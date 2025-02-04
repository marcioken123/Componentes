// CodeGear C++Builder
// Copyright (c) 1995, 2014 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'sPanel.pas' rev: 27.00 (Windows)

#ifndef SpanelHPP
#define SpanelHPP

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
#include <Vcl.ExtCtrls.hpp>	// Pascal unit
#include <System.Types.hpp>	// Pascal unit
#include <sCommonData.hpp>	// Pascal unit
#include <sConst.hpp>	// Pascal unit
#include <System.UITypes.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Spanel
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TsPanel;
class PASCALIMPLEMENTATION TsPanel : public Vcl::Extctrls::TPanel
{
	typedef Vcl::Extctrls::TPanel inherited;
	
private:
	Scommondata::TsCommonData* FCommonData;
	Sconst::TPaintEvent FOnPaint;
	Vcl::Controls::TBevelCut FOldBevel;
	
public:
	__fastcall virtual TsPanel(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TsPanel(void);
	virtual void __fastcall AfterConstruction(void);
	virtual void __fastcall Loaded(void);
	virtual void __fastcall Paint(void);
	virtual void __fastcall OurPaint(HDC DC = (HDC)(0x0), bool SendUpdated = true);
	virtual bool __fastcall PrepareCache(void);
	void __fastcall PaintDragPanel(HDC DC);
	virtual void __fastcall WndProc(Winapi::Messages::TMessage &Message);
	void __fastcall WriteText(const System::Types::TRect &R, Vcl::Graphics::TCanvas* aCanvas = (Vcl::Graphics::TCanvas*)(0x0), HDC aDC = (HDC)(0x0));
	virtual void __fastcall PaintWindow(HDC DC);
	
__published:
	__property Scommondata::TsCommonData* SkinData = {read=FCommonData, write=FCommonData};
	__property Sconst::TPaintEvent OnPaint = {read=FOnPaint, write=FOnPaint};
public:
	/* TWinControl.CreateParented */ inline __fastcall TsPanel(HWND ParentWindow) : Vcl::Extctrls::TPanel(ParentWindow) { }
	
};


class DELPHICLASS TsDragBar;
class PASCALIMPLEMENTATION TsDragBar : public TsPanel
{
	typedef TsPanel inherited;
	
private:
	Vcl::Controls::TControl* FDraggedControl;
	MESSAGE void __fastcall WMActivateApp(Winapi::Messages::TWMActivateApp &Message);
	
protected:
	DYNAMIC void __fastcall MouseDown(System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, int X, int Y);
	
public:
	virtual void __fastcall ReadState(System::Classes::TReader* Reader);
	__fastcall virtual TsDragBar(System::Classes::TComponent* AOwner);
	virtual void __fastcall Loaded(void);
	virtual void __fastcall WndProc(Winapi::Messages::TMessage &Message);
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation Operation);
	
__published:
	__property Alignment = {default=2};
	__property Align = {default=1};
	__property Color = {default=-16777214};
	__property Vcl::Controls::TControl* DraggedControl = {read=FDraggedControl, write=FDraggedControl};
public:
	/* TsPanel.Destroy */ inline __fastcall virtual ~TsDragBar(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TsDragBar(HWND ParentWindow) : TsPanel(ParentWindow) { }
	
};


class DELPHICLASS TsContainer;
class PASCALIMPLEMENTATION TsContainer : public TsPanel
{
	typedef TsPanel inherited;
	
public:
	/* TsPanel.Create */ inline __fastcall virtual TsContainer(System::Classes::TComponent* AOwner) : TsPanel(AOwner) { }
	/* TsPanel.Destroy */ inline __fastcall virtual ~TsContainer(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TsContainer(HWND ParentWindow) : TsPanel(ParentWindow) { }
	
};


class DELPHICLASS TsGrip;
class PASCALIMPLEMENTATION TsGrip : public TsPanel
{
	typedef TsPanel inherited;
	
public:
	bool Transparent;
	Vcl::Controls::TWinControl* LinkedControl;
	__fastcall virtual TsGrip(System::Classes::TComponent* AOwner);
	virtual void __fastcall Paint(void);
public:
	/* TsPanel.Destroy */ inline __fastcall virtual ~TsGrip(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TsGrip(HWND ParentWindow) : TsPanel(ParentWindow) { }
	
};


struct DECLSPEC_DRECORD TsColInfo
{
public:
	System::Uitypes::TColor Color;
	System::Types::TRect R;
};


class DELPHICLASS TsColorsPanel;
class PASCALIMPLEMENTATION TsColorsPanel : public TsPanel
{
	typedef TsPanel inherited;
	
private:
	typedef System::DynamicArray<TsColInfo> _TsColorsPanel__1;
	
	
private:
	System::Classes::TStrings* FColors;
	int FItemIndex;
	int FItemWidth;
	int FItemHeight;
	int FItemMargin;
	int FColCount;
	int FRowCount;
	System::Classes::TNotifyEvent FOnChange;
	void __fastcall SetColors(System::Classes::TStrings* const Value);
	void __fastcall SetItemIndex(const int Value);
	void __fastcall SetItemHeight(const int Value);
	void __fastcall SetItemWidth(const int Value);
	void __fastcall SetItemMargin(const int Value);
	void __fastcall SetColCount(const int Value);
	void __fastcall SetRowCount(const int Value);
	
public:
	int OldSelected;
	_TsColorsPanel__1 ColorsArray;
	__fastcall virtual TsColorsPanel(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TsColorsPanel(void);
	void __fastcall GenerateColors(void);
	virtual void __fastcall AfterConstruction(void);
	DYNAMIC void __fastcall ChangeScale(int M, int D);
	virtual void __fastcall Loaded(void);
	virtual void __fastcall OurPaint(HDC DC = (HDC)(0x0), bool SendUpdated = true);
	void __fastcall PaintColors(const HDC DC);
	int __fastcall Count(void);
	int __fastcall GetItemByCoord(const System::Types::TPoint &p);
	virtual void __fastcall WndProc(Winapi::Messages::TMessage &Message);
	DYNAMIC void __fastcall MouseDown(System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, int X, int Y);
	System::Uitypes::TColor __fastcall ColorValue(void);
	
__published:
	__property System::Classes::TStrings* Colors = {read=FColors, write=SetColors};
	__property int ColCount = {read=FColCount, write=SetColCount, default=5};
	__property int ItemIndex = {read=FItemIndex, write=SetItemIndex, default=-1};
	__property int ItemHeight = {read=FItemHeight, write=SetItemHeight, default=21};
	__property int ItemWidth = {read=FItemWidth, write=SetItemWidth, default=21};
	__property int ItemMargin = {read=FItemMargin, write=SetItemMargin, default=6};
	__property int RowCount = {read=FRowCount, write=SetRowCount, default=2};
	__property Height = {default=60};
	__property Width = {default=140};
	__property System::Classes::TNotifyEvent OnChange = {read=FOnChange, write=FOnChange};
public:
	/* TWinControl.CreateParented */ inline __fastcall TsColorsPanel(HWND ParentWindow) : TsPanel(ParentWindow) { }
	
};


class DELPHICLASS TsStdColorsPanel;
class PASCALIMPLEMENTATION TsStdColorsPanel : public TsColorsPanel
{
	typedef TsColorsPanel inherited;
	
public:
	/* TsColorsPanel.Create */ inline __fastcall virtual TsStdColorsPanel(System::Classes::TComponent* AOwner) : TsColorsPanel(AOwner) { }
	/* TsColorsPanel.Destroy */ inline __fastcall virtual ~TsStdColorsPanel(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TsStdColorsPanel(HWND ParentWindow) : TsColorsPanel(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Spanel */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_SPANEL)
using namespace Spanel;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// SpanelHPP
