#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ОбработчикиСобытий

Процедура ПередЗаписью(Отказ, Замещение)
	
	Если Не ОбменДанными.Загрузка Тогда
		СФормироватьТаблицуОбъектовОплаты();
		РегистрыСведений.ГрафикПлатежей.УстановитьБлокировкиДанныхДляРасчетаГрафика(
			ДополнительныеСвойства.ТаблицаОбъектовОплаты, "РегистрНакопления.РасчетыСКлиентами", "ОбъектРасчетов", "ОбъектРасчетов");
	КонецЕсли;
	
	// Проверка ОбменДанными.Загрузка не требуется, т.к. данный объект в РИБ при записи должен создавать задания.
	
	Если Не ПроведениеДокументов.КонтролироватьИзменения(ДополнительныеСвойства) Тогда
		Возврат;
	КонецЕсли;
	
	БлокироватьДляИзменения = Истина;
	
	// Текущее состояние набора помещается во временную таблицу,
	// чтобы при записи получить изменение нового набора относительно текущего.
	Запрос = Новый Запрос("
	|ВЫБРАТЬ
	|	Таблица.Регистратор  КАК Регистратор,
	|	Таблица.ОбъектРасчетов КАК ОбъектРасчетов,
	|	Таблица.Валюта       КАК Валюта,
	|	ВЫБОР КОГДА НЕ Таблица.ИсключатьПриКонтроле ТОГДА
	|			ВЫБОР КОГДА Таблица.ВидДвижения = ЗНАЧЕНИЕ(ВидДвиженияНакопления.Расход) ТОГДА
	|					-Таблица.КОплате
	|				ИНАЧЕ Таблица.КОплате
	|			КОНЕЦ
	|		ИНАЧЕ 0
	|	КОНЕЦ                КАК КОплатеПередЗаписью,
	|	ВЫБОР КОГДА НЕ Таблица.ИсключатьПриКонтроле ТОГДА
	|			ВЫБОР КОГДА Таблица.ВидДвижения = ЗНАЧЕНИЕ(ВидДвиженияНакопления.Расход) ТОГДА
	|					Таблица.Оплачивается
	|				ИНАЧЕ - Таблица.Оплачивается
	|			КОНЕЦ
	|	КОНЕЦ                КАК ОплачиваетсяПередЗаписью,
	|	0                    КАК КОплатеПередЗаписьюКонтрольСрока,
	|	0                    КАК ОплачиваетсяПередЗаписьюКонтрольСрока,
	|	0                    КАК СуммаПередЗаписью,
	|	0                    КАК ОтгружаетсяПередЗаписью,
	|	0                    КАК ДопустимаяСуммаЗадолженностиПередЗаписью,
	|	Таблица.АналитикаУчетаПоПартнерам КАК АналитикаУчетаПоПартнерам
	|
	|ПОМЕСТИТЬ РасчетыСКлиентамиПередЗаписью
	|ИЗ
	|	РегистрНакопления.РасчетыСКлиентами КАК Таблица
	|		ВНУТРЕННЕЕ СОЕДИНЕНИЕ Справочник.ОбъектыРасчетов КАК ОбъектыРасчетов
	|			ПО ОбъектыРасчетов.Ссылка = Таблица.ОбъектРасчетов
	|ГДЕ
	|	Таблица.Регистратор = &Регистратор
	|	И (ОбъектыРасчетов.Объект ССЫЛКА Документ.ЗаказКлиента
	|		ИЛИ ОбъектыРасчетов.Объект ССЫЛКА Документ.ЗаявкаНаВозвратТоваровОтКлиента
	|		ИЛИ ОбъектыРасчетов.Объект ССЫЛКА Документ.РеализацияТоваровУслуг)
	|	И НЕ &ЭтоНовый
	|	И НЕ &ОбменДанными
	|	И &РассчитыватьИзменения
	|
	|ОБЪЕДИНИТЬ ВСЕ
	|
	|ВЫБРАТЬ
	|	Таблица.Регистратор                  КАК Регистратор,
	|	Таблица.ОбъектРасчетов               КАК ОбъектРасчетов,
	|	Таблица.Валюта                       КАК Валюта,
	|	0                                    КАК КОплатеПередЗаписью,
	|	0                                    КАК ОплачиваетсяПередЗаписью,
	|	ВЫБОР КОГДА Таблица.Период <= &ПериодКонтроляСрокаДолга ТОГДА
	|		ВЫБОР КОГДА Таблица.ВидДвижения = ЗНАЧЕНИЕ(ВидДвиженияНакопления.Расход) ТОГДА
	|				-Таблица.КОплате
	|			ИНАЧЕ Таблица.КОплате
	|		КОНЕЦ
	|	ИНАЧЕ
	|		0
	|	КОНЕЦ                                КАК КОплатеПередЗаписьюКонтрольСрока,
	|	ВЫБОР КОГДА Таблица.Период <= &ПериодКонтроляСрокаДолга ТОГДА
	|		ВЫБОР КОГДА Таблица.ВидДвижения = ЗНАЧЕНИЕ(ВидДвиженияНакопления.Расход) ТОГДА
	|				Таблица.Оплачивается
	|			ИНАЧЕ -Таблица.Оплачивается
	|		КОНЕЦ
	|	ИНАЧЕ
	|		0
	|	КОНЕЦ                                КАК ОплачиваетсяПередЗаписьюКонтрольСрока,
	|	ВЫБОР КОГДА Таблица.ВидДвижения = ЗНАЧЕНИЕ(ВидДвиженияНакопления.Расход) ТОГДА
	|			ВЫБОР КОГДА Таблица.Сумма < 0 ТОГДА
	|					0
	|				ИНАЧЕ -Таблица.Сумма
	|			КОНЕЦ
	|		ИНАЧЕ Таблица.Сумма
	|	КОНЕЦ                                КАК СуммаПередЗаписью,
	|	ВЫБОР КОГДА Таблица.ВидДвижения = ЗНАЧЕНИЕ(ВидДвиженияНакопления.Расход) ТОГДА
	|			0
	|		ИНАЧЕ Таблица.Отгружается
	|	КОНЕЦ                                КАК ОтгружаетсяПередЗаписью,
	|	Таблица.ДопустимаяСуммаЗадолженности КАК ДопустимаяСуммаЗадолженностиПередЗаписью,
	|	Таблица.АналитикаУчетаПоПартнерам    КАК АналитикаУчетаПоПартнерам
	|
	|ИЗ
	|	РегистрНакопления.РасчетыСКлиентами КАК Таблица
	|ГДЕ
	|	Таблица.Регистратор = &Регистратор
	|	И НЕ &ЭтоНовый
	|	И Таблица.ОбъектРасчетов.Объект <> НЕОПРЕДЕЛЕНО
	|	И НЕ &ОбменДанными
	|	И &РассчитыватьИзменения
	|;
	|/////////////////////////////////////////////////
	|ВЫБРАТЬ
	|	Расчеты.ВидДвижения               КАК ВидДвижения,
	|	Расчеты.Регистратор               КАК Регистратор,
	|	Расчеты.Период                    КАК Период,
	|	Расчеты.АналитикаУчетаПоПартнерам КАК АналитикаУчетаПоПартнерам,
	|	Расчеты.ОбъектРасчетов            КАК ОбъектРасчетов,
	|	Расчеты.Валюта                    КАК Валюта,
	|
	|	Расчеты.Сумма        КАК Сумма,
	|	Расчеты.Оплачивается КАК Оплачивается,
	|	Расчеты.Отгружается  КАК Отгружается,
	|	Расчеты.КОплате      КАК КОплате,
	|	Расчеты.КОтгрузке    КАК КОтгрузке,
	|
	|	Расчеты.ХозяйственнаяОперация         КАК ХозяйственнаяОперация,
	|	Расчеты.СуммаРегл                     КАК СуммаРегл,
	|	Расчеты.СуммаУпр                      КАК СуммаУпр,
	|	Расчеты.СтатьяДвиженияДенежныхСредств КАК СтатьяДвиженияДенежныхСредств,
	|	Расчеты.ПорядокОперации               КАК ПорядокОперации,
	|	Расчеты.ПорядокЗачетаПоДатеПлатежа    КАК ПорядокЗачетаПоДатеПлатежа,
	|	Расчеты.РасчетныйДокумент             КАК РасчетныйДокумент,
	|	Расчеты.КорОбъектРасчетов             КАК КорОбъектРасчетов,
	|	Расчеты.ВалютаДокумента               КАК ВалютаДокумента,
	|	Расчеты.ВариантОплаты                 КАК ВариантОплаты,
	|	Расчеты.ДатаПлатежа                   КАК ДатаПлатежа,
	|	Расчеты.ПродажаПоЗаказу               КАК ПродажаПоЗаказу
	|ПОМЕСТИТЬ РасчетыСКлиентамиИсходныеДвижения
	|ИЗ
	|	РегистрНакопления.РасчетыСКлиентами КАК Расчеты
	|ГДЕ
	|	Расчеты.Регистратор = &Регистратор
	|");
	
	Запрос.УстановитьПараметр("Регистратор",              Отбор.Регистратор.Значение);
	Запрос.УстановитьПараметр("ПериодКонтроляСрокаДолга", Макс(КонецДня(ТекущаяДатаСеанса()), КонецДня(ДополнительныеСвойства.ДатаРегистратора)));
	Запрос.УстановитьПараметр("ЭтоНовый",                 ДополнительныеСвойства.СвойстваДокумента.ЭтоНовый);
	Запрос.УстановитьПараметр("ОбменДанными",             ОбменДанными.Загрузка);
	Запрос.УстановитьПараметр("РассчитыватьИзменения",    ПроведениеДокументов.РассчитыватьИзменения(ДополнительныеСвойства));
	Запрос.МенеджерВременныхТаблиц = ДополнительныеСвойства.МенеджерВременныхТаблиц;
	
	Запрос.Выполнить();
	
	Если ОбменДанными.Загрузка Тогда
		Возврат;
	КонецЕсли;
	
	ОбновлениеИнформационнойБазы.ПроверитьОбъектОбработан(ЭтотОбъект);
	
КонецПроцедуры

Процедура ПриЗаписи(Отказ, Замещение)
	
	Если Не ОбменДанными.Загрузка Тогда
		РегистрыСведений.ГрафикПлатежей.РассчитатьГрафикПлатежейПоРасчетамСКлиентами(
			ДополнительныеСвойства.ТаблицаОбъектовОплаты);
	КонецЕсли;
	
	// Проверка ОбменДанными.Загрузка не требуется, т.к. данный объект в РИБ при записи должен создавать задания.
	
	Если Не ПроведениеДокументов.КонтролироватьИзменения(ДополнительныеСвойства) Тогда
		Возврат;
	КонецЕсли;
	
	// Рассчитывается изменение нового набора относительно текущего с учетом накопленных изменений
	// и помещается во временную таблицу.
	Запрос = Новый Запрос("
	|ВЫБРАТЬ
	|	ТаблицаИзменений.ОбъектРасчетов          КАК ОбъектРасчетов,
	|	ТаблицаИзменений.Валюта                  КАК Валюта,
	|	СУММА(ТаблицаИзменений.КОплатеИзменение) КАК КОплатеИзменение
	|	
	|ПОМЕСТИТЬ ДвиженияРасчетыСКлиентамиИзменение
	|ИЗ
	|	(ВЫБРАТЬ
	|		Таблица.ОбъектРасчетов             КАК ОбъектРасчетов,
	|		Таблица.Валюта                     КАК Валюта,
	|		Таблица.КОплатеПередЗаписью        КАК КОплатеИзменение,
	|		Таблица.ОплачиваетсяПередЗаписью   КАК ОплачиваетсяИзменение
	|	ИЗ
	|		РасчетыСКлиентамиПередЗаписью КАК Таблица
	|	
	|	ОБЪЕДИНИТЬ ВСЕ
	|	
	|	ВЫБРАТЬ
	|		Таблица.ОбъектРасчетов КАК ОбъектРасчетов,
	|		Таблица.Валюта         КАК Валюта,
	|		ВЫБОР КОГДА НЕ Таблица.ИсключатьПриКонтроле ТОГДА
	|				ВЫБОР КОГДА Таблица.ВидДвижения = ЗНАЧЕНИЕ(ВидДвиженияНакопления.Расход) ТОГДА
	|						Таблица.КОплате
	|					ИНАЧЕ -Таблица.КОплате
	|				КОНЕЦ
	|			ИНАЧЕ 0
	|		КОНЕЦ,
	|		ВЫБОР КОГДА НЕ Таблица.ИсключатьПриКонтроле ТОГДА
	|				ВЫБОР КОГДА Таблица.ВидДвижения = ЗНАЧЕНИЕ(ВидДвиженияНакопления.Расход) ТОГДА
	|						-Таблица.Оплачивается
	|					ИНАЧЕ Таблица.Оплачивается
	|				КОНЕЦ
	|			ИНАЧЕ 0
	|		КОНЕЦ
	|	ИЗ
	|		РегистрНакопления.РасчетыСКлиентами КАК Таблица
	|			ВНУТРЕННЕЕ СОЕДИНЕНИЕ Справочник.ОбъектыРасчетов КАК ОбъектыРасчетов
	|				ПО ОбъектыРасчетов.Ссылка = Таблица.ОбъектРасчетов
	|	ГДЕ
	|		Таблица.Регистратор = &Регистратор

	|		И (ОбъектыРасчетов.Объект ССЫЛКА Документ.ЗаказКлиента
	|			ИЛИ ОбъектыРасчетов.Объект ССЫЛКА Документ.ЗаявкаНаВозвратТоваровОтКлиента
	|			ИЛИ ОбъектыРасчетов.Объект ССЫЛКА Документ.РеализацияТоваровУслуг
	|			)
	|
	|) КАК ТаблицаИзменений
	|ГДЕ
	|	НЕ &ОбменДанными
	|	И &РассчитыватьИзменения
	|
	|СГРУППИРОВАТЬ ПО
	|	ТаблицаИзменений.ОбъектРасчетов,
	|	ТаблицаИзменений.Валюта
	|
	|ИМЕЮЩИЕ
	|	СУММА(ТаблицаИзменений.КОплатеИзменение) + СУММА(ТаблицаИзменений.ОплачиваетсяИзменение) < 0
	|;
	|////////////////////////////////////////////////
	|ВЫБРАТЬ
	|	ТаблицаИзменений.Регистратор                                  КАК Регистратор,
	|	ТаблицаИзменений.ОбъектРасчетов                               КАК ОбъектРасчетов,
	|	ТаблицаИзменений.Валюта                                       КАК Валюта,
	|	СУММА(ТаблицаИзменений.СуммаИзменение)                        КАК СуммаИзменение,
	|	СУММА(ТаблицаИзменений.ОтгружаетсяИзменение)                  КАК ОтгружаетсяИзменение,
	|	СУММА(ТаблицаИзменений.ДопустимаяСуммаЗадолженностиИзменение) КАК ДопустимаяСуммаЗадолженностиИзменение,
	|	ТаблицаИзменений.АналитикаУчетаПоПартнерам                    КАК АналитикаУчетаПоПартнерам
	|ПОМЕСТИТЬ ДвиженияРасчетыСКлиентамиИзменениеСуммыДолга
	|ИЗ
	|	(ВЫБРАТЬ
	|		Таблица.Регистратор                              КАК Регистратор,
	|		Таблица.ОбъектРасчетов                           КАК ОбъектРасчетов,
	|		Таблица.Валюта                                   КАК Валюта,
	|		Таблица.СуммаПередЗаписью                        КАК СуммаИзменение,
	|		Таблица.ОтгружаетсяПередЗаписью                  КАК ОтгружаетсяИзменение,
	|		Таблица.ДопустимаяСуммаЗадолженностиПередЗаписью КАК ДопустимаяСуммаЗадолженностиИзменение,
	|		Таблица.АналитикаУчетаПоПартнерам                КАК АналитикаУчетаПоПартнерам
	|	ИЗ
	|		РасчетыСКлиентамиПередЗаписью КАК Таблица
	|	
	|	ОБЪЕДИНИТЬ ВСЕ
	|	
	|	ВЫБРАТЬ
	|		Таблица.Регистратор                   КАК Регистратор,
	|		Таблица.ОбъектРасчетов                КАК ОбъектРасчетов,
	|		Таблица.Валюта                        КАК Валюта,
	|		ВЫБОР КОГДА Таблица.ВидДвижения = ЗНАЧЕНИЕ(ВидДвиженияНакопления.Расход) ТОГДА
	|				ВЫБОР КОГДА Таблица.Сумма < 0 ТОГДА
	|						0
	|					ИНАЧЕ Таблица.Сумма
	|				КОНЕЦ
	|			ИНАЧЕ -Таблица.Сумма
	|		КОНЕЦ                                 КАК СуммаИзменение,
	|		ВЫБОР КОГДА Таблица.ВидДвижения = ЗНАЧЕНИЕ(ВидДвиженияНакопления.Расход) ТОГДА
	|				0
	|			ИНАЧЕ -Таблица.Отгружается
	|		КОНЕЦ                                 КАК ОтгружаетсяИзменение,
	|		-Таблица.ДопустимаяСуммаЗадолженности КАК ДопустимаяСуммаЗадолженностиИзменение,
	|		Таблица.АналитикаУчетаПоПартнерам     КАК АналитикаУчетаПоПартнерам
	|	ИЗ
	|		РегистрНакопления.РасчетыСКлиентами КАК Таблица
	|	ГДЕ
	|		Таблица.Регистратор = &Регистратор
	|		И Таблица.ОбъектРасчетов.Объект <> НЕОПРЕДЕЛЕНО
	|
	|) КАК ТаблицаИзменений
	|
	|ГДЕ
	|	&ПроведениеДокумента
	|	И НЕ &ОбменДанными
	|	И &РассчитыватьИзменения
	|	И НЕ ТИПЗНАЧЕНИЯ(ТаблицаИзменений.Регистратор) В (
	|		ТИП(Документ.ПоступлениеБезналичныхДенежныхСредств),
	|		ТИП(Документ.ПриходныйКассовыйОрдер),
	|		ТИП(Документ.ОперацияПоПлатежнойКарте),
	|		ТИП(Документ.ВзаимозачетЗадолженности),
	|		ТИП(Документ.СписаниеЗадолженности)
	|		)
	|
	|СГРУППИРОВАТЬ ПО
	|	ТаблицаИзменений.Регистратор,
	|	ТаблицаИзменений.ОбъектРасчетов,
	|	ТаблицаИзменений.Валюта,
	|	ТаблицаИзменений.АналитикаУчетаПоПартнерам
	|
	|ИМЕЮЩИЕ
	|	СУММА(ТаблицаИзменений.СуммаИзменение) + СУММА(ТаблицаИзменений.ОтгружаетсяИзменение) < 0
	|	ИЛИ СУММА(ТаблицаИзменений.ДопустимаяСуммаЗадолженностиИзменение) > 0
	|;
	|ВЫБРАТЬ
	|	ТаблицаИзменений.Регистратор                                  КАК Регистратор,
	|	ТаблицаИзменений.ОбъектРасчетов                               КАК ОбъектРасчетов,
	|	ТаблицаИзменений.Валюта                                       КАК Валюта,
	|	СУММА(ТаблицаИзменений.СуммаИзменение)                        КАК СуммаИзменение,
	|	СУММА(ТаблицаИзменений.КОплатеИзменениеКонтрольСрока)         КАК КОплатеИзменениеКонтрольСрока,
	|	СУММА(ТаблицаИзменений.ОплачиваетсяИзменениеКонтрольСрока)    КАК ОплачиваетсяИзменениеКонтрольСрока,
	|	ТаблицаИзменений.АналитикаУчетаПоПартнерам                    КАК АналитикаУчетаПоПартнерам
	|ПОМЕСТИТЬ ДвиженияРасчетыСКлиентамиИзменениеКонтрольСрока
	|ИЗ
	|	(ВЫБРАТЬ
	|		Таблица.Регистратор                              КАК Регистратор,
	|		Таблица.ОбъектРасчетов                           КАК ОбъектРасчетов,
	|		Таблица.Валюта                                   КАК Валюта,
	|		Таблица.СуммаПередЗаписью                        КАК СуммаИзменение,
	|		Таблица.КОплатеПередЗаписьюКонтрольСрока         КАК КОплатеИзменениеКонтрольСрока,
	|		Таблица.ОплачиваетсяПередЗаписьюКонтрольСрока    КАК ОплачиваетсяИзменениеКонтрольСрока,
	|		Таблица.АналитикаУчетаПоПартнерам                КАК АналитикаУчетаПоПартнерам
	|	ИЗ
	|		РасчетыСКлиентамиПередЗаписью КАК Таблица
	|	
	|	ОБЪЕДИНИТЬ ВСЕ
	|	
	|	ВЫБРАТЬ
	|		Таблица.Регистратор                   КАК Регистратор,
	|		Таблица.ОбъектРасчетов                КАК ОбъектРасчетов,
	|		Таблица.Валюта                        КАК Валюта,
	|		ВЫБОР КОГДА Таблица.ВидДвижения = ЗНАЧЕНИЕ(ВидДвиженияНакопления.Расход) ТОГДА
	|				ВЫБОР КОГДА Таблица.Сумма < 0 ТОГДА
	|						0
	|					ИНАЧЕ Таблица.Сумма
	|				КОНЕЦ
	|			ИНАЧЕ -Таблица.Сумма
	|		КОНЕЦ                                 КАК СуммаИзменение,
	|		ВЫБОР КОГДА Таблица.Период <= &ПериодКонтроляСрокаДолга ТОГДА
	|			ВЫБОР КОГДА Таблица.ВидДвижения = ЗНАЧЕНИЕ(ВидДвиженияНакопления.Расход) ТОГДА
	|					Таблица.КОплате
	|				ИНАЧЕ -Таблица.КОплате
	|			КОНЕЦ
	|		ИНАЧЕ
	|			0
	|		КОНЕЦ                                 КАК КОплатеИзменениеКонтрольСрока,
	|		ВЫБОР КОГДА Таблица.Период <= &ПериодКонтроляСрокаДолга ТОГДА
	|			ВЫБОР КОГДА Таблица.ВидДвижения = ЗНАЧЕНИЕ(ВидДвиженияНакопления.Расход) ТОГДА
	|					-Таблица.Оплачивается
	|				ИНАЧЕ Таблица.Оплачивается
	|			КОНЕЦ
	|		ИНАЧЕ
	|			0
	|		КОНЕЦ                                 КАК ОплачиваетсяИзменениеКонтрольСрока,
	|		Таблица.АналитикаУчетаПоПартнерам     КАК АналитикаУчетаПоПартнерам
	|	ИЗ
	|		РегистрНакопления.РасчетыСКлиентами КАК Таблица
	|	ГДЕ
	|		Таблица.Регистратор = &Регистратор
	|		И Таблица.ОбъектРасчетов.Объект <> НЕОПРЕДЕЛЕНО
	|
	|) КАК ТаблицаИзменений
	|
	|ГДЕ
	|	&ПроведениеДокумента
	|	И НЕ &ОбменДанными
	|	И &РассчитыватьИзменения
	|	И НЕ ТИПЗНАЧЕНИЯ(ТаблицаИзменений.Регистратор) В (
	|		ТИП(Документ.ПоступлениеБезналичныхДенежныхСредств),
	|		ТИП(Документ.ПриходныйКассовыйОрдер),
	|		ТИП(Документ.ОперацияПоПлатежнойКарте),
	|		ТИП(Документ.ВзаимозачетЗадолженности),
	|		ТИП(Документ.СписаниеЗадолженности)
	|		)
	|
	|СГРУППИРОВАТЬ ПО
	|	ТаблицаИзменений.Регистратор,
	|	ТаблицаИзменений.ОбъектРасчетов,
	|	ТаблицаИзменений.Валюта,
	|	ТаблицаИзменений.АналитикаУчетаПоПартнерам
	|
	|ИМЕЮЩИЕ
	|	СУММА(ТаблицаИзменений.СуммаИзменение) < 0
	|	ИЛИ (СУММА(ТаблицаИзменений.КОплатеИзменениеКонтрольСрока)
	|			+ СУММА(ТаблицаИзменений.ОплачиваетсяИзменениеКонтрольСрока)) < 0
	|;
	|/////////////////////////////////////////////////////
	|ВЫБРАТЬ РАЗЛИЧНЫЕ
	|	НАЧАЛОПЕРИОДА(Таблица.Период, МЕСЯЦ)        КАК Месяц,
	|	Таблица.Период                              КАК Период,
	|	Таблица.ПорядокОперации                     КАК ПорядокОперации,
	|	Таблица.ПорядокЗачетаПоДатеПлатежа          КАК ПорядокЗачетаПоДатеПлатежа,
	|	Таблица.АналитикаУчетаПоПартнерам           КАК АналитикаУчетаПоПартнерам,
	|	Таблица.ОбъектРасчетов                      КАК ОбъектРасчетов,
	|	Таблица.Валюта                              КАК ВалютаРасчетов,
	|	Таблица.Регистратор                         КАК Документ,
	|	СУММА(Таблица.Сумма)                        КАК Сумма,
	|	СУММА(Таблица.КОплате)                      КАК КОплате,
	|	СУММА(Таблица.КОтгрузке)                    КАК КОтгрузке,
	|	СУММА(Таблица.СуммаРегл)                    КАК СуммаРегл,
	|	СУММА(Таблица.СуммаУпр)                     КАК СуммаУпр,
	|	ЕСТЬNULL(Ключи.Организация,Неопределено)    КАК Организация,
	|	Таблица.КорОбъектРасчетов                   КАК КорОбъектРасчетов,
	|	Таблица.Заказ                               КАК Заказ
	|ПОМЕСТИТЬ РасчетыСКлиентамиИзменения
	|ИЗ
	|	(ВЫБРАТЬ
	|		Расчеты.Регистратор                   КАК Регистратор,
	|		Расчеты.Период                        КАК Период,
	|		Расчеты.АналитикаУчетаПоПартнерам     КАК АналитикаУчетаПоПартнерам,
	|		Расчеты.ОбъектРасчетов                КАК ОбъектРасчетов,
	|		Расчеты.Валюта                        КАК Валюта,
	|		Расчеты.Сумма                         КАК Сумма,
	|		Расчеты.Оплачивается                  КАК Оплачивается,
	|		Расчеты.Отгружается                   КАК Отгружается,
	|		Расчеты.КОплате                       КАК КОплате,
	|		Расчеты.КОтгрузке                     КАК КОтгрузке,
	|		Расчеты.ХозяйственнаяОперация         КАК ХозяйственнаяОперация,
	|		Расчеты.СуммаРегл                     КАК СуммаРегл,
	|		Расчеты.СуммаУпр                      КАК СуммаУпр,
	|		Расчеты.СтатьяДвиженияДенежныхСредств КАК СтатьяДвиженияДенежныхСредств,
	|		ВЫБОР КОГДА ТИПЗНАЧЕНИЯ(Расчеты.Регистратор) = ТИП(Документ.ВзаимозачетЗадолженности)
	|				И Расчеты.ВидДвижения = ЗНАЧЕНИЕ(ВидДвиженияНакопления.Расход) И Расчеты.Сумма > 0
	|			ТОГДА 0
	|			КОГДА ТИПЗНАЧЕНИЯ(Расчеты.Регистратор) = ТИП(Документ.ВзаимозачетЗадолженности)
	|				И Расчеты.ВидДвижения = ЗНАЧЕНИЕ(ВидДвиженияНакопления.Расход) И Расчеты.Сумма < 0
	|			ТОГДА -1
	|			ИНАЧЕ 1
	|		КОНЕЦ КАК ИндексДвиженияВзаимозачета,
	|		Расчеты.ПорядокОперации               КАК ПорядокОперации,
	|		Расчеты.ПорядокЗачетаПоДатеПлатежа    КАК ПорядокЗачетаПоДатеПлатежа,
	|		Расчеты.РасчетныйДокумент             КАК РасчетныйДокумент,
	|		Расчеты.КорОбъектРасчетов             КАК КорОбъектРасчетов,
	|		Расчеты.ВалютаДокумента               КАК ВалютаДокумента,
	|		Расчеты.ВариантОплаты                 КАК ВариантОплаты,
	|		Расчеты.ДатаПлатежа                   КАК ДатаПлатежа,
	|		Расчеты.ПродажаПоЗаказу               КАК Заказ
	|	ИЗ РасчетыСКлиентамиИсходныеДвижения КАК Расчеты
	|		
	|	ОБЪЕДИНИТЬ ВСЕ
	|		
	|	ВЫБРАТЬ
	|		Расчеты.Регистратор                   КАК Регистратор,
	|		Расчеты.Период                        КАК Период,
	|		Расчеты.АналитикаУчетаПоПартнерам     КАК АналитикаУчетаПоПартнерам,
	|		Расчеты.ОбъектРасчетов                КАК ОбъектРасчетов,
	|		Расчеты.Валюта                        КАК Валюта,
	|		-Расчеты.Сумма                        КАК Сумма,
	|		-Расчеты.Оплачивается                 КАК Оплачивается,
	|		-Расчеты.Отгружается                  КАК Отгружается,
	|		-Расчеты.КОплате                      КАК КОплате,
	|		-Расчеты.КОтгрузке                    КАК КОтгрузке,
	|		Расчеты.ХозяйственнаяОперация         КАК ХозяйственнаяОперация,
	|		-Расчеты.СуммаРегл                    КАК СуммаРегл,
	|		-Расчеты.СуммаУпр                     КАК СуммаУпр,
	|		Расчеты.СтатьяДвиженияДенежныхСредств КАК СтатьяДвиженияДенежныхСредств,
	|		ВЫБОР КОГДА ТИПЗНАЧЕНИЯ(Расчеты.Регистратор) = ТИП(Документ.ВзаимозачетЗадолженности)
	|				И Расчеты.ВидДвижения = ЗНАЧЕНИЕ(ВидДвиженияНакопления.Расход) И Расчеты.Сумма > 0
	|			ТОГДА 0
	|			КОГДА ТИПЗНАЧЕНИЯ(Расчеты.Регистратор) = ТИП(Документ.ВзаимозачетЗадолженности)
	|				И Расчеты.ВидДвижения = ЗНАЧЕНИЕ(ВидДвиженияНакопления.Расход) И Расчеты.Сумма < 0
	|			ТОГДА -1
	|			ИНАЧЕ 1
	|		КОНЕЦ КАК ИндексДвиженияВзаимозачета,
	|		Расчеты.ПорядокОперации               КАК ПорядокОперации,
	|		Расчеты.ПорядокЗачетаПоДатеПлатежа    КАК ПорядокЗачетаПоДатеПлатежа,
	|		Расчеты.РасчетныйДокумент             КАК РасчетныйДокумент,
	|		Расчеты.КорОбъектРасчетов             КАК КорОбъектРасчетов,
	|		Расчеты.ВалютаДокумента               КАК ВалютаДокумента,
	|		Расчеты.ВариантОплаты                 КАК ВариантОплаты,
	|		Расчеты.ДатаПлатежа                   КАК ДатаПлатежа,
	|		Расчеты.ПродажаПоЗаказу               КАК Заказ
	|	ИЗ РегистрНакопления.РасчетыСКлиентами КАК Расчеты
	|	ГДЕ Расчеты.Регистратор = &Регистратор
	|) КАК Таблица
	|
	|	ЛЕВОЕ СОЕДИНЕНИЕ Справочник.КлючиАналитикиУчетаПоПартнерам КАК Ключи
	|	ПО Ключи.Ссылка = Таблица.АналитикаУчетаПоПартнерам
	|СГРУППИРОВАТЬ ПО
	|	Таблица.Период,
	|	Таблица.Регистратор,
	|	Таблица.АналитикаУчетаПоПартнерам,
	|	Таблица.ОбъектРасчетов,
	|	Таблица.Валюта,
	|	Таблица.ХозяйственнаяОперация,
	|	Таблица.СтатьяДвиженияДенежныхСредств,
	|	Таблица.ИндексДвиженияВзаимозачета,
	|	Таблица.РасчетныйДокумент,
	|	Таблица.КорОбъектРасчетов,
	|	Таблица.ВалютаДокумента,
	|	Таблица.ВариантОплаты,
	|	Таблица.ДатаПлатежа,
	|	Ключи.Организация,
	|	Таблица.КорОбъектРасчетов,
	|	Таблица.ПорядокОперации,
	|	Таблица.ПорядокЗачетаПоДатеПлатежа,
	|	Таблица.Заказ
	|ИМЕЮЩИЕ
	|	СУММА(Таблица.Сумма) <> 0
	|	ИЛИ СУММА(Таблица.СуммаРегл) <> 0
	|	ИЛИ СУММА(Таблица.СуммаУпр) <> 0
	|	ИЛИ СУММА(Таблица.КОплате) <> 0
	|	ИЛИ СУММА(Таблица.КОтгрузке) <> 0
	|;
	|ВЫБРАТЬ
	|	ТаблицаИзменений.ОбъектРасчетов         КАК ОбъектРасчетов,
	|	ТаблицаИзменений.Валюта                 КАК Валюта,
	|	СУММА(ТаблицаИзменений.СуммаКИзменению) КАК СуммаКИзменению
	|	
	|ПОМЕСТИТЬ ДвиженияРасчетыСКлиентамиИзменениеАвансыПоНакладным
	|ИЗ
	|	(ВЫБРАТЬ
	|		Таблица.ОбъектРасчетов             КАК ОбъектРасчетов,
	|		Таблица.Валюта                     КАК Валюта,
	|		Таблица.СуммаПередЗаписью          КАК СуммаКИзменению
	|	ИЗ
	|		РасчетыСКлиентамиПередЗаписью КАК Таблица
	|	
	|	ОБЪЕДИНИТЬ ВСЕ
	|	
	|	ВЫБРАТЬ
	|		Таблица.ОбъектРасчетов   КАК ОбъектРасчетов,
	|		Таблица.Валюта           КАК Валюта,
	|		-Таблица.Сумма           КАК СуммаКИзменению
	|	ИЗ
	|		РегистрНакопления.РасчетыСКлиентами КАК Таблица
	|			ВНУТРЕННЕЕ СОЕДИНЕНИЕ Справочник.ОбъектыРасчетов КАК ОбъектыРасчетов
	|				ПО ОбъектыРасчетов.Ссылка = Таблица.ОбъектРасчетов
	|	ГДЕ
	|		Таблица.Регистратор = &Регистратор
	|		И ТИПЗНАЧЕНИЯ(ОбъектыРасчетов.Объект) В (ТИП(Документ.ПоступлениеБезналичныхДенежныхСредств),
	|													ТИП(Документ.СписаниеБезналичныхДенежныхСредств),
	|													ТИП(Документ.ПриходныйКассовыйОрдер),
	|													ТИП(Документ.РасходныйКассовыйОрдер),
	|													ТИП(Документ.ОперацияПоПлатежнойКарте))
	|) КАК ТаблицаИзменений
	|ГДЕ
	|	НЕ &ОбменДанными
	|	И &РассчитыватьИзменения
	|СГРУППИРОВАТЬ ПО
	|	ТаблицаИзменений.ОбъектРасчетов,
	|	ТаблицаИзменений.Валюта
	|
	|ИМЕЮЩИЕ
	|	СУММА(ТаблицаИзменений.СуммаКИзменению) <> 0;
	|////////////////////////////////////////////////////
	|УНИЧТОЖИТЬ РасчетыСКлиентамиПередЗаписью;
	|////////////////////////////////////////////////////
	|УНИЧТОЖИТЬ РасчетыСКлиентамиИсходныеДвижения;
	|");
	
	Запрос.УстановитьПараметр("Регистратор",              Отбор.Регистратор.Значение);
	Запрос.УстановитьПараметр("ПроведениеДокумента",      ДополнительныеСвойства.СвойстваДокумента.РежимЗаписи = РежимЗаписиДокумента.Проведение);
	Запрос.УстановитьПараметр("ПериодКонтроляСрокаДолга", Макс(КонецДня(ТекущаяДатаСеанса()), КонецДня(ДополнительныеСвойства.ДатаРегистратора)));
	Запрос.УстановитьПараметр("ОбменДанными",             ОбменДанными.Загрузка);
	Запрос.УстановитьПараметр("РассчитыватьИзменения",    ПроведениеДокументов.РассчитыватьИзменения(ДополнительныеСвойства));
	Запрос.УстановитьПараметр("НовыеРасчеты",             ПолучитьФункциональнуюОпцию("НоваяАрхитектураВзаиморасчетов"));
	
	Запрос.МенеджерВременныхТаблиц = ДополнительныеСвойства.МенеджерВременныхТаблиц;
	
	Результат = Запрос.ВыполнитьПакет();
	
	Если НЕ ПолучитьФункциональнуюОпцию("ОтложенноеОбновлениеЗавершеноУспешно") Тогда
		
		Если ПолучитьФункциональнуюОпцию("НоваяАрхитектураВзаиморасчетов") Тогда
			ФинансовыйРегистрВзаиморасчетовОбработан = ОбновлениеИнформационнойБазы.ОбъектОбработан("РасчетыСКлиентамиПоСрокам").Обработан
				И ОбновлениеИнформационнойБазы.ОбъектОбработан("РасчетыСКлиентамиПланОплат").Обработан
				И ОбновлениеИнформационнойБазы.ОбъектОбработан("РасчетыСКлиентамиПланОтгрузок").Обработан;
		Иначе
			ФинансовыйРегистрВзаиморасчетовОбработан = ОбновлениеИнформационнойБазы.ОбъектОбработан("РасчетыСКлиентамиПоДокументам").Обработан
		КонецЕсли;
		
		Если НЕ ФинансовыйРегистрВзаиморасчетовОбработан
			ИЛИ НЕ ОбновлениеИнформационнойБазы.ОбъектОбработан("РасчетыСКлиентами").Обработан Тогда
			Отказ = Истина;
			ОбщегоНазначения.СообщитьПользователю(НСтр("ru='Для проведения документа дождитесь окончания обновления регистров взаиморасчетов.';uk='Для проведення документа дочекайтеся закінчення оновлення регістрів взаєморозрахунків.'"));
		КонецЕсли;
		
	КонецЕсли;
	
	Выборка = Результат[0].Выбрать();
	ПроведениеДокументов.ЗарегистрироватьТаблицуКонтроля(ДополнительныеСвойства,
		"ДвиженияРасчетыСКлиентамиИзменение", Выборка.Следующий() И Выборка.Количество > 0);
	Выборка = Результат[1].Выбрать();
	ПроведениеДокументов.ЗарегистрироватьТаблицуКонтроля(ДополнительныеСвойства,
		"ДвиженияРасчетыСКлиентамиИзменениеСуммыДолга", Выборка.Следующий() И Выборка.Количество > 0);
	Выборка = Результат[2].Выбрать();
	ПроведениеДокументов.ЗарегистрироватьТаблицуКонтроля(ДополнительныеСвойства,
		"ДвиженияРасчетыСКлиентамиИзменениеКонтрольСрока", Выборка.Следующий() И Выборка.Количество > 0);
	Выборка = Результат[4].Выбрать();
	ПроведениеДокументов.ЗарегистрироватьТаблицуКонтроля(ДополнительныеСвойства,
		"ДвиженияРасчетыСКлиентамиИзменениеАвансыПоНакладным", Выборка.Следующий() И Выборка.Количество > 0);
	
	Если ОбменДанными.Загрузка Тогда
		ОперативныеВзаиморасчетыСервер.ЗарегистрироватьИзмененияКОтложенномуРаспределению(Истина, Запрос.МенеджерВременныхТаблиц, Отбор.Регистратор.Значение);
		Возврат;
	КонецЕсли;
	
	Если Константы.НачатПереходНаНовуюАрхитектуруВзаиморасчетов.Получить() Тогда
		ОперативныеВзаиморасчетыСервер.ОтметитьКПереносу(ЭтотОбъект);
	КонецЕсли;
	
	Если ПолучитьФункциональнуюОпцию("НоваяАрхитектураВзаиморасчетов") Тогда
		ОперативныеВзаиморасчетыСервер.РассчитатьПоИзменениям(Запрос.МенеджерВременныхТаблиц, Истина, Отбор.Регистратор.Значение, ДополнительныеСвойства);
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

// Формирует таблицу объектов расчетов, которые были раньше в движениях и которые сейчас будут записаны.
//
Процедура СформироватьТаблицуОбъектовОплаты()
	
	Запрос = Новый Запрос;
	Запрос.УстановитьПараметр("Регистратор", Отбор.Регистратор.Значение);
	Запрос.УстановитьПараметр("ТаблицаНовыхОбъектовРасчетов", Выгрузить(, "ОбъектРасчетов"));

	Запрос.Текст = 
	"ВЫБРАТЬ
	|	ВЫРАЗИТЬ(Таблица.ОбъектРасчетов КАК Справочник.ОбъектыРасчетов) КАК ОбъектРасчетов
	|ПОМЕСТИТЬ ОбъектыРасчетов
	|ИЗ
	|	&ТаблицаНовыхОбъектовРасчетов КАК Таблица
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ РАЗЛИЧНЫЕ
	|	Таблица.ОбъектРасчетов.Объект КАК ОбъектОплаты,
	|	Таблица.ОбъектРасчетов КАК ОбъектРасчетов
	|ПОМЕСТИТЬ ОбъектыРасчетовПоРегистратору
	|ИЗ
	|	РегистрНакопления.РасчетыСКлиентами КАК Таблица
	|ГДЕ
	|	Таблица.Регистратор = &Регистратор
	|	И Таблица.ОбъектРасчетов <> ЗНАЧЕНИЕ(Справочник.ОбъектыРасчетов.ПустаяСсылка)
	|
	|ОБЪЕДИНИТЬ
	|
	|ВЫБРАТЬ РАЗЛИЧНЫЕ
	|	ОбъектыРасчетов.ОбъектРасчетов.Объект,
	|	ОбъектыРасчетов.ОбъектРасчетов
	|ИЗ
	|	ОбъектыРасчетов КАК ОбъектыРасчетов
	|ГДЕ
	|	ОбъектыРасчетов.ОбъектРасчетов.Объект <> НЕОПРЕДЕЛЕНО
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ
	|	ОбъектыРасчетовПоРегистратору.ОбъектОплаты КАК ОбъектОплаты,
	|	ОбъектыРасчетовПоРегистратору.ОбъектРасчетов КАК ОбъектРасчетов
	|ИЗ
	|	ОбъектыРасчетовПоРегистратору КАК ОбъектыРасчетовПоРегистратору
	|
	|ОБЪЕДИНИТЬ
	|
	|ВЫБРАТЬ РАЗЛИЧНЫЕ
	|	ОбъектыРасчетовПоРегистратору.ОбъектОплаты,
	|	ОбъектыРасчетов.Ссылка
	|ИЗ
	|	ОбъектыРасчетовПоРегистратору КАК ОбъектыРасчетовПоРегистратору
	|		ВНУТРЕННЕЕ СОЕДИНЕНИЕ Справочник.ОбъектыРасчетов КАК ОбъектыРасчетов
	|		ПО ОбъектыРасчетовПоРегистратору.ОбъектОплаты = ОбъектыРасчетов.Объект";                   
	
	ДополнительныеСвойства.Вставить("ТаблицаОбъектовОплаты", Запрос.Выполнить().Выгрузить());
	
КонецПроцедуры

Процедура ЗагрузитьСОбработкой(ТаблицаРасчетов) Экспорт
	
	ВзаиморасчетыСервер.ДобавитьЗаполнитьПорядокРасчетовСКлиентами(ТаблицаРасчетов, ТипЗнч(ЭтотОбъект.Отбор.Регистратор.Значение));
	ЭтотОбъект.Загрузить(ТаблицаРасчетов);
	
КонецПроцедуры

#КонецОбласти

#КонецЕсли
