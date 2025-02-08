unit LMDCSVImport;
{$I lmdcmps.inc}

{###############################################################################

LMD VCL Series 2016
© by LMD Innovative
-------------------

For support or information contact us at:

email              : mail@lmdsupport.com
WWW                : http://www.lmdinnovative.com
SupportSite        : http://www.lmdsupport.com
Wiki               : http://wiki.lmd.de
Fax                : ++49 6131 4984372

This code is for reference purposes only and may not be copied
or distributed in any format electronic or otherwise except one
copy for backup purposes.

No Component Kit or Component individually or in a collection,
subclassed or otherwise from the code in this unit, or associated
.pas, .dfm, .dcu, .ocx, .dll or ActiveX files may be sold or
distributed without express permission from LMD Innovative.

For further license information please refer to the associated
license html file in \info folder.

################################################################################

LMDCSVImport unit (JH)
----------------------

Changes
-------
Release 8.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Classes,
  LMDImport;

type
  TLMDOnCSVMissingToken    = procedure (Sender: TObject; tokenNum: Int64; var token: String) of object;
  TLMDOnCSVAdditionalToken = procedure (Sender: TObject; tokenNum: Int64; token: String) of object;
  TLMDOnCSVToken           = procedure (Sender: TObject; var token: String) of object;
  TLMDOnCSVRecord          = procedure (Sender: TObject; recNo: Int64) of object;

  TLMDCSVImport = class (TLMDImport)
  private
    FCurrentRecord    : TStringList;
    FRecordDelimiter,
    FFieldDelimiter   : String;
    FOnMissingToken   : TLMDOnCSVMissingToken;
    FOnAdditionalToken: TLMDOnCSVAdditionalToken;
    FOnToken          : TLMDOnCSVToken;
    FOnProcessRecord  : TLMDOnCSVRecord;
  protected
    function getTokenCount: Int64; virtual; abstract;

    procedure ProcessToken (const aToken: String; aTokenNum: Int64); virtual;
    procedure ProcessTokens; virtual;
    function ProcessRecordStart: Boolean; virtual;
    procedure ProcessRecordEnd; virtual;

    property CurrentRecord: TStringList read FCurrentRecord;
  public
    procedure ImportStream (aStream  : TStream); override;
  published
    property FieldDelimiter : String read FFieldDelimiter write FFieldDelimiter;
    property RecordDelimiter : String read FRecordDelimiter write FRecordDelimiter;
    property OnToken: TLMDOnCSVToken read FOnToken write FOnToken;
    property OnProcessRecord: TLMDOnCSVRecord read FOnProcessRecord write FOnProcessRecord;
    property OnMissingToken   : TLMDOnCSVMissingToken read FOnMissingToken write FOnMissingToken;
    property OnAdditionalToken: TLMDOnCSVAdditionalToken read FOnAdditionalToken write FOnAdditionalToken;

  end;

implementation

uses
  LMDProcs;

{ ---------------------------------------------------------------------------- }
procedure TLMDCSVImport.ProcessToken (const aToken: String; aTokenNum: Int64);
begin
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCSVImport.ProcessTokens;
var
  i: Integer;
begin
  for i := 0 to FCurrentRecord.Count - 1 do
    ProcessToken (FCurrentRecord.Strings[i], i);
end;

{ ---------------------------------------------------------------------------- }
function TLMDCSVImport.ProcessRecordStart:Boolean;
begin
  result := false;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCSVImport.ProcessRecordEnd;
begin
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCSVImport.ImportStream (aStream  : TStream);
var
  ts         : TMemoryStream;
  i          : Integer;
  recNum,
  tokenNum,
  startPos   : Int64;
  s,
  token      : String;
  recordEnd  : Boolean;
  //firstchar,
  sourceend,
  source     : PChar;
  //tVal       : Array[0..024] of char;

  function CheckForDelim (delim: String): Boolean;
  var
    i : Integer;
    h : PChar;
    begin
    result := true;
    i := 1;
    h := Source;
    while Result and (i <= Length (delim)) and (h < sourceend) do
    begin
        result := h^ = delim[i];
        inc(h);
        inc(i);
      end;
    if result then
      begin
        startPos := startPos + i;
        source := h;
      end;
  end;

  function getNextEnd: Int64;
  var
     //help: PChar;
     delimFound: Boolean;
  begin
    token := '';
    result := startPos;
    delimFound := false;
    while not delimFound do
      begin
        while (source^ <> FFieldDelimiter[1]) and
              (source^ <> FRecordDelimiter[1]) and
              (source < sourceend) do
        begin
            token := token + source^;
            inc(source);
            inc(result);
          end;
        if source^ = FFieldDelimiter[1] then
        begin
            delimFound := checkForDelim (FFieldDelimiter);
          end;
        if (source^ = FRecordDelimiter[1]) and not delimFound then
        begin
            delimFound := checkForDelim (FRecordDelimiter);
            recordEnd := true;
          end;
        if not delimFound then
          begin
            delimFound := source >= sourceend;
            end;
      end;
    inc(tokenNum);
  end;

begin
  if FFieldDelimiter = '' then exit;
  if FRecordDelimiter = '' then exit;
  if not BeginImport then exit;
  FCurrentRecord   := TStringList.Create;
  ts := TMemoryStream.Create;
  try
    ts.LoadFromStream(aStream);
    source := PChar (ts.Memory);
    sourceend := source + ts.Size;
    recNum := -1;
    startPos := 0;
    tokenNum := 0;
    recordEnd := true;
    while source < sourceend do
    begin
        if recordEnd then
          begin
            inc(recNum);
            if Assigned(FOnProcessRecord) then FOnProcessRecord (self, recNum);
            tokenNum := 0;
            recordEnd := false;
          end;

        getNextEnd;
//        ts.Seek(startPos, soFromBeginning);
//        startPos := getNextEnd;

//        SetLength (tVal, startPos - ts.Position);
//        ts.ReadBuffer(tVal, startPos - ts.Position);

//        token := String (tVal);

        if Assigned (FOnToken) then FOnToken (self, token);
        FCurrentRecord.Add(token);

        if RecordEnd then
          begin
            if ProcessRecordStart then //new record
              begin
                ProcessTokens;

                //check for any missing tokens - this mean missing token delimiters
                //in one record
                if (FCurrentRecord.Count < getTokenCount) then
                  for i := FCurrentRecord.Count to getTokenCount do
                    begin
                      s := '';
                      //check whether user of component want to get note about
                      //missing token
                      if Assigned (FOnMissingToken) then FOnMissingToken (self, i, s);
                      //add a "token value" for the missing token
                      FCurrentRecord.Add(s);
                    end;

                //check for additional tokens, these are tokens which are in a
                //record but not specified by the csv definition given
                //in a descendant component
                if Assigned (FOnAdditionalToken) and (FCurrentRecord.Count > getTokenCount) then
                  for i := getTokenCount to FCurrentRecord.Count do
                    FOnAdditionalToken (self, i, FCurrentRecord[i]);

                ProcessRecordEnd; //close new record
              end;

            FCurrentRecord.Clear;
          end;
      end;
  finally
    ts.Free;
    FCurrentRecord.Free;
  end;
  DoImportFinished (recNum);
end;

end.
