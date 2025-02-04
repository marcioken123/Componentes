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
* Support and fingerprint management routines
* -----------------------------------------------------------------------------------

* Some constants to make our code cleaner
#INCLUDE consts.h

* -----------------------------------------------------------------------------------
* Support functions
* -----------------------------------------------------------------------------------

* Write a message to log
PROCEDURE WriteLog
	PARAMETERS message
	
	* add message
	sampleMainForm.LogList.AddItem(message)
	sampleMainForm.LogList.ListIndex = sampleMainForm.LogList.ListCount - 1
	sampleMainForm.LogList.ListIndex = - 1
ENDPROC

* Write and describe an error.
PROCEDURE WriteError
	PARAMETERS errorCode
	DO CASE 
        CASE errorCode = GR_ERROR_INITIALIZE_FAIL
            WriteLog ("Fail to Initialize GrFingerX. (Error:" + ALLTRIM(STR(errorCode)) + ")")
        CASE errorCode = GR_ERROR_NOT_INITIALIZED
            WriteLog ("The GrFingerX Library is not initialized. (Error:" + ALLTRIM(STR(errorCode)) + ")")
        CASE errorCode = GR_ERROR_FAIL_LICENSE_READ
            WriteLog ("License not found. See manual for troubleshooting. (Error:" + ALLTRIM(STR(errorCode)) + ")")
            MESSAGEBOX ("License not found. See manual for troubleshooting.")
        CASE errorCode = GR_ERROR_NO_VALID_LICENSE
            WriteLog ("The license is not valid. See manual for troubleshooting. (Error:" + ALLTRIM(STR(errorCode)) + ")")
            MESSAGEBOX ("The license is not valid. See manual for troubleshooting.")
        CASE errorCode = GR_ERROR_NULL_ARGUMENT
            WriteLog ("The parameter have a null value. (Error:" + ALLTRIM(STR(errorCode)) + ")")
        CASE errorCode = GR_ERROR_FAIL
            writeLog ("Fail to create a GDI object. (Error:" + ALLTRIM(STR(errorCode)) + ")")
        CASE errorCode = GR_ERROR_ALLOC
            writeLog ("Fail to create a context. Cannot allocate memory. (Error:" + ALLTRIM(STR(errorCode)) + ")")
        CASE errorCode = GR_ERROR_PARAMETERS
            writeLog ("One or more parameters are out of bound. (Error:" + ALLTRIM(STR(errorCode)) + ")")
        CASE errorCode = GR_ERROR_WRONG_USE
            writeLog ("This function cannot be called at this time. (Error:" + ALLTRIM(STR(errorCode)) + ")")
        CASE errorCode = GR_ERROR_EXTRACT
            writeLog ("Template Extraction failed. (Error:" + ALLTRIM(STR(errorCode)) + ")")
        CASE errorCode = GR_ERROR_SIZE_OFF_RANGE
            writeLog ("Image is too larger or too short.  (Error:" + ALLTRIM(STR(errorCode)) + ")")
        CASE errorCode = GR_ERROR_RES_OFF_RANGE
            writeLog ("Image have too low or too high resolution. (Error:" + ALLTRIM(STR(errorCode)) + ")")
        CASE errorCode = GR_ERROR_CONTEXT_NOT_CREATED
            writeLog ("The Context could not be created. (Error:" + ALLTRIM(STR(errorCode)) + ")")
        CASE errorCode = GR_ERROR_INVALID_CONTEXT
            writeLog ("The Context does not exist. (Error:" + ALLTRIM(STR(errorCode)) + ")")

            * Capture error codes

        CASE errorCode = GR_ERROR_CONNECT_SENSOR
            writeLog ("Error while connection to sensor. (Error:" + ALLTRIM(STR(errorCode)) + ")")
        CASE errorCode = GR_ERROR_CAPTURING
            writeLog ("Error while capturing from sensor. (Error:" + ALLTRIM(STR(errorCode)) + ")")
        CASE errorCode = GR_ERROR_CANCEL_CAPTURING
            writeLog ("Error while stop capturing from sensor. (Error:" + ALLTRIM(STR(errorCode)) + ")")
        CASE errorCode = GR_ERROR_INVALID_ID_SENSOR
            writeLog ("The idSensor is invalid. (Error:" + ALLTRIM(STR(errorCode)) + ")")
        CASE errorCode = GR_ERROR_SENSOR_NOT_CAPTURING
            writeLog ("The sensor is not capturing. (Error:" + ALLTRIM(STR(errorCode)) + ")")
        CASE errorCode = GR_ERROR_INVALID_EXT
            writeLog ("The File have a unknown extension. (Error:" + ALLTRIM(STR(errorCode)) + ")")
        CASE errorCode = GR_ERROR_INVALID_FILENAME
            writeLog ("The filename is invalid. (Error:" + ALLTRIM(STR(errorCode)) + ")")
        CASE errorCode = GR_ERROR_INVALID_FILETYPE
            writeLog ("The file type is invalid. (Error:" + ALLTRIM(STR(errorCode)) + ")")
        CASE errorCode = GR_ERROR_SENSOR
            writeLog ("The sensor raise an error. (Error:" + ALLTRIM(STR(errorCode)) + ")")

            * Our error codes

        CASE errorCode = ERR_INVALID_TEMPLATE
            writeLog ("Invalid Template. (Error:" + ALLTRIM(STR(errorCode)) + ")")
        CASE errorCode = ERR_INVALID_ID
            writeLog ("Invalid ID. (Error:" + ALLTRIM(STR(errorCode)) + ")")
        CASE errorCode = ERR_CANT_OPEN_BD
            writeLog ("Unable to connect to DataBase. (Error:" + ALLTRIM(STR(errorCode)) + ")")
        OTHERWISE
            writeLog ("Error:" + ALLTRIM(STR(errorCode)))
	ENDCASE
ENDPROC

* Check if we have a valid template
PROCEDURE TemplateIsValid
	* Check template size
	RETURN tpt.tptSize > 0
ENDPROC

* -----------------------------------------------------------------------------------
* Main functions for fingerprint recognition management
* -----------------------------------------------------------------------------------

* Initializes GrFinger ActiveX and all necessary utilities.
PROCEDURE InitializeGrFinger
	LOCAL err AS INTEGER
	* Set where our DB routines are
	SET PROCEDURE TO db.prg

	* Opening database
	IF OpenDB() = .F. THEN
		RETURN ERR_CANT_OPEN_BD
	ENDIF
	* Create a new Template
	tpt = CREATEOBJECT("CTemplate")
	* Create a new raw image
	raw = CREATEOBJECT("CRawImage")
	* Initializing library
	err = sampleMainForm.Grfingerx1.Initialize()
	IF err < 0 THEN
	 RETURN err
	ENDIF
	RETURN sampleMainForm.Grfingerx1.CapInitialize()
ENDPROC

* Finalizes and close the DB.
PROCEDURE FinalizeGrFinger
	LOCAL err as Integer
	* Set where our DB routines are
	SET PROCEDURE TO db.prg

	* Finalizing library
	sampleMainForm.Grfingerx1.CapFinalize()
	sampleMainForm.Grfingerx1.Finalize()
	* Close DB
	CloseDB()
ENDPROC

