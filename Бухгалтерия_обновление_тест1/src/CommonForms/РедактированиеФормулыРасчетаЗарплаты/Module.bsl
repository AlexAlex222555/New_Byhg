
#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	Формула = Параметры.Формула;
	НаименованиеВидаРасчета = Параметры.НаименованиеВидаРасчета;
	ВидРасчета = Параметры.ВидРасчета;
	
	Заголовок = НСтр("ru='Редактирование формулы (%1)';uk='Редагування формули (%1)'");
	Если ПустаяСтрока(НаименованиеВидаРасчета) Тогда
		Заголовок = СтрЗаменить(Заголовок, "(%1)", "");
	КонецЕсли;
	Заголовок = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(Заголовок, НаименованиеВидаРасчета);
	
	// Ограничиваем выбор недоступных показателей.
	Если Параметры.НедоступныеПоказатели <> Неопределено Тогда
		НедоступныеПоказатели = Новый ФиксированныйМассив(Параметры.НедоступныеПоказатели);
		ОбщегоНазначенияКлиентСервер.УстановитьЭлементОтбораДинамическогоСписка(
			Показатели, "Ссылка", НедоступныеПоказатели, ВидСравненияКомпоновкиДанных.НеВСписке);
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)
	УстановитьТекстВПозициюКурсора();
КонецПроцедуры

&НаКлиенте
Процедура ПередЗакрытием(Отказ, ЗавершениеРаботы, ТекстПредупреждения, СтандартнаяОбработка)
	
	Оповещение = Новый ОписаниеОповещения("ВыбратьИЗакрыть", ЭтотОбъект);
	ОбщегоНазначенияКлиент.ПоказатьПодтверждениеЗакрытияФормы(Оповещение, Отказ, ЗавершениеРаботы);
	
КонецПроцедуры

&НаКлиенте
Процедура ОбработкаОповещения(ИмяСобытия, Параметр, Источник)
	
	Если ИмяСобытия = "Запись_ПоказателиРасчетаЗарплаты" И Источник = ЭтаФорма Тогда
		Элементы.Показатели.ТекущаяСтрока = Параметр;
	КонецЕсли;
	
КонецПроцедуры

#Область ОбработчикиСобытийТаблицыФормыПоказатели

&НаКлиенте
Процедура ПоказателиВыбор(Элемент, ВыбраннаяСтрока, Поле, СтандартнаяОбработка)
	
	СтандартнаяОбработка = Ложь;
	
	Если Элементы.Показатели.ТекущиеДанные = Неопределено Тогда
		Возврат;
	КонецЕсли;
	
	ДобавитьВФормулу(Элементы.Показатели.ТекущиеДанные.Идентификатор);
	
КонецПроцедуры

&НаКлиенте
Процедура ПоказателиНачалоПеретаскивания(Элемент, ПараметрыПеретаскивания, Выполнение)
	
	Если Элементы.Показатели.ТекущиеДанные = Неопределено Тогда 
		Возврат;
	КонецЕсли;
	
	ПараметрыПеретаскивания.Значение = Элементы.Показатели.ТекущиеДанные.Идентификатор;
	
КонецПроцедуры

#КонецОбласти

#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура ОК(Команда)
	
	ВыбратьИЗакрыть();
	
КонецПроцедуры

&НаКлиенте
Процедура Отмена(Команда)
	
	Модифицированность = Ложь;
	Закрыть();
	
КонецПроцедуры

&НаКлиенте
Процедура ПроверитьФормулу(Команда)
	
	ОчиститьСообщения();
	Результаты = РезультатыРедактирования(Формула, ВидРасчета, НедоступныеПоказатели, Ложь);
	Если Результаты <> Неопределено Тогда
		ПоказатьПредупреждение(, НСтр("ru='Проверка формулы завершена успешно.';uk='Перевірка формули завершена успішно.'"));
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ДобавитьПоказательВФормулу(Команда)
	
	Если Элементы.Показатели.ТекущиеДанные = Неопределено Тогда
		Возврат;
	КонецЕсли;
	
	ДобавитьВФормулу(Элементы.Показатели.ТекущиеДанные.Идентификатор);
	
КонецПроцедуры

&НаКлиенте
Процедура ОткрытьПоказатель(Команда)
	
	Если Элементы.Показатели.ТекущиеДанные = Неопределено Тогда
		Возврат;
	КонецЕсли;
	
	ПараметрыФормы = Новый Структура("Ключ", Элементы.Показатели.ТекущиеДанные.Ссылка);
	ОткрытьФорму("Справочник.ПоказателиРасчетаЗарплаты.ФормаОбъекта", ПараметрыФормы, ЭтотОбъект.ВладелецФормы);
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаКлиенте
Процедура ВыбратьИЗакрыть(Результат = Неопределено, ДополнительныеПараметры = Неопределено) Экспорт
	
	ОчиститьСообщения();
	Результаты = РезультатыРедактирования(Формула, ВидРасчета, НедоступныеПоказатели);
	
	Если Результаты = Неопределено Тогда
		Возврат;
	КонецЕсли;
	
	Модифицированность = Ложь;
	Закрыть(Результаты);
	
КонецПроцедуры

&НаСервереБезКонтекста
Функция РезультатыРедактирования(Формула, ВидРасчета, НедоступныеПоказатели, ДополнятьРезультаты = Истина)
	
	Результаты = Новый Структура;
	Результаты.Вставить("Формула", Формула);
	
	ПараметрыВыполненияФормулы = РасчетЗарплатыРасширенный.ПараметрыВыполненияФормулы(Формула, Истина, НедоступныеПоказатели);

	Если ПараметрыВыполненияФормулы = Неопределено Тогда
		Возврат Неопределено
	Иначе
		ПоказателиФормулы = ПараметрыВыполненияФормулы.ПоказателиФормулы;
		Если ДополнятьРезультаты Тогда
			Результаты.Вставить("СведенияОПоказателях", ЗарплатаКадрыРасширенный.СведенияОПоказателяхРасчетаЗарплаты(ПоказателиФормулы));
			Результаты.Вставить("ЕстьПоказательРасчетнаяБаза", ПоказателиФормулы.Найти(ОбщегоНазначенияКлиентСервер.ПредопределенныйЭлемент("Справочник.ПоказателиРасчетаЗарплаты.РасчетнаяБаза")) <> Неопределено);
			Результаты.Вставить("ЕстьПоказательРасчетнаяБазаСтраховыеВзносы", ПоказателиФормулы.Найти(ОбщегоНазначенияКлиентСервер.ПредопределенныйЭлемент("Справочник.ПоказателиРасчетаЗарплаты.РасчетнаяБазаСтраховыеВзносы")) <> Неопределено);
			Результаты.Вставить("ЕстьПоказателиУчетаВремени", ЕстьПоказателиУчетаВремени(ПоказателиФормулы));
			Результаты.Вставить("ЕстьОперативныеПоказатели", ЕстьОперативныеПоказатели(ПоказателиФормулы));			
			Результаты.Вставить("ЗапрашиваемыеПоказатели", ЗарплатаКадрыРасширенный.ЗапрашиваемыеПоказателиВидаРасчетаПоУмолчанию(ВидРасчета, ПоказателиФормулы));
		КонецЕсли;
		Возврат Результаты;
	КонецЕсли;
	
КонецФункции

&НаСервереБезКонтекста
Функция ЕстьПоказателиУчетаВремени(ПоказателиФормулы)
	
	ПоказателиУчетаВремени = Справочники.ПоказателиРасчетаЗарплаты.ПоказателиУчетаВремени();
	
	Для Каждого ПоказательФормулы Из ПоказателиФормулы Цикл
		Если ПоказателиУчетаВремени.Найти(ПоказательФормулы) <> Неопределено Тогда
			Возврат Истина;
		КонецЕсли;
	КонецЦикла;
	
	Возврат Ложь;
	
КонецФункции

&НаСервереБезКонтекста
Функция ЕстьОперативныеПоказатели(ПоказателиФормулы)
	
	ОперативныеПоказатели = Справочники.ПоказателиРасчетаЗарплаты.ОперативныеПоказатели();
	
	Для Каждого ПоказательФормулы Из ПоказателиФормулы Цикл
		Если ОперативныеПоказатели.Найти(ПоказательФормулы) <> Неопределено Тогда
			Возврат Истина;
		КонецЕсли;
	КонецЦикла;
	
	Возврат Ложь;
	
КонецФункции

&НаКлиенте
Процедура ДобавитьВФормулу(Идентификатор)
	УстановитьТекстВПозициюКурсора(Идентификатор)	
КонецПроцедуры

&НаКлиенте
Процедура УстановитьТекстВПозициюКурсора(Текст = "")
	
	НачальнаяСтрокаВыделения = 0; 
	НачальнаяКолонкаВыделения = 0; 
	КонечнаяСтрокаВыделения = 0; 
	КонечнаяКолонкаВыделения = 0;
	
	// Получим текущую позицию курсора.
	Элементы.Формула.ПолучитьГраницыВыделения(НачальнаяСтрокаВыделения, НачальнаяКолонкаВыделения, КонечнаяСтрокаВыделения, КонечнаяКолонкаВыделения);
	
	Если ПустаяСтрока(Текст) Тогда
		НачальнаяКолонкаВыделения = НачальнаяКолонкаВыделения + СтрДлина(Формула);
	Иначе
		Элементы.Формула.ВыделенныйТекст = Текст;
		Модифицированность = Истина;
		
		// Установим курсор после вставленного текста.
		НачальнаяКолонкаВыделения = НачальнаяКолонкаВыделения + СтрДлина(Текст);
	КонецЕсли;
	
	Элементы.Формула.УстановитьГраницыВыделения(НачальнаяСтрокаВыделения, НачальнаяКолонкаВыделения, НачальнаяСтрокаВыделения, НачальнаяКолонкаВыделения);
	
КонецПроцедуры

#КонецОбласти
