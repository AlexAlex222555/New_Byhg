
#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	Если Параметры.Свойство("АвтоТест") Тогда
	
		Возврат;
	
	КонецЕсли;
	
	ОбновлениеИнформационнойБазы.ПроверитьОбъектОбработан(Объект, ЭтотОбъект);
	
	Если НЕ ЗначениеЗаполнено(Объект.Ссылка) Тогда
		ПриЧтенииСозданииНаСервере();
	КонецЕсли;
	
	Если НЕ ПолучитьФункциональнуюОпцию("УправлениеПредприятием") Тогда
		
		Элементы.ИспользоватьДляПланированияМатериалов.Заголовок = НСтр("ru='Расчет потребностей в материалах и трудовых ресурсах';uk='Розрахунок потреб у матеріалах і трудових ресурсах'");
		
		Элементы.Календарь.Подсказка = НСтр("ru='Календарь работы, используемый для расчета дат запуска продукции, а так же сроков потребностей в материалах и трудовых ресурсах';uk='Календар роботи, який використовується для розрахунку дат запуску продукції, а так само термінів потреб в матеріалах і трудових ресурсах'");
		
	КонецЕсли;
	
	// СтандартныеПодсистемы.ЗапретРедактированияРеквизитовОбъектов
	ЗапретРедактированияРеквизитовОбъектов.ЗаблокироватьРеквизиты(ЭтотОбъект);
	// Конец СтандартныеПодсистемы.ЗапретРедактированияРеквизитовОбъектов
	
	// СтандартныеПодсистемы.ВерсионированиеОбъектов
	ВерсионированиеОбъектов.ПриСозданииНаСервере(ЭтотОбъект);
	// Конец СтандартныеПодсистемы.ВерсионированиеОбъектов
	
	СобытияФорм.ПриСозданииНаСервере(ЭтаФорма, Отказ, СтандартнаяОбработка);
						
КонецПроцедуры
 
&НаСервере
Процедура ПриЧтенииНаСервере(ТекущийОбъект)
	
	ПриЧтенииСозданииНаСервере();

	МодификацияКонфигурацииПереопределяемый.ПриЧтенииНаСервере(ЭтаФорма, ТекущийОбъект);

КонецПроцедуры

&НаСервере
Процедура ПриЧтенииСозданииНаСервере()
	
	ПланЗакупокПланировать = ?(Объект.ПланЗакупокПланироватьПоСумме, 1, 0);
	ПланПродажПланировать = ?(Объект.ПланПродажПланироватьПоСумме, 1, 0);
	
	ОтображениеПериода = ?(Объект.ОтображатьНомерПериода, 1, 0);
	
	ОбщегоНазначенияКлиентСервер.УстановитьЭлементОтбораДинамическогоСписка(
			СтруктураПланов,
			"Владелец",
			Объект.Ссылка,
			ВидСравненияКомпоновкиДанных.Равно,
			НСтр("ru='ОтборПоВладельцу';uk='ОтборПоВладельцу'"),
			Истина,
			РежимОтображенияЭлементаНастройкиКомпоновкиДанных.Недоступный);
	ОбщегоНазначенияКлиентСервер.УстановитьПараметрДинамическогоСписка(СтруктураПланов, "УправлениеПроцессомПланирования", Объект.УправлениеПроцессомПланирования);
	
	УстановитьВидимостьЭлементов();
	
	НастроитьЗависимыеЭлементыФормы(ЭтаФорма);
	
КонецПроцедуры 

&НаКлиенте
Процедура ПослеЗаписи(ПараметрыЗаписи)

	МодификацияКонфигурацииКлиентПереопределяемый.ПослеЗаписи(ЭтаФорма, ПараметрыЗаписи);

КонецПроцедуры

&НаСервере
Процедура ПередЗаписьюНаСервере(Отказ, ТекущийОбъект, ПараметрыЗаписи)

	МодификацияКонфигурацииПереопределяемый.ПередЗаписьюНаСервере(ЭтаФорма, Отказ, ТекущийОбъект, ПараметрыЗаписи);

КонецПроцедуры

&НаСервере
Процедура ПослеЗаписиНаСервере(ТекущийОбъект, ПараметрыЗаписи)
	
	ОбщегоНазначенияКлиентСервер.УстановитьЭлементОтбораДинамическогоСписка(
			СтруктураПланов,
			"Владелец",
			Объект.Ссылка,
			ВидСравненияКомпоновкиДанных.Равно,
			НСтр("ru='ОтборПоВладельцу';uk='ОтборПоВладельцу'"),
			Истина,
			РежимОтображенияЭлементаНастройкиКомпоновкиДанных.Недоступный);
		
	// СтандартныеПодсистемы.ЗапретРедактированияРеквизитовОбъектов
	ЗапретРедактированияРеквизитовОбъектов.ЗаблокироватьРеквизиты(ЭтотОбъект);
	// Конец СтандартныеПодсистемы.ЗапретРедактированияРеквизитовОбъектов
	
	МодификацияКонфигурацииПереопределяемый.ПослеЗаписиНаСервере(ЭтаФорма, ТекущийОбъект, ПараметрыЗаписи);

КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовШапкиФормы

&НаКлиенте
Процедура ПланироватьПриИзменении(Элемент)
	
	Объект.ПланЗакупокПланироватьПоСумме = ПланЗакупокПланировать = 1;
	Объект.ПланПродажПланироватьПоСумме = ПланПродажПланировать = 1;
	Если НЕ (Объект.ПланЗакупокПланироватьПоСумме ИЛИ Объект.ПланПродажПланироватьПоСумме)Тогда
		Объект.Валюта = Неопределено;
	КонецЕсли; 
	НастроитьЗависимыеЭлементыФормы(ЭтаФорма, "ПланЗакупокПланировать, ПланПродажПланировать");
	
КонецПроцедуры

&НаКлиенте
Процедура ПериодичностьПриИзменении(Элемент)
	
	Если Объект.Периодичность = ПредопределенноеЗначение("Перечисление.Периодичность.Год")
		ИЛИ Объект.Периодичность = ПредопределенноеЗначение("Перечисление.Периодичность.Декада") Тогда
	
		Объект.ОтображатьНомерПериода = Ложь;
		ОтображениеПериода = 0;
	
	КонецЕсли; 
	НастроитьЗависимыеЭлементыФормы(ЭтаФорма, "Периодичность");
	
КонецПроцедуры

&НаКлиенте
Процедура ОтображениеПериодаПриИзменении(Элемент)
	
	Объект.ОтображатьНомерПериода = ОтображениеПериода = 1;
	
КонецПроцедуры

&НаКлиенте
Процедура ИспользоватьДляПланированияМатериаловПриИзменении(Элемент)
	
	Если Объект.ИспользоватьДляПланированияМатериалов Тогда
		Объект.СпособРасчетаПотребностейВМатериалах = ПредопределенноеЗначение("Перечисление.СпособыРасчетаМатериалов.ВероятноеПотребление");
	Иначе
		Объект.Календарь = Неопределено;
		Объект.СпособРасчетаПотребностейВМатериалах = Неопределено;
	КонецЕсли;
	
	НастроитьЗависимыеЭлементыФормы(
		ЭтаФорма,
		"ИспользоватьДляПланированияМатериалов, СпособРасчетаПотребностейВМатериалах");

КонецПроцедуры

&НаКлиенте
Процедура ОтражаетсяВБюджетированииПриИзменении(Элемент)
	
	//++ НЕ УТ
	Если Не Объект.ОтражаетсяВБюджетировании Тогда
		Объект.СценарийБюджетирования = Неопределено
	КонецЕсли;
	НастроитьЗависимыеЭлементыФормы(ЭтаФорма, "ОтражаетсяВБюджетировании");
	//-- НЕ УТ
	
	Возврат // В УТ 11.1 код данного обработчика пустой
	
КонецПроцедуры

