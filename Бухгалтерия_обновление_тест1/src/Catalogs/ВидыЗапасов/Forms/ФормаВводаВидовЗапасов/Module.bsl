
#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)

	УстановитьУсловноеОформление();

	// Пропускаем инициализацию, чтобы гарантировать получение формы при передаче параметра "АвтоТест".
	Если Параметры.Свойство("АвтоТест") Тогда
		Возврат;
	КонецЕсли;
	
	ПараметрыРедактированияВидовЗапасов = Новый ФиксированнаяСтруктура(Параметры.ПараметрыРедактированияВидовЗапасов);
	
	ЗаполнитьЗначенияСвойств(ЭтотОбъект, ПараметрыРедактированияВидовЗапасов);
		
	ЗаполнитьДеревоВидовЗапасов();
	
	Элементы.ПереключитьРедактированиеВидовЗапасов.Видимость = РедактироватьВидыЗапасов;
	Элементы.ДеревоВидовЗапасов.ТолькоПросмотр = Не РедактироватьВидыЗапасов;
	Элементы.ГруппаДерево.Видимость = РедактироватьВидыЗапасов;
	Элементы.ГруппаФормыДерево.Видимость = РедактироватьВидыЗапасов;
	Элементы.ГруппаФормы.Видимость = Не РедактироватьВидыЗапасов;
	Элементы.ПеренестиВДокумент.Видимость = РедактироватьВидыЗапасов;
	
	Элементы.КартинкаВнимание.Видимость = ДокументМодифицирован;
	Элементы.НадписьДокументМодифицирован.Видимость = ДокументМодифицирован;
	
	Элементы.ДеревоВидовЗапасовДокументРеализации.Видимость = ПараметрыРедактированияВидовЗапасов.ОтображатьДокументыРеализации;
	
	Если ПараметрыРедактированияВидовЗапасов.ОтображатьДокументыРеализации Тогда
		Элементы.ВидЗапасов.ФормаВыбора = "Справочник.ВидыЗапасов.Форма.ФормаВыбора";
	Иначе
		Элементы.ВидЗапасов.ФормаВыбора = "Справочник.ВидыЗапасов.Форма.ФормаВыбораПоОстаткам";
	КонецЕсли;	
	
	Элементы.ДеревоВидовЗапасовСуммаСНДС.Заголовок = 
		?(ПолучитьФункциональнуюОпцию("ИспользоватьУчетНДС"), НСтр("ru='Сумма с НДС';uk='Сума з ПДВ'"), НСтр("ru='Сумма';uk='Сума'"));
	
	НастроитьРедактированиеВидовЗапасов(Элементы.ПереключитьРедактированиеВидовЗапасов.Видимость И ВидыЗапасовУказаныВручную, Ложь);

	СобытияФорм.ПриСозданииНаСервере(ЭтаФорма, Отказ, СтандартнаяОбработка);

КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)
	
	ЭлементыДерева = ДеревоВидовЗапасов.ПолучитьЭлементы();
	Для Каждого ЭлементДерева Из ЭлементыДерева Цикл
		Если ЭлементДерева.ПолучитьРодителя() = Неопределено Тогда
			Элементы.ДеревоВидовЗапасов.Развернуть(ЭлементДерева.ПолучитьИдентификатор());
		КонецЕсли;
	КонецЦикла;
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовШапкиФормы

&НаКлиенте
Процедура ДеревоВидовЗапасовВыбор(Элемент, ВыбраннаяСтрока, Поле, СтандартнаяОбработка)
	
	Если Элемент.ТекущиеДанные.Свойство(Поле.Имя) Тогда
		Значение = Неопределено;
		Если Поле.Имя = "НомерСтроки" Тогда
			Если ЗначениеЗаполнено(Элемент.ТекущиеДанные.Номенклатура) Тогда
				Значение = Элемент.ТекущиеДанные.Номенклатура;
			Иначе
				Значение = Элемент.ТекущиеДанные.НоменклатураВидыЗапасов;
			КонецЕсли;
			СтандартнаяОбработка = Ложь;
		ИначеЕсли Элементы.ДеревоВидовЗапасов.ТолькоПросмотр Тогда
			Значение = Элемент.ТекущиеДанные[Поле.Имя];
		КонецЕсли;
		Если ЗначениеЗаполнено(Значение) Тогда
			ПоказатьЗначение(Неопределено, Значение);
		КонецЕсли;
	ИначеЕсли Элементы.ДеревоВидовЗапасов.ТолькоПросмотр Тогда
		Если ЗначениеЗаполнено(Элемент.ТекущиеДанные.ВидЗапасов) Тогда
			ПоказатьЗначение(Неопределено, Элемент.ТекущиеДанные.ВидЗапасов);
		КонецЕсли;
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ДеревоВидовЗапасовПередНачаломДобавления(Элемент, Отказ, Копирование, Родитель, Группа)
	
	СтрокаРодитель = Элемент.ТекущиеДанные.ПолучитьРодителя();
	Если Не Копирование
	 И СтрокаРодитель <> Неопределено Тогда
	 
		Отказ = Истина;
		Элемент.ТекущаяСтрока = СтрокаРодитель.ПолучитьИдентификатор();
		Элемент.ДобавитьСтроку();
		
	ИначеЕсли Копирование
	 И СтрокаРодитель = Неопределено Тогда
	 
		Отказ = Истина;
		
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ДеревоВидовЗапасовПередУдалением(Элемент, Отказ)
	
	СтрокаТаблицы = Элемент.ТекущиеДанные;
	Если СтрокаТаблицы.ПолучитьРодителя() = Неопределено Тогда
		ПоказатьПредупреждение(Неопределено, НСтр("ru='Корневую строку дерева удалять нельзя';uk='Кореневий рядок дерева видаляти не можна'"));
		Отказ = Истина;
	КонецЕсли;
	
	Если Не Отказ Тогда
		СтрокаРодитель = СтрокаТаблицы.ПолучитьРодителя();
		СтрокаРодитель.КоличествоВидыЗапасов = 0;
		Для Каждого Строка Из СтрокаРодитель.ПолучитьЭлементы() Цикл
			СтрокаРодитель.КоличествоВидыЗапасов = СтрокаРодитель.КоличествоВидыЗапасов + Строка.Количество;
		КонецЦикла;
		СтрокаРодитель.КоличествоВидыЗапасов = СтрокаРодитель.КоличествоВидыЗапасов - СтрокаТаблицы.Количество;
		ЗаполнитьПолеИнформации(СтрокаРодитель);
	КонецЕсли;

КонецПроцедуры

&НаКлиенте
Процедура ДеревоВидовЗапасовПриНачалеРедактирования(Элемент, НоваяСтрока, Копирование)
	
	Если НоваяСтрока И Не Копирование Тогда
		
		СтрокаТаблицы = Элемент.ТекущиеДанные;
		СтрокаРодитель = СтрокаТаблицы.ПолучитьРодителя();
		
		СуммаВидыЗапасов = 0;
		СуммаНДСВидыЗапасов = 0;
		КоличествоВидыЗапасов = 0;
		СтрокиДерева = СтрокаРодитель.ПолучитьЭлементы();
		Для Каждого Строка Из СтрокиДерева Цикл
			КоличествоВидыЗапасов = КоличествоВидыЗапасов + Строка.Количество;
			СуммаВидыЗапасов = СуммаВидыЗапасов + Строка.СуммаСНДС;
			СуммаНДСВидыЗапасов = СуммаНДСВидыЗапасов + Строка.СуммаНДС;
		КонецЦикла;
		СтрокаРодитель.КоличествоВидыЗапасов = СтрокаРодитель.Количество;
		ЗаполнитьПолеИнформации(СтрокаРодитель);
		
		СтрокаТаблицы.НоменклатураВидыЗапасов = СтрокаРодитель.Номенклатура;
		СтрокаТаблицы.ХарактеристикаВидыЗапасов = СтрокаРодитель.Характеристика;
		СтрокаТаблицы.СтавкаНДС = СтрокаРодитель.СтавкаНДС;
		СтрокаТаблицы.Количество = СтрокаРодитель.Количество - КоличествоВидыЗапасов;
		СтрокаТаблицы.СуммаСНДС = СтрокаРодитель.СуммаСНДС - СуммаВидыЗапасов;
		СтрокаТаблицы.СуммаНДС = СтрокаРодитель.СуммаНДС - СуммаНДСВидыЗапасов;
		
		СтрокаТаблицы.ДокументРеализации = СтрокаРодитель.ДокументРеализации;
		Если ЗначениеЗаполнено(СтрокаРодитель.ДокументРеализации) Тогда
			СтрокаТаблицы.СкладОтгрузки = Склад;
		КонецЕсли;
		
		СтрокаТаблицы.ВедетсяУчетПоГТД = СтрокаРодитель.ВедетсяУчетПоГТД;
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ДеревоВидовЗапасовКоличествоПриИзменении(Элемент)
	
	СтрокаТаблицы = Элементы.ДеревоВидовЗапасов.ТекущиеДанные;
	СтрокаРодитель = СтрокаТаблицы.ПолучитьРодителя();
	
	Если СтрокаРодитель.Количество <> 0 Тогда
		СтрокаТаблицы.СуммаСНДС = Окр(СтрокаТаблицы.Количество * СтрокаРодитель.СуммаСНДС / СтрокаРодитель.Количество, 2, РежимОкругления.Окр15как20);
	Иначе
		СтрокаТаблицы.СуммаСНДС = 0;
	КонецЕсли;
	
	Если СтрокаРодитель.СуммаСНДС <> 0 Тогда
		СтрокаТаблицы.СуммаНДС = Окр(СтрокаТаблицы.СуммаСНДС * СтрокаРодитель.СуммаНДС / СтрокаРодитель.СуммаСНДС, 2, РежимОкругления.Окр15как20);
	Иначе
		СтрокаТаблицы.СуммаНДС = 0;
	КонецЕсли;
	
	СтрокаРодитель.КоличествоВидыЗапасов = 0;
	Для Каждого Строка Из СтрокаРодитель.ПолучитьЭлементы() Цикл
		СтрокаРодитель.КоличествоВидыЗапасов = СтрокаРодитель.КоличествоВидыЗапасов + Строка.Количество;
	КонецЦикла;
	ЗаполнитьПолеИнформации(СтрокаРодитель);
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура ПереключитьРедактированиеВидовЗапасов(Команда)
	
	НастроитьРедактированиеВидовЗапасов(Не ВидыЗапасовУказаныВручную);
	
КонецПроцедуры

&НаКлиенте
Процедура ПеренестиВДокумент(Команда)
	
	ПоместитьВидыЗапасовВХранилище();
	Закрыть(КодВозвратаДиалога.OK);
	
	Результат = ОбщегоНазначенияКлиентСервер.СкопироватьСтруктуру(ПараметрыРедактированияВидовЗапасов);
	Результат.ВидыЗапасовУказаныВручную = ВидыЗапасовУказаныВручную;
	
	ОповеститьОВыборе(Результат);
	
КонецПроцедуры

