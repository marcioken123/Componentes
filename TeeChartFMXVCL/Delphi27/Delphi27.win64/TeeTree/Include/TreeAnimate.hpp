// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'TreeAnimate.pas' rev: 34.00 (Windows)

#ifndef TreeanimateHPP
#define TreeanimateHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <Vcl.ExtCtrls.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.Controls.hpp>
#include <System.Classes.hpp>
#include <System.SysUtils.hpp>
#include <System.UITypes.hpp>
#include <VCLTee.TeeProcs.hpp>
#include <VCLTee.TeeAnimate.hpp>
#include <TeeTree.hpp>
#include <System.Types.hpp>

//-- user supplied -----------------------------------------------------------

namespace Treeanimate
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TTreeAnimate;
class DELPHICLASS TNodeAnimation;
class DELPHICLASS TIntegerAnimation;
class DELPHICLASS TFontSizeAnimation;
class DELPHICLASS TMovementAnimation;
class DELPHICLASS TTransparencyAnimation;
class DELPHICLASS TTextTranspAnimation;
class DELPHICLASS TSizeAnimation;
class DELPHICLASS TBooleanAnimation;
class DELPHICLASS TVisibleAnimation;
class DELPHICLASS TColorAnimation;
class DELPHICLASS TNodeColorAnimation;
class DELPHICLASS TTreeColorAnimation;
class DELPHICLASS TCustomAnimation;
class DELPHICLASS TAddTextAnimation;
class DELPHICLASS TMoveTextAnimation;
class DELPHICLASS TTextAngleAnimation;
class DELPHICLASS TTextFlashAnimation;
class DELPHICLASS TTextColorAnimation;
class DELPHICLASS TNodeZoomAnimation;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TTreeAnimate : public Vcltee::Teeanimate::TTeeAnimate
{
	typedef Vcltee::Teeanimate::TTeeAnimate inherited;
	
private:
	Teetree::TCustomTree* FTree;
	void __fastcall SetTree(Teetree::TCustomTree* const Value);
	
protected:
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation Operation);
	
__published:
	__property Teetree::TCustomTree* Tree = {read=FTree, write=SetTree};
public:
	/* TTeeAnimate.Create */ inline __fastcall virtual TTreeAnimate(System::Classes::TComponent* AOwner) : Vcltee::Teeanimate::TTeeAnimate(AOwner) { }
	/* TTeeAnimate.Destroy */ inline __fastcall virtual ~TTreeAnimate() { }
	
};


class PASCALIMPLEMENTATION TNodeAnimation : public Vcltee::Teeanimate::TTeeAnimation
{
	typedef Vcltee::Teeanimate::TTeeAnimation inherited;
	
private:
	Teetree::TTreeNodeShape* FNode;
	void __fastcall SetNode(Teetree::TTreeNodeShape* const ANode);
	
protected:
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation Operation);
	
public:
	HIDESBASE TTreeAnimate* __fastcall Animate();
	DYNAMIC bool __fastcall IsEnabled();
	__classmethod virtual bool __fastcall IsValidOwner(System::TObject* const AObject);
	DYNAMIC void __fastcall Preview();
	__property Teetree::TTreeNodeShape* Node = {read=FNode, write=SetNode};
public:
	/* TTeeAnimation.Create */ inline __fastcall virtual TNodeAnimation(System::Classes::TComponent* AOwner) : Vcltee::Teeanimate::TTeeAnimation(AOwner) { }
	/* TTeeAnimation.Destroy */ inline __fastcall virtual ~TNodeAnimation() { }
	
};


class PASCALIMPLEMENTATION TIntegerAnimation : public TNodeAnimation
{
	typedef TNodeAnimation inherited;
	
private:
	int FEndValue;
	int FStartValue;
	int OldValue;
	void __fastcall SetEndValue(const int Value);
	
protected:
	virtual bool __fastcall EndAnimation();
	virtual int __fastcall GetValue() = 0 ;
	DYNAMIC void __fastcall NewNode();
	virtual void __fastcall NextFrame(const float Fraction);
	virtual void __fastcall SetValue(int AValue) = 0 ;
	
public:
	virtual void __fastcall Play()/* overload */;
	virtual void __fastcall StoreValue();
	__property int Value = {read=GetValue, write=SetValue, nodefault};
	
__published:
	__property int EndValue = {read=FEndValue, write=SetEndValue, default=0};
	__property Node;
	__property int StartValue = {read=FStartValue, write=FStartValue, default=0};
public:
	/* TTeeAnimation.Create */ inline __fastcall virtual TIntegerAnimation(System::Classes::TComponent* AOwner) : TNodeAnimation(AOwner) { }
	/* TTeeAnimation.Destroy */ inline __fastcall virtual ~TIntegerAnimation() { }
	
};


class PASCALIMPLEMENTATION TFontSizeAnimation : public TIntegerAnimation
{
	typedef TIntegerAnimation inherited;
	
protected:
	virtual int __fastcall GetValue();
	virtual void __fastcall SetValue(int AValue);
	
public:
	DYNAMIC void __fastcall Preview();
public:
	/* TTeeAnimation.Create */ inline __fastcall virtual TFontSizeAnimation(System::Classes::TComponent* AOwner) : TIntegerAnimation(AOwner) { }
	/* TTeeAnimation.Destroy */ inline __fastcall virtual ~TFontSizeAnimation() { }
	
};


enum DECLSPEC_DENUM TMoveSizeDirection : unsigned char { mdHorizontal, mdVertical };

class PASCALIMPLEMENTATION TMovementAnimation : public TIntegerAnimation
{
	typedef TIntegerAnimation inherited;
	
private:
	TMoveSizeDirection FDirection;
	
protected:
	virtual int __fastcall GetValue();
	virtual void __fastcall SetValue(int AValue);
	
public:
	DYNAMIC void __fastcall Preview();
	
__published:
	__property TMoveSizeDirection Direction = {read=FDirection, write=FDirection, nodefault};
public:
	/* TTeeAnimation.Create */ inline __fastcall virtual TMovementAnimation(System::Classes::TComponent* AOwner) : TIntegerAnimation(AOwner) { }
	/* TTeeAnimation.Destroy */ inline __fastcall virtual ~TMovementAnimation() { }
	
};


class PASCALIMPLEMENTATION TTransparencyAnimation : public TIntegerAnimation
{
	typedef TIntegerAnimation inherited;
	
protected:
	virtual int __fastcall GetValue();
	virtual void __fastcall SetValue(int AValue);
	
public:
	DYNAMIC void __fastcall Preview();
public:
	/* TTeeAnimation.Create */ inline __fastcall virtual TTransparencyAnimation(System::Classes::TComponent* AOwner) : TIntegerAnimation(AOwner) { }
	/* TTeeAnimation.Destroy */ inline __fastcall virtual ~TTransparencyAnimation() { }
	
};


class PASCALIMPLEMENTATION TTextTranspAnimation : public TIntegerAnimation
{
	typedef TIntegerAnimation inherited;
	
protected:
	virtual int __fastcall GetValue();
	virtual void __fastcall SetValue(int AValue);
	
public:
	DYNAMIC void __fastcall Preview();
public:
	/* TTeeAnimation.Create */ inline __fastcall virtual TTextTranspAnimation(System::Classes::TComponent* AOwner) : TIntegerAnimation(AOwner) { }
	/* TTeeAnimation.Destroy */ inline __fastcall virtual ~TTextTranspAnimation() { }
	
};


class PASCALIMPLEMENTATION TSizeAnimation : public TIntegerAnimation
{
	typedef TIntegerAnimation inherited;
	
private:
	TMoveSizeDirection FDirection;
	
protected:
	virtual int __fastcall GetValue();
	virtual void __fastcall SetValue(int AValue);
	
__published:
	__property TMoveSizeDirection Direction = {read=FDirection, write=FDirection, nodefault};
public:
	/* TTeeAnimation.Create */ inline __fastcall virtual TSizeAnimation(System::Classes::TComponent* AOwner) : TIntegerAnimation(AOwner) { }
	/* TTeeAnimation.Destroy */ inline __fastcall virtual ~TSizeAnimation() { }
	
};


class PASCALIMPLEMENTATION TBooleanAnimation : public TNodeAnimation
{
	typedef TNodeAnimation inherited;
	
private:
	bool FNewValue;
	bool OldValue;
	
protected:
	virtual bool __fastcall EndAnimation();
	virtual bool __fastcall GetValue() = 0 ;
	DYNAMIC void __fastcall NewNode();
	virtual void __fastcall NextFrame(const float Fraction);
	virtual void __fastcall SetValue(bool AValue) = 0 ;
	
public:
	virtual void __fastcall StoreValue();
	__property bool Value = {read=GetValue, write=SetValue, nodefault};
	
__published:
	__property bool NewValue = {read=FNewValue, write=FNewValue, nodefault};
	__property Node;
public:
	/* TTeeAnimation.Create */ inline __fastcall virtual TBooleanAnimation(System::Classes::TComponent* AOwner) : TNodeAnimation(AOwner) { }
	/* TTeeAnimation.Destroy */ inline __fastcall virtual ~TBooleanAnimation() { }
	
};


class PASCALIMPLEMENTATION TVisibleAnimation : public TBooleanAnimation
{
	typedef TBooleanAnimation inherited;
	
protected:
	virtual bool __fastcall GetValue();
	virtual void __fastcall SetValue(bool AValue);
	
public:
	virtual void __fastcall Stop();
public:
	/* TTeeAnimation.Create */ inline __fastcall virtual TVisibleAnimation(System::Classes::TComponent* AOwner) : TBooleanAnimation(AOwner) { }
	/* TTeeAnimation.Destroy */ inline __fastcall virtual ~TVisibleAnimation() { }
	
};


class PASCALIMPLEMENTATION TColorAnimation : public TNodeAnimation
{
	typedef TNodeAnimation inherited;
	
private:
	System::Uitypes::TColor FEndColor;
	System::Uitypes::TColor FStartColor;
	System::Uitypes::TColor OldColor;
	
protected:
	virtual bool __fastcall EndAnimation();
	virtual System::Uitypes::TColor __fastcall GetColor() = 0 ;
	DYNAMIC void __fastcall NewNode();
	virtual void __fastcall NextFrame(const float Fraction);
	virtual void __fastcall SetColor(System::Uitypes::TColor AColor) = 0 ;
	
public:
	__fastcall virtual TColorAnimation(System::Classes::TComponent* AOwner);
	virtual void __fastcall Play()/* overload */;
	virtual void __fastcall StoreValue();
	__property System::Uitypes::TColor Value = {read=GetColor, write=SetColor, nodefault};
	
__published:
	__property System::Uitypes::TColor EndColor = {read=FEndColor, write=FEndColor, default=536870911};
	__property System::Uitypes::TColor StartColor = {read=FStartColor, write=FStartColor, default=536870911};
public:
	/* TTeeAnimation.Destroy */ inline __fastcall virtual ~TColorAnimation() { }
	
};


enum DECLSPEC_DENUM TNodeColor : unsigned char { ncColor, ncBorder, ncFont, ncGradientStart, ncGradientEnd, ncGradientMiddle };

class PASCALIMPLEMENTATION TNodeColorAnimation : public TColorAnimation
{
	typedef TColorAnimation inherited;
	
private:
	TNodeColor FColor;
	
protected:
	virtual System::Uitypes::TColor __fastcall GetColor();
	virtual void __fastcall SetColor(System::Uitypes::TColor AColor);
	
public:
	DYNAMIC void __fastcall Preview();
	
__published:
	__property Node;
	__property TNodeColor NodeColor = {read=FColor, write=FColor, default=0};
public:
	/* TColorAnimation.Create */ inline __fastcall virtual TNodeColorAnimation(System::Classes::TComponent* AOwner) : TColorAnimation(AOwner) { }
	
public:
	/* TTeeAnimation.Destroy */ inline __fastcall virtual ~TNodeColorAnimation() { }
	
};


enum DECLSPEC_DENUM TTreeColor : unsigned char { tcColor, tcGrid, tcGradientStart, tcGradientEnd, tcGradientMiddle };

class PASCALIMPLEMENTATION TTreeColorAnimation : public TColorAnimation
{
	typedef TColorAnimation inherited;
	
private:
	TTreeColor FColor;
	
protected:
	virtual System::Uitypes::TColor __fastcall GetColor();
	virtual void __fastcall SetColor(System::Uitypes::TColor AColor);
	
public:
	DYNAMIC bool __fastcall IsEnabled();
	DYNAMIC void __fastcall Preview();
	
__published:
	__property TTreeColor TreeColor = {read=FColor, write=FColor, nodefault};
public:
	/* TColorAnimation.Create */ inline __fastcall virtual TTreeColorAnimation(System::Classes::TComponent* AOwner) : TColorAnimation(AOwner) { }
	
public:
	/* TTeeAnimation.Destroy */ inline __fastcall virtual ~TTreeColorAnimation() { }
	
};


class PASCALIMPLEMENTATION TCustomAnimation : public Vcltee::Teeanimate::TTeeAnimation
{
	typedef Vcltee::Teeanimate::TTeeAnimation inherited;
	
public:
	/* TTeeAnimation.Create */ inline __fastcall virtual TCustomAnimation(System::Classes::TComponent* AOwner) : Vcltee::Teeanimate::TTeeAnimation(AOwner) { }
	/* TTeeAnimation.Destroy */ inline __fastcall virtual ~TCustomAnimation() { }
	
};


