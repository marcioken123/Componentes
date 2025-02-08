unit ElEditCmds;
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

ElEditCmds unit
---------------

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
  LMDTypes,
  LMDObjectList;

const
  // Navigate commands
  eecLeft = 1;
  eecRight = 2;
  eecUp = 3;
  eecDown = 4;
  eecLineHome = 5;
  eecLineEnd = 6;
  eecNextWord = 7;
  eecPrevWord = 8;
  eecPageUp = 9;
  eecPageDown = 10;
  eecTextHome = 11;
  eecTextEnd = 12;

  // Control commands
  eecUndo = 101;
  eecRedo = 102;
  eecCut = 103;
  eecCopy = 104;
  eecPaste = 105;
  eecDeletePrevChar = 106;
  eecDeleteChar = 107;
  eecDeletePrevWord = 108;
  eecDeleteWord = 109;
  eecChar = 110;
  eecNewLine = 111;
  eecTab = 112;
  eecIndent = 113;
  eecUnIndent = 114;
  eecWideString = 115;

  eecSetBookmark0 = 118;
  eecSetBookmark1 = 119;
  eecSetBookmark2 = 120;
  eecSetBookmark3 = 121;
  eecSetBookmark4 = 122;
  eecSetBookmark5 = 123;
  eecSetBookmark6 = 124;
  eecSetBookmark7 = 125;
  eecSetBookmark8 = 126;
  eecSetBookmark9 = 127;

  eecGotoBookmark0 = 131;
  eecGotoBookmark1 = 132;
  eecGotoBookmark2 = 133;
  eecGotoBookmark3 = 134;
  eecGotoBookmark4 = 135;
  eecGotoBookmark5 = 136;
  eecGotoBookmark6 = 137;
  eecGotoBookmark7 = 138;
  eecGotoBookmark8 = 139;
  eecGotoBookmark9 = 140;
  eecSetStress = 141;

  //Selection commands
  eecSelectCommands = 200;
  eecSelectLeft = 1 + eecSelectCommands;
  eecSelectRight = 2 + eecSelectCommands;
  eecSelectHome = 3 + eecSelectCommands;
  eecSelectEnd = 4 + eecSelectCommands;
  eecSelectPrevAll = 5 + eecSelectCommands;
  eecSelectNextAll = 6 + eecSelectCommands;
  eecSelectPrevWord = 7 + eecSelectCommands;
  eecSelectNextWord = 8 + eecSelectCommands;
  eecSelectUp = 9 + eecSelectCommands;
  eecSelectDown = 10 + eecSelectCommands;
  eecSelectPageUp = 11 + eecSelectCommands;
  eecSelectPageDown = 12 + eecSelectCommands;

  eecSelectAll = 15 + eecSelectCommands;
  eecSelectDelete = 16 + eecSelectCommands;
  eecSelectNone = 17 + eecSelectCommands;

  //Service command
  eecNone = 0;
  eecLastCommand = High(Integer);
  eecWaitForSecondKey = eecLastCommand - 1;

