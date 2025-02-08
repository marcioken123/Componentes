// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDCustomCheckListBox.pas' rev: 31.00 (Windows)

#ifndef LmdcustomchecklistboxHPP
#define LmdcustomchecklistboxHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Vcl.Graphics.hpp>
#include <Winapi.Messages.hpp>
#include <System.Classes.hpp>
#include <Vcl.Dialogs.hpp>
#include <Vcl.Controls.hpp>
#include <Winapi.Windows.hpp>
#include <Vcl.StdCtrls.hpp>
#include <LMDButtonListData.hpp>
#include <LMDCustomImageListBox.hpp>
#include <LMDCustomListBox.hpp>
#include <Vcl.ImgList.hpp>
#include <LMDGlyphTextLayout.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdcustomchecklistbox
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDCustomCheckListBox;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDCustomCheckListBox : public Lmdcustomimagelistbox::TLMDCustomImageListBox
{
	typedef Lmdcustomimagelistbox::TLMDCustomImageListBox inherited;
	
private:
	bool FBtnAllowUnselect;
	Lmdbuttonlistdata::TLMDButtonListMode FBtnMode;
	bool FReadOnly;
	bool FBtnFlat;
	bool FBtnDefault;
	System::Byte FBtnGap;
	System::Classes::TNotifyEvent FOnClickCheck;
	System::Classes::TList* FSaveStates;
	bool FSelectByClick;
	void __fastcall SetBtnFlat(const bool aValue);
	void __fastcall SetBtnDefault(const bool aValue);
	void __fastcall SetReadOnly(const bool aValue);
	void __fastcall SetBtnGap(const System::Byte aValue);
	void __fastcall SetBtnMode(const Lmdbuttonlistdata::TLMDButtonListMode aValue);
	void __fastcall SetItemEnabled(int Index, const bool aValue);
	void __fastcall SetChecked(int Index, const bool aValue);
	void __fastcall SetState(int Index, const Vcl::Stdctrls::TCheckBoxState aValue);
	void __fastcall SetValue(__int64 aValue);
	Lmdbuttonlistdata::TLMDButtonListData* __fastcall GetButtonData(int Index);
	bool __fastcall GetChecked(int Index);
	bool __fastcall GetItemEnabled(int Index);
	Vcl::Stdctrls::TCheckBoxState __fastcall GetState(int Index);
	bool __fastcall ButtonDataAvailable(int Index);
	Lmdbuttonlistdata::TLMDButtonListData* __fastcall CheckButtonData(int Index);
	Lmdbuttonlistdata::TLMDButtonListData* __fastcall CreateButtonData(int Index);
	__int64 __fastcall GetValue(void);
	void __fastcall InvalidateButtonData(int Index);
	void __fastcall ToggleClickCheck(int Index);
	HIDESBASE MESSAGE void __fastcall CNDrawItem(Winapi::Messages::TWMDrawItem &Message);
	HIDESBASE MESSAGE void __fastcall WMDestroy(Winapi::Messages::TWMNoParams &Msg);
	
protected:
	virtual void __fastcall CreateParams(Vcl::Controls::TCreateParams &Params);
	virtual void __fastcall CreateWnd(void);
	DYNAMIC void __fastcall DeleteString(int Index);
	virtual void __fastcall DestroyWnd(void);
	virtual void __fastcall DrawItem(int Index, const System::Types::TRect &Rect, Winapi::Windows::TOwnerDrawState State);
	void __fastcall DoClickCheck(void);
	DYNAMIC NativeInt __fastcall GetItemData(int Index);
	DYNAMIC NativeInt __fastcall InternalGetItemData(int Index);
	DYNAMIC void __fastcall SetItemData(int Index, NativeInt AData);
	DYNAMIC void __fastcall InternalSetItemData(int Index, NativeInt AData);
	int __fastcall GetCheckWidth(void);
	int __fastcall GetCheckHeight(void);
	virtual int __fastcall GetHorzExtent(int index);
	virtual int __fastcall GetImageWidth(int aValue);
	virtual int __fastcall GetImageHeight(int aValue);
	DYNAMIC void __fastcall KeyPress(System::WideChar &Key);
	DYNAMIC void __fastcall MouseDown(System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall ResetContent(void);
	
public:
	__fastcall virtual TLMDCustomCheckListBox(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TLMDCustomCheckListBox(void);
	void __fastcall CheckAll(bool UnCheck = false);
	__property bool Checked[int Index] = {read=GetChecked, write=SetChecked};
	__property bool ItemEnabled[int Index] = {read=GetItemEnabled, write=SetItemEnabled};
	__property Vcl::Stdctrls::TCheckBoxState State[int Index] = {read=GetState, write=SetState};
	
__published:
	__property bool BtnDefault = {read=FBtnDefault, write=SetBtnDefault, default=1};
	__property System::Classes::TNotifyEvent OnClickCheck = {read=FOnClickCheck, write=FOnClickCheck};
	__property Items;
	__property bool BtnAllowUnselect = {read=FBtnAllowUnselect, write=FBtnAllowUnselect, default=0};
	__property Lmdbuttonlistdata::TLMDButtonListMode BtnMode = {read=FBtnMode, write=SetBtnMode, default=0};
	__property bool BtnFlat = {read=FBtnFlat, write=SetBtnFlat, default=1};
	__property System::Byte BtnGap = {read=FBtnGap, write=SetBtnGap, default=0};
	__property bool SelectByClick = {read=FSelectByClick, write=FSelectByClick, default=0};
	__property __int64 Value = {read=GetValue, write=SetValue, default=-1};
	__property bool ReadOnly = {read=FReadOnly, write=SetReadOnly, default=0};
	__property ItemIndex;
	__property ImageList;
	__property ListIndex = {default=0};
	__property Layout;
	__property MultiLine = {default=0};
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDCustomCheckListBox(HWND ParentWindow) : Lmdcustomimagelistbox::TLMDCustomImageListBox(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdcustomchecklistbox */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDCUSTOMCHECKLISTBOX)
using namespace Lmdcustomchecklistbox;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdcustomchecklistboxHPP
