// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'ElGroupBox.pas' rev: 31.00 (Windows)

#ifndef ElgroupboxHPP
#define ElgroupboxHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.SysUtils.hpp>
#include <System.Classes.hpp>
#include <System.Types.hpp>
#include <Vcl.StdCtrls.hpp>
#include <Winapi.Messages.hpp>
#include <Vcl.Controls.hpp>
#include <Winapi.Windows.hpp>
#include <Vcl.Graphics.hpp>
#include <Winapi.CommCtrl.hpp>
#include <Vcl.ExtCtrls.hpp>
#include <Vcl.Forms.hpp>
#include <Vcl.ImgList.hpp>
#include <System.Math.hpp>
#include <Vcl.Themes.hpp>
#include <Winapi.UxTheme.hpp>
#include <LMDThemes.hpp>
#include <LMDProcs.hpp>
#include <LMDClass.hpp>
#include <LMDObjectList.hpp>
#include <LMDGraphUtils.hpp>
#include <LMDGraph.hpp>
#include <LMDHTMLUnit.hpp>
#include <LMDTypes.hpp>
#include <ElImgFrm.hpp>
#include <ElPanel.hpp>
#include <ElVCLUtils.hpp>
#include <ElSndMap.hpp>
#include <ElXPThemedControl.hpp>
#include <ElCheckCtl.hpp>
#include <System.UITypes.hpp>
#include <Vcl.Menus.hpp>

//-- user supplied -----------------------------------------------------------

