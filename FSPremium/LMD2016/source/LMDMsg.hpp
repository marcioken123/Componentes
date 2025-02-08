// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDMsg.pas' rev: 31.00 (Windows)

#ifndef LmdmsgHPP
#define LmdmsgHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <Winapi.Messages.hpp>
#include <System.SysUtils.hpp>
#include <System.Classes.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.Forms.hpp>
#include <Vcl.Dialogs.hpp>
#include <Vcl.ImgList.hpp>
#include <LMDButtonBase.hpp>
#include <LMDGraph.hpp>
#include <LMDFormA.hpp>
#include <LMDClass.hpp>
#include <LMDBase.hpp>
#include <LMDWaveList.hpp>
#include <LMDCustomImageList.hpp>
#include <LMDBaseController.hpp>
#include <LMDGlyphTextLayout.hpp>
#include <LMD3DCaption.hpp>
#include <LMDContainerComponent.hpp>
#include <System.UITypes.hpp>
#include <LMDCustomComponent.hpp>
#include <LMDTypes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdmsg
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDMessageBoxDlg;
//-- type declarations -------------------------------------------------------
typedef Lmdclass::TLMDDlgPosition TLMDBoxPosition;

class PASCALIMPLEMENTATION TLMDMessageBoxDlg : public Lmdcontainercomponent::TLMDContainerComponent
{
	typedef Lmdcontainercomponent::TLMDContainerComponent inherited;
	
private:
	Lmd3dcaption::TLMD3DCaption* FCaption3D;
	Lmd3dcaption::TLMD3DCaption* FMessageF3D;
	Vcl::Graphics::TFont* FButtonFont;
	Vcl::Graphics::TFont* FCaptionFont;
	Vcl::Graphics::TFont* FMessageFont;
	Lmdglyphtextlayout::TLMDGlyphTextLayout* FMessageAlign;
	bool FShowAgainBox;
	bool FShowAgain;
	bool FFillCaption;
	bool FPlayWave;
	bool FParentShowHint;
	bool FCtlXP;
	bool FCustomGlyph;
	System::UnicodeString FCaptionTitle;
	int FShowAgainOffsetX;
	int FShowAgainOffsetY;
	int FCustomGlyphImageIndex;
	int FCustomGlyphListIndex;
	Vcl::Imglist::TCustomImageList* FCustomGlyphImageList;
	System::Classes::TStringList* FHints;
	System::Classes::TStringList* FButtonTitles;
	Lmdwavelist::TLMDWaveList* FWaveList;
	System::Uitypes::TMsgDlgType FDlgType;
	System::Uitypes::TMsgDlgButtons FButtons;
	int FColors;
	int FWaveListIndex;
	int FHeight;
	int FWidth;
	int FLeft;
	int FTop;
	System::Uitypes::TColor FColor;
	Lmdclass::TLMDDlgPosition FPosition;
	Lmdbuttonbase::TLMDUserButtonStyle FButtonsStyle;
	Lmdbuttonbase::TLMDNormalButtonStyle FButtonStyle;
	Lmdclass::TLMDDlgPosRel FBoxRel;
	Lmdbasecontroller::TLMDChangeLink* FWaveChangeLink;
	Vcl::Imglist::TChangeLink* FChangeLink;
	System::Classes::TNotifyEvent FOnCustomize;
	System::Classes::TNotifyEvent FOnHelpClick;
	System::Classes::TAlignment FCaptionAlignment;
	void __fastcall SetFont(int index, Vcl::Graphics::TFont* aValue);
	void __fastcall SetFont3D(int index, Lmd3dcaption::TLMD3DCaption* aValue);
	void __fastcall SetCaptionTitle(const System::UnicodeString aValue);
	void __fastcall SetStringList(int index, System::Classes::TStringList* aValue);
	void __fastcall SetCustomGlyphImageList(Vcl::Imglist::TCustomImageList* aValue);
	void __fastcall SetCustomGlyphListIndex(int aValue);
	void __fastcall SetCustomGlyphImageIndex(int aValue);
	void __fastcall SetWaveList(Lmdwavelist::TLMDWaveList* aValue);
	void __fastcall SetButtons(System::Uitypes::TMsgDlgButtons aValue);
	void __fastcall SetInteger(int index, int aValue);
	void __fastcall SetBoxPos(Lmdclass::TLMDDlgPosition aValue);
	void __fastcall SetAlignment(Lmdglyphtextlayout::TLMDGlyphTextLayout* aValue);
	void __fastcall SetBool(int index, bool aValue);
	void __fastcall SetBoxRel(Lmdclass::TLMDDlgPosRel aValue);
	void __fastcall GetCustomGlyphIMLChange(System::TObject* Sender);
	void __fastcall GetWaveListChange(System::TObject* Sender);
	bool __fastcall WaveListEmpty(void);
	HIDESBASE void __fastcall ReadIdent(System::Classes::TReader* Reader);
	void __fastcall ReadStyle(System::Classes::TReader* Reader);
	HIDESBASE void __fastcall WriteIdent(System::Classes::TWriter* Writer);
	HIDESBASE bool __fastcall CheckCont(void);
	void __fastcall GetHelpClick(System::TObject* Sender);
	void __fastcall DoKeyDown(System::TObject* Sender, System::Word &Key, System::Classes::TShiftState Shift);
	void __fastcall OnShowAgain(System::TObject* Sender);
	
protected:
	virtual void __fastcall DefineProperties(System::Classes::TFiler* Filer);
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation Operation);
	bool __fastcall UseXP(void);
	
