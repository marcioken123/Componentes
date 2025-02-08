// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'ElNameEdits.pas' rev: 31.00 (Windows)

#ifndef ElnameeditsHPP
#define ElnameeditsHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.SysUtils.hpp>
#include <ElPopBtn.hpp>
#include <ElFolderDlg.hpp>
#include <System.Classes.hpp>
#include <ElShellUtils.hpp>
#include <ElBtnEdit.hpp>
#include <Vcl.Forms.hpp>
#include <Vcl.Menus.hpp>
#include <Vcl.Controls.hpp>
#include <Winapi.Windows.hpp>
#include <Winapi.CommDlg.hpp>
#include <Vcl.Graphics.hpp>
#include <System.Types.hpp>
#include <Vcl.Dialogs.hpp>
#include <LMDTypes.hpp>
#include <LMDUnicodeDialogs.hpp>
#include <ElVCLUtils.hpp>
#include <ElEdits.hpp>
#include <System.UITypes.hpp>
#include <ElXPThemedControl.hpp>
#include <ElSBCtrl.hpp>
#include <LMDGraph.hpp>
#include <ElImgFrm.hpp>
#include <ElSndMap.hpp>
#include <LMDPNGImage.hpp>

//-- user supplied -----------------------------------------------------------

namespace Elnameedits
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TElFolderNameEdit;
class DELPHICLASS TElFileNameEdit;
//-- type declarations -------------------------------------------------------
typedef void __fastcall (__closure *TBeforeFileDialogEvent)(System::TObject* Sender, Vcl::Dialogs::TOpenDialog* Dialog);

typedef void __fastcall (__closure *TBeforeFolderDialogEvent)(System::TObject* Sender, Elfolderdlg::TElFolderDialog* Dialog);

class PASCALIMPLEMENTATION TElFolderNameEdit : public Elbtnedit::TCustomElButtonEdit
{
	typedef Elbtnedit::TCustomElButtonEdit inherited;
	
private:
	Elfolderdlg::TElFolderDialog* FileDlg;
	Elfolderdlg::TBrowseForFolderOptions __fastcall GetOptions(void);
	Lmdtypes::TLMDString __fastcall GetTitle(void);
	void __fastcall SetOptions(Elfolderdlg::TBrowseForFolderOptions Value);
	void __fastcall SetTitle(const Lmdtypes::TLMDString Value);
	void __fastcall SetRootFolder(Elshellutils::TShellFolders Value);
	Elshellutils::TShellFolders __fastcall GetRootFolder(void);
	
protected:
	Lmdtypes::TLMDString FDialogTitle;
	System::Classes::TNotifyEvent FOnDialogExecute;
	TBeforeFolderDialogEvent FOnBeforeDialogExecute;
	Lmdtypes::TLMDString FPrompt;
	void __fastcall BtnClick(System::TObject* Sender);
	virtual void __fastcall CreateHandle(void);
	virtual void __fastcall Loaded(void);
	void __fastcall SetStatusText(const Lmdtypes::TLMDString Value);
	Lmdtypes::TLMDString __fastcall GetStatusText(void);
	Lmdtypes::TLMDString __fastcall GetCustomRootFolder(void);
	void __fastcall SetCustomRootFolder(const Lmdtypes::TLMDString Value);
	virtual void __fastcall TriggerBeforeDialogExecute(Elfolderdlg::TElFolderDialog* Dialog);
	virtual void __fastcall TriggerDialogExecute(void);
	void __fastcall SetPrompt(const Lmdtypes::TLMDString Value);
	virtual void __fastcall SetReadOnly(bool newValue);
	
public:
	__fastcall virtual TElFolderNameEdit(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TElFolderNameEdit(void);
	
__published:
	__property Elfolderdlg::TBrowseForFolderOptions Options = {read=GetOptions, write=SetOptions, nodefault};
	__property Lmdtypes::TLMDString Title = {read=GetTitle, write=SetTitle, stored=false};
	__property Elshellutils::TShellFolders RootFolder = {read=GetRootFolder, write=SetRootFolder, nodefault};
	__property Lmdtypes::TLMDString DialogTitle = {read=GetTitle, write=SetTitle};
	__property Lmdtypes::TLMDString StatusText = {read=GetStatusText, write=SetStatusText};
	__property Lmdtypes::TLMDString CustomRootFolder = {read=GetCustomRootFolder, write=SetCustomRootFolder};
	__property TBeforeFolderDialogEvent OnBeforeDialogExecute = {read=FOnBeforeDialogExecute, write=FOnBeforeDialogExecute};
	__property System::Classes::TNotifyEvent OnDialogExecute = {read=FOnDialogExecute, write=FOnDialogExecute};
	__property Lmdtypes::TLMDString Prompt = {read=FPrompt, write=SetPrompt};
	__property VertScrollBarStyles;
	__property HorzScrollBarStyles;
	__property UseCustomScrollBars = {default=1};
	__property ButtonVisible = {default=1};
	__property TopMargin = {default=0};
	__property LeftMargin = {default=1};
	__property RightMargin = {default=1};
	__property BorderSides = {default=15};
	__property MaxLength = {default=0};
	__property Transparent = {default=0};
	__property HandleDialogKeys = {default=0};
	__property FocusedSelectColor = {default=-16777203};
	__property FocusedSelectTextColor = {default=-16777202};
	__property HideSelection = {default=1};
	__property HideSelectColor = {default=-16777201};
	__property HideSelectTextColor = {default=-16777200};
	__property HighlightAlphaLevel = {default=255};
	__property LineBorderActiveColor = {default=-16777201};
	__property LineBorderInactiveColor = {default=-16777201};
	__property ImageForm;
	__property OnMouseEnter;
	__property OnMouseLeave;
	__property OnResize;
	__property OnChange;
	__property OnSelectionChange;
	__property LinkedControl;
	__property LinkedControlPosition = {default=3};
	__property LinkedControlSpacing = {default=0};
	__property UseDisabledColors = {default=0};
	__property DisabledColor = {default=-16777201};
	__property DisabledFontColor = {default=-16777199};
	__property Text;
	__property Flat = {default=0};
	__property ActiveBorderType = {default=1};
	__property InactiveBorderType = {default=3};
	__property UseBackground = {default=0};
	__property UseSystemMenu = {default=1};
	__property Alignment = {default=0};
	__property AutoSelect = {default=0};
	__property Background;
	__property ButtonClickSound = {default=0};
	__property ButtonDownSound = {default=0};
	__property ButtonUpSound = {default=0};
	__property ButtonSoundMap;
	__property ButtonColor = {default=-16777201};
	__property ButtonFlat = {default=0};
	__property ButtonHint = {default=0};
	__property ButtonShortcut = {default=32808};
	__property ButtonGlyph;
	__property ButtonIcon;
	__property ButtonUseIcon = {default=0};
	__property ButtonNumGlyphs = {default=1};
	__property ButtonWidth = {default=-1};
	__property ButtonShowBorder = {default=1};
	__property ButtonThinFrame = {default=0};
	__property ButtonOldStyled = {default=0};
	__property AltButtonCaption = {default=0};
	__property AltButtonClickSound = {default=0};
	__property AltButtonDownSound = {default=0};
	__property AltButtonUpSound = {default=0};
	__property AltButtonSoundMap;
	__property AltButtonDown = {default=0};
	__property AltButtonEnabled = {default=1};
	__property AltButtonFlat = {default=0};
	__property AltButtonGlyph;
	__property AltButtonHint = {default=0};
	__property AltButtonIcon;
	__property AltButtonUseIcon = {default=0};
	__property AltButtonNumGlyphs = {default=1};
	__property AltButtonPopupPlace = {default=0};
	__property AltButtonPosition = {default=1};
	__property AltButtonPullDownMenu;
	__property AltButtonShortcut = {default=0};
	__property AltButtonVisible = {default=0};
	__property AltButtonWidth = {default=-1};
	__property AltButtonShowBorder = {default=1};
	__property AltButtonThinFrame = {default=0};
	__property AltButtonOldStyled = {default=0};
	__property AltButtonPngGlyph;
	__property AltButtonUsePng;
	__property OnAltButtonClick;
	__property AutoSize = {default=1};
	__property BorderStyle = {default=1};
	__property Ctl3D = {default=1};
	__property ParentCtl3D = {default=0};
	__property Enabled = {default=1};
	__property TabStop = {default=1};
	__property TabOrder = {default=-1};
	__property PopupMenu;
	__property Color = {default=-16777211};
	__property ParentColor = {default=0};
	__property Align = {default=0};
	__property Font;
	__property ParentFont = {default=1};
	__property ParentShowHint = {default=1};
	__property ShowHint;
	__property Visible = {default=1};
	__property ReadOnly = {default=0};
	__property OnEnter;
	__property OnExit;
	__property OnClick;
	__property OnDblClick;
	__property OnKeyDown;
	__property OnKeyPress;
	__property OnKeyUp;
	__property OnStartDrag;
	__property OnDragDrop;
	__property OnDragOver;
	__property OnEndDock;
	__property OnEndDrag;
	__property OnMouseDown;
	__property OnMouseMove;
	__property OnMouseUp;
	__property OnStartDock;
	__property Anchors = {default=3};
	__property Constraints;
	__property DockOrientation;
	__property Floating;
	__property DoubleBuffered;
	__property DragKind = {default=0};
public:
	/* TWinControl.CreateParented */ inline __fastcall TElFolderNameEdit(HWND ParentWindow) : Elbtnedit::TCustomElButtonEdit(ParentWindow) { }
	
};


enum DECLSPEC_DENUM TElFileDialogType : unsigned char { fdtOpen, fdtSave };

class PASCALIMPLEMENTATION TElFileNameEdit : public Elbtnedit::TCustomElButtonEdit
{
	typedef Elbtnedit::TCustomElButtonEdit inherited;
	
private:
	Vcl::Dialogs::TOpenDialog* FileDlg;
	int __fastcall GetFilterIndex(void);
	void __fastcall SetHistoryList(System::Classes::TStrings* Value);
	void __fastcall SetInitialDir(const Lmdtypes::TLMDString Value);
	Lmdtypes::TLMDString __fastcall GetDefaultExt(void);
	void __fastcall SetDefaultExt(const Lmdtypes::TLMDString Value);
	System::Classes::TStrings* __fastcall GetFiles(void);
	System::Classes::TStrings* __fastcall GetHistoryList(void);
	Lmdtypes::TLMDString __fastcall GetInitialDir(void);
	System::Uitypes::TOpenOptions __fastcall GetOptions(void);
	void __fastcall SetOptions(System::Uitypes::TOpenOptions Value);
	void __fastcall SetFilterIndex(int Value);
	Lmdtypes::TLMDString __fastcall GetTitle(void);
	void __fastcall SetTitle(const Lmdtypes::TLMDString Value);
	Lmdtypes::TLMDString __fastcall GetFilter(void);
	void __fastcall SetFilter(const Lmdtypes::TLMDString Value);
	
protected:
	bool OwnGlyphs;
	Lmdtypes::TLMDString FDialogTitle;
	TElFileDialogType FDialogType;
	System::Classes::TNotifyEvent FOnDialogExecute;
	bool FParseParameters;
	TBeforeFileDialogEvent FOnBeforeDialogExecute;
	void __fastcall BtnClick(System::TObject* Sender);
	virtual void __fastcall CreateHandle(void);
	virtual void __fastcall Loaded(void);
	virtual void __fastcall TriggerDialogExecute(void);
	virtual void __fastcall TriggerBeforeDialogExecute(Vcl::Dialogs::TOpenDialog* Dialog);
	void __fastcall UpdateGlyph(void);
	void __fastcall SetDialogType(TElFileDialogType Value);
	virtual void __fastcall SetButtonGlyph(Vcl::Graphics::TBitmap* newValue);
	virtual void __fastcall DefineProperties(System::Classes::TFiler* Filer);
	virtual void __fastcall SetReadOnly(bool newValue);
	
public:
	__fastcall virtual TElFileNameEdit(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TElFileNameEdit(void);
	__property System::Classes::TStrings* Files = {read=GetFiles};
	__property System::Classes::TStrings* HistoryList = {read=GetHistoryList, write=SetHistoryList};
	
__published:
	__property Lmdtypes::TLMDString DefaultExt = {read=GetDefaultExt, write=SetDefaultExt};
	__property Lmdtypes::TLMDString Filter = {read=GetFilter, write=SetFilter};
	__property int FilterIndex = {read=GetFilterIndex, write=SetFilterIndex, default=1};
	__property Lmdtypes::TLMDString InitialDir = {read=GetInitialDir, write=SetInitialDir};
	__property System::Uitypes::TOpenOptions Options = {read=GetOptions, write=SetOptions, default=524292};
	__property Lmdtypes::TLMDString Title = {read=GetTitle, write=SetTitle, stored=false};
	__property Lmdtypes::TLMDString DialogTitle = {read=GetTitle, write=SetTitle};
	__property TElFileDialogType DialogType = {read=FDialogType, write=SetDialogType, default=0};
	__property bool ParseParameters = {read=FParseParameters, write=FParseParameters, default=1};
	__property System::Classes::TNotifyEvent OnDialogExecute = {read=FOnDialogExecute, write=FOnDialogExecute};
	__property TBeforeFileDialogEvent OnBeforeDialogExecute = {read=FOnBeforeDialogExecute, write=FOnBeforeDialogExecute};
	__property VertScrollBarStyles;
	__property HorzScrollBarStyles;
	__property UseCustomScrollBars = {default=1};
	__property ButtonVisible = {default=1};
	__property TopMargin = {default=0};
	__property LeftMargin = {default=1};
	__property RightMargin = {default=1};
	__property BorderSides = {default=15};
	__property MaxLength = {default=0};
	__property Transparent = {default=0};
	__property HandleDialogKeys = {default=0};
	__property FocusedSelectColor = {default=-16777203};
	__property FocusedSelectTextColor = {default=-16777202};
	__property HideSelection = {default=1};
	__property HideSelectColor = {default=-16777201};
	__property HideSelectTextColor = {default=-16777200};
	__property HighlightAlphaLevel = {default=255};
	__property LineBorderActiveColor = {default=-16777201};
	__property LineBorderInactiveColor = {default=-16777201};
	__property ImageForm;
	__property OnMouseEnter;
	__property OnMouseLeave;
	__property OnResize;
	__property OnChange;
	__property OnSelectionChange;
	__property LinkedControl;
	__property LinkedControlPosition = {default=3};
	__property LinkedControlSpacing = {default=0};
	__property Text;
	__property UseDisabledColors = {default=0};
	__property DisabledColor = {default=-16777201};
	__property DisabledFontColor = {default=-16777199};
	__property Flat = {default=0};
	__property ActiveBorderType = {default=1};
	__property InactiveBorderType = {default=3};
	__property UseSystemMenu = {default=1};
	__property UseBackground = {default=0};
	__property Alignment = {default=0};
	__property AutoSelect = {default=0};
	__property Background;
	__property ButtonClickSound = {default=0};
	__property ButtonDownSound = {default=0};
	__property ButtonUpSound = {default=0};
	__property ButtonSoundMap;
	__property ButtonColor = {default=-16777201};
	__property ButtonFlat = {default=0};
	__property ButtonHint = {default=0};
	__property ButtonShortcut = {default=32808};
	__property ButtonGlyph;
	__property ButtonIcon;
	__property ButtonUseIcon = {default=0};
	__property ButtonNumGlyphs = {default=1};
	__property ButtonWidth = {default=-1};
	__property ButtonShowBorder = {default=1};
	__property ButtonThinFrame = {default=0};
	__property ButtonOldStyled = {default=0};
	__property AltButtonCaption = {default=0};
	__property AltButtonClickSound = {default=0};
	__property AltButtonDownSound = {default=0};
	__property AltButtonUpSound = {default=0};
	__property AltButtonSoundMap;
	__property AltButtonDown = {default=0};
	__property AltButtonEnabled = {default=1};
	__property AltButtonFlat = {default=0};
	__property AltButtonGlyph;
	__property AltButtonHint = {default=0};
	__property AltButtonIcon;
	__property AltButtonNumGlyphs = {default=1};
	__property AltButtonPopupPlace = {default=0};
	__property AltButtonPosition = {default=1};
	__property AltButtonPullDownMenu;
	__property AltButtonShortcut = {default=0};
	__property AltButtonUseIcon = {default=0};
	__property AltButtonVisible = {default=0};
	__property AltButtonWidth = {default=-1};
	__property AltButtonShowBorder = {default=1};
	__property AltButtonThinFrame = {default=0};
	__property AltButtonOldStyled = {default=0};
	__property OnAltButtonClick;
	__property AutoSize = {default=1};
	__property BorderStyle = {default=1};
	__property Ctl3D;
	__property ParentCtl3D = {default=1};
	__property Enabled = {default=1};
	__property TabStop = {default=1};
	__property TabOrder = {default=-1};
	__property PopupMenu;
	__property Color = {default=-16777211};
	__property ParentColor = {default=1};
	__property Align = {default=0};
	__property Font;
	__property ParentFont = {default=1};
	__property ParentShowHint = {default=1};
	__property ShowHint;
	__property Visible = {default=1};
	__property ReadOnly = {default=0};
	__property OnEnter;
	__property OnExit;
	__property OnClick;
	__property OnDblClick;
	__property OnKeyDown;
	__property OnKeyPress;
	__property OnKeyUp;
	__property OnStartDrag;
	__property OnDragDrop;
	__property OnDragOver;
	__property OnEndDock;
	__property OnEndDrag;
	__property OnMouseDown;
	__property OnMouseMove;
	__property OnMouseUp;
	__property OnStartDock;
	__property Anchors = {default=3};
	__property Constraints;
	__property DockOrientation;
	__property Floating;
	__property DoubleBuffered;
	__property DragKind = {default=0};
public:
	/* TWinControl.CreateParented */ inline __fastcall TElFileNameEdit(HWND ParentWindow) : Elbtnedit::TCustomElButtonEdit(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Elnameedits */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_ELNAMEEDITS)
using namespace Elnameedits;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// ElnameeditsHPP
