unit LMDRTFTape;
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

LMDRTFTape unit (VO)
--------------------

RTF RTF Tape support 

ToDo:

Changes
-------
Release 8.0 (October 2006)
 - Initial Release

###############################################################################}

interface
uses
  Classes;
  type

  {****************************************************************************}
  TLMDRTFTapeCellDATA = class
  end;

  {****************************************************************************}
  TLMDRTFTapeCellIDATA = class(TLMDRTFTapeCellDATA)
  private
    FData : LongInt;
  public
    constructor Create(aData : LongInt);
    property Data : LongInt read FData;
  end;

  {****************************************************************************}
  TLMDRTFTapeCellPDATA = class(TLMDRTFTapeCellDATA)
  private
    FData : String;
  public
    constructor Create(aData : string);
    property Data : String read FData;
  end;

  {****************************************************************************}
  TLMDRTFTapeCellSDATA = class(TLMDRTFTapeCellDATA)
  private
    FData : String;
  public
    constructor Create(aData : string);
    property Data : String read FData;
  end;

  {****************************************************************************}
  TLMDRTFTapeCellBDATA = class(TLMDRTFTapeCellDATA)
  private
    FData : TMemoryStream;
  public
    constructor Create(aData : TStream);
    destructor Destroy; override;
    property Data : TMemoryStream read FData;
  end;

  {****************************************************************************}
  TLMDRTFCellType = (ctDATA, ctIDATA, ctPDATA, ctSDATA, ctBDATA);
  {****************************************************************************}
  TLMDRTFTapeCell = class(TCollectionItem)
  private
    FCellType   : TLMDRTFCellType;
    FCellCode   : LongInt;
    FData       : TLMDRTFTapeCellDATA;
    FReady      : boolean;
  protected
    procedure SetReady;
  public
    constructor Create(Collection : TCollection); override;
    destructor Destroy; override;
    property CellCode : LongInt read FCellCode;
    property CellType : TLMDRTFCellType read FCellType;
    property Data : TLMDRTFTapeCellDATA read FData;
    property Ready : boolean read FReady;
  end;

  {****************************************************************************}
  TLMDRTFTape = class(TCollection)
  private
    function GetItem(index : integer) : TLMDRTFTapeCell;
  protected
    function AddCell : TLMDRTFTapeCell; overload;
  public
    constructor Create;
    procedure AddCell(aCode : LongInt); overload;
    procedure AddICell(aCode, aData : LongInt);
    procedure AddPCell(aCode : LongInt; aData : string);
    procedure AddSCell(aCode : LongInt; aData : string);
    procedure AddBCell(aCode : LongInt; aData : TStream);
    property Items[index : integer] : TLMDRTFTapeCell read GetItem; default;
  end;

implementation
uses
  sysutils, LMDRTFLookupTable;

{** TLMDRTFTapeCellIDATA ******************************************************}
constructor TLMDRTFTapeCellIDATA.Create(aData : LongInt);
begin
  inherited Create;
  FData := aData;
end;

{** TLMDRTFTapeCellPDATA ******************************************************}
constructor TLMDRTFTapeCellPDATA.Create(aData : string);
begin
  inherited Create;
  FData := aData;
end;

{** TLMDRTFTapeCellSDATA ******************************************************}
constructor TLMDRTFTapeCellSDATA.Create(aData : string);
begin
  inherited Create;
  FData := aData;
end;

{** TLMDRTFTapeCellBDATA ******************************************************}
constructor TLMDRTFTapeCellBDATA.Create(aData : TStream);
begin
  inherited Create;
  FData := TMemoryStream.Create;
  FData.LoadFromStream(aData);
  FData.Position := 0;
end;

{------------------------------------------------------------------------------}
destructor TLMDRTFTapeCellBDATA.Destroy;
begin
  FData.Free;
  inherited;
end;

{** TLMDRTFTapeCell ***********************************************************}
{-- protected -----------------------------------------------------------------}
procedure TLMDRTFTapeCell.SetReady;
begin FReady := True; end;

{-- public --------------------------------------------------------------------}
constructor TLMDRTFTapeCell.Create(Collection : TCollection);
begin
  inherited;
  FCellType := ctDATA;
  FCellCode := 0;
  FData := nil;
  FReady := False;
end;

{------------------------------------------------------------------------------}
destructor TLMDRTFTapeCell.Destroy;
begin
  inherited;
  if assigned(FData) then
    FreeAndNil(FData);
end;

{** TLMDRTFTape ***************************************************************}
{-- private -------------------------------------------------------------------}
function TLMDRTFTape.GetItem(index : integer) : TLMDRTFTapeCell;
begin result := TLMDRTFTapeCell(inherited GetItem(index)); end;

{-- protected -----------------------------------------------------------------}
function TLMDRTFTape.AddCell : TLMDRTFTapeCell;
begin
  if count = 0 then
    result := TLMDRTFTapeCell(inherited Add)  
  else
    result := TLMDRTFTapeCell(inherited insert(count-1));
end;

{-- public --------------------------------------------------------------------}
constructor TLMDRTFTape.Create;
begin
  inherited Create(TLMDRTFTapeCell);
end;

{------------------------------------------------------------------------------}
procedure TLMDRTFTape.AddCell(aCode : LongInt);
var
  Cell : TLMDRTFTapeCell;
begin
  Cell := AddCell;
  Cell.FCellCode := aCode;
  Cell.FCellType := ctDATA;
  Cell.SetReady;
end;

{------------------------------------------------------------------------------}
procedure TLMDRTFTape.AddICell(aCode, aData : LongInt);
var
  Cell : TLMDRTFTapeCell;
begin
  Cell := AddCell;
  Cell.FCellCode := aCode;
  Cell.FCellType := ctIDATA;
  Cell.FData := TLMDRTFTapeCellIDATA.Create(aData);
  Cell.SetReady;
end;

{------------------------------------------------------------------------------}
procedure TLMDRTFTape.AddPCell(aCode : LongInt; aData : string);
var
  Cell : TLMDRTFTapeCell;
begin
  Cell := AddCell;
  Cell.FCellCode := aCode;
  Cell.FCellType := ctPDATA;
  Cell.FData := TLMDRTFTapeCellPDATA.Create(aData);
  Cell.SetReady;
end;

{------------------------------------------------------------------------------}
procedure TLMDRTFTape.AddSCell(aCode : LongInt; aData : string);
var
  Cell : TLMDRTFTapeCell;
begin
  Cell := AddCell;
  Cell.FCellCode := aCode;
  Cell.FCellType := ctSDATA;
  Cell.FData := TLMDRTFTapeCellSDATA.Create(aData);
  Cell.SetReady;
end;

{------------------------------------------------------------------------------}
procedure TLMDRTFTape.AddBCell(aCode : LongInt; aData : TStream);
var
  Cell : TLMDRTFTapeCell;
begin
  Cell := AddCell;
  Cell.FCellCode := aCode;
  Cell.FCellType := ctBDATA;
  Cell.FData := TLMDRTFTapeCellBDATA.Create(aData);
  Cell.SetReady;
end;

end.
