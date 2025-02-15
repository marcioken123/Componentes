{***********************************************************
                R&A Library
                   RAI2
       Copyright (C) 1998-99 R&A

       description : adapter unit - converts RAI2 calls to delphi calls

       programer   : black
       e-mail      : black@infa.ru
       www         : www.chat.ru\~blacknbs\ralib
************************************************************}
{$INCLUDE RA.INC}

unit RAI2_httpapp;

interface

uses RAI2;

  procedure RegisterRAI2Adapter(RAI2Adapter: TRAI2Adapter);

implementation

uses SysUtils, Classes, Forms, Masks,
 {$IFDEF RA_D5H} Contnrs, {$ENDIF RA_D5H}
  HTTPApp;


  { TWebRequest }

{  function ReadClient(var Buffer; Count: Integer): Integer; }
procedure TWebRequest_ReadClient(var Value: Variant; Args: TArgs);
begin
  Value := TWebRequest(Args.Obj).ReadClient(Args.Values[0], Args.Values[1]);
end;

{  function ReadString(Count: Integer): string; }
procedure TWebRequest_ReadString(var Value: Variant; Args: TArgs);
begin
  Value := TWebRequest(Args.Obj).ReadString(Args.Values[0]);
end;

{  function TranslateURI(const URI: string): string; }
procedure TWebRequest_TranslateURI(var Value: Variant; Args: TArgs);
begin
  Value := TWebRequest(Args.Obj).TranslateURI(Args.Values[0]);
end;

{  function WriteClient(var Buffer; Count: Integer): Integer; }
procedure TWebRequest_WriteClient(var Value: Variant; Args: TArgs);
begin
  Value := TWebRequest(Args.Obj).WriteClient(Args.Values[0], Args.Values[1]);
end;

{  function WriteString(const AString: string): Boolean; }
procedure TWebRequest_WriteString(var Value: Variant; Args: TArgs);
begin
  Value := TWebRequest(Args.Obj).WriteString(Args.Values[0]);
end;

{  procedure ExtractContentFields(Strings: TStrings); }
procedure TWebRequest_ExtractContentFields(var Value: Variant; Args: TArgs);
begin
  TWebRequest(Args.Obj).ExtractContentFields(V2O(Args.Values[0]) as TStrings);
end;

{  procedure ExtractCookieFields(Strings: TStrings); }
procedure TWebRequest_ExtractCookieFields(var Value: Variant; Args: TArgs);
begin
  TWebRequest(Args.Obj).ExtractCookieFields(V2O(Args.Values[0]) as TStrings);
end;

{  procedure ExtractQueryFields(Strings: TStrings); }
procedure TWebRequest_ExtractQueryFields(var Value: Variant; Args: TArgs);
begin
  TWebRequest(Args.Obj).ExtractQueryFields(V2O(Args.Values[0]) as TStrings);
end;

{  function GetFieldByName(const Name: string): string; }
procedure TWebRequest_GetFieldByName(var Value: Variant; Args: TArgs);
begin
  Value := TWebRequest(Args.Obj).GetFieldByName(Args.Values[0]);
end;

{ property Read MethodType: TMethodType }
procedure TWebRequest_Read_MethodType(var Value: Variant; Args: TArgs);
begin
  Value := TWebRequest(Args.Obj).MethodType;
end;

{ property Read ContentFields: TStrings }
procedure TWebRequest_Read_ContentFields(var Value: Variant; Args: TArgs);
begin
  Value := O2V(TWebRequest(Args.Obj).ContentFields);
end;

{ property Read CookieFields: TStrings }
procedure TWebRequest_Read_CookieFields(var Value: Variant; Args: TArgs);
begin
  Value := O2V(TWebRequest(Args.Obj).CookieFields);
end;

{ property Read QueryFields: TStrings }
procedure TWebRequest_Read_QueryFields(var Value: Variant; Args: TArgs);
begin
  Value := O2V(TWebRequest(Args.Obj).QueryFields);
end;

{ property Read Method: string }
procedure TWebRequest_Read_Method(var Value: Variant; Args: TArgs);
begin
  Value := TWebRequest(Args.Obj).Method;
end;

{ property Read ProtocolVersion: string }
procedure TWebRequest_Read_ProtocolVersion(var Value: Variant; Args: TArgs);
begin
  Value := TWebRequest(Args.Obj).ProtocolVersion;
end;

{ property Read URL: string }
procedure TWebRequest_Read_URL(var Value: Variant; Args: TArgs);
begin
  Value := TWebRequest(Args.Obj).URL;
end;

{ property Read Query: string }
procedure TWebRequest_Read_Query(var Value: Variant; Args: TArgs);
begin
  Value := TWebRequest(Args.Obj).Query;
end;

{ property Read PathInfo: string }
procedure TWebRequest_Read_PathInfo(var Value: Variant; Args: TArgs);
begin
  Value := TWebRequest(Args.Obj).PathInfo;
end;

{ property Read PathTranslated: string }
procedure TWebRequest_Read_PathTranslated(var Value: Variant; Args: TArgs);
begin
  Value := TWebRequest(Args.Obj).PathTranslated;
end;

{ property Read Authorization: string }
procedure TWebRequest_Read_Authorization(var Value: Variant; Args: TArgs);
begin
  Value := TWebRequest(Args.Obj).Authorization;
end;

{ property Read CacheControl: string }
procedure TWebRequest_Read_CacheControl(var Value: Variant; Args: TArgs);
begin
  Value := TWebRequest(Args.Obj).CacheControl;
end;

{ property Read Cookie: string }
procedure TWebRequest_Read_Cookie(var Value: Variant; Args: TArgs);
begin
  Value := TWebRequest(Args.Obj).Cookie;
end;

{ property Read Date: TDateTime }
procedure TWebRequest_Read_Date(var Value: Variant; Args: TArgs);
begin
  Value := TWebRequest(Args.Obj).Date;
end;

{ property Read Accept: string }
procedure TWebRequest_Read_Accept(var Value: Variant; Args: TArgs);
begin
  Value := TWebRequest(Args.Obj).Accept;
end;

{ property Read From: string }
procedure TWebRequest_Read_From(var Value: Variant; Args: TArgs);
begin
  Value := TWebRequest(Args.Obj).From;
end;

{ property Read Host: string }
procedure TWebRequest_Read_Host(var Value: Variant; Args: TArgs);
begin
  Value := TWebRequest(Args.Obj).Host;
end;

{ property Read IfModifiedSince: TDateTime }
procedure TWebRequest_Read_IfModifiedSince(var Value: Variant; Args: TArgs);
begin
  Value := TWebRequest(Args.Obj).IfModifiedSince;
end;

{ property Read Referer: string }
procedure TWebRequest_Read_Referer(var Value: Variant; Args: TArgs);
begin
  Value := TWebRequest(Args.Obj).Referer;
end;

{ property Read UserAgent: string }
procedure TWebRequest_Read_UserAgent(var Value: Variant; Args: TArgs);
begin
  Value := TWebRequest(Args.Obj).UserAgent;
end;

{ property Read ContentEncoding: string }
procedure TWebRequest_Read_ContentEncoding(var Value: Variant; Args: TArgs);
begin
  Value := TWebRequest(Args.Obj).ContentEncoding;
end;

{ property Read ContentType: string }
procedure TWebRequest_Read_ContentType(var Value: Variant; Args: TArgs);
begin
  Value := TWebRequest(Args.Obj).ContentType;
end;

{ property Read ContentLength: Integer }
procedure TWebRequest_Read_ContentLength(var Value: Variant; Args: TArgs);
begin
  Value := TWebRequest(Args.Obj).ContentLength;
end;

{ property Read ContentVersion: string }
procedure TWebRequest_Read_ContentVersion(var Value: Variant; Args: TArgs);
begin
  Value := TWebRequest(Args.Obj).ContentVersion;
end;

{ property Read Content: string }
procedure TWebRequest_Read_Content(var Value: Variant; Args: TArgs);
begin
  Value := TWebRequest(Args.Obj).Content;
end;

{ property Read Connection: string }
procedure TWebRequest_Read_Connection(var Value: Variant; Args: TArgs);
begin
  Value := TWebRequest(Args.Obj).Connection;
end;

{ property Read DerivedFrom: string }
procedure TWebRequest_Read_DerivedFrom(var Value: Variant; Args: TArgs);
begin
  Value := TWebRequest(Args.Obj).DerivedFrom;
end;

{ property Read Expires: TDateTime }
procedure TWebRequest_Read_Expires(var Value: Variant; Args: TArgs);
begin
  Value := TWebRequest(Args.Obj).Expires;
end;

{ property Read Title: string }
procedure TWebRequest_Read_Title(var Value: Variant; Args: TArgs);
begin
  Value := TWebRequest(Args.Obj).Title;
end;

{ property Read RemoteAddr: string }
procedure TWebRequest_Read_RemoteAddr(var Value: Variant; Args: TArgs);
begin
  Value := TWebRequest(Args.Obj).RemoteAddr;
end;

{ property Read RemoteHost: string }
procedure TWebRequest_Read_RemoteHost(var Value: Variant; Args: TArgs);
begin
  Value := TWebRequest(Args.Obj).RemoteHost;
end;

{ property Read ScriptName: string }
procedure TWebRequest_Read_ScriptName(var Value: Variant; Args: TArgs);
begin
  Value := TWebRequest(Args.Obj).ScriptName;
end;

{ property Read ServerPort: Integer }
procedure TWebRequest_Read_ServerPort(var Value: Variant; Args: TArgs);
begin
  Value := TWebRequest(Args.Obj).ServerPort;
end;

  { TCookie }

{ constructor Create(Collection: TCollection) }
procedure TCookie_Create(var Value: Variant; Args: TArgs);
begin
  Value := O2V(TCookie.Create(V2O(Args.Values[0]) as TCollection));
end;

{  procedure AssignTo(Dest: TPersistent); }
procedure TCookie_AssignTo(var Value: Variant; Args: TArgs);
begin
  TCookie(Args.Obj).AssignTo(V2O(Args.Values[0]) as TPersistent);
end;

{ property Read Name: string }
procedure TCookie_Read_Name(var Value: Variant; Args: TArgs);
begin
  Value := TCookie(Args.Obj).Name;
end;

{ property Write Name(Value: string) }
procedure TCookie_Write_Name(const Value: Variant; Args: TArgs);
begin
  TCookie(Args.Obj).Name := Value;
end;

{ property Read Value: string }
procedure TCookie_Read_Value(var Value: Variant; Args: TArgs);
begin
  Value := TCookie(Args.Obj).Value;
end;

{ property Write Value(Value: string) }
procedure TCookie_Write_Value(const Value: Variant; Args: TArgs);
begin
  TCookie(Args.Obj).Value := Value;
