unit LMDSysFonts;
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

LMDSysFonts unit (JH)
-----------------------


Changes
-------
Release 3.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Classes,
  LMDSysBaseComponent,
  LMDSysFontInfo;

type
  { ************************************************************************** }
  TLMDSysFonts = class(TLMDSysBaseComponent)
  private
    FFonts: TLMDFontsInfo;
    procedure SetFonts(const Value: TLMDFontsInfo);
  protected
    procedure RefreshIt; override;
  public
    constructor Create(aOwner: TComponent); override;
    destructor Destroy; override;
    function GetElement(index : integer) : TObject;  override;
  published
    property Fonts: TLMDFontsInfo read FFonts write SetFonts stored false;
  end;

implementation

{ **************************** TLMDSysFonts ********************************** }
{ ------------------------------- private ------------------------------------ }

procedure TLMDSysFonts.SetFonts(const Value: TLMDFontsInfo);
begin
  FFonts.Assign(Value);
end;

{ ---------------------------- protected ------------------------------------ }
procedure TLMDSysFonts.RefreshIt;
begin
  FFonts.Refresh;
  SetRetrieved;
end;

{ ------------------------------- public ------------------------------------- }

constructor TLMDSysFonts.Create(aOwner: TComponent);
begin
  inherited Create(aOwner);
  //  FSysObject := TLMDFontsInfo.Create(Self);
  //  InitSysObject;
  FFonts:= TLMDFontsInfo.Create(Self);
  //FFonts.Refresh;
end;

{ --------------------------------------------------------------------------- }
destructor TLMDSysFonts.Destroy;
begin
  FFonts.Free;
  inherited;
end;

{------------------------------------------------------------------------------}
function TLMDSysFonts.GetElement(index: integer): TObject;
begin
  result:=FFonts;
end;

end.
