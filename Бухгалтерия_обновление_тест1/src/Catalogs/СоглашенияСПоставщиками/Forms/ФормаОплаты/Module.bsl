
#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)

	УстановитьУсловноеОформление();
	
	Если Параметры.Свойство("АвтоТест") Тогда // Возврат при получении формы для анализа.
		Возврат;
	КонецЕсли;

	ИспользоватьУпрощеннуюСхемуОплаты = ПолучитьФункциональнуюОпцию("ИспользоватьУпрощеннуюСхемуОплатыВЗакупках");
	
	ЗаполнитьЗначенияСвойств(Объект, Параметры);
	Объект.ЭтапыГрафикаОплаты.Очистить();
	
	ЭтоКомиссия = (Объект.ХозяйственнаяОперация = Перечисления.ХозяйственныеОперации.ПриемНаКомиссию)
     	      ИЛИ (Объект.ХозяйственнаяОперация = Перечисления.ХозяйственныеОперации.ПриемНаКомиссиюИмпорт);
	ИдентификаторВызывающейФормы = Параметры.УникальныйИдентификатор;
	ЗаполнитьЭтапыОплатыИзВременногоХранилищаСервер(Параметры.АдресВоВременномХранилище);
	РассчитатьИтоговыеПоказателиСоглашенияСПоставщиком(ЭтаФорма);
	
	Если ЭтоКомиссия Тогда
		
		МассивПараметров = Новый Массив;
		МассивПараметров.Добавить(Новый ПараметрВыбора("Отбор.Ссылка", Перечисления.ВариантыОплатыПоставщику.КредитПослеПоступления));
		Элементы.ЭтапыГрафикаОплатыВариантОплаты.ПараметрыВыбора = Новый ФиксированныйМассив(МассивПараметров);
		
		МассивЭлементов = Новый Массив;
		МассивЭлементов.Добавить("ДекорацияПредоплата");
		МассивЭлементов.Добавить("СдвигПредоплата");
		МассивЭлементов.Добавить("ПроцентПлатежаПредоплата");
		МассивЭлементов.Добавить("ПроцентЗалогаЗаТаруПредоплата");
		МассивЭлементов.Добавить("ПроцентПлатежаКредит");
		МассивЭлементов.Добавить("ПроцентЗалогаЗаТаруКредит");
		
		ОбщегоНазначенияУТКлиентСервер.УстановитьСвойствоЭлементовФормы(Элементы, МассивЭлементов, "Доступность", Ложь);
		
		ПроцентПлатежаКредит      = 100;
		ПроцентЗалогаЗаТаруКредит = 100;
		
	КонецЕсли;
	
	Если ИспользоватьУпрощеннуюСхемуОплаты Тогда
		Элементы.ГруппаСтраницы.ТекущаяСтраница = Элементы.СтраницаУпрощеннаяСхема;
		ОбщегоНазначенияУТКлиентСервер.УстановитьСвойствоЭлементаФормы(Элементы, "СтраницаРасширеннаяНастройка", "Видимость", Ложь);
	Иначе
		Элементы.ГруппаСтраницы.ТекущаяСтраница = Элементы.СтраницаРасширеннаяНастройка;
		ОбщегоНазначенияУТКлиентСервер.УстановитьСвойствоЭлементаФормы(Элементы, "СтраницаУпрощеннаяСхема", "Видимость", Ложь);
	КонецЕсли;
	
	МассивЭлементов = Новый Массив;
	МассивЭлементов.Добавить("ПроцентЗалогаЗаТаруКредит");
	МассивЭлементов.Добавить("ПроцентЗалогаЗаТаруПредоплата");
	
	ОбщегоНазначенияУТКлиентСервер.УстановитьСвойствоЭлементовФормы(
		Элементы, МассивЭлементов, "Видимость", Объект.ТребуетсяЗалогЗаТару);
	
	РежимУчетаОтсрочки = ЗначениеЗаполнено(Объект.Календарь);
	УстановитьДоступностьКалендаря(ЭтаФорма);
	Элементы.РежимУчетаОтсрочки.Доступность = ПравоДоступа("Изменение", Метаданные.Справочники.СоглашенияСПоставщиками);
	Элементы.КалендарьРасширенная.Доступность = ПравоДоступа("Изменение", Метаданные.Справочники.СоглашенияСПоставщиками);
	Элементы.УчетОтсрочкиПоКалендарнымДням.Доступность = ПравоДоступа("Изменение", Метаданные.Справочники.СоглашенияСПоставщиками);
	Элементы.УчетОтсрочкиПоПроизводственномуКалендарю.Доступность = ПравоДоступа("Изменение", Метаданные.Справочники.СоглашенияСПоставщиками);
	
	СобытияФорм.ПриСозданииНаСервере(ЭтаФорма, Отказ, СтандартнаяОбработка);
	
	КлючСохраненияПоложенияОкна = Строка(Новый УникальныйИдентификатор);
	
КонецПроцедуры

&НаКлиенте
Процедура ПередЗакрытием(Отказ, ЗавершениеРаботы, ТекстПредупреждения, СтандартнаяОбработка)
	
	СтандартнаяОбработка = Ложь;
	
	Если ЗакрытьФормуПринудительно Тогда
		Возврат;
	КонецЕсли;
	
	Если Модифицированность И НЕ ЗавершениеРаботы Тогда
		
		СписокКнопок = Новый СписокЗначений();
		СписокКнопок.Добавить("Закрыть", НСтр("ru='Закрыть';uk='Закрити'"));
		СписокКнопок.Добавить("НеЗакрывать", НСтр("ru='Не закрывать';uk='Не закривати'"));
		
		Отказ = Истина;
		ПоказатьВопрос(
			Новый ОписаниеОповещения("ПередЗакрытиемЗавершение", ЭтотОбъект),
			НСтр("ru='Все измененные данные будут потеряны. Закрыть форму?';uk='Всі змінені дані будуть втрачені. Закрити форму?'"),
			СписокКнопок);
		
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ПередЗакрытиемЗавершение(ОтветНаВопрос, ДополнительныеПараметры) Экспорт
	
	Если ОтветНаВопрос = "Закрыть" Тогда
		
		ЗакрытьФормуПринудительно = Истина;
		Закрыть();
		
	КонецЕсли;

КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовШапкиФормы

&НаСервере
Процедура ЗаполнитьЭтапыОплатыИзВременногоХранилищаСервер(АдресВоВременномХранилище)
	
	ЭтапыОплаты = ПолучитьИзВременногоХранилища(АдресВоВременномХранилище);
	
	Если ИспользоватьУпрощеннуюСхемуОплаты Тогда
		
		Для Каждого ТекСтрока Из ЭтапыОплаты Цикл
		
			Если ТекСтрока.ВариантОплаты = Перечисления.ВариантыОплатыПоставщику.КредитПослеПоступления Тогда
				ПроцентПлатежаКредит = ПроцентПлатежаКредит + ТекСтрока.ПроцентПлатежа;
				Если Объект.ТребуетсяЗалогЗаТару Тогда
					ПроцентЗалогаЗаТаруКредит = ПроцентЗалогаЗаТаруКредит + ТекСтрока.ПроцентЗалогаЗаТару;
				КонецЕсли;
				СдвигКредит = Макс(СдвигКредит, ТекСтрока.Сдвиг);
			ИначеЕсли Не ЭтоКомиссия Тогда //аванс и предоплата суммируются в общую сумму
				ПроцентПлатежаПредоплата = ПроцентПлатежаПредоплата + ТекСтрока.ПроцентПлатежа;
				Если Объект.ТребуетсяЗалогЗаТару Тогда
					ПроцентЗалогаЗаТаруПредоплата = ПроцентЗалогаЗаТаруПредоплата + ТекСтрока.ПроцентЗалогаЗаТару;
				КонецЕсли;
				СдвигПредоплата = Макс(СдвигПредоплата, ТекСтрока.Сдвиг);
			КонецЕсли;
			
		КонецЦикла;
		
		Если ЭтоКомиссия Тогда
			ПроцентПлатежаКредит      = 100;
			ПроцентЗалогаЗаТаруКредит = 100;
		КонецЕсли;
		
	Иначе
		Для Каждого ТекСтрока Из ЭтапыОплаты Цикл
			НоваяСтрока = Объект.ЭтапыГрафикаОплаты.Добавить();
			ЗаполнитьЗначенияСвойств(НоваяСтрока, ТекСтрока);
		КонецЦикла;
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ЭтапыГрафикаОплатыПослеУдаления(Элемент)
	
	РассчитатьИтоговыеПоказателиСоглашенияСПоставщиком(ЭтаФорма);
	
КонецПроцедуры

&НаКлиенте
Процедура ЭтапыГрафикаОплатыПриОкончанииРедактирования(Элемент, НоваяСтрока, ОтменаРедактирования)
	
	РассчитатьИтоговыеПоказателиСоглашенияСПоставщиком(ЭтаФорма);
	
КонецПроцедуры

&НаКлиенте
Процедура РежимУчетаОтсрочкиПриИзменении(Элемент)
	
	УстановитьДоступностьКалендаря(ЭтаФорма);
	
	Если РежимУчетаОтсрочки = 1 Тогда
		ЗаполнитьПроизводственныйКалендарьНаСервере();
	Иначе
		Объект.Календарь = ПредопределенноеЗначение("Справочник.ПроизводственныеКалендари.ПустаяСсылка");
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ПроцентПлатежаПредоплатаПриИзменении(Элемент)
	
	ПроцентПлатежаПриИзменении(ПроцентПлатежаПредоплата, ПроцентПлатежаКредит);
	
КонецПроцедуры

&НаКлиенте
Процедура ПроцентПлатежаКредитПриИзменении(Элемент)
	
	ПроцентПлатежаПриИзменении(ПроцентПлатежаКредит, ПроцентПлатежаПредоплата);
	
КонецПроцедуры

&НаКлиенте
Процедура ПроцентЗалогаЗаТаруПредоплатаПриИзменении(Элемент)
	
	ПроцентПлатежаПриИзменении(ПроцентЗалогаЗаТаруПредоплата, ПроцентЗалогаЗаТаруКредит);
	
КонецПроцедуры

&НаКлиенте
Процедура ПроцентЗалогаЗаТаруКредитПриИзменении(Элемент)
	
	ПроцентПлатежаПриИзменении(ПроцентЗалогаЗаТаруКредит, ПроцентЗалогаЗаТаруПредоплата);
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытий

&НаКлиенте
Процедура ОК(Команда)
	
	ОчиститьСообщения();
	
	Если Модифицированность И ИспользоватьУпрощеннуюСхемуОплаты Тогда
		ЗаполнитьЭтапыОплатыПоРеквизитамФормы();
	КонецЕсли;
	
	Если Не Модифицированность Тогда
		
		Закрыть();
		
	ИначеЕсли ОплатаКорректна() Тогда
		
		СтруктураОбъекта = Новый Структура();
		СтруктураОбъекта.Вставить("ФормаОплаты", Объект.ФормаОплаты);
		СтруктураОбъекта.Вставить("Календарь", Объект.Календарь);
		СтруктураОбъекта.Вставить("АдресВоВременномХранилище", ПоместитьВоВременноеХранилищеНаСервере());
		
		ЗакрытьФормуПринудительно = Истина;
		Закрыть(СтруктураОбъекта);
		
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура Отмена(Команда)
	
	ЗакрытьФормуПринудительно = Истина;
	Закрыть();
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаСервере
Процедура УстановитьУсловноеОформление()

	УсловноеОформление.Элементы.Очистить();

	//

	Элемент = УсловноеОформление.Элементы.Добавить();

	ПолеЭлемента = Элемент.Поля.Элементы.Добавить();
	ПолеЭлемента.Поле = Новый ПолеКомпоновкиДанных(Элементы.ЭтапыГрафикаОплатыСдвиг.Имя);

	ОтборЭлемента = Элемент.Отбор.Элементы.Добавить(Тип("ЭлементОтбораКомпоновкиДанных"));
	ОтборЭлемента.ЛевоеЗначение = Новый ПолеКомпоновкиДанных("Объект.ЭтапыГрафикаОплаты.СдвигЗаполненНеВерно");
	ОтборЭлемента.ВидСравнения = ВидСравненияКомпоновкиДанных.Равно;
	ОтборЭлемента.ПравоеЗначение = Истина;

	Элемент.Оформление.УстановитьЗначениеПараметра("ЦветТекста", WebЦвета.FireBrick);

	//

	Элемент = УсловноеОформление.Элементы.Добавить();

	ПолеЭлемента = Элемент.Поля.Элементы.Добавить();
	ПолеЭлемента.Поле = Новый ПолеКомпоновкиДанных(Элементы.ЭтапыГрафикаОплатыПроцентПлатежа.Имя);

	ОтборЭлемента = Элемент.Отбор.Элементы.Добавить(Тип("ЭлементОтбораКомпоновкиДанных"));
	ОтборЭлемента.ЛевоеЗначение = Новый ПолеКомпоновкиДанных("Объект.ЭтапыГрафикаОплаты.ПроцентЗаполненНеВерно");
	ОтборЭлемента.ВидСравнения = ВидСравненияКомпоновкиДанных.Равно;
	ОтборЭлемента.ПравоеЗначение = Истина;

	Элемент.Оформление.УстановитьЗначениеПараметра("ЦветТекста", WebЦвета.FireBrick);

	//

	Элемент = УсловноеОформление.Элементы.Добавить();

	ПолеЭлемента = Элемент.Поля.Элементы.Добавить();
	ПолеЭлемента.Поле = Новый ПолеКомпоновкиДанных(Элементы.ЭтапыГрафикаОплатыПроцентПлатежа.Имя);

	ОтборЭлемента = Элемент.Отбор.Элементы.Добавить(Тип("ЭлементОтбораКомпоновкиДанных"));
	ОтборЭлемента.ЛевоеЗначение = Новый ПолеКомпоновкиДанных("Объект.ЭтапыГрафикаОплаты.СдвигЗаполненНеВерно");
	ОтборЭлемента.ВидСравнения = ВидСравненияКомпоновкиДанных.Равно;
	ОтборЭлемента.ПравоеЗначение = Ложь;

	ОтборЭлемента = Элемент.Отбор.Элементы.Добавить(Тип("ЭлементОтбораКомпоновкиДанных"));
	ОтборЭлемента.ЛевоеЗначение = Новый ПолеКомпоновкиДанных("Объект.ЭтапыГрафикаОплаты.НомерСтроки");
	ОтборЭлемента.ВидСравнения = ВидСравненияКомпоновкиДанных.МеньшеИлиРавно;
	ОтборЭлемента.ПравоеЗначение = Новый ПолеКомпоновкиДанных("НомерСтрокиПолнойОплаты");

	ОтборЭлемента = Элемент.Отбор.Элементы.Добавить(Тип("ЭлементОтбораКомпоновкиДанных"));
	ОтборЭлемента.ЛевоеЗначение = Новый ПолеКомпоновкиДанных("НомерСтрокиПолнойОплаты");
	ОтборЭлемента.ВидСравнения = ВидСравненияКомпоновкиДанных.НеРавно;
	ОтборЭлемента.ПравоеЗначение = 0;

	Элемент.Оформление.УстановитьЗначениеПараметра("ЦветТекста", WebЦвета.Seagreen);

	//

	Элемент = УсловноеОформление.Элементы.Добавить();

	ПолеЭлемента = Элемент.Поля.Элементы.Добавить();
	ПолеЭлемента.Поле = Новый ПолеКомпоновкиДанных(Элементы.ЭтапыГрафикаОплатыПроцентЗалогаЗаТару.Имя);

	ОтборЭлемента = Элемент.Отбор.Элементы.Добавить(Тип("ЭлементОтбораКомпоновкиДанных"));
	ОтборЭлемента.ЛевоеЗначение = Новый ПолеКомпоновкиДанных("Объект.ЭтапыГрафикаОплаты.ПроцентЗалогаЗаполненНеВерно");
	ОтборЭлемента.ВидСравнения = ВидСравненияКомпоновкиДанных.Равно;
	ОтборЭлемента.ПравоеЗначение = Истина;

	Элемент.Оформление.УстановитьЗначениеПараметра("ЦветТекста", WebЦвета.FireBrick);

	//

	Элемент = УсловноеОформление.Элементы.Добавить();

	ПолеЭлемента = Элемент.Поля.Элементы.Добавить();
	ПолеЭлемента.Поле = Новый ПолеКомпоновкиДанных(Элементы.ЭтапыГрафикаОплатыПроцентЗалогаЗаТару.Имя);

	ОтборЭлемента = Элемент.Отбор.Элементы.Добавить(Тип("ЭлементОтбораКомпоновкиДанных"));
	ОтборЭлемента.ЛевоеЗначение = Новый ПолеКомпоновкиДанных("Объект.ЭтапыГрафикаОплаты.СдвигЗаполненНеВерно");
	ОтборЭлемента.ВидСравнения = ВидСравненияКомпоновкиДанных.Равно;
	ОтборЭлемента.ПравоеЗначение = Ложь;

	ОтборЭлемента = Элемент.Отбор.Элементы.Добавить(Тип("ЭлементОтбораКомпоновкиДанных"));
	ОтборЭлемента.ЛевоеЗначение = Новый ПолеКомпоновкиДанных("Объект.ЭтапыГрафикаОплаты.НомерСтроки");
	ОтборЭлемента.ВидСравнения = ВидСравненияКомпоновкиДанных.МеньшеИлиРавно;
	ОтборЭлемента.ПравоеЗначение = Новый ПолеКомпоновкиДанных("НомерСтрокиПолнойОплатыЗалога");

	ОтборЭлемента = Элемент.Отбор.Элементы.Добавить(Тип("ЭлементОтбораКомпоновкиДанных"));
	ОтборЭлемента.ЛевоеЗначение = Новый ПолеКомпоновкиДанных("НомерСтрокиПолнойОплатыЗалога");
	ОтборЭлемента.ВидСравнения = ВидСравненияКомпоновкиДанных.НеРавно;
	ОтборЭлемента.ПравоеЗначение = 0;

	Элемент.Оформление.УстановитьЗначениеПараметра("ЦветТекста", WebЦвета.Seagreen);

	//

	Элемент = УсловноеОформление.Элементы.Добавить();

	ПолеЭлемента = Элемент.Поля.Элементы.Добавить();
	ПолеЭлемента.Поле = Новый ПолеКомпоновкиДанных(Элементы.ЭтапыГрафикаОплатыПроцентПлатежа.Имя);

	ПолеЭлемента = Элемент.Поля.Элементы.Добавить();
	ПолеЭлемента.Поле = Новый ПолеКомпоновкиДанных(Элементы.ЭтапыГрафикаОплатыПроцентЗалогаЗаТару.Имя);

	ГруппаОтбора1 = Элемент.Отбор.Элементы.Добавить(Тип("ГруппаЭлементовОтбораКомпоновкиДанных"));
	ГруппаОтбора1.ТипГруппы = ТипГруппыЭлементовОтбораКомпоновкиДанных.ГруппаИли;

	ОтборЭлемента = ГруппаОтбора1.Элементы.Добавить(Тип("ЭлементОтбораКомпоновкиДанных"));
	ОтборЭлемента.ЛевоеЗначение = Новый ПолеКомпоновкиДанных("Объект.ЭтапыГрафикаОплаты.ПроцентПлатежа");
	ОтборЭлемента.ВидСравнения = ВидСравненияКомпоновкиДанных.Заполнено;

	ОтборЭлемента = ГруппаОтбора1.Элементы.Добавить(Тип("ЭлементОтбораКомпоновкиДанных"));
	ОтборЭлемента.ЛевоеЗначение = Новый ПолеКомпоновкиДанных("Объект.ЭтапыГрафикаОплаты.ПроцентЗалогаЗаТару");
	ОтборЭлемента.ВидСравнения = ВидСравненияКомпоновкиДанных.Заполнено;
	Элемент.Оформление.УстановитьЗначениеПараметра("ОтметкаНезаполненного", Ложь);

	//

	Элемент = УсловноеОформление.Элементы.Добавить();

	ПолеЭлемента = Элемент.Поля.Элементы.Добавить();
	ПолеЭлемента.Поле = Новый ПолеКомпоновкиДанных(Элементы.ЭтапыГрафикаОплатыПроцентЗалогаЗаТару.Имя);

	ОтборЭлемента = Элемент.Отбор.Элементы.Добавить(Тип("ЭлементОтбораКомпоновкиДанных"));
	ОтборЭлемента.ЛевоеЗначение = Новый ПолеКомпоновкиДанных("Объект.ТребуетсяЗалогЗаТару");
	ОтборЭлемента.ВидСравнения = ВидСравненияКомпоновкиДанных.Равно;
	ОтборЭлемента.ПравоеЗначение = Ложь;

	Элемент.Оформление.УстановитьЗначениеПараметра("Видимость", Ложь);

	//

	Элемент = УсловноеОформление.Элементы.Добавить();
	
	ПолеЭлемента = Элемент.Поля.Элементы.Добавить();
	ПолеЭлемента.Поле = Новый ПолеКомпоновкиДанных(Элементы.ПроцентПлатежаКредит.Имя);
	ПолеЭлемента = Элемент.Поля.Элементы.Добавить();
	ПолеЭлемента.Поле = Новый ПолеКомпоновкиДанных(Элементы.ПроцентПлатежаПредоплата.Имя);

	ОтборЭлемента = Элемент.Отбор.Элементы.Добавить(Тип("ЭлементОтбораКомпоновкиДанных"));
	ОтборЭлемента.ЛевоеЗначение = Новый ПолеКомпоновкиДанных("ПроцентПлатежейОбщий");
	ОтборЭлемента.ВидСравнения = ВидСравненияКомпоновкиДанных.НеРавно;
	ОтборЭлемента.ПравоеЗначение = 100;

	Элемент.Оформление.УстановитьЗначениеПараметра("ЦветТекста", WebЦвета.FireBrick);

	//

	Элемент = УсловноеОформление.Элементы.Добавить();
	
	ПолеЭлемента = Элемент.Поля.Элементы.Добавить();
	ПолеЭлемента.Поле = Новый ПолеКомпоновкиДанных(Элементы.ПроцентЗалогаЗаТаруКредит.Имя);
	ПолеЭлемента = Элемент.Поля.Элементы.Добавить();
	ПолеЭлемента.Поле = Новый ПолеКомпоновкиДанных(Элементы.ПроцентЗалогаЗаТаруПредоплата.Имя);

	ОтборЭлемента = Элемент.Отбор.Элементы.Добавить(Тип("ЭлементОтбораКомпоновкиДанных"));
	ОтборЭлемента.ЛевоеЗначение = Новый ПолеКомпоновкиДанных("ПроцентЗалогаОбщий");
	ОтборЭлемента.ВидСравнения = ВидСравненияКомпоновкиДанных.НеРавно;
	ОтборЭлемента.ПравоеЗначение = 100;

	Элемент.Оформление.УстановитьЗначениеПараметра("ЦветТекста", WebЦвета.FireBrick);

