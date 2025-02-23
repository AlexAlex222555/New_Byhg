#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	Если Параметры.Свойство("АвтоТест") Тогда // Возврат при получении формы для анализа.
		Возврат;
	КонецЕсли;
	
	ПоказательБюджетов = Параметры.ПоказательБюджетов;
	ТипПравил = Перечисления.ТипПравилаПолученияФактическихДанныхБюджетирования.ФактическиеДанные;
	
	ОбщегоНазначенияКлиентСервер.УстановитьЭлементОтбораДинамическогоСписка(Список, "ПоказательБюджетов", ПоказательБюджетов);
	
	// СтандартныеПодсистемы.ПодключаемыеКоманды
	ПодключаемыеКоманды.ПриСозданииНаСервере(ЭтотОбъект);
	// Конец СтандартныеПодсистемы.ПодключаемыеКоманды
	
	УправлениеФормой();
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовШапкиФормы

&НаКлиенте
Процедура ТипПравилПриИзменении(Элемент)
	
	УправлениеФормой();
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовТаблицыФормыСписок

&НаКлиенте
Процедура СписокПриАктивизацииСтроки(Элемент)
	
	// СтандартныеПодсистемы.ПодключаемыеКоманды
	ПодключаемыеКомандыКлиент.НачатьОбновлениеКоманд(ЭтотОбъект);
	// Конец СтандартныеПодсистемы.ПодключаемыеКоманды
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

// СтандартныеПодсистемы.ПодключаемыеКоманды
&НаКлиенте
Процедура Подключаемый_ВыполнитьКоманду(Команда)
	ПодключаемыеКомандыКлиент.ВыполнитьКоманду(ЭтотОбъект, Команда, Элементы.Список);
КонецПроцедуры

&НаСервере
Процедура Подключаемый_ВыполнитьКомандуНаСервере(Контекст, Результат) Экспорт
	ПодключаемыеКоманды.ВыполнитьКоманду(ЭтотОбъект, Контекст, Элементы.Список, Результат);
КонецПроцедуры

&НаКлиенте
Процедура Подключаемый_ОбновитьКоманды()
	ПодключаемыеКомандыКлиентСервер.ОбновитьКоманды(ЭтотОбъект, Элементы.Список);
КонецПроцедуры
// Конец СтандартныеПодсистемы.ПодключаемыеКоманды

#КонецОбласти

#Область ОбработчикиСобытийТаблицыФормы

&НаКлиенте
Процедура СписокПередНачаломДобавления(Элемент, Отказ, Копирование, Родитель, Группа, Параметр)
	
	Отказ = Истина;
	ПараметрыОткрытия = Новый Структура;
	Если Копирование Тогда
		ПараметрыОткрытия.Вставить("ЗначениеКопирования", Элементы.Список.ТекущиеДанные.Ссылка);
	Иначе
		ПараметрыОткрытия.Вставить("ЗначенияЗаполнения", Новый Структура("ПоказательБюджетов, ТипПравила", ПоказательБюджетов, ТипПравил));
	КонецЕсли;
	ОткрытьФорму("Справочник.ПравилаПолученияФактаПоПоказателямБюджетов.Форма.ФормаОбъекта", ПараметрыОткрытия, ЭтаФорма,,,,,
																		РежимОткрытияОкнаФормы.БлокироватьОкноВладельца);
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаСервере
Процедура УправлениеФормой()
	
	Если Не ЗначениеЗаполнено(ТипПравил) Тогда
		ОбщегоНазначенияКлиентСервер.УдалитьЭлементыГруппыОтбораДинамическогоСписка(Список, "ТипПравила");
	Иначе
		СписокТиповПравила = Новый СписокЗначений;
		СписокТиповПравила.Добавить(Перечисления.ТипПравилаПолученияФактическихДанныхБюджетирования.ИсполнениеБюджетаИФактическиеДанные);
		
		СписокТиповПравила.Добавить(ТипПравил);
		ОбщегоНазначенияКлиентСервер.УстановитьЭлементОтбораДинамическогоСписка(Список,
																				"ТипПравила", СписокТиповПравила,
																				ВидСравненияКомпоновкиДанных.ВСписке, Истина);
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти
