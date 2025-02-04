unit GLSceneEditVis;

interface 

{$i GLScene.inc}
{$IFDEF LINUX}{$Message Error 'Unit not supported'}{$ENDIF LINUX}


uses
   Windows,Forms,SysUtils,GLWin32Viewer, Buttons, StdCtrls, ExtCtrls ,
   Geometry,GLMisc,VectorTypes,GLObjects,GLSceneEdit, GLNavigator,
   GLScene, Classes,ComCtrls,ActnList,Controls,Dialogs, ImgList, Menus,
   ToolWin,AsyncTimer,Graphics,GLFileQ3BSP,GLTexture,Jpeg,TGA,GLVectorFileObjects,GLFile3DS,FileOCT,GLFileOCT,
   VectorLists,
   ShellApi,Octree,UGLExtraObjects,
   {$ifdef GLS_DELPHI_6_UP} DesignIntf, Grids {$else} DsgnIntf {$endif};


const
     ImgIdxTarget = 1;
     ImgIdxCamera = 4;

   
type
  TGLSceneEditorFormVis = class(TGLSceneEditorForm)
    XPanel8: TPanel;
    XPanel2: TPanel;
    GLSceneViewer: TGLSceneViewer;
    ActionListGlared: TActionList;
    actUndo: TAction;
    actKeybEdit: TAction;
    actTarget: TAction;
    ImageListGlared: TImageList;
    OpenDialog3DS: TOpenDialog;
    XToolbarGlared: TToolBar;
    XToolbutton15: TToolButton;
    XToolbutton16: TToolButton;
    XToolbutton17: TToolButton;
    GLNavigator: TGLNavigator;
    actLoadFreeForms: TAction;
    XToolbutton18: TToolButton;
    XToolbutton19: TToolButton;
    XToolbutton20: TToolButton;
    actUseThisCamera: TAction;
    XToolbutton21: TToolButton;
    AsyncTimer: TAsyncTimer;
    XSplitter1: TSplitter;
    PanEdits: TPanel;
    XToolbutton22: TToolButton;
    PanMouseStart: TPanel;
    ImageListLarge: TImageList;
    imgMouseCamera: TImage;
    actCameraUpY: TAction;
    XToolbutton23: TToolButton;
    XToolbutton24: TToolButton;
    actCopyProperties: TAction;
    actPasteProperties: TAction;
    XToolbutton25: TToolButton;
    XToolbutton26: TToolButton;
    PopupMenuLoadFF: TPopupMenu;
    Specifynew1: TMenuItem;
    ChkQ3BspLoadMaterials: TCheckBox;
    actAllocateMaterials: TAction;
    actCheckMaterialspath: TAction;
    XToolbutton27: TToolButton;
    XToolbutton28: TToolButton;
    pan_Meshes: TPanel;
    XSplitter2: TSplitter;
    pan_meshes_down: TPanel;
    pan_meshes_up: TPanel;
    XSplitter3: TSplitter;
    tvMeshes: TTreeView;
    pan_meshes_Title_up: TPanel;
    lvMats: TListBox;
    XPanel1: TPanel;
    ActSaveGLMS: TAction;
    actSaveTriMats: TAction;
    actLoadTriMats: TAction;
    ActSaveOCTFile: TAction;
    ActLoadOCTFile: TAction;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    PanGrid: TPanel;
    lblgX: TLabel;
    lblgY: TLabel;
    lblgZ: TLabel;
    Shape1: TShape;
    Shape2: TShape;
    Shape3: TShape;
    xLabel9: TLabel;
    xLabel10: TLabel;
    xLabel11: TLabel;
    TrackBarGridX: TTrackBar;
    TrackBarGridY: TTrackBar;
    TrackBarGridZ: TTrackBar;
    ChkGridLock: TCheckBox;
    chkGrid: TCheckBox;
    PanPosScal: TPanel;
    XSpeedbutton1: TSpeedButton;
    xLabel2: TLabel;
    xLabel12: TLabel;
    XSpeedbutton8: TSpeedButton;
    XSpeedbutton9: TSpeedButton;
    xLabel13: TLabel;
    XSpeedbutton10: TSpeedButton;
    edtScaleX: TEdit;
    edtScaleY: TEdit;
    edtScaleZ: TEdit;
    edtX: TEdit;
    edtY: TEdit;
    edtZ: TEdit;
    edtHint: TEdit;
    PanUpDir: TPanel;
    XSpeedbutton2: TSpeedButton;
    XSpeedbutton3: TSpeedButton;
    XSpeedbutton4: TSpeedButton;
    XSpeedbutton5: TSpeedButton;
    XSpeedbutton6: TSpeedButton;
    XSpeedbutton7: TSpeedButton;
    xLabel3: TLabel;
    xLabel8: TLabel;
    XSpeedbutton11: TSpeedButton;
    XToolbar3: TToolBar;
    XToolbutton33: TToolButton;
    xLabel1: TLabel;
    xLabel4: TLabel;
    XToolbutton31: TToolButton;
    actRunFSRad: TAction;
    XToolbutton34: TToolButton;
    xLabel5: TLabel;
    xLabel6: TLabel;
    xLabel7: TLabel;
    XToolbutton38: TToolButton;
    xLabel14: TLabel;
    XToolbutton30: TToolButton;
    DummyEDT: TEdit;
    ActSetOCTFilename: TAction;
    XPanel3: TPanel;
    XSpeedbutton12: TSpeedButton;
    edtOctGamma: TEdit;
    xLabel15: TLabel;
    xLabel16: TLabel;
    edtOctBright: TEdit;
    grdMatrix: TStringGrid;
    procedure DummyEDTExit(Sender: TObject);
    procedure edtHintKeyPress(Sender: TObject; var Key: Char);
    procedure GLSceneViewerMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure GLSceneViewerMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
    procedure GLSceneViewerMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure XSpeedbutton10Click(Sender: TObject);
    procedure XSpeedbutton1Click(Sender: TObject);
    procedure XSpeedbutton2Click(Sender: TObject);
    procedure XSpeedbutton3Click(Sender: TObject);
    procedure XSpeedbutton4Click(Sender: TObject);
    procedure XSpeedbutton5Click(Sender: TObject);
    procedure XSpeedbutton6Click(Sender: TObject);
    procedure XSpeedbutton7Click(Sender: TObject);
    procedure XSpeedbutton8Click(Sender: TObject);
    procedure XSpeedbutton9Click(Sender: TObject);
    procedure TrackBarGridZChange(Sender: TObject);
    procedure actUndoExecute(Sender: TObject);
    procedure actKeybEditExecute(Sender: TObject);
    procedure actTargetExecute(Sender: TObject);
    procedure actUseThisCameraExecute(Sender: TObject);
    procedure actLoadFreeFormsExecute(Sender: TObject);
    procedure AskFFPaths;
    procedure FormCreate(Sender: TObject);
    procedure AsyncTimerTimer(Sender: TObject);
    procedure DummyEDTKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormMouseWheel(Sender: TObject; Shift: TShiftState;
      WheelDelta: Integer; MousePos: TPoint; var Handled: Boolean);
    procedure TreeChange(Sender: TObject; Node: TTreeNode);
    procedure ACLoadSceneExecute(Sender: TObject);
    procedure FormDeactivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ACDeleteObjectExecute(Sender: TObject);
    procedure actCameraUpYExecute(Sender: TObject);
    procedure actCopyPropertiesExecute(Sender: TObject);
    procedure actPastePropertiesExecute(Sender: TObject);
    procedure Specifynew1Click(Sender: TObject);
    procedure TreeEnter(Sender: TObject);
    procedure edtScaleXKeyPress(Sender: TObject; var Key: Char);
    procedure ChkQ3BspLoadMaterialsClick(Sender: TObject);
    procedure actAllocateMaterialsUpdate(Sender: TObject);
    procedure actAllocateMaterialsExecute(Sender: TObject);
    procedure actCheckMaterialspathExecute(Sender: TObject);
    procedure lvMatsDrawItem(Control: TWinControl; Index: Integer;
      Rct: TRect; State: TOwnerDrawState);
    procedure lvMatsDblClick(Sender: TObject);
    procedure ActSaveGLMSExecute(Sender: TObject);
    procedure ActSaveGLMSUpdate(Sender: TObject);
    procedure actSaveTriMatsExecute(Sender: TObject);
    procedure actLoadTriMatsExecute(Sender: TObject);
    procedure actSaveTriMatsUpdate(Sender: TObject);
    procedure actLoadTriMatsUpdate(Sender: TObject);
    procedure XSpeedbutton11Click(Sender: TObject);
    procedure tvMeshesClick(Sender: TObject);
    procedure ActSaveOCTFileExecute(Sender: TObject);
    procedure actRunFSRadExecute(Sender: TObject);
    procedure ActLoadOCTFileExecute(Sender: TObject);
    procedure ActSetOCTFilenameExecute(Sender: TObject);
    procedure ActSaveOCTFileUpdate(Sender: TObject);
    procedure ActLoadOCTFileUpdate(Sender: TObject);
    procedure actRunFSRadUpdate(Sender: TObject);
    procedure ActSetOCTFilenameUpdate(Sender: TObject);
    procedure XSplitter3Moved(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure edtOctBrightChange(Sender: TObject);
    procedure ActionListGlaredUpdate(Action: TBasicAction;
      var Handled: Boolean);
  private
    { Private declarations }
    FScene: TGLScene;
    FCurrentDesigner: {$ifdef GLS_DELPHI_6_UP} IDesigner {$else} IFormDesigner {$endif};
    FPickedObj: TGLBaseSceneObject;
    FCameraObj : TGLCamera;
    FSelectedFaceGroup : TFaceGroup;
    SelectedFaceGroupMaterialName: string;
    SelectedFreeForm : TGLFreeForm;
    pickingFaceGroup : boolean;
    xx,yy : integer;
    procedure SetPickedObj(const Value: TGLBaseSceneObject);
    procedure SetCameraObj(const Value: TGLCamera);
    procedure SetSelectedFaceGroup(const Value: TFaceGroup);
    procedure tvMesh_BlinkFaceGroupByNode(Node: TTreeNode);
  protected
	 procedure Notification(AComponent: TComponent; Operation: TOperation); override;
  public
    { Public declarations }
    _RotFactorPitch,_RotFactorTurn : integer;
    _FactorShiftX : integer;
    _FactorShiftY : integer;
    MouseStartX : integer;
    MouseStartY : integer;
    tkMouseDown : integer;
    movingOnZ: boolean;
    PickStartX,PickStartY: integer;
    PickedObjOldShowAxis : boolean;
    lastMouseWorldPos,PickedObjOffset : Tvector4f;//TAffineVector;
    undoObj : TGLBaseSceneObject;
    undoX,undoY,undoZ : single;
    undoUpX,undoUpY,undoUpZ : single;
    undoDirX,undoDirY,undoDirZ : single;
    Grid_X,Grid_Y,Grid_Z : Real;
    LastTk : integer;
    CopySrcObj : TGLBaseSceneObject;
    FFPaths : string;
    dmPos : TVector3F;

    procedure SetScene(Scene: TGLScene; Designer: {$ifdef GLS_DELPHI_6_UP} IDesigner {$else} IFormDesigner {$endif});
    procedure UpdateProperties;
    procedure NotifyModify;
    function MouseWorldPos(x, y: Integer): TVector4f;
    procedure UpdateGridValues;
    function FindCameraInScene(Sc: TGLSCene) : TGLCamera;
    property PickedObj : TGLBaseSceneObject read FPickedObj write SetPickedObj;
    property CameraObj : TGLCamera read FCameraObj write SetCameraObj;
    procedure Meshes_FillTV(O:TGLBaseSceneObject);
    property SelectedFaceGroup: TFaceGroup read FSelectedFaceGroup write SetSelectedFaceGroup;
    procedure Begin_Update;
    procedure End_Update;
  end;


function GLSceneEditorFormVis : TGLSceneEditorFormVis;
procedure ReleaseGLSceneEditorFormVis;

implementation

  Uses USceneIO,GLSceneRegister;


{$R *.dfm}


var
   vGLSceneEditorFormVis : TGLSceneEditorFormVis;


function GLSceneEditorFormVis : TGLSceneEditorFormVis;
begin
	if not Assigned(vGLSceneEditorFormVis) then
		vGLSceneEditorFormVis := TGLSceneEditorFormVis.Create(nil);
	Result:=vGLSceneEditorFormVis;
end;


// FindNodeByData
//
function FindNodeByData(treeNodes : TTreeNodes; data : Pointer;baseNode : TTreeNode = nil) : TTreeNode;
var
	n : TTreeNode;
begin
	Result:=nil;
	if Assigned(baseNode) then begin
		n:=baseNode.getFirstChild;
		while Assigned(n) do begin
			if n.Data=data then begin
				Result:=n; Break;
			end else	if n.HasChildren then begin
				Result:=FindNodeByData(treeNodes, data, n);
				if Assigned(Result) then Break;
			end;
			n:=baseNode.GetNextChild(n);
		end;
	end else begin
		n:=treeNodes.GetFirstNode;
		while Assigned(n) do begin
			if n.Data=data then begin
				Result:=n; Break;
			end else	if n.HasChildren then begin
				Result:=FindNodeByData(treeNodes, data, n);
				if Assigned(Result) then Break;
			end;
			n:=n.getNextSibling;
		end;
	end;
end;


// SetScene
//
procedure TGLSceneEditorFormVis.SetScene(Scene: TGLScene;
   Designer: {$ifdef GLS_DELPHI_6_UP} IDesigner {$else} IFormDesigner {$endif});
begin
     inherited SetScene(Scene,Designer);

     FScene := Scene;
     FCurrentDesigner := Designer;

     Caption := Caption + ('- [Glared Express]');

     // Show StateIndex for Target of Camera
     actTarget.Checked := False;
     if GLSceneViewer.Camera<>nil then
     begin
          if GLSceneViewer.Camera.TargetObject<>nil then
          begin
               if FindNodeByData(Tree.Items,GLSceneViewer.Camera.TargetObject)<>nil then
               begin
                    FindNodeByData(Tree.Items,GLSceneViewer.Camera.TargetObject).StateIndex := ImgIdxTarget;
                    actTarget.Checked := True;
               end;
          end;
     end;
     Tree.FullExpand;
     CameraObj := FindCameraInScene(FScene);
end;


function TGLSceneEditorFormVis.FindCameraInScene(Sc: TGLSCene) : TGLCamera;

   function RecourseObjects(OParent : TGLBaseSCeneObject) : TGLCamera;
   var
      t: integer;
   begin
        Result := nil;
        for t := 0 to OParent.Count-1 do
        begin
             if OParent.Children[t] is TGLCamera then
             begin
                  Result := TGLCamera(OParent.Children[t]);
                  Break;
             end;
             Result := RecourseObjects(OParent.Children[t]);
             if Result<>nil then
                Break;
        end;
   end;

begin
     if Sc = nil then
     begin
          Result := nil;
     end
     else
     begin
          Result := RecourseObjects(Sc.Cameras);
          if Result= nil then
             Result := RecourseObjects(Sc.Objects);
     end;
end;


procedure ReleaseGLSceneEditorFormVis;
begin
     try
        if Assigned(vGLSceneEditorFormVis) then
        begin
             vGLSceneEditorFormVis.Free;
        end;
     finally
            vGLSceneEditorFormVis:=nil;
     end;
end;


procedure ClearAllEdits(ParentCtrl : TWinControl);
var
   t: integer;
begin
     for t := 0 to ParentCtrl.ControlCount-1 do
     begin
          if ParentCtrl.Controls[t] is TEdit then
             TEdit(ParentCtrl.Controls[t]).Text := '';
     end;
end;

procedure TGLSceneEditorFormVis.SetCameraObj(const Value: TGLCamera);
var
   N : TTreeNode;
begin
     if assigned(FCameraObj) then
     try
        N := FindNodeByData(Tree.Items,FCameraObj);
        if N<>nil then
           N.StateIndex :=-1;
     except
     end;

     FCameraObj := Value;
     GLSceneViewer.Camera := FCameraObj;
     GLNavigator.MovingObject := FCameraObj;

     if FCameraObj<>nil then
     begin
          N := FindNodeByData(Tree.Items,FCameraObj);
          if N<>nil then
               N.StateIndex := ImgIdxCamera;
     end;

     UpdateProperties;
end;


procedure TGLSceneEditorFormVis.SetPickedObj(const Value: TGLBaseSceneObject);
begin
     if assigned(FPickedObj) then
     try
        FPickedObj.ShowAxes := PickedObjOldShowAxis;
     except
     end;

     FPickedObj := Value;


     if FPickedObj<>nil then
        try
           PickedObjOldShowAxis := FPickedObj.ShowAxes;
           FCurrentDesigner.SelectComponent(FPickedObj);
           FPickedObj.ShowAxes := true;
           Tree.Selected := FindNodeByData(Tree.Items,FPickedObj);
        except
        end;

     UpdateProperties;
end;


procedure TGLSceneEditorFormVis.DummyEDTExit(Sender: TObject);
begin
     actKeybEdit.Checked := False;
end;

procedure TGLSceneEditorFormVis.edtHintKeyPress(Sender: TObject; var Key: Char);
begin
     if Key=#13 then
     begin
          if PickedObj is TGLFreeForm then
          begin
               TGLFreeForm(PickedObj).Hint := edtHint.Text;
          end;
          Key := #0;
          NotifyModify;
     end;

end;




procedure TGLSceneEditorFormVis.GLSceneViewerMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin

     if FScene = nil then
        Exit;

     PickStartX := X;
     PickStartY := Y;
     GLSceneViewer.SetFocus;
     SetCapture(GLSceneViewer.Handle);
     tkMouseDown := GettickCount;

//     try
        movingOnZ:=(ssShift in Shift);


        if (Not (ssAlt in Shift)) and (Button=mbLeft) then
        begin
             PickedObj := GLSceneViewer.Buffer.GetPickedObject(x,y);

             if PickedObj<>nil then
             Begin

                  dmPos := GLSceneViewer.Buffer.PixelRayToWorld(x,y);
                  dmPos := VectorSubtract(PickedObj.Position.AsAffineVector,dmPos);

                  lastMouseWorldPos:=MouseWorldPos(x, y);

                  VectorSubtract(lastMouseWorldPos,PickedObj.Position.AsAffineVector,PickedObjOffset);

                  undoObj := PickedObj;
                  with PickedObj.position do
                  begin
                       undoX := X;
                       undoY := Y;
                       undoZ := Z;
                  end;
                  with PickedObj.Direction do
                  begin
                       undoDirX := X;
                       undoDirY := Y;
                       undoDirZ := Z;
                  end;
                  with PickedObj.Up do
                  begin
                       undoUpX := X;
                       undoUpY := Y;
                       undoUpZ := Z;
                  end;

             end;
             Meshes_FillTV(PickedObj);
        end;

        if (Button=mbRight) and ((ssCTRL in Shift) or (ssSHIFT in Shift)) then
        begin
             MouseStartX := X;
             MouseStartY := Y;
             PanMouseStart.SetBounds(MouseStartX-(PanMouseStart.Width div 2),MouseStartY-(PanMouseStart.Height div 2),PanMouseStart.Width,PanMouseStart.Height);
             PanMouseStart.Visible := true;
        end;

//     except
           //beep;
//     end;
end;


procedure TGLSceneEditorFormVis.GLSceneViewerMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
var
   dV,newPos : Tvector4f;//TAffineVector;
   CamDist : Single;
   ip : TVector;
begin
     xx := x;
     yy := y;
     if GLSceneViewer.Camera=nil then
        Exit;
     if  (PickedObj<>nil) and (ssLeft in Shift) and (Not (ssAlt in Shift)) then // ROTATE/MOVE OBJECT  ----------------------
     Begin
          if actTarget.Checked then
             actTarget.Execute;

          if ssCtrl in Shift then
          Begin
               // ROTATE
               PickedObj.TurnAngle := PickedObj.TurnAngle + ((X-PickStartX) / _RotFactorTurn);
               PickedObj.PitchAngle := PickedObj.PitchAngle + ((Y-PickStartY) / _RotFactorPitch);
          end
          else
          Begin
                if ssShift in Shift then
                begin
                   GLSceneViewer.Buffer.ScreenVectorIntersectWithPlaneXY(
                      VectorMake(X, GLSceneViewer.Height-Y, 0, 0), PickedObj.Position.Z-dmPos[2], ip);

                   ip := VectorAdd(ip , VectorMake(dmPos));
                   PickedObj.Position.AsVector:=ip;
                end
                else
                begin
                      GLSceneViewer.Buffer.ScreenVectorIntersectWithPlaneXZ(
                            VectorMake(X, GLSceneViewer.Height-Y, 0, 0), PickedObj.Position.Y-dmPos[1], ip);

                      ip := VectorAdd(ip , VectorMake(dmPos));
                      PickedObj.Position.AsVector:=ip;
                end;
          end;

          GLSceneViewer.Invalidate;
          UpdateProperties;
     end;



     if (ssRight in Shift) and (not  PanMouseStart.Visible) and (Not (ssAlt in Shift)) then
     begin
          // ROTATE
          if GLSceneViewer.Camera.TargetObject<>nil then
          Begin
               // Rotate around Object
               GLSceneViewer.Camera.MoveAroundTarget((PickStarty-y) / _RotFactorPitch   ,   (PickStartX-X) / _RotFactorTurn );
          end
          else
          Begin
               // Rotate around Itself
                  GLNavigator.TurnVertical((PickStartY-Y) / _RotFactorPitch);
                  GLNavigator.TurnHorizontal(((X-PickStartX) / _RotFactorTurn));
          end;
          GLSceneViewer.Invalidate;
     end;

     PickStartX := X;
     PickStartY := Y;

end;

procedure TGLSceneEditorFormVis.GLSceneViewerMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
     PanMouseStart.Visible := False;
     imgMouseCamera.Tag := 0;
     ReleaseCapture;
     NotifyModify;
end;

procedure TGLSceneEditorFormVis.XSpeedbutton10Click(Sender: TObject);
var
   CurrDir: string;
begin
     if PickedObj<>nil then
     begin
          CurrDir := GetCurrentDir;
          if OpenDialog3DS.Execute then
          begin
               if PickedObj is TGLFreeForm then
               begin
                    TGLFreeForm(PickedObj).Hint :=OpenDialog3DS.FileName;
                    FScene.BeginUpdate;
                    try
                       TGLFreeForm(PickedObj).LoadFromFile(OpenDialog3DS.FileName);
                    finally
                           FScene.EndUpdate;
                    end;
                    NotifyModify;
                    UpdateProperties;
               end;
               ChDir(CurrDir);
          end;
     end;
end;

procedure TGLSceneEditorFormVis.XSpeedbutton1Click(Sender: TObject);
begin
     PickedObj.Scale.SeTvector(StrToFloat(edtScaleX.Text),StrToFloat(edtScaleY.Text),StrToFloat(edtScaleZ.Text));
     NotifyModify;
end;

procedure TGLSceneEditorFormVis.XSpeedbutton2Click(Sender: TObject);
begin
     PickedObj.Up.SeTvector(1,0,0);
     NotifyModify;
end;

procedure TGLSceneEditorFormVis.XSpeedbutton3Click(Sender: TObject);
begin
     PickedObj.Up.SeTvector(0,1,0);
     NotifyModify;
end;

procedure TGLSceneEditorFormVis.XSpeedbutton4Click(Sender: TObject);
begin
     PickedObj.Up.SeTvector(0,0,1);
     NotifyModify;
end;

procedure TGLSceneEditorFormVis.XSpeedbutton5Click(Sender: TObject);
begin
     PickedObj.Direction.SeTvector(1,0,0);
     NotifyModify;
end;

procedure TGLSceneEditorFormVis.XSpeedbutton6Click(Sender: TObject);
begin
     PickedObj.Direction.SeTvector(0,1,0);
     NotifyModify;
end;

procedure TGLSceneEditorFormVis.XSpeedbutton7Click(Sender: TObject);
begin
     PickedObj.Direction.SeTvector(0,0,1);
     NotifyModify;
end;

procedure TGLSceneEditorFormVis.XSpeedbutton8Click(Sender: TObject);
begin
     PickedObj.Position.SetPoint(StrToFloat(edtX.Text),StrToFloat(edtY.Text),StrToFloat(edtZ.Text));
     NotifyModify;
end;

procedure TGLSceneEditorFormVis.XSpeedbutton9Click(Sender: TObject);
begin
     edtX.Text := Floattostr(Round(StrToFloat(edtX.Text)));
     edtY.Text := Floattostr(Round(StrToFloat(edtY.Text)));
     edtZ.Text := Floattostr(Round(StrToFloat(edtZ.Text)));
     XSpeedbutton8Click(Self);
end;


procedure TGLSceneEditorFormVis.TrackBarGridZChange(Sender: TObject);
begin
     if ChkGridLock.Checked then
     begin
          TrackBarGridX.Position := TTrackBar(Sender).Position;
          TrackBarGridY.Position := TTrackBar(Sender).Position;
          TrackBarGridZ.Position := TTrackBar(Sender).Position;
     end;
     UpdateGridValues;
end;



procedure TGLSceneEditorFormVis.actUndoExecute(Sender: TObject);
begin
  inherited;
     if undoObj<>nil then
     try
        undoObj.Position.X := undoX;
        undoObj.Position.Y := undoY;
        undoObj.Position.Z := undoZ;
        undoObj.Up.SetVector(undoUpX,undoUpY,undoUpZ);
        undoObj.Direction.SetVector(undoDirX,undoDirY,undoDirZ);
     except
     end;
     NotifyModify;
end;

procedure TGLSceneEditorFormVis.actKeybEditExecute(Sender: TObject);
begin
  inherited;
  DummyEDT.SetFocus;
end;

procedure TGLSceneEditorFormVis.actTargetExecute(Sender: TObject);
var
   CurrTargObj: TGLBaseSceneObject;
begin
     inherited;
     if GLSceneViewer.Camera.TargetObject<>nil then
     try
        FindNodeByData(Tree.Items,GLSceneViewer.Camera.TargetObject).StateIndex:=-1;
     except
     end;

     if actTarget.Checked then
     begin
          if Tree.Selected<>nil then
          begin
               GLSceneViewer.Camera.PointTo(TGLBaseSceneObject(Tree.Selected.Data),VectorMake(GLNavigator.VirtualUp.AsAffineVector,0));
               GLSceneViewer.Camera.TargetObject := TGLBaseSceneObject(Tree.Selected.Data);
               Tree.Selected.StateIndex := ImgIdxTarget;
          end
          else
          begin
               actTarget.Checked := false;
          end;
     end
     else
     begin
          CurrTargObj := GLSceneViewer.Camera.TargetObject;
          GLSceneViewer.Camera.TargetObject := nil;
          if CurrTargObj<>nil then
          begin
               GLSceneViewer.Camera.PointTo(CurrTargObj,VectorMake(GLNavigator.VirtualUp.AsAffineVector,0));
          end;
     end;
     NotifyModify;
end;

procedure TGLSceneEditorFormVis.actUseThisCameraExecute(Sender: TObject);
begin
  inherited;
  CameraObj := TGLCamera(Tree.Selected.Data);
end;

procedure TGLSceneEditorFormVis.actLoadFreeFormsExecute(Sender: TObject);
begin
  inherited;
  try
     BEGIN_UPDATE;

     ChkQ3BspLoadMaterialsClick(self);

     AskFFPaths;

     if FFPaths<>'' then
     begin
          if FFPaths[Length(FFPaths)]<>'\' then
             FFPaths := FFPaths + '\';
          LoadFreeFormFilesFromHint(FScene.Objects,FFPaths,False,False);
     end;

     Meshes_FillTV(PickedObj);
  finally
         End_Update;
  end;

end;

procedure TGLSceneEditorFormVis.AskFFPaths;
var
   pth: string;
begin
    if FFPaths='' then
    begin
         pth := InputBox('Free Forms path','Path where the free forms can be found:',GetCurrentDir);
         FFPaths := pth;
    end;
end;


procedure TGLSceneEditorFormVis.UpdateProperties;
begin
     if PickedObj<>nil then
     begin
          edtScaleX.Text := Floattostr(PickedObj.Scale.X);
          edtScaleY.Text := Floattostr(PickedObj.Scale.Y);
          edtScaleZ.Text := Floattostr(PickedObj.Scale.Z);

          edtX.Text := Floattostr(PickedObj.Position.X);
          edtY.Text := Floattostr(PickedObj.Position.Y);
          edtZ.Text := Floattostr(PickedObj.Position.Z);

          if PickedObj is TGLFreeForm then
             edtHint.Text := TGLFreeForm(PickedObj).Hint
          else
              edtHint.Text := '';
     end;

     panPosScal.Enabled := PickedObj<>nil;
     PanUpDir.Enabled := PickedObj<>nil;


     if not panPosScal.Enabled then
        ClearAllEdits(panPosScal);
     if not PanUpDir.Enabled then
        ClearAllEdits(PanUpDir);

end;

procedure TGLSceneEditorFormVis.NotifyModify;
begin
     FCurrentDesigner.Modified;
end;

function TGLSceneEditorFormVis.MouseWorldPos(x, y : Integer) : Tvector4f;//TAffineVector;
var
   v :  Tvector4f;//TAffineVector;
begin
   try
      y:=GLSceneViewer.Height-y;
      if Assigned(PickedObj) then
      begin
         SeTvector(v, x, y, 0);
         if movingOnZ then
             GLSceneViewer.Buffer.ScreenVectorIntersectWithPlaneXY(v, PickedObj.Position.Z, Result)
         else
             GLSceneViewer.Buffer.ScreenVectorIntersectWithPlaneXZ(v, PickedObj.Position.Y, Result);

      end
      else
          SeTvector(Result, NullVector);
   except
   end;
end;


procedure TGLSceneEditorFormVis.UpdateGridValues;
Begin
     Grid_X := 11 - (TrackBarGridX.Position);
     Grid_Y := 11 - (TrackBarGridY.Position);
     Grid_Z := 11 - (TrackBarGridZ.Position);

     lblgX.Caption := '1/'+Floattostr(Grid_X);
     lblgY.Caption := '1/'+Floattostr(Grid_Y);
     lblgZ.Caption := '1/'+Floattostr(Grid_Z);
end;

procedure TGLSceneEditorFormVis.FormCreate(Sender: TObject);
begin
  ObjectManager.RegisterSceneObject(TGLDummyCubeLight, 'DummyCubeLightMap', 'Extra Objects');
  ObjectManager.RegisterSceneObject(TGLDummyCubeCull, 'DummyCubeCull', 'Extra Objects');
  inherited;
  DummyEDT.Left := -100;

  _RotFactorPitch := 2;
  _RotFactorTurn := 2;
  _FactorShiftX := 100;
  _FactorShiftY := 100;

  AsyncTimer.ThreadPriority := tpTimeCritical;
  TrackBarGridZChange(self);

  PanMouseStart.Parent := GLSceneViewer;
  Height := Screen.height;
  Top := 0;
  Left := 200;
  Width := Screen.width-200;
end;

procedure TGLSceneEditorFormVis.AsyncTimerTimer(Sender: TObject);
var
   stp : real;

   rayStart, rayVector, iPoint, iNormal : TVector;
   triangle: TOctreeTriangleInfo;
   t,u,v: integer;
   VL : TFGVertexIndexList;
   vx,vy,vz : single;
   d,dist : Real;
   absPos : TVector4F;
   TheFG : TFaceGroup;
   N : TTreeNode;

begin
     inherited;

     stp := (GetTickCount-LastTk) * 0.001;
     if stp>16 then
        stp := 16;

     if PanMouseStart.Visible then
     begin
          GLNavigator.VirtualUp := GLSceneViewer.Camera.Up;
          if GetKeyState(VK_CONTROL)<-10 then
          begin
               if abs(PickStartX-MouseStartX)>4 then // a little tollarance
                  GLNavigator.StrafeHorizontal(stp*(PickStartX-MouseStartX));
               if abs(MouseStartY-PickStartY)>4 then // a little tollarance
                  GLNavigator.StrafeVertical(stp*(MouseStartY-PickStartY));

               if imgMouseCamera.Tag<>1 then
               begin
                    ImageListLarge.GetBitmap(0,imgMouseCamera.Picture.Bitmap);
                    imgMouseCamera.Tag := 1;
                    imgMouseCamera.Repaint;
               end;

          end
          else
          if GetKeyState(VK_SHIFT)<-10 then
          begin
               if abs(PickStartX-MouseStartX)>4 then // a little tollarance
                  GLNavigator.StrafeHorizontal(stp*(PickStartX-MouseStartX));
               if abs(MouseStartY-PickStartY)>4 then // a little tollarance
                  GLNavigator.MoveForward(stp*(MouseStartY-PickStartY));
               if imgMouseCamera.Tag<>2 then
               begin
                    ImageListLarge.GetBitmap(1,imgMouseCamera.Picture.Bitmap);
                    imgMouseCamera.Tag := 2;
                    imgMouseCamera.Repaint;
               end;
          end;

     end;

     // PICK A FACEGROUP
     if (GetAsyncKeyState(VK_MENU)<-10) and ((GetAsyncKeyState(VK_CONTROL)<-10)) and (not pickingFaceGroup) then
     begin
          pickingFaceGroup := true;
          try
             if SelectedFreeForm<>nil then
             begin
                  absPos := SelectedFreeForm.AbsolutePosition;
                  dist := MAXLONG;

                  SetVector(rayStart, GLSceneViewer.Camera.AbsolutePosition);
                  SetVector(rayVector, GLSceneViewer.Buffer.ScreenToVector(AffineVectorMake(xx, GLSceneViewer.Height-yy, 0)));
                  NormalizeVector(rayVector);

                  TheFG := nil;

                  {if SelectedFreeForm.Octree.NodeCount=0 then
                  begin
                       SelectedFreeForm.BuildOctree;
                  end;}

                  //SelectedFreeForm.Octree.RayCastIntersectAABB(RayStart,RayVector,@iPoint,@iNormal,@Triangle);
                  SelectedFreeForm.RayCastIntersect(RayStart,RayVector,@iPoint,@iNormal);
                  //SelectedFreeForm.OctreeRayCastIntersect(RayStart,RayVector,@iPoint,@iNormal);

                  if FScene.Objects.FindChild('DummyIndicator',false)<>nil then
                  begin
                       FScene.Objects.FindChild('DummyIndicator',false).Position.SetPoint(iPoint[0],iPoint[1],iPoint[2]);
                  end;

                  iPoint := SelectedFreeForm.AbsoluteToLocal(iPoint);

                  for t := 0 to SelectedFreeForm.MeshObjects.count-1 do
                  begin
                       for u := 0 to SelectedFreeForm.MeshObjects[t].FaceGroups.Count-1 do
                       begin
                            VL := TFGVertexIndexList(SelectedFreeForm.MeshObjects[t].FaceGroups[u]);

                            vx :=0;
                            vy :=0;
                            vz :=0;
                            for v := 0 to VL.VertexIndices.Count-1 do
                            begin
                                 with SelectedFreeForm.MeshObjects[t] do
                                 begin
                                      vx := vx + Vertices[VL.VertexIndices[v]][0];
                                      vy := vy + Vertices[VL.VertexIndices[v]][1];
                                      vz := vz + Vertices[VL.VertexIndices[v]][2];
                                 end;
                            end;
                            if VL.VertexIndices.Count>0 then
                            begin
                                 // baricenter of vertices
                                 vx := vx / VL.VertexIndices.Count;
                                 vy := vy / VL.VertexIndices.Count;
                                 vz := vz / VL.VertexIndices.Count;
                            end;



                            d := sqrt( sqr(vx-iPoint[0]) + sqr(vy-iPoint[1]) + sqr(vz-iPoint[2]));
                            //d := Abs(vx-iPoint[0]) + Abs(vy-iPoint[1]) + Abs(vz-iPoint[2]);

                            if d < dist then
                            begin
                                 dist := d;
                                 TheFG := VL;
                            end;

                       end;
                  end;

                  if TheFG<>nil then
                  begin
                       //tvMeshes.Items.BeginUpdate;
                       N := tvMeshes.Items[0];
                       while N<>nil do
                       begin
                            if N.Data = TheFG then
                            begin
                                 N.Selected := true;
                                 tvMesh_BlinkFaceGroupByNode(N);
                                 //N.MakeVisible;
                                 break;
                            end;
                            N := N.GetNext;
                       end;
                       //tvMeshes.Items.EndUpdate;}
                  end;

                  // APPLY MATERIAL TO FACEGROUP
                  if GetAsyncKeyState(VK_LBUTTON)<-10 then
                     lvMatsDblClick(self);
             end;
          finally
                 pickingFaceGroup := false;
          end;
     end;


     for t := 0 to 3 do
     begin
          for u := 0 to 3 do
          begin
               if PickedObj<>nil then
                  grdMatrix.cells[u,t] := Floattostr(PickedObj.Matrix[u,t])
               else
                   grdMatrix.cells[u,t] := '';
          end;
     end;


     LastTk := GetTickCount;
end;


procedure TGLSceneEditorFormVis.DummyEDTKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
var
   Dx,Dy,Dz : Real;
   DTurn,DPitch : Real;
   gx,gy,gz : single;
begin
     if chkGrid.Checked then
     begin
          gx := Grid_X;
          gy := Grid_Y;
          gz := Grid_Z;
     end
     else
     begin
          gx := 100;
          gy := 100;
          gz := 100;
     end;


     inherited;
     if not actKeybEdit.Checked then Exit;
     Dx := 0;Dy := 0;Dz := 0;
     DTurn := 0; DPitch := 0;
     if shift =[] then
     begin
          begin
               if Key = VK_UP then Dz := -1/gz;
               if Key = VK_DOWN then Dz := 1/gz;
               if Key = VK_LEFT then Dx := -1/gx;
               if Key = VK_RIGHT then Dx := 1/gx;
          end
     end
     else
     if (ssCtrl in Shift) then
     begin
          if Key = VK_UP then DPitch := -1;
          if Key = VK_DOWN then DPitch := 1;
          if Key = VK_LEFT then DTurn := 1;
          if Key = VK_RIGHT then DTurn := -1;
     end
     else if (ssShift in Shift) then
     begin
          begin
               if Key = VK_UP then Dy := -1/gy;
               if Key = VK_DOWN then Dy := 1/gy;
               if Key = VK_LEFT then Dx := -1/gx;
               if Key = VK_RIGHT then Dx := 1/gx;
          end
     end;

     if PickedObj is TGLBaseSceneObject then
     begin
          PickedObj.Translate(Dx,Dy,Dz);
          PickedObj.TurnAngle := PickedObj.TurnAngle + DTurn;
          PickedObj.PitchAngle := PickedObj.PitchAngle + DPitch;
     end;
     NotifyModify;
end;

procedure TGLSceneEditorFormVis.FormMouseWheel(Sender: TObject;
  Shift: TShiftState; WheelDelta: Integer; MousePos: TPoint;
  var Handled: Boolean);
var
   fact : integer;
begin
     inherited;
     if GLSceneViewer.Focused then
     begin
          fact := 500;
          if GetAsyncKeyState(VK_SHIFT)<-10 then
             fact := 100;
             GLSCeneViewer.Camera.Position.AddScaledVector(WheelDelta/fact,GLSCeneViewer.Camera.Direction.AsAffineVector);
          NotifyModify;
     end;
end;

procedure TGLSceneEditorFormVis.TreeChange(Sender: TObject;
  Node: TTreeNode);
var
   TreeObject : TGLBaseSceneObject;
begin
  inherited;

  if Tree.Selected<>nil then
     if TObject(Tree.Selected.Data) is TGLBaseSceneObject then
        PickedObj := TGLBaseSceneObject(Tree.Selected.Data);

  // Update Actions
  if Tree.Selected<>nil then
  begin
       TreeObject := TGLBaseSceneObject(Tree.Selected.data);
       actUseThisCamera.Enabled   := TreeObject is TGLCamera;
       actKeybEdit.Enabled        := True;
       actTarget.Enabled          := TreeObject <> GLSceneViewer.Camera;
       actUndo.Enabled            := undoObj <>nil;
       actCopyProperties.Enabled  := True;
       actPasteProperties.Enabled := CopySrcObj<>nil;
  end
  else
  begin
       actUseThisCamera.Enabled   := False;
       actKeybEdit.Enabled        := False;
       actTarget.Enabled          := False;
       actUndo.Enabled            := False;
       actCopyProperties.Enabled  := False;
       actPasteProperties.Enabled := False;
  end;

  actCameraUpY.Enabled := GLSceneViewer.Camera<>nil;

end;

procedure TGLSceneEditorFormVis.Notification(AComponent: TComponent; Operation: TOperation);
begin
   inherited Notification(AComponent,Operation);

   if (FScene=AComponent) and (Operation=opRemove) then
   begin
      GLSceneViewer.Camera := nil;
      GLNavigator.MovingObject := nil;
      PickedObj := nil;
      FScene:=nil;
      SetScene(nil, nil);
      undoObj:= nil;
      Self.Close;
   end;

end;




procedure TGLSceneEditorFormVis.ACLoadSceneExecute(Sender: TObject);
begin
     PickedObj := nil; // Hide Axis
     GLSceneViewer.Camera := nil;
     inherited;
     SetScene(FScene,FCurrentDesigner);
end;

procedure TGLSceneEditorFormVis.FormDeactivate(Sender: TObject);
begin
  inherited;
  PickedObj := nil;
  AsyncTimer.Interval := 1000;
end;

procedure TGLSceneEditorFormVis.FormActivate(Sender: TObject);
begin
  inherited;
  AsyncTimer.Interval := 2;
end;


procedure TGLSceneEditorFormVis.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  AsyncTimer.Enabled := False;
end;

procedure TGLSceneEditorFormVis.ACDeleteObjectExecute(Sender: TObject);
begin
  if (Tree.Selected<>nil) and (TGLBaseSceneObject(Tree.Selected) = CameraObj) then
     CameraObj := nil;
  if (Tree.Selected<>nil) and (TGLBaseSceneObject(Tree.Selected) = PickedObj) then
     PickedObj := nil;
  inherited;

end;


procedure TGLSceneEditorFormVis.actCameraUpYExecute(Sender: TObject);
begin
  inherited;
  GLSceneViewer.Camera.Up.SetVector(0,1,0);
  GLNavigator.SetVirtualUp(GLSceneViewer.Camera.Up);
end;

procedure TGLSceneEditorFormVis.actCopyPropertiesExecute(Sender: TObject);
begin
  inherited;
  CopySrcObj := PickedObj;
end;

procedure TGLSceneEditorFormVis.actPastePropertiesExecute(Sender: TObject);
begin
  inherited;
  with CopySrcObj.Position do
       PickedObj.Position.SetPoint(x,y,z);
  with CopySrcObj.Scale do
       PickedObj.Scale.SetVector(x,y,z);
  with CopySrcObj.Direction do
       PickedObj.Direction.SetVector(x,y,z);
  with CopySrcObj.Up do
       PickedObj.Up.SetVector(x,y,z);

  // Material
  if (PickedObj is TGLSceneObject) and (CopySrcObj is TGLSceneObject) then
  begin
       TGLSceneObject(PickedObj).Material.Assign(TGLSceneObject(CopySrcObj).Material);
  end;

  // Hint (Todo: replace HINT with FILENAME
  if (PickedObj is TGLFreeForm) and (CopySrcObj is TGLFreeForm) then
  begin
       TGLFreeForm(PickedObj).Hint := TGLFreeForm(CopySrcObj).Hint;
  end;


  PickedObj.Tag := CopySrcObj.Tag;
end;

procedure TGLSceneEditorFormVis.Specifynew1Click(Sender: TObject);
begin
  inherited;
  FFPaths := '';
  actLoadFreeForms.Execute;
end;

procedure TGLSceneEditorFormVis.TreeEnter(Sender: TObject);
begin
  inherited;
  AsyncTimer.Enabled := true;
end;

procedure TGLSceneEditorFormVis.edtScaleXKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  if Key=#13 then
  begin
       EdtScaleY.Text := edtSCaleX.Text;
       EdtScaleZ.Text := edtSCaleX.Text;
       XSpeedbutton1.Click;
       Key := #0;
  end;

end;

procedure TGLSceneEditorFormVis.ChkQ3BspLoadMaterialsClick(Sender: TObject);
begin
  inherited;
  GLFileQ3BSP.vGLFileQ3BSPLoadMaterials := ChkQ3BspLoadMaterials.Checked;
end;


procedure TGLSceneEditorFormVis.actAllocateMaterialsUpdate(
  Sender: TObject);
begin
  inherited;
  actAllocateMaterials.Checked := GLVectorFileObjects.vGLVectorFileObjectsAllocateMaterials;
end;

procedure TGLSceneEditorFormVis.actAllocateMaterialsExecute(
  Sender: TObject);
begin
  inherited;
  GLFileQ3BSP.vGLFileQ3BSPLoadMaterials := actAllocateMaterials.Checked;
  GLVectorFileObjects.vGLVectorFileObjectsAllocateMaterials  := actAllocateMaterials.Checked;
  GLFileOCT.vGLFileOCTAllocateMaterials := actAllocateMaterials.Checked;
end;

procedure TGLSceneEditorFormVis.actCheckMaterialspathExecute(
  Sender: TObject);
var
   t: integer;
   F : TGLFreeForm;
   st: string;
   stMissing : string;
   MatStartPath : string;
begin
  inherited;
  if Tree.Selected=nil then
  begin
       ShowMessage('Select a GLFreeForm!');
       Exit;
  end;

  if TObject(Tree.Selected.Data) is TGLFreeForm then
  begin
       F := TGLFreeForm(Tree.Selected.Data);
       if F.MaterialLibrary<>nil then
       begin
            for t := 0 to  F.MaterialLibrary.Materials.Count-1 do
            begin
                 st := F.MaterialLibrary.Materials[t].Name;
                 st := StringReplace(st,'/','\',[rfReplaceAll]);
                 MatStartPath := GetCurrentDir+'\';
                 st := MatStartPath+st;
                 if (not FileExists(st+'.bmp')) and (not FileExists(st+'.jpg')) and (not FileExists(st+'.tga')) then
                    stMissing := stMissing + #13+st;
            end;
       end;
       if stMissing<>'' then
       ShowMessage('Missing files:'+#13+#13+stMissing);
  end
  else
  begin
       ShowMessage('Select a GLFreeForm');
  end;


end;


procedure TGLSceneEditorFormVis.Meshes_FillTV(O:TGLBaseSceneObject);
var
   m,f : integer;
   ff : TGLFreeForm;
   NM,NF : TTreeNode;
   fac : TFaceGroup;
   ml : TGLMaterialLibrary;
begin
     tvMeshes.Items.BeginUpdate;
     tvMeshes.Items.Clear;
     SelectedFreeForm := nil;
     try
        if O is TGLFreeForm then
        begin
             ff := TGLFreeForm(O);
             SelectedFreeForm := ff;
             NM := nil;
             for m := 0 to ff.MeshObjects.Count-1 do
             begin
                  NM := tvMeshes.Items.AddObject(NM,ff.MeshObjects[m].Name,ff.MeshObjects[m]);
                  for f := 0 to ff.MeshObjects[m].FaceGroups.Count-1 do
                  begin
                       fac := ff.MeshObjects[m].FaceGroups[f];
                       NF := tvMeshes.Items.AddChild(NM,fac.MaterialName);
                       NF.Data := fac;
                  end;

             end;

             lvMats.Clear;
             if ff.MaterialLibrary<>nil then
             begin
                  ml := ff.MaterialLibrary;
                  for m := 0 to ml.Materials.Count-1 do
                  begin
                       lvMats.Items.AddObject(ml.Materials[m].Name,ml.Materials[m]);
                  end;

             end;

        end;

     finally
            tvMeshes.FullExpand;
            tvMeshes.Items.EndUpdate;
            tkMouseDown := GettickCount;
     end;


end;


procedure TGLSceneEditorFormVis.lvMatsDrawItem(Control: TWinControl;
  Index: Integer; Rct: TRect; State: TOwnerDrawState);
var
   M : TGLLibMaterial;
begin
  inherited;
  try
     M := TGLLibMaterial(lvMats.Items.Objects[Index]);
     if M<>nil then
     begin
          lvMats.Canvas.FillRect(Rct);
          lvMats.Canvas.StretchDraw(Rct,TGLPictureImage(M.Material.Texture.Image).Picture.Graphic);
          lvMats.Canvas.TextOut(Rct.Left+10,Rct.Top+2,M.Name);
     end;

  except
  end;
end;

procedure TGLSceneEditorFormVis.tvMesh_BlinkFaceGroupByNode(Node: TTreeNode);
var
   t: integer;
   st: string;
begin
  inherited;
  if Node.Level=1 then
  begin
       SelectedFaceGroup := TFaceGroup(Node.Data);
       st := SelectedFaceGroupMaterialName;
       for t := 1 to 1 do
       begin
            //  Blink effect (off)
            SelectedFaceGroup.MaterialName := '';
            SelectedFreeForm.StructureChanged;
            GLSceneViewer.Repaint;
            Sleep(1);
            //  Blink effect (on)
            SelectedFaceGroup.MaterialName := st;
            SelectedFreeForm.StructureChanged;
            GLSceneViewer.Repaint;
            Sleep(1);
       end;
  end
  else
      SelectedFaceGroup := nil;
end;



procedure TGLSceneEditorFormVis.SetSelectedFaceGroup(const Value: TFaceGroup);
begin
     if FSelectedFaceGroup<>nil then
     begin
          try
             FSelectedFaceGroup.MaterialName := SelectedFaceGroupMaterialName;
          finally

          end;
     end;
     FSelectedFaceGroup := Value;

     if FSelectedFaceGroup<>nil then
     begin
          SelectedFaceGroupMaterialName := FSelectedFaceGroup.MaterialName;
     end;

end;




procedure TGLSceneEditorFormVis.lvMatsDblClick(Sender: TObject);
begin
  inherited;
  if (SelectedFaceGroup<>nil) and (lvMats.ItemIndex>-1) then
  begin
       SelectedFaceGroupMaterialName := TGLLibMaterial(lvMats.Items.Objects[lvMats.ItemIndex]).Name;//lvMats.Items[lvMats.ItemIndex];
       FSelectedFaceGroup.MaterialName := SelectedFaceGroupMaterialName;
       tvMeshes.Selected.Text := FSelectedFaceGroup.MaterialName;
       SelectedFreeForm.StructureChanged;
       GLSceneViewer.Invalidate;
  end;

end;

procedure TGLSceneEditorFormVis.ActSaveGLMSExecute(Sender: TObject);
begin
  // UNUSED (4 NOW) ACTION
  inherited;
  SelectedFreeForm.Hint := ChangeFileExt(SelectedFreeForm.Hint,'.GLSM');
  SelectedFreeForm.SaveToFile(SelectedFreeForm.Hint);
end;

procedure TGLSceneEditorFormVis.ActSaveGLMSUpdate(Sender: TObject);
begin
  inherited;
  TAction(Sender).Enabled := SelectedFreeForm<>nil;
end;

procedure TGLSceneEditorFormVis.actSaveTriMatsExecute(Sender: TObject);
begin
     if MessageDlg('Save (eventually overwrite) the .TRM file?',mtConfirmation,mbOKCancel,0)=mrOk then
        SaveTRMFile(SelectedFreeForm,'');
end;

procedure TGLSceneEditorFormVis.actLoadTriMatsExecute(Sender: TObject);
begin
     BEGIN_UPDATE;
     try
       AskFFPaths;

       if FFPaths<>'' then
       begin
            if MessageDlg('Load the .TRM file?',mtConfirmation,mbOKCancel,0)=mrOk then
            begin
                 LoadTRMFile(SelectedFreeForm,FFPaths,'');
                 Meshes_FillTV(PickedObj);
                 GLSceneViewer.Repaint;
            end;
       end;
    finally
           End_Update;
    end;
end;

procedure TGLSceneEditorFormVis.actSaveTriMatsUpdate(Sender: TObject);
begin
  inherited;
  TAction(Sender).Enabled := SelectedFreeForm<>nil;
end;

procedure TGLSceneEditorFormVis.actLoadTriMatsUpdate(Sender: TObject);
begin
  inherited;
  TAction(Sender).Enabled := SelectedFreeForm<>nil;
end;

procedure TGLSceneEditorFormVis.XSpeedbutton11Click(Sender: TObject);
begin
  inherited;
  if PickedObj<>nil then
  begin
       PickedObj.Up.SetVector(0,0,-1);
       PickedObj.Direction.SetVector(0,1,0);
  end;


end;

procedure TGLSceneEditorFormVis.tvMeshesClick(Sender: TObject);
begin
  inherited;
  if tvMeshes.Selected<>nil then
     tvMesh_BlinkFaceGroupByNode(tvMeshes.Selected);
end;

procedure TGLSceneEditorFormVis.ActSaveOCTFileExecute(Sender: TObject);
var
   oct : TOCTFile;
   fs : TFileStream;
   vertices, texCoords : TAffineVectorList;
   LV : TAffineVector;
   tmps : single;
   lightlist: Tlist;
   u: integer;
   lig : TGLDummyCubeLight;
   scx,scy,scz : single;

              procedure AddLightsIn(O: TGLBaseSceneObject);
              var
                 t: integer;
              begin
                   for t := 0 to O.Count-1 do
                   begin
                        if O.Children[t] is TGLDummyCubeLight then
                           lightlist.Add(O.Children[t]);
                        AddLightsIn(O.Children[t]);
                   end;

              end;

              procedure GetAbsoluteScale(O: TGLBaseSceneObject; var sx,sy,sz : Single);
              begin
                   if O.Parent<>FScene.Objects then
                   begin
                        GetAbsoluteScale(O.Parent, sx,sy,sz);
                        sx := sx * O.Scale.X;
                        sy := sy * O.Scale.y;
                        sz := sz * O.Scale.z;
                   end
                   else
                   begin
                        sx := O.Scale.X;
                        sy := O.Scale.y;
                        sz := O.Scale.z;
                   end;
              end;



begin
     if MessageDlg('Be sure you have the Materials assigned to the Facegroups (You have allocated the materials) !'+#13+'Continue ?',mtConfirmation,mbOkCancel,0)=mrCancel then
        Exit;

     lightlist := TList.create;


     oct:=TOCTFile.Create;
     texCoords:=TAffineVectorList.Create;
     vertices:=SelectedFreeForm.MeshObjects.ExtractTriangles(texCoords);
     //vertices.Scale(4);
     oct.AddTriangles(vertices, texCoords, SelectedFreeForm.Name);


     AddLightsIn(FScene.Objects);
     for u := 0 to  lightlist.count-1 do
     begin
          lig := TGLDummyCubeLight(lightlist[u]);


          GetAbsoluteScale(SelectedFreeForm,scx,scy,scz);

          LV[0] := (lig.Absoluteposition[0]-SelectedFreeForm.Absoluteposition[0]) / scx;
          LV[1] := (lig.Absoluteposition[1]-SelectedFreeForm.Absoluteposition[1]) / scy;
          LV[2] := (lig.Absoluteposition[2]-SelectedFreeForm.Absoluteposition[2]) / scz;

          LV[2] := -LV[2];


          oct.AddLight(LV,
                       lig.LightColor.Color,
                       lig.LightIntensity);
     end;



     vertices.Free;
     texCoords.Free;

     fs:=TFileStream.Create(ChangeFileExt(SelectedFreeForm.Hint,'.OCT'), fmCreate);
     oct.SaveToStream(fs);

     fs.Free;
     oct.Free;
     lightlist.free;
end;

procedure TGLSceneEditorFormVis.actRunFSRadExecute(Sender: TObject);
begin
  inherited;
  Shellexecute(0,'open','C:\FSRAD\FSRAD.EXE','','',sw_ShowNormal);
end;

procedure TGLSceneEditorFormVis.ActLoadOCTFileExecute(Sender: TObject);
begin
  inherited;
  Begin_Update;
  try
     if SelectedFreeForm.LightmapLibrary<>nil then
        SelectedFreeForm.LightmapLibrary.Materials.Clear;

     SelectedFreeForm.LoadFromFile(ChangeFileExt(SelectedFreeForm.Hint,'.OCT'));
     Meshes_FillTV(PickedObj);
  finally
         End_Update;
  end;
end;

procedure TGLSceneEditorFormVis.ActSetOCTFilenameExecute(Sender: TObject);
begin
  inherited;
  SelectedFreeForm.SaveToFile(ChangeFileExt(SelectedFreeForm.Hint,'_final.GLSM'));
end;

procedure TGLSceneEditorFormVis.ActSaveOCTFileUpdate(Sender: TObject);
begin
  inherited;
  TAction(Sender).Enabled := SelectedFreeForm<>nil;
end;

procedure TGLSceneEditorFormVis.ActLoadOCTFileUpdate(Sender: TObject);
begin
  inherited;
  TAction(Sender).Enabled := SelectedFreeForm<>nil;
end;

procedure TGLSceneEditorFormVis.actRunFSRadUpdate(Sender: TObject);
begin
  inherited;
  TAction(Sender).Enabled := SelectedFreeForm<>nil;
end;

procedure TGLSceneEditorFormVis.ActSetOCTFilenameUpdate(Sender: TObject);
begin
  inherited;
  TAction(Sender).Enabled := SelectedFreeForm<>nil;
end;

procedure TGLSceneEditorFormVis.Begin_Update;
begin
     AsyncTimer.Enabled := false;
     FScene.BeginUpdate;
end;

procedure TGLSceneEditorFormVis.End_Update;
begin
     AsyncTimer.Enabled := true;
     FScene.EndUpdate;
end;


procedure TGLSceneEditorFormVis.XSplitter3Moved(Sender: TObject);
begin
  inherited;
  lvMats.ItemHeight := lvMats.Height div 6; 
end;


procedure TGLSceneEditorFormVis.edtOctBrightChange(Sender: TObject);
begin
  inherited;
  GLFileOct.vGLFileOCTLightmapBrightness      := StrToFloat(edtOctBright.Text);
  GLFileOct.vGLFileOCTLightmapGammaCorrection := StrToFloat(edtOctGamma.Text);

end;


procedure TGLSceneEditorFormVis.ActionListGlaredUpdate(
  Action: TBasicAction; var Handled: Boolean);
begin
  inherited;

  // THEY ARE DISABLED IN ANCESTOR UNDER CERTAIN CIRCUMSTANCES...
  ACSaveScene.Enabled := true;
  ACLoadScene.Enabled := true;
end;

initialization

finalization
   ReleaseGLSceneEditorFormVis;

end.
