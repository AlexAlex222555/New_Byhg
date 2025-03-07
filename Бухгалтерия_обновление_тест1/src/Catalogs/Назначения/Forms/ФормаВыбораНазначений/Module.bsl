
#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)

	Если Параметры.Свойство("АвтоТест") Тогда // Возврат при получении формы для анализа.
		Возврат;
	КонецЕсли;
	
	Параметры.Свойство("Источник", Источник);
	
	МенеджерОбъекта = ОбщегоНазначения.МенеджерОбъектаПоПолномуИмени(Параметры.ИмяОбъекта);
	
	МакетФормыНазначений = МенеджерОбъекта.МакетФормыВыбораНазначений();
	
	ОчиститьМакетОтНеиспользуемыхПараметров();
	
	ПараметрыДинамическогоСписка = Справочники.Назначения.СформироватьПараметрыЗапросаПоМакетуФормыНазначений(МакетФормыНазначений, Параметры);
	
	ЗагрузитьСписокДоступныхКолонок();
	ЗагрузитьСписокДоступныхОтборов();
	
	// Определение текущей закладки из нескольких возможных
	УстановитьТекстИПараметрыЗапросаДинамическогоСписка();
	
	СоздатьКолонкиСписка();
	СоздатьФлагиОтбора();
	
	НастроитьФорму();

	МодификацияКонфигурацииПереопределяемый.ПриСозданииНаСервере(ЭтаФорма, СтандартнаяОбработка, Отказ);

КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовФормы

&НаКлиенте
Процедура Подключаемый_КолонкиСпискаПометкаПриИзменении(Элемент)
	
	ИмяКлючевойОперации = СтрШаблон("Справочник.Назначения.Форма.ФормаВыбораНазначений.ПометкаПриИзменении.%1", Элемент.Имя);
	
	// &ЗамерПроизводительности
	ОценкаПроизводительностиКлиент.НачатьЗамерВремени(Истина, ИмяКлючевойОперации);
	
	КолонкиСпискаПометкаПриИзмененииНаСервере();
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаСервере
Процедура ЗагрузитьСписокДоступныхКолонок()

	Для Каждого ОписаниеКолонок Из МакетФормыНазначений.ОписанияКолонок Цикл
		
		ВключатьВИтоговыйЗапрос = Справочники.Назначения.ПроверитьУсловиеИспользования(ОписаниеКолонок.Префикс,
																						ОписаниеКолонок.УсловиеИспользования,
																						ПараметрыДинамическогоСписка);
		
		ВключатьВИтоговыйЗапрос = ВключатьВИтоговыйЗапрос И Не ОписаниеКолонок.Отказ;
		
		Для Каждого Колонка Из ОписаниеКолонок.Колонки Цикл
			
			Представление = Колонка.Представление;
			Если СтрНайти(Представление, "%") <> 0 Тогда
				НачалоПодстроки = СтрНайти(Представление, "%");
				КонецПодстроки =  СтрНайти(Представление, "%", НаправлениеПоиска.СКонца);
				ПолнаяПодстрока = Сред(Представление, НачалоПодстроки, КонецПодстроки - НачалоПодстроки + 1);
				Подстрока = СтрЗаменить(ПолнаяПодстрока, "%", "");
				
				Если ПараметрыДинамическогоСписка.Свойство(Подстрока) 
					И ЗначениеЗаполнено(ПараметрыДинамическогоСписка[Подстрока]) Тогда
					Представление = СтрЗаменить(Представление, ПолнаяПодстрока, ПараметрыДинамическогоСписка[Подстрока]);
				Иначе
					// Если представление колонки формируется с помощью значения параметра, а этот параметр не задан,
					// тогда не показываем колонку (считаем что пришли не все необходимые данные).
					ВключатьВИтоговыйЗапрос = Ложь;
				КонецЕсли;
			КонецЕсли;
			
			НоваяСтрока = КолонкиСписка.Добавить();
			НоваяСтрока.ИмяКолонки                    = Колонка.Значение;
			НоваяСтрока.Префикс                       = ОписаниеКолонок.Префикс;
			НоваяСтрока.Представление                 = Представление;
			НоваяСтрока.РазрешеноИспользованиеКолонки = Колонка.Пометка И ВключатьВИтоговыйЗапрос;
			
			КолонкаПоУмолчанию = ОписаниеКолонок.КолонкиПоУмолчанию.Найти(Колонка.Значение) <> Неопределено;
			
			НоваяСтрока.УстановитьОтбор = КолонкаПоУмолчанию И НоваяСтрока.РазрешеноИспользованиеКолонки;
			НоваяСтрока.ПользовательскаяВидимость = ОписаниеКолонок.КолонкиНеотключаемые.Найти(Колонка.Значение) = Неопределено;
			
		КонецЦикла;
		
	КонецЦикла;
	
