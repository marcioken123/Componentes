unit LMDIconErrorProvider;
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

LMDIconErrorProvider unit (RS)
------------------------------

Error provider for icon-based indication

Changes
-------
Release 8.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes,
  Graphics, Controls, StdCtrls, ExtCtrls, Forms, Dialogs,
  LMDVldBase;

type

  {****************** Object TLMDIconErrorProvider ****************************}
  TLMDIconErrorProvider = class(TLMDCustomErrorProvider)
  protected
    FControlPaintBoxList: TList;
    FErrorIcon: TBitmap;
    //FErrorIconWritten: boolean;
    FErrorIconPosition: TAnchorKind;
    FErrorIconDistance: integer;
    procedure SetErrorIcon(const Value: TBitmap);
    procedure PaintBox_Paint(Sender: TObject);
    procedure Loaded; override;
    procedure DoDisplayError(control: ILMDValidatedControl; ErrorMsg: string; ErrorLevel: TLMDErrorLevel); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    property ErrorIcon: TBitmap read FErrorIcon write SetErrorIcon;
    property ErrorIconPosition: TAnchorKind read FErrorIconPosition write FErrorIconPosition default akRight;
    property ErrorIconDistance: integer read FErrorIconDistance write FErrorIconDistance default 10;
  end;

implementation

type
  TLMDControlPaintBox = class
  protected
    FPaintBox: TPaintBox;
    FControl: TControl;
  public
    constructor Create;
    destructor Destroy; override;
  end;

{****************** Object TLMDControlPaintBox ********************************}
{------------------------- Public ---------------------------------------------}
constructor TLMDControlPaintBox.Create;
begin
  inherited Create;
  FPaintBox := TPaintBox.Create(nil);
end;

{------------------------------------------------------------------------------}
destructor TLMDControlPaintBox.Destroy;
begin
  //FPaintBox.Hide;
  //FPaintBox.OnPaint:=nil;
  //FPaintBox.Parent:=nil;
  //FPaintBox.Free;
  inherited;
end;

{****************** Object TLMDIconErrorProvider ******************************}
{------------------------- Protected ------------------------------------------}
procedure TLMDIconErrorProvider.SetErrorIcon(const Value: TBitmap);
begin
  FErrorIcon.Assign(Value);
end;

{------------------------------------------------------------------------------}
procedure TLMDIconErrorProvider.PaintBox_Paint(Sender: TObject);
var
  PaintBox: TPaintBox;
begin
  if (Sender is TPaintBox) and not FErrorIcon.Empty then
    begin
      PaintBox := Sender as TPaintBox;
      PaintBox.Canvas.Draw(0, 0, FErrorIcon);
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDIconErrorProvider.Loaded;
begin
  inherited;
end;

{------------------------------------------------------------------------------}
procedure TLMDIconErrorProvider.DoDisplayError(control: ILMDValidatedControl; ErrorMsg: string; ErrorLevel: TLMDErrorLevel);
var
  i: integer;
  found: boolean;
  cpb: TLMDControlPaintBox;
  ctrlTop, ctrlLeft, icnTop, icnLeft: integer;
begin
  if (control <> nil) and (control.Control <> nil) and (control.Control.Parent <> nil) then
    begin
      found := false;
      i := 0;
      cpb := nil;
      while (not found) and (i < Self.FControlPaintBoxList.Count) do
        begin
          cpb := TLMDControlPaintBox(FControlPaintBoxList.Items[i]);
          found := cpb.FControl = control.Control;
          if not found then
            Inc(i);
        end;
      if (not found) and (ErrorLevel > 0) then
        begin
          cpb := TLMDControlPaintBox.Create;
          cpb.FControl := control.Control;
          cpb.FPaintBox.OnPaint := Self.PaintBox_Paint;
          cpb.FPaintBox.ShowHint := True;
          cpb.FPaintBox.Parent := control.Control.Parent;
          if Assigned(FErrorIcon) then
            begin
              cpb.FPaintBox.Height := FErrorIcon.Height;
              cpb.FPaintBox.Width := FErrorIcon.Width;
            end;
          ctrlTop := control.Control.Top;
          ctrlLeft := control.Control.Left;

          icnTop := 0;
          icnLeft := 0;

          case Self.ErrorIconPosition of
            akRight:
              begin
                icnTop := ctrlTop;
                icnLeft := ctrlLeft + control.Control.Width +
                  Self.ErrorIconDistance;
              end;
            akLeft:
              begin
                icnTop := ctrlTop;
                icnLeft := ctrlLeft - FErrorIconDistance - cpb.FPaintBox.Width;
              end;
            akTop:
              begin
                icnTop := ctrlTop - FErrorIconDistance - cpb.FPaintBox.Height;
                icnLeft := ctrlLeft;
              end;
            akBottom:
              begin
                icnTop := ctrlTop + control.Control.Height + FErrorIconDistance;
                icnLeft := ctrlLeft;
              end;
          end;

          cpb.FPaintBox.Top := icnTop;
          cpb.FPaintBox.Left := icnLeft;
          FControlPaintBoxList.Add(cpb);
        end;

      if ErrorLevel > 0 then
        begin
          cpb.FPaintBox.Hint := ErrorMsg;
          cpb.FPaintBox.Show;
        end
      else
        begin
          if found and Assigned(cpb) then
            begin
              cpb.FPaintBox.Hide;
              cpb.Free;
              FControlPaintBoxList.Delete(i);
            end;
        end;
    end;
end;

{------------------------- Public --------------------------------------------}
constructor TLMDIconErrorProvider.Create(AOwner: TComponent);
begin
  inherited;
  FControlPaintBoxList := TList.Create;
  FErrorIcon := TBitmap.Create;
  FErrorIcon.Transparent := true;
  FErrorIconPosition := akRight;
  FErrorIconDistance := 10;
end;

{------------------------------------------------------------------------------}
destructor TLMDIconErrorProvider.Destroy;
var
  cpb: TLMDControlPaintBox;
  i:Integer;
begin
  for i:=FControlPaintBoxList.Count-1 downto 0 do
    begin
      cpb := TLMDControlPaintBox(FControlPaintBoxList.Items[i]);
      FControlPaintBoxList.Delete(Pred(FControlPaintBoxList.Count));
      cpb.Free;
    end;
  FreeAndNil(FControlPaintBoxList);
  FreeAndNil(FErrorIcon);
  inherited;
end;

end.

