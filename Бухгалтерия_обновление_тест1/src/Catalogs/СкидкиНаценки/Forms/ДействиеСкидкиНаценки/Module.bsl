
#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	УстановитьУсловноеОформление();
	
	Если Параметры.Свойство("АвтоТест") Тогда // Возврат при получении формы для анализа.
		Возврат;
	КонецЕсли;
	
	ЗаполнитьЗначенияСвойств(ЭтотОбъект, СкидкиНаценкиСервер.СтруктураИсточниковДействияСкидокСогласноФО());
	
	СкидкаНаценка = Параметры.СкидкаНаценка;
	Дата = ТекущаяДатаСеанса();
	ДатаСреза = Дата;
	
	ДинамическиеСписки = Новый Массив;
	ДинамическиеСписки.Добавить(ИспользованиеВТиповыхСоглашенияхСКлиентами);
	ДинамическиеСписки.Добавить(ИспользованиеВИндивидуальныхСоглашенияхСКлиентами);
	ДинамическиеСписки.Добавить(ИспользованиеВКартахЛояльности);
	ДинамическиеСписки.Добавить(ИспользованиеНаСкладах);
	
	Для Каждого ДинамическийСписок Из ДинамическиеСписки Цикл
		
		ОбщегоНазначенияКлиентСервер.УстановитьПараметрДинамическогоСписка(
			ДинамическийСписок,
			"ТекущаяДата",
			ДатаСреза,
			Истина);
			
		ОбщегоНазначенияКлиентСервер.УстановитьПараметрДинамическогоСписка(
			ДинамическийСписок,
			"СкидкаНаценка",
			СкидкаНаценка,
			Истина);
			
	КонецЦикла;
	
	ДоступноРедактированиеСкидокНаценок = ПравоДоступа("Изменение", Метаданные.Справочники.СкидкиНаценки);
	
	Элементы.ИспользованиеНаСкладахИспользованиеНаСкладахУстановитьСтатусДействует.Видимость = ДоступноРедактированиеСкидокНаценок;
	Элементы.ИспользованиеНаСкладахИспользованиеНаСкладахУстановитьСтатусНеДействует.Видимость = ДоступноРедактированиеСкидокНаценок;
	Элементы.ИспользованиеНаСкладахКонтекстноеМенюИспользованиеНаСкладахУстановитьСтатусДействует.Видимость = ДоступноРедактированиеСкидокНаценок;
	Элементы.ИспользованиеНаСкладахКонтекстноеМенюИспользованиеНаСкладахУстановитьСтатусНеДействует.Видимость = ДоступноРедактированиеСкидокНаценок;
	
	Элементы.ИспользованиеВКартахЛояльностиИспользованиеВКартахЛояльностиУстановитьСтатусНеДействует.Видимость = ДоступноРедактированиеСкидокНаценок;
	Элементы.ИспользованиеВКартахЛояльностиИспользованиеВКартахЛояльностиУстановитьСтатусДействует.Видимость = ДоступноРедактированиеСкидокНаценок;
	Элементы.ИспользованиеВКартахЛояльностиКонтекстноеМенюИспользованиеВКартахЛояльностиУстановитьСтатусНеДействует.Видимость = ДоступноРедактированиеСкидокНаценок;
	Элементы.ИспользованиеВКартахЛояльностиКонтекстноеМенюИспользованиеВКартахЛояльностиУстановитьСтатусДействует.Видимость = ДоступноРедактированиеСкидокНаценок;

	Элементы.ИспользованиеВИндивидуальныхСоглашенияхСКлиентамиИспользованиеВСоглашенияхСКлиентамиУстановитьСтатусДействует.Видимость = ДоступноРедактированиеСкидокНаценок;
	Элементы.ИспользованиеВИндивидуальныхСоглашенияхСКлиентамиИспользованиеВСоглашенияхСКлиентамиУстановитьСтатусНеДействует.Видимость = ДоступноРедактированиеСкидокНаценок;
	Элементы.ИспользованиеВИндивидуальныхСоглашенияхСКлиентамиКонтекстноеМенюИспользованиеВИндивидуальныхСоглашенияхСКлиентамиУстановитьСтатусДействует.Видимость = ДоступноРедактированиеСкидокНаценок;
	Элементы.ИспользованиеВИндивидуальныхСоглашенияхСКлиентамиКонтекстноеМенюИспользованиеВИндивидуальныхСоглашенияхСКлиентамиУстановитьСтатусНеДействует.Видимость = ДоступноРедактированиеСкидокНаценок;

	Элементы.ИспользованиеВТиповыхСоглашенияхСКлиентамиИспользованиеВСоглашенияхСКлиентамиУстановитьСтатусДействует.Видимость = ДоступноРедактированиеСкидокНаценок;
	Элементы.ИспользованиеВТиповыхСоглашенияхСКлиентамиИспользованиеВСоглашенияхСКлиентамиУстановитьСтатусНеДействует.Видимость = ДоступноРедактированиеСкидокНаценок;
	Элементы.ИспользованиеВТиповыхСоглашенияхСКлиентамиКонтекстноеМенюИспользованиеВТиповыхСоглашенияхСКлиентамиУстановитьСтатусДействует.Видимость = ДоступноРедактированиеСкидокНаценок;
	Элементы.ИспользованиеВТиповыхСоглашенияхСКлиентамиКонтекстноеМенюИспользованиеВТиповыхСоглашенияхСКлиентамиУстановитьСтатусНеДействует.Видимость = ДоступноРедактированиеСкидокНаценок;
	
	ОбщегоНазначенияКлиентСервер.УстановитьЭлементОтбораДинамическогоСписка(
		ИспользованиеНаСкладах,
		"Статус",
		Перечисления.СтатусыДействияСкидок.Действует,
		ВидСравненияКомпоновкиДанных.Равно,
		,
		ИспользованиеНаСкладахВариантОтображенияСкидокНаценок <> "Все");
		
	ОбщегоНазначенияКлиентСервер.УстановитьЭлементОтбораДинамическогоСписка(
		ИспользованиеВИндивидуальныхСоглашенияхСКлиентами,
		"Статус",
		Перечисления.СтатусыДействияСкидок.Действует,
		ВидСравненияКомпоновкиДанных.Равно,
		,
		ИспользованиеВИндивидуальныхСоглашенияхСКлиентамиВариантОтображенияСкидокНаценок <> "Все");
		
	ОбщегоНазначенияКлиентСервер.УстановитьЭлементОтбораДинамическогоСписка(
		ИспользованиеВТиповыхСоглашенияхСКлиентами,
		"Статус",
		Перечисления.СтатусыДействияСкидок.Действует,
		ВидСравненияКомпоновкиДанных.Равно,
		,
		ИспользованиеВТиповыхСоглашенияхСКлиентамиВариантОтображенияСкидокНаценок <> "Все");
		
	ОбщегоНазначенияКлиентСервер.УстановитьЭлементОтбораДинамическогоСписка(
		ИспользованиеВКартахЛояльности,
		"Статус",
		Перечисления.СтатусыДействияСкидок.Действует,
		ВидСравненияКомпоновкиДанных.Равно,
		,
		ИспользованиеВКартахЛояльностиВариантОтображенияСкидокНаценок <> "Все");
		
	ОбновитьИспользованиеСкидокНаценок();
	