КонецПроцедуры

&НаСервере
Функция ОплатаКорректна()

	Отказ = Ложь;
	КоличествоЭтапов = Объект.ЭтапыГрафикаОплаты.Количество();
	
	Для ТекИндекс = 0 По Объект.ЭтапыГрафикаОплаты.Количество()-1 Цикл
		
		ТекСтрока = Объект.ЭтапыГрафикаОплаты[ТекИндекс]; // СтрокаТабличнойЧасти
		
		АдресОшибки = " " + НСтр("ru='в строке %НомерСтроки% списка ""Этапы графика оплаты""';uk='у рядку %НомерСтроки% списку ""Етапи графіка оплати""'");
		АдресОшибки = СтрЗаменить(АдресОшибки, "%НомерСтроки%", ТекСтрока.НомерСтроки);
		
		Если Не ЗначениеЗаполнено(ТекСтрока.ВариантОплаты) Тогда
			
			ТекстОшибки = НСтр("ru='Не заполнена колонка ""Вариант оплаты""';uk='Не заповнена колонка ""Варіант оплати""'");
			ОбщегоНазначенияКлиентСервер.СообщитьПользователю(
				ТекстОшибки + АдресОшибки,
				,
				ОбщегоНазначенияКлиентСервер.ПутьКТабличнойЧасти("Объект.ЭтапыГрафикаОплаты", ТекСтрока.НомерСтроки, "ВариантОплаты"),
				,
				Отказ);
			
		КонецЕсли;
		
		Если Объект.ТребуетсяЗалогЗаТару Тогда
			Если Не ЗначениеЗаполнено(ТекСтрока.ПроцентПлатежа)
				И Не ЗначениеЗаполнено(ТекСтрока.ПроцентЗалогаЗаТару) Тогда
				
				ТекстОшибки = НСтр("ru='Для этапа должен быть указан процент платежа или процент залога за тару';uk='Для етапу повинен бути вказаний відсоток платежу або відсоток застави за тару'");
				ОбщегоНазначенияКлиентСервер.СообщитьПользователю(
					ТекстОшибки + АдресОшибки,
					,
					ОбщегоНазначенияКлиентСервер.ПутьКТабличнойЧасти(
						"Объект.ЭтапыГрафикаОплаты", 
						ТекСтрока.НомерСтроки,
						"ПроцентПлатежа"),
					,
					Отказ);
				
			КонецЕсли;
		Иначе
			Если Не ЗначениеЗаполнено(ТекСтрока.ПроцентПлатежа) Тогда
				
				ТекстОшибки = НСтр("ru='Не заполнена колонка ""Процент платежа""';uk='Не заповнена колонка ""Відсоток платежу""'");
				ОбщегоНазначенияКлиентСервер.СообщитьПользователю(
					ТекстОшибки + АдресОшибки,
					,
					ОбщегоНазначенияКлиентСервер.ПутьКТабличнойЧасти(
						"Объект.ЭтапыГрафикаОплаты",
						ТекСтрока.НомерСтроки,
						"ПроцентПлатежа"),
					,
					Отказ);
				
			КонецЕсли;
		КонецЕсли;
		
	КонецЦикла;
	
	Если КоличествоЭтапов > 0 Тогда
		
		Если Объект.ЭтапыГрафикаОплаты.Итог("ПроцентПлатежа") <> 100 Тогда
			
			ТекстОшибки = НСтр("ru='Процент платежей по всем этапам должен быть равен 100%';uk='Відсоток платежів за всіма етапами повинен дорівнювати 100%'");
			Если ИспользоватьУпрощеннуюСхемуОплаты Тогда
				АдресОшибки = "ПроцентПлатежаКредит";
			Иначе
				АдресОшибки = "Объект.ЭтапыГрафикаОплаты";
			КонецЕсли;
			
			ОбщегоНазначенияКлиентСервер.СообщитьПользователю(ТекстОшибки, , АдресОшибки, , Отказ);
			
		КонецЕсли;
		
		Если Объект.ТребуетсяЗалогЗаТару
			И Объект.ЭтапыГрафикаОплаты.Итог("ПроцентЗалогаЗаТару") <> 100 Тогда
			
			ТекстОшибки = НСтр("ru='Процент залога за тару по всем этапам должен быть равен 100%';uk='Відсоток застави за тару за всіма етапами повинен бути рівний 100%'");
			Если ИспользоватьУпрощеннуюСхемуОплаты Тогда
				АдресОшибки = "ПроцентЗалогаЗаТаруКредит";
			Иначе
				АдресОшибки = "Объект.ЭтапыГрафикаОплаты";
			КонецЕсли;
			
			ОбщегоНазначенияКлиентСервер.СообщитьПользователю(ТекстОшибки, , АдресОшибки, , Отказ);
			
		КонецЕсли;
		
		Если ЭтоКомиссия Тогда
			
			Для Каждого ЭтапГрафикаОплаты Из Объект.ЭтапыГрафикаОплаты Цикл
				
				Если ЭтапГрафикаОплаты.ВариантОплаты <> Перечисления.ВариантыОплатыПоставщику.КредитПослеПоступления Тогда
					
					ТекстОшибки = НСтр("ru='Вариант оплаты ""%ВариантОплаты%"" нельзя использовать';uk='Варіант оплати ""%ВариантОплаты%"" не можна використовувати'") + Символы.ПС;
					ТекстОшибки = ТекстОшибки + НСтр("ru='при установленной хозяйственной операции ""Прием на комиссию""';uk='при встановленій господарської операції ""Приймання на комісію""'");
					ТекстОшибки = СтрЗаменить(ТекстОшибки, "%ВариантОплаты%", ЭтапГрафикаОплаты.ВариантОплаты);
					
					ОбщегоНазначенияКлиентСервер.СообщитьПользователю(
						ТекстОшибки,
						,
						"Объект." + ОбщегоНазначенияКлиентСервер.ПутьКТабличнойЧасти("ЭтапыГрафикаОплаты", ЭтапГрафикаОплаты.НомерСтроки,"ВариантОплаты"),
						,
						Отказ);
					
				КонецЕсли;
				
			КонецЦикла;
			
		КонецЕсли;
		
		Если Не ИспользоватьУпрощеннуюСхемуОплаты Тогда
			ПроверитьЭтапыГрафикаОплаты(Отказ);
		КонецЕсли;
		
	КонецЕсли;
	
	Если РежимУчетаОтсрочки = 1 И Не ЗначениеЗаполнено(Объект.Календарь) Тогда
		
		ТекстОшибки = НСтр("ru='Не указан календарь для учета отсрочки по рабочим дням.';uk='Не зазначений календар для обліку відстрочки по робочих днях.'");
		ОбщегоНазначенияКлиентСервер.СообщитьПользователю(ТекстОшибки, , "Объект.Календарь", , Отказ);
		
	КонецЕсли;
	
	Возврат Не Отказ;
	