* Display fingerprint image on screen
PROCEDURE PrintBiometricDisplay
	PARAMETERS biometricDisplay, context
	LOCAL pic
	LOCAL tmpBmpFile AS STRING
	LOCAL i AS INTEGER
	* Importing necessary HDC functions
	DECLARE INTEGER GetDC IN user32 INTEGER ahwnd
	DECLARE INTEGER ReleaseDC IN user32 INTEGER ahwnd, INTEGER hdc 

	tmpBmpFile = SYS(2023) + "\tmpfinger.bmp"
	pic = LOADPICTURE()
	hdc = GetDC(0)
	IF biometricDisplay = .T.
		* get image with biometric info
		sampleMainForm.Grfingerx1.BiometricDisplay (CREATEBINARY(tpt.tpt), raw.img, raw.imgWidth, raw.imgHeight, raw.res, hdc, @pic, context)
	ELSE
		* get raw image
		sampleMainForm.Grfingerx1.CapRawImageToHandle (raw.img, raw.imgWidth, raw.imgHeight, hdc, @pic)
	ENDIF
	* draw image on picture box
	SAVEPICTURE(pic, tmpBmpFile)
	sampleMainForm.Image1.Picture = tmpBmpFile
	DELETE FILE tmpBmpFile
	* release screen HDC
	ReleaseDC(0, hdc)
ENDPROC

* Add a fingerprint template to database
PROCEDURE Enroll
	* Set where our DB routines are
	SET PROCEDURE TO db.prg

	* Checking if template is valid.
	IF TemplateIsValid() THEN
		* Adds template to database and gets ID.
		RETURN AddTemplate(tpt.tpt)
	ELSE
		RETURN -1
	ENDIF
ENDPROC

* Extract a fingerprint template from current image
PROCEDURE ExtractTemplate
	LOCAL ret AS INTEGER
	LOCAL ttpt AS STRING
	LOCAL ttptSize AS INTEGER
	* Use DLL function because VFP doesn't like 'byte' parameters
	DECLARE INTEGER _GrExtract@28 IN grfinger AS GrExtract STRING @, LONG, LONG, LONG, STRING @, LONG @, LONG

	* set current buffer size for extract template
	ttptSize = GR_MAX_SIZE_TEMPLATE
	ttpt = SPACE(GR_MAX_SIZE_TEMPLATE)
	ret = GrExtract(raw.img, raw.imgWidth, raw.imgHeight, raw.res, @ttpt, @ttptSize, GR_DEFAULT_CONTEXT)
	* if error, set template size to 0
	* Result < 0 => extraction problem
	IF ret < 0 THEN
		tpt.Size = 0
		tpt.tpt = ''
	ELSE
		* free unused memory
		tpt.tpt = LEFT(ttpt, ttptSize)
		tpt.tptSize = ttptSize
	ENDIF
	RETURN ret
ENDPROC

* Identify current fingerprint on our database
PROCEDURE Identify
	PARAMETERS idscore
	LOCAL ret AS INTEGER
	LOCAL i AS LONG
	LOCAL rs AS "ADODB.Recordset"
	LOCAL qtpt AS STRING
	* Use DLL function because VFP doesn't like 'byte' parameters
	DECLARE INTEGER _GrIdentifyPrepare@8 IN grfinger AS GrIdentifyPrepare STRING @, LONG
	DECLARE INTEGER _GrIdentify@12 IN grfinger AS GrIdentify STRING @, LONG @, LONG
	* Set where our DB routines are
	SET PROCEDURE TO db.prg
	
	* Checking if template is valid.
	IF TemplateIsValid() = .F. THEN
		RETURN ERR_INVALID_TEMPLATE
	ENDIF

	* Starting identification process and supplying query template.
	ret = GrIdentifyPrepare(tpt.tpt, GR_DEFAULT_CONTEXT)
	* error?
	IF RET < 0 THEN
		RETURN ret
	ENDIF
	
    * Getting enrolled templates from database.
    rs = getTemplates()
    * Iterate over all templates in database
    DO WHILE rs.EOF() = .F.
        * Getting current template from recordset.
        qtpt = rs.Fields("template").Value
        * Comparing current template.
        ret = GrIdentify(@qtpt, @idscore, GR_DEFAULT_CONTEXT)
        * Checking if query template and reference template match.
        IF ret < 0 THEN
        	RETURN ret
        ENDIF
        IF ret = GR_MATCH THEN
            i = rs.Fields("ID").Value
            rs.Close()
            RETURN i
        ENDIF
        rs.MoveNext()
    ENDDO
    * Closing recordset.
    rs.Close()
    * end of database, return "no match" code
    RETURN GR_NOT_MATCH
ENDPROC

* Performs an verification using last extracted template.
PROCEDURE Verify
	PARAMETERS idt, vrscore
	LOCAL qtpt AS STRING
	* Use DLL function because VFP doesn't like 'byte' parameters
	DECLARE INTEGER _GrVerify@16 IN grfinger AS GrVerify STRING @, STRING @, LONG @, LONG
	* Set where our DB routines are
	SET PROCEDURE TO db.prg
    
    * Checking if template is valid.
    IF TemplateIsValid() = .F. THEN
    	RETURN ERR_INVALID_TEMPLATE
    ENDIF
    * Getting template with the supplied ID from database.
    qtpt = getTemplate(idt)
    * Checking if the ID was found.
    IF LEN(qtpt) = 0 THEN
        RETURN ERR_INVALID_ID
    ENDIF
    * Comparing templates.
    RETURN GrVerify(tpt.tpt, qtpt, @vrscore, GR_DEFAULT_CONTEXT)
ENDPROC

* Show GrFinger version and type
PROCEDURE MessageVersion
	LOCAL major AS INTEGER
	LOCAL minor AS INTEGER
	LOCAL ret AS INTEGER
	LOCAL vStr AS STRING
	* Use DLL function because VFP doesn't like 'byte' parameters
	DECLARE INTEGER _GrGetGrFingerVersion@8 IN grfinger as GrGetGrFingerVersion INTEGER @, INTEGER @

	major = 0
	minor = 0
	ret = GrGetGrFingerVersion(@major, @minor)
	IF ret = GRFINGER_FULL 
		vStr = "FULL"
	ENDIF
	IF ret = GRFINGER_LIGHT 
		vStr = "LIGHT"
	ENDIF
	IF ret = GRFINGER_FREE
		vStr = "FREE"
	ENDIF
	MESSAGEBOX("The GrFinger DLL version is " + ALLTRIM(STR(major)) + "." + ALLTRIM(STR(minor)) + "." + CHR(13)+ CHR(10) + "The license type is '" + vStr + "'.", 0, "GrFinger Version")
ENDPROC

* Save fingerprint image to a file
PROCEDURE SaveImage
	LOCAL fname AS STRING

	* we need an image
	IF LEN(raw.img) = 0 THEN
		MESSAGEBOX("There is no image to save.")
		RETURN
	ENDIF
	
	* open "save" dialog
	fname = PUTFILE("Image filename:", "", "BMP files (*.bmp):*")
	* save image
	IF LEN(fname) <> 0 THEN
		IF sampleMainForm.Grfingerx1.CapSaveRawImageToFile(CREATEBINARY(raw.img), raw.imgWidth, raw.imgHeight, fname, GRCAP_IMAGE_FORMAT_BMP) <> GR_OK THEN
			WriteLog("Failed to save the file.")
		ENDIF
	ENDIF
ENDPROC

* Load a fingerprint image from a file
PROCEDURE LoadImage
	LOCAL fname AS STRING
	LOCAL res AS INTEGER
	LOCAL ress AS STRING
	
	* open "load" dialog
	fname = GETFILE("BMP files (*.bmp):BMP", "Image filename:", "Open", 0, "Load From File...")
	* load image
	IF LEN(fname) <> 0 THEN
		* Getting resolution.
		ress = INPUTBOX("What is the image resolution?", "Resolution", "")
		* Checking if action was canceled, no value or an invalid value was entered.
		IF LEN(ress)<>0 THEN
			res = VAL(ress)
			DOEVENTS FORCE
			IF sampleMainForm.Grfingerx1.CapLoadImageFromFile(fname, res) <> GR_OK THEN
				WriteLog("Failed to load the file.")
			ENDIF
		ENDIF
	ENDIF
ENDPROC

