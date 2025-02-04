*-------------------------------------------------------------------------------
*GrFinger Sample
*(c) 2005 Griaule Tecnologia Ltda.
*http://www.griaule.com
*-------------------------------------------------------------------------------
*
*This sample is provided for use with "GrFinger Fingerprint Recognition Library"
*and can't run without it. It's provided just as an example of using GrFinger
*Fingerprint Recognition Library and should not be used as basis for any
*commercial product.
*
*Griaule Tecnologia makes no representations concerning either the merchantability
*of this software or the suitability of this sample for any particular purpose.
*
*THIS SAMPLE IS PROVIDED BY THE AUTHOR "AS IS" AND ANY EXPRESS OR
*IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES
*OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.
*IN NO EVENT SHALL GRIAULE BE LIABLE FOR ANY DIRECT, INDIRECT,
*INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
*NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
*DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
*THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
*(INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
*THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*
*You can download the free version of GrFinger directly from Griaule website.
*
*These notices must be retained in any copies of any part of this
*documentation and/or sample.
*
*-------------------------------------------------------------------------------

* -----------------------------------------------------------------------------------
* Main program
* -----------------------------------------------------------------------------------

* Database connection
PUBLIC dbConnHandle AS "ADODB.Connection"

* The last acquired image.
PUBLIC raw

* The template extracted from last acquired image.
PUBLIC tpt

* Sample main form
PUBLIC sampleMainForm AS Form

* Biometric display colors
PUBLIC minutiaeColor AS INTEGER
PUBLIC minutiaeMatchColor AS INTEGER
PUBLIC segmentsColor AS INTEGER
PUBLIC segmentsMatchColor AS INTEGER
PUBLIC directionsColor AS INTEGER
PUBLIC directionsMatchColor AS INTEGER
PUBLIC bShowMinutiae AS INTEGER
PUBLIC bShowMinutiaeMatch AS INTEGER
PUBLIC bShowSegments AS INTEGER
PUBLIC bShowSegmentsMatch AS INTEGER
PUBLIC bShowDirections AS INTEGER
PUBLIC bShowDirectionsMatch AS INTEGER

* Initialize biometric display colors
minutiaeColor = 255
minutiaeMatchColor = 8388736
segmentsColor = 65280
segmentsMatchColor = 8388736
directionsColor = 16711680
directionsMatchColor = 8388736
bShowMinutiae = 1
bShowMinutiaeMatch = 1
bShowSegments = 1
bShowSegmentsMatch = 1
bShowDirections = 1
bShowDirectionsMatch = 1

* Open the main form
DO FORM mainForm

* Raw image data type
DEFINE CLASS CRawImage as Custom
	* Image data.
	img = ''
	* Image width.
	imgWidth = 0
	* Image height.
	imgHeight = 0
	* Image resolution.
	res = 0
ENDDEFINE

* Raw image data type
DEFINE CLASS CTemplate as Custom
	* Template itself
	tpt = .F.
	* Template size
	tptSize = 0
ENDDEFINE

