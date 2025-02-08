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
 IDS_OPENURL='Hyperlink ö&ffnen';
 IDS_COPYURL='Hyperlink &kopieren';
 // ------

 // 7.1 MathParser
 // ----------------------------------------------------------------------------
 IDS_SyntaxError = 'Syntax Fehler';
 IDS_CloseBracketExpected = '")" erwartet';
 IDS_ExpressionEmpty = 'Ausdruck ist leer';
 IDS_OpenBracketExpected = '"(" erwartet';
 IDS_InvalidArgument = 'Ungültiges Argument';
 IDS_MathFunctions = 'Mathematische Funktionen';
 // ----------------------------------------------------------------------------

 IDS_PATH='Pfad:';
 IDS_ON='An';
 IDS_OFF='Aus';

 // TLMDCheckListBoxDlg
 IDS_SELECT='Auswählen...';
 IDS_SELECTOPTIONS='Bitte die gewünschte(n) Option(en) wählen...';

 //ButtonBar
 IDS_ADDSECTION='&Neue Gruppe hinzufügen';
 IDS_DELSECTION='Gruppe &entfernen';
 IDS_RENSECTION='Gruppe &umbenennen';
 IDS_ADDITEM='Neues Element &hinzufügen';
 IDS_DELITEM='Element ent&fernen';
 IDS_RENITEM='Element um&bennen';
 IDS_SMALLICONS='&Kleine Symbole';
 IDS_LARGEICONS='&Große Symbole';

 {TLMDCalendarDlg, 4.2}
 IDS_CALCAPTION='Kalender...';
 IDS_ACTUALDATE='Akt. Datum';

 //EditControls
 IDS_INSERT='&Einfügen';
 IDS_COPY='&Kopieren';
 IDS_CUT='&Ausschneiden';
 IDS_UNDO='&Rückgängig';
 IDS_SELECTALL='Alles auswä&hlen';
 IDS_DELETE='&Löschen';
 IDS_SEARCH='Suchen';
 IDS_SEARCHMSG1='Textanfang erreicht - weiter vom Ende des Textes?';
 IDS_SEARCHMSG2='Textende erreicht - weiter vom Anfang des Textes?';
 IDS_REPLACE='Ersetzen';
 IDS_WORDWRAP='Zeilenumbruch';
 IDS_LINED='Liniert';
 IDS_REDO='Wiederherstellen';
 IDS_FONT='Schriftart';
 IDS_CLEAR='Löschen';
 IDS_ALIGNLEFT='Links ausrichten';
 IDS_ALIGNRIGHT='Rechts ausrichten';
 IDS_ALIGNCENTER='Zentrieren';
 IDS_STATISTICS='Text Statistiken';
 IDS_OPEN='Öffnen';
 IDS_SAVE='Speichern';
 IDS_PRINT='Drucken';
 IDS_PAGE='Seite';
 IDS_EDIT='Bearbeiten';

 // Component Messages
 IDS_MUSTSHOWONE='Mindestens eine Uhranzeige muß aktiviert sein!!';
 IDS_INVALIDOWNER='Ungültiger Owner-Objekt (nicht TForm) oder zweite Instanz auf einer Form!';
 IDS_INTERVALNOTFIT='Angegebenes Intervall paßt nicht zum gesetzten MinimalIntervall!';

 // TLMDAssist
 IDS_NEXT='&Weiter >';
 IDS_BACK='< &Zurück';
 IDS_FINISH='&Beenden';
 IDS_HELP='&Hilfe';
 IDS_CLOSE='&Schließen';
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
 IDS_AboutAvailMemory='Verfügbarer Arbeitsspeicher:';
 IDS_AboutSysRes='Systemressourcen:';
 IDS_AboutCompatible='oder kompatibel';
 IDS_AboutPlatform='Plattform, Prozessor:';
 IDS_FREE='frei';

 {TLMDColorComboBox}
 IDS_COLORCOMBOBOXCUSTOM='Benutzerdef. Farbe...';

 {TLMDDirDlg}
 IDS_DIRCAPTION='Pfad auswählen...';
 IDS_DIRDRIVE='&Laufwerk:';
 IDS_DIRPATH='&Verzeichnis:';
 IDS_NEWPATH='&Neues Verz.';

 {TLMDTipDlg}
 IDS_TIPERROR='Keine Tips verfügbar - der Dialog wird nicht angezeigt...';
 IDS_SHOWATSTART='Tips bei jedem Programmstart zeigen';
 IDS_TIPNEXT='&Nächster Tip';
 IDS_TIPPREV='&Vorheriger Tip';

 {TLMDWindowList}
 IDS_WLCAPTION='Fensterliste...';
 IDS_WLDESC='Verfügbare &Fenster:';


 {TLMDMessageBoxDlg}
 IDS_DONTSHOWAGAIN='Nicht wieder anzeigen';

 {TLMDInputDlg, 5.0}
 IDS_INPUTCAPTION='Eingabe...';

 {TLMDTextEditorDlg, 5.0}
 IDS_TEXTEDITORCAPTION='Text Editor';

implementation

end.
