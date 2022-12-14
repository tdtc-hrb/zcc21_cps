unit data_abstracts;

interface

uses
  Windows, SysUtils, Classes, SvcMgr, DB, ADODB, Inifiles, ExtCtrls, UreadReg;

type
  Thread_t2d = class(TThread)
  private
    t1,t2,t3,t4,t5,t6,t7:WideString;
    parade1:integer;
    { Private declarations }
  protected
    Function RegulateStr(aString:String;Sepchar:String):String;
    Function GetSubStr(var aString:String;SepChar:String):String;
    procedure Execute; override;
  public
    constructor Create(flag:Boolean;parade:integer);
  end;
  
type
  Tdata_abstract = class(TService)
    Timer1: TTimer;
    procedure ServiceStart(Sender: TService; var Started: Boolean);
    procedure ServiceContinue(Sender: TService; var Continued: Boolean);
    procedure ServicePause(Sender: TService; var Paused: Boolean);
    procedure ServiceStop(Sender: TService; var Stopped: Boolean);
    procedure Timer1Timer(Sender: TObject);
    procedure ServiceCreate(Sender: TObject);
    procedure ServiceDestroy(Sender: TObject);
  private
    ftxt2db1:Thread_t2d;
    ftxt2db2:Thread_t2d;
    ftxt2db3:Thread_t2d;
    ftxt2db4:Thread_t2d;
    ftxt2db5:Thread_t2d;
    ftxt2db6:Thread_t2d;
    ftxt2db7:Thread_t2d;
    //
    procedure CreateThread_t2d;
  public
    ADOConnectionX:TADOConnection;
    function GetServiceController: TServiceController; override;
  end;

type
  Tfun_readFcn=function(loadFileA:WideString):DWORD;stdcall;
  Tfun_calFcn=function(filePathA:WideString):DWORD;stdcall;

var
  data_abstract: Tdata_abstract;

  readFcnA:Tfun_readFcn;
  calFcnA:Tfun_calFcn;
  
implementation
uses
  strUtils;  
{$R *.DFM}

procedure ServiceController(CtrlCode: DWord); stdcall;
begin
  data_abstract.Controller(CtrlCode);
end;

function Tdata_abstract.GetServiceController: TServiceController;
begin
  Result := ServiceController;
end;

//
procedure Tdata_abstract.CreateThread_t2d;
begin
  ftxt2db1:=Thread_t2d.Create(False,1);
  ftxt2db2:=Thread_t2d.Create(False,2);
  ftxt2db3:=Thread_t2d.Create(False,3);
  ftxt2db4:=Thread_t2d.Create(False,4);
  ftxt2db5:=Thread_t2d.Create(False,5);
  ftxt2db6:=Thread_t2d.Create(False,6);
  ftxt2db7:=Thread_t2d.Create(False,7);
end;

procedure Tdata_abstract.ServiceStart(Sender: TService; var Started: Boolean);
begin
  CreateThread_t2d;
  Started:=True;
end;

procedure Tdata_abstract.ServiceContinue(Sender: TService;
  var Continued: Boolean);
begin
  CreateThread_t2d;
  Continued:=True;
end;

procedure Tdata_abstract.ServicePause(Sender: TService; var Paused: Boolean);
begin
  CreateThread_t2d;
  Paused:=True;
end;

procedure Tdata_abstract.ServiceStop(Sender: TService; var Stopped: Boolean);
begin
  CreateThread_t2d;
  Stopped:=True;
end;

procedure Tdata_abstract.Timer1Timer(Sender: TObject);
begin
  ftxt2db1.Execute;
  ftxt2db2.Execute;
  ftxt2db3.Execute;
  ftxt2db4.Execute;
  ftxt2db5.Execute;
  ftxt2db6.Execute;
  ftxt2db7.Execute;
end;

procedure Tdata_abstract.ServiceCreate(Sender: TObject);
var
  xbffilepath:string;
  xbfini:TIniFile;
  xbfname:string;
  //h1:THandle;
begin
  //h1:=0;
  xbfini:=TIniFile.Create(ExtractFilePath(ParamStr(0))+'CPS_service.ini');
  xbfname:=xbfini.ReadString('file name','1','');
  xbffilepath:=ExtractFilePath(ParamStr(0))+xbfname;
  //
  try
    ADOConnectionX:=TADOConnection.Create(nil);
    ADOConnectionX.LoginPrompt:=False;
    ADOConnectionX.Close;
    
    ADOConnectionX.ConnectionString:=readREG(xbffilepath)
  except

  end;

end;

////??????????
constructor Thread_t2d.create(flag:Boolean;parade:integer);
var
  xbfini:TIniFile;
  Err : DWord;
  timeformat1:PChar;
  //
  Int1:Integer;
  fileCountInt:Integer;
  reportAy:array [0..15]of string; 
begin
  inherited Create(False);
  xbfini:=TIniFile.Create(ExtractFilePath(ParamStr(0))+'CPS_service.ini');
  //
  fileCountInt:=xbfini.ReadInteger('file count','1',3);
  for  int1:=0 to fileCountInt-1 do
  begin
     reportAy[Int1]:=xbfini.ReadString('file path',IntToStr(Int1+1),'');
  end;
  //
  t1:=reportAy[0];
  t2:=reportAy[1];
  t3:=reportAy[2];
  t4:=reportAy[3];
  t5:=reportAy[4];
  t6:=reportAy[5];
  t7:=reportAy[6];

  parade1:=parade;
    //
  timeformat1:='yyyy-MM-dd';
  if SetLocaleInfo(LOCALE_USER_DEFAULT,LOCALE_SSHORTDATE,timeformat1) then
  begin
    //
  end
  else
  begin
    Err := GetLastError;
    //????????????
    case Err of
      ERROR_INVALID_ACCESS : ;
      ERROR_INVALID_FLAGS  : ;
      ERROR_INVALID_PARAMETER : ;
    end;
  end;
  //free and nil
  FreeAndNil(xbfini);
