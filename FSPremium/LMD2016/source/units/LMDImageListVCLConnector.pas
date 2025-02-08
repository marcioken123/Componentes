unit LMDImageListVCLConnector;
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

LMDImageListVCLConnector unit (RM)
----------------------------------
Note: This control is obsolete from LMD-Tools 8 on.


Changes
-------
Release 8.0 (November 2006)
 - Initial Release

###############################################################################}

interface

uses
  Windows, Classes, Graphics, ImgList,
  LMDBase, LMDBaseController, LMDImagelist, intfLMDBase, LMDTypes;

type
  TLMDImageListVCLConnector=class(TCustomImageList, ILMDComponent)
  private
    FAbout:TLMDAboutVar;
    FImageList  : TLMDImageList;
    FListIndex:Integer;
    FUpdateCount:Byte;
    FChangeLink : TChangeLink;
    FMasked: Boolean;
    procedure SetImageList(aValue:TLMDImageList);
    procedure SetListIndex(const aValue:Integer);

    procedure ReadLeft(Reader: TReader);
    procedure ReadTop(Reader: TReader);
    procedure WriteLeft(Writer: TWriter);
    procedure WriteTop(Writer: TWriter);
    procedure SetMasked(const Value: Boolean);
  protected
    procedure BeginUpdate;
    procedure EndUpdate(repaint: Boolean=false);
    {$IFNDEF LMDCOMP22}
	procedure Change; override;
	{$ENDIF}
    procedure CopyImages(aList: TLMDImageList; aIndex:Integer);
    procedure DefineProperties(Filer: TFiler); override;
    procedure ImageListChange(Sender:TObject);
    procedure Loaded; override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override ;
  public
    constructor Create(aOwner:TComponent);override;
    destructor Destroy; override;
    function getLMDPackage:TLMDPackageID;
    {$IFDEF LMDCOMP22}
	procedure Change; override;
	{$ENDIF}
  published
    property About:TLMDAboutVar read FAbout write FAbout stored false;
    property Masked:Boolean read FMasked write SetMasked default true;
    property ImageList:TLMDImageList read FImageList write SetImageList;
    property ListIndex:Integer read FListIndex write SetListIndex default 0;
    property OnChange;
  end;

implementation

uses
  Types, SysUtils;

{******************* Class TLMDImageListVCLConnector **************************}
{------------------------- Private --------------------------------------------}
procedure TLMDImageListVCLConnector.SetImageList(aValue:TLMDImageList);
begin
  if FImageList<>nil then
    FImageList.UnRegisterChanges(FChangeLink);
  FImageList:=aValue;
  if FImageList <> nil then
    begin
      FImageList.RegisterChanges(FChangeLink);
      FImageList.FreeNotification(self);
    end;
  ImageListChange(nil);
end;

{------------------------------------------------------------------------------}
procedure TLMDImageListVCLConnector.SetListIndex(const aValue:Integer);
begin
  if aValue<>FListIndex then
    begin
      FListIndex:=aValue;
      if FImageList<>nil then ImageListChange(nil);
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDImageListVCLConnector.SetMasked(const Value: Boolean);
begin
  if Value<>FMasked then
    begin
      FMasked := Value;
      if FImageList<>nil then ImageListChange(nil);
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDImageListVCLConnector.ReadLeft(Reader: TReader);
var
  tmp:LongInt;
begin
  tmp:=DesignInfo;

  LongRec(tmp).Lo:=Reader.ReadInteger;

  DesignInfo:=tmp;
end;

{------------------------------------------------------------------------------}
procedure TLMDImageListVCLConnector.ReadTop(Reader: TReader);
var
  tmp:LongInt;
begin
  tmp:=DesignInfo;

  LongRec(tmp).Hi:=Reader.ReadInteger;

  DesignInfo:=tmp;
end;

{------------------------------------------------------------------------------}
procedure TLMDImageListVCLConnector.WriteLeft(Writer: TWriter);
begin
//  Writer.WriteInteger(LongRec(DesignInfo).Lo);
  Writer.WriteInteger(LoWord(DesignInfo));
end;

{------------------------------------------------------------------------------}
procedure TLMDImageListVCLConnector.WriteTop(Writer: TWriter);
begin
//  Writer.WriteInteger(LongRec(DesignInfo).Hi);
  Writer.WriteInteger(HiWord(DesignInfo));
