// Borland C++ Builder
// Copyright (c) 1995, 2002 by Borland Software Corporation
// All rights reserved

// (DO NOT EDIT: machine generated header) 'wwrcdpnl.pas' rev: 6.00

#ifndef wwrcdpnlHPP
#define wwrcdpnlHPP

#pragma delphiheader begin
#pragma option push -w-
#pragma option push -Vx
#include <wwframe.hpp>	// Pascal unit
#include <Wwstr.hpp>	// Pascal unit
#include <DBCtrls.hpp>	// Pascal unit
#include <wwdbedit.hpp>	// Pascal unit
#include <Wwcommon.hpp>	// Pascal unit
#include <StdCtrls.hpp>	// Pascal unit
#include <Wwdatsrc.hpp>	// Pascal unit
#include <DB.hpp>	// Pascal unit
#include <wwrcdvw.hpp>	// Pascal unit
#include <Dialogs.hpp>	// Pascal unit
#include <Forms.hpp>	// Pascal unit
#include <Controls.hpp>	// Pascal unit
#include <Graphics.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <SysUtils.hpp>	// Pascal unit
#include <Messages.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <System.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Wwrcdpnl
{
//-- type declarations -------------------------------------------------------
#pragma option push -b-
enum TwwRecordViewPanelStyle { rvpsVertical, rvpsHorizontal };
#pragma option pop

#pragma option push -b-
enum TwwRecordViewPanelOption { rvopHideReadOnly, rvopHideCalculated, rvopUseCustomControls, rvopShortenEditBox, rvopConsistentEditWidth, rvopMaximizeMemoWidth, rvopUseDateTimePicker, rvopLabelsBeneathControl };
#pragma option pop

typedef Set<TwwRecordViewPanelOption, rvopHideReadOnly, rvopLabelsBeneathControl>  TwwRecordViewPanelOptions;

typedef void __fastcall (__closure *TwwRecordOnBeforeCreateControl)(System::TObject* Sender, Db::TField* curField, bool &Accept);

typedef void __fastcall (__closure *TwwRecordOnAfterCreateControl)(System::TObject* Sender, Db::TField* curField, Controls::TControl* Control);

typedef void __fastcall (__closure *TwwRecordSetControlEffects)(System::TObject* Sender, Db::TField* curField, Controls::TControl* Control, Wwframe::TwwEditFrame* Frame, Wwframe::TwwButtonEffects* ButtonEffects);

class DELPHICLASS TwwRecordViewPanel;
class PASCALIMPLEMENTATION TwwRecordViewPanel : public Forms::TScrollBox 
{
	typedef Forms::TScrollBox inherited;
	
private:
	Classes::TStrings* FSelected;
	bool FUseTFields;
	Wwrcdvw::TwwEditSpacing* FEditSpacing;
	Wwrcdvw::TwwMargin* FMargin;
	Db::TDataLink* FDataLink;
	TwwRecordViewPanelOptions FOptions;
	Wwrcdvw::TwwRecordViewControlOptions FControlOptions;
	Graphics::TFont* FLabelFont;
	TwwRecordOnBeforeCreateControl FOnBeforeCreateControl;
	TwwRecordOnAfterCreateControl FOnAfterCreateControl;
	TwwRecordSetControlEffects FOnSetControlEffects;
	Graphics::TColor FReadOnlyColor;
	TwwRecordViewPanelStyle FStyle;
	int FLinesPerMemoControl;
	Controls::TWinControl* FParentObject;
	Wwframe::TwwEditFrame* FDefaultEditFrame;
	int EditStartOffset;
	Classes::TList* CustomControlList;
	bool InApply;
	bool RecreateNextTime;
	Classes::TList* ControlPositions;
	Classes::TStrings* FControlType;
	bool FControlInfoInDataset;
	Classes::TStrings* FPictureMasks;
	bool FPictureMaskFromDataSet;
	Stdctrls::TLabel* CurLabel;
	void __fastcall SetDataSource(Db::TDataSource* value);
	Db::TDataSource* __fastcall GetDataSource(void);
	void __fastcall SetLabelFont(Graphics::TFont* val);
	bool __fastcall ShowField(Db::TField* field, bool curFieldReadOnly);
	void __fastcall AddCustomControl(Controls::TWinControl* CustomEdit);
	HIDESBASE MESSAGE void __fastcall CMFontChanged(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall WMSetFocus(Messages::TWMSetFocus &Message);
	void __fastcall LabelFontChanged(System::TObject* Sender);
	void __fastcall SetOptions(TwwRecordViewPanelOptions val);
	void __fastcall SetControlOptions(Wwrcdvw::TwwRecordViewControlOptions val);
	void __fastcall SetStyle(TwwRecordViewPanelStyle val);
	bool __fastcall IsCustomEditCell(Db::TField* curField, Controls::TWinControl* &customEdit);
	bool __fastcall UseCustomControls(void);
	void __fastcall AddControlPosition(Controls::TControl* Control, int Left, int Top, int Width, int Height);
	void __fastcall SetLinesPerMemoControl(int val);
	void __fastcall SetPictureMasks(Classes::TStrings* val);
	void __fastcall SetControlType(Classes::TStrings* val);
	
protected:
	virtual bool __fastcall IsSingleLineEditControl(Controls::TWinControl* EditControl);
	virtual void __fastcall DoOnBeforeCreateControl(System::TObject* Sender, Db::TField* curField, bool &accept);
	virtual void __fastcall DoOnAfterCreateControl(System::TObject* Sender, Db::TField* curField, Controls::TControl* Control);
	void __fastcall DoSetControlEffects(System::TObject* Sender, Db::TField* curfield, Controls::TControl* control, Wwframe::TwwEditFrame* Frame, Wwframe::TwwButtonEffects* ButtonEffects);
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation Operation);
	void __fastcall DisplayVertical(bool Recreate);
	void __fastcall DisplayHorizontal(bool Recreate);
	DYNAMIC void __fastcall Resize(void);
	virtual void __fastcall LinkActive(bool Value);
	void __fastcall FreeNonCustomControls(bool DestroyControls);
	virtual bool __fastcall Apply(bool Recreate);
	virtual void __fastcall CreateParams(Controls::TCreateParams &Params);
	bool __fastcall HasFrame(Controls::TWinControl* Control);
	bool __fastcall HasButtonEffects(Controls::TWinControl* Control);
	virtual void __fastcall CreateWnd(void);
	
public:
	Variant Patch;
	__fastcall virtual TwwRecordViewPanel(Classes::TComponent* AOwner);
	__fastcall virtual ~TwwRecordViewPanel(void);
	void __fastcall RefreshControls(void);
	void __fastcall RecreateControls(void);
	void __fastcall ClearControls(void);
	
__published:
	__property Anchors  = {default=3};
	__property Constraints ;
	__property bool ControlInfoInDataset = {read=FControlInfoInDataset, write=FControlInfoInDataset, default=1};
	__property Classes::TStrings* ControlType = {read=FControlType, write=SetControlType};
	__property bool PictureMaskFromDataSet = {read=FPictureMaskFromDataSet, write=FPictureMaskFromDataSet, default=1};
	__property Classes::TStrings* PictureMasks = {read=FPictureMasks, write=SetPictureMasks};
	__property Db::TDataSource* DataSource = {read=GetDataSource, write=SetDataSource};
	__property Wwframe::TwwEditFrame* EditFrame = {read=FDefaultEditFrame, write=FDefaultEditFrame};
	__property Wwrcdvw::TwwEditSpacing* EditSpacing = {read=FEditSpacing, write=FEditSpacing};
	__property Wwrcdvw::TwwMargin* Margin = {read=FMargin, write=FMargin};
	__property TwwRecordViewPanelStyle Style = {read=FStyle, write=SetStyle, default=0};
	__property TwwRecordViewPanelOptions Options = {read=FOptions, write=SetOptions, default=108};
	__property Wwrcdvw::TwwRecordViewControlOptions ControlOptions = {read=FControlOptions, write=SetControlOptions, nodefault};
	__property Graphics::TFont* LabelFont = {read=FLabelFont, write=SetLabelFont};
	__property Graphics::TColor ReadOnlyColor = {read=FReadOnlyColor, write=FReadOnlyColor, default=-16777197};
	__property Classes::TStrings* Selected = {read=FSelected, write=FSelected};
	__property int LinesPerMemoControl = {read=FLinesPerMemoControl, write=SetLinesPerMemoControl, default=2};
	__property TwwRecordOnBeforeCreateControl OnBeforeCreateControl = {read=FOnBeforeCreateControl, write=FOnBeforeCreateControl};
	__property TwwRecordOnAfterCreateControl OnAfterCreateControl = {read=FOnAfterCreateControl, write=FOnAfterCreateControl};
	__property TwwRecordSetControlEffects OnSetControlEffects = {read=FOnSetControlEffects, write=FOnSetControlEffects};
public:
	#pragma option push -w-inl
	/* TWinControl.CreateParented */ inline __fastcall TwwRecordViewPanel(HWND ParentWindow) : Forms::TScrollBox(ParentWindow) { }
	#pragma option pop
	
};


//-- var, const, procedure ---------------------------------------------------
#pragma error Unsupported symbol type (23, wwrcdpnl)
extern PACKAGE void __fastcall Register(void);

}	/* namespace Wwrcdpnl */
using namespace Wwrcdpnl;
#pragma option pop	// -w-
#pragma option pop	// -Vx

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// wwrcdpnl
