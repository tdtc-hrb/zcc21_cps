unit UGeneralADO;

interface
uses
  SysUtils, Classes, ADODB;

var
  saveFilePath:WideString;

function generalCSV(ADOconnectString,ColName,TableName1,
                                ExprotFileName1:WideString;ColCount:integer):Boolean;

implementation

function generalCSV(ADOconnectString,ColName,TableName1,
                                ExprotFileName1:WideString;ColCount:integer):Boolean;
var
  ADOConnectX:TADOConnection;
  ADOQueryX:TADOQuery;
  
  TempStr:WideString;
  iFor: integer;
  TempList:TStringList;
begin
  ADOConnectX:=TADOConnection.Create(nil);
  ADOQueryX:=TADOQuery.Create(nil);

  ADOConnectX.LoginPrompt:=False;
  ADOConnectX.Close;
  ADOConnectX.ConnectionString:=ADOconnectString;
  ADOConnectX.Open;
  
  ADOQueryX.Connection:=ADOConnectX;
  ADOQueryX.Close;
  ADOQueryX.SQL.Text:='select '+ColName+' from '+TableName1;
  ADOQueryX.Open;


  TempStr := '';
  TempList := TStringList.Create;
  ADOQueryX.First;
  while not ADOQueryX.Eof do
  begin
    TempStr := '';
    for iFor := 0 to ColCount-1 do//colcount¡–
    begin
      if iFor=0 then
      begin
        TempStr := TempStr + ADOQueryX.Fields[iFor].AsString;
      end
      else
      begin
        TempStr := TempStr +','+ ADOQueryX.Fields[iFor].AsString;
      end;
    end;
    TempList.Append(TempStr);
    ADOQueryX.Next;
  end;

  saveFilePath:=ExprotFileName1;
  TempList.SaveToFile(saveFilePath);
  //free object
  FreeAndNil(TempList);
  FreeAndNil(ADOConnectX);
  FreeAndNil(ADOQueryX);

  Result:=True;

end;

end.
