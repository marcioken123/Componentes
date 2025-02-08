unit LMDIterator;
{$I LMDCmps.inc}

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

LMDIterator unit (VO)
---------------------

Support navigation through parsed elements 

ToDo:

Changes
-------
Release 8.0 (October 2006)
 - Initial Release

###############################################################################}

interface
uses
  LMDText, LMDTable, LMDTree, LMDEmbdControl, LMDHiddenText, LMDTextBox;

type

  TLMDIterator = class;
  TLMDIteratorClass = class of TLMDIterator;

  { ********************************** TLMDIterator ***************************}
  TLMDIterator = class
  private
    FDataTree           : TLMDParsedTextList;
    FCurrentData        : TLMDBaseText;
    FEof                : boolean;
    FBof                : boolean;
  protected
    function IsThis(AItem : TLMDBaseText) : boolean; virtual;
  public
    constructor Create(AData : TLMDParsedTextList);
    function  Current : TLMDBaseText; virtual;
    function  IsEmpty : boolean;
    procedure First; virtual;
    procedure Next; virtual;
    procedure Prev; virtual;
    procedure Last; virtual;
    property Eof : boolean read FEof;
    property Bof : boolean read FBof;
  end;

  {$WARNINGS OFF}
  { ********************************** TLMDImageIterator **********************}
  TLMDImageIterator = class(TLMDIterator)
  protected
    function IsThis(AItem : TLMDBaseText) : boolean; override;
  public
    function  Current : TLMDImage; 
  end;

  { ********************************** TLMDListIterator **********************}
  TLMDListIterator = class(TLMDIterator)
  protected
    function IsThis(AItem : TLMDBaseText) : boolean; override;
  public
    function  Current : TLMDParseList;
  end;

  { ********************************** TLMDListItemIterator *******************}
  TLMDListItemIterator = class(TLMDIterator)
  protected
    function IsThis(AItem : TLMDBaseText) : boolean; override;
  public
    function  Current : TLMDParseListItem;
  end;

  { ********************************** TLMDParagraphIterator ******************}
  TLMDParagraphIterator = class(TLMDIterator)
  protected
    function IsThis(AItem : TLMDBaseText) : boolean; override;
  public
    function  Current : TLMDParagraph;
  end;

  { ********************************** TLMDTableIterator **********************}
  TLMDTableIterator = class(TLMDIterator)
  protected
    function IsThis(AItem : TLMDBaseText) : boolean; override;
  public
    function  Current : TLMDTable;
  end;

  { ********************************** TLMDTreeIterator ***********************}
  TLMDTreeIterator = class(TLMDIterator)
  protected
    function IsThis(AItem : TLMDBaseText) : boolean; override;
  public
    function  Current : TLMDTree;
  end;

  { ********************************** TLMDEmbdControlIterator ****************}
  TLMDEmbdControlIterator = class(TLMDIterator)
  protected
    function IsThis(AItem : TLMDBaseText) : boolean; override;
  public
    function  Current : TLMDEmbdControl;
  end;

  { ********************************** TLMDTextIterator ***********************}
  TLMDTextIterator = class(TLMDIterator)
  protected
    function IsThis(AItem : TLMDBaseText) : boolean; override;
  public
    function  Current : TLMDText;
  end;

  { ********************************** TLMDHiddenTextIterator *****************}
  TLMDHiddenTextIterator = class(TLMDIterator)
  protected
    function IsThis(AItem : TLMDBaseText) : boolean; override;
  public
    function  Current : TLMDHiddenText;
  end;

  { ********************************** TLMDContainerIterator ******************}
  TLMDContainerIterator = class(TLMDIterator)
  protected
    function IsThis(AItem : TLMDBaseText) : boolean; override;
  public
    function  Current : TLMDParsedTextList; 
  end;

  { ********************************** TLMDHiddenTextIterator *****************}
  TLMDTextBoxIterator = class(TLMDIterator)
  protected
    function IsThis(AItem : TLMDBaseText) : boolean; override;
  public
    function  Current : TLMDTextBox;
  end;

implementation

{ ********************************** TLMDIterator *****************************}
{------------------------------------------------------------------------------}

function TLMDIterator.IsThis(AItem : TLMDBaseText) : boolean;
begin result := false end;

