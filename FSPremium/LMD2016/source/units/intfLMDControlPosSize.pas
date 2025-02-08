unit intfLMDControlPosSize;
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

intfLMDControlPosSize unit (RM)
-------------------------------

Changes
-------
Release 8.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Windows, Classes, Graphics, Controls, Forms,
  intfLMDBase;

type

  ILMDControlPosSize = interface
     ['{EE3AFF62-E73A-41F2-B04D-D24710377EBD}']
     function get_AllowMoving: Boolean;
     procedure set_AllowMoving(const aValue: Boolean);
     function get_AllowSizing: Boolean;
     procedure set_AllowSizing(const aValue: Boolean);
     function get_ControlLocked: Boolean;
     procedure set_ControlLocked(const aValue: Boolean);
     function GetMoveRect:TRect;
     procedure set_OnMove(const aValue:TNotifyEvent);
     function get_OnMove:TNotifyEvent;
     property AllowMoving:Boolean read get_AllowMoving write set_AllowMoving;
     property AllowSizing:Boolean read get_AllowSizing write set_AllowSizing;
     property ControlLocked:Boolean read get_ControlLocked write set_ControlLocked;
     property OnMove:TNotifyEvent read get_OnMove write set_OnMove;
   end;

  //helpers
  function LMDControlSizingHitTest(Handle:HWND; cPos:TPoint; CRect:Trect; bs:Byte):LongWord;

  // set ControlLocked property for all controls on aParen form
  procedure LMDSetCtlLocked(aParent: TCustomForm; Value:Boolean);overload;
  procedure LMDSetCtlLocked(aParent: TWinControl; Value:Boolean);overload;

implementation
uses
  Types, SysUtils;

{ ---------------------------------------------------------------------------- }
procedure LMDSetCtlLocked(aParent: TCustomForm; Value:Boolean);
var
  i:Integer;
  itmp:ILMDControlPosSize;
begin
  if not (aParent is TCustomForm) or (aParent = nil) then exit;
  with aParent do
    for i:=0 to ComponentCount-1 do
      if LMDSupports(Components[i], ILMDControlPosSize, itmp) then
         itmp.ControlLocked:=Value;
end;

{ ---------------------------------------------------------------------------- }
procedure LMDSetCtlLocked(aParent: TWinControl; Value:Boolean);
var
  i:Integer;
  itmp:ILMDControlPosSize;
begin
  if (aParent = nil) then exit;
  with aParent do
    for i:=0 to ControlCount-1 do
      if LMDSupports(Controls[i], ILMDControlPosSize, itmp) then
         itmp.ControlLocked:=Value;
end;

{ ---------------------------------------------------------------------------- }
function LMDControlSizingHitTest(Handle:HWND; cPos:TPoint; CRect:Trect; bs:Byte):LongWord;
var
  iRect:Trect;

begin
 iRect:=Types.Rect(cRect.Left+bs, cRect.Top+bs, cRect.Right-bs, cRect.Bottom-bs);

 result:=0;

 if (cpos.Y>iRect.Bottom) then
   begin
     if (cpos.X>iRect.Right) then
       begin result:=HTBOTTOMRIGHT; exit; end;
     if (cpos.X<iRect.Left) then
       begin result:=HTBOTTOMLEFT; exit; end;
     {if (cpos.X>hw-bs) and (cpos.X<hw+bs) then}
     result:=HTBottom;
     exit;
   end;

 if (cpos.Y<iRect.Top) then
   begin
     if (cpos.X>iRect.Right) then
       begin result:=HTTOPRIGHT;exit;end;
     if (cpos.X<iRect.Left) then
       begin result:=HTTOPLEFT;exit;end;
     result:=HTTOP;
     exit;
   end;

 if (cpos.X>iRect.Right) then
   begin result:=HTRIGHT;exit;end;

 if (cpos.X<iRect.Left) then result:=HTLEFT;

end;

end.