&НаКлиенте
Процедура СценарийБюджетированияНачалоВыбора(Элемент, ДанныеВыбора, СтандартнаяОбработка)
	
	//++ НЕ УТ
	МассивПараметров = Новый Массив;
	
	Если ЗначениеЗаполнено(Объект.Валюта) Тогда
		МассивПараметров.Добавить(Новый ПараметрВыбора("Отбор.Валюта", Объект.Валюта));
	КонецЕсли;
	
	Если ЗначениеЗаполнено(Объект.Периодичность) Тогда
		МассивПараметров.Добавить(Новый ПараметрВыбора("Отбор.Периодичность", Объект.Периодичность));
	КонецЕсли;
	
	МассивПараметров.Добавить(Новый ПараметрВыбора("Отбор.Предопределенный", Ложь));
	
	ФиксированныйМассивПараметров = Новый ФиксированныйМассив(МассивПараметров);
	Элементы.СценарийБюджетирования.ПараметрыВыбора = ФиксированныйМассивПараметров;
	//-- НЕ УТ
	
	Возврат // В УТ 11.1 код данного обработчика пустой
	
КонецПроцедуры 

&НаКлиенте
Процедура СпособРасчетаПотребностейВМатериалахПриИзменении(Элемент)
	
	НастроитьЗависимыеЭлементыФормы(ЭтаФорма, "СпособРасчетаПотребностейВМатериалах");
	
КонецПроцедуры

&НаКлиенте
Процедура УправлениеПроцессомПланированияПриИзменении(Элемент)
	ОбщегоНазначенияКлиентСервер.УстановитьПараметрДинамическогоСписка(СтруктураПланов, "УправлениеПроцессомПланирования", Объект.УправлениеПроцессомПланирования);
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

// СтандартныеПодсистемы.ЗапретРедактированияРеквизитовОбъектов
&НаКлиенте
Процедура Подключаемый_РазрешитьРедактированиеРеквизитовОбъекта(Команда)
	
	Оповещение = Новый ОписаниеОповещения("РазрешитьРедактированиеРеквизитовОбъектаЗавершение", ЭтотОбъект);
	ОбщегоНазначенияУТКлиент.РазрешитьРедактированиеРеквизитовОбъекта(ЭтаФорма,,Оповещение);
	
КонецПроцедуры
// Конец СтандартныеПодсистемы.ЗапретРедактированияРеквизитовОбъектов

&НаКлиенте
Процедура Подключаемый_ВыполнитьПереопределяемуюКоманду(Команда)
	
	СобытияФормКлиент.ВыполнитьПереопределяемуюКоманду(ЭтаФорма, Команда);
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаКлиенте
Процедура РазрешитьРедактированиеРеквизитовОбъектаЗавершение(Результат, ДополнительныеПараметры) Экспорт
	
	НастроитьЗависимыеЭлементыФормы(ЭтаФорма);
	
КонецПроцедуры

&НаСервере
Процедура УстановитьВидимостьЭлементов()
	
	ИспользоватьПланированиеЗакупок = ПолучитьФункциональнуюОпцию("ИспользоватьПланированиеЗакупок");
	ИспользоватьПланированиеПродаж = ПолучитьФункциональнуюОпцию("ИспользоватьПланированиеПродаж");
	ИспользоватьПланированиеСборкиРазборки = ПолучитьФункциональнуюОпцию("ИспользоватьПланированиеСборкиРазборки");
	ИспользоватьПланированиеВнутреннихПотреблений = ПолучитьФункциональнуюОпцию("ИспользоватьПланированиеВнутреннихПотреблений");
	ИспользоватьЗаказыПоставщикам = ПолучитьФункциональнуюОпцию("ИспользоватьЗаказыПоставщикам");
	ИспользоватьЗаказыНаСборку = ПолучитьФункциональнуюОпцию("ИспользоватьЗаказыНаСборку");
	ИспользоватьОбособленноеОбеспечениеЗаказов = ПолучитьФункциональнуюОпцию("ИспользоватьОбособленноеОбеспечениеЗаказов");
	
	Элементы.ГруппаПланировать.Видимость = (ИспользоватьПланированиеЗакупок ИЛИ ИспользоватьПланированиеПродаж);
	
	Элементы.ГруппаИспользоватьРасчетПоСкоростиПродаж.Видимость = ПолучитьФункциональнуюОпцию("ИспользоватьРейтингиПродажНоменклатуры")
		И ПолучитьФункциональнуюОпцию("ИспользоватьТоварныеКатегории")
		И ПолучитьФункциональнуюОпцию("ИспользоватьПланированиеПродажПоКатегориям");
		
	ИспользоватьПланированиеПроизводства = Ложь;
	//++ НЕ УТ
	ИспользоватьПланированиеПроизводства = ПолучитьФункциональнуюОпцию("ИспользоватьПланированиеПроизводства");
	//-- НЕ УТ
	ДоступноОписаниеВероятностиПримененияМатериалов = Ложь;
	//++ НЕ УТ
	ДоступноОписаниеВероятностиПримененияМатериалов = УправлениеДаннымиОбИзделиях.ДоступноОписаниеВероятностиПримененияМатериалов();
	//-- НЕ УТ	
	Элементы.ГруппаИспользоватьПланыМатериалов.Видимость = ИспользоватьПланированиеПроизводства;
	Элементы.ГруппаСпособРасчетаПотребностейВМатериалах.Видимость = ИспользоватьПланированиеПроизводства И ДоступноОписаниеВероятностиПримененияМатериалов;
	
	//++ НЕ УТ
	ПравоПросмотраСтатейБюджетов = ПравоДоступа("Просмотр", Метаданные.Справочники.СтатьиБюджетов);
	Элементы.ГруппаОтражатьВБюджетировании.Видимость = ПравоПросмотраСтатейБюджетов;
	//-- НЕ УТ
	
	Элементы.ГруппаОтражатьВБюджетировании.Видимость = Не ПолучитьФункциональнуюОпцию("УправлениеТорговлей");
	
	Элементы.ПланированиеПоНазначениям.Видимость = ИспользоватьОбособленноеОбеспечениеЗаказов;

	Элементы.СтруктураПлановСоздатьЭтап.Доступность = ПравоДоступа("Изменение", Метаданные.Справочники.ВидыПланов);
	
КонецПроцедуры 

&НаКлиентеНаСервереБезКонтекста
Процедура НастроитьЗависимыеЭлементыФормы(Форма, СписокРеквизитов = "")
	
	Объект = Форма.Объект;
	Элементы = Форма.Элементы;
	
	Инициализация = ПустаяСтрока(СписокРеквизитов);
	СтруктураРеквизитов = Новый Структура(СписокРеквизитов);
		
	Если СтруктураРеквизитов.Свойство("ПланЗакупокПланировать")
		ИЛИ СтруктураРеквизитов.Свойство("ПланПродажПланировать")
		ИЛИ Инициализация Тогда
		
		Элементы.Валюта.Доступность = (Объект.ПланЗакупокПланироватьПоСумме ИЛИ Объект.ПланПродажПланироватьПоСумме);
		
	КонецЕсли;
	
	//++ НЕ УТ
	
	Если СтруктураРеквизитов.Свойство("ИспользоватьДляПланированияМатериалов")
		ИЛИ Инициализация Тогда
		
		Элементы.СпособРасчетаПотребностейВМатериалах.Доступность = Объект.ИспользоватьДляПланированияМатериалов;
		Элементы.СпособРасчетаПотребностейВМатериалах.АвтоОтметкаНезаполненного = Объект.ИспользоватьДляПланированияМатериалов;
		Элементы.Календарь.Доступность = Объект.ИспользоватьДляПланированияМатериалов;
		
	КонецЕсли;
	
	Если СтруктураРеквизитов.Свойство("СпособРасчетаПотребностейВМатериалах")
		ИЛИ Инициализация Тогда
		
		ТекстПодсказки = "";
		Если Объект.СпособРасчетаПотребностейВМатериалах = ПредопределенноеЗначение("Перечисление.СпособыРасчетаМатериалов.ПустаяСсылка") Тогда
			ТекстПодсказки = "";
		ИначеЕсли Объект.СпособРасчетаПотребностейВМатериалах = ПредопределенноеЗначение("Перечисление.СпособыРасчетаМатериалов.ВероятноеПотребление") Тогда
			ТекстПодсказки = НСтр("ru='Основные и альтернативные материалы планируются с поправкой на вероятность применения.';uk='Основні і альтернативні матеріали плануються з поправкою на ймовірність застосування.'");
		ИначеЕсли Объект.СпособРасчетаПотребностейВМатериалах = ПредопределенноеЗначение("Перечисление.СпособыРасчетаМатериалов.МаксимальноеПотребление") Тогда
			ТекстПодсказки = НСтр("ru='Основные материалы планируются без поправки на вероятность применения, альтернативные с поправкой на вероятность.';uk='Основні матеріали плануються без поправки на ймовірність застосування, альтернативні з поправкою на ймовірність.'");
		ИначеЕсли Объект.СпособРасчетаПотребностейВМатериалах = ПредопределенноеЗначение("Перечисление.СпособыРасчетаМатериалов.МинимальноеПотребление") Тогда
			ТекстПодсказки = НСтр("ru='Основные материалы планируются без поправки на вероятность применения, альтернативные материалы не планируются.';uk='Основні матеріали плануються без поправки на ймовірність застосування, альтернативні матеріали не плануються.'");
		КонецЕсли;
		Элементы.ГруппаСпособРасчетаПотребностейВМатериалахПодсказка.Подсказка = ТекстПодсказки;
		
	КонецЕсли;
	
	Если СтруктураРеквизитов.Свойство("ОтражаетсяВБюджетировании")
		ИЛИ Инициализация Тогда
		
		Элементы.СценарийБюджетирования.Доступность = Объект.ОтражаетсяВБюджетировании;
		Элементы.СценарийБюджетирования.АвтоОтметкаНезаполненного = Объект.ОтражаетсяВБюджетировании;
		
	КонецЕсли;
	//-- НЕ УТ
	
	Если СтруктураРеквизитов.Свойство("Периодичность")
		ИЛИ Инициализация Тогда
		
		Если Объект.Периодичность = ПредопределенноеЗначение("Перечисление.Периодичность.Год")
			ИЛИ Объект.Периодичность = ПредопределенноеЗначение("Перечисление.Периодичность.Декада") Тогда
	        Элементы.ОтображениеПериода.Доступность = Ложь;
		Иначе
			Элементы.ОтображениеПериода.Доступность = Истина;
		КонецЕсли;
		
	КонецЕсли;
	
КонецПроцедуры

#Область СтруктураПланов

&НаКлиенте
Процедура СоздатьЭтап(Команда)
	
	Если Не ПроверитьЗаписатьСценарий() Тогда
		Возврат;
	КонецЕсли;
	
	ЗначенияЗаполнения = Новый Структура;
	ЗначенияЗаполнения.Вставить("Владелец", Объект.Ссылка);
	
	ПараметрыФормы = Новый Структура;
	ПараметрыФормы.Вставить("ЗначенияЗаполнения", ЗначенияЗаполнения);
	ПараметрыФормы.Вставить("ЭтоГруппа", Истина);
	ОткрытьФорму("Справочник.ВидыПланов.ФормаГруппы", ПараметрыФормы, Объект.Ссылка);
	
КонецПроцедуры

&НаКлиенте
Процедура ПовыситьПриоритет(Команда)
	
	ПередвинутьЭлемент(Элементы.СтруктураПланов.ТекущаяСтрока, Истина);
	Элементы.СтруктураПланов.Обновить()
	
КонецПроцедуры

&НаКлиенте
Процедура ПонизитьПриоритет(Команда)
	
	ПередвинутьЭлемент(Элементы.СтруктураПланов.ТекущаяСтрока, Ложь);
	Элементы.СтруктураПланов.Обновить()
	
КонецПроцедуры

