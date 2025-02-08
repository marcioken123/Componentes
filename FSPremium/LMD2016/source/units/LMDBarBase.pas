unit LMDBarBase;
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

LMDBarBase unit (DD, RM, AH)
----------------------------
Implements constants, types and helper classes for LMD BarPack.

Changes
-------
Release 2.0 (October 2006)
 - Initial Release

###############################################################################}

  {$R LMDBarPack.res}

interface
uses
  Windows, Classes, Controls, Messages, Graphics,
  LMDCustomComponent, LMDObject, LMDTypes;

const
  CM_UPDATELINKCONTROLMSG = WM_USER+1;
  WM_UPDATESCROLL = WM_USER+2;

  LEB_VSPACE    = 10;
  LEB_HSPACE    = 10;
  LEB_VSECTIONS_SPACE = 15;

  LEB_VITEMS_SPACE    = 20;

  LEB_HEADER_BTN_SIZE = 20;
  LEB_HEADER_VSPACE   = 10;

  LEB_BACK_COLOR       = $DE8E6C;
  LEB_HEADER_START     = $FFFFFF;
  LEB_HEADER_END       = $F7D6D0;
  LEB_HEADER_COLOR     = $C65252;
  LEB_HEADER_HIGHLIGHT = $DE8E6C;
  LEB_ITEM_DISABLE     = $FEAEAC;
  LEB_SECTION_BACK     = $F7DFD6;
  LEB_HEADER_FONT_NAME = 'Tahoma';
  LEB_ITEM_FONT_NAME   = 'Tahoma';
  LEB_TRANS_COLOR      = $109311;

  LEB_SMOOTH_STEP      = 10;

  LEB_GLYPH_SIZE   = 19;
  LEB_HINTPAUSE    = 800;

  LSB_TEXTCOLOR    = clBlack;
  LSB_HIGHLIGHTEXT = clNavy;
  LSB_DISABLETEXT  = clSilver;
  LSB_IBORDERLIGHT = clWhite;
  LSB_IBORDERBLACK = clSilver;
  LSB_ITEMSELECTEDBACKGROUND = $F0F0F0;
  LSB_ITEMDOWNBACKGROUND = clBtnFace;
  LSB_ITEMDRAGBACKGROUND = $B0B0B0;
  LSB_ITEMDRAGBORDER     = clBlack;
  LSB_LISTVIEW_BACK      = clBtnFace;
  LSB_BUTTON_BACK      = clBtnFace;

  type
  { ********************* TLMDBarParentControlInterface ********************** }
  TLMDBarParentControlInterface=interface
    ['{13432433-0000-4523-3456-454870235266}']
    function GetUseXP:boolean;
    function GetTheme:TLMDObject;
  end;

const
  IID_ILMDBarParentControlInterface: TGUID = '{13432433-0000-4523-3456-454870235266}';

type
  { ************************* TLMDBarController ****************************** }
  TLMDBarController=class(TLMDCustomComponent)
  protected
    FUpdateObjects : TList;
    procedure   UpdateParentControls(Internal:Integer=0);
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy;override;

    procedure   AddUpdateObject(aObject:TObject);
    procedure   RemoveUpdateObject(aObject:TObject);
    function    getLMDPackage:TLMDPackageID;override;
  published
    property About;
  end;

implementation
{$IFDEF LMD_DEBUGTRACE}
uses
   dialogs;
  {$I C2.INC}
{$ENDIF}

{************************** TLMDBarController *********************************}
{------------------------------ private ---------------------------------------}
procedure TLMDBarController.UpdateParentControls(Internal:Integer=0);
var
  i : Integer;
  Msg : TMessage;
begin
  Msg.Msg := CM_UPDATELINKCONTROLMSG;
  Msg.WParam := Word(Internal);
  Msg.LParam := LPARAM(Pointer(Self));
  for i:=0 to FUpdateObjects.Count-1 do
    TObject(FUpdateObjects[i]).Dispatch(Msg);
end;

{----------------------------- public -----------------------------------------}
constructor TLMDBarController.Create(AOwner: TComponent);
begin
  inherited;
  FUpdateObjects := TList.Create;
end;

{------------------------------------------------------------------------------}
destructor TLMDBarController.Destroy;
begin
  FUpdateObjects.Free;
  inherited;
end;

{------------------------------------------------------------------------------}
procedure TLMDBarController.AddUpdateObject(aObject: TObject);
begin
  FUpdateObjects.Add(aObject);
end;

{------------------------------------------------------------------------------}
procedure TLMDBarController.RemoveUpdateObject(aObject: TObject);
begin
  FUpdateObjects.Remove(aObject);
end;

{------------------------------------------------------------------------------}
function TLMDBarController.getLMDPackage: TLMDPackageID;
begin
  result:=pi_LMD_BAR;
end;

initialization
{$IFDEF LMD_DEBUGTRACE}
  {$I C3.INC}
{$ENDIF}

end.
