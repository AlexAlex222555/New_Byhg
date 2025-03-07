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
//   Строка - пространство имен.
//
Функция Пакет() Экспорт
	
	Возврат "http://www.1c.ru/SaaS/ControlZonesBackup/" + Версия();
	
КонецФункции

// Возвращает текущую (используемую вызывающим кодом) версию интерфейса сообщений.
// 
// Возвращаемое значение:
//   Строка - версия интерфейса.
//
Функция Версия() Экспорт
	
	Возврат "1.0.3.1";
	
КонецФункции

// Возвращает название программного интерфейса сообщений.
// 
// Возвращаемое значение:
//   Строка - название интерфейса.
//
Функция ПрограммныйИнтерфейс() Экспорт
	
	Возврат "ControlZonesBackup";
	
КонецФункции

// Выполняет регистрацию обработчиков сообщений в качестве обработчиков каналов обмена сообщениями.
//
// Параметры:
//  МассивОбработчиков - Массив - массив обработчиков.
//
//@skip-warning Пустой метод
Процедура ОбработчикиКаналовСообщений(Знач МассивОбработчиков) Экспорт
	
КонецПроцедуры

// Выполняет регистрацию обработчиков трансляции сообщений.
//
// Параметры:
//  МассивОбработчиков - Массив - массив обработчиков.
//
Процедура ОбработчикиТрансляцииСообщений(Знач МассивОбработчиков) Экспорт
	
	МассивОбработчиков.Добавить(СообщенияКонтрольРезервногоКопированияОбработчикТрансляции_1_0_2_1);
	
КонецПроцедуры

// Возвращает тип сообщения {http://www.1c.ru/SaaS/ControlZonesBackup/a.b.c.d}ZoneBackupSuccessfull.
//
// Параметры:
//  ИспользуемыйПакет - Строка - пространство имен версии интерфейса сообщений, для которой получается тип сообщения.
//
// Возвращаемое значение:
//  ОбъектXDTO - тип сообщения.
//
Функция СообщениеРезервнаяКопияОбластиСоздана(Знач ИспользуемыйПакет = Неопределено) Экспорт
	
	Возврат СоздатьТипСообщения(ИспользуемыйПакет, "ZoneBackupSuccessfull");
	
КонецФункции

// Возвращает тип сообщения {http://www.1c.ru/SaaS/ControlZonesBackup/a.b.c.d}ZoneBackupFailed.
//
// Параметры:
//  ИспользуемыйПакет - Строка - пространство имен версии интерфейса сообщений, для которой получается тип сообщения.
//
// Возвращаемое значение:
//  ОбъектXDTO - тип сообщения.
//
Функция СообщениеОшибкаАрхивацииОбласти(Знач ИспользуемыйПакет = Неопределено) Экспорт
	
	Возврат СоздатьТипСообщения(ИспользуемыйПакет, "ZoneBackupFailed");
	
КонецФункции

// Возвращает тип сообщения {http://www.1c.ru/SaaS/ControlZonesBackup/a.b.c.d}ZoneBackupSkipped.
//
// Параметры:
//  ИспользуемыйПакет - Строка - пространство имен версии интерфейса сообщений, для которой получается тип сообщения.
//
// Возвращаемое значение:
//  ОбъектXDTO - тип сообщения.
//
Функция СообщениеАрхивацияОбластиПропущена(Знач ИспользуемыйПакет = Неопределено) Экспорт
	
	Если ИспользуемыйПакет = Неопределено Тогда
		ИспользуемыйПакет = "http://www.1c.ru/SaaS/ControlZonesBackup/1.0.2.1";
	КонецЕсли;
	
	Возврат СоздатьТипСообщения(ИспользуемыйПакет, "ZoneBackupSkipped");
	
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
