
#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	Если Параметры.Свойство("АвтоТест") Тогда // Возврат при получении формы для анализа.
		Возврат;
	КонецЕсли;

	Если Параметры.Свойство("Отбор") Тогда
		
		ИспользуетсяСкладОтгрузки = Неопределено;
		Если Параметры.Отбор.Свойство("ИспользуетсяСкладОтгрузки", ИспользуетсяСкладОтгрузки) Тогда
			
			Если Не ИспользуетсяСкладОтгрузки Тогда
				Параметры.Отбор.Удалить("СкладОтгрузки");
			КонецЕсли;
			Параметры.Отбор.Удалить("ИспользуетсяСкладОтгрузки");
			
		КонецЕсли;
		
		Если Параметры.Отбор.Свойство("СкладОтгрузки") Тогда
			Параметры.Отбор.Склад = Параметры.Отбор.СкладОтгрузки;
		КонецЕсли;
		
		Если Не ЗначениеЗаполнено(Параметры.Отбор.Склад) Тогда
			Параметры.Отбор.Удалить("Склад");
		КонецЕсли;
		
		Если Параметры.Отбор.Свойство("ДокументРеализации") Тогда
			Если Параметры.Отбор.ДокументРеализации = Неопределено Тогда
				Параметры.Отбор.Удалить("ДокументРеализации");
				ПоДокументуРеализации = Ложь;
			Иначе
				ПоДокументуРеализации = Истина;
			КонецЕсли;
		КонецЕсли;
		
	КонецЕсли;
	
	Элементы.ТаблицаВидовЗапасовОстаток.Видимость = Не ПоДокументуРеализации;
	Элементы.ТаблицаВидовЗапасовПродано.Видимость = ПоДокументуРеализации;
	
	ЗаполнитьТаблицаВидовЗапасов();
	
	СобытияФорм.ПриСозданииНаСервере(ЭтаФорма, Отказ, СтандартнаяОбработка);
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовШапкиФормы

&НаКлиенте
Процедура СписокВыбор(Элемент, ВыбраннаяСтрока, Поле, СтандартнаяОбработка)
	
	СтандартнаяОбработка = Ложь;
	
	СтрокаТаблицы = Элемент.ТекущиеДанные;
	Если СтрокаТаблицы <> Неопределено Тогда
		ОповеститьОВыборе(СтрокаТаблицы.Ссылка);
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ВыполнитьВыбор(Команда)

	Закрыть(КодВозвратаДиалога.OK);
	
	СтрокаТаблицы = Элементы.ТаблицаВидовЗапасов.ТекущиеДанные;
	Если СтрокаТаблицы <> Неопределено Тогда
		ОповеститьОВыборе(СтрокаТаблицы.Ссылка);
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура Обновить(Команда)
	ЗаполнитьТаблицаВидовЗапасов();
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура Подключаемый_ВыполнитьПереопределяемуюКоманду(Команда)
	
	СобытияФормКлиент.ВыполнитьПереопределяемуюКоманду(ЭтаФорма, Команда);
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

#Область Прочее

&НаСервере
Процедура ЗаполнитьТаблицаВидовЗапасов()
	
	Запрос = Новый Запрос();
	ТекстЗапроса = 
	"ВЫБРАТЬ
	|	ТоварыОрганизаций.АналитикаУчетаНоменклатуры КАК АналитикаУчетаНоменклатуры,
	|	ВидыЗапасов.Ссылка КАК Ссылка,
	|	ВидыЗапасов.РеализацияЗапасовДругойОрганизации КАК РеализацияЗапасовДругойОрганизации,
	|	ВидыЗапасов.ПометкаУдаления КАК ПометкаУдаления,
	|	ВидыЗапасов.Предопределенный КАК Предопределенный,
	|	ВидыЗапасов.Наименование КАК Наименование,
	|	ВидыЗапасов.ТипЗапасов КАК ТипЗапасов,
    |	ВидыЗапасов.НалоговоеНазначение КАК НалоговоеНазначение,
	|	ВидыЗапасов.ВладелецТовара КАК ВладелецТовара,
	|	ВидыЗапасов.Соглашение КАК Соглашение,
	|	ВидыЗапасов.Валюта КАК Валюта,
	|	ВидыЗапасов.Организация КАК Организация,
	|	ТоварыОрганизаций.АналитикаУчетаНоменклатуры.Номенклатура КАК Номенклатура,
	|	ТоварыОрганизаций.АналитикаУчетаНоменклатуры.Характеристика КАК Характеристика,
	|	ТоварыОрганизаций.АналитикаУчетаНоменклатуры.Серия КАК Серия,
	|	ТоварыОрганизаций.АналитикаУчетаНоменклатуры.МестоХранения КАК Склад
	|ПОМЕСТИТЬ ВТВидыЗапасов
	|ИЗ
	|	РегистрНакопления.ТоварыОрганизаций.ОстаткиИОбороты(&МоментВремени, &МоментВремени, Период, , ) КАК ТоварыОрганизаций
	|		ЛЕВОЕ СОЕДИНЕНИЕ Справочник.ВидыЗапасов КАК ВидыЗапасов
	|		ПО (ВидыЗапасов.Ссылка = ТоварыОрганизаций.ВидЗапасов)
	|
	|//&УсловияВТВидыЗапасов
	|
	|
	|ИНДЕКСИРОВАТЬ ПО
	|	Ссылка,
	|	АналитикаУчетаНоменклатуры
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ
	|	РеализованныеТовары.ВидЗапасов КАК ВидЗапасов,
	|	РеализованныеТовары.АналитикаУчетаНоменклатуры КАК АналитикаУчетаНоменклатуры,
	|	РеализованныеТовары.Регистратор КАК ДокументРеализации,
	|	ЕСТЬNULL(РеализованныеТовары.КоличествоРасход, 0) КАК Продано
	|ПОМЕСТИТЬ ВТРеализованныеТовары
	|ИЗ
	|	РегистрНакопления.ТоварыОрганизаций.Обороты(
	|			,
	|			,
	|			Регистратор,
	|			&ПоДокументуРеализации
	|				И (ВидЗапасов, АналитикаУчетаНоменклатуры) В
	|					(ВЫБРАТЬ
	|						Таблица.Ссылка КАК ВидЗапасов,
	|						Таблица.АналитикаУчетаНоменклатуры
	|					ИЗ
	|						ВТВидыЗапасов КАК Таблица)) КАК РеализованныеТовары
	|
	|ИНДЕКСИРОВАТЬ ПО
	|	ВидЗапасов,
	|	АналитикаУчетаНоменклатуры
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ
	|	Остатки.ВидЗапасов КАК ВидЗапасов,
	|	Остатки.АналитикаУчетаНоменклатуры КАК АналитикаУчетаНоменклатуры,
	|	ЕСТЬNULL(Остатки.КоличествоОстаток, 0) КАК Остаток
	|ПОМЕСТИТЬ ВТОстатки
	|ИЗ
	|	РегистрНакопления.ТоварыОрганизаций.Остатки(
	|			,
	|			(ВидЗапасов, АналитикаУчетаНоменклатуры) В
	|				(ВЫБРАТЬ
	|					Таблица.Ссылка КАК ВидЗапасов,
	|					Таблица.АналитикаУчетаНоменклатуры
	|				ИЗ
	|					ВТВидыЗапасов КАК Таблица)) КАК Остатки
	|
	|ИНДЕКСИРОВАТЬ ПО
	|	ВидЗапасов,
	|	АналитикаУчетаНоменклатуры
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ РАЗЛИЧНЫЕ
	|	ВидыЗапасов.Ссылка КАК Ссылка,
	|	ВидыЗапасов.ПометкаУдаления КАК ПометкаУдаления,
	|	ВидыЗапасов.Предопределенный КАК Предопределенный,
	|	ВидыЗапасов.Наименование КАК Наименование,
	|	ВидыЗапасов.ТипЗапасов КАК ТипЗапасов,
    |	ВидыЗапасов.НалоговоеНазначение КАК НалоговоеНазначение,
	|	ВидыЗапасов.ВладелецТовара КАК ВладелецТовара,
	|	ВидыЗапасов.Соглашение КАК Соглашение,
	|	ВидыЗапасов.Валюта КАК Валюта,
	|	ВидыЗапасов.Организация КАК Организация,
	|	ВидыЗапасов.Номенклатура КАК Номенклатура,
	|	ВидыЗапасов.Характеристика КАК Характеристика,
	|	ВидыЗапасов.Серия КАК Серия,
	|	ВидыЗапасов.Склад КАК Склад,
	|	РеализованныеТовары.ДокументРеализации КАК ДокументРеализации,
	|	ЕСТЬNULL(Остатки.Остаток, 0) КАК Остаток,
	|	ЕСТЬNULL(РеализованныеТовары.Продано, 0) КАК Продано,
	|	ЕСТЬNULL(СправочникНоменклатура.ЕдиницаИзмерения, НЕОПРЕДЕЛЕНО) КАК ЕдиницаИзмерения
	|ИЗ
	|	ВТВидыЗапасов КАК ВидыЗапасов
	|		ЛЕВОЕ СОЕДИНЕНИЕ Справочник.Номенклатура КАК СправочникНоменклатура
	|		ПО ВидыЗапасов.Номенклатура = СправочникНоменклатура.Ссылка
	|		ЛЕВОЕ СОЕДИНЕНИЕ ВТРеализованныеТовары КАК РеализованныеТовары
	|		ПО ВидыЗапасов.Ссылка = РеализованныеТовары.ВидЗапасов
	|			И ВидыЗапасов.АналитикаУчетаНоменклатуры = РеализованныеТовары.АналитикаУчетаНоменклатуры
	|		ЛЕВОЕ СОЕДИНЕНИЕ ВТОстатки КАК Остатки
	|		ПО ВидыЗапасов.Ссылка = Остатки.ВидЗапасов
	|			И ВидыЗапасов.АналитикаУчетаНоменклатуры = Остатки.АналитикаУчетаНоменклатуры
	|ГДЕ
	|	НЕ ВидыЗапасов.РеализацияЗапасовДругойОрганизации
	|	И НЕ ВидыЗапасов.ПометкаУдаления
	|	//&УсловияТаблицаВыборки";
	
	ПараметрыЗапроса = Новый Структура();
	ПараметрыЗапроса.Вставить("Номенклатура",          Справочники.Номенклатура.ПустаяСсылка());
	ПараметрыЗапроса.Вставить("Характеристика",        Справочники.ХарактеристикиНоменклатуры.ПустаяСсылка());
	ПараметрыЗапроса.Вставить("Серия",                 Справочники.СерииНоменклатуры.ПустаяСсылка());
	ПараметрыЗапроса.Вставить("Склад",                 Справочники.Склады.ПустаяСсылка());
	ПараметрыЗапроса.Вставить("Организация",           Справочники.Организации.ПустаяСсылка());
	ПараметрыЗапроса.Вставить("ПоДокументуРеализации", Ложь);
	ПараметрыЗапроса.Вставить("ДокументРеализации",    Неопределено);
	ПараметрыЗапроса.Вставить("МоментВремени",         Дата(1, 1, 1));
	
	УсловияЗапросаВТВидыЗапасов = Новый Структура();
	УсловияЗапросаВТВидыЗапасов.Вставить("Номенклатура",   "ТоварыОрганизаций.АналитикаУчетаНоменклатуры.Номенклатура = &Номенклатура");
	УсловияЗапросаВТВидыЗапасов.Вставить("Характеристика", "ТоварыОрганизаций.АналитикаУчетаНоменклатуры.Характеристика = &Характеристика");
	УсловияЗапросаВТВидыЗапасов.Вставить("Серия",          "ТоварыОрганизаций.АналитикаУчетаНоменклатуры.Серия = &Серия");
	УсловияЗапросаВТВидыЗапасов.Вставить("Склад",          "ТоварыОрганизаций.АналитикаУчетаНоменклатуры.МестоХранения = &Склад");
	УсловияЗапросаВТВидыЗапасов.Вставить("Организация",    "ВидыЗапасов.Организация = &Организация");
	
	УсловияЗапросаТаблицаВыборки = Новый Структура();
	УсловияЗапросаТаблицаВыборки.Вставить("ДокументРеализации", "РеализованныеТовары.ДокументРеализации = &ДокументРеализации");
	
	Для Каждого ПараметрЗапроса Из ПараметрыЗапроса Цикл
		Если Параметры.Отбор.Свойство(ПараметрЗапроса.Ключ)
			И ЗначениеЗаполнено(Параметры.Отбор.Свойство(ПараметрЗапроса.Ключ)) Тогда
			ПараметрыЗапроса[ПараметрЗапроса.Ключ] = Параметры.Отбор[ПараметрЗапроса.Ключ];
		КонецЕсли;
	КонецЦикла;
	
	Если Параметры.Отбор.Свойство("ИспользуетсяСкладОтгрузки")
		И Параметры.Отбор.ИспользуетсяСкладОтгрузки
		И Параметры.Отбор.Свойство("СкладОтгрузки")
		И ЗначениеЗаполнено(Параметры.Отбор.СкладОтгрузки) Тогда
		ПараметрыЗапроса.Склад = Параметры.Отбор.СкладОтгрузки;
	КонецЕсли;
	
	Если ЗначениеЗаполнено(ПараметрыЗапроса.ДокументРеализации) Тогда
		ПараметрыЗапроса.МоментВремени = ПараметрыЗапроса.ДокументРеализации.МоментВремени();
	КонецЕсли;
	
	Если Параметры.Отбор.Свойство("ДокументРеализации")
		И ЗначениеЗаполнено(Параметры.Отбор.ДокументРеализации) Тогда
		ПараметрыЗапроса.ПоДокументуРеализации = Истина;
	КонецЕсли;
	
	МассивУсловийВТВидыЗапасов = Новый Массив();
	МассивУсловийТаблицаВыборка = Новый Массив();
	
	Для Каждого ПараметрЗапроса Из ПараметрыЗапроса Цикл
		
		Если УсловияЗапросаВТВидыЗапасов.Свойство(ПараметрЗапроса.Ключ)
			И ЗначениеЗаполнено(ПараметрЗапроса.Значение) Тогда
			МассивУсловийВТВидыЗапасов.Добавить(УсловияЗапросаВТВидыЗапасов[ПараметрЗапроса.Ключ]);
			Запрос.УстановитьПараметр(ПараметрЗапроса.Ключ, ПараметрЗапроса.Значение);
		ИначеЕсли УсловияЗапросаТаблицаВыборки.Свойство(ПараметрЗапроса.Ключ)
			И ЗначениеЗаполнено(ПараметрЗапроса.Значение) Тогда
			МассивУсловийТаблицаВыборка.Добавить(УсловияЗапросаТаблицаВыборки[ПараметрЗапроса.Ключ]);
			Запрос.УстановитьПараметр(ПараметрЗапроса.Ключ, ПараметрЗапроса.Значение);
		Иначе
			Запрос.УстановитьПараметр(ПараметрЗапроса.Ключ, ПараметрЗапроса.Значение);
		КонецЕсли;
		
	КонецЦикла;
	
	ТекстУсловийВТВидыЗапасов  = СтрСоединить(МассивУсловийВТВидыЗапасов, " И ");
	ТекстУсловийТаблицаВыборки = СтрСоединить(МассивУсловийТаблицаВыборка, " И ");
	
	Если ТекстУсловийВТВидыЗапасов <> "" Тогда
		ТекстЗапроса = СтрЗаменить(ТекстЗапроса, "//&УсловияВТВидыЗапасов", "ГДЕ " + ТекстУсловийВТВидыЗапасов);
	КонецЕсли;
	
	Если ТекстУсловийТаблицаВыборки <> "" Тогда
		ТекстЗапроса = СтрЗаменить(ТекстЗапроса, "//&УсловияТаблицаВыборки", " И " + ТекстУсловийТаблицаВыборки);
	КонецЕсли;
	
	Запрос.Текст = ТекстЗапроса;
	
	Результат = Запрос.Выполнить().Выгрузить();
	
	ТаблицаВидовЗапасов.Загрузить(Результат);
	
КонецПроцедуры

#КонецОбласти

#КонецОбласти
