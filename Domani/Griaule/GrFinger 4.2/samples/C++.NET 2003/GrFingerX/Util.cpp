/*
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
*/

// -----------------------------------------------------------------------------------
// Support and fingerprint management routines
// -----------------------------------------------------------------------------------

using namespace System::Data::OleDb;
using namespace System::Data;
using namespace Interop::GrFingerXLib;

#include "StdAfx.h"
#include "util.h"

//we'll use .NET MessageBox
#ifdef MessageBox
#undef MessageBox
#endif

// -----------------------------------------------------------------------------------
// Support functions
// -----------------------------------------------------------------------------------

// This class creates an Util class with some functions
// to help us to develop our GrFinger Application
Util::Util(ListBox *lbLog, PictureBox *pbPic,
		   Button *btEnroll, Button *btExtract, Button *btIdentify,
		   Button *btVerify, CheckBox *ckBoxAutoExtract,
		   CheckBox *ckBoxAutoIdentify) {
  _lbLog = lbLog;
  _pbPic = pbPic;
  _btEnroll = btEnroll;
  _btExtract = btExtract;
  _btIdentify = btIdentify;
  _btVerify = btVerify;
  _cbAutoExtract = ckBoxAutoExtract;
  _cbAutoIdentify = ckBoxAutoIdentify;
  _DB = NULL;
  _tpt = NULL;
}

Util::~Util(void){
}

//  Write a message in the log box.
void Util::WriteLog(String *msg) {
  _lbLog->Items->Add(msg);
  _lbLog->SelectedIndex = _lbLog->Items->Count - 1;
  _lbLog->ClearSelected();
}

// Write and describe an error.
void Util::WriteError(int errorCode) {
	switch (errorCode) {
		case GRConstants::GR_ERROR_INITIALIZE_FAIL:
            WriteLog(String::Concat(S"Fail to Initialize GrFingerX. (Error:", Convert::ToString(errorCode), ")"));
			return;
		case GR_ERROR_NOT_INITIALIZED:
            WriteLog(String::Concat(S"The GrFingerX Library is not initialized. (Error:", Convert::ToString(errorCode), ")"));
			return;
        case GR_ERROR_FAIL_LICENSE_READ:
            WriteLog(String::Concat(S"License not found. See manual for troubleshooting. (Error:", Convert::ToString(errorCode), ")"));
            MessageBox::Show("License not found. See manual for troubleshooting.");
			return;
        case GR_ERROR_NO_VALID_LICENSE:
            WriteLog(String::Concat(S"The license is not valid. See manual for troubleshooting. (Error:", Convert::ToString(errorCode), ")"));
			MessageBox::Show("The license is not valid. See manual for troubleshooting.");
			return;
		case GR_ERROR_NULL_ARGUMENT:
            WriteLog(String::Concat(S"The parameter have a null value. (Error:", Convert::ToString(errorCode), ")"));
			return;
		case GR_ERROR_FAIL:
            WriteLog(String::Concat(S"Fail to create a GDI object. (Error:", Convert::ToString(errorCode), ")"));
			return;
        case GR_ERROR_ALLOC:
            WriteLog(String::Concat(S"Fail to create a context. Cannot allocate memory. (Error:", Convert::ToString(errorCode), ")"));
			return;
        case GR_ERROR_PARAMETERS:
            WriteLog(String::Concat(S"One or more parameters are out of bound. (Error:", Convert::ToString(errorCode), ")"));
			return;
        case GR_ERROR_WRONG_USE:
            WriteLog(String::Concat(S"This function cannot be called at this time. (Error:", Convert::ToString(errorCode), ")"));
			return;
        case GR_ERROR_EXTRACT:
            WriteLog(String::Concat(S"Template Extraction failed. (Error:", Convert::ToString(errorCode), ")"));
			return;
        case GR_ERROR_SIZE_OFF_RANGE:
            WriteLog(String::Concat(S"Image is too larger or too short.  (Error:", Convert::ToString(errorCode), ")"));
			return;
        case GR_ERROR_RES_OFF_RANGE:
            WriteLog(String::Concat(S"Image have too low or too high resolution. (Error:", Convert::ToString(errorCode), ")"));
			return;
        case GR_ERROR_CONTEXT_NOT_CREATED:
            WriteLog(String::Concat(S"The Context could not be created. (Error:", Convert::ToString(errorCode), ")"));
			return;
        case GR_ERROR_INVALID_CONTEXT:
            WriteLog(String::Concat(S"The Context does not exist. (Error:", Convert::ToString(errorCode), ")"));
			return;

            // Capture error codes

        case GR_ERROR_CONNECT_SENSOR:
            WriteLog(String::Concat(S"Error while connection to sensor. (Error:", Convert::ToString(errorCode), ")"));
			return;
        case GR_ERROR_CAPTURING:
            WriteLog(String::Concat(S"Error while capturing from sensor. (Error:", Convert::ToString(errorCode), ")"));
			return;
        case GR_ERROR_CANCEL_CAPTURING:
            WriteLog(String::Concat(S"Error while stop capturing from sensor. (Error:", Convert::ToString(errorCode), ")"));
			return;
        case GR_ERROR_INVALID_ID_SENSOR:
            WriteLog(String::Concat(S"The idSensor is invalid. (Error:", Convert::ToString(errorCode), ")"));
			return;
        case GR_ERROR_SENSOR_NOT_CAPTURING:
            WriteLog(String::Concat(S"The sensor is not capturing. (Error:", Convert::ToString(errorCode), ")"));
			return;
        case GR_ERROR_INVALID_EXT:
            WriteLog(String::Concat(S"The File have a unknown extension. (Error:", Convert::ToString(errorCode), ")"));
			return;
        case GR_ERROR_INVALID_FILENAME:
            WriteLog(String::Concat(S"The filename is invalid. (Error:", Convert::ToString(errorCode), ")"));
			return;
        case GR_ERROR_INVALID_FILETYPE:
            WriteLog(String::Concat(S"The file type is invalid. (Error:", Convert::ToString(errorCode), ")"));
			return;
        case GR_ERROR_SENSOR:
            WriteLog(String::Concat(S"The sensor raise an error. (Error:", Convert::ToString(errorCode), ")"));
			return;

			// Our error codes

		case ERR_INVALID_TEMPLATE:
			WriteLog(String::Concat(S"Invalid Template. (Error:", Convert::ToString(errorCode), ")"));
			return;
		case ERR_INVALID_ID:
			WriteLog(String::Concat(S"Invalid ID. (Error:", Convert::ToString(errorCode), ")"));
			return;
		case ERR_CANT_OPEN_BD:
			WriteLog(String::Concat(S"Unable to connect to DataBase. (Error:", Convert::ToString(errorCode), ")"));
			return;

		default:
			WriteLog(String::Concat(S"Error:", Convert::ToString(errorCode)));
			return;
	}//END
}

// Check if we have a valid template
bool Util::TemplateIsValid() {
  // Check the template size and data
  return ((_tpt->_size > 0) && (_tpt->_tpt != NULL));
}

// -----------------------------------------------------------------------------------
// Main functions for fingerprint recognition management
// -----------------------------------------------------------------------------------

// Initializes the GrFinger ActiveX and all necessary utilities.
int Util::Initialize(AxInterop::GrFingerXLib::AxGrFingerXCtrl *grfingerx) {
  int result;

  _grfingerx = grfingerx;
  //Check the DataBase Class.  
  if (_DB == NULL)
    _DB = new DBClass();
  //Open the DataBase
  if(_DB->openDB()==false) {	  
	  return ERR_CANT_OPEN_BD;
  }

  //Create a new Template
  if (_tpt == NULL)
    _tpt = new TTemplate();

  //Create a new raw image
  if (_raw == NULL)
    _raw = new TRawImage();

  //Initialize the library
  result = _grfingerx->Initialize();
  if (result < 0) return (int)result;
  return _grfingerx->CapInitialize();
}

//  Finalizes the library and close the DB.
void Util::FinalizeUtil() {
  // finalize the library
  _grfingerx->Finalize();
  _grfingerx->CapFinalize();
  // close DB
  _DB->closeDB();
  if (_tpt) {
    delete _tpt;
    _tpt = NULL;
  }
  if (_DB) {
    delete _DB;
    _DB = NULL;
  }
}

// Display the fingerprint image on screen
void Util::PrintBiometricDisplay(bool biometricDisplay , int context) {
  // handle to finger image
  stdole::IPictureDisp *handle;

  // screen HDC
  Graphics *g = _btEnroll->CreateGraphics();
  IntPtr hdc = g->GetHdc();

  if (biometricDisplay) {
	  // get image with biometric info
	  _grfingerx->BiometricDisplay(&_tpt->_tpt, &_raw->img, _raw->width, _raw->height, _raw->Res, hdc.ToInt32(), &handle, context);
  } else {
	  // get raw image
	  _grfingerx->CapRawImageToHandle(&_raw->img, _raw->width, _raw->height, hdc.ToInt32(), &handle);
  }
  // draw image on picture box
  if (handle != NULL) {
	Image *curImage = System::Drawing::Image::FromHbitmap(handle->Handle);
    _pbPic->Image = curImage;
	_pbPic->Update();
  }

  // release screen HDC
  g->ReleaseHdc(hdc);
}

// Add a fingerprint template to the database
int Util::Enroll() {
	int id;
	// Checks if template is valid.
	if (TemplateIsValid()){
		// Adds the template to the database and returns the ID.
		_DB->addTemplate(_tpt, &id);
		return id;
	} else {
		return -1;
	}
}

// Extract a fingerprint template from the current image
int Util::ExtractTemplate() {
  int result;

  // set current buffer size for the extract template
  _tpt->_size = GR_MAX_SIZE_TEMPLATE;
  result = _grfingerx->Extract(&_raw->img, _raw->width, _raw->height, _raw->Res, &_tpt->_tpt,
                        &_tpt->_size, GR_DEFAULT_CONTEXT);
  // if error, set template size to 0
  if (result < 0){
    // Result < 0 => extraction problem
    _tpt->_size = 0;
  }
  return result;
}

// Identify the current fingerprint on our database
int Util::Identify(int &score) {
  int result, id;
  OleDbDataReader *rs;
  TTemplate *tptRef;

  // Checking if the template is valid.
  if(!TemplateIsValid())
    return ERR_INVALID_TEMPLATE;
  // Starting the identification process and supplying the query template.
  result = _grfingerx->IdentifyPrepare(&_tpt->_tpt, GR_DEFAULT_CONTEXT);
  // error?
  if(result < 0) return result;
  // Getting the enrolled templates from the database.
  rs = _DB->getTemplates();
  while(rs->Read()){
    // Getting the current template from the recordset.
    tptRef = _DB->getTemplate(rs);

    // Comparing the current template.
    result = _grfingerx->Identify(&tptRef->_tpt, &score, GR_DEFAULT_CONTEXT);
    
    // Checking if the query template and the reference template match.
    if(result == GR_MATCH){
      id = _DB->getId(rs);
      rs->Close();
      return id;
    }
    else if (result < 0){
	  rs->Close();
      return result;
    }
  }

  // Closing the recordset.
  rs->Close();
  return GR_NOT_MATCH;
}

// Check the current fingerprint against another one in our database
int Util::Verify(int id, int *score) {
  TTemplate *tptRef;
  int result;
  
  // Checking if the template is valid.
  if(!TemplateIsValid()) return ERR_INVALID_TEMPLATE;

  // Getting the template with the supplied ID from the database.
  tptRef = _DB->getTemplate(id);

  // Checking if the ID was found.
  if ((tptRef->_tpt == NULL) || (tptRef->_size == 0)){
	  return ERR_INVALID_ID;
  }

  // Comparing the templates.
  result = _grfingerx->Verify(&_tpt->_tpt, &tptRef->_tpt, score, GR_DEFAULT_CONTEXT);
  return result;
}

// Show GrFinger version and type
void Util::MessageVersion() {
	unsigned char majorVersion=0, minorVersion=0;
	String *vStr = new String("");

	int result = _grfingerx->GetGrFingerVersion(&majorVersion, &minorVersion);
	if (result == GRFINGER_FULL)
		vStr = new String("FULL");
	else if(result == GRFINGER_LIGHT)
		vStr = new String("LIGHT");
	else if(result == GRFINGER_FREE)
		vStr = new String("FREE");

	MessageBox::Show(
		System::String::Concat(
			System::String::Concat("The GrFinger DLL version is ",
				Convert::ToString(majorVersion) , "." , Convert::ToString(minorVersion)),
			System::String::Concat(". \n",
				"The license type is '", vStr, "'.")
		),
		"GrFinger Version"
	);

}