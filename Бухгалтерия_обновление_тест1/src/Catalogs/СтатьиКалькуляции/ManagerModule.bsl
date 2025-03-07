#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ПрограммныйИнтерфейс

// Возвращает имена блокируемых реквизитов для механизма блокирования реквизитов БСП.
//
// Возвращаемое значение:
//	Массив - имена блокируемых реквизитов.
//
Функция ПолучитьБлокируемыеРеквизитыОбъекта() Экспорт
	Результат = Новый Массив;
	Результат.Добавить("ТипЗатрат");
	Результат.Добавить("Идентификатор");
	Возврат Результат;
КонецФункции

// Вызывается при начальном заполнении предопределенных элементов
// Подробнее см. в СтандартныеПодсистемыСервер.НастройкиПредопределенныхЭлементов
//
// Параметры:
//  Настройки - Структура - Настройки начального заполнения.
//
Процедура ПриНастройкеНачальногоЗаполненияЭлементов(Настройки) Экспорт
	
	Настройки.ПриНачальномЗаполненииЭлемента = Истина;
	
КонецПроцедуры

// Вызывается при начальном заполнении справочника.
//
// Параметры:
//  КодыЯзыков - Массив - список языков конфигурации. Актуально для мультиязычных конфигураций.
//  Элементы   - ТаблицаЗначений - данные заполнения. Состав колонок соответствует набору реквизитов
//                                 справочника.
//  ТабличныеЧасти - Структура - Ключ - Имя табличной части объекта.
//                               Значение - Выгрузка в таблицу значений пустой табличной части.
//
Процедура ПриНачальномЗаполненииЭлементов(КодыЯзыков, Элементы, ТабличныеЧасти) Экспорт

	КодОсновногоЯзыка = ОбщегоНазначения.КодОсновногоЯзыка();

	#Область ПолуфабрикатыПроизводимыеВПроцессе
	Элемент = Элементы.Добавить(); // СправочникОбъект.СтатьиКалькуляции - 
	Элемент.ИмяПредопределенныхДанных = "ПолуфабрикатыПроизводимыеВПроцессе";
	Элемент.Наименование = НСтр("ru='Полуфабрикаты производимые в процессе';uk='Напівфабрикати вироблені в процесі'",КодОсновногоЯзыка);
	Элемент.ТипЗатрат = Перечисления.ТипыЗатрат.Материальные;
	Элемент.РеквизитДопУпорядочивания = 0;
	Элемент.Идентификатор = НСтр("ru='ПолуфабрикатыПроизводимыеВПроцессе';uk='Напівфабрикати що виробляються в процесі'",КодОсновногоЯзыка);
	#КонецОбласти
КонецПроцедуры


// Вызывается при начальном заполнении создаваемого элемента.
//
// Параметры:
//  Объект                  - СправочникОбъект.СтатьиКалькуляции - заполняемый объект.
//  Данные                  - СтрокаТаблицыЗначений - данные заполнения.
//  ДополнительныеПараметры - Структура - Дополнительные параметры.
//
Процедура ПриНачальномЗаполненииЭлемента(Объект, Данные, ДополнительныеПараметры) Экспорт
	
	
	
КонецПроцедуры

#КонецОбласти

#Область ОбновлениеИнформационнойБазы

// Заполняет идентификатор и тип затрат предопределенной статьи калькуляции.
Функция НастроитьСтатьюКалькуляцииПредопределенныхЭлементов() Экспорт
	
	МетаданныеОбъекта = Метаданные.Справочники.СтатьиКалькуляции;
	ПолноеИмяОбъекта  = МетаданныеОбъекта.ПолноеИмя();
	
	СписокСтатей = Новый Массив;
	СписокСтатей.Добавить("ПолуфабрикатыПроизводимыеВПроцессе");

	Запрос = Новый Запрос(
	"ВЫБРАТЬ
	|	СтатьиКалькуляции.Ссылка КАК Ссылка,
	|	СтатьиКалькуляции.ВерсияДанных КАК ВерсияДанных
	|ИЗ
	|	Справочник.СтатьиКалькуляции КАК СтатьиКалькуляции
	|ГДЕ
	|	СтатьиКалькуляции.Идентификатор = """"
	|	И СтатьиКалькуляции.ТипЗатрат = ЗНАЧЕНИЕ(Перечисление.ТипыЗатрат.ПустаяСсылка)
	|	И СтатьиКалькуляции.ИмяПредопределенныхДанных В (&СписокСтатей)
	|");
	Запрос.УстановитьПараметр("СписокСтатей", СписокСтатей);
	
	Выборка = Запрос.Выполнить().Выбрать();
	Пока Выборка.Следующий() Цикл
		
		НачатьТранзакцию();
		
		Попытка
			
			Блокировка = Новый БлокировкаДанных;
			Блокировка.Добавить(ПолноеИмяОбъекта).УстановитьЗначение("Ссылка", Выборка.Ссылка);
			Блокировка.Заблокировать();
			
			Объект = Выборка.Ссылка.ПолучитьОбъект(); // СправочникОбъект.СтатьиКалькуляции
			
			Если Объект <> Неопределено И Объект.ВерсияДанных = Выборка.ВерсияДанных Тогда
				
				Если Не ЗначениеЗаполнено(Объект.Идентификатор) Тогда
					Объект.Идентификатор = Объект.ИмяПредопределенныхДанных;
				КонецЕсли;
				
				Если Не ЗначениеЗаполнено(Объект.ТипЗатрат) Тогда
					Объект.ТипЗатрат = Перечисления.ТипыЗатрат.Материальные;
				КонецЕсли;
				
				ОбновлениеИнформационнойБазы.ЗаписатьДанные(Объект);
				
			КонецЕсли;
			
			ЗафиксироватьТранзакцию();
			
		Исключение
			ОтменитьТранзакцию();
			ТекстСообщения = НСтр("ru='Не удалось обработать элемент: %Ссылка% по причине: %Причина%';uk='Не вдалося обробити елемент:%Ссылка% через: %Причина%'");
			ТекстСообщения = СтрЗаменить(ТекстСообщения, "%Ссылка%", Выборка.Ссылка);
			ТекстСообщения = СтрЗаменить(ТекстСообщения, "%Причина%", ПодробноеПредставлениеОшибки(ИнформацияОбОшибке()));
			ЗаписьЖурналаРегистрации(
				ОбновлениеИнформационнойБазы.СобытиеЖурналаРегистрации(),
				УровеньЖурналаРегистрации.Предупреждение,
				МетаданныеОбъекта,
				Выборка.Ссылка,
				ТекстСообщения
			);
			Продолжить;
		КонецПопытки;
		
	КонецЦикла;
	Возврат Истина;
	
КонецФункции


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
	Обработчик.Процедура = "Справочники.СтатьиКалькуляции.ОбработатьДанныеДляПереходаНаНовуюВерсию";
	Обработчик.Идентификатор = Новый УникальныйИдентификатор("3a984a70-e2ca-464a-8a72-93c9f2b610fc");
	Обработчик.ПроцедураЗаполненияДанныхОбновления = "Справочники.СтатьиКалькуляции.ЗарегистрироватьДанныеКОбработкеДляПереходаНаНовуюВерсию";
	Обработчик.ПроцедураПроверки = "ОбновлениеИнформационнойБазы.ДанныеОбновленыНаНовуюВерсиюПрограммы";
	Обработчик.ЗапускатьТолькоВГлавномУзле = Истина;
	Обработчик.ЧитаемыеОбъекты = "Справочник.СтатьиКалькуляции,"
		+ "Документ.ЗаказПереработчику,"
		+ "Документ.ОтчетПереработчика";
	Обработчик.ИзменяемыеОбъекты = "Справочник.СтатьиКалькуляции";
	Обработчик.БлокируемыеОбъекты = "Справочник.СтатьиКалькуляции";
	Обработчик.Комментарий = НСтр("ru='Создает новые статьи калькуляции для заполнения ими обязательных к заполнению полей документов Заказ переработчику и Отчет переработчика.
    |Создает статьи калькуляции ""Ремонтируемое изделие"", ""Разбираемое изделие"", необходимые для плановых и фактических затрат.
    |Пока обработчик не выполнен, может не корректно выполнятся проведение старых документов Заказов переработчику и Отчетов переработчика.'
    |;uk='Створює нові статті калькуляції для заповнення ними обов''язкових до заповнення полів документів Замовлення переробника та Звіт переробника.
    |Створює статті калькуляції ""Виріб, що ремонтується"", ""Виріб, що розбирається"", необхідні для планових і фактичних витрат.
    |Поки обробник не виконаний, може не коректно виконуватись проведення старих документів Замовлень переробнику та Звітів переробника.'");
	
	Обработчик.ПриоритетыВыполнения = ОбновлениеИнформационнойБазы.ПриоритетыВыполненияОбработчика();

	НоваяСтрока = Обработчик.ПриоритетыВыполнения.Добавить();
	НоваяСтрока.Процедура = "Документы.ЗаказПереработчику.ОбработатьДанныеДляПереходаНаНовуюВерсию";
	НоваяСтрока.Порядок = "До";

	НоваяСтрока = Обработчик.ПриоритетыВыполнения.Добавить();
	НоваяСтрока.Процедура = "Документы.ОтчетПереработчика.ОбработатьДанныеДляПереходаНаНовуюВерсию";
	НоваяСтрока.Порядок = "До";

	НоваяСтрока = Обработчик.ПриоритетыВыполнения.Добавить();
	НоваяСтрока.Процедура = "РегистрыНакопления.СебестоимостьТоваров.ОбработатьДанныеДляПереходаНаНовуюВерсию";
	НоваяСтрока.Порядок = "До";                    
	
	НоваяСтрока = Обработчик.ПриоритетыВыполнения.Добавить();
	НоваяСтрока.Процедура = "ОбновлениеИнформационнойБазыУТ.ОбновитьПредставленияПредопределенныхЭлементов";
	НоваяСтрока.Порядок = "Любой";   

КонецПроцедуры	

Процедура ЗарегистрироватьДанныеКОбработкеДляПереходаНаНовуюВерсию(Параметры) Экспорт
	
	Возврат; // Нет данных для регистрации, создаются новые элементы
	
КонецПроцедуры

Процедура ОбработатьДанныеДляПереходаНаНовуюВерсию(Параметры) Экспорт
	
	ОбработкаЗавершена = Истина;
	
	ОбработкаЗавершена = ОбработкаЗавершена И НастроитьСтатьюКалькуляцииПредопределенныхЭлементов();
	
	Параметры.ОбработкаЗавершена = ОбработкаЗавершена;
	
КонецПроцедуры


#КонецОбласти

#Область СлужебныеПроцедурыИФункции

Процедура УстановитьРеквизитДопУпорядочиванияГруппСтатейДоходов() Экспорт
	Запрос = Новый Запрос;
	Запрос.Текст = "ВЫБРАТЬ
	|	СтатьиКалькуляции.Ссылка КАК Ссылка
	|ИЗ
	|	Справочник.СтатьиКалькуляции КАК СтатьиКалькуляции
	|ГДЕ
	|	СтатьиКалькуляции.ЭтоГруппа
	|
	|УПОРЯДОЧИТЬ ПО
	|	СтатьиКалькуляции.Наименование";
	
	Выборка = Запрос.Выполнить().Выбрать();
	Пока Выборка.Следующий() Цикл 
		Объект = Выборка.Ссылка.ПолучитьОбъект(); // СправочникОбъект.СтатьиКалькуляции
		ЗаблокироватьДанныеДляРедактирования(Объект.Ссылка);
		НастройкаПорядкаЭлементов.ЗаполнитьЗначениеРеквизитаУпорядочивания(Объект, Ложь);
		ОбновлениеИнформационнойБазы.ЗаписатьДанные(Объект);
	КонецЦикла;
КонецПроцедуры

#КонецОбласти

#КонецЕсли