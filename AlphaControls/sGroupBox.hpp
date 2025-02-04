// CodeGear C++Builder
// Copyright (c) 1995, 2014 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'sGroupBox.pas' rev: 27.00 (Windows)

#ifndef SgroupboxHPP
#define SgroupboxHPP

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
#include <System.Classes.hpp>	// Pascal unit
#include <Vcl.Graphics.hpp>	// Pascal unit
#include <Vcl.Controls.hpp>	// Pascal unit
#include <Vcl.Forms.hpp>	// Pascal unit
#include <Vcl.StdCtrls.hpp>	// Pascal unit
#include <System.Types.hpp>	// Pascal unit
#include <sCommonData.hpp>	// Pascal unit
#include <sRadioButton.hpp>	// Pascal unit
#include <sConst.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Sgroupbox
{
//-- type declarations -------------------------------------------------------
enum DECLSPEC_DENUM TsCaptionLayout : unsigned char { clTopLeft, clTopCenter, clTopRight };

typedef int TacIntProperty;

class DELPHICLASS TsMargin;
#pragma pack(push,4)
class PASCALIMPLEMENTATION TsMargin : public System::Classes::TPersistent
{
	typedef System::Classes::TPersistent inherited;
	
private:
	Vcl::Controls::TControl* FControl;
	TacIntProperty FLeft;
	TacIntProperty FTop;
	TacIntProperty FRight;
	TacIntProperty FBottom;
	void __fastcall SetMargin(int Index, TacIntProperty Value);
	
public:
	__fastcall TsMargin(Vcl::Controls::TControl* Control);
	void __fastcall Invalidate(void);
	
__published:
	__property TacIntProperty Left = {read=FLeft, write=SetMargin, index=0, default=2};
	__property TacIntProperty Top = {read=FTop, write=SetMargin, index=1, default=0};
	__property TacIntProperty Right = {read=FRight, write=SetMargin, index=2, default=2};
	__property TacIntProperty Bottom = {read=FBottom, write=SetMargin, index=3, default=0};
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TsMargin(void) { }
	
};

#pragma pack(pop)

class DELPHICLASS TsGroupBox;
class PASCALIMPLEMENTATION TsGroupBox : public Vcl::Stdctrls::TGroupBox
{
	typedef Vcl::Stdctrls::TGroupBox inherited;
	
private:
	TsCaptionLayout FCaptionLayout;
	int FCaptionYOffset;
	Scommondata::TsCommonData* FCommonData;
	System::UnicodeString FCaptionSkin;
	TsMargin* FCaptionMargin;
	TacIntProperty FCaptionWidth;
	void __fastcall SetCaptionLayout(const TsCaptionLayout Value);
	void __fastcall SetCaptionYOffset(const int Value);
	MESSAGE void __fastcall WMFontChanged(Winapi::Messages::TMessage &Message);
	void __fastcall SetCaptionSkin(const System::UnicodeString Value);
	void __fastcall SetCaptionWidth(const TacIntProperty Value);
	
protected:
	virtual void __fastcall AdjustClientRect(System::Types::TRect &Rect);
	int __fastcall TextHeight(void);
	virtual void __fastcall WndProc(Winapi::Messages::TMessage &Message);
	
public:
	virtual void __fastcall AfterConstruction(void);
	virtual void __fastcall Loaded(void);
	System::Types::TRect __fastcall CaptionRect(void);
	__fastcall virtual TsGroupBox(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TsGroupBox(void);
	virtual void __fastcall Paint(void);
	void __fastcall PaintToDC(HDC DC);
	bool __fastcall PrepareCache(void);
	void __fastcall WriteText(const System::Types::TRect &R, const Sconst::TCacheInfo &CI);
	
__published:
	__property TsCaptionLayout CaptionLayout = {read=FCaptionLayout, write=SetCaptionLayout, default=0};
	__property TsMargin* CaptionMargin = {read=FCaptionMargin, write=FCaptionMargin};
	__property int CaptionYOffset = {read=FCaptionYOffset, write=SetCaptionYOffset, default=0};
	__property Scommondata::TsCommonData* SkinData = {read=FCommonData, write=FCommonData};
	__property System::UnicodeString CaptionSkin = {read=FCaptionSkin, write=SetCaptionSkin};
	__property TacIntProperty CaptionWidth = {read=FCaptionWidth, write=SetCaptionWidth, default=0};
	__property Touch;
public:
	/* TWinControl.CreateParented */ inline __fastcall TsGroupBox(HWND ParentWindow) : Vcl::Stdctrls::TGroupBox(ParentWindow) { }
	
};


typedef void __fastcall (__closure *TacIndexChangingEvent)(System::TObject* Sender, int NewIndex, bool &AllowChange);

class DELPHICLASS TsRadioGroup;
class PASCALIMPLEMENTATION TsRadioGroup : public TsGroupBox
{
	typedef TsGroupBox inherited;
	
private:
	TacIndexChangingEvent FOnChanging;
	System::Classes::TStrings* FItems;
	Sconst::TacAnimatEvents FAnimatEvents;
	int FItemIndex;
	int FColumns;
	bool FReading;
	bool FUpdating;
	bool FShowFocus;
	void __fastcall ArrangeButtons(void);
	void __fastcall ButtonClick(System::TObject* Sender);
	void __fastcall ItemsChange(System::TObject* Sender);
	void __fastcall SetButtonCount(int Value);
	void __fastcall SetColumns(int Value);
	void __fastcall SetItemIndex(int Value);
	void __fastcall UpdateButtons(void);
	HIDESBASE MESSAGE void __fastcall CMEnabledChanged(Winapi::Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMFontChanged(Winapi::Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall WMSize(Winapi::Messages::TWMSize &Message);
	Sradiobutton::TsRadioButton* __fastcall GetButtons(int Index);
	void __fastcall SetItems(System::Classes::TStrings* Value);
	
protected:
	virtual void __fastcall ReadState(System::Classes::TReader* Reader);
	virtual void __fastcall WndProc(Winapi::Messages::TMessage &Message);
	
public:
	System::Classes::TList* FButtons;
	virtual void __fastcall Loaded(void);
	virtual bool __fastcall CanModify(int NewIndex);
	__fastcall virtual TsRadioGroup(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TsRadioGroup(void);
	DYNAMIC void __fastcall FlipChildren(bool AllLevels);
	DYNAMIC void __fastcall GetChildren(System::Classes::TGetChildProc Proc, System::Classes::TComponent* Root);
	__property Sradiobutton::TsRadioButton* Buttons[int Index] = {read=GetButtons};
	
__published:
	__property Sconst::TacAnimatEvents AnimatEvents = {read=FAnimatEvents, write=FAnimatEvents, default=16};
	__property int Columns = {read=FColumns, write=SetColumns, default=1};
	__property int ItemIndex = {read=FItemIndex, write=SetItemIndex, default=-1};
	__property System::Classes::TStrings* Items = {read=FItems, write=SetItems};
	__property bool ShowFocus = {read=FShowFocus, write=FShowFocus, default=1};
	__property TacIndexChangingEvent OnChanging = {read=FOnChanging, write=FOnChanging};
public:
	/* TWinControl.CreateParented */ inline __fastcall TsRadioGroup(HWND ParentWindow) : TsGroupBox(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Sgroupbox */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_SGROUPBOX)
using namespace Sgroupbox;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// SgroupboxHPP
