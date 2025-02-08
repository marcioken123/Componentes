// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDFormPersistent.pas' rev: 31.00 (Windows)

#ifndef LmdformpersistentHPP
#define LmdformpersistentHPP

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
#include <Vcl.Menus.hpp>
#include <LMDClass.hpp>
#include <LMDCont.hpp>
#include <LMDGraph.hpp>
#include <LMDStrings.hpp>
#include <LMDProcs.hpp>
#include <LMDWndProcComponent.hpp>
#include <LMDIniCtrl.hpp>
#include <LMDCustomComponent.hpp>
#include <System.Types.hpp>
#include <LMDTypes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdformpersistent
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDFormPersistent;
//-- type declarations -------------------------------------------------------
typedef void __fastcall (__closure *TLMDSizingChangeEvent)(System::TObject* Sender, System::Word xsize, System::Word ysize, System::Word flag);

typedef void __fastcall (__closure *TLMDMaxInfoEvent)(System::TObject* Sender, int &xpos, int &ypos, int &MaxWidth, int &MaxHeight);

typedef void __fastcall (__closure *TLMDMovingEvent)(System::TObject* Sender, int x, int y, bool &Cancel);

typedef void __fastcall (__closure *TLMDTrackInfoEvent)(System::TObject* Sender, int &MinWidth, int &MinHeight, int &MaxWidth, int &MaxHeight);

enum DECLSPEC_DENUM TLMDFormIniSaveOption : unsigned char { soColor, soFont, soPos, soSize, soState };

typedef System::Set<TLMDFormIniSaveOption, TLMDFormIniSaveOption::soColor, TLMDFormIniSaveOption::soState> TLMDFormIniSaveOptions;

enum DECLSPEC_DENUM TLMDFormOption : unsigned char { foAutoCenter, foAutoShow, foTryAdaptRes, foRestoreOnce, foWriteOnClose };

typedef System::Set<TLMDFormOption, TLMDFormOption::foAutoCenter, TLMDFormOption::foWriteOnClose> TLMDFormOptions;

class PASCALIMPLEMENTATION TLMDFormPersistent : public Lmdwndproccomponent::TLMDWndProcComponent
{
	typedef Lmdwndproccomponent::TLMDWndProcComponent inherited;
	
private:
	Lmdinictrl::TLMDIniCtrl* FIniLink;
	Lmdinictrl::TLMDIniUse FIniUse;
	System::UnicodeString FSection;
	System::UnicodeString FKey;
	TLMDFormIniSaveOptions FIniOptions;
	TLMDFormOptions FOptions;
	int FDesignPPI;
	bool FInternal;
	bool FRestored;
	System::Types::TRect FTrackInfo;
	System::Types::TRect FMaximized;
	int FMaximizedHeight;
	int FMaximizedWidth;
	int FMaxHeight;
	int FMaxWidth;
	int FMinHeight;
	int FMinWidth;
	int FMaximizedPosX;
	int FMaximizedPosY;
	bool FWriteChanges;
	TLMDSizingChangeEvent FOnDisplayChange;
	System::Classes::TNotifyEvent FOnFontChange;
	System::Classes::TNotifyEvent FOnSysColorChange;
	TLMDMaxInfoEvent FOnMaximize;
	System::Classes::TNotifyEvent FOnMove;
	TLMDMovingEvent FOnMoving;
	TLMDSizingChangeEvent FOnSize;
	TLMDTrackInfoEvent FOnTrackInfoEvent;
	Vcl::Forms::TCloseEvent FOwnerFormClose;
	System::Classes::TNotifyEvent FOwnerFormShow;
	System::Classes::TNotifyEvent FOwnerFormDestroy;
	System::Classes::TNotifyEvent FOnNoData;
	void __fastcall OwnerFormShow(System::TObject* Sender);
	void __fastcall OwnerFormDestroy(System::TObject* Sender);
	void __fastcall OwnerFormClose(System::TObject* Sender, System::Uitypes::TCloseAction &Action);
	int __fastcall GetRealValue(int aValue, bool vertical);
	void __fastcall HandleMessage(Winapi::Messages::TMessage &Message);
	void __fastcall SetInteger(int Index, int aValue);
	void __fastcall SetIniLink(Lmdinictrl::TLMDIniCtrl* aValue);
	bool __fastcall SaveKey(void);
	bool __fastcall SaveSection(void);
	System::Types::TRect __fastcall GetWorkRect(void);
	
protected:
	virtual void __fastcall Loaded(void);
	virtual void __fastcall Init(void);
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation Operation);
	virtual void __fastcall ReadState(System::Classes::TReader* Reader);
	void __fastcall SetRunTimeValues(void);
	virtual void __fastcall WndProc(Winapi::Messages::TMessage &Message);
	
public:
	__fastcall virtual TLMDFormPersistent(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TLMDFormPersistent(void);
	void __fastcall SetMaximizedRect(const System::Types::TRect &aRect);
	void __fastcall SetTrackMaxValues(const System::Types::TPoint &aValue);
	void __fastcall SetTrackMinValues(const System::Types::TPoint &aValue);
	void __fastcall AdaptResolution(void);
	System::UnicodeString __fastcall GetIniString(void);
	void __fastcall SetIniString(const System::UnicodeString aString);
	void __fastcall ReadData(void);
	void __fastcall WriteData(void);
	__property System::Types::TRect ScreenWorkArea = {read=GetWorkRect};
	
__published:
	__property About = {default=0};
	__property Lmdinictrl::TLMDIniCtrl* IniLink = {read=FIniLink, write=SetIniLink};
	__property Lmdinictrl::TLMDIniUse IniUse = {read=FIniUse, write=FIniUse, default=2};
	__property TLMDFormIniSaveOptions IniSaveOptions = {read=FIniOptions, write=FIniOptions, default=28};
	__property System::UnicodeString Section = {read=FSection, write=FSection, stored=SaveSection};
	__property System::UnicodeString IniKey = {read=FKey, write=FKey, stored=SaveKey};
	__property int DesignPPI = {read=FDesignPPI, write=FDesignPPI, default=96};
	__property TLMDFormOptions Options = {read=FOptions, write=FOptions, default=2};
	__property Enabled = {default=1};
	__property int MaximizedHeight = {read=FMaximizedHeight, write=SetInteger, index=4, default=0};
	__property int MaximizedWidth = {read=FMaximizedWidth, write=SetInteger, index=5, default=0};
	__property int MaximizedPosX = {read=FMaximizedPosX, write=SetInteger, index=6, default=0};
	__property int MaximizedPosY = {read=FMaximizedPosY, write=SetInteger, index=7, default=0};
	__property int TrackMaxHeight = {read=FMaxHeight, write=SetInteger, index=0, default=0};
	__property int TrackMaxWidth = {read=FMaxWidth, write=SetInteger, index=1, default=0};
	__property int TrackMinHeight = {read=FMinHeight, write=SetInteger, index=2, default=0};
	__property int TrackMinWidth = {read=FMinWidth, write=SetInteger, index=3, default=0};
	__property System::Classes::TNotifyEvent OnNoRestoreData = {read=FOnNoData, write=FOnNoData};
	__property TLMDSizingChangeEvent OnDisplayChange = {read=FOnDisplayChange, write=FOnDisplayChange};
	__property System::Classes::TNotifyEvent OnFontChange = {read=FOnFontChange, write=FOnFontChange};
	__property TLMDMaxInfoEvent OnMaximizeInfo = {read=FOnMaximize, write=FOnMaximize};
	__property System::Classes::TNotifyEvent OnMove = {read=FOnMove, write=FOnMove};
	__property TLMDMovingEvent OnMoving = {read=FOnMoving, write=FOnMoving};
	__property TLMDSizingChangeEvent OnSize = {read=FOnSize, write=FOnSize};
	__property System::Classes::TNotifyEvent OnSysColorChange = {read=FOnSysColorChange, write=FOnSysColorChange};
	__property TLMDTrackInfoEvent OnTrackInfo = {read=FOnTrackInfoEvent, write=FOnTrackInfoEvent};
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdformpersistent */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDFORMPERSISTENT)
using namespace Lmdformpersistent;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdformpersistentHPP
