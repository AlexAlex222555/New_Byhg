
#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	Если Параметры.РежимВыбора = Истина Тогда
		Элементы.Список.РежимВыбора = Истина;
	КонецЕсли;
	
	ЗарплатаКадры.ПриСозданииНаСервереФормыСДинамическимСписком(ЭтотОбъект, "Список");
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовШапкиФормы

&НаСервере
Процедура СписокПередЗагрузкойПользовательскихНастроекНаСервере(Элемент, Настройки)
	ЗарплатаКадры.ПроверитьПользовательскиеНастройкиДинамическогоСписка(ЭтотОбъект, Истина);
КонецПроцедуры

&НаСервере
Процедура СписокПриОбновленииСоставаПользовательскихНастроекНаСервере(СтандартнаяОбработка)
	ЗарплатаКадры.ПроверитьПользовательскиеНастройкиДинамическогоСписка(ЭтотОбъект);
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура ДобавитьНашуОрганизацию(Команда)
	
	ВыбраннаяОрганизация = ПредопределенноеЗначение("Справочник.Организации.ПустаяСсылка");
	Оповещение = Новый ОписаниеОповещения("ДобавитьНашуОрганизациюЗавершение", ЭтотОбъект);
	ПоказатьВводЗначения(Оповещение, ВыбраннаяОрганизация, НСтр("ru='Организация по данным которой создается работодатель';uk='Організація за даними якої створюється роботодавець'"), Тип("СправочникСсылка.Организации"));
	
КонецПроцедуры

&НаКлиенте
Процедура ДобавитьНашуОрганизациюЗавершение(ВыбраннаяОрганизация, ДополнительныеПараметры) Экспорт 
	
	Если ЗначениеЗаполнено(ВыбраннаяОрганизация) Тогда
		
		ПараметрыОткрытияФормы = Новый Структура("НашаОрганизация", ВыбраннаяОрганизация);
		ОткрытьФорму("Справочник.Работодатели.ФормаОбъекта", ПараметрыОткрытияФормы);
		
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти
