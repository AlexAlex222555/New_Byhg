///////////////////////////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2018
// Все права защищены. Эта программа и сопроводительные материалы предоставляются 
// в соответствии с условиями лицензии Attribution 4.0 International (CC BY 4.0)
// Текст лицензии доступен по ссылке:
// https://creativecommons.org/licenses/by/4.0/legalcode
///////////////////////////////////////////////////////////////////////////////////////////////////////

#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ОбработчикиСобытий

Процедура ПередЗаписью(Отказ)
	
	Если ОбменДанными.Загрузка Тогда
		Возврат;
	КонецЕсли;
	
	КаналСообщений = Наименование;
	
	СодержимоеТела = ТелоСообщения.Получить();
	
	// СтандартныеПодсистемы.РаботаВМоделиСервиса.БазоваяФункциональностьВМоделиСервиса
	СообщенияВМоделиСервиса.ПередОтправкойСообщения(КаналСообщений, СодержимоеТела);
	// Конец СтандартныеПодсистемы.РаботаВМоделиСервиса.БазоваяФункциональностьВМоделиСервиса
	
	ТелоСообщения = Новый ХранилищеЗначения(СодержимоеТела);
	
КонецПроцедуры

#КонецОбласти

#Иначе
ВызватьИсключение НСтр("ru='Недопустимый вызов объекта на клиенте.';uk='Неправильний виклик об''єкта на клієнті.'");
#КонецЕсли