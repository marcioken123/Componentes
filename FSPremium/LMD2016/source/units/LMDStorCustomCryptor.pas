unit LMDStorCustomCryptor;
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

LMDStorCustomCryptor unit (VO)
------------------------------


Changes
-------
Release 2.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses Classes, LMDStorBase;

type
  TLMDStorStreamCryptEvent = procedure(Sender: TObject; Stream: TMemoryStream) of object;
  {-------------------  Class TLMDStorCustomCustomCryptor ---------------------}
  TLMDStorCustomCustomCryptor = class(TLMDAbstractStorageCryptor)
  private
    FOnIntegerEncryption: TLMDStorIntegerCryptEvent;
    FOnStringEncryption: TLMDStorStringCryptEvent;
    FOnStreamEncryption: TLMDStorStreamCryptEvent;
    FOnIntegerDecryption: TLMDStorIntegerCryptEvent;
    FOnStringDecryption: TLMDStorStringCryptEvent;
    FOnStreamDecryption: TLMDStorStreamCryptEvent;
  protected
    procedure DoOnIntegerEncryption(Sender: TObject; var Value: Integer);
    procedure DoOnStringEncryption(Sender: TObject; var Value: String);
    procedure DoOnStreamEncryption(Sender: TObject; Value: TMemoryStream);
    procedure DoOnIntegerDecryption(Sender: TObject; var Value: Integer);
    procedure DoOnStringDecryption(Sender: TObject; var Value: String);
    procedure DoOnStreamDecryption(Sender: TObject; Value: TMemoryStream);
    property OnIntegerEncryption: TLMDStorIntegerCryptEvent
     read FOnIntegerEncryption write FOnIntegerEncryption;
    property OnStringEncryption: TLMDStorStringCryptEvent
     read FOnStringEncryption write FOnStringEncryption;
    property OnStreamEncryption: TLMDStorStreamCryptEvent
     read FOnStreamEncryption write FOnStreamEncryption;
    property OnIntegerDecryption: TLMDStorIntegerCryptEvent
     read FOnIntegerDecryption write FOnIntegerDecryption;
    property OnStringDecryption: TLMDStorStringCryptEvent
     read FOnStringDecryption write FOnStringDecryption;
    property OnStreamDecryption: TLMDStorStreamCryptEvent
     read FOnStreamDecryption write FOnStreamDecryption;
  public
    procedure Encrypt(Stream: TMemoryStream); override;
    procedure Decrypt(Stream: TMemoryStream); override;
    function EncryptString(Value: String): String; override;
    function DecryptString(Value: String): String; override;
    function EncryptInteger(Value: Integer): Integer; override;
    function DecryptInteger(Value: Integer): Integer; override;
  end;

  {-------------------  Class TLMDStorCustomCryptor ---------------------------}
  TLMDStorCustomCryptor = class(TLMDStorCustomCustomCryptor)
  published
    property CryptTypes;
    property OnIntegerEncryption;
    property OnStringEncryption;
    property OnStreamEncryption;
    property OnIntegerDecryption;
    property OnStringDecryption;
    property OnStreamDecryption;
  end;

implementation
{$IFDEF LMD_DEBUGTRACE}
uses
   Windows,
   dialogs;
  {$I C2.INC}
{$ENDIF}

{********************* TLMDStorCustomCustomCryptor ****************************}
{------------------------- Protected ------------------------------------------}
procedure TLMDStorCustomCustomCryptor.DoOnIntegerEncryption(Sender:
 TObject; var Value: Integer);
begin
  if Assigned(OnIntegerEncryption) then OnIntegerEncryption(Sender, Value);
end;

{------------------------------------------------------------------------------}
procedure TLMDStorCustomCustomCryptor.DoOnStringEncryption(Sender:
 TObject; var Value: String);
begin
  if Assigned(OnStringEncryption) then OnStringEncryption(Sender, Value);
end;

{------------------------------------------------------------------------------}
procedure TLMDStorCustomCustomCryptor.DoOnStreamEncryption(Sender:
 TObject; Value: TMemoryStream);
begin
  if Assigned(OnStreamEncryption) then OnStreamEncryption(Sender, Value);
end;

{------------------------------------------------------------------------------}
procedure TLMDStorCustomCustomCryptor.DoOnIntegerDecryption(Sender:
 TObject; var Value: Integer);
begin
  if Assigned(OnIntegerDecryption) then OnIntegerDecryption(Sender, Value);
end;

{------------------------------------------------------------------------------}
procedure TLMDStorCustomCustomCryptor.DoOnStringDecryption(Sender:
 TObject; var Value: String);
begin
  if Assigned(OnStringDecryption) then OnStringDecryption(Sender, Value);
end;

{------------------------------------------------------------------------------}
procedure TLMDStorCustomCustomCryptor.DoOnStreamDecryption(Sender:
 TObject; Value: TMemoryStream);
begin
  if Assigned(OnStreamDecryption) then OnStreamDecryption(Sender, Value);
end;

{------------------------- Public ---------------------------------------------}
procedure TLMDStorCustomCustomCryptor.Encrypt(Stream: TMemoryStream);
begin
  DoOnStreamEncryption(Self, Stream);
end;

{------------------------------------------------------------------------------}
procedure TLMDStorCustomCustomCryptor.Decrypt(Stream: TMemoryStream);
begin
  DoOnStreamDecryption(self, Stream);
end;

{------------------------------------------------------------------------------}
function TLMDStorCustomCustomCryptor.EncryptString(Value: String): String;
begin
  Result := Value;
  DoOnStringEncryption(self, Value);
end;

{------------------------------------------------------------------------------}
function TLMDStorCustomCustomCryptor.DecryptString(Value: String): String;
begin
  Result := Value;
  DoOnStringDecryption(self, Value);
end;

{------------------------------------------------------------------------------}
function TLMDStorCustomCustomCryptor.EncryptInteger(Value: Integer): Integer;
begin
  Result := Value;
  DoOnIntegerEncryption(self, Value);
end;

{------------------------------------------------------------------------------}
function TLMDStorCustomCustomCryptor.DecryptInteger(Value: Integer): Integer;
begin
  Result := Value;
  DoOnIntegerDecryption(self, Value);  
end;

{$IFDEF LMD_DEBUGTRACE}
initialization
  {$I C3.INC}
{$ENDIF}

end.
