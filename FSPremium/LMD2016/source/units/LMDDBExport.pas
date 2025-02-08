unit LMDDBExport;
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

LMDDBExport unit ()
-------------------

Changes
-------
Release 8.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Classes,
  DB,
  LMDCustomComponent;

type
  TLMDConverterEvent = procedure (Sender : TObject; var eventText : String) of object;
  TLMDExportImageEvent = procedure (Sender : TObject; var S : String; RecNo : Integer; val : TMemoryStream) of object;
  TLMDExportUnknownEvent = procedure (Sender : TObject; var S : String; RecNo : Integer; field : TBlobField) of object;

  TLMDExportImage = (eiNo, eiFile, eiData, eiCustom);
  TLMDConverterOutput = (coPlain, coHTML, coHTMLTable);

  TLMDDBExport = class (TLMDCustomComponent)
  private
    FDataLink        : TDataLink;
    //FFieldType       : Boolean;
    //FFieldNames      : Boolean;
    FRecordDelimiter,
    FDelimiter       : String;
    FOnHeader,
    FOnRecord,
    FOnDataHeader,
    FOnData          : TLMDConverterEvent;
    FOutStart,
    FOutEnd,
    FDataStart,
    FDataEnd,
    FFieldStart,
    FFieldEnd,
    FRecordStart,
    FRecordEnd       : String;
    FMode            : Byte;
    FExportImages    : TLMDExportImage;
    FConverterOut    : TLMDConverterOutput;
    FOnExportImage   : TLMDExportImageEvent;
    FOnExportUnknown : TLMDExportUnknownEvent;

    procedure SetDataSource (aValue : TDataSource);
    function GetDatasource : TDataSource;
  protected
    function getFieldCount : Integer;
    function getField(Index : Integer) : TField;
    function getFieldName(Index : Integer) : String;
    function getFieldString(Index : Integer; RecNo : Integer) : String;
    function exportImage (Field : TBlobField; RecNo : Integer) : String;

    function getRecordStart : String; virtual;
    function getRecordEnd : String; virtual;
    function getFieldStart : String;
    function getFieldEnd : String;
    function getDataHeader : String; virtual;
    function getDataStart : String; virtual;
    function getDataEnd : String; virtual;
    function getOutStart : String;
    function getOutEnd : String;

    function getRecord(RecNo : Integer) : String; virtual;

    procedure First;
    procedure Next;

    procedure WriteToStream (Stream : TStream); virtual;
    procedure WriteToFile (filename : String); virtual;
    procedure WriteToStringList (var stringlist : TStrings); virtual;

    procedure InitOutput;

    property Mode : Byte read FMode;

    property RecordStart : String read FRecordStart write FRecordStart;
    property RecordEnd : String read FRecordEnd write FRecordEnd;
    property FieldStart : String read FFieldStart write FFieldStart;
    property FieldEnd : String read FFieldEnd write FFieldEnd;
    property DataStart : String read FDataStart write FDataStart;
    property DataEnd : String read FDataEnd write FDataEnd;
    property OutStart : String read FOutStart write FOutStart;
    property OutEnd : String read FOutEnd write FOutEnd;
  public
    procedure Notification (AComponent : TComponent;Operation : TOperation); override;
    constructor Create (aOwner : TComponent); override;
    destructor Destroy; override;

    procedure SaveToStream (Stream : TStream); virtual;
    procedure SaveToFile (filename : String); virtual;
    procedure SaveToStringList (var stringlist : TStrings); virtual;

  published
    property About;
    property DataSource : TDataSource read GetDataSource write SetDataSource;

    property Delimiter : String read FDelimiter write FDelimiter;
    property ExportImages : TLMDExportImage read FExportImages write FExportImages default eiNo;
    property RecordDelimiter : String read FRecordDelimiter write FRecordDelimiter;
    property Output : TLMDConverterOutput read FConverterOut write FConverterOut default coPlain;

    property OnDataHeader : TLMDConverterEvent read FOnDataHeader write FOnDataHeader;
    property OnHeader : TLMDConverterEvent read FOnHeader write FOnHeader;    
    property OnData : TLMDConverterEvent read FOnData write FOnData;
    property OnRecord : TLMDConverterEvent read FOnRecord write FOnRecord;
    property OnExportImage : TLMDExportImageEvent read FOnExportImage write FOnExportImage;
    property OnExportUnknown : TLMDExportUnKnownEvent read FOnExportUnknown write FOnExportUnknown;
  end;

implementation

uses
  SysUtils, Graphics,
  LMDProcs, LMDStrings;

{ ------------------------------ private ------------------------------------- }
procedure TLMDDBExport.SetDataSource(aValue:TDataSource);
begin
  if aValue<>FDataLink.DataSource then
    FDataLink.DataSource:=aValue;
  if aValue <> nil then aValue.FreeNotification(Self);
end;

{ ---------------------------------------------------------------------------- }
function TLMDDBExport.GetDataSource:TDataSource;
begin
  result:=FDataLink.DataSource
end;

{ ----------------------- protected ------------------------------------------ }
function TLMDDBExport.getFieldCount : Integer;
begin
  result:=FDataLink.DataSet.FieldCount;
end;

{ ---------------------------------------------------------------------------- }
function TLMDDBExport.getField(Index : Integer) : TField;
begin
  result:=FDataLink.DataSet.Fields[Index];
end;

{ ---------------------------------------------------------------------------- }
function TLMDDBExport.exportImage (Field : TBlobField; RecNo : Integer) : String;
var
  dataStream : TMemoryStream;
  dataPic    : TPicture;
begin
  result := 'Pic';
  if (FExportImages = eiCustom) and Assigned (FOnExportImage) then
    begin
      dataStream := TMemoryStream.Create;
      try
        Field.SaveToStream (dataStream);
        FOnExportImage (self, result, RecNo, dataStream)
      finally
        dataStream.Free;
      end;
    end
  else
    begin
      dataPic := TPicture.Create;
      try
        dataPic.Assign (Field);
        dataPic.SaveToFile ('img'+IntToStr(RecNo));
      finally
        dataPic.Free;
      end;
    end;
end;

{ ---------------------------------------------------------------------------- }
function TLMDDBExport.getFieldString(Index, RecNo : Integer) : String;
var
  currentfield : TField;
begin
  result := '';
  currentField := getField(index);

  if (not currentField.isBlob) then
    result := currentField.AsString
  else
    case TBlobField(currentField).BlobType of
      ftMemo : result := currentField.AsString;
      ftGraphic : case FExportImages of
                    eiNo :;
                    eiData : result := currentField.AsString;
                    eiCustom,
                    eiFile : result := exportImage (TBlobField (currentField), RecNo);
                  end;
      else
        if Assigned (FOnExportUnKnown) then FOnExportUnKnown (self, result, RecNo, TBlobField (currentField));
    end;
  result := getFieldStart + result + getFieldEnd;
end;

{ ---------------------------------------------------------------------------- }
function TLMDDBExport.getFieldName(Index : Integer) : String;
begin
  result:=FDataLink.DataSet.Fields[Index].FieldName;
end;

{ ---------------------------------------------------------------------------- }
function TLMDDBExport.getRecordStart : String;
begin
  result := FRecordStart;
end;

{ ---------------------------------------------------------------------------- }
function TLMDDBExport.getRecordEnd : String;
begin
  result := FRecordEnd;
end;

{ ---------------------------------------------------------------------------- }
function TLMDDBExport.getFieldStart : String;
begin
  result := FFieldStart;
end;

{ ---------------------------------------------------------------------------- }
function TLMDDBExport.getFieldEnd : String;
begin
  result := FFieldEnd;
end;

{ ---------------------------------------------------------------------------- }
function TLMDDBExport.getDataHeader : String;
var
  i : Integer;
begin
  result := getRecordStart;
  case FConverterOut of
    coHTML,
    coPlain : for i := 0 to getFieldCount - 1 do
{                 if result = '' then
                   result := getFieldName (i)
                 else}
                   result := result + getFieldStart + getFieldName (i) + getFieldEnd;
    coHTMLTable :
              begin
                for i := 0 to getFieldCount - 1 do
                   result := result + getFieldStart + getFieldName(i) + getFieldEnd;
              end;
  end;
  result := result + getRecordEnd;  
  if Assigned (FOnDataHeader) then FOnDataHeader (self, result);
end;

{ ---------------------------------------------------------------------------- }
function TLMDDBExport.getDataStart : String;
begin
  result := FDataStart;
end;

{ ---------------------------------------------------------------------------- }
function TLMDDBExport.getDataEnd : String;
begin
  result := FDataEnd;
end;

{ ---------------------------------------------------------------------------- }
function TLMDDBExport.getOutStart : String;
begin
  result := FOutStart;
  //call event (if anyone wants to add a headline for a html file e.g.)
  if Assigned (FOnHeader) then FOnHeader (self, result);
end;

{ ---------------------------------------------------------------------------- }
function TLMDDBExport.getOutEnd : String;
begin
  result := FOutEnd;
end;

{ ---------------------------------------------------------------------------- }
function TLMDDBExport.getRecord(RecNo : Integer) : String;
var
  i : Integer;
begin
  result := '';
  for i := 0 to getFieldCount - 1 do
     result := result + getFieldString (i, RecNo);
  result := getRecordStart + result + getRecordEnd;
  //record string can be changed by user (be careful: do not delete record start/end tags)
  if Assigned (FOnRecord) then FOnRecord (self, result);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDBExport.First;
begin
  //just go to the first record of the dataset
  FDataLink.DataSet.First;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDBExport.Next;
begin
  //get to the next record
  FDataLink.DataSet.Next;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDBExport.WriteToStream (Stream : TStream);
var
  s : String;
  r : Integer;

  procedure write (const Str : String);
  begin
    LMDAnsiStringToStream(Str, Stream);
  end;

begin
  FMode := 1;
  First;

  write(getOutStart);

  //get data start chars
  s := getDataStart;
  if Assigned (FOnData) then FOnData (self, s);
  write (s);

  write(getDataHeader);

  //step through all records
  r := 0;
  while not FDataLink.DataSet.EOF do
    begin
      //get record string
      write(getRecord(r));
      //next record
      inc(r);
      next;
    end;

  write(getDataEnd);

  write (getOutEnd);

  FMode := 0;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDBExport.WriteToFile (filename : String);
var
  f : TFileStream;
begin
  f := TFileStream.Create (filename, fmCreate);
  try
    WriteToStream (f);
  finally
    f.Free;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDBExport.WriteToStringList (var stringlist : TStrings); 
var
  s : String;
  r : Integer;

  procedure write (const Str : String);
  begin
    if Str <> '' then
      stringList.Add (Str);
  end;

begin
  FMode := 2;
  First;

  write(getOutStart);

  s := getDataStart;
  if Assigned (FOnData) then FOnData (self, s);
  write (s);

  write(getDataHeader);

  //step through all records
  r := 0;
  while not FDataLink.DataSet.EOF do
    begin
      //get and write record string
      write(getRecord(r));
      //next record
      inc(r);
      next;
    end;

  write(getDataEnd);

  write (getOutEnd);

  FMode := 0;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDBExport.InitOutput;
begin
  case FConverterOut of
    coPlain : begin
                RecordStart := '';
                RecordEnd := RecordDelimiter;
                FieldStart := '';
                FieldEnd := Delimiter;
                DataStart := '';
                DataEnd := '';
                OutStart := '';
                OutEnd := '';
              end;
    coHTML  : begin
                RecordStart := '';
                RecordEnd := RecordDelimiter;
                FieldStart := '';
                FieldEnd := Delimiter;
                DataStart := '<body>';
                DataEnd := '</body>';
                OutStart := '<html>';
                OutEnd := '</html>';
              end;
    coHTMLTable :
              begin
                RecordStart := '<tr>';
                RecordEnd := '</tr>';
                FieldStart := '<td>';
                FieldEnd := '</td>';
                DataStart := '<body><table COL='+IntToStr(getFieldCount)+' BORDER>';
                DataEnd :='</table></body>';
                OutStart := '<html>';
                OutEnd := '</html>';
              end;
  end;
end;

{ ----------------------------- public --------------------------------------- }
procedure TLMDDBExport.Notification (AComponent : TComponent;Operation : TOperation);
begin
  inherited Notification (AComponent, Operation);
  if Operation = opRemove then
    if aComponent = FDataLink.DataSource then
      DataSource := nil;
end;

{ ---------------------------------------------------------------------------- }
constructor TLMDDBExport.Create (aOwner : TComponent);
begin
  inherited Create (aOwner);
  FDataLink := TDataLink.Create;
  FExportImages := eiNo;
  FMode := 0;
  FDelimiter := ';';
  FConverterOut := coPlain;
end;

{ ---------------------------------------------------------------------------- }
destructor TLMDDBExport.Destroy;
begin
  FDataLink.Free;
  inherited Destroy;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDBExport.SaveToStream (Stream : TStream);
begin
  initOutput;
  WriteToStream (Stream);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDBExport.SaveToFile (filename : String);
begin
  initOutput;
  WriteToFile (filename);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDBExport.SaveToStringList (var stringlist : TStrings);
begin
  initOutput;
  WriteToStringList (stringList);
end;

end.
