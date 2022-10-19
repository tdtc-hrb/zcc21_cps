program export;

uses
  Forms,
  init112 in 'init112.pas' {frmExport},
  UreadReg in 'UreadReg.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.Title := '数据导出';
  Application.CreateForm(TfrmExport, frmExport);
  Application.Run;
end.
