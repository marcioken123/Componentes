unit ElFrmPers;
{$I lmdcmps.inc}

{###############################################################################

LMD VCL Series 2016
� by LMD Innovative
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

ElFrmPers unit
--------------


Changes
-------
Release 6.0 (February 2007)
 - Initial Release

###############################################################################}

interface

uses
  Classes,
  SysUtils,
  Windows,
  Messages,
  Graphics,
  Controls,
  Forms,
  Menus,
  StdCtrls,
  ExtCtrls,
  Types,
  ElHook,
  LMDUtils,
  ElVCLUtils,
{$ifdef LMD_UNICODE}
  LMDUnicodeStrings,
{$endif}
  ElComponent,
  ElMTree,
  TypInfo,
  LMDUnicode,
  LMDStrings,
  ElTopmost,
  ElIni;

type
  TElFormPersist = class;

  TElPersistOption = (epoState, epoPosition, epoProperties, epoActiveControl, epoSize);
  TElPersistOptions = set of TElPersistOption;

  TElMinMaxInfo = class(TPersistent)
  private
    FInfo : TMinMaxInfo;
    FOwner : TElFormPersist;
    procedure SetInfo(index : integer; Value : integer);
    function GetInfo(index : integer) : integer;
  published
    property MaxPosX : Integer index 0 read GetInfo write SetInfo default 0;
    property MaxPosY : Integer index 1 read GetInfo write SetInfo default 0;
    property MaxSizeX : Integer index 2 read GetInfo write SetInfo default 0;
    property MaxSizeY : Integer index 3 read GetInfo write SetInfo default 0;
    property MaxTrackX : Integer index 4 read GetInfo write SetInfo default 0;
    property MaxTrackY : Integer index 5 read GetInfo write SetInfo default 0;
    property MinTrackX : Integer index 6 read GetInfo write SetInfo default 0;
    property MinTrackY : Integer index 7 read GetInfo write SetInfo default 0;
  end;
  // Fake class. Do not remove!
  TElStoredProps = class
  end;

  TElFormPersist = class(TElComponent)
  private
    FTopMost : Boolean;
    ATopmost : TElTopmost;
    FPersistOptions : TElPersistOptions;
    FActive : Boolean;
    FMinMaxInfo : TElMinMaxInfo;
    FProps : TElMTree;
    FStorage : TElIniFile;
    FStoragePath : string;
    FOnSave : TNotifyEvent;
    FOnRestore : TNotifyEvent;
    FHook : TElHook;
    //FOnShow : TNotifyEvent;
    //FOnDestroy : TNotifyEvent;
    //FOnHide : TNotifyEvent;
    // Fake field.
    FStoredProps : TElStoredProps;
    FSaveSize : TRect;
    RealDims: TRect;
    FFormSaved: Boolean;
    //FPosChanging : boolean;
    procedure SetStorage(newValue : TElIniFile);
    procedure SetMinMaxInfo(newValue : TElMinMaxInfo);
    procedure SetActive(newValue : Boolean);
    procedure OnHook(Sender : TObject; var Msg : TMessage; var Handled : boolean);
    procedure OnAfterHook(Sender : TObject; var Msg : TMessage; var Handled : boolean);
    //procedure FormShow(Sender : TObject);
    //procedure FormHide(Sender : TObject);
    //procedure FormDestroy(Sender : TObject);
    procedure ReadPropsList(Stream : TStream);
    procedure WritePropsList(Stream : TStream);
    procedure OnSavePropData(Sender : TObject; Item : TElMTreeItem; Stream : TStream);
    procedure OnLoadPropData(Sender : TObject; Item : TElMTreeItem; Stream : TStream);
    procedure OnDelPropData(Sender : TObject; Item : TElMTreeItem; Data : pointer);
    function GetPropsToStore : TElMTree;
    procedure SetTopMost(Value : Boolean);
  protected
    FFlipped: Boolean;
    procedure TriggerSaveEvent; virtual;
    procedure TriggerRestoreEvent; virtual;
    procedure InfoChanged;
    procedure Notification(AComponent : TComponent; Operation : TOperation); override;
    procedure UpdatePosition;
    procedure DefineProperties(Filer : TFiler); override;
    procedure Loaded; override;
    procedure SetFlipped(Value: Boolean);
    procedure DoFlip(Flip : boolean);
  public
    constructor Create(AOwner : TComponent); override;
    destructor Destroy; override;
    procedure Save;
    procedure Restore;
    procedure SavePosition;
    procedure RestorePosition;
    procedure SaveProps;
    procedure RestoreProps;
    property PropsToStore : TElMTree read GetPropsToStore;
    property Flipped: Boolean read FFlipped write SetFlipped;
  published
    property Storage : TElIniFile read FStorage write SetStorage;
    property StoragePath : string read FStoragePath write FStoragePath;
    property OnSave : TNotifyEvent read FOnSave write FOnSave;
    property OnRestore : TNotifyEvent read FOnRestore write FOnRestore;
    property MinMaxInfo : TElMinMaxInfo read FMinMaxInfo write SetMinMaxInfo;
    property Active : Boolean read FActive write SetActive default True;
    property PersistOptions : TElPersistOptions read FPersistOptions write FPersistOptions;
    property StoredProps : TElStoredProps read FStoredProps;
    property TopMost : Boolean read FTopMost write SetTopMost;
  end;

type
  TElStoreType = (estComp, estProp, estCollection);

type
  TElPropData = record
  PropType : TElStoreType;
    Store : boolean;
    Name : String;
  end;
  PElPropData = ^TElPropData;
  implementation

uses
  ElPropTools,
  LMDObjectList;

procedure TElMinMaxInfo.SetInfo(index : integer; Value : integer);
begin
  if GetInfo(index) = Value then exit;
  case index of
    0 : FInfo.ptMaxPosition.x := Value;
    1 : FInfo.ptMaxPosition.y := Value;
    2 : FInfo.ptMaxSize.x := Value;
    3 : FInfo.ptMaxSize.y := Value;
    4 : FInfo.ptMaxTrackSize.x := Value;
    5 : FInfo.ptMaxTrackSize.y := Value;
    6 : FInfo.ptMinTrackSize.x := Value;
    7 : FInfo.ptMinTrackSize.y := Value;
  end;
  FOwner.InfoChanged;
end;

function TElMinMaxInfo.GetInfo(index : integer) : integer;
begin
  case index of
    0 : Result := FInfo.ptMaxPosition.x;
    1 : Result := FInfo.ptMaxPosition.y;
    2 : Result := FInfo.ptMaxSize.x;
    3 : Result := FInfo.ptMaxSize.y;
    4 : Result := FInfo.ptMaxTrackSize.x;
    5 : Result := FInfo.ptMaxTrackSize.y;
    6 : Result := FInfo.ptMinTrackSize.x;
    7 : Result := FInfo.ptMinTrackSize.y;
  else
    Result := 0;
  end;
end;

procedure TElFormPersist.OnSavePropData(Sender : TObject; Item : TElMTreeItem; Stream : TStream);
var
  P : PElPropData;
  str: AnsiString;
begin
  P := PElPropData(Item.Data);
  Stream.WriteBuffer(P.PropType, sizeof(P.PropType));
  Stream.WriteBuffer(P.Store, sizeof(P.Store));
  str := AnsiString(P.Name);
  LMDAnsiWriteStringToStream(Stream, str);
end;

procedure TElFormPersist.OnLoadPropData(Sender : TObject; Item : TElMTreeItem; Stream : TStream);
var
  P : PElPropData;
  s: AnsiString;
begin
  New(P);
  Stream.ReadBuffer(P.PropType, sizeof(P.PropType));
  Stream.ReadBuffer(P.Store, sizeof(P.Store));
  LMDAnsiReadStringFromStream(Stream, s);
  P.Name := String(s);
  Item.Data := P;
end;

procedure TElFormPersist.OnDelPropData(Sender : TObject; Item : TElMTreeItem; Data : pointer);
begin
  if Data <> nil then
    Dispose(PElPropData(Data));
end;

procedure TElFormPersist.InfoChanged;
begin

end;

type
  THackForm = class(TCustomForm)
  end;

procedure TElFormPersist.OnAfterHook(Sender : TObject; var Msg : TMessage; var Handled : boolean);
var
  TWP : TWindowPlacement;
  Form2 : THackForm;
  B : boolean;
begin
  if (Msg.Msg = WM_SIZE) or (Msg.Msg = WM_MOVE) then
  begin
    TWP.length := sizeof(TWP);
    GetWindowPlacement(TWinControl(FHook.Control).Handle, @TWP);
    if TWP.showCmd = SW_SHOWNORMAL then FSaveSize := FHook.Control.BoundsRect;
  end;
  if Msg.Msg = WM_WINDOWPOSCHANGED then
  begin
    if (TWMWindowPosChanged(Msg).WindowPos.flags and SWP_HIDEWINDOW) = SWP_HIDEWINDOW then
    begin
      try
        //Form2 := THackForm(GetOwnerForm(Self));
        if (*Assigned(Form2) and (not (csDestroying in Form2.ComponentState)) and *) (not (csDesigning in ComponentState)) then
        begin
          SavePosition;
          SaveProps;
          TriggerSaveEvent;
        end;
      except
        Application.HandleException(self);
      end;
    end
    (*else
    if (TWMWindowPosChanged(Msg).WindowPos.flags and SWP_SHOWWINDOW) = SWP_SHOWWINDOW then
    begin
      try
        RestorePosition;
        RestoreProps;
        TriggerRestoreEvent;
        b := Topmost;
        Topmost := false;
        TopMost := b;
      except
        Application.HandleException(self);
      end;
    end;
    *)
  end;
  if Msg.Msg = WM_SHOWWINDOW then
  begin
    if Msg.WParam <> 0 then
    begin
      try
        RestorePosition;
        RestoreProps;
        TriggerRestoreEvent;
        b := Topmost;
        Topmost := false;
        TopMost := b;
      except
        Application.HandleException(self);
      end;
      FFormSaved := false;
    end
    else
    begin
      SavePosition;
      try
        Form2 := THackForm(LMDGetOwnerForm(Self));
        if Assigned(Form2) and (not (csDestroying in Form2.ComponentState)) and (not (csDesigning in ComponentState)) then
        begin
          SavePosition;
          SaveProps;
          TriggerSaveEvent;
        end;
      except
        Application.HandleException(self);
      end;
      FFormSaved := true;
    end;
  end;
end;

procedure TElFormPersist.OnHook(Sender : TObject; var Msg : TMessage; var Handled : boolean);

type
  TIntArr = array[1..10] of integer;
  PIntArr = ^TIntArr;

var
  op, tp : PIntArr;
  i      : integer;
  TWP    : TWindowPlacement;
  Form2: THackForm;
  begin
  if Active and (Msg.Msg = WM_CREATE) then
  begin
    TWP.length := sizeof(TWP);
    GetWindowPlacement((FHook.Control as TWinControl).Handle, @TWP);
    if TWP.showCmd = SW_SHOWNORMAL then
      FSaveSize := FHook.Control.BoundsRect;
  end;
//  if Msg.Msg = CM_SHOWINGCHANGED then
//  begin
//    TWP.length := sizeof(TWP);
//    GetWindowPlacement((FHook.Control as TWinControl).Handle, @TWP);
//    if TWP.showCmd = SW_SHOWMAXIMIZED then
//      RestorePosition;
//  end;
  if Active and (Msg.Msg = WM_DESTROY) then
  begin
    if not FFormSaved then
    begin
      SavePosition;
      try
        Form2 := THackForm(LMDGetOwnerForm(Self));
        if Assigned(Form2) and (not (csDestroying in Form2.ComponentState)) and (not (csDesigning in ComponentState)) then
        begin
          SavePosition;
          SaveProps;
          TriggerSaveEvent;
        end;
      except
        Application.HandleException(self);
      end;
      FFormSaved := true;
    end;
  end;
  if Msg.Msg = WM_SHOWWINDOW then
  begin
    if (Msg.WParam <> 0) then
    begin
      TWP.length := sizeof(TWP);
      GetWindowPlacement((FHook.Control as TWinControl).Handle, @TWP);
      if (TWP.showCmd = SW_SHOWMAXIMIZED) and (LMDGetOwnerForm(Self) <> nil) and (LMDGetOwnerForm(Self).Position = poScreenCenter) then
        RestorePosition;
    end;
  end;
  if (not FActive) or (Msg.Msg <> WM_GETMINMAXINFO) then
    exit
  else
  begin
    op := PIntArr(@FMinMaxInfo.FInfo);
    tp := PIntArr(Msg.LParam);
    for i := 3 to 10 do
      if (op[i] <> 0) then
         tp[i] := op[i];
    Msg.Result := 1;
    if Flipped then
    begin
      tp[9] := (FHook.Control as TWinControl).Width;
      tp[10] := (FHook.Control as TWinControl).Height;
    end;
    end;
end;

procedure TElFormPersist.SetStorage(newValue : TElIniFile);
begin
  if (FStorage <> newValue) then
  begin
    if FStorage <> nil then
      if not (csDestroying in FStorage.ComponentState) then
        FStorage.RemoveFreeNotification(Self);
    FStorage := newValue;
    if FStorage <> nil then
       FStorage.FreeNotification(Self);
  end; {if}
end;

procedure TElFormPersist.Save;
begin
  try
    SavePosition;
    SaveProps;
    TriggerSaveEvent;
  except
    Application.HandleException(self);
  end;
end;

procedure TElFormPersist.Restore;
begin
  try
    RestorePosition;
    RestoreProps;
    TriggerRestoreEvent;
  except
    Application.HandleException(self);
  end;
end;

procedure TElFormPersist.TriggerSaveEvent;
begin
  if (assigned(FOnSave)) then
    FOnSave(Self);
end;

procedure TElFormPersist.TriggerRestoreEvent;
begin
  if (assigned(FOnRestore)) then
    FOnRestore(Self);
end;

procedure TElFormPersist.SetMinMaxInfo(newValue : TElMinMaxInfo);
begin
  if (FMinMaxInfo <> newValue) then
    if newValue <> nil then FMinMaxInfo.Assign(newValue);
end;

procedure TElFormPersist.SetActive(newValue : Boolean);
begin
  if (FActive <> newValue) then
  begin
    FActive := newValue;
    if not (csDesigning in ComponentState) then
      FHook.Active := FActive;
  end; {if}
end;

procedure TElFormPersist.Notification(AComponent : TComponent; Operation : TOperation);
var
  Form: THackForm;
  //OnSmth : TNotifyEvent;

begin
  Form := THackForm(LMDGetOwnerForm(Self));
  if (AComponent = Form) then
  begin
    (*
    if (Operation = opRemove) and (not (csDesigning in ComponentState)) then
    begin
      FHook.Control := nil;
    end;
    *)
    if not (csDestroying in Form.ComponentState) then
      Form.RemoveFreeNotification(Self);
    end
  else
  if ((AComponent = Self) and (Operation = opInsert)) and (Form <> nil) then
  begin
    if not (csDesigning in ComponentState) then
    begin
      (*OnSmth := FormShow;
      if ((@Form.OnShow) <> (@FOnShow)) and ((@Form.OnShow) <> @OnSmth) then
          FOnShow := Form.OnShow;
      Form.OnShow := FormShow;
      OnSmth := FormDestroy;
      if ((@Form.OnDestroy) <> @FOnDestroy) and ((@Form.OnDestroy) <> @OnSmth) then
          FOnDestroy := Form.OnDestroy;
      Form.OnDestroy := FormDestroy;
      OnSmth := FormHide;
      if ((@Form.OnHide) <> (@FOnHide)) and ((@Form.OnHide) <> @OnSmth)  then
          FOnHide := Form.OnHide;
      Form.OnHide := FormHide;
      *)
    end;
  end;
  if (AComponent = FStorage) and (Operation = opRemove) then
    FStorage := nil;
  inherited;
end;

procedure TElFormPersist.SavePosition;
var
  FOldKey : string;
  ACN : string;
  R : TRect;
  i : integer;
  TWP : TWindowPlacement;
begin
  TWP.length := sizeof(TWP);
  if (FActive) and Assigned(FStorage) and (not (csDesigning in ComponentState)) then
  begin
    FOldKey := FStorage.CurrentKey;
    if FStorage.OpenKey(FStoragePath + FStorage.Delimiter + Owner.Name, true) then
    begin
      if epoState in PersistOptions then
      begin
        if TForm(Owner) = Application.MainForm then
        begin
          GetWindowPlacement(Application.Handle, @TWP);
          if TWP.showCmd = SW_SHOWMINIMIZED then
             i := ord(wsMinimized)
          else
          begin
            GetWindowPlacement(Application.MainForm.Handle, @TWP);
            if TWP.showCmd = SW_SHOWMAXIMIZED then
               i := ord(wsMaximized)
            else
              i := ord(wsNormal);
          end;
          FStorage.WriteInteger('', 'State', i);
        end else
        begin
          FStorage.WriteInteger('', 'State', ord(TForm(Owner).WindowState));
        end;
        FStorage.WriteBool('', 'Topmost', FTopmost);
      end;
      if epoActiveControl in PersistOptions then
      begin
        if TForm(Owner).ActiveControl <> nil then
        begin
          ACN := TForm(Owner).ActiveControl.Name;
          if Length(ACN) > 0 then FStorage.WriteString('', 'Active control', ACN);
        end;
      end;
      if epoSize in PersistOptions then
        with FStorage do
        begin
          R := FSaveSize;
          WriteInteger('', 'Width', R.Right - R.Left);
          WriteInteger('', 'Height', R.Bottom - R.Top);
        end;
      if epoPosition in PersistOptions then
        with FStorage do
        begin
          R := FSaveSize;
          WriteInteger('', 'Left', R.Left);
          WriteInteger('', 'Top', R.Top);
        end;
    end;
    FStorage.OpenKey(FOldKey, false);
  end;
end;

type
{$HINTS OFF}
  THack2Form = class(TScrollingWinControl)
  private
    FActiveControl: TWinControl;
    FFocusedControl: TWinControl;
    FBorderIcons: TBorderIcons;
    FBorderStyle: TFormBorderStyle;

    FSizeChanging: Boolean;

    FWindowState: TWindowState;
  end;
{$HINTS ON}
procedure TElFormPersist.RestorePosition;
var
  FOldKey : string;
  ACN : string;
  R : TRect;
  i : integer;
  b : boolean;
  F : TComponent;
  Form : TCustomForm;
begin
  if (FActive) and Assigned(FStorage) and (not (csDesigning in ComponentState)) then
  begin
    Form := LMDGetOwnerForm(Self);
    if Assigned(Form) then
    begin
      FOldKey := FStorage.CurrentKey;
      if FStorage.OpenKey(FStoragePath + FStorage.Delimiter + Owner.Name, False) then
      begin
        if (epoActiveControl in PersistOptions) then
        begin
          if FStorage.ReadString('', 'Active control', '', ACN) then
          begin
            F := Form.FindComponent(ACN);
            if (F <> nil) and (F is TWinControl) and (TWinControl(F).CanFocus) then
            begin
              Form.ActiveControl := TWinControl(F);
            end;
          end;
        end;
        if (epoPosition in PersistOptions) and (LMDGetOwnerForm(Self).WindowState = wsNormal) then
          with FStorage do
          begin
            b := true;
            R := Form.BoundsRect;
            b := b and ReadInteger('', 'Left', 0, i) {and (i >=0)};
            R.Right := R.Right - R.Left + i;
            R.Left := i;
            b := b and ReadInteger('', 'Top', 0, i) {and (i >=0)};
            R.Bottom := R.Bottom - R.Top + i;
            R.Top := i;
            if b then Form.BoundsRect := R;
          end;
        if (epoSize in PersistOptions) and (LMDGetOwnerForm(Self).WindowState = wsNormal) then
          with FStorage do
          begin
            R := Form.BoundsRect;
            b := ReadInteger('', 'Width', 0, i) and (i >= 0);
            R.Right := R.Left + i;
            b := b and ReadInteger('', 'Height', 0, i) and (i >= 0);
            R.Bottom := R.Top + i;
            if b then Form.BoundsRect := R;
          end;
        if epoState in PersistOptions then
        begin
          if FStorage.ReadInteger('', 'State', 0, i) then
          begin
            if TForm(Owner) = Application.MainForm then
            begin
              case TWindowState(i) of
                wsMaximized:
                  Form.WindowState := wsMaximized;
                wsMinimized:
                  begin
                    THack2Form(Owner).FWindowState := wsNormal;
                    PostMessage(Application.Handle, WM_SYSCOMMAND, SC_MINIMIZE, 0);
                  end;
                wsNormal:
                  Form.WindowState := wsNormal;
                else
                  Application.Restore;
              end;
            end else
              Form.WindowState := TWindowState(i);
          end;
          if FStorage.ReadBool('', 'Topmost', false, b) then
            Topmost := b;
        end;
      end;
      FStorage.OpenKey(FOldKey, false);
    end;
  end;
end;

procedure TElFormPersist.UpdatePosition;
var
  Place : TWindowPlacement;
begin
  if not (csLoading in ComponentState) and
     (FHook.Control <> nil) and
     ((FHook.Control as TWinControl).HandleAllocated) then
  begin
    Place.length := sizeof(Place);
    GetWindowPlacement(TWinControl(FHook.Control).Handle, @Place);
    if not IsWindowVisible(TWinControl(FHook.Control).Handle) then Place.ShowCmd := SW_HIDE;
    case TForm(FHook.Control).BorderStyle of //
      bsSingle,
        bsToolWindow :
        begin
          Place.ptMaxPosition.X := -GetSystemMetrics(SM_CXBORDER);
          Place.ptMaxPosition.Y := -GetSystemMetrics(SM_CXBORDER);
        end;
      bsSizeable,
        bsSizeToolWin :
        begin
          Place.ptMaxPosition.X := -GetSystemMetrics(SM_CXFRAME);
          Place.ptMaxPosition.Y := -GetSystemMetrics(SM_CXFRAME);
        end;
      bsDialog :
        begin
          Place.ptMaxPosition.X := -GetSystemMetrics(SM_CXDLGFRAME);
          Place.ptMaxPosition.Y := -GetSystemMetrics(SM_CXDLGFRAME);
        end;
    else
      Place.ptMaxPosition := Point(0, 0);
    end; // case
    Place.length := sizeof(Place);
    SetWindowPlacement(TWinControl(FHook.Control).Handle, @Place);
  end;
end;

procedure TElFormPersist.SaveProps;

  procedure IntSaveProps(FComp : TObject; Path : string; Item : TElMTreeItem);
  var
    FSaveKey,
    S : string;
    i, j : integer;
    FCComp : TObject;
    PropData : PElPropData;
    PropInfo : PPropInfo;
    Obj      : TObject;
    Form     : TForm;
    {$ifdef LMD_UNICODE}
    WS       : WideString;
    AnsiStr  : AnsiString;
    {$endif}
  begin
    //if FComp = nil then exit;
    FSaveKey := FStorage.CurrentKey;
    if FStorage.OpenKey(Path, true) then
    begin
      for i := 0 to Item.List.Count - 1 do // Iterate
      begin
        PropData := PElPropData(TElMTreeItem(Item.List[i]).Data);
        if PropData.PropType = estComp then
        begin
          Form := LMDGetOwnerForm(Self);
          if Assigned(Form) then
          begin
            if FComp = nil then
              FCComp := LMDGetOwnerForm(Self).FindComponent(PropData.Name)
            else
              FCComp := TObject(GetOrdProp(FComp, GetPropInfo(FComp.ClassInfo, PropData.Name)));
              if FCComp <> nil then
            begin
              if PropData.Store then
              begin
                if FStorage.OpenKey(Storage.CurrentKey + Storage.Delimiter + PropData.Name, true) then
                  ElPropTools.StoreObject(FCComp, FStorage)
              end
              else
                IntSaveProps(FCComp,
                  Storage.CurrentKey + Storage.Delimiter + PropData.Name,
                  TElMTreeItem(Item.List[i]));
            end;
          end;
        end
        else
        if PropData.PropType = estCollection then
        begin
          S := Copy(PropData.Name, 1, Pos('<', PropData.Name) - 1);
          PropInfo := GetPropInfo(FComp.ClassInfo, S);
          if (PropInfo.PropType^.Kind = tkClass) then
          begin
            FCComp := TObject(Pointer(GetOrdProp(FComp, PropInfo)));
            if FCComp is TCollection then
            begin
              // get the index
              j := Pos('<', PropData.Name);
              j := StrToIntDef(Copy(PropData.Name, j + 1, Pos('>', PropData.Name) - j - 1), - 1);
              if (j >= 0) and (j < TCollection(FCComp).Count) then
              begin
                FCComp := TCollection(FCComp).Items[j];
                if PropData.Store then
                  ElPropTools.StoreObject(FCComp, FStorage)
                else
                  IntSaveProps(FCComp,
                               Storage.CurrentKey + Storage.Delimiter + PropData.Name,
                               TElMTreeItem(Item.List[i]));
              end;
            end;
          end;
        end
        else
        begin
          PropInfo := GetPropInfo(FComp.ClassInfo, PropData.Name);
          if PropInfo <> nil then
          begin
            case PropInfo.PropType^.Kind of
              {$ifdef LMD_UNICODE}
              tkWString:
                StoreWideStringProperty(FComp, PropInfo, Storage);
              {$endif}
              tkString,
                tkLString:
                StoreStringProperty(FComp, PropInfo, Storage);
              tkEnumeration,
                tkInteger: StoreIntegerProperty(FComp, PropInfo, Storage);
              tkSet: StoreSetProperty(FComp, PropInfo, Storage);
              tkFloat: StoreFloatProperty(FComp, PropInfo, Storage);
              tkClass:
                begin
                  Obj := TObject(Pointer(GetOrdProp(FComp, PropInfo)));
                  if Obj <> nil then
                  begin
                    if Obj is TStrings then                                                   //D2009
                      Storage.WriteMultiString('', String(PropInfo.Name), TStrings(Obj))      //Att:REG_MULTI_SZ type does not allow empty strings
                    {$ifdef LMD_UNICODE}                                                      //Writing text with empty strings will TRUNCATE text on first empty string because #0 terminates string and #0#0 terminates text.
                    else
                      if Obj is TLMDWideStrings then                                          //D2007 and lower
                        begin
                          //StoreWideStringList(TLMDWideStrings(Obj), String(PropInfo.Name), Storage); //outcommented VB March 2009
                          WS := TLMDWideStrings(Obj).Text;                                    //In D2007 and lower empty strings will be saved and read to registry
                          LMDConvertUTF16toUTF8(WS, AnsiStr, strictConversion, false);        //without truncating because of LMDConvertUTF16toUTF8 encoding.
                          Storage.WriteString('', String(PropInfo.Name), string(AnsiStr));    //To do: unify handling
                        end;
                    {$endif}
                  end;
                end;
            end; // case
          end; // if
        end; // if
      end; // for
    end;
    FStorage.OpenKey(FSaveKey, false);
  end;

begin
  if Assigned(LMDGetOwnerForm(Self)) then
     if (epoProperties in FPersistOptions) and (Assigned(FStorage)) and (not (csDesigning in ComponentState)) then
       IntSaveProps(nil, StoragePath + Storage.Delimiter + LMDGetOwnerForm(Self).Name, FProps.Root);
end; {SaveProps}

procedure TElFormPersist.RestoreProps;

  procedure IntLoadProps(FComp : TObject; Path : string; Item : TElMTreeItem);
  var
    FSaveKey : string;
    i, j     : integer;
    FCComp   : TObject;
    PropData : PElPropData;
    PropInfo : PPropInfo;
    Obj      : TObject;
    Form     : TForm;
    S        : string;
{$ifdef LMD_UNICODE}
    WS       : WideString;
{$endif}
  begin
    //if FComp = nil then exit;
    FSaveKey := FStorage.CurrentKey;
    if FStorage.OpenKey(Path, false) then
    begin
      for i := 0 to Item.List.Count - 1 do // Iterate
      begin
        PropData := PElPropData(TElMTreeItem(Item.List[i]).Data);
        if PropData.PropType = estComp then
        begin
          Form := LMDGetOwnerForm(Self);
          if Assigned(Form) then
          begin
            if FComp = nil then
              FCComp := LMDGetOwnerForm(Self).FindComponent(PropData.Name)
            else
              FCComp := TObject(GetOrdProp(FComp, GetPropInfo(FComp.ClassInfo, PropData.Name)));
              if FCComp <> nil then
            begin
              if PropData.Store then
              begin
                if FStorage.OpenKey(Storage.CurrentKey + Storage.Delimiter + PropData.Name, false) then
                  ElPropTools.LoadObject(FCComp, FStorage)
              end
              else
                IntLoadProps(FCComp,
                  Storage.CurrentKey + Storage.Delimiter + PropData.Name,
                  TElMTreeItem(Item.List[i]));
            end;
          end;
        end
        else
        if PropData.PropType = estCollection then
        begin
          S := Copy(PropData.Name, 1, Pos('<', PropData.Name) - 1);
          PropInfo := GetPropInfo(FComp.ClassInfo, S);
          if (PropInfo.PropType^.Kind = tkClass) then
          begin
            FCComp := TObject(Pointer(GetOrdProp(FComp, PropInfo)));
            if FCComp is TCollection then
            begin
              // get the index
              j := Pos('<', PropData.Name);
              j := StrToIntDef(Copy(PropData.Name, j + 1, Pos('>', PropData.Name) - j - 1), - 1);
              if (j >= 0) and (j < TCollection(FCComp).Count) then
              begin
                FCComp := TCollection(FCComp).Items[j];
                if PropData.Store then
                  ElPropTools.LoadObject(FCComp, FStorage)
                else
                  IntLoadProps(FCComp,
                               Storage.CurrentKey + Storage.Delimiter + PropData.Name,
                               TElMTreeItem(Item.List[i]));
              end;
            end;
          end;
        end
        else
        begin
          PropInfo := GetPropInfo(FComp.ClassInfo, PropData.Name);
          if PropInfo <> nil then
          begin
            case PropInfo.PropType^.Kind of
              {$ifdef LMD_UNICODE}
              tkWString:
                LoadWideStringProperty(FComp, PropInfo, Storage);
              {$endif}
              tkString,
                tkLString : LoadStringProperty(FComp, PropInfo, Storage);
              tkEnumeration,
                tkInteger : LoadIntegerProperty(FComp, PropInfo, Storage);
              tkSet : LoadSetProperty(FComp, PropInfo, Storage);
              tkFloat : LoadFloatProperty(FComp, PropInfo, Storage);
              tkClass :
                begin
                  Obj := TObject(Pointer(GetOrdProp(FComp, PropInfo)));
                  if Obj <> nil then
                  begin
                    if Obj is TStrings then
                      Storage.ReadMultiString('', String(PropInfo.Name), TStrings(Obj))
                    {$ifdef LMD_UNICODE}
                    else
                    if Obj is TLMDWideStrings then
                    begin
                      Storage.ReadString('', String(PropInfo.Name), '', S);
                      LMDConvertUTF8ToUTF16(AnsiString(S), WS, strictConversion, false);
                      TLMDWideStrings(Obj).Text := WS;
//                      SetWideStrProp(FComp, PropInfo, WS);
                    end
                    {$endif}
                    else
                    if Obj is TCollection then
                    begin
                    end;
                  end;
                end;
            end; // case
          end; // if
        end; // if
      end; // for
    end;
    FStorage.OpenKey(FSaveKey, false);
  end;

begin
  if Assigned(LMDGetOwnerForm(Self)) then
     if (epoProperties in FPersistOptions) and (Assigned(FStorage)) and (not (csDesigning in ComponentState)) then IntLoadProps(nil, FStoragePath + Storage.Delimiter + LMDGetOwnerForm(Self).Name, FProps.Root);
end; {RestoreProps}

procedure TElFormPersist.DefineProperties(Filer : TFiler);
begin
  inherited DefineProperties(Filer);
  Filer.DefineBinaryProperty('PropsToStore', ReadPropsList, WritePropsList, true);
  with GetElReader do
    Filer.DefineProperty('Flipped', FakeBoolean, nil, false);
end; { DefineProperties }

procedure TElFormPersist.ReadPropsList;
begin
  FProps.LoadFromStream(Stream);
end; {ReadPropsList}

procedure TElFormPersist.WritePropsList;
begin
  FProps.SaveToStream(Stream);
end; {WritePropsList}

function TElFormPersist.GetPropsToStore : TElMTree;
begin
  result := FProps;
end; {GetPropsToStore}

procedure TElFormPersist.SetTopMost(Value : Boolean);
begin
  if (FTopMost <> Value) then
  begin
    FTopmost := Value;
    ATopmost.TopMost := Value;
  end; {if}
end; {SetTopMost}

procedure TElFormPersist.Loaded;
//var
//  Form : TForm;
//  OnSmth : TNotifyEvent;
begin
  inherited;
  (*
  Form := LMDGetOwnerForm(Self);
  if (not (csDesigning in ComponentState)) and Assigned(Form) then
  begin
    OnSmth := FormShow;
    if ((@Form.OnShow) <> (@FOnShow)) and ((@Form.OnShow) <> @OnSmth) then
        FOnShow := Form.OnShow;
    Form.OnShow := FormShow;
    OnSmth := FormDestroy;
    if ((@Form.OnDestroy) <> @FOnDestroy) and ((@Form.OnDestroy) <> @OnSmth) then
        FOnDestroy := Form.OnDestroy;
    Form.OnDestroy := FormDestroy;
    OnSmth := FormHide;
    if ((@Form.OnHide) <> (@FOnHide)) and ((@Form.OnHide) <> @OnSmth)  then
        FOnHide := Form.OnHide;
    Form.OnHide := FormHide;

    {FOnShow := Form.OnShow;
    Form.OnShow := FormShow;
    FOnHide := Form.OnHide;
    Form.OnHide := FormHide;
    FOnDestroy := Form.OnDestroy;
    Form.OnDestroy := FormDestroy;}
  end;
  *)
  if Topmost then
  begin
    FTopmost := false;
    Topmost := true;
  end;
  if Flipped then
    DoFlip(FFlipped);
end; {Loaded}

destructor TElFormPersist.Destroy;
begin
  Active := false;
  FHook.Free;
  FMinMaxInfo.Free;
  FProps.Free;
  inherited Destroy;
end;

constructor TElFormPersist.Create(AOwner : TComponent);
var
  TWP  : TWindowPlacement;
  Form : THackForm;
  begin
  inherited Create(AOwner);
  FHook := TElHook.Create(nil);
  Form := THackForm(LMDGetOwnerForm(AOwner));
  if Assigned(Form) then
     Form.FreeNotification(Self);
  FHook.Control := Form;
  FHook.OnBeforeProcess := OnHook;
  FHook.OnAfterProcess := OnAfterHook;
  FMinMaxInfo := TElMinMaxInfo.Create;
  FMinMaxInfo.FOwner := Self;
  FActive := True;
  ATopmost := TElTopmost.Create(Self);
  if (FHook.Control <> nil) and Assigned(Form) and (Form.HandleAllocated) then
  begin
    TWP.length := sizeof(TWP);
    GetWindowPlacement(TWinControl(FHook.Control).Handle, @TWP);
    if TWP.showCmd = SW_SHOWNORMAL then FSaveSize := FHook.Control.BoundsRect;
  end;
  if not (csDesigning in ComponentState) then
     FHook.Active := True;
  PersistOptions := [epoSize, epoState, epoPosition];
  FProps := TElMTree.Create;
  FProps.OnItemSave := OnSavePropData;
  FProps.OnItemLoad := OnLoadPropData;
  FProps.OnItemDelete := OnDelPropData;
end;

procedure TElFormPersist.SetFlipped(Value: Boolean);
begin
  if (FFlipped <> value) then
  begin
    if not ((csDesigning in ComponentState) or (csLoading in ComponentState)) then
    begin
      if Value then
      begin
        DoFlip(true);
        FFlipped := true;
      end
      else
      begin
        FFlipped := false;
        DoFlip(false);
      end;
    end
    else
      FFlipped := Value;
  end;
end;

procedure TElFormPersist.DoFlip(Flip : boolean);
var AForm: TForm;

    function CalcHeight : integer;
    begin
      result := 0;

      case AForm.BorderStyle of
        bsToolWindow,
          bsSingle,
          bsDialog:
            Inc(Result, GetSystemMetrics(SM_CYFIXEDFRAME) shl 1);
        bsSizeToolWin,
          bsSizeable:
            Inc(Result, GetSystemMetrics(SM_CYSIZEFRAME) shl 1);
      end;

      if (AForm.BorderStyle in [bsToolWindow, bsSizeToolWin]) then
        Inc(Result, GetSystemMetrics(SM_CYSMCAPTION) - 1)
      else
        Inc(Result, GetSystemMetrics(SM_CYCAPTION) - 1);
    end;

begin
  AForm := LMDGetOwnerForm(Self);
  if AForm = nil then
    exit;
  if not Flip then
  begin
    AForm.ClientHeight := RealDims.Bottom - RealDims.Top;
  end
  else
  begin
    RealDims := AForm.BoundsRect;
    AForm.Height := CalcHeight;
  end;
end;

(*
function TopWndProc(This : TObject; var Message: TMessage): boolean;
var i : integer;
begin
  if (Message.Msg = WM_ACTIVATEAPP) and (Message.wParam = 0) then
  begin
    PostMessage(Application.Handle, CM_DEACTIVATE, 0, 0);
    if FormPersList <> nil then
      for i := 0 to FormPersList.Count - 1 do
        TElFormPersist(FormPersList[i]).UpdateTopMost;
    Message.Msg := WM_NULL;
  end;
  result := false;
end;
*)

(*
var HookMethod : TMethod;

initialization

  HookMethod.Code := @TopWndProc;
  HookMethod.Data := nil;
  Application.HookMainWindow(TWindowHook(HookMethod));
  FormPersList := TElList.Create;

finalization
  Application.UnhookMainWindow(TWindowHook(HookMethod));
  FormPersList.Free;
  FormPersList := nil;
*)

end.
