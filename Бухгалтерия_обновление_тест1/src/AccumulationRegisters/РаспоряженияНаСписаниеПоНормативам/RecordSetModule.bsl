#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ОбработчикиСобытий

Процедура ПередЗаписью(Отказ, Замещение)
	
	Если ОбменДанными.Загрузка Тогда
		Возврат;
	КонецЕсли;
	
	ОбновлениеИнформационнойБазы.ПроверитьОбъектОбработан(ЭтотОбъект);
	
	Если Не ПроведениеДокументов.РассчитыватьИзменения(ДополнительныеСвойства) Тогда
		Возврат;
	КонецЕсли;
	
	БлокироватьДляИзменения = Истина;
	
	// Текущее состояние набора помещается во временную таблицу,
	// чтобы при записи получить изменение нового набора относительно текущего.
	
	Запрос = Новый Запрос;
	Запрос.УстановитьПараметр("Регистратор", Отбор.Регистратор.Значение);
	Запрос.УстановитьПараметр("ЭтоНовый",    ДополнительныеСвойства.СвойстваДокумента.ЭтоНовый);
	Запрос.МенеджерВременныхТаблиц = ДополнительныеСвойства.МенеджерВременныхТаблиц;
	Запрос.Текст =
	"ВЫБРАТЬ
	|	НАЧАЛОПЕРИОДА(Таблица.Период, Месяц) КАК Период,
	|	Таблица.Организация         КАК Организация,
	|	Таблица.Подразделение       КАК Подразделение,
	|	Таблица.Номенклатура        КАК Номенклатура,
	|	Таблица.Характеристика      КАК Характеристика,
	|	Таблица.Распоряжение        КАК Распоряжение,
	|	Таблица.КодСтроки           КАК КодСтроки,
	|	Таблица.Назначение          КАК Назначение,
	|	Таблица.ВидДвижения         КАК ВидДвижения,
	|	ВЫБОР КОГДА Таблица.ВидДвижения = ЗНАЧЕНИЕ(ВидДвиженияНакопления.Приход) ТОГДА
	|			Таблица.Количество
	|		ИНАЧЕ
	|			-Таблица.Количество
	|	КОНЕЦ                       КАК КоличествоПередЗаписью
	|ПОМЕСТИТЬ ДвиженияРаспоряженияНаСписаниеПоНормативамПередЗаписью
	|ИЗ
	|	РегистрНакопления.РаспоряженияНаСписаниеПоНормативам КАК Таблица
	|ГДЕ
	|	Таблица.Регистратор = &Регистратор
	|	И НЕ &ЭтоНовый
	|";
	Запрос.Выполнить();
	
КонецПроцедуры

