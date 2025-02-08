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
  SErrorInMTree = 'Erreur dans MTree : élément non trouvé';
  SDeleteFromDenyDataSet = 'Impossible de supprimer du DataSet avec l''option DenyLookSetPosition.';
  SMasterDetailIncompatible = 'Attention! MasterField et DetailField ont des types différents. A la création de l'#39'arborescence, un transtypage sera tenté.';
  SOnErrorInRelation = 'Impossible de consruire la relation %d. Vérifier type et taille des champs MasterField et DetailField.';
  SNoSetInstall = 'DataSource non défini. Modification impossible.';
  SNoDSetInstall = 'DataSet non défini dans le DataSource. Edition impossible.';
  SOnMoveError = 'Déplacement impossible';
  SOnGoToBookmark = 'Aucun enregistrement trouvé dans %s. Si vous utilisez une requête paramétrée, définir DenyLookSetPosition=True pour la relation correspondante.';
  SErrorInPattern = 'Erreur dans le modèle! Vérifier le nom des champs et la syntaxe.';
  SErrorPrebuildLevel = 'La valeur minimum possible pour ce paramètre est 2';
  SNoColumnSetAssigned = 'DataSet non défini pour les colonnes TreeGrid.';
  SNoValidDataSetName = 'Le nom %s pour le DataSet des colonnes TreeGrid n'#39'est pas valide. Vérifier que ce DataSet participe à la création de l'#39'arbre.';
  SIncorrectColumnIndex = 'Index de colonne incorrect';
  SIncorrectFieldName = 'Le nom %s est incorrect';

  SLMDNbrFirst = 'Premier enregistrement';
  SLMDNbrPrior = 'Enregistrement précédent';
  SLMDNbrNext = 'Enregistrement suivant';
  SLMDNbrLast = 'Dernier enregistrement';
  SLMDNbrInsert = 'Insérer enregistrement';
  SLMDNbrDelete = 'Supprimer enregistrement';
  SLMDNbrEdit = 'Modifier enregistrement';
  SLMDNbrPost = 'Valider enregistrement';
  SLMDNbrCancel = 'Annuler les changements';
  SLMDNbrRefresh = 'Rafraichîr';
  SLMDNbrSearch = 'Rechercher';
  SLMDNbrSetFilter = 'Activer filtre';
  SLMDNbrRemoveFilter = 'Enlever filtre';
  SLMDNbrClear = 'Effacer';
  SLMDNbrOpen = 'Ouvrir';
  SLMDNbrClose = 'Fermer';
  SLMDNbrFindFirst = 'Trouver premier';
  SLMDNbrFindPrior = 'Trouver précédent';
  SLMDNbrFindNext = 'Trouver suivant';
  SLMDNbrFindLast = 'Trouver dernier';

  SLMDTnbrFirstRoot = 'Premier élément à la racine';
  SLMDTnbrFirst = 'Premier élément';
  SLMDTnbrPrior = 'Elément précédent';
  SLMDTnbrNext = 'Elément suivant';
  SLMDTnbrLast = 'Dernier élément';
  SLMDTnbrLastRoot = 'Dernier élément à la racine';
  SLMDTnbrInsert = 'Insérer élément';
  SLMDTnbrInsertSubItem = 'Insérer sous-élément';
  SLMDTnbrDelete = 'Supprimer élément';
  SLMDTnbrEdit = 'Modifier élément';
  SLMDTnbrRefresh = 'Rafraichîr';


implementation

end.
