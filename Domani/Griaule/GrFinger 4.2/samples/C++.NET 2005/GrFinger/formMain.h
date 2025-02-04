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
// GUI routines: main form
// -----------------------------------------------------------------------------------

#pragma once

#include "util.h"
#include "formOptions.h"
#include "inputBox.h"
#include "GrFinger.h"

//we'll use .NET MessageBox
#ifdef MessageBox
#undef MessageBox
#endif

using namespace System;
using namespace System::ComponentModel;
using namespace System::Collections;
using namespace System::Windows::Forms;
using namespace System::Data;
using namespace System::Drawing;
using namespace System::Runtime::InteropServices;

namespace GrFingerSampleCPPdotNET2005
{
	public __gc class formMain : public System::Windows::Forms::Form
	{
	public: 
		formMain(void)
		{
			InitializeComponent();
		}
        
	private: System::Windows::Forms::Button *  btExtract;
	private: System::Windows::Forms::Button *  btIdentify;
	private: System::Windows::Forms::Button *  btVerify;
			 System::Windows::Forms::CheckBox *  cbAutoIdentify;

	protected: 
		void Dispose(Boolean disposing)
		{
			if (disposing && components)
			{
				components->Dispose();
			}
			__super::Dispose(disposing);
		}
	private: System::Windows::Forms::Button *  btEnroll;


	private: System::Windows::Forms::Button *  btNExtract;
	private: System::Windows::Forms::CheckBox *  cbAutoExtract;
	private: System::Windows::Forms::MainMenu *  mainMenu;
	private: System::Windows::Forms::MenuItem *  mnImage;
	private: System::Windows::Forms::MenuItem *  mnOptions;
	private: System::Windows::Forms::MenuItem *  mnImgSave;
	private: System::Windows::Forms::MenuItem *  mnImgLoad;

	private: System::Windows::Forms::Button *  btClearDB;
	private: System::Windows::Forms::Button *  btClearLog;

	private: System::Windows::Forms::PictureBox *  pbImg;
	private: System::Windows::Forms::OpenFileDialog *  ofdImage;
	private: System::Windows::Forms::SaveFileDialog *  sfdImage;

	private: System::Windows::Forms::MenuItem *  mnVersion;
	private: System::Windows::Forms::ListBox *  lbLog;
	private: System::ComponentModel::IContainer*  components;

	private:


// workaround for C++.NET bug KB888267, step 1 of 2
#ifdef GetObject
#pragma message("Undefine the GetObject function for your managed code.")
#pragma push_macro("GetObject")
#undef GetObject
#endif

		void InitializeComponent(void)
		{
			this->components = (new System::ComponentModel::Container());
			System::ComponentModel::ComponentResourceManager*  resources = (new System::ComponentModel::ComponentResourceManager(__typeof(formMain)));
			this->mainMenu = (new System::Windows::Forms::MainMenu(this->components));
			this->mnImage = (new System::Windows::Forms::MenuItem());
			this->mnImgSave = (new System::Windows::Forms::MenuItem());
			this->mnImgLoad = (new System::Windows::Forms::MenuItem());
			this->mnOptions = (new System::Windows::Forms::MenuItem());
			this->mnVersion = (new System::Windows::Forms::MenuItem());
			this->pbImg = (new System::Windows::Forms::PictureBox());
			this->btEnroll = (new System::Windows::Forms::Button());
			this->btIdentify = (new System::Windows::Forms::Button());
			this->btVerify = (new System::Windows::Forms::Button());
			this->btClearDB = (new System::Windows::Forms::Button());
			this->btClearLog = (new System::Windows::Forms::Button());
			this->cbAutoIdentify = (new System::Windows::Forms::CheckBox());
			this->cbAutoExtract = (new System::Windows::Forms::CheckBox());
			this->ofdImage = (new System::Windows::Forms::OpenFileDialog());
			this->sfdImage = (new System::Windows::Forms::SaveFileDialog());
			this->lbLog = (new System::Windows::Forms::ListBox());
			this->btExtract = (new System::Windows::Forms::Button());
			(__try_cast<System::ComponentModel::ISupportInitialize*  >(this->pbImg))->BeginInit();
			this->SuspendLayout();
			// 
			// mainMenu
			// 
			System::Windows::Forms::MenuItem* __mcTemp__1[] = new System::Windows::Forms::MenuItem*[3];
			__mcTemp__1[0] = this->mnImage;
			__mcTemp__1[1] = this->mnOptions;
			__mcTemp__1[2] = this->mnVersion;
			this->mainMenu->MenuItems->AddRange(__mcTemp__1);
			// 
			// mnImage
			// 
			this->mnImage->Index = 0;
			System::Windows::Forms::MenuItem* __mcTemp__2[] = new System::Windows::Forms::MenuItem*[2];
			__mcTemp__2[0] = this->mnImgSave;
			__mcTemp__2[1] = this->mnImgLoad;
			this->mnImage->MenuItems->AddRange(__mcTemp__2);
			this->mnImage->Text = S"&Image";
			// 
			// mnImgSave
			// 
			this->mnImgSave->Index = 0;
			this->mnImgSave->Shortcut = System::Windows::Forms::Shortcut::CtrlS;
			this->mnImgSave->Text = S"&Save...";
			this->mnImgSave->Click += new System::EventHandler(this, &formMain::mnImgSave_Click);
			// 
			// mnImgLoad
			// 
			this->mnImgLoad->Index = 1;
			this->mnImgLoad->Shortcut = System::Windows::Forms::Shortcut::CtrlL;
			this->mnImgLoad->Text = S"&Load from file...";
			this->mnImgLoad->Click += new System::EventHandler(this, &formMain::mnImgLoad_Click);
			// 
			// mnOptions
			// 
			this->mnOptions->Index = 1;
			this->mnOptions->Text = S"&Options...";
			this->mnOptions->Click += new System::EventHandler(this, &formMain::mnOptions_Click);
			// 
			// mnVersion
			// 
			this->mnVersion->Index = 2;
			this->mnVersion->Text = S"&Version";
			this->mnVersion->Click += new System::EventHandler(this, &formMain::mnVersion_Click);
			// 
			// pbImg
			// 
			this->pbImg->BorderStyle = System::Windows::Forms::BorderStyle::Fixed3D;
			this->pbImg->Location = System::Drawing::Point(8, 8);
			this->pbImg->Name = S"pbImg";
			this->pbImg->Size = System::Drawing::Size(392, 424);
			this->pbImg->SizeMode = System::Windows::Forms::PictureBoxSizeMode::StretchImage;
			this->pbImg->TabIndex = 0;
			this->pbImg->TabStop = false;
			// 
			// btEnroll
			// 
			this->btEnroll->Enabled = false;
			this->btEnroll->Location = System::Drawing::Point(408, 176);
			this->btEnroll->Name = S"btEnroll";
			this->btEnroll->Size = System::Drawing::Size(96, 24);
			this->btEnroll->TabIndex = 2;
			this->btEnroll->Text = S"Enroll";
			this->btEnroll->Click += new System::EventHandler(this, &formMain::btEnroll_Click);
			// 
			// btIdentify
			// 
			this->btIdentify->Enabled = false;
			this->btIdentify->Location = System::Drawing::Point(408, 208);
			this->btIdentify->Name = S"btIdentify";
			this->btIdentify->Size = System::Drawing::Size(96, 24);
			this->btIdentify->TabIndex = 2;
			this->btIdentify->Text = S"Identify";
			this->btIdentify->Click += new System::EventHandler(this, &formMain::btIdentify_Click);
			// 
			// btVerify
			// 
			this->btVerify->Enabled = false;
			this->btVerify->Location = System::Drawing::Point(408, 240);
			this->btVerify->Name = S"btVerify";
			this->btVerify->Size = System::Drawing::Size(96, 24);
			this->btVerify->TabIndex = 2;
			this->btVerify->Text = S"Verify";
			this->btVerify->Click += new System::EventHandler(this, &formMain::btVerify_Click);
			// 
			// btClearDB
			// 
			this->btClearDB->Location = System::Drawing::Point(408, 336);
			this->btClearDB->Name = S"btClearDB";
			this->btClearDB->Size = System::Drawing::Size(96, 24);
			this->btClearDB->TabIndex = 2;
			this->btClearDB->Text = S"Clear database";
			this->btClearDB->Click += new System::EventHandler(this, &formMain::btClearDB_Click);
			// 
			// btClearLog
			// 
			this->btClearLog->Location = System::Drawing::Point(408, 368);
			this->btClearLog->Name = S"btClearLog";
			this->btClearLog->Size = System::Drawing::Size(96, 24);
			this->btClearLog->TabIndex = 2;
			this->btClearLog->Text = S"Clear log";
			this->btClearLog->Click += new System::EventHandler(this, &formMain::btClearLog_Click);
			// 
			// cbAutoIdentify
			// 
			this->cbAutoIdentify->Location = System::Drawing::Point(408, 400);
			this->cbAutoIdentify->Name = S"cbAutoIdentify";
			this->cbAutoIdentify->Size = System::Drawing::Size(88, 16);
			this->cbAutoIdentify->TabIndex = 3;
			this->cbAutoIdentify->Text = S"Auto identify";
			// 
			// cbAutoExtract
			// 
			this->cbAutoExtract->Checked = true;
			this->cbAutoExtract->CheckState = System::Windows::Forms::CheckState::Checked;
			this->cbAutoExtract->Location = System::Drawing::Point(408, 419);
			this->cbAutoExtract->Name = S"cbAutoExtract";
			this->cbAutoExtract->Size = System::Drawing::Size(88, 16);
			this->cbAutoExtract->TabIndex = 4;
			this->cbAutoExtract->Text = S"Auto Extract";
			// 
			// ofdImage
			// 
			this->ofdImage->DefaultExt = S"*.bmp";
			this->ofdImage->Filter = S"Bitmap Files (*.bmp)|*.bmp|All Files (*.*)|*.*";
			// 
			// sfdImage
			// 
			this->sfdImage->DefaultExt = S"*.bmp";
			this->sfdImage->Filter = S"Bitmap Files (*.bmp)|*.bmp";
			// 
			// lbLog
			// 
			this->lbLog->Location = System::Drawing::Point(8, 440);
			this->lbLog->Name = S"lbLog";
			this->lbLog->ScrollAlwaysVisible = true;
			this->lbLog->Size = System::Drawing::Size(496, 108);
			this->lbLog->TabIndex = 6;
			// 
			// btExtract
			// 
			this->btExtract->Enabled = false;
			this->btExtract->Location = System::Drawing::Point(408, 272);
			this->btExtract->Name = S"btExtract";
			this->btExtract->Size = System::Drawing::Size(96, 24);
			this->btExtract->TabIndex = 7;
			this->btExtract->Text = S"Extract template";
			this->btExtract->Click += new System::EventHandler(this, &formMain::btExtract_Click);
			// 
			// formMain
			// 
			this->AutoScaleBaseSize = System::Drawing::Size(5, 13);
			this->ClientSize = System::Drawing::Size(514, 555);
			this->Controls->Add(this->btExtract);
			this->Controls->Add(this->lbLog);
			this->Controls->Add(this->cbAutoExtract);
			this->Controls->Add(this->cbAutoIdentify);
			this->Controls->Add(this->btEnroll);
			this->Controls->Add(this->pbImg);
			this->Controls->Add(this->btIdentify);
			this->Controls->Add(this->btVerify);
			this->Controls->Add(this->btClearDB);
			this->Controls->Add(this->btClearLog);
			this->FormBorderStyle = System::Windows::Forms::FormBorderStyle::FixedSingle;
			this->Icon = (__try_cast<System::Drawing::Icon*  >(resources->GetObject(S"$this.Icon")));
			this->Location = System::Drawing::Point(408, 272);
			this->MaximizeBox = false;
			this->Menu = this->mainMenu;
			this->Name = S"formMain";
			this->StartPosition = System::Windows::Forms::FormStartPosition::CenterScreen;
			this->Text = S"GrFinger - Sample application - C++ .NET 2005";
			this->Closing += new System::ComponentModel::CancelEventHandler(this, &formMain::formMain_Closing);
			this->Load += new System::EventHandler(this, &formMain::formMain_Load);
			(__try_cast<System::ComponentModel::ISupportInitialize*  >(this->pbImg))->EndInit();
			this->ResumeLayout(false);

		}		




// workaround for C++.NET bug KB888267, step 2 of 2
#ifndef GetObject
#pragma message( "Redefine the GetObject function to the unmanaged code definition.")
#pragma pop_macro("GetObject")
#endif

private: Util *_iface;
private: formOptions *optionsDialog;

// Application startup code
private: System::Void formMain_Load(System::Object *  sender, System::EventArgs *  e){
  int err;

  // initialize util class
  _iface = new Util(lbLog, pbImg, btEnroll, btExtract, btIdentify,
					btVerify, cbAutoExtract, cbAutoIdentify);
  // create options dialog
  optionsDialog = new formOptions();

  // Initialize GrFingerX Library
  err = _iface->Initialize();
  // print result in log
  if (err < 0) {
	_iface->WriteError(err);
  } else {
    _iface->WriteLog("**GrFinger Initialized Successfull**");
  }
}

// Application finalization code
private: System::Void formMain_Closing(System::Object *  sender, System::ComponentModel::CancelEventArgs *  e) {
  _iface->FinalizeUtil();
}

// Add a fingerprint to the database
private: System::Void btEnroll_Click(System::Object *  sender, System::EventArgs *  e){
 int id;

  // add fingerprint
  id = _iface->Enroll();
  // write the result to the log
  if (id >= 0) {
	_iface->WriteLog(String::Concat("Fingerprint enrolled with id = ", Convert::ToString(id)));
  } else {
	_iface->WriteLog("Error: Fingerprint not enrolled");
  }
}

// Check a fingerprint
private: System::Void btVerify_Click(System::Object *  sender, System::EventArgs *  e) {
  int ret, score;
  String *sid;

  // ask the target fingerprint ID
  score = 0;
  sid = InputBox::ShowModal("Enter the ID to verify", "Verify", "");
  if (!sid->Equals("")) {
    // compare the fingerprints
	ret = _iface->Verify(Convert::ToInt32(sid), &score);
    // write the result to the log
	if (ret < 0) {
      _iface->WriteError(ret);
	} else {
		if (ret == GR_NOT_MATCH) {
			_iface->WriteLog(String::Concat(S"Did not match with score = ", Convert::ToString(score)));
		} else {
          _iface->WriteLog(String::Concat(S"Matched with score = ", Convert::ToString(score)));
          // if they match, display the matching minutiae/segments/directions
          _iface->PrintBiometricDisplay(true, GR_DEFAULT_CONTEXT);
		}
    }
  }
}

// Identify a fingerprint
private: System::Void btIdentify_Click(System::Object *  sender, System::EventArgs *  e) {
  int ret, score;

  score = 0;
  // identify it
  ret = _iface->Identify(score);
  // write the result to the log
  if (ret > 0) {
      _iface->WriteLog(
	  String::Concat(S"Fingerprint identified. ID = ",
					  Convert::ToString(ret),
					  S". Score = ",
					  Convert::ToString(score),
					  S"."
	  ));
	  _iface->PrintBiometricDisplay(true, GR_DEFAULT_CONTEXT);
  } else {
	  if (ret == 0) {
		  _iface->WriteLog("Fingerprint not Found.");
	  } else {
		  _iface->WriteError(ret);
	  }
  }
}

// Extract a template from a fingerprint image
private: System::Void btExtract_Click(System::Object *  sender, System::EventArgs *  e) {
  int ret;

  // extract the template
  ret = _iface->ExtractTemplate();
  // write the template quality to the log
  if (ret == GR_BAD_QUALITY) {
   _iface->WriteLog("Template extracted successfully. Bad quality.");
  } else if (ret == GR_MEDIUM_QUALITY) {
   _iface->WriteLog("Template extracted successfully. Medium quality.");
  } else if (ret == GR_HIGH_QUALITY) {
   _iface->WriteLog("Template extracted successfully. High quality.");
  }
  if (ret >= 0) {
    // if no error, display the minutiae/segments/directions into the image
    _iface->PrintBiometricDisplay(true, GR_NO_CONTEXT);
    // enable the operations we can do over the extracted template
    this->btExtract->Enabled = false;
    this->btEnroll->Enabled = true;
    this->btIdentify->Enabled = true;
    this->btVerify->Enabled = true;
  } else {
    // write the error to the log
    _iface->WriteError(ret);
  }
}

// Clear the database
private: System::Void btClearDB_Click(System::Object *  sender, System::EventArgs *  e){
  // clear database
  _iface->_DB->clearDB();
  // write the result to the log
  _iface->WriteLog("Database is clear...");
}

// Clear the log
private: System::Void btClearLog_Click(System::Object *  sender, System::EventArgs *  e){
  lbLog->Items->Clear();
}

// Save fingerprint image to a file
private: System::Void mnImgSave_Click(System::Object *  sender, System::EventArgs *  e) {
  // we need an image
  if(!_iface->isThereAnImage){
    MessageBox::Show("There is no image to save.");
    return;
  }  
  // open "save" dialog
  sfdImage->Filter = "BMP files (*.bmp)|*.bmp|All files (*.*)|*.*";
  sfdImage->FilterIndex = 1;
  sfdImage->RestoreDirectory = true;

  // save the image
  if(sfdImage->ShowDialog() == DialogResult::OK){
    char *temp = (char*)Marshal::StringToHGlobalAnsi(sfdImage->FileName).ToPointer();
	if (GrCapSaveRawImageToFile(_iface->_raw.img, _iface->_raw.width, _iface->_raw.height, temp, GRCAP_IMAGE_FORMAT_BMP) != GR_OK) {
	  _iface->WriteLog("Fail to save the file.");
	}
    Marshal::FreeHGlobal((int)temp);
  }
}

// Load a fingerprint image from a file
private: System::Void mnImgLoad_Click(System::Object *  sender, System::EventArgs *  e) {
  // open "load" dialog
  sfdImage->Filter = "BMP files (*.bmp)|*.bmp|All files (*.*)|*.*";
  sfdImage->FilterIndex = 1;
  sfdImage->RestoreDirectory = true;

  // load the image
  if (ofdImage->ShowDialog() == DialogResult::OK){
	// Getting the resolution.
	  String* res = InputBox::ShowModal("What is the image resolution?", "Resolution", "");
	  if(!res->Equals(""))
	  {
		  int resolution = Convert::ToInt32(res);
		  // Checking if the action was canceled, no value or an invalid value was entered.
   		  if (resolution != 0) {
			char *temp = (char*)Marshal::StringToHGlobalAnsi(ofdImage->FileName).ToPointer();
			if (GrCapLoadImageFromFile(temp, resolution) != GR_OK) {
				_iface->WriteLog("Fail to load the file.");
			}
			Marshal::FreeHGlobal((int)temp);
		  }
	  }	  	
  }
}

// Open the "Options" window
private: System::Void mnOptions_Click(System::Object *  sender, System::EventArgs *  e) {
  int ret, thresholdId, rotationMaxId;
  int thresholdVr, rotationMaxVr;
  int minutiaeColor, minutiaeMatchColor;
  int segmentsColor, segmentsMatchColor;
  int directionsColor, directionsMatchColor;
  bool ok;

  for (;;) {
    // get current identification/verification parameters
    GrGetIdentifyParameters(thresholdId, rotationMaxId, GR_DEFAULT_CONTEXT);
    GrGetVerifyParameters(thresholdVr, rotationMaxVr, GR_DEFAULT_CONTEXT);
    // set current identification/verification parameters on options form
    optionsDialog->setParameters(thresholdId, rotationMaxId, thresholdVr, rotationMaxVr);

    // show form with match, display and colors options
    if (optionsDialog->ShowDialog() != DialogResult::OK) return;
    ok = true;
    // get the new parameters 
    optionsDialog->getParameters(&thresholdId, &rotationMaxId, &thresholdVr, &rotationMaxVr,
                        &minutiaeColor, &minutiaeMatchColor, &segmentsColor, &segmentsMatchColor,
						&directionsColor, &directionsMatchColor);
    if ((thresholdId < GR_MIN_THRESHOLD) || (thresholdId > GR_MAX_THRESHOLD) ||
	   (rotationMaxId < GR_ROT_MIN) || (rotationMaxId > GR_ROT_MAX)) {
		   MessageBox::Show("Invalid identify parameters values!");
		   ok = false;
    }
    if ((thresholdVr < GR_MIN_THRESHOLD) || (thresholdVr > GR_MAX_THRESHOLD) ||
	   (rotationMaxVr < GR_ROT_MIN) || (rotationMaxVr > GR_ROT_MAX)) {
		   MessageBox::Show("Invalid verify parameters values!");
		   ok = false;
    }
    // set the new identification parameters
    if (ok) {
      ret = GrSetIdentifyParameters(thresholdId, rotationMaxId, GR_DEFAULT_CONTEXT);
      // error?
	  if (ret == GR_DEFAULT_USED) {
	    MessageBox::Show("Invalid identify parameters values. Default values will be used.");
        ok = false;
	  }
      // set the new verification parameters
      ret = GrSetVerifyParameters(thresholdVr, rotationMaxVr, GR_DEFAULT_CONTEXT);
      // error?
	  if (ret == GR_DEFAULT_USED) {
	    MessageBox::Show("Invalid verify parameters values. Default values will be used.");
        ok = false;
	  }
      // if everything ok
      if (ok) {
        // accept the new parameters
        optionsDialog->acceptChanges();
        // set the new colors
        GrSetBiometricDisplayColors(minutiaeColor, minutiaeMatchColor, segmentsColor, segmentsMatchColor, directionsColor, directionsMatchColor);
        return;
	  }
    }
  }
}

// Display GrFinger version
private: System::Void mnVersion_Click(System::Object *  sender, System::EventArgs *  e) {
  _iface->MessageVersion();
}


};
}