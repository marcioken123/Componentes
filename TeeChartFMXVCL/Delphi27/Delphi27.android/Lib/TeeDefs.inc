// TeeChart Pro Defines
// See modifiable User Options below ...

{$IFNDEF MSWINDOWS}
{$IFDEF WIN32}
{$DEFINE MSWINDOWS}
{$ENDIF}
{$ENDIF}

{$IFDEF ADRENOCHROME}
{$DEFINE CHROME}
{$ELSE}
{$H+}
{$ENDIF}

{.$DEFINE TEEBETA} // Enable to compile in "BETA" mode (About Box, etc)

{$IFDEF CLR}
{$DEFINE TEENOASM}   // ASM (Inline Assembler) not supported in .NET
{$DEFINE TEESAFECLR} // Force "Safe" managed code only.

{$IFNDEF CHROME}
{$FINITEFLOAT OFF}   // Turn off floating-point exceptions to speed performance
{$ENDIF}

{$ENDIF}

{$DEFINE TEEVCL}  // Internal. Do not undefine TEEVCL !

{$DEFINE TEEEDITORS}

{$IFDEF TEELITEEMB}
{$DEFINE TEELITE}  // Embarcadero version 
{$ENDIF}

{$IFDEF FPC}
{$MODE DELPHI}
{$DEFINE D7}
{$DEFINE D6}
{$DEFINE D5}
{$DEFINE D4}
{$DEFINE D3}
{$IFNDEF FMX}
{$DEFINE LCL}
{$ENDIF}
{$ENDIF}

{$IFDEF LCL}
  {$DEFINE D3}
  {$DEFINE D4}
{$ENDIF}

{$IFDEF CPUX64}
{$DEFINE TEENOASM}   // Mixed ASM (Inline Assembler) not supported in x64

{$IFNDEF FPC}
{$EXCESSPRECISION OFF}  // Disable asm x64 Single to Double intermediate values
{$ENDIF}

{$ENDIF}

{$IFDEF FPC} // XE2
{$DEFINE TEENOASM}   // No ASM (Inline Assembler) for FreePascal
{$ENDIF}

{$IFDEF IOS} // XE3.5
{$DEFINE TEENOASM}   // No ASM (Inline Assembler) in iOS
{$ENDIF}

{$IFDEF ANDROID} // XE5
{$DEFINE TEENOASM}   // No ASM (Inline Assembler) in Android
{$ENDIF}

{$IFDEF VER340}  // RAD Studio XE v13.0 (10.4) Sydney (Denali) 2020 (v 21.0) Win 32bit / Win 64bit / OSX 64bit / iOS 64 FMX / Android & C++ / Linux 64bit
  {$DEFINE D3}
  {$DEFINE D4}
  {$DEFINE D5}
  {$DEFINE D6}
  {$DEFINE D7}
  {$DEFINE D8}
  {$DEFINE D9}
  {$DEFINE D10}
  {$DEFINE D105}
  {$DEFINE D11}
  {$DEFINE D12}
  {$DEFINE D14}
  {$DEFINE D15}
  {$DEFINE D16}
  {$DEFINE D17}
  {$DEFINE D18}
  {$DEFINE D19}
  {$DEFINE D20}
  {$DEFINE D21}
  {$DEFINE D22}
  {$DEFINE D23}
  {$DEFINE D24}
  {$DEFINE D25}
  {$DEFINE D26}
  {$DEFINE D27}
{$ENDIF}

{$IFDEF VER330}  // RAD Studio XE v12.0 Rio (Carnival) 2018 (v 20.0) 32bit / 64bit / OSX / iOS 32-64 FMX / Android & C++ / Linux 64bit
  {$DEFINE D3}
  {$DEFINE D4}
  {$DEFINE D5}
  {$DEFINE D6}
  {$DEFINE D7}
  {$DEFINE D8}
  {$DEFINE D9}
  {$DEFINE D10}
  {$DEFINE D105}
  {$DEFINE D11}
  {$DEFINE D12}
  {$DEFINE D14}
  {$DEFINE D15}
  {$DEFINE D16}
  {$DEFINE D17}
  {$DEFINE D18}
  {$DEFINE D19}
  {$DEFINE D20}
  {$DEFINE D21}
  {$DEFINE D22}
  {$DEFINE D23}
  {$DEFINE D24}
  {$DEFINE D25}
  {$DEFINE D26}
{$ENDIF}

