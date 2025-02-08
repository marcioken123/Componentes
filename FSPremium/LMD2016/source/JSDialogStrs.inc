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
  StrYouMustAssociateA = 'Sie müssen eine Hilfedatei mit Ihrer Anwendung verknüpfen';

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
  sBtnClose = '&Schließen';

  StrConfirmation = 'Bestätigung';
  StrWarning = 'Warnung';
  StrError = 'Fehler';
  StrInformation = 'Information';

  StrPasswordDialogTitle = 'Passwort eingeben';
  StrChangePasswordDialogTitle = 'Passwort ändern';
  StrConfirmPasswordDialogTitle = 'Passwort ändern';
  StrPasswordDialogInstruction = 'Geben Sie Ihr Passwort ein';
  StrChangePasswordDialogInstruction = 'Ändern Sie Ihr Passwort';
  StrConfirmPasswordDialogInstruction = 'Ändern Sie Ihr Passwort';
  StrConfirmPasswordDialogContent = 'Bitte geben Sie Ihr neues Passwort ein und bestätigen Sie dieses.';
  StrChangePasswordDialogContent = 'Bitte geben Sie Ihr neues Passwort ein und bestätigen Sie dieses.';
  StrPasswordsMustBeTheSame = 'Die eingegebenen Passwörter müssen identisch sein.';
  StrAllowPlainTextPasswordsCaption = 'Passwörter als Klartext anzeigen';
  StrJSPasswordDialogInvalidDialogType = 'Ungültiger Dialog Typ (%s) nutzt %s.';

  StrEnterPasswordCaption = '&Passwort eingeben';
  StrOldPasswordCaption = '&Altes Passwort';
  StrNewPasswordCaption = '&Neues Passwort';
  StrConfirmPasswordCaption = 'Passwort &bestätigen';
  {$ENDIF LANG_GERMAN}

  {$IFDEF LANG_CZECH}
  StrAssignSourceMustB = 'Připojený zdroj musí být TJSDialog';
  StrYouMustAssociateA = 'K aplikaci musíte připojit soubor s nápovědou';

  sBtnYes = '&Ano';
  sBtnNo = '&Ne';
  sBtnOK = 'OK';
  sBtnCancel = 'Storno';
  sBtnHelp = 'Nápověda';
  sBtnAbort = '&Přerušit';
  sBtnRetry = '&Opakovat';
  sBtnIgnore = 'Pře&skočit';
  sBtnAll = '&Vše';
  sBtnNoToAll = 'Ne všem';
  sBtnYesToAll = 'Ano všem';
  sBtnClose = 'Zavřít';

  StrConfirmation = 'Potvrzení';
  StrWarning = 'Upozornění';
  StrError = 'Chyba';
  StrInformation = 'Informace';

  StrPasswordDialogTitle = 'Zadat heslo';
  StrChangePasswordDialogTitle = 'Změnit heslo';
  StrConfirmPasswordDialogTitle = 'Změnit heslo';
  StrPasswordDialogInstruction = 'Zadejte heslo';
  StrChangePasswordDialogInstruction = 'Změňte heslo';
  StrConfirmPasswordDialogInstruction = 'Změňte heslo';
  StrConfirmPasswordDialogContent = 'Zadejte a potvrďte nové heslo.';
  StrChangePasswordDialogContent = 'Zadejte a potvrďte nové heslo.';
  StrPasswordsMustBeTheSame = 'Zadaná hesla musí být stejná.';
  StrAllowPlainTextPasswordsCaption = 'Zobrazit hesla jako prostý text';
  StrJSPasswordDialogInvalidDialogType = 'Neplatný typ dialogu (%s) při použití %s.';

  StrEnterPasswordCaption = '&Zadat heslo';
  StrOldPasswordCaption = '&Staré heslo';
  StrNewPasswordCaption = '&Nové heslo';
  StrConfirmPasswordCaption = '&Potvrdit nové heslo';
  {$ENDIF LANG_CZECH}

  {$IFDEF LANG_SLOVENE}
  StrAssignSourceMustB = 'Assigned source must be a TJSDialog';
  StrYouMustAssociateA = 'You must associate a Help File with your application';

  sBtnYes = '&Da';
  sBtnNo = '&Ne';
  sBtnOK = 'V redu';
  sBtnCancel = 'Preklic';
  sBtnHelp = '&Pomoč';
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
  StrAssignSourceMustB = 'La source assignée doit être un TJSDialog';
  StrYouMustAssociateA = 'Vous devez associer un Fichier d''Aide à votre application';

  sBtnYes = '&Oui';
  sBtnNo = '&Non';
  sBtnOK = 'OK';
  sBtnCancel = 'Annuler';
  sBtnHelp = 'A&ide';
  sBtnAbort = 'A&bandonner';
  sBtnRetry = '&Réessayer';
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
  StrPasswordsMustBeTheSame = 'Les mots de passe entrés doivent être identiques.';
  StrAllowPlainTextPasswordsCaption = 'Afficher les mots de passe sous forme de texte brut';
  StrJSPasswordDialogInvalidDialogType = 'Type de dialogue (%s) incorrect lors de l''utilisation de %s.';

  StrEnterPasswordCaption = '&Entrez le mot de passe';
  StrOldPasswordCaption = 'Ancien m&ot de passe';
  StrNewPasswordCaption = '&Nouveau mot de passe';
  StrConfirmPasswordCaption = '&Confirmer le nouveau mot de passe';
  {$ENDIF LANG_FRENCH}

  {$IFDEF LANG_DANISH}
  StrAssignSourceMustB = 'Assigned source skal være af type TJSDialog';
  StrYouMustAssociateA = 'Du skal associere en hjælpefil med din applikation';

  sBtnYes = '&Ja';
  sBtnNo = '&Nej';
  sBtnOK = 'OK';
  sBtnCancel = 'Afbryd';
  sBtnHelp = '&Hjælp';
  sBtnAbort = '&Abort';
  sBtnRetry = '&Prøv igen';
  sBtnIgnore = '&Ignorér';
  sBtnAll = '&Alle';
  sBtnNoToAll = 'N&ej til alle';
  sBtnYesToAll = 'Ja to &Alle';
  sBtnClose = '&Luk';

  StrConfirmation = 'Bekræft';
  StrWarning = 'Advarsel';
  StrError = 'Fejl';
  StrInformation = 'Information';

  StrPasswordDialogTitle = 'Indtast adgangskode';
  StrChangePasswordDialogTitle = 'Skift adgangskode';
  StrConfirmPasswordDialogTitle = 'Skift adgangskode';
  StrPasswordDialogInstruction = 'Indtast din adgangskode';
  StrChangePasswordDialogInstruction = 'Skift din adgangskode';
  StrConfirmPasswordDialogInstruction = 'Skift din adgangskode';
  StrConfirmPasswordDialogContent = 'Indtast og bekræft din nye adgangskode.';
  StrChangePasswordDialogContent = 'Indtast og bekræft din nye adgangskode.';
  StrPasswordsMustBeTheSame = 'De indtastede adgangskoder skal være ens.';
  StrAllowPlainTextPasswordsCaption = 'Vis adgangskoder som ren tekst';
  StrJSPasswordDialogInvalidDialogType = 'Ugyldig dialogtype (%s) ved brug af %s.';

  StrEnterPasswordCaption = 'Indtast &adgangskode';
  StrOldPasswordCaption = '&Gammel adgangskode';
  StrNewPasswordCaption = '&Ny adgangskode';
  StrConfirmPasswordCaption = '&Bekræft ny adgangskode';
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
  StrAssignSourceMustB = 'Fonte atribuída deve ser um TJSDialog';
  StrYouMustAssociateA = 'Você deve associar um arquivo de ajuda a sua aplicação';

  sBtnYes = '&Sim';
  sBtnNo = '&Não';
  sBtnOK = 'OK';
  sBtnCancel = 'Cancelar';
  sBtnHelp = '&Ajuda';
  sBtnAbort = '&Abortar';
  sBtnRetry = '&Tentar';
  sBtnIgnore = '&Ignorar';
  sBtnAll = '&Todos';
  sBtnNoToAll = 'Nã&o a Todos';
  sBtnYesToAll = '&Sim a Todos';
  sBtnClose = '&Fechar';

  StrConfirmation = 'Confirmação';
  StrWarning = 'Aviso';
  StrError = 'Erro';
  StrInformation = 'Informação';

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
  StrJSPasswordDialogInvalidDialogType = 'Tipo inválido de diálogo (%s) usando %s.';

  StrEnterPasswordCaption = '&Entre com senha';
  StrOldPasswordCaption = 'Senha &Antiga';
  StrNewPasswordCaption = '&Nova Senha';
  StrConfirmPasswordCaption = '&Confirmar Nova Senha';
  {$ENDIF LANG_BRAZILIANPORTUGUESE}

  {$IFDEF LANG_SVENSKA}
  StrAssignSourceMustB = 'Tilldelad källa måste vara TJSDialog';
  StrYouMustAssociateA = 'Du måste associera en Hjälpfil med din applikation';

  sBtnYes = '&Ja';
  sBtnNo = '&Nej';
  sBtnOK = 'OK';
  sBtnCancel = 'Avbryt';
  sBtnHelp = '&Hjälp';
  sBtnAbort = '&Avbryt';
  sBtnRetry = '&Försök igen';
  sBtnIgnore = '&Ignorera';
  sBtnAll = '&Alla';
  sBtnNoToAll = 'N&ej till Alla';
  sBtnYesToAll = 'Ja till &Alla';
  sBtnClose = '&Stäng';

  StrConfirmation = 'Bekräfta';
  StrWarning = 'Varning';
  StrError = 'Fel';
  StrInformation = 'Information';

  StrPasswordDialogTitle = 'Skriv Lösenord';
  StrChangePasswordDialogTitle = 'Byt Lösenord';
  StrConfirmPasswordDialogTitle = 'Byt Lösenord';
  StrPasswordDialogInstruction = 'Skriv Ditt Lösenord';
  StrChangePasswordDialogInstruction = 'Ändra Ditt Lösenord';
  StrConfirmPasswordDialogInstruction = 'Ändra Ditt Lösenord';
  StrConfirmPasswordDialogContent = 'Skriv och Bekräfta ditt nya lösenord.';
  StrChangePasswordDialogContent = 'Skriv och Bekräfta ditt nya lösenord.';
  StrPasswordsMustBeTheSame = 'Bägge lösenorden måste vara lika.';
  StrAllowPlainTextPasswordsCaption = 'Visa lösenord som text';
  StrJSPasswordDialogInvalidDialogType = 'Ogiltig dialog typ (%s) använder %s.';

  StrEnterPasswordCaption = '&Skriv Lösenord';
  StrOldPasswordCaption = '&Gammalt Lösenord';
  StrNewPasswordCaption = '&Nytt Lösenord';
  StrConfirmPasswordCaption = '&Bekräfta Nytt Lösenord';
  {$ENDIF LANG_SVENSKA}
  
  {$IFDEF LANG_JAPANESE}
  StrAssignSourceMustB = 'Assign元はTJSDialogでなくてはいけません';
  StrYouMustAssociateA = 'ヘルプファイルがアプリケーションに関連づけされていません';

  sBtnYes = 'はい(&Y)';
  sBtnNo = 'いいえ(&N)';
  sBtnOK = 'OK';
  sBtnCancel = 'キャンセル';
  sBtnHelp = 'ヘルプ(&H)';
  sBtnAbort = '中止(&A)';
  sBtnRetry = 'リトライ(&R)';
  sBtnIgnore = '無視(&I)';
  sBtnAll = 'すべて(&A)';
  sBtnNoToAll = 'すべていいえ(&O)';
  sBtnYesToAll = 'すべてはい(&A)';
  sBtnClose = '閉じる(&C)';

  StrConfirmation = '確認';
  StrWarning = '警告';
  StrError = 'エラー';
  StrInformation = '情報';

  StrPasswordDialogTitle = 'パスワードを入力';
  StrChangePasswordDialogTitle = 'パスワードを変更';
  StrConfirmPasswordDialogTitle = 'パスワードを変更';
  StrPasswordDialogInstruction = 'パスワードを入力してください';
  StrChangePasswordDialogInstruction = 'パスワードを変更します';
  StrConfirmPasswordDialogInstruction = 'パスワードを変更します';
  StrConfirmPasswordDialogContent = '新しいパスワードを入力・確認してください.';
  StrChangePasswordDialogContent = '新しいパスワードを入力・確認してください.';
  StrPasswordsMustBeTheSame = '入力されたパスワードが一致しません';
  StrAllowPlainTextPasswordsCaption = 'パスワードを平分で表示する';
  StrJSPasswordDialogInvalidDialogType = 'ダイアログのタイプが不正(%s)です(%sを使用).';

  StrEnterPasswordCaption = 'パスワードを入力(&E)';
  StrOldPasswordCaption = '現在のパスワード(&O)';
  StrNewPasswordCaption = '新しいパスワード(&N)';
  StrConfirmPasswordCaption = '新しいパスワードを確認(&C)';
  {$ENDIF LANG_JAPANESE}

