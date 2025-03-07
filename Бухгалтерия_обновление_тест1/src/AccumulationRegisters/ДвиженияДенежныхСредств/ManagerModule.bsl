#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

//++ НЕ УТ
#Область ПрограммныйИнтерфейс

// Определяет показатели регистра.
// Подробнее см. ОбщийМодуль.МеждународныйУчетСерверПовтИсп.Показатели().
//
// Параметры:
//  Свойства - Структура - содержащая ключи СвойстваПоказателей, СвойстваРесурсов.
//
// Возвращаемое значение:
//  Соответствие - Ключ - имя показателя.
//                 Значение - структура свойств показателя.
//
Функция Показатели(Свойства) Экспорт

	Показатели = Новый Соответствие;
	
	СвойстваПоказателей = Свойства.СвойстваПоказателей;
	СвойстваРесурсов = Свойства.СвойстваРесурсов;
	
	// Массив содержит не только ресурсы регистров, но и производные от них поля в запросах.
	МассивРесурсов = Новый Массив;
	МассивРесурсов.Добавить(Новый Структура(СвойстваРесурсов, "Сумма", "ВалютаУпр"));
	МассивРесурсов.Добавить(Новый Структура(СвойстваРесурсов, "СуммаРегл", "ВалютаРегл"));
	МассивРесурсов.Добавить(Новый Структура(СвойстваРесурсов, "СуммаВВалюте", "Валюта"));
	МассивРесурсов.Добавить(Новый Структура(СвойстваРесурсов, "СуммаВКорВалюте", "КорВалюта"));
	
	Показатели.Вставить(Перечисления.ПоказателиАналитическихРегистров.Сумма, Новый Структура(СвойстваПоказателей, МассивРесурсов));
	
	МассивРесурсов = Новый Массив;
	МассивРесурсов.Добавить(Новый Структура(СвойстваРесурсов, "СуммаКВыплатеВРамкахЛимита", "Валюта"));
	Показатели.Вставить(Перечисления.ПоказателиАналитическихРегистров.СуммаКВыплатеВРамкахЛимита, Новый Структура(СвойстваПоказателей, МассивРесурсов));
	
	МассивРесурсов = Новый Массив;
	МассивРесурсов.Добавить(Новый Структура(СвойстваРесурсов, "СуммаКВыплатеСверхЛимита", "Валюта"));
	Показатели.Вставить(Перечисления.ПоказателиАналитическихРегистров.СуммаКВыплатеСверхЛимита, Новый Структура(СвойстваПоказателей, МассивРесурсов));
	
	МассивРесурсов = Новый Массив;
	МассивРесурсов.Добавить(Новый Структура(СвойстваРесурсов, "СуммаКВыплате", "Валюта"));
	Показатели.Вставить(Перечисления.ПоказателиАналитическихРегистров.СуммаКВыплате, Новый Структура(СвойстваПоказателей, МассивРесурсов));

	Возврат Показатели;
	
КонецФункции

#КонецОбласти
//-- НЕ УТ

#Область ДляВызоваИзДругихПодсистем

// СтандартныеПодсистемы.УправлениеДоступом

// См. УправлениеДоступомПереопределяемый.ПриЗаполненииСписковСОграничениемДоступа.
Процедура ПриЗаполненииОграниченияДоступа(Ограничение) Экспорт

	Ограничение.Текст =
	"РазрешитьЧтениеИзменение
	|ГДЕ
	|	ЗначениеРазрешено(Организация)
	|	И ЗначениеРазрешено(Подразделение)
	|	И( ВЫБОР КОГДА ТипЗначения(ДенежныеСредства) = Тип(Справочник.Кассы) ТОГДА ЗначениеРазрешено(ДенежныеСредства)
	|	КОГДА ТипЗначения(ДенежныеСредства) = Тип(Справочник.КассыККМ) ТОГДА ЗначениеРазрешено(ДенежныеСредства)
	|	КОГДА ТипЗначения(ДенежныеСредства) = Тип(Справочник.ФизическиеЛица) ТОГДА ЗначениеРазрешено(ДенежныеСредства)
	|	ИНАЧЕ ИСТИНА КОНЕЦ) ";

КонецПроцедуры

// Конец СтандартныеПодсистемы.УправлениеДоступом

#КонецОбласти

#Область ОбновлениеИнформационнойБазы


// Добавляет в список процедуры-обработчики обновления данных ИБ
// для всех поддерживаемых версий библиотеки или конфигурации.
// Вызывается перед началом обновления данных ИБ для построения плана обновления.
//
//  Обработчики - ТаблицаЗначений - описание полей, см. в процедуре
//                ОбновлениеИнформационнойБазы.НоваяТаблицаОбработчиковОбновления.
//
// Пример добавления процедуры-обработчика в список:
//  Обработчик = Обработчики.Добавить();
//  Обработчик.Версия              = "1.1.0.0";
//  Обработчик.Процедура           = "ОбновлениеИБ.ПерейтиНаВерсию_1_1_0_0";
//  Обработчик.МонопольныйРежим    = Ложь;
//
// Параметры:
// 	Обработчики - см. ОбновлениеИнформационнойБазы.НоваяТаблицаОбработчиковОбновления
//
Процедура ОписаниеОбработчиковОбновления(Обработчики) Экспорт

	Обработчик = Обработчики.Добавить();
	Обработчик.Версия = "3.5.4.400";
	Обработчик.РежимВыполнения = "Отложенно";
	Обработчик.Процедура = "РегистрыНакопления.ДвиженияДенежныхСредств.ОбработатьДанныеДляПереходаНаНовуюВерсию";
	Обработчик.Идентификатор = Новый УникальныйИдентификатор("4a11397f-08ba-4c10-a7d3-0b92b8ae1bbb");
	Обработчик.ПроцедураЗаполненияДанныхОбновления = "РегистрыНакопления.ДвиженияДенежныхСредств.ЗарегистрироватьДанныеКОбработкеДляПереходаНаНовуюВерсию";
	Обработчик.ПроцедураПроверки = "ОбновлениеИнформационнойБазы.ДанныеОбновленыНаНовуюВерсиюПрограммы";
	Обработчик.ЧитаемыеОбъекты = "РегистрНакопления.ДвиженияДенежныхСредств,"
		+ "Документ.ПоступлениеБезналичныхДенежныхСредств,"
	//++ НЕ УТ
		+ "Документ.ПоступлениеДенежныхДокументов,"
		+ "Документ.ВыбытиеДенежныхДокументов,"
	//-- НЕ УТ
		+ "Документ.СписаниеБезналичныхДенежныхСредств,"
		+ "Документ.ПриходныйКассовыйОрдер,"
		+ "Документ.АвансовыйОтчет,"
		+ "Документ.РасходныйКассовыйОрдер,"
		+ "Документ.ЗаявкаНаРасходованиеДенежныхСредств";
	Обработчик.ИзменяемыеОбъекты = "РегистрНакопления.ДвиженияДенежныхСредств";
	Обработчик.БлокируемыеОбъекты = "";
	Обработчик.Комментарий = НСтр("ru='Перезаполняет реквизиты регистра ""Движения денежных средств"" корректными значениями.';uk='Перезаповнює реквізити регістру ""Рухи грошових коштів"" коректними значеннями.'");
	Обработчик.ПриоритетыВыполнения = ОбновлениеИнформационнойБазы.ПриоритетыВыполненияОбработчика();

	НоваяСтрока = Обработчик.ПриоритетыВыполнения.Добавить();
	НоваяСтрока.Процедура = "Документы.АвансовыйОтчет.ОбработатьДанныеДляПереходаНаНовуюВерсию";
	НоваяСтрока.Порядок = "После";
	
	НоваяСтрока = Обработчик.ПриоритетыВыполнения.Добавить();
	НоваяСтрока.Процедура = "Документы.ЗаявкаНаРасходованиеДенежныхСредств.ОбработатьДанныеДляПереходаНаНовуюВерсию";
	НоваяСтрока.Порядок = "Любой";

	НоваяСтрока = Обработчик.ПриоритетыВыполнения.Добавить();
	НоваяСтрока.Процедура = "Документы.ПоступлениеБезналичныхДенежныхСредств.ОбработатьДанныеДляПереходаНаНовуюВерсию";
	НоваяСтрока.Порядок = "После";
	
	НоваяСтрока = Обработчик.ПриоритетыВыполнения.Добавить();
	НоваяСтрока.Процедура = "Документы.ПриходныйКассовыйОрдер.ОбработатьДанныеДляПереходаНаНовуюВерсию";
	НоваяСтрока.Порядок = "После";
	
	НоваяСтрока = Обработчик.ПриоритетыВыполнения.Добавить();
	НоваяСтрока.Процедура = "Документы.РасходныйКассовыйОрдер.ОбработатьДанныеДляПереходаНаНовуюВерсию";
	НоваяСтрока.Порядок = "После";
	
	НоваяСтрока = Обработчик.ПриоритетыВыполнения.Добавить();
	НоваяСтрока.Процедура = "Документы.СписаниеБезналичныхДенежныхСредств.ОбработатьДанныеДляПереходаНаНовуюВерсию";
	НоваяСтрока.Порядок = "После";
	
	//++ НЕ УТ
	НоваяСтрока = Обработчик.ПриоритетыВыполнения.Добавить();
	НоваяСтрока.Процедура = "Документы.ВыбытиеДенежныхДокументов.ОбработатьДанныеДляПереходаНаНовуюВерсию";
	НоваяСтрока.Порядок = "После";

	НоваяСтрока = Обработчик.ПриоритетыВыполнения.Добавить();
	НоваяСтрока.Процедура = "Документы.ПоступлениеДенежныхДокументов.ОбработатьДанныеДляПереходаНаНовуюВерсию";
	НоваяСтрока.Порядок = "После";
	//-- НЕ УТ
	
КонецПроцедуры

Процедура ЗарегистрироватьДанныеКОбработкеДляПереходаНаНовуюВерсию(Параметры) Экспорт
	
	ПолноеИмяРегистра = "РегистрНакопления.ДвиженияДенежныхСредств";
	
	// Проверяем, что в выборку не попадают записи базы узла РИБ, в которую мигрируют записи без регистратора.
	Запрос = Новый Запрос;
	Запрос.Текст = 
	"ВЫБРАТЬ
		|	Заявки.Ссылка КАК Ссылка,
		|	ВЫБОР
		|		КОГДА Заявки.ДатаПлатежа <> ДАТАВРЕМЯ(1, 1, 1)
		|			ТОГДА Заявки.ДатаПлатежа
		|		КОГДА Заявки.ЖелательнаяДатаПлатежа <> ДАТАВРЕМЯ(1, 1, 1)
		|			ТОГДА Заявки.ЖелательнаяДатаПлатежа
		|		ИНАЧЕ НАЧАЛОПЕРИОДА(Заявки.Дата, ДЕНЬ)
		|	КОНЕЦ КАК Период
		|ПОМЕСТИТЬ Регистраторы
		|ИЗ
		|	Документ.ЗаявкаНаРасходованиеДенежныхСредств КАК Заявки
		|ГДЕ
		|	Заявки.Проведен
		|
		|ИНДЕКСИРОВАТЬ ПО
		|	Период,
		|	Ссылка
		|;
		|
		|////////////////////////////////////////////////////////////////////////////////
		|ВЫБРАТЬ РАЗЛИЧНЫЕ
		|	ДанныеРегистра.Регистратор КАК Регистратор
		|ИЗ
		|	РегистрНакопления.ДвиженияДенежныхСредств КАК ДанныеРегистра
		|ГДЕ
		|	ДанныеРегистра.ХозяйственнаяОперация = ЗНАЧЕНИЕ(Перечисление.ХозяйственныеОперации.ПоступлениеОплатыПоПлатежнойКарте)
		|	И ДанныеРегистра.ДенежныеСредства = НЕОПРЕДЕЛЕНО
		|	И ДанныеРегистра.Регистратор ССЫЛКА Документ.ПоступлениеБезналичныхДенежныхСредств
		|
		|ОБЪЕДИНИТЬ
		|
		|ВЫБРАТЬ
		|	ДвиженияДенежныхСредств.Регистратор
		|ИЗ
		|	РегистрНакопления.ДвиженияДенежныхСредств КАК ДвиженияДенежныхСредств
		|		ЛЕВОЕ СОЕДИНЕНИЕ Регистраторы КАК Регистраторы
		|		ПО ДвиженияДенежныхСредств.Период = Регистраторы.Период
		|			И ДвиженияДенежныхСредств.Регистратор = Регистраторы.Ссылка
		|ГДЕ
		|	ДвиженияДенежныхСредств.Регистратор ССЫЛКА Документ.ЗаявкаНаРасходованиеДенежныхСредств
		|	И Регистраторы.Ссылка ЕСТЬ NULL
		|	И (ДвиженияДенежныхСредств.СуммаКВыплатеВРамкахЛимита <> 0
		|			ИЛИ ДвиженияДенежныхСредств.СуммаКВыплатеСверхЛимита <> 0)";
	
	Регистраторы = Запрос.Выполнить().Выгрузить().ВыгрузитьКолонку("Регистратор");
	ОбновлениеИнформационнойБазы.ОтметитьРегистраторыКОбработке(Параметры, Регистраторы, ПолноеИмяРегистра);
	
	Запрос = Новый Запрос;
	Запрос.Текст = "
	|ВЫБРАТЬ РАЗЛИЧНЫЕ
	|	ДанныеРегистра.Регистратор
	|ИЗ
	|	РегистрНакопления.ДвиженияДенежныхСредств КАК ДанныеРегистра
	|ГДЕ
	|	(ДанныеРегистра.СтатьяДвиженияДенежныхСредств = ЗНАЧЕНИЕ(Справочник.СтатьиДвиженияДенежныхСредств.ПустаяСсылка)
	|	ИЛИ ДанныеРегистра.СтатьяДвиженияДенежныхСредств = НЕОПРЕДЕЛЕНО)
	|	И ТИПЗНАЧЕНИЯ(ДанныеРегистра.Регистратор) В (
	|		ТИП(Документ.АвансовыйОтчет),
	//++ НЕ УТ
	|		ТИП(Документ.ПоступлениеДенежныхДокументов),
	|		ТИП(Документ.ВыбытиеДенежныхДокументов),
	//-- НЕ УТ
	|		ТИП(Документ.ПоступлениеБезналичныхДенежныхСредств),
	|		ТИП(Документ.СписаниеБезналичныхДенежныхСредств),
	|		ТИП(Документ.ПриходныйКассовыйОрдер),
	|		ТИП(Документ.РасходныйКассовыйОрдер)
	|	)
	|
	|ОБЪЕДИНИТЬ ВСЕ
	|
	|ВЫБРАТЬ РАЗЛИЧНЫЕ
	|	ДанныеРегистра.Регистратор
	|ИЗ
	|	РегистрНакопления.ДвиженияДенежныхСредств КАК ДанныеРегистра
	|ГДЕ
	|	ДанныеРегистра.ТипДенежныхСредств = ЗНАЧЕНИЕ(Перечисление.ТипыДенежныхСредств.ДенежныеСредстваВПути)
	|	И ТИПЗНАЧЕНИЯ(ДанныеРегистра.ДенежныеСредства) = ТИП(Справочник.КассыККМ)
	|	И ДанныеРегистра.Регистратор ССЫЛКА Документ.ПриходныйКассовыйОрдер
	|
	|ОБЪЕДИНИТЬ ВСЕ
	|
	|ВЫБРАТЬ РАЗЛИЧНЫЕ
	|	ДанныеРегистра.Регистратор
	|ИЗ
	|	РегистрНакопления.ДвиженияДенежныхСредств КАК ДанныеРегистра
	|ГДЕ
	|	ДанныеРегистра.КорТипДенежныхСредств = ЗНАЧЕНИЕ(Перечисление.ТипыДенежныхСредств.ДенежныеСредстваВПути)
	|	И ТИПЗНАЧЕНИЯ(ДанныеРегистра.КорДенежныеСредства) = ТИП(Справочник.КассыККМ)
	|	И ДанныеРегистра.Регистратор ССЫЛКА Документ.РасходныйКассовыйОрдер
	|
	|ОБЪЕДИНИТЬ ВСЕ
	|
	|ВЫБРАТЬ РАЗЛИЧНЫЕ
	|	ДанныеДокумента.Ссылка
	|ИЗ
	|	Документ.ВнесениеДенежныхСредствВКассуККМ КАК ДанныеДокумента
	|	
	|	ЛЕВОЕ СОЕДИНЕНИЕ
	|		РегистрНакопления.ДенежныеСредстваВПути КАК ДенежныеСредства
	|	ПО
	|		ДенежныеСредства.Регистратор = ДанныеДокумента.Ссылка
	|	
	|ГДЕ
	|	ДанныеДокумента.Проведен
	|	И ДенежныеСредства.Регистратор ЕСТЬ NULL
	|
	|ОБЪЕДИНИТЬ ВСЕ
	|
	|ВЫБРАТЬ РАЗЛИЧНЫЕ
	|	ДанныеДокумента.Ссылка
	|ИЗ
	|	Документ.ВыемкаДенежныхСредствИзКассыККМ КАК ДанныеДокумента
	|	
	|	ЛЕВОЕ СОЕДИНЕНИЕ
	|		РегистрНакопления.ДенежныеСредстваВПути КАК ДенежныеСредства
	|	ПО
	|		ДенежныеСредства.Регистратор = ДанныеДокумента.Ссылка
	|	
	|ГДЕ
	|	ДанныеДокумента.Проведен
	|	И ДенежныеСредства.Регистратор ЕСТЬ NULL
	|";
	
	Регистраторы = Запрос.Выполнить().Выгрузить().ВыгрузитьКолонку("Регистратор");
	ОбновлениеИнформационнойБазы.ОтметитьРегистраторыКОбработке(Параметры, Регистраторы, ПолноеИмяРегистра);
	
