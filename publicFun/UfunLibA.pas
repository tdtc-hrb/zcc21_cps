unit UfunLibA;

interface
uses
  Windows, Forms, Printers, DBGrids, DB, SysUtils;

  function GridPrintA(dataSetA:TDataSet;DBGridA:TDBGrid):Boolean;
  function GetCDPFileVersion(FileName:String):String;
  
implementation

function GridPrintA(dataSetA:TDataSet;DBGridA:TDBGrid):Boolean;
const
  LeftBlank=1;
  RightBlank=1;
  TopBlank=1;
  BottomBlank=1;
var
  PointX,PointY:integer;
  PointScale,PrintStep:integer;
  s:string;
  x,y:integer;
  i:integer;
begin

  PointX:=Trunc(GetDeviceCaps(Printer.Handle,LOGPIXELSX)/2.54);
  PointY:=Trunc(GetDeviceCaps(Printer.Handle,LOGPIXELSY)/2.54);

  PointScale:=Trunc(GetDeviceCaps(Printer.Handle,LOGPIXELSY)/Screen.PixelsPerInch+0.5);
  printer.Orientation:=poPortrait;



  printer.Canvas.Font.Name:='ËÎÌו';
  printer.canvas.Font.Size:=10;

  s:='xiaobin';
  PrintStep:=printer.canvas.TextHeight(s)+16;

  x:=PointX*LeftBlank;
  y:=PointY*TopBlank;

  if (dataSetA.Active=true) and (dataSetA.RecordCount>0) then
  begin
    printer.BeginDoc;
    dataSetA.First;
    
    while not dataSetA.Eof do
    begin 
      for i:=0 to DBGridA.FieldCount-1 do
      begin
    
        if (x+DBGridA.Columns.Items[i].Width*PointScale)<=(Printer.PageWidth-PointX*RightBlank) then
        begin

          Printer.Canvas.Rectangle(x,y,x+DBGridA.Columns.Items[i].Width*PointScale,y+PrintStep);
          if y=PointY*TopBlank then
            Printer.Canvas.TextOut(x+8,y+8,DBGridA.Columns[i].Title.Caption)
          else
            Printer.Canvas.TextOut(x+8,y+8,DBGridA.Fields[i].asString);
        end;
        x:=x+DBGridA.Columns.Items[i].Width*PointScale;
      end;
      if not (y=PointY*TopBlank) then
        dataSetA.next;
        x:=PointX*LeftBlank;
        y:=y+PrintStep;
      if (y+PrintStep)>(Printer.PageHeight-PointY*BottomBlank) then
      begin
        Printer.NewPage;
        y:=PointY*TopBlank;
      end;
    end;//whil end

    printer.EndDoc;
    dataSetA.First;
  end;//if end

  Result:=True;
end;

function GetCDPFileVersion(FileName:String):String;
var
  InfoSize,Wnd:DWORD;
  VerBuf:Pointer;
  VerInfo:^VS_FIXEDFILEINFO;
begin
    Result:='1.0.0.0';
    InfoSize:=GetFileVersionInfoSize(PChar(FileName),Wnd);
    if InfoSize<>0 then
    begin
      GetMem(VerBuf,InfoSize);
      try
        if GetFileVersionInfo(PChar(FileName),Wnd,InfoSize,VerBuf) then
        begin
          VerInfo:=nil;
          VerQueryValue(VerBuf,'\',Pointer(VerInfo),Wnd);
          if VerInfo<>nil then Result:=Format('%d.%d.%d.%d',[VerInfo^.dwFileVersionMS shr 16,
                                                             VerInfo^.dwFileVersionMS and $0000ffff,
                                                             VerInfo^.dwFileVersionLS shr 16,
                                                             VerInfo^.dwFileVersionLS and $0000ffff]);
        end;
      finally
        FreeMem(VerBuf,InfoSize);
      end;

    end;
end;

end.
