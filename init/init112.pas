unit init112;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, ADODB, StdCtrls, Gauges, UreadReg;

type
  Tfrm_init = class(TForm)
    ADOConnection_init: TADOConnection;
    Gauge1: TGauge;
    btn_start: TButton;
    btnPrepared: TButton;
    Label1: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    edt_dbpass: TEdit;
    edt_dbusername: TEdit;
    edt_srv: TEdit;
    ADOCommand1: TADOCommand;
    ADOStoredProc1: TADOStoredProc;
    procedure FormCreate(Sender: TObject);
    procedure btn_startClick(Sender: TObject);
    procedure btnPreparedClick(Sender: TObject);
  private
    { Private declarations }
  public
    xbf:WideString;
    { Public declarations }
  end;

//
  type
  TreadXBF=function(DimRecord: Integer;filename1:WideString):WideString;stdcall;
  //

var
  frm_init: Tfrm_init;
  connstring:TreadXBF;
implementation

{$R *.dfm}

function readXBF(DimRecord: Integer;filename1:WideString):WideString;stdcall;
                                                        external 'XBFGenerate.dll';

procedure Tfrm_init.FormCreate(Sender: TObject);
begin
  frm_init.Caption:='初始化程序';
  xbf:=ExtractFilePath(ParamStr(0))+'zlnr1.xbf';
end;

procedure Tfrm_init.btn_startClick(Sender: TObject);
//var
//  h1:THandle;
begin
  if btnPrepared.Enabled=false then
  begin
    Exit;
  end;
  {try
     h1:=0;
     try
      h1:=LoadLibrary('XBFGenerate.dll');

      if h1<>0 then
        @connstring:=GetprocAddress(h1,'readXBF');
      if (@connstring<>nil)then
          ADOConnection_init.Close;
          ADOConnection_init.ConnectionString:=connstring(-1,xbf);
          ADOConnection_init.Open;
     finally
       FreeLibrary(h1);
     end;
  except
    Application.MessageBox('配置错误，请重新填写各个值！','提示',MB_OK);
    Exit;
  end;}
  //2006.8.17使用注册表密码
  try
    ADOConnection_init.Close;
    ADOConnection_init.ConnectionString:=readREG(xbf);
    ADOConnection_init.Open;
  except
    Application.MessageBox('配置错误，请检查链接文件！','提示',MB_OK);
    Exit;
  end;


  Gauge1.Visible:=True;
  try
    Sleep(2000);
    Gauge1.Progress:=30;
    Sleep(2000);
    Gauge1.Progress:=60;
    Sleep(2000);
    Gauge1.Progress:=100;
    //
    Application.MessageBox('初始化完成！','提示',MB_OK);
    btnPrepared.Enabled:=False;
  except

  end;
end;

procedure Tfrm_init.btnPreparedClick(Sender: TObject);
var
  customDS,customUserID,customPWD:WideString;
  lenOldPWD,lenNewPWD,lenUserName:Integer;
  regInfoPWD:WideString;
  XBFuserID:WideString;
  XBFuIDlen:integer;
  XBFinfo:WideString;
  //定位字符串中user ID的位置
  leftLen,rightLen:Integer;