{$IFDEF VER320}  // RAD Studio XE v11.0 Tokyo (Godzilla) 2016 (v 19.0) 32bit / 64bit / OSX / iOS 32-64 FMX / Android & C++ / Linux 64bit
  {$DEFINE D3}
  {$DEFINE D4}
  {$DEFINE D5}
  {$DEFINE D6}
  {$DEFINE D7}
  {$DEFINE D8}
  {$DEFINE D9}
  {$DEFINE D10}
  {$DEFINE D105}
  {$DEFINE D11}
  {$DEFINE D12}
  {$DEFINE D14}
  {$DEFINE D15}
  {$DEFINE D16}
  {$DEFINE D17}
  {$DEFINE D18}
  {$DEFINE D19}
  {$DEFINE D20}
  {$DEFINE D21}
  {$DEFINE D22}
  {$DEFINE D23}
  {$DEFINE D24}
  {$DEFINE D25}
{$ENDIF}

{$IFDEF D25}
{$WARN EXPLICIT_STRING_CAST OFF} // W1059
{$WARN EXPLICIT_STRING_CAST_LOSS OFF} // W1060 
{$WARN LOST_EXTENDED_PRECISION OFF} // W1066 x64 only
{$WARN IMPLICIT_INTEGER_CAST_LOSS OFF} // W1071
{$WARN IMPLICIT_CONVERSION_LOSS OFF} // W1072
{$ENDIF}

{$IFDEF VER310}  // RAD Studio XE v10.1 Berlin (London BigBen) 2016 (v 18.0) 32bit / 64bit / OSX / iOS 32-64 FMX / Android & C++
  {$DEFINE D3}
  {$DEFINE D4}
  {$DEFINE D5}
  {$DEFINE D6}
  {$DEFINE D7}
  {$DEFINE D8}
  {$DEFINE D9}
  {$DEFINE D10}
  {$DEFINE D105}
  {$DEFINE D11}
  {$DEFINE D12}
  {$DEFINE D14}
  {$DEFINE D15}
  {$DEFINE D16}
  {$DEFINE D17}
  {$DEFINE D18}
  {$DEFINE D19}
  {$DEFINE D20}
  {$DEFINE D21}
  {$DEFINE D22}
  {$DEFINE D23}
  {$DEFINE D24}
{$ENDIF}

{$IFDEF VER300}  // RAD Studio XE v10 Seattle 2015 (v 17.0) 32bit / 64bit / OSX / iOS 32-64 FMX / Android & C++
  {$DEFINE D3}
  {$DEFINE D4}
  {$DEFINE D5}
  {$DEFINE D6}
  {$DEFINE D7}
  {$DEFINE D8}
  {$DEFINE D9}
  {$DEFINE D10}
  {$DEFINE D105}
  {$DEFINE D11}
  {$DEFINE D12}
  {$DEFINE D14}
  {$DEFINE D15}
  {$DEFINE D16}
  {$DEFINE D17}
  {$DEFINE D18}
  {$DEFINE D19}
  {$DEFINE D20}
  {$DEFINE D21}
  {$DEFINE D22}
  {$DEFINE D23}
{$ENDIF}

{$IFDEF VER290}  // RAD Studio XE v8 2015 (v 16.0) 32bit / 64bit / OSX / iOS 32-64 FMX / Android & C++
  {$DEFINE D3}
  {$DEFINE D4}
  {$DEFINE D5}
  {$DEFINE D6}
  {$DEFINE D7}
  {$DEFINE D8}
  {$DEFINE D9}
  {$DEFINE D10}
  {$DEFINE D105}
  {$DEFINE D11}
  {$DEFINE D12}
  {$DEFINE D14}
  {$DEFINE D15}
  {$DEFINE D16}
  {$DEFINE D17}
  {$DEFINE D18}
  {$DEFINE D19}
  {$DEFINE D20}
  {$DEFINE D21}
  {$DEFINE D22}
{$ENDIF}

{$IFDEF VER280}  // RAD Studio XE v7 2014 (v 15.0) 32bit / 64bit / OSX / iOS FMX / Android & C++
  {$DEFINE D3}
  {$DEFINE D4}
  {$DEFINE D5}
  {$DEFINE D6}
  {$DEFINE D7}
  {$DEFINE D8}
  {$DEFINE D9}
  {$DEFINE D10}
  {$DEFINE D105}
  {$DEFINE D11}
  {$DEFINE D12}
  {$DEFINE D14}
  {$DEFINE D15}
  {$DEFINE D16}
  {$DEFINE D17}
  {$DEFINE D18}
  {$DEFINE D19}
  {$DEFINE D20}
  {$DEFINE D21}
{$ENDIF}

