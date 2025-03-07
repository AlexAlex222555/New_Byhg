#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	// Пропускаем инициализацию, чтобы гарантировать получение формы при передаче параметра "АвтоТест".
	Если Параметры.Свойство("АвтоТест") Тогда
		Возврат;
	КонецЕсли;
	
	ЗаполнитьТаблицуРасшифровки();
	ПриПолученииДанныхНаСервере();
	УстановитьЗаголовок();
	УстановитьВидимостьЭлементовФормы(ЭтаФорма);
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовТаблицыФормыТаблицаРасшифровкиВидовРабот

&НаКлиенте
Процедура ТаблицаРасшифровкиВидовРаботВыбор(Элемент, ВыбраннаяСтрока, Поле, СтандартнаяОбработка)
	
	ТекущиеДанные = Элементы.ТаблицаРасшифровкиВидовРабот.ТекущиеДанные;
	Если ТекущиеДанные = Неопределено Тогда
		Возврат;
	КонецЕсли;
	
	СтандартнаяОбработка = Ложь;
	ПоказатьЗначение(, ТекущиеДанные.Регистратор);
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовТаблицыФормыТаблицаРасшифровкиПоказателей

&НаКлиенте
Процедура ТаблицаРасшифровкиПоказателейВыбор(Элемент, ВыбраннаяСтрока, Поле, СтандартнаяОбработка)
	
	ТекущиеДанные = Элементы.ТаблицаРасшифровкиПоказателей.ТекущиеДанные;
	Если ТекущиеДанные = Неопределено Тогда
		Возврат;
	КонецЕсли;
	
	СтандартнаяОбработка = Ложь;
	ПоказатьЗначение(, ТекущиеДанные.Регистратор);
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаСервере	
Процедура ЗаполнитьТаблицуРасшифровки()

	Запрос = Новый Запрос;
	Запрос.УстановитьПараметр("Организация", Параметры.Организация);
	Запрос.УстановитьПараметр("Сотрудник", Параметры.Сотрудник);
	Запрос.УстановитьПараметр("СдельныйЗаработок", ОбщегоНазначенияКлиентСервер.ПредопределенныйЭлемент("Справочник.ПоказателиРасчетаЗарплаты.СдельныйЗаработок"));
	
	Если ОбщегоНазначения.ЗначениеРеквизитаОбъекта(Параметры.Начисление, "ИспользоватьОперативныеПоказателиВЦеломЗаМесяц") Тогда
		ДатаНачала = НачалоМесяца(Параметры.ДатаНачала);
		ДатаОкончания = КонецМесяца(Параметры.ДатаОкончания);
	Иначе
		ДатаНачала = НачалоДня(Параметры.ДатаНачала);
		ДатаОкончания = КонецДня(Параметры.ДатаОкончания);
	КонецЕсли;
	Запрос.УстановитьПараметр("ДатаНачала", ДатаНачала);
	Запрос.УстановитьПараметр("ДатаОкончания", ДатаОкончания);
	
	Запрос.МенеджерВременныхТаблиц = Новый МенеджерВременныхТаблиц;
	
	Запрос.Текст = 
	"ВЫБРАТЬ
	|	&Организация КАК Организация,
	|	&Сотрудник КАК Сотрудник,
	|	&ДатаНачала КАК ДатаНачала,
	|	&ДатаОкончания КАК ДатаОкончания
	|ПОМЕСТИТЬ ВТДанныеДляРасчета
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ РАЗЛИЧНЫЕ
	|	ВыполненныеРаботы.ВидРабот,
	|	ВыполненныеРаботы.Период
	|ПОМЕСТИТЬ ВТВидыРаботПериоды
	|ИЗ
	|	РегистрНакопления.ВыполненныеРаботыСотрудников КАК ВыполненныеРаботы
	|		ВНУТРЕННЕЕ СОЕДИНЕНИЕ ВТДанныеДляРасчета КАК ДанныеДляРасчета
	|		ПО (ДанныеДляРасчета.Сотрудник = ВыполненныеРаботы.Сотрудник)
	|			И (ВыполненныеРаботы.Период МЕЖДУ ДанныеДляРасчета.ДатаНачала И ДанныеДляРасчета.ДатаОкончания)";
	
	Запрос.Выполнить();
	
	ЗарплатаКадрыОбщиеНаборыДанных.СоздатьВТИмяРегистраСрезПоследних(
		"РасценкиРаботСотрудников",
		Запрос.МенеджерВременныхТаблиц,
		Истина,
		ЗарплатаКадрыОбщиеНаборыДанных.ОписаниеФильтраДляСоздатьВТИмяРегистра(
			"ВТВидыРаботПериоды",
			"ВидРабот"));
	
	// Учитывая данные расценок, рассчитаем значения показателя для сотрудников.
	// Суммируем значения с оперативным показателем, т.к. некоторые значения могли быть определены и непосредственно.
	Запрос.Текст = 
	"ВЫБРАТЬ
	|	ДанныеДляРасчета.Сотрудник,
	|	ВыполненныеРаботы.ВидРабот,
	|	ВыполненныеРаботы.Период КАК ДатаВыполненияРаботы,
	|	ВыполненныеРаботы.ОбъемВыполненныхРабот,
	|	ЕСТЬNULL(РасценкиРаботСотрудников.Расценка, 0) КАК Расценка,
	|	ВыполненныеРаботы.ОбъемВыполненныхРабот * ЕСТЬNULL(РасценкиРаботСотрудников.Расценка, 0) КАК Сумма,
	|	ВыполненныеРаботы.Регистратор,
	|	ПРЕДСТАВЛЕНИЕССЫЛКИ(ВыполненныеРаботы.Регистратор)
	|ИЗ
	|	ВТДанныеДляРасчета КАК ДанныеДляРасчета
	|		ВНУТРЕННЕЕ СОЕДИНЕНИЕ РегистрНакопления.ВыполненныеРаботыСотрудников КАК ВыполненныеРаботы
	|			ЛЕВОЕ СОЕДИНЕНИЕ ВТРасценкиРаботСотрудниковСрезПоследних КАК РасценкиРаботСотрудников
	|			ПО ВыполненныеРаботы.ВидРабот = РасценкиРаботСотрудников.ВидРабот
	|				И ВыполненныеРаботы.Период = РасценкиРаботСотрудников.Период
	|		ПО ДанныеДляРасчета.Сотрудник = ВыполненныеРаботы.Сотрудник
	|			И (ВыполненныеРаботы.Период МЕЖДУ ДанныеДляРасчета.ДатаНачала И ДанныеДляРасчета.ДатаОкончания)
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ
	|	ДанныеДляРасчета.Сотрудник,
	|	ЗначенияОперативногоПоказателя.Период КАК Период,
	|	ЗначенияОперативногоПоказателя.Регистратор,
	|	ЗначенияОперативногоПоказателя.Значение КАК Сумма
	|ИЗ
	|	ВТДанныеДляРасчета КАК ДанныеДляРасчета
	|		ВНУТРЕННЕЕ СОЕДИНЕНИЕ РегистрНакопления.ЗначенияОперативныхПоказателейРасчетаЗарплатыСотрудников КАК ЗначенияОперативногоПоказателя
	|		ПО ДанныеДляРасчета.Сотрудник = ЗначенияОперативногоПоказателя.Сотрудник
	|			И (ЗначенияОперативногоПоказателя.Показатель = &СдельныйЗаработок)
	|			И (ЗначенияОперативногоПоказателя.Период МЕЖДУ ДанныеДляРасчета.ДатаНачала И ДанныеДляРасчета.ДатаОкончания)
	|			И (ЗначенияОперативногоПоказателя.Сотрудник <> ЗНАЧЕНИЕ(Справочник.Сотрудники.ПустаяСсылка))
	|
	|ОБЪЕДИНИТЬ ВСЕ
	|
	|ВЫБРАТЬ
	|	ДанныеДляРасчета.Сотрудник,
	|	ЗначенияОперативногоПоказателя.Период,
	|	ЗначенияОперативногоПоказателя.Регистратор,
	|	ЗначенияОперативногоПоказателя.Значение
	|ИЗ
	|	ВТДанныеДляРасчета КАК ДанныеДляРасчета
	|		ВНУТРЕННЕЕ СОЕДИНЕНИЕ Справочник.Сотрудники КАК Сотрудники
	|		ПО (Сотрудники.Ссылка = ДанныеДляРасчета.Сотрудник)
	|		ВНУТРЕННЕЕ СОЕДИНЕНИЕ РегистрНакопления.ЗначенияОперативныхПоказателейРасчетаЗарплатыСотрудников КАК ЗначенияОперативногоПоказателя
	|		ПО (Сотрудники.ФизическоеЛицо = ЗначенияОперативногоПоказателя.ФизическоеЛицо)
	|			И (ЗначенияОперативногоПоказателя.Организация = ДанныеДляРасчета.Организация)
	|			И (ЗначенияОперативногоПоказателя.Показатель = &СдельныйЗаработок)
	|			И (ЗначенияОперативногоПоказателя.Период МЕЖДУ ДанныеДляРасчета.ДатаНачала И ДанныеДляРасчета.ДатаОкончания)
	|			И (ЗначенияОперативногоПоказателя.Сотрудник = ЗНАЧЕНИЕ(Справочник.Сотрудники.ПустаяСсылка))";
	
	РезультатЗапроса = Запрос.ВыполнитьПакет();

	ТаблицаРасшифровкиВидовРабот.Загрузить(РезультатЗапроса[РезультатЗапроса.Количество()-2].Выгрузить());
	ТаблицаРасшифровкиПоказателей.Загрузить(РезультатЗапроса[РезультатЗапроса.Количество()-1].Выгрузить());
	
	Итого = ТаблицаРасшифровкиВидовРабот.Итог("Сумма") + ТаблицаРасшифровкиПоказателей.Итог("Сумма");
	
КонецПроцедуры

&НаКлиентеНаСервереБезКонтекста
Процедура УстановитьВидимостьЭлементовФормы(Форма);

	ЕстьДанные = (Форма.ТаблицаРасшифровкиВидовРабот.Количество() > 0)
				ИЛИ (Форма.ТаблицаРасшифровкиПоказателей.Количество() > 0);
				
	Если ЕстьДанные Тогда
					
		ОбщегоНазначенияКлиентСервер.УстановитьСвойствоЭлементаФормы(
			Форма.Элементы,
			"ВидыРаботГруппа",
			"Видимость",
			Форма.ТаблицаРасшифровкиВидовРабот.Количество() > 0);
		
		ОбщегоНазначенияКлиентСервер.УстановитьСвойствоЭлементаФормы(
			Форма.Элементы,
			"ПоказателиГруппаГруппа",
			"Видимость",
			Форма.ТаблицаРасшифровкиПоказателей.Количество() > 0);
			
		Форма.Элементы.ГруппаСтраницФормы.ТекущаяСтраница = Форма.Элементы.СодержимоеСтраница;
		
	Иначе
		
		Форма.Элементы.ГруппаСтраницФормы.ТекущаяСтраница = Форма.Элементы.НетСодержимогоСтраница;
		
	КонецЕсли;
				

КонецПроцедуры

&НаСервере	
Процедура ПриПолученииДанныхНаСервере()
	ДатаНачала = Параметры.ДатаНачала;
КонецПроцедуры

&НаСервере
Процедура УстановитьЗаголовок()

	ЭтаФорма.Заголовок = Параметры.Сотрудник;
	ЗарплатаКадрыКлиентСервер.ЗаполнитьМесяцПоДате(ЭтаФорма, "ДатаНачала", "МесяцНачисленияСтрокой");
	
КонецПроцедуры

#КонецОбласти