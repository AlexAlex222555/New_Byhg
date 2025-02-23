
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
	//++ НЕ УТ
	МеханизмыДокумента.Добавить("РегламентированныйУчет");
	//-- НЕ УТ
	//-- Локализация
	
КонецПроцедуры

#КонецОбласти

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
Процедура ОбработкаЗаполнения(Объект, ДанныеЗаполнения, СтандартнаяОбработка) Экспорт
	
	
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
	
	
КонецПроцедуры

// Вызывается из соответствующего обработчика документа
//
// Параметры:
//  Объект - ДокументОбъект - Обрабатываемый объект
//  Отказ - Булево - Признак отказа от записи.
//                   Если в теле процедуры-обработчика установить данному параметру значение Истина, то запись выполнена не будет и будет вызвано исключение.
//
Процедура ПриЗаписи(Объект, Отказ) Экспорт
	
	
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

// Заполняет список команд печати.
//
// Параметры:
//   КомандыПечати - см. УправлениеПечатью.СоздатьКоллекциюКомандПечати
//
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
	//++ Локализация
	//-- Локализация
КонецПроцедуры

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
Функция ТекстОтраженияВРеглУчетеУКР() Экспорт
	
	//++ Локализация

	ЯзыкСодержания = МультиязычностьУкр.КодЯзыкаИнформационнойБазы();
 

	ТекстыОтражения = Новый Массив;

#Область ВключениеИсключениеНДСВСтоимость


	ТекстЗапроса = "
	|ВЫБРАТЬ ////  Условная продажа при использовании облагаемого товара в необлагаемых операциях  (Дт 90 :: Кт 6435)
	|        ////  Сторно условной продажи при использовании облагаемого товара в необлагаемых операциях  (Дт 90 :: Кт 6435 сторно)
	|	Операция.Ссылка КАК Ссылка,
	|	Партии.Период КАК Период,
	|	Партии.Организация КАК Организация,
	|	НЕОПРЕДЕЛЕНО КАК ИдентификаторСтроки,
	|
	|	ВЫБОР КОГДА Партии.ВключениеНДСВСтоимость ТОГДА
	|		Партии.НДСРегл
	|	ИНАЧЕ
	|		-Партии.НДСРегл
	|	КОНЕЦ КАК Сумма,
	|	ВЫБОР КОГДА Партии.ВключениеНДСВСтоимость ТОГДА
	|		Партии.НДСУпр
	|	ИНАЧЕ
	|		-Партии.НДСУпр
	|	КОНЕЦ КАК СуммаУУ,
	|
	|	ЗНАЧЕНИЕ(Перечисление.ВидыСчетовРеглУчета.Расходы) КАК ВидСчетаДт,
	|	ЗНАЧЕНИЕ(ПланВидовХарактеристик.СтатьиРасходов.НачисленныйНДСПриВыкупеМногооборотнойТары) КАК АналитикаУчетаДт,
	|	Партии.Склад КАК МестоУчетаДт,
	|
	|	ЗНАЧЕНИЕ(Справочник.Валюты.ПустаяСсылка) КАК ВалютаДт,
	|	Операция.Подразделение КАК ПодразделениеДт,
	|	Партии.НаправлениеДеятельности КАК НаправлениеДеятельностиДт,
	|	НЕОПРЕДЕЛЕНО КАК НалоговоеНазначениеДт,
	|
	|	ЗНАЧЕНИЕ(ПланСчетов.Хозрасчетный.ПустаяСсылка) КАК СчетДт,
	|
	|	Партии.ГруппаФинансовогоУчета КАК СубконтоДт1,
	|	НЕОПРЕДЕЛЕНО КАК СубконтоДт2,
	|	НЕОПРЕДЕЛЕНО КАК СубконтоДт3,
	|
	|	0 КАК ВалютнаяСуммаДт,
	|	0 КАК КоличествоДт,
	|	0 КАК СуммаНУДт,
	|	0 КАК СуммаПРДт,
	|	0 КАК СуммаВРДт,
	|
	|	НЕОПРЕДЕЛЕНО КАК ВидСчетаКт,
	|	НЕОПРЕДЕЛЕНО КАК АналитикаУчетаКт,
	|	НЕОПРЕДЕЛЕНО КАК МестоУчетаКт,
	|
	|	ЗНАЧЕНИЕ(Справочник.Валюты.ПустаяСсылка) КАК ВалютаКт,
	|	НЕОПРЕДЕЛЕНО КАК ПодразделениеКт,
	|	Партии.НаправлениеДеятельности КАК НаправлениеДеятельностиКт,
	|	НЕОПРЕДЕЛЕНО КАК НалоговоеНазначениеКт,
	|	ЗНАЧЕНИЕ(ПланСчетов.Хозрасчетный.УсловнаяПродажа) КАК СчетКт,
	|
	|	Партии.Контрагент КАК СубконтоКт1,
	|	Партии.ДокументПоступления КАК СубконтоКт2,
	|	Операция.Ссылка КАК СубконтоКт3,
	|
	|	0 КАК ВалютнаяСуммаКт,
	|	0 КоличествоКт,
	|	0 КАК СуммаНУКт,
	|	0 КАК СуммаПРКт,
	|	0 КАК СуммаВРКт,
 	|	ВЫБОР КОГДА Партии.ВключениеНДСВСтоимость ТОГДА
	|		""%1""
	|	ИНАЧЕ
	|		""%2""
	|	КОНЕЦ КАК Содержание
	|ИЗ
	|	ДокументыКОтражению КАК ДокументыКОтражению
	|	
	|	ВНУТРЕННЕЕ СОЕДИНЕНИЕ
	|		Документ.ВыкупВозвратнойТарыУПоставщика КАК Операция
	|	ПО
	|		ДокументыКОтражению.Ссылка = Операция.Ссылка
	|
	|	ВНУТРЕННЕЕ СОЕДИНЕНИЕ
	|		Партии КАК Партии
	|	ПО
	|		Операция.Ссылка = Партии.Ссылка
	|	
	|ГДЕ
	|	(Партии.ВключениеНДСВСтоимость ИЛИ Партии.ИсключениеНДСИзСтоимости)
	|";
	
	ТекстЗапроса = СтрШаблон(ТекстЗапроса, 
		НСтр("ru='Условная продажа';uk='Умовний продаж'",ЯзыкСодержания),НСтр("ru='Сторно условной продажи';uk='Сторно умовного продажу'",ЯзыкСодержания));

	ТекстыОтражения.Добавить(ТекстЗапроса);
	
