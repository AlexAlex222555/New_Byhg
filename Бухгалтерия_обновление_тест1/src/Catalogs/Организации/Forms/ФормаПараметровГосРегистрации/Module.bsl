#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	Если Параметры.Свойство("АвтоТест") Тогда // Возврат при получении формы для анализа.
		Возврат;
	КонецЕсли;
	
	ВидОрганизации      = Параметры.ВидОрганизации;
	ДатаРегистрации     = Параметры.ДатаРегистрации;
	НомерРегистрации    = Параметры.НомерРегистрации;
	КемЗарегистрирована = Параметры.КемЗарегистрирована;
	
КонецПроцедуры

&НаКлиенте
Процедура ПередЗакрытием(Отказ, ЗавершениеРаботы, ТекстПредупреждения, СтандартнаяОбработка)
	
	Оповещение = Новый ОписаниеОповещения("СохранитьИЗакрыть", ЭтотОбъект);
	ОбщегоНазначенияКлиент.ПоказатьПодтверждениеЗакрытияФормы(Оповещение, Отказ, ЗавершениеРаботы,, ТекстПредупреждения);
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура ОК(Команда)
	
	СохранитьИЗакрыть();	
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаКлиенте
Процедура СохранитьИЗакрыть() Экспорт
	
	Модифицированность = Ложь;
	
	СтруктураПараметров = Новый Структура;
    
	СтруктураПараметров.Вставить("ДатаРегистрации", ДатаРегистрации);	
	СтруктураПараметров.Вставить("НомерРегистрации", НомерРегистрации);
	СтруктураПараметров.Вставить("КемЗарегистрирована", КемЗарегистрирована);
	
	Закрыть(СтруктураПараметров);
	
КонецПроцедуры

#КонецОбласти
