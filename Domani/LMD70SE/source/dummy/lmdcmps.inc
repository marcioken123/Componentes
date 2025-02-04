{LMD-TOOLS V6.X - © 2002 by LMD Innovative}
{******************************************************************************}
{$DEFINE LMDTOOLS60}
{.$DEFINE LMDDEBUG}    {remove . if you need Debug-Information...}

{***************** TLMDObjectStorage, activate ZLib support *******************}
{.$DEFINE ZLIB}    // Remove point to activate compression support

{***************** Include Symbol and Debug-Information? **********************}
{$IFDEF LMDDEBUG}
  {$HINTS ON; WARNINGS ON}
  {$D+,L+,Y+}
{$ELSE}
  {$D-,L-,Y-,O+}
  {$HINTS OFF; WARNINGS OFF}
{$ENDIF}

{*********************** Include Compiler Check *******************************}
{$I lmdcmpV.inc}

{************************ Internal settings ***********************************}
//these flags are needed internally for special debugging purposes
{.$DEFINE LMDDEBUGTRACE}

//these flags are needed internally for creating special releases
{.$DEFINE TRIAL}
{$DEFINE LMDTOOLS_SPECIALEDITION}

{***************** These compiler settings shouldn't be changed ***************}
{$B-,X+,P+,R-,Q-,H+,W-,J-,A+,T-,S+,V-,W-}