public:
	__fastcall virtual TLMDMessageBoxDlg(System::Classes::TComponent* aOwner);
	__fastcall virtual ~TLMDMessageBoxDlg(void);
	System::Uitypes::TModalResult __fastcall Execute(System::UnicodeString Caption, System::UnicodeString MessageTxt, const System::TVarRec *Params, const int Params_High, System::Uitypes::TMsgDlgButtons Buttons = System::Uitypes::TMsgDlgButtons() , int Kind = 0xffffffff, int HelpCtx = 0xffffffff, int X = 0xffffffff, int Y = 0xffffffff, int DefaultBtn = 0x0)/* overload */;
	System::Uitypes::TModalResult __fastcall Execute(System::UnicodeString Caption, System::UnicodeString MessageTxt, System::Uitypes::TMsgDlgButtons Buttons = System::Uitypes::TMsgDlgButtons() , int Kind = 0xffffffff, int HelpCtx = 0xffffffff, int X = 0xffffffff, int Y = 0xffffffff, int DefaultBtn = 0x0)/* overload */;
	System::Uitypes::TModalResult __fastcall ExecuteWithDefaults(const System::UnicodeString MessageTxt, const System::UnicodeString Caption = System::UnicodeString(), System::Uitypes::TMsgDlgButtons Buttons = System::Uitypes::TMsgDlgButtons() , int Kind = 0xffffffff, int HelpCtx = 0xffffffff, int X = 0xffffffff, int Y = 0xffffffff, int DefaultBtn = 0x0);
	int __fastcall ShowMessage(const System::UnicodeString MessageTxt);
	System::Word __fastcall MessageDlg(const System::UnicodeString Msg, System::Uitypes::TMsgDlgType AType, System::Uitypes::TMsgDlgButtons AButtons, int HelpCtx);
	System::Word __fastcall MessageDlgPos(const System::UnicodeString Msg, System::Uitypes::TMsgDlgType AType, System::Uitypes::TMsgDlgButtons AButtons, int HelpCtx, int X, int Y);
	void __fastcall ShowMessageFmt(const System::UnicodeString Msg, const System::TVarRec *Params, const int Params_High);
	int __fastcall MessageBox(System::WideChar * Text, System::WideChar * Caption, int Flags)/* overload */;
	int __fastcall MessageBox(System::WideChar * Text, System::WideChar * Caption)/* overload */;
	int __fastcall MessageBox(System::WideChar * Text, int Flags)/* overload */;
	int __fastcall MessageBox(System::WideChar * Text)/* overload */;
	__property Lmdbuttonbase::TLMDNormalButtonStyle ButtonStyle = {read=FButtonStyle, write=FButtonStyle, default=0};
	
