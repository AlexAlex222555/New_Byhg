#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ПрограммныйИнтерфейс

// СтандартныеПодсистемы.ВерсионированиеОбъектов

// Определяет настройки объекта для подсистемы ВерсионированиеОбъектов.
//
// Параметры:
//  Настройки - Структура - настройки подсистемы.
Процедура ПриОпределенииНастроекВерсионированияОбъектов(Настройки) Экспорт

КонецПроцедуры

// Конец СтандартныеПодсистемы.ВерсионированиеОбъектов

// Возвращает имена блокируемых реквизитов для механизма блокирования реквизитов БСП
//	Возвращаемое значение:
//		Массив - имена блокируемых реквизитов.
//
Функция ПолучитьБлокируемыеРеквизитыОбъекта() Экспорт

	Результат = Новый Массив;
	Результат.Добавить("Валюта");
	Результат.Добавить("Периодичность");
	Результат.Добавить("ПланЗакупокПланироватьПоСумме;ПланЗакупокПланировать");
	Результат.Добавить("ПланПродажПланироватьПоСумме;ПланПродажПланировать");
	Результат.Добавить("ПланированиеПоНазначениям");
	Результат.Добавить("ИспользоватьРасчетПоСкоростиПродаж");
	Результат.Добавить("ИспользоватьДляПланированияМатериалов");
	Результат.Добавить("Календарь");
	Результат.Добавить("СпособРасчетаПотребностейВМатериалах");
	Результат.Добавить("УправлениеПроцессомПланирования");
	
	//++ НЕ УТ
	Результат.Добавить("ОтражаетсяВБюджетировании");
	//-- НЕ УТ
	
	Возврат Результат;

КонецФункции

// Список статусов планов по сценарию
//
// Параметры:
//  Сценарий - СправочникСсылка.СценарииТоварногоПланирования	 - Сценарий по которому необходимо получать данные.
// 
// Возвращаемое значение:
//  СписокЗначений - Список статусов планов, которые разрешено получать.
//
Функция СписокСтатусовПланов(Сценарий) Экспорт 
	
	СписокСтатусов = Новый СписокЗначений;
	СписокСтатусов.Добавить(Перечисления.СтатусыПланов.НаУтверждении);
	СписокСтатусов.Добавить(Перечисления.СтатусыПланов.Утвержден);
	
	Возврат СписокСтатусов;

КонецФункции 

// Возвращает календарь работы, используемый для расчета дат запуска продукции и полуфабрикатов, а так же сроков потребностей в  материалах, видах РЦ и трудовых ресурсах
//
// Параметры:
//  Сценарий - СправочникСсылка.СценарииТоварногоПланирования	 - Сценарий по которому необходимо получать данные.
// 
// Возвращаемое значение:
//  СправочникСсылка.Календари - календарь
//
Функция Календарь(Сценарий) Экспорт
	
	Если ЗначениеЗаполнено(Сценарий) Тогда
		Календарь = ОбщегоНазначения.ЗначениеРеквизитаОбъекта(Сценарий, "Календарь");
		Если Не ЗначениеЗаполнено(Календарь) Тогда
			Календарь = Константы.ОсновнойКалендарьПредприятия.Получить();
		КонецЕсли;
	Иначе
		Календарь = Константы.ОсновнойКалендарьПредприятия.Получить();
	КонецЕсли;
	
	Возврат Календарь;
	
КонецФункции

// Проверяет, используется ли расчет потребности в материалах, видах РЦ и трудовых ресурсах для выбранного сценария
//
// Параметры:
//  Сценарий - СправочникСсылка.СценарииТоварногоПланирования	 - Сценарий по которому необходимо получать данные.
// 
// Возвращаемое значение:
//  Булево - Истина, если используется расчет потребностей в материалах, видах РЦ и трудовых ресурсах
//
Функция ИспользоватьДляПланированияМатериалов(Сценарий) Экспорт
	
	Если Не ЗначениеЗаполнено(Сценарий) Тогда
		Возврат Ложь;
	КонецЕсли;
	
	Запрос = Новый Запрос(
	"ВЫБРАТЬ
	|	ИСТИНА
	|ИЗ
	|	Справочник.СценарииТоварногоПланирования КАК СценарииТоварногоПланирования
	|ГДЕ
	|	СценарииТоварногоПланирования.Ссылка = &Сценарий
	|	И СценарииТоварногоПланирования.ИспользоватьДляПланированияМатериалов
	|");
	Запрос.УстановитьПараметр("Сценарий", Сценарий);
	
	Возврат Не Запрос.Выполнить().Пустой();
	
КонецФункции

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

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
	Обработчик.РежимВыполнения = "Отложенно";
	Обработчик.Процедура = "Справочники.СценарииТоварногоПланирования.ОбработатьДанныеДляПереходаНаНовуюВерсию";
	Обработчик.Идентификатор = Новый УникальныйИдентификатор("3e82bc85-f825-46c6-afa5-311a14b182bd");
	Обработчик.ПроцедураЗаполненияДанныхОбновления = "Справочники.СценарииТоварногоПланирования.ЗарегистрироватьДанныеКОбработкеДляПереходаНаНовуюВерсию";
	Обработчик.ПроцедураПроверки = "ОбновлениеИнформационнойБазы.ДанныеОбновленыНаНовуюВерсиюПрограммы";
	Обработчик.ЧитаемыеОбъекты = "Справочник.СценарииТоварногоПланирования";
	Обработчик.ИзменяемыеОбъекты = "Справочник.СценарииТоварногоПланирования";
	Обработчик.БлокируемыеОбъекты = "Справочник.СценарииТоварногоПланирования";
	Обработчик.Комментарий = НСтр("ru='Заполняет реквизит ""Способ расчета потребностей в материалах"" значением по умолчанию ""Вероятное потребление"".';uk='Заповнює реквізит ""Спосіб розрахунку потреб у матеріалах"" значенням по умовчанню ""Вірогідне споживання"".'");
	Обработчик.ПриоритетыВыполнения = ОбновлениеИнформационнойБазы.ПриоритетыВыполненияОбработчика();

	НоваяСтрока = Обработчик.ПриоритетыВыполнения.Добавить();
	НоваяСтрока.Процедура = "Документы.ПланПроизводства.ОбработатьДанныеДляПереходаНаНовуюВерсию";
	НоваяСтрока.Порядок = "До";
	
КонецПроцедуры

Процедура ЗарегистрироватьДанныеКОбработкеДляПереходаНаНовуюВерсию(Параметры) Экспорт
	
	Запрос = Новый Запрос(
		"ВЫБРАТЬ
		|	СценарииТоварногоПланирования.Ссылка КАК Ссылка
		|ИЗ
		|	Справочник.СценарииТоварногоПланирования КАК СценарииТоварногоПланирования
		|ГДЕ
		|	СценарииТоварногоПланирования.ИспользоватьДляПланированияМатериалов
		|	И СценарииТоварногоПланирования.СпособРасчетаПотребностейВМатериалах = ЗНАЧЕНИЕ(Перечисление.СпособыРасчетаМатериалов.ПустаяСсылка)");
	
	ОбновлениеИнформационнойБазы.ОтметитьКОбработке(Параметры, Запрос.Выполнить().Выгрузить().ВыгрузитьКолонку("Ссылка"));
	
КонецПроцедуры

Процедура ОбработатьДанныеДляПереходаНаНовуюВерсию(Параметры) Экспорт
	
	ПолноеИмяОбъекта = "Справочник.СценарииТоварногоПланирования";
	
	МенеджерВременныхТаблиц = Новый МенеджерВременныхТаблиц;
	
	Результат = ОбновлениеИнформационнойБазы.СоздатьВременнуюТаблицуСсылокДляОбработки(
		Параметры.Очередь, ПолноеИмяОбъекта, МенеджерВременныхТаблиц);
	
	Если НЕ Результат.ЕстьДанныеДляОбработки Тогда
		Параметры.ОбработкаЗавершена = Истина;
		Возврат;
	КонецЕсли;
	Если НЕ Результат.ЕстьЗаписиВоВременнойТаблице Тогда
		Параметры.ОбработкаЗавершена = Ложь;
		Возврат;
	КонецЕсли;
	
	ТекстЗапроса = 
		"ВЫБРАТЬ
		|	КОбработке.Ссылка КАК Ссылка,
		|	КОбработке.Ссылка.ВерсияДанных КАК ВерсияДанных
		|ИЗ
		|	ВТСсылкиДляОбработки КАК КОбработке";
	
	ТекстЗапроса = СтрЗаменить(ТекстЗапроса, "ВТСсылкиДляОбработки", Результат.ИмяВременнойТаблицы);
	
	Запрос = Новый Запрос(ТекстЗапроса);
	Запрос.МенеджерВременныхТаблиц = МенеджерВременныхТаблиц;
	
	Выборка = Запрос.Выполнить().Выбрать();
	Пока Выборка.Следующий() Цикл
		
		НачатьТранзакцию();
		Попытка
			
			Блокировка = Новый БлокировкаДанных;
			
			ЭлементБлокировки = Блокировка.Добавить(ПолноеИмяОбъекта);
			ЭлементБлокировки.УстановитьЗначение("Ссылка", Выборка.Ссылка);
			ЭлементБлокировки.Режим = РежимБлокировкиДанных.Исключительный;
			
			Блокировка.Заблокировать();
			
			Объект = ОбновлениеИнформационнойБазыУТ.ПроверитьПолучитьОбъект(
				Выборка.Ссылка, Выборка.ВерсияДанных, Параметры.Очередь);
			
			Если Объект <> Неопределено Тогда
			
				ОбъектИзменен = Ложь;
				
				Если Объект.ИспользоватьДляПланированияМатериалов
					И Объект.СпособРасчетаПотребностейВМатериалах.Пустая() Тогда
					
					Объект.СпособРасчетаПотребностейВМатериалах = Перечисления.СпособыРасчетаМатериалов.ВероятноеПотребление;
					ОбъектИзменен = Истина;
					
				КонецЕсли;
				
				Если ОбъектИзменен Тогда
					ОбновлениеИнформационнойБазы.ЗаписатьДанные(Объект);
				Иначе
					ОбновлениеИнформационнойБазы.ОтметитьВыполнениеОбработки(Объект);
				КонецЕсли;
				
			КонецЕсли;
			
			ЗафиксироватьТранзакцию();
			
		Исключение
			
			ОтменитьТранзакцию();
			
			ОбновлениеИнформационнойБазыУТ.СообщитьОНеудачнойОбработке(ИнформацияОбОшибке(), Выборка.Ссылка);
			
		КонецПопытки;
		
	КонецЦикла;
	
	Параметры.ОбработкаЗавершена = Не ОбновлениеИнформационнойБазы.ЕстьДанныеДляОбработки(Параметры.Очередь, ПолноеИмяОбъекта);
	
КонецПроцедуры

//-- НЕ УТ
	

#КонецОбласти

#КонецОбласти

#КонецЕсли
