{ Summary
  Unit that contains the resourcestrings for the TJSDialog implementation. }
unit JSDialogStrs;

{

  ** NOTE: ******************************************************

  This unit is just a stub for the real strings unit.
  This is required to support unicode file format for BDS
  environments and an ansi file format for Delphi 6 and Delphi 7.

}

{$I lmddlgcmps.inc}
{$IFDEF BDS}
  {$I JSDialogStrs.inc}
{$ELSE}
  {$I JSDialogStrsDelphi.inc}
{$ENDIF}

{ Summary
  Retrieves the correctly translated string for the string value passed in.
  Description
  This method is used internally to make sure that the correctly string translation is being used.

  There should not be any reason for an end users application to call this method directly. }
function GetTranslatedString(const AStr: TJSString): TJSString;
{ Summary
  String you want to replace and a pointer to the replacement string.
  Description
  Call ReplaceResourceString to change the value of an existing string. }
procedure ReplaceResourceString(const AStr: TJSString; APtr: Pointer); overload;
{ Summary
  String you want to replace and a pointer to the replacement string.
  Description
  Call ReplaceResourceString to change the value of an existing string.

  This method is only valid when the ChangeJSDialogUseResourcestrings method has been called with a parameter
  of False. }
procedure ReplaceResourceString(const AStr, ANewStr: TJSString); overload;
{ Summary
  Method that fills a string list with all of the translatable text.
  Description
  Call ReplaceResourceString to help translate all strings available in JSDialog.
  This method is only valid when the ChangeJSDialogUseResourcestrings method has been called with a parameter
  of False. }
procedure GetResourceStrings(AStrings: TStringList);

{ Summary
  Change JSDialog Pack to use resource strings for localisation purposes.
  Description
  Call this method to force JSDialog Pack to retrieve translation resources from the defined resource
  strings.<p />
  <p />
  This method is also useful in resetting the resource strings back to their initial state. Since it is
  possible to override existing resource strings with custom values.                                    }
procedure ChangeJSDialogUseResourceStrings(const AValue: Boolean);

{ Summary
  Initialise the resource strings.
  Description
  Calling InitializeResourceStrings resets all strings back to the default values. }
procedure InitializeResourceStrings;

implementation

uses
  SysUtils;

var
  FResourceStrings: TStringList;

  { Summary
    Specifies that dialogs will load strings from resource strings.
    Description
    Change this value from the default setting if you want to store and use resource strings using an alternate
    storage method, such as DxGetText.

    Use the ChangeJSDialogUseResourceStrings method to modify this value. }
  JSDialogUseResourceStrings: Boolean;

type
  TStringObj = class
  private
    FTranslation: TJSString;
  public
    constructor Create(const ATranslation: TJSString); reintroduce;
    property Translation: TJSString read FTranslation write FTranslation;
  end;

function GetString(const AStr: TJSString): TJSString;
var
  lIdx: Integer;
begin
  if FResourceStrings.Find(AStr, lIdx) then
    result := TStringObj(FResourceStrings.Objects[lIdx]).Translation
  else
    result := AStr;
end;

function GetResourceString(const AStr: TJSString): Pointer;
var
  lIdx: Integer;
begin
  if FResourceStrings.Find(AStr, lIdx) then
    result := Pointer(FResourceStrings.Objects[lIdx])
  else
    result := nil;
end;

function GetTranslatedString(const AStr: TJSString): TJSString;
begin
  if JSDialogUseResourceStrings then
    result := LoadResString(GetResourceString(AStr))
  else
    result := GetString(AStr);
end;

procedure ReplaceResourceString(const AStr: TJSString; APtr: Pointer);
var
  lIdx: Integer;
begin
  if FResourceStrings.Find(AStr, lIdx) then
    FResourceStrings.Objects[lIdx] := APtr;
end;

procedure ReplaceResourceString(const AStr, ANewStr: TJSString);
var
  lIdx: Integer;
begin
  if not JSDialogUseResourceStrings then
  begin
    if FResourceStrings.Find(AStr, lIdx) then
      TStringObj(FResourceStrings.Objects[lIdx]).Translation := ANewStr;
  end;
end;

procedure GetResourceStrings(AStrings: TStringList);
var
  I: Integer;
begin
  if not JSDialogUseResourceStrings then
  begin
    AStrings.Clear;
    for I := 0 to FResourceStrings.Count - 1 do
      AStrings.Add(FResourceStrings[I]);
  end;
end;

procedure InitializeResourceStrings;
begin
  if FResourceStrings <> nil then
    FreeAndNil(FResourceStrings);
  FResourceStrings := TStringList.Create;
  FResourceStrings.Sorted := True;
  FResourceStrings.Duplicates := dupAccept;
  // load strings for reference
  if JSDialogUseResourceStrings then
  begin
    FResourceStrings.AddObject(StrAssignSourceMustB, @StrAssignSourceMustB);
    FResourceStrings.AddObject(StrYouMustAssociateA, @StrYouMustAssociateA);
    FResourceStrings.AddObject(sBtnYes, @sBtnYes);
    FResourceStrings.AddObject(sBtnNo, @sBtnNo);
    FResourceStrings.AddObject(sBtnOK, @sBtnOK);
    FResourceStrings.AddObject(sBtnCancel, @sBtnCancel);
    FResourceStrings.AddObject(sBtnHelp, @sBtnHelp);
    FResourceStrings.AddObject(sBtnAbort, @sBtnAbort);
    FResourceStrings.AddObject(sBtnRetry, @sBtnRetry);
    FResourceStrings.AddObject(sBtnIgnore, @sBtnIgnore);
    FResourceStrings.AddObject(sBtnAll, @sBtnAll);
    FResourceStrings.AddObject(sBtnNoToAll, @sBtnNoToAll);
    FResourceStrings.AddObject(sBtnYesToAll, @sBtnYesToAll);
    FResourceStrings.AddObject(sBtnClose, @sBtnClose);
    FResourceStrings.AddObject(StrConfirmation, @StrConfirmation);
    FResourceStrings.AddObject(StrWarning, @StrWarning);
    FResourceStrings.AddObject(StrError, @StrError);
    FResourceStrings.AddObject(StrInformation, @StrInformation);
    FResourceStrings.AddObject(StrPasswordDialogTitle, @StrPasswordDialogTitle);
    FResourceStrings.AddObject(StrChangePasswordDialogTitle, @StrChangePasswordDialogTitle);
    FResourceStrings.AddObject(StrConfirmPasswordDialogTitle, @StrConfirmPasswordDialogTitle);
    FResourceStrings.AddObject(StrPasswordDialogInstruction, @StrPasswordDialogInstruction);
    FResourceStrings.AddObject(StrChangePasswordDialogInstruction, @StrChangePasswordDialogInstruction);
    FResourceStrings.AddObject(StrConfirmPasswordDialogInstruction, @StrConfirmPasswordDialogInstruction);
    FResourceStrings.AddObject(StrConfirmPasswordDialogContent, @StrConfirmPasswordDialogContent);
    FResourceStrings.AddObject(StrChangePasswordDialogContent, @StrChangePasswordDialogContent);
    FResourceStrings.AddObject(StrPasswordsMustBeTheSame, @StrPasswordsMustBeTheSame);
    FResourceStrings.AddObject(StrAllowPlainTextPasswordsCaption, @StrAllowPlainTextPasswordsCaption);
    FResourceStrings.AddObject(StrJSPasswordDialogInvalidDialogType, @StrJSPasswordDialogInvalidDialogType);
    FResourceStrings.AddObject(StrEnterPasswordCaption, @StrEnterPasswordCaption);
    FResourceStrings.AddObject(StrOldPasswordCaption, @StrOldPasswordCaption);
    FResourceStrings.AddObject(StrNewPasswordCaption, @StrNewPasswordCaption);
    FResourceStrings.AddObject(StrConfirmPasswordCaption, @StrConfirmPasswordCaption);
  end
  else
  begin
    FResourceStrings.AddObject(StrAssignSourceMustB, TStringObj.Create(StrAssignSourceMustB));
    FResourceStrings.AddObject(StrYouMustAssociateA, TStringObj.Create(StrYouMustAssociateA));
    FResourceStrings.AddObject(sBtnYes, TStringObj.Create(sBtnYes));
    FResourceStrings.AddObject(sBtnNo, TStringObj.Create(sBtnNo));
    FResourceStrings.AddObject(sBtnOK, TStringObj.Create(sBtnOK));
    FResourceStrings.AddObject(sBtnCancel, TStringObj.Create(sBtnCancel));
    FResourceStrings.AddObject(sBtnHelp, TStringObj.Create(sBtnHelp));
    FResourceStrings.AddObject(sBtnAbort, TStringObj.Create(sBtnAbort));
    FResourceStrings.AddObject(sBtnRetry, TStringObj.Create(sBtnRetry));
    FResourceStrings.AddObject(sBtnIgnore, TStringObj.Create(sBtnIgnore));
    FResourceStrings.AddObject(sBtnAll, TStringObj.Create(sBtnAll));
    FResourceStrings.AddObject(sBtnNoToAll, TStringObj.Create(sBtnNoToAll));
    FResourceStrings.AddObject(sBtnYesToAll, TStringObj.Create(sBtnYesToAll));
    FResourceStrings.AddObject(sBtnClose, TStringObj.Create(sBtnClose));
    FResourceStrings.AddObject(StrConfirmation, TStringObj.Create(StrConfirmation));
    FResourceStrings.AddObject(StrWarning, TStringObj.Create(StrWarning));
    FResourceStrings.AddObject(StrError, TStringObj.Create(StrError));
    FResourceStrings.AddObject(StrInformation, TStringObj.Create(StrInformation));
    FResourceStrings.AddObject(StrPasswordDialogTitle, TStringObj.Create(StrPasswordDialogTitle));
    FResourceStrings.AddObject(StrChangePasswordDialogTitle, TStringObj.Create(StrChangePasswordDialogTitle));
    FResourceStrings.AddObject(StrConfirmPasswordDialogTitle, TStringObj.Create(StrConfirmPasswordDialogTitle));
    FResourceStrings.AddObject(StrPasswordDialogInstruction, TStringObj.Create(StrPasswordDialogInstruction));
    FResourceStrings.AddObject(StrChangePasswordDialogInstruction, TStringObj.Create(StrChangePasswordDialogInstruction));
    FResourceStrings.AddObject(StrConfirmPasswordDialogInstruction, TStringObj.Create(StrConfirmPasswordDialogInstruction));
    FResourceStrings.AddObject(StrConfirmPasswordDialogContent, TStringObj.Create(StrConfirmPasswordDialogContent));
    FResourceStrings.AddObject(StrChangePasswordDialogContent, TStringObj.Create(StrChangePasswordDialogContent));
    FResourceStrings.AddObject(StrPasswordsMustBeTheSame, TStringObj.Create(StrPasswordsMustBeTheSame));
    FResourceStrings.AddObject(StrAllowPlainTextPasswordsCaption, TStringObj.Create(StrAllowPlainTextPasswordsCaption));
    FResourceStrings.AddObject(StrJSPasswordDialogInvalidDialogType, TStringObj.Create(StrJSPasswordDialogInvalidDialogType));
    FResourceStrings.AddObject(StrEnterPasswordCaption, TStringObj.Create(StrEnterPasswordCaption));
    FResourceStrings.AddObject(StrOldPasswordCaption, TStringObj.Create(StrOldPasswordCaption));
    FResourceStrings.AddObject(StrNewPasswordCaption, TStringObj.Create(StrNewPasswordCaption));
    FResourceStrings.AddObject(StrConfirmPasswordCaption, TStringObj.Create(StrConfirmPasswordCaption));
  end;
end;

procedure CleanUpResourceStrings;
var
  I: Integer;
begin
  if not JSDialogUseResourceStrings then
  begin
    for I := 0 to FResourceStrings.Count - 1 do
      TStringObj(FResourceStrings.Objects[I]).Free;
  end;
end;

procedure ChangeJSDialogUseResourceStrings(const AValue: Boolean);
begin
  if JSDialogUseResourceStrings <> AValue then
  begin
    if not AValue then
      CleanUpResourceStrings;
    JSDialogUseResourceStrings := AValue;
    InitializeResourceStrings;
  end;
end;

{ TStringObj }

constructor TStringObj.Create(const ATranslation: TJSString);
begin
  inherited Create;
  FTranslation := ATranslation;
end;

initialization
  JSDialogUseResourceStrings := True;
  InitializeResourceStrings;

finalization
  CleanUpResourceStrings;
  FreeAndNil(FResourceStrings);

end.
