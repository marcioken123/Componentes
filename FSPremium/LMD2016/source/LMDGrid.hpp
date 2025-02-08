// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDGrid.pas' rev: 31.00 (Windows)

#ifndef LmdgridHPP
#define LmdgridHPP

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
#include <Vcl.Graphics.hpp>
#include <Vcl.GraphUtil.hpp>
#include <Vcl.ExtCtrls.hpp>
#include <Vcl.Grids.hpp>
#include <System.Contnrs.hpp>
#include <Winapi.Messages.hpp>
#include <Vcl.Forms.hpp>
#include <Vcl.StdCtrls.hpp>
#include <System.SysUtils.hpp>
#include <Vcl.ComCtrls.hpp>
#include <Data.DB.hpp>
#include <Vcl.Menus.hpp>
#include <Vcl.Mask.hpp>
#include <System.MaskUtils.hpp>
#include <Vcl.ImgList.hpp>
#include <LMDTypes.hpp>
#include <LMDStrings.hpp>
#include <LMDCustomMemo.hpp>
#include <LMDCal.hpp>
#include <LMDCalc.hpp>
#include <intfLMDBase.hpp>
#include <LMDThemes.hpp>
#include <LMDClass.hpp>
#include <LMDBevel.hpp>
#include <System.UITypes.hpp>
#include <System.Types.hpp>

//-- user supplied -----------------------------------------------------------
namespace Lmdgrid 
{ 
  typedef Set<Db::TFieldType, Db::ftUnknown, Db::ftSingle>  TLMDGridFieldTypes;
  typedef Set<Db::TFieldKind, Db::fkData, Db::fkAggregate>  TLMDGridFieldKinds;
}

namespace Lmdgrid
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS ELMDGridError;
struct TLMDGridFirstInput;
__interface ILMDGridEmbeddedEdit;
typedef System::DelphiInterface<ILMDGridEmbeddedEdit> _di_ILMDGridEmbeddedEdit;
class DELPHICLASS TLMDGridEditParentHelper;
class DELPHICLASS TLMDGridCustomSource;
class DELPHICLASS TLMDGridChooserDescr;
class DELPHICLASS TLMDGridColumnChooser;
class DELPHICLASS TLMDGridCustomChooser;
class DELPHICLASS TLMDGridPickListChooser;
class DELPHICLASS TLMDGridCalendarChooser;
class DELPHICLASS TLMDGridCalculatorChooser;
class DELPHICLASS TLMDGridMemoChooser;
class DELPHICLASS TLMDGridColumnDescr;
class DELPHICLASS TLMDGridColumnTitle;
class DELPHICLASS TLMDGridColumn;
class DELPHICLASS TLMDGridColumns;
class DELPHICLASS TLMDGridTextColumn;
class DELPHICLASS TLMDGridIntegerColumn;
class DELPHICLASS TLMDGridSpinColumn;
class DELPHICLASS TLMDGridDateColumn;
class DELPHICLASS TLMDGridFloatColumn;
class DELPHICLASS TLMDGridCheckBoxStateValues;
struct TLMDGridCheckBoxInfo;
class DELPHICLASS TLMDGridCheckBoxColumn;
class DELPHICLASS TLMDGridImageColumn;
struct TLMDGridRatingLayout;
class DELPHICLASS TLMDGridRatingColumn;
struct TLMDGridProgressLayout;
class DELPHICLASS TLMDGridProgressColumn;
class DELPHICLASS TLMDGridStyle;
class DELPHICLASS TLMDCustomGrid;
class DELPHICLASS TLMDGrid;
//-- type declarations -------------------------------------------------------
#pragma pack(push,4)
class PASCALIMPLEMENTATION ELMDGridError : public System::Sysutils::Exception
{
	typedef System::Sysutils::Exception inherited;
	
public:
	/* Exception.Create */ inline __fastcall ELMDGridError(const System::UnicodeString Msg) : System::Sysutils::Exception(Msg) { }
	/* Exception.CreateFmt */ inline __fastcall ELMDGridError(const System::UnicodeString Msg, const System::TVarRec *Args, const int Args_High) : System::Sysutils::Exception(Msg, Args, Args_High) { }
	/* Exception.CreateRes */ inline __fastcall ELMDGridError(NativeUInt Ident)/* overload */ : System::Sysutils::Exception(Ident) { }
	/* Exception.CreateRes */ inline __fastcall ELMDGridError(System::PResStringRec ResStringRec)/* overload */ : System::Sysutils::Exception(ResStringRec) { }
	/* Exception.CreateResFmt */ inline __fastcall ELMDGridError(NativeUInt Ident, const System::TVarRec *Args, const int Args_High)/* overload */ : System::Sysutils::Exception(Ident, Args, Args_High) { }
	/* Exception.CreateResFmt */ inline __fastcall ELMDGridError(System::PResStringRec ResStringRec, const System::TVarRec *Args, const int Args_High)/* overload */ : System::Sysutils::Exception(ResStringRec, Args, Args_High) { }
	/* Exception.CreateHelp */ inline __fastcall ELMDGridError(const System::UnicodeString Msg, int AHelpContext) : System::Sysutils::Exception(Msg, AHelpContext) { }
	/* Exception.CreateFmtHelp */ inline __fastcall ELMDGridError(const System::UnicodeString Msg, const System::TVarRec *Args, const int Args_High, int AHelpContext) : System::Sysutils::Exception(Msg, Args, Args_High, AHelpContext) { }
	/* Exception.CreateResHelp */ inline __fastcall ELMDGridError(NativeUInt Ident, int AHelpContext)/* overload */ : System::Sysutils::Exception(Ident, AHelpContext) { }
	/* Exception.CreateResHelp */ inline __fastcall ELMDGridError(System::PResStringRec ResStringRec, int AHelpContext)/* overload */ : System::Sysutils::Exception(ResStringRec, AHelpContext) { }
	/* Exception.CreateResFmtHelp */ inline __fastcall ELMDGridError(System::PResStringRec ResStringRec, const System::TVarRec *Args, const int Args_High, int AHelpContext)/* overload */ : System::Sysutils::Exception(ResStringRec, Args, Args_High, AHelpContext) { }
	/* Exception.CreateResFmtHelp */ inline __fastcall ELMDGridError(NativeUInt Ident, const System::TVarRec *Args, const int Args_High, int AHelpContext)/* overload */ : System::Sysutils::Exception(Ident, Args, Args_High, AHelpContext) { }
	/* Exception.Destroy */ inline __fastcall virtual ~ELMDGridError(void) { }
	
};

#pragma pack(pop)

typedef Lmdtypes::TLMDString *PLMDString;

typedef System::DynamicArray<bool> TLMDGridBoolArray;

enum DECLSPEC_DENUM TLMDGridCellState : unsigned char { csPressed, csHover, csInSelectedArea, csSelectedCell, csSingleCellSelection, csSizingCol, csSizingRow, csMovingCol, csMovingRow, csColumnUnbound, csInvalidValue, csDesignerSelected, csEditing, csSelLeft, csSelTop, csSelRight, csSelBottom };

typedef System::Set<TLMDGridCellState, TLMDGridCellState::csPressed, TLMDGridCellState::csSelBottom> TLMDGridCellStates;

enum DECLSPEC_DENUM TLMDGridCellKind : unsigned char { ckHeader, ckData, ckIndicator, ckNewRow, ckDummyHeader };

enum DECLSPEC_DENUM TLMDGridRowState : unsigned char { rsCurrentNewRow, rsCurrentEditing, rsCurrentNormal, rsNormal };

enum DECLSPEC_DENUM TLMDGridSortKind : unsigned char { skNone, skAsc, skDesc };

typedef System::Set<Data::Db::TFieldKind, Data::Db::TFieldKind::fkData, Data::Db::TFieldKind::fkAggregate> TLMDGridFieldKinds;

enum DECLSPEC_DENUM ILMDGridFirstInputKind : unsigned char { fikNone, fikChar, fikMouseDown, fikDelPress };

struct DECLSPEC_DRECORD TLMDGridFirstInput
{
public:
	ILMDGridFirstInputKind Kind;
	System::WideChar Char;
	System::Uitypes::TMouseButton Button;
	System::Types::TPoint CursorPos;
	System::Classes::TShiftState Shift;
};


__interface ILMDGridEmbeddedEdit  : public System::IInterface 
{
	virtual Vcl::Controls::TWinControl* __fastcall AsControl(void) = 0 ;
	virtual void __fastcall SetData(const System::Variant &AKey, const System::Variant &AValue, bool AInitValue) = 0 ;
	virtual void __fastcall GetData(System::Variant &AKey, System::Variant &AValue) = 0 ;
	virtual void __fastcall SetGrid(TLMDGridEditParentHelper* AGridHelper) = 0 ;
	virtual TLMDGridColumn* __fastcall Column(void) = 0 ;
	virtual void __fastcall HandleFirstInput(const TLMDGridFirstInput &AInput) = 0 ;
	virtual void __fastcall SetReadOnly(bool AValue) = 0 ;
	virtual bool __fastcall GetReadOnly(void) = 0 ;
	virtual void __fastcall SetThemeMode(Lmdclass::TLMDThemeMode AThemeMode, bool AThemeGlobalMode) = 0 ;
};

enum DECLSPEC_DENUM TLMDGridKeyProcessSource : unsigned char { psEdit, psChooser, psGrid };

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDGridEditParentHelper : public System::TObject
{
	typedef System::TObject inherited;
	
public:
	virtual void __fastcall WMGetDlgCode(const _di_ILMDGridEmbeddedEdit Ed, Winapi::Messages::TWMNoParams &Message) = 0 ;
	virtual void __fastcall KeyDownPreprocess(System::Word &Key, System::Classes::TShiftState Shift, TLMDGridKeyProcessSource Source) = 0 ;
	virtual void __fastcall KeyDownPostprocess(System::Word &Key, System::Classes::TShiftState Shift, TLMDGridKeyProcessSource Source) = 0 ;
	virtual bool __fastcall WndProc(const _di_ILMDGridEmbeddedEdit Edit, Winapi::Messages::TMessage &Message) = 0 ;
	virtual void __fastcall EditorChanged(void) = 0 ;
	virtual void __fastcall DrawEditBg(const System::Types::TRect &ARect, Vcl::Graphics::TCanvas* ACanvas) = 0 ;
	virtual TLMDCustomGrid* __fastcall AsControl(void) = 0 ;
	virtual void __fastcall NeedDelayedHideChooser(void) = 0 ;
	virtual bool __fastcall DoMouseWheelDown(System::Classes::TShiftState Shift) = 0 ;
	virtual bool __fastcall DoMouseWheelUp(System::Classes::TShiftState Shift) = 0 ;
public:
	/* TObject.Create */ inline __fastcall TLMDGridEditParentHelper(void) : System::TObject() { }
	/* TObject.Destroy */ inline __fastcall virtual ~TLMDGridEditParentHelper(void) { }
	
};

#pragma pack(pop)

enum DECLSPEC_DENUM TLMDGridCustomSourceProp : unsigned char { spCanEdit, spCanChangeRows, spCanChangeCols, spCanSort };

typedef System::Set<TLMDGridCustomSourceProp, TLMDGridCustomSourceProp::spCanEdit, TLMDGridCustomSourceProp::spCanSort> TLMDGridCustomSourceProps;

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDGridCustomSource : public System::TObject
{
	typedef System::TObject inherited;
	
public:
	virtual TLMDGridCustomSourceProps __fastcall GetProps(void);
	virtual System::Variant __fastcall GetDataCell(int ACol, int ARow);
	virtual void __fastcall SetDataCell(int ACol, int ARow, const System::Variant &Value, bool ABlockSort, /* out */ int &NewRow);
	virtual int __fastcall RowCount(void);
	virtual void __fastcall SetRowCount(int ACount, int &CorrIndex);
	virtual void __fastcall InsertRow(int ADest);
	virtual void __fastcall DeleteRow(int ARow, int &CorrIndex);
	virtual void __fastcall MoveRow(int ASrc, int ADest);
	virtual void __fastcall ColumnAdded(TLMDGridColumn* ACol);
	virtual void __fastcall ColumnDeleting(TLMDGridColumn* ACol);
	virtual void __fastcall ColumnMoved(TLMDGridColumn* ACol, int AMoveTo);
	virtual void __fastcall Sort(TLMDGridColumn* ACol, TLMDGridSortKind AKind, int &CorrIndex);
	virtual void __fastcall UpdateSort(int &CorrIndex);
public:
	/* TObject.Create */ inline __fastcall TLMDGridCustomSource(void) : System::TObject() { }
	/* TObject.Destroy */ inline __fastcall virtual ~TLMDGridCustomSource(void) { }
	
};

#pragma pack(pop)

typedef System::TMetaClass* TLMDGridColumnChooserClass;

enum DECLSPEC_DENUM TLMDGridChooserBtnStyle : unsigned char { bsEllipsis, bsPickList, bsBitmap };

