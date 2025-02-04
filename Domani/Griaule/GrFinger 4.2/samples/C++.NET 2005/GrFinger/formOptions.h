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
// GUI routines: "Options" form
// -----------------------------------------------------------------------------------

#pragma once

using namespace System;
using namespace System::ComponentModel;
using namespace System::Collections;
using namespace System::Windows::Forms;
using namespace System::Data;
using namespace System::Drawing;

#include "GrFinger.h"

namespace GrFingerSampleCPPdotNET2005
{
	public __gc class formOptions : public System::Windows::Forms::Form
	{
	public: 
		formOptions(void)
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
	private: System::Windows::Forms::GroupBox *  groupBox1;
	private: System::Windows::Forms::Label *  label1;

	private: System::Windows::Forms::Label *  label2;

	private: System::Windows::Forms::GroupBox *  groupBox2;


	private: System::Windows::Forms::Label *  label3;
	private: System::Windows::Forms::Label *  label4;
	private: System::Windows::Forms::Button *  btOk;
	private: System::Windows::Forms::Button *  btCancel;
	public: System::Windows::Forms::TextBox *  tbIdentThreshold;
	public: System::Windows::Forms::TextBox *  tbIdentRotTol;
	public: System::Windows::Forms::TextBox *  tbVerifRotTol;
	public: System::Windows::Forms::TextBox *  tbVerifThreshold;
	private: System::Windows::Forms::GroupBox *  groupBox3;
	private: System::Windows::Forms::Label *  label5;
	private: System::Windows::Forms::Label *  label6;




	private: System::Windows::Forms::Label *  label7;
	private: System::Windows::Forms::GroupBox *  groupBox4;
	private: System::Windows::Forms::Label *  label8;




	private: System::Windows::Forms::Label *  label9;
	private: System::Windows::Forms::Label *  label10;
	private: System::Windows::Forms::GroupBox *  groupBox5;
	private: System::Windows::Forms::Label *  label11;




	private: System::Windows::Forms::Label *  label12;
	private: System::Windows::Forms::Label *  label13;

	private: Color clMinutiaeColor;
	private: Color clMinutiaeMatchColor;
	private: Color clSegmentsColor;
	private: Color clSegmentsMatchColor;
	private: Color clDirectionsColor;
	private: Color clDirectionsMatchColor;
	private: bool bShowMinutiae;
	private: bool bShowMinutiaeMatch;
	private: bool bShowSegments;
	private: bool bShowSegmentsMatch;
	private: bool bShowDirections;
	private: bool bShowDirectionsMatch;
	private: bool initialized;
	private: System::Windows::Forms::PictureBox *  pbMinutiaeMatchColor;
	private: System::Windows::Forms::PictureBox *  pbMinutiaeColor;
	private: System::Windows::Forms::PictureBox *  pbSegmentsColor;
	private: System::Windows::Forms::PictureBox *  pbSegmentsMatchColor;
	private: System::Windows::Forms::PictureBox *  pbDirectionsMatchColor;
	private: System::Windows::Forms::PictureBox *  pbDirectionsColor;
	private: System::Windows::Forms::CheckBox *  cbShowMinutiaeMatched;
	private: System::Windows::Forms::CheckBox *  cbShowMinutiae;
	private: System::Windows::Forms::CheckBox *  cbShowSegmentsMatched;
	private: System::Windows::Forms::CheckBox *  cbShowSegments;
	private: System::Windows::Forms::CheckBox *  cbShowDirectionsMatched;
	private: System::Windows::Forms::CheckBox *  cbShowDirections;
	private: System::Windows::Forms::ColorDialog *  colorDialog1;

	private:
		System::ComponentModel::Container* components;
		void InitializeComponent(void)
		{
			this->groupBox1 = new System::Windows::Forms::GroupBox();
			this->tbVerifRotTol = new System::Windows::Forms::TextBox();
			this->tbVerifThreshold = new System::Windows::Forms::TextBox();
			this->label1 = new System::Windows::Forms::Label();
			this->label2 = new System::Windows::Forms::Label();
			this->groupBox2 = new System::Windows::Forms::GroupBox();
			this->tbIdentRotTol = new System::Windows::Forms::TextBox();
			this->tbIdentThreshold = new System::Windows::Forms::TextBox();
			this->label3 = new System::Windows::Forms::Label();
			this->label4 = new System::Windows::Forms::Label();
			this->btOk = new System::Windows::Forms::Button();
			this->btCancel = new System::Windows::Forms::Button();
			this->groupBox3 = new System::Windows::Forms::GroupBox();
			this->label7 = new System::Windows::Forms::Label();
			this->cbShowMinutiaeMatched = new System::Windows::Forms::CheckBox();
			this->cbShowMinutiae = new System::Windows::Forms::CheckBox();
			this->pbMinutiaeMatchColor = new System::Windows::Forms::PictureBox();
			this->pbMinutiaeColor = new System::Windows::Forms::PictureBox();
			this->label6 = new System::Windows::Forms::Label();
			this->label5 = new System::Windows::Forms::Label();
			this->groupBox4 = new System::Windows::Forms::GroupBox();
			this->label8 = new System::Windows::Forms::Label();
			this->cbShowSegmentsMatched = new System::Windows::Forms::CheckBox();
			this->cbShowSegments = new System::Windows::Forms::CheckBox();
			this->pbSegmentsMatchColor = new System::Windows::Forms::PictureBox();
			this->pbSegmentsColor = new System::Windows::Forms::PictureBox();
			this->label9 = new System::Windows::Forms::Label();
			this->label10 = new System::Windows::Forms::Label();
			this->groupBox5 = new System::Windows::Forms::GroupBox();
			this->label11 = new System::Windows::Forms::Label();
			this->cbShowDirectionsMatched = new System::Windows::Forms::CheckBox();
			this->cbShowDirections = new System::Windows::Forms::CheckBox();
			this->pbDirectionsMatchColor = new System::Windows::Forms::PictureBox();
			this->pbDirectionsColor = new System::Windows::Forms::PictureBox();
			this->label12 = new System::Windows::Forms::Label();
			this->label13 = new System::Windows::Forms::Label();
			this->colorDialog1 = new System::Windows::Forms::ColorDialog();
			this->groupBox1->SuspendLayout();
			this->groupBox2->SuspendLayout();
			this->groupBox3->SuspendLayout();
			this->groupBox4->SuspendLayout();
			this->groupBox5->SuspendLayout();
			this->SuspendLayout();
			// 
			// groupBox1
			// 
			this->groupBox1->Controls->Add(this->tbVerifRotTol);
			this->groupBox1->Controls->Add(this->tbVerifThreshold);
			this->groupBox1->Controls->Add(this->label1);
			this->groupBox1->Controls->Add(this->label2);
			this->groupBox1->Location = System::Drawing::Point(184, 8);
			this->groupBox1->Name = S"groupBox1";
			this->groupBox1->Size = System::Drawing::Size(168, 88);
			this->groupBox1->TabIndex = 0;
			this->groupBox1->TabStop = false;
			this->groupBox1->Text = S"Verify";
			// 
			// tbVerifRotTol
			// 
			this->tbVerifRotTol->Location = System::Drawing::Point(104, 56);
			this->tbVerifRotTol->Name = S"tbVerifRotTol";
			this->tbVerifRotTol->Size = System::Drawing::Size(56, 20);
			this->tbVerifRotTol->TabIndex = 8;
			this->tbVerifRotTol->Text = S"";
			// 
			// tbVerifThreshold
			// 
			this->tbVerifThreshold->Location = System::Drawing::Point(104, 24);
			this->tbVerifThreshold->Name = S"tbVerifThreshold";
			this->tbVerifThreshold->Size = System::Drawing::Size(56, 20);
			this->tbVerifThreshold->TabIndex = 6;
			this->tbVerifThreshold->Text = S"";
			// 
			// label1
			// 
			this->label1->AutoSize = true;
			this->label1->Location = System::Drawing::Point(48, 24);
			this->label1->Name = S"label1";
			this->label1->Size = System::Drawing::Size(58, 16);
			this->label1->TabIndex = 0;
			this->label1->Text = S"Threshold:";
			// 
			// label2
			// 
			this->label2->AutoSize = true;
			this->label2->Location = System::Drawing::Point(8, 56);
			this->label2->Name = S"label2";
			this->label2->Size = System::Drawing::Size(99, 16);
			this->label2->TabIndex = 0;
			this->label2->Text = S"Rotation tolerance:";
			// 
			// groupBox2
			// 
			this->groupBox2->Controls->Add(this->tbIdentRotTol);
			this->groupBox2->Controls->Add(this->tbIdentThreshold);
			this->groupBox2->Controls->Add(this->label3);
			this->groupBox2->Controls->Add(this->label4);
			this->groupBox2->Location = System::Drawing::Point(8, 8);
			this->groupBox2->Name = S"groupBox2";
			this->groupBox2->Size = System::Drawing::Size(168, 88);
			this->groupBox2->TabIndex = 0;
			this->groupBox2->TabStop = false;
			this->groupBox2->Text = S"Identify";
			// 
			// tbIdentRotTol
			// 
			this->tbIdentRotTol->Location = System::Drawing::Point(104, 56);
			this->tbIdentRotTol->Name = S"tbIdentRotTol";
			this->tbIdentRotTol->Size = System::Drawing::Size(56, 20);
			this->tbIdentRotTol->TabIndex = 4;
			this->tbIdentRotTol->Text = S"";
			// 
			// tbIdentThreshold
			// 
			this->tbIdentThreshold->Location = System::Drawing::Point(104, 24);
			this->tbIdentThreshold->Name = S"tbIdentThreshold";
			this->tbIdentThreshold->Size = System::Drawing::Size(56, 20);
			this->tbIdentThreshold->TabIndex = 2;
			this->tbIdentThreshold->Text = S"";
			// 
			// label3
			// 
			this->label3->AutoSize = true;
			this->label3->Location = System::Drawing::Point(48, 24);
			this->label3->Name = S"label3";
			this->label3->Size = System::Drawing::Size(58, 16);
			this->label3->TabIndex = 0;
			this->label3->Text = S"Threshold:";
			// 
			// label4
			// 
			this->label4->AutoSize = true;
			this->label4->Location = System::Drawing::Point(8, 56);
			this->label4->Name = S"label4";
			this->label4->Size = System::Drawing::Size(99, 16);
			this->label4->TabIndex = 0;
			this->label4->Text = S"Rotation tolerance:";
			// 
			// btOk
			// 
			this->btOk->DialogResult = System::Windows::Forms::DialogResult::OK;
			this->btOk->Location = System::Drawing::Point(112, 392);
			this->btOk->Name = S"btOk";
			this->btOk->Size = System::Drawing::Size(64, 24);
			this->btOk->TabIndex = 10;
			this->btOk->Text = S"OK";
			// 
			// btCancel
			// 
			this->btCancel->DialogResult = System::Windows::Forms::DialogResult::Cancel;
			this->btCancel->Location = System::Drawing::Point(192, 392);
			this->btCancel->Name = S"btCancel";
			this->btCancel->Size = System::Drawing::Size(64, 24);
			this->btCancel->TabIndex = 12;
			this->btCancel->Text = S"Cancel";
			// 
			// groupBox3
			// 
			this->groupBox3->Controls->Add(this->label7);
			this->groupBox3->Controls->Add(this->cbShowMinutiaeMatched);
			this->groupBox3->Controls->Add(this->cbShowMinutiae);
			this->groupBox3->Controls->Add(this->pbMinutiaeMatchColor);
			this->groupBox3->Controls->Add(this->pbMinutiaeColor);
			this->groupBox3->Controls->Add(this->label6);
			this->groupBox3->Controls->Add(this->label5);
			this->groupBox3->Location = System::Drawing::Point(8, 104);
			this->groupBox3->Name = S"groupBox3";
			this->groupBox3->Size = System::Drawing::Size(344, 88);
			this->groupBox3->TabIndex = 13;
			this->groupBox3->TabStop = false;
			this->groupBox3->Text = S"Minutiae Colors";
			// 
			// label7
			// 
			this->label7->Location = System::Drawing::Point(232, 32);
			this->label7->Name = S"label7";
			this->label7->Size = System::Drawing::Size(96, 32);
			this->label7->TabIndex = 6;
			this->label7->Text = S"Double click the color to change it.";
			// 
			// cbShowMinutiaeMatched
			// 
			this->cbShowMinutiaeMatched->Checked = true;
			this->cbShowMinutiaeMatched->CheckState = System::Windows::Forms::CheckState::Checked;
			this->cbShowMinutiaeMatched->Location = System::Drawing::Point(160, 56);
			this->cbShowMinutiaeMatched->Name = S"cbShowMinutiaeMatched";
			this->cbShowMinutiaeMatched->Size = System::Drawing::Size(56, 16);
			this->cbShowMinutiaeMatched->TabIndex = 5;
			this->cbShowMinutiaeMatched->Text = S"Show";
			// 
			// cbShowMinutiae
			// 
			this->cbShowMinutiae->Checked = true;
			this->cbShowMinutiae->CheckState = System::Windows::Forms::CheckState::Checked;
			this->cbShowMinutiae->Location = System::Drawing::Point(160, 24);
			this->cbShowMinutiae->Name = S"cbShowMinutiae";
			this->cbShowMinutiae->Size = System::Drawing::Size(56, 16);
			this->cbShowMinutiae->TabIndex = 4;
			this->cbShowMinutiae->Text = S"Show";
			// 
			// pbMinutiaeMatchColor
			// 
			this->pbMinutiaeMatchColor->BackColor = System::Drawing::Color::Purple;
			this->pbMinutiaeMatchColor->BorderStyle = System::Windows::Forms::BorderStyle::FixedSingle;
			this->pbMinutiaeMatchColor->Location = System::Drawing::Point(80, 56);
			this->pbMinutiaeMatchColor->Name = S"pbMinutiaeMatchColor";
			this->pbMinutiaeMatchColor->Size = System::Drawing::Size(72, 16);
			this->pbMinutiaeMatchColor->TabIndex = 3;
			this->pbMinutiaeMatchColor->TabStop = false;
			
			this->pbMinutiaeMatchColor->DoubleClick += new System::EventHandler(this, &GrFingerSampleCPPdotNET2005::formOptions::pbMinutiaeMatchColor_DoubleClick);
			// 
			// pbMinutiaeColor
			// 
			this->pbMinutiaeColor->BackColor = System::Drawing::Color::Blue;
			this->pbMinutiaeColor->BorderStyle = System::Windows::Forms::BorderStyle::FixedSingle;
			this->pbMinutiaeColor->Location = System::Drawing::Point(80, 24);
			this->pbMinutiaeColor->Name = S"pbMinutiaeColor";
			this->pbMinutiaeColor->Size = System::Drawing::Size(72, 16);
			this->pbMinutiaeColor->TabIndex = 2;
			this->pbMinutiaeColor->TabStop = false;
			this->pbMinutiaeColor->DoubleClick += new System::EventHandler(this, &GrFingerSampleCPPdotNET2005::formOptions::pbMinutiaeColor_DoubleClick);
			// 
			// label6
			// 
			this->label6->AutoSize = true;
			this->label6->Location = System::Drawing::Point(16, 56);
			this->label6->Name = S"label6";
			this->label6->Size = System::Drawing::Size(38, 16);
			this->label6->TabIndex = 1;
			this->label6->Text = S"Match:";
			// 
			// label5
			// 
			this->label5->AutoSize = true;
			this->label5->Location = System::Drawing::Point(16, 24);
			this->label5->Name = S"label5";
			this->label5->Size = System::Drawing::Size(47, 16);
			this->label5->TabIndex = 0;
			this->label5->Text = S"Regular:";
			// 
			// groupBox4
			// 
			this->groupBox4->Controls->Add(this->label8);
			this->groupBox4->Controls->Add(this->cbShowSegmentsMatched);
			this->groupBox4->Controls->Add(this->cbShowSegments);
			this->groupBox4->Controls->Add(this->pbSegmentsMatchColor);
			this->groupBox4->Controls->Add(this->pbSegmentsColor);
			this->groupBox4->Controls->Add(this->label9);
			this->groupBox4->Controls->Add(this->label10);
			this->groupBox4->Location = System::Drawing::Point(8, 200);
			this->groupBox4->Name = S"groupBox4";
			this->groupBox4->Size = System::Drawing::Size(344, 88);
			this->groupBox4->TabIndex = 14;
			this->groupBox4->TabStop = false;
			this->groupBox4->Text = S"Segments Colors";
			// 
			// label8
			// 
			this->label8->Location = System::Drawing::Point(232, 32);
			this->label8->Name = S"label8";
			this->label8->Size = System::Drawing::Size(96, 32);
			this->label8->TabIndex = 6;
			this->label8->Text = S"Double click the color to change it.";
			// 
			// cbShowSegmentsMatched
			// 
			this->cbShowSegmentsMatched->Checked = true;
			this->cbShowSegmentsMatched->CheckState = System::Windows::Forms::CheckState::Checked;
			this->cbShowSegmentsMatched->Location = System::Drawing::Point(160, 56);
			this->cbShowSegmentsMatched->Name = S"cbShowSegmentsMatched";
			this->cbShowSegmentsMatched->Size = System::Drawing::Size(56, 16);
			this->cbShowSegmentsMatched->TabIndex = 5;
			this->cbShowSegmentsMatched->Text = S"Show";
			// 
			// cbShowSegments
			// 
			this->cbShowSegments->Checked = true;
			this->cbShowSegments->CheckState = System::Windows::Forms::CheckState::Checked;
			this->cbShowSegments->Location = System::Drawing::Point(160, 24);
			this->cbShowSegments->Name = S"cbShowSegments";
			this->cbShowSegments->Size = System::Drawing::Size(56, 16);
			this->cbShowSegments->TabIndex = 4;
			this->cbShowSegments->Text = S"Show";
			// 
			// pbSegmentsMatchColor
			// 
			this->pbSegmentsMatchColor->BackColor = System::Drawing::Color::Purple;
			this->pbSegmentsMatchColor->BorderStyle = System::Windows::Forms::BorderStyle::FixedSingle;
			this->pbSegmentsMatchColor->Location = System::Drawing::Point(80, 56);
			this->pbSegmentsMatchColor->Name = S"pbSegmentsMatchColor";
			this->pbSegmentsMatchColor->Size = System::Drawing::Size(72, 16);
			this->pbSegmentsMatchColor->TabIndex = 3;
			this->pbSegmentsMatchColor->TabStop = false;
			this->pbSegmentsMatchColor->DoubleClick += new System::EventHandler(this, &GrFingerSampleCPPdotNET2005::formOptions::pbSegmentsMatchColor_DoubleClick);
			// 
			// pbSegmentsColor
			// 
			this->pbSegmentsColor->BackColor = System::Drawing::Color::Lime;
			this->pbSegmentsColor->BorderStyle = System::Windows::Forms::BorderStyle::FixedSingle;
			this->pbSegmentsColor->Location = System::Drawing::Point(80, 24);
			this->pbSegmentsColor->Name = S"pbSegmentsColor";
			this->pbSegmentsColor->Size = System::Drawing::Size(72, 16);
			this->pbSegmentsColor->TabIndex = 2;
			this->pbSegmentsColor->TabStop = false;
			this->pbSegmentsColor->DoubleClick += new System::EventHandler(this, &GrFingerSampleCPPdotNET2005::formOptions::pbSegmentsColor_DoubleClick);
			// 
			// label9
			// 
			this->label9->AutoSize = true;
			this->label9->Location = System::Drawing::Point(16, 56);
			this->label9->Name = S"label9";
			this->label9->Size = System::Drawing::Size(38, 16);
			this->label9->TabIndex = 1;
			this->label9->Text = S"Match:";
			// 
			// label10
			// 
			this->label10->AutoSize = true;
			this->label10->Location = System::Drawing::Point(16, 24);
			this->label10->Name = S"label10";
			this->label10->Size = System::Drawing::Size(47, 16);
			this->label10->TabIndex = 0;
			this->label10->Text = S"Regular:";
			// 
			// groupBox5
			// 
			this->groupBox5->Controls->Add(this->label11);
			this->groupBox5->Controls->Add(this->cbShowDirectionsMatched);
			this->groupBox5->Controls->Add(this->cbShowDirections);
			this->groupBox5->Controls->Add(this->pbDirectionsMatchColor);
			this->groupBox5->Controls->Add(this->pbDirectionsColor);
			this->groupBox5->Controls->Add(this->label12);
			this->groupBox5->Controls->Add(this->label13);
			this->groupBox5->Location = System::Drawing::Point(8, 296);
			this->groupBox5->Name = S"groupBox5";
			this->groupBox5->Size = System::Drawing::Size(344, 88);
			this->groupBox5->TabIndex = 15;
			this->groupBox5->TabStop = false;
			this->groupBox5->Text = S"Directions Colors";
			// 
			// label11
			// 
			this->label11->Location = System::Drawing::Point(232, 32);
			this->label11->Name = S"label11";
			this->label11->Size = System::Drawing::Size(96, 32);
			this->label11->TabIndex = 6;
			this->label11->Text = S"Double click the color to change it.";
			// 
			// cbShowDirectionsMatched
			// 
			this->cbShowDirectionsMatched->Checked = true;
			this->cbShowDirectionsMatched->CheckState = System::Windows::Forms::CheckState::Checked;
			this->cbShowDirectionsMatched->Location = System::Drawing::Point(160, 56);
			this->cbShowDirectionsMatched->Name = S"cbShowDirectionsMatched";
			this->cbShowDirectionsMatched->Size = System::Drawing::Size(56, 16);
			this->cbShowDirectionsMatched->TabIndex = 5;
			this->cbShowDirectionsMatched->Text = S"Show";
			// 
			// cbShowDirections
			// 
			this->cbShowDirections->Checked = true;
			this->cbShowDirections->CheckState = System::Windows::Forms::CheckState::Checked;
			this->cbShowDirections->Location = System::Drawing::Point(160, 24);
			this->cbShowDirections->Name = S"cbShowDirections";
			this->cbShowDirections->Size = System::Drawing::Size(56, 16);
			this->cbShowDirections->TabIndex = 4;
			this->cbShowDirections->Text = S"Show";
			// 
			// pbDirectionsMatchColor
			// 
			this->pbDirectionsMatchColor->BackColor = System::Drawing::Color::Purple;
			this->pbDirectionsMatchColor->BorderStyle = System::Windows::Forms::BorderStyle::FixedSingle;
			this->pbDirectionsMatchColor->Location = System::Drawing::Point(80, 56);
			this->pbDirectionsMatchColor->Name = S"pbDirectionsMatchColor";
			this->pbDirectionsMatchColor->Size = System::Drawing::Size(72, 16);
			this->pbDirectionsMatchColor->TabIndex = 3;
			this->pbDirectionsMatchColor->TabStop = false;
			this->pbDirectionsMatchColor->Click += new System::EventHandler(this, &GrFingerSampleCPPdotNET2005::formOptions::pbDirectionsMatchColor_Click);
			// 
			// pbDirectionsColor
			// 
			this->pbDirectionsColor->BackColor = System::Drawing::Color::Red;
			this->pbDirectionsColor->BorderStyle = System::Windows::Forms::BorderStyle::FixedSingle;
			this->pbDirectionsColor->Location = System::Drawing::Point(80, 24);
			this->pbDirectionsColor->Name = S"pbDirectionsColor";
			this->pbDirectionsColor->Size = System::Drawing::Size(72, 16);
			this->pbDirectionsColor->TabIndex = 2;
			this->pbDirectionsColor->TabStop = false;
			this->pbDirectionsColor->DoubleClick += new System::EventHandler(this, &GrFingerSampleCPPdotNET2005::formOptions::pbDirectionsColor_DoubleClick);
			// 
			// label12
			// 
			this->label12->AutoSize = true;
			this->label12->Location = System::Drawing::Point(16, 56);
			this->label12->Name = S"label12";
			this->label12->Size = System::Drawing::Size(38, 16);
			this->label12->TabIndex = 1;
			this->label12->Text = S"Match:";
			// 
			// label13
			// 
			this->label13->AutoSize = true;
			this->label13->Location = System::Drawing::Point(16, 24);
			this->label13->Name = S"label13";
			this->label13->Size = System::Drawing::Size(47, 16);
			this->label13->TabIndex = 0;
			this->label13->Text = S"Regular:";
			// 
			// formOptions
			// 
			this->AcceptButton = this->btOk;
			this->AutoScaleBaseSize = System::Drawing::Size(5, 13);
			this->CancelButton = this->btCancel;
			this->ClientSize = System::Drawing::Size(362, 423);
			this->Controls->Add(this->groupBox5);
			this->Controls->Add(this->groupBox4);
			this->Controls->Add(this->groupBox3);
			this->Controls->Add(this->btOk);
			this->Controls->Add(this->groupBox1);
			this->Controls->Add(this->groupBox2);
			this->Controls->Add(this->btCancel);
			this->FormBorderStyle = System::Windows::Forms::FormBorderStyle::FixedDialog;
			this->MaximizeBox = false;
			this->MinimizeBox = false;
			this->Name = S"formOptions";
			this->StartPosition = System::Windows::Forms::FormStartPosition::CenterScreen;
			this->Text = S"Options";
			this->Load += new System::EventHandler(this, &GrFingerSampleCPPdotNET2005::formOptions::formOptions_Load);
			this->groupBox1->ResumeLayout(false);
			this->groupBox2->ResumeLayout(false);
			this->groupBox3->ResumeLayout(false);
			this->groupBox4->ResumeLayout(false);
			this->groupBox5->ResumeLayout(false);
			this->ResumeLayout(false);

		}		


	
	// Commit changes made by user
	public: void acceptChanges() {
        clMinutiaeColor = pbMinutiaeColor->BackColor;
        clMinutiaeMatchColor = pbMinutiaeMatchColor->BackColor;
        clSegmentsColor = pbSegmentsColor->BackColor;
        clSegmentsMatchColor = pbSegmentsMatchColor->BackColor;
        clDirectionsColor = pbDirectionsColor->BackColor;
        clDirectionsMatchColor = pbDirectionsMatchColor->BackColor;
        bShowMinutiae = cbShowMinutiae->Checked;
        bShowMinutiaeMatch = cbShowMinutiaeMatched->Checked;
        bShowSegments = cbShowSegments->Checked;
        bShowSegmentsMatch = cbShowSegmentsMatched->Checked;
        bShowDirections = cbShowDirections->Checked;
        bShowDirectionsMatch = cbShowDirectionsMatched->Checked;
	}

	// Set current values of threshold and rotation for verification and identification
	public: void setParameters(int thresholdId, int rotationMaxId, int thresholdVr, int rotationMaxVr) {
		tbIdentThreshold->Text = Convert::ToString(thresholdId);
        tbIdentRotTol->Text = Convert::ToString(rotationMaxId);
        tbVerifThreshold->Text = Convert::ToString(thresholdVr);
        tbVerifRotTol->Text = Convert::ToString(rotationMaxVr);
	}

    // Convert Color type to BGR format used by GrFinger
	private: int Color2BGR(Color &color) {
        int rgb = color.ToArgb() & 0xFFFFFF;
        return (rgb & 0xFF00) + ((rgb & 0xFF) << 16) + ((rgb & 0xFF0000) >> 16);
	}

	// Get new values set by user
	public: void getParameters(int *thresholdId, int *rotationMaxId, int *thresholdVr, int *rotationMaxVr,
            int *minutiaeColor, int *minutiaeMatchColor, int *segmentsColor, int *segmentsMatchColor,
			int *directionsColor, int *directionsMatchColor) {
		// convert threshold and rotation values
		*thresholdId = Convert::ToInt32(tbIdentThreshold->Text);
		*rotationMaxId = Convert::ToInt32(tbIdentRotTol->Text);
        *thresholdVr = Convert::ToInt32(tbVerifThreshold->Text);
        *rotationMaxVr = Convert::ToInt32(tbVerifRotTol->Text);
		// convert colors to BGR
        *minutiaeColor = Color2BGR(pbMinutiaeColor->BackColor);
        *minutiaeMatchColor = Color2BGR(pbMinutiaeMatchColor->BackColor);
        *segmentsColor = Color2BGR(pbSegmentsColor->BackColor);
        *segmentsMatchColor = Color2BGR(pbSegmentsMatchColor->BackColor);
        *directionsColor = Color2BGR(pbDirectionsColor->BackColor);
        *directionsMatchColor = Color2BGR(pbDirectionsMatchColor->BackColor);
		// check if anything should not be displayed
        if (!cbShowMinutiae->Checked) *minutiaeColor = GR_IMAGE_NO_COLOR;
        if (!cbShowMinutiaeMatched->Checked) *minutiaeMatchColor = GR_IMAGE_NO_COLOR;
        if (!cbShowSegments->Checked) *segmentsColor = GR_IMAGE_NO_COLOR;
        if (!cbShowSegmentsMatched->Checked) *segmentsMatchColor = GR_IMAGE_NO_COLOR;
        if (!cbShowDirections->Checked) *directionsColor = GR_IMAGE_NO_COLOR;
        if (!cbShowDirectionsMatched->Checked) *directionsMatchColor = GR_IMAGE_NO_COLOR;
    }

	// Set current values in the GUI
	private: System::Void formOptions_Load(System::Object *  sender, System::EventArgs *  e) {
	    // if not initialized, get initial values
        if (!initialized) acceptChanges();
		// set current values in GUI
        pbMinutiaeColor->BackColor = clMinutiaeColor;
        pbMinutiaeMatchColor->BackColor = clMinutiaeMatchColor;
		pbSegmentsColor->BackColor = clSegmentsColor;
        pbSegmentsMatchColor->BackColor = clSegmentsMatchColor;
        pbDirectionsColor->BackColor = clDirectionsColor;
        pbDirectionsMatchColor->BackColor = clDirectionsMatchColor;
        cbShowMinutiae->Checked = bShowMinutiae;
        cbShowMinutiaeMatched->Checked = bShowMinutiaeMatch;
        cbShowSegments->Checked = bShowSegments;
        cbShowSegmentsMatched->Checked = bShowSegmentsMatch;
        cbShowDirections->Checked = bShowDirections;
		cbShowDirectionsMatched->Checked = bShowDirectionsMatch;
		// flag as already initialized
        initialized = true;
    }

    // display color dialog and set minutiae color
	private: System::Void pbMinutiaeColor_DoubleClick(System::Object *  sender, System::EventArgs *  e) {
		colorDialog1->Color = pbMinutiaeColor->BackColor;
		if (colorDialog1->ShowDialog() == DialogResult::OK) {
		pbMinutiaeColor->BackColor = colorDialog1->Color;
		}
	}

    // display color dialog and set minutiae color
	private: System::Void pbMinutiaeMatchColor_DoubleClick(System::Object *  sender, System::EventArgs *  e) {
		colorDialog1->Color = pbMinutiaeMatchColor->BackColor;
		if (colorDialog1->ShowDialog() == DialogResult::OK) {
		pbMinutiaeMatchColor->BackColor = colorDialog1->Color;
		}
	}

    // display color dialog and set color
	private: System::Void pbSegmentsColor_DoubleClick(System::Object *  sender, System::EventArgs *  e) {
		colorDialog1->Color = pbSegmentsColor->BackColor;
		if (colorDialog1->ShowDialog() == DialogResult::OK) {
		pbSegmentsColor->BackColor = colorDialog1->Color;
		}
	}

    // display color dialog and set matching segments color
	private: System::Void pbSegmentsMatchColor_DoubleClick(System::Object *  sender, System::EventArgs *  e) {
		colorDialog1->Color = pbSegmentsMatchColor->BackColor;
		if (colorDialog1->ShowDialog() == DialogResult::OK) {
		pbSegmentsMatchColor->BackColor = colorDialog1->Color;
		}
	}

    // display color dialog and set directions color
	private: System::Void pbDirectionsColor_DoubleClick(System::Object *  sender, System::EventArgs *  e) {
		colorDialog1->Color = pbDirectionsColor->BackColor;
		if (colorDialog1->ShowDialog() == DialogResult::OK) {
		pbDirectionsColor->BackColor = colorDialog1->Color;
		}
	}

    // display color dialog and set matching directions color
	private: System::Void pbDirectionsMatchColor_Click(System::Object *  sender, System::EventArgs *  e) {
		colorDialog1->Color = pbDirectionsMatchColor->BackColor;
		if (colorDialog1->ShowDialog() == DialogResult::OK) {
		pbDirectionsMatchColor->BackColor = colorDialog1->Color;
		}
	}

};
}