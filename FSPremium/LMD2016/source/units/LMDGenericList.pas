unit LMDGenericList;
{$I lmdcmps.INC}

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

LMDGenericList unit (RM)
------------------------

Changes
-------
Release 8.0 (July 2006)
 - Initial Release

###############################################################################}

interface

uses
  Windows, SysUtils, Classes, Consts, Controls, LMDCustomContainer;

type

  {------------------------- TLMDGenericListItem ------------------------------}
  TLMDGenericListItem = class(TLMDListItem)
  private
    FMemoryStream:TMemoryStream;
    FFilename:String;
  protected
    procedure DefineProperties(Filer: TFiler);override;
    function  GetEmpty:Boolean;override;
    procedure ReadData(Stream:TStream);override;
    procedure WriteData(Stream:TStream);override;
    function  WriteFlag:Byte; override;
  public
    constructor Create(AOwner:TComponent);override;
    destructor Destroy;override;
    procedure Assign(Source: TPersistent); override;
    procedure FreeData; override;
    procedure LoadFromFile(FileName:String);
    procedure SaveToFile(FileName:String );
    procedure LoadFromStream(Stream:TStream);
    procedure SaveToStream(Stream:TStream);
    function SaveToTempFile:String;
    property Data:TMemoryStream read FMemoryStream;
    property Compressed;
    property Description;
    property Ident;

    //introduced
    property FileName:String read FFilename;
  end;

  {------------------------- TLMDGenericList ----------------------------------}
  TLMDGenericList=class(TLMDCustomContainer)
  private
    function GetArrayItem(index:Integer):TLMDGenericListItem;
    function GetArrayNameItem(Index:String):TLMDGenericListItem;
  protected
  public
    constructor Create(AOwner:TComponent);override;
    property Items[Index:Integer]:TLMDGenericListItem read GetArrayItem;default;
    property ItemByName[Index:String]:TLMDGenericListItem read GetArrayNameItem;
  published
    property DefaultCompressed;
  end;

implementation
uses
  LMDClass, LMDStrings, LMDStreamUtils, LMDProcs, LMDSysIn;

{************************ Class TLMDGenericListItem ******************************}
{------------------------- Private---------------------------------------------}
{procedure TLMDGenericListItem.SetFileName(aValue:String);
begin
end;

{-------------------------- Protected -----------------------------------------}
procedure TLMDGenericListItem.Assign(Source: TPersistent);
begin
  if (Source is TLMDGenericListItem) then
    with  TLMDGenericListItem(Source) do
      begin
        self.FIdent:=Ident;
        self.FFilename:=Filename;
        self.FDescription:=Description;
        self.FCompressed:=Compressed;
        self.FMemoryStream.LoadFromStream(Data);
      exit;
    end;
  inherited Assign(Source);
end;

{------------------------------------------------------------------------------}
procedure TLMDGenericListItem.DefineProperties(Filer: TFiler);
begin
  inherited DefineProperties(Filer);
  Filer.DefineBinaryProperty(IDS_INTERNAL, ReadData, WriteData, True);
end;

{------------------------------------------------------------------------------}
function  TLMDGenericListItem.GetEmpty:Boolean;
begin
  result:=FMemoryStream.Size=0;
end;

{------------------------------------------------------------------------------}
procedure TLMDGenericListItem.ReadData(Stream:TStream);
var
  fSize:LongInt;
  tmp:TMemoryStream;
begin
  if ReadStd(Stream) AND ITF_DATA=ITF_DATA then
    begin
      if FCompressed then
       begin
         tmp:=TMemoryStream.Create;
         try
           LMDLoadCompressedStream(Stream, tmp);
           tmp.Position:=0;
           FMemoryStream.LoadFromStream(tmp);
         finally
           tmp.Free;
         end;
       end
      else
        begin
          fSize:=stReadInteger(Stream);
          FMemoryStream.SetSize(fsize);
          Stream.ReadBuffer(FMemoryStream.Memory^, fSize);
          end;
    end
  else
    FMemoryStream.Free;
  FFilename := String(LMDAnsiStreamToString(Stream, stReadByte(Stream)));
end;

{------------------------------------------------------------------------------}
procedure TLMDGenericListItem.WriteData(Stream:TStream);
var
  fsize:LongInt;
begin
  FMemoryStream.Position := 0;
  WriteStd(Stream);
  if not Empty then
    if FCompressed then
      LMDSaveCompressedStream(FMemoryStream, Stream, FMemoryStream.Size)
    else
      begin
        fSize:=FMemoryStream.Size;
        stWriteInteger(Stream, fsize);
        Stream.WriteBuffer(FMemoryStream.Memory^, fSize);
        end;
//  stWriteString(Stream, FFilename);
  stWriteByte(Stream, Length(FFilename));
  LMDAnsiStringToStream(AnsiString(FFilename), Stream);
end;

{------------------------------------------------------------------------------}
function TLMDGenericListItem.WriteFlag:Byte;
begin
  result:=inherited WriteFlag;
  if not Empty then result:=result or ITF_DATA;
end;

{-------------------------- Public --------------------------------------------}
constructor TLMDGenericListItem.Create(aOwner:TComponent);
begin
  inherited Create(aOwner);
  FMemoryStream:=TMemoryStream.Create;
end;

{------------------------------------------------------------------------------}
Destructor TLMDGenericListItem.Destroy;
begin
  FMemoryStream.Free;
  inherited Destroy;
end;

{------------------------------------------------------------------------------}
procedure TLMDGenericListItem.FreeData;
begin
  FMemoryStream.Clear;
  FFilename:='';
end;

{------------------------------------------------------------------------------}
procedure TLMDGenericListItem.LoadFromFile(FileName:String);
begin
  if FileExists(FileName) and not (FileName='') then
    begin
      FMemoryStream.LoadFromFile(FileName);
      FFilename:=ExtractFileName(Filename);
    end
  else
    FreeData;
end;

{------------------------------------------------------------------------------}
procedure TLMDGenericListItem.SaveToFile(FileName:String);
begin
  FMemoryStream.SaveToFile(FileName);
end;

{------------------------------------------------------------------------------}
procedure TLMDGenericListItem.LoadFromStream(Stream:TStream);
begin
  FMemoryStream.LoadFromStream(Stream);
end;

{------------------------------------------------------------------------------}
procedure TLMDGenericListItem.SaveToStream(Stream:TStream);
begin
  FMemoryStream.SaveToStream(Stream);
end;

{------------------------------------------------------------------------------}
function TLMDGenericListItem.SaveToTempFile:String;
begin
  result:=LMDSITempFile;
  if result<>'' then SaveToFile(result);
end;

{************************ Class TLMDGenericList *******************************}
{------------------------- Private---------------------------------------------}
function TLMDGenericList.GetArrayItem(index:Integer):TLMDGenericListItem;
begin
  result:=TLMDGenericListItem(Contents[Index]);
end;

{------------------------------------------------------------------------------}
function TLMDGenericList.GetArrayNameItem(Index:String):TLMDGenericListItem;
begin
  result:=TLMDGenericListItem(ContentsByName[index]);
end;

{-------------------------- Public --------------------------------------------}
constructor TLMDGenericList.Create(AOwner:TComponent);
begin
  inherited Create(AOwner);
  FListClass:=TLMDGenericListItem;
  FListType:=icGeneric;

  if not LMD_ICRegistered[FListType] then
    begin
      LMD_ICRegistered[FListType]:=True;
      RegisterClass(TLMDGenericListItem);
    end;

end;

end.
