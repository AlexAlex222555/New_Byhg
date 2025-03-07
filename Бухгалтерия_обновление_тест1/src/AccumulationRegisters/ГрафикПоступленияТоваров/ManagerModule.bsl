#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ПрограммныйИнтерфейс

// Текст запроса оборотов товаров по варианту обеспечения "Резервировать к дате"
// в разрезе дат, номенклатуры, характеристики и склада.
//
// Параметры:
//  ИспользоватьКорректировку - Булево - признак необходимости скорректировать движения регистра перед получением оборотов.
//  Разделы - Массив - массив в который будет добавлена информация о временных таблицах, создаваемых при выполнении запроса.
//
// Возвращаемое значение:
//  Строка - Текст запроса временной таблицы оборотов товаров по варианту обеспечения "Резервировать к дате"
//           в разрезе дат, номенклатуры, характеристики и склада.
//
Функция ТекстЗапросаОборотов(ИспользоватьКорректировку, Разделы = Неопределено) Экспорт

	Шаблоны = Новый Массив();
	ШаблонПоступление =
		"ВЫБРАТЬ
		|	Таблица.Номенклатура        КАК Номенклатура,
		|	Таблица.Характеристика      КАК Характеристика,
		|	Таблица.Склад               КАК Склад,
		|
		|	ВЫБОР КОГДА Таблица.ДатаСобытия <= &НачалоТекущегоДня ТОГДА
		|				&НачалоТекущегоДня
		|			ИНАЧЕ
		|				Таблица.ДатаСобытия
		|		КОНЕЦ                         КАК Период,
		|
		|	Таблица.КоличествоИзЗаказов       КАК Количество
		|ИЗ
		|	РегистрНакопления.ГрафикПоступленияТоваров КАК Таблица
		|		ВНУТРЕННЕЕ СОЕДИНЕНИЕ ВтТовары КАК Отбор
		|		ПО Таблица.Номенклатура   = Отбор.Номенклатура
		|		 И Таблица.Характеристика = Отбор.Характеристика
		|		 И Таблица.Склад          = Отбор.Склад
		|ГДЕ
		|	Таблица.Активность
		|	И Таблица.КоличествоИзЗаказов <> 0";

	ШаблонОтгрузка =
		"ВЫБРАТЬ
		|	Таблица.Номенклатура       КАК Номенклатура,
		|	Таблица.Характеристика     КАК Характеристика,
		|	Таблица.Склад              КАК Склад,
		|
		|	ВЫБОР КОГДА Таблица.ДатаОтгрузки <= &НачалоТекущегоДня ТОГДА
		|				&НачалоТекущегоДня
		|			ИНАЧЕ
		|				Таблица.ДатаОтгрузки
		|		КОНЕЦ                           КАК Период,
		|
		|	-Таблица.КоличествоИзЗаказовОстаток КАК Количество
		|ИЗ
		|	РегистрНакопления.ГрафикОтгрузкиТоваров.Остатки(,
		|		(Номенклатура, Характеристика, Склад) В(
		|			ВЫБРАТЬ
		|				Отбор.Номенклатура   КАК Номенклатура,
		|				Отбор.Характеристика КАК Характеристика,
		|				Отбор.Склад          КАК Склад
		|			ИЗ
		|				ВтТовары КАК Отбор)) КАК Таблица";

	ШаблонКорректировка =
		"ВЫБРАТЬ
		|	Таблица.Номенклатура          КАК Номенклатура,
		|	Таблица.Характеристика        КАК Характеристика,
		|	Таблица.Склад                 КАК Склад,
		|
		|	ВЫБОР КОГДА Таблица.ДатаСобытия <= &НачалоТекущегоДня ТОГДА
		|				&НачалоТекущегоДня
		|			ИНАЧЕ
		|				Таблица.ДатаСобытия
		|		КОНЕЦ                          КАК Период,
		|
		|	Таблица.КоличествоИзЗаказов        КАК Количество
		|ИЗ
		|	ВтГрафикПоступленияТоваровКорректировка КАК Таблица
		|ГДЕ
		|	Таблица.КоличествоИзЗаказов <> 0";

	ТекстЗапроса =
		"ВЫБРАТЬ
		|	Набор.Номенклатура             КАК Номенклатура,
		|	Набор.Характеристика           КАК Характеристика,
		|	Набор.Склад                    КАК Склад,
		|
		|	Набор.Период                   КАК Период,
		|	СУММА(Набор.Количество)        КАК Количество
		|
		|ПОМЕСТИТЬ ВтОборотыГрафика
		|ИЗ
		|	ОбъединениеШаблонов КАК Набор
		|
		|СГРУППИРОВАТЬ ПО
		|	Набор.Номенклатура, Набор.Характеристика, Набор.Склад,
		|	Набор.Период
		|ИМЕЮЩИЕ
		|	СУММА(Набор.Количество) <> 0
		|ИНДЕКСИРОВАТЬ ПО
		|	Номенклатура, Характеристика, Склад,
		|	Период
		|;
		|
		|///////////////////////////////////////////////////
		|";

	Шаблоны.Добавить(ШаблонПоступление);
	Шаблоны.Добавить(ШаблонОтгрузка);

	Если ИспользоватьКорректировку Тогда
		Шаблоны.Добавить(ШаблонКорректировка);
	КонецЕсли;

	ОбъединениеШаблонов = ОбъединитьТекстыЗапроса(Шаблоны);
	ТекстЗапроса = СтрЗаменить(ТекстЗапроса, "ОбъединениеШаблонов", ОбъединениеШаблонов);

	Если Разделы <> Неопределено Тогда
		Разделы.Добавить("ТаблицаОборотыГрафика");
	КонецЕсли;

	Возврат ТекстЗапроса;

КонецФункции