end;

{ property Read Domain: string }
procedure TCookie_Read_Domain(var Value: Variant; Args: TArgs);
begin
  Value := TCookie(Args.Obj).Domain;
end;

{ property Write Domain(Value: string) }
procedure TCookie_Write_Domain(const Value: Variant; Args: TArgs);
begin
  TCookie(Args.Obj).Domain := Value;
end;

{ property Read Path: string }
procedure TCookie_Read_Path(var Value: Variant; Args: TArgs);
begin
  Value := TCookie(Args.Obj).Path;
end;

{ property Write Path(Value: string) }
procedure TCookie_Write_Path(const Value: Variant; Args: TArgs);
begin
  TCookie(Args.Obj).Path := Value;
end;

{ property Read Expires: TDateTime }
procedure TCookie_Read_Expires(var Value: Variant; Args: TArgs);
begin
  Value := TCookie(Args.Obj).Expires;
end;

{ property Write Expires(Value: TDateTime) }
procedure TCookie_Write_Expires(const Value: Variant; Args: TArgs);
begin
  TCookie(Args.Obj).Expires := Value;
end;

{ property Read Secure: Boolean }
procedure TCookie_Read_Secure(var Value: Variant; Args: TArgs);
begin
  Value := TCookie(Args.Obj).Secure;
end;

{ property Write Secure(Value: Boolean) }
procedure TCookie_Write_Secure(const Value: Variant; Args: TArgs);
begin
  TCookie(Args.Obj).Secure := Value;
end;

{ property Read HeaderValue: string }
procedure TCookie_Read_HeaderValue(var Value: Variant; Args: TArgs);
begin
  Value := TCookie(Args.Obj).HeaderValue;
end;

  { TWebResponse }

{  function GetCustomHeader(const Name: string): String; }
procedure TWebResponse_GetCustomHeader(var Value: Variant; Args: TArgs);
begin
  Value := TWebResponse(Args.Obj).GetCustomHeader(Args.Values[0]);
end;

{  procedure SendResponse; }
procedure TWebResponse_SendResponse(var Value: Variant; Args: TArgs);
begin
  TWebResponse(Args.Obj).SendResponse;
end;

{  procedure SendRedirect(const URI: string); }
procedure TWebResponse_SendRedirect(var Value: Variant; Args: TArgs);
begin
  TWebResponse(Args.Obj).SendRedirect(Args.Values[0]);
end;

{  procedure SendStream(AStream: TStream); }
procedure TWebResponse_SendStream(var Value: Variant; Args: TArgs);
begin
  TWebResponse(Args.Obj).SendStream(V2O(Args.Values[0]) as TStream);
end;

{  function Sent: Boolean; }
procedure TWebResponse_Sent(var Value: Variant; Args: TArgs);
begin
  Value := TWebResponse(Args.Obj).Sent;
end;

{  procedure SetCookieField(Values: TStrings; const ADomain, APath: string; AExpires: TDateTime; ASecure: Boolean); }
procedure TWebResponse_SetCookieField(var Value: Variant; Args: TArgs);
begin
  TWebResponse(Args.Obj).SetCookieField(V2O(Args.Values[0]) as TStrings, Args.Values[1], Args.Values[2], Args.Values[3], Args.Values[4]);
end;

{  procedure SetCustomHeader(const Name, Value: string); }
procedure TWebResponse_SetCustomHeader(var Value: Variant; Args: TArgs);
begin
  TWebResponse(Args.Obj).SetCustomHeader(Args.Values[0], Args.Values[1]);
end;

{ property Read Cookies: TCookieCollection }
procedure TWebResponse_Read_Cookies(var Value: Variant; Args: TArgs);
begin
  Value := O2V(TWebResponse(Args.Obj).Cookies);
end;

{ property Read HTTPRequest: TWebRequest }
procedure TWebResponse_Read_HTTPRequest(var Value: Variant; Args: TArgs);
begin
  Value := O2V(TWebResponse(Args.Obj).HTTPRequest);
end;

{ property Read Version: string }
procedure TWebResponse_Read_Version(var Value: Variant; Args: TArgs);
begin
  Value := TWebResponse(Args.Obj).Version;
end;

{ property Write Version(Value: string) }
procedure TWebResponse_Write_Version(const Value: Variant; Args: TArgs);
begin
  TWebResponse(Args.Obj).Version := Value;
end;

{ property Read ReasonString: string }
procedure TWebResponse_Read_ReasonString(var Value: Variant; Args: TArgs);
begin
  Value := TWebResponse(Args.Obj).ReasonString;
end;

{ property Write ReasonString(Value: string) }
procedure TWebResponse_Write_ReasonString(const Value: Variant; Args: TArgs);
begin
  TWebResponse(Args.Obj).ReasonString := Value;
end;

{ property Read Server: string }
procedure TWebResponse_Read_Server(var Value: Variant; Args: TArgs);
begin
  Value := TWebResponse(Args.Obj).Server;
end;

{ property Write Server(Value: string) }
procedure TWebResponse_Write_Server(const Value: Variant; Args: TArgs);
begin
  TWebResponse(Args.Obj).Server := Value;
end;

{ property Read WWWAuthenticate: string }
procedure TWebResponse_Read_WWWAuthenticate(var Value: Variant; Args: TArgs);
begin
  Value := TWebResponse(Args.Obj).WWWAuthenticate;
end;