Процедура ПриЗаписи(Отказ, Замещение)
	
	Если ОбменДанными.Загрузка Или Не ПроведениеДокументов.РассчитыватьИзменения(ДополнительныеСвойства) Тогда
		Возврат;
	КонецЕсли;
	
	// Рассчитывается изменение нового набора относительно текущего с учетом накопленных изменений
	// и помещается во временную таблицу.
	Запрос = Новый Запрос;
	Запрос.УстановитьПараметр("Регистратор", Отбор.Регистратор.Значение);
	Запрос.МенеджерВременныхТаблиц = ДополнительныеСвойства.МенеджерВременныхТаблиц;
	Запрос.Текст =
	"ВЫБРАТЬ
	|	МАКСИМУМ(ТаблицаИзменений.ДатаКонтроляПриЗаписи) КАК ДатаКонтроляПриЗаписи,
	|	МАКСИМУМ(ТаблицаИзменений.ДатаКонтроляПередЗаписью) КАК ДатаКонтроляПередЗаписью,
	|	ТаблицаИзменений.Организация         КАК Организация,
	|	ТаблицаИзменений.Подразделение       КАК Подразделение,
	|	ТаблицаИзменений.Номенклатура        КАК Номенклатура,
	|	ТаблицаИзменений.Характеристика      КАК Характеристика,
	|	ТаблицаИзменений.Распоряжение        КАК Распоряжение,
	|	ТаблицаИзменений.КодСтроки           КАК КодСтроки,
	|	ТаблицаИзменений.Назначение          КАК Назначение,
	|	СУММА(ТаблицаИзменений.КоличествоИзменение)    КАК КоличествоИзменение
	|ПОМЕСТИТЬ ДвиженияРаспоряженияНаСписаниеПоНормативамИзменение
	|ИЗ
	|	(ВЫБРАТЬ
	|		ДАТАВРЕМЯ(1,1,1)            КАК ДатаКонтроляПриЗаписи,
	|		НАЧАЛОПЕРИОДА(Таблица.Период, МЕСЯЦ) КАК ДатаКонтроляПередЗаписью,
	|		Таблица.Организация         КАК Организация,
	|		Таблица.Подразделение       КАК Подразделение,
	|		Таблица.Номенклатура        КАК Номенклатура,
	|		Таблица.Характеристика      КАК Характеристика,
	|		Таблица.Распоряжение        КАК Распоряжение,
	|		Таблица.КодСтроки           КАК КодСтроки,
	|		Таблица.Назначение          КАК Назначение,
	|		Таблица.КоличествоПередЗаписью КАК КоличествоИзменение
	|	ИЗ
	|		ДвиженияРаспоряженияНаСписаниеПоНормативамПередЗаписью КАК Таблица
	|	
	|	ОБЪЕДИНИТЬ ВСЕ
	|	
	|	ВЫБРАТЬ
	|		НАЧАЛОПЕРИОДА(Таблица.Период, МЕСЯЦ) КАК ДатаКонтроляПриЗаписи,
	|		ДАТАВРЕМЯ(1,1,1)            КАК ДатаКонтроляПередЗаписью,
	|		Таблица.Организация         КАК Организация,
	|		Таблица.Подразделение       КАК Подразделение,
	|		Таблица.Номенклатура        КАК Номенклатура,
	|		Таблица.Характеристика      КАК Характеристика,
	|		Таблица.Распоряжение        КАК Распоряжение,
	|		Таблица.КодСтроки           КАК КодСтроки,
	|		Таблица.Назначение          КАК Назначение,
	|		ВЫБОР КОГДА Таблица.ВидДвижения = ЗНАЧЕНИЕ(ВидДвиженияНакопления.Приход) ТОГДА
	|				-Таблица.Количество
	|			ИНАЧЕ
	|				Таблица.Количество
	|		КОНЕЦ                           КАК КоличествоИзменение
	|	ИЗ
	|		РегистрНакопления.РаспоряженияНаСписаниеПоНормативам КАК Таблица
	|	ГДЕ
	|		Таблица.Регистратор = &Регистратор) КАК ТаблицаИзменений
	|
	|СГРУППИРОВАТЬ ПО
	|	ТаблицаИзменений.Организация,
	|	ТаблицаИзменений.Подразделение,
	|	ТаблицаИзменений.Номенклатура,
	|	ТаблицаИзменений.Характеристика,
	|	ТаблицаИзменений.Распоряжение,
	|	ТаблицаИзменений.КодСтроки,
	|	ТаблицаИзменений.Назначение
	|
	|ИМЕЮЩИЕ
	|	СУММА(ТаблицаИзменений.КоличествоИзменение) > 0 
	|		ИЛИ МАКСИМУМ(ТаблицаИзменений.ДатаКонтроляПриЗаписи) <> МАКСИМУМ(ТаблицаИзменений.ДатаКонтроляПередЗаписью)
	|;
	|УНИЧТОЖИТЬ ДвиженияРаспоряженияНаСписаниеПоНормативамПередЗаписью
	|";
	
	Результат = Запрос.ВыполнитьПакет();
	
	Выборка = Результат[0].Выбрать();
	ПроведениеДокументов.ЗарегистрироватьТаблицуКонтроля(ДополнительныеСвойства,
		"ДвиженияРаспоряженияНаСписаниеПоНормативамИзменение", Выборка.Следующий() И Выборка.Количество > 0);
	
КонецПроцедуры

#КонецОбласти

#КонецЕсли
