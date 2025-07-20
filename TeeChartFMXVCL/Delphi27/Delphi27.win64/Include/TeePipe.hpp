// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'TeePipe.pas' rev: 34.00 (Windows)

#ifndef TeepipeHPP
#define TeepipeHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <System.Classes.hpp>
#include <System.SysUtils.hpp>
#include <Vcl.Graphics.hpp>
#include <VCLTee.TeCanvas.hpp>
#include <TeeBlocks.hpp>
#include <TeeExtruded.hpp>

//-- user supplied -----------------------------------------------------------

namespace Teepipe
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TPipeBlock;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TPipeBlock : public Teeextruded::TPathBlock
{
	typedef Teeextruded::TPathBlock inherited;
	
private:
	bool FClosed;
	Teeblocks::TCustomBlock* FConnector;
	bool FConnectorVisible;
	Vcltee::Tecanvas::TPointXYFloat* FRadius;
	bool ICustomConnector;
	Teeblocks::TCustomBlock* IGlobalConnector;
	void __fastcall CreateConnector();
	bool __fastcall IsConnectorStored();
	void __fastcall SetClosed(const bool Value);
	void __fastcall SetConnector(Teeblocks::TCustomBlock* const Value);
	void __fastcall SetConnectorVisible(const bool Value);
	void __fastcall SetRadius(Vcltee::Tecanvas::TPointXYFloat* const Value);
	
protected:
	virtual void __fastcall DeleteLists();
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation Operation);
	
public:
	__fastcall virtual TPipeBlock(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TPipeBlock();
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	virtual void __fastcall Draw();
	
__published:
	__property bool Closed = {read=FClosed, write=SetClosed, default=0};
	__property Teeblocks::TCustomBlock* Connector = {read=FConnector, write=SetConnector, stored=IsConnectorStored};
	__property bool ConnectorVisible = {read=FConnectorVisible, write=SetConnectorVisible, default=1};
	__property Vcltee::Tecanvas::TPointXYFloat* Radius = {read=FRadius, write=SetRadius};
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Teepipe */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_TEEPIPE)
using namespace Teepipe;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// TeepipeHPP
