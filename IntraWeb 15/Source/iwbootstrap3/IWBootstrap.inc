// set de IW version
{$DEFINE IW_14_0_53_UP}
{$DEFINE IW_14_1_0_UP}
{$DEFINE IW_15}

{$DEFINE HAS_ComponentPlatformsAttribute}
// Free Pascal Compiler / Lazarus
{$IFDEF FPC}
  {$UNDEF HAS_ComponentPlatformsAttribute}
{$ENDIF}
// Delphi 2009
{$IFDEF VER200}
  {$UNDEF HAS_ComponentPlatformsAttribute}
{$ENDIF}
// Delphi 2010
{$IFDEF VER210}
  {$UNDEF HAS_ComponentPlatformsAttribute}
{$ENDIF}
//Delphi XE
{$IFDEF VER220}
  {$UNDEF HAS_ComponentPlatformsAttribute}
{$ENDIF}
