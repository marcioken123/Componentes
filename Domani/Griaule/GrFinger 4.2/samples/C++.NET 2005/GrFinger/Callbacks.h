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
// Callback routines
// -----------------------------------------------------------------------------------

// Consumes data from a status event.
void Util::StatusEventHandler(char* idSensor, GRCAP_STATUS_EVENTS event) {
// Signaling that a status event occurred.
	WriteEvent(idSensor, event);
	if (event == GR_PLUG) {
		// Start capturing from plugged sensor.
		GrCapStartCapture(idSensor, myFingerCallBack, myImageCallBack);
	} else if (event == GR_UNPLUG) {
		// Stop capturing from unplugged sensor
		GrCapStopCapture(idSensor);
	}
}

// Consumes data that came from finger event.
void Util::FingerEventHandler(char* idSensor, GRCAP_FINGER_EVENTS event) {
	// Just signals that a finger event ocurred.
	WriteEvent(idSensor, event);
}

// Consumes data that came from an image event.
void Util::ImageEventHandler(char* idSensor, unsigned int width, unsigned int height, unsigned char* rawImage, int res) {
	// Copying aquired image
	memcpy(_raw.img, rawImage, width*height);
	_raw.height = height;
	_raw.width = width;
	_raw.Res = res;
	isThereAnImage = true;

	// Signaling that an image event occurred.
	WriteEvent(idSensor, GR_IMAGE);

	// display fingerprint image
	PrintBiometricDisplay(false, GR_DEFAULT_CONTEXT);

	// now we have a fingerprint, so we can extract template
	_btEnroll->Enabled = false;
	_btExtract->Enabled = true;
	_btIdentify->Enabled = false;
	_btVerify->Enabled = false;
	
	// extracting template from image
	if (_cbAutoExtract->Checked) _btExtract->PerformClick();
	// identify fingerprint
	if (_cbAutoIdentify->Checked) _btIdentify->PerformClick();
}
