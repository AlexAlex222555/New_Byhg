
#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	УстановитьУсловноеОформление();
	
	Если Параметры.Свойство("АвтоТест") Тогда
		Возврат;
	КонецЕсли;
	
	ПоказатьСведения = Ложь;
	ЗаполнитьСвойстваЭлементовСведений();
	
	МожноРедактировать = ПравоДоступа("Редактирование", Метаданные.Справочники.НематериальныеАктивы);
	Элементы.ИзменитьВыделенные.Видимость = МожноРедактировать;
	Элементы.СписокКонтекстноеМенюИзменитьВыделенные.Видимость = МожноРедактировать;
	// СтандартныеПодсистемы.ПодключаемыеКоманды
	ПодключаемыеКоманды.ПриСозданииНаСервере(ЭтотОбъект);
	// Конец СтандартныеПодсистемы.ПодключаемыеКоманды
	СобытияФорм.ПриСозданииНаСервере(ЭтаФорма, Отказ, СтандартнаяОбработка);
	
	
	ВерсионированиеОбъектов.ПриСозданииНаСервере(ЭтотОбъект);
	
КонецПроцедуры

&НаСервере
Процедура ПриЗагрузкеДанныхИзНастроекНаСервере(Настройки)
	
	СохраненноеЗначение = Настройки.Получить("ПоказатьСведения");
	ПоказатьСведения = ?(ЗначениеЗаполнено(СохраненноеЗначение), СохраненноеЗначение, Истина);
	ЗаполнитьСвойстваЭлементовСведений();
	
	ОтборСостояние = Настройки.Получить("ОтборСостояние");
	ОбщегоНазначенияКлиентСервер.УстановитьЭлементОтбораДинамическогоСписка(
		Список,
		"Состояние",
		ОтборСостояние,
		ВидСравненияКомпоновкиДанных.Равно,,
		ЗначениеЗаполнено(ОтборСостояние));
	
	ОтборОрганизация = Настройки.Получить("ОтборОрганизация");
	ОбщегоНазначенияКлиентСервер.УстановитьЭлементОтбораДинамическогоСписка(
		Список,
		"Организация",
		ОтборОрганизация,
		ВидСравненияКомпоновкиДанных.Равно,,
		ЗначениеЗаполнено(ОтборОрганизация));
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовФормы

&НаКлиенте
Процедура ОтборСостояниеПриИзменении(Элемент)
	
	ОбщегоНазначенияКлиентСервер.УстановитьЭлементОтбораДинамическогоСписка(
		Список,
		"Состояние",
		ОтборСостояние,
		ВидСравненияКомпоновкиДанных.Равно,,
		ЗначениеЗаполнено(ОтборСостояние));
	
КонецПроцедуры

&НаКлиенте
Процедура ОтборОрганизацияПриИзменении(Элемент)
	
	ОбщегоНазначенияКлиентСервер.УстановитьЭлементОтбораДинамическогоСписка(
		Список,
		"Организация",
		ОтборОрганизация,
		ВидСравненияКомпоновкиДанных.Равно,,
		ЗначениеЗаполнено(ОтборОрганизация));
	
КонецПроцедуры

&НаКлиенте
Процедура СписокПриАктивизацииСтроки(Элемент)
	
	ПодключитьОбработчикОжидания("ЗаполнитьСведения", 0.2, Истина);
	
	// СтандартныеПодсистемы.ПодключаемыеКоманды
	ПодключаемыеКомандыКлиент.НачатьОбновлениеКоманд(ЭтотОбъект);
	// Конец СтандартныеПодсистемы.ПодключаемыеКоманды
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКоманд

&НаКлиенте
Процедура ИзменитьВыделенные(Команда)
	
	ГрупповоеИзменениеОбъектовКлиент.ИзменитьВыделенные(Элементы.Список);

КонецПроцедуры

&НаКлиенте
Процедура Сведения(Команда)
	
	ПоказатьСведения = Не ПоказатьСведения;
	Элементы.ГруппаСведения.Видимость = ПоказатьСведения;
	
	Если ПоказатьСведения Тогда
		Элементы.КнопкаСведения.Заголовок = НСтр("ru='Скрыть сведения';uk='Приховати відомості'");
	Иначе
		Элементы.КнопкаСведения.Заголовок = НСтр("ru='Показать сведения';uk='Показати відомості'");
	КонецЕсли;
	
КонецПроцедуры

#Область СтандартныеПодсистемы

