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
  SLMDInvalidItemName = 'Неверное имя элемента: ''%s''';
  SLMDInvalidHandlerName = 'Неверное имя обработчика события ''%s''';
  SLMDInvalidHandlerOwner = '''%s'' имеет неверного владельца обратотчика события';
  SLMDItemExist = 'Элемент ''%s'' уже существует';
  SLMDNotImplemented = 'Функция не реализована';

  SLMDItemNotFound = 'Элемент не найден';
  SLMDNamedItemNotFound = 'Элемент ''%s'' не найден';

  SLMDDsgnrCompLockedDel = 'Компонент ''%s'' или один из его вложенных компонентов' +
                           #13#10 + 'защищены от удаления';
  SLMDDsgnrCompsLockedDel = 'Невозможно удалить компоненты. Некоторые компоненты защищены от удаления';
  SLMDDsgnrMastBeActive = 'Дизайнер должен быть активен';
  SLMDDsgnrMastBeInactive = 'Дизайнер должен быть неактивен';
  SLMDDsgnrMisingDesignCtrl = 'Не задано свойство ''Module'' или ''Module.Root''';
  SLMDDsgnrMisingSelection = 'Не задано свойство ''Selection''';
  SLMDDsgnrRootHaveParent = 'Свойство ''Parent'' у компонента, используемого в качестве ' +
                            #13#10 + '''Module.Root'' должно быть равно nil';
  SLMDDsgnrMisingDesignPanel = 'Не задано значение свойству ''DesignPanel''';
  SLMDDsgnrDesignPanelIsUsed = 'Дизайн-панель ''%s'' уже используется другим дизайнером';
  SLMDDsgnrCanNotSelectComp = 'Компонент ''%s'' не может быть веделен';
  SLMDDsgnrCompHaveNoVisualRepr = 'Компонент ''%s'' не имеет визуального представления';
  SLMDDsgnrSameCollections = 'Свойства ''Selection'' и ''RootChildren'' не должны ' +
                             'указывать на один компонент.';

  SLMDPropPageUnableActivateItem = 'Элемент не может быть активирован';

  SLMDPropInspObjectsLocked = 'Инспектор свойств находится в состоянии изменения значения свойства. ' +
                             'Операция недоступна в данное время.';
  SLMDPropInspOutOfRange = 'Значение свойства должно быть между %d и %d';
  SLMDPropInspInvPropValue = 'Неверное значение свойства';
  SLMDPropInspEditError = 'Функция ''Edit'' недоступна';

  SLMDStrErDlgCaption = 'String List Editor';
  SLMDStrErDlgOkBtnCaption = '&Ok';
  SLMDStrErDlgCancelBtnCaption = 'Отмена';
  SLMDStrErDlgLinesCountTemplate = 'Кол-во строк: %d';

  SLMDDgrmSelItemError = 'Невидимый элемент не может быть выделен';
  SLMDDgrmSelLinkError = 'Невидимая связь не может быть выделена';
  SLMDDgrmShowItemError = 'Невозможно показать невидимый элемент';

  SLMDObtCmBxNoObjectsSelected = 'Объекты не выделены';
  SLMDObtCmBxManyObjectsSelected = '%d объектов(а) выделено';
  SLMDObtCmBxSameCollections = 'Свойства ''Selection'' и ''ListObjects'' не должны ' +
                               'указывать на один компонент.';

  SLMDDsgMgrDublicateDesigner = 'Дизайнер ''%s'' уже используется';
  SLMDDsgMgrNonActiveCurDesigner = 'Текущий дизайнер должен быть активен';
  SLMDDsgMgrNonBreakedCurDebugger   = 'Current debugger must be in break.';

implementation

end.