{$IFDEF VER270}  // RAD Studio XE v6 2014 (v 14.0) 32bit / 64bit / OSX / iOS FMX / Android C++
  {$DEFINE D3}
  {$DEFINE D4}
  {$DEFINE D5}
  {$DEFINE D6}
  {$DEFINE D7}
  {$DEFINE D8}
  {$DEFINE D9}
  {$DEFINE D10}
  {$DEFINE D105}
  {$DEFINE D11}
  {$DEFINE D12}
  {$DEFINE D14}
  {$DEFINE D15}
  {$DEFINE D16}
  {$DEFINE D17}
  {$DEFINE D18}
  {$DEFINE D19}
  {$DEFINE D20}
  {$DEFINE UPTOXE7}
{$ENDIF}

{$IFDEF VER260}  // RAD Studio XE v5 2013 (v 12.0) 32bit / 64bit / OSX / iOS FMX / Android
  {$DEFINE D3}
  {$DEFINE D4}
  {$DEFINE D5}
  {$DEFINE D6}
  {$DEFINE D7}
  {$DEFINE D8}
  {$DEFINE D9}
  {$DEFINE D10}
  {$DEFINE D105}
  {$DEFINE D11}
  {$DEFINE D12}
  {$DEFINE D14}
  {$DEFINE D15}
  {$DEFINE D16}
  {$DEFINE D17}
  {$DEFINE D18}
  {$DEFINE D19}
  {$DEFINE UPTOXE7}
{$ENDIF}

{$IFDEF VER250}  // RAD Studio XE v4 2013 (v 11.0) 32bit / 64bit / OSX / iOS FMX
  {$DEFINE D3}
  {$DEFINE D4}
  {$DEFINE D5}
  {$DEFINE D6}
  {$DEFINE D7}
  {$DEFINE D8}
  {$DEFINE D9}
  {$DEFINE D10}
  {$DEFINE D105}
  {$DEFINE D11}
  {$DEFINE D12}
  {$DEFINE D14}
  {$DEFINE D15}
  {$DEFINE D16}
  {$DEFINE D17}
  {$DEFINE D18}
  {$DEFINE UPTOXE7}
{$ENDIF}

{$IFDEF VER240}  // RAD Studio XE v3 2012 (v 10.0) 32bit / 64bit / OSX
  {$DEFINE D3}
  {$DEFINE D4}
  {$DEFINE D5}
  {$DEFINE D6}
  {$DEFINE D7}
  {$DEFINE D8}
  {$DEFINE D9}
  {$DEFINE D10}
  {$DEFINE D105}
  {$DEFINE D11}
  {$DEFINE D12}
  {$DEFINE D14}
  {$DEFINE D15}
  {$DEFINE D16}
  {$DEFINE D17}
  {$DEFINE UPTOXE3}
  {$DEFINE UPTOXE7}
{$ENDIF}

{$IFDEF VER230}  // RAD Studio XE v2 2011 (v 9.0) 32bit / 64bit / OSX / iOS FMI
  {$DEFINE D3}
  {$DEFINE D4}
  {$DEFINE D5}
  {$DEFINE D6}
  {$DEFINE D7}
  {$DEFINE D8}
  {$DEFINE D9}
  {$DEFINE D10}
  {$DEFINE D105}
  {$DEFINE D11}
  {$DEFINE D12}
  {$DEFINE D14}
  {$DEFINE D15}
  {$DEFINE D16}
  {$DEFINE UPTOXE3}
  {$DEFINE UPTOXE7}
{$ENDIF}

{$IFDEF VER220}  // RAD Studio XE 2011 (v 8.0)
  {$DEFINE D3}
  {$DEFINE D4}
  {$DEFINE D5}
  {$DEFINE D6}
  {$DEFINE D7}
  {$DEFINE D8}
  {$DEFINE D9}
  {$DEFINE D10}
  {$DEFINE D105}
  {$DEFINE D11}
  {$DEFINE D12}
  {$DEFINE D14}
  {$DEFINE D15}
{$ENDIF}

{$IFDEF VER210}
  {$DEFINE D3}
  {$DEFINE D4}
  {$DEFINE D5}
  {$DEFINE D6}
  {$DEFINE D7}
  {$DEFINE D8}
  {$DEFINE D9}
  {$DEFINE D10}
  {$DEFINE D105}
  {$DEFINE D11}
  {$DEFINE D12}
  {$DEFINE D14}
{$ENDIF}

{$IFDEF VER200}
  {$DEFINE D3}
  {$DEFINE D4}
  {$DEFINE D5}
  {$DEFINE D6}
  {$DEFINE D7}
  {$DEFINE D8}
  {$DEFINE D9}
  {$DEFINE D10}
  {$DEFINE D105}
  {$DEFINE D11}
  {$DEFINE D12}
{$ENDIF}

{$IFDEF VER190}
  {$DEFINE D3}
  {$DEFINE D4}
  {$DEFINE D5}
  {$DEFINE D6}
  {$DEFINE D7}
  {$DEFINE D8}
  {$DEFINE D9}
  {$DEFINE D10}
  {$DEFINE D105}
  {$DEFINE D11}
{$ENDIF}

{$IFDEF VER185}
  {$DEFINE D3}
  {$DEFINE D4}
  {$DEFINE D5}
  {$DEFINE D6}
  {$DEFINE D7}
  {$DEFINE D8}
  {$DEFINE D9}
  {$DEFINE D10}
  {$DEFINE D105}
{$ENDIF}

{$IFDEF VER180}
  {$DEFINE D3}
  {$DEFINE D4}
  {$DEFINE D5}
  {$DEFINE D6}
  {$DEFINE D7}
  {$DEFINE D8}
  {$DEFINE D9}
  {$DEFINE D10}
{$ENDIF}

{$IFDEF VER170}
  {$DEFINE D3}
  {$DEFINE D4}
  {$DEFINE D5}
  {$DEFINE D6}
  {$DEFINE D7}
  {$DEFINE D8}
  {$DEFINE D9}
{$ENDIF}

{$IFDEF VER160}
  {$DEFINE D3}
  {$DEFINE D4}
  {$DEFINE D5}
  {$DEFINE D6}
  {$DEFINE D7}
  {$DEFINE D8}
{$ENDIF}

{$IFDEF VER150}
  {$DEFINE D3}
  {$DEFINE D4}
  {$DEFINE D5}
  {$DEFINE D6}
  {$DEFINE D7}
  {$IFDEF BCB}
    {$DEFINE C5}
    {$DEFINE C6}
  {$ENDIF}
{$ENDIF}

{$IFDEF VER145}
  {$DEFINE D3}
  {$DEFINE D4}
  {$DEFINE D5}
  {$DEFINE D6}
  {$IFDEF BCB}
    {$DEFINE C5}
    {$DEFINE C6}
  {$ENDIF}
  {$DEFINE K3}
{$ENDIF}

{$IFDEF VER140}
  {$DEFINE D3}
  {$DEFINE D4}
  {$DEFINE D5}
  {$DEFINE D6}
  {$IFDEF BCB}
    {$DEFINE C5}
    {$DEFINE C6}
  {$ENDIF}  
{$ENDIF}

{$IFDEF VER130}
  {$DEFINE D3}
  {$DEFINE D4}
  {$DEFINE D5}
  {$DEFINE C4}
  {$DEFINE C5}
{$ENDIF}

{$IFDEF VER125}
  {$DEFINE D3}
  {$DEFINE D4}
  {$DEFINE C3D4}
  {$DEFINE C4}
  {$DEFINE BCB}
{$ENDIF}

{$IFDEF VER120}
  {$DEFINE D3}
  {$DEFINE D4}
  {$DEFINE C3D4}
{$ENDIF}

{$IFDEF VER110}
  {$DEFINE D3}
  {$IFDEF BCB}
    {$DEFINE C3}
    {$DEFINE C3D4}
  {$ELSE}
    {$DEFINE D4}
    {$DEFINE C3D4}
  {$ENDIF}
{$ENDIF}

{$IFDEF DECLARE_GPL}
{$DEFINE KYLIXOPEN}
{$ENDIF}

{$IFDEF BCB}
{$ObjExportAll On}
{$ENDIF}

{$IFDEF VER110}
  'Error: This TeeChart version does not support Delphi 4. Please use TeeChart version 7.'
{$ENDIF}

{$IFDEF VER100}
  'Error: This TeeChart version does not support Delphi 3. Please use TeeChart version 5.'
{$ENDIF}