// СтандартныеПодсистемы.ПодключаемыеКоманды
&НаКлиенте
Процедура Подключаемый_ВыполнитьКоманду(Команда)
	ПодключаемыеКомандыКлиент.ВыполнитьКоманду(ЭтотОбъект, Команда, Элементы.Список);
КонецПроцедуры

&НаСервере
Процедура Подключаемый_ВыполнитьКомандуНаСервере(Контекст, Результат) Экспорт
	ПодключаемыеКоманды.ВыполнитьКоманду(ЭтотОбъект, Контекст, Элементы.Список, Результат);
КонецПроцедуры

&НаКлиенте
Процедура Подключаемый_ОбновитьКоманды()
	ПодключаемыеКомандыКлиентСервер.ОбновитьКоманды(ЭтотОбъект, Элементы.Список);
КонецПроцедуры
// Конец СтандартныеПодсистемы.ПодключаемыеКоманды

&НаКлиенте
Процедура Подключаемый_ВыполнитьПереопределяемуюКоманду(Команда)
	
	СобытияФормКлиент.ВыполнитьПереопределяемуюКоманду(ЭтаФорма, Команда);
	
КонецПроцедуры

#КонецОбласти

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаСервере
Процедура ЗаполнитьСвойстваЭлементовСведений()
	
	Элементы.ГруппаСведения.Видимость = ПоказатьСведения;
	Если ПоказатьСведения Тогда
		Элементы.КнопкаСведения.Заголовок = НСтр("ru='Скрыть сведения';uk='Приховати відомості'");
	Иначе
		Элементы.КнопкаСведения.Заголовок = НСтр("ru='Показать сведения';uk='Показати відомості'");
	КонецЕсли;
	
КонецПроцедуры

&НаСервере
Процедура УстановитьУсловноеОформление()
	
	УсловноеОформление.Элементы.Очистить();
	
КонецПроцедуры

&НаКлиенте
Процедура ЗаполнитьСведения()
	
	Если ПоказатьСведения Тогда
		
		СведенияТаблицаСумм.Очистить();
		Если Элементы.Список.ВыделенныеСтроки.Количество() <> 0 Тогда
			ДанныеСтроки = Элементы.Список.ТекущиеДанные;
			Массив = ПолучитьСведения(ДанныеСтроки.Ссылка, ДанныеСтроки.СчетУчета, ДанныеСтроки.СчетАмортизации);
			Для Каждого ЭлементМассива Из Массив Цикл
				ЗаполнитьЗначенияСвойств(СведенияТаблицаСумм.Добавить(), ЭлементМассива);
			КонецЦикла;
		КонецЕсли;
	КонецЕсли;
	
КонецПроцедуры

&НаСервереБезКонтекста
Функция ПолучитьСведения(ВнеоборотныйАктив, СчетУчета, СчетАмортизации)
	
	УстановитьПривилегированныйРежим(Истина);
	
	ЗначенияПоУмолчанию = Новый Структура;
	ЗначенияПоУмолчанию.Вставить("Стоимость", 0);
	ЗначенияПоУмолчанию.Вставить("СтоимостьПредставления", 0);
	ЗначенияПоУмолчанию.Вставить("Амортизация", 0);
	ЗначенияПоУмолчанию.Вставить("АмортизацияПредставления", 0);
	
	Поля = "Представление, Сумма, СуммаПредставления";
	
	Массив = Новый Массив;
	
	Строка = Новый Структура(Поля);
	Строка.Представление = НСтр("ru='Первоначальная стоимость:';uk='Первісна вартість:'");
	Строка.Сумма = ЗначенияПоУмолчанию.Стоимость;
	Строка.СуммаПредставления = ЗначенияПоУмолчанию.СтоимостьПредставления;
	Массив.Добавить(Строка);
	
	Строка = Новый Структура(Поля);
	Строка.Представление = НСтр("ru='Накопленная амортизация:';uk='Накопичена амортизація:'");
	Строка.Сумма = ЗначенияПоУмолчанию.Амортизация;
	Строка.СуммаПредставления = ЗначенияПоУмолчанию.АмортизацияПредставления;
	Массив.Добавить(Строка);
	
	Строка = Новый Структура(Поля);
	Строка.Представление = НСтр("ru='Остаточная стоимость:';uk='Залишкова вартість:'");
	Строка.Сумма = ЗначенияПоУмолчанию.Стоимость-ЗначенияПоУмолчанию.Амортизация;
	Строка.СуммаПредставления = ЗначенияПоУмолчанию.СтоимостьПредставления-ЗначенияПоУмолчанию.АмортизацияПредставления;
	Массив.Добавить(Строка);
	
	Возврат Массив;
	
КонецФункции

#КонецОбласти