#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ПрограммныйИнтерфейс

//++ НЕ УТ

// Определяет показатели регистра.
// Подробнее см. ОбщийМодуль.МеждународныйУчетСерверПовтИсп.Показатели()
//
Функция Показатели(Свойства) Экспорт

	Показатели = Новый Соответствие;
	
	СвойстваПоказателей = Свойства.СвойстваПоказателей;
	СвойстваРесурсов = Свойства.СвойстваРесурсов;
    
	МассивРесурсов = Новый Массив;
	МассивРесурсов.Добавить(Новый Структура(СвойстваРесурсов, "Стоимость", "ВалютаУпр"));
    МассивРесурсов.Добавить(Новый Структура(СвойстваРесурсов, "СтоимостьРегл", "ВалютаРегл"));
	Показатели.Вставить(Перечисления.ПоказателиАналитическихРегистров.Сумма, Новый Структура(СвойстваПоказателей, МассивРесурсов));
	
	Возврат Показатели;
	
КонецФункции

//-- НЕ УТ


#Область ДляВызоваИзДругихПодсистем

// СтандартныеПодсистемы.УправлениеДоступом

// См. УправлениеДоступомПереопределяемый.ПриЗаполненииСписковСОграничениемДоступа.
Процедура ПриЗаполненииОграниченияДоступа(Ограничение) Экспорт

	Ограничение.Текст =
	"РазрешитьЧтениеИзменение
	|ГДЕ
	|	ЗначениеРазрешено(Организация)
	|	И ЗначениеРазрешено(Подразделение)";

КонецПроцедуры

// Конец СтандартныеПодсистемы.УправлениеДоступом

#КонецОбласти

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
	Обработчик.Процедура = "РегистрыНакопления.ТрудозатратыНезавершенногоПроизводства.ОбработатьДанныеДляПереходаНаНовуюВерсию";
	Обработчик.ПроцедураЗаполненияДанныхОбновления = "РегистрыНакопления.ТрудозатратыНезавершенногоПроизводства.ЗарегистрироватьДанныеКОбработкеДляПереходаНаНовуюВерсию";
	Обработчик.Идентификатор = Новый УникальныйИдентификатор("58b675e9-b1de-4c57-821a-3793b05d71ca");
	Обработчик.ПроцедураПроверки = "ОбновлениеИнформационнойБазы.ДанныеОбновленыНаНовуюВерсиюПрограммы";
	Обработчик.ЧитаемыеОбъекты = "РегистрНакопления.ТрудозатратыНезавершенногоПроизводства,"
		+ "Справочник.КлючиАналитикиУчетаНоменклатуры,"
		+ "Справочник.ВидыЗапасов";
	Обработчик.ИзменяемыеОбъекты = "РегистрНакопления.ТрудозатратыНезавершенногоПроизводства";
	Обработчик.БлокируемыеОбъекты = "";
	Обработчик.Комментарий = НСтр("ru='Заполняет новый реквизит ""Назначение"" в справочнике ""Ключи аналитики учета номенклатуры"" и обновляет движения по регистру.';uk='Заповнює новий реквізит ""Призначення"" у довіднику ""Ключі аналітики обліку номенклатури"" та оновлює рухи по регістру.'");
	Обработчик.ПриоритетыВыполнения = ОбновлениеИнформационнойБазы.ПриоритетыВыполненияОбработчика();


	НоваяСтрока = Обработчик.ПриоритетыВыполнения.Добавить();
	НоваяСтрока.Процедура = "РегистрыНакопления.ПрочиеАктивыПассивы.ОбработатьДанныеДляПереходаНаНовуюВерсию";
	НоваяСтрока.Порядок = "До";

	
	Исключения = ОбновлениеИнформационнойБазыПереопределяемый.ИсключенияПриДобавленииПриоритетов();
	ОбновлениеИнформационнойБазыПереопределяемый.ДобавитьПриоритетыСгенерироватьКлючиАналитикиНоменклатуры(
		Обработчик.ПриоритетыВыполнения,
		"После",
		Исключения
	);	                        
	
КонецПроцедуры 

// Обработчик обновления КА 2.5.4
Процедура ЗарегистрироватьДанныеКОбработкеДляПереходаНаНовуюВерсию(Параметры) Экспорт

	ДополнительныеПараметры = ОбновлениеИнформационнойБазы.ДополнительныеПараметрыОтметкиОбработки();
	ДополнительныеПараметры.ЭтоДвижения = Истина;
	ДополнительныеПараметры.ПолноеИмяРегистра = "РегистрНакопления.ТрудозатратыНезавершенногоПроизводства";
	
	Запрос = Новый Запрос("
	|ВЫБРАТЬ РАЗЛИЧНЫЕ
	|	ДанныеРегистра.Регистратор КАК Ссылка
	|ИЗ
	|	РегистрНакопления.ТрудозатратыНезавершенногоПроизводства КАК ДанныеРегистра
	|ГДЕ
	|	ДанныеРегистра.КорАналитикаУчетаПродукции.Назначение <> ДанныеРегистра.КорВидЗапасовПродукции.УстарелоНазначение
	|	И ДанныеРегистра.КорВидЗапасовПродукции.УстарелоНазначение <> ЗНАЧЕНИЕ(Справочник.Назначения.ПустаяСсылка)
	|	И ДанныеРегистра.КорВидЗапасовПродукции <> ЗНАЧЕНИЕ(Справочник.ВидыЗапасов.ПустаяСсылка)
	|	И ДанныеРегистра.КорАналитикаУчетаПродукции <> ЗНАЧЕНИЕ(Справочник.КлючиАналитикиУчетаНоменклатуры.ПустаяСсылка)
	|");
	
	Регистраторы = Запрос.Выполнить().Выгрузить().ВыгрузитьКолонку("Ссылка");
	
	ОбновлениеИнформационнойБазы.ОтметитьКОбработке(Параметры, Регистраторы, ДополнительныеПараметры);
	РегистрыНакопления.ПрочиеАктивыПассивы.ЗарегистироватьКОбновлениюУправленческогоБаланса(Параметры, Регистраторы, ДополнительныеПараметры.ПолноеИмяРегистра);
	
КонецПроцедуры

// Обработчик обновления заполняет новый реквизит "Назначение" в справочнике "Ключи аналитики учета номенклатуры",
// и обновляет движения по регистру.
Процедура ОбработатьДанныеДляПереходаНаНовуюВерсию(Параметры) Экспорт

	ПолноеИмяРегистра = "РегистрНакопления.ТрудозатратыНезавершенногоПроизводства";
	
	ДополнительныеПараметры = ОбновлениеИнформационнойБазы.ДополнительныеПараметрыОтметкиОбработки();
	ДополнительныеПараметры.ЭтоДвижения = Истина;
	ДополнительныеПараметры.ПолноеИмяРегистра = ПолноеИмяРегистра;
	
	Выборка = ОбновлениеИнформационнойБазы.ВыбратьРегистраторыРегистраДляОбработки(Параметры.Очередь, Неопределено, ПолноеИмяРегистра);
	ТекстЗапроса = "
	|ВЫБРАТЬ
	|	Движения.Регистратор            КАК Регистратор,
	|	Движения.Период                 КАК Период,
	|	Движения.ВидДвижения            КАК ВидДвижения,
	|	Движения.Организация                  КАК Организация,
	|	Движения.Подразделение                КАК Подразделение,
	|	Движения.ЗаказНаПроизводство          КАК ЗаказНаПроизводство,
	|	Движения.КодСтрокиПродукция           КАК КодСтрокиПродукция,
	|	Движения.Этап                         КАК Этап,
	|	Движения.СтатьяКалькуляции            КАК СтатьяКалькуляции,
	|	Движения.ВидРабот                     КАК ВидРабот,
	|	Движения.ГруппаПродукции              КАК ГруппаПродукции,
	|	Движения.Количество             КАК Количество,
	|	Движения.НормативнаяСтоимость   КАК НормативнаяСтоимость,
	|	Движения.Стоимость              КАК Стоимость,
	|	Движения.СтоимостьРегл          КАК СтоимостьРегл,
	|	Движения.Продукция                    КАК Продукция,
	|	Движения.ХарактеристикаПродукции      КАК ХарактеристикаПродукции,
	|	Движения.КоличествоПродукции          КАК КоличествоПродукции,
	|	Движения.Сотрудник                    КАК Сотрудник,
	|	ВЫБОР КОГДА Движения.КорВидЗапасовПродукции <> ЗНАЧЕНИЕ(Справочник.ВидыЗапасов.ПустаяСсылка)
	|		И Движения.КорАналитикаУчетаПродукции.Назначение <> Движения.КорВидЗапасовПродукции.УстарелоНазначение
	|		И Движения.КорВидЗапасовПродукции <> ЗНАЧЕНИЕ(Справочник.ВидыЗапасов.ПустаяСсылка)
	|		И Движения.КорАналитикаУчетаПродукции <> ЗНАЧЕНИЕ(Справочник.КлючиАналитикиУчетаНоменклатуры.ПустаяСсылка)
	|		И НЕ Аналитика.КлючАналитики ЕСТЬ NULL
	|		ТОГДА Аналитика.КлючАналитики
	|		ИНАЧЕ Движения.КорАналитикаУчетаПродукции
	|	КОНЕЦ                                 КАК КорАналитикаУчетаПродукции,
	|	Движения.КорРазделУчета               КАК КорРазделУчета,
	|	Движения.КорВидЗапасовПродукции       КАК КорВидЗапасов,
	|	Движения.СтатьяКалькуляцииБезЗаказа   КАК СтатьяКалькуляцииБезЗаказа,
	|	Движения.ДокументВыпуска              КАК ДокументВыпуска,
	|	Движения.КодСтроки                    КАК КодСтроки,
	|
	|	ВЫБОР КОГДА Аналитика.КлючАналитики ЕСТЬ NULL
	|		И Движения.КорАналитикаУчетаПродукции.Назначение <> Движения.КорВидЗапасовПродукции.УстарелоНазначение
	|		И Движения.КорВидЗапасовПродукции.УстарелоНазначение <> ЗНАЧЕНИЕ(Справочник.Назначения.ПустаяСсылка)
	|		И Движения.КорВидЗапасовПродукции <> ЗНАЧЕНИЕ(Справочник.ВидыЗапасов.ПустаяСсылка)
	|		И Движения.КорАналитикаУчетаПродукции <> ЗНАЧЕНИЕ(Справочник.КлючиАналитикиУчетаНоменклатуры.ПустаяСсылка)
	|		ТОГДА 0
	|		ИНАЧЕ 1
	|	КОНЕЦ КАК КлючиИнициализированы
	|ИЗ
	|	РегистрНакопления.ТрудозатратыНезавершенногоПроизводства КАК Движения
	|
	|	ЛЕВОЕ СОЕДИНЕНИЕ Справочник.КлючиАналитикиУчетаНоменклатуры КАК Ключи
	|	ПО Ключи.Ссылка = Движения.КорАналитикаУчетаПродукции
	|
	|	ЛЕВОЕ СОЕДИНЕНИЕ РегистрСведений.АналитикаУчетаНоменклатуры КАК Аналитика
	|	ПО Ключи.Номенклатура = Аналитика.Номенклатура
	|		И Ключи.Характеристика = Аналитика.Характеристика
	|		И Ключи.Серия = Аналитика.Серия
	|		И Ключи.МестоХранения = Аналитика.МестоХранения
	|		И Ключи.СтатьяКалькуляции = Аналитика.СтатьяКалькуляции
	|		И Движения.КорВидЗапасовПродукции.УстарелоНазначение = Аналитика.Назначение
	|
	|ГДЕ
	|	Движения.Регистратор = &Регистратор
	|
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
			
			Набор = РегистрыНакопления.ТрудозатратыНезавершенногоПроизводства.СоздатьНаборЗаписей();
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
			ЗаписьЖурналаРегистрации(ОбновлениеИнформационнойБазы.СобытиеЖурналаРегистрации(), УровеньЖурналаРегистрации.Ошибка,
				Регистратор.Метаданные(), ТекстСообщения);
		КонецПопытки;
	КонецЦикла;
	
	Параметры.ОбработкаЗавершена = Не ОбновлениеИнформационнойБазы.ЕстьДанныеДляОбработки(Параметры.Очередь, ПолноеИмяРегистра);
	
КонецПроцедуры


#КонецОбласти

#КонецОбласти

#КонецЕсли
