unit LMDXPRes;
{###############################################################################

LMDXPRes unit (RM)
---------------------
Include this unit to add Themes Manifest file to your application.
In Delphi 7 or better TXPManifest can be used instead.

Changes
-------
Release 8.0 (October 2006)
 - Initial Release

###############################################################################}

interface

implementation
uses
  LMDClass;

{$R LMDXP.res}

initialization
  LMDApplication.XPManifestAvailable:=True;

end.
