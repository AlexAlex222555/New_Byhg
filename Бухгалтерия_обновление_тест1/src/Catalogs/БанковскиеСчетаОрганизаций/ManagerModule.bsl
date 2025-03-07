#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ПрограммныйИнтерфейс

// Функция определяет банковский счет выбранной организации.
//
// Возвращает банковский счет организации, если найден один банковский счет.
// Возвращает Неопределено, если банковский счет не найден или счетов больше одного.
//
// Параметры:
//  Организация - СправочникСсылка.Организации - Ссылка на организацию
//	Валюта - СправочникСсылка.Валюты - Валюта банковского счета.
//
// Возвращаемое значение:
//	СправочникСсылка.БанковскиеСчетаОрганизаций - Найденный банковский счет организации.
//
Функция ПолучитьБанковскийСчетОрганизацииПоУмолчанию(Организация, Валюта = Неопределено, НаправлениеДеятельности = Неопределено) Экспорт
	
	Запрос = Новый Запрос("
	|ВЫБРАТЬ РАЗРЕШЕННЫЕ ПЕРВЫЕ 2
	|	БанковскиеСчетаОрганизаций.Ссылка КАК БанковскийСчетОрганизации
	|ИЗ
	|	Справочник.БанковскиеСчетаОрганизаций КАК БанковскиеСчетаОрганизаций
	|ГДЕ
	|	НЕ БанковскиеСчетаОрганизаций.ПометкаУдаления
	|	И НЕ БанковскиеСчетаОрганизаций.Закрыт
	|	И (БанковскиеСчетаОрганизаций.Владелец = &Организация
	|		ИЛИ &Организация = Неопределено)
	|	И (БанковскиеСчетаОрганизаций.ВалютаДенежныхСредств = &Валюта
	|		ИЛИ &Валюта = Неопределено)
	|	И (БанковскиеСчетаОрганизаций.НаправлениеДеятельности = &НаправлениеДеятельности
	|			ИЛИ &НаправлениеДеятельности = НЕОПРЕДЕЛЕНО);
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ РАЗРЕШЕННЫЕ ПЕРВЫЕ 2
	|	БанковскиеСчетаОрганизаций.Ссылка КАК БанковскийСчетОрганизации
	|ИЗ
	|	Справочник.БанковскиеСчетаОрганизаций КАК БанковскиеСчетаОрганизаций
	|ГДЕ
	|	НЕ БанковскиеСчетаОрганизаций.ПометкаУдаления
	|	И НЕ БанковскиеСчетаОрганизаций.Закрыт
	|	И (БанковскиеСчетаОрганизаций.Владелец = &Организация
	|		ИЛИ &Организация = Неопределено)
	|	И (БанковскиеСчетаОрганизаций.ВалютаДенежныхСредств = &Валюта
	|		ИЛИ &Валюта = Неопределено)
	|");
	
	Запрос.УстановитьПараметр("Организация", ?(ЗначениеЗаполнено(Организация), Организация, Неопределено));
	Запрос.УстановитьПараметр("Валюта", ?(ЗначениеЗаполнено(Валюта), Валюта, Неопределено));
	Запрос.УстановитьПараметр("НаправлениеДеятельности", ?(ЗначениеЗаполнено(НаправлениеДеятельности), НаправлениеДеятельности, Неопределено));
	
	Результат = Запрос.ВыполнитьПакет();
	ВыборкаПоНаправлению  = Результат[0].Выбрать();
	ВыборкаБезНаправления = Результат[1].Выбрать();
	
	Если ВыборкаПоНаправлению.Количество() = 1 И ВыборкаПоНаправлению.Следующий() Тогда
		
		БанковскийСчетОрганизации = ВыборкаПоНаправлению.БанковскийСчетОрганизации;
		
	ИначеЕсли ВыборкаБезНаправления.Количество() = 1 И ВыборкаБезНаправления.Следующий() Тогда
		
		БанковскийСчетОрганизации = ВыборкаБезНаправления.БанковскийСчетОрганизации;
		
	Иначе
		
		БанковскийСчетОрганизации = Справочники.БанковскиеСчетаОрганизаций.ПустаяСсылка();
		
	КонецЕсли;
	
	Возврат БанковскийСчетОрганизации;

КонецФункции

// Функция определяет организацию и валюту выбранного банковского счета.
//
// Параметры:
//  БанковскийСчет - СправочникСсылка.БанковскиеСчетаОрганизаций - Ссылка на банковский счет.
//
// Возвращаемое значение:
//	Структура - Организация и реквизиты банковского счета организации.
//
Функция ПолучитьРеквизитыБанковскогоСчетаОрганизации(БанковскийСчет) Экспорт
	
	Запрос = Новый Запрос;
	Запрос.Текст = "
	|ВЫБРАТЬ РАЗРЕШЕННЫЕ
	|	БанковскиеСчета.Владелец                          КАК Организация,
	|	БанковскиеСчета.ВалютаДенежныхСредств             КАК Валюта,
	|	БанковскиеСчета.РазрешитьПлатежиБезУказанияЗаявок КАК РазрешитьПлатежиБезУказанияЗаявок,
	|	БанковскиеСчета.НомерСчета                        КАК НомерСчета,
	|	БанковскиеСчета.НомерСчетаУстаревший 			  КАК НомерСчетаУстаревший,
	|	ВЫБОР
	|		КОГДА БанковскиеСчета.РучноеИзменениеРеквизитовБанка
	|			ТОГДА 
	|				ВЫБОР
	|					КОГДА БанковскиеСчета.НаименованиеБанка = """"
	|						ТОГДА БанковскиеСчета.НаименованиеБанкаМеждународное
	|					ИНАЧЕ БанковскиеСчета.НаименованиеБанка
	|				КОНЕЦ
	|		ИНАЧЕ БанковскиеСчета.Банк
	|	КОНЕЦ КАК Банк,
	|	ВЫБОР
	|		КОГДА БанковскиеСчета.РучноеИзменениеРеквизитовБанка
	|			ТОГДА БанковскиеСчета.НаименованиеБанка
	|		ИНАЧЕ БанковскиеСчета.Банк.Наименование
	|	КОНЕЦ КАК НаименованиеБанка,
	|	ВЫБОР
	|		КОГДА БанковскиеСчета.РучноеИзменениеРеквизитовБанка
	|			ТОГДА БанковскиеСчета.КодБанка
	|		ИНАЧЕ БанковскиеСчета.Банк.Код
	|	КОНЕЦ КАК МФО,
	|	ВЫБОР
	|		КОГДА БанковскиеСчета.РучноеИзменениеРеквизитовБанка
	|			ТОГДА БанковскиеСчета.АдресБанка
	|		ИНАЧЕ БанковскиеСчета.Банк.Адрес
	|	КОНЕЦ КАК АдресБанка
	|ИЗ
	|	Справочник.БанковскиеСчетаОрганизаций КАК БанковскиеСчета
	|ГДЕ
	|	БанковскиеСчета.Ссылка = &БанковскийСчет
	|";
	
	Запрос.УстановитьПараметр("БанковскийСчет", БанковскийСчет);
	
	РеквизитыСчета = Новый Структура;
	РеквизитыСчета.Вставить("Организация", Неопределено);
	РеквизитыСчета.Вставить("Валюта", Неопределено);
	РеквизитыСчета.Вставить("РазрешитьПлатежиБезУказанияЗаявок", Ложь);
	РеквизитыСчета.Вставить("НомерСчета", "");
	РеквизитыСчета.Вставить("НомерСчетаУстаревший", "");
	РеквизитыСчета.Вставить("Банк", Неопределено);
	РеквизитыСчета.Вставить("НаименованиеБанка", "");
	РеквизитыСчета.Вставить("МФО", "");
	РеквизитыСчета.Вставить("АдресБанка", "");
	
	Выборка = Запрос.Выполнить().Выбрать();
	Если Выборка.Следующий() Тогда
		ЗаполнитьЗначенияСвойств(РеквизитыСчета, Выборка);
	КонецЕсли;
	
	Возврат РеквизитыСчета;
	
КонецФункции

// Функция файл выгрузки по умолчанию для всех счетов банка
//
// Возвращает найденный путь файла выгрузки банка, если найден один банковский счет.
// Возвращает Неопределено, если банковский счет не найден или счетов больше одного.
//
// Параметры:
//    Банк - СправочникСсылка.КлассификаторБанков - Ссылка на банк банковского счета.
//
// Возвращаемое значение:
//    Строка - Найденный путь файла выгрузки банка.
//
Функция ФайлВыгрузкиПоУмолчанию(Банк) Экспорт
	
	ФайлВыгрузкиПоУмолчанию = Неопределено;
	
	Запрос = Новый Запрос("ВЫБРАТЬ РАЗРЕШЕННЫЕ ПЕРВЫЕ 2
	|	БанковскиеСчетаОрганизаций.ФайлВыгрузки КАК ФайлВыгрузки
	|ИЗ
	|	Справочник.БанковскиеСчетаОрганизаций КАК БанковскиеСчетаОрганизаций
	|ГДЕ
	|	НЕ БанковскиеСчетаОрганизаций.ПометкаУдаления
	|	И БанковскиеСчетаОрганизаций.Банк = &Банк
	|
	|СГРУППИРОВАТЬ ПО
	|	БанковскиеСчетаОрганизаций.ФайлВыгрузки");
	
	Запрос.УстановитьПараметр("Банк", Банк);
	
	Выборка = Запрос.Выполнить().Выбрать();
	Если Выборка.Количество() = 1 И Выборка.Следующий() Тогда
		ФайлВыгрузкиПоУмолчанию = Выборка.ФайлВыгрузки;
	КонецЕсли;
	
	Возврат ФайлВыгрузкиПоУмолчанию;
	
КонецФункции

// Функция файл загрузки по умолчанию для всех счетов банка
//
// Возвращает найденный путь файла загрузки банка, если найден один банковский счет.
// Возвращает Неопределено, если банковский счет не найден или счетов больше одного.
//
// Параметры:
//    Банк - СправочникСсылка.КлассификаторБанков - Ссылка на банк банковского счета.
//
// Возвращаемое значение:
//    Строка - Найденный путь файла загрузки банка.
//
Функция ФайлЗагрузкиПоУмолчанию(Банк) Экспорт
	
	ФайлЗагрузкиПоУмолчанию = Неопределено;
	
	Запрос = Новый Запрос("ВЫБРАТЬ РАЗРЕШЕННЫЕ ПЕРВЫЕ 2
	|	БанковскиеСчетаОрганизаций.ФайлЗагрузки КАК ФайлЗагрузки
	|ИЗ
	|	Справочник.БанковскиеСчетаОрганизаций КАК БанковскиеСчетаОрганизаций
	|ГДЕ
	|	НЕ БанковскиеСчетаОрганизаций.ПометкаУдаления
	|	И БанковскиеСчетаОрганизаций.Банк = &Банк
	|
	|СГРУППИРОВАТЬ ПО
	|	БанковскиеСчетаОрганизаций.ФайлЗагрузки");
	
	Запрос.УстановитьПараметр("Банк", Банк);
	
	Выборка = Запрос.Выполнить().Выбрать();
	Если Выборка.Количество() = 1 И Выборка.Следующий() Тогда
		ФайлЗагрузкиПоУмолчанию = Выборка.ФайлЗагрузки;
	КонецЕсли;
	
	Возврат ФайлЗагрузкиПоУмолчанию;
	
КонецФункции

// Определяет свойства полей формы в зависимости от данных
//
// Возвращаемое значение:
//    ТаблицаЗначений - таблица с колонками Поля, Условие, Свойства.
//
Функция НастройкиПолейФормы() Экспорт
	
	Финансы = ФинансоваяОтчетностьСервер;
	Настройки = ДенежныеСредстваСервер.ИнициализироватьНастройкиПолейФормы();
	
	// Шапка
	Элемент = Настройки.Добавить();
	Элемент.Поля.Добавить("Владелец");
	Финансы.НовыйОтбор(Элемент.Условие, "Дополнительно.ИспользоватьНесколькоОрганизаций", Истина);
	Элемент.Свойства.Вставить("Видимость");
	
	Элемент = Настройки.Добавить();
	Элемент.Поля.Добавить("ИностранныйБанк");
	Финансы.НовыйОтбор(Элемент.Условие, "Дополнительно.ИспользоватьНесколькоВалют", Истина);
	Элемент.Свойства.Вставить("Видимость");
	
	// Обмен с банком
	Элемент = Настройки.Добавить();
	Элемент.Поля.Добавить("ФайлВыгрузки");
	Элемент.Поля.Добавить("ФайлЗагрузки");
	Элемент.Поля.Добавить("Кодировка");
	Финансы.НовыйОтбор(Элемент.Условие, "ОбменСБанкомВключен", Истина);
	Финансы.НовыйОтбор(Элемент.Условие, "ИспользоватьОбменСБанком", Истина);
	Элемент.Свойства.Вставить("Видимость");
	
	ДенежныеСредстваСервер.НастройкиЭлементовБанков(Настройки);
	
	Возврат Настройки;
	
КонецФункции

#Область ДляВызоваИзДругихПодсистем

//++ НЕ УТ
// Заполняет реквизиты параметров настройки счетов учета расходов, которые влияют на настройку,
// 	соответствующими им именам реквизитов аналитики учета.
//
// Параметры:
// 	СоответствиеИмен - Соответствие - ключом выступает имя реквизита, используемое в настройке счетов учета,
// 		значением является соответствующее имя реквизита аналитики учета.
// 
Процедура ЗаполнитьСоответствиеРеквизитовНастройкиСчетовУчета(СоответствиеИмен) Экспорт
	
	СоответствиеИмен.ВалютаДенежныхСредств = "ВалютаДенежныхСредств";
	СоответствиеИмен.АналитикаДенежныхСредств = "Ссылка";
	СоответствиеИмен.Организация = "Владелец";
	
КонецПроцедуры
//-- НЕ УТ

// СтандартныеПодсистемы.УправлениеДоступом

// См. УправлениеДоступомПереопределяемый.ПриЗаполненииСписковСОграничениемДоступа.
Процедура ПриЗаполненииОграниченияДоступа(Ограничение) Экспорт

	Ограничение.Текст =
	"РазрешитьЧтениеИзменение
	|ГДЕ
	|	ЗначениеРазрешено(Владелец)";

КонецПроцедуры
// Конец СтандартныеПодсистемы.УправлениеДоступом

#КонецОбласти

#КонецОбласти

#КонецЕсли

#Область ОбработчикиСобытий

Процедура ОбработкаПолученияДанныхВыбора(ДанныеВыбора, Параметры, СтандартнаяОбработка)
	
	Если Параметры.Свойство("ВыборСчетовГоловнойОрганизации") Тогда
		
		Если Не ПолучитьФункциональнуюОпцию("ИспользоватьОбособленныеПодразделенияВыделенныеНаБаланс") Тогда
			Возврат;
		КонецЕсли;
		
		Организация = Неопределено;
		Параметры.Отбор.Свойство("Владелец", Организация);
		
		Если Не ЗначениеЗаполнено(Организация)
			Или Не ОбщегоНазначенияУТВызовСервера.ЗначениеРеквизитаОбъекта(Организация, "ОбособленноеПодразделение") Тогда
			Возврат;
		КонецЕсли;
		
		ХозяйственнаяОперация = Неопределено;
		Если Параметры.Свойство("ХозяйственнаяОперация", ХозяйственнаяОперация) Тогда
			
			Если ХозяйственнаяОперация = Перечисления.ХозяйственныеОперации.РеализацияКлиенту
				Или ХозяйственнаяОперация = Перечисления.ХозяйственныеОперации.ПередачаНаКомиссию Тогда
				ЕстьРасчетыСКлиентами = Истина;
			Иначе
				ЕстьРасчетыСКлиентами = Ложь;
			КонецЕсли;
			
			ЕстьРасчетыСПоставщиками = Не ЕстьРасчетыСКлиентами;
			
		Иначе
		
			ЕстьРасчетыСКлиентами = Параметры.Свойство("ЕстьРасчетыСКлиентами");
			ЕстьРасчетыСПоставщиками = Параметры.Свойство("ЕстьРасчетыСПоставщиками");
			
		КонецЕсли;
		
		СтандартнаяОбработка = Ложь;
		Запрос = Новый Запрос("ВЫБРАТЬ
		|	&Организация
		|ПОМЕСТИТЬ ДоступныеОрганизации
		|
		|ОБЪЕДИНИТЬ ВСЕ
		|
		|ВЫБРАТЬ
		|	Организации.ГоловнаяОрганизация
		|ИЗ
		|	Справочник.Организации КАК Организации
		|ГДЕ
		|	Организации.Ссылка = &Организация
		|	И Организации.ДопускаютсяВзаиморасчетыЧерезГоловнуюОрганизацию
		|	И (&ЕстьРасчетыСКлиентами ИЛИ &ЕстьРасчетыСПоставщиками)
		|;
		|
		|////////////////////////////////////////////////////////////////////////////////
		|ВЫБРАТЬ РАЗРЕШЕННЫЕ
		|	БанковскиеСчетаОрганизаций.Ссылка,
		|	БанковскиеСчетаОрганизаций.Наименование,
		|	БанковскиеСчетаОрганизаций.Владелец
		|ПОМЕСТИТЬ Данные
		|ИЗ
		|	ДоступныеОрганизации КАК ДоступныеОрганизации
		|		ВНУТРЕННЕЕ СОЕДИНЕНИЕ Справочник.БанковскиеСчетаОрганизаций КАК БанковскиеСчетаОрганизаций
		|		ПО ДоступныеОрганизации.Организация = БанковскиеСчетаОрганизаций.Владелец
		|;
		|
		|////////////////////////////////////////////////////////////////////////////////
		|ВЫБРАТЬ
		|	Данные.Ссылка
		|ИЗ
		|	Данные КАК Данные
		|ГДЕ
		|	&УсловиеПоискаПоСтроке И &ПрочиеУсловия
		|
		|УПОРЯДОЧИТЬ ПО
		|	Данные.Владелец,
		|	Данные.Наименование
		|АВТОУПОРЯДОЧИВАНИЕ");
		Запрос.УстановитьПараметр("Организация", Организация);
		Запрос.УстановитьПараметр("ЕстьРасчетыСКлиентами", ЕстьРасчетыСКлиентами);
		Запрос.УстановитьПараметр("ЕстьРасчетыСПоставщиками", ЕстьРасчетыСПоставщиками);
		
	КонецЕсли;
	
	Если Не СтандартнаяОбработка Тогда
		
		Запрос.Текст = СтрЗаменить(Запрос.Текст, "&УсловиеПоискаПоСтроке", "Данные.Наименование ПОДОБНО &СтрокаПоиска");
		Запрос.УстановитьПараметр("СтрокаПоиска", ?(Параметры.СтрокаПоиска = Неопределено, "", Параметры.СтрокаПоиска) + "%");
		
		ПрочиеУсловия = "";
		Для Каждого Элемент Из Параметры.Отбор Цикл
			
			Если Элемент.Ключ = "Владелец" И Параметры.Свойство("ВыборСчетовГоловнойОрганизации") Тогда
				Продолжить;
			Иначе
				
				ПрочиеУсловия = ПрочиеУсловия + "Данные.Ссылка." + Элемент.Ключ 
					+ ?(ТипЗнч(Элемент.Значение) = Тип("ФиксированныйМассив"), " В (&", " = (&") 
					+ Элемент.Ключ + ") И ";
				Запрос.УстановитьПараметр(Элемент.Ключ, Элемент.Значение);
				
			КонецЕсли;
			
		КонецЦикла;
		
		Если ПрочиеУсловия = "" Тогда
			ПрочиеУсловия = "Истина";
		Иначе
			ПрочиеУсловия = Лев(ПрочиеУсловия, СтрДлина(ПрочиеУсловия) - 3);
		КонецЕсли;
			
		Запрос.Текст = СтрЗаменить(Запрос.Текст, "&ПрочиеУсловия", ПрочиеУсловия);
		
		ДанныеВыбора = Новый СписокЗначений;
		ДанныеВыбора.ЗагрузитьЗначения(Запрос.Выполнить().Выгрузить().ВыгрузитьКолонку("Ссылка"));
		
	КонецЕсли;
	
КонецПроцедуры

Процедура ОбработкаПолученияФормы(ВидФормы, Параметры, ВыбраннаяФорма, ДополнительнаяИнформация, СтандартнаяОбработка)
	
	Если ВидФормы = "ФормаСписка" И Не ПолучитьФункциональнуюОпцию("ИспользоватьНесколькоРасчетныхСчетов") Тогда
		Параметры.Вставить("Ключ", ОбщегоНазначенияУТВызовСервера.БанковскийСчетОрганизацииПоУмолчанию());
		ВыбраннаяФорма = "ФормаЭлемента";
		СтандартнаяОбработка = Ложь;
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область СлужебныеПроцедурыИФункции

Функция ПолучитьБлокируемыеРеквизитыОбъекта() Экспорт
	
	Результат = Новый Массив;
	
	Результат.Добавить("ВалютаДенежныхСредств");
	Результат.Добавить("Владелец");
	Результат.Добавить("ИностранныйБанк; ИностранныйБанк");
	//++ НЕ УТ
	Результат.Добавить("СчетУчета");
	//-- НЕ УТ
	Возврат Результат;
	
КонецФункции

#КонецОбласти

#Область ОбновлениеИнформационнойБазы

#КонецОбласти

#КонецЕсли
