unit LMDCaptionPanelGroup;
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

LMDCaptionPanelGroup unit (RM)
------------------------------

Changes
-------
Release 8.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Windows, Classes, Controls, Messages, Forms, Graphics, StdCtrls,
  LMDBase, LMDGraph, LMDIniCtrl, LMDCaptionPanel, LMDCustomPanelFill;

const
  IDS_CAPTIONPANELGROUPSAVE:String='CPANEL';  // do not localize

  CM_LMDUpdatePanel = WM_USER + 9276;

type
  TLMDCPGIniSaveOption = (cpgIndex, cpgState, cpgVisible, cpgDimensions, cpgScrollPos);
  TLMDCPGIniSaveOptions = set of TLMDCPGIniSaveOption;

const
  def_LMDCPGOptions=[cpgIndex, cpgState, cpgVisible, cpgDimensions, cpgScrollPos];

type
  TLMDCaptionPanelGroup=class(TLMDCustomPanelFill)
  private
    FAutoExpand: boolean;
    FOrientation: TLMDOrientation;
    FPanels:TList;
    FPanelGap,
    FMargin: Byte;
    FScrollBar:TScrollBar;
    FHeight:Integer;
    FOnScroll:TNotifyEvent;

    // TLMDIniCtrl Support
    FIniSection,
    FIniKey         : String;
    FIniLink        : TLMDIniCtrl;
    FIniSaveOptions : TLMDCPGIniSaveOptions;
    FIniUse         : TLMDIniUse;

    FOnIniReadData  : TLMDIniCtrlEvent;
    FOnIniWriteData : TLMDIniCtrlEvent;

    procedure SetAutoExpand(aValue: boolean);
    procedure SetIniLink (aValue : TLMDIniCtrl);
    function SaveIniKey : Boolean;
    function SaveIniSection : Boolean;
    // -----

    function GetPanelByCaption(PanelCaption: String): TLMDCaptionPanel;
    function GetPanelByIndex(PanelIndex: integer): TLMDCaptionPanel;
    function GetPanelByName(PanelName: String): TLMDCaptionPanel;
    function GetPanelByData(PanelData: String): TLMDCaptionPanel;
    procedure SetOrientation(const Value: TLMDOrientation);
    procedure SetPanelGap(const Value: Byte);
    procedure SetMargin(const Value: Byte);
    procedure CMTabStopChanged(var Message: TMessage); message CM_TABSTOPCHANGED;
    procedure WMNCCalcSize(var Message: TWMNCCALCSIZE); message WM_NCCALCSIZE;
    procedure WMNCPaint(var Msg: TWMNCPaint); message WM_NCPAINT;
    procedure WMSize(var Msg: TWMSize); message WM_SIZE;
    procedure CMLMDUpdatePanel(var Msg: TMessage); message CM_LMDUpdatePanel;
  protected
    procedure AdjustClientRect(var Rect: TRect); override;
    procedure AlignControls(AControl: TControl; var Rect: TRect);override;
    procedure Loaded; override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override ;

    function DoReadData:Boolean;dynamic;
    procedure DoWriteData;dynamic;

    procedure DoScroll(Sender: TObject);
    function DoMouseWheelDown(Shift: TShiftState; MousePos: TPoint): Boolean;override;
    function DoMouseWheelUp(Shift: TShiftState; MousePos: TPoint): Boolean;override;
    procedure GetChange(Sender:TObject);override;
    procedure InitScrollBar;
    procedure Paint;override;

    // not for public use
    procedure FixPanelIndex;virtual;
    procedure UpdatePanelIndex(Value, old:Integer);virtual;

  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    // causes ReInit of all Panels
    procedure Change;
    // collapses all panels
    procedure CollapseAll;
    // Expands all panels
    procedure ExpandAll;
    // Sets position of ScrollBar to make aControl visible
    procedure ScrollInView(AControl: TControl);

    procedure AllowSizingAll(Value:Boolean=True);
    procedure AllowMovingAll(Value:Boolean=True);

    // returns max PanelIndex
    function PanelMaxIndex: Integer;
    // returns PanelIndex at Position X,Y
    function PanelIndexAtPos(X, Y: Integer): Integer;
    // Echanges PanelIndex values
    procedure PanelExchange(OldIndex, NewIndex:Integer);
    procedure PanelList(Value:TStrings; CustomData:Boolean=false);overload;
    procedure PanelList(Value:TList);overload;
    property PanelByName[PanelName:String]:TLMDCaptionPanel read GetPanelByName;
    property Panels[PanelIndex:integer]:TLMDCaptionPanel read GetPanelByIndex;
    property PanelByData[PanelData:String]:TLMDCaptionPanel read GetPanelByData;
    property PanelByCaption[PanelCaption:String]:TLMDCaptionPanel read GetPanelByCaption;

    // Read Only access
    property ScrollBar:TScrollBar read FScrollBar;
  published
    property AutoExpand: boolean read FAutoExpand write SetAutoExpand default false;
    property PanelGap:Byte read FPanelGap write SetPanelGap default 1;
    property Orientation:TLMDOrientation read FOrientation write SetOrientation default toVertical;
    property Margin:Byte read FMargin write SetMargin default 3;

    property OnScroll:TNotifyEvent read FOnScroll write FOnScroll;

    // Ini-Support
    property IniKey         : String read FIniKey write FIniKey stored SaveIniKey;
    property IniSection     : String read FIniSection write FIniSection stored SaveIniSection;
    property IniLink        : TLMDIniCtrl read FIniLink write SetIniLink;
    property IniSaveOptions : TLMDCPGIniSaveOptions read FIniSaveOptions write FIniSaveOptions default def_LMDCPGOptions;
    property IniUse         : TLMDIniUse read FIniUse write FIniUse default ioNone;

    property OnIniReadData  : TLMDIniCtrlEvent read FOnIniReadData write FOnIniReadData;
    property OnIniWriteData : TLMDIniCtrlEvent read FOnIniWriteData write FOnIniWriteData;

    // LMD V7 Enhancements
    property AllowSizing default false;
    property AllowMoving default false;
    property ControlLocked;

    // V4 enhancements
    property Anchors;
    property AutoSize;
    property Constraints;
    property UseDockManager default false;
    property DockSite;
    property DragKind;
    property BiDiMode;
    property ParentBiDiMode;

    property OnCanResize;
    property OnConstrainedResize;
    property OnDockDrop;
    property OnDockOver;
    property OnEndDock;
    property OnGetSiteInfo;
    property OnStartDock;
    property OnUnDock;

    Property About;
    property Align;
    property Bevel;
    property Color;
    property Ctl3D;
    property DragCursor;
    property DragMode;
    property Enabled;
    property Font;
    property Locked;
    property ParentColor;
    property ParentCtl3D;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property TabOrder;
    property TabStop;
    property Transparent;
    property TransparentBorder;
    property Visible;

    property OnClick;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseEnter;
    property OnMouseExit;
    property OnMouseUp;
    property OnResize;
    property OnStartDrag;
    property OnContextPopup;
    {$IFDEF LMDCOMP9}
    property OnMouseActivate;
    {$ENDIF}
  end;

implementation

uses
  RtlConsts, Types, SysUtils, ExtCtrls,
  LMDClass, LMDSysIn, LMDButtonBase, LMDProcs, LMDFxCaption;

// helper for sorting

function ComparePanels(Item1, Item2: Pointer): Integer;

begin
  result := 0;
  if TLMDCaptionPanel(Item1).PanelIndex<TLMDCaptionPanel(Item2).PanelIndex then
    result := -1
  else
    if TLMDCaptionPanel(Item1).PanelIndex>TLMDCaptionPanel(Item2).PanelIndex then
      result := 1;
end;

{***********************  TLMDCaptionPanelGroup *******************************}
{ ---------------------- private --------------------------------------------- }
procedure TLMDCaptionPanelGroup.SetAutoExpand(aValue: boolean);
begin
  FAutoExpand := aValue;
end;

{------------------------------------------------------------------------------}
procedure TLMDCaptionPanelGroup.SetIniLink(aValue:TLMDIniCtrl);
begin
  FIniLink:=aValue;
  if FIniLink<>nil then FIniLink.FreeNotification(Self);
end;

{------------------------------------------------------------------------------}
function TLMDCaptionPanelGroup.SaveIniKey: Boolean;
begin
  result:=(FIniKey<>'') and (FIniKey<>IDS_CAPTIONPANELGROUPSAVE);
end;

{------------------------------------------------------------------------------}
function TLMDCaptionPanelGroup.SaveIniSection: Boolean;
begin
  result:=(FIniSection<>'') and (FIniSection<>IDS_COMMON);
end;

{------------------------------------------------------------------------------}
procedure TLMDCaptionPanelGroup.SetMargin(const Value: Byte);
begin
  if Value<>FMargin then
    begin
      FMargin := Value;
      Change;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDCaptionPanelGroup.SetOrientation(const Value: TLMDOrientation);
var
  i: integer;
  cp: TLMDCaptionPanel;
  lr,tb: boolean;
begin
  if Value <> FOrientation then
    begin
      FOrientation := Value;
      for i := 0 to ControlCount - 1 do
        if (Controls[i] is TLMDCaptionPanel) then
          begin
            cp := TLMDCaptionPanel(Controls[i]);
            lr := cp.CaptionSettings.Position in [fsLeft, fsRight];
            tb := cp.CaptionSettings.Position in [fsTop, fsBottom];
            if not cp.Expanded then
              begin
                //this block expands all panels that were collapsed
                //if changing orientation makes them impossible to stay collapsed
                if AutoExpand then
                  if (lr and (FOrientation = toVertical)) or (tb and (FOrientation = toHorizontal)) then
                    cp.Expand;
                //this block assures that all collapsed panels become actually collapsed
                //after changing orientation if caption&orinetation configuration
                //allows collapsing
                if (lr and (FOrientation = toHorizontal) or tb and (FOrientation = toVertical)) then
                  begin
                    cp.Expand;
                    cp.Collapse;
                 end;
              end;
          end;
      Change;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDCaptionPanelGroup.SetPanelGap(const Value: Byte);
begin
  if FPanelGap<>Value then
    begin
      FPanelGap := Value;
      Change;
    end;
end;

{------------------------------------------------------------------------------}
function TLMDCaptionPanelGroup.GetPanelByCaption(PanelCaption: String): TLMDCaptionPanel;
var
  i:Integer;
begin
  result:=nil;
  for i:=0 to Pred(ControlCount) do
   if (Controls[I] is TLMDCaptionPanel) then
     if PanelCaption=TLMDCaptionPanel(Controls[I]).Caption then
       begin
         result:=TLMDCaptionPanel(Controls[I]);
         break;
       end;
end;

{------------------------------------------------------------------------------}
function TLMDCaptionPanelGroup.GetPanelByIndex(PanelIndex: integer): TLMDCaptionPanel;
var
  i:Integer;
begin
  result:=nil;
  for i:=0 to Pred(ControlCount) do
   if (Controls[I] is TLMDCaptionPanel) then
     if PanelIndex=TLMDCaptionPanel(Controls[I]).PanelIndex then
       begin
         result:=TLMDCaptionPanel(Controls[I]);
         break;
       end;
end;

{------------------------------------------------------------------------------}
function TLMDCaptionPanelGroup.GetPanelByName(PanelName: String): TLMDCaptionPanel;
var
  i:Integer;
begin
  result:=nil;
  for i:=0 to Pred(ControlCount) do
   if (Controls[I] is TLMDCaptionPanel) then
     if PanelName=TLMDCaptionPanel(Controls[I]).Name then
       begin
         result:=TLMDCaptionPanel(Controls[I]);
         break;
       end;
end;

{------------------------------------------------------------------------------}
function TLMDCaptionPanelGroup.GetPanelByData(PanelData: String): TLMDCaptionPanel;
var
  i:Integer;
begin
  result:=nil;
  for i:=0 to Pred(ControlCount) do
   if (Controls[I] is TLMDCaptionPanel) then
     if PanelData=TLMDCaptionPanel(Controls[I]).CustomData then
       begin
         result:=TLMDCaptionPanel(Controls[I]);
         break;
       end;
end;

{------------------------------------------------------------------------------}
procedure TLMDCaptionPanelGroup.CMTabStopChanged(var Message: TMessage);
begin
  inherited;
  if (csDesigning in ComponentState) then exit;
  FScrollBar.TabStop:=self.TabStop;
end;

{------------------------------------------------------------------------------}
procedure TLMDCaptionPanelGroup.WMSize(var Msg: TWMSize);
begin
  inherited;
  InitScrollBar;
  ReAlign;
  Perform(WM_NCPaint, 0,0);
end;

{------------------------------------------------------------------------------}

procedure TLMDCaptionPanelGroup.WMNCCalcSize(var Message: TWMNCCalcSize);
begin
 inherited;
 with Message.CalcSize_Params^ do
    rgrc[0]:=Rect(rgrc[0].Left+FBevel.BevelExtend, rgrc[0].Top+FBevel.BevelExtend,
             rgrc[0].Right-FBevel.BevelExtendRight, rgrc[0].Bottom-FBevel.BevelExtendRight);
end;

{------------------------------------------------------------------------------}
procedure TLMDCaptionPanelGroup.WMNCPaint(var Msg: TWMNCPaint);
var
  DC:HDC;
begin
  if (csLoading in ComponentState) and not IsWindowVisible(Handle) then exit;
  inherited;
  DC:=GetWindowDC(Handle);
  if DC<>0 then
    try
      Canvas.Lock;
      try
        Canvas.Handle:=DC;
        try
          Bevel.PaintBevel(Canvas, Rect(0,0, Width, Height), false);
        finally
          Canvas.Handle:=0;
        end;
      finally
        Canvas.UnLock;
      end;
    finally
      ReleaseDC(Handle, DC);
    end;
end;

{------------------------ protected -------------------------------------------}
procedure TLMDCaptionPanelGroup.AdjustClientRect(var Rect: TRect);
begin
  Rect:=ClientRect;
  inherited;
end;

{------------------------------------------------------------------------------}
procedure TLMDCaptionPanelGroup.AlignControls(AControl: TControl; var Rect: TRect);
var
  //Panels:TList;
  i, cwi, cp:Integer;

begin
  inherited AlignControls(aControl, Rect);

  if isUpdating or (csLoading in ComponentState) then exit;

  FPanels.Clear;
  // Count all Panels
  for i:=0 to Pred(ControlCount) do
    if (Controls[I] is TLMDCaptionPanel) then
      if (TLMDCaptionPanel(Controls[i]).Visible) or (csDesigning in ComponentState) then  // at Designtime we show all buttons
        FPanels.Add(Controls[i]);

  FPanels.Sort(ComparePanels);

  if FOrientation=toHorizontal then
    begin
      cp:=FMargin-FScrollBar.Position;
      // calculate!!
      cwi:=ClientHeight-2*FMargin;
      if FScrollBar.Visible then
        cwi:=cwi-FScrollBar.Height;

      for i:=0 to Pred(FPanels.Count) do
        with TLMDCaptionPanel(FPanels[i]) do
          begin
            SetBounds(cp, FMargin, Width, cwi);
            Inc(cp, Width+FPanelGap);
          end;
    end
  else
    begin
      cp:=FMargin-FScrollBar.Position; //aRect.Top+FMargin;
      // calculate!!
      cwi:=ClientWidth-2*FMargin;
      if FScrollBar.Visible then
        cwi:=cwi-FScrollBar.Width;
      for i:=0 to Pred(FPanels.Count) do
        with TLMDCaptionPanel(FPanels[i]) do
          begin
            SetBounds(FMargin, cp, cwi, Height);
            Inc(cp, Height+FPanelGap);
          end
      end;
end;

type
  THackPanel=class(TLMDCaptionPanel)
  public
    property InternalSize;
  end;

{------------------------------------------------------------------------------}
function TLMDCaptionPanelGroup.DoReadData:Boolean;

  procedure DoReadValues(aLink:TLMDIniCtrl);
  var
    tmp:TLMDCaptionPanel;
    i:Integer;

    function FindPanelByName(const Value:String):TLMDCaptionPanel;
    var
      j:Integer;
    begin
      result:=nil;
      for j:=0 to Pred(ControlCount) do
        if (Controls[j] is TLMDCaptionPanel) and (Controls[j].Name=Value) then
          begin
            result:=TLMDCaptionPanel(Controls[j]);
            break;
          end;
    end;

  begin
    with aLink do
      begin
        //store amount of sections
        for i := 0 to ReadInteger(FIniSection, FIniKey + 'PanelCount', 0)-1 do
          begin
            tmp:=FindPanelByName(ReadString(FIniSection, FIniKey +'N'+IntToStr(i), ''));
            if Assigned(tmp) then
              with tmp do
                begin
                  BeginUpdate;
                  if cpgIndex in FIniSaveOptions then
                    PanelIndex:=ReadInteger(FIniSection, FIniKey + 'I'+IntToStr(i), -1);
                  if cpgState in FIniSaveOptions then
                    Expanded:=ReadBool(FIniSection, FIniKey + 'S'+IntToStr(i), True);
                  if cpgVisible in FIniSaveOptions then
                    Visible:=ReadBool(FIniSection, FIniKey + 'V'+IntToStr(i), True);
                  if cpgDimensions in FIniSaveOptions then
                    if not Expanded then
                      THackPanel(tmp).InternalSize:=ReadInteger(FIniSection, FIniKey + 'D'+IntToStr(i), 100)
                    else
                      if Orientation=toVertical then
                        Height:=ReadInteger(FIniSection, FIniKey + 'D'+IntToStr(i), Height)
                      else
                        Width:=ReadInteger(FIniSection, FIniKey +'D'+IntToStr(i), Width);
                  EndUpdate(false);
              end;
          end;
        if cpgScrollPos in FIniSaveOptions then
            FScrollBar.Position:=ReadInteger(FIniSection, FIniKey + 'ScrollPos', FScrollBar.Position);
      end;

    if Assigned(FOnIniReadData) then FOnIniReadData(self, aLink, FIniSection);
    result:=True;
  end;

begin
  result:=false;
  if (FIniUse=ioUseLink) and Assigned(FIniLink) then
    DoReadValues(FiniLink)
  else
    if FIniUse=ioUseGlobal then
      DoReadValues(LMDApplication.Ini)
    else
      if Assigned(FOnIniReadData) then FOnIniReadData(self, nil, FIniSection);

end;

{------------------------------------------------------------------------------}
procedure TLMDCaptionPanelGroup.DoWriteData;

  procedure WriteValues(aLink:TLMDIniCtrl);
  var
    i: Integer;
    tmp:TList;
  begin
    if aLink = nil then exit;

    tmp:=Tlist.Create;
    with aLink do
     try

        //we have to remove everything
        EraseSection (FIniSection);

        //store amount of sections
        WriteInteger (FIniSection, FIniKey + 'PanelCount', FPanels.Count);
        if cpgScrollPos in FIniSaveOptions then
            WriteInteger(FIniSection, FIniKey + 'ScrollPos', FScrollBar.Position);

        PanelList(tmp);
        for i := 0 to tmp.Count-1 do
          with TLMDCaptionPanel(tmp[i]) do
            begin

              WriteString(FIniSection, FIniKey + 'N'+IntToStr(i), Name);

              if cpgIndex in FIniSaveOptions then
                WriteInteger(FIniSection, FIniKey + 'I'+IntToStr(i), PanelIndex);

              if cpgState in FIniSaveOptions then
                WriteBool(FIniSection, FIniKey + 'S'+IntToStr(i), Expanded);

              if cpgVisible in FIniSaveOptions then
                WriteBool(FIniSection, FIniKey + 'V'+IntToStr(i), Visible);

              if cpgDimensions in FIniSaveOptions then
                if not Expanded then
                  WriteInteger(FIniSection, FIniKey +'D'+IntToStr(i), THackPanel(FPanels[i]).InternalSize)
                else
                  if Orientation=toVertical then
                    WriteInteger(FIniSection, FIniKey +'D'+IntToStr(i), Height)
                  else
                    WriteInteger(FIniSection, FIniKey +'D'+IntToStr(i), Width);

          end;
      finally
        tmp.Free;
      end;
    if Assigned(FOnIniWriteData) then FOnIniWriteData(self, aLink, FIniSection);
  end;

begin
  if (FIniUse=ioUseLink) and Assigned(FIniLink) then
    WriteValues(FiniLink)
  else
    if FIniUse=ioUseGlobal then
      WriteValues(LMDApplication.Ini)
    else
     if Assigned(FOnIniWriteData) then FOnIniWriteData(self, nil, FIniSection);
end;

{------------------------------------------------------------------------------}
function TLMDCaptionPanelGroup.DoMouseWheelDown(Shift: TShiftState; MousePos: TPoint): Boolean;
begin
  inherited DoMouseWheelDown(Shift, MousePos);
  if FScrollBar.Visible and (FScrollBar.Position+FScrollBar.PageSize<FScrollBar.Max) then
    FScrollBar.Position:=FScrollBar.Position+FScrollBar.PageSize;
  result:=True;
end;

{------------------------------------------------------------------------------}
function TLMDCaptionPanelGroup.DoMouseWheelUp(Shift: TShiftState; MousePos: TPoint): Boolean;
begin
  inherited DoMouseWheelUp(Shift, MousePos);
  if FScrollBar.Visible and (FScrollBar.Position>0) then
    FScrollBar.Position:=FScrollBar.Position-FScrollBar.PageSize;
  result:=True;
end;

{------------------------------------------------------------------------------}
procedure TLMDCaptionPanelGroup.DoScroll(Sender: TObject);
begin
  if FScrollBar.Position>FScrollbar.Max-FScrollbar.Pagesize then
    Change
  else
    ReAlign;
  if Assigned(FOnScroll) then FOnScroll(self);
end;

{------------------------------------------------------------------------------}
procedure TLMDCaptionPanelGroup.FixPanelIndex;
var
  Panels:TList;
  i:Integer;
begin
  Panels:=TList.Create;
  try
    for i:=0 to Pred(ControlCount) do
      if (Controls[I] is TLMDCaptionPanel) then
            begin
      Panels.Add(Controls[i]);
      end;
    Panels.Sort(ComparePanels);
    for i:=0 to Pred(Panels.Count) do
      with TLMDCaptionPanel(Panels[I]) do
        begin
          BeginUpdate; PanelIndex:=i; EndUpdate(false);
        end;
  finally
    Panels.Free;
  end;
end;

{------------------------------------------------------------------------------}
procedure TLMDCaptionPanelGroup.GetChange(Sender:TObject);
begin
  if (csLoading in ComponentState) or isUpdating then exit;
  if sender=Bevel then
    begin
      RecreateWnd;
      exit;
    end
  else
    inherited;
  InitScrollBar;
  ReAlign;
end;

{------------------------------------------------------------------------------}
procedure TLMDCaptionPanelGroup.InitScrollBar;
var
  i, wi, PCount:Integer;
begin

  if isUpdating then exit;
  wi:=0;
  PCount:=0;
  // Count all Panels
  for i:=0 to Pred(ControlCount) do
    if (Controls[I] is TLMDCaptionPanel) then
      if (TLMDCaptionPanel(Controls[i]).Visible) or (csDesigning in ComponentState) then  // at Designtime we show all buttons
        begin
          Inc(PCount);
          if FOrientation=toHorizontal then
            Inc(wi, TLMDCaptionPanel(Controls[i]).Width)
          else
            Inc(wi, TLMDCaptionPanel(Controls[i]).Height);
        end;

  if PCount>0 then
    Inc(wi,FPanelGap*(PCount+1))
  else
    begin
      FScrollBar.Visible:=False;
      exit;
    end;
  FHeight:=wi;

  if FOrientation=toVertical then
    begin
      if FHeight>ClientHeight then
        begin
          BeginUpdate;
          try
            FScrollBar.Align:=alRight;
            FScrollBar.Kind:=sbVertical;
            FScrollBar.Width := def_GroupScrollBar;
            //must be set before FScrollBar.Max, otherwise EInvalidOperation is
            //raised by TScrollBar.SetParams
            FScrollBar.PageSize:=self.ClientHeight;
            FScrollBar.Max := FHeight+FPanelGap+2;
            if FScrollBar.Position>FScrollBar.Max-FScrollBar.PageSize then
              FScrollBar.Position:= FScrollBar.Max-FScrollBar.PageSize;
            FScrollBar.Visible:=True;
          finally
            EndUpdate;
          end;
        end
      else
        begin
          FScrollBar.Position:=0;
          FScrollBar.Visible:=False;
        end;
    end
  else
    begin
      if FHeight>ClientWidth then
        begin
          BeginUpdate;
          try
            FScrollBar.PageSize:=self.ClientWidth;
            FScrollBar.Align:=alBottom;
            FScrollBar.Kind:=sbHorizontal;
            FScrollBar.Height :=def_GroupScrollBar;
            FScrollBar.Max:=FHeight+FPanelGap+2;
            if FScrollBar.Position>FScrollBar.Max-FScrollBar.PageSize then
              FScrollBar.Position:= FScrollBar.Max-FScrollBar.PageSize;
            FScrollBar.Visible:=True;
          finally
            EndUpdate;
          end;
        end
      else
        begin
          FScrollBar.Position:=0;
          FScrollBar.Visible:=False;
        end;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDCaptionPanelGroup.Loaded;
begin
  inherited;

  if not (csDesigning in ComponentState) then
    try
      BeginUpdate;
      DoReadData;
      FixPanelIndex;
    finally
      EndUpdate(false);
    end;
  Change;

end;

