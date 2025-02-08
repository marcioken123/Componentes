unit LMDFormPersistent;
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

LMDFormPersistent unit (RM)
---------------------------

Changes
-------
Release 8.0 (April 2007)
 - Initial Release

###############################################################################}

interface

uses
  Windows, SysUtils, Classes, Controls, Messages, Graphics, Forms, Menus, 
  LMDClass, LMDCont, LMDGraph, LMDStrings, LMDProcs, LMDWndProcComponent, LMDIniCtrl;

type

  {------------------------- TLMDFormPersistent -----------------------------------------}
  TLMDSizingChangeEvent=procedure(Sender:TObject;xsize, ysize, flag:Word) of object;
  TLMDMaxInfoEvent=procedure(Sender:TObject; var xpos, ypos, MaxWidth, MaxHeight:Integer) of object;
  TLMDMovingEvent=procedure(Sender:TObject; x,y:Integer; var Cancel:Boolean) of object;
  TLMDTrackInfoEvent=procedure(Sender:TObject; var MinWidth, MinHeight, MaxWidth,
                               MaxHeight:Integer) of object;

  {Ini-Support}
  TLMDFormIniSaveOption=(soColor, soFont, soPos, soSize, soState);
  TLMDFormIniSaveOptions=set of TLMDFormIniSaveOption;

  {general}
  TLMDFormOption=(foAutoCenter, foAutoShow, foTryAdaptRes, foRestoreOnce, foWriteOnClose);
  TLMDFormOptions=set of TLMDFormOption;

  TLMDFormPersistent=class(TLMDWndProcComponent)
  private
    {Ini-Support}
    FIniLink       : TLMDIniCtrl;
    FIniUse        : TLMDIniUse;
    FSection,
    FKey           : String;
    FIniOptions    : TLMDFormIniSaveOptions;
    FOptions       : TLMDFormOptions;
    {resolution problem}
    FDesignPPI     : Integer;
    FInternal,
    FRestored      : Boolean;
    FTrackInfo,
    FMaximized     : TRect;
    FMaximizedHeight,
    FMaximizedWidth,
    FMaxHeight,
    FMaxWidth,
    FMinHeight,
    FMinWidth,
    FMaximizedPosX,
    FMaximizedPosY : Integer;
    FWriteChanges: boolean;

    FOnDisplayChange:TLMDSizingChangeEvent;
    FOnFontChange   :TNotifyEvent;
    FOnSysColorChange:TNotifyEvent;
    FOnMaximize     :TLMDMaxInfoEvent;
    FOnMove         :TNotifyEvent;
    FOnMoving       :TLMDMovingEvent;
    FOnSize         :TLMDSizingChangeEvent;
    FOnTrackInfoEvent:TLMDTrackInfoEvent;

    FOwnerFormClose: TCloseEvent;
    FOwnerFormShow,    
    FOwnerFormDestroy: TNotifyEvent;

    {3.01}
    FOnNoData       :TNotifyEvent;
    procedure OwnerFormShow(Sender:TObject);
    procedure OwnerFormDestroy(Sender:TObject);
    procedure OwnerFormClose(Sender: TObject; var Action: TCloseAction);
    function GetRealValue(aValue:Integer; vertical:Boolean):Integer;
    procedure HandleMessage(var Message:TMessage);
    procedure SetInteger(Index:Integer; aValue:Integer);
    procedure SetIniLink(aValue:TLMDIniCtrl);
    function SaveKey:Boolean;
    function SaveSection:Boolean;
    function GetWorkRect: TRect;
  protected
    procedure Loaded; override;
    procedure Init; override;
    procedure Notification(AComponent:TComponent;Operation:TOperation);override;
    procedure ReadState(Reader: TReader); override;
    procedure SetRunTimeValues;
    procedure WndProc(var Message: TMessage);override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure SetMaximizedRect(aRect:TRect);
    procedure SetTrackMaxValues(aValue:TPoint);
    procedure SetTrackMinValues(aValue:TPoint);
    procedure AdaptResolution;
    function GetIniString:String;
    procedure SetIniString(const aString:String);
    {3.01}
    procedure ReadData;
    procedure WriteData;
    property ScreenWorkArea:TRect read GetWorkRect;
  published
    property About;
    {Ini-Support}
    property IniLink:TLMDIniCtrl read FIniLink write SetIniLink;
    property IniUse:TLMDIniUse read FIniUse write FIniUse default ioNone; {not active by default}
    property IniSaveOptions:TLMDFormIniSaveOptions read FIniOptions write FIniOptions default [soPos, soSize, soState];
    property Section:String read FSection write FSection stored SaveSection;
    property IniKey:String read FKey write FKey stored SaveKey;
    {Additional Features}
    property DesignPPI:Integer read FDesignPPI write FDesignPPI default 96;
    property Options:TLMDFormOptions read FOptions write FOptions default [foAutoShow];
    property Enabled;
    property MaximizedHeight:Integer index 4 read FMaximizedHeight write SetInteger default 0;
    property MaximizedWidth:Integer index 5 read FMaximizedWidth write SetInteger default 0;
    property MaximizedPosX:Integer index 6 read FMaximizedPosX write SetInteger default 0;
    property MaximizedPosY:Integer index 7 read FMaximizedPosY write SetInteger default 0;
    property TrackMaxHeight:Integer index 0 read FMaxHeight write SetInteger default 0;
    property TrackMaxWidth:Integer index 1 read FMaxWidth write SetInteger default 0;
    property TrackMinHeight:Integer index 2 read FMinHeight write SetInteger default 0;
    property TrackMinWidth:Integer index 3 read FMinWidth write SetInteger default 0;
    {Events}
    property OnNoRestoreData:TNotifyEvent read FOnNoData write FOnNoData;
    property OnDisplayChange:TLMDSizingChangeEvent read FOnDisplayChange write FOnDisplayChange;
    property OnFontChange:TNotifyEvent read FOnFontChange write FOnFontCHange;
    property OnMaximizeInfo:TLMDMaxInfoEvent read FOnMaximize write FOnMaximize;
    property OnMove:TNotifyEvent read FOnMove write FOnMove;
    property OnMoving:TLMDMovingEvent read FOnMoving write FOnMoving;
    property OnSize:TLMDSizingChangeEvent read FOnSize write FOnSize;
    property OnSysColorChange:TNotifyEvent read FOnSysColorChange write FOnSysColorChange;
    property OnTrackInfo:TLMDTrackInfoEvent read FOnTrackInfoEvent write FOnTrackInfoEvent;
  end;

