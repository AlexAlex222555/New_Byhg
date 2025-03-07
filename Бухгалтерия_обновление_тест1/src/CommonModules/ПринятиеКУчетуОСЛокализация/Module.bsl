////////////////////////////////////////////////////////////////////////////////
// Процедуры, используемые для локализации документа "Принятие к учету ОС".
// 
////////////////////////////////////////////////////////////////////////////////

#Область ПрограммныйИнтерфейс

#Область Проведение

// Описывает учетные механизмы используемые в документе для регистрации в механизме проведения.
//
// Параметры:
//  МеханизмыДокумента - Массив - список имен учетных механизмов, для которых будет выполнена
//              регистрация в механизме проведения.
//
Процедура ЗарегистрироватьУчетныеМеханизмы(МеханизмыДокумента) Экспорт
	
	//++ Локализация
	МеханизмыДокумента.Добавить("РегламентированныйУчет");
	//-- Локализация
	
КонецПроцедуры

#КонецОбласти

// Добавляет в текст запроса реквизиты шапки документа.
//  Реквизиты добавляются вместо параметра "&ПринятиеКУчетуОС_РеквизитыДокумента".
//
// Параметры:
//  ТекстЗапроса - Строка				 - Исходный текст запроса.
//  ИмяТаблицы	 - Строка, Неопределено	 - Синоним таблицы документа в запросе.
//  	Для получения пустых значений нужно передать "Неопределено".
//
Процедура ДобавитьВТекстЗапросаРеквизитыДокумента(ТекстЗапроса, ИмяТаблицы = Неопределено) Экспорт
	
	ПоляЛокализации = "NULL";
	
	ПолеСтатьяРасходовУУ =
	"ДанныеДокумента.СтатьяРасходовУУ";
	
	ПолеАналитикаРасходовУУ =
	"ДанныеДокумента.АналитикаРасходовУУ";
	
	ПолеВариантРаспределенияРасходовУпр =
	"ДанныеДокумента.СтатьяРасходовУУ.ВариантРаспределенияРасходовУпр";
	
	//++ Локализация
	ПоляЛокализации =
	"
	|	ДанныеДокумента.СтатьяРасходовБУ                                  КАК СтатьяРасходовБУ,
	|	ДанныеДокумента.СтатьяРасходовБУ.ВариантРаспределенияРасходовРегл КАК ВариантРаспределенияРасходовРегл,
	|	ДанныеДокумента.АналитикаРасходовБУ                               КАК АналитикаРасходовБУ,
	|
	|	ВЫБОР 
	|		КОГДА ДанныеДокумента.СтатьяРасходовНУ = ЗНАЧЕНИЕ(ПланВидовХарактеристик.СтатьиРасходов.ПустаяСсылка)
	|
	|			ТОГДА ДанныеДокумента.СтатьяРасходовБУ
	|
	|		ИНАЧЕ ДанныеДокумента.СтатьяРасходовНУ 
	|	КОНЕЦ                                                             КАК СтатьяРасходовНУ,
	|
	|	ВЫБОР 
	|		КОГДА ДанныеДокумента.СтатьяРасходовНУ = ЗНАЧЕНИЕ(ПланВидовХарактеристик.СтатьиРасходов.ПустаяСсылка)
	|
	|			ТОГДА ДанныеДокумента.АналитикаРасходовБУ
	|
	|		ИНАЧЕ ДанныеДокумента.АналитикаРасходовНУ 
	|	КОНЕЦ                                                             КАК АналитикаРасходовНУ,
	|
	|	ДанныеДокумента.НачислятьАмортизациюБУ                            КАК НачислятьАмортизациюБУ,
	|	ДанныеДокумента.НачислятьАмортизациюНУ                            КАК НачислятьАмортизациюНУ,
	|
	|	ДанныеДокумента.МетодНачисленияАмортизацииБУ 					  КАК МетодНачисленияАмортизацииБУ,
	|
	|	ДанныеДокумента.СрокИспользованияБУ                               КАК СрокИспользованияБУ,
	|	ДанныеДокумента.СрокИспользованияНУ                               КАК СрокИспользованияНУ,
	|	ДанныеДокумента.ГрафикАмортизации                                 КАК ГрафикАмортизации,
	|	ДанныеДокумента.ВариантПримененияЦелевогоФинансирования           КАК ВариантПримененияЦелевогоФинансирования,
	|	ДанныеДокумента.СтатьяДоходов                                     КАК СтатьяДоходов,
	|	ДанныеДокумента.АналитикаДоходов                                  КАК АналитикаДоходов";
	ПоляЛокализации = СтрЗаменить(ПоляЛокализации, "ДанныеДокумента", ИмяТаблицы);

	ПолеСтатьяРасходовУУ =
	"ВЫБОР 
	|		КОГДА ДанныеДокумента.СтатьяРасходовУУ = ЗНАЧЕНИЕ(ПланВидовХарактеристик.СтатьиРасходов.ПустаяСсылка)
	|				И ДанныеДокумента.ОтражатьВУпрУчете
	|				И ДанныеДокумента.ОтражатьВРеглУчете
	|
	|			ТОГДА ДанныеДокумента.СтатьяРасходовБУ
	
	|
	|		ИНАЧЕ ДанныеДокумента.СтатьяРасходовУУ 
	|	КОНЕЦ";

	ПолеАналитикаРасходовУУ =
	"ВЫБОР 
	|		КОГДА ДанныеДокумента.СтатьяРасходовУУ = ЗНАЧЕНИЕ(ПланВидовХарактеристик.СтатьиРасходов.ПустаяСсылка)
	|				И ДанныеДокумента.ОтражатьВУпрУчете
	|				И ДанныеДокумента.ОтражатьВРеглУчете
	|
	|			ТОГДА ДанныеДокумента.АналитикаРасходовБУ
	|
	|
	|		ИНАЧЕ ДанныеДокумента.АналитикаРасходовУУ 
	|	КОНЕЦ";

	ПолеВариантРаспределенияРасходовУпр =
	"ВЫБОР КОГДА ДанныеДокумента.СтатьяРасходовУУ = ЗНАЧЕНИЕ(ПланВидовХарактеристик.СтатьиРасходов.ПустаяСсылка)
	|			И ДанныеДокумента.ОтражатьВУпрУчете
	|		ТОГДА ДанныеДокумента.СтатьяРасходовБУ.ВариантРаспределенияРасходовУпр
	|		ИНАЧЕ ДанныеДокумента.СтатьяРасходовУУ.ВариантРаспределенияРасходовУпр 
	|	КОНЕЦ";

	//-- Локализация
	
	ПолеСтатьяРасходовУУ = СтрЗаменить(ПолеСтатьяРасходовУУ, "ДанныеДокумента", ИмяТаблицы);
	ПолеАналитикаРасходовУУ = СтрЗаменить(ПолеАналитикаРасходовУУ, "ДанныеДокумента", ИмяТаблицы);
	ПолеВариантРаспределенияРасходовУпр = СтрЗаменить(ПолеВариантРаспределенияРасходовУпр, "ДанныеДокумента", ИмяТаблицы);

	ТекстЗапроса = СтрЗаменить(ТекстЗапроса, "&ПринятиеКУчетуОС_РеквизитыДокумента", ПоляЛокализации);
	ТекстЗапроса = СтрЗаменить(ТекстЗапроса, "&ПринятиеКУчетуОС_СтатьяРасходовУУ", ПолеСтатьяРасходовУУ);
	ТекстЗапроса = СтрЗаменить(ТекстЗапроса, "&ПринятиеКУчетуОС_АналитикаРасходовУУ", ПолеАналитикаРасходовУУ);
	ТекстЗапроса = СтрЗаменить(ТекстЗапроса, "&ПринятиеКУчетуОС_ВариантРаспределенияРасходовУпр", ПолеВариантРаспределенияРасходовУпр);
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныйПрограммныйИнтерфейс

#Область ОбработчикиСобытий

// Вызывается из соответствующего обработчика документа
//
// Параметры:
//  Объект - ДокументОбъект - Обрабатываемый документ.
//  Отказ - Булево - Признак проведения документа.
//                   Если в теле процедуры-обработчика установить данному параметру значение Истина,
//                   то проведение документа выполнено не будет.
//  РежимПроведения - РежимПроведенияДокумента - В данный параметр передается текущий режим проведения.
//
Процедура ОбработкаПроведения(Объект, Отказ, РежимПроведения) Экспорт
	
КонецПроцедуры

// Вызывается из соответствующего обработчика документа
//
// Параметры:
//  Объект - ДокументОбъект - Обрабатываемый объект
//  Отказ - Булево - Если в теле процедуры-обработчика установить данному параметру значение Истина,
//                   то будет выполнен отказ от продолжения работы после выполнения проверки заполнения.
//  ПроверяемыеРеквизиты - Массив - Массив путей к реквизитам, для которых будет выполнена проверка заполнения.
//
Процедура ОбработкаПроверкиЗаполнения(Объект, Отказ, ПроверяемыеРеквизиты) Экспорт
	
	
КонецПроцедуры

// Вызывается из соответствующего обработчика документа
//
// Параметры:
//  Объект - ДокументОбъект - Обрабатываемый объект.
//  ДанныеЗаполнения - Произвольный - Значение, которое используется как основание для заполнения.
//  СтандартнаяОбработка - Булево - В данный параметр передается признак выполнения стандартной (системной) обработки события.
//
Процедура ОбработкаЗаполнения(Объект, ДанныеЗаполнения, ТекстЗаполнения, СтандартнаяОбработка) Экспорт
	
	//++ Локализация
	//-- Локализация
	
КонецПроцедуры

// Вызывается из соответствующего обработчика документа
//
// Параметры:
//  Объект - ДокументОбъект - Обрабатываемый объект
//  Отказ - Булево - Признак отказа от записи.
//                   Если в теле процедуры-обработчика установить данному параметру значение Истина,
//                   то запись выполнена не будет и будет вызвано исключение.
//
Процедура ОбработкаУдаленияПроведения(Объект, Отказ) Экспорт
	
	
КонецПроцедуры

// Вызывается из соответствующего обработчика документа
//
// Параметры:
//  Объект - ДокументОбъект - Обрабатываемый объект
//  Отказ - Булево - Признак отказа от записи.
//                   Если в теле процедуры-обработчика установить данному параметру значение Истина,
//                   то запись выполнена не будет и будет вызвано исключение.
//  РежимЗаписи - РежимЗаписиДокумента - В параметр передается текущий режим записи документа. Позволяет определить в теле процедуры режим записи.
//  РежимПроведения - РежимПроведенияДокумента - В данный параметр передается текущий режим проведения.
//
Процедура ПередЗаписью(Объект, Отказ, РежимЗаписи, РежимПроведения) Экспорт
	
	//++ Локализация
	//-- Локализация	
	
КонецПроцедуры

// Вызывается из соответствующего обработчика документа
//
// Параметры:
//  Объект - ДокументОбъект - Обрабатываемый объект
//  Отказ - Булево - Признак отказа от записи.
//                   Если в теле процедуры-обработчика установить данному параметру значение Истина, то запись выполнена не будет и будет вызвано исключение.
//
Процедура ПриЗаписи(Объект, Отказ) Экспорт
	
	//++ Локализация
	//-- Локализация
	
КонецПроцедуры

// Вызывается из соответствующего обработчика документа
//
// Параметры:
//  Объект - ДокументОбъект - Обрабатываемый объект
//  ОбъектКопирования - ДокументОбъект.<Имя документа> - Исходный документ, который является источником копирования.
//
Процедура ПриКопировании(Объект, ОбъектКопирования) Экспорт
	
	
КонецПроцедуры

#КонецОбласти

#Область ПодключаемыеКоманды

// Определяет список команд создания на основании.
//
// Параметры:
//  КомандыСозданияНаОсновании - см. СозданиеНаОснованииПереопределяемый.ПередДобавлениемКомандСозданияНаОсновании.КомандыСозданияНаОсновании
//  Параметры - см. СозданиеНаОснованииПереопределяемый.ПередДобавлениемКомандСозданияНаОсновании.Параметры
//
Процедура ДобавитьКомандыСозданияНаОсновании(КомандыСозданияНаОсновании, Параметры) Экспорт
	
	
КонецПроцедуры

// Добавляет команду создания документа "Авансовый отчет".
//
// Параметры:
//  КомандыСозданияНаОсновании - см. СозданиеНаОснованииПереопределяемый.ПередДобавлениемКомандСозданияНаОсновании.КомандыСозданияНаОсновании
//
Процедура ДобавитьКомандуСоздатьНаОсновании(КомандыСозданияНаОсновании) Экспорт


КонецПроцедуры

// Определяет список команд отчетов.
//
// Параметры:
//   КомандыОтчетов - См. ВариантыОтчетовПереопределяемый.ПередДобавлениемКомандОтчетов.КомандыОтчетов
//   Параметры - См. ВариантыОтчетовПереопределяемый.ПередДобавлениемКомандОтчетов.Параметры
//
Процедура ДобавитьКомандыОтчетов(КомандыОтчетов, Параметры) Экспорт
	
	
КонецПроцедуры

// Добавляет команды печати.
// 
// Параметры:
// 	КомандыПечати - см. УправлениеПечатью.СоздатьКоллекциюКомандПечати
Процедура ДобавитьКомандыПечати(КомандыПечати) Экспорт
	
	//++ Локализация
	//-- Локализация
	
КонецПроцедуры

#КонецОбласти

#Область Печать

