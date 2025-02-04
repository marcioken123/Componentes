// 	VARIOUS MDL utility functions
//	by Mrqzzz

unit USMDStuff;

     // LoadQC Examples:
     //
     // 1) LoadQC('C:\KazeXtreme2\KazeXtreme2.qc',Actor1,True);  <-- Loads the first body found in .QC and animation sequences.
     //
     // 2) LoadQC('C:\KazeXtreme2\KazeXtreme2.qc',Actor1,True,'template_urban2');        <-- Loads in Actor1 the body "template_urban2" found in .QC and animation sequences.
     //    LoadQC('C:\KazeXtreme2\KazeXtreme2.qc',Actor2,True, 'template_urban2_pack');  <-- Loads in Actor2 the body "template_urban2_pack" found in .QC and animation sequences.
     //                                                                                      Use "Actor2.Synchronize(Actor1)" when you switch between Actor1's animations


interface

Uses
    Classes,SysUtils,GLVectorFileObjects,Geometry,VectorTypes;

   // LOADING STUFF
   procedure LoadQC(QCFilename : string; Ac : TGLActor; LoadReference : Boolean; LoadAnimations : Boolean; BodyName : string ='');

   // BONES STUFF
   procedure GetIdealBoneRotationLookingAt(Ac: TGLActor; BoneIndex : integer; YCenterOffset: single; AbsolutePosition :TVector4f; var aa,bb,cc : single);
   procedure RotateBone(Ac: TGLActor;BoneIndex : integer; aa,bb,cc : single; SlowerCoeff : single; Maxaa,Minaa,Maxbb,Minbb,Maxcc,Mincc : single);
   function GetBoneIndexByName(Ac: TGLActor;BoneName: string): integer;
implementation



Function Get_String_From1_From2_To1(st: string; From1,From2,To1 : string): string;
var
   P1,p2,p3 : integer;
   ltot : integer;
begin
     ltot := Length(st);
     Result :='';
     P1 := pos(From1,st);
     if P1>0 then
     begin
          P1 := P1 + length(From1);
          P2 := pos(From2,Copy(st,P1,ltot));
          if P2>0 then
          begin
               P2 := P2 + Length(From2) + P1 -1;
               P3 := pos(To1,Copy(st,P2,ltot));
               if P3>0 then
               begin
                    Result := Copy(st,P2, p3-1);
               end;

          end;

     end;

end;



procedure LoadQC(QCFilename : string; Ac : TGLActor; LoadReference : Boolean; LoadAnimations : Boolean; BodyName : string ='');
var
   cwd : string;
   Pth: string;
   Stl : TstringList;
   st: string;
   stAnimName : string;
   t : integer;