// Текст запроса оборотов товаров по варианту обеспечения "Обособленно"
// в разрезе назначений, дат, номенклатуры, характеристики и склада.
//
// Параметры:
//  ИспользоватьКорректировку - Булево - признак необходимости скорректировать движения регистра перед получением оборотов.
//  Разделы                   - Массив - массив в который будет добавлена информация о временных таблицах, создаваемых
//                                       при выполнении запроса.
//  УчитыватьГрафикОтгрузки   - Булево - необходимость при вычислении остатков учитывать, запланированные отгрузки со склада.
//
// Возвращаемое значение:
//  Строка - Текст запроса временной таблицы оборотов товаров по варианту обеспечения "Обособленно"
//           в разрезе назначений, дат, номенклатуры, характеристики и склада.
//
Функция ТекстЗапросаОборотовОбособленных(ИспользоватьКорректировку, Разделы, УчитыватьГрафикОтгрузки)

	Шаблоны = Новый Массив();
	ШаблонПоступление =
		"ВЫБРАТЬ
		|	Таблица.Номенклатура        КАК Номенклатура,
		|	Таблица.Характеристика      КАК Характеристика,
		|	Таблица.Склад               КАК Склад,
		|	Таблица.Назначение          КАК Назначение,
		|
		|	ВЫБОР КОГДА Таблица.ДатаСобытия <= &НачалоТекущегоДня ТОГДА
		|				&НачалоТекущегоДня
		|			ИНАЧЕ
		|				Таблица.ДатаСобытия
		|		КОНЕЦ                         КАК Период,
		|
		|	Таблица.КоличествоПодЗаказ        КАК Количество
		|ИЗ
		|	РегистрНакопления.ГрафикПоступленияТоваров КАК Таблица
		|		ВНУТРЕННЕЕ СОЕДИНЕНИЕ ВтТоварыОбособленные КАК Отбор
		|		ПО Таблица.Номенклатура   = Отбор.Номенклатура
		|		 И Таблица.Характеристика = Отбор.Характеристика
		|		 И Таблица.Склад          = Отбор.Склад
		|		 И Таблица.Назначение     = Отбор.Назначение
		|ГДЕ
		|	Таблица.Активность
		|	И Таблица.КоличествоПодЗаказ <> 0";

	ШаблонОтгрузка =
		"ВЫБРАТЬ
		|	Таблица.Номенклатура        КАК Номенклатура,
		|	Таблица.Характеристика      КАК Характеристика,
		|	Таблица.Склад               КАК Склад,
		|	Таблица.Назначение          КАК Назначение,
		|
		|	ВЫБОР КОГДА Таблица.ДатаОтгрузки <= &НачалоТекущегоДня ТОГДА
		|				&НачалоТекущегоДня
		|			ИНАЧЕ
		|				Таблица.ДатаОтгрузки
		|		КОНЕЦ                         КАК Период,
		|
		|	-Таблица.КоличествоПодЗаказ       КАК Количество
		|ИЗ
		|	РегистрНакопления.ГрафикОтгрузкиТоваров КАК Таблица
		|		ВНУТРЕННЕЕ СОЕДИНЕНИЕ ВтТоварыОбособленные КАК Отбор
		|		ПО Таблица.Номенклатура   = Отбор.Номенклатура
		|		 И Таблица.Характеристика = Отбор.Характеристика
		|		 И Таблица.Склад          = Отбор.Склад
		|		 И Таблица.Назначение     = Отбор.Назначение
		|ГДЕ
		|	Таблица.Активность
		|	И Таблица.КоличествоПодЗаказ <> 0";

	ШаблонКорректировка =
		"ВЫБРАТЬ
		|	Таблица.Номенклатура          КАК Номенклатура,
		|	Таблица.Характеристика        КАК Характеристика,
		|	Таблица.Склад                 КАК Склад,
		|	Таблица.Назначение            КАК Назначение,
		|
		|	ВЫБОР КОГДА Таблица.ДатаСобытия <= &НачалоТекущегоДня ТОГДА
		|				&НачалоТекущегоДня
		|			ИНАЧЕ
		|				Таблица.ДатаСобытия
		|		КОНЕЦ                          КАК Период,
		|
		|	Таблица.КоличествоПодЗаказ         КАК Количество
		|ИЗ
		|	ВтГрафикПоступленияТоваровКорректировка КАК Таблица
		|ГДЕ
		|	Таблица.КоличествоПодЗаказ <> 0";

	ТекстЗапроса =
		"ВЫБРАТЬ
		|	Набор.Номенклатура             КАК Номенклатура,
		|	Набор.Характеристика           КАК Характеристика,
		|	Набор.Склад                    КАК Склад,
		|	Набор.Назначение               КАК Назначение,
		|
		|	Набор.Период                   КАК Период,
		|	СУММА(Набор.Количество)        КАК Количество
		|
		|ПОМЕСТИТЬ ВтОборотыГрафикаОбособленные
		|ИЗ
		|	ОбъединениеШаблонов КАК Набор
		|
		|СГРУППИРОВАТЬ ПО
		|	Набор.Номенклатура, Набор.Характеристика, Набор.Склад, Набор.Назначение,
		|	Набор.Период
		|ИМЕЮЩИЕ
		|	СУММА(Набор.Количество) <> 0
		|ИНДЕКСИРОВАТЬ ПО
		|	Номенклатура, Характеристика, Склад, Назначение,
		|	Период
		|;
		|
		|///////////////////////////////////////////////////
		|";

	Шаблоны.Добавить(ШаблонПоступление);

	Если ИспользоватьКорректировку Тогда
		Шаблоны.Добавить(ШаблонКорректировка);
	КонецЕсли;

	Если УчитыватьГрафикОтгрузки Тогда
		Шаблоны.Добавить(ШаблонОтгрузка);
	КонецЕсли;

	ОбъединениеШаблонов = ОбъединитьТекстыЗапроса(Шаблоны);
	ТекстЗапроса = СтрЗаменить(ТекстЗапроса, "ОбъединениеШаблонов", ОбъединениеШаблонов);

	Если Разделы <> Неопределено Тогда
		Разделы.Добавить("ТаблицаОборотыГрафикаОбособленные");
	КонецЕсли;

	Возврат ТекстЗапроса;

КонецФункции

