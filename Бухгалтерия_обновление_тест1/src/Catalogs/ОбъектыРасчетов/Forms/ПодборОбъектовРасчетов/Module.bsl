
#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	// Пропускаем инициализацию, чтобы гарантировать получение формы при передаче параметра "АвтоТест".
	Если Параметры.Свойство("АвтоТест") Тогда
		Возврат;
	КонецЕсли;
	
	УстановитьУсловноеОформление();
	ОбъектСсылка         = Параметры.ОбъектСсылка;
	ТипРасчетов          = Параметры.ТипРасчетов;
	ВалютаВзаиморасчетов = Параметры.ВалютаВзаиморасчетов;
	Организация          = Параметры.Организация;
	Партнер              = Параметры.Партнер;
	Если ЗначениеЗаполнено(Партнер) Тогда
		Элементы.Партнер.Доступность = Ложь;
	КонецЕсли;
	Контрагент           = Параметры.Контрагент;
	Если ЗначениеЗаполнено(Контрагент) Тогда
		Элементы.Контрагент.Доступность = Ложь;
	КонецЕсли;
	
	СуммаДокумента = Параметры.СуммаДокумента;
	ВалютаДокумента = Параметры.ВалютаДокумента;
	ДатаДокумента  = Параметры.ДатаДокумента;
	
	АдресПлатежейВХранилище = Параметры.АдресПлатежейВХранилище;
	ПартнерПрочиеОтношения = Параметры.ПартнерПрочиеОтношения;
	ПодборДебиторскойЗадолженности = Параметры.ПодборДебиторскойЗадолженности;
	ПодборТолькоБезусловнойЗадолженности = Параметры.ПодборТолькоБезусловнойЗадолженности;
	УчитыватьФилиалы = Параметры.УчитыватьФилиалы;
	
	Если Контрагент = Неопределено Тогда
		Контрагент = Справочники.Контрагенты.ПустаяСсылка();
	КонецЕсли;
	
	ЗаполнитьТаблицуПоРасчетамСПартнерами(Параметры.ДополнительныеОтборы);
	УстановитьВидимость();
	
КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)
	
	РассчитатьСуммуПлатежей();
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовШапкиФормы

&НаКлиенте
Процедура ПартнерПриИзменении(Элемент)
	
	ЗаполнитьТаблицуПоРасчетамСПартнерами();
	
КонецПроцедуры

&НаКлиенте
Процедура КонтрагентПриИзменении(Элемент)
	
	ЗаполнитьТаблицуПоРасчетамСПартнерами();
	
КонецПроцедуры

&НаКлиенте
Процедура ТаблицаОстатковРасчетовПриОкончанииРедактирования(Элемент, НоваяСтрока, ОтменаРедактирования)
	
	РассчитатьСуммуПлатежей();
	
КонецПроцедуры

&НаКлиенте
Процедура ТаблицаОстатковРасчетовВыбор(Элемент, ВыбраннаяСтрока, Поле, СтандартнаяОбработка)
	
	Если Поле.Имя = "ТаблицаОстатковРасчетовОбъектРасчетов" Тогда
		СтрокаТаблицы = Элементы.ТаблицаОстатковРасчетов.ТекущиеДанные;
		Если СтрокаТаблицы <> Неопределено И ЗначениеЗаполнено(СтрокаТаблицы.ОбъектРасчетов) Тогда
			ПоказатьЗначение(Неопределено, СтрокаТаблицы.ОбъектРасчетов);
		КонецЕсли;
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура ПеренестиВДокументВыполнить()

	ПоместитьПлатежиВХранилище();
	Структура = Новый Структура("АдресПлатежейВХранилище", АдресПлатежейВХранилище);
	Структура.Вставить("ХозяйственнаяОперация", ?(ПодборДебиторскойЗадолженности, 
		ПредопределенноеЗначение("Перечисление.ХозяйственныеОперации.СписаниеДебиторскойЗадолженности"),
		ПредопределенноеЗначение("Перечисление.ХозяйственныеОперации.СписаниеКредиторскойЗадолженности")));
	Закрыть(Структура);
	
	ОповеститьОВыборе(Структура);
	
КонецПроцедуры

&НаКлиенте
Процедура ВыбратьПлатежиВыполнить()

	Для Каждого СтрокаТаблицы Из ТаблицаОстатковРасчетов Цикл
		СтрокаТаблицы.Выбран = Истина;
	КонецЦикла;
	РассчитатьСуммуПлатежей();
	
КонецПроцедуры

&НаКлиенте
Процедура ИсключитьПлатежиВыполнить()

	Для Каждого СтрокаТаблицы Из ТаблицаОстатковРасчетов Цикл
		СтрокаТаблицы.Выбран = Ложь
	КонецЦикла;
	РассчитатьСуммуПлатежей();
	
