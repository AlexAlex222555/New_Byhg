////////////////////////////////////////////////////////////////////////////////
// Процедуры подсистемы "Производство"
// 
////////////////////////////////////////////////////////////////////////////////

#Область ПрограммныйИнтерфейс

// Переопределяемый обработчик получения данных выбора справочника СтруктураПредприятия.
//
// Параметры:
//  ДанныеВыбора - СписокЗначений - значения выбора.
//  Параметры - Структура - параметры выбора.
//  СтандартнаяОбработка - Булево - признак выполнения стандартной (системной) обработки события.
//
Процедура СтруктураПредприятияОбработкаПолученияДанныхВыбора(ДанныеВыбора, Параметры, СтандартнаяОбработка) Экспорт
	
	СтандартнаяОбработка = Ложь;
	Если ЗначениеЗаполнено(Параметры.СтрокаПоиска) Тогда
		
		Запрос = Новый Запрос;
		Запрос.Текст = 
		"ВЫБРАТЬ РАЗРЕШЕННЫЕ ПЕРВЫЕ 51
		|	СтруктураПредприятия.Ссылка КАК Ссылка,
		|	СтруктураПредприятия.Представление КАК Представление
		|ИЗ
		|	Справочник.СтруктураПредприятия КАК СтруктураПредприятия
		|ГДЕ
		|	СтруктураПредприятия.Наименование ПОДОБНО &Текст
		|	И НЕ СтруктураПредприятия.ПометкаУдаления
		|	И (СтруктураПредприятия.ПодразделениеДиспетчер
		|			ИЛИ СтруктураПредприятия.ПроизводственноеПодразделение)
		|
		|УПОРЯДОЧИТЬ ПО
		|	Представление";
		
		Запрос.УстановитьПараметр("Текст", "%" + СокрЛП(Параметры.СтрокаПоиска) + "%");
		
		Результат = Запрос.Выполнить();
		Выборка = Результат.Выбрать();
		
		ДанныеВыбора = Новый СписокЗначений;
		Пока Выборка.Следующий() Цикл
			ДанныеВыбора.Добавить(Выборка.Ссылка, Выборка.Представление);
		КонецЦикла; 
								
	КонецЕсли;
	
КонецПроцедуры

// Возвращает параметры производственного подразделения
//
// Параметры:
//  Подразделение	- СправочникСсылка.СтруктураПредприятия - Подразделение для которого требуется получить параметры.
//
// Возвращаемое значение:
//   Структура   - содержит параметры производственного подразделения.
//
Функция ПараметрыПроизводственногоПодразделения(Подразделение) Экспорт
	
	Параметры = ПроизводствоСервер.ПараметрыПроизводственногоПодразделения(Подразделение);
	Возврат Параметры;
	
КонецФункции

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

#Область РасчетДолейСтоимости

Функция ДоступнаРасшифровкаРасчетаДолиСтоимости(СпособРаспределенияЗатратНаВыходныеИзделия) Экспорт
	
	Если СпособРаспределенияЗатратНаВыходныеИзделия = Перечисления.СпособыРаспределенияЗатратНаВыходныеИзделия.ПоПлановойСтоимости Тогда
		ЕстьДоступ = ПравоДоступа("Просмотр", Метаданные.РегистрыСведений.ЦеныНоменклатуры);
	Иначе
		ЕстьДоступ = Истина;
	КонецЕсли;
	
	Возврат ЕстьДоступ;
	
КонецФункции

#КонецОбласти

Функция ДоступноРабочееМестоЗаказыПереработчикам() Экспорт

	Если ПолучитьФункциональнуюОпцию("ИспользоватьПроизводство")
		И Пользователи.РолиДоступны("ИспользованиеРабочегоМестаЗаказыПереработчикам") Тогда
		
		Возврат Истина;
	КонецЕсли;

	Возврат Ложь;
	
КонецФункции

//++ НЕ УТ

Функция ПараметрыСозданияДвиженияПродукцииИМатериаловНаОсновании(МассивЗаказов, ХозяйственнаяОперация) Экспорт
	
	ОбъектыОснований = МассивЗаказов;
	
	РеквизитыШапки = Документы.ДвижениеПродукцииИМатериалов.ДанныеЗаполненияНакладной(ОбъектыОснований, Новый Структура("ХозяйственнаяОперация", ХозяйственнаяОперация));
	РезультатыПроверки = Документы.ДвижениеПродукцииИМатериалов.ПроверитьДанныеЗаполненияНакладной(РеквизитыШапки);
	
	ПараметрыОснования = Новый Структура;
	Если РеквизитыШапки.ПоРаспоряжениям Тогда
		ПараметрыОснования.Вставить("РеквизитыШапки", РеквизитыШапки);
		ПараметрыОснования.Вставить("МассивЗаказов",  ОбъектыОснований);
	Иначе
		ПараметрыОснования.Вставить("ОбъектыОснований", ОбъектыОснований);
		ПараметрыОснования.Вставить("ХозяйственнаяОперация", РеквизитыШапки.ХозяйственнаяОперация);
	КонецЕсли;
	
	Возврат Новый Структура("Основание, РезультатыПроверки", ПараметрыОснования, РезультатыПроверки);
	
КонецФункции

Функция ДокументыДвиженияПродукцииИМатериаловПоПараметрам(ПараметрыДокументов) Экспорт
	
	// СтандартныеПодсистемы.ЗамерПроизводительности
	ОписаниеЗамера = ОценкаПроизводительности.НачатьЗамерДлительнойОперации(
		"ОбщийМодуль.ПроизводствоВызовСервера.ДокументыДвиженияПродукцииИМатериаловПоПараметрам");
	// Конец СтандартныеПодсистемы.ЗамерПроизводительности
	
	МассивОбъектов = Документы.ДвижениеПродукцииИМатериалов.ДокументыПоПараметрам(ПараметрыДокументов);
	Результат = Новый Структура;
	
	Если МассивОбъектов.Количество() = 1 Тогда
		ЗначениеВДанныеФормы(МассивОбъектов[0], ПараметрыДокументов.ОбъектФормы);
		Результат.Вставить("ОткрытьФормуНового");
	Иначе
		
		СозданныеДокументы = Новый Массив;
		Для Каждого ТекДокумент Из МассивОбъектов Цикл
			ТекДокумент.Записать(РежимЗаписиДокумента.Запись);
			СозданныеДокументы.Добавить(ТекДокумент.Ссылка);
		КонецЦикла;
		
		Если СозданныеДокументы.Количество() > 1 Тогда
			
			ПараметрыФормы = Новый Структура("КлючДанных, ВидимыеКолонки, СобытияОбновления",
				"ВыпускПродукцииБезЗаказаНаОсновании", Новый Массив, Новый Массив);
			
			ПараметрыФормы.ВидимыеКолонки.Добавить("Номер");
			ПараметрыФормы.ВидимыеКолонки.Добавить("Дата");
			ПараметрыФормы.ВидимыеКолонки.Добавить("ТипЗначения");
			ПараметрыФормы.ВидимыеКолонки.Добавить("ХозяйственнаяОперация");
			ПараметрыФормы.ВидимыеКолонки.Добавить("Организация");
			ПараметрыФормы.ВидимыеКолонки.Добавить("Подразделение");
			ПараметрыФормы.ВидимыеКолонки.Добавить("НаправлениеДеятельности");
			Если ПолучитьФункциональнуюОпцию("ИспользоватьСтатусыДвиженийПродукцииИМатериалов") Тогда
				ПараметрыФормы.ВидимыеКолонки.Добавить("Статус");
			КонецЕсли;
			ПараметрыФормы.ВидимыеКолонки.Добавить("Дополнительно");
			
			ПараметрыФормы.СобытияОбновления.Добавить("Запись_ДвижениеПродукцииИМатериалов");
			
			Результат.Вставить("ИмяФормы", "ОбщаяФорма.ФормаСозданныхДокументов");
			Результат.Вставить("Параметры", ПараметрыФормы);
			
			Владелец = Пользователи.АвторизованныйПользователь();
			УстановитьПривилегированныйРежим(Истина);
			ОбщегоНазначения.ЗаписатьДанныеВБезопасноеХранилище(Владелец, СозданныеДокументы, ПараметрыФормы.КлючДанных);
			УстановитьПривилегированныйРежим(Ложь);
			
		КонецЕсли;
		
		Результат.Вставить("КоличествоСозданныхДокументов", СозданныеДокументы.Количество());
		
	КонецЕсли;
	
	// СтандартныеПодсистемы.ЗамерПроизводительности
	КоличествоОпераций = ПараметрыДокументов.ОбъектыОснований.Количество();
	ОценкаПроизводительности.ЗакончитьЗамерДлительнойОперации(ОписаниеЗамера, КоличествоОпераций);
	// Конец СтандартныеПодсистемы.ЗамерПроизводительности
	
	Возврат Результат;
	
	
