unit LMDSpinEdit;
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

LMDSpinEdit unit ()
-------------------

Old SpinEdit control, on user request made available in core package

Changes
-------
Release 8.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Windows, SysUtils, Menus, Messages, Classes, Graphics, Controls, Forms,
  LMDCustomExtSpinEdit;

type

  {************************* TLMDCustomSpinEdit *******************************}
  TLMDCustomSpinEdit = class(TLMDCustomExtSpinEdit)
  private
    procedure SetInteger(Index:Integer; aValue:Integer);
    function GetInteger(Index:Integer): Integer;
    procedure ReadIdent(Reader:TReader);
  protected
    procedure DefineProperties(Filer:TFiler);override;
  public
    constructor Create(AOwner: TComponent); override;
  published
    property About;
    property AutoSelect;

    property AutoSize default true;
    property Alignment;
    property Suffix;
    property EditorEnabled;
    property TabOnEnter;

    property LineSize:Integer index 0 read GetInteger write SetInteger default 1;
    property PageSize:Integer index 1 read GetInteger write SetInteger default 10;
    property MinValue:Integer index 2 read GetInteger write SetInteger default 0;
    property MaxValue:Integer index 3 read GetInteger write SetInteger default 100;
    property Value:Integer index 4 read GetInteger write SetInteger default 0;

    // RangeCheck!
    //property OnRangeError;
    property Color;
    property Ctl3D;
    property DragCursor;
    property DragMode;
    property Enabled;
    property Font;
    property ImeMode;
    property ImeName;
    property MaxLength;
    property ParentColor;
    property ParentCtl3D;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ReadOnly;
    property ShowHint;
    property TabOrder;
    property TabStop;
    property Visible;

    property OnChange;
    property OnClick;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnStartDrag;

    // V4 enhancements
    property Anchors;
    property Constraints;
    property DragKind;
    property BiDiMode;
    property ParentBiDiMode;
    property OnEndDock;
    property OnStartDock;
    property OnMouseWheelDown;
    Property OnMouseWheelUp;

  end;

  TLMDSpinEdit=class(TLMDCustomSpinEdit)
  published
    property Value;
  end;

implementation
uses
  LMDGraph;
{******************** class TLMDSpinEdit **************************************}
{-------------------------- private -------------------------------------------}
procedure TLMDCustomSpinEdit.SetInteger(Index:Integer; aValue:Integer);
begin
  case Index of
    0: inherited Step:=aValue;
    1: inherited LargeStep:=aValue;
    2: inherited MinValue:=aValue;
    3: inherited MaxValue:=aValue;
    4: inherited Value:=aValue;
  end;
end;

{ ---------------------------------------------------------------------------- }
function TLMDCustomSpinEdit.GetInteger(Index:Integer): Integer;
begin
  case index of
    0: result:=Trunc(Step);
    1: result:=Trunc(LargeStep);
    2: result:=Trunc(inherited MinValue);
    3: result:=Trunc(inherited MaxValue);
    4: result:=AsInteger;
  else
    result:=0;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomSpinEdit.ReadIdent(Reader: TReader);
var
  tmp:String;
begin
  tmp:=Reader.ReadIdent;
  Bevel.BeginUpdate;
  try
    if tmp='bsSingle' then
      Bevel.Mode:=bmWindows
    else
      begin
        Bevel.StandardStyle:=lsNone;
        Bevel.Mode:=bmStandard;
      end;
  finally
    Bevel.EndUpdate;
  end;
end;

{----------------------- protected --------------------------------------------}
procedure TLMDCustomSpinEdit.DefineProperties(Filer: TFiler);
begin
  inherited;
  Filer.DefineProperty('BorderStyle', ReadIdent, nil, false);
end;

{---------------------------- public ------------------------------------------}
constructor TLMDCustomSpinEdit.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  BeginUpdate;
  try
    AutoSize:=True;
    AutoSelect:=True;
    //Text:='0';
  finally
    EndUpdate;
  end;
end;

end.

