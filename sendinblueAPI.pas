 {
 *    ██   ██  █████  ██      ██ ██          ██   ██  █████  ███    ██     ██████   █████  ██████  ███████ ███    ███ 
 *    ██   ██ ██   ██ ██      ██ ██          ██   ██ ██   ██ ████   ██     ██   ██ ██   ██ ██   ██ ██      ████  ████ 
 *    ███████ ███████ ██      ██ ██          ███████ ███████ ██ ██  ██     ██████  ███████ ██   ██ █████   ██ ████ ██ 
 *    ██   ██ ██   ██ ██      ██ ██          ██   ██ ██   ██ ██  ██ ██     ██   ██ ██   ██ ██   ██ ██      ██  ██  ██ 
 *    ██   ██ ██   ██ ███████ ██ ███████     ██   ██ ██   ██ ██   ████     ██████  ██   ██ ██████  ███████ ██      ██ 
 *                                                                                                                    
 *
 *}

unit sendinblueAPI;

interface

uses
  Classes, SysUtils, System.JSON, System.Net.URLClient, System.Net.HttpClient,
  System.Net.HttpClientComponent;

type
  TsendinblueAPI = class
  strict private
   class function buildJSON(FromMail, FromName, ToMail, ToName, Subject,
      htmlContent: String; PDFFile: String = ''): string; static;
  public
    class function sendMail(APIKey, FromMail, FromName, ToMail, ToName, Subject,
      htmlContent: String): string; static;
    class function sendMailWithPDF(APIKey, FromMail, FromName, ToMail, ToName, Subject,
      htmlContent, PDFPath: String): string; static;
  end;

implementation

{ TsendinblueAPI }

class function TsendinblueAPI.buildJSON(FromMail, FromName, ToMail, ToName, Subject,
  htmlContent: String; PDFFile: String): string;
var
  mainJSON, senderJSON, toJSON, fileJSON: TJSONObject;
  toJSONArray, toFileJSONArray: TJSONArray;
  IsAttachment: Boolean;
begin
  IsAttachment := False;

  if (PDFFile) <> '' then
  begin
    IsAttachment := True;
  end;

  senderJSON := TJSONObject.Create;
  toJSON := TJSONObject.Create;
  mainJSON := TJSONObject.Create;
  toJSONArray := TJSONArray.Create;

  if IsAttachment then
  begin
    fileJSON := TJSONObject.Create;
    toFileJSONArray := TJSONArray.Create;
  end;

  try
    senderJSON.AddPair('name', FromName);
    senderJSON.AddPair('email', FromMail);
    mainJSON.AddPair('sender', senderJSON);

    toJSON.AddPair('email', ToMail);
    toJSON.AddPair('name', ToName);
    toJSONArray.Add(toJSON);

    mainJSON.AddPair('to', toJSONArray);
    mainJSON.AddPair('subject', Subject);
    mainJSON.AddPair('htmlContent', htmlContent);

    if IsAttachment then
    begin
     fileJSON.AddPair('content', PDFFile);
     fileJSON.AddPair('name', 'attachment-1.pdf');
     toFileJSONArray.Add(fileJSON);
     mainJSON.AddPair('attachment', toFileJSONArray);
    end;

    Result := mainJSON.ToString;
  finally
    FreeAndNil(mainJSON);
  end;
end;

class function TsendinblueAPI.sendMail(APIKey, FromMail, FromName, ToMail, ToName,
  Subject, htmlContent: String): string;
var
  NetHTTPClient: TNetHTTPClient;
  NetHTTPRequest: TNetHTTPRequest;
  JSONStream: TStream;
  JSONData: String;
begin
  NetHTTPClient := TNetHTTPClient.Create(nil);
  NetHTTPRequest := TNetHTTPRequest.Create(nil);
  NetHTTPRequest.Client := NetHTTPClient;
  try
    JSONData := buildJSON(FromMail, FromName, ToMail,
      ToName, Subject, htmlContent);

    NetHTTPRequest.CustomHeaders['api-key'] := APIKey;
    NetHTTPRequest.CustomHeaders['accept'] := 'application/json';
    NetHTTPRequest.CustomHeaders['content-type'] := 'application/json';
    JSONStream := TStringStream.Create(JSONData, TEncoding.UTF8);
    Result := NetHTTPRequest.Post('https://api.sendinblue.com/v3/smtp/email',
      JSONStream, nil).ContentAsString();
  finally
    NetHTTPClient.Free;
    NetHTTPRequest.Free;
    JSONStream.Free;
  end;
end;


class function TsendinblueAPI.sendMailWithPDF(APIKey, FromMail, FromName, ToMail, ToName,
  Subject, htmlContent, PDFPath: String): string;
var
  NetHTTPClient: TNetHTTPClient;
  NetHTTPRequest: TNetHTTPRequest;
  JSONStream: TStream;
  JSONData: String;
begin
  NetHTTPClient := TNetHTTPClient.Create(nil);
  NetHTTPRequest := TNetHTTPRequest.Create(nil);
  NetHTTPRequest.Client := NetHTTPClient;
  try
    JSONData := buildJSON(FromMail, FromName, ToMail,
      ToName, Subject, htmlContent, PDFPath);

    NetHTTPRequest.CustomHeaders['api-key'] := APIKey;
    NetHTTPRequest.CustomHeaders['accept'] := 'application/json';
    NetHTTPRequest.CustomHeaders['content-type'] := 'application/json';
    JSONStream := TStringStream.Create(JSONData, TEncoding.UTF8);
    Result := NetHTTPRequest.Post('https://api.sendinblue.com/v3/smtp/email',
      JSONStream, nil).ContentAsString();
  finally
    NetHTTPClient.Free;
    NetHTTPRequest.Free;
    JSONStream.Free;
  end;
end;

end.
