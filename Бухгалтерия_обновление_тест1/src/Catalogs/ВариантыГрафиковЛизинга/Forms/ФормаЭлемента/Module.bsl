
#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	Если Параметры.Свойство("АвтоТест") Тогда // Возврат при получении формы для анализа.
		Возврат;
	КонецЕсли;
	
	ОбновлениеИнформационнойБазы.ПроверитьОбъектОбработан(Объект, ЭтотОбъект);
	
	СсылкаКопирования = Параметры.ЗначениеКопирования;
	Если Не СсылкаКопирования.Пустая() Тогда
		ПрочитатьНаборГрафика("ГрафикОплат", СсылкаКопирования);
		ПрочитатьНаборГрафика("ГрафикНачислений", СсылкаКопирования);
	КонецЕсли;
	
	Если Не ЗначениеЗаполнено(Объект.Ссылка) Тогда
		ПриЧтенииСозданииНаСервере();
	КонецЕсли;
	
	// СтандартныеПодсистемы.ПодключаемыеКоманды
	ПодключаемыеКоманды.ПриСозданииНаСервере(ЭтотОбъект);
	// Конец СтандартныеПодсистемы.ПодключаемыеКоманды
	
	СобытияФорм.ПриСозданииНаСервере(ЭтаФорма, Отказ, СтандартнаяОбработка);
	
КонецПроцедуры

&НаСервере
Процедура ПриЧтенииНаСервере(ТекущийОбъект)
	
	// СтандартныеПодсистемы.УправлениеДоступом
	Если ОбщегоНазначения.ПодсистемаСуществует("СтандартныеПодсистемы.УправлениеДоступом") Тогда
		МодульУправлениеДоступом = ОбщегоНазначения.ОбщийМодуль("УправлениеДоступом");
		МодульУправлениеДоступом.ПриЧтенииНаСервере(ЭтотОбъект, ТекущийОбъект);
	КонецЕсли;
	// Конец СтандартныеПодсистемы.УправлениеДоступом
	
	ПрочитатьНаборГрафика("ГрафикОплат", ТекущийОбъект.Ссылка);
	ПрочитатьНаборГрафика("ГрафикНачислений", ТекущийОбъект.Ссылка);
	
	ОбновитьСвязанныеДанные();
	
	ПриЧтенииСозданииНаСервере();
	
	МодификацияКонфигурацииПереопределяемый.ПриЧтенииНаСервере(ЭтаФорма, ТекущийОбъект);
	
	// СтандартныеПодсистемы.ПодключаемыеКоманды
	ПодключаемыеКомандыКлиентСервер.ОбновитьКоманды(ЭтотОбъект, Объект);
	// Конец СтандартныеПодсистемы.ПодключаемыеКоманды
	
КонецПроцедуры

&НаСервере
Процедура ПередЗаписьюНаСервере(Отказ, ТекущийОбъект, ПараметрыЗаписи)
	
	ТекущийОбъект.АвторИзменения = ПользователиКлиентСервер.ТекущийПользователь();
	ТекущийОбъект.ДатаИзменения = ТекущаяДатаСеанса();
	
	ТекущийОбъект.СуммаУслугПоЛизингу = ГрафикОплат.Итог("УслугаПоЛизингу");
	ТекущийОбъект.СуммаОбеспечительногоПлатежа = ГрафикОплат.Итог("ЗачетОбеспечительногоПлатежа");
	ТекущийОбъект.СуммаВыкупаПредметаЛизинга = ГрафикОплат.Итог("ВыкупПредметаЛизинга");
	
	Справочники.ВариантыГрафиковЛизинга.ПересчитатьСроки(ТекущийОбъект);
	
	ТекущийОбъект.ДополнительныеСвойства.Вставить("ЗаписьГрафиков", Истина);
	
	МодификацияКонфигурацииПереопределяемый.ПередЗаписьюНаСервере(ЭтаФорма, Отказ, ТекущийОбъект, ПараметрыЗаписи);
	
КонецПроцедуры

&НаСервере
Процедура ПриЗаписиНаСервере(Отказ, ТекущийОбъект, ПараметрыЗаписи)
	
	Если ТекущийОбъект.ЭтоНовый() Тогда
		СсылкаНаСправочник = Справочники.ВариантыГрафиковЛизинга.ПолучитьСсылку();
		ТекущийОбъект.УстановитьСсылкуНового(СсылкаНаСправочник);
	Иначе
		СсылкаНаСправочник = ТекущийОбъект.Ссылка;
	КонецЕсли;
	
	ЗаписатьНаборГрафика("ГрафикОплат", СсылкаНаСправочник);
	ЗаписатьНаборГрафика("ГрафикНачислений", СсылкаНаСправочник);
	
КонецПроцедуры

&НаСервере
Процедура ПослеЗаписиНаСервере(ТекущийОбъект, ПараметрыЗаписи)

	// СтандартныеПодсистемы.УправлениеДоступом
	УправлениеДоступом.ПослеЗаписиНаСервере(ЭтотОбъект, ТекущийОбъект, ПараметрыЗаписи);
	// Конец СтандартныеПодсистемы.УправлениеДоступом
	
	МодификацияКонфигурацииПереопределяемый.ПослеЗаписиНаСервере(ЭтаФорма, ТекущийОбъект, ПараметрыЗаписи);
	
КонецПроцедуры

&НаКлиенте
Процедура ПослеЗаписи(ПараметрыЗаписи)
	
	Оповестить("Запись_ВариантГрафиковЛизинга", ПараметрыЗаписи, ЭтаФорма);
	
	МодификацияКонфигурацииКлиентПереопределяемый.ПослеЗаписи(ЭтаФорма, ПараметрыЗаписи);
	
КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)
	
	// СтандартныеПодсистемы.ПодключаемыеКоманды
	ПодключаемыеКомандыКлиент.НачатьОбновлениеКоманд(ЭтотОбъект);
	// Конец СтандартныеПодсистемы.ПодключаемыеКоманды
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовШапкиФормы

&НаКлиенте
Процедура ВладелецПриИзменении(Элемент)
	
	НастроитьФормуПоДоговору();
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовТаблицыФормы

&НаКлиенте
Процедура ОплатыПослеУдаления(Элемент)
	
	ОбновитьИтогиОплат();
	
КонецПроцедуры

&НаКлиенте
Процедура ОплатыПриОкончанииРедактирования(Элемент, НоваяСтрока, ОтменаРедактирования)
	
	ОбновитьИтогиОплат();
	
КонецПроцедуры

&НаКлиенте
Процедура НачисленияПослеУдаления(Элемент)
	
	ОбновитьИтогиНачислений();
	
КонецПроцедуры

&НаКлиенте
Процедура НачисленияПриОкончанииРедактирования(Элемент, НоваяСтрока, ОтменаРедактирования)
	
	ОбновитьИтогиНачислений();
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура ЗаписатьИЗакрыть(Команда)
	
	ЗаписатьГрафик(Истина);
	
КонецПроцедуры

&НаКлиенте
Процедура ЗаписатьВариантГрафика(Команда)
	
	ЗаписатьГрафик();
	
КонецПроцедуры

