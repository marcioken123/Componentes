// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDUpdateMessage.pas' rev: 31.00 (Windows)

#ifndef LmdupdatemessageHPP
#define LmdupdatemessageHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <LMDTypes.hpp>
#include <LMDWebConfig.hpp>
#include <System.Classes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdupdatemessage
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDUpdateMessage;
//-- type declarations -------------------------------------------------------
enum DECLSPEC_DENUM TLMDUpdateMessageType : unsigned char { umtBreakUpdate, umtError, umtScript, umtProgress, umtFinish, umtGetConfig, umtInfo, umtConfirm, umtCloseRequest };

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDUpdateMessage : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	TLMDUpdateMessageType FMsgType;
	Lmdtypes::TLMDString FDescr;
	System::Byte FPercent;
	Lmdtypes::TLMDString FCurFileName;
	unsigned FCurFileSize;
	unsigned FTimeEstimateElapsed;
	int FErrCode;
	int FDbID;
	Lmdwebconfig::TLMDWebConfig* FWebConfig;
	HRESULT FResult;
	
public:
	void __fastcall SaveToStream(System::Classes::TStream* AStream);
	void __fastcall LoadFromStream(System::Classes::TStream* AStream);
	__property TLMDUpdateMessageType MsgType = {read=FMsgType, write=FMsgType, nodefault};
	__property Lmdtypes::TLMDString Descr = {read=FDescr, write=FDescr};
	__property System::Byte Percent = {read=FPercent, write=FPercent, nodefault};
	__property Lmdtypes::TLMDString CurFileName = {read=FCurFileName, write=FCurFileName};
	__property unsigned CurFileSize = {read=FCurFileSize, write=FCurFileSize, nodefault};
	__property unsigned TimeEstimateElapsed = {read=FTimeEstimateElapsed, write=FTimeEstimateElapsed, nodefault};
	__property int ErrCode = {read=FErrCode, write=FErrCode, nodefault};
	__property int DbID = {read=FDbID, write=FDbID, nodefault};
	__property Lmdwebconfig::TLMDWebConfig* WebConfig = {read=FWebConfig, write=FWebConfig};
	__property HRESULT Result = {read=FResult, write=FResult, nodefault};
public:
	/* TObject.Create */ inline __fastcall TLMDUpdateMessage(void) : System::TObject() { }
	/* TObject.Destroy */ inline __fastcall virtual ~TLMDUpdateMessage(void) { }
	
};

#pragma pack(pop)

//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdupdatemessage */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDUPDATEMESSAGE)
using namespace Lmdupdatemessage;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdupdatemessageHPP
