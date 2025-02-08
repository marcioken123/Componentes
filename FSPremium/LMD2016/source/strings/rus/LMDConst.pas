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
 IDS_SyntaxError = '�������������� ������';
 IDS_CloseBracketExpected = '��������� ")"';
 IDS_ExpressionEmpty = '��������� �����';
 IDS_OpenBracketExpected = '��������� "("';
 IDS_InvalidArgument = '������������ ��������';
 IDS_MathFunctions = '�������������� �������';
 // ----------------------------------------------------------------------------
 
 IDS_PATH='����:';
 IDS_ON='���';
 IDS_OFF='����';

 // TLMDCheckListBoxDlg
 IDS_SELECT='Select...';
 IDS_SELECTOPTIONS='Select desired option(s)...';

 //ButtonBar
 IDS_ADDSECTION='�&������� ������';
 IDS_DELSECTION='��&����� ������';
 IDS_RENSECTION='�&������������ ������';
 IDS_ADDITEM='&�������� �������';
 IDS_DELITEM='&������� �������';
 IDS_RENITEM='&������������� �������';
 IDS_SMALLICONS='&��������� ������';
 IDS_LARGEICONS='&������� ������';

 {TLMDCalendarDlg, 4.2}
 IDS_CALCAPTION='���������...';
 IDS_ACTUALDATE='�������� ����';

 //EditControls
 IDS_INSERT='&��������';
 IDS_COPY='&����������';
 IDS_CUT='���&�����';
 IDS_UNDO='&��������';
 IDS_SELECTALL='�������� ���';
 IDS_DELETE='&�������';
 IDS_SEARCH='�����';
 IDS_SEARCHMSG1='������ ... ��������� � �����?';
 IDS_SEARCHMSG2='����� ... ��������� �������?';
 IDS_REPLACE='��������';
 IDS_WORDWRAP='������� ������';
 IDS_LINED='������������';
 IDS_REDO='�������';
 IDS_FONT='�����';
 IDS_CLEAR='��������';
 IDS_ALIGNLEFT='����� ������������';
 IDS_ALIGNRIGHT='������ ������������';
 IDS_ALIGNCENTER='�� ������';
 IDS_STATISTICS='���������� ������';
 IDS_OPEN='�������';
 IDS_SAVE='���������';
 IDS_PRINT='������';
 IDS_PAGE='��������';
 IDS_EDIT='�������������'; 

 // Component Messages
 IDS_MUSTSHOWONE='������ ���� ������ ���� �� ���� �����!';
 IDS_INVALIDOWNER='�������� ������ (<>TForm) ��� �� ����� ������ ���������';
 IDS_INTERVALNOTFIT='������������ �������� � �������� MinInterval!';

 // TLMDAssist
 IDS_NEXT='&����� >';
 IDS_BACK='< &�����';
 IDS_FINISH='&������';
 IDS_HELP='&������';
 IDS_CLOSE='&�������';
 IDS_CANCEL='������';

 // TLMDListBox
 IDS_PROPERTYNOTUSED = '��� �������� ������ �� �������� � LMD-Tools!';

 // TLMDMessageHintController
 IDS_MESSAGEHINTNOTASSIGNED = '�������� �������� MessageHintControl �� ������!';

 // TLMDOneInstance
 IDS_ALREADYSTARTED='���������� ��� ��������...';

 // LMD-Tools Dialog components
 // ****************************************************************************
 {TLMDAboutDlg}
 IDS_AboutInfo='���������� ';
 IDS_AboutAvailMemory='��������� ������:';
 IDS_AboutSysRes='��������� �������:';
 IDS_AboutCompatible='��� �����������';
 IDS_AboutPlatform='���������, ���������:';
 IDS_FREE='��������';

 {TLMDColorComboBox}
 IDS_COLORCOMBOBOXCUSTOM='Custom color...';

 {TLMDDirDlg}
 IDS_DIRCAPTION='����� ��������...';
 IDS_DIRDRIVE='&����:';
 IDS_DIRPATH='&����:';
 IDS_NEWPATH='&����� �������';

 {TLMDTipDlg}
 IDS_TIPERROR='������ �� �������� - �� ��������� �������� Tips...';
 IDS_SHOWATSTART='���������� ��� ������ ������� ���������';
 IDS_TIPNEXT='&�������� �����';
 IDS_TIPPREV='&���������� �����';

 {TLMDWindowList}
 IDS_WLCAPTION='������ ����...';
 IDS_WLDESC='��������� &����:';

 {TLMDMessageBoxDlg}
 IDS_DONTSHOWAGAIN='������ �� ���������� ��� ���������';

 {TLMDInputDlg, 5.0}
 IDS_INPUTCAPTION='����...';

 {TLMDTextEditorDlg, 5.0}
 IDS_TEXTEDITORCAPTION='��������� ��������';


implementation

end.
