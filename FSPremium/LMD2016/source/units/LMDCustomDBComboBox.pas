unit LMDCustomDBComboBox;
{$I lmdcmps.INC}

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

LMDCustomDBComboBox unit ()
---------------------------

Changes
-------
Release 8.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Classes,
  Controls, //CM_BASE
  Messages,
  LMDBase,
  LMDCustomComboBox;

const
  CM_LMDDBCHANGED = CM_BASE + 210;

type
  TLMDCustomDBComboBox = class (TLMDCustomComboBox)
  private
    FDataBase : TDataBase;
    FUpdate   : Boolean;

    procedure SetDataBase (aValue : TDataBase);
    procedure CMLMDDBCHANGED (var Msg : TMessage); message CM_LMDDBCHANGED;
  protected
    procedure Connected; virtual;
  public
    constructor Create (aOwner : TComponent); override;
    procedure Notification (AComponent: TComponent; Operation: TOperation); override;
    procedure Loaded; override;
    property CtlXP; // compatibility
    property DataBase : TDataBase read FDataBase write FDataBase;
    property Update : Boolean read FUpdate write FUpdate default true;
  published
    property About;
    property Color;
    property Ctl3D;
    property Cursor;
    property DragCursor;
    property DropDownCount;
    property DropDownWidth;
    property Flat;
    property FocusControl;
    property Hint;
    property Interval;
    property MRUList;
    property MRUMax;
    property ParentColor;
    property ParentCtl3D;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property Search;
    property ShowHint;
    property Sorted;
    property Style;
    property ThemeMode;
    property ThemeGlobalMode;    
    property TabOrder;
    property TabStop;

    property OnChange;
    property OnClick;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnDropDown;
    property OnEditClick;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnSelect;
    property OnStartDrag;
    // 7.1
    property OnContextPopup;
    property OnCloseUp;
  end;

implementation

{ ------------------------- private ------------------------------------------ }
procedure TLMDCustomDBComboBox.SetDataBase (aValue : TDataBase);
begin
  FDataBase := aValue;
  if FDataBase <> nil then
    Connected;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomDBComboBox.CMLMDDBCHANGED (var Msg : TMessage);
begin
  Connected;
end;

{ ------------------------- protected ---------------------------------------- }
procedure TLMDCustomDBComboBox.Connected;
begin
end;

{ ------------------------- public ------------------------------------------- }
constructor TLMDCustomDBComboBox.Create (aOwner : TComponent);
begin
  inherited Create (aOwner);
  FUpdate := true;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomDBComboBox.Notification (AComponent : TComponent; Operation : TOperation);
begin
  inherited Notification (AComponent, Operation);
  if (Operation = opRemove) and (AComponent = FDataBase) then
    DataBase := nil;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomDBComboBox.Loaded;
begin
  inherited Loaded;
  if FDataBase <> nil then
    Connected;
end;

end.
