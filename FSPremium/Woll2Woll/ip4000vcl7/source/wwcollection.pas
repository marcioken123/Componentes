{
//
// Components : IwwCollection
//
// Copyright (c) 1998 by Woll2Woll Software
//
// 8/24/98 - Moved IwwNavButtons from wwdbnavigator unit
}
unit wwCollection;

interface

uses Classes, Controls, Windows, ActiveX, SysUtils;

type
  IwwCollectionItem = interface;

  TwwUpdateNameEvent = procedure(Item: IwwCollectionItem) of object;
  TwwSelectionMethod = procedure(Item: IwwCollectionItem) of object;

  IwwCollection = interface;
  IwwNavButtons = interface(IUnknown) { 8/24/98 - Moved from wwdbnavigator unit }
    ['{BCDB6D20-2D56-11D2-A5AC-00104B216B5B}']
    procedure AddInfoPowerDialogs;
  end;

  // Implement the following two interfaces in order to
  // call the Collection Editor.  If you already implement
  // TCollection and TCollectionItem, the easiest option
  // is to change your inheritance to TwwCollection and
  // TwwCollectionItem, as these two classes already
  // implement the three required COM methods.
  //
  // If you do not implement the Collection classes, then
  // be certain that you implement QueryInterface(), _AddRef(),
  // and _Release() on BOTH of the classes that implement
  // these interfaces.  VERY IMPORTANT!!!  Do NOT rely/use
  // the implementation of these methods found in TComponent.
  // In addition, you generally do not want to use reference
  // counting so it is reccomended that you use NONE of the
  // implementations of these methods found in the Delphi VCL.
  // You merely want to return 1 for _AddRef, 0 for _Release,
  // and what we have below for QueryInterface.

  IwwCollectionItem = interface
    ['{D4CC0381-0B8D-11D2-A5AC-00104B216B5B}']
    function GetCollection: IwwCollection;
    function GetDisplayName: string;
    function GetIndex: Integer;
    function GetInstance: TPersistent;
    procedure SetIndex(Value: Integer);

    property Index: Integer read GetIndex write SetIndex;

    // Callback event that you should assign in your
    // implementing class in order for the Collection
    // Editor's display text to remain up-to-date.
    procedure SetOnUpdateName(Value: TwwUpdateNameEvent);
    procedure SetSelectionMethod(Value: TwwSelectionMethod);
    property OnUpdateName: TwwUpdateNameEvent write SetOnUpdateName;
    property SelectionMethod: TwwSelectionMethod write SetSelectionMethod;
  end;

  IwwCollection = interface
    ['{D4CC0380-0B8D-11D2-A5AC-00104B216B5B}']
    function GetCount: Integer;
    function GetItem(Index: Integer): IwwCollectionItem;
    function Add: IwwCollectionItem;
    procedure BeginUpdate;
    procedure Clear;
    procedure EndUpdate;
    procedure SetDesigner(Value: TControl);
    property Count: Integer read GetCount;
    property Designer: TControl write SetDesigner;
    property Items[Index: Integer]: IwwCollectionItem read GetItem;
  end;

  TwwCollectionItem = class(TCollectionItem)
  public
    // IUnknown
    function QueryInterface(const IID: TGUID; out Obj): Integer; stdcall;
    function _AddRef: Integer; stdcall;
    function _Release: Integer; stdcall;
  end;

  TwwCollection = class(TCollection)
  public
    // IUnknown
    function QueryInterface(const IID: TGUID; out Obj): Integer; stdcall;
    function _AddRef: Integer; stdcall;
    function _Release: Integer; stdcall;
  end;

implementation

// IUnknown

function TwwCollectionItem.QueryInterface(const IID: TGUID; out Obj): Integer;
const
  E_NOINTERFACE = $80004002;
begin
  {$WARNINGS OFF}
  if GetInterface(IID, Obj) then Result := 0 else Result := E_NOINTERFACE;
  {$WARNINGS ON}
end;

function TwwCollectionItem._AddRef: Integer;
begin
  Result := 1;
end;

function TwwCollectionItem._Release: Integer;
begin
  Result := 0;
end;

// IUnknown

function TwwCollection.QueryInterface(const IID: TGUID; out Obj): Integer;
const
  E_NOINTERFACE = $80004002;
begin
  {$WARNINGS OFF}
  if GetInterface(IID, Obj) then Result := 0 else Result := E_NOINTERFACE;
  {$WARNINGS ON}
end;

function TwwCollection._AddRef: Integer;
begin
  Result := 1;
end;

function TwwCollection._Release: Integer;
begin
  Result := 0;
end;

end.
