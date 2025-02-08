unit pLMDImageBox;

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

pLMDImageBox unit (RM)
----------------------
Common control for all Packs / used at Designtime

Changes
-------
Release 8.0 (October 2006)
 - Initial Release

###############################################################################}

interface
{$I lmdcmps.inc}
uses
  Windows,
  Messages,
  Graphics,
  Classes,
  Controls,
  ExtCtrls,
  Stdctrls,
  imglist,
  sysutils;

type

  {---------------------- TLMDImageCBox ----------------------------------------}
  TLMDImageCBox = class(TCustomComboBox)
  private
    FOnSelect    : TNotifyEvent;
    FImageList:TCustomImageList;
    FWidth, FHeight:Integer;
    FChangeLink:TChangeLink;
    FNeedToPopulate: Boolean;
    FImageIndex:Integer;
    function GetImageIndex:Integer;
    procedure SetImageList(aValue:TCustomImageList);
    procedure SetImageIndex(aValue:Integer);

    procedure CNCommand(var Message: TWMCommand); message CN_COMMAND;
  protected
    procedure CreateWnd; override;
    procedure DrawItem(Index: Integer; Rect: TRect; State: TOwnerDrawState); override;
    procedure GetChange(Sender:TObject);
    procedure Loaded; override;
    procedure Notification(AComponent: TComponent; Operation: TOperation);override;
    procedure PopulateList;
    procedure DoSelect;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy;override;

  published
    property ImageIndex: Integer read GetImageIndex write SetImageIndex default -1;
    property ImageList:TCustomImageList read FImagelist write SetImageList;
    property OnSelect : TNotifyEvent read FOnSelect write FOnSelect;

    property Anchors;
    property BevelEdges;
    property BevelInner;
    property BevelKind;
    property BevelOuter;
    property BiDiMode;
    property Color;
    property Constraints;
    property Ctl3D;
    property DropDownCount;
    property Enabled;
    property Font;
    property ItemHeight;
    property ParentBiDiMode;
    property ParentColor;
    property ParentCtl3D;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property TabOrder;
    property TabStop;
    property Visible;
    property OnChange;
    property OnClick;
    property OnContextPopup;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnDropDown;
    property OnEndDock;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnStartDock;
    property OnStartDrag;
  end;

  {---------------------- TLMDImageLBox ----------------------------------------}
  TLMDImageLBox = class(TCustomListBox)
  private
    FOnSelect    : TNotifyEvent;
    FImageList:TCustomImageList;
    FWidth, FHeight:Integer;
    FChangeLink:TChangeLink;
    FNeedToPopulate: Boolean;
    FImageIndex:Integer;
    function GetImageIndex:Integer;
    procedure SetImageList(aValue:TCustomImageList);
    procedure SetImageIndex(aValue:Integer);

    procedure CNCommand(var Message: TWMCommand); message CN_COMMAND;
  protected
    procedure CreateWnd; override;
    procedure DrawItem(Index: Integer; Rect: TRect; State: TOwnerDrawState); override;
    procedure MeasureItem(Index: Integer; var Height: Integer); override;
    procedure GetChange(Sender:TObject);
    procedure Loaded; override;
    procedure Notification(AComponent: TComponent; Operation: TOperation);override;
    procedure PopulateList;
    procedure DoSelect;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy;override;

  published
    property ImageIndex: Integer read GetImageIndex write SetImageIndex default -1;
    property ImageList:TCustomImageList read FImagelist write SetImageList;
    property OnSelect : TNotifyEvent read FOnSelect write FOnSelect;

    property Anchors;
    property BevelEdges;
    property BevelInner;
    property BevelKind;
    property BevelOuter;
    property BiDiMode;
    property Color;
    property Constraints;
    property Ctl3D;
    property Enabled;
    property Font;
    property ItemHeight;
    property ParentBiDiMode;
    property ParentColor;
    property ParentCtl3D;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property TabOrder;
    property TabStop;
    property Visible;
    property OnClick;
    property OnContextPopup;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDock;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnStartDock;
    property OnStartDrag;
  end;

implementation
{********************* Class TLMDImageCBox *************************************}
{----------------------- Private ----------------------------------------------}
procedure TLMDImageCBox.SetImageList(aValue:TCustomImageList);
begin
  if FImageList<>nil then
    FImageList.UnRegisterChanges(FChangeLink);
  FImageList:=aValue;
  if FImageList<>nil then
    begin
      FWidth:=FImageList.Width;
      FHeight:=FImageList.Height;
      FImageList.RegisterChanges(FChangeLink);
      FImageList.FreeNotification(Self);
    end;
  GetChange(FImageList);
