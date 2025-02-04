// CodeGear C++Builder
// Copyright (c) 1995, 2014 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'acThumbForm.pas' rev: 27.00 (Windows)

#ifndef ActhumbformHPP
#define ActhumbformHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <Winapi.Windows.hpp>	// Pascal unit
#include <Winapi.Messages.hpp>	// Pascal unit
#include <System.SysUtils.hpp>	// Pascal unit
#include <System.Variants.hpp>	// Pascal unit
#include <System.Classes.hpp>	// Pascal unit
#include <Vcl.Controls.hpp>	// Pascal unit
#include <Vcl.Forms.hpp>	// Pascal unit
#include <System.UITypes.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Acthumbform
{
//-- type declarations -------------------------------------------------------
#pragma pack(push,1)
struct DECLSPEC_DRECORD TMagTransform
{
public:
	System::StaticArray<System::StaticArray<float, 3>, 3> v;
};
#pragma pack(pop)


typedef System::StaticArray<HWND, 2> THWNDArray;

typedef THWNDArray *PHWNDArray;

class DELPHICLASS TMagnifierWindow;
class DELPHICLASS TMagnifierOwner;
#pragma pack(push,4)
class PASCALIMPLEMENTATION TMagnifierWindow : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	HWND FHandle;
	unsigned FWndStyle;
	int FWidth;
	int FTop;
	int FLeft;
	int FHeight;
	System::Byte FMagFactor;
	bool FVisible;
	TMagnifierOwner* FParent;
	void __fastcall SetMagFactor(const System::Byte Value);
	void __fastcall SetVisible(const bool Value);
	
public:
	bool PosUpdating;
	__property HWND Handle = {read=FHandle, nodefault};
	__property System::Byte MagFactor = {read=FMagFactor, write=SetMagFactor, nodefault};
	__property bool Visible = {read=FVisible, write=SetVisible, nodefault};
	__fastcall TMagnifierWindow(TMagnifierOwner* Parent);
	__fastcall virtual ~TMagnifierWindow(void);
	void __fastcall Refresh(void);
	void __fastcall UpdateSource(void);
};

#pragma pack(pop)

class PASCALIMPLEMENTATION TMagnifierOwner : public Vcl::Forms::TForm
{
	typedef Vcl::Forms::TForm inherited;
	
__published:
	HIDESBASE MESSAGE void __fastcall WMMove(Winapi::Messages::TMessage &m);
	void __fastcall FormMouseDown(System::TObject* Sender, System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, int X, int Y);
	
public:
	int cL;
	int cT;
	int cR;
	int cB;
	Vcl::Forms::TForm* ParentForm;
	TMagnifierWindow* MagnWnd;
	__fastcall virtual TMagnifierOwner(System::Classes::TComponent* AOwner);
	virtual void __fastcall CreateParams(Vcl::Controls::TCreateParams &Params);
	__fastcall virtual ~TMagnifierOwner(void);
	void __fastcall UpdatePosition(bool Full = true);
	void __fastcall UpdateRgn(void);
public:
	/* TCustomForm.CreateNew */ inline __fastcall virtual TMagnifierOwner(System::Classes::TComponent* AOwner, int Dummy) : Vcl::Forms::TForm(AOwner, Dummy) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TMagnifierOwner(HWND ParentWindow) : Vcl::Forms::TForm(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
#define sMagnificationDll L"Magnification.dll"
extern DELPHI_PACKAGE TMagnifierOwner* MagnifierOwner;
extern DELPHI_PACKAGE BOOL __stdcall (*acMagInitialize)(void);
extern DELPHI_PACKAGE BOOL __stdcall (*acMagUninitialize)(void);
extern DELPHI_PACKAGE BOOL __stdcall (*acMagSetWindowSource)(HWND hwnd, const System::Types::TRect rect);
extern DELPHI_PACKAGE BOOL __stdcall (*acMagSetWindowTransform)(HWND hwnd, /* out */ TMagTransform &Transform);
extern DELPHI_PACKAGE BOOL __stdcall (*acMagSetWindowFilterList)(HWND hwnd, unsigned dwFilterMode, int count, PHWNDArray pHWND);
}	/* namespace Acthumbform */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_ACTHUMBFORM)
using namespace Acthumbform;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// ActhumbformHPP
