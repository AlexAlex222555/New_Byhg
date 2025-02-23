#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ОбновлениеИнформационнойБазы

Процедура ЗаполнитьЕдиницыИзмерения() Экспорт
	
	ТекстЗапроса =
	"ВЫБРАТЬ
	|	Т.Ссылка
	|ИЗ
	|	Справочник.ТипоразмерыУпаковок КАК Т
	|ГДЕ
	|	Т.ВысотаЕдиницаИзмерения = ЗНАЧЕНИЕ(Справочник.УпаковкиЕдиницыИзмерения.ПустаяСсылка)";
	
	ЕдиницыИзмерения = Справочники.УпаковкиЕдиницыИзмерения.БазовыеЕдиницыИзмерения();
		
	Запрос = Новый Запрос(ТекстЗапроса);
	Выборка = Запрос.Выполнить().Выбрать();
	Пока Выборка.Следующий() Цикл
		СпрОбъект = Выборка.Ссылка.ПолучитьОбъект();
		ЗаполнитьЗначенияСвойств(СпрОбъект,ЕдиницыИзмерения);
		ОбновлениеИнформационнойБазы.ЗаписатьОбъект(СпрОбъект);
	КонецЦикла;
	
КонецПроцедуры

#КонецОбласти

#КонецЕсли