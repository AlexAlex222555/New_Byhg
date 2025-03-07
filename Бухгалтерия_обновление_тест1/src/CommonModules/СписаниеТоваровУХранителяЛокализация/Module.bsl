
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
//  РежимЗаписи - РежимЗаписиДокумента - В параметр передается текущий режим записи документа. Позволяет определить в теле процедуры режим записи.
//  РежимПроведения - РежимПроведенияДокумента - В данный параметр передается текущий режим проведения.
//
Процедура ПередЗаписью(Объект, Отказ, РежимЗаписи, РежимПроведения) Экспорт
	
	
КонецПроцедуры

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

// Добавляет команду создания документа "Авансовый отчет".
//
// Параметры:
//  КомандыСозданияНаОсновании - см. СозданиеНаОснованииПереопределяемый.ПередДобавлениемКомандСозданияНаОсновании.КомандыСозданияНаОсновании
//
Процедура ДобавитьКомандуСоздатьНаОсновании(КомандыСозданияНаОсновании) Экспорт
	
	
КонецПроцедуры

// Определяет список команд создания на основании.
//
// Параметры:
//  КомандыСозданияНаОсновании - см. СозданиеНаОснованииПереопределяемый.ПередДобавлениемКомандСозданияНаОсновании.КомандыСозданияНаОсновании
//  Параметры - см. СозданиеНаОснованииПереопределяемый.ПередДобавлениемКомандСозданияНаОсновании.Параметры
//
Процедура ДобавитьКомандыСозданияНаОсновании(КомандыСозданияНаОсновании, Параметры) Экспорт
	
	
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

#Область СписаниеТоваровПринятыхНаОтветХранение  
	ТекстЗапроса = "
	|ВЫБРАТЬ //// Списание товаров у хранителя (Дт 0234 :: Кт 0233)
	|
	|	Операция.Ссылка КАК Ссылка,
	|	Операция.Дата КАК Период,
	|	Операция.Организация КАК Организация,
	|	НЕОПРЕДЕЛЕНО КАК ИдентификаторСтроки,
	|
	|	ЕСТЬNULL(Стоимости.Сумма, Строки.Сумма) КАК Сумма,
	|	ЕСТЬNULL(Стоимости.СуммаУУ, Строки.СуммаУУ) КАК СуммаУУ,
	|
	|	ЗНАЧЕНИЕ(Перечисление.ВидыСчетовРеглУчета.ТМЦКСписанию) КАК ВидСчетаДт,
	|	Строки.ГруппаФинансовогоУчета КАК АналитикаУчетаДт,
	|	Строки.Склад КАК МестоУчетаДт,
	|
	|	НЕОПРЕДЕЛЕНО КАК ВалютаДт,
	|	НЕОПРЕДЕЛЕНО КАК ПодразделениеДт,
	|	ЗНАЧЕНИЕ(Справочник.НаправленияДеятельности.ПустаяСсылка) КАК НаправлениеДеятельностиДт,
	|	НЕОПРЕДЕЛЕНО КАК НалоговоеНазначениеДт,	
	|
	|	НЕОПРЕДЕЛЕНО КАК СчетДт,
	|	Строки.Номенклатура КАК СубконтоДт1,
	|	Строки.Контрагент КАК СубконтоДт2,
	|	НЕОПРЕДЕЛЕНО КАК СубконтоДт3,
	|
	|	0 КАК ВалютнаяСуммаДт,
	|	0 КАК КоличествоДт,
	|	0 КАК СуммаНУДт,
	|	0 КАК СуммаПРДт,
	|	0 КАК СуммаВРДт,
	|
	|	ЗНАЧЕНИЕ(Перечисление.ВидыСчетовРеглУчета.ТМЦУХранителей) КАК ВидСчетаКт,
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
	|	Операция.Контрагент КАК СубконтоКт3,
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
	|		Документ.СписаниеТоваровУХранителя КАК Операция
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
	|ГДЕ
	|	Строки.РазделУчета = ЗНАЧЕНИЕ(Перечисление.РазделыУчетаСебестоимостиТоваров.ТоварыНаХраненииСПравомПродажиПереданныеПартнерам)
	|";     

	ТекстЗапроса = СтрШаблон(ТекстЗапроса, 
		НСтр("ru='Списание товаров у хранителя';uk='Списання товарів у зберігача'",ЯзыкСодержания));

	ТекстыОтражения.Добавить(ТекстЗапроса);

#КонецОбласти

#Область СписаниеТоваровНаРасходы 
	ТекстЗапроса = "
	|ВЫБРАТЬ //// Списание на расходы товаров (Дт 23, 9X :: Кт 28)
	|	Операция.Ссылка КАК Ссылка,
	|	Операция.Дата КАК Период,
	|	Операция.Организация КАК Организация,
	|	НЕОПРЕДЕЛЕНО КАК ИдентификаторСтроки,
	|	
	|	ЕСТЬNULL(Стоимости.Сумма, Строки.Сумма) КАК Сумма,
	|	ЕСТЬNULL(Стоимости.СуммаУУ, Строки.СуммаУУ) КАК СуммаУУ,
	|	
	|	ЗНАЧЕНИЕ(Перечисление.ВидыСчетовРеглУчета.Расходы) КАК ВидСчетаДт,
	|	Операция.СтатьяРасходов КАК АналитикаУчетаДт,
	|	Операция.Подразделение КАК МестоУчетаДт,
	|	
	|	ЗНАЧЕНИЕ(Справочник.Валюты.ПустаяСсылка) КАК ВалютаДт,
	|	Операция.Подразделение КАК ПодразделениеДт,
	|	ЕСТЬNULL(Стоимости.КорНаправлениеДеятельности, Строки.КорНаправлениеДеятельности) КАК НаправлениеДеятельностиДт,
	|	НЕОПРЕДЕЛЕНО КАК НалоговоеНазначениеДт,	
	|
	|	ЗНАЧЕНИЕ(ПланСчетов.Хозрасчетный.ПустаяСсылка) КАК СчетДт,
    |	ЗНАЧЕНИЕ(Перечисление.ТипыЗатратРегл.Прочее) КАК СубконтоДт1,
	|	Операция.СтатьяРасходов КАК СубконтоДт2,
	|	Операция.АналитикаРасходов КАК СубконтоДт3, 
	|	
	|	0 КАК ВалютнаяСуммаДт,
	|	0 КАК КоличествоДт,
	|	0 КАК СуммаНУДт,
	|	0 КАК СуммаПРДт,
	|	0 КАК СуммаВРДт,
	|	
	|	ВЫБОР КОГДА Строки.Склад ССЫЛКА Справочник.ДоговорыКонтрагентов ТОГДА
	|		ЗНАЧЕНИЕ(Перечисление.ВидыСчетовРеглУчета.НоменклатураПереданная)
	|	ИНАЧЕ
	|		ЗНАЧЕНИЕ(Перечисление.ВидыСчетовРеглУчета.НаСкладе)
	|	КОНЕЦ КАК ВидСчетаКт,
	|	
	|	Строки.ГруппаФинансовогоУчета КАК АналитикаУчетаКт,
	|	Строки.Склад КАК МестоУчетаКт,
	|	
	|	ЗНАЧЕНИЕ(Справочник.Валюты.ПустаяСсылка) КАК ВалютаКт,
	|	Строки.ПодразделениеАналитики КАК ПодразделениеКт,
	|	ВЫБОР КОГДА Строки.Склад ССЫЛКА Справочник.ДоговорыКонтрагентов ТОГДА
	|		ЕСТЬNULL(Стоимости.КорНаправлениеДеятельности, Строки.КорНаправлениеДеятельности)
	|	ИНАЧЕ
	|		ЕСТЬNULL(Стоимости.НаправлениеДеятельности, Строки.НаправлениеДеятельности)
	|	КОНЕЦ КАК НаправлениеДеятельностиКт,
	|	НЕОПРЕДЕЛЕНО КАК НалоговоеНазначениеКт,	
	|	
	|	НЕОПРЕДЕЛЕНО КАК СчетКт,
	|	
	|	ВЫБОР КОГДА Строки.Склад ССЫЛКА Справочник.ДоговорыКонтрагентов ТОГДА
	|		Строки.Контрагент
	|	ИНАЧЕ
	|		Строки.Номенклатура
	|	КОНЕЦ КАК СубконтоКт1,
	|	
	|	ВЫБОР КОГДА Строки.Склад ССЫЛКА Справочник.ДоговорыКонтрагентов ТОГДА
	|		Строки.Номенклатура
	|	ИНАЧЕ
	|		Строки.Склад
	|	КОНЕЦ КАК СубконтоКт2,
	|	НЕОПРЕДЕЛЕНО КАК СубконтоКт3,
	|	
	|	0 КАК ВалютнаяСуммаКт,
	|	Строки.Количество КАК КоличествоКт,
	|	0 КАК СуммаНУКт,
	|	0 КАК СуммаПРКт,
	|	0 КАК СуммаВРКт,
	|	""%1"" КАК Содержание
	|ИЗ
	|	ДокументыКОтражению КАК ДокументыКОтражению
	|	
	|	ВНУТРЕННЕЕ СОЕДИНЕНИЕ
	|		Документ.СписаниеТоваровУХранителя КАК Операция
	|	ПО
	|		ДокументыКОтражению.Ссылка = Операция.Ссылка
	|	
	|	ВНУТРЕННЕЕ СОЕДИНЕНИЕ
	|		ВтСтроки КАК Строки
	|	ПО
	|		Операция.Ссылка = Строки.Ссылка
	|		И Строки.ВидДвижения = ЗНАЧЕНИЕ(ВидДвиженияНакопления.Расход)
	|		И Строки.РазделУчета <> ЗНАЧЕНИЕ(Перечисление.РазделыУчетаСебестоимостиТоваров.ТоварыНаХраненииСПравомПродажиПереданныеПартнерам)
	|	
	|	ЛЕВОЕ СОЕДИНЕНИЕ
	|		ВтСтоимости КАК Стоимости
	|	ПО
	|		Строки.Ссылка = Стоимости.Ссылка
	|		И Строки.Номенклатура = Стоимости.Номенклатура
	|		И Строки.Склад = Стоимости.Склад
	|		И Строки.ГруппаФинансовогоУчета = Стоимости.ГруппаФинансовогоУчета
	|		И Строки.ТипЗапасов = Стоимости.ТипЗапасов
	|		И Строки.Контрагент = Стоимости.Контрагент
	|		И Строки.СтатьяРасходов = Стоимости.СтатьяРасходов
	|		И Строки.АналитикаРасходов = Стоимости.АналитикаРасходов
	|		И Строки.РазделУчета = Стоимости.РазделУчета
	|		И Строки.ГруппаПродукции = Стоимости.ГруппаПродукции
	|		И Строки.ИдентификаторСтроки = Стоимости.ИдентификаторСтроки
	|		И Строки.НаправлениеДеятельности = Стоимости.НаправлениеДеятельности
	|		И Строки.КорНаправлениеДеятельности = Стоимости.КорНаправлениеДеятельности
	|	
	|	ЛЕВОЕ СОЕДИНЕНИЕ
	|		ПланВидовХарактеристик.СтатьиРасходов КАК СтатьиНаПрочиеАктивы
	|	ПО
	|		Операция.СтатьяРасходов = СтатьиНаПрочиеАктивы.Ссылка
	|		И СтатьиНаПрочиеАктивы.ВариантРаспределенияРасходовРегл = ЗНАЧЕНИЕ(Перечисление.ВариантыРаспределенияРасходов.НаПрочиеАктивы)
	|	
	|	ЛЕВОЕ СОЕДИНЕНИЕ 
	|		Справочник.ОбъектыСтроительства КАК ОбъектыСтроительства
	|	ПО 
	|		ОбъектыСтроительства.Ссылка = Операция.АналитикаРасходов
	|ГДЕ
	|	Операция.СтатьяРасходов ССЫЛКА ПланВидовХарактеристик.СтатьиРасходов
	|	И СтатьиНаПрочиеАктивы.Ссылка ЕСТЬ NULL
	|";

	ТекстЗапроса = СтрШаблон(ТекстЗапроса, 
		НСтр("ru='Списание товаров на расходы';uk='Списання товарів на витрати'",ЯзыкСодержания));

	ТекстыОтражения.Добавить(ТекстЗапроса);
