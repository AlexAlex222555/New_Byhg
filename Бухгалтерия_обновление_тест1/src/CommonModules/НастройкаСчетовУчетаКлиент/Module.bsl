
#Область ПрограммныйИнтерфейс

// Выполняет обработку закрытия формы настройки счетов учета.
// Вызывается в обработчике ОбработкаОповещения() формы объекта.
// 
// Параметры:
// 	Форма - ФормаКлиентскогоПриложения - Форма объекта
// 	ИмяСобытия - Строка - Имя события оповещения
// 	Параметр - Произвольный - Параметр оповещения 
//
Процедура ЗаконченаНастройкаСчетовУчета(Форма, ИмяСобытия, Параметр) Экспорт
	//++ Локализация
	//++ НЕ УТ
	ДанныеНастройкиСчетовУчета = ОбщегоНазначенияУТКлиентСервер.ПолучитьДанныеМеханизмаИзКэшаФормы(Форма, "НастройкаСчетовУчета");
	Если ИмяСобытия = "ЗаконченаНастройкаСчетовУчета" И Параметр = Форма.Объект.Ссылка
		И ДанныеНастройкиСчетовУчета <> Неопределено И ДанныеНастройкиСчетовУчета.ИспользуетсяНастройкаИсключений Тогда
		РазделУчета = НастройкаСчетовУчетаКлиентСервер.РазделУчетаПоНастройкам(ДанныеНастройкиСчетовУчета);
		Форма.НастройкаСчетовУчета_Ссылка = НастройкаСчетовУчетаСлужебныйВызовСервера.СсылкаНастройкаСчетовУчета(Параметр, РазделУчета);
	КонецЕсли;
	//-- НЕ УТ
	//-- Локализация
КонецПроцедуры

// Выполняет обработку навигационной ссылки открытия формы настройки счетов.
// 
// Параметры:
// 	Форма - ФормаКлиентскогоПриложения - Форма объекта
// 	НавигационнаяСсылка - Строка - Навигационная ссылка
// 	СтандартнаяОбработка - Булево - флаг СтандартнаяОбработка события
//
Процедура ОбработкаНавигационнойСсылкиНастройкаСчетовУчета(Форма, НавигационнаяСсылка, СтандартнаяОбработка) Экспорт
	//++ Локализация
	//++ НЕ УТ
	СтандартнаяОбработка = Ложь;
	ИмяОткрываемойФормы = ?(НавигационнаяСсылка = "ОткрытьНастройкуСчетовУчета",
		"РегистрСведений.ПорядокОтраженияНаСчетахУчета.Форма.ФормаНастройкиДинамически",
		"Обработка.НастройкаОтраженияДокументовВРеглУчете.Форма.ФормаНастройки");
	ОткрытьФормуНастройкиСПроверкойЗаписи(ИмяОткрываемойФормы, Форма);
	//-- НЕ УТ
	//-- Локализация
КонецПроцедуры