type
  TElCommand = type integer;

  TElKeyCommand = class(TObject)
  private
    function GetShortCut: TShortCut;
  protected
    FKey: word;
    FShiftState: TShiftState;
    // for second key combination like in Borland IDE editor Ctrl+K I
    FKey2: word;
    FShiftState2: TShiftState;

    FCommand: TElCommand;

    FDescription: TLMDString;
  public
    constructor Create(const AKey: word; const AShiftState: TShiftState; const ACommand: TElCommand;
                       const ADescription: TLMDString); overload;
    constructor Create(const AKey: word; const AShiftState: TShiftState;
                       const AKey2: word; const AShiftState2: TShiftState; const ACommand: TElCommand;
                       const ADescription: TLMDString); overload;
    property Key: Word read FKey;
    property ShiftState: TShiftState read FShiftState;
    property Key2: word read FKey2;
    property ShiftState2: TShiftState read FShiftState2;
    property Command: TElCommand read FCommand;
    property Description: TLMDString read FDescription;
    property ShortCut: TShortCut read GetShortCut;
  end;

  TElKeyCommandList = class(TObject)
  protected
    FCommandList: TLMDObjectList;
    function GetCommand(Index: TElCommand): TElKeyCommand;
  public
    constructor Create;
    destructor Destroy; override;
    procedure DefaultKeyBind;
    procedure Add(const AKey: word; const AShiftState: TShiftState; const ACommand: TElCommand;
                  const ADescription: TLMDString); overload;
    procedure Add(const AKey: word; const AShiftState: TShiftState; const AKey2: word;
                  const AShiftState2: TShiftState; const ACommand: TElCommand;
                  const ADescription: TLMDString); overload;
    function Find(AKey: word; AShiftState: TShiftState): TElCommand; overload;
    function Find(const AKey: word; const AShiftState: TShiftState; AKey2: word;
                         const AShiftState2: TShiftState): TElCommand; overload;
    procedure Delete(ACommand: TElCommand);
    property Commands[Index: TElCommand]: TElKeyCommand read GetCommand; default;
  end;

implementation

constructor TElKeyCommand.Create(const AKey: word; const AShiftState: TShiftState; const ACommand: TElCommand;
                                 const ADescription: TLMDString);
begin
  inherited Create;
  FKey := AKey;
  FShiftState := AShiftState;
  FKey2 := 0;
  FShiftState2 := [];
  FCommand := ACommand;
  FDescription := ADescription;
end;

constructor TElKeyCommand.Create(const AKey: word; const AShiftState: TShiftState;
                   const AKey2: word; const AShiftState2: TShiftState; const ACommand: TElCommand;
                   const ADescription: TLMDString);
begin
  inherited Create;
  FKey := AKey;
  FShiftState := AShiftState;
  FKey2 := AKey2;
  FShiftState2 := AShiftState2;
  FCommand := ACommand;
  FDescription := ADescription;
end;

function TElKeyCommand.GetShortCut: TShortCut;
begin
  Result := 0;
  if HiByte(FKey) <> 0 then
    Exit;
  Result := FKey;
  if ssShift in FShiftState then
    Inc(Result, scShift);
  if ssCtrl in FShiftState then
    Inc(Result, scCtrl);
  if ssAlt in FShiftState then
    Inc(Result, scAlt);
end;

{ TElKeyCommandList }

procedure TElKeyCommandList.Add(const AKey: word;
  const AShiftState: TShiftState; const ACommand: TElCommand;
  const ADescription: TLMDString);
begin
  Add(AKey, AShiftState, 0, [], ACommand, ADescription);
end;

procedure TElKeyCommandList.Add(const AKey: word;
  const AShiftState: TShiftState; const AKey2: word;
  const AShiftState2: TShiftState; const ACommand: TElCommand;
  const ADescription: TLMDString);
var
  LCommand: TElKeyCommand;
begin
  LCommand := TElKeyCommand.Create(AKey, AShiftState, AKey2, AShiftState2, ACommand, ADescription);
  FCommandList.Add(LCommand);
end;

constructor TElKeyCommandList.Create;
begin
  inherited;
  FCommandList := TLMDObjectList.Create;
  FCommandList.AutoClearObjects := true;
end;

procedure TElKeyCommandList.DefaultKeyBind;
begin
  Add(VK_LEFT, [], eecLeft, 'Move cursor left');
  Add(VK_LEFT, [ssShift], eecSelectLeft, 'Select previous char');
  Add(VK_LEFT, [ssCtrl], eecPrevWord, 'Move to previous word');
  Add(VK_LEFT, [ssShift, ssCtrl], eecSelectPrevWord, 'Select previous char');

  Add(VK_RIGHT, [], eecRight, 'Move cursor right');
  Add(VK_RIGHT, [ssShift], eecSelectRight, 'Select next char');
  Add(VK_RIGHT, [ssCtrl], eecNextWord, 'Move to next word');
  Add(VK_RIGHT, [ssShift, ssCtrl], eecSelectNextWord, 'Select next word');

  Add(VK_UP, [], eecUp, 'Move cursor up');
  Add(VK_UP, [ssShift], eecSelectUp, 'Select text up');

  Add(VK_DOWN, [], eecDown, 'Move cursor down');
  Add(VK_DOWN, [ssShift], eecSelectDown, 'Select text down');

  Add(VK_NEXT, [], eecPageDown, 'Page down');
  Add(VK_NEXT, [ssShift], eecSelectPageDown, 'Select page down');

  Add(VK_PRIOR, [], eecPageUp, 'Page up');
  Add(VK_PRIOR, [ssShift], eecSelectPageUp, 'Select page up');

  Add(VK_RETURN, [], eecNewLine, 'New line');
  Add(VK_RETURN, [ssCtrl], eecNewLine, 'New line');
  Add(VK_RETURN, [ssShift], eecNewLine, 'New line');

  Add(VK_TAB, [], eecTab, 'Insert Tab symbol');

  Add(VK_HOME, [], eecLineHome, 'Move cursor to begin of line');
  Add(VK_HOME, [ssShift], eecSelectHome, 'Select line before cursor');
  Add(VK_HOME, [ssCtrl], eecTextHome, 'Move cursor to begin of text');
  Add(VK_HOME, [ssShift, ssCtrl], eecSelectPrevAll, 'Select all before cursor');

  Add(VK_END, [], eecLineEnd, 'Move cursor to end of line');
  Add(VK_END, [ssShift], eecSelectEnd, 'Select line after cursor');
  Add(VK_END, [ssCtrl], eecTextEnd, 'Move cursor to end of text');
  Add(VK_END, [ssShift, ssCtrl], eecSelectNextAll, 'Select all before cursor');

  Add(VK_BACK, [], eecDeletePrevChar, 'Delete char before cursor');
  Add(VK_BACK, [ssShift], eecDeletePrevChar, 'Delete char before cursor');
  Add(VK_BACK, [ssCtrl], eecDeletePrevWord, 'Delete word before cursor');
  Add(VK_BACK, [ssAlt], eecUndo, 'Undo');

  Add(VK_DELETE, [], eecDeleteChar, 'Delete char under cursor');
  Add(VK_DELETE, [ssShift], eecCut, 'Cut to clipboard');
  Add(VK_DELETE, [ssCtrl], eecDeleteWord, 'Delete selection');

  Add(VK_INSERT, [ssCtrl], eecCopy, 'Copy to clipboard');
  Add(VK_INSERT, [ssShift], eecPaste, 'Paste from clipboard');

  Add(Ord('K'), [ssCtrl], Ord('I'), [], eecIndent, 'Indent selected text');
  Add(Ord('K'), [ssCtrl], Ord('U'), [], eecUnIndent, 'Unindent selected text');

  Add(Ord('K'), [ssCtrl], Ord('0'), [], eecSetBookmark0, 'Set bookmark 0');
  Add(Ord('K'), [ssCtrl], Ord('1'), [], eecSetBookmark1, 'Set bookmark 1');
  Add(Ord('K'), [ssCtrl], Ord('2'), [], eecSetBookmark2, 'Set bookmark 2');
  Add(Ord('K'), [ssCtrl], Ord('3'), [], eecSetBookmark3, 'Set bookmark 3');
  Add(Ord('K'), [ssCtrl], Ord('4'), [], eecSetBookmark4, 'Set bookmark 4');
  Add(Ord('K'), [ssCtrl], Ord('5'), [], eecSetBookmark5, 'Set bookmark 5');
  Add(Ord('K'), [ssCtrl], Ord('6'), [], eecSetBookmark6, 'Set bookmark 6');
  Add(Ord('K'), [ssCtrl], Ord('7'), [], eecSetBookmark7, 'Set bookmark 7');
  Add(Ord('K'), [ssCtrl], Ord('8'), [], eecSetBookmark8, 'Set bookmark 8');
  Add(Ord('K'), [ssCtrl], Ord('9'), [], eecSetBookmark9, 'Set bookmark 9');

  Add(Ord('Q'), [ssCtrl], Ord('0'), [], eecGotoBookmark0, 'Goto bookmark to 0');
  Add(Ord('Q'), [ssCtrl], Ord('1'), [], eecGotoBookmark1, 'Goto bookmark to 1');
  Add(Ord('Q'), [ssCtrl], Ord('2'), [], eecGotoBookmark2, 'Goto bookmark to 2');
  Add(Ord('Q'), [ssCtrl], Ord('3'), [], eecGotoBookmark3, 'Goto bookmark to 3');
  Add(Ord('Q'), [ssCtrl], Ord('4'), [], eecGotoBookmark4, 'Goto bookmark to 4');
  Add(Ord('Q'), [ssCtrl], Ord('5'), [], eecGotoBookmark5, 'Goto bookmark to 5');
  Add(Ord('Q'), [ssCtrl], Ord('6'), [], eecGotoBookmark6, 'Goto bookmark to 6');
  Add(Ord('Q'), [ssCtrl], Ord('7'), [], eecGotoBookmark7, 'Goto bookmark to 7');
  Add(Ord('Q'), [ssCtrl], Ord('8'), [], eecGotoBookmark8, 'Goto bookmark to 8');
  Add(Ord('Q'), [ssCtrl], Ord('9'), [], eecGotoBookmark9, 'Goto bookmark to 9');

  Add(Ord('A'), [ssCtrl], eecSelectAll, 'Select all');
  Add(Ord('C'), [ssCtrl], eecCopy, 'Copy to clipboard');
  Add(Ord('X'), [ssCtrl], eecCut, 'Cut to clipboard');
  Add(Ord('V'), [ssCtrl], eecPaste, 'Paste from clipboard');
  Add(Ord('Z'), [ssCtrl], eecUndo, 'Undo');
