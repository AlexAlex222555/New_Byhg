///////////////////////////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2020
// Все права защищены. Эта программа и сопроводительные материалы предоставляются 
// в соответствии с условиями лицензии Attribution 4.0 International (CC BY 4.0)
// Текст лицензии доступен по ссылке:
// https://creativecommons.org/licenses/by/4.0/legalcode
///////////////////////////////////////////////////////////////////////////////////////////////////////

#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	Если Параметры.Свойство("Владелец")
		И ТипЗнч(Параметры.Владелец) = Тип("ПланВидовХарактеристикСсылка.ВопросыДляАнкетирования")
		И НЕ Параметры.Владелец.Пустая() Тогда
			
			Объект.Владелец = Параметры.Владелец;
		
	Иначе
		
		ТекстСообщения = НСтр("ru='Данная форма предназначена для открытия только из формы элемента плана вида характеристик ""Вопросы для анкетирования""';uk='Дана форма призначена для відкриття тільки з форми елемента плану виду характеристик ""Питання для анкетування""'");
		ОбщегоНазначения.СообщитьПользователю(ТекстСообщения);
		Отказ = Истина;
		Возврат;
		
	КонецЕсли;
	
	Если Параметры.Свойство("ТипОтвета") Тогда
		Элементы.ТребуетОткрытогоОтвета.Видимость = (Параметры.ТипОтвета = Перечисления.ТипыОтветовНаВопрос.НесколькоВариантовИз);
	Иначе
		Элементы.ТребуетОткрытогоОтвета.Видимость = (Объект.Владелец.ТипОтвета = Перечисления.ТипыОтветовНаВопрос.НесколькоВариантовИз);
	КонецЕсли;
	
	Если Параметры.Свойство("Наименование") Тогда
		Объект.Наименование = Параметры.Наименование;
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти
