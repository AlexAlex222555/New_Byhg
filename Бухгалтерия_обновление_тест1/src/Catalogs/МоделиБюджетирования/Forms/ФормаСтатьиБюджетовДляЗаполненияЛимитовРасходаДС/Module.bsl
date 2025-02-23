#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	Если Параметры.Свойство("АвтоТест") Тогда // Возврат при получении формы для анализа.
		Возврат;
	КонецЕсли;
	
	АдресВоВременномХранилище = Параметры.АдресВоВременномХранилище;
	СтатьиБюджетов.Загрузить(ПолучитьИзВременногоХранилища(АдресВоВременномХранилище));

	Элементы.СтатьиБюджетов.Доступность = ПравоДоступа("Изменение", Метаданные.Справочники.СтатьиБюджетов);
	
	СобытияФорм.ПриСозданииНаСервере(ЭтаФорма, Отказ, СтандартнаяОбработка);
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийТаблицыСписок

&НаКлиенте
Процедура СтатьиБюджетовОбработкаВыбора(Элемент, ВыбранноеЗначение, СтандартнаяОбработка)
	
	Для каждого Значение Из ВыбранноеЗначение Цикл
		Если СтатьиБюджетов.НайтиСтроки(Новый Структура("СтатьяБюджетов", Значение)).Количество() > 0 Тогда
			Продолжить;
		КонецЕсли;
		Запись = СтатьиБюджетов.Добавить();
		Запись.СтатьяБюджетов = Значение;
	КонецЦикла;
	
	Модифицированность = Истина;
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура Подобрать(Команда)
	
	Аналитика = ПредопределенноеЗначение("ПланВидовХарактеристик.АналитикиСтатейБюджетов.СтатьиДвиженияДенежныхСредств");
	
	ПараметрыФормыВыбора = Новый Структура;
	ПараметрыФормыВыбора.Вставить("ЗакрыватьПриВыборе", Ложь);
	ПараметрыФормыВыбора.Вставить("ЗакрыватьПриЗакрытииВладельца", Истина);
	ПараметрыФормыВыбора.Вставить("МножественныйВыбор", Истина);
	ПараметрыФормыВыбора.Вставить("РежимВыбора", Истина);
	ПараметрыФормыВыбора.Вставить("ВыборГрупп", Ложь);
	ПараметрыФормыВыбора.Вставить("ВыборГруппПользователей", Ложь);
	ПараметрыФормыВыбора.Вставить("Аналитика", Аналитика);
	
	ОткрытьФорму("Справочник.СтатьиБюджетов.Форма.ФормаВыбораПоАналитике", ПараметрыФормыВыбора, Элементы.СтатьиБюджетов);
	
КонецПроцедуры

&НаКлиенте
Процедура Отмена(Команда)
	
	Закрыть(Неопределено);
	
КонецПроцедуры

&НаКлиенте
Процедура Сохранить(Команда)
	
	ПоместитьВоВременноеХранилищеСервер();
	Закрыть(АдресВоВременномХранилище);
	
КонецПроцедуры

&НаКлиенте
Процедура Подключаемый_ВыполнитьПереопределяемуюКоманду(Команда)
	
	СобытияФормКлиент.ВыполнитьПереопределяемуюКоманду(ЭтаФорма, Команда);
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаСервере
Процедура ПоместитьВоВременноеХранилищеСервер()
	
	ПоместитьВоВременноеХранилище(СтатьиБюджетов.Выгрузить(), АдресВоВременномХранилище);
	
КонецПроцедуры

#КонецОбласти