&НаСервере
Процедура ПередвинутьЭлемент(СсылкаНаОбъект, Вверх)
	
	Если СсылкаНаОбъект = Неопределено Тогда
		
		Возврат;
		
	КонецЕсли;
	
	Запрос = Новый Запрос(
	"ВЫБРАТЬ РАЗРЕШЕННЫЕ ПЕРВЫЕ 1
	|	Т.Ссылка КАК Ссылка,
	|	ВЫБОР КОГДА &Вверх ТОГДА
	|		-Т.ПорядокПланирования
	|	ИНАЧЕ
	|		Т.ПорядокПланирования
	|	КОНЕЦ КАК ПорядокПланирования
	|ИЗ
	|	Справочник.ВидыПланов КАК Т
	|
	|ГДЕ
	|	ВЫБОР КОГДА &Вверх ТОГДА
	|		Т.ПорядокПланирования < &ПорядокПланирования
	|	ИНАЧЕ
	|		Т.ПорядокПланирования > &ПорядокПланирования
	|	КОНЕЦ
	|	И Т.Владелец = &Сценарий
	|	И Т.Родитель = &Родитель
	|
	|УПОРЯДОЧИТЬ ПО
	|	ПорядокПланирования");
	
	Запрос.УстановитьПараметр("Вверх", Вверх);
	Запрос.УстановитьПараметр("Сценарий", Объект.Ссылка);
	СтруктураПараметровВидаПлана = ОбщегоНазначения.ЗначенияРеквизитовОбъекта(СсылкаНаОбъект, "ПорядокПланирования, Родитель");
	Запрос.УстановитьПараметр("ПорядокПланирования", СтруктураПараметровВидаПлана.ПорядокПланирования);
	Запрос.УстановитьПараметр("Родитель", СтруктураПараметровВидаПлана.Родитель);
	
	Результат = Запрос.Выполнить();
	
	Выборка = Результат.Выбрать();
	
	Если Выборка.Количество() <> 1 Тогда
		
		Возврат;
		
	КонецЕсли;
	
	Выборка.Следующий();
	
	НачатьТранзакцию();

	Попытка
		
		ЗаблокироватьДанныеДляРедактирования(СсылкаНаОбъект);
		ЗаблокироватьДанныеДляРедактирования(Выборка.Ссылка);
		
		ПеремещаемыйЭлемент = СсылкаНаОбъект.ПолучитьОбъект(); // СправочникОбъект.ВидыПланов - 
		СоседнийЭлемент = Выборка.Ссылка.ПолучитьОбъект(); // СправочникОбъект.ВидыПланов - 
		
		Если ПеремещаемыйЭлемент.ПорядокПланирования = 0
			ИЛИ СоседнийЭлемент.ПорядокПланирования = 0 Тогда
			ОтменитьТранзакцию();
			Возврат;
		КонецЕсли;
		
		ПеремещаемыйЭлемент.ПорядокПланирования = ПеремещаемыйЭлемент.ПорядокПланирования + СоседнийЭлемент.ПорядокПланирования;
		СоседнийЭлемент.ПорядокПланирования     = ПеремещаемыйЭлемент.ПорядокПланирования - СоседнийЭлемент.ПорядокПланирования;
		ПеремещаемыйЭлемент.ПорядокПланирования = ПеремещаемыйЭлемент.ПорядокПланирования - СоседнийЭлемент.ПорядокПланирования;
	
		УстановитьПривилегированныйРежим(Истина);
	
		ПеремещаемыйЭлемент.Записать();
		СоседнийЭлемент.Записать();
		
		ЗафиксироватьТранзакцию();
		
	Исключение
		
		ОтменитьТранзакцию();
		ВызватьИсключение;
		
	КонецПопытки;
	
КонецПроцедуры

&НаКлиенте
Процедура СтруктураПлановПередНачаломДобавления(Элемент, Отказ, Копирование, Родитель, Группа, Параметр)
	
	Если Не ПроверитьЗаписатьСценарий() Тогда
		Отказ = Истина;
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Функция ПроверитьЗаписатьСценарий()
	
	Если НЕ ЗначениеЗаполнено(Объект.Ссылка) Тогда
		
		Оповещение = Новый ОписаниеОповещения("ПроверитьЗаписатьСценарийЗавершение", ЭтотОбъект);
		ТекстВопроса = НСтр("ru='Для настройки вида плана необходимо записать сценарий. Записать?';uk='Для настройки виду плану необхідно записати сценарій. Записати?'");
		Кнопки = Новый СписокЗначений;
		Кнопки.Добавить(КодВозвратаДиалога.Да, НСтр("ru='Записать и продолжить';uk='Записати й продовжити'"));
		Кнопки.Добавить(КодВозвратаДиалога.Отмена);
		
		ПоказатьВопрос(Оповещение, ТекстВопроса, Кнопки);
		Возврат Ложь;
	
	КонецЕсли;
	
	Возврат Истина;
	
КонецФункции

&НаКлиенте
Процедура ПроверитьЗаписатьСценарийЗавершение(Результат, ДополнительныеПараметры) Экспорт 
	
	Если Результат = КодВозвратаДиалога.Да Тогда
		Записать();
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#КонецОбласти