#КонецОбласти


#Область ТараНДСОжидаемый

	ТекстЗапроса = "
	|ВЫБРАТЬ 
	|	Операция.Ссылка КАК Ссылка,
	|	Операция.Дата КАК Период,
	|	Операция.Организация КАК Организация,
	|	НЕОПРЕДЕЛЕНО КАК ИдентификаторСтроки,
	|
	|	СУММА(ЕСТЬNULL(Суммы.СуммаНДСРегл, Строки.СуммаНДС)) КАК Сумма,
	|	СУММА(ЕСТЬNULL(Суммы.СуммаНДСУпрМУ, Строки.СуммаНДС)) КАК СуммаУУ,
	|
	|	НЕОПРЕДЕЛЕНО КАК ВидСчетаДт,
	|	Строки.Номенклатура.ГруппаФинансовогоУчета КАК АналитикаУчетаДт,
	|	НЕОПРЕДЕЛЕНО КАК МестоУчетаДт,
	|
	|	ЗНАЧЕНИЕ(Справочник.Валюты.ПустаяСсылка) КАК ВалютаДт,
	|	НЕОПРЕДЕЛЕНО КАК ПодразделениеДт,
	|	ЗНАЧЕНИЕ(Справочник.НаправленияДеятельности.ПустаяСсылка) КАК НаправлениеДеятельностиДт,
	|	НЕОПРЕДЕЛЕНО КАК НалоговоеНазначениеДт,
	|
	|	ЗНАЧЕНИЕ(ПланСчетов.Хозрасчетный.НалоговыйКредитНеподтвержденный) КАК СчетДт,
	|
	|	Операция.Контрагент КАК СубконтоДт1,
	|	Операция.Договор КАК СубконтоДт2,
	|	НЕОПРЕДЕЛЕНО КАК СубконтоДт3,
	|
	|	0 КАК ВалютнаяСуммаДт,
	|	0 КАК КоличествоДт,
	|	0 КАК СуммаНУДт,
	|	0 КАК СуммаПРДт,
	|	0 КАК СуммаВРДт,
	|
	|	ЗНАЧЕНИЕ(Перечисление.ВидыСчетовРеглУчета.РасчетыСПоставщикамиТара) КАК ВидСчетаКт,
	|	ЕСТЬNULL(Расчеты.ГруппаФинансовогоУчета, Операция.ГруппаФинансовогоУчета) КАК АналитикаУчетаКт,
	|	НЕОПРЕДЕЛЕНО КАК МестоУчетаКт,
	|
	|	ЗНАЧЕНИЕ(Справочник.Валюты.ПустаяСсылка) КАК ВалютаКт,
	|	ЕСТЬNULL(Расчеты.Подразделение, Операция.Подразделение) КАК ПодразделениеКт,
	|	ЕСТЬNULL(Расчеты.НаправлениеДеятельности, Операция.НаправлениеДеятельности) КАК НаправлениеДеятельностиКт,
	|	НЕОПРЕДЕЛЕНО КАК НалоговоеНазначениеКт,
	|	НЕОПРЕДЕЛЕНО КАК СчетКт,
	|
	|	Операция.Контрагент КАК СубконтоКт1,
	|	Операция.Договор КАК СубконтоКт2,
	|	НЕОПРЕДЕЛЕНО КАК СубконтоКт3,
	|
	|	СУММА(Строки.СуммаВзаиморасчетов - Строки.СуммаНДСВзаиморасчетов) КАК ВалютнаяСуммаКт,
	|	0 КоличествоКт,
	|	0 КАК СуммаНУКт,
	|	0 КАК СуммаПРКт,
	|	0 КАК СуммаВРКт,
	|	""%1"" КАК Содержание
	|ИЗ
	|	ДокументыКОтражению КАК ДокументыКОтражению
	|	
	|	ВНУТРЕННЕЕ СОЕДИНЕНИЕ
	|		Документ.ВыкупВозвратнойТарыУПоставщика КАК Операция
	|	ПО
	|		ДокументыКОтражению.Ссылка = Операция.Ссылка
	|	
	|	ВНУТРЕННЕЕ СОЕДИНЕНИЕ 
	|		Документ.ВыкупВозвратнойТарыУПоставщика.Товары КАК Строки
	|	ПО 
	|		Строки.Ссылка = Операция.Ссылка
	|	
	|	ЛЕВОЕ СОЕДИНЕНИЕ 
	|		РегистрСведений.СуммыДокументовВВалютахУчета КАК Суммы
	|	ПО 
	|		Суммы.Регистратор = Строки.Ссылка
	|		И Суммы.ИдентификаторСтроки = Строки.ИдентификаторСтроки
	|		И Суммы.СуммаБезНДСРегл <> 0
	|
	|	ЛЕВОЕ СОЕДИНЕНИЕ
	|		ВТРасчетыСПоставщиками КАК Расчеты
	|	ПО 
	|		Расчеты.Ссылка = Операция.Ссылка
	|		
	|ГДЕ
	|	Операция.ВозвратТарыНеПросрочен
	|
	|СГРУППИРОВАТЬ ПО
	|	Операция.Ссылка,
	|	Строки.Номенклатура.ГруппаФинансовогоУчета,
	|	ЕСТЬNULL(Расчеты.ГруппаФинансовогоУчета, Операция.ГруппаФинансовогоУчета),
	|	ЕСТЬNULL(Расчеты.Подразделение, Операция.Подразделение),
	|	ЕСТЬNULL(Расчеты.НаправлениеДеятельности, Операция.НаправлениеДеятельности)
	|";

	ТекстЗапроса = СтрШаблон(ТекстЗапроса, 
		НСтр("ru='НДС: налоговый кредит не подтвержденный';uk='ПДВ: податковий кредит, не підтверджений'",ЯзыкСодержания));
 	
	ТекстыОтражения.Добавить(ТекстЗапроса);
	
