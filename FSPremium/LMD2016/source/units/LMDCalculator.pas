unit LMDCalculator;
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

LMDCalculator unit (JH)
----------------------
Calculator panel control. Panel containing inout btns and output label

Changes
-------
Release 8.05 (February 2008)
+ Parentbackground property

Release 8.0 (November 2006)
 - Initial Release

###############################################################################}

interface

uses
  Classes, Controls, Graphics, LMDButtonBase, LMDClass, LMDFXCaption,
  LMDButtonLayout, LMDGraph, LMDLabel, LMDSpeedButton, LMDStack,
  LMDEmbeddedObject, LMDCustomMaskEdit, LMDCustomPanelFill, LMDCalc;

type
  TLMDCalculator = class(TLMDCustomCalculator)
  published
    property About;
    property BackFX;
    property Bevel;
    property Color;
    property ButtonStyle;
    property ThemeMode;
    property ThemeGlobalMode;
    property Decimals;
    property Precision;
    property DragMode;
    property DragCursor;
    property DisplaySettings;
    property EditType;
    property BtnFont;
    property FillObject;
    property TabStop;
    property ParentBackground;
    property Transparent;
    property Visible;
    property Value;
    property OnCalc;
    property OnWork;
    property OnManualBtnSetup;
    property OnMouseEnter;
    property OnMouseExit;
    property OnMouseDown;
    property OnMouseUp;
    property OnKeyDown;
    property OnKeyUp;
    property OnDragOver;
    property OnEndDrag;
    property OnStartDrag;
    property OnDragDrop;
    property OnClick;
    property OnDblClick;
    property OnEnter;
    property OnExit;
    property OnContextPopup;
    {$IFDEF LMDCOMP9}
    property OnMouseActivate;
    {$ENDIF}
  end;

implementation

end.
