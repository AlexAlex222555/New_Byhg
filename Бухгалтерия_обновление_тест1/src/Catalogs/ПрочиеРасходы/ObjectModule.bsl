#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ОбработчикиСобытий

Процедура ПередЗаписью(Отказ)
	
	Если ОбменДанными.Загрузка Тогда
		Возврат;
	КонецЕсли;

	ОбновлениеИнформационнойБазы.ПроверитьОбъектОбработан(ЭтотОбъект);

КонецПроцедуры

Процедура ОбработкаПроверкиЗаполнения(Отказ, ПроверяемыеРеквизиты)
	
	Если ЗначениеЗаполнено(Владелец) И НЕ Владелец.ТипЗначения.СодержитТип(Тип("СправочникСсылка.ПрочиеРасходы")) Тогда
		Текст = НСтр("ru='Необходимо указать статью расходов с аналитикой ""Прочие расходы""';uk='Необхідно вказати статтю витрат з аналітикою ""Інші витрати""'");
		ОбщегоНазначенияКлиентСервер.СообщитьПользователю(
			Текст,
			ЭтотОбъект,
			"Владелец",
			,
			Отказ);
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#КонецЕсли