КонецПроцедуры

Процедура ОбработатьДанныеДляПереходаНаНовуюВерсию(Параметры) Экспорт
	
	ПолноеИмяРегистра = "РегистрНакопления.ДвиженияДенежныхСредств";
	ПолноеИмяЗаявки   = "Документ.ЗаявкаНаРасходованиеДенежныхСредств";
	
	ДополнительныеПараметры = ОбновлениеИнформационнойБазы.ДополнительныеПараметрыОтметкиОбработки();
	ДополнительныеПараметры.ЭтоДвижения = Истина;
	ДополнительныеПараметры.ПолноеИмяРегистра = ПолноеИмяРегистра;
	
	Выборка = ОбновлениеИнформационнойБазы.ВыбратьРегистраторыРегистраДляОбработки(Параметры.Очередь, ПолноеИмяЗаявки, ПолноеИмяРегистра);
	
	Запрос = Новый Запрос;
	Запрос.Текст =
	"ВЫБРАТЬ
		|	Движения.Период КАК ПериодПредыдущееЗначение,
		|	Движения.Регистратор КАК Регистратор,
		|	Движения.НомерСтроки КАК НомерСтроки,
		|	Движения.Активность КАК Активность,
		|	Движения.ХозяйственнаяОперация КАК ХозяйственнаяОперация,
		|	Движения.Организация КАК Организация,
		|	Движения.Подразделение КАК Подразделение,
		|	Движения.НаправлениеДеятельности КАК НаправлениеДеятельности,
		|	Движения.ДенежныеСредства КАК ДенежныеСредства,
		|	Движения.ТипДенежныхСредств КАК ТипДенежныхСредств,
		|	Движения.СтатьяДвиженияДенежныхСредств КАК СтатьяДвиженияДенежныхСредств,
		|	Движения.СтатьяКалькуляции КАК СтатьяКалькуляции,
		|	Движения.Валюта КАК Валюта,
		|	Движения.КорДенежныеСредства КАК КорДенежныеСредства,
		|	Движения.КорТипДенежныхСредств КАК КорТипДенежныхСредств,
		|	Движения.КорНаправлениеДеятельности КАК КорНаправлениеДеятельности,
		|	Движения.КорВалюта КАК КорВалюта,
		|	Движения.Сумма КАК Сумма,
		|	Движения.СуммаРегл КАК СуммаРегл,
		|	Движения.СуммаВВалюте КАК СуммаВВалюте,
		|	Движения.СуммаКВыплатеВРамкахЛимита КАК СуммаКВыплатеВРамкахЛимита,
		|	Движения.СуммаКВыплатеСверхЛимита КАК СуммаКВыплатеСверхЛимита,
		|	Движения.СуммаВКорВалюте КАК СуммаВКорВалюте,
		|	Движения.ИсточникГФУДенежныхСредств КАК ИсточникГФУДенежныхСредств,
		|	Движения.ИсточникКорГФУДенежныхСредств КАК ИсточникКорГФУДенежныхСредств,
		|	ВЫБОР
		|		КОГДА Движения.СуммаКВыплатеВРамкахЛимита = 0
		|				И Движения.СуммаКВыплатеСверхЛимита = 0
		|			ТОГДА Движения.Период
		|		ИНАЧЕ ВЫБОР
		|				КОГДА ВЫРАЗИТЬ(Движения.Регистратор КАК Документ.ЗаявкаНаРасходованиеДенежныхСредств).ДатаПлатежа <> ДАТАВРЕМЯ(1, 1, 1)
		|					ТОГДА ВЫРАЗИТЬ(Движения.Регистратор КАК Документ.ЗаявкаНаРасходованиеДенежныхСредств).ДатаПлатежа
		|				КОГДА ВЫРАЗИТЬ(Движения.Регистратор КАК Документ.ЗаявкаНаРасходованиеДенежныхСредств).ЖелательнаяДатаПлатежа <> ДАТАВРЕМЯ(1, 1, 1)
		|					ТОГДА ВЫРАЗИТЬ(Движения.Регистратор КАК Документ.ЗаявкаНаРасходованиеДенежныхСредств).ЖелательнаяДатаПлатежа
		|				ИНАЧЕ НАЧАЛОПЕРИОДА(ВЫРАЗИТЬ(Движения.Регистратор КАК Документ.ЗаявкаНаРасходованиеДенежныхСредств).Дата, ДЕНЬ)
		|			КОНЕЦ
		|	КОНЕЦ КАК Период
		|ИЗ
		|	РегистрНакопления.ДвиженияДенежныхСредств КАК Движения
		|ГДЕ
		|	Движения.Регистратор = &Регистратор";
	
	Пока Выборка.Следующий() Цикл
		
		Если ТипЗнч(Выборка.Регистратор) = Тип("ДокументСсылка.ЗаявкаНаРасходованиеДенежныхСредств") Тогда
			Регистратор = Выборка.Регистратор;
			
			Запрос.УстановитьПараметр("Регистратор", Регистратор);
			
			НачатьТранзакцию();
			
			Попытка
				
				Блокировка = Новый БлокировкаДанных;
				ЭлементБлокировки = Блокировка.Добавить(ПолноеИмяРегистра + ".НаборЗаписей");
				ЭлементБлокировки.УстановитьЗначение("Регистратор", Регистратор);
				ЭлементБлокировки.Режим = РежимБлокировкиДанных.Исключительный;
				
				ЭлементБлокировки = Блокировка.Добавить("Документ.ЗаявкаНаРасходованиеДенежныхСредств");
				ЭлементБлокировки.УстановитьЗначение("Ссылка", Регистратор);
				ЭлементБлокировки.Режим = РежимБлокировкиДанных.Разделяемый;
				
				Блокировка.Заблокировать();
				
				Набор = РегистрыНакопления.ДвиженияДенежныхСредств.СоздатьНаборЗаписей();
				Набор.Отбор.Регистратор.Установить(Регистратор);
				Набор.Загрузить(Запрос.Выполнить().Выгрузить());
				
				Если Набор.Количество() = 0 Тогда
					ОбновлениеИнформационнойБазы.ОтметитьВыполнениеОбработки(Регистратор, ДополнительныеПараметры);
				Иначе
					ОбновлениеИнформационнойБазы.ЗаписатьДанные(Набор);
				КонецЕсли;
				
				ЗафиксироватьТранзакцию();
				
			Исключение
				
				ОтменитьТранзакцию();
				
				ТекстСообщения = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(
					НСтр("ru='Не удалось обработать движения документа ""%1"" по причине:
                        |%2'
                        |;uk='Не вдалося обробити рух документа ""%1"" по причині:
                        |%2'"),
					Регистратор,
					ПодробноеПредставлениеОшибки(ИнформацияОбОшибке()));
				
				ЗаписьЖурналаРегистрации(
					ОбновлениеИнформационнойБазы.СобытиеЖурналаРегистрации(),
					УровеньЖурналаРегистрации.Ошибка,
					Регистратор.Метаданные(),
					ТекстСообщения);
				
			КонецПопытки;
		КонецЕсли;
		
	КонецЦикла;
	
	Регистраторы = Новый Массив;
	Регистраторы.Добавить("Документ.АвансовыйОтчет");
	//++ НЕ УТ
	Регистраторы.Добавить("Документ.ВыбытиеДенежныхДокументов");
	Регистраторы.Добавить("Документ.ПоступлениеДенежныхДокументов");
	//-- НЕ УТ
	Регистраторы.Добавить("Документ.ПоступлениеБезналичныхДенежныхСредств");
	Регистраторы.Добавить("Документ.ПриходныйКассовыйОрдер");
	Регистраторы.Добавить("Документ.РасходныйКассовыйОрдер");
	Регистраторы.Добавить("Документ.СписаниеБезналичныхДенежныхСредств");
	
	ОбновлениеИнформационнойБазыУТ.ПерезаписатьДвиженияИзОчереди(
		Регистраторы,
		ПолноеИмяРегистра,
		Параметры.Очередь
	);
	
	Выборка = ОбновлениеИнформационнойБазы.ВыбратьРегистраторыРегистраДляОбработки(
		Параметры.Очередь, 
		"Документ.ВнесениеДенежныхСредствВКассуККМ", 
		ПолноеИмяРегистра
	);
	ОчиститьДвижения(Выборка);
	
	Выборка = ОбновлениеИнформационнойБазы.ВыбратьРегистраторыРегистраДляОбработки(
		Параметры.Очередь, 
		"Документ.ВыемкаДенежныхСредствИзКассыККМ", 
		ПолноеИмяРегистра
	);
	ОчиститьДвижения(Выборка);
	
	Параметры.ОбработкаЗавершена = ОбновлениеИнформационнойБазы.ОбработкаДанныхЗавершена(Параметры.Очередь, ПолноеИмяРегистра);
	
КонецПроцедуры

Процедура ОчиститьДвижения(Выборка)
	
	ПолноеИмяРегистра = "РегистрНакопления.ДвиженияДенежныхСредств";
	
	Пока Выборка.Следующий() Цикл
		
		НачатьТранзакцию();
		
		Попытка
			
			Блокировка = Новый БлокировкаДанных;
			
			ЭлементБлокировки = Блокировка.Добавить(ПолноеИмяРегистра + ".НаборЗаписей");
			ЭлементБлокировки.УстановитьЗначение("Регистратор", Выборка.Регистратор);
			Блокировка.Заблокировать();
			
			Набор = РегистрыНакопления.ДвиженияДенежныхСредств.СоздатьНаборЗаписей();
			Набор.Отбор.Регистратор.Установить(Выборка.Регистратор);
			
			ОбновлениеИнформационнойБазы.ЗаписатьДанные(Набор);
			
			ЗафиксироватьТранзакцию();
		
		Исключение
		
			ОтменитьТранзакцию();
			
			ТекстСообщения = НСтр("ru='Не удалось очистить движения регистра ""Движения ДС - ДС"" при обработке документа: %Ссылка% по причине: %Причина%';uk='Не вдалося очистити рухи регістру ""Рухи ГК - ГК"" при обробці документа: %Ссылка% по причині: %Причина%'");
			ТекстСообщения = СтрЗаменить(ТекстСообщения, "%Ссылка%", Выборка.Регистратор);
			ТекстСообщения = СтрЗаменить(ТекстСообщения, "%Причина%", ПодробноеПредставлениеОшибки(ИнформацияОбОшибке()));
			
			ЗаписьЖурналаРегистрации(ОбновлениеИнформационнойБазы.СобытиеЖурналаРегистрации(), УровеньЖурналаРегистрации.Предупреждение,
				Выборка.Регистратор.Метаданные(), Выборка.Регистратор, ТекстСообщения);
			ВызватьИсключение;
			
		КонецПопытки;
	КонецЦикла;
	
КонецПроцедуры


#КонецОбласти

#КонецЕсли
