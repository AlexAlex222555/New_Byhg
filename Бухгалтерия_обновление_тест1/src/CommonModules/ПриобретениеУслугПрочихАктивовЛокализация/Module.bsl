
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
	
	//++ Локализация
	//-- Локализация
	
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


//++ Локализация
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

	
#Область ТекстПоступлениеУслуг    // (Дт 23, 9X :: Кт 372, 63)
	ТекстПоступлениеУслуг = "
	|ВЫБРАТЬ // Поступление услуг (Дт 23, 9X :: Кт 372, 63)
	|
	|	Операция.Ссылка КАК Ссылка,
	|	Операция.Дата КАК Период,
	|	Операция.Организация КАК Организация,
	|	НЕОПРЕДЕЛЕНО КАК ИдентификаторСтроки,
	|
	|	(ВЫБОР
	|		КОГДА (НЕ Строки.НалоговоеНазначение.ВидДеятельностиНДС = ЗНАЧЕНИЕ(Перечисление.ВидыДеятельностиНДС.Необлагаемая)) ТОГДА
	|			ЕСТЬNULL(Суммы.СуммаБезНДСРегл, Строки.СуммаСНДС - Строки.СуммаНДС + Строки.СуммаНДСПропорционально)
	|		ИНАЧЕ
	|			ЕСТЬNULL(Суммы.СуммаБезНДСРегл + Суммы.СуммаНДСРегл, Строки.СуммаСНДС)
	|	КОНЕЦ) КАК Сумма,
	|	(ВЫБОР
	|		КОГДА (НЕ Строки.НалоговоеНазначение.ВидДеятельностиНДС = ЗНАЧЕНИЕ(Перечисление.ВидыДеятельностиНДС.Необлагаемая)) ТОГДА
	|			ЕСТЬNULL(Суммы.СуммаБезНДСУпрМУ, Строки.СуммаСНДС - Строки.СуммаНДС + Строки.СуммаНДСПропорционально)
	|		ИНАЧЕ     
	|			ЕСТЬNULL(Суммы.СуммаБезНДСУпрМУ + Суммы.СуммаНДСУпрМУ, Строки.СуммаСНДС)
	|	КОНЕЦ) КАК СуммаУУ,
	|
	|	ЗНАЧЕНИЕ(Перечисление.ВидыСчетовРеглУчета.Расходы) КАК ВидСчетаДт,
	|	Строки.СтатьяРасходов КАК АналитикаУчетаДт,
	|	Строки.Подразделение КАК МестоУчетаДт,
	|
	|	ЗНАЧЕНИЕ(Справочник.Валюты.ПустаяСсылка) КАК ВалютаДт,
	|	Строки.Подразделение КАК ПодразделениеДт,
	|	Строки.НаправлениеДеятельности КАК НаправлениеДеятельностиДт,
	|	НЕОПРЕДЕЛЕНО КАК НалоговоеНазначениеДт,
	|
	|	ЗНАЧЕНИЕ(ПланСчетов.Хозрасчетный.ПустаяСсылка) КАК СчетДт,
	|
    |	ЗНАЧЕНИЕ(Перечисление.ТипыЗатратРегл.Прочее) КАК СубконтоДт1,
	|	Строки.СтатьяРасходов КАК СубконтоДт2,
    |	Строки.АналитикаРасходов КАК СубконтоДт3,
	|	
	|	0 КАК ВалютнаяСуммаДт,
	|	Строки.Количество КАК КоличествоДт,
	|	0 КАК СуммаНУДт,
	|	0 КАК СуммаПРДт,
	|	0 КАК СуммаВРДт,
	|	
	|	(ВЫБОР КОГДА Операция.ХозяйственнаяОперация = ЗНАЧЕНИЕ(Перечисление.ХозяйственныеОперации.ЗакупкаЧерезПодотчетноеЛицо) ТОГДА НЕОПРЕДЕЛЕНО
	|		ИНАЧЕ ЗНАЧЕНИЕ(Перечисление.ВидыСчетовРеглУчета.РасчетыСПоставщиками) КОНЕЦ) КАК ВидСчетаКт,
	|	(ВЫБОР КОГДА Операция.ХозяйственнаяОперация = ЗНАЧЕНИЕ(Перечисление.ХозяйственныеОперации.ЗакупкаЧерезПодотчетноеЛицо) ТОГДА НЕОПРЕДЕЛЕНО
	|		ИНАЧЕ ЕСТЬNULL(Расчеты.ГруппаФинансовогоУчета, Операция.ГруппаФинансовогоУчета) КОНЕЦ) КАК АналитикаУчетаКт,
	|	НЕОПРЕДЕЛЕНО КАК МестоУчетаКт,
	|
	|	Операция.ВалютаВзаиморасчетов КАК ВалютаКт,
	|	ЕСТЬNULL(Расчеты.Подразделение, Операция.Подразделение) КАК ПодразделениеКт,
	|	ВЫБОР
	|		КОГДА Операция.ХозяйственнаяОперация = ЗНАЧЕНИЕ(Перечисление.ХозяйственныеОперации.ЗакупкаЧерезПодотчетноеЛицо) ТОГДА НЕОПРЕДЕЛЕНО
	|		ИНАЧЕ ЕСТЬNULL(Расчеты.НаправлениеДеятельности, Операция.НаправлениеДеятельности)
	|	КОНЕЦ КАК НаправлениеДеятельностиКт,
	|	НЕОПРЕДЕЛЕНО КАК НалоговоеНазначениеКт,
	|
	|	(ВЫБОР
	|		КОГДА Операция.ХозяйственнаяОперация = ЗНАЧЕНИЕ(Перечисление.ХозяйственныеОперации.ЗакупкаЧерезПодотчетноеЛицо) ТОГДА
	|			(ВЫБОР КОГДА Суммы.СуммаБезНДСРегл = Суммы.СуммаБезНДС ТОГДА ЗНАЧЕНИЕ(ПланСчетов.Хозрасчетный.РасчетыСПодотчетнымиЛицамиВНациональнойВалюте)
	|				ИНАЧЕ ЗНАЧЕНИЕ(ПланСчетов.Хозрасчетный.РасчетыСПодотчетнымиЛицамиВИностраннойВалюте) КОНЕЦ)
	|		ИНАЧЕ НЕОПРЕДЕЛЕНО КОНЕЦ) КАК СчетКт,
	|	(ВЫБОР КОГДА Операция.ХозяйственнаяОперация = ЗНАЧЕНИЕ(Перечисление.ХозяйственныеОперации.ЗакупкаЧерезПодотчетноеЛицо) ТОГДА Операция.ПодотчетноеЛицо
	|		ИНАЧЕ Расчеты.Контрагент КОНЕЦ) КАК СубконтоКт1,
	|	(ВЫБОР КОГДА Операция.ХозяйственнаяОперация = ЗНАЧЕНИЕ(Перечисление.ХозяйственныеОперации.ЗакупкаЧерезПодотчетноеЛицо) ТОГДА НЕОПРЕДЕЛЕНО
	|		ИНАЧЕ Расчеты.Договор КОНЕЦ) КАК СубконтоКт2,
	|	НЕОПРЕДЕЛЕНО КАК СубконтоКт3,
	|
	|	(ВЫБОР
	|		КОГДА (НЕ Строки.НалоговоеНазначение.ВидДеятельностиНДС = ЗНАЧЕНИЕ(Перечисление.ВидыДеятельностиНДС.Необлагаемая)) ТОГДА
	|			Строки.СуммаВзаиморасчетов - Строки.СуммаНДСВзаиморасчетов
	|		ИНАЧЕ
	|			Строки.СуммаВзаиморасчетов
	|	КОНЕЦ) КАК ВалютнаяСуммаКт,
	|	0 КАК КоличествоКт,
	|	0 КАК СуммаНУКт,
	|	0 КАК СуммаПРКт,
	|	0 КАК СуммаВРКт,
	|	""%1"" КАК Содержание
	|ИЗ
	|	ДокументыКОтражению КАК ДокументыКОтражению
	|	
	|	ВНУТРЕННЕЕ СОЕДИНЕНИЕ
	|		Документ.ПриобретениеУслугПрочихАктивов КАК Операция
	|	ПО
	|		ДокументыКОтражению.Ссылка = Операция.Ссылка
	|
	|	ВНУТРЕННЕЕ СОЕДИНЕНИЕ
	|		Документ.ПриобретениеУслугПрочихАктивов.Расходы КАК Строки
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
	|		ПланВидовХарактеристик.СтатьиРасходов КАК СтатьиСтроительства
	|	ПО
	|		Строки.СтатьяРасходов = СтатьиСтроительства.Ссылка
	|		И СтатьиСтроительства.ВариантРаспределенияРасходовРегл = ЗНАЧЕНИЕ(Перечисление.ВариантыРаспределенияРасходов.НаВнеоборотныеАктивы)
	|	
	|	ЛЕВОЕ СОЕДИНЕНИЕ
	|		ПланВидовХарактеристик.СтатьиРасходов КАК СтатьиНаПрочиеАктивы
	|	ПО
	|		Строки.СтатьяРасходов = СтатьиНаПрочиеАктивы.Ссылка
	|		И СтатьиНаПрочиеАктивы.ВариантРаспределенияРасходовРегл = ЗНАЧЕНИЕ(Перечисление.ВариантыРаспределенияРасходов.НаПрочиеАктивы)
	|
	|	ЛЕВОЕ СОЕДИНЕНИЕ
	|		ВТРасчетыСПоставщиками КАК Расчеты
	|	ПО 
	|		Расчеты.Ссылка = Операция.Ссылка
	|
	|	ЛЕВОЕ СОЕДИНЕНИЕ 
	|		Справочник.ОбъектыСтроительства КАК ОбъектыСтроительства
	|	ПО 
	|		ОбъектыСтроительства.Ссылка = Строки.АналитикаРасходов
	|ГДЕ
	|	Операция.ХозяйственнаяОперация В (
	|		ЗНАЧЕНИЕ(Перечисление.ХозяйственныеОперации.ЗакупкаУПоставщика),
	|		ЗНАЧЕНИЕ(Перечисление.ХозяйственныеОперации.ЗакупкаЧерезПодотчетноеЛицо)
	|	)
	|	И СтатьиНаПрочиеАктивы.Ссылка ЕСТЬ NULL
	|	И ТИПЗНАЧЕНИЯ(Строки.СтатьяРасходов) = ТИП(ПланВидовХарактеристик.СтатьиРасходов)
	|";

	ТекстПоступлениеУслуг = СтрШаблон(ТекстПоступлениеУслуг, 
		НСтр("ru='Поступление услуг';uk='Надходження послуг'",ЯзыкСодержания));
	ТекстыОтражения.Добавить(ТекстПоступлениеУслуг);   
	