КонецПроцедуры

&НаСервере
Процедура ЗагрузитьСписокДоступныхОтборов()
	
	Для Каждого ШаблонНазначения Из МакетФормыНазначений.ШаблоныНазначений Цикл
		
		ВключатьВИтоговыйЗапрос = Справочники.Назначения.ПроверитьУсловиеИспользования("",
			ШаблонНазначения.УсловиеИспользования,
			ПараметрыДинамическогоСписка,
			ШаблонНазначения.ПутьКПолюНазначение);
		
		Если Не ВключатьВИтоговыйЗапрос Тогда
			Продолжить;
		КонецЕсли;
		
		Для Каждого ПолеОтбора Из ШаблонНазначения Цикл
			
			Если ЗначениеЗаполнено(ПолеОтбора.Значение)
				И ПолеОтбора.Ключ <> "УсловиеИспользования"
				И ПолеОтбора.Ключ <> "ВидимыеОтборыНаФорме"
				И ПолеОтбора.Ключ <> "ТипыНазначений"
				И ПолеОтбора.Ключ <> "ПутьКПолюНазначение" Тогда
				
				Если ПолеОтбора.Ключ = "НаправлениеДеятельности"
					И (СтрНайти(ПолеОтбора.Значение, "Объект.") <> 0
						Или СтрНайти(ПолеОтбора.Значение, "&") <> 0) Тогда
					
					Если НЕ ПараметрыДинамическогоСписка.Свойство("НаправлениеДеятельности") 
						ИЛИ НЕ НаправленияДеятельностиСервер.ЭтоНаправлениеДеятельностиСОбособлениемТоваровИРабот(ПараметрыДинамическогоСписка.НаправлениеДеятельности) Тогда
						Продолжить;
					КонецЕсли;
					
				КонецЕсли;
				
				НовыйОтбор = ОтборыСписка.Добавить();
				НовыйОтбор.ИмяПоля		= ПолеОтбора.Ключ;
				НовыйОтбор.ПутьКДанным	= ПолеОтбора.Значение;
				НовыйОтбор.Пометка		= Истина;
				
				Если ШаблонНазначения.ВидимыеОтборыНаФорме.Свойство(ПолеОтбора.Ключ) Тогда
					НовыйОтбор.ВидимостьНаФорме = Истина;
					НовыйОтбор.Представление = СтрШаблон(ШаблонНазначения.ВидимыеОтборыНаФорме[ПолеОтбора.Ключ],
						ПараметрыДинамическогоСписка[ПолеОтбора.Ключ]);
				КонецЕсли;
				
			КонецЕсли;
			
		КонецЦикла;
		
	КонецЦикла;
	
КонецПроцедуры

&НаСервере
Процедура СоздатьКолонкиСписка()
	
	Для ТекущийИндекс = 0 По КолонкиСписка.Количество() - 1 Цикл
		
		Колонка = КолонкиСписка[ТекущийИндекс];
		
		Если Колонка.РазрешеноИспользованиеКолонки Тогда
			
			ИмяКолонки = Колонка.Префикс + "_" + Колонка.ИмяКолонки;
			
			НоваяКолонкаСписка             = Элементы.Добавить("Список" + ИмяКолонки, Тип("ПолеФормы"), Элементы.Список);
			НоваяКолонкаСписка.Вид         = ВидПоляФормы.ПолеНадписи;
			НоваяКолонкаСписка.Заголовок   = Колонка.Представление;
			НоваяКолонкаСписка.Формат      = "ЧДЦ=3";
			НоваяКолонкаСписка.ПутьКДанным = "Список." + ИмяКолонки;
			
			НоваяКолонкаСписка.АвтоМаксимальнаяШирина = Ложь;
			НоваяКолонкаСписка.МаксимальнаяШирина     = 14;
			
			Если Колонка.ПользовательскаяВидимость Тогда
				
				НовыйФлаг             = Элементы.Добавить("Флаг" + ИмяКолонки, Тип("ПолеФормы"), Элементы.ГруппаУправлениеКолонками);
				НовыйФлаг.Вид         = ВидПоляФормы.ПолеФлажка;
				НовыйФлаг.Заголовок   = Колонка.Представление;
				НовыйФлаг.ПутьКДанным = "КолонкиСписка[" + ТекущийИндекс + "].УстановитьОтбор";
				НовыйФлаг.УстановитьДействие("ПриИзменении", "Подключаемый_КолонкиСпискаПометкаПриИзменении");
				НовыйФлаг.ПоложениеЗаголовка = ПоложениеЗаголовкаЭлементаФормы.Право;
				
			КонецЕсли;
			
		КонецЕсли;
		
	КонецЦикла;
	
КонецПроцедуры

&НаСервере
Процедура СоздатьФлагиОтбора()
	
	Для Каждого Отбор Из ОтборыСписка Цикл
		
		Если Отбор.ВидимостьНаФорме Тогда
			
			НовыйФлаг             = Элементы.Добавить("Флаг_" + Отбор.ИмяПоля, Тип("ПолеФормы"), Элементы.ГруппаУправлениеКолонками);
			НовыйФлаг.Вид         = ВидПоляФормы.ПолеФлажка;
			НовыйФлаг.Заголовок   = Отбор.Представление;
			НовыйФлаг.ПутьКДанным = "ОтборыСписка[" + ОтборыСписка.Индекс(Отбор) + "].Пометка";
			НовыйФлаг.УстановитьДействие("ПриИзменении", "Подключаемый_КолонкиСпискаПометкаПриИзменении");
			НовыйФлаг.ПоложениеЗаголовка = ПоложениеЗаголовкаЭлементаФормы.Право;
			
		КонецЕсли;
		
	КонецЦикла;
	
КонецПроцедуры

&НаСервере
Процедура УстановитьТекстИПараметрыЗапросаДинамическогоСписка()
	
	ТекстыЗапросов = Новый Массив();
	
	// Формирование списка запросов - источников данных
	// В финальный текст включаются только те запросы, поля из которых используются
	// Для секции ВЫБОРКА досчитываются поля, присутствующие в других запросах.
	Для Каждого ОписаниеКолонок Из МакетФормыНазначений.ОписанияКолонок Цикл
		
		ПараметрыОтбора = Новый Структура();
		ПараметрыОтбора.Вставить("Префикс", ОписаниеКолонок.Префикс);
		ПараметрыОтбора.Вставить("УстановитьОтбор", Истина);
		
		НайденныеКолонки = КолонкиСписка.НайтиСтроки(ПараметрыОтбора);
		
		// Имеет смысл исполнять запрос, если из него выбирается хотя бы одно поле
		
		ВключатьВИтоговыйЗапрос = Ложь;
		Если КолонкиСписка.Количество() > 0 И НайденныеКолонки.Количество() > 0 Тогда
			
			ВключатьВИтоговыйЗапрос = Справочники.Назначения.ПроверитьУсловиеИспользования(ОписаниеКолонок.Префикс,
				ОписаниеКолонок.УсловиеИспользования, ПараметрыДинамическогоСписка);
			
		КонецЕсли;
		
		Если ВключатьВИтоговыйЗапрос Тогда
			
			ТекстЗапросаПредшествующиеПоля = "";
			ТекстЗапросаПоследующиеПоля = "";
			
			НайденныеКолонки = КолонкиСписка.НайтиСтроки(Новый Структура("Префикс", ОписаниеКолонок.Префикс));
			
			МинимальныйИндексКолонки = Неопределено;
			МаксимальныйИндексКолонки = 0;
			Для Каждого Колонка Из НайденныеКолонки Цикл
				Индекс = КолонкиСписка.Индекс(Колонка);
				МинимальныйИндексКолонки  = ?(МинимальныйИндексКолонки = Неопределено, Индекс, Мин(МинимальныйИндексКолонки, Индекс));
				МаксимальныйИндексКолонки = Макс(МаксимальныйИндексКолонки, Индекс);
			КонецЦикла;
			
			// Подсчет полей, присутствующих в других запросах
			Для Индекс = 0 По МинимальныйИндексКолонки - 1 Цикл
				Колонка = КолонкиСписка[Индекс];
				ИмяКолонки = Колонка.Префикс + "_" + Колонка.ИмяКолонки;
				ТекстЗапросаПредшествующиеПоля = ТекстЗапросаПредшествующиеПоля
					+ Символы.ПС + "	0 КАК " + ИмяКолонки + ", ";
			КонецЦикла;
			Для Индекс = МаксимальныйИндексКолонки + 1 По КолонкиСписка.Количество() - 1 Цикл
				Колонка = КолонкиСписка[Индекс];
				ИмяКолонки = Колонка.Префикс + "_" + Колонка.ИмяКолонки;
				ТекстЗапросаПоследующиеПоля = ТекстЗапросаПоследующиеПоля
					+ "," + Символы.ПС + "	0 КАК " + ИмяКолонки;
			КонецЦикла;
		
			ТекстЗапроса = ОписаниеКолонок.ТекстЗапроса;
			ТекстЗапроса = СтрЗаменить(ТекстЗапроса, "//&ПоляВыбораПредшествующие", ТекстЗапросаПредшествующиеПоля);
			ТекстЗапроса = СтрЗаменить(ТекстЗапроса, "//&ПоляВыбораПоследующие",    ТекстЗапросаПоследующиеПоля);
			
			ТекстыЗапросов.Добавить(ТекстЗапроса);
			
		КонецЕсли;
		
	КонецЦикла;
	
	Если ЗначениеЗаполнено(ТекстыЗапросов) Тогда
		
		ТекстЗапросаШаблон = 
			"ВЫБРАТЬ
			|	ТаблицаВыборки.Назначение КАК Назначение,
			|	%1
			|ПОМЕСТИТЬ ВтОтобранныеНазначения
			|ИЗ
			|	(%2) КАК ТаблицаВыборки
			|
			|СГРУППИРОВАТЬ ПО
			|	ТаблицаВыборки.Назначение
			|
			|ИМЕЮЩИЕ
			|	%3
			|
			|ИНДЕКСИРОВАТЬ ПО
			|	Назначение
			|;
			|////////////////////////////////////////////////////////////////////////////////
			|ВЫБРАТЬ
			|	Назначения.Ссылка КАК Назначение,
			|	%4
			|ИЗ
			|	Справочник.Назначения КАК Назначения
			|		ВНУТРЕННЕЕ СОЕДИНЕНИЕ ВтОтобранныеНазначения КАК Отбор
			|		ПО Назначения.Ссылка = Отбор.Назначение
			|ГДЕ
			|	НЕ Назначения.ПометкаУдаления
			|	//&Условия";
		
		ПоляВыборкиИзВложенногоЗапроса = Новый Массив;
		ПоляВыборкиИзВременнойТаблицы = Новый Массив;
		ПоляУсловийИмеющие = Новый Массив;
		Для Каждого Колонка Из КолонкиСписка Цикл
			
			ИмяКолонки = Колонка.Префикс + "_" + Колонка.ИмяКолонки;
			
			Если Колонка.УстановитьОтбор Тогда
				ПоляВыборкиИзВложенногоЗапроса.Добавить("СУММА(ТаблицаВыборки." + ИмяКолонки + ") КАК " + ИмяКолонки);
				ПоляУсловийИмеющие.Добавить("СУММА(ТаблицаВыборки." + ИмяКолонки + ") <> 0 ");
			Иначе
				ПоляВыборкиИзВложенногоЗапроса.Добавить("0 КАК " + ИмяКолонки);
			КонецЕсли;
			ПоляВыборкиИзВременнойТаблицы.Добавить("Отбор." + ИмяКолонки + " КАК " + ИмяКолонки);
			
		КонецЦикла;
		
		ТекстЗапроса = СтрШаблон(ТекстЗапросаШаблон,
			СтрСоединить(ПоляВыборкиИзВложенногоЗапроса, "," + Символы.ПС + Символы.Таб),
			СтрСоединить(ТекстыЗапросов, ОбщегоНазначенияУТ.РазделительЗапросовВОбъединении()),
			СтрСоединить(ПоляУсловийИмеющие, Символы.ПС + Символы.Таб + "И "),
			СтрСоединить(ПоляВыборкиИзВременнойТаблицы, "," + Символы.ПС + Символы.Таб));
		
	Иначе
		
		ТекстЗапроса =
			"ВЫБРАТЬ
			|	Назначения.Ссылка КАК Назначение
			|	//&ПоляВыборки
			|ИЗ
			|	Справочник.Назначения КАК Назначения
			|ГДЕ
			|	НЕ Назначения.ПометкаУдаления
			|	//&Условия";
		
		Если ЗначениеЗаполнено(КолонкиСписка) Тогда
			ПоляВыборки = Новый Массив;
			Для Каждого Колонка Из КолонкиСписка Цикл
				ПоляВыборки.Добавить("0 КАК " + Колонка.Префикс + "_" + Колонка.ИмяКолонки);
			КонецЦикла;
			ТекстЗапроса = СтрЗаменить(ТекстЗапроса, "//&ПоляВыборки", ", " +СтрСоединить(ПоляВыборки, "," + Символы.ПС + Символы.Таб));
		КонецЕсли;
		
	КонецЕсли;
	
	УсловияНазначения = Новый Массив();
	Для Каждого Отбор Из ОтборыСписка Цикл
		Если Отбор.Пометка Тогда
			
			Если СтрНайти(Отбор.ПутьКДанным, "Объект.") <> 0
				Или СтрНайти(Отбор.ПутьКДанным, "&") <> 0 Тогда
				Условие = "Назначения." + Отбор.ИмяПоля + " = " + "&" + Отбор.ИмяПоля
			Иначе
				Условие = "Назначения." + Отбор.ИмяПоля + " = (" + Отбор.ПутьКДанным + ")";
			КонецЕсли;
			УсловияНазначения.Добавить(Условие);
			
		КонецЕсли;
	КонецЦикла;
	УсловияНазначения.Добавить("Назначения.ТипНазначения В (&ТипыНазначений)");
	Справочники.Назначения.ДобавитьУсловиеИсключенияПартнера(УсловияНазначения, "Назначения");
	Если ЗначениеЗаполнено(Источник) Тогда
		УсловияНазначения.Добавить("Назначения.Заказ <> &Источник");
	КонецЕсли;
	
	ТекстЗапроса = СтрЗаменить(ТекстЗапроса, "//&Условия",
		"И " + СтрСоединить(УсловияНазначения, Символы.ПС + Символы.Таб + "И "));
	
	СвойстваСписка = ОбщегоНазначения.СтруктураСвойствДинамическогоСписка();
	ЗаполнитьЗначенияСвойств(СвойстваСписка, Список);
	СвойстваСписка.ТекстЗапроса = ТекстЗапроса;
	ОбщегоНазначения.УстановитьСвойстваДинамическогоСписка(Элементы.Список, СвойстваСписка);
	
	Если ЗначениеЗаполнено(Источник) Тогда
		ОбщегоНазначенияКлиентСервер.УстановитьПараметрДинамическогоСписка(Список, "Источник", Источник);
	КонецЕсли;
	
	// Установка значений параметров запроса.
	
	Для Каждого ОписаниеКолонок Из МакетФормыНазначений.ОписанияКолонок Цикл
		
		Для Каждого ПутьКДанным Из ОписаниеКолонок.ПутиКДанным Цикл
			ИмяПараметра = ОписаниеКолонок.Префикс + "_" + ПутьКДанным.Ключ;
			Значение = ПараметрыДинамическогоСписка[ИмяПараметра];
			ОбщегоНазначенияКлиентСервер.УстановитьПараметрДинамическогоСписка(Список, ИмяПараметра, Значение);
		КонецЦикла;
		
	КонецЦикла;
	
	Для Каждого ПолеОтбора Из ОтборыСписка Цикл
		
		Если ЗначениеЗаполнено(ПолеОтбора.ПутьКДанным)
			И (СтрНайти(ПолеОтбора.ПутьКДанным, "Объект.") <> 0
				Или СтрНайти(ПолеОтбора.ПутьКДанным, "&") <> 0) Тогда
			
			ПараметрыУсловияИспользования = Справочники.Назначения.ТекстИПараметрыЗапросаУсловияИспользования("", ПолеОтбора.ПутьКДанным);
			Для Каждого ПараметрЗапроса Из ПараметрыУсловияИспользования.ПараметрыЗапроса Цикл
				ЗначениеПараметра = ПараметрыДинамическогоСписка[ПараметрЗапроса];
				ОбщегоНазначенияКлиентСервер.УстановитьПараметрДинамическогоСписка(Список, ПараметрЗапроса, ЗначениеПараметра);
			КонецЦикла;
		КонецЕсли;
		
	КонецЦикла;
	ОбщегоНазначенияКлиентСервер.УстановитьПараметрДинамическогоСписка(Список, "ТипыНазначений",
		ПараметрыДинамическогоСписка.ТипыНазначений);
	
КонецПроцедуры

&НаСервере
Процедура НастроитьФорму()
	
	ТекущиеОтборы = Новый Структура("Номенклатура, Характеристика, Партнер, Договор, НаправлениеДеятельности,
		|Документ, ТипыНазначений");
	
	ОтборыНаФорме = ОтборыСписка.Выгрузить(Новый Структура("ВидимостьНаФорме", Истина), "ИмяПоля");
	
	// Получение значений параметров, используемых как отборы.
	// В дальнейшем используется для отображения пользователю текущих отборов.
	Для Каждого КлючЗначение Из ПараметрыДинамическогоСписка Цикл
		Если ТипЗнч(КлючЗначение.Значение) = Тип("СправочникСсылка.Номенклатура") Тогда
			ТекущиеОтборы.Номенклатура = КлючЗначение.Значение;
		ИначеЕсли ТипЗнч(КлючЗначение.Значение) = Тип("СправочникСсылка.ХарактеристикиНоменклатуры") Тогда
			ТекущиеОтборы.Характеристика = КлючЗначение.Значение;
		ИначеЕсли ТипЗнч(КлючЗначение.Значение) = Тип("СправочникСсылка.Партнеры")
			И ОтборыНаФорме.Найти("Партнер") = Неопределено Тогда
			ТекущиеОтборы.Партнер = КлючЗначение.Значение;
		ИначеЕсли ТипЗнч(КлючЗначение.Значение) = Тип("СправочникСсылка.ДоговорыКонтрагентов")
			И ОтборыНаФорме.Найти("Договор") = Неопределено Тогда
			ТекущиеОтборы.Договор = КлючЗначение.Значение;
		ИначеЕсли ТипЗнч(КлючЗначение.Значение) = Тип("СправочникСсылка.НаправленияДеятельности")
			И НаправленияДеятельностиСервер.ЭтоНаправлениеДеятельностиСОбособлениемТоваровИРабот(КлючЗначение.Значение)
			И ОтборыНаФорме.Найти("НаправлениеДеятельности") = Неопределено Тогда
			ТекущиеОтборы.НаправлениеДеятельности = КлючЗначение.Значение;
		ИначеЕсли ТипЗнч(КлючЗначение.Значение) = Тип("ДокументСсылка.РеализацияТоваровУслуг")
			Или ТипЗнч(КлючЗначение.Значение) = Тип("ДокументСсылка.ПередачаТоваровХранителю") Тогда
			
			ТекущиеОтборы.Документ = КлючЗначение.Значение;
			
		КонецЕсли;
	КонецЦикла;
	ТекущиеОтборы.ТипыНазначений = ПараметрыДинамическогоСписка.ТипыНазначений;
	
	// Формирование заголовка
	Если ЗначениеЗаполнено(МакетФормыНазначений.Заголовок) Тогда
		Заголовок = МакетФормыНазначений.Заголовок;
	ИначеЕсли ЗначениеЗаполнено(ТекущиеОтборы.Номенклатура) Тогда
		Заголовок = НСтр("ru='Выбор назначения';uk='Вибір призначення'");
		
		Номенклатура   = СтрЗаменить(НСтр("ru='Номенклатура: %1';uk='Номенклатура: %1'"),   "%1", ТекущиеОтборы.Номенклатура);
		Характеристика = ?(ЗначениеЗаполнено(ТекущиеОтборы.Характеристика),
								СтрЗаменить(НСтр("ru='Характеристика: %1';uk='Характеристика: %1'"), "%1", ТекущиеОтборы.Характеристика),
								"");
		ЕдиницаИзмерения = ОбщегоНазначения.ЗначениеРеквизитаОбъекта(ТекущиеОтборы.Номенклатура, "ЕдиницаИзмерения");
		ЕдиницаИзмерения = СтрЗаменить(НСтр("ru='Ед. изм: %1';uk='Од. вим. %1'"), "%1", ЕдиницаИзмерения);
		ТекстВыборка = Номенклатура
			+ ?(ЗначениеЗаполнено(ТекущиеОтборы.Характеристика), ", " + Характеристика, "")
			+ ", " + ЕдиницаИзмерения;
		
		Заголовок = Заголовок + " (" + ТекстВыборка + ")";
	Иначе
		Заголовок = НСтр("ru='Выбор назначения';uk='Вибір призначення'");
	КонецЕсли;
	
	// Формирование информационной строки по направлению деятельности
	УстановитьНадписьОтобраныНазначения(ТекущиеОтборы);
	
	// Управление видимостью колонок в зависимости от взвода флажков отборов
	Для Каждого Колонка Из КолонкиСписка Цикл
		
		Если Колонка.РазрешеноИспользованиеКолонки Тогда
			КолонкаСписка = Элементы["Список" + Колонка.Префикс + "_" + Колонка.ИмяКолонки];
			КолонкаСписка.Видимость = Колонка.УстановитьОтбор;
		КонецЕсли;
		
	КонецЦикла;
	
КонецПроцедуры

&НаСервере
Процедура УстановитьНадписьОтобраныНазначения(ТекущиеОтборы)
	
	ЗаголовокНадписи = "";
	Если ЗначениеЗаполнено(ТекущиеОтборы.НаправлениеДеятельности) И ЗначениеЗаполнено(ТекущиеОтборы.Договор) Тогда
		
		СтрокаПодстановки = НСтр("ru='Назначения направления деятельности %1 по договору %2';uk='Призначення напряму діяльності %1 за договором %2'");
		ЗаголовокНадписи = СтрШаблон(СтрокаПодстановки, ТекущиеОтборы.НаправлениеДеятельности, ТекущиеОтборы.Договор);
		
	ИначеЕсли ЗначениеЗаполнено(ТекущиеОтборы.НаправлениеДеятельности) И ЗначениеЗаполнено(ТекущиеОтборы.Партнер) Тогда
		
		Если ТекущиеОтборы.ТипыНазначений.Найти(Перечисления.ТипыНазначений.Собственное) <> Неопределено Тогда
			СтрокаПодстановки = НСтр("ru='Назначения направления деятельности %1 переработчика %2';uk='Призначення напряму діяльності %1 переробника %2'");
		Иначе
			СтрокаПодстановки = НСтр("ru='Назначения направления деятельности %1 давальца %2';uk='Призначення напряму діяльності %1 давальця %2'");
		КонецЕсли;
		ЗаголовокНадписи = СтрШаблон(СтрокаПодстановки, ТекущиеОтборы.НаправлениеДеятельности, ТекущиеОтборы.Партнер);
		
	ИначеЕсли ЗначениеЗаполнено(ТекущиеОтборы.НаправлениеДеятельности) Тогда
		
		СтрокаПодстановки = НСтр("ru='Назначения направления деятельности %1';uk='Призначення напряму діяльності %1'");
		ЗаголовокНадписи = СтрШаблон(СтрокаПодстановки, ТекущиеОтборы.НаправлениеДеятельности);
		
	ИначеЕсли ЗначениеЗаполнено(ТекущиеОтборы.Договор) Тогда
		
		СтрокаПодстановки = НСтр("ru='Назначения по договору %1';uk='Призначення за договором %1'");
		ЗаголовокНадписи = СтрШаблон(СтрокаПодстановки, ТекущиеОтборы.Договор);
		
	ИначеЕсли ЗначениеЗаполнено(ТекущиеОтборы.Партнер) Тогда
		
		Если ТекущиеОтборы.ТипыНазначений.Найти(Перечисления.ТипыНазначений.Собственное) <> Неопределено Тогда
			СтрокаПодстановки = НСтр("ru='Назначения переработчика %1';uk='Призначення переробника %1'");
		Иначе
			СтрокаПодстановки = НСтр("ru='Назначения давальца %1';uk='Призначення давальця %1'");
		КонецЕсли;
		ЗаголовокНадписи = СтрШаблон(СтрокаПодстановки, ТекущиеОтборы.Партнер);
		
	КонецЕсли;
	Если ЗначениеЗаполнено(ТекущиеОтборы.Документ) Тогда
		
		СтрокаПодстановки = НСтр("ru='по данным документа %1';uk='за даними документа %1'");
		ЗаголовокНадписи = ?(ПустаяСтрока(ЗаголовокНадписи), НСтр("ru='Назначения';uk='Призначення'"), ЗаголовокНадписи)
			+ " " + СтрШаблон(СтрокаПодстановки, ТекущиеОтборы.Документ);
		
	КонецЕсли;
	
	Элементы.НадписьОтобраныНазначения.Видимость = Не ПустаяСтрока(ЗаголовокНадписи);
	Элементы.НадписьОтобраныНазначения.Заголовок = ЗаголовокНадписи;

КонецПроцедуры

&НаСервере
Процедура КолонкиСпискаПометкаПриИзмененииНаСервере()
	
	УстановитьТекстИПараметрыЗапросаДинамическогоСписка();
	
	НастроитьФорму();
	
КонецПроцедуры

&НаСервере
Процедура ОчиститьМакетОтНеиспользуемыхПараметров()
	
	КоличествоИндексов = МакетФормыНазначений.ОписанияКолонок.Количество() - 1;
	
	Для Индекс = 0 По КоличествоИндексов Цикл
		
		ТекущийИндекс = КоличествоИндексов - Индекс;
		ОписаниеКолонок = МакетФормыНазначений.ОписанияКолонок[ТекущийИндекс];
		Если ОписаниеКолонок.ПутьКПолюНазначение <> Параметры.ПутьКПолюНазначение Тогда
			МакетФормыНазначений.ОписанияКолонок.Удалить(ТекущийИндекс);
		КонецЕсли;
		
	КонецЦикла;
	
КонецПроцедуры

#КонецОбласти
