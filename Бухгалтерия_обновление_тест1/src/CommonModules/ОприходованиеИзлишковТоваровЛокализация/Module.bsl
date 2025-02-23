
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


// Функция получает данные для формирования печатной формы МХ - 1
//
Функция ПолучитьДанныеДляПечатнойФормыМХ1(ПараметрыПечати, МассивОбъектов) Экспорт
	
	КолонкаКодов = ФормированиеПечатныхФорм.ИмяДополнительнойКолонки();
	Если Не ЗначениеЗаполнено(КолонкаКодов) Тогда
		КолонкаКодов = "Код";
	КонецЕсли;
	
	Запрос = Новый Запрос;
	Запрос.Текст = "
	|ВЫБРАТЬ
	|	РасчетСебестоимостиТоваровОрганизации.Ссылка.ПредварительныйРасчет КАК ПредварительныйРасчет,
	|	Документ.Ссылка КАК Ссылка,
	|	Документ.Номер КАК Номер,
	|	Документ.Дата КАК Дата,
	|	Документ.Дата КАК ДатаДокумента,
	|	Документ.Организация КАК Организация,
	|	Документ.Склад КАК Склад,
	|	Склады.ИсточникИнформацииОЦенахДляПечати КАК ИсточникИнформацииОЦенахДляПечати,
	|	Склады.УчетныйВидЦены КАК ВидЦены,
	|	Склады.УчетныйВидЦены.ВалютаЦены КАК ВалютаЦены
	|ПОМЕСТИТЬ ВтШапка
	|ИЗ
	|	Документ.ОприходованиеИзлишковТоваров КАК Документ
	|		ЛЕВОЕ СОЕДИНЕНИЕ Документ.РасчетСебестоимостиТоваров.Организации КАК РасчетСебестоимостиТоваровОрганизации
	|		ПО (РасчетСебестоимостиТоваровОрганизации.Ссылка.Дата МЕЖДУ НАЧАЛОПЕРИОДА(Документ.Дата, МЕСЯЦ) И КОНЕЦПЕРИОДА(Документ.Дата, МЕСЯЦ))
	|			И (РасчетСебестоимостиТоваровОрганизации.Ссылка.Проведен)
	|			И (Документ.Организация = РасчетСебестоимостиТоваровОрганизации.Организация)
	|		ЛЕВОЕ СОЕДИНЕНИЕ Справочник.Склады КАК Склады
	|		ПО (Документ.Склад = Склады.Ссылка)
	|ГДЕ
	|	Документ.Ссылка В(&МассивДокументов)
	|	И Документ.Проведен
	|	И Склады.СкладОтветственногоХранения
	|	И Документ.Организация <> Склады.Поклажедержатель
	|;
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ
	|	Товары.Ссылка КАК Ссылка,
	|	Шапка.Склад КАК Склад,
	|	Товары.Номенклатура.ЕдиницаИзмерения КАК Упаковка,
	|	Товары.НомерСтроки КАК НомерСтроки,
	|	Товары.Номенклатура КАК Номенклатура,
	|	Товары.Характеристика КАК Характеристика,
	|	Товары.Номенклатура.ЕдиницаИзмерения.Представление КАК ЕдиницаИзмеренияНаименование,
	|	Товары.Номенклатура.ЕдиницаИзмерения.Код КАК ЕдиницаИзмеренияКод,
	|	Товары.Номенклатура.ЕдиницаИзмерения.Представление КАК ВидУпаковки,
	|	Товары.Количество КАК КоличествоУпаковок,
	|	Товары.Количество КАК Количество,
	|	КОНЕЦПЕРИОДА(Товары.Ссылка.Дата, ДЕНЬ) КАК ДатаПолученияЦены,
	|	Шапка.ВидЦены КАК ВидЦены,
	|	Шапка.ВалютаЦены КАК ВалютаЦены
	|ПОМЕСТИТЬ ВтТовары
	|ИЗ
	|	Документ.ОприходованиеИзлишковТоваров.Товары КАК Товары
	|		ВНУТРЕННЕЕ СОЕДИНЕНИЕ ВтШапка КАК Шапка
	|		ПО Товары.Ссылка = Шапка.Ссылка
	|ГДЕ
	|	Товары.Номенклатура.ТипНоменклатуры В (ЗНАЧЕНИЕ(Перечисление.ТипыНоменклатуры.Товар), ЗНАЧЕНИЕ(Перечисление.ТипыНоменклатуры.МногооборотнаяТара))
	|	И (Шапка.ИсточникИнформацииОЦенахДляПечати = ЗНАЧЕНИЕ(Перечисление.ИсточникиИнформацииОЦенахДляПечати.ПоВидуЦен)
	|		ИЛИ (Шапка.ИсточникИнформацииОЦенахДляПечати = ЗНАЧЕНИЕ(Перечисление.ИсточникиИнформацииОЦенахДляПечати.ПоСебестоимости)
	|			И Шапка.ПредварительныйРасчет ЕСТЬ NULL))
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ
	|	ВидыЗапасов.Ссылка КАК Ссылка,
	|	ВидыЗапасов.АналитикаУчетаНоменклатуры КАК АналитикаУчетаНоменклатуры,
	|	ВидыЗапасов.ВидЗапасов КАК ВидЗапасов,
	|	Шапка.Организация КАК Организация,
	|	ВидыЗапасов.АналитикаУчетаНоменклатуры.МестоХранения КАК Склад,
	|	ВидыЗапасов.АналитикаУчетаНоменклатуры.Номенклатура.ЕдиницаИзмерения КАК Упаковка,
	|	ВидыЗапасов.НомерСтроки КАК НомерСтроки,
	|	ВидыЗапасов.АналитикаУчетаНоменклатуры.Номенклатура КАК Номенклатура,
	|	ВидыЗапасов.АналитикаУчетаНоменклатуры.Характеристика КАК Характеристика,
	|	ВидыЗапасов.АналитикаУчетаНоменклатуры.Номенклатура.ЕдиницаИзмерения.Представление КАК ЕдиницаИзмеренияНаименование,
	|	ВидыЗапасов.АналитикаУчетаНоменклатуры.Номенклатура.ЕдиницаИзмерения.Код КАК ЕдиницаИзмеренияКод,
	|	ВидыЗапасов.АналитикаУчетаНоменклатуры.Номенклатура.ЕдиницаИзмерения.Представление ВидУпаковки,
	|	ВидыЗапасов.Количество КАК КоличествоУпаковок,
	|	ВидыЗапасов.Количество КАК Количество,
	|	КОНЕЦПЕРИОДА(ВидыЗапасов.Ссылка.Дата, ДЕНЬ) КАК ДатаПолученияЦены,
	|	ВидыЗапасов.АналитикаУчетаНоменклатуры.МестоХранения.УчетныйВидЦены КАК ВидЦены,
	|	ВидыЗапасов.АналитикаУчетаНоменклатуры.МестоХранения.УчетныйВидЦены.ВалютаЦены КАК ВалютаЦены,
	|	Шапка.ПредварительныйРасчет КАК ПредварительныйРасчет
	|ПОМЕСТИТЬ ВтВидыЗапасов
	|ИЗ
	|	Документ.ОприходованиеИзлишковТоваров.Товары КАК ВидыЗапасов
	|		ВНУТРЕННЕЕ СОЕДИНЕНИЕ ВтШапка КАК Шапка
	|		ПО ВидыЗапасов.Ссылка = Шапка.Ссылка
	|ГДЕ
	|	ВидыЗапасов.АналитикаУчетаНоменклатуры.Номенклатура.ТипНоменклатуры В (ЗНАЧЕНИЕ(Перечисление.ТипыНоменклатуры.Товар), ЗНАЧЕНИЕ(Перечисление.ТипыНоменклатуры.МногооборотнаяТара))
	|	И ВидыЗапасов.АналитикаУчетаНоменклатуры.МестоХранения.ИсточникИнформацииОЦенахДляПечати = ЗНАЧЕНИЕ(Перечисление.ИсточникиИнформацииОЦенахДляПечати.ПоСебестоимости)
	|;
	|";
	
	СкладыСервер.ДополнитьТекстЗапросаДляПечатныхФормМХ1Х3(Запрос);
	
	Запрос.УстановитьПараметр("МассивДокументов", МассивОбъектов);
	Запрос.УстановитьПараметр("КолонкаКодов", КолонкаКодов);
	
	МассивРезультатов = Запрос.ВыполнитьПакет();
	РезультатПоШапке = МассивРезультатов[6];
	РезультатПоСкладам = МассивРезультатов[7];
	РезультатПоТабличнойЧасти = МассивРезультатов[8];
	
	СтруктураДанныхДляПечати = Новый Структура(
		"РезультатПоШапке, РезультатПоСкладам, РезультатПоТабличнойЧасти",
		РезультатПоШапке,
		РезультатПоСкладам,
		РезультатПоТабличнойЧасти);
		
	Возврат СтруктураДанныхДляПечати
	
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
Функция ТекстОтраженияВРеглУчетеУКР() Экспорт
	
	//++ Локализация

	ЯзыкСодержания = МультиязычностьУкр.КодЯзыкаИнформационнойБазы();
 
