unit LMDElDBConst;
{###############################################################################

LMDElDBConst unit
-----------------
Translation by David Le Franc

Changes
-------
Release 6.0 (February 2007)
 - Initial Release

###############################################################################}

interface

uses
  SysUtils;

{$R LMDElPackDB.res}

type
  TElUpdateStylesType = (stPattern, stFontAndStyles, stHint, stCheckBox, stImages, stCaption, stShowCaption);
  TElTableName = type string;

  EOnUndefinedGridColumnsDataSet = class (Exception)
  end;

  ENoValidDataSetName = class (Exception)
  end;

  EIncorrectFieldName = class (Exception)
  end;
  EIncorrectColumnIndex = class (Exception)
  end;

  EErrorInPattern = class (Exception)
  end;

  EOnGoToBookmark = class (Exception)
  end;

  EOnMoveError = class (Exception)
  end;

  EOnErrorInRelation = class (Exception)
  end;

  TElDBUnicodeMode = (umFieldType, umForceUTF8, umForceUnicode);

resourcestring
  SErrorInMTree = 'Erreur dans MTree : �l�ment non trouv�';
  SDeleteFromDenyDataSet = 'Impossible de supprimer du DataSet avec l''option DenyLookSetPosition.';
  SMasterDetailIncompatible = 'Attention! MasterField et DetailField ont des types diff�rents. A la cr�ation de l'#39'arborescence, un transtypage sera tent�.';
  SOnErrorInRelation = 'Impossible de consruire la relation %d. V�rifier type et taille des champs MasterField et DetailField.';
  SNoSetInstall = 'DataSource non d�fini. Modification impossible.';
  SNoDSetInstall = 'DataSet non d�fini dans le DataSource. Edition impossible.';
  SOnMoveError = 'D�placement impossible';
  SOnGoToBookmark = 'Aucun enregistrement trouv� dans %s. Si vous utilisez une requ�te param�tr�e, d�finir DenyLookSetPosition=True pour la relation correspondante.';
  SErrorInPattern = 'Erreur dans le mod�le! V�rifier le nom des champs et la syntaxe.';
  SErrorPrebuildLevel = 'La valeur minimum possible pour ce param�tre est 2';
  SNoColumnSetAssigned = 'DataSet non d�fini pour les colonnes TreeGrid.';
  SNoValidDataSetName = 'Le nom %s pour le DataSet des colonnes TreeGrid n'#39'est pas valide. V�rifier que ce DataSet participe � la cr�ation de l'#39'arbre.';
  SIncorrectColumnIndex = 'Index de colonne incorrect';
  SIncorrectFieldName = 'Le nom %s est incorrect';

  SLMDNbrFirst = 'Premier enregistrement';
  SLMDNbrPrior = 'Enregistrement pr�c�dent';
  SLMDNbrNext = 'Enregistrement suivant';
  SLMDNbrLast = 'Dernier enregistrement';
  SLMDNbrInsert = 'Ins�rer enregistrement';
  SLMDNbrDelete = 'Supprimer enregistrement';
  SLMDNbrEdit = 'Modifier enregistrement';
  SLMDNbrPost = 'Valider enregistrement';
  SLMDNbrCancel = 'Annuler les changements';
  SLMDNbrRefresh = 'Rafraich�r';
  SLMDNbrSearch = 'Rechercher';
  SLMDNbrSetFilter = 'Activer filtre';
  SLMDNbrRemoveFilter = 'Enlever filtre';
  SLMDNbrClear = 'Effacer';
  SLMDNbrOpen = 'Ouvrir';
  SLMDNbrClose = 'Fermer';
  SLMDNbrFindFirst = 'Trouver premier';
  SLMDNbrFindPrior = 'Trouver pr�c�dent';
  SLMDNbrFindNext = 'Trouver suivant';
  SLMDNbrFindLast = 'Trouver dernier';

  SLMDTnbrFirstRoot = 'Premier �l�ment � la racine';
  SLMDTnbrFirst = 'Premier �l�ment';
  SLMDTnbrPrior = 'El�ment pr�c�dent';
  SLMDTnbrNext = 'El�ment suivant';
  SLMDTnbrLast = 'Dernier �l�ment';
  SLMDTnbrLastRoot = 'Dernier �l�ment � la racine';
  SLMDTnbrInsert = 'Ins�rer �l�ment';
  SLMDTnbrInsertSubItem = 'Ins�rer sous-�l�ment';
  SLMDTnbrDelete = 'Supprimer �l�ment';
  SLMDTnbrEdit = 'Modifier �l�ment';
  SLMDTnbrRefresh = 'Rafraich�r';


implementation

end.
