
#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	Если Параметры.Свойство("АвтоТест") Тогда // Возврат при получении формы для анализа.
		Возврат;
	КонецЕсли;

	Если Параметры.Свойство("Отбор")
		И Параметры.Отбор.Свойство("ТипТранспортногоСредства")
		И ЗначениеЗаполнено(Параметры.Отбор.ТипТранспортногоСредства) Тогда
		
		ЗагрузитьНастройки();
		
		ТипТранспортногоСредства = Параметры.Отбор.ТипТранспортногоСредства;
		
		ТекстЗаголовка = НСтр("ru='По типу ""%Тип%""';uk='За типом ""%Тип%""'");
		ТекстЗаголовка = СтрЗаменить(ТекстЗаголовка, "%Тип%", ТипТранспортногоСредства);
		Элементы.ПоТипуТранспортногоСредства.Заголовок = ТекстЗаголовка;
		
		Если ПолучитьКоличествоТранспортаПоТипу(ТипТранспортногоСредства) = 0 Тогда
			ПоТипуТранспортногоСредства = Ложь;
		КонецЕсли;
		
		Параметры.Отбор.Удалить("ТипТранспортногоСредства");
		Если ПоТипуТранспортногоСредства Тогда
			УстановитьОтборТипТранспортногоСредстваСервер();
		КонецЕсли;
	Иначе
		ТипТранспортногоСредства = Справочники.ТипыТранспортныхСредств.ПустаяСсылка();
		Элементы.ПоТипуТранспортногоСредства.Видимость = Ложь;
	КонецЕсли;

	СобытияФорм.ПриСозданииНаСервере(ЭтаФорма, Отказ, СтандартнаяОбработка);

КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовШапкиФормы

&НаКлиенте
Процедура ПоТипуТранспортногоСредстваПриИзменении(Элемент)
	
	Если ПоТипуТранспортногоСредства Тогда
		УстановитьОтборТипТранспортногоСредства();
	Иначе
		ОбщегоНазначенияУТКлиентСервер.ПолучитьОтборДинамическогоСписка(Список).Элементы.Очистить();
	КонецЕсли;
	
	СохранитьНастройки();
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура Подключаемый_ВыполнитьПереопределяемуюКоманду(Команда)
	
	СобытияФормКлиент.ВыполнитьПереопределяемуюКоманду(ЭтаФорма, Команда);
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаСервере
Функция ПолучитьКоличествоТранспортаПоТипу(ТипТранспортногоСредства)
	
	Запрос = Новый Запрос;
	Запрос.Текст = 
		"ВЫБРАТЬ
		|	ЕСТЬNULL(влТаб.Количество, 0) КАК Количество
		|ИЗ
		|	(ВЫБРАТЬ
		|		СУММА(1) КАК Количество
		|	ИЗ
		|		Справочник.ТранспортныеСредства КАК ТранспортныеСредства
		|	ГДЕ
		|		ТранспортныеСредства.Тип = &Тип) КАК влТаб";

	Запрос.УстановитьПараметр("Тип", ТипТранспортногоСредства);

	Возврат Запрос.Выполнить().Выгрузить()[0].Количество;
	
КонецФункции

&НаСервере
Процедура ЗагрузитьНастройки()
	
	ЗначениеНастроек = ОбщегоНазначения.ХранилищеОбщихНастроекЗагрузить("Справочники.ТранспортныеСредства", "");
	Если ТипЗнч(ЗначениеНастроек) = Тип("Соответствие") Тогда
		ПоТипуТранспортногоСредства = ЗначениеНастроек.Получить("ПоТипуТранспортногоСредства");
	Иначе
		ПоТипуТранспортногоСредства = Истина;
	КонецЕсли;
	
КонецПроцедуры

&НаСервере
Процедура СохранитьНастройки()

	Перем Настройки;
	
	Настройки = Новый Соответствие;
	Настройки.Вставить("ПоТипуТранспортногоСредства",ПоТипуТранспортногоСредства);
	
	ОбщегоНазначения.ХранилищеОбщихНастроекСохранить("Справочники.ТранспортныеСредства", "",Настройки);

КонецПроцедуры

&НаКлиенте
Процедура УстановитьОтборТипТранспортногоСредства()
	
	ОбщегоНазначенияКлиентСервер.УстановитьЭлементОтбораДинамическогоСписка(Список, "Тип", ТипТранспортногоСредства, ВидСравненияКомпоновкиДанных.Равно,,Истина);
	
КонецПроцедуры

&НаСервере
Процедура УстановитьОтборТипТранспортногоСредстваСервер()
	
	ОбщегоНазначенияКлиентСервер.УстановитьЭлементОтбораДинамическогоСписка(Список, "Тип", ТипТранспортногоСредства, ВидСравненияКомпоновкиДанных.Равно,,Истина);
	
КонецПроцедуры

#КонецОбласти