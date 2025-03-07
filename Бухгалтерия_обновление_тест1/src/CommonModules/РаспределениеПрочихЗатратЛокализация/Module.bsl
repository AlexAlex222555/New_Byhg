
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
	
	//++ НЕ УТ
	//++ Устарело_Производство21
	Если РасчетСебестоимостиПовтИсп.ПартионныйУчетВерсии21(ТекущаяДатаСеанса()) Тогда
		
		Если ПравоДоступа("Просмотр", Метаданные.Отчеты.ДанныеДляБазыРаспределенияРасходов) Тогда
			
			КомандаОтчет = КомандыОтчетов.Добавить();
			
			КомандаОтчет.ВидимостьВФормах	= "ФормаДокумента";
			КомандаОтчет.Идентификатор		= Метаданные.Отчеты.ДанныеДляБазыРаспределенияРасходов.ПолноеИмя();
			КомандаОтчет.Менеджер			= "Отчет.ДанныеДляБазыРаспределенияРасходов";
			КомандаОтчет.Представление		= НСтр("ru='Данные базы распределения';uk='Дані бази розподілу'");
			
			КомандаОтчет.МножественныйВыбор = Ложь;
			КомандаОтчет.Важность			= "Обычное";
			
		КонецЕсли;
		
	КонецЕсли;
	//-- Устарело_Производство21
	//-- НЕ УТ
	
КонецПроцедуры

// Заполняет список команд печати.
//
// Параметры:
//   КомандыПечати - см. УправлениеПечатью.СоздатьКоллекциюКомандПечати
//
Процедура ДобавитьКомандыПечати(КомандыПечати) Экспорт
	
	
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
	
#Область РаспределениеРасходов //(Дт 23, 91, 92 :: Кт 91, 92)
	ТекстЗапроса = "
	|ВЫБРАТЬ //// Распределение расходов (Дт 23 :: Кт 91, 92)
	|
	|	Операция.Ссылка КАК Ссылка,
	|	Операция.Дата КАК Период,
	|	Операция.Организация КАК Организация,
	|	НЕОПРЕДЕЛЕНО КАК ИдентификаторСтроки,
	|
	|	Строки.Сумма КАК Сумма,
	|	Строки.СуммаУпр КАК СуммаУУ,
	|
	|	ЗНАЧЕНИЕ(Перечисление.ВидыСчетовРеглУчета.Производство) КАК ВидСчетаДт,
	|	НЕОПРЕДЕЛЕНО КАК АналитикаУчетаДт,
	|	Строки.МестоУчетаДт КАК МестоУчетаДт,
	|
	|	ЗНАЧЕНИЕ(Справочник.Валюты.ПустаяСсылка) КАК ВалютаДт,
	|	Строки.Подразделение КАК ПодразделениеДт,
	|	Строки.НаправлениеДеятельности КАК НаправлениеДеятельностиДт,
	|	НЕОПРЕДЕЛЕНО КАК НалоговоеНазначениеДт,
	|
	|	ЗНАЧЕНИЕ(ПланСчетов.Хозрасчетный.ПустаяСсылка) КАК СчетДт,
	|
	|	Строки.СтатьяРасходов КАК СубконтоДт1,
	|	ЗНАЧЕНИЕ(Перечисление.ТипыЗатратРегл.Прочее) КАК СубконтоДт2,
	|	Строки.ГруппаПродукции КАК СубконтоДт3,
	|
	|	0 КАК ВалютнаяСуммаДт,
	|	0 КАК КоличествоДт,
	|	0 КАК СуммаНУДт,
	|	0 КАК СуммаПРДт,
	|	0 КАК СуммаВРДт,
	|
	|	ЗНАЧЕНИЕ(Перечисление.ВидыСчетовРеглУчета.Расходы) КАК ВидСчетаКт,
	|	Операция.СтатьяРасходов КАК АналитикаУчетаКт,
	|	Операция.Подразделение КАК МестоУчетаКт,
	|
	|	ЗНАЧЕНИЕ(Справочник.Валюты.ПустаяСсылка) КАК ВалютаКт,
	|	Операция.Подразделение КАК ПодразделениеКт,
	|	Операция.НаправлениеДеятельности КАК НаправлениеДеятельностиКт,
	|	НЕОПРЕДЕЛЕНО КАК НалоговоеНазначениеКт,
	|
	|	ЗНАЧЕНИЕ(ПланСчетов.Хозрасчетный.ПустаяСсылка) КАК СчетКт,
	|
	|	Операция.СтатьяРасходов КАК СубконтоКт1,
	|	ЗНАЧЕНИЕ(Перечисление.ТипыЗатратРегл.Прочее) КАК СубконтоКт2,
	|	ЗНАЧЕНИЕ(Справочник.ГруппыАналитическогоУчетаНоменклатуры.ПустаяСсылка) КАК СубконтоКт3,
	|
	|	0 КАК ВалютнаяСуммаКт,
	|	0 КАК КоличествоКт,
	|	0 КАК СуммаНУКт,
	|	0 КАК СуммаПРКт,
	|	0 КАК СуммаВРКт,
	|	""%1"" КАК Содержание
	|ИЗ
	|	ДокументыКОтражению КАК ДокументыКОтражению
	|	
	|	ВНУТРЕННЕЕ СОЕДИНЕНИЕ
	|		Документ.РаспределениеПрочихЗатрат КАК Операция
	|	ПО	
	|		ДокументыКОтражению.Ссылка = Операция.Ссылка
	|	
	|	ВНУТРЕННЕЕ СОЕДИНЕНИЕ
	|		ПрочиеРасходыНЗП КАК Строки
	|	ПО
	|		Строки.Ссылка = Операция.Ссылка
	|	
	|	ЛЕВОЕ СОЕДИНЕНИЕ 
	|		РегистрСведений.ПорядокОтраженияНаСчетахУчета КАК СчетаПроизводстваПоМестуУчета
	|	ПО 
	|		СчетаПроизводстваПоМестуУчета.ВидСчета = ЗНАЧЕНИЕ(Перечисление.ВидыСчетовРеглУчета.Производство)
	|		И СчетаПроизводстваПоМестуУчета.Организация = Операция.Организация
	|		И СчетаПроизводстваПоМестуУчета.МестоУчета = Операция.Подразделение
	|	
	|	ЛЕВОЕ СОЕДИНЕНИЕ 
	|		РегистрСведений.ПорядокОтраженияНаСчетахУчета КАК СчетаПроизводстваПоОрганизации
	|	ПО 
	|		СчетаПроизводстваПоОрганизации.ВидСчета = ЗНАЧЕНИЕ(Перечисление.ВидыСчетовРеглУчета.Производство)
	|		И СчетаПроизводстваПоОрганизации.Организация = Операция.Организация
	|		И СчетаПроизводстваПоОрганизации.МестоУчета = НЕОПРЕДЕЛЕНО
	|	
	|	ЛЕВОЕ СОЕДИНЕНИЕ 
	|		РегистрСведений.ПорядокОтраженияНаСчетахУчета КАК КорСчетаРасходовПоМестуУчета
	|	ПО 
	|		КорСчетаРасходовПоМестуУчета.ВидСчета = ЗНАЧЕНИЕ(Перечисление.ВидыСчетовРеглУчета.Расходы)
	|		И КорСчетаРасходовПоМестуУчета.Организация = Операция.Организация
	|		И КорСчетаРасходовПоМестуУчета.АналитикаУчета = Операция.СтатьяРасходов
	|		И КорСчетаРасходовПоМестуУчета.МестоУчета = Строки.Подразделение
	|	
	|	ЛЕВОЕ СОЕДИНЕНИЕ 
	|		РегистрСведений.ПорядокОтраженияНаСчетахУчета КАК КорСчетаРасходовПоОрганизации
	|	ПО 
	|		КорСчетаРасходовПоОрганизации.ВидСчета = ЗНАЧЕНИЕ(Перечисление.ВидыСчетовРеглУчета.Расходы)
	|		И КорСчетаРасходовПоОрганизации.Организация = Операция.Организация
	|		И КорСчетаРасходовПоОрганизации.АналитикаУчета = Операция.СтатьяРасходов
	|		И КорСчетаРасходовПоОрганизации.МестоУчета = НЕОПРЕДЕЛЕНО
	|	
	|	ЛЕВОЕ СОЕДИНЕНИЕ 
	|		РегистрСведений.ПорядокОтраженияНаСчетахУчета КАК КорСчетаРасходовПоАналитикеУчета
	|	ПО 
	|		КорСчетаРасходовПоАналитикеУчета.ВидСчета = ЗНАЧЕНИЕ(Перечисление.ВидыСчетовРеглУчета.Расходы)
	|		И КорСчетаРасходовПоАналитикеУчета.Организация = ЗНАЧЕНИЕ(Справочник.Организации.ПустаяСсылка)
	|		И КорСчетаРасходовПоАналитикеУчета.АналитикаУчета = Операция.СтатьяРасходов
	|		И КорСчетаРасходовПоАналитикеУчета.МестоУчета = НЕОПРЕДЕЛЕНО
	|	
	|ГДЕ
    |	(Строки.Сумма <> 0 ИЛИ Строки.СуммаУпр <> 0)
	|	И (ЕСТЬNULL(СчетаПроизводстваПоМестуУчета.СчетУчета, ЕСТЬNULL(СчетаПроизводстваПоОрганизации.СчетУчета, ЗНАЧЕНИЕ(ПланСчетов.Хозрасчетный.ОсновноеПроизводство))) <>
	|			ЕСТЬNULL(КорСчетаРасходовПоМестуУчета.СчетУчета, ЕСТЬNULL(КорСчетаРасходовПоОрганизации.СчетУчета, ЕСТЬNULL(КорСчетаРасходовПоАналитикеУчета.СчетУчета, ЗНАЧЕНИЕ(ПланСчетов.Хозрасчетный.ПустаяСсылка))))
	|	    ИЛИ Операция.Подразделение <> Строки.Подразделение
	|	    ИЛИ Операция.НаправлениеДеятельности <> Строки.НаправлениеДеятельности
	|	    ИЛИ (&АналитическийУчетПоГруппамПродукции И Строки.ГруппаПродукции <> ЗНАЧЕНИЕ(Справочник.ГруппыАналитическогоУчетаНоменклатуры.ПустаяСсылка)))
	|
	|ОБЪЕДИНИТЬ ВСЕ
	|
	|ВЫБРАТЬ //// Распределение расходов (Дт 91, 92 :: Кт 91, 92)
	|
	|	Операция.Ссылка КАК Ссылка,
	|	Операция.Дата КАК Период,
	|	Операция.Организация КАК Организация,
	|	НЕОПРЕДЕЛЕНО КАК ИдентификаторСтроки,
	|
	|	ПрочиеРасходы.СуммаРегл КАК Сумма,
	|	ПрочиеРасходы.СуммаУпр КАК СуммаУУ,
	|
	|	ЗНАЧЕНИЕ(Перечисление.ВидыСчетовРеглУчета.Расходы) КАК ВидСчетаДт,
	|	ПрочиеРасходы.СтатьяРасходов КАК АналитикаУчетаДт,
	|	ПрочиеРасходы.Подразделение КАК МестоУчетаДт,
	|
	|	ЗНАЧЕНИЕ(Справочник.Валюты.ПустаяСсылка) КАК ВалютаДт,
	|	ПрочиеРасходы.Подразделение КАК ПодразделениеДт,
	|	ПрочиеРасходы.НаправлениеДеятельности КАК НаправлениеДеятельностиДт,
	|	НЕОПРЕДЕЛЕНО КАК НалоговоеНазначениеДт,
	|
	|	ЗНАЧЕНИЕ(ПланСчетов.Хозрасчетный.ПустаяСсылка) КАК СчетДт,
	|
	|	ПрочиеРасходы.СтатьяРасходов КАК СубконтоДт1,
	|	ЗНАЧЕНИЕ(Перечисление.ТипыЗатратРегл.Прочее) КАК СубконтоДт2,
	|	ПрочиеРасходы.АналитикаРасходов КАК СубконтоДт3,
	|
	|	0 КАК ВалютнаяСуммаДт,
	|	0 КАК КоличествоДт,
	|	0 КАК СуммаНУДт,
	|	0 КАК СуммаПРДт,
	|	0 КАК СуммаВРДт,
	|
	|	ЗНАЧЕНИЕ(Перечисление.ВидыСчетовРеглУчета.Расходы) КАК ВидСчетаКт,
	|	Операция.СтатьяРасходов КАК АналитикаУчетаКт,
	|	Операция.Подразделение КАК МестоУчетаКт,
	|
	|	ЗНАЧЕНИЕ(Справочник.Валюты.ПустаяСсылка) КАК ВалютаКт,
	|	Операция.Подразделение КАК ПодразделениеКт,
	|	Операция.НаправлениеДеятельности КАК НаправлениеДеятельностиКт,
	|	НЕОПРЕДЕЛЕНО КАК НалоговоеНазначениеКт,
	|
	|	ЗНАЧЕНИЕ(ПланСчетов.Хозрасчетный.ПустаяСсылка) КАК СчетКт,
	|
	|	Операция.СтатьяРасходов КАК СубконтоКт1,
	|	ЗНАЧЕНИЕ(Перечисление.ТипыЗатратРегл.Прочее) КАК СубконтоКт2,
	|	НЕОПРЕДЕЛЕНО КАК СубконтоКт3,
	|
	|	0 КАК ВалютнаяСуммаКт,
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
	|		Документ.РаспределениеПрочихЗатрат КАК Операция
	|	ПО	
	|		ДокументыКОтражению.Ссылка = Операция.Ссылка
	|
	|	ВНУТРЕННЕЕ СОЕДИНЕНИЕ РегистрНакопления.ПрочиеРасходы КАК ПрочиеРасходы
	|	ПО Операция.Ссылка = ПрочиеРасходы.ДокументДвижения
	|	   И ПрочиеРасходы.ВидДвижения = ЗНАЧЕНИЕ(ВидДвиженияНакопления.Приход)
	|	   И ПрочиеРасходы.Активность
    |	   И (ПрочиеРасходы.СуммаРегл <> 0 ИЛИ ПрочиеРасходы.СуммаУпр <> 0)
	|";            

	ТекстЗапроса = СтрШаблон(ТекстЗапроса, 
		НСтр("ru='Распределение расходов';uk='Розподіл витрат'",ЯзыкСодержания));

	ТекстыОтражения.Добавить(ТекстЗапроса);
	
