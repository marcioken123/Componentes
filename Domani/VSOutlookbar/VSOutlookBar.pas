unit VSOutlookBar;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls,VSOLGroup;

type
  TVSOutlookBarGroupChangeEvent = procedure(Sender : TObject; group : TVSOutlookGroup) of object;

type
  TVSOutlookBar = class(TCustomPanel)
  private
    { Private declarations }
    FCurrentGroup : TVSOutlookGroup;
    FGroups : Array of TVSOutlookGroup;
    FGroupCount : integer;
    FChanging : boolean;
    FLoading : boolean;
    FButtonHeight : integer;
    FSlideSpeed : integer;
    FButtonFont : TFont;
    FOnGroupChange : TVSOutlookBarGroupChangeEvent;
  protected
    { Protected declarations }
    procedure Loaded;override;
    procedure Resize;override;
    procedure Notification(AComponent: TComponent;
      Operation: TOperation); override;
    procedure SetButtonHeight(value : integer);
    procedure SetSlideSpeed(value : integer);
    procedure SetButtonFont(value : TFont);
    function GetGroup(index : integer) : TVSOutLookGroup;
    procedure WMEraseBkgnd(var Message: TWmEraseBkgnd); message WM_ERASEBKGND;
  public
    { Public declarations }
    constructor Create(AOwner : TComponent);override;
    destructor Destroy;override;
    procedure ChangeGroup(Sender: TObject);
    procedure GroupButtonClick(Sender: TObject);
    function  AddNewGroup(caption : string) : TVSOutLookGroup;
    procedure AddGroup(Group : TVSOutlookGroup);
    procedure RemoveGroup(Group : TVSOutlookGroup);
    procedure SetCurrentGroup(Group : TVSOutLookGroup);
    property Groups[index : integer] : TVSOutLookGroup read GetGroup;
    property GroupCount : integer read FGroupCount;
    function UniqueName(Comp: TComponent): string;
  published
    { Published declarations }
    property Align;
    property ActiveGroup : TVSOutLookGroup read FCurrentGroup write SetCurrentGroup;
    property Color;
    property BorderWidth;
    property ButtonHeight : integer read FButtonHeight write SetButtonHeight;
    property ButtonFont : TFont read FButtonFont write SetButtonFont;
    property SlideSpeed : integer read FSlideSpeed write SetSlideSpeed;
    property Constraints;
    property Visible;
    property OnGroupChange : TVSOutlookBarGroupChangeEvent read FOnGroupChange write FOnGroupChange;
  end;

{$R *.dcr}

procedure Register;


implementation

procedure Register;
begin
  RegisterComponents('VSoft', [TVSOutlookBar]);
  RegisterClass(TVSOutlookGroup);
  RegisterClass(TVSOutlookGroup);
end;


{function Min(a,b: integer) : integer;
begin
    if a > b then
       result := b
    else
       result := a;
end;}

function Max(a,b: integer) : integer;
begin
    if a > b then
       result := a
    else
       result := b;
end;


constructor TVSOutlookBar.Create(AOwner : TComponent);
begin
    inherited Create(AOwner);
    BevelInner := bvLowered;
    BevelOuter := bvNone;
    BevelWidth := 1;
    BorderWidth := 0;
    FGroupCount := 0;
    FChanging := False;
    FButtonHeight := 20;
    FSlideSpeed := 10;
    FButtonFont := TFont.Create;
    ControlStyle := ControlStyle + [csOpaque];
    if not(csDesigning in ComponentState) then
    begin
       FLoading := True;
       Caption := '';
    end
    else
    begin
      Caption := 'Right click to add Groups'
    end;
end;

destructor TVSOutlookBar.Destroy;
begin
     FButtonFont.Free;
     inherited;
end;


procedure TVSOutlookBar.Loaded;
begin
     inherited;
     FLoading := False;
     if FCurrentGroup <> nil then
     begin
          FCurrentGroup.Position := spTop;
          FCurrentGroup.Height  := Self.Height - FButtonHeight * (FGroupCount - 1) - 2;
     end;
end;

procedure TVSOutlookBar.SetCurrentGroup(Group : TVSOutLookGroup);
begin
    if csLoading in ComponentState then
    begin
         FCurrentGroup := Group;
         exit;
    end;
    if FChanging = True then exit;
    FChanging := True;
    if FCurrentGroup <> Group then
    begin
        ChangeGroup(Group);
    end;
    FChanging := False;
end;

procedure TVSOutlookBar.GroupButtonClick(Sender: TObject);
var
  Form: TCustomForm;
begin
        ChangeGroup(Sender);
        if csDesigning in ComponentState then
        begin
          Form := GetParentForm(Self);
          if (Form <> nil) and (Form.Designer <> nil) then Form.Designer.Modified;
        end;
end;


procedure TVSOutlookBar.ChangeGroup(Sender: TObject);
var i,j,h : integer;
    y : double;
    Group : TVSOutlookGroup;
    s1,s2 : integer;
begin
     Group := TVSOutlookGroup(Sender);
     if Group.Position = spTop then exit;

     if (FCurrentGroup.Index = 1) then
     begin
          for i := FGroupCount downto Group.Index  + 1 do
              FGroups[i].Align := alNone;
     end
     else
     begin
         if FCurrentGroup.Index = FGroupCount - 1 then
         begin
              if Group.Index <> FGroupCount then
             FGroups[FGroupCount].Align := alNone
         end
         else
         begin
             if FCurrentGroup.Index <> FGroupCount then
             begin
                  if Group.Index < FCurrentGroup.Index then
                  begin
                     for i := FGroupCount downto FCurrentGroup.Index + 1   do
                         FGroups[i].Align := alNone
                  end
                  else
                  begin
                     for i := FGroupCount downto Group.Index + 1 do
                         FGroups[i].Align := alNone
                  end;
             end;
         end;
     end;


     h := FCurrentGroup.Height;
     i := 1;
     if (csDesigning in ComponentState) then
        j := 50
     else
        j := FSlideSpeed;

     //need to make this use some sort of curve like in OL98
     while i <= 200 do
     begin
        y := i / 200 * h;
        s1 := Max(h - round(y),Group.ButtonHeight );
        s2 := (h - s1) + Group.ButtonHeight;
        FCurrentGroup.Height := s1;
        Group.Height := s2;
        Application.ProcessMessages;
        Inc(i,j);
     end;
     Group.Height := h;
     FCurrentGroup.Height := FCurrentGroup.ButtonHeight ;

     if (FCurrentGroup.Index = 1) then
     begin
          for i := Group.Index  + 1 to FGroupCount do
              FGroups[i].Align := alTop;
     end
     else
     begin
         if FCurrentGroup.Index = FGroupCount - 1 then
         begin
              if Group.Index <> FGroupCount then
             FGroups[FGroupCount].Align := alTop
         end
         else
         begin
             if FCurrentGroup.Index <> FGroupCount then
             begin
                  if Group.Index < FCurrentGroup.Index then
                  begin
                     for i := FCurrentGroup.Index + 1 to FGroupCount do
                         FGroups[i].Align := alTop
                  end
                  else
                  begin
                     for i :=Group.Index + 1  to  FGroupCount do
                         FGroups[i].Align := alTop
                  end;
             end;
         end;
     end;
     FcurrentGroup.Position := spBottom;
     FCurrentGroup := Group;
     FcurrentGroup.Position := spTop;
     if assigned(FOnGroupChange) then
        FOnGroupChange(Self,FcurrentGroup);
end;


procedure TVSOutlookBar.Resize;
begin
     inherited;
     if FCurrentGroup <> nil then
          FCurrentGroup.Height := Self.Height - FCurrentGroup.ButtonHeight * (FGroupCount - 1) - 2;
end;

function TVSOutlookBar.AddNewGroup(caption : string) : TVSOutLookGroup;
var newGroup : TVSOutLookGroup;
begin
   newGroup := TVSOutLookGroup.Create(Self.Owner);
   newGroup.Name := UniqueName(newGroup);
   newGroup.Parent := Self;
   newGroup.ButtonCaption := caption;
   newGroup.Caption := '';
   newGroup.ButtonHeight := FButtonHeight;
   newGroup.ButtonFont := FButtonFont;
   AddGroup(newGroup);
   result := FCurrentGroup;
end;


procedure TVSOutlookBar.AddGroup(Group : TVSOutlookGroup);
var i : integer;
begin
     Inc(FGroupCount);
     SetLength(FGroups,FGroupCount + 1);
     FGroups[FGroupCount] := Group;
     if not (csLoading in ComponentState) then
     begin
         Group.ob := self;
         Group.ButtonHeight := FButtonHeight;
         Group.ButtonFont := FButtonFont;
         Group.Index := FGroupCount;
         if FGroupCount = 1 then
         begin
             Group.Align := alClient;
             Group.Align := alTop;
             Group.Position := spTop;
         end
         else
         begin
                 for i := FGroupCount downto 1 do
                 begin
                      FGroups[i].Height := FButtonHeight;
                      FGroups[i].Position := spBottom;
                 end;
                 Group.Top := (FGroupCount - 1) * Group.ButtonHeight;
                 Group.Align := alClient;
                 Group.Position := spTop;
                 Group.Align := alTop;
         end;
         Group.Index := FGroupCount;
         FCurrentGroup := Group;
     end
     else
         Group.Position := spBottom;
     FCurrentGroup := Group;
     Group.OnButtonClick := GroupButtonClick;

end;

procedure TVSOutlookBar.RemoveGroup(Group : TVSOutlookGroup);
begin


end;

procedure TVSOutlookBar.Notification(AComponent: TComponent;
      Operation: TOperation);
var i : integer;
    Group : TVSOutLookGroup;
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) and (AComponent  is TVSOutLookGroup) then
  begin
     Group := TVSOutLookGroup(AComponent);
     if Group.ob = Self then
     begin
          if FGroupCount = 1 then
          begin
              Dec(FGroupCount);
              SetLength(FGroups,FGroupCount + 1);
              FCurrentGroup := nil;
              exit;
          end;
          if Group.Index = FGroupCount then
          begin
              Dec(FGroupCount);
              SetLength(FGroups,FGroupCount + 1);
              if FGroupCount = 1 then
              begin
                   FGroups[FGroupCount].Height := self.Height - 1;
                   FGroups[FGroupCount].Align := alClient;
                   FGroups[FGroupCount].Align := alTop;
                   FGroups[FGroupCount].Index := 1;
                   FGroups[FGroupCount].Position := spTop;
              end
              else
              begin
                 for i := FGroupCount - 1 downto 1 do
                 begin
                     FGroups[i].Height := FButtonHeight;
                     FGroups[i].Position := spBottom;
                 ///    FGroups[i].Index := i;
                 end;
                 FGroups[FGroupCount].Height := self.Height - 1 - FGroups[FGroupCount].Top;
              end;
              FCurrentGroup := FGroups[FGroupCount];
          end
          else
          begin
               for i := TVSOutLookGroup(AComponent).Index  to FGroupCount -1 do
               begin
                    FGroups[i] := FGroups[i + 1];
                    FGroups[i].Index := i;
               end;
               Dec(FGroupCount);
               SetLength(FGroups,FGroupCount + 1);

               if TVSOutLookGroup(AComponent) = FCurrentGroup then
               begin
                   FGroups[FGroupCount].Height := self.Height - 1 - FGroups[FGroupCount].Top;
                   FCurrentGroup := FGroups[FGroupCount];
                   if FGroupCount = 1 then
                      FCurrentGroup.Position := spTop;
               end
               else
               begin
                  FCurrentGroup := FGroups[FGroupCount];
                  FCurrentGroup.Height := FCurrentGroup.Height + FCurrentGroup.ButtonHeight;
               end;
          end;
     end;
  end;
end;

procedure TVSOutlookBar.SetButtonHeight(value : integer);
var i : integer;
begin
    if value <> FButtonHeight then
    begin
        if value >= 10 then
        begin
            FButtonHeight := Value;
            if not (csLoading in ComponentState) then
            begin
                if FGroupCount > 0 then
                begin
                     for i := 1 to FGroupCount do
                     begin
                         FGroups[i].ButtonHeight := FButtonHeight;
                         if FGroups[i] <> FCurrentGroup then
                           FGroups[i].Height := FButtonHeight;
                        FCurrentGroup.Height := self.Height - 2 - (FGroupCount - 1)*FButtonHeight;

                     end;
                end;
            end;
        end
        else
            raise Exception.Create('Minimum button height is 10');
    end;
end;

procedure TVSOutlookBar.SetSlideSpeed(value : integer);
begin
    if FSlideSpeed <> value then
    begin
        if( Value > 100) or (value < 1) then
            raise Exception.Create('SlideSpeed must be between 1 an 100 !')
        else
            FSlideSpeed := value;

    end;

end;

procedure TVSOutlookBar.SetButtonFont(value : TFont);
var i : integer;
begin
     FButtonFont.Assign(Value);
     if not (csLoading in ComponentState) then
     begin
       if FGroupCount > 0 then
          for i := 1 to FGroupCount do
              FGroups[i].ButtonFont := FButtonFont;
     end;
end;

function TVSOutlookBar.GetGroup(index : integer) : TVSOutLookGroup;
begin
     if (index < 0 ) or (index > FGroupCount) then
        result := nil
     else
        result := FGroups[index];
end;

function TryName(const Test: string; Comp: TComponent): Boolean;
var
  I: Integer;
begin
  Result := False;
  for I := 0 to Comp.ComponentCount-1 do
    if CompareText(Comp.Components[I].Name, Test) = 0 then
      Exit;
  Result := True;
end;

function TVSOutlookBar.UniqueName(Comp: TComponent): string;
var
  I: Integer;
  Fmt: string;
begin
  if Comp.ClassName[1] in ['t','T'] then
    Fmt := Copy(Comp.ClassName, 2, 255) + '%d'
  else
    Fmt := Comp.ClassName + '%d';

  if Comp.Owner = nil then
  begin
    Result := Format(Fmt, [1]);
    Exit;
  end
  else
  begin
    for I := 1 to High(Integer) do
    begin
      Result := Format(Fmt, [I]);
      if TryName(Result, Comp.Owner) then
        Exit;
    end;
  end;
  raise Exception.CreateFmt('Cannot create unique name for %s.', [Comp.ClassName]);
end;

procedure TVSOutlookBar.WMEraseBkgnd(var Message: TWmEraseBkgnd);
begin
    message.Result := 1;
end;



end.
