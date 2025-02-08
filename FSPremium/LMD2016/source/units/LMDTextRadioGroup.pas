unit LMDTextRadioGroup;
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

LMDTextRadioGroup unit (JH)
---------------------------

Changes
-------
Release 8.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Classes,
  LMDTextObject,
  LMDText,
  LMDCustomRadioGroup;

type
  {------------------------- TLMDTextRadioGroup -------------------------------}
  TLMDTextRadioGroup = class(TLMDCustomRadioGroup)
  private
    FText         : TLMDTextObject;
    FOnGetVariable: TLMDGetVariableEvent;

    procedure SetTextObject (aValue : TLMDTextObject);
  protected
    function DoGetVariable(Sender: TObject; const aVarName: string): string; virtual;
    procedure DoTxtChange(Sender: TObject);
    procedure SetButtonCount(aValue: Integer); override;
    procedure UpdateButtons; override;
  public
    constructor Create(aOwner : TComponent); override;
    destructor Destroy; override;
  published
    property ItemIndex;
    property TextSettings : TLMDTextObject read FText write SetTextObject;
  end;

implementation

uses
  Controls,
  SysUtils,
  LMDGraph,
  LMDCustomButtonGroup,
  LMDTextRadioGroupButton;

{ -------------------------------- private ----------------------------------- }
procedure TLMDTextRadioGroup.SetTextObject (aValue : TLMDTextObject);
begin
  FText.Assign (aValue);
end;

{ --------------------------------- protected -------------------------------- }
function TLMDTextRadioGroup.DoGetVariable(Sender: TObject; const aVarName: string): string;
begin
  result := '';
  if Assigned (FOnGetVariable) then result := FOnGetVariable (self, aVarName);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDTextRadioGroup.DoTxtChange(Sender: TObject);
begin
  UpdateButtons;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDTextRadioGroup.SetButtonCount(aValue: Integer);
begin
  while FButtons.Count<aValue do
    TLMDTextRadioGroupButton.CreateExt(Self);
  while FButtons.Count>aValue do
    TLMDTextRadioGroupButton(FButtons.Last).Free;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDTextRadioGroup.UpdateButtons;
var
  i: Integer;
  begin
  inherited;
  for i:=0 to Pred(FButtons.Count) do
    begin
      TLMDTextRadioGroupButton(FButtons[i]).UpdateNow(true);
      try
        TLMDTextRadioGroupButton(FButtons[i]).TextSettings.Assign (FText);
      finally
        TLMDTextRadioGroupButton(FButtons[i]).UpdateNow(false);
      end;
    end;
  end;

{ ------------------------------- public ------------------------------------- }
constructor TLMDTextRadioGroup.Create(aOwner:TComponent);
begin
  inherited Create(aOwner);
  FText := TLMDTextObject.Create(true);
  FText.OnChange := DoTxtChange;
  FText.OnGetVariable := DoGetVariable;

end;

{ ---------------------------------------------------------------------------- }
destructor TLMDTextRadioGroup.Destroy;
begin
  FreeAndNil(FText);
  inherited Destroy;
end;

end.
