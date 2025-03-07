
#Область ПрограммныйИнтерфейс

#Область ПреобразованиеТиповАналитики

// Возвращает таблицу видов аналитик с колонкой типов
// 
// Возвращаемое значение:
//	ТаблицаЗначений - все доступные виды аналитик. Содержит колонки:
//		*Ссылка - ПланВидовХарактеристикСсылка.АналитикиСтатейБюджетов - вид аналитики.
//		*ТипЗначения - ОписаниеТипов - тип вида аналитики.
// 
Функция ТипыВидовВидыАналитик() Экспорт
	
	Запрос = Новый Запрос("ВЫБРАТЬ
	|	АналитикиСтатейБюджетов.Ссылка,
	|	АналитикиСтатейБюджетов.ТипЗначения
	|ИЗ
	|	ПланВидовХарактеристик.АналитикиСтатейБюджетов КАК АналитикиСтатейБюджетов");
	
	Возврат Запрос.Выполнить().Выгрузить();
	
КонецФункции

// Возвращает таблицу видов аналитик с колонкой типов
// 
// Возвращаемое значение:
//	Массив из ПланВидовХарактеристикСсылка.АналитикиСтатейБюджетов - все доступные виды аналитик.
// 
Функция ВидыАналитик() Экспорт
	
	Возврат ТипыВидовВидыАналитик().ВыгрузитьКолонку("Ссылка");
	
КонецФункции

// Возвращает таблицу видов аналитик с колонкой типов
// 
// Параметры:
// 	ВидАналитики - ПланВидовХарактеристикСсылка.АналитикиСтатейБюджетов, Строка - Ссылка на ПВХ АналитикиСтатейБюджетов или имя (идентификатор) вида аналитики.
//
// Возвращаемое значение:
//	Массив - Массив значений типа Тип, состоящий из используемых типов.
// 
Функция ТипыВидаАналитики(ВидАналитики) Экспорт
	ТипыВидаАналитики = Новый Массив;
	
	ИскомыйВидАналитики = Неопределено;
	ТипПараметра = ТипЗнч(ВидАналитики);
	// Уточним пустой вид и тип аналитики
	Если ТипПараметра = Тип("ПланВидовХарактеристикСсылка.АналитикиСтатейБюджетов")
		И ВидАналитики.Пустая() Тогда
		ВидАналитики = Неопределено;
		ТипПараметра = Тип("Неопределено");
	КонецЕсли;
	
	Если ТипПараметра = Тип("Строка") Тогда
		ИД_ВидаАналитики = МониторингЦелевыхПоказателей.СтрокуВУникальныйИдентификатор(ВидАналитики);
		
		ИскомыйВидАналитики = ПланыВидовХарактеристик.АналитикиСтатейБюджетов.ПолучитьСсылку(ИД_ВидаАналитики);
		
		Если НЕ ЗначениеЗаполнено(ИскомыйВидАналитики) Тогда
			ИскомыйВидАналитики = Неопределено;
		КонецЕсли;
	Иначе
		ИскомыйВидАналитики = ВидАналитики;
	КонецЕсли;
	
	// Неопределено - вид аналитики не используется 
	Если Не ТипПараметра = Тип("Неопределено") Тогда
		ТипыВидаАналитики = ИскомыйВидАналитики.ТипЗначения.Типы();
	КонецЕсли;
		
	Возврат ТипыВидаАналитики;
КонецФункции

// Возвращает массив пустых ссылок плана видов характеристик АналитикиСтатейБюджетов и Неопределено.
//
// Возвращаемое значение:
// 	Массив - массив пустых ссылок и неопределено.
//
Функция ПустыеЗначенияАналитики() Экспорт
	Массив = Новый Массив;
	
	Типы = БюджетированиеСервер.ВсеТипыАналитик().Типы();
	
	Для каждого Тип Из Типы Цикл
		ПустаяСсылка = Новый (Тип);
		Массив.Добавить(ПустаяСсылка);
	КонецЦикла;
	
	Массив.Добавить(Неопределено);
	
	Возврат Массив;
КонецФункции

#КонецОбласти

#Область МассивноИспользуемыеКонстанты

// Возвращает значение одноименной опции и используется в массивных, многократно повторяющихся алгоритмах. 
//
// Возвращаемое значение:
//   Булево - значение функциональной опции.
// 
Функция ИспользоватьНесколькоВалют() Экспорт
	Возврат ПолучитьФункциональнуюОпцию("ИспользоватьНесколькоВалют");
КонецФункции

#КонецОбласти 


// Возвращает структуру полей заполнения валюты по виду аналитики.
// 
// Параметры:
// 	ВидАналитики - ПланВидовХарактеристикСсылка.АналитикиСтатейБюджетов - Вид аналитики.
// Возвращаемое значение:
// 	Структура - Описание:
// * УчитыватьПоВалюте - Булево - Флаг учета аналитики по валюте.
// * ЗаполнениеВалюты - Булево - Путь к полю валюты.
Функция ПараметрыЗаполненияВалютыВидаАналитики(ВидАналитики) Экспорт
	
	Если ЗначениеЗаполнено(ВидАналитики) Тогда
		ПараметрыЗаполненияВалюты = ОбщегоНазначения.ЗначенияРеквизитовОбъекта(ВидАналитики, "УчитыватьПоВалюте, ЗаполнениеВалюты");
	Иначе
		ПараметрыЗаполненияВалюты = Новый Структура("УчитыватьПоВалюте, ЗаполнениеВалюты", Ложь, Ложь);
	КонецЕсли;
	
	Возврат ПараметрыЗаполненияВалюты;
КонецФункции

#КонецОбласти
