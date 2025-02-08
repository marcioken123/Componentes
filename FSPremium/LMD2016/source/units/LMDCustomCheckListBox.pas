unit LMDCustomCheckListBox;
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

LMDCustomCheckListBox unit (RM)
-------------------------------

ToDo
----
Custom CheckBoxGlpyhs

Changes
-------
Release 8.0 (November 2006)
 - Initial Release

###############################################################################}

interface

uses
  Graphics, Messages, Classes, Dialogs, Controls, Windows,  StdCtrls,
  LMDButtonListData, LMDCustomImageListBox;

type
  {********************* TLMDCustomCheckListBox *******************************}
  TLMDCustomCheckListBox = class(TLMDCustomImageListBox)
  private
    FBtnAllowUnselect: Boolean;
    FBtnMode         : TLMDButtonListMode;
    FReadOnly,
    FBtnFlat,
    FBtnDefault      : Boolean;
    FBtnGap          : Byte;
    FOnClickCheck    : TNotifyEvent;
    FSaveStates      : TList;
    FSelectByClick   : Boolean;
    procedure SetBtnFlat(const aValue:Boolean);
    procedure SetBtnDefault(const aValue:Boolean);
    procedure SetReadOnly(const aValue:Boolean);
    procedure SetBtnGap(const aValue:Byte);
    procedure SetBtnMode(const aValue:TLMDButtonListMode);
    procedure SetItemEnabled(Index:Integer;const aValue: Boolean);
    procedure SetChecked(Index: Integer;const aValue: Boolean);
    procedure SetState(Index: Integer;const aValue:TCheckBoxState);
    procedure SetValue(aValue:Int64);
    function GetButtonData(Index: Integer):TLMDButtonListData;
    function GetChecked(Index: Integer): Boolean;
    function GetItemEnabled(Index:Integer): Boolean;
    function GetState(Index: Integer): TCheckBoxState;
    function ButtonDataAvailable(Index: Integer): Boolean;
    function CheckButtonData(Index: Integer):TLMDButtonListData;
    function CreateButtonData(Index: Integer): TLMDButtonListData;
    function GetValue:Int64;
    procedure InvalidateButtonData(Index: Integer);
    procedure ToggleClickCheck(Index: Integer);
    procedure CNDrawItem(var Message: TWMDrawItem); message CN_DRAWITEM;
    procedure WMDestroy(var Msg:TWMDestroy);message WM_DESTROY;
  protected
    procedure CreateParams(var Params: TCreateParams); override;
    procedure CreateWnd; override;
    procedure DeleteString(Index: Integer); override;
    procedure DestroyWnd; override;
    procedure DrawItem(Index: Integer; Rect: TRect; State: TOwnerDrawState); override;
    procedure DoClickCheck;

    function GetItemData(Index: Integer): {$IFDEF LMDCOMP16}TListBoxItemData{$ELSE}Integer{$ENDIF}; override;
    function InternalGetItemData(Index: Integer): {$IFDEF LMDCOMP16}TListBoxItemData{$ELSE}Integer{$ENDIF}; override;
    procedure SetItemData(Index: Integer; AData: {$IFDEF LMDCOMP16}TListBoxItemData{$ELSE}Integer{$ENDIF}); override;
    procedure InternalSetItemData(Index: Integer; AData: {$IFDEF LMDCOMP16}TListBoxItemData{$ELSE}Integer{$ENDIF}); override;

    function GetCheckWidth: Integer;
    function GetCheckHeight: Integer;
    function GetHorzExtent(index:Integer):Integer; override; // override because of checkbox
    function GetImageWidth(aValue:Integer):Integer;override; // override because of checkbox
    function GetImageHeight(aValue:Integer):Integer;override; // override because of possible custom checkbox
    procedure KeyPress(var Key: Char); override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure ResetContent; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    // 7.0 - valid only in CheckBoxMode
    procedure CheckAll(UnCheck:Boolean=False);
    // --
    property Checked[Index: Integer]: Boolean read GetChecked write SetChecked;
    property ItemEnabled[Index: Integer]: Boolean read GetItemEnabled write SetItemEnabled;
    property State[Index: Integer]: TCheckBoxState read GetState write SetState;

  published
    property BtnDefault: Boolean read FBtnDefault write SetBtnDefault default True;
    property OnClickCheck: TNotifyEvent read FOnClickCheck write FOnClickCheck;
    property Items;
    property BtnAllowUnselect:Boolean read FBtnAllowUnselect write FBtnAllowUnselect default false;
    property BtnMode:TLMDButtonListMode read FBtnMode write SetBtnMode default blCheckBox;
    property BtnFlat: Boolean read FBtnFlat write SetBtnFlat default True;
    property BtnGap: Byte read FBtnGap write SetBtnGap default 0;

    // 7.0
    property SelectByClick:Boolean read FSelectByClick write FSelectByClick default false;
    // ---

    property Value:Int64 read GetValue write SetValue default -1;

    property ReadOnly: Boolean read FReadOnly write SetReadOnly default false;

    //inherited from TLMDCustomImageListBox
    property ItemIndex;
    property ImageList;
    property ListIndex;
    property Layout;
    property MultiLine;
  end;

implementation

uses
  Types, RtlConsts, Consts, SysUtils, UxTheme, Themes,
  LMDClass, LMDProcs, LMDUtils;

{********************** Class TLMDCustomCheckListBox **************************}
{------------------------- Private --------------------------------------------}
procedure TLMDCustomCheckListBox.SetBtnFlat(const aValue:Boolean);
begin
  if aValue <> FBtnFlat then
    begin
      FBtnFlat:=aValue;
      Invalidate;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomCheckListBox.SetBtnDefault(const aValue:Boolean);
begin
  if aValue <> FBtnDefault then
    begin
      FBtnDefault:=aValue;
      Invalidate;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomCheckListBox.SetReadOnly(const aValue:Boolean);
begin
  if aValue <> FReadOnly then
    begin
      FReadOnly := aValue;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomCheckListBox.SetBtnGap(const aValue:Byte);
begin
  if aValue<>FBtnGap then
    begin
      FBtnGap:=aValue;
      Invalidate;
    end;
end;
{------------------------------------------------------------------------------}
procedure TLMDCustomCheckListBox.SetBtnMode(const aValue:TLMDButtonListMode);
begin
  if aValue<>FBtnMode then
    begin
      FBtnMode:=aValue;
      Invalidate;
      SetValue(Value);
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomCheckListBox.SetChecked(Index: Integer; const aValue:Boolean);
begin
  if aValue<>GetChecked(Index) then
    begin
      TLMDButtonListData(GetButtonData(Index)).Checked:=aValue;
      InvalidateButtonData(Index);
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomCheckListBox.SetItemEnabled(Index: Integer; const aValue:Boolean);
begin
  if aValue<>GetItemEnabled(Index) then
  begin
    TLMDButtonListData(GetButtonData(Index)).Disabled:=not aValue;
    InvalidateButtonData(Index);
  end;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomCheckListBox.SetState(Index: Integer;const aValue:TCheckBoxState);
begin
  if aValue<>GetState(Index) then
    begin
      TLMDButtonListData(GetButtonData(Index)).State:=aValue;
      InvalidateButtonData(Index);
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomCheckListBox.SetValue(aValue:Int64);
var
  i, tmp:Integer;
begin
  case FBtnMode of
    blCheckBox3State:
      for i:=0 to Pred(Items.Count) do State[i]:=cbUnChecked;
    blCheckBox:
      for i:=0 to Pred(Items.Count) do
        begin
          tmp:=LMDExp(2, i);
          Checked[i]:=tmp and aValue = tmp;
        end;
    blRadioButton:
      for i:=0 to Pred(Items.Count) do Checked[i]:=(i=aValue);
  end;
end;

{------------------------------------------------------------------------------}
function TLMDCustomCheckListBox.GetChecked(Index: Integer): Boolean;
begin
  if ButtonDataAvailable(Index) then
    result:=TLMDButtonListData(GetButtonData(Index)).Checked
  else
    result:=False;
