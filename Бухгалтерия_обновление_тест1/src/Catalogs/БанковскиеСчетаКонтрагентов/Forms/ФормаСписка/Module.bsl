
#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	Если Параметры.Свойство("АвтоТест") Тогда // Возврат при получении формы для анализа.
		Возврат;
	КонецЕсли;

	Если Параметры.Свойство("ОтборПоПартнеру") Тогда
		
		ОбщегоНазначенияКлиентСервер.УстановитьЭлементОтбораДинамическогоСписка(
			Список,
			"Владелец",
			ПартнерыИКонтрагенты.ПолучитьКонтрагентаПартнераПоУмолчанию(Параметры.ОтборПоПартнеру));
	КонецЕсли;
		
	// ИнтеграцияС1СДокументооборотом
	ИнтеграцияС1СДокументооборот.ПриСозданииНаСервере(ЭтаФорма);
	// Конец ИнтеграцияС1СДокументооборотом

	СобытияФорм.ПриСозданииНаСервере(ЭтаФорма, Отказ, СтандартнаяОбработка);
	
КонецПроцедуры

&НаСервере
Процедура ПриЗагрузкеДанныхИзНастроекНаСервере(Настройки)
	
	ТолькоДействующие = Настройки.Получить("ТолькоДействующие");
	Элементы.ТолькоДействующие.Пометка = ТолькоДействующие;
	ТолькоДействующиеПриИзмененииСервер();
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

// ИнтеграцияС1СДокументооборотом
&НаКлиенте
Процедура Подключаемый_ВыполнитьКомандуИнтеграции(Команда)
	
	ИнтеграцияС1СДокументооборотКлиент.ВыполнитьПодключаемуюКомандуИнтеграции(Команда, ЭтаФорма, Элементы.Список);
	
КонецПроцедуры
// Конец ИнтеграцияС1СДокументооборотом

&НаКлиенте
Процедура Подключаемый_ВыполнитьПереопределяемуюКоманду(Команда)
	
	СобытияФормКлиент.ВыполнитьПереопределяемуюКоманду(ЭтаФорма, Команда);
	
КонецПроцедуры

&НаКлиенте
Процедура ТолькоДействующие(Команда)
	
	Элементы.ТолькоДействующие.Пометка = Не Элементы.ТолькоДействующие.Пометка;
	
	ТолькоДействующие = Элементы.ТолькоДействующие.Пометка;
	ТолькоДействующиеПриИзмененииСервер();
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаСервере
Процедура ТолькоДействующиеПриИзмененииСервер()
	
	ОбщегоНазначенияКлиентСервер.УстановитьЭлементОтбораДинамическогоСписка(
		Список,
		"Закрыт",
		ТолькоДействующие,
		ВидСравненияКомпоновкиДанных.НеРавно,
		,
		ТолькоДействующие);
	
КонецПроцедуры

#КонецОбласти