implementation
uses
  Types, LMDUtils;

const
  IDS_FORMSAVE:String='Form';  // do not localize

{************************* Class TLMDForm**************************************}
{--------------------------- Private ------------------------------------------}
procedure TLMDFormPersistent.SetIniLink(aValue:TLMDIniCtrl);
begin
  FIniLink:=aValue;
  if FIniLink<>nil then FIniLink.FreeNotification(Self);
end;

{------------------------------------------------------------------------------}
procedure TLMDFormPersistent.SetInteger(Index:Integer; aValue:Integer);
var
  tmp:Integer;

begin
  if (aValue<-100) then exit;
  case Index of
    0:begin
        if aValue=FMaxHeight then exit;
        tmp:=GetRealValue(aValue, True);
        if (tmp>=FTrackInfo.Bottom) or (tmp=0) then
          begin
            FMaxHeight:=aValue;
            FTrackInfo.Top:=tmp;
          end;
      end;
    1:begin
        if aValue=FMaxWidth then exit;
        tmp:=GetRealValue(aValue, False);
        if (tmp>=FTrackInfo.Right) or (tmp=0) then
          begin
            FMaxWidth:=aValue;
            FTrackInfo.Left:=tmp;
          end;
        end;
    2:begin
        if aValue=FMinHeight then exit;
        tmp:=GetRealValue(aValue, True);
        if (tmp<=FTrackInfo.Top) or (FTrackInfo.Top<=0) or (tmp=0) then
          begin
            FMinHeight:=aValue;
            FTrackInfo.Bottom:=tmp;
          end;
      end;
    3:begin
        if aValue=FMinWidth then exit;
        tmp:=GetRealValue(aValue, False);
        if (tmp<=FTrackInfo.Left) or (FTrackInfo.Left<=0) or (tmp=0) then
          begin
            FMinWidth:=aValue;
            FTrackInfo.Right:=tmp;
          end;
        end;
    4:begin
        if aValue=FMaximizedHeight then exit;
        FMaximizedHeight:=aValue;
        FMaximized.Bottom:=GetRealValue(aValue, True);;
      end;
    5:begin
        if aValue=FMaximizedWidth then exit;
        FMaximizedWidth:=aValue;
        FMaximized.Right:=GetRealValue(aValue, False);
      end;
    6:begin
        if aValue=FMaximizedPosX then exit;
        FMaximizedPosX:=aValue;
        FMaximized.Left:=GetRealValue(aValue, False);
      end;
    7:begin
        if aValue=FMaximizedPosY then exit;
        FMaximizedPosY:=aValue;
        FMaximized.Top:=GetRealValue(aValue, True);
      end;
  end;
