
#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	Если Параметры.Свойство("АвтоТест") Тогда // Возврат при получении формы для анализа.
		Возврат;
	КонецЕсли;

	Если Параметры.Свойство("ЭтоПредопределенныйЭлемент") Тогда
		Если Параметры.ЭтоПредопределенныйЭлемент Тогда
			ЭтоПредопределенныйЭлемент = Параметры.ЭтоПредопределенныйЭлемент;
		КонецЕсли;
	КонецЕсли;
	РазрешитьРедактированиеРеквизитов = Истина;
	
КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)
	
	Если ЭтоПредопределенныйЭлемент Тогда
		Закрыть(НСтр("ru='Свойства предопределенного элемента изменять нельзя!';uk='Властивості напередвизначеного елементу змінювати не можна!'"));
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура РазрешитьРедактирование(Команда)

	Результат = Новый Массив;
	Если РазрешитьРедактированиеРеквизитов Тогда
		Результат.Добавить("АктивПассив");
		Результат.Добавить("ТипЗначения");
	КонецЕсли;
	Закрыть(Результат);

КонецПроцедуры

#КонецОбласти
