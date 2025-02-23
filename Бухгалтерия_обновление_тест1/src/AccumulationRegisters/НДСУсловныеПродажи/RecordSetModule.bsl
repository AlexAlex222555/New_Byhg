#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ОбработчикиСобытий

Процедура ПередЗаписью(Отказ, Замещение)
	
	Если ОбменДанными.Загрузка
		Или РасчетСебестоимостиПрикладныеАлгоритмы.ДвиженияЗаписываютсяРасчетомПартийИСебестоимости(ЭтотОбъект) Тогда
		Возврат;
	КонецЕсли;
	
	ОбновлениеИнформационнойБазы.ПроверитьОбъектОбработан(ЭтотОбъект);
	
	Если НЕ РасчетСебестоимостиПрикладныеАлгоритмы.ФормироватьДвиженияРегистровУчетаСебестоимости(ЭтотОбъект) Тогда
		Возврат;
	КонецЕсли;
	
	РасчетСебестоимостиПрикладныеАлгоритмы.СохранитьДвиженияСформированныеРасчетомПартийИСебестоимости(ЭтотОбъект, Замещение);
	
	Если Не ПроведениеДокументов.КонтролироватьИзменения(ДополнительныеСвойства)
		Или ПланыОбмена.ГлавныйУзел() <> Неопределено Тогда
		Возврат;
	КонецЕсли;

КонецПроцедуры

Процедура ПриЗаписи(Отказ, Замещение)
	
	Если ОбменДанными.Загрузка Или Не ПроведениеДокументов.КонтролироватьИзменения(ДополнительныеСвойства)
		Или ПланыОбмена.ГлавныйУзел() <> Неопределено
		Или РасчетСебестоимостиПрикладныеАлгоритмы.ДвиженияЗаписываютсяРасчетомПартийИСебестоимости(ЭтотОбъект) Тогда
		Возврат;
	КонецЕсли;
	
	Если НЕ РасчетСебестоимостиПрикладныеАлгоритмы.ФормироватьДвиженияРегистровУчетаСебестоимости(ЭтотОбъект) Тогда
		Возврат;
	КонецЕсли;

КонецПроцедуры

#КонецОбласти

#КонецЕсли