{ ********************************** Public ***********************************}

constructor TLMDIterator.Create(AData : TLMDParsedTextList);
begin
  inherited Create;
  FDataTree := AData;
  FCurrentData := nil;
  FEof := False;
  FBof := True;
  First;
end;

{------------------------------------------------------------------------------}

function  TLMDIterator.Current : TLMDBaseText;
begin result := FCurrentData end;

{------------------------------------------------------------------------------}

function  TLMDIterator.IsEmpty : boolean;
var
  I : LongInt;
begin
  result := True;
  for I := 0 to FDataTree.count-1 do
    if IsThis(FDataTree.SubItem[I]) then
    begin
      result := False;
      Break;
    end;
end;

{------------------------------------------------------------------------------}

procedure TLMDIterator.First;
var
  I : LongInt;
begin
  FCurrentData := nil;
  FEof := True;
  FBof := True;
  if not assigned(FDataTree) then Exit;
  for I := 0 to FDataTree.count-1 do
    if IsThis(FDataTree.SubItem[I]) then
    begin
      FCurrentData := FDataTree.SubItem[I];
      FEof := False;
      FBof := False;
      Break;
    end;
end;

{------------------------------------------------------------------------------}

procedure TLMDIterator.Next;
var
  I     : LongInt;
  J     : LongInt;
  Item  : TLMDBaseText;
begin
  if FEof then Exit;
  if Bof then begin
    First;
    Exit;
  end;

  if not assigned(FDataTree) then begin
    FCurrentData := nil;
    FEof := True;
    FBof := True;
    Exit;
  end;

  if not assigned(FCurrentData) then begin
    FCurrentData := nil;
    FEof := False;
    FBof := True;
  end;

  Item := FCurrentData;
  FCurrentData := nil;
  FEof := True;
  for I := 0 to FDataTree.count-1 do
    if FDataTree.SubItem[I] = Item then begin
      for J := I+1 to FDataTree.count-1 do
        if IsThis(FDataTree.SubItem[J]) then
        begin
          FCurrentData := FDataTree.SubItem[J];
          FEof := False;
          FBof := False;
          Break;
        end;
      Break;
    end;
end;

{------------------------------------------------------------------------------}

procedure TLMDIterator.Prev;
var
  I     : LongInt;
  J     : LongInt;
  Item  : TLMDBaseText;
begin
  if FBof then Exit;
  if Eof then begin
    Last;
    Exit;
  end;

  if not assigned(FDataTree) then begin
    FCurrentData := nil;
    FEof := True;
    FBof := True;
    Exit;
  end;

  if not assigned(FCurrentData) then begin
    FCurrentData := nil;
    FEof := True;
    FBof := False;
  end;

  Item := FCurrentData;
  FCurrentData := nil;
  FBof := True;
  for I := FDataTree.count-1 downto 0 do
    if FDataTree.SubItem[I] = Item then begin
      for J := I-1 downto 0 do
        if IsThis(FDataTree.SubItem[J]) then
        begin
          FCurrentData := FDataTree.SubItem[J];
          FEof := False;
          FBof := False;
          Break;
        end;
      Break;
    end;
end;

{------------------------------------------------------------------------------}

procedure TLMDIterator.Last;
var
  I : LongInt;
begin
  FCurrentData := nil;
  FEof := True;
  FBof := True;
  if not assigned(FDataTree) then Exit;
  for I := FDataTree.count-1 downto 0 do
    if IsThis(FDataTree.SubItem[I]) then
    begin
      FCurrentData := FDataTree.SubItem[I];
      FEof := False;
      FBof := False;
      Break;
    end;
end;

{ ************************************ TLMDImageIterator **********************}
{-----------------------------------------------------------------------------}

function TLMDImageIterator.IsThis(AItem : TLMDBaseText) : boolean;
begin result := (AItem is TLMDImage) end;

{ ********************************** Public ***********************************}

function  TLMDImageIterator.Current : TLMDImage;
begin  result := TLMDImage(inherited Current) end;

{ ********************************** TLMDListIterator **********************}
{-----------------------------------------------------------------------------}

function TLMDListIterator.IsThis(AItem : TLMDBaseText) : boolean;
begin result := (AItem is TLMDParseList) end;

