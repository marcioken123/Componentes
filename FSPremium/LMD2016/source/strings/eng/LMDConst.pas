unit LMDConst;
{###############################################################################

LMDConst unit (--)
------------------

Unit containing resource strings used by the components

already available in several other languages!

Changes
-------
Release 8.0 (October 2006)
 - Initial Release

###############################################################################}

interface

resourcestring
  // 8.0  --> TLMDCustomSimpleLabel
 IDS_OPENURL='&Open URL';
 IDS_COPYURL='&Copy URL';
 // ------

 // 7.1 MathParser
 IDS_SyntaxError = 'Syntax error';
 IDS_CloseBracketExpected = '")" expected';
 IDS_ExpressionEmpty = 'Expression is empty';
 IDS_OpenBracketExpected = '"(" expected';
 IDS_InvalidArgument = 'Invalid argument';
 IDS_MathFunctions = 'Mathematical functions';
 // ----------------------------------------------------------------------------

 IDS_PATH='Path:';
 IDS_ON='On';
 IDS_OFF='Off';

 // TLMDCheckListBoxDlg
 IDS_SELECT='Select...';
 IDS_SELECTOPTIONS='Select desired option(s)...';

 //ButtonBar
 IDS_ADDSECTION='Add Sect&ion';
 IDS_DELSECTION='D&elete Section';
 IDS_RENSECTION='Re&name Section';
 IDS_ADDITEM='&Add Item';
 IDS_DELITEM='&Delete Item';
 IDS_RENITEM='&Rename Item';
 IDS_SMALLICONS='&Small icons';
 IDS_LARGEICONS='&Large icons';

 {TLMDCalendarDlg, 4.2}
 IDS_CALCAPTION='Calendar...';
 IDS_ACTUALDATE='Today';

 //EditControls
 IDS_INSERT='&Paste';
 IDS_COPY='&Copy';
 IDS_CUT='&Cut';
 IDS_UNDO='&Undo';
 IDS_SELECTALL='Select all';
 IDS_DELETE='&Delete';
 IDS_SEARCH='Search';
 IDS_SEARCHMSG1='At top ... restart from bottom?';
 IDS_SEARCHMSG2='At bottom ... restart from top?';
 IDS_REPLACE='Replace';
 IDS_WORDWRAP='Wordwrap';
 IDS_LINED='Lined';
 IDS_REDO='Redo';
 IDS_FONT='Font';
 IDS_CLEAR='Clear';
 IDS_ALIGNLEFT='Align left';
 IDS_ALIGNRIGHT='Align right';
 IDS_ALIGNCENTER='Center';
 IDS_STATISTICS='Text statistics';
 IDS_OPEN='Open';
 IDS_SAVE='Save';
 IDS_PRINT='Print';
 IDS_PAGE='Page';
 IDS_EDIT='Edit';

 // Component Messages
 IDS_MUSTSHOWONE='One clock style must be active!';
 IDS_INVALIDOWNER='Invalid owner (<>TForm) or second instance on a form';
 IDS_INTERVALNOTFIT='Interval not compatible with MinInterval property!';

 // TLMDAssist
 IDS_NEXT='Ne&xt >';
 IDS_BACK='< &Back';
 IDS_FINISH='&Finish';
 IDS_HELP='&Help';
 IDS_CLOSE='&Close';
 IDS_CANCEL='Cancel';

 // TLMDListBox
 IDS_PROPERTYNOTUSED = 'This property is no longer used in LMD-Tools!';


 // TLMDMessageHintController
 IDS_MESSAGEHINTNOTASSIGNED = 'MessageHintControl property is not assigned!';

  // TLMDOneInstance
 IDS_ALREADYSTARTED='was already started...';

 // LMD-Tools Dialog components
 // ****************************************************************************
 {TLMDAboutDlg}
 IDS_AboutInfo='Info ';
 IDS_AboutAvailMemory='Available Memory:';
 IDS_AboutSysRes='System Resources:';
 IDS_AboutCompatible='or compatible';
 IDS_AboutPlatform='Platform, CPU:';
 IDS_FREE='free';

 {TLMDColorComboBox}
 IDS_COLORCOMBOBOXCUSTOM='Custom color...';

 {TLMDDirDlg}
 IDS_DIRCAPTION='Select Path...';
 IDS_DIRDRIVE='&Drive:';
 IDS_DIRPATH='&Path:';
 IDS_NEWPATH='&New Folder';

 {TLMDTipDlg}
 IDS_TIPERROR='No Items available - Dialog will not be displayed...';
 IDS_SHOWATSTART='Show tips at every start';
 IDS_TIPNEXT='&Next Tip';
 IDS_TIPPREV='&Previous Tip';

 {TLMDWindowList}
 IDS_WLCAPTION='Windowlist...';
 IDS_WLDESC='Available &Windows:';

 {TLMDMessageBoxDlg}
 IDS_DONTSHOWAGAIN='Don''t show again';

 {TLMDInputDlg, 5.0}
 IDS_INPUTCAPTION='Input...';

 {TLMDTextEditorDlg, 5.0}
 IDS_TEXTEDITORCAPTION='Text Editor';

implementation

end.
