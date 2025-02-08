unit LMDMouseBaseCtrl;
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

LMDMouseBaseCtrl unit ()
------------------------

Changes
-------
Release 8.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Windows,
  Classes,
  Controls,
  LMDWndProcComponent;

type
  {------------------------- TLMDMouseBaseCtrl --------------------------------}
  TLMDMousePosStyle=(mpDefaultButton, mpControl, mpClientArea);

  TLMDMouseBaseCtrl = class(TLMDWndProcComponent)
  private
    FAutoActive:Boolean;
    FControl:TControl;
    FPosStyle:TLMDMousePosStyle;
    procedure SetControl(aControl:TControl);
    procedure SetPosStyle(aValue:TLMDMousePosStyle);
  protected
    function GetTargetRect(var aRect:TRect):Boolean;
    function  HasControl:Boolean;
    procedure Notification(AComponent: TComponent;  Operation: TOperation); override;
  public
    Performed:Boolean;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    property About;
    property AutoActive:Boolean read FAutoActive write FAutoActive default false;
    property Control:TControl read FControl write SetControl stored HasControl;
    property Style:TLMDMousePosStyle read FPosStyle write SetPosStyle default mpDefaultButton;
  end;

implementation

uses
  Types, StdCtrls, Forms;

{--------------------------- Private ------------------------------------------}
function TLMDMouseBaseCtrl.GetTargetRect(var aRect:TRect):Boolean;
var
  i:Integer;
  btn: TButton;

begin
   result:=false;
   case FPosStyle of
     mpControl:
       begin
         if not HasControl then exit;
         with aRect do
           begin
             TopLeft:=FControl.ClientOrigin;
             Right:=Left+FControl.Width;
             Bottom:=Top+FControl.Height;
             result:=true;
           end;
       end;
     mpDefaultButton:
       begin
         if Owner=nil then exit;
         with TForm(Owner) do
           for i:=0 to ComponentCount-1 do
             if Components[i] is TButton then
             begin
               btn := Components[i] as TButton;
               with btn do
               if Default=true then
                 with aRect do
                   begin
                     TopLeft:=ClientOrigin;
                     Right:=left + btn.Width;
                     Bottom:=Top + btn.Height;
                     result:=true;
                     exit;
                 end;
             end;
       end;
     mpClientArea:
       begin
         if Owner=nil then exit;
         with TForm(Owner) do
           begin
             aRect.TopLeft:=ClientToScreen(Point(ClientRect.Left, ClientRect.Top));
             aRect.BottomRight:=ClientToScreen(Point(ClientRect.Right, ClientRect.Bottom));
             result:=true;
           end;
       end;
   end;
end;

{------------------------------------------------------------------------------}
procedure TLMDMouseBaseCtrl.SetControl(aControl:TControl);
begin
  if AControl<>FControl then
    begin
      FControl:=AControl;
      if FControl <> nil then FControl.FreeNotification(Self);
    end;

end;

{------------------------------------------------------------------------------}
procedure TLMDMouseBaseCtrl.SetPosStyle(aValue:TLMDMousePosStyle);
begin
  if aValue<>FPosStyle then FPosStyle:=aValue;
end;

{--------------------------- Protected ----------------------------------------}
function TLMDMouseBaseCtrl.HasControl:Boolean;
begin
  result:=FControl<>nil;
end;

{---------------------------------------------------------------------------}
procedure TLMDMouseBaseCtrl.Notification(AComponent: TComponent;  Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (AComponent=FControl) and (Operation = opRemove) then
    FControl := nil;
end;

{--------------------------- Public -------------------------------------------}
constructor TLMDMouseBaseCtrl.Create(AOwner:TComponent);
begin
  inherited Create(AOwner);
  FPosStyle:=mpDefaultButton;
  Performed:=False;
  FAutoActive:=False;
end;

{------------------------------------------------------------------------------}
destructor TLMDMouseBaseCtrl.Destroy;
begin
  FControl:=nil;
  inherited Destroy;
end;

end.
 
