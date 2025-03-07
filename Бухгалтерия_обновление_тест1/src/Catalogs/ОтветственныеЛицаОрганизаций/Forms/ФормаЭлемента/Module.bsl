
#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	Если Параметры.Свойство("АвтоТест") Тогда // Возврат при получении формы для анализа.
		Возврат;
	КонецЕсли;

	ОбновлениеИнформационнойБазы.ПроверитьОбъектОбработан(Объект, ЭтотОбъект);

	Если Параметры.Свойство("Автозаполнение") Тогда
		Объект.Владелец						= Параметры["Владелец"];
		Объект.Наименование					= Параметры["Наименование"];
		Объект.Должность					= Параметры["Должность"];
		Объект.ПравоПодписиПоДоверенности	= Параметры["ПравоПодписиПоДоверенности"];
		Объект.ДатаНачала					= Параметры["ДатаНачала"];
		Объект.ДокументПраваПодписи			= Параметры["ДокументПраваПодписи"];
		Объект.НомерДокументаПраваПодписи	= Параметры["НомерДокументаПраваПодписи"];
		Объект.ДатаДокументаПраваПодписи	= Параметры["ДатаДокументаПраваПодписи"];
	КонецЕсли;
	
	ПриСозданииЧтенииНаСервере();
	
	//++ НЕ УТ
	Элементы.ОтветственноеЛицо.РежимВыбораИзСписка = Ложь;
	//-- НЕ УТ
	Элементы.Владелец.Видимость = ПолучитьФункциональнуюОпцию("ИспользоватьНесколькоОрганизаций");
	
	Если ПолучитьФункциональнуюОпцию("БазоваяВерсия") Тогда
		Элементы.ФизическоеЛицо.Заголовок = НСтр("ru='Сотрудник';uk='Співробітник'");
	КонецЕсли;
	
	// СтандартныеПодсистемы.ВерсионированиеОбъектов
	ВерсионированиеОбъектов.ПриСозданииНаСервере(ЭтотОбъект);
	// Конец СтандартныеПодсистемы.ВерсионированиеОбъектов
	
	СобытияФорм.ПриСозданииНаСервере(ЭтаФорма, Отказ, СтандартнаяОбработка);
	
КонецПроцедуры

&НаСервере
Процедура ПриЧтенииНаСервере(ТекущийОбъект)

	// СтандартныеПодсистемы.УправлениеДоступом
	Если ОбщегоНазначения.ПодсистемаСуществует("СтандартныеПодсистемы.УправлениеДоступом") Тогда
		МодульУправлениеДоступом = ОбщегоНазначения.ОбщийМодуль("УправлениеДоступом");
		МодульУправлениеДоступом.ПриЧтенииНаСервере(ЭтотОбъект, ТекущийОбъект);
	КонецЕсли;
	// Конец СтандартныеПодсистемы.УправлениеДоступом
	
	ПриСозданииЧтенииНаСервере();
	
	//++ НЕ БЗК
	МодификацияКонфигурацииПереопределяемый.ПриЧтенииНаСервере(ЭтаФорма, ТекущийОбъект);
	//-- НЕ БЗК

КонецПроцедуры

&НаКлиенте
Процедура ПередЗаписью(Отказ, ПараметрыЗаписи)
	
	УстановитьОснованиеПраваПодписи(Ложь);
	
КонецПроцедуры

&НаСервере
Процедура ПередЗаписьюНаСервере(Отказ, ТекущийОбъект, ПараметрыЗаписи)
	
	//++ НЕ БЗК
	МодификацияКонфигурацииПереопределяемый.ПередЗаписьюНаСервере(ЭтаФорма, Отказ, ТекущийОбъект, ПараметрыЗаписи);
	//-- НЕ БЗК

КонецПроцедуры

&НаКлиенте
Процедура ПослеЗаписи(ПараметрыЗаписи)
	
	//++ НЕ БЗК
	МодификацияКонфигурацииКлиентПереопределяемый.ПослеЗаписи(ЭтаФорма, ПараметрыЗаписи);
	//-- НЕ БЗК
	
	Оповестить("Запись_ФизическиеЛица", , Объект.ФизическоеЛицо);
	Оповестить("Запись_ОтветственныеЛицаОрганизаций", , Объект.Ссылка);
	
	//++ Локализация
	//-- Локализация
КонецПроцедуры

&НаСервере
Процедура ПослеЗаписиНаСервере(ТекущийОбъект, ПараметрыЗаписи)

	// СтандартныеПодсистемы.УправлениеДоступом
	УправлениеДоступом.ПослеЗаписиНаСервере(ЭтотОбъект, ТекущийОбъект, ПараметрыЗаписи);
	// Конец СтандартныеПодсистемы.УправлениеДоступом
	
	//++ НЕ БЗК
	МодификацияКонфигурацииПереопределяемый.ПослеЗаписиНаСервере(ЭтаФорма, ТекущийОбъект, ПараметрыЗаписи);
	//-- НЕ БЗК

КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовШапкиФормы

&НаКлиенте
Процедура ВидОтветственногоЛицаПриИзменении(Элемент)
	
	Объект.ПравоПодписиПоДоверенности = Булево(ВидОтветственногоЛица);
	
	УстановитьОснованиеПраваПодписи();
	
	УправлениеЭлементамиФормы(ЭтаФорма);
	
КонецПроцедуры

&НаКлиенте
Процедура ФизическоеЛицоПриИзменении(Элемент)
	
	//++ НЕ УТ
	Если ИспользоватьНачислениеЗарплаты Тогда
		ЗаполнитьПоКадровымДаннымФизическогоЛица();
	КонецЕсли;
	//-- НЕ УТ
	
	НаименованиеЗаполнитьСписокВыбора();
	
КонецПроцедуры

&НаКлиенте
Процедура ОтветственноеЛицоПриИзменении(Элемент)
	
	Если Не ИспользоватьНачислениеЗарплаты Тогда
		ДолжностиЗаполнитьСписокВыбора();
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ДолжностьСсылкаПриИзменении(Элемент)
	
	//++ НЕ УТ
	ЗаполнитьПредставлениеДолжности();
	//-- НЕ УТ
	
	Если Объект.ПравоПодписиПоДоверенности Тогда
		НаименованиеЗаполнитьСписокВыбора();
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ДолжностьПриИзменении(Элемент)
	
	Если Объект.ПравоПодписиПоДоверенности Тогда
		НаименованиеЗаполнитьСписокВыбора();
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ДокументПраваПодписиПриИзменении(Элемент)
	
	УстановитьОснованиеПраваПодписи();
	
КонецПроцедуры

&НаКлиенте
Процедура НомерДокументаПраваПодписиПриИзменении(Элемент)
	
	УстановитьОснованиеПраваПодписи();
	
КонецПроцедуры

&НаКлиенте
Процедура ДатаДокументаПраваПодписиПриИзменении(Элемент)
	
	УстановитьОснованиеПраваПодписи();
	
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
Процедура ПриСозданииЧтенииНаСервере()
	
	ВидОтветственногоЛица = Число(Объект.ПравоПодписиПоДоверенности);
	
	ИспользоватьНачислениеЗарплаты = Константы.ИспользоватьНачислениеЗарплаты.Получить();
	
	Если ИспользоватьНачислениеЗарплаты Тогда
		Элементы.ДолжностьСтрока.КнопкаВыпадающегоСписка = Ложь;
	Иначе
		Элементы.ДолжностьСтрока.Заголовок = НСтр("ru='Должность';uk='Посада'");
		ДолжностиЗаполнитьСписокВыбора();
	КонецЕсли;
	
	НаименованиеЗаполнитьСписокВыбора(Ложь);
	ДокументПраваПодписиЗаполнитьСписокВыбора();
	
	УправлениеЭлементамиФормы(ЭтаФорма);
	
КонецПроцедуры

&НаКлиентеНаСервереБезКонтекста
Процедура УправлениеЭлементамиФормы(Форма)
	
	Форма.Элементы.ГруппаДокументПраваПодписи.Доступность = (Форма.ВидОтветственногоЛица = 1);
	
КонецПроцедуры

//++ НЕ УТ

&НаСервере
Процедура ЗаполнитьПоКадровымДаннымФизическогоЛица()
	
	ПолучатьНаДату = ?(ЗначениеЗаполнено(Объект.ДатаНачала), Объект.ДатаНачала, НачалоДня(ТекущаяДатаСеанса()));
	ДанныеСотрудников = Новый ТаблицаЗначений();
	ИнтеграцияБЗК.ЗаполнитьОсновныхСотрудниковФизическихЛиц(
		ДанныеСотрудников,
		Объект.ФизическоеЛицо,
		Истина,
		Объект.Владелец,
		ПолучатьНаДату);
	
	КадровыеДанные = Новый ТаблицаЗначений;
	ИнтеграцияБЗК.ЗаполнитьТаблицуКадровыеДанныеСотрудников(КадровыеДанные, Истина, ДанныеСотрудников.ВыгрузитьКолонку("Сотрудник"), "Должность", ПолучатьНаДату);
	
	Если КадровыеДанные.Количество() > 0 Тогда
		Объект.ДолжностьСсылка = КадровыеДанные[0].Должность;
		ЗаполнитьПредставлениеДолжности();
	КонецЕсли;
	
КонецПроцедуры

&НаСервере
Процедура ЗаполнитьПредставлениеДолжности()
	
	Представление = ОбщегоНазначения.ЗначениеРеквизитаОбъекта(Объект.ДолжностьСсылка, "Наименование");
	
	Объект.Должность = Представление;
	
КонецПроцедуры

//-- НЕ УТ

#Область ЗаполнениеСписковВыбора

&НаСервере
Процедура ДолжностиЗаполнитьСписокВыбора()
	
	Запрос = Новый Запрос;
	Запрос.Текст =
	"ВЫБРАТЬ РАЗРЕШЕННЫЕ РАЗЛИЧНЫЕ
	|	ОтветственныеЛицаОрганизаций.Должность КАК Должность
	|ИЗ
	|	Справочник.ОтветственныеЛицаОрганизаций КАК ОтветственныеЛицаОрганизаций
	|ГДЕ
	|	ОтветственныеЛицаОрганизаций.Должность <> """"
	|	И ОтветственныеЛицаОрганизаций.ОтветственноеЛицо = &ОтветственноеЛицо
	|	И НЕ ОтветственныеЛицаОрганизаций.ПометкаУдаления
	|
	|УПОРЯДОЧИТЬ ПО
	|	Должность";
	
	Запрос.УстановитьПараметр("ОтветственноеЛицо", Объект.ОтветственноеЛицо);
	
	МассивДолжностей = Запрос.Выполнить().Выгрузить().ВыгрузитьКолонку("Должность");
	Элементы.ДолжностьСтрока.СписокВыбора.ЗагрузитьЗначения(МассивДолжностей);
	
КонецПроцедуры

&НаСервере
Процедура НаименованиеЗаполнитьСписокВыбора(ОчищатьПоле = Истина)
	
	Если ОчищатьПоле Тогда
		Объект.Наименование = "";
	КонецЕсли;
	
	Элементы.Наименование.СписокВыбора.Очистить();
	
	Если ЗначениеЗаполнено(Объект.ФизическоеЛицо) Тогда
		
		ФамилияИнициалы = ФизическиеЛицаУТ.ФамилияИнициалыФизЛица(Объект.ФизическоеЛицо, Объект.ДатаНачала);
		
		Если Объект.ПравоПодписиПоДоверенности Тогда
			
			Если ЗначениеЗаполнено(Объект.ОснованиеПраваПодписи) Тогда
				Элементы.Наименование.СписокВыбора.Добавить(ФамилияИнициалы + ", " + Объект.ОснованиеПраваПодписи);
				Если ЗначениеЗаполнено(Объект.Должность) Тогда
					Элементы.Наименование.СписокВыбора.Добавить(ФамилияИнициалы + ", " + Объект.Должность + ", " + Объект.ОснованиеПраваПодписи);
				КонецЕсли;
			КонецЕсли;
			
		КонецЕсли;
		
		Элементы.Наименование.СписокВыбора.Добавить(ФамилияИнициалы);
		
	КонецЕсли;
	
КонецПроцедуры

&НаСервере
Процедура ДокументПраваПодписиЗаполнитьСписокВыбора()
	
	КодЯзыкаИнформационнойБазы = МультиязычностьУкр.КодЯзыкаИнформационнойБазы();
	Элементы.ДокументПраваПодписи.СписокВыбора.Очистить();
	Элементы.ДокументПраваПодписи.СписокВыбора.Добавить(НСтр("ru='Доверенность';uk= 'Довіреність'", КодЯзыкаИнформационнойБазы));
	Элементы.ДокументПраваПодписи.СписокВыбора.Добавить(НСтр("ru='Приказ';uk= 'Наказ'", КодЯзыкаИнформационнойБазы));
	
КонецПроцедуры

#КонецОбласти

&НаКлиенте
Процедура УстановитьОснованиеПраваПодписи(ОчищатьНаименование = Истина)
	
	Если Объект.ПравоПодписиПоДоверенности Тогда
		Объект.ОснованиеПраваПодписи =
			Объект.ДокументПраваПодписи 
			+ ?(ПустаяСтрока(Объект.НомерДокументаПраваПодписи), "", " № " + Объект.НомерДокументаПраваПодписи)
			+ ?(НЕ ЗначениеЗаполнено(Объект.ДатаДокументаПраваПодписи),  "", " " + НСтр("ru='от';uk='від'") + " " + Формат(Объект.ДатаДокументаПраваПодписи, "ДЛФ=D") + " " + НСтр("ru='г.';uk='р.'"));
	Иначе
		Объект.ОснованиеПраваПодписи = "";
	КонецЕсли;
	
	НаименованиеЗаполнитьСписокВыбора(ОчищатьНаименование);
	
КонецПроцедуры

#КонецОбласти
