#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда
	
#Область ОбработчикиСобытий

Процедура ОбработкаПроверкиЗаполнения(Отказ, ПроверяемыеРеквизиты)
	
	Если Не Начисление И Не Договоры И Не Пособия И Не Льготы И Не Удержания И Не НДФЛ И Не Займы И Не Взносы Тогда 
		ТекстСообщения = НСтр("ru='Не выбрано ни одного действия.';uk='Не вибрано жодної дії.'");
		ОбщегоНазначенияКлиентСервер.СообщитьПользователю(ТекстСообщения, ЭтотОбъект, "Начисление", , Отказ);
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти
	
#КонецЕсли