// Текст запроса остатков товаров по варианту обеспечения "Резервировать к дате".
// в разрезе номенклатуры, характеристики и склада.
//
// Параметры:
//  ИспользоватьКорректировку - Булево - признак необходимости скорректировать движения регистра перед получением остатков.
//  Разделы - Массив - массив в который будет добавлена информация о временных таблицах создаваемых при выполнении запроса.
//
// Возвращаемое значение:
//  Строка - Текст запроса временной таблицы остатков товаров по варианту обеспечения "Резервировать к дате"
//           в разрезе номенклатуры, характеристики и склада.
//
Функция ТекстЗапросаОстатков(ИспользоватьКорректировку, Разделы = Неопределено) Экспорт

	Шаблоны = Новый Массив();
	ШаблонПоступление =
		"ВЫБРАТЬ
		|	Таблица.Номенклатура   КАК Номенклатура,
		|	Таблица.Характеристика КАК Характеристика,
		|	Таблица.Склад          КАК Склад,
		|
		|	Таблица.КоличествоИзЗаказовОстаток КАК Количество
		|ИЗ
		|	РегистрНакопления.ГрафикПоступленияТоваров.Остатки(,
		|		(Номенклатура, Характеристика, Склад) В(
		|			ВЫБРАТЬ
		|				Отбор.Номенклатура    КАК Номенклатура,
		|				Отбор.Характеристика  КАК Характеристика,
		|				Отбор.Склад           КАК Склад
		|			ИЗ
		|				ВтТовары КАК Отбор)) КАК Таблица";

	ШаблонОтгрузка =
		"ВЫБРАТЬ
		|	Таблица.Номенклатура   КАК Номенклатура,
		|	Таблица.Характеристика КАК Характеристика,
		|	Таблица.Склад          КАК Склад,
		|
		|	-Таблица.КоличествоИзЗаказовОстаток КАК Количество
		|ИЗ
		|	РегистрНакопления.ГрафикОтгрузкиТоваров.Остатки(,
		|		(Номенклатура, Характеристика, Склад) В(
		|			ВЫБРАТЬ
		|				Отбор.Номенклатура    КАК Номенклатура,
		|				Отбор.Характеристика  КАК Характеристика,
		|				Отбор.Склад           КАК Склад
		|			ИЗ
		|				ВтТовары КАК Отбор)) КАК Таблица";

	ШаблонКорректировка =
		"ВЫБРАТЬ
		|	Таблица.Номенклатура   КАК Номенклатура,
		|	Таблица.Характеристика КАК Характеристика,
		|	Таблица.Склад          КАК Склад,
		|
		|	Таблица.КоличествоИзЗаказов КАК Количество
		|ИЗ
		|	ВтГрафикПоступленияТоваровКорректировка КАК Таблица
		|ГДЕ
		|	Таблица.КоличествоИзЗаказов <> 0";

	ТекстЗапроса =
		"ВЫБРАТЬ
		|	НаборДанных.Номенклатура      КАК Номенклатура,
		|	НаборДанных.Характеристика    КАК Характеристика,
		|	НаборДанных.Склад             КАК Склад,
		|	СУММА(НаборДанных.Количество) КАК Количество
		|ПОМЕСТИТЬ ВтОстаткиГрафика
		|ИЗ
		|	ОбъединениеШаблонов КАК НаборДанных
		|
		|СГРУППИРОВАТЬ ПО
		|	НаборДанных.Номенклатура, НаборДанных.Характеристика, НаборДанных.Склад
		|ИМЕЮЩИЕ
		|	СУММА(НаборДанных.Количество) <> 0
		|ИНДЕКСИРОВАТЬ ПО
		|	Номенклатура, Характеристика, Склад
		|;
		|
		|///////////////////////////////////////////////////
		|";

	Шаблоны.Добавить(ШаблонПоступление);
	Шаблоны.Добавить(ШаблонОтгрузка);

	Если ИспользоватьКорректировку Тогда
		Шаблоны.Добавить(ШаблонКорректировка);
	КонецЕсли;

	ОбъединениеШаблонов = ОбъединитьТекстыЗапроса(Шаблоны);
	ТекстЗапроса = СтрЗаменить(ТекстЗапроса, "ОбъединениеШаблонов", ОбъединениеШаблонов);


	Если Разделы <> Неопределено Тогда
		Разделы.Добавить("ТаблицаОстаткиГрафика");
	КонецЕсли;

	Возврат ТекстЗапроса;

КонецФункции

// Текст запроса остатков товаров по варианту обеспечения "Обособленно".
// в разрезе назначений, номенклатуры, характеристики и склада.
//
// Параметры:
//  ИспользоватьКорректировку - Булево - признак необходимости скорректировать движения регистра перед получением остатков.
//  Разделы                   - Массив - массив в который будет добавлена информация о временных таблицах создаваемых
//                                       при выполнении запроса.
//  УчитыватьГрафикОтгрузки   - Булево - необходимость при вычислении остатков учитывать, запланированные отгрузки со склада.
//
// Возвращаемое значение:
//  Строка - Текст запроса временной таблицы остатков товаров по варианту обеспечения "Обособленно"
//           в разрезе назначений, номенклатуры, характеристики и склада.
//
Функция ТекстЗапросаОстатковОбособленных(ИспользоватьКорректировку, Разделы, УчитыватьГрафикОтгрузки)

	Шаблоны = Новый Массив();
	ШаблонПоступление =
		"ВЫБРАТЬ
		|	Таблица.Номенклатура   КАК Номенклатура,
		|	Таблица.Характеристика КАК Характеристика,
		|	Таблица.Склад          КАК Склад,
		|	Таблица.Назначение     КАК Назначение,
		|
		|	Таблица.КоличествоПодЗаказОстаток КАК Количество
		|ИЗ
		|	РегистрНакопления.ГрафикПоступленияТоваров.Остатки(,
		|		(Номенклатура, Характеристика, Склад, Назначение) В(
		|			ВЫБРАТЬ
		|				Отбор.Номенклатура    КАК Номенклатура,
		|				Отбор.Характеристика  КАК Характеристика,
		|				Отбор.Склад           КАК Склад,
		|				Отбор.Назначение      КАК Назначение
		|			ИЗ
		|				ВтТоварыОбособленные КАК Отбор)) КАК Таблица";

	ШаблонОтгрузка =
		"ВЫБРАТЬ
		|	Таблица.Номенклатура   КАК Номенклатура,
		|	Таблица.Характеристика КАК Характеристика,
		|	Таблица.Склад          КАК Склад,
		|	Таблица.Назначение     КАК Назначение,
		|
		|	-Таблица.КоличествоПодЗаказОстаток КАК Количество
		|ИЗ
		|	РегистрНакопления.ГрафикОтгрузкиТоваров.Остатки(,
		|		(Номенклатура, Характеристика, Склад, Назначение) В(
		|			ВЫБРАТЬ
		|				Отбор.Номенклатура    КАК Номенклатура,
		|				Отбор.Характеристика  КАК Характеристика,
		|				Отбор.Склад           КАК Склад,
		|				Отбор.Назначение      КАК Назначение
		|			ИЗ
		|				ВтТоварыОбособленные КАК Отбор)) КАК Таблица";

	ШаблонКорректировка =
		"ВЫБРАТЬ
		|	Таблица.Номенклатура   КАК Номенклатура,
		|	Таблица.Характеристика КАК Характеристика,
		|	Таблица.Склад          КАК Склад,
		|	Таблица.Назначение     КАК Назначение,
		|
		|	Таблица.КоличествоПодЗаказ КАК Количество
		|ИЗ
		|	ВтГрафикПоступленияТоваровКорректировка КАК Таблица
		|ГДЕ
		|	Таблица.КоличествоПодЗаказ <> 0";

	ТекстЗапроса =
		"ВЫБРАТЬ
		|	НаборДанных.Номенклатура      КАК Номенклатура,
		|	НаборДанных.Характеристика    КАК Характеристика,
		|	НаборДанных.Склад             КАК Склад,
		|	НаборДанных.Назначение        КАК Назначение,
		|	СУММА(НаборДанных.Количество) КАК Количество
		|ПОМЕСТИТЬ ВтОстаткиГрафикаОбособленные
		|ИЗ
		|	ОбъединениеШаблонов КАК НаборДанных
		|
		|СГРУППИРОВАТЬ ПО
		|	НаборДанных.Номенклатура, НаборДанных.Характеристика, НаборДанных.Склад, НаборДанных.Назначение
		|ИМЕЮЩИЕ
		|	СУММА(НаборДанных.Количество) <> 0
		|ИНДЕКСИРОВАТЬ ПО
		|	Номенклатура, Характеристика, Склад, Назначение
		|;
		|
		|///////////////////////////////////////////////////
		|";

	Шаблоны.Добавить(ШаблонПоступление);

	Если ИспользоватьКорректировку Тогда
		Шаблоны.Добавить(ШаблонКорректировка);
	КонецЕсли;

	Если УчитыватьГрафикОтгрузки Тогда
		Шаблоны.Добавить(ШаблонОтгрузка);
	КонецЕсли;

	ОбъединениеШаблонов = ОбъединитьТекстыЗапроса(Шаблоны);
	ТекстЗапроса = СтрЗаменить(ТекстЗапроса, "ОбъединениеШаблонов", ОбъединениеШаблонов);

	Если Разделы <> Неопределено Тогда
		Разделы.Добавить("ТаблицаОстаткиГрафикаОбособленные");
	КонецЕсли;

	Возврат ТекстЗапроса;

КонецФункции

// Текст запроса оборотов товаров по датам и итогового остатка с учетом свободного остатка товара на складе
// в разрезе номенклатуры, характеристики и склада.
//
// Параметры:
//  ИспользоватьКорректировку - Булево - признак необходимости скорректировать движения регистров перед получением остатков.
//  Разделы - Массив - массив в который будет добавлена информация о временных таблицах создаваемых при выполнении запроса.
//
// Возвращаемое значение:
//  Строка - Текст запроса временной таблицы оборотов товаров по датам и итогового остатка товара.
//           в разрезе номенклатуры, характеристики и склада.
//
Функция ТекстЗапросаОстатковИОборотов(ИспользоватьКорректировку, Разделы = Неопределено) Экспорт

	ТекстЗапроса =
		РегистрыНакопления.СвободныеОстатки.ТекстЗапросаОстатков(ИспользоватьКорректировку, Разделы)
		+ ТекстЗапросаОборотов(ИспользоватьКорректировку, Разделы)
		+ ТекстЗапросаОстатков(ИспользоватьКорректировку, Разделы)
		+ "ВЫБРАТЬ
		|	Таблица.Номенклатура   КАК Номенклатура,
		|	Таблица.Характеристика КАК Характеристика,
		|	Таблица.Склад          КАК Склад,
		|
		|	ЕСТЬNULL(ОборотыГрафика.Период, ДАТАВРЕМЯ(1,1,1)) КАК Период,
		|	ЕСТЬNULL(ОборотыГрафика.Количество, 0)            КАК Оборот,
		|
		|	ЕСТЬNULL(ОстаткиГрафика.Количество, 0) + ЕСТЬNULL(ОстаткиСклада.Количество,0) КАК Остаток
		|ИЗ
		|	ВтТовары КАК Таблица
		|		ЛЕВОЕ СОЕДИНЕНИЕ ВтОстаткиСклада КАК ОстаткиСклада
		|		ПО Таблица.Номенклатура   = ОстаткиСклада.Номенклатура
		|		 И Таблица.Характеристика = ОстаткиСклада.Характеристика
		|		 И Таблица.Склад          = ОстаткиСклада.Склад
		|		ЛЕВОЕ СОЕДИНЕНИЕ ВтОстаткиГрафика КАК ОстаткиГрафика
		|		ПО Таблица.Номенклатура   = ОстаткиГрафика.Номенклатура
		|		 И Таблица.Характеристика = ОстаткиГрафика.Характеристика
		|		 И Таблица.Склад          = ОстаткиГрафика.Склад
		|		ЛЕВОЕ СОЕДИНЕНИЕ ВтОборотыГрафика КАК ОборотыГрафика
		|		ПО Таблица.Номенклатура   = ОборотыГрафика.Номенклатура
		|		 И Таблица.Характеристика = ОборотыГрафика.Характеристика
		|		 И Таблица.Склад          = ОборотыГрафика.Склад
		|УПОРЯДОЧИТЬ ПО
		|	Номенклатура, Характеристика, Склад,
		|	Период УБЫВ
		|;
		|
		|/////////////////////////////////////////////////////
		|";

	Если Разделы <> Неопределено Тогда
		Разделы.Добавить("ТаблицаОстаткиИОборотыГрафика");
	КонецЕсли;

	Возврат ТекстЗапроса;

КонецФункции

// Текст запроса оборотов обособленных товаров по датам и итогового остатка с учетом обособленного остатка товара на складе
// в разрезе назначений, номенклатуры, характеристики и склада.
//
// Параметры:
//  ИспользоватьКорректировку - Булево - признак необходимости скорректировать движения регистров перед получением остатков.
//  Разделы - Массив - массив в который будет добавлена информация о временных таблицах создаваемых при выполнении запроса.
//
// Возвращаемое значение:
//  Строка - Текст запроса временной таблицы оборотов обособленных товаров по датам и итогового обособленного остатка товара.
//           в разрезе назначений, номенклатуры, характеристики и склада.
//
Функция ТекстЗапросаОстатковИОборотовОбособленных(ИспользоватьКорректировку, Разделы, УчитыватьГрафикОтгрузки) Экспорт

	ТекстЗапроса =
		РегистрыНакопления.ОбеспечениеЗаказов.ТекстЗапросаОстатков(ИспользоватьКорректировку, Разделы)
		+ ТекстЗапросаОборотовОбособленных(ИспользоватьКорректировку, Разделы, УчитыватьГрафикОтгрузки)
		+ ТекстЗапросаОстатковОбособленных(ИспользоватьКорректировку, Разделы, УчитыватьГрафикОтгрузки)
		+ "ВЫБРАТЬ
		|	Таблица.Номенклатура   КАК Номенклатура,
		|	Таблица.Характеристика КАК Характеристика,
		|	Таблица.Склад          КАК Склад,
		|	Таблица.Назначение     КАК Назначение,
		|
		|	ЕСТЬNULL(ОборотыГрафика.Период, ДАТАВРЕМЯ(1,1,1)) КАК Период,
		|	ЕСТЬNULL(ОборотыГрафика.Количество, 0)            КАК Оборот,
		|
		|	ЕСТЬNULL(ОстаткиГрафика.Количество, 0) + ЕСТЬNULL(ОстаткиСклада.Количество, 0) КАК Остаток
		|ИЗ
		|	ВтТоварыОбособленные КАК Таблица
		|		ЛЕВОЕ СОЕДИНЕНИЕ ВтОбеспечениеЗаказов КАК ОстаткиСклада
		|		ПО Таблица.Номенклатура   = ОстаткиСклада.Номенклатура
		|		 И Таблица.Характеристика = ОстаткиСклада.Характеристика
		|		 И Таблица.Склад          = ОстаткиСклада.Склад
		|		 И Таблица.Назначение     = ОстаткиСклада.Назначение
		|		ЛЕВОЕ СОЕДИНЕНИЕ ВтОстаткиГрафикаОбособленные КАК ОстаткиГрафика
		|		ПО Таблица.Номенклатура   = ОстаткиГрафика.Номенклатура
		|		 И Таблица.Характеристика = ОстаткиГрафика.Характеристика
		|		 И Таблица.Склад          = ОстаткиГрафика.Склад
		|		 И Таблица.Назначение     = ОстаткиГрафика.Назначение
		|		ЛЕВОЕ СОЕДИНЕНИЕ ВтОборотыГрафикаОбособленные КАК ОборотыГрафика
		|		ПО Таблица.Номенклатура   = ОборотыГрафика.Номенклатура
		|		 И Таблица.Характеристика = ОборотыГрафика.Характеристика
		|		 И Таблица.Склад          = ОборотыГрафика.Склад
		|		 И Таблица.Назначение     = ОборотыГрафика.Назначение
		|УПОРЯДОЧИТЬ ПО
		|	Номенклатура, Характеристика, Склад, Назначение,
		|	Период УБЫВ
		|;
		|
		|/////////////////////////////////////////////////////
		|";

	Если Разделы <> Неопределено Тогда
		Разделы.Добавить("ТаблицаОстаткиИОборотыГрафикаОбособленные");
	КонецЕсли;
	
	Возврат ТекстЗапроса;

КонецФункции

// Предназначена для получения таблицы доступных остатков по данным об остатках и оборотах номенклатуры из выборки.
//
// Параметры:
//  Выборка - ВыборкаДанных      - Выборка оборотов номенклатуры в порядке убывания периода,
//                                 каждая запись содержит также конченый остаток номенклатуры.
//  ТолькоПоложительные - Булево - Если истина, то в результат попадут только положительные остатки
//                                 (для заполнения обеспечения в заказах).
//  Обособление - Строка         - Если "Товар", то выборка содержит данные обособленных товаров, если "Работа",
//                                 то выборка содержит данные работ.
// 
// Возвращаемое значение:
//   ТаблицаЗначений - Таблица доступных остатков с колонками:
//     * Номенклатура    - СправочникСсылка.Номенклатура               - номенклатура из выборки данных.
//     * Характеристика  - СправочникСсылка.ХарактеристикиНоменклатуры - характеристика из выборки данных.
//     * Склад           - СправочникСсылка.Склады                     - склад из выборки данных, только при использовании
//                                                                       со значением параметра Обособление равным Неопределено
//                                                                       или "Товар".
//     * Назначение      - СправочникСсылка.Назначения                 - назначение из выборки данных, только при использовании
//                                                                       со значением параметра Обособление равным "Товар".
//     * Подразделение   - СправочникСсылка.СтруктураПредприятия       - подразделение из выборки данных, только при использовании
//                                                                       со значением параметра Обособление равным "Работа".
//     * ДатаДоступности - Дата                                        - дата, для которой рассчитано доступное
//                                                                       количество товаров/работ.
//     * Количество      - Число                                       - рассчитаное доступное количество товаров/работ.
//
Функция ТаблицаДоступныеОстатки(Выборка, ТолькоПоложительные = Ложь, Обособление = Неопределено) Экспорт

	ДоступныеОстатки = Новый ТаблицаЗначений();
	ДоступныеОстатки.Колонки.Добавить("Номенклатура", Новый ОписаниеТипов("СправочникСсылка.Номенклатура"));
	ДоступныеОстатки.Колонки.Добавить("Характеристика", Новый ОписаниеТипов("СправочникСсылка.ХарактеристикиНоменклатуры"));
	ДоступныеОстатки.Колонки.Добавить("ДатаДоступности", ОбщегоНазначенияУТ.ПолучитьОписаниеТиповДаты(ЧастиДаты.Дата));
	ДоступныеОстатки.Колонки.Добавить("Количество", ОбщегоНазначенияУТ.ПолучитьОписаниеТиповЧисла(15, 3));

	Если Обособление = Неопределено Тогда

		ДоступныеОстатки.Колонки.Добавить("Склад", Новый ОписаниеТипов("СправочникСсылка.Склады"));
		КлючСтроки = ОбеспечениеКлиентСервер.КлючНоменклатураХарактеристикаСклад();

	ИначеЕсли Обособление = "Товар" Тогда

		ДоступныеОстатки.Колонки.Добавить("Склад", Новый ОписаниеТипов("СправочникСсылка.Склады"));
		ДоступныеОстатки.Колонки.Добавить("Назначение", Новый ОписаниеТипов("СправочникСсылка.Назначения"));
		КлючСтроки = ОбеспечениеКлиентСервер.КлючНоменклатураХарактеристикаСкладНазначение();

	ИначеЕсли Обособление = "Работа" Тогда

		ДоступныеОстатки.Колонки.Добавить("Подразделение", Новый ОписаниеТипов("СправочникСсылка.СтруктураПредприятия"));
		ДоступныеОстатки.Колонки.Добавить("Назначение", Новый ОписаниеТипов("СправочникСсылка.Назначения"));
		КлючСтроки = ОбеспечениеКлиентСервер.КлючНоменклатураХарактеристикаПодразделениеНазначение();

	КонецЕсли;

	ЕстьЗаписи = Выборка.Следующий();
	Пока ЕстьЗаписи Цикл

		ЗаполнитьЗначенияСвойств(КлючСтроки, Выборка);

		НарастающийИтог          = Выборка.Остаток;
		МинимальноеЗначение      = НарастающийИтог;

		ИзмениласьЗапись         = Ложь;

		// Цикл по сочетанию номенклатура\характеристика\склад.
		Пока Не ИзмениласьЗапись Цикл

			НарастающийИтог = НарастающийИтог - Выборка.Оборот;

			Если МинимальноеЗначение > НарастающийИтог И (Не ТолькоПоложительные Или МинимальноеЗначение > 0) Тогда

				СтрокаТаблицы = ДоступныеОстатки.Добавить();
				ЗаполнитьЗначенияСвойств(СтрокаТаблицы, Выборка);

				СтрокаТаблицы.ДатаДоступности = Выборка.Период; //доступно на дату.
				СтрокаТаблицы.Количество = МинимальноеЗначение;
				МинимальноеЗначение = НарастающийИтог;

			КонецЕсли;

			// Переход к следующей записи.
			ЕстьЗаписи = Выборка.Следующий();

			ИзмениласьЗапись = Не ЕстьЗаписи Или ОбеспечениеКлиентСервер.ИзменилсяКлюч(КлючСтроки, Выборка);

		КонецЦикла;

		Если Не ТолькоПоложительные Или МинимальноеЗначение > 0 Тогда

			СтрокаТаблицы = ДоступныеОстатки.Добавить();
			ЗаполнитьЗначенияСвойств(СтрокаТаблицы, КлючСтроки);

			СтрокаТаблицы.ДатаДоступности = '00010101'; //доступно сейчас.
			СтрокаТаблицы.Количество = МинимальноеЗначение;

		КонецЕсли;

	КонецЦикла;

	Возврат ДоступныеОстатки;

