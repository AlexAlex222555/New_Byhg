
#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)

	ОбновлениеИнформационнойБазы.ПроверитьОбъектОбработан(Объект, ЭтотОбъект);
	
	Если Объект.Ссылка.Пустая() Тогда
		ЗаполнитьПолеВидовАналитик(Ложь);
	КонецЕсли;
	
	КонтрольЛимитов = ПолучитьФункциональнуюОпцию("ИспользоватьЛимитыРасходаДенежныхСредствБюджетирования");
	Элементы.ГруппаЛимиты.Видимость = КонтрольЛимитов;
	
	ЭтаФорма.КлючСохраненияПоложенияОкна = "ПравилаЛимитовПоДаннымБюджетирования.Форма.Лимиты_" + КонтрольЛимитов;
	
	// СтандартныеПодсистемы.ЗапретРедактированияРеквизитовОбъектов
	ЗапретРедактированияРеквизитовОбъектов.ЗаблокироватьРеквизиты(ЭтаФорма);
	УправлениеФормой();
	// Конец СтандартныеПодсистемы.ЗапретРедактированияРеквизитовОбъектов
	
КонецПроцедуры

&НаСервере
Процедура ПриЧтенииНаСервере(ТекущийОбъект)

	// СтандартныеПодсистемы.УправлениеДоступом
	Если ОбщегоНазначения.ПодсистемаСуществует("СтандартныеПодсистемы.УправлениеДоступом") Тогда
		МодульУправлениеДоступом = ОбщегоНазначения.ОбщийМодуль("УправлениеДоступом");
		МодульУправлениеДоступом.ПриЧтенииНаСервере(ЭтотОбъект, ТекущийОбъект);
	КонецЕсли;
	// Конец СтандартныеПодсистемы.УправлениеДоступом
	
	ЗаполнитьПолеВидовАналитик(Ложь);
КонецПроцедуры

&НаСервере
Процедура ПередЗаписьюНаСервере(Отказ, ТекущийОбъект, ПараметрыЗаписи)
	
	ТекущийОбъект.ИерархияАналитик.Загрузить(ИерархияАналитик.Выгрузить());
	ТекущийОбъект.ИерархияАналитикПерезаписана = Истина;
	
КонецПроцедуры

&НаСервере
Процедура ПослеЗаписиНаСервере(ТекущийОбъект, ПараметрыЗаписи)

	// СтандартныеПодсистемы.УправлениеДоступом
	УправлениеДоступом.ПослеЗаписиНаСервере(ЭтотОбъект, ТекущийОбъект, ПараметрыЗаписи);
	// Конец СтандартныеПодсистемы.УправлениеДоступом

	// СтандартныеПодсистемы.ЗапретРедактированияРеквизитовОбъектов
	ЗапретРедактированияРеквизитовОбъектов.ЗаблокироватьРеквизиты(ЭтаФорма);
	УправлениеФормой();
	// Конец СтандартныеПодсистемы.ЗапретРедактированияРеквизитовОбъектов
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовШапкиФормы

&НаКлиенте
Процедура СтатьяПоказательБюджетаПриИзменении(Элемент)
	
	СтатьяПоказательБюджетаПриИзмененииНаСервере();
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовТаблицыФормыИерархияАналитик

&НаКлиенте
Процедура ИерархияАналитикПриИзменении(Элемент)
	ОбновитьПредставлениеИерархииАналитик(ИерархияАналитик);
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура Подключаемый_РазрешитьРедактированиеРеквизитовОбъекта(Команда)
	
	ОписаниеОповещения = Новый ОписаниеОповещения("ОповещениеОРазблокировке", ЭтаФорма);
	ОбщегоНазначенияУТКлиент.РазрешитьРедактированиеРеквизитовОбъекта(ЭтаФорма,, ОписаниеОповещения);
	
КонецПроцедуры

&НаКлиенте
Процедура ПометитьВсеАналитики(Команда)
	Для Каждого СтрокаИерархии Из ИерархияАналитик Цикл
		СтрокаИерархии.Используется = Истина;
	КонецЦикла;
КонецПроцедуры

&НаКлиенте
Процедура СнятьПометкуВсехАналитик(Команда)
	Для Каждого СтрокаИерархии Из ИерархияАналитик Цикл
		СтрокаИерархии.Используется = Ложь;
	КонецЦикла;
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаСервере
Процедура СтатьяПоказательБюджетаПриИзмененииНаСервере()
	
	Объект.Наименование = ОбщегоНазначения.ЗначениеРеквизитаОбъекта(Объект.СтатьяБюджета, "Наименование");
	ЗаполнитьПолеВидовАналитик();
	
КонецПроцедуры

&НаСервере
Процедура ЗаполнитьПолеВидовАналитик(ИнтерактивноеОбновление = Истина)
	
	Если Не ЗначениеЗаполнено(Объект.СтатьяБюджета) Тогда
		ИерархияАналитик.Очистить();
		Возврат;
	КонецЕсли;
	
	Если ИнтерактивноеОбновление Тогда
		ИсточникЗаданнойИерархии = ИерархияАналитик.Выгрузить(, "Используется, ВидАналитики, ИмяИзмерения");
		ИсточникЗаданнойИерархии.Колонки.Добавить("НомерСтроки",
			Новый ОписаниеТипов("Число", Новый КвалификаторыЧисла(2, 0, ДопустимыйЗнак.Неотрицательный)));
		СчетчикСтрок = 0;
		Для Каждого СтрокаИерархии Из ИсточникЗаданнойИерархии Цикл
			СчетчикСтрок = СчетчикСтрок + 1;
			СтрокаИерархии.НомерСтроки  = СчетчикСтрок;
		КонецЦикла;
	Иначе
		ИсточникЗаданнойИерархии = Объект.ИерархияАналитик.Выгрузить();
		Если НЕ Объект.ИерархияАналитикПерезаписана Тогда
			ИсточникЗаданнойИерархии.ЗаполнитьЗначения(Истина, "Используется");
		КонецЕсли;
	КонецЕсли;
	
	ИерархияАналитик.Очистить();
	
	ТаблицаИерархии = Справочники.ПравилаЛимитовПоДаннымБюджетирования.ИерархияАналитик(
		Объект.Владелец,
		Объект.СтатьяБюджета,
		ИсточникЗаданнойИерархии);
	
	ИерархияАналитик.Загрузить(ТаблицаИерархии);
	
	ОбновитьПредставлениеИерархииАналитик(ИерархияАналитик);
	
	Если НЕ ИнтерактивноеОбновление Тогда
		// Проверка при чтении, что отображаемая иерархия аналитик
		// не совпадает с иерархией аналитик в объекте.
		// Необходимо установить флаг модифицированности.
		Если НЕ Модифицированность Тогда
			Если ТаблицаИерархии.Количество() <> Объект.ИерархияАналитик.Количество() Тогда
				Модифицированность = Истина;
			Иначе
				ИндексСтроки = 0;
				Для каждого СтрокаИерархии Из ТаблицаИерархии Цикл
					СтрокаИерархииОбъекта = Объект.ИерархияАналитик[ИндексСтроки];
					Если СтрокаИерархииОбъекта.ВидАналитики <> СтрокаИерархии.ВидАналитики
						ИЛИ СтрокаИерархииОбъекта.ИмяИзмерения <> СтрокаИерархии.ИмяИзмерения
						ИЛИ СтрокаИерархииОбъекта.Используется <> СтрокаИерархии.Используется Тогда
						Модифицированность = Истина;
						Прервать;
					КонецЕсли;
					ИндексСтроки = ИндексСтроки + 1;
				КонецЦикла;
			КонецЕсли;
			Если Модифицированность Тогда
				Сообщение = Новый СообщениеПользователю;
				Сообщение.Текст = НСтр("ru='Изменена иерархия аналитик';uk='Змінена ієрархія аналітик'");
				Сообщение.Поле = "ИерархияАналитик";
				Сообщение.Сообщить();
			КонецЕсли;
		КонецЕсли;
	КонецЕсли;
	
КонецПроцедуры

&НаКлиентеНаСервереБезКонтекста
Процедура ОбновитьПредставлениеИерархииАналитик(ИерархияАналитик)
	Префикс = "";
	Для каждого СтрокаТаблицы Из ИерархияАналитик Цикл
		СтрокаТаблицы.ПредставлениеВИерархии = Префикс + СтрокаТаблицы.Представление;
		Префикс = Префикс + "   ";
	КонецЦикла;
КонецПроцедуры

&НаКлиенте
Процедура ОповещениеОРазблокировке(Результат, ДополнительныеПараметры) Экспорт
	
	УправлениеФормой();
	
КонецПроцедуры

&НаСервере
Процедура УправлениеФормой()
	
	Если Элементы.СтатьяБюджетов.ТолькоПросмотр Тогда
		Элементы.ИерархияАналитик.ТолькоПросмотр = Истина;
		Элементы.ИерархияАналитикПометитьВсеАналитики.Доступность = Ложь;
		Элементы.ИерархияАналитикСнятьПометкуВсехАналитик.Доступность = Ложь;
	Иначе
		Элементы.ИерархияАналитик.ТолькоПросмотр = Ложь;
		Элементы.ИерархияАналитикПометитьВсеАналитики.Доступность = Истина;
		Элементы.ИерархияАналитикСнятьПометкуВсехАналитик.Доступность = Истина;
	КонецЕсли;
	
КонецПроцедуры



#КонецОбласти

