unit LMDEditAutoComplete;
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

LMDEditAutoComplete unit (JH)
-----------------------------

Component which can be linked from edit controls for adding auto suggest / complete 
support on typing Currently: Only user string lists are supported

The control which uses this component has to call the component's methods. 
This means this control is more a container for settings as a standalone component. 
It will even not work if the edit component does not call the component's methods 
according to this component's settings!

Changes
-------
Release 8.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Windows,
  Classes,
  Controls,
  Messages,
  LMDStringList,
  LMDBaseEdit,
  LMDCont,
  LMDTypes,
  LMDCustomComponent;

type
  TLMDAutoCompleteSource = (asStringList //use a StringList as lookup source
                            );
  TLMDAutoCompleteSources = set of TLMDAutoCompleteSource;
  TLMDAutoCompleteMode = (amText,  //add suggestion to the text in the edit, highlight the added chars
                          amPopup  //popup window with all strings in the source which match the current input
                         );
  TLMDAutoCompleteModes = set of TLMDAutoCompleteMode;
  TLMDAutoCompleteAddOn = (aaControlExit, //add unknown strings to the lookupsource if the control looses the focus
                           aaControlReturn //add unknown strings to the lookupsource if the return key is pressed in the control
                          );
  TLMDAutoCompleteAddOns = set of TLMDAutoCompleteAddOn;

  //parameters
  // - Sender: instance of TLMDEditAutoComplete calling the event handler
  // - editControl: LMDBaseEdit descendant editcontrol which tries to add a string to the lookup source
  // - addText: the string which shall be added
  // - add: default true, set to false if the string shall not be added
  // - addTo: lookup source the string shall be added to
  TLMDAutoCompleteAddEvent = procedure (Sender: TObject; editControl: TLMDBaseEdit; var addText: String; var add: Boolean; var addTo: TLMDAutoCompleteSource) of object;
  TLMDAutoCompleteSelEvent = procedure (Sender: TObject; editControl: TLMDBaseEdit; Text: String) of object;

  TLMDEditAutoComplete = class (TLMDCustomComponent)
  private
    FCaseSensitive,
    FEnabled       : Boolean;
    FBuffered      : String;
    FStringList    : TLMDStringList;
    FDropDownRows,
    FStrListIndex  : Integer;
    FSource        : TLMDAutoCompleteSources;
    FMode          : TLMDAutoCompleteModes;
    FAdd           : TLMDAutoCompleteAddOns;
    FOnAdd         : TLMDAutoCompleteAddEvent;
    fOnSel         : TLMDAutoCompleteSelEvent;
    FEdit          : TLMDBaseEdit;
    FPopupWindow   : TWinControl;
    FControlWndProc    : TFarProc;
    FControlOldWndProc : TFarProc;
    fIsExact       : Boolean;     

    procedure SetStringList (aValue: TLMDStringList);
    procedure SetStrListIndex (aValue: Integer);
    function getS (const s: String): String;
    procedure CMCancelMode(var Message: TCMCancelMode); message CM_CANCELMODE;
    procedure WMCancelMode (var Msg: TWMCancelMode); message WM_CANCELMODE;
    procedure WMKillFocus (var Msg : TWMKillFocus); message WM_KILLFOCUS;
  protected
    procedure Popup (anEditControl: TLMDBaseEdit; aText: String);
    procedure ControlWndProc(var Message: TMessage); virtual;
    procedure ListBoxMouseUp(Sender: TObject;
       Button: TMouseButton; Shift: TShiftState; X, Y: Integer); virtual;    
    procedure Notification (AComponent: TComponent; Operation: TOperation); override;
    //source to be looked up
    property Source: TLMDAutoCompleteSources read FSource write FSource;
  public
    constructor Create (aOwner: TComponent); override;
    procedure CancelPopup;
    procedure CreatePopup (anEditcontrol: TLMDBaseEdit; strings: TStrings);
    procedure SetControl (anEditcontrol: TLMDBaseEdit);
    function CompleteText (anEditControl: TLMDBaseEdit; aText: String): String;
    procedure AutoCompleteText (anEditControl: TLMDBaseEdit; aText: String);
    procedure Add (anEditControl: TLMDBaseEdit; aText: String);
  published
    property About;
    property StringList: TLMDStringList read FStringList write SetStringList;
    property StringListIndex:  Integer read FStrListIndex write SetStrListIndex;
    property Mode: TLMDAutoCompleteModes read FMode write FMode;
    //if an unknown string has been entered in the control this can be added to
    //the lookup source. This property sets up on which events the string shall
    //be added
    property AddUnknownOn: TLMDAutoCompleteAddOns read FAdd write FAdd;
    property CaseSensitive: Boolean read FCaseSensitive write FCaseSensitive default true;    
    property Enabled: Boolean read FEnabled write FEnabled default true;
    //This event can be used for checking the strings to be added according
    //to the AddUnknownOn property
    property OnAdd: TLMDAutoCompleteAddEvent read FOnAdd write FOnAdd;
    property OnSelect: TLMDAutoCompleteSelEvent read fOnSel write fOnSel;

    property IsExact: Boolean read fIsExact write fIsExact default false;
  end;

implementation

uses
  Types, Forms, SysUtils, StdCtrls,
  LMDUtils;

{ ---------------------------------- private --------------------------------- }
procedure TLMDEditAutoComplete.SetStringList (aValue: TLMDStringList);
begin
  FStringList := aValue;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDEditAutoComplete.SetStrListIndex (aValue: Integer);
begin
  if Assigned (FStringList) then
    begin
      FStrListIndex := aValue;
      if FStrListIndex >= FStringList.Count then
        FStrListIndex := FStringList.Count - 1;
    end;
end;

{ ---------------------------------------------------------------------------- }
function TLMDEditAutoComplete.getS (const s: String): String;
begin
  if FCaseSensitive then
    result := s
  else
    result := UpperCase (s);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDEditAutoComplete.CMCancelMode(var Message: TCMCancelMode);
begin
  inherited;
  CancelPopup;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDEditAutoComplete.WMCancelMode (var Msg: TWMCancelMode);
begin
  inherited;
  CancelPopup;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDEditAutoComplete.WMKillFocus (var Msg : TWMKillFocus);
begin
  inherited;
  CancelPopup;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDEditAutoComplete.Popup (anEditControl: TLMDBaseEdit; aText: String);
var
  FStrings: TStringList;
  i       : Integer;
begin
  FStrings := TStringList.Create;
  try
    if asStringList in FSource then
      begin
        if Assigned (FStringList) then
          begin
            FStrings.Assign (FStringList[FStrListIndex].Items);
            FStrings.Sort;
            //find first matching to the given string
            while (FStrings.Count > 0) and (Pos (getS(aText), getS(FStrings[0])) <> 1) do
              FStrings.Delete (0);
            i := 0;
            //find last matching item
            while (FStrings.Count > 0) and (i < FStrings.Count) and
                  (Pos (getS(aText), getS(FStrings[i])) = 1) do
              inc (i);
            //delete not matching rest of items
            while FStrings.Count > i do FStrings.Delete (FStrings.Count - 1);
          end;
      end;
      with anEditControl do
        begin
          CreatePopup (anEditControl, FStrings);
        end;
  finally
    FStrings.Free;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDEditAutoComplete.ListBoxMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  with (FPopupWindow as TListBox) do
   begin
     ItemIndex :=   ItemAtPos(Point(X, Y), true);
     if ItemIndex <> -1 then
       FEdit.Text := Items[ItemIndex];
     FEdit.CurrentChar := Length (FEdit.Text) + 1;
     FEdit.SelectAll;
     if Assigned(fOnSel) then fOnSel(Self, FEdit, FEdit.Text);
     CancelPopup;
   end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDEditAutoComplete.ControlWndProc(var Message: TMessage);

        procedure setEdit;
        begin
          FEdit.CurrentChar := Length (FEdit.Text) + 1;
          FEdit.SelectAll;
        end;

