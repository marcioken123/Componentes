unit wwrichspell;
{$DENYPACKAGEUNIT ON}
{$i wwIfDef.pas}

interface

uses
  wwriched;

function SpellCheckWithCom(RichEdit: TwwCustomRichEdit;
  var ErrorStarting: boolean): boolean;

implementation

{$ifndef wwDelphi5Up}
function SpellCheckWithCom(RichEdit: TwwCustomRichEdit;
  var ErrorStarting: boolean): boolean;
begin
   result:= False;
end;

{$else}

uses word97, oleserver, activex, sysutils, dialogs, forms, controls;

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

function SpellCheckWithCom(RichEdit: TwwCustomRichEdit;
  var ErrorStarting: boolean): boolean;
var
  RouteDocument, OriginalFormat, SaveChanges: OLEVariant;
  BoolFalse, EmptyString, Format, FileNameOLE: OLEVariant;
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

    RichEdit.ILines.SaveToFile(FileName);

    Screen.cursor:= crHourGlass;
    NoErrors:= False;

    WordApplication:= TwwWordApplication.create(RichEdit);
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

         Data:= RichEdit.text;

         FileNameOLE := FileName;
         BoolFalse:= False;
         EmptyString:= '';
         Format:= wdOpenFormatAuto;
         Documents.Open(FileNameOLE, BoolFalse, BoolFalse,
            BoolFalse, EmptyString, EmptyString, BoolFalse,
            EmptyString, EmptyString, format);
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
             RichEdit.ILines.LoadFromFile(FileName);
       DeleteFile(FileName);
       Application.BringToFront;
       Screen.Cursor:= crArrow;
   end;
   if Not ErrorStarting then
      result:= not NoErrors
   else result:= false
end;
{$Endif}

end.