#КонецОбласти

#Область ТекстПоступлениеПрочее   // (Дт <ХХ.ХХ> :: Кт Кт 372, 63)

	// Поддержка статей расходов с устаревшим направлением распределения "НаПрочиеАктивы".
	ТекстПоступлениеПрочее = "
	|ВЫБРАТЬ // Поступление на прочие активы (Дт <ХХ.ХХ> :: Кт Кт 372, 63)
	|
	|	Операция.Ссылка КАК Ссылка,
	|	Операция.Дата КАК Период,
	|	Операция.Организация КАК Организация,
	|	"""" КАК ИдентификаторСтроки,
	|
	|	(ВЫБОР
	|		КОГДА (НЕ Строки.НалоговоеНазначение.ВидДеятельностиНДС = ЗНАЧЕНИЕ(Перечисление.ВидыДеятельностиНДС.Необлагаемая)) ТОГДА
	|			ЕСТЬNULL(Суммы.СуммаБезНДСРегл, Строки.СуммаСНДС - Строки.СуммаНДС + Строки.СуммаНДСПропорционально)
	|		ИНАЧЕ
	|			ЕСТЬNULL(Суммы.СуммаБезНДСРегл + Суммы.СуммаНДСРегл, Строки.СуммаСНДС)
	|	КОНЕЦ) КАК Сумма,
	|	(ВЫБОР
	|		КОГДА (НЕ Строки.НалоговоеНазначение.ВидДеятельностиНДС = ЗНАЧЕНИЕ(Перечисление.ВидыДеятельностиНДС.Необлагаемая)) ТОГДА 
	|			ЕСТЬNULL(Суммы.СуммаБезНДСУпрМУ, Строки.СуммаСНДС - Строки.СуммаНДС + Строки.СуммаНДСПропорционально)
	|		ИНАЧЕ
	|			ЕСТЬNULL(Суммы.СуммаБезНДСУпрМУ + Суммы.СуммаНДСУпрМУ, Строки.СуммаСНДС)
	|	КОНЕЦ) КАК СуммаУУ,
	|
	|	ЗНАЧЕНИЕ(Перечисление.ВидыСчетовРеглУчета.ПрочиеОперации) КАК ВидСчетаДт,
	|	НЕОПРЕДЕЛЕНО КАК АналитикаУчетаДт,
	|	НЕОПРЕДЕЛЕНО КАК МестоУчетаДт,
	|
	|	Операция.ВалютаВзаиморасчетов КАК ВалютаДт,
	|	Строки.Подразделение КАК ПодразделениеДт,
	|	Строки.НаправлениеДеятельности КАК НаправлениеДеятельностиДт,
	|	НЕОПРЕДЕЛЕНО КАК НалоговоеНазначениеДт,
	|
	|	ЗНАЧЕНИЕ(ПланСчетов.Хозрасчетный.ПустаяСсылка) КАК СчетДт,
	|
	|	НЕОПРЕДЕЛЕНО КАК СубконтоДт1,
	|	НЕОПРЕДЕЛЕНО КАК СубконтоДт2,
	|	НЕОПРЕДЕЛЕНО КАК СубконтоДт3,
	|
	|	(ВЫБОР
	|		КОГДА (НЕ Строки.НалоговоеНазначение.ВидДеятельностиНДС = ЗНАЧЕНИЕ(Перечисление.ВидыДеятельностиНДС.Необлагаемая)) ТОГДА
	|			Строки.СуммаВзаиморасчетов - Строки.СуммаНДСВзаиморасчетов
	|		ИНАЧЕ
	|			Строки.СуммаВзаиморасчетов
	|	КОНЕЦ) КАК ВалютнаяСуммаДт,
	|	Строки.Количество КАК КоличествоДт,
	|	0 КАК СуммаНУДт,
	|	0 КАК СуммаПРДт,
	|	0 КАК СуммаВРДт,
	|
	|	(ВЫБОР КОГДА Операция.ХозяйственнаяОперация = ЗНАЧЕНИЕ(Перечисление.ХозяйственныеОперации.ЗакупкаЧерезПодотчетноеЛицо) ТОГДА НЕОПРЕДЕЛЕНО
	|		ИНАЧЕ ЗНАЧЕНИЕ(Перечисление.ВидыСчетовРеглУчета.РасчетыСПоставщиками) КОНЕЦ) КАК ВидСчетаКт,
	|	(ВЫБОР КОГДА Операция.ХозяйственнаяОперация = ЗНАЧЕНИЕ(Перечисление.ХозяйственныеОперации.ЗакупкаЧерезПодотчетноеЛицо) ТОГДА НЕОПРЕДЕЛЕНО
	|		ИНАЧЕ ЕСТЬNULL(Расчеты.ГруппаФинансовогоУчета, Операция.ГруппаФинансовогоУчета) КОНЕЦ) КАК АналитикаУчетаКт,
	|	НЕОПРЕДЕЛЕНО КАК МестоУчетаКт,
	|
	|	Операция.ВалютаВзаиморасчетов КАК ВалютаКт,
	|	ЕСТЬNULL(Расчеты.Подразделение, Операция.Подразделение) КАК ПодразделениеКт,
	|	ВЫБОР
	|		КОГДА Операция.ХозяйственнаяОперация = ЗНАЧЕНИЕ(Перечисление.ХозяйственныеОперации.ЗакупкаЧерезПодотчетноеЛицо) ТОГДА НЕОПРЕДЕЛЕНО
	|		ИНАЧЕ ЕСТЬNULL(Расчеты.НаправлениеДеятельности, Операция.НаправлениеДеятельности)
	|	КОНЕЦ КАК НаправлениеДеятельностиКт,
	|	НЕОПРЕДЕЛЕНО КАК НалоговоеНазначениеКт,
	|
	|	(ВЫБОР
	|		КОГДА Операция.ХозяйственнаяОперация = ЗНАЧЕНИЕ(Перечисление.ХозяйственныеОперации.ЗакупкаЧерезПодотчетноеЛицо) ТОГДА
	|			(ВЫБОР КОГДА Суммы.СуммаБезНДСРегл = Суммы.СуммаБезНДС ТОГДА ЗНАЧЕНИЕ(ПланСчетов.Хозрасчетный.РасчетыСПодотчетнымиЛицамиВНациональнойВалюте)
	|				ИНАЧЕ ЗНАЧЕНИЕ(ПланСчетов.Хозрасчетный.РасчетыСПодотчетнымиЛицамиВИностраннойВалюте) КОНЕЦ)
	|		ИНАЧЕ НЕОПРЕДЕЛЕНО КОНЕЦ) КАК СчетКт,
	|	(ВЫБОР КОГДА Операция.ХозяйственнаяОперация = ЗНАЧЕНИЕ(Перечисление.ХозяйственныеОперации.ЗакупкаЧерезПодотчетноеЛицо) ТОГДА Операция.ПодотчетноеЛицо
	|		ИНАЧЕ Расчеты.Контрагент КОНЕЦ) КАК СубконтоКт1,
	|	(ВЫБОР КОГДА Операция.ХозяйственнаяОперация = ЗНАЧЕНИЕ(Перечисление.ХозяйственныеОперации.ЗакупкаЧерезПодотчетноеЛицо) ТОГДА НЕОПРЕДЕЛЕНО
	|		ИНАЧЕ Расчеты.Договор КОНЕЦ) КАК СубконтоКт2,
	|	НЕОПРЕДЕЛЕНО КАК СубконтоКт3,
	|                 
	|	(ВЫБОР
	|		КОГДА (НЕ Строки.НалоговоеНазначение.ВидДеятельностиНДС = ЗНАЧЕНИЕ(Перечисление.ВидыДеятельностиНДС.Необлагаемая)) ТОГДА
	|			Строки.СуммаВзаиморасчетов - Строки.СуммаНДСВзаиморасчетов
	|		ИНАЧЕ
	|			Строки.СуммаВзаиморасчетов
	|	КОНЕЦ) КАК ВалютнаяСуммаКт,
	|	0 КАК КоличествоКт,
	|	0 КАК СуммаНУКт,
	|	0 КАК СуммаПРКт,
	|	0 КАК СуммаВРКт,
	|	""%1"" КАК Содержание
	|ИЗ
	|	ДокументыКОтражению КАК ДокументыКОтражению
	|	
	|	ВНУТРЕННЕЕ СОЕДИНЕНИЕ
	|		Документ.ПриобретениеУслугПрочихАктивов КАК Операция
	|	ПО
	|		ДокументыКОтражению.Ссылка = Операция.Ссылка
	|
	|	ВНУТРЕННЕЕ СОЕДИНЕНИЕ
	|		Документ.ПриобретениеУслугПрочихАктивов.Расходы КАК Строки
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
	|	ВНУТРЕННЕЕ СОЕДИНЕНИЕ
	|		ПланВидовХарактеристик.СтатьиРасходов КАК СтатьиПрочихОпераций
	|	ПО
	|		Строки.СтатьяРасходов = СтатьиПрочихОпераций.Ссылка
	|		И СтатьиПрочихОпераций.ВариантРаспределенияРасходовРегл = ЗНАЧЕНИЕ(Перечисление.ВариантыРаспределенияРасходов.НаПрочиеАктивы)
	|	
	|	ЛЕВОЕ СОЕДИНЕНИЕ
	|		ВТРасчетыСПоставщиками КАК Расчеты
	|	ПО
	|		Расчеты.Ссылка = Операция.Ссылка
	|
	|ГДЕ
	|	Операция.ХозяйственнаяОперация В (
	|		ЗНАЧЕНИЕ(Перечисление.ХозяйственныеОперации.ЗакупкаУПоставщика),
	|		ЗНАЧЕНИЕ(Перечисление.ХозяйственныеОперации.ЗакупкаЧерезПодотчетноеЛицо)
	|	)
	|";
 
 	ТекстПоступлениеПрочее = СтрШаблон(ТекстПоступлениеПрочее, 
 		НСтр("ru='Поступление на прочие активы';uk='Надходження на інші активи'",ЯзыкСодержания));

	ТекстПоступлениеПрочееНаСтатьиПрочихАктивов = "
	|ВЫБРАТЬ // Поступление на прочие активы (Дт <ХХ.ХХ> :: Кт Кт 372, 63)
	|
	|	Операция.Ссылка КАК Ссылка,
	|	Операция.Дата КАК Период,
	|	Операция.Организация КАК Организация,
	|	Строки.НомерСтроки КАК ИдентификаторСтроки,
	|
	|	(ВЫБОР
	|		КОГДА (НЕ Строки.НалоговоеНазначение.ВидДеятельностиНДС = ЗНАЧЕНИЕ(Перечисление.ВидыДеятельностиНДС.Необлагаемая)) ТОГДА
	|			ЕСТЬNULL(Суммы.СуммаБезНДСРегл, Строки.СуммаСНДС - Строки.СуммаНДС + Строки.СуммаНДСПропорционально)
	|		ИНАЧЕ
	|			ЕСТЬNULL(Суммы.СуммаБезНДСРегл + Суммы.СуммаНДСРегл, Строки.СуммаСНДС)
	|	КОНЕЦ) КАК Сумма,
	|	(ВЫБОР
	|		КОГДА (НЕ Строки.НалоговоеНазначение.ВидДеятельностиНДС = ЗНАЧЕНИЕ(Перечисление.ВидыДеятельностиНДС.Необлагаемая)) ТОГДА 
	|			ЕСТЬNULL(Суммы.СуммаБезНДСУпрМУ, Строки.СуммаСНДС - Строки.СуммаНДС + Строки.СуммаНДСПропорционально)
	|		ИНАЧЕ     
	|			ЕСТЬNULL(Суммы.СуммаБезНДСУпрМУ + Суммы.СуммаНДСУпрМУ, Строки.СуммаСНДС)
	|	КОНЕЦ) КАК СуммаУУ,
	|
	|	ЗНАЧЕНИЕ(Перечисление.ВидыСчетовРеглУчета.ПрочиеАктивыПассивы) КАК ВидСчетаДт,
	|	НЕОПРЕДЕЛЕНО КАК АналитикаУчетаДт,
	|	НЕОПРЕДЕЛЕНО КАК МестоУчетаДт,
	|
	|	Операция.ВалютаВзаиморасчетов КАК ВалютаДт,
	|	Строки.Подразделение КАК ПодразделениеДт,
	|	Строки.НаправлениеДеятельности КАК НаправлениеДеятельностиДт,
	|	НЕОПРЕДЕЛЕНО КАК НалоговоеНазначениеДт,
	|
	|	Строки.СчетУчета КАК СчетДт,
	|
	|	Строки.Субконто1 КАК СубконтоДт1,
	|	Строки.Субконто2 КАК СубконтоДт2,
	|	Строки.Субконто3 КАК СубконтоДт3,
	|
	|	(ВЫБОР
	|		КОГДА ( НЕ Строки.НалоговоеНазначение.ВидДеятельностиНДС = ЗНАЧЕНИЕ(Перечисление.ВидыДеятельностиНДС.Необлагаемая)) ТОГДА
	|			Строки.СуммаВзаиморасчетов - Строки.СуммаНДСВзаиморасчетов
	|		ИНАЧЕ
	|			Строки.СуммаВзаиморасчетов
	|	КОНЕЦ) КАК ВалютнаяСуммаДт,
	|	Строки.Количество КАК КоличествоДт,
	|	0 КАК СуммаНУДт,
	|	0 КАК СуммаПРДт,
	|	0 КАК СуммаВРДт,
	|
	|	(ВЫБОР КОГДА Операция.ХозяйственнаяОперация = ЗНАЧЕНИЕ(Перечисление.ХозяйственныеОперации.ЗакупкаЧерезПодотчетноеЛицо) ТОГДА НЕОПРЕДЕЛЕНО
	|		ИНАЧЕ ЗНАЧЕНИЕ(Перечисление.ВидыСчетовРеглУчета.РасчетыСПоставщиками) КОНЕЦ) КАК ВидСчетаКт,
	|	(ВЫБОР КОГДА Операция.ХозяйственнаяОперация = ЗНАЧЕНИЕ(Перечисление.ХозяйственныеОперации.ЗакупкаЧерезПодотчетноеЛицо) ТОГДА НЕОПРЕДЕЛЕНО
	|		ИНАЧЕ ЕСТЬNULL(Расчеты.ГруппаФинансовогоУчета, Операция.ГруппаФинансовогоУчета) КОНЕЦ) КАК АналитикаУчетаКт,
	|	НЕОПРЕДЕЛЕНО КАК МестоУчетаКт,
	|
	|	Операция.ВалютаВзаиморасчетов КАК ВалютаКт,
	|	ЕСТЬNULL(Расчеты.Подразделение, Операция.Подразделение) КАК ПодразделениеКт,
	|	ВЫБОР
	|		КОГДА Операция.ХозяйственнаяОперация = ЗНАЧЕНИЕ(Перечисление.ХозяйственныеОперации.ЗакупкаЧерезПодотчетноеЛицо) ТОГДА НЕОПРЕДЕЛЕНО
	|		ИНАЧЕ ЕСТЬNULL(Расчеты.НаправлениеДеятельности, Операция.НаправлениеДеятельности)
	|	КОНЕЦ КАК НаправлениеДеятельностиКт,
	|	НЕОПРЕДЕЛЕНО КАК НалоговоеНазначениеКт,
	|
	|	(ВЫБОР
	|		КОГДА Операция.ХозяйственнаяОперация = ЗНАЧЕНИЕ(Перечисление.ХозяйственныеОперации.ЗакупкаЧерезПодотчетноеЛицо) ТОГДА
	|			(ВЫБОР КОГДА Суммы.СуммаБезНДСРегл = Суммы.СуммаБезНДС ТОГДА ЗНАЧЕНИЕ(ПланСчетов.Хозрасчетный.РасчетыСПодотчетнымиЛицамиВНациональнойВалюте)
	|				ИНАЧЕ ЗНАЧЕНИЕ(ПланСчетов.Хозрасчетный.РасчетыСПодотчетнымиЛицамиВИностраннойВалюте) КОНЕЦ)
	|		ИНАЧЕ НЕОПРЕДЕЛЕНО КОНЕЦ) КАК СчетКт,
	|	(ВЫБОР КОГДА Операция.ХозяйственнаяОперация = ЗНАЧЕНИЕ(Перечисление.ХозяйственныеОперации.ЗакупкаЧерезПодотчетноеЛицо) ТОГДА Операция.ПодотчетноеЛицо
	|		ИНАЧЕ Расчеты.Контрагент КОНЕЦ) КАК СубконтоКт1,
	|	(ВЫБОР КОГДА Операция.ХозяйственнаяОперация = ЗНАЧЕНИЕ(Перечисление.ХозяйственныеОперации.ЗакупкаЧерезПодотчетноеЛицо) ТОГДА НЕОПРЕДЕЛЕНО
	|		ИНАЧЕ Расчеты.Договор КОНЕЦ) КАК СубконтоКт2,
	|	НЕОПРЕДЕЛЕНО КАК СубконтоКт3,
	|
	|	(ВЫБОР
	|		КОГДА (НЕ Строки.НалоговоеНазначение.ВидДеятельностиНДС = ЗНАЧЕНИЕ(Перечисление.ВидыДеятельностиНДС.Необлагаемая)) ТОГДА
	|			Строки.СуммаВзаиморасчетов - Строки.СуммаНДСВзаиморасчетов
	|		ИНАЧЕ
	|			Строки.СуммаВзаиморасчетов
	|	КОНЕЦ) КАК ВалютнаяСуммаКт,
	|	0 КАК КоличествоКт,
	|	0 КАК СуммаНУКт,
	|	0 КАК СуммаПРКт,
	|	0 КАК СуммаВРКт,
	|	""%1"" КАК Содержание
	|ИЗ
	|	ДокументыКОтражению КАК ДокументыКОтражению
	|	
	|	ВНУТРЕННЕЕ СОЕДИНЕНИЕ
	|		Документ.ПриобретениеУслугПрочихАктивов КАК Операция
	|	ПО
	|		ДокументыКОтражению.Ссылка = Операция.Ссылка
	|
	|	ВНУТРЕННЕЕ СОЕДИНЕНИЕ
	|		Документ.ПриобретениеУслугПрочихАктивов.Расходы КАК Строки
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
	|	Операция.ХозяйственнаяОперация = ЗНАЧЕНИЕ(Перечисление.ХозяйственныеОперации.ЗакупкаУПоставщика)
	|	И ТИПЗНАЧЕНИЯ(Строки.СтатьяРасходов) = ТИП(ПланВидовХарактеристик.СтатьиАктивовПассивов) 
	|";
 	ТекстПоступлениеПрочееНаСтатьиПрочихАктивов = СтрШаблон(ТекстПоступлениеПрочееНаСтатьиПрочихАктивов, 
 		НСтр("ru='Поступление на прочие активы';uk='Надходження на інші активи'",ЯзыкСодержания));

	ТекстыОтражения.Добавить(ТекстПоступлениеПрочее);
	ТекстыОтражения.Добавить(ТекстПоступлениеПрочееНаСтатьиПрочихАктивов);  
	
#КонецОбласти

#Область ТекстПоступлениеНДСОжидаемый // (Дт 6442 :: Кт 372, 63)
	ТекстПоступлениеНДСОжидаемый = "
	|ВЫБРАТЬ //// НДС при приобретении (Дт 6442 :: Кт 372, 63)
	|
	|	Операция.Ссылка КАК Ссылка,
	// Период, Организация, ИдентификаторСтроки 
	|	Операция.Дата КАК Период,
	|	Операция.Организация КАК Организация,
	|	НЕОПРЕДЕЛЕНО КАК ИдентификаторСтроки,
	|
	// Сумма  
	|	СУММА(ЕСТЬNULL(Суммы.СуммаНДСРегл, Строки.СуммаНДС - Строки.СуммаНДСПропорционально)) КАК Сумма,
	|	СУММА(ЕСТЬNULL(Суммы.СуммаНДСУпр, Строки.СуммаНДС - Строки.СуммаНДСПропорционально)) КАК СуммаУУ,
	|
	// ДТ - Вид счета, Аналитика учета, Место учета
	|	НЕОПРЕДЕЛЕНО КАК ВидСчетаДт,
	|	НЕОПРЕДЕЛЕНО КАК АналитикаУчетаДт,
	|	НЕОПРЕДЕЛЕНО КАК МестоУчетаДт, 
	|
	// ДТ - Валюта, Подразделение, Счет
	|	НЕОПРЕДЕЛЕНО КАК ВалютаДт,
	|	НЕОПРЕДЕЛЕНО КАК ПодразделениеДт,
	|	ЗНАЧЕНИЕ(Справочник.НаправленияДеятельности.ПустаяСсылка) КАК НаправлениеДеятельностиДт,
	|	НЕОПРЕДЕЛЕНО КАК НалоговоеНазначениеДт,
	|
	|	ЗНАЧЕНИЕ(ПланСчетов.Хозрасчетный.НалоговыйКредитНеподтвержденный) КАК СчетДт,
	|	
	// ДТ - Субконто
	|	Операция.Контрагент КАК СубконтоДт1,
	|	Операция.Договор КАК СубконтоДт2,
	|	НЕОПРЕДЕЛЕНО КАК СубконтоДт3,
	|	
	// ДТ - Валютная сумма, Количество, Суммы ПР,ВР,НУ
	|	0 КАК ВалютнаяСуммаДт,
	|	0 КАК КоличествоДт,
	|	0 КАК СуммаНУДт,
	|	0 КАК СуммаПРДт,
	|	0 КАК СуммаВРДт,
	|	
	// КТ - Вид счета, Аналитика учета, Место учета
	|	ВЫБОР КОГДА Операция.ХозяйственнаяОперация = ЗНАЧЕНИЕ(Перечисление.ХозяйственныеОперации.ЗакупкаЧерезПодотчетноеЛицо) ТОГДА
	|		НЕОПРЕДЕЛЕНО
	|	ИНАЧЕ
	|		ЗНАЧЕНИЕ(Перечисление.ВидыСчетовРеглУчета.РасчетыСПоставщиками)
	|	КОНЕЦ КАК ВидСчетаКт,
	|	ВЫБОР КОГДА Операция.ХозяйственнаяОперация = ЗНАЧЕНИЕ(Перечисление.ХозяйственныеОперации.ЗакупкаЧерезПодотчетноеЛицо) ТОГДА
	|		НЕОПРЕДЕЛЕНО
	|	ИНАЧЕ
	|		ЕСТЬNULL(Расчеты.ГруппаФинансовогоУчета, Операция.ГруппаФинансовогоУчета)
	|	КОНЕЦ КАК АналитикаУчетаКт,
	|	НЕОПРЕДЕЛЕНО КАК МестоУчетаКт,
	|
	// КТ - Валюта, Подразделение, Счет
	|	Операция.ВалютаВзаиморасчетов КАК ВалютаКт,
	|	ЕСТЬNULL(Расчеты.Подразделение, Операция.Подразделение) КАК ПодразделениеКт,
	|	ВЫБОР 
	|		КОГДА Операция.ХозяйственнаяОперация = ЗНАЧЕНИЕ(Перечисление.ХозяйственныеОперации.ЗакупкаЧерезПодотчетноеЛицо) ТОГДА НЕОПРЕДЕЛЕНО
	|		ИНАЧЕ ЕСТЬNULL(Расчеты.НаправлениеДеятельности, Операция.НаправлениеДеятельности)
	|	КОНЕЦ КАК НаправлениеДеятельностиКт,
	|	НЕОПРЕДЕЛЕНО КАК НалоговоеНазначениеКт,
	|
	|	ВЫБОР КОГДА Операция.ХозяйственнаяОперация = ЗНАЧЕНИЕ(Перечисление.ХозяйственныеОперации.ЗакупкаЧерезПодотчетноеЛицо) ТОГДА
	|		ВЫБОР КОГДА Суммы.СуммаБезНДСРегл = Суммы.СуммаБезНДС ТОГДА
	|			ЗНАЧЕНИЕ(ПланСчетов.Хозрасчетный.РасчетыСПодотчетнымиЛицамиВНациональнойВалюте)
	|		ИНАЧЕ
	|			ЗНАЧЕНИЕ(ПланСчетов.Хозрасчетный.РасчетыСПодотчетнымиЛицамиВИностраннойВалюте)
	|		КОНЕЦ
	|	ИНАЧЕ
	|		НЕОПРЕДЕЛЕНО
	|	КОНЕЦ КАК СчетКт,
	|	
	// КТ - Субконто
	|	ВЫБОР КОГДА Операция.ХозяйственнаяОперация = ЗНАЧЕНИЕ(Перечисление.ХозяйственныеОперации.ЗакупкаЧерезПодотчетноеЛицо) ТОГДА
	|		Операция.ПодотчетноеЛицо
	|	ИНАЧЕ
	|		Операция.Контрагент
	|	КОНЕЦ КАК СубконтоКт1,
	|	ВЫБОР КОГДА Операция.ХозяйственнаяОперация = ЗНАЧЕНИЕ(Перечисление.ХозяйственныеОперации.ЗакупкаЧерезПодотчетноеЛицо) ТОГДА
	|		НЕОПРЕДЕЛЕНО
	|	ИНАЧЕ
	|		Операция.Договор
	|	КОНЕЦ КАК СубконтоКт2,
	|	НЕОПРЕДЕЛЕНО КАК СубконтоКт3,
	|	
	// КТ - Валютная сумма, Количество, Суммы ПР,ВР,НУ
	|	СУММА(Строки.СуммаНДСВзаиморасчетов) КАК ВалютнаяСуммаКт,
	|	0 КАК КоличествоКт,
	|	0 КАК СуммаНУКт,
	|	0 КАК СуммаПРКт,
	|	0 КАК СуммаВРКт,
	|	""%1"" КАК Содержание
	|
	|ИЗ
	|	ДокументыКОтражению КАК ДокументыКОтражению
	|	
	|	ВНУТРЕННЕЕ СОЕДИНЕНИЕ
	|		Документ.ПриобретениеУслугПрочихАктивов КАК Операция
	|	ПО
	|		ДокументыКОтражению.Ссылка = Операция.Ссылка
	|	
	|	ВНУТРЕННЕЕ СОЕДИНЕНИЕ 
	|		Документ.ПриобретениеУслугПрочихАктивов.Расходы КАК Строки
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
	|		ПланВидовХарактеристик.СтатьиРасходов КАК Статьи
	|	ПО
	|		Строки.СтатьяРасходов = Статьи.Ссылка
	|	
	|	ЛЕВОЕ СОЕДИНЕНИЕ
	|		ВТРасчетыСПоставщиками КАК Расчеты
	|	ПО 
	|		Расчеты.Ссылка = Операция.Ссылка
	|ГДЕ
	|	(НЕ Строки.НалоговоеНазначение.ВидДеятельностиНДС = ЗНАЧЕНИЕ(Перечисление.ВидыДеятельностиНДС.Необлагаемая))
	|	И Операция.ХозяйственнаяОперация В (ЗНАЧЕНИЕ(Перечисление.ХозяйственныеОперации.ЗакупкаУПоставщика),
	|										ЗНАЧЕНИЕ(Перечисление.ХозяйственныеОперации.ЗакупкаУПоставщикаРеглУчет),
	|										ЗНАЧЕНИЕ(Перечисление.ХозяйственныеОперации.ЗакупкаЧерезПодотчетноеЛицо))
	|СГРУППИРОВАТЬ ПО
	|	Операция.Ссылка,
	|	ВЫБОР КОГДА Операция.ХозяйственнаяОперация = ЗНАЧЕНИЕ(Перечисление.ХозяйственныеОперации.ЗакупкаЧерезПодотчетноеЛицо) ТОГДА
	|		НЕОПРЕДЕЛЕНО
	|	ИНАЧЕ
	|		ЕСТЬNULL(Расчеты.ГруппаФинансовогоУчета, Операция.ГруппаФинансовогоУчета)
	|	КОНЕЦ,
	|	ЕСТЬNULL(Расчеты.Подразделение, Операция.Подразделение),
	|	ВЫБОР КОГДА Статьи.ВариантРаспределенияРасходовРегл = ЗНАЧЕНИЕ(Перечисление.ВариантыРаспределенияРасходов.НаВнеоборотныеАктивы) ТОГДА
	|		Строки.АналитикаРасходов
	|	ИНАЧЕ
	|		НЕОПРЕДЕЛЕНО
	|	КОНЕЦ,
	|	ВЫБОР КОГДА Операция.ХозяйственнаяОперация = ЗНАЧЕНИЕ(Перечисление.ХозяйственныеОперации.ЗакупкаЧерезПодотчетноеЛицо) ТОГДА
	|		ВЫБОР КОГДА Суммы.СуммаБезНДСРегл = Суммы.СуммаБезНДС ТОГДА
	|			ЗНАЧЕНИЕ(ПланСчетов.Хозрасчетный.РасчетыСПодотчетнымиЛицамиВНациональнойВалюте)
	|		ИНАЧЕ
	|			ЗНАЧЕНИЕ(ПланСчетов.Хозрасчетный.РасчетыСПодотчетнымиЛицамиВИностраннойВалюте)
	|		КОНЕЦ
	|	ИНАЧЕ
	|		НЕОПРЕДЕЛЕНО
	|	КОНЕЦ,
	|	ВЫБОР 
	|		КОГДА Операция.ХозяйственнаяОперация = ЗНАЧЕНИЕ(Перечисление.ХозяйственныеОперации.ЗакупкаЧерезПодотчетноеЛицо) ТОГДА НЕОПРЕДЕЛЕНО
	|		ИНАЧЕ ЕСТЬNULL(Расчеты.НаправлениеДеятельности, Операция.НаправлениеДеятельности)
	|	КОНЕЦ
	|";

	ТекстПоступлениеНДСОжидаемый = СтрШаблон(ТекстПоступлениеНДСОжидаемый, 
		НСтр("ru='НДС: налоговый кредит не подтвержденный';uk='ПДВ: податковий кредит, не підтверджений'",ЯзыкСодержания));
	
	ТекстыОтражения.Добавить(ТекстПоступлениеНДСОжидаемый);

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
	
	Возврат "";
	
КонецФункции

#КонецОбласти
//-- НЕ УТ

//++ Локализация
//-- Локализация

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
	ТекстЗапросаТаблицаПорядокОтраженияПрочихОпераций(Запрос, ТекстыЗапроса, Регистры);
	ТекстЗапросаТаблицаОтражениеДокументовВРеглУчете(Запрос, ТекстыЗапроса, Регистры);
	//-- НЕ УТ
	//-- Локализация
	
КонецПроцедуры
//++ Локализация
//++ НЕ УТ

Функция ТекстЗапросаТаблицаПорядокОтраженияПрочихОпераций(Запрос, ТекстыЗапроса, Регистры)
	
	ИмяРегистра = "ПорядокОтраженияПрочихОпераций";
	
	Если НЕ ПроведениеДокументов.ТребуетсяТаблицаДляДвижений(ИмяРегистра, Регистры) Тогда
		Возврат "";
	КонецЕсли; 
	
	ТекстЗапроса = "
	|ВЫБРАТЬ ПЕРВЫЕ 1
	|	&Период			КАК Дата,
	|	&Организация	КАК Организация,
	|	&Ссылка			КАК Документ,
	|	""""			КАК ИдентификаторСтроки
	|ИЗ
	|	Документ.ПриобретениеУслугПрочихАктивов.Расходы КАК Строки
	|
	|	ВНУТРЕННЕЕ СОЕДИНЕНИЕ
	|		ПланВидовХарактеристик.СтатьиРасходов КАК СтатьиПрочихОпераций
	|	ПО
	|		Строки.СтатьяРасходов = СтатьиПрочихОпераций.Ссылка
	|		И СтатьиПрочихОпераций.ВариантРаспределенияРасходовРегл = ЗНАЧЕНИЕ(Перечисление.ВариантыРаспределенияРасходов.НаПрочиеАктивы)
	|		И СтатьиПрочихОпераций.ВидЦенности = ЗНАЧЕНИЕ(Перечисление.ВидыЦенностей.ПрочиеРаботыИУслуги)
	|
	|ГДЕ
	|	Строки.Ссылка = &Ссылка
	|	И &ХозяйственнаяОперация = ЗНАЧЕНИЕ(Перечисление.ХозяйственныеОперации.ЗакупкаУПоставщика)
	|";
	
	ТекстыЗапроса.Добавить(ТекстЗапроса, ИмяРегистра);
	Возврат ТекстЗапроса;
	
КонецФункции

Функция ТекстЗапросаТаблицаОтражениеДокументовВРеглУчете(Запрос, ТекстыЗапроса, Регистры)
	
	ИмяРегистра = "ОтражениеДокументовВРеглУчете";
	
	Если Не ПроведениеДокументов.ТребуетсяТаблицаДляДвижений(ИмяРегистра, Регистры) Тогда
		Возврат "";
	КонецЕсли; 
	
	Если Не ПроведениеДокументов.ЕстьТаблицаЗапроса("ВтПрочиеРасходы", ТекстыЗапроса) Тогда
		Документы.ПриобретениеУслугПрочихАктивов.ТекстЗапросаТаблицаВтПрочиеРасходы(Запрос, ТекстыЗапроса);
	КонецЕсли;
	
	Если Не ПроведениеДокументов.ЕстьТаблицаЗапроса("ВтПартииПрочихРасходов", ТекстыЗапроса) Тогда
		Документы.ПриобретениеУслугПрочихАктивов.ТекстЗапросаТаблицаВтПартииПрочихРасходов(Запрос, ТекстыЗапроса);
	КонецЕсли;
	
	ТекстЗапроса = "
	|ВЫБРАТЬ
	|	&Период                      КАК Период,
	|	&Организация                 КАК Организация,
	|	НАЧАЛОПЕРИОДА(&Период, ДЕНЬ) КАК ДатаОтражения
	|";
	ТекстЗапроса = ТекстЗапроса + "ОБЪЕДИНИТЬ ВСЕ"
		+ ДоходыИРасходыСервер.ДополнитьТекстЗапросаТаблицаОтражениеДокументовВРеглУчете();
	
	ТекстыЗапроса.Добавить(ТекстЗапроса, ИмяРегистра);
	
	Возврат ТекстЗапроса;
	
КонецФункции
//-- НЕ УТ
//-- Локализация

#КонецОбласти

#КонецОбласти
