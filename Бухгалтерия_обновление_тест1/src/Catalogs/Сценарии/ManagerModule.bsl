#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ПрограммныйИнтерфейс

// Возвращает имена блокируемых реквизитов для механизма блокирования реквизитов БСП.
// 
// Возвращаемое значение:
// 	Массив - имена блокируемых реквизитов:
//		* БлокируемыйРеквизит - Строка - Имя блокируемого реквизита.
//
Функция ПолучитьБлокируемыеРеквизитыОбъекта() Экспорт
	
	Результат = Новый Массив;
	
	Результат.Добавить("Периодичность");
	Результат.Добавить("Валюта");
	
	Возврат Результат;
	
КонецФункции

// Возвращает наименьшую из переданной периодичности и периодичностей сценариев
//
// Параметры:
//  Сценарий  - Массив - СправочникСсылка.Сценарии, сценарии для которых 
//						требуется сравнить периодичность.
//  Периодичность  - ПеречислениеСсылка.Периодичность - Периодичность, с которой требуется сравнить
//						периодичность сценариев.
//
// Возвращаемое значение:
// 	ПеречислениеСсылка.Периодичность - вычисленная периодичность.
//
Функция ПривестиПериодичностьКПериодичностиСценария(Сценарии, Периодичность) Экспорт
	
	ПериодичностиСценариев = ОбщегоНазначения.ЗначениеРеквизитаОбъектов(Сценарии, "Периодичность");
	ПериодичностиПоПорядку = Перечисления.Периодичность.УпорядоченныеПериодичности();
	
	ПериодичностьСценариев       = Перечисления.Периодичность.ПустаяСсылка();
	ИндексПериодичностиСценариев = 0;
	Для каждого Элемент Из ПериодичностиСценариев Цикл
		Индекс = ПериодичностиПоПорядку.Найти(Элемент.Значение);
		Если Индекс > ИндексПериодичностиСценариев Тогда
			ИндексПериодичностиСценариев = Индекс;
			ПериодичностьСценариев       = Элемент.Значение;
		КонецЕсли;
	КонецЦикла;
	
	Если Не ЗначениеЗаполнено(Периодичность) Тогда
		Периодичность = ПериодичностьСценариев;
	ИначеЕсли ИндексПериодичностиСценариев > ПериодичностиПоПорядку.Найти(Периодичность) Тогда 
		Периодичность = ПериодичностьСценариев;
	КонецЕсли;

	Возврат Периодичность;
	
КонецФункции

// Возвращает таблицу прогнозных курсов сценариев за выбранный период,
// дополненную начальными курсами.
//
// Параметры:
//  Сценарий 		 - Массив - СправочникСсылка.Сценарии, сценарии для которых 
//								требуется получить курсы.
//  Валюты 			 - Массив - Валюты, по которым требуется получить таблицу курсов,
//								если не указано - то по всем
//  ДатаНачала 		 - Дата - Дата начала курсов.
//  ДатаОкончания 	 - Дата - Дата окончания курсов.
//
// Возвращаемое значение:
// 	ТаблицаЗначений - таблица курсов.
//		* Сценарий - СправочникСсылка.Сценарии - Сценарий.
//      * Валюта - СправочникСсылка.Валюты - Валюта.
//		* Период - Дата - Период курса валют.
//		* Курс - Число - курс валюты.
//		* Кратность - Число - Кратность валюты.
//
Функция ТаблицаКурсовСценария(Сценарий = Неопределено, Валюты = Неопределено, ДатаНачала, ДатаОкончания) Экспорт
	
	Запрос = Новый Запрос(
	"ВЫБРАТЬ РАЗРЕШЕННЫЕ
	|	Сценарии.Ссылка КАК Сценарий,
	|	Сценарии.Ссылка КАК СценарийКурсов
	|ПОМЕСТИТЬ ФильтрПоСценариям
	|ИЗ
	|	Справочник.Сценарии КАК Сценарии
	|ГДЕ
	|	" + ?(Сценарий <> Неопределено, "Сценарии.Ссылка В(&Сценарий)
	|	И", "") + " НЕ Сценарии.ИспользоватьКурсыДругогоСценария
	|
	|ОБЪЕДИНИТЬ ВСЕ
	|
	|ВЫБРАТЬ
	|	Сценарии.Ссылка,
	|	Сценарии.СценарийКурсов
	|ИЗ
	|	Справочник.Сценарии КАК Сценарии
	|ГДЕ
	|	" + ?(Сценарий <> Неопределено, "Сценарии.Ссылка В(&Сценарий)
	|	И", "") + " Сценарии.ИспользоватьКурсыДругогоСценария
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ РАЗРЕШЕННЫЕ
	|	&НачалоПериода КАК Период,
	|	ПрогнозныеКурсыСценариев.Валюта КАК Валюта,
	|	ФильтрПоСценариям.Сценарий КАК Сценарий,
	|	ВЫБОР
	|		КОГДА ПрогнозныеКурсыСценариев.Кратность = 0
	|			ТОГДА 0
	|		ИНАЧЕ ПрогнозныеКурсыСценариев.Курс / ПрогнозныеКурсыСценариев.Кратность
	|	КОНЕЦ КАК Курс
	|ИЗ
	|	РегистрСведений.ПрогнозныеКурсыСценариев.СрезПоследних(
	|			&НачалоПериода,
	|			Сценарий В (ВЫБРАТЬ РАЗЛИЧНЫЕ Фильтр.СценарийКурсов ИЗ ФильтрПоСценариям КАК Фильтр)
	|			" + ?(Валюты <> Неопределено, "И Валюта В (&Валюты)", "") + "
	|			) КАК ПрогнозныеКурсыСценариев
	|		ВНУТРЕННЕЕ СОЕДИНЕНИЕ ФильтрПоСценариям КАК ФильтрПоСценариям
	|		ПО ПрогнозныеКурсыСценариев.Сценарий = ФильтрПоСценариям.СценарийКурсов
	|
	|ОБЪЕДИНИТЬ
	|
	|ВЫБРАТЬ
	|	ПрогнозныеКурсыСценариев.Период,
	|	ПрогнозныеКурсыСценариев.Валюта,
	|	ФильтрПоСценариям.Сценарий,
	|	ВЫБОР
	|		КОГДА ПрогнозныеКурсыСценариев.Кратность = 0
	|			ТОГДА 0
	|		ИНАЧЕ ПрогнозныеКурсыСценариев.Курс / ПрогнозныеКурсыСценариев.Кратность
	|	КОНЕЦ КАК Курс
	|ИЗ
	|	ФильтрПоСценариям КАК ФильтрПоСценариям
	|		ВНУТРЕННЕЕ СОЕДИНЕНИЕ РегистрСведений.ПрогнозныеКурсыСценариев КАК ПрогнозныеКурсыСценариев
	|		ПО (ПрогнозныеКурсыСценариев.Период МЕЖДУ &НачалоПериода И &КонецПериода)
	|			И (ПрогнозныеКурсыСценариев.Сценарий = ФильтрПоСценариям.СценарийКурсов)
	|			" + ?(Валюты <> Неопределено, "И ПрогнозныеКурсыСценариев.Валюта В (&Валюты)", "")
	);
	
	Запрос.УстановитьПараметр("Валюты", Валюты);
	
	Запрос.УстановитьПараметр("Сценарий", Сценарий);
	Запрос.УстановитьПараметр("НачалоПериода", ДатаНачала);
	Запрос.УстановитьПараметр("КонецПериода", ДатаОкончания);
	
	Возврат Запрос.Выполнить().Выгрузить();
	
КонецФункции

// Возвращает таблицу, содержащую информацию о незаполненных курсах сценариев. 
//
// Параметры:
//  Сценарий 		 - Массив - СправочникСсылка.Сценарии, сценарии, для которых необходимо выполнить проверку заполнения курсов.
//  Валюты 			 - Массив - Валюты, по которым необходимо выполнить проверку заполнения курсов.
//  ДатаНачала 		 - Дата - Начало периода проверки.
//  ДатаОкончания 	 - Дата - Окончание периода проверки.
//
// Возвращаемое значение:
// 	ТаблицаЗначений - таблица незаполненных курсов.
//		* Сценарий - СправочникСсылка.Сценарии - Сценарий.
//      * Валюта - СправочникСсылка.Валюты - Валюта.
//		* Период - Дата - Период курса валют.
//
Функция ПроверитьЗаполнениеКурсовСценариев(Сценарии, Валюты, ДатаНачала, ДатаОкончания) Экспорт
	
	ПериодичностиСценариев = ОбщегоНазначения.ЗначениеРеквизитаОбъектов(Сценарии, "Периодичность");
	КурсыСценариев = Справочники.Сценарии.ТаблицаКурсовСценария(Сценарии, Валюты, ДатаНачала, ДатаОкончания);
	КурсыСценариев.Индексы.Добавить("Сценарий, Валюта, Период");
	
	НезаполненныеКурсы = КурсыСценариев.СкопироватьКолонки("Сценарий, Валюта, Период");
	
	Для каждого Сценарий Из Сценарии Цикл
		Периоды = БюджетнаяОтчетностьВыводСервер.ПериодыБюджетногоОтчета(ДатаНачала, ДатаОкончания, ПериодичностиСценариев[Сценарий]);
		Для каждого Период Из Периоды Цикл
			Для каждого Валюта Из Валюты Цикл
				СтруктураПоиска = Новый Структура("Сценарий, Валюта, Период", Сценарий, Валюта, Период);
				Если КурсыСценариев.НайтиСтроки(СтруктураПоиска).Количество() = 0 Тогда
					НоваяСтрока = НезаполненныеКурсы.Добавить();
					ЗаполнитьЗначенияСвойств(НоваяСтрока, СтруктураПоиска);
				КонецЕсли;
			КонецЦикла;
		КонецЦикла;
	КонецЦикла;
	
	Возврат НезаполненныеКурсы;
	
КонецФункции


#Область ДляВызоваИзДругихПодсистем

// СтандартныеПодсистемы.УправлениеДоступом

// См. УправлениеДоступомПереопределяемый.ПриЗаполненииСписковСОграничениемДоступа.
Процедура ПриЗаполненииОграниченияДоступа(Ограничение) Экспорт

	Ограничение.Текст =
	"РазрешитьЧтениеИзменение
	|ГДЕ
	|	ЭтоГруппа ИЛИ
	|	ЗначениеРазрешено(Ссылка)";

КонецПроцедуры

// Конец СтандартныеПодсистемы.УправлениеДоступом

#КонецОбласти

#КонецОбласти


#Область ОбновлениеИнформационнойБазы

//++ НЕ УТ

// Добавляет в список процедуры-обработчики обновления данных ИБ
// для всех поддерживаемых версий библиотеки или конфигурации.
// Вызывается перед началом обновления данных ИБ для построения плана обновления.
//
//  Обработчики - ТаблицаЗначений - описание полей, см. в процедуре
//                ОбновлениеИнформационнойБазы.НоваяТаблицаОбработчиковОбновления.
//
// Пример добавления процедуры-обработчика в список:
//  Обработчик = Обработчики.Добавить();
//  Обработчик.Версия              = "1.1.0.0";
//  Обработчик.Процедура           = "ОбновлениеИБ.ПерейтиНаВерсию_1_1_0_0";
//  Обработчик.МонопольныйРежим    = Ложь;
//
// Параметры:
// 	Обработчики - см. ОбновлениеИнформационнойБазы.НоваяТаблицаОбработчиковОбновления
//
Процедура ОписаниеОбработчиковОбновления(Обработчики) Экспорт
	
	Обработчик = Обработчики.Добавить();
	Обработчик.Версия = "2.5.4.400";
	Обработчик.РежимВыполнения = "Монопольно";
	Обработчик.Идентификатор = Новый УникальныйИдентификатор("a0b62521-7353-45f0-a60f-eab28c85ad58");	
	Обработчик.Процедура = "Справочники.Сценарии.ОбработатьДанныеДляПереходаНаНовуюВерсию";
	Обработчик.ЧитаемыеОбъекты = "Справочник.Сценарии";
	Обработчик.ИзменяемыеОбъекты = "Справочник.Сценарии";
	Обработчик.Комментарий = НСтр("ru='Очищает валюту в предопределенных сценариях ""Фактические данные"" и ""Исполнение бюджета""';uk='Очищає валюту у напередвизначених сценаріях ""Фактичні дані"" та ""Виконання бюджету""'");

КонецПроцедуры

// Обработчик обновления КА.
// Очищает валюту в предопределенных сценариях Фактические данные и Исполнение бюджета
//
Процедура ОбработатьДанныеДляПереходаНаНовуюВерсию() Экспорт
	
	Если ЗначениеЗаполнено(Справочники.Сценарии.ФактическиеДанные.Валюта) Тогда
		Объект = Справочники.Сценарии.ФактическиеДанные.ПолучитьОбъект();
		Объект.Валюта = Неопределено;
		ОбновлениеИнформационнойБазы.ЗаписатьДанные(Объект);
	КонецЕсли;
	
	Если ЗначениеЗаполнено(Справочники.Сценарии.ИсполнениеБюджета.Валюта) Тогда
		Объект = Справочники.Сценарии.ИсполнениеБюджета.ПолучитьОбъект();
		Объект.Валюта = Неопределено;
		ОбновлениеИнформационнойБазы.ЗаписатьДанные(Объект);
	КонецЕсли;
	
КонецПроцедуры

//-- НЕ УТ

#КонецОбласти


#КонецЕсли

#Область ОбработчикиСобытий

Процедура ОбработкаПолученияДанныхВыбора(ДанныеВыбора, Параметры, СтандартнаяОбработка)
	
	БюджетнаяОтчетностьВызовСервера.СценарииСФильтром(ДанныеВыбора, Параметры, СтандартнаяОбработка);
	
КонецПроцедуры

#КонецОбласти