КонецПроцедуры

&НаКлиенте
Процедура ВыбратьВыделенныеПлатежи(Команда)
	
	МассивСтрок = Элементы.ТаблицаОстатковРасчетов.ВыделенныеСтроки;
	Для Каждого НомерСтроки Из МассивСтрок Цикл
		СтрокаТаблицы = ТаблицаОстатковРасчетов.НайтиПоИдентификатору(НомерСтроки);
		Если СтрокаТаблицы <> Неопределено Тогда
			СтрокаТаблицы.Выбран = Истина;
		КонецЕсли;
	КонецЦикла;
	РассчитатьСуммуПлатежей();
	
КонецПроцедуры

&НаКлиенте
Процедура ИсключитьВыделенныеПлатежи(Команда)
	
	МассивСтрок = Элементы.ТаблицаОстатковРасчетов.ВыделенныеСтроки;
	Для Каждого НомерСтроки Из МассивСтрок Цикл
		СтрокаТаблицы = ТаблицаОстатковРасчетов.НайтиПоИдентификатору(НомерСтроки);
		Если СтрокаТаблицы <> Неопределено Тогда
			СтрокаТаблицы.Выбран = Ложь;
		КонецЕсли;
	КонецЦикла;
	РассчитатьСуммуПлатежей();
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаСервере
Процедура УстановитьУсловноеОформление()

	УсловноеОформление.Элементы.Очистить();

	//

	Элемент = УсловноеОформление.Элементы.Добавить();

	ПолеЭлемента = Элемент.Поля.Элементы.Добавить();
	ПолеЭлемента.Поле = Новый ПолеКомпоновкиДанных(Элементы.ТаблицаОстатковРасчетов.Имя);

	ОтборЭлемента = Элемент.Отбор.Элементы.Добавить(Тип("ЭлементОтбораКомпоновкиДанных"));
	ОтборЭлемента.ЛевоеЗначение = Новый ПолеКомпоновкиДанных("ТаблицаОстатковРасчетов.Выбран");
	ОтборЭлемента.ВидСравнения = ВидСравненияКомпоновкиДанных.Равно;
	ОтборЭлемента.ПравоеЗначение = Ложь;

	Элемент.Оформление.УстановитьЗначениеПараметра("ЦветТекста", WebЦвета.RosyBrown);
	
	
КонецПроцедуры

#Область УправлениеЭлементамиФормы

&НаСервере
Процедура УстановитьВидимость()
	
	МассивЭлементов = Новый Массив;
	
	Если ТипРасчетов = Перечисления.ТипыРасчетовСПартнерами.РасчетыСКлиентом Тогда
		Если ПодборДебиторскойЗадолженности Тогда
			МассивЭлементов.Добавить("ТаблицаОстатковРасчетовНашДолг");
			МассивЭлементов.Добавить("ТаблицаОстатковРасчетовВалютаВзаиморасчетовНашДолг");
		Иначе
			МассивЭлементов.Добавить("ТаблицаОстатковРасчетовДолгПартнера");
			МассивЭлементов.Добавить("ТаблицаОстатковРасчетовКОплате");
			МассивЭлементов.Добавить("ТаблицаОстатковРасчетовВалютаВзаиморасчетовДолгПартнера");
			МассивЭлементов.Добавить("ТаблицаОстатковРасчетовВалютаВзаиморасчетов");
		КонецЕсли;
	ИначеЕсли ТипРасчетов = Перечисления.ТипыРасчетовСПартнерами.РасчетыСПоставщиком Тогда
		Если НЕ ПодборДебиторскойЗадолженности Тогда
			МассивЭлементов.Добавить("ТаблицаОстатковРасчетовДолгПартнера");
			МассивЭлементов.Добавить("ТаблицаОстатковРасчетовВалютаВзаиморасчетовДолгПартнера");
		Иначе
			МассивЭлементов.Добавить("ТаблицаОстатковРасчетовНашДолг");
			МассивЭлементов.Добавить("ТаблицаОстатковРасчетовКОплате");
			МассивЭлементов.Добавить("ТаблицаОстатковРасчетовВалютаВзаиморасчетовНашДолг");
			МассивЭлементов.Добавить("ТаблицаОстатковРасчетовВалютаВзаиморасчетов");
		КонецЕсли;
	КонецЕсли;
	
	ОбщегоНазначенияУТКлиентСервер.УстановитьСвойствоЭлементовФормы(
		Элементы, МассивЭлементов, "Видимость", Ложь);

	
	Если ТипЗнч(Контрагент) = Тип("СправочникСсылка.Организации") Тогда
		Заголовок = НСтр("ru='Подбор по расчетам между организациями';uk='Підбір за розрахунками між організаціями'");
	КонецЕсли;
	
	ПартнерыИКонтрагенты.ЗаголовокРеквизитаВЗависимостиОтФОИспользоватьПартнеровКакКонтрагентов(
		ЭтотОбъект, "ТаблицаОстатковРасчетовДолгПартнера", НСтр("ru='Долг контрагента';uk='Борг контрагента'"));
	
	ЕстьФилиалы = Справочники.Организации.ФилиалыСРасчетамиЧерезГоловнуюОрганизацию(Организация).Количество() > 0;
	Элементы.ТаблицаОстатковРасчетовОрганизация.Видимость = ЕстьФилиалы;
	
	Если СуммаДокумента = 0 Тогда
		Элементы.СуммаДокумента.Видимость = Ложь;
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Область Прочее

&НаСервере
Процедура ПоместитьПлатежиВХранилище()
	
	Платежи = ТаблицаОстатковРасчетов.Выгрузить(, "Выбран, Сумма, ОбъектРасчетов, ВалютаВзаиморасчетов, Партнер, Контрагент, Договор, Организация, ДолгПартнера, НашДолг, ТипРасчетов");
	
	сч = 0;
	Пока сч < Платежи.Количество() Цикл
		Если Не Платежи[сч].Выбран Тогда
			Платежи.Удалить(сч);
		Иначе 
			сч = сч + 1;
		КонецЕсли;
	КонецЦикла;
	
	Если Платежи.Итог("Сумма") < СуммаДокумента И СуммаДокумента > 0 Тогда
		СтрокаТаблицы = Платежи.Добавить();
		СтрокаТаблицы.Сумма = СуммаДокумента - Платежи.Итог("Сумма");
		Если ЗначениеЗаполнено(Партнер) Тогда
			СтрокаТаблицы.Партнер = Партнер;
		Иначе
			СтрокаТаблицы.Партнер = ДенежныеСредстваСервер.ПолучитьПартнераПоКонтрагенту(Контрагент);
		КонецЕсли;
		СтрокаТаблицы.ОбъектРасчетов = ОбъектыРасчетовСервер.ПолучитьОбъектРасчетовПоСсылке(ОбъектСсылка);
	КонецЕсли;
	
	ОплатаОтКлиента = (ТипРасчетов = Перечисления.ТипыРасчетовСПартнерами.РасчетыСКлиентом);
	
	Платежи.Колонки.Добавить("ОснованиеПлатежа");
	Платежи.ЗагрузитьКолонку(Платежи.ВыгрузитьКолонку("ОбъектРасчетов"), "ОснованиеПлатежа");
	
	АдресПлатежейВХранилище = ПоместитьВоВременноеХранилище(Платежи, УникальныйИдентификатор);
	
КонецПроцедуры

&НаСервере
Процедура ЗаполнитьТаблицуПоРасчетамСПартнерами(ДополнительныеОтборы = Неопределено)
	
	Реквизиты = Новый Структура;
	Реквизиты.Вставить("Дата", ДатаДокумента);
	Реквизиты.Вставить("Организация", Организация);
	Реквизиты.Вставить("СуммаДокумента", СуммаДокумента);
	Реквизиты.Вставить("Валюта", ВалютаДокумента);
	Реквизиты.Вставить("Контрагент", Контрагент);
	Реквизиты.Вставить("Партнер", Партнер);
	
	Если ЗначениеЗаполнено(ТипРасчетов) Тогда
		Реквизиты.Вставить("ТипРасчетов", ТипРасчетов);
	КонецЕсли;
	
	Реквизиты.Вставить("ПартнерПрочиеОтношения", ПартнерПрочиеОтношения);
	Реквизиты.Вставить("ПодборДебиторскойЗадолженности", ПодборДебиторскойЗадолженности);
	Реквизиты.Вставить("ПодборТолькоБезусловнойЗадолженности", ПодборТолькоБезусловнойЗадолженности);
	
	Реквизиты.Вставить("УчитыватьФилиалы", УчитыватьФилиалы);
	
	ВзаиморасчетыСервер.ЗаполнитьТаблицуОстатковРасчетов(Реквизиты, АдресПлатежейВХранилище, ТаблицаОстатковРасчетов, ДополнительныеОтборы);
	
КонецПроцедуры

&НаКлиенте
Процедура РассчитатьСуммуПлатежей()
	
	СуммаПлатежей = 0;
	Для Каждого СтрокаТаблицы Из ТаблицаОстатковРасчетов Цикл
		
		Если СтрокаТаблицы.Выбран Тогда
			СуммаПлатежей = СуммаПлатежей + СтрокаТаблицы.Сумма;
		КонецЕсли;
		
	КонецЦикла;
	
КонецПроцедуры

#КонецОбласти

#КонецОбласти
