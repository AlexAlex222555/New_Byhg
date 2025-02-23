#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)

	Если Параметры.Свойство("АвтоТест") Тогда // Возврат при получении формы для анализа.
		Возврат;
	КонецЕсли;
	
	Если Параметры.Свойство("НеДанныйСценарий") Тогда
		
		Если ТипЗнч(Параметры.НеДанныйСценарий) = Тип("ФиксированныйМассив") Тогда
			СсылкаНаДанныйСценарий = Новый СписокЗначений;
			СсылкаНаДанныйСценарий.ЗагрузитьЗначения(Новый Массив(Параметры.НеДанныйСценарий));
			ВидСравненияСписка = ВидСравненияКомпоновкиДанных.НеВСписке;
		Иначе
			СсылкаНаДанныйСценарий = Параметры.НеДанныйСценарий;
			ВидСравненияСписка = ВидСравненияКомпоновкиДанных.НеРавно;
		КонецЕсли;
		
		ОтборыСписковКлиентСервер.УстановитьЭлементОтбораСписка(
			Список, "Ссылка", СсылкаНаДанныйСценарий, ВидСравненияСписка);
		
	КонецЕсли;
	
	СобытияФорм.ПриСозданииНаСервере(ЭтаФорма, Отказ, СтандартнаяОбработка);
	
КонецПроцедуры

#КонецОбласти
#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура Подключаемый_ВыполнитьПереопределяемуюКоманду(Команда)
	
	СобытияФормКлиент.ВыполнитьПереопределяемуюКоманду(ЭтаФорма, Команда);
	
КонецПроцедуры

#КонецОбласти

