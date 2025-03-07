
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
	
	// Проведение
	Если Свойства.РежимЗаписи = РежимЗаписиДокумента.Проведение Тогда
		
		Параметры.ПодчиненныеРегистры.Добавить(Метаданные.РегистрыНакопления.АмортизацияОС);
		Параметры.ПодчиненныеРегистры.Добавить(Метаданные.РегистрыНакопления.СтоимостьОС);
		
		Параметры.ПодчиненныеРегистры.Добавить(Метаданные.РегистрыСведений.МестонахождениеОС);
		Параметры.ПодчиненныеРегистры.Добавить(Метаданные.РегистрыСведений.НаработкиОбъектовЭксплуатации);
		Параметры.ПодчиненныеРегистры.Добавить(Метаданные.РегистрыСведений.ПараметрыАмортизацииОСУУ);
		Параметры.ПодчиненныеРегистры.Добавить(Метаданные.РегистрыСведений.ПервоначальныеСведенияОС);
		Параметры.ПодчиненныеРегистры.Добавить(Метаданные.РегистрыСведений.ПорядокУчетаОС);
		Параметры.ПодчиненныеРегистры.Добавить(Метаданные.РегистрыСведений.ПорядокУчетаОСУУ); 
		
	КонецЕсли;
	
	// Контроль
	Если Свойства.РежимЗаписи <> РежимЗаписиДокумента.Запись Тогда
		
		Параметры.КонтрольныеРегистрыЗаданий.Добавить(Метаданные.РегистрыНакопления.АмортизацияОС);
		Параметры.КонтрольныеРегистрыЗаданий.Добавить(Метаданные.РегистрыНакопления.СтоимостьОС);
		
		Параметры.КонтрольныеРегистрыЗаданий.Добавить(Метаданные.РегистрыСведений.МестонахождениеОС);
		Параметры.КонтрольныеРегистрыЗаданий.Добавить(Метаданные.РегистрыСведений.НаработкиОбъектовЭксплуатации);
		Параметры.КонтрольныеРегистрыЗаданий.Добавить(Метаданные.РегистрыСведений.ПараметрыАмортизацииОСУУ);
		Параметры.КонтрольныеРегистрыЗаданий.Добавить(Метаданные.РегистрыСведений.ПервоначальныеСведенияОС);
		Параметры.КонтрольныеРегистрыЗаданий.Добавить(Метаданные.РегистрыСведений.ПорядокУчетаОСУУ);
		
	КонецЕсли;
	
	Параметры.НезависимыеРегистры.Добавить(Метаданные.РегистрыСведений.ДокументыПоОС);
	
	ОсновныеСредстваЛокализация.ДополнитьПараметрыДляПроведенияДокумента(Параметры, Документ, Свойства);
	
	Возврат Параметры;
	
КонецФункции

// Процедура формирования движений по подчиненным регистрам основных средств.
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
	
	ПроведениеДокументов.ОтразитьДвижения(ТаблицыДляДвижений, Движения, "АмортизацияОС");
	ПроведениеДокументов.ОтразитьДвижения(ТаблицыДляДвижений, Движения, "СтоимостьОС");
	
	ПроведениеДокументов.ОтразитьДвижения(ТаблицыДляДвижений, Движения, "МестонахождениеОС");
	ПроведениеДокументов.ОтразитьДвижения(ТаблицыДляДвижений, Движения, "НаработкиОбъектовЭксплуатации");
	ПроведениеДокументов.ОтразитьДвижения(ТаблицыДляДвижений, Движения, "ПараметрыАмортизацииОСУУ");
	ПроведениеДокументов.ОтразитьДвижения(ТаблицыДляДвижений, Движения, "ПервоначальныеСведенияОС");
	ПроведениеДокументов.ОтразитьДвижения(ТаблицыДляДвижений, Движения, "ПорядокУчетаОС");
	ПроведениеДокументов.ОтразитьДвижения(ТаблицыДляДвижений, Движения, "ПорядокУчетаОСУУ");
	
	ОсновныеСредстваЛокализация.ОтразитьДвижения(ТаблицыДляДвижений, Движения, Отказ);
	
КонецПроцедуры

// Процедура формирования движений по независимым регистрам основных средств.
//
// Параметры:
//	ТаблицыДляДвижений - Структура - таблицы данных документа
//	Документ - ДокументСсылка - ссылка на документ
//	Отказ - Булево - признак отказа от проведения документа.
//
Процедура ЗаписатьДанные(ТаблицыДляДвижений, Документ, Отказ) Экспорт
	
	Если Отказ Тогда
		Возврат;
	КонецЕсли;
	
	Если ТаблицыДляДвижений.Свойство("ТаблицаДокументыПоОС") Тогда
		
		Набор = РегистрыСведений.ДокументыПоОС.СоздатьНаборЗаписей();
		Набор.Отбор.Ссылка.Установить(Документ);
		Набор.Загрузить(ТаблицыДляДвижений.ТаблицаДокументыПоОС);
		Набор.Записать();
		
	КонецЕсли;
	
	ОсновныеСредстваЛокализация.ЗаписатьДанные(ТаблицыДляДвижений, Документ, Отказ);
	
КонецПроцедуры

#КонецОбласти

#КонецОбласти
