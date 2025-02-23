
#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	Если Параметры.Свойство("АвтоТест") Тогда // Возврат при получении формы для анализа.
		Возврат;
	КонецЕсли;

	ЗаполнитьОтчеты();
	
	УстановитьВидимостьГруппыПоиска(Элементы);

	СобытияФорм.ПриСозданииНаСервере(ЭтаФорма, Отказ, СтандартнаяОбработка);

КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовТаблицыФормыВыбранныеОтчеты

&НаКлиенте
Процедура ВыбранныеОтчетыДоступностьПриИзменении(Элемент)
	
	ВыбранныйПользователь = Элементы.ВыбранныеОтчеты.ТекущиеДанные;
	
	ОбновляемаяСтрока = Отчеты.НайтиПоИдентификатору(ВыбранныйПользователь.ИдентификаторСтрокиОтчета);
	ОбновляемаяСтрока.Доступность = ВыбранныйПользователь.Доступность;
	
	Если НЕ ВыбранныйПользователь.Доступность Тогда
		
		ВыбранныеОтчеты.Удалить(ВыбранныеОтчеты.Индекс(ВыбранныйПользователь));
		
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура ЗавершитьРедактирование(Команда)
	
	Если Элементы.СтраницыВыбораОтчетов.ТекущаяСтраница = Элементы.СтраницаВыбранныхОтчетов Тогда
		Для Каждого ВыбранныйОтчет Из ВыбранныеОтчеты Цикл
			ТекущиеДанные = Отчеты.НайтиПоИдентификатору(ВыбранныйОтчет.ИдентификаторСтрокиОтчета);
			ТекущиеДанные.Доступность = ВыбранныйОтчет.Доступность;
			
		КонецЦикла; 
	Иначе
		ВыбранныеОтчеты.Очистить();
		
		ЗаполнитьСписокВыбранныхОтчетов();
		
	КонецЕсли;
	
	АдресХранилищаВыбранныхОтчетов = АдресХранилищаВыбранныхОтчетов();
	
	Закрыть(АдресХранилищаВыбранныхОтчетов);
	
КонецПроцедуры

&НаКлиенте
Процедура ОтметитьВсе(Команда)
	
	// Установим отметку доступности
	Для Каждого ВариантОтчета Из Отчеты Цикл 
		ВариантОтчета.Доступность = Истина;
		
	КонецЦикла;
	
	ОбновитьСписокВыбранныхОтчетов();
	
КонецПроцедуры

&НаКлиенте
Процедура ПоказатьТолькоВыбранныеОтчеты(Команда)
	
	ТолькоВыбранные = Элементы.ФормаПоказатьТолькоВыбранныеОтчеты.Пометка;
	
	Если ТолькоВыбранные Тогда
		
		Для Каждого ВыбранныйПользователь Из ВыбранныеОтчеты Цикл 
			
			ТекущиеДанные = Отчеты.НайтиПоИдентификатору(ВыбранныйПользователь.ИдентификаторСтрокиОтчета);
			ТекущиеДанные.Доступность = ВыбранныйПользователь.Доступность;
			
		КонецЦикла;
		
		Элементы.СтраницыВыбораОтчетов.ТекущаяСтраница = Элементы.СтраницаОтчетов;
		
	Иначе
		
		ВыбранныеОтчеты.Очистить();
		
		ЗаполнитьСписокВыбранныхОтчетов();
		
		Элементы.СтраницыВыбораОтчетов.ТекущаяСтраница = Элементы.СтраницаВыбранныхОтчетов;
		
	КонецЕсли;
	
	Элементы.ФормаПоказатьТолькоВыбранныеОтчеты.Пометка = Не ТолькоВыбранные;
	
	УстановитьВидимостьГруппыПоиска(Элементы);
	
КонецПроцедуры

&НаКлиенте
Процедура СнятьОтметки(Команда)
	
	// Снимем отметку доступности
	Для Каждого ВариантОтчета Из Отчеты Цикл 
		ВариантОтчета.Доступность = Ложь;
		
	КонецЦикла;
	
	ОбновитьСписокВыбранныхОтчетов();
	
КонецПроцедуры

&НаКлиенте
Процедура Подключаемый_ВыполнитьПереопределяемуюКоманду(Команда)
	
	СобытияФормКлиент.ВыполнитьПереопределяемуюКоманду(ЭтаФорма, Команда);
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

// Помещает во временное хранилище таблицу значений с выбранными отчетами
// и возвращает адрес.
// 
// Возвращаемое значение:
//	Строка - адрес хранилища значений таблицы значений во временном хранилище.
//
&НаСервере 
Функция АдресХранилищаВыбранныхОтчетов()
	
	ВыбранныеОтчетыОбъект = РеквизитФормыВЗначение("ВыбранныеОтчеты");
	
	АдресХранилищаВыбранныхОтчетов = ПоместитьВоВременноеХранилище(Новый ХранилищеЗначения(ВыбранныеОтчетыОбъект));
	
	Возврат АдресХранилищаВыбранныхОтчетов;
	
КонецФункции

&НаСервере 
Процедура ЗаполнитьОтчеты()
	
	Запрос = Новый Запрос;
	Запрос.УстановитьПараметр("ВариантыОтчетов", Параметры.ВариантыОтчетов.Выгрузить(,"ВариантОтчета"));
	Запрос.УстановитьПараметр("ОтключенныеВариантыПрограммы", ВариантыОтчетовПовтИсп.ОтключенныеВариантыПрограммы());
	Запрос.Текст = "ВЫБРАТЬ РАЗРЕШЕННЫЕ
	|	Варианты.Ссылка КАК ВариантОтчета,
	|	КОЛИЧЕСТВО(Варианты.Ссылка) КАК Количество
	|ПОМЕСТИТЬ ВариантыОтчетов
	|ИЗ
	|	Справочник.ВариантыОтчетов КАК Варианты
	|		ЛЕВОЕ СОЕДИНЕНИЕ Справочник.ПредопределенныеВариантыОтчетов КАК Предопределенные
	|		ПО Варианты.ПредопределенныйВариант = Предопределенные.Ссылка
	|			И (НЕ Предопределенные.Ссылка В (&ОтключенныеВариантыПрограммы))
	|ГДЕ
	|	Варианты.Ссылка В(&ВариантыОтчетов)
	|	И НЕ Варианты.ПредопределенныйВариант В (&ОтключенныеВариантыПрограммы)
	|	И НЕ Варианты.ПометкаУдаления
	|
	|СГРУППИРОВАТЬ ПО
	|	Варианты.Ссылка
	|
	|ИНДЕКСИРОВАТЬ ПО
	|	ВариантОтчета
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ
	|	ВариантыОтчетов.Ссылка КАК ВариантОтчета,
	|	ВЫБОР
	|		КОГДА ВариантыОтчетовВНесохраненномВариантеРасчета.Количество = 1
	|			ТОГДА ИСТИНА
	|		ИНАЧЕ ЛОЖЬ
	|	КОНЕЦ КАК Доступность
	|ИЗ
	|	Справочник.ВариантыОтчетов КАК ВариантыОтчетов
	|		ЛЕВОЕ СОЕДИНЕНИЕ ВариантыОтчетов КАК ВариантыОтчетовВНесохраненномВариантеРасчета
	|		ПО ВариантыОтчетов.Ссылка = ВариантыОтчетовВНесохраненномВариантеРасчета.ВариантОтчета
	|ГДЕ
	|	НЕ ВариантыОтчетов.ПредопределенныйВариант В (&ОтключенныеВариантыПрограммы)
	|	И НЕ ВариантыОтчетов.ПометкаУдаления
	|
	|УПОРЯДОЧИТЬ ПО
	|	ВариантыОтчетов.Наименование";
	РезультатЗапроса = Запрос.Выполнить();
	
	Если Не РезультатЗапроса.Пустой() Тогда
		ОтчетыИзЗапроса = РезультатЗапроса.Выгрузить();
		
		Для каждого ОтчетИзЗапроса Из ОтчетыИзЗапроса Цикл
			НовыйВариантОтчета = Отчеты.Добавить();
			
			ЗаполнитьЗначенияСвойств(НовыйВариантОтчета, ОтчетИзЗапроса);
			
		КонецЦикла;
		
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте 
Процедура ЗаполнитьСписокВыбранныхОтчетов()
	
	Для Каждого Отчет Из Отчеты Цикл
		
		Если Отчет.Доступность Тогда
			ИдентификаторСтрокиОтчета = Отчет.ПолучитьИдентификатор();
			
			НовыйВыбранныйПользователь = ВыбранныеОтчеты.Добавить();
			НовыйВыбранныйПользователь.ВариантОтчета = Отчет.ВариантОтчета;
			НовыйВыбранныйПользователь.Доступность = Истина;
			НовыйВыбранныйПользователь.ИдентификаторСтрокиОтчета = ИдентификаторСтрокиОтчета;
			
		КонецЕсли;
		
	КонецЦикла;
	
	ВыбранныеОтчеты.Сортировать("ВариантОтчета");
	
КонецПроцедуры

&НаКлиенте 
Процедура ОбновитьСписокВыбранныхОтчетов()
	
	ВыбранныеОтчеты.Очистить();
	
	ЗаполнитьСписокВыбранныхОтчетов();
	
КонецПроцедуры

&НаКлиентеНаСервереБезКонтекста 
Процедура УстановитьВидимостьГруппыПоиска(Элементы)
	
	ТолькоВыбранные = Элементы.ФормаПоказатьТолькоВыбранныеОтчеты.Пометка;
	
	Элементы.ГруппаПоискаПоВсемОтчетам.Видимость = Не ТолькоВыбранные;
	Элементы.ГруппаПоискаПоВыбранным.Видимость = ТолькоВыбранные;

КонецПроцедуры

#КонецОбласти