begin
  //2007.1.5对SQL2000进行权限操作
  customPWD:=trim(edt_dbpass.Text);
  customDS:=Trim(edt_srv.Text);
  customUserID:=Trim(edt_dbusername.Text);
  XBFinfo:=readREG(xbf);
  regInfoPWD:=childstr2+childstr5+childstr6+childstr1+childstr3+childstr4;

  lenOldPWD:=length(customPWD);
  lenNewPWD:=length(regInfoPWD);
  lenUserName:=length(customUserID);
  try
    ADOConnection_init.Close;
    ADOConnection_init.ConnectionString:='Provider=SQLOLEDB.1'
                                        +';Password='+customPWD
                                        +';Persist Security Info=True'
                                        +';User ID='+customUserID
                                        +';Initial Catalog=pubs'
                                        +';Data Source='+customDS;
    ADOConnection_init.Open;
    //更改sa密码。(新密码为注册表密码)
    ADOStoredProc1.Close;
    ADOStoredProc1.ProcedureName:='sp_password';
    ADOStoredProc1.Parameters.Clear;
    ADOStoredProc1.Parameters.CreateParameter('@old',ftWideString,pdInput,lenOldPWD,customPWD);
    ADOStoredProc1.Parameters.CreateParameter('@new',ftWideString,pdInput,lenNewPWD,regInfoPWD);
    ADOStoredProc1.Parameters.CreateParameter('@loginame',ftWideString,pdInput,lenUserName,customUserID);

    ADOStoredProc1.ExecProc;
  except
    Application.MessageBox('管理员密码错误，请重新填写密码！','提示',MB_OK);
    Exit;
  end;
  //2006.1.6建立新用户和新密码（为注册表密码）
  //xbf文件中的用户即为新用户
  leftLen:=pos('ID=',XBFinfo);
  rightLen:=pos(';I',XBFinfo);

  XBFuserID:=copy(XBFinfo,leftLen+3,rightLen-leftLen-3);
  XBFuIDlen:=length(XBFuserID);
  //删除用户  
  try
    ADOStoredProc1.Close;
    ADOStoredProc1.ProcedureName:='sp_droplogin';
    ADOStoredProc1.Parameters.Clear;
    ADOStoredProc1.Parameters.CreateParameter('@loginame',ftWideString,pdInput,XBFuIDlen,XBFuserID);
    ADOStoredProc1.ExecProc;
  except

  end;
  //建立新用户
  try
    ADOStoredProc1.Close;
    ADOStoredProc1.ProcedureName:='sp_addlogin';
    ADOStoredProc1.Parameters.Clear;
    ADOStoredProc1.Parameters.CreateParameter('@loginame',ftWideString,pdInput,XBFuIDlen,XBFuserID);
    ADOStoredProc1.Parameters.CreateParameter('@passwd',ftWideString,pdInput,lenNewPWD,regInfoPWD);
    ADOStoredProc1.ExecProc;
  except
    Application.MessageBox('配置数据库错误，请中止相关管理员操作！','提示',MB_OK);
    Exit;
  end;
  //赋予新用户权限(默认权限为sa)
  try
    //服务器角色授权
    ADOStoredProc1.Close;
    ADOStoredProc1.ProcedureName:='sp_addsrvrolemember';
    ADOStoredProc1.Parameters.CreateParameter('@loginame',ftWideString,pdInput,XBFuIDlen,XBFuserID);
    ADOStoredProc1.Parameters.CreateParameter('@rolename',ftWideString,pdInput,8,'sysadmin');
    ADOStoredProc1.ExecProc;
    //数据库访问授权1步
    //(此时拥有"public"数据库角色)
    ADOStoredProc1.Close;
    ADOStoredProc1.ProcedureName:='sp_grantdbaccess';
    ADOStoredProc1.Parameters.CreateParameter('@loginame',ftWideString,pdInput,XBFuIDlen,XBFuserID);
    ADOStoredProc1.Parameters.CreateParameter('@name_in_db',ftWideString,pdInput,XBFuIDlen,XBFuserID);
    ADOStoredProc1.ExecProc;
    //数据库访问授权2步
    //(此时拥有"public"和"db_owner"两个数据库角色)
    ADOStoredProc1.Close;
    ADOStoredProc1.ProcedureName:='sp_addrolemember';
    ADOStoredProc1.Parameters.CreateParameter('@rolename',ftWideString,pdInput,8,'db_owner');
    ADOStoredProc1.Parameters.CreateParameter('@membername',ftWideString,pdInput,XBFuIDlen,XBFuserID);
    ADOStoredProc1.ExecProc;
  except

  end;

  //拒绝windows组对SQL的访问
  try
    ADOStoredProc1.Close;
    ADOStoredProc1.ProcedureName:='sp_denylogin';
    ADOStoredProc1.Parameters.Clear;
    ADOStoredProc1.Parameters.CreateParameter('@loginame',ftWideString,pdInput,22,'BUILTIN\Administrators');
    ADOStoredProc1.ExecProc;
  except

  end;
  //
  btn_start.Enabled:=True;
  Application.MessageBox('预处理完成！','提示',MB_OK);
end;


end.
