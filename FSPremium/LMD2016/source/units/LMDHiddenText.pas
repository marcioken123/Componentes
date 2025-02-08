unit LMDHiddenText;
{$I LMDCmps.inc}

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

LMDHiddenText unit (VO)
-----------------------

Support for unvisible data

ToDo:

Changes
-------
Release 8.0 (October 2006)
 - Initial Release

###############################################################################}

interface
uses
  Windows, Graphics, Classes,
  LMDText, LMDWriter;

type

  { ******************************** TLMDHiddenText ***************************}
  TLMDHiddenText = class (TLMDBaseText)
  private
    FText : string;
  protected
    function  NeedReCalcClientRect(aCanvas: TCanvas; const aDisplayRect: TRect;
      aDefFont: TFont; aAutoSize: Boolean; aWordWrap: Boolean) : boolean;override;
    procedure CalcClientRect(aCanvas: TCanvas; const aDisplayRect: TRect;
      aDefFont: TFont; aAutoSize: Boolean; aWordWrap: Boolean);override;
  public
    constructor Create(aParent: TLMDParsedTextList; const aText : string); 

    destructor Destroy; override;
    procedure Render(aCanvas: TCanvas; const aRect: TRect; const aOffset: TPoint;
      aDefFont: TFont; aBkColor: TColor; aAutoSize: Boolean; aWordWrap: Boolean;
      aMask: Boolean);override;
    procedure Store(AWriter : TLMDWriter); override;
    property Text : string read FText write FText;
  end;

implementation

{ ******************************** TLMDHiddenText *****************************}

constructor TLMDHiddenText.Create(aParent: TLMDParsedTextList; const aText : string);
begin
  inherited Create(aParent);
  FText := aText;
end;

{------------------------------------------------------------------------------}

destructor TLMDHiddenText.Destroy;
begin
  Inherited;
end;

{------------------------------------------------------------------------------}

function  TLMDHiddenText.NeedReCalcClientRect(aCanvas: TCanvas; const aDisplayRect: TRect;
  aDefFont: TFont; aAutoSize: Boolean; aWordWrap: Boolean) : boolean;
begin
  result := True;
end;

procedure TLMDHiddenText.CalcClientRect(aCanvas: TCanvas; const aDisplayRect: TRect;
  aDefFont: TFont; aAutoSize: Boolean; aWordWrap: Boolean);
begin
  FClientWidth := 0;
  FClientheight := 0;
end;

{------------------------------------------------------------------------------}

procedure TLMDHiddenText.Render(aCanvas: TCanvas; const aRect: TRect; const aOffset: TPoint;
  aDefFont: TFont; aBkColor: TColor; aAutoSize: Boolean; aWordWrap: Boolean;
  aMask: Boolean);
begin
end;

procedure TLMDHiddenText.Store(AWriter : TLMDWriter);
begin
    AWriter.Write(FText);
end;

end.
