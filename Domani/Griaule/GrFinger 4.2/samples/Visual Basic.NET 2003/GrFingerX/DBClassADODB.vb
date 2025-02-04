'-------------------------------------------------------------------------------
'GrFinger Sample
'(c) 2005 Griaule Tecnologia Ltda.
'http://www.griaule.com
'-------------------------------------------------------------------------------
'
'This sample is provided with "GrFinger Fingerprint Recognition Library" and
'can't run without it. It's provided just as an example of using GrFinger
'Fingerprint Recognition Library and should not be used as basis for any
'commercial product.
'
'Griaule Tecnologia makes no representations concerning either the merchantability
'of this software or the suitability of this sample for any particular purpose.
'
'THIS SAMPLE IS PROVIDED BY THE AUTHOR "AS IS" AND ANY EXPRESS OR
'IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES
'OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.
'IN NO EVENT SHALL GRIAULE BE LIABLE FOR ANY DIRECT, INDIRECT,
'INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
'NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
'DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
'THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
'(INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
'THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
'
'You can download the free version of GrFinger directly from Griaule website.
'
'These notices must be retained in any copies of any part of this
'documentation and/or sample.
'
'-------------------------------------------------------------------------------

' -----------------------------------------------------------------------------------
' Database routines
' -----------------------------------------------------------------------------------

'It's necessary Add Reference... to use ADODB:
' Microsoft ADO Data Control
' Microsoft ADO Ext 2.7
Imports ADODB

Imports System.Data.OleDb
Imports System.Runtime.InteropServices

' Template data
Public Class TTemplate
	' Template itself
    Public tpt(GrFingerXLib.GRConstants.GR_MAX_SIZE_TEMPLATE) As Byte
	' Template size
	Public Size As Long
End Class

' Template list
Public Structure TTemplates
	' ID
	Public ID As Integer
	' Template itself
	Public template As TTemplate
End Structure

Public Class DBClass

    ' the database we'll be connecting to
    Const DBFile = "GrFingerSample.mdb"
    Const ConnectionString = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source="

    ' the connection object
    Dim connection As New ADODB.Connection

    ' Open connection
    Public Function OpenDB() As Boolean
        On Error GoTo cantopen
        connection.Open(ConnectionString & Application.StartupPath() & "\" & DBFile)
        OpenDB = True
        Exit Function
cantopen:
        On Error GoTo 0
        OpenDB = False
    End Function

    ' Close conection
    Public Sub closeDB()
        If connection.State <> 0 Then connection.Close()
    End Sub

    ' Clear database
    Public Sub clearDB()
        ' run "clear" query
        connection.Execute("DELETE FROM enroll")
    End Sub

    ' Add template to database. Returns added template ID.
    Public Function AddTemplate(ByRef template As TTemplate) As Long
        Dim rs As New ADODB.Recordset
        rs.Open("enroll", connection, ADODB.CursorTypeEnum.adOpenStatic, ADODB.LockTypeEnum.adLockOptimistic)
        ' Add a new row.
        rs.AddNew()
        rs("template").Value = template.tpt

        rs.Update()
        ' return ID
        AddTemplate = rs("ID").Value
    End Function

    ' Returns a ADODB.recordset with all enrolled templates from database.
    Public Function getTemplates() As TTemplates()
        Dim rs As New ADODB.Recordset
        rs.Open("select * from enroll", connection, ADODB.CursorTypeEnum.adOpenDynamic, ADODB.LockTypeEnum.adLockReadOnly)
        Dim tpt(rs.Fields.Count) As TTemplates
        Dim i As Integer = 0
        Do Until rs.EOF
            'Asseguring that tpt.Length is greater os equal then i
            If i >= tpt.Length Then ReDim tpt(i + 1)
            ' Getting current template from recordset.
            tpt(i).ID = rs("ID").Value
            tpt(i).template = New TTemplate
            tpt(i).template.tpt = rs("template").Value
            tpt(i).template.Size = tpt(i).template.tpt.Length

            ' If it's not a valid template, skip it
            rs.MoveNext()
            i = i + 1
        Loop

        getTemplates = tpt
    End Function

    ' returns template with the supplied ID.
    Public Function getTemplate(ByVal id As Long) As Byte()
        Dim rs As New ADODB.Recordset
        ' Get query response
        rs.Open("select * from enroll where ID = " & id, connection, ADODB.CursorTypeEnum.adOpenDynamic, ADODB.LockTypeEnum.adLockReadOnly)
        ' No results?
        If rs.EOF And rs.BOF Then
            Dim tptVazio(0) As Byte
            rs.Close()
            getTemplate = tptVazio
        Else
            ' Deserialize template and return it
            Dim tpt() As Byte
            tpt = rs("template").Value
            rs.Close()
            getTemplate = tpt
        End If
    End Function


End Class
