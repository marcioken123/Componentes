unit LMDBoundLabel;
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

LMDBoundLabel unit (JH)
-----------------------

Changes
-------
Release 8.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Classes,
  Controls,
  LMDBase,
  LMDGraph,
  LMDCustomSimpleLabel;

type

  TLMDBoundLabel = class (TLMDCustomSimpleLabel)
  private
    function GetTop: Integer;
    function GetLeft: Integer;
    function GetWidth: Integer;
    function GetHeight: Integer;
    procedure SetWidth(const Value: Integer);
    procedure SetHeight(const Value: Integer);
    function IsNotParent:Boolean;
    function GetAnchors: TAnchors;
    function GetConstraints: TSizeConstraints;
  protected
  public
    procedure CorrectBounds; override;
    constructor Create(AOwner: TComponent); override;
  published
    property Alignment default agCenterLeft;
    property Caption;
    property FocusControl stored IsNotParent;
    property Height: Integer read GetHeight write SetHeight;
    property Left: Integer read GetLeft;
    property Top: Integer read GetTop;
    property Width: Integer read GetWidth write SetWidth;

    property Anchors:TAnchors read GetAnchors;
    property Constraints:TSizeConstraints read GetConstraints;
  end;

implementation

uses
  Windows, LMDClass;

{ ----------------------------- private -------------------------------------- }
function TLMDBoundLabel.IsNotParent:Boolean;
begin
  result:=FocusControl<>Owner;
end;

{ ---------------------------------------------------------------------------- }
function TLMDBoundLabel.GetTop: Integer;
begin
  result := inherited Top;
end;

{ ---------------------------------------------------------------------------- }
function TLMDBoundLabel.GetLeft: Integer;
begin
  result := inherited Left;
end;

{ ---------------------------------------------------------------------------- }
function TLMDBoundLabel.GetWidth: Integer;
begin
  result := inherited Width;
end;

{ ---------------------------------------------------------------------------- }
function TLMDBoundLabel.GetAnchors: TAnchors;
begin
  result:=inherited Anchors;
end;

{ ---------------------------------------------------------------------------- }
function TLMDBoundLabel.GetConstraints: TSizeConstraints;
begin
  result:=inherited Constraints;
end;

{ ---------------------------------------------------------------------------- }
function TLMDBoundLabel.GetHeight: Integer;
begin
  result := inherited Height;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDBoundLabel.SetWidth(const Value: Integer);
begin
  inherited Width:=Value;
  //SetBounds(Left, Top, Value, Height);
  if not AutoSize then
    if [csLoading, csReading]*ComponentState=[] then
      SendMessage(TWinControl(Owner).Handle, CM_LMDBOUNDLABELCHANGE, 0, 0);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDBoundLabel.SetHeight(const Value: Integer);
begin
  inherited Height:=Value;
  //SetBounds(Left, Top, Width, Value);
  if not AutoSize then
    if [csLoading, csReading]*ComponentState=[] then
      SendMessage(TWinControl(Owner).Handle, CM_LMDBOUNDLABELCHANGE, 0, 0);
end;

{ ---------------------------------------------------------------------------- }
constructor TLMDBoundLabel.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Name := 'SubLabel';
  inherited Alignment:=agCenterLeft;
  SetSubComponent(True);
  if Assigned(AOwner) then
    Caption := AOwner.Name;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDBoundLabel.CorrectBounds;
begin
  inherited CorrectBounds;
  //if [csLoading, csReading]*ComponentState<>[] then //VB June 2009
    if (Owner is TWinControl) and TWinControl(Owner).HandleAllocated then
      SendMessage(TWinControl(Owner).Handle, CM_LMDBOUNDLABELCHANGE, 0, 0)
end;

end.
