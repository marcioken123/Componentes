unit LMDSysEventListView;
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

LMDSysEventListView unit (RM)
-----------------------------


Changes
-------
Release 3.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  ComCtrls, CommCtrl,
  LMDSysBase, intfLMDBase, LMDTypes;

type

  { ************************************************************************** }
  TLMDSysEventListView = class(TCustomListView, ILMDComponent)
  private
    FAbout: TLMDAboutVar;
    FImageList:TImageList;
    FController:TLMDSysComponent;

    FHeaderHandle:HWND;
    FHeaderID:LongInt;
    FClickedColumn:Integer;
    FSortDirection:TLMDSysDirection;
    procedure AddColumn(const aCaption : string; aWidth : integer; Alignment:TAlignment=taLeftJustify);
    function CheckFlags:Boolean;
    procedure DrawHeaderItem(PDIS : PDrawItemStruct);
    procedure LoadImageList;
    procedure SetController(const Value: TLMDSysComponent);
    procedure SetSortDirection(const Value: TLMDSysDirection);
    procedure SetSortedColumn(const Value: Integer);
    procedure WMNotify(var Message: TWMNotify); message WM_NOTIFY;
    procedure WMParentNotify(var Message: TWMParentNotify); message WM_PARENTNOTIFY;
    protected
    procedure ColClick(Column: TListColumn); override;

    procedure DblClick; override;
    procedure Loaded; override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure WndProc(var Message: TMessage);override;

  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    function getLMDPackage:TLMDPackageID;  // specification in LMDTypes
    property LogControl:TLMDSysComponent read FController write SetController;
    property Items;
    procedure Sort;
    property SortedColumn:Integer read FClickedColumn write SetSortedColumn default -1;
    property SortDirection:TLMDSysDirection read FSortDirection write SetSortDirection default sdDescending;
  published
    property About: TLMDAboutVar read FAbout write FAbout stored false;
    property Align;
    property AllocBy;
    property Anchors;
    property BiDiMode;
    property BorderStyle;
    property BorderWidth;
    property Color;
    property Constraints;
    property Ctl3D;
    property Enabled;
    property Font;
    property FlatScrollBars;
    property GridLines;
    property HideSelection default false;
    property HotTrack;
    property HotTrackStyles;
    property HoverTime;
    property RowSelect default true;
    property ParentBiDiMode;
    property ParentColor default False;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property TabOrder;
    property TabStop default True;
    property Visible;
    property OnChange;
    property OnChanging;
    property OnClick;
    property OnContextPopup;
    property OnDblClick;
    property OnEnter;
    property OnExit;
    property OnInfoTip;
    property OnInsert;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnResize;
    property OnSelectItem;
  end;

implementation
uses
  Imglist,
  LMDSysConst, LMDSysEventLog;

const
  OneMillisecond = 1 / (24*60*60*1000);

{------------------------------------------------------------------------------}
function LMDCompareDateTime(const A, B: TDateTime):Integer;
begin
  if Abs(A - B) < OneMillisecond then Result := 0
  else if A < B then Result := -1 else Result := 1;
end;

{------------------------------------------------------------------------------}
function LMDCompareTime(const A, B: TDateTime): Integer;
begin
  if Abs(Frac(A)- Frac(B))<OneMillisecond then Result:=0
  else if Frac(A) < Frac(B) then Result:=-1 else Result:=1;
end;

{------------------------------------------------------------------------------}
function LMDCompareInt(const A, B: Integer): Integer;
begin
  if A=B then Result:=0
  else if A<B then Result:=-1 else Result:=1;
end;

{------------------------------------------------------------------------------}

function CustomSortProc(Item1, Item2: TListItem; Data: Integer): Integer; stdcall;

var
  tmp:Integer;
begin
  if Data>=50 then
    begin
      tmp:=-1;
      Data:=Data-50;
    end
  else
    tmp:=1;
  case Data of
  0: result:= AnsiCompareStr(Item1.Caption, Item2.Caption);
    1: result:= LMDCompareDateTime(StrToDate(Item1.SubItems[Data-1])+StrToTime(Item1.SubItems[Data]), StrToDate(Item2.SubItems[Data-1])+StrToTime(Item2.SubItems[Data]));
    2: result:= LMDCompareTime(StrToTime(Item1.SubItems[Data-1]), StrToTime(Item2.SubItems[Data-1]));
    5: result:=LMDCompareInt(StrToIntDef(Item1.SubItems[Data-1], 0), StrToIntDef(Item2.SubItems[Data-1],0));
    3,4,6,7: Result := AnsiCompareStr(Item1.SubItems[Data-1], Item2.SubItems[Data-1]);
    else
    result:=0;
  end;
  result:=tmp*result;
end;

{ ********************** TLMDSysEventListView *********************************}
{ ----------------------------- private -------------------------------------- }

procedure TLMDSysEventListView.AddColumn(const aCaption : string; aWidth : integer; Alignment: TAlignment = taLeftJustify);
var
  Col : TListColumn;
