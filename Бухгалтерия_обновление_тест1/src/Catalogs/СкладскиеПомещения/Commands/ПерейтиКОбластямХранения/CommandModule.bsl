
#Область ОбработчикиСобытий

&НаКлиенте
Процедура ОбработкаКоманды(ПараметрКоманды, ПараметрыВыполненияКоманды)
	Отбор = Новый Структура;
	Отбор.Вставить("Помещение", ПараметрКоманды);
	
	ОткрытьФорму("Справочник.ОбластиХранения.ФормаСписка",Новый Структура("Отбор", Отбор),,ПараметрКоманды,ПараметрыВыполненияКоманды.Окно);
КонецПроцедуры

#КонецОбласти

