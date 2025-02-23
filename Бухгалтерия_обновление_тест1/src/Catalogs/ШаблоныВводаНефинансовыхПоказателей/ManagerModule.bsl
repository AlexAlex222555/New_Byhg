#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ПрограммныйИнтерфейс

// Проверяет использование объекта
//
// Параметры:
//  Параметры		- Структура - содержит объект использование которого нужно проверить
//  АдресХранилища	- Строка - адрес хранилища в которое будут помещен результат проверки.
//
Процедура ПроверитьИспользованиеОбъекта(Параметры, АдресХранилища) Экспорт
	
	ЕстьСсылки = ОбщегоНазначенияВызовСервера.ЕстьСсылкиНаОбъект(Параметры.Объект);
	
	
	ПоместитьВоВременноеХранилище(ЕстьСсылки, АдресХранилища);
	
КонецПроцедуры

// Возвращает имена блокируемых реквизитов для механизма блокирования реквизитов БСП.
// 
// Возвращаемое значение:
// 	Массив - имена блокируемых реквизитов:
//		* БлокируемыйРеквизит - Строка - Имя блокируемого реквизита.
//
Функция ПолучитьБлокируемыеРеквизитыОбъекта() Экспорт
	
	Результат = Новый Массив;
	Результат.Добавить("ТипФормыВводаПоказателей");
	
	Возврат Результат;
	
КонецФункции

Функция ШаблонИспользуетсяВДокументах(Знач Шаблон, Знач ДокументИсключение = Неопределено) Экспорт
	
	Если Не ЗначениеЗаполнено(Шаблон) Тогда
		Возврат Ложь;
	КонецЕсли;
	
	Если Не ЗначениеЗаполнено(ДокументИсключение) Тогда
		ДокументИсключение = Документы.УстановкаЗначенийНефинансовыхПоказателей.ПустаяСсылка();
	КонецЕсли;
	
	Запрос = Новый Запрос("ВЫБРАТЬ ПЕРВЫЕ 1
	                      |	ДокументУстановкаЗначений.Ссылка
	                      |ИЗ
	                      |	Документ.УстановкаЗначенийНефинансовыхПоказателей КАК ДокументУстановкаЗначений
	                      |ГДЕ
	                      |	ДокументУстановкаЗначений.ШаблонВвода = &ШаблонВвода
	                      |	И НЕ ДокументУстановкаЗначений.Ссылка = &Исключение");
	
	Запрос.УстановитьПараметр("ШаблонВвода", Шаблон);
	Запрос.УстановитьПараметр("Исключение", ДокументИсключение);
	
	УстановитьПривилегированныйРежим(Истина);
	Возврат Не Запрос.Выполнить().Пустой();
	
КонецФункции

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

#Область ОбновлениеИнформационнойБазы

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
	Обработчик.РежимВыполнения = "Отложенно";
	Обработчик.Процедура = "Справочники.ШаблоныВводаНефинансовыхПоказателей.ОбработатьДанныеДляПереходаНаНовуюВерсию";
	Обработчик.Идентификатор = Новый УникальныйИдентификатор("06b3cac4-cbf4-4a46-ba07-924b20897234");
	Обработчик.ПроцедураЗаполненияДанныхОбновления = "Справочники.ШаблоныВводаНефинансовыхПоказателей.ЗарегистрироватьДанныеКОбработкеДляПереходаНаНовуюВерсию";
	Обработчик.ПроцедураПроверки = "БюджетированиеСервер.ДанныеОбновленыНаНовуюВерсиюПрограммы";
	Обработчик.ЧитаемыеОбъекты = "Справочник.ШаблоныВводаНефинансовыхПоказателей";
	Обработчик.ИзменяемыеОбъекты = "Справочник.ШаблоныВводаНефинансовыхПоказателей";
	Обработчик.БлокируемыеОбъекты = "Документ.УстановкаЗначенийНефинансовыхПоказателей,"
		+ "Справочник.ШаблоныВводаНефинансовыхПоказателей";
	Обработчик.Комментарий = НСтр("ru='Замена пустых значений аналитики в справочнике ""Шаблоны ввода нефинансовых показателей"" на единое значение пустой аналитики Неопределено';uk='Заміна порожніх значень аналітики у довіднику ""Шаблони введення нефінансових показників"" на єдине значення порожньої аналітики Неопределено'");

КонецПроцедуры

Процедура ЗарегистрироватьДанныеКОбработкеДляПереходаНаНовуюВерсию(Параметры) Экспорт
	
	ПустыеЗначенияДляОбработки = БюджетированиеВызовСервера.ЗаменяемыеПустыеЗначенияАналитики();
	
	Запрос = Новый Запрос;
	Запрос.Текст = 
	"ВЫБРАТЬ РАЗЛИЧНЫЕ
		|	Таблица.Ссылка КАК Ссылка
		|ИЗ
		|	Справочник.ШаблоныВводаНефинансовыхПоказателей.ЗначенияСложнойТаблицыПоУмолчанию КАК Таблица
		|ГДЕ
		|	Таблица.Значение В(&ПустыеЗначенияДляОбработки)
		|	И Таблица.Аналитика <> ЗНАЧЕНИЕ(ПланВидовХарактеристик.АналитикиСтатейБюджетов.ПустаяСсылка)";
	
	Запрос.УстановитьПараметр("ПустыеЗначенияДляОбработки", ПустыеЗначенияДляОбработки);
	
	ОбновлениеИнформационнойБазы.ОтметитьКОбработке(Параметры, Запрос.Выполнить().Выгрузить().ВыгрузитьКолонку("Ссылка"));
	
КонецПроцедуры

Процедура ОбработатьДанныеДляПереходаНаНовуюВерсию(Параметры) Экспорт
	
	ПолноеИмяМетаданных = "Справочник.ШаблоныВводаНефинансовыхПоказателей";
	МетаданныеОбъекта = Метаданные.Справочники.ШаблоныВводаНефинансовыхПоказателей;
	
	ПустыеЗначенияДляОбработки = БюджетированиеВызовСервера.ЗаменяемыеПустыеЗначенияАналитики();
	ЗначениеЗамены = БюджетированиеКлиентСервер.ПустоеЗначениеАналитики();
	
	
	ЗапросПоТипамАналитик = Новый Запрос;
	ЗапросПоТипамАналитик.Текст =
	"ВЫБРАТЬ
		|	АналитикиСтатейБюджетов.Ссылка КАК Ссылка,
		|	АналитикиСтатейБюджетов.ТипЗначения КАК ТипЗначения
		|ИЗ
		|	ПланВидовХарактеристик.АналитикиСтатейБюджетов КАК АналитикиСтатейБюджетов";
	
	ТипыАналитик = Новый Соответствие;
	ВыборкаТиповАналитик = ЗапросПоТипамАналитик.Выполнить().Выбрать();
	Пока ВыборкаТиповАналитик.Следующий() Цикл
		ТипыАналитик.Вставить(ВыборкаТиповАналитик.Ссылка, ВыборкаТиповАналитик.ТипЗначения);
	КонецЦикла;
	
	
	МенеджерВременныхТаблиц = Новый МенеджерВременныхТаблиц;
	
	Результат = ОбновлениеИнформационнойБазы.СоздатьВременнуюТаблицуСсылокДляОбработки(
		Параметры.Очередь, ПолноеИмяМетаданных, МенеджерВременныхТаблиц);
		
	Параметры.ОбработкаЗавершена = НЕ Результат.ЕстьДанныеДляОбработки;
	Если Параметры.ОбработкаЗавершена Тогда
		Возврат;
	КонецЕсли;
	
	Если НЕ Результат.ЕстьЗаписиВоВременнойТаблице Тогда
		Параметры.ОбработкаЗавершена = Ложь;
		Возврат;
	КонецЕсли;
	
	ТекстЗапроса =
	"ВЫБРАТЬ РАЗЛИЧНЫЕ
		|	ОбъектыДляОбработки.Ссылка                      КАК Ссылка
		|ИЗ
		|	ВТОбъектыДляОбработки КАК ОбъектыДляОбработки";
	
	ТекстЗапроса = СтрЗаменить(ТекстЗапроса, "ВТОбъектыДляОбработки", Результат.ИмяВременнойТаблицы);
	
	Запрос = Новый Запрос(ТекстЗапроса);
	Запрос.МенеджерВременныхТаблиц = МенеджерВременныхТаблиц;
	
	РезультатЗапроса = Запрос.Выполнить();
	
	Выборка = РезультатЗапроса.Выбрать();
	
	Пока Выборка.Следующий() Цикл
		
		НачатьТранзакцию();
		
		Попытка
			
			Блокировка = Новый БлокировкаДанных;
			ЭлементБлокировки = Блокировка.Добавить(ПолноеИмяМетаданных);
			ЭлементБлокировки.УстановитьЗначение("Ссылка", Выборка.Ссылка);
			ЭлементБлокировки.Режим = РежимБлокировкиДанных.Исключительный;
			Блокировка.Заблокировать();
			
			Объект = Выборка.Ссылка.ПолучитьОбъект();
			
			Если НЕ Объект = Неопределено Тогда
				Объект.Заблокировать();
				
				ОбъектИзменен = Ложь;
				
				Объект.ОбменДанными.Загрузка = Истина;
				Объект.ОбменДанными.Получатели.АвтоЗаполнение = Ложь;
				
				ОбъектИзменен = Ложь;
				
				Для каждого СтрокаТабличнойЧасти Из Объект.ЗначенияСложнойТаблицыПоУмолчанию Цикл
					
					Если ЗначениеЗаполнено(СтрокаТабличнойЧасти.Аналитика) Тогда
						ТипАналитики = ТипыАналитик.Получить(СтрокаТабличнойЧасти.Аналитика);
						Значение = БюджетированиеКлиентСервер.ПриведенноеЗначениеАналитики(
						СтрокаТабличнойЧасти.Значение, ТипАналитики);
						Если СтрокаТабличнойЧасти.Значение <> Значение Тогда
							СтрокаТабличнойЧасти.Значение = Значение;
							ОбъектИзменен = Истина;
						КонецЕсли;
					КонецЕсли;
				
				КонецЦикла;
				
				Если ОбъектИзменен Тогда
					ОбновлениеИнформационнойБазы.ЗаписатьОбъект(Объект);
				Иначе
					ОбновлениеИнформационнойБазы.ОтметитьВыполнениеОбработки(Выборка.Ссылка);
				КонецЕсли;
				
			Иначе
				
				ОбновлениеИнформационнойБазы.ОтметитьВыполнениеОбработки(Выборка.Ссылка);
				
			КонецЕсли;
			
			ЗафиксироватьТранзакцию();
			
		Исключение
			ОтменитьТранзакцию();
			ОбновлениеИнформационнойБазыУТ.СообщитьОНеудачнойОбработке(ИнформацияОбОшибке(), Выборка.Ссылка);
			Продолжить;
		КонецПопытки;
		
	КонецЦикла;
	
	Параметры.ОбработкаЗавершена = Не ОбновлениеИнформационнойБазы.ЕстьДанныеДляОбработки(Параметры.Очередь, ПолноеИмяМетаданных);
	
КонецПроцедуры

#КонецОбласти


#КонецОбласти

#КонецЕсли