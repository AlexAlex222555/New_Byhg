////////////////////////////////////////////////////////////////////////////////
// КадровыйУчетФормыБазовый: методы, обслуживающие работу форм кадровых документов.
//  
////////////////////////////////////////////////////////////////////////////////

#Область СлужебныеПроцедурыИФункции

// Доопределяет форму кадрового документа при ее создании на сервере.
Процедура ФормаКадровогоДокументаПриСозданииНаСервере(Форма) Экспорт
	
	Если Форма.Параметры.Свойство("РежимОткрытияОкна") 
		И ЗначениеЗаполнено(Форма.Параметры.РежимОткрытияОкна) Тогда
		
		Форма.РежимОткрытияОкна = Форма.Параметры.РежимОткрытияОкна;
		
	КонецЕсли; 
	
	Если Форма.Параметры.Ключ.Пустая() Тогда
		
		ЗначенияДляЗаполнения = Новый Структура;
		МетаданныеДокумента = Форма.Объект.Ссылка.Метаданные();
		
		Если МетаданныеДокумента.Реквизиты.Найти("Организация") <> Неопределено Тогда
			ЗначенияДляЗаполнения.Вставить("Организация", "Объект.Организация");
		КонецЕсли;
		
		Если МетаданныеДокумента.Реквизиты.Найти("Подразделение") <> Неопределено Тогда
			ЗначенияДляЗаполнения.Вставить("Подразделение", "Объект.Подразделение");
		КонецЕсли; 
		
		Если МетаданныеДокумента.Реквизиты.Найти("Руководитель") <> Неопределено Тогда
			ЗначенияДляЗаполнения.Вставить("Руководитель", "Объект.Руководитель");
		КонецЕсли; 
		
		Если МетаданныеДокумента.Реквизиты.Найти("ДолжностьРуководителя") <> Неопределено Тогда
			ЗначенияДляЗаполнения.Вставить("ДолжностьРуководителя", "Объект.ДолжностьРуководителя");
		КонецЕсли; 
		
		ЗначенияДляЗаполнения.Вставить("Ответственный", "Объект.Ответственный");
		
		ЗарплатаКадры.ЗаполнитьПервоначальныеЗначенияВФорме(Форма, ЗначенияДляЗаполнения);
		
	КонецЕсли; 
	
КонецПроцедуры

#КонецОбласти
