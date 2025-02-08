// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'ElDBBtnEdit.pas' rev: 31.00 (Windows)

#ifndef EldbbtneditHPP
#define EldbbtneditHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Vcl.Forms.hpp>
#include <Winapi.Windows.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.StdCtrls.hpp>
#include <Winapi.Messages.hpp>
#include <Vcl.Menus.hpp>
#include <Data.DB.hpp>
#include <Vcl.DBCtrls.hpp>
#include <System.Classes.hpp>
#include <System.SysUtils.hpp>
#include <System.Types.hpp>
#include <LMDTypes.hpp>
#include <LMDUnicode.hpp>
#include <ElDBCtrls.hpp>
#include <ElBtnEdit.hpp>
#include <LMDElDBConst.hpp>
#include <ElEdits.hpp>
#include <ElXPThemedControl.hpp>
#include <ElVCLUtils.hpp>
#include <LMDGraph.hpp>
#include <ElImgFrm.hpp>
#include <System.UITypes.hpp>
#include <Vcl.Graphics.hpp>
#include <ElSndMap.hpp>
#include <ElPopBtn.hpp>

//-- user supplied -----------------------------------------------------------

namespace Eldbbtnedit
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TElDBButtonEdit;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TElDBButtonEdit : public Elbtnedit::TCustomElButtonEdit
{
	typedef Elbtnedit::TCustomElButtonEdit inherited;
	
private:
	Vcl::Dbctrls::TFieldDataLink* FDataLink;
	System::Classes::TShortCut FNullValueKey;
	void __fastcall ActiveChange(System::TObject* Sender);
	void __fastcall DataChange(System::TObject* Sender);
	void __fastcall EditingChange(System::TObject* Sender);
	System::UnicodeString __fastcall GetDataField(void);
	Data::Db::TDataSource* __fastcall GetDataSource(void);
	Data::Db::TField* __fastcall GetField(void);
	void __fastcall ResetMaxLength(void);
	void __fastcall SetDataField(const System::UnicodeString Value);
	void __fastcall SetDataSource(Data::Db::TDataSource* Value);
	void __fastcall UpdateData(System::TObject* Sender);
	HIDESBASE MESSAGE void __fastcall CMExit(Winapi::Messages::TWMNoParams &Message);
	MESSAGE void __fastcall CMGetDataLink(Winapi::Messages::TMessage &Message);
	bool __fastcall GetDBReadOnlyState(void);
	
protected:
	Lmdeldbconst::TElDBUnicodeMode FUnicodeMode;
	virtual void __fastcall Change(void);
	DYNAMIC void __fastcall KeyDown(System::Word &Key, System::Classes::TShiftState Shift);
	DYNAMIC void __fastcall KeyPress(System::WideChar &Key);
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation Operation);
	virtual void __fastcall Loaded(void);
	
public:
	__fastcall virtual TElDBButtonEdit(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TElDBButtonEdit(void);
	DYNAMIC bool __fastcall ExecuteAction(System::Classes::TBasicAction* Action);
	virtual bool __fastcall UpdateAction(System::Classes::TBasicAction* Action);
	DYNAMIC bool __fastcall UseRightToLeftAlignment(void);
	__property Data::Db::TField* Field = {read=GetField};
	__property Text;
	__property Lines;
	
__published:
	__property System::Classes::TShortCut NullValueKey = {read=FNullValueKey, write=FNullValueKey, default=0};
	__property System::UnicodeString DataField = {read=GetDataField, write=SetDataField};
	__property Data::Db::TDataSource* DataSource = {read=GetDataSource, write=SetDataSource};
	__property DisplayReadOnlyOptions;
	__property TopMargin = {default=0};
	__property LeftMargin = {default=1};
	__property RightMargin = {default=1};
	__property AutoSize = {default=1};
	__property RightAlignedText = {default=0};
	__property RightAlignedView = {default=0};
	__property BorderSides = {default=15};
	__property PasswordChar = {default=0};
	__property MaxLength = {default=0};
	__property Transparent = {default=0};
	__property FlatFocusedScrollBars = {default=0};
	__property WantTabs = {default=0};
	__property HandleDialogKeys = {default=0};
	__property HideSelection = {default=1};
	__property TabSpaces = {default=4};
	__property ImageForm;
	__property WordWrap = {default=0};
	__property ScrollBars = {default=0};
	__property OnMouseEnter;
	__property OnMouseLeave;
	__property OnResize;
	__property OnChange;
	__property OnSelectionChange;
	__property Multiline = {default=0};
	__property StressShortCut = {default=0};
	__property Flat = {default=0};
	__property ActiveBorderType = {default=1};
	__property InactiveBorderType = {default=3};
	__property LineBorderActiveColor = {default=-16777201};
	__property LineBorderInactiveColor = {default=-16777201};
	__property UseBackground = {default=0};
	__property Alignment = {default=0};
	__property AutoSelect = {default=0};
	__property Background;
	__property ButtonCaption = {default=0};
	__property ButtonClickSound = {default=0};
	__property ButtonDownSound = {default=0};
	__property ButtonUpSound = {default=0};
	__property ButtonSoundMap;
	__property ButtonColor = {default=-16777201};
	__property ButtonDown = {default=0};
	__property ButtonEnabled = {default=1};
	__property ButtonFlat = {default=0};
	__property ButtonGlyph;
	__property ButtonHint = {default=0};
	__property ButtonIcon;
	__property ButtonNumGlyphs = {default=1};
	__property ButtonPopupPlace = {default=0};
	__property ButtonPullDownMenu;
	__property ButtonShortcut = {default=0};
	__property ButtonUseIcon = {default=0};
	__property ButtonVisible = {default=1};
	__property ButtonWidth = {default=-1};
	__property OnButtonClick;
	__property AltButtonCaption = {default=0};
	__property AltButtonClickSound = {default=0};
	__property AltButtonDownSound = {default=0};
	__property AltButtonUpSound = {default=0};
	__property AltButtonSoundMap;
	__property AltButtonColor = {default=-16777201};
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
	__property OnAltButtonClick;
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
	__property ReadOnly = {default=1};
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
	__property Lmdeldbconst::TElDBUnicodeMode UnicodeMode = {read=FUnicodeMode, write=FUnicodeMode, default=0};
public:
	/* TWinControl.CreateParented */ inline __fastcall TElDBButtonEdit(HWND ParentWindow) : Elbtnedit::TCustomElButtonEdit(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Eldbbtnedit */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_ELDBBTNEDIT)
using namespace Eldbbtnedit;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// EldbbtneditHPP
