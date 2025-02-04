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

#pragma once

#include "DBClass.h"
#include "GrFinger.h"

using namespace System;
using namespace System::Drawing;
using namespace System::Windows::Forms;
using namespace System::Runtime::InteropServices;

// Raw image data type.
struct TRawImage {
	// Image data.
	unsigned char *img;
	// Image width.
	unsigned int width;
	// Image height.
	unsigned int height;
	// Image resolution.
	int Res;
};

// Some constants to make our code cleaner
#define ERR_CANT_OPEN_BD		-999
#define ERR_INVALID_ID			-998
#define ERR_INVALID_TEMPLATE	-997

__gc class Util
{
public:
	Util(ListBox *lbLog, PictureBox *pbPic,
		   Button *btEnroll, Button *btExtract, Button *btIdentify,
		   Button *btVerify, CheckBox *ckBoxAutoExtract,
		   CheckBox *ckBoxAutoIdentify);
	~Util();


	// support functions
	void WriteLog(String *msg);
	void WriteError(int err);
	void WriteEvent(String *idSensor, int eventCode);

	// fingerprint management functions
	int Initialize();
	void FinalizeUtil();
	void PrintBiometricDisplay(bool biometricDisplay , int context);
	int Enroll();
	int ExtractTemplate();
	int Identify(int &score);
	int Verify(int id, int *score);
	void MessageVersion();

	// event handlers
	void StatusEventHandler(char* idSensor, GRCAP_STATUS_EVENTS event);
	void FingerEventHandler(char* idSensor, GRCAP_FINGER_EVENTS event);
	void ImageEventHandler(char* idSensor, unsigned int width, unsigned int height, unsigned char* rawImage, int res);

	// Database class.
	DBClass *_DB;
	// The last acquired image.
	TRawImage _raw;
	//is there an image??
	bool isThereAnImage;
	// Reference to main form Image.
	PictureBox *_pbPic;


private:
	// The template extracted from last acquired image.
	TTemplate *_tpt;
	// Reference to main form log.
	ListBox *_lbLog;
	//references Main form Auto Extract Check Box
	CheckBox *_cbAutoExtract;
  	//references Main form Auto Identify Check Box
	CheckBox *_cbAutoIdentify;
	//references Main form enroll button
	Button *_btEnroll;
	//references Main form extract button
	Button *_btExtract;
	//references Main form identify button
	Button *_btIdentify;
	//references Main form verify button
	Button *_btVerify;

	// Callbacks
	StatusCallBack* myCallBack;
	FingerCallBack* myFingerCallBack;
	ImageCallBack* myImageCallBack;
	
	// GC handles
	GCHandle gchStatus;
	GCHandle gchFinger;
	GCHandle gchImage;

	bool TemplateIsValid();
};