begin
  Col := Columns.Add;
  Col.Caption := aCaption;
  Col.Width := aWidth;
  Col.Alignment := Alignment;
  Col.Tag := Columns.Count - 1;
end;

{------------------------------------------------------------------------------}
function TLMDSysEventListView.CheckFlags: Boolean;
begin
 result:=not ((csDesigning in ComponentState) or (csLoading in ComponentState))
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDSysEventListView.DrawHeaderItem(PDIS : PDrawItemStruct);

var
  iSavedDC      : integer;
  rc            : TRect;
  rgn           : HRGN;
  szText        : string;
  hditem        : HD_ITEM;
  uFormat       : UINT;
  rcIcon        : TRect;
  iOffset       : Integer;
  Brush         : HBRUSH;
  penLight      : HPEN;
  penShadow     : HPEN;
  pOldPen       : HPEN;
  OldPos        : TPoint;
  begin
  with PDIS^ do
  begin
    rc := rcItem;
    iSavedDC:=hdC;
    try
      rgn := CreateRectRgnIndirect(rc);
      SelectObject(hDC, rgn);
      DeleteObject(rgn);

      Brush := CreateSolidBrush(GetSysColor( COLOR_3DFACE ));
      FillRect(PDIS^.hDC, rc, Brush);
      SetString(szText, nil, 256);
      hditem.mask := HDI_TEXT or HDI_FORMAT;
      hditem.pszText := PChar(szText);
      hditem.cchTextMax := 255;

      Header_GetItem(FHeaderHandle, PDIS^.itemID, hditem);
      uFormat := DT_LEFT or DT_SINGLELINE or DT_NOPREFIX or DT_NOCLIP or DT_VCENTER or DT_END_ELLIPSIS ;
      // we want Header always left aligned

      if itemState = ODS_SELECTED  then
        begin
          Inc(rc.left);
          Inc(rc.top,2);
          Inc(rc.right);
        end;

      rcIcon := rc;
      iOffset := round(( rcIcon.bottom - rcIcon.top ) / 4);

      if Columns[itemID].Tag = FClickedColumn then
        Dec(rc.right, 3 * iOffset);

      Inc(rc.left, iOffset);
      Dec(rc.right, iOffset);

      if rc.left < rc.right then
        DrawText(hDC, PChar(szText), -1, rc, uFormat );
        if Columns[itemID].Tag = FClickedColumn then
        begin
          // draw the error
          penLight := CreatePen(PS_SOLID, 1, GetSysColor( COLOR_3DHILIGHT ) );
          penShadow := CreatePen(PS_SOLID, 1, GetSysColor( COLOR_3DSHADOW ) );
          pOldPen := SelectObject(hDC, penLight);
          try
            if FSortDirection = sdAscending then
              begin
                MoveToEx(hDC, rcIcon.right - 2 * iOffset, iOffset, @OldPos);
                LineTo(hDC, rcIcon.right - iOffset, rcIcon.bottom - iOffset - 1 );
                LineTo(hDC, rcIcon.right - 3 * iOffset - 2, rcIcon.bottom - iOffset - 1 );
                SelectObject(hDC, penShadow);
                MoveToEx(hDC, rcIcon.right - 3 * iOffset - 1, rcIcon.bottom - iOffset - 1, @OldPos);
                LineTo(hDC, rcIcon.right - 2 * iOffset, iOffset - 1);
              end
            else
              begin
                MoveToEx(hDC, rcIcon.right - iOffset - 1, iOffset, @OldPos);
                LineTo(hDC, rcIcon.right - 2 * iOffset - 1, rcIcon.bottom - iOffset );
                SelectObject(hDC, penShadow);
                MoveToEx(hDC, rcIcon.right - 2 * iOffset - 2, rcIcon.bottom - iOffset, @OldPos);
                LineTo(hDC, rcIcon.right - 3 * iOffset - 1, iOffset );
                LineTo(hDC, rcIcon.right - iOffset - 1, iOffset );
              end;
          finally
            SelectObject(hDC, pOldPen);
            DeleteObject(penLight);
            DeleteObject(penShadow);
          end;
        end;

    finally
      RestoreDC(hDC,  iSavedDC);
    end;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDSysEventListView.LoadImageList;
var
  hImageList    : THandle;
  tmpBitmap     : TBitmap;
begin
  FImageList := TImageList.Create(nil);
  hImageList := ImageList_Create(16, 16, ILC_COLOR16 or ILC_MASK, 0, 1);
  FImageList.Handle := hImageList;

  tmpBitmap := TBitmap.Create;
  try
    tmpBitmap.LoadFromResourceName(HInstance,'LMDSYSEVENTLIST');
    FImageList.AddMasked(tmpBitmap, clFuchsia);
  finally
    tmpBitmap.Free;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDSysEventListView.SetController(const Value: TLMDSysComponent);
begin
  if FController<>Value then
    begin
      FController := Value;
      if FController<>nil then
        FController.FreeNotification(self);
    end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDSysEventListView.SetSortDirection(const Value: TLMDSysDirection);
begin
  if FSortDirection<>Value then
    begin
      FSortDirection := Value;
      if CheckFlags then Sort;
      if csDesigning in ComponentState then
        InvalidateRect(FHeaderHandle, nil, true);
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDSysEventListView.SetSortedColumn(const Value: Integer);
begin
  if FClickedColumn<>Value then
    begin
      FClickedColumn := Value;
      if CheckFlags then Sort;
      if csDesigning in ComponentState then
        InvalidateRect(FHeaderHandle, nil, true);
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDSysEventListView.WMParentNotify(var Message: TWMParentNotify);
begin
  with Message do
    if (Event = WM_CREATE) and (FHeaderHandle = 0) then
    begin
      FHeaderHandle := ChildWnd;
      FHeaderID := ChildID;
    end;
  inherited;
end;

//{------------------------------------------------------------------------------}

procedure TLMDSysEventListView.WMNotify(var Message: TWMNotify);

begin

  inherited;
  if (FHeaderHandle <> 0) and (Message.NMHdr^.hWndFrom = FHeaderHandle) then
  with Message.NMHdr^ do
    if Code = HDN_ITEMCHANGING then
       with PHDNotify(Pointer(Message.NMHdr))^ do
         if (PItem^.Mask and HDI_FORMAT) <> 0 then
           PItem^.fmt :=  PItem^.fmt or HDF_OWNERDRAW;

end;

{ --------------------------------- protected -------------------------------- }
procedure TLMDSysEventListView.ColClick(Column: TListColumn);
begin
  inherited;
  if FClickedColumn = Column.Index then
    begin
      if FSortDirection = sdAscending then
        FSortDirection := sdDescending
      else
        FSortDirection := sdAscending;
    end
  else
    begin
      FSortDirection:=sdAscending;
      FClickedColumn:=Column.Index;
    end;

  Sort;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDSysEventListView.DblClick;
begin
  if (FController<>nil) and (Selected<>nil) then
    if sdoListShowDialog in TLMDSysEventLog(FController).DlgOptions then
      with TLMDSysEventLog(FController) do
        begin
          Open;
          try
            ShowEventDialog(DWORD(Selected.Data)-DWORD(FirstRecordNr));
          finally
            Close;
          end;
        end;
  inherited;
end;

{------------------------------------------------------------------------------}
procedure TLMDSysEventListView.Loaded;
begin
  inherited;
  Sort;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDSysEventListView.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited Notification(aComponent, Operation);
  if AComponent = FController then
     if Operation = opRemove then FController:=nil;
end;

{------------------------------------------------------------------------------}
procedure TLMDSysEventListView.Sort;
begin
  if FClickedColumn=-1 then exit;
  CustomSort(@CustomSortProc, FClickedColumn+(Ord(FSortDirection)*50));
  if Visible and (FHeaderHandle<>0) then
    InvalidateRect(FHeaderHandle, nil, true);
end;

{------------------------------------------------------------------------------}
procedure TLMDSysEventListView.WndProc(var Message: TMessage);
begin
  case Message.Msg of
    WM_DRAWITEM :
    begin
      if Message.WParam = WPARAM(FHeaderID) then
      begin
        DrawHeaderItem(PDrawItemStruct(Pointer(Message.LParam)));
        Message.Result := 1;
        Exit;
      end;
    end;
    end;
  inherited;
end;

{ --------------------------------- public ----------------------------------- }
constructor TLMDSysEventListView.Create(AOwner: TComponent);
begin
  inherited;

  RowSelect:=True;
  DragMode := dmManual;
  ReadOnly := True;
  ViewStyle := vsReport;
  ShowColumnHeaders:=True;

  FHeaderHandle := 0;
  FHeaderID := 0;

  HideSelection:=false;
  FClickedColumn:=-1;
  FSortDirection:=sdDescending;

  AddColumn(sLMDSysEventType, 80);      // Tag=0
  AddColumn(sLMDSysEventDate, 70, taRightJustify);      // Tag=1
  AddColumn(sLMDSysEventTime, 70, taRightJustify);      // Tag=2
  AddColumn(sLMDSysEventSource, 100);   // Tag=3
  AddColumn(sLMDSysEventCategory, 60);  // Tag=4
  AddColumn(sLMDSysEventEvent, 60);     // Tag=5
  AddColumn(sLMDSysEventUser, 100);     // Tag=6
  AddColumn(sLMDSysEventComputer, 100); // Tag=7

  LoadImageList;
  SmallImages := FImageList;
end;

{ ---------------------------------------------------------------------------- }
destructor TLMDSysEventListView.Destroy;
begin
  FreeAndNil(FImageList);
  inherited Destroy;
end;

{ ---------------------------------------------------------------------------- }
function TLMDSysEventListView.getLMDPackage: TLMDPackageID;
begin
  result:=pi_LMD_SYS;
end;

end.