// Формирует печатные формы.
//
// Параметры:
//  МассивОбъектов  - Массив    - ссылки на объекты, которые нужно распечатать;
//  ПараметрыПечати - Структура - дополнительные настройки печати;
//  КоллекцияПечатныхФорм - ТаблицаЗначений - сформированные табличные документы (выходной параметр)
//  ОбъектыПечати         - СписокЗначений  - значение - ссылка на объект;
//                                            представление - имя области в которой был выведен объект (выходной параметр);
//  ПараметрыВывода       - Структура       - дополнительные параметры сформированных табличных документов (выходной параметр).
//
Процедура Печать(МассивОбъектов, ПараметрыПечати, КоллекцияПечатныхФорм, ОбъектыПечати, ПараметрыВывода) Экспорт
	
	
КонецПроцедуры

Функция ПолучитьДанныеДляПечатнойФормыОС1(ПараметрыПечати, МассивОбъектов) Экспорт
	
	ДанныеДляПечатнойФормы = Неопределено;
	
	//++ Локализация
	//-- Локализация
	
	Возврат ДанныеДляПечатнойФормы;
	
КонецФункции

#КонецОбласти

//++ НЕ УТ
#Область ПроводкиРегУчета

// Функция возвращает текст запроса для отражения документа в регламентированном учете.
//
// Возвращаемое значение:
//	Строка - Текст запроса
//
Функция ТекстОтраженияВРеглУчете() Экспорт
	
	//++ Локализация
	Возврат ТекстОтраженияВРеглУчетеУКР();
	//-- Локализация
	Возврат "";
	
КонецФункции

// Функция возвращает текст запроса дополнительных временных таблиц,
// необходимых для отражения в регламентированном учете
//
// Возвращаемое значение:
//   Строка - сформированный текст запроса.
//
Функция ТекстЗапросаВТОтраженияВРеглУчете() Экспорт
	
	//++ Локализация
	Возврат ТекстЗапросаВТОтраженияВРеглУчетеУКР();
	//-- Локализация
	Возврат "";
	
	
КонецФункции

#КонецОбласти
//-- НЕ УТ

//++ НЕ УТ
#Область ПроводкиРегУчетаУКР

// Функция возвращает текст запроса для отражения документа в регламентированном учете.
//
// Возвращаемое значение:
//	Строка - Текст запроса
//
Функция ТекстОтраженияВРеглУчетеУКР()
	
    
	ЯзыкСодержания = МультиязычностьУкр.КодЯзыкаИнформационнойБазы();
	
	ТекстЗапроса = "";
	
	//++ Локализация

	СписокЗапросов = Новый Массив;
	
	
	#Область ПринятиеКУчетуОС_Дт_СчетУчета__Кт_151_или_152

	ТекстЗапроса =
	"////////////////////////////////////////////////////////////////////////////////////////////////////
	|// Принятие к учету ОС (Дт СчетУчета:: Кт 151, 152)
	|//
	|ВЫБРАТЬ
	|	
	|	Строки.Регистратор КАК Ссылка,
	|	Строки.Период КАК Период,
	|	Строки.Организация КАК Организация,
	|	НЕОПРЕДЕЛЕНО КАК ИдентификаторСтроки,
	|	
	|	Строки.СтоимостьРегл КАК Сумма,
	|	Строки.Стоимость КАК СуммаУУ,
	|	
	|	// Дт ///////////////////////////////////////////////////////////////////////////////////////////
	|	
	|	ЗНАЧЕНИЕ(Перечисление.ВидыСчетовРеглУчета.СтоимостьВНА) КАК ВидСчетаДт,
	|	Строки.ГруппаФинансовогоУчета КАК АналитикаУчетаДт,
	|	НЕОПРЕДЕЛЕНО КАК МестоУчетаДт,
	|	
	|	ЗНАЧЕНИЕ(Справочник.Валюты.ПустаяСсылка) КАК ВалютаДт,
	|	Строки.Подразделение КАК ПодразделениеДт,
	|	Строки.НаправлениеДеятельности КАК НаправлениеДеятельностиДт,
	|	Операция.НалоговоеНазначение КАК НалоговоеНазначениеДт,
	|	
	|	ЗНАЧЕНИЕ(ПланСчетов.Хозрасчетный.ПустаяСсылка) КАК СчетДт,
	|	
	|	Строки.ОсновноеСредство КАК СубконтоДт1,
	|	НЕОПРЕДЕЛЕНО КАК СубконтоДт2,
	|	НЕОПРЕДЕЛЕНО КАК СубконтоДт3,
	|	
	|	0 КАК ВалютнаяСуммаДт,
	|	0 КАК КоличествоДт,
	|	Строки.СтоимостьНУ КАК СуммаНУДт,
	|	0 КАК СуммаПРДт,
	|	0 КАК СуммаВРДт,
	|	
	|	// Кт ///////////////////////////////////////////////////////////////////////////////////////////
	|	
	|	ЗНАЧЕНИЕ(Перечисление.ВидыСчетовРеглУчета.Расходы) КАК ВидСчетаКт,
	|	Строки.КорСтатьяРасходов КАК АналитикаУчетаКт,
	|	Строки.КорПодразделение КАК МестоУчетаКт,
	|	
	|	НЕОПРЕДЕЛЕНО КАК ВалютаКт,
	|	Строки.КорПодразделение КАК ПодразделениеКт,
	|	Строки.КорНаправлениеДеятельности КАК НаправлениеДеятельностиКт,
	|   ЗНАЧЕНИЕ(Справочник.НалоговыеНазначенияАктивовИЗатрат.ПустаяСсылка) КАК НалоговоеНазначениеКт,
	|	
	|	ЗНАЧЕНИЕ(ПланСчетов.Хозрасчетный.ПустаяСсылка) КАК СчетКт,
	|	
	|	Строки.КорАналитикаРасходов КАК СубконтоКт1,
	|	НЕОПРЕДЕЛЕНО КАК СубконтоКт2,
	|	НЕОПРЕДЕЛЕНО КАК СубконтоКт3,
	|	
	|	0 КАК ВалютнаяСуммаКт,
	|	0 КАК КоличествоКт,
	|	Строки.СтоимостьРегл КАК СуммаНУКт,
	|	0 КАК СуммаПРКт,
	|	0 КАК СуммаВРКт,
	|	""%1"" КАК Содержание
	|ИЗ
	|	ДокументыКОтражению КАК ДокументыКОтражению
	|	
	|	ВНУТРЕННЕЕ СОЕДИНЕНИЕ Документ.ПринятиеКУчетуОС2_4 КАК Операция
	|	ПО Операция.Ссылка = ДокументыКОтражению.Ссылка
	|
	|	ВНУТРЕННЕЕ СОЕДИНЕНИЕ РегистрНакопления.СтоимостьОС КАК Строки
	|	ПО Строки.Регистратор = ДокументыКОтражению.Ссылка
	|	
	|	ЛЕВОЕ СОЕДИНЕНИЕ ПланВидовХарактеристик.СтатьиРасходов КАК СтатьиСтроительства
	|	ПО Строки.КорСтатьяРасходов = СтатьиСтроительства.Ссылка
	|		И СтатьиСтроительства.ВариантРаспределенияРасходовРегл = ЗНАЧЕНИЕ(Перечисление.ВариантыРаспределенияРасходов.НаВнеоборотныеАктивы)
	|
	|	ЛЕВОЕ СОЕДИНЕНИЕ Справочник.ОбъектыСтроительства КАК ОбъектыСтроительства
	|	ПО ОбъектыСтроительства.Ссылка = Строки.КорАналитикаРасходов
	|
	|ГДЕ
	|	Строки.ХозяйственнаяОперация = ЗНАЧЕНИЕ(Перечисление.ХозяйственныеОперации.ПринятиеКУчетуОС)
	|
	|
	|	И Строки.РасчетСтоимости
	|	И (Строки.Стоимость <> 0
	|		ИЛИ Строки.СтоимостьРегл <> 0
	|		ИЛИ Строки.СтоимостьНУ <> 0)";
	

	ТекстЗапроса = СтрШаблон(ТекстЗапроса, 
		НСтр("ru='Принятие к учету ОС';uk='Прийняття до обліку ОЗ'",ЯзыкСодержания));
	СписокЗапросов.Добавить(ТекстЗапроса);

#КонецОбласти

	

	#Область ПринятиеКУчетуОСЦелевыеСредства_Дт_СчетУчета__Кт_08_04_2_или_08_03

	ТекстЗапроса =
	"////////////////////////////////////////////////////////////////////////////////////////////////////
	|// Принятие к учету ОС (Дт СчетУчета:: Кт 08.04.2, 08.03)
	|//
	|ВЫБРАТЬ
	|	
	|	Строки.Регистратор КАК Ссылка,
	|	Строки.Период КАК Период,
	|	Строки.Организация КАК Организация,
	|	НЕОПРЕДЕЛЕНО КАК ИдентификаторСтроки,
	|	
	|	Строки.СтоимостьЦФ КАК Сумма,
	|	0 КАК СуммаУУ,
	|	
	|	// Дт ///////////////////////////////////////////////////////////////////////////////////////////
	|	
	|	ЗНАЧЕНИЕ(Перечисление.ВидыСчетовРеглУчета.СтоимостьВНА_ЦФ) КАК ВидСчетаДт,
	|	Строки.ГруппаФинансовогоУчета КАК АналитикаУчетаДт,
	|	НЕОПРЕДЕЛЕНО КАК МестоУчетаДт,
	|	
	|	ЗНАЧЕНИЕ(Справочник.Валюты.ПустаяСсылка) КАК ВалютаДт,
	|	Строки.Подразделение КАК ПодразделениеДт,
	|	Строки.НаправлениеДеятельности КАК НаправлениеДеятельностиДт,
	|	ЗНАЧЕНИЕ(Справочник.НалоговыеНазначенияАктивовИЗатрат.ПустаяСсылка) КАК НалоговоеНазначениеДт,
	|	
	|	ЗНАЧЕНИЕ(ПланСчетов.Хозрасчетный.ПустаяСсылка) КАК СчетДт,
	|	
	|	Строки.ОсновноеСредство КАК СубконтоДт1,
	|	НЕОПРЕДЕЛЕНО КАК СубконтоДт2,
	|	НЕОПРЕДЕЛЕНО КАК СубконтоДт3,
	|	
	|	0 КАК ВалютнаяСуммаДт,
	|	0 КАК КоличествоДт,
	|	0 КАК СуммаНУДт,
	|	0 КАК СуммаПРДт,
	|	0 КАК СуммаВРДт,
	|	
	|	// Кт ///////////////////////////////////////////////////////////////////////////////////////////
	|	
	|	ЗНАЧЕНИЕ(Перечисление.ВидыСчетовРеглУчета.Расходы) КАК ВидСчетаКт,
	|	Строки.КорСтатьяРасходов КАК АналитикаУчетаКт,
	|	Строки.КорПодразделение КАК МестоУчетаКт,
	|	
	|	НЕОПРЕДЕЛЕНО КАК ВалютаКт,
	|	Строки.КорПодразделение КАК ПодразделениеКт,
	|	Строки.КорНаправлениеДеятельности КАК НаправлениеДеятельностиКт,
	|   ЗНАЧЕНИЕ(Справочник.НалоговыеНазначенияАктивовИЗатрат.ПустаяСсылка) КАК НалоговоеНазначениеКт,
	|	
	|	ЗНАЧЕНИЕ(ПланСчетов.Хозрасчетный.ПустаяСсылка) КАК СчетКт,
	|	
	|	Строки.КорАналитикаРасходов КАК СубконтоКт1,
	//|	ВЫБОР КОГДА СтатьиСтроительства.Ссылка ЕСТЬ НЕ NULL ТОГДА
	//|			ВЫБОР КОГДА ОбъектыСтроительства.СпособСтроительства <> ЗНАЧЕНИЕ(Перечисление.СпособыСтроительства.ПустаяСсылка) 
	//|					ТОГДА ОбъектыСтроительства.СпособСтроительства
	//|				ИНАЧЕ 
	//|					ЗНАЧЕНИЕ(Перечисление.СпособыСтроительства.Подрядный) 
	//|			КОНЕЦ
	//|	ИНАЧЕ
	//|		ЗНАЧЕНИЕ(Перечисление.ТипыЗатратРегл.Прочее)
	//|	КОНЕЦ КАК СубконтоКт2,
	|	ЗНАЧЕНИЕ(Перечисление.ТипыЗатратРегл.Прочее)  КАК СубконтоКт2,
	|	НЕОПРЕДЕЛЕНО КАК СубконтоКт3,
	|	
	|	0 КАК ВалютнаяСуммаКт,
	|	0 КАК КоличествоКт,
	|	Строки.СтоимостьЦФ КАК СуммаНУКт,
	|	0 КАК СуммаПРКт,
	|	0 КАК СуммаВРКт,
	|	""%1"" КАК Содержание
	|ИЗ
	|	ДокументыКОтражению КАК ДокументыКОтражению
	|	
	|	ВНУТРЕННЕЕ СОЕДИНЕНИЕ РегистрНакопления.СтоимостьОС КАК Строки
	|	ПО Строки.Регистратор = ДокументыКОтражению.Ссылка
	|
	|	ЛЕВОЕ СОЕДИНЕНИЕ ПланВидовХарактеристик.СтатьиРасходов КАК СтатьиСтроительства
	|	ПО Строки.КорСтатьяРасходов = СтатьиСтроительства.Ссылка
	|		И СтатьиСтроительства.ВариантРаспределенияРасходовРегл = ЗНАЧЕНИЕ(Перечисление.ВариантыРаспределенияРасходов.НаВнеоборотныеАктивы)
	|
	|	ЛЕВОЕ СОЕДИНЕНИЕ Справочник.ОбъектыСтроительства КАК ОбъектыСтроительства
	|	ПО ОбъектыСтроительства.Ссылка = Строки.КорАналитикаРасходов
	|
	|ГДЕ
	|	Строки.КорСтатьяРасходов <> ЗНАЧЕНИЕ(ПланВидовХарактеристик.СтатьиРасходов.ПустаяСсылка)
	|	И (Строки.СтоимостьЦФ <> 0
	|		ИЛИ Строки.СтоимостьНУЦФ <> 0)";

	ТекстЗапроса = СтрШаблон(ТекстЗапроса, 
		НСтр("ru='Принятие к учету ОС';uk='Прийняття до обліку ОЗ'",ЯзыкСодержания));
	СписокЗапросов.Добавить(ТекстЗапроса);

	#КонецОбласти

	
	#Область ПринятиеКУчетуПоРезультатамИнвентаризации_Дт_СчетУчета__Кт_СчетДоходов

	ТекстЗапроса =
	"////////////////////////////////////////////////////////////////////////////////////////////////////
	|// Принятие к учету по результатам инвентаризации ОС (Дт СчетУчета:: Кт СчетДоходов)
	|//
	|ВЫБРАТЬ
	|
	|	Операция.Ссылка КАК Ссылка,
	|	Операция.Дата КАК Период,
	|	Операция.Организация КАК Организация,
	|	НЕОПРЕДЕЛЕНО КАК ИдентификаторСтроки,
	|	
	|	Строки.СтоимостьБУ КАК Сумма,
	|	Строки.СтоимостьУУ КАК СуммаУУ,
	|	
	|	// Дт ///////////////////////////////////////////////////////////////////////////////////////////
	|	
	|	ЗНАЧЕНИЕ(Перечисление.ВидыСчетовРеглУчета.СтоимостьВНА) КАК ВидСчетаДт,
	|	Операция.ГруппаФинансовогоУчета КАК АналитикаУчетаДт,
	|	НЕОПРЕДЕЛЕНО КАК МестоУчетаДт,
	|	
	|	ЗНАЧЕНИЕ(Справочник.Валюты.ПустаяСсылка) КАК ВалютаДт,
	|	Операция.Местонахождение КАК ПодразделениеДт,
	|	Операция.НаправлениеДеятельности КАК НаправлениеДеятельностиДт,
	|	Операция.НалоговоеНазначение КАК НалоговоеНазначениеДт,
	|
	|	ЗНАЧЕНИЕ(ПланСчетов.Хозрасчетный.ПустаяСсылка) КАК СчетДт,
	|	
	|	Строки.ОсновноеСредство КАК СубконтоДт1,
	|	НЕОПРЕДЕЛЕНО КАК СубконтоДт2,
	|	НЕОПРЕДЕЛЕНО КАК СубконтоДт3,
	|	
	|	0 КАК ВалютнаяСуммаДт,
	|	0 КАК КоличествоДт,
	|	Строки.СтоимостьНУ КАК СуммаНУДт,
	|	0 КАК СуммаПРДт,
	|	0 КАК СуммаВРДт,
	|	
	|	// Кт ///////////////////////////////////////////////////////////////////////////////////////////
	|	
	|	ЗНАЧЕНИЕ(Перечисление.ВидыСчетовРеглУчета.Доходы) КАК ВидСчетаКт,
	|	Операция.СтатьяДоходов КАК АналитикаУчетаКт,
	|	Операция.Местонахождение КАК МестоУчетаКт,
	|	
	|	НЕОПРЕДЕЛЕНО КАК ВалютаКт,
	|	Операция.Местонахождение КАК ПодразделениеКт,
	|	НЕОПРЕДЕЛЕНО КАК НаправлениеДеятельностиКт,
	|   ЗНАЧЕНИЕ(Справочник.НалоговыеНазначенияАктивовИЗатрат.ПустаяСсылка) КАК НалоговоеНазначениеКт,
	|	
	|	ЗНАЧЕНИЕ(ПланСчетов.Хозрасчетный.ПустаяСсылка) КАК СчетКт,
	|	
	|	Операция.СтатьяДоходов КАК СубконтоКт1,
	|	Операция.АналитикаДоходов КАК СубконтоКт2,
	|	НЕОПРЕДЕЛЕНО КАК СубконтоКт3,
	|	
	|	0 КАК ВалютнаяСуммаКт,
	|	0 КАК КоличествоКт,
	|	Строки.СтоимостьНУ КАК СуммаНУКт,
	|	0 КАК СуммаПРКт,
	|	0 КАК СуммаВРКт,
	|	""%1"" КАК Содержание
	|ИЗ
	|	ДокументыКОтражению КАК ДокументыКОтражению
	|
	|	ВНУТРЕННЕЕ СОЕДИНЕНИЕ Документ.ПринятиеКУчетуОС2_4 КАК Операция
	|	ПО Операция.Ссылка = ДокументыКОтражению.Ссылка
	|
	|	ВНУТРЕННЕЕ СОЕДИНЕНИЕ Документ.ПринятиеКУчетуОС2_4.ОС КАК Строки
	|	ПО Строки.Ссылка = ДокументыКОтражению.Ссылка
	|
	|ГДЕ
	|	Операция.ХозяйственнаяОперация = ЗНАЧЕНИЕ(Перечисление.ХозяйственныеОперации.ПринятиеКУчетуОСПоИнвентаризации)";

	ТекстЗапроса = СтрШаблон(ТекстЗапроса, 
		НСтр("ru='Принятие к учету по результатам инвентаризации';uk='Прийняття до обліку за результатами інвентаризації'",ЯзыкСодержания));
	СписокЗапросов.Добавить(ТекстЗапроса);

	#КонецОбласти
	
	ТекстЗапроса = СтрСоединить(СписокЗапросов, ОбщегоНазначенияУТ.РазделительЗапросовВОбъединении());
		
	//-- Локализация
	Возврат ТекстЗапроса;
	