enum DECLSPEC_DENUM TLMDGridChooserLayout : unsigned char { clUnderEdit, clUnderCell };

enum DECLSPEC_DENUM TLMDGridChooserKind : unsigned char { ckControl, ckModalDialog };

typedef void __fastcall (__closure *TLMDGridChooserGetValueEvent)(System::TObject* Grid, TLMDGridColumn* Column, System::Variant &Value, bool &Result);

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDGridChooserDescr : public System::TObject
{
	typedef System::TObject inherited;
	
public:
	TLMDGridColumnChooserClass ChooserClass;
	System::UnicodeString ChooserName;
	Lmdtypes::TLMDString Description;
	Vcl::Graphics::TBitmap* Image;
	TLMDGridFieldKinds FieldKinds;
	TLMDGridFieldTypes MainFieldTypes;
	int MainPriority;
	TLMDGridFieldTypes CompatibleFieldTypes;
	int CompatiblePriority;
	TLMDGridChooserBtnStyle PaintStyle;
	__fastcall virtual ~TLMDGridChooserDescr(void);
public:
	/* TObject.Create */ inline __fastcall TLMDGridChooserDescr(void) : System::TObject() { }
	
};

#pragma pack(pop)

class PASCALIMPLEMENTATION TLMDGridColumnChooser : public System::Classes::TComponent
{
	typedef System::Classes::TComponent inherited;
	
private:
	bool FValid;
	bool FIsEmpty;
	int FUpdateCnt;
	Vcl::Graphics::TBitmap* FButtonImage;
	bool FEnabled;
	void __fastcall SetButtonImage(Vcl::Graphics::TBitmap* const Value);
	void __fastcall SetEnabled(const bool Value);
	void __fastcall SetValid(bool AValue);
	bool __fastcall IsValid(void);
	
protected:
	TLMDGridColumn* FColumn;
	void __fastcall CheckCol(void);
	Data::Db::TField* __fastcall GetColumnField(void);
	Data::Db::TField* __fastcall GetColumnFieldKey(void);
	TLMDGridEditParentHelper* __fastcall GetEditHelper(void);
	virtual bool __fastcall GetData(System::Variant &AKey, System::Variant &AValue) = 0 ;
	virtual void __fastcall SetData(const System::Variant &AKey, const System::Variant &AValue) = 0 ;
	virtual bool __fastcall ShowModal(void) = 0 ;
	virtual void __fastcall SetBounds(const System::Types::TRect &ARect) = 0 ;
	virtual System::Types::TSize __fastcall GetControlSize(void) = 0 ;
	virtual void __fastcall SetControlParent(Vcl::Controls::TWinControl* AParent);
	virtual void __fastcall SetFocus(void) = 0 ;
	void __fastcall ColumnNotifyPropChanged(void);
	virtual TLMDGridChooserKind __fastcall GetChooserKind(void);
	virtual TLMDGridChooserLayout __fastcall GetLayout(void);
	virtual bool __fastcall NeedOkButton(void);
	virtual bool __fastcall CanResize(void);
	__property Tag = {default=0};
	
public:
	__fastcall virtual TLMDGridColumnChooser(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TLMDGridColumnChooser(void);
	virtual void __fastcall Assign(System::Classes::TPersistent* AValue);
	__classmethod void __fastcall RegisterChooserClass(TLMDGridColumnChooserClass AChooserClass, System::UnicodeString AChooserName, Lmdtypes::TLMDString ADescription, Vcl::Graphics::TBitmap* AImage, const TLMDGridFieldTypes &AMainFieldTypes, int AMainPriority, const TLMDGridFieldTypes &ACompatibleFieldTypes, int ACompatiblePriority, TLMDGridFieldKinds AFieldKinds, TLMDGridChooserBtnStyle APaintStyle);
	__classmethod int __fastcall RegisteredChooserClassesCount();
	__classmethod TLMDGridChooserDescr* __fastcall GetRegisteredChooserClass(int AIndex)/* overload */;
	__classmethod TLMDGridChooserDescr* __fastcall GetRegisteredChooserClass(Data::Db::TFieldType AFieldType, Data::Db::TFieldKind AFieldKind)/* overload */;
	__classmethod TLMDGridChooserDescr* __fastcall GetRegisteredChooserClass(const System::UnicodeString AChooserName)/* overload */;
	__classmethod TLMDGridChooserDescr* __fastcall GetRegisteredChooserClass(System::TClass AChooserClass)/* overload */;
	
__published:
	__property bool Enabled = {read=FEnabled, write=SetEnabled, default=1};
	__property Vcl::Graphics::TBitmap* ButtonImage = {read=FButtonImage, write=SetButtonImage};
};


class PASCALIMPLEMENTATION TLMDGridCustomChooser : public TLMDGridColumnChooser
{
	typedef TLMDGridColumnChooser inherited;
	
protected:
	System::Variant FValue;
	TLMDGridChooserGetValueEvent FChooserShow;
	void __fastcall SetChooserShow(const TLMDGridChooserGetValueEvent Value);
	virtual bool __fastcall GetData(System::Variant &AKey, System::Variant &AValue);
	virtual void __fastcall SetData(const System::Variant &AKey, const System::Variant &AValue);
	virtual bool __fastcall ShowModal(void);
	virtual TLMDGridChooserKind __fastcall GetChooserKind(void);
	virtual void __fastcall SetFocus(void);
	
public:
	__fastcall virtual TLMDGridCustomChooser(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TLMDGridCustomChooser(void);
	
__published:
	__property Enabled = {default=0};
	__property TLMDGridChooserGetValueEvent OnChooserShow = {read=FChooserShow, write=SetChooserShow};
};


class PASCALIMPLEMENTATION TLMDGridPickListChooser : public TLMDGridColumnChooser
{
	typedef TLMDGridColumnChooser inherited;
	
private:
	Vcl::Stdctrls::TCustomListBox* FView;
	System::Classes::TStrings* FItems;
	int FItemHeight;
	int FDropDownCount;
	int FDefWidth;
	void __fastcall SetItems(System::Classes::TStrings* const Value);
	void __fastcall SetItemHeight(const int Value);
	void __fastcall PaintItem(Vcl::Controls::TWinControl* Control, int Index, const System::Types::TRect &ARect, Winapi::Windows::TOwnerDrawState State);
	void __fastcall SetDropDownCount(const int Value);
	int __fastcall CalkHeight(void);
	
protected:
	virtual bool __fastcall GetData(System::Variant &AKey, System::Variant &AValue);
	virtual void __fastcall SetData(const System::Variant &AKey, const System::Variant &AValue);
	virtual void __fastcall SetFocus(void);
	virtual TLMDGridChooserLayout __fastcall GetLayout(void);
	virtual TLMDGridChooserKind __fastcall GetChooserKind(void);
	virtual void __fastcall SetBounds(const System::Types::TRect &ARect);
	virtual System::Types::TSize __fastcall GetControlSize(void);
	virtual void __fastcall SetControlParent(Vcl::Controls::TWinControl* AParent);
	
public:
	__fastcall virtual TLMDGridPickListChooser(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TLMDGridPickListChooser(void);
	
__published:
	__property System::Classes::TStrings* Items = {read=FItems, write=SetItems};
	__property int ItemHeight = {read=FItemHeight, write=SetItemHeight, default=18};
	__property int DropDownCount = {read=FDropDownCount, write=SetDropDownCount, default=7};
};


class PASCALIMPLEMENTATION TLMDGridCalendarChooser : public TLMDGridColumnChooser
{
	typedef TLMDGridColumnChooser inherited;
	
private:
	Lmdcal::TLMDCustomCalendar* FCalendar;
	int FDefWidth;
	int FDefHeight;
	System::Uitypes::TColor FHeaderColor;
	System::Uitypes::TColor FHeaderTextColor;
	Lmdcal::TLMDCustomCalendar* __fastcall CreateCalendar(Vcl::Controls::TWinControl* AParent);
	void __fastcall SetHeaderColor(const System::Uitypes::TColor Value);
	void __fastcall SetHeaderTextColor(const System::Uitypes::TColor Value);
	
protected:
	virtual bool __fastcall GetData(System::Variant &AKey, System::Variant &AValue);
	virtual void __fastcall SetData(const System::Variant &AKey, const System::Variant &AValue);
	virtual void __fastcall SetFocus(void);
	virtual TLMDGridChooserLayout __fastcall GetLayout(void);
	virtual TLMDGridChooserKind __fastcall GetChooserKind(void);
	virtual void __fastcall SetBounds(const System::Types::TRect &ARect);
	virtual System::Types::TSize __fastcall GetControlSize(void);
	virtual void __fastcall SetControlParent(Vcl::Controls::TWinControl* AParent);
	virtual bool __fastcall NeedOkButton(void);
	
public:
	__fastcall virtual TLMDGridCalendarChooser(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TLMDGridCalendarChooser(void);
	
__published:
	__property System::Uitypes::TColor HeaderColor = {read=FHeaderColor, write=SetHeaderColor, default=15912628};
	__property System::Uitypes::TColor HeaderTextColor = {read=FHeaderTextColor, write=SetHeaderTextColor, default=-16777208};
};


class PASCALIMPLEMENTATION TLMDGridCalculatorChooser : public TLMDGridColumnChooser
{
	typedef TLMDGridColumnChooser inherited;
	
private:
	Lmdcalc::TLMDCustomCalculator* FCalculator;
	int FDefWidth;
	int FDefHeight;
	int FPrecision;
	int FDigits;
	System::Uitypes::TColor FDisplayColor;
	Lmdcalc::TLMDCustomCalculator* __fastcall CreateCalculator(Vcl::Controls::TWinControl* AParent);
	void __fastcall SetPrecision(const int Value);
	void __fastcall SetDigits(const int Value);
	void __fastcall SetDisplayColor(const System::Uitypes::TColor Value);
	
protected:
	virtual bool __fastcall GetData(System::Variant &AKey, System::Variant &AValue);
	virtual void __fastcall SetData(const System::Variant &AKey, const System::Variant &AValue);
	virtual void __fastcall SetFocus(void);
	virtual TLMDGridChooserLayout __fastcall GetLayout(void);
	virtual TLMDGridChooserKind __fastcall GetChooserKind(void);
	virtual void __fastcall SetBounds(const System::Types::TRect &ARect);
	virtual System::Types::TSize __fastcall GetControlSize(void);
	virtual void __fastcall SetControlParent(Vcl::Controls::TWinControl* AParent);
	virtual bool __fastcall NeedOkButton(void);
	virtual bool __fastcall CanResize(void);
	
public:
	__fastcall virtual TLMDGridCalculatorChooser(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TLMDGridCalculatorChooser(void);
	
__published:
	__property int Digits = {read=FDigits, write=SetDigits, default=5};
	__property int Precision = {read=FPrecision, write=SetPrecision, default=5};
	__property System::Uitypes::TColor DisplayColor = {read=FDisplayColor, write=SetDisplayColor, default=15912628};
};


class PASCALIMPLEMENTATION TLMDGridMemoChooser : public TLMDGridColumnChooser
{
	typedef TLMDGridColumnChooser inherited;
	
private:
	Vcl::Stdctrls::TCustomMemo* FMemo;
	int FDefWidth;
	int FDefHeight;
	bool FWantTabs;
	bool FWantReturns;
	Vcl::Stdctrls::TCustomMemo* __fastcall CreateMemo(Vcl::Controls::TWinControl* AParent);
	
protected:
	virtual bool __fastcall GetData(System::Variant &AKey, System::Variant &AValue);
	virtual void __fastcall SetData(const System::Variant &AKey, const System::Variant &AValue);
	virtual void __fastcall SetFocus(void);
	virtual TLMDGridChooserLayout __fastcall GetLayout(void);
	virtual TLMDGridChooserKind __fastcall GetChooserKind(void);
	virtual void __fastcall SetBounds(const System::Types::TRect &ARect);
	virtual System::Types::TSize __fastcall GetControlSize(void);
	virtual void __fastcall SetControlParent(Vcl::Controls::TWinControl* AParent);
	virtual bool __fastcall NeedOkButton(void);
	virtual bool __fastcall CanResize(void);
	
public:
	__fastcall virtual TLMDGridMemoChooser(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TLMDGridMemoChooser(void);
	
__published:
	__property bool WantTabs = {read=FWantTabs, write=FWantTabs, default=1};
	__property bool WantReturns = {read=FWantReturns, write=FWantReturns, default=1};
};


typedef System::TMetaClass* TLMDGridColumnClass;

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDGridColumnDescr : public System::TObject
{
	typedef System::TObject inherited;
	
public:
	TLMDGridColumnClass ColClass;
	Lmdtypes::TLMDString Description;
	Vcl::Graphics::TBitmap* Image;
	TLMDGridFieldTypes FieldTypes;
	__fastcall virtual ~TLMDGridColumnDescr(void);
public:
	/* TObject.Create */ inline __fastcall TLMDGridColumnDescr(void) : System::TObject() { }
	
};

#pragma pack(pop)

enum DECLSPEC_DENUM TLMDColSetting : unsigned char { csAlignment, csAlignmentV, csReadOnly, csWidth, csFont, csCaption, csVisible, csMinValue, csMaxValue, csMask, csChooserModified };

typedef System::Set<TLMDColSetting, TLMDColSetting::csAlignment, TLMDColSetting::csChooserModified> TLMDColSettings;

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDGridColumnTitle : public System::Classes::TPersistent
{
	typedef System::Classes::TPersistent inherited;
	
private:
	TLMDColSettings FSettings;
	Vcl::Graphics::TFont* FFont;
	Lmdtypes::TLMDString FCaption;
	System::Classes::TAlignment FAlignment;
	TLMDGridColumn* FColumn;
	System::Classes::TVerticalAlignment FVertAlign;
	bool __fastcall IsAlignmentStored(void);
	bool __fastcall IsAlignmentVStored(void);
	bool __fastcall IsFontStored(void);
	bool __fastcall IsCaptionStored(void);
	void __fastcall SetAlignment(const System::Classes::TAlignment Value);
	void __fastcall SetCaption(const Lmdtypes::TLMDString Value);
	void __fastcall SetFont(Vcl::Graphics::TFont* const Value);
	void __fastcall OnFontChange(System::TObject* ASender);
	void __fastcall SetVertAlign(const System::Classes::TVerticalAlignment Value);
	Lmdtypes::TLMDString __fastcall GetCaption(void);
	System::Classes::TAlignment __fastcall GetAlignment(void);
	System::Classes::TVerticalAlignment __fastcall GetVertAlign(void);
	Vcl::Graphics::TFont* __fastcall GetFont(void);
	void __fastcall RefreshDefaultFont(void);
	
public:
	__fastcall TLMDGridColumnTitle(TLMDGridColumn* AColumn);
	__fastcall virtual ~TLMDGridColumnTitle(void);
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	
__published:
	__property Lmdtypes::TLMDString Caption = {read=GetCaption, write=SetCaption, stored=IsCaptionStored};
	__property Vcl::Graphics::TFont* Font = {read=GetFont, write=SetFont, stored=IsFontStored};
	__property System::Classes::TAlignment Alignment = {read=GetAlignment, write=SetAlignment, stored=IsAlignmentStored, nodefault};
	__property System::Classes::TVerticalAlignment VertAlignment = {read=GetVertAlign, write=SetVertAlign, stored=IsAlignmentVStored, nodefault};
};

#pragma pack(pop)

typedef int __fastcall (__closure *TLMDGridCompareFunc)(System::PVariant Val1, System::PVariant Val2);

typedef void __fastcall (__closure *TLMDGridColumnTextParseEvent)(System::TObject* Grid, TLMDGridColumn* Column, Lmdtypes::TLMDString &TextValue, System::Variant &ResultValue, bool &IsNull, bool &ParsedOk, PLMDString PErrMsg, bool CanRaiseError);

typedef void __fastcall (__closure *TLMDGridColumnTextFormatEvent)(System::TObject* Grid, TLMDGridColumn* Column, const System::Variant &CellValue, bool IsNull, Lmdtypes::TLMDString &ResultText);

typedef void __fastcall (__closure *TLMDGridColumnCanEditEvent)(System::TObject* Grid, TLMDGridColumn* Column, bool &ACanEdit);

class PASCALIMPLEMENTATION TLMDGridColumn : public System::Classes::TComponent
{
	typedef System::Classes::TComponent inherited;
	
private:
	Vcl::Graphics::TFont* FFont;
	bool FVisible;
	int FWidth;
	int FPosition;
	TLMDCustomGrid* FGrid;
	TLMDGridSortKind FSortKind;
	bool FSortingAllowed;
	System::Classes::TAlignment FAlignment;
	System::Classes::TVerticalAlignment FVertAlign;
	TLMDGridColumnTitle* FTitle;
	System::StaticArray<int, 4> FPaddings;
	TLMDGridCompareFunc FComparer;
	TLMDGridColumnTextFormatEvent FOnFormatEdit;
	TLMDGridColumnTextFormatEvent FOnFormatPaint;
	TLMDGridColumnTextParseEvent FOnParse;
	System::UnicodeString FFieldName;
	bool FReadOnly;
	TLMDGridColumnChooser* FChooser;
	bool FAutoColDesignerSelected;
	System::Classes::TComponent* FDummyLookupRoot;
	bool FFramesUpdating;
	System::Classes::TComponent* FTmpRoot;
	System::Classes::TPersistent* FTmpAnc;
	System::Classes::TComponent* FTmpRootAnc;
	System::Classes::TPersistent* FChooserDsgHelper;
	System::Uitypes::TColor FColor;
	System::Uitypes::TColor FAltrernateColor;
	bool FAltrernateLoaded;
	bool FDefaultColor;
	bool FAllowUndefinedValue;
	TLMDGridColumnCanEditEvent FOnCanEdit;
	void __fastcall BeginUpdate(void);
	void __fastcall EndUpdate(void);
	void __fastcall SetVisible(const bool Value);
	void __fastcall SetWidth(const int Value);
	void __fastcall SetPosition(const int Value);
	void __fastcall SetGrid(TLMDCustomGrid* const Value);
	void __fastcall SetSortKind(const TLMDGridSortKind Value);
	void __fastcall SetAlignment(const System::Classes::TAlignment Value);
	bool __fastcall IsFontStored(void);
	bool __fastcall IsReadOnlyStored(void);
	void __fastcall SetFont(Vcl::Graphics::TFont* const Value);
	void __fastcall OnFontChange(System::TObject* ASender);
	void __fastcall SetTitle(TLMDGridColumnTitle* const Value);
	void __fastcall SetVertAlign(const System::Classes::TVerticalAlignment Value);
	int __fastcall GetPadding(const int Index);
	void __fastcall SetPadding(const int Index, const int Value);
	void __fastcall SetFieldName(const System::UnicodeString Value);
	void __fastcall SetReadOnly(const bool Value);
	bool __fastcall IsAlignmentStored(void);
	bool __fastcall IsVisibleStored(void);
	bool __fastcall IsWidthStored(void);
	bool __fastcall GetReadOnly(void);
	Vcl::Graphics::TFont* __fastcall GetFont(void);
	System::Classes::TAlignment __fastcall GetAlignment(void);
	int __fastcall GetWidth(void);
	bool __fastcall GetVisible(void);
	void __fastcall RefreshDefaultFont(void);
	void __fastcall RefreshDefaultColor(void);
	TLMDGridChooserDescr* __fastcall GetDefaultChooserDescr(void);
	TLMDGridColumnChooser* __fastcall CreateChooser(TLMDGridChooserDescr* ADescr);
	TLMDGridColumnChooser* __fastcall CreateDefChooser(void);
	void __fastcall CheckChooserDsc(TLMDGridChooserDescr* const ADescr);
	void __fastcall SetChooserByClass(const System::TClass Value);
	void __fastcall SetChooserByDescr(TLMDGridChooserDescr* const ADescr);
	System::TClass __fastcall GetChooserClass(void);
	void __fastcall ChooserPropChanged(void);
	void __fastcall SetAutoColumnDesignerSelected(bool AValue);
	bool __fastcall GetAutoColumnDesignerSelected(void);
	System::Classes::TPersistent* __fastcall GetDsgHelper(void);
	void __fastcall SetDefaultColor(const bool Value);
	void __fastcall SetColor(const System::Uitypes::TColor Value);
	bool __fastcall IsColorStored(void);
	void __fastcall SetAltrernateColor(const System::Uitypes::TColor Value);
	bool __fastcall IsAltrernateColorStored(void);
	void __fastcall SetAllowUndefinedValue(const bool Value);
	void __fastcall SetSortingAllowed(const bool Value);
	
protected:
	Data::Db::TFieldType FDefaultDataType;
	TLMDColSettings FSettings;
	Vcl::Controls::TControl* FEditor;
	void __fastcall CheckColumnDataTypeChange(void);
	void __fastcall RemoveSetting(TLMDColSetting ASet);
	virtual bool __fastcall IsValueValid(System::PVariant Value, PLMDString AErrMsg);
	virtual void __fastcall NormalizeValue(System::PVariant ASrcValue, System::PVariant ADestValue);
	DYNAMIC void __fastcall Updated(void);
	virtual void __fastcall Loaded(void);
	virtual void __fastcall ReadState(System::Classes::TReader* Reader);
	virtual void __fastcall DefineProperties(System::Classes::TFiler* Filer);
	bool __fastcall IsDefaultChooserClass(System::TClass AClass);
	bool __fastcall IsDefaultChooserClassName(System::UnicodeString AClassName);
	void __fastcall ReadChooser(System::Classes::TReader* Reader);
	void __fastcall WriteChooser(System::Classes::TWriter* Writer);
	void __fastcall DetachEmbeddedEditor(void);
	virtual _di_ILMDGridEmbeddedEdit __fastcall GetEmbeddedEditor(void) = 0 ;
	virtual void __fastcall ResetEmbeddedEditor(void) = 0 ;
	virtual void __fastcall PaintCellBG(Vcl::Graphics::TCanvas* ACanvas, int ADataRow, const System::Types::TRect &ARect, TLMDGridCellStates ACellState, bool AWithFrame, const System::Types::TRect &APaddingRect, System::Types::TRect &ContentRect);
	virtual void __fastcall PaintFormattedCellData(Vcl::Graphics::TCanvas* ACanvas, const System::Types::TRect &ARect, const System::Variant &AData, System::Classes::TAlignment AAlignment, TLMDGridCellStates ACellState);
	virtual int __fastcall CompareColValues(System::PVariant Val1, System::PVariant Val2) = 0 ;
	virtual bool __fastcall IsSortingAllowed(void);
	void __fastcall DefTextOut(Vcl::Graphics::TCanvas* ACanvas, const System::Types::TRect &ARect, const Lmdtypes::TLMDString S, System::Classes::TAlignment AAlignment, bool AWrapWords, bool AExpandTabs, TLMDGridCellStates ACellState, TLMDGridStyle* AStyle)/* overload */;
	void __fastcall DefTextOut(Vcl::Graphics::TCanvas* ACanvas, const System::Types::TRect &ARect, const Lmdtypes::TLMDString S, System::Classes::TAlignment AAlignment, bool AWrapWords, bool AExpandTabs, int AGlyphW, TLMDGridCellStates ACellState, TLMDGridStyle* AStyle, System::Types::TRect &TextR)/* overload */;
	virtual bool __fastcall ParseEditorData(const System::Variant &AEditData, bool ARaiseError, PLMDString PErrMsg, System::Variant &Res);
	virtual System::Variant __fastcall FormatEditorData(const System::Variant &AGridData);
	virtual System::Variant __fastcall FormatPaintData(const System::Variant &AGridData);
	virtual TLMDGridFieldTypes __fastcall GetColumnCompatDataTypes(void);
	virtual bool __fastcall IsFieldTypeCompatibleWithColSettings(Data::Db::TField* AField, PLMDString PErrMessage);
	virtual void __fastcall CheckInitPropsForField(void);
	DYNAMIC void __fastcall ResetPaintCache(void);
	System::UnicodeString __fastcall GetChooserName(void);
	void __fastcall SetChooserName(System::UnicodeString Value);
	virtual bool __fastcall CanEdit(void);
	__property TLMDGridColumnTextFormatEvent OnFormatEdit = {read=FOnFormatEdit, write=FOnFormatEdit};
	__property TLMDGridColumnTextFormatEvent OnFormatPaint = {read=FOnFormatPaint, write=FOnFormatPaint};
	__property TLMDGridColumnTextParseEvent OnParse = {read=FOnParse, write=FOnParse};
	
public:
	__fastcall virtual TLMDGridColumn(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TLMDGridColumn(void);
	virtual void __fastcall Assign(System::Classes::TPersistent* ASrc);
	DYNAMIC void __fastcall SetParentComponent(System::Classes::TComponent* AParent);
	DYNAMIC System::Classes::TComponent* __fastcall GetParentComponent(void);
	DYNAMIC bool __fastcall HasParent(void);
	__classmethod void __fastcall RegisterColumnClass(TLMDGridColumnClass AColClass, Lmdtypes::TLMDString ADescription, Vcl::Graphics::TBitmap* AImage, const TLMDGridFieldTypes &ADataTypes);
	__classmethod int __fastcall RegisteredColumnClassesCount();
	__classmethod TLMDGridColumnDescr* __fastcall GetRegisteredColumnClass(int AIndex)/* overload */;
	__classmethod TLMDGridColumnDescr* __fastcall GetRegisteredColumnClass(Data::Db::TFieldType AFieldType)/* overload */;
	Data::Db::TFieldKind __fastcall GetColumnKind(void);
	Data::Db::TFieldType __fastcall GetColumnDataType(void);
	__property TLMDCustomGrid* Grid = {read=FGrid, write=SetGrid};
	__property System::TClass ChooserClass = {read=GetChooserClass, write=SetChooserByClass};
	__property TLMDGridColumnChooser* Chooser = {read=FChooser};
	
__published:
	__property System::UnicodeString ChooserName = {read=GetChooserName, write=SetChooserName, stored=false};
	__property System::UnicodeString FieldName = {read=FFieldName, write=SetFieldName};
	__property bool Visible = {read=GetVisible, write=SetVisible, stored=IsVisibleStored, nodefault};
	__property int Width = {read=GetWidth, write=SetWidth, stored=IsWidthStored, nodefault};
	__property int Position = {read=FPosition, write=SetPosition, default=-1};
	__property TLMDGridSortKind SortKind = {read=FSortKind, write=SetSortKind, default=0};
	__property bool SortingAllowed = {read=FSortingAllowed, write=SetSortingAllowed, default=1};
	__property System::Classes::TAlignment Alignment = {read=GetAlignment, write=SetAlignment, stored=IsAlignmentStored, nodefault};
	__property System::Classes::TVerticalAlignment VertAlignment = {read=FVertAlign, write=SetVertAlign, default=2};
	__property Vcl::Graphics::TFont* Font = {read=GetFont, write=SetFont, stored=IsFontStored};
	__property TLMDGridColumnTitle* Title = {read=FTitle, write=SetTitle};
	__property TLMDGridCompareFunc Comparer = {read=FComparer, write=FComparer};
	__property bool ReadOnly = {read=GetReadOnly, write=SetReadOnly, stored=IsReadOnlyStored, nodefault};
	__property int PaddingLeft = {read=GetPadding, write=SetPadding, index=0, default=3};
	__property int PaddingRight = {read=GetPadding, write=SetPadding, index=1, default=3};
	__property int PaddingTop = {read=GetPadding, write=SetPadding, index=2, default=3};
	__property int PaddingBottom = {read=GetPadding, write=SetPadding, index=3, default=3};
	__property System::Classes::TPersistent* DsgHelper = {read=GetDsgHelper, stored=false};
	__property System::Uitypes::TColor Color = {read=FColor, write=SetColor, stored=IsColorStored, nodefault};
	__property bool DefaultColor = {read=FDefaultColor, write=SetDefaultColor, default=1};
	__property System::Uitypes::TColor AltrernateColor = {read=FAltrernateColor, write=SetAltrernateColor, stored=IsAltrernateColorStored, nodefault};
	__property bool AllowUndefinedValue = {read=FAllowUndefinedValue, write=SetAllowUndefinedValue, default=1};
	__property TLMDGridColumnCanEditEvent OnCanEdit = {read=FOnCanEdit, write=FOnCanEdit};
};


#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDGridColumns : public System::Classes::TPersistent
{
	typedef System::Classes::TPersistent inherited;
	
public:
	TLMDGridColumn* operator[](int AIndex) { return this->Items[AIndex]; }
	
private:
	TLMDCustomGrid* FGrid;
	System::Contnrs::TObjectList* FCols;
	int __fastcall GetCount(void);
	TLMDGridColumn* __fastcall GetItem(int AIndex);
	void __fastcall AddColLow(TLMDGridColumn* ACol);
	void __fastcall RemoveColLow(TLMDGridColumn* ACol);
	void __fastcall UpdateColPositions(void);
	
public:
	__fastcall TLMDGridColumns(TLMDCustomGrid* AGrid);
	__fastcall virtual ~TLMDGridColumns(void);
	void __fastcall Add(TLMDGridColumn* ACol);
	void __fastcall Remove(TLMDGridColumn* ACol)/* overload */;
	void __fastcall Clear(void);
	bool __fastcall HaveCol(TLMDGridColumn* ACol);
	__property TLMDCustomGrid* ParentGrid = {read=FGrid};
	__property int Count = {read=GetCount, nodefault};
	__property TLMDGridColumn* Items[int AIndex] = {read=GetItem/*, default*/};
};

#pragma pack(pop)

enum DECLSPEC_DENUM TLMDGridMaskedReturnKind : unsigned char { rkMasked, rkUnmasked, rmMaskedTrim };

class PASCALIMPLEMENTATION TLMDGridTextColumn : public TLMDGridColumn
{
	typedef TLMDGridColumn inherited;
	
private:
	System::Maskutils::TEditMask FMask;
	TLMDGridMaskedReturnKind FMaskedTextReturnKind;
	bool FFormatPaintByMask;
	bool FWordWrap;
	Lmdtypes::TLMDString __fastcall VarToStr(const System::Variant &V);
	System::Maskutils::TEditMask __fastcall GetMask(void);
	bool __fastcall IsMaskStored(void);
	void __fastcall SetMask(const System::Maskutils::TEditMask Value);
	void __fastcall InitEditor(void);
	void __fastcall SetFormatPaintByMask(const bool Value);
	void __fastcall SetWordWrap(const bool Value);
	
protected:
	virtual void __fastcall NormalizeValue(System::PVariant ASrcValue, System::PVariant ADestValue);
	virtual int __fastcall CompareColValues(System::PVariant Val1, System::PVariant Val2);
	virtual void __fastcall PaintFormattedCellData(Vcl::Graphics::TCanvas* ACanvas, const System::Types::TRect &ARect, const System::Variant &AData, System::Classes::TAlignment AAlignment, TLMDGridCellStates ACellState);
	virtual System::Variant __fastcall FormatPaintData(const System::Variant &AGridData);
	virtual System::Variant __fastcall FormatEditorData(const System::Variant &AGridData);
	virtual bool __fastcall ParseEditorData(const System::Variant &AEditData, bool ARaiseError, PLMDString PErrMsg, System::Variant &Res);
	virtual _di_ILMDGridEmbeddedEdit __fastcall GetEmbeddedEditor(void);
	virtual void __fastcall ResetEmbeddedEditor(void);
	
public:
	__fastcall virtual TLMDGridTextColumn(System::Classes::TComponent* AOwner);
	
__published:
	__property System::Maskutils::TEditMask Mask = {read=GetMask, write=SetMask, stored=IsMaskStored};
	__property TLMDGridMaskedReturnKind MaskedTextReturnKind = {read=FMaskedTextReturnKind, write=FMaskedTextReturnKind, default=2};
	__property bool FormatPaintByMask = {read=FFormatPaintByMask, write=SetFormatPaintByMask, default=0};
	__property bool WordWrap = {read=FWordWrap, write=SetWordWrap, default=1};
	__property OnFormatEdit;
	__property OnFormatPaint;
	__property OnParse;
public:
	/* TLMDGridColumn.Destroy */ inline __fastcall virtual ~TLMDGridTextColumn(void) { }
	
};


class PASCALIMPLEMENTATION TLMDGridIntegerColumn : public TLMDGridColumn
{
	typedef TLMDGridColumn inherited;
	
private:
	int FStep;
	int FLargeStep;
	int FMinValue;
	int FMaxValue;
	bool FShowButtons;
	int __fastcall VarToIntDef(System::PVariant V);
	void __fastcall SetInteger(const int Index, const int Value);
	void __fastcall InitEditor(void);
	bool __fastcall IsValueStored(const int Index);
	int __fastcall GetInteger(const int Index);
	Data::Db::TIntegerField* __fastcall GetField(void);
	void __fastcall SetShowButtons(const bool Value);
	
protected:
	virtual bool __fastcall ParseEditorData(const System::Variant &AEditData, bool ARaiseError, PLMDString PErrMsg, System::Variant &Res);
	virtual int __fastcall CompareColValues(System::PVariant Val1, System::PVariant Val2);
	virtual void __fastcall NormalizeValue(System::PVariant ASrcValue, System::PVariant ADestValue);
	virtual void __fastcall PaintFormattedCellData(Vcl::Graphics::TCanvas* ACanvas, const System::Types::TRect &ARect, const System::Variant &AData, System::Classes::TAlignment AAlignment, TLMDGridCellStates ACellState);
	virtual _di_ILMDGridEmbeddedEdit __fastcall GetEmbeddedEditor(void);
	virtual void __fastcall ResetEmbeddedEditor(void);
	
public:
	__fastcall virtual TLMDGridIntegerColumn(System::Classes::TComponent* AOwner);
	
__published:
	__property int Step = {read=GetInteger, write=SetInteger, index=0, default=1};
	__property int LargeStep = {read=GetInteger, write=SetInteger, index=1, default=10};
	__property int MinValue = {read=GetInteger, write=SetInteger, stored=IsValueStored, index=2, nodefault};
	__property int MaxValue = {read=GetInteger, write=SetInteger, stored=IsValueStored, index=3, nodefault};
	__property bool ShowButtons = {read=FShowButtons, write=SetShowButtons, default=1};
	__property OnFormatEdit;
	__property OnFormatPaint;
	__property OnParse;
public:
	/* TLMDGridColumn.Destroy */ inline __fastcall virtual ~TLMDGridIntegerColumn(void) { }
	
};


class PASCALIMPLEMENTATION TLMDGridSpinColumn : public TLMDGridIntegerColumn
{
	typedef TLMDGridIntegerColumn inherited;
	
public:
	/* TLMDGridIntegerColumn.Create */ inline __fastcall virtual TLMDGridSpinColumn(System::Classes::TComponent* AOwner) : TLMDGridIntegerColumn(AOwner) { }
	
public:
	/* TLMDGridColumn.Destroy */ inline __fastcall virtual ~TLMDGridSpinColumn(void) { }
	
};


class PASCALIMPLEMENTATION TLMDGridDateColumn : public TLMDGridColumn
{
	typedef TLMDGridColumn inherited;
	
private:
	System::UnicodeString FDateFormat;
	System::TDateTime __fastcall VarToDateDef(System::PVariant V);
	void __fastcall SetDateFormat(const System::UnicodeString Value);
	void __fastcall InitEditor(void);
	void __fastcall FormatGen(const System::Variant &AGridData, Lmdtypes::TLMDString &Res, bool &IsNull);
	
protected:
	virtual bool __fastcall ParseEditorData(const System::Variant &AEditData, bool ARaiseError, PLMDString PErrMsg, System::Variant &Res);
	virtual System::Variant __fastcall FormatEditorData(const System::Variant &AGridData);
	virtual System::Variant __fastcall FormatPaintData(const System::Variant &AGridData);
	virtual int __fastcall CompareColValues(System::PVariant Val1, System::PVariant Val2);
	virtual void __fastcall NormalizeValue(System::PVariant ASrcValue, System::PVariant ADestValue);
	virtual void __fastcall PaintFormattedCellData(Vcl::Graphics::TCanvas* ACanvas, const System::Types::TRect &ARect, const System::Variant &AData, System::Classes::TAlignment AAlignment, TLMDGridCellStates ACellState);
	virtual _di_ILMDGridEmbeddedEdit __fastcall GetEmbeddedEditor(void);
	virtual void __fastcall ResetEmbeddedEditor(void);
	
public:
	__fastcall virtual TLMDGridDateColumn(System::Classes::TComponent* AOwner);
	
__published:
	__property System::UnicodeString DateFormat = {read=FDateFormat, write=SetDateFormat};
	__property OnFormatEdit;
	__property OnFormatPaint;
	__property OnParse;
public:
	/* TLMDGridColumn.Destroy */ inline __fastcall virtual ~TLMDGridDateColumn(void) { }
	
};


class PASCALIMPLEMENTATION TLMDGridFloatColumn : public TLMDGridColumn
{
	typedef TLMDGridColumn inherited;
	
private:
	int FPrecision;
	int FDigits;
	System::UnicodeString FFloatFormat;
	bool FIsCurrencyMode;
	System::UnicodeString FCurrencyString;
	double __fastcall VarToFloatDef(System::PVariant V);
	void __fastcall InitEditor(void);
	void __fastcall SetDigits(int Value);
	void __fastcall SetPrecision(int Value);
	void __fastcall SetFloatFormat(const System::UnicodeString Value);
	void __fastcall FormatGen(const System::Variant &AGridData, Lmdtypes::TLMDString &Res, bool &IsNull, bool AForEdit);
	void __fastcall SetIsCurrencyMode(const bool Value);
	void __fastcall SetCurrencyString(const System::UnicodeString Value);
	
protected:
	virtual void __fastcall CheckInitPropsForField(void);
	virtual bool __fastcall ParseEditorData(const System::Variant &AEditData, bool ARaiseError, PLMDString PErrMsg, System::Variant &Res);
	virtual System::Variant __fastcall FormatEditorData(const System::Variant &AGridData);
	virtual System::Variant __fastcall FormatPaintData(const System::Variant &AGridData);
	virtual int __fastcall CompareColValues(System::PVariant Val1, System::PVariant Val2);
	virtual void __fastcall NormalizeValue(System::PVariant ASrcValue, System::PVariant ADestValue);
	virtual void __fastcall PaintFormattedCellData(Vcl::Graphics::TCanvas* ACanvas, const System::Types::TRect &ARect, const System::Variant &AData, System::Classes::TAlignment AAlignment, TLMDGridCellStates ACellState);
	virtual _di_ILMDGridEmbeddedEdit __fastcall GetEmbeddedEditor(void);
	virtual void __fastcall ResetEmbeddedEditor(void);
	
public:
	__fastcall virtual TLMDGridFloatColumn(System::Classes::TComponent* AOwner);
	
__published:
	__property int Precision = {read=FPrecision, write=SetPrecision, default=5};
	__property int Digits = {read=FDigits, write=SetDigits, default=5};
	__property System::UnicodeString FloatFormat = {read=FFloatFormat, write=SetFloatFormat};
	__property bool IsCurrencyMode = {read=FIsCurrencyMode, write=SetIsCurrencyMode, nodefault};
	__property System::UnicodeString CurrencyString = {read=FCurrencyString, write=SetCurrencyString};
	__property OnFormatEdit;
	__property OnFormatPaint;
	__property OnParse;
public:
	/* TLMDGridColumn.Destroy */ inline __fastcall virtual ~TLMDGridFloatColumn(void) { }
	
};


enum DECLSPEC_DENUM TLMDGridCheckBoxDataType : unsigned char { dtBoolean, dtString, dtInteger };

enum DECLSPEC_DENUM TLMDGridCheckBoxColumnSP : unsigned char { spCheckedValue, spUncheckedValue, spUndefinedValue, spCheckedDescr, spUncheckedDescr, spUndefinedDescr };

typedef System::StaticArray<Lmdtypes::TLMDString, 6> TStringPropsArr;

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDGridCheckBoxStateValues : public System::Classes::TPersistent
{
	typedef System::Classes::TPersistent inherited;
	
private:
	TLMDGridCheckBoxColumn* FCol;
	Lmdtypes::TLMDString __fastcall GetStrProp(const int Index);
	void __fastcall SetStrProp(const int Index, const Lmdtypes::TLMDString Value);
	bool __fastcall IsStrPropStored(const int Index);
	
public:
	__fastcall TLMDGridCheckBoxStateValues(TLMDGridCheckBoxColumn* ACol);
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	
__published:
	__property Lmdtypes::TLMDString CheckedValue = {read=GetStrProp, write=SetStrProp, stored=IsStrPropStored, index=0};
	__property Lmdtypes::TLMDString UncheckedValue = {read=GetStrProp, write=SetStrProp, stored=IsStrPropStored, index=1};
	__property Lmdtypes::TLMDString UndefinedValue = {read=GetStrProp, write=SetStrProp, stored=IsStrPropStored, index=2};
	__property Lmdtypes::TLMDString CheckedDescr = {read=GetStrProp, write=SetStrProp, stored=IsStrPropStored, index=3};
	__property Lmdtypes::TLMDString UncheckedDescr = {read=GetStrProp, write=SetStrProp, stored=IsStrPropStored, index=4};
	__property Lmdtypes::TLMDString UndefinedDescr = {read=GetStrProp, write=SetStrProp, stored=IsStrPropStored, index=5};
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TLMDGridCheckBoxStateValues(void) { }
	
};

#pragma pack(pop)

struct DECLSPEC_DRECORD TLMDGridCheckBoxInfo
{
public:
	int Width;
	int Height;
	int Flags;
};


class PASCALIMPLEMENTATION TLMDGridCheckBoxColumn : public TLMDGridColumn
{
	typedef TLMDGridColumn inherited;
	
private:
	TStringPropsArr FStringProps;
	TStringPropsArr FDefStringProps;
	TLMDGridCheckBoxDataType FDataType;
	TLMDGridCheckBoxStateValues* FStateValues;
	bool FDrawCB;
	bool FDrawDescr;
	bool FDrawGrayed;
	TLMDGridCheckBoxInfo __fastcall GetCheckBoxInfo(Vcl::Graphics::TCanvas* ACanvas, Vcl::Stdctrls::TCheckBoxState AState, bool APressed, bool AHot, Lmdclass::TLMDThemeMode AUseTheme);
	void __fastcall PaintCheckBox(Vcl::Graphics::TCanvas* ACanvas, const System::Types::TPoint &P, Lmdclass::TLMDThemeMode AUseTheme, const TLMDGridCheckBoxInfo &AInfo);
	void __fastcall SetDataType(const TLMDGridCheckBoxDataType Value);
	bool __fastcall IsStrPropStored(const TLMDGridCheckBoxColumnSP Index);
	Lmdtypes::TLMDString __fastcall GetStrProp(const TLMDGridCheckBoxColumnSP Index);
	void __fastcall SetStrProp(const TLMDGridCheckBoxColumnSP Index, const Lmdtypes::TLMDString Value);
	HIDESBASE void __fastcall BeginUpdate(void);
	HIDESBASE void __fastcall EndUpdate(bool ADataTypeChanged);
	void __fastcall SetStateValues(TLMDGridCheckBoxStateValues* const Value);
	void __fastcall SetDrawCB(const bool Value);
	void __fastcall SetDrawDescr(const bool Value);
	TLMDGridCheckBoxDataType __fastcall FieldDataTypeToColDataType(Data::Db::TFieldType ADataType);
	void __fastcall SetDrawGrayed(const bool Value);
	
protected:
	virtual int __fastcall CompareColValues(System::PVariant Val1, System::PVariant Val2);
	virtual bool __fastcall IsValueValid(System::PVariant Value, PLMDString AErrMsg);
	virtual void __fastcall NormalizeValue(System::PVariant ASrcValue, System::PVariant ADestValue);
	virtual void __fastcall PaintFormattedCellData(Vcl::Graphics::TCanvas* ACanvas, const System::Types::TRect &ARect, const System::Variant &AData, System::Classes::TAlignment AAlignment, TLMDGridCellStates ACellState);
	virtual _di_ILMDGridEmbeddedEdit __fastcall GetEmbeddedEditor(void);
	virtual void __fastcall ResetEmbeddedEditor(void);
	virtual bool __fastcall IsFieldTypeCompatibleWithColSettings(Data::Db::TField* AField, PLMDString PErrMessage);
	virtual void __fastcall DefineProperties(System::Classes::TFiler* Filer);
	void __fastcall ReadDescrsEmpty(System::Classes::TReader* Reader);
	System::UnicodeString __fastcall GetDescrsEmpty(const TStringPropsArr &ADescrs);
	void __fastcall WriteDescrsEmpty(System::Classes::TWriter* Writer);
	virtual void __fastcall CheckInitPropsForField(void);
	void __fastcall InitDefValues(void);
	void __fastcall SetDefValues(bool ASetDescr);
	void __fastcall CheckGridEmpty(void);
	void __fastcall CheckStrForState(const Lmdtypes::TLMDString AStr);
	System::Variant __fastcall StrToVar(const Lmdtypes::TLMDString AStr);
	Lmdtypes::TLMDString __fastcall VarToStr(System::PVariant AVar);
	Lmdtypes::TLMDString __fastcall StateToStr(Vcl::Stdctrls::TCheckBoxState AState);
	Vcl::Stdctrls::TCheckBoxState __fastcall StrToState(const Lmdtypes::TLMDString AStr);
	Lmdtypes::TLMDString __fastcall StateToDescr(Vcl::Stdctrls::TCheckBoxState AState);
	
public:
	__fastcall virtual TLMDGridCheckBoxColumn(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TLMDGridCheckBoxColumn(void);
	
__published:
	__property Alignment = {default=2};
	__property TLMDGridCheckBoxDataType DataType = {read=FDataType, write=SetDataType, default=0};
	__property TLMDGridCheckBoxStateValues* StateValues = {read=FStateValues, write=SetStateValues};
	__property bool DrawCheckBox = {read=FDrawCB, write=SetDrawCB, default=1};
	__property bool DrawDescription = {read=FDrawDescr, write=SetDrawDescr, default=0};
	__property bool DrawGrayed = {read=FDrawGrayed, write=SetDrawGrayed, default=0};
};


class PASCALIMPLEMENTATION TLMDGridImageColumn : public TLMDGridColumn
{
	typedef TLMDGridColumn inherited;
	
private:
	Vcl::Imglist::TCustomImageList* FImages;
	System::Uitypes::TImageIndex FEmptyImageIndex;
	int __fastcall VarToIntDef(System::PVariant V);
	void __fastcall SetImages(Vcl::Imglist::TCustomImageList* const Value);
	void __fastcall SetEmptyImageIndex(const System::Uitypes::TImageIndex Value);
	
protected:
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation Operation);
	virtual int __fastcall CompareColValues(System::PVariant Val1, System::PVariant Val2);
	virtual void __fastcall NormalizeValue(System::PVariant ASrcValue, System::PVariant ADestValue);
	virtual void __fastcall PaintFormattedCellData(Vcl::Graphics::TCanvas* ACanvas, const System::Types::TRect &ARect, const System::Variant &AData, System::Classes::TAlignment AAlignment, TLMDGridCellStates ACellState);
	virtual _di_ILMDGridEmbeddedEdit __fastcall GetEmbeddedEditor(void);
	virtual void __fastcall ResetEmbeddedEditor(void);
	
public:
	__fastcall virtual TLMDGridImageColumn(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TLMDGridImageColumn(void);
	
__published:
	__property Alignment = {default=2};
	__property Vcl::Imglist::TCustomImageList* Images = {read=FImages, write=SetImages};
	__property System::Uitypes::TImageIndex EmptyImageIndex = {read=FEmptyImageIndex, write=SetEmptyImageIndex, default=-1};
};


struct DECLSPEC_DRECORD TLMDGridRatingLayout
{
public:
	int Left;
	int ItemWidth;
	int ItemCount;
};


class PASCALIMPLEMENTATION TLMDGridRatingColumn : public TLMDGridColumn
{
	typedef TLMDGridColumn inherited;
	
private:
	Vcl::Graphics::TPicture* FGlyph;
	int FMaxRating;
	Vcl::Graphics::TPicture* FEmptyGlyph;
	bool FTransparent;
	TLMDGridRatingLayout FLastDrawn;
	void __fastcall GlyphsChanged(System::TObject* Sender);
	void __fastcall UpdateTransparent(void);
	void __fastcall SetGlyph(Vcl::Graphics::TPicture* const Value);
	void __fastcall SetEmptyGlyph(Vcl::Graphics::TPicture* const Value);
	void __fastcall SetMaxRating(const int Value);
	void __fastcall SetTransparent(const bool Value);
	
protected:
	virtual int __fastcall CompareColValues(System::PVariant Val1, System::PVariant Val2);
	virtual void __fastcall NormalizeValue(System::PVariant ASrcValue, System::PVariant ADestValue);
	virtual void __fastcall PaintFormattedCellData(Vcl::Graphics::TCanvas* ACanvas, const System::Types::TRect &ARect, const System::Variant &AData, System::Classes::TAlignment AAlignment, TLMDGridCellStates ACellState);
	virtual _di_ILMDGridEmbeddedEdit __fastcall GetEmbeddedEditor(void);
	virtual void __fastcall ResetEmbeddedEditor(void);
	int __fastcall VarToRating(System::PVariant AVar, /* out */ bool &AIsNull);
	
public:
	__fastcall virtual TLMDGridRatingColumn(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TLMDGridRatingColumn(void);
	
__published:
	__property Vcl::Graphics::TPicture* Glyph = {read=FGlyph, write=SetGlyph};
	__property Vcl::Graphics::TPicture* EmptyGlyph = {read=FEmptyGlyph, write=SetEmptyGlyph};
	__property int MaxRating = {read=FMaxRating, write=SetMaxRating, default=5};
	__property bool Transparent = {read=FTransparent, write=SetTransparent, default=1};
};


struct DECLSPEC_DRECORD TLMDGridProgressLayout
{
public:
	System::Types::TRect Content;
};


class PASCALIMPLEMENTATION TLMDGridProgressColumn : public TLMDGridColumn
{
	typedef TLMDGridColumn inherited;
	
private:
	int FMinValue;
	int FMaxValue;
	int FBarHeight;
	int FBarWidth;
	System::Uitypes::TColor FBarBorderColor;
	System::Uitypes::TColor FBarColor;
	System::Uitypes::TColor FChunkColor;
	TLMDGridProgressLayout FLastDrawn;
	void __fastcall SetMaxValue(const int Value);
	void __fastcall SetMinValue(const int Value);
	void __fastcall SetBarHeight(const int Value);
	void __fastcall SetBarWidth(const int Value);
	void __fastcall SetBarBorderColor(const System::Uitypes::TColor Value);
	void __fastcall SetBarColor(const System::Uitypes::TColor Value);
	void __fastcall SetChunkColor(const System::Uitypes::TColor Value);
	
protected:
	virtual int __fastcall CompareColValues(System::PVariant Val1, System::PVariant Val2);
	virtual void __fastcall NormalizeValue(System::PVariant ASrcValue, System::PVariant ADestValue);
	virtual void __fastcall PaintFormattedCellData(Vcl::Graphics::TCanvas* ACanvas, const System::Types::TRect &ARect, const System::Variant &AData, System::Classes::TAlignment AAlignment, TLMDGridCellStates ACellState);
	virtual _di_ILMDGridEmbeddedEdit __fastcall GetEmbeddedEditor(void);
	virtual void __fastcall ResetEmbeddedEditor(void);
	int __fastcall VarToProgress(System::PVariant AVar, /* out */ bool &AIsNull);
	
public:
	__fastcall virtual TLMDGridProgressColumn(System::Classes::TComponent* AOwner);
	
__published:
	__property Alignment = {default=2};
	__property int MinValue = {read=FMinValue, write=SetMinValue, default=0};
	__property int MaxValue = {read=FMaxValue, write=SetMaxValue, default=100};
	__property int BarWidth = {read=FBarWidth, write=SetBarWidth, default=-1};
	__property int BarHeight = {read=FBarHeight, write=SetBarHeight, default=12};
	__property System::Uitypes::TColor BarColor = {read=FBarColor, write=SetBarColor, default=-16777211};
	__property System::Uitypes::TColor BarBorderColor = {read=FBarBorderColor, write=SetBarBorderColor, default=-16777200};
	__property System::Uitypes::TColor ChunkColor = {read=FChunkColor, write=SetChunkColor, default=-16777203};
public:
	/* TLMDGridColumn.Destroy */ inline __fastcall virtual ~TLMDGridProgressColumn(void) { }
	
};


enum DECLSPEC_DENUM TLMDGridOption : unsigned char { opHeaderVertLine, opIndicatorHorzLine, opVertLine, opHorzLine, opRangeSelect, opRowSelect, opDrawFocusSelected, opRowSizing, opColSizing, opRowMoving, opColMoving, opEditing, opTabs, opAlwaysShowEditor, opThumbTracking, opShowIndicator, opShowHeader, opConfirmDeleteRow, opCancelOnExit, opHighlightHeaders, opShowEmptyBanner, opShowColumnsChooser };

typedef System::Set<TLMDGridOption, TLMDGridOption::opHeaderVertLine, TLMDGridOption::opShowColumnsChooser> TLMDGridOptions;

enum DECLSPEC_DENUM TLMDGridInternalState : unsigned char { isHaveVisibleCols, isHaveVisibleRows, isDestroing, isEditing, isColSizing, isRowSizing, isColMoving, isRowMoving, isSelExtending, isBlockPressedMouseAct, isNewRecord, isRowEdit, isRowEditChanged, isInplaceEditChanged, isInplaceEditHiding, isWasEditorShown, isNeedRestoreEditor, isNeedFullRepaint, isNoClick };

typedef System::Set<TLMDGridInternalState, TLMDGridInternalState::isHaveVisibleCols, TLMDGridInternalState::isNoClick> TLMDGridInternalStates;

enum DECLSPEC_DENUM TLMDGridScrollDir : unsigned char { sdUp, sdDown, sdLeft, sdRight, sdUpLeft, sdUpRight, sdDownLeft, sdDownRight, sdNone };

enum DECLSPEC_DENUM TLMDGridImage : unsigned char { giIndicatorCurrent, giIndicatorEditing, giIndicatorNewRow, giDropArrowColumn, giDropArrowRow, giSortArrowAsc, giSortArrowDesc, giChooserButton, giColumnsChoose };

enum DECLSPEC_DENUM TLMDGridChangeFlag : unsigned char { cfCurrent, cfTopLeft };

typedef System::Set<TLMDGridChangeFlag, TLMDGridChangeFlag::cfCurrent, TLMDGridChangeFlag::cfTopLeft> TLMDGridChangeFlags;

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDGridStyle : public System::Classes::TPersistent
{
	typedef System::Classes::TPersistent inherited;
	
private:
	TLMDCustomGrid* FGrid;
	System::StaticArray<System::Uitypes::TColor, 11> FColors;
	System::StaticArray<Vcl::Graphics::TBitmap*, 9> FImages;
	int FIndicatorWidth;
	int FHeaderRowHeight;
	Vcl::Graphics::TFont* FEmptyBannerFont;
	Lmdtypes::TLMDString FEmptyBanner;
	System::Uitypes::TColor __fastcall GetColor(const int Index);
	void __fastcall SetColor(const int Index, const System::Uitypes::TColor Value);
	Vcl::Graphics::TBitmap* __fastcall GetImg(const int Index);
	void __fastcall SetImg(const int Index, Vcl::Graphics::TBitmap* const Value);
	void __fastcall ObjChanged(System::TObject* Sender);
	void __fastcall SetHeaderRowHeight(const int Value);
	void __fastcall SetIndicatorWidth(const int Value);
	void __fastcall SetEmptyBanner(const Lmdtypes::TLMDString Value);
	void __fastcall SetEmptyBannerFont(Vcl::Graphics::TFont* const Value);
	
public:
	__fastcall TLMDGridStyle(TLMDCustomGrid* AGrid);
	__fastcall virtual ~TLMDGridStyle(void);
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	void __fastcall BeginUpdate(void);
	void __fastcall EndUpdate(void);
	
__published:
	__property System::Uitypes::TColor SortArrowColor = {read=GetColor, write=SetColor, index=0, default=-16777200};
	__property System::Uitypes::TColor HeaderBgColor = {read=GetColor, write=SetColor, index=1, default=-16777201};
	__property System::Uitypes::TColor HeaderHighlightColor = {read=GetColor, write=SetColor, index=2, default=-16777196};
	__property System::Uitypes::TColor HeaderMovingColor = {read=GetColor, write=SetColor, index=8, default=-16777200};
	__property System::Uitypes::TColor IndicatorBgColor = {read=GetColor, write=SetColor, index=3, default=-16777201};
	__property System::Uitypes::TColor CellBgColor = {read=GetColor, write=SetColor, index=4, default=-16777211};
	__property System::Uitypes::TColor AlternateBgColor = {read=GetColor, write=SetColor, index=10, default=-16777211};
	__property System::Uitypes::TColor SelectedCellBgColor = {read=GetColor, write=SetColor, index=5, default=-16777203};
	__property System::Uitypes::TColor SelectedCellTextColor = {read=GetColor, write=SetColor, index=6, default=-16777202};
	__property System::Uitypes::TColor SelectBorderColor = {read=GetColor, write=SetColor, index=9, default=536870911};
	__property System::Uitypes::TColor CellGridLinesColor = {read=GetColor, write=SetColor, index=7, default=-16777201};
	__property Vcl::Graphics::TBitmap* IndicatorCurrentImg = {read=GetImg, write=SetImg, index=0};
	__property Vcl::Graphics::TBitmap* IndicatorEditingImg = {read=GetImg, write=SetImg, index=1};
	__property Vcl::Graphics::TBitmap* IndicatorNewRowImg = {read=GetImg, write=SetImg, index=2};
	__property Vcl::Graphics::TBitmap* DropArrowColumnImg = {read=GetImg, write=SetImg, index=3};
	__property Vcl::Graphics::TBitmap* DropArrowRowImg = {read=GetImg, write=SetImg, index=4};
	__property Vcl::Graphics::TBitmap* SortArrowAscImg = {read=GetImg, write=SetImg, index=5};
	__property Vcl::Graphics::TBitmap* SortArrowDescImg = {read=GetImg, write=SetImg, index=6};
	__property Vcl::Graphics::TBitmap* ChooserButtonImg = {read=GetImg, write=SetImg, index=7};
	__property Vcl::Graphics::TBitmap* ChooseColumnsImg = {read=GetImg, write=SetImg, index=8};
	__property int IndicatorColWidth = {read=FIndicatorWidth, write=SetIndicatorWidth, default=10};
	__property int HeaderRowHeight = {read=FHeaderRowHeight, write=SetHeaderRowHeight, default=20};
	__property Lmdtypes::TLMDString EmptyBanner = {read=FEmptyBanner, write=SetEmptyBanner};
	__property Vcl::Graphics::TFont* EmptyBannerFont = {read=FEmptyBannerFont, write=SetEmptyBannerFont};
};

#pragma pack(pop)

typedef void __fastcall (__closure *TLMDGridColumnNameSetCallback)(TLMDGridColumn* ACol);

typedef void __fastcall (__closure *TKeyPressWEvent)(System::TObject* Sender, System::WideChar &Key);

typedef void __fastcall (__closure *TLMDGridChangeEvent)(System::TObject* Sender, TLMDGridChangeFlags AChangedFlags);

typedef void __fastcall (__closure *TLMDGridGetCellColorEvent)(System::TObject* Sender, TLMDGridCellStates ACellState, TLMDGridRowState ARowState, const System::Variant &AData, TLMDGridColumn* AColumn, int ARow, System::Uitypes::TColor &AColor);

typedef void __fastcall (__closure *TLMDGridDrawDataCellEvent)(System::TObject* Sender, Vcl::Graphics::TCanvas* ACanvas, const System::Types::TRect &ARect, TLMDGridCellStates ACellState, TLMDGridRowState ARowState, const System::Variant &AData, const System::Variant &AFormattedData, TLMDGridColumn* AColumn, int ARow);

typedef void __fastcall (__closure *TLMDGridDrawHeaderCellEvent)(System::TObject* Sender, Vcl::Graphics::TCanvas* ACanvas, const System::Types::TRect &ARect, TLMDGridCellStates ACellState, Lmdtypes::TLMDString &ACaption, bool AIsDummyHeader, TLMDGridColumn* AColumn);

typedef void __fastcall (__closure *TLMDGridDrawIndicatorEvent)(System::TObject* Sender, Vcl::Graphics::TCanvas* ACanvas, const System::Types::TRect &ARect, TLMDGridCellStates ACellState, TLMDGridRowState ARowState, int ARow);

typedef void __fastcall (__closure *TLMDGridDelRowEvent)(System::TObject* Sender, int Row, bool &DoDelete, bool &BeepIfDisagree);

typedef void __fastcall (__closure *TLMDGridPaintEmptyBannerEvent)(System::TObject* Sender, Vcl::Graphics::TCanvas* ACanvas, const System::Types::TRect &ARect);

class PASCALIMPLEMENTATION TLMDCustomGrid : public Vcl::Grids::TCustomGrid
{
	typedef Vcl::Grids::TCustomGrid inherited;
	
private:
	Lmdtypes::TLMDAboutVar FAbout;
	TLMDGridEditParentHelper* FEditHelper;
	System::TObject* FStore;
	int FUpdateCnt;
	int FInternalCnt;
	int FSetColDefModeCnt;
	int FInitColModeCnt;
	TLMDGridInternalStates FState;
	TLMDGridChangeFlags FChangeFlags;
	Vcl::Grids::TGridCoord FHoverCell;
	TLMDGridColumns* FColumns;
	TLMDGridStyle* FStyle;
	Lmdclass::TLMDThemeMode FThemeMode;
	bool FThemeGlobalMode;
	System::Types::TPoint FMouseDownPt;
	System::Types::TPoint FMouseMovePt;
	TLMDGridOptions FOptions;
	Vcl::Graphics::TBitmap* FCellBmp;
	Vcl::Graphics::TBitmap* FMovingBmp;
	Vcl::Controls::TControl* FEditPanel;
	int FSizeMoveIdx;
	System::Types::TPoint FMoveOffset;
	int FMoveDropIdx;
	int FSizingNewSize;
	Vcl::Extctrls::TTimer* FMoveSizeTimer;
	TLMDGridScrollDir FMoveSizeTimerDir;
	System::Types::TPoint FSelectionAnchor;
	TLMDGridDelRowEvent FBeforeRowDelete;
	TLMDGridPaintEmptyBannerEvent FPaintEmptyBanner;
	TLMDGridBoolArray FColumnsVisible;
	TLMDGridBoolArray FColumnsReadOnly;
	TKeyPressWEvent FOnKeyPressW;
	TLMDGridChangeEvent FOnChange;
	TLMDGridGetCellColorEvent FOnGetCellColor;
	TLMDGridDrawDataCellEvent FOnDrawDataCell;
	TLMDGridDrawHeaderCellEvent FOnDrawHeaderCell;
	TLMDGridDrawIndicatorEvent FOnDrawIndicator;
	int FOldCol;
	int FOldRow;
	int FOldTop;
	int FOldLeft;
	TLMDGridCustomSource* FCustomSource;
	System::Uitypes::TScrollStyle FScrollBarsStyle;
	HIDESBASE MESSAGE void __fastcall WMEraseBkgnd(Winapi::Messages::TMessage &Msg);
	MESSAGE void __fastcall WMThemeChanged(Winapi::Messages::TMessage &Msg);
	HIDESBASE MESSAGE void __fastcall WMSetFocus(Winapi::Messages::TWMSetFocus &Msg);
	HIDESBASE MESSAGE void __fastcall WMChar(Winapi::Messages::TWMKey &Msg);
	HIDESBASE MESSAGE void __fastcall WMCancelMode(Winapi::Messages::TWMNoParams &Msg);
	HIDESBASE MESSAGE void __fastcall WMSetCursor(Winapi::Messages::TWMSetCursor &Msg);
	HIDESBASE MESSAGE void __fastcall CMDesignHitTest(Winapi::Messages::TWMMouse &Msg);
	HIDESBASE MESSAGE void __fastcall CMMouseLeave(Winapi::Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMCancelMode(Vcl::Controls::TCMCancelMode &Msg);
	MESSAGE void __fastcall HidePopupMessage(Winapi::Messages::TMessage &Msg);
	HIDESBASE bool __fastcall IsActiveControl(void);
	void __fastcall SetThemeGlobalMode(const bool Value);
	void __fastcall SetThemeMode(const Lmdclass::TLMDThemeMode Value);
	int __fastcall GetCurrentColumn(void);
	int __fastcall GetCurrentRow(void);
	void __fastcall SetCurrentColumn(const int ACol);
	void __fastcall SetCurrentRow(const int ARow);
	bool __fastcall IsInteractiveState(void);
	bool __fastcall NoMovingSizingState(void);
	bool __fastcall MovingState(void);
	bool __fastcall SizingState(void);
	void __fastcall SetIndicatorHeaderOptionsLow(bool AShowIndicator, bool AShowHeaders, bool AShowIndicatorOld, bool AShowHeadersOld);
	void __fastcall SetBaseOptions(const TLMDGridOptions Value);
	HIDESBASE void __fastcall SetOptions(const TLMDGridOptions Value);
	void __fastcall ResetHoverCell(void);
	void __fastcall InvalidateBySelectCell(int ANewCol, int ANewRow)/* overload */;
	void __fastcall InvalidateIndicator(int ARow = 0xffffffff);
	void __fastcall InvalidateMovingPt(int OldX, int OldY, int X, int Y);
	int __fastcall GetMoveDropIndex(int X, int Y, bool AColMoving);
	System::Types::TRect __fastcall GetMoveDropRect(int AIndex, bool AColMoving);
	void __fastcall OnMoveSizeTimer(System::TObject* ASender);
	void __fastcall OnFontChange(System::TObject* ASender);
	void __fastcall DoThemeChanged(void);
	TLMDGridInternalStates __fastcall GetMouseSizingState(int X, int Y, int &SizingIdx);
	void __fastcall ExitFromSizingMoving(bool ACancelMoveSize, int X, int Y);
	void __fastcall SetStyle(TLMDGridStyle* const Value);
	void __fastcall FillColumnsChooseMenu(Vcl::Menus::TPopupMenu* AMenu);
	void __fastcall OnColumnsMenuClick(System::TObject* Sender);
	void __fastcall SetDataCell(int ACol, int ARow, const System::Variant &Value);
	System::Variant __fastcall GetDataCell(int ACol, int ARow);
	void __fastcall SetDataCellLow(int ACol, int ARow, const System::Variant &Key, const System::Variant &Value);
	void __fastcall GetDataCellLow(int ACol, int ARow, System::Variant &Key, System::Variant &Value);
	void __fastcall OnDesignSelectonChanged(System::TObject* ASender);
	void __fastcall SelectAutoColumn(TLMDGridColumn* ACol, bool ADoAdd);
	bool __fastcall HaveSelectedAutoColumns(void);
	void __fastcall SetCustomSource(TLMDGridCustomSource* const Value);
	void __fastcall SetScrollBarsStyle(const System::Uitypes::TScrollStyle Value);
	bool __fastcall IsOptionsStored(void);
	
protected:
	Lmdtypes::TLMDPackageID __fastcall getLMDPackage(void);
	DYNAMIC bool __fastcall DesignWndProc(Winapi::Messages::TMessage &Message);
	bool __fastcall IsUpdating(void);
	bool __fastcall HaveVisibleData(void);
	bool __fastcall HaveVisibleCols(void);
	bool __fastcall HaveRows(void);
	void __fastcall EnterInitMode(void);
	void __fastcall ExitInitMode(void);
	bool __fastcall InInitMode(void);
	void __fastcall RebuildColsSaved(void);
	void __fastcall CheckDataLayoutChange(void);
	bool __fastcall IsSortingAllowed(TLMDGridColumn* ACol);
	void __fastcall IncludeState(TLMDGridInternalState AState);
	void __fastcall ExcludeState(TLMDGridInternalState AState)/* overload */;
	void __fastcall ExcludeState(TLMDGridInternalStates AState)/* overload */;
	void __fastcall IncludeChange(TLMDGridChangeFlag AChange);
	void __fastcall ScrollToCurrent(void);
	void __fastcall ED_WMGetDlgCode(const _di_ILMDGridEmbeddedEdit Ed, Winapi::Messages::TWMNoParams &Message);
	bool __fastcall ED_WndProc(const _di_ILMDGridEmbeddedEdit Edit, Winapi::Messages::TMessage &Message);
	void __fastcall ED_KeyDown(System::Word &Key, System::Classes::TShiftState Shift, bool APreprocess, TLMDGridKeyProcessSource Source);
	void __fastcall ED_EditorChanged(void);
	bool __fastcall ED_IsEditorChanged(void);
	bool __fastcall ED_DoMouseWheelDown(System::Classes::TShiftState Shift);
	bool __fastcall ED_DoMouseWheelUp(System::Classes::TShiftState Shift);
	System::Types::TRect __fastcall GetInplaceEditRect(void);
	bool __fastcall ShowInplaceEditor(void)/* overload */;
	bool __fastcall ShowInplaceEditor(const TLMDGridFirstInput &AInput)/* overload */;
	void __fastcall HideInplaceEditor(bool ACommitData, bool AReturnFocus);
	void __fastcall HidePopupChooserDelayed(void);
	void __fastcall UpdateInplaceEditState(void);
	void __fastcall ReFocusInplaceEditor(HWND AFocusFrom);
	void __fastcall InplaceEditDoCancelMode(Vcl::Controls::TControl* ASender);
	void __fastcall KeyDownLow(System::Word &Key, System::Classes::TShiftState Shift, TLMDGridKeyProcessSource Source);
	DYNAMIC void __fastcall KeyDown(System::Word &Key, System::Classes::TShiftState Shift);
	DYNAMIC void __fastcall KeyPress(System::WideChar &Key);
	virtual void __fastcall KeyPressW(System::WideChar &Key);
	void __fastcall DoKeyPressW(Winapi::Messages::TWMKey &AMsg);
	DYNAMIC void __fastcall MouseMove(System::Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseDown(System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseUp(System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall Click(void);
	virtual bool __fastcall SelectCell(int ACol, int ARow);
	virtual bool __fastcall CanEditShow(void);
	virtual void __fastcall CreateParams(Vcl::Controls::TCreateParams &Params);
	virtual Vcl::Grids::TInplaceEdit* __fastcall CreateEditor(void);
	DYNAMIC void __fastcall Resize(void);
	virtual void __fastcall CreateWnd(void);
	HIDESBASE MESSAGE void __fastcall CMShowingChanged(Winapi::Messages::TMessage &Message);
	virtual void __fastcall CreateWindowHandle(const Vcl::Controls::TCreateParams &Params);
	DYNAMIC void __fastcall RowHeightsChanged(void);
	DYNAMIC bool __fastcall DoMouseWheelDown(System::Classes::TShiftState Shift, const System::Types::TPoint &MousePos);
	DYNAMIC bool __fastcall DoMouseWheelUp(System::Classes::TShiftState Shift, const System::Types::TPoint &MousePos);
	virtual void __fastcall InternalDeleteDataRow(int ARow, int &CorrIndex);
	virtual void __fastcall InternalDataSourceSort(TLMDGridColumn* AColumn, TLMDGridSortKind Value, int &ACorrectIdx);
	virtual void __fastcall InternalSetDataCell(int ACol, int ARow, System::PVariant Key, System::PVariant Value, bool ABlockSort, /* out */ int &NewRow);
	virtual void __fastcall InternalGetDataCell(int ACol, int ARow, System::PVariant Key, System::PVariant Value);
	virtual bool __fastcall InternalDataSourceCanSort(void);
	virtual void __fastcall GetAvailableColumnFieldNames(TLMDGridColumn* ACol, System::Classes::TStrings* AList);
	virtual Data::Db::TField* __fastcall GetColumnField(TLMDGridColumn* AColumn);
	virtual Data::Db::TField* __fastcall GetColumnFieldKey(TLMDGridColumn* AColumn);
	virtual Lmdtypes::TLMDString __fastcall GetDefaultColumnCaption(TLMDGridColumn* AColumn);
	virtual System::Classes::TAlignment __fastcall GetDefaultColumnAlignment(TLMDGridColumn* AColumn);
	virtual bool __fastcall GetDefaultColumnVisible(TLMDGridColumn* AColumn);
	virtual bool __fastcall GetDefaultColumnReadOnly(TLMDGridColumn* AColumn);
	virtual int __fastcall GetDefaultColumnWidth(TLMDGridColumn* AColumn);
	void __fastcall ResetColumnsPaintCache(void);
	virtual bool __fastcall GetAutoColumnsMode(void);
	virtual void __fastcall SetAutoColumnsMode(bool AMode);
	virtual bool __fastcall CanFillColumnsFromStore(void);
	virtual void __fastcall FillColumnsFromStore(TLMDGridColumnNameSetCallback ANameSetProc);
	virtual void __fastcall ColumnAdding(TLMDGridColumn* AColumn);
	virtual void __fastcall ColumnAdded(TLMDGridColumn* AColumn);
	virtual void __fastcall ColumnDeleting(TLMDGridColumn* AColumn);
	virtual void __fastcall ColumnMoving(int AFrom, int ATo);
	virtual void __fastcall MoveDataRow(int AFrom, int ATo);
	virtual bool __fastcall IsEOF(void);
	virtual void __fastcall InternalColumnDataTypeChanged(TLMDGridColumn* ACol);
	virtual void __fastcall InternalDataLayoutChange(void);
	virtual void __fastcall InternalEnterNewRecMode(int ADestIndex);
	virtual void __fastcall InternalExitNewRecMode(bool ACommit, /* out */ int &ACurrentIndex);
	virtual void __fastcall InternalEnterRowEditMode(void);
	virtual void __fastcall InternalExitRowEditMode(bool ACommit, /* out */ int &ACurrentIndex);
	virtual void __fastcall InternalSetColumnFieldName(TLMDGridColumn* AColumn, const System::UnicodeString Value, bool ABefore);
	virtual void __fastcall InternalSetColumnGrid(TLMDGridColumn* AColumn);
	virtual bool __fastcall InternalIsColumnDataBound(int ACol);
	virtual void __fastcall InternalSetDefaultColWidth(TLMDGridColumn* AColumn);
	virtual void __fastcall InternalSetDefaultColPos(TLMDGridColumn* AColumn);
	virtual void __fastcall InternalAfterSyncGridStore(void);
	virtual void __fastcall InternalUpdateStore(void);
	virtual bool __fastcall InternalMoveVert(int ANewCurrent, int ANewTop);
	virtual void __fastcall InternalRestrictDataPoint(int &ACol, int &ARow);
	virtual void __fastcall InternalSetupScrollBarsStyle(void);
	virtual void __fastcall InternalEndUpdateLow(void);
	virtual int __fastcall GetDataRowCount(void);
	virtual void __fastcall SetDataRowCount(const int Value);
	virtual void __fastcall Beep(void);
	virtual bool __fastcall ConfirmDeleteCurrentRow(void);
	virtual bool __fastcall CanStoreEdit(void);
	virtual bool __fastcall CanStoreInsert(void);
	virtual bool __fastcall CanStoreRemove(void);
	virtual bool __fastcall CanStoreMoveCol(void);
	virtual bool __fastcall CanStoreMoveRow(void);
	virtual bool __fastcall CanStoreRowEdit(void);
	virtual void __fastcall PageSizeChanged(void);
	virtual System::Types::TRect __fastcall GetSelRect(void);
	virtual bool __fastcall IsSelectionValid(void);
	virtual void __fastcall CancelSelectionLow(void);
	TLMDGridEditParentHelper* __fastcall GetEditorHelper(void);
	virtual TLMDGridStyle* __fastcall GetStyle(void);
	virtual bool __fastcall UseAlternate(void);
	System::Uitypes::TColor __fastcall GetStyledColor(System::Uitypes::TColor C);
	void __fastcall DrawStyledEdge(Vcl::Graphics::TCanvas* C, System::Types::TRect &R, int AFlags);
	System::Uitypes::TColor __fastcall GetDataCellColor(TLMDGridColumn* AColumn, TLMDGridCellStates ACellState, int ADataRow);
	HIDESBASE void __fastcall DrawCell(int ACol, int ARow, const System::Types::TRect &ARect, bool AMoving, Vcl::Graphics::TCanvas* ACanvas);
	virtual void __fastcall Paint(void);
	DYNAMIC void __fastcall ColumnMoved(int FromIndex, int ToIndex);
	DYNAMIC void __fastcall RowMoved(int FromIndex, int ToIndex);
	DYNAMIC void __fastcall TopLeftChanged(void);
	DYNAMIC void __fastcall DoExit(void);
	DYNAMIC void __fastcall DoEnter(void);
	DYNAMIC bool __fastcall BeginColumnDrag(int &Origin, int &Destination, const System::Types::TPoint &MousePt);
	DYNAMIC bool __fastcall BeginRowDrag(int &Origin, int &Destination, const System::Types::TPoint &MousePt);
	DYNAMIC bool __fastcall EndColumnDrag(int &Origin, int &Destination, const System::Types::TPoint &MousePt);
	DYNAMIC bool __fastcall EndRowDrag(int &Origin, int &Destination, const System::Types::TPoint &MousePt);
	bool __fastcall SetCurrent(int ACol, int ARow, bool WithSelection, bool AClickEvent = true)/* overload */;
	bool __fastcall SetCurrent(int ACol, int ARow, int ALeftCol, int ATopRow, bool WithSelection, bool AClickEvent = true)/* overload */;
	void __fastcall DeleteCurrentRow(void);
	void __fastcall RestrictDataPoint(int &ACol, int &ARow, bool ARestrictRow);
	int __fastcall TopDataRow(void);
	int __fastcall LeftDataCol(void);
	int __fastcall VisibleColumnsCount(void);
	bool __fastcall IsColVisible(int ADataCol);
	int __fastcall VisibleColToCol(int AVisCol);
	int __fastcall FindNearVisibleCol(int ADataCol, bool ABack);
	void __fastcall RemoveColumn(TLMDGridColumn* AColumn);
	void __fastcall InsertColumn(TLMDGridColumn* AColumn);
	void __fastcall ClearColumns(void);
	void __fastcall SetColPositionLow(TLMDGridColumn* AColumn, int Value);
	void __fastcall SetColWidthLow(TLMDGridColumn* AColumn, int Value, /* out */ int &FieldVal);
	void __fastcall SetColVisibleLow(TLMDGridColumn* AColumn, bool Value, /* out */ bool &FieldVal);
	void __fastcall SetColReadOnlyLow(TLMDGridColumn* AColumn, bool Value, /* out */ bool &FieldVal);
	void __fastcall SetColFieldNameLow(TLMDGridColumn* AColumn, const System::UnicodeString Value, System::UnicodeString &FieldVal);
	TLMDGridSortKind __fastcall SetSortLow(TLMDGridColumn* AColumn, TLMDGridSortKind Value);
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation Operation);
	void __fastcall CheckColumnsNotSet(void);
	void __fastcall CheckStyleNotSet(void);
	void __fastcall CheckCellIdx(int ACol, int ARow);
	void __fastcall CheckColumnIdx(int Value);
	void __fastcall CheckColumnVisible(int ACol);
	void __fastcall CheckRowIdx(int ARow);
	void __fastcall BeginUpdateLow(bool ANeedRestoreEditor, bool AFullRepaint);
	void __fastcall EndUpdateLow(bool ABlockRestoreEditor = false);
	void __fastcall BeginInternal(void);
	void __fastcall EndInternal(void);
	bool __fastcall InInternal(void);
	void __fastcall SyncGridStore(void);
	System::Types::TSize __fastcall PageExtents(void);
	int __fastcall PageHeight(void);
	int __fastcall PageWidth(void);
	bool __fastcall CanEdit(void);
	bool __fastcall CanInsert(void);
	bool __fastcall CanRemove(void);
	bool __fastcall CanMoveCol(void);
	bool __fastcall CanMoveRow(void);
	bool __fastcall IsNewRecMode(void);
	bool __fastcall InitNewRecMode(bool AInsertBefore);
	void __fastcall ExitNewRecMode(bool ACommit, /* out */ bool &Cancelled)/* overload */;
	void __fastcall ExitNewRecMode(bool ACommit)/* overload */;
	bool __fastcall IsRowEditMode(void);
	void __fastcall InitRowEditMode(void);
	void __fastcall ExitRowEditMode(bool ACommit);
	void __fastcall CancelSelection(void);
	bool __fastcall InSelection(int ADataCol, int ADataRow);
	void __fastcall InvalidateGridRect(const System::Types::TRect &ARect);
	void __fastcall InvalidateSelRect(void);
	bool __fastcall IsHeaderRow(int ARow);
	bool __fastcall IsDataCol(int ACol);
	bool __fastcall IsDataRow(int ARow);
	bool __fastcall IsDataCell(int ACol, int ARow);
	bool __fastcall IsIndicatorCol(int ACol);
	TLMDGridCellStates __fastcall GetCellState(int ACol, int ARow);
	TLMDGridCellKind __fastcall GetCellKind(int ACol, int ARow);
	TLMDGridRowState __fastcall GetCellRowState(int ACol, int ARow);
	System::Classes::TShiftState __fastcall GetShiftState(void);
	void __fastcall DeleteDataRow(int ARow);
	__property DefaultRowHeight = {default=18};
	__property System::Variant Cells[int ACol][int ARow] = {read=GetDataCell, write=SetDataCell};
	__property int DataRowCount = {read=GetDataRowCount, write=SetDataRowCount, nodefault};
	__property int CurrentRow = {read=GetCurrentRow, write=SetCurrentRow, nodefault};
	__property TLMDGridColumns* Columns = {read=FColumns, stored=false};
	__property TLMDGridStyle* Style = {read=GetStyle, write=SetStyle};
	__property Lmdclass::TLMDThemeMode ThemeMode = {read=FThemeMode, write=SetThemeMode, default=1};
	__property bool ThemeGlobalMode = {read=FThemeGlobalMode, write=SetThemeGlobalMode, default=0};
	__property TLMDGridOptions Options = {read=FOptions, write=SetOptions, stored=IsOptionsStored, nodefault};
	__property System::Uitypes::TScrollStyle ScrollBarsStyle = {read=FScrollBarsStyle, write=SetScrollBarsStyle, default=3};
	__property TLMDGridDelRowEvent OnBeforeRowDelete = {read=FBeforeRowDelete, write=FBeforeRowDelete};
	__property TLMDGridPaintEmptyBannerEvent OnPaintEmptyBanner = {read=FPaintEmptyBanner, write=FPaintEmptyBanner};
	__property TLMDGridGetCellColorEvent OnGetCellColor = {read=FOnGetCellColor, write=FOnGetCellColor};
	__property TLMDGridDrawDataCellEvent OnDrawDataCell = {read=FOnDrawDataCell, write=FOnDrawDataCell};
	__property TLMDGridDrawHeaderCellEvent OnDrawHeaderCell = {read=FOnDrawHeaderCell, write=FOnDrawHeaderCell};
	__property TLMDGridDrawIndicatorEvent OnDrawIndicator = {read=FOnDrawIndicator, write=FOnDrawIndicator};
	__property TKeyPressWEvent OnKeyPressW = {read=FOnKeyPressW, write=FOnKeyPressW};
	__property TLMDGridChangeEvent OnChange = {read=FOnChange, write=FOnChange};
	__property TLMDGridCustomSource* CustomSource = {read=FCustomSource, write=SetCustomSource};
	
public:
	__fastcall virtual TLMDCustomGrid(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TLMDCustomGrid(void);
	DYNAMIC void __fastcall GetChildren(System::Classes::TGetChildProc Proc, System::Classes::TComponent* Root);
	Lmdclass::TLMDThemeMode __fastcall UseThemeMode(void);
	void __fastcall BeginUpdate(void);
	void __fastcall EndUpdate(void);
	bool __fastcall IsEditorShown(void);
	bool __fastcall Edit(void);
	void __fastcall EndEditing(bool ACommit);
	int __fastcall GridColToDataCol(int ACol);
	int __fastcall DataColToGridCol(int ACol);
	int __fastcall GridRowToDataRow(int ARow);
	int __fastcall DataRowToGridRow(int ARow);
	System::Types::TRect __fastcall DataRectToGridRect(const System::Types::TRect &ARect);
	HIDESBASE Vcl::Grids::TGridCoord __fastcall MouseCoord(int X, int Y);
	HIDESBASE System::Types::TRect __fastcall CellRect(int ACol, int ARow);
	__property int CurrentColumn = {read=GetCurrentColumn, write=SetCurrentColumn, nodefault};
	
__published:
	__property Lmdtypes::TLMDAboutVar About = {read=FAbout, write=FAbout, stored=false};
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDCustomGrid(HWND ParentWindow) : Vcl::Grids::TCustomGrid(ParentWindow) { }
	
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


class PASCALIMPLEMENTATION TLMDGrid : public TLMDCustomGrid
{
	typedef TLMDCustomGrid inherited;
	
public:
	HIDESBASE void __fastcall DeleteDataRow(int ARow);
	__property Cells;
	__property DataRowCount;
	__property CurrentRow;
	__property CustomSource;
	
__published:
	__property Columns;
	__property Style;
	__property DefaultColWidth = {default=64};
	__property DefaultRowHeight = {default=18};
	__property ScrollBarsStyle = {default=3};
	__property ThemeMode = {default=1};
	__property ThemeGlobalMode = {default=0};
	__property Options;
	__property OnBeforeRowDelete;
	__property OnPaintEmptyBanner;
	__property OnGetCellColor;
	__property OnDrawDataCell;
	__property OnDrawHeaderCell;
	__property OnDrawIndicator;
	__property Align = {default=0};
	__property Anchors = {default=3};
	__property BevelEdges = {default=15};
	__property BevelInner = {index=0, default=2};
	__property BevelKind = {default=0};
	__property BevelOuter = {index=1, default=1};
	__property BevelWidth = {default=1};
	__property BiDiMode;
	__property BorderStyle = {default=1};
	__property Color = {default=-16777211};
	__property Constraints;
	__property Ctl3D;
	__property DoubleBuffered;
	__property DragCursor = {default=-12};
	__property DragKind = {default=0};
	__property DragMode = {default=0};
	__property Enabled = {default=1};
	__property Font;
	__property ImeMode = {default=3};
	__property ImeName = {default=0};
	__property ParentBiDiMode = {default=1};
	__property ParentColor = {default=0};
	__property ParentCtl3D = {default=1};
	__property ParentDoubleBuffered = {default=1};
	__property ParentFont = {default=1};
	__property ParentShowHint = {default=1};
	__property PopupMenu;
	__property ShowHint;
	__property TabOrder = {default=-1};
	__property TabStop = {default=1};
	__property Text = {default=0};
	__property Visible = {default=1};
	__property OnChange;
	__property OnClick;
	__property OnContextPopup;
	__property OnDblClick;
	__property OnDragDrop;
	__property OnDragOver;
	__property OnEndDock;
	__property OnEndDrag;
	__property OnEnter;
	__property OnExit;
	__property OnKeyDown;
	__property OnKeyPress;
	__property OnKeyUp;
	__property OnMouseDown;
	__property OnMouseEnter;
	__property OnMouseLeave;
	__property OnMouseMove;
	__property OnMouseUp;
	__property OnStartDock;
	__property OnStartDrag;
	__property OnGesture;
	__property Touch;
	__property OnMouseActivate;
public:
	/* TLMDCustomGrid.Create */ inline __fastcall virtual TLMDGrid(System::Classes::TComponent* AOwner) : TLMDCustomGrid(AOwner) { }
	/* TLMDCustomGrid.Destroy */ inline __fastcall virtual ~TLMDGrid(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDGrid(HWND ParentWindow) : TLMDCustomGrid(ParentWindow) { }
	
};


typedef void __fastcall (*TLMDDesignerSelectComponent)(Vcl::Controls::TControl* ADsgControl, System::Classes::TComponent* AComponent, bool ADoAddSelection);

typedef bool __fastcall (*TLMDDesignerIsComponentSelected)(Vcl::Controls::TControl* ADsgControl, System::Classes::TComponent* AComponent);

typedef void __fastcall (*TLMDDesignSelectionNotifyRegister)(Vcl::Controls::TControl* ADsgControl, bool AIsRegister, System::Classes::TNotifyEvent ANotifyProc);

//-- var, const, procedure ---------------------------------------------------
static const System::Word HIDEPOPUP_MESSAGE = System::Word(0x401);
extern DELPHI_PACKAGE TLMDDesignerSelectComponent LMDDesignerSelectComponentProc;
extern DELPHI_PACKAGE TLMDDesignerIsComponentSelected LMDDesignerIsComponentSelected;
extern DELPHI_PACKAGE TLMDDesignSelectionNotifyRegister LMDDesignSelectionNotifyRegister;
extern DELPHI_PACKAGE bool __fastcall IsVarEmpty(System::PVariant Val);
}	/* namespace Lmdgrid */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDGRID)
using namespace Lmdgrid;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdgridHPP
