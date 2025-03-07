///////////////////////////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2020
// Все права защищены. Эта программа и сопроводительные материалы предоставляются 
// в соответствии с условиями лицензии Attribution 4.0 International (CC BY 4.0)
// Текст лицензии доступен по ссылке:
// https://creativecommons.org/licenses/by/4.0/legalcode
///////////////////////////////////////////////////////////////////////////////////////////////////////

#Область СлужебныеПроцедурыИФункции

// Возвращает таблицу префиксообразующих реквизитов, заданных в переопределяемом модуле.
//
Функция ПрефиксообразующиеРеквизиты() Экспорт
	
	Объекты = Новый ТаблицаЗначений;
	Объекты.Колонки.Добавить("Объект");
	Объекты.Колонки.Добавить("Реквизит");
	
	ПрефиксацияОбъектовПереопределяемый.ПолучитьПрефиксообразующиеРеквизиты(Объекты);
	
	РеквизитыОбъектов = Новый Соответствие;
	
	Для каждого Строка Из Объекты Цикл
		РеквизитыОбъектов.Вставить(Строка.Объект.ПолноеИмя(), Строка.Реквизит);
	КонецЦикла;
	
	Возврат Новый ФиксированноеСоответствие(РеквизитыОбъектов);
	
КонецФункции

#КонецОбласти
