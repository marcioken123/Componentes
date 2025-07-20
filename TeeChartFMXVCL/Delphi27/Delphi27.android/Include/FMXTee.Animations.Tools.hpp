// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'FMXTee.Animations.Tools.pas' rev: 34.00 (Android)

#ifndef Fmxtee_Animations_ToolsHPP
#define Fmxtee_Animations_ToolsHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.SysUtils.hpp>
#include <System.Classes.hpp>
#include <System.UITypes.hpp>
#include <System.Types.hpp>
#include <FMXTee.Canvas.hpp>
#include <FMXTee.Engine.hpp>
#include <FMXTee.Chart.hpp>
#include <FMXTee.Animate.hpp>
#include <FMXTee.Series.hpp>

//-- user supplied -----------------------------------------------------------

namespace Fmxtee
{
namespace Animations
{
namespace Tools
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TTeeAnimationTool;
class DELPHICLASS TCustomExpandAnimation;
class DELPHICLASS TCustomAnimationChart;
class DELPHICLASS TTransformAnimation;
class DELPHICLASS TSeriesAnimation;
class DELPHICLASS TTeeLegacyAnimation;
class DELPHICLASS TSeriesAnimationTool;
class DELPHICLASS TExpandAnimation;
class DELPHICLASS TRotate3DAnimation;
class DELPHICLASS TRandomPointsAnimation;
class DELPHICLASS TLineAnimation;
class DELPHICLASS TSeriesTransitionAnimation;
//-- type declarations -------------------------------------------------------
#pragma pack(push,4)
class PASCALIMPLEMENTATION TTeeAnimationTool : public Fmxtee::Engine::TTeeCustomAnimation
{
	typedef Fmxtee::Engine::TTeeCustomAnimation inherited;
	
private:
	bool FAutoPlay;
	Fmxtee::Animate::TTeeAnimate* IAnimate;
	bool IPlayed;
	Fmxtee::Animate::TTeeAnimate* __fastcall GetAnimate();
	Fmxtee::Animate::TAnimations* __fastcall GetAnimations();
	bool __fastcall GetLoop();
	System::Classes::TNotifyEvent __fastcall GetOnPlay();
	System::Classes::TNotifyEvent __fastcall GetOnStop();
	int __fastcall GetSpeed();
	void __fastcall SetAnimate(Fmxtee::Animate::TTeeAnimate* const Value);
	void __fastcall SetLoop(const bool Value);
	void __fastcall SetOnPlay(const System::Classes::TNotifyEvent Value);
	void __fastcall SetOnStop(const System::Classes::TNotifyEvent Value);
	void __fastcall SetSpeed(const int Value);
	
protected:
	bool IKeepAnimate;
	virtual void __fastcall ChartEvent(Fmxtee::Engine::TChartToolEvent AEvent);
	DYNAMIC void __fastcall GetChildren(System::Classes::TGetChildProc Proc, System::Classes::TComponent* Root);
	DYNAMIC System::Classes::TComponent* __fastcall GetChildOwner();
	virtual void __fastcall ReadState(System::Classes::TReader* Reader);
	
public:
	void __fastcall Continue();
	void __fastcall Pause();
	bool __fastcall Paused();
	virtual void __fastcall Play();
	bool __fastcall Running();
	void __fastcall Stop();
	__classmethod virtual System::UnicodeString __fastcall Description();
	__classmethod virtual System::UnicodeString __fastcall LongDescription();
	__property Fmxtee::Animate::TAnimations* Animations = {read=GetAnimations};
	
__published:
	__property Fmxtee::Animate::TTeeAnimate* Animate = {read=GetAnimate, write=SetAnimate};
	__property bool AutoPlay = {read=FAutoPlay, write=FAutoPlay, default=0};
	__property bool Loop = {read=GetLoop, write=SetLoop, stored=false, nodefault};
	__property int Speed = {read=GetSpeed, write=SetSpeed, stored=false, nodefault};
	__property System::Classes::TNotifyEvent OnPlay = {read=GetOnPlay, write=SetOnPlay};
	__property System::Classes::TNotifyEvent OnStop = {read=GetOnStop, write=SetOnStop};
public:
	/* TCustomChartElement.Create */ inline __fastcall virtual TTeeAnimationTool(System::Classes::TComponent* AOwner) : Fmxtee::Engine::TTeeCustomAnimation(AOwner) { }
	/* TCustomChartElement.Destroy */ inline __fastcall virtual ~TTeeAnimationTool() { }
	
};

#pragma pack(pop)

enum DECLSPEC_DENUM TAnimationTrigger : unsigned char { atMouseClick, atMouseOver };

#pragma pack(push,4)
class PASCALIMPLEMENTATION TCustomExpandAnimation : public Fmxtee::Animate::TTeeAnimation
{
	typedef Fmxtee::Animate::TTeeAnimation inherited;
	
private:
	Fmxtee::Engine::TChartClickedPart FPart;
	int FSizeBy;
	Fmxtee::Engine::TChartClickedPartStyle FTarget;
	TAnimationTrigger FTrigger;
	System::Types::TPoint IOldSize;
	int ILastIndex;
	Fmxtee::Engine::TSeriesPointer* __fastcall GetPointer();
	
protected:
	virtual bool __fastcall EndAnimation();
	virtual void __fastcall NextFrame(const float Fraction);
	
public:
	__fastcall virtual TCustomExpandAnimation(System::Classes::TComponent* AOwner);
	DYNAMIC System::UnicodeString __fastcall EditorClass();
	virtual void __fastcall StoreValue();
	
__published:
	__property int SizeBy = {read=FSizeBy, write=FSizeBy, default=10};
	__property Fmxtee::Engine::TChartClickedPartStyle Target = {read=FTarget, write=FTarget, default=8};
	__property TAnimationTrigger Trigger = {read=FTrigger, write=FTrigger, default=1};
	__property TwoWay = {default=1};
public:
	/* TTeeAnimation.Destroy */ inline __fastcall virtual ~TCustomExpandAnimation() { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TCustomAnimationChart : public Fmxtee::Animate::TTeeAnimation
{
	typedef Fmxtee::Animate::TTeeAnimation inherited;
	
private:
	Fmxtee::Engine::TCustomAxisPanel* FChart;
	Fmxtee::Engine::TChartSeries* FSeries;
	void __fastcall SetChart(Fmxtee::Engine::TCustomAxisPanel* const Value);
	void __fastcall SetSeries(Fmxtee::Engine::TChartSeries* const Value);
	
protected:
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation Operation);
	
public:
	__classmethod virtual bool __fastcall IsValidOwner(System::TObject* const AObject);
	
__published:
	__property Fmxtee::Engine::TCustomAxisPanel* Chart = {read=FChart, write=SetChart};
	__property Fmxtee::Engine::TChartSeries* Series = {read=FSeries, write=SetSeries};
public:
	/* TTeeAnimation.Create */ inline __fastcall virtual TCustomAnimationChart(System::Classes::TComponent* AOwner) : Fmxtee::Animate::TTeeAnimation(AOwner) { }
	/* TTeeAnimation.Destroy */ inline __fastcall virtual ~TCustomAnimationChart() { }
	
};

#pragma pack(pop)

enum DECLSPEC_DENUM TTransformTranslate : unsigned char { ttFromLeft, ttFromRight, ttFromTop, ttFromBottom, ttFromTopLeft, ttFromTopRight, ttFromBottomLeft, ttFromBottomRight, ttNone };

enum DECLSPEC_DENUM TTransformZoom : unsigned char { tzNone, tzIn, tzOut };

enum DECLSPEC_DENUM TTransformFade : unsigned char { tfNone, tfIn, tfOut };

enum DECLSPEC_DENUM TTransformScale : unsigned char { tsNone, tsHorizontal, tsVertical, tsBoth };

typedef Fmxtee::Engine::TChartClickedPartStyle TTransformAnimationTarget;

#pragma pack(push,4)
class PASCALIMPLEMENTATION TTransformAnimation : public TCustomAnimationChart
{
	typedef TCustomAnimationChart inherited;
	
private:
	Fmxtee::Engine::TChartAxis* FAxis;
	bool FClip;
	TTransformFade FFade;
	int FMaxZoom;
	int FRotateMin;
	int FRotateMax;
	TTransformScale FScale;
	Fmxtee::Engine::TChartClickedPartStyle FTarget;
	TTransformTranslate FTranslateStyle;
	bool FUseBounds;
	TTransformZoom FZoomStyle;
	int IAxisID;
	Fmxtee::Chart::TCustomChart* IChart;
	bool IOldClip;
	bool IOldClipFlag;
	int IOldTransp;
	Fmxtee::Canvas::TTeeTransform* ILastTransform;
	Fmxtee::Engine::TCustomAxisPanel* __fastcall CalcChart();
	void __fastcall ReadAxis(System::Classes::TReader* Reader);
	void __fastcall WriteAxis(System::Classes::TWriter* Writer);
	
protected:
	void __fastcall ChangeTransform(const float Fraction, Fmxtee::Canvas::TTeeTransform* const Transform, const System::Types::TRectF &R);
	virtual void __fastcall DefineProperties(System::Classes::TFiler* Filer);
	virtual bool __fastcall EndAnimation();
	virtual void __fastcall NextFrame(const float Fraction);
	virtual void __fastcall Loaded();
	
public:
	__fastcall virtual TTransformAnimation(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TTransformAnimation();
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	void __fastcall AssignTransform(TTransformAnimation* const ATransform);
	DYNAMIC System::UnicodeString __fastcall EditorClass();
	__classmethod virtual System::UnicodeString __fastcall Description();
	
__published:
	__property Fmxtee::Engine::TChartAxis* Axis = {read=FAxis, write=FAxis, stored=false};
	__property bool Clip = {read=FClip, write=FClip, default=1};
	__property TTransformFade Fade = {read=FFade, write=FFade, default=0};
	__property int MaxZoom = {read=FMaxZoom, write=FMaxZoom, default=300};
	__property int RotateMin = {read=FRotateMin, write=FRotateMin, default=0};
	__property int RotateMax = {read=FRotateMax, write=FRotateMax, default=0};
	__property TTransformScale Scale = {read=FScale, write=FScale, default=0};
	__property TTransformTranslate TranslateStyle = {read=FTranslateStyle, write=FTranslateStyle, default=0};
	__property Fmxtee::Engine::TChartClickedPartStyle Target = {read=FTarget, write=FTarget, default=3};
	__property bool UseBounds = {read=FUseBounds, write=FUseBounds, default=1};
	__property TTransformZoom ZoomStyle = {read=FZoomStyle, write=FZoomStyle, default=0};
};

#pragma pack(pop)

enum DECLSPEC_DENUM TSeriesAnimationLoop : unsigned char { salNo, salOneWay, salCircular };

class PASCALIMPLEMENTATION TSeriesAnimation : public TCustomAnimationChart
{
	typedef TCustomAnimationChart inherited;
	
private:
	int FDrawEvery;
	TSeriesAnimationLoop FLoop;
	double FStartValue;
	bool FStartAtMin;
	bool IDirection;
	System::Classes::TNotifyEvent IOnStart;
	System::Classes::TNotifyEvent IOnStep;
	System::Classes::TNotifyEvent IOnStop;
	Fmxtee::Engine::TCustomAxisPanel* IPrepared;
	bool OldCustom;
	void __fastcall RemoveAllSeries(Fmxtee::Engine::TChartSeriesList* const AList);
	
protected:
	Fmxtee::Engine::TChartSeriesList* IBackup;
	virtual bool __fastcall AnimateSeries(const float Fraction, Fmxtee::Engine::TChartSeries* const ASeries, int AIndex);
	virtual bool __fastcall EndAnimation();
	virtual void __fastcall NextFrame(const float Fraction);
	virtual void __fastcall SetInitialValues(Fmxtee::Engine::TChartSeries* const ASeries);
	virtual void __fastcall StoreSeries(Fmxtee::Engine::TChartSeries* const ASeries);
	
public:
	__fastcall virtual TSeriesAnimation(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TSeriesAnimation();
	__classmethod virtual System::UnicodeString __fastcall Description();
	DYNAMIC System::UnicodeString __fastcall EditorClass();
	virtual void __fastcall StoreValue();
	
__published:
	__property int DrawEvery = {read=FDrawEvery, write=FDrawEvery, default=0};
	__property TSeriesAnimationLoop Loop = {read=FLoop, write=FLoop, default=0};
	__property bool StartAtMin = {read=FStartAtMin, write=FStartAtMin, default=1};
	__property double StartValue = {read=FStartValue, write=FStartValue};
};


#pragma pack(push,4)
class PASCALIMPLEMENTATION TTeeLegacyAnimation : public TTeeAnimationTool
{
	typedef TTeeAnimationTool inherited;
	
private:
	Fmxtee::Animate::TTeeAnimation* IAnimation;
	
protected:
	virtual void __fastcall DoCreateAnimation() = 0 ;
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation Operation);
	virtual void __fastcall ReadState(System::Classes::TReader* Reader);
	virtual void __fastcall SetAnimation(Fmxtee::Animate::TTeeAnimation* const Value);
	virtual bool __fastcall Valid(System::Classes::TComponent* const Value) = 0 ;
	
public:
	__fastcall virtual TTeeLegacyAnimation(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TTeeLegacyAnimation();
	
__published:
	__property Active = {default=1};
};

#pragma pack(pop)

typedef void __fastcall (__closure *TSeriesAnimationStep)(TSeriesAnimationTool* Sender, int Step);

#pragma pack(push,4)
class PASCALIMPLEMENTATION TSeriesAnimationTool : public TTeeLegacyAnimation
{
	typedef TTeeLegacyAnimation inherited;
	
private:
	System::Classes::TNotifyEvent FOnStart;
	TSeriesAnimationStep FOnStep;
	System::Classes::TNotifyEvent FOnStop;
	void __fastcall DoStart(System::TObject* Sender);
	void __fastcall DoStep(System::TObject* Sender);
	void __fastcall DoStop(System::TObject* Sender);
	TSeriesAnimation* __fastcall GetAnimation();
	int __fastcall GetDelay();
	int __fastcall GetDrawEvery();
	int __fastcall GetDuration();
	HIDESBASE TSeriesAnimationLoop __fastcall GetLoop();
	Fmxtee::Engine::TChartSeries* __fastcall GetSeries();
	bool __fastcall GetStartAtMin();
	double __fastcall GetStartValue();
	int __fastcall GetSteps();
	void __fastcall ReadSteps(System::Classes::TReader* Reader);
	void __fastcall SetDelay(const int Value);
	void __fastcall SetDrawEvery(const int Value);
	void __fastcall SetDuration(const int Value);
	HIDESBASE void __fastcall SetLoop(const TSeriesAnimationLoop Value);
	void __fastcall SetSeries(Fmxtee::Engine::TChartSeries* const Value);
	void __fastcall SetStartAtMin(const bool Value);
	void __fastcall SetStartValue(const double Value);
	void __fastcall SetSteps(const int Value);
	HIDESBASE bool __fastcall Running();
	
protected:
	virtual void __fastcall DefineProperties(System::Classes::TFiler* Filer);
	virtual void __fastcall DoCreateAnimation();
	__classmethod virtual System::UnicodeString __fastcall GetEditorClass();
	virtual void __fastcall SetAnimation(Fmxtee::Animate::TTeeAnimation* const Value);
	virtual void __fastcall SetParentChart(Fmxtee::Engine::TCustomAxisPanel* const Value);
	virtual bool __fastcall Valid(System::Classes::TComponent* const Value);
	
public:
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	__classmethod virtual System::UnicodeString __fastcall Description();
	void __fastcall Execute()/* overload */;
	void __fastcall Execute(System::TObject* Sender)/* overload */;
	__classmethod virtual System::UnicodeString __fastcall LongDescription();
	__property TSeriesAnimation* Animation = {read=GetAnimation};
	__property int Steps = {read=GetSteps, write=SetSteps, nodefault};
	
__published:
	__property int Delay = {read=GetDelay, write=SetDelay, stored=false, nodefault};
	__property int DrawEvery = {read=GetDrawEvery, write=SetDrawEvery, stored=false, nodefault};
	__property int Duration = {read=GetDuration, write=SetDuration, stored=false, nodefault};
	__property TSeriesAnimationLoop Loop = {read=GetLoop, write=SetLoop, stored=false, nodefault};
	__property Fmxtee::Engine::TChartSeries* Series = {read=GetSeries, write=SetSeries, stored=false};
	__property bool StartAtMin = {read=GetStartAtMin, write=SetStartAtMin, stored=false, nodefault};
	__property double StartValue = {read=GetStartValue, write=SetStartValue, stored=false};
	__property System::Classes::TNotifyEvent OnStart = {read=FOnStart, write=FOnStart};
	__property TSeriesAnimationStep OnStep = {read=FOnStep, write=FOnStep};
	__property System::Classes::TNotifyEvent OnStop = {read=FOnStop, write=FOnStop};
public:
	/* TTeeLegacyAnimation.Create */ inline __fastcall virtual TSeriesAnimationTool(System::Classes::TComponent* AOwner) : TTeeLegacyAnimation(AOwner) { }
	/* TTeeLegacyAnimation.Destroy */ inline __fastcall virtual ~TSeriesAnimationTool() { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TExpandAnimation : public TTeeLegacyAnimation
{
	typedef TTeeLegacyAnimation inherited;
	
private:
	TCustomExpandAnimation* __fastcall GetAnimation();
	int __fastcall GetExpandSpeed();
	void __fastcall SetExpandSpeed(const int Value);
	int __fastcall GetSizeBy();
	Fmxtee::Engine::TChartClickedPartStyle __fastcall GetTarget();
	TAnimationTrigger __fastcall GetTrigger();
	void __fastcall SetSizeBy(const int Value);
	void __fastcall SetTarget(const Fmxtee::Engine::TChartClickedPartStyle Value);
	void __fastcall SetTrigger(const TAnimationTrigger Value);
	
protected:
	virtual void __fastcall ChartMouseEvent(Fmxtee::Engine::TChartMouseEvent AEvent, System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, int X, int Y);
	virtual void __fastcall DoCreateAnimation();
	virtual bool __fastcall Valid(System::Classes::TComponent* const Value);
	
public:
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	__classmethod virtual System::UnicodeString __fastcall Description();
	__classmethod virtual System::UnicodeString __fastcall LongDescription();
	__property TCustomExpandAnimation* Animation = {read=GetAnimation};
	
__published:
	__property int SizeBy = {read=GetSizeBy, write=SetSizeBy, stored=false, nodefault};
	__property int Speed = {read=GetExpandSpeed, write=SetExpandSpeed, stored=false, nodefault};
	__property Fmxtee::Engine::TChartClickedPartStyle Target = {read=GetTarget, write=SetTarget, stored=false, nodefault};
	__property TAnimationTrigger Trigger = {read=GetTrigger, write=SetTrigger, stored=false, nodefault};
public:
	/* TTeeLegacyAnimation.Create */ inline __fastcall virtual TExpandAnimation(System::Classes::TComponent* AOwner) : TTeeLegacyAnimation(AOwner) { }
	/* TTeeLegacyAnimation.Destroy */ inline __fastcall virtual ~TExpandAnimation() { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TRotate3DAnimation : public TCustomAnimationChart
{
	typedef TCustomAnimationChart inherited;
	
private:
	Fmxtee::Canvas::TView3DOptions* IBackup;
	bool IBackupView3D;
	
protected:
	virtual bool __fastcall EndAnimation();
	virtual void __fastcall NextFrame(const float Fraction);
	
public:
	__fastcall virtual TRotate3DAnimation(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TRotate3DAnimation();
	__classmethod virtual System::UnicodeString __fastcall Description();
	DYNAMIC System::UnicodeString __fastcall EditorClass();
	virtual void __fastcall StoreValue();
};

#pragma pack(pop)

class PASCALIMPLEMENTATION TRandomPointsAnimation : public TSeriesAnimation
{
	typedef TSeriesAnimation inherited;
	
private:
	Fmxtee::Engine::TChartSeriesList* IRandom;
	
protected:
	virtual bool __fastcall AnimateSeries(const float Fraction, Fmxtee::Engine::TChartSeries* const ASeries, int AIndex);
	virtual void __fastcall SetInitialValues(Fmxtee::Engine::TChartSeries* const ASeries);
	virtual void __fastcall StoreSeries(Fmxtee::Engine::TChartSeries* const ASeries);
	
public:
	__fastcall virtual TRandomPointsAnimation(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TRandomPointsAnimation();
	__classmethod virtual System::UnicodeString __fastcall Description();
	virtual void __fastcall StoreValue();
};


#pragma pack(push,4)
class PASCALIMPLEMENTATION TLineAnimation : public TCustomAnimationChart
{
	typedef TCustomAnimationChart inherited;
	
private:
	bool __fastcall ChangeAll(const float Fraction);
	
protected:
	virtual void __fastcall NextFrame(const float Fraction);
	
public:
	__classmethod virtual System::UnicodeString __fastcall Description();
	virtual void __fastcall Stop();
public:
	/* TTeeAnimation.Create */ inline __fastcall virtual TLineAnimation(System::Classes::TComponent* AOwner) : TCustomAnimationChart(AOwner) { }
	/* TTeeAnimation.Destroy */ inline __fastcall virtual ~TLineAnimation() { }
	
};

#pragma pack(pop)

typedef System::DynamicArray<System::DynamicArray<System::Types::TRectF> > TSeriesTransitionData;

#pragma pack(push,4)
class PASCALIMPLEMENTATION TSeriesTransitionAnimation : public TCustomAnimationChart
{
	typedef TCustomAnimationChart inherited;
	
private:
	TSeriesTransitionData FSource;
	TSeriesTransitionData FDest;
	float IFraction;
	void __fastcall GetBar(Fmxtee::Series::TCustomBarSeries* Sender, int ValueIndex, System::Types::TRectF &Rect);
	void __fastcall Remember(TSeriesTransitionData &AData);
	void __fastcall SetEvent(const Fmxtee::Series::TGetBarBoundsEvent AEvent);
	
protected:
	virtual void __fastcall NextFrame(const float Fraction);
	
public:
	__fastcall virtual TSeriesTransitionAnimation(System::Classes::TComponent* AOwner);
	void __fastcall After();
	void __fastcall Before();
	__classmethod virtual System::UnicodeString __fastcall Description();
	virtual void __fastcall Stop();
	virtual void __fastcall StoreValue();
public:
	/* TTeeAnimation.Destroy */ inline __fastcall virtual ~TSeriesTransitionAnimation() { }
	
};

#pragma pack(pop)

//-- var, const, procedure ---------------------------------------------------
}	/* namespace Tools */
}	/* namespace Animations */
}	/* namespace Fmxtee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMXTEE_ANIMATIONS_TOOLS)
using namespace Fmxtee::Animations::Tools;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMXTEE_ANIMATIONS)
using namespace Fmxtee::Animations;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMXTEE)
using namespace Fmxtee;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Fmxtee_Animations_ToolsHPP
