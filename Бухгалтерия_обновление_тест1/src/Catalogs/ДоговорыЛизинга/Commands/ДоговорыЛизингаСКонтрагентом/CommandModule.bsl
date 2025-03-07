
&НаКлиенте
Процедура ОбработкаКоманды(ПараметрКоманды, ПараметрыВыполненияКоманды)
	
	ПараметрыОтбора = Новый Структура("Контрагент", ПараметрКоманды);
	
	ПараметрыФормы = Новый Структура;
	ПараметрыФормы.Вставить("Отбор", ПараметрыОтбора);
	ПараметрыФормы.Вставить("Заголовок", НСтр("ru='Договоры с контрагентом';uk='Договори з контрагентом'"));
	
	ОткрытьФорму("Справочник.ДоговорыЛизинга.ФормаСписка",
		ПараметрыФормы,
		ПараметрыВыполненияКоманды.Источник,
		ПараметрыВыполненияКоманды.Уникальность,
		ПараметрыВыполненияКоманды.Окно);
	
КонецПроцедуры
