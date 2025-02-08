unit LMDDsgCst;

{
  ##############################################################################
  # Author:           LMD Innovative (YB)
  # Created:          6.10.2002
  # Description:      Contains resource strings needed in the
  #                   LMD Design Pack
  # State:            DEVELOPING
  # Comments:
  #---------------------------------- CHANGES ----------------------------------
  # 2.0: Several constants were added
  ##############################################################################
}

interface

resourcestring
  SLMDInvalidItemName = '�������� ��� ��������: ''%s''';
  SLMDInvalidHandlerName = '�������� ��� ����������� ������� ''%s''';
  SLMDInvalidHandlerOwner = '''%s'' ����� ��������� ��������� ����������� �������';
  SLMDItemExist = '������� ''%s'' ��� ����������';
  SLMDNotImplemented = '������� �� �����������';

  SLMDItemNotFound = '������� �� ������';
  SLMDNamedItemNotFound = '������� ''%s'' �� ������';

  SLMDDsgnrCompLockedDel = '��������� ''%s'' ��� ���� �� ��� ��������� �����������' +
                           #13#10 + '�������� �� ��������';
  SLMDDsgnrCompsLockedDel = '���������� ������� ����������. ��������� ���������� �������� �� ��������';
  SLMDDsgnrMastBeActive = '�������� ������ ���� �������';
  SLMDDsgnrMastBeInactive = '�������� ������ ���� ���������';
  SLMDDsgnrMisingDesignCtrl = '�� ������ �������� ''Module'' ��� ''Module.Root''';
  SLMDDsgnrMisingSelection = '�� ������ �������� ''Selection''';
  SLMDDsgnrRootHaveParent = '�������� ''Parent'' � ����������, ������������� � �������� ' +
                            #13#10 + '''Module.Root'' ������ ���� ����� nil';
  SLMDDsgnrMisingDesignPanel = '�� ������ �������� �������� ''DesignPanel''';
  SLMDDsgnrDesignPanelIsUsed = '������-������ ''%s'' ��� ������������ ������ ����������';
  SLMDDsgnrCanNotSelectComp = '��������� ''%s'' �� ����� ���� �������';
  SLMDDsgnrCompHaveNoVisualRepr = '��������� ''%s'' �� ����� ����������� �������������';
  SLMDDsgnrSameCollections = '�������� ''Selection'' � ''RootChildren'' �� ������ ' +
                             '��������� �� ���� ���������.';

  SLMDPropPageUnableActivateItem = '������� �� ����� ���� �����������';

  SLMDPropInspObjectsLocked = '��������� ������� ��������� � ��������� ��������� �������� ��������. ' +
                             '�������� ���������� � ������ �����.';
  SLMDPropInspOutOfRange = '�������� �������� ������ ���� ����� %d � %d';
  SLMDPropInspInvPropValue = '�������� �������� ��������';
  SLMDPropInspEditError = '������� ''Edit'' ����������';

  SLMDStrErDlgCaption = 'String List Editor';
  SLMDStrErDlgOkBtnCaption = '&Ok';
  SLMDStrErDlgCancelBtnCaption = '������';
  SLMDStrErDlgLinesCountTemplate = '���-�� �����: %d';

  SLMDDgrmSelItemError = '��������� ������� �� ����� ���� �������';
  SLMDDgrmSelLinkError = '��������� ����� �� ����� ���� ��������';
  SLMDDgrmShowItemError = '���������� �������� ��������� �������';

  SLMDObtCmBxNoObjectsSelected = '������� �� ��������';
  SLMDObtCmBxManyObjectsSelected = '%d ��������(�) ��������';
  SLMDObtCmBxSameCollections = '�������� ''Selection'' � ''ListObjects'' �� ������ ' +
                               '��������� �� ���� ���������.';

  SLMDDsgMgrDublicateDesigner = '�������� ''%s'' ��� ������������';
  SLMDDsgMgrNonActiveCurDesigner = '������� �������� ������ ���� �������';
  SLMDDsgMgrNonBreakedCurDebugger   = 'Current debugger must be in break.';

implementation

end.
