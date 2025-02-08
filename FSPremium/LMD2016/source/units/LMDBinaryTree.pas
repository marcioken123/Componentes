unit LMDBinaryTree;
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

LMDBinaryTree unit (AIH)
------------------------
Simple implementation of binary tree structure

Changes
-------
Release 8.0 (Mart 2007)
 - Initial Release

###############################################################################}

interface

uses
  Classes;

type
  TLMDBinaryTreeAddType = (adtLeft, adtRight);

  TLMDBinaryTreeNode = class(TPersistent)
  private
    FData: TObject;
    FLeft: TLMDBinaryTreeNode;
    FRight: TLMDBinaryTreeNode;
    function GetIsLeaf: boolean;
    procedure SetLeft(const Value: TLMDBinaryTreeNode);
    procedure SetRight(const Value: TLMDBinaryTreeNode);
  public
    constructor Create;
    destructor Destroy; override;
    function AddData(AnObject: TObject; AAddType: TLMDBinaryTreeAddType): TObject;
    procedure AddNode(ANode: TLMDBinaryTreeNode; AAddType: TLMDBinaryTreeAddType);
    property Data: TObject read FData write FData;
    property LeftNode: TLMDBinaryTreeNode read FLeft write SetLeft;
    property RightNode: TLMDBinaryTreeNode read FRight write SetRight;
    property IsLeaf: boolean read GetIsLeaf;
  end;

  TLMDCompareMethod = class(TObject)
  private
    FPriority: Byte;
    FSymbol: Char;
  public
    property Symbol: Char read FSymbol write FSymbol;
    property Priority: Byte read FPriority write FPriority;
  end;

implementation

{TLMDBinaryTreeNode}

function TLMDBinaryTreeNode.AddData;
var
  ANewNode: TLMDBinaryTreeNode;
begin
  ANewNode := TLMDBinaryTreeNode.Create;
  ANewNode.Data := AnObject;
  if AAddType = adtLeft then
    FLeft := ANewNode
  else
    FRight := ANewNode;
  Result := ANewNode;
end;

function TLMDBinaryTreeNode.GetIsLeaf: boolean;
begin
  Result := (FRight = nil) and (FLeft = nil)
end;

procedure TLMDBinaryTreeNode.SetLeft(const Value: TLMDBinaryTreeNode);
begin
  if FLeft <> Value then
  begin
    if Value = nil then
      FLeft.Free;
    FLeft := Value
  end;
end;

procedure TLMDBinaryTreeNode.SetRight(const Value: TLMDBinaryTreeNode);
begin
  if FRight <> Value then
  begin
    if Value = nil then
      FRight.Free;
    FRight := Value
  end;
end;

procedure TLMDBinaryTreeNode.AddNode;
begin
  if AAddType = adtLeft then
    FLeft := ANode
  else
    FRight := ANode;
end;

constructor TLMDBinaryTreeNode.Create;
begin
  inherited;
  FLeft := nil;
  FRight := nil;
end;

destructor TLMDBinaryTreeNode.Destroy;
begin
  if Assigned(FLeft) then
    FLeft.Free;
  if Assigned(FRight) then
    FRight.Free;
  inherited;
end;

end.
