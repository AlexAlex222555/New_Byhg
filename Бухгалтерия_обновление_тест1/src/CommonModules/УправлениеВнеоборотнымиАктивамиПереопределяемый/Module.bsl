
// ПРОГРАММНЫЙ ИНТЕРФЕЙС

// Возвращает тип ссылка на справочник для хранения основных средст
//
// Возвращаемое значение:
// 		Тип - Тип ссылки на справочник ОС
//
Функция ТипДанныхОсновныхСредств() Экспорт
	
	Возврат Тип("СправочникСсылка.ОбъектыЭксплуатации");
	
КонецФункции

// РАСПРЕДЕЛЕНИЕ АМОРТИЗАЦИИ ПО НАПРАВЛЕНИЯМ ЗАТРАТ

Функция ПустаяТаблицаАмортизации() Экспорт
	
	ТаблицаЗатрат = Новый ТаблицаЗначений;
	
	МассивТиповОбъектаУчета = Новый Массив;
	МассивТиповОбъектаУчета.Добавить(Тип("СправочникСсылка.ОбъектыЭксплуатации"));
	МассивТиповОбъектаУчета.Добавить(Тип("СправочникСсылка.НематериальныеАктивы"));
	ТаблицаЗатрат.Колонки.Добавить("ОбъектУчета", Новый ОписаниеТипов(МассивТиповОбъектаУчета));
	ТаблицаЗатрат.Колонки.Добавить("СчетАмортизации", Новый ОписаниеТипов("ПланСчетовСсылка.Хозрасчетный"));
	ТаблицаЗатрат.Колонки.Добавить("СуммаБУ", ОбщегоНазначенияБПКлиентСервер.ПолучитьОписаниеТиповЧисла(15, 2));
	ТаблицаЗатрат.Колонки.Добавить("СуммаНУ", ОбщегоНазначенияБПКлиентСервер.ПолучитьОписаниеТиповЧисла(15, 2));
	ТаблицаЗатрат.Колонки.Добавить("СуммаВР", ОбщегоНазначенияБПКлиентСервер.ПолучитьОписаниеТиповЧисла(15, 2));
	ТаблицаЗатрат.Колонки.Добавить("СуммаПР", ОбщегоНазначенияБПКлиентСервер.ПолучитьОписаниеТиповЧисла(15, 2));
	ТаблицаЗатрат.Колонки.Добавить("Подразделение", Новый ОписаниеТипов("СправочникСсылка.СтруктураПредприятия"));
	ТаблицаЗатрат.Колонки.Добавить("ПодразделениеЗатрат", Новый ОписаниеТипов("СправочникСсылка.СтруктураПредприятия"));
	ТаблицаЗатрат.Колонки.Добавить("СтатьяРасходов", Новый ОписаниеТипов("ПланВидовХарактеристикСсылка.СтатьиРасходов"));
	ТаблицаЗатрат.Колонки.Добавить("АналитикаРасходов", Метаданные.ПланыВидовХарактеристик.СтатьиРасходов.Тип);
	ТаблицаЗатрат.Колонки.Добавить("Коэффициент", Новый ОписаниеТипов("Число"));
	
	ТаблицаЗатрат.Колонки.Добавить("ПередаватьРасходыВДругуюОрганизацию", Новый ОписаниеТипов("Булево"));
	ТаблицаЗатрат.Колонки.Добавить("ОрганизацияПолучательРасходов", Новый ОписаниеТипов("СправочникСсылка.Организации"));
	ТаблицаЗатрат.Колонки.Добавить("СчетПередачиРасходов", Новый ОписаниеТипов("ПланСчетовСсылка.Хозрасчетный"));
	
	ТаблицаЗатрат.Колонки.Добавить("НачислятьИзнос", Новый ОписаниеТипов("Булево"));
	
	ТаблицаЗатрат.Колонки.Добавить("Контрагент",         Новый ОписаниеТипов("СправочникСсылка.Контрагенты"));
	ТаблицаЗатрат.Колонки.Добавить("ДоговорКонтрагента", ПланыВидовХарактеристик.ВидыСубконтоХозрасчетные.Договоры.ТипЗначения);
	ТаблицаЗатрат.Колонки.Добавить("НаправлениеДеятельности", Новый ОписаниеТипов("СправочникСсылка.НаправленияДеятельности"));
	ТаблицаЗатрат.Колонки.Добавить("НаправлениеДеятельностиЗатрат", Новый ОписаниеТипов("СправочникСсылка.НаправленияДеятельности"));
	
	Возврат ТаблицаЗатрат;
	
КонецФункции

// ПРОЧИЕ

// Возвращает пустую таблицу значений с заранее созданными колонками
// Нужно для создания пустых таблиц значения для дальнейшей
//   обработки в функциях "ПодготовитьПараметры*"
//
Функция ПолучитьПустуюТаблицуЗначенийСКолонками(СтруктураКолонок) Экспорт

	Таблица = Новый ТаблицаЗначений;

	Для Каждого ТекущаяКолонка Из СтруктураКолонок Цикл
		Если ТипЗнч(ТекущаяКолонка.Значение) = Тип("Тип") Тогда
			НоваяКолонка = Таблица.Колонки.Добавить(ТекущаяКолонка.Ключ, ТекущаяКолонка.Значение);
		Иначе
			НоваяКолонка = Таблица.Колонки.Добавить(ТекущаяКолонка.Ключ);
		КонецЕсли;
	КонецЦикла;

	Возврат Таблица;

КонецФункции

// Возвращает список обязательных колонок (через запятую), отсутствующих в таблице значений
//
//Параметры:
//	Таблица 			- <ТаблицаЗначений> - проверяемая таблица
//	ОбязательныеКолонки - <Строка> - имена колонок, которые обязательно должны присутствовать в таблице
//
//Возвращаемое значение:
//	<Строка> - имена отсутствующих в таблице колонок через запятую
Функция ПроверитьКолонкиТаблицыЗначений(Таблица, ОбязательныеКолонки)

	СтруктураКолонок = Новый Структура(ОбязательныеКолонки);
	КолонкиТаблицы = Таблица.Колонки;
	СтрокаНеНайденных = "";

	Для Каждого ОбязательнаяКолонка Из СтруктураКолонок Цикл

		Если КолонкиТаблицы.Найти(ОбязательнаяКолонка.Ключ) = Неопределено Тогда
			СтрокаНеНайденных = СтрокаНеНайденных + ?(СтрокаНеНайденных = "", "", ", ") + ОбязательнаяКолонка.Ключ;
		КонецЕсли;

	КонецЦикла;

	Возврат СтрокаНеНайденных;

КонецФункции

// Определяет коэффициент распределения выручки по видам деятельности 
// (ЕНВД / не ЕНВД) за период.
//
// Параметры:
//  Организация - СправочникСсылка.Организации - Организация.
//  НачДата     - Дата - Начало периода расчета.
//	КонДата     - Дата - Окончание периода расчета.
//
// Возвращаемое значение:
//  Число - Коэффициент распределения расходов по видам деятельности.
//
Функция КоэффициентРаспределенияВыручкиПоВидамДеятельности(Организация, Знач НачДата, Знач КонДата) Экспорт
	
	Запрос = Новый Запрос;
	Запрос.УстановитьПараметр("Организация",      Организация);
	Запрос.УстановитьПараметр("НачДата",          НачДата);
	Запрос.УстановитьПараметр("КонДата",          КонДата);
	
	Запрос.Текст = 
	"ВЫБРАТЬ
	|	ЕСТЬNULL(СУММА(ВЫБОР
	|				КОГДА ВыручкаИСебестоимостьПродаж.НалогообложениеНДС = ЗНАЧЕНИЕ(Перечисление.ТипыНалогообложенияНДС.ПродажаОблагаетсяЕНВД)
	|					ТОГДА ВыручкаИСебестоимостьПродаж.СуммаВыручкиБезНДС
	|				ИНАЧЕ 0
	|			КОНЕЦ), 0) КАК ВыручкаЕНВД,
	|	ЕСТЬNULL(СУММА(ВЫБОР
	|				КОГДА ВыручкаИСебестоимостьПродаж.НалогообложениеНДС <> ЗНАЧЕНИЕ(Перечисление.ТипыНалогообложенияНДС.ПродажаОблагаетсяЕНВД)
	|					ТОГДА ВыручкаИСебестоимостьПродаж.СуммаВыручкиБезНДС
	|				ИНАЧЕ 0
	|			КОНЕЦ), 0) КАК ВыручкаНеЕНВД
	|ИЗ
	|	РегистрНакопления.ВыручкаИСебестоимостьПродаж КАК ВыручкаИСебестоимостьПродаж
	|		ВНУТРЕННЕЕ СОЕДИНЕНИЕ Справочник.КлючиАналитикиУчетаПоПартнерам КАК КлючиАналитикиУчетаПоПартнерам
	|		ПО ВыручкаИСебестоимостьПродаж.АналитикаУчетаПоПартнерам = КлючиАналитикиУчетаПоПартнерам.Ссылка
	|			И (КлючиАналитикиУчетаПоПартнерам.Организация = &Организация)
	|ГДЕ
	|	ВыручкаИСебестоимостьПродаж.Период МЕЖДУ &НачДата И &КонДата";
	РезультатЗапроса = Запрос.Выполнить();
	
	// Если результат запроса пустой, то считаем, что все
	// расходы относятся к деятельности, не облагаемой ЕНВД.
	Если РезультатЗапроса.Пустой() Тогда
		
		Коэффициент = 1;
		
	Иначе
		
		Выборка = РезультатЗапроса.Выбрать();
		Выборка.Следующий();
		ВыручкаЕНВД   = Макс(Выборка.ВыручкаЕНВД,   0);
		ВыручкаНеЕНВД = Макс(Выборка.ВыручкаНеЕНВД, 0);
		
		Если ВыручкаНеЕНВД + ВыручкаЕНВД = 0 Тогда // нет дохода ни по одному из видов деятельности
			Коэффициент = 1;
		Иначе
			Коэффициент = ВыручкаНеЕНВД / (ВыручкаНеЕНВД + ВыручкаЕНВД);
		КонецЕсли;
		
	КонецЕсли;
	
	Возврат Коэффициент;
	
КонецФункции // КоэффициентРаспределенияВыручкиПоВидамДеятельности()

// Функция возвращает строку с описание для пользователя ссылки в интерфейсе, 
// где расположен регистр сведений "Регистрация транспортных средств".
// 
// Возвращаемое значение:
//	 Строка.
//
Функция ОписаниеПутиВИнтерфейсеКРегистрацииТранспортныхСредств() Экспорт

	Если ПолучитьФункциональнуюОпцию("ИспользоватьВнеоборотныеАктивы2_4") Тогда 
		Результат = НСтр("ru='(меню ""Необоротные активы"" - ""Документы по ОС"")';uk='(Меню ""Необоротні активи"" - ""Документи по ОС"")'");
	Иначе
		Результат = НСтр("ru='(меню ""Регламентированный учет"" - ""Документы по ОС"")';uk='(Меню ""Регламентований облік"" - ""Документи по ОС"")'");
	КонецЕсли;
	
	Возврат Результат;

КонецФункции

// Функция возвращает строку с описание для пользователя ссылки в интерфейсе, 
// где расположен регистр сведений "Регистрация земельных участков".
// 
// Возвращаемое значение:
//	 Строка.
//
Функция ОписаниеПутиВИнтерфейсеКРегистрацииЗемельныхУчастков() Экспорт

	Если ПолучитьФункциональнуюОпцию("ИспользоватьВнеоборотныеАктивы2_4") Тогда 
		Результат = НСтр("ru='(меню ""Необоротные активы"" - ""Документы по ОС"")';uk='(Меню ""Необоротні активи"" - ""Документи по ОС"")'");
	Иначе
		Результат = НСтр("ru='(меню ""Регламентированный учет"" - ""Документы по ОС"")';uk='(Меню ""Регламентований облік"" - ""Документи по ОС"")'");
	КонецЕсли;

	Возврат Результат;

КонецФункции

////////////////////////////////////////////////////////////////////////////////
// ПРОЦЕДУРЫ И ФУНКЦИИ РАБОТЫ С ДВИЖЕНИЯМИ ДОКУМЕНТОВ

Функция ПараметрыПроведения(ИсходнаяТаблица, СписокКолонок) Экспорт

	Если ИсходнаяТаблица = Неопределено Тогда
		
		ТаблицаРезультат = Новый ТаблицаЗначений;
		Колонки = Новый Структура(СписокКолонок);
		Для каждого Колонка Из Колонки Цикл
			ТаблицаРезультат.Колонки.Добавить(Колонка.Ключ);
		КонецЦикла;
		Возврат ТаблицаРезультат;

	Иначе

		ОтсутствующиеКолонки = ПроверитьКолонкиТаблицыЗначений(ИсходнаяТаблица, СписокКолонок);
		Если НЕ ПустаяСтрока(ОтсутствующиеКолонки) Тогда
			ОписаниеИсключения = НСтр("ru='В таблице отсутствуют колонки: %1';uk='У таблиці відсутні колонки: %1'");
			ОписаниеИсключения = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(ОписаниеИсключения, ОтсутствующиеКолонки);
			ВызватьИсключение ОписаниеИсключения;
		КонецЕсли;

		Возврат ИсходнаяТаблица.Скопировать(, СписокКолонок);

	КонецЕсли;

КонецФункции

