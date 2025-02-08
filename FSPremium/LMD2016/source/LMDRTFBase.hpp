// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDRTFBase.pas' rev: 31.00 (Windows)

#ifndef LmdrtfbaseHPP
#define LmdrtfbaseHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.SysUtils.hpp>
#include <System.Classes.hpp>
#include <Vcl.Forms.hpp>
#include <Winapi.Windows.hpp>
#include <Vcl.Controls.hpp>
#include <Winapi.Messages.hpp>
#include <Vcl.StdCtrls.hpp>
#include <LMDCustomComponent.hpp>
#include <LMDTypes.hpp>
#include <LMDClass.hpp>
#include <LMDConversion.hpp>
#include <LMDBaseControl.hpp>
#include <intfLMDBase.hpp>
#include <System.UITypes.hpp>
#include <System.Types.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdrtfbase
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDRichComponent;
class DELPHICLASS TLMDRichBaseDialog;
class DELPHICLASS TLMDRichPageMargins;
class DELPHICLASS TLMDRichGraphicControl;
class DELPHICLASS TLMDRichBaseComboBox;
//-- type declarations -------------------------------------------------------
typedef void __fastcall (__closure *TLMDRichURLClickEvent)(System::TObject* Sender, const System::UnicodeString URLText, System::Uitypes::TMouseButton Button);

typedef void __fastcall (__closure *TLMDLinkMouseMoveEvent)(System::TObject* Sender, const System::UnicodeString URLText, bool IsLink);

class PASCALIMPLEMENTATION TLMDRichComponent : public Lmdcustomcomponent::TLMDCustomComponent
{
	typedef Lmdcustomcomponent::TLMDCustomComponent inherited;
	
public:
	virtual Lmdtypes::TLMDPackageID __fastcall getLMDPackage(void);
	
__published:
	__property About = {default=0};
public:
	/* TLMDCustomComponent.Create */ inline __fastcall virtual TLMDRichComponent(System::Classes::TComponent* AOwner) : Lmdcustomcomponent::TLMDCustomComponent(AOwner) { }
	
public:
	/* TComponent.Destroy */ inline __fastcall virtual ~TLMDRichComponent(void) { }
	
};


enum DECLSPEC_DENUM Lmdrtfbase__2 : unsigned char { rdoShowHelpButton, rdoCenterDialog, rdoCenterOwnerForm };

typedef System::Set<Lmdrtfbase__2, Lmdrtfbase__2::rdoShowHelpButton, Lmdrtfbase__2::rdoCenterOwnerForm> TLMDRichDialogOptions;

enum DECLSPEC_DENUM TLMDRichDialogPosition : unsigned char { rdpOwner, rdpMainForm, rdpScreen };

class PASCALIMPLEMENTATION TLMDRichBaseDialog : public TLMDRichComponent
{
	typedef TLMDRichComponent inherited;
	
private:
	System::Classes::TNotifyEvent FOnCustomize;
	System::Classes::TNotifyEvent FOnHelp;
	TLMDRichDialogOptions Foptions;
	
protected:
	void __fastcall PrepareDialog(Vcl::Forms::TCustomForm* Dlg, Vcl::Forms::TCustomForm* AOwner = (Vcl::Forms::TCustomForm*)(0x0), int X = 0xffffffff, int Y = 0xffffffff);
	__property System::Classes::TNotifyEvent OnHelpClick = {read=FOnHelp, write=FOnHelp};
	
public:
	__fastcall virtual TLMDRichBaseDialog(System::Classes::TComponent* aOwner);
	virtual bool __fastcall Execute(Vcl::Forms::TCustomForm* AOwner = (Vcl::Forms::TCustomForm*)(0x0), int X = 0xffffffff, int Y = 0xffffffff) = 0 ;
	__property System::Classes::TNotifyEvent OnCustomize = {read=FOnCustomize, write=FOnCustomize};
	__property TLMDRichDialogOptions Options = {read=Foptions, write=Foptions, default=6};
public:
	/* TComponent.Destroy */ inline __fastcall virtual ~TLMDRichBaseDialog(void) { }
	
};


typedef Lmdtypes::TLMDUnits TLMDMeasurement;

class PASCALIMPLEMENTATION TLMDRichPageMargins : public System::Classes::TPersistent
{
	typedef System::Classes::TPersistent inherited;
	
private:
	double FLeft;
	double FTop;
	double FBottom;
	double FRight;
	Lmdtypes::TLMDUnits FUnits;
	int FInternal;
	System::Classes::TNotifyEvent FOnChange;
	System::Types::TRect __fastcall GetAsRect(void);
	void __fastcall SetAsRect(const System::Types::TRect &aValue);
	void __fastcall SetDouble(int Index, double aValue);
	void __fastcall SetUnits(Lmdtypes::TLMDUnits aValue);
	void __fastcall SetInternal(Lmdtypes::TLMDUnits aValue);
	
public:
	__fastcall TLMDRichPageMargins(void);
	DYNAMIC void __fastcall DoChange(void);
	__property System::Types::TRect AsRect = {read=GetAsRect, write=SetAsRect};
	__property Lmdtypes::TLMDUnits Units = {read=FUnits, write=SetUnits, nodefault};
	__property int UnitFactor = {read=FInternal, nodefault};
	__property System::Classes::TNotifyEvent OnChange = {read=FOnChange, write=FOnChange};
	virtual void __fastcall Assign(System::Classes::TPersistent* aValue);
	void __fastcall Translate(Lmdtypes::TLMDUnits FromUnits, Lmdtypes::TLMDUnits ToUnits);
	
__published:
	__property double Left = {read=FLeft, write=SetDouble, index=0};
	__property double Top = {read=FTop, write=SetDouble, index=1};
	__property double Right = {read=FRight, write=SetDouble, index=2};
	__property double Bottom = {read=FBottom, write=SetDouble, index=3};
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TLMDRichPageMargins(void) { }
	
};


class PASCALIMPLEMENTATION TLMDRichGraphicControl : public Lmdbasecontrol::TLMDBaseControl
{
	typedef Lmdbasecontrol::TLMDBaseControl inherited;
	
public:
	virtual Lmdtypes::TLMDPackageID __fastcall getLMDPackage(void);
	
__published:
	__property OnResize;
public:
	/* TLMDBaseControl.Create */ inline __fastcall virtual TLMDRichGraphicControl(System::Classes::TComponent* aOwner) : Lmdbasecontrol::TLMDBaseControl(aOwner) { }
	/* TLMDBaseControl.Destroy */ inline __fastcall virtual ~TLMDRichGraphicControl(void) { }
	
};


class PASCALIMPLEMENTATION TLMDRichBaseComboBox : public Vcl::Stdctrls::TCustomComboBox
{
	typedef Vcl::Stdctrls::TCustomComboBox inherited;
	
private:
	Lmdtypes::TLMDAboutVar FAbout;
	bool FMouseOver;
	bool FFlat;
	int FDropDownWidth;
	void __fastcall SetFlat(const bool aValue);
	void __fastcall SetDropDownWidth(const int aValue);
	void __fastcall DrawBorder(void);
	HIDESBASE MESSAGE void __fastcall CMEnter(Winapi::Messages::TWMNoParams &Message);
	HIDESBASE MESSAGE void __fastcall CMExit(Winapi::Messages::TWMNoParams &Message);
	HIDESBASE MESSAGE void __fastcall CMMouseEnter(Winapi::Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMMouseLeave(Winapi::Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMEnabledChanged(Winapi::Messages::TMessage &Msg);
	HIDESBASE MESSAGE void __fastcall CNCommand(Winapi::Messages::TWMCommand &Message);
	HIDESBASE MESSAGE void __fastcall WMPaint(Winapi::Messages::TWMPaint &Message);
	HIDESBASE MESSAGE void __fastcall WMNCPaint(Winapi::Messages::TMessage &Message);
	
protected:
	virtual void __fastcall CreateWnd(void);
	__property bool Flat = {read=FFlat, write=SetFlat, default=0};
	__property int DropDownWidth = {read=FDropDownWidth, write=SetDropDownWidth, default=0};
	
public:
	__fastcall virtual TLMDRichBaseComboBox(System::Classes::TComponent* AOwner);
	virtual Lmdtypes::TLMDPackageID __fastcall getLMDPackage(void);
	
__published:
	__property Lmdtypes::TLMDAboutVar About = {read=FAbout, write=FAbout, stored=false};
public:
	/* TCustomComboBox.Destroy */ inline __fastcall virtual ~TLMDRichBaseComboBox(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDRichBaseComboBox(HWND ParentWindow) : Vcl::Stdctrls::TCustomComboBox(ParentWindow) { }
	
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
#define def_TLMDRichDialogOptions (System::Set<Lmdrtfbase__2, Lmdrtfbase__2::rdoShowHelpButton, Lmdrtfbase__2::rdoCenterOwnerForm>() << Lmdrtfbase__2::rdoCenterDialog << Lmdrtfbase__2::rdoCenterOwnerForm )
extern DELPHI_PACKAGE bool __fastcall LMDRichIsPrinterValid(void);
}	/* namespace Lmdrtfbase */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDRTFBASE)
using namespace Lmdrtfbase;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdrtfbaseHPP
