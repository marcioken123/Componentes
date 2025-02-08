// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDFormA.pas' rev: 31.00 (Windows)

#ifndef LmdformaHPP
#define LmdformaHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <System.SysUtils.hpp>
#include <System.Classes.hpp>
#include <Vcl.Controls.hpp>
#include <Winapi.Messages.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.Forms.hpp>
#include <Winapi.ShellAPI.hpp>
#include <Vcl.Menus.hpp>
#include <LMDClass.hpp>
#include <LMDCont.hpp>
#include <LMDGraph.hpp>
#include <LMDStrings.hpp>
#include <LMDBase.hpp>
#include <LMDProcs.hpp>
#include <LMDFormPersistent.hpp>
#include <LMDObject.hpp>
#include <LMDFMDrop.hpp>
#include <LMDWndProcComponent.hpp>
#include <LMDIniCtrl.hpp>
#include <LMDCustomComponent.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdforma
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDAutoDockObject;
class DELPHICLASS TLMDForm;
//-- type declarations -------------------------------------------------------
typedef void __fastcall (__closure *TLMDSendIntegerEvent)(System::TObject* Sender, int Value);

typedef void __fastcall (__closure *TLMDSendStringEvent)(System::TObject* Sender, const System::UnicodeString Section);

enum DECLSPEC_DENUM TLMDAutoDockSide : unsigned char { adLeft, adTop, adBottom, adRight };

typedef System::Set<TLMDAutoDockSide, TLMDAutoDockSide::adLeft, TLMDAutoDockSide::adRight> TLMDAutoDockSides;

class PASCALIMPLEMENTATION TLMDAutoDockObject : public Lmdobject::TLMDObject
{
	typedef Lmdobject::TLMDObject inherited;
	
private:
	bool FAfterMove;
	bool FEnabled;
	TLMDAutoDockSides FMoveOut;
	TLMDAutoDockSides FSides;
	int FLeft;
	int FRight;
	int FTop;
	int FBottom;
	
public:
	__fastcall virtual TLMDAutoDockObject(System::Classes::TPersistent* Owner);
	
__published:
	__property bool AfterMove = {read=FAfterMove, write=FAfterMove, default=1};
	__property bool Enabled = {read=FEnabled, write=FEnabled, default=0};
	__property TLMDAutoDockSides Sides = {read=FSides, write=FSides, default=15};
	__property TLMDAutoDockSides MoveOut = {read=FMoveOut, write=FMoveOut, default=15};
	__property int Left = {read=FLeft, write=FLeft, default=40};
	__property int Right = {read=FRight, write=FRight, default=40};
	__property int Top = {read=FTop, write=FTop, default=40};
	__property int Bottom = {read=FLeft, write=FLeft, default=40};
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TLMDAutoDockObject(void) { }
	
};


class PASCALIMPLEMENTATION TLMDForm : public Lmdformpersistent::TLMDFormPersistent
{
	typedef Lmdformpersistent::TLMDFormPersistent inherited;
	
private:
	Lmdclass::TLMDCharCase FCharCase;
	TLMDAutoDockObject* FAutoDock;
	bool FAcceptFiles;
	Lmdclass::TLMDDlgEffect FEffect;
	System::Classes::TNotifyEvent FOnAPMResume;
	System::Classes::TNotifyEvent FOnAPMCriticalResume;
	Lmdbase::TLMDStandardEvent FOnAPMSuspend;
	TLMDSendIntegerEvent FOnCompacting;
	TLMDSendStringEvent FOnDevModeChange;
	Lmdfmdrop::TLMDFMDragDropEvent FOnDragDrop;
	System::Classes::TNotifyEvent FOnFontCHange;
	System::Classes::TNotifyEvent FOnPaintIcon;
	TLMDSendIntegerEvent FOnSpoolerStatus;
	System::Classes::TNotifyEvent FOnTimeChange;
	TLMDSendStringEvent FOnWinIniChange;
	void __fastcall SetAutoDock(TLMDAutoDockObject* const Value);
	HIDESBASE void __fastcall HandleMessage(Winapi::Messages::TMessage &Message);
	void __fastcall SetAcceptFiles(bool aValue);
	
protected:
	virtual void __fastcall Init(void);
	virtual void __fastcall RestoreState(void);
	virtual void __fastcall WndProc(Winapi::Messages::TMessage &Message);
	
public:
	__fastcall virtual TLMDForm(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TLMDForm(void);
	
__published:
	__property bool AcceptFiles = {read=FAcceptFiles, write=SetAcceptFiles, default=0};
	__property Lmdclass::TLMDCharCase CharCase = {read=FCharCase, write=FCharCase, default=0};
	__property Lmdclass::TLMDDlgEffect Effect = {read=FEffect, write=FEffect, default=0};
	__property TLMDAutoDockObject* AutoDock = {read=FAutoDock, write=SetAutoDock};
	__property System::Classes::TNotifyEvent OnAPMCriticalResume = {read=FOnAPMCriticalResume, write=FOnAPMCriticalResume};
	__property System::Classes::TNotifyEvent OnAPMResume = {read=FOnAPMResume, write=FOnAPMResume};
	__property Lmdbase::TLMDStandardEvent OnAPMSuspendRequest = {read=FOnAPMSuspend, write=FOnAPMSuspend};
	__property TLMDSendIntegerEvent OnCompacting = {read=FOnCompacting, write=FOnCompacting};
	__property TLMDSendStringEvent OnDevModeChange = {read=FOnDevModeChange, write=FOnDevModeChange};
	__property TLMDSendStringEvent OnIniChange = {read=FOnWinIniChange, write=FOnWinIniChange};
	__property Lmdfmdrop::TLMDFMDragDropEvent OnFMDragDrop = {read=FOnDragDrop, write=FOnDragDrop};
	__property System::Classes::TNotifyEvent OnPaintIcon = {read=FOnPaintIcon, write=FOnPaintIcon};
	__property TLMDSendIntegerEvent OnSpoolerStatus = {read=FOnSpoolerStatus, write=FOnSpoolerStatus};
	__property System::Classes::TNotifyEvent OnTimeChange = {read=FOnTimeChange, write=FOnTimeChange};
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdforma */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDFORMA)
using namespace Lmdforma;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdformaHPP
