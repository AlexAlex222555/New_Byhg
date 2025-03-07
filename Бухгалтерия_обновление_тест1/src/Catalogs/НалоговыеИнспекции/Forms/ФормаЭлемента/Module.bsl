&НаКлиенте
Процедура НаименованиеПриИзменении(Элемент)
	
	Если ФормироватьНаименованиеПолноеАвтоматически Тогда
		Объект.НаименованиеПолное = Объект.Наименование;
	КонецЕсли;
	
КонецПроцедуры

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	ФормироватьНаименованиеПолноеАвтоматически = УстановитьФлагФормироватьНаименованиеПолноеАвтоматически(Объект.НаименованиеПолное, Объект.Наименование);
	
КонецПроцедуры

&НаКлиенте
Процедура НаименованиеПолноеПриИзменении(Элемент)
	
	ФормироватьНаименованиеПолноеАвтоматически = УстановитьФлагФормироватьНаименованиеПолноеАвтоматически(Объект.НаименованиеПолное, Объект.Наименование);
	
КонецПроцедуры

&НаКлиентеНаСервереБезКонтекста
Функция УстановитьФлагФормироватьНаименованиеПолноеАвтоматически(НаименованиеПолное, Наименование)
   
   Возврат (ПустаяСтрока(НаименованиеПолное) ИЛИ НаименованиеПолное = Наименование);
   
КонецФункции
