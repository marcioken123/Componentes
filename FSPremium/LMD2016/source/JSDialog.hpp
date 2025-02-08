// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'JSDialog.pas' rev: 31.00 (Windows)

#ifndef JsdialogHPP
#define JsdialogHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <Vcl.ComCtrls.hpp>
#include <Winapi.Messages.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.Controls.hpp>
#include <System.SysUtils.hpp>
#include <System.Contnrs.hpp>
#include <Vcl.StdCtrls.hpp>
#include <System.Classes.hpp>
#include <JSRichEdit.hpp>
#include <JSLabel.hpp>
#include <JSProgressBar.hpp>
#include <JSCheckBox.hpp>
#include <Vcl.Forms.hpp>
#include <Vcl.ExtCtrls.hpp>
#include <Vcl.Buttons.hpp>
#include <JSDialogs.hpp>
#include <Vcl.GraphUtil.hpp>
#include <JSGraphUtil.hpp>
#include <Vcl.ImgList.hpp>
#include <System.Types.hpp>
#include <System.StrUtils.hpp>
#include <JSTypes.hpp>
#include <JSGraphics.hpp>
#include <JSButton.hpp>
#include <System.UITypes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Jsdialog
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS JSNoHelpFileException;
class DELPHICLASS EDialogSheet;
class DELPHICLASS TJSSizeComparer;
class DELPHICLASS TJSCustomButtonItem;
class DELPHICLASS TJSCustomButtons;
class DELPHICLASS TJSRadioButtonItem;
class DELPHICLASS TJSRadioButtons;
class DELPHICLASS TJSDialogOwnedPersistent;
class DELPHICLASS TJSTextSection;
class DELPHICLASS TJSButtonOptions;
class DELPHICLASS TJSProgress;
class DELPHICLASS TJSAnimate;
class DELPHICLASS TJSExpando;
class DELPHICLASS TJSHelpLink;
class DELPHICLASS TJSBaseOptions;
class DELPHICLASS TJSHeader;
class DELPHICLASS TJSFooter;
class DELPHICLASS TJSBorder;
class DELPHICLASS TJSInstruction;
class DELPHICLASS TJSButtonBarOptions;
class DELPHICLASS TJSVerification;
struct TJSDialogResult;
class DELPHICLASS TJSLocation;
class DELPHICLASS TJSTimer;
class DELPHICLASS TJSRadioButton;
class DELPHICLASS TJSSheetOptions;
class DELPHICLASS TJSCustomTaskDialogForm;
class DELPHICLASS TJSCustomDialog;
class DELPHICLASS TJSDialog;
class DELPHICLASS TJSTaskDialogForm;
//-- type declarations -------------------------------------------------------
#pragma pack(push,4)
class PASCALIMPLEMENTATION JSNoHelpFileException : public System::Sysutils::Exception
{
	typedef System::Sysutils::Exception inherited;
	
public:
	/* Exception.Create */ inline __fastcall JSNoHelpFileException(const System::UnicodeString Msg) : System::Sysutils::Exception(Msg) { }
	/* Exception.CreateFmt */ inline __fastcall JSNoHelpFileException(const System::UnicodeString Msg, const System::TVarRec *Args, const int Args_High) : System::Sysutils::Exception(Msg, Args, Args_High) { }
	/* Exception.CreateRes */ inline __fastcall JSNoHelpFileException(NativeUInt Ident)/* overload */ : System::Sysutils::Exception(Ident) { }
	/* Exception.CreateRes */ inline __fastcall JSNoHelpFileException(System::PResStringRec ResStringRec)/* overload */ : System::Sysutils::Exception(ResStringRec) { }
	/* Exception.CreateResFmt */ inline __fastcall JSNoHelpFileException(NativeUInt Ident, const System::TVarRec *Args, const int Args_High)/* overload */ : System::Sysutils::Exception(Ident, Args, Args_High) { }
	/* Exception.CreateResFmt */ inline __fastcall JSNoHelpFileException(System::PResStringRec ResStringRec, const System::TVarRec *Args, const int Args_High)/* overload */ : System::Sysutils::Exception(ResStringRec, Args, Args_High) { }
	/* Exception.CreateHelp */ inline __fastcall JSNoHelpFileException(const System::UnicodeString Msg, int AHelpContext) : System::Sysutils::Exception(Msg, AHelpContext) { }
	/* Exception.CreateFmtHelp */ inline __fastcall JSNoHelpFileException(const System::UnicodeString Msg, const System::TVarRec *Args, const int Args_High, int AHelpContext) : System::Sysutils::Exception(Msg, Args, Args_High, AHelpContext) { }
	/* Exception.CreateResHelp */ inline __fastcall JSNoHelpFileException(NativeUInt Ident, int AHelpContext)/* overload */ : System::Sysutils::Exception(Ident, AHelpContext) { }
	/* Exception.CreateResHelp */ inline __fastcall JSNoHelpFileException(System::PResStringRec ResStringRec, int AHelpContext)/* overload */ : System::Sysutils::Exception(ResStringRec, AHelpContext) { }
	/* Exception.CreateResFmtHelp */ inline __fastcall JSNoHelpFileException(System::PResStringRec ResStringRec, const System::TVarRec *Args, const int Args_High, int AHelpContext)/* overload */ : System::Sysutils::Exception(ResStringRec, Args, Args_High, AHelpContext) { }
	/* Exception.CreateResFmtHelp */ inline __fastcall JSNoHelpFileException(NativeUInt Ident, const System::TVarRec *Args, const int Args_High, int AHelpContext)/* overload */ : System::Sysutils::Exception(Ident, Args, Args_High, AHelpContext) { }
	/* Exception.Destroy */ inline __fastcall virtual ~JSNoHelpFileException(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION EDialogSheet : public System::Sysutils::Exception
{
	typedef System::Sysutils::Exception inherited;
	
public:
	/* Exception.Create */ inline __fastcall EDialogSheet(const System::UnicodeString Msg) : System::Sysutils::Exception(Msg) { }
	/* Exception.CreateFmt */ inline __fastcall EDialogSheet(const System::UnicodeString Msg, const System::TVarRec *Args, const int Args_High) : System::Sysutils::Exception(Msg, Args, Args_High) { }
	/* Exception.CreateRes */ inline __fastcall EDialogSheet(NativeUInt Ident)/* overload */ : System::Sysutils::Exception(Ident) { }
	/* Exception.CreateRes */ inline __fastcall EDialogSheet(System::PResStringRec ResStringRec)/* overload */ : System::Sysutils::Exception(ResStringRec) { }
	/* Exception.CreateResFmt */ inline __fastcall EDialogSheet(NativeUInt Ident, const System::TVarRec *Args, const int Args_High)/* overload */ : System::Sysutils::Exception(Ident, Args, Args_High) { }
	/* Exception.CreateResFmt */ inline __fastcall EDialogSheet(System::PResStringRec ResStringRec, const System::TVarRec *Args, const int Args_High)/* overload */ : System::Sysutils::Exception(ResStringRec, Args, Args_High) { }
	/* Exception.CreateHelp */ inline __fastcall EDialogSheet(const System::UnicodeString Msg, int AHelpContext) : System::Sysutils::Exception(Msg, AHelpContext) { }
	/* Exception.CreateFmtHelp */ inline __fastcall EDialogSheet(const System::UnicodeString Msg, const System::TVarRec *Args, const int Args_High, int AHelpContext) : System::Sysutils::Exception(Msg, Args, Args_High, AHelpContext) { }
	/* Exception.CreateResHelp */ inline __fastcall EDialogSheet(NativeUInt Ident, int AHelpContext)/* overload */ : System::Sysutils::Exception(Ident, AHelpContext) { }
	/* Exception.CreateResHelp */ inline __fastcall EDialogSheet(System::PResStringRec ResStringRec, int AHelpContext)/* overload */ : System::Sysutils::Exception(ResStringRec, AHelpContext) { }
	/* Exception.CreateResFmtHelp */ inline __fastcall EDialogSheet(System::PResStringRec ResStringRec, const System::TVarRec *Args, const int Args_High, int AHelpContext)/* overload */ : System::Sysutils::Exception(ResStringRec, Args, Args_High, AHelpContext) { }
	/* Exception.CreateResFmtHelp */ inline __fastcall EDialogSheet(NativeUInt Ident, const System::TVarRec *Args, const int Args_High, int AHelpContext)/* overload */ : System::Sysutils::Exception(Ident, Args, Args_High, AHelpContext) { }
	/* Exception.Destroy */ inline __fastcall virtual ~EDialogSheet(void) { }
	
};

#pragma pack(pop)

enum DECLSPEC_DENUM TJSFontType : unsigned char { ftContent, ftInstruction, ftHeader, ftFooter, ftExpando };

enum DECLSPEC_DENUM TJSDialogHitTest : unsigned char { htNone, htHeader, htHeaderImage, htInstruction, htInstructionImage, htContent, htMainIcon, htButtonBar, htExpandedSection, htFooter, htFooterImage };

enum DECLSPEC_DENUM TPaintStage : unsigned char { psGlyph, psInstruction, psContent, psMoreLines, psRadio, psCommand, psHeader, psFooter, psMoreFooter, psButtonBar, psHelpLink, psProgressBar, psInstructBounds };

enum DECLSPEC_DENUM TControlType : unsigned char { ctButton, ctCommandLink, ctCheckBox, ctMoreButton, ctRichEdit, ctLinkLabel, ctURLLabel, ctRadioButton, ctProgressBar, ctRadioGroup, ctMaxLines };

#pragma pack(push,4)
class PASCALIMPLEMENTATION TJSSizeComparer : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	int FWidth;
	int FHeight;
	
public:
	__fastcall TJSSizeComparer(const int aWidth, const int aHeight);
	bool __fastcall IsEqual(const int aWidth, const int aHeight);
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TJSSizeComparer(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TJSCustomButtonItem : public System::Classes::TCollectionItem
{
	typedef System::Classes::TCollectionItem inherited;
	
private:
	System::UnicodeString FCaption;
	int FValue;
	TJSCustomButtons* FOwner;
	Vcl::Graphics::TPicture* FGlyph;
	int FImageIndex;
	System::Uitypes::TModalResult FModalResult;
	bool FDefault;
	System::UnicodeString FHint;
	bool FCancel;
	System::Classes::TStrings* FInfo;
	bool FElevationRequired;
	Vcl::Graphics::TPicture* FPicture;
	bool FEnabled;
	int FPictureIndex;
	bool FVisible;
	void __fastcall SetCaption(const System::UnicodeString Value);
	void __fastcall SetGlyph(Vcl::Graphics::TPicture* const Value);
	void __fastcall SetHint(const System::UnicodeString Value);
	void __fastcall SetInfo(System::Classes::TStrings* const Value);
	void __fastcall SetPicture(Vcl::Graphics::TPicture* const Value);
	void __fastcall SetValue(const int Value);
	void __fastcall SetEnabled(const bool Value);
	void __fastcall SetVisible(const bool Value);
	
protected:
	DYNAMIC System::Classes::TPersistent* __fastcall GetOwner(void);
	virtual System::UnicodeString __fastcall GetDisplayName(void);
	
public:
	__fastcall virtual TJSCustomButtonItem(System::Classes::TCollection* Collection);
	__fastcall virtual ~TJSCustomButtonItem(void);
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	
__published:
	__property bool ElevationRequired = {read=FElevationRequired, write=FElevationRequired, default=0};
	__property System::UnicodeString Caption = {read=FCaption, write=SetCaption};
	__property Vcl::Graphics::TPicture* Glyph = {read=FGlyph, write=SetGlyph};
	__property int ImageIndex = {read=FImageIndex, write=FImageIndex, default=-1};
	__property int Value = {read=FValue, write=SetValue, nodefault};
	__property System::Uitypes::TModalResult ModalResult = {read=FModalResult, write=FModalResult, default=0};
	__property bool Default = {read=FDefault, write=FDefault, default=0};
	__property bool Cancel = {read=FCancel, write=FCancel, default=0};
	__property System::UnicodeString Hint = {read=FHint, write=SetHint};
	__property System::Classes::TStrings* Info = {read=FInfo, write=SetInfo};
	__property Vcl::Graphics::TPicture* Picture = {read=FPicture, write=SetPicture};
	__property int PictureIndex = {read=FPictureIndex, write=FPictureIndex, default=-1};
	__property bool Enabled = {read=FEnabled, write=SetEnabled, default=1};
	__property bool Visible = {read=FVisible, write=SetVisible, default=1};
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TJSCustomButtons : public System::Classes::TOwnedCollection
{
	typedef System::Classes::TOwnedCollection inherited;
	
public:
	TJSCustomButtonItem* operator[](int Index) { return this->Items[Index]; }
	
private:
	Vcl::Imglist::TCustomImageList* FImages;
	Vcl::Imglist::TCustomImageList* FPictureImages;
	TJSCustomDialog* __fastcall GetMessagePanel(void);
	HIDESBASE TJSCustomButtonItem* __fastcall GetItem(int Index);
	HIDESBASE void __fastcall SetItem(int Index, TJSCustomButtonItem* const Value);
	void __fastcall SetImages(Vcl::Imglist::TCustomImageList* const Value);
	void __fastcall SetPictureImages(Vcl::Imglist::TCustomImageList* const Value);
	int __fastcall GetVisibleCount(void);
	
protected:
	virtual void __fastcall Notify(System::Classes::TCollectionItem* Item, System::Classes::TCollectionNotification Action);
	
public:
	__fastcall TJSCustomButtons(System::Classes::TPersistent* AOwner, System::Classes::TCollectionItemClass ItemClass);
	__fastcall virtual ~TJSCustomButtons(void);
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	__property TJSCustomDialog* MessagePanel = {read=GetMessagePanel};
	HIDESBASE TJSCustomButtonItem* __fastcall Add(void);
	int __fastcall GetModalResult(const int aValue);
	__property TJSCustomButtonItem* Items[int Index] = {read=GetItem, write=SetItem/*, default*/};
	__property int VisibleCount = {read=GetVisibleCount, nodefault};
	
__published:
	__property Vcl::Imglist::TCustomImageList* Images = {read=FImages, write=SetImages};
	__property Vcl::Imglist::TCustomImageList* PictureImages = {read=FPictureImages, write=SetPictureImages};
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TJSRadioButtonItem : public System::Classes::TCollectionItem
{
	typedef System::Classes::TCollectionItem inherited;
	
private:
	System::UnicodeString FCaption;
	int FValue;
	bool FChecked;
	bool FEnabled;
	void __fastcall SetCaption(const System::UnicodeString Value);
	bool __fastcall CanUpdateControls(/* out */ TJSCustomDialog* &ADialog);
	
protected:
	virtual System::UnicodeString __fastcall GetDisplayName(void);
	
public:
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	__fastcall virtual TJSRadioButtonItem(System::Classes::TCollection* Collection);
	
__published:
	__property System::UnicodeString Caption = {read=FCaption, write=SetCaption};
	__property bool Checked = {read=FChecked, write=FChecked, default=0};
	__property bool Enabled = {read=FEnabled, write=FEnabled, default=1};
	__property int Value = {read=FValue, write=FValue, nodefault};
public:
	/* TCollectionItem.Destroy */ inline __fastcall virtual ~TJSRadioButtonItem(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TJSRadioButtons : public System::Classes::TOwnedCollection
{
	typedef System::Classes::TOwnedCollection inherited;
	
public:
	TJSRadioButtonItem* operator[](int Index) { return this->Items[Index]; }
	
private:
	TJSCustomDialog* __fastcall GetMessagePanel(void);
	HIDESBASE TJSRadioButtonItem* __fastcall GetItem(int Index);
	HIDESBASE void __fastcall SetItem(int Index, TJSRadioButtonItem* const Value);
	
protected:
	virtual void __fastcall Notify(System::Classes::TCollectionItem* Item, System::Classes::TCollectionNotification Action);
	
public:
	__property TJSCustomDialog* MessagePanel = {read=GetMessagePanel};
	HIDESBASE TJSRadioButtonItem* __fastcall Add(void);
	TJSRadioButtonItem* __fastcall ItemWithValue(const int AValue);
	void __fastcall SetEnabled(const int AValue, const bool AEnabled);
	__property TJSRadioButtonItem* Items[int Index] = {read=GetItem, write=SetItem/*, default*/};
public:
	/* TOwnedCollection.Create */ inline __fastcall TJSRadioButtons(System::Classes::TPersistent* AOwner, System::Classes::TCollectionItemClass ItemClass) : System::Classes::TOwnedCollection(AOwner, ItemClass) { }
	
public:
	/* TCollection.Destroy */ inline __fastcall virtual ~TJSRadioButtons(void) { }
	
};

#pragma pack(pop)

class PASCALIMPLEMENTATION TJSDialogOwnedPersistent : public Jstypes::TJSChangePersistent
{
	typedef Jstypes::TJSChangePersistent inherited;
	
private:
	TJSCustomDialog* FDialog;
	
protected:
	__property TJSCustomDialog* Dialog = {read=FDialog};
	
public:
	__fastcall virtual TJSDialogOwnedPersistent(TJSCustomDialog* ADialog);
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TJSDialogOwnedPersistent(void) { }
	
};


class PASCALIMPLEMENTATION TJSTextSection : public TJSDialogOwnedPersistent
{
	typedef TJSDialogOwnedPersistent inherited;
	
public:
	/* TJSDialogOwnedPersistent.Create */ inline __fastcall virtual TJSTextSection(TJSCustomDialog* ADialog) : TJSDialogOwnedPersistent(ADialog) { }
	
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TJSTextSection(void) { }
	
};


class PASCALIMPLEMENTATION TJSButtonOptions : public TJSDialogOwnedPersistent
{
	typedef TJSDialogOwnedPersistent inherited;
	
private:
	Jsbutton::TJSCommandLinkColors* FCommandLinkColors;
	void __fastcall SetCommandLinkColors(Jsbutton::TJSCommandLinkColors* const Value);
	
public:
	__fastcall virtual TJSButtonOptions(TJSCustomDialog* ADialog);
	__fastcall virtual ~TJSButtonOptions(void);
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	
__published:
	__property Jsbutton::TJSCommandLinkColors* CommandLinkColors = {read=FCommandLinkColors, write=SetCommandLinkColors};
};


class PASCALIMPLEMENTATION TJSProgress : public TJSDialogOwnedPersistent
{
	typedef TJSDialogOwnedPersistent inherited;
	
private:
	int FMax;
	int FMin;
	int FStep;
	int FPosition;
	Jsprogressbar::TProgressBarState FState;
	unsigned FInterval;
	bool FUseNativeProgressbar;
	bool FShowOnTaskBar;
	void __fastcall SetInterval(const unsigned Value);
	void __fastcall SetMax(const int Value);
	void __fastcall SetPosition(const int Value);
	void __fastcall SetState(const Jsprogressbar::TProgressBarState Value);
	void __fastcall SetStep(const int Value);
	void __fastcall SetUseNativeProgressBar(const bool Value);
	void __fastcall SetShowOnTaskBar(const bool Value);
	
public:
	__fastcall virtual TJSProgress(TJSCustomDialog* ADialog);
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	
__published:
	__property unsigned Interval = {read=FInterval, write=SetInterval, default=100};
	__property int Max = {read=FMax, write=SetMax, default=100};
	__property int Min = {read=FMin, write=FMin, default=0};
	__property int Step = {read=FStep, write=SetStep, default=1};
	__property int Position = {read=FPosition, write=SetPosition, default=0};
	__property bool ShowOnTaskBar = {read=FShowOnTaskBar, write=SetShowOnTaskBar, default=0};
	__property Jsprogressbar::TProgressBarState State = {read=FState, write=SetState, default=0};
	__property bool UseNativeProgressBar = {read=FUseNativeProgressbar, write=SetUseNativeProgressBar, default=1};
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TJSProgress(void) { }
	
};


typedef void __fastcall (__closure *TUpdateProgressBarStateEvent)(System::TObject* Sender, Vcl::Controls::TControl* Control, const Jsprogressbar::TProgressBarState State);

typedef void __fastcall (__closure *TUpdateProgressBarEvent)(System::TObject* Sender, Vcl::Controls::TControl* Control, const int Position, bool &CloseDialog);

typedef void __fastcall (__closure *TProgressEvent)(System::TObject* Sender, const int Position);

typedef void __fastcall (__closure *TGetMoreFileNameEvent)(System::TObject* Sender, System::UnicodeString &FileName);

typedef void __fastcall (__closure *TTimerEvent)(System::TObject* Sender, const unsigned TimeSince);

enum DECLSPEC_DENUM TMoreFormat : unsigned char { mfText, mfRTF };

enum DECLSPEC_DENUM TMoreSource : unsigned char { msDefault, msStream, msFile };

typedef System::Int8 TJSSpeedRange;

typedef System::Int8 TJSStepRange;

#pragma pack(push,4)
class PASCALIMPLEMENTATION TJSAnimate : public System::Classes::TPersistent
{
	typedef System::Classes::TPersistent inherited;
	
private:
	bool FEnabled;
	TJSStepRange FStep;
	TJSSpeedRange FSpeed;
	
public:
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	__fastcall TJSAnimate(void);
	
__published:
	__property bool Enabled = {read=FEnabled, write=FEnabled, default=0};
	__property TJSSpeedRange Speed = {read=FSpeed, write=FSpeed, default=10};
	__property TJSStepRange Step = {read=FStep, write=FStep, default=2};
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TJSAnimate(void) { }
	
};

#pragma pack(pop)

class PASCALIMPLEMENTATION TJSExpando : public TJSTextSection
{
	typedef TJSTextSection inherited;
	
private:
	Vcl::Graphics::TFont* FFont;
	System::Classes::TStrings* FLines;
	bool FVisible;
	bool FShowMore;
	System::UnicodeString FShowText;
	System::UnicodeString FHideText;
	bool FShowInFooter;
	int FMoreHeight;
	TMoreFormat FMoreFormat;
	System::Uitypes::TScrollStyle FMoreScrollbars;
	TMoreSource FMoreSource;
	bool FShowing;
	TJSAnimate* FAnimate;
	void __fastcall SetFont(Vcl::Graphics::TFont* const Value);
	void __fastcall SetLines(System::Classes::TStrings* const Value);
	void __fastcall SetVisible(const bool Value);
	void __fastcall SetHideText(const System::UnicodeString Value);
	void __fastcall SetShowText(const System::UnicodeString Value);
	void __fastcall SetShowInFooter(const bool Value);
	void __fastcall SetMoreHeight(const int Value);
	void __fastcall SetShowing(const bool Value);
	bool __fastcall IsFontStored(void);
	void __fastcall LinesChangedHandler(System::TObject* Sender);
	void __fastcall SetAnimate(TJSAnimate* const Value);
	
public:
	__fastcall virtual TJSExpando(TJSCustomDialog* ADialog);
	__fastcall virtual ~TJSExpando(void);
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	
__published:
	__property TJSAnimate* Animate = {read=FAnimate, write=SetAnimate};
	__property System::Classes::TStrings* Lines = {read=FLines, write=SetLines};
	__property Vcl::Graphics::TFont* Font = {read=FFont, write=SetFont, stored=IsFontStored};
	__property bool Showing = {read=FShowing, write=SetShowing, default=0};
	__property bool ShowInFooter = {read=FShowInFooter, write=SetShowInFooter, default=0};
	__property int MoreHeight = {read=FMoreHeight, write=SetMoreHeight, default=0};
	__property TMoreFormat MoreFormat = {read=FMoreFormat, write=FMoreFormat, default=0};
	__property System::Uitypes::TScrollStyle MoreScrollbars = {read=FMoreScrollbars, write=FMoreScrollbars, default=3};
	__property TMoreSource MoreSource = {read=FMoreSource, write=FMoreSource, default=0};
	__property bool Visible = {read=FVisible, write=SetVisible, default=0};
	__property System::UnicodeString ShowText = {read=FShowText, write=SetShowText};
	__property System::UnicodeString HideText = {read=FHideText, write=SetHideText};
};


typedef void __fastcall (__closure *THelpLinkClickEvent)(System::TObject* Sender, bool &Handled);

class PASCALIMPLEMENTATION TJSHelpLink : public TJSDialogOwnedPersistent
{
	typedef TJSDialogOwnedPersistent inherited;
	
private:
	System::Classes::THelpType FHelpType;
	System::UnicodeString FHelpKeyword;
	System::Classes::THelpContext FHelpContext;
	System::UnicodeString FText;
	Vcl::Graphics::TFont* FFont;
	void __fastcall SetText(const System::UnicodeString Value);
	void __fastcall SetFont(Vcl::Graphics::TFont* const Value);
	bool __fastcall IsFontStored(void);
	
public:
	__fastcall virtual TJSHelpLink(TJSCustomDialog* ADialog);
	__fastcall virtual ~TJSHelpLink(void);
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	
__published:
	__property Vcl::Graphics::TFont* Font = {read=FFont, write=SetFont, stored=IsFontStored};
	__property System::Classes::THelpContext HelpContext = {read=FHelpContext, write=FHelpContext, default=0};
	__property System::Classes::THelpType HelpType = {read=FHelpType, write=FHelpType, default=1};
	__property System::UnicodeString HelpKeyword = {read=FHelpKeyword, write=FHelpKeyword};
	__property System::UnicodeString Text = {read=FText, write=SetText};
};


enum DECLSPEC_DENUM TJSImageAlignment : unsigned char { jsImageAlignLeft, jsImageAlignRight };

class PASCALIMPLEMENTATION TJSBaseOptions : public TJSDialogOwnedPersistent
{
	typedef TJSDialogOwnedPersistent inherited;
	
private:
	bool FVisible;
	System::UnicodeString FText;
	Vcl::Graphics::TPicture* FGlyph;
	Jsdialogs::TTaskDialogIcon FIcon;
	Vcl::Graphics::TFont* FFont;
	System::Uitypes::TColor FColor;
	TJSImageAlignment FImageAlignment;
	void __fastcall SetText(const System::UnicodeString Value);
	void __fastcall SetVisible(const bool Value);
	void __fastcall SetGlyph(Vcl::Graphics::TPicture* const Value);
	void __fastcall SetIcon(const Jsdialogs::TTaskDialogIcon Value);
	void __fastcall SetFont(Vcl::Graphics::TFont* const Value);
	bool __fastcall IsFontStored(void);
	
protected:
	virtual bool __fastcall FontModified(void);
	
public:
	__fastcall virtual TJSBaseOptions(TJSCustomDialog* ADialog);
	__fastcall virtual ~TJSBaseOptions(void);
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	
__published:
	__property System::Uitypes::TColor Color = {read=FColor, write=FColor, nodefault};
	__property System::UnicodeString Text = {read=FText, write=SetText};
	__property Vcl::Graphics::TPicture* Glyph = {read=FGlyph, write=SetGlyph};
	__property Vcl::Graphics::TFont* Font = {read=FFont, write=SetFont, stored=IsFontStored};
	__property Jsdialogs::TTaskDialogIcon Icon = {read=FIcon, write=SetIcon, default=0};
	__property bool Visible = {read=FVisible, write=SetVisible, default=0};
	__property TJSImageAlignment ImageAlignment = {read=FImageAlignment, write=FImageAlignment, default=0};
};


enum DECLSPEC_DENUM TJSIconSize : unsigned char { isSmall, isMedium, isLarge };

class PASCALIMPLEMENTATION TJSHeader : public TJSBaseOptions
{
	typedef TJSBaseOptions inherited;
	
private:
	TJSIconSize FIconSize;
	Jstypes::TJSGradient* FGradient;
	void __fastcall SetGradient(Jstypes::TJSGradient* const Value);
	
protected:
	virtual bool __fastcall FontModified(void);
	
public:
	__fastcall virtual TJSHeader(TJSCustomDialog* ADialog);
	__fastcall virtual ~TJSHeader(void);
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	
__published:
	__property Color = {default=-16777211};
	__property Jstypes::TJSGradient* Gradient = {read=FGradient, write=SetGradient};
	__property TJSIconSize IconSize = {read=FIconSize, write=FIconSize, default=2};
};


class PASCALIMPLEMENTATION TJSFooter : public TJSBaseOptions
{
	typedef TJSBaseOptions inherited;
	
public:
	__fastcall virtual TJSFooter(TJSCustomDialog* ADialog);
	
__published:
	__property Color = {default=-16777201};
public:
	/* TJSBaseOptions.Destroy */ inline __fastcall virtual ~TJSFooter(void) { }
	
};


class PASCALIMPLEMENTATION TJSBorder : public TJSDialogOwnedPersistent
{
	typedef TJSDialogOwnedPersistent inherited;
	
private:
	int FWidth;
	System::Uitypes::TColor FColor;
	bool FVisible;
	
public:
	__fastcall virtual TJSBorder(TJSCustomDialog* ADialog);
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	
__published:
	__property System::Uitypes::TColor Color = {read=FColor, write=FColor, default=8421504};
	__property int Width = {read=FWidth, write=FWidth, default=1};
	__property bool Visible = {read=FVisible, write=FVisible, default=0};
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TJSBorder(void) { }
	
};


class PASCALIMPLEMENTATION TJSInstruction : public TJSTextSection
{
	typedef TJSTextSection inherited;
	
private:
	Vcl::Graphics::TFont* FFont;
	System::WideString FText;
	bool FShowAtTop;
	bool FShowGlyph;
	Vcl::Graphics::TPicture* FGlyph;
	Jsdialogs::TTaskDialogIcon FIcon;
	System::Uitypes::TColor FColor;
	void __fastcall SetFont(Vcl::Graphics::TFont* const Value);
	void __fastcall SetShowAtTop(const bool Value);
	void __fastcall SetText(const System::WideString Value);
	void __fastcall SetGlyph(Vcl::Graphics::TPicture* const Value);
	void __fastcall SetShowGlyph(const bool Value);
	void __fastcall SetIcon(const Jsdialogs::TTaskDialogIcon Value);
	bool __fastcall IsFontStored(void);
	void __fastcall SetColor(const System::Uitypes::TColor Value);
	
public:
	__fastcall virtual TJSInstruction(TJSCustomDialog* ADialog);
	__fastcall virtual ~TJSInstruction(void);
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	int __fastcall GlyphHeight(void);
	int __fastcall GlyphWidth(void);
	bool __fastcall HasCustomGlyph(void);
	bool __fastcall HasGlyph(void);
	bool __fastcall GlyphAvailable(void);
	
__published:
	__property System::Uitypes::TColor Color = {read=FColor, write=SetColor, default=536870911};
	__property Vcl::Graphics::TFont* Font = {read=FFont, write=SetFont, stored=IsFontStored};
	__property System::WideString Text = {read=FText, write=SetText};
	__property bool ShowAtTop = {read=FShowAtTop, write=SetShowAtTop, default=0};
	__property Vcl::Graphics::TPicture* Glyph = {read=FGlyph, write=SetGlyph};
	__property Jsdialogs::TTaskDialogIcon Icon = {read=FIcon, write=SetIcon, default=0};
	__property bool ShowGlyph = {read=FShowGlyph, write=SetShowGlyph, default=0};
};


class PASCALIMPLEMENTATION TJSButtonBarOptions : public TJSDialogOwnedPersistent
{
	typedef TJSDialogOwnedPersistent inherited;
	
private:
	Jsdialogs::TCommonButtons FButtons;
	bool FVisible;
	System::Uitypes::TColor FColor;
	Jsdialogs::TCommonButton FCancel;
	Jsdialogs::TCommonButton FDefault;
	bool FShowDivider;
	bool FUseCancel;
	bool FUseDefault;
	void __fastcall SetButtons(const Jsdialogs::TCommonButtons Value);
	void __fastcall SetVisible(const bool Value);
	void __fastcall SetColor(const System::Uitypes::TColor Value);
	void __fastcall SetCancel(const Jsdialogs::TCommonButton Value);
	void __fastcall SetDefault(const Jsdialogs::TCommonButton Value);
	bool __fastcall IsColorStored(void);
	
public:
	__fastcall virtual TJSButtonBarOptions(TJSCustomDialog* ADialog);
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	void __fastcall DetermineDefaults(void);
	
__published:
	__property Jsdialogs::TCommonButtons Buttons = {read=FButtons, write=SetButtons, default=12};
	__property System::Uitypes::TColor Color = {read=FColor, write=SetColor, stored=IsColorStored, default=-16777201};
	__property bool Visible = {read=FVisible, write=SetVisible, default=1};
	__property Jsdialogs::TCommonButton Default = {read=FDefault, write=SetDefault, default=2};
	__property Jsdialogs::TCommonButton Cancel = {read=FCancel, write=SetCancel, default=3};
	__property bool ShowDivider = {read=FShowDivider, write=FShowDivider, default=1};
	__property bool UseDefault = {read=FUseDefault, write=FUseDefault, default=1};
	__property bool UseCancel = {read=FUseCancel, write=FUseCancel, default=1};
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TJSButtonBarOptions(void) { }
	
};


class PASCALIMPLEMENTATION TJSVerification : public TJSDialogOwnedPersistent
{
	typedef TJSDialogOwnedPersistent inherited;
	
private:
	bool FVisible;
	System::UnicodeString FText;
	bool FInitialState;
	void __fastcall SetText(const System::UnicodeString Value);
	void __fastcall SetVisible(const bool Value);
	
public:
	__fastcall virtual TJSVerification(TJSCustomDialog* ADialog);
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	
__published:
	__property bool InitialState = {read=FInitialState, write=FInitialState, default=0};
	__property System::UnicodeString Text = {read=FText, write=SetText};
	__property bool Visible = {read=FVisible, write=SetVisible, default=0};
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TJSVerification(void) { }
	
};


typedef System::TMetaClass* TButtonClass;

typedef void __fastcall (__closure *TGetControlClassEvent)(System::TObject* Sender, TControlType ControlType, Vcl::Controls::TControlClass &ControlClass);

typedef void __fastcall (__closure *TInitControlEvent)(System::TObject* Sender, TControlType ControlType, Vcl::Controls::TControl* Control, System::Classes::TCollectionItem* ControlItem, bool &Handled);

typedef void __fastcall (__closure *TGetMoreStreamEvent)(System::TObject* Sender, System::Classes::TMemoryStream* &Stream);

typedef void __fastcall (__closure *TControlClickEvent)(System::TObject* Sender, TControlType ControlType, Vcl::Controls::TControl* Control, const int Value, bool &Handled);

typedef void __fastcall (__closure *TGetVerificationResult)(System::TObject* Sender, Vcl::Controls::TControl* Control, bool &VerificationResult);

typedef void __fastcall (__closure *TGetRadioButtonChecked)(System::TObject* Sender, Vcl::Controls::TControl* Control, bool &Checked, bool &Handled);

typedef void __fastcall (__closure *TDialogCloseEvent)(TJSCustomDialog* Sender);

typedef void __fastcall (__closure *TDialogClickEvent)(System::TObject* Sender, TJSDialogHitTest HitTest);

typedef void __fastcall (__closure *THelpButtonClickEvent)(System::TObject* Sender, bool &Handled);

typedef void __fastcall (__closure *TGetCustomSoundEvent)(System::TObject* Sender, System::UnicodeString &Sound, unsigned &Flags, bool &Handled);

typedef void __fastcall (__closure *TVerificationClickEvent)(System::TObject* Sender, const bool Checked);

enum DECLSPEC_DENUM TDialogOption : unsigned char { doShowHelpLink, doRadioButtons, doCommandLinks, doCommandLinksNoIcon, doProgressBar, doProgressBarMarquee, doTimer, doTopMost, doModal };

typedef System::Set<TDialogOption, TDialogOption::doShowHelpLink, TDialogOption::doModal> TDialogOptions;

enum DECLSPEC_DENUM TJSDialogStyle : unsigned char { dsDialog, dsSheet };

struct DECLSPEC_DRECORD TJSDialogResult
{
public:
	System::Uitypes::TModalResult ModalResult;
	bool VerificationResult;
	int RadioResult;
	int CustomButtonResult;
};


#pragma pack(push,4)
class PASCALIMPLEMENTATION TJSLocation : public System::Classes::TPersistent
{
	typedef System::Classes::TPersistent inherited;
	
private:
	int FTop;
	int FLeft;
	
public:
	__fastcall TJSLocation(void);
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	
__published:
	__property int Left = {read=FLeft, write=FLeft, default=-1};
	__property int Top = {read=FTop, write=FTop, default=-1};
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TJSLocation(void) { }
	
};

#pragma pack(pop)

class PASCALIMPLEMENTATION TJSTimer : public TJSDialogOwnedPersistent
{
	typedef TJSDialogOwnedPersistent inherited;
	
private:
	unsigned FInterval;
	
public:
	__fastcall virtual TJSTimer(TJSCustomDialog* ADialog);
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	
__published:
	__property unsigned Interval = {read=FInterval, write=FInterval, default=1000};
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TJSTimer(void) { }
	
};


class PASCALIMPLEMENTATION TJSRadioButton : public TJSDialogOwnedPersistent
{
	typedef TJSDialogOwnedPersistent inherited;
	
private:
	bool FShowBorder;
	System::WideString FCaption;
	int FColumns;
	
public:
	__fastcall virtual TJSRadioButton(TJSCustomDialog* ADialog);
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	
__published:
	__property int Columns = {read=FColumns, write=FColumns, default=1};
	__property bool ShowBorder = {read=FShowBorder, write=FShowBorder, default=0};
	__property System::WideString Caption = {read=FCaption, write=FCaption};
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TJSRadioButton(void) { }
	
};


enum DECLSPEC_DENUM TJSSheetLocation : unsigned char { slActiveForm, slDesktop };

class PASCALIMPLEMENTATION TJSSheetOptions : public TJSDialogOwnedPersistent
{
	typedef TJSDialogOwnedPersistent inherited;
	
private:
	unsigned FInterval;
	TJSSheetLocation FStyle;
	void __fastcall SetInterval(const unsigned Value);
	void __fastcall SetStyle(const TJSSheetLocation Value);
	
public:
	__fastcall virtual TJSSheetOptions(TJSCustomDialog* ADialog);
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	
__published:
	__property TJSSheetLocation Location = {read=FStyle, write=SetStyle, default=0};
	__property unsigned Interval = {read=FInterval, write=SetInterval, default=500};
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TJSSheetOptions(void) { }
	
};


enum DECLSPEC_DENUM TJSDialogState : unsigned char { dsNormal, dsPreview };

typedef System::Set<TJSDialogState, TJSDialogState::dsNormal, TJSDialogState::dsPreview> TJSDialogStates;

class PASCALIMPLEMENTATION TJSCustomTaskDialogForm : public Vcl::Forms::TForm
{
	typedef Vcl::Forms::TForm inherited;
	
public:
	/* TCustomForm.Create */ inline __fastcall virtual TJSCustomTaskDialogForm(System::Classes::TComponent* AOwner) : Vcl::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TJSCustomTaskDialogForm(System::Classes::TComponent* AOwner, int Dummy) : Vcl::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TJSCustomTaskDialogForm(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TJSCustomTaskDialogForm(HWND ParentWindow) : Vcl::Forms::TForm(ParentWindow) { }
	
};


class PASCALIMPLEMENTATION TJSCustomDialog : public System::Classes::TComponent
{
	typedef System::Classes::TComponent inherited;
	
private:
	TJSDialogStates FDialogState;
	System::Classes::TStrings* FContent;
	Vcl::Graphics::TPicture* FGlyph;
	int FLeftMargin;
	int FRightMargin;
	int FVertMargin;
	int FVertSpacing;
	int FHorzSpacing;
	int FButtonSpacing;
	TJSExpando* FExpando;
	TJSRadioButtons* FRadioButtons;
	TJSCustomButtons* FCustomButtons;
	System::Contnrs::TObjectList* FCreatedRadioButtons;
	Vcl::Controls::TControl* FRadioGroup;
	System::Contnrs::TObjectList* FCreatedCustomButtons;
	System::Contnrs::TObjectList* FCreatedButtonBarButtons;
	TJSButtonBarOptions* FButtonBar;
	int FButtonBarHeight;
	TJSInstruction* FInstruction;
	TJSVerification* FVerification;
	System::UnicodeString FText;
	Vcl::Controls::TControl* FVerificationCheckBox;
	Jslabel::TJSMoreLabel* FShowMoreButton;
	int FRadioResult;
	bool FVerificationResult;
	TJSFooter* FFooter;
	TJSHeader* FHeader;
	Jsrichedit::TJSRichEdit* FMoreRichEdit;
	TGetMoreFileNameEvent FOnGetMoreFileName;
	System::Uitypes::TModalResult FModalResult;
	Jsgraphics::TJSCaptionControl* FFooterLabel;
	Jsdialogs::TTaskDialogIcon FMainIcon;
	TInitControlEvent FOnInitControl;
	TGetControlClassEvent FOnGetControlClass;
	TGetMoreStreamEvent FOnGetMoreStream;
	TDialogOptions FDialogOptions;
	TJSDialogStyle FDialogStyle;
	Jsgraphics::TJSCaptionControl* FHelpLinkLabel;
	THelpLinkClickEvent FOnHelpLinkClick;
	TJSHelpLink* FHelpLink;
	TControlClickEvent FOnControlClick;
	int FCustomButtonResult;
	Vcl::Controls::TWinControl* FFocusedControl;
	bool FEmulateMessageDlg;
	System::Classes::TNotifyEvent FOldFontChanged;
	Vcl::Controls::TControl* FProgressBar;
	bool FCalcAutosizing;
	bool FCalcLayout;
	TJSProgress* FProgress;
	TJSBorder* FBorder;
	bool FAssigning;
	System::Classes::TNotifyEvent FOnDialogExpand;
	System::Classes::TNotifyEvent FOnDialogCollapse;
	TGetVerificationResult FOnGetVerificationResult;
	TUpdateProgressBarStateEvent FOnUpdateProgressBarState;
	TUpdateProgressBarEvent FOnUpdateProgressBar;
	int FShowMoreButtonWidth;
	bool FExpanding;
	bool FCollapsing;
	System::Uitypes::TColor FColor;
	Vcl::Graphics::TFont* FFont;
	System::UnicodeString FTitle;
	Jsdialogs::TDialogPosition FPosition;
	TJSLocation* FLocation;
	int FHelpContext;
	Vcl::Forms::TFormBorderStyle FBorderStyle;
	Vcl::Graphics::TIcon* FIcon;
	bool FUseDefaultFonts;
	System::Classes::THelpType FHelpType;
	System::UnicodeString FHelpKeyword;
	TDialogCloseEvent FOnDialogClose;
	TDialogClickEvent FOnDialogClick;
	TJSDialogResult FDialogResult;
	bool FInitialisingFonts;
	int FWidth;
	System::Classes::TNotifyEvent FOnCleanUpDialog;
	bool FAllowCancel;
	bool FAllowMinimize;
	int FFirstButtonLeftPos;
	int FWidthOfLastCommonButton;
	System::Classes::TNotifyEvent FOnDialogConstructed;
	System::Classes::TNotifyEvent FOnCreated;
	System::Classes::TNotifyEvent FOnDestroyed;
	TControlType FActiveControlType;
	TProgressEvent FOnProgress;
	bool FInvalidateOnPosition;
	Vcl::Controls::TControl* FDefaultButton;
	bool FUseOldStyleSetting;
	int FAcceleratorState;
	TJSTimer* FTimer;
	TTimerEvent FOnTimer;
	TGetRadioButtonChecked FOnGetRadioButtonChecked;
	THelpButtonClickEvent FOnHelpButtonClick;
	Jstypes::TJSBackground* FBackground;
	TJSRadioButton* FRadioButton;
	int FClientWidth;
	int FClientHeight;
	Vcl::Controls::TKeyEvent FOnKeyPress;
	System::Classes::TBiDiMode FBiDiMode;
	bool FShowHint;
	TVerificationClickEvent FOnVerificationClick;
	bool FShowHelpButton;
	Jsgraphics::TJSCaptionControl* FInstructionLabel;
	Jsgraphics::TJSCaptionControl* FContentLabel;
	Jsgraphics::TJSCaptionControl* FMoreLinesLabel;
	Vcl::Controls::TControl* FContentMaxLines;
	TGetCustomSoundEvent FOnGetCustomSound;
	bool FPlaySounds;
	int FMaxLines;
	bool FResetMaxLines;
	System::Classes::TNotifyEvent FOnDialogShow;
	Vcl::Forms::TDefaultMonitor FDefaultMonitor;
	int FExpandingHeight;
	int FExpandedHeight;
	int FExpandedAmount;
	int FExpandedLeftOver;
	TJSButtonOptions* FButton;
	TJSSheetOptions* FSheet;
	Jsprogressbar::TJSTaskBarProgressImpl* FTaskBarProgressImpl;
	int FPreviousProgressPosition;
	void __fastcall SetLines(System::Classes::TStrings* const Value);
	void __fastcall SetGlyph(Vcl::Graphics::TPicture* const Value);
	void __fastcall SetExpando(TJSExpando* const Value);
	void __fastcall ExpandoChangedHandler(System::TObject* Sender);
	void __fastcall InstructionChangeHandler(System::TObject* Sender);
	void __fastcall ContentChangeHandler(System::TObject* Sender);
	void __fastcall VerificationChangeHandler(System::TObject* Sender);
	void __fastcall SetRadioButtons(TJSRadioButtons* const Value);
	void __fastcall SetCustomButtons(TJSCustomButtons* const Value);
	void __fastcall SetButtonBar(TJSButtonBarOptions* const Value);
	void __fastcall SetInstruction(TJSInstruction* const Value);
	void __fastcall SetText(const System::UnicodeString Value);
	void __fastcall SetVerification(TJSVerification* const Value);
	int __fastcall GetRadioResult(void);
	bool __fastcall GetVerificationResult(void);
	void __fastcall SetRadioResult(const int Value);
	void __fastcall SetVerificationResult(const bool Value);
	void __fastcall ButtonClickHandler(System::TObject* Sender);
	void __fastcall HelpButtonClickHandler(System::TObject* Sender);
	void __fastcall RadioButtonClickHandler(System::TObject* Sender);
	void __fastcall ShowMoreButtonCollapsedHandler(System::TObject* Sender);
	void __fastcall ShowMoreButtonExpandedHandler(System::TObject* Sender);
	void __fastcall FooterChange(System::TObject* Sender);
	void __fastcall SetFooter(TJSFooter* const Value);
	void __fastcall SetHeader(TJSHeader* const Value);
	void __fastcall SetForm(TJSCustomTaskDialogForm* const Value);
	System::Uitypes::TModalResult __fastcall GetModalResult(void);
	void __fastcall SetModalResult(const System::Uitypes::TModalResult Value);
	void __fastcall SetMainIcon(const Jsdialogs::TTaskDialogIcon Value);
	void __fastcall SetDialogOptions(const TDialogOptions Value);
	void __fastcall SetDialogStyle(const TJSDialogStyle Value);
	void __fastcall HelpLinkLabelClickHandler(System::TObject* Sender);
	void __fastcall SetHelpLink(TJSHelpLink* const Value);
	void __fastcall SetCustomButtonResult(const int Value);
	bool __fastcall ShowCommandLinks(void);
	bool __fastcall ShowProgressBar(void);
	bool __fastcall ShowProgressBarOnTaskBar(void);
	bool __fastcall ShowRadioButtons(void);
	void __fastcall NewFontChanged(System::TObject* Sender);
	void __fastcall SetProgress(TJSProgress* const Value);
	void __fastcall SetBorder(TJSBorder* const Value);
	void __fastcall CheckBoxClickHandler(System::TObject* Sender);
	int __fastcall GetShowMoreButtonWidth(void);
	bool __fastcall IsCustomButtonsStored(void);
	bool __fastcall IsRadioButtonsStored(void);
	Vcl::Graphics::TCanvas* __fastcall Canvas(void);
	void __fastcall SetFont(Vcl::Graphics::TFont* const Value);
	void __fastcall SetIcon(Vcl::Graphics::TIcon* const Value);
	void __fastcall SetUseDefaultFonts(const bool Value);
	void __fastcall DialogCloseHandler(System::TObject* Sender, System::Uitypes::TCloseAction &Action);
	void __fastcall DialogCloseQueryHandler(System::TObject* Sender, bool &CanClose);
	void __fastcall DialogDestroyHandler(System::TObject* Sender);
	void __fastcall DialogShowHandler(System::TObject* Sender);
	void __fastcall DialogKeyUpHandler(System::TObject* Sender, System::Word &Key, System::Classes::TShiftState Shift);
	void __fastcall DialogClientClickHandler(System::TObject* Sender, const System::Types::TPoint &APt);
	bool __fastcall IsExpanded(void);
	bool __fastcall IsDialogAvailable(void);
	void __fastcall SetColor(const System::Uitypes::TColor Value);
	bool __fastcall IsFontStored(void);
	int __fastcall GetIconHeightFromIconSize(const TJSIconSize aIconSize);
	void __fastcall SetLocation(TJSLocation* const Value);
	void __fastcall SetWidth(const int Value);
	void __fastcall HeaderFontChange(System::TObject* Sender);
	void __fastcall ProgressChangeHandler(System::TObject* Sender);
	void __fastcall TimerChangeHandler(System::TObject* Sender);
	void __fastcall SetActiveControlType(const TControlType Value);
	Vcl::Graphics::TGraphic* __fastcall CreateGraphic(const Jsdialogs::TTaskDialogIcon AIcon, const TJSIconSize ASize);
	void __fastcall SetTimer(TJSTimer* const Value);
	void __fastcall GlyphChangeHandler(System::TObject* Sender);
	void __fastcall SetRadioButton(TJSRadioButton* const Value);
	bool __fastcall HasElevationButton(void);
	void __fastcall SetShowHint(const bool Value);
	void __fastcall SetTitle(const System::UnicodeString Value);
	void __fastcall SetPlaySounds(const bool Value);
	System::UnicodeString __fastcall StripFormatting(const System::UnicodeString AStr);
	void __fastcall LoadStringIntoRichEdit(const System::UnicodeString AString);
	System::UnicodeString __fastcall RetrievePlainTextFromRichEdit(void);
	TJSDialogHitTest __fastcall GetHitTest(const System::Types::TPoint &APt);
	void __fastcall FooterClickHandler(System::TObject* Sender);
	void __fastcall ContentClickHandler(System::TObject* Sender);
	void __fastcall InstructionClickHandler(System::TObject* Sender);
	void __fastcall MoreLinesClickHandler(System::TObject* Sender);
	bool __fastcall IsColorStored(void);
	void __fastcall SetButton(TJSButtonOptions* const Value);
	void __fastcall SetSheet(TJSSheetOptions* const Value);
	
protected:
	TJSCustomTaskDialogForm* FForm;
	bool FButtonClicked;
	bool FIgnoreSnapTo;
	virtual int __fastcall AdjustButtonBarHeight(void);
	void __fastcall CreateCommonButton(Jsdialogs::TCommonButton ACommonBtn, const System::Types::TPoint &ADialogUnits, int AButtonHeight);
	virtual void __fastcall DoButtonClick(System::TObject* Sender);
	virtual void __fastcall DoHelpButtonClick(System::TObject* Sender);
	virtual void __fastcall DoControlClick(System::TObject* Sender, TControlType ControlType, const int Value, bool &Handled);
	virtual void __fastcall DoDialogCloseQuery(System::TObject* Sender, bool &CanClose);
	virtual void __fastcall DoGetCustomSound(System::UnicodeString &ASound, unsigned &AFlags, bool &AHandled);
	virtual void __fastcall DoKeyPressHandler(System::Word &Key, System::Classes::TShiftState Shift);
	virtual bool __fastcall DoGetVerificationResult(void);
	System::Types::TRect __fastcall GetRect(TPaintStage AStage);
	int __fastcall GetInstructionHeight(const bool AIncludeGlyphHeight);
	int __fastcall GetInstructionWidth(void);
	int __fastcall GetContentWidth(void);
	int __fastcall GetFooterHeight(void);
	int __fastcall GetFooterImageWidth(void);
	int __fastcall GetHeaderImageWidth(void);
	int __fastcall GetMoreFooterHeight(void);
	virtual void __fastcall PaintMainInstruction(Vcl::Graphics::TCanvas* ACanvas, const System::Types::TRect &ARect);
	virtual void __fastcall PaintMoreLines(Vcl::Graphics::TCanvas* ACanvas, const System::Types::TRect &ARect);
	virtual void __fastcall PaintGlyph(Vcl::Graphics::TCanvas* ACanvas, const System::Types::TRect &ARect);
	virtual void __fastcall PaintHeader(Vcl::Graphics::TCanvas* ACanvas, const System::Types::TRect &ARect);
	virtual void __fastcall PaintMoreFooter(Vcl::Graphics::TCanvas* ACanvas, const System::Types::TRect &ARect);
	virtual void __fastcall PaintButtonBar(Vcl::Graphics::TCanvas* ACanvas, const System::Types::TRect &ARect);
	virtual void __fastcall PaintFooter(Vcl::Graphics::TCanvas* ACanvas);
	virtual void __fastcall PaintFooterSeparator(Vcl::Graphics::TCanvas* ACanvas, const System::Types::TRect &ARect);
	void __fastcall Paint(void);
	virtual bool __fastcall CheckMinimumHeight(void);
	virtual int __fastcall CalculateWidth(void);
	virtual void __fastcall InitialiseMargins(void);
	virtual void __fastcall CalculateAutoSize(/* out */ int &AHeight, /* out */ int &AWidth, const bool AApply = true);
	virtual int __fastcall HeightAdjustment(void);
	virtual int __fastcall WidthAdjustment(void);
	virtual void __fastcall CreateControls(void);
	virtual void __fastcall RecreateControls(void);
	virtual void __fastcall ReinitialiseControls(void);
	virtual void __fastcall CreateRadioButtons(void);
	virtual void __fastcall PositionRadioButtons(void);
	virtual void __fastcall CreateCustomButtons(void);
	virtual void __fastcall PositionCustomButtons(void);
	virtual void __fastcall CreateButtonBarButtons(void);
	virtual void __fastcall PositionButtonBarButtons(void);
	virtual void __fastcall CreateVerificationCheckBox(void);
	virtual void __fastcall PositionVerificationCheckBox(void);
	virtual void __fastcall CreateExpandoButton(void);
	virtual void __fastcall PositionExpandoButton(void);
	virtual void __fastcall CreateInstruction(void);
	virtual void __fastcall PositionInstruction(void);
	virtual void __fastcall CreateContent(void);
	virtual void __fastcall PositionContent(void);
	virtual void __fastcall CreateFooter(void);
	virtual void __fastcall PositionFooter(void);
	virtual void __fastcall CreateMoreInFooter(void);
	virtual void __fastcall CreateMoreLines(void);
	virtual void __fastcall PositionMoreLines(void);
	virtual void __fastcall PositionMoreRichEdit(void);
	bool __fastcall LoadLines(System::Classes::TStrings* L);
	bool __fastcall LoadLinesW(System::Classes::TStrings* L);
	virtual void __fastcall CreateHeader(void);
	virtual void __fastcall CreateHelpLinkLabel(void);
	virtual void __fastcall PositionHelpLinkLabel(void);
	virtual void __fastcall CreateProgressBar(void);
	virtual void __fastcall PositionProgressBar(void);
	virtual void __fastcall CreateEditControls(void);
	virtual void __fastcall InitialiseControlClass(TControlType AControlType, Vcl::Controls::TControlClass &AControlClass);
	virtual Vcl::Controls::TControlClass __fastcall DoGetControlClass(TControlType AControlType);
	virtual void __fastcall DoInitControl(TControlType AControlType, Vcl::Controls::TControl* AControl, System::Classes::TCollectionItem* AControlItem);
	virtual void __fastcall InitialiseControl(TControlType AControlType, Vcl::Controls::TControl* AControl, System::Classes::TCollectionItem* AControlItem);
	virtual void __fastcall DoGetMoreFileName(System::UnicodeString &aFileName);
	virtual void __fastcall DoGetMoreStream(System::Classes::TMemoryStream* &aStream);
	virtual void __fastcall DoHelpLinkClick(void);
	virtual void __fastcall ExpandDialog(const bool AExpand);
	virtual Vcl::Controls::TWinControl* __fastcall GetActiveControl(void);
	__classmethod void __fastcall SetTaskIcon(const Jsdialogs::TTaskDialogIcon aIcon, Vcl::Graphics::TPicture* aGlyph);
	bool __fastcall CanUpdateProgress(void);
	void __fastcall InvalidateButtons(void);
	virtual void __fastcall DoExpand(void);
	virtual void __fastcall DoCollapse(void);
	virtual void __fastcall DoUpdateProgressBarState(Jsprogressbar::TProgressBarState AState);
	virtual void __fastcall DoUpdateProgressBar(const int APosition, bool &ACloseDialog);
	virtual void __fastcall DoProgress(const int APosition);
	virtual void __fastcall DoDialogClose(System::TObject* Sender);
	virtual void __fastcall DoDialogClick(System::TObject* Sender, const TJSDialogHitTest AHitTest);
	virtual void __fastcall UpdateDialogResult(void);
	virtual void __fastcall DoCleanUpDialog(void);
	virtual void __fastcall DoTimerEvent(const unsigned aTimeSince);
	virtual void __fastcall CleanUpDialog(void);
	MESSAGE void __fastcall CMFontchanged(Winapi::Messages::TMessage &Message);
	virtual void __fastcall DoCreated(void);
	virtual void __fastcall DoDestroyed(void);
	virtual void __fastcall DoDialogConstructed(void);
	void __fastcall ShowCommandLinkHotKeys(void);
	virtual bool __fastcall DoGetRadioButtonChecked(Vcl::Controls::TControl* AControl);
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation Operation);
	virtual void __fastcall ResetProgressBar(void);
	virtual void __fastcall DoVerificationClick(const bool Checked);
	virtual bool __fastcall PlaySystemSounds(void);
	virtual System::UnicodeString __fastcall GetSystemSound(const Jsdialogs::TTaskDialogIcon AIcon, unsigned &AFlags);
	virtual void __fastcall DoDialogShow(void);
	virtual void __fastcall DoShowDialogModal(void);
	virtual void __fastcall DoShowDialogNonModal(void);
	virtual void __fastcall CalculateSheetPosition(void);
	virtual int __fastcall AdjustSheetTopPosition(const int ATop);
	int __fastcall GetCaptionHeight(Vcl::Forms::TCustomForm* AForm);
	virtual int __fastcall HorzPadding(void);
	__property int LeftMargin = {read=FLeftMargin, nodefault};
	__property int RightMargin = {read=FRightMargin, nodefault};
	__property int VertMargin = {read=FVertMargin, nodefault};
	__property TJSDialogStates DialogState = {read=FDialogState, nodefault};
	
public:
	__fastcall virtual TJSCustomDialog(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TJSCustomDialog(void);
	int __fastcall Execute(void)/* overload */;
	virtual int __fastcall Execute(System::Classes::TComponent* aOwner)/* overload */;
	int __fastcall ExecutePreview(void);
	int __fastcall ContentLineWidth(const System::UnicodeString ALine);
	__classmethod int __fastcall RequiredWidth(const System::UnicodeString ALine, TJSFontType AFontType);
	virtual int __fastcall Close(const int AModalResult = 0x0);
	void __fastcall Update(void);
	virtual void __fastcall PositionControls(void);
	void __fastcall DefaultRadioButton(const int aIndex);
	bool __fastcall IsChecked(const int aValue);
	void __fastcall Show(void);
	int __fastcall UpdateProgress(void)/* overload */;
	int __fastcall UpdateProgress(const int aPosition)/* overload */;
	int __fastcall UpdateProgress(const int aPosition, const int aStep)/* overload */;
	void __fastcall SetProgressState(const Jsprogressbar::TProgressBarState aState);
	void __fastcall SetUnchecked(const int aValue = 0xffffffff);
	void __fastcall SetChecked(const int aValue, const bool aChecked);
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	Vcl::Controls::TControl* __fastcall GetControl(const TControlType AControlType, const int AValue = 0xffffffff);
	void __fastcall EnableButton(const int AValue, const bool AEnabled);
	void __fastcall EnableRadioButton(const int aValue, const bool aEnabled);
	void __fastcall PerformAction(const int aValue);
	void __fastcall UpdateCustomButtonDetails(const int aValue, const System::UnicodeString aCaption, const System::UnicodeString aHint, System::Classes::TStrings* aInfo);
	__property bool AllowMinimize = {read=FAllowMinimize, write=FAllowMinimize, default=0};
	__property bool AllowCancel = {read=FAllowCancel, write=FAllowCancel, default=1};
	__property TJSCustomTaskDialogForm* Form = {read=FForm, write=SetForm};
	__property TControlType ActiveControlType = {read=FActiveControlType, write=SetActiveControlType, default=0};
	__property Vcl::Graphics::TFont* Font = {read=FFont, write=SetFont, stored=IsFontStored};
	__property System::Uitypes::TColor Color = {read=FColor, write=SetColor, stored=IsColorStored, default=-16777211};
	__property System::Classes::TStrings* Content = {read=FContent, write=SetLines};
	__property TJSExpando* Expando = {read=FExpando, write=SetExpando};
	__property Vcl::Graphics::TPicture* Glyph = {read=FGlyph, write=SetGlyph};
	__property TJSRadioButtons* RadioButtons = {read=FRadioButtons, write=SetRadioButtons, stored=IsRadioButtonsStored};
	__property TJSCustomButtons* CustomButtons = {read=FCustomButtons, write=SetCustomButtons, stored=IsCustomButtonsStored};
	__property TJSButtonBarOptions* ButtonBar = {read=FButtonBar, write=SetButtonBar};
	__property TJSInstruction* Instruction = {read=FInstruction, write=SetInstruction};
	__property TJSVerification* Verification = {read=FVerification, write=SetVerification};
	__property System::UnicodeString Text = {read=FText, write=SetText};
	__property Jsdialogs::TTaskDialogIcon MainIcon = {read=FMainIcon, write=SetMainIcon, default=0};
	__property TDialogOptions DialogOptions = {read=FDialogOptions, write=SetDialogOptions, default=256};
	__property TJSDialogStyle DialogStyle = {read=FDialogStyle, write=SetDialogStyle, default=0};
	__property TJSHelpLink* HelpLink = {read=FHelpLink, write=SetHelpLink};
	__property TJSProgress* Progress = {read=FProgress, write=SetProgress};
	__property TJSBorder* Border = {read=FBorder, write=SetBorder};
	__property TJSButtonOptions* Button = {read=FButton, write=SetButton};
	__property TJSFooter* Footer = {read=FFooter, write=SetFooter};
	__property TJSHeader* Header = {read=FHeader, write=SetHeader};
	__property System::UnicodeString Title = {read=FTitle, write=SetTitle};
	__property Jsdialogs::TDialogPosition Position = {read=FPosition, write=FPosition, default=0};
	__property int HelpContext = {read=FHelpContext, write=FHelpContext, default=0};
	__property bool UseDefaultFonts = {read=FUseDefaultFonts, write=SetUseDefaultFonts, default=1};
	__property Vcl::Forms::TFormBorderStyle BorderStyle = {read=FBorderStyle, write=FBorderStyle, default=3};
	__property Vcl::Graphics::TIcon* Icon = {read=FIcon, write=SetIcon};
	__property System::Classes::THelpType HelpType = {read=FHelpType, write=FHelpType, default=1};
	__property System::UnicodeString HelpKeyword = {read=FHelpKeyword, write=FHelpKeyword};
	__property bool EmulateMessageDlg = {read=FEmulateMessageDlg, write=FEmulateMessageDlg, nodefault};
	__property TJSLocation* Location = {read=FLocation, write=SetLocation};
	__property bool PlaySounds = {read=FPlaySounds, write=SetPlaySounds, nodefault};
	__property int Width = {read=FWidth, write=SetWidth, default=0};
	__property bool UseOldStyleSetting = {read=FUseOldStyleSetting, write=FUseOldStyleSetting, default=1};
	__property int RadioResult = {read=GetRadioResult, write=SetRadioResult, nodefault};
	__property bool VerificationResult = {read=GetVerificationResult, write=SetVerificationResult, nodefault};
	__property System::Uitypes::TModalResult ModalResult = {read=GetModalResult, write=SetModalResult, nodefault};
	__property int CustomButtonResult = {read=FCustomButtonResult, write=SetCustomButtonResult, nodefault};
	__property TJSTimer* Timer = {read=FTimer, write=SetTimer};
	__property TJSRadioButton* RadioButton = {read=FRadioButton, write=SetRadioButton};
	__property System::Classes::TBiDiMode BiDiMode = {read=FBiDiMode, write=FBiDiMode, default=0};
	__property TJSSheetOptions* Sheet = {read=FSheet, write=SetSheet};
	__property bool ShowHelpButton = {read=FShowHelpButton, write=FShowHelpButton, default=0};
	__property bool ShowHint = {read=FShowHint, write=SetShowHint, default=0};
	__property int MaxLines = {read=FMaxLines, write=FMaxLines, default=0};
	__property Vcl::Forms::TDefaultMonitor DefaultMonitor = {read=FDefaultMonitor, write=FDefaultMonitor, default=3};
	__property System::Classes::TNotifyEvent OnCreated = {read=FOnCreated, write=FOnCreated};
	__property System::Classes::TNotifyEvent OnDestroyed = {read=FOnDestroyed, write=FOnDestroyed};
	__property System::Classes::TNotifyEvent OnDialogConstructed = {read=FOnDialogConstructed, write=FOnDialogConstructed};
	__property TDialogCloseEvent OnDialogClose = {read=FOnDialogClose, write=FOnDialogClose};
	__property TDialogClickEvent OnDialogClick = {read=FOnDialogClick, write=FOnDialogClick};
	__property System::Classes::TNotifyEvent OnCleanUpDialog = {read=FOnCleanUpDialog, write=FOnCleanUpDialog};
	__property System::Classes::TNotifyEvent OnDialogShow = {read=FOnDialogShow, write=FOnDialogShow};
	__property TGetMoreFileNameEvent OnGetMoreFileName = {read=FOnGetMoreFileName, write=FOnGetMoreFileName};
	__property TGetMoreStreamEvent OnGetMoreStream = {read=FOnGetMoreStream, write=FOnGetMoreStream};
	__property TInitControlEvent OnInitControl = {read=FOnInitControl, write=FOnInitControl};
	__property TGetControlClassEvent OnGetControlClass = {read=FOnGetControlClass, write=FOnGetControlClass};
	__property System::Classes::TNotifyEvent OnDialogExpand = {read=FOnDialogExpand, write=FOnDialogExpand};
	__property System::Classes::TNotifyEvent OnDialogCollapse = {read=FOnDialogCollapse, write=FOnDialogCollapse};
	__property TGetCustomSoundEvent OnGetCustomSound = {read=FOnGetCustomSound, write=FOnGetCustomSound};
	__property TGetVerificationResult OnGetVerificationResult = {read=FOnGetVerificationResult, write=FOnGetVerificationResult};
	__property THelpButtonClickEvent OnHelpButtonClick = {read=FOnHelpButtonClick, write=FOnHelpButtonClick};
	__property THelpLinkClickEvent OnHelpLinkClick = {read=FOnHelpLinkClick, write=FOnHelpLinkClick};
	__property TControlClickEvent OnControlClick = {read=FOnControlClick, write=FOnControlClick};
	__property TGetRadioButtonChecked OnGetRadioButtonChecked = {read=FOnGetRadioButtonChecked, write=FOnGetRadioButtonChecked};
	__property TProgressEvent OnProgress = {read=FOnProgress, write=FOnProgress};
	__property TUpdateProgressBarStateEvent OnUpdateProgressBarState = {read=FOnUpdateProgressBarState, write=FOnUpdateProgressBarState};
	__property TUpdateProgressBarEvent OnUpdateProgressBar = {read=FOnUpdateProgressBar, write=FOnUpdateProgressBar};
	__property TTimerEvent OnTimer = {read=FOnTimer, write=FOnTimer};
	__property Vcl::Controls::TKeyEvent OnKeyPress = {read=FOnKeyPress, write=FOnKeyPress};
	__property TVerificationClickEvent OnVerificationClick = {read=FOnVerificationClick, write=FOnVerificationClick};
};


class PASCALIMPLEMENTATION TJSDialog : public TJSCustomDialog
{
	typedef TJSCustomDialog inherited;
	
__published:
	__property ActiveControlType = {default=0};
	__property AllowCancel = {default=1};
	__property AllowMinimize = {default=0};
	__property BiDiMode = {default=0};
	__property Button;
	__property Content;
	__property DefaultMonitor = {default=3};
	__property DialogOptions = {default=256};
	__property DialogStyle = {default=0};
	__property Expando;
	__property Glyph;
	__property Instruction;
	__property RadioButtons;
	__property CustomButtons;
	__property ButtonBar;
	__property Verification;
	__property Footer;
	__property Header;
	__property MainIcon = {default=0};
	__property HelpLink;
	__property Progress;
	__property Border;
	__property Title = {default=0};
	__property Position = {default=0};
	__property Color = {default=-16777211};
	__property Font;
	__property UseDefaultFonts = {default=1};
	__property BorderStyle = {default=3};
	__property Icon;
	__property HelpContext = {default=0};
	__property HelpType = {default=1};
	__property HelpKeyword = {default=0};
	__property Location;
	__property Width = {default=0};
	__property UseOldStyleSetting = {default=1};
	__property Sheet;
	__property Timer;
	__property RadioButton;
	__property ShowHint = {default=0};
	__property MaxLines = {default=0};
	__property OnCleanUpDialog;
	__property OnCreated;
	__property OnDestroyed;
	__property OnDialogClick;
	__property OnDialogClose;
	__property OnDialogConstructed;
	__property OnGetMoreFileName;
	__property OnGetMoreStream;
	__property OnHelpLinkClick;
	__property OnHelpButtonClick;
	__property OnGetControlClass;
	__property OnInitControl;
	__property OnControlClick;
	__property OnDialogCollapse;
	__property OnDialogExpand;
	__property OnDialogShow;
	__property OnGetRadioButtonChecked;
	__property OnGetVerificationResult;
	__property OnProgress;
	__property OnUpdateProgressBarState;
	__property OnUpdateProgressBar;
	__property OnTimer;
	__property OnKeyPress;
	__property OnVerificationClick;
public:
	/* TJSCustomDialog.Create */ inline __fastcall virtual TJSDialog(System::Classes::TComponent* AOwner) : TJSCustomDialog(AOwner) { }
	/* TJSCustomDialog.Destroy */ inline __fastcall virtual ~TJSDialog(void) { }
	
};


typedef System::TMetaClass* TJSDialogClass;

typedef void __fastcall (__closure *TJSTaskDialogFormClientClickEvent)(System::TObject* Sender, const System::Types::TPoint &APt);

class PASCALIMPLEMENTATION TJSTaskDialogForm : public TJSCustomTaskDialogForm
{
	typedef TJSCustomTaskDialogForm inherited;
	
private:
	TJSCustomDialog* FDialog;
	unsigned FLastTimer;
	TJSTaskDialogFormClientClickEvent FOnClientClick;
	MESSAGE void __fastcall WMNonModalFree(Winapi::Messages::TMessage &Message);
	MESSAGE void __fastcall WMPerformSnapTo(Winapi::Messages::TMessage &Message);
	
protected:
	DYNAMIC void __fastcall ActiveChanged(void);
	virtual void __fastcall CreateParams(Vcl::Controls::TCreateParams &Params);
	DYNAMIC void __fastcall DoClose(System::Uitypes::TCloseAction &Action);
	virtual System::UnicodeString __fastcall GetTaskDialogText(void);
	DYNAMIC void __fastcall KeyDown(System::Word &Key, System::Classes::TShiftState Shift);
	HIDESBASE MESSAGE void __fastcall WMEraseBkgnd(Winapi::Messages::TWMEraseBkgnd &Message);
	HIDESBASE MESSAGE void __fastcall WMWinIniChange(Winapi::Messages::TMessage &Message);
	DYNAMIC void __fastcall Paint(void);
	virtual void __fastcall CreateWnd(void);
	MESSAGE void __fastcall WMTimer(Winapi::Messages::TWMTimer &Message);
	void __fastcall StartTimer(void);
	void __fastcall EndTimer(void);
	virtual void __fastcall DoClientClick(const System::Types::TPoint &APt);
	DYNAMIC void __fastcall Click(void);
	__property TJSCustomDialog* Dialog = {read=FDialog, write=FDialog};
	
public:
	__fastcall virtual TJSTaskDialogForm(System::Classes::TComponent* AOwner, int Dummy);
	__property TJSTaskDialogFormClientClickEvent OnClientClick = {read=FOnClientClick, write=FOnClientClick};
public:
	/* TCustomForm.Create */ inline __fastcall virtual TJSTaskDialogForm(System::Classes::TComponent* AOwner) : TJSCustomTaskDialogForm(AOwner) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TJSTaskDialogForm(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TJSTaskDialogForm(HWND ParentWindow) : TJSCustomTaskDialogForm(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
static const int clInstruction = int(0x993300);
static const int clVistaSeparator = int(0xdfdfdf);
static const System::Word WM_NONMODAL_FREE = System::Word(0x42f);
static const System::Word WM_PERFORMSNAPTO = System::Word(0x42b);
static const System::Int8 BASE_CUSTOMBUTTON = System::Int8(0x64);
static const System::Byte BASE_RADIOBUTTON = System::Byte(0xc8);
#define JSDIALOG_CTRL_INSTRUCTION L"JSDialogInstructionControl"
#define JSDIALOG_CTRL_CONTENT L"JSDialogContentControl"
#define JSDIALOG_CTRL_VERIFICATION L"JSDialogVerificationControl"
#define JSDIALOG_CTRL_EXPANDO L"JSDialogExpandoControl"
#define JSDIALOG_CTRL_RICHEDIT L"JSDialogMoreRichEdit"
#define JSDIALOG_CTRL_MORELINES L"JSDialogMoreLinesControl"
#define JSDIALOG_CTRL_PROGRESSBAR L"JSDialogProgressControl"
#define JSDIALOG_CTRL_RADIOGROUP L"JSDialogRadioGroupControl"
#define JSDIALOG_CTRL_CONTENTMEMO L"JSDialogContentMemoControl"
#define JSDIALOG_CTRL_FOOTER L"JSDialogFooterControl"
#define JSDIALOG_CTRL_HELPLINK L"JSDialogHelpLinkControl"
#define JSDIALOG_FORM L"JSDialogForm"
extern DELPHI_PACKAGE bool UseOldDialogStyle;
extern DELPHI_PACKAGE bool AlwaysUseDefaultFonts;
extern DELPHI_PACKAGE TJSDialogClass JSDialogClass;
extern DELPHI_PACKAGE void __fastcall RegisterFont(TJSFontType AFontType, Vcl::Graphics::TFont* AFont)/* overload */;
extern DELPHI_PACKAGE void __fastcall RegisterFont(TJSFontType AFontType, const System::UnicodeString AName, const int ASize, const System::Uitypes::TColor AColor = (System::Uitypes::TColor)(0x1fffffff))/* overload */;
extern DELPHI_PACKAGE void __fastcall RegisterFont(TJSFontType AFontType)/* overload */;
extern DELPHI_PACKAGE Vcl::Graphics::TFont* __fastcall GetRegisteredFont(TJSFontType AFontType);
extern DELPHI_PACKAGE void __fastcall ResetRegisteredFonts(void);
extern DELPHI_PACKAGE int __fastcall AFFS(const int AValue);
extern DELPHI_PACKAGE System::WideChar * __fastcall GetIcon(const Jsdialogs::TTaskDialogIcon Value, bool &AIsCustomShield);
extern DELPHI_PACKAGE bool __fastcall IsVista(void);
}	/* namespace Jsdialog */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_JSDIALOG)
using namespace Jsdialog;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// JsdialogHPP
