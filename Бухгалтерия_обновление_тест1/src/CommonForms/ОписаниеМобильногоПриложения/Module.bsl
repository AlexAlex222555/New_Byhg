
#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	Если Параметры.Свойство("АвтоТест") Тогда // Возврат при получении формы для анализа.
		Возврат;
	КонецЕсли;
	
	Заголовок = НСтр("ru='Инструкция по настройке мобильного приложения ""%1""';uk='Інструкція з настройки мобільного додатку ""%1""'");
	Заголовок = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(Заголовок, Параметры.НазваниеПриложения);
	
	МакетОписаниеПриложения = Метаданные.ОбщиеМакеты.Найти(Параметры.ИмяМакетаОписания);
	Если МакетОписаниеПриложения <> Неопределено Тогда
		ОписаниеПриложения = ПолучитьОбщийМакет(МакетОписаниеПриложения).ПолучитьТекст();
	КонецЕсли;
КонецПроцедуры

#КонецОбласти