КонецФункции

Функция СоздатьАктВыполненныхВнутреннихРаботПроверкаОснований(ОбъектыОснований) Экспорт
	
	ТекстыЗапросов = Новый Массив;
	ТекстЗапроса =
	// Получатели выходных изделий (производство без заказа)
	"ВЫБРАТЬ
	|	Реквизиты.Организация				КАК Организация,
	|	Реквизиты.НаправлениеДеятельности	КАК НаправлениеДеятельности,
	|	ТаблицаТоваров.Получатель			КАК Подразделение
	|ПОМЕСТИТЬ ВтТовары
	|ИЗ
	|	Документ.ПроизводствоБезЗаказа.ВыходныеИзделия КАК ТаблицаТоваров
	|		ЛЕВОЕ СОЕДИНЕНИЕ Документ.ПроизводствоБезЗаказа КАК Реквизиты
	|		ПО ТаблицаТоваров.Ссылка = Реквизиты.Ссылка
	|		ЛЕВОЕ СОЕДИНЕНИЕ Справочник.Номенклатура КАК СпрНоменклатура
	|		ПО ТаблицаТоваров.Номенклатура = СпрНоменклатура.Ссылка
	|ГДЕ
	|	ТаблицаТоваров.Ссылка В(&ОбъектыОснований)
	|	И СпрНоменклатура.ТипНоменклатуры = ЗНАЧЕНИЕ(Перечисление.ТипыНоменклатуры.Работа)
	|	И ТаблицаТоваров.НаправлениеВыпуска = ЗНАЧЕНИЕ(Перечисление.ХозяйственныеОперации.ВыпускПродукцииВПодразделение)
	|
	|СГРУППИРОВАТЬ ПО
	|	Реквизиты.НаправлениеДеятельности,
	|	ТаблицаТоваров.Получатель,
	|	Реквизиты.Организация
	|
	|ОБЪЕДИНИТЬ ВСЕ
	|
	// Получатели побочных изделий (производство без заказа)
	|ВЫБРАТЬ
	|	Реквизиты.Организация				КАК Организация,
	|	Реквизиты.НаправлениеДеятельности	КАК НаправлениеДеятельности,
	|	ТаблицаТоваров.Получатель			КАК Подразделение
	|ИЗ
	|	Документ.ПроизводствоБезЗаказа.ПобочныеИзделия КАК ТаблицаТоваров
	|		ЛЕВОЕ СОЕДИНЕНИЕ Документ.ПроизводствоБезЗаказа КАК Реквизиты
	|		ПО ТаблицаТоваров.Ссылка = Реквизиты.Ссылка
	|		ЛЕВОЕ СОЕДИНЕНИЕ Справочник.Номенклатура КАК СпрНоменклатура
	|		ПО ТаблицаТоваров.Номенклатура = СпрНоменклатура.Ссылка
	|ГДЕ
	|	ТаблицаТоваров.Ссылка В(&ОбъектыОснований)
	|	И СпрНоменклатура.ТипНоменклатуры = ЗНАЧЕНИЕ(Перечисление.ТипыНоменклатуры.Работа)
	|	И ТаблицаТоваров.НаправлениеВыпуска = ЗНАЧЕНИЕ(Перечисление.ХозяйственныеОперации.ВыпускПродукцииВПодразделение)
	|
	|СГРУППИРОВАТЬ ПО
	|	Реквизиты.НаправлениеДеятельности,
	|	ТаблицаТоваров.Получатель,
	|	Реквизиты.Организация
	|";
	ТекстыЗапросов.Добавить(ТекстЗапроса);
	
	Запрос = Новый Запрос;
	Запрос.Текст = СтрСоединить(ТекстыЗапросов, ОбщегоНазначенияУТ.РазделительЗапросовВОбъединении());
	Запрос.Текст = Запрос.Текст + "
	|;
	|ВЫБРАТЬ
	|	МАКСИМУМ(ТаблицаТоваров.Организация)							КАК Организация,
	|	МАКСИМУМ(ТаблицаТоваров.НаправлениеДеятельности)				КАК НаправлениеДеятельности,
	|	МАКСИМУМ(ТаблицаТоваров.Подразделение)							КАК Подразделение,
	|	КОЛИЧЕСТВО(РАЗЛИЧНЫЕ ТаблицаТоваров.Организация)				КАК РазличныеОрганизации,
	|	КОЛИЧЕСТВО(РАЗЛИЧНЫЕ ТаблицаТоваров.НаправлениеДеятельности)	КАК РазличныеНаправленияДеятельности,
	|	КОЛИЧЕСТВО(РАЗЛИЧНЫЕ ТаблицаТоваров.Подразделение)				КАК РазличныеПолучатели
	|ИЗ
	|	ВтТовары КАК ТаблицаТоваров
	|ИМЕЮЩИЕ
	|	МАКСИМУМ(ТаблицаТоваров.Организация) ЕСТЬ НЕ NULL";
	
	Запрос.УстановитьПараметр("ОбъектыОснований", ОбъектыОснований);
	
	Ошибки = Запрос.Выполнить().Выбрать();
	РеквизитыШапки = Новый Структура("Организация, НаправлениеДеятельности, Подразделение");
	Результат = Новый Структура;
	
	Если Ошибки.Следующий() Тогда
		
		ЕстьОшибки = Ложь;
		ТекстОшибки = НСтр("ru='В документах-основаниях различаются значения:';uk='У документах-підставах розрізняються значення:'");
		Если Не Ошибки.РазличныеОрганизации = 1 Тогда
			ТекстОшибки = ТекстОшибки + Символы.ПС + НСтр("ru='- Организаций';uk='- Організацій'");
			ЕстьОшибки = Истина;
		КонецЕсли;
		
		Если Не Ошибки.РазличныеПолучатели = 1 Тогда
			ТекстОшибки = ТекстОшибки + Символы.ПС + НСтр("ru='- Получателей работ';uk='- Одержувачів робіт'");
			ЕстьОшибки = Истина;
		КонецЕсли;
		
		Если Не Ошибки.РазличныеНаправленияДеятельности = 1 Тогда
			ТекстОшибки = ТекстОшибки + Символы.ПС + НСтр("ru='- Направлений деятельности';uk='- Напрямів діяльності'");
			ЕстьОшибки = Истина;
		КонецЕсли;
		
		Если ЕстьОшибки Тогда
			ТекстОшибки = ТекстОшибки + Символы.ПС + НСтр("ru='Оформление документа невозможно!';uk='Оформлення документа неможливо!'");
			Результат.Вставить("ЕстьОшибки");
			Результат.Вставить("ТекстОшибки", ТекстОшибки);
		Иначе
			ЗаполнитьЗначенияСвойств(РеквизитыШапки, Ошибки);
		КонецЕсли;
	Иначе
		ТекстОшибки = НСтр("ru='Отсутствуют данные для заполнения!';uk='Відсутні дані для заповнення!'");
		Результат.Вставить("ЕстьОшибки");
		Результат.Вставить("ТекстОшибки", ТекстОшибки);
	КонецЕсли;
	Результат.Вставить("РеквизитыШапки", РеквизитыШапки);
	
	Возврат Результат;
	
КонецФункции

//-- НЕ УТ

#КонецОбласти
