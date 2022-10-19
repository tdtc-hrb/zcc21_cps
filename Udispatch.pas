unit Udispatch;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, ComCtrls, StdCtrls, StrUtils, Grids, DBGrids, Menus, DB, ADODB,
  Mask, DBCtrls, UGeneralADO, UfunLibA, IniFiles, ShellApi;

type
  Thread_update = class(TThread)
  private
    thread_flag1:integer;
    logpath2,reppath2:string;
    errorRepStr:WideString;
    function querySQLformula(tableNameStrA:WideString):Integer;
    function execStoredProcA(procNameStrA:WideString):Boolean;
    function turnTableA(tableNameStrA:WideString):Boolean;
    function expErrorReport(tableNameStrA,expNameStrA:wideString):WideString;
    { Private declarations }
  protected
    procedure Execute; override;

  public
    constructor Create(thread_flag:integer;reppath1,Logpath1:string);
  end;

type
  Tfrm_main = class(TForm)
    Panel1: TPanel;
    StatusBar1: TStatusBar;
    Panel2: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    Splitter1: TSplitter;
    Panel5: TPanel;
    Label1: TLabel;
    cmbox_kb: TComboBox;
    Panel6: TPanel;
    DBGrid2: TDBGrid;
    btn_print: TButton;
    btn_csv: TButton;
    PopupMenu1: TPopupMenu;
    N4: TMenuItem;
    N5: TMenuItem;
    N6: TMenuItem;
    N7: TMenuItem;
    ADODataSet1: TADODataSet;
    ADOConnection1: TADOConnection;
    DataSource1: TDataSource;
    ADODataSet2: TADODataSet;
    N8: TMenuItem;
    dispatchTemplate: TADODataSet;
    DataSource2: TDataSource;
    Popup2: TPopupMenu;
    N1: TMenuItem;
    addDispatch: TADOQuery;
    delDispatch: TADOQuery;
    judgmentStation: TDBEdit;
    add1del: TADOConnection;
    N2: TMenuItem;
    N9: TMenuItem;
    N10: TMenuItem;
    N11: TMenuItem;
    N12: TMenuItem;
    ADODataSet2total_weight1: TBCDField;
    ADODataSet2suttle1: TBCDField;
    ADODataSet2car_marque: TStringField;
    ADODataSet2car_number: TStringField;
    ADODataSet2carry_weight1: TBCDField;
    ADODataSet2self_weight1: TBCDField;
    ADODataSet2yk_weight: TBCDField;
    ADODataSet2breed: TStringField;
    ADODataSet2Pstation: TStringField;
    ADODataSet2past_date: TDateTimeField;
    ADODataSet2past_time: TStringField;
    ADODataSet2sn: TAutoIncField;
    dispatchTemplatesn: TAutoIncField;
    dispatchTemplatetotal_weight1: TBCDField;
    dispatchTemplatesuttle1: TBCDField;
    dispatchTemplatecar_marque: TStringField;
    dispatchTemplatecar_number: TStringField;
    dispatchTemplatecarry_weight1: TBCDField;
    dispatchTemplateself_weight1: TBCDField;
    dispatchTemplateyk_weight: TBCDField;
    dispatchTemplatebreed: TStringField;
    dispatchTemplatePstation: TStringField;
    dispatchTemplatepast_date: TDateTimeField;
    dispatchTemplatepast_time: TStringField;
    dispatchTemplatestation: TStringField;
    clock: TTimer;
    N3: TMenuItem;
    N13: TMenuItem;
    Timer1: TTimer;
    DBGrid1: TDBGrid;
    procedure N4Click(Sender: TObject);
    procedure N5Click(Sender: TObject);
    procedure N7Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure cmbox_kbChange(Sender: TObject);
    procedure btn_csvClick(Sender: TObject);
    procedure N8Click(Sender: TObject);
    procedure btn_printClick(Sender: TObject);
    procedure N1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure clockTimer(Sender: TObject);
    procedure N13Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private
    stationName:string;
    execpath:string;
    Logpath:string;
    reppath:string;
    csvPath:string;
    excpchar:pchar;
    stationcount,tempcount:integer;
    //
    h1:THandle;
    connectStr,colName1,tableName1,exportName1:WideString;
    colCount1:integer;
    { Private declarations }
  public
    tablename:string;
    stationINT:Integer;
    stationStrA:string;
    counINI:TIniFile;
    //2007.10.28
    stationAy:array [0..15]of string;
    SQLstatementStrA:WideString;
    function querySQLformulaF(tableNameStrA:WideString):Integer;
    { Public declarations }
  end;

type
  Tpro_saveFCN=procedure(saveFile1,CheckFilePath:WideString);stdcall;

var
  frm_main: Tfrm_main;

  saveFCNA:Tpro_saveFCN;
  //
  handlers:string;
  xbf:string;//xbf path
  connstr:string;
  
implementation
uses
Ulogin,u_about,Udatatotal,Ustation;

function readXBF(DimRecord: Integer;filename1:WideString):WideString;stdcall;
                external 'XBFGenerate.dll';

{$R *.dfm}

procedure Tfrm_main.N4Click(Sender: TObject);
begin
  frm_about:=Tfrm_about.Create(Application);
  frm_about.Update;
  frm_about.ShowModal;
end;

procedure Tfrm_main.N5Click(Sender: TObject);
begin
  frm_sa:=Tfrm_sa.Create(Application);
  frm_sa.Update;
  frm_sa.ShowModal;
end;

procedure Tfrm_main.N7Click(Sender: TObject);
begin
  frm_station:=Tfrm_station.Create(Application);
  frm_station.Update;
  frm_station.ShowModal;
end;

procedure Tfrm_main.FormShow(Sender: TObject);
var
  Int1:Integer;
  titleStrA:WideString;
begin
  //
  ADODataSet1.Close;
  ADODataSet1.CommandText:='select OperName from operator where OperID='+opertor;
  ADODataSet1.Open;

  StatusBar1.Panels[3].Text:='调度员:'+ADODataSet1.Fields[0].AsString;
  StatusBar1.Panels[4].Text:='登录时间：'+RightStr(DateTimeToStr(Time),8);

  //
  dispatchTemplate.Close;
  dispatchTemplate.CommandText:='select sn,total_weight1,suttle1,car_marque,'
                +'car_number,carry_weight1,self_weight1,yk_weight,breed,'
                +'Pstation,past_date,past_time,station from dispatchTemplate';
  dispatchTemplate.Open;
  //2007.10.28
  titleStrA:=counINI.ReadString('title','1','');
  if titleStrA='' then
        frm_main.Caption:=frm_main.Caption+'---unknow'
        else frm_main.Caption:=frm_main.Caption+'---'+titleStrA;
  //
  stationINT:=counINI.ReadInteger('stationcount','1',6);
  for Int1:=0 to stationINT-1 do
  begin
     stationAy[Int1]:=counINI.ReadString('stationname',IntToStr(Int1+1),'my1');
     stationStrA:=stationAy[Int1];
     cmbox_kb.Items.Add(stationStrA);
  end;
  
end;

procedure Tfrm_main.FormCreate(Sender: TObject);
var
  configini:string;
begin
  configini:=ExtractFilePath(ParamStr(0))+'CPSconfig.ini';
  counINI:=TIniFile.Create(configini);

  try
    ADOConnection1.Close;
    //ADOConnection1.ConnectionString:=readXBF(-1,xbf);
    ADOConnection1.ConnectionString:=connstr;
    ADOConnection1.Open;
    add1del.Close;
    //add1del.ConnectionString:=readXBF(-1,xbf);
    add1del.ConnectionString:=connstr;
    add1del.Open;
   Except
     Application.MessageBox('数据库位置不对！','提示',MB_OK+MB_ICONINFORMATION);
     Exit;
   end;

   //
   execpath:=ExtractFilePath(ParamStr(0));
   excpchar:=pchar(execpath);
   Logpath:=execpath+'log\';
   reppath:=counINI.ReadString('filePath','2','D:\receive');
end;

procedure Tfrm_main.cmbox_kbChange(Sender: TObject);
var
  strlist:TStringList;
  sq:string;
