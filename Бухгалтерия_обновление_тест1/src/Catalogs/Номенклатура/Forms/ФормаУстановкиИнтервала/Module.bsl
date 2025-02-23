
#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	// Пропускаем инициализацию, чтобы гарантировать получение формы при передаче параметра "АвтоТест".
	Если Параметры.Свойство("АвтоТест") Тогда
		Возврат;
	КонецЕсли;
	
	Если Параметры.ТипЗначения = Тип("Строка") Тогда
		
		ЭтаФорма.Заголовок = НСтр("ru='Установите значение отбора';uk='Встановіть значення відбору'");
		Элементы.СтраницыВидовОтборов.ТекущаяСтраница = Элементы.СтраницаВводаСтроки;
		ЗначениеВыбораСтрока = Параметры.ЗначениеОтбора;
		
		Элементы.ЗначениеВыбораСтрока.СписокВыбора.Очистить();
		Для Каждого ЭлементСписка Из Параметры.СписокСтрокОтбора Цикл
			Элементы.ЗначениеВыбораСтрока.СписокВыбора.Добавить(ЭлементСписка.Значение, ЭлементСписка.Представление);
		КонецЦикла;
		
	Иначе
		
		ЭтаФорма.Заголовок = НСтр("ru='Установите интервал значений отбора';uk='Встановіть інтервал значень відбору'");
		Элементы.СтраницыВидовОтборов.ТекущаяСтраница = Элементы.СтраницаВводаИнтервала;
		
		Если Параметры.ТипЗначения = Тип("Дата") Тогда
			Элементы.СтраницыТиповИнтервалов.ТекущаяСтраница = Элементы.СтраницаТипаДата;
			ЗначениеДатаОт   = Параметры.ЗначениеОт;
			ЗначениеДатаДо   = Параметры.ЗначениеДо;
			ТипЗначенияДата  = Истина;
		Иначе
			Элементы.СтраницыТиповИнтервалов.ТекущаяСтраница = Элементы.СтраницаТипаЧисло;
			ЗначениеЧислоОт   = Параметры.ЗначениеОт;
			ЗначениеЧислоДо   = Параметры.ЗначениеДо;
		КонецЕсли;
		
	КонецЕсли;
	
	ИмяРеквизита = Параметры.ИмяРеквизита;

	СобытияФорм.ПриСозданииНаСервере(ЭтаФорма, Отказ, СтандартнаяОбработка);

КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура Отмена(Команда)
	
	Закрыть();
	
КонецПроцедуры

&НаКлиенте
Процедура ОК(Команда)
	
	НеверныйИнтервал = Ложь;
	
	Если Элементы.СтраницыВидовОтборов.ТекущаяСтраница = Элементы.СтраницаВводаИнтервала Тогда
		
		СтруктураВозврата = Новый Структура("ИнтервалОт, ИнтервалДо");
		
		Если ТипЗначенияДата Тогда
			СтруктураВозврата.ИнтервалОт = ЗначениеДатаОт;
			СтруктураВозврата.ИнтервалДо = ЗначениеДатаДо;
			
			НеверныйИнтервал = (ЗначениеДатаОт > ЗначениеДатаДо);
		Иначе
			СтруктураВозврата.ИнтервалОт = ЗначениеЧислоОт;
			СтруктураВозврата.ИнтервалДо = ЗначениеЧислоДо;
			
			НеверныйИнтервал = (ЗначениеЧислоОт > ЗначениеЧислоДо);
		КонецЕсли;
		
	Иначе
		СтруктураВозврата = Новый Структура("ЗначениеОтбора", ЗначениеВыбораСтрока);
	КонецЕсли;
	
	Если НеверныйИнтервал Тогда
		ПоказатьПредупреждение(Неопределено, НСтр("ru='Указан неверный диапазон значений!';uk='Вказаний невірний діапазон значень!'"));
		Возврат;
	КонецЕсли;
	
	Закрыть(СтруктураВозврата);
	
КонецПроцедуры

&НаКлиенте
Процедура УстановитьИнтервал(Команда)
	
	ОбщегоНазначенияУТКлиент.РедактироватьПериод(ЭтаФорма, Новый Структура("ДатаНачала, ДатаОкончания", "ЗначениеДатаОт", "ЗначениеДатаДо"));
	
КонецПроцедуры

&НаКлиенте
Процедура Подключаемый_ВыполнитьПереопределяемуюКоманду(Команда)
	
	СобытияФормКлиент.ВыполнитьПереопределяемуюКоманду(ЭтаФорма, Команда);
	
КонецПроцедуры

#КонецОбласти
