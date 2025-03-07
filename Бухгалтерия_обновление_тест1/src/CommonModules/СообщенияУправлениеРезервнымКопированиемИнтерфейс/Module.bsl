///////////////////////////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2018
// Все права защищены. Эта программа и сопроводительные материалы предоставляются 
// в соответствии с условиями лицензии Attribution 4.0 International (CC BY 4.0)
// Текст лицензии доступен по ссылке:
// https://creativecommons.org/licenses/by/4.0/legalcode
///////////////////////////////////////////////////////////////////////////////////////////////////////

#Область ПрограммныйИнтерфейс

// Возвращает пространство имен текущей (используемой вызывающим кодом) версии интерфейса сообщений.
//
// Возвращаемое значение:
//  Строка - наименование пакета.
//
Функция Пакет() Экспорт
	
	Возврат "http://www.1c.ru/SaaS/ManageZonesBackup/" + Версия();
	
КонецФункции

// Возвращает текущую (используемую вызывающим кодом) версию интерфейса сообщений.
//
// Возвращаемое значение:
//  Строка - версия пакета.
//
Функция Версия() Экспорт
	
	Возврат "1.0.3.1";
	
КонецФункции

// Возвращает название программного интерфейса сообщений.
//
// Возвращаемое значение:
//  Строка - идентификатор программного интерфейса.
//
Функция ПрограммныйИнтерфейс() Экспорт
	
	Возврат "ManageZonesBackup";
	
КонецФункции

// Выполняет регистрацию обработчиков сообщений в качестве обработчиков каналов обмена сообщениями.
//
// Параметры:
//  МассивОбработчиков - Массив - массив обработчиков.
//
Процедура ОбработчикиКаналовСообщений(Знач МассивОбработчиков) Экспорт
	
	МассивОбработчиков.Добавить(СообщенияУправлениеРезервнымКопированиемОбработчикСообщения_1_0_2_1);
	МассивОбработчиков.Добавить(СообщенияУправлениеРезервнымКопированиемОбработчикСообщения_1_0_3_1);
	
КонецПроцедуры

// Выполняет регистрацию обработчиков трансляции сообщений.
//
// Параметры:
//  МассивОбработчиков - Массив - массив обработчиков.
//
//@skip-warning Пустой метод
Процедура ОбработчикиТрансляцииСообщений(Знач МассивОбработчиков) Экспорт
	
КонецПроцедуры

// Возвращает тип сообщения {http://www.1c.ru/SaaS/ManageZonesBackup/a.b.c.d}PlanZoneBackup.
//
// Параметры:
//  ИспользуемыйПакет - Строка - пространство имен версии интерфейса сообщений, для которой
//    получается тип сообщения.
//
// Возвращаемое значение:
//  ОбъектXDTO - сообщение.
//
Функция СообщениеПланироватьАрхивациюОбласти(Знач ИспользуемыйПакет = Неопределено) Экспорт
	
	Возврат СоздатьТипСообщения(ИспользуемыйПакет, "PlanZoneBackup");
	
КонецФункции

// Возвращает тип сообщения {http://www.1c.ru/SaaS/ManageZonesBackup/a.b.c.d}CancelZoneBackup.
//
// Параметры:
//  ИспользуемыйПакет - Строка - пространство имен версии интерфейса сообщений, для которой
//    получается тип сообщения.
//
// Возвращаемое значение:
//  ОбъектXDTO - сообщение.
//
Функция СообщениеОтменитьАрхивациюОбласти(Знач ИспользуемыйПакет = Неопределено) Экспорт
	
	Если ИспользуемыйПакет = Неопределено Тогда
		ИспользуемыйПакет = "http://www.1c.ru/SaaS/ManageZonesBackup/1.0.2.1";
	КонецЕсли;
	
	Возврат СоздатьТипСообщения(ИспользуемыйПакет, "CancelZoneBackup");
	
КонецФункции

// Возвращает тип сообщения {http://www.1c.ru/SaaS/ManageZonesBackup/a.b.c.d}UpdateScheduledZoneBackupSettings
//
// Параметры:
//  ИспользуемыйПакет - Строка - пространство имен версии интерфейса сообщений, для которой
//    получается тип сообщения.
//
// Возвращаемое значение:
//  ОбъектXDTO - сообщение.
//
Функция СообщениеОбновитьНастройкиПериодическогоРезервногоКопирования(Знач ИспользуемыйПакет = Неопределено) Экспорт
	
	Возврат СоздатьТипСообщения(ИспользуемыйПакет, "UpdateScheduledZoneBackupSettings");
	
КонецФункции

// Возвращает тип сообщения {http://www.1c.ru/SaaS/ManageZonesBackup/a.b.c.d}CancelScheduledZoneBackup
//
// Параметры:
//  ИспользуемыйПакет - Строка - пространство имен версии интерфейса сообщений, для которой
//    получается тип сообщения.
//
// Возвращаемое значение:
//  ОбъектXDTO - сообщение.
//
Функция СообщениеОтменитьПериодическоеРезервноеКопирование(Знач ИспользуемыйПакет = Неопределено) Экспорт
	
	Возврат СоздатьТипСообщения(ИспользуемыйПакет, "CancelScheduledZoneBackup");
	
КонецФункции

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

Функция СоздатьТипСообщения(Знач ИспользуемыйПакет, Знач Тип)
	
	Если ИспользуемыйПакет = Неопределено Тогда
		ИспользуемыйПакет = Пакет();
	КонецЕсли;
	
	Возврат ФабрикаXDTO.Тип(ИспользуемыйПакет, Тип);
	
КонецФункции

#КонецОбласти
