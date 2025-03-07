#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ОбработчикиСобытий

Процедура ПередЗаписью(Отказ, Замещение)
	
	Если ОбменДанными.Загрузка Тогда
		Возврат;
	КонецЕсли;
	
	ОбновлениеИнформационнойБазы.ПроверитьОбъектОбработан(ЭтотОбъект);
	
	Если Не ПроведениеДокументов.КонтролироватьИзменения(ДополнительныеСвойства) Тогда
		Возврат;
	КонецЕсли;
	
	ДополнительныеСвойства.Вставить("ВалютаУпр", Константы.ВалютаУправленческогоУчета.Получить());
	ДополнительныеСвойства.Вставить("ВалютаРегл", Константы.ВалютаРегламентированногоУчета.Получить());
	
	// Текущее состояние набора помещается во временную таблицу,
	// чтобы при записи получить изменение нового набора относительно текущего.
	Запрос = Новый Запрос("
	|ВЫБРАТЬ
	|	Таблица.Период				КАК Период,
	|	Таблица.Организация			КАК Организация,
	|	Таблица.Подразделение		КАК Подразделение,
	|	Таблица.МОЛ					КАК МОЛ,
	|	Таблица.ДенежныйДокумент	КАК ДенежныйДокумент,
	|	(ВЫБОР Таблица.ВидДвижения КОГДА ЗНАЧЕНИЕ(ВидДвиженияНакопления.Расход) ТОГДА -Таблица.Количество
	|		ИНАЧЕ Таблица.Количество КОНЕЦ) КАК КоличествоПередЗаписью,
	|	(ВЫБОР Таблица.ВидДвижения КОГДА ЗНАЧЕНИЕ(ВидДвиженияНакопления.Расход) ТОГДА -Таблица.Сумма
	|		ИНАЧЕ Таблица.Сумма КОНЕЦ) КАК СуммаПередЗаписью
	|ПОМЕСТИТЬ
	|	ДвиженияДенежныеДокументыПередЗаписью
	|ИЗ
	|	РегистрНакопления.ДенежныеДокументы КАК Таблица
	|ГДЕ
	|	Таблица.Регистратор = &Регистратор
	|	И НЕ &ЭтоНовый
	|	И НЕ &ЭтоОбменДанными
	|	И &РассчитыватьИзменения
	|;
	|///////////////////////////////////////////
	|ВЫБРАТЬ
	|	Записи.Период                     КАК Период,
	|	Записи.Регистратор                КАК Регистратор,
	|	Записи.Организация                КАК Организация,
	|	Записи.Подразделение              КАК Подразделение,
	|	Записи.МОЛ                        КАК МОЛ,
	|	Записи.ДенежныйДокумент           КАК ДенежныйДокумент,
	|
	|	Записи.Количество   КАК Количество,
	|	Записи.Сумма        КАК Сумма,
	|	Записи.СуммаУпр     КАК СуммаУпр,
	|	Записи.СуммаРегл    КАК СуммаРегл,
	|
	|	Записи.ХозяйственнаяОперация КАК ХозяйственнаяОперация
	|ПОМЕСТИТЬ ПереоценкаДенежныеДокументыПередЗаписью
	|ИЗ
	|	РегистрНакопления.ДенежныеДокументы КАК Записи
	|ГДЕ
	|	Записи.Регистратор = &Регистратор
	|	И (ТипЗначения(Записи.Регистратор) = ТИП(Документ.РасчетКурсовыхРазниц)
	|		ИЛИ Записи.ДенежныйДокумент.Валюта <> &ВалютаУпр
	|		ИЛИ Записи.ДенежныйДокумент.Валюта <> &ВалютаРегл
	|	)
	|");
	Запрос.УстановитьПараметр("Регистратор",	 Отбор.Регистратор.Значение);
	Запрос.УстановитьПараметр("ЭтоНовый",		 ДополнительныеСвойства.СвойстваДокумента.ЭтоНовый);
	Запрос.УстановитьПараметр("ЭтоОбменДанными", ОбменДанными.Загрузка);
	Запрос.УстановитьПараметр("РассчитыватьИзменения", ПроведениеДокументов.РассчитыватьИзменения(ДополнительныеСвойства));
	Запрос.УстановитьПараметр("ВалютаУпр",  ДополнительныеСвойства.ВалютаУпр);
	Запрос.УстановитьПараметр("ВалютаРегл", ДополнительныеСвойства.ВалютаРегл);
	
	Запрос.МенеджерВременныхТаблиц = ДополнительныеСвойства.МенеджерВременныхТаблиц;
	
	Запрос.Выполнить();
	
КонецПроцедуры

Процедура ПриЗаписи(Отказ, Замещение)
	
	Если ОбменДанными.Загрузка Или Не ПроведениеДокументов.КонтролироватьИзменения(ДополнительныеСвойства) Тогда
		Возврат;
	КонецЕсли;
	
	// Рассчитывается изменение нового набора относительно текущего с учетом накопленных изменений
	// и помещается во временную таблицу.
	Запрос = Новый Запрос("
	|ВЫБРАТЬ
	|	МИНИМУМ(ТаблицаИзменений.ПериодПередЗаписью) КАК ПериодПередЗаписью,
	|	ТаблицаИзменений.Организация,
	|	ТаблицаИзменений.Подразделение,
	|	ТаблицаИзменений.МОЛ,
	|	ТаблицаИзменений.ДенежныйДокумент,
	|	СУММА(ТаблицаИзменений.КоличествоИзменение) КАК КоличествоИзменение,
	|	СУММА(ТаблицаИзменений.СуммаИзменение) КАК СуммаИзменение
	|ПОМЕСТИТЬ
	|	ДвиженияДенежныеДокументыИзменение
	|ИЗ (
	|	ВЫБРАТЬ
	|		Таблица.Период КАК ПериодПередЗаписью,
	|		NULL КАК ПериодПриЗаписи,
	|		Таблица.Организация,
	|		Таблица.Подразделение,
	|		Таблица.МОЛ,
	|		Таблица.ДенежныйДокумент,
	|		Таблица.КоличествоПередЗаписью КАК КоличествоИзменение,
	|		Таблица.СуммаПередЗаписью КАК СуммаИзменение
	|	ИЗ
	|		ДвиженияДенежныеДокументыПередЗаписью КАК Таблица
	|	
	|	ОБЪЕДИНИТЬ ВСЕ
	|	ВЫБРАТЬ
	|		NULL КАК ПериодПередЗаписью,
	|		Таблица.Период КАК ПериодПриЗаписи,
	|		Таблица.Организация,
	|		Таблица.Подразделение,
	|		Таблица.МОЛ,
	|		Таблица.ДенежныйДокумент,
	|		(ВЫБОР Таблица.ВидДвижения КОГДА ЗНАЧЕНИЕ(ВидДвиженияНакопления.Расход) ТОГДА Таблица.Количество
	|			ИНАЧЕ -Таблица.Количество КОНЕЦ) КАК КоличествоИзменение,
	|		(ВЫБОР Таблица.ВидДвижения КОГДА ЗНАЧЕНИЕ(ВидДвиженияНакопления.Расход) ТОГДА Таблица.Сумма
	|			ИНАЧЕ -Таблица.Сумма КОНЕЦ) КАК СуммаИзменение
	|	ИЗ
	|		РегистрНакопления.ДенежныеДокументы КАК Таблица
	|	ГДЕ
	|		Таблица.Регистратор = &Регистратор
	|		И НЕ &ЭтоОбменДанными
	|		И &РассчитыватьИзменения
	|) КАК ТаблицаИзменений
	|
	|СГРУППИРОВАТЬ ПО
	|	ТаблицаИзменений.Организация,
	|	ТаблицаИзменений.Подразделение,
	|	ТаблицаИзменений.МОЛ,
	|	ТаблицаИзменений.ДенежныйДокумент
	|
	|ИМЕЮЩИЕ
	|	СУММА(ТаблицаИзменений.КоличествоИзменение) <> 0
	|	ИЛИ СУММА(ТаблицаИзменений.СуммаИзменение) <> 0
	|	ИЛИ МИНИМУМ(ТаблицаИзменений.ПериодПередЗаписью) < МАКСИМУМ(ТаблицаИзменений.ПериодПриЗаписи)
	|;
	|//////////////////////////////////////////////////
	|УНИЧТОЖИТЬ ДвиженияДенежныеДокументыПередЗаписью
	|;
	|//////////////////////////////////////////////////
	|ВЫБРАТЬ
	|	Таблица.Период                       КАК Период,
	|	Таблица.Регистратор                  КАК Регистратор,
	|	Таблица.Организация                  КАК Организация,
	|	Таблица.Подразделение                КАК Подразделение,
	|	Таблица.МОЛ                          КАК МОЛ,
	|	Таблица.ДенежныйДокумент             КАК ДенежныйДокумент,
	|	Таблица.ХозяйственнаяОперация        КАК ХозяйственнаяОперация,
	|	СУММА(Таблица.Количество)            КАК КоличествоИзменение,
	|	СУММА(Таблица.Сумма)                 КАК СуммаИзменение,
	|	СУММА(Таблица.СуммаУпр)              КАК СуммаУпрИзменение,
	|	СУММА(Таблица.СуммаРегл)             КАК СуммаРеглИзменение
	|ПОМЕСТИТЬ ТаблицаИзмененийДенежныеДокументыПереоценка
	|ИЗ
	|	(ВЫБРАТЬ
	|		Записи.Период                     КАК Период,
	|		Записи.Регистратор                КАК Регистратор,
	|		Записи.Организация                КАК Организация,
	|		Записи.Подразделение              КАК Подразделение,
	|		Записи.МОЛ                        КАК МОЛ,
	|		Записи.ДенежныйДокумент           КАК ДенежныйДокумент,
	|
	|		Записи.Количество   КАК Количество,
	|		Записи.Сумма        КАК Сумма,
	|		Записи.СуммаУпр     КАК СуммаУпр,
	|		Записи.СуммаРегл    КАК СуммаРегл,
	|
	|		Записи.ХозяйственнаяОперация      КАК ХозяйственнаяОперация
	|	ИЗ
	|		ПереоценкаДенежныеДокументыПередЗаписью КАК Записи
	|	
	|	ОБЪЕДИНИТЬ ВСЕ
	|
	|	ВЫБРАТЬ
	|		Записи.Период                     КАК Период,
	|		Записи.Регистратор                КАК Регистратор,
	|		Записи.Организация                КАК Организация,
	|		Записи.Подразделение              КАК Подразделение,
	|		Записи.МОЛ                        КАК МОЛ,
	|		Записи.ДенежныйДокумент           КАК ДенежныйДокумент,
	|
	|		-Записи.Количество   КАК Количество,
	|		-Записи.Сумма        КАК Сумма,
	|		-Записи.СуммаУпр     КАК СуммаУпр,
	|		-Записи.СуммаРегл    КАК СуммаРегл,
	|
	|		Записи.ХозяйственнаяОперация      КАК ХозяйственнаяОперация
	|	ИЗ
	|		РегистрНакопления.ДенежныеДокументы КАК Записи
	|	ГДЕ
	|		Записи.Регистратор = &Регистратор
	|	И (ТипЗначения(Записи.Регистратор) = ТИП(Документ.РасчетКурсовыхРазниц)
	|		ИЛИ Записи.ДенежныйДокумент.Валюта <> &ВалютаУпр
	|		ИЛИ Записи.ДенежныйДокумент.Валюта <> &ВалютаРегл)
	|	) КАК Таблица
	|
	|СГРУППИРОВАТЬ ПО
	|	Таблица.Период,
	|	Таблица.Регистратор,
	|	Таблица.Организация,
	|	Таблица.Подразделение,
	|	Таблица.МОЛ,
	|	Таблица.ДенежныйДокумент,
	|	Таблица.ХозяйственнаяОперация
	|ИМЕЮЩИЕ
	|	СУММА(Таблица.Количество) <> 0
	|	ИЛИ СУММА(Таблица.Сумма) <> 0
	|	ИЛИ СУММА(Таблица.СуммаУпр) <> 0
	|	ИЛИ СУММА(Таблица.СуммаРегл) <> 0
	|");
	
	Запрос.УстановитьПараметр("Регистратор",     Отбор.Регистратор.Значение);
	Запрос.УстановитьПараметр("ЭтоОбменДанными", ОбменДанными.Загрузка);
	Запрос.УстановитьПараметр("РассчитыватьИзменения", ПроведениеДокументов.РассчитыватьИзменения(ДополнительныеСвойства));
	Запрос.УстановитьПараметр("ВалютаУпр",  ДополнительныеСвойства.ВалютаУпр);
	Запрос.УстановитьПараметр("ВалютаРегл", ДополнительныеСвойства.ВалютаРегл);
	
	Запрос.МенеджерВременныхТаблиц = ДополнительныеСвойства.МенеджерВременныхТаблиц;
	
	Результат = Запрос.ВыполнитьПакет();
	
	Выборка = Результат[0].Выбрать();
	ПроведениеДокументов.ЗарегистрироватьТаблицуКонтроля(ДополнительныеСвойства,
		"ДвиженияДенежныеДокументыИзменение", Выборка.Следующий() И Выборка.Количество > 0);
	
КонецПроцедуры

#КонецОбласти

#КонецЕсли