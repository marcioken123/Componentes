unit LMDRTFConst;
{###############################################################################

LMDRTFConst unit (RM)
--------------------
Unit containing resource strings used by the components

Changes
-------
Release 4.0 (October 2006)
 - Initial Release

###############################################################################}

interface

resourcestring

 // General
 IDRTF_OK='������';
 IDRTF_CANCEL='������';
 IDRTF_CLOSE='�������';
 IDRTF_HELP='&������';

 // used for unnamed items in "Save as" dialog
 IDRTF_DOCUMENT='document';
 

 IDRTF_AVAILABLEFORMATS='��������� �������:';
 IDRTF_DATETIME='����/�����';

 IDRTF_NEW='�������';
 IDRTF_NONE='(none)';
 IDRTF_DELETE='�������';
 IDRTF_DELETEALL='������� ���';
 IDRTF_SELECT='�������';

 // Bookmark Dialog
 IDRTF_BOOKMARKS='��������';

 // RichText Editor
 IDRTF_ALIGN='������������';
 IDRTF_NUMBERING='���������';
 IDRTF_UNDERLINE='�������������';

 // Paragraph
 IDRTF_PARAGRAPH = '��������';
 IDRTF_JUSTIFY = '&���������:';
 IDRTF_JUSTIFIES = '�����,"�� ������",������,"� ����� ������"';
 IDRTF_JUSTIFYLEFT = '��������� �����';
 IDRTF_JUSTIFYCENTER = '��������� �� ������';
 IDRTF_JUSTIFYRIGHT = '��������� ������';

 IDRTF_MARGINS = '�������';
 IDRTF_LEFT = '�����';
 IDRTF_RIGHT = '������';
 IDRTF_FIRSTLINE = '������ ������:';
 IDRTF_INDENTAT = '��:';
 IDRTF_INDENTS = '(���),��������� ������,"��������� ������"';

 IDRTF_INTERVALS = '���������';
 IDRTF_BEFORE = '�����:';
 IDRTF_AFTER = '�����:';
 IDRTF_LINESPACING = '����������� ��������:';
 IDRTF_SPACINGS = '���������,����������,�������,�������,�����,���������';
 IDRTF_VALUE = '��������:'; 

 IDRTF_TABSTOPS = '&�����������';

 IDRTF_SET = '����������';

 // Link Dialog
 IDRTF_URL = 'URL';
 IDRTF_Link = 'Link';

 // Actions Category
 IDRTF_AC_FILE = '����';
 IDRTF_AC_EDIT = '�������������';
 IDRTF_AC_FORMAT = '������';

 // Actions
 IDRTF_ANEW = '�������';
 IDRTF_AOPEN = '�������...';
 IDRTF_ASAVE = '���������';
 IDRTF_ASAVEAS = '��������� ���...';
 IDRTF_APARAGRAPH = '��������...';
 IDRTF_AFONT = '�����...';
 IDRTF_ABOLD = '����������';
 IDRTF_AITALIC = '������';
 IDRTF_AUNDERLINE = '������������';
 IDRTF_ASUBSCRIPT = '����������� �����';
 IDRTF_ASUPERSCRIPT = '����������� �����';
 IDRTF_AUNDO = '��������';
 IDRTF_AREDO = '�������';
 IDRTF_APRINT = '������';
 IDRTF_APREVIEW = '��������������� ��������...';
 IDRTF_APAGESETTINGS = '��������� ��������';
 IDRTF_AINSERTOBJ = '�������� ������...';
 IDRTF_AOBJPROPS = '�������� �������';
 IDRTF_ACOPY = '����������';
 IDRTF_ACUT = '��������';
 IDRTF_APASTE = '��������';
 IDRTF_APASTESPECIAL = '����������� �������...';
 IDRTF_ASELECTALL = '�������� ���';
 IDRTF_ADELETE = '�������';
 IDRTF_AALIGN = '������������';
 IDRTF_AINCREASEINDENT = '��������� ������';
 IDRTF_ADECREASEINDENT = '��������� ������';
 IDRTF_ANUMBERING = '���������';
 IDRTF_ANUMBERINGBULLET = '�������';
 IDRTF_ANUMBERINGARABICNUMBERS = '���������';
 IDRTF_AFIND = '�����...';
 IDRTF_AREPLACE = '������...';
 IDRTF_AINSERTCHAR = '�������� ������...';
 IDRTF_AINSERTDATETIME = '����/�����...';
 IDRTF_ASTATISTICS = '����������...';


 // Charmap dialog
 IDRTF_FONT = '�����';
 IDRTF_CHARSET = 'CharSet';
 IDRTF_CHARMAP = '������� ��������';

 // Find&Replace Dialog
 IDRTF_FR_NOTFOUND = '������ �� �������!';
 IDRTF_FR_REPLACED = '����������� %d �����.';

 // TLMDRTFStatisticsDlg
 IDRTF_SD_CAPTION = '����� ����������';
 IDRTF_SD_STATISTICS = '���������� :';
 IDRTF_SD_PAGES = '�������';
 IDRTF_SD_WORDS = '����';
 IDRTF_SD_CHARACTERSWOS = '�������� (��� ��������)';
 IDRTF_SD_CHARACTERSWS = '�������� (������� �������)';
 IDRTF_SD_PARAGRAPHS = '�������';
 IDRTF_SD_LINES = '�����';

 // Ranges dialogs
 {IDRTF_COMMON = 'Common';
 IDRTF_STARTPOSITION = 'Start position:';
 IDRTF_ENDPOSITION = 'End position:';
 IDRTF_ADDRESS = 'Address:';
 IDRTF_DATASET = 'DataSet';
 IDRTF_CONNECTIONSTRING = 'Connection string:';
 IDRTF_QUERY = 'Query:';
 IDRTF_VIEW = 'View';
 IDRTF_FIELDNAME = 'Show field names';
 IDRTF_TABLEVIEW = 'Table view';
 IDRTF_FILENAME = 'File name:';
 IDRTF_IMAGE = 'Image';}

implementation

end.