КонецФункции

// Функция возвращает текст запроса дополнительных временных таблиц,
// необходимых для отражения в регламентированном учете
//
// Возвращаемое значение:
//   Строка - сформированный текст запроса.
//
Функция ТекстЗапросаВТОтраженияВРеглУчетеУКР()
	
	Возврат "";
	
КонецФункции

#КонецОбласти
//-- НЕ УТ

#Область Проведение

Функция АдаптированныйТекстЗапросаДвиженийПоРегистру(ИмяРегистра, ПереопределениеРасчетаПараметров, СинонимТаблицыДокумента) Экспорт

	ТекстЗапроса = Неопределено;
	ТекстыЗапроса = Новый СписокЗначений;
	
	//++ Локализация
	//-- Локализация
	
	Возврат ТекстЗапроса;

КонецФункции

Процедура ЗаполнитьПараметрыИнициализации(Запрос, Реквизиты) Экспорт

	//++ Локализация
	ПараметрыУчетнойПолитики = НастройкиНалоговУчетныхПолитикПовтИсп.ДействующиеПараметрыНалоговУчетныхПолитик(
		"НастройкиУчетаНалогаНаПрибыль",
		Реквизиты.Организация,
		Реквизиты.Период);
	
	//-- Локализация
	
КонецПроцедуры
 
