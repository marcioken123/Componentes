unit LMDShExceptions;
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

LMDShExceptions unit (DS)
------------------------
Exception classes


Changes
-------
Release 4.0 (September 2006)
 - Initial Release

###############################################################################}

interface

uses
  SysUtils;

type
  {****************************************************************************}
  ELMDException = class(Exception)
    protected
      FErrorCode : Longint;
    public
      constructor CreateRes(aIdent : LongInt; aDummy : Word); overload; virtual;
      constructor Create(const Str: string); overload; virtual;
      constructor CreateResFmt(aIdent : Longint; const aArgs : array of const; aDummy : Word); overload; virtual;
      property ErrorCode : LongInt read FErrorCode write FErrorCode;
  end;

  ELMDExceptionClass = class of ELMDException;
  ELMDInvalidFolder = class(ELMDException);

procedure LMDRaiseError(aExceptionClass : ELMDExceptionClass; aCode : LongInt);
procedure LMDRaiseWin32Error(aExceptionClass : ELMDExceptionClass; aCode : LongInt);
procedure LMDRaiseWin32ErrorEx(aExceptionClass : ELMDExceptionClass; aCode : LongInt; const aInfo : string);

implementation

uses
  LMDShMisc, LMDShConsts;

{******************************************************************************}
procedure LMDRaiseError(aExceptionClass : ELMDExceptionClass; aCode : LongInt);
var
  E : ELMDException;
begin
  E := aExceptionClass.CreateRes(aCode, 0);
  E.ErrorCode := aCode;
  raise E;
end;

{------------------------------------------------------------------------------}
procedure LMDRaiseWin32Error(aExceptionClass : ELMDExceptionClass; aCode : LongInt);
var
  E : ELMDException;
begin
  E := aExceptionClass.Create(SysErrorMessage(aCode));
  E.ErrorCode := aCode;
  raise E;
end;

{------------------------------------------------------------------------------}
procedure LMDRaiseWin32ErrorEx(aExceptionClass : ELMDExceptionClass; aCode : LongInt;
              const aInfo : string);
var
  E : ELMDException;
begin
  E := aExceptionClass.Create(SysErrorMessage(aCode) + ' [' + aInfo + ']');
  E.ErrorCode := aCode;
  raise E;
end;

{** ELMDException *************************************************************}
{-- private -------------------------------------------------------------------}
{-- protected -----------------------------------------------------------------}
{-- public --------------------------------------------------------------------}
constructor ELMDException.CreateRes(aIdent : LongInt; aDummy : Word);
begin
  inherited Create(LMDConstToStr(aIdent));
end;

{------------------------------------------------------------------------------}
constructor ELMDException.CreateResFmt(aIdent : Longint; const aArgs : array of const; aDummy : Word);
begin
//  inherited CreateFmt(LMDConstToStr(aIdent), aArgs);
  inherited Create(Format(LMDConstToStr(aIdent), aArgs));
end;

{------------------------------------------------------------------------------}
constructor ELMDException.Create(const Str: string);
begin
  inherited Create(Str);
end;

end.
