
{********************************************************************}
{                                                                    }
{       Developer Express Visual Component Library                   }
{       ExpressDataController                                        }
{                                                                    }
{       Copyright (c) 1998-2007 Developer Express Inc.               }
{       ALL RIGHTS RESERVED                                          }
{                                                                    }
{   The entire contents of this file is protected by U.S. and        }
{   International Copyright Laws. Unauthorized reproduction,         }
{   reverse-engineering, and distribution of all or any portion of   }
{   the code contained in this file is strictly prohibited and may   }
{   result in severe civil and criminal penalties and will be        }
{   prosecuted to the maximum extent possible under the law.         }
{                                                                    }
{   RESTRICTIONS                                                     }
{                                                                    }
{   THIS SOURCE CODE AND ALL RESULTING INTERMEDIATE FILES            }
{   (DCU, OBJ, DLL, ETC.) ARE CONFIDENTIAL AND PROPRIETARY TRADE     }
{   SECRETS OF DEVELOPER EXPRESS INC. THE REGISTERED DEVELOPER IS    }
{   LICENSED TO DISTRIBUTE THE EXPRESSDATACONTROLLER AND ALL         }
{   ACCOMPANYING VCL CONTROLS AS PART OF AN EXECUTABLE PROGRAM ONLY. }
{                                                                    }
{   THE SOURCE CODE CONTAINED WITHIN THIS FILE AND ALL RELATED       }
{   FILES OR ANY PORTION OF ITS CONTENTS SHALL AT NO TIME BE         }
{   COPIED, TRANSFERRED, SOLD, DISTRIBUTED, OR OTHERWISE MADE        }
{   AVAILABLE TO OTHER INDIVIDUALS WITHOUT EXPRESS WRITTEN CONSENT   }
{   AND PERMISSION FROM DEVELOPER EXPRESS INC.                       }
{                                                                    }
{   CONSULT THE END USER LICENSE AGREEMENT FOR INFORMATION ON        }
{   ADDITIONAL RESTRICTIONS.                                         }
{                                                                    }
{********************************************************************}

unit cxFilterConsts;

{$I cxVer.inc}

interface

resourcestring
  // base operators
  cxSFilterOperatorEqual = 'equals';
  cxSFilterOperatorNotEqual = 'does not equal';
  cxSFilterOperatorLess = 'is less than';
  cxSFilterOperatorLessEqual = 'is less than or equal to';
  cxSFilterOperatorGreater = 'is greater than';
  cxSFilterOperatorGreaterEqual = 'is greater than or equal to';
  cxSFilterOperatorLike = 'like';
  cxSFilterOperatorNotLike = 'not like';
  cxSFilterOperatorBetween = 'between';
  cxSFilterOperatorNotBetween = 'not between';
  cxSFilterOperatorInList = 'in';
  cxSFilterOperatorNotInList = 'not in';

  cxSFilterOperatorYesterday = 'is yesterday';
  cxSFilterOperatorToday = 'is today';
  cxSFilterOperatorTomorrow = 'is tomorrow';

  cxSFilterOperatorLast7Days = 'is last 7 days';
  cxSFilterOperatorLastWeek = 'is last week';
  cxSFilterOperatorLast14Days = 'is last 14 days';
  cxSFilterOperatorLastTwoWeeks = 'is last two weeks';
  cxSFilterOperatorLast30Days = 'is last 30 days';
  cxSFilterOperatorLastMonth = 'is last month';
  cxSFilterOperatorLastYear = 'is last year';
  cxSFilterOperatorPast = 'is past';

  cxSFilterOperatorThisWeek = 'is this week';
  cxSFilterOperatorThisMonth = 'is this month';
  cxSFilterOperatorThisYear = 'is this year';

  cxSFilterOperatorNext7Days = 'is next 7 days';
  cxSFilterOperatorNextWeek = 'is next week';
  cxSFilterOperatorNext14Days = 'is next 14 days';
  cxSFilterOperatorNextTwoWeeks = 'is next two weeks';
  cxSFilterOperatorNext30Days = 'is next 30 days';
  cxSFilterOperatorNextMonth = 'is next month';
  cxSFilterOperatorNextYear = 'is next year';
  cxSFilterOperatorFuture = 'is future';

  cxSFilterAndCaption = 'and';
  cxSFilterOrCaption = 'or';
  cxSFilterNotCaption = 'not';
  cxSFilterBlankCaption = 'blank';

  // derived
  cxSFilterOperatorIsNull = 'is blank';
  cxSFilterOperatorIsNotNull = 'is not blank';
  cxSFilterOperatorBeginsWith = 'begins with';
  cxSFilterOperatorDoesNotBeginWith = 'does not begin with';
  cxSFilterOperatorEndsWith = 'ends with';
  cxSFilterOperatorDoesNotEndWith = 'does not end with';
  cxSFilterOperatorContains = 'contains';
  cxSFilterOperatorDoesNotContain = 'does not contain';
  // filter listbox's values
  cxSFilterBoxAllCaption = '(All)';
  cxSFilterBoxCustomCaption = '(Custom...)';
  cxSFilterBoxBlanksCaption = '(Blanks)';
  cxSFilterBoxNonBlanksCaption = '(NonBlanks)';

function cxSFilterString(AResString: {$IFNDEF CLR}PResStringRec{$ELSE}string{$ENDIF}): string;

type
  TcxFilterGetResourceStringFunc = function(
    AResString: {$IFNDEF CLR}PResStringRec{$ELSE}string{$ENDIF}): string;

var
  cxFilterGetResourceStringFunc: TcxFilterGetResourceStringFunc;

implementation

function cxSFilterString(
  AResString: {$IFNDEF CLR}PResStringRec{$ELSE}string{$ENDIF}): string;
begin
  if Assigned(cxFilterGetResourceStringFunc) then
    Result := cxFilterGetResourceStringFunc(AResString)
  else
    Result := {$IFNDEF CLR}LoadResString(AResString){$ELSE}AResString{$ENDIF};
end;

end.
