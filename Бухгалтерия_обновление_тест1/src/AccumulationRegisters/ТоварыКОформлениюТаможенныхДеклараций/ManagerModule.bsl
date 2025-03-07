#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ПрограммныйИнтерфейс

#Область ДляВызоваИзДругихПодсистем

// СтандартныеПодсистемы.УправлениеДоступом

// См. УправлениеДоступомПереопределяемый.ПриЗаполненииСписковСОграничениемДоступа.
Процедура ПриЗаполненииОграниченияДоступа(Ограничение) Экспорт

	Ограничение.Текст =
	"РазрешитьЧтениеИзменение
	|ГДЕ
	|	ЗначениеРазрешено(Поставщик)
	|	И ЗначениеРазрешено(Организация)";

КонецПроцедуры

// Конец СтандартныеПодсистемы.УправлениеДоступом

#КонецОбласти

#КонецОбласти

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
	Обработчик.Версия = "3.5.4.400";
	Обработчик.РежимВыполнения = "Отложенно";
	Обработчик.Процедура = "РегистрыНакопления.ТоварыКОформлениюТаможенныхДеклараций.ОбработатьДанныеДляПереходаНаНовуюВерсию";
	Обработчик.Идентификатор = Новый УникальныйИдентификатор("55e236f2-3cb6-4c0a-8fea-2d4b59cac380");
	Обработчик.ПроцедураЗаполненияДанныхОбновления = "РегистрыНакопления.ТоварыКОформлениюТаможенныхДеклараций.ЗарегистрироватьДанныеКОбработкеДляПереходаНаНовуюВерсию";
	Обработчик.ПроцедураПроверки = "ОбновлениеИнформационнойБазы.ДанныеОбновленыНаНовуюВерсиюПрограммы";
	Обработчик.ЧитаемыеОбъекты = "Документ.ПриобретениеТоваровУслуг,"
		+ "РегистрНакопления.ТоварыКОформлениюТаможенныхДеклараций,"
		+ "Справочник.КлючиАналитикиУчетаНоменклатуры,"
		+ "Справочник.Назначения,"
		+ "Документ.ТаможеннаяДекларацияИмпорт"
	;
	Обработчик.ИзменяемыеОбъекты = "РегистрНакопления.ТоварыКОформлениюТаможенныхДеклараций";
	Обработчик.БлокируемыеОбъекты = "";
	Обработчик.Комментарий = НСтр("ru='Заполняет поле ""Назначение"" в измерении ""Аналитика учета номенклатуры"".';uk='Заповнює поле ""Призначення"" у вимірі ""Аналітика обліку номенклатури"".'");
	
	Обработчик.ПриоритетыВыполнения = ОбновлениеИнформационнойБазы.ПриоритетыВыполненияОбработчика();

	НоваяСтрока = Обработчик.ПриоритетыВыполнения.Добавить();
	НоваяСтрока.Процедура = "Документы.ПриобретениеТоваровУслуг.ОбработатьДанныеДляПереходаНаНовуюВерсию";
	НоваяСтрока.Порядок = "После";
	
	НоваяСтрока = Обработчик.ПриоритетыВыполнения.Добавить();
	НоваяСтрока.Процедура = "Документы.ТаможеннаяДекларацияИмпорт.ОбработатьДанныеДляПереходаНаНовуюВерсию";
	НоваяСтрока.Порядок = "После";
	
	НоваяСтрока = Обработчик.ПриоритетыВыполнения.Добавить();
	НоваяСтрока.Процедура = "Справочники.КлючиАналитикиУчетаНоменклатуры.ОбработатьДанныеДляПереходаНаНовуюВерсию";
	НоваяСтрока.Порядок = "После";
	
	НоваяСтрока = Обработчик.ПриоритетыВыполнения.Добавить();
	НоваяСтрока.Процедура = "Справочники.Назначения.ОбработатьДанныеДляПереходаНаНовуюВерсию";
	НоваяСтрока.Порядок = "После";        
	
	
	НоваяСтрока = Обработчик.ПриоритетыВыполнения.Добавить();
	НоваяСтрока.Процедура = "Справочники.Партнеры.ОбработатьДанныеДляПереходаНаНовуюВерсию";
	НоваяСтрока.Порядок = "После";
	
	НоваяСтрока = Обработчик.ПриоритетыВыполнения.Добавить();
	НоваяСтрока.Процедура = "РегистрыНакопления.ТоварыОрганизаций.СгенерироватьДокументыДляПереброскиОстатковСПустогоНазначенияПоДавальческойСхеме";
	НоваяСтрока.Порядок = "Любой";
	
	ОбновлениеИнформационнойБазыПереопределяемый.ДобавитьПриоритетыОбработатьДанныеДляГенерацииНазначений(
		Обработчик.ПриоритетыВыполнения,
		"После"
	);
	
	Исключения = ОбновлениеИнформационнойБазыПереопределяемый.ИсключенияПриДобавленииПриоритетов();
	ОбновлениеИнформационнойБазыПереопределяемый.ДобавитьПриоритетыСгенерироватьКлючиАналитикиНоменклатуры(
		Обработчик.ПриоритетыВыполнения,
		"После",
		Исключения
	);	                        

КонецПроцедуры

Процедура ЗарегистрироватьДанныеКОбработкеДляПереходаНаНовуюВерсию(Параметры) Экспорт
	
	ИмяРегистра = "ТоварыКОформлениюТаможенныхДеклараций";
	ПолноеИмяРегистра = "РегистрНакопления.ТоварыКОформлениюТаможенныхДеклараций";
	
	Запрос = Новый Запрос("
	|ВЫБРАТЬ РАЗЛИЧНЫЕ
	|	ДанныеРегистра.Регистратор КАК Ссылка
	|ИЗ
	|	РегистрНакопления.ТоварыКОформлениюТаможенныхДеклараций КАК ДанныеРегистра
	|ГДЕ
	|	ДанныеРегистра.АналитикаУчетаНоменклатуры.Назначение <> ДанныеРегистра.ВидЗапасов.УстарелоНазначение
	|	И ДанныеРегистра.ВидЗапасов.УстарелоНазначение <> ЗНАЧЕНИЕ(Справочник.Назначения.ПустаяСсылка)
	|	И ДанныеРегистра.ВидЗапасов <> ЗНАЧЕНИЕ(Справочник.ВидыЗапасов.ПустаяСсылка)
	|");
	
	Регистраторы = Запрос.Выполнить().Выгрузить().ВыгрузитьКолонку("Ссылка");
	ОбновлениеИнформационнойБазы.ОтметитьРегистраторыКОбработке(
		Параметры, 
		Регистраторы, 
		ПолноеИмяРегистра
	);
	
	
	СписокДокументов = Новый Массив();
	СписокДокументов.Добавить("Документ.ТаможеннаяДекларацияИмпорт");
	
	Для Каждого ПолноеИмяДокумента Из СписокДокументов Цикл
		ИмяДокумента = СтрРазделить(ПолноеИмяДокумента, ".")[1];
		ТекстЗапросаМеханизмаПроведения = Документы[ИмяДокумента].АдаптированныйТекстЗапросаДвиженийПоРегистру(ИмяРегистра);
		Регистраторы = ОбновлениеИнформационнойБазыУТ.РегистраторыДляПерепроведения(
			ТекстЗапросаМеханизмаПроведения,
			ПолноеИмяРегистра,
			ПолноеИмяДокумента
		);
								
		ОбновлениеИнформационнойБазы.ОтметитьРегистраторыКОбработке(
			Параметры, 
			Регистраторы, 
			ПолноеИмяРегистра
		);  
		
	КонецЦикла;
	
КонецПроцедуры

Процедура ОбработатьДанныеДляПереходаНаНовуюВерсию(Параметры) Экспорт
	
	ПолноеИмяРегистра = "РегистрНакопления.ТоварыКОформлениюТаможенныхДеклараций";
	
	Регистраторы = Новый Массив;
	Регистраторы.Добавить("Документ.ТаможеннаяДекларацияИмпорт");
	
	ОбновлениеИнформационнойБазыУТ.ПерезаписатьДвиженияИзОчереди(
		Регистраторы,
		"РегистрНакопления.ТоварыКОформлениюТаможенныхДеклараций", 
		Параметры.Очередь
	);

	ДополнительныеПараметры = ОбновлениеИнформационнойБазы.ДополнительныеПараметрыОтметкиОбработки();
	ДополнительныеПараметры.ЭтоДвижения = Истина;
	ДополнительныеПараметры.ПолноеИмяРегистра = ПолноеИмяРегистра;
	
	Выборка = ОбновлениеИнформационнойБазы.ВыбратьРегистраторыРегистраДляОбработки(
		Параметры.Очередь, 
		Неопределено, 
		ПолноеИмяРегистра
	);
	
	ТекстЗапроса = "
	|ВЫБРАТЬ
	|	Движения.Регистратор             КАК Регистратор,
	|	Движения.ВидДвижения             КАК ВидДвижения,
	|	Движения.Период                  КАК Период,
	|	Движения.Организация                        КАК Организация,
	|	Движения.Поставщик                          КАК Поставщик,
	|	ВЫБОР КОГДА Движения.ВидЗапасов <> ЗНАЧЕНИЕ(Справочник.ВидыЗапасов.ПустаяСсылка)
	|		И Движения.АналитикаУчетаНоменклатуры.Назначение <> Движения.ВидЗапасов.УстарелоНазначение
	|		И Движения.ВидЗапасов.УстарелоНазначение <> ЗНАЧЕНИЕ(Справочник.Назначения.ПустаяСсылка)
	|		И НЕ Аналитика.КлючАналитики ЕСТЬ NULL
	|		ТОГДА Аналитика.КлючАналитики
	|		ИНАЧЕ Движения.АналитикаУчетаНоменклатуры
	|	КОНЕЦ                                        КАК АналитикаУчетаНоменклатуры,
	|	Движения.ВидЗапасов                          КАК ВидЗапасов,
	|	Движения.ДокументПоступления                 КАК ДокументПоступления,
	|	Движения.Количество              КАК Количество,
	|	Движения.Сумма                   КАК Сумма,
	|	Движения.НомерГТД                            КАК НомерГТД,
	|	Движения.Первичное                           КАК Первичное,
	|
	|	ВЫБОР КОГДА Аналитика.КлючАналитики ЕСТЬ NULL
	|		И Движения.АналитикаУчетаНоменклатуры.Назначение <> Движения.ВидЗапасов.УстарелоНазначение
	|		И Движения.ВидЗапасов.УстарелоНазначение <> ЗНАЧЕНИЕ(Справочник.Назначения.ПустаяСсылка)
	|		И Движения.ВидЗапасов <> ЗНАЧЕНИЕ(Справочник.ВидыЗапасов.ПустаяСсылка)
	|		ТОГДА 0
	|		ИНАЧЕ 1
	|	КОНЕЦ КАК КлючиИнициализированы
	|ИЗ
	|	РегистрНакопления.ТоварыКОформлениюТаможенныхДеклараций КАК Движения
	|
	|	ВНУТРЕННЕЕ СОЕДИНЕНИЕ Справочник.КлючиАналитикиУчетаНоменклатуры КАК Ключи
	|	ПО Ключи.Ссылка = Движения.АналитикаУчетаНоменклатуры
	|
	|	ЛЕВОЕ СОЕДИНЕНИЕ РегистрСведений.АналитикаУчетаНоменклатуры КАК Аналитика
	|	ПО Ключи.Номенклатура = Аналитика.Номенклатура
	|		И Ключи.Характеристика = Аналитика.Характеристика
	|		И Ключи.Серия = Аналитика.Серия
	|		И Ключи.МестоХранения = Аналитика.МестоХранения
	|		И Ключи.СтатьяКалькуляции = Аналитика.СтатьяКалькуляции
	|		И Движения.ВидЗапасов.УстарелоНазначение = Аналитика.Назначение
	|
	|ГДЕ
	|	Движения.Регистратор = &Регистратор
	|УПОРЯДОЧИТЬ ПО
	|	КлючиИнициализированы,
	|	НомерСтроки
	|";
	
	Пока Выборка.Следующий() Цикл
		
		Регистратор = Выборка.Регистратор;
		
		НачатьТранзакцию();
		Попытка
			Блокировка = Новый БлокировкаДанных;
			ЭлементБлокировки = Блокировка.Добавить(ПолноеИмяРегистра + ".НаборЗаписей");
			ЭлементБлокировки.УстановитьЗначение("Регистратор", Регистратор);
			ЭлементБлокировки.Режим = РежимБлокировкиДанных.Исключительный;

			Блокировка.Заблокировать();
			
			Запрос = Новый Запрос(ТекстЗапроса);
			Запрос.УстановитьПараметр("Регистратор", Регистратор);
			
			Набор = РегистрыНакопления.ТоварыКОформлениюТаможенныхДеклараций.СоздатьНаборЗаписей();
			Набор.Отбор.Регистратор.Установить(Регистратор);
			
			Результат = Запрос.Выполнить().Выгрузить();
			Если Результат.Количество() = 0 Тогда
				ОбновлениеИнформационнойБазы.ОтметитьВыполнениеОбработки(Регистратор, ДополнительныеПараметры);
				ЗафиксироватьТранзакцию();
				Продолжить;
			ИначеЕсли Результат[0].КлючиИнициализированы = 0 Тогда
				ТекстСообщения = НСтр("ru='есть необновленные ключи. Необходимо перепровести документ вручную.';uk='існують неоновлені ключі. Необхідно перепровести документ вручну.'");
				ВызватьИсключение ТекстСообщения;
			КонецЕсли;
			
			Набор.Загрузить(Результат);
			
			ОбновлениеИнформационнойБазы.ЗаписатьДанные(Набор);
			ЗафиксироватьТранзакцию();
		Исключение
			ОтменитьТранзакцию();
			ТекстСообщения = НСтр("ru='Не удалось обработать документ: %Регистратор% по причине: %Причина%';uk='Не вдалося обробити документ: %Регистратор% по причині: %Причина%'");
			ТекстСообщения = СтрЗаменить(ТекстСообщения, "%Регистратор%", Регистратор);
			ТекстСообщения = СтрЗаменить(ТекстСообщения, "%Причина%", ПодробноеПредставлениеОшибки(ИнформацияОбОшибке()));
			ЗаписьЖурналаРегистрации(
				ОбновлениеИнформационнойБазы.СобытиеЖурналаРегистрации(), 
				УровеньЖурналаРегистрации.Ошибка,
				Регистратор.Метаданные(), 
				ТекстСообщения
			);
		КонецПопытки;
	КонецЦикла;
	
	Параметры.ОбработкаЗавершена = Не ОбновлениеИнформационнойБазы.ЕстьДанныеДляОбработки(Параметры.Очередь, ПолноеИмяРегистра);
	
КонецПроцедуры


#КонецОбласти

#КонецЕсли