end;

procedure TElKeyCommandList.Delete(ACommand: TElCommand);
var
  i: integer;
begin
  for i := 0 to FCommandList.Count - 1 do
  begin
    if TElKeyCommand(FCommandList.FastGet(i)).Command = ACommand then
    begin
      FCommandList.Delete(i);
      exit;
    end;
  end;
end;

destructor TElKeyCommandList.Destroy;
begin
  FreeAndNil(FCommandList);
  inherited;
end;

function TElKeyCommandList.Find(AKey: Word; AShiftState: TShiftState): TElCommand;
begin
  Result := Find(AKey, AShiftState, 0, []);
end;

function TElKeyCommandList.Find(const AKey: word;
  const AShiftState: TShiftState; AKey2: word;
  const AShiftState2: TShiftState): TElCommand;
var
  i: Integer;
  LCommand: TElKeyCommand;
begin
  Result := eecNone;
  for i := 0 to FCommandList.Count - 1 do
  begin
    LCommand := TElKeyCommand(FCommandList.FastGet(i));
    if (LCommand.Key = AKey) and (LCommand.ShiftState = AShiftState) then
    begin
      Result := eecWaitForSecondKey;
      if (LCommand.Key2 = AKey2) and (LCommand.ShiftState2 = AShiftState2) then
      begin
        Result := LCommand.Command;
        exit;
      end;
    end;
  end;
end;

function TElKeyCommandList.GetCommand(Index: TElCommand): TElKeyCommand;
var
  i: Integer;
begin
  Result := nil;
  for i := 0 to FCommandList.Count - 1 do
  begin
    if TElKeyCommand(FCommandList.FastGet(i)).Command = Index then
    begin
      Result := TElKeyCommand(FCommandList.FastGet(i));
      exit;
    end;
  end;
end;

end.
