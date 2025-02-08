// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDShPathFrame.pas' rev: 31.00 (Windows)

#ifndef LmdshpathframeHPP
#define LmdshpathframeHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Vcl.Forms.hpp>
#include <Vcl.StdCtrls.hpp>
#include <Vcl.Controls.hpp>
#include <System.Classes.hpp>
#include <Vcl.Buttons.hpp>
#include <Winapi.Windows.hpp>
#include <System.Types.hpp>
#include <System.UITypes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdshpathframe
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDShellPathFrame;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDShellPathFrame : public Vcl::Forms::TFrame
{
	typedef Vcl::Forms::TFrame inherited;
	
__published:
	Vcl::Stdctrls::TListBox* PathListBox;
	Vcl::Buttons::TSpeedButton* UpBtn;
	Vcl::Buttons::TSpeedButton* DownBtn;
	Vcl::Stdctrls::TButton* DeleteBtn;
	Vcl::Stdctrls::TButton* AddBtn;
	Vcl::Stdctrls::TButton* ReplaceBtn;
	Vcl::Stdctrls::TEdit* PathEdit;
	Vcl::Stdctrls::TButton* BrowseBtn;
	Vcl::Stdctrls::TButton* DelInvalidPathsBtn;
	Vcl::Buttons::TSpeedButton* FirstBtn;
	Vcl::Buttons::TSpeedButton* LastBtn;
	void __fastcall PathListBoxClick(System::TObject* Sender);
	void __fastcall UpBtnClick(System::TObject* Sender);
	void __fastcall DownBtnClick(System::TObject* Sender);
	void __fastcall PathEditChange(System::TObject* Sender);
	void __fastcall ReplaceBtnClick(System::TObject* Sender);
	void __fastcall AddBtnClick(System::TObject* Sender);
	void __fastcall DeleteBtnClick(System::TObject* Sender);
	void __fastcall BrowseBtnClick(System::TObject* Sender);
	void __fastcall DelInvalidPathsBtnClick(System::TObject* Sender);
	void __fastcall PathListBoxDrawItem(Vcl::Controls::TWinControl* Control, int Index, const System::Types::TRect &Rect, Winapi::Windows::TOwnerDrawState State);
	void __fastcall FirstBtnClick(System::TObject* Sender);
	void __fastcall LastBtnClick(System::TObject* Sender);
	void __fastcall PathListBoxDragOver(System::TObject* Sender, System::TObject* Source, int X, int Y, System::Uitypes::TDragState State, bool &Accept);
	void __fastcall PathListBoxDragDrop(System::TObject* Sender, System::TObject* Source, int X, int Y);
	void __fastcall PathListBoxStartDrag(System::TObject* Sender, Vcl::Controls::TDragObject* &DragObject);
	void __fastcall FrameResize(System::TObject* Sender);
	
private:
	System::UnicodeString FszDelimeter;
	System::UnicodeString FPathIdent;
	System::UnicodeString FPathKey;
	System::UnicodeString FPathKeyValue;
	System::UnicodeString FCustomRootPath;
	bool FPathMustExist;
	System::UnicodeString __fastcall GetPath(void);
	void __fastcall SetPath(const System::UnicodeString Value);
	void __fastcall SetszDelimeter(const System::UnicodeString Value);
	void __fastcall SetPathIdent(const System::UnicodeString Value);
	void __fastcall SetPathKey(const System::UnicodeString Value);
	System::UnicodeString __fastcall GetRootPath(void);
	void __fastcall SetPathKeyValue(const System::UnicodeString Value);
	void __fastcall SetCustomRootPath(const System::UnicodeString Value);
	
public:
	int iDrag;
	__fastcall virtual TLMDShellPathFrame(System::Classes::TComponent* AOwner);
	void __fastcall UpdateBtn(void);
	void __fastcall UpdateOnShow(void);
	void __fastcall Clear(void);
	System::UnicodeString __fastcall GetFillPath(const System::UnicodeString szPath);
	System::UnicodeString __fastcall GetSmartPath(const System::UnicodeString szPath);
	__property System::UnicodeString RootPath = {read=GetRootPath};
	__property System::UnicodeString szPathList = {read=GetPath, write=SetPath};
	__property System::UnicodeString szDelimeter = {read=FszDelimeter, write=SetszDelimeter};
	__property System::UnicodeString PathKey = {read=FPathKey, write=SetPathKey};
	__property System::UnicodeString PathKeyValue = {read=FPathKeyValue, write=SetPathKeyValue};
	__property System::UnicodeString PathIdent = {read=FPathIdent, write=SetPathIdent};
	__property System::UnicodeString CustomRootPath = {read=FCustomRootPath, write=SetCustomRootPath};
	__property bool PathMustExist = {read=FPathMustExist, write=FPathMustExist, default=1};
public:
	/* TScrollingWinControl.Destroy */ inline __fastcall virtual ~TLMDShellPathFrame(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDShellPathFrame(HWND ParentWindow) : Vcl::Forms::TFrame(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdshpathframe */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDSHPATHFRAME)
using namespace Lmdshpathframe;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdshpathframeHPP
