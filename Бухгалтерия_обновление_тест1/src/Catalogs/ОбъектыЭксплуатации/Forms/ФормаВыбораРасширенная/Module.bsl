
#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	Если Параметры.Свойство("АвтоТест") Тогда
		Возврат;
	КонецЕсли;
	
	СписокОбъектовЭксплуатации = Новый СписокЗначений;
	
	ЗаполнитьСписокДоступныхДляВыбораОбъектов(СписокОбъектовЭксплуатации);
	
	ОбщегоНазначенияКлиентСервер.УстановитьЭлементОтбораДинамическогоСписка(
		Список,
		"Ссылка",
		СписокОбъектовЭксплуатации,
		ВидСравненияКомпоновкиДанных.ВСписке,
		,
		Истина,
		РежимОтображенияЭлементаНастройкиКомпоновкиДанных.Недоступный);
	
	СобытияФорм.ПриСозданииНаСервере(ЭтаФорма, Отказ, СтандартнаяОбработка);
	// СтандартныеПодсистемы.ПодключаемыеКоманды
	ПодключаемыеКоманды.ПриСозданииНаСервере(ЭтотОбъект);
	// Конец СтандартныеПодсистемы.ПодключаемыеКоманды
	// ИнтеграцияС1СДокументооборотом
	ИнтеграцияС1СДокументооборот.ПриСозданииНаСервере(ЭтаФорма);
	// Конец ИнтеграцияС1СДокументооборотом
	
	ВерсионированиеОбъектов.ПриСозданииНаСервере(ЭтотОбъект);
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовТаблицыФормыСписок

&НаКлиенте
Процедура СписокПриАктивизацииСтроки(Элемент)
	
	// СтандартныеПодсистемы.ПодключаемыеКоманды
	ПодключаемыеКомандыКлиент.НачатьОбновлениеКоманд(ЭтотОбъект);
	// Конец СтандартныеПодсистемы.ПодключаемыеКоманды
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

#Область СтандартныеПодсистемы

// СтандартныеПодсистемы.ПодключаемыеКоманды
&НаКлиенте
Процедура Подключаемый_ВыполнитьКоманду(Команда)
	ПодключаемыеКомандыКлиент.ВыполнитьКоманду(ЭтотОбъект, Команда, Элементы.Список);
КонецПроцедуры

&НаСервере
Процедура Подключаемый_ВыполнитьКомандуНаСервере(Контекст, Результат) Экспорт
	ПодключаемыеКоманды.ВыполнитьКоманду(ЭтотОбъект, Контекст, Элементы.Список, Результат);
КонецПроцедуры

&НаКлиенте
Процедура Подключаемый_ОбновитьКоманды()
	ПодключаемыеКомандыКлиентСервер.ОбновитьКоманды(ЭтотОбъект, Элементы.Список);
КонецПроцедуры
// Конец СтандартныеПодсистемы.ПодключаемыеКоманды

&НаКлиенте
Процедура Подключаемый_ВыполнитьПереопределяемуюКоманду(Команда)
	
	СобытияФормКлиент.ВыполнитьПереопределяемуюКоманду(ЭтаФорма, Команда);
	
КонецПроцедуры

&НаКлиенте
Процедура Подключаемый_ВыполнитьКомандуИнтеграции(Команда)
	
	// ИнтеграцияС1СДокументооборотом
	ИнтеграцияС1СДокументооборотКлиент.ВыполнитьПодключаемуюКомандуИнтеграции(Команда, ЭтаФорма, Элементы.Список);
	// Конец ИнтеграцияС1СДокументооборотом
	
КонецПроцедуры

#КонецОбласти

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаСервере
Процедура ЗаполнитьСписокДоступныхДляВыбораОбъектов(СписокОбъектовЭксплуатации)
	
	ИспользоватьУправлениеРемонтами = ПолучитьФункциональнуюОпцию("ИспользоватьУправлениеРемонтами");
	
	
		ТекстЗапроса = ОбъектыЭксплуатацииЛокализация.ТекстЗапросаДоступныхДляВыбораОбъектов();
		
		Если ТекстЗапроса = Неопределено Тогда
			
			ТекстЗапроса =
			"ВЫБРАТЬ РАЗРЕШЕННЫЕ
			|	СрезСведенияОС.ОсновноеСредство КАК Ссылка
			|ИЗ
			|	РегистрСведений.ПараметрыАмортизацииОСУУ.СрезПоследних(, &РегистрацияНаработки) КАК СрезСведенияОС
			|ГДЕ
			|	СрезСведенияОС.МетодНачисленияАмортизации = ЗНАЧЕНИЕ(Перечисление.СпособыНачисленияАмортизацииОС.ПропорциональноОбъемуПродукции)";
			
		КонецЕсли; 
		
	
	Запрос = Новый Запрос(ТекстЗапроса);
	
	Запрос.УстановитьПараметр(
		"РегистрацияНаработки",
		Параметры.Свойство("РегистрацияНаработки") И Параметры.РегистрацияНаработки);
		
	Запрос.УстановитьПараметр(
		"УстановкаНаработки",
		Параметры.Свойство("УстановкаНаработки") И Параметры.УстановкаНаработки);
		
	Запрос.УстановитьПараметр(
		"ИсточникПоказателяНаработки",
		Параметры.Свойство("ИсточникПоказателяНаработки") И Параметры.ИсточникПоказателяНаработки);
		
	Запрос.УстановитьПараметр(
		"ПоказательНаработки",
		?(Параметры.Свойство("ПоказательНаработки"), Параметры.ПоказательНаработки, Неопределено));
		
	Запрос.УстановитьПараметр(
		"ПотребительНаработки",
		?(Параметры.Свойство("ПотребительНаработки"), Параметры.ПотребительНаработки, Неопределено));
	
	СписокОбъектовЭксплуатации.ЗагрузитьЗначения(Запрос.Выполнить().Выгрузить().ВыгрузитьКолонку("Ссылка"));
	
КонецПроцедуры

#КонецОбласти
