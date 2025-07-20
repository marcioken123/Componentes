// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'VCLTee.TeeInspector.pas' rev: 34.00 (Windows)

#ifndef Vcltee_TeeinspectorHPP
#define Vcltee_TeeinspectorHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <Winapi.Messages.hpp>
#include <System.Types.hpp>
#include <System.UITypes.hpp>
#include <Vcl.Grids.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.Forms.hpp>
#include <Vcl.StdCtrls.hpp>
#include <Vcl.Menus.hpp>
#include <System.Variants.hpp>
#include <System.Classes.hpp>
#include <System.SysUtils.hpp>
#include <VCLTee.TeCanvas.hpp>
#include <VCLTee.TeeProcs.hpp>

//-- user supplied -----------------------------------------------------------

namespace Vcltee
{
namespace Teeinspector
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TInspectorItem;
class DELPHICLASS TInspectorItems;
class DELPHICLASS TComboFlatGrid;
class DELPHICLASS TEditGrid;
class DELPHICLASS TInspectorHeader;
class DELPHICLASS TTeeInspector;
//-- type declarations -------------------------------------------------------
enum DECLSPEC_DENUM TInspectorItemStyle : unsigned char { iiBoolean, iiString, iiSelection, iiColor, iiPen, iiGradient, iiBrush, iiFont, iiImage, iiButton, iiInteger, iiDouble };

typedef void __fastcall (__closure *TGetItemProc)(const System::UnicodeString S, System::TObject* AObject/* = (System::TObject*)(0x0)*/);

typedef void __fastcall (__closure *TGetInspectorItems)(TInspectorItem* Sender, TGetItemProc Proc);

typedef void __fastcall (__closure *TGetItemIndex)(TInspectorItem* Sender, int &Index);

typedef void __fastcall (__closure *TSetItemIndex)(TInspectorItem* Sender, int Index);

class PASCALIMPLEMENTATION TInspectorItem : public System::Classes::TCollectionItem
{
	typedef System::Classes::TCollectionItem inherited;
	
private:
	System::UnicodeString FCaption;
	System::TObject* FData;
	bool FEnabled;
	bool FExpanded;
	System::TObject* FOwner;
	TInspectorItemStyle FStyle;
	System::Variant FValue;
	bool FVisible;
	System::TObject* IData;
	TInspectorItem* IParent;
	System::Classes::TNotifyEvent FOnChange;
	TGetItemIndex FOnGetItemIndex;
	TGetInspectorItems FOnGetItems;
	TSetItemIndex FOnSetItemIndex;
	HIDESBASE void __fastcall Changed();
	void __fastcall RebuildInspector();
	void __fastcall SetCaption(const System::UnicodeString Value);
	void __fastcall SetVisible(const bool Value);
	void __fastcall SetValue(const System::Variant &Value);
	void __fastcall SetData(System::TObject* const Value);
	void __fastcall SetStyle(const TInspectorItemStyle Value);
	
protected:
	void __fastcall FillItems(System::Classes::TStrings* const Items);
	virtual int __fastcall GetSelectedIndex(System::Classes::TStrings* Items);
	int __fastcall StyleToInt();
	
public:
	__fastcall virtual TInspectorItem(System::Classes::TCollection* Collection);
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	TTeeInspector* __fastcall Inspector();
	__property System::TObject* Data = {read=FData, write=SetData};
	__property System::TObject* Owner = {read=FOwner, write=FOwner};
	__property TInspectorItem* Parent = {read=IParent, write=IParent};
	
__published:
	__property System::UnicodeString Caption = {read=FCaption, write=SetCaption};
	__property bool Enabled = {read=FEnabled, write=FEnabled, default=1};
	__property bool Expanded = {read=FExpanded, write=FExpanded, nodefault};
	__property TInspectorItemStyle Style = {read=FStyle, write=SetStyle, default=0};
	__property System::Variant Value = {read=FValue, write=SetValue};
	__property bool Visible = {read=FVisible, write=SetVisible, default=1};
	__property System::Classes::TNotifyEvent OnChange = {read=FOnChange, write=FOnChange};
	__property TGetItemIndex OnGetItemIndex = {read=FOnGetItemIndex, write=FOnGetItemIndex};
	__property TGetInspectorItems OnGetItems = {read=FOnGetItems, write=FOnGetItems};
	__property TSetItemIndex OnSetItemIndex = {read=FOnSetItemIndex, write=FOnSetItemIndex};
public:
	/* TCollectionItem.Destroy */ inline __fastcall virtual ~TInspectorItem() { }
	
};


class PASCALIMPLEMENTATION TInspectorItems : public System::Classes::TOwnedCollection
{
	typedef System::Classes::TOwnedCollection inherited;
	
public:
	TInspectorItem* operator[](int Index) { return this->Item[Index]; }
	
private:
	TInspectorItem* __fastcall Get(int Index);
	void __fastcall Put(int Index, TInspectorItem* const Value);
	
protected:
	virtual void __fastcall Update(System::Classes::TCollectionItem* Item);
	
public:
	TTeeInspector* Inspector;
	HIDESBASE TInspectorItem* __fastcall Add(TInspectorItemStyle AStyle, const System::UnicodeString ACaption, System::TObject* const AData)/* overload */;
	HIDESBASE TInspectorItem* __fastcall Add(TInspectorItemStyle AStyle, const System::UnicodeString ACaption, System::TObject* const AData, const System::Classes::TNotifyEvent AOnChange)/* overload */;
	HIDESBASE TInspectorItem* __fastcall Add(TInspectorItemStyle AStyle, const System::UnicodeString ACaption, const System::Classes::TNotifyEvent AOnChange)/* overload */;
	HIDESBASE TInspectorItem* __fastcall Add(TInspectorItemStyle AStyle, const System::UnicodeString ACaption, const System::Variant &InitialValue, const System::Classes::TNotifyEvent AOnChange)/* overload */;
	HIDESBASE TInspectorItem* __fastcall Add(TInspectorItemStyle AStyle, const System::UnicodeString ACaption, const System::Variant &InitialValue)/* overload */;
	HIDESBASE TInspectorItem* __fastcall Add(TInspectorItemStyle AStyle, const System::UnicodeString ACaption, const System::Variant &InitialValue, System::TObject* const AData, const System::Classes::TNotifyEvent AOnChange)/* overload */;
	HIDESBASE TInspectorItem* __fastcall Add(TInspectorItemStyle AStyle, const System::UnicodeString ACaption, const System::Variant &InitialValue, System::TObject* const AData)/* overload */;
	__property TInspectorItem* Item[int Index] = {read=Get, write=Put/*, default*/};
public:
	/* TOwnedCollection.Create */ inline __fastcall TInspectorItems(System::Classes::TPersistent* AOwner, System::Classes::TCollectionItemClass ItemClass) : System::Classes::TOwnedCollection(AOwner, ItemClass) { }
	
public:
	/* TCollection.Destroy */ inline __fastcall virtual ~TInspectorItems() { }
	
};


class PASCALIMPLEMENTATION TComboFlatGrid : public Vcltee::Tecanvas::TComboFlat
{
	typedef Vcltee::Tecanvas::TComboFlat inherited;
	
private:
	HIDESBASE MESSAGE void __fastcall CMFocusChanged(Vcl::Controls::TCMFocusChanged &Message);
public:
	/* TComboFlat.Create */ inline __fastcall virtual TComboFlatGrid(System::Classes::TComponent* AOwner) : Vcltee::Tecanvas::TComboFlat(AOwner) { }
	
public:
	/* TCustomComboBox.Destroy */ inline __fastcall virtual ~TComboFlatGrid() { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TComboFlatGrid(HWND ParentWindow) : Vcltee::Tecanvas::TComboFlat(ParentWindow) { }
	
};


class PASCALIMPLEMENTATION TEditGrid : public Vcl::Stdctrls::TEdit
{
	typedef Vcl::Stdctrls::TEdit inherited;
	
private:
	HIDESBASE MESSAGE void __fastcall CMFocusChanged(Vcl::Controls::TCMFocusChanged &Message);
public:
	/* TCustomEdit.Create */ inline __fastcall virtual TEditGrid(System::Classes::TComponent* AOwner) : Vcl::Stdctrls::TEdit(AOwner) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TEditGrid(HWND ParentWindow) : Vcl::Stdctrls::TEdit(ParentWindow) { }
	/* TWinControl.Destroy */ inline __fastcall virtual ~TEditGrid() { }
	
};


class PASCALIMPLEMENTATION TInspectorHeader : public System::Classes::TPersistent
{
	typedef System::Classes::TPersistent inherited;
	
private:
	Vcl::Graphics::TFont* FFont;
	bool FVisible;
	void __fastcall CanvasChanged(System::TObject* Sender);
	void __fastcall SetFont(Vcl::Graphics::TFont* const Value);
	void __fastcall SetVisible(const bool Value);
	
public:
	TTeeInspector* Inspector;
	__fastcall TInspectorHeader(TTeeInspector* const AInspector);
	__fastcall virtual ~TInspectorHeader();
	void __fastcall Update();
	
__published:
	__property Vcl::Graphics::TFont* Font = {read=FFont, write=SetFont};
	__property bool Visible = {read=FVisible, write=SetVisible, default=1};
};


class PASCALIMPLEMENTATION TTeeInspector : public Vcl::Grids::TStringGrid
{
	typedef Vcl::Grids::TStringGrid inherited;
	
private:
	TInspectorHeader* FHeader;
	TInspectorItems* FItems;
	System::Classes::TNotifyEvent FOnExpandCollapse;
	TComboFlatGrid* IComboGrid;
	TEditGrid* IEditGrid;
	bool __fastcall CanDrawEllipsi(int ARow);
	int __fastcall CellType(int ARow);
	int __fastcall ClickedCross(int X, int Y);
	void __fastcall ComboChange(System::TObject* Sender);
	void __fastcall ComboKeyDown(System::TObject* Sender, System::Word &Key, System::Classes::TShiftState Shift);
	void __fastcall CreateCombo();
	void __fastcall CreateEdit();
	void __fastcall DrawCross(const System::Types::TRect &R, bool Plus);
	void __fastcall EditChange(System::TObject* Sender);
	void __fastcall EditKeyDown(System::TObject* Sender, System::Word &Key, System::Classes::TShiftState Shift);
	void __fastcall ExpandCollapse(int ARow);
	void __fastcall HideCombos();
	void __fastcall InternalSetHeader();
	System::Types::TRect __fastcall ItemCrossRect(const System::Types::TRect &R);
	int __fastcall ItemOffset(int ARow);
	int __fastcall MinRow();
	void __fastcall SetComboIndex();
	void __fastcall SetHeader(TInspectorHeader* const Value);
	void __fastcall SetItems(TInspectorItems* const Value);
	bool __fastcall ValidRow(int ARow);
	
protected:
	void __fastcall AddComboItem(const System::UnicodeString S, System::TObject* AObject);
	HIDESBASE MESSAGE void __fastcall CMEnabledChanged(Winapi::Messages::TMessage &Message);
	virtual void __fastcall DrawCell(int ACol, int ARow, const System::Types::TRect &ARect, Vcl::Grids::TGridDrawState AState);
	void __fastcall DoPositionCombos(bool WhenVisible);
	TInspectorItem* __fastcall Item(int ARow);
	virtual bool __fastcall ItemExpandable(int ARow);
	DYNAMIC void __fastcall KeyDown(System::Word &Key, System::Classes::TShiftState Shift);
	virtual void __fastcall Loaded();
	DYNAMIC void __fastcall MouseDown(System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseMove(System::Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseUp(System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, int X, int Y);
	int __fastcall RecalcRowCount();
	DYNAMIC void __fastcall Resize();
	virtual bool __fastcall SelectCell(int ACol, int ARow);
	virtual void __fastcall SetParent(Vcl::Controls::TWinControl* AParent);
	DYNAMIC void __fastcall TopLeftChanged();
	
public:
	__fastcall virtual TTeeInspector(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TTeeInspector();
	void __fastcall Clear();
	void __fastcall Rebuild();
	void __fastcall SetProperties(Vcl::Menus::TPopupMenu* const AMenu);
	__property System::Classes::TNotifyEvent OnExpandCollapse = {read=FOnExpandCollapse, write=FOnExpandCollapse};
	
__published:
	__property TInspectorItems* Items = {read=FItems, write=SetItems};
	__property Color = {default=-16777201};
	__property ColCount = {default=2};
	__property DefaultColWidth = {default=82};
	__property DefaultRowHeight = {default=19};
	__property FixedCols = {default=0};
	__property GridLineWidth = {default=0};
	__property RowCount = {default=1};
	__property TInspectorHeader* Header = {read=FHeader, write=SetHeader};
public:
	/* TWinControl.CreateParented */ inline __fastcall TTeeInspector(HWND ParentWindow) : Vcl::Grids::TStringGrid(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Teeinspector */
}	/* namespace Vcltee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE_TEEINSPECTOR)
using namespace Vcltee::Teeinspector;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE)
using namespace Vcltee;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Vcltee_TeeinspectorHPP