#КонецОбласти

#Область СписаниеТоваровНаПрочиеАктивы 
	ТекстЗапроса = "
	|ВЫБРАТЬ //// Списание на прочие активы (Дт ХХ :: Кт 28)
	|	Операция.Ссылка КАК Ссылка,
	|	Операция.Дата КАК Период,
	|	Операция.Организация КАК Организация,
	|	"""" КАК ИдентификаторСтроки,
	|
	|	ЕСТЬNULL(Стоимости.Сумма, Строки.Сумма) КАК Сумма,
	|	ЕСТЬNULL(Стоимости.СуммаУУ, Строки.СуммаУУ) КАК СуммаУУ,
	|
	|	ЗНАЧЕНИЕ(Перечисление.ВидыСчетовРеглУчета.ПрочиеОперации) КАК ВидСчетаДт,
	|	НЕОПРЕДЕЛЕНО КАК АналитикаУчетаДт,
	|	НЕОПРЕДЕЛЕНО КАК МестоУчетаДт,
	|
	|	ЗНАЧЕНИЕ(Справочник.Валюты.ПустаяСсылка) КАК ВалютаДт,
	|	Операция.Подразделение КАК ПодразделениеДт,
	|	ЗНАЧЕНИЕ(Справочник.НаправленияДеятельности.ПустаяСсылка) КАК НаправлениеДеятельностиДт,
	|	НЕОПРЕДЕЛЕНО КАК НалоговоеНазначениеДт,	
	|
	|	ЗНАЧЕНИЕ(ПланСчетов.Хозрасчетный.ПустаяСсылка) КАК СчетДт,
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
	|	ВЫБОР КОГДА Строки.Склад ССЫЛКА Справочник.ДоговорыКонтрагентов ТОГДА
	|		ЗНАЧЕНИЕ(Перечисление.ВидыСчетовРеглУчета.НоменклатураПереданная)
	|	ИНАЧЕ
	|		ЗНАЧЕНИЕ(Перечисление.ВидыСчетовРеглУчета.НаСкладе)
	|	КОНЕЦ КАК ВидСчетаКт,
	|	
	|	Строки.ГруппаФинансовогоУчета КАК АналитикаУчетаКт,
	|	Строки.Склад КАК МестоУчетаКт,
	|	
	|	ЗНАЧЕНИЕ(Справочник.Валюты.ПустаяСсылка) КАК ВалютаКт,
	|	Строки.ПодразделениеАналитики КАК ПодразделениеКт,
	|	ВЫБОР КОГДА Строки.Склад ССЫЛКА Справочник.ДоговорыКонтрагентов ТОГДА
	|		ЕСТЬNULL(Стоимости.КорНаправлениеДеятельности, Строки.КорНаправлениеДеятельности)
	|	ИНАЧЕ
	|		ЕСТЬNULL(Стоимости.НаправлениеДеятельности, Строки.НаправлениеДеятельности)
	|	КОНЕЦ КАК НаправлениеДеятельностиКт,
	|	НЕОПРЕДЕЛЕНО КАК НалоговоеНазначениеКт,	
	|	
	|	НЕОПРЕДЕЛЕНО КАК СчетКт,
	|	
	|	ВЫБОР КОГДА Строки.Склад ССЫЛКА Справочник.ДоговорыКонтрагентов ТОГДА
	|		Строки.Контрагент
	|	ИНАЧЕ
	|		Строки.Номенклатура
	|	КОНЕЦ КАК СубконтоКт1,
	|	
	|	ВЫБОР КОГДА Строки.Склад ССЫЛКА Справочник.ДоговорыКонтрагентов ТОГДА
	|		Строки.Номенклатура
	|	ИНАЧЕ
	|		Строки.Склад
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
	|		Документ.СписаниеТоваровУХранителя КАК Операция
	|	ПО
	|		ДокументыКОтражению.Ссылка = Операция.Ссылка
	|	
	|	ВНУТРЕННЕЕ СОЕДИНЕНИЕ
	|		ВтСтроки КАК Строки
	|	ПО
	|		Операция.Ссылка = Строки.Ссылка
	|		И Строки.ВидДвижения = ЗНАЧЕНИЕ(ВидДвиженияНакопления.Расход)
	|		И Строки.РазделУчета <> ЗНАЧЕНИЕ(Перечисление.РазделыУчетаСебестоимостиТоваров.ТоварыНаХраненииСПравомПродажиПереданныеПартнерам)
	|
	|	ЛЕВОЕ СОЕДИНЕНИЕ
	|		ВтСтоимости КАК Стоимости
	|	ПО
	|		Строки.Ссылка = Стоимости.Ссылка
	|		И Строки.Номенклатура = Стоимости.Номенклатура
	|		И Строки.Склад = Стоимости.Склад
	|		И Строки.ГруппаФинансовогоУчета = Стоимости.ГруппаФинансовогоУчета
	|		И Строки.ТипЗапасов = Стоимости.ТипЗапасов
	|		И Строки.Контрагент = Стоимости.Контрагент
	|		И Строки.СтатьяРасходов = Стоимости.СтатьяРасходов
	|		И Строки.АналитикаРасходов = Стоимости.АналитикаРасходов
	|		И Строки.РазделУчета = Стоимости.РазделУчета
	|		И Строки.ИдентификаторСтроки = Стоимости.ИдентификаторСтроки
	|
	|	ВНУТРЕННЕЕ СОЕДИНЕНИЕ
	|		ПланВидовХарактеристик.СтатьиРасходов КАК СтатьиНаПрочиеАктивы
	|	ПО
	|		Операция.СтатьяРасходов = СтатьиНаПрочиеАктивы.Ссылка
	|		И СтатьиНаПрочиеАктивы.ВариантРаспределенияРасходовРегл = ЗНАЧЕНИЕ(Перечисление.ВариантыРаспределенияРасходов.НаПрочиеАктивы)
	|";                 

	ТекстЗапроса = СтрШаблон(ТекстЗапроса, 
		НСтр("ru='Списание на прочие активы';uk='Списання на інші активи'",ЯзыкСодержания));

	ТекстыОтражения.Добавить(ТекстЗапроса);
#КонецОбласти

#Область СписаниеТоваровНаСтатьиАктивовПассивов 
	ТекстЗапроса = "
	|ВЫБРАТЬ //// Списание на прочие активы (Дт ХХ :: Кт 28)
	|	Операция.Ссылка КАК Ссылка,
	|	Операция.Дата КАК Период,
	|	Операция.Организация КАК Организация,
	|	"""" КАК ИдентификаторСтроки,
	|
	|	ЕСТЬNULL(Стоимости.Сумма, Строки.Сумма) КАК Сумма,	
	|	ЕСТЬNULL(Стоимости.СуммаУУ, Строки.СуммаУУ) КАК СуммаУУ,
	|
	|	ЗНАЧЕНИЕ(Перечисление.ВидыСчетовРеглУчета.ПрочиеАктивыПассивы) КАК ВидСчетаДт,
	|	НЕОПРЕДЕЛЕНО КАК АналитикаУчетаДт,
	|	НЕОПРЕДЕЛЕНО КАК МестоУчетаДт,
	|
	|	ЗНАЧЕНИЕ(Справочник.Валюты.ПустаяСсылка) КАК ВалютаДт,
	|	Операция.Подразделение КАК ПодразделениеДт,
	|	ЕСТЬNULL(Стоимости.НаправлениеДеятельности, Строки.НаправлениеДеятельности) КАК НаправлениеДеятельностиДт,
	|	НЕОПРЕДЕЛЕНО КАК НалоговоеНазначениеДт,	
	|
	|	Операция.СчетУчета КАК СчетДт,
	|	Операция.Субконто1 КАК СубконтоДт1,
	|	Операция.Субконто2 КАК СубконтоДт2,
	|	Операция.Субконто3 КАК СубконтоДт3,
	|
	|	0 КАК ВалютнаяСуммаДт,
	|	0 КАК КоличествоДт,
	|	0 КАК СуммаНУДт,
	|	0 КАК СуммаПРДт,
	|	0 КАК СуммаВРДт,
	|
	|	ВЫБОР КОГДА Строки.Склад ССЫЛКА Справочник.ДоговорыКонтрагентов ТОГДА
	|		ЗНАЧЕНИЕ(Перечисление.ВидыСчетовРеглУчета.НоменклатураПереданная)
	|	ИНАЧЕ
	|		ЗНАЧЕНИЕ(Перечисление.ВидыСчетовРеглУчета.НаСкладе)
	|	КОНЕЦ КАК ВидСчетаКт,
	|	
	|	Строки.ГруппаФинансовогоУчета КАК АналитикаУчетаКт,
	|	Строки.Склад КАК МестоУчетаКт,
	|	
	|	ЗНАЧЕНИЕ(Справочник.Валюты.ПустаяСсылка) КАК ВалютаКт,
	|	Строки.ПодразделениеАналитики КАК ПодразделениеКт,
	|	ВЫБОР КОГДА Строки.Склад ССЫЛКА Справочник.ДоговорыКонтрагентов ТОГДА
	|		ЕСТЬNULL(Стоимости.КорНаправлениеДеятельности, Строки.КорНаправлениеДеятельности)
	|	ИНАЧЕ
	|		ЕСТЬNULL(Стоимости.НаправлениеДеятельности, Строки.НаправлениеДеятельности)
	|	КОНЕЦ КАК НаправлениеДеятельностиКт,
	|	НЕОПРЕДЕЛЕНО КАК НалоговоеНазначениеКт,	
	|	
	|	НЕОПРЕДЕЛЕНО КАК СчетКт,
	|	
	|	ВЫБОР КОГДА Строки.Склад ССЫЛКА Справочник.ДоговорыКонтрагентов ТОГДА
	|		Строки.Контрагент
	|	ИНАЧЕ
	|		Строки.Номенклатура
	|	КОНЕЦ КАК СубконтоКт1,
	|	
	|	ВЫБОР КОГДА Строки.Склад ССЫЛКА Справочник.ДоговорыКонтрагентов ТОГДА
	|		Строки.Номенклатура
	|	ИНАЧЕ
	|		Строки.Склад
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
	|		Документ.СписаниеТоваровУХранителя КАК Операция
	|	ПО
	|		ДокументыКОтражению.Ссылка = Операция.Ссылка
	|	
	|	ВНУТРЕННЕЕ СОЕДИНЕНИЕ
	|		ВтСтроки КАК Строки
	|	ПО
	|		Операция.Ссылка = Строки.Ссылка
	|		И Строки.ВидДвижения = ЗНАЧЕНИЕ(ВидДвиженияНакопления.Расход)
	|		И Строки.РазделУчета <> ЗНАЧЕНИЕ(Перечисление.РазделыУчетаСебестоимостиТоваров.ТоварыНаХраненииСПравомПродажиПереданныеПартнерам)
	|
	|	ЛЕВОЕ СОЕДИНЕНИЕ
	|		ВтСтоимости КАК Стоимости
	|	ПО
	|		Строки.Ссылка = Стоимости.Ссылка
	|		И Строки.Номенклатура = Стоимости.Номенклатура
	|		И Строки.Склад = Стоимости.Склад
	|		И Строки.ГруппаФинансовогоУчета = Стоимости.ГруппаФинансовогоУчета
	|		И Строки.ТипЗапасов = Стоимости.ТипЗапасов
	|		И Строки.Контрагент = Стоимости.Контрагент
	|		И Строки.СтатьяРасходов = Стоимости.СтатьяРасходов
	|		И Строки.АналитикаРасходов = Стоимости.АналитикаРасходов
	|		И Строки.РазделУчета = Стоимости.РазделУчета
	|		И Строки.ИдентификаторСтроки = Стоимости.ИдентификаторСтроки
	|
	|ГДЕ
	|	Операция.СтатьяРасходов ССЫЛКА ПланВидовХарактеристик.СтатьиАктивовПассивов
	|";       

	ТекстЗапроса = СтрШаблон(ТекстЗапроса, 
		НСтр("ru='Списание на прочие активы';uk='Списання на інші активи'",ЯзыкСодержания));

	ТекстыОтражения.Добавить(ТекстЗапроса);
