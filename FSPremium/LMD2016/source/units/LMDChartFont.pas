unit LMDChartFont;
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
LMDChartFont
------------

Changes
-------
Last (07-June-2006)

###############################################################################}

interface

uses
  Windows, SysUtils, Classes, Controls, Graphics, Variants, Types, ExtCtrls,
  LMDXML, LMDXMLNodeNames, LMDChartPersistent;

type
  /// <summary>
  /// Represents font
  /// </summary>
  { ************************* TLMDChartFont ********************************** }
  TLMDChartFont = class(TFont)
  private
    FMainOwner: TObject;
    function GetQuality: integer;
    procedure SetQuality(const Value: integer);
    function GetSmoothFont: boolean;
    function GetEscapment: Integer;
    procedure SetEscapment(const Value: Integer);
  protected
    procedure Changed; override;
  public
    constructor Create(AMainOwner: TObject);
    /// <summary>
    /// Saves inner object state to xml format
    /// </summary>
    procedure SaveStateToXML(BaseNode: ILMDXmlNode; Comment: string);
    /// <summary>
    /// Loads inner object state from xml format
    /// </summary>
    procedure LoadStateFromXML(BaseNode: ILMDXmlNode; Comment: string);
    ///  <summary>
    ///  Set lfQuality member of TLogFont, to support ClearType
    ///  </summary>
    property Quality: integer read GetQuality write SetQuality;
    property Escapment: integer read GetEscapment write SetEscapment;
    property IsSmoothFontOn: boolean read GetSmoothFont;
  end;

implementation

uses
  LMDChartArea,
  LMDChartAxis,
  LMDChart;

{ *************************** TLMDChartFont ********************************** }
{ --------------------------- protected -------------------------------------- }

procedure TLMDChartFont.Changed;
begin
  inherited;
  if FMainOwner <> nil then
    if FMainOwner is TLMDChart then
      TLMDChart(FMainOwner).Repaint;
end;

{ --------------------------- public ----------------------------------------- }

procedure TLMDChartFont.SaveStateToXML(BaseNode: ILMDXmlNode; Comment: string);
var
  WorkNode, IterNode, ArrayNode: ILMDXmlNode;
begin

  WorkNode := BaseNode.EnsureChild(NNChartFont + Comment);
  IterNode := WorkNode.AppendElement('Charset');
  IterNode.SetVarAttr('value', Charset);
  IterNode := WorkNode.AppendElement('Color');
  IterNode.SetVarAttr('value', Color);
  IterNode := WorkNode.AppendElement('Height');
  IterNode.SetVarAttr('value', Height);
  IterNode := WorkNode.AppendElement('Name');
  IterNode.SetVarAttr('value', Name);
  IterNode := WorkNode.AppendElement('Size');
  IterNode.SetVarAttr('value', Size);
  IterNode := WorkNode.AppendElement('Pitch');
  IterNode.SetVarAttr('value', Variant(Pitch));
  IterNode := WorkNode.EnsureChild('Style');
  ArrayNode := IterNode.AppendElement('fsBold');
  ArrayNode.SetBoolAttr('value', fsBold in Style);
  ArrayNode := IterNode.AppendElement('fsItalic');
  ArrayNode.SetBoolAttr('value', fsItalic in Style);
  ArrayNode := IterNode.AppendElement('fsUnderline');
  ArrayNode.SetBoolAttr('value', fsUnderline in Style);
  ArrayNode := IterNode.AppendElement('fsStrikeOut');
  ArrayNode.SetBoolAttr('value', fsStrikeOut in Style);

end;

{ ---------------------------------------------------------------------------- }

procedure TLMDChartFont.LoadStateFromXML(BaseNode: ILMDXmlNode; Comment: string);
var
  WorkNode, IterNode, ArrayNode: ILMDXmlNode;
begin
  WorkNode := BaseNode.NeedChild(NNChartFont + Comment);

  IterNode := WorkNode.NeedChild('Charset');
  Charset := TFontCharset(IterNode.GetVarAttr('value', 0));

  IterNode := WorkNode.NeedChild('Color');
  Color := TColor(IterNode.GetVarAttr('value', 0));

  IterNode := WorkNode.NeedChild('Height');
  Height := IterNode.GetVarAttr('value', 0);

  IterNode := WorkNode.NeedChild('Name');
  Name := IterNode.GetVarAttr('value', 0);

  IterNode := WorkNode.NeedChild('Size');
  Size := IterNode.GetVarAttr('value', 0);

  IterNode := WorkNode.NeedChild('Pitch');
  Pitch := TFontPitch(IterNode.GetVarAttr('value', 0));

  IterNode := WorkNode.NeedChild('Style');

  ArrayNode := IterNode.NeedChild('fsBold');
  if (ArrayNode.GetBoolAttr('value')) then
    Style := Style + [fsBold];
  ArrayNode := IterNode.NeedChild('fsItalic');
  if (ArrayNode.GetBoolAttr('value')) then
    Style := Style + [fsItalic];
  ArrayNode := IterNode.NeedChild('fsUnderline');
  if (ArrayNode.GetBoolAttr('value')) then
    Style := Style + [fsUnderline];
  ArrayNode := IterNode.NeedChild('fsStrikeOut');
  if (ArrayNode.GetBoolAttr('value')) then
    Style := Style + [fsStrikeOut];

end;
{ ---------------------------------------------------------------------------- }

constructor TLMDChartFont.Create(AMainOwner: TObject);
begin
  inherited Create;
  FMainOwner := AMainOwner;
end;

function TLMDChartFont.GetEscapment: Integer;
var
  LLogFont: TLogFont;
begin
  Lock;
  GetObject(Handle, SizeOf(LLogFont), @LLogFont);
  Result := LLogFont.lfEscapement;
  Unlock;
end;

procedure TLMDChartFont.SetEscapment(const Value: Integer);
var
  LLogFont: TLogFont;
begin
  Lock;
  GetObject(Handle, SizeOf(LLogFont), @LLogFont);
  LLogFont.lfEscapement := Value * 10;
  Handle := CreateFontIndirect(LLogFont);
  Unlock;
end;

function TLMDChartFont.GetQuality: integer;
var
  LLogFont: TLogFont;
begin
  Lock;
  GetObject(Handle, SizeOf(LLogFont), @LLogFont);
  Result := LLogFont.lfQuality;
  Unlock;
end;

procedure TLMDChartFont.SetQuality(const Value: integer);
var
  LLogFont: TLogFont;
begin
  Lock;
  GetObject(Handle, SizeOf(LLogFont), @LLogFont);
  LLogFont.lfQuality := Value;
  Handle := CreateFontIndirect(LLogFont);
  Unlock;
end;

function TLMDChartFont.GetSmoothFont: Boolean;

begin
  SystemParametersInfo(SPI_GETFONTSMOOTHING, 0, @Result, 0);
  end;

end.
