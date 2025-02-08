unit LMDSysNetTreeView;
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

LMDSysNetTreeView unit (RM)
---------------------------


Changes
-------
Release 3.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls, LMDSysBase, LMDSysTreeView;

type

  { ************************** TLMDSysNetTreeView *****************************}
  TLMDSysNetTreeView=class(TLMDSysTreeView)
  private
    FImageList          : TImageList;
    procedure LoadImageList;
  protected
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property Items;
  published
  end;

implementation
uses
  CommCtrl, Imglist;

{ ***************************** TLMDSysTreeView ****************************** }
{ --------------------------------- private ---------------------------------- }
{ ---------------------------------------------------------------------------- }
procedure TLMDSysNetTreeView.LoadImageList;
var
  hImageList    : THandle;
  tmpBitmap     : TBitmap;
begin
  FImageList := TImageList.Create(nil);
  hImageList := ImageList_Create(16, 16, ILC_COLOR24 or ILC_MASK, 0, 1);
  FImageList.Handle := hImageList;

  tmpBitmap := TBitmap.Create;
  try
    tmpBitmap.LoadFromResourceName(HInstance,'LMDSYSNETTREE');
    FImageList.AddMasked(tmpBitmap, clFuchsia);
  finally
    tmpBitmap.Free;
  end;
end;

{ --------------------------------- protected -------------------------------- }

{ ---------------------------------------------------------------------------- }

{ --------------------------------- public ----------------------------------- }
constructor TLMDSysNetTreeView.Create(AOwner: TComponent);
begin
  inherited;
  LoadImageList;
  Images := FImageList;
end;

{ ---------------------------------------------------------------------------- }
destructor TLMDSysNetTreeView.Destroy;
begin
  FreeAndNil(FImageList);
  inherited Destroy;
end;

end.