{$IFDEF VER80}
  'Error: This TeeChart version does not support Delphi 1 and 2. Please use TeeChart version 4.'
{$ENDIF}

{$IFDEF UCL}
{$DEFINE CLX}
{$ENDIF}

{$IFDEF LINUX}
{$IFDEF FPC}
{$DEFINE FPCLINUX}
{$ELSE}
{$DEFINE CLX}
{$DEFINE FMXLINUX}
{$ENDIF}
{$ENDIF}

{$IFDEF D6}
{$DEFINE D6DESIGNER}
{$ELSE}
{$IFDEF CLX}
{$DEFINE D6DESIGNER}
{$ENDIF}
{$ENDIF}

{$IFDEF D7}
{$IFNDEF K3}
{$IFNDEF FPC}
  {$WARN UNSAFE_TYPE OFF}
  {$WARN UNSAFE_CODE OFF}
  {$WARN UNSAFE_CAST OFF}
{$ENDIF}
{$ENDIF}
{$ENDIF}

{$IFDEF D6} 
{$WARN UNIT_PLATFORM OFF}   // Hide unit platform warnings
{$WARN SYMBOL_PLATFORM OFF} // Hide symbol platform warnings (streaming read/write)
{$ENDIF}

// User Options
// =====================

{$IFDEF CHROME}
{$UNDEF D9}
{$ENDIF}

{$IFDEF D9}
{$INLINE ON}  // Enable or disable inlining in Delphi 9
{$ENDIF}

{$IFDEF CPUX64}
{$DEFINE NOUSE_BDE}  // BDE is not available in 64bit platform
{$ENDIF}

{$IFDEF D21}
{$DEFINE NOUSE_BDE}  // BDE is not available in XE7 and up (Win32 & Win64)
{$ENDIF}

{$IFDEF NOTEEDB}
{$DEFINE NOUSE_BDE}  // BDE is not available in all ides "Starter" or "Personal" editions
{$ENDIF}

{.$DEFINE NOUSE_BDE}      // <-- remove the "." to avoid using the BDE (in QRChart, etc)
{.$DEFINE TEEMULTIPLIER}  // <-- remove the "." to enable obsolete "Multiplier" property,                           //     (slower performance)

{$IFDEF D5}
{.$DEFINE TEEENTERPRISE}  // <-- remove the "." to add ADO support in TeeChart Wizard
{$ENDIF}

{$IFDEF D4}

// TList     = less speed modifying values, more speed deleting values, much MORE memory
// Dyn Array = Direct access to values, more speed modifying values, much LESS memory,
//             less speed deleting values. Not for Delphi 3.

{$DEFINE TEEARRAY}  // <-- put a "." in front to use TList instead of Dynamic Arrays

{$ENDIF}

{$IFNDEF TEEVALUESINGLE}
{$IFNDEF TEEVALUEEXTENDED}

// "Value" type for point values data.
// Remove the "." on ONLY one of the items below:

{$DEFINE TEEVALUEDOUBLE}
{.$DEFINE TEEVALUESINGLE}
{.$DEFINE TEEVALUEEXTENDED}

{$ENDIF}
{$ENDIF}

// Unicode support from D6 and up,
// but not for BCB6 due to overload ambiguity. Not for CLX.
{$IFDEF BCB}
 {$IFDEF D10}
   {$DEFINE TEEUNICODE}
 {$ENDIF}
{$ELSE}
 {$IFNDEF CLR}
  {$IFDEF D6}
   {$DEFINE TEEUNICODE}
  {$ENDIF}
 {$ENDIF}
{$ENDIF}

{$IFNDEF FMX}
{$IFNDEF TEELITE}
{$DEFINE TEEEXCEPTIONS}  // Send design-time exceptions to steema.com
{$ENDIF}

{$IFDEF MSWINDOWS}
{$DEFINE USEWINDOWS}
{$ENDIF}

{$IFDEF OSX}
{$DEFINE USEWINDOWS} // CrossVCL.com
{$ENDIF}

{$ENDIF}

{$IFDEF D18}
{$IFDEF IOS}
{$DEFINE TEELISTMETA} // QC115377
{$ENDIF}
{$IFDEF ANDROID}
{$DEFINE TEELISTMETA} // QC115377
{$DEFINE TEENOPRINT}
{$ENDIF}
{$IFDEF LINUX}
{$DEFINE TEELISTMETA} // QC115377
{$ENDIF}
{$ENDIF}

