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
' GUI routines: "Options" form
' -----------------------------------------------------------------------------------

Imports GrFingerXLib

Public Class OptionsForm
	Inherits System.Windows.Forms.Form

	Private clMinutiaeColor As Color
	Private clMinutiaeMatchColor As Color
	Private clSegmentsColor As Color
	Private clSegmentsMatchColor As Color
	Private clDirectionsColor As Color
	Private clDirectionsMatchColor As Color
	Private bShowMinutiae As Boolean
	Private bShowMinutiaeMatch As Boolean
	Private bShowSegments As Boolean
	Private bShowSegmentsMatch As Boolean
	Private bShowDirections As Boolean
	Private bShowDirectionsMatch As Boolean
	Private initialized As Boolean

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
	Friend WithEvents GroupBox1 As System.Windows.Forms.GroupBox
	Friend WithEvents Label1 As System.Windows.Forms.Label
	Friend WithEvents Label2 As System.Windows.Forms.Label
	Friend WithEvents GroupBox2 As System.Windows.Forms.GroupBox
	Friend WithEvents Label3 As System.Windows.Forms.Label
	Friend WithEvents Label4 As System.Windows.Forms.Label
	Friend WithEvents GroupBox3 As System.Windows.Forms.GroupBox
	Friend WithEvents ColorDialog1 As System.Windows.Forms.ColorDialog
	Friend WithEvents Label5 As System.Windows.Forms.Label
	Friend WithEvents Label6 As System.Windows.Forms.Label
	Friend WithEvents Label13 As System.Windows.Forms.Label
	Friend WithEvents GroupBox4 As System.Windows.Forms.GroupBox
	Friend WithEvents Label7 As System.Windows.Forms.Label
	Friend WithEvents Label8 As System.Windows.Forms.Label
	Friend WithEvents Label9 As System.Windows.Forms.Label
	Friend WithEvents GroupBox5 As System.Windows.Forms.GroupBox
	Friend WithEvents Label10 As System.Windows.Forms.Label
	Friend WithEvents Label11 As System.Windows.Forms.Label
	Friend WithEvents Label12 As System.Windows.Forms.Label
	Friend WithEvents RotationMaxIdTextBox As System.Windows.Forms.TextBox
	Friend WithEvents ThresholdIdTextBox As System.Windows.Forms.TextBox
	Friend WithEvents RotationMaxVrTextBox As System.Windows.Forms.TextBox
	Friend WithEvents ThresholdVrTextBox As System.Windows.Forms.TextBox
	Friend WithEvents OkButton As System.Windows.Forms.Button
	Friend WithEvents ButtonCancel As System.Windows.Forms.Button
	Friend WithEvents pbMinutiaeMatchColor As System.Windows.Forms.PictureBox
	Friend WithEvents pbMinutiaeColor As System.Windows.Forms.PictureBox
	Friend WithEvents pbSegmentsMatchColor As System.Windows.Forms.PictureBox
	Friend WithEvents pbSegmentsColor As System.Windows.Forms.PictureBox
	Friend WithEvents cbShowMinutiaeMatched As System.Windows.Forms.CheckBox
	Friend WithEvents cbShowMinutiae As System.Windows.Forms.CheckBox
	Friend WithEvents cbShowSegmentsMatched As System.Windows.Forms.CheckBox
	Friend WithEvents cbShowSegments As System.Windows.Forms.CheckBox
	Friend WithEvents cbShowDirections As System.Windows.Forms.CheckBox
	Friend WithEvents pbDirectionsMatchColor As System.Windows.Forms.PictureBox
	Friend WithEvents pbDirectionsColor As System.Windows.Forms.PictureBox
	Friend WithEvents cbShowDirectionsMatched As System.Windows.Forms.CheckBox
	<System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()
		Dim resources As System.Resources.ResourceManager = New System.Resources.ResourceManager(GetType(OptionsForm))
		Me.GroupBox1 = New System.Windows.Forms.GroupBox
		Me.Label2 = New System.Windows.Forms.Label
		Me.Label1 = New System.Windows.Forms.Label
		Me.RotationMaxIdTextBox = New System.Windows.Forms.TextBox
		Me.ThresholdIdTextBox = New System.Windows.Forms.TextBox
		Me.GroupBox2 = New System.Windows.Forms.GroupBox
		Me.Label3 = New System.Windows.Forms.Label
		Me.Label4 = New System.Windows.Forms.Label
		Me.RotationMaxVrTextBox = New System.Windows.Forms.TextBox
		Me.ThresholdVrTextBox = New System.Windows.Forms.TextBox
		Me.GroupBox3 = New System.Windows.Forms.GroupBox
		Me.Label13 = New System.Windows.Forms.Label
		Me.cbShowMinutiaeMatched = New System.Windows.Forms.CheckBox
		Me.cbShowMinutiae = New System.Windows.Forms.CheckBox
		Me.pbMinutiaeMatchColor = New System.Windows.Forms.PictureBox
		Me.Label6 = New System.Windows.Forms.Label
		Me.pbMinutiaeColor = New System.Windows.Forms.PictureBox
		Me.Label5 = New System.Windows.Forms.Label
		Me.ColorDialog1 = New System.Windows.Forms.ColorDialog
		Me.OkButton = New System.Windows.Forms.Button
		Me.ButtonCancel = New System.Windows.Forms.Button
		Me.GroupBox4 = New System.Windows.Forms.GroupBox
		Me.Label7 = New System.Windows.Forms.Label
		Me.cbShowSegmentsMatched = New System.Windows.Forms.CheckBox
		Me.cbShowSegments = New System.Windows.Forms.CheckBox
		Me.pbSegmentsMatchColor = New System.Windows.Forms.PictureBox
		Me.Label8 = New System.Windows.Forms.Label
		Me.pbSegmentsColor = New System.Windows.Forms.PictureBox
		Me.Label9 = New System.Windows.Forms.Label
		Me.GroupBox5 = New System.Windows.Forms.GroupBox
		Me.Label10 = New System.Windows.Forms.Label
		Me.cbShowDirectionsMatched = New System.Windows.Forms.CheckBox
		Me.cbShowDirections = New System.Windows.Forms.CheckBox
		Me.pbDirectionsMatchColor = New System.Windows.Forms.PictureBox
		Me.Label11 = New System.Windows.Forms.Label
		Me.pbDirectionsColor = New System.Windows.Forms.PictureBox
		Me.Label12 = New System.Windows.Forms.Label
		Me.GroupBox1.SuspendLayout()
		Me.GroupBox2.SuspendLayout()
		Me.GroupBox3.SuspendLayout()
		Me.GroupBox4.SuspendLayout()
		Me.GroupBox5.SuspendLayout()
		Me.SuspendLayout()
		'
		'GroupBox1
		'
		Me.GroupBox1.Controls.Add(Me.Label2)
		Me.GroupBox1.Controls.Add(Me.Label1)
		Me.GroupBox1.Controls.Add(Me.RotationMaxIdTextBox)
		Me.GroupBox1.Controls.Add(Me.ThresholdIdTextBox)
		Me.GroupBox1.Location = New System.Drawing.Point(8, 8)
		Me.GroupBox1.Name = "GroupBox1"
		Me.GroupBox1.Size = New System.Drawing.Size(192, 80)
		Me.GroupBox1.TabIndex = 0
		Me.GroupBox1.TabStop = False
		Me.GroupBox1.Text = "Identify"
		'
		'Label2
		'
		Me.Label2.AutoSize = True
		Me.Label2.Location = New System.Drawing.Point(16, 52)
		Me.Label2.Name = "Label2"
		Me.Label2.Size = New System.Drawing.Size(99, 16)
		Me.Label2.TabIndex = 3
		Me.Label2.Text = "Rotation tolerance:"
		'
		'Label1
		'
		Me.Label1.AutoSize = True
		Me.Label1.Location = New System.Drawing.Point(56, 20)
		Me.Label1.Name = "Label1"
		Me.Label1.Size = New System.Drawing.Size(58, 16)
		Me.Label1.TabIndex = 2
		Me.Label1.Text = "Threshold:"
		'
		'RotationMaxIdTextBox
		'
		Me.RotationMaxIdTextBox.Location = New System.Drawing.Point(120, 48)
		Me.RotationMaxIdTextBox.Name = "RotationMaxIdTextBox"
		Me.RotationMaxIdTextBox.Size = New System.Drawing.Size(64, 20)
		Me.RotationMaxIdTextBox.TabIndex = 1
		Me.RotationMaxIdTextBox.Text = ""
		'
		'ThresholdIdTextBox
		'
		Me.ThresholdIdTextBox.Location = New System.Drawing.Point(120, 16)
		Me.ThresholdIdTextBox.Name = "ThresholdIdTextBox"
		Me.ThresholdIdTextBox.Size = New System.Drawing.Size(64, 20)
		Me.ThresholdIdTextBox.TabIndex = 0
		Me.ThresholdIdTextBox.Text = ""
		'
		'GroupBox2
		'
		Me.GroupBox2.Controls.Add(Me.Label3)
		Me.GroupBox2.Controls.Add(Me.Label4)
		Me.GroupBox2.Controls.Add(Me.RotationMaxVrTextBox)
		Me.GroupBox2.Controls.Add(Me.ThresholdVrTextBox)
		Me.GroupBox2.Location = New System.Drawing.Point(208, 8)
		Me.GroupBox2.Name = "GroupBox2"
		Me.GroupBox2.Size = New System.Drawing.Size(192, 80)
		Me.GroupBox2.TabIndex = 5
		Me.GroupBox2.TabStop = False
		Me.GroupBox2.Text = "Verify"
		'
		'Label3
		'
		Me.Label3.AutoSize = True
		Me.Label3.Location = New System.Drawing.Point(16, 52)
		Me.Label3.Name = "Label3"
		Me.Label3.Size = New System.Drawing.Size(99, 16)
		Me.Label3.TabIndex = 3
		Me.Label3.Text = "Rotation tolerance:"
		'
		'Label4
		'
		Me.Label4.AutoSize = True
		Me.Label4.Location = New System.Drawing.Point(56, 20)
		Me.Label4.Name = "Label4"
		Me.Label4.Size = New System.Drawing.Size(58, 16)
		Me.Label4.TabIndex = 2
		Me.Label4.Text = "Threshold:"
		'
		'RotationMaxVrTextBox
		'
		Me.RotationMaxVrTextBox.Location = New System.Drawing.Point(120, 48)
		Me.RotationMaxVrTextBox.Name = "RotationMaxVrTextBox"
		Me.RotationMaxVrTextBox.Size = New System.Drawing.Size(64, 20)
		Me.RotationMaxVrTextBox.TabIndex = 1
		Me.RotationMaxVrTextBox.Text = ""
		'
		'ThresholdVrTextBox
		'
		Me.ThresholdVrTextBox.Location = New System.Drawing.Point(120, 16)
		Me.ThresholdVrTextBox.Name = "ThresholdVrTextBox"
		Me.ThresholdVrTextBox.Size = New System.Drawing.Size(64, 20)
		Me.ThresholdVrTextBox.TabIndex = 0
		Me.ThresholdVrTextBox.Text = ""
		'
		'GroupBox3
		'
		Me.GroupBox3.Controls.Add(Me.Label13)
		Me.GroupBox3.Controls.Add(Me.cbShowMinutiaeMatched)
		Me.GroupBox3.Controls.Add(Me.cbShowMinutiae)
		Me.GroupBox3.Controls.Add(Me.pbMinutiaeMatchColor)
		Me.GroupBox3.Controls.Add(Me.Label6)
		Me.GroupBox3.Controls.Add(Me.pbMinutiaeColor)
		Me.GroupBox3.Controls.Add(Me.Label5)
		Me.GroupBox3.Location = New System.Drawing.Point(8, 96)
		Me.GroupBox3.Name = "GroupBox3"
		Me.GroupBox3.Size = New System.Drawing.Size(392, 80)
		Me.GroupBox3.TabIndex = 6
		Me.GroupBox3.TabStop = False
		Me.GroupBox3.Text = "Minutiae Colors"
		'
		'Label13
		'
		Me.Label13.Location = New System.Drawing.Point(232, 32)
		Me.Label13.Name = "Label13"
		Me.Label13.Size = New System.Drawing.Size(144, 32)
		Me.Label13.TabIndex = 6
		Me.Label13.Text = "Double click the color to change it."
		'
		'cbShowMinutiaeMatched
		'
		Me.cbShowMinutiaeMatched.Checked = True
		Me.cbShowMinutiaeMatched.CheckState = System.Windows.Forms.CheckState.Checked
		Me.cbShowMinutiaeMatched.Location = New System.Drawing.Point(144, 48)
		Me.cbShowMinutiaeMatched.Name = "cbShowMinutiaeMatched"
		Me.cbShowMinutiaeMatched.Size = New System.Drawing.Size(56, 16)
		Me.cbShowMinutiaeMatched.TabIndex = 5
		Me.cbShowMinutiaeMatched.Text = "Show"
		'
		'cbShowMinutiae
		'
		Me.cbShowMinutiae.Checked = True
		Me.cbShowMinutiae.CheckState = System.Windows.Forms.CheckState.Checked
		Me.cbShowMinutiae.Location = New System.Drawing.Point(144, 24)
		Me.cbShowMinutiae.Name = "cbShowMinutiae"
		Me.cbShowMinutiae.Size = New System.Drawing.Size(56, 16)
		Me.cbShowMinutiae.TabIndex = 4
		Me.cbShowMinutiae.Text = "Show"
		'
		'pbMinutiaeMatchColor
		'
		Me.pbMinutiaeMatchColor.BackColor = System.Drawing.Color.Purple
		Me.pbMinutiaeMatchColor.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle
		Me.pbMinutiaeMatchColor.Location = New System.Drawing.Point(64, 48)
		Me.pbMinutiaeMatchColor.Name = "pbMinutiaeMatchColor"
		Me.pbMinutiaeMatchColor.Size = New System.Drawing.Size(72, 16)
		Me.pbMinutiaeMatchColor.TabIndex = 3
		Me.pbMinutiaeMatchColor.TabStop = False
		'
		'Label6
		'
		Me.Label6.AutoSize = True
		Me.Label6.Location = New System.Drawing.Point(16, 48)
		Me.Label6.Name = "Label6"
		Me.Label6.Size = New System.Drawing.Size(38, 16)
		Me.Label6.TabIndex = 2
		Me.Label6.Text = "Match:"
		'
		'pbMinutiaeColor
		'
		Me.pbMinutiaeColor.BackColor = System.Drawing.Color.Blue
		Me.pbMinutiaeColor.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle
		Me.pbMinutiaeColor.Location = New System.Drawing.Point(64, 24)
		Me.pbMinutiaeColor.Name = "pbMinutiaeColor"
		Me.pbMinutiaeColor.Size = New System.Drawing.Size(72, 16)
		Me.pbMinutiaeColor.TabIndex = 1
		Me.pbMinutiaeColor.TabStop = False
		'
		'Label5
		'
		Me.Label5.AutoSize = True
		Me.Label5.Location = New System.Drawing.Point(16, 24)
		Me.Label5.Name = "Label5"
		Me.Label5.Size = New System.Drawing.Size(47, 16)
		Me.Label5.TabIndex = 0
		Me.Label5.Text = "Regular:"
		'
		'OkButton
		'
		Me.OkButton.DialogResult = System.Windows.Forms.DialogResult.OK
		Me.OkButton.Location = New System.Drawing.Point(112, 360)
		Me.OkButton.Name = "OkButton"
		Me.OkButton.Size = New System.Drawing.Size(80, 24)
		Me.OkButton.TabIndex = 9
		Me.OkButton.Text = "OK"
		'
		'ButtonCancel
		'
		Me.ButtonCancel.DialogResult = System.Windows.Forms.DialogResult.Cancel
		Me.ButtonCancel.Location = New System.Drawing.Point(216, 360)
		Me.ButtonCancel.Name = "ButtonCancel"
		Me.ButtonCancel.Size = New System.Drawing.Size(80, 24)
		Me.ButtonCancel.TabIndex = 0
		Me.ButtonCancel.Text = "Cancel"
		'
		'GroupBox4
		'
		Me.GroupBox4.Controls.Add(Me.Label7)
		Me.GroupBox4.Controls.Add(Me.cbShowSegmentsMatched)
		Me.GroupBox4.Controls.Add(Me.cbShowSegments)
		Me.GroupBox4.Controls.Add(Me.pbSegmentsMatchColor)
		Me.GroupBox4.Controls.Add(Me.Label8)
		Me.GroupBox4.Controls.Add(Me.pbSegmentsColor)
		Me.GroupBox4.Controls.Add(Me.Label9)
		Me.GroupBox4.Location = New System.Drawing.Point(8, 184)
		Me.GroupBox4.Name = "GroupBox4"
		Me.GroupBox4.Size = New System.Drawing.Size(392, 80)
		Me.GroupBox4.TabIndex = 11
		Me.GroupBox4.TabStop = False
		Me.GroupBox4.Text = "Segments Colors"
		'
		'Label7
		'
		Me.Label7.Location = New System.Drawing.Point(232, 32)
		Me.Label7.Name = "Label7"
		Me.Label7.Size = New System.Drawing.Size(144, 32)
		Me.Label7.TabIndex = 6
		Me.Label7.Text = "Double click the color to change it."
		'
		'cbShowSegmentsMatched
		'
		Me.cbShowSegmentsMatched.Checked = True
		Me.cbShowSegmentsMatched.CheckState = System.Windows.Forms.CheckState.Checked
		Me.cbShowSegmentsMatched.Location = New System.Drawing.Point(144, 48)
		Me.cbShowSegmentsMatched.Name = "cbShowSegmentsMatched"
		Me.cbShowSegmentsMatched.Size = New System.Drawing.Size(56, 16)
		Me.cbShowSegmentsMatched.TabIndex = 5
		Me.cbShowSegmentsMatched.Text = "Show"
		'
		'cbShowSegments
		'
		Me.cbShowSegments.Checked = True
		Me.cbShowSegments.CheckState = System.Windows.Forms.CheckState.Checked
		Me.cbShowSegments.Location = New System.Drawing.Point(144, 24)
		Me.cbShowSegments.Name = "cbShowSegments"
		Me.cbShowSegments.Size = New System.Drawing.Size(56, 16)
		Me.cbShowSegments.TabIndex = 4
		Me.cbShowSegments.Text = "Show"
		'
		'pbSegmentsMatchColor
		'
		Me.pbSegmentsMatchColor.BackColor = System.Drawing.Color.Purple
		Me.pbSegmentsMatchColor.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle
		Me.pbSegmentsMatchColor.Location = New System.Drawing.Point(64, 48)
		Me.pbSegmentsMatchColor.Name = "pbSegmentsMatchColor"
		Me.pbSegmentsMatchColor.Size = New System.Drawing.Size(72, 16)
		Me.pbSegmentsMatchColor.TabIndex = 3
		Me.pbSegmentsMatchColor.TabStop = False
		'
		'Label8
		'
		Me.Label8.AutoSize = True
		Me.Label8.Location = New System.Drawing.Point(16, 48)
		Me.Label8.Name = "Label8"
		Me.Label8.Size = New System.Drawing.Size(38, 16)
		Me.Label8.TabIndex = 2
		Me.Label8.Text = "Match:"
		'
		'pbSegmentsColor
		'
		Me.pbSegmentsColor.BackColor = System.Drawing.Color.Lime
		Me.pbSegmentsColor.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle
		Me.pbSegmentsColor.Location = New System.Drawing.Point(64, 24)
		Me.pbSegmentsColor.Name = "pbSegmentsColor"
		Me.pbSegmentsColor.Size = New System.Drawing.Size(72, 16)
		Me.pbSegmentsColor.TabIndex = 1
		Me.pbSegmentsColor.TabStop = False
		'
		'Label9
		'
		Me.Label9.AutoSize = True
		Me.Label9.Location = New System.Drawing.Point(16, 24)
		Me.Label9.Name = "Label9"
		Me.Label9.Size = New System.Drawing.Size(47, 16)
		Me.Label9.TabIndex = 0
		Me.Label9.Text = "Regular:"
		'
		'GroupBox5
		'
		Me.GroupBox5.Controls.Add(Me.Label10)
		Me.GroupBox5.Controls.Add(Me.cbShowDirectionsMatched)
		Me.GroupBox5.Controls.Add(Me.cbShowDirections)
		Me.GroupBox5.Controls.Add(Me.pbDirectionsMatchColor)
		Me.GroupBox5.Controls.Add(Me.Label11)
		Me.GroupBox5.Controls.Add(Me.pbDirectionsColor)
		Me.GroupBox5.Controls.Add(Me.Label12)
		Me.GroupBox5.Location = New System.Drawing.Point(8, 272)
		Me.GroupBox5.Name = "GroupBox5"
		Me.GroupBox5.Size = New System.Drawing.Size(392, 80)
		Me.GroupBox5.TabIndex = 12
		Me.GroupBox5.TabStop = False
		Me.GroupBox5.Text = "Minutiae Direction Colors"
		'
		'Label10
		'
		Me.Label10.Location = New System.Drawing.Point(232, 32)
		Me.Label10.Name = "Label10"
		Me.Label10.Size = New System.Drawing.Size(144, 32)
		Me.Label10.TabIndex = 6
		Me.Label10.Text = "Double click the color to change it."
		'
		'cbShowDirectionsMatched
		'
		Me.cbShowDirectionsMatched.Checked = True
		Me.cbShowDirectionsMatched.CheckState = System.Windows.Forms.CheckState.Checked
		Me.cbShowDirectionsMatched.Location = New System.Drawing.Point(144, 48)
		Me.cbShowDirectionsMatched.Name = "cbShowDirectionsMatched"
		Me.cbShowDirectionsMatched.Size = New System.Drawing.Size(56, 16)
		Me.cbShowDirectionsMatched.TabIndex = 5
		Me.cbShowDirectionsMatched.Text = "Show"
		'
		'cbShowDirections
		'
		Me.cbShowDirections.Checked = True
		Me.cbShowDirections.CheckState = System.Windows.Forms.CheckState.Checked
		Me.cbShowDirections.Location = New System.Drawing.Point(144, 24)
		Me.cbShowDirections.Name = "cbShowDirections"
		Me.cbShowDirections.Size = New System.Drawing.Size(56, 16)
		Me.cbShowDirections.TabIndex = 4
		Me.cbShowDirections.Text = "Show"
		'
		'pbDirectionsMatchColor
		'
		Me.pbDirectionsMatchColor.BackColor = System.Drawing.Color.Purple
		Me.pbDirectionsMatchColor.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle
		Me.pbDirectionsMatchColor.Location = New System.Drawing.Point(64, 48)
		Me.pbDirectionsMatchColor.Name = "pbDirectionsMatchColor"
		Me.pbDirectionsMatchColor.Size = New System.Drawing.Size(72, 16)
		Me.pbDirectionsMatchColor.TabIndex = 3
		Me.pbDirectionsMatchColor.TabStop = False
		'
		'Label11
		'
		Me.Label11.AutoSize = True
		Me.Label11.Location = New System.Drawing.Point(16, 48)
		Me.Label11.Name = "Label11"
		Me.Label11.Size = New System.Drawing.Size(38, 16)
		Me.Label11.TabIndex = 2
		Me.Label11.Text = "Match:"
		'
		'pbDirectionsColor
		'
		Me.pbDirectionsColor.BackColor = System.Drawing.Color.Red
		Me.pbDirectionsColor.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle
		Me.pbDirectionsColor.Location = New System.Drawing.Point(64, 24)
		Me.pbDirectionsColor.Name = "pbDirectionsColor"
		Me.pbDirectionsColor.Size = New System.Drawing.Size(72, 16)
		Me.pbDirectionsColor.TabIndex = 1
		Me.pbDirectionsColor.TabStop = False
		'
		'Label12
		'
		Me.Label12.AutoSize = True
		Me.Label12.Location = New System.Drawing.Point(16, 24)
		Me.Label12.Name = "Label12"
		Me.Label12.Size = New System.Drawing.Size(47, 16)
		Me.Label12.TabIndex = 0
		Me.Label12.Text = "Regular:"
		'
		'OptionsForm
		'
		Me.AutoScaleBaseSize = New System.Drawing.Size(5, 13)
		Me.ClientSize = New System.Drawing.Size(408, 389)
		Me.Controls.Add(Me.GroupBox5)
		Me.Controls.Add(Me.GroupBox4)
		Me.Controls.Add(Me.ButtonCancel)
		Me.Controls.Add(Me.OkButton)
		Me.Controls.Add(Me.GroupBox3)
		Me.Controls.Add(Me.GroupBox2)
		Me.Controls.Add(Me.GroupBox1)
		Me.Icon = CType(resources.GetObject("$this.Icon"), System.Drawing.Icon)
		Me.Name = "OptionsForm"
		Me.Text = "Options"
		Me.GroupBox1.ResumeLayout(False)
		Me.GroupBox2.ResumeLayout(False)
		Me.GroupBox3.ResumeLayout(False)
		Me.GroupBox4.ResumeLayout(False)
		Me.GroupBox5.ResumeLayout(False)
		Me.ResumeLayout(False)

	End Sub

