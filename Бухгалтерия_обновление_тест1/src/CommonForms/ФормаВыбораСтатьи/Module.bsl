
#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)

	УстановитьПараметрыДинамическогоСписка();
	
	Если Параметры.Свойство("АвтоТест") Тогда // Возврат при получении формы для анализа.
		Возврат;
	КонецЕсли;

	АктивПассив = Неопределено;
	Если Параметры.Свойство("ПараметрыВыбора") Тогда
		
		Для каждого ПараметрВыбора Из Параметры.ПараметрыВыбора Цикл
		
			Если ПараметрВыбора.Имя = "Отбор.ХозяйственнаяОперация" Тогда
				
				Если ЗначениеЗаполнено(ПараметрВыбора.Значение) Тогда
					ОтборХозОперацииДляСтатейРасходов = ПараметрВыбора.Значение;
					ОбщегоНазначенияКлиентСервер.УстановитьЭлементОтбораДинамическогоСписка(
						СтатьиРасходов,
						"Ссылка",
						СтатьиРасходовСОтборомПоХозяйственнойОперации(ОтборХозОперацииДляСтатейРасходов),
						ВидСравненияКомпоновкиДанных.ВСписке,,
						Истина);
				КонецЕсли;
				
			КонецЕсли;
			
			Если ПараметрВыбора.Имя = "Отбор.ВариантРаспределенияРасходовУпр"
			 ИЛИ ПараметрВыбора.Имя = "Отбор.ВариантРаспределенияРасходов" Тогда
				
				Если ЗначениеЗаполнено(ПараметрВыбора.Значение) Тогда
					ОбщегоНазначенияКлиентСервер.УстановитьЭлементОтбораДинамическогоСписка(
						СтатьиРасходов,
						"ВариантРаспределенияРасходовУпр",
						ПараметрВыбора.Значение,
						ВидСравненияКомпоновкиДанных.ВСписке,,
						Истина);
				КонецЕсли;
				
			КонецЕсли;
			
			Если ПараметрВыбора.Имя = "Отбор.ВариантРаспределенияРасходовРегл"
			 ИЛИ ПараметрВыбора.Имя = "Отбор.ВариантРаспределенияРасходов" Тогда
				
				Если ЗначениеЗаполнено(ПараметрВыбора.Значение) Тогда
					ОбщегоНазначенияКлиентСервер.УстановитьЭлементОтбораДинамическогоСписка(
						СтатьиРасходов,
						"ВариантРаспределенияРасходовРегл",
						ПараметрВыбора.Значение,
						ВидСравненияКомпоновкиДанных.ВСписке,,
						Истина);	
				КонецЕсли;
				
			КонецЕсли;
			
			Если ПараметрВыбора.Имя = "Отбор.ВидДеятельностиДляНалоговогоУчетаЗатрат" Тогда
				
				Если ЗначениеЗаполнено(ПараметрВыбора.Значение) Тогда
					ОбщегоНазначенияКлиентСервер.УстановитьЭлементОтбораДинамическогоСписка(
						СтатьиРасходов,
						"ВидДеятельностиДляНалоговогоУчетаЗатрат",
						ПараметрВыбора.Значение,
						ВидСравненияКомпоновкиДанных.ВСписке,,
						Истина);
				КонецЕсли;
				
			КонецЕсли;
			
			Если ПараметрВыбора.Имя = "Отбор.АктивПассив" Тогда
				Если ЗначениеЗаполнено(ПараметрВыбора.Значение) Тогда
					АктивПассив = ПараметрВыбора.Значение;
				КонецЕсли;
			КонецЕсли;
			
			Если ПараметрВыбора.Имя = "ДополнитьСтатьямиРасходов" И ПараметрВыбора.Значение Тогда
				ВыбиратьСтатьиРасходов = Истина;
			КонецЕсли;
			
			Если ПараметрВыбора.Имя = "ДополнитьСтатьямиДоходов" И ПараметрВыбора.Значение Тогда
				ВыбиратьСтатьиДоходов = Истина;
			КонецЕсли;
			
			Если ПараметрВыбора.Имя = "ДополнитьСтатьямиАктивовПассивов" И ПараметрВыбора.Значение Тогда
				ВыбиратьСтатьиАктивовПассивов = Истина;
			КонецЕсли;
			
		КонецЦикла;
		
	КонецЕсли;
	
	Если Параметры.Свойство("ОграничениеТипа") И ЗначениеЗаполнено(Параметры.ОграничениеТипа) Тогда
		ОграничениеТипа = Параметры.ОграничениеТипа; 
		Если ВыбиратьСтатьиРасходов 
			И Не ОграничениеТипа.СодержитТип(Тип("ПланВидовХарактеристикСсылка.СтатьиРасходов")) Тогда
			ВыбиратьСтатьиРасходов = Ложь;
		КонецЕсли;
		Если ВыбиратьСтатьиДоходов 
			И Не ОграничениеТипа.СодержитТип(Тип("ПланВидовХарактеристикСсылка.СтатьиДоходов")) Тогда
			ВыбиратьСтатьиДоходов = Ложь;
		КонецЕсли;
		Если ВыбиратьСтатьиАктивовПассивов 
			И Не ОграничениеТипа.СодержитТип(Тип("ПланВидовХарактеристикСсылка.СтатьиАктивовПассивов")) Тогда
			ВыбиратьСтатьиАктивовПассивов = Ложь;
		КонецЕсли;
	КонецЕсли;
	
	СтатьиАктивовПассивов.Параметры.УстановитьЗначениеПараметра("АктивностьСтатьи", АктивПассив);
	СтатьиАктивовПассивов.Параметры.УстановитьЗначениеПараметра("БезОграниченияПоАктивуПассиву", Не ЗначениеЗаполнено(АктивПассив));
	
	Если Параметры.Свойство("Статья", Статья) Тогда
		
		Если ТипЗнч(Статья) = Тип("ПланВидовХарактеристикСсылка.СтатьиРасходов") Тогда
			РежимВыбора = 0;
			Элементы.СтатьиРасходов.ТекущаяСтрока = Статья;
		ИначеЕсли ТипЗнч(Статья) = Тип("ПланВидовХарактеристикСсылка.СтатьиДоходов") Тогда
			РежимВыбора = 1;
			Элементы.СтатьиДоходов.ТекущаяСтрока = Статья;
		Иначе
			РежимВыбора = 2;
			Элементы.СтатьиАктивовПассивов.ТекущаяСтрока = Статья;
		КонецЕсли;
	КонецЕсли;
	
	НастроитьРежимВыбора();
	УправлениеФормой();
	
КонецПроцедуры

&НаКлиенте
Процедура ОбработкаОповещения(ИмяСобытия, Параметр, Источник)
	
	Если ИмяСобытия = "Запись_СтатьяРасходов" И Не ОтборХозОперацииДляСтатейРасходов.Пустая() Тогда
		ОбщегоНазначенияКлиентСервер.УстановитьЭлементОтбораДинамическогоСписка(
			СтатьиРасходов,
			"Ссылка",
			СтатьиРасходовСОтборомПоХозяйственнойОперации(ОтборХозОперацииДляСтатейРасходов),
			ВидСравненияКомпоновкиДанных.ВСписке,,
			Истина);
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиЭлементовФормы

&НаКлиенте
Процедура РежимВыбораПриИзменении(Элемент)
	
	УправлениеФормой();
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура СтатьиРасходовВыбор(Элемент, ВыбраннаяСтрока, Поле, СтандартнаяОбработка)
	
	СтатьяРасходов = Элементы.СтатьиРасходов.ТекущаяСтрока;
	Если НЕ Элементы.СтатьиРасходов.ДанныеСтроки(СтатьяРасходов).ЭтоГруппа Тогда
		СтандартнаяОбработка = Ложь;
		ОповеститьОВыборе(СтатьяРасходов);
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура СтатьиДоходовВыбор(Элемент, ВыбраннаяСтрока, Поле, СтандартнаяОбработка)
	
	СтатьяДоходов = Элементы.СтатьиДоходов.ТекущаяСтрока;
	Если НЕ Элементы.СтатьиДоходов.ДанныеСтроки(СтатьяДоходов).ЭтоГруппа Тогда
		СтандартнаяОбработка = Ложь;
		ОповеститьОВыборе(СтатьяДоходов);
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура СтатьиАктивовПассивовВыбор(Элемент, ВыбраннаяСтрока, Поле, СтандартнаяОбработка)
	
	СтатьяАктивовПассивов = Элементы.СтатьиАктивовПассивов.ТекущаяСтрока;
	Если НЕ Элементы.СтатьиАктивовПассивов.ДанныеСтроки(СтатьяАктивовПассивов).ЭтоГруппа Тогда
		СтандартнаяОбработка = Ложь;
		ОповеститьОВыборе(СтатьяАктивовПассивов);
	КонецЕсли;

КонецПроцедуры

&НаКлиенте
Процедура ВыбратьСтатьюРасходов(Команда)
	
	ВыбратьСтатью("СтатьиРасходов");
	
КонецПроцедуры

&НаКлиенте
Процедура ВыбратьСтатьюДоходов(Команда)
	
	ВыбратьСтатью("СтатьиДоходов");
	
КонецПроцедуры

&НаКлиенте
Процедура ВыбратьСтатьюАктивовПассивов(Команда)
	
	ВыбратьСтатью("СтатьиАктивовПассивов");
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаКлиенте
Процедура ВыбратьСтатью(ИмяТаблицы)
	
	ТекущаяСтрока = Элементы[ИмяТаблицы].ТекущаяСтрока; 
	
	Если ТекущаяСтрока = Неопределено Тогда
		ПоказатьПредупреждение(, НСтр("ru='Команда не может быть выполнена для указанного объекта.';uk='Команда не може бути виконана для зазначеного об''єкта.'"));
		Возврат;
	КонецЕсли;
	
	Если Элементы[ИмяТаблицы].ДанныеСтроки(ТекущаяСтрока).ЭтоГруппа Тогда
		ПоказатьПредупреждение(, НСтр("ru='Выберите элемент, а не группу.';uk='Виберіть елемент, а не групу.'"));
		Возврат;
	КонецЕсли;
	
	ОповеститьОВыборе(ТекущаяСтрока);
	
КонецПроцедуры

&НаСервере
Процедура УстановитьПараметрыДинамическогоСписка()
	
	ОбщегоНазначенияКлиентСервер.УстановитьЭлементОтбораДинамическогоСписка(
			СтатьиРасходов,
			"Ссылка",
			ПланыВидовХарактеристик.СтатьиРасходов.ЗаблокированныеСтатьиРасходов(),
			ВидСравненияКомпоновкиДанных.НеВСписке);
		
	ОбщегоНазначенияКлиентСервер.УстановитьЭлементОтбораДинамическогоСписка(
			СтатьиДоходов,
			"Ссылка",
			ПланыВидовХарактеристик.СтатьиДоходов.ЗаблокированныеСтатьиДоходов(),
			ВидСравненияКомпоновкиДанных.НеВСписке);
			
	ОбщегоНазначенияКлиентСервер.УстановитьЭлементОтбораДинамическогоСписка(
			СтатьиАктивовПассивов,
			"Ссылка",
			ПланыВидовХарактеристик.СтатьиАктивовПассивов.ЗаблокированныеСтатьиАктивовПассивов(),
			ВидСравненияКомпоновкиДанных.НеВСписке);
	
КонецПроцедуры

&НаСервере
Процедура УправлениеФормой()
	
	Если РежимВыбора = 0 Тогда
		Элементы.ГруппаСтраницы.ТекущаяСтраница = Элементы.ГруппаСтатьиРасходов;
		Элементы.СтатьиРасходовКнопкаВыбрать.КнопкаПоУмолчанию = Истина;
	ИначеЕсли РежимВыбора = 1 Тогда
		Элементы.ГруппаСтраницы.ТекущаяСтраница = Элементы.ГруппаСтатьиДоходов;
		Элементы.СтатьиДоходовКнопкаВыбрать.КнопкаПоУмолчанию = Истина;
	Иначе
		Элементы.ГруппаСтраницы.ТекущаяСтраница = Элементы.ГруппаСтатьиАктивовПассивов;
		Элементы.СтатьиАктивовПассивовКнопкаВыбрать.КнопкаПоУмолчанию = Истина;
	КонецЕсли;
	
	Если Элементы.РежимВыбора.СписокВыбора.Количество() = 1 Тогда
		
		Если РежимВыбора = 0 Тогда
			ЭтаФорма.Заголовок = НСтр("ru='Статьи расходов';uk='Статті витрат'");
		ИначеЕсли РежимВыбора = 1 Тогда
			ЭтаФорма.Заголовок = НСтр("ru='Статьи доходов';uk='Статті доходів'");
		Иначе
			ЭтаФорма.Заголовок = НСтр("ru='Статьи активов/пассивов';uk='Статті активів/пасивів'");
		КонецЕсли;
	Иначе
		ЭтаФорма.Заголовок = НСтр("ru='Выбор статьи';uk='Вибір статті'");
	КонецЕсли;
	
	ЭтоУТБазовая = ПолучитьФункциональнуюОпцию("БазоваяВерсия");
	Если ЭтоУТБазовая Тогда
		Элементы.СтатьиРасходовВариантРаспределенияРасходовРегл.Заголовок = НСтр("ru='Вариант распределения';uk='Варіант розподілу'");
		Элементы.СтатьиРасходовВариантРаспределенияРасходовУпр.Видимость = Ложь;
	КонецЕсли;

КонецПроцедуры

&НаСервере
Процедура НастроитьРежимВыбора()
	
	СписокВыбора = Элементы.РежимВыбора.СписокВыбора;
	
	Если НЕ ВыбиратьСтатьиАктивовПассивов
			ИЛИ НЕ ПолучитьФункциональнуюОпцию("ИспользоватьУчетПрочихАктивовПассивов") Тогда
		СписокВыбора.Удалить(2);
	КонецЕсли;
	
	Если НЕ ВыбиратьСтатьиДоходов
			ИЛИ НЕ ПолучитьФункциональнуюОпцию("ИспользоватьУчетПрочихДоходовРасходов") Тогда
		СписокВыбора.Удалить(1);
	КонецЕсли;
	
	Если НЕ ВыбиратьСтатьиРасходов
			ИЛИ НЕ ПолучитьФункциональнуюОпцию("ИспользоватьУчетПрочихДоходовРасходов") Тогда
		СписокВыбора.Удалить(0);
	КонецЕсли;
	
	Элементы.РежимВыбора.Видимость =  (СписокВыбора.Количество() > 1);
	
	Если СписокВыбора.Количество() = 1 Тогда
		РежимВыбора = СписокВыбора[0].Значение;
	КонецЕсли;
	
КонецПроцедуры

&НаСервереБезКонтекста
Функция СтатьиРасходовСОтборомПоХозяйственнойОперации(ХозяйственнаяОперация)
	
	Запрос = Новый Запрос;
	Запрос.Текст = 
	"ВЫБРАТЬ РАЗЛИЧНЫЕ
	|	СтатьиРасходов.Ссылка
	|ИЗ
	|	ПланВидовХарактеристик.СтатьиРасходов КАК СтатьиРасходов
	|ГДЕ
	|	(НЕ СтатьиРасходов.ОграничитьИспользование
	|			ИЛИ СтатьиРасходов.ЭтоГруппа
	|			ИЛИ СтатьиРасходов.Ссылка В
	|				(ВЫБРАТЬ
	|					ДоступныеОперации.Ссылка
	|				ИЗ
	|					ПланВидовХарактеристик.СтатьиРасходов.ДоступныеХозяйственныеОперации КАК ДоступныеОперации
	|				ГДЕ
	|					ДоступныеОперации.ХозяйственнаяОперация = &ХозяйственнаяОперация))
	|	И НЕ СтатьиРасходов.Ссылка В (&ЗаблокированныеСтатьиРасходов)";
	Запрос.УстановитьПараметр("ХозяйственнаяОперация", ХозяйственнаяОперация);
	Запрос.УстановитьПараметр("ЗаблокированныеСтатьиРасходов", ПланыВидовХарактеристик.СтатьиРасходов.ЗаблокированныеСтатьиРасходов().ВыгрузитьЗначения());
	Статьи = Запрос.Выполнить().Выгрузить().ВыгрузитьКолонку("Ссылка");
	Возврат Статьи;
					
КонецФункции

#КонецОбласти