end;

{------------------------------------------------------------------------------}
procedure TLMDFormPersistent.SetRuntimeValues;
begin
  FTrackInfo:=Rect(GetRealValue(FMaxWidth, False), GetRealValue(FMaxHeight, True),
                   GetRealValue(FMinWidth, False), GetRealValue(FMinHeight, True));
  {Plausiblitätstests}
  with FTrackInfo do
    begin
      if FTrackInfo.Left>Screen.DesktopWidth then Left:=Screen.DesktopWidth;
      if FTrackInfo.Top>Screen.DesktopHeight then Top:=Screen.DesktopHeight;
      if (Right>Left) and (Left<>0) then Right:=Left;
      if (Bottom>Top) and (Top<>0) then Bottom:=Top;
    end;

  FMaximized:=Rect(GetRealValue(FMaximizedPosX, False), GetRealValue(FMaximizedPosY, True),
                   GetRealValue(FMaximizedWidth, False), GetRealValue(FMaximizedHeight, True));

end;

{------------------------------------------------------------------------------}
function TLMDFormPersistent.GetRealValue(aValue:Integer; vertical:Boolean):Integer;
begin
  result:=aValue;
  if aValue>=0 then exit;
  if vertical then
    result:=Round(Screen.DesktopHeight div Abs(aValue))
  else
    result:=Round(Screen.DesktopWidth div Abs(aValue));
end;

{------------------------------------------------------------------------------}
function TLMDFormPersistent.GetWorkRect: TRect;
begin

  SystemParametersInfo(SPI_GETWORKAREA, 0, @result, 0);

end;

