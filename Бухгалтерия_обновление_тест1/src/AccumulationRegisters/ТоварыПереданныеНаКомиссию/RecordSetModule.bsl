#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ОбработчикиСобытий

Процедура ПередЗаписью(Отказ, Замещение)
	
	Если ОбменДанными.Загрузка Тогда
		Возврат;
	КонецЕсли;
	
	ОбновлениеИнформационнойБазы.ПроверитьОбъектОбработан(ЭтотОбъект);
	
	Если Не ПроведениеДокументов.КонтролироватьИзменения(ДополнительныеСвойства)
		Или ПланыОбмена.ГлавныйУзел() <> Неопределено Тогда
		Возврат;
	КонецЕсли;
	
	БлокироватьДляИзменения = Истина;
	
	ДополнительныеСвойства.Вставить("ПартионныйУчетВключен",
		РасчетСебестоимостиПовтИсп.ПартионныйУчетВключен(
			НачалоМесяца(ДополнительныеСвойства.ДатаРегистратора)));
	
	// Текущее состояние набора помещается во временную таблицу,
	// чтобы при записи получить изменение нового набора относительно текущего.
	Запрос = Новый Запрос("
	|ВЫБРАТЬ
	|	Товары.Период                     КАК Период,
	|	Товары.Регистратор                КАК Регистратор,
	|	Товары.АналитикаУчетаНоменклатуры КАК АналитикаУчетаНоменклатуры,
	|	Товары.Соглашение                 КАК Соглашение,
	|	Товары.Организация                КАК Организация,
	|	Товары.ВидЗапасов                 КАК ВидЗапасов,
	|	Товары.НомерГТД                   КАК НомерГТД,
	|
	|	Товары.Количество          КАК Количество,
	|	Товары.СуммаВыручки        КАК СуммаВыручки,
	|	Товары.СуммаВознаграждения КАК СуммаВознаграждения,
	|
	|	Товары.КорАналитикаУчетаНоменклатуры КАК КорАналитикаУчетаНоменклатуры,
	|	Товары.ДокументРеализации            КАК ДокументРеализации,
	|	Товары.ХозяйственнаяОперация         КАК ХозяйственнаяОперация,
    |	Товары.НалоговоеНазначение           КАК НалоговоеНазначение,
	|	Товары.Номенклатура                  КАК Номенклатура,
	|	Товары.Характеристика                КАК Характеристика
	|ПОМЕСТИТЬ ТоварыПереданныеПередЗаписью
	|ИЗ
	|	РегистрНакопления.ТоварыПереданныеНаКомиссию КАК Товары
	|ГДЕ
	|	Товары.Регистратор = &Регистратор
	|	И &ПартионныйУчетВключен
	|");
	
	Запрос.УстановитьПараметр("Регистратор", Отбор.Регистратор.Значение);
	Запрос.УстановитьПараметр("ПартионныйУчетВключен", ДополнительныеСвойства.ПартионныйУчетВключен);
	
	Запрос.МенеджерВременныхТаблиц = ДополнительныеСвойства.МенеджерВременныхТаблиц;
	Запрос.Выполнить();
	
КонецПроцедуры

Процедура ПриЗаписи(Отказ, Замещение)
	
	Если ОбменДанными.Загрузка Или Не ПроведениеДокументов.КонтролироватьИзменения(ДополнительныеСвойства)
		Или ПланыОбмена.ГлавныйУзел() <> Неопределено Тогда
		Возврат;
	КонецЕсли;
	
	// Рассчитывается изменение нового набора относительно текущего с учетом накопленных изменений
	// и помещается во временную таблицу.
	Запрос = Новый Запрос("ВЫБРАТЬ
	|	Таблица.Период КАК Период,
	|	Таблица.Регистратор КАК Регистратор,
	|	Таблица.АналитикаУчетаНоменклатуры КАК АналитикаУчетаНоменклатуры,
	|	Таблица.Соглашение КАК Соглашение,
	|	Таблица.Организация КАК Организация,
	|	Таблица.ВидЗапасов КАК ВидЗапасов,
	|	Таблица.НомерГТД КАК НомерГТД,
	|	Таблица.КорАналитикаУчетаНоменклатуры КАК КорАналитикаУчетаНоменклатуры,
	|	Таблица.ДокументРеализации КАК ДокументРеализации,
	|	Таблица.ХозяйственнаяОперация КАК ХозяйственнаяОперация,
    |	Таблица.НалоговоеНазначение КАК НалоговоеНазначение,
	|	Таблица.Номенклатура КАК Номенклатура,
	|	Таблица.Характеристика КАК Характеристика,
	|	СУММА(Таблица.Количество) КАК КоличествоИзменение,
	|	СУММА(Таблица.СуммаВыручки) КАК СуммаВыручкиИзменение,
	|	СУММА(Таблица.СуммаВознаграждения) КАК СуммаВознагражденияИзменение
	|ПОМЕСТИТЬ ТаблицаИзмененийТоварыПереданныеНаКомиссию
	|ИЗ
	|	(ВЫБРАТЬ
	|		Товары.Период КАК Период,
	|		Товары.Регистратор КАК Регистратор,
	|		Товары.АналитикаУчетаНоменклатуры КАК АналитикаУчетаНоменклатуры,
	|		Товары.Соглашение КАК Соглашение,
	|		Товары.Организация КАК Организация,
	|		Товары.ВидЗапасов КАК ВидЗапасов,
	|		Товары.НомерГТД КАК НомерГТД,
	|		Товары.Количество КАК Количество,
	|		Товары.СуммаВыручки КАК СуммаВыручки,
	|		Товары.СуммаВознаграждения КАК СуммаВознаграждения,
	|		Товары.КорАналитикаУчетаНоменклатуры КАК КорАналитикаУчетаНоменклатуры,
	|		Товары.ДокументРеализации КАК ДокументРеализации,
	|		Товары.ХозяйственнаяОперация КАК ХозяйственнаяОперация,
    |		Товары.НалоговоеНазначение КАК НалоговоеНазначение,
	|		Товары.Номенклатура КАК Номенклатура,
	|		Товары.Характеристика КАК Характеристика
	|	ИЗ
	|		ТоварыПереданныеПередЗаписью КАК Товары
	|	ГДЕ
	|		&ПартионныйУчетВключен
	|
	|	ОБЪЕДИНИТЬ ВСЕ
	|
	|	ВЫБРАТЬ
	|		Товары.Период КАК Период,
	|		Товары.Регистратор КАК Регистратор,
	|		Товары.АналитикаУчетаНоменклатуры КАК АналитикаУчетаНоменклатуры,
	|		Товары.Соглашение КАК Соглашение,
	|		Товары.Организация КАК Организация,
	|		Товары.ВидЗапасов КАК ВидЗапасов,
	|		Товары.НомерГТД КАК НомерГТД,
	|		-Товары.Количество КАК Количество,
	|		-Товары.СуммаВыручки КАК СуммаВыручки,
	|		-Товары.СуммаВознаграждения КАК СуммаВознаграждения,
	|		Товары.КорАналитикаУчетаНоменклатуры КАК КорАналитикаУчетаНоменклатуры,
	|		Товары.ДокументРеализации КАК ДокументРеализации,
	|		Товары.ХозяйственнаяОперация КАК ХозяйственнаяОперация,
    |		Товары.НалоговоеНазначение КАК НалоговоеНазначение,
	|		Товары.Номенклатура КАК Номенклатура,
	|		Товары.Характеристика КАК Характеристика
	|	ИЗ
	|		РегистрНакопления.ТоварыПереданныеНаКомиссию КАК Товары
	|	ГДЕ
	|		Товары.Регистратор = &Регистратор
	|		И &ПартионныйУчетВключен) КАК Таблица
	|СГРУППИРОВАТЬ ПО
	|	Таблица.Период,
	|	Таблица.Регистратор,
	|	Таблица.АналитикаУчетаНоменклатуры,
	|	Таблица.Соглашение,
	|	Таблица.Организация,
	|	Таблица.ВидЗапасов,
	|	Таблица.НомерГТД,
	|	Таблица.КорАналитикаУчетаНоменклатуры,
	|	Таблица.ДокументРеализации,
	|	Таблица.ХозяйственнаяОперация,
    |	Таблица.НалоговоеНазначение,
	|	Таблица.Номенклатура,
	|	Таблица.Характеристика
	|ИМЕЮЩИЕ
	|	СУММА(Таблица.Количество) <> 0
	|	ИЛИ СУММА(Таблица.СуммаВыручки) <> 0
	|	ИЛИ СУММА(Таблица.СуммаВознаграждения) <> 0
	|");
	
	Запрос.УстановитьПараметр("Регистратор", Отбор.Регистратор.Значение);
	Запрос.УстановитьПараметр("ПартионныйУчетВключен", ДополнительныеСвойства.ПартионныйУчетВключен);
	
	Запрос.МенеджерВременныхТаблиц = ДополнительныеСвойства.МенеджерВременныхТаблиц;
	
	Запрос.Выполнить();
	
КонецПроцедуры

#КонецОбласти

#КонецЕсли