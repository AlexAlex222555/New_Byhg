
#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	УстановитьУсловноеОформление();
	
	Если Параметры.Свойство("АвтоТест") Тогда // Возврат при получении формы для анализа.
		Возврат;
	КонецЕсли;
	
	ПартнерыИКонтрагентыЛокализация.УстановитьСвойстваДинамическогоСпискаКонтрагенты(ЭтаФорма);
		
	ОбщегоНазначенияКлиентСервер.УстановитьПараметрДинамическогоСписка(
		Список,
		"ПредставлениеОбособленногоПодразделения",
		НСтр("ru='Обособленное подразделение';uk='Відокремлений підрозділ'"));
	
	ИспользоватьПартнеровКакКонтрагентов = ПолучитьФункциональнуюОпцию("ИспользоватьПартнеровКакКонтрагентов");
	ДоступноДобавлениеПартнеров = ПравоДоступа("Добавление", Метаданные.Справочники.Партнеры);
	
	Если ИспользоватьПартнеровКакКонтрагентов Тогда
		ТолькоПросмотр = Истина;
	КонецЕсли;
	
	МожноРедактировать = ПравоДоступа("Редактирование", Метаданные.Справочники.Контрагенты);
	Элементы.ФормаИзменитьВыделенные.Видимость                 = МожноРедактировать;
	Элементы.СписокКонтекстноеМенюИзменитьВыделенные.Видимость = МожноРедактировать;
	
	// СтандартныеПодсистемы.ПодключаемыеКоманды
	ПодключаемыеКоманды.ПриСозданииНаСервере(ЭтотОбъект);
	// Конец СтандартныеПодсистемы.ПодключаемыеКоманды
	
	// ИнтеграцияС1СДокументооборотом
	ИнтеграцияС1СДокументооборот.ПриСозданииНаСервере(ЭтаФорма, Элементы.ГруппаГлобальныеКоманды);
	// Конец ИнтеграцияС1СДокументооборотом
	

	ПартнерыИКонтрагентыЛокализация.ПриСозданииНаСервереФормаСпискаКонтрагент(ЭтаФорма, Отказ, СтандартнаяОбработка);
	СобытияФорм.ПриСозданииНаСервере(ЭтаФорма, Отказ, СтандартнаяОбработка);
	// СтандартныеПодсистемы.ВерсионированиеОбъектов
	ВерсионированиеОбъектов.ПриСозданииНаСервере(ЭтотОбъект);
	// Конец СтандартныеПодсистемы.ВерсионированиеОбъектов
	
КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)
КонецПроцедуры

&НаКлиенте
Процедура ОбработкаОповещения(ИмяСобытия, Параметр, Источник)
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовТаблицыФормыСписок

&НаКлиенте
Процедура СписокВыбор(Элемент, ВыбраннаяСтрока, Поле, СтандартнаяОбработка)
	
	Если МожноРедактировать
		И Поле = Элементы.ГоловнойКонтрагент Тогда
		
		ТекущиеДанные = Элемент.ТекущиеДанные;
		Если ТекущиеДанные.ОбособленноеПодразделение И Не ЗначениеЗаполнено(ТекущиеДанные.ГоловнойКонтрагент) Тогда
			
			СтандартнаяОбработка = Ложь;
			
			ПараметрыЗаполнения = Новый Структура;
			ПартнерыИКонтрагентыЛокализацияКлиентСервер.ДополнитьПараметрыЗаполнитьГоловногоКонтрагента(ПараметрыЗаполнения, ТекущиеДанные);
			ПараметрыЗаполнения.Вставить("Контрагент", ТекущиеДанные.Ссылка);
			ПараметрыЗаполнения.Вставить("Партнер",    ТекущиеДанные.Партнер);
			ПараметрыЗаполнения.Вставить("ИспользоватьПартнеровКакКонтрагентов", ИспользоватьПартнеровКакКонтрагентов);
			
			Оповещение = Новый ОписаниеОповещения("ЗаполнитьГоловногоКонтрагентаЗавершение", ЭтотОбъект);
			ПартнерыИКонтрагентыКлиент.ЗаполнитьГоловногоКонтрагента(ЭтотОбъект, ПараметрыЗаполнения, Истина, Оповещение);
			
		КонецЕсли;
		
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура СписокПриАктивизацииСтроки(Элемент)
	
	// СтандартныеПодсистемы.ПодключаемыеКоманды
	ПодключаемыеКомандыКлиент.НачатьОбновлениеКоманд(ЭтотОбъект);
	// Конец СтандартныеПодсистемы.ПодключаемыеКоманды
	
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура ИзменитьВыделенные(Команда)
	
	ГрупповоеИзменениеОбъектовКлиент.ИзменитьВыделенные(Элементы.Список);
	
КонецПроцедуры

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

#Область СлужебныеПроцедурыИФункции

&НаСервере
Процедура УстановитьУсловноеОформление()

	УсловноеОформление.Элементы.Очистить();

	ПартнерыИКонтрагенты.УстановитьОформлениеГоловногоКонтрагентаВСписке(ЭтаФорма);

КонецПроцедуры

&НаКлиенте
Процедура ЗаполнитьГоловногоКонтрагентаЗавершение(ВыбранноеЗначение, ДополнительныеПараметры) Экспорт
	
	Если ВыбранноеЗначение <> Неопределено Тогда
		Элементы.Список.Обновить();
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Область Локализация


// ИнтеграцияС1СДокументооборотом
&НаКлиенте
Процедура Подключаемый_ВыполнитьКомандуИнтеграции(Команда)
	
	ИнтеграцияС1СДокументооборотКлиент.ВыполнитьПодключаемуюКомандуИнтеграции(Команда, ЭтаФорма, Элементы.Список);
	
КонецПроцедуры
// Конец ИнтеграцияС1СДокументооборотом

#КонецОбласти