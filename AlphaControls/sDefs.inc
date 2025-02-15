{ ---- Definitions by Serge V. Goncharov ---- }

{$DEFINE ACDPIAWARE} // Comment this line if support of DPI-aware mode is not required

//{$DEFINE USE_INET} // Use internet functions in the package (wininet.lib should be added in C++ Builder projects also)

//{$DEFINE NOFONTRES}          // Exclude the symbol font resource
//{$DEFINE ADDWEBBROWSER}      // Support of the TWebBrowser (full AC sources needed)
//{$DEFINE DISABLEPREVIEWMODE} // If key is enabled then preview code is excluded
//{$DEFINE NOWNDANIMATION}     // Disable animation effects for dialogs and forms
{$DEFINE SKININDESIGN}         // Skin control in frames in design-time
//{$DEFINE ALITE}              // Free Lite Edition
//{$DEFINE NOACPNG}            // Do not use AlphaControls Png loader automatically
//{$DEFINE NOJPG}              // Jpegs will not be used
//{$DEFINE GDIPLUS_PNG}        // Use GDI+ for decoding of Png images (more faster, but quality of images is worse sometimes)

// << 3rdparty support start <<
//{$DEFINE DEVEX2011}  // DevExpress, LookAndFeel.NativeStyle property must be False
//{$DEFINE DEVEX6}     // Old version of DevExpress components, earlier than v2011
//{$DEFINE DEVEXHINTS} // Uncomment this line if you have conflicts between DevEx hints and AlphaHints
//{$DEFINE USEPNG}     // Support of TPngImageList from PngComponents
//{$DEFINE TNTUNICODE} // Enable Unicode support by TntControls
// >> 3rdparty support finish >>

{$IFNDEF NOJPG}
//  {$DEFINE TINYJPG} // Faster than std TJPEGImage
{$ENDIF}


//{$DEFINE TESTSLOWDETAILS} // Simplified output without slow effects, used for a package painting testing mainly

{ ---- End defs by Serge V. Goncharov ---- }

{$DEFINE ALPHASKINS}

{$IFDEF VER350} {$DEFINE DELPHI_11}{$ENDIF}
{$IFDEF VER340} {$DEFINE DELPHI_10SYDNEY}{$ENDIF}
{$IFDEF VER330} {$DEFINE DELPHI_10RIO}{$ENDIF}
{$IFDEF VER320} {$DEFINE DELPHI_10TOKYO}{$ENDIF}
{$IFDEF VER310} {$DEFINE DELPHI_10BERLIN}{$ENDIF}
{$IFDEF VER300} {$DEFINE DELPHI_10}  {$ENDIF}
{$IFDEF VER290} {$DEFINE DELPHI_XE8} {$ENDIF}
{$IFDEF VER280} {$DEFINE DELPHI_XE7} {$ENDIF}
{$IFDEF VER270} {$DEFINE DELPHI_XE6} {$ENDIF}
{$IFDEF VER260} {$DEFINE DELPHI_XE5} {$ENDIF}
{$IFDEF VER250} {$DEFINE DELPHI_XE4} {$ENDIF}
{$IFDEF VER240} {$DEFINE DELPHI_XE3} {$ENDIF}
{$IFDEF VER230} {$DEFINE DELPHI_XE2} {$ENDIF}
{$IFDEF VER220} {$DEFINE DELPHI_XE}  {$ENDIF}
{$IFDEF VER210} {$DEFINE D2010}      {$ENDIF}
{$IFDEF VER200} {$DEFINE D2009}      {$ENDIF}
{$IFDEF VER185} {$DEFINE D2007}      {$ENDIF}
{$IFDEF VER180} {$DEFINE D2006}      {$ENDIF}
{$IFDEF VER170} {$DEFINE D2005}      {$ENDIF}
{$IFDEF VER150} {$DEFINE DELPHI7UP}  {$ENDIF}
{$IFDEF VER140} {$DEFINE DELPHI6UP}  {$ENDIF}
{$IFDEF VER130} {$DEFINE DELPHI5}    {$ENDIF}

