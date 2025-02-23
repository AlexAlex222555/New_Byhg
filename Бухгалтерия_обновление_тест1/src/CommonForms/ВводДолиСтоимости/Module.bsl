
#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	Если Параметры.Свойство("АвтоТест") Тогда
		Возврат;
	КонецЕсли;
	
	// Проверка обязательных параметров
	Если Не Параметры.Свойство("ДанныеПоНоменклатуре")
		ИЛИ Не Параметры.Свойство("СпособРаспределенияЗатратНаВыходныеИзделия") Тогда
		ВызватьИсключение НСтр("ru='Для открытия формы необходимо передать параметры.';uk='Для відкриття форми необхідно передати параметри.'");
	КонецЕсли;
	
	Если Не ЗначениеЗаполнено(Параметры.СпособРаспределенияЗатратНаВыходныеИзделия) Тогда
		ВызватьИсключение НСтр("ru='Способ распределения затрат на выходные изделия не передан.';uk='Спосіб розподілу витрат на вихідні вироби не переданий.'");
	КонецЕсли;
	
	// Заполнение параметров формы
	ВидЦены    = Справочники.ВидыЦен.ВидЦеныПлановойСтоимостиТМЦ();
	ВалютаЦены = Справочники.ВидыЦен.ПолучитьРеквизитыВидаЦены(ВидЦены).ВалютаЦены;
	
	ГруппировкаЗатрат = Параметры.ГруппировкаЗатрат;
	СпособРаспределенияЗатратНаВыходныеИзделия = Параметры.СпособРаспределенияЗатратНаВыходныеИзделия;
	
	ЗаполнитьЗначенияСвойств(
		ЭтаФорма,
		Параметры.ДанныеПоНоменклатуре,
		"Номенклатура,
		|Характеристика,
		|
		|Упаковка,
		|КоличествоУпаковок,
		|Количество,
		|
		|ДоляСтоимости,
		|ДоляСтоимостиНаЕдиницу");
	
	ДоляСтоимостиПроцент = Параметры.ДоляСтоимостиПроцент;
	ДоляСтоимостиИтого   = Параметры.ДоляСтоимостиИтого;

	ДоляСтоимостиИтогоНовая       = ДоляСтоимостиИтого;
	ДоляСтоимостиИтогоБезТекущего = ДоляСтоимостиИтого - ДоляСтоимости;
	
	ИспользуетсяПараметризация = Параметры.ИспользуетсяПараметризация;
	
	НастроитьЭлементыФормы();
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовШапкиФормы

&НаКлиенте
Процедура ДоляСтоимостиНаЕдиницуПриИзменении(Элемент)
	
	СтруктураСтроки = Новый Структура("ДоляСтоимости,ДоляСтоимостиНаЕдиницу,Количество", ДоляСтоимости, ДоляСтоимостиНаЕдиницу, Количество);
	
	ПроизводствоКлиентСервер.РассчитатьДолюСтоимостиВСтроке(СтруктураСтроки, СпособРаспределенияЗатратНаВыходныеИзделия);
	ЗаполнитьЗначенияСвойств(ЭтаФорма, СтруктураСтроки);
	
	ПриИзмененииДолиСтоимости();
	
КонецПроцедуры

&НаКлиенте
Процедура ДоляСтоимостиПриИзменении(Элемент)
	
	СтруктураСтроки = Новый Структура("ДоляСтоимости,ДоляСтоимостиНаЕдиницу,Количество", ДоляСтоимости, ДоляСтоимостиНаЕдиницу, Количество);
	
	ПроизводствоКлиентСервер.РассчитатьДолюСтоимостиНаЕдиницуВСтроке(СтруктураСтроки, СпособРаспределенияЗатратНаВыходныеИзделия);
	ЗаполнитьЗначенияСвойств(ЭтаФорма, СтруктураСтроки);
	
	ПриИзмененииДолиСтоимости();
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура ОК(Команда)
	
	ЗначениеВыбора = Новый Структура("ДоляСтоимости,ДоляСтоимостиНаЕдиницу", ДоляСтоимости, ДоляСтоимостиНаЕдиницу);
	ОповеститьОВыборе(ЗначениеВыбора);
	
КонецПроцедуры

&НаКлиенте
Процедура Отмена(Команда)
	
	Модифицированность = Ложь;
	
	Закрыть();
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаСервере
Процедура НастроитьЭлементыФормы()
	
	ИмяСпособа = ОбщегоНазначения.ИмяЗначенияПеречисления(СпособРаспределенияЗатратНаВыходныеИзделия);
	
	// Заголовок
	НоменклатураПредставление = НоменклатураКлиентСервер.ПредставлениеНоменклатуры(Номенклатура, Характеристика);
	ЭтаФорма.Заголовок = СтрШаблон(НСтр("ru='Доля стоимости номенклатуры ""%1""';uk='Частка вартості номенклатури ""%1""'"), НоменклатураПредставление);
	ЭтаФорма.АвтоЗаголовок = Ложь;
	
	// Только просмотр
	Если ТолькоПросмотр Тогда
		МассивЭлементов = Новый Массив;
		МассивЭлементов.Добавить(Элементы.ДоляСтоимости.Имя);
		МассивЭлементов.Добавить(Элементы.ПлановаяЦена.Имя);
		МассивЭлементов.Добавить(Элементы.ПлановаяСтоимости.Имя);
		МассивЭлементов.Добавить(Элементы.Вес.Имя);
		МассивЭлементов.Добавить(Элементы.ВесСтроки.Имя);
		МассивЭлементов.Добавить(Элементы.Объем.Имя);
		МассивЭлементов.Добавить(Элементы.ОбъемСтроки.Имя);
		ОбщегоНазначенияУТКлиентСервер.УстановитьСвойствоЭлементовФормы(Элементы, МассивЭлементов, "АвтоОтметкаНезаполненного", Ложь);
	КонецЕсли;
	Элементы.ФормаГруппаКнопокРедактирование.Видимость = Не ТолькоПросмотр;
	Элементы.ФормаЗакрыть.Видимость = ТолькоПросмотр;
	
	// Используется параметризация
	Если ИспользуетсяПараметризация Тогда
		МассивЭлементов = Новый Массив;
		МассивЭлементов.Добавить(Элементы.ГруппаПлановаяСтоимость.Имя);
		МассивЭлементов.Добавить(Элементы.ДоляСтоимостиИтогоПоПлановойСтоимости.Имя);
		МассивЭлементов.Добавить(Элементы.ДоляСтоимостиПроцентПоПлановойСтоимости.Имя);
		МассивЭлементов.Добавить(Элементы.ГруппаВесСтроки.Имя);
		МассивЭлементов.Добавить(Элементы.ДоляСтоимостиИтогоПоВесу.Имя);
		МассивЭлементов.Добавить(Элементы.ДоляСтоимостиПроцентПоВесу.Имя);
		МассивЭлементов.Добавить(Элементы.ГруппаОбъемСтроки.Имя);
		МассивЭлементов.Добавить(Элементы.ДоляСтоимостиИтогоПоОбъему.Имя);
		МассивЭлементов.Добавить(Элементы.ДоляСтоимостиПроцентПоОбъему.Имя);
		ОбщегоНазначенияУТКлиентСервер.УстановитьСвойствоЭлементовФормы(Элементы, МассивЭлементов, "Видимость", Ложь);
	КонецЕсли;
	
	// Установка текущей страницы, видимость группировки затрат
	Элементы.СпособыРаспределенияЗатратНаВыходныеИзделия.ТекущаяСтраница = Элементы["Страница" + ИмяСпособа];
	Элементы["Группировка" + ИмяСпособа].Видимость = ЗначениеЗаполнено(ГруппировкаЗатрат);
	
	НастроитьЗависимыеЭлементыФормы();
	
КонецПроцедуры

&НаСервере
Процедура НастроитьЗависимыеЭлементыФормы()
	
	Запрос = Новый Запрос(
	"ВЫБРАТЬ
	|	ВЫРАЗИТЬ(&Номенклатура   КАК Справочник.Номенклатура)               КАК Номенклатура,
	|	ВЫРАЗИТЬ(&Характеристика КАК Справочник.ХарактеристикиНоменклатуры) КАК Характеристика,
	|	ВЫРАЗИТЬ(&Упаковка       КАК Справочник.УпаковкиЕдиницыИзмерения)   КАК Упаковка
	|ПОМЕСТИТЬ ВтТаблица
	|;
	|ВЫБРАТЬ
	|
	|	Таблица.Номенклатура                КАК Номенклатура,
	|	ПРЕДСТАВЛЕНИЕ(Таблица.Номенклатура) КАК НоменклатураПредставление,
	|	
	|	Таблица.Характеристика                КАК Характеристика,
	|	ПРЕДСТАВЛЕНИЕ(Таблица.Характеристика) КАК ХарактеристикаПредставление,
	|
	|	Таблица.Номенклатура.ЕдиницаИзмерения                КАК ЕдиницаИзмерения,
	|	ПРЕДСТАВЛЕНИЕ(Таблица.Номенклатура.ЕдиницаИзмерения) КАК ЕдиницаИзмеренияПредставление,
	|
	|	Таблица.Упаковка     КАК Упаковка,
	|	&КоэффициентУпаковка КАК КоэффициентУпаковка,
	|
	|	ВЫБОР
	|		КОГДА ЕСТЬNULL(Таблица.Упаковка.ЕдиницаИзмерения, &УпаковкаПустаяСсылка) <> &УпаковкаПустаяСсылка
	|			ТОГДА ПРЕДСТАВЛЕНИЕ(Таблица.Упаковка.ЕдиницаИзмерения)
	|		ИНАЧЕ ПРЕДСТАВЛЕНИЕ(Таблица.Упаковка)
	|	КОНЕЦ КАК УпаковкаПредставление,
	|
	|	%ДоляСтоимостиНаЕдиницу% КАК ВесОбъемЦена
	|
	|ИЗ
	|	ВтТаблица КАК Таблица
	|	%СоединениеДоляСтоимости%
	|");
	Запрос.Текст = СтрЗаменить(Запрос.Текст, "&КоэффициентУпаковка", Справочники.УпаковкиЕдиницыИзмерения.ТекстЗапросаКоэффициентаУпаковки("Таблица.Упаковка","Таблица.Номенклатура"));
	
	ПараметрыПодстановки = ПроизводствоСервер.ПараметрыПодстановкиАлгоритмаРасчетаДолейСтоимости(
		"Таблица",
		"&СпособРаспределенияЗатратНаВыходныеИзделия",
		"(Номенклатура, Характеристика) В (
		|	Выбрать
		|		Т.Номенклатура,
		|		Т.Характеристика
		|	ИЗ
		|		ВтТаблица КАК Т)");
	ПроизводствоСервер.ВыполнитьПодстановкуАлгоритмаРасчетаДолейСтоимости(Запрос.Текст, ПараметрыПодстановки);
	
	Запрос.УстановитьПараметр("Номенклатура", Номенклатура);
	Запрос.УстановитьПараметр("Характеристика", Характеристика);
	Запрос.УстановитьПараметр("Упаковка", Упаковка);
	
	Запрос.УстановитьПараметр("ВидЦены", ВидЦены);
	Запрос.УстановитьПараметр("СпособРаспределенияЗатратНаВыходныеИзделия", СпособРаспределенияЗатратНаВыходныеИзделия);
	
	Запрос.УстановитьПараметр("УпаковкаПустаяСсылка", Справочники.УпаковкиЕдиницыИзмерения.ПустаяСсылка());
	
	Выборка = Запрос.Выполнить().Выбрать();
	Выборка.Следующий();
	
	// Содержимое страниц
	Если СпособРаспределенияЗатратНаВыходныеИзделия = Перечисления.СпособыРаспределенияЗатратНаВыходныеИзделия.ПоПлановойСтоимости Тогда
		
		Список = Новый Массив;
		Список.Добавить(Элементы.ПлановаяЦена);
		Список.Добавить(Элементы.ПлановаяСтоимости);
		Список.Добавить(Элементы.ДоляСтоимостиИтогоПоПлановойСтоимости);
		ВывестиЕдиницуИзмеренияВПодсказку(Список, ВалютаЦены);
		
		Элементы.ГруппаПлановаяСтоимость.Подсказка = РасшифровкаРасчетаДолиСтоимостиПлановаяСтоимость(Выборка);
		
		Если ДоляСтоимостиНаЕдиницу = 0 И Не ЗначениеЗаполнено(Выборка.ВесОбъемЦена) Тогда
			Элементы.ТекстОшибкаЗаполненияЦена.Заголовок = СообщениеОбОшибкеЗаполненияФорматированнаяСтрока("Цена", Выборка);
			Элементы.ГруппаОшибкаЗаполненияЦена.Видимость = Истина;
		Иначе
			Элементы.ГруппаОшибкаЗаполненияЦена.Видимость = Ложь;
		КонецЕсли;
		
	КонецЕсли;
	
	Если СпособРаспределенияЗатратНаВыходныеИзделия = Перечисления.СпособыРаспределенияЗатратНаВыходныеИзделия.ПоВесу Тогда
		
		ТипЕдиницы = "";
		МернаяЕдиница = Справочники.УпаковкиЕдиницыИзмерения.ЭтоМернаяЕдиница(Выборка.ЕдиницаИзмерения, ТипЕдиницы);
		ЕдиницаИзмеренияПоУмолчанию = НоменклатураСервер.ЕдиницаИзмеренияПоУмолчанию("Вес");
		
		Если ( Не МернаяЕдиница ИЛИ ТипЕдиницы <> "Вес" ) Тогда
			Элементы.Вес.Заголовок = СтрШаблон(НСтр("ru='Вес (1 %1)';uk='Вага (1 %1)'"), Выборка.ЕдиницаИзмерения);
			Элементы.Вес.Видимость = Истина;
		Иначе
			Элементы.Вес.Видимость = Ложь;
		КонецЕсли;
		
		Список = Новый Массив;
		Список.Добавить(Элементы.Вес);
		Список.Добавить(Элементы.ВесСтроки);
		Список.Добавить(Элементы.ДоляСтоимостиИтогоПоВесу);
		ВывестиЕдиницуИзмеренияВПодсказку(Список, ЕдиницаИзмеренияПоУмолчанию);
		
		Элементы.ГруппаВесСтроки.Подсказка = РасшифровкаРасчетаДолиСтоимостиОбъемВес(Выборка, МернаяЕдиница, ТипЕдиницы, "Вес", ЕдиницаИзмеренияПоУмолчанию);
		
		Если ДоляСтоимостиНаЕдиницу = 0 И Не ЗначениеЗаполнено(Выборка.ВесОбъемЦена) Тогда
			Элементы.ТекстОшибкаЗаполненияВес.Заголовок = СообщениеОбОшибкеЗаполненияФорматированнаяСтрока("Вес", Выборка);
			Элементы.ГруппаОшибкаЗаполненияВес.Видимость = Истина;
		Иначе
			Элементы.ГруппаОшибкаЗаполненияВес.Видимость = Ложь;
		КонецЕсли;
		
	КонецЕсли;
	
	Если СпособРаспределенияЗатратНаВыходныеИзделия = Перечисления.СпособыРаспределенияЗатратНаВыходныеИзделия.ПоОбъему Тогда
		
		ТипЕдиницы = "";
		МернаяЕдиница = Справочники.УпаковкиЕдиницыИзмерения.ЭтоМернаяЕдиница(Выборка.ЕдиницаИзмерения, ТипЕдиницы);
		ЕдиницаИзмеренияПоУмолчанию = НоменклатураСервер.ЕдиницаИзмеренияПоУмолчанию("Объем");
		
		Если ( Не МернаяЕдиница ИЛИ ТипЕдиницы <> "Объем" ) Тогда
			Элементы.Объем.Заголовок = СтрШаблон(НСтр("ru='Объем (1 %1)';uk='Об''єм (1 %1)'"), Выборка.ЕдиницаИзмерения);
			Элементы.Объем.Видимость = Истина;
		Иначе
			Элементы.Объем.Видимость = Ложь;
		КонецЕсли;
		
		Список = Новый Массив;
		Список.Добавить(Элементы.Объем);
		Список.Добавить(Элементы.ОбъемСтроки);
		Список.Добавить(Элементы.ДоляСтоимостиИтогоПоОбъему);
		ВывестиЕдиницуИзмеренияВПодсказку(Список, ЕдиницаИзмеренияПоУмолчанию);
		
		Элементы.ГруппаОбъемСтроки.Подсказка = РасшифровкаРасчетаДолиСтоимостиОбъемВес(Выборка, МернаяЕдиница, ТипЕдиницы, "Объем", ЕдиницаИзмеренияПоУмолчанию);
		
		Если ДоляСтоимостиНаЕдиницу = 0 И Не ЗначениеЗаполнено(Выборка.ВесОбъемЦена) Тогда
			Элементы.ТекстОшибкаЗаполненияОбъем.Заголовок = СообщениеОбОшибкеЗаполненияФорматированнаяСтрока("Объем", Выборка);
			Элементы.ГруппаОшибкаЗаполненияОбъем.Видимость = Истина;
		Иначе
			Элементы.ГруппаОшибкаЗаполненияОбъем.Видимость = Ложь;
		КонецЕсли;
		
	КонецЕсли;
	
КонецПроцедуры

&НаСервере
Функция РасшифровкаРасчетаДолиСтоимостиОбъемВес(Выборка, МернаяЕдиница, ТипЕдиницы, Тип, ЕдиницаИзмеренияПоУмолчанию)
	
	МассивСтрок = Новый Массив();
	
	Если ЗначениеЗаполнено(Упаковка) ИЛИ НЕ ( МернаяЕдиница И ТипЕдиницы = Тип ) Тогда
		
		ЗнаменательЕдиницыИзмерения = "";
		
		Если ЗначениеЗаполнено(Упаковка) Тогда
			
			МассивСтрок.Добавить(СтрШаблон("%1 %2", КоличествоУпаковок, Выборка.УпаковкаПредставление));
			МассивСтрок.Добавить(" x ");
			
			ЗнаменательЕдиницыИзмерения = Выборка.УпаковкаПредставление;
			
		КонецЕсли;
		
		Если Не МернаяЕдиница ИЛИ ТипЕдиницы <> Тип Тогда
			
			Если ЗначениеЗаполнено(Упаковка) Тогда
				МассивСтрок.Добавить(СтрШаблон("%1 %2/%3", Выборка.КоэффициентУпаковка, Выборка.ЕдиницаИзмеренияПредставление, ЗнаменательЕдиницыИзмерения));
			Иначе
				МассивСтрок.Добавить(СтрШаблон("%1 %2", Количество, Выборка.ЕдиницаИзмеренияПредставление));
			КонецЕсли;
			
			МассивСтрок.Добавить(" x ");
			
			ЗнаменательЕдиницыИзмерения = Выборка.ЕдиницаИзмеренияПредставление;
			
		КонецЕсли;
		
		Если ЗнаменательЕдиницыИзмерения <> "" Тогда
			МассивСтрок.Добавить(СтрШаблон("%1 %2/%3", ДоляСтоимостиНаЕдиницу, ЕдиницаИзмеренияПоУмолчанию, ЗнаменательЕдиницыИзмерения));
		Иначе
			МассивСтрок.Добавить(СтрШаблон("%1 %2", ДоляСтоимостиНаЕдиницу, ЕдиницаИзмеренияПоУмолчанию));
		КонецЕсли;
		
	КонецЕсли;
	
	Расшифровка = СтрСоединить(МассивСтрок);
	Возврат Расшифровка; // 12кг (1 упак х 10 шт/упак х 1.2 кг/шт)
	
КонецФункции

&НаСервере
Функция РасшифровкаРасчетаДолиСтоимостиПлановаяСтоимость(Выборка)
	
	МассивСтрок = Новый Массив();
	
	Если ЗначениеЗаполнено(Выборка.Упаковка) Тогда
		МассивСтрок.Добавить(СтрШаблон("%1 %2", КоличествоУпаковок, Выборка.УпаковкаПредставление));
		МассивСтрок.Добавить(" x ");
		МассивСтрок.Добавить(СтрШаблон("%1 %2/%3", Выборка.КоэффициентУпаковка, Выборка.ЕдиницаИзмеренияПредставление, Выборка.УпаковкаПредставление));
	Иначе
		МассивСтрок.Добавить(СтрШаблон("%1 %2", Количество, Выборка.ЕдиницаИзмеренияПредставление));
	КонецЕсли;
	МассивСтрок.Добавить(" x ");
	Если Выборка.ЕдиницаИзмеренияПредставление <> "" Тогда
		МассивСтрок.Добавить(СтрШаблон("%1 %2/%3", ДоляСтоимостиНаЕдиницу, ВалютаЦены, Выборка.ЕдиницаИзмеренияПредставление));
	Иначе
		МассивСтрок.Добавить(СтрШаблон("%1 %2", ДоляСтоимостиНаЕдиницу, ВалютаЦены));
	КонецЕсли;
	
	Расшифровка = СтрСоединить(МассивСтрок);
	Возврат Расшифровка;
	
КонецФункции

&НаСервере
Функция СообщениеОбОшибкеЗаполненияФорматированнаяСтрока(Тип, Выборка)
	
	ТекстПредупреждения = Неопределено;
	НоменклатураПредставление = НоменклатураКлиентСервер.ПредставлениеНоменклатуры(Выборка.НоменклатураПредставление, Выборка.ХарактеристикаПредставление);
	
	Если Тип = "Цена" Тогда
		
		Строки = Новый Массив();
		
		Если ЗначениеЗаполнено(ВидЦены) Тогда
			СсылкаВидЦены = ПолучитьНавигационнуюСсылку(ВидЦены);
		Иначе
			СсылкаВидЦены = Неопределено;
		КонецЕсли;
		
		Строки.Добавить(НСтр("ru='Для номенклатуры';uk='Для номенклатури'") + " ");
		Строки.Добавить(Новый ФорматированнаяСтрока(НоменклатураПредставление,,,, ПолучитьНавигационнуюСсылку(Номенклатура)));
		Строки.Добавить(" " + НСтр("ru='не задана плановая';uk='не задана планова'") + " ");
		Строки.Добавить(Новый ФорматированнаяСтрока(НСтр("ru='цена';uk='ціна'"),,,, СсылкаВидЦены));
		
		ТекстПредупреждения = Новый ФорматированнаяСтрока(Строки); 
		
	КонецЕсли;
	
	Если Тип = "Объем" Тогда

		Строки = Новый Массив();
		
		Строки.Добавить(НСтр("ru='Для номенклатуры';uk='Для номенклатури'") + " ");
		Строки.Добавить(Новый ФорматированнаяСтрока(НоменклатураПредставление,,,, ПолучитьНавигационнуюСсылку(Номенклатура)));
		Строки.Добавить(" " + НСтр("ru='не задан объем';uk='не заданий об''єм'"));
		
		ТекстПредупреждения = Новый ФорматированнаяСтрока(Строки);
		
	КонецЕсли;
	
	Если Тип = "Вес" Тогда
		
		Строки = Новый Массив();
		
		Строки.Добавить(НСтр("ru='Для номенклатуры';uk='Для номенклатури'") + " ");
		Строки.Добавить(Новый ФорматированнаяСтрока(НоменклатураПредставление,,,, ПолучитьНавигационнуюСсылку(Номенклатура)));
		Строки.Добавить(" " + НСтр("ru='не задан вес';uk='не задано вагу'"));
		
		ТекстПредупреждения = Новый ФорматированнаяСтрока(Строки);
		
	КонецЕсли;
	
	Возврат ТекстПредупреждения;
	
КонецФункции

&НаСервереБезКонтекста
Процедура ВывестиЕдиницуИзмеренияВПодсказку(Список, ЕдиницаИзмерения)
	
	Для каждого Элемент Из Список Цикл
		Элемент.Подсказка = ЕдиницаИзмерения;
	КонецЦикла;
	
КонецПроцедуры

&НаКлиенте
Процедура ПриИзмененииДолиСтоимости()
	
	ДоляСтоимостиИтогоНовая = ДоляСтоимости + ДоляСтоимостиИтогоБезТекущего;
	
	Если ДоляСтоимостиИтогоНовая <> 0 Тогда
		ДоляСтоимостиПроцент = (ДоляСтоимости/ДоляСтоимостиИтогоНовая) * 100;
	Иначе
		ДоляСтоимостиПроцент = 0;
	КонецЕсли;
	
	НастроитьЗависимыеЭлементыФормы();
	
КонецПроцедуры

#КонецОбласти