// Выполняет движение по регистру.
//
// Параметры:
//  НаборДвижений   - набор движений регистра.
//
Процедура ВыполнитьДвижениеПоРегистру(НаборДвижений, ВидДвижения = Неопределено) Экспорт

	ТаблицаДвижений = НаборДвижений.мТаблицаДвижений;
	Если ТаблицаДвижений.Количество() = 0 Тогда
		Возврат;
	КонецЕсли;

    Если ТаблицаДвижений.Колонки.Найти("Период") = Неопределено Тогда
		ТаблицаДвижений.Колонки.Добавить("Период", ОбщегоНазначенияБПКлиентСервер.ПолучитьОписаниеТиповДаты(ЧастиДаты.ДатаВремя))
	КонецЕсли;

	МетаРег = НаборДвижений.Метаданные();
	ИзмеренияСостТипа = Новый Структура;

	Для Каждого МетаИзм Из МетаРег.Измерения Цикл
		Если МетаИзм.Тип.Типы().Количество() > 1 Тогда
			ИзмеренияСостТипа.Вставить(МетаИзм.Имя);
		КонецЕсли;
	КонецЦикла;

	Для Каждого МетаИзм Из МетаРег.Реквизиты Цикл
		Если МетаИзм.Тип.Типы().Количество() > 1 Тогда
			ИзмеренияСостТипа.Вставить(МетаИзм.Имя);
		КонецЕсли;
	КонецЦикла;

	Для Каждого МетаРес Из МетаРег.Ресурсы Цикл
		Если МетаРес.Тип.Типы().Количество() > 1 Тогда
			ИзмеренияСостТипа.Вставить(МетаРес.Имя);
		КонецЕсли;
	КонецЦикла;

	// Скопируем остальные колонки (структура таблиц совпадает).
	ПерваяКолонка = Истина;
	МассивСтрок   = Новый Массив(ТаблицаДвижений.Количество());

	Для каждого Колонка Из ТаблицаДвижений.Колонки Цикл

		ИмяКолонки = Колонка.Имя;

		Если ИмяКолонки <> "Период"
		   И ИмяКолонки <> "Активность"
		   И ИмяКолонки <> "НомерСтроки"
		   И ИмяКолонки <> ""
		   И ?(ИмяКолонки = "ВидДвижения", ВидДвижения = Неопределено, Истина)
		   И ИмяКолонки <> "МоментВремени" Тогда

			ФлагКолонкиСостТипа = (ИзмеренияСостТипа.Свойство(ИмяКолонки));

			Индекс = 0;

			Для каждого СтрокаТаблицы Из ТаблицаДвижений Цикл

				Если ПерваяКолонка Тогда

					Если ВидДвижения = ВидДвиженияНакопления.Приход Тогда
						СтрокаДвижения = НаборДвижений.ДобавитьПриход();
					ИначеЕсли ВидДвижения = ВидДвиженияНакопления.Расход Тогда
						СтрокаДвижения = НаборДвижений.ДобавитьРасход();
					Иначе
						СтрокаДвижения = НаборДвижений.Добавить(); // Для оборотных регистров
					КонецЕсли;

					МассивСтрок[Индекс] = СтрокаДвижения;
					Если СтрокаТаблицы.Период = '00010101' Тогда
						СтрокаДвижения.Период = НаборДвижений.мПериод;
					Иначе
						СтрокаДвижения.Период = СтрокаТаблицы.Период;
					КонецЕсли;

				Иначе

					СтрокаДвижения = МассивСтрок[Индекс];

				КонецЕсли;

				Индекс = Индекс + 1;

				ЗначКолонки = СтрокаТаблицы[ИмяКолонки];
				Если ФлагКолонкиСостТипа Тогда
					Если ЗначКолонки = Неопределено ИЛИ НЕ ЗначениеЗаполнено(ЗначКолонки) Тогда
						СтрокаДвижения[ИмяКолонки] = Неопределено;
					Иначе
						СтрокаДвижения[ИмяКолонки] = ЗначКолонки;
					КонецЕсли;
				Иначе
					СтрокаДвижения[ИмяКолонки] = ЗначКолонки;
				КонецЕсли;

			КонецЦикла;

			ПерваяКолонка = Ложь;

		КонецЕсли;

	КонецЦикла;

КонецПроцедуры // ВыполнитьДвижениеПоРегистру()

// Процедура предназначена для заполнения общих реквизитов документов по документу основанию,
//	вызывается в обработчиках событий "ОбработкаЗаполнения" в модулях документов.
//
// Параметры:
//  ДокументОбъект  - объект редактируемого документа,
//  ДокументОснование - объект документа основания
//  КопироватьПодразделение - булево - если да - подразделение организации берется из документа-основания,
//										если нет - из реквизита СчетОрганизации или настройки пользователя
//
Процедура ЗаполнитьПоОснованию(ДокументОбъект, ДокументОснование, КопироватьПодразделение = Истина) Экспорт

	МетаданныеДокумента          = ДокументОбъект.Метаданные();
	МетаданныеДокументаОснования = ДокументОснование.Метаданные();

	// Дата
	Если НЕ ЗначениеЗаполнено(ДокументОбъект.Дата) Тогда
		ДокументОбъект.Дата = НачалоДня(ТекущаяДатаСеанса());
	КонецЕсли;

	// Организация.
	Если ОбщегоНазначенияБП.ЕстьРеквизитДокумента("Организация", МетаданныеДокумента)
	   И ОбщегоНазначенияБП.ЕстьРеквизитДокумента("Организация", МетаданныеДокументаОснования) Тогда
		ДокументОбъект.Организация = ДокументОснование.Организация;
	КонецЕсли;

	// Склад.
	Если ОбщегоНазначенияБП.ЕстьРеквизитДокумента("Склад", МетаданныеДокумента)
	   И ОбщегоНазначенияБП.ЕстьРеквизитДокумента("Склад", МетаданныеДокументаОснования) Тогда
		ДокументОбъект.Склад = ДокументОснование.Склад;
	КонецЕсли;

	// Контрагент.
	Если ОбщегоНазначенияБП.ЕстьРеквизитДокумента("Контрагент", МетаданныеДокумента)
	   И ОбщегоНазначенияБП.ЕстьРеквизитДокумента("Контрагент", МетаданныеДокументаОснования) Тогда
		ДокументОбъект.Контрагент = ДокументОснование.Контрагент;
	КонецЕсли;

	// ДоговорКонтрагента.
	Если ОбщегоНазначенияБП.ЕстьРеквизитДокумента("ДоговорКонтрагента", МетаданныеДокумента)
	   И ОбщегоНазначенияБП.ЕстьРеквизитДокумента("ДоговорКонтрагента", МетаданныеДокументаОснования)
	   И (НЕ ОбщегоНазначенияБП.ЕстьРеквизитДокумента("Организация", МетаданныеДокумента)
	      ИЛИ ОбщегоНазначенияБПВызовСервераПовтИсп.ГоловнаяОрганизация(ДокументОбъект.Организация) =
		  	ОбщегоНазначенияБПВызовСервераПовтИсп.ГоловнаяОрганизация(ДокументОснование.ДоговорКонтрагента.Организация)) Тогда

		ДокументОбъект.ДоговорКонтрагента = ДокументОснование.ДоговорКонтрагента;

		// КурсВзаиморасчетов.
		Если ОбщегоНазначенияБП.ЕстьРеквизитДокумента("КурсВзаиморасчетов", МетаданныеДокумента) Тогда
			СтруктураКурсаВзаиморасчетов = РаботаСКурсамиВалют.ПолучитьКурсВалюты(ДокументОбъект.ДоговорКонтрагента.ВалютаВзаиморасчетов, ДокументОбъект.Дата);
			ДокументОбъект.КурсВзаиморасчетов = СтруктураКурсаВзаиморасчетов.Курс;

			// КратностьВзаиморасчетов.
			Если ОбщегоНазначенияБП.ЕстьРеквизитДокумента("КратностьВзаиморасчетов", МетаданныеДокумента) Тогда
				ДокументОбъект.КратностьВзаиморасчетов = СтруктураКурсаВзаиморасчетов.Кратность;
			КонецЕсли;
		КонецЕсли;

	КонецЕсли;

	// Банковский счет
	Если ОбщегоНазначенияБП.ЕстьРеквизитДокумента("БанковскийСчет", МетаданныеДокумента) Тогда

		// Если в документе-основании есть структурная единица, то берем ее оттуда
		Если ОбщегоНазначенияБП.ЕстьРеквизитДокумента("СтруктурнаяЕдиница", МетаданныеДокументаОснования) Тогда
			Если ЗначениеЗаполнено(ДокументОснование.СтруктурнаяЕдиница)
			   И ТипЗнч(ДокументОснование.СтруктурнаяЕдиница) = БухгалтерскийУчетКлиентСерверПереопределяемый.ТипЗначенияБанковскогоСчетаОрганизации() Тогда
				ДокументОбъект.БанковскийСчет = ДокументОснование.СтруктурнаяЕдиница;
			КонецЕсли;
		ИначеЕсли ОбщегоНазначенияБП.ЕстьРеквизитДокумента("БанковскийСчет", МетаданныеДокументаОснования) Тогда
			Если ЗначениеЗаполнено(ДокументОснование.БанковскийСчет) Тогда
				ДокументОбъект.БанковскийСчет = ДокументОснование.БанковскийСчет;
			КонецЕсли;

		КонецЕсли;

	КонецЕсли;

	Если ОбщегоНазначенияБП.ЕстьРеквизитДокумента("СчетОрганизации", МетаданныеДокумента) Тогда

		// Если в документе-основании есть структурная единица, то берем ее оттуда
		Если ОбщегоНазначенияБП.ЕстьРеквизитДокумента("СтруктурнаяЕдиница", МетаданныеДокументаОснования) Тогда
			Если ЗначениеЗаполнено(ДокументОснование.СтруктурнаяЕдиница)
			   И ТипЗнч(ДокументОснование.СтруктурнаяЕдиница) = БухгалтерскийУчетКлиентСерверПереопределяемый.ТипЗначенияБанковскогоСчетаОрганизации() Тогда
				ДокументОбъект.СчетОрганизации = ДокументОснование.СтруктурнаяЕдиница;
			КонецЕсли;
		ИначеЕсли ОбщегоНазначенияБП.ЕстьРеквизитДокумента("СчетОрганизации", МетаданныеДокументаОснования) Тогда
			Если ЗначениеЗаполнено(ДокументОснование.СчетОрганизации) Тогда
				ДокументОбъект.СчетОрганизации = ДокументОснование.СчетОрганизации;
			КонецЕсли;
		ИначеЕсли ОбщегоНазначенияБП.ЕстьРеквизитДокумента("БанковскийСчет", МетаданныеДокументаОснования) Тогда
			Если ЗначениеЗаполнено(ДокументОснование.БанковскийСчет) Тогда
				ДокументОбъект.СчетОрганизации = ДокументОснование.БанковскийСчет;
			КонецЕсли;
		КонецЕсли;

	КонецЕсли;

	// Подразделение организации
	Если ОбщегоНазначенияБП.ЕстьРеквизитДокумента("ПодразделениеОрганизации", МетаданныеДокумента) Тогда

		Если КопироватьПодразделение Тогда

			Если ОбщегоНазначенияБП.ЕстьРеквизитДокумента("ПодразделениеОрганизации", МетаданныеДокументаОснования) Тогда
				ДокументОбъект.ПодразделениеОрганизации = ДокументОснование.ПодразделениеОрганизации;
			КонецЕсли;

		Иначе

			Если ОбщегоНазначенияБП.ЕстьРеквизитДокумента("СчетОрганизации", МетаданныеДокумента) Тогда
				Если ЗначениеЗаполнено(ДокументОбъект.СчетОрганизации)
					И (ДокументОбъект.СчетОрганизации.Метаданные().Реквизиты.Найти("ПодразделениеОрганизации") <> Неопределено) Тогда
					ДокументОбъект.ПодразделениеОрганизации = ДокументОбъект.СчетОрганизации.ПодразделениеОрганизации;
				КонецЕсли;
			Иначе
				ОсновноеПодразделение = БухгалтерскийУчетПереопределяемый.ПолучитьЗначениеПоУмолчанию("ОсновноеПодразделениеОрганизации");
				Если ЗначениеЗаполнено(ОсновноеПодразделение)
					И БухгалтерскийУчетПереопределяемый.ПодразделениеПринадлежитОрганизации(ОсновноеПодразделение, ДокументОбъект.Организация) Тогда
					ДокументОбъект.ПодразделениеОрганизации = ОсновноеПодразделение;
				КонецЕсли;
			КонецЕсли;

		КонецЕсли;

	КонецЕсли;

	// ВалютаДокумента.
	Если ОбщегоНазначенияБП.ЕстьРеквизитДокумента("ВалютаДокумента", МетаданныеДокумента)
	   И ОбщегоНазначенияБП.ЕстьРеквизитДокумента("ВалютаДокумента", МетаданныеДокументаОснования) Тогда

		// Если есть касса или банковский счет, то валюта должна браться только оттуда
		Если ОбщегоНазначенияБП.ЕстьРеквизитДокумента("Касса", МетаданныеДокумента) Тогда
			Если ЗначениеЗаполнено(ДокументОбъект.Касса) Тогда
				ДокументОбъект.ВалютаДокумента = ДокументОбъект.Касса.ВалютаДенежныхСредств;
			КонецЕсли;
		ИначеЕсли ОбщегоНазначенияБП.ЕстьРеквизитДокумента("БанковскийСчет", МетаданныеДокумента) Тогда
			Если ЗначениеЗаполнено(ДокументОбъект.БанковскийСчет) Тогда
				ДокументОбъект.ВалютаДокумента = ДокументОбъект.БанковскийСчет.ВалютаДенежныхСредств;
		    КонецЕсли;
		Иначе
			ДокументОбъект.ВалютаДокумента = ДокументОснование.ВалютаДокумента;
		КонецЕсли;

		// КурсДокумента.
		Если ОбщегоНазначенияБП.ЕстьРеквизитДокумента("КурсДокумента", МетаданныеДокумента) Тогда
			СтруктураКурсаДокумента = РаботаСКурсамиВалют.ПолучитьКурсВалюты(ДокументОбъект.ВалютаДокумента, ДокументОбъект.Дата);
			ДокументОбъект.КурсДокумента = СтруктураКурсаДокумента.Курс;

			// КратностьДокумента.
			Если ОбщегоНазначенияБП.ЕстьРеквизитДокумента("КратностьДокумента", МетаданныеДокумента) Тогда
				ДокументОбъект.КратностьДокумента = СтруктураКурсаДокумента.Кратность;
			КонецЕсли;
		КонецЕсли;

	КонецЕсли;

	// ТипЦен.
	Если ОбщегоНазначенияБП.ЕстьРеквизитДокумента("ТипЦен", МетаданныеДокумента)
	   И ОбщегоНазначенияБП.ЕстьРеквизитДокумента("ТипЦен", МетаданныеДокументаОснования) Тогда
		ДокументОбъект.ТипЦен = ДокументОснование.ТипЦен;
	КонецЕсли;

	// СуммаВключаетНДС.
	Если ОбщегоНазначенияБП.ЕстьРеквизитДокумента("СуммаВключаетНДС", МетаданныеДокумента)
	   И ОбщегоНазначенияБП.ЕстьРеквизитДокумента("СуммаВключаетНДС", МетаданныеДокументаОснования) Тогда
		ДокументОбъект.СуммаВключаетНДС = ДокументОснование.СуммаВключаетНДС;
	КонецЕсли;

	// НДСВключенВСтоимость.
	Если ОбщегоНазначенияБП.ЕстьРеквизитДокумента("НДСВключенВСтоимость", МетаданныеДокумента)
	   И ОбщегоНазначенияБП.ЕстьРеквизитДокумента("НДСВключенВСтоимость", МетаданныеДокументаОснования) Тогда
		ДокументОбъект.НДСВключенВСтоимость = ДокументОснование.НДСВключенВСтоимость;
	КонецЕсли;

