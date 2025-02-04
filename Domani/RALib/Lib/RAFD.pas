{***********************************************************
                R&A Library
              R&A Form Designer
       Copyright (C) 1998-99 R&A

       description : resource identifers,
                     common global objects

       programer   : black
       e-mail      : black@infa.ru
       www         : www.chat.ru\~blacknbs\ralib
************************************************************}

{$INCLUDE RA.INC}

unit RAFD;

interface

uses Windows, SysUtils, RARegAuto, RAFDCompat;

type

  ERAFDError = class(Exception)
  public
    ErrCode : integer;
    ErrName : string;
    ErrName2 : string;
    constructor Create(const AErrCode : integer; const AErrName,
      AErrName2 : string);
  end;

  procedure RAFDError(const AErrCode : integer);
  procedure RAFDErrorN(const AErrCode : integer; const AErrName : string);
  procedure RAFDErrorN2(const AErrCode : integer; const AErrName1,
    AErrName2 : string);
  function ResStr(const ID: Integer; const Default: string): string;

type

 { Environment Options }
  TEnvironment = class
  public
   { Editor }
    DoubleClickLine    : boolean;
    UndoAfterSave      : boolean;
    KeepTrailingBlanks : boolean;
    AutoIndent         : boolean;
    SmartTab           : boolean;
    BackspaceUnindents : boolean;
    GroupUndo          : boolean;
    CursorBeyondEOF    : boolean;
    SytaxHighlighting  : boolean;
    AutoIdentifers     : boolean;
    FontName           : string;
    FontSize           : longword;
    FontColor          : Integer;
    FontCharset        : longword;

    constructor Create;
    destructor Destroy; override;
    procedure Save(ARegAuto : TRegAuto);
    procedure Restore(ARegAuto : TRegAuto);
  end;

var
  Environment: TEnvironment;
  

const
  deResBase           = $5400;

  deFileNotFound      = 1;
  deNoFormSelected    = 2;
  deCantSaveFile      = 3;
  deFileChanged       = 4;
  deNotYetImplemented = 5;
  deInternal          = 6;
  deRAI2NotFound      = 7;
  deRAI2FuncNotFound  = 8;
  deLoadExpertFail    = 9;
  deErrorCreatingForm = 10;
  deCantChangeIniStrings = 11;

 { source manipualtion error }
  deCantRenameForm       = 12;
  deCantRenameUnit       = 13;
  deCantRenameMethod     = 14;
  deFormDeclNotFound     = 15;
  deClauseIncorrect      = 16;


  deStrBase           = deResBase + $200;

  deOk                = deStrBase + 1;
  deCancel            = deStrBase + 2;

 { Form Designer }
  deBringToFront      = deStrBase + 50;
  deSendToBack        = deStrBase + 51;

 { App Builder - main form }
  deFileMenu                   = deStrBase + 100;
  deEditMenu                   = deStrBase + 101;
  deViewsMenu                  = deStrBase + 102;
  deFileNewItem                = deStrBase + 103;
  deFileNewFormItem            = deStrBase + 104;
  deFileOpenItem               = deStrBase + 105;
  deFileSaveItem               = deStrBase + 106;
  deFileSaveAsItem             = deStrBase + 107;
  deFileSaveAllItem            = deStrBase + 108;
  deFileCloseItem              = deStrBase + 109;
  deFileCloseAllItem           = deStrBase + 110;
  deFileExitItem               = deStrBase + 111;
  deEditDeleteItem             = deStrBase + 112;
  deViewObjInspItem            = deStrBase + 113;
  deViewAlignItem              = deStrBase + 114;
  deViewPaletteItem            = deStrBase + 115;
  deRunMenu                    = deStrBase + 116;
  deRunFormItem                = deStrBase + 117;
  deRunReportPreviewItem       = deStrBase + 118;
  deViewSwapSourceFormItem     = deStrBase + 119;
  deOpenHint                   = deStrBase + 120;
  deSaveAllHint                = deStrBase + 121;
  deSwapSourceFormHint         = deStrBase + 122;
  deRunFormHint                = deStrBase + 123;
  deRunReportPreviewHint       = deStrBase + 124;
  deComponentMenu              = deStrBase + 125;
  deViewWindowListItem         = deStrBase + 126;
  deSearchMenu                 = deStrBase + 127;
  deProjectMenu                = deStrBase + 128;
  deToolsMenu                  = deStrBase + 129;
  deViewPrjSourceItem          = deStrBase + 130;
  deToolsOptionsItem           = deStrBase + 131;
  deHelpMenu                   = deStrBase + 132;
  deEditCopyItem               = deStrBase + 133;
  deEditPasteItem              = deStrBase + 134;


 { Alignment Palette }
  deAlign             = deStrBase + 200;
  deAlign10           = deStrBase + 210;

 { ObjectInspector }
  deObjectInspector   = deStrBase + 220;
  deProperties        = deStrBase + 221;
  deEvents            = deStrBase + 222;

 { String List Editor }
  deStringsEditor     = deStrBase + 230;
  deCodeEditor        = deStrBase + 231;

 { New Items }
  deNewItems          = deStrBase + 240;
  deNew               = deStrBase + 241;

  DefaultComponentBitmap = 'RAFDDefaultComponentBitmap';

