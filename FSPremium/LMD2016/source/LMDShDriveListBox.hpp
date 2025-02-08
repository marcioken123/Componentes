// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDShDriveListBox.pas' rev: 31.00 (Windows)

#ifndef LmdshdrivelistboxHPP
#define LmdshdrivelistboxHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <Winapi.Messages.hpp>
#include <System.Classes.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.StdCtrls.hpp>
#include <Vcl.Graphics.hpp>
#include <LMDShBase.hpp>
#include <intfLMDBase.hpp>
#include <LMDTypes.hpp>
#include <System.UITypes.hpp>
#include <Vcl.Forms.hpp>
#include <Vcl.Menus.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdshdrivelistbox
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDShellDriveListBox;
//-- type declarations -------------------------------------------------------
enum DECLSPEC_DENUM TLMDShellDriveType : unsigned char { dtsUnknown, dtsNoRoot, dtsRemovable, dtsFixed, dtsNetwork, dtsCDROM, dtsRAM };

typedef System::Set<TLMDShellDriveType, TLMDShellDriveType::dtsUnknown, TLMDShellDriveType::dtsRAM> TLMDShellDriveTypes;

class PASCALIMPLEMENTATION TLMDShellDriveListBox : public Vcl::Stdctrls::TCustomListBox
{
	typedef Vcl::Stdctrls::TCustomListBox inherited;
	
private:
	Lmdtypes::TLMDAboutVar FAbout;
	System::WideChar FDrive;
	TLMDShellDriveTypes FDriveTypes;
	Vcl::Graphics::TBitmap* CDROMBMP;
	HIDESBASE MESSAGE void __fastcall CMFontChanged(Winapi::Messages::TMessage &Message);
	void __fastcall SetDrive(System::WideChar NewDrive);
	void __fastcall SetDriveTypes(TLMDShellDriveTypes aValue);
	TLMDShellDriveType __fastcall GetDriveTypeLMD(int Index);
	void __fastcall ReadBitmaps(void);
	void __fastcall ResetItemHeight(void);
	
protected:
	virtual void __fastcall CreateWnd(void);
	virtual void __fastcall DrawItem(int Index, const System::Types::TRect &Rect, Winapi::Windows::TOwnerDrawState State);
	DYNAMIC void __fastcall Click(void);
	void __fastcall BuildList(void);
	
public:
	__fastcall virtual TLMDShellDriveListBox(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TLMDShellDriveListBox(void);
	Lmdtypes::TLMDPackageID __fastcall getLMDPackage(void);
	__property Text = {default=0};
	__property System::WideChar Drive = {read=FDrive, write=SetDrive, nodefault};
	__property TLMDShellDriveType DriveType[int index] = {read=GetDriveTypeLMD};
	
__published:
	__property Lmdtypes::TLMDAboutVar About = {read=FAbout, write=FAbout, stored=false};
	__property TLMDShellDriveTypes ShowDriveType = {read=FDriveTypes, write=SetDriveTypes, default=124};
	__property Align = {default=0};
	__property Anchors = {default=3};
	__property BorderStyle = {default=1};
	__property Color = {default=-16777211};
	__property Columns = {default=0};
	__property Constraints;
	__property Ctl3D;
	__property DragCursor = {default=-12};
	__property DragKind = {default=0};
	__property DragMode = {default=0};
	__property Enabled = {default=1};
	__property Font;
	__property IntegralHeight = {default=0};
	__property ParentColor = {default=0};
	__property ParentCtl3D = {default=1};
	__property ParentFont = {default=1};
	__property ParentShowHint = {default=1};
	__property PopupMenu;
	__property ShowHint;
	__property TabStop = {default=1};
	__property TabOrder = {default=-1};
	__property Visible = {default=1};
	__property OnClick;
	__property OnContextPopup;
	__property OnDblClick;
	__property OnDragDrop;
	__property OnDragOver;
	__property OnDrawItem;
	__property OnEndDock;
	__property OnEndDrag;
	__property OnEnter;
	__property OnExit;
	__property OnKeyDown;
	__property OnKeyPress;
	__property OnKeyUp;
	__property OnMeasureItem;
	__property OnMouseDown;
	__property OnMouseMove;
	__property OnMouseUp;
	__property OnStartDock;
	__property OnStartDrag;
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDShellDriveListBox(HWND ParentWindow) : Vcl::Stdctrls::TCustomListBox(ParentWindow) { }
	
private:
	void *__ILMDComponent;	// Intflmdbase::ILMDComponent 
	
public:
	#if defined(MANAGED_INTERFACE_OPERATORS)
	// {42DEE038-9F98-4CA3-9734-F770483E97FF}
	operator Intflmdbase::_di_ILMDComponent()
	{
		Intflmdbase::_di_ILMDComponent intf;
		this->GetInterface(intf);
		return intf;
	}
	#else
	operator Intflmdbase::ILMDComponent*(void) { return (Intflmdbase::ILMDComponent*)&__ILMDComponent; }
	#endif
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdshdrivelistbox */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDSHDRIVELISTBOX)
using namespace Lmdshdrivelistbox;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdshdrivelistboxHPP
