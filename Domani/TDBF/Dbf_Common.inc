// define this if you need more SPEEEEEDDDD!!!
// useful if you index dbf files over a network

{.$define USE_CACHE}

// enables assembler routines, 486+ only

{$define USE_ASSEMBLER_486_UP}

// test compatibility

{.$define TDBF_UPDATE_FIRSTLAST_NODE}

// use this to enable the lookup function which is still buggy

{.$define USE_BUGGY_LOOKUP}

// use this directive to suppress math exceptions,
// instead NAN is returned.
// Using this directive is slightly less efficient
//
// used in Dbf_PrsDef
//
// NAN support needs to be rewritten and is currently absent

{.$define NAN}

//--- Define a few directive to ease the compatibility ---

{$define SUPPORT_DEFAULT_PARAMS}
{$define SUPPORT_VARIANTS}
{$define SUPPORT_NEW_TRANSLATE}

// FreePascal general
{$ifdef FPC_VERSION}

  {$mode delphi}
  {$h+}
  {$asmmode intel}

  {$define DELPHI_3}
  {$define DELPHI_4}
  {$define DELPHI_5}

  // FPC 1.9 does not completely support variants too
  {$undef SUPPORT_VARIANTS}

  // FPC 1.0.x exceptions: no 0/0 support
  {$ifdef VER1_0}
    {$undef NAN}
    {$undef SUPPORT_DEFAULT_PARAMS}
    {$undef SUPPORT_NEW_TRANSLATE}

    #ERROR TDbf needs fpc 1.9 minimum.

  {$endif}

{$endif}

{$ifdef VER80}          //	Delphi 1.0
  #ERROR tDbf needs Delphi or C++ Builder 3 minimum.
{$endif}

{$ifdef VER90}          //	 Delphi 2.0
  #ERROR tDbf needs Delphi or C++ Builder 3 minimum.
{$endif}

{$ifdef VER93}          //	 is BCB++ 1.0
  #ERROR tDbf needs Delphi or C++ Builder 3 minimum.
{$endif}

{$ifdef VER100}         // Delphi 3
  {$define DELPHI_3}
  {$undef SUPPORT_NEW_TRANSLATE}
{$endif}

{$ifdef VER110}      // CBuilder 3
  {$define DELPHI_3}
  {$undef SUPPORT_NEW_TRANSLATE}
{$endif}

{$ifdef VER120}      // Delphi 4
  {$define DELPHI_4}
  {$define DELPHI_3}
{$endif}

{$ifdef VER125} // C++ BUILDER 4
  {$define DELPHI_4}
  {$define DELPHI_3}
{$endif}

{$ifdef VER130} // Delphi 5
  {$define DELPHI_5}
  {$define DELPHI_4}
  {$define DELPHI_3}
{$endif}

{$ifdef VER135} // C++ Builder 5 ??
  {$define DELPHI_5}
  {$define DELPHI_4}
  {$define DELPHI_3}
{$endif}

{$ifdef VER140} // Delphi 6
  {$define DELPHI_6}
  {$define DELPHI_5}
  {$define DELPHI_4}
  {$define DELPHI_3}
{$endif}

{$ifdef VER145} // C++ Builder 6
  {$define DELPHI_6}
  {$define DELPHI_5}
  {$define DELPHI_4}
  {$define DELPHI_3}
{$endif}

{$ifdef VER150} // Delphi 7 :-) For once I am not late (12/07/2001)
  {$define DELPHI_7}
  {$define DELPHI_6}
  {$define DELPHI_5}
  {$define DELPHI_4}
  {$define DELPHI_3}
{$endif}

{$ifdef VER155} // C++ Builder 7
  {$define DELPHI_7}
  {$define DELPHI_6}
  {$define DELPHI_5}
  {$define DELPHI_4}
  {$define DELPHI_3}
{$endif}

{$ifndef DELPHI_4}
  {$undef SUPPORT_DEFAULT_PARAMS}
{$endif}