// Выполняет обработку изменения счетов учета аналитики учета.
// 
// Параметры:
// 	ИмяЭлемента - Строка - Имя элемента настройки счета учета
// 	Форма - ФормаКлиентскогоПриложения - Форма объекта настройки
//
Процедура ПриИзмененииСчетаУчета(Элемент, Форма) Экспорт
	//++ Локализация
	Если Не Форма.КэшДанныхМеханизмов.Свойство("НастройкаСчетовУчета") Тогда
		Возврат;
	КонецЕсли;
	//++ НЕ УТ
	Настройка = Форма.КэшДанныхМеханизмов.НастройкаСчетовУчета;
	РеквизитыОбъекта = Настройка.РеквизитыАналитики;
	ИмяРеквизита = НастройкаСчетовУчетаКлиентСервер.ИмяЭлементаНастройкиПоИмениЭлементаФормы(Элемент.Имя, Истина);
	Если РеквизитыОбъекта.Свойство(ИмяРеквизита) Тогда
		НастройкаСчетовУчетаКлиентСервер.УстановитьСвойстваЭлементовНастройкиСчетовУчета(Форма);
	КонецЕсли;
	Если Настройка.СворачиваемыеГруппы.Количество() Тогда
		ИмяРеквизита = НастройкаСчетовУчетаКлиентСервер.ИмяЭлементаНастройкиПоИмениЭлементаФормы(Элемент.Имя, Ложь);
		Если ИмяРеквизита = "НастройкаСворачиваемостиГрупп" Тогда
			ГруппаНастройкиСчетовУчета = Элемент.Родитель;
			ИмяРеквизитаСворачиваемости = Настройка.ПрефиксПутиКДанным + ИмяРеквизита;
			Для каждого ПодчиненнаяГруппа Из ГруппаНастройкиСчетовУчета.ПодчиненныеЭлементы Цикл
				Если ТипЗнч(ПодчиненнаяГруппа) = Тип("ГруппаФормы") И ПодчиненнаяГруппа.Поведение = ПоведениеОбычнойГруппы.Свертываемая Тогда
					Если ПодчиненнаяГруппа.Скрыта() И Форма[ИмяРеквизитаСворачиваемости] = "ПоказатьВсе" Тогда
						ПодчиненнаяГруппа.Показать();
					ИначеЕсли Не ПодчиненнаяГруппа.Скрыта() И Форма[ИмяРеквизитаСворачиваемости] = "СвернутьВсе" Тогда
						ПодчиненнаяГруппа.Скрыть();
					КонецЕсли;
				КонецЕсли;
			КонецЦикла;
		КонецЕсли;
		// Возможно это счет, проверим, входит ли он в сворачиваемую группу:
		РазделУчета = НастройкаСчетовУчетаКлиентСервер.РазделУчетаПоНастройкам(Форма.КэшДанныхМеханизмов.НастройкаСчетовУчета);
		ГруппаСчетаУчета = НастройкаСчетовУчетаКлиентСервер.ГруппаСчетаУчета(ИмяРеквизита, РазделУчета, Настройка.РедактированиеВСписке);
		Если ГруппаСчетаУчета <> Неопределено И Настройка.СворачиваемыеГруппы.Найти(ГруппаСчетаУчета.ИмяГруппы) <> Неопределено Тогда
			ГруппаНаФорме = Форма.Элементы.Найти(НастройкаСчетовУчетаКлиентСервер.ИмяЭлементаНаФорме(Настройка,, ГруппаСчетаУчета.ИмяГруппы, "Группа"));
			Если ГруппаНаФорме <> Неопределено Тогда
				ГруппаНаФорме.ЗаголовокСвернутогоОтображения = ГруппаНаФорме.Заголовок + НастройкаСчетовУчетаКлиентСервер.ДопПредставлениеГруппы(Форма, ГруппаСчетаУчета.ИмяГруппы);
			КонецЕсли;
		КонецЕсли;
	КонецЕсли;
	//-- НЕ УТ
	//-- Локализация
КонецПроцедуры

#Область НастройкаСчетовУчетаПрочихОпераций

