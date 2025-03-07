#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ПрограммныйИнтерфейс

// Вычисляет отгруженное количество, согласно данных регистра накопления "Товары к отгрузке".
//
// Параметры:
//  Отбор - ТаблицаЗначений - таблица товаров по которым необходимо получить отгруженное количество
//  Корректировка - ТаблицаЗначений	 - таблица товаров сторно
//  ТолькоОрдерныеСклады - Булево - указывает на расчет отгруженного количества только на ордерных складах.
//
// Возвращаемое значение:
//	ТаблицаЗначений - таблица отгруженных товаров.
//
Функция ТаблицаОформлено(Отбор, Корректировка, ТолькоОрдерныеСклады = Ложь) Экспорт

	МетаданныеРегистра = Метаданные.РегистрыНакопления.ТоварыКОтгрузке;
	ТаблицаОтбора = Новый ТаблицаЗначений;
	ТаблицаОтбора.Колонки.Добавить("Номенклатура",   Новый ОписаниеТипов("СправочникСсылка.Номенклатура"));
	ТаблицаОтбора.Колонки.Добавить("Характеристика", Новый ОписаниеТипов("СправочникСсылка.ХарактеристикиНоменклатуры"));
	ТаблицаОтбора.Колонки.Добавить("Склад",          Новый ОписаниеТипов("СправочникСсылка.Склады"));
	ТаблицаОтбора.Колонки.Добавить("Назначение",     Новый ОписаниеТипов("СправочникСсылка.Назначения"));
	ТаблицаОтбора.Колонки.Добавить("Серия",          Новый ОписаниеТипов("СправочникСсылка.СерииНоменклатуры"));
	ТаблицаОтбора.Колонки.Добавить("Ссылка",         МетаданныеРегистра.Измерения.ДокументОтгрузки.Тип);
	ОбщегоНазначенияКлиентСервер.ДополнитьТаблицу(Отбор, ТаблицаОтбора);

	Запрос = Новый Запрос();

	// Запрос оформленного количества по заказу.
	Запрос.Текст =
		"ВЫБРАТЬ РАЗЛИЧНЫЕ
		|	Таблица.Номенклатура   КАК Номенклатура,
		|	Таблица.Характеристика КАК Характеристика,
		|	Таблица.Назначение     КАК Назначение,
		|	Таблица.Серия          КАК Серия,
		|	Таблица.Склад          КАК Склад,
		|	Таблица.Ссылка         КАК ДокументОтгрузки
		|ПОМЕСТИТЬ ВТОтбор
		|ИЗ
		|	&Отбор КАК Таблица
		|;
		|
		|///////////////////////////////////////////
		|ВЫБРАТЬ
		|	Таблица.Номенклатура     КАК Номенклатура,
		|	Таблица.Характеристика   КАК Характеристика,
		|	Таблица.Назначение       КАК Назначение,
		|	Таблица.Серия            КАК Серия,
		|	Таблица.Склад            КАК Склад,
		|	Таблица.КОтгрузке        КАК Количество
		|ПОМЕСТИТЬ ВТКорректировка
		|ИЗ
		|	&Корректировка КАК Таблица
		|ГДЕ
		|	Таблица.КОтгрузке <> 0
		|;
		|
		|///////////////////////////////////////////
		|ВЫБРАТЬ
		|	Набор.Номенклатура      КАК Номенклатура,
		|	Набор.ТипНоменклатуры   КАК ТипНоменклатуры,
		|	Набор.Характеристика    КАК Характеристика,
		|	Набор.Назначение        КАК Назначение,
		|	Набор.Серия             КАК Серия,
		|	Набор.Склад             КАК Склад,
		|	СУММА(Набор.Количество) КАК Количество
		|ИЗ
		|(ВЫБРАТЬ
		|	Таблица.Номенклатура     КАК Номенклатура,
		|	Таблица.Номенклатура.ТипНоменклатуры КАК ТипНоменклатуры,
		|	Таблица.Характеристика   КАК Характеристика,
		|	Таблица.Назначение       КАК Назначение,
		|	Таблица.Серия            КАК Серия,
		|	Таблица.Склад            КАК Склад,
		|
		|	ВЫБОР КОГДА Таблица.ВидДвижения = ЗНАЧЕНИЕ(ВидДвиженияНакопления.Расход) ТОГДА
		|				Таблица.КОтгрузке
		|					- Таблица.Собирается - Таблица.Собрано
		|			ИНАЧЕ
		|				- Таблица.КОтгрузке
		|					+ Таблица.Собирается + Таблица.Собрано
		|		КОНЕЦ                КАК Количество
		|ИЗ
		|	РегистрНакопления.ТоварыКОтгрузке КАК Таблица
		|		ВНУТРЕННЕЕ СОЕДИНЕНИЕ ВтОтбор КАК Фильтр
		|		ПО Таблица.Номенклатура   = Фильтр.Номенклатура
		|		 И Таблица.Характеристика = Фильтр.Характеристика
		|		 И Таблица.Склад          = Фильтр.Склад
		|		 И Таблица.Назначение     = Фильтр.Назначение
		|		 И Таблица.Серия          = Фильтр.Серия
		|		 И Таблица.ДокументОтгрузки = Фильтр.ДокументОтгрузки
		|		 И Таблица.ДокументОтгрузки <> Таблица.Регистратор
		|ГДЕ
		|	Таблица.Активность
		|		И (Таблица.КОтгрузке <> 0 ИЛИ Таблица.Собирается <> 0 ИЛИ Таблица.Собрано <> 0)
		|		И &ВсеСклады
		|
		|ОБЪЕДИНИТЬ ВСЕ
		|
		|ВЫБРАТЬ
		|	Таблица.Номенклатура     КАК Номенклатура,
		|	ВЫРАЗИТЬ(Таблица.Номенклатура КАК Справочник.Номенклатура).ТипНоменклатуры КАК ТипНоменклатуры,
		|	Таблица.Характеристика   КАК Характеристика,
		|	Таблица.Назначение       КАК Назначение,
		|	Таблица.Серия            КАК Серия,
		|	Таблица.Склад            КАК Склад,
		|	-Таблица.Количество      КАК Количество
		|
		|ИЗ
		|	ВтКорректировка КАК Таблица
		|		ВНУТРЕННЕЕ СОЕДИНЕНИЕ ВтОтбор КАК Фильтр
		|		ПО Таблица.Номенклатура   = Фильтр.Номенклатура
		|		 И Таблица.Характеристика = Фильтр.Характеристика
		|		 И Таблица.Склад          = Фильтр.Склад
		|		 И Таблица.Назначение     = Фильтр.Назначение
		|		 И Таблица.Серия          = Фильтр.Серия) КАК Набор
		|
		|СГРУППИРОВАТЬ ПО
		|	Набор.Номенклатура, Набор.ТипНоменклатуры, Набор.Характеристика, Набор.Назначение, Набор.Склад, Набор.Серия
		|ИМЕЮЩИЕ
		|	СУММА(Набор.Количество) > 0
		|";
	
	Если ТолькоОрдерныеСклады Тогда
		Запрос.Текст = СтрЗаменить(Запрос.Текст, "&ВсеСклады",
			"Таблица.Склад.ИспользоватьОрдернуюСхемуПриОтгрузке
			|И Таблица.Склад.ДатаНачалаОрдернойСхемыПриОтгрузке <= &ТекущаяДата");
		Запрос.УстановитьПараметр("ТекущаяДата", ТекущаяДатаСеанса());
	Иначе
		Запрос.УстановитьПараметр("ВсеСклады", Истина);
	КонецЕсли;
	
	Запрос.УстановитьПараметр("Корректировка", Корректировка);
	Запрос.УстановитьПараметр("Отбор",         ТаблицаОтбора);
	
	УстановитьПривилегированныйРежим(Истина);
	Таблица = Запрос.Выполнить().Выгрузить();
	УстановитьПривилегированныйРежим(Ложь);
	Таблица.Индексы.Добавить("Номенклатура, Характеристика, Склад, Назначение");
	
	Возврат Таблица;
	
КонецФункции

#Область ДляВызоваИзДругихПодсистем

// СтандартныеПодсистемы.УправлениеДоступом

// См. УправлениеДоступомПереопределяемый.ПриЗаполненииСписковСОграничениемДоступа.
Процедура ПриЗаполненииОграниченияДоступа(Ограничение) Экспорт

	Ограничение.Текст =
	"РазрешитьЧтениеИзменение
	|ГДЕ
	|	ЗначениеРазрешено(Склад)";

КонецПроцедуры

// Конец СтандартныеПодсистемы.УправлениеДоступом

#КонецОбласти

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

// Текст запроса получает таблицу отгруженных ордерами, но не оформленных накладными товаров
// Таблица дополняется движениями, сделанными накладной заданной в параметре Регистратор.
//
// Параметры:
//  ОтборПоИзмерениям	 - Соответствие - Ключ     - Строка    - левое значение: единичное поле или поля через запятые
//										- Значение - Структура - 1. Ключ: "ВидСравнения";   Значение - Строка - оператор сравнения в запросе
//																 2. Ключ: "ПравоеЗначение"; Значение - Строка - единичное поле с амперсандом или запрос к таблице
// 
// Возвращаемое значение:
//   - Строка
//
Функция ТекстЗапросаОсталосьОформить(ОтборПоИзмерениям = Неопределено) Экспорт
	
	ТекстЗапроса = 
	"ВЫБРАТЬ
	|	Таблица.ДокументОтгрузки  КАК Распоряжение,
	|	Таблица.Номенклатура      КАК Номенклатура,
	|	Таблица.Характеристика    КАК Характеристика,
	|	Таблица.Назначение        КАК Назначение,
	|	Таблица.Склад             КАК Склад,
	|	Таблица.Серия             КАК Серия,
	|	Таблица.КОтгрузкеРасход   КАК КОтгрузке,
	|	Таблица.КОформлениюРасход КАК КОформлению,
	|	Таблица.СобраноПриход     КАК Собрано,
	|	Таблица.СобираетсяПриход  КАК Собирается
	|ПОМЕСТИТЬ ВтДанныеРегистра
	|ИЗ
	|	РегистрНакопления.ТоварыКОтгрузке.Обороты(, , , ДокументОтгрузки В (&Распоряжения)
	|//&Отбор
	|	)КАК Таблица
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ
	|	Набор.Распоряжение         КАК Распоряжение,
	|	Набор.Номенклатура         КАК Номенклатура,
	|	Набор.Характеристика       КАК Характеристика,
	|	Набор.Назначение           КАК Назначение,
	|	Набор.Склад                КАК Склад,
	|	Набор.Серия                КАК Серия,
	|	СУММА(Набор.Количество)    КАК Количество,
	|	МАКСИМУМ(Набор.Собирается) КАК Собирается
	|ИЗ
	|	(
	|	ВЫБРАТЬ
	|		Таблица.Распоряжение         КАК Распоряжение,
	|		Таблица.Номенклатура         КАК Номенклатура,
	|		Таблица.Характеристика       КАК Характеристика,
	|		Таблица.Назначение           КАК Назначение,
	|		Таблица.Склад                КАК Склад,
	|		Таблица.Серия                КАК Серия,
	|		Таблица.КОтгрузке 
	|			+ Таблица.Собрано        КАК Количество,
	|		Таблица.Собирается           КАК Собирается
	|	ИЗ
	|		ВтДанныеРегистра КАК Таблица
	|	ГДЕ
	|		Таблица.КОтгрузке 
	|			+ Таблица.Собрано > 0
	|		
	|	ОБЪЕДИНИТЬ ВСЕ
	|		
	|	ВЫБРАТЬ
	|		Таблица.Распоряжение         КАК Распоряжение,
	|		Таблица.Номенклатура         КАК Номенклатура,
	|		Таблица.Характеристика       КАК Характеристика,
	|		Таблица.Назначение           КАК Назначение,
	|		Таблица.Склад                КАК Склад,
	|		Таблица.Серия                КАК Серия,
	|		-Таблица.КОформлению         КАК Количество,
	|		Таблица.Собирается           КАК Собирается
	|	ИЗ
	|		ВтДанныеРегистра КАК Таблица
	|	ГДЕ
	|		Таблица.КОформлению > 0
	|		
	|	ОБЪЕДИНИТЬ ВСЕ
	|		
	|	ВЫБРАТЬ
	|		Таблица.ДокументОтгрузки     КАК Распоряжение,
	|		Таблица.Номенклатура         КАК Номенклатура,
	|		Таблица.Характеристика       КАК Характеристика,
	|		Таблица.Назначение           КАК Назначение,
	|		Таблица.Склад                КАК Склад,
	|		Таблица.Серия                КАК Серия,
	|		СУММА(Таблица.КОформлению)   КАК Количество,
	|		МАКСИМУМ(Таблица.Собирается) КАК Собирается
	|	ИЗ
	|		РегистрНакопления.ТоварыКОтгрузке КАК Таблица
	|	ГДЕ
	|		Таблица.Регистратор = &Регистратор
	|		И Таблица.ДокументОтгрузки В(&Распоряжения)
	|		И Таблица.ВидДвижения = ЗНАЧЕНИЕ(ВидДвиженияНакопления.Расход)
	|		И Таблица.КОформлению > 0
	|		И Таблица.Активность
	|		//&Отбор
	|
	|	СГРУППИРОВАТЬ ПО
	|		Таблица.ДокументОтгрузки,
	|		Таблица.Номенклатура,
	|		Таблица.Характеристика,
	|		Таблица.Назначение,
	|		Таблица.Серия,
	|		Таблица.Склад
	|	) КАК Набор
	|
	|СГРУППИРОВАТЬ ПО
	|	Распоряжение,
	|	Номенклатура,
	|	Характеристика,
	|	Назначение,
	|	Склад,
	|	Серия";
	
	Если ЗначениеЗаполнено(ОтборПоИзмерениям) Тогда
		
		ТекстОтбора = "";
		Для Каждого КлючЗначение Из ОтборПоИзмерениям Цикл
			
			ЛевоеЗначение  		= КлючЗначение.Ключ;
			ВидСравненияЗапроса = КлючЗначение.Значение.ВидСравнения;
			ПравоеЗначение 		= КлючЗначение.Значение.ПравоеЗначение;
			
			ТекстОтбора = ТекстОтбора + " И "
						+ "(" + ЛевоеЗначение + ") " + ВидСравненияЗапроса + " (" + ПравоеЗначение + ")";
			
		КонецЦикла;
		
		ТекстЗапроса = СтрЗаменить(ТекстЗапроса, "//&Отбор", ТекстОтбора);
		
	КонецЕсли;
	
	Возврат ТекстЗапроса;
	
КонецФункции

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
	Обработчик.Процедура = "РегистрыНакопления.ТоварыКОтгрузке.ОбработатьДанныеДляПереходаНаНовуюВерсию";
	Обработчик.Версия = "3.5.4.400";
	Обработчик.РежимВыполнения = "Отложенно";
	Обработчик.Идентификатор = Новый УникальныйИдентификатор("90b00a56-b427-4730-b71c-9547ea847835");
	Обработчик.Многопоточный = Истина;
	Обработчик.ПроцедураЗаполненияДанныхОбновления = "РегистрыНакопления.ТоварыКОтгрузке.ЗарегистрироватьДанныеКОбработкеДляПереходаНаНовуюВерсию";
	Обработчик.ПроцедураПроверки = "ОбновлениеИнформационнойБазы.ДанныеОбновленыНаНовуюВерсиюПрограммы";
	Обработчик.Комментарий = НСтр("ru='Обновляет движения документов информационной базы по регистру накопления ""Товары к отгрузке"".
|До завершения обработчика работа с документами не рекомендуется, т.к. информация в регистре некорректна.'
|;uk='Оновлює рухи документів інформаційної бази за регістром накопичення ""Товари до відвантаження"". 
|До завершення обробника робота з документами не рекомендується, тому що інформація в регістрі некоректна.'");
	
	Читаемые = Новый Массив;
	Читаемые.Добавить(Метаданные.Документы.АктОРасхожденияхПослеОтгрузки.ПолноеИмя());
	Читаемые.Добавить(Метаданные.Документы.АктОРасхожденияхПослеПеремещения.ПолноеИмя());
	Читаемые.Добавить(Метаданные.Документы.АктОРасхожденияхПослеПриемки.ПолноеИмя());
	Читаемые.Добавить(Метаданные.Документы.ВнутреннееПотреблениеТоваров.ПолноеИмя());
	Читаемые.Добавить(Метаданные.Документы.ВозвратТоваровПоставщику.ПолноеИмя());
	Читаемые.Добавить(Метаданные.Документы.ЗаказКлиента.ПолноеИмя());
	Читаемые.Добавить(Метаданные.Документы.ЗаказНаВнутреннееПотребление.ПолноеИмя());
	Читаемые.Добавить(Метаданные.Документы.ЗаказНаПеремещение.ПолноеИмя());
	Читаемые.Добавить(Метаданные.Документы.ЗаказНаСборку.ПолноеИмя());
	Читаемые.Добавить(Метаданные.Документы.ЗаявкаНаВозвратТоваровОтКлиента.ПолноеИмя());
	Читаемые.Добавить(Метаданные.Документы.ПеремещениеТоваров.ПолноеИмя());
	Читаемые.Добавить(Метаданные.Документы.РасходныйОрдерНаТовары.ПолноеИмя());
	Читаемые.Добавить(Метаданные.Документы.РеализацияТоваровУслуг.ПолноеИмя());
	Читаемые.Добавить(Метаданные.Документы.СборкаТоваров.ПолноеИмя());
	Читаемые.Добавить(Метаданные.РегистрыНакопления.ТоварыКОтгрузке.ПолноеИмя());
	//++ НЕ УТ
	//++ Локализация
	Читаемые.Добавить(Метаданные.Документы.ПередачаМатериаловВПроизводство.ПолноеИмя());
	//-- Локализация
	//-- НЕ УТ
	//++ НЕ УТ
	Читаемые.Добавить(Метаданные.Документы.ЗаказМатериаловВПроизводство.ПолноеИмя());
	Читаемые.Добавить(Метаданные.Документы.ЗаказПереработчику.ПолноеИмя());
	Читаемые.Добавить(Метаданные.Документы.ПередачаСырьяПереработчику.ПолноеИмя());
	Читаемые.Добавить(Метаданные.Документы.РаспределениеПроизводственныхЗатрат.ПолноеИмя());
	//-- НЕ УТ
	Обработчик.ЧитаемыеОбъекты = СтрСоединить(Читаемые, ",");
	
	Изменяемые = Новый Массив;
	Изменяемые.Добавить(Метаданные.РегистрыНакопления.ТоварыКОтгрузке.ПолноеИмя());
	Обработчик.ИзменяемыеОбъекты = СтрСоединить(Изменяемые, ",");
	
	Обработчик.ПриоритетыВыполнения = ОбновлениеИнформационнойБазы.ПриоритетыВыполненияОбработчика();

	НоваяСтрока = Обработчик.ПриоритетыВыполнения.Добавить();
	НоваяСтрока.Процедура = "Документы.АктОРасхожденияхПослеОтгрузки.ОбработатьДанныеДляПереходаНаНовуюВерсию";
	НоваяСтрока.Порядок = "После";

	НоваяСтрока = Обработчик.ПриоритетыВыполнения.Добавить();
	НоваяСтрока.Процедура = "Документы.АктОРасхожденияхПослеПеремещения.ОбработатьДанныеДляПереходаНаНовуюВерсию";
	НоваяСтрока.Порядок = "После";

	НоваяСтрока = Обработчик.ПриоритетыВыполнения.Добавить();
	НоваяСтрока.Процедура = "Документы.АктОРасхожденияхПослеПриемки.ОбработатьДанныеДляПереходаНаНовуюВерсию";
	НоваяСтрока.Порядок = "После";

	НоваяСтрока = Обработчик.ПриоритетыВыполнения.Добавить();
	НоваяСтрока.Процедура = "Документы.ВозвратТоваровПоставщику.ОбработатьДанныеДляПереходаНаНовуюВерсию";
	НоваяСтрока.Порядок = "После";

	НоваяСтрока = Обработчик.ПриоритетыВыполнения.Добавить();
	НоваяСтрока.Процедура = "Документы.ЗаказКлиента.ОбработатьДанныеДляПереходаНаНовуюВерсию";
	НоваяСтрока.Порядок = "После";

	НоваяСтрока = Обработчик.ПриоритетыВыполнения.Добавить();
	НоваяСтрока.Процедура = "Документы.ЗаявкаНаВозвратТоваровОтКлиента.ОбработатьДанныеДляПереходаНаНовуюВерсию";
	НоваяСтрока.Порядок = "После";



	НоваяСтрока = Обработчик.ПриоритетыВыполнения.Добавить();
	НоваяСтрока.Процедура = "Документы.РасходныйОрдерНаТовары.ОбработатьДанныеДляПереходаНаНовуюВерсию";
	НоваяСтрока.Порядок = "После";

	НоваяСтрока = Обработчик.ПриоритетыВыполнения.Добавить();
	НоваяСтрока.Процедура = "Документы.РеализацияТоваровУслуг.ОбработатьДанныеДляПереходаНаНовуюВерсию";
	НоваяСтрока.Порядок = "После";

	НоваяСтрока = Обработчик.ПриоритетыВыполнения.Добавить();
	НоваяСтрока.Процедура = "РегистрыНакопления.ТоварыОрганизаций.ОбработатьДанныеДляПереходаНаНовуюВерсию";
	НоваяСтрока.Порядок = "Любой";
	
	//++ НЕ УТ
	НоваяСтрока = Обработчик.ПриоритетыВыполнения.Добавить();
	НоваяСтрока.Процедура = "Документы.ЗаказПереработчику.ОбработатьДанныеДляПереходаНаНовуюВерсию";
	НоваяСтрока.Порядок = "После";

	НоваяСтрока = Обработчик.ПриоритетыВыполнения.Добавить();
	НоваяСтрока.Процедура = "Документы.ПередачаСырьяПереработчику.ОбработатьДанныеДляПереходаНаНовуюВерсию";
	НоваяСтрока.Порядок = "После";
	
	//-- НЕ УТ
	

КонецПроцедуры

// Параметры:
// 	Параметры - см. ОбновлениеИнформационнойБазы.ОсновныеПараметрыОтметкиКОбработке
//
Процедура ЗарегистрироватьДанныеКОбработкеДляПереходаНаНовуюВерсию(Параметры) Экспорт
	
	ПолноеИмяРегистра	= "РегистрНакопления.ТоварыКОтгрузке";
	ИмяРегистра			= "ТоварыКОтгрузке";
	
	
	//++ НЕ УТ
	Запрос = Новый Запрос;
	Запрос.Текст = 
	"ВЫБРАТЬ РАЗЛИЧНЫЕ
	|	РасходныйОрдерНаТоварыТоварыПоРаспоряжениям.Ссылка
	|ИЗ
	|	Документ.РасходныйОрдерНаТовары.ТоварыПоРаспоряжениям КАК РасходныйОрдерНаТоварыТоварыПоРаспоряжениям
	|		ВНУТРЕННЕЕ СОЕДИНЕНИЕ Документ.ПередачаСырьяПереработчику КАК ПередачаСырьяПереработчику
	|		ПО РасходныйОрдерНаТоварыТоварыПоРаспоряжениям.Распоряжение = ПередачаСырьяПереработчику.Ссылка
	|		ВНУТРЕННЕЕ СОЕДИНЕНИЕ РегистрНакопления.ТоварыКОтгрузке КАК ТоварыКОтгрузке
	|		ПО ТоварыКОтгрузке.Регистратор = РасходныйОрдерНаТоварыТоварыПоРаспоряжениям.Ссылка
	|ГДЕ
	|	РасходныйОрдерНаТоварыТоварыПоРаспоряжениям.Распоряжение ССЫЛКА Документ.ПередачаСырьяПереработчику
	|	И ПередачаСырьяПереработчику.ПередачаПоЗаказам";
	
	Регистраторы = Запрос.Выполнить().Выгрузить().ВыгрузитьКолонку("Ссылка");
	ОбновлениеИнформационнойБазы.ОтметитьРегистраторыКОбработке(
		Параметры, 
		Регистраторы, 
		ПолноеИмяРегистра
	);
	//-- НЕ УТ
	
	
	
	СписокДокументов = ДокументыКОбновлению();
	
	ДопПараметры = ПроведениеДокументов.ДопПараметрыИнициализироватьДанныеДокументаДляПроведения();
	ДопПараметры.ПолучитьТекстыЗапроса = Истина;
	
	ПараметрыВыборки = Параметры.ПараметрыВыборки;
	ПараметрыВыборки.ПолныеИменаОбъектов = СтрСоединить(СписокДокументов, ",");
	ПараметрыВыборки.ПолныеИменаРегистров = ПолноеИмяРегистра;
	ПараметрыВыборки.ПоляУпорядочиванияПриРаботеПользователей.Добавить("Регистратор.Дата УБЫВ");
	ПараметрыВыборки.ПоляУпорядочиванияПриОбработкеДанных.Добавить("Регистратор");
	ПараметрыВыборки.СпособВыборки = ОбновлениеИнформационнойБазы.СпособВыборкиРегистраторыРегистра();
	
	Для Каждого ПолноеИмяДокумента Из СписокДокументов Цикл
		
		ИмяДокумента	= СтрРазделить(ПолноеИмяДокумента, ".")[1];
		ТекстыЗапроса	= Документы[ИмяДокумента].ДанныеДокументаДляПроведения(Неопределено, ИмяРегистра, ДопПараметры);
		Регистраторы	= ПроведениеДокументов.РегистраторыДляПерепроведения(
			ТекстыЗапроса,
			ПолноеИмяРегистра,
			ПолноеИмяДокумента
		);
		
		ОбновлениеИнформационнойБазы.ОтметитьРегистраторыКОбработке(
			Параметры, 
			Регистраторы, 
			ПолноеИмяРегистра
		); 
		
	КонецЦикла;
	
КонецПроцедуры

Процедура ОбработатьДанныеДляПереходаНаНовуюВерсию(Параметры) Экспорт
	
	ПолноеИмяРегистра = "РегистрНакопления.ТоварыКОтгрузке";
	
	ДополнительныеПараметры = ОбновлениеИнформационнойБазыУТ.ДополнительныеПараметрыПерезаписиДвиженийИзОчереди();
	ДополнительныеПараметры.ОбновляемыеДанные = Параметры.ОбновляемыеДанные;
	
	СписокДокументов = ДокументыКОбновлению();
	
	ОбработкаЗавершена = ОбновлениеИнформационнойБазыУТ.ПерезаписатьДвиженияИзОчереди(
		СписокДокументов,
		ПолноеИмяРегистра,
		Параметры.Очередь,
		ДополнительныеПараметры
	);
	
	Параметры.ОбработкаЗавершена = ОбработкаЗавершена;
	
КонецПроцедуры

Функция ДокументыКОбновлению()
	СписокДокументов = Новый Массив;
	СписокДокументов.Добавить("Документ.АктОРасхожденияхПослеОтгрузки");
	СписокДокументов.Добавить("Документ.АктОРасхожденияхПослеПеремещения");
	СписокДокументов.Добавить("Документ.АктОРасхожденияхПослеПриемки");
	СписокДокументов.Добавить("Документ.ВнутреннееПотреблениеТоваров");
	СписокДокументов.Добавить("Документ.ВозвратТоваровПоставщику");
	СписокДокументов.Добавить("Документ.ЗаказКлиента");
	СписокДокументов.Добавить("Документ.ЗаказНаВнутреннееПотребление");
	СписокДокументов.Добавить("Документ.ЗаказНаПеремещение");
	СписокДокументов.Добавить("Документ.ЗаказНаСборку");
	СписокДокументов.Добавить("Документ.ЗаявкаНаВозвратТоваровОтКлиента");
	СписокДокументов.Добавить("Документ.ПеремещениеТоваров");
	СписокДокументов.Добавить("Документ.РасходныйОрдерНаТовары");
	СписокДокументов.Добавить("Документ.РеализацияТоваровУслуг");
	СписокДокументов.Добавить("Документ.СборкаТоваров");
	
	//++ НЕ УТ
	//++ Устарело_Производство21
	СписокДокументов.Добавить("Документ.ПередачаМатериаловВПроизводство");
	//-- Устарело_Производство21
	СписокДокументов.Добавить("Документ.ЗаказМатериаловВПроизводство");
	СписокДокументов.Добавить("Документ.ЗаказПереработчику");
	СписокДокументов.Добавить("Документ.ПередачаСырьяПереработчику");
	СписокДокументов.Добавить("Документ.РаспределениеПроизводственныхЗатрат");
	//-- НЕ УТ
	
	Возврат СписокДокументов
КонецФункции

#КонецОбласти

#КонецОбласти

#КонецЕсли
