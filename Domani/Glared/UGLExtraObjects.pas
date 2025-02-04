unit UGLExtraObjects;

interface

uses
   Windows,Forms,SysUtils,  GLWin32Viewer, Buttons, StdCtrls, ExtCtrls ,
   Geometry,GLMisc,GLObjects,VectorTypes,GLNavigator,
   GLScene, Classes,Dialogs, ImgList, Menus,
   Graphics,GLFileQ3BSP,GLTexture,Jpeg,TGA,GLVectorFileObjects,FileOCT,VectorLists;


   // MRQZZZ---
   // A DUMMYCUBE TO STORE THE POSITION/COLOR/INTENSITY OF A LIGHT FOR USE WHEN EXPORTING TO .OCT FILE FORMAT
   type TGLDummyCubeLight = class(TGLDummyCube)
  private
    FLightIntensity: integer;
    FLightColor: TGLColor;
    procedure SetLightColor(const Value: TGLColor);
    procedure SetLightIntensity(const Value: integer);
      public
         constructor Create(AOwner : TComponent); override;
      published
         property LightColor : TGLColor read FLightColor write SetLightColor;
         property LightIntensity : integer read FLightIntensity write SetLightIntensity;
   end;


   // MRQZZZ---
   // A DUMMYCUBE TO DO BASIC BOX CULLING
   type TGLDummyCubeCull = class(TGLDummyCube)
  private
    FCulledObject: TGLBaseSceneObject;
    FLinkedGLDummyCubeCull: TGLDummyCubeCull;
    procedure SetCulledObject(const Value: TGLBaseSceneObject);
    procedure SetLinkedGLDummyCubeCull(const Value: TGLDummyCubeCull);
      public
            constructor Create(AOwner : TComponent); override;
            function IsPointInside(P:TVector4F; CheckInsideLinkedCubes:boolean):boolean;
      published
               property CulledObject : TGLBaseSceneObject read FCulledObject write SetCulledObject;
               property LinkedGLDummyCubeCull : TGLDummyCubeCull read FLinkedGLDummyCubeCull write SetLinkedGLDummyCubeCull;
   end;


implementation

{ TGLDummyCubeLight }

constructor TGLDummyCubeLight.Create(AOwner: TComponent);
begin
     inherited create(AOwner);
     FLightColor:=TGLColor.Create(Self);
     FLightColor.Initialize(clrWhite);
     FLightIntensity := 1000;
end;

procedure TGLDummyCubeLight.SetLightColor(const Value: TGLColor);
begin
  FLightColor.Assign(Value);
  Self.EdgeColor.Red := Value.Red;
  Self.EdgeColor.Green := Value.Green;
  Self.EdgeColor.Blue := Value.Blue;
  //Self.EdgeColor.Assign(Value);
  StructureChanged;
end;

procedure TGLDummyCubeLight.SetLightIntensity(const Value: integer);
begin
  FLightIntensity := Value;
end;

{ TGLDummyCubeCull }

constructor TGLDummyCubeCull.Create(AOwner: TComponent);
begin
  inherited;

end;

function TGLDummyCubeCull.IsPointInside(P: TVector4F; CheckInsideLinkedCubes: boolean): boolean;
begin

     Result := false;
     if self.PointInObject(P) then
     begin
          Result := true;
          exit;
     end
     else
     begin
          if CheckInsideLinkedCubes and (FLinkedGLDummyCubeCull<>nil) then
          begin
               Result := FLinkedGLDummyCubeCull.IsPointInside(P,CheckInsideLinkedCubes); 
          end;
     end;
end;

procedure TGLDummyCubeCull.SetCulledObject(
  const Value: TGLBaseSceneObject);
begin
  FCulledObject := Value;
end;

procedure TGLDummyCubeCull.SetLinkedGLDummyCubeCull(
  const Value: TGLDummyCubeCull);
begin
  FLinkedGLDummyCubeCull := Value;
end;

initialization
              RegisterClass(TGLDummyCubeLight);
              RegisterClass(TGLDummyCubeCull);

end.