begin
  Message.Result := CallWindowProc (FControlOldWndProc, FEdit.Handle, Message.Msg, Message.wParam, Message.lParam);
  case Message.Msg of
    WM_MOUSEWHEEL:
              with (FPopupWindow as TListBox) do
                begin
                  if short(Message.wParamHi) > 0 then
                    begin
                      if ItemIndex > 0 then
                        ItemIndex := ItemIndex - 1;
                    end
                  else
                    begin
                      if ItemIndex < Items.Count - 1 then
                        ItemIndex := ItemIndex + 1;
                    end;
                  FEdit.Text := Items[ItemIndex];
                  setEdit;
                end;
    WM_KEYUP:
              case Message.wParam of
              VK_UP :  with (FPopupWindow as TListBox) do
                           begin
                             if ItemIndex > 0 then
                               ItemIndex := ItemIndex - 1;
                             FEdit.Text := ITems[ItemIndex];
                             setEdit;
                           end;
                VK_DOWN: with (FPopupWindow as TListBox) do
                           begin
                             ItemIndex := ItemIndex + 1;
                             FEdit.Text := ITems[ItemIndex];
                             setEdit;
                           end;
              end;
    WM_CHAR :
              case Message.wParam of
					            VK_RETURN, VK_SPACE: with (FPopupWindow as TListBox) do
                                   begin
                                     if ItemIndex <> -1 then
                                       FEdit.Text := Items[ItemIndex];
                                     setEdit;
                                     if Assigned(fOnSel) then fOnSel(Self, FEdit, FEdit.Text);
                                     CancelPopup;
                                   end;
                      VK_ESCAPE: begin
                                   FEdit.Text := FBuffered;
                                   setEdit;
                                   CancelPopup;
                                 end;
                    end;
    WM_KILLFOCUS  : begin
                      FEdit.Text := FBuffered;
                      setEdit;
                      CancelPopup;
                    end;
    WM_CANCELMODE : begin
                      FEdit.Text := FBuffered;
                      setEdit;
                      CancelPopup;
                    end;
  end;
end;

{ ---------------------------------- public ---------------------------------- }
procedure TLMDEditAutoComplete.Notification (AComponent: TComponent; Operation: TOperation);
begin
  inherited Notification (AComponent, Operation);
end;

{ ---------------------------------------------------------------------------- }
constructor TLMDEditAutoComplete.Create (aOwner: TComponent);
begin
  inherited Create (aOwner);
  FEnabled := true;
  FSource := [asStringList];
  FCaseSensitive := true;
  FDropDownRows := 8;
  FControlOldWndProc := nil;  
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDEditAutoComplete.CancelPopup;
begin
  // 7.01
  if FPopupWindow=nil then exit;
  // ----
  SetWindowLong (FEdit.Handle, GWL_WNDPROC, TLMDPtrInt(FControlOldWndProc));
  FControlOldWndProc := nil;
  FEdit := nil;
  Classes.FreeObjectInstance (FControlWndProc);
  FControlWndProc := nil;
  if Assigned (FPopupWindow) then
    FreeAndNil(FPopupWindow);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDEditAutoComplete.CreatePopup (anEditControl: TLMDBaseEdit; strings: TStrings);
var
  rd,
  rh: Integer;
  p: TPoint;
  h: HWND;
begin
  if strings.Count = 0 then exit;

  if (strings.Count = 1) and (getS(strings[0]) = getS(anEditControl.Text)) then
    begin
      CancelPopup;
      exit;
    end;

  if not Assigned (FPopupWindow) then
    begin
      FPopupWindow := TListBox.Create (self);
      FPopupWindow.Visible := false;
    end;

  if not Assigned (FControlWndProc) then
    FControlWndProc := Classes.MakeObjectInstance (ControlWndProc);

  FPopupWindow.Parent := anEditControl;

  FEdit := anEditControl;

  if not Assigned(FControlOldWndProc) then
    begin
      //set custom message handler
      FControlOldWndProc := TFarProc(GetWindowLong (anEditControl.Handle, GWL_WNDPROC));

      SetWindowLong (anEditControl.Handle, GWL_WNDPROC, TLMDPtrInt(FControlWndProc));

    end;

  p := Point (0, anEditcontrol.Height);
  p := anEditcontrol.ClientToScreen (p);

  Windows.SetParent(FPopupWindow.Handle, GetDesktopWindow);

  SetWindowLong (FPopupWindow.Handle, GWL_EXSTYLE, WS_EX_TOOLWINDOW);
  SetWindowLong (FPopupWindow.Handle, GWL_STYLE, GetWindowLong (FPopupWindow.Handle, GWL_STYLE) or WS_BORDER);

  TListBox(FPopupWindow).OnMouseUp := ListBoxMouseUp;

  h := HWND_TOPMOST;
  SetWindowPos(FPopupWindow.Handle, h, p.x, p.y, anEditControl.Width, FPopupWindow.Height,
               SWP_NOACTIVATE or SWP_SHOWWINDOW
               );

//  rh := 10;
  with FPopupWindow as TListBox do
    begin
      Items.Clear;
      Items.Assign (strings);
      rh := Canvas.TextHeight (strings[0]);
    end;

  if strings.Count < FDropDownRows then
    rd := strings.Count
  else
    rd := FDropDownRows;
  FPopupWindow.Height := (rd * rh) + 5;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDEditAutoComplete.SetControl (anEditcontrol: TLMDBaseEdit);
begin
end;

{ ---------------------------------------------------------------------------- }
function TLMDEditAutoComplete.CompleteText (anEditControl: TLMDBaseEdit; aText: String): String;
var
  i : Integer;
//  FH: TStringList;

  function find: Integer;
  var
    i : Integer;
    txt:  string;
  begin
    result := -1;
    i := 0;
    txt := getS(aText);
    while (result = -1) and (i < FStringList[FStrListIndex].Items.Count) do
      begin
		if not fIsExact then
        begin
          if Pos(txt, getS(FStringList[FStrListIndex].Items[i])) = 1 then
          begin
            result := i;
            Exit;
          end;
        end
        else
          if txt = getS(FStringList[FStrListIndex].Items[i]) then
          begin
            Result := i;
            Exit;
          end;
        inc(i);
      end;
  end;

begin
  result := aText;
  FBuffered := aText;
  if amText in FMode then
    begin
      i := -1;
      if Assigned (FStringList) then
        i := find;
      if i <> -1 then
        result := FStringList[FStrListIndex].Items[i];
    end;
  if amPopup in FMode then
    if (FBuffered <> '') then
      popup (anEditControl, FBuffered) //FBuffered instean of result, Feb 03, JH
    else
      CancelPopup;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDEditAutoComplete.AutoCompleteText (anEditControl: TLMDBaseEdit; aText: String);
var
  s: String;
begin
  if not enabled then exit;
  s := completeText (anEditControl, aText);
  if getS(s) = getS(aText) then exit; //nothing to do
  anEditControl.Text := s; //set the currently retrieved suggestion
  //select auto added part of text, if a user presses the next key the
  //selected text will be replaced ...
  //anEditControl.SelStart := Length (aText);
  anEditControl.CurrentChar := Length (aText)+1;
  anEditControl.SelLength := Length (s) - Length (aText);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDEditAutoComplete.Add (anEditControl: TLMDBaseEdit; aText: String);
var
  addIt: Boolean;
  source: TLMDAutoCompleteSource;
  i: Integer;
begin
  if not enabled then exit;

  //set default values for the event
  addIt := true;
  source := asStringList;

  //check whether string is already in list?
  if (source = asStringList) and Assigned (FStringList) then
    begin
      for i := 0 to FStringList[FStrListIndex].Items.Count - 1 do
        if getS (aText) = getS (FStringList[FStrListIndex].Items[i]) then
          exit;
    end;

  if Assigned (FOnAdd) then FOnAdd (self, anEditControl, aText, addIt, source);
  if addIt then
    begin
      if (source = asStringList) and Assigned (FStringList) then
        begin
          FStringList[FStrListIndex].Items.Add (aText);
        end;
    end;
end;

end.
