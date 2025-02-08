unit LMDStorBinVault;
{$I LMDCmps.inc}

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

LMDStorBinVault unit (VO)
-------------------------


Changes
-------
Release 2.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses Classes, SysUtils, Graphics, Windows, Types,
     LMDStorXMLVault;

type
  {-------------------- Class TLMDStorCustomBinVault --------------------------}
  TLMDStorCustomBinVault = class(TLMDStorCustomXMLVault)
  private
  protected
    function Extension: String; override;
  public
    constructor Create(AOwner: TComponent); override;
  end;

  {-------------------- Class TLMDStorBinVault --------------------------------}
  TLMDStorBinVault = class(TLMDStorCustomBinVault)
  published
    property FileName;
    property FilePrefix;
    property AppDataPath;
    property AppDataCommon;
    property Encrypted;        
    property OnBeforeOpen;
    property OnAfterOpen;
    property OnBeforeClose;
    property OnAfterClose;
    property OnSectionAdd;
    property OnSectionDelete;
    property OnLoadStream;
    property OnSaveStream;
    property OnBeforeEncryption;
    property OnAfterEncryption;
    property OnBeforeDecryption;
    property OnAfterDecryption;
    property OnBeforeStringEncryption;
    property OnAfterStringEncryption;
    property OnBeforeStringDecryption;
    property OnAfterStringDecryption;
    property OnBeforeIntegerEncryption;
    property OnAfterIntegerEncryption;
    property OnBeforeIntegerDecryption;
    property OnAfterIntegerDecryption;
    property OnCustomRootRead;
    property OnCustomRootWrite;    
    property StorageCryptor;
    property Sections;
    property ActiveSection;
    property ActiveSectionIndex;
  end;

implementation
{$IFDEF LMD_DEBUGTRACE}
uses
   dialogs;
  {$I C2.INC}
{$ENDIF}

{********************* TLMDStorCustomBinVault *********************************}
{------------------------- Private --------------------------------------------}
{------------------------- Protected ------------------------------------------}
function TLMDStorCustomBinVault.Extension: String;
begin
  Result := 'dat';
end;

{------------------------- Public----------------------------------------------}
constructor TLMDStorCustomBINVault.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  BinaryState := True;
end;

{$IFDEF LMD_DEBUGTRACE}
initialization
  {$I C1.INC}
{$ENDIF}

end.
