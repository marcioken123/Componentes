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
 IDRTF_OK='OK';
 IDRTF_CANCEL='Abbrechen';
 IDRTF_CLOSE='Schliessen';
 IDRTF_HELP='&Hilfe';

 // used for unnamed items in "Save as" dialog
 IDRTF_DOCUMENT='Dokument';

 IDRTF_AVAILABLEFORMATS='Verf�gbare Formate::';
 IDRTF_DATETIME='Datum und Zeit';

 IDRTF_NEW='Neu';
 IDRTF_NONE='(kein)';
 IDRTF_DELETE='L�schen';
 IDRTF_DELETEALL='Alle l�schen';
 IDRTF_SELECT='Ausw�hlen';

 // Bookmark Dialog
 IDRTF_BOOKMARKS='Lesezeichen';

 // RichText Editor
 IDRTF_ALIGN='Ausrichtung';
 IDRTF_NUMBERING='Numerierung';
 IDRTF_UNDERLINE='Unterstreichen';

 // Paragraph
 IDRTF_PARAGRAPH = 'Absatz';
 IDRTF_JUSTIFY = 'Aus&richtung:';
 IDRTF_JUSTIFIES = 'Linsb�ndig,Zentrieren,Rechtsb�ndig';
 IDRTF_JUSTIFYLEFT = 'Linksb�ndig';
 IDRTF_JUSTIFYCENTER = 'Zentrieren';
 IDRTF_JUSTIFYRIGHT = 'Rechtsb�ndig';

 IDRTF_MARGINS = 'R�nder';
 IDRTF_LEFT = 'Rechts';
 IDRTF_RIGHT = 'Links';
 IDRTF_FIRSTLINE = 'Erste &Zeile:';
 IDRTF_INDENTAT = '&Um:';
 IDRTF_INDENTS = '(kein),Einzug verkleinern,Einzug vergr��ern';

 IDRTF_INTERVALS = 'Abstand';
 IDRTF_BEFORE = 'Vor:';
 IDRTF_AFTER = 'Nach:';
 IDRTF_LINESPACING = 'Zeilenabstand:';
 IDRTF_SPACINGS = 'Einzeilig,1.5 Zeilen,Doppelt,Minimum,Genau,Mehrfach';
 IDRTF_VALUE = 'Ma�:';

 IDRTF_TABSTOPS = '&Tabstopps';
 IDRTF_SET = 'Setzen';

 // Link Dialog
 IDRTF_URL = 'URL';
 IDRTF_Link = 'Link';

 // Actions Category
 IDRTF_AC_FILE = 'Datei';
 IDRTF_AC_EDIT = 'Bearbeiten';
 IDRTF_AC_FORMAT = 'Format';

 // Actions
 IDRTF_ANEW = 'Neu';
 IDRTF_AOPEN = 'Datei �ffnen...';
 IDRTF_ASAVE = 'Speichern';
 IDRTF_ASAVEAS = 'Speichern unter...';
 IDRTF_APARAGRAPH = 'Absatz...';
 IDRTF_AFONT = 'Schriftart...';
 IDRTF_ABOLD = 'Fett';
 IDRTF_AITALIC = 'Kursiv';
 IDRTF_AUNDERLINE = 'Unterstrichen';
 IDRTF_ASUBSCRIPT = 'Tiefgestellt';
 IDRTF_ASUPERSCRIPT = 'Hochgestellt';
 IDRTF_AUNDO = 'R�ckg�ngig';
 IDRTF_AREDO = 'Wiederholen';
 IDRTF_APRINT = 'Drucken';
 IDRTF_APREVIEW = 'Seitenansicht...';
 IDRTF_APAGESETTINGS = 'Seite einrichten...';
 IDRTF_AINSERTOBJ = 'Objekt einf�gen...';
 IDRTF_AOBJPROPS = 'Objekteigenschaften';
 IDRTF_ACOPY = 'Kopieren';
 IDRTF_ACUT = 'Ausschneiden';
 IDRTF_APASTE = 'Einf�gen';
 IDRTF_APASTESPECIAL = 'Inhalte einf�gen...';
 IDRTF_ASELECTALL = 'Alles markieren';
 IDRTF_ADELETE = 'L�schen';
 IDRTF_AALIGN = 'Ausrichtung';
 IDRTF_AINCREASEINDENT = 'Einzug vergr��ern';
 IDRTF_ADECREASEINDENT = 'Einzug verkleinern';
 IDRTF_ANUMBERING = 'Numerieren';
 IDRTF_ANUMBERINGBULLET = 'Aufz�hlungszeichen';
 IDRTF_ANUMBERINGARABICNUMBERS = 'Numerierung';
 IDRTF_AFIND = 'Suchen...';
 IDRTF_AREPLACE = 'Ersetzen...';
 IDRTF_AINSERTCHAR = 'Zeichen einf�gen...';
 IDRTF_AINSERTDATETIME = 'Datum und Zeit...';
 IDRTF_ASTATISTICS = 'Text-Statistik...';

 // Charmap dialog
 IDRTF_FONT = 'Schrift';
 IDRTF_CHARSET = 'Zeichensatz';
 IDRTF_CHARMAP = 'Zeichentabelle';

 // Find&Replace Dialog
 IDRTF_FR_NOTFOUND = 'Zeichenkette wurde nicht gefunden!';
 IDRTF_FR_REPLACED = '%d gefundene Stelle(n) ersetzt.';

 // TLMDRTFStatisticsDlg
 IDRTF_SD_CAPTION = 'Text-Statistik';
 IDRTF_SD_STATISTICS = 'Statistik :';
 IDRTF_SD_PAGES = 'Seiten';
 IDRTF_SD_WORDS = 'Wort(e)';
 IDRTF_SD_CHARACTERSWOS = 'Zeichen (ohne Leerzeichen)';
 IDRTF_SD_CHARACTERSWS = 'Zeichen (mit Leerzeichen)';
 IDRTF_SD_PARAGRAPHS = 'Abs�tze';
 IDRTF_SD_LINES = 'Zeilen';
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
