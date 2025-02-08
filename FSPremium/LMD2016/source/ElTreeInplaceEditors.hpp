// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'ElTreeInplaceEditors.pas' rev: 31.00 (Windows)

#ifndef EltreeinplaceeditorsHPP
#define EltreeinplaceeditorsHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.SysUtils.hpp>
#include <System.Classes.hpp>
#include <Vcl.Controls.hpp>
#include <Winapi.Messages.hpp>
#include <Winapi.Windows.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.Forms.hpp>
#include <Vcl.StdCtrls.hpp>
#include <Vcl.ExtCtrls.hpp>
#include <Winapi.CommCtrl.hpp>
#include <System.Types.hpp>
#include <Vcl.ImgList.hpp>
#include <Vcl.Buttons.hpp>
#include <Vcl.Menus.hpp>
#include <System.Variants.hpp>
#include <Winapi.Imm.hpp>
#include <Winapi.ActiveX.hpp>
#include <System.TypInfo.hpp>
#include <LMDVldBase.hpp>
#include <LMDElConst.hpp>
#include <LMDClass.hpp>
#include <LMDThemes.hpp>
#include <Vcl.Themes.hpp>
#include <LMDTypes.hpp>
#include <LMDUnicodeStrings.hpp>
#include <LMDHTMLUnit.hpp>
#include <LMDObjectList.hpp>
#include <LMDProcs.hpp>
#include <LMDGraphUtils.hpp>
#include <ElStyleMan.hpp>
#include <ElComponent.hpp>
#include <ElHook.hpp>
#include <ElXPThemedControl.hpp>
#include <ElHeader.hpp>
#include <ElSBCtrl.hpp>
#include <ElScrollBar.hpp>
#include <ElHintWnd.hpp>
#include <ElInputProcessor.hpp>
#include <ElIni.hpp>
#include <LMDGlyphs.hpp>
#include <ElImgFrm.hpp>
#include <ElDragDrop.hpp>
#include <ElVCLUtils.hpp>

//-- user supplied -----------------------------------------------------------

namespace Eltreeinplaceeditors
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS EElTreeError;
__interface IElTreeView;
typedef System::DelphiInterface<IElTreeView> _di_IElTreeView;
__interface IElTree;
typedef System::DelphiInterface<IElTree> _di_IElTree;
class DELPHICLASS TElTreeViewAncestor;
class DELPHICLASS TElTreeAncestor;
class DELPHICLASS TElTreeInplaceManager;
class DELPHICLASS THackWinControl;
class DELPHICLASS TElTreeInplaceEditor;
//-- type declarations -------------------------------------------------------
enum DECLSPEC_DENUM TSTItemPart : unsigned char { ipButton, ipMainText, ipColumn, ipInside, ipPicture, ipPicture2, ipCheckBox, ipGutter, ipOutside };

typedef TSTItemPart TSTXItemPart;

enum DECLSPEC_DENUM TElDragType : unsigned char { dtOLE, dtDelphi, dtBoth };

enum DECLSPEC_DENUM TSTSelModes : unsigned char { smSimple, smUsual };

enum DECLSPEC_DENUM TSortDirs : unsigned char { sdAscend, sdDescend };

enum DECLSPEC_DENUM TSortModes : unsigned char { smNone, smAdd, smClick, smAddClick };

enum DECLSPEC_DENUM TSortTypes : unsigned char { stCustom, stText, stNumber, stFloating, stDateTime, stDate, stTime, stBoolean, stCurrency };

enum DECLSPEC_DENUM THintModes : unsigned char { shmNone, shmLong, shmAll };

enum DECLSPEC_DENUM TLineHintType : unsigned char { lhtMainTextOnly, lhtCellTextOnly, lhtSmart };

enum DECLSPEC_DENUM TElHintType : unsigned char { shtMainText, shtHintOnly, shtHintOrText };

enum DECLSPEC_DENUM TDragImgMode : unsigned char { dimNever, dimOne, dimAll };

enum DECLSPEC_DENUM TNodeAttachMode : unsigned char { naAdd, naAddFirst, naAddChild, naAddChildFirst, naInsert };

enum DECLSPEC_DENUM TElCheckBoxType : unsigned char { ectCheckBox, ect3SCheckBox, ectRadioButton };

enum DECLSPEC_DENUM TElDblClickMode : unsigned char { dcmNone, dcmExpand, dcmEdit };

enum DECLSPEC_DENUM TElIncSearchScope : unsigned char { issWholeTree, issWithinParent };

enum DECLSPEC_DENUM TElIncSearchColumn : unsigned char { iscMainText, iscSortColumn };

enum DECLSPEC_DENUM TVirtualityLevel : unsigned char { vlNone, vlTextAndStyles, vlAllProps };

enum DECLSPEC_DENUM TElItemBorderStyle : unsigned char { ibsNone, ibsRaised, ibsFlat, ibsSunken, ibsSpace };

enum DECLSPEC_DENUM TItemChangeMode : unsigned char { icmText, icmState, icmCheckState, icmColumnText };

typedef void __fastcall (__closure *TColumnNotifyEvent)(System::TObject* Sender, int SectionIndex);

#pragma pack(push,4)
class PASCALIMPLEMENTATION EElTreeError : public System::Sysutils::Exception
{
	typedef System::Sysutils::Exception inherited;
	
public:
	/* Exception.Create */ inline __fastcall EElTreeError(const System::UnicodeString Msg) : System::Sysutils::Exception(Msg) { }
	/* Exception.CreateFmt */ inline __fastcall EElTreeError(const System::UnicodeString Msg, const System::TVarRec *Args, const int Args_High) : System::Sysutils::Exception(Msg, Args, Args_High) { }
	/* Exception.CreateRes */ inline __fastcall EElTreeError(NativeUInt Ident)/* overload */ : System::Sysutils::Exception(Ident) { }
	/* Exception.CreateRes */ inline __fastcall EElTreeError(System::PResStringRec ResStringRec)/* overload */ : System::Sysutils::Exception(ResStringRec) { }
	/* Exception.CreateResFmt */ inline __fastcall EElTreeError(NativeUInt Ident, const System::TVarRec *Args, const int Args_High)/* overload */ : System::Sysutils::Exception(Ident, Args, Args_High) { }
	/* Exception.CreateResFmt */ inline __fastcall EElTreeError(System::PResStringRec ResStringRec, const System::TVarRec *Args, const int Args_High)/* overload */ : System::Sysutils::Exception(ResStringRec, Args, Args_High) { }
	/* Exception.CreateHelp */ inline __fastcall EElTreeError(const System::UnicodeString Msg, int AHelpContext) : System::Sysutils::Exception(Msg, AHelpContext) { }
	/* Exception.CreateFmtHelp */ inline __fastcall EElTreeError(const System::UnicodeString Msg, const System::TVarRec *Args, const int Args_High, int AHelpContext) : System::Sysutils::Exception(Msg, Args, Args_High, AHelpContext) { }
	/* Exception.CreateResHelp */ inline __fastcall EElTreeError(NativeUInt Ident, int AHelpContext)/* overload */ : System::Sysutils::Exception(Ident, AHelpContext) { }
	/* Exception.CreateResHelp */ inline __fastcall EElTreeError(System::PResStringRec ResStringRec, int AHelpContext)/* overload */ : System::Sysutils::Exception(ResStringRec, AHelpContext) { }
	/* Exception.CreateResFmtHelp */ inline __fastcall EElTreeError(System::PResStringRec ResStringRec, const System::TVarRec *Args, const int Args_High, int AHelpContext)/* overload */ : System::Sysutils::Exception(ResStringRec, Args, Args_High, AHelpContext) { }
	/* Exception.CreateResFmtHelp */ inline __fastcall EElTreeError(NativeUInt Ident, const System::TVarRec *Args, const int Args_High, int AHelpContext)/* overload */ : System::Sysutils::Exception(Ident, Args, Args_High, AHelpContext) { }
	/* Exception.Destroy */ inline __fastcall virtual ~EElTreeError(void) { }
	
};

#pragma pack(pop)

enum DECLSPEC_DENUM TElVirtPropType : unsigned char { vptMainText, vptCellText, vptStyles, vptFontStyle, vptVisual, vptHTML, vptCheck, vptSelection, vptButtons, vptImages, vptColors, vptEdit, vptIndent };

typedef System::Set<TElVirtPropType, TElVirtPropType::vptMainText, TElVirtPropType::vptIndent> TElVirtPropTypes;

enum DECLSPEC_DENUM TDragTargetDraw : unsigned char { ColorFrame, ColorRect, SelColorRect, dtdNone, dtdUpColorLine, dtdDownColorLine, dtdUpSelColorLine, dtdDownSelColorLine };

typedef void __fastcall (__closure *TInplaceOperationEvent)(System::TObject* Sender, bool &DefaultConversion);

typedef void __fastcall (__closure *TInplaceAfterOperationEvent)(System::TObject* Sender, bool &Accepted, bool &DefaultConversion);

typedef void __fastcall (__closure *TInplaceValidationEvent)(System::TObject* Sender, bool &InputValid);

typedef void __fastcall (__closure *TInplaceOperationCompleteEvent)(TElTreeInplaceEditor* Editor, bool Accepted);

__interface IElTreeView  : public System::IInterface 
{
	virtual void __fastcall EditOperationAccepted(void) = 0 ;
	virtual void __fastcall EditOperationCancelled(void) = 0 ;
};

__interface IElTree  : public System::IInterface 
{
	virtual TElTreeInplaceManager* __fastcall GetEditorManager(void) = 0 ;
	virtual TElTreeViewAncestor* __fastcall GetView(void) = 0 ;
	__property TElTreeViewAncestor* View = {read=GetView};
};

class PASCALIMPLEMENTATION TElTreeViewAncestor : public Vcl::Controls::TCustomControl
{
	typedef Vcl::Controls::TCustomControl inherited;
	
protected:
	virtual void __fastcall EditOperationAccepted(void) = 0 ;
	virtual void __fastcall EditOperationCancelled(void) = 0 ;
public:
	/* TCustomControl.Create */ inline __fastcall virtual TElTreeViewAncestor(System::Classes::TComponent* AOwner) : Vcl::Controls::TCustomControl(AOwner) { }
	/* TCustomControl.Destroy */ inline __fastcall virtual ~TElTreeViewAncestor(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TElTreeViewAncestor(HWND ParentWindow) : Vcl::Controls::TCustomControl(ParentWindow) { }
	
};


class PASCALIMPLEMENTATION TElTreeAncestor : public Elxpthemedcontrol::TElXPThemedControl
{
	typedef Elxpthemedcontrol::TElXPThemedControl inherited;
	
protected:
	Vcl::Controls::TKeyEvent FOnEditKeyDown;
	bool FHorizontalLines;
	bool FVerticalLines;
	bool FExplorerEditMode;
	TElTreeInplaceManager* FEditorManager;
	virtual TElTreeViewAncestor* __fastcall GetTreeViewAncestor(void) = 0 ;
	virtual System::UnicodeString __fastcall GetAlignmentOnSection(int SectionIndex) = 0 ;
	
public:
	__property TElTreeViewAncestor* View = {read=GetTreeViewAncestor};
	__property TElTreeInplaceManager* EditorManager = {read=FEditorManager};
	__property Vcl::Controls::TKeyEvent OnEditKeyDown = {read=FOnEditKeyDown, write=FOnEditKeyDown};
public:
	/* TElXPThemedControl.Create */ inline __fastcall virtual TElTreeAncestor(System::Classes::TComponent* AOwner) : Elxpthemedcontrol::TElXPThemedControl(AOwner) { }
	/* TElXPThemedControl.Destroy */ inline __fastcall virtual ~TElTreeAncestor(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TElTreeAncestor(HWND ParentWindow) : Elxpthemedcontrol::TElXPThemedControl(ParentWindow) { }
	
};


class PASCALIMPLEMENTATION TElTreeInplaceManager : public Elcomponent::TElComponent
{
	typedef Elcomponent::TElComponent inherited;
	
protected:
	Lmdobjectlist::TLMDObjectList* FEditorsList;
	void __fastcall RegisterEditor(TElTreeInplaceEditor* Editor);
	void __fastcall UnregisterEditor(TElTreeInplaceEditor* Editor);
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation Operation);
	
public:
	__fastcall virtual TElTreeInplaceManager(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TElTreeInplaceManager(void);
	TElTreeInplaceEditor* __fastcall GetSuitableEditor(Elheader::TElFieldType SupposedFieldType);
};


class PASCALIMPLEMENTATION THackWinControl : public Vcl::Controls::TWinControl
{
	typedef Vcl::Controls::TWinControl inherited;
	
public:
	/* TWinControl.Create */ inline __fastcall virtual THackWinControl(System::Classes::TComponent* AOwner) : Vcl::Controls::TWinControl(AOwner) { }
	/* TWinControl.CreateParented */ inline __fastcall THackWinControl(HWND ParentWindow) : Vcl::Controls::TWinControl(ParentWindow) { }
	/* TWinControl.Destroy */ inline __fastcall virtual ~THackWinControl(void) { }
	
};


class PASCALIMPLEMENTATION TElTreeInplaceEditor : public Elcomponent::TElComponent
{
	typedef Elcomponent::TElComponent inherited;
	
private:
	void __fastcall SetCellRect(const System::Types::TRect &Value);
	void __fastcall SetDataType(const Elheader::TElFieldType Value);
	void __fastcall SetItem(System::Classes::TPersistent* const Value);
	void __fastcall SetSectionIndex(const int Value);
	void __fastcall SetValueAsText(const Lmdtypes::TLMDString Value);
	
protected:
	Vcl::Graphics::TFont* FFont;
	Vcl::Controls::TWinControl* FEditor;
	bool FExplorerEditMode;
	Lmdtypes::TLMDString FDefaultValueAsText;
	bool FEditing;
	TElTreeAncestor* FTree;
	Elheader::TElFieldTypes FTypes;
	System::Classes::TPersistent* FItem;
	Lmdtypes::TLMDString FValueAsText;
	int FSectionIndex;
	Elheader::TElFieldType FDataType;
	System::Types::TRect FCellRect;
	bool CanReFocus;
	TInplaceOperationEvent FOnBeforeOperation;
	TInplaceAfterOperationEvent FOnAfterOperation;
	TInplaceValidationEvent FOnValidateResult;
	bool FInputChecked;
	void __fastcall SetFont(Vcl::Graphics::TFont* Value);
	void __fastcall SetTree(TElTreeAncestor* Value);
	virtual bool __fastcall GetVisible(void) = 0 ;
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation Operation);
	virtual void __fastcall SetEditorParent(void);
	virtual void __fastcall TriggerBeforeOperation(bool &DefaultConversion);
	virtual void __fastcall TriggerAfterOperation(bool &Accepted, bool &DefaultConversion);
	virtual void __fastcall TriggerKeyDown(const Winapi::Messages::TWMKey &Message);
	virtual void __fastcall DoStartOperation(void);
	virtual void __fastcall DoStopOperation(bool Accepted);
	void __fastcall FontChange(System::TObject* Sender);
	void __fastcall EndEditWithInputChecked(void);
	virtual void __fastcall AdjustBounds(void);
	virtual void __fastcall AdjustBoundsRect(System::Types::TRect &r);
	bool __fastcall IsVistaUp(void);
	bool __fastcall HorizontalLines(void);
	bool __fastcall VerticalLines(void);
	
public:
	__fastcall virtual TElTreeInplaceEditor(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TElTreeInplaceEditor(void);
	virtual void __fastcall StartOperation(void);
	virtual void __fastcall CompleteOperation(bool Accepted);
	virtual void __fastcall TriggerValidateResult(bool &InputValid);
	__property Vcl::Graphics::TFont* Font = {read=FFont, write=SetFont, stored=true};
	__property System::Classes::TPersistent* Item = {read=FItem, write=SetItem};
	__property Lmdtypes::TLMDString ValueAsText = {read=FValueAsText, write=SetValueAsText};
	__property int SectionIndex = {read=FSectionIndex, write=SetSectionIndex, nodefault};
	__property Elheader::TElFieldType DataType = {read=FDataType, write=SetDataType, nodefault};
	__property System::Types::TRect CellRect = {read=FCellRect, write=SetCellRect};
	__property bool Visible = {read=GetVisible, nodefault};
	__property bool Editing = {read=FEditing, nodefault};
	__property bool InputChecked = {read=FInputChecked, write=FInputChecked, nodefault};
	
__published:
	__property TElTreeAncestor* Tree = {read=FTree, write=SetTree};
	__property Elheader::TElFieldTypes Types = {read=FTypes, write=FTypes, default=0};
	__property Lmdtypes::TLMDString DefaultValueAsText = {read=FDefaultValueAsText, write=FDefaultValueAsText};
	__property TInplaceOperationEvent OnBeforeOperation = {read=FOnBeforeOperation, write=FOnBeforeOperation};
	__property TInplaceAfterOperationEvent OnAfterOperation = {read=FOnAfterOperation, write=FOnAfterOperation};
	__property TInplaceValidationEvent OnValidateResult = {read=FOnValidateResult, write=FOnValidateResult};
};


//-- var, const, procedure ---------------------------------------------------
#define DefaultTreeOwnerDrawMask L"~~@~~"
#define AllVirtPropTypes (System::Set<TElVirtPropType, TElVirtPropType::vptMainText, TElVirtPropType::vptIndent>() << TElVirtPropType::vptMainText << TElVirtPropType::vptCellText << TElVirtPropType::vptStyles << TElVirtPropType::vptFontStyle << TElVirtPropType::vptVisual << TElVirtPropType::vptHTML << TElVirtPropType::vptCheck << TElVirtPropType::vptSelection << TElVirtPropType::vptButtons << TElVirtPropType::vptImages << TElVirtPropType::vptColors << TElVirtPropType::vptEdit << TElVirtPropType::vptIndent )
}	/* namespace Eltreeinplaceeditors */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_ELTREEINPLACEEDITORS)
using namespace Eltreeinplaceeditors;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// EltreeinplaceeditorsHPP
