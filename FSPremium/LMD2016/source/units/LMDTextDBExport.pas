unit LMDTextDBExport;
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

LMDTextDBExport unit (JH)
-------------------------

DB export component Exports records of connected datasource. Export process 
is started by calling one of the SaveToXXX methods. Property Lines contains HTML 
template for export. Reserved words (variable tags): 
~~GETRECORDCOUNT -> returns total count of record 
~~GETRECORDNUMBER -> returns actual record's 
# Usage: HTML template with basic repeat tag .a. 
<repeat count=~~GETRECORDCOUNT> .b. </repeat> .c. .?. (?= a|b|c) 
Can be replaced by any valid HTML tags, .b. can be used for exporting database, 
should contain fields to be exported use <~~name of FieldName> for exporting 
a field

Changes
-------
Release 8.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Classes, Graphics, DB,
  LMDText, LMDTextObject, LMDWriter, LMDCustomComponent;

type
  TLMDConverterEvent = procedure (Sender : TObject; var eventText : String) of object;
  TLMDExportImageEvent = procedure (Sender : TObject; var S : String; RecNo : Integer; val : TMemoryStream) of object;
  TLMDExportUnknownEvent = procedure (Sender : TObject; var S : String; RecNo : Integer; field : TBlobField) of object;

  TLMDExportImage = (eiNo, eiFile, eiData, eiCustom);

  TLMDTextDBExport = class (TLMDCustomComponent)
  private
    FDataLink        : TDataLink;
    FRepDetect       : String;
    FText            : TLMDTextObject;
    FTextWriter      : TLMDWriter;
    FWriterClass     : TLMDWriterClass;
    FLines           : TStrings;
    FFirstRepeat     : Boolean;
    FOnRecord,
    FOnData          : TLMDConverterEvent;
    FMode            : Byte;
    FExportImages    : TLMDExportImage;
    FOnExportImage   : TLMDExportImageEvent;
    FOnExportUnknown : TLMDExportUnknownEvent;
    FOnGetVariable   : TLMDGetVariableEvent;

    procedure SetDataSource (aValue : TDataSource);
    function GetDatasource : TDataSource;
    procedure SetLines(aValue: TStrings);
    function GetWriterClass: String;
    procedure SetWriterClass (aValue: String);
    function IsNotDefault:Boolean;
  protected
    function getFieldCount : Integer;
    function getField(Index : Integer) : TField;
    function getFieldName(Index : Integer) : String;
    function getFieldString(Index : Integer; RecNo : Integer) : String;
    function exportImage (Field : TBlobField; RecNo : Integer) : String;

//    function getRecord(RecNo : Integer) : String; virtual;

    procedure First;
    procedure Next;

    procedure WriteToStream (Stream : TStream); virtual;
    procedure WriteToFile (filename : String); virtual;
    procedure WriteToStringList (var stringlist : TStrings); virtual;

    procedure InitOutput;
    procedure DoGraphicError(Sender: TObject; aPicture: TPicture; const aFileName: String; aImageIndex: LongInt);
    function DoGetVariable(Sender: TObject; const aVarName: string): string;
    procedure DoRepeat(Sender: TObject; aNumber: LongInt);
    property Mode : Byte read FMode;
    procedure Notification (AComponent : TComponent;Operation : TOperation); override;
  public
    constructor Create (aOwner : TComponent); override;
    destructor Destroy; override;

    procedure SaveToStream (Stream : TStream); virtual;
    procedure SaveToFile (filename : String); virtual;
    procedure SaveToStringList (var stringlist : TStrings); virtual;

  published
    property About;
    property DataSource : TDataSource read GetDataSource write SetDataSource;

    //Lines content must be HTML
    property Lines : TStrings read FLines write SetLines;
    property Writer : String read GetWriterClass write SetWriterClass stored IsNotDefault;
    property ExportImages : TLMDExportImage read FExportImages write FExportImages default eiNo;

    property OnData : TLMDConverterEvent read FOnData write FOnData;
    property OnRecord : TLMDConverterEvent read FOnRecord write FOnRecord;
    property OnExportImage : TLMDExportImageEvent read FOnExportImage write FOnExportImage;
    property OnExportUnknown : TLMDExportUnKnownEvent read FOnExportUnknown write FOnExportUnknown;
    property OnGetVariable: TLMDGetVariableEvent read FOnGetVariable write FOnGetVariable;
  end;

implementation

uses
  Forms, SysUtils,
  LMDPlainTextWriter,
  LMDHTMLWriter;

{ ------------------------------ private ------------------------------------- }
procedure TLMDTextDBExport.SetDataSource(aValue:TDataSource);
begin
  if aValue<>FDataLink.DataSource then
    FDataLink.DataSource:=aValue;
  if aValue <> nil then aValue.FreeNotification(Self);
end;

{ ---------------------------------------------------------------------------- }
function TLMDTextDBExport.GetDataSource:TDataSource;
begin
  result:=FDataLink.DataSource
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDTextDBExport.SetLines(aValue: TStrings);
begin
  FLines.Assign (aValue);
end;

{ ---------------------------------------------------------------------------- }
function TLMDTextDBExport.GetWriterClass: string;
begin
  Result:= FWriterClass.ClassName;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDTextDBExport.SetWriterClass (aValue: String);
var
  I: LongInt;
begin
  if not Assigned (FTextWriter) or not AnsiSameText(aValue, FTextWriter.ClassName) then
    begin
      for I:= 0 to Writers.Count - 1 do
        if AnsiSameText(aValue, PLMDWriterRec(Writers[I])^.WriterClass.ClassName) then
        begin
            FreeAndNil(FTextWriter);
            FWriterClass := PLMDWriterRec(Writers[I])^.WriterClass;
            Exit;
          end;
      FWriterClass := DefaultWriterClass;
    end;
end;

{ ---------------------------------------------------------------------------- }
function TLMDTextDBExport.IsNotDefault: Boolean;
begin
  result := FWriterClass <> DefaultWriterClass;
end;

{ ----------------------- protected ------------------------------------------ }
function TLMDTextDBExport.getFieldCount : Integer;
begin
  result:=FDataLink.DataSet.FieldCount;
end;

{ ---------------------------------------------------------------------------- }
function TLMDTextDBExport.getField(Index : Integer) : TField;
begin
  result:=FDataLink.DataSet.Fields[Index];
end;

{ ---------------------------------------------------------------------------- }
function TLMDTextDBExport.exportImage (Field : TBlobField; RecNo : Integer) : String;
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
        result := 'img'+IntToStr(RecNo);
      finally
        dataPic.Free;
      end;
    end;
end;

{ ---------------------------------------------------------------------------- }
function TLMDTextDBExport.getFieldString(Index, RecNo : Integer) : String;
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
end;

{ ---------------------------------------------------------------------------- }
function TLMDTextDBExport.getFieldName(Index : Integer) : String;
begin
  result:=FDataLink.DataSet.Fields[Index].FieldName;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDTextDBExport.First;
begin
  //just go to the first record of the dataset
  FDataLink.DataSet.First;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDTextDBExport.Next;
begin
  if Assigned (FDataLink) and Assigned (FDataLink.DataSet) then
    //get to the next record
    FDataLink.DataSet.Next;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDTextDBExport.WriteToStream (Stream : TStream);
begin
  if FWriterClass = nil then exit;
  FTextWriter:= FWriterClass.Create(Stream);
  FText.ParsedText.Store(FTextWriter)
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDTextDBExport.WriteToFile (filename : String);
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
procedure TLMDTextDBExport.WriteToStringList (var stringlist : TStrings);
var
  m: TMemoryStream;
begin
  m:= TMemoryStream.Create;
  try
    WriteToStream (m);
    m.Position := 0;
    stringlist.LoadFromStream (m);
  finally
    m.Free;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDTextDBExport.InitOutput;
begin
  FText.Parse (FLines);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDTextDBExport.DoGraphicError(Sender: TObject; aPicture: TPicture; const aFileName: String; aImageIndex: LongInt);
var
  f : TField;
begin
  //let's check whether we'll find the variable as field in the database
  if (FDataLink<>nil) and (FDataLink.DataSet <> nil) then
    begin
      f := FDataLink.DataSet.FindField (aFileName);
      if assigned (f) then
        begin
          if f.isBlob then //check whether we have a blob field here
            begin
              aPicture.Assign (f);
              exit;
            end;
        end;
     end;
end;

{ ---------------------------------------------------------------------------- }
function TLMDTextDBExport.DoGetVariable(Sender: TObject; const aVarName: string): string;
var
  f : TField;
begin
  //let's check whether we'll find the variable as field in the database
  if (FDataLink<>nil) and (FDataLink.DataSet <> nil) then
    begin
      if UpperCase(aVarName) = 'GETRECORDCOUNT' then
        begin
          result := IntToStr (FDataLink.DataSet.RecordCount);
          FFirstRepeat := true;
          FRepDetect := '';
          First;
          exit;
        end;
      if UpperCase(aVarName) = 'GETRECORDNUMBER' then
        begin
          result := IntTOStr (FDataLink.DataSet.RecNo);
        end;

      f := FDataLink.DataSet.FindField (aVarName);
      if assigned (f) then
        begin
          if f.isBlob then //check whether we have a blob field here
            if f.DataType = ftGraphic then
              result := aVarName
            else
              result := f.AsString
          else
            result := f.DisplayText;
          exit;
        end;
    end;
  //if not let's call the event
  if assigned (FOnGetVariable) then result := FOnGetVariable (self, aVarName);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDTextDBExport.DoRepeat(Sender: TObject; aNumber: LongInt);
begin
  if not FFirstRepeat then
    Next
  else
    FFirstRepeat := false;
end;

{ ----------------------------- public --------------------------------------- }
procedure TLMDTextDBExport.Notification (AComponent : TComponent;Operation : TOperation);
begin
  inherited Notification (AComponent, Operation);
  if Operation = opRemove then
    if aComponent = DataSource then
      DataSource := nil;
end;

{ ---------------------------------------------------------------------------- }
constructor TLMDTextDBExport.Create (aOwner : TComponent);
begin
  inherited Create (aOwner);
  FDataLink := TDataLink.Create;
  FExportImages := eiNo;
  FMode := 0;
  FLines := TStringList.Create;

  FText  := TLMDTextObject.Create;
  FText.OnGraphicError := DoGraphicError;
  FText.OnGetVariable := DoGetVariable;
  FText.OnRepeat := DoRepeat;
  FText.ParserClass := 'TLMDHTMLParser';
  Writer := '';
end;

{ ---------------------------------------------------------------------------- }
destructor TLMDTextDBExport.Destroy;
begin
  FText.Free;
  FLines.Free;
  FDataLink.Free;
  inherited Destroy;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDTextDBExport.SaveToStream (Stream : TStream);
begin
  initOutput;
  WriteToStream (Stream);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDTextDBExport.SaveToFile (filename : String);
begin
  initOutput;
  WriteToFile (filename);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDTextDBExport.SaveToStringList (var stringlist : TStrings);
begin
  initOutput;
  WriteToStringList (stringList);
end;

end.
