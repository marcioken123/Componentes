unit LMD_RegText;
{$I LMDCmps.INC}

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

_LMD_RegText unit (JH)
-----------------------
Text components registration unit

Changes
-------
Release 8.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Classes,
  DesignIntf, DesignEditors,
  pLMDText_PE,
  // ------------
  LMDTextObject,
  // ------------
  LMDTextContainer,     //ContainerClass
  LMDTextPanel,         //panel
  LMDTextListBox,       //listbox
  LMDTextButton,        //button
  LMDTextSpeedButton,   //speed button
  LMDTextHint,          //hint
  LMDTextShapeHint,     //shapeable hint
  LMDTextLabel,         //label
  LMDTextCheckGroup,    //check button group
  LMDTextRadioButton,   //radio button
  LMDTextRadioGroup,    //radio button group
  LMDTextScroll,        //scrolling text
  LMDTextScrollPanel,   //text viewer
  LMDTextCheckBox;      //check box

  {
  LMDTextView,          //scrollview
  LMDTextDockLabel,     //dock label
  }

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('LMD Text', [TLMDTextContainer,
                                  TLMDTextPanel,
                                  TLMDTextListBox,
                                  TLMDTextButton,
                                  TLMDTextSpeedButton,
                                  TLMDTextHint,
                                  TLMDTextShapeHint,
                                  TLMDTextLabel,
                                  TLMDTextCheckBox,
                                  TLMDTextCheckGroup,
                                  TLMDTextRadioButton,
                                  TLMDTextScroll,
                                  TLMDTextScrollPanel,
                                  TLMDTextRadioGroup]);
 RegisterPropertyEditor(TypeInfo(string), TLMDTextObject, 'ParserClass', TLMDParserClassProperty);
 RegisterPropertyEditor(TypeInfo(TLMDStrings), nil, 'Lines', TLMDTextLinesProperty);
 RegisterPropertyEditor(TypeInfo(TLMDStrings), TLMDTextPanel, 'Lines', TLMDTextLinesProperty);
 RegisterPropertyEditor(TypeInfo(TLMDStrings), TLMDTextLabel, 'Lines', TLMDTextLinesProperty);
 RegisterPropertyEditor(TypeInfo(TLMDStrings), TLMDTextScrollPanel, 'Lines', TLMDTextLinesProperty);
 RegisterPropertyEditor(TypeInfo(TStrings), TLMDTextListBox, 'Items', TLMDTextLinesProperty);
 RegisterPropertyEditor(TypeInfo(TStrings), TLMDTextRadioGroup, 'Items', TLMDTextLinesProperty);
 RegisterComponentEditor(TLMDTextContainer, TLMDTextContainerEditor);
end;

end.
