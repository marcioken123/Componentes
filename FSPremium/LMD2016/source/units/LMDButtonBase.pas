unit LMDButtonBase;
{$I lmdcmps.Inc}

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

LMDButtonBase unit (RM / JH)
----------------------------
Base unit with common button helpers

Changes
-------
Release 8.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Classes, Graphics, LMDGraph;

const
  BDF_ROUNDED=$1;
  BDF_FOCUSED=$2;
  BDF_SPEEDBUTTON=$4;
  BDF_EXTDOWNSTYLE=$8;
  BDF_MIDDLE=$10;
  BDF_DEFAULT=$20;
  BDF_MOUSEOVER=$40;
  BDF_SPLIT=$80;
  BDF_SPLITPARTTWO=$100;
  // 7.0
  BDF_CTLXP=$200;

  LMDBTNTIMERBORDER=0;
  LMDBTNTIMERREPEATED=1;

type
  {****************************************************************************}
  {* Standard Buttons
  {****************************************************************************}
  {Buttons}
  TLMDButtonState=(bsUp, bsDisabledUp, bsMouseOver, bsOptionSet, bsDown,
                   bsDragOver, bsDropDownOpen, bsDisabledDown, bsDefaultEd);

  TLMDUserButtonStyle=(//ubsAutoDetect,      // non-flat standard framed button, CtlXP: Standard button
                       ubsWin31,           // framed button, Win 31 style, CTLXP: standard button
                       ubsWin40,           // framed button, Win 40 style, CTLXP: standard button
                       ubsDelphi,          // framed button, Delphi style, CTLXP: standard button
                       ubsDelphiFlat,      // flat button, Delphi 1.0 Style, CTLXP: Tool button
                       ubsFlat,            // flat button, CTLXP: Tool button
                       ubsFlatUnColored,   // flat button without hot state, CTLXP: Tool button
                       ubsNavigator,       // flat button like ubsDelphiFlat, without hot state, CTLXP: Tool button
                       ubsExplorer,         // like ubsFlatUnColored, but transparent
                       ubsExplorerColored,  // like ubsflat, but transparent
                       ubsIntegrated,       // for use in other controls
                       ubsCombo,            // New in 7.0
                       ubsOffice,           // Office XP like button CTLXP: Tool button
                       ubsOfficeTransp,     // Office XP like button, transparent
                       ubsWin40Ext          // like Win40, but with hotstate in frame
                       //ubsWinXP,      //AutoDetect with CTLXP
                       //ubsWinXPCombo, //ubsCombo + CTLXP
                       //ubsWinXPTool   //ubsExplorer/ExplorerColored etc. + CTLXP
                       );

type
  TLMDGlyphKind=(gkCustom, gkEllipsis, gkFile, gkFolder, gkCalculator,
                 gkCalender, gkSearch, gkColor, gkFont);

  {-> for TLMDButtonLayout}
  TLMDArrowPosition=(apRightText, apLeftText, apRightGlyph, apLeftGlyph);

  {TLMDUserButtonStyle=(ubsAutoDetect, ubsWin31, ubsWin40, ubsDelphi);}
  TLMDNormalButtonStyle=(nbsAutoDetect, nbsWin31, nbsWin40);

  // required globally
const
  TLMDNormalBtnStyleString : array[TLMDNormalButtonStyle] of string = ('','nbsWin31', 'nbsWin40');

type
  {****************************************************************************}
  {* MultiMedia Buttons }
  {****************************************************************************}
  TLMDButtonFace=class(TObject);

  //4.0
  TLMDButtonFaceIndex=packed record
    ListIndex, ImageIndex:Word;
  end;

  TLMDButtonFaceIndices=array[TLMDButtonState] of TLMDButtonFaceIndex;

  // small helper
  // ---------------------------------------------------------------------------
  function LMDGetButtonBevel(Style:TLMDUserButtonStyle; State:TLMDButtonState):Byte;
  function LMDIsXPToolButton(const Value:TLMDUserButtonStyle):Boolean;

  // MMButton
  function LMDMMReturnFaceIndex(ListIndex,ImageIndex:Integer):TLMDButtonFaceIndex;
  procedure LMDMMSynchronize(var aValue:TLMDButtonFaceIndices; HotState:Boolean=false);
  procedure LMDMMInitFace(var aValue:TLMDButtonFaceIndices);
  // 7.01
  procedure LMDMMCopyFace(var aTarget:TLMDButtonFaceIndices; aSource:TLMDButtonFaceIndices);

  // helper method for automatic conversion of older button styles
  procedure LMDButtonReadExtStyle(Reader: TReader; var aExtStyle:TLMDUserButtonStyle; var aXP:Boolean);

implementation

uses
  Forms, Controls, TypInfo;

// helper method
{ ---------------------------------------------------------------------------- }
procedure LMDButtonReadExtStyle(Reader: TReader; var aExtStyle:TLMDUserButtonStyle; var aXP:Boolean);
var
  tmp:String;
begin
  tmp:=Reader.ReadIdent;
  // assign similar values to old identifiers
  if tmp='ubsWinXP' then
    begin aExtStyle:=ubsWin40; aXP:=True; exit; end;
  if tmp='ubsWinXPCombo' then
    begin aExtStyle:=ubsCombo; aXP:=True; exit; end;
  if tmp='ubsWinXPTool' then
    begin aExtStyle:=ubsExplorer; aXP:=True; exit; end;
  aExtStyle:=TLMDUserButtonStyle(GetEnumValue(TypeInfo(TLMDUserButtonStyle), tmp));
end;

{------------------------------------------------------------------------------}
function LMDIsXPToolButton(const Value:TLMDUserButtonStyle):Boolean;
begin
  result:=Value in [ubsDelphi, ubsDelphiFlat, ubsFlat, ubsNavigator, ubsExplorer,
                    ubsExplorerColored, ubsOffice, ubsOfficeTransp];
end;

{------------------------------------------------------------------------------}
function LMDGetButtonBevel(Style:TLMDUserButtonStyle; State:TLMDButtonState):Byte;
begin
  //if style=ubsAutoDetect then
  //  if NewStyleControls then Style:=ubsWin40 else Style:=ubsWin31;
  case Style of
    ubsWin40Ext, ubsWin40, ubsDelphi, ubsDelphiFlat, ubsNavigator, ubsIntegrated: result:=2;
    ubsWin31: result:=3;
  else
    result:=1;
  end;
end;

{------------------------------------------------------------------------------}
function LMDMMReturnFaceIndex(ListIndex,ImageIndex:Integer):TLMDButtonFaceIndex;
begin
  result.Listindex:=ListIndex;
  result.ImageIndex:=ImageIndex;
end;

{------------------------------------------------------------------------------}
// synchronizes States if 2 or 3 images are available only
// similar images can be used for up: bsDisabledUp, bsDragOver, bsMouseOver
//                              down: bsOptionSet, bsDropDownOpen, bsDisabledDown
// if hotstate is enabled, routine assumes a 3rd item for bsMouseOver and
// sets bsDragOver to same Value.
procedure LMDMMSynchronize(var aValue:TLMDButtonFaceIndices; HotState:Boolean=false);
begin
  // bsUp Values
  aValue[bsDisabledUp]:=aValue[bsUp];
  //  SetValue(bsDisabledUp, bsUp);
  if HotState then
    aValue[bsDragOver]:=aValue[bsMouseOver]
  else
    begin
      aValue[bsDragOver]:=aValue[bsUp];
      aValue[bsMouseOver]:=aValue[bsUp];
    end;
  // ??
  aValue[bsDefaultEd]:=aValue[bsUp];

  // bsDownValues
  aValue[bsOptionSet]:=aValue[bsDown];
  aValue[bsDropDownOpen]:=aValue[bsDown];
  aValue[bsDisabledDown]:=aValue[bsDown];
end;

{------------------------------------------------------------------------------}
procedure LMDMMInitFace(var aValue:TLMDButtonFaceIndices);
var
  i: TLMDButtonState;
begin
  for i:=Low(TLMDButtonState) to High(TLMDButtonState) do
    begin
      aValue[i].ListIndex:=0;
      aValue[i].ImageIndex:=0;
    end;
end;

{------------------------------------------------------------------------------}
procedure LMDMMCopyFace(var aTarget:TLMDButtonFaceIndices; aSource:TLMDButtonFaceIndices);
var
  i: TLMDButtonState;
begin
  for i:=Low(TLMDButtonState) to High(TLMDButtonState) do
    begin
      aTarget[i].ListIndex:=aSource[i].ListIndex;
      aTarget[i].ImageIndex:=aSource[i].ImageIndex;
    end;
end;

end.
