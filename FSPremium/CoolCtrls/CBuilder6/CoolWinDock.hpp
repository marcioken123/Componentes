// Borland C++ Builder
// Copyright (c) 1995, 2002 by Borland Software Corporation
// All rights reserved

// (DO NOT EDIT: machine generated header) 'CoolWinDock.pas' rev: 6.00

#ifndef CoolWinDockHPP
#define CoolWinDockHPP

#pragma delphiheader begin
#pragma option push -w-
#pragma option push -Vx
#include <CoolCtrls.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <Messages.hpp>	// Pascal unit
#include <Controls.hpp>	// Pascal unit
#include <Forms.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <System.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Coolwindock
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TCoolWinDock;
class PASCALIMPLEMENTATION TCoolWinDock : public Classes::TComponent 
{
	typedef Classes::TComponent inherited;
	
private:
	Coolctrls::TCCAboutBox* fAboutBox;
	Forms::TForm* fForm;
	Classes::TWndMethod fOrigWndProc;
	int fMagRange;
	int fOffsetX;
	int fOffsetY;
	int SourceFormWidth;
	int SourceFormHeight;
	bool fSticky;
	int fGroupIndex;
	bool fMoving;
	Word fSizingEdge;
	#pragma pack(push, 1)
	Types::TRect fStartPoint;
	#pragma pack(pop)
	
	void __fastcall WndProc(Messages::TMessage &Message);
	bool __fastcall CheckVertBorder(const int RealPos, const int OtherBorderXPos, const int OtherBorderTop, const int OtherBorderBottom, const bool CheckLeft, Types::PRect PWinRect);
	bool __fastcall CheckHorzBorder(const int RealPos, const int OtherBorderYPos, const int OtherBorderLeft, const int OtherBorderRight, const bool CheckTop, Types::PRect PWinRect);
	void __fastcall ProcFindMagnet(Messages::TMessage &Msg);
	void __fastcall ProcMoveSize(Messages::TMessage &Message);
	void __fastcall ProcBeginMove(void);
	void __fastcall SetFollow(Classes::TList* MasterMagList);
	bool __fastcall FormsTouch(Forms::TForm* RemForm);
	Types::TRect __fastcall FormToRect(Forms::TForm* frm);
	void __fastcall MoveFollowersBy(int MovX, int MovY);
	AnsiString __fastcall GetVersion();
	void __fastcall SetVersion(const AnsiString Value);
	
protected:
	Classes::TList* fMagList;
	bool fFollowMove;
	
public:
	__fastcall virtual TCoolWinDock(Classes::TComponent* AOwner);
	__fastcall virtual ~TCoolWinDock(void);
	__property AnsiString Version = {read=GetVersion, write=SetVersion};
	
__published:
	__property Coolctrls::TCCAboutBox* About = {read=fAboutBox, write=fAboutBox};
	__property int MagRange = {read=fMagRange, write=fMagRange, nodefault};
	__property bool Sticky = {read=fSticky, write=fSticky, nodefault};
	__property int GroupIndex = {read=fGroupIndex, write=fGroupIndex, nodefault};
};


//-- var, const, procedure ---------------------------------------------------
static const Word WMFindMagnet = 0x67a;
#define C_Version "V 1.12"

}	/* namespace Coolwindock */
using namespace Coolwindock;
#pragma option pop	// -w-
#pragma option pop	// -Vx

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// CoolWinDock
