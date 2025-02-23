#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ПрограммныйИнтерфейс

#Область ДляВызоваИзДругихПодсистем

// СтандартныеПодсистемы.УправлениеДоступом

// См. УправлениеДоступомПереопределяемый.ПриЗаполненииСписковСОграничениемДоступа.
Процедура ПриЗаполненииОграниченияДоступа(Ограничение) Экспорт

	Ограничение.Текст =
	"РазрешитьЧтениеИзменение
	|ГДЕ
	|	ЗначениеРазрешено(Касса)
	|	И ЗначениеРазрешено(Организация)";

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
	Обработчик.Процедура = "РегистрыНакопления.ДенежныеСредстваНаличные.ОбработатьДанныеДляПереходаНаНовуюВерсию";
    Обработчик.Версия = "3.5.4.400";
	Обработчик.РежимВыполнения = "Отложенно";
	Обработчик.Идентификатор = Новый УникальныйИдентификатор("09f685ad-fe4d-4da1-89ef-381073257d63");
	Обработчик.Многопоточный = Истина;
	Обработчик.ПроцедураЗаполненияДанныхОбновления = "РегистрыНакопления.ДенежныеСредстваНаличные.ЗарегистрироватьДанныеКОбработкеДляПереходаНаНовуюВерсию";
	Обработчик.ПроцедураПроверки = "ОбновлениеИнформационнойБазы.ДанныеОбновленыНаНовуюВерсиюПрограммы";
	Обработчик.Комментарий = НСтр("ru='Обновляет данные переоценки в регистре ""Денежные средства безналичные"".
                                   |Заполняет реквизит ОбъектРасчетов.'
                                   |;uk='Оновлює дані переоцінки у регістрі ""Грошові кошти безготівкові"".
                                   |Заповнює реквізит ОбъектРасчетов.'");
	
	Читаемые = Новый Массив;
	Читаемые.Добавить(Метаданные.РегистрыНакопления.ДенежныеСредстваНаличные.ПолноеИмя());
	Читаемые.Добавить(Метаданные.Справочники.ОбъектыРасчетов.ПолноеИмя());
    Читаемые.Добавить(Метаданные.Документы.РасчетКурсовыхРазниц.ПолноеИмя());
	Обработчик.ЧитаемыеОбъекты = СтрСоединить(Читаемые, ",");
	
	Изменяемые = Новый Массив;
	Изменяемые.Добавить(Метаданные.РегистрыНакопления.ДенежныеСредстваНаличные.ПолноеИмя());
	Обработчик.ИзменяемыеОбъекты = СтрСоединить(Изменяемые, ",");
	
	Обработчик.ПриоритетыВыполнения = ОбновлениеИнформационнойБазы.ПриоритетыВыполненияОбработчика();


	НоваяСтрока = Обработчик.ПриоритетыВыполнения.Добавить();
	НоваяСтрока.Процедура = "Справочники.ДоговорыКонтрагентов.ОбработатьДанныеДляПереходаНаНовуюВерсию";
	НоваяСтрока.Порядок = "После";

	НоваяСтрока = Обработчик.ПриоритетыВыполнения.Добавить();
	НоваяСтрока.Процедура = "Справочники.ДоговорыМеждуОрганизациями.ОбработатьДанныеДляПереходаНаНовуюВерсию";
	НоваяСтрока.Порядок = "После";

    
	НоваяСтрока = Обработчик.ПриоритетыВыполнения.Добавить();
	НоваяСтрока.Процедура = "РегистрыНакопления.ПрочиеАктивыПассивы.ОбработатьДанныеДляПереходаНаНовуюВерсию";
	НоваяСтрока.Порядок = "До";  
	
	Исключения = ОбновлениеИнформационнойБазыПереопределяемый.ИсключенияПриДобавленииПриоритетов();
	ОбновлениеИнформационнойБазыПереопределяемый.ДобавитьПриоритетыСгенерироватьОбъектыРасчетов(
		Обработчик.ПриоритетыВыполнения,
		"После",
		Исключения
	);

КонецПроцедуры

Функция ПолноеИмяРегистра()
	
	Возврат "РегистрНакопления.ДенежныеСредстваНаличные";
	
КонецФункции

// Параметры:
// 	Параметры - см. ОбновлениеИнформационнойБазы.ОсновныеПараметрыОтметкиКОбработке
//
Процедура ЗарегистрироватьДанныеКОбработкеДляПереходаНаНовуюВерсию(Параметры = Неопределено) Экспорт
	
	ПолноеИмяРегистра = СоздатьНаборЗаписей().Метаданные().ПолноеИмя();
	
	ПараметрыВыборки = Параметры.ПараметрыВыборки;
	ПараметрыВыборки.ПолныеИменаРегистров = ПолноеИмяРегистра;
	ПараметрыВыборки.ПоляУпорядочиванияПриРаботеПользователей.Добавить("Регистратор.Дата УБЫВ");
	ПараметрыВыборки.ПоляУпорядочиванияПриОбработкеДанных.Добавить("Регистратор");
	ПараметрыВыборки.СпособВыборки = ОбновлениеИнформационнойБазы.СпособВыборкиРегистраторыРегистра();
	
	Запрос = Новый Запрос;
	Запрос.МенеджерВременныхТаблиц = Новый МенеджерВременныхТаблиц;
	
	ТекстЗапроса = 
	"ВЫБРАТЬ РАЗЛИЧНЫЕ
	|	ДанныеРегистра.Регистратор
	|ИЗ
	|	РегистрНакопления.ДенежныеСредстваНаличные КАК ДанныеРегистра
	|ГДЕ
	|	ДанныеРегистра.ОбъектРасчетов = ЗНАЧЕНИЕ(Справочник.ОбъектыРасчетов.ПустаяСсылка)
	|		И НЕ ДанныеРегистра.УдалитьЗаказ В (&ПустыеЗначенияОбъектовРасчета)";
	
	Запрос = Новый Запрос(ТекстЗапроса);
	Запрос.УстановитьПараметр("ПустыеЗначенияОбъектовРасчета", ОбъектыРасчетовСервер.ПустыеЗначенияОбъектРасчетов());
	Регистраторы = Запрос.Выполнить().Выгрузить().ВыгрузитьКолонку("Регистратор");
	
	ОбновлениеИнформационнойБазы.ОтметитьРегистраторыКОбработке(
		Параметры, 
		Регистраторы,
		ПолноеИмяРегистра
    );   
    
	Запрос = Новый Запрос;
	Запрос.Текст = 
	"ВЫБРАТЬ РАЗЛИЧНЫЕ
	|		ДанныеРегистра.Регистратор КАК Регистратор
	|	ИЗ
	|		РегистрНакопления.ДенежныеСредстваНаличные КАК ДанныеРегистра
	|	ГДЕ
	|		ТИПЗНАЧЕНИЯ(ДанныеРегистра.Регистратор) = ТИП(Документ.РасчетКурсовыхРазниц)
	|		И ДанныеРегистра.ХозяйственнаяОперация = ЗНАЧЕНИЕ(Перечисление.ХозяйственныеОперации.ПереоценкаДенежныхСредств)
	|";
	
	Регистраторы = Запрос.Выполнить().Выгрузить().ВыгрузитьКолонку("Регистратор");
	ОбновлениеИнформационнойБазы.ОтметитьРегистраторыКОбработке(Параметры, Регистраторы, ПолноеИмяРегистра());
	
	РегистрыНакопления.ПрочиеАктивыПассивы.ЗарегистироватьКОбновлениюУправленческогоБаланса(Параметры, Регистраторы, ПолноеИмяРегистра());
	
КонецПроцедуры

Процедура ОбработатьДанныеДляПереходаНаНовуюВерсию(Параметры) Экспорт
	
	МетаданныеРегистра = СоздатьНаборЗаписей().Метаданные();
	ПолноеИмяРегистра = МетаданныеРегистра.ПолноеИмя();
	ОбновляемыеДанные = ОбновлениеИнформационнойБазы.ДанныеДляОбновленияВМногопоточномОбработчике(Параметры);
	
	Если ОбновляемыеДанные.Количество() = 0
		Или Не ОбъектыРасчетовСервер.ВсеОбъектыРасчетовСгенерированы(Параметры.Очередь) Тогда
		Параметры.ОбработкаЗавершена = ОбновлениеИнформационнойБазы.ОбработкаДанныхЗавершена(Параметры.Очередь, ПолноеИмяРегистра);
		Возврат;
	КонецЕсли;
	
	Запрос = Новый Запрос;
	Запрос.Текст = "ВЫБРАТЬ
	|	ЕСТЬNULL(ОбъектыРасчетовКлиент.Ссылка, ЕСТЬNULL(ОбъектыРасчетовПоставщик.Ссылка,
	|		ЗНАЧЕНИЕ(Справочник.ОбъектыРасчетов.ПустаяСсылка))) КАК ОбъектРасчетов,
	|	ДанныеРегистра.НомерСтроки КАК НомерСтроки,
	|	ДанныеРегистра.Регистратор КАК Регистратор
	|ИЗ
	|	РегистрНакопления.ДенежныеСредстваНаличные КАК ДанныеРегистра
	|		ЛЕВОЕ СОЕДИНЕНИЕ Справочник.ОбъектыРасчетов КАК ОбъектыРасчетовКлиент
	|			ПО ДанныеРегистра.УдалитьЗаказ = ОбъектыРасчетовКлиент.Объект
	|			И ОбъектыРасчетовКлиент.ТипРасчетов = ЗНАЧЕНИЕ(Перечисление.ТипыРасчетовСПартнерами.РасчетыСКлиентом)
	|			И ОбъектыРасчетовКлиент.Организация.ГоловнаяОрганизация = ДанныеРегистра.АналитикаУчетаПоПартнерам.Организация.ГоловнаяОрганизация
	|			И НЕ ДанныеРегистра.УдалитьЗаказ В (&ПустыеЗначенияОбъектовРасчетов)
	|			И ДанныеРегистра.УдалитьЗаказ ССЫЛКА Документ.ЗаказКлиента
	|		ЛЕВОЕ СОЕДИНЕНИЕ Справочник.ОбъектыРасчетов КАК ОбъектыРасчетовПоставщик
	|			ПО ДанныеРегистра.УдалитьЗаказ = ОбъектыРасчетовПоставщик.Объект
	|			И ОбъектыРасчетовПоставщик.ТипРасчетов = ЗНАЧЕНИЕ(Перечисление.ТипыРасчетовСПартнерами.РасчетыСПоставщиком)
	|			И ОбъектыРасчетовПоставщик.Организация.ГоловнаяОрганизация = ДанныеРегистра.АналитикаУчетаПоПартнерам.Организация.ГоловнаяОрганизация
	|			И НЕ ДанныеРегистра.УдалитьЗаказ В (&ПустыеЗначенияОбъектовРасчетов)
	|			И ДанныеРегистра.УдалитьЗаказ ССЫЛКА Документ.ЗаказПоставщику
	|ГДЕ
	|	ДанныеРегистра.Регистратор В (&Регистраторы)
	|ИТОГИ
	|ПО
	|	Регистратор";
	
	Запрос.УстановитьПараметр("ПустыеЗначенияОбъектовРасчетов", ОбъектыРасчетовСервер.ПустыеЗначенияОбъектРасчетов());
	
	НачатьТранзакцию();
	
	Попытка
	
		Блокировка = Новый БлокировкаДанных;
		ЭлементБлокировки = Блокировка.Добавить(ПолноеИмяРегистра + ".НаборЗаписей");
		ЭлементБлокировки.Режим = РежимБлокировкиДанных.Исключительный;
		ЭлементБлокировки.ИсточникДанных = ОбновляемыеДанные;
		ЭлементБлокировки.ИспользоватьИзИсточникаДанных("Регистратор", "Регистратор");
		Блокировка.Заблокировать();
		
		Запрос.УстановитьПараметр("Регистраторы", ОбновляемыеДанные.ВыгрузитьКолонку("Регистратор"));
		РезультатЗапроса = Запрос.Выполнить();
		
		ВыборкаРегистратор = РезультатЗапроса.Выбрать(ОбходРезультатаЗапроса.ПоГруппировкам);
		
		Пока ВыборкаРегистратор.Следующий() Цикл
			ВыборкаДетальныеЗаписи = ВыборкаРегистратор.Выбрать();
			НаборЗаписей = РегистрыНакопления[МетаданныеРегистра.Имя].СоздатьНаборЗаписей();
			НаборЗаписей.Отбор.Регистратор.Установить(ВыборкаРегистратор.Регистратор);
			НаборЗаписей.Прочитать();
			
			Пока ВыборкаДетальныеЗаписи.Следующий() Цикл
				СтрокаНабора = НаборЗаписей[ВыборкаДетальныеЗаписи.НомерСтроки - 1];
				
				Если Не ЗначениеЗаполнено(СтрокаНабора.ОбъектРасчетов) Тогда
					Если ЗначениеЗаполнено(ВыборкаДетальныеЗаписи.ОбъектРасчетов)
						И ЗначениеЗаполнено(СтрокаНабора.УдалитьЗаказ) Тогда
						СтрокаНабора.ОбъектРасчетов = ВыборкаДетальныеЗаписи.ОбъектРасчетов;
					ИначеЕсли Не ЗначениеЗаполнено(ВыборкаДетальныеЗаписи.ОбъектРасчетов)
								И ЗначениеЗаполнено(СтрокаНабора.УдалитьЗаказ) Тогда
									ВызватьИсключение (СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(
										НСтр("ru='Не удалось заполнить объект расчетов в регистре накопления: %1 по источнику данных %2';uk='Не вдалося заповнити об''єкт розрахунків в регістрі накопичення: %1 по джерелу даних %2'"),
										ПолноеИмяРегистра,
										ВыборкаДетальныеЗаписи.УдалитьОбъектРасчетов));
					КонецЕсли;
				КонецЕсли;
			КонецЦикла;
			
			Если НаборЗаписей.Модифицированность() Тогда
				ОбновлениеИнформационнойБазы.ЗаписатьНаборЗаписей(НаборЗаписей);
			Иначе
				ОбновлениеИнформационнойБазы.ОтметитьВыполнениеОбработки(НаборЗаписей);
			КонецЕсли;
		
		КонецЦикла;
		
		ЗафиксироватьТранзакцию();
		
	Исключение
	
		ОтменитьТранзакцию();
		
		Шаблон = НСтр("ru='Не удалось записать данные в регистр %1 , по причине: %2';uk='Не вдалося записати дані в регістр %1, з причини: %2'");
		ТекстСообщения = СтрШаблон(Шаблон,
			ПолноеИмяРегистра,
			ПодробноеПредставлениеОшибки(ИнформацияОбОшибке()));
		
		ЗаписьЖурналаРегистрации(ОбновлениеИнформационнойБазы.СобытиеЖурналаРегистрации(),
			УровеньЖурналаРегистрации.Предупреждение,
			МетаданныеРегистра,
			,
			ТекстСообщения);
	
	КонецПопытки;
    
	// Заменить хоз.операции в переоценке валютных средств
	Документы.РасчетКурсовыхРазниц.ЗаполнитьХозОперациюИСтатьюДДС(Параметры, ПолноеИмяРегистра(), Истина);
    
	Параметры.ОбработкаЗавершена = Не ОбновлениеИнформационнойБазы.ЕстьДанныеДляОбработки(Параметры.Очередь, ПолноеИмяРегистра);
	
КонецПроцедуры

#КонецОбласти

#КонецОбласти

#КонецЕсли
