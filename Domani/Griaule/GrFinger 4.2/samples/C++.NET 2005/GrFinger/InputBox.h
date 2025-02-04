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
// GUI routines: InputBox-like form
// -----------------------------------------------------------------------------------

#pragma once

using namespace System;
using namespace System::ComponentModel;
using namespace System::Collections;
using namespace System::Windows::Forms;
using namespace System::Data;
using namespace System::Drawing;


namespace GrFingerSampleCPPdotNET2005
{
	public __gc class InputBox : public System::Windows::Forms::Form
	{
	public: 
		InputBox(void)
		{
			InitializeComponent();
		}
        
	protected: 
		void Dispose(Boolean disposing)
		{
			if (disposing && components)
			{
				components->Dispose();
			}
			__super::Dispose(disposing);
		}
	public: System::Windows::Forms::Label *  lbCaption;
	private: System::Windows::Forms::Button *  button1;
	private: System::Windows::Forms::Button *  button2;
	public: System::Windows::Forms::TextBox *  textBox1;

	private:
		System::ComponentModel::Container* components;

		void InitializeComponent(void)
		{
			this->lbCaption = new System::Windows::Forms::Label();
			this->button1 = new System::Windows::Forms::Button();
			this->button2 = new System::Windows::Forms::Button();
			this->textBox1 = new System::Windows::Forms::TextBox();
			this->SuspendLayout();
			// 
			// lbCaption
			// 
			this->lbCaption->Location = System::Drawing::Point(8, 8);
			this->lbCaption->Name = S"lbCaption";
			this->lbCaption->Size = System::Drawing::Size(264, 40);
			this->lbCaption->TabIndex = 0;
			this->lbCaption->Text = S"label1";
			// 
			// button1
			// 
			this->button1->DialogResult = System::Windows::Forms::DialogResult::OK;
			this->button1->Location = System::Drawing::Point(288, 8);
			this->button1->Name = S"button1";
			this->button1->Size = System::Drawing::Size(56, 24);
			this->button1->TabIndex = 2;
			this->button1->Text = S"OK";
			// 
			// button2
			// 
			this->button2->DialogResult = System::Windows::Forms::DialogResult::Cancel;
			this->button2->Location = System::Drawing::Point(288, 40);
			this->button2->Name = S"button2";
			this->button2->Size = System::Drawing::Size(56, 24);
			this->button2->TabIndex = 3;
			this->button2->Text = S"Cancel";
			// 
			// textBox1
			// 
			this->textBox1->Location = System::Drawing::Point(8, 88);
			this->textBox1->Name = S"textBox1";
			this->textBox1->Size = System::Drawing::Size(336, 20);
			this->textBox1->TabIndex = 1;
			this->textBox1->Text = S"";
			this->textBox1->KeyPress += new System::Windows::Forms::KeyPressEventHandler(this, &GrFingerSampleCPPdotNET2005::InputBox::textBox1_KeyPress);
			// 
			// InputBox
			// 
			this->AutoScaleBaseSize = System::Drawing::Size(5, 13);
			this->ClientSize = System::Drawing::Size(352, 117);
			this->ControlBox = false;
			this->Controls->Add(this->textBox1);
			this->Controls->Add(this->button2);
			this->Controls->Add(this->button1);
			this->Controls->Add(this->lbCaption);
			this->FormBorderStyle = System::Windows::Forms::FormBorderStyle::FixedToolWindow;
			this->MaximizeBox = false;
			this->Name = S"InputBox";
			this->StartPosition = System::Windows::Forms::FormStartPosition::CenterScreen;
			this->Text = S"InputBox";
			this->Load += new System::EventHandler(this, &GrFingerSampleCPPdotNET2005::InputBox::InputBox_Load);
			this->ResumeLayout(false);

		}		




	

	// Show form as modal and return typed by user
	public: static String *ShowModal(String *text, String *caption, String *defaultvalue) {
				// create form
				InputBox *ib = new InputBox();
				// set parameters
				ib->Text = caption;
				ib->lbCaption->Text = text;
				ib->textBox1->Text = defaultvalue;
				// show dialog and return value
				if (ib->ShowDialog() == DialogResult::OK) {
					return ib->textBox1->Text;
				}
				return new String("");
	}

	// Close window if user hit RETURN key
	private: System::Void textBox1_KeyPress(System::Object *  sender, System::Windows::Forms::KeyPressEventArgs *  e) {
			 if (e->get_KeyChar() == 13) button1->PerformClick();
	}

    // Focus when the window if displayed
	private: System::Void InputBox_Load(System::Object *  sender, System::EventArgs *  e) {
			textBox1->Focus();
	}

};
}