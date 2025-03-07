#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ОбработчикиСобытий

Процедура ПередЗаписью(Отказ, Замещение)
	
	Если ОбменДанными.Загрузка Или Не ПроведениеДокументов.РассчитыватьИзменения(ДополнительныеСвойства) Тогда
		Возврат;
	КонецЕсли;

	ОбновлениеИнформационнойБазы.ПроверитьОбъектОбработан(ЭтотОбъект);

	СтруктураВременныеТаблицы = ДополнительныеСвойства.ДляПроведения.СтруктураВременныеТаблицы;
	БлокироватьДляИзменения = Истина;

	// Текущее состояние набора помещается во временную таблицу,
	// чтобы при записи получить изменение нового набора относительно текущего.

	Запрос = Новый Запрос;
	Запрос.УстановитьПараметр("Регистратор", Отбор.Регистратор.Значение);
	Запрос.УстановитьПараметр("ЭтоНовый",    ДополнительныеСвойства.ЭтоНовый);
	Запрос.МенеджерВременныхТаблиц = СтруктураВременныеТаблицы.МенеджерВременныхТаблиц;
	Запрос.Текст =
	"ВЫБРАТЬ
	|	Таблица.Организация,
	|	Таблица.ОсновноеСредство,
	|	ВЫБОР
	|		КОГДА Таблица.ВидДвижения = ЗНАЧЕНИЕ(ВидДвиженияНакопления.Приход)
	|			ТОГДА Таблица.СуммаПереоценки
	|		ИНАЧЕ -Таблица.СуммаПереоценки
	|	КОНЕЦ КАК СуммаПереоценкиПередЗаписью
	|ПОМЕСТИТЬ ДвиженияПереоценкаОСБухгалтерскийУчет
	|ИЗ
	|	РегистрНакопления.ПереоценкаОСБухгалтерскийУчет КАК Таблица
	|ГДЕ
	|	Таблица.Регистратор = &Регистратор
	|	И НЕ &ЭтоНовый";
	
	Запрос.Выполнить();
	
КонецПроцедуры

Процедура ПриЗаписи(Отказ, Замещение)
	
	Если ОбменДанными.Загрузка Или Не ПроведениеДокументов.РассчитыватьИзменения(ДополнительныеСвойства) Тогда
		Возврат;
	КонецЕсли;
	
	СтруктураВременныеТаблицы = ДополнительныеСвойства.ДляПроведения.СтруктураВременныеТаблицы;
	// Рассчитывается изменение нового набора относительно текущего с учетом накопленных изменений
	// и помещается во временную таблицу.
	Запрос = Новый Запрос;
	Запрос.УстановитьПараметр("Регистратор", Отбор.Регистратор.Значение);
	Запрос.МенеджерВременныхТаблиц = СтруктураВременныеТаблицы.МенеджерВременныхТаблиц;
	Запрос.Текст =
	"ВЫБРАТЬ
	|	ТаблицаИзменений.Организация,
	|	ТаблицаИзменений.ОсновноеСредство,
	|	СУММА(ТаблицаИзменений.СуммаПереоценкиИзменение) КАК СуммаПереоценкиИзменение
	|ПОМЕСТИТЬ ДвиженияПереоценкаОСБухгалтерскийУчет
	|ИЗ
	|	(ВЫБРАТЬ
	|		Таблица.Организация КАК Организация,
	|		Таблица.ОсновноеСредство КАК ОсновноеСредство,
	|		Таблица.СуммаПереоценки КАК СуммаПереоценкиИзменение
	|	ИЗ
	|		ДвиженияПереоценкаОСБухгалтерскийУчет КАК Таблица
	|	
	|	ОБЪЕДИНИТЬ ВСЕ
	|	
	|	ВЫБРАТЬ
	|		Таблица.Организация,
	|		Таблица.ОсновноеСредство,
	|		ВЫБОР
	|			КОГДА Таблица.ВидДвижения = ЗНАЧЕНИЕ(ВидДвиженияНакопления.Приход)
	|				ТОГДА -Таблица.СуммаПереоценки
	|			ИНАЧЕ Таблица.СуммаПереоценки
	|		КОНЕЦ   КАК  СуммаПереоценкиИзменение
	|	ИЗ
	|		РегистрНакопления.ПереоценкаОСБухгалтерскийУчет КАК Таблица
	|	ГДЕ
	|		Таблица.Регистратор = &Регистратор) КАК ТаблицаИзменений
	|
	|СГРУППИРОВАТЬ ПО
	|	ТаблицаИзменений.Организация,
	|	ТаблицаИзменений.ОсновноеСредство
	|
	|ИМЕЮЩИЕ
	|	СУММА(ТаблицаИзменений.СуммаПереоценкиИзменение) > 0
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|УНИЧТОЖИТЬ ДвиженияПереоценкаОСБухгалтерскийУчет";
	Выборка = Запрос.ВыполнитьПакет()[0].Выбрать();
	Выборка.Следующий();
	
	// Новые изменения были помещены во временную таблицу.
	// Добавляется информация о ее существовании и наличии в ней записей об изменении.
	СтруктураВременныеТаблицы.Вставить("ДвиженияПереоценкаОСБухгалтерскийУчет", Выборка.Количество > 0);
	
КонецПроцедуры

#КонецОбласти

#КонецЕсли