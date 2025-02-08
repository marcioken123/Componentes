unit LMDStringList;
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

LMDStringList unit (2002)
-------------------------

Changes
-------
Release 8.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Windows,
  SysUtils,
  Classes,
  Graphics,
  Consts,
  Controls,
  LMDClass,
  LMDStrings,
  LMDCustomComponent,
  LMDCustomContainer,
  LMDBaseController;

type

  {StringLists}
  {------------------------- TLMDStringListItem -------------------------------}
  TLMDStringListItem = class(TLMDListItem)
  private
    FStrList:TStringList;
    function GetList:TStrings;
    procedure SetList(aValue:TStrings);
  protected
    procedure DefineProperties(Filer: TFiler);override;
    function  GetEmpty:Boolean;override;
    procedure ReadData(Stream:TStream);override;
    procedure WriteData(Stream:TStream);override;
    function  WriteFlag:Byte; override;
  public
    constructor Create(AOwner:TComponent);override;
    destructor Destroy;override;
    procedure Assign(Source: TPersistent);override;
    procedure FreeData; override;
    property Compressed;
  published
    property Items: TStrings read GetList write SetList stored false;
    property Description;
    property Ident;
  end;

  {------------------------ Class TLMDStringList ------------------------------}
  TLMDStringList=class(TLMDCustomContainer)
  private
    function GetArrayItem(index:Integer):TLMDStringListItem;
    function GetArrayNameItem(Index:String):TLMDStringListItem;
  protected

  public
    constructor Create(AOwner:TComponent);override;
    property Items[Index:Integer]:TLMDStringListItem read GetArrayItem;default;
    property ItemByName[Index:String]:TLMDStringListItem read GetArrayNameItem;
  published
    property DefaultCompressed;
  end;

implementation
uses
  RtlConsts,
  LMDSysIn, LMDUtils, LMDStreamUtils;

{*************************** Class TLMDStrListItem ****************************}
{----------------------------  Private ----------------------------------------}
function TLMDStringListItem.GetList:TStrings;
begin
  result:=FStrList;
end;

{------------------------------------------------------------------------------}
procedure TLMDStringListItem.SetList(aValue:TStrings);
begin
  FStrList.Assign(aValue);
end;

{---------------------Protected------------------------------------------------}
procedure TLMDStringListItem.Assign(Source: TPersistent);
begin
  if (Source is TStrings) then
    begin
      FStrList.Assign(TStrings(Source));
      exit;
    end;
  if (Source is TLMDStringListItem) then
    begin
      AssignStd(Source);
      FStrList.Assign(TLMDStringListItem(Source).Items);
      exit;
    end;
  inherited Assign(Source);
end;

{------------------------------------------------------------------------------}
procedure TLMDStringListItem.DefineProperties(Filer: TFiler);
begin
  inherited DefineProperties(Filer);
  Filer.DefineBinaryProperty(IDS_INTERNAL, ReadData, WriteData, True);
end;

{------------------------------------------------------------------------------}
procedure TLMDStringListItem.FreeData;
begin
  FStrList.Clear;
end;

{------------------------------------------------------------------------------}
function  TLMDStringListItem.GetEmpty:Boolean;
begin
  result:=FStrList.Count=0;
end;

{------------------------------------------------------------------------------}
procedure TLMDStringListItem.ReadData(Stream:TStream);
begin
  if ReadStd(Stream) AND ITF_DATA=ITF_DATA then
    stReadStringList(Stream, FStrList, FCompressed)
  else
    FStrList.Clear;
end;

{------------------------------------------------------------------------------}
procedure TLMDStringListItem.WriteData(Stream:TStream);
begin
  WriteStd(Stream);
  if not Empty then stWriteStringList(Stream, FStrList, FCompressed);
end;

{------------------------------------------------------------------------------}
function TLMDStringListItem.WriteFlag:Byte;
begin
  result:=inherited WriteFlag;
  if not Empty then result:=result or ITF_DATA;
end;

{---------------------Public---------------------------------------------------}
constructor TLMDStringListItem.Create(aOwner:TComponent);
begin
  inherited Create(aOwner);
  FStrList:=TStringList.Create;
end;

{------------------------------------------------------------------------------}
Destructor TLMDStringListItem.Destroy;
begin
  FStrList.Free;
  inherited Destroy;
end;

{************************ Class TStringList ***********************************}
{------------------------- Private---------------------------------------------}
function TLMDStringList.GetArrayItem(index:Integer):TLMDStringListItem;
begin
  result:=TLMDStringListItem(Contents[Index]);
end;

{------------------------------------------------------------------------------}
function TLMDStringList.GetArrayNameItem(Index:String):TLMDStringListItem;
begin
  result:=TLMDStringListItem(ContentsByName[index]);
end;

{-------------------------- Public --------------------------------------------}
constructor TLMDStringList.Create(AOwner:TComponent);
begin
  inherited Create(AOwner);
  FListClass:=TLMDStringListItem;
  FListType:=icStringList;

  if not LMD_ICRegistered[FListType] then
    begin
      LMD_ICRegistered[FListType]:=True;
      RegisterClass(TLMDStringListItem);
    end;
end;

end.