КонецФункции

&НаСервере
Функция ПоместитьВоВременноеХранилищеНаСервере()
	
	Возврат ПоместитьВоВременноеХранилище(Объект.ЭтапыГрафикаОплаты.Выгрузить(), ИдентификаторВызывающейФормы);
	
КонецФункции

&НаКлиентеНаСервереБезКонтекста
Процедура РассчитатьИтоговыеПоказателиСоглашенияСПоставщиком(Форма)
	
	Форма.ПроцентПлатежейОбщий = 0;
	Форма.ПроцентЗалогаОбщий = 0;
	ПредыдущееЗначениеСдвига = 0;
	ПредыдущееЗначениеВариантаОплаты = Неопределено;
	Форма.НомерСтрокиПолнойОплаты = 0;
	Форма.НомерСтрокиПолнойОплатыЗалога = 0;
	
	Если Форма.ИспользоватьУпрощеннуюСхемуОплаты Тогда
		
		Форма.ПроцентПлатежейОбщий = Форма.ПроцентПлатежаКредит + Форма.ПроцентПлатежаПредоплата;
		Форма.ПроцентЗалогаОбщий   = Форма.ПроцентЗалогаЗаТаруКредит + Форма.ПроцентЗалогаЗаТаруПредоплата;
		
	Иначе
		
		Для Каждого ТекСтрока Из Форма.Объект.ЭтапыГрафикаОплаты Цикл
			
			Форма.ПроцентПлатежейОбщий = Форма.ПроцентПлатежейОбщий + ТекСтрока.ПроцентПлатежа;
			ТекСтрока.ПроцентЗаполненНеВерно = (Форма.ПроцентПлатежейОбщий > 100);
			Если Форма.ПроцентПлатежейОбщий = 100 Тогда
				Форма.НомерСтрокиПолнойОплаты = ТекСтрока.НомерСтроки;
			КонецЕсли;
			
			Форма.ПроцентЗалогаОбщий = Форма.ПроцентЗалогаОбщий + ТекСтрока.ПроцентЗалогаЗаТару;
			ТекСтрока.ПроцентЗалогаЗаполненНеВерно = (Форма.ПроцентЗалогаОбщий > 100);
			Если Форма.ПроцентЗалогаОбщий = 100 Тогда
				Форма.НомерСтрокиПолнойОплатыЗалога = ТекСтрока.НомерСтроки;
			КонецЕсли;
			
			Если ТекСтрока.ВариантОплаты = ПредопределенноеЗначение("Перечисление.ВариантыОплатыПоставщику.КредитПослеПоступления")
				И ТекСтрока.ВариантОплаты <> ПредыдущееЗначениеВариантаОплаты Тогда
				// Если текущий вариант оплаты кредитный и предыдущий вариант оплаты был НЕ кредитный.
				// Отсрочка платежа для кредитных этапов будет рассчитываться от другой даты,
				// необходимо разрешить назначать отсрочки для следующих этапов начиная с 0 дней.
				ПредыдущееЗначениеСдвига = 0;
			КонецЕсли;

			ТекСтрока.СдвигЗаполненНеВерно = (ПредыдущееЗначениеСдвига > ТекСтрока.Сдвиг);
			ПредыдущееЗначениеСдвига = ТекСтрока.Сдвиг;
			ПредыдущееЗначениеВариантаОплаты = ТекСтрока.ВариантОплаты;
			
		КонецЦикла;
		
	КонецЕсли;
	
КонецПроцедуры

&НаСервере
Процедура ПроверитьЭтапыГрафикаОплаты(Отказ)
	
	Запрос = Новый Запрос(
	"ВЫБРАТЬ
	|	ГрафикиОплатыЭтапы.НомерСтроки КАК НомерСтроки,
	|	ГрафикиОплатыЭтапы.Сдвиг КАК ЗначениеСдвигаОплаты,
	|	ГрафикиОплатыЭтапы.ВариантОплаты КАК ЗначениеВариантаОплаты
	|ПОМЕСТИТЬ ВременнаяТабличнаяЧасть
	|ИЗ
	|	&ЭтапыГрафикаОплаты КАК ГрафикиОплатыЭтапы
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ
	|	ТабличнаяЧасть.НомерСтроки КАК НомерСтроки,
	|	ТабличнаяЧасть.ЗначениеСдвигаОплаты КАК ЗначениеСдвигаОплаты,
	|	ТабличнаяЧасть.ЗначениеВариантаОплаты КАК ЗначениеВариантаОплаты,
	|	ВЫБОР КОГДА ТабличнаяЧасть.ЗначениеВариантаОплаты = ЗНАЧЕНИЕ(Перечисление.ВариантыОплатыПоставщику.ПустаяСсылка) 
	|		ТОГДА 0
	|		ИНАЧЕ ТабличнаяЧасть.ЗначениеВариантаОплаты.Порядок
	|	КОНЕЦ КАК ЗначениеПорядкаОплаты
	|ИЗ
	|	ВременнаяТабличнаяЧасть КАК ТабличнаяЧасть
	|
	|УПОРЯДОЧИТЬ ПО
	|	НомерСтроки");
	
	Запрос.УстановитьПараметр("ЭтапыГрафикаОплаты", Объект.ЭтапыГрафикаОплаты.Выгрузить());
	
	Выборка = Запрос.Выполнить().Выбрать();
	
	ПредыдущееЗначениеПорядкаОплаты = 0;
	ПредыдущееЗначениеСдвигаОплаты = 0;
	ПредыдущееЗначениеВариантаОплаты = Неопределено;
	Пока Выборка.Следующий() Цикл
		
		Если ПредыдущееЗначениеПорядкаОплаты > Выборка.ЗначениеПорядкаОплаты Тогда
			
			ТекстОшибки = НСтр("ru='Вариант оплаты ""%ТекущееЗначениеВариантаОплаты%"" в строке %ИндексТекущегоЭтапа%
|не может идти после варианта оплаты ""%ПредыдущееЗначениеВариантаОплаты%"" в строке %ИндексПредыдущегоЭтапа%'
|;uk='Варіант оплати ""%ТекущееЗначениеВариантаОплаты%"" в рядку %ИндексТекущегоЭтапа%
|не може йти після варіанти оплати ""%ПредыдущееЗначениеВариантаОплаты%"" в рядку %ИндексПредыдущегоЭтапа%'");
			ТекстОшибки = СтрЗаменить(ТекстОшибки, "%ПредыдущееЗначениеВариантаОплаты%", ПредыдущееЗначениеВариантаОплаты);
			ТекстОшибки = СтрЗаменить(ТекстОшибки, "%ТекущееЗначениеВариантаОплаты%",    Выборка.ЗначениеВариантаОплаты);
			ТекстОшибки = СтрЗаменить(ТекстОшибки, "%ИндексТекущегоЭтапа%",              Выборка.НомерСтроки);
			ТекстОшибки = СтрЗаменить(ТекстОшибки, "%ИндексПредыдущегоЭтапа%",           Выборка.НомерСтроки-1);
			
			ОбщегоНазначенияКлиентСервер.СообщитьПользователю(
				ТекстОшибки,
				,
				"Объект." + ОбщегоНазначенияКлиентСервер.ПутьКТабличнойЧасти("ЭтапыГрафикаОплаты",Выборка.НомерСтроки,"ВариантОплаты"),
				,
				Отказ);
			
		КонецЕсли;
		
		Если (Выборка.ЗначениеВариантаОплаты = Перечисления.ВариантыОплатыПоставщику.КредитПослеПоступления
			ИЛИ Выборка.ЗначениеВариантаОплаты = Перечисления.ВариантыОплатыПоставщику.КредитСдвиг) И //Если текущий вариант оплаты кредитный
			Выборка.ЗначениеПорядкаОплаты <> ПредыдущееЗначениеПорядкаОплаты Тогда // Если предыдущий вариант оплаты был НЕ кредитный
			
			// Отсрочка платежа для кредитных этапов будет рассчитываться от другой даты, 
			// 		необходимо разрешить назначать отсрочки для следующих этапов начиная с 0 дней.
			ПредыдущееЗначениеСдвигаОплаты = 0;
			
		КонецЕсли;
		
		ПредыдущееЗначениеПорядкаОплаты = Выборка.ЗначениеПорядкаОплаты;
		
		Если ПредыдущееЗначениеСдвигаОплаты > Выборка.ЗначениеСдвигаОплаты Тогда
			
			ТекстОшибки = НСтр("ru='Отсрочка в строке %ИндексТекущегоЭтапа% 
| должна быть не меньше, чем в строке %ИндексПредыдущегоЭтапа%'
|;uk='Відстрочка в рядку %ИндексТекущегоЭтапа% 
| повинна бути не менше, ніж у рядку %ИндексПредыдущегоЭтапа%'");
			ТекстОшибки = СтрЗаменить(ТекстОшибки, "%ИндексТекущегоЭтапа%",    Выборка.НомерСтроки);
			ТекстОшибки = СтрЗаменить(ТекстОшибки, "%ИндексПредыдущегоЭтапа%", Выборка.НомерСтроки-1);
			
			ОбщегоНазначенияКлиентСервер.СообщитьПользователю(
				ТекстОшибки,
				,
				"Объект." + ОбщегоНазначенияКлиентСервер.ПутьКТабличнойЧасти("ЭтапыГрафикаОплаты", Выборка.НомерСтроки, "Сдвиг"),
				,
				Отказ);
			
		КонецЕсли;
		
		ПредыдущееЗначениеСдвигаОплаты = Выборка.ЗначениеСдвигаОплаты;
		ПредыдущееЗначениеВариантаОплаты = Выборка.ЗначениеВариантаОплаты;
		
	КонецЦикла;
	
КонецПроцедуры

&НаСервере
Процедура ЗаполнитьПроизводственныйКалендарьНаСервере()
	
	КалендарныеГрафики.ЗаполнитьПроизводственныйКалендарьВФорме(ЭтаФорма, "Объект.Календарь");
	
КонецПроцедуры

&НаКлиенте
Процедура ЗаполнитьЭтапыОплатыПоРеквизитамФормы()
	
	Объект.ЭтапыГрафикаОплаты.Очистить();
	
	Если Не ЭтоКомиссия 
		И (ПроцентПлатежаПредоплата > 0
			Или (Объект.ТребуетсяЗалогЗаТару И ПроцентЗалогаЗаТаруПредоплата > 0)) Тогда
		НоваяСтрока = Объект.ЭтапыГрафикаОплаты.Добавить();
		НоваяСтрока.ВариантОплаты       = ПредопределенноеЗначение("Перечисление.ВариантыОплатыПоставщику.ПредоплатаДоПоступления");
		НоваяСтрока.Сдвиг               = СдвигПредоплата;
		НоваяСтрока.ПроцентПлатежа      = ПроцентПлатежаПредоплата;
		НоваяСтрока.ПроцентЗалогаЗаТару = ПроцентЗалогаЗаТаруПредоплата
	КонецЕсли;
	
	Если ПроцентПлатежаКредит > 0 
		Или (Объект.ТребуетсяЗалогЗаТару И ПроцентЗалогаЗаТаруКредит > 0) Тогда
		НоваяСтрока = Объект.ЭтапыГрафикаОплаты.Добавить();
		НоваяСтрока.ВариантОплаты       = ПредопределенноеЗначение("Перечисление.ВариантыОплатыПоставщику.КредитПослеПоступления");
		НоваяСтрока.Сдвиг               = СдвигКредит;
		НоваяСтрока.ПроцентПлатежа      = ПроцентПлатежаКредит;
		НоваяСтрока.ПроцентЗалогаЗаТару = ПроцентЗалогаЗаТаруКредит;
	КонецЕсли;
	
КонецПроцедуры

&НаКлиентеНаСервереБезКонтекста
Процедура УстановитьДоступностьКалендаря(Форма)
	
	МассивЭлементов = Новый Массив;
	МассивЭлементов.Добавить("КалендарьУпрощенная");
	МассивЭлементов.Добавить("КалендарьРасширенная");
	
	ВариантПоКалендарю = Форма.РежимУчетаОтсрочки = 1;
	ОбщегоНазначенияУТКлиентСервер.УстановитьСвойствоЭлементовФормы(
		Форма.Элементы, МассивЭлементов, "Доступность", ВариантПоКалендарю);
	ОбщегоНазначенияУТКлиентСервер.УстановитьСвойствоЭлементовФормы(
		Форма.Элементы, МассивЭлементов, "АвтоОтметкаНезаполненного", ВариантПоКалендарю);
	
КонецПроцедуры

&НаКлиенте
Процедура ПроцентПлатежаПриИзменении(Процент, ЗависимыйПроцент)

	ЗависимыйПроцент = 100 - Процент;
	РассчитатьИтоговыеПоказателиСоглашенияСПоставщиком(ЭтаФорма);

КонецПроцедуры

#КонецОбласти
