
&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	Если Параметры.Свойство("АвтоТест") Тогда
		Возврат;
	КонецЕсли;
	
	Параметры.Свойство("ФизическоеЛицоСсылка", ФизическоеЛицоСсылка);
	
	Если Не ЗначениеЗаполнено(ФизическоеЛицоСсылка) Тогда
		Отказ = Истина;
		Возврат;
	КонецЕсли; 
	
	ЗаполнитьТаблицуРолей(СотрудникиФормыРасширенный.ТаблицаДругихРолейФизическогоЛица(ФизическоеЛицоСсылка));
	
КонецПроцедуры

&НаСервере
Процедура ЗаполнитьТаблицуРолей(ТаблицаДругихРолей)
	
	Запрос = Новый Запрос;
	Запрос.Текст =
	"ВЫБРАТЬ РАЗРЕШЕННЫЕ
	|	Организации.Ссылка КАК Организация
	|ИЗ
	|	Справочник.Организации КАК Организации
	|ГДЕ
	|   Организации.Ссылка <> ЗНАЧЕНИЕ(Справочник.Организации.УправленческаяОрганизация)
	|
	|УПОРЯДОЧИТЬ ПО
	|	Организации.Наименование";
	
	Запрос.УстановитьПараметр("ФизическоеЛицоСсылка", ФизическоеЛицоСсылка);
	
	РолиФизическогоЛица.Загрузить(Запрос.Выполнить().Выгрузить());
	
	Для каждого ОписаниеРоли Из ТаблицаДругихРолей  Цикл
		
		СтрокиОрганизации = РолиФизическогоЛица.НайтиСтроки(Новый Структура("Организация", ОписаниеРоли.Организация));
		Если ОписаниеРоли.Роль = Перечисления.РолиФизическихЛиц.Акционер Тогда
			СтрокиОрганизации[0].Акционер = Истина;
		ИначеЕсли ОписаниеРоли.Роль = Перечисления.РолиФизическихЛиц.ПрочийПолучательДоходов Тогда
			СтрокиОрганизации[0].ПрочийПолучательДоходов = Истина;
		ИначеЕсли ОписаниеРоли.Роль = Перечисления.РолиФизическихЛиц.БывшийСотрудник Тогда
			СтрокиОрганизации[0].БывшийСотрудник = Истина;
		ИначеЕсли ОписаниеРоли.Роль = Перечисления.РолиФизическихЛиц.РаздатчикЗарплаты Тогда
			СтрокиОрганизации[0].РаздатчикЗарплаты = Истина;
		КонецЕсли;
		
	КонецЦикла;
	
	Запрос.Текст =
		"ВЫБРАТЬ РАЗРЕШЕННЫЕ РАЗЛИЧНЫЕ
		|	Сотрудники.ГоловнаяОрганизация
		|ПОМЕСТИТЬ ВТГоловныеОрганизации
		|ИЗ
		|	Справочник.Сотрудники КАК Сотрудники
		|ГДЕ
		|	Сотрудники.ФизическоеЛицо = &ФизическоеЛицоСсылка
		|;
		|
		|////////////////////////////////////////////////////////////////////////////////
		|ВЫБРАТЬ РАЗРЕШЕННЫЕ РАЗЛИЧНЫЕ
		|	Организации.Ссылка КАК Организация
		|ИЗ
		|	ВТГоловныеОрганизации КАК ГоловныеОрганизации
		|		ВНУТРЕННЕЕ СОЕДИНЕНИЕ Справочник.Организации КАК Организации
		|		ПО ГоловныеОрганизации.ГоловнаяОрганизация = Организации.ГоловнаяОрганизация";
		
	Запрос.УстановитьПараметр("ФизическоеЛицоСсылка", ФизическоеЛицоСсылка);
	МассивОрганизаций = Запрос.Выполнить().Выгрузить().ВыгрузитьКолонку("Организация");
	
	Если РолиФизическогоЛица.Количество() > 1 Тогда
		
		ОбщегоНазначенияКлиентСервер.УстановитьСвойствоЭлементаФормы(
			Элементы,
			"ГруппаСтраницыРолей",
			"ТекущаяСтраница",
			Элементы.НесколькоОрганизаций);
			
		ОрганизацииБывшихСотрудников = Новый СписокЗначений;
		ОрганизацииБывшихСотрудников.ЗагрузитьЗначения(МассивОрганизаций);
		
		// Роль БывшийСотрудник
		ЭлементОформления = УсловноеОформление.Элементы.Добавить();
		
		Отображение = ЭлементОформления.Оформление.Элементы.Найти("Отображать");
		Отображение.Значение = Ложь;
		Отображение.Использование = Истина;
		
		ЭлементОтбораДанных = ЭлементОформления.Отбор.Элементы.Добавить(Тип("ЭлементОтбораКомпоновкиДанных"));
		ЭлементОтбораДанных.ЛевоеЗначение = Новый ПолеКомпоновкиДанных("РолиФизическогоЛица.Организация");
		ЭлементОтбораДанных.ВидСравнения = ВидСравненияКомпоновкиДанных.НеВСписке;
		ЭлементОтбораДанных.ПравоеЗначение = ОрганизацииБывшихСотрудников;
		ЭлементОтбораДанных.Использование = Истина;
		
		ОформляемоеПоле = ЭлементОформления.Поля.Элементы.Добавить(); 
		ОформляемоеПоле.Поле = Новый ПолеКомпоновкиДанных("РолиФизическогоЛицаБывшийСотрудник");
		
		ОбщегоНазначенияКлиентСервер.УстановитьСвойствоЭлементаФормы(
			Элементы,
			"РолиФизическогоЛицаБывшийСотрудник",
			"Видимость",
			МассивОрганизаций.Количество() > 0);
			
	Иначе
		
		ОбщегоНазначенияКлиентСервер.УстановитьСвойствоЭлементаФормы(
			Элементы,
			"ГруппаСтраницыРолей",
			"ТекущаяСтраница",
			Элементы.ОднаОрганизация);
			
		ОбщегоНазначенияКлиентСервер.УстановитьСвойствоЭлементаФормы(
			Элементы,
			"РольФизическогоЛицаАкционер",
			"Заголовок",
			СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(
				НСтр("ru='Акционер в %1';uk='Акціонер у %1'"),
				РолиФизическогоЛица[0].Организация));
			
		ОбщегоНазначенияКлиентСервер.УстановитьСвойствоЭлементаФормы(
			Элементы,
			"РольФизическогоЛицаПрочийПолучательДоходов",
			"Заголовок",
			СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(
				НСтр("ru='Получает доход по прочим договорам в %1';uk='Отримує дохід за іншими договорами у %1'"),
				РолиФизическогоЛица[0].Организация));
			
		ОбщегоНазначенияКлиентСервер.УстановитьСвойствоЭлементаФормы(
			Элементы,
			"РольФизическогоЛицаБывшийСотрудник",
			"Заголовок",
			СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(
				НСтр("ru='Бывший сотрудник %1';uk='Колишній співробітник %1'"),
				РолиФизическогоЛица[0].Организация));
		
		ОбщегоНазначенияКлиентСервер.УстановитьСвойствоЭлементаФормы(
			Элементы,
			"РольФизическогоЛицаБывшийСотрудник",
			"Видимость",
			МассивОрганизаций.Количество() > 0);
			
		ОбщегоНазначенияКлиентСервер.УстановитьСвойствоЭлементаФормы(
			Элементы,
			"РольФизическогоЛицаРаздатчикЗарплаты",
			"Заголовок",
			СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(
				НСтр("ru='Раздатчик зарплаты %1';uk='Роздавальник зарплати %1'"),
				РолиФизическогоЛица[0].Организация));
		
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура КомандаOK(Команда)
	
	Если Модифицированность Тогда
		
		МассивРолей = Новый Массив;
		Для каждого СтрокаРолиОрганизации Из РолиФизическогоЛица Цикл
			
			Если СтрокаРолиОрганизации.Акционер Тогда
				МассивРолей.Добавить(Новый Структура("Организация,Роль", СтрокаРолиОрганизации.Организация, ПредопределенноеЗначение("Перечисление.РолиФизическихЛиц.Акционер")));
			КонецЕсли;
				
			Если СтрокаРолиОрганизации.ПрочийПолучательДоходов Тогда
				МассивРолей.Добавить(Новый Структура("Организация,Роль", СтрокаРолиОрганизации.Организация, ПредопределенноеЗначение("Перечисление.РолиФизическихЛиц.ПрочийПолучательДоходов")));
			КонецЕсли;
			
			Если СтрокаРолиОрганизации.БывшийСотрудник Тогда
				МассивРолей.Добавить(Новый Структура("Организация,Роль", СтрокаРолиОрганизации.Организация, ПредопределенноеЗначение("Перечисление.РолиФизическихЛиц.БывшийСотрудник")));
			КонецЕсли;
			
			Если СтрокаРолиОрганизации.РаздатчикЗарплаты Тогда
				МассивРолей.Добавить(Новый Структура("Организация,Роль", СтрокаРолиОрганизации.Организация, ПредопределенноеЗначение("Перечисление.РолиФизическихЛиц.РаздатчикЗарплаты")));
			КонецЕсли;
			
		КонецЦикла;
		
		СохранитьДанные(МассивРолей);
		
		Оповестить("ИзмененСоставРолейФизическогоЛица", МассивРолей, ФизическоеЛицоСсылка);
		
	КонецЕсли; 
	
	Закрыть();
	
КонецПроцедуры

&НаСервере
Процедура СохранитьДанные(МассивРолей) Экспорт
	
	РегистрыСведений.РолиФизическихЛиц.ОбновитьРолиФизическогоЛица(ФизическоеЛицоСсылка, МассивРолей);
	Модифицированность = Ложь;
	
КонецПроцедуры
