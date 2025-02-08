unit LMDGridImages;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ImgList, Menus;

type
  TLMDGridImagesForm = class(TForm)
    Images: TImageList;
    IndicatorImages: TImageList;
    ArrowImages: TImageList;
    ChooserImages: TImageList;
    OtherImages: TImageList;
    SelectColumnsMenu: TPopupMenu;
    N11: TMenuItem;
    N21: TMenuItem;
    N31: TMenuItem;
    N41: TMenuItem;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  LMDGridImagesForm: TLMDGridImagesForm;

implementation

{$R *.dfm}

initialization
  LMDGridImagesForm := TLMDGridImagesForm.Create(nil);
finalization
  FreeAndNil(LMDGridImagesForm);
end.