КонецПроцедуры

&НаКлиенте
Процедура ОбработкаОповещения(ИмяСобытия, Параметр, Источник)
	
	Если ИмяСобытия = "Запись_ДействиеСкидокНаценок" И Параметр.СкидкаНаценка.Найти(СкидкаНаценка) <> Неопределено Тогда
		Элементы.ИспользованиеВКартахЛояльности.Обновить();
		Элементы.ИспользованиеВИндивидуальныхСоглашенияхСКлиентами.Обновить();
		Элементы.ИспользованиеВТиповыхСоглашенияхСКлиентами.Обновить();
		Элементы.ИспользованиеНаСкладах.Обновить();
		ОбновитьИспользованиеСкидокНаценок();
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовШапкиФормы

&НаКлиенте
Процедура ДатаСрезаПриИзменении(Элемент)
	
	ОбновитьДанныеНаСервере();
	
КонецПроцедуры

&НаКлиенте
Процедура ДатаСрезаОчистка(Элемент, СтандартнаяОбработка)
	
	СтандартнаяОбработка = Ложь;
	ДатаСреза = Дата;
	
	ОбновитьДанныеНаСервере();
	
КонецПроцедуры

&НаКлиенте
Процедура ИспользованиеНаСкладахВариантОтображенияСкидокПриИзменении(Элемент)
	
	ОбщегоНазначенияКлиентСервер.УстановитьЭлементОтбораДинамическогоСписка(
		ИспользованиеНаСкладах,
		"Статус",
		ПредопределенноеЗначение("Перечисление.СтатусыДействияСкидок.Действует"),
		ВидСравненияКомпоновкиДанных.Равно,
		,
		ИспользованиеНаСкладахВариантОтображенияСкидокНаценок <> "Все");
		
КонецПроцедуры

&НаКлиенте
Процедура ИспользованиеВИндивидуальныхСоглашенияхСКлиентамиВариантОтображенияСкидокПриИзменении(Элемент)
	
	ОбщегоНазначенияКлиентСервер.УстановитьЭлементОтбораДинамическогоСписка(
		ИспользованиеВИндивидуальныхСоглашенияхСКлиентами,
		"Статус",
		ПредопределенноеЗначение("Перечисление.СтатусыДействияСкидок.Действует"),
		ВидСравненияКомпоновкиДанных.Равно,
		,
		ИспользованиеВИндивидуальныхСоглашенияхСКлиентамиВариантОтображенияСкидокНаценок <> "Все");
		
КонецПроцедуры

&НаКлиенте
Процедура ИспользованиеВТиповыхСоглашенияхСКлиентамиВариантОтображенияСкидокПриИзменении(Элемент)
	
	ОбщегоНазначенияКлиентСервер.УстановитьЭлементОтбораДинамическогоСписка(
		ИспользованиеВТиповыхСоглашенияхСКлиентами,
		"Статус",
		ПредопределенноеЗначение("Перечисление.СтатусыДействияСкидок.Действует"),
		ВидСравненияКомпоновкиДанных.Равно,
		,
		ИспользованиеВТиповыхСоглашенияхСКлиентамиВариантОтображенияСкидокНаценок <> "Все");
		
КонецПроцедуры

&НаКлиенте
Процедура ИспользованиеВКартахЛояльностиВариантОтображенияСкидокПриИзменении(Элемент)
	
	ОбщегоНазначенияКлиентСервер.УстановитьЭлементОтбораДинамическогоСписка(
		ИспользованиеВКартахЛояльности,
		"Статус",
		ПредопределенноеЗначение("Перечисление.СтатусыДействияСкидок.Действует"),
		ВидСравненияКомпоновкиДанных.Равно,
		,
		ИспользованиеВКартахЛояльностиВариантОтображенияСкидокНаценок <> "Все");
		
КонецПроцедуры

&НаКлиенте
Процедура ИнформацияОДействииСкидокОбработкаНавигационнойСсылки(Элемент, НавигационнаяСсылка, СтандартнаяОбработка)
	
	СтандартнаяОбработка = Ложь;
	Если НавигационнаяСсылка = "ИзменитьОбщийСтатус" Тогда
		
		ПараметрыОткрытия = Новый Структура;
		ПараметрыОткрытия.Вставить("СкидкаНаценка", СкидкаНаценка);
		ПараметрыОткрытия.Вставить("Источник", ПредопределенноеЗначение("Справочник.Склады.ПустаяСсылка"));
		ОткрытьФорму("Справочник.СкидкиНаценки.Форма.УстановкаСтатусаДействия", ПараметрыОткрытия);
		
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ИспользованиеНаСкладахВыбор(Элемент, ВыбраннаяСтрока, Поле, СтандартнаяОбработка)
	
	Если Поле <> Элементы.ИспользованиеНаСкладахСклад Тогда
		СтандартнаяОбработка = Ложь;
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ИспользованиеВКартахЛояльностиВыбор(Элемент, ВыбраннаяСтрока, Поле, СтандартнаяОбработка)
	
	Если Поле <> Элементы.ИспользованиеВКартахЛояльностиВидКартыЛояльности Тогда
		СтандартнаяОбработка = Ложь;
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ИспользованиеВИндивидуальныхСоглашенияхСКлиентамиВыбор(Элемент, ВыбраннаяСтрока, Поле, СтандартнаяОбработка)
	
	Если Поле <> Элементы.ИспользованиеВИндивидуальныхСоглашенияхСКлиентамиСоглашение Тогда
		СтандартнаяОбработка = Ложь;
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ИспользованиеВТиповыхСоглашенияхСКлиентамиВыбор(Элемент, ВыбраннаяСтрока, Поле, СтандартнаяОбработка)
	
	Если Поле <> Элементы.ИспользованиеВТиповыхСоглашенияхСКлиентамиСоглашение Тогда
		СтандартнаяОбработка = Ложь;
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура ИспользованиеНаСкладахУстановитьСтатусНеДействует(Команда)
	
	Источники = Новый Массив;
	Для Каждого ИдентификаторСтроки Из Элементы.ИспользованиеНаСкладах.ВыделенныеСтроки Цикл
		Источники.Добавить(Элементы.ИспользованиеНаСкладах.ДанныеСтроки(ИдентификаторСтроки).Склад);
	КонецЦикла;
	
	Если Источники.Количество() = 0 Тогда
		Возврат;
	КонецЕсли;
	
	ОткрытьФормуИзмененияСтатуса(
		Источники,
		ПредопределенноеЗначение("Перечисление.СтатусыДействияСкидок.НеДействует"));
	
КонецПроцедуры

&НаКлиенте
Процедура ИспользованиеНаСкладахУстановитьСтатусДействует(Команда)
	
	Источники = Новый Массив;
	Для Каждого ИдентификаторСтроки Из Элементы.ИспользованиеНаСкладах.ВыделенныеСтроки Цикл
		Источники.Добавить(Элементы.ИспользованиеНаСкладах.ДанныеСтроки(ИдентификаторСтроки).Склад);
	КонецЦикла;
	
	Если Источники.Количество() = 0 Тогда
		Возврат;
	КонецЕсли;
	
	ОткрытьФормуИзмененияСтатуса(
		Источники,
		ПредопределенноеЗначение("Перечисление.СтатусыДействияСкидок.Действует"));
	
КонецПроцедуры

&НаКлиенте
Процедура ИспользованиеВКартахЛояльностиУстановитьСтатусНеДействует(Команда)
	
	Источники = Новый Массив;
	Для Каждого Источник Из Элементы.ИспользованиеВКартахЛояльности.ВыделенныеСтроки Цикл
		Источники.Добавить(Источник);
	КонецЦикла;
	
	Если Источники.Количество() = 0 Тогда
		Возврат;
	КонецЕсли;
	
	ОткрытьФормуИзмененияСтатуса(
		Источники,
		ПредопределенноеЗначение("Перечисление.СтатусыДействияСкидок.НеДействует"));
	
КонецПроцедуры

&НаКлиенте
Процедура ИспользованиеВКартахЛояльностиУстановитьСтатусДействует(Команда)
	
	Источники = Новый Массив;
	Для Каждого Источник Из Элементы.ИспользованиеВКартахЛояльности.ВыделенныеСтроки Цикл
		Источники.Добавить(Источник);
	КонецЦикла;
	
	Если Источники.Количество() = 0 Тогда
		Возврат;
	КонецЕсли;
	
	ОткрытьФормуИзмененияСтатуса(
		Источники,
		ПредопределенноеЗначение("Перечисление.СтатусыДействияСкидок.Действует"));
	
КонецПроцедуры

&НаКлиенте
Процедура ИспользованиеВИндивидуальныхСоглашенияхСКлиентамиУстановитьСтатусНеДействует(Команда)
	
	Источники = Новый Массив;
	Для Каждого Источник Из Элементы.ИспользованиеВИндивидуальныхСоглашенияхСКлиентами.ВыделенныеСтроки Цикл
		Источники.Добавить(Источник);
	КонецЦикла;
	
	Если Источники.Количество() = 0 Тогда
		Возврат;
	КонецЕсли;
	
	ОткрытьФормуИзмененияСтатуса(
		Источники,
		ПредопределенноеЗначение("Перечисление.СтатусыДействияСкидок.НеДействует"));
	
КонецПроцедуры

&НаКлиенте
Процедура ИспользованиеВИндивидуальныхСоглашенияхСКлиентамиУстановитьСтатусДействует(Команда)
	
	Источники = Новый Массив;
	Для Каждого Источник Из Элементы.ИспользованиеВИндивидуальныхСоглашенияхСКлиентами.ВыделенныеСтроки Цикл
		Источники.Добавить(Источник);
	КонецЦикла;
	
	Если Источники.Количество() = 0 Тогда
		Возврат;
	КонецЕсли;
	
	ОткрытьФормуИзмененияСтатуса(
		Источники,
		ПредопределенноеЗначение("Перечисление.СтатусыДействияСкидок.Действует"));
	
КонецПроцедуры

&НаКлиенте
Процедура ИспользованиеВТиповыхСоглашенияхСКлиентамиУстановитьСтатусНеДействует(Команда)
	
	Источники = Новый Массив;
	Для Каждого Источник Из Элементы.ИспользованиеВТиповыхСоглашенияхСКлиентами.ВыделенныеСтроки Цикл
		Источники.Добавить(Источник);
	КонецЦикла;
	
	Если Источники.Количество() = 0 Тогда
		Возврат;
	КонецЕсли;
	
	ОткрытьФормуИзмененияСтатуса(
		Источники,
		ПредопределенноеЗначение("Перечисление.СтатусыДействияСкидок.НеДействует"));
	
КонецПроцедуры

&НаКлиенте
Процедура ИспользованиеВТиповыхСоглашенияхСКлиентамиУстановитьСтатусДействует(Команда)
	
	Источники = Новый Массив;
	Для Каждого Источник Из Элементы.ИспользованиеВТиповыхСоглашенияхСКлиентами.ВыделенныеСтроки Цикл
		Источники.Добавить(Источник);
	КонецЦикла;
	
	Если Источники.Количество() = 0 Тогда
		Возврат;
	КонецЕсли;
	
	ОткрытьФормуИзмененияСтатуса(
		Источники,
		ПредопределенноеЗначение("Перечисление.СтатусыДействияСкидок.Действует"));
	
КонецПроцедуры

&НаКлиенте
Процедура ИсторияДействияНаСкладе(Команда)
	
	ТекущиеДанные = Элементы.ИспользованиеНаСкладах.ТекущиеДанные;
	Если ТекущиеДанные = Неопределено Тогда
		Возврат;
	КонецЕсли;
	
	ОткрытьФормуИстории(ТекущиеДанные.Склад);
	
КонецПроцедуры

&НаКлиенте
Процедура ИсторияДействияВВидеКартыЛояльности(Команда)
	
	ТекущиеДанные = Элементы.ИспользованиеВКартахЛояльности.ТекущиеДанные;
	Если ТекущиеДанные = Неопределено Тогда
		Возврат;
	КонецЕсли;
	
	ОткрытьФормуИстории(ТекущиеДанные.ВидКартыЛояльности);
	
КонецПроцедуры

&НаКлиенте
Процедура ИсторияДействияВИндивидуальномСоглашении(Команда)
	
	ТекущиеДанные = Элементы.ИспользованиеВИндивидуальныхСоглашенияхСКлиентами.ТекущиеДанные;
	Если ТекущиеДанные = Неопределено Тогда
		Возврат;
	КонецЕсли;
	
	ОткрытьФормуИстории(ТекущиеДанные.Соглашение);
	
КонецПроцедуры

&НаКлиенте
Процедура ИсторияДействияВТиповомСоглашении(Команда)
	
	ТекущиеДанные = Элементы.ИспользованиеВТиповыхСоглашенияхСКлиентами.ТекущиеДанные;
	Если ТекущиеДанные = Неопределено Тогда
		Возврат;
	КонецЕсли;
	
	ОткрытьФормуИстории(ТекущиеДанные.Соглашение);
	
КонецПроцедуры

&НаКлиенте
Процедура ОК(Команда)
	
	Закрыть(Неопределено);
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаСервере
Процедура УстановитьУсловноеОформление()

	УсловноеОформление.Элементы.Очистить();

	//

	Элемент = УсловноеОформление.Элементы.Добавить();

	ПолеЭлемента = Элемент.Поля.Элементы.Добавить();
	ПолеЭлемента.Поле = Новый ПолеКомпоновкиДанных(Элементы.ИспользованиеВКартахЛояльностиДатаОкончания.Имя);

	ОтборЭлемента = Элемент.Отбор.Элементы.Добавить(Тип("ЭлементОтбораКомпоновкиДанных"));
	ОтборЭлемента.ЛевоеЗначение = Новый ПолеКомпоновкиДанных("ИспользованиеВКартахЛояльности.ДатаОкончания");
	ОтборЭлемента.ВидСравнения = ВидСравненияКомпоновкиДанных.Равно;
	ОтборЭлемента.ПравоеЗначение = '00010101';

	ОтборЭлемента = Элемент.Отбор.Элементы.Добавить(Тип("ЭлементОтбораКомпоновкиДанных"));
	ОтборЭлемента.ЛевоеЗначение = Новый ПолеКомпоновкиДанных("ИспользованиеВКартахЛояльности.ДатаНачала");
	ОтборЭлемента.ВидСравнения = ВидСравненияКомпоновкиДанных.НеРавно;
	ОтборЭлемента.ПравоеЗначение = '00010101';

	Элемент.Оформление.УстановитьЗначениеПараметра("Текст", НСтр("ru='<бессрочно>';uk='<безстроково>'"));
	
	//

	Элемент = УсловноеОформление.Элементы.Добавить();

	ПолеЭлемента = Элемент.Поля.Элементы.Добавить();
	ПолеЭлемента.Поле = Новый ПолеКомпоновкиДанных(Элементы.ИспользованиеВИндивидуальныхСоглашенияхСКлиентамиДатаОкончания.Имя);

	ОтборЭлемента = Элемент.Отбор.Элементы.Добавить(Тип("ЭлементОтбораКомпоновкиДанных"));
	ОтборЭлемента.ЛевоеЗначение = Новый ПолеКомпоновкиДанных("ИспользованиеВИндивидуальныхСоглашенияхСКлиентами.ДатаОкончания");
	ОтборЭлемента.ВидСравнения = ВидСравненияКомпоновкиДанных.Равно;
	ОтборЭлемента.ПравоеЗначение = '00010101';

	ОтборЭлемента = Элемент.Отбор.Элементы.Добавить(Тип("ЭлементОтбораКомпоновкиДанных"));
	ОтборЭлемента.ЛевоеЗначение = Новый ПолеКомпоновкиДанных("ИспользованиеВИндивидуальныхСоглашенияхСКлиентами.ДатаНачала");
	ОтборЭлемента.ВидСравнения = ВидСравненияКомпоновкиДанных.НеРавно;
	ОтборЭлемента.ПравоеЗначение = '00010101';

	Элемент.Оформление.УстановитьЗначениеПараметра("Текст", НСтр("ru='<бессрочно>';uk='<безстроково>'"));
	
	//

	Элемент = УсловноеОформление.Элементы.Добавить();

	ПолеЭлемента = Элемент.Поля.Элементы.Добавить();
	ПолеЭлемента.Поле = Новый ПолеКомпоновкиДанных(Элементы.ИспользованиеВТиповыхСоглашенияхСКлиентамиДатаОкончания.Имя);

	ОтборЭлемента = Элемент.Отбор.Элементы.Добавить(Тип("ЭлементОтбораКомпоновкиДанных"));
	ОтборЭлемента.ЛевоеЗначение = Новый ПолеКомпоновкиДанных("ИспользованиеВТиповыхСоглашенияхСКлиентами.ДатаОкончания");
	ОтборЭлемента.ВидСравнения = ВидСравненияКомпоновкиДанных.Равно;
	ОтборЭлемента.ПравоеЗначение = '00010101';

	ОтборЭлемента = Элемент.Отбор.Элементы.Добавить(Тип("ЭлементОтбораКомпоновкиДанных"));
	ОтборЭлемента.ЛевоеЗначение = Новый ПолеКомпоновкиДанных("ИспользованиеВТиповыхСоглашенияхСКлиентами.ДатаНачала");
	ОтборЭлемента.ВидСравнения = ВидСравненияКомпоновкиДанных.НеРавно;
	ОтборЭлемента.ПравоеЗначение = '00010101';

	Элемент.Оформление.УстановитьЗначениеПараметра("Текст", НСтр("ru='<бессрочно>';uk='<безстроково>'"));
	
	//

	Элемент = УсловноеОформление.Элементы.Добавить();

	ПолеЭлемента = Элемент.Поля.Элементы.Добавить();
	ПолеЭлемента.Поле = Новый ПолеКомпоновкиДанных(Элементы.ИспользованиеНаСкладахДатаОкончания.Имя);

	ОтборЭлемента = Элемент.Отбор.Элементы.Добавить(Тип("ЭлементОтбораКомпоновкиДанных"));
	ОтборЭлемента.ЛевоеЗначение = Новый ПолеКомпоновкиДанных("ИспользованиеНаСкладах.ДатаОкончания");
	ОтборЭлемента.ВидСравнения = ВидСравненияКомпоновкиДанных.Равно;
	ОтборЭлемента.ПравоеЗначение = '00010101';

	ОтборЭлемента = Элемент.Отбор.Элементы.Добавить(Тип("ЭлементОтбораКомпоновкиДанных"));
	ОтборЭлемента.ЛевоеЗначение = Новый ПолеКомпоновкиДанных("ИспользованиеНаСкладах.ДатаНачала");
	ОтборЭлемента.ВидСравнения = ВидСравненияКомпоновкиДанных.НеРавно;
	ОтборЭлемента.ПравоеЗначение = '00010101';

	Элемент.Оформление.УстановитьЗначениеПараметра("Текст", НСтр("ru='<бессрочно>';uk='<безстроково>'"));
	
	//

	Элемент = УсловноеОформление.Элементы.Добавить();

	ПолеЭлемента = Элемент.Поля.Элементы.Добавить();
	ПолеЭлемента.Поле = Новый ПолеКомпоновкиДанных(Элементы.ИспользованиеНаСкладах.Имя);

	ОтборЭлемента = Элемент.Отбор.Элементы.Добавить(Тип("ЭлементОтбораКомпоновкиДанных"));
	ОтборЭлемента.ЛевоеЗначение = Новый ПолеКомпоновкиДанных("ИспользованиеНаСкладах.Статус");
	ОтборЭлемента.ВидСравнения = ВидСравненияКомпоновкиДанных.Равно;
	ОтборЭлемента.ПравоеЗначение = Перечисления.СтатусыДействияСкидок.НеДействует;

	Элемент.Оформление.УстановитьЗначениеПараметра("ЦветТекста", ЦветаСтиля.ЦветТекстаОтмененнойСтрокиДокумента);
	
	//
	
	Элемент = УсловноеОформление.Элементы.Добавить();
	
	ПолеЭлемента = Элемент.Поля.Элементы.Добавить();
	ПолеЭлемента.Поле = Новый ПолеКомпоновкиДанных(Элементы.ИспользованиеНаСкладахСклад.Имя);
	
	ОтборЭлемента = Элемент.Отбор.Элементы.Добавить(Тип("ЭлементОтбораКомпоновкиДанных"));
	ОтборЭлемента.ЛевоеЗначение = Новый ПолеКомпоновкиДанных("ИспользованиеНаСкладах.Склад");
	ОтборЭлемента.ВидСравнения = ВидСравненияКомпоновкиДанных.Равно;
	ОтборЭлемента.ПравоеЗначение = Справочники.Склады.ПустаяСсылка();
	
	Элемент.Оформление.УстановитьЗначениеПараметра("Текст", НСтр("ru='Все склады';uk='Всі склади'"));
	
	//

	Элемент = УсловноеОформление.Элементы.Добавить();

	ПолеЭлемента = Элемент.Поля.Элементы.Добавить();
	ПолеЭлемента.Поле = Новый ПолеКомпоновкиДанных(Элементы.ИспользованиеВКартахЛояльности.Имя);

	ОтборЭлемента = Элемент.Отбор.Элементы.Добавить(Тип("ЭлементОтбораКомпоновкиДанных"));
	ОтборЭлемента.ЛевоеЗначение = Новый ПолеКомпоновкиДанных("ИспользованиеВКартахЛояльности.Статус");
	ОтборЭлемента.ВидСравнения = ВидСравненияКомпоновкиДанных.Равно;
	ОтборЭлемента.ПравоеЗначение = Перечисления.СтатусыДействияСкидок.НеДействует;

	Элемент.Оформление.УстановитьЗначениеПараметра("ЦветТекста", ЦветаСтиля.ЦветТекстаОтмененнойСтрокиДокумента);
	
	//

	Элемент = УсловноеОформление.Элементы.Добавить();

	ПолеЭлемента = Элемент.Поля.Элементы.Добавить();
	ПолеЭлемента.Поле = Новый ПолеКомпоновкиДанных(Элементы.ИспользованиеВИндивидуальныхСоглашенияхСКлиентами.Имя);

	ОтборЭлемента = Элемент.Отбор.Элементы.Добавить(Тип("ЭлементОтбораКомпоновкиДанных"));
	ОтборЭлемента.ЛевоеЗначение = Новый ПолеКомпоновкиДанных("ИспользованиеВИндивидуальныхСоглашенияхСКлиентами.Статус");
	ОтборЭлемента.ВидСравнения = ВидСравненияКомпоновкиДанных.Равно;
	ОтборЭлемента.ПравоеЗначение = Перечисления.СтатусыДействияСкидок.НеДействует;

	Элемент.Оформление.УстановитьЗначениеПараметра("ЦветТекста", ЦветаСтиля.ЦветТекстаОтмененнойСтрокиДокумента);
	
	//

	Элемент = УсловноеОформление.Элементы.Добавить();

	ПолеЭлемента = Элемент.Поля.Элементы.Добавить();
	ПолеЭлемента.Поле = Новый ПолеКомпоновкиДанных(Элементы.ИспользованиеВТиповыхСоглашенияхСКлиентами.Имя);

	ОтборЭлемента = Элемент.Отбор.Элементы.Добавить(Тип("ЭлементОтбораКомпоновкиДанных"));
	ОтборЭлемента.ЛевоеЗначение = Новый ПолеКомпоновкиДанных("ИспользованиеВТиповыхСоглашенияхСКлиентами.Статус");
	ОтборЭлемента.ВидСравнения = ВидСравненияКомпоновкиДанных.Равно;
	ОтборЭлемента.ПравоеЗначение = Перечисления.СтатусыДействияСкидок.НеДействует;

	Элемент.Оформление.УстановитьЗначениеПараметра("ЦветТекста", ЦветаСтиля.ЦветТекстаОтмененнойСтрокиДокумента);
	
КонецПроцедуры

&НаКлиенте
Процедура ОткрытьФормуИзмененияСтатуса(Источник, Статус)
	
	ПараметрыОткрытия = Новый Структура;
	ПараметрыОткрытия.Вставить("ДатаНачала", ДатаСреза);
	ПараметрыОткрытия.Вставить("СкидкаНаценка", СкидкаНаценка);
	ПараметрыОткрытия.Вставить("Источник", Источник);
	ПараметрыОткрытия.Вставить("Статус", Статус);
	
	ОткрытьФорму(
		"Справочник.СкидкиНаценки.Форма.УстановкаСтатусаДействия",
		ПараметрыОткрытия,
		ЭтаФорма);
	
КонецПроцедуры

&НаКлиенте
Процедура ОткрытьФормуИстории(Источник)
	
	ПараметрыОткрытия = Новый Структура;
	ПараметрыОткрытия.Вставить("Источник", Источник);
	ПараметрыОткрытия.Вставить("СкидкаНаценка", СкидкаНаценка);
	ОткрытьФорму(
		"Справочник.СкидкиНаценки.Форма.ИсторияДействияСкидкиНаценки",
		ПараметрыОткрытия,
		ЭтаФорма);
	
КонецПроцедуры

&НаСервере
Процедура ОбновитьДанныеНаСервере()
	
	ДинамическиеСписки = Новый Массив;
	ДинамическиеСписки.Добавить(ИспользованиеВИндивидуальныхСоглашенияхСКлиентами);
	ДинамическиеСписки.Добавить(ИспользованиеВТиповыхСоглашенияхСКлиентами);
	ДинамическиеСписки.Добавить(ИспользованиеВКартахЛояльности);
	ДинамическиеСписки.Добавить(ИспользованиеНаСкладах);
	
	Для Каждого ДинамическийСписок Из ДинамическиеСписки Цикл
		
		ОбщегоНазначенияКлиентСервер.УстановитьПараметрДинамическогоСписка(
			ДинамическийСписок,
			"ТекущаяДата",
			ДатаСреза,
			Истина);
			
	КонецЦикла;
	
	ОбновитьИспользованиеСкидокНаценок();
	
КонецПроцедуры

&НаСервере
Процедура ОбновитьИспользованиеСкидокНаценок()
	
	ДополнительнаяКоманда = "ИзменитьОбщийСтатус";
	
	ИспользованиеСкидкиНаценки = СкидкиНаценкиСервер.ИспользованиеСкидкиНаценки(СкидкаНаценка, ДатаСреза);
	СкидкиНаценкиСервер.СформироватьИнформационнуюНадписьИспользованиеСкидокНаценок(ИнформацияОДействииСкидок,
	                                                                                ИспользованиеСкидкиНаценки,
	                                                                                ДополнительнаяКоманда);
	СкидкиНаценкиСервер.СформироватьИнформациюОКоличествеИспользуемыхСкидок(ЭтотОбъект, ИспользованиеСкидкиНаценки);
	
КонецПроцедуры

#КонецОбласти