{ property Write WWWAuthenticate(Value: string) }
procedure TWebResponse_Write_WWWAuthenticate(const Value: Variant; Args: TArgs);
begin
  TWebResponse(Args.Obj).WWWAuthenticate := Value;
end;

{ property Read Realm: string }
procedure TWebResponse_Read_Realm(var Value: Variant; Args: TArgs);
begin
  Value := TWebResponse(Args.Obj).Realm;
end;

{ property Write Realm(Value: string) }
procedure TWebResponse_Write_Realm(const Value: Variant; Args: TArgs);
begin
  TWebResponse(Args.Obj).Realm := Value;
end;

{ property Read Allow: string }
procedure TWebResponse_Read_Allow(var Value: Variant; Args: TArgs);
begin
  Value := TWebResponse(Args.Obj).Allow;
end;

{ property Write Allow(Value: string) }
procedure TWebResponse_Write_Allow(const Value: Variant; Args: TArgs);
begin
  TWebResponse(Args.Obj).Allow := Value;
end;

{ property Read Location: string }
procedure TWebResponse_Read_Location(var Value: Variant; Args: TArgs);
begin
  Value := TWebResponse(Args.Obj).Location;
end;

{ property Write Location(Value: string) }
procedure TWebResponse_Write_Location(const Value: Variant; Args: TArgs);
begin
  TWebResponse(Args.Obj).Location := Value;
end;

{ property Read ContentEncoding: string }
procedure TWebResponse_Read_ContentEncoding(var Value: Variant; Args: TArgs);
begin
  Value := TWebResponse(Args.Obj).ContentEncoding;
end;

{ property Write ContentEncoding(Value: string) }
procedure TWebResponse_Write_ContentEncoding(const Value: Variant; Args: TArgs);
begin
  TWebResponse(Args.Obj).ContentEncoding := Value;
end;

{ property Read ContentType: string }
procedure TWebResponse_Read_ContentType(var Value: Variant; Args: TArgs);
begin
  Value := TWebResponse(Args.Obj).ContentType;
end;

{ property Write ContentType(Value: string) }
procedure TWebResponse_Write_ContentType(const Value: Variant; Args: TArgs);
begin
  TWebResponse(Args.Obj).ContentType := Value;
end;

{ property Read ContentVersion: string }
procedure TWebResponse_Read_ContentVersion(var Value: Variant; Args: TArgs);
begin
  Value := TWebResponse(Args.Obj).ContentVersion;
end;

{ property Write ContentVersion(Value: string) }
procedure TWebResponse_Write_ContentVersion(const Value: Variant; Args: TArgs);
begin
  TWebResponse(Args.Obj).ContentVersion := Value;
end;

{ property Read DerivedFrom: string }
procedure TWebResponse_Read_DerivedFrom(var Value: Variant; Args: TArgs);
begin
  Value := TWebResponse(Args.Obj).DerivedFrom;
end;

{ property Write DerivedFrom(Value: string) }
procedure TWebResponse_Write_DerivedFrom(const Value: Variant; Args: TArgs);
begin
  TWebResponse(Args.Obj).DerivedFrom := Value;
end;

{ property Read Title: string }
procedure TWebResponse_Read_Title(var Value: Variant; Args: TArgs);
begin
  Value := TWebResponse(Args.Obj).Title;
end;

{ property Write Title(Value: string) }
procedure TWebResponse_Write_Title(const Value: Variant; Args: TArgs);
begin
  TWebResponse(Args.Obj).Title := Value;
end;

{ property Read StatusCode: Integer }
procedure TWebResponse_Read_StatusCode(var Value: Variant; Args: TArgs);
begin
  Value := TWebResponse(Args.Obj).StatusCode;
end;

{ property Write StatusCode(Value: Integer) }
procedure TWebResponse_Write_StatusCode(const Value: Variant; Args: TArgs);
begin
  TWebResponse(Args.Obj).StatusCode := Value;
end;

{ property Read ContentLength: Integer }
procedure TWebResponse_Read_ContentLength(var Value: Variant; Args: TArgs);
begin
  Value := TWebResponse(Args.Obj).ContentLength;
end;

{ property Write ContentLength(Value: Integer) }
procedure TWebResponse_Write_ContentLength(const Value: Variant; Args: TArgs);
begin
  TWebResponse(Args.Obj).ContentLength := Value;
end;

{ property Read Date: TDateTime }
procedure TWebResponse_Read_Date(var Value: Variant; Args: TArgs);
begin
  Value := TWebResponse(Args.Obj).Date;
end;

{ property Write Date(Value: TDateTime) }
procedure TWebResponse_Write_Date(const Value: Variant; Args: TArgs);
begin
  TWebResponse(Args.Obj).Date := Value;
end;

{ property Read Expires: TDateTime }
procedure TWebResponse_Read_Expires(var Value: Variant; Args: TArgs);
begin
  Value := TWebResponse(Args.Obj).Expires;
end;

{ property Write Expires(Value: TDateTime) }
procedure TWebResponse_Write_Expires(const Value: Variant; Args: TArgs);
begin
  TWebResponse(Args.Obj).Expires := Value;
end;

{ property Read LastModified: TDateTime }
procedure TWebResponse_Read_LastModified(var Value: Variant; Args: TArgs);
begin
  Value := TWebResponse(Args.Obj).LastModified;
end;

