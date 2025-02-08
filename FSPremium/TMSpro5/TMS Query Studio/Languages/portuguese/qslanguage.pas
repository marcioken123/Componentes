unit wsLanguage;

interface

implementation

uses
  wsRes;

const LanguageStr = 
'[strings]' + #13#10 +
'SAfter=depois' + #13#10 +
'SAggregationFunctionNotAllowed=Fun��o de agrega��o "%s" n�o permitida para o tipo de dados "%s"' + #13#10 +
'SAlias=apelido' + #13#10 +
'SAmbiguousError=Erro amb�guo' + #13#10 +
'SAnd=E' + #13#10 +
'SAndNot=E n�o' + #13#10 +
'SAnyFile=Todos os arquivos' + #13#10 +
'SAs=como' + #13#10 +
'SAscending=crescente' + #13#10 +
'SAutomaticListEditor=Editor de lista autom�tica' + #13#10 +
'SAvg=M�dia de' + #13#10 +
'SBefore=antes' + #13#10 +
'SBring=Obter' + #13#10 +
'SCancel=Cancelar' + #13#10 +
'SCannotClearParser=N�o � poss�vel limpar o parser durante o processamento' + #13#10 +
'SCapabilityNotSupportedJoins=Recurso n�o suportado em condi��es de jun��o ligando a tabela "%s" � "%s"' + #13#10 +
'SCheckListEditor=Editor de lista de marca��o' + #13#10 +
'SChooseListEditor=Editor de lista de escolha' + #13#10 +
'SCompareFieldToAnother=Comparar um campo a outro campo' + #13#10 +
'SCompareFieldToParametricValue=Comparar um campo a um valor param�trico' + #13#10 +
'SCompareFieldToSpecificValue=Comparar um campo a um valor espec�fico' + #13#10 +
'SConditionExpressionNotSpecified=Express�o da condi��o n�o especificada' + #13#10 +
'SConditionRightSideNotSpecified=Lado direito da condi��o n�o especificado' + #13#10 +
'SConfirmChangeLogicalConnector=Confirma modifica��o do conector l�gico das condi��es agrupadas?' + #13#10 +
'SConfirmClearAllItems=Limpar todos os itens?' + #13#10 +
'SConfirmDeleteSelectedItems=Deseja realmente excluir os itens selecionados?' + #13#10 +
'SConfirmExcludeAllDefinitions=Confirma exclus�o de todas as defini��es da consulta "%s"?' + #13#10 +
'SConfirmUpdatingMetaSQL=Confirma atualiza��o do componente MetaSQL com a senten�a SQL atual?' + #13#10 +
'SContaining=contendo' + #13#10 +
'SCount=Quantidade' + #13#10 +
'SCustomExpression=Express�o personalizada' + #13#10 +
'SCustomExpressionSQLSyntax=Express�o personalizada (sintaxe SQL)' + #13#10 +
'SDatabaseNameNotInformed=Nome do banco de dados n�o informado' + #13#10 +
'SDataFields=Campos de dados' + #13#10 +
'SDataTypeNotIndicated=Tipo de dados n�o indicado' + #13#10 +
'SDate=data' + #13#10 +
'SDay=dia' + #13#10 +
'SDeleteThisQuery=&Excluir esta consulta' + #13#10 +
'SDescending=decrescente' + #13#10 +
'SDifferent=diferente' + #13#10 +
'SDropdownAutomatic=Lista autom�tica' + #13#10 +
'SDropdownCheck=Lista de marca��o' + #13#10 +
'SDropdownChoose=Lista de escolha' + #13#10 +
'SDropdownQuery=Lista de consulta' + #13#10 +
'SDuplicateThisQuery=Du&plicar esta consulta como...' + #13#10 +
'SEditMetaSQL=Editar Meta SQL' + #13#10 +
'SEditParameterEditorTitled=Editar par�metro:%s com editor %s, t�tulo "%s"' + #13#10 +
'SEmpty=vazio' + #13#10 +
'SEndingWith=terminando com' + #13#10 +
'SEnterTableAlias=Informe o apelido da tabela:' + #13#10 +
'SEqual=igual' + #13#10 +
'SErrorOpeningQueryCombo=Erro abrindo query interna do TatQueryCombo:' + #13#10 +
'SErroSintaxeLinhaColuna=Erro de sintaxe na linha %d, coluna %d do Meta SQL:' + #13#10 +
'SExportQueriesToFile=Exportar consultas para arquivo' + #13#10 +
'SExpression=Express�o' + #13#10 +
'SExpressionAliasTitled=Express�o %s apelido %s, t�tulo "%s"' + #13#10 +
'SExpressionFieldNotSpecified=Campo da express�o n�o especificado' + #13#10 +
'SExpressionOperatorNotSpecified=Operador da express�o n�o especificado' + #13#10 +
'SFalse=N�o' + #13#10 +
'SField=campo' + #13#10 +
'SFieldAliasNotIndicated=Apelido do campo n�o indicado' + #13#10 +
'SFieldAliasNotUnique=Apelido do campo n�o � �nico no Meta SQL' + #13#10 +
'SFieldCalculatedByAnExpression=Campo calculado por uma express�o' + #13#10 +
'SFieldComparing=Compara��o de campos' + #13#10 +
'SFieldExpressionNotIndicated=Express�o do campo n�o indicada' + #13#10 +
'SFieldKindAvg=M�dia de (calcula a m�dia do valor do campo em um conjunto de registros)' + #13#10 +
'SFieldKindBring=Obter (retorna os valores individuais do campo de uma tabela do banco de dados)' + #13#10 +
'SFieldKindCount=Quantidade (conta o n�mero de ocorr�ncias do valor do campo em um conjunto de registros)' + #13#10 +
'SFieldKindMax=M�ximo de (retorna o valor m�ximo do campo em um conjunto de registros)' + #13#10 +
'SFieldKindMin=M�nimo de (retorna o valor m�nimo do campo em um conjunto de registros)' + #13#10 +
'SFieldKindSum=Soma de (calcula a soma dos valores do campo em um conjunto de registros)' + #13#10 +
'SFieldNameNotIndicated=Nome do campo n�o indicado' + #13#10 +
'SFieldNotIndicated=Campo n�o indicado' + #13#10 +
'SFilterConditions=Condi��es de filtro' + #13#10 +
'SFreeTyping=edi��o livre' + #13#10 +
'SFreeTypingEditor=Editor de edi��o livre' + #13#10 +
'SGreaterOrEqual=maior ou igual a' + #13#10 +
'SGreaterThan=maior que' + #13#10 +
'SGroupingFields=Campos para agrupamento' + #13#10 +
'SImportQueriesFromFile=Importar consultas de arquivo' + #13#10 +
'SImportQueryFromTargetDataset=Importar consulta do Dataset' + #13#10 +
'SImportQueryFromTargetMetaSQL=Importar consulta do Meta SQL' + #13#10 +
'SInclude=Incluir' + #13#10 +
'SIncludeANewItem=incluir um novo item' + #13#10 +
'SIncorrectGrammarLiteralString=Gram�tica incorreta. String literal n�o terminada em "%s"' + #13#10 +
'SIncorrectGrammarSubexpressionEmpty=Gram�tica incorreta. Subexpress�o est� vazia em "%s"' + #13#10 +
'SIncorrectGrammarSubexpressionNotTerminated=Gram�tica incorreta. Subexpress�o n�o terminada em "%s"' + #13#10 +
'SIndexOutOfBounds=�ndice fora da faixa' + #13#10 +
'SInvalidFieldType=Tipo de campo inv�lido' + #13#10 +
'SInvalidIncludedInputBuffer=Buffer de leitura inclu�do inv�lido. Cada n� deve iniciar e terminar no mesmo buffer' + #13#10 +
'SInvalidMetaSQL=Meta SQL inv�lido:' + #13#10 +
'SInvalidSQLForQueryCombo=SQL inv�lida para query interna do TatQueryCombo' + #13#10 +
'SInvalidQueryFirstSecondFields=Consulta inv�lida. O primeiro campo deve ser a chave e o segundo a legenda' + #13#10 +
'SItemSets=item "%s" define' + #13#10 +
'SJoinConditionEmpty=Condi��o de jun��o est� vazia' + #13#10 +
'SJoinConditionError=Erro na condi��o de jun��o:' + #13#10 +
'SLessOrEqual=menor ou igual a' + #13#10 +
'SLessThan=menor que' + #13#10 +
'SLike=similar a' + #13#10 +
'SMainConditions=Condi��es principais' + #13#10 +
'SMax=M�ximo de' + #13#10 +
'SMin=M�nimo de' + #13#10 +
'SMonth=m�s' + #13#10 +
'SNaoPossivelInserirSubstring=N�o � poss�vel inserir uma substring no n� "%s", porque ela pertence a seu sub-n� %d ("%s")' + #13#10 +
'SNaoPossivelModificarSubstring=N�o � poss�vel modificar a substring "%s" do n� "%s", porque ela pertence a seu sub-n� %d ("%s")' + #13#10 +
'SNestedConditions=Condi��es aninhadas...' + #13#10 +
'SNestedSubconditions=Subcondi��es aninhadas' + #13#10 +
'SNewCheckItem=novo item de marca��o' + #13#10 +
'SNewChooseItem=novo item de escolha' + #13#10 +
'SNewCondition=nova condi��o' + #13#10 +
'SNewEditor=novo editor' + #13#10 +
'SNewField=novo campo' + #13#10 +
'SNewGroupField=novo campo de agrupamento' + #13#10 +
'SNewOrderField=novo campo de ordena��o' + #13#10 +
'SNewParameterAssignment=nova atribui��o de par�metro' + #13#10 +
'SNewQuery=&Nova consulta...' + #13#10 +
'SNewTable=nova tabela' + #13#10 +
'SNewVisualQueryTitle=(Nova consulta visual)' + #13#10 +
'SNone=(nenhum)' + #13#10 +
'SNotEnoughTableLinks=Uma ou mais tabelas n�o ligadas' + #13#10 +
'SNotImplemented=N�o implementado' + #13#10 +
'SNow=agora' + #13#10 +
'SNull=nulo' + #13#10 +
'SNullNode=N� nulo' + #13#10 +
'SOff=inativo' + #13#10 +
'SOK=OK' + #13#10 +
'SOr=Ou' + #13#10 +
'SOrderingFields=Campos de ordena��o' + #13#10 +
'SOrNot=Ou n�o' + #13#10 +
'SParamCaptionNotSpecified=Legenda do par�metro n�o especificada' + #13#10 +
'SParameter=par�metro' + #13#10 +
'SParameterEditors=Editores de par�metro' + #13#10 +
'SParameterTo=parameter: %s para "%s"' + #13#10 +
'SParamNameNotIndicated=Nome do par�metro n�o indicado' + #13#10 +
'SParamNameNotReferFieldComparingCondition=Nome do par�metro n�o se refere a uma condi��o de compara��o de campos' + #13#10 +
'SParamNameNotValid=Nome do par�metro � inv�lido.' + #13#10 +
'SQueryAlreadyExists=Consulta "%s" j� existe. Deseja sobrescrever?' + #13#10 +
'SQueryDefinitionFile=Arquivo de defini��es de consulta' + #13#10 +
'SQueryEditorForParameter=Editor para o par�metro: %s' + #13#10 +
'SQueryListEditor=Editor de lista de consulta' + #13#10 +
'SQueryTitle=T�tulo da consulta' + #13#10 +
'SSaveCurrentQuery=Salvar consulta atual na lista de consultas' + #13#10 +
'SSelectDirectory=Selecionar diret�rio' + #13#10 +
'SSetContinueOnRemarksShouldOnlyBeCalled=Erro interno' + #13#10 +
'SSetCurrentInputPosShouldOnlyBeCalled=Erro interno' + #13#10 +
'SSetCurrentMaxInputPosShouldOnlyBeCalled=Erro interno' + #13#10 +
'SSetTableAlias=Definir apelido da tabela' + #13#10 +
'SShowSQL=Exibir SQL' + #13#10 +
'SSingleField=Campo individual' + #13#10 +
'SSingleTable=Tabela individual' + #13#10 +
'SSourceTables=Tabelas de origem' + #13#10 +
'SSQLIs=SQL �:' + #13#10 +
'SStartingWith=come�ando com' + #13#10 +
'SSum=Soma de' + #13#10 +
'SSyntaxErrorAtRow=Erro de sintaxe na linha %d caracter %d' + #13#10 +
'SSyntaxOK=Sintaxe OK!' + #13#10 +
'STable=Tabela' + #13#10 +
'STableAliasAlreadyIncluded=Apelido "%s" j� foi inclu�do em outra tabela no Meta SQL' + #13#10 +
'STableAliasEmpty=Apelido da tabela est� vazio' + #13#10 +
'STableAliasJoinedConditioned=%s apelido %s com jun��o %s das tabelas acima, condicionada por' + #13#10 +
'STableJoinHandlingFailure=Falha na manipula��o de jun��o de tabelas' + #13#10 +
'STableLinkedToAnother=Tabela ligada a outra' + #13#10 +
'STableNameEmpty=Nome da tabela est� vazio' + #13#10 +
'STableNotIndicated=Tabela n�o indicada' + #13#10 +
'STargetDatasetNotSupported=Dataset destino n�o compat�vel com o componente TatDatabase corrente.' + #13#10 +
'STentativaAcessarPosicaoInexistente=Tentativa de acessar uma posi��o inexistente no fonte' + #13#10 +
'STentativaInserirSubstring=Tentativa de inserir uma substring fora do n� "%s"' + #13#10 +
'STentativaModificarSubstring=Tentativa de modificar uma substring n�o pertinente ao n� "%s"' + #13#10 +
'STitled=t�tulo' + #13#10 +
'SToday=hoje' + #13#10 +
'STokenDoesNotContainSubnode="%s" n�o cont�m o sub-n� %d' + #13#10 +
'STokenIsNotNode="%s" n�o � um n� %s' + #13#10 +
'STrue=Sim' + #13#10 +
'SUndefinedValue=indefinido' + #13#10 +
'SValue=valor' + #13#10 +
'SValuesAppliedNoItemSelected=Valores a aplicar quando nenhum item estiver selecionado:' + #13#10 +
'SValuesAppliedItemSelected=Valores a aplicar quando o item "%s" estiver selecionado:' + #13#10 +
'SVisualQueryEditor=Editor de consulta visual' + #13#10 +
'SWhen=Quando' + #13#10 +
'SWhenNot=Quando n�o' + #13#10 +
'SWith=comum' + #13#10 +
'SYear=ano' + #13#10 +
'SYouMustCompleteUndefinedItem=Voc� deve completar a defini��o do item indefinido para incluir um novo' + #13#10 +
'SYouMustSpecifyTargetDataset=Voc� deve especificar a propriedade TargetDataset para importar a consulta' + #13#10 +
'SYouMustSpecifyTargetMetaSQL=Voc� deve especificar a propriedade TargetMetaSQL para importar a consulta' + #13#10 +
'' + #13#10 +
'[atMetaSQLConditionEditor]' + #13#10 +
'fmMetaSQLConditionEditor.Label2.Caption=Valor' + #13#10 +
'fmMetaSQLConditionEditor.lbLinkType.Caption=Operador' + #13#10 +
'fmMetaSQLConditionEditor.Label1.Caption=Apelido do campo' + #13#10 +
'fmMetaSQLConditionEditor.Label3.Caption=Nome da condi��o' + #13#10 +
'fmMetaSQLConditionEditor.Label8.Caption=Tipo da condi��o' + #13#10 +
'fmMetaSQLConditionEditor.Label7.Caption=Express�o' + #13#10 +
'fmMetaSQLConditionEditor.Label4.Caption=Operador das subcondi��es' + #13#10 +
'fmMetaSQLConditionEditor.lvItems.Items0.Caption=Nome da condi��o' + #13#10 +
'fmMetaSQLConditionEditor.lvItems.Items1.Caption=Apelido do campo' + #13#10 +
'fmMetaSQLConditionEditor.lvItems.Items2.Caption=Operador' + #13#10 +
'fmMetaSQLConditionEditor.lvItems.Items3.Caption=Valor' + #13#10 +
'fmMetaSQLConditionEditor.lvItems.Items4.Caption=Conector' + #13#10 +
'fmMetaSQLConditionEditor.lvItems.Items5.Caption=Tipo da condi��o' + #13#10 +
'fmMetaSQLConditionEditor.lvItems.Items6.Caption=Express�o' + #13#10 +
'' + #13#10 +
'[atMetaSQLConditionForm]' + #13#10 +
'fmMetaSQLConditionForm.Self.Caption=Editor de condi��es' + #13#10 +
'' + #13#10 +
'[atmetasqlcustomeditor]' + #13#10 +
'fmMetaSQLCustomEditor.btInsert.Caption=&Salvar' + #13#10 +
'fmMetaSQLCustomEditor.acNew.Caption=&Novo' + #13#10 +
'fmMetaSQLCustomEditor.acInsert.Caption=&Inserir' + #13#10 +
'fmMetaSQLCustomEditor.acCancel.Caption=&Cancelar' + #13#10 +
'fmMetaSQLCustomEditor.acEdit.Caption=&Editar' + #13#10 +
'fmMetaSQLCustomEditor.acClearItems.Caption=Limpar todos os itens' + #13#10 +
'fmMetaSQLCustomEditor.acDelete.Caption=E&xcluir' + #13#10 +
'' + #13#10 +
'[atMetaSQLFieldEditor]' + #13#10 +
'fmMetaSQLFieldEditor.Label1.Caption=Legenda' + #13#10 +
'fmMetaSQLFieldEditor.Label2.Caption=Apelido da tabela' + #13#10 +
'fmMetaSQLFieldEditor.Label3.Caption=Nome do campo' + #13#10 +
'fmMetaSQLFieldEditor.Label4.Caption=Fun��o de agrupamento' + #13#10 +
'fmMetaSQLFieldEditor.Label5.Caption=Tipo de dado' + #13#10 +
'fmMetaSQLFieldEditor.Label6.Caption=Apelido do campo' + #13#10 +
'fmMetaSQLFieldEditor.Label7.Caption=Express�o do campo' + #13#10 +
'fmMetaSQLFieldEditor.Label8.Caption=Tipo da express�o' + #13#10 +
'fmMetaSQLFieldEditor.Label10.Caption=Vis�vel' + #13#10 +
'fmMetaSQLFieldEditor.lbOptions.Caption=Op��es' + #13#10 +
'fmMetaSQLFieldEditor.lvItems.Items0.Caption=Apelido do campo' + #13#10 +
'fmMetaSQLFieldEditor.lvItems.Items1.Caption=Apelido da tabela' + #13#10 +
'fmMetaSQLFieldEditor.lvItems.Items2.Caption=Nome do campo' + #13#10 +
'fmMetaSQLFieldEditor.lvItems.Items3.Caption=Tipo de dado' + #13#10 +
'fmMetaSQLFieldEditor.lvItems.Items4.Caption=Legenda' + #13#10 +
'fmMetaSQLFieldEditor.lvItems.Items5.Caption=Fun��o de agrupamento' + #13#10 +
'fmMetaSQLFieldEditor.lvItems.Items6.Caption=Express�o' + #13#10 +
'fmMetaSQLFieldEditor.lvItems.Items7.Caption=Express�o do campo' + #13#10 +
'fmMetaSQLFieldEditor.lvItems.Items8.Caption=Vis�vel' + #13#10 +
'fmMetaSQLFieldEditor.lvItems.Items9.Caption=Oculto para o usu�rio' + #13#10 +
'fmMetaSQLFieldEditor.lvItems.Items10.Caption=Sempre na consulta' + #13#10 +
'fmMetaSQLFieldEditor.lvItems.Items11.Caption=Pode ordenar por' + #13#10 +
'fmMetaSQLFieldEditor.lvItems.Items12.Caption=Pode usar em condi��es' + #13#10 +
'fmMetaSQLFieldEditor.acAppendDataset.Caption=&Acrescenter do dataset' + #13#10 +
'fmMetaSQLFieldEditor.acAppendTable.Caption=Acrescentar da &tabela' + #13#10 +
'fmMetaSQLFieldEditor.acTableAlias.Caption=Definir apelido da tabela' + #13#10 +
'fmMetaSQLFieldEditor.ldPickDataset.CancelCaption=Cancelar' + #13#10 +
'fmMetaSQLFieldEditor.ldPickDataset.OkCaption=OK' + #13#10 +
'fmMetaSQLFieldEditor.ldPickDataset.Title=Escolher dataset' + #13#10 +
'' + #13#10 +
'[atMetaSQLForm]' + #13#10 +
'fmMetaSQLEditor.Self.Caption=Editor de Meta SQL' + #13#10 +
'fmMetaSQLEditor.TabControl1.Tabs0=Tabelas' + #13#10 +
'fmMetaSQLEditor.TabControl1.Tabs1=Campos' + #13#10 +
'fmMetaSQLEditor.TabControl1.Tabs2=Jun��es' + #13#10 +
'fmMetaSQLEditor.TabControl1.Tabs3=Condi��es' + #13#10 +
'fmMetaSQLEditor.TabControl1.Tabs4=Ordena��o' + #13#10 +
'fmMetaSQLEditor.TabControl1.Tabs5=Agrupamento' + #13#10 +
'fmMetaSQLEditor.TabControl1.Tabs6=SQL' + #13#10 +
'fmMetaSQLEditor.TabControl1.Tabs7=Dados' + #13#10 +
'fmMetaSQLEditor.Label1.Caption=&Banco de dados:' + #13#10 +
'fmMetaSQLEditor.cbSaveDB.Caption=&Salvar o �ltimo banco de dados usado' + #13#10 +
'fmMetaSQLEditor.acNextTab.Caption=Pr�xima aba' + #13#10 +
'fmMetaSQLEditor.acPreviousTab.Caption=Aba anterior' + #13#10 +
'fmMetaSQLEditor.acImportFromSQL.Caption=Importar da SQL' + #13#10 +
'' + #13#10 +
'[atMetaSQLGroupEditor]' + #13#10 +
'fmMetaSQLGroupEditor.Label2.Caption=Agrupar pelo campo' + #13#10 +
'fmMetaSQLGroupEditor.lvItems.Items0.Caption=Agrupar pelo campo' + #13#10 +
'fmMetaSQLGroupEditor.lvItems.Items1.Caption=' + #13#10 +
'' + #13#10 +
'[atmetasqljoineditor]' + #13#10 +
'fmMetaSQLJoinEditor.Label2.Caption=Apelido da tabela relacionada' + #13#10 +
'fmMetaSQLJoinEditor.Label4.Caption=Tipo de liga��o' + #13#10 +
'fmMetaSQLJoinEditor.Label1.Caption=Apelido da tabela prim�ria' + #13#10 +
'fmMetaSQLJoinEditor.cbLinkType.Items0=Interna (inner join)' + #13#10 +
'fmMetaSQLJoinEditor.cbLinkType.Items1=Esquerda (left join)' + #13#10 +
'fmMetaSQLJoinEditor.cbLinkType.Items2=Direita (right join)' + #13#10 +
'fmMetaSQLJoinEditor.lvItems.Items0.Caption=Tabela prim�ria' + #13#10 +
'fmMetaSQLJoinEditor.lvItems.Items1.Caption=Tabela relacionada' + #13#10 +
'fmMetaSQLJoinEditor.lvItems.Items2.Caption=Descri��o da liga��o' + #13#10 +
'fmMetaSQLJoinEditor.lvItems.Items3.Caption=Subcondi��es' + #13#10 +
'fmMetaSQLJoinEditor.acSubConditions.Caption=Editar &subcondi��es' + #13#10 +
'' + #13#10 +
'[atMetaSQLOrderEditor]' + #13#10 +
'fmMetaSQLOrderEditor.Label2.Caption=Ordenar pelo campo' + #13#10 +
'fmMetaSQLOrderEditor.Label4.Caption=Tipo de ordena��o' + #13#10 +
'fmMetaSQLOrderEditor.cbSortType.Items0=crescente' + #13#10 +
'fmMetaSQLOrderEditor.cbSortType.Items1=decrescente' + #13#10 +
'fmMetaSQLOrderEditor.lvItems.Items0.Caption=Ordenar pelo campo' + #13#10 +
'fmMetaSQLOrderEditor.lvItems.Items1.Caption=Tipo de ordena��o' + #13#10 +
'' + #13#10 +
'[atMetaSQLTableEditor]' + #13#10 +
'fmMetaSQLTableEditor.Label1.Caption=Nome da tabela' + #13#10 +
'fmMetaSQLTableEditor.Label2.Caption=Apelido da tabela' + #13#10 +
'fmMetaSQLTableEditor.lvItems.Columns0.Caption=Nome da tabela' + #13#10 +
'fmMetaSQLTableEditor.lvItems.Columns1.Caption=Apelido da tabela' + #13#10 +
'' + #13#10 +
'[atVisualQueryEditor]' + #13#10 +
'fmVisualQueryEditor.Self.Caption=Editando a consulta visual' + #13#10 +
'fmVisualQueryEditor.TabSheet1.Caption=&Visualizar consulta visual' + #13#10 +
'fmVisualQueryEditor.atVisualQuery1.MetaSqlDefs0.Title=(Nova consulta visual)' + #13#10 +
'fmVisualQueryEditor.Button1.Caption=&OK' + #13#10 +
'fmVisualQueryEditor.Button2.Caption=&Cancelar' + #13#10 +
'' + #13#10 +
'[fCheckListParamEditor]' + #13#10 +
'fmCheckListParamEditor.Self.Caption=Editor de par�metro lista de marca��o' + #13#10 +
'fmCheckListParamEditor.lbInfo.Caption=Este par�metro permite ao usu�rio selecionar um ou mais itens em uma lista suspensa.\#13#10Cada item selecionado aplica todos os valores de par�metro correspondentes � consulta. \#13#10Itens desmarcados desativam os par�metros associados da consulta.' + #13#10 +
'' + #13#10 +
'[fChooseListParamEditor]' + #13#10 +
'fmChooseListParamEditor.Self.Caption=Editor de par�metro lista de escolha' + #13#10 +
'fmChooseListParamEditor.lbInfo.Caption=Este par�metro permite ao usu�rio selecionar um entre v�rios itens em uma lista suspensa.\#13#10O �nico item selecionado aplica todos os valores de par�metro correspondentes � consulta.\#13#10Itens desmarcados desativam os par�metros associados da consulta.' + #13#10 +
'' + #13#10 +
'[fCompareConditionEditor]' + #13#10 +
'fmCompareConditionEditor.Self.Caption=Condi��o de compara��o' + #13#10 +
'fmCompareConditionEditor.Label1.Caption=Express�o:' + #13#10 +
'fmCompareConditionEditor.lbInfo.Caption=Esta condi��o representa uma compara��o simples entre duas informa��es.\#13#10Um campo do banco de dados pode ser comparado a outro campo, a um valor individual ou a um par�metro.' + #13#10 +
'' + #13#10 +
'[fCustomConditionEditor]' + #13#10 +
'fmCustomConditionEditor.Self.Caption=Editor de condi��o' + #13#10 +
'fmCustomConditionEditor.Label3.Caption=Conector:' + #13#10 +
'fmCustomConditionEditor.edLogicOper.Items0=Campo 1' + #13#10 +
'fmCustomConditionEditor.edLogicOper.Items1=Campo 2' + #13#10 +
'fmCustomConditionEditor.edLogicOper.Items2=Campo exemplo' + #13#10 +
'' + #13#10 +
'[fcustomeditor]' + #13#10 +
'fmCustomEditor.Self.Caption=fmCustomEditor' + #13#10 +
'fmCustomEditor.btOk.Caption=&OK' + #13#10 +
'fmCustomEditor.btCancel.Caption=&Cancelar' + #13#10 +
'fmCustomEditor.lbInfo.Caption=' + #13#10 +
'' + #13#10 +
'[fCustomFieldEditor]' + #13#10 +
'fmCustomFieldEditor.Self.Caption=Editor de campo' + #13#10 +
'' + #13#10 +
'[fCustomGroupEditor]' + #13#10 +
'fmCustomGroupEditor.Self.Caption=Campo de agrupamento' + #13#10 +
'fmCustomGroupEditor.Label2.Caption=Express�o do campo:' + #13#10 +
'fmCustomGroupEditor.lbInfo.Caption=Este campo ser� usado para separar fun��es de agrega��o. Geralmente, todos os campos vis�vels que n�o possuem fun��o de agrega��o devem ser agrupados assim.' + #13#10 +
'' + #13#10 +
'[fCustomListParamEditor]' + #13#10 +
'fmCustomListParamEditor.Self.Caption=Editor de par�metro lista' + #13#10 +
'fmCustomListParamEditor.lbParamValues.Caption=Par�metros de condi��o correspondentes:' + #13#10 +
'fmCustomListParamEditor.Label2.Caption=Lista de escolha:' + #13#10 +
'fmCustomListParamEditor.edParamValues.Items0.Caption=Valor' + #13#10 +
'fmCustomListParamEditor.edParamValues.Items1.Caption=Nome do par�metro' + #13#10 +
'fmCustomListParamEditor.edListItems.Items0.Caption=Texto do item' + #13#10 +
'fmCustomListParamEditor.lbInfo.Caption=' + #13#10 +
'' + #13#10 +
'[fCustomOrderEditor]' + #13#10 +
'fmCustomOrderEditor.Self.Caption=Campo de ordena��o' + #13#10 +
'fmCustomOrderEditor.Label2.Caption=Express�o do campo:' + #13#10 +
'fmCustomOrderEditor.Label4.Caption=Dire��o da ordena��o:' + #13#10 +
'fmCustomOrderEditor.edAggregation.Items0=Crescente' + #13#10 +
'fmCustomOrderEditor.edAggregation.Items1=Decrescente' + #13#10 +
'fmCustomOrderEditor.lbInfo.Caption=Este campo pode estar sozinho ou combinado com outros para especificar um crit�rio de ordena��o sobre o resultado da consulta.' + #13#10 +
'' + #13#10 +
'[fCustomParamEditor]' + #13#10 +
'fmCustomParamEditor.Self.Caption=Editor de par�metro' + #13#10 +
'fmCustomParamEditor.Label5.Caption=Caption:' + #13#10 +
'' + #13#10 +
'[fCustomTableEditor]' + #13#10 +
'fmCustomTableEditor.Self.Caption=Tabela da consulta' + #13#10 +
'fmCustomTableEditor.Label1.Caption=Nome da tabela:' + #13#10 +
'fmCustomTableEditor.Label2.Caption=Apelido da tabela:' + #13#10 +
'fmCustomTableEditor.Label4.Caption=Tipo de jun��o:' + #13#10 +
'fmCustomTableEditor.edJoinType.Items0=(sem jun��o)' + #13#10 +
'fmCustomTableEditor.edJoinType.Items1=Interna (inner join)' + #13#10 +
'fmCustomTableEditor.edJoinType.Items2=Esquerda (left join)' + #13#10 +
'fmCustomTableEditor.edJoinType.Items3=Direita (right join)' + #13#10 +
'fmCustomTableEditor.Label3.Caption=Condi��o de jun��o:' + #13#10 +
'fmCustomTableEditor.lbInfo.Caption=A tabela indicada aqui � uma fonte de dados para a consulta. Uma ou mais tabelas podem ser ligadas entre si para construir uma consulta.\#13#10Condi��o de jun��o � usada para ligar esta tabela a outras relacionadas.' + #13#10 +
'' + #13#10 +
'[fDistinctListParamEditor]' + #13#10 +
'fmDistinctListParamEditor.Self.Caption=Editor de par�metro lista distinta' + #13#10 +
'fmDistinctListParamEditor.Label2.Caption=Nome do par�metro:' + #13#10 +
'fmDistinctListParamEditor.lbInfo.Caption=Este par�metro retorna ao usu�rio uma lista de todos os valores distintos contidos na tabela relacionada. A tabela usada � a que cont�m o campo comparado a este par�metro.' + #13#10 +
'' + #13#10 +
'[fExpressionConditionEditor]' + #13#10 +
'fmExpressionConditionEditor.Self.Caption=Condi��o de express�o' + #13#10 +
'fmExpressionConditionEditor.Label5.Caption=Express�o:' + #13#10 +
'fmExpressionConditionEditor.lbInfo.Caption=Esta condi��o pode ser representada por qualquer express�o l�gica v�lida no Meta SQL. Nomes de par�metros podem ser usados, prefixados por dois-pontos.' + #13#10 +
'' + #13#10 +
'[fExpressionFieldEditor]' + #13#10 +
'fmExpressionFieldEditor.Self.Caption=Campo de express�o' + #13#10 +
'fmExpressionFieldEditor.Label4.Caption=Agrega��o:' + #13#10 +
'fmExpressionFieldEditor.edAggregation.Items0=(nenhum)' + #13#10 +
'fmExpressionFieldEditor.edAggregation.Items1=Quantidade' + #13#10 +
'fmExpressionFieldEditor.edAggregation.Items2=Soma' + #13#10 +
'fmExpressionFieldEditor.edAggregation.Items3=M�ximo' + #13#10 +
'fmExpressionFieldEditor.edAggregation.Items4=M�nimo' + #13#10 +
'fmExpressionFieldEditor.edAggregation.Items5=M�dia' + #13#10 +
'fmExpressionFieldEditor.Label6.Caption=Express�o:' + #13#10 +
'fmExpressionFieldEditor.Label3.Caption=Apelido do campo:' + #13#10 +
'fmExpressionFieldEditor.Label5.Caption=Legenda:' + #13#10 +
'fmExpressionFieldEditor.Label7.Caption=Tipo de dado:' + #13#10 +
'fmExpressionFieldEditor.edDataType.Items0=(nenhum)' + #13#10 +
'fmExpressionFieldEditor.edDataType.Items1=Quantidade' + #13#10 +
'fmExpressionFieldEditor.edDataType.Items2=Soma' + #13#10 +
'fmExpressionFieldEditor.edDataType.Items3=M�ximo' + #13#10 +
'fmExpressionFieldEditor.edDataType.Items4=M�nimo' + #13#10 +
'fmExpressionFieldEditor.edDataType.Items5=M�dia' + #13#10 +
'fmExpressionFieldEditor.lbInfo.Caption=Este campo atua como uma informa��o calculada, e sua expres~sao pode ser qualquer express�o de campo v�lida no Meta SQL.' + #13#10 +
'' + #13#10 +
'[fFreeEditParamEditor]' + #13#10 +
'fmFreeEditParamEditor.Self.Caption=Editor de par�metro livre' + #13#10 +
'fmFreeEditParamEditor.Label2.Caption=Nome do par�metro:' + #13#10 +
'fmFreeEditParamEditor.lbInfo.Caption=Este editor permite ao usu�rio digitar valores correspondentes aos par�metros usados pelas condi��es da consulta.' + #13#10 +
'' + #13#10 +
'[fQueryEditor]' + #13#10 +
'fmQueryEditor.Self.Caption=Consulta para editor de par�metro' + #13#10 +
'fmQueryEditor.VisualQuery.MetaSqlDefs0.Title=(Nova consulta visual)' + #13#10 +
'fmQueryEditor.Button1.Caption=&OK' + #13#10 +
'fmQueryEditor.Button2.Caption=&Cancel' + #13#10 +
'' + #13#10 +
'[fQueryListParamEditor]' + #13#10 +
'fmQueryListParamEditor.Self.Caption=Editor de par�metro lista de consulta' + #13#10 +
'fmQueryListParamEditor.Label2.Caption=Nome do par�metro:' + #13#10 +
'fmQueryListParamEditor.Label1.Caption=Meta SQL:' + #13#10 +
'fmQueryListParamEditor.btMetaSql.Caption=Assistente >>' + #13#10 +
'fmQueryListParamEditor.lbInfo.Caption=Este par�metro permite ao usu�rio selecionar um valor de uma lista suspensa. Os itens listados s�o obtidos desta consulta Meta SQL. O primeiro campo da consulta deve corresponder ao campo associado com este par�metro.' + #13#10 +
'' + #13#10 +
'[fSingleFieldEditor]' + #13#10 +
'fmSingleFieldEditor.Self.Caption=Campo individual' + #13#10 +
'fmSingleFieldEditor.Label1.Caption=Tabela:' + #13#10 +
'fmSingleFieldEditor.Label2.Caption=Nome do campo:' + #13#10 +
'fmSingleFieldEditor.Label4.Caption=Agrega��o:' + #13#10 +
'fmSingleFieldEditor.edAggregation.Items0=(nenhum)' + #13#10 +
'fmSingleFieldEditor.edAggregation.Items1=Quantidade' + #13#10 +
'fmSingleFieldEditor.edAggregation.Items2=Soma' + #13#10 +
'fmSingleFieldEditor.edAggregation.Items3=M�ximo' + #13#10 +
'fmSingleFieldEditor.edAggregation.Items4=M�nimo' + #13#10 +
'fmSingleFieldEditor.edAggregation.Items5=M�dia' + #13#10 +
'fmSingleFieldEditor.Label3.Caption=Apelido do campo:' + #13#10 +
'fmSingleFieldEditor.Label5.Caption=Legenda:' + #13#10 +
'fmSingleFieldEditor.Label7.Caption=Tipo de dado:' + #13#10 +
'fmSingleFieldEditor.edDataType.Items0=(nenhum)' + #13#10 +
'fmSingleFieldEditor.edDataType.Items1=Quantidade' + #13#10 +
'fmSingleFieldEditor.edDataType.Items2=Soma' + #13#10 +
'fmSingleFieldEditor.edDataType.Items3=M�ximo' + #13#10 +
'fmSingleFieldEditor.edDataType.Items4=M�nimo' + #13#10 +
'fmSingleFieldEditor.edDataType.Items5=M�dia' + #13#10 +
'fmSingleFieldEditor.lbInfo.Caption=Este campo � uma express�o simples para uma informa��o.\#13#10Apenas um campo do banco de dados pode ser indicado aqui.' + #13#10 +
'' + #13#10 +
'[fSubconditionsEditor]' + #13#10 +
'fmSubconditionsEditor.Self.Caption=Cole��o de condi��es' + #13#10 +
'fmSubconditionsEditor.lbInfo.Caption=Esta condi��o � um grupo de outras subcondi��es.\#13#10A avalia��o de suas subcondi��es depende desta condi��o.' + #13#10 +
'' + #13#10 +
'[ShowSQLForm]' + #13#10 +
'fmShowSQL.Self.Caption=Exibir SQL' + #13#10 +
'fmShowSQL.Button1.Caption=Fechar' + #13#10 +
'' + #13#10 +
'';

initialization
  _ResAddStrings(LanguageStr);

end.
