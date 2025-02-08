unit LMDRTFPrintPreviewMode;
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

LMDRTFPrintPreviewMode unit (RM)
--------------------------------


Changes
-------
Release 4.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls;

type
  TRTFPrintPreviewMode = class(TForm)
    Panel: TPanel;
    imSelected1: TImage;
    imUnSelected1: TImage;
    imSelected2: TImage;
    imUnSelected2: TImage;
    imSelected3: TImage;
    imUnSelected3: TImage;
    imSelected4: TImage;
    imUnSelected4: TImage;
    imSelected5: TImage;
    imUnSelected5: TImage;
    imSelected6: TImage;
    imUnSelected6: TImage;
    Msg: TStaticText;
    procedure MsgClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure MsgMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure imSelected1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure PanelMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure imSelected4Click(Sender: TObject);
  private
    FRowCount   : integer;
    FColCount   : integer;
  public
    property RowCount : integer read FRowCount;
    property ColCount : integer read FColCount;
  end;

implementation

{$R *.DFM}

procedure TRTFPrintPreviewMode.MsgClick(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

procedure TRTFPrintPreviewMode.FormCreate(Sender: TObject);
begin
  Width := 90;
  FRowCount := 0;
  FColCount := 0;
  Msg.Caption := Format('Pages: %dx%d',[FRowCount, FColCount]);  
end;

procedure TRTFPrintPreviewMode.MsgMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  Msg.Caption := 'Cancel';
  Msg.Alignment := taLeftJustify;
end;

procedure TRTFPrintPreviewMode.imSelected1MouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
var
  P : TPoint;
begin

  P := Point(X, Y);

  P := TImage(Sender).ClientToScreen(P);
  P := Panel.ScreenToClient(P);
  Panel.OnMouseMove(Panel, Shift, P.x, P.y);
end;

procedure TRTFPrintPreviewMode.PanelMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  imUnSelected1.Visible := (X<2) or (Y<2);
  imUnSelected2.Visible := (X<31) or (Y<2);
  imUnSelected3.Visible := (X<59) or (Y<2);
  imUnSelected4.Visible := (X<2) or (Y<31);
  imUnSelected5.Visible := (X<31) or (Y<31);
  imUnSelected6.Visible := (X<59) or (Y<31);

  imSelected1.Visible := not imUnSelected1.Visible;
  imSelected2.Visible := not imUnSelected2.Visible;
  imSelected3.Visible := not imUnSelected3.Visible;
  imSelected4.Visible := not imUnSelected4.Visible;
  imSelected5.Visible := not imUnSelected5.Visible;
  imSelected6.Visible := not imUnSelected6.Visible;

  if imSelected6.Visible then
    begin
      FRowCount := 2; FColCount := 3;
    end
  else if imSelected5.Visible then
    begin
      FRowCount := 2; FColCount := 2;
    end
  else if imSelected4.Visible then
    begin
      FRowCount := 2; FColCount := 1;
    end
  else if imSelected3.Visible then
    begin
      FRowCount := 1; FColCount := 3;
    end
  else if imSelected2.Visible then
    begin
      FRowCount := 1; FColCount := 2;
    end
  else if imSelected1.Visible then
    begin
      FRowCount := 1; FColCount := 1;
    end
  else
    begin
      FRowCount := 0; FColCount := 0;
    end;

  Msg.Caption := Format('Pages: %dx%d',[FRowCount, FColCount]);

end;

procedure TRTFPrintPreviewMode.imSelected4Click(Sender: TObject);
begin
  ModalResult := mrOk;
end;

end.
