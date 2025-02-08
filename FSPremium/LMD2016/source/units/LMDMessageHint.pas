unit LMDMessageHint;
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

LMDMessageHint unit ()
----------------------

Changes
-------
Release 8.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Classes, Controls, LMDTypes, Graphics, LMDCustomShapeHint, LMDShapeHint,
  LMDCustomHint;

type
  TLMDMessageHintWindow = class;

  TLMDMessageHint = class(TLMDCustomShapeHint)
  private
    FSetCapture:         Boolean;
    FAllowMultipleHints: Boolean;

    function  GetState: Boolean;
    procedure SetAllowMultipleHints(const Value: boolean);
  protected
    function  NeedHintHook: Boolean; override;
    function  GetHintClass: THintWindowClass; override;
    procedure DoHide(Sender: THintWindow); override;
  public
    constructor Create(AOwner:TComponent);override;
    destructor Destroy; override;
    procedure HideMessage; overload;
    procedure HideMessage(AWindow: TLMDMessageHintWindow); overload;
    procedure HideMessages(aDisplayOrder: integer = -1); virtual;
    procedure ShowMessage(const Msg:string; x, y: integer; aTitle: TLMDString = ''; aColor: TColor = clNone; aIcon: TLMDHintIconType = hitInfo; aDisplayOrder: integer = -1);
    procedure ShowControlMessage(const Msg:string; aControl:TControl; aTitle: TLMDString = ''; aColor: TColor = clNone; aIcon: TLMDHintIconType = hitInfo; aDisplayOrder: integer = -1);
    property  IsDisplaying:Boolean read GetState;
  published
    property AllowMultipleHints: boolean read FAllowMultipleHints write SetAllowMultipleHints;
    property CloseBtnType;
    property CloseBtnStyle;
    property DefaultTitle;
    property Distance;
    property Enabled;
    property Font3D;
    property Gradient;
    property HideAccelChar;
    property NoseLength;
    property NoseWidth;
    property NoseAngleWidth;
    property Options;
    property Position;
    property RoundRectWidth;
    property SetCapture:Boolean read FSetCapture write FSetCapture default True;
    property Shadow;
    property Style;
    property ThemeMode;
    property ThemeGlobalMode;
    property TitleFont;
    property TitleFont3D;
    property UseGradient;
    property UseSystemShadow;
  end;

  {$HINTS OFF}
  TLMDMessageHintWindow = class(TLMDShapeHintWindow)
  protected
    FDisplayOrder: Integer;
    procedure      PreCreateWnd; override;
  public
    property DisplayOrder: integer read FDisplayOrder;
  end;
  {$HINTS ON}

implementation

uses
  Windows, Forms, SysUtils, Types, Variants;

{---------------------------- Private -----------------------------------------}
destructor TLMDMessageHint.Destroy;
begin
  HideMessages;
  inherited;
end;

{------------------------------------------------------------------------------}
procedure TLMDMessageHint.DoHide(Sender: THintWindow);
begin
  inherited;
  SetCaptureControl(nil);
  TLMDMessageHintWindow(Sender).ReleaseHandle;
end;

{------------------------------------------------------------------------------}
function TLMDMessageHint.GetHintClass: THintWindowClass;
begin
  Result := TLMDMessageHintWindow;
end;

{------------------------------------------------------------------------------}
function TLMDMessageHint.GetState: Boolean;
begin
  Result := (WindowCount > 0);
end;

{---------------------------- Protected ---------------------------------------}
procedure TLMDMessageHint.SetAllowMultipleHints(const Value: boolean);
begin
  FAllowMultipleHints := Value;
  if FAllowMultipleHints then
    SetCapture := false;
end;

{----------------------------- public -----------------------------------------}
Constructor TLMDMessageHint.Create(aOwner:TComponent);
begin
  inherited Create(aOwner);
  FSetCapture     := True;
end;

{------------------------------------------------------------------------------}
procedure TLMDMessageHint.ShowMessage(const Msg:string; x, y: Integer;
  aTitle: TLMDString = ''; aColor: TColor = clNone;
  aIcon: TLMDHintIconType = hitInfo; aDisplayOrder: Integer = -1);
var
  wnd: TLMDMessageHintWindow;
begin
  if not AllowMultipleHints then
    HideMessage;
  wnd := TLMDMessageHintWindow.CreateCustom(Self, Self);

  wnd.Title := aTitle;
  if aColor <> clNone then
    wnd.Color := aColor;
  wnd.IconType      := aIcon;
  wnd.FDisplayOrder := aDisplayOrder;

  if AllowMultipleHints then
    wnd.Tag := WindowCount - 1;
  wnd.ActivateHintExt(Rect(x, y, -1, -1), Msg);
end;

{------------------------------------------------------------------------------}
procedure TLMDMessageHint.ShowControlMessage(const Msg: string;
  aControl: TControl; aTitle: TLMDString = ''; aColor: TColor = clNone;
  aIcon: TLMDHintIconType = hitInfo; aDisplayOrder: Integer = -1);
var
  x, y: Integer;
  s:    string;
begin
  if not AllowMultipleHints then
    HideMessage;
  if (aControl.Visible) and (aControl.Parent <> nil) then
    with aControl do
    begin
      s := Msg;
      if s = '' then
        s := aControl.Hint;
      x := Parent.ClientToScreen(Point(Left, Top)).X + (Width div 2);
      y := Parent.ClientToScreen(Point(Left, Top)).Y + (Height div 2);

      ShowMessage(s, x, y, aTitle, aColor, aIcon, aDisplayOrder);
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDMessageHint.HideMessage;
begin
  HideMessages;
end;

{------------------------------------------------------------------------------}
procedure TLMDMessageHint.HideMessage(AWindow: TLMDMessageHintWindow);
begin
  if AWindow <> nil then
  begin
    AWindow.OnHide;
    FreeAndNil(AWindow);
  end;
end;

{------------------------------------------------------------------------------}
procedure TLMDMessageHint.HideMessages(aDisplayOrder: integer = -1);
var
  i:   Integer;
  wnd: TLMDMessageHintWindow;
begin
  for i := WindowCount - 1 downto 0 do
  begin
    wnd := TLMDMessageHintWindow(Windows[i]);
    if (aDisplayOrder = -1) or (wnd.DisplayOrder = aDisplayOrder) then
      HideMessage(wnd);
  end;
end;

{------------------------------------------------------------------------------}
function TLMDMessageHint.NeedHintHook: Boolean;
begin
  Result := False;
end;

{------------------------------------------------------------------------------}
procedure TLMDMessageHintWindow.PreCreateWnd;
begin
  // Do nothing.
end;

end.
