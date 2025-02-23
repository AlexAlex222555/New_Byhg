#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	// Пропускаем инициализацию, чтобы гарантировать получение формы при передаче параметра "АвтоТест".
	Если Параметры.Свойство("АвтоТест") Тогда
		Возврат;
	КонецЕсли;
	
	Макет = Справочники.ПравилаИнтеграцииС1СДокументооборотом.ПолучитьМакет("ОписаниеВебСервисов");
	ОписаниеВебСервисов = Макет.ПолучитьТекст();
	
	Параметры.Свойство("Ссылка", Ссылка);
	
КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)
	
	Если ЗначениеЗаполнено(Ссылка) Тогда
		ПодключитьОбработчикОжидания("ПерейтиКСсылке", 0.2, Истина);
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаКлиенте
Процедура ПерейтиКСсылке()
	
	// При проблемах с совместимостью браузеров откроем документ без позиционирования
	// на ссылке, проглотив исключение как некритичное.
	Попытка
		Документ = Элементы.ПолеHTMLДокумента.Документ;
		Элемент = Документ.getElementById(Ссылка);
		Если Элемент <> Неопределено Тогда
			Элемент.scrollIntoView(Истина)
		КонецЕсли;
	Исключение
		ПроходитАПК = Истина;
	КонецПопытки;
	
КонецПроцедуры

#КонецОбласти