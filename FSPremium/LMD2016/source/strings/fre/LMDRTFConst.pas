unit LMDRTFConst;
{###############################################################################

LMDRTFConst unit
----------------
Translation by David Le Franc

Changes
-------
Release 4.0 (October 2006)
 - Initial Release

###############################################################################}

interface

resourcestring

 // General
 IDRTF_OK='OK';
 IDRTF_CANCEL='Annuler';
 IDRTF_CLOSE='Fermer';
 IDRTF_HELP='&Aide';

 // used for unnamed items in "Save as" dialog
 IDRTF_DOCUMENT='document';
 

 IDRTF_AVAILABLEFORMATS='Formats disponibles:';
 IDRTF_DATETIME='Date et heure';

 IDRTF_NEW='Nouveau';
 IDRTF_NONE='(aucun)';
 IDRTF_DELETE='Supprimer';
 IDRTF_DELETEALL='Supprimer tout';
 IDRTF_SELECT='Sélectionner';

 // Bookmark Dialog
 IDRTF_BOOKMARKS='Signets';

 // RichText Editor
 IDRTF_ALIGN='Alignement';
 IDRTF_NUMBERING='Numérotation';
 IDRTF_UNDERLINE='Souligné';

 // Paragraph
 IDRTF_PARAGRAPH = 'Paragraphe';
 IDRTF_JUSTIFY = 'Justifier:';
 IDRTF_JUSTIFIES = 'Gauche,Centré,Droite';
 IDRTF_JUSTIFYLEFT = 'Aligné à gauche';
 IDRTF_JUSTIFYCENTER = 'Centré';
 IDRTF_JUSTIFYRIGHT = 'Aligné à droite';

 IDRTF_MARGINS = 'Retrait';
 IDRTF_LEFT = 'Gauche';
 IDRTF_RIGHT = 'Droite';
 IDRTF_FIRSTLINE = 'Première ligne:';
 IDRTF_INDENTAT = 'De:';
 IDRTF_INDENTS = '(Aucun),Positif,Négatif';

 IDRTF_INTERVALS = 'Espacement';
 IDRTF_BEFORE = 'Avant:';
 IDRTF_AFTER = 'Après:';
 IDRTF_LINESPACING = 'Interligne:';
 IDRTF_SPACINGS = 'Simple,1.5 ligne,Double,Au moins,Exactement,Multiple';
 IDRTF_VALUE = 'Valeur:';

 IDRTF_TABSTOPS = '&Tabulations';

 IDRTF_SET = 'Définir';

 // Link Dialog
 IDRTF_URL = 'URL';
 IDRTF_Link = 'Lien';

 // Actions Category
 IDRTF_AC_FILE = 'Fichier';
 IDRTF_AC_EDIT = 'Edition';
 IDRTF_AC_FORMAT = 'Format';
 
 // Actions
 IDRTF_ANEW = 'Nouveau';
 IDRTF_AOPEN = 'Ouvrir...';
 IDRTF_ASAVE = 'Enregistrer';
 IDRTF_ASAVEAS = 'Enregistrer sous...';
 IDRTF_APARAGRAPH = 'Paragraphe...';
 IDRTF_AFONT = 'Police...';
 IDRTF_ABOLD = 'Gras';
 IDRTF_AITALIC = 'Italique';
 IDRTF_AUNDERLINE = 'Souligné';
 IDRTF_ASUBSCRIPT = 'Indice';
 IDRTF_ASUPERSCRIPT = 'Exposant';
 IDRTF_AUNDO = 'Annuler';
 IDRTF_AREDO = 'Rétablir';
 IDRTF_APRINT = 'Imprimer';
 IDRTF_APREVIEW = 'Aperçu avant impression...';
 IDRTF_APAGESETTINGS = 'Mise en page...';
 IDRTF_AINSERTOBJ = 'Objet...';
 IDRTF_AOBJPROPS = 'Propriétés de l'#39'objet';
 IDRTF_ACOPY = 'Copier';
 IDRTF_ACUT = 'Couper';
 IDRTF_APASTE = 'Coller';
 IDRTF_APASTESPECIAL = 'Collage spécial...';
 IDRTF_ASELECTALL = 'Sélectionner tout';
 IDRTF_ADELETE = 'Supprimer';
 IDRTF_AALIGN = 'Aligner';
 IDRTF_AINCREASEINDENT = 'Augmenter le retrait';
 IDRTF_ADECREASEINDENT = 'Diminuer le retrait';
 IDRTF_ANUMBERING = 'Numérotation';
 IDRTF_ANUMBERINGBULLET = 'Puces';
 IDRTF_ANUMBERINGARABICNUMBERS = 'Nombres arabes';
 IDRTF_AFIND = 'Rechercher...';
 IDRTF_AREPLACE = 'Remplacer...';
 IDRTF_AINSERTCHAR = 'Caractères spéciaux...';
 IDRTF_AINSERTDATETIME = 'Date et heure...';
 IDRTF_ASTATISTICS = 'Statistiques...';

 // Charmap dialog
 IDRTF_FONT = 'Police';
 IDRTF_CHARSET = 'CharSet';
 IDRTF_CHARMAP = 'Table des caractères';
 
 // Find&Replace Dialog
 IDRTF_FR_NOTFOUND = 'Chaine non trouvée!';
 IDRTF_FR_REPLACED = '%d remplacement(s) effectué(s).';

 // TLMDRTFStatisticsDlg
 IDRTF_SD_CAPTION = 'Statistiques';
 IDRTF_SD_STATISTICS = 'Statistiques :';
 IDRTF_SD_PAGES = 'Pages';
 IDRTF_SD_WORDS = 'Mots';
 IDRTF_SD_CHARACTERSWOS = 'Caractères (sans espaces)';
 IDRTF_SD_CHARACTERSWS = 'Caractères (avec espaces)';
 IDRTF_SD_PARAGRAPHS = 'Paragraphes';
 IDRTF_SD_LINES = 'Lignes';

 // Ranges dialogs
 {IDRTF_COMMON = 'Commun';
 IDRTF_STARTPOSITION = 'Position de début:';
 IDRTF_ENDPOSITION = 'Position de fin:';
 IDRTF_ADDRESS = 'Adresse:';
 IDRTF_DATASET = 'DataSet';
 IDRTF_CONNECTIONSTRING = 'Chaine de connexion:';
 IDRTF_QUERY = 'Query:';
 IDRTF_VIEW = 'View';
 IDRTF_FIELDNAME = 'Voir noms de champs';
 IDRTF_TABLEVIEW = 'Table view';
 IDRTF_FILENAME = 'Nom de fichier:';
 IDRTF_IMAGE = 'Image';}

implementation

end.
