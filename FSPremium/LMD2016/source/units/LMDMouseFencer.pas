unit LMDMouseFencer;
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

LMDMouseFencer unit ()
----------------------

Changes
-------
Release 8.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Windows,
  Messages,
  LMDMouseBaseCtrl;

type
  {------------------------- TLMDMouseFencer ----------------------------------}
  TLMDMouseFencer = class(TLMDMouseBaseCtrl)
  protected
    procedure WndProc(var Message: TMessage);override;
  public
    destructor Destroy; override;
    function Execute:Boolean;
    function ExecuteEnh(aRect:TRect):Boolean;
    procedure Stop;
  end;

implementation

uses
  Types, Classes;

{--------------------------- Protected ----------------------------------------}
procedure TLMDMouseFencer.WndProc(var Message: TMessage);
begin
   if FDestroying then exit;
   with Message do
      case Msg of
        WM_ACTIVATE:
          if AutoActive and not Performed then
            begin
              Execute;
              Performed:=True;
            end;
        WM_CANCELMODE:
          ClipCursor(nil);
      end;
   inherited WndProc(Message);
end;

{--------------------------- Public -------------------------------------------}
destructor TLMDMouseFencer.Destroy;
begin
  ClipCursor(nil);
  inherited Destroy;
end;

{------------------------------------------------------------------------------}
function TLMDMouseFencer.Execute:Boolean;
begin
  result:=ExecuteEnh(Rect(-1,-50,0,0));  {call default action}
end;

{------------------------------------------------------------------------------}
function TLMDMouseFencer.ExecuteEnh(aRect:TRect):Boolean;
var
  target:TRect;
  tp:TPoint;

begin
  result:=False;
  if (aRect.Left<>-1) and not IsRectEmpty(aRect) then
    target:=aRect
  else
    if not GetTargetRect(target) then exit;
  GetCursorPos(tp);
  if not PtInRect(target, tp) then
    SetCursorPos(target.Left, target.Top);

  ClipCursor(@target);

  result:=True;
end;

{------------------------------------------------------------------------------}
procedure TLMDMouseFencer.Stop;
begin
  ClipCursor(nil);
end;

end.
 
