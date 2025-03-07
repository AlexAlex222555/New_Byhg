#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ПрограммныйИнтерфейс

#Область ДляВызоваИзДругихПодсистем

// СтандартныеПодсистемы.УправлениеДоступом

// См. УправлениеДоступом.ЗаполнитьНаборыЗначенийДоступа
// 
// Параметры:
// 	Таблица - См. УправлениеДоступом.ТаблицаНаборыЗначенийДоступа
//
Процедура ЗаполнитьНаборыЗначенийДоступа(Таблица) Экспорт
	
	Партнер = Неопределено;
	
	Если ЗначениеЗаполнено(Предмет) Тогда
		Партнер = ОбщегоНазначения.ЗначениеРеквизитаОбъекта(Предмет, "Партнер");
	КонецЕсли;
	
	СтрокаТаб = Таблица.Добавить();
	СтрокаТаб.НомерНабора = 1;
	СтрокаТаб.ЗначениеДоступа = Партнер;
	
	СтрокаТаб = Таблица.Добавить();
	СтрокаТаб.НомерНабора = 2;
	СтрокаТаб.ЗначениеДоступа = Автор;
	
КонецПроцедуры

// Конец СтандартныеПодсистемы.УправлениеДоступом

#КонецОбласти

#КонецОбласти

#Область ОбработчикиСобытий

Процедура ПервичныйКонтактПередСозданиемЗадач(ТочкаМаршрутаБизнесПроцесса, ФормируемыеЗадачи, СтандартнаяОбработка)

	СделкиСервер.УстановитьЭтапПроцесса(Предмет, Справочники.СостоянияПроцессов.ПервичныйКонтакт);

КонецПроцедуры

Процедура КвалификацияКлиентаПередСозданиемЗадач(ТочкаМаршрутаБизнесПроцесса, ФормируемыеЗадачи, СтандартнаяОбработка)

	СделкиСервер.УстановитьЭтапПроцесса(Предмет, Справочники.СостоянияПроцессов.КвалификацияКлиента);

КонецПроцедуры

Процедура ПодготовкаПредложенияПередСозданиемЗадач(ТочкаМаршрутаБизнесПроцесса, ФормируемыеЗадачи, СтандартнаяОбработка)

	СделкиСервер.УстановитьЭтапПроцесса(Предмет, Справочники.СостоянияПроцессов.ФормированиеПредложения);

КонецПроцедуры

Процедура ПрезентацияПередСозданиемЗадач(ТочкаМаршрутаБизнесПроцесса, ФормируемыеЗадачи, СтандартнаяОбработка)

	СделкиСервер.УстановитьЭтапПроцесса(Предмет, Справочники.СостоянияПроцессов.Презентация);

КонецПроцедуры

Процедура ТоргПередСозданиемЗадач(ТочкаМаршрутаБизнесПроцесса, ФормируемыеЗадачи, СтандартнаяОбработка)

	СделкиСервер.УстановитьЭтапПроцесса(Предмет, Справочники.СостоянияПроцессов.СогласованиеУсловий);

КонецПроцедуры

Процедура ПодтверждениеОбязательствПередСозданиемЗадач(ТочкаМаршрутаБизнесПроцесса, ФормируемыеЗадачи, СтандартнаяОбработка)

	СделкиСервер.УстановитьЭтапПроцесса(Предмет, Справочники.СостоянияПроцессов.ПодготовкаКВыполнениюОбязательств);

КонецПроцедуры

Процедура КонтрольВыполненияОбязательствПередСозданиемЗадач(ТочкаМаршрутаБизнесПроцесса, ФормируемыеЗадачи, СтандартнаяОбработка)

	СделкиСервер.УстановитьЭтапПроцесса(Предмет, Справочники.СостоянияПроцессов.ВыполнениеОбязательств);

КонецПроцедуры

Процедура ФиксацияРезультатовСделкиПриВыполнении(ТочкаМаршрутаБизнесПроцесса, Задача, Отказ)
	
	Если Предмет.Статус = Перечисления.СтатусыСделок.Проиграна Тогда
		Результат = ЗначениеЗаполнено(Предмет.ПричинаПроигрышаСделки);
		Если НЕ Результат Тогда
			ОбщегоНазначенияКлиентСервер.СообщитьПользователю(
			НСтр("ru='Для выполнения задачи необходимо определить причину проигрыша сделки';uk='Для виконання задачі необхідно визначити причину програшу угоди'"));
		КонецЕсли;
	ИначеЕсли Предмет.Статус = Перечисления.СтатусыСделок.ВРаботе Тогда
		ОбщегоНазначенияКлиентСервер.СообщитьПользователю(
			НСтр("ru='Для выполнения задачи сделка должна находится в статусе выиграна или проиграна.';uk='Для виконання задачі угода повинна знаходиться в статусі виграна або програна.'"));
		Результат = Ложь;
	Иначе
		Результат = Истина;
	КонецЕсли;
	
	УстановитьПривилегированныйРежим(Истина);
	
	Если Результат Тогда
		Запрос = Новый Запрос;
		Запрос.Текст = "ВЫБРАТЬ ПЕРВЫЕ 1
		|	СделкиСКлиентамиПервичныйСпрос.НомерСтроки КАК НомерСтроки
		|ИЗ
		|	Справочник.СделкиСКлиентами.ПервичныйСпрос КАК СделкиСКлиентамиПервичныйСпрос
		|ГДЕ
		|	СделкиСКлиентамиПервичныйСпрос.Ссылка = &Предмет
		|	И СделкиСКлиентамиПервичныйСпрос.ПроцентУдовлетворения <> 100
		|	И СделкиСКлиентамиПервичныйСпрос.ПричинаНеудовлетворения = ЗНАЧЕНИЕ(Справочник.ПричиныНеудовлетворенияПервичногоСпроса.ПустаяСсылка)";
		
		Запрос.УстановитьПараметр("Предмет",Предмет);
		
		Если НЕ Запрос.Выполнить().Пустой() Тогда
			ОбщегоНазначенияКлиентСервер.СообщитьПользователю(
			НСтр("ru='Для выполнения задачи необходимо корректно заполнить результаты удовлетворения первичного спроса.';uk='Для виконання задачі необхідно коректно заповнити результати задоволення первинного попиту.'"));
			Результат = Ложь;
		Иначе
			Результат = Истина;
		КонецЕсли;
	КонецЕсли;
	
	УстановитьПривилегированныйРежим(Ложь);
	
	Если Результат Тогда
		ЗакрытьСделку(Отказ);
	Иначе
		Отказ = Истина;
	КонецЕсли;
	
КонецПроцедуры

Процедура ПервичныйКонтактПриВыполнении(ТочкаМаршрутаБизнесПроцесса, Задача, Отказ)
	
	Если ПолучитьФункциональнуюОпцию("ИспользоватьПочтовыйКлиент") Тогда
		ТекстЗапроса =
		"ВЫБРАТЬ ПЕРВЫЕ 1
		|	Взаимодействия.Ссылка
		|ИЗ
		|	ЖурналДокументов.Взаимодействия КАК Взаимодействия
		|		ВНУТРЕННЕЕ СОЕДИНЕНИЕ РегистрСведений.ПредметыПапкиВзаимодействий КАК ПредметыПапкиВзаимодействий
		|		ПО Взаимодействия.Ссылка = ПредметыПапкиВзаимодействий.Взаимодействие
		|ГДЕ
		|	ТИПЗНАЧЕНИЯ(Взаимодействия.Ссылка) <> ТИП(Документ.ЗапланированноеВзаимодействие)
		|	И (НЕ Взаимодействия.ПометкаУдаления)
		|	И ПредметыПапкиВзаимодействий.Предмет = &ОтборСсылка";
		ТекстСообщения =
		НСтр("ru='Задача не может считаться выполненной, так как нет зарегистрированных взаимодействий.';uk='Задача не може вважатися виконаним, так як немає зареєстрованих взаємодій.'");
		Если НЕ ДокументСоздан(ТекстЗапроса, Предмет, ТекстСообщения) Тогда
			Отказ = Истина;
		КонецЕсли;
	КонецЕсли;
	
КонецПроцедуры

Процедура КвалификацияКлиентаПриВыполнении(ТочкаМаршрутаБизнесПроцесса, Задача, Отказ)
	
	Если ЗначениеЗаполнено(Предмет.СоглашениеСКлиентом) Тогда
		Результат = Истина;
	Иначе
		Результат = Ложь;
		ОбщегоНазначенияКлиентСервер.СообщитьПользователю(
			НСтр("ru='Задача не может считаться выполненной, так как не определено соглашение с клиентом.';uk='Задача не може вважатися виконаним, оскільки не визначено оферту клієнту.'"));
	КонецЕсли;
	
	Отказ = Отказ ИЛИ НЕ Результат;

КонецПроцедуры

Процедура ФормированиеЗаказаПриВыполнении(ТочкаМаршрутаБизнесПроцесса, Задача, Отказ)
	
	Результат = (ПартнерыИКонтрагенты.ПолучитьВсехКонтрагентовПартнера(Предмет.Партнер).Количество() > 0);

	Если Не Результат Тогда
		ОбщегоНазначенияКлиентСервер.СообщитьПользователю(
			НСтр("ru='Задача не может считаться выполненной, так как не определен контрагент партнера.';uk='Задача не може вважатися виконаною, оскільки не визначений контрагент партнера.'"));
	Иначе
		ТекстЗапроса =
			"ВЫБРАТЬ ПЕРВЫЕ 1
			|	ЗаказКлиента.Ссылка
			|ИЗ
			|	Документ.ЗаказКлиента КАК ЗаказКлиента
			|ГДЕ
			|	ЗаказКлиента.Проведен
			|	И ЗаказКлиента.Сделка = &ОтборСсылка";
		ТекстСообщения =
			НСтр("ru='Задача не может считаться выполненной, так как нет заказа клиента.';uk='Задача не може вважатися виконаною, оскільки немає замовлення клієнта.'");
		Результат = ДокументСоздан(ТекстЗапроса, Предмет, ТекстСообщения);
	КонецЕсли;
	
	Отказ = Отказ ИЛИ НЕ Результат;
	
КонецПроцедуры

Процедура ПодтверждениеОбязательствПриВыполнении(ТочкаМаршрутаБизнесПроцесса, Задача, Отказ)
	
	УстановитьПривилегированныйРежим(Истина);
	
	Результат = Истина;
	
	Запрос = Новый Запрос(
		"ВЫБРАТЬ ПЕРВЫЕ 1
		|	ЗаказКлиента.Ссылка
		|ИЗ
		|	Документ.ЗаказКлиента КАК ЗаказКлиента
		|ГДЕ
		|	ЗаказКлиента.Проведен
		|	И ЗаказКлиента.Сделка = &ОтборСсылка
		|	И ЗаказКлиента.ПорядокРасчетов = ЗНАЧЕНИЕ(Перечисление.ПорядокРасчетов.ПоДоговорамКонтрагентов)");
	Запрос.УстановитьПараметр("ОтборСсылка", Предмет);
	РезультатЗапроса = Запрос.Выполнить();
	НетРасчетовПоДоговорам = РезультатЗапроса.Пустой();
	
	Если НетРасчетовПоДоговорам Тогда
		
		Запрос = Новый Запрос(
			"ВЫБРАТЬ
			|	ЕСТЬNULL(РасчетыСКлиентамиОбороты.СуммаПриход, 0) + ЕСТЬNULL(РасчетыСКлиентамиОбороты.СуммаРасход, 0) + ЕСТЬNULL(РасчетыСКлиентамиОбороты.КОтгрузкеПриход, 0) КАК Обязательства
			|ИЗ
			|	РегистрНакопления.РасчетыСКлиентами.Обороты(, , , ОбъектРасчетов.Объект.Сделка = &ОтборСсылка) КАК РасчетыСКлиентамиОбороты");
		Запрос.УстановитьПараметр("ОтборСсылка", Предмет);
		Выборка = Запрос.Выполнить().Выбрать();
		Результат = Выборка.Следующий() И Выборка.Обязательства > 0;
		
	КонецЕсли;

	Если Не Результат Тогда
		ОбщегоНазначенияКлиентСервер.СообщитьПользователю(
			НСтр("ru='Задача не может считаться выполненной, так как нет открытых обязательств по сделке.';uk='Задача не може вважатися виконаною, так як немає відкритих зобов''язань по угоді.'"));
	КонецЕсли;

	Отказ = Отказ ИЛИ НЕ Результат;
	
КонецПроцедуры

Процедура КонтрольВыполненияОбязательствПриВыполнении(ТочкаМаршрутаБизнесПроцесса, Задача, Отказ)
	
	УстановитьПривилегированныйРежим(Истина);
	
	Результат = Истина;
	
	Запрос = Новый Запрос(
		"ВЫБРАТЬ ПЕРВЫЕ 1
		|	ЗаказКлиента.Ссылка
		|ИЗ
		|	Документ.ЗаказКлиента КАК ЗаказКлиента
		|ГДЕ
		|	ЗаказКлиента.Проведен
		|	И ЗаказКлиента.Сделка = &ОтборСсылка
		|	И ЗаказКлиента.ПорядокРасчетов = ЗНАЧЕНИЕ(Перечисление.ПорядокРасчетов.ПоДоговорамКонтрагентов)");
	Запрос.УстановитьПараметр("ОтборСсылка", Предмет);
	РезультатЗапроса = Запрос.Выполнить();
	НетРасчетовПоДоговорам = РезультатЗапроса.Пустой();
	
	Если НетРасчетовПоДоговорам Тогда
		
		// проверить остатки по платежам
		Запрос = Новый Запрос(
			"ВЫБРАТЬ
			|	ЕСТЬNULL(РасчетыСКлиентамиОстатки.СуммаОстаток, 0) КАК СуммаОстаток,
			|	ЕСТЬNULL(РасчетыСКлиентамиОстатки.КОплатеОстаток, 0) КАК КОплатеОстаток
			|ИЗ
			|	РегистрНакопления.РасчетыСКлиентами.Остатки(
			|			,
			|			ОбъектРасчетов.Объект.Сделка = &Сделка) КАК РасчетыСКлиентамиОстатки");
		Запрос.УстановитьПараметр("Сделка", Предмет);
		ПлатежиОстатки = Запрос.Выполнить().Выбрать();
		ПлатежиОстатки.Следующий();
		Результат = ПлатежиОстатки.СуммаОстаток = 0 И ПлатежиОстатки.КОплатеОстаток = 0;

		// проверить остатки по отгрузкам
		Запрос = Новый Запрос(
			"ВЫБРАТЬ
			|	ЕСТЬNULL(ЗаказыКлиентовОстатки.ЗаказаноОстаток, 0) + ЕСТЬNULL(ЗаказыКлиентовОстатки.КОформлениюОстаток, 0) КАК КоличествоОстаток
			|ИЗ
			|	РегистрНакопления.ЗаказыКлиентов.Остатки(, ЗаказКлиента.Сделка = &Сделка) КАК ЗаказыКлиентовОстатки");
		Запрос.УстановитьПараметр("Сделка", Предмет);
		ОтгрузкиОстатки = Запрос.Выполнить().Выбрать();
		ОтгрузкиОстатки.Следующий();
		Результат = Результат И ОтгрузкиОстатки.КоличествоОстаток = 0;
		
	КонецЕсли;

	Если НЕ Результат Тогда
		ОбщегоНазначенияКлиентСервер.СообщитьПользователю(
		НСтр("ru='Задача не может быть выполнена, так как есть не выполненные обязательства по сделке';uk='Задача не може бути виконаною, оскільки є не виконані зобов''язання по угоді'"));
	КонецЕсли;
	
	Отказ = Отказ ИЛИ НЕ Результат;
	
КонецПроцедуры

Процедура СделкаПроигранаПроверкаУсловия(ТочкаМаршрутаБизнесПроцесса, Результат)
	
	Результат = (Предмет.Статус = Перечисления.СтатусыСделок.Проиграна);
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

Процедура ЗаполнитьЗадачуПриСозданииЗадач(ТочкаМаршрутаБизнесПроцесса, ФормируемыеЗадачи)

	СделкиСервер.ЗаполнитьРеквизитыЗадачПроцесса(
		Предмет, БизнесПроцессы.ТиповаяПродажа,
		ТочкаМаршрутаБизнесПроцесса,
		ФормируемыеЗадачи);

КонецПроцедуры

Функция ДокументСоздан(ТекстЗапроса, Отбор, ТекстСообщенияОшибки)

	УстановитьПривилегированныйРежим(Истина);
	
	Запрос = Новый Запрос(ТекстЗапроса);
	Запрос.УстановитьПараметр("ОтборСсылка", Отбор);
	Запрос.УстановитьПараметр("ТекущаяДата",НачалоДня(ТекущаяДатаСеанса()));
	РезультатЗапроса = Запрос.Выполнить();
	Если РезультатЗапроса.Пустой() Тогда
		ОбщегоНазначенияКлиентСервер.СообщитьПользователю(ТекстСообщенияОшибки);
		Возврат Ложь;
	КонецЕсли;

	Возврат Истина;

КонецФункции

Процедура ЗакрытьСделку(Отказ = Ложь)

	Попытка
		ЗаблокироватьДанныеДляРедактирования(Предмет);
	Исключение
		
		ТекстСообщения = НСтр("ru='Не удалось заблокировать %Сделка%.';uk='Не вдалося заблокувати %Сделка%.'");
		ТекстСообщения = СтрЗаменить(ТекстСообщения, "%Сделка%", Предмет);
		ОбщегоНазначенияКлиентСервер.СообщитьПользователю(ТекстСообщения,,,,Отказ);
		
		Возврат;
		
	КонецПопытки;
	
	Попытка
		СделкаОбъект               = Предмет.ПолучитьОбъект();
		СделкаОбъект.Закрыта       = Истина;
		СделкаОбъект.ДатаОкончания = ТекущаяДатаСеанса();
		СделкаОбъект.Записать();
		
		ТекущийЭтап = СделкиСервер.ПолучитьТекущийЭтап(Предмет);
		Если  ТекущийЭтап <> Справочники.СостоянияПроцессов.ПустаяСсылка() Тогда
				СделкиСервер.ЗакрытьСтатистику(Предмет, ТекущийЭтап);
		КонецЕсли;

	Исключение
		Отказ = Истина;
		ОбщегоНазначенияКлиентСервер.СообщитьПользователю(КраткоеПредставлениеОшибки(ИнформацияОбОшибке()));
	КонецПопытки;

КонецПроцедуры

#КонецОбласти

#КонецЕсли
