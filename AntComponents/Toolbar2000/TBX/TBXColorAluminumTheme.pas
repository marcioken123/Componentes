unit TBXColorAluminumTheme;

// TBX Package
// Copyright 2001-2004 Alex A. Denisov. All Rights Reserved
// See TBX.chm for license and installation instructions
//
// Theme for TBX 2.1.
// This theme add color to Aluminum theme.


interface

{$I TB2Ver.inc}
{$I TBX.inc}

uses
  Graphics, TBXThemes, TBXAluminumTheme;

type
  TTBXColorAluminumTheme = class(TTBXAluminumTheme)
  protected
    procedure SetupBaseColors; override;
  end;

implementation

{ TTBXColorAluminumTheme }

procedure TTBXColorAluminumTheme.SetupBaseColors;
begin
  BaseColor := clBtnFace;
  BtnText := clBtnText;
  BtnShadow := clBtnShadow;
  BtnFace := clBtnFace;
  BtnHighlight := clBtnHighlight;
end;

initialization
  RegisterTBXTheme('Color Aluminum', TTBXColorAluminumTheme);
end.