{------------------------------------------------------------------------------}
procedure TLMDFormPersistent.HandleMessage(var Message:TMessage);
var
  tmp:Boolean;
  begin
   with Message do
     case Msg of
       WM_WINDOWPOSCHANGING:
         with TWMWINDOWPOSMSG(Message).WindowPos^ do
           begin
             tmp:=False;
             FOnMoving(Self, X, Y, tmp);
             if tmp then Flags:=Flags or SWP_NOMOVE;
           end;
        WM_DISPLAYCHANGE:
         begin
           SetRunTimeValues;
           if Assigned(FOnDisplayChange) then
             FOnDisplayCHange(Self, LoWord(LParam), HiWord(LParam), wParam);
         end;
       WM_GETMINMAXINFO:
         begin
           with TWMGetMinMaxInfo(Message).MinMaxInfo^ do
           begin
             if Assigned(FOnTrackInfoEvent) then
               FOnTrackInfoEvent(Self,Integer(ptMinTrackSize.X) ,Integer(ptMinTrackSize.Y),
                                 Integer(ptMaxTrackSize.X), Integer(ptMaxTrackSize.Y))
             else
               with FTrackInfo do
                 begin
                   if Left>0 then ptMaxTrackSize.X:=Left;
                   if Top>0 then ptMaxTrackSize.Y:=Top;
                   if Right>0 then ptMinTrackSize.X:=Right;
                   if Bottom>0 then ptMinTrackSize.Y:=Bottom;
                 end;

             if Assigned(FOnMaximize) then
               FOnMaximize(Self, Integer(ptMaxPosition.X), Integer(ptMaxPosition.Y),
                           Integer(ptMaxSize.X) ,Integer(ptMaxSize.Y))
             else
               with FMaximized do
                 begin
                   if Left>0 then ptMaxPosition.X:=Left;
                   if Top>0 then ptMaxPosition.Y:=Top;
                   if Right>0 then ptMaxSize.X:=Right;
                   if Bottom>0 then ptMaxSize.Y:=Bottom;
                 end;
             result:=0;
           end;
           end;
     end;

end;

{------------------------------------------------------------------------------}
procedure TLMDFormPersistent.OwnerFormShow(Sender:TObject);
begin
  FWriteChanges := true;
  if not (csDesigning in ComponentState) and Enabled then
    begin
      if (foRestoreOnce in FOptions) and FRestored then
        begin
          if Assigned(FOwnerFormShow) then FOwnerFormShow(Sender);
          exit;
        end;
      ReadData;
      FRestored:=True;
      case WndOwner.WindowState of
        wsNormal:
           with FTrackInfo do
             begin
               if (Left>0) and (WndOwner.Width>Left) then WndOwner.Width:=Left;
               if (Top>0) and (WndOwner.Height>Top) then WndOwner.Height:=Top;
               if (Right>0) and (WndOwner.Width<Right) then WndOwner.Width:=Right;
               if (Bottom>0) and (WndOwner.Height<Bottom) then WndOwner.Height:=Bottom;
             end;
        wsMaximized:
          with FMaximized do
            begin
               if (Left>0) then WndOwner.Left:=Left;
               if (Top>0) then WndOwner.Top:=Top;
               if (Right>0) then WndOwner.Width:=Right;
               if (Bottom>0) then WndOwner.Height:=Bottom
            end;
      end;
      // check for plausibility
      if foTryAdaptRes in FOptions then AdaptResolution;
   end;
  if Assigned(FOwnerFormShow) then FOwnerFormShow(Sender);
end;

{------------------------------------------------------------------------------}
procedure TLMDFormPersistent.OwnerFormDestroy(Sender:TObject);
begin
  if Enabled and not (foWriteOnClose in Options) and not (csDesigning in ComponentState) and FWriteChanges then
    WriteData;
  if Assigned(FOwnerFormDestroy) then
    FOwnerFormDestroy(Sender);
end;

{------------------------------------------------------------------------------}
function TLMDFormPersistent.SaveKey:Boolean;
begin
  result:=(FKey<>'') and (FKey<>IDS_FORMSAVE);
end;

{------------------------------------------------------------------------------}
function TLMDFormPersistent.SaveSection:Boolean;
begin
  result:=(FSection<>'') and (FSection<>IDS_COMMON);
end;

{--------------------------- Protected ----------------------------------------}
procedure TLMDFormPersistent.Loaded;
begin
  if (IniUse<>ioNone) and ([soPos, soSize]*FIniOptions<>[]) then
    if WndOwner.Position <> poDesigned then
      WndOwner.Position := poDesigned;
  inherited Loaded;
end;

