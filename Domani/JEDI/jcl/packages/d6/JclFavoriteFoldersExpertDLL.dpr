Library JclFavoriteFoldersExpertDLL;
{
-----------------------------------------------------------------------------
     DO NOT EDIT THIS FILE, IT IS GENERATED BY THE PACKAGE GENERATOR
            ALWAYS EDIT THE RELATED XML FILE (JclFavoriteFoldersExpertDLL-L.xml)

     Last generated: 26-12-2005  13:10:25 UTC
-----------------------------------------------------------------------------
}

{$R *.res}
{$ALIGN 8}
{$ASSERTIONS ON}
{$BOOLEVAL OFF}
{$DEBUGINFO OFF}
{$EXTENDEDSYNTAX ON}
{$IMPORTEDDATA ON}
{$IOCHECKS ON}
{$LOCALSYMBOLS ON}
{$LONGSTRINGS ON}
{$OPENSTRINGS ON}
{$OPTIMIZATION ON}
{$OVERFLOWCHECKS OFF}
{$RANGECHECKS OFF}
{$REFERENCEINFO ON}
{$SAFEDIVIDE OFF}
{$STACKFRAMES OFF}
{$TYPEDADDRESS OFF}
{$VARSTRINGCHECKS ON}
{$WRITEABLECONST OFF}
{$MINENUMSIZE 1}
{$IMAGEBASE $58020000}
{$DESCRIPTION 'JCL Open and Save IDE dialogs with favorite folders'}
{$LIBSUFFIX 'D60'}
{$IMPLICITBUILD OFF}

uses
  ToolsAPI,
  IdeOpenDlgFavoriteUnit in '..\..\experts\favfolders\IdeOpenDlgFavoriteUnit.pas' ,
  OpenDlgFavAdapter in '..\..\experts\favfolders\OpenDlgFavAdapter.pas' 
  ;

exports
  JCLWizardInit name WizardEntryPoint;

end.
