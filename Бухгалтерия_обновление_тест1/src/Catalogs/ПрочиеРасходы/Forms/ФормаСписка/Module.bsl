
#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	Если Параметры.Свойство("АвтоТест") Тогда // Возврат при получении формы для анализа.
		Возврат;
	КонецЕсли;

	УстановитьПараметрыДинамическогоСписка();

	// СтандартныеПодсистемы.ПодключаемыеКоманды
	СписокТипов = СписокСтатейРасходов.КомпоновщикНастроек.Настройки.Выбор.ДоступныеПоляВыбора.НайтиПоле(Новый ПолеКомпоновкиДанных("Ссылка")).Тип;
	ПараметрыРазмещения = ПодключаемыеКоманды.ПараметрыРазмещения();
	ПараметрыРазмещения.Источники = СписокТипов;
	ПараметрыРазмещения.КоманднаяПанель = Элементы.СписокСтатейРасходовКоманднаяПанель;
	
	ПодключаемыеКоманды.ПриСозданииНаСервере(ЭтотОбъект, ПараметрыРазмещения);
	// Конец СтандартныеПодсистемы.ПодключаемыеКоманды
	
	СобытияФорм.ПриСозданииНаСервере(ЭтаФорма, Отказ, СтандартнаяОбработка);

КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовШапкиФормы

&НаКлиенте
Процедура СписокПередНачаломДобавления(Элемент, Отказ, Копирование, Родитель, Группа)
	
	ВыделенныеСтроки = Элементы.СписокСтатейРасходов.ВыделенныеСтроки;
	Если ВыделенныеСтроки.Количество() > 0 Тогда
		СтатьяРасходов = ВыделенныеСтроки[0];
		Если НЕ ЗначениеЗаполнено(СтатьяРасходов) ИЛИ ЭтоГруппаСтатейРасходов(СтатьяРасходов) Тогда
			Отказ = Истина;
		КонецЕсли; 
	Иначе
		Отказ = Истина;
	КонецЕсли;
	
	Если Отказ Тогда
		ПоказатьПредупреждение(Неопределено, НСтр("ru='Команда не может быть выполнена для указанного объекта!';uk='Команда не може бути виконана для зазначеного об''єкта!'"));
	КонецЕсли; 
	
КонецПроцедуры

&НаКлиенте
Процедура СписокСтатейРасходовПриАктивизацииСтроки(Элемент)
	
	УстановитьПараметрыДинамическогоСписка();
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура Подключаемый_ВыполнитьПереопределяемуюКоманду(Команда)
	
	СобытияФормКлиент.ВыполнитьПереопределяемуюКоманду(ЭтаФорма, Команда);
	
КонецПроцедуры

// СтандартныеПодсистемы.ПодключаемыеКоманды
&НаКлиенте
Процедура Подключаемый_ВыполнитьКоманду(Команда)
	ПодключаемыеКомандыКлиент.ВыполнитьКоманду(ЭтотОбъект, Команда, Элементы.СписокСтатейРасходов);
КонецПроцедуры

&НаСервере
Процедура Подключаемый_ВыполнитьКомандуНаСервере(Контекст, Результат) Экспорт
	ПодключаемыеКоманды.ВыполнитьКоманду(ЭтотОбъект, Контекст, Элементы.СписокСтатейРасходов, Результат);
КонецПроцедуры

&НаКлиенте
Процедура Подключаемый_ОбновитьКоманды()
	ПодключаемыеКомандыКлиентСервер.ОбновитьКоманды(ЭтотОбъект, Элементы.СписокСтатейРасходов);
КонецПроцедуры
// Конец СтандартныеПодсистемы.ПодключаемыеКоманды

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

#Область Прочее

&НаСервере
Процедура УстановитьПараметрыДинамическогоСписка()
	
	ВыделенныеСтроки = Элементы.СписокСтатейРасходов.ВыделенныеСтроки;
	Если ВыделенныеСтроки.Количество() > 0 Тогда
		СтатьяРасходов = ВыделенныеСтроки[0];
	Иначе
		СтатьяРасходов = ПредопределенноеЗначение("ПланВидовХарактеристик.СтатьиРасходов.ПустаяСсылка");
	КонецЕсли;
	
	ОбщегоНазначенияКлиентСервер.УстановитьЭлементОтбораДинамическогоСписка(Список, "Владелец", СтатьяРасходов, ВидСравненияКомпоновкиДанных.Равно,, Истина);
	
КонецПроцедуры

&НаСервере
Функция ЭтоГруппаСтатейРасходов(СтатьяРасходов)
	
	Возврат СтатьяРасходов.ЭтоГруппа;
	
КонецФункции

#КонецОбласти

#КонецОбласти
