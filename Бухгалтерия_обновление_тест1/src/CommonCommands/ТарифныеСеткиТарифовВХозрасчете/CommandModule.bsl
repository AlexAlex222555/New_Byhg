
&НаКлиенте
Процедура ОбработкаКоманды(ПараметрКоманды, ПараметрыВыполненияКоманды)
	
	ПараметрыОткрытия = Новый Структура();
	СтруктураОтбора = Новый Структура;
	СтруктураОтбора.Вставить("ВидТарифнойСетки", ПредопределенноеЗначение("Перечисление.ВидыТарифныхСеток.Тариф"));	
	ПараметрыОткрытия.Вставить("Отбор", СтруктураОтбора);
	
	ОткрытьФорму("Справочник.ТарифныеСетки.ФормаСписка", 
		ПараметрыОткрытия, 
		ПараметрыВыполненияКоманды.Источник,
		,
		ПараметрыВыполненияКоманды.Окно);
		
КонецПроцедуры
