// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDObj.pas' rev: 31.00 (Windows)

#ifndef LmdobjHPP
#define LmdobjHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <System.SysUtils.hpp>
#include <Winapi.Messages.hpp>
#include <System.Classes.hpp>
#include <Vcl.Forms.hpp>
#include <Vcl.ExtCtrls.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.Menus.hpp>
#include <Vcl.Dialogs.hpp>
#include <System.RTLConsts.hpp>
#include <LMDConst.hpp>
#include <LMDClass.hpp>
#include <LMDGraph.hpp>
#include <LMDBase.hpp>
#include <LMDBaseGraphicControl.hpp>
#include <LMDGraphicControl.hpp>
#include <LMDPointList.hpp>
#include <LMDBaseMeter.hpp>
#include <LMDSmallBar.hpp>
#include <LMDCustomPanelFill.hpp>
#include <LMDGradient.hpp>
#include <LMDCaption.hpp>
#include <LMDTransparent.hpp>
#include <LMDSimpleBevel.hpp>
#include <LMDCustomComponent.hpp>
#include <LMDShape.hpp>
#include <LMDObject.hpp>
#include <LMDBaseControl.hpp>
#include <LMDControl.hpp>
#include <LMDCustomBevelPanel.hpp>
#include <LMDCustomPanel.hpp>
#include <LMDCustomControl.hpp>
#include <System.UITypes.hpp>
#include <LMDTypes.hpp>
#include <System.Types.hpp>
#include <LMDBevel.hpp>
#include <LMDCustomParentPanel.hpp>
#include <LMDFXCaption.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdobj
{
//-- forward type declarations -----------------------------------------------
struct TFramePos;
struct TLMDAniFrame;
class DELPHICLASS TLMDApp;
class DELPHICLASS TLMDScreenCanvas;
class DELPHICLASS TLMDFrameList;
class DELPHICLASS TLMDAnimation;
class DELPHICLASS TLMDClip;
class DELPHICLASS TLMDAniClip;
class DELPHICLASS TLMDAniPicClip;
class DELPHICLASS TLMDPicClip;
class DELPHICLASS TLMDCustomImage;
class DELPHICLASS TLMDAniImage;
class DELPHICLASS TLMDImage;
class DELPHICLASS TLMDBmpOptions;
class DELPHICLASS TLMDMeter;
class DELPHICLASS TLMDPanel;
class DELPHICLASS TLMDTile;
//-- type declarations -------------------------------------------------------
enum DECLSPEC_DENUM TLMDBackmode : unsigned char { tmNone, tmCenter, tmGradient, tmTile, tmStretch };

typedef TLMDBackmode TBackMode;

enum DECLSPEC_DENUM TLMDOldBitmapStyle : unsigned char { sbNone, sbAutosize, sbCenter, sbStretch, sbTile };

enum DECLSPEC_DENUM TLMDAnStyle : unsigned char { anOPShowLast, anOPFirst, anOPOldCell, anOPInvisible, anLoop, anLoopInvisible };

struct DECLSPEC_DRECORD TFramePos
{
public:
	System::Word startpic;
	System::Word EndPic;
};


typedef TLMDAniFrame *PFrame;

struct DECLSPEC_DRECORD TLMDAniFrame
{
public:
	System::SmallString<24> Name;
	System::Word IndexNr;
	TFramePos Pos;
	System::Word Unused;
};


typedef void __fastcall (__closure *TLMDAnimationEvent)(System::TObject* Sender, const TLMDAniFrame &info, const System::Word pos, bool &Cancel);

class PASCALIMPLEMENTATION TLMDApp : public Lmdcustomcomponent::TLMDCustomComponent
{
	typedef Lmdcustomcomponent::TLMDCustomComponent inherited;
	
private:
	System::UnicodeString FTitle;
	System::Sysutils::TFileName FHelpFile;
	System::Uitypes::TColor FHintColor;
	int FHintPause;
	int FHintHidePause;
	int FHintShortPause;
	bool FShowHint;
	Vcl::Graphics::TPicture* FPicture;
	bool FUpdateFormatSettings;
	System::Classes::TNotifyEvent FOnHint;
	Vcl::Forms::TShowHintEvent FOnShowHint;
	System::Classes::TNotifyEvent FOnActivate;
	System::Classes::TNotifyEvent FOnDeactivate;
	Vcl::Forms::TExceptionEvent FOnException;
	Vcl::Forms::TMessageEvent FOnMessage;
	Vcl::Forms::THelpEvent FOnHelp;
	Vcl::Forms::TIdleEvent FOnIdle;
	System::Classes::TNotifyEvent FOnRestore;
	System::Classes::TNotifyEvent FOnMinimize;
	void __fastcall SetIcon(Vcl::Graphics::TIcon* aValue);
	Vcl::Graphics::TIcon* __fastcall GetIcon(void);
	
protected:
	virtual void __fastcall Loaded(void);
	
public:
	__fastcall virtual TLMDApp(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TLMDApp(void);
	
__published:
	__property About = {default=0};
	__property System::Uitypes::TColor HintColor = {read=FHintColor, write=FHintColor, default=-16777192};
	__property int HintPause = {read=FHintPause, write=FHintPause, default=500};
	__property int HintHidePause = {read=FHintHidePause, write=FHintHidePause, default=2500};
	__property int HintShortPause = {read=FHintShortPause, write=FHintShortPause, default=50};
	__property Vcl::Graphics::TIcon* Icon = {read=GetIcon, write=SetIcon};
	__property System::Sysutils::TFileName HelpFile = {read=FHelpFile, write=FHelpFile};
	__property bool ShowHint = {read=FShowHint, write=FShowHint, default=1};
	__property System::UnicodeString Title = {read=FTitle, write=FTitle};
	__property bool UpdateFormatSettings = {read=FUpdateFormatSettings, write=FUpdateFormatSettings, default=1};
	__property System::Classes::TNotifyEvent OnActivate = {read=FOnActivate, write=FOnActivate};
	__property System::Classes::TNotifyEvent OnDeactivate = {read=FOnDeactivate, write=FOnDeactivate};
	__property Vcl::Forms::TExceptionEvent OnException = {read=FOnException, write=FOnException};
	__property Vcl::Forms::THelpEvent OnHelp = {read=FOnHelp, write=FOnHelp};
	__property Vcl::Forms::TIdleEvent OnIdle = {read=FOnIdle, write=FOnIdle};
	__property Vcl::Forms::TMessageEvent OnMessage = {read=FOnMessage, write=FOnMessage};
	__property System::Classes::TNotifyEvent OnMinimize = {read=FOnMinimize, write=FOnMinimize};
	__property System::Classes::TNotifyEvent OnHint = {read=FOnHint, write=FOnHint};
	__property System::Classes::TNotifyEvent OnRestore = {read=FOnRestore, write=FOnRestore};
	__property Vcl::Forms::TShowHintEvent OnShowHint = {read=FOnShowHint, write=FOnShowHint};
};


class PASCALIMPLEMENTATION TLMDScreenCanvas : public Lmdcustomcomponent::TLMDCustomComponent
{
	typedef Lmdcustomcomponent::TLMDCustomComponent inherited;
	
private:
	Vcl::Graphics::TBitmap* FBitmap;
	Vcl::Graphics::TCanvas* FCanvas;
	bool FSaveBack;
	bool Painting;
	int __fastcall GetInteger(int Index);
	
protected:
	Vcl::Graphics::TCanvas* __fastcall GetCanvas(void);
	
public:
	__fastcall virtual TLMDScreenCanvas(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TLMDScreenCanvas(void);
	void __fastcall BeginPaint(void);
	void __fastcall EndPaint(void);
	void __fastcall Invalidate(void);
	void __fastcall SaveScreen(void);
	__property Vcl::Graphics::TBitmap* Bitmap = {read=FBitmap};
	__property Vcl::Graphics::TCanvas* Canvas = {read=GetCanvas};
	__property int Height = {read=GetInteger, index=0, nodefault};
	__property int Width = {read=GetInteger, index=1, nodefault};
	
__published:
	__property About = {default=0};
	__property bool SaveBackground = {read=FSaveBack, write=FSaveBack, default=0};
};


class PASCALIMPLEMENTATION TLMDFrameList : public Lmdobject::TLMDObject
{
	typedef Lmdobject::TLMDObject inherited;
	
public:
	PFrame operator[](System::Word index) { return this->Frame[index]; }
	
private:
	System::Classes::TList* FList;
	System::Word __fastcall GetCount(void);
	bool __fastcall GetEmpty(void);
	PFrame __fastcall GetFrame(System::Word index);
	PFrame __fastcall GetFrameByIndex(System::Word indexnr);
	PFrame __fastcall GetFrameByName(System::UnicodeString index);
	void __fastcall DisposeItem(PFrame p);
	PFrame __fastcall NewItem(const TLMDAniFrame &aFrame);
	
public:
	__fastcall virtual TLMDFrameList(System::Classes::TPersistent* Owner);
	__fastcall virtual ~TLMDFrameList(void);
	virtual void __fastcall Add(const TLMDAniFrame &aValue);
	virtual void __fastcall AddValue(System::UnicodeString name, System::Word index, System::Word start, System::Word ende);
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	virtual void __fastcall Clear(void);
	virtual bool __fastcall Delete(System::Word index);
	virtual bool __fastcall Remove(PFrame p);
	__property System::Word Count = {read=GetCount, nodefault};
	__property bool Empty = {read=GetEmpty, nodefault};
	__property PFrame Frame[System::Word index] = {read=GetFrame/*, default*/};
	__property PFrame FrameByIndex[System::Word Indexnr] = {read=GetFrameByIndex};
	__property PFrame FrameByName[System::UnicodeString index] = {read=GetFrameByName};
};


class PASCALIMPLEMENTATION TLMDAnimation : public Lmdobject::TLMDObject
{
	typedef Lmdobject::TLMDObject inherited;
	
private:
	System::Word FIntervall;
	bool FLoopReverse;
	bool FPlayForward;
	TLMDAnStyle FStyle;
	void __fastcall SetBool(int index, bool aValue);
	void __fastcall SetInterval(System::Word aValue);
	void __fastcall SetStyle(TLMDAnStyle aValue);
	
public:
	__fastcall virtual TLMDAnimation(System::Classes::TPersistent* Owner);
	
__published:
	__property System::Word Interval = {read=FIntervall, write=SetInterval, default=200};
	__property bool LoopReverse = {read=FLoopReverse, write=SetBool, index=0, default=0};
	__property bool PlayForward = {read=FPlayForward, write=SetBool, index=1, default=1};
	__property TLMDAnStyle Style = {read=FStyle, write=SetStyle, default=0};
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TLMDAnimation(void) { }
	
};


class PASCALIMPLEMENTATION TLMDClip : public Lmdobject::TLMDObject
{
	typedef Lmdobject::TLMDObject inherited;
	
private:
	Vcl::Graphics::TBitmap* FBitmap;
	Vcl::Graphics::TBitmap* FTempBmp;
	System::Word FColumns;
	System::Word FRows;
	void __fastcall SetBitmap(Vcl::Graphics::TBitmap* aValue);
	void __fastcall SetColumns(System::Word aValue);
	void __fastcall SetRows(System::Word aValue);
	System::Word __fastcall GetCount(void);
	System::Word __fastcall GetCellExtend(int Index);
	void __fastcall DefaultValues(void);
	
protected:
	virtual bool __fastcall CheckEmpty(void);
	virtual void __fastcall GetBitmapChange(System::TObject* Sender);
	virtual bool __fastcall GetEmpty(void);
	virtual Vcl::Graphics::TBitmap* __fastcall GetLastBitmap(void);
	
public:
	__fastcall virtual TLMDClip(System::Classes::TPersistent* Owner);
	__fastcall virtual ~TLMDClip(void);
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	void __fastcall FreeClip(void);
	virtual void __fastcall FreeLastBitmap(void);
	virtual Vcl::Graphics::TBitmap* __fastcall GetArea(const System::Types::TRect &aRect);
	virtual Vcl::Graphics::TBitmap* __fastcall GetCell(System::Word Cell);
	virtual Vcl::Graphics::TBitmap* __fastcall GetCellXY(System::Word X, System::Word Y);
	void __fastcall LoadBitmap(const System::UnicodeString Filename);
	virtual void __fastcall LoadFromFile(const System::UnicodeString Filename);
	virtual void __fastcall LoadFromStream(System::Classes::TStream* Stream);
	void __fastcall SaveBitmap(const System::UnicodeString filename);
	virtual void __fastcall SaveToFile(const System::UnicodeString Filename);
	virtual void __fastcall SaveToStream(System::Classes::TStream* Stream);
	__property System::Word CellX = {read=GetCellExtend, index=0, nodefault};
	__property System::Word CellY = {read=GetCellExtend, index=1, nodefault};
	__property System::Word Count = {read=GetCount, nodefault};
	__property bool Empty = {read=GetEmpty, nodefault};
	__property Vcl::Graphics::TBitmap* LastBitmap = {read=GetLastBitmap};
	
__published:
	__property Vcl::Graphics::TBitmap* Bitmap = {read=FBitmap, write=SetBitmap};
	__property System::Word Columns = {read=FColumns, write=SetColumns, default=0};
	__property System::Word Rows = {read=FRows, write=SetRows, default=0};
};


class PASCALIMPLEMENTATION TLMDAniClip : public Lmdobject::TLMDObject
{
	typedef Lmdobject::TLMDObject inherited;
	
public:
	TLMDAniFrame operator[](System::Word index) { return this->Frame[index]; }
	
private:
	TLMDClip* FClip;
	TLMDFrameList* FFrameList;
	void __fastcall SetClip(TLMDClip* aValue);
	TLMDAniFrame __fastcall Getall(void);
	System::Word __fastcall GetCount(void);
	TLMDAniFrame __fastcall GetFrame(System::Word index);
	TFramePos __fastcall GetFramePos(System::Word index);
	TLMDAniFrame __fastcall GetFrameByIndex(System::Word indexnr);
	TLMDAniFrame __fastcall GetFrameByName(System::UnicodeString index);
	
protected:
	virtual bool __fastcall GetEmpty(void);
	virtual void __fastcall DefineProperties(System::Classes::TFiler* Filer);
	virtual void __fastcall ReadData(System::Classes::TReader* Reader);
	virtual void __fastcall WriteData(System::Classes::TWriter* Writer);
	
public:
	__fastcall virtual TLMDAniClip(System::Classes::TPersistent* Owner);
	__fastcall virtual ~TLMDAniClip(void);
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	virtual void __fastcall FreeAniClip(void);
	virtual Vcl::Graphics::TBitmap* __fastcall GetCell(System::Word Cell);
	void __fastcall LoadFromFile(const System::UnicodeString Filename);
	void __fastcall LoadFromStream(System::Classes::TStream* Stream);
	void __fastcall SaveToFile(const System::UnicodeString Filename);
	void __fastcall SaveToStream(System::Classes::TStream* Stream);
	__property System::Word Count = {read=GetCount, nodefault};
	__property bool Empty = {read=GetEmpty, nodefault};
	__property TFramePos FramePos[System::Word index] = {read=GetFramePos};
	__property TLMDAniFrame Frame[System::Word index] = {read=GetFrame/*, default*/};
	__property TLMDAniFrame FrameByIndex[System::Word Indexnr] = {read=GetFrameByIndex};
	__property TLMDAniFrame FrameByName[System::UnicodeString index] = {read=GetFrameByName};
	__property TLMDFrameList* List = {read=FFrameList};
	
__published:
	__property TLMDClip* Clip = {read=FClip, write=SetClip};
};


class PASCALIMPLEMENTATION TLMDAniPicClip : public Lmdcustomcomponent::TLMDCustomComponent
{
	typedef Lmdcustomcomponent::TLMDCustomComponent inherited;
	
private:
	TLMDAniClip* FAniClip;
	System::Classes::TNotifyEvent FOnChange;
	void __fastcall SetAniClip(TLMDAniClip* aValue);
	
protected:
	DYNAMIC void __fastcall Change(void);
	
public:
	__fastcall virtual TLMDAniPicClip(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TLMDAniPicClip(void);
	__property System::Classes::TNotifyEvent OnChange = {read=FOnChange, write=FOnChange};
	
__published:
	__property About = {default=0};
	__property TLMDAniClip* AniClip = {read=FAniClip, write=SetAniClip};
};


class PASCALIMPLEMENTATION TLMDPicClip : public Lmdcustomcomponent::TLMDCustomComponent
{
	typedef Lmdcustomcomponent::TLMDCustomComponent inherited;
	
private:
	TLMDClip* FClip;
	System::Classes::TNotifyEvent FOnChange;
	void __fastcall SetClip(TLMDClip* aValue);
	
protected:
	DYNAMIC void __fastcall Change(void);
	
public:
	__fastcall virtual TLMDPicClip(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TLMDPicClip(void);
	Vcl::Graphics::TBitmap* __fastcall GetCell(System::Word Cell);
	Vcl::Graphics::TBitmap* __fastcall GetCellXY(System::Word X, System::Word Y);
	Vcl::Graphics::TBitmap* __fastcall GetArea(const System::Types::TRect &aRect);
	__property System::Classes::TNotifyEvent OnChange = {read=FOnChange, write=FOnChange};
	
__published:
	__property About = {default=0};
	__property TLMDClip* Clip = {read=FClip, write=SetClip};
};


class PASCALIMPLEMENTATION TLMDCustomImage : public Lmdgraphiccontrol::TLMDGraphicControl
{
	typedef Lmdgraphiccontrol::TLMDGraphicControl inherited;
	
private:
	TLMDOldBitmapStyle FStyle;
	Lmdtransparent::TLMDTransparent* FTransparent;
	Vcl::Graphics::TBitmap* FBackGround;
	bool FRestoreBack;
	void __fastcall SetStyle(TLMDOldBitmapStyle aValue);
	HIDESBASE void __fastcall SetTransparent(Lmdtransparent::TLMDTransparent* aValue);
	void __fastcall TransBlt(Vcl::Graphics::TBitmap* srcB, int x, int y, System::Uitypes::TColor TCol);
	bool __fastcall GetTransMode(void);
	MESSAGE void __fastcall CMClipChanged(Winapi::Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall WMPaint(Winapi::Messages::TWMPaint &Message);
	
protected:
	virtual void __fastcall GetControlChange(System::TObject* Sender);
	virtual void __fastcall GetTransparentChange(System::TObject* Sender);
	virtual void __fastcall Loaded(void);
	virtual void __fastcall PaintImage(Vcl::Graphics::TBitmap* aBitmap, const System::Types::TRect &aRect);
	__property bool RestoreBack = {read=FRestoreBack, write=FRestoreBack, nodefault};
	__property bool TransMode = {read=GetTransMode, nodefault};
	
public:
	__fastcall virtual TLMDCustomImage(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TLMDCustomImage(void);
	__property TLMDOldBitmapStyle Style = {read=FStyle, write=SetStyle, default=0};
	__property Lmdtransparent::TLMDTransparent* Transparent = {read=FTransparent, write=SetTransparent};
};


class PASCALIMPLEMENTATION TLMDAniImage : public TLMDCustomImage
{
	typedef TLMDCustomImage inherited;
	
private:
	System::Word FACounter;
	bool FADirection;
	bool FAPlaying;
	TLMDAniClip* FActualAniClip;
	TLMDAniClip* FAniClip;
	TLMDAnimation* FAnimation;
	System::Word FCell;
	TLMDAniPicClip* FControl;
	System::Word FCount;
	System::Word FEndPic;
	System::Byte FFlag;
	System::Word FFrame;
	bool FMakeVisible;
	System::Word FStartPic;
	Vcl::Extctrls::TTimer* FTimer;
	TLMDAnimationEvent FChangeCell;
	TLMDAnimationEvent FEndEvent;
	TLMDAnimationEvent FStartEvent;
	void __fastcall SetActiveClip(void);
	bool __fastcall SetActiveValues(System::Byte flag, const void *aValue);
	void __fastcall SetAniClip(TLMDAniClip* aValue);
	void __fastcall SetControl(TLMDAniPicClip* AControl);
	void __fastcall SetCell(System::Word aValue);
	void __fastcall SetFrame(System::Word aValue);
	void __fastcall SetFrameIndex(System::Word aValue);
	void __fastcall SetFrameName(System::UnicodeString aValue);
	void __fastcall SetValues(void);
	TLMDAniPicClip* __fastcall GetControl(void);
	System::Word __fastcall GetClips(void);
	TLMDAniFrame __fastcall GetFrame(System::Word index);
	TLMDAniFrame __fastcall GetFrameByIndex(System::Word indexnr);
	TLMDAniFrame __fastcall GetFrameByName(System::UnicodeString index);
	System::Word __fastcall GetFrames(void);
	System::Word __fastcall GetFrameIndex(void);
	System::UnicodeString __fastcall GetFrameName(void);
	TLMDFrameList* __fastcall GetList(void);
	Vcl::Graphics::TBitmap* __fastcall GetRealCell(System::Word aValue);
	void __fastcall GetTimer(System::TObject* Sender);
	void __fastcall Move(int aValue);
	HIDESBASE bool __fastcall HasControl(void);
	HIDESBASE MESSAGE void __fastcall WMPaint(Winapi::Messages::TWMPaint &Message);
	
protected:
	virtual void __fastcall GetChange(System::TObject* Sender);
	virtual void __fastcall GetControlChange(System::TObject* Sender);
	virtual bool __fastcall GetEmpty(void);
	DYNAMIC HPALETTE __fastcall GetPalette(void);
	virtual void __fastcall Loaded(void);
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation Operation);
	virtual void __fastcall Paint(void);
	
public:
	__fastcall virtual TLMDAniImage(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TLMDAniImage(void);
	void __fastcall Play(void);
	void __fastcall PlayFrameByName(System::UnicodeString aName, TLMDAnStyle aStyle);
	void __fastcall PlayFrameByIndex(System::Word aIndex, TLMDAnStyle aStyle);
	void __fastcall Stop(void);
	void __fastcall First(void);
	void __fastcall Last(void);
	void __fastcall Next(void);
	void __fastcall Prev(void);
	__property System::Word Clips = {read=GetClips, nodefault};
	__property bool Empty = {read=GetEmpty, nodefault};
	__property System::Word Count = {read=GetFrames, nodefault};
	__property TLMDAniFrame Frame[System::Word index] = {read=GetFrame};
	__property TLMDAniFrame FrameByIndex[System::Word Indexnr] = {read=GetFrameByIndex};
	__property TLMDAniFrame FrameByName[System::UnicodeString index] = {read=GetFrameByName};
	__property TLMDFrameList* List = {read=GetList};
	
__published:
	__property TLMDAniClip* AniClip = {read=FAniClip, write=SetAniClip};
	__property TLMDAniPicClip* AniControl = {read=GetControl, write=SetControl, stored=HasControl};
	__property TLMDAnimation* Animation = {read=FAnimation, write=FAnimation};
	__property System::Word Cell = {read=FCell, write=SetCell, default=0};
	__property System::Word FrameNr = {read=FFrame, write=SetFrame, default=0};
	__property System::Word FrameIndex = {read=GetFrameIndex, write=SetFrameIndex, stored=false, nodefault};
	__property System::UnicodeString FrameName = {read=GetFrameName, write=SetFrameName, stored=false};
	__property bool MakeVisible = {read=FMakeVisible, write=FMakeVisible, default=1};
	__property About = {default=0};
	__property Align = {default=0};
	__property Bevel;
	__property DragCursor = {default=-12};
	__property DragMode = {default=0};
	__property ParentShowHint = {default=1};
	__property PopupMenu;
	__property ShowHint;
	__property Style = {default=0};
	__property Transparent;
	__property Visible = {default=1};
	__property OnClick;
	__property OnDblClick;
	__property OnDragDrop;
	__property OnDragOver;
	__property OnEndDrag;
	__property OnMouseDown;
	__property OnMouseMove;
	__property OnMouseUp;
	__property OnStartDrag;
	__property TLMDAnimationEvent OnFrameStart = {read=FStartEvent, write=FStartEvent};
	__property TLMDAnimationEvent OnFrameEnd = {read=FEndEvent, write=FEndEvent};
	__property TLMDAnimationEvent OnChangeCell = {read=FChangeCell, write=FChangeCell};
};


class PASCALIMPLEMENTATION TLMDImage : public TLMDCustomImage
{
	typedef TLMDCustomImage inherited;
	
private:
	System::Word FCell;
	TLMDClip* FClip;
	TLMDClip* FActualClip;
	TLMDPicClip* FControl;
	void __fastcall SetActiveClip(void);
	void __fastcall SetCell(System::Word aValue);
	void __fastcall SetClip(TLMDClip* aValue);
	void __fastcall SetControl(TLMDPicClip* AControl);
	System::Word __fastcall GetClips(void);
	TLMDPicClip* __fastcall GetControl(void);
	
protected:
	virtual void __fastcall GetChange(System::TObject* Sender);
	virtual void __fastcall GetControlChange(System::TObject* Sender);
	virtual bool __fastcall GetEmpty(void);
	DYNAMIC HPALETTE __fastcall GetPalette(void);
	virtual void __fastcall Loaded(void);
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation Operation);
	virtual void __fastcall Paint(void);
	
public:
	__fastcall virtual TLMDImage(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TLMDImage(void);
	__property bool Empty = {read=GetEmpty, nodefault};
	__property System::Word Count = {read=GetClips, nodefault};
	
__published:
	__property About = {default=0};
	__property Align = {default=0};
	__property Bevel;
	__property System::Word Cell = {read=FCell, write=SetCell, default=0};
	__property TLMDClip* Clip = {read=FClip, write=SetClip};
	__property TLMDPicClip* ClipControl = {read=GetControl, write=SetControl};
	__property DragCursor = {default=-12};
	__property DragMode = {default=0};
	__property ParentShowHint = {default=1};
	__property PopupMenu;
	__property ShowHint;
	__property Style = {default=0};
	__property Transparent;
	__property Visible = {default=1};
	__property OnClick;
	__property OnDblClick;
	__property OnDragDrop;
	__property OnDragOver;
	__property OnEndDrag;
	__property OnMouseDown;
	__property OnMouseMove;
	__property OnMouseUp;
	__property OnStartDrag;
};


enum DECLSPEC_DENUM TMeterStyle : unsigned char { msBar, msSmallBar, msBitmap, msGradient, msOwnerDraw };

enum DECLSPEC_DENUM TMeterBitmapStyle : unsigned char { bmTile, bmStretch, bmTileInvert };

typedef void __fastcall (__closure *TOnDrawEvent)(System::TObject* Sender, Vcl::Graphics::TBitmap* aBitmap);

class PASCALIMPLEMENTATION TLMDBmpOptions : public Lmdobject::TLMDObject
{
	typedef Lmdobject::TLMDObject inherited;
	
private:
	Vcl::Graphics::TBitmap* FBitmap;
	TMeterBitmapStyle FBitmapStyle;
	void __fastcall SetBitmap(Vcl::Graphics::TBitmap* aValue);
	void __fastcall SetBitmapStyle(TMeterBitmapStyle aValue);
	
public:
	__fastcall virtual TLMDBmpOptions(System::Classes::TPersistent* Owner);
	__fastcall virtual ~TLMDBmpOptions(void);
	
__published:
	__property Vcl::Graphics::TBitmap* Bitmap = {read=FBitmap, write=SetBitmap};
	__property TMeterBitmapStyle BitmapStyle = {read=FBitmapStyle, write=SetBitmapStyle, default=1};
};


class PASCALIMPLEMENTATION TLMDMeter : public Lmdbasemeter::TLMDBaseMeter
{
	typedef Lmdbasemeter::TLMDBaseMeter inherited;
	
private:
	Vcl::Graphics::TBrush* FBarOptions;
	TLMDBmpOptions* FBmpOptions;
	Lmdgradient::TLMDGradient* FGradientOptions;
	Lmdsmallbar::TLMDSmallBar* FSmBarOptions;
	TMeterStyle FStyle;
	TOnDrawEvent FOnDrawEvent;
	void __fastcall SetBarOptions(Vcl::Graphics::TBrush* aValue);
	void __fastcall SetBmpOptions(TLMDBmpOptions* aValue);
	void __fastcall SetGradient(Lmdgradient::TLMDGradient* aValue);
	void __fastcall SetMeterstyle(TMeterStyle aValue);
	void __fastcall SetSmBarOptions(Lmdsmallbar::TLMDSmallBar* aValue);
	
protected:
	virtual bool __fastcall CorrectBounds(void);
	virtual void __fastcall DrawBar(Vcl::Graphics::TCanvas* aCanvas, const System::Types::TRect &dest, const System::Types::TRect &notDest, const System::Types::TRect &aRect);
	DYNAMIC HPALETTE __fastcall GetPalette(void);
	
public:
	__fastcall virtual TLMDMeter(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TLMDMeter(void);
	
__published:
	__property About = {default=0};
	__property Align = {default=0};
	__property Alignment = {default=2};
	__property Bevel;
	__property Color = {default=-16777211};
	__property Caption = {default=0};
	__property Direction = {default=0};
	__property DragCursor = {default=-12};
	__property DragMode = {default=0};
	__property Enabled = {default=1};
	__property Font;
	__property MaxValue = {default=100};
	__property MinValue = {default=0};
	__property Vcl::Graphics::TBrush* OptionsBar = {read=FBarOptions, write=SetBarOptions};
	__property TLMDBmpOptions* OptionsBmp = {read=FBmpOptions, write=SetBmpOptions};
	__property Lmdgradient::TLMDGradient* OptionsGradient = {read=FGradientOptions, write=SetGradient};
	__property Lmdsmallbar::TLMDSmallBar* OptionsSmallBar = {read=FSmBarOptions, write=SetSmBarOptions};
	__property OptionsText = {default=0};
	__property ParentColor = {default=1};
	__property ParentFont = {default=1};
	__property ParentShowHint = {default=1};
	__property PopupMenu;
	__property PercentValue = {default=0};
	__property ShowHint;
	__property TMeterStyle StyleMeter = {read=FStyle, write=SetMeterstyle, default=1};
	__property UserValue = {default=0};
	__property UseFontColor = {default=0};
	__property Visible = {default=1};
	__property TOnDrawEvent OnDraw = {read=FOnDrawEvent, write=FOnDrawEvent};
	__property OnClick;
	__property OnDblClick;
	__property OnDragDrop;
	__property OnDragOver;
	__property OnEndDrag;
	__property OnMouseDown;
	__property OnMouseMove;
	__property OnMouseUp;
	__property OnStartDrag;
};


class PASCALIMPLEMENTATION TLMDPanel : public Lmdcustompanelfill::TLMDCustomPanelFill
{
	typedef Lmdcustompanelfill::TLMDCustomPanelFill inherited;
	
private:
	TLMDBackmode FBackMode;
	Vcl::Graphics::TBitmap* FBitmap;
	Lmdgradient::TLMDGradient* FGradient;
	void __fastcall SetBackMode(TLMDBackmode aValue);
	void __fastcall SetBitmap(Vcl::Graphics::TBitmap* aValue);
	void __fastcall SetGradient(Lmdgradient::TLMDGradient* aValue);
	HIDESBASE MESSAGE void __fastcall WMEraseBkgnd(Winapi::Messages::TWMEraseBkgnd &Message);
	
protected:
	virtual void __fastcall GetChange(System::TObject* Sender);
	DYNAMIC HPALETTE __fastcall GetPalette(void);
	virtual void __fastcall Paint(void);
	
public:
	__fastcall virtual TLMDPanel(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TLMDPanel(void);
	
__published:
	__property About = {default=0};
	__property Align = {default=0};
	__property Alignment = {default=4};
	__property TLMDBackmode Background = {read=FBackMode, write=SetBackMode, default=0};
	__property Bevel;
	__property Vcl::Graphics::TBitmap* Bitmap = {read=FBitmap, write=SetBitmap};
	__property Caption = {default=0};
	__property Color = {default=-16777201};
	__property Ctl3D;
	__property DragCursor = {default=-12};
	__property DragMode = {default=0};
	__property Enabled = {default=1};
	__property Font;
	__property FontFX;
	__property Lmdgradient::TLMDGradient* Gradient = {read=FGradient, write=SetGradient};
	__property Locked = {default=0};
	__property ParentColor = {default=0};
	__property ParentCtl3D = {default=1};
	__property ParentFont = {default=1};
	__property ParentShowHint = {default=1};
	__property PopupMenu;
	__property ShowHint;
	__property TabOrder = {default=-1};
	__property TabStop = {default=0};
	__property Visible = {default=1};
	__property OnClick;
	__property OnDblClick;
	__property OnDragDrop;
	__property OnDragOver;
	__property OnEndDrag;
	__property OnEnter;
	__property OnExit;
	__property OnMouseDown;
	__property OnMouseMove;
	__property OnMouseUp;
	__property OnResize;
	__property OnStartDrag;
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDPanel(HWND ParentWindow) : Lmdcustompanelfill::TLMDCustomPanelFill(ParentWindow) { }
	
};


class PASCALIMPLEMENTATION TLMDTile : public Lmdgraphiccontrol::TLMDGraphicControl
{
	typedef Lmdgraphiccontrol::TLMDGraphicControl inherited;
	
private:
	Vcl::Graphics::TBitmap* FBitmap;
	Lmdgradient::TLMDGradient* FGradient;
	TLMDBackmode FTileMode;
	void __fastcall SetBitmap(Vcl::Graphics::TBitmap* aValue);
	void __fastcall SetGradient(Lmdgradient::TLMDGradient* aValue);
	void __fastcall SetTileMode(TLMDBackmode aValue);
	
protected:
	virtual void __fastcall Paint(void);
	virtual void __fastcall GetChange(System::TObject* Sender);
	virtual bool __fastcall GetEmpty(void);
	DYNAMIC HPALETTE __fastcall GetPalette(void);
	
public:
	__fastcall virtual TLMDTile(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TLMDTile(void);
	
__published:
	__property About = {default=0};
	__property Align = {default=0};
	__property Vcl::Graphics::TBitmap* Bitmap = {read=FBitmap, write=SetBitmap};
	__property Bevel;
	__property DragCursor = {default=-12};
	__property DragMode = {default=0};
	__property Lmdgradient::TLMDGradient* Gradient = {read=FGradient, write=SetGradient};
	__property ParentShowHint = {default=1};
	__property PopupMenu;
	__property ShowHint;
	__property TLMDBackmode TileMode = {read=FTileMode, write=SetTileMode, default=0};
	__property Visible = {default=1};
	__property OnClick;
	__property OnDblClick;
	__property OnDragDrop;
	__property OnDragOver;
	__property OnEndDrag;
	__property OnMouseDown;
	__property OnMouseMove;
	__property OnMouseUp;
	__property OnStartDrag;
};


//-- var, const, procedure ---------------------------------------------------
static const System::Word CM_ClipChanged = System::Word(0xb063);
static const System::Word IDS_NOANICLIP = System::Word(0x40a5);
static const System::Word IDS_NOTMATCH = System::Word(0x40a8);
static const System::Word IDS_BMPWIDTH = System::Word(0x40ac);
static const System::Word IDS_BMPHEIGHT = System::Word(0x40ad);
static const System::Word IDS_CLIPEMPTY = System::Word(0x40a9);
static const System::Word IDS_INVALIDVALUE = System::Word(0x40aa);
static const System::Word IDS_INVALIDRECT = System::Word(0x40ab);
extern DELPHI_PACKAGE System::SmallString<5> PCLSignature;
extern DELPHI_PACKAGE System::Word ALLPIC;
extern DELPHI_PACKAGE System::SmallString<3> ALLPICS;
extern DELPHI_PACKAGE System::SmallString<5> PCPSignature;
extern DELPHI_PACKAGE void __fastcall TransparentBlt(Vcl::Graphics::TCanvas* aCanvas, int x, int y, Vcl::Graphics::TBitmap* bSrc, int cx, int cy, int cw, int ch, System::Uitypes::TColor transColor);
}	/* namespace Lmdobj */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDOBJ)
using namespace Lmdobj;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdobjHPP
