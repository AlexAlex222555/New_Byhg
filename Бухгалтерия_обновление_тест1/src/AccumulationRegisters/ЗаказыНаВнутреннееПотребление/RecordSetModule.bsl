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
	|	Таблица.ЗаказНаВнутреннееПотребление КАК ЗаказНаВнутреннееПотребление,
	|	Таблица.Номенклатура                 КАК Номенклатура,
	|	Таблица.Характеристика               КАК Характеристика,
	|	Таблица.Серия                        КАК Серия,
	|	Таблица.Склад                        КАК Склад,
	|	Таблица.КодСтроки                    КАК КодСтроки,
	|	ВЫБОР КОГДА Таблица.ВидДвижения = ЗНАЧЕНИЕ(ВидДвиженияНакопления.Приход) ТОГДА
	|			Таблица.КОформлению
	|		ИНАЧЕ
	|			-Таблица.КОформлению
	|	КОНЕЦ                                КАК КОформлениюПередЗаписью
	|ПОМЕСТИТЬ ДвиженияЗаказыНаВнутреннееПотреблениеПередЗаписью
	|ИЗ
	|	РегистрНакопления.ЗаказыНаВнутреннееПотребление КАК Таблица
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
	|	ТаблицаИзменений.ЗаказНаВнутреннееПотребление КАК ЗаказНаВнутреннееПотребление,
	|	ТаблицаИзменений.Номенклатура                КАК Номенклатура,
	|	ТаблицаИзменений.Характеристика              КАК Характеристика,
	|	ТаблицаИзменений.Серия                       КАК Серия,
	|	ТаблицаИзменений.Склад                       КАК Склад,
	|	СУММА(ТаблицаИзменений.КОформлениюИзменение) КАК КОформлениюИзменение
	|ПОМЕСТИТЬ ДвиженияЗаказыНаВнутреннееПотреблениеИзменение
	|ИЗ
	|	(ВЫБРАТЬ
	|		Таблица.ЗаказНаВнутреннееПотребление КАК ЗаказНаВнутреннееПотребление,
	|		Таблица.Номенклатура                 КАК Номенклатура,
	|		Таблица.Характеристика               КАК Характеристика,
	|		Таблица.Серия                        КАК Серия,
	|		Таблица.Склад                        КАК Склад,
	|		Таблица.КОформлениюПередЗаписью      КАК КОформлениюИзменение
	|	ИЗ
	|		ДвиженияЗаказыНаВнутреннееПотреблениеПередЗаписью КАК Таблица
	|	
	|	ОБЪЕДИНИТЬ ВСЕ
	|	
	|	ВЫБРАТЬ
	|		Таблица.ЗаказНаВнутреннееПотребление КАК ЗаказНаВнутреннееПотребление,
	|		Таблица.Номенклатура                 КАК Номенклатура,
	|		Таблица.Характеристика               КАК Характеристика,
	|		Таблица.Серия                        КАК Серия,
	|		Таблица.Склад                        КАК Склад,
	|		ВЫБОР КОГДА Таблица.ВидДвижения = ЗНАЧЕНИЕ(ВидДвиженияНакопления.Приход) ТОГДА
	|				-Таблица.КОформлению
	|			ИНАЧЕ
	|				Таблица.КОформлению
	|		КОНЕЦ                                КАК КОформлениюИзменение
	|	ИЗ
	|		РегистрНакопления.ЗаказыНаВнутреннееПотребление КАК Таблица
	|	ГДЕ
	|		Таблица.Регистратор = &Регистратор) КАК ТаблицаИзменений
	|
	|СГРУППИРОВАТЬ ПО
	|	ТаблицаИзменений.ЗаказНаВнутреннееПотребление,
	|	ТаблицаИзменений.Номенклатура,
	|	ТаблицаИзменений.Характеристика,
	|	ТаблицаИзменений.Серия,
	|	ТаблицаИзменений.Склад
	|
	|ИМЕЮЩИЕ
	|	СУММА(ТаблицаИзменений.КОформлениюИзменение) <> 0
	|;
	|УНИЧТОЖИТЬ ДвиженияЗаказыНаВнутреннееПотреблениеПередЗаписью
	|";
	
	Выборка = Запрос.ВыполнитьПакет()[0].Выбрать();
	ЕстьИзменения = Выборка.Следующий() И Выборка.Количество > 0;
	ПроведениеДокументов.ЗарегистрироватьТаблицуКонтроля(ДополнительныеСвойства,
		"ДвиженияЗаказыНаВнутреннееПотреблениеИзменение", ЕстьИзменения);
	
	Если ЕстьИзменения
		И ПолучитьФункциональнуюОпцию("ИспользоватьДопустимоеОтклонениеОтгрузкиПриемкиМерныхТоваров") Тогда
		
		Запрос = Новый Запрос;
		Запрос.УстановитьПараметр("ДопустимоеОтклонениеОтгрузкиПриемкиМерныхТоваров",
			Константы.ДопустимоеОтклонениеОтгрузкиПриемкиМерныхТоваров.Получить());
		Запрос.УстановитьПараметр("МерныеТипыЕдиницИзмерений",
			Справочники.УпаковкиЕдиницыИзмерения.МерныеТипыЕдиницИзмерений());
		Запрос.МенеджерВременныхТаблиц = ДополнительныеСвойства.МенеджерВременныхТаблиц;
		
		ТекстЗапроса = "
		|ВЫБРАТЬ
		|	Таблица.ЗаказНаВнутреннееПотребление,
		|	Таблица.Номенклатура,
		|	Таблица.Характеристика,
		|	Таблица.Серия,
		|	Таблица.Склад
		|ПОМЕСТИТЬ ДвиженияЗаказыНаВнутреннееПотреблениеИзменениеМерныеТовары
		|ИЗ
		|	ДвиженияЗаказыНаВнутреннееПотреблениеИзменение КАК Таблица
		|ГДЕ 
		|	Таблица.Номенклатура.ЕдиницаИзмерения.ТипИзмеряемойВеличины В (&МерныеТипыЕдиницИзмерений)
		|СГРУППИРОВАТЬ ПО
		|	Таблица.ЗаказНаВнутреннееПотребление,
		|	Таблица.Номенклатура,
		|	Таблица.Характеристика,
		|	Таблица.Серия,
		|	Таблица.Склад
		|;
		|////////////////////////////////////////////////////////////////////////////////
		|";
		
		// Основная таблица
		ТекстЗапроса = ТекстЗапроса + "
		|ВЫБРАТЬ
		|	ЗаказыНаВнутреннееПотребление.ВидДвижения                  КАК ВидДвижения,
		|	ЗаказыНаВнутреннееПотребление.ЗаказНаВнутреннееПотребление КАК ЗаказНаВнутреннееПотребление,
		|	ЗаказыНаВнутреннееПотребление.Номенклатура                 КАК Номенклатура,
		|	ЗаказыНаВнутреннееПотребление.Характеристика               КАК Характеристика,
		|	ЗаказыНаВнутреннееПотребление.Склад                        КАК Склад,
		|	ЗаказыНаВнутреннееПотребление.Серия                        КАК Серия,
		|	ЗаказыНаВнутреннееПотребление.КОформлению                  КАК КОформлению
		|ПОМЕСТИТЬ ВТЗаказыНаВнутреннееПотребление
		|ИЗ
		|	РегистрНакопления.ЗаказыНаВнутреннееПотребление КАК ЗаказыНаВнутреннееПотребление
		|	ВНУТРЕННЕЕ СОЕДИНЕНИЕ
		|		ДвиженияЗаказыНаВнутреннееПотреблениеИзменение КАК Изменения
		|		ПО ЗаказыНаВнутреннееПотребление.ЗаказНаВнутреннееПотребление = Изменения.ЗаказНаВнутреннееПотребление
		|			И ЗаказыНаВнутреннееПотребление.Номенклатура              = Изменения.Номенклатура
		|			И ЗаказыНаВнутреннееПотребление.Характеристика            = Изменения.Характеристика
		|			И ЗаказыНаВнутреннееПотребление.Склад                     = Изменения.Склад
		|			И ЗаказыНаВнутреннееПотребление.Серия                     = Изменения.Серия
		|;
		|////////////////////////////////////////////////////////////////////////////////
		|";
		
		// Допустимые отклонения
		ТекстЗапроса = ТекстЗапроса + "
		|ВЫБРАТЬ
		|	ЗаказыНаВнутреннееПотребление.ЗаказНаВнутреннееПотребление КАК ЗаказНаВнутреннееПотребление,
		|	ЗаказыНаВнутреннееПотребление.Номенклатура                 КАК Номенклатура,
		|	ЗаказыНаВнутреннееПотребление.Характеристика               КАК Характеристика,
		|	ЗаказыНаВнутреннееПотребление.Склад                        КАК Склад,
		|	ЗаказыНаВнутреннееПотребление.Серия                        КАК Серия,
		|	СУММА(ЗаказыНаВнутреннееПотребление.КОформлению
		|		* (&ДопустимоеОтклонениеОтгрузкиПриемкиМерныхТоваров / 100)) КАК ДопустимоеОтклонение
		|ПОМЕСТИТЬ ВТДопустимыеОтклоненияЗаказыНаВнутреннееПотребление
		|ИЗ
		|	ВТЗаказыНаВнутреннееПотребление КАК ЗаказыНаВнутреннееПотребление
		|	ВНУТРЕННЕЕ СОЕДИНЕНИЕ ДвиженияЗаказыНаВнутреннееПотреблениеИзменениеМерныеТовары КАК Изменения
		|		ПО ЗаказыНаВнутреннееПотребление.ЗаказНаВнутреннееПотребление = Изменения.ЗаказНаВнутреннееПотребление
		|			И ЗаказыНаВнутреннееПотребление.Номенклатура              = Изменения.Номенклатура
		|			И ЗаказыНаВнутреннееПотребление.Характеристика            = Изменения.Характеристика
		|			И ЗаказыНаВнутреннееПотребление.Склад                     = Изменения.Склад
		|			И ЗаказыНаВнутреннееПотребление.Серия                     = Изменения.Серия
		|ГДЕ
		|	ЗаказыНаВнутреннееПотребление.ВидДвижения = ЗНАЧЕНИЕ(ВидДвиженияНакопления.Приход)
		|СГРУППИРОВАТЬ ПО
		|	ЗаказыНаВнутреннееПотребление.ЗаказНаВнутреннееПотребление,
		|	ЗаказыНаВнутреннееПотребление.Номенклатура,
		|	ЗаказыНаВнутреннееПотребление.Характеристика,
		|	ЗаказыНаВнутреннееПотребление.Склад,
		|	ЗаказыНаВнутреннееПотребление.Серия
		|ИНДЕКСИРОВАТЬ ПО
		|	ЗаказНаВнутреннееПотребление,
		|	Номенклатура,
		|	Характеристика,
		|	Склад,
		|	Серия
		|;
		|////////////////////////////////////////////////////////////////////////////////
		|";
		
		//Остатки
		ТекстЗапроса = ТекстЗапроса + "
		|ВЫБРАТЬ
		|	ЗаказыНаВнутреннееПотребление.ЗаказНаВнутреннееПотребление КАК ЗаказНаВнутреннееПотребление,
		|	ЗаказыНаВнутреннееПотребление.Номенклатура                 КАК Номенклатура,
		|	ЗаказыНаВнутреннееПотребление.Характеристика               КАК Характеристика,
		|	ЗаказыНаВнутреннееПотребление.Склад                        КАК Склад,
		|	ЗаказыНаВнутреннееПотребление.Серия                        КАК Серия,
		|	СУММА(ВЫБОР КОГДА ЗаказыНаВнутреннееПотребление.ВидДвижения = ЗНАЧЕНИЕ(ВидДвиженияНакопления.Приход) ТОГДА
		|			ЗаказыНаВнутреннееПотребление.КОформлению
		|		ИНАЧЕ
		|			-ЗаказыНаВнутреннееПотребление.КОформлению
		|	КОНЕЦ)                                                     КАК КОформлениюОстаток
		|ПОМЕСТИТЬ ВТЗаказыНаВнутреннееПотреблениеОстатки
		|ИЗ
		|	ВТЗаказыНаВнутреннееПотребление КАК ЗаказыНаВнутреннееПотребление
		|СГРУППИРОВАТЬ ПО
		|	ЗаказыНаВнутреннееПотребление.ЗаказНаВнутреннееПотребление,
		|	ЗаказыНаВнутреннееПотребление.Номенклатура,
		|	ЗаказыНаВнутреннееПотребление.Характеристика,
		|	ЗаказыНаВнутреннееПотребление.Склад,
		|	ЗаказыНаВнутреннееПотребление.Серия
		|;
		|////////////////////////////////////////////////////////////////////////////////
		|";
		
		ТекстЗапроса = ТекстЗапроса + "
		|ВЫБРАТЬ РАЗЛИЧНЫЕ
		|	ЗаказыОстатки.ЗаказНаВнутреннееПотребление КАК ЗаказНаВнутреннееПотребление
		|ИЗ
		|	ВТЗаказыНаВнутреннееПотреблениеОстатки КАК ЗаказыОстатки
		|	ВНУТРЕННЕЕ СОЕДИНЕНИЕ
		|		ВТДопустимыеОтклоненияЗаказыНаВнутреннееПотребление КАК ДопустимыеОтклонения
		|		ПО
		|			ЗаказыОстатки.ЗаказНаВнутреннееПотребление = ДопустимыеОтклонения.ЗаказНаВнутреннееПотребление
		|			И ЗаказыОстатки.Номенклатура               = ДопустимыеОтклонения.Номенклатура
		|			И ЗаказыОстатки.Характеристика             = ДопустимыеОтклонения.Характеристика
		|			И ЗаказыОстатки.Склад                      = ДопустимыеОтклонения.Склад
		|			И ЗаказыОстатки.Серия                      = ДопустимыеОтклонения.Серия
		|ГДЕ
		|	ЗаказыОстатки.КОформлениюОстаток <= ДопустимыеОтклонения.ДопустимоеОтклонение
		|	И ЗаказыОстатки.КОформлениюОстаток >= -ДопустимыеОтклонения.ДопустимоеОтклонение
		|;
		|////////////////////////////////////////////////////////////////////////////////
		|";
		
		Запрос.Текст = ТекстЗапроса;
		
		ВыборкаЗаказ = Запрос.Выполнить().Выбрать();
		
		Пока ВыборкаЗаказ.Следующий() Цикл
			
			РегистрыСведений.ОчередьЗаказовККорректировкеСтрокМерныхТоваров.ДобавитьЗаказВОчередь(
				ВыборкаЗаказ.ЗаказНаВнутреннееПотребление);
			
		КонецЦикла;
		
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#КонецЕсли
