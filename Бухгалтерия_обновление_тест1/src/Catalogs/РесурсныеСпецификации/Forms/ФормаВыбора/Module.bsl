
#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	УстановитьУсловноеОформление();
	
	Если Параметры.Свойство("АвтоТест") Тогда // Возврат при получении формы для анализа.
		Возврат;
	КонецЕсли;
	
	Параметры.Свойство("ОтборИзделие",            ОтборНоменклатура);
	Параметры.Свойство("ОтборИспользуетсяКак",    ОтборИспользуетсяКак);
	Параметры.Свойство("ОтборСписокСпецификаций", ОтборСписокСпецификаций);
	
	Параметры.Свойство("ПолучитьСпецификацииПоНоменклатуре", ПолучитьСпецификацииПоНоменклатуре);
	
	МассивСпецификаций = Новый Массив;
	Если Параметры.Свойство("МассивСпецификаций", МассивСпецификаций) Тогда
		СписокСпецификаций.ЗагрузитьЗначения(МассивСпецификаций);
	КонецЕсли;
	
	УстановитьСвойстваДинамическогоСписка();
	
	УстановитьОтборПоНоменклатуре();
	УстановитьОтборПоСтатусу(ЭтаФорма);
	УстановитьОтборПоСпискуСпецификаций(ЭтаФорма);
	
	НастроитьЭлементыФормы();
	
	// СтандартныеПодсистемы.ПодключаемыеКоманды
	ПодключаемыеКоманды.ПриСозданииНаСервере(ЭтотОбъект);
	// Конец СтандартныеПодсистемы.ПодключаемыеКоманды

	СобытияФорм.ПриСозданииНаСервере(ЭтаФорма, Отказ, СтандартнаяОбработка);

	ВерсионированиеОбъектов.ПриСозданииНаСервере(ЭтотОбъект);
	
	// ИнтеграцияС1СДокументооборотом
	ИнтеграцияС1СДокументооборот.ПриСозданииНаСервере(ЭтаФорма);
	// Конец ИнтеграцияС1СДокументооборотом
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовШапкиФормы

&НаКлиенте
Процедура ОтборНоменклатураПриИзменении(Элемент)
	
	УстановитьОтборПоНоменклатуре();
	
	НастроитьЗависимыеЭлементыФормы(ЭтаФорма, "Номенклатура");
	
КонецПроцедуры

&НаКлиенте
Процедура ОтборИспользуетсяКакПриИзменении(Элемент)
	
	УстановитьОтборПоНоменклатуре();
	
КонецПроцедуры

&НаКлиенте
Процедура ОтборСтатусПриИзменении(Элемент)
	
	УстановитьОтборПоСтатусу(ЭтаФорма);
	
КонецПроцедуры

&НаКлиенте
Процедура ОтборСписокСпецификацийПриИзменении(Элемент)
	
	УстановитьОтборПоСпискуСпецификаций(ЭтаФорма);

	НастроитьЗависимыеЭлементыФормы(ЭтаФорма, "ОтборСписокСпецификаций");
	
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

#Область СлужебныеПроцедурыИФункции

#Область Список

&НаСервере
Процедура УстановитьСвойстваДинамическогоСписка()
	
	СвойстваСписка = ОбщегоНазначения.СтруктураСвойствДинамическогоСписка();
	
	ТекстЗапроса = Справочники.РесурсныеСпецификации.ТекстЗапросаДинамическогоСпискаРесурсныхСпецификаций();
	СвойстваСписка.ТекстЗапроса = ТекстЗапроса;
	
	СвойстваСписка.ОсновнаяТаблица = Список.ОсновнаяТаблица;
	СвойстваСписка.ДинамическоеСчитываниеДанных = Истина;
	
	ОбщегоНазначения.УстановитьСвойстваДинамическогоСписка(Элементы.Список, СвойстваСписка);
	
КонецПроцедуры

#КонецОбласти

#Область Отборы

&НаКлиентеНаСервереБезКонтекста
Процедура УстановитьОтборПоСтатусу(Форма)
	
	ОбщегоНазначенияКлиентСервер.УстановитьЭлементОтбораДинамическогоСписка(
		Форма.Список, 
		"Статус", 
		Форма.ОтборСтатус, 
		ВидСравненияКомпоновкиДанных.Равно,
		, 
		ЗначениеЗаполнено(Форма.ОтборСтатус));
		
КонецПроцедуры

&НаСервере
Процедура УстановитьОтборПоНоменклатуре()

	УправлениеДаннымиОбИзделиях.УстановитьОтборПоНоменклатуреВСпискеСпецификаций(Список, ОтборНоменклатура, ОтборИспользуетсяКак);
	
КонецПроцедуры

&НаКлиентеНаСервереБезКонтекста
Процедура УстановитьОтборПоСпискуСпецификаций(Форма)
	
	СписокСпецификаций = Форма.СписокСпецификаций.ВыгрузитьЗначения();
	
	ОбщегоНазначенияКлиентСервер.УстановитьЭлементОтбораДинамическогоСписка(
		Форма.Список,
		"Ссылка",
		СписокСпецификаций,
		ВидСравненияКомпоновкиДанных.ВСписке,
		,
		Форма.ОтборСписокСпецификаций);
	
КонецПроцедуры

#КонецОбласти

#Область Прочее

&НаСервере
Процедура УстановитьУсловноеОформление()
	
	УсловноеОформление.Элементы.Очистить();
	
	Справочники.РесурсныеСпецификации.УстановитьУсловноеОформлениеСпискаРесурсныхСпецификаций(Список.УсловноеОформление);
	
КонецПроцедуры

&НаСервере
Процедура НастроитьЭлементыФормы()
	
	Элементы.ОтборСписокСпецификаций.Видимость = ОтборСписокСпецификаций;
	
	Если ПолучитьСпецификацииПоНоменклатуре Тогда
		Элементы.БыстрыеОтборы.Видимость = Ложь;
		АвтоЗаголовок = Ложь;
		Заголовок = СтрШаблон(НСтр("ru='Ресурсные спецификации %1';uk='Ресурсні специфікації %1'"), ОтборНоменклатура);
	КонецЕсли;
	
	НастроитьЗависимыеЭлементыФормы(ЭтаФорма);
	
КонецПроцедуры

&НаКлиентеНаСервереБезКонтекста
Процедура НастроитьЗависимыеЭлементыФормы(Форма, СписокРеквизитов = "")

	Элементы = Форма.Элементы;
	
	Инициализация = ПустаяСтрока(СписокРеквизитов);
	СтруктураРеквизитов = Новый Структура(СписокРеквизитов);
	
	Если СтруктураРеквизитов.Свойство("Номенклатура")
		ИЛИ Инициализация Тогда
		
		Элементы.ОтборИспользуетсяКак.ТолькоПросмотр = НЕ ЗначениеЗаполнено(Форма.ОтборНоменклатура);
		
	КонецЕсли;
	
	Если СтруктураРеквизитов.Свойство("ОтборСписокСпецификаций")
		ИЛИ Инициализация Тогда
		
		Элементы.Список.Отображение = ?(
			Форма.ОтборСписокСпецификаций ИЛИ Форма.ПолучитьСпецификацииПоНоменклатуре,
			ОтображениеТаблицы.Список,
			ОтображениеТаблицы.ИерархическийСписок);
		
	КонецЕсли;
	
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

#КонецОбласти

