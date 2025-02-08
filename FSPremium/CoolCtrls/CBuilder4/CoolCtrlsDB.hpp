// Borland C++ Builder
// Copyright (c) 1995, 1999 by Borland International
// All rights reserved

// (DO NOT EDIT: machine generated header) 'CoolCtrlsDB.pas' rev: 4.00

#ifndef CoolCtrlsDBHPP
#define CoolCtrlsDBHPP

#pragma delphiheader begin
#pragma option push -w-
#include <Menus.hpp>	// Pascal unit
#include <CoolCtrls.hpp>	// Pascal unit
#include <ExtCtrls.hpp>	// Pascal unit
#include <ToolWin.hpp>	// Pascal unit
#include <DBGrids.hpp>	// Pascal unit
#include <Grids.hpp>	// Pascal unit
#include <CoolUtils.hpp>	// Pascal unit
#include <SysUtils.hpp>	// Pascal unit
#include <Db.hpp>	// Pascal unit
#include <DBCtrls.hpp>	// Pascal unit
#include <Forms.hpp>	// Pascal unit
#include <Controls.hpp>	// Pascal unit
#include <StdCtrls.hpp>	// Pascal unit
#include <Graphics.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Messages.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <Dialogs.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <System.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Coolctrlsdb
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TDBCoolCheckRadioBox;
#pragma pack(push, 4)
class PASCALIMPLEMENTATION TDBCoolCheckRadioBox : public Coolctrls::TCoolCheckRadioBox 
{
	typedef Coolctrls::TCoolCheckRadioBox inherited;
	
private:
	Dbctrls::TFieldDataLink* FDataLink;
	AnsiString FValueCheck;
	AnsiString FValueUncheck;
	void __fastcall DataChange(System::TObject* Sender);
	AnsiString __fastcall GetDataField();
	Db::TDataSource* __fastcall GetDataSource(void);
	Db::TField* __fastcall GetField(void);
	Stdctrls::TCheckBoxState __fastcall GetFieldState(void);
	bool __fastcall GetReadOnly(void);
	void __fastcall SetDataField(const AnsiString Value);
	void __fastcall SetDataSource(Db::TDataSource* Value);
	void __fastcall SetReadOnly(bool Value);
	void __fastcall SetValueCheck(const AnsiString Value);
	void __fastcall SetValueUncheck(const AnsiString Value);
	void __fastcall UpdateData(System::TObject* Sender);
	bool __fastcall ValueMatch(const AnsiString ValueList, const AnsiString Value);
	HIDESBASE MESSAGE void __fastcall WMPaint(Messages::TWMPaint &Message);
	HIDESBASE MESSAGE void __fastcall CMExit(Messages::TWMNoParams &Message);
	MESSAGE void __fastcall CMGetDataLink(Messages::TMessage &Message);
	
protected:
	virtual bool __fastcall Toggle(void);
	DYNAMIC void __fastcall KeyPress(char &Key);
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation Operation
		);
	virtual void __fastcall WndProc(Messages::TMessage &Message);
	
public:
	__fastcall virtual TDBCoolCheckRadioBox(Classes::TComponent* AOwner);
	__fastcall virtual ~TDBCoolCheckRadioBox(void);
	DYNAMIC bool __fastcall ExecuteAction(Classes::TBasicAction* Action);
	DYNAMIC bool __fastcall UpdateAction(Classes::TBasicAction* Action);
	DYNAMIC bool __fastcall UseRightToLeftAlignment(void);
	__property Checked ;
	__property State ;
	__property Db::TField* Field = {read=GetField};
	
__published:
	__property AnsiString DataField = {read=GetDataField, write=SetDataField};
	__property Db::TDataSource* DataSource = {read=GetDataSource, write=SetDataSource};
	__property bool ReadOnly = {read=GetReadOnly, write=SetReadOnly, default=0};
	__property AnsiString ValueChecked = {read=FValueCheck, write=SetValueCheck};
	__property AnsiString ValueUnchecked = {read=FValueUncheck, write=SetValueUncheck};
public:
	#pragma option push -w-inl
	/* TWinControl.CreateParented */ inline __fastcall TDBCoolCheckRadioBox(HWND ParentWindow) : Coolctrls::TCoolCheckRadioBox(
		ParentWindow) { }
	#pragma option pop
	
};

#pragma pack(pop)

class DELPHICLASS TDBCoolCheckRadioGroup;
#pragma pack(push, 4)
class PASCALIMPLEMENTATION TDBCoolCheckRadioGroup : public Coolctrls::TCustomCoolCheckRadioGroup 
{
	typedef Coolctrls::TCustomCoolCheckRadioGroup inherited;
	
private:
	Dbctrls::TFieldDataLink* FDataLink;
	AnsiString FValue;
	Classes::TStrings* FValues;
	bool FInSetValue;
	Classes::TNotifyEvent FOnChange;
	void __fastcall DataChange(System::TObject* Sender);
	void __fastcall UpdateData(System::TObject* Sender);
	AnsiString __fastcall GetDataField();
	Db::TDataSource* __fastcall GetDataSource(void);
	Db::TField* __fastcall GetField(void);
	bool __fastcall GetReadOnly(void);
	AnsiString __fastcall GetButtonValue(int Index);
	void __fastcall SetDataField(const AnsiString Value);
	void __fastcall SetDataSource(Db::TDataSource* Value);
	void __fastcall SetReadOnly(bool Value);
	void __fastcall SetValue(const AnsiString Value);
	HIDESBASE void __fastcall SetItems(Classes::TStrings* Value);
	void __fastcall SetValues(Classes::TStrings* Value);
	HIDESBASE MESSAGE void __fastcall CMExit(Messages::TWMNoParams &Message);
	
protected:
	DYNAMIC void __fastcall Change(void);
	DYNAMIC void __fastcall Click(void);
	DYNAMIC void __fastcall KeyPress(char &Key);
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation Operation
		);
	__property Dbctrls::TFieldDataLink* DataLink = {read=FDataLink};
	
public:
	__fastcall virtual TDBCoolCheckRadioGroup(Classes::TComponent* AOwner);
	__fastcall virtual ~TDBCoolCheckRadioGroup(void);
	DYNAMIC bool __fastcall ExecuteAction(Classes::TBasicAction* Action);
	DYNAMIC bool __fastcall UpdateAction(Classes::TBasicAction* Action);
	DYNAMIC bool __fastcall UseRightToLeftAlignment(void);
	__property Db::TField* Field = {read=GetField};
	__property ItemIndex ;
	__property AnsiString Value = {read=FValue, write=SetValue};
	
__published:
	__property AnsiString DataField = {read=GetDataField, write=SetDataField};
	__property Db::TDataSource* DataSource = {read=GetDataSource, write=SetDataSource};
	__property Items  = {write=SetItems};
	__property bool ReadOnly = {read=GetReadOnly, write=SetReadOnly, default=0};
	__property Classes::TStrings* Values = {read=FValues, write=SetValues};
	__property Classes::TNotifyEvent OnChange = {read=FOnChange, write=FOnChange};
	__property Columns ;
	__property GlyphMarked ;
	__property GlyphNormal ;
	__property Flat ;
public:
	#pragma option push -w-inl
	/* TWinControl.CreateParented */ inline __fastcall TDBCoolCheckRadioGroup(HWND ParentWindow) : Coolctrls::TCustomCoolCheckRadioGroup(
		ParentWindow) { }
	#pragma option pop
	
};

#pragma pack(pop)

class DELPHICLASS TDBCoolListBox;
#pragma pack(push, 4)
class PASCALIMPLEMENTATION TDBCoolListBox : public Coolctrls::TCoolListBox 
{
	typedef Coolctrls::TCoolListBox inherited;
	
private:
	Dbctrls::TFieldDataLink* FDataLink;
	void __fastcall DataChange(System::TObject* Sender);
	void __fastcall UpdateData(System::TObject* Sender);
	AnsiString __fastcall GetDataField();
	Db::TDataSource* __fastcall GetDataSource(void);
	Db::TField* __fastcall GetField(void);
	bool __fastcall GetReadOnly(void);
	void __fastcall SetDataField(const AnsiString Value);
	void __fastcall SetDataSource(Db::TDataSource* Value);
	void __fastcall SetReadOnly(bool Value);
	HIDESBASE void __fastcall SetItems(Classes::TStrings* Value);
	HIDESBASE MESSAGE void __fastcall WMLButtonDown(Messages::TWMMouse &Message);
	HIDESBASE MESSAGE void __fastcall CMExit(Messages::TWMNoParams &Message);
	
protected:
	DYNAMIC void __fastcall Click(void);
	DYNAMIC void __fastcall KeyDown(Word &Key, Classes::TShiftState Shift);
	DYNAMIC void __fastcall KeyPress(char &Key);
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation Operation
		);
	
public:
	__fastcall virtual TDBCoolListBox(Classes::TComponent* AOwner);
	__fastcall virtual ~TDBCoolListBox(void);
	void __fastcall BuildItems(void);
	__property Db::TField* Field = {read=GetField};
	
__published:
	__property AnsiString DataField = {read=GetDataField, write=SetDataField};
	__property Db::TDataSource* DataSource = {read=GetDataSource, write=SetDataSource};
	__property Items  = {write=SetItems};
	__property bool ReadOnly = {read=GetReadOnly, write=SetReadOnly, default=0};
public:
	#pragma option push -w-inl
	/* TWinControl.CreateParented */ inline __fastcall TDBCoolListBox(HWND ParentWindow) : Coolctrls::TCoolListBox(
		ParentWindow) { }
	#pragma option pop
	
};

#pragma pack(pop)

class DELPHICLASS TDBCoolComboBox;
#pragma pack(push, 4)
class PASCALIMPLEMENTATION TDBCoolComboBox : public Coolctrls::TCoolComboBox 
{
	typedef Coolctrls::TCoolComboBox inherited;
	
private:
	Dbctrls::TFieldDataLink* FDataLink;
	void __fastcall DataChange(System::TObject* Sender);
	void __fastcall EditingChange(System::TObject* Sender);
	AnsiString __fastcall GetComboText();
	AnsiString __fastcall GetDataField();
	Db::TDataSource* __fastcall GetDataSource(void);
	Db::TField* __fastcall GetField(void);
	bool __fastcall GetReadOnly(void);
	void __fastcall SetComboText(const AnsiString Value);
	void __fastcall SetDataField(const AnsiString Value);
	void __fastcall SetDataSource(Db::TDataSource* Value);
	void __fastcall SetEditReadOnly(void);
	HIDESBASE void __fastcall SetItems(Classes::TStrings* Value);
	void __fastcall SetReadOnly(bool Value);
	void __fastcall UpdateData(System::TObject* Sender);
	HIDESBASE MESSAGE void __fastcall CMEnter(Messages::TWMNoParams &Message);
	HIDESBASE MESSAGE void __fastcall CMExit(Messages::TWMNoParams &Message);
	MESSAGE void __fastcall CMGetDataLink(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall WMPaint(Messages::TWMPaint &Message);
	
protected:
	DYNAMIC void __fastcall Change(void);
	DYNAMIC void __fastcall Click(void);
	virtual void __fastcall ComboWndProc(Messages::TMessage &Message, HWND ComboWnd, void * ComboProc);
		
	virtual void __fastcall CreateWnd(void);
	DYNAMIC void __fastcall DropDown(void);
	DYNAMIC void __fastcall KeyDown(Word &Key, Classes::TShiftState Shift);
	DYNAMIC void __fastcall KeyPress(char &Key);
	virtual void __fastcall Loaded(void);
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation Operation
		);
	virtual void __fastcall SetStyle(Stdctrls::TComboBoxStyle Value);
	virtual void __fastcall WndProc(Messages::TMessage &Message);
	
public:
	__fastcall virtual TDBCoolComboBox(Classes::TComponent* AOwner);
	__fastcall virtual ~TDBCoolComboBox(void);
	void __fastcall BuildItems(void);
	__property Db::TField* Field = {read=GetField};
	__property Text ;
	
__published:
	__property AnsiString DataField = {read=GetDataField, write=SetDataField};
	__property Db::TDataSource* DataSource = {read=GetDataSource, write=SetDataSource};
	__property Items  = {write=SetItems};
	__property bool ReadOnly = {read=GetReadOnly, write=SetReadOnly, default=0};
public:
	#pragma option push -w-inl
	/* TWinControl.CreateParented */ inline __fastcall TDBCoolComboBox(HWND ParentWindow) : Coolctrls::TCoolComboBox(
		ParentWindow) { }
	#pragma option pop
	
};

#pragma pack(pop)

class DELPHICLASS TDBCoolEdit;
#pragma pack(push, 4)
class PASCALIMPLEMENTATION TDBCoolEdit : public Coolctrls::TCoolEdit 
{
	typedef Coolctrls::TCoolEdit inherited;
	
private:
	Dbctrls::TFieldDataLink* FDataLink;
	bool FFocused;
	void __fastcall DataChange(System::TObject* Sender);
	void __fastcall EditingChange(System::TObject* Sender);
	void __fastcall UpdateData(System::TObject* Sender);
	AnsiString __fastcall GetDataField();
	Db::TDataSource* __fastcall GetDataSource(void);
	Db::TField* __fastcall GetField(void);
	bool __fastcall GetReadOnly(void);
	void __fastcall SetDataField(const AnsiString Value);
	void __fastcall SetDataSource(Db::TDataSource* Value);
	void __fastcall SetFocused(bool Value);
	HIDESBASE void __fastcall SetReadOnly(bool Value);
	MESSAGE void __fastcall WMCut(Messages::TMessage &Message);
	MESSAGE void __fastcall WMPaste(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMEnter(Messages::TWMNoParams &Message);
	HIDESBASE MESSAGE void __fastcall CMExit(Messages::TWMNoParams &Message);
	MESSAGE void __fastcall CMGetDataLink(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall WMPaint(Messages::TWMPaint &Message);
	
protected:
	DYNAMIC void __fastcall Change(void);
	DYNAMIC void __fastcall KeyDown(Word &Key, Classes::TShiftState Shift);
	DYNAMIC void __fastcall KeyPress(char &Key);
	virtual void __fastcall Loaded(void);
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation Operation
		);
	
public:
	__fastcall virtual TDBCoolEdit(Classes::TComponent* AOwner);
	__fastcall virtual ~TDBCoolEdit(void);
	__property Db::TField* Field = {read=GetField};
	
__published:
	__property AnsiString DataField = {read=GetDataField, write=SetDataField};
	__property Db::TDataSource* DataSource = {read=GetDataSource, write=SetDataSource};
	__property bool ReadOnly = {read=GetReadOnly, write=SetReadOnly, default=0};
public:
	#pragma option push -w-inl
	/* TWinControl.CreateParented */ inline __fastcall TDBCoolEdit(HWND ParentWindow) : Coolctrls::TCoolEdit(
		ParentWindow) { }
	#pragma option pop
	
};

#pragma pack(pop)

class DELPHICLASS TDBCoolEditBtn;
#pragma pack(push, 4)
class PASCALIMPLEMENTATION TDBCoolEditBtn : public Coolctrls::TCoolEditBtn 
{
	typedef Coolctrls::TCoolEditBtn inherited;
	
private:
	Dbctrls::TFieldDataLink* FDataLink;
	bool FFocused;
	void __fastcall DataChange(System::TObject* Sender);
	void __fastcall EditingChange(System::TObject* Sender);
	void __fastcall UpdateData(System::TObject* Sender);
	AnsiString __fastcall GetDataField();
	Db::TDataSource* __fastcall GetDataSource(void);
	Db::TField* __fastcall GetField(void);
	bool __fastcall GetReadOnly(void);
	void __fastcall SetDataField(const AnsiString Value);
	void __fastcall SetDataSource(Db::TDataSource* Value);
	void __fastcall SetFocused(bool Value);
	HIDESBASE void __fastcall SetReadOnly(bool Value);
	MESSAGE void __fastcall WMCut(Messages::TMessage &Message);
	MESSAGE void __fastcall WMPaste(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMEnter(Messages::TWMNoParams &Message);
	HIDESBASE MESSAGE void __fastcall CMExit(Messages::TWMNoParams &Message);
	MESSAGE void __fastcall CMGetDataLink(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall WMPaint(Messages::TWMPaint &Message);
	
protected:
	DYNAMIC void __fastcall Change(void);
	DYNAMIC void __fastcall KeyDown(Word &Key, Classes::TShiftState Shift);
	DYNAMIC void __fastcall KeyPress(char &Key);
	virtual void __fastcall Loaded(void);
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation Operation
		);
	
public:
	__fastcall virtual TDBCoolEditBtn(Classes::TComponent* AOwner);
	__fastcall virtual ~TDBCoolEditBtn(void);
	__property Db::TField* Field = {read=GetField};
	
__published:
	__property AnsiString DataField = {read=GetDataField, write=SetDataField};
	__property Db::TDataSource* DataSource = {read=GetDataSource, write=SetDataSource};
	__property bool ReadOnly = {read=GetReadOnly, write=SetReadOnly, default=0};
public:
	#pragma option push -w-inl
	/* TWinControl.CreateParented */ inline __fastcall TDBCoolEditBtn(HWND ParentWindow) : Coolctrls::TCoolEditBtn(
		ParentWindow) { }
	#pragma option pop
	
};

#pragma pack(pop)

class DELPHICLASS TDBCoolMemo;
#pragma pack(push, 4)
class PASCALIMPLEMENTATION TDBCoolMemo : public Coolctrls::TCoolMemo 
{
	typedef Coolctrls::TCoolMemo inherited;
	
private:
	Dbctrls::TFieldDataLink* FDataLink;
	bool FFocused;
	bool FMemoLoaded;
	bool FAutoDisplay;
	void __fastcall DataChange(System::TObject* Sender);
	void __fastcall EditingChange(System::TObject* Sender);
	void __fastcall UpdateData(System::TObject* Sender);
	AnsiString __fastcall GetDataField();
	Db::TDataSource* __fastcall GetDataSource(void);
	Db::TField* __fastcall GetField(void);
	bool __fastcall GetReadOnly(void);
	void __fastcall SetDataField(const AnsiString Value);
	void __fastcall SetDataSource(Db::TDataSource* Value);
	void __fastcall SetFocused(bool Value);
	HIDESBASE void __fastcall SetReadOnly(bool Value);
	void __fastcall SetAutoDisplay(bool Value);
	MESSAGE void __fastcall WMCut(Messages::TMessage &Message);
	MESSAGE void __fastcall WMPaste(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMEnter(Messages::TWMNoParams &Message);
	HIDESBASE MESSAGE void __fastcall CMExit(Messages::TWMNoParams &Message);
	MESSAGE void __fastcall CMGetDataLink(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall WMLButtonDblClk(Messages::TWMMouse &Message);
	HIDESBASE MESSAGE void __fastcall WMPaint(Messages::TWMPaint &Message);
	HIDESBASE MESSAGE void __fastcall WMEraseBkgnd(Messages::TWMEraseBkgnd &Message);
	HIDESBASE MESSAGE void __fastcall WMSetFocus(Messages::TWMSetFocus &Message);
	HIDESBASE MESSAGE void __fastcall WMKillFocus(Messages::TWMKillFocus &Message);
	
protected:
	DYNAMIC void __fastcall Change(void);
	DYNAMIC void __fastcall KeyDown(Word &Key, Classes::TShiftState Shift);
	DYNAMIC void __fastcall KeyPress(char &Key);
	virtual void __fastcall Loaded(void);
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation Operation
		);
	virtual void __fastcall WndProc(Messages::TMessage &Message);
	
public:
	__fastcall virtual TDBCoolMemo(Classes::TComponent* AOwner);
	__fastcall virtual ~TDBCoolMemo(void);
	__property Db::TField* Field = {read=GetField};
	void __fastcall LoadMemo(void);
	DYNAMIC bool __fastcall ExecuteAction(Classes::TBasicAction* Action);
	DYNAMIC bool __fastcall UpdateAction(Classes::TBasicAction* Action);
	
__published:
	__property bool AutoDisplay = {read=FAutoDisplay, write=SetAutoDisplay, default=1};
	__property AnsiString DataField = {read=GetDataField, write=SetDataField};
	__property Db::TDataSource* DataSource = {read=GetDataSource, write=SetDataSource};
	__property bool ReadOnly = {read=GetReadOnly, write=SetReadOnly, default=0};
public:
	#pragma option push -w-inl
	/* TWinControl.CreateParented */ inline __fastcall TDBCoolMemo(HWND ParentWindow) : Coolctrls::TCoolMemo(
		ParentWindow) { }
	#pragma option pop
	
};

#pragma pack(pop)

class DELPHICLASS TDBCoolText;
#pragma pack(push, 4)
class PASCALIMPLEMENTATION TDBCoolText : public Coolctrls::TCoolLabel 
{
	typedef Coolctrls::TCoolLabel inherited;
	
private:
	Dbctrls::TFieldDataLink* FDataLink;
	void __fastcall DataChange(System::TObject* Sender);
	AnsiString __fastcall GetDataField();
	Db::TDataSource* __fastcall GetDataSource(void);
	Db::TField* __fastcall GetField(void);
	AnsiString __fastcall GetFieldText();
	void __fastcall SetDataField(const AnsiString Value);
	void __fastcall SetDataSource(Db::TDataSource* Value);
	MESSAGE void __fastcall CMGetDataLink(Messages::TMessage &Message);
	
protected:
	virtual AnsiString __fastcall GetLabelText();
	virtual void __fastcall Loaded(void);
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation Operation
		);
	virtual void __fastcall SetAutoSize(bool Value);
	
public:
	__fastcall virtual TDBCoolText(Classes::TComponent* AOwner);
	__fastcall virtual ~TDBCoolText(void);
	DYNAMIC bool __fastcall ExecuteAction(Classes::TBasicAction* Action);
	DYNAMIC bool __fastcall UpdateAction(Classes::TBasicAction* Action);
	DYNAMIC bool __fastcall UseRightToLeftAlignment(void);
	__property Db::TField* Field = {read=GetField};
	
__published:
	__property AutoSize ;
	__property AnsiString DataField = {read=GetDataField, write=SetDataField};
	__property Db::TDataSource* DataSource = {read=GetDataSource, write=SetDataSource};
};

#pragma pack(pop)

class DELPHICLASS TDBCoolScrollingText;
#pragma pack(push, 4)
class PASCALIMPLEMENTATION TDBCoolScrollingText : public Coolctrls::TCoolScrollingText 
{
	typedef Coolctrls::TCoolScrollingText inherited;
	
private:
	Dbctrls::TFieldDataLink* FDataLink;
	void __fastcall DataChange(System::TObject* Sender);
	AnsiString __fastcall GetDataField();
	Db::TDataSource* __fastcall GetDataSource(void);
	Db::TField* __fastcall GetField(void);
	AnsiString __fastcall GetFieldText();
	void __fastcall SetDataField(const AnsiString Value);
	void __fastcall SetDataSource(Db::TDataSource* Value);
	MESSAGE void __fastcall CMGetDataLink(Messages::TMessage &Message);
	
protected:
	virtual Classes::TStrings* __fastcall GetStrings(void);
	virtual void __fastcall Loaded(void);
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation Operation
		);
	
public:
	__fastcall virtual TDBCoolScrollingText(Classes::TComponent* AOwner);
	__fastcall virtual ~TDBCoolScrollingText(void);
	DYNAMIC bool __fastcall ExecuteAction(Classes::TBasicAction* Action);
	DYNAMIC bool __fastcall UpdateAction(Classes::TBasicAction* Action);
	DYNAMIC bool __fastcall UseRightToLeftAlignment(void);
	__property Db::TField* Field = {read=GetField};
	
__published:
	__property AnsiString DataField = {read=GetDataField, write=SetDataField};
	__property Db::TDataSource* DataSource = {read=GetDataSource, write=SetDataSource};
};

#pragma pack(pop)

class DELPHICLASS TDBCoolGrid;
#pragma pack(push, 4)
class PASCALIMPLEMENTATION TDBCoolGrid : public Dbgrids::TDBGrid 
{
	typedef Dbgrids::TDBGrid inherited;
	
private:
	Coolctrls::TCCAboutBox* FAboutBox;
	Graphics::TBitmap* FWallpaper;
	Graphics::TBitmap* FSelWallpaper;
	Graphics::TBitmap* FCaptionWallpaper;
	Graphics::TColor FSelColor;
	Graphics::TColor FCaptionColor;
	Graphics::TColor FCaptionTextColor;
	Coolctrls::TCoolImages* FCoolImages;
	int FidWallpaper;
	int FidSelWallpaper;
	int FidCaptionWallpaper;
	Coolctrls::TCoolChangeLink* FCoolImagesChangeLink;
	Coolctrls::TCoolOptions FExOptions;
	Byte FTransparencyLevel;
	Classes::TNotifyEvent FOnPaint;
	Classes::TNotifyEvent FOnMouseEnter;
	Classes::TNotifyEvent FOnMouseLeave;
	Coolctrls::TEndCellEditingEvent FOnEndCellEditing;
	void __fastcall SetCaptionColor(Graphics::TColor Value);
	void __fastcall SetCaptionTextColor(Graphics::TColor Value);
	void __fastcall SetWallpaper(Graphics::TBitmap* Value);
	Graphics::TBitmap* __fastcall GetWallpaper(void);
	void __fastcall SetSelWallpaper(Graphics::TBitmap* Value);
	Graphics::TBitmap* __fastcall GetSelWallpaper(void);
	void __fastcall SetCaptionWallpaper(Graphics::TBitmap* Value);
	Graphics::TBitmap* __fastcall GetCaptionWallpaper(void);
	void __fastcall WallpaperChanged(System::TObject* Sender);
	void __fastcall SetCoolImages(Coolctrls::TCoolImages* Value);
	void __fastcall SetidWallpaper(int Value);
	void __fastcall SetidSelWallpaper(int Value);
	void __fastcall SetidCaptionWallpaper(int Value);
	bool __fastcall CTLDrawWallpaperEx(HDC DC, const Windows::TRect &R, const Windows::TRect &SubRect, 
		bool IsStretch, int Mode);
	bool __fastcall CTLDrawSelWallpaperEx(HDC DC, const Windows::TRect &R, const Windows::TRect &SubRect
		, bool IsStretch, int Mode);
	bool __fastcall CTLDrawCaptionWallpaper(HDC DC, const Windows::TRect &R, bool IsStretch, int Mode);
		
	bool __fastcall IsWallpaperAssigned(void);
	bool __fastcall IsSelWallpaperAssigned(void);
	void __fastcall CoolImagesChange(System::TObject* Sender);
	void __fastcall SetExOptions(Coolctrls::TCoolOptions Value);
	void __fastcall SetTransparencyLevel(Byte Value);
	Controls::TWinControl* __fastcall TrControl(void);
	HIDESBASE MESSAGE void __fastcall WMPaint(Messages::TWMPaint &Message);
	HIDESBASE MESSAGE void __fastcall WMEraseBkgnd(Messages::TWMEraseBkgnd &Message);
	HIDESBASE MESSAGE void __fastcall WMNCPaint(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMMouseEnter(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMMouseLeave(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall WMSetFocus(Messages::TWMSetFocus &Message);
	HIDESBASE MESSAGE void __fastcall WMKillFocus(Messages::TWMKillFocus &Message);
	MESSAGE void __fastcall WMNCLButtonDblClk(Messages::TWMNCHitMessage &Message);
	HIDESBASE MESSAGE void __fastcall WMNCHitTest(Messages::TWMNCHitTest &Message);
	HIDESBASE MESSAGE void __fastcall CMParentColorChanged(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMEnabledChanged(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall WMMove(Messages::TWMMove &Message);
	MESSAGE void __fastcall WMSetText(Messages::TMessage &Message);
	MESSAGE void __fastcall CMEndEditing(Messages::TMessage &Message);
	
protected:
	AnsiString EditValue;
	virtual void __fastcall DrawCell(int ACol, int ARow, const Windows::TRect &ARect, Grids::TGridDrawState 
		AState);
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation Operation
		);
	virtual void __fastcall NCCtlChanged(void);
	DYNAMIC void __fastcall TopLeftChanged(void);
	virtual void __fastcall Scroll(int Distance);
	DYNAMIC void __fastcall SetEditText(int ACol, int ARow, const AnsiString Value);
	DYNAMIC AnsiString __fastcall GetEditText(int ACol, int ARow);
	virtual Grids::TInplaceEdit* __fastcall CreateEditor(void);
	virtual void __fastcall CreateParams(Controls::TCreateParams &Params);
	
public:
	__fastcall virtual TDBCoolGrid(Classes::TComponent* AOwner);
	__fastcall virtual ~TDBCoolGrid(void);
	void __fastcall MakeTransparency(void);
	__property Canvas ;
	__property SelectedRows ;
	
__published:
	__property Coolctrls::TCCAboutBox* About = {read=FAboutBox, write=FAboutBox};
	__property Graphics::TColor CaptionColor = {read=FCaptionColor, write=SetCaptionColor, default=-2147483645
		};
	__property Graphics::TColor CaptionTextColor = {read=FCaptionTextColor, write=SetCaptionTextColor, 
		default=-2147483629};
	__property Graphics::TBitmap* CaptionWallpaper = {read=GetCaptionWallpaper, write=SetCaptionWallpaper
		};
	__property Coolctrls::TCoolImages* CoolImages = {read=FCoolImages, write=SetCoolImages};
	__property Coolctrls::TCoolOptions ExOptions = {read=FExOptions, write=SetExOptions, default=4096};
		
	__property int idCaptionWallpaper = {read=FidCaptionWallpaper, write=SetidCaptionWallpaper, default=-1
		};
	__property int idSelWallpaper = {read=FidSelWallpaper, write=SetidSelWallpaper, default=-1};
	__property int idWallpaper = {read=FidWallpaper, write=SetidWallpaper, default=-1};
	__property Graphics::TBitmap* SelWallpaper = {read=GetSelWallpaper, write=SetSelWallpaper};
	__property Byte TransparencyLevel = {read=FTransparencyLevel, write=SetTransparencyLevel, default=0
		};
	__property Graphics::TBitmap* Wallpaper = {read=GetWallpaper, write=SetWallpaper};
	__property Coolctrls::TEndCellEditingEvent OnEndCellEditing = {read=FOnEndCellEditing, write=FOnEndCellEditing
		};
	__property Classes::TNotifyEvent OnMouseEnter = {read=FOnMouseEnter, write=FOnMouseEnter};
	__property Classes::TNotifyEvent OnMouseLeave = {read=FOnMouseLeave, write=FOnMouseLeave};
	__property Classes::TNotifyEvent OnPaint = {read=FOnPaint, write=FOnPaint};
	__property Align ;
	__property Anchors ;
	__property BiDiMode ;
	__property BorderStyle ;
	__property Color ;
	__property Columns  = {stored=false};
	__property Constraints ;
	__property Ctl3D ;
	__property DataSource ;
	__property DefaultDrawing ;
	__property DragCursor ;
	__property DragKind ;
	__property DragMode ;
	__property Enabled ;
	__property FixedColor ;
	__property Font ;
	__property ImeMode ;
	__property ImeName ;
	__property Options ;
	__property ParentBiDiMode ;
	__property ParentColor ;
	__property ParentCtl3D ;
	__property ParentFont ;
	__property ParentShowHint ;
	__property PopupMenu ;
	__property ReadOnly ;
	__property ShowHint ;
	__property TabOrder ;
	__property TabStop ;
	__property TitleFont ;
	__property Visible ;
	__property OnCellClick ;
	__property OnColEnter ;
	__property OnColExit ;
	__property OnColumnMoved ;
	__property OnDrawDataCell ;
	__property OnDrawColumnCell ;
	__property OnDblClick ;
	__property OnDragDrop ;
	__property OnDragOver ;
	__property OnEditButtonClick ;
	__property OnEndDock ;
	__property OnEndDrag ;
	__property OnEnter ;
	__property OnExit ;
	__property OnKeyDown ;
	__property OnKeyPress ;
	__property OnKeyUp ;
	__property OnMouseDown ;
	__property OnMouseMove ;
	__property OnMouseUp ;
	__property OnStartDock ;
	__property OnStartDrag ;
	__property OnTitleClick ;
public:
	#pragma option push -w-inl
	/* TWinControl.CreateParented */ inline __fastcall TDBCoolGrid(HWND ParentWindow) : Dbgrids::TDBGrid(
		ParentWindow) { }
	#pragma option pop
	
};

#pragma pack(pop)

class DELPHICLASS TDBCoolLookupListBox;
#pragma pack(push, 4)
class PASCALIMPLEMENTATION TDBCoolLookupListBox : public Dbctrls::TDBLookupListBox 
{
	typedef Dbctrls::TDBLookupListBox inherited;
	
private:
	Coolctrls::TCCAboutBox* FAboutBox;
	Coolctrls::TCoolOptions FOptions;
	Byte FTransparencyLevel;
	Graphics::TBitmap* FWallpaper;
	Graphics::TBitmap* FSelWallpaper;
	Graphics::TBitmap* FCaptionWallpaper;
	Controls::TBevelCut FBevelInner;
	Controls::TBevelCut FBevelOuter;
	Coolctrls::TCoolImages* FCoolImages;
	int FidWallpaper;
	int FidSelWallpaper;
	int FidCaptionWallpaper;
	Coolctrls::TCoolChangeLink* FCoolImagesChangeLink;
	Toolwin::TEdgeBorders FEdgeBorders;
	Graphics::TPen* FBorderPen;
	Graphics::TColor FBordersTrColor;
	Graphics::TColor FSelColor;
	Graphics::TColor FCaptionColor;
	Graphics::TColor FCaptionTextColor;
	Graphics::TFont* FSelFont;
	bool FPopup;
	Classes::TNotifyEvent FOnMouseEnter;
	Classes::TNotifyEvent FOnMouseLeave;
	void __fastcall BorderPenChange(System::TObject* Sender);
	void __fastcall SetOptions(Coolctrls::TCoolOptions Value);
	void __fastcall SetEdgeBorders(Toolwin::TEdgeBorders Value);
	void __fastcall SetBorderPen(Graphics::TPen* Value);
	void __fastcall SetBordersTrColor(Graphics::TColor Value);
	void __fastcall SetWallpaper(Graphics::TBitmap* Value);
	Graphics::TBitmap* __fastcall GetWallpaper(void);
	void __fastcall WallpaperChanged(System::TObject* Sender);
	void __fastcall SetSelWallpaper(Graphics::TBitmap* Value);
	Graphics::TBitmap* __fastcall GetSelWallpaper(void);
	void __fastcall SetCaptionWallpaper(Graphics::TBitmap* Value);
	Graphics::TBitmap* __fastcall GetCaptionWallpaper(void);
	void __fastcall SetBevelInner(Controls::TBevelCut Value);
	void __fastcall SetBevelOuter(Controls::TBevelCut Value);
	void __fastcall SetCaptionColor(Graphics::TColor Value);
	void __fastcall SetCaptionTextColor(Graphics::TColor Value);
	void __fastcall SetSelFont(Graphics::TFont* Value);
	void __fastcall SelFontChange(System::TObject* Sender);
	void __fastcall SetTransparencyLevel(Byte Value);
	void __fastcall SetCoolImages(Coolctrls::TCoolImages* Value);
	void __fastcall SetidWallpaper(int Value);
	void __fastcall SetidSelWallpaper(int Value);
	void __fastcall SetidCaptionWallpaper(int Value);
	bool __fastcall IsWallpaperAssigned(void);
	bool __fastcall IsSelWallpaperAssigned(void);
	void __fastcall CoolImagesChange(System::TObject* Sender);
	bool __fastcall CTLDrawWallpaper(HDC DC, const Windows::TRect &R, bool IsStretch, int Mode);
	bool __fastcall CTLDrawCaptionWallpaper(HDC DC, const Windows::TRect &R, bool IsStretch, int Mode);
		
	bool __fastcall CTLDrawWallpaperEx(HDC DC, const Windows::TRect &R, const Windows::TRect &SubRect, 
		bool IsStretch, int Mode);
	bool __fastcall CTLDrawSelWallpaperEx(HDC DC, const Windows::TRect &R, const Windows::TRect &SubRect
		, bool IsStretch, int Mode);
	HIDESBASE MESSAGE void __fastcall WMPaint(Messages::TWMPaint &Message);
	HIDESBASE MESSAGE void __fastcall WMEraseBkGnd(Messages::TWMEraseBkgnd &Message);
	MESSAGE void __fastcall WMSetText(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall WMNCPaint(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall WMSetFocus(Messages::TWMSetFocus &Message);
	HIDESBASE MESSAGE void __fastcall WMKillFocus(Messages::TWMKillFocus &Message);
	MESSAGE void __fastcall WMNCLButtonDblClk(Messages::TWMNCHitMessage &Message);
	HIDESBASE MESSAGE void __fastcall WMNCHitTest(Messages::TWMNCHitTest &Message);
	HIDESBASE MESSAGE void __fastcall CMMouseEnter(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMMouseLeave(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMParentFontChanged(Messages::TMessage &Message);
	
protected:
	virtual void __fastcall NCCtlChanged(void);
	virtual void __fastcall Loaded(void);
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation Operation
		);
	virtual void __fastcall Paint(void);
	virtual void __fastcall CreateParams(Controls::TCreateParams &Params);
	DYNAMIC void __fastcall MouseDown(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, 
		int Y);
	HIDESBASE void __fastcall SelectItemAt(int X, int Y);
	
public:
	__fastcall virtual TDBCoolLookupListBox(Classes::TComponent* AOwner);
	__fastcall virtual ~TDBCoolLookupListBox(void);
	
__published:
	__property Coolctrls::TCCAboutBox* About = {read=FAboutBox, write=FAboutBox};
	__property Controls::TBevelCut BevelInner = {read=FBevelInner, write=SetBevelInner, default=0};
	__property Controls::TBevelCut BevelOuter = {read=FBevelOuter, write=SetBevelOuter, default=0};
	__property Graphics::TPen* BorderPen = {read=FBorderPen, write=SetBorderPen};
	__property Graphics::TColor BordersTrColor = {read=FBordersTrColor, write=SetBordersTrColor, default=536870911
		};
	__property Graphics::TColor CaptionColor = {read=FCaptionColor, write=SetCaptionColor, default=-2147483645
		};
	__property Graphics::TColor CaptionTextColor = {read=FCaptionTextColor, write=SetCaptionTextColor, 
		default=-2147483629};
	__property Graphics::TBitmap* CaptionWallpaper = {read=GetCaptionWallpaper, write=SetCaptionWallpaper
		};
	__property Coolctrls::TCoolImages* CoolImages = {read=FCoolImages, write=SetCoolImages};
	__property Toolwin::TEdgeBorders EdgeBorders = {read=FEdgeBorders, write=SetEdgeBorders, default=0}
		;
	__property int idCaptionWallpaper = {read=FidCaptionWallpaper, write=SetidCaptionWallpaper, default=-1
		};
	__property int idSelWallpaper = {read=FidSelWallpaper, write=SetidSelWallpaper, default=-1};
	__property int idWallpaper = {read=FidWallpaper, write=SetidWallpaper, default=-1};
	__property Coolctrls::TCoolOptions Options = {read=FOptions, write=SetOptions, default=4160};
	__property Graphics::TBitmap* SelWallpaper = {read=GetSelWallpaper, write=SetSelWallpaper};
	__property Graphics::TColor SelColor = {read=FSelColor, write=FSelColor, default=-2147483635};
	__property Graphics::TFont* SelFont = {read=FSelFont, write=SetSelFont};
	__property Byte TransparencyLevel = {read=FTransparencyLevel, write=SetTransparencyLevel, default=0
		};
	__property Graphics::TBitmap* Wallpaper = {read=GetWallpaper, write=SetWallpaper};
	__property Caption ;
public:
	#pragma option push -w-inl
	/* TWinControl.CreateParented */ inline __fastcall TDBCoolLookupListBox(HWND ParentWindow) : Dbctrls::TDBLookupListBox(
		ParentWindow) { }
	#pragma option pop
	
};

#pragma pack(pop)

class DELPHICLASS TPopupDataList;
#pragma pack(push, 4)
class PASCALIMPLEMENTATION TPopupDataList : public TDBCoolLookupListBox 
{
	typedef TDBCoolLookupListBox inherited;
	
private:
	MESSAGE void __fastcall WMMouseActivate(Messages::TMessage &Message);
	
protected:
	virtual void __fastcall CreateParams(Controls::TCreateParams &Params);
	
public:
	__fastcall virtual TPopupDataList(Classes::TComponent* AOwner);
public:
	#pragma option push -w-inl
	/* TDBCoolLookupListBox.Destroy */ inline __fastcall virtual ~TPopupDataList(void) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TWinControl.CreateParented */ inline __fastcall TPopupDataList(HWND ParentWindow) : TDBCoolLookupListBox(
		ParentWindow) { }
	#pragma option pop
	
};

#pragma pack(pop)

class DELPHICLASS TDBCoolLookupComboBox;
#pragma pack(push, 4)
class PASCALIMPLEMENTATION TDBCoolLookupComboBox : public Dbctrls::TDBLookupControl 
{
	typedef Dbctrls::TDBLookupControl inherited;
	
private:
	TPopupDataList* FDataList;
	int FButtonWidth;
	AnsiString FText;
	int FDropDownRows;
	int FDropDownWidth;
	Dbctrls::TDropDownAlign FDropDownAlign;
	bool FListVisible;
	bool FPressed;
	bool FTracking;
	Classes::TAlignment FAlignment;
	bool FLookupMode;
	Classes::TNotifyEvent FOnDropDown;
	Classes::TNotifyEvent FOnCloseUp;
	Coolctrls::TCCAboutBox* FAboutBox;
	Coolctrls::TCoolOptions FOptions;
	Byte FTransparencyLevel;
	Graphics::TBitmap* FWallpaper;
	Graphics::TBitmap* FSelWallpaper;
	Controls::TBevelCut FBevelInner;
	Controls::TBevelCut FBevelOuter;
	Coolctrls::TCoolImages* FCoolImages;
	int FidWallpaper;
	int FidSelWallpaper;
	Coolctrls::TCoolChangeLink* FCoolImagesChangeLink;
	Toolwin::TEdgeBorders FEdgeBorders;
	Graphics::TPen* FBorderPen;
	Graphics::TColor FBordersTrColor;
	Graphics::TColor FSelColor;
	Graphics::TFont* FSelFont;
	Forms::TFormBorderStyle FBorderStyle;
	Classes::TNotifyEvent FOnMouseEnter;
	Classes::TNotifyEvent FOnMouseLeave;
	void __fastcall BorderPenChange(System::TObject* Sender);
	void __fastcall SetOptions(Coolctrls::TCoolOptions Value);
	void __fastcall SetEdgeBorders(Toolwin::TEdgeBorders Value);
	void __fastcall SetBorderPen(Graphics::TPen* Value);
	void __fastcall SetBorderStyle(Forms::TBorderStyle Value);
	void __fastcall SetBordersTrColor(Graphics::TColor Value);
	void __fastcall SetWallpaper(Graphics::TBitmap* Value);
	Graphics::TBitmap* __fastcall GetWallpaper(void);
	void __fastcall WallpaperChanged(System::TObject* Sender);
	void __fastcall SetSelWallpaper(Graphics::TBitmap* Value);
	Graphics::TBitmap* __fastcall GetSelWallpaper(void);
	void __fastcall SetBevelInner(Controls::TBevelCut Value);
	void __fastcall SetBevelOuter(Controls::TBevelCut Value);
	void __fastcall SetSelFont(Graphics::TFont* Value);
	void __fastcall SelFontChange(System::TObject* Sender);
	void __fastcall SetTransparencyLevel(Byte Value);
	void __fastcall SetCoolImages(Coolctrls::TCoolImages* Value);
	void __fastcall SetidWallpaper(int Value);
	void __fastcall SetidSelWallpaper(int Value);
	bool __fastcall IsWallpaperAssigned(void);
	bool __fastcall IsSelWallpaperAssigned(void);
	void __fastcall CoolImagesChange(System::TObject* Sender);
	bool __fastcall CTLDrawWallpaper(HDC DC, const Windows::TRect &R, bool IsStretch, int Mode);
	bool __fastcall CTLDrawWallpaperEx(HDC DC, const Windows::TRect &R, const Windows::TRect &SubRect, 
		bool IsStretch, int Mode);
	bool __fastcall CTLDrawSelWallpaperEx(HDC DC, const Windows::TRect &R, const Windows::TRect &SubRect
		, bool IsStretch, int Mode);
	HIDESBASE MESSAGE void __fastcall WMPaint(Messages::TWMPaint &Message);
	HIDESBASE MESSAGE void __fastcall WMEraseBkGnd(Messages::TWMEraseBkgnd &Message);
	MESSAGE void __fastcall WMSetText(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall WMSetFocus(Messages::TWMSetFocus &Message);
	HIDESBASE MESSAGE void __fastcall WMKillFocus(Messages::TWMKillFocus &Message);
	HIDESBASE MESSAGE void __fastcall CMMouseEnter(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMMouseLeave(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMParentFontChanged(Messages::TMessage &Message);
	void __fastcall ListMouseUp(System::TObject* Sender, Controls::TMouseButton Button, Classes::TShiftState 
		Shift, int X, int Y);
	void __fastcall StopTracking(void);
	void __fastcall TrackButton(int X, int Y);
	HIDESBASE MESSAGE void __fastcall CMDialogKey(Messages::TWMKey &Message);
	MESSAGE void __fastcall CMCancelMode(Controls::TCMCancelMode &Message);
	HIDESBASE MESSAGE void __fastcall CMCtl3DChanged(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMFontChanged(Messages::TMessage &Message);
	MESSAGE void __fastcall CMGetDataLink(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall WMCancelMode(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMBiDiModeChanged(Messages::TMessage &Message);
	
protected:
	virtual void __fastcall Loaded(void);
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation Operation
		);
	virtual void __fastcall CreateParams(Controls::TCreateParams &Params);
	virtual void __fastcall Paint(void);
	DYNAMIC void __fastcall KeyDown(Word &Key, Classes::TShiftState Shift);
	DYNAMIC void __fastcall KeyPress(char &Key);
	virtual void __fastcall KeyValueChanged(void);
	DYNAMIC void __fastcall MouseDown(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, 
		int Y);
	DYNAMIC void __fastcall MouseMove(Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseUp(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int 
		Y);
	virtual void __fastcall UpdateListFields(void);
	
public:
	__fastcall virtual TDBCoolLookupComboBox(Classes::TComponent* AOwner);
	__fastcall virtual ~TDBCoolLookupComboBox(void);
	virtual void __fastcall CloseUp(bool Accept);
	virtual void __fastcall DropDown(void);
	DYNAMIC bool __fastcall ExecuteAction(Classes::TBasicAction* Action);
	virtual void __fastcall SetBounds(int ALeft, int ATop, int AWidth, int AHeight);
	DYNAMIC bool __fastcall UpdateAction(Classes::TBasicAction* Action);
	DYNAMIC bool __fastcall UseRightToLeftAlignment(void);
	__property KeyValue ;
	__property bool ListVisible = {read=FListVisible, nodefault};
	__property AnsiString Text = {read=FText};
	
__published:
	__property Coolctrls::TCCAboutBox* About = {read=FAboutBox, write=FAboutBox};
	__property Controls::TBevelCut BevelInner = {read=FBevelInner, write=SetBevelInner, default=0};
	__property Controls::TBevelCut BevelOuter = {read=FBevelOuter, write=SetBevelOuter, default=0};
	__property Graphics::TPen* BorderPen = {read=FBorderPen, write=SetBorderPen};
	__property Graphics::TColor BordersTrColor = {read=FBordersTrColor, write=SetBordersTrColor, default=536870911
		};
	__property Forms::TBorderStyle BorderStyle = {read=FBorderStyle, write=SetBorderStyle, default=1};
	__property Coolctrls::TCoolImages* CoolImages = {read=FCoolImages, write=SetCoolImages};
	__property Toolwin::TEdgeBorders EdgeBorders = {read=FEdgeBorders, write=SetEdgeBorders, default=0}
		;
	__property int idSelWallpaper = {read=FidSelWallpaper, write=SetidSelWallpaper, default=-1};
	__property int idWallpaper = {read=FidWallpaper, write=SetidWallpaper, default=-1};
	__property Coolctrls::TCoolOptions Options = {read=FOptions, write=SetOptions, default=4160};
	__property Graphics::TBitmap* SelWallpaper = {read=GetSelWallpaper, write=SetSelWallpaper};
	__property Graphics::TColor SelColor = {read=FSelColor, write=FSelColor, default=-2147483635};
	__property Graphics::TFont* SelFont = {read=FSelFont, write=SetSelFont};
	__property Byte TransparencyLevel = {read=FTransparencyLevel, write=SetTransparencyLevel, default=0
		};
	__property Graphics::TBitmap* Wallpaper = {read=GetWallpaper, write=SetWallpaper};
	__property Anchors ;
	__property BiDiMode ;
	__property Color ;
	__property Constraints ;
	__property Ctl3D ;
	__property DataField ;
	__property DataSource ;
	__property DragCursor ;
	__property DragKind ;
	__property DragMode ;
	__property Dbctrls::TDropDownAlign DropDownAlign = {read=FDropDownAlign, write=FDropDownAlign, default=0
		};
	__property int DropDownRows = {read=FDropDownRows, write=FDropDownRows, default=7};
	__property int DropDownWidth = {read=FDropDownWidth, write=FDropDownWidth, default=0};
	__property Enabled ;
	__property Font ;
	__property ImeMode ;
	__property ImeName ;
	__property KeyField ;
	__property ListField ;
	__property ListFieldIndex ;
	__property ListSource ;
	__property ParentBiDiMode ;
	__property ParentColor ;
	__property ParentCtl3D ;
	__property ParentFont ;
	__property ParentShowHint ;
	__property PopupMenu ;
	__property ReadOnly ;
	__property ShowHint ;
	__property TabOrder ;
	__property TabStop ;
	__property Visible ;
	__property OnClick ;
	__property Classes::TNotifyEvent OnCloseUp = {read=FOnCloseUp, write=FOnCloseUp};
	__property OnDragDrop ;
	__property OnDragOver ;
	__property Classes::TNotifyEvent OnDropDown = {read=FOnDropDown, write=FOnDropDown};
	__property OnEndDock ;
	__property OnEndDrag ;
	__property OnEnter ;
	__property OnExit ;
	__property OnKeyDown ;
	__property OnKeyPress ;
	__property OnKeyUp ;
	__property OnMouseDown ;
	__property OnMouseMove ;
	__property OnMouseUp ;
	__property OnStartDock ;
	__property OnStartDrag ;
public:
	#pragma option push -w-inl
	/* TWinControl.CreateParented */ inline __fastcall TDBCoolLookupComboBox(HWND ParentWindow) : Dbctrls::TDBLookupControl(
		ParentWindow) { }
	#pragma option pop
	
};

#pragma pack(pop)

//-- var, const, procedure ---------------------------------------------------

}	/* namespace Coolctrlsdb */
#if !defined(NO_IMPLICIT_NAMESPACE_USE)
using namespace Coolctrlsdb;
#endif
#pragma option pop	// -w-

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// CoolCtrlsDB
