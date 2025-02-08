// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'ElEditCmds.pas' rev: 31.00 (Windows)

#ifndef EleditcmdsHPP
#define EleditcmdsHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.Classes.hpp>
#include <System.SysUtils.hpp>
#include <Winapi.Windows.hpp>
#include <LMDTypes.hpp>
#include <LMDObjectList.hpp>

//-- user supplied -----------------------------------------------------------

namespace Eleditcmds
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TElKeyCommand;
class DELPHICLASS TElKeyCommandList;
//-- type declarations -------------------------------------------------------
typedef int TElCommand;

#pragma pack(push,4)
class PASCALIMPLEMENTATION TElKeyCommand : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	System::Classes::TShortCut __fastcall GetShortCut(void);
	
protected:
	System::Word FKey;
	System::Classes::TShiftState FShiftState;
	System::Word FKey2;
	System::Classes::TShiftState FShiftState2;
	TElCommand FCommand;
	Lmdtypes::TLMDString FDescription;
	
public:
	__fastcall TElKeyCommand(const System::Word AKey, const System::Classes::TShiftState AShiftState, const TElCommand ACommand, const Lmdtypes::TLMDString ADescription)/* overload */;
	__fastcall TElKeyCommand(const System::Word AKey, const System::Classes::TShiftState AShiftState, const System::Word AKey2, const System::Classes::TShiftState AShiftState2, const TElCommand ACommand, const Lmdtypes::TLMDString ADescription)/* overload */;
	__property System::Word Key = {read=FKey, nodefault};
	__property System::Classes::TShiftState ShiftState = {read=FShiftState, nodefault};
	__property System::Word Key2 = {read=FKey2, nodefault};
	__property System::Classes::TShiftState ShiftState2 = {read=FShiftState2, nodefault};
	__property TElCommand Command = {read=FCommand, nodefault};
	__property Lmdtypes::TLMDString Description = {read=FDescription};
	__property System::Classes::TShortCut ShortCut = {read=GetShortCut, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TElKeyCommand(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TElKeyCommandList : public System::TObject
{
	typedef System::TObject inherited;
	
public:
	TElKeyCommand* operator[](TElCommand Index) { return this->Commands[Index]; }
	
protected:
	Lmdobjectlist::TLMDObjectList* FCommandList;
	TElKeyCommand* __fastcall GetCommand(TElCommand Index);
	
public:
	__fastcall TElKeyCommandList(void);
	__fastcall virtual ~TElKeyCommandList(void);
	void __fastcall DefaultKeyBind(void);
	void __fastcall Add(const System::Word AKey, const System::Classes::TShiftState AShiftState, const TElCommand ACommand, const Lmdtypes::TLMDString ADescription)/* overload */;
	void __fastcall Add(const System::Word AKey, const System::Classes::TShiftState AShiftState, const System::Word AKey2, const System::Classes::TShiftState AShiftState2, const TElCommand ACommand, const Lmdtypes::TLMDString ADescription)/* overload */;
	TElCommand __fastcall Find(System::Word AKey, System::Classes::TShiftState AShiftState)/* overload */;
	TElCommand __fastcall Find(const System::Word AKey, const System::Classes::TShiftState AShiftState, System::Word AKey2, const System::Classes::TShiftState AShiftState2)/* overload */;
	void __fastcall Delete(TElCommand ACommand);
	__property TElKeyCommand* Commands[TElCommand Index] = {read=GetCommand/*, default*/};
};

#pragma pack(pop)

//-- var, const, procedure ---------------------------------------------------
static const System::Int8 eecLeft = System::Int8(0x1);
static const System::Int8 eecRight = System::Int8(0x2);
static const System::Int8 eecUp = System::Int8(0x3);
static const System::Int8 eecDown = System::Int8(0x4);
static const System::Int8 eecLineHome = System::Int8(0x5);
static const System::Int8 eecLineEnd = System::Int8(0x6);
static const System::Int8 eecNextWord = System::Int8(0x7);
static const System::Int8 eecPrevWord = System::Int8(0x8);
static const System::Int8 eecPageUp = System::Int8(0x9);
static const System::Int8 eecPageDown = System::Int8(0xa);
static const System::Int8 eecTextHome = System::Int8(0xb);
static const System::Int8 eecTextEnd = System::Int8(0xc);
static const System::Int8 eecUndo = System::Int8(0x65);
static const System::Int8 eecRedo = System::Int8(0x66);
static const System::Int8 eecCut = System::Int8(0x67);
static const System::Int8 eecCopy = System::Int8(0x68);
static const System::Int8 eecPaste = System::Int8(0x69);
static const System::Int8 eecDeletePrevChar = System::Int8(0x6a);
static const System::Int8 eecDeleteChar = System::Int8(0x6b);
static const System::Int8 eecDeletePrevWord = System::Int8(0x6c);
static const System::Int8 eecDeleteWord = System::Int8(0x6d);
static const System::Int8 eecChar = System::Int8(0x6e);
static const System::Int8 eecNewLine = System::Int8(0x6f);
static const System::Int8 eecTab = System::Int8(0x70);
static const System::Int8 eecIndent = System::Int8(0x71);
static const System::Int8 eecUnIndent = System::Int8(0x72);
static const System::Int8 eecWideString = System::Int8(0x73);
static const System::Int8 eecSetBookmark0 = System::Int8(0x76);
static const System::Int8 eecSetBookmark1 = System::Int8(0x77);
static const System::Int8 eecSetBookmark2 = System::Int8(0x78);
static const System::Int8 eecSetBookmark3 = System::Int8(0x79);
static const System::Int8 eecSetBookmark4 = System::Int8(0x7a);
static const System::Int8 eecSetBookmark5 = System::Int8(0x7b);
static const System::Int8 eecSetBookmark6 = System::Int8(0x7c);
static const System::Int8 eecSetBookmark7 = System::Int8(0x7d);
static const System::Int8 eecSetBookmark8 = System::Int8(0x7e);
static const System::Int8 eecSetBookmark9 = System::Int8(0x7f);
static const System::Byte eecGotoBookmark0 = System::Byte(0x83);
static const System::Byte eecGotoBookmark1 = System::Byte(0x84);
static const System::Byte eecGotoBookmark2 = System::Byte(0x85);
static const System::Byte eecGotoBookmark3 = System::Byte(0x86);
static const System::Byte eecGotoBookmark4 = System::Byte(0x87);
static const System::Byte eecGotoBookmark5 = System::Byte(0x88);
static const System::Byte eecGotoBookmark6 = System::Byte(0x89);
static const System::Byte eecGotoBookmark7 = System::Byte(0x8a);
static const System::Byte eecGotoBookmark8 = System::Byte(0x8b);
static const System::Byte eecGotoBookmark9 = System::Byte(0x8c);
static const System::Byte eecSetStress = System::Byte(0x8d);
static const System::Byte eecSelectCommands = System::Byte(0xc8);
static const System::Byte eecSelectLeft = System::Byte(0xc9);
static const System::Byte eecSelectRight = System::Byte(0xca);
static const System::Byte eecSelectHome = System::Byte(0xcb);
static const System::Byte eecSelectEnd = System::Byte(0xcc);
static const System::Byte eecSelectPrevAll = System::Byte(0xcd);
static const System::Byte eecSelectNextAll = System::Byte(0xce);
static const System::Byte eecSelectPrevWord = System::Byte(0xcf);
static const System::Byte eecSelectNextWord = System::Byte(0xd0);
static const System::Byte eecSelectUp = System::Byte(0xd1);
static const System::Byte eecSelectDown = System::Byte(0xd2);
static const System::Byte eecSelectPageUp = System::Byte(0xd3);
static const System::Byte eecSelectPageDown = System::Byte(0xd4);
static const System::Byte eecSelectAll = System::Byte(0xd7);
static const System::Byte eecSelectDelete = System::Byte(0xd8);
static const System::Byte eecSelectNone = System::Byte(0xd9);
static const System::Int8 eecNone = System::Int8(0x0);
static const int eecLastCommand = int(2147483647);
static const int eecWaitForSecondKey = int(0x7ffffffe);
}	/* namespace Eleditcmds */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_ELEDITCMDS)
using namespace Eleditcmds;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// EleditcmdsHPP