{------------------------------------------------------------------------------}
procedure TLMDCaptionPanelGroup.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited;
  if (Operation=opRemove) then
    begin
      if aComponent=FIniLink then FIniLink:=nil;
      if (csLoading in ComponentState) or (csDestroying in ComponentState) then exit;
      if (AComponent is TLMDCaptionPanel) then InitScrollBar;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDCaptionPanelGroup.Paint;
begin
  if (csLoading in ComponentState) then exit;
  FillControl;
  if GetEmpty then
    begin
      if csDesigning in ComponentState then DrawDashedFrame;
      exit;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDCaptionPanelGroup.CMLMDUpdatePanel(var Msg: TMessage);
begin
  UpdatePanelIndex(Msg.WParam, Msg.LParam);
  FixPanelIndex;
end;

{------------------------------------------------------------------------------}
procedure TLMDCaptionPanelGroup.UpdatePanelIndex(Value, old:Integer);
var
  i, tmp:Integer;

begin
  if Value>old then
    begin
      tmp:=PanelMaxIndex;
       for i:=0 to Pred(ControlCount) do
         if (Controls[I] is TLMDCaptionPanel) then
           with TLMDCaptionPanel(Controls[I]) do
             if PanelIndex=old then
               begin
                 BeginUpdate;
                 if Value>=tmp then PanelIndex:=tmp+10 else PanelIndex:=Value+1;
                 EndUpdate(false);
               end
             else
               if (PanelIndex<>old) and (PanelIndex>Value) then
                 begin
                   BeginUpdate; PanelIndex:=PanelIndex+1; EndUpdate(false);
                end;
     end
   else
     for i:=0 to Pred(ControlCount) do
       if (Controls[I] is TLMDCaptionPanel) then
         with TLMDCaptionPanel(Controls[I]) do
           if PanelIndex=old then
             begin
               BeginUpdate;
                PanelIndex:=Value;
                EndUpdate(false);
             end
           else
             if (PanelIndex<>old) and (PanelIndex>=Value) then
                 begin
                   BeginUpdate; PanelIndex:=PanelIndex+1; EndUpdate(false);
                end;
end;

{----------------------- public -----------------------------------------------}
constructor TLMDCaptionPanelGroup.Create(AOwner: TComponent);
begin
  inherited;
  //inherited ControlStyle:=ControlStyle - [csSetCaption];
  inherited Caption:='';

  FAutoExpand := false;
  FOrientation:=toVertical;
  FPanels:=TList.Create;
  FPanelGap:=1;
  FMargin:=3;

  FScrollBar := TScrollBar.Create(nil);
  with FScrollBar do
    begin
      Parent:=Self;
      OnChange:=DoScroll;
      Visible:=False;
      TabStop:=False;
      LargeChange:=20;
      SmallChange:=2;
    end;

  FIniKey:=IDS_CAPTIONPANELGROUPSAVE;
  FIniSaveOptions := def_LMDCPGOptions;
  FIniSection:=IDS_COMMON;
  FIniUse := ioNone;

end;

{------------------------------------------------------------------------------}
destructor TLMDCaptionPanelGroup.Destroy;
begin
  if not (csDesigning in ComponentState) then
    DoWriteData;

  FIniLink := nil; //remove pointer to ini component
  FreeAndNil(FPanels);

  If Assigned(FScrollBar) then
    FreeAndNil(FScrollBar);
  inherited;
end;

{------------------------------------------------------------------------------}
procedure TLMDCaptionPanelGroup.AllowMovingAll(Value: Boolean);
var
  i:Integer;
begin
  for i:=0 to Pred(ControlCount) do
    if (Controls[I] is TLMDCaptionPanel) then
      //if TLMDCaptionPanel(Controls[i]).Visible then
        TLMDCaptionPanel(Controls[i]).AllowMoving:=Value;
end;

{------------------------------------------------------------------------------}
procedure TLMDCaptionPanelGroup.AllowSizingAll(Value: Boolean);
var
  i:Integer;
begin
  for i:=0 to Pred(ControlCount) do
    if (Controls[I] is TLMDCaptionPanel) then
      //if TLMDCaptionPanel(Controls[i]).Visible then
        TLMDCaptionPanel(Controls[i]).AllowSizing:=Value;
end;

{------------------------------------------------------------------------------}
procedure TLMDCaptionPanelGroup.CollapseAll;
var
  i:Integer;
begin
  for i:=0 to Pred(ControlCount) do
    if (Controls[I] is TLMDCaptionPanel) then
      //if TLMDCaptionPanel(Controls[i]).Visible then
        TLMDCaptionPanel(Controls[i]).Collapse;
end;

{------------------------------------------------------------------------------}
procedure TLMDCaptionPanelGroup.ExpandAll;
var
  i:Integer;
begin
  for i:=0 to Pred(ControlCount) do
    if (Controls[I] is TLMDCaptionPanel) then
      //if TLMDCaptionPanel(Controls[i]).Visible then
        TLMDCaptionPanel(Controls[i]).Expand;
end;

{------------------------------------------------------------------------------}
procedure TLMDCaptionPanelGroup.Change;
begin
  if csDestroying in ComponentState then exit;
  FixPanelIndex;
  GetChange(nil);
end;

{------------------------------------------------------------------------------}
procedure TLMDCaptionPanelGroup.PanelExchange(OldIndex, NewIndex:Integer);
var
  tmp1, tmp2:TLMDCaptionPanel;
  tmpi:Integer;
begin
  if NewIndex=OldIndex then exit;
  tmp1:=Panels[OldIndex];
  if tmp1=nil then

    raise EListError.CreateResFmt(@SListIndexError, [OldIndex]);

  tmp2:=Panels[NewIndex];
  if tmp2=nil then

    raise EListError.CreateResFmt(@SListIndexError, [NewIndex]);

  tmpi:=tmp2.PanelIndex;
  tmp2.SetSilentIndex(tmp1.PanelIndex);
  tmp1.SetsilentIndex(tmpi);
  Change;
end;

{------------------------------------------------------------------------------}
function TLMDCaptionPanelGroup.PanelIndexAtPos(X, Y: Integer): Integer;
var
  i:Integer;
  aRect:TRect;

begin
  result:=-1;
  If FPanels.Count=0 then exit;
  for i:=0 to Pred(FPanels.Count) do
    begin
      aRect:=TLMDCaptionPanel(FPanels[i]).BoundsRect;
      if FOrientation=toVertical then
        begin
          if X<FMargin then x:=FMargin+1;
          if X>aRect.Right then x:=aRect.Right-1;
        end
      else
        begin
          if Y<Fmargin then Y:=FMargin+1;
          if y>aRect.Bottom then y:=aRect.Bottom-1;
        end;
      if PtInRect(aRect, Point(X,Y)) then
        begin
          result:=TLMDCaptionPanel(FPanels[i]).PanelIndex;
          break;
        end;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDCaptionPanelGroup.PanelList(Value: TStrings; CustomData: Boolean);
var
  i:Integer;
  tmp:TLMDCaptionPanel;
begin
  if not assigned(Value) then exit;
  Value.Clear;
  for i:=0 to PanelMaxIndex do
    begin
      tmp:=Panels[i];
      if Assigned(tmp) then
        if CustomData then
          Value.AddObject(tmp.CustomData, tmp)
        else
          Value.AddObject(tmp.Caption, tmp);
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDCaptionPanelGroup.PanelList(Value: TList);
var
  i:Integer;
  tmp:TLMDCaptionPanel;
begin
  if not assigned(Value) then exit;
  Value.Clear;
  for i:=0 to PanelMaxIndex do
    begin
      tmp:=Panels[i];
      if Assigned(tmp) then Value.Add(tmp);
    end;
end;

{------------------------------------------------------------------------------}
function TLMDCaptionPanelGroup.PanelMaxIndex: Integer;
var
  i:Integer;
begin
  result:=-1;
  for i:=0 to Pred(ControlCount) do
   if (Controls[I] is TLMDCaptionPanel) then
     with TLMDCaptionPanel(Controls[I]) do
       If PanelIndex>result then result:=PanelIndex;
end;

{------------------------------------------------------------------------------}
procedure TLMDCaptionPanelGroup.ScrollInView(AControl: TControl);
var
  aRect:Trect;
begin
  if (AControl=nil) or (aControl.Parent<>self) or not (FScrollBar.Visible) then exit;
  aRect := AControl.BoundsRect;

  if Orientation=toVertical then
    begin
      if (aRect.Top>FScrollBar.Position+Height) or (aRect.Bottom<FScrollBar.Position) then
        FScrollBar.Position:=aRect.Top-20;
    end
  else
    if (aRect.Left>FScrollBar.Position+Width) or (aRect.Right<FScrollBar.Position) then
      FScrollBar.Position:=aRect.Left;

end;

end.
