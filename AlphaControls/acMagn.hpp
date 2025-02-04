// CodeGear C++Builder
// Copyright (c) 1995, 2014 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'acMagn.pas' rev: 27.00 (Windows)

#ifndef AcmagnHPP
#define AcmagnHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <Winapi.Windows.hpp>	// Pascal unit
#include <Winapi.Messages.hpp>	// Pascal unit
#include <Vcl.Graphics.hpp>	// Pascal unit
#include <Vcl.Forms.hpp>	// Pascal unit
#include <Vcl.Menus.hpp>	// Pascal unit
#include <System.Classes.hpp>	// Pascal unit
#include <System.Types.hpp>	// Pascal unit
#include <Vcl.Controls.hpp>	// Pascal unit
#include <acThumbForm.hpp>	// Pascal unit
#include <Vcl.ExtCtrls.hpp>	// Pascal unit
#include <System.UITypes.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Acmagn
{
//-- type declarations -------------------------------------------------------
typedef void __fastcall (__closure *TPosChangingEvent)(int &X, int &Y);

typedef System::Word TMagnSize;

enum DECLSPEC_DENUM TacSizingMode : unsigned char { asmNone, asmFreeAspectRatio, asmFixedAspectRatio };

enum DECLSPEC_DENUM TacMagnStyle : unsigned char { amsRectangle, amsLens };

class DELPHICLASS TsMagnifier;
class PASCALIMPLEMENTATION TsMagnifier : public System::Classes::TComponent
{
	typedef System::Classes::TComponent inherited;
	
private:
	int FScaling;
	Vcl::Menus::TPopupMenu* FPopupMenu;
	Vcl::Controls::TMouseEvent FOnMouseUp;
	Vcl::Controls::TMouseEvent FOnMouseDown;
	TPosChangingEvent FOnPosChanging;
	System::Classes::TNotifyEvent FOnDblClick;
	TMagnSize FHeight;
	TMagnSize FWidth;
	TacSizingMode FSizingMode;
	TacMagnStyle FStyle;
	void __fastcall SetScaling(const int Value);
	void __fastcall SetWidth(const TMagnSize Value);
	void __fastcall SetHeight(const TMagnSize Value);
	
public:
	bool IsModal;
	__fastcall virtual TsMagnifier(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TsMagnifier(void);
	void __fastcall Execute(int x = 0xffffffff, int y = 0xffffffff);
	void __fastcall Hide(void);
	bool __fastcall IsVisible(void);
	System::Types::TPoint __fastcall GetPosition(void);
	System::Uitypes::TColor __fastcall GetPixelColor(System::Uitypes::TColor X, System::Uitypes::TColor Y);
	void __fastcall Refresh(void);
	
__published:
	__property Vcl::Menus::TPopupMenu* PopupMenu = {read=FPopupMenu, write=FPopupMenu};
	__property int Scaling = {read=FScaling, write=SetScaling, default=2};
	__property TMagnSize Width = {read=FWidth, write=SetWidth, default=280};
	__property TMagnSize Height = {read=FHeight, write=SetHeight, default=280};
	__property TacSizingMode SizingMode = {read=FSizingMode, write=FSizingMode, default=1};
	__property TacMagnStyle Style = {read=FStyle, write=FStyle, default=0};
	__property System::Classes::TNotifyEvent OnDblClick = {read=FOnDblClick, write=FOnDblClick};
	__property Vcl::Controls::TMouseEvent OnMouseDown = {read=FOnMouseDown, write=FOnMouseDown};
	__property Vcl::Controls::TMouseEvent OnMouseUp = {read=FOnMouseUp, write=FOnMouseUp};
	__property TPosChangingEvent OnPosChanging = {read=FOnPosChanging, write=FOnPosChanging};
};


class DELPHICLASS TacMagnForm;
class PASCALIMPLEMENTATION TacMagnForm : public Vcl::Forms::TForm
{
	typedef Vcl::Forms::TForm inherited;
	
__published:
	Vcl::Menus::TPopupMenu* PopupMenu1;
	Vcl::Menus::TMenuItem* N1x1;
	Vcl::Menus::TMenuItem* N2x1;
	Vcl::Menus::TMenuItem* N8x1;
	Vcl::Menus::TMenuItem* N1;
	Vcl::Menus::TMenuItem* Close1;
	Vcl::Menus::TMenuItem* N16x1;
	Vcl::Extctrls::TTimer* Timer1;
	void __fastcall Close1Click(System::TObject* Sender);
	void __fastcall Zoom1x1Click(System::TObject* Sender);
	void __fastcall FormClose(System::TObject* Sender, System::Uitypes::TCloseAction &Action);
	void __fastcall FormKeyDown(System::TObject* Sender, System::Word &Key, System::Classes::TShiftState Shift);
	void __fastcall FormShow(System::TObject* Sender);
	void __fastcall Image1DblClick(System::TObject* Sender);
	void __fastcall Image1MouseMove(System::TObject* Sender, System::Classes::TShiftState Shift, int X, int Y);
	void __fastcall FormMouseDown(System::TObject* Sender, System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, int X, int Y);
	void __fastcall FormMouseUp(System::TObject* Sender, System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, int X, int Y);
	void __fastcall FormMouseMove(System::TObject* Sender, System::Classes::TShiftState Shift, int X, int Y);
	void __fastcall FormResize(System::TObject* Sender);
	void __fastcall FormActivate(System::TObject* Sender);
	void __fastcall Timer1Timer(System::TObject* Sender);
	
protected:
	System::Types::TPoint LastMousePos;
	bool IntUpdating;
	bool Dragging;
	MESSAGE void __fastcall WMPosChanging(Winapi::Messages::TWMWindowPosMsg &Message);
	HIDESBASE int __fastcall WMNCHitTest(Winapi::Messages::TWMNCHitTest &Message);
	void __fastcall UpdateThumbPos(bool Full = true);
	System::Types::TRect __fastcall BordersWidth(void);
	void __fastcall MakeAeroMagnifier(void);
	
public:
	TsMagnifier* Caller;
	Acthumbform::TMagnifierOwner* MagnOwner;
	Vcl::Graphics::TBitmap* FMaskBmp;
	Vcl::Graphics::TBitmap* FTempBmp;
	Vcl::Graphics::TBitmap* AlphaBmp;
	short Scale;
	Vcl::Graphics::TBitmap* MagnBmp;
	void __fastcall UpdateAero(void);
	System::Types::TRect __fastcall ContentMargins(void);
	void __fastcall FormCreateInit(void);
	System::Types::TSize __fastcall MagnSize(void);
	System::Types::TRect __fastcall MClientRect(void);
	int __fastcall MinSize(void);
	__fastcall virtual ~TacMagnForm(void);
	void __fastcall EstablishAspectRatio(System::Word Side, System::Types::TRect &Rect);
	virtual void __fastcall WndProc(Winapi::Messages::TMessage &Message);
	void __fastcall SetZooming(int k);
	void __fastcall ShowGlass(int x, int y);
	void __fastcall CreateAlphaBmp(void);
public:
	/* TCustomForm.Create */ inline __fastcall virtual TacMagnForm(System::Classes::TComponent* AOwner) : Vcl::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TacMagnForm(System::Classes::TComponent* AOwner, int Dummy) : Vcl::Forms::TForm(AOwner, Dummy) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TacMagnForm(HWND ParentWindow) : Vcl::Forms::TForm(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
static const System::Word amMaxSize = System::Word(0x320);
static const System::Byte amMinSize = System::Byte(0x96);
extern DELPHI_PACKAGE bool Closing;
extern DELPHI_PACKAGE bool Showed;
extern DELPHI_PACKAGE bool acIsDragging;
}	/* namespace Acmagn */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_ACMAGN)
using namespace Acmagn;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// AcmagnHPP