begin
     Pth := ExtractFilePath(QCFileName);
     cwd := GetCurrentDir;
     Stl := TstringList.create;
     Try
        Stl.LoadFromFile(QCFilename);
        SetCurrentDir(Pth);

        // Body---------------------------------
        if LoadReference then
        begin
             if BodyName='' then
             begin
                  st := Trim(Get_String_From1_From2_To1(Stl.Text,'$bodygroup ','studio "','"'));
                  st := StringReplace(st,'/','\',[rfReplaceAll]);
                  st := ExtractFileName(st);
             end
             else
                 st := BodyName;
             Ac.LoadFromFile(st+'.smd');
        end;

        if LoadAnimations then
        begin
             // Sequences-----------------------------
             for t := 0 to stl.Count-1 do
             begin
                  if Pos('$sequence ',Stl[t])=1 then
                  begin
                       stAnimName := trim(Get_String_From1_From2_To1(Stl[t],'$','sequence ',' "'));
                       // Ususlly there are 2 sequences on a line
                       st := trim(Get_String_From1_From2_To1(Stl[t],'$sequence ',' "','"'));
                       if st<>'' then
                          Ac.AddDataFromFile(st+'.smd');
                       st := trim(Get_String_From1_From2_To1(Stl[t],'$sequence ','" "','"'));
                       if st<>'' then
                          Ac.AddDataFromFile(st+'.smd');
                       Ac.Animations[Ac.Animations.Count-1].Name := stAnimName;
                       Ac.Animations[Ac.Animations.Count-1].MakeSkeletalTranslationStatic;
                  end;
             end;
        end;

     finally
            Stl.Free;
            SetCurrentDir(cwd);
     end;
end;




procedure GetIdealBoneRotationLookingAt(Ac: TGLActor; BoneIndex : integer; YCenterOffset: single; AbsolutePosition :TVector4f; var aa,bb,cc : single);
var
  AcAp : TVector4f;
  V4: Tvector4f;
  V3 : Tvector3f;
  VC : Tvector3f;
  cs : single;
  hh : single;
  vl : single;
begin
     AcAp := Ac.AbsolutePosition;

     // ---------------HORIZONLTAL ANGLE-----------------------
     // -------------------------------------------------------
     V4[0] := AbsolutePosition[0];
     V4[1] := AcAp[1];
     V4[2] := AbsolutePosition[2];
     VectorSubtract(Ac.Absoluteposition,V4,V3);
     // Get Cosine
     cs := VectorAngleCosine(Ac.Up.AsAffineVector,V3);
     aa := arccos(cs);
     // Get Cross Product
     VectorCrossProduct(V3,Ac.Up.AsAffineVector,VC);
     if VC[1]>0 then
        aa := - aa;



     // ---------------VERTICAL ANGLES-----------------------
     // -------------------------------------------------------
     V4[0] := AbsolutePosition[0];
     V4[1] := AbsolutePosition[1] + YCenterOffset;
     V4[2] := AbsolutePosition[2];
     VectorSubtract(V4,Ac.Absoluteposition,V3);
     vl := VectorLength(V3);
     V3[0] := (Ac.Up.x * vl);
     V3[1] := V3[1];
     V3[2] := (Ac.Up.z * vl);


     // Get Cosine
     cs := VectorAngleCosine(Ac.Up.AsAffineVector,V3);
     hh := arccos(cs);
     sincos(aa,bb,cc);
     cc := hh * cc;
     bb := -hh * bb;

     // Correct angles
     if v3[1]>0 then
        cc := - cc;
     if v3[1]>0 then
        bb := - bb;

end;

procedure RotateBone(Ac: TGLActor;BoneIndex : integer; aa,bb,cc : single; SlowerCoeff : single; Maxaa,Minaa,Maxbb,Minbb,Maxcc,Mincc : single);
var
  BoneRotation : TVector3f;
  BoneFrame: TSkeletonFrame;
  t: integer;
begin
  for t := Ac.Animations.FindName(Ac.CurrentAnimation).StartFrame to  Ac.Animations.FindName(Ac.CurrentAnimation).EndFrame do
  begin
       BoneFrame := Ac.Skeleton.Frames[t];
       BoneRotation := BoneFrame.Rotation.Items[BoneIndex];

       if (aa<Minaa) then aa := Minaa
       else if (aa>Maxaa) then aa := Maxaa;
       BoneRotation[0] := BoneRotation[0] + ((aa-BoneRotation[0]) * SlowerCoeff);

       if (bb<Minbb) then bb := Minbb
       else if (bb>Maxbb) then bb := Maxbb;
       BoneRotation[1] := BoneRotation[1] + ((bb-BoneRotation[1]) * SlowerCoeff);

       if (cc<Mincc) then cc := Mincc
       else if (cc>Maxcc) then cc := Maxcc;
       BoneRotation[2] := BoneRotation[2] + ((cc-BoneRotation[2]) * SlowerCoeff);

       BoneFrame.Rotation.Items[BoneIndex] := BoneRotation;
  end;
end;


function GetBoneIndexByName(Ac: TGLActor;BoneName: string): integer;
var
   t: integer;
begin
     Result :=-1;
     // WHY CAN'T WE GET THE BONES COUNT ?!?!?
     try
        for t := 0 to 99 {Ac.Skeleton.RootBones.Count-1} do
        begin
             if Ac.Skeleton.BoneByID(t).Name = BoneName then
             begin
                  Result := t;
                  Break;
             end;

        end;
     except
     end;
end;


end.
