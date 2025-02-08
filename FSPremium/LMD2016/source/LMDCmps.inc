{LMD 2016 Compiler Switches - © by LMD Innovative}
{******************************************************************************}
{To turn specific features on/off remove/place "." before "$" in the directive}

{********************* Enable/Disable Debug Support ***************************}
{------------------------------------------------------------------------------}
// Use this switch to enable/disable Debug settings for compiler
{$DEFINE LMD_DEBUG}

{*************** General Options for all LMD packages *************************}
{------------------------------------------------------------------------------}
// Unicode support: Comment this switch, to disable Unicode support (where available)
{$DEFINE LMD_UNICODE}

{************************** PNG Support Options *******************************}
{------------------------------------------------------------------------------}
// Remove dot if you want to use LMD PNG Image object in Delphi 2009+
// (in earlier version this will be registered automatically)

{.$DEFINE LMD_REGISTERPNG}

// Drawing mode for semitransparent png images
{$DEFINE LMD_PARTIALTRANSPARENTDRAWPNG}

// Remove  dot to disable OleInitialize in initialization section

{.$define LMDDISABLE_OLEINIT}

{************************** Ribbon Themes support *****************************}
{------------------------------------------------------------------------------}

// Remove dot if you want to use Ribbon support in lmd.themes package
// in Delphi 10.1+.
{.$DEFINE LMD_ENABLE_GETIT_RIBBONS}

{**************************** LMD Core Options ********************************}

// Since 2012.1, ImageIndex is used in TLMDBaseGraphicButton to define image
// taken from image list.
// Remove dot if you want to force use of ListIndex in TLMDBaseGraphicButton 
// so that ListIndex is used to define image index in one-dimensional 
// imagelists like TLMDBitmapList, TLMDGraphicList etc, like it was before 2012.1

{.$DEFINE LMD_FORCELISTINDEXUSE}

{************************** LMD ElPack Options ********************************}
{------------------------------------------------------------------------------}

// Uniscribe support: comment this switch, to disable Uniscribe support
// note: feature is in alpha stage and not available for all controls

{.$DEFINE LMD_ELUNISCRIBE}

// Disables TElToolBar.Setup method that show the dialog that lets user re-arrange
// and show or hide controls on toolbar. This method is hidden by default
// to make less executable

{$DEFINE LMDDISABLE_ELTOOLBAR_SETUP}

// Disables TElHeader.Setup method that show the dialog for sections in ElHeader object
// This method is disabled by default to make less executable

{$DEFINE LMDDISABLE_ELHEADER_SETUP}

{****************************** Profiling  ************************************}
{------------------------------------------------------------------------------}

// Special key added on user request. Enable this key if you want to disable
// self-modifying code such as the internal theme engine and ElPack hook set.

{.$DEFINE LMD_PROFILING}

// =============================================================================
{***************************** Internal settings ******************************}
// =============================================================================
// Following compiler settings shouldn't be changed

{********************* Additional Debug settings ******************************}
{------------------------------------------------------------------------------}
// required internally for special debugging purposes
{.$DEFINE LMD_DEBUGTRACE}

// enables or disables output of debug messages
{.$DEFINE LMD_DEBUGMESSAGES}

{************************ Unicode related flags *******************************}
{------------------------------------------------------------------------------}

{*************** Determine Delphi/CBuilder Version ****************************}
{------------------------------------------------------------------------------}
// Delphi 6
{$IFDEF VER140}
  {$DEFINE LMDCOMP_DETECT}
  {$DEFINE LMDCOMP6}
  {$DEFINE LMD_REGISTERPNG}
{$ENDIF}

// Delphi 7
{$IFDEF VER150}
  {$DEFINE LMDCOMP_DETECT}
  {$DEFINE LMDCOMP7}
  {$DEFINE LMD_REGISTERPNG}
{$ENDIF}

// Delphi 2005
{$IFDEF VER170}
  {$DEFINE LMDCOMP_DETECT}
  {$DEFINE LMDCOMP7}
  {$DEFINE LMDCOMP9}
  {$DEFINE LMD_REGISTERPNG}
{$ENDIF}

// BDS 2006 + Delphi/C++ 2007
{$IFDEF VER180}
  {$DEFINE LMDCOMP_DETECT}
  {$DEFINE LMDCOMP7}
  {$DEFINE LMDCOMP9}
  {$DEFINE LMDCOMP10}
  {$IFDEF VER185}   // BDS 5.0 also defines VER180
    {$DEFINE LMDCOMP11}  // -> Delphi/C++ Builder 2007
  {$ENDIF}
  {$DEFINE LMD_REGISTERPNG}
{$ENDIF}

// Delphi 2007.NET
{$IFDEF VER190}
  {$DEFINE LMDCOMP_DETECT}
  {$DEFINE LMDCOMP7}
  {$DEFINE LMDCOMP9}
  {$DEFINE LMDCOMP10}
  {$DEFINE LMDCOMP11}
  {$DEFINE LMD_REGISTERPNG}
{$ENDIF}

// CRS 2009 --> VER200
{$IFDEF VER200}
  {$DEFINE LMDCOMP_DETECT}
  {$DEFINE LMDCOMP7}
  {$DEFINE LMDCOMP9}
  {$DEFINE LMDCOMP10}
  {$DEFINE LMDCOMP11}
  {$DEFINE LMDCOMP12}
{$ENDIF}

// ERS 2010 --> VER210
{$IFDEF VER210}
  {$DEFINE LMDCOMP_DETECT}
  {$DEFINE LMDCOMP7}
  {$DEFINE LMDCOMP9}
  {$DEFINE LMDCOMP10}
  {$DEFINE LMDCOMP11}
  {$DEFINE LMDCOMP12}
  {$DEFINE LMDCOMP14}
{$ENDIF}

// ERS XE --> VER220
{$IFDEF VER220}
  {$DEFINE LMDCOMP_DETECT}
  {$DEFINE LMDCOMP7}
  {$DEFINE LMDCOMP9}
  {$DEFINE LMDCOMP10}
  {$DEFINE LMDCOMP11}
  {$DEFINE LMDCOMP12}
  {$DEFINE LMDCOMP14}
  {$DEFINE LMDCOMP15}
{$ENDIF}

// ERS XE2 --> VER230
{$IFDEF VER230}
  {$DEFINE LMDCOMP_DETECT}
  {$DEFINE LMDCOMP7}
  {$DEFINE LMDCOMP9}
  {$DEFINE LMDCOMP10}
  {$DEFINE LMDCOMP11}
  {$DEFINE LMDCOMP12}
  {$DEFINE LMDCOMP14}
  {$DEFINE LMDCOMP15}
  {$DEFINE LMDCOMP16}
{$ENDIF}

//XE3
{$IFDEF VER240}
  {$DEFINE LMDCOMP_DETECT}
  {$DEFINE LMDCOMP7}
  {$DEFINE LMDCOMP9}
  {$DEFINE LMDCOMP10}
  {$DEFINE LMDCOMP11}
  {$DEFINE LMDCOMP12}
  {$DEFINE LMDCOMP14}
  {$DEFINE LMDCOMP15}
  {$DEFINE LMDCOMP16}
  {$DEFINE LMDCOMP17}
{$ENDIF}

//XE4
{$IFDEF VER250}
  {$DEFINE LMDCOMP_DETECT}
  {$DEFINE LMDCOMP7}
  {$DEFINE LMDCOMP9}
  {$DEFINE LMDCOMP10}
  {$DEFINE LMDCOMP11}
  {$DEFINE LMDCOMP12}
  {$DEFINE LMDCOMP14}
  {$DEFINE LMDCOMP15}
  {$DEFINE LMDCOMP16}
  {$DEFINE LMDCOMP17}
  {$DEFINE LMDCOMP18}
{$ENDIF}

//XE5
{$IFDEF VER260}
  {$DEFINE LMDCOMP_DETECT}
  {$DEFINE LMDCOMP7}
  {$DEFINE LMDCOMP9}
  {$DEFINE LMDCOMP10}
  {$DEFINE LMDCOMP11}
  {$DEFINE LMDCOMP12}
  {$DEFINE LMDCOMP14}
  {$DEFINE LMDCOMP15}
  {$DEFINE LMDCOMP16}
  {$DEFINE LMDCOMP17}
  {$DEFINE LMDCOMP18}
  {$DEFINE LMDCOMP19}
{$ENDIF}

//XE6
{$IFDEF VER270}
  {$DEFINE LMDCOMP_DETECT}
  {$DEFINE LMDCOMP7}
  {$DEFINE LMDCOMP9}
  {$DEFINE LMDCOMP10}
  {$DEFINE LMDCOMP11}
  {$DEFINE LMDCOMP12}
  {$DEFINE LMDCOMP14}
  {$DEFINE LMDCOMP15}
  {$DEFINE LMDCOMP16}
  {$DEFINE LMDCOMP17}
  {$DEFINE LMDCOMP18}
  {$DEFINE LMDCOMP19}
  {$DEFINE LMDCOMP20}
{$ENDIF}

//XE7
{$IFDEF VER280}
  {$DEFINE LMDCOMP_DETECT}
  {$DEFINE LMDCOMP7}
  {$DEFINE LMDCOMP9}
  {$DEFINE LMDCOMP10}
  {$DEFINE LMDCOMP11}
  {$DEFINE LMDCOMP12}
  {$DEFINE LMDCOMP14}
  {$DEFINE LMDCOMP15}
  {$DEFINE LMDCOMP16}
  {$DEFINE LMDCOMP17}
  {$DEFINE LMDCOMP18}
  {$DEFINE LMDCOMP19}
  {$DEFINE LMDCOMP20}
  {$DEFINE LMDCOMP21}
{$ENDIF}

//XE8
{$IFDEF VER290}
  {$DEFINE LMDCOMP_DETECT}
  {$DEFINE LMDCOMP7}
  {$DEFINE LMDCOMP9}
  {$DEFINE LMDCOMP10}
  {$DEFINE LMDCOMP11}
  {$DEFINE LMDCOMP12}
  {$DEFINE LMDCOMP14}
  {$DEFINE LMDCOMP15}
  {$DEFINE LMDCOMP16}
  {$DEFINE LMDCOMP17}
  {$DEFINE LMDCOMP18}
  {$DEFINE LMDCOMP19}
  {$DEFINE LMDCOMP20}
  {$DEFINE LMDCOMP21}
  {$DEFINE LMDCOMP22}  
{$ENDIF}

//10 Seattle
{$IFDEF VER300}
  {$DEFINE LMDCOMP_DETECT}
  {$DEFINE LMDCOMP7}
  {$DEFINE LMDCOMP9}
  {$DEFINE LMDCOMP10}
  {$DEFINE LMDCOMP11}
  {$DEFINE LMDCOMP12}
  {$DEFINE LMDCOMP14}
  {$DEFINE LMDCOMP15}
  {$DEFINE LMDCOMP16}
  {$DEFINE LMDCOMP17}
  {$DEFINE LMDCOMP18}
  {$DEFINE LMDCOMP19}
  {$DEFINE LMDCOMP20}
  {$DEFINE LMDCOMP21}
  {$DEFINE LMDCOMP22}  
  {$DEFINE LMDCOMP23}  
{$ENDIF}

// 10.1 Berlin
{$IFDEF VER310}
  {$DEFINE LMDCOMP_DETECT}
  {$DEFINE LMDCOMP7}
  {$DEFINE LMDCOMP9}
  {$DEFINE LMDCOMP10}
  {$DEFINE LMDCOMP11}
  {$DEFINE LMDCOMP12}
  {$DEFINE LMDCOMP14}
  {$DEFINE LMDCOMP15}
  {$DEFINE LMDCOMP16}
  {$DEFINE LMDCOMP17}
  {$DEFINE LMDCOMP18}
  {$DEFINE LMDCOMP19}
  {$DEFINE LMDCOMP20}
  {$DEFINE LMDCOMP21}
  {$DEFINE LMDCOMP22}  
  {$DEFINE LMDCOMP23}  
  {$DEFINE LMDCOMP24}  
{$ENDIF}

// 10.2 Tokio
{$IFDEF VER320}
  {$DEFINE LMDCOMP_DETECT}
  {$DEFINE LMDCOMP7}
  {$DEFINE LMDCOMP9}
  {$DEFINE LMDCOMP10}
  {$DEFINE LMDCOMP11}
  {$DEFINE LMDCOMP12}
  {$DEFINE LMDCOMP14}
  {$DEFINE LMDCOMP15}
  {$DEFINE LMDCOMP16}
  {$DEFINE LMDCOMP17}
  {$DEFINE LMDCOMP18}
  {$DEFINE LMDCOMP19}
  {$DEFINE LMDCOMP20}
  {$DEFINE LMDCOMP21}
  {$DEFINE LMDCOMP22}  
  {$DEFINE LMDCOMP23}  
  {$DEFINE LMDCOMP24}
  {$DEFINE LMDCOMP25}
{$ENDIF}

// No compiler found? We assume a higher release
{$IFNDEF LMDCOMP_DETECT}
  {$DEFINE LMDCOMP7}
  {$DEFINE LMDCOMP9}
  {$DEFINE LMDCOMP10}
  {$DEFINE LMDCOMP11}
  {$DEFINE LMDCOMP12}
  {$DEFINE LMDCOMP14}
  {$DEFINE LMDCOMP15}
  {$DEFINE LMDCOMP16}
  {$DEFINE LMDCOMP17}
  {$DEFINE LMDCOMP18}
  {$DEFINE LMDCOMP19}
  {$DEFINE LMDCOMP20}
  {$DEFINE LMDCOMP21}
  {$DEFINE LMDCOMP22}
  {$DEFINE LMDCOMP23}
  {$DEFINE LMDCOMP24}
  {$DEFINE LMDCOMP25}
{$ENDIF}

// Detect x86 or x64 code
{$IFDEF LMDCOMP16}
  {$IFDEF CPUX64}
    {$DEFINE LMDX64}
  {$ELSE}
    {$DEFINE LMDX86}
  {$ENDIF}
{$ELSE}
  {$DEFINE LMDX86}
{$ENDIF}

{$WARN UNIT_DEPRECATED OFF}
{$WARN UNIT_PLATFORM OFF}
{$WARN SYMBOL_DEPRECATED OFF}
{$WARN SYMBOL_PLATFORM OFF}

// Shared from VCL release 7
{$IFDEF LMDCOMP7}
  {$WARN UNSAFE_CODE OFF}
  {$WARN UNSAFE_TYPE OFF}
  {$WARN UNSAFE_CAST OFF}
{$ENDIF}

// Shared from VCL release 9
{$IFDEF LMDCOMP9}
  {$DEFINE LMD_INLINE} // code inlining
  {$INLINE ON}
{$ENDIF}

// Delphi 12 version is always unicode
{$IFDEF LMDCOMP12}
  {$DEFINE LMD_UNICODE}
  {$DEFINE LMD_NATIVEUNICODE}
{$ENDIF}

//.Net version is always unicode but no uniscribe
{$IFDEF CLR}
  {$DEFINE LMD_UNICODE}
  {$DEFINE LMD_NATIVEUNICODE}
  {$UNDEF LMD_ELUNISCRIBE}
{$ENDIF}


// This flag specifies whether special Unicode implementation need to be used
// for VCL based Unicode controls.
// E.g. for example in .Net there is no need to use special implementation,
// because Vcl .Net is already Unicode.
// Note also that special implementation does not guarantee Unicode support -
// the OS need to be Unicode as well.
{$IFDEF LMD_UNICODE}
  {$IFNDEF LMD_NATIVEUNICODE}
    {$DEFINE _LMD_UNICODEIMPL}
  {$ENDIF}
{$ENDIF}

// Ribbons support in lmd.themes package.
{$IFDEF LMDCOMP12}
  {$IFDEF LMDCOMP24}
    {$IFDEF LMD_ENABLE_GETIT_RIBBONS}
      {$DEFINE _LMD_THEMESRIBBONIMPL}
    {$ENDIF}
  {$ELSE}
    {$DEFINE _LMD_THEMESRIBBONIMPL}
  {$ENDIF}
{$ENDIF}

{********************* Special Debug / Release settings ***********************}
{------------------------------------------------------------------------------}
{$IFDEF LMD_DEBUG}
  {$HINTS ON; WARNINGS ON}{$D+,L+,Y+,O-}{$W+} // STACKFRAMES
{$ELSE}
  {$HINTS OFF; WARNINGS OFF}{$D-,L-,Y-,O+}
  {$ASSERTIONS OFF}  
{$ENDIF}

{*************************** All other settings *******************************}
{------------------------------------------------------------------------------}
{$B-,X+,P+,R-,Q-,H+,W-,J+,A+,T-,S+,U-,V+,W-}{$A8}
{$IFDEF LMDCOMP17}
  {$INLINE OFF}
{$ENDIF}
