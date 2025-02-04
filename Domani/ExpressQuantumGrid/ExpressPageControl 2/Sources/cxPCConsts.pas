
{********************************************************************}
{                                                                    }
{       Developer Express Visual Component Library                   }
{       ExpressPageControl                                           }
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
{   LICENSED TO DISTRIBUTE THE EXPRESSPAGECONTROL AND ALL            }
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

unit cxPCConsts;

interface

resourcestring
  scxPCImageListIndexError = 'Index (%d) must be between 0 and %d';
  scxPCNoBaseImages = 'BaseImages is not assigned';
  scxPCNoRegisteredStyles = 'There are no styles registered';
  scxPCPageIndexError = '%d is an invalid PageIndex value.  PageIndex must be ' +
    'between 0 and %d';
  scxPCPainterClassError = 'PCPainterClass is nil';
  scxPCStandardStyleError = '%s is an unsupported standard style';
  scxPCStyleNameError = '%s is an unregistered style name';
  scxPCTabCountEqualsZero = 'Tabs.Count = 0';
  scxPCTabIndexError = 'Tab''s index (%d) out of bounds';
  scxPCTabVisibleIndexOutsOfBounds = 'TabVisibleIndex (%d) must be between 0 and %d';
  scxPCVisibleTabListEmpty = 'There are no visible tabs';
  scxPCAllowRotateError = '%s style does not support rotation of tabs';

implementation

end.
