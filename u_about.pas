unit u_about;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, ShellApi, ComCtrls;

type
  Tfrm_about = class(TForm)
    Label10: TLabel;
    StaticText1: TStaticText;
    StaticText3: TStaticText;
    Animate1: TAnimate;
    StaticTextVer: TStaticText;
    StaticText2: TStaticText;
    StaticText4: TStaticText;
    Bevel1: TBevel;
    procedure Label10Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    verStr:string;
    { Public declarations }
  end;

var
  frm_about: Tfrm_about;

implementation
uses
  UfunLibA;
{$R *.dfm}
{$R htkLogo.res}

procedure Tfrm_about.Label10Click(Sender: TObject);
begin
//
    ShellExecute(Handle,
				 nil,
				 PChar(Label10.Caption),
				 nil,
				 nil,
				 SW_SHOWNORMAL);

end;

procedure Tfrm_about.FormShow(Sender: TObject);
var
  szExePathname:array [0..266]of char;
  hMoudleA:DWORD;
begin
  hMoudleA:=GetModuleHandle(nil);
  GetModuleFileName(hMoudleA,szExePathname,MAX_PATH);
  verStr:=GetCDPFileVersion(string(szExePathname));
  StaticTextVer.Caption:=verStr;
  //htkLogo.res
  //RC:htkAVI AVI res\HTK.AVI
  Animate1.ResName:='htkAVI';
  Animate1.Active:=True;
end;

end.