{ ********************************** Public ***********************************}

function  TLMDListIterator.Current : TLMDParseList;
begin  result := TLMDParseList(inherited Current) end;

{ ********************************** TLMDListItemIterator *********************}
{-----------------------------------------------------------------------------}

function TLMDListItemIterator.IsThis(AItem : TLMDBaseText) : boolean;
begin result := (AItem is TLMDParseListItem) end;

{ ********************************** Public ***********************************}

function  TLMDListItemIterator.Current : TLMDParseListItem;
begin  result := TLMDParseListItem(inherited Current) end;

{ ************************************ TLMDParagraphIterator ******************}
{-----------------------------------------------------------------------------}

function TLMDParagraphIterator.IsThis(AItem : TLMDBaseText) : boolean;
begin result := (AItem is TLMDParagraph) end;

{ ********************************** Public ***********************************}

function  TLMDParagraphIterator.Current : TLMDParagraph;
begin  result := TLMDParagraph(inherited Current) end;

{ ************************************ TLMDTableIterator **********************}
{-----------------------------------------------------------------------------}

function TLMDTableIterator.IsThis(AItem : TLMDBaseText) : boolean;
begin result := (AItem is TLMDTable) end;

{ ********************************** Public ***********************************}

function  TLMDTableIterator.Current : TLMDTable;
begin  result := TLMDTable(inherited Current) end;

{ ************************************ TLMDTreeIterator ***********************}
{-----------------------------------------------------------------------------}

function TLMDTreeIterator.IsThis(AItem : TLMDBaseText) : boolean;
begin result := (AItem is TLMDTree) end;

{ ********************************** Public ***********************************}

function  TLMDTreeIterator.Current : TLMDTree;
begin  result := TLMDTree(inherited Current) end;

{ ************************************ TLMDEmbdControlIterator ****************}
{-----------------------------------------------------------------------------}

function TLMDEmbdControlIterator.IsThis(AItem : TLMDBaseText) : boolean;
begin result := (AItem is TLMDEmbdControl) end;

{ ********************************** Public ***********************************}

function  TLMDEmbdControlIterator.Current : TLMDEmbdControl;
begin  result := TLMDEmbdControl(inherited Current) end;

{ ************************************ TLMDTextIterator ***********************}
{-----------------------------------------------------------------------------}

function TLMDTextIterator.IsThis(AItem : TLMDBaseText) : boolean;
begin result := (AItem is TLMDText) end;

{ ********************************** Public ***********************************}

function  TLMDTextIterator.Current : TLMDText;
begin  result := TLMDText(inherited Current) end;

{ ************************************ TLMDHiddenTextIterator *****************}
{-----------------------------------------------------------------------------}

function TLMDHiddenTextIterator.IsThis(AItem : TLMDBaseText) : boolean;
begin result := (AItem is TLMDHiddenText) end;

{ ********************************** Public ***********************************}

function  TLMDHiddenTextIterator.Current : TLMDHiddenText;
begin  result := TLMDHiddenText(inherited Current) end;

{ ************************************ TLMDContainerIterator ******************}
{-----------------------------------------------------------------------------}

function TLMDContainerIterator.IsThis(AItem : TLMDBaseText) : boolean;
begin
  result := (not (AItem is TLMDText)) and
            (not (AItem is TLMDEmbdControl)) and
            (not (AItem is TLMDTree)) and
            (not (AItem is TLMDTable)) and
            (not (AItem is TLMDParagraph)) and
            (not (AItem is TLMDParseList)) and
            (not (AItem is TLMDImage)) and
            (not (AItem is TLMDHiddenText)) and
            (AItem is TLMDParsedTextList);
end;

{ ********************************** Public ***********************************}

function  TLMDContainerIterator.Current : TLMDParsedTextList;
begin  result := TLMDParsedTextList(inherited Current) end;

{ ********************************** TLMDHiddenTextIterator *****************}
{-----------------------------------------------------------------------------}

function TLMDTextBoxIterator.IsThis(AItem : TLMDBaseText) : boolean;
begin result := (AItem is TLMDTextBox) end;

{ ********************************** Public ***********************************}

function  TLMDTextBoxIterator.Current : TLMDTextBox;
begin  result := TLMDTextBox(inherited Current) end;

end.
