#Область ПрограммныйИнтерфейс

#Область Проведение

// Формирует параметры для проведения документа по регистрам учетного механизма через общий механизм проведения.
//
// Параметры:
//  Документ - ДокументОбъект - записываемый документ
//  Свойства - ФиксированнаяСтруктура - свойства документа (См. ПроведениеДокументов.СвойстваДокумента).
//
// Возвращаемое значение:
//  Структура - параметры учетного механизма (См. ПроведениеДокументов.ПараметрыУчетногоМеханизма()).
//
Функция ПараметрыДляПроведенияДокумента(Документ, Свойства) Экспорт
	
	Параметры = ПроведениеДокументов.ПараметрыУчетногоМеханизма();
	
	ТипДокумента = ТипЗнч(Документ);
	
	// Проведение
	Если Свойства.РежимЗаписи = РежимЗаписиДокумента.Проведение Тогда
		
		Параметры.ПодчиненныеРегистры.Добавить(Метаданные.РегистрыНакопления.ТМЦВЭксплуатации);
		
	КонецЕсли;
	
	// Контроль
	Если Свойства.РежимЗаписи <> РежимЗаписиДокумента.Запись Тогда
		
		Если Свойства.РежимЗаписи = РежимЗаписиДокумента.Проведение
				И (ТипДокумента = Тип("ДокументОбъект.ПрочееОприходованиеТоваров")
					//++ НЕ УТ
					Или ТипДокумента = Тип("ДокументОбъект.СписаниеИзЭксплуатации")
					//-- НЕ УТ
					)
			Или Не Свойства.ЭтоНовый
				И (ТипДокумента = Тип("ДокументОбъект.ВводОстатков") 
					Или ТипДокумента = Тип("ДокументОбъект.ВводОстатковТМЦВЭксплуатации")
					Или ТипДокумента = Тип("ДокументОбъект.ВнутреннееПотреблениеТоваров"))
			//++ НЕ УТ
			Или ТипДокумента = Тип("ДокументОбъект.ПеремещениеВЭксплуатации") 
			//-- НЕ УТ
			Тогда
			Параметры.КонтрольныеРегистрыИзменений.Добавить(Метаданные.РегистрыНакопления.ТМЦВЭксплуатации);
		КонецЕсли;
		
	КонецЕсли;
	
	Возврат Параметры;
	
КонецФункции

// Процедура формирования движений по подчиненным регистрам взаиморасчетов.
//
// Параметры:
//   ТаблицыДляДвижений - Структура - таблицы данных документа
//   Движения - КоллекцияДвижений - коллекция наборов записей движений документа
//   Отказ - Булево - признак отказа от проведения документа.
//
Процедура ОтразитьДвижения(ТаблицыДляДвижений, Движения, Отказ) Экспорт
	
	Если Отказ Тогда
		Возврат;
	КонецЕсли;
	
	ПроведениеДокументов.ОтразитьДвижения(ТаблицыДляДвижений, Движения, "ТМЦВЭксплуатации");
	
КонецПроцедуры