#КонецОбласти

	Возврат СтрСоединить(ТекстыОтражения, ОбщегоНазначенияУТ.РазделительЗапросовВОбъединении());
	
	//-- Локализация
	Возврат "";
	
КонецФункции

// Функция возвращает текст запроса дополнительных временных таблиц,
// необходимых для отражения в регламентированном учете
//
// Возвращаемое значение:
//   Строка - сформированный текст запроса.
//
Функция ТекстЗапросаВТОтраженияВРеглУчетеУКР() Экспорт
	
	//++ Локализация
	//-- Локализация
	Возврат "";
	
КонецФункции

#КонецОбласти
//-- НЕ УТ

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

#Область Проведение

// Процедура дополняет тексты запросов проведения документа.
//
// Параметры:
//  Запрос - Запрос - Общий запрос проведения документа.
//  ТекстыЗапроса - СписокЗначений - Список текстов запроса проведения.
//  Регистры - Строка, Структура - Список регистров проведения документа через запятую или в ключах структуры.
//
Процедура ДополнитьТекстыЗапросовПроведения(Запрос, ТекстыЗапроса, Регистры) Экспорт
	
	//++ Локализация
	//++ НЕ УТ
	РеглУчетПроведениеСервер.ТекстЗапросаТаблицаОтражениеДокументовВРеглУчете(Запрос, ТекстыЗапроса, Регистры);
	//-- НЕ УТ
	//-- Локализация
	
КонецПроцедуры

#КонецОбласти

#КонецОбласти
