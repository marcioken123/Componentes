unit LMDHideNonVC;
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

LMDHideNonVC unit ()
--------------------

Changes
-------
Release 8.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Windows, Classes, messages, Graphics, controls, Forms, Buttons, stdctrls, sysutils,
  LMDClass,
  LMDGraph,
  LMDProcs,
  LMDCustomComponent;

type
  {------------------------- TLMDNonHideVC ------------------------------------}
  TLMDOnNewComponentEvent=procedure(Sender:TObject; aComponent:TComponent) of object;

  TLMDHideNonVC=class(TLMDCustomComponent)
  private
    FNewComponent:TLMDOnNewComponentEvent;
    FUseTag:Boolean;
  protected
    procedure Loaded;override;
    procedure Notification(AComponent:TComponent;Operation:TOperation);override;
  public
    constructor Create(aOwner:TComponent);override;
    property OnNewComponent:TLMDOnNewComponentEvent read FNewComponent write FNewComponent;
  published
    property About;
    property UseTagInfo:Boolean read FUseTag write FUseTag default True;
  end;

const
  defHideX:WORD=65000;
  defComWidth:Byte=28;

{required procedures for TLMDHideNonVC}
function LMDCheckValidComponent(Comp, Parent:TComponent):Boolean;
function LMDGetNonVCIndex(Target:TScrollingWinControl; Comp:TComponent):Integer;
procedure LMDRemoveContainer(Target:TScrollingWinControl; Comp:TComponent);
procedure LMDShowContainer(Target:TScrollingWinControl; Comp:TComponent);

implementation

uses

  Dialogs,
  LMDUtils,
  Consts;

{************************* Class TLMDHideNonVC ********************************}
{this function tests for valid components}
function LMDCheckValidComponent(Comp, Parent:TComponent):Boolean;
begin
   result:= not ((comp is TControl) or (comp=Parent) or comp.HasParent);
end;

{------------------------------------------------------------------------------}
function LMDGetNonVCIndex(Target:TScrollingWinControl; Comp:TComponent):Integer;
var
  i:Integer;
begin
  result:=0;
  with Target do
    for i:=Pred(ComponentCount) downto 0 do
      If LMDCheckValidComponent(Components[i], nil) then
        if Components[i]=Comp then exit else Inc(result);
end;

{------------------------------------------------------------------------------}
procedure LMDHandleContainer(Target:TScrollingWinControl; Comp:TComponent; aValue:Boolean);
var
  hw:HWND;
  i,c:Integer;
  r:TRect;
  p, p1:TPoint;
  n:String;

begin
  c:=0;
  if Comp is TLMDHideNonVC then exit;
  hw:=GetWindow(Target.Handle, GW_CHILD);
  while hw>0 do
    begin
      n:='';

      SetLength(n, 64);
      i:=GetClassName(hw,PChar(n), 64);
      if i>0 then SetLength(n,i);

      if SameText(n, 'TContainer') then
        begin
          if c=LMDGetNonVCIndex(Target, Comp) then
            begin
              GetWindowRect(hw, r);
               with Target do
                 begin
                   p:=ScreenToClient(r.TopLeft);
                   p1:=ScreenToClient(r.BottomRight);
                   if (((p1.X-p.x)<>defComWidth) or ((p1.y-p.y)<>defComWidth)) then
                     begin
                        raise Exception.Create('TLMDHideNonVC: Display of component caption in designmode is '+
                                               'activated.'#13'Please disable this option or remove TLMDHideNonVC component.');
                     end
                   else
                     if aValue then

                       SetWindowPos(hw,0,LongRec(Comp.DesignInfo).Lo,LongRec(Comp.DesignInfo).Hi,

                                    0,0,SWP_NOSIZE OR SWP_NOZORDER)

                     else
                       SetWindowPos(hw,0,-40,0,0,0,SWP_NOSIZE OR SWP_NOZORDER);
                 end;
               exit;
            end;
          Inc(c);
        end;
      hw:=GetWindow(hw, GW_HWNDNEXT);
    end;

end;

{------------------------------------------------------------------------------}
procedure LMDShowContainer(Target:TScrollingWinControl; Comp:TComponent);
begin
  LMDHandleContainer(Target, Comp, True);
end;

{------------------------------------------------------------------------------}
procedure LMDRemoveContainer(Target:TScrollingWinControl; Comp:TComponent);
begin
  LMDHandleContainer(Target, Comp, False);
end;

{class}
{--------------------------- Protected ----------------------------------------}
procedure TLMDHideNonVC.Loaded;
begin
  inherited Loaded;
end;

{------------------------------------------------------------------------------}
procedure TLMDHideNonVC.Notification(AComponent:TComponent;Operation:TOperation);
var
  i:Integer;
begin
  inherited Notification(aComponent, Operation);
  if (csDesigning in ComponentState) then
    begin
      if (Operation=opInsert) and LMDCheckValidComponent(aComponent, Self) then
        if Assigned(FNewComponent) then FNewComponent(Self, aComponent);

      if (Operation=opRemove) and (aComponent=self) and not (csDestroying in TForm(Owner).ComponentState) then
        begin
          FNewComponent:=nil;
          with TForm(owner) do
            for i:=Pred(ComponentCount) downto 0 do
              if LMDCheckValidComponent(Components[i], self) then
                with Components[i] do
                  if DesignInfo=defHideX then
                    begin
                      if FUseTag and (Tag<>0) then
                        begin
                          DesignInfo:=Tag;
                          Tag:=0
                        end
                      else
                        DesignInfo:=0;
                      LMDShowContainer(Designer.Form, TForm(owner).Components[i]);
                    end;
        end;
    end;
end;

{----------------------------- Public -----------------------------------------}
constructor TLMDHideNonVC.Create(aOwner:TComponent);
begin
  inherited Create(aOwner);
  FUseTag:=True;

  if csDesigning in ComponentState then
    if LMDCheckForSameClass(aOwner, self.ClassType, false) then
      raise ELMDOneInstError.Create(self.ClassName,0);
end;

initialization

end.