{------------------------------------------------------------------------------}
procedure TLMDFormPersistent.Init;
begin
  if (IniUse<>ioNone) and ([soPos, soSize]*FIniOptions<>[]) then
    if WndOwner.Position <> poDesigned then
      WndOwner.Position := poDesigned;
  inherited Init;
end;

{------------------------------------------------------------------------------}
procedure TLMDFormPersistent.Notification(AComponent:TComponent;Operation:TOperation);
var
  i,l,comp : Integer;
begin

  inherited Notification(aComponent,Operation);
  if (Operation=opRemove) then
    if AComponent=FIniLink then FIniLink:=nil;

  if (Operation=opInsert) then
    begin

      if (FIniUse=ioUseLink) and (aComponent is TLMDIniCtrl) and not Assigned(FIniLink) then
        FIniLink := TLMDIniCtrl(aComponent);

      if (Owner is TCustomForm) and (aComponent=Self) then
        begin
          comp:=0;
          if FIniUse=ioUseLink then
            begin
              l:=0;
              for i := 0 to Pred(TForm(Owner).ComponentCount) do
                if TForm(Owner).Components[i] is TLMDIniCtrl then
                  begin
                    Comp:=i;
                    inc(l);
                  end;
              if l=1 then
                FIniLink:=TLMDIniCtrl(TForm(Owner).Components[Comp]);
            end;
        end;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDFormPersistent.ReadState(Reader: TReader);
begin
  inherited ReadState(Reader);
  if not (csDesigning in ComponentState) and Enabled then
    begin
      FRestored:=False;
      FOwnerFormShow:=TForm(Owner).OnShow;
      TForm(Owner).OnShow:=OwnerFormShow;
      FOwnerFormDestroy:=TForm(Owner).OnDestroy;
      TForm(Owner).OnDestroy:=OwnerFormDestroy;
      FOwnerFormClose:=TForm(Owner).OnClose;
      TForm(Owner).OnClose:=OwnerFormClose;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDFormPersistent.WndProc(var Message: TMessage);
begin

  if not Enabled then
    begin
      inherited WndProc(Message);
      exit;
    end;

   with Message do
     begin
       case msg of
         WM_DISPLAYCHANGE:
           HandleMessage(Message);
         WM_FONTCHANGE:
           if Assigned(FOnFontChange) then
            FOnFontChange(Self);
         WM_GETMINMAXINFO:
           HandleMessage(Message);
         WM_Move:
           begin
             if Assigned(FonMove) then
              FOnMove(self);
           end;
         WM_SIZE:
           if Assigned(FOnSize) then
             with TWMSize(Message) do
             FOnSize(Self, Width, Height, SizeType);
         WM_SYSCOLORCHANGE:
           if Assigned(FOnSysColorChange) then
             FOnSysColorCHange(Self);
         WM_WINDOWPOSCHANGING:
           begin
             If Assigned(FOnMoving) then
               HandleMessage(Message);
           end;
       end;
     end;

  inherited WndProc(Message);

end;

{--------------------------- Public -------------------------------------------}
constructor TLMDFormPersistent.Create(AOwner:TComponent);
begin
  inherited Create(aOwner);

  FWriteChanges := false;

  FDesignPPI:=96;
  FInternal:=False;
  FHandleMDI:=True;

  FIniUse:=ioNone;
  FIniOptions:=[soPos, soSize, soState];

  FSection:=IDS_COMMON;
  if not (Owner is TForm) then
    FKey:=IDS_FORMSAVE
  else
    FKey:=copy(owner.ClassName, 2,250);

  FOptions:=[foAutoShow];

  if csDesigning in ComponentState then
    if LMDCheckForSameClass(aOwner, self.ClassType, False) then
      raise ELMDOneInstError.Create(self.ClassName,0);
end;

{ ---------------------------------------------------------------------------- }
destructor TLMDFormPersistent.Destroy;
begin
  inherited Destroy;
end;

