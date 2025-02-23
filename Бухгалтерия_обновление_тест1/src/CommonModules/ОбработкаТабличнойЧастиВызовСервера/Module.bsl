////////////////////////////////////////////////////////////////////////////////
// Модуль предоставляет клиенту интерфейс к серверной части функциональности
// механизма обработки табличной части.
////////////////////////////////////////////////////////////////////////////////

#Область СлужебныеПроцедурыИФункции

// Вызов этой функции должен осуществляться только из клиентского модуля ОбработкаТабличнойЧастиКлиент.
//
Процедура ОбработатьСтрокуТЧ(ТекущаяСтрока, СтруктураДействий, КэшированныеЗначения) Экспорт
	
	Если КэшированныеЗначения = Неопределено Тогда
		КэшированныеЗначения = ОбработкаТабличнойЧастиКлиентСервер.ПолучитьСтруктуруКэшируемыеЗначения();
	КонецЕсли;
	
	ОбработкаТабличнойЧастиСервер.ОбработатьСтрокуТЧ(ТекущаяСтрока, СтруктураДействий, КэшированныеЗначения)
	
КонецПроцедуры

#КонецОбласти
