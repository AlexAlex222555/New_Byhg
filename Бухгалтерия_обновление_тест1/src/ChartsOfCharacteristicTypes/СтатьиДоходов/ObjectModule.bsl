#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ОбработчикиСобытий

Процедура ОбработкаЗаполнения(ДанныеЗаполнения, СтандартнаяОбработка)
	
	ТипЗначения = Новый ОписаниеТипов("СправочникСсылка.Партнеры");
	
	Если ТипЗнч(ДанныеЗаполнения) = Тип("Структура")
		И ДанныеЗаполнения.Свойство("ДоговорыКредитовИДепозитов") Тогда
			ТипЗначения = Новый ОписаниеТипов("СправочникСсылка.ДоговорыКредитовИДепозитов");
	КонецЕсли;
	
	СтатьиДоходовЛокализация.ОбработкаЗаполнения(ЭтотОбъект, ДанныеЗаполнения, СтандартнаяОбработка);
	
КонецПроцедуры

Процедура ПередЗаписью(Отказ)
	
	Если ОбменДанными.Загрузка Тогда
		Возврат;
	КонецЕсли;
	
	Если Не ЭтоГруппа Тогда
		
		//++ НЕ УТ
		ДоходыПоОбъектамЭксплуатации = (ТипЗначения.СодержитТип(Тип("СправочникСсылка.ОбъектыЭксплуатации")));
		ДоходыПоНМАиНИОКР = (ТипЗначения.СодержитТип(Тип("СправочникСсылка.НематериальныеАктивы")));
		//-- НЕ УТ
		
		ДоговорыКредитовИДепозитов = ТипЗначения.СодержитТип(Тип("СправочникСсылка.ДоговорыКредитовИДепозитов"));
		
	КонецЕсли;
	
	СтатьиДоходовЛокализация.ПередЗаписью(ЭтотОбъект, Отказ);
	
КонецПроцедуры

Процедура ОбработкаПроверкиЗаполнения(Отказ, ПроверяемыеРеквизиты)
	
	СтатьиДоходовЛокализация.ОбработкаПроверкиЗаполнения(ЭтотОбъект, Отказ, ПроверяемыеРеквизиты);
	
КонецПроцедуры

Процедура ПриЗаписи(Отказ)
	
	Если Отказ ИЛИ ОбменДанными.Загрузка Тогда
		Возврат;
	КонецЕсли;
	
	СтатьиДоходовЛокализация.ПриЗаписи(ЭтотОбъект, Отказ);
	
КонецПроцедуры

#КонецОбласти


#КонецЕсли