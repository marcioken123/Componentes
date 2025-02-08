unit LMDCustomContainer;
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

LMDCustomContainer unit (RM)
----------------------------


Changes
-------
Release 8.0 (November 2006)
 - Initial Release

###############################################################################}

interface

uses
  Windows, SysUtils, Classes, Graphics, Consts, Controls, LMDClass, LMDProcs,
  LMDCustomComponent, LMDBaseController, LMDTypes;

type

  {possible values for Container}
  TLMDListItemClassType=(icImageList, icBitmap, icWave, icStringList, icGeneric, icImageListItem, icInvalid);

  {--------------------- TLMDListItem -----------------------------------------}
  TLMDListItem = class(TLMDCustomComponent)
  private
    function GetIndex:Integer;
  protected
    FDescription : String;
    FIdent       : Word;
    FCompressed  : Boolean;
    procedure AssignStd(Source:TPersistent);
    procedure Change; override;
    function  GetEmpty: Boolean; virtual;
    procedure ReadData(Stream:TStream);virtual;
    function ReadStd(Stream:TStream):Byte;
    procedure ReadState(Reader: TReader);override;
    procedure WriteData(Stream:TStream);virtual;
    function  WriteFlag:Byte; virtual;
    procedure WriteStd(Stream:TStream);
  public
    procedure LoadFromStream(Stream:TStream);
    procedure SaveToStream(Stream:TStream);
    procedure FreeData; virtual;
    property ListIndex:Integer read GetIndex;
    property Owner;
    property Empty:Boolean read GetEmpty;
    property Compressed:Boolean read FCompressed write FCompressed default false;
    property Description: String read FDescription write FDescription;
    property Ident:Word read FIdent write FIdent;
  end;

  {****************************************************************************}
  {----------------------TLMDCustomContainer-----------------------------------}
  TLMDListItemClass = class of TLMDListItem;
  TLMDContainerSource=(sdComponent, sdFile, sdAppResource, sdLibResource, sdPath);

  TLMDCustomContainer=class(TLMDBaseController)
  private
    procedure SetSource(aValue:TLMDContainerSource);
    procedure SetPrefix(aValue:TLMDPathPrefix);
    function GetItemByName(index: String):TLMDListItem;
  protected
    FDefault:Boolean;
    FPrefix:TLMDPathPrefix;
    FSource:TLMDContainerSource;
    FFileName:TFileName;
    FList:TList;
    FListClass:TLMDListItemClass;
    FListType:TLMDListItemClassType;
    procedure GetChildren(Proc: TGetChildProc; Root: TComponent); override;
    function GetChildOwner: TComponent; override;

    function GetCount:Integer;virtual;
    function GetEmpty:Boolean;virtual;
    function GetItem(index:Integer):TLMDListItem;virtual;
    procedure ReadData(Stream:TStream; flag:Boolean);virtual;
    procedure WriteData(Stream:TStream; flag:Boolean);virtual;
    procedure Update(Sender:TObject);
  public
    constructor Create(aOwner:TComponent);override;
    destructor Destroy;override;
    procedure Assign(Source:TPersistent);override;
    {admin functions}
    function Add(aValue:TLMDListItem=nil):Integer;
    procedure AddList(aValue:TLMDCustomContainer);
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

    {properties, read only}
    property Count:Integer read GetCount;
    property Empty:Boolean read GetEmpty;
    property Contents[Index:Integer]:TLMDListItem read GetItem;
    property ContentsByName[Index: String]:TLMDListItem read GetItemByName;

    {ResSource -> datei, LMDList, RessDLL/Exe, ResApp
    TLMDContainerSource=(sdComponent, sdFile, sdAppResource, sdDLLResource, sdPath);}
    property DefaultCompressed:Boolean read FDefault write FDefault default False;
    property Source:TLMDContainerSource read FSource write SetSource default sdComponent;
    property FileName:TFileName read FFileName write FFileName;
    property FilePrefix:TLMDPathPrefix read FPrefix write SetPrefix default ppProgram;
  published
    property About;
  end;

{file Access routines}
function LMDListGetTypeName(typ:TLMDListItemClassType):String;
function LMDListGetFileType(const FileName:String; var aCount:LongInt; aList:TList):TLMDListItemClassType;
function LMDListGetItemFromStream(Stream:TStream; aList:TList; Index:Integer; aItem:TLMDListItem):Boolean;
function LMDListGetItemFromFile(const FileName:String; aType:TLMDListItemClassType; aList:TList; Index:Integer;
                                aItem:TLMDListItem):Boolean;

{helper for Extensions}
function LMDICGetSuffix(aValue:TLMDListItemClassType; AddPoint:Boolean):String;
function LMDICGetItemSuffix(aValue:TLMDListItemClassType; AddPoint:Boolean):String;

const {standard extensions for LMD-Tools Container Files}
   LMDICEXTENSION: array[TLMDListItemClassType] of string[3]=('iml', 'bml', 'wvl', 'sll',
                                                             'gll','iml', '');
   LMD_ICInfo:array[TLMDListItemClassType] of string[8]=('LMDIML30', 'LMDBML30',
                                                         'LMDWVL30', 'LMDSLL30', 'LMDGLL50',
                                                         'LMDIML30', '');
  ITF_COMPRESSED=$1;
  ITF_DESCRIPTION=$2;
  ITF_IDENT=$4;
  ITF_DATA=$8;

var
  LMD_ICRegistered:array[TLMDListItemClassType] of Boolean;

implementation

uses
  RtlConsts,
  LMDStrings, LMDSysIn, LMDUtils, LMDStreamUtils;

{------------------------------------------------------------------------------}
function LMDICGetSuffix(aValue:TLMDListItemClassType; AddPoint:Boolean):String;
begin
  Result := String(LMDICExtension[aValue]);
  if AddPoint and (Result <> '') then
    Result:= '.' + Result;
end;

{------------------------------------------------------------------------------}
function LMDICGetItemSuffix(aValue:TLMDListItemClassType; AddPoint:Boolean):String;
begin
  result:='';
  case aValue of
    icImageList:result:='iml';
    icBitmap, icImageListItem:result:='bmp';
    icStringList:result:='txt';
    icGeneric:result:='*';
    icWave:result:='wav';
  end;
  if AddPoint and (result<>'') then result:='.'+result;
end;

{------------------------------------------------------------------------------}
function LMDListGetTypeName(typ:TLMDListItemClassType):String;
begin
  result:='';
  case typ of
    icImageList:result:='TLMDImageList';
    icImageListItem:result:='TLMDImageListItem';
    icBitmap:result:='TLMDBitmapList';
    icStringList:result:='TLMDStringList';
    icGeneric:result:='TLMDGenericList';
    icWave:result:='TLMDWaveList';
  end;
end;

{------------------------------------------------------------------------------}
function LMDListGetFileType(const FileName: String; var aCount: LongInt; aList: TList): TLMDListItemClassType;
// Done AH, 05.07.2004
var
  Stream: TStream;
  temp:String[8];
  i:TLMDListItemClassType;
  j:Integer;
begin
  aCount:=-1;
  result:=icInvalid;
  Stream:=TFileStream.Create(Filename, fmOpenRead or fmShareDenyWrite);
  try
    Stream.Read(temp, sizeof(temp));
    {detect type}
    for i:=icImageList to Pred(icInvalid) do
      if temp = LMD_ICINFO[i] then
      begin
          result:=i;
          break;
        end;
    aCount := stReadInteger(Stream);

    if (result=icInvalid) or (aList=nil) then exit;
    aList.Clear;
    aList.Capacity:=aCount;
    for j:=0 to pred(aCount) do aList.Add(Pointer(TLMDPtrUInt(stReadInteger(Stream))));
    finally
    Stream.Free;
  end;
end;
{------------------------------------------------------------------------------}
function LMDListGetItemFromStream(Stream:TStream; aList:TList; Index:Integer; aItem:TLMDListItem):Boolean;
begin
  result:=False;
  if aList=nil then exit;
  Stream.Position := TLMDPtrUInt(aList[Index]);
  aItem.LoadFromStream(Stream);
  result:=True;
end;

{------------------------------------------------------------------------------}
function LMDListGetItemFromFile(const FileName:String; aType:TLMDListItemClassType; aList:TList; Index:Integer;
                                aItem:TLMDListItem):Boolean;
var
  Stream: TStream;
  myList:TList;
  ac:LongInt;
begin
  if aList<>nil then
    myList:=aList
  else
    begin
      myList:=TList.Create;
      if LMDListGetFileType(FileName, ac, myList)<>aType then
        begin
          myList.Free;
          raise Exception.Create(format('%s: %s', [SFOpenError, FileName]));
        end;
    end;

  Stream:=TFileStream.Create(Filename, fmOpenRead);
  try
    result:=LMDListGetItemFromStream(Stream, myList, Index, aItem);
  finally
    Stream.Free;
    if aList=nil then myList.Free;
  end;

end;

{********************** class TLMDListItem ************************************}
{------------------------- Private --------------------------------------------}
function TLMDListItem.GetIndex:Integer;
begin
  if Owner is TLMDCustomContainer then
    result:=TLMDCustomContainer(Owner).IndexOf(self)
  else
    result:=-1;
end;

{-------------------------- Protected -----------------------------------------}
procedure TLMDListItem.AssignStd(Source:TPersistent);
begin
  with  TLMDListItem(Source) do
    begin
      self.FCompressed:=Compressed;
      self.FDescription:=Description;
      self.FIdent:=Ident;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDListItem.Change;
begin
  inherited Change;
  if Owner is TLMDCustomContainer then
    TLMDCustomContainer(Owner).Update(Self);
end;

{------------------------------------------------------------------------------}
procedure TLMDListItem.FreeData;
begin
end;

{------------------------------------------------------------------------------}
function TLMDListItem.ReadStd(Stream:TStream):Byte;
begin
  Result := stReadByte(Stream);
  FCompressed:=(result and ITF_COMPRESSED = ITF_COMPRESSED);
  if (result and ITF_DESCRIPTION = ITF_DESCRIPTION) then
    begin
      FDescription := String(LMDAnsiStreamToString(Stream, stReadByte(Stream)));
      //FDescription := stReadString(Stream);
    end
  else
    FDescription:='';
  if (result and ITF_IDENT = ITF_IDENT) then
    FIdent := stReadInteger(Stream)
  else
    FIdent:=0;
end;

{------------------------------------------------------------------------------}
function TLMDListItem.GetEmpty: Boolean;
begin
  result:=false;
end;

{------------------------------------------------------------------------------}
procedure TLMDListItem.ReadData(Stream:TStream);
begin
end;

{------------------------------------------------------------------------------}
procedure TLMDListItem.WriteData(Stream:TStream);
begin
end;

{------------------------------------------------------------------------------}
procedure TLMDListItem.ReadState(Reader: TReader);
begin
  inherited ReadState(Reader);
  if Reader.Parent is TLMDCustomContainer then
    TLMDCustomContainer(Reader.Parent).Add(self);
end;

{------------------------------------------------------------------------------}
function TLMDListItem.WriteFlag:Byte;
begin
  result:=0;
  if FCompressed then result:=ITF_COMPRESSED;
  if FDescription<>'' then result:=result or ITF_DESCRIPTION;
  if FIdent<>0 then result:=result or ITF_IDENT;
end;

{------------------------------------------------------------------------------}
procedure TLMDListItem.WriteStd(Stream:TStream);
var
  tmp:Byte;
begin
  tmp:=WriteFlag;
  stWriteByte(Stream, tmp);
  if ITF_DESCRIPTION and tmp=ITF_DESCRIPTION then
    begin
      stWriteByte(Stream, Length(FDescription));
      LMDAnsiStringToStream(AnsiString(FDescription), Stream);
      //stWriteString(Stream, FDescription)
    end;
  if ITF_IDENT and tmp=ITF_IDENT then
    stWriteInteger(Stream, FIdent);
end;

{-------------------------- Public --------------------------------------------}
procedure TLMDListItem.LoadFromStream(Stream: TStream);
begin
  ReadData(Stream);
end;

{------------------------------------------------------------------------------}
procedure TLMDListItem.SaveToStream(Stream: TStream);
begin
  WriteData(Stream);
end;

{********************** class TLMDCustomContainer *****************************}
{-------------------------- Private -------------------------------------------}
procedure TLMDCustomContainer.SetSource(aValue:TLMDContainerSource);
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
procedure TLMDCustomContainer.SetPrefix(aValue:TLMDPathPrefix);
begin
  if aValue<>FPrefix then
    begin
      FPrefix:=aValue;
      Change;
    end;
end;

{------------------------------------------------------------------------------}
function TLMDCustomContainer.GetCount:Integer;
begin
  result:=FList.Count;
end;

{------------------------------------------------------------------------------}
function TLMDCustomContainer.GetEmpty:Boolean;
begin
  result:=FList.Count=0;
end;

{------------------------------------------------------------------------------}
function TLMDCustomContainer.GetItem(Index:Integer):TLMDListItem;
begin
  result:=TLMDListItem(FList[Index]);
end;

{------------------------------------------------------------------------------}
function TLMDCustomContainer.GetItemByName(index: String):TLMDListItem;
var
  i:Integer;
begin
  result:=nil;
  i:=0;
  while i<FList.Count do
    if TLMDListItem(FList[i]).Description = index then
      begin
        result:=TLMDListItem(FList[i]);
        break;
      end
    else
      Inc(i);
end;

{-------------------------- Protected -----------------------------------------}
procedure TLMDCustomContainer.Assign(Source:TPersistent);
begin
  if (Source is Self.ClassType) or Self.ClassType.InheritsFrom(Source.ClassType) then
    begin
      BeginUpdate;
      try
        Clear;
        FDefault:=TLMDCustomContainer(Source).DefaultCompressed;
        AddList(TLMDCustomContainer(Source));
      finally
        EndUpdate(True);
      end;
      Exit;
    end;
  inherited Assign(Source);
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomContainer.GetChildren(Proc: TGetChildProc; Root: TComponent);
var
  i: Integer;
begin
  for i:=0 to Pred(FList.Count) do
    Proc(TLMDListItem(FList[i]));
end;

{------------------------------------------------------------------------------}
function TLMDCustomContainer.GetChildOwner: TComponent;
begin
  result:=self;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomContainer.ReadData(Stream:TStream; flag:Boolean);
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
procedure TLMDCustomContainer.WriteData(Stream:TStream; flag:Boolean);
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
procedure TLMDCustomContainer.Update(Sender:TObject);
var
  myChange:TNotifyEvent;
begin
  myChange:=OnChange;
  if Assigned(myChange) then MyChange(Sender);
end;

{-------------------------- Public --------------------------------------------}
constructor TLMDCustomContainer.Create(aOwner:TComponent);
begin
  inherited Create(aOwner);
  FDefault:=False;
  FList:=TList.Create;
  FSource:=sdComponent;
  FFileName:='';
  FPrefix:=ppProgram;
end;

{------------------------------------------------------------------------------}
destructor TLMDCustomContainer.Destroy;
begin
  FList.Free;
  inherited Destroy;
end;

{admin functions}
{------------------------------------------------------------------------------}
function TLMDCustomContainer.Add(aValue:TLMDListItem=nil):Integer;
begin
  if aValue=nil then
    result:=FList.Add(FListClass.Create(self))
  else
    result:=FList.Add(aValue);
  Change;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomContainer.AddList(aValue:TLMDCustomContainer);
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
procedure TLMDCustomContainer.Clear;
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
procedure TLMDCustomContainer.Delete(Index: Integer);
begin
  TLMDListItem(FList[Index]).Free;
  FList[Index]:=nil;
  FList.Delete(Index);
  Change;
end;

{------------------------------------------------------------------------------}
function  TLMDCustomContainer.IndexOf(aValue:TLMDListItem):Integer;
begin
  result:=FList.IndexOf(aValue);
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomContainer.Insert(Index:Integer; aValue:TLMDListItem=nil);
begin
  if aValue=nil then
    FList.Insert(Index, FListClass.Create(self))
  else
    FList.Insert(Index, aValue);
  Change;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomContainer.Move(OldIndex, NewIndex:Integer);
begin
  if OldIndex=NewIndex then exit;
  FList.Move(OldIndex, NewIndex);
  Change;
end;

{i/o}
{------------------------------------------------------------------------------}
procedure TLMDCustomContainer.LoadFromFile(const Filename: string);
// Done AH, 05.07.2004
var
  Stream: TStream;
  temp:String[8];
  begin
  Stream:=TFileStream.Create(Filename, fmOpenRead);
  try
    Stream.Read(temp, sizeof(temp));
    if temp=LMD_ICINFO[FListType] then
      ReadData(Stream, True)
    else
      raise Exception.Create(format('%s: %s', [SFOpenError, ClassName]));
  finally
    Stream.Free;
  end;
end;
{------------------------------------------------------------------------------}
procedure TLMDCustomContainer.LoadFromStream(Stream:TStream);
begin
  ReadData(Stream, false);
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomContainer.SaveToStream(Stream:TStream);
begin
  WriteData(Stream, false);
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomContainer.SaveToFile(const Filename: string);
// Done AH, 05.07.2004
var
  Stream: TStream;
  begin
  Stream:=TFileStream.Create(Filename, fmCreate);
  try
    Stream.Write(LMD_ICINFO[FListType], sizeof(LMD_ICINFO[FListType]));
    WriteData(Stream, True);
  finally
    Stream.Free;
  end;
end;

end.
