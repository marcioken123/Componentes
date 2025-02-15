//-----------------------------------------------------------------------------
//   Overview:    This unit contains the resource strings used by the TJSDialog component suite
//   Description: Contains all of the strings used by the TJSDialog components. Translate the contents
//   of this unit to the desired language.
//-----------------------------------------------------------------------------

interface

{$I lmddlgcmps.inc}

uses
  Classes, JSTypes;

resourcestring
  {$IFDEF LANG_ENGLISH}
  StrAssignSourceMustB = 'Assigned source must be a TJSDialog';
  { Resource string for error raised when an unhandled Help Link
    click is processed and the application doesn't have an
    associated help file.                                        }
  StrYouMustAssociateA = 'You must associate a Help File with your application';

  // Button caption resource strings

  { Resourcestrings for buttons }
  sBtnYes = '&Yes';
  sBtnNo = '&No';
  sBtnOK = 'OK';
  sBtnCancel = 'Cancel';
  sBtnHelp = '&Help';
  sBtnAbort = '&Abort';
  sBtnRetry = '&Retry';
  sBtnIgnore = '&Ignore';
  sBtnAll = '&All';
  sBtnNoToAll = 'N&o to All';
  sBtnYesToAll = 'Yes to &All';
  sBtnClose = '&Close';

  { Dialog Title used in the VerifyMessage global function from the JSDialogs unit. }
  StrConfirmation = 'Confirmation';
  StrWarning = 'Warning';
  StrError = 'Error';
  StrInformation = 'Information';

  { Summary
    Default dialog title for the TJSPasswordDialog class. }
  StrPasswordDialogTitle = 'Enter Password';
  { Summary
    Default dialog title for the TJSChangePasswordDialog class. }
  StrChangePasswordDialogTitle = 'Change Password';
  { Summary
    Default dialog title for the TJSConfirmPasswordDialog class. }
  StrConfirmPasswordDialogTitle = 'Change Password';
  { Summary
    Default instruction section text for the TJSPasswordDialog class. }
  StrPasswordDialogInstruction = 'Enter your password';
  { Summary
    Default instruction section text for the TJSChangePasswordDialog class. }
  StrChangePasswordDialogInstruction = 'Change your password';
  { Summary
    Default instruction section text for the TJSConfirmPasswordDialog class. }
  StrConfirmPasswordDialogInstruction = 'Change your password';
  { Summary
    Default content section text for the TJSConfirmPasswordDialog class. }
  StrConfirmPasswordDialogContent = 'Enter and confirm your new password.';
  { Summary
    Default content section text for the TJSChangePasswordDialog class. }
  StrChangePasswordDialogContent = 'Enter and confirm your new password.';
  { Summary
    Default password dialog when entered passwords do not match. }
  StrPasswordsMustBeTheSame = 'Entered passwords must be the same.';
  { Summary
    Default password dialog when entered passwords do not match. }
  StrAllowPlainTextPasswordsCaption = 'Show passwords as plain text';
  { Summary
    Exception string when creating a password frame control with a non TJSCustomPasswordDialog descendant. }
  StrJSPasswordDialogInvalidDialogType = 'Invalid dialog type (%s) using %s.';

  StrEnterPasswordCaption = '&Enter Password';
  StrOldPasswordCaption = '&Old Password';
  StrNewPasswordCaption = '&New Password';
  StrConfirmPasswordCaption = '&Confirm New Password';
  {$ENDIF LANG_ENGLISH}

  {$IFDEF LANG_GERMAN}
  StrAssignSourceMustB = 'Zugewiesene Quelle muss ein TJSDialog sein';
  StrYouMustAssociateA = 'Sie m�ssen eine Hilfedatei mit Ihrer Anwendung verkn�pfen';

  sBtnYes = '&Ja';
  sBtnNo = '&Nein';
  sBtnOK = 'OK';
  sBtnCancel = 'Abbrechen';
  sBtnHelp = '&Hilfe';
  sBtnAbort = '&Abbrechen';
  sBtnRetry = '&Wiederholen';
  sBtnIgnore = '&Ignorieren';
  sBtnAll = '&Alle';
  sBtnNoToAll = '&Alle Nein';
  sBtnYesToAll = 'A&lle Ja';
  sBtnClose = '&Schlie�en';

  StrConfirmation = 'Best�tigung';
  StrWarning = 'Warnung';
  StrError = 'Fehler';
  StrInformation = 'Information';

  StrPasswordDialogTitle = 'Passwort eingeben';
  StrChangePasswordDialogTitle = 'Passwort �ndern';
  StrConfirmPasswordDialogTitle = 'Passwort �ndern';
  StrPasswordDialogInstruction = 'Geben Sie Ihr Passwort ein';
  StrChangePasswordDialogInstruction = '�ndern Sie Ihr Passwort';
  StrConfirmPasswordDialogInstruction = '�ndern Sie Ihr Passwort';
  StrConfirmPasswordDialogContent = 'Bitte geben Sie Ihr neues Passwort ein und best�tigen Sie dieses.';
  StrChangePasswordDialogContent = 'Bitte geben Sie Ihr neues Passwort ein und best�tigen Sie dieses.';
  StrPasswordsMustBeTheSame = 'Die eingegebenen Passw�rter m�ssen identisch sein.';
  StrAllowPlainTextPasswordsCaption = 'Passw�rter als Klartext anzeigen';
  StrJSPasswordDialogInvalidDialogType = 'Ung�ltiger Dialog Typ (%s) nutzt %s.';

  StrEnterPasswordCaption = '&Passwort eingeben';
  StrOldPasswordCaption = '&Altes Passwort';
  StrNewPasswordCaption = '&Neues Passwort';
  StrConfirmPasswordCaption = 'Passwort &best�tigen';
  {$ENDIF LANG_GERMAN}

  {$IFDEF LANG_CZECH}
  StrAssignSourceMustB = 'Pripojen� zdroj mus� b�t TJSDialog';
  StrYouMustAssociateA = 'K aplikaci mus�te pripojit soubor s n�povedou';

  sBtnYes = '&Ano';
  sBtnNo = '&Ne';
  sBtnOK = 'OK';
  sBtnCancel = 'Storno';
  sBtnHelp = 'N�poveda';
  sBtnAbort = '&Preru�it';
  sBtnRetry = '&Opakovat';
  sBtnIgnore = 'Pre&skocit';
  sBtnAll = '&V�e';
  sBtnNoToAll = 'Ne v�em';
  sBtnYesToAll = 'Ano v�em';
  sBtnClose = 'Zavr�t';

  StrConfirmation = 'Potvrzen�';
  StrWarning = 'Upozornen�';
  StrError = 'Chyba';
  StrInformation = 'Informace';

  StrPasswordDialogTitle = 'Zadat heslo';
  StrChangePasswordDialogTitle = 'Zmenit heslo';
  StrConfirmPasswordDialogTitle = 'Zmenit heslo';
  StrPasswordDialogInstruction = 'Zadejte heslo';
  StrChangePasswordDialogInstruction = 'Zmente heslo';
  StrConfirmPasswordDialogInstruction = 'Zmente heslo';
  StrConfirmPasswordDialogContent = 'Zadejte a potvrdte nov� heslo.';
  StrChangePasswordDialogContent = 'Zadejte a potvrdte nov� heslo.';
  StrPasswordsMustBeTheSame = 'Zadan� hesla mus� b�t stejn�.';
  StrAllowPlainTextPasswordsCaption = 'Zobrazit hesla jako prost� text';
  StrJSPasswordDialogInvalidDialogType = 'Neplatn� typ dialogu (%s) pri pou�it� %s.';

  StrEnterPasswordCaption = '&Zadat heslo';
  StrOldPasswordCaption = '&Star� heslo';
  StrNewPasswordCaption = '&Nov� heslo';
  StrConfirmPasswordCaption = '&Potvrdit nov� heslo';
  {$ENDIF LANG_CZECH}

  {$IFDEF LANG_SLOVENE}
  StrAssignSourceMustB = 'Assigned source must be a TJSDialog';
  StrYouMustAssociateA = 'You must associate a Help File with your application';

  sBtnYes = '&Da';
  sBtnNo = '&Ne';
  sBtnOK = 'V redu';
  sBtnCancel = 'Preklic';
  sBtnHelp = '&Pomo�';
  sBtnAbort = 'Pre&kini';
  sBtnRetry = 'Zno&va';
  sBtnIgnore = 'Pre&zri';
  sBtnAll = '&Vse';
  sBtnNoToAll = '&Ne za vse';
  sBtnYesToAll = '&Da za vse';
  sBtnClose = '&Zapri';

  StrConfirmation = 'Potrditev';
  StrWarning = 'Opozorilo';
  StrError = 'Napaka';
  StrInformation = 'Informacija';

  StrPasswordDialogTitle = 'Enter Password';
  StrChangePasswordDialogTitle = 'Change Password';
  StrConfirmPasswordDialogTitle = 'Change Password';
  StrPasswordDialogInstruction = 'Enter your password';
  StrChangePasswordDialogInstruction = 'Change your password';
  StrConfirmPasswordDialogInstruction = 'Change your password';
  StrConfirmPasswordDialogContent = 'Enter and confirm your new password.';
  StrChangePasswordDialogContent = 'Enter and confirm your new password.';
  StrPasswordsMustBeTheSame = 'Entered passwords must be the same.';
  StrAllowPlainTextPasswordsCaption = 'Show passwords as plain text';
  StrJSPasswordDialogInvalidDialogType = 'Invalid dialog type (%s) using %s.';

  StrEnterPasswordCaption = '&Enter Password';
  StrOldPasswordCaption = '&Old Password';
  StrNewPasswordCaption = '&New Password';
  StrConfirmPasswordCaption = '&Confirm New Password';
  {$ENDIF LANG_SLOVENE}

  {$IFDEF LANG_FRENCH}
  StrAssignSourceMustB = 'La source assign�e doit �tre un TJSDialog';
  StrYouMustAssociateA = 'Vous devez associer un Fichier d''Aide � votre application';

  sBtnYes = '&Oui';
  sBtnNo = '&Non';
  sBtnOK = 'OK';
  sBtnCancel = 'Annuler';
  sBtnHelp = 'A&ide';
  sBtnAbort = 'A&bandonner';
  sBtnRetry = '&R�essayer';
  sBtnIgnore = '&Ignorer';
  sBtnAll = '&Tous';
  sBtnNoToAll = 'Non po&ur tout';
  sBtnYesToAll = 'O&ui pour tout';
  sBtnClose = '&Fermer';

  StrConfirmation = 'Confirmation';
  StrWarning = 'Avertissement';
  StrError = 'Erreur';
  StrInformation = 'Information';

  StrPasswordDialogTitle = 'Entrez le mot de passe';
  StrChangePasswordDialogTitle = 'Modifier le mot de passe';
  StrConfirmPasswordDialogTitle = 'Modifier le mot de passe';
  StrPasswordDialogInstruction = 'Entrez le mot de passe';
  StrChangePasswordDialogInstruction = 'Modifier votre mot de passe';
  StrConfirmPasswordDialogInstruction = 'Modifier votre mot de passe';
  StrConfirmPasswordDialogContent = 'Entrez et confirmez votre nouveau mot de passe.';
  StrChangePasswordDialogContent = 'Entrez et confirmez votre nouveau mot de passe.';
  StrPasswordsMustBeTheSame = 'Les mots de passe entr�s doivent �tre identiques.';
  StrAllowPlainTextPasswordsCaption = 'Afficher les mots de passe sous forme de texte brut';
  StrJSPasswordDialogInvalidDialogType = 'Type de dialogue (%s) incorrect lors de l''utilisation de %s.';

  StrEnterPasswordCaption = '&Entrez le mot de passe';
  StrOldPasswordCaption = 'Ancien m&ot de passe';
  StrNewPasswordCaption = '&Nouveau mot de passe';
  StrConfirmPasswordCaption = '&Confirmer le nouveau mot de passe';
  {$ENDIF LANG_FRENCH}

  {$IFDEF LANG_DANISH}
  StrAssignSourceMustB = 'Assigned source skal v�re af type TJSDialog';
  StrYouMustAssociateA = 'Du skal associere en hj�lpefil med din applikation';

  sBtnYes = '&Ja';
  sBtnNo = '&Nej';
  sBtnOK = 'OK';
  sBtnCancel = 'Afbryd';
  sBtnHelp = '&Hj�lp';
  sBtnAbort = '&Abort';
  sBtnRetry = '&Pr�v igen';
  sBtnIgnore = '&Ignor�r';
  sBtnAll = '&Alle';
  sBtnNoToAll = 'N&ej til alle';
  sBtnYesToAll = 'Ja to &Alle';
  sBtnClose = '&Luk';

  StrConfirmation = 'Bekr�ft';
  StrWarning = 'Advarsel';
  StrError = 'Fejl';
  StrInformation = 'Information';

  StrPasswordDialogTitle = 'Indtast adgangskode';
  StrChangePasswordDialogTitle = 'Skift adgangskode';
  StrConfirmPasswordDialogTitle = 'Skift adgangskode';
  StrPasswordDialogInstruction = 'Indtast din adgangskode';
  StrChangePasswordDialogInstruction = 'Skift din adgangskode';
  StrConfirmPasswordDialogInstruction = 'Skift din adgangskode';
  StrConfirmPasswordDialogContent = 'Indtast og bekr�ft din nye adgangskode.';
  StrChangePasswordDialogContent = 'Indtast og bekr�ft din nye adgangskode.';
  StrPasswordsMustBeTheSame = 'De indtastede adgangskoder skal v�re ens.';
  StrAllowPlainTextPasswordsCaption = 'Vis adgangskoder som ren tekst';
  StrJSPasswordDialogInvalidDialogType = 'Ugyldig dialogtype (%s) ved brug af %s.';

  StrEnterPasswordCaption = 'Indtast &adgangskode';
  StrOldPasswordCaption = '&Gammel adgangskode';
  StrNewPasswordCaption = '&Ny adgangskode';
  StrConfirmPasswordCaption = '&Bekr�ft ny adgangskode';
  {$ENDIF LANG_DANISH}
  
  {$IFDEF LANG_DUTCH}
  StrAssignSourceMustB = 'Assigned source must be a TJSDialog';
  StrYouMustAssociateA = 'You must associate a Help File with your application';

  sBtnYes = '&Ja';
  sBtnNo = '&Nee';
  sBtnOK = 'OK';
  sBtnCancel = 'Annuleren';
  sBtnHelp = '&Help';
  sBtnAbort = '&Stop';
  sBtnRetry = '&Opnieuw';
  sBtnIgnore = '&Negeren';
  sBtnAll = '&Allemaal';
  sBtnNoToAll = 'N&ee op alles';
  sBtnYesToAll = 'Ja op &alles';
  sBtnClose = '&Sluiten';

  StrConfirmation = 'Bevestiging';
  StrWarning = 'Waarschuwing';
  StrError = 'Fout';
  StrInformation = 'Informatie';

  StrPasswordDialogTitle = 'Geef wachtwoord';
  StrChangePasswordDialogTitle = 'Wijzig wachtwoord';
  StrConfirmPasswordDialogTitle = 'Wijzig wachtwoord';
  StrPasswordDialogInstruction = 'Geef wachtwoord';
  StrChangePasswordDialogInstruction = 'Wijzig uw wachtwoord';
  StrConfirmPasswordDialogInstruction = 'Wijzig uw wachtwoord';
  StrConfirmPasswordDialogContent = 'Geef uw wachtwoord in en bevestig.';
  StrChangePasswordDialogContent = 'Geef uw nieuw wachtwoord in en bevestig.';
  StrPasswordsMustBeTheSame = 'Ingegeven wachtwoorden moeten overeenkomen.';
  StrAllowPlainTextPasswordsCaption = 'Toon wachtwoorden zonder sterretjes';
  StrJSPasswordDialogInvalidDialogType = 'Verkeerd dialoogvenster (%s) bij gebruik van %s.';

  StrEnterPasswordCaption = '&Geef wachtwoord';
  StrOldPasswordCaption = '&Oud wachtwoord';
  StrNewPasswordCaption = '&Nieuw wachtwoord';
  StrConfirmPasswordCaption = '&Bevestig wachtwoord';
  {$ENDIF LANG_DUTCH}

  {$IFDEF LANG_ITALIAN}
  StrAssignSourceMustB = 'La sorgente assegnata deve essere di tipo TJSDialog';
  StrYouMustAssociateA = 'E'' necessario associare un file di aiuto all''applicazione';

  sBtnYes = '&Si';
  sBtnNo = '&No';
  sBtnOK = 'Ok';
  sBtnCancel = '&Annulla';
  sBtnHelp = 'Aiuto';
  sBtnAbort = '&Interrompi';
  sBtnRetry = '&Riprova';
  sBtnIgnore = '&Ignora';
  sBtnAll = '&Tutto';
  sBtnNoToAll = 'No a tutto';
  sBtnYesToAll = 'Si a tutto';
  sBtnClose = '&Chiudi';

  StrConfirmation = 'Conferma';
  StrWarning = 'Avviso';
  StrError = 'Errore';
  StrInformation = 'Informazione';

  StrPasswordDialogTitle = 'Inserisci la password';
  StrChangePasswordDialogTitle = 'Modifica la password';
  StrConfirmPasswordDialogTitle = 'Modifica la password';
  StrPasswordDialogInstruction = 'Inserisci la password';
  StrChangePasswordDialogInstruction = 'Modifica la password';
  StrConfirmPasswordDialogInstruction = 'Modifica la password';
  StrConfirmPasswordDialogContent = 'Inserisci e conferma la nuova password.';
  StrChangePasswordDialogContent = 'Inserisci e conferma la nuova password.';
  StrPasswordsMustBeTheSame = 'Le password inserite devono essere uguali.';
  StrAllowPlainTextPasswordsCaption = 'Visualizza le password in chiaro';
  StrJSPasswordDialogInvalidDialogType = ' Finestra di dialogo (%s) di tipo non valido utilizzando %s.';

  StrEnterPasswordCaption = '&Inserisci la password';
  StrOldPasswordCaption = '&Password precedente';
  StrNewPasswordCaption = '&Nuova password';
  StrConfirmPasswordCaption = '&Conferma la nuova password';
  {$ENDIF LANG_ITALIAN}

  {$IFDEF LANG_BRAZILIANPORTUGUESE}
  StrAssignSourceMustB = 'Fonte atribu�da deve ser um TJSDialog';
  StrYouMustAssociateA = 'Voc� deve associar um arquivo de ajuda a sua aplica��o';

  sBtnYes = '&Sim';
  sBtnNo = '&N�o';
  sBtnOK = 'OK';
  sBtnCancel = 'Cancelar';
  sBtnHelp = '&Ajuda';
  sBtnAbort = '&Abortar';
  sBtnRetry = '&Tentar';
  sBtnIgnore = '&Ignorar';
  sBtnAll = '&Todos';
  sBtnNoToAll = 'N�&o a Todos';
  sBtnYesToAll = '&Sim a Todos';
  sBtnClose = '&Fechar';

  StrConfirmation = 'Confirma��o';
  StrWarning = 'Aviso';
  StrError = 'Erro';
  StrInformation = 'Informa��o';

  StrPasswordDialogTitle = 'Entre com Senha';
  StrChangePasswordDialogTitle = 'Alterar Senha';
  StrConfirmPasswordDialogTitle = 'Alterar Senha';
  StrPasswordDialogInstruction = 'Entre com sua senha';
  StrChangePasswordDialogInstruction = 'Altere sua senha';
  StrConfirmPasswordDialogInstruction = 'Altere sua senha';
  StrConfirmPasswordDialogContent = 'Entre e confirme sua nova senha.';
  StrChangePasswordDialogContent = 'Entre e confirme sua nova senha.';
  StrPasswordsMustBeTheSame = 'As senhas digitadas devem ser iguais.';
  StrAllowPlainTextPasswordsCaption = 'Mostrar senhas como texto';
  StrJSPasswordDialogInvalidDialogType = 'Tipo inv�lido de di�logo (%s) usando %s.';

  StrEnterPasswordCaption = '&Entre com senha';
  StrOldPasswordCaption = 'Senha &Antiga';
  StrNewPasswordCaption = '&Nova Senha';
  StrConfirmPasswordCaption = '&Confirmar Nova Senha';
  {$ENDIF LANG_BRAZILIANPORTUGUESE}

  {$IFDEF LANG_SVENSKA}
  StrAssignSourceMustB = 'Tilldelad k�lla m�ste vara TJSDialog';
  StrYouMustAssociateA = 'Du m�ste associera en Hj�lpfil med din applikation';

  sBtnYes = '&Ja';
  sBtnNo = '&Nej';
  sBtnOK = 'OK';
  sBtnCancel = 'Avbryt';
  sBtnHelp = '&Hj�lp';
  sBtnAbort = '&Avbryt';
  sBtnRetry = '&F�rs�k igen';
  sBtnIgnore = '&Ignorera';
  sBtnAll = '&Alla';
  sBtnNoToAll = 'N&ej till Alla';
  sBtnYesToAll = 'Ja till &Alla';
  sBtnClose = '&St�ng';

  StrConfirmation = 'Bekr�fta';
  StrWarning = 'Varning';
  StrError = 'Fel';
  StrInformation = 'Information';

  StrPasswordDialogTitle = 'Skriv L�senord';
  StrChangePasswordDialogTitle = 'Byt L�senord';
  StrConfirmPasswordDialogTitle = 'Byt L�senord';
  StrPasswordDialogInstruction = 'Skriv Ditt L�senord';
  StrChangePasswordDialogInstruction = '�ndra Ditt L�senord';
  StrConfirmPasswordDialogInstruction = '�ndra Ditt L�senord';
  StrConfirmPasswordDialogContent = 'Skriv och Bekr�fta ditt nya l�senord.';
  StrChangePasswordDialogContent = 'Skriv och Bekr�fta ditt nya l�senord.';
  StrPasswordsMustBeTheSame = 'B�gge l�senorden m�ste vara lika.';
  StrAllowPlainTextPasswordsCaption = 'Visa l�senord som text';
  StrJSPasswordDialogInvalidDialogType = 'Ogiltig dialog typ (%s) anv�nder %s.';

  StrEnterPasswordCaption = '&Skriv L�senord';
  StrOldPasswordCaption = '&Gammalt L�senord';
  StrNewPasswordCaption = '&Nytt L�senord';
  StrConfirmPasswordCaption = '&Bekr�fta Nytt L�senord';
  {$ENDIF LANG_SVENSKA}
  
  {$IFDEF LANG_JAPANESE}
  StrAssignSourceMustB = 'Assigned source must be a TJSDialog';
  StrYouMustAssociateA = 'You must associate a Help File with your application';

  sBtnYes = '&Yes';
  sBtnNo = '&No';
  sBtnOK = 'OK';
  sBtnCancel = 'Cancel';
  sBtnHelp = '&Help';
  sBtnAbort = '&Abort';
  sBtnRetry = '&Retry';
  sBtnIgnore = '&Ignore';
  sBtnAll = '&All';
  sBtnNoToAll = 'N&o to All';
  sBtnYesToAll = 'Yes to &All';
  sBtnClose = '&Close';

  StrConfirmation = 'Confirmation';
  StrWarning = 'Warning';
  StrError = 'Error';
  StrInformation = 'Information';

  StrPasswordDialogTitle = 'Enter Password';
  StrChangePasswordDialogTitle = 'Change Password';
  StrConfirmPasswordDialogTitle = 'Change Password';
  StrPasswordDialogInstruction = 'Enter your password';
  StrChangePasswordDialogInstruction = 'Change your password';
  StrConfirmPasswordDialogInstruction = 'Change your password';
  StrConfirmPasswordDialogContent = 'Enter and confirm your new password.';
  StrChangePasswordDialogContent = 'Enter and confirm your new password.';
  StrPasswordsMustBeTheSame = 'Entered passwords must be the same.';
  StrAllowPlainTextPasswordsCaption = 'Show passwords as plain text';
  StrJSPasswordDialogInvalidDialogType = 'Invalid dialog type (%s) using %s.';

  { Summary
    Default enter password caption for the TJSCustomPasswordDialog class.
    Description
    Default enter password caption for the TJSCustomPasswordDialog class. }
  StrEnterPasswordCaption = '&Enter Password';
  { Summary
    The default old password caption for the TJSCustomPassword class.
    Description
    The default old password caption for the TJSCustomPassword class. }
  StrOldPasswordCaption = '&Old Password';
  { Summary
    Default new password caption for the TJSCustomPasswordDialog class.
    Description
    Default new password caption for the TJSCustomPasswordDialog class. }
  StrNewPasswordCaption = '&New Password';
  { Summary
    Default confirm password caption for the TJSConfirmPasswordDialog class.
    Description
    Default confirm password caption for the TJSConfirmPasswordDialog class. }
  StrConfirmPasswordCaption = '&Confirm New Password';
  {$ENDIF LANG_JAPANESE}

