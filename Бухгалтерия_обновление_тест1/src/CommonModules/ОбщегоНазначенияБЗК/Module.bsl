////////////////////////////////////////////////////////////////////////////////
// Серверные процедуры и функции общего назначения
//
////////////////////////////////////////////////////////////////////////////////

#Область ПрограммныйИнтерфейс

////////////////////////////////////////////////////////////////////////////////
// Функции для работы с прикладными типами и коллекциями значений.

// Преобразует коллекцию движений в структуру.
//
// Параметры:
//  Движения - КоллекцияДвижений, Структура - исходная коллекция движений документа.
// 
// Возвращаемое значение:
//  Структура - движения в виде структуры.
//
Функция ДвиженияВСтруктуру(Движения) Экспорт
	
	Структура = Новый Структура;
	
	Если ТипЗнч(Движения) = Тип("Структура") Тогда
		Структура = ОбщегоНазначения.СкопироватьРекурсивно(Движения);
	Иначе	
		Для Каждого НаборЗаписей Из Движения Цикл
			Структура.Вставить(НаборЗаписей.Метаданные().Имя, НаборЗаписей);
		КонецЦикла;
	КонецЕсли;
	
	Возврат Структура
	
КонецФункции

// Помещает значения перечисления в массив.
//
// Параметры:
//  Перечисление     - ПеречислениеМенеджер        - исходное перечисление.
//	ИсключаяЗначения - Массив, ФиксированныйМассив - значения перечисления, не включаемые в результат.
// 
// Возвращаемое значение:
//  Массив - массив элементов типа ПеречислениеСсылка.
//
Функция ПеречислениеВМассив(Перечисление, Знач ИсключаяЗначения = Неопределено) Экспорт
	
	Если ИсключаяЗначения = Неопределено Тогда
		ИсключаяЗначения = Новый Массив;
	КонецЕсли;	
	
	ЗначенияПеречисления = Новый Массив;
	
	Для Каждого ЗначениеПеречисления Из Перечисление Цикл
		Если ИсключаяЗначения.Найти(ЗначениеПеречисления) = Неопределено Тогда
			ЗначенияПеречисления.Добавить(ЗначениеПеречисления);
		КонецЕсли;	
	КонецЦикла;	
	
	Возврат ЗначенияПеречисления
	
КонецФункции

// Возвращает таблицу значений с колонками, соответствующими структуре регистра накопления
// Параметры
//		ИмяРегистра - Строка, имя регистра накопления.
//
// Возвращаемое значение:
//   Таблица значений
//
Функция ТаблицаЗначенийПоИмениРегистраНакопления(ИмяРегистра) Экспорт
	
	Возврат ТаблицаЗначенийПоМетаданнымРегистра(Метаданные.РегистрыНакопления[ИмяРегистра], Истина);
	
КонецФункции

// Возвращает таблицу значений с колонками, соответствующими структуре регистра сведений
//
// Параметры:
//	ИмяРегистра - Строка, имя регистра сведений.
//
// Возвращаемое значение:
//   Таблица значений
//
Функция ТаблицаЗначенийПоИмениРегистраСведений(ИмяРегистра) Экспорт
	
	МетаданныеРегистра = Метаданные.РегистрыСведений[ИмяРегистра];
	
	Возврат ТаблицаЗначенийПоМетаданнымРегистра(МетаданныеРегистра,
		МетаданныеРегистра.ПериодичностьРегистраСведений <> Метаданные.СвойстваОбъектов.ПериодичностьРегистраСведений.Непериодический);
	
КонецФункции

// Добавляет индекс таблицы значений, если такого индекса еще нет.
// см. также ТаблицаЗначений.Индексы.Добавить()
//
// Параметры:
//  Коллекция - ТаблицаЗначений - Коллекция, в которую будет добавлен индекс.
//	Колонки   - Строка          - Строковое описание колонок индекса в виде: "Колонка1, Колонка2...". 
// 
// Возвращаемое значение:
//  ИндексКоллекции - добавленный индекс. Если индекс не добавлялся - Неопределено.
//
Функция ДобавитьИндексКоллекции(Коллекция, Знач Колонки) Экспорт
	
	// строка колонок приводится к каноническому виду
	КолонкиИндекса = Новый Массив;
	Для Каждого Свойство Из Новый Структура(Колонки) Цикл
		КолонкиИндекса.Добавить(Свойство.Ключ)
	КонецЦикла;
	Колонки = СтрСоединить(КолонкиИндекса, ", ");
	
	ИндексСуществует = Ложь;
	Для Каждого Индекс Из Коллекция.Индексы Цикл
		Если Строка(Индекс) = Колонки Тогда
			ИндексСуществует = Истина;
			Прервать;
		КонецЕсли;	
	КонецЦикла;
	
	Если ИндексСуществует Тогда
		Возврат Неопределено
	Иначе
		Возврат Коллекция.Индексы.Добавить(Колонки)
	КонецЕсли;
	
КонецФункции	

////////////////////////////////////////////////////////////////////////////////
// Функции для работы с типами, объектами метаданных и их строковыми представлениями.

// Возвращает менеджер объекта по типу.
// Ограничение: не обрабатываются точки маршрутов бизнес-процессов.
// См. так же МенеджерОбъектаПоПолномуИмени.
//
// Параметры:
//  Тип - Тип - тип объекта, менеджер которого требуется получить.
//
// Возвращаемое значение:
//  СправочникМенеджер, ДокументМенеджер, ОбработкаМенеджер, РегистрСведенийМенеджер - менеджер объекта.
//
// Пример:
//  МенеджерСправочника = ОбщегоНазначения.МенеджерОбъектаПоТипу(ТипЗнч(Ссылка));
//  ПустаяСсылка = МенеджерСправочника.ПустаяСсылка();
//
Функция МенеджерОбъектаПоТипу(Тип) Экспорт
	
	МетаданныеОбъекта = Метаданные.НайтиПоТипу(Тип);
	Если МетаданныеОбъекта = Неопределено Тогда
		Возврат Неопределено
	КонецЕсли;	
	
	ИмяОбъекта = МетаданныеОбъекта.Имя;
	
	Если Справочники.ТипВсеСсылки().СодержитТип(Тип) Тогда
		Возврат Справочники[ИмяОбъекта];
		
	ИначеЕсли Документы.ТипВсеСсылки().СодержитТип(Тип) Тогда
		Возврат Документы[ИмяОбъекта];
		
	ИначеЕсли БизнесПроцессы.ТипВсеСсылки().СодержитТип(Тип) Тогда
		Возврат БизнесПроцессы[ИмяОбъекта];
		
	ИначеЕсли ПланыВидовХарактеристик.ТипВсеСсылки().СодержитТип(Тип) Тогда
		Возврат ПланыВидовХарактеристик[ИмяОбъекта];
		
	ИначеЕсли ПланыСчетов.ТипВсеСсылки().СодержитТип(Тип) Тогда
		Возврат ПланыСчетов[ИмяОбъекта];
		
	ИначеЕсли ПланыВидовРасчета.ТипВсеСсылки().СодержитТип(Тип) Тогда
		Возврат ПланыВидовРасчета[ИмяОбъекта];
		
	ИначеЕсли Задачи.ТипВсеСсылки().СодержитТип(Тип) Тогда
		Возврат Задачи[ИмяОбъекта];
		
	ИначеЕсли ПланыОбмена.ТипВсеСсылки().СодержитТип(Тип) Тогда
		Возврат ПланыОбмена[ИмяОбъекта];
		
	ИначеЕсли Перечисления.ТипВсеСсылки().СодержитТип(Тип) Тогда
		Возврат Перечисления[ИмяОбъекта];
		
	Иначе
		Возврат Неопределено;
	КонецЕсли;
	
КонецФункции

// Возвращает объекты, сгруппированные по их типам.
//
// Параметры:
//  Объекты - Массив - объекты, которые необходимо сгруппировать.
// 
// Возвращаемое значение:
//  Соответствие - в ключе тип, в значении массив объектов этого типа.
//
Функция ОбъектыПоТипам(Объекты) Экспорт
	
	ОбъектыПоТипам = Новый Соответствие;
	
	Для Каждого Объект Из Объекты Цикл
		ОбъектыТипа = ОбъектыПоТипам[ТипЗнч(Объект)];
		Если ОбъектыТипа = Неопределено Тогда
			ОбъектыТипа = Новый Массив;
			ОбъектыПоТипам.Вставить(ТипЗнч(Объект), ОбъектыТипа); 
		КонецЕсли;	
		ОбъектыТипа.Добавить(Объект)
	КонецЦикла;
	
	Возврат ОбъектыПоТипам
	
КонецФункции	

////////////////////////////////////////////////////////////////////////////////
// Функции для работы с табличными документами.

// Возвращает структуру параметров табличного документа 
//
// Параметры:
//  ТабличныйДокумент - ТабличныйДокумент - табличный документ, параметры которого будут получены.
//
// Возвращаемое значение:
//  Структура - ключ соответствует имени параметра, значение - Неопределено.
//
Функция ПараметрыТабличногоДокумента(ТабличныйДокумент) Экспорт
	
	Параметры = Новый Структура;
	
	Для НомерСтроки = 1 По ТабличныйДокумент.ВысотаТаблицы Цикл
		Для НомерКолонки = 1 По ТабличныйДокумент.ШиринаТаблицы Цикл
			Ячейка = ТабличныйДокумент.Область(НомерСтроки, НомерКолонки);
			Если Ячейка.Заполнение = ТипЗаполненияОбластиТабличногоДокумента.Параметр Тогда
				Параметры.Вставить(Ячейка.Параметр);
			ИначеЕсли Ячейка.Заполнение = ТипЗаполненияОбластиТабличногоДокумента.Шаблон Тогда
				Для Каждого Параметр Из ПараметрыШаблонаТабличногоДокумента(Ячейка.Текст) Цикл
					Параметры.Вставить(Параметр);
				КонецЦикла;	
			КонецЕсли;
		КонецЦикла;
	КонецЦикла;
	
	Возврат Параметры;
	
