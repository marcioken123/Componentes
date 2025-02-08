{ Compiler Defines used by the units. }

{$IFDEF VER130}
  {$DEFINE DELPHI5}
{$ENDIF VER130}

{$IFDEF CONDITIONALEXPRESSIONS}

  {$IF COMPILERVERSION >= 24.0}
    {$LEGACYIFEND ON}
  {$IFEND}

  {.$DEFINE TNTUnicode}

  {$IF COMPILERVERSION < 17.0}
    {$DEFINE DELPHI}
  {$IFEND}

  {$IF COMPILERVERSION >= 17.0}
    {$DEFINE UNICODE}
    {$DEFINE BDS}
    {$DEFINE INLINE}
    {$DEFINE THEMES}
    {$DEFINE DELPHI2005}
  {$IFEND}

  {$IF COMPILERVERSION >= 18.0}
    {$DEFINE FASTMM_AVAILABLE}
    {$DEFINE DELPHI2006}
  {$IFEND}

  {$IF COMPILERVERSION >= 18.5}
    {$DEFINE DELPHI2007}
  {$IFEND}

  {$IF COMPILERVERSION >= 20.0}
    {$DEFINE DELPHI2009}
    {$UNDEF UNICODE}
    {$UNDEF TNTUnicode}
  {$IFEND}

  {$IF COMPILERVERSION >= 21.0}
    {$DEFINE DELPHI2010}
  {$IFEND}

  {$IF COMPILERVERSION >= 22.0}
    {$DEFINE DELPHI2011}
    {$DEFINE DELPHIXE}
  {$IFEND}

  {$IF COMPILERVERSION >= 23.0}
    {$DEFINE DELPHIXE2}
  {$IFEND}

  {$IF COMPILERVERSION >= 24.0}
    {$DEFINE DELPHIXE3}
  {$IFEND}

  {$IF COMPILERVERSION >= 25.0}
    {$DEFINE DELPHIXE4}
  {$IFEND}

{$ELSE}
  {$DEFINE DELPHI}
  {$DEFINE DELPHI5}
{$ENDIF CONDITIONALEXPRESSIONS}

// The FORCEUNICODE define allows you to support unicode on Win9x system as long
// as the system has the unicode dll from MS installed. This is verified by checking
// for the existance of "unicows".
//
// IMPORTANT NOTE:
// In order to support the FORCEUNICODE define, you must have a WideStrings unit that
// contains implementations of TWideStringList and TWideStrings. This is a must for
// supporting this define. You will also need to recompile your packages and reinstall
// them since all string properties will be their "Wide" string version.
{.$DEFINE FORCEUNICODE}

{$IFDEF FORCEUNICODE}
  {$UNDEF UNICODE}
{$ENDIF FORCEUNICODE}

{$IFDEF DELPHI2009}
  {$UNDEF FORCEUNICODE}
{$ENDIF DELPHI2009}

{.$DEFINE TRIAL}

// Select the language you wish to use
{$DEFINE LANG_ENGLISH}
{.$DEFINE LANG_GERMAN}
{.$DEFINE LANG_CZECH}
{.$DEFINE LANG_SLOVENE}
{.$DEFINE LANG_FRENCH}
{.$DEFINE LANG_DANISH}
{.$DEFINE LANG_DUTCH}
{.$DEFINE LANG_ITALIAN}
{.$DEFINE LANG_BRAZILIANPORTUGUESE}
{.$DEFINE LANG_SVENSKA}
{.$DEFINE LANG_JAPANESE}
