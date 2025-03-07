
#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	// Пропускаем инициализацию, чтобы гарантировать получение формы при передаче параметра "АвтоТест".
	Если Параметры.Свойство("АвтоТест") Тогда
		Возврат;
	КонецЕсли;
	
	// Обработчик подсистемы "ВерсионированиеОбъектов".
	ВерсионированиеОбъектов.ПриСозданииНаСервере(ЭтаФорма);
	
КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)
	
	Если Объект.ГруппаЛьгот Тогда
		ТолькоПросмотр = Истина;
		ЭтаФорма.Элементы.ГруппаСтраницы.ТекущаяСтраница = ЭтаФорма.Элементы.СтраницаГруппаЛьгот;
	Иначе
		ЭтаФорма.Элементы.ГруппаСтраницы.ТекущаяСтраница = ЭтаФорма.Элементы.СтраницаЛьгота;
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти
