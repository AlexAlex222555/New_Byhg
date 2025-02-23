
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
	Документы.ТранспортнаяНакладная.ОбновитьРеквизитыТранспортныхНакладныхПриЗаписиДокументаОснования(Объект, Отказ);
	//-- Локализация
	
	Возврат;
	
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
	
	
КонецПроцедуры

Процедура КомплектПечатныхФорм(КомплектПечатныхФорм) Экспорт

	//++ Локализация
	//-- Локализация
	
КонецПроцедуры

Процедура СформироватьКомплектПечатныхФорм(МассивОбъектов,
										ПараметрыПечати,
										КоллекцияПечатныхФорм,
										ОбъектыПечати,
										КомплектПечатныхФорм) Экспорт
	
	//++ Локализация
	//-- Локализация
	
КонецПроцедуры

//++ Локализация

// Формирует временную таблицу, содержащую табличную часть по таблице данных документов.
//
// Параметры:
//	МенеджерВременныхТаблиц - МенеджерВременныхТаблиц - менеджер временных таблиц, содержащий таблицу
//		ТаблицаДанныхДокументов с полями:
//			* Ссылка - ДокументСсылка.ОтгрузкаТоваровСхранения - ссылка на документ отгрузки товров с хранения.
//	ПараметрыЗаполнения     - Структура               - структура, возвращаемая функцией
//		ПродажиСервер.ПараметрыЗаполненияВременнойТаблицыТоваров.
//
Процедура ПоместитьВременнуюТаблицуТоваров(МенеджерВременныхТаблиц, ПараметрыЗаполнения = Неопределено) Экспорт
	
	Если ПараметрыЗаполнения = Неопределено Тогда
		ПараметрыЗаполнения = ПродажиСервер.ПараметрыЗаполненияВременнойТаблицыТоваров();
	КонецЕсли;
	
	Запрос                         = Новый Запрос;
	Запрос.МенеджерВременныхТаблиц = МенеджерВременныхТаблиц;
	
	Запрос.Текст = "
	|ВЫБРАТЬ
	|	ТаблицаТоваров.Ссылка                КАК Ссылка,
	|	МАКСИМУМ(ТаблицаТоваров.НомерСтроки) КАК НомерСтроки,
	|	ТаблицаТоваров.Номенклатура          КАК Номенклатура,
	|	ТаблицаТоваров.Характеристика        КАК Характеристика,
	|	ТаблицаТоваров.Упаковка              КАК Упаковка,
	|	ТаблицаТоваров.Серия                 КАК Серия,
	|	ТаблицаТоваров.Цена                  КАК Цена
	|
	|ПОМЕСТИТЬ СтрокиТоваров
	|ИЗ
	|	Документ.ОтгрузкаТоваровСХранения.Товары КАК ТаблицаТоваров
	|		ВНУТРЕННЕЕ СОЕДИНЕНИЕ ТаблицаДанныхДокументов КАК ДанныеДокументов
	|		ПО ТаблицаТоваров.Ссылка = ДанныеДокументов.Ссылка
	|
	|СГРУППИРОВАТЬ ПО
	|	ТаблицаТоваров.Ссылка,
	|	ТаблицаТоваров.Номенклатура,
	|	ТаблицаТоваров.Характеристика,
	|	ТаблицаТоваров.Упаковка,
	|	ТаблицаТоваров.Серия,
	|	ТаблицаТоваров.Цена
	|
	|ИНДЕКСИРОВАТЬ ПО
	|	ТаблицаТоваров.Ссылка,
	|	ТаблицаТоваров.Номенклатура,
	|	ТаблицаТоваров.Характеристика,
	|	ТаблицаТоваров.Серия,
	|	ТаблицаТоваров.Упаковка,
	|	ТаблицаТоваров.Цена
	|;
	|/////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ
	|	ТаблицаДокумента.Ссылка                                     КАК Ссылка,
	|	СтрокиТоваров.НомерСтроки                                   КАК НомерСтроки,
	|	ТаблицаДокумента.АналитикаУчетаНоменклатуры.Номенклатура    КАК Номенклатура,
	|	ТаблицаДокумента.АналитикаУчетаНоменклатуры.Характеристика  КАК Характеристика,
	|	ТаблицаДокумента.Упаковка                                   КАК Упаковка,
	|	ТаблицаДокумента.АналитикаУчетаНоменклатуры.Серия           КАК Серия,
	|	СУММА(ТаблицаДокумента.КоличествоУпаковок)                  КАК КоличествоУпаковок,
	|	СУММА(ТаблицаДокумента.Количество)                          КАК Количество,
	|	ВЫБОР
	|		КОГДА &ВключаяНомераГТД
	|			ТОГДА ТаблицаДокумента.НомерГТД
	|		ИНАЧЕ
	|			&ПустаяГТД
	|	КОНЕЦ                                                        КАК НомерГТД,
	|	ТаблицаДокумента.Цена                                        КАК Цена,
	|	ТаблицаДокумента.СтавкаНДС                                   КАК СтавкаНДС,
	|	СУММА(ЕСТЬNULL(СуммыДокументовВВалютахУчета.СуммаНДСРегл,
	|		ТаблицаДокумента.СуммаНДС))                              КАК СуммаНДС,
	|	СУММА(ЕСТЬNULL(СуммыДокументовВВалютахУчета.СуммаБезНДСРегл,
	|		ТаблицаДокумента.СуммаСНДС - ТаблицаДокумента.СуммаНДС)) КАК СуммаБезНДС,
	|	ИСТИНА                                                       КАК ЭтоТовар
	|
	|ПОМЕСТИТЬ ОтгрузкаТоваровСХраненияТаблицаТоваров
	|ИЗ
	|	Документ.ОтгрузкаТоваровСХранения.ВидыЗапасов КАК ТаблицаДокумента
	|		ВНУТРЕННЕЕ СОЕДИНЕНИЕ ТаблицаДанныхДокументов КАК ДанныеДокументов
	|		ПО ТаблицаДокумента.Ссылка = ДанныеДокументов.Ссылка
	|
	|		ЛЕВОЕ СОЕДИНЕНИЕ РегистрСведений.СуммыДокументовВВалютахУчета КАК СуммыДокументовВВалютахУчета
	|		ПО ТаблицаДокумента.Ссылка = СуммыДокументовВВалютахУчета.Регистратор
	|			И ТаблицаДокумента.ИдентификаторСтроки = СуммыДокументовВВалютахУчета.ИдентификаторСтроки
	|			И СуммыДокументовВВалютахУчета.Активность
	|			И &ПересчитыватьВВалютуРегл
	|
	|		ЛЕВОЕ СОЕДИНЕНИЕ СтрокиТоваров КАК СтрокиТоваров
	|		ПО ТаблицаДокумента.Ссылка       = СтрокиТоваров.Ссылка
	|			И ТаблицаДокумента.АналитикаУчетаНоменклатуры.Номенклатура   = СтрокиТоваров.Номенклатура
	|			И ТаблицаДокумента.АналитикаУчетаНоменклатуры.Характеристика = СтрокиТоваров.Характеристика
	|			И ТаблицаДокумента.Упаковка  = СтрокиТоваров.Упаковка
	|			И ТаблицаДокумента.АналитикаУчетаНоменклатуры.Серия          = СтрокиТоваров.Серия
	|			И ТаблицаДокумента.Цена      = СтрокиТоваров.Цена
	|
	|СГРУППИРОВАТЬ ПО
	|	ТаблицаДокумента.Ссылка,
	|	СтрокиТоваров.НомерСтроки,
	|	ТаблицаДокумента.АналитикаУчетаНоменклатуры.Номенклатура,
	|	ТаблицаДокумента.АналитикаУчетаНоменклатуры.Характеристика,
	|	ТаблицаДокумента.Упаковка,
	|	ТаблицаДокумента.АналитикаУчетаНоменклатуры.Серия,
	|	ВЫБОР
	|		КОГДА &ВключаяНомераГТД
	|			ТОГДА ТаблицаДокумента.НомерГТД
	|		ИНАЧЕ
	|			&ПустаяГТД
	|	КОНЕЦ,
	|	ТаблицаДокумента.Цена,
	|	ТаблицаДокумента.СтавкаНДС
	|
	|ИНДЕКСИРОВАТЬ ПО
	|	Ссылка,
	|	НомерСтроки
	|;
	|/////////////////////////////////////////////////////////////////////////////
	|УНИЧТОЖИТЬ СтрокиТоваров";
	
	Запрос.УстановитьПараметр("ПересчитыватьВВалютуРегл", ПараметрыЗаполнения.ПересчитыватьВВалютуРегл);
	Запрос.УстановитьПараметр("ВключаяНомераГТД",         ПараметрыЗаполнения.ВключаяНомераГТД);
	Запрос.УстановитьПараметр("ПустаяГТД",                Справочники.НоменклатураГТД.ПустаяСсылка());
	
	Запрос.Выполнить();
	
КонецПроцедуры

//-- Локализация

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

#Область ОтгрузкаТоваровПринятыхНаОтветХранение                    // (Дт  :: Кт 023)
	ТекстЗапроса = "
	|ВЫБРАТЬ //// Отгрузка товаров, принятых на ответственное хранение (Дт  :: Кт 023)
	|
	|	Операция.Ссылка КАК Ссылка,
	|	Операция.Дата КАК Период,
	|	Операция.Организация КАК Организация,
	|	НЕОПРЕДЕЛЕНО КАК ИдентификаторСтроки,
	|
	|	ЕСТЬNULL(Стоимости.Сумма, Строки.Сумма) КАК Сумма,
	|	ЕСТЬNULL(Стоимости.СуммаУУ, Строки.СуммаУУ) КАК СуммаУУ,
	|
	|	НЕОПРЕДЕЛЕНО КАК ВидСчетаДт,
	|	НЕОПРЕДЕЛЕНО КАК АналитикаУчетаДт,
	|	НЕОПРЕДЕЛЕНО КАК МестоУчетаДт,
	|
	|	НЕОПРЕДЕЛЕНО КАК ВалютаДт,
	|	НЕОПРЕДЕЛЕНО КАК ПодразделениеДт,
	|	ЗНАЧЕНИЕ(Справочник.НаправленияДеятельности.ПустаяСсылка) КАК НаправлениеДеятельностиДт,
	|	НЕОПРЕДЕЛЕНО КАК НалоговоеНазначениеДт,	
	|
	|	НЕОПРЕДЕЛЕНО КАК СчетДт,
	|	НЕОПРЕДЕЛЕНО КАК СубконтоДт1,
	|	НЕОПРЕДЕЛЕНО КАК СубконтоДт2,
	|	НЕОПРЕДЕЛЕНО КАК СубконтоДт3,
	|
	|	0 КАК ВалютнаяСуммаДт,
	|	0 КАК КоличествоДт,
	|	0 КАК СуммаНУДт,
	|	0 КАК СуммаПРДт,
	|	0 КАК СуммаВРДт,
	|
	|	ВЫБОР КОГДА Строки.Склад.ЦеховаяКладовая
	|		ТОГДА ЗНАЧЕНИЕ(Перечисление.ВидыСчетовРеглУчета.ТМЦвпроизводстве)
	|		ИНАЧЕ ЗНАЧЕНИЕ(Перечисление.ВидыСчетовРеглУчета.ТМЦнаскладах)
	|	КОНЕЦ КАК ВидСчетаКт,
	|	Строки.ГруппаФинансовогоУчета КАК АналитикаУчетаКт,
	|	Строки.Склад КАК МестоУчетаКт,
	|
	|	НЕОПРЕДЕЛЕНО КАК ВалютаКт,
	|	Строки.Склад.Подразделение КАК ПодразделениеКт,
	|	ЗНАЧЕНИЕ(Справочник.НаправленияДеятельности.ПустаяСсылка) КАК НаправлениеДеятельностиКт,
	|	НЕОПРЕДЕЛЕНО КАК НалоговоеНазначениеКт,	
	|
	|	НЕОПРЕДЕЛЕНО КАК СчетКт,
	|	Строки.Номенклатура КАК СубконтоКт1,
	|	Строки.Контрагент КАК СубконтоКт2,
	|	Строки.Склад КАК СубконтоКт3,
	|
	|	0 КАК ВалютнаяСуммаКт,
	|	Строки.Количество КАК КоличествоКт,
	|	0 КАК СуммаНУКт,
	|	0 КАК СуммаПРКт,
	|	0 КАК СуммаВРКт,
	|	""%1"" КАК Содержание
	|
	|ИЗ 
	|	ДокументыКОтражению КАК ДокументыКОтражению
	|	
	|	ВНУТРЕННЕЕ СОЕДИНЕНИЕ
	|		Документ.ОтгрузкаТоваровСХранения КАК Операция
	|	ПО
	|		ДокументыКОтражению.Ссылка = Операция.Ссылка
	|
	|	ВНУТРЕННЕЕ СОЕДИНЕНИЕ
	|		ВтСтроки КАК Строки
	|	ПО
	|		Операция.Ссылка = Строки.Ссылка
	|
	|	ЛЕВОЕ СОЕДИНЕНИЕ
	|		ВтСтоимости КАК Стоимости
	|	ПО
	|		Строки.Ссылка = Стоимости.Ссылка
	|		И Строки.Номенклатура = Стоимости.Номенклатура
	|		И Строки.Склад = Стоимости.Склад
	|		И Строки.ГруппаФинансовогоУчета = Стоимости.ГруппаФинансовогоУчета
	|		И Строки.НаправлениеДеятельности = Стоимости.НаправлениеДеятельности
	|		И Строки.РазделУчета = Стоимости.РазделУчета
	|";

	ТекстЗапроса = СтрШаблон(ТекстЗапроса, 
		НСтр("ru='Отгрузка товаров, принятых на ответственное хранение';uk='Відвантаження товарів, які були прийняті на відповідальне зберігання'",ЯзыкСодержания));
	ТекстыОтражения.Добавить(ТекстЗапроса);
 
#КонецОбласти

	Возврат СтрСоединить(ТекстыОтражения, ОбщегоНазначенияУТ.РазделительЗапросовВОбъединении());;

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

//++ Локализация

// Правила получения значений реквизитов ТТН
// 
// Возвращаемое значение:
//  Структура -  см. Документы.ТранспортнаяНакладная.ПараметрыФормированияТранспортныхНакладных() 
//
Функция ПараметрыФормированияТранспортныхНакладных() Экспорт
	
	ПараметрыФормированияТранспортныхНакладных =
		Документы.ТранспортнаяНакладная.ПараметрыФормированияТранспортныхНакладных();
		
	ПараметрыФормированияТранспортныхНакладных.Реквизиты.Грузоотправитель = 
	"	ВЫБОР
	|		КОГДА ОснованиеТранспортнойНакладной.Грузоотправитель = ЗНАЧЕНИЕ(Справочник.Контрагенты.ПустаяСсылка)
	|			ТОГДА ОснованиеТранспортнойНакладной.Организация
	|		ИНАЧЕ ОснованиеТранспортнойНакладной.Грузоотправитель
	|	КОНЕЦ";
	
	ПараметрыФормированияТранспортныхНакладных.Реквизиты.Грузополучатель = 
	"		ВЫБОР
	|			КОГДА ОснованиеТранспортнойНакладной.Грузополучатель = ЗНАЧЕНИЕ(Справочник.Контрагенты.ПустаяСсылка)
	|				ТОГДА ОснованиеТранспортнойНакладной.Контрагент
	|			ИНАЧЕ ОснованиеТранспортнойНакладной.Грузополучатель
	|		КОНЕЦ";
	
	ПараметрыФормированияТранспортныхНакладных.Реквизиты.ЗаказчикПеревозки                 = "ОснованиеТранспортнойНакладной.Организация";
	ПараметрыФормированияТранспортныхНакладных.Реквизиты.БанковскийСчетЗаказчикаПеревозки  = "ОснованиеТранспортнойНакладной.БанковскийСчетОрганизации";
	ПараметрыФормированияТранспортныхНакладных.Реквизиты.Плательщик                        = "ОснованиеТранспортнойНакладной.Организация";
	ПараметрыФормированияТранспортныхНакладных.Реквизиты.БанковскийСчетПлательщика         = "ОснованиеТранспортнойНакладной.БанковскийСчетОрганизации";
	
	Возврат	ПараметрыФормированияТранспортныхНакладных;
	
КонецФункции

//-- Локализация

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

#Область Проведение

// Процедура дополняет тексты запросов проведения документа.
//
// Параметры:
//  Запрос - Запрос - Общий запрос проведения документа.
//  ТекстыЗапроса - СпискоЗначений - Список текстов запроса провведения.
//  Регистры - Строка, Структура - Список регистров продения документа через запятую или в ключах структуры.
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
