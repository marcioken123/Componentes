unit VSObarEdit;

interface
uses
    classes,VSOutlookBar,VSOLGroup,dsgnintf;



type
    TVSOutLookBarEditor = class(TComponentEditor)
    public
      procedure ExecuteVerb(index : integer);override;
      function GetVerb(index : integer) : string;override;
      function GetVerbCount : integer ;override;
    end;

type
  TVSOutLookBarProperty = class(TComponentProperty)
  public
    procedure GetValues(Proc: TGetStrProc); override;
  end;

procedure Register;

implementation

uses
    Dialogs;

procedure Register;
begin
  RegisterComponentEditor(TVSOutlookBar,TVSOutlookBarEditor);
  RegisterComponentEditor(TVSOutlookGroup,TVSOutlookBarEditor);
  RegisterPropertyEditor(TypeInfo(TVSOutLookGroup),TVSOutLookBar,'ActiveGroup',TVSOutLookBarProperty);
end;

// component editor ************************************************************

procedure TVSOutLookBarEditor.ExecuteVerb(index : integer);
var newGroup : TVSOutLookGroup;
    Designer: IFormDesigner;
    OB : TVSOutLookBar;
    i : integer;
begin
   OB := nil;
   if Component is TVSOutLookBar then
      OB := TVSOutLookBar(Component);
   if Component is TVSOutLookGroup then
      OB := TVSOutLookBar(TVSOutLookGroup(Component).Parent);
   Designer := Self.Designer;
   if OB = nil then exit;

   case index of
     2 :
     begin
       if OB <> nil then
       begin
           if IsInInlined = False then
           begin
             newGroup := TVSOutLookGroup.Create(Designer.GetRoot);
             newGroup.Name := Designer.UniqueName(TVSOutLookGroup.ClassName);
             newGroup.Parent := OB;
             newGroup.ButtonCaption := newGroup.Name;
             OB.AddGroup(newGroup);
             Designer.SelectComponent(newGroup);
             Designer.Modified;
           end
           else
              ShowMessage('Cannot add a group when in a Frame Instance');  
       end;
     end;
     3:
     begin
          newgroup := OB.ActiveGroup;
          i := newgroup.Index;
          if i < OB.GroupCount then
             newgroup := OB.Groups[i + 1]
          else
             newgroup := OB.Groups[1];
           OB.ActiveGroup := newgroup;
           Designer.SelectComponent(newGroup);
           Designer.Modified;
     end;
     4:
     begin
          newgroup := OB.ActiveGroup;
          i := newgroup.Index;
          if i > 1 then
             newgroup := OB.Groups[i - 1]
          else
             newgroup := OB.Groups[OB.GroupCount];
           OB.ActiveGroup := newgroup;
           Designer.SelectComponent(newGroup);
           Designer.Modified;
     end;
     5:
     begin
           Designer.SelectComponent(OB);
           Designer.Modified;
     end;


     else

   end;
end;

function TVSOutLookBarEditor.GetVerb(index : integer) : string;
begin
     case index of
          0:    result := 'VSOutLookBar (c)1999 VSoft Technologies';
          1:    result := '-';
          2:    result := '&Add Group';
          3:    result := '&Next Group';
          4:    result := '&Previous Group';
          5:    result := '&Select OutlookBar';
     end;
end;

function TVSOutLookBarEditor.GetVerbCount : integer ;
begin
    result := 6;
end;



procedure TVSOutLookBarProperty.GetValues(Proc: TGetStrProc);
var i : integer;
    bar : TVSOutLookBar;
    s : string;
begin
    bar := TVSOutLookBar(Self.GetComponent(0));
    if bar <> nil then
    begin
         if bar.GroupCount > 0 then
         begin
            For i := 1 to bar.GroupCount do
            begin
               s := bar.Groups[i].Name;
               Proc(s);
            end;
         end;
    end;
end;

end.
