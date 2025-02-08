// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'JSEditDialog.pas' rev: 31.00 (Windows)

#ifndef JseditdialogHPP
#define JseditdialogHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Vcl.Controls.hpp>
#include <System.Classes.hpp>
#include <JSDialog.hpp>
#include <Vcl.StdCtrls.hpp>
#include <Winapi.Windows.hpp>
#include <JSTypes.hpp>
#include <Vcl.CheckLst.hpp>

//-- user supplied -----------------------------------------------------------

namespace Jseditdialog
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TJSEditProperties;
class DELPHICLASS TJSCustomEditDialog;
class DELPHICLASS TJSEditDialog;
//-- type declarations -------------------------------------------------------
enum DECLSPEC_DENUM TJSCaptionAlignment : unsigned char { caLeft, caRight };

enum DECLSPEC_DENUM TJSEditType : unsigned char { etNone, etEdit, etMemo, etComboBox, etListBox, etDate, etTime, etCalendar, etCustom, etCheckListBox, etRTF, etHTML, etEditComboBox };

enum DECLSPEC_DENUM TJSCaptionPosition : unsigned char { cpLeft, cpTop };

enum DECLSPEC_DENUM TCoverageType : unsigned char { ctPercent, ctPixels };

class PASCALIMPLEMENTATION TJSEditProperties : public Jstypes::TJSChangePersistent
{
	typedef Jstypes::TJSChangePersistent inherited;
	
private:
	TJSEditType FEditType;
	System::UnicodeString FCaption;
	TJSCaptionPosition FCaptionPosition;
	System::UnicodeString FValue;
	int FHeight;
	System::Classes::TStrings* FItems;
	bool FAllowDoubleClickToClose;
	TCoverageType FCoverageType;
	int FCoverage;
	bool FAllowActiveControl;
	int FMaxLength;
	void __fastcall SetEditType(const TJSEditType Value);
	void __fastcall SetCaption(const System::UnicodeString Value);
	void __fastcall SetCaptionPosition(const TJSCaptionPosition Value);
	void __fastcall SetValue(const System::UnicodeString Value);
	void __fastcall SetHeight(const int Value);
	void __fastcall SetItems(System::Classes::TStrings* const Value);
	
public:
	__fastcall virtual TJSEditProperties(void);
	__fastcall virtual ~TJSEditProperties(void);
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	bool __fastcall CaptionVisible(void);
	
__published:
	__property System::UnicodeString Caption = {read=FCaption, write=SetCaption};
	__property System::UnicodeString Value = {read=FValue, write=SetValue};
	__property TJSEditType EditType = {read=FEditType, write=SetEditType, default=1};
	__property int Height = {read=FHeight, write=SetHeight, default=100};
	__property System::Classes::TStrings* Items = {read=FItems, write=SetItems};
	__property int MaxLength = {read=FMaxLength, write=FMaxLength, default=0};
	__property bool AllowDoubleClickToClose = {read=FAllowDoubleClickToClose, write=FAllowDoubleClickToClose, default=1};
	__property TJSCaptionPosition CaptionPosition = {read=FCaptionPosition, write=SetCaptionPosition, default=0};
	__property int Coverage = {read=FCoverage, write=FCoverage, default=100};
	__property TCoverageType CoverageType = {read=FCoverageType, write=FCoverageType, default=0};
	__property bool AllowActiveControl = {read=FAllowActiveControl, write=FAllowActiveControl, default=1};
};


typedef System::TMetaClass* TJSEditPropertiesClass;

typedef void __fastcall (__closure *TJSGetControlClassEvent)(System::TObject* Sender, const int Index, Vcl::Controls::TControlClass &ControlClass);

typedef void __fastcall (__closure *TJSGetEditValueEvent)(System::TObject* Sender, Vcl::Controls::TControl* AControl, const int Index, System::UnicodeString &Value);

typedef void __fastcall (__closure *TJSSetDefaultValueEvent)(System::TObject* Sender, Vcl::Controls::TControl* AControl, const int Index, const System::UnicodeString Value);

typedef void __fastcall (__closure *TJSGetControlHeightEvent)(System::TObject* Sender, Vcl::Controls::TControl* AControl, const int Index, int &Height);

typedef void __fastcall (__closure *TJSInitialiseEditEvent)(System::TObject* Sender, Vcl::Controls::TControl* AControl, const int Index);

typedef void __fastcall (__closure *TJSValidateEvent)(System::TObject* Sender, Vcl::Controls::TControl* Control, bool &Valid);

typedef void __fastcall (__closure *TJSAdjustTopValueEvent)(System::TObject* Sender, int &ATop);

class PASCALIMPLEMENTATION TJSCustomEditDialog : public Jsdialog::TJSDialog
{
	typedef Jsdialog::TJSDialog inherited;
	
private:
	TJSGetControlClassEvent FOnGetEditControlClass;
	TJSEditProperties* FEditProperties;
	TJSSetDefaultValueEvent FOnSetDefaultValue;
	TJSGetControlHeightEvent FOnGetControlHeight;
	TJSGetEditValueEvent FOnGetEditValue;
	System::UnicodeString FEditValue;
	TJSInitialiseEditEvent FOnInitialiseEdit;
	bool FEditInitialised;
	TJSValidateEvent FOnValidate;
	TJSAdjustTopValueEvent FOnAdjustTopValue;
	TJSSetDefaultValueEvent FOnSetEditValue;
	void __fastcall CreateEditControl(void);
	void __fastcall SetEditProperties(TJSEditProperties* const Value);
	System::UnicodeString __fastcall GetEditValue(void);
	Vcl::Controls::TControl* __fastcall GetEditControl(int Index);
	void __fastcall EditControlDblClickHandler(System::TObject* Sender);
	void __fastcall SetEditValue(const System::UnicodeString AValue);
	
protected:
	Vcl::Controls::TControl* FEditControl;
	Vcl::Stdctrls::TLabel* FEditLabel;
	virtual bool __fastcall CheckMinimumHeight(void);
	virtual int __fastcall HeightAdjustment(void);
	virtual int __fastcall WidthAdjustment(void);
	virtual TJSEditPropertiesClass __fastcall GetEditPropertiesClass(void);
	virtual void __fastcall CreateEditControls(void);
	virtual int __fastcall GetHeightForEditType(void);
	virtual System::UnicodeString __fastcall DoGetEditValue(void);
	virtual void __fastcall DoSetDefaultValue(void);
	virtual void __fastcall DoUpdateEditControl(const System::UnicodeString AValue, System::Classes::TStrings* AItems);
	virtual void __fastcall DoGetEditControlClass(Vcl::Controls::TControlClass &AControlClass);
	virtual int __fastcall DoGetControlHeight(void);
	virtual void __fastcall DoDestroyed(void);
	virtual void __fastcall InitialiseEditControl(Vcl::Controls::TControl* &AControl);
	virtual void __fastcall DoDialogConstructed(void);
	virtual void __fastcall DoDialogClose(System::TObject* Sender);
	virtual Vcl::Controls::TWinControl* __fastcall GetActiveControl(void);
	virtual int __fastcall GetEditControlWidth(void);
	virtual void __fastcall DoDialogCloseQuery(System::TObject* Sender, bool &CanClose);
	virtual bool __fastcall DoValidation(void);
	virtual int __fastcall GetLeftPosition(void);
	virtual void __fastcall DoAdjustTopValue(int &ATop);
	
public:
	__fastcall virtual TJSCustomEditDialog(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TJSCustomEditDialog(void);
	void __fastcall UpdateValue(const System::UnicodeString AValue, const bool AFocus, const bool ASelect);
	virtual void __fastcall PositionControls(void);
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	bool __fastcall ItemChecked(const int AIndex)/* overload */;
	bool __fastcall ItemChecked(const System::UnicodeString AValue)/* overload */;
	int __fastcall ItemCount(void);
	bool __fastcall GetCheckedItems(System::Classes::TStrings* AItems);
	virtual int __fastcall Execute(System::Classes::TComponent* aOwner)/* overload */;
	__property System::UnicodeString EditValue = {read=FEditValue, write=SetEditValue};
	__property Vcl::Controls::TControl* EditControls[int Index] = {read=GetEditControl};
	__property TJSEditProperties* EditProperties = {read=FEditProperties, write=SetEditProperties};
	__property TJSGetControlClassEvent OnGetEditControlClass = {read=FOnGetEditControlClass, write=FOnGetEditControlClass};
	__property TJSInitialiseEditEvent OnInitialiseEdit = {read=FOnInitialiseEdit, write=FOnInitialiseEdit};
	__property TJSSetDefaultValueEvent OnSetDefaultValue = {read=FOnSetDefaultValue, write=FOnSetDefaultValue};
	__property TJSGetEditValueEvent OnGetEditValue = {read=FOnGetEditValue, write=FOnGetEditValue};
	__property TJSGetControlHeightEvent OnGetControlHeight = {read=FOnGetControlHeight, write=FOnGetControlHeight};
	__property TJSValidateEvent OnValidate = {read=FOnValidate, write=FOnValidate};
	__property TJSAdjustTopValueEvent OnAdjustTopValue = {read=FOnAdjustTopValue, write=FOnAdjustTopValue};
	__property TJSSetDefaultValueEvent OnSetEditValue = {read=FOnSetEditValue, write=FOnSetEditValue};
	/* Hoisted overloads: */
	
public:
	inline int __fastcall  Execute(void){ return Jsdialog::TJSCustomDialog::Execute(); }
	
};


class PASCALIMPLEMENTATION TJSEditDialog : public TJSCustomEditDialog
{
	typedef TJSCustomEditDialog inherited;
	
__published:
	__property EditProperties;
	__property OnAdjustTopValue;
	__property OnGetEditControlClass;
	__property OnInitialiseEdit;
	__property OnSetDefaultValue;
	__property OnSetEditValue;
	__property OnGetEditValue;
	__property OnGetControlHeight;
	__property OnValidate;
public:
	/* TJSCustomEditDialog.Create */ inline __fastcall virtual TJSEditDialog(System::Classes::TComponent* AOwner) : TJSCustomEditDialog(AOwner) { }
	/* TJSCustomEditDialog.Destroy */ inline __fastcall virtual ~TJSEditDialog(void) { }
	
};


typedef System::TMetaClass* TJSEditDialogClass;

//-- var, const, procedure ---------------------------------------------------
}	/* namespace Jseditdialog */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_JSEDITDIALOG)
using namespace Jseditdialog;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// JseditdialogHPP
