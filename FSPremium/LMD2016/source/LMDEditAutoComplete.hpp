// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDEditAutoComplete.pas' rev: 31.00 (Windows)

#ifndef LmdeditautocompleteHPP
#define LmdeditautocompleteHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <System.Classes.hpp>
#include <Vcl.Controls.hpp>
#include <Winapi.Messages.hpp>
#include <LMDStringList.hpp>
#include <LMDBaseEdit.hpp>
#include <LMDCont.hpp>
#include <LMDTypes.hpp>
#include <LMDCustomComponent.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdeditautocomplete
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDEditAutoComplete;
//-- type declarations -------------------------------------------------------
enum DECLSPEC_DENUM TLMDAutoCompleteSource : unsigned char { asStringList };

typedef System::Set<TLMDAutoCompleteSource, TLMDAutoCompleteSource::asStringList, TLMDAutoCompleteSource::asStringList> TLMDAutoCompleteSources;

enum DECLSPEC_DENUM TLMDAutoCompleteMode : unsigned char { amText, amPopup };

typedef System::Set<TLMDAutoCompleteMode, TLMDAutoCompleteMode::amText, TLMDAutoCompleteMode::amPopup> TLMDAutoCompleteModes;

enum DECLSPEC_DENUM TLMDAutoCompleteAddOn : unsigned char { aaControlExit, aaControlReturn };

typedef System::Set<TLMDAutoCompleteAddOn, TLMDAutoCompleteAddOn::aaControlExit, TLMDAutoCompleteAddOn::aaControlReturn> TLMDAutoCompleteAddOns;

typedef void __fastcall (__closure *TLMDAutoCompleteAddEvent)(System::TObject* Sender, Lmdbaseedit::TLMDBaseEdit* editControl, System::UnicodeString &addText, bool &add, TLMDAutoCompleteSource &addTo);

typedef void __fastcall (__closure *TLMDAutoCompleteSelEvent)(System::TObject* Sender, Lmdbaseedit::TLMDBaseEdit* editControl, System::UnicodeString Text);

class PASCALIMPLEMENTATION TLMDEditAutoComplete : public Lmdcustomcomponent::TLMDCustomComponent
{
	typedef Lmdcustomcomponent::TLMDCustomComponent inherited;
	
private:
	bool FCaseSensitive;
	bool FEnabled;
	System::UnicodeString FBuffered;
	Lmdstringlist::TLMDStringList* FStringList;
	int FDropDownRows;
	int FStrListIndex;
	TLMDAutoCompleteSources FSource;
	TLMDAutoCompleteModes FMode;
	TLMDAutoCompleteAddOns FAdd;
	TLMDAutoCompleteAddEvent FOnAdd;
	TLMDAutoCompleteSelEvent fOnSel;
	Lmdbaseedit::TLMDBaseEdit* FEdit;
	Vcl::Controls::TWinControl* FPopupWindow;
	void *FControlWndProc;
	void *FControlOldWndProc;
	bool fIsExact;
	void __fastcall SetStringList(Lmdstringlist::TLMDStringList* aValue);
	void __fastcall SetStrListIndex(int aValue);
	System::UnicodeString __fastcall getS(const System::UnicodeString s);
	MESSAGE void __fastcall CMCancelMode(Vcl::Controls::TCMCancelMode &Message);
	MESSAGE void __fastcall WMCancelMode(Winapi::Messages::TWMNoParams &Msg);
	MESSAGE void __fastcall WMKillFocus(Winapi::Messages::TWMKillFocus &Msg);
	
protected:
	void __fastcall Popup(Lmdbaseedit::TLMDBaseEdit* anEditControl, System::UnicodeString aText);
	virtual void __fastcall ControlWndProc(Winapi::Messages::TMessage &Message);
	virtual void __fastcall ListBoxMouseUp(System::TObject* Sender, System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, int X, int Y);
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation Operation);
	__property TLMDAutoCompleteSources Source = {read=FSource, write=FSource, nodefault};
	
public:
	__fastcall virtual TLMDEditAutoComplete(System::Classes::TComponent* aOwner);
	void __fastcall CancelPopup(void);
	void __fastcall CreatePopup(Lmdbaseedit::TLMDBaseEdit* anEditcontrol, System::Classes::TStrings* strings);
	void __fastcall SetControl(Lmdbaseedit::TLMDBaseEdit* anEditcontrol);
	System::UnicodeString __fastcall CompleteText(Lmdbaseedit::TLMDBaseEdit* anEditControl, System::UnicodeString aText);
	void __fastcall AutoCompleteText(Lmdbaseedit::TLMDBaseEdit* anEditControl, System::UnicodeString aText);
	void __fastcall Add(Lmdbaseedit::TLMDBaseEdit* anEditControl, System::UnicodeString aText);
	
__published:
	__property About = {default=0};
	__property Lmdstringlist::TLMDStringList* StringList = {read=FStringList, write=SetStringList};
	__property int StringListIndex = {read=FStrListIndex, write=SetStrListIndex, nodefault};
	__property TLMDAutoCompleteModes Mode = {read=FMode, write=FMode, nodefault};
	__property TLMDAutoCompleteAddOns AddUnknownOn = {read=FAdd, write=FAdd, nodefault};
	__property bool CaseSensitive = {read=FCaseSensitive, write=FCaseSensitive, default=1};
	__property bool Enabled = {read=FEnabled, write=FEnabled, default=1};
	__property TLMDAutoCompleteAddEvent OnAdd = {read=FOnAdd, write=FOnAdd};
	__property TLMDAutoCompleteSelEvent OnSelect = {read=fOnSel, write=fOnSel};
	__property bool IsExact = {read=fIsExact, write=fIsExact, default=0};
public:
	/* TComponent.Destroy */ inline __fastcall virtual ~TLMDEditAutoComplete(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdeditautocomplete */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDEDITAUTOCOMPLETE)
using namespace Lmdeditautocomplete;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdeditautocompleteHPP
