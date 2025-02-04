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
' GUI routines: main form
' -----------------------------------------------------------------------------------

Imports GrFingerXLib
Imports Microsoft.VisualBasic

Public Class MainForm
    Inherits System.Windows.Forms.Form

#Region " Windows Form Designer generated code "

    Public Sub New()
        MyBase.New()

        'This call is required by the Windows Form Designer.
        InitializeComponent()

        'Add any initialization after the InitializeComponent() call

    End Sub

    'Form overrides dispose to clean up the component list.
    Protected Overloads Overrides Sub Dispose(ByVal disposing As Boolean)
        If disposing Then
            If Not (components Is Nothing) Then
                components.Dispose()
            End If
        End If
        MyBase.Dispose(disposing)
    End Sub

    'Required by the Windows Form Designer
    Private components As System.ComponentModel.IContainer

    'NOTE: The following procedure is required by the Windows Form Designer
    'It can be modified using the Windows Form Designer.  
    'Do not modify it using the code editor.
    Friend WithEvents PictureBox1 As System.Windows.Forms.PictureBox
    Friend WithEvents MainMenu1 As System.Windows.Forms.MainMenu
    Friend WithEvents MenuItem1 As System.Windows.Forms.MenuItem
    Friend WithEvents AxGrFingerXCtrl1 As AxGrFingerXLib.AxGrFingerXCtrl
    Friend WithEvents LogList As System.Windows.Forms.ListBox
    Friend WithEvents ClearLogButton As System.Windows.Forms.Button
    Friend WithEvents ExtractButton As System.Windows.Forms.Button
    Friend WithEvents ckAutoExtract As System.Windows.Forms.CheckBox
    Friend WithEvents IdentifyButton As System.Windows.Forms.Button
    Friend WithEvents ckBoxAutoIdentify As System.Windows.Forms.CheckBox
    Friend WithEvents EnrollButton As System.Windows.Forms.Button
    Friend WithEvents VerifyButton As System.Windows.Forms.Button
    Friend WithEvents ClearDatabaseButton As System.Windows.Forms.Button
    Friend WithEvents MenuSave As System.Windows.Forms.MenuItem
    Friend WithEvents MenuLoad As System.Windows.Forms.MenuItem
    Friend WithEvents MenuOptions As System.Windows.Forms.MenuItem
    Friend WithEvents MenuVersion As System.Windows.Forms.MenuItem
    <System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()
        Dim resources As System.Resources.ResourceManager = New System.Resources.ResourceManager(GetType(MainForm))
        Me.PictureBox1 = New System.Windows.Forms.PictureBox
        Me.MainMenu1 = New System.Windows.Forms.MainMenu
        Me.MenuItem1 = New System.Windows.Forms.MenuItem
        Me.MenuSave = New System.Windows.Forms.MenuItem
        Me.MenuLoad = New System.Windows.Forms.MenuItem
        Me.MenuOptions = New System.Windows.Forms.MenuItem
        Me.MenuVersion = New System.Windows.Forms.MenuItem
        Me.EnrollButton = New System.Windows.Forms.Button
        Me.VerifyButton = New System.Windows.Forms.Button
        Me.IdentifyButton = New System.Windows.Forms.Button
        Me.ClearDatabaseButton = New System.Windows.Forms.Button
        Me.ClearLogButton = New System.Windows.Forms.Button
        Me.ckBoxAutoIdentify = New System.Windows.Forms.CheckBox
        Me.LogList = New System.Windows.Forms.ListBox
        Me.AxGrFingerXCtrl1 = New AxGrFingerXLib.AxGrFingerXCtrl
        Me.ExtractButton = New System.Windows.Forms.Button
        Me.ckAutoExtract = New System.Windows.Forms.CheckBox
        CType(Me.AxGrFingerXCtrl1, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.SuspendLayout()
        '
        'PictureBox1
        '
        Me.PictureBox1.BackColor = System.Drawing.SystemColors.Control
        Me.PictureBox1.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.PictureBox1.Location = New System.Drawing.Point(8, 8)
        Me.PictureBox1.Name = "PictureBox1"
        Me.PictureBox1.Size = New System.Drawing.Size(400, 408)
        Me.PictureBox1.SizeMode = System.Windows.Forms.PictureBoxSizeMode.StretchImage
        Me.PictureBox1.TabIndex = 0
        Me.PictureBox1.TabStop = False
        '
        'MainMenu1
        '
        Me.MainMenu1.MenuItems.AddRange(New System.Windows.Forms.MenuItem() {Me.MenuItem1, Me.MenuOptions, Me.MenuVersion})
        '
        'MenuItem1
        '
        Me.MenuItem1.Index = 0
        Me.MenuItem1.MenuItems.AddRange(New System.Windows.Forms.MenuItem() {Me.MenuSave, Me.MenuLoad})
        Me.MenuItem1.Text = "&Image"
        '
        'MenuSave
        '
        Me.MenuSave.Index = 0
        Me.MenuSave.Shortcut = System.Windows.Forms.Shortcut.CtrlS
        Me.MenuSave.Text = "Save..."
        '
        'MenuLoad
        '
        Me.MenuLoad.Index = 1
        Me.MenuLoad.Shortcut = System.Windows.Forms.Shortcut.CtrlL
        Me.MenuLoad.Text = "Load From File..."
        '
        'MenuOptions
        '
        Me.MenuOptions.Index = 1
        Me.MenuOptions.Text = "&Options..."
        '
        'MenuVersion
        '
        Me.MenuVersion.Index = 2
        Me.MenuVersion.Text = "&Version"
        '
        'EnrollButton
        '
        Me.EnrollButton.Enabled = False
        Me.EnrollButton.Location = New System.Drawing.Point(416, 160)
        Me.EnrollButton.Name = "EnrollButton"
        Me.EnrollButton.Size = New System.Drawing.Size(96, 24)
        Me.EnrollButton.TabIndex = 1
        Me.EnrollButton.Text = "Enroll"
        '
        'VerifyButton
        '
        Me.VerifyButton.Enabled = False
        Me.VerifyButton.Location = New System.Drawing.Point(416, 192)
        Me.VerifyButton.Name = "VerifyButton"
        Me.VerifyButton.Size = New System.Drawing.Size(96, 24)
        Me.VerifyButton.TabIndex = 2
        Me.VerifyButton.Text = "Verify"
        '
        'IdentifyButton
        '
        Me.IdentifyButton.Enabled = False
        Me.IdentifyButton.Location = New System.Drawing.Point(416, 224)
        Me.IdentifyButton.Name = "IdentifyButton"
        Me.IdentifyButton.Size = New System.Drawing.Size(96, 24)
        Me.IdentifyButton.TabIndex = 3
        Me.IdentifyButton.Text = "Identify"
        '
        'ClearDatabaseButton
        '
        Me.ClearDatabaseButton.Location = New System.Drawing.Point(416, 304)
        Me.ClearDatabaseButton.Name = "ClearDatabaseButton"
        Me.ClearDatabaseButton.Size = New System.Drawing.Size(96, 24)
        Me.ClearDatabaseButton.TabIndex = 4
        Me.ClearDatabaseButton.Text = "Clear database"
        '
        'ClearLogButton
        '
        Me.ClearLogButton.Location = New System.Drawing.Point(416, 336)
        Me.ClearLogButton.Name = "ClearLogButton"
        Me.ClearLogButton.Size = New System.Drawing.Size(96, 24)
        Me.ClearLogButton.TabIndex = 5
        Me.ClearLogButton.Text = "Clear log"
        '
        'ckBoxAutoIdentify
        '
        Me.ckBoxAutoIdentify.Location = New System.Drawing.Point(416, 376)
        Me.ckBoxAutoIdentify.Name = "ckBoxAutoIdentify"
        Me.ckBoxAutoIdentify.Size = New System.Drawing.Size(88, 16)
        Me.ckBoxAutoIdentify.TabIndex = 6
        Me.ckBoxAutoIdentify.Text = "Auto identify"
        '
        'LogList
        '
        Me.LogList.Location = New System.Drawing.Point(8, 424)
        Me.LogList.Name = "LogList"
        Me.LogList.ScrollAlwaysVisible = True
        Me.LogList.Size = New System.Drawing.Size(504, 108)
        Me.LogList.TabIndex = 7
        '
        'AxGrFingerXCtrl1
        '
        Me.AxGrFingerXCtrl1.Enabled = True
        Me.AxGrFingerXCtrl1.Location = New System.Drawing.Point(456, 56)
        Me.AxGrFingerXCtrl1.Name = "AxGrFingerXCtrl1"
        Me.AxGrFingerXCtrl1.OcxState = CType(resources.GetObject("AxGrFingerXCtrl1.OcxState"), System.Windows.Forms.AxHost.State)
        Me.AxGrFingerXCtrl1.Size = New System.Drawing.Size(32, 32)
        Me.AxGrFingerXCtrl1.TabIndex = 8
        '
        'ExtractButton
        '
        Me.ExtractButton.Enabled = False
        Me.ExtractButton.Location = New System.Drawing.Point(416, 256)
        Me.ExtractButton.Name = "ExtractButton"
        Me.ExtractButton.Size = New System.Drawing.Size(96, 24)
        Me.ExtractButton.TabIndex = 9
        Me.ExtractButton.Text = "Extract template"
        '
        'ckAutoExtract
        '
        Me.ckAutoExtract.Checked = True
        Me.ckAutoExtract.CheckState = System.Windows.Forms.CheckState.Checked
        Me.ckAutoExtract.Location = New System.Drawing.Point(416, 392)
        Me.ckAutoExtract.Name = "ckAutoExtract"
        Me.ckAutoExtract.Size = New System.Drawing.Size(88, 24)
        Me.ckAutoExtract.TabIndex = 10
        Me.ckAutoExtract.Text = "Auto Extract"
        '
        'MainForm
        '
        Me.AutoScaleBaseSize = New System.Drawing.Size(5, 13)
        Me.ClientSize = New System.Drawing.Size(520, 537)
        Me.Controls.Add(Me.ckAutoExtract)
        Me.Controls.Add(Me.ExtractButton)
        Me.Controls.Add(Me.AxGrFingerXCtrl1)
        Me.Controls.Add(Me.LogList)
        Me.Controls.Add(Me.ckBoxAutoIdentify)
        Me.Controls.Add(Me.ClearLogButton)
        Me.Controls.Add(Me.ClearDatabaseButton)
        Me.Controls.Add(Me.IdentifyButton)
        Me.Controls.Add(Me.VerifyButton)
        Me.Controls.Add(Me.EnrollButton)
        Me.Controls.Add(Me.PictureBox1)
        Me.Icon = CType(resources.GetObject("$this.Icon"), System.Drawing.Icon)
        Me.Menu = Me.MainMenu1
        Me.Name = "MainForm"
        Me.Text = "GrFingerX - Sample application - VB.NET 2003"
        CType(Me.AxGrFingerXCtrl1, System.ComponentModel.ISupportInitialize).EndInit()
        Me.ResumeLayout(False)

    End Sub

#End Region

    ' the options form
    Dim OptionsForm1 As New OptionsForm
    ' the util class
    Dim myUtil As Util

    ' Application startup code
    Private Sub MainForm_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        Dim err As Integer

        ' initialize util class
        myUtil = New Util(LogList, PictureBox1, AxGrFingerXCtrl1)

        ' Initialize GrFingerX Library
        err = myUtil.InitializeGrFinger()
        ' Print result in log
        If err < 0 Then
            myUtil.WriteError(err)
            Exit Sub
        Else
            myUtil.WriteLog("**GrFingerX Initialized Successfull**")
        End If
    End Sub

    ' Application finalization code
    Private Sub MainForm_Close(ByVal sender As System.Object, ByVal e As System.ComponentModel.CancelEventArgs) Handles MyBase.Closing
        myUtil.FinalizeGrFinger()
    End Sub

    ' Add a fingerprint to database
    Private Sub EnrollButton_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles EnrollButton.Click
        Dim id As Integer

        ' add fingerprint
        id = myUtil.Enroll()
        ' write result to log
        If id >= 0 Then
            myUtil.WriteLog("Fingerprint enrolled with id = " & id)
        Else
            myUtil.WriteLog("Error: Fingerprint not enrolled")
        End If
    End Sub

    ' Identify a fingerprint
    Private Sub IdentifyButton_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles IdentifyButton.Click
        Dim ret As Integer, score As Integer

        score = 0
        ' identify it
        ret = myUtil.Identify(score)
        ' write result to log
        If ret > 0 Then
            myUtil.WriteLog("Fingerprint identified. ID = " & ret & ". Score = " & score & ".")
            myUtil.PrintBiometricDisplay(True, GRConstants.GR_DEFAULT_CONTEXT)
        ElseIf ret = 0 Then
            myUtil.WriteLog("Fingerprint not Found.")
        Else
            myUtil.WriteError(ret)
        End If
    End Sub

    ' Check a fingerprint
    Private Sub VerifyButton_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles VerifyButton.Click
        Dim id As Integer
        Dim ret As Integer
        Dim score As Integer
        Dim sid As String

        ' ask target fingerprint ID
        score = 0
        sid = InputBox("Enter the ID to verify", "Verify", "")
        If sid <> "" Then
            ' compare fingerprints
            ret = myUtil.Verify(Val(sid), score)
            ' write result to log
            If ret < 0 Then
                myUtil.WriteError(ret)
            ElseIf ret = GRConstants.GR_NOT_MATCH Then
                myUtil.WriteLog("Did not match with score = " & score)
            Else
                myUtil.WriteLog("Matched with score = " & score)
                ' if they match, display matching minutiae/segments/directions
                myUtil.PrintBiometricDisplay(True, GRConstants.GR_DEFAULT_CONTEXT)
            End If
        End If
    End Sub

    ' Extract a template from a fingerprint image
    Private Sub ExtractButton_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles ExtractButton.Click
        Dim ret As Integer

        ' extract template
        ret = myUtil.ExtractTemplate()
        ' write template quality to log
        If ret = GRConstants.GR_BAD_QUALITY Then
            myUtil.WriteLog("Template extracted successfully. Bad quality.")
        ElseIf ret = GRConstants.GR_MEDIUM_QUALITY Then
            myUtil.WriteLog("Template extracted successfully. Medium quality.")
        ElseIf ret = GRConstants.GR_HIGH_QUALITY Then
            myUtil.WriteLog("Template extracted successfully. High quality.")
        End If
        If ret >= 0 Then
            ' if no error, display minutiae/segments/directions into the image
            myUtil.PrintBiometricDisplay(True, GRConstants.GR_NO_CONTEXT)
            ' enable operations we can do over extracted template
            ExtractButton.Enabled = False
            EnrollButton.Enabled = True
            IdentifyButton.Enabled = True
            VerifyButton.Enabled = True
        Else
            ' write error to log
            myUtil.WriteError(ret)
        End If
    End Sub

    ' Clear database
    Private Sub ClearDatabaseButton_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles ClearDatabaseButton.Click
        ' clear database
        myUtil.DB.clearDB()
        ' write result to log
        myUtil.WriteLog("Database is clear...")
    End Sub

    ' Clear log
    Private Sub ClearLogButton_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles ClearLogButton.Click
        LogList.Items.Clear()
    End Sub

    ' Save fingerprint image to a file
    Private Sub MenuSave_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MenuSave.Click
        Dim SaveFileDialog1 As New SaveFileDialog

        ' we need an image
        If myUtil.raw.img Is Nothing Then
            MsgBox("There is no image to save.")
            Return
        End If

        ' open "save" dialog
        SaveFileDialog1.Filter = "BMP files (*.bmp)|*.bmp|All files (*.*)|*.*"
        SaveFileDialog1.FilterIndex = 1
        SaveFileDialog1.RestoreDirectory = True

        ' save image
        If SaveFileDialog1.ShowDialog() = DialogResult.OK Then
            If AxGrFingerXCtrl1.CapSaveRawImageToFile(myUtil.raw.img, myUtil.raw.width, myUtil.raw.height, SaveFileDialog1.FileName, GRConstants.GRCAP_IMAGE_FORMAT_BMP) <> GRConstants.GR_OK Then
                myUtil.WriteLog("Fail to save the file.")
            End If
        End If
    End Sub

    ' Load a fingerprint image from a file
    Private Sub MenuLoad_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MenuLoad.Click
        Dim OpenFileDialog1 As New OpenFileDialog
        Dim resolution As Integer

        ' open "load" dialog
        OpenFileDialog1.Filter = "BMP files (*.bmp)|*.bmp|All files (*.*)|*.*"
        OpenFileDialog1.FilterIndex = 1
        OpenFileDialog1.RestoreDirectory = True

        ' load image
        If OpenFileDialog1.ShowDialog() = DialogResult.OK Then
            ' Getting resolution.
            resolution = Val(InputBox("What is the image resolution?", "Resolution", ""))
            ' Checking if action was canceled, no value or an invalid value was entered.
            If (resolution <> 0) Then
                If AxGrFingerXCtrl1.CapLoadImageFromFile(OpenFileDialog1.FileName, resolution) <> GRConstants.GR_OK Then
                    myUtil.WriteLog("Fail to load the file.")
                End If
            End If
        End If
    End Sub

    ' Open "Options" window
    Private Sub MenuOptions_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MenuOptions.Click
        Dim ret As Integer
        Dim thresholdId As Integer
        Dim rotationMaxId As Integer
        Dim thresholdVr As Integer
        Dim rotationMaxVr As Integer
        Dim minutiaeColor As Integer
        Dim minutiaeMatchColor As Integer
        Dim segmentsColor As Integer
        Dim segmentsMatchColor As Integer
        Dim directionsColor As Integer
        Dim directionsMatchColor As Integer
        Dim ok As Boolean

        Do
            ' get current identification/verification parameters
            AxGrFingerXCtrl1.GetIdentifyParameters(thresholdId, rotationMaxId, GRConstants.GR_DEFAULT_CONTEXT)
            AxGrFingerXCtrl1.GetVerifyParameters(thresholdVr, rotationMaxVr, GRConstants.GR_DEFAULT_CONTEXT)
            ' set current identification/verification parameters on options form
            OptionsForm1.setParameters(thresholdId, rotationMaxId, thresholdVr, rotationMaxVr)

            ' show form with match option and biometric display options
            If OptionsForm1.ShowDialog() = DialogResult.Cancel Then Return
            ok = True
            ' get new parameters 
            OptionsForm1.getParameters(thresholdId, rotationMaxId, thresholdVr, rotationMaxVr, _
                  minutiaeColor, minutiaeMatchColor, segmentsColor, segmentsMatchColor, directionsColor, directionsMatchColor)

            If (thresholdId < GRConstants.GR_MIN_THRESHOLD Or _
             thresholdId > GRConstants.GR_MAX_THRESHOLD Or _
             rotationMaxId < GRConstants.GR_ROT_MIN Or _
             rotationMaxId > GRConstants.GR_ROT_MAX) Then
                MsgBox("Invalid identify parameters values!")
                ok = False
            End If
            If (thresholdVr < GRConstants.GR_MIN_THRESHOLD Or _
             thresholdVr > GRConstants.GR_MAX_THRESHOLD Or _
             rotationMaxVr < GRConstants.GR_ROT_MIN Or _
             rotationMaxVr > GRConstants.GR_ROT_MAX) Then
                MsgBox("Invalid verify parameters values!")
                ok = False
            End If
            ' set new identification parameters
            If ok Then
                ret = AxGrFingerXCtrl1.SetIdentifyParameters(thresholdId, rotationMaxId, GRConstants.GR_DEFAULT_CONTEXT)
                ' error?
                If ret = GRConstants.GR_DEFAULT_USED Then
                    MsgBox("Invalid identify parameters values. Default values will be used.")
                    ok = False
                End If
                ' set new verification parameters
                ret = AxGrFingerXCtrl1.SetVerifyParameters(thresholdVr, rotationMaxVr, GRConstants.GR_DEFAULT_CONTEXT)
                ' error?
                If ret = GRConstants.GR_DEFAULT_USED Then
                    MsgBox("Invalid verify parameters values. Default values will be used.")
                    ok = False
                End If
                ' if everything ok
                If ok Then
                    ' accept new parameters
                    OptionsForm1.AcceptChanges()
                    ' set new colors
                    AxGrFingerXCtrl1.SetBiometricDisplayColors(minutiaeColor, minutiaeMatchColor, segmentsColor, segmentsMatchColor, directionsColor, directionsMatchColor)
                    Return
                End If
            End If
        Loop
    End Sub

    ' Display GrFinger version
    Private Sub MenuVersion_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MenuVersion.Click
        myUtil.MessageVersion()
    End Sub

    ' -----------------------------------------------------------------------------------
    ' GrFingerX events
    ' -----------------------------------------------------------------------------------

    ' A fingerprint reader was plugged on system
    Private Sub AxGrFingerXCtrl1_SensorPlug(ByVal sender As System.Object, ByVal e As AxGrFingerXLib._IGrFingerXCtrlEvents_SensorPlugEvent) Handles AxGrFingerXCtrl1.SensorPlug
        myUtil.WriteLog("Sensor: " & e.idSensor & ". Event: Plugged.")
        AxGrFingerXCtrl1.CapStartCapture(e.idSensor)
    End Sub

    ' A fingerprint reader was unplugged from system
    Private Sub AxGrFingerXCtrl1_SensorUnplug(ByVal sender As System.Object, ByVal e As AxGrFingerXLib._IGrFingerXCtrlEvents_SensorUnplugEvent) Handles AxGrFingerXCtrl1.SensorUnplug
        myUtil.WriteLog("Sensor: " & e.idSensor & ". Event: Unplugged.")
        AxGrFingerXCtrl1.CapStopCapture(e.idSensor)
    End Sub

    ' A finger was placed on reader
    Private Sub AxGrFingerXCtrl1_FingerDown(ByVal sender As System.Object, ByVal e As AxGrFingerXLib._IGrFingerXCtrlEvents_FingerDownEvent) Handles AxGrFingerXCtrl1.FingerDown
        myUtil.WriteLog("Sensor: " & e.idSensor & ". Event: Finger Placed.")
    End Sub

    ' A finger was removed from reader
    Private Sub AxGrFingerXCtrl1_FingerUp(ByVal sender As System.Object, ByVal e As AxGrFingerXLib._IGrFingerXCtrlEvents_FingerUpEvent) Handles AxGrFingerXCtrl1.FingerUp
        myUtil.WriteLog("Sensor: " & e.idSensor & ". Event: Finger removed.")
    End Sub

    ' An image was acquired from reader
    Private Sub AxGrFingerXCtrl1_ImageAcquired(ByVal sender As System.Object, ByVal e As AxGrFingerXLib._IGrFingerXCtrlEvents_ImageAcquiredEvent) Handles AxGrFingerXCtrl1.ImageAcquired
        ' Copying aquired image
        myUtil.raw.height = e.height
        myUtil.raw.width = e.width
        myUtil.raw.res = e.res
        myUtil.raw.img = e.rawImage

        ' Signaling that an Image Event occurred.
        myUtil.WriteLog("Sensor: " & e.idSensor & ". Event: Image captured.")

        ' display fingerprint image
        myUtil.PrintBiometricDisplay(False, GRConstants.GR_DEFAULT_CONTEXT)

        ' now we have a fingerprint, so we can extract template
        ExtractButton.Enabled = True
        EnrollButton.Enabled = False
        IdentifyButton.Enabled = False
        VerifyButton.Enabled = False

        ' extracting template from image
        If ckAutoExtract.Checked Then ExtractButton.PerformClick()

        ' identify fingerprint
        If ckBoxAutoIdentify.Checked Then IdentifyButton().PerformClick()

    End Sub

End Class
