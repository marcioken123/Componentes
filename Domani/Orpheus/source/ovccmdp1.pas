{*********************************************************}
{*                  OVCCMDP1.PAS 4.06                    *}
{*********************************************************}

{* ***** BEGIN LICENSE BLOCK *****                                            *}
{* Version: MPL 1.1                                                           *}
{*                                                                            *}
{* The contents of this file are subject to the Mozilla Public License        *}
{* Version 1.1 (the "License"); you may not use this file except in           *}
{* compliance with the License. You may obtain a copy of the License at       *}
{* http://www.mozilla.org/MPL/                                                *}
{*                                                                            *}
{* Software distributed under the License is distributed on an "AS IS" basis, *}
{* WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License   *}
{* for the specific language governing rights and limitations under the       *}
{* License.                                                                   *}
{*                                                                            *}
{* The Original Code is TurboPower Orpheus                                    *}
{*                                                                            *}
{* The Initial Developer of the Original Code is TurboPower Software          *}
{*                                                                            *}
{* Portions created by TurboPower Software Inc. are Copyright (C)1995-2002    *}
{* TurboPower Software Inc. All Rights Reserved.                              *}
{*                                                                            *}
{* Contributor(s):                                                            *}
{*                                                                            *}
{* ***** END LICENSE BLOCK *****                                              *}

{$I OVC.INC}

{$B-} {Complete Boolean Evaluation}
{$I+} {Input/Output-Checking}
{$P+} {Open Parameters}
{$T-} {Typed @ Operator}
{.W-} {Windows Stack Frame}
{$X+} {Extended Syntax}

unit ovccmdp1;
  {-Form and list that allows re-ordering of its contents}

interface

uses
  Windows, Classes, Graphics, Forms, Controls, Buttons, StdCtrls, ExtCtrls;

type
  TOvcfrmScanOrder = class(TForm)
    lbCommands: TListBox;
    btnUp: TBitBtn;
    bntDown: TBitBtn;
    btnOk: TBitBtn;
    Bevel1: TBevel;
    pnlCmdTables: TPanel;
    btnCancel: TBitBtn;
    procedure btnUpClick(Sender: TObject);
    procedure bntDownClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  end;


implementation

{$R *.DFM}


procedure TOvcfrmScanOrder.btnUpClick(Sender: TObject);
var
  I : Integer;
begin
  I := lbCommands.ItemIndex;

  if I > 0 then begin
    lbCommands.Items.Exchange(I-1, I);
    lbCommands.ItemIndex := I-1;
  end;
end;

procedure TOvcfrmScanOrder.bntDownClick(Sender: TObject);
var
  I : Integer;
begin
  I := lbCommands.ItemIndex;

  if (I > -1) and (I < lbCommands.Items.Count - 1) then begin
    lbCommands.Items.Exchange(I, I+1);
    lbCommands.ItemIndex := I+1;
  end;
end;

procedure TOvcfrmScanOrder.FormCreate(Sender: TObject);
begin
  Top := (Screen.Height - Height) div 3;
  Left := (Screen.Width - Width) div 2;
end;

end.
