unit MainForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, sendinblueAPI;

type
  TMain = class(TForm)
    btnSend: TButton;
    procedure btnSendClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Main: TMain;

implementation

{$R *.dfm}

procedure TMain.btnSendClick(Sender: TObject);
var
 APIKey, FromMail, FromName, ToMail, ToName, Subject, HTMLContent: String;
begin
 FromMail := 'YOUR_MAIL';
 FromName := 'YOUR_NAME';
 ToMail := 'halilhanbadem@gmail.com';
 ToName := 'Halil Han Badem';
 Subject := 'Thank you: sendinblueAPI for Delphi';
 HTMLContent := 'Hi Halil Han! Your api codes are working.';
 APIKey := 'YOUR_V3_API_CODE';
 ShowMessage(TsendinblueAPI.sendMail(APIKey, FromMail, FromName, ToMail, ToName, Subject, HTMLContent));
end;



end.