&НаКлиенте
Процедура Подключаемый_ВыполнитьПереопределяемуюКоманду(Команда)
	
	СобытияФормКлиент.ВыполнитьПереопределяемуюКоманду(ЭтаФорма, Команда);
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаСервере
Процедура УстановитьУсловноеОформление()

	УсловноеОформление.Элементы.Очистить();

	//

	Элемент = УсловноеОформление.Элементы.Добавить();

	ПолеЭлемента = Элемент.Поля.Элементы.Добавить();
	ПолеЭлемента.Поле = Новый ПолеКомпоновкиДанных(Элементы.ДеревоВидовЗапасов.Имя);

	ОтборЭлемента = Элемент.Отбор.Элементы.Добавить(Тип("ЭлементОтбораКомпоновкиДанных"));
	ОтборЭлемента.ЛевоеЗначение = Новый ПолеКомпоновкиДанных("ДеревоВидовЗапасов.Номенклатура");
	ОтборЭлемента.ВидСравнения = ВидСравненияКомпоновкиДанных.Заполнено;
	Элемент.Оформление.УстановитьЗначениеПараметра("ЦветФона", ЦветаСтиля.ReportGroup1BackColor);
	Элемент.Оформление.УстановитьЗначениеПараметра("ТолькоПросмотр", Истина);

	//

	Элемент = УсловноеОформление.Элементы.Добавить();

	ПолеЭлемента = Элемент.Поля.Элементы.Добавить();
	ПолеЭлемента.Поле = Новый ПолеКомпоновкиДанных(Элементы.ДеревоВидовЗапасов.Имя);

	ОтборЭлемента = Элемент.Отбор.Элементы.Добавить(Тип("ЭлементОтбораКомпоновкиДанных"));
	ОтборЭлемента.ЛевоеЗначение = Новый ПолеКомпоновкиДанных("ДеревоВидовЗапасов.НоменклатураВидыЗапасов");
	ОтборЭлемента.ВидСравнения = ВидСравненияКомпоновкиДанных.Заполнено;

	ОтборЭлемента = Элемент.Отбор.Элементы.Добавить(Тип("ЭлементОтбораКомпоновкиДанных"));
	ОтборЭлемента.ЛевоеЗначение = Новый ПолеКомпоновкиДанных("ДеревоВидовЗапасов.ВидЗапасов");
	ОтборЭлемента.ВидСравнения = ВидСравненияКомпоновкиДанных.НеЗаполнено;
	Элемент.Оформление.УстановитьЗначениеПараметра("ЦветТекста", ЦветаСтиля.ПросроченныеДанныеЦвет);

	//

	Элемент = УсловноеОформление.Элементы.Добавить();

	ПолеЭлемента = Элемент.Поля.Элементы.Добавить();
	ПолеЭлемента.Поле = Новый ПолеКомпоновкиДанных(Элементы.ДеревоВидовЗапасовКоличество.Имя);

	ПолеЭлемента = Элемент.Поля.Элементы.Добавить();
	ПолеЭлемента.Поле = Новый ПолеКомпоновкиДанных(Элементы.ДеревоВидовЗапасовИнформация.Имя);

	ОтборЭлемента = Элемент.Отбор.Элементы.Добавить(Тип("ЭлементОтбораКомпоновкиДанных"));
	ОтборЭлемента.ЛевоеЗначение = Новый ПолеКомпоновкиДанных("ДеревоВидовЗапасов.Количество");
	ОтборЭлемента.ВидСравнения = ВидСравненияКомпоновкиДанных.НеРавно;
	ОтборЭлемента.ПравоеЗначение = Новый ПолеКомпоновкиДанных("ДеревоВидовЗапасов.КоличествоВидыЗапасов");

	ОтборЭлемента = Элемент.Отбор.Элементы.Добавить(Тип("ЭлементОтбораКомпоновкиДанных"));
	ОтборЭлемента.ЛевоеЗначение = Новый ПолеКомпоновкиДанных("ДеревоВидовЗапасов.Номенклатура");
	ОтборЭлемента.ВидСравнения = ВидСравненияКомпоновкиДанных.Заполнено;
	Элемент.Оформление.УстановитьЗначениеПараметра("ЦветТекста", ЦветаСтиля.ПоясняющийОшибкуТекст);
	Элемент.Оформление.УстановитьЗначениеПараметра("Отображать", Истина);

	//

	Элемент = УсловноеОформление.Элементы.Добавить();

	ПолеЭлемента = Элемент.Поля.Элементы.Добавить();
	ПолеЭлемента.Поле = Новый ПолеКомпоновкиДанных(Элементы.ДеревоВидовЗапасовСуммаСНДС.Имя);

	ПолеЭлемента = Элемент.Поля.Элементы.Добавить();
	ПолеЭлемента.Поле = Новый ПолеКомпоновкиДанных(Элементы.ДеревоВидовЗапасовИнформация.Имя);

	ОтборЭлемента = Элемент.Отбор.Элементы.Добавить(Тип("ЭлементОтбораКомпоновкиДанных"));
	ОтборЭлемента.ЛевоеЗначение = Новый ПолеКомпоновкиДанных("ДеревоВидовЗапасов.СуммаСНДС");
	ОтборЭлемента.ВидСравнения = ВидСравненияКомпоновкиДанных.НеРавно;
	ОтборЭлемента.ПравоеЗначение = Новый ПолеКомпоновкиДанных("ДеревоВидовЗапасов.СуммаСНДСВидыЗапасов");

	ОтборЭлемента = Элемент.Отбор.Элементы.Добавить(Тип("ЭлементОтбораКомпоновкиДанных"));
	ОтборЭлемента.ЛевоеЗначение = Новый ПолеКомпоновкиДанных("ДеревоВидовЗапасов.Номенклатура");
	ОтборЭлемента.ВидСравнения = ВидСравненияКомпоновкиДанных.Заполнено;
	Элемент.Оформление.УстановитьЗначениеПараметра("ЦветТекста", ЦветаСтиля.ПоясняющийОшибкуТекст);
	Элемент.Оформление.УстановитьЗначениеПараметра("Отображать", Истина);

	//

	Элемент = УсловноеОформление.Элементы.Добавить();

	ПолеЭлемента = Элемент.Поля.Элементы.Добавить();
	ПолеЭлемента.Поле = Новый ПолеКомпоновкиДанных(Элементы.ДеревоВидовЗапасовСуммаНДС.Имя);

	ПолеЭлемента = Элемент.Поля.Элементы.Добавить();
	ПолеЭлемента.Поле = Новый ПолеКомпоновкиДанных(Элементы.ДеревоВидовЗапасовИнформация.Имя);

	ОтборЭлемента = Элемент.Отбор.Элементы.Добавить(Тип("ЭлементОтбораКомпоновкиДанных"));
	ОтборЭлемента.ЛевоеЗначение = Новый ПолеКомпоновкиДанных("ДеревоВидовЗапасов.СуммаНДС");
	ОтборЭлемента.ВидСравнения = ВидСравненияКомпоновкиДанных.НеРавно;
	ОтборЭлемента.ПравоеЗначение = Новый ПолеКомпоновкиДанных("ДеревоВидовЗапасов.СуммаНДСВидыЗапасов");

	ОтборЭлемента = Элемент.Отбор.Элементы.Добавить(Тип("ЭлементОтбораКомпоновкиДанных"));
	ОтборЭлемента.ЛевоеЗначение = Новый ПолеКомпоновкиДанных("ДеревоВидовЗапасов.Номенклатура");
	ОтборЭлемента.ВидСравнения = ВидСравненияКомпоновкиДанных.Заполнено;
	Элемент.Оформление.УстановитьЗначениеПараметра("ЦветТекста", ЦветаСтиля.ПоясняющийОшибкуТекст);
	Элемент.Оформление.УстановитьЗначениеПараметра("Отображать", Истина);

	//

	Элемент = УсловноеОформление.Элементы.Добавить();

	ПолеЭлемента = Элемент.Поля.Элементы.Добавить();
	ПолеЭлемента.Поле = Новый ПолеКомпоновкиДанных(Элементы.НомерГТД.Имя);

	ОтборЭлемента = Элемент.Отбор.Элементы.Добавить(Тип("ЭлементОтбораКомпоновкиДанных"));
	ОтборЭлемента.ЛевоеЗначение = Новый ПолеКомпоновкиДанных("ДеревоВидовЗапасов.НомерГТД");
	ОтборЭлемента.ВидСравнения = ВидСравненияКомпоновкиДанных.НеЗаполнено;

	ОтборЭлемента = Элемент.Отбор.Элементы.Добавить(Тип("ЭлементОтбораКомпоновкиДанных"));
	ОтборЭлемента.ЛевоеЗначение = Новый ПолеКомпоновкиДанных("ДеревоВидовЗапасов.ВедетсяУчетПоГТД");
	ОтборЭлемента.ВидСравнения = ВидСравненияКомпоновкиДанных.Равно;
	ОтборЭлемента.ПравоеЗначение = Ложь;

	ОтборЭлемента = Элемент.Отбор.Элементы.Добавить(Тип("ЭлементОтбораКомпоновкиДанных"));
	ОтборЭлемента.ЛевоеЗначение = Новый ПолеКомпоновкиДанных("ДеревоВидовЗапасов.НоменклатураВидыЗапасов");
	ОтборЭлемента.ВидСравнения = ВидСравненияКомпоновкиДанных.Заполнено;
	Элемент.Оформление.УстановитьЗначениеПараметра("ЦветТекста", ЦветаСтиля.ЦветТекстаОтмененнойСтрокиДокумента);
    Элемент.Оформление.УстановитьЗначениеПараметра("Текст", НСтр("ru='<Коды для НН и номера ГТД не используются>';uk='<Коди для ПН і номери ВМД не використовуються>'"));
	Элемент.Оформление.УстановитьЗначениеПараметра("ТолькоПросмотр", Истина);

КонецПроцедуры

#Область УправлениеЭлементамиФормы

&НаСервере
Процедура НастроитьРедактированиеВидовЗапасов(РедактированиеВключено, ЗаполнятьДеревоВидовЗапасов = Истина)
	
	Если Элементы.ПереключитьРедактированиеВидовЗапасов.Видимость Тогда
		ВидыЗапасовУказаныВручную = РедактированиеВключено;
		Элементы.ПереключитьРедактированиеВидовЗапасов.Пометка = ВидыЗапасовУказаныВручную;
		Элементы.ДеревоВидовЗапасов.ТолькоПросмотр = Не РедактированиеВключено;
		Элементы.ГруппаВидыЗапасовУказаныВручную.Видимость = РедактированиеВключено;
		
		Если ЗаполнятьДеревоВидовЗапасов Тогда
			ЗаполнитьДеревоВидовЗапасов();
		КонецЕсли;
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Область Прочее

&НаСервере
Процедура ПоместитьВидыЗапасовВХранилище() 
	
	ТаблицаВидыЗапасов = ПолучитьИзВременногоХранилища(АдресВидовЗапасовВХранилище).СкопироватьКолонки();
	ЕстьСуммаСНДС = (ТаблицаВидыЗапасов.Колонки.Найти("СуммаСНДС") <> Неопределено);
	ЕстьСуммаНДС = (ТаблицаВидыЗапасов.Колонки.Найти("СуммаНДС") <> Неопределено);
	ЕстьСтавкаНДС = (ТаблицаВидыЗапасов.Колонки.Найти("СтавкаНДС") <> Неопределено);
	ЕстьСклад = (ТаблицаВидыЗапасов.Колонки.Найти("Склад") <> Неопределено);
	ЕстьСкладОтгрузки = (ТаблицаВидыЗапасов.Колонки.Найти("СкладОтгрузки") <> Неопределено);
	ЕстьДокументРеализации = (ТаблицаВидыЗапасов.Колонки.Найти("ДокументРеализации") <> Неопределено);
	ЕстьСпособОпределенияСебестоимости = (ТаблицаВидыЗапасов.Колонки.Найти("СпособОпределенияСебестоимости") <> Неопределено);
	
	Дерево = РеквизитФормыВЗначение("ДеревоВидовЗапасов");
	Для Каждого СтрокаНоменклатуры Из Дерево.Строки Цикл
		
		Для Каждого Строка Из СтрокаНоменклатуры.Строки Цикл
		
			НоваяСтрока = ТаблицаВидыЗапасов.Добавить();
			НоваяСтрока.АналитикаУчетаНоменклатуры = СтрокаНоменклатуры.АналитикаУчетаНоменклатуры;
			НоваяСтрока.ВидЗапасов = Строка.ВидЗапасов;
			НоваяСтрока.НомерГТД = Строка.НомерГТД;
			НоваяСтрока.Количество = Строка.Количество;
			Если ЕстьСуммаСНДС Тогда
				НоваяСтрока.СуммаСНДС = Строка.СуммаСНДС;
			КонецЕсли;
			Если ЕстьСуммаНДС Тогда
				НоваяСтрока.СуммаНДС = Строка.СуммаНДС;
			КонецЕсли;
			Если ЕстьСтавкаНДС Тогда
				НоваяСтрока.СтавкаНДС = Строка.СтавкаНДС;
			КонецЕсли;
			Если ЕстьСкладОтгрузки Тогда
				НоваяСтрока.СкладОтгрузки = Строка.СкладОтгрузки;
			КонецЕсли;
			Если ЕстьДокументРеализации Тогда
				НоваяСтрока.ДокументРеализации = Строка.ДокументРеализации;
			КонецЕсли;
			Если ЕстьСпособОпределенияСебестоимости Тогда
				НоваяСтрока.СпособОпределенияСебестоимости = Строка.СпособОпределенияСебестоимости;
			КонецЕсли;
			
		КонецЦикла;
		
	КонецЦикла;

	ПоместитьВоВременноеХранилище(ТаблицаВидыЗапасов, АдресВидовЗапасовВХранилище);
	
КонецПроцедуры

&НаСервере
Процедура ЗаполнитьДеревоВидовЗапасов()
	
	Запрос = Новый Запрос("
	|ВЫБРАТЬ
	|	ИсходнаяТаблицаДокумента.НомерСтроки КАК НомерСтроки,
	|	ИсходнаяТаблицаДокумента.АналитикаУчетаНоменклатуры КАК АналитикаУчетаНоменклатуры,
	|	ИсходнаяТаблицаДокумента.Склад КАК Склад,
	|	ИсходнаяТаблицаДокумента.ДокументРеализации КАК ДокументРеализации,
	|	ИсходнаяТаблицаДокумента.СпособОпределенияСебестоимости КАК СпособОпределенияСебестоимости,
	|	ИсходнаяТаблицаДокумента.Номенклатура КАК Номенклатура,
	|	ИсходнаяТаблицаДокумента.Характеристика КАК Характеристика,
	|	ИсходнаяТаблицаДокумента.Серия КАК Серия,
	|	ИсходнаяТаблицаДокумента.Назначение КАК Назначение,
	|	ИсходнаяТаблицаДокумента.Количество КАК Количество,
	|	(ВЫБОР
	|		КОГДА ИсходнаяТаблицаДокумента.Количество < 0 ТОГДА -1
	|		ИНАЧЕ 1 КОНЕЦ) КАК Знак,
	|	ВЫБОР КОГДА ИсходнаяТаблицаДокумента.СуммаПродажи <> 0 ТОГДА
	|		ИсходнаяТаблицаДокумента.СуммаПродажи
	|	ИНАЧЕ
	|		ИсходнаяТаблицаДокумента.Сумма
	|	КОНЕЦ КАК Сумма,
	|	ВЫБОР КОГДА ИсходнаяТаблицаДокумента.СуммаПродажи <> 0 ТОГДА
	|		0
	|	ИНАЧЕ
	|		ИсходнаяТаблицаДокумента.СуммаНДС
	|	КОНЕЦ КАК СуммаНДС,
	|	ИсходнаяТаблицаДокумента.СтавкаНДС КАК СтавкаНДС
	|	
	|ПОМЕСТИТЬ ИсходнаяТаблицаДокумента
	|ИЗ
	|	&ИсходнаяТаблицаДокумента КАК ИсходнаяТаблицаДокумента
	|;
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ
	|	МАКСИМУМ(ИсходнаяТаблицаДокумента.НомерСтроки) КАК НомерСтроки,
	|	ЕСТЬNULL(Аналитика.КлючАналитики, ИсходнаяТаблицаДокумента.АналитикаУчетаНоменклатуры) КАК АналитикаУчетаНоменклатуры,
	|	ИсходнаяТаблицаДокумента.Склад КАК Склад,
	|	ВЫБОР 
	|		КОГДА &ОтображатьДокументыРеализации
	|		ТОГДА ИсходнаяТаблицаДокумента.ДокументРеализации
	|		ИНАЧЕ НЕОПРЕДЕЛЕНО
	|	КОНЕЦ ДокументРеализации,
	|	ИсходнаяТаблицаДокумента.СпособОпределенияСебестоимости КАК СпособОпределенияСебестоимости,
	|	ИсходнаяТаблицаДокумента.Номенклатура КАК Номенклатура,
	|	СправочникНоменклатура.ВестиУчетПоГТД КАК ВестиУчетПоГТД,
	|	ИсходнаяТаблицаДокумента.Характеристика КАК Характеристика,
	|	ИсходнаяТаблицаДокумента.Серия КАК Серия,
	|	ИсходнаяТаблицаДокумента.Знак КАК Знак,
	|	СУММА(ИсходнаяТаблицаДокумента.Количество) КАК Количество,
	|	СУММА(
	|		ИсходнаяТаблицаДокумента.Сумма
	|		+ &ЦенаНеВключаетНДС * ИсходнаяТаблицаДокумента.СуммаНДС
	|	) КАК СуммаСНДС,
	|	МАКСИМУМ(ИсходнаяТаблицаДокумента.СтавкаНДС) КАК СтавкаНДС,
	|	СУММА(ИсходнаяТаблицаДокумента.СуммаНДС) КАК СуммаНДС
	|	
	|ПОМЕСТИТЬ ТаблицаДокумента
	|ИЗ
	|	ИсходнаяТаблицаДокумента КАК ИсходнаяТаблицаДокумента
	|
	|	ЛЕВОЕ СОЕДИНЕНИЕ
	|		Справочник.Номенклатура КАК СправочникНоменклатура
	|	ПО
	|		ИсходнаяТаблицаДокумента.Номенклатура = СправочникНоменклатура.Ссылка
	|
	|	ЛЕВОЕ СОЕДИНЕНИЕ
	|		РегистрСведений.АналитикаУчетаНоменклатуры КАК Аналитика
	|	ПО
	|		ИсходнаяТаблицаДокумента.Номенклатура = Аналитика.Номенклатура
	|		И ИсходнаяТаблицаДокумента.Характеристика = Аналитика.Характеристика
	|		И ИсходнаяТаблицаДокумента.Серия = Аналитика.Серия
	|		И ИсходнаяТаблицаДокумента.Склад = Аналитика.МестоХранения
	|		И ИсходнаяТаблицаДокумента.Назначение = Аналитика.Назначение
	|		И ИсходнаяТаблицаДокумента.АналитикаУчетаНоменклатуры = ЗНАЧЕНИЕ(Справочник.КлючиАналитикиУчетаНоменклатуры.ПустаяСсылка)
	//++ НЕ УТ 
	|		И ЗНАЧЕНИЕ(Справочник.СтатьиКалькуляции.ПустаяСсылка) = Аналитика.СтатьяКалькуляции
	//-- НЕ УТ
	|ГДЕ
	|	СправочникНоменклатура.ТипНоменклатуры В (
	|		ЗНАЧЕНИЕ(Перечисление.ТипыНоменклатуры.Товар),
	|		ЗНАЧЕНИЕ(Перечисление.ТипыНоменклатуры.МногооборотнаяТара)
	|	)
	|
	|СГРУППИРОВАТЬ ПО
	|	ЕСТЬNULL(Аналитика.КлючАналитики, ИсходнаяТаблицаДокумента.АналитикаУчетаНоменклатуры),
	|	ИсходнаяТаблицаДокумента.Склад,
	|	ИсходнаяТаблицаДокумента.ДокументРеализации,
	|	ИсходнаяТаблицаДокумента.СпособОпределенияСебестоимости,
	|	ИсходнаяТаблицаДокумента.Номенклатура,
	|	ИсходнаяТаблицаДокумента.Характеристика,
	|	ИсходнаяТаблицаДокумента.Серия,
	|	ИсходнаяТаблицаДокумента.Знак,
	|	СправочникНоменклатура.ВестиУчетПоГТД
	|;
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ
	|	ИсходнаяТаблицаВидыЗапасов.АналитикаУчетаНоменклатуры,
	|	ИсходнаяТаблицаВидыЗапасов.ВидЗапасов,
	|	ИсходнаяТаблицаВидыЗапасов.НомерГТД,
	|	ИсходнаяТаблицаВидыЗапасов.ЦелевоеНалоговоеНазначение,
	|	ИсходнаяТаблицаВидыЗапасов.СтавкаНДС,
	|	ИсходнаяТаблицаВидыЗапасов.Количество,
	|	ИсходнаяТаблицаВидыЗапасов.СуммаСНДС,
	|	ИсходнаяТаблицаВидыЗапасов.СуммаНДС,
	|	(ВЫБОР
	|		КОГДА ИсходнаяТаблицаВидыЗапасов.Количество < 0 ТОГДА -1
	|		ИНАЧЕ 1 КОНЕЦ) КАК Знак,
	|	ВЫБОР 
	|		КОГДА &ОтображатьДокументыРеализации
	|		ТОГДА ИсходнаяТаблицаВидыЗапасов.ДокументРеализации
	|		ИНАЧЕ НЕОПРЕДЕЛЕНО
	|	КОНЕЦ ДокументРеализации,
	|	ИсходнаяТаблицаВидыЗапасов.СпособОпределенияСебестоимости,
	|	ИсходнаяТаблицаВидыЗапасов.СкладОтгрузки
	|
	|ПОМЕСТИТЬ ВтТаблицаВидыЗапасов
	|ИЗ
	|	&ИсходнаяТаблицаВидыЗапасов КАК ИсходнаяТаблицаВидыЗапасов
	|;
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ
	|	ВидыЗапасов.АналитикаУчетаНоменклатуры,
	|	Ключи.МестоХранения КАК Склад,
	|	Ключи.Номенклатура,
	|	Ключи.Характеристика,
	|	Ключи.Серия,
	|	ВидыЗапасов.ВидЗапасов,
	|	ВидыЗапасов.НомерГТД,
	|	ВидыЗапасов.ЦелевоеНалоговоеНазначение,
    |	ВидыЗапасов.СтавкаНДС,
	|	ВидыЗапасов.Знак,
	|	СУММА(ВидыЗапасов.Количество),
	|	СУММА(ВидыЗапасов.СуммаСНДС),
	|	СУММА(ВидыЗапасов.СуммаНДС),
	|	ВидыЗапасов.ДокументРеализации,
	|	ВидыЗапасов.СпособОпределенияСебестоимости,
	|	ВидыЗапасов.СкладОтгрузки
	|
	|ПОМЕСТИТЬ ТаблицаВидыЗапасов
	|ИЗ
	|	ВтТаблицаВидыЗапасов КАК ВидыЗапасов
	|
	|	ВНУТРЕННЕЕ СОЕДИНЕНИЕ
	|		Справочник.КлючиАналитикиУчетаНоменклатуры КАК Ключи
	|	ПО
	|		ВидыЗапасов.АналитикаУчетаНоменклатуры = Ключи.Ссылка
	|
	|СГРУППИРОВАТЬ ПО
	|	ВидыЗапасов.АналитикаУчетаНоменклатуры,
	|	Ключи.МестоХранения,
	|	Ключи.Номенклатура,
	|	Ключи.Характеристика,
	|	Ключи.Серия,
	|	ВидыЗапасов.ВидЗапасов,
	|	ВидыЗапасов.НомерГТД,
    |	ВидыЗапасов.ЦелевоеНалоговоеНазначение,
	|	ВидыЗапасов.СтавкаНДС,
	|	ВидыЗапасов.СпособОпределенияСебестоимости,
	|	ВидыЗапасов.ДокументРеализации,
	|	ВидыЗапасов.СкладОтгрузки,
	|	ВидыЗапасов.Знак
	|
	|ИНДЕКСИРОВАТЬ ПО
	|	Ключи.Номенклатура,
	|	Ключи.Характеристика,
	|	Ключи.Серия
	|;
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ
	|	ТаблицаДокумента.НомерСтроки КАК НомерСтроки,
	|	ТаблицаДокумента.АналитикаУчетаНоменклатуры КАК АналитикаУчетаНоменклатуры,
	|	ТаблицаДокумента.АналитикаУчетаНоменклатуры.Назначение КАК Назначение,
	|	ВЫБОР КОГДА ТаблицаДокумента.Склад = ЗНАЧЕНИЕ(Справочник.Склады.ПустаяСсылка) ТОГДА
	|		&Склад
	|	ИНАЧЕ
	|		ТаблицаДокумента.Склад
	|	КОНЕЦ КАК Склад,
	|	ТаблицаДокумента.Номенклатура КАК Номенклатура,
	|	ТаблицаДокумента.ВестиУчетПоГТД КАК ВедетсяУчетПоГТД,
	|	ТаблицаДокумента.Характеристика КАК Характеристика,
	|	ТаблицаДокумента.Серия КАК Серия,
	|	ТаблицаДокумента.Количество КАК Количество,
	|	ТаблицаДокумента.СуммаСНДС КАК СуммаСНДС,
	|	ТаблицаДокумента.СуммаНДС КАК СуммаНДС,
	|	ТаблицаДокумента.СтавкаНДС КАК СтавкаНДС,
	|
	|	ТаблицаВидыЗапасов.ВидЗапасов КАК ВидЗапасов,
	|	ТаблицаВидыЗапасов.НомерГТД КАК НомерГТД,
    |	ТаблицаВидыЗапасов.ЦелевоеНалоговоеНазначение,
	|	ЕСТЬNULL(ТаблицаВидыЗапасов.Количество, 0) КАК КоличествоВидыЗапасов,
	|	ЕСТЬNULL(ТаблицаВидыЗапасов.СуммаСНДС, 0) КАК СуммаСНДСВидыЗапасов,
	|	ЕСТЬNULL(ТаблицаВидыЗапасов.СуммаНДС, 0) КАК СуммаНДСВидыЗапасов,
	|	ЕСТЬNULL(ТаблицаВидыЗапасов.СтавкаНДС, Неопределено) КАК СтавкаНДСВидыЗапасов,
	|
	|	ВЫБОР КОГДА ВидыЗапасов.РеализацияЗапасовДругойОрганизации ТОГДА
	|		ВидыЗапасов.ВидЗапасовВладельца.ТипЗапасов
	|	ИНАЧЕ
	|		ВидыЗапасов.ТипЗапасов
	|	КОНЕЦ КАК ТипЗапасов,
	|
	|	ВЫБОР КОГДА ВидыЗапасов.РеализацияЗапасовДругойОрганизации ТОГДА
	|		ВидыЗапасов.ВидЗапасовВладельца.Организация
	|	ИНАЧЕ
	|		ВидыЗапасов.Организация
	|	КОНЕЦ КАК Организация,
	|
	|	ВЫБОР КОГДА ВидыЗапасов.РеализацияЗапасовДругойОрганизации ТОГДА
	|		ВидыЗапасов.ВидЗапасовВладельца.ВладелецТовара
	|	ИНАЧЕ
	|		ВидыЗапасов.ВладелецТовара
	|	КОНЕЦ КАК ВладелецТовара,
	|
	|	ТаблицаВидыЗапасов.ДокументРеализации КАК ДокументРеализации,
	|	ТаблицаВидыЗапасов.СпособОпределенияСебестоимости КАК СпособОпределенияСебестоимости,
	|	ТаблицаВидыЗапасов.СкладОтгрузки КАК СкладОтгрузки
	|ИЗ
	|	ТаблицаДокумента КАК ТаблицаДокумента
	|	
	|	ЛЕВОЕ СОЕДИНЕНИЕ
	|		ТаблицаВидыЗапасов КАК ТаблицаВидыЗапасов
	|	ПО
	|		ТаблицаДокумента.АналитикаУчетаНоменклатуры = ТаблицаВидыЗапасов.АналитикаУчетаНоменклатуры
	|		И ТаблицаДокумента.СпособОпределенияСебестоимости = ТаблицаВидыЗапасов.СпособОпределенияСебестоимости
	|		И ТаблицаДокумента.Знак = ТаблицаВидыЗапасов.Знак
	|		И (ТаблицаДокумента.Склад = ЗНАЧЕНИЕ(Справочник.Склады.ПустаяСсылка)
	|			ИЛИ ТаблицаДокумента.Склад = ТаблицаВидыЗапасов.Склад)
	|		И (ТаблицаДокумента.ДокументРеализации = ТаблицаВидыЗапасов.ДокументРеализации
	|			ИЛИ (&ОтображатьДокументыРеализации И (
	|				ТаблицаДокумента.ДокументРеализации = НЕОПРЕДЕЛЕНО
	|				ИЛИ ТаблицаДокумента.ДокументРеализации = ЗНАЧЕНИЕ(Документ.РеализацияТоваровУслуг.ПустаяСсылка)
	|				ИЛИ ТаблицаДокумента.ДокументРеализации = ЗНАЧЕНИЕ(Документ.ОтчетОРозничныхПродажах.ПустаяСсылка)
	|			))
	|		)
	|	
	|	ЛЕВОЕ СОЕДИНЕНИЕ
	|		Справочник.ВидыЗапасов КАК ВидыЗапасов
	|	ПО
	|		ТаблицаВидыЗапасов.ВидЗапасов = ВидыЗапасов.Ссылка
	|
	|ОБЪЕДИНИТЬ ВСЕ
	|
	|ВЫБРАТЬ
	|	0 КАК НомерСтроки,
	|	ТаблицаВидыЗапасов.АналитикаУчетаНоменклатуры КАК АналитикаУчетаНоменклатуры,
	|	Аналитика.Назначение КАК Назначение,
	|	Аналитика.МестоХранения КАК Склад,
	|	Аналитика.Номенклатура КАК Номенклатура,
	|	Аналитика.Номенклатура.ВестиУчетПоГТД КАК ВедетсяУчетПоГТД,
	|	Аналитика.Характеристика КАК Характеристика,
	|	Аналитика.Серия КАК Серия,
	|	0 КАК Количество,
	|	0 КАК СуммаСНДС,
	|	0 КАК СуммаНДС,
	|	ТаблицаВидыЗапасов.СтавкаНДС КАК СтавкаНДС,
	|
	|	ТаблицаВидыЗапасов.ВидЗапасов КАК ВидЗапасов,
	|	ТаблицаВидыЗапасов.НомерГТД КАК НомерГТД,
    |	ТаблицаВидыЗапасов.ЦелевоеНалоговоеНазначение,
	|	ТаблицаВидыЗапасов.Количество КАК КоличествоВидыЗапасов,
	|	ТаблицаВидыЗапасов.СуммаСНДС КАК СуммаСНДСВидыЗапасов,
	|	ТаблицаВидыЗапасов.СуммаНДС КАК СуммаНДСВидыЗапасов,
	|	ТаблицаВидыЗапасов.СтавкаНДС КАК СтавкаНДСВидыЗапасов,
	|
	|	ВЫБОР КОГДА ВидыЗапасов.РеализацияЗапасовДругойОрганизации ТОГДА
	|		ВидыЗапасов.ВидЗапасовВладельца.ТипЗапасов
	|	ИНАЧЕ
	|		ВидыЗапасов.ТипЗапасов
	|	КОНЕЦ КАК ТипЗапасов,
	|
	|	ВЫБОР КОГДА ВидыЗапасов.РеализацияЗапасовДругойОрганизации ТОГДА
	|		ВидыЗапасов.ВидЗапасовВладельца.Организация
	|	ИНАЧЕ
	|		ВидыЗапасов.Организация
	|	КОНЕЦ КАК Организация,
	|
	|	ВЫБОР КОГДА ВидыЗапасов.РеализацияЗапасовДругойОрганизации ТОГДА
	|		ВидыЗапасов.ВидЗапасовВладельца.ВладелецТовара
	|	ИНАЧЕ
	|		ВидыЗапасов.ВладелецТовара
	|	КОНЕЦ КАК ВладелецТовара,
	|
	|	ТаблицаВидыЗапасов.ДокументРеализации КАК ДокументРеализации,
	|	ТаблицаВидыЗапасов.СпособОпределенияСебестоимости КАК СпособОпределенияСебестоимости,
	|	ТаблицаВидыЗапасов.СкладОтгрузки КАК СкладОтгрузки
	|
	|ИЗ
	|	ТаблицаВидыЗапасов КАК ТаблицаВидыЗапасов
	|	
	|	ЛЕВОЕ СОЕДИНЕНИЕ
	|		Справочник.КлючиАналитикиУчетаНоменклатуры КАК Аналитика
	|	ПО
	|		ТаблицаВидыЗапасов.АналитикаУчетаНоменклатуры = Аналитика.Ссылка
	|	
	|	ЛЕВОЕ СОЕДИНЕНИЕ
	|		ТаблицаДокумента КАК ТаблицаДокумента
	|	ПО
	|		ТаблицаДокумента.АналитикаУчетаНоменклатуры = ТаблицаВидыЗапасов.АналитикаУчетаНоменклатуры
	|		И ТаблицаДокумента.Знак = ТаблицаВидыЗапасов.Знак
	|		И (ТаблицаДокумента.Склад = ЗНАЧЕНИЕ(Справочник.Склады.ПустаяСсылка)
	|			ИЛИ ТаблицаДокумента.Склад = Аналитика.МестоХранения)
	|		И (ТаблицаДокумента.ДокументРеализации = ТаблицаВидыЗапасов.ДокументРеализации
	|			ИЛИ (&ОтображатьДокументыРеализации И (
	|				ТаблицаДокумента.ДокументРеализации = НЕОПРЕДЕЛЕНО
	|				ИЛИ ТаблицаДокумента.ДокументРеализации = ЗНАЧЕНИЕ(Документ.РеализацияТоваровУслуг.ПустаяСсылка)
	|				ИЛИ ТаблицаДокумента.ДокументРеализации = ЗНАЧЕНИЕ(Документ.ОтчетОРозничныхПродажах.ПустаяСсылка)
	|			))
	|		)
	|
	|	ЛЕВОЕ СОЕДИНЕНИЕ
	|		Справочник.ВидыЗапасов КАК ВидыЗапасов
	|	ПО
	|		ТаблицаВидыЗапасов.ВидЗапасов = ВидыЗапасов.Ссылка
	|ГДЕ
	|	ТаблицаДокумента.Номенклатура ЕСТЬ NULL
	|
	|УПОРЯДОЧИТЬ ПО
	|	НомерСтроки
	|
	|ИТОГИ
	|	СУММА(Количество),
	|	СУММА(СуммаСНДС),
	|	СУММА(СуммаНДС),
	|	МАКСИМУМ(СтавкаНДС),
	|	СУММА(КоличествоВидыЗапасов),
	|	СУММА(СуммаСНДСВидыЗапасов),
	|	СУММА(СуммаНДСВидыЗапасов),
	|	МАКСИМУМ(СтавкаНДСВидыЗапасов)
	|ПО
	|	НомерСтроки
	|");
	Запрос.УстановитьПараметр("ЦенаНеВключаетНДС", ?(ЦенаВключаетНДС, 0, 1));
	Запрос.УстановитьПараметр("ОтображатьДокументыРеализации", ОтображатьДокументыРеализации);
	Запрос.УстановитьПараметр("Склад", Склад);

	ТаблицаТоваров = ПолучитьИзВременногоХранилища(АдресТоваровВХранилище);  // ТаблицаЗначений
	
	КолонкаНомерСтроки = ТаблицаТоваров.Колонки.Найти("LineNumber");
	Если КолонкаНомерСтроки <> Неопределено Тогда
		КолонкаНомерСтроки.Имя = "НомерСтроки";
	КонецЕсли;
	
	ЕстьСумма = (ТаблицаТоваров.Колонки.Найти("Сумма") <> Неопределено);
	Если Не ЕстьСумма Тогда
		ТаблицаТоваров.Колонки.Добавить("Сумма", Новый ОписаниеТипов("Число"));
	КонецЕсли;
	
	ЕстьСуммаНДС = (ТаблицаТоваров.Колонки.Найти("СуммаНДС") <> Неопределено);
	Если Не ЕстьСуммаНДС Тогда
		ТаблицаТоваров.Колонки.Добавить("СуммаНДС", Новый ОписаниеТипов("Число"));
		ТаблицаТоваров.Колонки.Добавить("СтавкаНДС", Новый ОписаниеТипов("СправочникСсылка.СтавкиНДС"));
	КонецЕсли;
	
	ЕстьСуммаПродажи = (ТаблицаТоваров.Колонки.Найти("СуммаПродажи") <> Неопределено);
	Если Не ЕстьСуммаПродажи Тогда
		ТаблицаТоваров.Колонки.Добавить("СуммаПродажи", Новый ОписаниеТипов("Число"));
	КонецЕсли;
	
	ЕстьСклад = (ТаблицаТоваров.Колонки.Найти("Склад") <> Неопределено);
	Если Не ЕстьСклад Тогда
		ТаблицаТоваров.Колонки.Добавить("Склад", Новый ОписаниеТипов("СправочникСсылка.Склады"));
	КонецЕсли;
	
	ЕстьДокументРеализации = (ТаблицаТоваров.Колонки.Найти("ДокументРеализации") <> Неопределено);
	Если Не ЕстьДокументРеализации Тогда
		ТаблицаТоваров.Колонки.Добавить("ДокументРеализации", Документы.ТипВсеСсылки());
	КонецЕсли;
	
	ЕстьСерия = (ТаблицаТоваров.Колонки.Найти("Серия") <> Неопределено);
	Если Не ЕстьСерия Тогда
		ТаблицаТоваров.Колонки.Добавить("Серия", Новый ОписаниеТипов("СправочникСсылка.СерииНоменклатуры"));
	КонецЕсли;
	
	ЕстьНазначение = (ТаблицаТоваров.Колонки.Найти("Назначение") <> Неопределено);
	Если Не ЕстьНазначение Тогда
		ТаблицаТоваров.Колонки.Добавить("Назначение", Новый ОписаниеТипов("СправочникСсылка.Назначения"));
	КонецЕсли;
	
	ЕстьСпособОпределенияСебестоимости = (ТаблицаТоваров.Колонки.Найти("СпособОпределенияСебестоимости") <> Неопределено);
	Если Не ЕстьСпособОпределенияСебестоимости Тогда
		ТаблицаТоваров.Колонки.Добавить("СпособОпределенияСебестоимости", Новый ОписаниеТипов("ПеречислениеСсылка.СпособыОпределенияСебестоимости"));
	КонецЕсли;
	
	Запрос.УстановитьПараметр("ИсходнаяТаблицаДокумента", ТаблицаТоваров);
	
	
	
	ТаблицаВидыЗапасов = ПолучитьИзВременногоХранилища(АдресВидовЗапасовВХранилище); // ТаблицаЗначений
	
	ЕстьСуммаНДС = (ТаблицаВидыЗапасов.Колонки.Найти("СуммаНДС") <> Неопределено);
	Если Не ЕстьСуммаНДС Тогда
		ТаблицаВидыЗапасов.Колонки.Добавить("СуммаНДС",  Новый ОписаниеТипов("Число"));
		ТаблицаВидыЗапасов.Колонки.Добавить("СтавкаНДС", Новый ОписаниеТипов("СправочникСсылка.СтавкиНДС"));
	КонецЕсли;
	
	ЕстьСуммаСНДС = (ТаблицаВидыЗапасов.Колонки.Найти("СуммаСНДС") <> Неопределено);
	Если Не ЕстьСуммаСНДС Тогда
		ТаблицаВидыЗапасов.Колонки.Добавить("СуммаСНДС",  Новый ОписаниеТипов("Число"));
    КонецЕсли;
    
    ЕстьЦелевоеНалоговоеНазначение = (ТаблицаВидыЗапасов.Колонки.Найти("ЦелевоеНалоговоеНазначение") <> Неопределено);
    Если Не ЕстьЦелевоеНалоговоеНазначение Тогда
    	ТаблицаВидыЗапасов.Колонки.Добавить("ЦелевоеНалоговоеНазначение", Новый ОписаниеТипов("СправочникСсылка.НалоговыеНазначенияАктивовИЗатрат"));
    КонецЕсли;
	
	ЕстьСкладОтгрузки = (ТаблицаВидыЗапасов.Колонки.Найти("СкладОтгрузки") <> Неопределено);
	Если Не ЕстьСкладОтгрузки Тогда
		ТаблицаВидыЗапасов.Колонки.Добавить("СкладОтгрузки", Новый ОписаниеТипов("СправочникСсылка.Склады"));
	КонецЕсли;
	
	ЕстьДокументРеализации = (ТаблицаВидыЗапасов.Колонки.Найти("ДокументРеализации") <> Неопределено);
	Если Не ЕстьДокументРеализации Тогда
		ТаблицаВидыЗапасов.Колонки.Добавить("ДокументРеализации", Документы.ТипВсеСсылки());
	КонецЕсли;
	
	ЕстьНомерГТД = (ТаблицаВидыЗапасов.Колонки.Найти("НомерГТД") <> Неопределено);
	Если Не ЕстьНомерГТД Тогда
		ТаблицаВидыЗапасов.Колонки.Добавить("НомерГТД", Новый ОписаниеТипов("СправочникСсылка.НоменклатураГТД"));
	КонецЕсли;
	
	ЕстьСпособОпределенияСебестоимости = (ТаблицаВидыЗапасов.Колонки.Найти("СпособОпределенияСебестоимости") <> Неопределено);
	Если Не ЕстьСпособОпределенияСебестоимости Тогда
		ТаблицаВидыЗапасов.Колонки.Добавить("СпособОпределенияСебестоимости", Новый ОписаниеТипов("ПеречислениеСсылка.СпособыОпределенияСебестоимости"));
	КонецЕсли;
	
	Запрос.УстановитьПараметр("ИсходнаяТаблицаВидыЗапасов", ТаблицаВидыЗапасов);
	
	Дерево = РеквизитФормыВЗначение("ДеревоВидовЗапасов");
	Дерево.Строки.Очистить();
	
	РезультатЗапроса = Запрос.Выполнить();
	Если РезультатЗапроса.Пустой() Тогда
		РедактироватьВидыЗапасов = Ложь;
	Иначе
		ВыборкаПоСтрокам = РезультатЗапроса.Выбрать(ОбходРезультатаЗапроса.ПоГруппировкам);
		Пока ВыборкаПоСтрокам.Следующий() Цикл
			
			ДобавитьСтрокуНоменклатуры = Истина;
			
			Выборка = ВыборкаПоСтрокам.Выбрать();
			КоличествоЗаписей = Выборка.Количество();
			
			Если КоличествоЗаписей > 1
			 ИЛИ ВидыЗапасовУказаныВручную
			 ИЛИ ВыборкаПоСтрокам.Количество = 0 Тогда
				ДобавлятьПодчиненныеСтроки = Истина;
				
			ИначеЕсли ВыборкаПоСтрокам.Количество <> ВыборкаПоСтрокам.КоличествоВидыЗапасов
			 ИЛИ ВыборкаПоСтрокам.СуммаСНДС <> ВыборкаПоСтрокам.СуммаСНДСВидыЗапасов
			 ИЛИ ВыборкаПоСтрокам.СуммаНДС <> ВыборкаПоСтрокам.СуммаНДСВидыЗапасов
			 ИЛИ ВыборкаПоСтрокам.СтавкаНДС <> ВыборкаПоСтрокам.СтавкаНДСВидыЗапасов Тогда
				ДобавлятьПодчиненныеСтроки = Истина;
				
			Иначе
				ДобавлятьПодчиненныеСтроки = Ложь;
			КонецЕсли;
			
			Пока Выборка.Следующий() Цикл
				
				Если ДобавитьСтрокуНоменклатуры Тогда
			
					СтрокаГруппы = Дерево.Строки.Добавить();
					ЗаполнитьЗначенияСвойств(СтрокаГруппы, Выборка);
					
					Если ДобавлятьПодчиненныеСтроки Тогда
						СтрокаГруппы.ВидЗапасов = Неопределено;
						СтрокаГруппы.НомерГТД = Неопределено;
                        СтрокаГруппы.ЦелевоеНалоговоеНазначение = Неопределено;
						СтрокаГруппы.ТипЗапасов = Неопределено;
						СтрокаГруппы.ВладелецТовара = Неопределено;
						СтрокаГруппы.Организация = Неопределено;
						СтрокаГруппы.СкладОтгрузки = Неопределено;
						СтрокаГруппы.КоличествоВидыЗапасов = 0;
						СтрокаГруппы.СуммаСНДСВидыЗапасов = 0;
						СтрокаГруппы.СуммаНДСВидыЗапасов = 0;
						СтрокаГруппы.СпособОпределенияСебестоимости = Неопределено;
					КонецЕсли;
					
					ДобавитьСтрокуНоменклатуры = Ложь;
				
				КонецЕсли;
			
				Если Выборка.КоличествоВидыЗапасов <> 0 И ДобавлятьПодчиненныеСтроки Тогда
					
					СтрокаВидыЗапасов = СтрокаГруппы.Строки.Добавить();
					СтрокаВидыЗапасов.НоменклатураВидыЗапасов = Выборка.Номенклатура;
					СтрокаВидыЗапасов.ХарактеристикаВидыЗапасов = Выборка.Характеристика;
					СтрокаВидыЗапасов.ВидЗапасов = Выборка.ВидЗапасов;
					СтрокаВидыЗапасов.ТипЗапасов = Выборка.ТипЗапасов;
					СтрокаВидыЗапасов.ВладелецТовара = Выборка.ВладелецТовара;
					СтрокаВидыЗапасов.Организация = Выборка.Организация;
					СтрокаВидыЗапасов.ВедетсяУчетПоГТД = Выборка.ВедетсяУчетПоГТД;
					СтрокаВидыЗапасов.НомерГТД = Выборка.НомерГТД;
                    СтрокаВидыЗапасов.ЦелевоеНалоговоеНазначение = Выборка.ЦелевоеНалоговоеНазначение;
					СтрокаВидыЗапасов.ДокументРеализации = Выборка.ДокументРеализации;
					СтрокаВидыЗапасов.СпособОпределенияСебестоимости = Выборка.СпособОпределенияСебестоимости;
					СтрокаВидыЗапасов.СкладОтгрузки = Выборка.СкладОтгрузки;
					СтрокаВидыЗапасов.Количество = Выборка.КоличествоВидыЗапасов;
					СтрокаВидыЗапасов.СуммаСНДС = Выборка.СуммаСНДСВидыЗапасов;
					СтрокаВидыЗапасов.СуммаНДС = Выборка.СуммаНДСВидыЗапасов;
					СтрокаВидыЗапасов.СтавкаНДС = Выборка.СтавкаНДСВидыЗапасов;
					
					СтрокаГруппы.КоличествоВидыЗапасов = СтрокаГруппы.КоличествоВидыЗапасов + Выборка.КоличествоВидыЗапасов;
					СтрокаГруппы.СуммаСНДСВидыЗапасов = СтрокаГруппы.СуммаСНДСВидыЗапасов + Выборка.СуммаСНДСВидыЗапасов;
					СтрокаГруппы.СуммаНДСВидыЗапасов = СтрокаГруппы.СуммаНДСВидыЗапасов + Выборка.СуммаНДСВидыЗапасов;
					
					Если СтрокаГруппы.Количество > СтрокаГруппы.КоличествоВидыЗапасов Тогда
						СтрокаГруппы.Информация = "Недостаточно: " + Формат(СтрокаГруппы.Количество - СтрокаГруппы.КоличествоВидыЗапасов, "ЧДЦ=3");
					ИначеЕсли СтрокаГруппы.Количество < СтрокаГруппы.КоличествоВидыЗапасов Тогда
						СтрокаГруппы.Информация = "Превышение: " + Формат(СтрокаГруппы.КоличествоВидыЗапасов - СтрокаГруппы.Количество, "ЧДЦ=3");
					Иначе
						СтрокаГруппы.Информация = "";
					КонецЕсли;
					
				КонецЕсли;
			
			КонецЦикла;
			
		КонецЦикла;
		
		ЗначениеВРеквизитФормы(Дерево, "ДеревоВидовЗапасов");
	КонецЕсли;
	
	Если Не ВидимостьУстановлена Тогда
		ИспользуетсяСкладОтгрузки = ЕстьСкладОтгрузки;
        Элементы.ДеревоВидовЗапасовСуммаСНДС.Видимость = (ЕстьСумма ИЛИ ЕстьСуммаПродажи ИЛИ ЕстьСуммаСНДС);
		Элементы.ДеревоВидовЗапасовСтавкаНДС.Видимость = ЕстьСуммаНДС;
        Элементы.ДеревоВидовЗапасовЦелевоеНалоговоеНазначение.Видимость  = ЕстьЦелевоеНалоговоеНазначение;
		Элементы.ДеревоВидовЗапасовСуммаНДС.Видимость  = ЕстьСуммаНДС;
		Элементы.Склад.Видимость = ЕстьСклад;
		Элементы.ДеревоВидовЗапасовСкладОтгрузки.Видимость = ЕстьСкладОтгрузки;
		ВидимостьУстановлена = Истина;
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ЗаполнитьПолеИнформации(СтрокаТаблицы)
	
	Если СтрокаТаблицы.Количество > СтрокаТаблицы.КоличествоВидыЗапасов Тогда
		СтрокаТаблицы.Информация = "Недостаточно: " + Формат(СтрокаТаблицы.Количество - СтрокаТаблицы.КоличествоВидыЗапасов, "ЧДЦ=3");
	ИначеЕсли СтрокаТаблицы.Количество < СтрокаТаблицы.КоличествоВидыЗапасов Тогда
		СтрокаТаблицы.Информация = "Превышение: " + Формат(СтрокаТаблицы.КоличествоВидыЗапасов - СтрокаТаблицы.Количество, "ЧДЦ=3");
	Иначе
		СтрокаТаблицы.Информация = "";
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#КонецОбласти
