object RMaterialPreview: TRMaterialPreview
  Left = 0
  Top = 0
  Width = 202
  Height = 203
  AutoSize = True
  TabOrder = 0
  object SceneViewer: TGLSceneViewer
    Left = 0
    Top = 26
    Width = 201
    Height = 177
    Camera = Camera
  end
  object CBObject: TComboBox
    Left = 0
    Top = 0
    Width = 60
    Height = 21
    Style = csDropDownList
    ItemHeight = 13
    TabOrder = 1
    OnChange = CBObjectChange
    Items.Strings = (
      'Cube'
      'Sphere')
  end
  object CBBackground: TComboBox
    Left = 60
    Top = 0
    Width = 142
    Height = 21
    Style = csDropDownList
    ItemHeight = 13
    TabOrder = 2
    OnChange = CBBackgroundChange
    Items.Strings = (
      'on a pattern background'
      'on a white background'
      'on a black background'
      'on a blue background'
      'on a red background'
      'on a green background')
  end
  object GLScene1: TGLScene
    Left = 160
    Top = 32
    object Cube: TGLCube
      Direction.Coordinates = {FCFAF0B1D8B35D3FFEFFFF3E00000000}
      Up.Coordinates = {D7B35DBFFFFF7F3ED7B3DDBE00000000}
      Material.Texture.MappingTCoordinates.Coordinates = {000000000000803F0000000000000000}
    end
    object Sphere: TGLSphere
      Material.Texture.MappingTCoordinates.Coordinates = {000000000000803F0000000000000000}
      Radius = 0.800000011920929
    end
    object LightSource: TGLLightSource
      ConstAttenuation = 1
      Position.Coordinates = {0000000000004040000020410000803F}
      Specular.Color = {0000803F0000803F0000803F0000803F}
      SpotCutOff = 180
    end
    object PlanePattern: TGLPlane
      Position.Coordinates = {0000000000000000000040C00000803F}
      Material.Texture.Image.Picture.Data = {
        07544269746D617076080000424D760800000000000076000000280000004000
        0000400000000100040000000000000800000000000000000000100000000000
        000000000000000080000080000000808000800000008000800080800000C0C0
        C000808080000000FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFF
        FF00CCCCCCCCCCCCCCCCBBBBBBBBBBBBBBBBAAAAAAAAAAAAAAAA555555555555
        5555CCCCCCCCCCCCCCCCBBBBBBBBBBBBBBBBAAAAAAAAAAAAAAAA555555555555
        5555CCCCCCCCCCCCCCCCBBBBBBBBBBBBBBBBAAAAAAAAAAAAAAAA555555555555
        5555CCCCCCCCCCCCCCCCBBBBBBBBBBBBBBBBAAAAAAAAAAAAAAAA555555555555
        5555CCCCCCCCCCCCCCCCBBBBBBBBBBBBBBBBAAAAAAAAAAAAAAAA555555555555
        5555CCCCCCCCCCCCCCCCBBBBBBBBBBBBBBBBAAAAAAAAAAAAAAAA555555555555
        5555CCCCCCCCCCCCCCCCBBBBBBBBBBBBBBBBAAAAAAAAAAAAAAAA555555555555
        5555CCCCCCCCCCCCCCCCBBBBBBBBBBBBBBBBAAAAAAAAAAAAAAAA555555555555
        5555CCCCCCCCCCCCCCCCBBBBBBBBBBBBBBBBAAAAAAAAAAAAAAAA555555555555
        5555CCCCCCCCCCCCCCCCBBBBBBBBBBBBBBBBAAAAAAAAAAAAAAAA555555555555
        5555CCCCCCCCCCCCCCCCBBBBBBBBBBBBBBBBAAAAAAAAAAAAAAAA555555555555
        5555CCCCCCCCCCCCCCCCBBBBBBBBBBBBBBBBAAAAAAAAAAAAAAAA555555555555
        5555CCCCCCCCCCCCCCCCBBBBBBBBBBBBBBBBAAAAAAAAAAAAAAAA555555555555
        5555CCCCCCCCCCCCCCCCBBBBBBBBBBBBBBBBAAAAAAAAAAAAAAAA555555555555
        5555CCCCCCCCCCCCCCCCBBBBBBBBBBBBBBBBAAAAAAAAAAAAAAAA555555555555
        5555CCCCCCCCCCCCCCCCBBBBBBBBBBBBBBBBAAAAAAAAAAAAAAAA555555555555
        5555EEEEEEEEEEEEEEEE33333333333333332222222222222222DDDDDDDDDDDD
        DDDDEEEEEEEEEEEEEEEE33333333333333332222222222222222DDDDDDDDDDDD
        DDDDEEEEEEEEEEEEEEEE33333333333333332222222222222222DDDDDDDDDDDD
        DDDDEEEEEEEEEEEEEEEE33333333333333332222222222222222DDDDDDDDDDDD
        DDDDEEEEEEEEEEEEEEEE33333333333333332222222222222222DDDDDDDDDDDD
        DDDDEEEEEEEEEEEEEEEE33333333333333332222222222222222DDDDDDDDDDDD
        DDDDEEEEEEEEEEEEEEEE33333333333333332222222222222222DDDDDDDDDDDD
        DDDDEEEEEEEEEEEEEEEE33333333333333332222222222222222DDDDDDDDDDDD
        DDDDEEEEEEEEEEEEEEEE33333333333333332222222222222222DDDDDDDDDDDD
        DDDDEEEEEEEEEEEEEEEE33333333333333332222222222222222DDDDDDDDDDDD
        DDDDEEEEEEEEEEEEEEEE33333333333333332222222222222222DDDDDDDDDDDD
        DDDDEEEEEEEEEEEEEEEE33333333333333332222222222222222DDDDDDDDDDDD
        DDDDEEEEEEEEEEEEEEEE33333333333333332222222222222222DDDDDDDDDDDD
        DDDDEEEEEEEEEEEEEEEE33333333333333332222222222222222DDDDDDDDDDDD
        DDDDEEEEEEEEEEEEEEEE33333333333333332222222222222222DDDDDDDDDDDD
        DDDDEEEEEEEEEEEEEEEE33333333333333332222222222222222DDDDDDDDDDDD
        DDDD4444444444444444CCCCCCCCCCCCCCCC9999999999999999111111111111
        11114444444444444444CCCCCCCCCCCCCCCC9999999999999999111111111111
        11114444444444444444CCCCCCCCCCCCCCCC9999999999999999111111111111
        11114444444444444444CCCCCCCCCCCCCCCC9999999999999999111111111111
        11114444444444444444CCCCCCCCCCCCCCCC9999999999999999111111111111
        11114444444444444444CCCCCCCCCCCCCCCC9999999999999999111111111111
        11114444444444444444CCCCCCCCCCCCCCCC9999999999999999111111111111
        11114444444444444444CCCCCCCCCCCCCCCC9999999999999999111111111111
        11114444444444444444CCCCCCCCCCCCCCCC9999999999999999111111111111
        11114444444444444444CCCCCCCCCCCCCCCC9999999999999999111111111111
        11114444444444444444CCCCCCCCCCCCCCCC9999999999999999111111111111
        11114444444444444444CCCCCCCCCCCCCCCC9999999999999999111111111111
        11114444444444444444CCCCCCCCCCCCCCCC9999999999999999111111111111
        11114444444444444444CCCCCCCCCCCCCCCC9999999999999999111111111111
        11114444444444444444CCCCCCCCCCCCCCCC9999999999999999111111111111
        11114444444444444444CCCCCCCCCCCCCCCC9999999999999999111111111111
        1111000000000000000088888888888888887777777777777777FFFFFFFFFFFF
        FFFF000000000000000088888888888888887777777777777777FFFFFFFFFFFF
        FFFF000000000000000088888888888888887777777777777777FFFFFFFFFFFF
        FFFF000000000000000088888888888888887777777777777777FFFFFFFFFFFF
        FFFF000000000000000088888888888888887777777777777777FFFFFFFFFFFF
        FFFF000000000000000088888888888888887777777777777777FFFFFFFFFFFF
        FFFF000000000000000088888888888888887777777777777777FFFFFFFFFFFF
        FFFF000000000000000088888888888888887777777777777777FFFFFFFFFFFF
        FFFF000000000000000088888888888888887777777777777777FFFFFFFFFFFF
        FFFF000000000000000088888888888888887777777777777777FFFFFFFFFFFF
        FFFF000000000000000088888888888888887777777777777777FFFFFFFFFFFF
        FFFF000000000000000088888888888888887777777777777777FFFFFFFFFFFF
        FFFF000000000000000088888888888888887777777777777777FFFFFFFFFFFF
        FFFF000000000000000088888888888888887777777777777777FFFFFFFFFFFF
        FFFF000000000000000088888888888888887777777777777777FFFFFFFFFFFF
        FFFF000000000000000088888888888888887777777777777777FFFFFFFFFFFF
        FFFF}
      Material.Texture.MappingTCoordinates.Coordinates = {000000000000803F0000000000000000}
      Height = 3
      Width = 3
    end
    object Camera: TGLCamera
      DepthOfView = 100
      FocalLength = 140
      Position.Coordinates = {0000000000000000000020410000803F}
    end
  end
end