КонецФункции

#Область ДляВызоваИзДругихПодсистем

// СтандартныеПодсистемы.УправлениеДоступом

// См. УправлениеДоступомПереопределяемый.ПриЗаполненииСписковСОграничениемДоступа.
Процедура ПриЗаполненииОграниченияДоступа(Ограничение) Экспорт

	Ограничение.Текст =
	"РазрешитьЧтениеИзменение
	|ГДЕ
	|	ЗначениеРазрешено(Склад)";
	
	Ограничение.ТекстДляВнешнихПользователей = Ограничение.Текст;

КонецПроцедуры

// Конец СтандартныеПодсистемы.УправлениеДоступом

#КонецОбласти

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

Функция ОбъединитьТекстыЗапроса(Тексты)

	Результат = "";
	ВГраница = Тексты.Количество() - 1;
	Для Индекс = 0 По ВГраница Цикл
		Результат = Результат + Тексты[Индекс];
		Если Индекс < ВГраница Тогда
			Результат = Результат + "
			|
			|ОБЪЕДИНИТЬ ВСЕ
			|
			|";
		КонецЕсли;
	КонецЦикла;
	
	Возврат "(" + Результат + ")";

КонецФункции

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
	Обработчик.Версия = "3.5.4.400";
	Обработчик.РежимВыполнения = "Отложенно";
	Обработчик.Процедура = "РегистрыНакопления.ГрафикПоступленияТоваров.ОбработатьДанныеДляПереходаНаНовуюВерсию";
	Обработчик.Идентификатор = Новый УникальныйИдентификатор("027eae00-9900-472f-95a0-2ed21a4e1d51");
	Обработчик.ПроцедураЗаполненияДанныхОбновления = "РегистрыНакопления.ГрафикПоступленияТоваров.ЗарегистрироватьДанныеКОбработкеДляПереходаНаНовуюВерсию";
	Обработчик.ПроцедураПроверки = "ОбновлениеИнформационнойБазы.ДанныеОбновленыНаНовуюВерсиюПрограммы";
	Обработчик.ЧитаемыеОбъекты = "Документ.ВозвратТоваровОтКлиента,"
		+ "Документ.ЗаказПоставщику,"
		+ "Документ.ПриходныйОрдерНаТовары,"
		+ "Документ.РегистраторГрафикаДвиженияТоваров,"
		+ "РегистрНакопления.ДвижениеТоваров,"
	//++ НЕ УТ
		+ "Документ.ВыпускПродукции,"
		+ "Документ.ЗаказПереработчику,"
		+ "Документ.ПоступлениеОтПереработчика,"
	//-- НЕ УТ
		+ "РегистрНакопления.ГрафикПоступленияТоваров"
	;
	Обработчик.ИзменяемыеОбъекты = "РегистрНакопления.ГрафикПоступленияТоваров";
	Обработчик.БлокируемыеОбъекты = "";
	Обработчик.Комментарий = НСтр("ru='Обновляет движения документов по регистру накопления ""График поступления товаров"".
    |До завершения обработчика работа с документами ""Выпуск продукции"", ""Поступление от переработчика"", ""Заказ поставщику"", ""Заказ переработчику"", ""Возврат товаров от клиента"", ""Приходный ордер на товары"" и ""Поступление сырья от давальца"" не рекомендуется, т.к. информация в регистре некорректна.'
    |;uk='Оновлює рухи документів з регістру накопичення ""Графік надходження товарів"".
    |До завершення обробника робота з документами ""Випуск продукції"", ""Надходження від переробника"", ""Замовлення постачальнику"", ""Замовлення переробнику"", ""Повернення товарів від клієнта"", ""Прибутковий ордер на товари"" та ""Надходження сировини від давальця"" не рекомендується, оскільки інформація у регістрі некоректна.'");
	Обработчик.ПриоритетыВыполнения = ОбновлениеИнформационнойБазы.ПриоритетыВыполненияОбработчика();
	
	НоваяСтрока = Обработчик.ПриоритетыВыполнения.Добавить();
	НоваяСтрока.Процедура = "Документы.ВозвратТоваровОтКлиента.ОбработатьДанныеДляПереходаНаНовуюВерсию";
	НоваяСтрока.Порядок = "После";

	НоваяСтрока = Обработчик.ПриоритетыВыполнения.Добавить();
	НоваяСтрока.Процедура = "Документы.ЗаказПоставщику.ОбработатьДанныеДляПереходаНаНовуюВерсию";
	НоваяСтрока.Порядок = "После";
	
	НоваяСтрока = Обработчик.ПриоритетыВыполнения.Добавить();
	НоваяСтрока.Процедура = "Документы.ПриходныйОрдерНаТовары.ОбработатьДанныеДляПереходаНаНовуюВерсию";
	НоваяСтрока.Порядок = "После";

	НоваяСтрока = Обработчик.ПриоритетыВыполнения.Добавить();
	НоваяСтрока.Процедура = "Справочники.СоглашенияСПоставщиками.ОбработатьДанныеДляПереходаНаНовуюВерсию2";
	НоваяСтрока.Порядок = "После";
	
	НоваяСтрока = Обработчик.ПриоритетыВыполнения.Добавить();
	НоваяСтрока.Процедура = "РегистрыСведений.ДоступныеОстаткиПланируемыхПоступлений.ОбработатьДанныеДляПереходаНаНовуюВерсию";
	НоваяСтрока.Порядок = "До";
	
	НоваяСтрока = Обработчик.ПриоритетыВыполнения.Добавить();
	НоваяСтрока.Процедура = "РегистрыНакопления.ДвижениеТоваров.ОбработатьДанныеДляПереходаНаНовуюВерсию";
	НоваяСтрока.Порядок = "После";
	
	//++ НЕ УТ
	НоваяСтрока = Обработчик.ПриоритетыВыполнения.Добавить();
	НоваяСтрока.Процедура = "Документы.ВыпускПродукции.ОбработатьДанныеДляПереходаНаНовуюВерсию";
	НоваяСтрока.Порядок = "После";
	
	НоваяСтрока = Обработчик.ПриоритетыВыполнения.Добавить();
	НоваяСтрока.Процедура = "Документы.ЗаказПереработчику.ОбработатьДанныеДляПереходаНаНовуюВерсию";
	НоваяСтрока.Порядок = "После";
	
	НоваяСтрока = Обработчик.ПриоритетыВыполнения.Добавить();
	НоваяСтрока.Процедура = "Документы.ПоступлениеОтПереработчика.ОбработатьДанныеДляПереходаНаНовуюВерсию";
	НоваяСтрока.Порядок = "После";
	//-- НЕ УТ

	
	НоваяСтрока = Обработчик.ПриоритетыВыполнения.Добавить();
	НоваяСтрока.Процедура = "Справочники.ДоговорыКонтрагентов.СоздатьРегистраторыГрафикаДвиженияТоваровПоДоговорам";
	НоваяСтрока.Порядок = "После";
	
КонецПроцедуры

Процедура ЗарегистрироватьДанныеКОбработкеДляПереходаНаНовуюВерсию(Параметры) Экспорт
	
	ПолноеИмяРегистра = "РегистрНакопления.ГрафикПоступленияТоваров";
	
	РегистрыСведений.ДоступныеОстаткиПланируемыхПоступлений.ЗарегистрироватьКОбработкеПриОбновленииИБ(ПолноеИмяРегистра, Параметры);
	
КонецПроцедуры

Процедура ОбработатьДанныеДляПереходаНаНовуюВерсию(Параметры) Экспорт
	
	ПолноеИмяРегистра = "РегистрНакопления.ГрафикПоступленияТоваров";
	ИмяРегистра = "ГрафикПоступленияТоваров";
	
	РегистрДвижениеТоваровОбновляется = ОбновлениеИнформационнойБазы.ЕстьДанныеДляОбработки(Неопределено, "РегистрНакопления.ДвижениеТоваров");
	Если РегистрДвижениеТоваровОбновляется Тогда
		// Обработка РН ГрафикПоступленияТоваров возможна только если завершена обработка РН ДвижениеТоваров.
		Параметры.ОбработкаЗавершена = Ложь;
		Возврат;
	КонецЕсли;
	
	МенеджерВременныхТаблиц = Новый МенеджерВременныхТаблиц();
	Результат = ОбновлениеИнформационнойБазы.СоздатьВременнуюТаблицуРегистраторовРегистраДляОбработки(Параметры.Очередь, Неопределено, ПолноеИмяРегистра, МенеджерВременныхТаблиц);
	
	Если НЕ Результат.ЕстьДанныеДляОбработки Тогда
		Параметры.ОбработкаЗавершена = Истина;
		Возврат;
	КонецЕсли;
	
	Если НЕ Результат.ЕстьЗаписиВоВременнойТаблице Тогда
		Параметры.ОбработкаЗавершена = Ложь;
		Возврат;
	КонецЕсли;
	
	ТекстЗапроса = 
	// 0. Получение таблицы документов, готовых к обработке.
	"ВЫБРАТЬ РАЗЛИЧНЫЕ
	|	СсылкиДляОбработки.Регистратор КАК Регистратор
	|ИЗ
	|	&ВТДляОбработкиСсылка КАК СсылкиДляОбработки";
	
	ТекстЗапроса = СтрЗаменить(ТекстЗапроса, "&ВТДляОбработкиСсылка", Результат.ИмяВременнойТаблицы);
	
	Запрос = Новый Запрос(ТекстЗапроса);
	Запрос.МенеджерВременныхТаблиц = МенеджерВременныхТаблиц;
	РезультатЗапроса = Запрос.ВыполнитьПакет();
	
	ДокументыДляРасчетаИтогаРегистра = РезультатЗапроса[0].Выбрать();
	
	Пока ДокументыДляРасчетаИтогаРегистра.Следующий() Цикл
		
		НачатьТранзакцию();
		
		Попытка
			
			// Блокировка читаемых и записываемых наборов.
			Блокировка = Новый БлокировкаДанных;
			
			ЭлементБлокировки = Блокировка.Добавить("РегистрНакопления.ГрафикПоступленияТоваров.НаборЗаписей");
			ЭлементБлокировки.УстановитьЗначение("Регистратор", ДокументыДляРасчетаИтогаРегистра.Регистратор);
			ЭлементБлокировки.Режим = РежимБлокировкиДанных.Исключительный;
			
			ЭлементБлокировки = Блокировка.Добавить("РегистрНакопления.ДвижениеТоваров");
			ЭлементБлокировки.УстановитьЗначение("Распоряжение", ДокументыДляРасчетаИтогаРегистра.Регистратор);
			ЭлементБлокировки.Режим = РежимБлокировкиДанных.Разделяемый;
			
			Блокировка.Заблокировать();
			
			// Перерасчет движений
			НаборЗаписей = РегистрыНакопления.ДвижениеТоваров.РассчитатьИтогиРегистраОстаткиТоваровПоГрафикуДляОбновленияИБ(ДокументыДляРасчетаИтогаРегистра.Регистратор);
			
			// Запись.
			Если ЕстьИзмененияВНаборе(ДокументыДляРасчетаИтогаРегистра, НаборЗаписей) Тогда
				ОбновлениеИнформационнойБазы.ЗаписатьДанные(НаборЗаписей);
			Иначе
				ОбновлениеИнформационнойБазы.ОтметитьВыполнениеОбработки(НаборЗаписей);
			КонецЕсли;
			
			
			ЗафиксироватьТранзакцию();
			
		Исключение
			ОтменитьТранзакцию();
			ТекстСообщения = НСтр("ru='Не удалось обработать документ: %Регистратор% по причине: %Причина%';uk='Не вдалося обробити документ: %Регистратор% по причині: %Причина%'");
			ТекстСообщения = СтрЗаменить(ТекстСообщения, "%Регистратор%", ДокументыДляРасчетаИтогаРегистра.Регистратор);
			ТекстСообщения = СтрЗаменить(ТекстСообщения, "%Причина%", ПодробноеПредставлениеОшибки(ИнформацияОбОшибке()));
			ЗаписьЖурналаРегистрации(ОбновлениеИнформационнойБазы.СобытиеЖурналаРегистрации(),
				УровеньЖурналаРегистрации.Предупреждение,
				ДокументыДляРасчетаИтогаРегистра.Регистратор.Метаданные(),
				ДокументыДляРасчетаИтогаРегистра.Регистратор,
				ТекстСообщения);
		КонецПопытки;
		
	КонецЦикла;
	
	Параметры.ОбработкаЗавершена = Не ОбновлениеИнформационнойБазы.ЕстьДанныеДляОбработки(Параметры.Очередь, ПолноеИмяРегистра);
	
КонецПроцедуры

Функция ЕстьИзмененияВНаборе(Выборка, НаборЗаписей)
	
	Таблица = НаборЗаписей.Выгрузить();
	Запрос = Новый Запрос();
	Запрос.Текст =
		"ВЫБРАТЬ
		|	Таблица.Номенклатура   КАК Номенклатура,
		|	Таблица.Характеристика КАК Характеристика,
		|	Таблица.Склад          КАК Склад,
		|	Таблица.ДатаСобытия    КАК ДатаСобытия,
		|	Таблица.Назначение     КАК Назначение,
		|	Таблица.КоличествоИзЗаказов                   КАК КоличествоИзЗаказов,
		|	Таблица.КоличествоПодЗаказ                    КАК КоличествоПодЗаказ,
		|	Таблица.КоличествоИзЗаказовСНеподтвержденными КАК КоличествоИзЗаказовСНеподтвержденными,
		|	Таблица.КоличествоПодЗаказСНеподтвержденными  КАК КоличествоПодЗаказСНеподтвержденными
		|ПОМЕСТИТЬ ВтТаблицаИзменений
		|ИЗ
		|	&Таблица КАК Таблица
		|;
		|
		|///////////////////////////////////
		|ВЫБРАТЬ ПЕРВЫЕ 1
		|	1
		|ИЗ(
		|	ВЫБРАТЬ
		|		ТаблицаИзменений.Номенклатура   КАК Номенклатура,
		|		ТаблицаИзменений.Характеристика КАК Характеристика,
		|		ТаблицаИзменений.Склад          КАК Склад,
		|		ТаблицаИзменений.ДатаСобытия    КАК ДатаСобытия,
		|		ТаблицаИзменений.Назначение     КАК Назначение,
		|		ТаблицаИзменений.КоличествоИзЗаказов                   КАК КоличествоИзЗаказов,
		|		ТаблицаИзменений.КоличествоПодЗаказ                    КАК КоличествоПодЗаказ,
		|		ТаблицаИзменений.КоличествоИзЗаказовСНеподтвержденными КАК КоличествоИзЗаказовСНеподтвержденными,
		|		ТаблицаИзменений.КоличествоПодЗаказСНеподтвержденными  КАК КоличествоПодЗаказСНеподтвержденными
		|	ИЗ
		|		ВтТаблицаИзменений КАК ТаблицаИзменений
		|	
		|	ОБЪЕДИНИТЬ ВСЕ
		|	
		|	ВЫБРАТЬ
		|		ГрафикПоступленияТоваров.Номенклатура   КАК Номенклатура,
		|		ГрафикПоступленияТоваров.Характеристика КАК Характеристика,
		|		ГрафикПоступленияТоваров.Склад          КАК Склад,
		|		ГрафикПоступленияТоваров.ДатаСобытия    КАК ДатаСобытия,
		|		ГрафикПоступленияТоваров.Назначение     КАК Назначение,
		|		-ГрафикПоступленияТоваров.КоличествоИзЗаказов                   КАК КоличествоИзЗаказов,
		|		-ГрафикПоступленияТоваров.КоличествоПодЗаказ                    КАК КоличествоПодЗаказ,
		|		-ГрафикПоступленияТоваров.КоличествоИзЗаказовСНеподтвержденными КАК КоличествоИзЗаказовСНеподтвержденными,
		|		-ГрафикПоступленияТоваров.КоличествоПодЗаказСНеподтвержденными  КАК КоличествоПодЗаказСНеподтвержденными
		|	ИЗ
		|		РегистрНакопления.ГрафикПоступленияТоваров КАК ГрафикПоступленияТоваров
		|	ГДЕ
		|		ГрафикПоступленияТоваров.Регистратор = &Регистратор) КАК Набор
		|СГРУППИРОВАТЬ ПО
		|	Набор.Номенклатура, Набор.Характеристика, Набор.Склад, Набор.ДатаСобытия, Набор.Назначение
		|ИМЕЮЩИЕ
		|	СУММА(Набор.КоличествоИзЗаказов) <> 0 
		|	ИЛИ СУММА(Набор.КоличествоПодЗаказ) <> 0
		|	ИЛИ СУММА(Набор.КоличествоИзЗаказовСНеподтвержденными) <> 0
		|	ИЛИ СУММА(Набор.КоличествоПодЗаказСНеподтвержденными) <> 0";
		
	Запрос.УстановитьПараметр("Таблица",     НаборЗаписей.Выгрузить());
	Запрос.УстановитьПараметр("Регистратор", Выборка.Регистратор);
	Возврат Не Запрос.Выполнить().Пустой();
	
КонецФункции


#КонецОбласти

#КонецОбласти

#КонецЕсли
