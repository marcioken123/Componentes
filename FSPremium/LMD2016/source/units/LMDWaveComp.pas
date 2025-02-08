unit LMDWaveComp;
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

LMDWaveComp unit ()
-------------------

Changes
-------
Release 8.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Classes,
  LMDWave, LMDCustomComponent;

type
  (*$HPPEMIT 'namespace Lmdwavecomp' *)
  (*$HPPEMIT '{' *)
  (*$HPPEMIT '//-- type declarations -------------------------------------------------------' *)
  (*$HPPEMIT 'class DELPHICLASS TLMDCustomWaveComp;' *)
  (*$HPPEMIT 'class PASCALIMPLEMENTATION TLMDCustomWaveComp : public Lmdcustomcomponent::TLMDCustomComponent ' *)
  (*$HPPEMIT '{' *)
  (*$HPPEMIT '	typedef Lmdcustomcomponent::TLMDCustomComponent inherited;' *)
  (*$HPPEMIT 'protected:' *)
  (*$HPPEMIT '	virtual bool __fastcall PlaySoundExt(Lmdwave::TLMDSndPlayMode aValue) = 0 ;' *)
  (*$HPPEMIT 'public:' *)
  (*$HPPEMIT '	bool __fastcall PlaySound(Lmdwave::TLMDSndPlayMode aValue);' *)
  (*$HPPEMIT 'public:' *)
  (*$HPPEMIT '	#pragma option push -w-inl' *)
  (*$HPPEMIT '	/* TLMDCustomComponent.Create */ inline __fastcall virtual TLMDCustomWaveComp(Classes::TComponent* ' *)
  (*$HPPEMIT '		AOwner) : Lmdcustomcomponent::TLMDCustomComponent(AOwner) { }' *)
  (*$HPPEMIT '	#pragma option pop' *)
  (*$HPPEMIT 'public:' *)
  (*$HPPEMIT '	#pragma option push -w-inl' *)
  (*$HPPEMIT '	/* TComponent.Destroy */ inline __fastcall virtual ~TLMDCustomWaveComp(void) { }' *)
  (*$HPPEMIT '	#pragma option pop' *)
  (*$HPPEMIT '	' *)
  (*$HPPEMIT '};' *)
  (*$HPPEMIT '};' *)

  {$EXTERNALSYM TLMDCustomWaveComp}
  {------------------- Object TLMDCustomWave ----------------------------------}
  TLMDCustomWaveComp = class(TLMDCustomComponent)
  public
    function  PlaySoundExt(aValue:TLMDSndPlayMode):Boolean;virtual;abstract;
    function  PlaySound(aValue:TLMDSndPlayMode):Boolean;
  end;

  {------------------------ Class TLMDWaveComp --------------------------------}
  TLMDWaveComp = class(TLMDCustomWaveComp)
  private
    FWave : TLMDWave;
    procedure SetWave(aValue:TLMDWave);
  public
    constructor Create(AOwner:TComponent);override;
    destructor Destroy;override;
    procedure LoadFromFile(const Filename: string);virtual;
    procedure SaveToFile(const FileName: String);virtual;
    function  Play:Boolean;
    function  PlaySoundExt(aValue:TLMDSndPlayMode):Boolean;override;
    procedure Stop;
  published
    property About;
    property Wave:TLMDWave read FWave write SetWave;
  end;


implementation

{**************** Object TLMDCustomWaveComp ***********************************}
{------------------------------------------------------------------------------}
function TLMDCustomWaveComp.PlaySound(aValue:TLMDSndPlayMode):Boolean;
begin
  result:=PlaySoundExt(aValue);
end;

{******************* Object TLMDWaveComp **************************************}
{------------------------- Private---------------------------------------------}
procedure TLMDWaveComp.SetWave(aValue:TLMDWave);
begin
  FWave.assign(aValue);
end;

{-------------------------- Public --------------------------------------------}
constructor TLMDWaveComp.Create(aOwner:TComponent);
begin
  inherited Create(aOwner);
  FWave:=TLMDWave.Create;
end;

{------------------------------------------------------------------------------}
Destructor TLMDWaveComp.Destroy;
begin
  FWave.Free;
  inherited Destroy;
end;

{------------------------------------------------------------------------------}
procedure TLMDWaveComp.LoadFromFile(const Filename: string);
begin
  FWave.LoadFromFile(FileName);
end;

{------------------------------------------------------------------------------}
procedure TLMDWaveComp.SaveToFile(const Filename: string);
begin
  FWave.SaveToFile(FileName);
end;

{------------------------------------------------------------------------------}
function TLMDWaveComp.Play:Boolean;
begin
  result:=FWave.Play;
end;

{------------------------------------------------------------------------------}
function TLMDWaveComp.PlaySoundExt(aValue:TLMDSndPlayMode):Boolean;
begin
  result:=FWave.PlaySoundExt(aValue);
end;

{------------------------------------------------------------------------------}
Procedure TLMDWaveComp.Stop;
begin
  FWave.Stop;
end;

end.
