// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'FMXTee.Animate.pas' rev: 34.00 (Android)

#ifndef Fmxtee_AnimateHPP
#define Fmxtee_AnimateHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.Types.hpp>
#include <System.UITypes.hpp>
#include <System.Generics.Collections.hpp>
#include <FMX.Types.hpp>
#include <FMX.Forms.hpp>
#include <System.Variants.hpp>
#include <System.Classes.hpp>
#include <System.SysUtils.hpp>
#include <System.TypInfo.hpp>
#include <FMXTee.Procs.hpp>
#include <FMXTee.Canvas.hpp>
#include <System.Generics.Defaults.hpp>

//-- user supplied -----------------------------------------------------------

namespace Fmxtee
{
namespace Animate
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TTeeAnimation;
class DELPHICLASS TAnimations;
struct TTeeAnimateEvents;
class DELPHICLASS TCustomTeePanelLink;
struct TAnimateEditorOptions;
class DELPHICLASS TTimerThread;
struct TTimerEvent;
class DELPHICLASS TMultiTimer;
class DELPHICLASS TTeeAnimate;
class DELPHICLASS TPropertyAnimation;
class DELPHICLASS TPropertyLink;
class DELPHICLASS TRangePropertyAnimation;
class DELPHICLASS TAnimationCurve;
class DELPHICLASS TNumberAnimation;
class DELPHICLASS TColorsAnimation;
class DELPHICLASS TToggleAnimation;
class DELPHICLASS TSinusAnimation;
class DELPHICLASS TPlaySoundAnimation;
//-- type declarations -------------------------------------------------------
typedef void __fastcall (__closure *TAnimationEndEvent)(TTeeAnimation* Sender, bool &FreeAnimation);

enum DECLSPEC_DENUM TAnimationState : unsigned char { asStopped, asPlaying, asPaused };

enum DECLSPEC_DENUM TAnimationTiming : unsigned char { atLinear, atSine, atSquare, atExp, atCubic, atBack, atBounce, atElastic };

enum DECLSPEC_DENUM TAnimationTimingStyle : unsigned char { atIn, atOut, atInOut };

typedef void __fastcall (__closure *TAnimationFrameEvent)(TTeeAnimation* Sender, const float Fraction);

_DECLARE_METACLASS(System::TMetaClass, TTeeAnimationClass);

#pragma pack(push,4)
class PASCALIMPLEMENTATION TTeeAnimation : public System::Classes::TComponent
{
	typedef System::Classes::TComponent inherited;
	
private:
	int FDuration;
	bool FEnabled;
	bool FInverted;
	bool FLoop;
	TTeeAnimation* FParent;
	int FStart;
	System::TObject* FTagObject;
	System::UnicodeString FTitle;
	TAnimationTiming FTiming;
	TAnimationTimingStyle FTimingStyle;
	bool FTwoWay;
	System::Classes::TNotifyEvent FOnBegin;
	TAnimationEndEvent FOnEnd;
	TAnimationFrameEvent FOnFrame;
	System::Classes::TNotifyEvent FOnStop;
	void __fastcall DoNextFrame(const float Fraction);
	TTeeAnimate* __fastcall GetAnimate();
	int __fastcall GetStartFrame();
	void __fastcall ReadStartFrame(System::Classes::TReader* Reader);
	void __fastcall SetStartFrame(int Value);
	
protected:
	TTeeAnimate* IAnimate;
	unsigned ICurrentTime;
	TAnimationState IPlaying;
	System::UnicodeString IParentSource;
	bool IDontFree;
	DYNAMIC void __fastcall Added(TTeeAnimation* const AAnimation);
	DYNAMIC void __fastcall ChildDurationChanged(TTeeAnimation* const Child);
	virtual void __fastcall DefineProperties(System::Classes::TFiler* Filer);
	int __fastcall DurationFrames();
	DYNAMIC bool __fastcall IsFolder();
	DYNAMIC bool __fastcall IsSequence();
	DYNAMIC bool __fastcall IsValidChild(const TTeeAnimationClass AClass);
	DYNAMIC void __fastcall NewNode();
	virtual void __fastcall NextFrame(const float Fraction);
	DYNAMIC System::Classes::TPersistent* __fastcall GetOwner();
	virtual void __fastcall ReadState(System::Classes::TReader* Reader);
	DYNAMIC void __fastcall Removed(TTeeAnimation* const AAnimation);
	virtual void __fastcall SetAnimate(TTeeAnimate* const Value);
	virtual void __fastcall SetDuration(const int Value);
	virtual void __fastcall SetParent(TTeeAnimation* const Value);
	virtual bool __fastcall EndAnimation();
	virtual void __fastcall FixupReferences(const System::UnicodeString AParentSource);
	DYNAMIC void __fastcall SetParentComponent(System::Classes::TComponent* AParent);
	
public:
	__fastcall virtual TTeeAnimation(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TTeeAnimation();
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	__classmethod virtual System::UnicodeString __fastcall Description();
	DYNAMIC System::UnicodeString __fastcall EditorClass();
	DYNAMIC System::UnicodeString __fastcall EditorName();
	DYNAMIC System::Classes::TComponent* __fastcall GetParentComponent();
	DYNAMIC bool __fastcall HasParent();
	int __fastcall Index();
	DYNAMIC bool __fastcall IsEnabled();
	__classmethod virtual bool __fastcall IsValidOwner(System::TObject* const AObject);
	__classmethod virtual bool __fastcall IsValidSource(System::TObject* const ASource, bool IsObject);
	__property TTeeAnimate* Animate = {read=GetAnimate, write=SetAnimate};
	virtual void __fastcall Continue();
	int __fastcall EndFrame();
	int __fastcall EndTime();
	virtual void __fastcall Pause();
	virtual void __fastcall Play()/* overload */;
	DYNAMIC void __fastcall Preview();
	virtual void __fastcall Stop();
	virtual void __fastcall StoreValue();
	float __fastcall TimingFunction(const float Fraction);
	__property TAnimationState Playing = {read=IPlaying, nodefault};
	__property int StartFrame = {read=GetStartFrame, write=SetStartFrame, nodefault};
	__property System::TObject* TagObject = {read=FTagObject, write=FTagObject};
	
__published:
	__property int Duration = {read=FDuration, write=SetDuration, default=1000};
	__property bool Enabled = {read=FEnabled, write=FEnabled, default=1};
	__property bool Inverted = {read=FInverted, write=FInverted, default=0};
	__property bool Loop = {read=FLoop, write=FLoop, default=0};
	__property TTeeAnimation* Parent = {read=FParent, write=SetParent};
	__property int StartTime = {read=FStart, write=FStart, default=0};
	__property TAnimationTiming Timing = {read=FTiming, write=FTiming, default=0};
	__property TAnimationTimingStyle TimingStyle = {read=FTimingStyle, write=FTimingStyle, default=0};
	__property System::UnicodeString Title = {read=FTitle, write=FTitle};
	__property bool TwoWay = {read=FTwoWay, write=FTwoWay, default=0};
	__property System::Classes::TNotifyEvent OnBegin = {read=FOnBegin, write=FOnBegin};
	__property TAnimationEndEvent OnEnd = {read=FOnEnd, write=FOnEnd};
	__property TAnimationFrameEvent OnFrame = {read=FOnFrame, write=FOnFrame};
	__property System::Classes::TNotifyEvent OnStop = {read=FOnStop, write=FOnStop};
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TAnimations : public System::Generics::Collections::TObjectList__1<TTeeAnimation*>
{
	typedef System::Generics::Collections::TObjectList__1<TTeeAnimation*> inherited;
	
public:
	TTeeAnimation* operator[](int Index) { return this->Animation[Index]; }
	
private:
	TTeeAnimation* __fastcall Get(int Index);
	void __fastcall Put(int Index, TTeeAnimation* const Value);
	
protected:
	System::Classes::TComponent* IAnimate;
	
public:
	__fastcall virtual ~TAnimations();
	void __fastcall Assign(TAnimations* const Value);
	HIDESBASE void __fastcall Add(TTeeAnimation* const Animation);
	HIDESBASE void __fastcall Clear();
	void __fastcall FreeAll();
	__property System::Classes::TComponent* Animate = {read=IAnimate, write=IAnimate};
	__property TTeeAnimation* Animation[int Index] = {read=Get, write=Put/*, default*/};
public:
	/* {System_Generics_Collections}TObjectList<FMXTee_Animate_TTeeAnimation>.Create */ inline __fastcall TAnimations()/* overload */ : System::Generics::Collections::TObjectList__1<TTeeAnimation*>() { }
	/* {System_Generics_Collections}TObjectList<FMXTee_Animate_TTeeAnimation>.Create */ inline __fastcall TAnimations(bool AOwnsObjects)/* overload */ : System::Generics::Collections::TObjectList__1<TTeeAnimation*>(AOwnsObjects) { }
	/* {System_Generics_Collections}TObjectList<FMXTee_Animate_TTeeAnimation>.Create */ inline __fastcall TAnimations(const System::DelphiInterface<System::Generics::Defaults::IComparer__1<TTeeAnimation*> > AComparer, bool AOwnsObjects)/* overload */ : System::Generics::Collections::TObjectList__1<TTeeAnimation*>(AComparer, AOwnsObjects) { }
	/* {System_Generics_Collections}TObjectList<FMXTee_Animate_TTeeAnimation>.Create */ inline __fastcall TAnimations(System::Generics::Collections::TEnumerable__1<TTeeAnimation*>* const Collection, bool AOwnsObjects)/* overload */ : System::Generics::Collections::TObjectList__1<TTeeAnimation*>(Collection, AOwnsObjects) { }
	
public:
	/* {System_Generics_Collections}TList<FMXTee_Animate_TTeeAnimation>.Create */ inline __fastcall TAnimations(const System::DelphiInterface<System::Generics::Defaults::IComparer__1<TTeeAnimation*> > AComparer)/* overload */ : System::Generics::Collections::TObjectList__1<TTeeAnimation*>(AComparer) { }
	/* {System_Generics_Collections}TList<FMXTee_Animate_TTeeAnimation>.Create */ inline __fastcall TAnimations(System::Generics::Collections::TEnumerable__1<TTeeAnimation*>* const Collection)/* overload */ : System::Generics::Collections::TObjectList__1<TTeeAnimation*>(Collection) { }
	
};

#pragma pack(pop)

#pragma pack(push,1)
struct DECLSPEC_DRECORD TTeeAnimateEvents
{
public:
	System::Classes::TNotifyEvent Clear;
	System::Classes::TNotifyEvent Continue;
	System::Classes::TNotifyEvent Frame;
	System::Classes::TNotifyEvent Stop;
	System::Classes::TNotifyEvent Pause;
	System::Classes::TNotifyEvent Play;
	System::Classes::TNotifyEvent DeletedShapes;
};
#pragma pack(pop)


#pragma pack(push,4)
class PASCALIMPLEMENTATION TCustomTeePanelLink : public System::Classes::TComponent
{
	typedef System::Classes::TComponent inherited;
	
private:
	Fmxtee::Procs::TCustomTeePanel* FPanel;
	void __fastcall SetPanel(Fmxtee::Procs::TCustomTeePanel* const Value);
	
protected:
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation Operation);
	
public:
	__property Fmxtee::Procs::TCustomTeePanel* Panel = {read=FPanel, write=SetPanel};
public:
	/* TComponent.Create */ inline __fastcall virtual TCustomTeePanelLink(System::Classes::TComponent* AOwner) : System::Classes::TComponent(AOwner) { }
	/* TComponent.Destroy */ inline __fastcall virtual ~TCustomTeePanelLink() { }
	
};

#pragma pack(pop)

struct DECLSPEC_DRECORD TAnimateEditorOptions
{
public:
	int HorizScale;
	int VertScale;
	System::Types::TPointF Size;
	int NodeListX;
};


#pragma pack(push,4)
class PASCALIMPLEMENTATION TTimerThread : public System::Classes::TThread
{
	typedef System::Classes::TThread inherited;
	
private:
	System::Classes::TNotifyEvent FTimerProc;
	bool DoSynchronize;
	void __fastcall Timer();
	
public:
	__fastcall TTimerThread(const System::Classes::TNotifyEvent AProc);
	virtual void __fastcall Execute();
public:
	/* TThread.Destroy */ inline __fastcall virtual ~TTimerThread() { }
	
};

#pragma pack(pop)

#pragma pack(push,1)
struct DECLSPEC_DRECORD TTimerEvent
{
public:
	System::TMethod FMethod;
	System::TMethod FEnabled;
	bool FIsEnabled;
	bool FRepeat;
	System::Variant FData;
	__int64 FOldTick;
	unsigned FInterval;
	System::TObject* FSource;
};
#pragma pack(pop)


typedef TTimerEvent *PTimerEvent;

typedef bool __fastcall (__closure *TTimerEnabled)(const TTimerEvent &Sender);

#pragma pack(push,4)
class PASCALIMPLEMENTATION TMultiTimer : public System::TObject
{
	typedef System::TObject inherited;
	
	
private:
	bool IAnyNil;
	TTimerThread* IThreadTimer;
	_TMultiTimer__1 IList;
	void __fastcall CreateTimer();
	void __fastcall Delete(int Index);
	
protected:
	void __fastcall OnTimer(System::TObject* Sender);
	
public:
	__fastcall virtual ~TMultiTimer();
	void __fastcall AddEvent(System::Classes::TNotifyEvent AEvent, TTimerEnabled AEnabled = 0x0, const unsigned Interval = (unsigned)(0x3e8), bool DoRepeat = true, System::TObject* Source = (System::TObject*)(0x0), const System::UnicodeString Data = System::UnicodeString());
	void __fastcall ChangeInterval(System::Classes::TNotifyEvent AEvent, unsigned AInterval);
	void __fastcall EnableEvent(System::Classes::TNotifyEvent AEvent, bool AEnable);
	int __fastcall IndexOfEvent(System::Classes::TNotifyEvent AEvent);
	void __fastcall RemoveEvent(System::Classes::TNotifyEvent AEvent);
	void __fastcall TryToEnable();
public:
	/* TObject.Create */ inline __fastcall TMultiTimer() : System::TObject() { }
	
};

#pragma pack(pop)

class PASCALIMPLEMENTATION TTeeAnimate : public TCustomTeePanelLink
{
	typedef TCustomTeePanelLink inherited;
	
public:
	TTeeAnimation* operator[](int Index) { return this->Animation[Index]; }
	
private:
	TAnimations* FAnimations;
	bool FLoop;
	int FSpeed;
	double FSpeedFactor;
	TAnimationState FState;
	System::Classes::TNotifyEvent FOnClear;
	System::Classes::TNotifyEvent FOnContinue;
	System::Classes::TNotifyEvent FOnDeleted;
	System::Classes::TNotifyEvent FOnFrame;
	System::Classes::TNotifyEvent FOnPause;
	System::Classes::TNotifyEvent FOnPlay;
	System::Classes::TNotifyEvent FOnStop;
	void __fastcall CallOnPlay();
	void __fastcall CallOnStop();
	TTeeAnimation* __fastcall Get(int Index);
	int __fastcall GetEndFrame();
	int __fastcall GetEndTime();
	void __fastcall InternalStop();
	bool __fastcall IsSpeedFactorStored();
	void __fastcall Put(int Index, TTeeAnimation* const Value);
	void __fastcall SetLoop(const bool Value);
	void __fastcall SetSpeed(const int Value);
	void __fastcall OnTimer(System::TObject* Sender);
	
protected:
	System::Classes::TNotifyEvent IOnPlay;
	System::Classes::TNotifyEvent IOnStop;
	System::Classes::TNotifyEvent FOnDestroy;
	TAnimateEditorOptions IEditor;
	bool PlayByFrames;
	DYNAMIC void __fastcall GetChildren(System::Classes::TGetChildProc Proc, System::Classes::TComponent* Root);
	DYNAMIC System::Classes::TComponent* __fastcall GetChildOwner();
	__classmethod TMultiTimer* __fastcall GlobalTimer();
	void __fastcall RestoreEvents(const TTeeAnimateEvents &AnimateEvents);
	void __fastcall SaveEvents(TTeeAnimateEvents &AnimateEvents);
	
public:
	int CurrentFrame;
	unsigned StartTime;
	bool FreeOnStop;
	__fastcall virtual TTeeAnimate(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TTeeAnimate();
	void __fastcall Continue();
	float __fastcall MillisecondsPerFrame();
	void __fastcall NextFrame();
	void __fastcall Pause();
	bool __fastcall Paused();
	void __fastcall Play(bool Wait = false, bool SynchronizeMain = true);
	bool __fastcall Playing();
	void __fastcall Stop();
	__property TTeeAnimation* Animation[int Index] = {read=Get, write=Put/*, default*/};
	__property int EndFrame = {read=GetEndFrame, nodefault};
	__property int EndTime = {read=GetEndTime, nodefault};
	__property System::Classes::TNotifyEvent OnDeleteShapes = {read=FOnDeleted, write=FOnDeleted};
	
__published:
	__property TAnimations* Animations = {read=FAnimations};
	__property bool Loop = {read=FLoop, write=SetLoop, default=0};
	__property int Speed = {read=FSpeed, write=SetSpeed, default=60};
	__property double SpeedFactor = {read=FSpeedFactor, write=FSpeedFactor, stored=IsSpeedFactorStored};
	__property TAnimationState State = {read=FState, nodefault};
	__property System::Classes::TNotifyEvent OnClear = {read=FOnClear, write=FOnClear};
	__property System::Classes::TNotifyEvent OnContinue = {read=FOnContinue, write=FOnContinue};
	__property System::Classes::TNotifyEvent OnFrame = {read=FOnFrame, write=FOnFrame};
	__property System::Classes::TNotifyEvent OnPause = {read=FOnPause, write=FOnPause};
	__property System::Classes::TNotifyEvent OnPlay = {read=FOnPlay, write=FOnPlay};
	__property System::Classes::TNotifyEvent OnStop = {read=FOnStop, write=FOnStop};
};


#pragma pack(push,4)
class PASCALIMPLEMENTATION TPropertyAnimation : public TTeeAnimation
{
	typedef TTeeAnimation inherited;
	
private:
	void __fastcall ReadSpecial(System::Classes::TReader* Reader);
	void __fastcall SetInst(System::TObject* const Value);
	void __fastcall WriteSpecial(System::Classes::TWriter* Writer);
	
protected:
	System::TObject* FInst;
	System::UnicodeString FProp;
	System::Classes::TNotifyEvent FOnChange;
	System::TObject* IRealInstance;
	System::UnicodeString IRealProperty;
	int IsSpecial;
	virtual void __fastcall DefineProperties(System::Classes::TFiler* Filer);
	virtual void __fastcall FindRealNames();
	virtual void __fastcall FixupReferences(const System::UnicodeString AParentSource);
	bool __fastcall HasProperty();
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation Operation);
	void __fastcall SetProp(const System::UnicodeString Value);
	
public:
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	DYNAMIC System::UnicodeString __fastcall EditorClass();
	DYNAMIC System::UnicodeString __fastcall EditorName();
	__classmethod System::Typinfo::PPropInfo __fastcall Fixup(System::TObject* &AInstance, System::UnicodeString &AName);
	DYNAMIC bool __fastcall IsEnabled();
	__property System::UnicodeString PropertyName = {read=FProp, write=SetProp};
	__property System::Classes::TNotifyEvent OnChange = {read=FOnChange, write=FOnChange};
	
__published:
	__property System::TObject* Instance = {read=FInst, write=SetInst};
public:
	/* TTeeAnimation.Create */ inline __fastcall virtual TPropertyAnimation(System::Classes::TComponent* AOwner) : TTeeAnimation(AOwner) { }
	/* TTeeAnimation.Destroy */ inline __fastcall virtual ~TPropertyAnimation() { }
	
};

#pragma pack(pop)

typedef System::Variant __fastcall (__closure *TGetPropertyValueProc)(System::TObject* AInstance, const System::UnicodeString AProperty);

#pragma pack(push,4)
class PASCALIMPLEMENTATION TPropertyLink : public System::Classes::TPersistent
{
	typedef System::Classes::TPersistent inherited;
	
private:
	System::TObject* FInst;
	System::UnicodeString FProp;
	System::Classes::TComponent* IOwner;
	System::TObject* IRealInstance;
	System::UnicodeString IRealProperty;
	DYNAMIC void __fastcall FindRealNames();
	void __fastcall SetInst(System::TObject* const Value);
	void __fastcall SetProp(const System::UnicodeString Value);
	
public:
	__fastcall TPropertyLink(System::Classes::TComponent* AOwner);
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	void __fastcall CheckInstancePrefix(const System::UnicodeString APrefix, System::TObject* const AInstance);
	System::Typinfo::PPropInfo __fastcall PropertyInfo();
	System::Variant __fastcall PropertyValue(TGetPropertyValueProc AProc = 0x0)/* overload */;
	System::Variant __fastcall PropertyValue(const System::UnicodeString APropName)/* overload */;
	
__published:
	__property System::TObject* Instance = {read=FInst, write=SetInst};
	__property System::UnicodeString PropertyName = {read=FProp, write=SetProp};
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TPropertyLink() { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TRangePropertyAnimation : public TPropertyAnimation
{
	typedef TPropertyAnimation inherited;
	
private:
	bool FKeepEnd;
	bool FUseEnd;
	bool FUseStart;
	
public:
	__fastcall virtual TRangePropertyAnimation(System::Classes::TComponent* AOwner);
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	
__published:
	__property bool KeepEndValue = {read=FKeepEnd, write=FKeepEnd, default=0};
	__property bool UseEndValue = {read=FUseEnd, write=FUseEnd, default=1};
	__property bool UseStartValue = {read=FUseStart, write=FUseStart, default=1};
public:
	/* TTeeAnimation.Destroy */ inline __fastcall virtual ~TRangePropertyAnimation() { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TAnimationCurve : public System::Classes::TPersistent
{
	typedef System::Classes::TPersistent inherited;
	
private:
	bool FInverted;
	Fmxtee::Canvas::TDoubleArray ICurve;
	void __fastcall ReadCurve(System::Classes::TStream* Stream);
	void __fastcall WriteCurve(System::Classes::TStream* Stream);
	
protected:
	virtual void __fastcall DefineProperties(System::Classes::TFiler* Filer);
	
public:
	Fmxtee::Canvas::TDoubleArray X;
	Fmxtee::Canvas::TDoubleArray Y;
	__fastcall virtual ~TAnimationCurve();
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	void __fastcall Calculate(int Duration);
	void __fastcall Reset();
	
__published:
	__property bool Inverted = {read=FInverted, write=FInverted, default=0};
public:
	/* TObject.Create */ inline __fastcall TAnimationCurve() : System::Classes::TPersistent() { }
	
};

#pragma pack(pop)

typedef void __fastcall (__closure *TAnimationSetValue)(TTeeAnimation* Sender, const double Value);

class PASCALIMPLEMENTATION TNumberAnimation : public TRangePropertyAnimation
{
	typedef TRangePropertyAnimation inherited;
	
private:
	TAnimationCurve* FCurve;
	TPropertyLink* FEndLink;
	double FEndValue;
	bool FInitStart;
	TAnimationSetValue FOnSetValue;
	TPropertyLink* FStartLink;
	double FStartValue;
	double FValue;
	double OldValue;
	TAnimationCurve* __fastcall GetCurve();
	TPropertyLink* __fastcall GetEndLink();
	double __fastcall GetEndValue();
	TPropertyLink* __fastcall GetStartLink();
	double __fastcall GetStartValue();
	bool __fastcall HasCurve();
	void __fastcall SetCurve(TAnimationCurve* const Value);
	void __fastcall SetEndLink(TPropertyLink* const Value);
	void __fastcall SetStartLink(TPropertyLink* const Value);
	
protected:
	virtual double __fastcall GetValue();
	DYNAMIC void __fastcall NewNode();
	virtual void __fastcall NextFrame(const float Fraction);
	virtual void __fastcall SetDuration(const int Value);
	virtual void __fastcall SetValue(const double AValue);
	
public:
	__fastcall virtual ~TNumberAnimation();
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	float __fastcall CurveFrameValue(int Frame);
	virtual bool __fastcall EndAnimation();
	bool __fastcall HasLink(TPropertyLink* const ALink);
	DYNAMIC bool __fastcall IsEnabled();
	virtual void __fastcall Play()/* overload */;
	virtual void __fastcall StoreValue();
	__property double Value = {read=GetValue, write=SetValue};
	
__published:
	__property TAnimationCurve* Curve = {read=GetCurve, write=SetCurve, stored=HasCurve};
	__property TPropertyLink* EndLink = {read=GetEndLink, write=SetEndLink};
	__property double EndValue = {read=GetEndValue, write=FEndValue};
	__property bool InitStart = {read=FInitStart, write=FInitStart, default=0};
	__property PropertyName = {default=0};
	__property TPropertyLink* StartLink = {read=GetStartLink, write=SetStartLink};
	__property double StartValue = {read=GetStartValue, write=FStartValue};
	__property TAnimationSetValue OnSetValue = {read=FOnSetValue, write=FOnSetValue};
public:
	/* TRangePropertyAnimation.Create */ inline __fastcall virtual TNumberAnimation(System::Classes::TComponent* AOwner) : TRangePropertyAnimation(AOwner) { }
	
};


enum DECLSPEC_DENUM TColorMethod : unsigned char { cmRGB, cmHLS };

class PASCALIMPLEMENTATION TColorsAnimation : public TNumberAnimation
{
	typedef TNumberAnimation inherited;
	
private:
	TColorMethod FMethod;
	System::Uitypes::TAlphaColor __fastcall GetEnd();
	System::Uitypes::TAlphaColor __fastcall GetStart();
	void __fastcall SetEnd(const System::Uitypes::TAlphaColor Value);
	void __fastcall SetStart(const System::Uitypes::TAlphaColor Value);
	
protected:
	virtual void __fastcall NextFrame(const float Fraction);
	
public:
	__property System::Uitypes::TAlphaColor EndColor = {read=GetEnd, write=SetEnd, nodefault};
	__property System::Uitypes::TAlphaColor StartColor = {read=GetStart, write=SetStart, nodefault};
	
__published:
	__property TColorMethod Method = {read=FMethod, write=FMethod, default=0};
	__property PropertyName = {default=0};
public:
	/* TNumberAnimation.Destroy */ inline __fastcall virtual ~TColorsAnimation() { }
	
public:
	/* TRangePropertyAnimation.Create */ inline __fastcall virtual TColorsAnimation(System::Classes::TComponent* AOwner) : TNumberAnimation(AOwner) { }
	
};


#pragma pack(push,4)
class PASCALIMPLEMENTATION TToggleAnimation : public TPropertyAnimation
{
	typedef TPropertyAnimation inherited;
	
private:
	int FEvery;
	bool __fastcall GetValue();
	void __fastcall SetValue(const bool Value);
	
protected:
	virtual void __fastcall NextFrame(const float Fraction);
	
public:
	__fastcall virtual TToggleAnimation(System::Classes::TComponent* AOwner);
	__property bool Value = {read=GetValue, write=SetValue, nodefault};
	
__published:
	__property int Every = {read=FEvery, write=FEvery, default=5};
	__property PropertyName = {default=0};
public:
	/* TTeeAnimation.Destroy */ inline __fastcall virtual ~TToggleAnimation() { }
	
};

#pragma pack(pop)

class PASCALIMPLEMENTATION TSinusAnimation : public TNumberAnimation
{
	typedef TNumberAnimation inherited;
	
protected:
	virtual void __fastcall NextFrame(const float Fraction);
public:
	/* TNumberAnimation.Destroy */ inline __fastcall virtual ~TSinusAnimation() { }
	
public:
	/* TRangePropertyAnimation.Create */ inline __fastcall virtual TSinusAnimation(System::Classes::TComponent* AOwner) : TNumberAnimation(AOwner) { }
	
};


#pragma pack(push,4)
class PASCALIMPLEMENTATION TPlaySoundAnimation : public TTeeAnimation
{
	typedef TTeeAnimation inherited;
	
private:
	System::UnicodeString FFile;
	bool FSync;
	
protected:
	System::UnicodeString __fastcall CheckSoundLibrary(const System::UnicodeString AFile);
	virtual void __fastcall SetFile(const System::UnicodeString Value);
	
public:
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	__classmethod void __fastcall ChangeVolume(const int Value);
	DYNAMIC bool __fastcall IsEnabled();
	virtual void __fastcall Play()/* overload */;
	__classmethod void __fastcall Play(const System::UnicodeString AFileName, bool Synchronous = true)/* overload */;
	__classmethod void __fastcall SetGlobalPath(const System::UnicodeString Value);
	
__published:
	__property System::UnicodeString FileName = {read=FFile, write=SetFile};
	__property bool Synchronous = {read=FSync, write=FSync, default=0};
public:
	/* TTeeAnimation.Create */ inline __fastcall virtual TPlaySoundAnimation(System::Classes::TComponent* AOwner) : TTeeAnimation(AOwner) { }
	/* TTeeAnimation.Destroy */ inline __fastcall virtual ~TPlaySoundAnimation() { }
	
};

#pragma pack(pop)

//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE System::Classes::TStringList* TeeAnimationClasses;
extern DELPHI_PACKAGE void __fastcall TeeRegisterAnimation(const TTeeAnimationClass Animation);
}	/* namespace Animate */
}	/* namespace Fmxtee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMXTEE_ANIMATE)
using namespace Fmxtee::Animate;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMXTEE)
using namespace Fmxtee;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Fmxtee_AnimateHPP