class PASCALIMPLEMENTATION TAddTextAnimation : public TNodeAnimation
{
	typedef TNodeAnimation inherited;
	
private:
	System::UnicodeString OldText;
	
protected:
	virtual bool __fastcall EndAnimation();
	virtual void __fastcall NextFrame(const float Fraction);
	
public:
	virtual void __fastcall Play()/* overload */;
	DYNAMIC void __fastcall Preview();
	virtual void __fastcall StoreValue();
	
__published:
	__property Node;
public:
	/* TTeeAnimation.Create */ inline __fastcall virtual TAddTextAnimation(System::Classes::TComponent* AOwner) : TNodeAnimation(AOwner) { }
	/* TTeeAnimation.Destroy */ inline __fastcall virtual ~TAddTextAnimation() { }
	
};


class PASCALIMPLEMENTATION TMoveTextAnimation : public TNodeAnimation
{
	typedef TNodeAnimation inherited;
	
private:
	int OldOffset;
	
protected:
	virtual bool __fastcall EndAnimation();
	virtual void __fastcall NextFrame(const float Fraction);
	
public:
	virtual void __fastcall Play()/* overload */;
	virtual void __fastcall StoreValue();
	
__published:
	__property Node;
public:
	/* TTeeAnimation.Create */ inline __fastcall virtual TMoveTextAnimation(System::Classes::TComponent* AOwner) : TNodeAnimation(AOwner) { }
	/* TTeeAnimation.Destroy */ inline __fastcall virtual ~TMoveTextAnimation() { }
	
};


class PASCALIMPLEMENTATION TTextAngleAnimation : public TIntegerAnimation
{
	typedef TIntegerAnimation inherited;
	
protected:
	virtual int __fastcall GetValue();
	virtual void __fastcall SetValue(int AValue);
	
public:
	DYNAMIC void __fastcall Preview();
public:
	/* TTeeAnimation.Create */ inline __fastcall virtual TTextAngleAnimation(System::Classes::TComponent* AOwner) : TIntegerAnimation(AOwner) { }
	/* TTeeAnimation.Destroy */ inline __fastcall virtual ~TTextAngleAnimation() { }
	
};


class PASCALIMPLEMENTATION TTextFlashAnimation : public TNodeAnimation
{
	typedef TNodeAnimation inherited;
	
private:
	int OldSize;
	int StartSize;
	int FSizePercent;
	
protected:
	virtual bool __fastcall EndAnimation();
	virtual void __fastcall NextFrame(const float Fraction);
	
public:
	__fastcall virtual TTextFlashAnimation(System::Classes::TComponent* AOwner);
	virtual void __fastcall Play()/* overload */;
	virtual void __fastcall StoreValue();
	
__published:
	__property Node;
	__property int SizePercent = {read=FSizePercent, write=FSizePercent, default=100};
public:
	/* TTeeAnimation.Destroy */ inline __fastcall virtual ~TTextFlashAnimation() { }
	
};


class PASCALIMPLEMENTATION TTextColorAnimation : public TColorAnimation
{
	typedef TColorAnimation inherited;
	
protected:
	virtual System::Uitypes::TColor __fastcall GetColor();
	virtual void __fastcall SetColor(System::Uitypes::TColor AColor);
	
public:
	DYNAMIC void __fastcall Preview();
	
__published:
	__property Node;
public:
	/* TColorAnimation.Create */ inline __fastcall virtual TTextColorAnimation(System::Classes::TComponent* AOwner) : TColorAnimation(AOwner) { }
	
public:
	/* TTeeAnimation.Destroy */ inline __fastcall virtual ~TTextColorAnimation() { }
	
};


class PASCALIMPLEMENTATION TNodeZoomAnimation : public TNodeAnimation
{
	typedef TNodeAnimation inherited;
	
private:
	int FZoomPercent;
	System::Types::TRect OldBounds;
	void __fastcall SetNodeBounds(const System::Types::TRect &R);
	
protected:
	virtual bool __fastcall EndAnimation();
	virtual void __fastcall NextFrame(const float Fraction);
	
public:
	__fastcall virtual TNodeZoomAnimation(System::Classes::TComponent* AOwner);
	DYNAMIC void __fastcall Preview();
	virtual void __fastcall StoreValue();
	
__published:
	__property Node;
	__property int ZoomPercent = {read=FZoomPercent, write=FZoomPercent, default=100};
public:
	/* TTeeAnimation.Destroy */ inline __fastcall virtual ~TNodeZoomAnimation() { }
	
};


typedef System::StaticArray<System::UnicodeString, 2> Treeanimate__12;

typedef System::StaticArray<System::UnicodeString, 6> Treeanimate__22;

typedef System::StaticArray<System::UnicodeString, 5> Treeanimate__32;

//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE Treeanimate__12 MoveSizeDirection;
extern DELPHI_PACKAGE Treeanimate__22 NodeColor;
extern DELPHI_PACKAGE Treeanimate__32 TreeColor;
}	/* namespace Treeanimate */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_TREEANIMATE)
using namespace Treeanimate;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// TreeanimateHPP
