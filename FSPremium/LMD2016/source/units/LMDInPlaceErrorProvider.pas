unit LMDInPlaceErrorProvider;
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

LMDInPlaceErrorProvider unit (RS)
---------------------------------

Error provider for in-place (in control) error indication

Changes
-------
Release 8.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, StdCtrls,
  ExtCtrls, Forms, Dialogs,
  LMDVldBase;

type

  TLMDControlColors = class
  public
    FontColor: TColor;
    BackColor: TColor;
    Control: TControl;
    ColorsModified: Boolean;
  end;

  TLMDInPlaceErrorProvider = class(TLMDCustomErrorProvider)
  protected
    FControlFontColor: TColor;
    FControlBackColor: TColor;
    FControlColorList: TList;
    FIndicationFontColor: TColor;
    FIndicationBackColor: TColor;
    procedure DoDisplayError(AControl: ILMDValidatedControl; ErrorMsg: string; ErrorLevel: TLMDErrorLevel); override;
  public
    destructor Destroy; override;
    constructor Create(AOwner: TComponent); override;
  published
    property IndicationFontColor: TColor read FIndicationFontColor write FIndicationFontColor default clRed;
    property IndicationBackColor: TColor read FIndicationBackColor write FIndicationBackColor default clYellow;
  end;

implementation

{****************** Object TLMDInPlaceErrorProvider ***************************}
{------------------------- Protected ------------------------------------------}
procedure TLMDInPlaceErrorProvider.DoDisplayError(AControl: ILMDValidatedControl;
  ErrorMsg: string; ErrorLevel: TLMDErrorLevel);
var
  i: integer;
  found: boolean;
  cc: TLMDControlColors;
begin
  if AControl <> nil then
  begin
    if (AControl.SupportsDefaultIndication) then
    begin
      found := false;
      i := 0;
      cc := nil;
      while (not found) and (i < Self.FControlColorList.Count) do
      begin
        cc := TLMDControlColors(Self.FControlColorList.Items[i]);
        found := cc.Control = AControl.Control;
        if not found then
          Inc(i);
      end;
      if (not found) and (ErrorLevel > 0) then
      begin
        cc := TLMDControlColors.Create;
        cc.Control := AControl.Control;
        cc.ColorsModified := false;
        Self.FControlColorList.Add(cc);
      end;
      if (ErrorLevel > 0) then
      begin
        if not cc.ColorsModified then
        begin
          cc.FontColor := AControl.ControlFont.Color;
          cc.BackColor := AControl.ControlBackBrush.Color;
          cc.ColorsModified := true;
        end;
        AControl.ControlBackBrush.Color := Self.IndicationBackColor;
        AControl.ControlFont.Color := Self.IndicationFontColor;
      end
      else
      begin
        if found and Assigned(cc) then
        begin
          AControl.ControlBackBrush.Color := cc.BackColor;
          AControl.ControlFont.Color := cc.FontColor;
          cc.Free;
          Self.FControlColorList.Delete(i);
        end;
      end;
    end
//    else
//    begin
//      AControl.RespondToError(ErrorLevel);
//    end;
  end;
end;

{------------------------- Public ---------------------------------------------}
constructor TLMDInPlaceErrorProvider.Create(AOwner: TComponent);
begin
  inherited;
  FControlColorList := TList.Create;
  Self.IndicationFontColor := clRed;
  Self.IndicationBackColor := clYellow;
end;

{------------------------------------------------------------------------------}
destructor TLMDInPlaceErrorProvider.Destroy;
var
  i: integer;
  cc: TLMDControlColors;
begin
  for i := 0 to Self.FControlColorList.Count - 1 do
  begin
    cc := TLMDControlColors(Self.FControlColorList.Items[i]);
    cc.Free;
  end;
  Self.FControlColorList.Free;
  inherited;
end;

end.