end;
//
//
Function Thread_t2d.RegulateStr(aString:String;Sepchar:String):String;
var
  i,Num:Integer;
  Flag:Boolean;
  MyStr,TempStr:String;
begin
  Flag:=False;
  Num:=Length(aString);
  for i:=1 to Num do
  begin
    TempStr:=Copy(aString,i,1);
    if TempStr<>SepChar then
    begin
      MyStr:=MyStr+TempStr;
      Flag:=True;
    end
    else
      if(Flag)then
      begin
        Mystr:=Mystr+TempStr;
        Flag:=False;
      end
      else
      begin
         Mystr:=Mystr+' '+TempStr;
         Flag:=False;
      end;
    end;
    if MyStr[Length(MyStr)]<>SepChar then
    MyStr:=MyStr+SepChar;
    RegulateStr:=MyStr;
end;

Function Thread_t2d.GetSubStr(var aString:String;SepChar:String):String;
var
  Mystr:WideString;
  SepCharPos:Integer;
begin
  SepCharPos:=Pos(SepChar,aString);
  MyStr:=Copy(aString,1,SepCharPos-1);
  Delete(aString,1,SepCharPos);
  GetSubStr:=MyStr;
end;




procedure Thread_t2d.Execute;
var
  richstring:TStringList;
  i,j:Integer;
  MyLine:String;
  //
  filename1:WideString;
  ADODataSetX:TADODataSet;
  //
  txtCrc32Value,fcnCrc32Value:DWORD;
  posInt1:integer;
  genFileNameStrA:WideString;
  //
  h2:THandle;
begin
  ADODataSetX:=TADODataSet.Create(nil);
  ADODataSetX.Connection:=data_abstract.ADOConnectionX;
  //
  case parade1 of

    1:
      begin
        filename1:=t1;
        ADODataSetX.Close;
        ADODataSetX.CommandText:='select * from sxj6566572';
      end;
    2:
      begin
        filename1:=t2;
        ADODataSetX.Close;
        ADODataSetX.CommandText:='select * from tbk6563921';
      end;
    3:
      begin
        filename1:=t3;
        ADODataSetX.Close;
        ADODataSetX.CommandText:='select * from ltk6565734';
      end;
    4:
      begin
        filename1:=t4;
        ADODataSetX.Close;
        ADODataSetX.CommandText:='select * from zlnr04';
      end;
    5:
      begin
        filename1:=t5;
        ADODataSetX.Close;
        ADODataSetX.CommandText:='select * from zlnr05';
      end;
    6:
      begin
        filename1:=t6;
        ADODataSetX.Close;
        ADODataSetX.CommandText:='select * from zlnr06';
      end;      
    7:
      begin
        filename1:=t7;
        ADODataSetX.Close;
        ADODataSetX.CommandText:='select * from zlnr07';
      end;
   end;

  richstring:=TStringList.Create;
  try
    richstring.LoadFromFile(filename1);
    //
    posInt1:=pos('.',filename1);
    genFileNameStrA:=LeftStr(filename1,posInt1-1);
    txtCrc32Value:=1;
    fcnCrc32Value:=2;
    Randomize;
    h2:=0;
    try
      h2:=LoadLibrary('FCN.dll');
      if h2<>0 then
      begin
        @readFcnA:=GetProcAddress(h2,'readFCN');
        @calFcnA:=GetProcAddress(h2,'calCRC32');
      end;
      //
      if @calFcnA<>nil then txtCrc32Value:=calFcnA(filename1);
      if @readFcnA<>nil then
      begin
        if FileExists(genFileNameStrA+'.fcn')then
                fcnCrc32Value:=readFcnA(genFileNameStrA+'.fcn')
           else fcnCrc32Value:=0;
      end;
    finally
      FreeLibrary(h2);
    end;
    if(txtCrc32Value<>fcnCrc32Value)then
    begin
      richstring.Add('-------------------------------------------------------');
      richstring.Add('check Report Name:         '+filename1);
      richstring.Add('check Report CRC32 Value:  '+IntToHex(txtCrc32Value,8));
      richstring.Add('check FCN File CRC32 Value:'+IntToHex(fcnCrc32Value,8));
      richstring.Add('check Date Time:           '+DateTimeToStr(Now));
      richstring.Add('-------------------------------------------------------');
      richstring.SaveToFile(genFileNameStrA+IntToStr(random(99))+'.erp');
      //
      DeleteFile(filename1);
      DeleteFile(genFileNameStrA+'.fcn');
      //free and nil
      FreeAndNil(ADODataSetX);
      FreeAndNil(richstring);
      //
      ExitProcessProc;
    end;
  except
    Exit;
  end;


  with ADODataSetX do
  begin
    Open;
    for i:=0 to richstring.Count-1 do
    begin
      MyLine:=RegulateStr(richstring.Strings[i],',');
      for j:=1 to 11 do//11??--????????????????
      begin
        Edit;
        Fields[j-1].Value:=GetSubStr(MyLine,',');
        post;
      end;//inner for
      Append;
    end;//outer for
    DeleteFile(filename1);
    DeleteFile(genFileNameStrA+'.fcn');
  end;//with end

  //free and nil
  FreeAndNil(ADODataSetX);
  FreeAndNil(richstring);
end;


procedure Tdata_abstract.ServiceDestroy(Sender: TObject);
begin
  FreeAndNil(ADOConnectionX);
end;

end.
 