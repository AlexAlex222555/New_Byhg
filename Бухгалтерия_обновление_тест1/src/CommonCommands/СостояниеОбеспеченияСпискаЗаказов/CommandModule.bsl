
&НаКлиенте
Процедура ОбработкаКоманды(ПараметрКоманды, ПараметрыВыполненияКоманды)

	Заказы = Новый СписокЗначений();
	Заказы.ЗагрузитьЗначения(ПараметрКоманды);
	ПараметрыФормы = Новый Структура("Заказы", Заказы);
	ОткрытьФорму("Обработка.СостояниеОбеспечения.Форма", ПараметрыФормы,
		ПараметрыВыполненияКоманды.Источник, ПараметрыВыполненияКоманды.Уникальность, ПараметрыВыполненияКоманды.Окно);

КонецПроцедуры