#End Region

	' Commit changes made by user
	Public Sub AcceptChanges()
		clMinutiaeColor = pbMinutiaeColor.BackColor
		clMinutiaeMatchColor = pbMinutiaeMatchColor.BackColor
		clSegmentsColor = pbSegmentsColor.BackColor
		clSegmentsMatchColor = pbSegmentsMatchColor.BackColor
		clDirectionsColor = pbDirectionsColor.BackColor
		clDirectionsMatchColor = pbDirectionsMatchColor.BackColor
		bShowMinutiae = cbShowMinutiae.Checked
		bShowMinutiaeMatch = cbShowMinutiaeMatched.Checked
		bShowSegments = cbShowSegments.Checked
		bShowSegmentsMatch = cbShowSegmentsMatched.Checked
		bShowDirections = cbShowDirections.Checked
		bShowDirectionsMatch = cbShowDirectionsMatched.Checked
	End Sub

	' Set current values of threshold and rotation for verification and identification
	Public Sub setParameters(ByVal thresholdId As Integer, ByVal rotationMaxId As Integer, ByVal thresholdVr As Integer, ByVal rotationMaxVr As Integer)
		ThresholdIdTextBox.Text = thresholdId
		RotationMaxIdTextBox.Text = rotationMaxId
		ThresholdVrTextBox.Text = thresholdVr
		RotationMaxVrTextBox.Text = rotationMaxVr
	End Sub

	' convert Color type to BGR format used by GrFinger
	Private Function Color2BGR(ByVal color As Color) As Integer
		Dim rgb As Integer = color.ToArgb And &HFFFFFF
		Return ((rgb And &HFF00) + ((rgb And &HFF) * 65536) + ((rgb And &HFF0000) / 65536))
	End Function

	' Get new values set by user
	Public Sub getParameters(ByRef thresholdId As Integer, ByRef rotationMaxId As Integer, ByRef thresholdVr As Integer, ByRef rotationMaxVr As Integer, _
					ByRef minutiaeColor As Integer, ByRef minutiaeMatchColor As Integer, ByRef segmentsColor As Integer, ByRef segmentsMatchColor As Integer, _
					ByRef directionsColor As Integer, ByRef directionsMatchColor As Integer)
		' convert threshold and rotation values
		thresholdId = Integer.Parse(ThresholdIdTextBox.Text)
		rotationMaxId = Integer.Parse(RotationMaxIdTextBox.Text)
		thresholdVr = Integer.Parse(ThresholdVrTextBox.Text)
		rotationMaxVr = Integer.Parse(RotationMaxVrTextBox.Text)
		' convert colors to BGR
		minutiaeColor = Color2BGR(pbMinutiaeColor.BackColor)
		minutiaeMatchColor = Color2BGR(pbMinutiaeMatchColor.BackColor)
		segmentsColor = Color2BGR(pbSegmentsColor.BackColor)
		segmentsMatchColor = Color2BGR(pbSegmentsMatchColor.BackColor)
		directionsColor = Color2BGR(pbDirectionsColor.BackColor)
		directionsMatchColor = Color2BGR(pbDirectionsMatchColor.BackColor)
		' check if anything should not be displayed
		If Not (cbShowMinutiae.Checked) Then minutiaeColor = GRConstants.GR_IMAGE_NO_COLOR
		If Not (cbShowMinutiaeMatched.Checked) Then minutiaeMatchColor = GRConstants.GR_IMAGE_NO_COLOR
		If Not (cbShowSegments.Checked) Then segmentsColor = GRConstants.GR_IMAGE_NO_COLOR
		If Not (cbShowSegmentsMatched.Checked) Then segmentsMatchColor = GRConstants.GR_IMAGE_NO_COLOR
		If Not (cbShowDirections.Checked) Then directionsColor = GRConstants.GR_IMAGE_NO_COLOR
		If Not (cbShowDirectionsMatched.Checked) Then directionsMatchColor = GRConstants.GR_IMAGE_NO_COLOR
	End Sub

	' Set current values in GUI
	Private Sub OptionsForm_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
		' if not initialized, get initial values
		If Not (initialized) Then AcceptChanges()
		' set current values in GUI
		pbMinutiaeColor.BackColor = clMinutiaeColor
		pbMinutiaeMatchColor.BackColor = clMinutiaeMatchColor
		pbSegmentsColor.BackColor = clSegmentsColor
		pbSegmentsMatchColor.BackColor = clSegmentsMatchColor
		pbDirectionsColor.BackColor = clDirectionsColor
		pbDirectionsMatchColor.BackColor = clDirectionsMatchColor
		cbShowMinutiae.Checked = bShowMinutiae
		cbShowMinutiaeMatched.Checked = bShowMinutiaeMatch
		cbShowSegments.Checked = bShowSegments
		cbShowSegmentsMatched.Checked = bShowSegmentsMatch
		cbShowDirections.Checked = bShowDirections
		cbShowDirectionsMatched.Checked = bShowDirectionsMatch
		' flag as already initialized
		initialized = True
	End Sub

	' display color dialog and set minutiae color
	Private Sub pbMinutiaeColor_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles pbMinutiaeColor.DoubleClick
		ColorDialog1.Color = pbMinutiaeColor.BackColor
        If ColorDialog1.ShowDialog() = Windows.Forms.DialogResult.OK Then pbMinutiaeColor.BackColor = ColorDialog1.Color
	End Sub

	' display color dialog and set matching minutiae color
	Private Sub pbMinutiaeMatchColor_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles pbMinutiaeMatchColor.DoubleClick
		ColorDialog1.Color = pbMinutiaeMatchColor.BackColor
        If ColorDialog1.ShowDialog() = Windows.Forms.DialogResult.OK Then pbMinutiaeMatchColor.BackColor = ColorDialog1.Color
	End Sub

	' display color dialog and set segments color
	Private Sub pbSegmentsColor_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles pbSegmentsColor.DoubleClick
		ColorDialog1.Color = pbSegmentsColor.BackColor
        If ColorDialog1.ShowDialog() = Windows.Forms.DialogResult.OK Then pbSegmentsColor.BackColor = ColorDialog1.Color
	End Sub

	' display color dialog and set matching segments color
	Private Sub pbSegmentsMatchColor_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles pbSegmentsMatchColor.DoubleClick
		ColorDialog1.Color = pbSegmentsMatchColor.BackColor
        If ColorDialog1.ShowDialog() = Windows.Forms.DialogResult.OK Then pbSegmentsMatchColor.BackColor = ColorDialog1.Color
	End Sub

	' display color dialog and set directions color
	Private Sub pbDirectionsColor_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles pbDirectionsColor.DoubleClick
		ColorDialog1.Color = pbDirectionsColor.BackColor
        If ColorDialog1.ShowDialog() = Windows.Forms.DialogResult.OK Then pbDirectionsColor.BackColor = ColorDialog1.Color
	End Sub

	' display color dialog and set matching directions color
	Private Sub pbDirectionsMatchColor_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles pbDirectionsMatchColor.DoubleClick
		ColorDialog1.Color = pbDirectionsMatchColor.BackColor
        If ColorDialog1.ShowDialog() = Windows.Forms.DialogResult.OK Then pbDirectionsMatchColor.BackColor = ColorDialog1.Color
	End Sub

End Class
