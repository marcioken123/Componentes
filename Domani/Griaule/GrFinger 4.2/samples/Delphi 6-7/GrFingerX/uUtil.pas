{
 -------------------------------------------------------------------------------
 GrFinger Sample
 (c) 2005 Griaule Tecnologia Ltda.
 http://www.griaule.com
 -------------------------------------------------------------------------------

 This sample is provided with "GrFinger Fingerprint Recognition Library" and
 can't run without it. It's provided just as an example of using GrFinger
 Fingerprint Recognition Library and should not be used as basis for any
 commercial product.

 Griaule Tecnologia makes no representations concerning either the merchantability
 of this software or the suitability of this sample for any particular purpose.

 THIS SAMPLE IS PROVIDED BY THE AUTHOR "AS IS" AND ANY EXPRESS OR
 IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES
 OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.
 IN NO EVENT SHALL GRIAULE BE LIABLE FOR ANY DIRECT, INDIRECT,
 INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
 NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
 DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
 THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
 (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
 THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

 You can download the free version of GrFinger directly from Griaule website.
                                                                   
 These notices must be retained in any copies of any part of this
 documentation and/or sample.

 -------------------------------------------------------------------------------
}

// -----------------------------------------------------------------------------------
// Support and fingerprint management routines
// -----------------------------------------------------------------------------------

unit uUtil;

interface

uses
  Classes, StdCtrls, ExtCtrls, CheckLst, SysUtils, uDBClass, Forms,
  ADODB, Dialogs, Windows, Graphics, uMain, ActiveX, GrFingerXLib_TLB,
  AXCtrls;

type
  // Raw image data type.
  TRawImage = record
    // Image data.
    img:        OleVariant;
    // Image width.
    width:      Integer;
    // Image height.
    Height:     Integer;
    // Image resolution.
    Res:        Integer;
  end;

// Some constants to make our code cleaner
const
        ERR_CANT_OPEN_BD = -999;
        ERR_INVALID_ID = -998;
        ERR_INVALID_TEMPLATE = -997;

procedure WriteLog(msg: String);
procedure WriteError(err: Integer);

function InitializeGrFinger(): Integer;
procedure FinalizeGrFinger();
procedure PrintBiometricDisplay(biometricDisplay: boolean; context: Cardinal);
function Enroll(): Integer;
function ExtractTemplate(): Integer;
function Identify(var score: Integer): Integer;
function Verify(ID: Integer; var score: Integer): Integer;
procedure MessageVersion();

Var
  // The last acquired image.
  raw : TRawImage;
  // The template extracted from last acquired image.
  template: TTemplate;
  // Database class.
  DB: TDBClass;

implementation

// -----------------------------------------------------------------------------------
// Support functions
// -----------------------------------------------------------------------------------

// Write a message to log
procedure WriteLog(msg: String);
Begin
  // add message
  formMain.memoLog.Lines.Add(msg);
end;

// Write and describe an error.
procedure WriteError(err: Integer);
Begin
  case err of
    Integer(GR_ERROR_INITIALIZE_FAIL):
      WriteLog('Fail to Initialize GrFinger. (Error:'+IntToStr(err)+')');
    Integer(GR_ERROR_NOT_INITIALIZED):
      WriteLog('The GrFinger Library is not initialized. (Error:'+IntToStr(err)+')');
    Integer(GR_ERROR_FAIL_LICENSE_READ):
    begin
      WriteLog('License not found. See manual for troubleshooting. (Error:'+IntToStr(err)+')');
      ShowMessage('License not found. See manual for troubleshooting.');
    end;
    Integer(GR_ERROR_NO_VALID_LICENSE):
    begin
      WriteLog('The license is not valid. See manual for troubleshooting. (Error:'+IntToStr(err)+')');
      ShowMessage('The license is not valid. See manual for troubleshooting.');
    end;
    Integer(GR_ERROR_NULL_ARGUMENT):
      WriteLog('The parameter have a null value. (Error:'+IntToStr(err)+')');
    Integer(GR_ERROR_FAIL):
      WriteLog('Fail to create a GDI object.  (Error:'+IntToStr(err)+')');
    Integer(GR_ERROR_ALLOC):
      WriteLog('Fail to create a context. Cannot allocate memory. (Error:'+IntToStr(err)+')');
    Integer(GR_ERROR_PARAMETERS):
      WriteLog('One or more parameters are out of bound. (Error:'+IntToStr(err)+')');
    Integer(GR_ERROR_WRONG_USE):
      WriteLog('This function cannot be called at this time. (Error:'+IntToStr(err)+')');
    Integer(GR_ERROR_EXTRACT):
      WriteLog('Template Extraction failed. (Error:'+IntToStr(err)+')');
    Integer(GR_ERROR_SIZE_OFF_RANGE):
      WriteLog('Image is too larger or too short. (Error:'+IntToStr(err)+')');
    Integer(GR_ERROR_RES_OFF_RANGE):
      WriteLog('Image have too low or too high resolution.  (Error:'+IntToStr(err)+')');
    Integer(GR_ERROR_CONTEXT_NOT_CREATED):
      WriteLog('The Context could not be created. (Error:'+IntToStr(err)+')');
    Integer(GR_ERROR_INVALID_CONTEXT):
      WriteLog('The Context does not exist. (Error:'+IntToStr(err)+')');

    // Capture error codes

    Integer(GR_ERROR_CONNECT_SENSOR):
      WriteLog('Error while connection to sensor. (Error:'+IntToStr(err)+')');
    Integer(GR_ERROR_CAPTURING):
      WriteLog('Error while capturing from sensor. (Error:'+IntToStr(err)+')');
    Integer(GR_ERROR_CANCEL_CAPTURING):
      WriteLog('Error while stop capturing from sensor. (Error:'+IntToStr(err)+')');
    Integer(GR_ERROR_INVALID_ID_SENSOR):
      WriteLog('The idSensor is invalid. (Error:'+IntToStr(err)+')');
    Integer(GR_ERROR_SENSOR_NOT_CAPTURING):
      WriteLog('The sensor is not capturing. (Error:'+IntToStr(err)+')');
    Integer(GR_ERROR_INVALID_EXT):
      WriteLog('The File have a unknown extension. (Error:'+IntToStr(err)+')');
    Integer(GR_ERROR_INVALID_FILENAME):
      WriteLog('The filename is invalid. (Error:'+IntToStr(err)+')');
    Integer(GR_ERROR_INVALID_FILETYPE):
      WriteLog('The file type is invalid. (Error:'+IntToStr(err)+')');
    Integer(GR_ERROR_SENSOR):
      WriteLog('The sensor raise an error. (Error:'+IntToStr(err)+')');

    // Our error codes

    ERR_INVALID_TEMPLATE:
      WriteLog('Invalid Template. (Error:'+IntToStr(err)+')');
    ERR_INVALID_ID:
      WriteLog('Invalid ID. (Error:'+IntToStr(err)+')');
    ERR_CANT_OPEN_BD:
      WriteLog('Unable to connect to DataBase. (Error:'+IntToStr(err)+')');
  else
    WriteLog('Error:('+IntToStr(err)+')');
  end;
end;

// Check if we have a valid template
function TemplateIsValid(): boolean;
begin
  // Check template size and data
  TemplateIsValid := ((template.size > 0) and (template.tpt <> nil));
end;

// -----------------------------------------------------------------------------------
// Main functions for fingerprint recognition management
// -----------------------------------------------------------------------------------

// Initializes the GrFinger ActiveX and all necessary utilities.
function InitializeGrFinger(): Integer;
var
  err: Integer;
begin
  // Opening database
  DB := TDBClass.Create();
  if not DB.openDB() then begin
    InitializeGrFinger := ERR_CANT_OPEN_BD;
    Exit;
  end;
  // Create a new Template
  template := TTemplate.Create();
  // Initializing library.
  err := formMain.GrFingerXCtrl1.Initialize();
  if (err < 0) then begin
    InitializeGrFinger := err;
    exit;
  end;
  InitializeGrFinger := formMain.GrFingerXCtrl1.CapInitialize();
end;

// Finalize library and close DB.
procedure FinalizeGrFinger();
begin
  // finalize library
  formMain.GrFingerXCtrl1.Finalize();
  formMain.GrFingerXCtrl1.CapFinalize();
  // Closing database
  DB.closeDB();
  DB.Free();
  // Freeing resources
  template.Free();
end;

// Display fingerprint image on screen
procedure PrintBiometricDisplay(biometricDisplay: boolean; context: Cardinal);
var
  // handle to finger image
  handle: IPictureDisp;
  // screen HDC
  hdc: LongInt;
begin
  // free previous image
  formMain.image.Picture.Bitmap.Dormant();
  formMain.image.Picture.Bitmap.FreeImage();

  {If range checking is on - turn it off for now
   we will remember if range checking was on by defining
   a define called CKRANGE if range checking is on.
   We do this to access array members past the arrays
   defined index range without causing a range check
   error at runtime. To satisfy the compiler, we must
   also access the indexes with a variable. ie: if we
   have an array defined as a: array[0..0] of byte,
   and an integer i, we can now access a[3] by setting
   i := 3; and then accessing a[i] without error}
  {$IFOPT R+}
    {$DEFINE CKRANGE}
  {$R-}
  {$ENDIF}

  // get screen HDC
  hdc := GetDC(0);

  if biometricDisplay then
    // get image with biometric info
    formMain.GrFingerXCtrl1.BiometricDisplay(template.tpt,raw.img, raw.width, raw.height,raw.Res, hdc,
                        handle, context)
  else
    // get raw image
    formMain.GrFingerXCtrl1.CapRawImageToHandle(raw.img, raw.width, raw.height, hdc, handle);

  // draw image on picture box
  if handle <> nil then
  begin
    SetOlePicture(formMain.image.Picture, handle);
    formMain.image.Width := formMain.Bevel1.Width;
    formMain.image.Height := formMain.Bevel1.Height;
    formMain.image.Repaint();
  end;

  // release screen HDC
  ReleaseDC(HWND(nil), hdc);

  {Turn range checking back on if it was on when we started}
  {$IFDEF CKRANGE}
    {$UNDEF CKRANGE}
    {$R+}
  {$ENDIF}
end;

// Add a fingerprint template to database
function Enroll(): Integer;
Var
  id: Integer;
Begin
  // Checking if template is valid.
  if (TemplateIsValid()) then begin
    // Adds template to database and gets the ID.
    id := DB.addTemplate(template);
    Enroll := id;
  end
  else
    Enroll := -1;
end;

// Extract a fingerprint template from current image
function ExtractTemplate(): Integer;
Var
  ret: Integer;
Begin
  // set current buffer size for extract template
  template.size := GR_MAX_SIZE_TEMPLATE;
  ret := formMain.GrFingerXCtrl1.Extract(raw.img, raw.width, raw.height, raw.res, template.tpt,
                        template.size, GR_DEFAULT_CONTEXT);
  // if error, set template size to 0
  // Result < 0 => extraction problem
  if (ret < 0 ) then
    template.size := 0;
  ExtractTemplate := ret;
End;

// Identify current fingerprint on our database
function Identify(var score: Integer): Integer;
Var
  ret: Integer;
  tptRef: TTemplate;
Begin
  // Checking if template is valid.
  if not(TemplateIsValid())then
  begin
    Identify := ERR_INVALID_TEMPLATE;
    exit;
  end;
  // Starting identification process and supplying query template.
  ret := formMain.GrFingerXCtrl1.IdentifyPrepare(template.tpt, GR_DEFAULT_CONTEXT);
  // error?
  if (ret < 0) then begin
    identify := ret;
    exit;
  end;
  // Getting enrolled templates from database.
  DB.getTemplates();
  tptRef := DB.getNextTemplate();
  // Iterate over all templates in database
  if tptRef.size > 0 then
    repeat
      // Comparing current template.
      ret := formMain.GrFingerXCtrl1.Identify(tptRef.tpt, score, GR_DEFAULT_CONTEXT);
      // Checking if query template and reference template match.
      if (ret = GR_MATCH) then
      begin
        Identify := tptRef.id;
        exit;
      end
      else if (ret < 0) then
        begin
          Identify := ret;
          exit;
        end;
      tptRef := DB.getNextTemplate();
    until tptRef.size <= 0;
    // end of database, return "no match" code
    Identify := GR_NOT_MATCH;
end;

// Check current fingerprint against another one in our database
function Verify(ID: Integer; var score: Integer): Integer;
Var
  tptRef: TTemplate;
Begin
  // Checking if template is valid.
  if not(TemplateIsValid()) then
  begin
    Verify := ERR_INVALID_TEMPLATE;
    exit;
  end;
  // Getting template with the supplied ID from the database.
  tptRef := DB.getTemplate(id);
  if ((tptRef.tpt = nil) or (tptRef.size <= 0)) then
  begin
    Verify := ERR_INVALID_ID;
    exit;
  end;
  // Comparing templates.
  Verify := formMain.GrFingerXCtrl1.Verify(template.tpt, tptRef.tpt, score, GR_DEFAULT_CONTEXT);
end;

// Show GrFinger version and type
procedure MessageVersion();
var majorVersion: byte;
    minorVersion: byte;
    result: integer;
    vStr: String;
begin
    result := formMain.GrFingerXCtrl1.GetGrFingerVersion(majorVersion, minorVersion);
    If result = GRFINGER_FULL Then vStr := 'FULL';
    If result = GRFINGER_LIGHT Then vStr := 'LIGHT';
    If result = GRFINGER_FREE Then vStr := 'FREE';
    Application.MessageBox(PChar('The GrFinger DLL version is ' + IntToStr(majorVersion) +
            '.' + IntToStr(minorVersion) + '.' + #13#10 +
            'The license type is ''' + vStr + '''.'), PChar('GrFinger Version'), MB_OK);
end;

end.