{------------------------------------------------------------------------------}
procedure TLMDFormPersistent.AdaptResolution;
var
  i,act:integer;

  procedure AdaptControl(aControl:TControl);
  var
    j:Integer;
  begin
    with aControl do
      SetBounds(MulDiv(Left,  FDesignPPI, act),
                MulDiv(Top,   FDesignPPI, act),
                MulDiv(Width, FDesignPPI, act),
                MulDiv(Height,FDesignPPI, act));
   if aControl is TWinControl then
      with TWinControl(aControl) do
        for j:=0 to Pred(ControlCount) do
          AdaptControl(Controls[j]);
  end;

begin
  with WndOwner do
     begin
       if FInternal or not Scaled then exit;
       FInternal:=True;
       PixelsPerInch:=Screen.PixelsPerInch;
       if PixelsPerInch<>FDesignPPI then
         begin
           act:=PixelsPerInch;
           for i:=0 to Pred(ControlCount) do
             AdaptControl(Controls[i]);
         end;
     end;
end;

{------------------------------------------------------------------------------}
procedure TLMDFormPersistent.SetMaximizedRect(aRect:TRect);
begin
  MaximizedHeight:=aRect.Bottom;
  MaximizedWidth:=aRect.Right;
  MaximizedPosX:=aRect.Left;
  MaximizedPosY:=aRect.Top;
end;

{------------------------------------------------------------------------------}
procedure TLMDFormPersistent.SetTrackMaxValues(aValue:TPoint);
begin
  TrackMaxHeight:=aValue.Y;
  TrackMaxWidth:=aValue.X;
end;

{------------------------------------------------------------------------------}
procedure TLMDFormPersistent.SetTrackMinValues(aValue:TPoint);
begin
  TrackMinHeight:=aValue.Y;
  TrackMinWidth:=aValue.X;
end;

{------------------------------------------------------------------------------}
function TLMDFormPersistent.GetIniString:String;
var
  aP:TWindowPlacement;
begin

  aP.length:=Sizeof(TWindowPlacement);
  GetWindowPlacement(WndHandle, @aP);

  {-> problem: minimized state in Windows 4}
  with aP, aP.rcNormalPosition do
    Result := LMDAnsiCodeInt([200, flags, showCmd, Left, Top, Right, Bottom], IDS_DEFAULTDELIMITER);
    end;

{------------------------------------------------------------------------------}
procedure TLMDFormPersistent.SetIniString(const aString:String);
var
  aList:TStrings;
  ap:TWindowPlacement;
  aRect:TRect;

begin
  if //(aString = '') or //VB bts 365
      not ((soPos in FIniOptions) or (soSize in FIniOptions)
          or (soState in FIniOptions)) then
    exit;

  // 6.01
  if WndOwner.Position<>poDesigned then
    WndOwner.Position:=poDesigned;

  aP.length:=Sizeof(TWindowPlacement);
  GetWindowPlacement(WndHandle, @aP);

  aList:=TStringList.Create;
  try

    LMDAnsiParseToStrList(aString, IDS_DEFAULTDELIMITER , aList);

    if (aList.count<>7) or (aList[0]<>'200') then
      begin
        if foAutoCenter in FOptions then
          LMDCenterForm(WndOwner);
        if Assigned(FOnNoData) then FOnNoData(self);
        exit;
      end;

    with ap, aP.rcNormalPosition do
      begin

        if soState in FIniOptions then
          begin
            flags:=StrToInt(aList[1]);
            showCmd:=StrToInt(aList[2]);
            if not (foAutoShow in FOptions) then showCmd:=0;
          end;

        if (soPos in FIniOptions) or (soSize in FIniOptions) then
          begin

            aRect:=Rect(StrToInt(aList[3]), StrToInt(aList[4]),
                        StrToInt(aList[5]), StrToInt(aList[6]));

            if soPos in FIniOptions then
              begin
                Left:=aRect.Left;
                Top:=aRect.Top;
                if not (soSize in FIniOptions) then
                  begin
                    Right:=aRect.Left+WndOwner.Width;
                    Bottom:=aRect.Top+WndOwner.Height;
                  end;
              end;

            if soSize in FIniOptions then
              if soPos in FIniOptions then
                begin
                  Right:=aRect.Right;
                  Bottom:=aRect.Bottom;
                end
              else
                begin
                  Right:=WndOwner.Left+(aRect.Right-aRect.Left);
                  Bottom:=WndOwner.Top+(aRect.Bottom-aRect.Top);
                end;

            {check bounds, new in 4.0, modified for MultiMonitor
             support in 6.01, RM}
            if Right>Screen.DesktopWidth then
              begin
                Left:=Screen.DesktopWidth-Abs(Right-Left);
                Right:=Screen.DesktopWidth;
              end;
            if Bottom>Screen.DesktopHeight then
              begin
                Top:=Screen.DesktopHeight-Abs(Bottom-Top);
                Bottom:=Screen.DesktopHeight;
              end;
            // 7.11 --> additional checks for visibility
            if Left<Screen.DesktopLeft then
              begin
                Right:=Screen.DesktopLeft+Abs(Right-Left);
                Left:=Screen.DesktopLeft;
              end;
            if Top<Screen.DesktopTop then
              begin
                Bottom:=Screen.DesktopTop+Abs(Bottom-Top);
                Top:=Screen.DesktopTop;
              end;
            // -----
          end;
      end;

    SetWindowPlacement(WNDHandle, @ap);

  finally
    aList.free;
  end;

end;

{------------------------------------------------------------------------------}
procedure TLMDFormPersistent.ReadData;

  procedure DoReadValues(aLink:TLMDIniCtrl; aForm:TForm);
  var
    tmp:String;
  begin
     with aLink, aForm do
       begin
         SetIniString(ReadString(FSection, FKey, ''));
         if soColor in FIniOptions then
           begin
             tmp:=ReadString(FSection, FKey+'Color','');
             if tmp<>'' then Color:=StringToColor(tmp);
           end;
         if soFont in FIniOptions then
           begin
             tmp:=ReadString(FSection, FKey+'Font','');
             if tmp<>'' then LMDAnsiStringToFont(tmp, Font);
           end;
       end;
  end;
begin
  case FIniUse of
    ioUseLink:
      if Assigned(FIniLink) then DoReadValues(FIniLink, WndOwner);
    ioUseGlobal:
      DoReadValues(LMDApplication.Ini, WndOwner);
    ioNone: ;
  end;
end;

{------------------------------------------------------------------------------}
procedure TLMDFormPersistent.WriteData;

  procedure WriteValues(aLink:TLMDIniCtrl; aForm:TForm);
  begin
    with aLink, aForm do
      begin
        WriteString(FSection, FKey, GetIniString);
        if soColor in FIniOptions then
          WriteString(FSection, FKey+'Color', ColorToString(Color))
        else
          DeleteKey(FSection, FKey+'Color');
        if soFont in FIniOptions then
          WriteString(FSection, FKey+'Font', LMDAnsiFontToString(Font))
        else
          DeleteKey(FSection, FKey+'Font');
      end;
  end;
begin
  case FIniUse of
    ioUseLink:
      if Assigned(FIniLink) then WriteValues(FiniLink, WndOwner);
    ioUseGlobal:
        writeValues(LMDApplication.Ini, WndOwner);
    ioNone: ;
  end;
end;

{------------------------------------------------------------------------------}
procedure TLMDFormPersistent.OwnerFormClose(Sender: TObject; var Action: TCloseAction);
begin
  if Enabled and (foWriteOnClose in Options) and not (csDesigning in ComponentState) and FWriteChanges then
    WriteData;
  if Assigned(FOwnerFormCLose) then
    FOwnerFormClose(Sender, Action);
end;

end.