end;

{------------------------------------------------------------------------------}
procedure TLMDImageCBox.SetImageIndex(aValue:Integer);
begin
  if aValue<>FImageIndex then
    begin
      if (aValue<Items.Count) and (aValue>-1) then
        FImageIndex:=aValue
      else
        FImageIndex:=-1;
      if HandleAllocated then
        ItemIndex:=FImageIndex;
    end;
end;

{------------------------------------------------------------------------------}
function TLMDImageCBox.GetImageIndex:Integer;
begin
  if HandleAllocated then
    result:=ItemIndex
  else
    result:=FImageIndex;
end;

{------------------------------------------------------------------------------}
procedure TLMDImageCBox.CNCommand(var Message: TWMCommand);
begin
  inherited;
  if message.NotifyCode = CBN_SELCHANGE then
    begin
      If Itemindex<>-1 then
        Text := Items[ItemIndex]
      else
        Text :='';
      Click;
      DoSelect;
    end;
end;

{----------------------- Protected --------------------------------------------}
procedure TLMDImageCBox.CreateWnd;
begin
  inherited CreateWnd;
  if FNeedToPopulate then PopulateList;
end;

{------------------------------------------------------------------------------}
procedure TLMDImageCBox.DrawItem(Index: Integer; Rect: TRect; State: TOwnerDrawState);
var
  w, h:Integer;
  aRect: TRect;
  aBitmap:TBitmap;
  r:Extended;
begin
  if Index=-1 then exit;
  with Canvas do
    begin
      FillRect(Rect);
      aRect:=Rect;
      InflateRect(aRect, -1, -1);

      r:=0;

      // determine height
      h:=aRect.Bottom-aRect.Top;
      if FHeight<h then
        begin
          aRect.Top:=aRect.Top+(aRect.Bottom-aRect.Top-Fheight) div 2;
          h:=FHeight;
        end
      else
        r:=h/Fheight;
      aRect.Bottom:=aRect.Top+h;

      // determine width
      if r<>0 then
        w:=Round(r*FWidth)
      else
        begin
          w:=aRect.Right-aRect.Left-30;
          if FWidth<w then w:=FWidth;
        end;
      aRect.Right:=aRect.Left+w;

      TextRect(Rect,Rect.Left+w+4,Rect.Top+(Rect.Bottom-Rect.Top-TextHeight('W')) div 2, Inttostr(Index));

      aBitmap:=TBitmap.Create;
      try
        FImageList.GetBitmap(Index, aBitmap);
        Canvas.StretchDraw(aRect, aBitmap);
      finally
        aBitmap.Free;
      end;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDImageCBox.GetChange(Sender:TObject);
begin
  if Sender=FImageList then
    PopulateList;
  if HandleAllocated then
    Invalidate
end;

{------------------------------------------------------------------------------}
procedure TLMDImageCBox.Loaded;
begin
  inherited;
  PopulateList;
  ItemIndex:=FImageIndex;
end;

{------------------------------------------------------------------------------}
procedure TLMDImageCBox.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) then
    if (FImageList<>nil) and (AComponent=FImageList) then
      ImageList := nil;
end;

{------------------------------------------------------------------------------}
procedure TLMDImageCBox.PopulateList;
var
  i:Integer;
begin
  if HandleAllocated then
    begin
      try
        Items.BeginUpdate;
        Items.Clear;
        if FImageList<>nil then
          for i:=0 to Pred(FImageList.Count) do Items.Add(' ')
      finally
        Items.EndUpdate;
        FNeedToPopulate := False;
      end;
    end
  else
    FNeedToPopulate := True;
end;

{------------------------------------------------------------------------------}
procedure TLMDImageCBox.DoSelect;
begin
  if Assigned(FOnSelect) then FOnSelect(self);
end;

{----------------------- Public -----------------------------------------------}
constructor TLMDImageCBox.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  inherited Style := csOwnerDrawFixed;
  FChangeLink := TChangeLink.Create;
  FChangeLink.OnChange := GetChange;
  FImageIndex:=-1;
end;

{------------------------------------------------------------------------------}
destructor TLMDImageCBox.Destroy;
begin
  FChangeLink.Free;
  inherited;
end;