#КонецОбласти

#Область СписаниеНаСтатьиАктивовПассивов //(Дт ХХ.ХХ :: Кт 20)
	ТекстЗапроса = "
	|ВЫБРАТЬ //// Списание на прочие активы (Дт ХХ.ХХ :: Кт 20)
	|	Операция.Ссылка КАК Ссылка,
	|	Операция.Дата КАК Период,
	|	Операция.Организация КАК Организация,
	|	ТаблицаСписание.НомерСтроки КАК ИдентификаторСтроки,
	|
	|	Строки.СуммаРегл КАК Сумма,
	|	Строки.СуммаУпр КАК СуммаУУ,
	|
	|	ЗНАЧЕНИЕ(Перечисление.ВидыСчетовРеглУчета.ПрочиеАктивыПассивы) КАК ВидСчетаДт,
	|	НЕОПРЕДЕЛЕНО КАК АналитикаУчетаДт,
	|	НЕОПРЕДЕЛЕНО КАК МестоУчетаДт,
	|
	|	ЗНАЧЕНИЕ(Справочник.Валюты.ПустаяСсылка) КАК ВалютаДт,
	|	Операция.Подразделение КАК ПодразделениеДт,
	|	ТаблицаСписание.НаправлениеДеятельности КАК НаправлениеДеятельностиДт,
    |	НЕОПРЕДЕЛЕНО КАК НалоговоеНазначениеДт,
	|
	|	ТаблицаСписание.СчетУчета КАК СчетДт,
	|	ТаблицаСписание.Субконто1 КАК СубконтоДт1,
	|	ТаблицаСписание.Субконто2 КАК СубконтоДт2,
	|	ТаблицаСписание.Субконто3 КАК СубконтоДт3,
	|
	|	0 КАК ВалютнаяСуммаДт,
	|	0 КАК КоличествоДт,
    |	0 КАК СуммаНУДт,
    |	0 КАК СуммаПРДт,
    |	0 КАК СуммаВРДт,
	|
	|	ЗНАЧЕНИЕ(Перечисление.ВидыСчетовРеглУчета.Расходы) КАК ВидСчетаКт,
	|	Операция.СтатьяРасходов КАК АналитикаУчетаКт,
	|	Строки.Подразделение КАК МестоУчетаКт,
	|
	|	ЗНАЧЕНИЕ(Справочник.Валюты.ПустаяСсылка) КАК ВалютаКт,
	|	Строки.Подразделение КАК ПодразделениеКт,
	|	Строки.НаправлениеДеятельности КАК НаправлениеДеятельностиКт,
    |	НЕОПРЕДЕЛЕНО КАК НалоговоеНазначениеКт,
	|
	|	ЗНАЧЕНИЕ(ПланСчетов.Хозрасчетный.ПустаяСсылка) КАК СчетКт,
	|
	|	Строки.СтатьяРасходов КАК СубконтоКт1,
	|	ЗНАЧЕНИЕ(Перечисление.ТипыЗатратРегл.Прочее) КАК СубконтоКт2,
	|	Строки.ГруппаПродукции КАК СубконтоКт3,
	|
	|	0 КАК ВалютнаяСуммаКт,
	|	0 КАК КоличествоКт,
    |	0 КАК СуммаНУКт,
    |	0 КАК СуммаПРКт,
    |	0 КАК СуммаВРКт,
	|	""%1"" КАК Содержание
	|ИЗ
	|	ДокументыКОтражению КАК ДокументыКОтражению
	|	
	|	ВНУТРЕННЕЕ СОЕДИНЕНИЕ
	|		Документ.РаспределениеПрочихЗатрат КАК Операция
	|	ПО
	|		ДокументыКОтражению.Ссылка = Операция.Ссылка
	|	
	|	ВНУТРЕННЕЕ СОЕДИНЕНИЕ
	|		РегистрНакопления.ПрочиеРасходы КАК Строки
	|	ПО
	|		Операция.Ссылка = Строки.Регистратор
	|		И Строки.ВидДвижения = ЗНАЧЕНИЕ(ВидДвиженияНакопления.Расход)
	|		И Строки.Активность
	|
	|	ВНУТРЕННЕЕ СОЕДИНЕНИЕ
	|		Документ.РаспределениеПрочихЗатрат.Списание КАК ТаблицаСписание
	|	ПО
	|		Операция.Ссылка = ТаблицаСписание.Ссылка
	|		И Строки.ИдентификаторСтроки = ТаблицаСписание.ИдентификаторСтроки
	|
	|ГДЕ
	|	ТИПЗНАЧЕНИЯ(ТаблицаСписание.СтатьяРасходов) = ТИП(ПланВидовХарактеристик.СтатьиАктивовПассивов)
	|";   

	ТекстЗапроса = СтрШаблон(ТекстЗапроса, 
		НСтр("ru='Списание на прочие активы';uk='Списання на інші активи'",ЯзыкСодержания));

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
	
	ТекстЗапроса = "
	|ВЫБРАТЬ
	|	ВыпускБезЗаказа.Ссылка,
	|	ВыпускБезЗаказа.КодСтроки,
	|	МАКСИМУМ(ВыпускБезЗаказа.Назначение.НаправлениеДеятельности) КАК НаправлениеДеятельности
	|ПОМЕСТИТЬ ВыпускиБезЗаказа
	|ИЗ
	|	ДокументыКОтражению КАК ДокументыКОтражению
	|	ВНУТРЕННЕЕ СОЕДИНЕНИЕ РегистрНакопления.ПрочиеРасходыНезавершенногоПроизводства КАК Движения
	|		ПО ДокументыКОтражению.Ссылка = Движения.ДокументДвижения
	|			И Движения.Активность
	|	ВНУТРЕННЕЕ СОЕДИНЕНИЕ Документ.ВыпускПродукции.Товары КАК ВыпускБезЗаказа
	|		ПО (ВыпускБезЗаказа.Ссылка = Движения.ДокументВыпуска ИЛИ ВыпускБезЗаказа.Ссылка = Движения.ЗаказНаПроизводство)
	|		И ВыпускБезЗаказа.КодСтроки = Движения.КодСтрокиПродукция
	|ГДЕ
	|	НЕ ВыпускБезЗаказа.Ссылка.ВыпускПоРаспоряжениям
	|СГРУППИРОВАТЬ ПО
	|	ВыпускБезЗаказа.Ссылка,
	|	ВыпускБезЗаказа.КодСтроки
	|;
	|ВЫБРАТЬ
	|	Движения.ДокументДвижения     КАК Ссылка,
	|	(ВЫБОР
	|		КОГДА НЕ ЗаказыПереработчику.Партнер ЕСТЬ NULL ТОГДА ЗаказыПереработчику.Партнер
	|		КОГДА НЕ ОтчетПереработчика.Партнер ЕСТЬ NULL ТОГДА ОтчетПереработчика.Партнер
	|		ИНАЧЕ Движения.Подразделение КОНЕЦ) КАК МестоУчетаДт,
	|	Движения.Подразделение        КАК Подразделение,
	|	Движения.СтатьяРасходов       КАК СтатьяРасходов,
	|	Движения.ГруппаПродукции      КАК ГруппаПродукции,
	|	ВЫБОР
	|		КОГДА НЕ ВыпускБезЗаказа.НаправлениеДеятельности ЕСТЬ NULL
	|			ТОГДА ВыпускБезЗаказа.НаправлениеДеятельности
	|		ИНАЧЕ ЕСТЬNULL(СпрПартииПроизводства.НаправлениеДеятельности, Движения.НаправлениеДеятельности)
	|	КОНЕЦ                         КАК НаправлениеДеятельности,
	|	СУММА(Движения.СтоимостьРегл) КАК Сумма,
	|	СУММА(Движения.СтоимостьУпр)  КАК СуммаУпр,
    |	0 КАК СуммаНУ,
    |	0 КАК СуммаПР,
    |	0 КАК СуммаВР
	|ПОМЕСТИТЬ ПрочиеРасходыНЗП
	|ИЗ
	|	ДокументыКОтражению КАК ДокументыКОтражению
	|
	|	ВНУТРЕННЕЕ СОЕДИНЕНИЕ РегистрНакопления.ПрочиеРасходыНезавершенногоПроизводства КАК Движения
	|		ПО ДокументыКОтражению.Ссылка = Движения.ДокументДвижения
	|			И Движения.Активность
	|
	|	ЛЕВОЕ СОЕДИНЕНИЕ Документ.ЗаказПереработчику КАК ЗаказыПереработчику
	|		ПО ЗаказыПереработчику.Ссылка = Движения.ЗаказНаПроизводство
	|
	|	ЛЕВОЕ СОЕДИНЕНИЕ Документ.ОтчетПереработчика КАК ОтчетПереработчика
	|		ПО ОтчетПереработчика.Ссылка = Движения.ДокументВыпуска
	|
	|	ЛЕВОЕ СОЕДИНЕНИЕ ВыпускиБезЗаказа КАК ВыпускБезЗаказа
	|		ПО (ВыпускБезЗаказа.Ссылка = Движения.ДокументВыпуска ИЛИ ВыпускБезЗаказа.Ссылка = Движения.ЗаказНаПроизводство)
	|		И ВыпускБезЗаказа.КодСтроки = Движения.КодСтрокиПродукция
	|
	|	ЛЕВОЕ СОЕДИНЕНИЕ Справочник.ПартииПроизводства КАК СпрПартииПроизводства
	|		ПО СпрПартииПроизводства.Ссылка = Движения.ПартияПроизводства
	|
	|СГРУППИРОВАТЬ ПО
	|	(ВЫБОР
	|		КОГДА НЕ ЗаказыПереработчику.Партнер ЕСТЬ NULL ТОГДА ЗаказыПереработчику.Партнер
	|		КОГДА НЕ ОтчетПереработчика.Партнер ЕСТЬ NULL ТОГДА ОтчетПереработчика.Партнер
	|		ИНАЧЕ Движения.Подразделение КОНЕЦ),
	|	Движения.ДокументДвижения,
	|	Движения.Подразделение,
	|	Движения.СтатьяРасходов,
	|	ВЫБОР
	|		КОГДА НЕ ВыпускБезЗаказа.НаправлениеДеятельности ЕСТЬ NULL
	|			ТОГДА ВыпускБезЗаказа.НаправлениеДеятельности
	|		ИНАЧЕ ЕСТЬNULL(СпрПартииПроизводства.НаправлениеДеятельности, Движения.НаправлениеДеятельности)
	|	КОНЕЦ,
	|	Движения.ГруппаПродукции
	|
	|ИНДЕКСИРОВАТЬ ПО
	|	Ссылка
	|;
	|";
	
	РегистрыСведений.ПорядокОтраженияНаСчетахУчета.ПереопределитьВТекстеЗапросаПорядокОтраженияСчетаУчета(ТекстЗапроса);
	Возврат ТекстЗапроса;
	
	//-- Локализация
	Возврат "";
	
КонецФункции

#КонецОбласти
//-- НЕ УТ

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

//++ НЕ УТ
//Регистрирует документ к отражению в регламентированном учете.
//Параметры:
//	Документ - ДокументСсылка.РаспределениеПрочихЗатрат - документ к отражению.
//
Процедура ЗарегистрироватьОтражениеДокумента(Документ) Экспорт
	
	//++ Локализация
	РеглУчетПроведениеСервер.ЗарегистрироватьОтражениеДокумента(Документ,
		Перечисления.СтатусыОтраженияДокументовВРеглУчете.КОтражениюВРеглУчете);
	//-- Локализация
				
КонецПроцедуры
//-- НЕ УТ

#Область Проведение

// Процедура дополняет тексты запросов проведения документа.
//
// Параметры:
//  Запрос - Запрос - Общий запрос проведения документа.
//  ТекстыЗапроса - СписокЗначений - Список текстов запроса проведения.
//  Регистры - Строка, Структура - Список регистров проведения документа через запятую или в ключах структуры.
//
Процедура ДополнитьТекстыЗапросовПроведения(Запрос, ТекстыЗапроса, Регистры) Экспорт
	
	//++ НЕ УТ
	//++ Локализация
	РеглУчетПроведениеСервер.ТекстЗапросаТаблицаОтражениеДокументовВРеглУчете(Запрос, ТекстыЗапроса, Регистры);
	//-- Локализация
	//-- НЕ УТ
	
КонецПроцедуры

#КонецОбласти

#КонецОбласти
