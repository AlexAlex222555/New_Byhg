
#Область ОбработчикиСобытийФормы

&НаКлиенте
Процедура ПриОткрытии(Отказ)
	УстановитьПоясняющийТекстКатегорииСтажа();
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовШапкиФормы

&НаКлиенте
Процедура КатегорияСтажаПриИзменении(Элемент)
	УстановитьПоясняющийТекстКатегорииСтажа();
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаКлиенте
Процедура УстановитьПоясняющийТекстКатегорииСтажа()
	
	КатегорияСтажаПоясняющийТекст = "";
	
	ЗарплатаКадрыКлиентСервер.УстановитьРасширеннуюПодсказкуЭлементуФормы(ЭтаФОрма, "КатегорияСтажа", КатегорияСтажаПоясняющийТекст);
	
КонецПроцедуры

#КонецОбласти
