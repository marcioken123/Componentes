unit LMDWaveList;
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

LMDWaveList unit ()
-------------------

Changes
-------
Release 8.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Windows, SysUtils, Classes, LMDWave, LMDCustomContainer;

type

  {waves}
  {------------------------ Class TLMDWaveListItem ----------------------------}
  TLMDWaveListItem = class(TLMDListItem)
  private
    FWave:TLMDWave;
    procedure SetWave(aValue:TLMDWave);
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
    property Compressed;
  published
    property Wave:TLMDWave read FWave write SetWave stored false;
    property Description;
    property Ident;
  end;

  {------------------------ Class TLMDWaveList --------------------------------}
  TLMDWaveList=class(TLMDCustomContainer)
  private
    function GetArrayItem(index:Integer):TLMDWaveListItem;
    function GetArrayNameItem(Index:String):TLMDWaveListItem;
  protected
  public
    constructor Create(AOwner:TComponent);override;
    property Items[Index:Integer]:TLMDWaveListItem read GetArrayItem;default;
    property ItemByName[Index:String]:TLMDWaveListItem read GetArrayNameItem;
  published
    property DefaultCompressed;
  end;

function LMDWVLGetItem(const FileName:String; index:Integer; aWave:TLMDWave):Boolean;

implementation
uses
  LMDClass, LMDStreamUtils;

{------------------------------------------------------------------------------}
function LMDWVLGetItem(const FileName:String; index:Integer; aWave:TLMDWave):Boolean;
var
  t:TLMDWaveListItem;
begin
  t:=TLMDWaveListItem.Create(nil);
  try
    result:=LMDListGetItemFromFile(FileName, icWave, nil, index, t);
    aWave.Assign(t.Wave);
  finally
    t.Free;
  end;
end;

{************************ Class TLMDWaveListItem ******************************}
{------------------------- Private---------------------------------------------}
procedure TLMDWaveListItem.SetWave(aValue:TLMDWave);
begin
  FWave.Assign(aValue);
end;

{-------------------------- Protected -----------------------------------------}
procedure TLMDWaveListItem.Assign(Source: TPersistent);
begin
  if (Source is TLMDWaveListItem) then
    begin
      FIdent:=TLMDWaveListItem(Source).Ident;
      FDescription:=TLMDWaveListItem(Source).Description;
      FCompressed:=TLMDWaveListItem(Source).Compressed;
      FWave.Assign(TLMDWaveListItem(Source).Wave);
      exit;
    end;
  inherited Assign(Source);
end;

{------------------------------------------------------------------------------}
procedure TLMDWaveListItem.DefineProperties(Filer: TFiler);
begin
  inherited DefineProperties(Filer);
  Filer.DefineBinaryProperty(IDS_INTERNAL, ReadData, WriteData, True);
end;

{------------------------------------------------------------------------------}
function  TLMDWaveListItem.GetEmpty:Boolean;
begin
  result:=FWave.Empty;
end;

{------------------------------------------------------------------------------}
procedure TLMDWaveListItem.ReadData(Stream:TStream);
begin
  if ReadStd(Stream) AND ITF_DATA=ITF_DATA then
    stReadWave(Stream, FWave, FCompressed)
  else
    FWave.FreeWave;
end;

{------------------------------------------------------------------------------}
procedure TLMDWaveListItem.WriteData(Stream:TStream);
begin
  WriteStd(Stream);
  stWriteWave(Stream, FWave, FCompressed);
end;

{------------------------------------------------------------------------------}
function TLMDWaveListItem.WriteFlag:Byte;
begin
  result:=inherited WriteFlag;
  if not FWave.Empty then result:=result or ITF_DATA;
end;

{-------------------------- Public --------------------------------------------}
constructor TLMDWaveListItem.Create(aOwner:TComponent);
begin
  inherited Create(aOwner);
  FWave:=TLMDWave.Create;
end;

{------------------------------------------------------------------------------}
Destructor TLMDWaveListItem.Destroy;
begin
  FWave.Free;
  inherited Destroy;
end;

{------------------------------------------------------------------------------}
procedure TLMDWaveListItem.FreeData;
begin
  FWave.FreeWave;
end;

{************************ Class TLMDWaveList **********************************}
{------------------------- Private---------------------------------------------}
function TLMDWaveList.GetArrayItem(index:Integer):TLMDWaveListItem;
begin
  result:=TLMDWaveListItem(Contents[Index]);
end;

{------------------------------------------------------------------------------}
function TLMDWaveList.GetArrayNameItem(Index:String):TLMDWaveListItem;
begin
  result:=TLMDWaveListItem(ContentsByName[index]);
end;

{-------------------------- Public --------------------------------------------}
constructor TLMDWaveList.Create(AOwner:TComponent);
begin
  inherited Create(AOwner);
  FListClass:=TLMDWaveListItem;
  FListType:=icWave;

  if not LMD_ICRegistered[FListType] then
    begin
      LMD_ICRegistered[FListType]:=True;
      RegisterClass(TLMDWaveListItem);
    end;

end;

end.

