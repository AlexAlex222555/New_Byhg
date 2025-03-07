#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область СлужебныеПроцедурыИФункции

Процедура ПередЗаписью(Отказ, Замещение)
		
	Если ОбменДанными.Загрузка Тогда
		Возврат;
	КонецЕсли;

	ОбновлениеИнформационнойБазы.ПроверитьОбъектОбработан(ЭтотОбъект);
	
	Если Не ПроведениеДокументов.КонтролироватьИзменения(ДополнительныеСвойства) Тогда
		Возврат;
	КонецЕсли;
	
	Запрос = Новый Запрос("
	|ВЫБРАТЬ
	|	Расчеты.Регистратор               КАК Регистратор,
	|	Расчеты.Период                    КАК Период,
	|	Расчеты.АналитикаУчетаПоПартнерам КАК АналитикаУчетаПоПартнерам,
	|	Расчеты.ЗаказКлиента              КАК ЗаказКлиента,
	|	Расчеты.РасчетныйДокумент         КАК РасчетныйДокумент,
	|	Расчеты.Валюта                    КАК Валюта,
	|
	|	Расчеты.Долг             КАК Долг,
	|	Расчеты.ДолгУпр          КАК ДолгУпр,
	|	Расчеты.ДолгРегл         КАК ДолгРегл,
	|	Расчеты.Предоплата       КАК Предоплата,
	|	Расчеты.ПредоплатаУпр    КАК ПредоплатаУпр,
	|	Расчеты.ПредоплатаРегл   КАК ПредоплатаРегл,
	|	Расчеты.ЗалогЗаТару      КАК ЗалогЗаТару,
	|	Расчеты.ЗалогЗаТаруРегл  КАК ЗалогЗаТаруРегл,
	|
	|	Расчеты.ХозяйственнаяОперация         КАК ХозяйственнаяОперация,
	|	Расчеты.СтатьяДвиженияДенежныхСредств КАК СтатьяДвиженияДенежныхСредств
	|ПОМЕСТИТЬ РасчетыСКлиентамиПоДокументамИсходныеДвижения
	|ИЗ
	|	РегистрНакопления.РасчетыСКлиентамиПоДокументам КАК Расчеты
	|ГДЕ
	|	Расчеты.Регистратор = &Регистратор
	|");
	Запрос.УстановитьПараметр("Регистратор", Отбор.Регистратор.Значение);
	Запрос.МенеджерВременныхТаблиц = ДополнительныеСвойства.МенеджерВременныхТаблиц;
	Запрос.Выполнить();
	
КонецПроцедуры

Процедура ПриЗаписи(Отказ, Замещение)
	
	Если ОбменДанными.Загрузка Тогда
		Возврат;
	КонецЕсли;
	
	Если Не ПроведениеДокументов.КонтролироватьИзменения(ДополнительныеСвойства) Тогда
		Возврат;
	КонецЕсли;
	
	МассивТекстовЗапроса = Новый Массив;
	ТекстЗапроса =
	"ВЫБРАТЬ РАЗЛИЧНЫЕ
	|	Таблица.Период                       КАК Период,
	|	Таблица.АналитикаУчетаПоПартнерам    КАК АналитикаУчетаПоПартнерам,
	|	Таблица.ЗаказКлиента                 КАК ОбъектРасчетов,
	|	Таблица.РасчетныйДокумент            КАК РасчетныйДокумент,
	|	Таблица.Регистратор                  КАК Регистратор
	|ПОМЕСТИТЬ РасчетыСКлиентамиПоДокументамИзменения
	|ИЗ
	|	(ВЫБРАТЬ
	|		Расчеты.Регистратор               КАК Регистратор,
	|		Расчеты.Период                    КАК Период,
	|		Расчеты.АналитикаУчетаПоПартнерам КАК АналитикаУчетаПоПартнерам,
	|		Расчеты.ЗаказКлиента              КАК ЗаказКлиента,
	|		Расчеты.РасчетныйДокумент         КАК РасчетныйДокумент,
	|		Расчеты.Валюта                    КАК Валюта,
	|
	|		Расчеты.Долг             КАК Долг,
	|		Расчеты.ДолгУпр          КАК ДолгУпр,
	|		Расчеты.ДолгРегл         КАК ДолгРегл,
	|		Расчеты.Предоплата       КАК Предоплата,
	|		Расчеты.ПредоплатаУпр    КАК ПредоплатаУпр,
	|		Расчеты.ПредоплатаРегл   КАК ПредоплатаРегл,
	|		Расчеты.ЗалогЗаТару      КАК ЗалогЗаТару,
	|		Расчеты.ЗалогЗаТаруРегл  КАК ЗалогЗаТаруРегл,
	|
	|		Расчеты.ХозяйственнаяОперация         КАК ХозяйственнаяОперация,
	|		Расчеты.СтатьяДвиженияДенежныхСредств КАК СтатьяДвиженияДенежныхСредств
	|	ИЗ
	|		РасчетыСКлиентамиПоДокументамИсходныеДвижения КАК Расчеты
	|		
	|	ОБЪЕДИНИТЬ ВСЕ
	|		
	|	ВЫБРАТЬ
	|		Расчеты.Регистратор               КАК Регистратор,
	|		Расчеты.Период                    КАК Период,
	|		Расчеты.АналитикаУчетаПоПартнерам КАК АналитикаУчетаПоПартнерам,
	|		Расчеты.ЗаказКлиента              КАК ЗаказКлиента,
	|		Расчеты.РасчетныйДокумент         КАК РасчетныйДокумент,
	|		Расчеты.Валюта                    КАК Валюта,
	|
	|		-Расчеты.Долг             КАК Долг,
	|		-Расчеты.ДолгУпр          КАК ДолгУпр,
	|		-Расчеты.ДолгРегл         КАК ДолгРегл,
	|		-Расчеты.Предоплата       КАК Предоплата,
	|		-Расчеты.ПредоплатаУпр    КАК ПредоплатаУпр,
	|		-Расчеты.ПредоплатаРегл   КАК ПредоплатаРегл,
	|		-Расчеты.ЗалогЗаТару      КАК ЗалогЗаТару,
	|		-Расчеты.ЗалогЗаТаруРегл  КАК ЗалогЗаТаруРегл,
	|
	|		Расчеты.ХозяйственнаяОперация         КАК ХозяйственнаяОперация,
	|		Расчеты.СтатьяДвиженияДенежныхСредств КАК СтатьяДвиженияДенежныхСредств
	|	ИЗ
	|		РегистрНакопления.РасчетыСКлиентамиПоДокументам КАК Расчеты
	|	ГДЕ Расчеты.Регистратор = &Регистратор
	|) КАК Таблица
	|СГРУППИРОВАТЬ ПО
	|	Таблица.Период,
	|	Таблица.Регистратор,
	|	Таблица.АналитикаУчетаПоПартнерам,
	|	Таблица.ЗаказКлиента,
	|	Таблица.РасчетныйДокумент,
	|	Таблица.Валюта,
	|	Таблица.ХозяйственнаяОперация,
	|	Таблица.СтатьяДвиженияДенежныхСредств
	|ИМЕЮЩИЕ
	|	СУММА(Таблица.Долг) <> 0 ИЛИ СУММА(Таблица.ДолгУпр) <> 0 ИЛИ СУММА(Таблица.ДолгРегл) <> 0
	|	ИЛИ СУММА(Таблица.Предоплата) <> 0 ИЛИ СУММА(Таблица.ПредоплатаУпр) <> 0 ИЛИ СУММА(Таблица.ПредоплатаРегл) <> 0
	|	ИЛИ СУММА(Таблица.ЗалогЗаТару) <> 0 ИЛИ СУММА(Таблица.ЗалогЗаТаруРегл) <> 0
	|";
	МассивТекстовЗапроса.Добавить(ТекстЗапроса);
	
	ТекстЗапроса =
	"ВЫБРАТЬ РАЗЛИЧНЫЕ
	|	НАЧАЛОПЕРИОДА(Таблица.Период, МЕСЯЦ) КАК Месяц,
	|	Таблица.АналитикаУчетаПоПартнерам    КАК АналитикаУчетаПоПартнерам,
	|	Таблица.ОбъектРасчетов               КАК ОбъектРасчетов,
	|	Таблица.Регистратор                  КАК Документ
	|ПОМЕСТИТЬ РасчетыСКлиентамиПоДокументамЗаданияКРасчетамСКлиентами
	|ИЗ
	|	РасчетыСКлиентамиПоДокументамИзменения КАК Таблица
	|ГДЕ
	|	ТИПЗНАЧЕНИЯ(Таблица.Регистратор) = ТИП(Документ.РасчетКурсовыхРазниц)";
	МассивТекстовЗапроса.Добавить(ТекстЗапроса);
	
	Если Не ПолучитьФункциональнуюОпцию("НоваяАрхитектураВзаиморасчетов") Тогда
		ТекстЗапроса =
		"ВЫБРАТЬ РАЗЛИЧНЫЕ
		|	НАЧАЛОПЕРИОДА(Изменения.Период, МЕСЯЦ)         КАК Период,
		|	Изменения.РасчетныйДокумент                    КАК Документ,
		|	Изменения.АналитикаУчетаПоПартнерам.Контрагент КАК Контрагент
		|ИЗ
		|	РасчетыСКлиентамиПоДокументамИзменения КАК Изменения";
		
		МассивТекстовЗапроса.Добавить(ТекстЗапроса);
	КонецЕсли;
	
	МассивТекстовЗапроса.Добавить("УНИЧТОЖИТЬ РасчетыСКлиентамиПоДокументамИзменения");
	МассивТекстовЗапроса.Добавить("УНИЧТОЖИТЬ РасчетыСКлиентамиПоДокументамИсходныеДвижения");
	
	Запрос = Новый Запрос(СтрСоединить(МассивТекстовЗапроса, ОбщегоНазначения.РазделительПакетаЗапросов()));
	Запрос.УстановитьПараметр("Регистратор", Отбор.Регистратор.Значение);
	Запрос.МенеджерВременныхТаблиц = ДополнительныеСвойства.МенеджерВременныхТаблиц;
	
	Результат = Запрос.ВыполнитьПакет();
	
КонецПроцедуры

#КонецОбласти

#КонецЕсли