#Область ТекстОприходованиеТоваров                    // (Дт 2X :: Кт 7X)
	ТекстОприходованиеТоваров = "
	|ВЫБРАТЬ //// Оприходование товаров (Дт 2X :: Кт 7X)
	|
	|	Операция.Ссылка КАК Ссылка,
	|	Операция.Дата КАК Период,
	|	Операция.Организация КАК Организация,
	|	НЕОПРЕДЕЛЕНО КАК ИдентификаторСтроки,
	|
	|	ЕСТЬNULL(Суммы.СуммаБезНДСРегл,Строки.Сумма) КАК Сумма,
	|	Строки.Сумма КАК СуммаУУ,
	|
	|	ЗНАЧЕНИЕ(Перечисление.ВидыСчетовРеглУчета.НаСкладе) КАК ВидСчетаДт,
	|	ВЫБОР
	|		КОГДА &ФормироватьВидыЗапасовПоГруппамФинансовогоУчета
	|			ТОГДА Строки.ВидЗапасов.ГруппаФинансовогоУчета
	|		ИНАЧЕ Строки.Номенклатура.ГруппаФинансовогоУчета
	|	КОНЕЦ КАК АналитикаУчетаДт,
	|	Операция.Склад КАК МестоУчетаДт,
	|
	|	ЗНАЧЕНИЕ(Справочник.Валюты.ПустаяСсылка) КАК ВалютаДт,
	|	Операция.Склад.Подразделение КАК ПодразделениеДт,
	|	Строки.Назначение.НаправлениеДеятельности КАК НаправлениеДеятельностиДт,
	|	НЕОПРЕДЕЛЕНО КАК НалоговоеНазначениеДт,
	|
	|	ЗНАЧЕНИЕ(ПланСчетов.Хозрасчетный.ПустаяСсылка) КАК СчетДт,
	|	Строки.Номенклатура КАК СубконтоДт1,
	|	Операция.Склад КАК СубконтоДт2,
	|	НЕОПРЕДЕЛЕНО КАК СубконтоДт3,
	|
	|	0 КАК ВалютнаяСуммаДт,
	|	Строки.Количество КАК КоличествоДт,
	|	0 КАК СуммаНУДт,
	|	0 КАК СуммаПРДт,
	|	0 КАК СуммаВРДт,
	|
	|	ЗНАЧЕНИЕ(Перечисление.ВидыСчетовРеглУчета.Доходы) КАК ВидСчетаКт,
	|	Операция.СтатьяДоходов КАК АналитикаУчетаКт,
	|	Операция.Подразделение КАК МестоУчетаКт,
	|
	|	ЗНАЧЕНИЕ(Справочник.Валюты.ПустаяСсылка) КАК ВалютаКт,
	|	Операция.Подразделение КАК ПодразделениеКт,
	|	Строки.Назначение.НаправлениеДеятельности КАК НаправлениеДеятельностиКт,
	|	НЕОПРЕДЕЛЕНО КАК НалоговоеНазначениеКт,
	|
	|	ЗНАЧЕНИЕ(ПланСчетов.Хозрасчетный.ПустаяСсылка) КАК СчетКт,
	|	Операция.СтатьяДоходов КАК СубконтоКт1,
	|	ВЫБОР
	|		КОГДА &ФормироватьВидыЗапасовПоГруппамФинансовогоУчета
	|			ТОГДА Строки.ВидЗапасов.ГруппаФинансовогоУчета
	|		ИНАЧЕ Строки.Номенклатура.ГруппаФинансовогоУчета
	|	КОНЕЦ КАК СубконтоКт2,
	|	НЕОПРЕДЕЛЕНО КАК СубконтоКт3,
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
	|		Документ.ОприходованиеИзлишковТоваров КАК Операция
	|	ПО
	|		ДокументыКОтражению.Ссылка = Операция.Ссылка
	|	
	|	ВНУТРЕННЕЕ СОЕДИНЕНИЕ
	|		Документ.ОприходованиеИзлишковТоваров.Товары КАК Строки
	|	ПО 
	|		(Строки.Ссылка = Операция.Ссылка)
	|	
	|	ЛЕВОЕ СОЕДИНЕНИЕ 
	|		РегистрСведений.СуммыДокументовВВалютахУчета КАК Суммы
	|	ПО 
	|		Строки.Ссылка = Суммы.Регистратор 
	|		И Строки.ИдентификаторСтроки = Суммы.ИдентификаторСтроки 
	|		И Суммы.СуммаБезНДСРегл <> 0
	|	
	|ГДЕ
	|	НЕ Операция.Склад.ЦеховаяКладовая
	|";

	ТекстОприходованиеТоваров = СтрШаблон(ТекстОприходованиеТоваров, 
		НСтр("ru='Оприходование товаров';uk='Оприбуткування товарів'",ЯзыкСодержания));
 