{$IFDEF DELPHI_11}{$DEFINE DELPHI_10SYDNEY}{$ENDIF}
{$IFDEF DELPHI_10SYDNEY}{$DEFINE DELPHI_10RIO}{$ENDIF}
{$IFDEF DELPHI_10RIO}{$DEFINE DELPHI_10TOKYO}{$ENDIF}
{$IFDEF DELPHI_10TOKYO}{$DEFINE DELPHI_10BERLIN}{$ENDIF}
{$IFDEF DELPHI_10BERLIN}{$DEFINE DELPHI_10}{$ENDIF}
{$IFDEF DELPHI_10}  {$DEFINE DELPHI_XE8} {$ENDIF}
{$IFDEF DELPHI_XE8} {$DEFINE DELPHI_XE7} {$ENDIF}
{$IFDEF DELPHI_XE7} {$DEFINE DELPHI_XE6} {$ENDIF}
{$IFDEF DELPHI_XE6} {$DEFINE DELPHI_XE5} {$ENDIF}
{$IFDEF DELPHI_XE5} {$DEFINE DELPHI_XE4} {$ENDIF}
{$IFDEF DELPHI_XE4} {$DEFINE DELPHI_XE3} {$ENDIF}
{$IFDEF DELPHI_XE3} {$DEFINE DELPHI_XE2} {$ENDIF}
{$IFDEF DELPHI_XE2} {$DEFINE DELPHI_XE}  {$ENDIF}
{$IFDEF DELPHI_XE}  {$DEFINE D2010}      {$ENDIF}
{$IFDEF D2010}      {$DEFINE D2009}      {$ENDIF}
{$IFDEF D2009}      {$DEFINE D2007}      {$ENDIF}
{$IFDEF D2007}      {$DEFINE D2006}      {$ENDIF}
{$IFDEF D2006}      {$DEFINE D2005}      {$ENDIF}
{$IFDEF D2005}      {$DEFINE DELPHI7UP}  {$ENDIF}
{$IFDEF DELPHI7UP}  {$DEFINE DELPHI6UP}  {$ENDIF}

{$IFDEF D2005}      {$DEFINE SPLASH}     {$ENDIF}

//{$IFNDEF BCB}
//  {$DEFINE SPLASH}
//{$ENDIF}

//{$WARNINGS OFF}
//{$TYPEDADDRESS ON}

{$IFDEF DELPHI6UP}
  {$WARN UNIT_PLATFORM OFF}
  {$WARN SYMBOL_PLATFORM OFF}
  {$IFDEF DELPHI7UP}
    {$DEFINE CHECKXP}
  {$ENDIF}
{$ENDIF}

{$IFNDEF DELPHI6UP}
  {$UNDEF TNTUNICODE}
{$ENDIF}

{$IFDEF DELPHI7UP}
  {$WARN UNSAFE_CODE OFF}
  {$WARN UNSAFE_TYPE OFF}
  {$WARN UNSAFE_CAST OFF}
  {$IFDEF D2005}
    {$WARN SUSPICIOUS_TYPECAST OFF}
  {$ENDIF}
  {$IFDEF D2009}
    {$WARN IMPLICIT_STRING_CAST OFF}
    {$WARN IMPLICIT_STRING_CAST_LOSS OFF}
  {$ENDIF}
{$ENDIF}

//{$DEFINE WARN_DEPRECATED} // Notify us about deprecated functions

{$IFDEF DELPHI6UP}
  {$IFDEF WARN_DEPRECATED}
    {$WARN SYMBOL_DEPRECATED ON}
  {$ENDIF}
{$ELSE}
  {$UNDEF WARN_DEPRECATED}
{$ENDIF}

{$IFDEF D2009}
  {$DEFINE WIDETEXT}
{$ENDIF}

{$IFDEF TNTUNICODE}
  {$DEFINE WIDETEXT}
{$ENDIF}

{$IFNDEF DELPHI6UP}
  {$UNDEF ADDWEBBROWSER} // WebBrowser does not exists in D5
{$ENDIF}

{$IFDEF DELPHI6UP}
  {$H+,A8} // Not supported in the D5
{$ENDIF}

{$IFNDEF BCB}
  {$DEFINE USEFILTEDIT}
{$ELSE}
  {$IFNDEF DELPHI_XE7}
//    {$DEFINE USEFILTEDIT}
    {$IFNDEF D2005}
      {$DEFINE BCB6}
    {$ENDIF} 
  {$ENDIF}
{$ENDIF}
{$B-}

{$IFNDEF DELPHI_10}
  {$DEFINE AUTOVCL}
{$ENDIF}

//{$UNDEF USEFILTEDIT} // Uncomment this line if FiltEdit.obj is not found by compiler

{$IFDEF FPC}
  {$DEFINE WIN64}
  {$DEFINE NOMNUHOOK}
  {$DEFINE NOACPNG}
  {$mode Delphi}
{$ENDIF}

{$IFDEF DELPHI_10TOKYO}
  {$IFNDEF BCB}
    {$DEFINE FLUENTCOMP}
  {$ENDIF}
{$ENDIF}  