&НаКлиенте
Процедура ЗагрузитьГрафик(Команда)
	
	Если ЗначениеЗаполнено(Объект.Ссылка) Тогда
		ЗагрузитьГрафикФрагмент(Команда);
	Иначе
		ПоказатьВопрос(Новый ОписаниеОповещения("ЗагрузитьГрафикПослеВопроса", ЭтотОбъект, Новый Структура("Команда", Команда)),
			НСтр("ru='Перед загрузкой необходимо записать объект.
|Записать и продолжить?'
|;uk='Перед завантаженням необхідно записати об''єкт.
|Записати і продовжити?'"),
			РежимДиалогаВопрос.ДаНет);
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ЗагрузитьГрафикПослеВопроса(РезультатВопроса, ДополнительныеПараметры) Экспорт
	
	Если РезультатВопроса = КодВозвратаДиалога.Да Тогда
		Записать();
		ЗагрузитьГрафикФрагмент(ДополнительныеПараметры.Команда);
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ЗагрузитьГрафикФрагмент(Знач Команда)
	
	ТипГрафика = СтрЗаменить(Команда.Имя, "ЗагрузитьГрафик_", "");
	
	ПараметрыФормы = Новый Структура;
	ПараметрыФормы.Вставить("ВариантГрафика", Объект.Ссылка);
	ПараметрыФормы.Вставить("ТипГрафика", ТипГрафика);
	ПараметрыФормы.Вставить("ИдентификаторВладельца", УникальныйИдентификатор);
	ПараметрыФормы.Вставить("ЕстьОбеспечительныйПлатеж", ЕстьОбеспечительныйПлатеж);
	ПараметрыФормы.Вставить("ЕстьВыкупПредметаЛизинга", ЕстьВыкупПредметаЛизинга);
	
	ОткрытьФорму("Справочник.ВариантыГрафиковЛизинга.Форма.ФормаЗагрузки",
		ПараметрыФормы,,,,,
		Новый ОписаниеОповещения("ЗагрузитьГрафикЗавершение", ЭтотОбъект, Новый Структура("ТипГрафика", ТипГрафика)),
		РежимОткрытияОкнаФормы.БлокироватьВесьИнтерфейс);
	
КонецПроцедуры

&НаКлиенте
Процедура ЗагрузитьГрафикЗавершение(Результат, ДополнительныеПараметры) Экспорт
	
	Если ТипЗнч(Результат) = Тип("Строка") И ЭтоАдресВременногоХранилища(Результат) Тогда
		ТипГрафика = ДополнительныеПараметры.ТипГрафика;
		ЗагрузитьГрафикЗавершениеНаСервере(ТипГрафика, Результат);
		Если ТипГрафика = "ГрафикОплат" Тогда
			ОбновитьИтогиОплат();
		ИначеЕсли ТипГрафика = "ГрафикНачислений" Тогда
			ОбновитьИтогиНачислений();
		КонецЕсли;
		Модифицированность = Истина;
	КонецЕсли;
	
КонецПроцедуры

&НаСервере
Процедура ЗагрузитьГрафикЗавершениеНаСервере(ТипГрафика, АдресНабораЗаписей)
	
	НаборЗаписей = ОбщегоНазначения.ЗначениеИзСтрокиXML(ПолучитьИзВременногоХранилища(АдресНабораЗаписей));
	ЗначениеВРеквизитФормы(НаборЗаписей, ТипГрафика);
	
КонецПроцедуры

// СтандартныеПодсистемы.ПодключаемыеКоманды
&НаКлиенте
Процедура Подключаемый_ВыполнитьПереопределяемуюКоманду(Команда)
	
	СобытияФормКлиент.ВыполнитьПереопределяемуюКоманду(ЭтаФорма, Команда);
	
КонецПроцедуры

&НаКлиенте
Процедура Подключаемый_ВыполнитьКоманду(Команда)
	ПодключаемыеКомандыКлиент.ВыполнитьКоманду(ЭтотОбъект, Команда, Объект);
КонецПроцедуры

&НаСервере
Процедура Подключаемый_ВыполнитьКомандуНаСервере(Контекст, Результат) Экспорт
	ПодключаемыеКоманды.ВыполнитьКоманду(ЭтотОбъект, Контекст, Объект, Результат);
КонецПроцедуры

&НаКлиенте
Процедура Подключаемый_ОбновитьКоманды()
	ПодключаемыеКомандыКлиентСервер.ОбновитьКоманды(ЭтотОбъект, Объект);
КонецПроцедуры
// Конец СтандартныеПодсистемы.ПодключаемыеКоманды

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

Процедура ПриЧтенииСозданииНаСервере()
	
	НастроитьФормуПоДоговору();
	
КонецПроцедуры

&НаКлиенте
Процедура ОбновитьДаты()
	
	Если ГрафикОплат.Количество() > 0 Тогда
		ГрафикОплат.Сортировать("Период");
		Объект.ДатаПоследнегоПлатежа = ГрафикОплат[ГрафикОплат.Количество()-1].Период;
	Иначе
		Объект.ДатаПоследнегоПлатежа = Неопределено;
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ОбновитьИтогиНачислений()
	
	НачисленияУслугПоЛизингу          = ГрафикНачислений.Итог("УслугаПоЛизингу");
	НачисленияОбеспечительногоПлатежа = ГрафикНачислений.Итог("ЗачетОбеспечительногоПлатежа");
	НачисленияВыкупПредметаЛизинга    = ГрафикНачислений.Итог("ВыкупПредметаЛизинга");
	ГрафикНачислений.Сортировать("Период");
	
КонецПроцедуры

&НаКлиенте
Процедура ОбновитьИтогиОплат()
	
	Объект.СуммаУслугПоЛизингу          = ГрафикОплат.Итог("УслугаПоЛизингу");
	Объект.СуммаОбеспечительногоПлатежа = ГрафикОплат.Итог("ЗачетОбеспечительногоПлатежа");
	Объект.СуммаВыкупаПредметаЛизинга   = ГрафикОплат.Итог("ВыкупПредметаЛизинга");
	ОбновитьДаты();
	
КонецПроцедуры

&НаСервере
Процедура НастроитьФормуПоДоговору()
	
	РеквизитыДоговора = ОбщегоНазначения.ЗначенияРеквизитовОбъекта(Объект.Владелец,
		"ВалютаВзаиморасчетов, Статус, ЕстьОбеспечительныйПлатеж, ЕстьВыкупПредметаЛизинга");
	
	ВалютаДоговора = РеквизитыДоговора.ВалютаВзаиморасчетов;
	СтрокаВалюта = Строка(ВалютаДоговора);
	ЕстьОбеспечительныйПлатеж = РеквизитыДоговора.ЕстьОбеспечительныйПлатеж;
	ЕстьВыкупПредметаЛизинга = РеквизитыДоговора.ЕстьВыкупПредметаЛизинга;
	
	Элементы.ГруппаОплаты.Заголовок                                 = СтрШаблон(НСтр("ru='Всего оплата (%1)';uk='Всього оплата (%1)'"), СтрокаВалюта);
	Элементы.ГруппаНачисления.Заголовок                             = СтрШаблон(НСтр("ru='Всего начисления (%1)';uk='Всього нарахування (%1)'"), СтрокаВалюта);
	Элементы.ГрафикОплатУслугаПоЛизингу.Заголовок                   = СтрШаблон(НСтр("ru='Сумма лизингового платежа (%1)';uk='Сума лізингового платежу (%1)'"), СтрокаВалюта);
	Элементы.ГрафикОплатЗачетОбеспечительногоПлатежа.Заголовок      = СтрШаблон(НСтр("ru='Сумма обеспечительного платежа (%1)';uk='Сума забезпечувального платежу (%1)'"), СтрокаВалюта);
	Элементы.ГрафикОплатВыкупПредметаЛизинга.Заголовок              = СтрШаблон(НСтр("ru='Сумма выкупа предмета лизинга (%1)';uk='Сума викупу предмета лізингу (%1)'"), СтрокаВалюта);
	Элементы.ГрафикНачисленийУслугаПоЛизингу.Заголовок              = СтрШаблон(НСтр("ru='Сумма услуг по лизингу (%1)';uk='Сума послуг з лізингу (%1)'"), СтрокаВалюта);
	Элементы.ГрафикНачисленийЗачетОбеспечительногоПлатежа.Заголовок = СтрШаблон(НСтр("ru='Сумма зачета обеспечительного платежа (%1)';uk='Сума заліку забезпечувального платежу (%1)'"), СтрокаВалюта);
	Элементы.ГрафикНачисленийВыкупПредметаЛизинга.Заголовок         = СтрШаблон(НСтр("ru='Сумма выкупа предмета лизинга (%1)';uk='Сума викупу предмета лізингу (%1)'"), СтрокаВалюта);
	
	МассивЭлементов = Новый Массив;
	МассивЭлементов.Добавить("ГрафикОплатЗачетОбеспечительногоПлатежа");
	МассивЭлементов.Добавить("ГрафикНачисленийЗачетОбеспечительногоПлатежа");
	МассивЭлементов.Добавить("СуммаОбеспечительногоПлатежа");
	МассивЭлементов.Добавить("НачисленияОбеспечительногоПлатежа");
	ОбщегоНазначенияУТКлиентСервер.УстановитьСвойствоЭлементовФормы(Элементы, МассивЭлементов, "Видимость", ЕстьОбеспечительныйПлатеж);
	
	МассивЭлементов = Новый Массив;
	МассивЭлементов.Добавить("ГрафикОплатВыкупПредметаЛизинга");
	МассивЭлементов.Добавить("ГрафикНачисленийВыкупПредметаЛизинга");
	МассивЭлементов.Добавить("СуммаВыкупаПредметаЛизинга");
	МассивЭлементов.Добавить("НачисленияВыкупПредметаЛизинга");
	ОбщегоНазначенияУТКлиентСервер.УстановитьСвойствоЭлементовФормы(Элементы, МассивЭлементов, "Видимость", ЕстьВыкупПредметаЛизинга);
	
	ДоговорЗакрыт = (РеквизитыДоговора.Статус = Перечисления.СтатусыДоговоровКонтрагентов.Закрыт);
	Элементы.НадписьДоговорЗакрыт.Видимость = ДоговорЗакрыт;
	МассивЭлементов = Новый Массив();
	МассивЭлементов.Добавить("ФормаЗаписать");
	МассивЭлементов.Добавить("ФормаЗаписатьИЗакрыть");
	МассивЭлементов.Добавить("Используется");
	МассивЭлементов.Добавить("Утвержден");
	МассивЭлементов.Добавить("ОписаниеДоговора");
	МассивЭлементов.Добавить("НаименованиеКод");
	МассивЭлементов.Добавить("ОплатыКоманднаяПанель");
	МассивЭлементов.Добавить("НачисленияКоманднаяПанель");
	МассивЭлементов.Добавить("Комментарий");
	ОбщегоНазначенияУТКлиентСервер.УстановитьСвойствоЭлементовФормы(Элементы, МассивЭлементов, "Доступность", Не ДоговорЗакрыт);
	
КонецПроцедуры

&НаСервере
Процедура ПрочитатьНаборГрафика(ТипГрафика, Ссылка)
	
	Набор = НаборГрафика(ТипГрафика, Ссылка);
	Набор.Прочитать();
	ЗначениеВРеквизитФормы(Набор, ТипГрафика);
	
КонецПроцедуры

&НаСервере
Процедура ЗаписатьНаборГрафика(ТипГрафика, Ссылка)
	
	Набор = НаборГрафика(ТипГрафика, Ссылка);
	Набор.Заполнить(Новый Структура("ВариантГрафика", Ссылка));
	Набор.Записать();
	
КонецПроцедуры

&НаСервере
Функция НаборГрафика(ТипГрафика, Ссылка)
	
	Набор = РеквизитФормыВЗначение(ТипГрафика, Тип("РегистрСведенийНаборЗаписей." + ТипГрафика + "Лизинга")); // РегистрСведенийНаборЗаписей
	Набор.Отбор.ВариантГрафика.Установить(Ссылка);
	
	Возврат Набор;
	
КонецФункции

&НаКлиенте
Функция СуммыГрафиковСходятся()
	
	СуммыУслугПоЛизингуРавны          = (Объект.СуммаУслугПоЛизингу = НачисленияУслугПоЛизингу);
	СуммыОбеспечительногоПлатежаРавны = (Объект.СуммаОбеспечительногоПлатежа = НачисленияОбеспечительногоПлатежа);
	СуммыВыкупаПредметаЛизингаРавны   = (Объект.СуммаВыкупаПредметаЛизинга = НачисленияВыкупПредметаЛизинга);

	Если Не СуммыУслугПоЛизингуРавны Тогда
		Текст = НСтр("ru='Различаются итоговые суммы услуг по лизингу на закладках ""Оплаты"" и ""Начисления"".';uk='Розрізняються підсумкові суми послуг по лізингу на закладках ""Оплати"" і ""Нарахування"".'");
		ОбщегоНазначенияКлиентСервер.СообщитьПользователю(Текст);
	КонецЕсли;
	
	Если Не СуммыОбеспечительногоПлатежаРавны Тогда
		Текст = НСтр("ru='Различаются итоговые суммы зачета обеспечительного платежа на закладках ""Оплаты"" и ""Начисления"".';uk='Розрізняються підсумкові суми заліку забезпечувального платежу на закладках ""Оплати"" і ""Нарахування"".'");
		ОбщегоНазначенияКлиентСервер.СообщитьПользователю(Текст);
	КонецЕсли;
	
	Если Не СуммыВыкупаПредметаЛизингаРавны Тогда
		Текст = НСтр("ru='Различаются итоговые суммы выкупа предмета лизинга на закладках ""Оплаты"" и ""Начисления"".';uk='Розрізняються підсумкові суми викупу предмета лізингу на закладках ""Оплати"" і ""Нарахування"".'");
		ОбщегоНазначенияКлиентСервер.СообщитьПользователю(Текст);
	КонецЕсли;
	
	Возврат СуммыУслугПоЛизингуРавны И СуммыОбеспечительногоПлатежаРавны И СуммыВыкупаПредметаЛизингаРавны;
	
КонецФункции

&НаСервере
Процедура ОбновитьСвязанныеДанные()
	
	ДанныеГрафика = Справочники.ВариантыГрафиковЛизинга.ИтогиГрафика(Объект.Ссылка);
	ЗаполнитьЗначенияСвойств(ЭтаФорма, ДанныеГрафика,
		"НачисленияУслугПоЛизингу, НачисленияОбеспечительногоПлатежа, НачисленияВыкупПредметаЛизинга");
	
КонецПроцедуры

&НаКлиенте
Процедура ЗаписатьГрафик(ЗакрыватьПослеЗаписи = Ложь)
	
	Если Не СуммыГрафиковСходятся() Тогда
		ПоказатьВопрос(Новый ОписаниеОповещения("ОбработкаОтветаНаВопросИгнорировать", ЭтотОбъект, ЗакрыватьПослеЗаписи),
			НСтр("ru='В текущем варианте графика различаются итоговые суммы.
|Игнорировать?'
|;uk='У поточному варіанті графіка розрізняються підсумкові суми.
|Ігнорувати?'"),
			РежимДиалогаВопрос.ДаНет);
	Иначе
		ВыполнитьЗаписьОбъекта(ЗакрыватьПослеЗаписи);
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ОбработкаОтветаНаВопросИгнорировать(Ответ, ЗакрыватьПослеЗаписи) Экспорт
	
	Если Ответ = КодВозвратаДиалога.Нет Тогда
		Возврат;
	КонецЕсли;
	
	ВыполнитьЗаписьОбъекта(ЗакрыватьПослеЗаписи);
	
КонецПроцедуры

&НаКлиенте
Процедура ВыполнитьЗаписьОбъекта(ЗакрыватьПослеЗаписи = Ложь)
	
	Записать();
	Если ЗакрыватьПослеЗаписи Тогда
		Закрыть();
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти
