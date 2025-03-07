///////////////////////////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2020
// Все права защищены. Эта программа и сопроводительные материалы предоставляются 
// в соответствии с условиями лицензии Attribution 4.0 International (CC BY 4.0)
// Текст лицензии доступен по ссылке:
// https://creativecommons.org/licenses/by/4.0/legalcode
///////////////////////////////////////////////////////////////////////////////////////////////////////

#Область ПрограммныйИнтерфейс

// Обработчик подписки на событие КонтрольНеразделенныхОбъектовПриЗаписи.
//
// Параметры:
//   Источник - ЛюбаяСсылка - источник события.
//   Отказ    - Булево - признак отказа от записи.
//
Процедура КонтрольНеразделенныхОбъектовПриЗаписи(Источник, Отказ) Экспорт
	
	// ОбменДанными.Загрузка не требуется.
	// Запись неразделенных данных из разделенного сеанса запрещена.
	Если Не ОбщегоНазначения.РазделениеВключено() Тогда
		Возврат;
	КонецЕсли;
	
	МодульРаботаВМоделиСервиса = ОбщегоНазначения.ОбщийМодуль("РаботаВМоделиСервиса");
	МодульРаботаВМоделиСервиса.КонтрольНеразделенныхОбъектовПриЗаписи(Источник, Отказ);
	
КонецПроцедуры

// Обработчик подписки на событие КонтрольНеразделенныхНаборовЗаписейПриЗаписи.
//
// Параметры:
//   Источник  - РегистрСведенийНаборЗаписей - источник события.
//   Отказ     - Булево - признак отказа от записи набора в базу данных.
//   Замещение - Булево - режим записи набора. Истина - запись осуществляется с заменой
//             существующих в базе данных записей набора. Ложь - запись осуществляется с
//             "дописыванием" текущего набора записей.
//
Процедура КонтрольНеразделенныхНаборовЗаписейПриЗаписи(Источник, Отказ, Замещение) Экспорт
	
	// ОбменДанными.Загрузка не требуется.
	// Запись неразделенных данных из разделенного сеанса запрещена.
	Если Не ОбщегоНазначения.РазделениеВключено() Тогда
		Возврат;
	КонецЕсли;
	
	МодульРаботаВМоделиСервиса = ОбщегоНазначения.ОбщийМодуль("РаботаВМоделиСервиса");
	МодульРаботаВМоделиСервиса.КонтрольНеразделенныхНаборовЗаписейПриЗаписи(Источник, Отказ, Замещение);
	
КонецПроцедуры

#КонецОбласти