КонецФункции

// Очищает параметры табличного документа
//
// Параметры:
//  ТабличныйДокумент - ТабличныйДокумент - табличный документ, параметры которого будут очищены.
//
Процедура ОчиститьПараметрыТабличногоДокумента(ТабличныйДокумент) Экспорт
	
	Для Сч = 1 По ТабличныйДокумент.Параметры.Количество() Цикл
		ТабличныйДокумент.Параметры.Установить(Сч - 1, ""); 
	КонецЦикла;
	
КонецПроцедуры	

// Дополняет табличный документ переданной строкой до конца страницы так, 
// чтобы на странице уместился указанный подвал.
//
// Параметры:
//  ТабДокумент - ТабличныйДокумент - дополняемый табличный документ.
//  Строка      - ТабличныйДокумент - строка, которой дополняется документ. 
//  Подвал      - Массив, ТабличныйДокумент - подвал, которым должна закончиться страница. 
//
// Возвращаемое значение:
//   Число   - количество добавленных строк.
//
Функция ДополнитьСтраницуТабличногоДокумента(ТабличныйДокумент, Строка, Подвал = Неопределено) Экспорт

	ДобавленоСтрок = 0;
	
	ВыводимыеОбласти = Новый Массив();
	ВыводимыеОбласти.Добавить(Строка);
	Если Подвал <> Неопределено Тогда
		Если ТипЗнч(Подвал) = Тип("Массив") Тогда
			ОбщегоНазначенияКлиентСервер.ДополнитьМассив(ВыводимыеОбласти, Подвал)
		Иначе
			ВыводимыеОбласти.Добавить(Подвал)
		КонецЕсли;	
	КонецЕсли;	
	
	Пока ОбщегоНазначения.ПроверитьВыводТабличногоДокумента(ТабличныйДокумент, ВыводимыеОбласти, Ложь) И ДобавленоСтрок < ТабличныйДокумент.ВысотаСтраницы Цикл
		ТабличныйДокумент.Вывести(Строка);
		ДобавленоСтрок = ДобавленоСтрок + 1;
	КонецЦикла;

	Возврат ДобавленоСтрок
	
КонецФункции 

// Проверяет вхождение даты в интервал
// 
// Параметры:
// 	ПроверяемаяДата - Дата - проверяемая дата
// 	ДатаНачалаИнтервала - Дата - дата начала интервала
// 	ДатаОкончанияИнтервала - Дата - дата окончания интервала
// 	ВключатьГраницы - Булево - определят необходимость учета границ интервала при проверке
// Возвращаемое значение:
// 	Булево
//
Функция ДатаВИнтервале(ПроверяемаяДата, ДатаНачалаИнтервала, ДатаОкончанияИнтервала, ВключатьГраницы = Истина) Экспорт
	Если ВключатьГраницы Тогда
		Если ПроверяемаяДата >= ДатаНачалаИнтервала
			И ПроверяемаяДата <= ДатаОкончанияИнтервала Тогда
				
			Возврат Истина;
		Иначе
			Возврат Ложь;
		КонецЕсли;
	Иначе
		Если ПроверяемаяДата > ДатаНачалаИнтервала
			И ПроверяемаяДата < ДатаОкончанияИнтервала Тогда
				
			Возврат Истина;
		Иначе
			Возврат Ложь;
		КонецЕсли;
	КонецЕсли;		
КонецФункции	

// Вставляет элемент в заданную позицию таблицы.
// 
// Параметры:
// 	Таблица - ТаблицаЗначений, ТабличнаяЧасть, ДанныеФормыКоллекция - любая таблица, имеющая методы Вставить и Добавить.
// 	ИндексСтроки     - Число        - Индекс вставляемой строки.
// 	                                  Необязательный. Если не указан, строка будет добавлена в конец таблицы.
// 	ШаблонЗаполнения - Произвольный - Значения свойств данного объекта будут установлены 
// 	                                  в соответствующие свойства новой строки.
// 	                                  Значение данного параметра не может быть следующих типов: 
// 	                                  Неопределено, Null, Число, Строка, Дата, Булево.
// Возвращаемое значение:
// 	СтрокаТаблицыЗначений, СтрокаТабличнойЧасти, ДанныеФормыЭлементКоллекции - добавленная строка таблицы.
//
Функция ВставитьСтрокуВТаблицу(Таблица, Индекс = Неопределено, ШаблонЗаполнения = Неопределено) Экспорт		
	Если Индекс = Неопределено 
		Или Индекс > Таблица.Количество() - 1 Тогда
		
		НоваяСтрока = Таблица.Добавить();		
	Иначе
		НоваяСтрока = Таблица.Вставить(Индекс);
	КонецЕсли;
	
	Если ШаблонЗаполнения <> Неопределено Тогда
		ЗаполнитьЗначенияСвойств(НоваяСтрока, ШаблонЗаполнения);
	КонецЕсли;
	
	Возврат НоваяСтрока;