{********************* Class TLMDImageLBox ************************************}
{----------------------- Private ----------------------------------------------}
procedure TLMDImageLBox.SetImageList(aValue:TCustomImageList);
begin
  if FImageList<>nil then
    FImageList.UnRegisterChanges(FChangeLink);
  FImageList:=aValue;
  if FImageList<>nil then
    begin
      FWidth:=FImageList.Width;
      FHeight:=FImageList.Height;
      FImageList.RegisterChanges(FChangeLink);
      FImageList.FreeNotification(Self);
    end;
  GetChange(FImageList);
end;

{------------------------------------------------------------------------------}
procedure TLMDImageLBox.SetImageIndex(aValue:Integer);
begin
  if aValue<>FImageIndex then
    begin
      if (aValue<Items.Count) and (aValue>-1) then
        FImageIndex:=aValue
      else
        FImageIndex:=-1;
      if HandleAllocated then
        ItemIndex:=FImageIndex;
    end;
end;

{------------------------------------------------------------------------------}
function TLMDImageLBox.GetImageIndex:Integer;
begin
  if HandleAllocated then
    result:=ItemIndex
  else
    result:=FImageIndex;
end;

{------------------------------------------------------------------------------}
procedure TLMDImageLBox.CNCommand(var Message: TWMCommand);
begin
  inherited;
  if message.NotifyCode = CBN_SELCHANGE then
    begin
      If Itemindex<>-1 then
        Text := Items[ItemIndex]
      else
        Text :='';
      Click;
      DoSelect;
    end;
end;

{----------------------- Protected --------------------------------------------}
procedure TLMDImageLBox.CreateWnd;
begin
  inherited CreateWnd;
  if FNeedToPopulate then PopulateList;
end;

{------------------------------------------------------------------------------}
procedure TLMDImageLBox.DrawItem(Index: Integer; Rect: TRect; State: TOwnerDrawState);
var
  w:Integer;
  aRect: TRect;
  aBitmap:TBitmap;
begin
  if Index=-1 then exit;
  with Canvas do
    begin
      FillRect(Rect);
      aRect:=Rect;
      InflateRect(aRect, -1, -1);
      // determine width
      w:=aRect.Right-aRect.Left-30;
      if FWidth<w then w:=FWidth;
      aRect.Right:=aRect.Left+w;

      TextRect(Rect,Rect.Left+w+4,Rect.Top+(Rect.Bottom-Rect.Top-TextHeight('W')) div 2, Inttostr(Index));

      aBitmap:=TBitmap.Create;
      try
        FImageList.GetBitmap(Index, aBitmap);
        Canvas.StretchDraw(aRect, aBitmap);
      finally
        aBitmap.Free;
      end;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDImageLBox.MeasureItem(Index: Integer; var Height: Integer);
begin
  Height:=FHeight;
end;

{------------------------------------------------------------------------------}
procedure TLMDImageLBox.GetChange(Sender:TObject);
begin
  if Sender=FImageList then
    PopulateList;
  if HandleAllocated then
    Invalidate
end;

{------------------------------------------------------------------------------}
procedure TLMDImageLBox.Loaded;
begin
  inherited;
  PopulateList;
  ItemIndex:=FImageIndex;
end;

{------------------------------------------------------------------------------}
procedure TLMDImageLBox.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) then
    if (FImageList<>nil) and (AComponent=FImageList) then
      ImageList := nil;
end;

{------------------------------------------------------------------------------}
procedure TLMDImageLBox.PopulateList;
var
  i:Integer;
begin
  if HandleAllocated then
    begin
      try
        Items.BeginUpdate;
        Items.Clear;
        if FImageList<>nil then
          for i:=0 to Pred(FImageList.Count) do Items.Add(' ')
      finally
        Items.EndUpdate;
        FNeedToPopulate := False;
      end;
    end
  else
    FNeedToPopulate := True;
end;

{------------------------------------------------------------------------------}
procedure TLMDImageLBox.DoSelect;
begin
  if Assigned(FOnSelect) then FOnSelect(self);
end;

{----------------------- Public -----------------------------------------------}
constructor TLMDImageLBox.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  inherited Style := lbOwnerDrawVariable;
  FChangeLink := TChangeLink.Create;
  FChangeLink.OnChange := GetChange;
  FImageIndex:=-1;
end;

{------------------------------------------------------------------------------}
destructor TLMDImageLBox.Destroy;
begin
  FChangeLink.Free;
  inherited;
end;

end.