{ property Write LastModified(Value: TDateTime) }
procedure TWebResponse_Write_LastModified(const Value: Variant; Args: TArgs);
begin
  TWebResponse(Args.Obj).LastModified := Value;
end;

{ property Read Content: string }
procedure TWebResponse_Read_Content(var Value: Variant; Args: TArgs);
begin
  Value := TWebResponse(Args.Obj).Content;
end;

{ property Write Content(Value: string) }
procedure TWebResponse_Write_Content(const Value: Variant; Args: TArgs);
begin
  TWebResponse(Args.Obj).Content := Value;
end;

{ property Read ContentStream: TStream }
procedure TWebResponse_Read_ContentStream(var Value: Variant; Args: TArgs);
begin
  Value := O2V(TWebResponse(Args.Obj).ContentStream);
end;

{ property Write ContentStream(Value: TStream) }
procedure TWebResponse_Write_ContentStream(const Value: Variant; Args: TArgs);
begin
  TWebResponse(Args.Obj).ContentStream := V2O(Value) as TStream;
end;

{ property Read LogMessage: string }
procedure TWebResponse_Read_LogMessage(var Value: Variant; Args: TArgs);
begin
  Value := TWebResponse(Args.Obj).LogMessage;
end;

{ property Write LogMessage(Value: string) }
procedure TWebResponse_Write_LogMessage(const Value: Variant; Args: TArgs);
begin
  TWebResponse(Args.Obj).LogMessage := Value;
end;

{ property Read CustomHeaders: TStrings }
procedure TWebResponse_Read_CustomHeaders(var Value: Variant; Args: TArgs);
begin
  Value := O2V(TWebResponse(Args.Obj).CustomHeaders);
end;

{ property Write CustomHeaders(Value: TStrings) }
procedure TWebResponse_Write_CustomHeaders(const Value: Variant; Args: TArgs);
begin
  TWebResponse(Args.Obj).CustomHeaders := V2O(Value) as TStrings;
end;

  { TWebActionItem }

{ constructor Create(Collection: TCollection) }
procedure TWebActionItem_Create(var Value: Variant; Args: TArgs);
begin
  Value := O2V(TWebActionItem.Create(V2O(Args.Values[0]) as TCollection));
end;

{  procedure AssignTo(Dest: TPersistent); }
procedure TWebActionItem_AssignTo(var Value: Variant; Args: TArgs);
begin
  TWebActionItem(Args.Obj).AssignTo(V2O(Args.Values[0]) as TPersistent);
end;

{ property Read Default: Boolean }
procedure TWebActionItem_Read_Default(var Value: Variant; Args: TArgs);
begin
  Value := TWebActionItem(Args.Obj).Default;
end;

{ property Write Default(Value: Boolean) }
procedure TWebActionItem_Write_Default(const Value: Variant; Args: TArgs);
begin
  TWebActionItem(Args.Obj).Default := Value;
end;

{ property Read Enabled: Boolean }
procedure TWebActionItem_Read_Enabled(var Value: Variant; Args: TArgs);
begin
  Value := TWebActionItem(Args.Obj).Enabled;
end;

{ property Write Enabled(Value: Boolean) }
procedure TWebActionItem_Write_Enabled(const Value: Variant; Args: TArgs);
begin
  TWebActionItem(Args.Obj).Enabled := Value;
end;

{ property Read MethodType: TMethodType }
procedure TWebActionItem_Read_MethodType(var Value: Variant; Args: TArgs);
begin
  Value := TWebActionItem(Args.Obj).MethodType;
end;

{ property Write MethodType(Value: TMethodType) }
procedure TWebActionItem_Write_MethodType(const Value: Variant; Args: TArgs);
begin
  TWebActionItem(Args.Obj).MethodType := Value;
end;

{ property Read Name: string }
procedure TWebActionItem_Read_Name(var Value: Variant; Args: TArgs);
begin
  Value := TWebActionItem(Args.Obj).Name;
end;

{ property Write Name(Value: string) }
procedure TWebActionItem_Write_Name(const Value: Variant; Args: TArgs);
begin
  TWebActionItem(Args.Obj).Name := Value;
end;

{ property Read PathInfo: string }
procedure TWebActionItem_Read_PathInfo(var Value: Variant; Args: TArgs);
begin
  Value := TWebActionItem(Args.Obj).PathInfo;
end;

{ property Write PathInfo(Value: string) }
procedure TWebActionItem_Write_PathInfo(const Value: Variant; Args: TArgs);
begin
  TWebActionItem(Args.Obj).PathInfo := Value;
end;

{$IFDEF RA_D5H}
{ property Read Producer: TCustomContentProducer }
procedure TWebActionItem_Read_Producer(var Value: Variant; Args: TArgs);
begin
  Value := O2V(TWebActionItem(Args.Obj).Producer);
end;

{ property Write Producer(Value: TCustomContentProducer) }
procedure TWebActionItem_Write_Producer(const Value: Variant; Args: TArgs);
begin
  TWebActionItem(Args.Obj).Producer := V2O(Value) as TCustomContentProducer;
end;
{$ENDIF RA_D5H}

  { TWebDispatcher }

{ function DosPathToUnixPath(const Path: string): string; }
procedure RAI2_DosPathToUnixPath(var Value: Variant; Args: TArgs);
begin
  Value := DosPathToUnixPath(Args.Values[0]);
end;

{ function HTTPDecode(const AStr: String): string; }
procedure RAI2_HTTPDecode(var Value: Variant; Args: TArgs);
begin
  Value := HTTPDecode(Args.Values[0]);
