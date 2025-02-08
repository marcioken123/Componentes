unit wwrichedspell2000;
//
// Component : TwwDBRichEditMSWord
//
// Copyright (c) 1999-2001 by Woll2Woll Software
//
// 4/18/00 - Fixed open failure by changing last paramater to true
//
{$i wwIfDef.pas}

interface

uses classes, wwriched;

type
  TwwDBRichEditMSWord = class(TwwDBRichEdit)
   public
     Function MSWordSpellChecker: boolean; override;
  end;

procedure Register;

implementation

{$R wwrichsp.RES}

uses word2000, oleserver, activex, sysutils, dialogs, forms, controls,
     wwintl;

type
 TwwWordApplication=class(TWordApplication)
  private
    ValidServer: boolean;
  protected
    function GetServer: IUnknown; override;
 end;

function CreateComObject(const ClassID: TGUID; var Status: HResult): IUnknown;
begin
  Status:= CoCreateInstance(ClassID, nil, CLSCTX_INPROC_SERVER or
    CLSCTX_LOCAL_SERVER, IUnknown, Result);
end;

function TwwWordApplication.GetServer: IUnknown;
var Status: HResult;
begin
  case ConnectKind of
    ckNewInstance:
      Result := CreateComObject(ServerData^.ClassId, Status)
    else Result:= inherited GetServer;
  end;
  ValidServer:= (Result<>nil);
  if not ValidServer then abort; //OleCheck(Status);
end;

Function TwwDBRichEditMSWord.MSWordSpellChecker: boolean;
{$ifdef wwDelphi5Up}
var
    ErrorStarting: boolean;

function SpellCheckWithCom: boolean;
var
  RouteDocument, OriginalFormat, SaveChanges: OLEVariant;
  BoolFalse, BoolTrue, EmptyString, Format, FileNameOLE: OLEVariant;
  WordApplication: TwwWordApplication;
  FileName:string;
  NoErrors: boolean;
  Data: OLEVariant;
begin
    result:= False;
    if not wwGetUniqueFileName(FileName) then begin
       ShowMessage('Fail to create temporary file.');
       exit;
    end;

    ILines.SaveToFile(FileName);

    Screen.cursor:= crHourGlass;
    NoErrors:= False;

    WordApplication:= TwwWordApplication.create(self);
    try
       WordApplication.ConnectKind:= ckNewInstance;

       with WordApplication do begin
         ErrorStarting:= True;
         Connect;
         ErrorStarting:= not Validserver;
         if not ValidServer then begin
            exit;
         end;

         WindowState:= wdWindowStateMinimize;

         Data:= self.text;

         FileNameOLE := FileName;
         BoolFalse:= False;
         BoolTrue:= True;
         EmptyString:= '';
         Format:= wdOpenFormatAuto;
         Documents.Open(FileNameOLE, BoolFalse, BoolFalse,
            BoolFalse, EmptyString, EmptyString, BoolFalse,
            EmptyString, EmptyString, format, BoolFalse, BoolTrue); { 4/18/00 - Changed last paramater to true }
         Visible := False;

         NoErrors:= (ActiveDocument.SpellingErrors.Count=0) and
                    (ActiveDocument.GrammaticalErrors.Count=0);

         if not NoErrors then
         begin
           ActiveDocument.CheckGrammar;
           ActiveDocument.Save;
         end;
         SaveChanges:= wdDoNotSaveChanges;
         OriginalFormat:= wdOriginalDocumentFormat;
         RouteDocument:= False;
         ActiveDocument.Close(SaveChanges, OriginalFormat, RouteDocument);

         Quit(SaveChanges, OriginalFormat, RouteDocument);
      end;
   finally
       WordApplication.Free;
       if (not ErrorStarting) then
          if (not NoErrors) then
             ILines.LoadFromFile(FileName);
       DeleteFile(FileName);
       Application.BringToFront;
       Screen.Cursor:= crArrow;
   end;
   if Not ErrorStarting then
      result:= not NoErrors
   else result:= false
end;
{$Endif}

begin
   {$ifdef wwDelphi5Up}
   try
      result:= SpellCheckWithCom;
   except
      if ErrorStarting then begin
         result:= False;
         MessageDlg(wwInternational.UserMessages.RichEditMSWordNotFound,
                    mtInformation, [mbOK], 0);
         exit;
      end;
      raise;
   end;

   if (not result) and (wwInternational.UserMessages.RichEditSpellCheckComplete<>'') then
      MessageDlg(wwInternational.UserMessages.RichEditSpellCheckComplete,
                    mtInformation, [mbOK], 0);
   {$else}
   result:= True;
   {$endif}
end;

procedure Register;
begin
  RegisterComponents('IP Controls', [TwwDBRichEditMSWord]);
end;

end.
