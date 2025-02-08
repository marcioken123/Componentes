unit LMDSysLog;
{$I LMDCmps.inc}

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

LMDSysLog unit (JH)
-------------------
The TLMDSysLog component is a component providing log file access.

ToDo
----
* should provide several storage options
* maximimum number of entries (circled buffer, -1 = no limit)
* storeto filename, save compressed, max file size
* delimiter for stored values, storeValues: (old, new, propDescript, dt)
* order of values to be stored
* event if s.th is to be stored (for giving chance to change this)

Changes
-------
Release 3.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  LMDSysBase, StdCtrls;

type
  TLMDSysLogChangeEvent = procedure(Sender: TObject; propertyDescription, oldValue, newValue: string; datetime: TDateTime) of object;

  { ************************************************************************** }
  TLMDSysLog = class(TLMDSysComponent)
  private
    FOnLog: TLMDSysLogChangeEvent;

    FLogStrings: TStrings;
    FLogMemo   : TMemo;
    FLogListBox: TCustomListBox;
  protected
    procedure AddLogString (const aString: String);
    procedure Notification (AComponent: TComponent; Operation: TOperation); override;
  public
    //SetLogCombo
    //SetLogFile
    //SetLogStream
    procedure SetLogMemo (aMemo: TMemo);
    procedure SetLogListBox (aListBox: TCustomListBox);
    //string object assigned by using this method MUST be manually removed
    //call this method with nil as parameter value
    procedure SetLogStrings (aStringObject: TStrings);
    //the log procedure writes the specified items to the log strings container
    procedure Log(changedItem, oldValue, newValue: string; datetime: TDateTime); overload;
    //dateTime is automatically added (current system dateTime)
    procedure Log(changedItem, oldValue, newValue: string); overload;
    //this will add aString to the LogFile
    procedure LogString(const aString: string);
  published
    property OnLog: TLMDSysLogChangeEvent read FOnLog write FOnLog;
  end;

implementation

{ ******************************* TLMDSysLog ********************************* }
{ --------------------------------- protected -------------------------------- }
procedure TLMDSysLog.AddLogString (const aString: String);
begin
  if Assigned (FLogMemo) then
    FLogMemo.Lines.Add (aString);
  if Assigned (FLogListBox) then
    FLogListBox.Items.Add (aString);
  try
    if Assigned (FLogStrings) then
      FLogStrings.Add (aString);
  except
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDSysLog.Notification (AComponent: TComponent; Operation: TOperation);
begin
  inherited Notification (AComponent, Operation);
  if AComponent = FLogMemo then
    FLogMemo := nil;
  if AComponent = FLogListBox then
    FLogListBox := nil;
end;

{ --------------------------------- public ----------------------------------- }
procedure TLMDSysLog.SetLogMemo (aMemo: TMemo);
begin
  FLogMemo := aMemo;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDSysLog.SetLogListBox (aListBox: TCustomListBox);
begin
  FLogListBox := aListBox;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDSysLog.SetLogStrings (aStringObject: TStrings);
begin
  FLogStrings := aStringObject;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDSysLog.Log(changedItem, oldValue, newValue: string; datetime: TDateTime);
begin
  if Assigned(FOnLog) then
    FOnLog(Self, changedItem, oldValue, newValue, datetime);
  AddLogString (changedItem+':'+oldValue+' - '+newValue+' '+DateTimeToStr (datetime));
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDSysLog.Log(changedItem, oldValue, newValue: string);
begin
  Log(changedItem, oldValue, newValue, now);
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDSysLog.LogString(const aString: string);
begin
  AddLogString (aString);
end;

end.
