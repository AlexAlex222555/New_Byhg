&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	Если Параметры.Свойство("АвтоТест") Тогда
		Возврат;
	КонецЕсли;
	
	Список = Параметры.СписокВидовСубконто;
	
КонецПроцедуры

&НаКлиенте
Процедура КомандаОК(Команда)
		
	ОповеститьОВыборе(Список);
	
КонецПроцедуры


