unit LMDCustomImageList;
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

LMDCustomImageList unit (RM)
----------------------------
Base class for all native LMD ImageLists.

Changes
-------
Release 8.0 (November 2006)
 - Initial Release

###############################################################################}

interface

uses
  Windows, SysUtils, Classes, Graphics, Consts, Controls, Imglist,
  LMDClass, LMDGraph, LMDProcs, LMDCustomContainer, intfLMDBase, LMDTypes;

const
  LMDPixelFormatColors:array[TLMDSavePixelFormat] of LongInt=(-1, 2, 16, 256, 65536);

type

  {----------------------TLMDCustomImageList-----------------------------------}
  TLMDCustomImageList = class(TCustomImageList, ILMDComponent)
  private
    FAbout: TLMDAboutVar;
    FUpdateCount: Word;
    function GetItemByName(index:String):TLMDListItem;
    procedure SetIndex(aValue:Integer);
    procedure SetSource(aValue:TLMDContainerSource);
    procedure SetPrefix(aValue:TLMDPathPrefix);
    procedure ReadLeft(Reader: TReader);
    procedure ReadTop(Reader: TReader);
    procedure WriteLeft(Writer: TWriter);
    procedure WriteTop(Writer: TWriter);
  protected
    FDefault:Boolean;
    FPrefix:TLMDPathPrefix;
    FSource:TLMDContainerSource;
    FFileName:TFileName;
    FList:TList;
    FListClass:TLMDListItemClass;
    FListType:TLMDListItemClassType;
    FIndex:Integer;
    FDefaultPixel:TLMDSavePixelFormat;
    procedure DefineProperties(Filer: TFiler); override;
    procedure GetChildren(Proc: TGetChildProc; Root: TComponent); override;
    function GetChildOwner: TComponent; override;
    {$IFNDEF LMDCOMP22}procedure Change; override;{$ENDIF}
    function GetCount:Integer;{$IFNDEF LMDCOMP22}virtual;{$ELSE}override;{$ENDIF}
    function GetEmpty:Boolean;virtual;
    function GetItem(index:Integer):TLMDListItem;virtual;
    procedure ReadData(Stream:TStream); {$IFDEF LMDCOMP7}override;{$ENDIF}
    procedure WriteData(Stream:TStream); {$IFDEF LMDCOMP7}override;{$ENDIF}
    procedure ReadStream(Stream:TStream; flag:Boolean);virtual;
    procedure WriteStream(Stream:TStream; flag:Boolean);virtual;
    procedure Update(Sender:TObject);
//    procedure Initialize;override;       // disable TCustomImageList features
  public
    constructor Create(aOwner: TComponent);override;
    destructor Destroy; override;
    procedure Assign(Source:TPersistent);override;
    {$IFDEF LMDCOMP22}procedure Change; override;{$ENDIF}

    // Basic LMD CustomImageList functions
    function BmpCanvas(index:Integer):TCanvas;virtual;abstract; {3.10}
    function ItemRect(index, item:Integer):TRect;virtual;abstract; {3.10}
    function Dimensions(index:Integer; tp:Byte):Integer;virtual;abstract;
    function ItemCount(index:Integer):Integer;virtual;abstract;
    function IsValidItem(index, item:Integer):Boolean;virtual;abstract;
    procedure GetBitmapItem(index, item:integer; tb:TBitmap);virtual;abstract;
    function Masked(index:Integer):Boolean; virtual; abstract;
    function Palette(index:Integer):HPalette;virtual;abstract;
    function TransparentColor(index, item:Integer):TColor;virtual;abstract;
    function GetColorAtPoint(aPoint: TPoint; index, item:Integer): TColor; virtual;abstract;

    {Drawing}
    procedure Draw(Canvas: TCanvas; X, Y: Integer; ListIndex, Index: Integer);virtual; abstract;
    function DrawExt(Canvas:TCanvas; target:TRect; flags:Word; ListIndex, Index:Integer):TRect;virtual; abstract;

    {Extended Drawing}
    procedure ClipDraw(Canvas:TCanvas; target:TRect; flags:WORD;
                       pos:LongInt; transColor:TColor; ListIndex, index:Integer);virtual; abstract;

    {admin functions}
    function Add(aValue:TLMDListItem=nil):Integer; virtual;
    procedure AddList(aValue:TLMDCustomImageList);
    procedure Clear;
    procedure Delete(Index: Integer);
    function  IndexOf(aValue:TLMDListItem):Integer;
    procedure Insert(Index:Integer; aValue:TLMDListItem=nil);
    procedure Move(OldIndex, NewIndex:Integer);

    {i/o}
    procedure LoadFromFile(const Filename: string);
    procedure LoadFromStream(Stream:TStream);
    procedure SaveToStream(Stream:TStream);
    procedure SaveToFile(const Filename: string);

    procedure BeginUpdate;
    function IsUpdating:Boolean;
    procedure EndUpdate(aValue:Boolean=True);
    function getLMDPackage:TLMDPackageID;

    property Index:Integer read FIndex write SetIndex default 0;
    property DefaultPixelFormat:TLMDSavePixelFormat read FDefaultPixel write FDefaultPixel default spfDefault;

    {properties, read only}
    {$IFNDEF LMDCOMP22}property Count:Integer read GetCount;{$ENDIF}
    property Empty:Boolean read GetEmpty;
    property Contents[Index:Integer]:TLMDListItem read GetItem;
    property ContentsByName[Index:String]:TLMDListItem read GetItemByName;

    {ResSource -> datei, LMDList, RessDLL/Exe, ResApp
    TLMDContainerSource=(sdComponent, sdFile, sdAppResource, sdDLLResource, sdPath);}
    property DefaultCompressed:Boolean read FDefault write FDefault default False;
    property Source:TLMDContainerSource read FSource write SetSource default sdComponent;
    property FileName:TFileName read FFileName write FFileName;
    property FilePrefix:TLMDPathPrefix read FPrefix write SetPrefix default ppProgram;
  published
    property About:TLMDAboutVar read FAbout write FAbout stored false;
    property OnChange;
    //property Source;
    //property FileName;
    //property FilePrefix;
  end;

const
  ITF_BMPMONO=$10;
  ITF_BMP16=$20;
  ITF_BMP256=$40;
  ITF_BMP65K=$80;

  function LMDBmpLoad(hlib:THandle; index:Integer; aBitmap:TBitmap):Boolean;
  function LMDBmpLoadFromFile(const FileName:String; index:Integer; aBitmap:TBitmap):Boolean;

implementation
uses
  RtlConsts,
  LMDSysIn, LMDUtils, LMDStreamUtils;

{------------------------------------------------------------------------------}
function LMDBmpLoad(hlib:THandle; index:Integer; aBitmap:TBitmap):Boolean;
{var
  tmp:TResourceStream;}
begin
  result:=True;
  {
  tmp:=TResourceStream.CreateFromID(hlib, index, RT_BITMAP);
  aBitmap.Assign(TBitmap(tmp));
  }
end;

{------------------------------------------------------------------------------}
function LMDBmpLoadFromFile(const FileName:String; index:Integer; aBitmap:TBitmap):Boolean;
var
  hlib:THandle;
begin
  result:=false;
  hlib:=LoadLibrary(int_Ref(FileName));
  if hlib>=32 then
    try
      result:=LMDBmpLoad(hlib, index, aBitmap);
    finally
      FreeLibrary(hlib);
    end;
end;

{Helper}
{------------------------------------------------------------------------------}
procedure InvalidOperation(const Str: String);
begin
  raise EInvalidGraphicOperation.Create(Str);
end;

{********************** class TLMDCustomImageList *****************************}
{-------------------------- Private -------------------------------------------}
procedure TLMDCustomImageList.SetSource(aValue:TLMDContainerSource);
var
  i:Integer;
begin
  if FSource<>aValue then
    begin
      if not (csLoading in ComponentState) then
        {if FSource=sdComponent then}
           For i:=0 to Pred(FList.Count) do TLMDListItem(FList[i]).FreeData;
      FSource:=aValue;
      Change;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomImageList.SetPrefix(aValue:TLMDPathPrefix);
begin
  if aValue<>FPrefix then
    begin
      FPrefix:=aValue;
      Change;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomImageList.SetIndex(aValue:Integer);
begin
  if aValue<>FIndex then
    if aValue<FList.Count then
      FIndex:=aValue
    else
      InValidOperation(SListIndexError);
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomImageList.ReadLeft(Reader: TReader);
var
  tmp:LongInt;
begin
  tmp:=DesignInfo;

  LongRec(tmp).Lo:=Reader.ReadInteger;

  DesignInfo:=tmp;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomImageList.ReadTop(Reader: TReader);
var
  tmp:LongInt;
begin
  tmp:=DesignInfo;

  LongRec(tmp).Hi:=Reader.ReadInteger;

  DesignInfo:=tmp;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomImageList.WriteLeft(Writer: TWriter);
begin
//  Writer.WriteInteger(LongRec(DesignInfo).Lo);
  Writer.WriteInteger(LoWord(DesignInfo));
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomImageList.WriteTop(Writer: TWriter);
begin
//  Writer.WriteInteger(LongRec(DesignInfo).Hi);
  Writer.WriteInteger(HiWord(DesignInfo));
end;

{------------------------------------------------------------------------------}
function TLMDCustomImageList.GetCount:Integer;
begin
  result:=FList.Count;
end;

{------------------------------------------------------------------------------}
function TLMDCustomImageList.GetEmpty:Boolean;
begin
  result:=FList.Count=0;
end;

{------------------------------------------------------------------------------}
function TLMDCustomImageList.GetItemByName(index:String):TLMDListItem;
var
  i:Integer;
begin
  result:=nil;
  i:=0;
  while i<FList.Count do
    if TLMDListItem(FList[i]).Description=index then
      begin
        result:=TLMDListItem(FList[i]);
        break;
      end
    else
      Inc(i);
end;
{------------------------------------------------------------------------------}
function TLMDCustomImageList.GetItem(Index:Integer):TLMDListItem;
begin
  result:=TLMDListItem(FList[Index]);
end;

{-------------------------- Protected -----------------------------------------}
procedure TLMDCustomImageList.Assign(Source:TPersistent);
begin
  // ToDo RM --> check for TCustomImageList descendant

  if (Source is Self.ClassType) or Self.ClassType.InheritsFrom(Source.ClassType) then
    begin
      BeginUpdate;
      try
        Clear;
        FDefault:=TLMDCustomImageList(Source).DefaultCompressed;
        AddList(TLMDCustomImageList(Source));
      finally
        EndUpdate(True);
      end;
      Exit;
    end;
  inherited Assign(Source);
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomImageList.DefineProperties(Filer: TFiler);
var
  Ancestor: TComponent;
  Info: Longint;
begin
  Info := 0;
  Ancestor := TComponent(Filer.Ancestor);
  if Ancestor <> nil then
    Info := Ancestor.DesignInfo;
  Filer.DefineProperty('Left', ReadLeft, WriteLeft, LoWord(DesignInfo) <> LoWord(Info));
  Filer.DefineProperty('Top', ReadTop, WriteTop, HiWord(DesignInfo) <> HiWord(Info));
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomImageList.GetChildren(Proc: TGetChildProc; Root: TComponent);
var
  i: Integer;
begin
  for i:=0 to Pred(FList.Count) do
    Proc(TLMDListItem(FList[i]));
end;

{------------------------------------------------------------------------------}
function TLMDCustomImageList.GetChildOwner: TComponent;
begin
  result:=self;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomImageList.Change;
begin
  if (FUpdateCount>0) or (csDestroying in ComponentState) then
    exit
  else
    inherited;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomImageList.ReadData(Stream:TStream);
begin
// Nothing to do
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomImageList.ReadStream(Stream:TStream; flag:Boolean);
var
  i:Integer;
  aCount:LongInt;
begin
  BeginUpdate;
  try
    Clear;
    Stream.Read(aCount, sizeof(aCount));
    if flag and (aCount>0) then
      begin
        {Listenkonfiguration
         -----------------------------}

        {Data
         -----------------------------}
        {if we load complete file, skip positions}
        stream.Position:=stream.Position+aCount*sizeof(LongInt);
      end;
    for i:=0 to Pred(aCount) do
       TLMDListItem(FList.Items[Add(nil)]).LoadFromStream(Stream);
  finally
    EndUpdate(True);
  end;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomImageList.WriteData(Stream:TStream);
begin
  // Nothing to do
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomImageList.WriteStream(Stream:TStream; flag:Boolean);
// Check AH, 05.12.2004
var
  i:Integer;
  aCount, oldpos, newpos:LongInt;
  pos:TList;

begin
  aCount:=FList.Count;
  Stream.Write(aCount, sizeof(aCount));
  if flag then   {save to file}
    begin
     {ListenKonfiguration
      -----------------------------}

     {Data
      -----------------------------}
     if aCount>0 then
       begin
         pos:=TList.Create;
         try
           {prepare Space for single items}
           oldpos:=Stream.Position;
           Stream.Position:=oldpos+aCount*sizeof(LongInt);

           for i:=0 to Pred(aCount) do
             begin
               pos.Add(Pointer(TLMDPtrUInt(Stream.Position)));
               TLMDListItem(FList[i]).SaveToStream(Stream);
             end;
           {write positions of single items in one block}
           newpos:=Stream.Position;
           Stream.Position:=oldpos;
           {--> RM: improve!!!}
           for i:=0 to Pred(aCount) do
             stWriteInteger(Stream, LongInt(pos[i]));
           {---}
           Stream.Position:=newpos;
         finally
           pos.free;
         end;
       end;
    end
  else   {save into DFM}
   for i:=0 to Pred(aCount) do
     TLMDListItem(FList[i]).SaveToStream(Stream);

end;
{------------------------------------------------------------------------------}
procedure TLMDCustomImageList.Update(Sender:TObject);
var
  myChange:TNotifyEvent;
begin
  myChange:=OnChange;
  if Assigned(myChange) then MyChange(Sender);
end;

{------------------------------------------------------------------------------}
{procedure TLMDCustomImageList.Initialize;
begin
  // empty - we need no features of original imagelist control
end;

{-------------------------- Public --------------------------------------------}
constructor TLMDCustomImageList.Create(aOwner:TComponent);
begin
  inherited Create(aOwner);
  FDefault:=False;
  FList:=TList.Create;
  FSource:=sdComponent;
  FFileName:='';
  FPrefix:=ppProgram;
end;

{------------------------------------------------------------------------------}
destructor TLMDCustomImageList.Destroy;
begin
  FList.Free;
  inherited Destroy;
end;

{admin functions}
{------------------------------------------------------------------------------}
function TLMDCustomImageList.Add(aValue:TLMDListItem=nil):Integer;
begin
  if aValue=nil then
    result:=FList.Add(FListClass.Create(self))
  else
    result:=FList.Add(aValue);
  Change;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomImageList.AddList(aValue:TLMDCustomImageList);
var
  i:Integer;
begin
  for i:=0 to Pred(aValue.Count) do
    begin
      FList.Add(FListClass.Create(self));
      TLMDListItem(FList.Last).Assign(aValue.Contents[i]);
    end;
  Change;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomImageList.Clear;
var
  i:integer;
begin
  for i:=0 to Pred(FList.Count) do
    begin
      TLMDListItem(FList[i]).Free;
      FList[i]:=nil;
    end;
  FList.Clear;
  Change;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomImageList.Delete(Index: Integer);
begin
  TLMDListItem(FList[Index]).Free;
  FList[Index]:=nil;
  FList.Delete(Index);
  Change;
end;

{------------------------------------------------------------------------------}
function  TLMDCustomImageList.IndexOf(aValue:TLMDListItem):Integer;
begin
  result:=FList.IndexOf(aValue);
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomImageList.Insert(Index:Integer; aValue:TLMDListItem=nil);
begin
  if aValue=nil then
    FList.Insert(Index, FListClass.Create(self))
  else
    FList.Insert(Index, aValue);
  Change;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomImageList.Move(OldIndex, NewIndex:Integer);
begin
  if OldIndex=NewIndex then exit;
  FList.Move(OldIndex, NewIndex);
  Change;
end;

{i/o}
{------------------------------------------------------------------------------}
procedure TLMDCustomImageList.LoadFromFile(const Filename: string);
// Done AH, 05.07.2004
var
  Stream: TStream;
  temp:String[8];
  begin
  Stream:=TFileStream.Create(Filename, fmOpenRead);
  try
    Stream.Read(temp, sizeof(temp));
    if temp=LMD_ICINFO[FListType] then
      ReadStream(Stream, True)
    else
      raise Exception.Create(format('%s: %s', [SFOpenError, ClassName]));
  finally
    Stream.Free;
  end;
end;
{------------------------------------------------------------------------------}
procedure TLMDCustomImageList.LoadFromStream(Stream:TStream);
begin
  ReadStream(Stream, false);
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomImageList.SaveToStream(Stream:TStream);
begin
  WriteStream(Stream, false);
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomImageList.SaveToFile(const Filename: string);
// Done AH, 05.07.2004
var
  Stream: TStream;
  begin
  Stream:=TFileStream.Create(Filename, fmCreate);
  try
    Stream.Write(LMD_ICINFO[FListType], sizeof(LMD_ICINFO[FListType]));
    WriteStream(Stream, True);
  finally
    Stream.Free;
  end;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomImageList.BeginUpdate;
begin
  Inc(FUpdateCount);
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomImageList.EndUpdate(aValue: Boolean);
begin
 if FUpdateCount>0 then Dec (FUpdateCount);
 if FUpdateCount = 0 then
   if aValue then Change;
end;

{------------------------------------------------------------------------------}
function TLMDCustomImageList.IsUpdating: Boolean;
begin
  result:=FUpdateCount>0;
end;

{------------------------------------------------------------------------------}
function TLMDCustomImageList.getLMDPackage: TLMDPackageID;
begin
  result:=pi_LMD_RTLX;
end;

end.
