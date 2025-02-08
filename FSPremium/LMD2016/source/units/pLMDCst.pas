unit pLMDCst;
{$I lmdcmps.inc}

{###############################################################################

LMD VCL Series 2016
© by LMD Innovative
-------------------

For support or information contact us at:

email              : mail@lmdsupport.com
WWW                : http://www.lmdinnovative.com
SupportSite        : http://www.lmdsupport.com
Wiki               : http://wiki.lmd.de
Fax                : ++49 6131 4984372

This code is for reference purposes only and may not be copied
or distributed in any format electronic or otherwise except one
copy for backup purposes.

No Component Kit or Component individually or in a collection,
subclassed or otherwise from the code in this unit, or associated
.pas, .dfm, .dcu, .ocx, .dll or ActiveX files may be sold or
distributed without express permission from LMD Innovative.

For further license information please refer to the associated
license html file in \info folder.

################################################################################

pLMDCst unit (RM)
-----------------

Changes
-------
Release 16.0 (October 2015)
 - Initial Release

###############################################################################}

interface
uses
  LMDStrings, LMDTypes;

const
  sLMDDesignRtlResourceName = 'pLMDEditors';
  sLMDDesignSplashResourceName = 'LMDSplash';
  sLMDSharedName = 'LMD VCL 2016';
  // new constants for BDS splash icon and about box information
  sLMDSplashIconResource = 'LMDICON';
  sLMDTargetName = '';
  sLMDPackageName = sLMDSharedName+' - Common Designtime Support';
  sLMDAboutDescription = sLMDPackageName +LMDCRLF + 'Provides common editors and '+
                         'designtime support for all '+sLMDSharedName+' packages' +LMDCRLF+
                         LMDCRLF+'(c) by LMD Innovative, Germany';

  LMDPE_DEFVISUALWIDTH=24;
  LMDPE_DEFSHAREDOPTIONS={$IFDEF LMDCOMP14}31{$ELSE}255{$ENDIF};  // From ERS 2010 do not visualize booleans etc. by default
  LMDPE_DEFLMDTOOLSOPTIONS=1; // no editor controls
  LMDTOOLS_APPNAME='lmdutil'; 

  // Registry keys
  LMDELPACK_REGISTRYPATH = LMDTOOLS_REGISTRYPATH+'\LMD ElPack';

{$IFDEF LMDCOMP22}
type
  TLMDHelpfile = (lhfTools, lhfElPack, lhfShared, lhfGrid, lhfPacks, lhfIDETools);
  TLMDHelpFileEntry = record
    FileName: string;
    Caption: string;
  end;

const
  LMDHelpFiles: array[TLMDHelpfile] of TLMDHelpFileEntry = (
    (FileName: 'lmdtools.chm'; Caption: 'LMD-Tools Help'),
    (FileName: 'lmdelpack.chm'; Caption: 'LMD ElPack Help'),
    (FileName: 'lmdshared.chm'; Caption: 'LMD Common Help'),
    (FileName: 'lmdgrid.chm'; Caption: 'LMD GridPack Help'),
    (FileName: 'lmdpacks.chm'; Caption: 'LMD Packs Help'),
    (FileName: 'lmdidetools.chm'; Caption: 'LMD IDETools Help')
  );  
{$ENDIF}
{$IFDEF VER290}
  LMDREGROOTDIR = 'Software\Embarcadero\BDS\16.0';
{$ENDIF}  
{$IFDEF VER300}
  LMDREGROOTDIR = 'Software\Embarcadero\BDS\17.0';
{$ENDIF}
{$IFDEF VER310}
  LMDREGROOTDIR = 'Software\Embarcadero\BDS\18.0';
{$ENDIF}
{$IFDEF VER320}
  LMDREGROOTDIR = 'Software\Embarcadero\BDS\19.0';
{$ENDIF}

function LMDTOOLS_COMPILERNAME:String;

implementation

{ ---------------------------------------------------------------------------- }
function LMDTOOLS_COMPILERNAME:String;
begin
  {$IFDEF VER140}result:='(Delphi/C++Builder 6.0';{$ENDIF}
  {$IFDEF VER150}result:='(Delphi 7.0';{$ENDIF}
  {$IFDEF VER170}result:='(Delphi 2005';{$ENDIF}
  {$IFDEF VER180}result:='(Delphi/C++Builder 2006';{$ENDIF}
  {$IFDEF VER185}result:='(Delphi/C++Builder 2007';{$ENDIF}
  {$IFDEF VER190}result:='(Delphi/C++Builder 2007';{$ENDIF}
  {$IFDEF VER200}result:='(Delphi/C++Builder 2009';{$ENDIF}
  {$IFDEF VER210}result:='(Delphi/C++Builder 2010';{$ENDIF}
  {$IFDEF VER220}result:='(Delphi/C++Builder XE';{$ENDIF}
  {$IFDEF VER230}result:='(Delphi/C++Builder XE2';{$ENDIF}
  {$IFDEF VER240}result:='(Delphi/C++Builder XE3';{$ENDIF}
  {$IFDEF VER250}result:='(Delphi/C++Builder XE4';{$ENDIF}
  {$IFDEF VER260}result:='(Delphi/C++Builder XE5';{$ENDIF}
  {$IFDEF VER270}result:='(Delphi/C++Builder XE6';{$ENDIF}
  {$IFDEF VER280}result:='(Delphi/C++Builder XE7';{$ENDIF}  
  {$IFDEF VER290}result:='(Delphi/C++Builder XE8';{$ENDIF}    
  {$IFDEF VER300}result:='(Delphi/C++Builder 10 Seattle';{$ENDIF} 
  {$IFDEF VER310}result:='(Delphi/C++Builder 10.1';{$ENDIF} 
  {$IFDEF VER320}result:='(Delphi/C++Builder 10.2';{$ENDIF} 

  if result = '' then result := '(Unknown';
  result := result +  ')';
  {$IFDEF LMD_DEBUGTRACE}result:=result+' - Trialversion';{$ENDIF}
end;

end.
