unit LMDRTFConst;

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
 IDRTF_OK='OK';
 IDRTF_CANCEL='Cancel';
 IDRTF_CLOSE='Close';
 IDRTF_HELP='&Help';

 // used for unnamed items in "Save as" dialog
 IDRTF_DOCUMENT='document';
 IDRTF_AVAILABLEFORMATS='Available formats:';
 IDRTF_DATETIME='Date and Time';

 IDRTF_NEW='New';
 IDRTF_NONE='(none)';
 IDRTF_DELETE='Delete';
 IDRTF_DELETEALL='Delete All';
 IDRTF_SELECT='Select';

 // Bookmark Dialog
 IDRTF_BOOKMARKS='BookMarks';

 // RichText Editor
 IDRTF_ALIGN='Align';
 IDRTF_NUMBERING='Numbering';
 IDRTF_UNDERLINE='Underline';

 // Paragraph
 IDRTF_PARAGRAPH = 'Paragraph';
 IDRTF_JUSTIFY = 'Justify:';
 IDRTF_JUSTIFIES = 'Left,Center,Right';
 IDRTF_JUSTIFYLEFT = 'Left Justify';
 IDRTF_JUSTIFYCENTER = 'Center Justify';
 IDRTF_JUSTIFYRIGHT = 'Right Justify';

 IDRTF_MARGINS = 'Margins';
 IDRTF_LEFT = 'left';
 IDRTF_RIGHT = 'right';
 IDRTF_FIRSTLINE = 'first line:';
 IDRTF_INDENTAT = 'at:';
 IDRTF_INDENTS = '(none),indent,unindent';

 IDRTF_INTERVALS = 'Intervals';
 IDRTF_BEFORE = 'before:';
 IDRTF_AFTER = 'after:';
 IDRTF_LINESPACING = 'line spacing:';
 IDRTF_SPACINGS = 'single,one-and-half,double,minimum,exactly,multiplier';
 IDRTF_VALUE = 'value:'; 

 IDRTF_TABSTOPS = '&Tabstops';

 IDRTF_SET = 'Set';

 // Link Dialog
 IDRTF_URL = 'URL';
 IDRTF_Link = 'Link';

 // Actions Category
 IDRTF_AC_FILE = 'File';
 IDRTF_AC_EDIT = 'Edit';
 IDRTF_AC_FORMAT = 'Format';

 // Actions
 IDRTF_ANEW = 'New file';
 IDRTF_AOPEN = 'Open a file...';
 IDRTF_ASAVE = 'Save';
 IDRTF_ASAVEAS = 'Save As...';
 IDRTF_APARAGRAPH = 'Paragraph...';
 IDRTF_AFONT = 'Font...';
 IDRTF_ABOLD = 'Bold';
 IDRTF_AITALIC = 'Italic';
 IDRTF_AUNDERLINE = 'Underline';
 IDRTF_ASUBSCRIPT = 'Subscript';
 IDRTF_ASUPERSCRIPT = 'Superscript';
 IDRTF_AUNDO = 'Undo';
 IDRTF_AREDO = 'Redo';
 IDRTF_APRINT = 'Print';
 IDRTF_APREVIEW = 'Preview...';
 IDRTF_APAGESETTINGS = 'Page Settings...';
 IDRTF_AINSERTOBJ = 'Insert Object...';
 IDRTF_AOBJPROPS = 'Object Properties';
 IDRTF_ACOPY = 'Copy';
 IDRTF_ACUT = 'Cut';
 IDRTF_APASTE = 'Paste';
 IDRTF_APASTESPECIAL = 'Paste Special...';
 IDRTF_ASELECTALL = 'Select All';
 IDRTF_ADELETE = 'Delete';
 IDRTF_AALIGN = 'Align';
 IDRTF_AINCREASEINDENT = 'Increase indent';
 IDRTF_ADECREASEINDENT = 'Decrease indent';
 IDRTF_ANUMBERING = 'Numbering';
 IDRTF_ANUMBERINGBULLET = 'Bullet';
 IDRTF_ANUMBERINGARABICNUMBERS = 'Arabic Numbers';
 IDRTF_AFIND = 'Find...';
 IDRTF_AREPLACE = 'Replace...';
 IDRTF_AINSERTCHAR = 'Insert char...';
 IDRTF_AINSERTDATETIME = 'Date and Time...';
 IDRTF_ASTATISTICS = 'Statistics...';

 // Charmap dialog
 IDRTF_FONT = 'Font';
 IDRTF_CHARSET = 'CharSet';
 IDRTF_CHARMAP = 'Character map';

  // Find&Replace Dialog
 IDRTF_FR_NOTFOUND = 'Search string not found!';
 IDRTF_FR_REPLACED = '%d occurences were replaced.';

 // TLMDRTFStatisticsDlg
 IDRTF_SD_CAPTION = 'Text statistics';
 IDRTF_SD_STATISTICS = 'Statistics :';
 IDRTF_SD_PAGES = 'Pages';
 IDRTF_SD_WORDS = 'Words';
 IDRTF_SD_CHARACTERSWOS = 'Characters (without spaces)';
 IDRTF_SD_CHARACTERSWS = 'Characters (with spaces)';
 IDRTF_SD_PARAGRAPHS = 'Paragraphs';
 IDRTF_SD_LINES = 'Lines';

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