// Вызывается в обработчике "Нажатие" гиперссылки элемента настройки.
// 
// Параметры:
// 	Форма - ФормаКлиентскогоПриложения - Форма объекта настройки.
// 	Элемент - ПолеФормы - Элемент настройки.
// 	СтандартнаяОбработка - Булево - Признак стандартной обработки события.
// 	Оповещение - ОписаниеОповещения - Описание оповещения, которое необходимо выполнить после окончания настройки.
//
Процедура ПриНажатии(Форма, Элемент, СтандартнаяОбработка, Оповещение = Неопределено) Экспорт
	
	//++ Локализация
	//++ НЕ УТ
	
	ДанныеНастройкиСчетовУчета = ОбщегоНазначенияУТКлиентСервер.ПолучитьДанныеМеханизмаИзКэшаФормы(Форма, "НастройкаСчетовУчета");
	Если ДанныеНастройкиСчетовУчета = Неопределено ИЛИ Не ДанныеНастройкиСчетовУчета.ДоступнаНастройкиСчетовУчета Тогда
		Возврат;
	КонецЕсли;
	ИндексПараметров = Неопределено;
	Если НЕ ДанныеНастройкиСчетовУчета.СоответствиеПараметровНастройкиЭлементамФормы.Свойство(Элемент.Имя, ИндексПараметров) Тогда
		Возврат;
	КонецЕсли;
	ПараметрыНастройки = ДанныеНастройкиСчетовУчета.МассивПараметровНастройки.Получить(ИндексПараметров);
	
	СтандартнаяОбработка = Ложь;
	ТаблицаФормы = ОбщегоНазначенияУТКлиентСервер.ТаблицаФормыЭлемента(Элемент);
	Если ТаблицаФормы <> Неопределено Тогда
		ИдентификаторСтроки = ТаблицаФормы.ТекущаяСтрока;
	КонецЕсли;
	Данные = НастройкаСчетовУчетаКлиентСервер.ДанныеПоПути(Форма, ПараметрыНастройки.ПутьКДанным, ИдентификаторСтроки);
	Если ТипЗнч(Данные) = Тип("ДанныеФормыКоллекция") Тогда
		// Редактируем таблицу в режиме "Без разбиения"
		Данные = Данные[0];
	КонецЕсли;
	
	ДанныеНастройки = Новый Структура;
	ДанныеНастройки.Вставить("СчетУчета", Данные[ПараметрыНастройки.СчетУчета]);
	ДанныеНастройки.Вставить("Субконто1", Данные[ПараметрыНастройки.Субконто1]);
	ДанныеНастройки.Вставить("Субконто2", Данные[ПараметрыНастройки.Субконто2]);
	ДанныеНастройки.Вставить("Субконто3", Данные[ПараметрыНастройки.Субконто3]);
	
	ПараметрыФормыНастройки = Новый Структура;
	ПараметрыФормыНастройки.Вставить("ДанныеНастройки", ДанныеНастройки);
	ПараметрыФормыНастройки.Вставить("ТолькоПросмотр",  Форма.ТолькоПросмотр);
	ПараметрыФормыНастройки.Вставить("КонтекстНастройки", НастройкаСчетовУчетаКлиентСервер.КонтекстНастройки(Форма, ПараметрыНастройки, ИдентификаторСтроки));
	ПараметрыФормыНастройки.Вставить("ИсточникиПодбораСубконто", ПараметрыНастройки.ИсточникиПодбораСубконто);
	
	ДополнительныеПараметры = Новый Структура;
	ДополнительныеПараметры.Вставить("Форма", Форма);
	ДополнительныеПараметры.Вставить("ИдентификаторСтроки", ИдентификаторСтроки);
	ДополнительныеПараметры.Вставить("ИмяЭлементаНастройки", Элемент.Имя);
	ДополнительныеПараметры.Вставить("ПараметрыНастройки", ПараметрыНастройки);
	ДополнительныеПараметры.Вставить("ОповещениеПослеЗавершения", Оповещение);
	
	ОписаниеОповещения = Новый ОписаниеОповещения("НастройкаОтраженияОперацииЗавершение", ЭтотОбъект, ДополнительныеПараметры);
	
	ОткрытьФорму("ОбщаяФорма.НастройкаСчетаУчетаОперации", ПараметрыФормыНастройки, Форма, , , , ОписаниеОповещения); 
	
	//-- НЕ УТ
	//-- Локализация
	
КонецПроцедуры

#КонецОбласти

#Область НастройкаВыбораСубконто

