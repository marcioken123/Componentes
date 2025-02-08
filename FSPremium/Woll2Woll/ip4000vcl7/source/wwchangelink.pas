unit wwchangelink;
{
//
// Description : Picture Mask Design Time Access
//
// Copyright (c) 1995-2001 by Woll2Woll Software
//
}

interface

uses Classes;

type
  TwwChangeLink = class(TObject)
  private
    FOnChange: TNotifyEvent;
    FOnChanging: TNotifyEvent;
    FOnLoaded: TNotifyEvent;
    FSender: TObject;
  public
    procedure Change; virtual;
    procedure Changing; virtual;
    procedure Loaded; virtual;
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
    property OnChanging: TNotifyEvent read FOnChanging write FOnChanging;
    property OnLoaded: TNotifyEvent read FOnLoaded write FOnLoaded;
    property Sender: TObject read FSender write FSender;
  end;

implementation

procedure TwwChangeLink.Change;
begin
  if Assigned(OnChange) then OnChange(Sender);
end;

procedure TwwChangeLink.Changing;
begin
  if Assigned(OnChanging) then OnChanging(Sender);
end;

procedure TwwChangeLink.Loaded;
begin
  if Assigned(OnLoaded) then OnLoaded(Sender);
end;

end.
