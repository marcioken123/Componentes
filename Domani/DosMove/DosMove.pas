//-----------------------------------------------------------------------------
// TDosMove ver 1.02
//
// Last updated at: 09/10/1998
//
// Component that allows you to move thourgh the controls in your app with
//  UP/DOWN arrows or ENTER key insted of using the old boring TAB.
//
// Code by: Liran Shahar
//          Israel
//          simpletech@ibm.net
//-----------------------------------------------------------------------------
unit DosMove;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls;

type
  TMoveOptions = set of (moEnter,moUpDn);

  TDosMove = class(TComponent)
  private
    FActive        : boolean;
    FOptions       : TMoveOptions;
    FEditNoBeep    : boolean;
    FOwnerKeyDown  : TKeyEvent;
    FOwnerKeyPress : TKeyPressEvent;
    FLastWasEdit   : boolean;
  protected
    procedure NewKeyDown(Sender : TObject;var Key : word;Shift : TShiftState);
    procedure NewKeyPress(Sender : Tobject;var Key : char);
  public
    constructor Create(AOwner : TComponent); override;
  published
    property Active : boolean read FActive write FActive 
      default false;
    property Options : TMoveOptions read FOptions write FOptions 
      default [moEnter,moUpDn];
    property EditNoBeep : boolean read FEditNoBeep write FEditNoBeep
      default true;  
  end;

procedure Register;

implementation

//-----------------------------------------------------------------------------
procedure Register;
begin
  RegisterComponents('Domani', [TDosMove]);
end;

//-----------------------------------------------------------------------------
constructor TDosMove.Create(AOwner : TComponent);
var
  Loop : integer;
begin
  // First check to see no other TDosMove exists on the form
  for Loop:=0 to AOwner.ComponentCount-1 do
    if AOwner.Components[Loop] is TDosMove then raise
      EInvalidOperation.Create('TDosMove can have only one instance per form');

  // Create component and set default properties
  inherited Create(AOwner);
  FActive:=false;
  FOptions:=[moEnter,moUpDn];
  FEditNoBeep:=true;
  
  // Intercept with OnKeyDown event and OnKeyPress event of 'Owner'
  (AOwner as TForm).KeyPreview:=true;
  FOwnerKeyDown:=(AOwner as TForm).OnKeyDown;
  (AOwner as TForm).OnKeyDown:=NewKeyDown;
  FOwnerKeyPress:=(AOwner as TForm).OnKeyPress;
  (AOwner as TForm).OnKeyPress:=NewKeyPress;
  
end; // Create

//-----------------------------------------------------------------------------
procedure TDosMove.NewKeyDown(Sender : TObject;var Key : word;
  Shift : TShiftState);
begin
  if FActive then begin
  
    // true if last active control is TCustomEdit and above
    FLastWasEdit:=(Owner as TForm).ActiveControl is TCustomEdit;

    if (FOptions<>[]) then begin

      // Handle the specials keys
      if ((Key=VK_DOWN) and (moUpDn in FOptions)) or
         ((Key=VK_RETURN) and (moEnter in FOptions)) then
        (Owner as TForm).Perform(WM_NEXTDLGCTL,0,0)
      else if (Key=VK_UP) and (moUpDn in FOptions) then
        (Owner as TForm).Perform(WM_NEXTDLGCTL,1,0);
    end; // if Options<>[] ...

  end; // if FActive ...

  // Call owner OnKeyDown if it's assigned
  if assigned(FOwnerKeyDown) then FOwnerKeyDown(Sender,Key,Shift);
end; // NewKeyDown

//-----------------------------------------------------------------------------
procedure TDosMove.NewKeyPress(Sender : TObject;var Key : char);
begin
  if FActive then begin
    // Handle 'Enter' key that makes Edits beep
    if FEditNoBeep and FLastWasEdit and (Key=#13) then Key:=#0;
    
  end; // if FActive ...
        
  // Call owner OnKeyPress if it's assigned
  if assigned(FOwnerKeyPress) then FOwnerKeyPress(Sender,Key);
end; // NewKeyPress

end.
