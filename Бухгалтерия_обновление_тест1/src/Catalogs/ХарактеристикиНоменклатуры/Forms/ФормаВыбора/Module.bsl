
#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)

	Если Параметры.Свойство("АвтоТест") Тогда
		Возврат;
	КонецЕсли;
	
	УстановитьУсловноеОформление();
	
	КодФормы = "Справочник_ХарактеристикиНоменклатуры_ФормаВыбора";
	
	Номенклатура          = Неопределено;
	ВладелецХарактеристик = Неопределено;
	
	Если Параметры.Отбор.Свойство("Владелец") Тогда
		
		// Перенесем "стандартный" отбор по владельцу в свойство ПараметрВладелец
		Параметры.ПараметрВладелец = Параметры.Отбор.Владелец;
		Параметры.Отбор.Удалить("Владелец");
		
	КонецЕсли;
	
	Если Параметры.Свойство("ПараметрВладелец", ВладелецХарактеристик) И ЗначениеЗаполнено(ВладелецХарактеристик) Тогда
		
		ПодборТоваровСервер.УстановитьОтборПоВладельцуХарактеристик(ЭтаФорма);
		
	ИначеЕсли Параметры.Свойство("Номенклатура", Номенклатура) И ЗначениеЗаполнено(Номенклатура) Тогда
		
		Если Справочники.Номенклатура.ПроверитьИспользованиеХарактеристикИПолучитьВладельцаДляВыбора(Номенклатура, ВладелецХарактеристик) Тогда
			
			Если ВладелецХарактеристик = Неопределено Тогда
				
				ТекстИсключения = НСтр("ru='Для данной номенклатуры характеристики не заданы.';uk='Для даної номенклатури характеристики не визначено.'");
				ВызватьИсключение ТекстИсключения;
				
			Иначе
				
				ПодборТоваровСервер.УстановитьОтборПоВладельцуХарактеристик(ЭтаФорма);
				
			КонецЕсли;
			
		Иначе
			
			ТекстИсключения = НСтр("ru='Для данной номенклатуры отключено использование характеристик.';uk='Для даної номенклатури відключено використання характеристик.'");
			ВызватьИсключение ТекстИсключения;
			
		КонецЕсли;
		
	КонецЕсли;
	
	Если ТипЗнч(ВладелецХарактеристик) = Тип("СправочникСсылка.ВидыНоменклатуры") Тогда
		
		ВидНоменклатуры = ВладелецХарактеристик;
		
	ИначеЕсли ТипЗнч(ВладелецХарактеристик) = Тип("СправочникСсылка.Номенклатура") Тогда
		
		ВидНоменклатуры = ОбщегоНазначения.ЗначениеРеквизитаОбъекта(ВладелецХарактеристик, "ВидНоменклатуры");
		
	КонецЕсли;
	
	Если ЗначениеЗаполнено(Параметры.ВариантыРасчетаЦеныНабора) Тогда
		ОбщегоНазначенияКлиентСервер.УстановитьПараметрДинамическогоСписка(Список, "ВариантыРасчетаЦеныНабора", Параметры.ВариантыРасчетаЦеныНабора, Истина);
		ОбщегоНазначенияКлиентСервер.УстановитьПараметрДинамическогоСписка(Список, "Номенклатура", Номенклатура, Истина);
	КонецЕсли;
	
	ПодборТоваровСервер.ЗаполнитьДеревоОтборовХарактеристик(ЭтаФорма);
	
	ЕстьДоступныеОтборы                      = ДеревоОтборов.ПолучитьЭлементы().Количество() > 0;
	Элементы.ГруппаДеревоОтборов.Видимость   = ЕстьДоступныеОтборы;
	ИспользоватьФильтры                      = ЕстьДоступныеОтборы;

	СобытияФорм.ПриСозданииНаСервере(ЭтаФорма, Отказ, СтандартнаяОбработка);

КонецПроцедуры

&НаКлиенте
Процедура ОбработкаОповещения(ИмяСобытия, Параметр, Источник)
	
	Если ИмяСобытия = "Запись_ХарактеристикиНоменклатуры" 
		И ЗначениеЗаполнено(Источник) Тогда
		
		Элементы.Список.ТекущаяСтрока = Источник;
		
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовШапкиФормы

&НаКлиенте
Процедура ИспользоватьФильтрыПриИзменении(Элемент)
	
	ИспользоватьФильтрыПриИзмененииНаСервере();
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовТаблицыФормыСписок

&НаКлиенте
Процедура СписокПередНачаломДобавления(Элемент, Отказ, Копирование, Родитель, Группа)
	
	Если НЕ Копирование И НЕ Группа Тогда
		
		Отказ = Истина;
		
		ПараметрыСозданияВФорму = Новый Структура;
		ПараметрыСозданияВФорму.Вставить("Владелец");
		ПараметрыСозданияВФорму.Вставить("ВидНоменклатуры");
		ПараметрыСозданияВФорму.Вставить("АдресТаблицыПараметров");
		
		Если ИспользоватьФильтры
			И ЗначениеЗаполнено(ВидНоменклатуры)
			И ДеревоОтборов.ПолучитьЭлементы().Количество() > 0 Тогда
			
			ПараметрыСозданияВФорму.АдресТаблицыПараметров = АдресТаблицыПараметровДереваОтборовНаСервере();
			
		КонецЕсли;
		
		ПараметрыСозданияВФорму.ВидНоменклатуры = ВидНоменклатуры;
		ПараметрыСозданияВФорму.Владелец = ВладелецХарактеристик;
		
		ОткрытьФорму("Справочник.ХарактеристикиНоменклатуры.ФормаОбъекта",
			Новый Структура("ДополнительныеПараметры",ПараметрыСозданияВФорму),
			ЭтотОбъект);
		
	КонецЕсли;
	
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовТаблицыФормыДеревоОтборов

&НаКлиенте
Процедура ДеревоОтборовОтборПриИзменении(Элемент)
	
	ПодборТоваровКлиент.ДеревоОтборовОтборПриИзменении(ЭтаФорма, Новый ОписаниеОповещения("ДеревоОтборовПриИзмененииЗавершение", ЭтотОбъект));
	
КонецПроцедуры

&НаКлиенте
Процедура ДеревоОтборовВыбор(Элемент, ВыбраннаяСтрока, Поле, СтандартнаяОбработка)
	
	СтандартнаяОбработка = Ложь;
	
	ПодборТоваровКлиент.ДеревоОтборовВыбор(ЭтаФорма, Новый ОписаниеОповещения("ДеревоОтборовПриИзмененииЗавершение", ЭтотОбъект));
	
КонецПроцедуры

&НаКлиенте
Процедура ДеревоОтборовПриИзмененииЗавершение(Результат, ДополнительныеПараметры) Экспорт 
	
	ПодборТоваровКлиент.ДеревоОтборовПриИзмененииЗавершение(ЭтаФорма);
	ДеревоОтборовОтборПриИзмененииНаСервере();

КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура Подключаемый_ВыполнитьПереопределяемуюКоманду(Команда)
	
	СобытияФормКлиент.ВыполнитьПереопределяемуюКоманду(ЭтаФорма, Команда);
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаСервере
Процедура УстановитьУсловноеОформление()

	УсловноеОформление.Элементы.Очистить();

	//

	Элемент = УсловноеОформление.Элементы.Добавить();

	ПолеЭлемента = Элемент.Поля.Элементы.Добавить();
	ПолеЭлемента.Поле = Новый ПолеКомпоновкиДанных(Элементы.ДеревоОтборовПредставление.Имя);

	ОтборЭлемента = Элемент.Отбор.Элементы.Добавить(Тип("ЭлементОтбораКомпоновкиДанных"));
	ОтборЭлемента.ЛевоеЗначение = Новый ПолеКомпоновкиДанных("ДеревоОтборов.Отбор");
	ОтборЭлемента.ВидСравнения = ВидСравненияКомпоновкиДанных.Равно;
	ОтборЭлемента.ПравоеЗначение = Истина;

	Элемент.Оформление.УстановитьЗначениеПараметра("Шрифт", Новый Шрифт(WindowsШрифты.DefaultGUIFont, , , Истина, Ложь, Ложь, Ложь, ));

	//

	Элемент = УсловноеОформление.Элементы.Добавить();

	ПолеЭлемента = Элемент.Поля.Элементы.Добавить();
	ПолеЭлемента.Поле = Новый ПолеКомпоновкиДанных(Элементы.ДеревоОтборовПредставлениеОтбора.Имя);

	ОтборЭлемента = Элемент.Отбор.Элементы.Добавить(Тип("ЭлементОтбораКомпоновкиДанных"));
	ОтборЭлемента.ЛевоеЗначение = Новый ПолеКомпоновкиДанных("ДеревоОтборов.ФиксированноеЗначение");
	ОтборЭлемента.ВидСравнения = ВидСравненияКомпоновкиДанных.Равно;
	ОтборЭлемента.ПравоеЗначение = Истина;

	Элемент.Оформление.УстановитьЗначениеПараметра("ЦветТекста", ЦветаСтиля.ЦветГиперссылки);
	Элемент.Оформление.УстановитьЗначениеПараметра("Шрифт", Новый Шрифт(WindowsШрифты.DefaultGUIFont, , , Ложь, Ложь, Истина, Ложь, ));

	//

	Элемент = УсловноеОформление.Элементы.Добавить();

	ПолеЭлемента = Элемент.Поля.Элементы.Добавить();
	ПолеЭлемента.Поле = Новый ПолеКомпоновкиДанных(Элементы.ДеревоОтборов.Имя);

	ОтборЭлемента = Элемент.Отбор.Элементы.Добавить(Тип("ЭлементОтбораКомпоновкиДанных"));
	ОтборЭлемента.ЛевоеЗначение = Новый ПолеКомпоновкиДанных("ИспользоватьФильтры");
	ОтборЭлемента.ВидСравнения = ВидСравненияКомпоновкиДанных.Равно;
	ОтборЭлемента.ПравоеЗначение = Ложь;

	Элемент.Оформление.УстановитьЗначениеПараметра("ЦветФона", ЦветаСтиля.FormBackColor);
	Элемент.Оформление.УстановитьЗначениеПараметра("ЦветТекста", ЦветаСтиля.ЦветТекстаОтмененнойСтрокиДокумента);

	//

	Элемент = УсловноеОформление.Элементы.Добавить();

	ПолеЭлемента = Элемент.Поля.Элементы.Добавить();
	ПолеЭлемента.Поле = Новый ПолеКомпоновкиДанных(Элементы.ДеревоОтборовПредставлениеОтбора.Имя);

	ОтборЭлемента = Элемент.Отбор.Элементы.Добавить(Тип("ЭлементОтбораКомпоновкиДанных"));
	ОтборЭлемента.ЛевоеЗначение = Новый ПолеКомпоновкиДанных("ИспользоватьФильтры");
	ОтборЭлемента.ВидСравнения = ВидСравненияКомпоновкиДанных.Равно;
	ОтборЭлемента.ПравоеЗначение = Ложь;

	Элемент.Оформление.УстановитьЗначениеПараметра("ЦветТекста", ЦветаСтиля.ЦветТекстаОтмененнойСтрокиДокумента);

КонецПроцедуры

#Область Прочее

&НаСервере
Процедура ИспользоватьФильтрыПриИзмененииНаСервере()
	
	ПодборТоваровСервер.ПриИзмененииИспользованияФильтров(ЭтаФорма);
	
КонецПроцедуры

&НаСервере
Процедура ДеревоОтборовОтборПриИзмененииНаСервере()
	
	ПодборТоваровСервер.ДеревоОтборовОтборПриИзменении(ЭтаФорма);
	
КонецПроцедуры

&НаСервере
Функция АдресТаблицыПараметровДереваОтборовНаСервере()
	
	АдресТаблицы = ПодборТоваровСервер.АдресТаблицыПараметровДереваОтборов(ЭтаФорма);
	Возврат АдресТаблицы;
	
КонецФункции

#КонецОбласти

#КонецОбласти
