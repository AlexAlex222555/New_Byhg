
#Область ОбработчикиСобытийФормы

&НаКлиенте
Процедура ПослеЗаписи(ПараметрыЗаписи)
	
	Если Параметры.Ключ.Пустая() Тогда
		
		Оповестить("", Объект.Ссылка);
		
	КонецЕсли; 
	
КонецПроцедуры

#КонецОбласти
