(* Terminal - terminal library
 * Copyright (C) 1999-2003  Tomas Mandys-MandySoft
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Lesser General Public
 * License as published by the Free Software Foundation; either
 * version 2.1 of the License, or (at your option) any later version.
 *
 * This library is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public
 * License along with this library; if not, write to the Free Software
 * Foundation, Inc., 59 Temple Place, Suite 330,
 * Boston, MA  02111-1307  USA
 *)

{ URL: http://www.2p.cz }

unit Terminal;
{HTX: -oProt}

{ Terminal.htx }

interface
uses
  {$IFDEF LINUX}Qt, Types, Libc, QGraphics, QControls, QForms, QStdCtrls, {$ELSE}Windows, Messages, Graphics, Controls, Forms, StdCtrls, {$ENDIF}SysUtils, Classes, SyncObjs;

const
  CR = #13;
  LF = #10;

type
  TTerminal = class;

  TTerminalThread = class(TThread)
  private
    FTerminal: TTerminal;
    FLogBuffer: TStrings;
    FLogTermBuffer: string;
    FEvent: TSimpleEvent;
    FCriticalSection: TCriticalSection;
    fInsertedFromLogBuffer: Boolean;
  protected
    procedure Execute; override;
    procedure Terminate;
    procedure DoOnSignal;
  public
    constructor Create(aTerminal: TTerminal);
    destructor Destroy; override;
  end;

  TTerminal = class(TCustomMemo)
  private
    FTermXPos: Integer;
    FMaxLines: Integer;
    FTermThread: TTerminalThread;
  protected
    procedure LogTermChar(C: Char; aLines: TStrings); virtual;
    procedure CheckLines(aLines: TStrings);
    {$IFDEF LINUX}
    function EventFilter(Sender: QObjectH; Event: QEventH): Boolean; override;
    procedure CMKeyDown(var Msg: TCMKeyDown); message CM_KEYDOWN;
    {$ENDIF}
  public
    constructor Create(aOwner: TComponent); override;
    destructor Destroy; override;
    procedure Log(const S: string);
    procedure LogErr(const S1, S2: string);
    procedure LogTerm(const S: string);
    published
    property MaxLines: Integer read FMaxLines write FMaxLines;
    property Align;
    property Alignment;
    property Anchors;
    property BorderStyle;
    property Color;
    property Constraints;
    property DragMode;
    property Enabled;
    property Font;
    property Lines;
    property MaxLength;
    property ParentColor;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ScrollBars;
    property ShowHint;
    property TabOrder;
    property TabStop;
    property Visible;
    property WantReturns;
    property WantTabs;
    property OnChange;
    property OnClick;
    property OnContextPopup;
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
    {$IFDEF LINUX}
    property HMargin;
    property WrapAtValue;
    property WrapBreak;
    property WrapMode;
    property OnKeyString;
    property OnMouseEnter;
    property OnMouseLeave;
    {$ENDIF}
  end;

procedure Register;

implementation
uses
  AuxStr;

{$IFDEF LINUX}
const
  INFINITE = $FFFFFFFF;
{$ENDIF}

constructor TTerminalThread.Create;
begin
  FTerminal:= aTerminal;
  FreeOnTerminate := True;
  FEvent := TSimpleEvent.Create;
  FCriticalSection:= TCriticalSection.Create;
  FLogBuffer:= TStringList.Create;
  inherited Create(False);
  {$IFNDEF LINUX}
  Priority := tpHigher;
  {$ENDIF}
end;

destructor TTerminalThread.Destroy;
begin
  FEvent.Free;
  FCriticalSection.Free;
  FLogBuffer.Free;
  Inherited Destroy;
end;

procedure TTerminalThread.Execute;
begin
  while not Terminated do
  begin
    FEvent.WaitFor(INFINITE);
    if not Terminated then
    begin
      FEvent.ResetEvent;
      Synchronize(DoOnSignal);
    end;
  end;
end;

procedure TTerminalThread.Terminate;
begin
  inherited;
  FEvent.SetEvent;
end;

procedure TTerminalThread.DoOnSignal;
var
  Sg: TStrings;
  I, N: Integer;
{$IFDEF LINUX}
  CP: TCaretPos;
{$ENDIF}
begin
  Sg:= TStringList.Create;
  try
    Sg.Assign(fTerminal.Lines);
    while FLogBuffer.Count <> 0 do
    begin
      FCriticalSection.Enter;
      try
        Sg.Add(FLogBuffer[0]);
        FLogBuffer.Delete(0);
        FTerminal.FTermXPos:= 0;
        fInsertedFromLogBuffer:= True;
      finally
        FCriticalSection.Leave;
      end;
    end;
    FTerminal.CheckLines(Sg);
    N:= Length(FLogTermBuffer);  // multi thread
    if N > 0 then
    begin
      if fInsertedFromLogBuffer then
        Sg.Add('');
      fInsertedFromLogBuffer:= False;
    end;
    for I:= 1 to N do
      FTerminal.LogTermChar(FLogTermBuffer[I], Sg);
    FCriticalSection.Enter;
    try
      Delete(FLogTermBuffer, 1, N);
    finally
      FCriticalSection.Leave;
    end;
    fTerminal.Lines.BeginUpdate;
    try
      if fTerminal.Lines.Text <> Sg.Text then
        fTerminal.Lines.Assign(Sg);
      N:= fTerminal.FTermXPos;
     {$IFDEF LINUX}
      CP.Col:= fTerminal.FTermXPos;
      CP.Line:= Sg.Count-1;
      if fInsertedFromLogBuffer then
        Inc(CP.Line);
     {$ENDIF}
      for I:= 0 to Sg.Count-2 do
        Inc(N, Length(Sg[I])+1{LF}{$IFNDEF LINUX}+1{CR}{$ENDIF});
      if N <> fTerminal.SelStart then
        fTerminal.SelStart:= N;
      fTerminal.SelLength:= 0;
    finally
      fTerminal.Lines.EndUpdate;
    end;
    {$IFDEF LINUX}
    fTerminal.CaretPos:= CP;
    {$ELSE}
    SendMessage(fTerminal.Handle, EM_SCROLLCARET, 0,0); // to scroll to cursor pos
    {$ENDIF}
  finally
    Sg.Free;
  end;
end;

constructor TTerminal.Create;
begin
  inherited;
  FMaxLines:= 100;
  {$IFDEF LINUX}   // in linux is cursor hidden if readonly
  UndoLevels:= 0;
  {$ELSE}
  ReadOnly:= True;
  {$ENDIF}
  WordWrap:= False;
  FTermThread:= TTerminalThread.Create(Self);
end;

destructor TTerminal.Destroy;
begin
  FTermThread.Terminate;
//  FTermThread.WaitFor;
  inherited;
end;

procedure TTerminal.Log;
begin
  if Self = nil then
    Exit;
  FTermThread.FCriticalSection.Enter;
  try
    FTermThread.FLogBuffer.Add(S);
  finally
    FTermThread.FCriticalSection.Leave;
  end;
  FTermThread.FEvent.SetEvent;
end;

procedure TTerminal.LogErr;
begin
  if Self = nil then
    Exit;
  Log(Format('%s: %s', [S1, S2]));
end;

procedure TTerminal.LogTerm;
begin
  if Self = nil then
    Exit;
  FTermThread.FCriticalSection.Enter;
  try
    FTermThread.FLogTermBuffer:= FTermThread.FLogTermBuffer + S;
  finally
    FTermThread.FCriticalSection.Leave;
  end;
  FTermThread.FEvent.SetEvent;
end;

procedure TTerminal.CheckLines;
begin
  while aLines.Count > FMaxLines do
    aLines.Delete(0);
end;

procedure TTerminal.LogTermChar;
var
  S: string;
  I: Integer;
begin
  if aLines.Count = 0 then
    aLines.Add('');
  case C of
    LF: begin
          aLines.Add(ReplSpace(FTermXPos));
        end;
    CR: FTermXPos:= 0;
    #8{BS}: if FTermXPos > 0 then
            begin
              Dec(FTermXPos);
            end;
    else
      S:= aLines[aLines.Count-1];

      I:= FTermXPos+1-Length(S);
      if I > 0 then
        S:= S+ReplSpace(I);
      S[FTermXPos+1]:= C;
      aLines[aLines.Count-1]:= S;
      Inc(FTermXPos);
  end;
end;

{$IFDEF LINUX}
function TTerminal.EventFilter(Sender: QObjectH; Event: QEventH): Boolean;
var
  Key: Integer;
  ShiftState: TShiftState;
begin
  Result:= False;
  case QEvent_type(Event) of
    QEventType_MouseButtonRelease:
      begin
        if QMouseEvent_button(QMouseEventH(Event)) = ButtonState_RightButton then
        begin
        // cannot call protected method from TWidgedControl, only inherited is possible !!!
        //  Result := TWidgetControl.EventFilter(Sender, Event);
        //  Exit;
          ReadOnly:= True;   // omit local menu
          try
            Result := inherited EventFilter(Sender, Event);
          finally
            ReadOnly:= False;
          end;
        end;
      end;
    QEventType_keyPress:
      begin
        if not (csDesigning in ComponentState) then
        begin
          Key := QKeyEvent_key(QKeyEventH(Event));
          ShiftState := ButtonStateToShiftState(QKeyEvent_state(QKeyEventH(Event)));
          ReadOnly:= True;   // omit cut, paste handling in TCustomMemo
          try
            Result := inherited EventFilter(Sender, Event);
          finally
            ReadOnly:= False;
          end;
          if not Result then
            Result:= (ShiftState = [ssCtrl]) and (Key in [Key_V, Key_X]) or
                     (ShiftState = []) and (Key = Key_Delete) ;  // omit cut, paste, delete block
          Exit;
        end
      end;
  end;
  if not Result then
    Result := inherited EventFilter(Sender, Event);
end;

procedure TTerminal.CMKeyDown(var Msg: TCMKeyDown);
var
  K: Char;
begin
  if ((Msg.Key = Key_Return) or (Msg.Key = Key_Enter)) then
  begin
    Msg.Handled := WantReturns;
    if Msg.Handled then
      if Msg.Shift = [ssCtrl] then
      begin
        K:= LF;
        KeyPress(K);
        if K = #0 then
          Exit;
      end;
  end;
  inherited;
end;
{$ENDIF}

procedure Register;
begin
  RegisterComponents('Communication', [TTerminal]);
end;

end.
