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
 IDS_OPENURL='Hyperlink �&ffnen';
 IDS_COPYURL='Hyperlink &kopieren';
 // ------

 // 7.1 MathParser
 // ----------------------------------------------------------------------------
 IDS_SyntaxError = 'Syntax Fehler';
 IDS_CloseBracketExpected = '")" erwartet';
 IDS_ExpressionEmpty = 'Ausdruck ist leer';
 IDS_OpenBracketExpected = '"(" erwartet';
 IDS_InvalidArgument = 'Ung�ltiges Argument';
 IDS_MathFunctions = 'Mathematische Funktionen';
 // ----------------------------------------------------------------------------

 IDS_PATH='Pfad:';
 IDS_ON='An';
 IDS_OFF='Aus';

 // TLMDCheckListBoxDlg
 IDS_SELECT='Ausw�hlen...';
 IDS_SELECTOPTIONS='Bitte die gew�nschte(n) Option(en) w�hlen...';

 //ButtonBar
 IDS_ADDSECTION='&Neue Gruppe hinzuf�gen';
 IDS_DELSECTION='Gruppe &entfernen';
 IDS_RENSECTION='Gruppe &umbenennen';
 IDS_ADDITEM='Neues Element &hinzuf�gen';
 IDS_DELITEM='Element ent&fernen';
 IDS_RENITEM='Element um&bennen';
 IDS_SMALLICONS='&Kleine Symbole';
 IDS_LARGEICONS='&Gro�e Symbole';

 {TLMDCalendarDlg, 4.2}
 IDS_CALCAPTION='Kalender...';
 IDS_ACTUALDATE='Akt. Datum';

 //EditControls
 IDS_INSERT='&Einf�gen';
 IDS_COPY='&Kopieren';
 IDS_CUT='&Ausschneiden';
 IDS_UNDO='&R�ckg�ngig';
 IDS_SELECTALL='Alles ausw�&hlen';
 IDS_DELETE='&L�schen';
 IDS_SEARCH='Suchen';
 IDS_SEARCHMSG1='Textanfang erreicht - weiter vom Ende des Textes?';
 IDS_SEARCHMSG2='Textende erreicht - weiter vom Anfang des Textes?';
 IDS_REPLACE='Ersetzen';
 IDS_WORDWRAP='Zeilenumbruch';
 IDS_LINED='Liniert';
 IDS_REDO='Wiederherstellen';
 IDS_FONT='Schriftart';
 IDS_CLEAR='L�schen';
 IDS_ALIGNLEFT='Links ausrichten';
 IDS_ALIGNRIGHT='Rechts ausrichten';
 IDS_ALIGNCENTER='Zentrieren';
 IDS_STATISTICS='Text Statistiken';
 IDS_OPEN='�ffnen';
 IDS_SAVE='Speichern';
 IDS_PRINT='Drucken';
 IDS_PAGE='Seite';
 IDS_EDIT='Bearbeiten';

 // Component Messages
 IDS_MUSTSHOWONE='Mindestens eine Uhranzeige mu� aktiviert sein!!';
 IDS_INVALIDOWNER='Ung�ltiger Owner-Objekt (nicht TForm) oder zweite Instanz auf einer Form!';
 IDS_INTERVALNOTFIT='Angegebenes Intervall pa�t nicht zum gesetzten MinimalIntervall!';

 // TLMDAssist
 IDS_NEXT='&Weiter >';
 IDS_BACK='< &Zur�ck';
 IDS_FINISH='&Beenden';
 IDS_HELP='&Hilfe';
 IDS_CLOSE='&Schlie�en';
 IDS_CANCEL='Abbrechen';

 // TLMDListBox
 IDS_PROPERTYNOTUSED = 'This property is no longer used in LMD-Tools!';

 // TLMDMessageHintController
 IDS_MESSAGEHINTNOTASSIGNED = 'MessageHintControl property is not assigned!';

 // TLMDOneInstance
 IDS_ALREADYSTARTED='wurde schon gestartet...';

 // LMD-Tools Dialog components
 // ****************************************************************************
 {TLMDAboutDlg}
 IDS_AboutInfo='Programminfo ';
 IDS_AboutAvailMemory='Verf�gbarer Arbeitsspeicher:';
 IDS_AboutSysRes='Systemressourcen:';
 IDS_AboutCompatible='oder kompatibel';
 IDS_AboutPlatform='Plattform, Prozessor:';
 IDS_FREE='frei';

 {TLMDColorComboBox}
 IDS_COLORCOMBOBOXCUSTOM='Benutzerdef. Farbe...';

 {TLMDDirDlg}
 IDS_DIRCAPTION='Pfad ausw�hlen...';
 IDS_DIRDRIVE='&Laufwerk:';
 IDS_DIRPATH='&Verzeichnis:';
 IDS_NEWPATH='&Neues Verz.';

 {TLMDTipDlg}
 IDS_TIPERROR='Keine Tips verf�gbar - der Dialog wird nicht angezeigt...';
 IDS_SHOWATSTART='Tips bei jedem Programmstart zeigen';
 IDS_TIPNEXT='&N�chster Tip';
 IDS_TIPPREV='&Vorheriger Tip';

 {TLMDWindowList}
 IDS_WLCAPTION='Fensterliste...';
 IDS_WLDESC='Verf�gbare &Fenster:';


 {TLMDMessageBoxDlg}
 IDS_DONTSHOWAGAIN='Nicht wieder anzeigen';

 {TLMDInputDlg, 5.0}
 IDS_INPUTCAPTION='Eingabe...';

 {TLMDTextEditorDlg, 5.0}
 IDS_TEXTEDITORCAPTION='Text Editor';

implementation

end.
