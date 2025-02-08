unit pLMDElDBNavDsgn;
{$I lmdcmps.inc}

{###############################################################################

LMD VCL Series 2016
© by LMD Innovative
-------------------

For support or information contact us at:

email              : mail@lmdsupport.com
WWW                : http://www.lmdinnovative.com
SupportSite        : http://www.lmdsupport.com
Wiki               : http://wiki.lmd.de
Fax                : ++49 6131 4984372

This code is for reference purposes only and may not be copied
or distributed in any format electronic or otherwise except one
copy for backup purposes.

No Component Kit or Component individually or in a collection,
subclassed or otherwise from the code in this unit, or associated
.pas, .dfm, .dcu, .ocx, .dll or ActiveX files may be sold or
distributed without express permission from LMD Innovative.

For further license information please refer to the associated
license html file in \info folder.

################################################################################

pLMDElDBNavDsgn unit
--------------------


Changes
-------
Release 6.0 (February 2007)
 - Initial Release

###############################################################################}

interface

uses 
  DesignEditors, DesignWindows, DsnConst, DesignIntf,
  ElToolBar, ElDBCtrls;

type
  TElDBNavigatorEditor = class(TComponentEditor)
    procedure ExecuteVerb(Index : Integer); override;
    function GetVerb(Index : Integer) : string; override;
    function GetVerbCount : Integer; override;
  end;

implementation

//type
//  THackButton = class(TElDBNavButton);

procedure TElDBNavigatorEditor.ExecuteVerb(Index : Integer);
  var
    ElDBNav        : TElDBNavigator;
    ElDBNavBtn     : TElDBNavButton;
    ElDBNavBtnPrev : TElDBNavButton;
    i              : integer;

    TBar : TElToolBar;
    TButton : TElToolButton;

begin
  if Index = 0 then
  begin
        ElDBNav := Component as TElDBNavigator;
        ElDBNavBtn :=  Designer.CreateComponent(TElDBNavButton, ElDBNav, 10000, 10000, ElDBNav.BtnWidth, ElDBNav.BtnHeight) as TElDBNavButton;
        // Set Next Role
          ElDBNavBtnPrev := nil;
          // scan previous Role
          for i:=ElDBNav.ButtonCount-2 DownTo 0 do
            begin
              if ElDBNav.CustomToolButton[i] is TElDBNavButton then
               begin
                 ElDBNavBtnPrev := TElDBNavButton(ElDBNav.ToolButton[i]);
                 break;
               end;
            end;
          // assign role
          if ElDBNavBtnPrev=nil
            then ElDBNavBtn.Role := nbrFirst
            else
             begin
                if ElDBNavBtnPrev.Role < nbrCustom //High(TElNavButtonRole)
                  then ElDBNavBtn.Role := Succ(ElDBNavBtnPrev.Role);
             end;
  end
  else begin
        TBar := TElToolBar(Component);
        TButton := TElToolButton(Designer.CreateComponent(TElToolButton, TBar, 10000, 10000, TBar.BtnWidth, TBar.BtnHeight));
        if Assigned(TButton) then
        begin
          if Index = 1 then
            TButton.ButtonType := ebtSeparator
          else
            TButton.ButtonType := ebtDivider;
        end;
  end;
end;

//TElToolButtonType = (ebtButton, ebtSeparator, ebtDivider);

function TElDBNavigatorEditor.GetVerb(Index : Integer): string;
begin
  if Index = 0 then
    Result := 'New DB B&utton'
  else
  if Index = 1 then
    Result := 'New S&eparator'
  else
  if Index = 2 then
    Result := 'New D&ivider'
end;

function TElDBNavigatorEditor.GetVerbCount: Integer;
begin
  Result := 3;
end;

end.
