unit LMDTextCheckGroup;
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

LMDTextCheckGroup unit (JH)
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
  LMDCustomCheckGroup;

type
  {------------------------- TLMDTextCheckGroup -------------------------------}
  TLMDTextCheckGroup = class(TLMDCustomCheckGroup)
  private
    FText : TLMDTextObject;
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
    property TextSettings : TLMDTextObject read FText write SetTextObject;
    property Value;
    property IgnoreValue;
  end;

implementation

uses
  Controls,
  LMDGraph,
  SysUtils,
  LMDProcs,
  LMDCustomButtonGroup,
  LMDTextCheckGroupButton;

{ -------------------------------- private ----------------------------------- }
procedure TLMDTextCheckGroup.SetTextObject (aValue : TLMDTextObject);
begin
  FText.Assign (aValue);
end;

{ --------------------------------- protected -------------------------------- }
function TLMDTextCheckGroup.DoGetVariable(Sender: TObject; const aVarName: string): string;
begin
  result := '';
  if Assigned (FOnGetVariable) then result := FOnGetVariable (self, aVarName);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDTextCheckGroup.DoTxtChange(Sender: TObject);
begin
  UpdateButtons;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDTextCheckGroup.SetButtonCount(aValue: Integer);
begin
  while FButtons.Count<aValue do
    TLMDTextCheckGroupButton.CreateExt(Self);
  while FButtons.Count>aValue do
    TLMDTextCheckGroupButton(FButtons.Last).Free;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDTextCheckGroup.UpdateButtons;
var
  i: Integer;
  begin
  inherited;
  for i:=0 to Pred(FButtons.Count) do
    begin
      TLMDTextCheckGroupButton(FButtons[i]).UpdateNow(true);
      try
        TLMDTextCheckGroupButton(FButtons[i]).TextSettings.Assign(FText);
      finally
        TLMDTextCheckGroupButton(FButtons[i]).UpdateNow(false);
      end;
    end;
  end;

{ ------------------------------- public ------------------------------------- }
constructor TLMDTextCheckGroup.Create(aOwner:TComponent);
begin
  inherited Create(aOwner);
  FText := TLMDTextObject.Create(true);
  FText.OnChange := DoTxtChange;
  FText.OnGetVariable := DoGetVariable;
end;

{ ---------------------------------------------------------------------------- }
destructor TLMDTextCheckGroup.Destroy;
begin
  FreeAndNil(FText);
  inherited Destroy;
end;

end.