begin
  ADODataSet1.Close;
  ADODataSet1.CommandText:='select ArriveStation from arrivestation';
  ADODataSet1.Open;
  strlist:=TStringList.Create;
  while not ADODataSet1.Eof do
  begin
    sq:=ADODataSet1.Fields[0].AsString;
    strlist.Add(sq);
    ADODataSet1.Next;
  end;
  DBGrid1.Columns[9].PickList:=strlist;
  //
  
  case cmbox_kb.ItemIndex of
      0:
        begin
          tablename:='sx02';
        end;
      1:
        begin
          tablename:='tb01';
        end;
      2:
        begin
          tablename:='lt04';
        end;
      3:
        begin
          tablename:='tb01_2';
        end;
      4:
        begin
          tablename:='lt04_2';
        end;
      5:
        begin
          tablename:='sej_2';
        end;
      6:
        begin
          tablename:='sx01';
        end;
  end;
  //
  SQLstatementStrA:='select sn,total_weight1,suttle1,car_marque,'
                +'car_number,carry_weight1,self_weight1,yk_weight,breed,Pstation,'
                +'past_date,past_time from ';
  SQLstatementStrA:=SQLstatementStrA+tablename;
  ADODataSet2.Close;
  ADODataSet2.CommandText:=SQLstatementStrA;
  ADODataSet2.Open;

  stationName:=trim(cmbox_kb.Text);
  //
  stationcount:=ADODataSet2.RecordCount;
  StatusBar1.Panels[0].Text:=stationName+'检斤站共有'
                                                +IntToStr(stationcount)+'辆车';
end;

procedure Tfrm_main.btn_csvClick(Sender: TObject);
var
 loop1:integer;
 ConsistCount,ConsistCount1:integer;
 sqlstr5,sqlstr6,sqlstr7,sqlstr8,sqlstr9:string;
begin
  csvPath:=counINI.ReadString('filePath','1','d:\send');
  if RightStr(csvPath,1)<>'\' then csvPath:=csvPath+'\';
  if not DirectoryExists(csvPath)then
  begin
    MkDir(csvPath);
  end;
  //退出的几种情况
  if dispatchTemplate.RecordCount=0 then Exit;
  ConsistCount:=counINI.ReadInteger('cumulateConsist','2',2);
  ConsistCount1:=counINI.ReadInteger('cumulateConsist','3',2);
  if ConsistCount<>ConsistCount1 then Exit;

  //输出CSV文件
  connectStr:=ADOConnection1.ConnectionString;
  tableName1:='dispatchTemplate';
  colName1:='total_weight1,suttle1,car_marque,car_number,carry_weight1,'
        +'self_weight1,yk_weight,breed,station,Pstation,past_date,past_time';
  colCount1:=11;
  exportName1:=csvPath+'datasb.txt';
  if generalCSV(connectStr,colName1,tableName1,exportName1,colCount1)then
  begin
    h1:=0;
    try
    h1:=LoadLibrary('FCN.dll');

    if h1<>0 then
      @saveFCNA:=GetprocAddress(h1,'saveFCN');
    if (@saveFCNA<>nil)then
      saveFCNA(csvPath+'datasb.fcn',exportName1);
   finally
     FreeLibrary(h1);
   end;
  end
  else
  begin
    Exit;
  end;

  StatusBar1.Panels[5].Text:='数据上报成功';
  //把dispatchTemplate表的数据添加到TotalTable表中

  for loop1:=0 to dispatchTemplate.RecordCount-1 do
  begin
    //

    sqlstr5:='insert into TotalTable';
    sqlstr6:=' (total_weight1,suttle1,car_marque, car_number,carry_weight1,'
                +'self_weight1,yk_weight,breed,Pstation,past_date,past_time,'
                +'cumulateConsist,station,OperID)';
    sqlstr7:=' values('+dispatchTemplatetotal_weight1.Text
                +','+dispatchTemplatesuttle1.Text
                +','+''''+dispatchTemplatecar_marque.Text+''''
                +','+''''+dispatchTemplatecar_number.Text+''''
                +','+dispatchTemplatecarry_weight1.Text
                +','+dispatchTemplateself_weight1.Text
                +','+dispatchTemplateyk_weight.Text; 
    sqlstr8:=','+''''+dispatchTemplatebreed.Text+''''
                +','+''''+dispatchTemplatePstation.Text+''''
                +','+''''+dispatchTemplatepast_date.Text+''''
                +','+''''+dispatchTemplatepast_time.Text+'''';
    sqlstr9:=','+IntToStr(ConsistCount)+','+''''+judgmentStation.Text+''''
                +','+''''+opertor+'''';
    //
    try
      add1del.BeginTrans;
      delDispatch.Close;
      delDispatch.SQL.Clear;
      delDispatch.SQL.Text:=sqlstr5+sqlstr6+sqlstr7+sqlstr8+sqlstr9+')';
      delDispatch.ExecSQL;
      add1del.CommitTrans;
      //dispatchTemplate.Delete;
      addDispatch.Close;
      addDispatch.SQL.Clear;
      addDispatch.SQL.Text:='delete from dispatchTemplate where sn='
                                +IntToStr(dispatchTemplatesn.Value);
      addDispatch.ExecSQL;

      dispatchTemplate.Close;
      dispatchTemplate.Open;
    except
      add1del.RollbackTrans;
      counINI.WriteString('RunTime','2',DateToStr(now));
      StatusBar1.Panels[5].Text:='数据上报失败';
      Exit;
    end;

  end;//for end;
  counINI.WriteInteger('cumulateConsist','2',ConsistCount+1);//增加计数
  counINI.WriteInteger('cumulateConsist','3',ConsistCount+1);