__published:
	__property bool CtlXP = {read=FCtlXP, write=FCtlXP, default=1};
	__property System::Classes::TNotifyEvent OnCustomize = {read=FOnCustomize, write=FOnCustomize};
	__property Lmdbuttonbase::TLMDUserButtonStyle ButtonsStyle = {read=FButtonsStyle, write=FButtonsStyle, default=1};
	__property int ShowAgainOffsetX = {read=FShowAgainOffsetX, write=FShowAgainOffsetX, default=0};
	__property int ShowAgainOffsetY = {read=FShowAgainOffsetY, write=FShowAgainOffsetY, default=0};
	__property Lmd3dcaption::TLMD3DCaption* MessageFont3D = {read=FMessageF3D, write=SetFont3D, index=0};
	__property Lmd3dcaption::TLMD3DCaption* CaptionFont3D = {read=FCaption3D, write=SetFont3D, index=1};
	__property Lmdglyphtextlayout::TLMDGlyphTextLayout* MessageAlignment = {read=FMessageAlign, write=SetAlignment};
	__property Vcl::Graphics::TFont* MessageFont = {read=FMessageFont, write=SetFont, index=0};
	__property Vcl::Graphics::TFont* CaptionFont = {read=FCaptionFont, write=SetFont, index=1};
	__property System::Uitypes::TColor Color = {read=FColor, write=FColor, default=-16777201};
	__property Vcl::Graphics::TFont* ButtonFont = {read=FButtonFont, write=SetFont, index=2};
	__property System::UnicodeString CaptionTitle = {read=FCaptionTitle, write=SetCaptionTitle};
	__property System::Classes::TAlignment CaptionAlignment = {read=FCaptionAlignment, write=FCaptionAlignment, default=0};
	__property System::Classes::TStringList* ButtonTitles = {read=FButtonTitles, write=SetStringList, index=0};
	__property System::Classes::TStringList* Hints = {read=FHints, write=SetStringList, index=1};
	__property Vcl::Imglist::TCustomImageList* CustomGlyphImageList = {read=FCustomGlyphImageList, write=SetCustomGlyphImageList};
	__property int CustomGlyphListIndex = {read=FCustomGlyphListIndex, write=SetCustomGlyphListIndex, nodefault};
	__property int CustomGlyphImageIndex = {read=FCustomGlyphImageIndex, write=SetCustomGlyphImageIndex, nodefault};
	__property bool CustomGlyph = {read=FCustomGlyph, write=SetBool, index=1, default=0};
	__property System::Uitypes::TMsgDlgButtons Buttons = {read=FButtons, write=SetButtons, default=4};
	__property int BoxLeft = {read=FLeft, write=SetInteger, index=0, default=0};
	__property int BoxTop = {read=FTop, write=SetInteger, index=1, default=0};
	__property int BoxWidth = {read=FWidth, write=SetInteger, index=2, default=0};
	__property int BoxHeight = {read=FHeight, write=SetInteger, index=3, default=0};
	__property bool ShowHints = {read=FParentShowHint, write=SetBool, index=0, default=0};
	__property Lmdclass::TLMDDlgPosition Position = {read=FPosition, write=SetBoxPos, default=5};
	__property Lmdclass::TLMDDlgPosRel RelatePos = {read=FBoxRel, write=SetBoxRel, default=0};
	__property bool PlayWave = {read=FPlayWave, write=SetBool, index=2, default=0};
	__property bool ShowAgain = {read=FShowAgain, write=FShowAgain, default=1};
	__property bool ShowAgainBox = {read=FShowAgainBox, write=FShowAgainBox, default=0};
	__property bool CaptionFill = {read=FFillCaption, write=SetBool, index=3, default=0};
	__property int Colors = {read=FColors, write=SetInteger, index=5, default=32};
	__property System::Uitypes::TMsgDlgType DlgType = {read=FDlgType, write=FDlgType, default=4};
	__property ImageList;
	__property ListIndex = {index=1, default=0};
	__property ImageIndex = {index=0, default=0};
	__property Lmdwavelist::TLMDWaveList* WaveList = {read=FWaveList, write=SetWaveList};
	__property int WaveIndex = {read=FWaveListIndex, write=SetInteger, index=4, default=0};
	__property About = {default=0};
	__property System::Classes::TNotifyEvent OnHelpClick = {read=FOnHelpClick, write=FOnHelpClick};
};


//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE System::Uitypes::TModalResult __fastcall LMDExecuteMsg(const System::UnicodeString Caption, const System::UnicodeString MessageTxt, const System::TVarRec *Params, const int Params_High, System::Uitypes::TMsgDlgButtons Buttons, int Kind, int HelpCtx, int X, int Y, int DefaultBtn);
extern DELPHI_PACKAGE void __fastcall LMDShowMessage(const System::UnicodeString MessageTxt);
extern DELPHI_PACKAGE System::Word __fastcall LMDMessageDlg(const System::UnicodeString Msg, System::Uitypes::TMsgDlgType AType, System::Uitypes::TMsgDlgButtons AButtons, int HelpCtx);
extern DELPHI_PACKAGE System::Word __fastcall LMDMessageDlgPos(const System::UnicodeString Msg, System::Uitypes::TMsgDlgType AType, System::Uitypes::TMsgDlgButtons AButtons, int HelpCtx, int X, int Y);
extern DELPHI_PACKAGE void __fastcall LMDShowMessageFmt(const System::UnicodeString Msg, const System::TVarRec *Params, const int Params_High);
extern DELPHI_PACKAGE int __fastcall LMDMessageBox(System::WideChar * Text, System::WideChar * Caption, int Flags);
}	/* namespace Lmdmsg */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDMSG)
using namespace Lmdmsg;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdmsgHPP
