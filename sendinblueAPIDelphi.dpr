program sendinblueAPIDelphi;

uses
  Vcl.Forms,
  MainForm in 'MainForm.pas' {Main},
  sendinblueAPI in 'sendinblueAPI.pas';

{$R *.res}

begin
  ReportMemoryLeaksOnShutdown := True;
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TMain, Main);
  Application.Run;
end.
