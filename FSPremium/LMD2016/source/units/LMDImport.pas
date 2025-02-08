unit LMDImport;
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

LMDImport unit (JH)
-------------------

Changes
-------
Release 8.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Classes,
  DB,
  LMDCustomComponent;

type
  TLMDFinishedImport = procedure (Sender: TObject; recordCount: Int64) of object;

  TLMDImport = class (TLMDCustomComponent)
  private
{    FDataLink        : TDataLink;
    procedure SetDataSource (aValue : TDataSource);
    function GetDatasource : TDataSource;          }
    FOnFinished: TLMDFinishedImport;
  protected
    procedure DoImportFinished (records: Int64);
    function BeginImport: Boolean; virtual;
    procedure Notification (AComponent : TComponent;Operation : TOperation); override;
  public
    constructor Create (aOwner: TComponent); override;
    destructor Destroy; override;
    procedure ImportStream (aStream  : TStream); virtual; abstract;
    procedure ImportFile   (aFilename: String);
    procedure ImportStrings(aStrings : TStrings);
    procedure ImportString (const aString  : String);
  published
    property About;
    property OnFinished: TLMDFinishedImport read FOnFinished write FOnFinished;
//    property DataSource : TDataSource read GetDataSource write SetDataSource;
  end;

implementation

uses
  SysUtils;

{ ------------------------------ private ------------------------------------- }
{procedure TLMDImport.SetDataSource(aValue:TDataSource);
begin
  if aValue<>FDataLink.DataSource then
    FDataLink.DataSource:=aValue;
  if aValue <> nil then aValue.FreeNotification(Self);
end;}

{ ---------------------------------------------------------------------------- }
{function TLMDImport.GetDataSource:TDataSource;
begin
  result:=FDataLink.DataSource
end;}
{ ----------------------------- protected ------------------------------------ }
procedure TLMDImport.DoImportFinished (records: Int64);
begin
  if Assigned (FOnFinished) then FOnFinished (self, records);
end;

{ ---------------------------------------------------------------------------- }
function TLMDImport.BeginImport: Boolean;
begin
  result := false;
end;

{ ----------------------------- public --------------------------------------- }
procedure TLMDImport.Notification (AComponent : TComponent;Operation : TOperation);
begin
  inherited Notification (AComponent, Operation);
{  if Operation = opRemove then
    if aComponent = FDataLink.DataSource then
      DataSource := nil;}
end;

{ ---------------------------------------------------------------------------- }
constructor TLMDImport.Create (aOwner : TComponent);
begin
  inherited Create (aOwner);
//  FDataLink := TDataLink.Create;
end;

{ ---------------------------------------------------------------------------- }
destructor TLMDImport.Destroy;
begin
//  FDataLink.Free;
  inherited Destroy;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDImport.ImportFile (aFilename: String);
var
  fs: TFileStream;
begin
  fs := TFileStream.Create (aFilename, fmOpenRead);
  try
    ImportStream (fs);
  finally
    fs.Free;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDImport.ImportStrings (aStrings: TStrings);
begin
  ImportString (aStrings.Text);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDImport.ImportString (const aString  : String);
var
  ts: TStringStream;
begin
  ts := TStringStream.Create(aString);
  try
    ImportStream (ts);
  finally
    ts.Free;
  end;
end;

end.