end;

procedure Tfrm_main.N8Click(Sender: TObject);
var
  sqlstr1,sqlstr2:string;
  carX,carN,breed2,dz,time2:string;
  TW:real;
begin
  //
  if DataSource1.DataSet.IsEmpty then Exit;
  carX:=ADODataSet2car_marque.Value;
  carN:=ADODataSet2car_number.Value;
  breed2:=ADODataSet2breed.Value;
  dz:=ADODataSet2Pstation.Value;
  time2:=ADODataSet2past_time.Value;
  //
  TW:=ADODataSet2total_weight1.Value;
  sqlstr1:='insert into dispatchTemplate (total_weight1,suttle1,car_marque,'
                +'car_number,carry_weight1,self_weight1,yk_weight,breed,Pstation,'
                +'past_date,past_time,station)';
  sqlstr2:=' values('+''+FloatToStr(TW)+''+','+FloatToStr(ADODataSet2suttle1.Value)
                +','+''''+carX+''''+','+''''+carN+''''
                +','+FloatToStr(ADODataSet2carry_weight1.Value)
                +','+FloatToStr(ADODataSet2self_weight1.Value)
                +','+''+FloatToStr(ADODataSet2yk_weight.Value)+''
                +','+''''+breed2+''''+','+''''+DZ+'''';
  try
    addDispatch.Close;
    addDispatch.SQL.Clear;
    addDispatch.SQL.Text:=sqlstr1+sqlstr2
                +','+''''+DateToStr(ADODataSet2past_date.Value)+''''
                +','+''''+time2+''''+','+''''+stationName+''''+')';
    addDispatch.ExecSQL;
    delDispatch.Close;
    delDispatch.SQL.Clear;
    delDispatch.SQL.Text:='delete from '+tablename+' where sn='
                                        +IntToStr(ADODataSet2sn.Value);
    delDispatch.ExecSQL;

    dispatchTemplate.Close;
    dispatchTemplate.Open;
    //tempcount
    tempcount:=dispatchTemplate.RecordCount;
    StatusBar1.Panels[1].Text:='现在共有'+IntToStr(tempcount)+'辆车编入';
    ADODataSet2.Close;
    ADODataSet2.Open;
    //stationcount
    stationcount:=ADODataSet2.RecordCount;
    StatusBar1.Panels[0].Text:=stationName+'检斤站共有'
                                +IntToStr(stationcount)+'辆车';
  except
    Application.MessageBox('添加编车组失败！','提示',MB_OK);
    Exit;
  end;

end;

procedure Tfrm_main.btn_printClick(Sender: TObject);
begin
  //
  if GridPrintA(DataSource2.DataSet,DBGrid2) then
        Application.MessageBox('打印完成','打印',32);
end;

procedure Tfrm_main.N1Click(Sender: TObject);
var
  sqlstr3,sqlstr4,sqlstr5:string;
  carX,carN,breed2,dz,time2:string;
  TW:real;
begin
  //
  if dispatchTemplate.RecordCount=0 then Exit;

  if tablename='' then
  begin
    Exit;
  end;

  //
  carX:=dispatchTemplatecar_marque.Value;
  carN:=dispatchTemplatecar_number.Value;
  breed2:=dispatchTemplatebreed.Value;
  dz:=dispatchTemplatePstation.Value;
  time2:=dispatchTemplatepast_time.Value;
  //
  TW:=dispatchTemplatetotal_weight1.Value;

  sqlstr3:='insert into '+tablename;
  sqlstr4:=' (total_weight1,suttle1,car_marque, car_number,carry_weight1,'
        +'self_weight1,yk_weight,breed,Pstation,past_date,past_time)';
  sqlstr5:=' values('+''+FloatToStr(TW)+''
        +','+FloatToStr(dispatchTemplatesuttle1.Value)
        +','+''''+carX+''''+','+''''+carN+''''
        +','+FloatToStr(dispatchTemplatecarry_weight1.Value)
        +','+FloatToStr(dispatchTemplateself_weight1.Value)
        +','+''+FloatToStr(dispatchTemplateyk_weight.Value)+''
        +','+''''+breed2+''''+','+''''+DZ+'''';
  //判断站点是否是添加的站点
  if judgmentStation.Text<>stationName then
  begin
    Exit;
  end;
  try
    addDispatch.Close;
    addDispatch.SQL.Clear;
    addDispatch.SQL.Text:=sqlstr3+sqlstr4+sqlstr5
                +','+''''+DateToStr(dispatchTemplatepast_date.Value)+''''
                +','+''''+time2+''''+')';
    addDispatch.ExecSQL;
    delDispatch.Close;
    delDispatch.SQL.Clear;
    delDispatch.SQL.Text:='delete from dispatchTemplate where sn='
                                +IntToStr(dispatchTemplatesn.Value);
    delDispatch.ExecSQL;

    dispatchTemplate.Close;
    dispatchTemplate.Open;
    //tempcount
    tempcount:=dispatchTemplate.RecordCount;
    StatusBar1.Panels[1].Text:='现在共有'+IntToStr(tempcount)+'辆车编入';
    
    ADODataSet2.Close;
    ADODataSet2.Open;
    //stationcount
    stationcount:=ADODataSet2.RecordCount;
    StatusBar1.Panels[0].Text:=stationName+'检斤站共有'
                                +IntToStr(stationcount)+'辆车';
    
    Exit;
  except
    Application.MessageBox('删除编车组失败！','提示',MB_OK);
    Exit;
  end;
end;

procedure Tfrm_main.clockTimer(Sender: TObject);
begin
  StatusBar1.Panels[2].Text:='现在时间：'+RightStr(DateTimeToStr(Now),8);
end;

procedure Tfrm_main.N13Click(Sender: TObject);
var
  opertype:string;
  conentSTR:string;
begin
  opertype:='DEL OPER';
  conentSTR:=ADODataSet2total_weight1.AsString+','+ADODataSet2suttle1.AsString+','
             +ADODataSet2car_marque.AsString+','+ADODataSet2car_number.AsString+','
             +ADODataSet2carry_weight1.AsString+','+ADODataSet2self_weight1.AsString+','
             +ADODataSet2yk_weight.AsString+','+ADODataSet2breed.AsString+','
             +ADODataSet2past_date.AsString+','+ADODataSet2past_time.AsString;
  //把数据添加到日志表中
  addDispatch.Close;
  addDispatch.SQL.Clear;
  addDispatch.SQL.Text:='insert into zcc_log values('+''''+opertor+''''
                        +','+''''+DateTimeToStr(Now)+''''+','
                        +''''+conentSTR+''''+','+''''+opertype+''''+')';
  addDispatch.ExecSQL;
  //删除数据
  delDispatch.Close;
  delDispatch.SQL.Clear;
  delDispatch.SQL.Text:='delete from '+tablename+' where sn='
                                +IntToStr(ADODataSet2sn.Value);
  delDispatch.ExecSQL;

  ADODataSet2.Close;
  ADODataSet2.Open;
  stationcount:=ADODataSet2.RecordCount;
  StatusBar1.Panels[0].Text:=stationName+'检斤站共有'
                                                +IntToStr(stationcount)+'辆车';

end;

