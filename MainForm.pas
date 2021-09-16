unit MainForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, sendinblueAPI, System.NetEncoding, System.IOUtils;

type
  TMain = class(TForm)
    btnSend: TButton;
    Button1: TButton;
    Edit1: TEdit;
    Button2: TButton;
    OpenDialog1: TOpenDialog;
    procedure btnSendClick(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
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



procedure TMain.Button1Click(Sender: TObject);
var
 APIKey, FromMail, FromName, ToMail, ToName, Subject, HTMLContent, PDFBase64: String;
begin
 FromMail := 'YOUR_MAIL';
 FromName := 'YOUR_NAME';
 ToMail := 'halilhanbadem@gmail.com';
 ToName := 'Halil Han Badem';
 Subject := 'Thank you: sendinblueAPI for Delphi';
 HTMLContent := 'Hi Halil Han! <p style="color: blue;">Your api codes are working.</p>';
 APIKey := 'YOU_V3_API_CODE';
 PDFBase64 := TNetEncoding.Base64.EncodeBytesToString(TFile.ReadAllBytes(Edit1.Text));
 ShowMessage(TsendinblueAPI.sendMailWithPDF(APIKey, FromMail, FromName, ToMail, ToName, Subject, HTMLContent, PDFBase64));

end;

procedure TMain.Button2Click(Sender: TObject);
begin
 if OpenDialog1.Execute then
 begin
   Edit1.Text := OpenDialog1.FileName;
 end;
end;

end.
