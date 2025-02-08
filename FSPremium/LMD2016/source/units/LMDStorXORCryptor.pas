unit LMDStorXORCryptor;
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

LMDStorXORCryptor unit (VO)
---------------------------

Changes
-------
Release 2.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses Classes, LMDStorBase;

type
  {-------------------  Class TLMDStorCustomXORCryptor ------------------------}
  TLMDStorCustomXORCryptor = class(TLMDAbstractStorageCryptor)
  private
    FMask: Byte;
    procedure SetMask(const Value: Byte);
  protected
    property Mask: Byte read FMask write SetMask default 0;
  public
    procedure Encrypt(Stream: TMemoryStream); override;
    procedure Decrypt(Stream: TMemoryStream); override;
    function EncryptString(Value: String): String; override;
    function DecryptString(Value: String): String; override;
    function EncryptInteger(Value: Integer): Integer; override;
    function DecryptInteger(Value: Integer): Integer; override;
  end;

  {-------------------  Class TLMDStorXORCryptor ------------------------------}
  TLMDStorXORCryptor = class(TLMDStorCustomXORCryptor)
  published
    property Mask;
    property CryptTypes;
  end;

implementation

{********************* TLMDStorCustomXORCryptor *******************************}
{------------------------- Private --------------------------------------------}
procedure TLMDStorCustomXORCryptor.SetMask(const Value: Byte);
begin
  FMask := Value;
end;

{------------------------------------------------------------------------------}
procedure TLMDStorCustomXORCryptor.Encrypt(Stream: TMemoryStream);
var
  p: Pointer;
  i: Integer;
begin
  if not Assigned(Stream) or (Stream.Size = 0) then exit;
  Stream.Seek(0, soFromBeginning);

  p := GetMemory(Stream.Size);
  try
    Stream.Read(PAnsiChar(p)[1], Stream.Size);
    for i := 0 to Stream.Size - 1 do
      Byte(PAnsiChar(p)[i]) := Byte(PAnsiChar(p)[i]) xor FMask;
    Stream.Seek(0, soFromBeginning);
    Stream.Write(PAnsiChar(p)[1], Stream.Size);
  finally
    FreeMemory(p);
  end;

end;

{------------------------------------------------------------------------------}
procedure TLMDStorCustomXORCryptor.Decrypt(Stream: TMemoryStream);
begin
  Encrypt(Stream);
end;

{------------------------------------------------------------------------------}
function TLMDStorCustomXORCryptor.EncryptString(Value: String): String;
var
  i: integer;
begin
  SetLength(Result, length(Value));
  for I := 1 to Length(Value) do
     Result[I] := char(byte(Value[I]) xor FMask);
end;

{------------------------------------------------------------------------------}
function TLMDStorCustomXORCryptor.DecryptString(Value: String): String;
begin
  Result := EncryptString(Value);
end;

{------------------------------------------------------------------------------}
function TLMDStorCustomXORCryptor.EncryptInteger(Value: Integer): Integer;
begin
  Result := Value xor FMask;
end;

{------------------------------------------------------------------------------}
function TLMDStorCustomXORCryptor.DecryptInteger(Value: Integer): Integer;
begin
  Result := EncryptInteger(Value);
end;

end.
