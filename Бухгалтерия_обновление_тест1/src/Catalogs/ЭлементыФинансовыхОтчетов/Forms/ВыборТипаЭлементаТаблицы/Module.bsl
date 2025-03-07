
#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	Если Параметры.Свойство("АвтоТест") Тогда
		Возврат;
	КонецЕсли;
	
	Если Не Параметры.Свойство("ИспользоватьДляВводаПлана", ИспользоватьДляВводаПлана) Тогда
		ТекстСообщения = НСтр("ru='Непосредственное открытие этой формы не предусмотрено. Открытие данной формы выполняется при начале выбора вида ячейки в форме ""Настройка ячеек"" справочника ""Элементы финансовых отчетов"".';uk='Безпосереднє відкриття цієї форми не передбачено. Відкриття  форми виконується при початку вибору виду комірки в формі ""Настройка комірок"" довідника ""Елементи фінансових звітів"".'");
		ВызватьИсключение ТекстСообщения;
	КонецЕсли;
	
	ОбновитьДеревоНовыхЭлементовВидаБюджета();

	СобытияФорм.ПриСозданииНаСервере(ЭтаФорма, Отказ, СтандартнаяОбработка);

КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)
	
	Для Каждого Строка Из ДеревоНовыхЭлементов.ПолучитьЭлементы() Цикл
		Элементы.ЭлементыВидаБюджета.Свернуть(Строка.ПолучитьИдентификатор());
		Элементы.ЭлементыВидаБюджета.Развернуть(Строка.ПолучитьИдентификатор(), Ложь);
	КонецЦикла;
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовШапкиФормы

&НаКлиенте
Процедура БыстрыйПоискНовыхПриИзменении(Элемент)
	
	ОбновитьДеревоНовыхЭлементовВидаБюджета();
	
	Для Каждого Строка Из ДеревоНовыхЭлементов.ПолучитьЭлементы() Цикл
		Элементы.ЭлементыВидаБюджета.Свернуть(Строка.ПолучитьИдентификатор());
		Элементы.ЭлементыВидаБюджета.Развернуть(Строка.ПолучитьИдентификатор(), Ложь);
	КонецЦикла;
	
КонецПроцедуры

&НаКлиенте
Процедура БыстрыйПоискНовыхОчистка(Элемент, СтандартнаяОбработка)
	
	ОбновитьДеревоНовыхЭлементовВидаБюджета();
	
	Для Каждого Строка Из ДеревоНовыхЭлементов.ПолучитьЭлементы() Цикл
		Элементы.ЭлементыВидаБюджета.Свернуть(Строка.ПолучитьИдентификатор());
		Элементы.ЭлементыВидаБюджета.Развернуть(Строка.ПолучитьИдентификатор(), Ложь);
	КонецЦикла;
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийТаблицыФормы

&НаКлиенте
Процедура ЭлементыВидаБюджетаВыбор(Элемент, ВыбраннаяСтрока, Поле, СтандартнаяОбработка)
	
	СтандартнаяОбработка = Ложь;
	Выбрать(Неопределено);
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура НайтиНовыйЭлемент(Команда)
	
	ОбновитьДеревоНовыхЭлементовВидаБюджета();
	
	Для Каждого Строка Из ДеревоНовыхЭлементов.ПолучитьЭлементы() Цикл
		Элементы.ЭлементыВидаБюджета.Свернуть(Строка.ПолучитьИдентификатор());
		Элементы.ЭлементыВидаБюджета.Развернуть(Строка.ПолучитьИдентификатор(), Ложь);
	КонецЦикла;
	
КонецПроцедуры

&НаКлиенте
Процедура Выбрать(Команда)
	
	ТекущиеДанные = Элементы.ЭлементыВидаБюджета.ТекущиеДанные;
	Если Не ЗначениеЗаполнено(ТекущиеДанные.ВидЭлемента) Тогда
		ПоказатьПредупреждение(Неопределено, НСтр("ru='Элемент не может быть выбран!';uk='Елемент не може бути вибраний!'"));
		Возврат;
	КонецЕсли;
	
	Результат = Новый Структура;
	Результат.Вставить("ВидЭлемента", ТекущиеДанные.ВидЭлемента);
	Результат.Вставить("ЭлементОтчета", ТекущиеДанные.ЭлементВидаОтчетности);
	Результат.Вставить("НаименованиеДляПечати", ТекущиеДанные.Наименование);
	
	Закрыть(Результат);
	
КонецПроцедуры

&НаКлиенте
Процедура Подключаемый_ВыполнитьПереопределяемуюКоманду(Команда)
	
	СобытияФормКлиент.ВыполнитьПереопределяемуюКоманду(ЭтаФорма, Команда);
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаСервере 
Процедура ОбновитьДеревоНовыхЭлементовВидаБюджета()
	
	ПараметрыДерева = Новый Структура;
	
	ПараметрыДерева.Вставить("ИмяЭлементаДерева", "ДеревоНовыхЭлементов");
	ПараметрыДерева.Вставить("БыстрыйПоиск", БыстрыйПоискНовых);
	ПараметрыДерева.Вставить("ИспользоватьДляВводаПлана", ИспользоватьДляВводаПлана);
	ПараметрыДерева.Вставить("РежимДерева", Перечисления.РежимыОтображенияДереваНовыхЭлементов.ВыборВидаЯчейкиСложнойТаблицы);
	
	БюджетнаяОтчетностьВызовСервера.ОбновитьДеревоНовыхЭлементов(ЭтаФорма, ПараметрыДерева);
	
КонецПроцедуры

#КонецОбласти
