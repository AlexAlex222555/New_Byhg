
&НаКлиенте
Процедура ОбработкаКоманды(ПараметрКоманды, ПараметрыВыполненияКоманды)

	Параметры = Новый Структура("ОтборПоТипуОбеспечения", ПредопределенноеЗначение("Перечисление.ТипыОбеспечения.Покупка"));
	ОткрытьФорму("Обработка.ОбеспечениеПотребностей.Форма", Параметры, ПараметрыВыполненияКоманды.Источник, ПараметрыВыполненияКоманды.Уникальность);

КонецПроцедуры
