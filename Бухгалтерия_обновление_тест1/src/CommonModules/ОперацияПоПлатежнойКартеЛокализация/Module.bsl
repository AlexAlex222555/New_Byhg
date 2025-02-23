
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

#Область ПоступлениеОплатыОтКлиента
	ТекстЗапроса = "
	|ВЫБРАТЬ // Получение оплаты от клиента (Дт 3332 :: Кт 361)
	|
	|	Операция.Ссылка КАК Ссылка,
	|	Операция.Дата КАК Период,
	|	Операция.Организация КАК Организация,
	|	НЕОПРЕДЕЛЕНО КАК ИдентификаторСтроки,
	|
	|	-РасчетыПоДокументам.ДолгРегл - РасчетыПоДокументам.ЗалогЗаТаруРегл КАК Сумма,
	|	-РасчетыПоДокументам.ДолгУпр - РасчетыПоДокументам.ЗалогЗаТаруРегл / КурсВалютыУпрУчета.Курс КАК СуммаУУ,
	|
	|	НЕОПРЕДЕЛЕНО КАК ВидСчетаДт,
	|	НЕОПРЕДЕЛЕНО КАК АналитикаУчетаДт,
	|	НЕОПРЕДЕЛЕНО КАК МестоУчетаДт,
	|
	|	Операция.Валюта КАК ВалютаДт,
	|	Операция.ЭквайринговыйТерминал.БанковскийСчет.Подразделение КАК ПодразделениеДт,
	|	Операция.ЭквайринговыйТерминал.БанковскийСчет.НаправлениеДеятельности КАК НаправлениеДеятельностиДт,
	|	НЕОПРЕДЕЛЕНО КАК НалоговоеНазначениеДт,	
	|
	|	ЗНАЧЕНИЕ(ПланСчетов.Хозрасчетный.ПродажиПоПлатежнымКартам) КАК СчетДт,
	|	Операция.ЭквайринговыйТерминал.Эквайер КАК СубконтоДт1,
	|	НЕОПРЕДЕЛЕНО КАК СубконтоДт2,
	|	НЕОПРЕДЕЛЕНО КАК СубконтоДт3,
	|	
	|	-РасчетыПоДокументам.Долг - РасчетыПоДокументам.ЗалогЗаТару КАК ВалютнаяСуммаДт,
	|	0 КАК КоличествоДт,
	|	0 КАК СуммаНУДт,
	|	0 КАК СуммаПРДт,
	|	0 КАК СуммаВРДт,
	|	
	|	ЗНАЧЕНИЕ(Перечисление.ВидыСчетовРеглУчета.РасчетыСКлиентами) КАК ВидСчетаКт,
	|	Расчеты.ГруппаФинансовогоУчета КАК АналитикаУчетаКт,
	|	НЕОПРЕДЕЛЕНО КАК МестоУчетаКт,
	|
	|	Расчеты.Валюта КАК ВалютаКт,
	|	Расчеты.Подразделение КАК ПодразделениеКт,
	|	Расчеты.НаправлениеДеятельности КАК НаправлениеДеятельностиКт,
	|	НЕОПРЕДЕЛЕНО КАК НалоговоеНазначениеКт,
	|
	|	ЗНАЧЕНИЕ(ПланСчетов.Хозрасчетный.ПустаяСсылка) КАК СчетКт,
	|	Расчеты.Контрагент КАК СубконтоКт1,
	|	Расчеты.Договор КАК СубконтоКт2,
	|	НЕОПРЕДЕЛЕНО КАК СубконтоКт3,
	|
	|	-РасчетыПоДокументам.Долг - РасчетыПоДокументам.ЗалогЗаТару КАК ВалютнаяСуммаКт,
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
	|		Документ.ОперацияПоПлатежнойКарте КАК Операция
	|	ПО
	|		ДокументыКОтражению.Ссылка = Операция.Ссылка
	|
	|	ВНУТРЕННЕЕ СОЕДИНЕНИЕ
	|		Расчеты КАК Расчеты
	|	ПО
	|		Операция.Ссылка = Расчеты.Ссылка
	|
	|	ВНУТРЕННЕЕ СОЕДИНЕНИЕ
	|		РасчетыСКлиентамиПоДокументам КАК РасчетыПоДокументам
	|	ПО
	|		Расчеты.Ссылка = РасчетыПоДокументам.Ссылка
	|		И Расчеты.ОбъектРасчетов = РасчетыПоДокументам.ОбъектРасчетов
	|		И Расчеты.Валюта = РасчетыПоДокументам.Валюта
	|		И Расчеты.СтатьяДвиженияДенежныхСредств = РасчетыПоДокументам.СтатьяДвиженияДенежныхСредств
	|
	|	ЛЕВОЕ СОЕДИНЕНИЕ
	|		КурсыВалют КАК КурсВалютыУпрУчета
	|	ПО
	|		КурсВалютыУпрУчета.Валюта = &ВалютаУпрУчета
	|		И КурсВалютыУпрУчета.Дата = НАЧАЛОПЕРИОДА(Операция.Дата, День)
	|
	|ГДЕ
	|	Операция.ХозяйственнаяОперация = ЗНАЧЕНИЕ(Перечисление.ХозяйственныеОперации.ПоступлениеОплатыОтКлиента)
	|";

	ТекстЗапроса = СтрШаблон(ТекстЗапроса, 
		НСтр("ru='Получение оплаты от клиента';uk='Отримання оплати від клієнта'",ЯзыкСодержания));
	ТекстыОтражения.Добавить(ТекстЗапроса);
 
#КонецОбласти
	
#Область ПоступлениеАвансаОтКлиента
	ТекстЗапроса = "
	|ВЫБРАТЬ // Поступление аванса от клиента (Дт 3332 :: Кт 681)
	|
	|	Операция.Ссылка КАК Ссылка,
	|	Операция.Дата КАК Период,
	|	Операция.Организация КАК Организация,
	|	НЕОПРЕДЕЛЕНО КАК ИдентификаторСтроки,
	|
	|	ЕСТЬNULL(РасчетыПредоплата.ПредоплатаРегл, -Расчеты.СуммаРегл) КАК Сумма,
	|	ЕСТЬNULL(РасчетыПредоплата.ПредоплатаУпр, -Расчеты.СуммаУпр) КАК СуммаУУ,
	|
	|	НЕОПРЕДЕЛЕНО КАК ВидСчетаДт,
	|	НЕОПРЕДЕЛЕНО КАК АналитикаУчетаДт,
	|	НЕОПРЕДЕЛЕНО КАК МестоУчетаДт,
	|
	|	Расчеты.Валюта КАК ВалютаДт,
	|	Операция.ЭквайринговыйТерминал.БанковскийСчет.Подразделение КАК ПодразделениеДт,
	|	Операция.ЭквайринговыйТерминал.БанковскийСчет.НаправлениеДеятельности КАК НаправлениеДеятельностиДт,
	|	НЕОПРЕДЕЛЕНО КАК НалоговоеНазначениеДт,	
	|
	|	ЗНАЧЕНИЕ(ПланСчетов.Хозрасчетный.ПродажиПоПлатежнымКартам) КАК СчетДт,
	|	Операция.ЭквайринговыйТерминал.Эквайер КАК СубконтоДт1,
	|	НЕОПРЕДЕЛЕНО КАК СубконтоДт2,
	|	НЕОПРЕДЕЛЕНО КАК СубконтоДт3,
	|	
	|	ЕСТЬNULL(РасчетыПредоплата.Предоплата, -Расчеты.Сумма) КАК ВалютнаяСуммаДт,
	|	0 КАК КоличествоДт,
	|	0 КАК СуммаНУДт,
	|	0 КАК СуммаПРДт,
	|	0 КАК СуммаВРДт,
	|	
	|	ЗНАЧЕНИЕ(Перечисление.ВидыСчетовРеглУчета.АвансыПолученные) КАК ВидСчетаКт,
	|	Расчеты.ГруппаФинансовогоУчета КАК АналитикаУчетаКт,
	|	НЕОПРЕДЕЛЕНО КАК МестоУчетаКт,
	|
	|	Расчеты.Валюта КАК ВалютаКт,
	|	Расчеты.Подразделение КАК ПодразделениеКт,
	|	Расчеты.НаправлениеДеятельности КАК НаправлениеДеятельностиКт,
	|	НЕОПРЕДЕЛЕНО КАК НалоговоеНазначениеКт,
	|
	|	ЗНАЧЕНИЕ(ПланСчетов.Хозрасчетный.ПустаяСсылка) КАК СчетКт,
	|	Расчеты.Контрагент КАК СубконтоКт1,
	|	Расчеты.Договор КАК СубконтоКт2,
	|	НЕОПРЕДЕЛЕНО КАК СубконтоКт3,
	|
	|	ЕСТЬNULL(РасчетыПредоплата.Предоплата, -Расчеты.Сумма) КАК ВалютнаяСуммаКт,
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
	|		Документ.ОперацияПоПлатежнойКарте КАК Операция
	|	ПО
	|		ДокументыКОтражению.Ссылка = Операция.Ссылка
	|
	|	ВНУТРЕННЕЕ СОЕДИНЕНИЕ
	|		Расчеты КАК Расчеты
	|	ПО
	|		Операция.Ссылка = Расчеты.Ссылка
	|
	|	ЛЕВОЕ СОЕДИНЕНИЕ
	|		РасчетыСКлиентамиПоДокументам КАК РасчетыПредоплата
	|	ПО
	|		Расчеты.Ссылка = РасчетыПредоплата.Ссылка
	|		И Расчеты.ОбъектРасчетов = РасчетыПредоплата.ОбъектРасчетов
	|		И Расчеты.Валюта = РасчетыПредоплата.Валюта
	|		И Расчеты.СтатьяДвиженияДенежныхСредств = РасчетыПредоплата.СтатьяДвиженияДенежныхСредств
	|ГДЕ
	|	Операция.ХозяйственнаяОперация = ЗНАЧЕНИЕ(Перечисление.ХозяйственныеОперации.ПоступлениеОплатыОтКлиента)
	|";

	ТекстЗапроса = СтрШаблон(ТекстЗапроса, 
		НСтр("ru='Поступление аванса от клиента';uk='Надходження авансу від клієнта'",ЯзыкСодержания));
	ТекстыОтражения.Добавить(ТекстЗапроса);
 
#КонецОбласти
	
#Область ВозвратДСКлиенту
	ТекстЗапроса = "
	|ВЫБРАТЬ // Возврат ДС клиенту (Дт 361 :: Кт 3332)
	|
	|	Операция.Ссылка КАК Ссылка,
	|	Операция.Дата КАК Период,
	|	Операция.Организация КАК Организация,
	|	НЕОПРЕДЕЛЕНО КАК ИдентификаторСтроки,
	|
	|	Суммы.СуммаБезНДСРегл + Суммы.СуммаНДСРегл КАК Сумма,
	|	Суммы.СуммаБезНДСУпр + Суммы.СуммаНДСУпр КАК СуммаУУ,
	|
	|	ЗНАЧЕНИЕ(Перечисление.ВидыСчетовРеглУчета.РасчетыСКлиентами) КАК ВидСчетаДт,
	|	ЕСТЬNULL(Расчеты.ГруппаФинансовогоУчета, Операция.ГруппаФинансовогоУчета) КАК АналитикаУчетаДт,
	|	НЕОПРЕДЕЛЕНО КАК МестоУчетаДт,
	|
	|	ЕСТЬNULL(Расчеты.Валюта, Операция.Валюта) КАК ВалютаДт,
	|	ЕСТЬNULL(Расчеты.Подразделение, Операция.Подразделение) КАК ПодразделениеДт,
	|	ЕСТЬNULL(Расчеты.НаправлениеДеятельности, Операция.НаправлениеДеятельности) КАК НаправлениеДеятельностиДт,
	|	НЕОПРЕДЕЛЕНО КАК НалоговоеНазначениеДт,	
	|
	|	ЗНАЧЕНИЕ(ПланСчетов.Хозрасчетный.ПустаяСсылка) КАК СчетДт,
	|	ЕСТЬNULL(Расчеты.Контрагент, Операция.Контрагент) КАК СубконтоДт1,
	|	ЕСТЬNULL(Расчеты.Договор, Операция.Договор) КАК СубконтоДт2,
	|	НЕОПРЕДЕЛЕНО КАК СубконтоДт3,
	|	
	|	Суммы.СуммаВзаиморасчетов КАК ВалютнаяСуммаДт,
	|	0 КАК КоличествоДт,
	|	0 КАК СуммаНУДт,
	|	0 КАК СуммаПРДт,
	|	0 КАК СуммаВРДт,
	|	
	|	НЕОПРЕДЕЛЕНО КАК ВидСчетаКт,
	|	НЕОПРЕДЕЛЕНО КАК АналитикаУчетаКт,
	|	НЕОПРЕДЕЛЕНО КАК МестоУчетаКт,
	|
	|	Операция.Валюта КАК ВалютаКт,
	|	Операция.ЭквайринговыйТерминал.БанковскийСчет.Подразделение КАК ПодразделениеКт,
	|	Операция.ЭквайринговыйТерминал.БанковскийСчет.НаправлениеДеятельности КАК НаправлениеДеятельностиКт,
	|	НЕОПРЕДЕЛЕНО КАК НалоговоеНазначениеКт,
	|
	|	ЗНАЧЕНИЕ(ПланСчетов.Хозрасчетный.ПродажиПоПлатежнымКартам) КАК СчетКт,
	|	Операция.ЭквайринговыйТерминал.Эквайер КАК СубконтоКт1,
	|	НЕОПРЕДЕЛЕНО КАК СубконтоКт2,
	|	НЕОПРЕДЕЛЕНО КАК СубконтоКт3,
	|
	|	Суммы.СуммаБезНДС + Суммы.СуммаНДС КАК ВалютнаяСуммаКт,
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
	|		Документ.ОперацияПоПлатежнойКарте КАК Операция
	|	ПО
	|		ДокументыКОтражению.Ссылка = Операция.Ссылка
	|	
	|	ВНУТРЕННЕЕ СОЕДИНЕНИЕ
	|		РегистрСведений.СуммыДокументовВВалютахУчета КАК Суммы
	|	ПО	
	|		Суммы.Регистратор = ДокументыКОтражению.Ссылка
	|	
	|	ЛЕВОЕ СОЕДИНЕНИЕ
	|		Расчеты КАК Расчеты
	|	ПО
	|		Расчеты.Ссылка = Операция.Ссылка
	|		И Расчеты.ДокументОбъектаРасчетов = Операция.Ссылка
	|		И (Расчеты.Валюта = Суммы.ВалютаВзаиморасчетов
	|		ИЛИ Суммы.ВалютаВзаиморасчетов = ЗНАЧЕНИЕ(Справочник.Валюты.ПустаяСсылка))
	|ГДЕ
	|	Операция.ХозяйственнаяОперация = ЗНАЧЕНИЕ(Перечисление.ХозяйственныеОперации.ВозвратОплатыКлиенту)
	|	И Суммы.СуммаБезНДСРегл + Суммы.СуммаНДСРегл + Суммы.СуммаБезНДСУпр + Суммы.СуммаНДСУпр <> 0
	|";

	ТекстЗапроса = СтрШаблон(ТекстЗапроса, 
		НСтр("ru='Возврат денежных средств клиенту';uk='Повернення коштів клієнту'",ЯзыкСодержания));
	ТекстыОтражения.Добавить(ТекстЗапроса);
 
#КонецОбласти
	
#Область ВозвратКлиентуАвансаПогашениеДолга
	ТекстЗапроса = "
	|ВЫБРАТЬ // Возврат аванса клиенту, погашение долга клиента (Дт 361, 362 :: Кт 3332)
	|
	|	Операция.Ссылка КАК Ссылка,
	|	Операция.Дата КАК Период,
	|	Операция.Организация КАК Организация,
	|	НЕОПРЕДЕЛЕНО КАК ИдентификаторСтроки,
	|
	|	ЕСТЬNULL(-РасчетыПоДокументам.ПредоплатаРегл + РасчетыПоДокументам.ДолгРегл, Расчеты.СуммаРегл) КАК Сумма,
	|	ЕСТЬNULL(-РасчетыПоДокументам.ПредоплатаУпр + РасчетыПоДокументам.ДолгУпр, Расчеты.СуммаУпр) КАК СуммаУУ,
	|
	|	ВЫБОР КОГДА ЕСТЬNULL(РасчетыПоДокументам.ПредоплатаРегл, 0) <> 0
	|		ТОГДА ЗНАЧЕНИЕ(Перечисление.ВидыСчетовРеглУчета.АвансыПолученные)
	|		ИНАЧЕ ЗНАЧЕНИЕ(Перечисление.ВидыСчетовРеглУчета.РасчетыСКлиентами)
	|	КОНЕЦ КАК ВидСчетаДт,
	|	Расчеты.ГруппаФинансовогоУчета КАК АналитикаУчетаДт,
	|	НЕОПРЕДЕЛЕНО КАК МестоУчетаДт,
	|
	|	Расчеты.Валюта КАК ВалютаДт,
	|	Расчеты.Подразделение КАК ПодразделениеДт,
	|	Расчеты.НаправлениеДеятельности КАК НаправлениеДеятельностиДт,
	|	НЕОПРЕДЕЛЕНО КАК НалоговоеНазначениеДт,	
	|
	|	ЗНАЧЕНИЕ(ПланСчетов.Хозрасчетный.ПустаяСсылка) КАК СчетДт,
	|	Расчеты.Контрагент КАК СубконтоДт1,
	|	Расчеты.Договор КАК СубконтоДт2,
	|	НЕОПРЕДЕЛЕНО КАК СубконтоДт3,
	|	
	|	ЕСТЬNULL(-РасчетыПоДокументам.Предоплата + РасчетыПоДокументам.Долг, Расчеты.Сумма) КАК ВалютнаяСуммаДт,
	|	0 КАК КоличествоДт,
	|	0 КАК СуммаНУДт,
	|	0 КАК СуммаПРДт,
	|	0 КАК СуммаВРДт,
	|	
	|	ЗНАЧЕНИЕ(Перечисление.ВидыСчетовРеглУчета.РасчетыСКлиентами) КАК ВидСчетаКт,
	|	ЕСТЬNULL(РасчетыПоПретензиям.ГруппаФинансовогоУчета, Операция.ГруппаФинансовогоУчета) КАК АналитикаУчетаКт,
	|	НЕОПРЕДЕЛЕНО КАК МестоУчетаКт,
	|
	|	ЕСТЬNULL(РасчетыПоПретензиям.Валюта, Операция.Валюта) КАК ВалютаКт,
	|	ЕСТЬNULL(РасчетыПоПретензиям.Подразделение, Операция.Подразделение) КАК ПодразделениеКт,
	|	ЕСТЬNULL(РасчетыПоПретензиям.НаправлениеДеятельности, Операция.НаправлениеДеятельности) КАК НаправлениеДеятельностиКт,
	|	НЕОПРЕДЕЛЕНО КАК НалоговоеНазначениеКт,
	|
	|	НЕОПРЕДЕЛЕНО КАК СчетКт,
	|	ЕСТЬNULL(РасчетыПоПретензиям.Контрагент, Операция.Контрагент) КАК СубконтоКт1,
	|	ЕСТЬNULL(РасчетыПоПретензиям.Договор, Операция.Договор) КАК СубконтоКт2,
	|	НЕОПРЕДЕЛЕНО КАК СубконтоКт3,
	|
	|	ЕСТЬNULL(-РасчетыПоДокументам.Предоплата + РасчетыПоДокументам.Долг, Расчеты.Сумма) КАК ВалютнаяСуммаКт,
	|	0 КАК КоличествоКт,
	|	0 КАК СуммаНУКт,
	|	0 КАК СуммаПРКт,
	|	0 КАК СуммаВРКт,
	|	ВЫБОР КОГДА ЕСТЬNULL(РасчетыПоДокументам.ПредоплатаРегл, 0) <> 0
	|		ТОГДА ""%1""
	|		ИНАЧЕ ""%2""
	|	КОНЕЦ КАК Содержание
	|
	|ИЗ
	|	ДокументыКОтражению КАК ДокументыКОтражению
	|	
	|	ВНУТРЕННЕЕ СОЕДИНЕНИЕ
	|		Документ.ОперацияПоПлатежнойКарте КАК Операция
	|	ПО
	|		ДокументыКОтражению.Ссылка = Операция.Ссылка
	|	
	|	ЛЕВОЕ СОЕДИНЕНИЕ
	|		Расчеты КАК РасчетыПоПретензиям
	|	ПО
	|		РасчетыПоПретензиям.Ссылка = Операция.Ссылка
	|		И РасчетыПоПретензиям.ДокументОбъектаРасчетов = Операция.Ссылка
	|	
	|	ВНУТРЕННЕЕ СОЕДИНЕНИЕ
	|		Расчеты КАК Расчеты
	|	ПО
	|		Расчеты.Ссылка = Операция.Ссылка
	|		И Расчеты.Валюта = ЕСТЬNULL(РасчетыПоПретензиям.Валюта, Операция.Валюта)
	|
	|	ЛЕВОЕ СОЕДИНЕНИЕ
	|		РасчетыСКлиентамиПоДокументам КАК РасчетыПоДокументам
	|	ПО
	|		Расчеты.Ссылка = РасчетыПоДокументам.Ссылка
	|		И Расчеты.ОбъектРасчетов = РасчетыПоДокументам.ОбъектРасчетов
	|		И Расчеты.Валюта = РасчетыПоДокументам.Валюта
	|		И Расчеты.СтатьяДвиженияДенежныхСредств = РасчетыПоДокументам.СтатьяДвиженияДенежныхСредств
	|ГДЕ
	|	Операция.ХозяйственнаяОперация = ЗНАЧЕНИЕ(Перечисление.ХозяйственныеОперации.ВозвратОплатыКлиенту)
	|	И ЕСТЬNULL(-РасчетыПоДокументам.ПредоплатаРегл + РасчетыПоДокументам.ДолгРегл, Расчеты.СуммаРегл) + ЕСТЬNULL(-РасчетыПоДокументам.ПредоплатаУпр + РасчетыПоДокументам.ДолгУпр, Расчеты.СуммаУпр) <> 0
	|";

	ТекстЗапроса = СтрШаблон(ТекстЗапроса, 
		НСтр("ru='Возврат клиенту аванса';uk='Повернення клієнту авансу'",ЯзыкСодержания),НСтр("ru='Возврат денежных средств клиенту';uk='Повернення коштів клієнту'",ЯзыкСодержания));
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
	
	ТекстыЗапроса = Новый Массив;
	
	#Область РасчетыСКлиентамиПоДокументам
	
	ТекстЗапроса = "
	|ВЫБРАТЬ
	|	Расчеты.Регистратор КАК Ссылка,
	|	Расчеты.ЗаказКлиента КАК ОбъектРасчетов,
	|	Расчеты.РасчетныйДокумент,
	|	Расчеты.Валюта,
	|	Расчеты.СтатьяДвиженияДенежныхСредств,
	|	СУММА(ВЫБОР КОГДА Расчеты.ВидДвижения = ЗНАЧЕНИЕ(ВидДвиженияНакопления.Приход) ТОГДА 1 ИНАЧЕ -1 КОНЕЦ * Расчеты.Предоплата) КАК Предоплата,
	|	СУММА(ВЫБОР КОГДА Расчеты.ВидДвижения = ЗНАЧЕНИЕ(ВидДвиженияНакопления.Приход) ТОГДА 1 ИНАЧЕ -1 КОНЕЦ * Расчеты.ПредоплатаУпр) КАК ПредоплатаУпр,
	|	СУММА(ВЫБОР КОГДА Расчеты.ВидДвижения = ЗНАЧЕНИЕ(ВидДвиженияНакопления.Приход) ТОГДА 1 ИНАЧЕ -1 КОНЕЦ * Расчеты.ПредоплатаРегл) КАК ПредоплатаРегл,
	|	СУММА(ВЫБОР КОГДА Расчеты.ВидДвижения = ЗНАЧЕНИЕ(ВидДвиженияНакопления.Приход) ТОГДА 1 ИНАЧЕ -1 КОНЕЦ * Расчеты.Долг) КАК Долг,
	|	СУММА(ВЫБОР КОГДА Расчеты.ВидДвижения = ЗНАЧЕНИЕ(ВидДвиженияНакопления.Приход) ТОГДА 1 ИНАЧЕ -1 КОНЕЦ * Расчеты.ДолгУпр) КАК ДолгУпр,
	|	СУММА(ВЫБОР КОГДА Расчеты.ВидДвижения = ЗНАЧЕНИЕ(ВидДвиженияНакопления.Приход) ТОГДА 1 ИНАЧЕ -1 КОНЕЦ * Расчеты.ДолгРегл) КАК ДолгРегл,
	|	СУММА(ВЫБОР КОГДА Расчеты.ВидДвижения = ЗНАЧЕНИЕ(ВидДвиженияНакопления.Приход) ТОГДА 1 ИНАЧЕ -1 КОНЕЦ * Расчеты.ЗалогЗаТару) КАК ЗалогЗаТару,
	|	СУММА(ВЫБОР КОГДА Расчеты.ВидДвижения = ЗНАЧЕНИЕ(ВидДвиженияНакопления.Приход) ТОГДА 1 ИНАЧЕ -1 КОНЕЦ * Расчеты.ЗалогЗаТаруРегл) КАК ЗалогЗаТаруРегл
	|
	|ПОМЕСТИТЬ РасчетыСКлиентамиПоДокументам
	|ИЗ
	|	ДокументыКОтражению КАК ДокументыКОтражению
	|	ВНУТРЕННЕЕ СОЕДИНЕНИЕ
	|		РегистрНакопления.РасчетыСКлиентамиПоДокументам КАК Расчеты
	|	ПО
	|		ДокументыКОтражению.Ссылка = Расчеты.Регистратор
	|		И НЕ &НоваяАрхитектураВзаиморасчетов
	|
	|СГРУППИРОВАТЬ ПО
	|	Расчеты.Регистратор,
	|	Расчеты.ЗаказКлиента,
	|	Расчеты.РасчетныйДокумент,
	|	Расчеты.Валюта,
	|	Расчеты.СтатьяДвиженияДенежныхСредств
	|
	|ОБЪЕДИНИТЬ ВСЕ
	|
	|ВЫБРАТЬ
	|	Расчеты.Ссылка КАК Ссылка,
	|	Расчеты.ОбъектРасчетов,
	|	Расчеты.РасчетныйДокумент,
	|	Расчеты.Валюта КАК Валюта,
	|	Расчеты.СтатьяДвиженияДенежныхСредств КАК СтатьяДвиженияДенежныхСредств,
	|	СУММА(Расчеты.Предоплата) КАК Предоплата,
	|	СУММА(Расчеты.ПредоплатаУпр) КАК ПредоплатаУпр,
	|	СУММА(Расчеты.ПредоплатаРегл) КАК ПредоплатаРегл,
	|	СУММА(Расчеты.Долг) КАК Долг,
	|	СУММА(Расчеты.ДолгУпр) КАК ДолгУпр,
	|	СУММА(Расчеты.ДолгРегл) КАК ДолгРегл,
	|	СУММА(Расчеты.ЗалогЗаТару) КАК ЗалогЗаТару,
	|	СУММА(Расчеты.ЗалогЗаТаруРегл) КАК ЗалогЗаТаруРегл
	|ИЗ
	|	РасчетыСКлиентамиНоваяАрхитектура КАК Расчеты
	|
	|СГРУППИРОВАТЬ ПО
	|	Расчеты.Ссылка,
	|	Расчеты.ОбъектРасчетов,
	|	Расчеты.РасчетныйДокумент,
	|	Расчеты.Валюта,
	|	Расчеты.СтатьяДвиженияДенежныхСредств
	|	
	|ИНДЕКСИРОВАТЬ ПО
	|	Ссылка";
	
	ТекстыЗапроса.Добавить(ТекстЗапроса);
	
	#КонецОбласти
	
	#Область РасчетыСКлиентами
	
	ТекстЗапроса = "
	|ВЫБРАТЬ
	|	Расчеты.Регистратор КАК Ссылка,
	|	ОбъектыРасчетов.Контрагент КАК Контрагент,
	|	ОбъектыРасчетов.Договор КАК Договор,
	|	ОбъектыРасчетов.НаправлениеДеятельности КАК НаправлениеДеятельности,
	|	ОбъектыРасчетов.Объект КАК ДокументОбъектаРасчетов,
	|	ОбъектыРасчетов.Ссылка КАК ОбъектРасчетов,
	|	ОбъектыРасчетов.ГруппаФинансовогоУчета КАК ГруппаФинансовогоУчета,
	|	ОбъектыРасчетов.Подразделение КАК Подразделение,
	|	Расчеты.Валюта,
	|	Расчеты.СтатьяДвиженияДенежныхСредств,
	|	СУММА(ВЫБОР КОГДА Расчеты.ВидДвижения = ЗНАЧЕНИЕ(ВидДвиженияНакопления.Приход) Тогда 1 ИНАЧЕ -1 КОНЕЦ * Расчеты.Сумма) КАК Сумма,
	|	СУММА(ВЫБОР КОГДА Расчеты.ВидДвижения = ЗНАЧЕНИЕ(ВидДвиженияНакопления.Приход) Тогда 1 ИНАЧЕ -1 КОНЕЦ * Расчеты.СуммаУпр) КАК СуммаУпр,
	|	СУММА(ВЫБОР КОГДА Расчеты.ВидДвижения = ЗНАЧЕНИЕ(ВидДвиженияНакопления.Приход) Тогда 1 ИНАЧЕ -1 КОНЕЦ * Расчеты.СуммаРегл) КАК СуммаРегл
	|ПОМЕСТИТЬ Расчеты
	|ИЗ
	|	ДокументыКОтражению КАК ДокументыКОтражению
	|	ВНУТРЕННЕЕ СОЕДИНЕНИЕ
	|		РегистрНакопления.РасчетыСКлиентами КАК Расчеты
	|	ПО
	|		ДокументыКОтражению.Ссылка = Расчеты.Регистратор
	|	ВНУТРЕННЕЕ СОЕДИНЕНИЕ Справочник.ОбъектыРасчетов КАК ОбъектыРасчетов
	|	ПО (Расчеты.ОбъектРасчетов = ОбъектыРасчетов.Ссылка)
	|	
	|СГРУППИРОВАТЬ ПО
	|	Расчеты.Регистратор,
	|	ОбъектыРасчетов.Контрагент,
	|	ОбъектыРасчетов.Договор,
	|	ОбъектыРасчетов.НаправлениеДеятельности,
	|	ОбъектыРасчетов.Объект,
	|	ОбъектыРасчетов.Ссылка,
	|	ОбъектыРасчетов.ГруппаФинансовогоУчета,
	|	ОбъектыРасчетов.Подразделение,
	|	Расчеты.Валюта,
	|	Расчеты.СтатьяДвиженияДенежныхСредств
	|	
	|ИНДЕКСИРОВАТЬ ПО
	|	Ссылка";
	
	ТекстыЗапроса.Добавить(ТекстЗапроса);
	
	#КонецОбласти
	
	ТекстЗапроса = СтрСоединить(ТекстыЗапроса, ОбщегоНазначения.РазделительПакетаЗапросов());
	ТекстЗапроса = ТекстЗапроса + ОбщегоНазначения.РазделительПакетаЗапросов();
	Возврат ТекстЗапроса;
	
	//-- Локализация
	Возврат "";
	
КонецФункции

#КонецОбласти

//-- НЕ УТ

#Область Фискализация

//++ Локализация
//-- Локализация

#КонецОбласти

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