// Формирует тексты запросов для контроля изменений записанных движений регистров.
//
// Параметры:
//  Запрос - Запрос - запрос, хранящий параметры используемые в списке запросов
//  ТекстыЗапроса - СписокЗначений - список текстов запросов и их имен.
//  Документ - ДокументОбъект - записываемый документ.
//
Процедура ИнициализироватьДанныеКонтроляИзменений(Запрос, ТекстыЗапроса, Документ) Экспорт
	
	Если ПроведениеДокументов.ЕстьЗаписиВТаблице(Документ, "ДвиженияТМЦВЭксплуатацииИзменение") Тогда
		
		ТекстЗапроса =
			"ВЫБРАТЬ
			|	ТаблицаОборотов.Организация  КАК Организация,
			|	ТаблицаОборотов.Подразделение КАК Подразделение,
			|	ТаблицаОборотов.Номенклатура КАК Номенклатура,
			|	ТаблицаОборотов.Номенклатура.ЕдиницаИзмерения КАК ЕдиницаИзмерения,
			|	ТаблицаОборотов.Характеристика КАК Характеристика,
			|	ТаблицаОборотов.ФизическоеЛицо КАК ФизическоеЛицо,
			|	ТаблицаОборотов.Партия КАК Партия,
			|	ТаблицаОборотов.КоличествоОборот КАК Количество
			|ИЗ
			|	РегистрНакопления.ТМЦВЭксплуатации.Обороты(,,,
			|			(Организация, Подразделение, ФизическоеЛицо, Партия) В
			|				(ВЫБРАТЬ
			|					Таблица.Организация,
			|					Таблица.Подразделение,
			|					Таблица.ФизическоеЛицо,
			|					Таблица.Партия
			|				ИЗ
			|					ДвиженияТМЦВЭксплуатацииИзменение КАК Таблица)
			|	) КАК ТаблицаОборотов
			|ГДЕ
			|	ТаблицаОборотов.КоличествоОборот < 0";
		
		ТекстыЗапроса.Добавить(ТекстЗапроса, "ОшибкиТМЦВЭксплуатации");
		
	КонецЕсли;
	
КонецПроцедуры

// Выводит сообщения пользователю при наличии ошибок контроля изменений записанных движений регистров.
//
// Параметры:
//  РезультатыКонтроля - Структура - таблицы с результатами контроля изменений
//  Документ - ДокументОбъект - записываемый документ
//  Отказ - Булево - признак отказа от проведения документа.
//
Процедура СообщитьОРезультатахКонтроляИзменений(РезультатыКонтроля, Документ, Отказ) Экспорт
	
	Если ПроведениеДокументов.ЕстьЗаписиВТаблице(Документ, "ДвиженияТМЦВЭксплуатацииИзменение") Тогда
		
		Если ТипЗнч(Документ) = Тип("ДокументОбъект.ВнутреннееПотреблениеТоваров")
			Или ТипЗнч(Документ) = Тип("ДокументОбъект.ВводОстатков") 
			Или ТипЗнч(Документ) = Тип("ДокументОбъект.ВводОстатковТМЦВЭксплуатации") Тогда
			ШаблонСообщения = НСтр("ru='Номенклатура %1, %2
|По ТМЦ уже оформлено списание, перемещение или возврат в количестве большем, чем указано в документе, на %3 %4'
|;uk='Номенклатура %1, %2
|По ТМЦ вже оформлено списання, переміщення або повернення у кількості більшій, ніж зазначено в документі, на %3 %4'");
			ЗаполнятьПодразделение = Ложь;
		Иначе
			ШаблонСообщения = НСтр("ru='Номенклатура %1, %2
|Превышен оперативный остаток в подразделении %5, на %3 %4'
|;uk='Номенклатура %1, %2
|Перевищено оперативний залишок в підрозділі %5, на %3 %4'");
			ЗаполнятьПодразделение = Истина;
		КонецЕсли;
		
		Для каждого СтрокаОшибки Из РезультатыКонтроля.ОшибкиТМЦВЭксплуатации Цикл
			
			ПредставлениеНоменклатуры = НоменклатураКлиентСервер.ПредставлениеНоменклатуры(СтрокаОшибки.Номенклатура,
				СтрокаОшибки.Характеристика);
			
			Если ЗаполнятьПодразделение Тогда
				ТекстСообщения = СтрШаблон(ШаблонСообщения, ПредставлениеНоменклатуры,
					СтрокаОшибки.Партия, -СтрокаОшибки.Количество, СтрокаОшибки.ЕдиницаИзмерения, СтрокаОшибки.Подразделение);
			Иначе
				ТекстСообщения = СтрШаблон(ШаблонСообщения, ПредставлениеНоменклатуры,
					СтрокаОшибки.Партия, -СтрокаОшибки.Количество, СтрокаОшибки.ЕдиницаИзмерения);
			КонецЕсли;
			
			ОбщегоНазначенияКлиентСервер.СообщитьПользователю(ТекстСообщения, Документ,,, Отказ);
			
		КонецЦикла;
		
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

//++ НЕ УТ

Процедура СформироватьЗаписиРегистровЗаданий(ДокументСсылка, ДанныеТаблиц) Экспорт

КонецПроцедуры

//-- НЕ УТ

#КонецОбласти

#Область СлужебныйПрограммныйИнтерфейс

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

#Область ОбновлениеИнформационнойБазы

// Добавляет в список процедуры-обработчики обновления данных ИБ
// для всех поддерживаемых версий библиотеки или конфигурации.
// Вызывается перед началом обновления данных ИБ для построения плана обновления.
//
//  Обработчики - ТаблицаЗначений - описание полей, см. в процедуре
//                ОбновлениеИнформационнойБазы.НоваяТаблицаОбработчиковОбновления.
//
// Пример добавления процедуры-обработчика в список:
//  Обработчик = Обработчики.Добавить();
//  Обработчик.Версия              = "1.1.0.0";
//  Обработчик.Процедура           = "ОбновлениеИБ.ПерейтиНаВерсию_1_1_0_0";
//  Обработчик.МонопольныйРежим    = Ложь;
//
// Параметры:
// 	Обработчики - см. ОбновлениеИнформационнойБазы.НоваяТаблицаОбработчиковОбновления
//
Процедура ОписаниеОбработчиковОбновления(Обработчики) Экспорт

	Обработчик = Обработчики.Добавить();
	Обработчик.Процедура = "ТМЦВЭксплуатации.ИспользоватьТМЦВЭксплуатации_ОбработатьДанныеДляПереходаНаНовуюВерсию";
	Обработчик.Версия = "2.5.4.400";
	Обработчик.РежимВыполнения = "Отложенно";
	Обработчик.Идентификатор = Новый УникальныйИдентификатор("4ef67970-2b74-4971-b50a-e3eaa3e9c099");
	Обработчик.ПроцедураЗаполненияДанныхОбновления = "ТМЦВЭксплуатации.ИспользоватьТМЦВЭксплуатации_ЗарегистрироватьДанныеКОбработкеДляПереходаНаНовуюВерсию";
	Обработчик.ПроцедураПроверки = "";
	Обработчик.Комментарий = НСтр("ru='Устанавливает константу ""Использовать ТМЦ в эксплуатации""';uk='Встановлює константу ""Використовувати ТМЦ в експлуатації""'");
	
	Читаемые = Новый Массив;
	Читаемые.Добавить(Метаданные.Константы.ИспользоватьТМЦВЭксплуатации.ПолноеИмя());
	Обработчик.ЧитаемыеОбъекты = СтрСоединить(Читаемые, ",");
	
	Изменяемые = Новый Массив;
	Изменяемые.Добавить(Метаданные.Константы.ИспользоватьТМЦВЭксплуатации.ПолноеИмя());
	Обработчик.ИзменяемыеОбъекты = СтрСоединить(Изменяемые, ",");

КонецПроцедуры

#Область УстановкаКонстанты_ИспользоватьТМЦВЭксплуатации

Процедура ИспользоватьТМЦВЭксплуатации_ЗарегистрироватьДанныеКОбработкеДляПереходаНаНовуюВерсию(Параметры) Экспорт
	
	// Регистрация не требуется
	Возврат;
	
КонецПроцедуры

Процедура ИспользоватьТМЦВЭксплуатации_ОбработатьДанныеДляПереходаНаНовуюВерсию(Параметры) Экспорт
	
	Если НЕ Константы.ИспользоватьТМЦВЭксплуатации.Получить() Тогда
		МенеджерЗначения = Константы.ИспользоватьТМЦВЭксплуатации.СоздатьМенеджерЗначения();
		МенеджерЗначения.Значение = Истина;
		ОбновлениеИнформационнойБазы.ЗаписатьДанные(МенеджерЗначения);
	КонецЕсли;
	
	Параметры.ОбработкаЗавершена = Истина;
	
КонецПроцедуры

#КонецОбласти

#КонецОбласти

#КонецОбласти