procedure Tfrm_main.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  counINI.Destroy;
  delDispatch.Close;
  delDispatch.SQL.Clear;
  delDispatch.SQL.Text:='update operator set preserve1=0 where OperID='+opertor;
  delDispatch.ExecSQL;
end;
//
function Tfrm_main.querySQLformulaF(tableNameStrA:WideString):Integer;
var
  sqlStr2:WideString;
  checkDataA:TADOQuery;
begin
  sqlStr2:='select * from '+tableNameStrA;
  //
  checkDataA:=TADOQuery.Create(nil);
  checkDataA.ConnectionString:=connstr;
  //
  checkDataA.Close;
  checkDataA.SQL.Clear;
  checkDataA.SQL.Text:=sqlStr2;
  checkDataA.Open;

  Result:=checkDataA.RecordCount;
  FreeAndNil(checkDataA);
end;
//2007.10.28
function Thread_update.querySQLformula(tableNameStrA:WideString):Integer;
var
  sqlStr2:WideString;
  checkDataA:TADOQuery;
begin
  sqlStr2:='select * from '+tableNameStrA;
  //
  checkDataA:=TADOQuery.Create(nil);
  checkDataA.ConnectionString:=connstr;
  //
  checkDataA.Close;
  checkDataA.SQL.Clear;
  checkDataA.SQL.Text:=sqlStr2;
  checkDataA.Open;

  Result:=checkDataA.RecordCount;
  FreeAndNil(checkDataA);
end;

function Thread_update.execStoredProcA(procNameStrA:WideString):Boolean;
var
  convertSpA:TADOStoredProc;
begin
  //
  convertSpA:=TADOStoredProc.Create(nil);
  convertSpA.ConnectionString:=connstr;
  //
  convertSpA.Close;
  convertSpA.Parameters.Clear;
  convertSpA.ProcedureName:=procNameStrA;
  convertSpA.ExecProc;

  Result:=True;
end;

function Thread_update.turnTableA(tableNameStrA:WideString):Boolean;
var
  sqlStr1:WideString;
  checkDataA:TADOQuery;
begin
  sqlStr1:='TRUNCATE TABLE '+tableNameStrA;
  //
  checkDataA:=TADOQuery.Create(nil);
  checkDataA.ConnectionString:=connstr;
  //
  checkDataA.Close;
  checkDataA.SQL.Clear;
  checkDataA.SQL.Add(sqlStr1);
  checkDataA.ExecSQL;

  Result:=True;
end;

function Thread_update.expErrorReport(tableNameStrA,expNameStrA:wideString):WideString;
var
  connectStr,colName1,exportName1:WideString;
  colCount1:Integer;
begin
  Randomize;
 //输出CSV文件
  connectStr:=connStr;
  colName1:='Col001,Col002,Col003,Col004,Col005,'
        +'Col006,Col007,Col008,Col009,Col010,Col011';
  colCount1:=10;
  exportName1:=logpath2+DateToStr(Now)+'_'+IntToStr(random(99))+expNameStrA;
  generalCSV(connectStr,colName1,tableNameStrA,exportName1,colCount1);

  Result:=exportName1;
end;
//thread process
constructor Thread_update.create(thread_flag:integer;reppath1,Logpath1:string);
begin
  inherited Create(False);
  reppath2:=reppath1;
  logpath2:=Logpath1;
  thread_flag1:=thread_flag;
end;

