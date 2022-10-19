//****************************************************************************//
//****************************************************************************//
//**********This Unit For 2 Develop Use ZLNR**********************************//
//**********Date:2007.05.06***************************************************//
//**********Developer:XiaoBin*************************************************//
//**********Compant:Veic******************************************************//
//**********Purpose:CPS System Table Create***********************************//
//****************************************************************************//

unit init112;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, ADODB, StdCtrls, Gauges, UreadReg, ExtCtrls;

type
  Tfrm_init = class(TForm)
    ADOConnection_init: TADOConnection;
    btn_star: TButton;
    btn_stop: TButton;
    ADOCommand1: TADOCommand;
    AdataSet_query: TADODataSet;
    Panel1: TPanel;
    Gauge1: TGauge;
    procedure FormCreate(Sender: TObject);
    procedure btn_starClick(Sender: TObject);
    procedure btn_stopClick(Sender: TObject);
  private
    t1i,t2i,t3i,t4i,t5i:Integer;    //system use table
    s1i,s2i,s3i,s4i,s5i,s6i,s7i:integer;//service use table
    { Private declarations }
  public
    xbf:WideString;
    function queryRec(tableNameWstrA,flagWstrA:WideString):Integer;
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

function readXBF(DimRecord: Integer;filename1:WideString):WideString;stdcall;external 'XBFGenerate.dll';

procedure Tfrm_init.FormCreate(Sender: TObject);
begin
  frm_init.Caption:='初始化程序';
  xbf:=ExtractFilePath(ParamStr(0))+'zlnr1.xbf';
end;

procedure Tfrm_init.btn_starClick(Sender: TObject);
//var
//  h1:THandle;
begin
  if btn_stop.Enabled=false then
  begin
    Exit;
  end;
  //2006.8.17注释
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
  //2006.8.17注释
  try
    ADOConnection_init.Close;
    ADOConnection_init.ConnectionString:=readREG(xbf);
    ADOConnection_init.Open;
  except
    Application.MessageBox('配置错误，请重新填写各个值！','提示',MB_OK);
    Exit;
  end;

  //
  Gauge1.Visible:=True;
  //system use table
  try
    if t1i<>1 then
    begin
      ADOCommand1.CommandText:='CREATE TABLE [dbo].[arrivestation] ('+#13+
                          '[StationID] [int] IDENTITY (1001, 1) NOT NULL ,'+#13+
                          '[Jan] [varchar] (30) COLLATE Chinese_PRC_CI_AS NULL ,'+#13+
                          '[ArriveStation] [varchar] (30) COLLATE Chinese_PRC_CI_AS NULL'+#13+
                          ') ON [PRIMARY]';
                              //'constraint PK_sx02'+#13+//联合主键
                              //'primary key(total_weight1, car_number)) ON [PRIMARY]';
                            
      ADOCommand1.Execute;
    end;
    Gauge1.Progress:=7;
    //
    if t2i<>1 then
    begin
      ADOCommand1.CommandText:='CREATE TABLE [dbo].[dispatchTemplate] ('+#13+
                          '[total_weight1] [numeric](9, 3) NULL ,'+#13+
                          '[suttle1] [numeric](9, 3) NULL ,'+#13+
                          '[car_marque] [varchar] (25) COLLATE Chinese_PRC_CI_AS NULL ,'+#13+
                          '[car_number] [varchar] (25) COLLATE Chinese_PRC_CI_AS NULL ,'+#13+
                          '[carry_weight1] [numeric](9, 3) NULL ,'+#13+
                          '[self_weight1] [numeric](9, 3) NULL ,'+#13+
                          '[yk_weight] [numeric](9, 3) NULL ,'+#13+
                          '[breed] [varchar] (25) COLLATE Chinese_PRC_CI_AS NULL ,'+#13+
                          '[Pstation] [varchar] (25) COLLATE Chinese_PRC_CI_AS NULL ,'+#13+
                          '[past_date] [datetime] NULL ,'+#13+
                          '[past_time] [varchar] (25) COLLATE Chinese_PRC_CI_AS NULL ,'+#13+
                          '[consist] [int] NULL ,'+#13+
                          '[station] [varchar] (25) COLLATE Chinese_PRC_CI_AS NULL ,'+#13+
                          '[sn] [int] IDENTITY (1, 1) NOT FOR REPLICATION  NOT NULL'+#13+
                          ') ON [PRIMARY]';
                                 //'constraint PK_lt04'+#13+//联合主键
                                 //'primary key(total_weight1, car_number)) ON [PRIMARY]';
      ADOCommand1.Execute;
    end;
    
    Gauge1.Progress:=14;
    //
    if t3i<>1 then
    begin
      ADOCommand1.CommandText:='CREATE TABLE [dbo].[operator] ('+#13+
                          '[OperID] [int] IDENTITY (1001, 1) NOT NULL ,'+#13+
                          '[OperName] [varchar] (30) COLLATE Chinese_PRC_CI_AS NULL ,'+#13+
                          '[OperPassWord] [varchar] (30) COLLATE Chinese_PRC_CI_AS NULL ,'+#13+
                          '[preserve1] [bit] NULL ,'+#13+
                          '[OperMemo] [varchar] (50) COLLATE Chinese_PRC_CI_AS NULL'+#13+
                          ') ON [PRIMARY]';
                                //'constraint PK_tb01'+#13+//联合主键
                                //'primary key(total_weight1, car_number)) ON [PRIMARY]';
      ADOCommand1.Execute;
    end;
    Gauge1.Progress:=21;
    //
    if t4i<>1 then
    begin
      ADOCommand1.CommandText:='CREATE TABLE [dbo].[TotalTable] ('+#13+
	                '[total_weight1] [numeric](9, 3) NULL ,'+#13+
	                '[suttle1] [numeric](9, 3) NULL ,'+#13+
                        '[car_marque] [varchar] (25) COLLATE Chinese_PRC_CI_AS NULL ,'+#13+
	                '[car_number] [varchar] (25) COLLATE Chinese_PRC_CI_AS NULL ,'+#13+
	                '[carry_weight1] [numeric](9, 3) NULL ,'+#13+
	                '[self_weight1] [numeric](9, 3) NULL ,'+#13+
	                '[yk_weight] [numeric](9, 3) NULL ,'+#13+
	                '[breed] [varchar] (25) COLLATE Chinese_PRC_CI_AS NULL ,'+#13+
	                '[Pstation] [varchar] (25) COLLATE Chinese_PRC_CI_AS NULL ,'+#13+
	                '[past_date] [datetime] NULL ,'+#13+
	                '[past_time] [varchar] (25) COLLATE Chinese_PRC_CI_AS NULL ,'+#13+
	                '[cumulateConsist] [int] NULL ,'+#13+
	                '[station] [varchar] (25) COLLATE Chinese_PRC_CI_AS NULL ,'+#13+
	                '[OperID] [varchar] (25) COLLATE Chinese_PRC_CI_AS NULL'+#13+
                        ') ON [PRIMARY]';
      ADOCommand1.Execute;
    end;
      Gauge1.Progress:=28;
      //
    if t5i<>1 then
    begin
      ADOCommand1.CommandText:='CREATE TABLE [dbo].[zcc_log] ('+#13+
	                '[id] [int] IDENTITY (1, 1) NOT NULL ,'+#13+
	                '[operID] [varchar] (30) COLLATE Chinese_PRC_CI_AS NULL ,'+#13+
	                '[datetime1] [varchar] (30) COLLATE Chinese_PRC_CI_AS NULL ,'+#13+
	                '[content1] [varchar] (249) COLLATE Chinese_PRC_CI_AS NULL ,'+#13+
	                '[memo] [varchar] (30) COLLATE Chinese_PRC_CI_AS NULL'+#13+
                        ') ON [PRIMARY]';
      ADOCommand1.Execute;
    end;

    Gauge1.Progress:=35;
    Sleep(2000);
  except

  end;

  //service use talbe
  try
    if s1i<>1 then
    begin
      ADOCommand1.CommandText:='CREATE TABLE [dbo].[sxj6566572] ('+#13+
                        '[Col001] [varchar] (30) COLLATE Chinese_PRC_CI_AS NULL ,'+#13+
                        '[Col002] [varchar] (30) COLLATE Chinese_PRC_CI_AS NULL ,'+#13+
                        '[Col003] [varchar] (30) COLLATE Chinese_PRC_CI_AS NULL ,'+#13+
                        '[Col004] [varchar] (30) COLLATE Chinese_PRC_CI_AS NULL ,'+#13+
                        '[Col005] [varchar] (30) COLLATE Chinese_PRC_CI_AS NULL ,'+#13+
                        '[Col006] [varchar] (30) COLLATE Chinese_PRC_CI_AS NULL ,'+#13+
                        '[Col007] [varchar] (30) COLLATE Chinese_PRC_CI_AS NULL ,'+#13+
                        '[Col008] [varchar] (30) COLLATE Chinese_PRC_CI_AS NULL ,'+#13+
                        '[Col009] [varchar] (30) COLLATE Chinese_PRC_CI_AS NULL ,'+#13+
                        '[Col010] [varchar] (30) COLLATE Chinese_PRC_CI_AS NULL ,'+#13+
                        '[Col011] [varchar] (30) COLLATE Chinese_PRC_CI_AS NULL'+#13+
                        ') ON [PRIMARY]';
      ADOCommand1.Execute;
    end;
    Gauge1.Progress:=55;
    //
    if s2i<>1 then
    begin
      ADOCommand1.CommandText:='CREATE TABLE [dbo].[tbk6563921] ('+#13+
                        '[Col001] [varchar] (30) COLLATE Chinese_PRC_CI_AS NULL ,'+#13+
                        '[Col002] [varchar] (30) COLLATE Chinese_PRC_CI_AS NULL ,'+#13+
                        '[Col003] [varchar] (30) COLLATE Chinese_PRC_CI_AS NULL ,'+#13+
                        '[Col004] [varchar] (30) COLLATE Chinese_PRC_CI_AS NULL ,'+#13+
                        '[Col005] [varchar] (30) COLLATE Chinese_PRC_CI_AS NULL ,'+#13+
                        '[Col006] [varchar] (30) COLLATE Chinese_PRC_CI_AS NULL ,'+#13+
                        '[Col007] [varchar] (30) COLLATE Chinese_PRC_CI_AS NULL ,'+#13+
                        '[Col008] [varchar] (30) COLLATE Chinese_PRC_CI_AS NULL ,'+#13+
                        '[Col009] [varchar] (30) COLLATE Chinese_PRC_CI_AS NULL ,'+#13+
                        '[Col010] [varchar] (30) COLLATE Chinese_PRC_CI_AS NULL ,'+#13+
                        '[Col011] [varchar] (30) COLLATE Chinese_PRC_CI_AS NULL'+#13+
                        ') ON [PRIMARY]';
      ADOCommand1.Execute;
    end;
    Gauge1.Progress:=62;
    //
    if s3i<>1 then
    begin
      ADOCommand1.CommandText:='CREATE TABLE [dbo].[ltk6565734] ('+#13+
                        '[Col001] [varchar] (30) COLLATE Chinese_PRC_CI_AS NULL ,'+#13+
                        '[Col002] [varchar] (30) COLLATE Chinese_PRC_CI_AS NULL ,'+#13+
                        '[Col003] [varchar] (30) COLLATE Chinese_PRC_CI_AS NULL ,'+#13+
                        '[Col004] [varchar] (30) COLLATE Chinese_PRC_CI_AS NULL ,'+#13+
                        '[Col005] [varchar] (30) COLLATE Chinese_PRC_CI_AS NULL ,'+#13+
                        '[Col006] [varchar] (30) COLLATE Chinese_PRC_CI_AS NULL ,'+#13+
                        '[Col007] [varchar] (30) COLLATE Chinese_PRC_CI_AS NULL ,'+#13+
                        '[Col008] [varchar] (30) COLLATE Chinese_PRC_CI_AS NULL ,'+#13+
                        '[Col009] [varchar] (30) COLLATE Chinese_PRC_CI_AS NULL ,'+#13+
                        '[Col010] [varchar] (30) COLLATE Chinese_PRC_CI_AS NULL ,'+#13+
                        '[Col011] [varchar] (30) COLLATE Chinese_PRC_CI_AS NULL'+#13+
                        ') ON [PRIMARY]';
      ADOCommand1.Execute;
    end;
    Gauge1.Progress:=69;
    //
    if s4i<>1 then
    begin
      ADOCommand1.CommandText:='CREATE TABLE [dbo].[zlnr04] ('+#13+
                        '[Col001] [varchar] (30) COLLATE Chinese_PRC_CI_AS NULL ,'+#13+
                        '[Col002] [varchar] (30) COLLATE Chinese_PRC_CI_AS NULL ,'+#13+
                        '[Col003] [varchar] (30) COLLATE Chinese_PRC_CI_AS NULL ,'+#13+
                        '[Col004] [varchar] (30) COLLATE Chinese_PRC_CI_AS NULL ,'+#13+
                        '[Col005] [varchar] (30) COLLATE Chinese_PRC_CI_AS NULL ,'+#13+
                        '[Col006] [varchar] (30) COLLATE Chinese_PRC_CI_AS NULL ,'+#13+
                        '[Col007] [varchar] (30) COLLATE Chinese_PRC_CI_AS NULL ,'+#13+
                        '[Col008] [varchar] (30) COLLATE Chinese_PRC_CI_AS NULL ,'+#13+
                        '[Col009] [varchar] (30) COLLATE Chinese_PRC_CI_AS NULL ,'+#13+
                        '[Col010] [varchar] (30) COLLATE Chinese_PRC_CI_AS NULL ,'+#13+
                        '[Col011] [varchar] (30) COLLATE Chinese_PRC_CI_AS NULL'+#13+
                        ') ON [PRIMARY]';
      ADOCommand1.Execute;
    end;
    Gauge1.Progress:=76;
    //
    if s5i<>1 then
    begin
      ADOCommand1.CommandText:='CREATE TABLE [dbo].[zlnr05] ('+#13+
                        '[Col001] [varchar] (30) COLLATE Chinese_PRC_CI_AS NULL ,'+#13+
                        '[Col002] [varchar] (30) COLLATE Chinese_PRC_CI_AS NULL ,'+#13+
                        '[Col003] [varchar] (30) COLLATE Chinese_PRC_CI_AS NULL ,'+#13+
                        '[Col004] [varchar] (30) COLLATE Chinese_PRC_CI_AS NULL ,'+#13+
                        '[Col005] [varchar] (30) COLLATE Chinese_PRC_CI_AS NULL ,'+#13+
                        '[Col006] [varchar] (30) COLLATE Chinese_PRC_CI_AS NULL ,'+#13+
                        '[Col007] [varchar] (30) COLLATE Chinese_PRC_CI_AS NULL ,'+#13+
                        '[Col008] [varchar] (30) COLLATE Chinese_PRC_CI_AS NULL ,'+#13+
                        '[Col009] [varchar] (30) COLLATE Chinese_PRC_CI_AS NULL ,'+#13+
                        '[Col010] [varchar] (30) COLLATE Chinese_PRC_CI_AS NULL ,'+#13+
                        '[Col011] [varchar] (30) COLLATE Chinese_PRC_CI_AS NULL'+#13+
                        ') ON [PRIMARY]';
      ADOCommand1.Execute;
    end;
    Gauge1.Progress:=83;
    //
    if s6i<>1 then
    begin
      ADOCommand1.CommandText:='CREATE TABLE [dbo].[zlnr06] ('+#13+
                        '[Col001] [varchar] (30) COLLATE Chinese_PRC_CI_AS NULL ,'+#13+
                        '[Col002] [varchar] (30) COLLATE Chinese_PRC_CI_AS NULL ,'+#13+
                        '[Col003] [varchar] (30) COLLATE Chinese_PRC_CI_AS NULL ,'+#13+
                        '[Col004] [varchar] (30) COLLATE Chinese_PRC_CI_AS NULL ,'+#13+
                        '[Col005] [varchar] (30) COLLATE Chinese_PRC_CI_AS NULL ,'+#13+
                        '[Col006] [varchar] (30) COLLATE Chinese_PRC_CI_AS NULL ,'+#13+
                        '[Col007] [varchar] (30) COLLATE Chinese_PRC_CI_AS NULL ,'+#13+
                        '[Col008] [varchar] (30) COLLATE Chinese_PRC_CI_AS NULL ,'+#13+
                        '[Col009] [varchar] (30) COLLATE Chinese_PRC_CI_AS NULL ,'+#13+
                        '[Col010] [varchar] (30) COLLATE Chinese_PRC_CI_AS NULL ,'+#13+
                        '[Col011] [varchar] (30) COLLATE Chinese_PRC_CI_AS NULL'+#13+
                        ') ON [PRIMARY]';
      ADOCommand1.Execute;
    end;
    Gauge1.Progress:=90;
    //
    if s7i<>1 then
    begin
      ADOCommand1.CommandText:='CREATE TABLE [dbo].[zlnr07] ('+#13+
                        '[Col001] [varchar] (30) COLLATE Chinese_PRC_CI_AS NULL ,'+#13+
                        '[Col002] [varchar] (30) COLLATE Chinese_PRC_CI_AS NULL ,'+#13+
                        '[Col003] [varchar] (30) COLLATE Chinese_PRC_CI_AS NULL ,'+#13+
                        '[Col004] [varchar] (30) COLLATE Chinese_PRC_CI_AS NULL ,'+#13+
                        '[Col005] [varchar] (30) COLLATE Chinese_PRC_CI_AS NULL ,'+#13+
                        '[Col006] [varchar] (30) COLLATE Chinese_PRC_CI_AS NULL ,'+#13+
                        '[Col007] [varchar] (30) COLLATE Chinese_PRC_CI_AS NULL ,'+#13+
                        '[Col008] [varchar] (30) COLLATE Chinese_PRC_CI_AS NULL ,'+#13+
                        '[Col009] [varchar] (30) COLLATE Chinese_PRC_CI_AS NULL ,'+#13+
                        '[Col010] [varchar] (30) COLLATE Chinese_PRC_CI_AS NULL ,'+#13+
                        '[Col011] [varchar] (30) COLLATE Chinese_PRC_CI_AS NULL'+#13+
                        ') ON [PRIMARY]';
      ADOCommand1.Execute;
    end;
    Gauge1.Progress:=100;
    //
    Application.MessageBox('初始化完成！','提示',MB_OK);
    btn_stop.Enabled:=False;
  except

  end;
end;

function Tfrm_init.queryRec(tableNameWstrA,flagWstrA:WideString):Integer;
begin
  AdataSet_query.Close;
  AdataSet_query.CommandText:='select * from dbo.sysobjects where id ='
                +' object_id(N'+''''+tableNameWstrA+''''
                +') and OBJECTPROPERTY(id, N'+''''+flagWstrA+''''
                +') = 1';;
  AdataSet_query.Open;

  Result:=AdataSet_query.RecordCount;
end;

procedure Tfrm_init.btn_stopClick(Sender: TObject);
//var
//  h1:THandle;
var
  tableNameWstr,userFlagWstr:WideString;
begin
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
  //
  try
    ADOConnection_init.Close;
    ADOConnection_init.ConnectionString:=readREG(xbf);
    ADOConnection_init.Open;
  except
    Application.MessageBox('配置错误，请检查链接文件！','提示',MB_OK);
    Exit;
  end;

  //
  userFlagWstr:='IsUserTable';
  //system use table
  tableNameWstr:='[dbo].[arrivestation]';
  t1i:=queryRec(tableNameWstr,userFlagWstr);

  tableNameWstr:='[dbo].[dispatchTemplate]';
  t2i:=queryRec(tableNameWstr,userFlagWstr);

  tableNameWstr:='[dbo].[operator]';
  t3i:=queryRec(tableNameWstr,userFlagWstr);

  tableNameWstr:='[dbo].[TotalTable]';
  t4i:=queryRec(tableNameWstr,userFlagWstr);

  tableNameWstr:='[dbo].[zcc_log]';
  t5i:=queryRec(tableNameWstr,userFlagWstr);
  //
  //service use table
  tableNameWstr:='[dbo].[sxj6566572]';
  s1i:=queryRec(tableNameWstr,userFlagWstr);
  //tbk6563921
  tableNameWstr:='[dbo].[tbk6563921]';
  s2i:=queryRec(tableNameWstr,userFlagWstr);
  //ltk6565734
  tableNameWstr:='[dbo].[ltk6565734]';
  s3i:=queryRec(tableNameWstr,userFlagWstr);
  //zlnr04
  tableNameWstr:='[dbo].[zlnr04]';
  s4i:=queryRec(tableNameWstr,userFlagWstr);
  //zlnr05
  tableNameWstr:='[dbo].[zlnr05]';
  s5i:=queryRec(tableNameWstr,userFlagWstr);
  //zlnr06
  tableNameWstr:='[dbo].[zlnr06]';
  s6i:=queryRec(tableNameWstr,userFlagWstr);
  //zlnr07
  tableNameWstr:='[dbo].[zlnr07]';
  s7i:=queryRec(tableNameWstr,userFlagWstr);
  //
  btn_star.Enabled:=True;
  Application.MessageBox('预处理完成！','提示',MB_OK);
end;


end.
