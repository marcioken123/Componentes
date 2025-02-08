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
  IDSHELL_ErrShVersion          = 'Opération non supportée dans cette version du shell';
  IDSHELL_ErrInvalidFolder      = 'Dossier non valide';
  
  
  IDSHELL_ABOUT                 = 'A propos de...';
  IDSHELL_OK                    = 'OK';
  IDSHELL_CANCEL                = 'Annuler';
  
  IDSHELL_ColumnName            = 'Nom';
  IDSHELL_ColumnSize            = 'Taille';
  IDSHELL_ColumnType            = 'Type';
  IDSHELL_ColumnAttr            = 'Attributs';
  IDSHELL_ColumnCreateDate      = 'Date de création';
  IDSHELL_ColumnCreateTime      = 'Heure de cération';
  IDSHELL_ColumnAccessDate      = 'Date d''accès';
  IDSHELL_ColumnAccessTime      = 'Heure d''accès';
  IDSHELL_ColumnWriteDate       = 'Date de modification';
  IDSHELL_ColumnWriteTime       = 'Heure de modification';
  IDSHELL_ColumnModified        = 'Modifié';

  sBrowseForFolder              = 'Sélectionner un dossier';
  sBrowseInstruction            = 'Choisissez un dossier';
  sDeleteFolderHint             = 'Supprime le dossier sélectionné.';
  sCreateFolderHint             = 'Crée un nouveau dossier.';
  sEmpty                        = '(Vide)';
  sNewFolderName                = 'Nouveau dossier';
  sDuplicatedPath               = 'Le chemin existe déjà!';
  sPickRootPath                 = 'Choisissez un dossier racine';
  sEditRoot                     = 'Mo&difier dossier racine';
  sPathCaption                  = 'Chemins';
    
  // LMDSHListDlg
  IDSHELL_SELECTDETAILS         = 'Choisir les détails';
  IDSHELL_DEFAULTCOLUMNS        = 'Colonnes par défaut';
  IDSHELL_BUTTONUP              = 'Monter';
  IDSHELL_BUTTONDOWN            = 'Descendre';
  IDSHELL_WIDTHCAPTION          = 'Taille de la colonne sélectionnée (en pixels):';
  IDSHELL_COLINSTRUCTION        = 'Sélectionnez les détails que vous voulez afficher pour les fichiers';
  IDSHELL_HIDE                  = 'Masquer';
  IDSHELL_DISPLAY               = 'Afficher';

  // Filter Dialog                 
  IDSHELL_SpecifyFilter         = 'Définir le filtre...';
  IDSHELL_FilterInstruction     = 'Les élements du filtre sont séparés par des points-virgules.';
  IDSHELL_FilterOptions         = 'Désactiver le filtre'#13'Fichiers seulement'#13'Fichiers et dossiers';
  IDSHELL_Filters               = 'Filtres';
  IDSHELL_ApplyFilter           = 'Appliquer le filtre à...';

  IDSHELL_COPYTO                = 'Copier dans...';
  IDSHELL_COPYTOINST            = 'Sélectionnez le dossier où vous voulez copier les élements.';
  IDSHELL_MOVETO                = 'Déplacer...';
  IDSHELL_MOVETOINST            = 'Sélectionnez le dossier où vous voulez déplacer les élements.';
  IDSHELL_SHOWPROPERTIES        = 'Propriétés';
  IDSHELL_RENAME                = 'Renommer';
  IDSHELL_OPENWITH              = 'Ouvrir avec...';
  IDSHELL_OPEN                  = 'Ouvrir';
  IDSHELL_CREATEFOLDER          = 'Créer dossier';
  IDSHELL_RUN                   = 'Exécuter';
  IDSHELL_MAILTO                = 'Envoyer par mail...';
  IDSHELL_BACKWARD              = 'Retourner';
  IDSHELL_FORWARD               = 'Avancer';
  IDSHELL_UPLEVEL               = 'Dossier parent';
  IDSHELL_CUT                   = 'Couper';
  IDSHELL_COPY                  = 'Copier';
  IDSHELL_PASTE                 = 'Coller';
  IDSHELL_DELETE                = 'Supprimer';
  IDSHELL_SELECTALL             = 'Sélectionner tout';
  IDSHELL_INVERTSELECTION       = 'Inverser la sélection';
  IDSHELL_OPENDOSWINDOW         = 'Ouvrir une fenêtre Dos';
  IDSHELL_FINDFILES             = 'Rechercher des fichiers...';
  IDSHELL_FINDCOMPUTER          = 'Rechercher un ordinateur...';
  IDSHELL_FORMATDISK            = 'Formatter le disque...';
  IDSHELL_SELECTDISKFORMAT      = 'Choisissez le disque à formatter';
  IDSHELL_COPYDISK              = 'Copier le disque...';
  IDSHELL_MAPDRIVE              = 'Connecter un lecteur réseau...';
  IDSHELL_UNMAPDRIVE            = 'Déconnecter un lecteur réseau...';
  IDSHELL_EDITDISKLABEL         = 'Nom du disque...';
  IDSHELL_SELECTDISKLABEL       = 'Sélectionner le disque à renommer';
  IDSHELL_FILTER                = 'Filtrer...';
  IDSHELL_COPYFILENAMEASTEXT    = 'Copier le nom du fichier comme texte';
  IDSHELL_COPYPATHNAMEASTEXT    = 'Copier le chemin comme texte';
  IDSHELL_VIEW                  = 'Affichage';

implementation


end.