procedure Thread_update.Execute;
begin
  //
  case thread_flag1 of
    //thread1
    1:
    begin
      if querySQLformula('sxj6566572')=0 then Exit;
    
      try
        execStoredProcA('update_sxj');
        //清空文本表12
        turnTableA('sxj6566572');
      except
        //从文本表读取数据，出错导出报文
        errorRepStr:= expErrorReport('sxj6566572','sx2.log');
        frm_main.StatusBar1.Panels[5].Text:='报文错误:"sxj1"('+errorRepStr+')';
        //清空文本表12
        turnTableA('sxj6566572');
        exit;
      end;
      
    end;
    //thread2
    2:
    begin
      if querySQLformula('ltk6565734')=0 then Exit;
      try
        execStoredProcA('update_ltk');
        //清空文本表22
        turnTableA('ltk6565734');
      except
        //从文本表读取数据，出错导出报文
        errorRepStr:=expErrorReport('ltk6565734','lt2.log');
        frm_main.StatusBar1.Panels[5].Text:='报文错误:"ltk1"('+errorRepStr+')';
        //清空文本表22
        turnTableA('ltk6565734');
        exit;
      end;
    end;
    //thread3
    3:
    begin
      if querySQLformula('tbk6563921')=0 then Exit;

      try
        execStoredProcA('update_tbk');
        //清空文本表32
        turnTableA('tbk6563921');
      except
        //从文本表读取数据，出错导出报文
        errorRepStr:=expErrorReport('tbk6563921','tb2.log');
        frm_main.StatusBar1.Panels[5].Text:='报文错误:"tb1"('+errorRepStr+')';
        //清空文本表32
        turnTableA('tbk6563921');
        exit;
      end;

    end;

  //第二次项目增加设备点（2006.8.14）
  //铁北2为station04
  //露天矿2为station05
  //十二井为station06

    //thread4- station04
    4:
    begin
      if querySQLformula('zlnr04')=0 then Exit;
      try
        execStoredProcA('update_station04');
        //清空文本表42
        turnTableA('zlnr04');
      except
        //从文本表读取数据，出错导出报文
        errorRepStr:=expErrorReport('zlnr04','st4.log');
        frm_main.StatusBar1.Panels[5].Text:='报文错误:"st4"('+errorRepStr+')';
        //清空文本表42
        turnTableA('zlnr04');
        exit;
      end;

    end;

   //thread5- station05
    5:
    begin
      if querySQLformula('zlnr05')=0 then Exit;

      try
        execStoredProcA('update_station05');
        //清空文本表52
        turnTableA('zlnr05');
      except
        //从文本表读取数据，出错导出报文
        errorRepStr:=expErrorReport('zlnr05','st5.log');
        frm_main.StatusBar1.Panels[5].Text:='报文错误:"st5"('+errorRepStr+')';
        //清空文本表52
        turnTableA('zlnr05');
        exit;
      end;

    end; 

    //thread6- station06
    6:
    begin
      if querySQLformula('zlnr06')=0 then Exit;

      try
        execStoredProcA('update_station06');
        //清空文本表62
        turnTableA('zlnr06');
      except
        //从文本表读取数据，出错导出报文
        errorRepStr:=expErrorReport('zlnr06','st6.log');
        frm_main.StatusBar1.Panels[5].Text:='报文错误:"st6"('+errorRepStr+')';
        //清空文本表62
        turnTableA('zlnr06');
        exit;
      end;
    end;

    //thread7- station07
    7:
    begin
      if querySQLformula('zlnr07')=0 then Exit;

      try
        execStoredProcA('update_station07');
        //清空文本表72
        turnTableA('zlnr07');
      except
        //从文本表读取数据，出错导出报文
        errorRepStr:=expErrorReport('zlnr07','st7.log');
        frm_main.StatusBar1.Panels[5].Text:='报文错误:"st7"('+errorRepStr+')';
        //清空文本表72
        turnTableA('zlnr07');
        exit;
      end;

    end;
  end;//case end;
end;

//thread processor
procedure Tfrm_main.Timer1Timer(Sender: TObject);
begin
  if querySQLformulaF('sxj6566572')<>0 then
  begin
    Thread_update.Create(1,reppath,logpath);
  end;

  if querySQLformulaF('ltk6565734')<>0 then
  begin
    Thread_update.Create(2,reppath,logpath);
  end;
  //tbk6563921
  if querySQLformulaF('tbk6563921')<>0 then
  begin
    Thread_update.Create(3,reppath,logpath);
  end;
  //station04
  if querySQLformulaF('zlnr04')<>0 then
  begin
    Thread_update.Create(4,reppath,logpath);
  end;
  //station05
  if querySQLformulaF('zlnr05')<>0 then
  begin
    Thread_update.Create(5,reppath,logpath);
  end;
  //station06
  if querySQLformulaF('zlnr06')<>0 then
  begin
    Thread_update.Create(6,reppath,logpath);
  end;
  //station07---sx1
  if querySQLformulaF('zlnr07')<>0 then
  begin
    Thread_update.Create(7,reppath,logpath);
  end;
end;

end.
