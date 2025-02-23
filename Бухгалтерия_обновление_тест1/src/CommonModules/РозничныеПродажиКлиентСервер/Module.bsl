
#Область ПрограммныйИнтерфейс



// Обновляет данные информационной панели
//
// Параметры:
//  Форма - ФормаКлиентскогоПриложения - Форма, на которой расположена информационная панель
//  Данные - Структура - Структура с данными информационной панели.
//
Процедура ОбновитьДанныеИнформационнойПанели(Форма, Данные) Экспорт
	
	Если Данные = Неопределено Тогда
		Форма.ИнформационнаяПанельНаименованиеТовара      = "";
		Форма.ИнформационнаяПанельРасчетСуммы             = "";
		Форма.ИнформационнаяПанельПрочиеПараметрыИмя      = "";
		Форма.ИнформационнаяПанельПрочиеПараметрыЗначение = "";
		Возврат;
	КонецЕсли;
	
	Если Данные.ОтобразитьСдачу Тогда
		
		ТекстНачисленныеБонусныеБаллы = "";
		Если Данные.Свойство("ТекстНачисленныеБонусныеБаллы") Тогда
			ТекстНачисленныеБонусныеБаллы = Данные.ТекстНачисленныеБонусныеБаллы;
		КонецЕсли;
		
		Форма.ИнформационнаяПанельНаименованиеТовара      = ТекстНачисленныеБонусныеБаллы;
		Форма.ИнформационнаяПанельРасчетСуммы             = Данные.ТекстСдача;
		Форма.ИнформационнаяПанельПрочиеПараметрыИмя      = "";
		Форма.ИнформационнаяПанельПрочиеПараметрыЗначение = "";
		Возврат;
	КонецЕсли;
	
	НаименованиеТовара = Новый ФорматированнаяСтрока(Данные.НаименованиеТовара);
	ДанныеСтроки       = Данные.ДанныеСтроки;
	СуммовыеПараметры  = Данные.СуммовыеПараметры;
	
	РасчетСуммы = Новый ФорматированнаяСтрока("");
	
	Формат = ФорматнаяСтрока(СуммовыеПараметры.Цена, 2);
	
	Если СуммовыеПараметры.Сумма <> 0 Тогда
		
		// Количество x Цена
		ФорматКоличество = ФорматнаяСтрока(СуммовыеПараметры.Количество, 3);
		ЦенаКоличество = СтрШаблон("%1 x %2",
			Формат(СуммовыеПараметры.Количество, ФорматКоличество),
			Формат(СуммовыеПараметры.Цена, Формат));
			
		// Ручная скидка
		Формат = ФорматнаяСтрока(СуммовыеПараметры.СуммаРучнойСкидки, 2);
		РучнаяСкидка = Новый ФорматированнаяСтрока("");
		Если СуммовыеПараметры.Свойство("СуммаРучнойСкидки") Тогда
			Если СуммовыеПараметры.СуммаРучнойСкидки > 0 Тогда
				РучнаяСкидка = Новый ФорматированнаяСтрока(
					РучнаяСкидка,
					" - ",
					Новый ФорматированнаяСтрока(Формат(СуммовыеПараметры.СуммаРучнойСкидки, Формат),,,,"РучнаяСкидка"));
				РучнаяСкидка = Новый ФорматированнаяСтрока(
					РучнаяСкидка,
					Новый ФорматированнаяСтрока(" ( " + Формат(СуммовыеПараметры.ПроцентРучнойСкидки, Формат) + "%" + " )",,,,"РучнаяСкидка"));
			КонецЕсли;
			Если СуммовыеПараметры.СуммаРучнойСкидки < 0 Тогда
				РучнаяСкидка = Новый ФорматированнаяСтрока(
					РучнаяСкидка,
					" + ",
					Новый ФорматированнаяСтрока(Формат(-СуммовыеПараметры.СуммаРучнойСкидки, Формат),,,,"РучнаяСкидка"));
				РучнаяСкидка = Новый ФорматированнаяСтрока(
					РучнаяСкидка,
					Новый ФорматированнаяСтрока(" ( " + Формат(-СуммовыеПараметры.ПроцентРучнойСкидки, Формат) + "%" + " )",,,,"РучнаяСкидка"));
			КонецЕсли;
		КонецЕсли;
		
		// Автоматическая скидка
		Формат = ФорматнаяСтрока(СуммовыеПараметры.СуммаАвтоматическойСкидки, 2);
		АвтоматическаяСкидка = Новый ФорматированнаяСтрока("");
		Если СуммовыеПараметры.Свойство("СуммаАвтоматическойСкидки") Тогда
			Если СуммовыеПараметры.СуммаАвтоматическойСкидки > 0 Тогда
				АвтоматическаяСкидка = Новый ФорматированнаяСтрока(
					АвтоматическаяСкидка,
					" - ",
					Новый ФорматированнаяСтрока(Формат(СуммовыеПараметры.СуммаАвтоматическойСкидки, Формат),,,,"АвтоматическаяСкидка"));
				АвтоматическаяСкидка = Новый ФорматированнаяСтрока(
					АвтоматическаяСкидка,
					Новый ФорматированнаяСтрока(" ( " + Формат(СуммовыеПараметры.ПроцентАвтоматическойСкидки,  Формат) + "%" + " )",,,,"АвтоматическаяСкидка"));
			КонецЕсли;
			Если СуммовыеПараметры.СуммаАвтоматическойСкидки < 0 Тогда
				АвтоматическаяСкидка = Новый ФорматированнаяСтрока(
					АвтоматическаяСкидка,
					" + ",
					Новый ФорматированнаяСтрока(Формат(-СуммовыеПараметры.СуммаАвтоматическойСкидки, Формат),,,,"АвтоматическаяСкидка"));
				АвтоматическаяСкидка = Новый ФорматированнаяСтрока(
					АвтоматическаяСкидка,
					Новый ФорматированнаяСтрока(" ( " + Формат(-СуммовыеПараметры.ПроцентАвтоматическойСкидки, Формат) + "%" + " )",,,,"АвтоматическаяСкидка"));
			КонецЕсли;
		КонецЕсли;
		
		// Сумма
		Формат = ФорматнаяСтрока(СуммовыеПараметры.Сумма, 2);
		Сумма  = " = " + Формат(СуммовыеПараметры.Сумма, Формат);
		
		РасчетСуммы = Новый ФорматированнаяСтрока(
			ЦенаКоличество,
			РучнаяСкидка,
			АвтоматическаяСкидка,
			Сумма
		);
		
	КонецЕсли;
	
	ВыводитьПиктограммуСообщенийОколоКарты = Ложь;
	Если Данные.Свойство("СтруктураСообщений")
		И Данные.СтруктураСообщений <> Неопределено
		И Данные.СтруктураСообщений.Сообщения.Количество() > 0 Тогда
		
		Если ДанныеСтроки.Количество() <= 2
			Или (ДанныеСтроки.Свойство("Карта") И Не ЗначениеЗаполнено(ДанныеСтроки.Карта)) Тогда
			
			НепрочитанныхСообщений = 0;
			Для Каждого СтрокаТЧ Из Данные.СтруктураСообщений.Сообщения Цикл
				Если СтрокаТЧ.НапомнитьПозже Тогда
					НепрочитанныхСообщений = НепрочитанныхСообщений + 1;
				КонецЕсли;
			КонецЦикла;
			
			Если НепрочитанныхСообщений > 0 Тогда
				Текст = СтрШаблон(НСтр("ru='Новые (%1)';uk='Нові (%1)'"), НепрочитанныхСообщений);
			Иначе
				Текст = Данные.СтруктураСообщений.Сообщения.Количество();
			КонецЕсли;
			
			ДанныеСтроки.Вставить("Сообщения", Текст);
			
		Иначе
			ВыводитьПиктограммуСообщенийОколоКарты = Истина;
		КонецЕсли;
		
	КонецЕсли;
	
	Имена = Новый ФорматированнаяСтрока("");
	Значения = Новый ФорматированнаяСтрока("");
	Для Каждого ЭлементСтруктуры Из ДанныеСтроки Цикл
		
		Разделитель = "";
		Если ЗначениеЗаполнено(Имена) Тогда
			Разделитель = Символы.ПС;
		КонецЕсли;
		
		Суффикс = "";
		Цвет = Неопределено;
		
		Если ЭлементСтруктуры.Ключ = "Карта" И ВыводитьПиктограммуСообщенийОколоКарты Тогда
			Значение = Новый ФорматированнаяСтрока(
				Строка(ЭлементСтруктуры.Значение),
				Новый ФорматированнаяСтрока(БиблиотекаКартинок.Информация16,,,,"Сообщения"));
		Иначе
			Значение = Строка(ЭлементСтруктуры.Значение);
		КонецЕсли;
		
		Если Данные.ОбязательныеРеквизиты.Найти(ЭлементСтруктуры.Ключ) <> Неопределено
			И Не ЗначениеЗаполнено(ЭлементСтруктуры.Значение) Тогда
			
			#Если Клиент Тогда
				Цвет = ОбщегоНазначенияКлиентПовтИсп.ЦветСтиля("ПоясняющийОшибкуТекст");
			#Иначе
				Цвет = ЦветаСтиля.ПоясняющийОшибкуТекст;
			#КонецЕсли
			
			Значение = НСтр("ru='<не заполнено>';uk='<не заповнено>'");
			Суффикс = "ЗначениеНеЗаполнено";
			
		ИначеЕсли Не ЗначениеЗаполнено(ЭлементСтруктуры.Значение) Тогда
			
			Продолжить;
			
		КонецЕсли;
		
		Если ЭлементСтруктуры.Ключ = "Сообщения" Тогда
			ЭлементСтруктурыКлючПредставление = НСтр("ru='Сообщения';uk='Повідомлення'");
		ИначеЕсли ЭлементСтруктуры.Ключ = "Продавец" Тогда
			ЭлементСтруктурыКлючПредставление = НСтр("ru='Продавец';uk='Продавець'");
		ИначеЕсли ЭлементСтруктуры.Ключ = "Помещение" Тогда
			ЭлементСтруктурыКлючПредставление = НСтр("ru='Помещение';uk='Приміщення'");
		ИначеЕсли ЭлементСтруктуры.Ключ = "Карта" Тогда
			ЭлементСтруктурыКлючПредставление = НСтр("ru='Карта';uk='Карта'");
		ИначеЕсли ЭлементСтруктуры.Ключ = "Номинал" Тогда
			ЭлементСтруктурыКлючПредставление = НСтр("ru='Номинал';uk='Номінал'");
		ИначеЕсли ЭлементСтруктуры.Ключ = "Статус" Тогда
			ЭлементСтруктурыКлючПредставление = НСтр("ru='Статус';uk='Статус'");
		Иначе
			ЭлементСтруктурыКлючПредставление = ЭлементСтруктуры.Ключ;
		КонецЕсли;
	
		Имена = Новый ФорматированнаяСтрока(
			Имена,
			Разделитель,
			ЭлементСтруктурыКлючПредставление + ":");
		
		Значения = Новый ФорматированнаяСтрока(
			Значения,
			Разделитель,
			Новый ФорматированнаяСтрока(Значение,,Цвет,,ЭлементСтруктуры.Ключ + Суффикс));
		
	КонецЦикла;
	
	Форма.ИнформационнаяПанельРасчетСуммы             = РасчетСуммы;
	Форма.ИнформационнаяПанельНаименованиеТовара      = НаименованиеТовара;
	Форма.ИнформационнаяПанельПрочиеПараметрыИмя      = Имена;
	Форма.ИнформационнаяПанельПрочиеПараметрыЗначение = Значения;
	
КонецПроцедуры

// Структура данных для повтора операции записи.
// 
// Возвращаемое значение:
//  Структура - Данные для повтора операции записи.
//
Функция СтруктураПовтораЗаписи() Экспорт
	
	СтруктураПовтораЗаписи = Новый Структура;
	СтруктураПовтораЗаписи.Вставить("РеквизитыФискальнойОперацииКассовогоУзла");
	СтруктураПовтораЗаписи.Вставить("ОписаниеОповещения");
	СтруктураПовтораЗаписи.Вставить("ТекстСообщения");
	СтруктураПовтораЗаписи.Вставить("ВозвращатьРезультатФункции");
	СтруктураПовтораЗаписи.Вставить("РезультатПриУспешномПроведении");
	СтруктураПовтораЗаписи.Вставить("РезультатПриОтмене");
	СтруктураПовтораЗаписи.Вставить("ИмяПроцедуры");
	СтруктураПовтораЗаписи.Вставить("ПараметрыПроцедуры");
	СтруктураПовтораЗаписи.Вставить("РезультатОперации");
	
	Возврат СтруктураПовтораЗаписи;
	
КонецФункции


#КонецОбласти

#Область СлужебныеПроцедурыИФункции

Функция ФорматнаяСтрока(Число, РазрядностьДробнойЧасти)
	
	Если Цел(Число) = Число Тогда
		Возврат "ЧН=0; ЧДЦ=;";
	Иначе
		Возврат "ЧН=0; ЧДЦ=" + РазрядностьДробнойЧасти;
	КонецЕсли
	
КонецФункции

#КонецОбласти
