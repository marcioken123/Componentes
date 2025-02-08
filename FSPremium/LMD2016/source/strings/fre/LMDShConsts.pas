unit LMDShConsts; 
{###############################################################################

LMDShConsts unit (DS)
------------------------
Contains ShellPack constants


Changes
-------
Release 4.0 (September 2006)
 - Initial Release

###############################################################################}

interface

resourcestring
  // error messages
  IDSHELL_ErrShVersion          = 'Op�ration non support�e dans cette version du shell';
  IDSHELL_ErrInvalidFolder      = 'Dossier non valide';
  
  
  IDSHELL_ABOUT                 = 'A propos de...';
  IDSHELL_OK                    = 'OK';
  IDSHELL_CANCEL                = 'Annuler';
  
  IDSHELL_ColumnName            = 'Nom';
  IDSHELL_ColumnSize            = 'Taille';
  IDSHELL_ColumnType            = 'Type';
  IDSHELL_ColumnAttr            = 'Attributs';
  IDSHELL_ColumnCreateDate      = 'Date de cr�ation';
  IDSHELL_ColumnCreateTime      = 'Heure de c�ration';
  IDSHELL_ColumnAccessDate      = 'Date d''acc�s';
  IDSHELL_ColumnAccessTime      = 'Heure d''acc�s';
  IDSHELL_ColumnWriteDate       = 'Date de modification';
  IDSHELL_ColumnWriteTime       = 'Heure de modification';
  IDSHELL_ColumnModified        = 'Modifi�';

  sBrowseForFolder              = 'S�lectionner un dossier';
  sBrowseInstruction            = 'Choisissez un dossier';
  sDeleteFolderHint             = 'Supprime le dossier s�lectionn�.';
  sCreateFolderHint             = 'Cr�e un nouveau dossier.';
  sEmpty                        = '(Vide)';
  sNewFolderName                = 'Nouveau dossier';
  sDuplicatedPath               = 'Le chemin existe d�j�!';
  sPickRootPath                 = 'Choisissez un dossier racine';
  sEditRoot                     = 'Mo&difier dossier racine';
  sPathCaption                  = 'Chemins';
    
  // LMDSHListDlg
  IDSHELL_SELECTDETAILS         = 'Choisir les d�tails';
  IDSHELL_DEFAULTCOLUMNS        = 'Colonnes par d�faut';
  IDSHELL_BUTTONUP              = 'Monter';
  IDSHELL_BUTTONDOWN            = 'Descendre';
  IDSHELL_WIDTHCAPTION          = 'Taille de la colonne s�lectionn�e (en pixels):';
  IDSHELL_COLINSTRUCTION        = 'S�lectionnez les d�tails que vous voulez afficher pour les fichiers';
  IDSHELL_HIDE                  = 'Masquer';
  IDSHELL_DISPLAY               = 'Afficher';

  // Filter Dialog                 
  IDSHELL_SpecifyFilter         = 'D�finir le filtre...';
  IDSHELL_FilterInstruction     = 'Les �lements du filtre sont s�par�s par des points-virgules.';
  IDSHELL_FilterOptions         = 'D�sactiver le filtre'#13'Fichiers seulement'#13'Fichiers et dossiers';
  IDSHELL_Filters               = 'Filtres';
  IDSHELL_ApplyFilter           = 'Appliquer le filtre �...';

  IDSHELL_COPYTO                = 'Copier dans...';
  IDSHELL_COPYTOINST            = 'S�lectionnez le dossier o� vous voulez copier les �lements.';
  IDSHELL_MOVETO                = 'D�placer...';
  IDSHELL_MOVETOINST            = 'S�lectionnez le dossier o� vous voulez d�placer les �lements.';
  IDSHELL_SHOWPROPERTIES        = 'Propri�t�s';
  IDSHELL_RENAME                = 'Renommer';
  IDSHELL_OPENWITH              = 'Ouvrir avec...';
  IDSHELL_OPEN                  = 'Ouvrir';
  IDSHELL_CREATEFOLDER          = 'Cr�er dossier';
  IDSHELL_RUN                   = 'Ex�cuter';
  IDSHELL_MAILTO                = 'Envoyer par mail...';
  IDSHELL_BACKWARD              = 'Retourner';
  IDSHELL_FORWARD               = 'Avancer';
  IDSHELL_UPLEVEL               = 'Dossier parent';
  IDSHELL_CUT                   = 'Couper';
  IDSHELL_COPY                  = 'Copier';
  IDSHELL_PASTE                 = 'Coller';
  IDSHELL_DELETE                = 'Supprimer';
  IDSHELL_SELECTALL             = 'S�lectionner tout';
  IDSHELL_INVERTSELECTION       = 'Inverser la s�lection';
  IDSHELL_OPENDOSWINDOW         = 'Ouvrir une fen�tre Dos';
  IDSHELL_FINDFILES             = 'Rechercher des fichiers...';
  IDSHELL_FINDCOMPUTER          = 'Rechercher un ordinateur...';
  IDSHELL_FORMATDISK            = 'Formatter le disque...';
  IDSHELL_SELECTDISKFORMAT      = 'Choisissez le disque � formatter';
  IDSHELL_COPYDISK              = 'Copier le disque...';
  IDSHELL_MAPDRIVE              = 'Connecter un lecteur r�seau...';
  IDSHELL_UNMAPDRIVE            = 'D�connecter un lecteur r�seau...';
  IDSHELL_EDITDISKLABEL         = 'Nom du disque...';
  IDSHELL_SELECTDISKLABEL       = 'S�lectionner le disque � renommer';
  IDSHELL_FILTER                = 'Filtrer...';
  IDSHELL_COPYFILENAMEASTEXT    = 'Copier le nom du fichier comme texte';
  IDSHELL_COPYPATHNAMEASTEXT    = 'Copier le chemin comme texte';
  IDSHELL_VIEW                  = 'Affichage';

implementation


end.
