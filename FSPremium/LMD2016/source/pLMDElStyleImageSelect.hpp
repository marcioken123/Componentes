// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'pLMDElStyleImageSelect.pas' rev: 31.00 (Windows)

#ifndef PlmdelstyleimageselectHPP
#define PlmdelstyleimageselectHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <Winapi.Messages.hpp>
#include <System.SysUtils.hpp>
#include <System.Classes.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.Forms.hpp>
#include <Vcl.Dialogs.hpp>
#include <Vcl.Clipbrd.hpp>
#include <LMDElConst.hpp>
#include <ElXPThemedControl.hpp>
#include <ElBtnCtl.hpp>
#include <ElPopBtn.hpp>
#include <Vcl.ExtCtrls.hpp>
#include <ElPanel.hpp>
#include <ElScrollBox.hpp>
#include <ElGroupBox.hpp>
#include <ElCheckCtl.hpp>
#include <ElEdits.hpp>
#include <Vcl.ExtDlgs.hpp>

//-- user supplied -----------------------------------------------------------

namespace Plmdelstyleimageselect
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TStyleImageSelectForm;
struct TCursorOrIcon;
struct TIconRec;
//-- type declarations -------------------------------------------------------
enum DECLSPEC_DENUM TImageType : unsigned char { itBitmap, itIcon };

class PASCALIMPLEMENTATION TStyleImageSelectForm : public Vcl::Forms::TForm
{
	typedef Vcl::Forms::TForm inherited;
	
__published:
	Elpanel::TElPanel* Panel1;
	Elpopbtn::TElPopupButton* OkButton;
	Elpopbtn::TElPopupButton* CancelButton;
	Elpanel::TElPanel* ElPanel1;
	Elscrollbox::TElScrollBox* ScrollBox;
	Vcl::Extctrls::TImage* Image;
	Elpopbtn::TElPopupButton* btnLoad;
	Elpopbtn::TElPopupButton* btnSave;
	Elpopbtn::TElPopupButton* btnClear;
	Elpopbtn::TElPopupButton* btnPaste;
	Elpopbtn::TElPopupButton* btnCopy;
	Vcl::Dialogs::TSaveDialog* SD;
	Elpopbtn::TElPopupButton* btnMono;
	void __fastcall ImageListSelClick(System::TObject* Sender);
	void __fastcall btnClearClick(System::TObject* Sender);
	void __fastcall btnPasteClick(System::TObject* Sender);
	void __fastcall btnLoadClick(System::TObject* Sender);
	void __fastcall btnSaveClick(System::TObject* Sender);
	void __fastcall btnCopyClick(System::TObject* Sender);
	void __fastcall FormCreate(System::TObject* Sender);
	void __fastcall btnMonoClick(System::TObject* Sender);
	
private:
	Vcl::Extdlgs::TOpenPictureDialog* fOD;
	HIDESBASE MESSAGE void __fastcall WMActivate(Winapi::Messages::TWMActivate &Msg);
	void __fastcall CheckEnabledPaste(void);
	void __fastcall CheckEnabledCopy(void);
	
public:
	bool __fastcall isImage(void);
	void __fastcall SaveToStream(System::Classes::TStream* S, TImageType Format);
	void __fastcall LoadFromStream(System::Classes::TStream* S, TImageType Format);
public:
	/* TCustomForm.Create */ inline __fastcall virtual TStyleImageSelectForm(System::Classes::TComponent* AOwner) : Vcl::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TStyleImageSelectForm(System::Classes::TComponent* AOwner, int Dummy) : Vcl::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TStyleImageSelectForm(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TStyleImageSelectForm(HWND ParentWindow) : Vcl::Forms::TForm(ParentWindow) { }
	
};


#pragma pack(push,1)
struct DECLSPEC_DRECORD TCursorOrIcon
{
public:
	System::Word Reserved;
	System::Word wType;
	System::Word Count;
};
#pragma pack(pop)


typedef TIconRec *PIconRec;

#pragma pack(push,1)
struct DECLSPEC_DRECORD TIconRec
{
public:
	System::Byte Width;
	System::Byte Height;
	System::Word Colors;
	System::Word Reserved1;
	System::Word Reserved2;
	int DIBSize;
	int DIBOffset;
};
#pragma pack(pop)


//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE TStyleImageSelectForm* StyleImageSelectForm;
static const System::Int8 rc3_StockIcon = System::Int8(0x0);
static const System::Int8 rc3_Icon = System::Int8(0x1);
static const System::Int8 rc3_Cursor = System::Int8(0x2);
}	/* namespace Plmdelstyleimageselect */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_PLMDELSTYLEIMAGESELECT)
using namespace Plmdelstyleimageselect;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// PlmdelstyleimageselectHPP
