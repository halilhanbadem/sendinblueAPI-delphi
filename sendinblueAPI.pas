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
  private
    function buildJSON(FromMail, FromName, ToMail, ToName, Subject,
      htmlContent: String): string;
  public
    class function sendMail(APIKey, FromMail, FromName, ToMail, ToName, Subject,
      htmlContent: String): string;
  end;

implementation

{ TsendinblueAPI }

function TsendinblueAPI.buildJSON(FromMail, FromName, ToMail, ToName, Subject,
  htmlContent: String): string;
var
  mainJSON, senderJSON, toJSON: TJSONObject;
  toJSONArray: TJSONArray;
begin
  senderJSON := TJSONObject.Create;
  toJSON := TJSONObject.Create;
  mainJSON := TJSONObject.Create;
  toJSONArray := TJSONArray.Create;
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
  Instance: TsendinblueAPI;
begin
  Instance := TsendinblueAPI.Create;
  NetHTTPClient := TNetHTTPClient.Create(nil);
  NetHTTPRequest := TNetHTTPRequest.Create(nil);
  NetHTTPRequest.Client := NetHTTPClient;
  try
    JSONData := Instance.buildJSON(FromMail, FromName, ToMail,
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
    Instance.Free;
  end;
end;

end.
