
#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	Если Параметры.Свойство("АвтоТест") Тогда // Возврат при получении формы для анализа.
		Возврат;
	КонецЕсли;

	РазрешитьРедактированиеРеквизитов = Истина;
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура РазрешитьРедактирование(Команда)

	Результат = Новый Массив;
	Если РазрешитьРедактированиеРеквизитов Тогда
		Результат.Добавить("Цена");
		Результат.Добавить("Валюта");
		Результат.Добавить("Наименование");
	КонецЕсли;
	Закрыть(Результат);

КонецПроцедуры

#КонецОбласти
