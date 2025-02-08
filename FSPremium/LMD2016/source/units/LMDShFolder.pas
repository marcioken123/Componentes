unit LMDShFolder;
{$I LMDCmps.inc}

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

LMDShFolder unit (DS)
------------------------
Contains TLMDShellFolder support


Changes
-------
Release 4.0 (September 2006)
 - Initial Release

###############################################################################}

interface
uses
  Classes, Graphics, ShlObj,
  LMDShBase, LMDShItem, LMDShController, LMDShMisc, LMDShUtils;

type

  {****************************************************************************}
  TLMDShellSortType = (stNone, stName, stTypeName, stSize, stAttributes, stCreateDate,
                       stCreateTime, stCreateDateTime, stAccessDate, stAccessTime,
                       stAccessDateTime, stWriteDate, stWriteTime,
                       stWriteDateTime);

  {****************************************************************************}
  TLMDShellSortOrder = (soAsc ,soDesc);

  {****************************************************************************}
  TLMDShellFilterEvent = procedure(Sender: TObject; Item: TLMDShellItem;
    var Accept: Boolean) of object;

  {****************************************************************************}
  TLMDShellDriveInfoEvent = procedure (Sender: TObject; Drive: string;
        TotalSpace, FreeSpace : Int64) of object;

  {****************************************************************************}
  TLMDShellInfoEvent = procedure (Sender: TObject; Count: LongInt; Size: Int64) of object;

  {****************************************************************************}
  TLMDShellFolder = class(TLMDShellController)
  private
    { property variables }
    FRootFolder         : TLMDRoot;

    { V2.0 }
    FCompressedColor    : TColor;
    FOptions            : TLMDShellFolderOptions;
    FFilter             : string;
    FFiltered           : boolean;
    FSortType           : TLMDShellSortType;
    FSortOrder          : TLMDShellSortOrder;
    FOnChange           : TNotifyEvent;
    FOnFilter           : TLMDShellFilterEvent;
    FOnFolderInfoEvent  : TLMDShellInfoEvent;
    FOnDriveInfoEvent   : TLMDShellDriveInfoEvent;

    { property methods }
    procedure SetRootFolder(const aValue : TLMDRoot);

    { internal methods }
    procedure LoadCustomFolder(Reader: TReader);
    procedure LoadSystemFolder(Reader: TReader);
    //procedure LoadCompressedColor(Reader: TReader);
    //procedure SetCompressedColor(const Value: TColor);
    function isNoDefault:Boolean;
  protected
    { base mothods }
    procedure DefineProperties(Filer: TFiler); override;
    procedure TriggerActiveFolderChanged; override;
  public
    { constructor / destructor }
    constructor Create(aOwner : TComponent); override;
    destructor Destroy; override;

    { only for old cpb }
    procedure RefreshControls;
    procedure ChDir(aRootFolder : TLMDSystemFolder);overload;

  published
    { properties }
    property About;
    property RootFolder : TLMDRoot read FRootFolder write SetRootFolder stored isNoDefault;
    { for V2.0 }
    property Options : TLMDShellFolderOptions read FOptions write FOptions default [];
    // for compatbility
    property CompressedColor : TColor read FCompressedColor write FCompressedColor default clBlack; //SetCompressedColor;

    property Filter : String read FFilter write FFilter;
    property Filtered : Boolean read FFiltered write FFiltered default false;
    property SortType : TLMDShellSortType read FSortType write FSortType default stNone;
    property SortOrder : TLMDShellSortOrder read FSortOrder write FSortOrder default soAsc;
    property ObserveChanges;

    property OnChange : TNotifyEvent read FOnChange write FOnChange;
    property OnFilter : TLMDShellFilterEvent read FOnFilter write FOnFilter;
    property OnFolderInfoEvent : TLMDShellInfoEvent read FOnFolderInfoEvent write FOnFolderInfoEvent;
    property OnDriveInfoEvent : TLMDShellDriveInfoEvent read FOnDriveInfoEvent write FOnDriveInfoEvent;
  end;

implementation

uses
  SysUtils, TypInfo,
  LMDShConsts, LMDStrings;

{** TLMDShellFolder ***********************************************************}
{-- private -------------------------------------------------------------------}
procedure TLMDShellFolder.SetRootFolder(const aValue : TLMDRoot);
var
  tmpPIDL : PItemIDList;
begin
  if LMDAnsiSameText(FRootFolder, aValue) then Exit;
  FRootFolder := aValue;
  tmpPIDL := LMDGetRootFolderID(FRootFolder);
  // in csLoading state we assume that default sfDesktop setting will be overwritten
  if csLoading in ComponentState then
    ClearPathList(BackwardPathList);
  if Assigned(tmpPIDL)  then
    begin
      ChDir(tmpPIDL);
      ID_Free(tmpPIDL);
    end
  else
    ChDir(aValue);
end;

{------------------------------------------------------------------------------}
procedure TLMDShellFolder.LoadCustomFolder(Reader: TReader);
begin
  RootFolder := Reader.ReadString;
end;

{------------------------------------------------------------------------------}
{procedure TLMDShellFolder.LoadCompressedColor(Reader: TReader);
begin
  SetCompressedColor(StringToColor(Reader.ReadIdent));
end;

{------------------------------------------------------------------------------}
procedure TLMDShellFolder.LoadSystemFolder(Reader: TReader);
var
  i: Integer;
begin
  i:= GetEnumValue(TypeInfo(TLMDSystemFolder), Reader.ReadIdent);
  if i <= Ord(High(TLMDRootFolder)) then
    RootFolder := GetEnumName(TypeInfo(TLMDRootFolder), i);
end;

{-- protected -----------------------------------------------------------------}
procedure TLMDShellFolder.DefineProperties(Filer: TFiler);
begin
  inherited;
  Filer.DefineProperty('SystemFolder', LoadSystemFolder, nil, false);
  Filer.DefineProperty('CustomFolder', LoadCustomFolder, nil, false);
  //Filer.DefineProperty('CompressedColor', LoadCompressedColor, nil, false);
end;

{-- public --------------------------------------------------------------------}
constructor TLMDShellFolder.Create(aOwner : TComponent);
begin
  inherited;
  RootFolder := sRFDesktop;
end;

{------------------------------------------------------------------------------}
destructor TLMDShellFolder.Destroy;
begin
  inherited;
end;

{------------------------------------------------------------------------------}
function TLMDShellFolder.isNoDefault: Boolean;
begin
  result:=FRootFolder<>sRFDesktop;
end;

{------------------------------------------------------------------------------}
procedure TLMDShellFolder.RefreshControls;
begin
  ActiveFolderChanged;
end;

{------------------------------------------------------------------------------}
procedure TLMDShellFolder.ChDir(aRootFolder : TLMDSystemFolder);
var
  tmpPIDL : PItemIDList;
begin
  tmpPIDL := LMDGetRootFolderID(aRootFolder);
  if Assigned(tmpPIDL)  then
  begin
    ChDir(tmpPIDL);
    ID_Free(tmpPIDL);
  end;
end;

{------------------------------------------------------------------------------}
procedure TLMDShellFolder.TriggerActiveFolderChanged;
begin
  if  Assigned(FOnChange) then
    FOnChange(self);
end;

{procedure TLMDShellFolder.SetCompressedColor(const Value: TColor);
var
  i:Integer;
begin
  if Value<>FCompressedColor then
    begin
      for i:=0 to ViewCount-1 do
        begin
          if Views[i] is TLMDShellList then TLMDShellList(Views[i]).CompressedColor:=
        end;
  FCompressedColor := Value;
end;}

end.
