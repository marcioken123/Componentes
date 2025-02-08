unit LMDMousePositioner;
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

LMDMousePositioner unit ()
--------------------------

Changes
-------
Release 8.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Windows,
  Messages,
  Classes,
  LMDMouseBaseCtrl,
  LMDGraph;

type
  {------------------------- TLMDMousePositioner ------------------------------}
  TLMDMousePositioner = class(TLMDMouseBaseCtrl)
  private
    FPosition:TLMDAlignment;
    function GetAutoPosition(aRect:TRect):TPoint;
    procedure SetPosition(aValue:TLMDAlignment);
  protected
    procedure WndProc(var Message: TMessage);override;
  public
    constructor Create(AOwner: TComponent); override;
    function Execute:Boolean;
    function ExecuteEnh(X,Y:Integer):Boolean;
  published
    property Position:TLMDAlignment read FPosition write SetPosition default agCenter;
  end;

implementation

uses
 Types, SysUtils;
  {--------------------------- Private ------------------------------------------}
function TLMDMousePositioner.GetAutoPosition(aRect:TRect):TPoint;
begin
  with aRect do
    case FPosition of
      agTopLeft:result:=TopLeft;
      agTopCenter:result:=Point(Left+Abs(Right-Left) Div 2, Top);
      agTopRight:result:=Point(Right, Top);
      agCenterLeft:result:=Point(left, Top+Abs(Bottom-Top) Div 2);
      agCenter:result:=Point(Left+Abs(Right-Left) Div 2, Top+Abs(Bottom-Top) Div 2);
      agCenterRight:result:=Point(Right, top+Abs(Bottom-Top) Div 2);
      agBottomLeft:result:=Point(Left, Bottom);
      agBottomCenter:result:=Point(Left+Abs(Right-Left) Div 2, Bottom);
      agBottomRight:result:=aRect.BottomRight;
    else
      result:=Point(0,0);
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDMousePositioner.SetPosition(aValue:TLMDAlignment);
begin
  if aValue<>FPosition then FPosition:=aValue;
end;

{--------------------------- Protected ----------------------------------------}
procedure TLMDMousePositioner.WndProc(var Message: TMessage);
begin
   If FDestroying then Exit;
    with Message do
      case Msg of
        WM_ACTIVATE:
          if AutoActive and not Performed then
            begin
              Execute;
              Performed:=True;
            end;
      end;
   inherited WndProc(Message);
end;

{--------------------------- Public -------------------------------------------}
constructor TLMDMousePositioner.Create(AOwner:TComponent);
begin
  inherited Create(AOwner);
  FPosition:=agCenter;
end;

{------------------------------------------------------------------------------}
function TLMDMousePositioner.Execute:Boolean;
begin
  result:=ExecuteEnh(-1,-1);  {call default action}
end;

{------------------------------------------------------------------------------}
function TLMDMousePositioner.ExecuteEnh(X,Y:Integer):Boolean;
var
  target:TRect;
  pos:TPoint;

begin
  result:=false;
  if GetTargetRect(target) then
    begin
      if X=-1 then  {default value}
        pos:=GetAutoPosition(target)
      else
        begin
          pos:=Point(target.Left+X, target.Top+Y);
          if not PtInRect(target, pos) then
            {Center automatically}
            with target do
              pos:=Point(Abs(Right-Left) Div 2, Abs(Bottom-Top) Div 2);
        end;

      {Now what we want :) }
      SetCursorPos(Pos.X, Pos.Y);
      result:=true;
    end;
end;

end.
 