#КонецОбласти

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
	|	ЗНАЧЕНИЕ(Перечисление.ВидыСчетовРеглУчета.СебестоимостьПродаж) КАК ВидСчетаДт,
	|	Партии.ГруппаФинансовогоУчета КАК АналитикаУчетаДт,
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
	|
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
	|		Документ.СписаниеТоваровУХранителя КАК Операция
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
		НСтр("ru='Условная продажа';uk='Умовний продаж'",ЯзыкСодержания),
		НСтр("ru='Сторно условной продажи';uk='Сторно умовного продажу'",ЯзыкСодержания));
	
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
	Возврат "";
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
	ТекстЗапросаТаблицаОтражениеДокументовВРеглУчете(Запрос, ТекстыЗапроса, Регистры);
	//-- НЕ УТ
	//-- Локализация
	
КонецПроцедуры

//++ Локализация

//++ НЕ УТ
Функция ТекстЗапросаТаблицаОтражениеДокументовВРеглУчете(Запрос, ТекстыЗапроса, Регистры)
	
	ИмяРегистра = "ОтражениеДокументовВРеглУчете";
	
	Если Не ПроведениеДокументов.ТребуетсяТаблицаДляДвижений(ИмяРегистра, Регистры) Тогда
		Возврат "";
	КонецЕсли;
	
	ТекстЗапроса =
	"ВЫБРАТЬ
	|	&Период                      КАК Период,
	|	&Организация                 КАК Организация,
	|	НАЧАЛОПЕРИОДА(&Период, ДЕНЬ) КАК ДатаОтражения";
	
	ТекстыЗапроса.Добавить(ТекстЗапроса, ИмяРегистра);
	
	Возврат ТекстЗапроса;
	
КонецФункции
//-- НЕ УТ
//-- Локализация

//++ НЕ УТ
#Область ПроводкиРеглУчета

//++ Локализация
//-- Локализация
#КонецОбласти
//-- НЕ УТ

#КонецОбласти

#Область Прочее

#КонецОбласти

#КонецОбласти