#КонецОбласти
	
#Область ТекстОприходованиеТоваровНаСкладПроизводства        // (Дт 231 :: Кт 7X)
	ТекстОприходованиеТоваровСкладПроизводства = "
	|ВЫБРАТЬ //// Оприходование товаров на склад производства (Дт 231 :: Кт 7X)
	|
	|	Операция.Ссылка КАК Ссылка,
	|	Операция.Дата КАК Период,
	|	Операция.Организация КАК Организация,
	|	НЕОПРЕДЕЛЕНО КАК ИдентификаторСтроки,
	|
	|	ЕСТЬNULL(Суммы.СуммаБезНДСРегл,Строки.Сумма) КАК Сумма,
	|	Строки.Сумма КАК СуммаУУ,
	|
	|	ЗНАЧЕНИЕ(Перечисление.ВидыСчетовРеглУчета.Производство) КАК ВидСчетаДт,
	|	НЕОПРЕДЕЛЕНО КАК АналитикаУчетаДт,
	|	Операция.Склад.Подразделение КАК МестоУчетаДт,
	|
	|	ЗНАЧЕНИЕ(Справочник.Валюты.ПустаяСсылка) КАК ВалютаДт,
	|	Операция.Склад.Подразделение КАК ПодразделениеДт,
	|	Строки.Назначение.НаправлениеДеятельности КАК НаправлениеДеятельностиДт,
	|	НЕОПРЕДЕЛЕНО КАК НалоговоеНазначениеДт,
	|
	|	ЗНАЧЕНИЕ(ПланСчетов.Хозрасчетный.ПустаяСсылка) КАК СчетДт,
	|	Строки.Номенклатура КАК СубконтоДт1,
	|	ЗНАЧЕНИЕ(Перечисление.ТипыЗатратРегл.МатериальныеЗатраты) КАК СубконтоДт2,
	|	НЕОПРЕДЕЛЕНО КАК СубконтоДт3,
	|
	|	0 КАК ВалютнаяСуммаДт,
	|	0 КАК КоличествоДт,
	|	0 КАК СуммаНУДт,
	|	0 КАК СуммаПРДт,
	|	0 КАК СуммаВРДт,
	|
	|	ЗНАЧЕНИЕ(Перечисление.ВидыСчетовРеглУчета.Доходы) КАК ВидСчетаКт,
	|	Операция.СтатьяДоходов КАК АналитикаУчетаКт,
	|	Операция.Подразделение КАК МестоУчетаКт,
	|
	|	ЗНАЧЕНИЕ(Справочник.Валюты.ПустаяСсылка) КАК ВалютаКт,
	|	Операция.Подразделение КАК ПодразделениеКт,
	|	Строки.Назначение.НаправлениеДеятельности КАК НаправлениеДеятельностиКт,
	|	НЕОПРЕДЕЛЕНО КАК НалоговоеНазначениеКт,
	|
	|	ЗНАЧЕНИЕ(ПланСчетов.Хозрасчетный.ПустаяСсылка) КАК СчетКт,
	|	Операция.СтатьяДоходов КАК СубконтоКт1,
	|	ВЫБОР
	|		КОГДА &ФормироватьВидыЗапасовПоГруппамФинансовогоУчета
	|			ТОГДА Строки.ВидЗапасов.ГруппаФинансовогоУчета
	|		ИНАЧЕ Строки.Номенклатура.ГруппаФинансовогоУчета
	|	КОНЕЦ КАК СубконтоКт2,
	|	НЕОПРЕДЕЛЕНО КАК СубконтоКт3,
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
	|		Документ.ОприходованиеИзлишковТоваров КАК Операция
	|	ПО
	|		ДокументыКОтражению.Ссылка = Операция.Ссылка
	|	
	|	ВНУТРЕННЕЕ СОЕДИНЕНИЕ
	|		Документ.ОприходованиеИзлишковТоваров.Товары КАК Строки
	|	ПО 
	|		(Строки.Ссылка = Операция.Ссылка)
	|	
	|	ЛЕВОЕ СОЕДИНЕНИЕ 
	|		РегистрСведений.СуммыДокументовВВалютахУчета КАК Суммы
	|	ПО 
	|		Строки.Ссылка = Суммы.Регистратор 
	|		И Строки.ИдентификаторСтроки = Суммы.ИдентификаторСтроки 
	|		И Суммы.СуммаБезНДСРегл <> 0
	|	
	|ГДЕ
	|	Операция.Склад.ЦеховаяКладовая
	|";

	ТекстОприходованиеТоваровСкладПроизводства = СтрШаблон(ТекстОприходованиеТоваровСкладПроизводства, 
		НСтр("ru='Оприходование товаров';uk='Оприбуткування товарів'",ЯзыкСодержания));
 
#КонецОбласти
	
	ТекстыОтражения = Новый Массив;
	ТекстыОтражения.Добавить(ТекстОприходованиеТоваров);
	ТекстыОтражения.Добавить(ТекстОприходованиеТоваровСкладПроизводства);

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

//++ Локализация
//-- Локализация

#КонецОбласти

#КонецОбласти
