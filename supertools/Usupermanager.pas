unit Usupermanager;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, ComCtrls, Grids, DBGrids, StdCtrls, DB, ADODB, jpeg,
  UreadReg, IniFiles;

type
  Tfrm_supermanager = class(TForm)
    Panel1: TPanel;
    DBGrid1: TDBGrid;
    StatusBar1: TStatusBar;
    Panel2: TPanel;
    Button1: TButton;
    Button2: TButton;
    ADODataSet1: TADODataSet;
    DataSource1: TDataSource;
    clearTAG: TADOQuery;
    ADOConnection1: TADOConnection;
    Panel3: TPanel;
    Image1: TImage;
    btnData: TButton;
    btnFile: TButton;
    procedure FormShow(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure btnDataClick(Sender: TObject);
    procedure btnFileClick(Sender: TObject);
  private
    count1:integer;
    { Private declarations }
  public
    xbf:string;
    inipath:string;
    myIni:TIniFile;
    { Public declarations }
  end;

var
  frm_supermanager: Tfrm_supermanager;

  handlers:string;
implementation
  
function readXBF(DimRecord: Integer;filename1:WideString):WideString;stdcall;external 'XBFGenerate.dll';

{$R *.dfm}

procedure Tfrm_supermanager.FormShow(Sender: TObject);
begin
  ADODataSet1.Close;
  ADODataSet1.Open;
  count1:=myIni.ReadInteger('cumulateConsist','1',43);
  //
  try
    clearTAG.Close;
    clearTAG.SQL.Clear;
    clearTAG.SQL.Text:='update operator set preserve1=0 where preserve1=1';
    clearTAG.ExecSQL;
  except

  end;
end;

procedure Tfrm_supermanager.Button1Click(Sender: TObject);
begin
  DBGrid1.ReadOnly:=False;
  ADODataSet1.Edit;
  ADODataSet1.Append;
  Button2.Enabled:=True;
end;

procedure Tfrm_supermanager.Button2Click(Sender: TObject);
begin
  try
    ADODataSet1.Post;
    DBGrid1.ReadOnly:=True;
    count1:=count1+1;
    myIni.WriteInteger('cumulateConsist','1',count1);
    if count1=911 then Panel3.Visible:=True;
    Application.MessageBox('保存成功！','提示',MB_OK); 
  except
    Application.MessageBox('保存失败！','提示',MB_OK);
    Exit;
  end;
end;

procedure Tfrm_supermanager.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  myIni.Destroy;
  Application.Terminate;
end;

procedure Tfrm_supermanager.FormCreate(Sender: TObject);
var
  xbftemp:string;
begin
  inipath:=ExtractFilePath(ParamStr(0))+'CPSconfig.ini';
  myIni:=TIniFile.Create(inipath);
  xbftemp:=myIni.ReadString('filePath','3','zlnr1.xbf');
  xbf:=ExtractFilePath(ParamStr(0))+xbftemp;

  ADOConnection1.Close;
  ADOConnection1.ConnectionString:=readREG(xbf);
  ADOConnection1.Open;
end;

procedure Tfrm_supermanager.btnDataClick(Sender: TObject);
begin
  clearTAG.Close;
  clearTAG.SQL.Clear;
  clearTAG.SQL.Text:='truncate table sxj6566572';
  clearTAG.ExecSQL;

  clearTAG.Close;
  clearTAG.SQL.Clear;
  clearTAG.SQL.Text:='truncate table ltk6565734';
  clearTAG.ExecSQL;

  clearTAG.Close;
  clearTAG.SQL.Clear;
  clearTAG.SQL.Text:='truncate table tbk6563921';
  clearTAG.ExecSQL;
  Application.MessageBox('数据初始化完成！','提示',MB_OK+MB_ICONINFORMATION);
  Exit;
end;

procedure Tfrm_supermanager.btnFileClick(Sender: TObject);
begin
  myIni.WriteString('filePath','1','d:\send');
  myIni.WriteString('filePath','2','D:\receive');
  myIni.WriteInteger('cumulateConsist','2',1);
  myIni.WriteInteger('cumulateConsist','3',1);
  Application.MessageBox('文件初始化完成！','提示',MB_OK+MB_ICONINFORMATION);
  Exit;
end;

end.