namespace Elgroupbox
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TCustomElGroupBox;
class DELPHICLASS TElGroupBox;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TCustomElGroupBox : public Elpanel::TCustomElPanel
{
	typedef Elpanel::TCustomElPanel inherited;
	
protected:
	bool FReading;
	Lmdhtmlunit::TLMDHTMLRender* FRender;
	bool FIsHTML;
	Lmdgraph::TLMDBorderSides FBorderSides;
	System::Types::TRect FTextRect;
	System::Types::TRect FCheckRect;
	Elsndmap::TElSoundName FCheckSound;
	Vcl::Graphics::TBitmap* FGlyph;
	Vcl::Imglist::TCustomImageList* FImages;
	Vcl::Imglist::TCustomImageList* FAlphaImages;
	Elsndmap::TElSoundMap* FSoundMap;
	bool FUseCustomGlyphs;
	bool FUseImageList;
	Vcl::Imglist::TChangeLink* FChLink;
	Vcl::Imglist::TChangeLink* FAChLink;
	bool FShowCheckBox;
	bool FCheckBoxChecked;
	bool FShowFocus;
	System::Uitypes::TColor FCaptionColor;
	bool FMouseInText;
	bool FMouseInCheckBox;
	bool FCaptured;
	HWND FOldCapture;
	bool FFlat;
	bool FFlatAlways;
	bool FAutoDisableChildren;
	bool FMoneyFlat;
	System::Uitypes::TColor FMoneyFlatInactiveColor;
	System::Uitypes::TColor FMoneyFlatActiveColor;
	System::Uitypes::TColor FMoneyFlatDownColor;
	void __fastcall DrawFrame(void);
	HIDESBASE MESSAGE void __fastcall WMNCPaint(Winapi::Messages::TWMNCPaint &Msg);
	virtual void __fastcall SetTransparentXPThemes(bool Value);
	HIDESBASE MESSAGE void __fastcall CMDialogChar(Winapi::Messages::TWMKey &Message);
	HIDESBASE void __fastcall SetBorderSides(Lmdgraph::TLMDBorderSides Value);
	void __fastcall ImagesChanged(System::TObject* Sender);
	virtual void __fastcall SetIsHTML(bool Value);
	virtual void __fastcall ReadState(System::Classes::TReader* Reader);
	virtual bool __fastcall CanModify(void);
	virtual Vcl::Themes::TThemedElement __fastcall GetThemedElement(void);
	void __fastcall SetShowCheckBox(bool Value);
	virtual void __fastcall SetCheckBoxChecked(bool Value);
	HIDESBASE void __fastcall SetShowFocus(bool Value);
	void __fastcall SetCaptionColor(System::Uitypes::TColor Value);
	virtual void __fastcall SetEnabled(bool Value);
	virtual void __fastcall SetCheckSound(Elsndmap::TElSoundName Value);
	virtual void __fastcall SetGlyph(Vcl::Graphics::TBitmap* Value);
	virtual void __fastcall SetSoundMap(Elsndmap::TElSoundMap* Value);
	virtual void __fastcall SetUseCustomGlyphs(bool Value);
	virtual void __fastcall SetImages(Vcl::Imglist::TCustomImageList* Value);
	virtual void __fastcall SetAlphaImages(Vcl::Imglist::TCustomImageList* Value);
	virtual void __fastcall SetUseImageList(bool Value);
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation operation);
	virtual void __fastcall GlyphChange(System::TObject* Sender);
	System::Types::TSize __fastcall GetCheckBoxSize(void);
	virtual void __fastcall DrawGlyph(Vcl::Graphics::TCanvas* Canvas, const System::Types::TRect &DestRect, const System::Types::TRect &SrcRect);
	virtual void __fastcall SetFlat(bool newValue);
	void __fastcall DrawFlatFrame(Vcl::Graphics::TCanvas* Canvas, const System::Types::TRect &R);
	DYNAMIC void __fastcall MouseDown(System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseUp(System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseMove(System::Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall KeyDown(System::Word &Key, System::Classes::TShiftState Shift);
	virtual void __fastcall AdjustClientRect(System::Types::TRect &Rect);
	int __fastcall GetTopOffset(void);
	HIDESBASE MESSAGE void __fastcall WMKillFocus(Winapi::Messages::TWMKillFocus &Msg);
	HIDESBASE MESSAGE void __fastcall WMSetFocus(Winapi::Messages::TWMSetFocus &Msg);
	HIDESBASE MESSAGE void __fastcall CMMouseLeave(Winapi::Messages::TMessage &Msg);
	void __fastcall SetFlatAlways(bool Value);
	System::Types::TRect __fastcall GetCaptionRect(void);
	System::Types::TRect __fastcall GetCheckRect(void);
	int __fastcall GetLineTopOffset(void);
	HIDESBASE MESSAGE void __fastcall CMEnabledChanged(Winapi::Messages::TMessage &Message);
	void __fastcall SetAutoDisableChildren(bool Value);
	virtual void __fastcall SetMoneyFlat(bool Value);
	virtual void __fastcall SetMoneyFlatInactiveColor(System::Uitypes::TColor Value);
	virtual void __fastcall SetMoneyFlatActiveColor(System::Uitypes::TColor Value);
	virtual void __fastcall SetMoneyFlatDownColor(System::Uitypes::TColor Value);
	bool __fastcall GetMoneyFlat(void);
	__property bool IsHTML = {read=FIsHTML, write=SetIsHTML, default=0};
	__property Lmdgraph::TLMDBorderSides BorderSides = {read=FBorderSides, write=SetBorderSides, default=15};
	__property bool ShowCheckBox = {read=FShowCheckBox, write=SetShowCheckBox, default=0};
	__property bool CheckBoxChecked = {read=FCheckBoxChecked, write=SetCheckBoxChecked, default=1};
	__property bool ShowFocus = {read=FShowFocus, write=SetShowFocus, default=0};
	__property System::Uitypes::TColor CaptionColor = {read=FCaptionColor, write=SetCaptionColor, default=536870911};
	__property Elsndmap::TElSoundName CheckSound = {read=FCheckSound, write=SetCheckSound};
	__property Vcl::Graphics::TBitmap* Glyph = {read=FGlyph, write=SetGlyph};
	__property Vcl::Imglist::TCustomImageList* Images = {read=FImages, write=SetImages};
	__property Vcl::Imglist::TCustomImageList* AlphaForImages = {read=FAlphaImages, write=SetAlphaImages};
	__property Elsndmap::TElSoundMap* SoundMap = {read=FSoundMap, write=SetSoundMap};
	__property bool UseCustomGlyphs = {read=FUseCustomGlyphs, write=SetUseCustomGlyphs, default=0};
	__property bool UseImageList = {read=FUseImageList, write=SetUseImageList, default=0};
	__property bool Flat = {read=FFlat, write=SetFlat, default=0};
	__property bool FlatAlways = {read=FFlatAlways, write=SetFlatAlways, default=0};
	__property bool AutoDisableChildren = {read=FAutoDisableChildren, write=SetAutoDisableChildren, default=0};
	__property bool MoneyFlat = {read=GetMoneyFlat, write=SetMoneyFlat, default=0};
	__property System::Uitypes::TColor MoneyFlatInactiveColor = {read=FMoneyFlatInactiveColor, write=SetMoneyFlatInactiveColor, stored=GetMoneyFlat, nodefault};
	__property System::Uitypes::TColor MoneyFlatActiveColor = {read=FMoneyFlatActiveColor, write=SetMoneyFlatActiveColor, stored=GetMoneyFlat, nodefault};
	__property System::Uitypes::TColor MoneyFlatDownColor = {read=FMoneyFlatDownColor, write=SetMoneyFlatDownColor, stored=GetMoneyFlat, nodefault};
	virtual void __fastcall Loaded(void);
	virtual void __fastcall RepaintRect(const System::Types::TRect &ARect);
	virtual Vcl::Themes::TThemedButton __fastcall GetThemedElementInState(void);
	
public:
	__fastcall virtual TCustomElGroupBox(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TCustomElGroupBox(void);
	DYNAMIC void __fastcall FlipChildren(bool AllLevels);
	
__published:
	__property DoubleBuffered = {default=0};
public:
	/* TWinControl.CreateParented */ inline __fastcall TCustomElGroupBox(HWND ParentWindow) : Elpanel::TCustomElPanel(ParentWindow) { }
	
};


class PASCALIMPLEMENTATION TElGroupBox : public TCustomElGroupBox
{
	typedef TCustomElGroupBox inherited;
	
__published:
	__property Align = {default=0};
	__property Anchors = {default=3};
	__property AutoDisableChildren = {default=0};
	__property BiDiMode;
	__property Constraints;
	__property DragKind = {default=0};
	__property ParentBiDiMode = {default=1};
	__property OnEndDock;
	__property OnStartDock;
	__property BorderSides = {default=15};
	__property Caption;
	__property CaptionColor = {default=536870911};
	__property CheckBoxChecked = {default=1};
	__property CheckSound = {default=0};
	__property Color = {default=-16777201};
	__property Ctl3D;
	__property DragCursor = {default=-12};
	__property DragMode = {default=0};
	__property Enabled = {default=1};
	__property Flat = {default=0};
	__property FlatAlways = {default=0};
	__property Font;
	__property Glyph;
	__property ImageForm;
	__property Images;
	__property AlphaForImages;
	__property MoneyFlat = {default=0};
	__property MoneyFlatInactiveColor;
	__property MoneyFlatActiveColor;
	__property MoneyFlatDownColor;
	__property IsHTML = {default=0};
	__property ParentCtl3D = {default=1};
	__property ParentColor = {default=0};
	__property ParentFont = {default=1};
	__property ParentShowHint = {default=1};
	__property PopupMenu;
	__property ShowCheckBox = {default=0};
	__property ShowFocus = {default=0};
	__property ShowHint;
	__property SoundMap;
	__property TabOrder = {default=-1};
	__property TabStop = {default=0};
	__property Transparent = {default=0};
	__property TransparentXPThemes = {default=1};
	__property UseCustomGlyphs = {default=0};
	__property UseImageList = {default=0};
	__property ParentThemeMode = {default=1};
	__property ThemeMode = {default=1};
	__property ThemeGlobalMode = {default=0};
	__property Visible = {default=1};
	__property AutoSize = {default=0};
	__property OnClick;
	__property OnDblClick;
	__property OnDragDrop;
	__property OnDragOver;
	__property OnEndDrag;
	__property OnEnter;
	__property OnExit;
	__property OnMouseDown;
	__property OnMouseUp;
	__property OnMouseMove;
	__property OnKeyDown;
	__property OnKeyUp;
	__property OnKeyPress;
	__property OnResize;
	__property OnStartDrag;
	__property OnContextPopup;
public:
	/* TCustomElGroupBox.Create */ inline __fastcall virtual TElGroupBox(System::Classes::TComponent* AOwner) : TCustomElGroupBox(AOwner) { }
	/* TCustomElGroupBox.Destroy */ inline __fastcall virtual ~TElGroupBox(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TElGroupBox(HWND ParentWindow) : TCustomElGroupBox(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Elgroupbox */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_ELGROUPBOX)
using namespace Elgroupbox;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// ElgroupboxHPP