КонецПроцедуры

///////////////////////////////////////////////////////////////////////////////
// ПРОЦЕДУРЫ И ФУНКЦИИ РАБОТЫ С ФИЗЛИЦАМИ

// Получение представления для документа, удостоверяющего личность
//
// Параметры
//  ДанныеФизЛица  - Коллекция данных физ. лица (структура, строка таблицы, ...), содержащая значения:
//                   ВидДокумента, ДокументСерия, Номер, ДатаВыдачи, КемВыдан.
//
// Возвращаемое значение:
//   Строка   - Представление документа, удостоверяющего личность.
//
Функция ПолучитьПредставлениеДокументаФизЛица(ДанныеФизЛица)

	Возврат Строка(ДанныеФизЛица.ВидДокумента) + " серия " +
			ДанныеФизЛица.Серия       + ", номер " +
			ДанныеФизЛица.Номер       + ", выданный " +
			Формат(ДанныеФизЛица.ДатаВыдачи, "ДЛФ=D")  + " " +
			ДанныеФизЛица.КемВыдан;

КонецФункции // ПолучитьПредставлениеДокументаФизЛица()

// Функция возвращает совокупность данных о физическом лице в виде структуры,
// В совокупность данных входит ФИО, должность в заданной организации,
// паспортные данные и др.
//
// Параметры:
//  Организация  - СправочникСсылка.Организации - организация, по которой
//                 определяется должность и подразделение работника
//  ФизЛицо      - СправочникСсылка.ФизическиеЛица - физическое лицо,
//                 по которому возвращается совокупность данных
//  ДатаСреза    - Дата - дата, на которую считываются данные
//  ФИОКратко    - Булево - если Истина (по умолчанию), Представление физ.лица включает фамилию и инициалы, если Ложь - фамилию и полностью имя и отчество
//
// Возвращаемое значение:
//  Структура    - Структура с совокупностью данных о физическом лице:
//                 - Фамилия
//                 - Имя
//                 - Отчество
//                 - Представление (Фамилия И.О.)
//                 - Подразделение
//                 - ВидДокумента
//                 - Серия
//                 - Номер
//                 - ДатаВыдачи
//                 - КемВыдан
//                 - КодПодразделения
//
Функция ДанныеФизЛица(Организация, ФизЛицо, ДатаСреза, ФИОКратко = Истина) Экспорт

	ЗапросПоЛицам = Новый Запрос();
	ЗапросПоЛицам.УстановитьПараметр("ДатаСреза",   ДатаСреза);
	ЗапросПоЛицам.УстановитьПараметр("Организация", ОбщегоНазначенияБПВызовСервераПовтИсп.ГоловнаяОрганизация(Организация));
	ЗапросПоЛицам.УстановитьПараметр("ФизЛицо", ФизЛицо);
	ЗапросПоЛицам.Текст =
	"ВЫБРАТЬ
	|	Физлица.Наименование КАК Представление,
	|	"""" КАК ТабельныйНомер,
	|	ДокументыФизическихЛицСрезПоследних.ВидДокумента,
	|	ДокументыФизическихЛицСрезПоследних.Серия,
	|	ДокументыФизическихЛицСрезПоследних.Номер,
	|	ДокументыФизическихЛицСрезПоследних.ДатаВыдачи,
	|	ДокументыФизическихЛицСрезПоследних.КемВыдан,
	|	ДокументыФизическихЛицСрезПоследних.КодПодразделения
	|ИЗ
	|	(ВЫБРАТЬ
	|		ФизическиеЛица.Ссылка КАК ФизЛицо,
	|		ФизическиеЛица.Наименование КАК Наименование
	|	ИЗ
	|		Справочник.ФизическиеЛица КАК ФизическиеЛица
	|	ГДЕ
	|		ФизическиеЛица.Ссылка = &ФизЛицо) КАК ФизЛица
	|		ЛЕВОЕ СОЕДИНЕНИЕ РегистрСведений.ДокументыФизическихЛиц.СрезПоследних(&ДатаСреза, ФизЛицо = &ФизЛицо) КАК ДокументыФизическихЛицСрезПоследних
	|		ПО ФизЛица.ФизЛицо = ДокументыФизическихЛицСрезПоследних.Физлицо";

	Данные = ЗапросПоЛицам.Выполнить().Выбрать();
	Данные.Следующий();

	Результат = Новый Структура("Фамилия, Имя, Отчество, Представление,
								|ТабельныйНомер, Должность, ПодразделениеОрганизации,
								|ВидДокумента, Серия, Номер,
								|ДатаВыдачи, КемВыдан, КодПодразделения,
								|ПредставлениеДокумента");

	ЗаполнитьЗначенияСвойств(Результат, Данные);
	
	// {БРУ 
	ФИО = СтроковыеФункцииКлиентСервер.РазложитьСтрокуВМассивПодстрок(СокрЛП(Результат.Представление)," ");

	КоличествоПодстрок = ФИО.Количество();
	Фамилия = ?(КоличествоПодстрок > 0,ФИО[0],"");
	Имя		= ?(КоличествоПодстрок > 1,ФИО[1],"");
	Отчество= ?(КоличествоПодстрок > 2,ФИО[2],"");
	
	Результат.Вставить("Фамилия", Фамилия);
	Результат.Вставить("Имя", Имя);
	Результат.Вставить("Отчество", Отчество);
	Результат.Вставить("Должность", "");
	Результат.Вставить("ПодразделениеОрганизации", "");
	// }БРУ

	Результат.ПредставлениеДокумента = ПолучитьПредставлениеДокументаФизЛица(Данные);

	Возврат Результат;

КонецФункции // ДанныеФизЛица

// Функция возвращает совокупность данных о физических лицах в виде таблицы
// значений. В совокупность данных входит ФИО, должность в заданной
// организации, паспортные данные и др.
//
// Параметры:
//  Организация  - СправочникСсылка.Организации - организация, по которой
//                 определяется должность и подразделение работника(ов)
//  ФизЛицо      - СправочникСсылка.ФизическиеЛица или Массив - физическое лицо
//                 или список физ. лиц, по которым возвращается совокупность
//                 данных
//  ДатаСреза    - Дата - дата, на которую считываются данные
//
// Возвращаемое значение:
//  ТаблицаЗначений - Таблица с совокупностью данных о физическом лице.
//                  Колонки: возвращаемой таблицы:
//                  - Фамилия
//                  - Имя
//                  - Отчество
//                  - Представление (Фамилия И.О.)
//                  - Подразделение
//                  - ВидДокумента
//                  - Серия
//                  - Номер
//                  - ДатаВыдачи
//                  - КемВыдан
//                  - КодПодразделения
//
Функция ДанныеФизЛиц(Организация, ФизЛицо, ДатаСреза) Экспорт

	ЗапросПоЛицам = Новый Запрос();
	ЗапросПоЛицам.УстановитьПараметр("ДатаСреза",   ДатаСреза);
	ЗапросПоЛицам.УстановитьПараметр("Организация", Организация);
	ЗапросПоЛицам.УстановитьПараметр("ФизЛицо", ФизЛицо);
	ЗапросПоЛицам.Текст =
	"ВЫБРАТЬ
	|	"""" КАК ТабельныйНомер,
	|	ФизЛица.Наименование КАК Представление,
	|	ДокументыФизическихЛицСрезПоследних.ВидДокумента,
	|	ДокументыФизическихЛицСрезПоследних.Серия,
	|	ДокументыФизическихЛицСрезПоследних.Номер,
	|	ДокументыФизическихЛицСрезПоследних.ДатаВыдачи,
	|	ДокументыФизическихЛицСрезПоследних.КемВыдан,
	|	ДокументыФизическихЛицСрезПоследних.КодПодразделения
	|ИЗ
	|	(ВЫБРАТЬ
	|		ФизическиеЛица.Ссылка КАК ФизЛицо,
	|		ФизическиеЛица.Наименование КАК Наименование
	|	ИЗ
	|		Справочник.ФизическиеЛица КАК ФизическиеЛица
	|	ГДЕ
	|		ФизическиеЛица.Ссылка В(&ФизЛицо)) КАК ФизЛица
	|		ЛЕВОЕ СОЕДИНЕНИЕ РегистрСведений.ДокументыФизическихЛиц.СрезПоследних(&ДатаСреза, ФизЛицо В (&ФизЛицо)) КАК ДокументыФизическихЛицСрезПоследних
	|		ПО ФизЛица.ФизЛицо = ДокументыФизическихЛицСрезПоследних.Физлицо";


	Данные = ЗапросПоЛицам.Выполнить().Выбрать();

	ТабРезультат = Новый ТаблицаЗначений();
	ТабРезультат.Колонки.Добавить("Фамилия");
	ТабРезультат.Колонки.Добавить("Имя");
	ТабРезультат.Колонки.Добавить("Отчество");
	ТабРезультат.Колонки.Добавить("Представление");
	ТабРезультат.Колонки.Добавить("ТабельныйНомер");
	ТабРезультат.Колонки.Добавить("Должность");
	ТабРезультат.Колонки.Добавить("ПодразделениеОрганизации");
	ТабРезультат.Колонки.Добавить("ВидДокумента");
	ТабРезультат.Колонки.Добавить("Серия");
	ТабРезультат.Колонки.Добавить("Номер");
	ТабРезультат.Колонки.Добавить("ДатаВыдачи");
	ТабРезультат.Колонки.Добавить("КемВыдан");
	ТабРезультат.Колонки.Добавить("КодПодразделения");
	ТабРезультат.Колонки.Добавить("ПредставлениеДокумента");

	Пока Данные.Следующий() Цикл

		Результат = ТабРезультат.Добавить();

		ЗаполнитьЗначенияСвойств(Результат, Данные);

		// {БРУ 
		ФИО = СтроковыеФункцииКлиентСервер.РазложитьСтрокуВМассивПодстрок(СокрЛП(Результат.Представление)," ");

		КоличествоПодстрок = ФИО.Количество();
		Фамилия = ?(КоличествоПодстрок > 0,ФИО[0],"");
		Имя		= ?(КоличествоПодстрок > 1,ФИО[1],"");
		Отчество= ?(КоличествоПодстрок > 2,ФИО[2],"");
		
		Результат.Фамилия 	= Фамилия;
		Результат.Имя 		= Имя;
		Результат.Отчество	= Отчество;
		Результат.Должность	= "";
		Результат.ПодразделениеОрганизации = "";
		// }БРУ
		
		Результат.ПредставлениеДокумента = ПолучитьПредставлениеДокументаФизЛица(Данные);

	КонецЦикла;

	Возврат ТабРезультат;

КонецФункции // ДанныеФизЛиц
