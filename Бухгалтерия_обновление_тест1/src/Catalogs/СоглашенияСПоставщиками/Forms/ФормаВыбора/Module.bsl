
#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	Если Параметры.Свойство("АвтоТест") Тогда // Возврат при получении формы для анализа.
		Возврат;
	КонецЕсли;

	Список.Параметры.УстановитьЗначениеПараметра("ДатаДокумента", ?(ЗначениеЗаполнено(Параметры.ДатаДокумента), НачалоДня(Параметры.ДатаДокумента), НачалоДня(ТекущаяДатаСеанса())));
	Если Параметры.Отбор.Свойство("Партнер") Тогда
		Партнер = Параметры.Отбор.Партнер;
	КонецЕсли;
	Если Параметры.Отбор.Свойство("ХозяйственнаяОперация") Тогда
		ХозяйственнаяОперация = Параметры.Отбор.ХозяйственнаяОперация;
	Иначе
		ОбщегоНазначенияКлиентСервер.УстановитьЭлементОтбораДинамическогоСписка(Список, 
			"ХозяйственнаяОперация", 
			Перечисления.ХозяйственныеОперации.ОказаниеАгентскихУслуг, 
			ВидСравненияКомпоновкиДанных.НеРавно,, 
			Истина);
	КонецЕсли;
	
	// СтандартныеПодсистемы.ПодключаемыеКоманды
	ПодключаемыеКоманды.ПриСозданииНаСервере(ЭтотОбъект);
	// Конец СтандартныеПодсистемы.ПодключаемыеКоманды

	СобытияФорм.ПриСозданииНаСервере(ЭтаФорма, Отказ, СтандартнаяОбработка);

	ВерсионированиеОбъектов.ПриСозданииНаСервере(ЭтотОбъект);
	
	// ИнтеграцияС1СДокументооборотом
	ИнтеграцияС1СДокументооборот.ПриСозданииНаСервере(ЭтаФорма);
	// Конец ИнтеграцияС1СДокументооборотом
	
КонецПроцедуры

&НаСервере
Процедура ПриЗагрузкеДанныхИзНастроекНаСервере(Настройки)
	
	Менеджер      = Настройки.Получить("Менеджер");
	Организация   = Настройки.Получить("Организация");
	
	ОбщегоНазначенияКлиентСервер.УстановитьЭлементОтбораДинамическогоСписка(Список, "Менеджер", Менеджер, ВидСравненияКомпоновкиДанных.Равно,, ЗначениеЗаполнено(Менеджер));
	
	МассивОрганизаций = Новый Массив();
	МассивОрганизаций.Добавить(Организация);
	МассивОрганизаций.Добавить(ПредопределенноеЗначение("Справочник.Организации.ПустаяСсылка"));
	
	ОбщегоНазначенияКлиентСервер.УстановитьЭлементОтбораДинамическогоСписка(Список, "Организация", МассивОрганизаций, ВидСравненияКомпоновкиДанных.ВСписке,, ЗначениеЗаполнено(Организация));
	
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

#Область ОбработчикиСобытий

&НаКлиенте
Процедура ОрганизацияПриИзменении(Элемент)
	
	МассивОрганизаций = Новый Массив();
	МассивОрганизаций.Добавить(Организация);
	МассивОрганизаций.Добавить(ПредопределенноеЗначение("Справочник.Организации.ПустаяСсылка"));
	
	ОбщегоНазначенияКлиентСервер.УстановитьЭлементОтбораДинамическогоСписка(Список, "Организация", МассивОрганизаций, ВидСравненияКомпоновкиДанных.ВСписке,, ЗначениеЗаполнено(Организация));
	
КонецПроцедуры

&НаКлиенте
Процедура МенеджерПриИзменении(Элемент)
	
	ОбщегоНазначенияКлиентСервер.УстановитьЭлементОтбораДинамическогоСписка(Список, "Менеджер", Менеджер, ВидСравненияКомпоновкиДанных.Равно,, ЗначениеЗаполнено(Менеджер));
	
КонецПроцедуры

&НаКлиенте
Процедура СписокПередНачаломДобавления(Элемент, Отказ, Копирование, Родитель, Группа)
	
	Если Копирование Тогда
		Возврат;
	КонецЕсли;

	Отказ = Истина;
	
	ПараметрыОтбора = Новый Структура();
	ПараметрыОтбора.Вставить("Организация", Организация);
	ПараметрыОтбора.Вставить("Партнер", Партнер);
	Если ЗначениеЗаполнено(ХозяйственнаяОперация) Тогда
		ПараметрыОтбора.Вставить("ХозяйственнаяОперация", ХозяйственнаяОперация);
	КонецЕсли;
	
	ОткрытьФорму(
		"Справочник.СоглашенияСПоставщиками.ФормаОбъекта",
		Новый Структура("ЗначенияЗаполнения", ПараметрыОтбора),
		,
		,);
	
КонецПроцедуры

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

#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура Подключаемый_ВыполнитьПереопределяемуюКоманду(Команда)
	
	СобытияФормКлиент.ВыполнитьПереопределяемуюКоманду(ЭтаФорма, Команда);
	
КонецПроцедуры

// ИнтеграцияС1СДокументооборотом
&НаКлиенте
Процедура Подключаемый_ВыполнитьКомандуИнтеграции(Команда)
	
	ИнтеграцияС1СДокументооборотКлиент.ВыполнитьПодключаемуюКомандуИнтеграции(Команда, ЭтаФорма, Элементы.Список);
	
КонецПроцедуры
// Конец ИнтеграцияС1СДокументооборотом

#КонецОбласти

