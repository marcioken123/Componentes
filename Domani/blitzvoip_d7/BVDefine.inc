{$S- No stack overflow checking}
{$R- No range checking}
{$B- Incomplete boolean evaluation}
{$P- No open string parameters}
{$Q- No arithmetic overflow checking}
{$T- No type-checked pointers}
{$V- No var string checking}
{$X+ Extended syntax}
{$Z- Enumeration size is 256}

{$IFDEF Win32}    { not available in D1 for the 16-bit fax printer driver }
  {$H+ Long string support}
  {$J+ Writeable typed constants}
  {$IFOPT H+}
    {$DEFINE HugeStr}
  {$ENDIF}
{$ENDIF}

{.$DEFINE TapiDebug}                      { creates detailed TAPI debug log }
{.$DEFINE BVModemDebug}                   { adds debug info to dispatcher log }

{$IFDEF Win32}
  {$IFNDEF VER100}
    { Delphi 3 generates internal error L1086 when the resourcestring is used}
    {$DEFINE UseResourceStrings}     { disable for the String Resource Manager }
  {$ENDIF}
{$ENDIF}


{$IFDEF VER80}                {Delphi 1.0}
  {$IFNDEF PRNDRV}
  !! Error: BV is a 32-bit library
  {$ENDIF}
{$ENDIF}

{$IFDEF VER90}                {Delphi 2.0}
  !! Error: BV is compatible with Delphi 3 and above
{$ENDIF}

{$IFDEF VER93}                {C++ Builder 1.0}
  !! Error: BV is compatible with C++ Builder 3 and above
{$ENDIF}


{$IFDEF VER100}                {Delphi 3.0}
  {$DEFINE BVDelphi}
{$ENDIF}

{$IFDEF VER120}                {Delphi 4.0}
  {$DEFINE BVDelphi}
{$ENDIF}

{$IFDEF VER130}
  {$IFNDEF BCB}
   {$DEFINE BVDelphi}        {Delphi 5.0}
  {$ENDIF}
{$ENDIF}

{$IFDEF Ver140}
  {$IFNDEF BCB}
    {$DEFINE BVDelphi}       {Delphi 6.0}
  {$ENDIF}
{$ENDIF}

{$IFNDEF VER80}
 {$IFNDEF VER90}
  {$IFNDEF VER93}
    {$DEFINE Delphi3}         {Delphi 3.0 or higher}
    {$DEFINE VERSION3}        {Delphi 3.0^ or BCB 3.0^}
  {$ENDIF}
 {$ENDIF}
{$ENDIF}

{$IFDEF Delphi3}
  {$IFNDEF VER100}
    {$IFNDEF Ver110}
      {$DEFINE Delphi4}       {Delphi 4.0 or higher}
      {$DEFINE VERSION4}
    {$ENDIF}
  {$ENDIF}
{$ENDIF}

{$IFDEF Delphi4}
  {$IFNDEF VER120}
    {$IFNDEF Ver125}
      {$DEFINE Delphi5}       {Delphi 5.0 or higher}
      {$DEFINE VERSION5}
    {$ENDIF}
  {$ENDIF}
{$ENDIF}

{$IFDEF Delphi5}
  {$IFNDEF VER130}
      {$DEFINE Delphi6}       {Delphi 6.0 or higher}
      {$DEFINE VERSION6}
  {$ENDIF}
{$ENDIF}

{$IFDEF Delphi6}
  {$IFNDEF VER140}
      {$DEFINE Delphi7}       {Delphi 7.0 (VER150) or higher}
      {$DEFINE VERSION7}
  {$ENDIF}
{$ENDIF}

{$IFDEF VER110}               {C++ Builder 3.0}
  {$ObjExportAll On}
  {$DEFINE BVBCB}
{$ENDIF}

{$IFDEF VER125}               {C++ Builder 4.0}
  {$ObjExportAll On}
  {$DEFINE BVBCB}
{$ENDIF}

{$IFDEF Ver130}               {C++ Builder 5.0}
  {$IFDEF BCB}
    {$ObjExportAll On}
    {$DEFINE BVBCB}
  {$ENDIF}
{$ENDIF}

{$IFDEF Ver140}               {C++ Builder 6.0}
  {$IFDEF BCB}
    {$ObjExportAll On}
    {$DEFINE BVBCB}
  {$ENDIF}
{$ENDIF}

{ BV supports D3/BCB3 and above, and is a strictly Win32 library }
{ turn off the following warnings }
{$IFDEF Delphi6}
  {$WARN SYMBOL_PLATFORM OFF}
  {$WARN UNIT_PLATFORM OFF}
  {$WARN SYMBOL_DEPRECATED OFF}
{$ENDIF}
{$IFDEF Delphi7}
    {$WARN UNSAFE_CODE OFF}
    {$WARN UNSAFE_TYPE OFF}
    {$WARN UNSAFE_CAST OFF}
{$ENDIF}