Процедура ОбработкаПроводокПриИзмененииОрганизации(Проводка, ТипыСвязанныеСОрганизацией)  Экспорт
	
	Для Инд = 1 По 3 Цикл
		ЗначениеСубконто = Проводка["СубконтоДт" + Инд];
		Если ЗначениеЗаполнено(ЗначениеСубконто)
			И ТипыСвязанныеСОрганизацией.СодержитТип(ТипЗнч(ЗначениеСубконто)) Тогда
			МассивТипов = Новый Массив;
			МассивТипов.Добавить(ТипЗнч(ЗначениеСубконто));
			ОписаниеТипаСубконто = Новый ОписаниеТипов(МассивТипов);
			Проводка["СубконтоДт" + Инд] = ОписаниеТипаСубконто.ПривестиЗначение(Неопределено);
		КонецЕсли;
	КонецЦикла;
	
	Для Инд = 1 По 3 Цикл
		ЗначениеСубконто = Проводка["СубконтоКт" + Инд];
		Если ЗначениеЗаполнено(ЗначениеСубконто)
			И ТипыСвязанныеСОрганизацией.СодержитТип(ТипЗнч(ЗначениеСубконто)) Тогда
			МассивТипов = Новый Массив;
			МассивТипов.Добавить(ТипЗнч(ЗначениеСубконто));
			ОписаниеТипаСубконто = Новый ОписаниеТипов(МассивТипов);
			Проводка["СубконтоКт" + Инд] = ОписаниеТипаСубконто.ПривестиЗначение(Неопределено);
		КонецЕсли;
	КонецЦикла;
	
	Если ЗначениеЗаполнено(Проводка.ПодразделениеДт) Тогда
		Проводка.ПодразделениеДт = Неопределено;
	КонецЕсли;
	
	Если ЗначениеЗаполнено(Проводка.ПодразделениеКт) Тогда
		Проводка.ПодразделениеДт = Неопределено;
	КонецЕсли;
	
КонецПроцедуры

Процедура ИзменитьПараметрыВыбораПолейСубконто(Форма, СтрокаТаблицы, Организация, ДтКт = "")  Экспорт
	
	Если ДтКт <> "Кт" Тогда
		ПараметрыДокумента = НастройкаСчетовУчетаКлиентСервер.ПараметрыВыбораСубконто(Организация, СтрокаТаблицы, "СубконтоДт%Индекс%", "СчетДт");
		НастройкаСчетовУчетаКлиентСервер.ИзменитьПараметрыВыбораПолейСубконто(
		Форма, СтрокаТаблицы, "СубконтоДт%Индекс%", "СубконтоДт%Индекс%", ПараметрыДокумента);
	КонецЕсли;
	Если ДтКт <> "Дт" Тогда
		ПараметрыДокумента = НастройкаСчетовУчетаКлиентСервер.ПараметрыВыбораСубконто(Организация, СтрокаТаблицы, "СубконтоКт%Индекс%", "СчетКт");
		НастройкаСчетовУчетаКлиентСервер.ИзменитьПараметрыВыбораПолейСубконто(
		Форма, СтрокаТаблицы, "СубконтоКт%Индекс%", "СубконтоКт%Индекс%", ПараметрыДокумента);
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#КонецОбласти

//++ Локализация
//++ НЕ УТ

#Область СлужебныеПроцедурыИФункции

Процедура ОткрытьФормуНастройкиСПроверкойЗаписи(ИмяФормы, ФормаВладелец) Экспорт
	
	Если НЕ ЗначениеЗаполнено(ФормаВладелец.Объект.Ссылка) ИЛИ ФормаВладелец.Модифицированность Тогда
		
		ТекстВопроса = НСтр("ru='Открытие формы настройки возможно только после записи объекта. Записать?';uk='Відкриття форми настройки можливо тільки після запису об''єкта. Записати?'");
		ДополнительныеПараметры = Новый Структура();
		ДополнительныеПараметры.Вставить("ИмяФормы", ИмяФормы);
		ДополнительныеПараметры.Вставить("ФормаВладелец", ФормаВладелец);
		
		ОписаниеОповещения = Новый ОписаниеОповещения("ОткрытьФормуСПроверкойЗаписиЗавершение", ЭтотОбъект, ДополнительныеПараметры);
		ПоказатьВопрос(ОписаниеОповещения, ТекстВопроса, РежимДиалогаВопрос.ДаНет);
		Возврат;
	КонецЕсли;
	
	ПараметрыФормы = Новый Структура;
	ПараметрыФормы.Вставить("АналитикаУчета", ФормаВладелец.Объект.Ссылка);
	ОткрытьФорму(ИмяФормы, ПараметрыФормы, ФормаВладелец);
	
КонецПроцедуры

Процедура ОткрытьФормуСПроверкойЗаписиЗавершение(РезультатВопроса, ДополнительныеПараметры) Экспорт
	
	ОткрыватьФорму = Ложь;
	Если РезультатВопроса = КодВозвратаДиалога.Да Тогда
		Попытка
			ФормаВладелец = ДополнительныеПараметры.ФормаВладелец;
			ОткрыватьФорму = ФормаВладелец.Записать();
		Исключение
			ПоказатьПредупреждение(,НСтр("ru='Не удалось выполнить запись объекта';uk='Не вдалося виконати запис об''єкта'"));
		КонецПопытки;
	КонецЕсли;
	
	Если ОткрыватьФорму Тогда
		ПараметрыФормы = Новый Структура;
		ПараметрыФормы.Вставить("АналитикаУчета", ФормаВладелец.Объект.Ссылка);
		ОткрытьФорму(ДополнительныеПараметры.ИмяФормы, ПараметрыФормы, ДополнительныеПараметры.ФормаВладелец);
	КонецЕсли;
	
КонецПроцедуры

Процедура НастройкаОтраженияОперацииЗавершение(Результат, ДополнительныеПараметры) Экспорт
	
	Если Результат = Неопределено Тогда
		Возврат;
	КонецЕсли;
	
	Форма = ДополнительныеПараметры.Форма;
	ПараметрыНастройки = ДополнительныеПараметры.ПараметрыНастройки;
	ИдентификаторСтроки = ДополнительныеПараметры.ИдентификаторСтроки;
	
	ДанныеНастройки = НастройкаСчетовУчетаКлиентСервер.ДанныеПоПути(Форма, ПараметрыНастройки.ПутьКДанным, ИдентификаторСтроки);
	
	Если ТипЗнч(ДанныеНастройки) = Тип("ДанныеФормыКоллекция") Тогда
		Для каждого СтрокаТаблицы Из ДанныеНастройки Цикл
			СтрокаТаблицы[ПараметрыНастройки.СчетУчета] = Результат.СчетУчета;
			СтрокаТаблицы[ПараметрыНастройки.Субконто1] = Результат.Субконто1;
			СтрокаТаблицы[ПараметрыНастройки.Субконто2] = Результат.Субконто2;
			СтрокаТаблицы[ПараметрыНастройки.Субконто3] = Результат.Субконто3;
			Представление = НастройкаСчетовУчетаКлиентСервер.ПредставлениеНастройкиОтражения(СтрокаТаблицы, ПараметрыНастройки);
			СтрокаТаблицы[ПараметрыНастройки.Представление] = Представление;
		КонецЦикла;
	Иначе
		ДанныеНастройки[ПараметрыНастройки.СчетУчета] = Результат.СчетУчета;
		ДанныеНастройки[ПараметрыНастройки.Субконто1] = Результат.Субконто1;
		ДанныеНастройки[ПараметрыНастройки.Субконто2] = Результат.Субконто2;
		ДанныеНастройки[ПараметрыНастройки.Субконто3] = Результат.Субконто3;
		Представление = НастройкаСчетовУчетаКлиентСервер.ПредставлениеНастройкиОтражения(ДанныеНастройки, ПараметрыНастройки);
		Если ТипЗнч(ДанныеНастройки) = Тип("ДанныеФормыЭлементКоллекции") Тогда
			ДанныеНастройки[ПараметрыНастройки.Представление] = Представление;
		Иначе
			Форма[ПараметрыНастройки.Представление] = Представление;
		КонецЕсли;
	КонецЕсли;
	
	Форма.Модифицированность = Истина;
	Форма.ОбновитьОтображениеДанных();
	
	Если ДополнительныеПараметры.ОповещениеПослеЗавершения <> Неопределено Тогда
		ВыполнитьОбработкуОповещения(ДополнительныеПараметры.ОповещениеПослеЗавершения);
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

//-- НЕ УТ
//-- Локализация