end;

{------------------------------------------------------------------------------}
function TLMDCustomCheckListBox.GetItemEnabled(Index: Integer): Boolean;
begin
  if ButtonDataAvailable(Index) then
    result:=not TLMDButtonListData(GetButtonData(Index)).Disabled
  else
    result:=True;
end;

{------------------------------------------------------------------------------}
function TLMDCustomCheckListBox.GetState(Index: Integer): TCheckBoxState;
begin
  if ButtonDataAvailable(Index) then
    result:=TLMDButtonListData(GetButtonData(Index)).State
  else
    result:=TLMDButtonListData.GetDefaultState;;
end;

//GetWrapper
{------------------------------------------------------------------------------}
function TLMDCustomCheckListBox.GetButtonData(Index: Integer): TLMDButtonListData;
begin
  // try to get data object
  result:=CheckButtonData(Index);
  // not available? ok, create a new one
  if not Assigned(result) then result:=CreateButtonData(Index);
end;

{------------------------------------------------------------------------------}
function TLMDCustomCheckListBox.GetValue:Int64;
var
  i:Integer;
begin
  result:=0;
  case FBtnMode of
    blCheckBox3State: result:=-1;
     // we always return -1;
    blCheckBox:
      for i:=0 to Pred(Items.Count) do
        if Checked[i] then Inc(Result, LMDExp(2, i));
    blRadioButton:
      begin
        for i:=0 to Pred(Items.Count) do
          if Checked[i] then
            begin
              result:=i;
              exit;
            end;
        result:=-1;
      end;
  end;
end;

// ExtractWrapper, like GetItemButtonData, but does not create a new item if empty
{------------------------------------------------------------------------------}
function TLMDCustomCheckListBox.CheckButtonData(Index:Integer): TLMDButtonListData;
var
  Data: TObject;
begin
  Result := nil;
  Data := TObject(inherited GetItemData(Index));
//  result:=TLMDButtonListData(inherited GetItemData(Index));

  if Assigned(Data) and (LB_ERR=Integer(Data)) then
    raise EListError.CreateResFmt(@SListIndexError, [Index]);

//  if (result<>nil) and (not (result is TLMDButtonListData)) then
//    result:=nil;
  if  Assigned(Data) and (Data is TLMDButtonListData) then
    Result := TLMDButtonListData(Data);
end;

// CreateWrapper
{------------------------------------------------------------------------------}
function TLMDCustomCheckListBox.CreateButtonData(Index: Integer): TLMDButtonListData;
begin
  result:=TLMDButtonListData.Create;

  inherited SetItemData(Index, LPARAM(result));

end;

// HaveWrapper
{------------------------------------------------------------------------------}
function TLMDCustomCheckListBox.ButtonDataAvailable(Index: Integer): Boolean;
begin
  result:=CheckButtonData(Index)<>nil;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomCheckListBox.DeleteString(Index: Integer);
begin
  if ButtonDataAvailable(Index) then GetButtonData(Index).Free;
  inherited;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomCheckListBox.InvalidateButtonData(Index: Integer);
var
  r:TRect;
begin
  r:=ItemRect(Index);
  if not UseRightToLeftAlignment then
    R.Right := R.Left + GetCheckWidth
  else
    R.Left := R.Right - GetCheckWidth;
  LMDInvalidateRect(Handle, R, not (csOpaque in ControlStyle));
  UpdateWindow(Handle);
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomCheckListBox.ToggleClickCheck;
var
  State: TCheckBoxState;
  i:Integer;
begin
  if (Index >= 0) and (Index < Items.Count) and GetItemEnabled(Index) then
    begin
      State := Self.State[Index];
      // uncheck all
      if FBtnMode=blRadioButton then
        for i:=0 to Pred(Items.Count) do Self.State[i]:=cbUnchecked;
      case State of
        cbUnchecked:
          if FBtnMode=blCheckBox3State then State := cbGrayed else State := cbChecked;
        // Allow no items selected? -> FBtnAllowUnselect
        cbChecked: if (FBtnMode<>blRadioButton) or FBtnAllowUnselect then State := cbUnchecked;
        cbGrayed: State := cbChecked;
      end;
      Self.State[Index] := State;
      DoClickCheck;
    end;
end;

{------------------------------------------------------------------------------}

procedure TLMDCustomCheckListBox.CNDrawItem(var Message: TWMDrawItem);
begin
  with Message.DrawItemStruct^ do
    if not UseRightToLeftAlignment then
      rcItem.Left := rcItem.Left + GetCheckWidth
    else
      rcItem.Right := rcItem.Right - GetCheckWidth;
  inherited;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomCheckListBox.WMDestroy(var Msg: TWMDestroy);
var
  i: Integer;
begin
  if not (csDestroying in ComponentState) then
  begin
    for i:=0 to Pred(Items.Count) do
      CheckButtonData(i).Free;
  end;
  inherited;
end;

{------------------------------ Protected -------------------------------------}
procedure TLMDCustomCheckListBox.CreateWnd;
begin
  inherited CreateWnd;
  if Assigned(FSaveStates) then
    FreeAndNil(FSaveStates);
  // RM
  //ResetItemHeight;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomCheckListBox.DestroyWnd;
var
  i:Integer;
begin
  if Items.Count>0 then
    begin
      FSaveStates:=TList.Create;
      for i:=0 to Pred(Items.Count) do
        FSaveStates.Add(LMDBtnMakeSaveState(State[i], not ItemEnabled[i]));
    end;
  inherited DestroyWnd;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomCheckListBox.DoClickCheck;
begin
  if Assigned(FOnClickCheck) then FOnClickCheck(Self);
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomCheckListBox.CreateParams(var Params: TCreateParams);
begin
  inherited;
end;

// required????
{------------------------------------------------------------------------------}
procedure TLMDCustomCheckListBox.DrawItem(Index: Integer; Rect: TRect;
  State: TOwnerDrawState);
var
  r, tmp: TRect;
  chwdth: Integer;
  enbl:   Boolean;
begin
  chwdth := GetCheckWidth;

  if Index < Items.Count then
  begin
    r := Rect;

    if not UseRightToLeftAlignment then
    begin
      r.Right := Rect.Left;
      r.Left  := r.Right - chwdth;
    end
    else
    begin
      r.Left  := Rect.Right;
      r.Right := r.Left + chwdth;
    end;

    if Transparent then
    begin
      tmp := r;
      if Index = Pred(Items.Count) then
        tmp.Bottom := ClientHeight;
      RestoreBack(tmp);
    end;

    enbl := Enabled and GetItemEnabled(Index);

    LMDDrawButtonListItem(Self, Canvas, r, GetState(Index), FBtnMode, enbl,
                          FBtnFlat, FBtnDefault, ThemeMode);

    if not enbl then
      Canvas.Font.Color := clGrayText
    else
      Canvas.Font.Color := GetThemedTextColor;
  end;

  Canvas.Refresh;
  inherited;
end;

{------------------------------------------------------------------------------}
function TLMDCustomCheckListBox.GetHorzExtent(index:Integer):Integer;
begin
  result:=inherited GetHorzExtent(index)+GetCheckWidth;
end;

{------------------------------------------------------------------------------}
function TLMDCustomCheckListBox.GetImageWidth(aValue:Integer):Integer;
begin
  result:=inherited GetImageWidth(aValue)+GetCheckWidth;
end;

{------------------------------------------------------------------------------}
function TLMDCustomCheckListBox.GetImageHeight(aValue:Integer):Integer;
var
  tmp:Integer;
begin
  result:=inherited GetImageHeight(aValue);
  tmp:=GetCheckHeight+2;
  if tmp>result then result:=tmp;
end;

{------------------------------------------------------------------------------}

function TLMDCustomCheckListBox.InternalGetItemData(Index: Integer): {$IFDEF LMDCOMP16}TListBoxItemData{$ELSE}Integer{$ENDIF};

