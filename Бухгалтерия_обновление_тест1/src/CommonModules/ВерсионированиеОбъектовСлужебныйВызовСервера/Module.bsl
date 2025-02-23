///////////////////////////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2020
// Все права защищены. Эта программа и сопроводительные материалы предоставляются 
// в соответствии с условиями лицензии Attribution 4.0 International (CC BY 4.0)
// Текст лицензии доступен по ссылке:
// https://creativecommons.org/licenses/by/4.0/legalcode
///////////////////////////////////////////////////////////////////////////////////////////////////////

#Область СлужебныеПроцедурыИФункции

// Устанавливает режим хранения истории изменений
// Выполняет:
//   - установку значение в константу ИспользоватьВерсионированиеОбъектов
//   - изменяет значение функциональной опции ИспользоватьВерсионированиеОбъектов
//   
Функция УстановитьРежимХраненияИсторииИзменений(ХранитьИсториюИзменений) Экспорт
	
	Если Не Пользователи.ЭтоПолноправныйПользователь(,, Ложь) Тогда
		ВызватьИсключение НСтр("ru='Недостаточно прав для совершения операции.';uk='Недостатньо прав для здійснення операції.'");
	КонецЕсли;
	
	Попытка
		Константы.ИспользоватьВерсионированиеОбъектов.Установить(ХранитьИсториюИзменений);
	Исключение
		Возврат Ложь;
	КонецПопытки;
	
	Возврат Истина;
	
КонецФункции

// (См. ВерсионированиеОбъектов.ЗначениеФлажкаХранитьИсторию)
//
Функция ЗначениеФлажкаХранитьИсторию() Экспорт
	
	Возврат ВерсионированиеОбъектов.ЗначениеФлажкаХранитьИсторию();
	
КонецФункции

#КонецОбласти