end;

{ function HTTPEncode(const AStr: String): string; }
procedure RAI2_HTTPEncode(var Value: Variant; Args: TArgs);
begin
  Value := HTTPEncode(Args.Values[0]);
end;

{ function ParseDate(const DateStr: string): TDateTime; }
procedure RAI2_ParseDate(var Value: Variant; Args: TArgs);
begin
  Value := ParseDate(Args.Values[0]);
end;

{ function StatusString(StatusCode: Integer): string; }
procedure RAI2_StatusString(var Value: Variant; Args: TArgs);
begin
  Value := StatusString(Args.Values[0]);
end;

{ function UnixPathToDosPath(const Path: string): string; }
procedure RAI2_UnixPathToDosPath(var Value: Variant; Args: TArgs);
begin
  Value := UnixPathToDosPath(Args.Values[0]);
end;

{ function MonthStr(DateTime: TDateTime): string; }
procedure RAI2_MonthStr(var Value: Variant; Args: TArgs);
begin
  Value := MonthStr(Args.Values[0]);
end;

{ function DayOfWeekStr(DateTime: TDateTime): string; }
procedure RAI2_DayOfWeekStr(var Value: Variant; Args: TArgs);
begin
  Value := DayOfWeekStr(Args.Values[0]);
end;


procedure RegisterRAI2Adapter(RAI2Adapter: TRAI2Adapter);
begin
  with RAI2Adapter do
  begin
   { TWebRequest }
    AddClass('httpapp', TWebRequest, 'TWebRequest');
    AddGet(TWebRequest, 'ReadClient', TWebRequest_ReadClient, 2, [varEmpty or varByRef, varInteger]);
    AddGet(TWebRequest, 'ReadString', TWebRequest_ReadString, 1, [varInteger]);
    AddGet(TWebRequest, 'TranslateURI', TWebRequest_TranslateURI, 1, [varString]);
    AddGet(TWebRequest, 'WriteClient', TWebRequest_WriteClient, 2, [varEmpty or varByRef, varInteger]);
    AddGet(TWebRequest, 'WriteString', TWebRequest_WriteString, 1, [varString]);
    AddGet(TWebRequest, 'ExtractContentFields', TWebRequest_ExtractContentFields, 1, [varObject]);
    AddGet(TWebRequest, 'ExtractCookieFields', TWebRequest_ExtractCookieFields, 1, [varObject]);
    AddGet(TWebRequest, 'ExtractQueryFields', TWebRequest_ExtractQueryFields, 1, [varObject]);
    AddGet(TWebRequest, 'GetFieldByName', TWebRequest_GetFieldByName, 1, [varString]);
    AddGet(TWebRequest, 'MethodType', TWebRequest_Read_MethodType, 0, [0]);
    AddGet(TWebRequest, 'ContentFields', TWebRequest_Read_ContentFields, 0, [0]);
    AddGet(TWebRequest, 'CookieFields', TWebRequest_Read_CookieFields, 0, [0]);
    AddGet(TWebRequest, 'QueryFields', TWebRequest_Read_QueryFields, 0, [0]);
    AddGet(TWebRequest, 'Method', TWebRequest_Read_Method, 0, [0]);
    AddGet(TWebRequest, 'ProtocolVersion', TWebRequest_Read_ProtocolVersion, 0, [0]);
    AddGet(TWebRequest, 'URL', TWebRequest_Read_URL, 0, [0]);
    AddGet(TWebRequest, 'Query', TWebRequest_Read_Query, 0, [0]);
    AddGet(TWebRequest, 'PathInfo', TWebRequest_Read_PathInfo, 0, [0]);
    AddGet(TWebRequest, 'PathTranslated', TWebRequest_Read_PathTranslated, 0, [0]);
    AddGet(TWebRequest, 'Authorization', TWebRequest_Read_Authorization, 0, [0]);
    AddGet(TWebRequest, 'CacheControl', TWebRequest_Read_CacheControl, 0, [0]);
    AddGet(TWebRequest, 'Cookie', TWebRequest_Read_Cookie, 0, [0]);
    AddGet(TWebRequest, 'Date', TWebRequest_Read_Date, 0, [0]);
    AddGet(TWebRequest, 'Accept', TWebRequest_Read_Accept, 0, [0]);
    AddGet(TWebRequest, 'From', TWebRequest_Read_From, 0, [0]);
    AddGet(TWebRequest, 'Host', TWebRequest_Read_Host, 0, [0]);
    AddGet(TWebRequest, 'IfModifiedSince', TWebRequest_Read_IfModifiedSince, 0, [0]);
    AddGet(TWebRequest, 'Referer', TWebRequest_Read_Referer, 0, [0]);
    AddGet(TWebRequest, 'UserAgent', TWebRequest_Read_UserAgent, 0, [0]);
    AddGet(TWebRequest, 'ContentEncoding', TWebRequest_Read_ContentEncoding, 0, [0]);
    AddGet(TWebRequest, 'ContentType', TWebRequest_Read_ContentType, 0, [0]);
    AddGet(TWebRequest, 'ContentLength', TWebRequest_Read_ContentLength, 0, [0]);
    AddGet(TWebRequest, 'ContentVersion', TWebRequest_Read_ContentVersion, 0, [0]);
    AddGet(TWebRequest, 'Content', TWebRequest_Read_Content, 0, [0]);
    AddGet(TWebRequest, 'Connection', TWebRequest_Read_Connection, 0, [0]);
    AddGet(TWebRequest, 'DerivedFrom', TWebRequest_Read_DerivedFrom, 0, [0]);
    AddGet(TWebRequest, 'Expires', TWebRequest_Read_Expires, 0, [0]);
    AddGet(TWebRequest, 'Title', TWebRequest_Read_Title, 0, [0]);
    AddGet(TWebRequest, 'RemoteAddr', TWebRequest_Read_RemoteAddr, 0, [0]);
    AddGet(TWebRequest, 'RemoteHost', TWebRequest_Read_RemoteHost, 0, [0]);
    AddGet(TWebRequest, 'ScriptName', TWebRequest_Read_ScriptName, 0, [0]);
    AddGet(TWebRequest, 'ServerPort', TWebRequest_Read_ServerPort, 0, [0]);
   { TCookie }
    AddClass('httpapp', TCookie, 'TCookie');
    AddGet(TCookie, 'Create', TCookie_Create, 1, [varObject]);
    AddGet(TCookie, 'AssignTo', TCookie_AssignTo, 1, [varObject]);
    AddGet(TCookie, 'Name', TCookie_Read_Name, 0, [0]);
    AddSet(TCookie, 'Name', TCookie_Write_Name, 0, [0]);
    AddGet(TCookie, 'Value', TCookie_Read_Value, 0, [0]);
    AddSet(TCookie, 'Value', TCookie_Write_Value, 0, [0]);
    AddGet(TCookie, 'Domain', TCookie_Read_Domain, 0, [0]);
    AddSet(TCookie, 'Domain', TCookie_Write_Domain, 0, [0]);
    AddGet(TCookie, 'Path', TCookie_Read_Path, 0, [0]);
    AddSet(TCookie, 'Path', TCookie_Write_Path, 0, [0]);
    AddGet(TCookie, 'Expires', TCookie_Read_Expires, 0, [0]);
    AddSet(TCookie, 'Expires', TCookie_Write_Expires, 0, [0]);
    AddGet(TCookie, 'Secure', TCookie_Read_Secure, 0, [0]);
    AddSet(TCookie, 'Secure', TCookie_Write_Secure, 0, [0]);
    AddGet(TCookie, 'HeaderValue', TCookie_Read_HeaderValue, 0, [0]);
   { TWebResponse }
    AddClass('httpapp', TWebResponse, 'TWebResponse');
    AddGet(TWebResponse, 'GetCustomHeader', TWebResponse_GetCustomHeader, 1, [varString]);
    AddGet(TWebResponse, 'SendResponse', TWebResponse_SendResponse, 0, [0]);
    AddGet(TWebResponse, 'SendRedirect', TWebResponse_SendRedirect, 1, [varString]);
    AddGet(TWebResponse, 'SendStream', TWebResponse_SendStream, 1, [varObject]);
    AddGet(TWebResponse, 'Sent', TWebResponse_Sent, 0, [0]);
    AddGet(TWebResponse, 'SetCookieField', TWebResponse_SetCookieField, 5, [varObject, varString, varString, varEmpty, varBoolean]);
    AddGet(TWebResponse, 'SetCustomHeader', TWebResponse_SetCustomHeader, 2, [varString, varString]);
    AddGet(TWebResponse, 'Cookies', TWebResponse_Read_Cookies, 0, [0]);
    AddGet(TWebResponse, 'HTTPRequest', TWebResponse_Read_HTTPRequest, 0, [0]);
    AddGet(TWebResponse, 'Version', TWebResponse_Read_Version, 0, [0]);
    AddSet(TWebResponse, 'Version', TWebResponse_Write_Version, 0, [0]);
    AddGet(TWebResponse, 'ReasonString', TWebResponse_Read_ReasonString, 0, [0]);
    AddSet(TWebResponse, 'ReasonString', TWebResponse_Write_ReasonString, 0, [0]);
    AddGet(TWebResponse, 'Server', TWebResponse_Read_Server, 0, [0]);
    AddSet(TWebResponse, 'Server', TWebResponse_Write_Server, 0, [0]);
    AddGet(TWebResponse, 'WWWAuthenticate', TWebResponse_Read_WWWAuthenticate, 0, [0]);
    AddSet(TWebResponse, 'WWWAuthenticate', TWebResponse_Write_WWWAuthenticate, 0, [0]);
    AddGet(TWebResponse, 'Realm', TWebResponse_Read_Realm, 0, [0]);
    AddSet(TWebResponse, 'Realm', TWebResponse_Write_Realm, 0, [0]);
    AddGet(TWebResponse, 'Allow', TWebResponse_Read_Allow, 0, [0]);
    AddSet(TWebResponse, 'Allow', TWebResponse_Write_Allow, 0, [0]);
    AddGet(TWebResponse, 'Location', TWebResponse_Read_Location, 0, [0]);
    AddSet(TWebResponse, 'Location', TWebResponse_Write_Location, 0, [0]);
    AddGet(TWebResponse, 'ContentEncoding', TWebResponse_Read_ContentEncoding, 0, [0]);
    AddSet(TWebResponse, 'ContentEncoding', TWebResponse_Write_ContentEncoding, 0, [0]);
    AddGet(TWebResponse, 'ContentType', TWebResponse_Read_ContentType, 0, [0]);
    AddSet(TWebResponse, 'ContentType', TWebResponse_Write_ContentType, 0, [0]);
    AddGet(TWebResponse, 'ContentVersion', TWebResponse_Read_ContentVersion, 0, [0]);
    AddSet(TWebResponse, 'ContentVersion', TWebResponse_Write_ContentVersion, 0, [0]);
    AddGet(TWebResponse, 'DerivedFrom', TWebResponse_Read_DerivedFrom, 0, [0]);
    AddSet(TWebResponse, 'DerivedFrom', TWebResponse_Write_DerivedFrom, 0, [0]);
    AddGet(TWebResponse, 'Title', TWebResponse_Read_Title, 0, [0]);
    AddSet(TWebResponse, 'Title', TWebResponse_Write_Title, 0, [0]);
    AddGet(TWebResponse, 'StatusCode', TWebResponse_Read_StatusCode, 0, [0]);
    AddSet(TWebResponse, 'StatusCode', TWebResponse_Write_StatusCode, 0, [0]);
    AddGet(TWebResponse, 'ContentLength', TWebResponse_Read_ContentLength, 0, [0]);
    AddSet(TWebResponse, 'ContentLength', TWebResponse_Write_ContentLength, 0, [0]);
    AddGet(TWebResponse, 'Date', TWebResponse_Read_Date, 0, [0]);
    AddSet(TWebResponse, 'Date', TWebResponse_Write_Date, 0, [0]);
    AddGet(TWebResponse, 'Expires', TWebResponse_Read_Expires, 0, [0]);
    AddSet(TWebResponse, 'Expires', TWebResponse_Write_Expires, 0, [0]);
    AddGet(TWebResponse, 'LastModified', TWebResponse_Read_LastModified, 0, [0]);
    AddSet(TWebResponse, 'LastModified', TWebResponse_Write_LastModified, 0, [0]);
    AddGet(TWebResponse, 'Content', TWebResponse_Read_Content, 0, [0]);
    AddSet(TWebResponse, 'Content', TWebResponse_Write_Content, 0, [0]);
    AddGet(TWebResponse, 'ContentStream', TWebResponse_Read_ContentStream, 0, [0]);
    AddSet(TWebResponse, 'ContentStream', TWebResponse_Write_ContentStream, 0, [0]);
    AddGet(TWebResponse, 'LogMessage', TWebResponse_Read_LogMessage, 0, [0]);
    AddSet(TWebResponse, 'LogMessage', TWebResponse_Write_LogMessage, 0, [0]);
    AddGet(TWebResponse, 'CustomHeaders', TWebResponse_Read_CustomHeaders, 0, [0]);
    AddSet(TWebResponse, 'CustomHeaders', TWebResponse_Write_CustomHeaders, 0, [0]);
   { TWebActionItem }
    AddClass('httpapp', TWebActionItem, 'TWebActionItem');
    AddGet(TWebActionItem, 'Create', TWebActionItem_Create, 1, [varObject]);
    AddGet(TWebActionItem, 'AssignTo', TWebActionItem_AssignTo, 1, [varObject]);
    AddGet(TWebActionItem, 'Default', TWebActionItem_Read_Default, 0, [0]);
    AddSet(TWebActionItem, 'Default', TWebActionItem_Write_Default, 0, [0]);
    AddGet(TWebActionItem, 'Enabled', TWebActionItem_Read_Enabled, 0, [0]);
    AddSet(TWebActionItem, 'Enabled', TWebActionItem_Write_Enabled, 0, [0]);
    AddGet(TWebActionItem, 'MethodType', TWebActionItem_Read_MethodType, 0, [0]);
    AddSet(TWebActionItem, 'MethodType', TWebActionItem_Write_MethodType, 0, [0]);
    AddGet(TWebActionItem, 'Name', TWebActionItem_Read_Name, 0, [0]);
    AddSet(TWebActionItem, 'Name', TWebActionItem_Write_Name, 0, [0]);
    AddGet(TWebActionItem, 'PathInfo', TWebActionItem_Read_PathInfo, 0, [0]);
    AddSet(TWebActionItem, 'PathInfo', TWebActionItem_Write_PathInfo, 0, [0]);
   {$IFDEF RA_D5H}
    AddGet(TWebActionItem, 'Producer', TWebActionItem_Read_Producer, 0, [0]);
    AddSet(TWebActionItem, 'Producer', TWebActionItem_Write_Producer, 0, [0]);
   {$ENDIF RA_D5H}
   { TWebDispatcher }
    AddClass('httpapp', TWebDispatcher, 'TWebDispatcher');
    AddFun('httpapp', 'DosPathToUnixPath', RAI2_DosPathToUnixPath, 1, [varString]);
    AddFun('httpapp', 'HTTPDecode', RAI2_HTTPDecode, 1, [varString]);
    AddFun('httpapp', 'HTTPEncode', RAI2_HTTPEncode, 1, [varString]);
    AddFun('httpapp', 'ParseDate', RAI2_ParseDate, 1, [varString]);
    AddFun('httpapp', 'StatusString', RAI2_StatusString, 1, [varInteger]);
    AddFun('httpapp', 'UnixPathToDosPath', RAI2_UnixPathToDosPath, 1, [varString]);
    AddFun('httpapp', 'MonthStr', RAI2_MonthStr, 1, [varEmpty]);
    AddFun('httpapp', 'DayOfWeekStr', RAI2_DayOfWeekStr, 1, [varEmpty]);
  end;    { with }
end;    { RegisterRAI2Adapter }

end.
