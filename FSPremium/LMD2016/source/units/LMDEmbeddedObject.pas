unit LMDEmbeddedObject;
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

LMDEmbeddedObject unit ()
-------------------------

Changes
-------
Release 8.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Graphics,
  Classes,
  LMDObject,
  LMDBevel;

type
  TLMDEmbeddedObject = class (TLMDObject)
  private
    FBevel : TLMDBevel;
    FColor : TColor;
    FTransparent : Boolean;
    FFont : TFont;

    procedure SetBevel (aValue : TLMDBevel);
    procedure SetColor (aValue : TColor);
    procedure SetBoolean (aValue : Boolean);
    procedure SetFont (aValue : TFont);
  public
    constructor Create(Owner:TPersistent=nil); override;
    destructor Destroy; override;
    procedure Assign (Source : TPersistent); override;
  published
    property Bevel : TLMDBevel read FBevel write SetBevel;
    property Color : TColor read FColor write SetColor;
    property Transparent : Boolean read FTransparent write SetBoolean;
    property Font : TFont read FFont write SetFont;
  end;

implementation

{ -------------------------------- private ----------------------------------- }
procedure TLMDEmbeddedObject.SetBevel (aValue : TLMDBevel);
begin
  FBevel.Assign(aValue);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDEmbeddedObject.SetColor (aValue : TColor);
begin
  if aValue <> FColor then
    begin
      FColor := aValue;
      GetChange (self);
    end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDEmbeddedObject.SetBoolean (aValue : Boolean);
begin
  if aValue <> FTransparent then
    begin
      FTransparent := aValue;
      GetChange (self);
    end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDEmbeddedObject.SetFont (aValue : TFont);
begin
  FFont.Assign(aValue);
end;

{ ------------------------------- public ------------------------------------- }
constructor TLMDEmbeddedObject.Create;
begin
  inherited Create;
  FBevel := TLMDBevel.Create;
  FBevel.OnChange := GetChange;
  FFont := TFont.Create;
  FFont.OnChange := GetChange;
  FColor := clTeal;
  FTransparent := false;
end;

{ ---------------------------------------------------------------------------- }
destructor TLMDEmbeddedObject.Destroy;
begin
  FFont.OnChange := nil;
  FFont.Free;
  FBevel.OnChange := nil;
  FBevel.Free;
  inherited Destroy;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDEmbeddedObject.Assign (Source : TPersistent);
begin
  if source = self then exit;
  if source is TLMDEmbeddedObject then
    with  TLMDEmbeddedObject(Source) do
      begin
        self.FBevel.Assign (Bevel);
        self.FColor := Color;
        self.FTransparent := Transparent;
        self.FFont.Assign (Font);
      end
  else
    inherited Assign (Source);
end;

end.