begin
  // call inherited version
  result:=inherited GetItemData(Index);
end;

{------------------------------------------------------------------------------}

procedure TLMDCustomCheckListBox.InternalSetItemData(Index: Integer; AData: {$IFDEF LMDCOMP16}TListBoxItemData{$ELSE}Integer{$ENDIF});

begin
  // call inherited version
  inherited SetItemData(Index, AData);
end;

{------------------------------------------------------------------------------}

procedure TLMDCustomCheckListBox.SetItemData(Index: Integer; aData: {$IFDEF LMDCOMP16}TListBoxItemData{$ELSE}Integer{$ENDIF});

var
  buttondata:TLMDButtonListData;
  SaveState:TObject;
begin
  buttondata:=TLMDButtonListData(GetButtonData(Index));
  buttondata.Data:=TObject(aData);
  if FSaveStates<>nil then
    if FSaveStates.Count > 0 then
      begin
        SaveState:=FSaveStates[0];
        buttondata.State:=LMDBtnGetSaveState(SaveState);
        buttondata.Disabled:=LMDBtnGetSaveDisabled(SaveState);
        FSaveStates.Delete(0);
      end;
end;

{------------------------------------------------------------------------------}

function TLMDCustomCheckListBox.GetItemData(Index: Integer): {$IFDEF LMDCOMP16}TListBoxItemData{$ELSE}Integer{$ENDIF};
begin
  result:=0;
  if ButtonDataAvailable(Index) then
    result := LPARAM(TLMDButtonListData(GetButtonData(Index)).Data);
end;

{------------------------------------------------------------------------------}
function TLMDCustomCheckListBox.GetCheckWidth: Integer;
begin
  result:=FBtnGap+2;
  if FBtnDefault then
    Result:=Result+LMDApplication.CheckDefWidth
  else
    Result:=Result+LMDApplication.CheckCustomWidth;
end;

{------------------------------------------------------------------------------}
function TLMDCustomCheckListBox.GetCheckHeight: Integer;
begin
  if FBtnDefault then
    Result:=LMDApplication.CheckDefHeight
  else
    Result:=LMDApplication.CheckCustomHeight;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomCheckListBox.KeyPress(var Key: Char);
begin
  inherited;
  if ReadOnly then exit;
  if Key =Chr(32) then ToggleClickCheck(ItemIndex);
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomCheckListBox.MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  Index: Integer;
begin
  inherited;
  if (Button=mbLeft) and not ReadOnly then
    begin
      Index:=ItemAtPos(Point(X,Y),True);
      if (Index<>-1) and GetItemEnabled(Index) then
        if not UseRightToLeftAlignment then
          begin
            if FSelectByClick or
               (X - ItemRect(Index).Left < GetCheckWidth) then ToggleClickCheck(Index)
          end
        else
          begin
            Dec(X, ItemRect(Index).Right-GetCheckWidth);
            if FSelectByCLick or
               ((X>0) and (X < GetCheckWidth)) then ToggleClickCheck(Index)
          end;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomCheckListBox.ResetContent;
var
  i:Integer;
begin
  for i := 0 to Items.Count-1 do // RM 21.03.2010, Memory Leak Fix
    if ButtonDataAvailable(i) then
      GetButtonData(i).Free;
  inherited;
end;

{---------------------------- Public ------------------------------------------}
constructor TLMDCustomCheckListBox.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FBtnFlat   := true;
  FBtnDefault:= true;
  FBtnGap    := 0;
  FReadOnly  := false;
end;

{------------------------------------------------------------------------------}
destructor TLMDCustomCheckListBox.Destroy;
begin
  if Assigned(FSaveStates) then
    FreeAndNil(FSaveStates);
  inherited Destroy;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomCheckListBox.CheckAll(UnCheck:Boolean=False);
var
  i:Integer;
begin
  If FBtnMode<>blRadioButton then
    for i:=0 to Items.Count-1 do
      Checked[i]:=not UnCheck;
end;

end.
