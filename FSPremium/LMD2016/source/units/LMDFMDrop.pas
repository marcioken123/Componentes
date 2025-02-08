unit LMDFMDrop;
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

LMDFMDrop unit (RM)
-------------------

Changes
-------
Release 8.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Classes, Messages, Controls, LMDSysIn, LMDClass, LMDHookComponent, Dialogs;

type
  {used by TLMDForm and TLMDFMDrop}
  TLMDFMDragDropEvent = procedure(Sender:TObject; fcount, x,y:Integer; FileList:TStrings) of object;

  TLMDFMDrop=class(TLMDCustomHookComponent)
  private
    FOnDragDrop: TLMDFMDragDropEvent;
    FCharCase:TLMDCharCase;
  protected
    procedure HandleMessage(var Message:TMessage);
    procedure Init;override;
    procedure RestoreState;override;
    procedure TriggerBeforeProcessEvent(var Msg : TMessage; var Handled : boolean); override;
    procedure TriggerAfterProcessEvent(var Msg: TMessage; var Handled: Boolean); override;
  public
    constructor Create(AOwner: TComponent); override;
  published
    property About;
    property CharCase:TLMDCharCase read FCharCase write FCharCase default ccNormal;
    property Control;
    property Enabled;
    property OnFMDragDrop: TLMDFMDragDropEvent read FOnDragDrop write FOnDragDrop;
  end;

implementation

uses
  Windows, ShellApi, SysUtils,
  LMDUtils, LMDStrings, LMDShUtils;

{--------------------------- Private ------------------------------------------}
procedure TLMDFMDrop.HandleMessage(var Message: TMessage);
var
  aList:TStringList;
  tmpp:TPoint;
  i, size, count:Integer;
  FileName: string;
  hDrop:THandle;

  buffer:array[0..MAX_PATH] of Char;

begin
  if  Message.Msg = WM_DROPFILES  then
    begin

      // TWMDropFiles is simply wrong declared :-(
      hDrop:=THandle(Message.WParam);
      count:=DragQueryFile(hDrop,$FFFFFFFF, nil, 0);
      if Count>0 then
        begin
          DragQueryPoint(hDrop,tmpp);
          aList:=TStringList.Create;
          try
            for i := 0 to (count-1) do
              begin
                size:=DragQueryFile(hDrop, i, nil, 0);
                if size < MAX_PATH  then
                  begin

                    DragQueryFile(hDrop, i, buffer, size + 1);
                    FileName := StrPas(buffer);

                    case FCharCase of
                      ccNormal:    aList.Add(FileName);
                      ccUpperCase: aList.Add(LMDAnsiUpperCase(FileName));
                      ccLowerCase: aList.Add(LMDAnsiLowerCase(FileName));
                    end;
                  end;
              end;
              FOnDragDrop(self, Count, tmpp.X, tmpp.Y, aList);
            finally
              aList.Free;
            end;
        end;
  end;
end;

{--------------------------- Protected ----------------------------------------}
procedure TLMDFMDrop.Init;
begin
  inherited Init;
  if Enabled and HasControl and (Control is TWinControl) then
    if not (csDesigning in ComponentState) then
      DragAcceptFiles(TWinControl(Control).Handle, True);
end;

{------------------------------------------------------------------------------}
procedure TLMDFMDrop.RestoreState;
begin
  if [csDesigning, csDestroying]*ComponentState=[] then
    if HasControl and (Control is TWinControl) then DragAcceptFiles(TWinControl(Control).Handle, False);
  inherited RestoreState;
end;

{------------------------------------------------------------------------------}
procedure TLMDFMDrop.TriggerAfterProcessEvent(var Msg: TMessage; var Handled: Boolean);
begin
  if Msg.Msg = CM_RECREATEWND then
    Init;
  inherited;
end;

procedure TLMDFMDrop.TriggerBeforeProcessEvent(var Msg: TMessage; var Handled: boolean);
begin
  if  Msg.Msg = WM_DROPFILES  then
    if Assigned(FOnDragDrop) then HandleMessage(Msg);
  inherited;
end;

{---------------------------- Public ------------------------------------------}
constructor TLMDFMDrop.Create(aOwner:TComponent);
begin
  inherited Create(aOWner);
  FCharCase:=ccNormal;
  // Magic value
  LMDChangeWindowMessageFilter($49, True);
  LMDChangeWindowMessageFilter(WM_DROPFILES, True);
end;

end.
