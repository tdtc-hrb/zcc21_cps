program CPS_x3;

uses
  Forms,
  windows,
  SysUtils,
  Udispatch in 'Udispatch.pas' {frm_main},
  u_about in 'u_about.pas' {frm_about},
  Ulogin in 'Ulogin.pas' {frm_login},
  Udatatotal in 'Udatatotal.pas' {frm_sa},
  Ustation in 'Ustation.pas' {frm_station},
  UGeneralADO in 'csvGeneral\UGeneralADO.pas',
  UreadReg in 'init2\UreadReg.pas',
  UfunLibA in 'publicFun\UfunLibA.pas';

{$R *.res}
Var
  hMutex:HWND;
  Ret:Integer;
  
begin
  hMutex:=CreateMutex(nil,False,'DispatchCenter');
  Ret:=GetLastError;
  If Ret<>ERROR_ALREADY_EXISTS Then
  begin
    Application.Initialize;
    Application.Title := 'DispatchCenter';
  try
      frm_login :=Tfrm_login.Create(nil);
      frm_login.ShowModal;
    finally
      frm_login.Free;
    end;
    if handlers<>'' then
    begin
      application.MessageBox('û����ȷ��¼������ʹ�ñ����!','��ʾ',mb_ok);
      exit ;
    end ;

    Application.CreateForm(Tfrm_main, frm_main);
  Application.Run;
  end
  else
  begin
    Application.MessageBox('�����Ѿ������У�','��ʾ',MB_OK+MB_ICONHAND);
    Exit;
  end;
end.