// Процедура дополняет тексты запросов проведения документа.
//
// Параметры:
//  Запрос - Запрос - Общий запрос проведения документа.
//  ТекстыЗапроса - СписокЗначений - Список текстов запроса проведения.
//  Регистры - Строка, Структура - Список регистров проведения документа через запятую или в ключах структуры.
//
Процедура ДополнитьТекстыЗапросовПроведения(Запрос, ТекстыЗапроса, Регистры) Экспорт
	
	//++ Локализация

	ТекстЗапросаТаблицаПорядокУчетаОСБУ(ТекстыЗапроса, Регистры);
	ТекстЗапросаТаблицаПараметрыАмортизацииОСБУ(Запрос, ТекстыЗапроса, Регистры);
	ТекстЗапросаТаблицаСобытияОСОрганизаций(ТекстыЗапроса, Регистры);
	
	ТекстЗапросаТаблицаОтражениеДокументовВРеглУчете(ТекстыЗапроса, Регистры);

	//-- Локализация
	
КонецПроцедуры

Процедура ДополнитьТекстЗапросаТаблицаДвиженияДоходыРасходыПрочиеАктивыПассивы(СписокЗапросовОбъединение) Экспорт

	//++ Локализация

	ТекстЗапроса =
	"ВЫБРАТЬ
	|	&Период                                      КАК Период,
	|	&ХозяйственнаяОперация                       КАК ХозяйственнаяОперация,
	|	&Организация                                 КАК Организация,
	|
	|	&Местонахождение                             КАК Подразделение,
	|	&НаправлениеДеятельности                     КАК НаправлениеДеятельности,
	|	&СтатьяДоходов                               КАК Статья,
	|	&АналитикаДоходов                            КАК АналитикаДоходов,
	|	НЕОПРЕДЕЛЕНО                                 КАК АналитикаРасходов,
	|	НЕОПРЕДЕЛЕНО                                 КАК АналитикаАктивовПассивов,
	|	НЕОПРЕДЕЛЕНО                                 КАК ГруппаФинансовогоУчета,
	|
	|	&Местонахождение                             КАК КорПодразделение,
	|	&НаправлениеДеятельности                     КАК КорНаправлениеДеятельности,
	|	&СтатьяАП_ОС                                 КАК КорСтатья,
	|	НЕОПРЕДЕЛЕНО                                 КАК КорАналитикаДоходов,
	|	НЕОПРЕДЕЛЕНО                                 КАК КорАналитикаРасходов,
	|	ТаблицаОС.ОсновноеСредство                   КАК КорАналитикаАктивовПассивов,
	|	&ГруппаФинансовогоУчета                      КАК КорГруппаФинансовогоУчета,
	|
	|	&Организация                                 КАК КорОрганизация,
	|
	|	ТаблицаОС.СтоимостьУУ                        КАК Сумма,
	|	ТаблицаОС.СтоимостьБУ                        КАК СуммаРегл,
	|	ТаблицаОС.СтоимостьУУ                        КАК СуммаУпр
	|ИЗ
	|	Документ.ПринятиеКУчетуОС2_4.ОС КАК ТаблицаОС
	|ГДЕ
	|	ТаблицаОС.Ссылка = &Ссылка
	|	И &ХозяйственнаяОперация = ЗНАЧЕНИЕ(Перечисление.ХозяйственныеОперации.ПринятиеКУчетуОСпоИнвентаризации)";

	СписокЗапросовОбъединение.Добавить(ТекстЗапроса);

	//-- Локализация
	
КонецПроцедуры

Процедура ПроверитьРеквизитыШапки(Объект, Отказ) Экспорт

	//++ Локализация
	//-- Локализация
	
КонецПроцедуры

Функция ТекстЗапросаТаблицаПервоначальныеСведенияОС(Запрос, ТекстыЗапроса) Экспорт

	ТекстЗапроса = Неопределено;
	
	//++ Локализация
	//-- Локализация
	
	Возврат ТекстЗапроса;
	
КонецФункции

Функция ТекстЗапросаТаблицаСтоимостьОС(ТекстыЗапроса) Экспорт

	ТекстЗапроса = Неопределено;
	
	//++ Локализация
	//-- Локализация
	
	Возврат ТекстЗапроса;

КонецФункции

Функция ТекстЗапросаТаблицаАмортизацияОС(Запрос, ТекстыЗапроса) Экспорт

	ТекстЗапроса = Неопределено;
	
	//++ Локализация
	//-- Локализация

	Возврат ТекстЗапроса;
	
КонецФункции

Функция ТекстЗапросаТаблицаВтИсходныеПрочиеРасходы(Запрос, ТекстыЗапроса) Экспорт

	ТекстЗапроса = Неопределено;
	
	//++ Локализация
	//-- Локализация
	
	Возврат ТекстЗапроса;
	
КонецФункции

Функция ТекстЗапросаТаблицаВтРасчетСтоимостиСгруппированная(Запрос, ТекстыЗапроса) Экспорт

	ТекстЗапроса = Неопределено;
	
	//++ Локализация

	ИмяТаблицы = "ВтРасчетСтоимостиСгруппированная";

	Если ПроведениеДокументов.ЕстьТаблицаЗапроса(ИмяТаблицы, ТекстыЗапроса) Тогда
		Возврат "";
	КонецЕсли;

	ВнеоборотныеАктивыСлужебный.ТекстЗапросаПустаяТаблицаСтоимости(ТекстыЗапроса, Запрос);

	ТекстЗапроса = 
	"ВЫБРАТЬ
	|	РасчетСтоимости.ОбъектУчета               КАК ОбъектУчета,
	|	СУММА(РасчетСтоимости.Стоимость)          КАК Стоимость,
	|	СУММА(РасчетСтоимости.СтоимостьРегл)      КАК СтоимостьРегл,
	|	СУММА(РасчетСтоимости.СтоимостьНУ)        КАК СтоимостьНУ,
	|	СУММА(РасчетСтоимости.СтоимостьПР)        КАК СтоимостьПР,
	|	СУММА(РасчетСтоимости.СтоимостьВР)        КАК СтоимостьВР,
	|	СУММА(РасчетСтоимости.СтоимостьЦФ)        КАК СтоимостьЦФ,
	|	СУММА(РасчетСтоимости.СтоимостьНУЦФ)      КАК СтоимостьНУЦФ,
	|	СУММА(РасчетСтоимости.СтоимостьПРЦФ)      КАК СтоимостьПРЦФ,
	|	СУММА(РасчетСтоимости.СтоимостьВРЦФ)      КАК СтоимостьВРЦФ,
	|	СУММА(РасчетСтоимости.НДС)                КАК НДС,
	|	СУММА(РасчетСтоимости.НДСРегл)            КАК НДСРегл
	|ПОМЕСТИТЬ ВтРасчетСтоимостиСгруппированная 
	|ИЗ
	|	(ВЫБРАТЬ
	|		РасчетСтоимости.ОбъектУчета        КАК ОбъектУчета,
	|		РасчетСтоимости.Стоимость          КАК Стоимость,
	|		РасчетСтоимости.СтоимостьРегл      КАК СтоимостьРегл,
	|		РасчетСтоимости.СтоимостьНУ        КАК СтоимостьНУ,
	|		РасчетСтоимости.СтоимостьПР        КАК СтоимостьПР,
	|		РасчетСтоимости.СтоимостьВР        КАК СтоимостьВР,
	|		РасчетСтоимости.СтоимостьЦФ        КАК СтоимостьЦФ,
	|		РасчетСтоимости.СтоимостьНУЦФ      КАК СтоимостьНУЦФ,
	|		РасчетСтоимости.СтоимостьПРЦФ      КАК СтоимостьПРЦФ,
	|		РасчетСтоимости.СтоимостьВРЦФ      КАК СтоимостьВРЦФ,
	|		0                                  КАК НДС,
	|		0                                  КАК НДСРегл
	|	ИЗ
	|		ВтРасчетСтоимости КАК РасчетСтоимости
	|
	|
	|	) КАК РасчетСтоимости
	|
	|СГРУППИРОВАТЬ ПО
	|	РасчетСтоимости.ОбъектУчета";

	ТекстыЗапроса.Добавить(ТекстЗапроса, ИмяТаблицы);

	//-- Локализация
	
	Возврат ТекстЗапроса;
	
