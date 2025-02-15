{***********************************************************
                R&A Library
       Copyright (C) 1996-98 R&A

       description : include module for all RALib units

       programer   : black
       e-mail      : blacknbs@chat.ru
       www         : www.chat.ru\~blacknbs\ralib
************************************************************}

{ Determine compiler version }

{ Borland Delphi 2 }
{$IFDEF VER90}
  {$DEFINE RA_D}
  {$DEFINE RA_D2}
{$ENDIF}

{ Borland C++ Builder 1 }
{$IFDEF VER93}
  {$DEFINE RA_D2}
  {$DEFINE RA_B}
  {$DEFINE RA_B1}
  {$DEFINE RA_B1H} {Builder 1 or higher}
{$ENDIF}

{ Borland Delphi 3 }
{$IFDEF VER100}
  {$DEFINE RA_D}
  {$DEFINE RA_D3}
  {$DEFINE RA_D3H} {Delphi 3 or higher}
{$ENDIF}

{ Borland C++ Builder 3 }
{$IFDEF VER110}
  {$DEFINE RA_D3H} {Delphi 3 or higher}
  {$DEFINE RA_D35H} {Delphi 3.5 or higher}
  {$DEFINE RA_B}
  {$DEFINE RA_B3} {Builder 3}
  {$DEFINE RA_B1H} {Builder 1 or higher}
  {$DEFINE RA_B3H} {Builder 3 or higher}
{$ENDIF}

{ Borland Delphi 4 }
{$IFDEF VER120}
  {$DEFINE RA_D}
  {$DEFINE RA_D4}
  {$DEFINE RA_D3H} {Delphi 3 or higher}
  {$DEFINE RA_D35H} {Delphi 3.5 or higher}
  {$DEFINE RA_D4H} {Delphi 4 or higher}
  {$DEFINE RA_QR3H} {QuickReport 3 or higher}
{$ENDIF}

{ Borland C++ Builder 4 }
{$IFDEF VER125}
  {$DEFINE RA_D}
  {$DEFINE RA_D4}
  {$DEFINE RA_D3H} {Delphi 3 or higher}
  {$DEFINE RA_D35H} {Delphi 3.5 or higher}
  {$DEFINE RA_D4H} {Delphi 4 or higher}
  {$DEFINE RA_QR3H} {QuickReport 3 or higher}
{$ENDIF}
{$IFDEF VER125_}
  {$DEFINE RA_D3H} {Delphi 3 or higher}
  {$DEFINE RA_D35H} {Delphi 3.5 or higher}
  {$DEFINE RA_D4H} {Delphi 4 or higher}
  {$DEFINE RA_B}
  {$DEFINE RA_B4} {Builder 4}
  {$DEFINE RA_B1H} {Builder 1 or higher}
  {$DEFINE RA_B3H} {Builder 3 or higher}
  {$DEFINE RA_B4H} {Builder 4 or higher}
{$ENDIF}

{ Borland Delphi 5 }
{$IFDEF VER130}
  {$DEFINE RA_D}
  {$DEFINE RA_D5}
  {$DEFINE RA_D3H} {Delphi 3 or higher}
  {$DEFINE RA_D35H} {Delphi 3.5 or higher}
  {$DEFINE RA_D4H} {Delphi 4 or higher}
  {$DEFINE RA_D5H} {Delphi 5 or higher}
  {$DEFINE RA_QR3H} {QuickReport 3 or higher}
{$ENDIF}

{$IFNDEF RA_D2}
 {$IFNDEF RA_D3}
  {$IFNDEF RA_D4}
   {$IFNDEF RA_D5}
     {$IFNDEF RA_B}
      {$IFNDEF RA_B3}

        { Delphi 6 ? }
        {$DEFINE RA_D}
        {$DEFINE RA_D4}
        {$DEFINE RA_D3H} {Delphi 3 or higher}
        {$DEFINE RA_D35H} {Delphi 3.5 or higher}
        {$DEFINE RA_D4H} {Delphi 4 or higher}
        {$DEFINE RA_D5H} {Delphi 4 or higher}

      {$ENDIF}
     {$ENDIF}
   {$ENDIF}
  {$ENDIF}
 {$ENDIF}
{$ENDIF}


{$IFDEF RA_D4}
  { if you don't have installed Update pack 3 comment next line } 
  {$DEFINE RA_D43H}
{$ENDIF RA_D4}


{R&A Inter}

 {R&A Inter can compiled only under Delphi 3 and higher,
  not Builder any versions}
{$IFDEF RA_D3H}
 {$IFNDEF RA_B}
  {$DEFINE RAINTER}
 {$ENDIF RA_B}
{$ENDIF RA_D3H}

{$IFDEF RAINTER}
  // enables Ole automation support in R&A Interpreter
  {$DEFINE RAINTER_OLEAUTO}
{$ENDIF RAINTER}

// enables new property editor for integer types
{$DEFINE RAI2_INTEGERPROPERTY}
// enables dblclick feature in new property editor
{$DEFINE RAI2_INTEGERPROPERTY_DBLCLICK}

// - uncomment next line, if you have TCheckBox95 component
//{$DEFINE TCheckBox95}


   

{Compiler Options}
{$BOOLEVAL OFF}
{$EXTENDEDSYNTAX ON}
{$OPENSTRINGS ON}
{$LONGSTRINGS ON}

{$OPTIMIZATION OFF} // R&A Library was writen and debugged with this option, don't ON sucks optimization
{$RANGECHECKS ON}
{$STACKCHECKS ON}
{$IOCHECKS ON}
{$OVERFLOWCHECKS ON}
