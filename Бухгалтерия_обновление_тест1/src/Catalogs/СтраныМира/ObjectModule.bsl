///////////////////////////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2020
// Все права защищены. Эта программа и сопроводительные материалы предоставляются 
// в соответствии с условиями лицензии Attribution 4.0 International (CC BY 4.0)
// Текст лицензии доступен по ссылке:
// https://creativecommons.org/licenses/by/4.0/legalcode
///////////////////////////////////////////////////////////////////////////////////////////////////////

#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ОбработчикиСобытий

Процедура ПередЗаписью(Отказ)
	Если ОбменДанными.Загрузка Или ДополнительныеСвойства.Свойство("НеПроверятьУникальность") Тогда
		Возврат;
	КонецЕсли;
	
	Если Не ПроверитьЗаполнение() Тогда
		Отказ = Истина;
	КонецЕсли;
КонецПроцедуры

Процедура ОбработкаПроверкиЗаполнения(Отказ, ПроверяемыеРеквизиты)
	
	Существующий = СуществующийЭлемент();
	Если Существующий<>Неопределено Тогда
		Отказ = Истина;
		ОбщегоНазначения.СообщитьПользователю(Существующий.ОписаниеОшибки,, "Объект.Наименование");
	КонецЕсли;
	
КонецПроцедуры

Процедура ОбработкаЗаполнения(ДанныеЗаполнения, ТекстЗаполнения, СтандартнаяОбработка)
	Если ДанныеЗаполнения<>Неопределено Тогда
		ЗаполнитьЗначенияСвойств(ЭтотОбъект, ДанныеЗаполнения);
	КонецЕсли;
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

// Контролирует уникальность элемента в базе.
//
//  Возвращаемое значение:
//      Неопределено - нет ошибок.
//      Структура - описание элемента, существующего в базе. Свойства:
//          * ОписаниеОшибки     - Строка - текст ошибки.
//          * Код                - Строка - реквизит уже существующего элемента.
//          * Наименование       - Строка - реквизит уже существующего элемента.
//          * НаименованиеПолное - Строка - реквизит уже существующего элемента.
//          * КодАльфа2          - Строка - реквизит уже существующего элемента.
//          * КодАльфа3          - Строка - реквизит уже существующего элемента.
//          * Ссылка             - СправочникаСсылка.СтраныМира - реквизит уже существующего элемента.
//
Функция СуществующийЭлемент()
	
	Результат = Неопределено;
	
	// Нецифровые коды пропускаем
	ТипЧисло = Новый ОписаниеТипов("Число", Новый КвалификаторыЧисла(3, 0, ДопустимыйЗнак.Неотрицательный));
	Если Код="0" Или Код="00" Или Код="000" Тогда
		КодПоиска = "000";
	Иначе
		КодПоиска = Формат(ТипЧисло.ПривестиЗначение(Код), "ЧЦ=3; ЧН=; ЧВН=");
		Если КодПоиска="000" Тогда
			Возврат Результат; // Не число
		КонецЕсли;
	КонецЕсли;
		
	Запрос = Новый Запрос("
		|ВЫБРАТЬ ПЕРВЫЕ 1
		|	Код                КАК Код,
		|	Наименование       КАК Наименование,
		|	НаименованиеПолное КАК НаименованиеПолное,
		|	КодАльфа2          КАК КодАльфа2,
		|	КодАльфа3          КАК КодАльфа3,
		|	Ссылка             КАК Ссылка
		|ИЗ
		|	Справочник.СтраныМира
		|ГДЕ
		|	Код=&Код 
		|	И Ссылка <> &Ссылка
		|");
	Запрос.УстановитьПараметр("Ссылка", Ссылка);
	Запрос.УстановитьПараметр("Код",    КодПоиска);
	
	РезультатЗапроса = Запрос.Выполнить();
	Выборка = РезультатЗапроса.Выбрать();
	Если Выборка.Следующий() Тогда
		Результат = Новый Структура("ОписаниеОшибки", 
			СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(НСтр("ru='С кодом %1 уже существует страна %2. Измените код или используйте уже существующие данные.';uk='З кодом %1 уже існує країна %2. Змініть код або використайте вже існуючі дані.'"),
			Код, Выборка.Наименование));
		
		Для Каждого Поле Из РезультатЗапроса.Колонки Цикл
			Результат.Вставить(Поле.Имя, Выборка[Поле.Имя]);
		КонецЦикла;
	КонецЕсли;
	
	Возврат Результат;
КонецФункции

#КонецОбласти

#Иначе
ВызватьИсключение НСтр("ru='Недопустимый вызов объекта на клиенте.';uk='Неправильний виклик об''єкта на клієнті.'");
#КонецЕсли