КонецФункции	

#Область УстаревшиеПроцедурыИФункции

// Устарела. Следует использовать ОбщегоНазначения.ЗначенияРеквизитовОбъектов.
// Значения реквизитов, прочитанные из информационной базы для нескольких объектов.
//
//  Если необходимо зачитать реквизит независимо от прав текущего пользователя,
//  то следует использовать предварительный переход в привилегированный режим.
//
// Параметры:
//  Ссылки      - Массив - ссылки на объекты, значения реквизитов которых нужно получить.
//                         Если массив пуст, то результатом будет пустое соответствие.
//  Реквизиты   - Строка - имена реквизитов, перечисленные через запятую, 
//                         в формате требований к свойствам структуры. 
//                         Например, "Код, Наименование, Родитель".
//  Разрешенные - Булево - если Истина, то будут получены реквизиты объектов, доступные по правам пользователя;
//                       - если Ложь, то возникнет исключение при отсутствии прав на объект или реквизит.
//
// Возвращаемое значение:
//  Соответствие - список объектов и значений их реквизитов:
//   * Ключ - ЛюбаяСсылка - ссылка на объект;
//   * Значение - Структура - значения реквизитов:
//    ** Ключ - Строка - имя реквизита;
//    ** Значение - Произвольный - значение реквизита.
// 
Функция ЗначенияРеквизитовОбъектов(Ссылки, Знач Реквизиты, Разрешенные = Ложь) Экспорт
	
	Если ПустаяСтрока(Реквизиты) Тогда 
		ВызватьИсключение НСтр("ru='Неверный второй параметр ИменаРеквизитов: 
|- Поле объекта должно быть указано'
|;uk='Невірний другий параметр ИменаРеквизитов: 
|- Поле об''єкта повинно бути зазначено'");
	КонецЕсли;
	
	Если СтрНайти(Реквизиты, ".") <> 0 Тогда 
		ВызватьИсключение НСтр("ru='Неверный второй параметр ИменаРеквизитов: 
|- Обращение через точку не поддерживается'
|;uk='Невірний другий параметр ИменаРеквизитов: 
|- Звернення через точку не підтримується'");
	КонецЕсли;
	
	ЗначенияРеквизитов = Новый Соответствие;
	Если Ссылки.Количество() = 0 Тогда
		Возврат ЗначенияРеквизитов;
	КонецЕсли;
	
	ИменаПолей = СтрРазделить(Реквизиты, ",", Ложь);
	Для Индекс = 0 По ИменаПолей.ВГраница() Цикл
		ИменаПолей[Индекс] = СокрЛП(ИменаПолей[Индекс]);
	КонецЦикла;	
	
	Схема = Новый СхемаЗапроса;
	ЗапросВыбора = Схема.ПакетЗапросов.Добавить();
	ОператорыТипа = Новый Соответствие;
	Для Каждого Ссылка Из Ссылки Цикл
		Если ОператорыТипа.Получить(ТипЗнч(Ссылка)) = Неопределено Тогда
			Если ОператорыТипа.Количество() = 0 Тогда
				// ОператорыСхемыЗапроса всегда содержит хотя бы один элемент.
				// Поэтому для первого типа используем существующий оператор.
				ОператорВыбрать = ЗапросВыбора.Операторы[0];
			Иначе	
				ОператорВыбрать = ЗапросВыбора.Операторы.Добавить();
			КонецЕсли;	
			ИсточникОператора = ОператорВыбрать.Источники.Добавить(Ссылка.Метаданные().ПолноеИмя(), "Таблица");
			ОператорВыбрать.ВыбираемыеПоля.Добавить("Ссылка");
			Для Каждого ИмяПоля Из ИменаПолей Цикл
				Поле = ИсточникОператора.Источник.ДоступныеПоля.Найти(ИмяПоля);
				Если Поле = Неопределено Тогда
					ВызватьИсключение  
						СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(
							НСтр("ru='Неверный второй параметр ИменаРеквизитов:
|- В таблице ""%1"" поле ""%2"" не найдено'
|;uk='Неправильний другий параметр ИменаРеквизитов:
|- У таблиці ""%1"" поле ""%2"" не знайдено'"), 
							ИсточникОператора.Источник.ИмяТаблицы, 
							ИмяПоля)
				КонецЕсли;	
				ОператорВыбрать.ВыбираемыеПоля.Добавить(Поле);
			КонецЦикла;	
			ОператорВыбрать.Отбор.Добавить("Таблица.Ссылка В (&Ссылки)");
			ОператорыТипа.Вставить(ТипЗнч(Ссылка), ОператорВыбрать); 
		КонецЕсли;	
	КонецЦикла;	
	ЗапросВыбора.ВыбиратьРазрешенные = Разрешенные;
	
	Запрос = Новый Запрос;
	Запрос.Текст = Схема.ПолучитьТекстЗапроса();
	Запрос.УстановитьПараметр("Ссылки", Ссылки);
	
	Выборка = Запрос.Выполнить().Выбрать();
	Пока Выборка.Следующий() Цикл
		Результат = Новый Структура(Реквизиты);
		ЗаполнитьЗначенияСвойств(Результат, Выборка);
		ЗначенияРеквизитов[Выборка.Ссылка] = Результат;
	КонецЦикла;
	
	Возврат ЗначенияРеквизитов;
	
КонецФункции

// Устарела. Следует использовать ОбщегоНазначения.ЗначениеРеквизитаОбъектов.
// Значения реквизита, прочитанного из информационной базы для нескольких объектов.
//
//  Если необходимо зачитать реквизит независимо от прав текущего пользователя,
//  то следует использовать предварительный переход в привилегированный режим.
//
// Параметры:
//  Ссылки      - Массив - ссылки на объекты, значения реквизита которых нужно получить.
//                         Если массив пуст, то результатом будет пустое соответствие.
//  Реквизиты   - Строка - имя реквизита.
//  Разрешенные - Булево - если Истина, то будут получены реквизиты объектов, доступные по правам пользователя;
//                       - если Ложь, то возникнет исключение при отсутствии прав на объект или реквизит.
//
// Возвращаемое значение:
//  Соответствие - Ключ - ссылка на объект, Значение - значение прочитанного реквизита.
//      * Ключ     - ссылка на объект, 
//      * Значение - значение прочитанного реквизита.
// 
Функция ЗначениеРеквизитаОбъектов(Ссылки, Знач Реквизит, Разрешенные = Ложь) Экспорт
	
	Если ПустаяСтрока(Реквизит) Тогда 
		ВызватьИсключение НСтр("ru='Неверный второй параметр ИмяРеквизита: 
|- Имя реквизита должно быть заполнено'
|;uk='Невірний другий параметр ИмяРеквизита: 
|- Ім''я реквізиту повинно бути заповнено'");
	КонецЕсли;
	
	ЗначенияРеквизитов = ЗначенияРеквизитовОбъектов(Ссылки, Реквизит, Разрешенные);
	Для Каждого Элемент Из ЗначенияРеквизитов Цикл
		ЗначенияРеквизитов[Элемент.Ключ] = Элемент.Значение[Реквизит];
	КонецЦикла;
		
	Возврат ЗначенияРеквизитов;
	
КонецФункции

#КонецОбласти

#КонецОбласти

#Область СлужебныйПрограммныйИнтерфейс

////////////////////////////////////////////////////////////////////////////////
// Параметры выбора.

// Устанавливает значения параметров выбора элемента формы.
//
// Параметры:
//   ПолеВвода       - ПолеФормы    - Поле ввода, для которого требуется установить параметр выбора.
//   ПараметрыВыбора - Соответствие - Имена и значения параметров выбора.
//
// Возвращаемое значение:
//   Булево - Истина, если параметры выбора были изменены.
//
Функция УстановитьПараметрыВыбора(ПолеВвода, ПараметрыВыбора) Экспорт
	Если ПараметрыВыбора = Неопределено Тогда
		Возврат Ложь;
	КонецЕсли;
	Если ПараметрыВыбора.Количество() = 0 Тогда
		Возврат Ложь;
	КонецЕсли;
	
	ЕстьИзменения = Ложь;
	МассивПараметров = Новый Массив(ПолеВвода.ПараметрыВыбора);
	
	ОбратныйИндекс = МассивПараметров.Количество();
	Пока ОбратныйИндекс > 0 Цикл
		ОбратныйИндекс = ОбратныйИндекс - 1;
		ПараметрВыбора = МассивПараметров[ОбратныйИндекс];
		НовоеЗначение = ПараметрыВыбора[ПараметрВыбора.Имя];
		Если НовоеЗначение <> Неопределено Тогда
			ПараметрыВыбора.Удалить(ПараметрВыбора.Имя);
			Если Не ЗначенияСовпадают(НовоеЗначение, ПараметрВыбора.Значение) Тогда
				ЕстьИзменения = Истина;
				ПараметрВыбора = Новый ПараметрВыбора(ПараметрВыбора.Имя, НовоеЗначение);
				МассивПараметров.Удалить(ОбратныйИндекс);
				МассивПараметров.Вставить(ОбратныйИндекс, ПараметрВыбора);
			КонецЕсли;
		Иначе
			Исходное = ПараметрыВыбора.Количество();
			ПараметрыВыбора.Удалить(ПараметрВыбора.Имя);
			Если Исходное <> ПараметрыВыбора.Количество() Тогда
				ЕстьИзменения = Истина;
				МассивПараметров.Удалить(ОбратныйИндекс);
			КонецЕсли;
		КонецЕсли;
	КонецЦикла;
	
	Для Каждого КлючИЗначение Из ПараметрыВыбора Цикл
		Если КлючИЗначение.Значение = Неопределено Тогда
			Продолжить;
		КонецЕсли;
		МассивПараметров.Добавить(Новый ПараметрВыбора(КлючИЗначение.Ключ, КлючИЗначение.Значение));
		ЕстьИзменения = Истина;
	КонецЦикла;
	
	Если ЕстьИзменения Тогда
		ПолеВвода.ПараметрыВыбора = Новый ФиксированныйМассив(МассивПараметров);
	КонецЕсли;
	
	Возврат ЕстьИзменения;
КонецФункции

// Формирует отбор по параметрам выбора и связям параметров выбора.
//
// Параметры:
//   ФормаИлиОбъект - ФормаКлиентскогоПриложения, ДокументОбъект - Форма с полем ввода или документ с реквизитом, для которого
//                                                       формируется отбор.
//   ПолеВводаИлиРеквизитМетаданных - ПолеВвода, ОбъектМетаданных: Реквизит - Параметры выбора поля ввода или реквизита документа.
//   ДополнительныеПараметрыВыбора - Структура - Необязательный. Дополнительные параметры выбора реквизита документа.
//       Допустимо использовать когда в первом параметре используется ДокументОбъект.
//       Если в первом параметре используется ФормаКлиентскогоПриложения, то см. ОбщегоНазначенияБЗК.УстановитьПараметрыВыбора().
//
// Возвращаемое значение:
//   Структура - Параметры выбора значения реквизита.
//       * Отбор - Структура - Отбор по полям реквизита.
//
Функция ПараметрыВыбораВСтруктуру(ФормаИлиОбъект, ПолеВводаИлиРеквизитМетаданных, ДополнительныеПараметрыВыбора = Неопределено) Экспорт
	Параметры = Новый Структура("Отбор", Новый Структура);
	
	Для Каждого ПараметрВыбора Из ПолеВводаИлиРеквизитМетаданных.ПараметрыВыбора Цикл
		УстановитьЗначениеВИерархическойСтруктуре(Параметры, ПараметрВыбора.Имя, ПараметрВыбора.Значение);
	КонецЦикла;
	
	Для Каждого СвязьПараметровВыбора Из ПолеВводаИлиРеквизитМетаданных.СвязиПараметровВыбора Цикл
		ЗначениеПараметра = ЗначениеРеквизитаПоПутиКДанным(ФормаИлиОбъект, СвязьПараметровВыбора.ПутьКДанным);
		Если ЗначениеПараметра = "ТекущиеДанныеТаблицыНедоступныНаСервере" Тогда
			Продолжить; // Значения параметров, зачитываемых из строки ТЧ, можно передать в дополнительных параметрах выбора.
		КонецЕсли;
		УстановитьЗначениеВИерархическойСтруктуре(Параметры, СвязьПараметровВыбора.Имя, ЗначениеПараметра);
	КонецЦикла;
	
	Если ДополнительныеПараметрыВыбора <> Неопределено Тогда
		Для Каждого КлючИЗначение Из ДополнительныеПараметрыВыбора Цикл
			УстановитьЗначениеВИерархическойСтруктуре(Параметры, КлючИЗначение.Ключ, КлючИЗначение.Значение);
		КонецЦикла;
	КонецЕсли;
	
	Возврат Параметры;
КонецФункции

////////////////////////////////////////////////////////////////////////////////
// Структуры и массивы.

// Устанавливает значение в иерархии структур по полному пути к ключу.
Процедура УстановитьЗначениеВИерархическойСтруктуре(Структура, ПолноеИмяКлюча, Значение) Экспорт
	МассивКлючей = СтрРазделить(ПолноеИмяКлюча, ".");
	ВГраница = МассивКлючей.ВГраница();
	Коллекция = Структура;
	Для Индекс = 0 По ВГраница-1 Цикл
		Ключ = МассивКлючей[Индекс];
		Если Не Коллекция.Свойство(Ключ) Тогда
			Коллекция.Вставить(Ключ, Новый Структура);
		КонецЕсли;
		Коллекция = Коллекция[Ключ];
	КонецЦикла;
	Коллекция.Вставить(МассивКлючей[ВГраница], Значение);
КонецПроцедуры

// Сравнивает значения на равенство. Работает для массивов.
Функция ЗначенияСовпадают(Значение1, Значение2) Экспорт
	Если Значение1 = Значение2 Тогда
		Возврат Истина;
	ИначеЕсли ТипЗнч(Значение1) = ТипЗнч(Значение2) Тогда
		Возврат ОбщегоНазначения.ЗначениеВСтрокуXML(Значение1) = ОбщегоНазначения.ЗначениеВСтрокуXML(Значение2);
	Иначе
		Возврат Ложь;
	КонецЕсли;
КонецФункции

////////////////////////////////////////////////////////////////////////////////
// Формы, объекты.

// Получение значения свойства объекта по полному пути к данным.
//
// Параметры:
//   Объект      - Произвольный - Форма, объект справочника, документа и т.п..
//   ПутьКДанным - Строка       - Например, для формы может быть: "Объект.Ссылка".
//
// Возвращаемое значение:
//   Произвольный - Полученное значение.
//   "ТекущиеДанныеТаблицыНедоступныНаСервере" - если при обходе возникла ошибка "Текущие данные таблицы недоступны на сервере".
//
Функция ЗначениеРеквизитаПоПутиКДанным(Объект, ПутьКДанным) Экспорт
	МассивИмен = СтрРазделить(ПутьКДанным, ".");
	ВГраница = МассивИмен.ВГраница();
	Коллекция = Объект;
	Для Индекс = 0 По ВГраница - 1 Цикл
		Коллекция = Коллекция[МассивИмен[Индекс]];
		Если ТипЗнч(Коллекция) = Тип("ТаблицаФормы") И ВРег(МассивИмен[Индекс+1]) = ВРег("ТекущиеДанные") Тогда
			Возврат "ТекущиеДанныеТаблицыНедоступныНаСервере"; // Обход ошибки "Текущие данные таблицы недоступны на сервере".
		КонецЕсли;
	КонецЦикла;
	Возврат Коллекция[МассивИмен[ВГраница]];
КонецФункции

Процедура ДобавитьОшибкуЗаполненияДокумента(Ошибки, Текст, Документ = Неопределено, Поле = "", ПутьКДанным = "", Отказ = Ложь) Экспорт
	
	Если Ошибки <> Неопределено Тогда
		Ошибки.Добавить(Текст);
		Отказ = Истина;
		Возврат;
	КонецЕсли;
	
	ОбщегоНазначения.СообщитьПользователю(Текст, Документ, Поле, ПутьКДанным, Отказ);
	
КонецПроцедуры	

////////////////////////////////////////////////////////////////////////////////
// Условное оформление формы и динамического списка.

// Добавляет элемент условного оформления в форму.
//
// Параметры:
//   ФормаИлиСписок - ФормаКлиентскогоПриложения, ДинамическийСписок - Форма или список, 
//       в который необходимо добавить условное оформление.
//   ИменаПолей - Строка - Имена элементов формы, разделенные запятыми, для которых применяется оформление.
//       Например: "Поле1, Поле2".
//       Если необходимо чтобы условное оформление применялось ко всем строкам таблицы, тогда:
//       - Для условного оформления управляемой формы в параметре "ИменаПолей" следует передать имя таблицы формы.
//       - Для условного оформления динамического списка в параметре "ИменаПолей" следует передать пустую строку.
//
// Возвращаемое значение:
//   ЭлементУсловногоОформленияКомпоновкиДанных - Добавленный элемент.
//
Функция ДобавитьУсловноеОформление(ФормаИлиСписок, ИменаПолей) Экспорт
	ЭлементУсловногоОформленияКД = ФормаИлиСписок.УсловноеОформление.Элементы.Добавить();
	ЭлементУсловногоОформленияКД.Использование = Истина;
	
	Если ТипЗнч(ИменаПолей) = Тип("Строка") Тогда
		МассивИменПолей = СтрРазделить(ИменаПолей, ",", Ложь);
	Иначе
		МассивИменПолей = ИменаПолей;
	КонецЕсли;
	Для Каждого ИмяПоля Из МассивИменПолей Цикл
		ИмяПоля = СокрЛП(ИмяПоля);
		Если ИмяПоля <> "" Тогда
			ПолеКД = ЭлементУсловногоОформленияКД.Поля.Элементы.Добавить();
			ПолеКД.Использование = Истина;
			ПолеКД.Поле = Новый ПолеКомпоновкиДанных(ИмяПоля);
		КонецЕсли;
	КонецЦикла;
	
	Возврат ЭлементУсловногоОформленияКД;
КонецФункции

// Устанавливает параметр условного оформления.
//
// Параметры:
//   ЭлементУсловногоОформленияКД - ЭлементУсловногоОформленияКомпоновкиДанных - Элемент условного оформления формы.
//   ИмяПараметра - Строка - Имя параметра или параметр компоновки данных, значение которого нужно установить.
//       Имена параметров см. в синтакс-помощнике: "ОформлениеКомпоновкиДанных", блок "Описание".
//   ЗначениеПараметра - Произвольный - Значение, которое нужно установить.
//       Типы значений см. в синтакс-помощнике: "ОформлениеКомпоновкиДанных", блок "Описание".
//
Процедура УстановитьПараметрУсловногоОформления(ЭлементУсловногоОформленияКД, ИмяПараметра, ЗначениеПараметра) Экспорт
	ЭлементУсловногоОформленияКД.Оформление.УстановитьЗначениеПараметра(
		Новый ПараметрКомпоновкиДанных(ИмяПараметра),
		ЗначениеПараметра);
КонецПроцедуры

// Добавляет отбор элемента условного оформления.
//
// Параметры:
//   Форма - ФормаКлиентскогоПриложения - Форма, в которую необходимо добавить условное оформление.
//   Поле - Строка - Имя поля отбора.
//   ВидСравнения - ВидСравненияКомпоновкиДанных, Строка - Вид сравнения отбора.
//       Если указано значение "=", то используется ВидСравненияКомпоновкиДанных.Равно.
//   Значение - Произвольный - Значение отбора. Необязательный если ВидСравнения = Заполнено или НеЗаполнено.
//
// Возвращаемое значение:
//   ЭлементОтбораКомпоновкиДанных - Добавленный элемент отбора.
//
Функция ДобавитьОтборУсловногоОформления(ЭлементУсловногоОформленияКД, Поле, ВидСравнения, Значение = Неопределено) Экспорт
	Если ТипЗнч(ВидСравнения) = Тип("ВидСравненияКомпоновкиДанных") Тогда
		ВидСравненияКД = ВидСравнения;
	Иначе
		Если ВидСравнения = "=" Тогда
			ВидСравненияКД = ВидСравненияКомпоновкиДанных.Равно;
		ИначеЕсли ВидСравнения = ">" Тогда
			ВидСравненияКД = ВидСравненияКомпоновкиДанных.Больше;
		ИначеЕсли ВидСравнения = ">=" Тогда
			ВидСравненияКД = ВидСравненияКомпоновкиДанных.БольшеИлиРавно;
		ИначеЕсли ВидСравнения = "<" Тогда
			ВидСравненияКД = ВидСравненияКомпоновкиДанных.Меньше;
		ИначеЕсли ВидСравнения = "<=" Тогда
			ВидСравненияКД = ВидСравненияКомпоновкиДанных.МеньшеИлиРавно;
		Иначе
			ВызватьИсключение СтрШаблон(НСтр("ru='Неизвестный параметр ""ВидСравнения"" = ""%1""';uk='Невідомий параметр ""ВидСравнения"" = ""%1""'"), ВидСравнения);
		КонецЕсли;
	КонецЕсли;
	
	ЭлементОтбораКД = ЭлементУсловногоОформленияКД.Отбор.Элементы.Добавить(Тип("ЭлементОтбораКомпоновкиДанных"));
	ЭлементОтбораКД.ЛевоеЗначение  = Новый ПолеКомпоновкиДанных(Поле);
	ЭлементОтбораКД.ВидСравнения   = ВидСравненияКД;
	ЭлементОтбораКД.ПравоеЗначение = Значение;
	
	Возврат ЭлементОтбораКД;
КонецФункции

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

Функция ПараметрыШаблонаТабличногоДокумента(Знач Шаблон)
	
	ПараметрыВШаблоне = Новый Массив;
	
	Шаблон = СтрЗаменить(Шаблон, "[", Символы.ПС + "[");
	Шаблон = СтрЗаменить(Шаблон, "]", Символы.ПС);
	
	Для НомерСтроки = 1 По СтрЧислоСтрок(Шаблон) Цикл
		Строка = СтрПолучитьСтроку(Шаблон, НомерСтроки);
		Если Лев(Строка, 1) = "[" Тогда
			ПараметрыВШаблоне.Добавить(Сред(Строка, 2));
		КонецЕсли;
	КонецЦикла;
	
	Возврат ПараметрыВШаблоне;
	
КонецФункции

Функция ТаблицаЗначенийПоМетаданнымРегистра(МетаданныеРегистра, ДобавитьКолонкуПериод)
	
	ТаблицаЗначенийРегистраНакопления = Новый ТаблицаЗначений;
	Если ДобавитьКолонкуПериод Тогда
		ТаблицаЗначенийРегистраНакопления.Колонки.Добавить("Период", Новый ОписаниеТипов("Дата"));
	КонецЕсли;
	
	// Измерения
	Для Каждого Измерение Из МетаданныеРегистра.Измерения Цикл
		ТаблицаЗначенийРегистраНакопления.Колонки.Добавить(Измерение.Имя, Измерение.Тип);
	КонецЦикла;
	
	// Ресурсы
	Для Каждого Ресурс Из МетаданныеРегистра.Ресурсы Цикл
		ТаблицаЗначенийРегистраНакопления.Колонки.Добавить(Ресурс.Имя, Ресурс.Тип);
	КонецЦикла;
	
	// Реквизиты
	Для Каждого Реквизит Из МетаданныеРегистра.Реквизиты Цикл
		ТаблицаЗначенийРегистраНакопления.Колонки.Добавить(Реквизит.Имя, Реквизит.Тип);
	КонецЦикла;
	
	Возврат ТаблицаЗначенийРегистраНакопления;
	
КонецФункции

#КонецОбласти

