#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ОбработчикиСобытий
	
Процедура ПередЗаписью(Отказ, Замещение)
	
	Если ЗарплатаКадры.ОтключитьБизнесЛогикуПриЗаписи(ЭтотОбъект) Тогда
		Возврат;
	КонецЕсли;

	// Приводим периоды к началу месяца.
	Для Каждого Запись Из ЭтотОбъект Цикл
		Запись.Период 				= НачалоМесяца(Запись.Период);
		Запись.ПериодВзаиморасчетов = НачалоМесяца(Запись.ПериодВзаиморасчетов);
	КонецЦикла;
	
КонецПроцедуры

#КонецОбласти

#КонецЕсли