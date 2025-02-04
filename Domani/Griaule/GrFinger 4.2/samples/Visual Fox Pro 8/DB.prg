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
* Database routines
* -----------------------------------------------------------------------------------

* Some constants to make our code cleaner
#INCLUDE consts.h

* the database we'll be connecting to
#DEFINE DBFile 		"..\..\GrFingerSample.mdb"
#DEFINE ConnecStr 	"Provider=Microsoft.Jet.OLEDB.4.0;Data Source="

* Open connection
PROCEDURE OpenDB
	LOCAL bdOpened as Boolean
	
	bdOpened = .T.
	TRY
		* Opening database
		dbConnHandle = CREATEOBJECT("ADODB.Connection")
		dbConnHandle.ConnectionString = ConnecStr + DBFile
		dbConnHandle.Open()
	CATCH
		bdOpened = .F.
	ENDTRY
	RETURN bdOpened
ENDPROC

* Close connection
PROCEDURE CloseDB
	TRY
		IF dbConnHandle.State() = adStateOpen
			dbConnHandle.Close()
		ENDIF
	CATCH
	ENDTRY
	dbConnHandle = ''
ENDPROC

* Clear database
PROCEDURE ClearDB()
    * run "clear" query
    dbConnHandle.Execute("DELETE FROM enroll")
ENDPROC

* Add template to database. Returns added template ID.
PROCEDURE AddTemplate
	PARAMETERS template
	LOCAL rs AS "ADODB.Recordset"
	
	rs = CREATEOBJECT("ADODB.Recordset")
	rs.Open("enroll", dbConnHandle, adOpenStatic, adLockOptimistic)
   	* Add a new row
    rs.AddNew()
    rs.Fields("template").Value = CREATEBINARY(template)
	rs.Update()
    * return ID
	RETURN rs.Fields("ID").Value
ENDPROC

* Returns a ADODB.recordset with all enrolled templates from database.
PROCEDURE getTemplates
	LOCAL rs AS "ADODB.Recordset"

	rs = CREATEOBJECT("ADODB.Recordset")
	rs.Open("select * from enroll", dbConnHandle, adOpenDynamic, adLockReadOnly)
    RETURN rs
ENDPROC

* returns template with the supplied ID.
PROCEDURE getTemplate
	PARAMETERS idt
	LOCAL rs AS "ADODB.Recordset"
	LOCAL tp AS String
	
	tp = ""
	rs = CREATEOBJECT("ADODB.Recordset")
    * Get query response
   	rs.Open("select * from enroll where ID=" + ALLTRIM(STR(idt)), dbConnHandle, adOpenDynamic, adLockReadOnly)
    * No results?
    IF NOT ((rs.EOF() = .T.) AND (rs.BOF() = .T.)) THEN
        * Deserialize template and return it
        tp = rs.Fields("template").Value
    ENDIF
    rs.Close()
    RETURN tp
ENDPROC