КонецФункции

Функция ТекстЗапросаТаблицаПорядокУчетаОСУУ() Экспорт

	ТекстЗапроса = Неопределено;
	
	//++ Локализация
	//-- Локализация
	
	Возврат ТекстЗапроса;

КонецФункции

#КонецОбласти

#Область ФормаДокумента
 
Процедура ПриЧтенииСозданииНаСервере(Форма) Экспорт

	//++ Локализация
	//-- Локализация
	
КонецПроцедуры

Процедура ПослеЗаписиНаСервере(Форма, ТекущийОбъект, ПараметрыЗаписи) Экспорт

	//++ Локализация
	//-- Локализация
	
КонецПроцедуры

Процедура ПриИзмененииРеквизита(ИмяЭлемента, Форма, ДополнительныеПараметры) Экспорт

	//++ Локализация
	//-- Локализация
	
КонецПроцедуры

Процедура ПриВыполненииКоманды(ИмяКоманды, Форма) Экспорт
	
	//++ Локализация
	//-- Локализация
	
КонецПроцедуры

Процедура ОСОсновноеСредствоПриИзменении(Форма, ИзмененныеРеквизиты) Экспорт

	//++ Локализация
	//-- Локализация
	
КонецПроцедуры

Процедура ОССтоимостьБУПриИзменении(Форма, ТекущиеДанные) Экспорт

	//++ Локализация
	Если ТекущиеДанные.СтоимостьНУ = Форма.ЗначенияРеквизитовОСДоИзменения.СтоимостьБУ И Форма.РасширеннаяСтоимостьРегл Тогда
		ТекущиеДанные.СтоимостьНУ = ТекущиеДанные.СтоимостьБУ;
	КонецЕсли;
	//-- Локализация
	
КонецПроцедуры

Процедура ОбработкаВыбораЭлемента(Форма, ИзмененныеРеквизиты) Экспорт

	//++ Локализация
	//-- Локализация

КонецПроцедуры

Процедура НастроитьЗависимыеЭлементыФормы(Форма, СтруктураИзмененныхРеквизитов) Экспорт

	//++ Локализация

	ОбновитьВсе = СтруктураИзмененныхРеквизитов.Количество() = 0;

	Объект = Форма.Объект;

	Если СтруктураИзмененныхРеквизитов.Свойство("Дата")
		ИЛИ СтруктураИзмененныхРеквизитов.Свойство("Организация")
		ИЛИ ОбновитьВсе Тогда
		
		ВнеоборотныеАктивыСлужебный.УстановитьСвойствоСтруктуры(
			"ПлательщикНалогаНаПрибыль",
			УчетнаяПолитика.ПлательщикНалогаНаПрибыль(Объект.Организация, Объект.Дата),
			Форма.СлужебныеПараметрыФормы);
			
	КонецЕсли;

	Если СтруктураИзмененныхРеквизитов.Свойство("Организация") 
		ИЛИ ОбновитьВсе Тогда
		
		ВнеоборотныеАктивыСлужебный.УстановитьСвойствоСтруктуры(
			"ЕстьСвязанныеОрганизации",
			Справочники.Организации.ОрганизацияВзаимосвязанаСДругимиОрганизациями(Объект.Организация),
			Форма.СлужебныеПараметрыФормы);
		
	КонецЕсли;

	//-- Локализация
	
КонецПроцедуры
 
#КонецОбласти

#Область ЗаполнениеДокумента

Процедура ЗаполнитьДокументПоОтбору(Объект, Основание) Экспорт

	//++ Локализация
	//-- Локализация
	
КонецПроцедуры

Процедура ЗаполнитьНаОснованииОбъектаЭксплуатации(Объект, Основание) Экспорт

	//++ Локализация
	//-- Локализация
	
КонецПроцедуры

Процедура ЗаполнитьНаОснованииПринятияКУчетуИлиВводаОстатков(Объект, Основание) Экспорт

	//++ Локализация
	//-- Локализация
	
КонецПроцедуры
 
#КонецОбласти

#Область Прочее

Процедура ДополнитьВспомогательныеРеквизиты(Объект, ВспомогательныеРеквизиты) Экспорт

	//++ Локализация
	//-- Локализация
	
КонецПроцедуры

Процедура ЗаполнитьСтоимость(Объект, СписокСтрок, ТаблицаОС) Экспорт

	//++ Локализация
	//-- Локализация
	
КонецПроцедуры

// Дополняет параметры выбора статей и аналитик.
// 
// Параметры:
// 	ПараметрыВыбораСтатьиИАналитики - Массив из см. ДоходыИРасходыСервер.ПараметрыВыбораСтатьиИАналитики -
Процедура ДополнитьПараметрыВыбораСтатейИАналитик(ПараметрыВыбораСтатьиИАналитики) Экспорт

	//++ Локализация
	//-- Локализация
	
КонецПроцедуры

#КонецОбласти

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

#Область Проведение

//++ Локализация
Процедура ТекстЗапросаТаблицаПорядокУчетаОСБУ(ТекстыЗапроса, Регистры)

	ИмяРегистра = "ПорядокУчетаОСБУ";
	
	Если Не ПроведениеДокументов.ТребуетсяТаблицаДляДвижений(ИмяРегистра, Регистры) Тогда
		Возврат;
	КонецЕсли;
	
	ТекстЗапроса =
	"ВЫБРАТЬ
	|	&Период                                 КАК Период,
	|	&Организация                            КАК Организация,
	|	ТаблицаОС.ОсновноеСредство              КАК ОсновноеСредство,
	|	ЗНАЧЕНИЕ(Перечисление.СостоянияОС.ПринятоКУчету) КАК Состояние,
	|	&НачислятьАмортизациюБУ                 КАК НачислятьАмортизациюБУ,
	|	&НачислятьАмортизациюНУ                 КАК НачислятьАмортизациюНУ,
	|	&СтатьяРасходовБУ                       КАК СтатьяРасходовБУ,
	|	&АналитикаРасходовБУ                    КАК АналитикаРасходовБУ,
	|	&СтатьяРасходовНУ                       КАК СтатьяРасходовНУ,
	|	&АналитикаРасходовНУ                    КАК АналитикаРасходовНУ,
	|	&ГрафикАмортизации                      КАК ГрафикАмортизации
	|ИЗ
	|	Документ.ПринятиеКУчетуОС2_4.ОС КАК ТаблицаОС
	|ГДЕ
	|	ТаблицаОС.Ссылка = &Ссылка
	|	И &ОтражатьВРеглУчете
	|	И &ВедетсяРегламентированныйУчетВНА";
	
	ТекстыЗапроса.Добавить(ТекстЗапроса, ИмяРегистра, Истина);
	
КонецПроцедуры

Процедура ТекстЗапросаТаблицаПараметрыАмортизацииОСБУ(Запрос, ТекстыЗапроса, Регистры)
	
	ИмяРегистра = "ПараметрыАмортизацииОСБУ";
	
	Если Не ПроведениеДокументов.ТребуетсяТаблицаДляДвижений(ИмяРегистра, Регистры) Тогда
		Возврат;
	КонецЕсли;
	
	ТекстЗапросаТаблицаВтРасчетСтоимостиСгруппированная(Запрос, ТекстыЗапроса);
	
	ТекстЗапроса =
	"ВЫБРАТЬ
	|	&Период                      КАК Период,
	|	&Организация                 КАК Организация,
	|	ТаблицаОС.ОсновноеСредство   КАК ОсновноеСредство,
	|	&Период                      КАК ДатаПоследнегоИзменения,
	|	&СрокИспользованияБУ         КАК СрокПолезногоИспользованияБУ,
	|	&СрокИспользованияНУ         КАК СрокПолезногоИспользованияНУ,
	|	&ГрафикАмортизации           КАК ГрафикАмортизации,
	|	ТаблицаОС.ОбъемНаработки     КАК ОбъемПродукцииРаботДляВычисленияАмортизации,
	|	&СрокИспользованияБУ         КАК СрокИспользованияДляВычисленияАмортизации,
	|
	|	ЕСТЬNULL(РасчетСтоимости.СтоимостьРегл 
	|				+ РасчетСтоимости.СтоимостьЦФ 
	|				+ РасчетСтоимости.НДСРегл, ТаблицаОС.СтоимостьБУ) КАК СтоимостьДляВычисленияАмортизации,
	|
	|	ЕСТЬNULL(РасчетСтоимости.СтоимостьЦФ, 0) КАК СтоимостьДляВычисленияАмортизацииЦФ
	|ИЗ
	|	Документ.ПринятиеКУчетуОС2_4.ОС КАК ТаблицаОС
	|		ЛЕВОЕ СОЕДИНЕНИЕ ВтРасчетСтоимостиСгруппированная КАК РасчетСтоимости
	|		ПО РасчетСтоимости.ОбъектУчета = ТаблицаОС.ОсновноеСредство
	|ГДЕ
	|	ТаблицаОС.Ссылка = &Ссылка
	|	И &ОтражатьВРеглУчете
	|	И &ВедетсяРегламентированныйУчетВНА";
	
	ТекстыЗапроса.Добавить(ТекстЗапроса, ИмяРегистра, Истина);
	
КонецПроцедуры

Процедура ТекстЗапросаТаблицаСобытияОСОрганизаций(ТекстыЗапроса, Регистры)
	
	ИмяРегистра = "СобытияОСОрганизаций";
	
	Если Не ПроведениеДокументов.ТребуетсяТаблицаДляДвижений(ИмяРегистра, Регистры) Тогда
		Возврат;
	КонецЕсли;
	
	ТекстЗапроса =
	"ВЫБРАТЬ
	|	&Период                     КАК Период,
	|	&Организация                КАК Организация,
	|	&СобытиеОС                  КАК Событие,
	|	ТаблицаОС.ОсновноеСредство  КАК ОсновноеСредство,
	|	&НазваниеДокумента          КАК НазваниеДокумента,
	|	&Номер                      КАК НомерДокумента
	|ИЗ
	|	Документ.ПринятиеКУчетуОС2_4.ОС КАК ТаблицаОС
	|ГДЕ
	|	ТаблицаОС.Ссылка = &Ссылка
	|	И &ОтражатьВРеглУчете
	|	И &ВедетсяРегламентированныйУчетВНА";
	
	ТекстыЗапроса.Добавить(ТекстЗапроса, ИмяРегистра, Истина);
	
КонецПроцедуры


Процедура ТекстЗапросаТаблицаОтражениеДокументовВРеглУчете(ТекстыЗапроса, Регистры)
	
	ИмяРегистра = "ОтражениеДокументовВРеглУчете";
	
	Если Не ПроведениеДокументов.ТребуетсяТаблицаДляДвижений(ИмяРегистра, Регистры) Тогда
		Возврат;
	КонецЕсли;
	
	ТекстЗапроса =
	"ВЫБРАТЬ
	|	&Ссылка КАК Документ,
	|	&Период КАК Период,
	|	НАЧАЛОПЕРИОДА(&Период, ДЕНЬ) КАК ДатаОтражения,
	|	&Организация КАК Организация,
	|	ЗНАЧЕНИЕ(Перечисление.СтатусыОтраженияДокументовВРеглУчете.КОтражениюВРеглУчете) КАК Статус
	|
	|";
		
	ТекстыЗапроса.Добавить(ТекстЗапроса, ИмяРегистра, Истина);
	
КонецПроцедуры
//-- Локализация

#КонецОбласти

#Область ЗаполнениеДокумента

//++ Локализация
//-- Локализация

#КонецОбласти

#Область ФормаДокумента

//++ Локализация
//-- Локализация

#КонецОбласти

#Область ОбновлениеИнформационнойБазы

// Параметры:
// 	Параметры - см. ОбновлениеИнформационнойБазы.ОсновныеПараметрыОтметкиКОбработке
//
Процедура ЗарегистрироватьДанныеКОбработкеДляПереходаНаНовуюВерсию(Параметры) Экспорт

	//++ Локализация
	//-- Локализация
	
КонецПроцедуры

Процедура ОбработатьДанныеДляПереходаНаНовуюВерсию(ДанныеОбъекта) Экспорт

	//++ Локализация
	//-- Локализация
	
КонецПроцедуры
 
#КонецОбласти

#КонецОбласти
