unit LMD_RegV1;
{$I lmdcmps.inc}
interface

uses Classes, DesignIntf, DesignEditors, VCLEditors, 
      {--> !!! } pLMDCECore, pLMDPeCore;

type

  {----------------------------------------------------------------------------}
  TLMDRulerComponentEditor = class(TComponentEditor)
  public
    procedure ExecuteVerb(Index: Integer); override;
    function GetVerb(Index: Integer): string; override;
    function GetVerbCount: Integer; override;
  end;

procedure Register;

{------------------------------------------------------------------------------}
implementation

uses
  LMDObj, LMDFile, LMDRuler, LMDSCRSV, LMDJoy,
  pLMDCPGetCore, pLMDPeX, pLMDGlobalEditors,
  plmdpeclp, plmdpeacp, Controls;
  
{****************** Class TLMDRulerComponentEditor ****************************}
{------------------------------------------------------------------------------}
procedure TLMDRulerComponentEditor.ExecuteVerb(Index: Integer);
begin
  with TLMDRuler(Component) do
    case Index of
      0:BigColor:=LMDCPGetColorCP(BigColor);
      1:Color:=LMDCPGetColorCP(Color);
      2:Enabled:=not Enabled;
      3:if not LMDCPGetFont(Font) then exit;
      4:Horizontal:=not Horizontal;
      5:NormalColor:=LMDCPGetColorCP(NormalColor);
    end;
  Designer.Modified;
end;

{------------------------------------------------------------------------------}
function TLMDRulerComponentEditor.GetVerb(Index: Integer): string;
begin
  case index of
    0: Result:='BigColor';
    1: Result:='Color';
    2: Result:='Enabled' + BoolStr[TLMDRuler(Component).Enabled];
    3: Result:='Font';
    4: Result:='Horizontal'+ BoolStr[TLMDRuler(Component).Horizontal];
    5: Result:='NormalColor';
  end;
end;

{------------------------------------------------------------------------------}
function TLMDRulerComponentEditor.GetVerbCount: Integer;
begin
  Result:=6;
end;


procedure Register;
begin


  {From Version 3.5 no longer supported}

  {Components}
  RegisterComponents('LMD Old', [TLMDPicClip, TLMDAniPicClip, TLMDAniImage,
                                  TLMDImage, TLMDTile, TLMDMeter, TLMDPanel,
                                  TLMDFile, TLMDRuler, TLMDScreenSaver, TLMDJoyStick,
                                  TLMDApp, TLMDScreenCanvas]);

  {TLMDAniClip-Editor}
  RegisterComponentEditor(TLMDAniPicClip, TLMDAniClipEditor);
  {TLMDPicClip-Editor}
  RegisterComponentEditor(TLMDPicClip, TLMDClipEditor);
  {TLMDAniImage-Editor}
  RegisterComponentEditor(TLMDAniImage, TLMDAniEditor);
  {TLMDClip}
  RegisterPropertyEditor( TypeInfo( TLMDClip ), nil, '', TLMDClipProperty);
  {TLMDAniClip}
  RegisterPropertyEditor( TypeInfo( TLMDAniClip ), nil, '', TLMDAniClipProperty);

  {TLMDRuler}
  RegisterComponentEditor(TLMDRuler, TLMDRulerComponentEditor);

  {Property HelpFile, TLMDApp}
  RegisterPropertyEditor( TypeInfo( String ), TLMDApp, 'HelpFile', TLMDHelpfileNameProperty );

  {TLMDFile}
  RegisterPropertyEditor( TypeInfo( String ), TLMDFile, 'FileName', TLMDFileNameProperty );
end ;

end.
