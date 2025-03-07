#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ПрограммныйИнтерфейс

#Область ДляВызоваИзДругихПодсистем

// СтандартныеПодсистемы.УправлениеДоступом

// См. УправлениеДоступомПереопределяемый.ПриЗаполненииСписковСОграничениемДоступа.
Процедура ПриЗаполненииОграниченияДоступа(Ограничение) Экспорт

	Ограничение.Текст =
	"РазрешитьЧтениеИзменение
	|ГДЕ
	|	ЗначениеРазрешено(Склад)
	|	И ЗначениеРазрешено(Сценарий)
	|	И ЗначениеРазрешено(ВидПлана)";

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
	Обработчик.Процедура = "РегистрыНакопления.ПланыПотребленияКомплектующих.ОбработатьДанныеДляПереходаНаНовуюВерсию";
    Обработчик.Версия = "3.5.4.400";
	Обработчик.РежимВыполнения = "Отложенно";
	Обработчик.Идентификатор = Новый УникальныйИдентификатор("24aab2e0-70e4-4024-b86a-6faf17f4feab");
	Обработчик.ПроцедураЗаполненияДанныхОбновления = "РегистрыНакопления.ПланыПотребленияКомплектующих.ЗарегистрироватьДанныеКОбработкеДляПереходаНаНовуюВерсию";
	Обработчик.ПроцедураПроверки = "ОбновлениеИнформационнойБазы.ДанныеОбновленыНаНовуюВерсиюПрограммы";
	Обработчик.Комментарий = НСтр("ru='Обновляет движения документа ""План сборки(разборки)"" по регистру накопления ""Планы  потребления комплектующих"".
                                   |Данные в регистре накопления ""Планы потребления комплектующих"" не рекомендуется использовать до момента завершения обработки. Данные будут некорректны.'
                                   |;uk='Оновлює рух документа ""План збирання(розбирання)"" по регістру накопичення ""Плани споживання комплектуючих"".
                                   |Дані в регістрі накопичення ""Плани споживання комплектуючих"" не рекомендується використовувати до завершення обробки. Дані будуть некоректні.'");
	
	Читаемые = Новый Массив;
	Читаемые.Добавить(Метаданные.Документы.ПланСборкиРазборки.ПолноеИмя());
	Читаемые.Добавить(Метаданные.РегистрыНакопления.ПланыПотребленияКомплектующих.ПолноеИмя());
	Обработчик.ЧитаемыеОбъекты = СтрСоединить(Читаемые, ",");
	
	Изменяемые = Новый Массив;
	Изменяемые.Добавить(Метаданные.РегистрыНакопления.ПланыПотребленияКомплектующих.ПолноеИмя());
	Обработчик.ИзменяемыеОбъекты = СтрСоединить(Изменяемые, ",");
	
	Обработчик.ПриоритетыВыполнения = ОбновлениеИнформационнойБазы.ПриоритетыВыполненияОбработчика();

	НоваяСтрока = Обработчик.ПриоритетыВыполнения.Добавить();
	НоваяСтрока.Процедура = "Документы.ПланСборкиРазборки.ОбработатьДанныеДляПереходаНаНовуюВерсию";
	НоваяСтрока.Порядок = "После";

КонецПроцедуры

// Процедура регистрации данных для обработчика обновления ОбработатьДанныеДляПереходаНаВерсию.
//
Процедура ЗарегистрироватьДанныеКОбработкеДляПереходаНаНовуюВерсию(Параметры) Экспорт
    
	ПолноеИмяДокумента = "Документ.ПланСборкиРазборки";
	ПолноеИмяРегистра = "РегистрНакопления.ПланыСборкиРазборки";
	ИмяРегистра       = "ПланыСборкиРазборки";
	
	ТекстЗапроса = Документы.ПланСборкиРазборки.АдаптированныйТекстЗапросаДвиженийПоРегистру(ИмяРегистра);
	
	Регистраторы = ОбновлениеИнформационнойБазыУТ.РегистраторыДляПерепроведения(
		ТекстЗапроса, 
        ПолноеИмяРегистра, 
        ПолноеИмяДокумента
    );
	
	Запрос = Новый Запрос;
	Запрос.Текст = Документы.ПланСборкиРазборки.ТекстЗапросаДанныеКОбработке();
	
	ЗапросПакет = Запрос.ВыполнитьПакет();
	ОбщегоНазначенияКлиентСервер.ДополнитьМассив(
        Регистраторы, 
        ЗапросПакет[4].Выгрузить().ВыгрузитьКолонку("Ссылка")
    );
	
	ПолноеИмяРегистра = "РегистрНакопления.ПланыПотребленияКомплектующих";
	
	ОбновлениеИнформационнойБазы.ОтметитьРегистраторыКОбработке(
		Параметры, 
        Регистраторы, 
        ПолноеИмяРегистра
    );   
    
	Запрос = Новый Запрос;
	Запрос.Текст = 
	"ВЫБРАТЬ РАЗЛИЧНЫЕ
	|	Планы.Регистратор КАК Ссылка
	|ИЗ
	|	РегистрНакопления.ПланыПотребленияКомплектующих КАК Планы
	|ГДЕ
	|	Планы.Статус = ЗНАЧЕНИЕ(Перечисление.СтатусыПланов.ПустаяСсылка)";
	
	Регистраторы = Запрос.Выполнить().Выгрузить().ВыгрузитьКолонку("Ссылка");
	
	ОбновлениеИнформационнойБазы.ОтметитьРегистраторыКОбработке(Параметры, Регистраторы, ПолноеИмяРегистра);
	
	// Заполнение нового измерения "ХозяйственнаяОперация"
	Запрос = Новый Запрос;
	Запрос.Текст = 
	"ВЫБРАТЬ РАЗЛИЧНЫЕ
	|	Планы.Регистратор КАК Ссылка
	|ИЗ
	|	РегистрНакопления.ПланыПотребленияКомплектующих КАК Планы
	|ГДЕ
	|	Планы.ХозяйственнаяОперация = ЗНАЧЕНИЕ(Перечисление.ХозяйственныеОперации.ПустаяСсылка)";
	
	Регистраторы = Запрос.Выполнить().Выгрузить().ВыгрузитьКолонку("Ссылка");
	
	ОбновлениеИнформационнойБазы.ОтметитьРегистраторыКОбработке(Параметры, Регистраторы, ПолноеИмяРегистра);
	
КонецПроцедуры

Процедура ОбработатьДанныеДляПереходаНаНовуюВерсию(Параметры) Экспорт
	
	ПолноеИмяДокумента = "Документ.ПланСборкиРазборки";
	
	ПолноеИмяРегистра = "РегистрНакопления.ПланыПотребленияКомплектующих";
	МетаданныеРегистра = Метаданные.РегистрыНакопления.ПланыПотребленияКомплектующих;
	
	МенеджерВременныхТаблиц = Новый МенеджерВременныхТаблиц;
	
	ДополнительныеПараметры = ОбновлениеИнформационнойБазы.ДополнительныеПараметрыОтметкиОбработки();
	ДополнительныеПараметры.ЭтоДвижения = Истина;
	ДополнительныеПараметры.ПолноеИмяРегистра = ПолноеИмяРегистра;
	
	ТекстЗапроса = 
	"ВЫБРАТЬ
	|	ПланыПотребленияКомплектующих.Период КАК Период,
	|	ПланыПотребленияКомплектующих.Регистратор КАК Регистратор,
	|	ПланыПотребленияКомплектующих.НомерСтроки КАК НомерСтроки,
	|	ПланыПотребленияКомплектующих.Активность КАК Активность,
	|	ПланыПотребленияКомплектующих.Сценарий КАК Сценарий,
	|	ПланыПотребленияКомплектующих.Статус КАК Статус,
	|	ПланыПотребленияКомплектующих.ХозяйственнаяОперация КАК ХозяйственнаяОперация,
	|	ПланыПотребленияКомплектующих.Номенклатура КАК Номенклатура,
	|	ПланыПотребленияКомплектующих.Характеристика КАК Характеристика,
	|	ПланыПотребленияКомплектующих.Склад КАК Склад,
	|	ПланыПотребленияКомплектующих.ПланСборкиРазборки КАК ПланСборкиРазборки,
	|	ПланыПотребленияКомплектующих.ДатаВыпуска КАК ДатаВыпуска,
	|	ВЫБОР ПланыПотребленияКомплектующих.Регистратор.Периодичность
	|		КОГДА ЗНАЧЕНИЕ(Перечисление.Периодичность.Неделя)
	|			ТОГДА НАЧАЛОПЕРИОДА(ПланыПотребленияКомплектующих.ДатаВыпуска, НЕДЕЛЯ)
	|		КОГДА ЗНАЧЕНИЕ(Перечисление.Периодичность.Декада)
	|			ТОГДА НАЧАЛОПЕРИОДА(ПланыПотребленияКомплектующих.ДатаВыпуска, ДЕКАДА)
	|		КОГДА ЗНАЧЕНИЕ(Перечисление.Периодичность.Месяц)
	|			ТОГДА НАЧАЛОПЕРИОДА(ПланыПотребленияКомплектующих.ДатаВыпуска, МЕСЯЦ)
	|		КОГДА ЗНАЧЕНИЕ(Перечисление.Периодичность.Квартал)
	|			ТОГДА НАЧАЛОПЕРИОДА(ПланыПотребленияКомплектующих.ДатаВыпуска, КВАРТАЛ)
	|		КОГДА ЗНАЧЕНИЕ(Перечисление.Периодичность.Полугодие)
	|			ТОГДА НАЧАЛОПЕРИОДА(ПланыПотребленияКомплектующих.ДатаВыпуска, ПОЛУГОДИЕ)
	|		КОГДА ЗНАЧЕНИЕ(Перечисление.Периодичность.Год)
	|			ТОГДА НАЧАЛОПЕРИОДА(ПланыПотребленияКомплектующих.ДатаВыпуска, ГОД)
	|		ИНАЧЕ ПланыПотребленияКомплектующих.ДатаВыпуска
	|	КОНЕЦ КАК ПериодДатыВыпуска,
	|	ПланыПотребленияКомплектующих.Назначение КАК Назначение,
	|	ПланыПотребленияКомплектующих.Количество КАК Количество,
	|	ВЫБОР
	|		КОГДА ПланыПотребленияКомплектующих.КЗаказу <> 0
	|			ТОГДА ПланыПотребленияКомплектующих.КЗаказу
	|		КОГДА ПланыПотребленияКомплектующих.Статус = ЗНАЧЕНИЕ(Перечисление.СтатусыПланов.Утвержден)
	|			ТОГДА ПланыПотребленияКомплектующих.Количество
	|		ИНАЧЕ 0
	|	КОНЕЦ КАК КЗаказу,
	|	ПланыПотребленияКомплектующих.ВариантКомплектации КАК ВариантКомплектации,
	|	ПланыПотребленияКомплектующих.Регистратор.ВидПлана КАК ВидПлана
	|ПОМЕСТИТЬ ПланыПотребленияКомплектующих
	|ИЗ
	|	РегистрНакопления.ПланыПотребленияКомплектующих КАК ПланыПотребленияКомплектующих
	|ГДЕ
	|	ПланыПотребленияКомплектующих.Регистратор = &Регистратор
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ
	|	ЗамещениеПланов.ЗамещенныйПериод КАК ЗамещенныйПериод
	|ПОМЕСТИТЬ ЗамещенныеПериоды
	|ИЗ
	|	РегистрСведений.ЗамещениеПланов КАК ЗамещениеПланов
	|ГДЕ
	|	ЗамещениеПланов.ЗамещенныйПлан = &Регистратор
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ
	|	ПланыПотребленияКомплектующих.Период КАК Период,
	|	ПланыПотребленияКомплектующих.Регистратор КАК Регистратор,
	|	ПланыПотребленияКомплектующих.НомерСтроки КАК НомерСтроки,
	|	ПланыПотребленияКомплектующих.Активность КАК Активность,
	|	ПланыПотребленияКомплектующих.Сценарий КАК Сценарий,
	|	ПланыПотребленияКомплектующих.Статус КАК Статус,
	|	ПланыПотребленияКомплектующих.ХозяйственнаяОперация КАК ХозяйственнаяОперация,
	|	ПланыПотребленияКомплектующих.Номенклатура КАК Номенклатура,
	|	ПланыПотребленияКомплектующих.Характеристика КАК Характеристика,
	|	ПланыПотребленияКомплектующих.Склад КАК Склад,
	|	ПланыПотребленияКомплектующих.ПланСборкиРазборки КАК ПланСборкиРазборки,
	|	ПланыПотребленияКомплектующих.ДатаВыпуска КАК ДатаВыпуска,
	|	ПланыПотребленияКомплектующих.ПериодДатыВыпуска КАК ПериодДатыВыпуска,
	|	ПланыПотребленияКомплектующих.Назначение КАК Назначение,
	|	ПланыПотребленияКомплектующих.Количество КАК Количество,
	|	ПланыПотребленияКомплектующих.КЗаказу КАК КЗаказу,
	|	ПланыПотребленияКомплектующих.ВариантКомплектации КАК ВариантКомплектации,
	|	ПланыПотребленияКомплектующих.ВидПлана КАК ВидПлана
	|ИЗ
	|	ПланыПотребленияКомплектующих КАК ПланыПотребленияКомплектующих
	|		ЛЕВОЕ СОЕДИНЕНИЕ ЗамещенныеПериоды КАК ЗамещенныеПериоды
	|		ПО ПланыПотребленияКомплектующих.ПериодДатыВыпуска = ЗамещенныеПериоды.ЗамещенныйПериод
	|ГДЕ
    |	ЗамещенныеПериоды.ЗамещенныйПериод ЕСТЬ NULL
    |	ИЛИ ПланыПотребленияКомплектующих.Статус = ЗНАЧЕНИЕ(Перечисление.СтатусыПланов.ПустаяСсылка)
    |	ИЛИ ПланыПотребленияКомплектующих.ХозяйственнаяОперация = ЗНАЧЕНИЕ(Перечисление.ХозяйственныеОперации.ПустаяСсылка)
    |";
	
	Выборка = ОбновлениеИнформационнойБазы.ВыбратьРегистраторыРегистраДляОбработки(
        Параметры.Очередь, 
        Неопределено, 
        ПолноеИмяРегистра
    );
    
    Пока Выборка.Следующий() Цикл
		
		Регистратор = Выборка.Регистратор;
		
		НачатьТранзакцию();
		Попытка
			Блокировка = Новый БлокировкаДанных;
			
			ЭлементБлокировки = Блокировка.Добавить(ПолноеИмяДокумента);
			ЭлементБлокировки.УстановитьЗначение("Ссылка", Регистратор);
			ЭлементБлокировки.Режим = РежимБлокировкиДанных.Разделяемый;
			
			ЭлементБлокировки = Блокировка.Добавить("РегистрСведений.ЗамещениеПланов");
			ЭлементБлокировки.УстановитьЗначение("ЗамещенныйПлан", Регистратор);
			ЭлементБлокировки.Режим = РежимБлокировкиДанных.Исключительный;
			
			ЭлементБлокировки = Блокировка.Добавить(ПолноеИмяРегистра + ".НаборЗаписей");
			ЭлементБлокировки.УстановитьЗначение("Регистратор", Регистратор);
			ЭлементБлокировки.Режим = РежимБлокировкиДанных.Исключительный;
			
			Блокировка.Заблокировать();
			
			Запрос = Новый Запрос(ТекстЗапроса);
			Запрос.УстановитьПараметр("Регистратор", Регистратор);
			
			Набор = РегистрыНакопления.ПланыПотребленияКомплектующих.СоздатьНаборЗаписей();
			Набор.Отбор.Регистратор.Установить(Регистратор);
			
			Результат = Запрос.Выполнить().Выгрузить();
			Набор.Загрузить(Результат); 
            
			// Выполним ответственное чтение реквизитов "Проведен", "Статус" и "ХозяйственнаяОперация"
			ОбъектМетаданных = Регистратор.Метаданные();
			ЕстьХозОперация = ОбщегоНазначения.ЕстьРеквизитОбъекта("ХозяйственнаяОперация", ОбъектМетаданных);
			ЗаполняемыеРеквизиты = ?(ЕстьХозОперация, "Проведен, Статус, ХозяйственнаяОперация", "Проведен, Статус");
			
			Реквизиты = ОбщегоНазначения.ЗначенияРеквизитовОбъекта(Регистратор, ЗаполняемыеРеквизиты);
            
			Если Набор.Количество() > 0
				И Реквизиты.Проведен Тогда
				
				Для каждого Запись Из Набор Цикл
					ЗаполнитьЗначенияСвойств(Запись, Реквизиты); // "Статус" и "ХозяйственнаяОперация"
				КонецЦикла;
				Набор.УстановитьАктивность(Истина);
            КонецЕсли;      
            
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