var
  BaseRegKey: string;
  ActiveModule: HModule;


implementation

{$R rafd.res}


procedure RAFDError(const AErrCode : integer);
begin
  raise ERAFDError.Create(AErrCode, '', '');
end;    { RAFDError }

procedure RAFDErrorN(const AErrCode : integer; const AErrName : string);
begin
  raise ERAFDError.Create(AErrCode, AErrName, '');
end;    { RAFDErrorN }

procedure RAFDErrorN2(const AErrCode : integer; const AErrName1,
  AErrName2 : string);
begin
  raise ERAFDError.Create(AErrCode, AErrName1, AErrName2);
end;    { RAFDErrorN2 }

constructor ERAFDError.Create(const AErrCode : integer; const AErrName,
  AErrName2 : string);
begin
  inherited Create('');
  ErrCode := AErrCode;
  ErrName := AErrName;
  ErrName2 := AErrName2;
  // S := LoadStr(ErrCode + ResBase);
  { function LoadStr don't work sometimes :-( }
  Message := Format(ResStr(ErrCode + deResBase, ''), [ErrName, ErrName2]);
end;    { Create }

function ResStr(const ID: Integer; const Default: string): string;
begin
  SetLength(Result, 1024);
  SetLength(Result, LoadString(hInstance, ID, PChar(Result), Length(Result)));
  if Length(Result) = 0 then
    Result := Default;
end;    {  }


constructor TEnvironment.Create;
begin
 {default settings}
  DoubleClickLine    := false;
  UndoAfterSave      := true;
  KeepTrailingBlanks := true;
  AutoIndent         := true;
  SmartTab           := true;
  BackspaceUnindents := true;
  GroupUndo          := true;
  CursorBeyondEOF    := false;
  SytaxHighlighting  := true;
  AutoIdentifers     := true;
  FontName           := 'Courier New';
  FontSize           := 10;
  FontColor          := {clWindowText} COLOR_WINDOWTEXT or Integer($80000000);
  FontCharset        := DEFAULT_CHARSET;
end;

destructor TEnvironment.Destroy;
begin
end;

procedure TEnvironment.Save(ARegAuto : TRegAuto);
begin
  with ARegAuto do
  begin
    WriteBool('Environment\Editor', 'DoubleClickLine'   , DoubleClickLine   );
    WriteBool('Environment\Editor', 'UndoAfterSave'     , UndoAfterSave     );
    WriteBool('Environment\Editor', 'KeepTrailingBlanks', KeepTrailingBlanks);
    WriteBool('Environment\Editor', 'AutoIndent'        , AutoIndent        );
    WriteBool('Environment\Editor', 'SmartTab'          , SmartTab          );
    WriteBool('Environment\Editor', 'BackspaceUnindents', BackspaceUnindents);
    WriteBool('Environment\Editor', 'GroupUndo'         , GroupUndo         );
    WriteBool('Environment\Editor', 'CursorBeyondEOF'   , CursorBeyondEOF   );
    WriteBool('Environment\Editor', 'SytaxHighlighting' , SytaxHighlighting );
    WriteBool('Environment\Editor', 'AutoIdentifers'    , AutoIdentifers    );
    WriteString ('Environment\Editor', 'FontName'   , FontName   );
    WriteInteger('Environment\Editor', 'FontSize'   , FontSize   );
    WriteInteger('Environment\Editor', 'FontColor'  , FontColor  );
    WriteInteger('Environment\Editor', 'FontCharset', FontCharset);
  end
end;

procedure TEnvironment.Restore(ARegAuto : TRegAuto);
begin
  with ARegAuto do
    try
      DoubleClickLine    := ReadBool('Environment\Editor', 'DoubleClickLine'   , DoubleClickLine   );
      UndoAfterSave      := ReadBool('Environment\Editor', 'UndoAfterSave'     , UndoAfterSave     );
      KeepTrailingBlanks := ReadBool('Environment\Editor', 'KeepTrailingBlanks', KeepTrailingBlanks);
      AutoIndent         := ReadBool('Environment\Editor', 'AutoIndent'        , AutoIndent        );
      SmartTab           := ReadBool('Environment\Editor', 'SmartTab'          , SmartTab          );
      BackspaceUnindents := ReadBool('Environment\Editor', 'BackspaceUnindents', BackspaceUnindents);
      GroupUndo          := ReadBool('Environment\Editor', 'GroupUndo'         , GroupUndo         );
      CursorBeyondEOF    := ReadBool('Environment\Editor', 'CursorBeyondEOF'   , CursorBeyondEOF   );
      SytaxHighlighting  := ReadBool('Environment\Editor', 'SytaxHighlighting' , SytaxHighlighting );
      AutoIdentifers     := ReadBool('Environment\Editor', 'AutoIdentifers'    , AutoIdentifers    );
      FontName    := ReadString ('Environment\Editor', 'FontName'   , FontName   );
      FontSize    := ReadInteger('Environment\Editor', 'FontSize'   , FontSize   );
      FontColor   := ReadInteger('Environment\Editor', 'FontColor'  , FontColor  );
      FontCharset := ReadInteger('Environment\Editor', 'FontCharset', FontCharset);
    except
    end;
end;

initialization
  Environment := TEnvironment.Create;
finalization
  Environment.Free;
end.