end;

{----------------------- Protected --------------------------------------------}
procedure TLMDImageListVCLConnector.CopyImages(aList: TLMDImageList; aIndex: Integer);
var
  i:Integer;
  Image, aMask: TBitmap;
begin
  BeginUpdate;
  try
    Clear;
    if Assigned(aList) and (aList.Count>aIndex) then
      begin
        Width:=aList.Items[aIndex].Width;
        Height:=aList.Items[aIndex].Height;
        Image := TBitmap.Create;
        with Image do
          try
            Height := self.Height;
            Width := self.Width;
            if aList.Items[aIndex].Masked then
              begin
                aMask:=TBitmap.Create;
                with aMask do
                  try
                    Monochrome := True;
                    Height := self.Height;
                    Width := self.Width;
                    for i:=0 to alist.ItemCount(aIndex)-1 do
                      begin
                        aList[aIndex].GetBitmap(i, Image);
                        aList[aIndex].GetMaskBitmap(i, aMask);
                        Add(Image, aMask);
                     end;
                  finally
                    aMask.Free;
                  end;
              end
            else
             if FMasked then
               begin
                  for i:=0 to alist.ItemCount(aIndex)-1 do
                    begin
                      aList[aIndex].GetBitmap(i, Image);
                      AddMasked(Image, Image.TransparentColor);
                   end;
               end
             else
              for i:=0 to alist.ItemCount(aIndex)-1 do
                begin
                  aList[aIndex].GetBitmap(i, Image);
                  Add(Image, nil);
               end;
          finally
            Free;
          end;
      end;
  finally
    EndUpdate(True);
  end;
end;

{------------------------------------------------------------------------------}
procedure TLMDImageListVCLConnector.Change;
begin
  if (FUpdateCount>0) or (csDestroying in ComponentState) then
    exit
  else
    inherited;
end;

{------------------------------------------------------------------------------}
procedure TLMDImageListVCLConnector.DefineProperties(Filer: TFiler);
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
//  Filer.DefineProperty('Left', ReadLeft, WriteLeft, LongRec(DesignInfo).Lo <> LongRec(Info).Lo);
//  Filer.DefineProperty('Top', ReadTop, WriteTop, LongRec(DesignInfo).Hi <> LongRec(Info).Hi);
end;

{------------------------------------------------------------------------------}
procedure TLMDImageListVCLConnector.Loaded;
begin
  inherited;
  CopyImages(FImageList, FListIndex);
end;

{------------------------------------------------------------------------------}
procedure TLMDImageListVCLConnector.Notification(aComponent: TComponent; Operation: TOperation);
begin
  inherited Notification(aComponent, Operation);
  if (Operation=opRemove) and (aComponent is TLMDImageList) then
    if (aComponent=FImageList) then SetImageList(nil);
end;

{------------------------------------------------------------------------------}
procedure TLMDImageListVCLConnector.BeginUpdate;
begin
  inc(FUpdateCount);
end;

{------------------------------------------------------------------------------}
procedure TLMDImageListVCLConnector.EndUpdate(repaint: Boolean=false);
begin
  Dec(FUpdateCount);
  if FUpdateCount=0 then
    if repaint then Change;
end;

{------------------------------------------------------------------------------}
procedure TLMDImageListVCLConnector.ImageListChange(Sender:TObject);
begin
  if not (csLoading in ComponentState) then
    CopyImages(FImageList, FListIndex);
end;

{------------------------- Public----------------------------------------------}
constructor TLMDImageListVCLConnector.Create(aOwner:TComponent);
begin
  inherited Create(aOwner);
  FListIndex:=0;
  FMasked:=True;
  FImageList:=nil;
  FChangeLink:=TChangeLink.Create;
  FChangeLink.OnChange:=ImageListChange;
end;

{------------------------------------------------------------------------------}
destructor TLMDImageListVCLConnector.Destroy;
begin
  FChangeLink.OnChange:=nil;
  FChangeLink.Free;
  inherited Destroy;
end;

{------------------------------------------------------------------------------}
function TLMDImageListVCLConnector.getLMDPackage: TLMDPackageID;
begin
  result:=pi_LMD_TOOLS;
end;

end.
