#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
		
	Если Параметры.Свойство("АвтоТест") Тогда // Возврат при получении формы для анализа.
		Возврат;
	КонецЕсли;
	
	Если Параметры.Свойство("ВыбранныеГруппы")
		И ЗначениеЗаполнено(Параметры.ВыбранныеГруппы) Тогда
		ОтмеченныеГруппы = Параметры.ВыбранныеГруппы;
	Иначе
		ОтмеченныеГруппы = Новый Массив;
	КонецЕсли;
	
	ЗаполнитьДеревоГрупп(ОтмеченныеГруппы);
	
	Если Параметры.МножественныйВыбор = Истина Тогда
		Элементы.ДеревоГрупп.МножественныйВыбор = Истина;
	Иначе
		
		ОбщегоНазначенияКлиентСервер.УстановитьСвойствоЭлементаФормы(
			Элементы,
			"ДеревоГруппИспользуется",
			"Видимость",
			Ложь);
			
	КонецЕсли; 
	
КонецПроцедуры

&НаКлиенте
Процедура ОбработкаОповещения(ИмяСобытия, Параметр, Источник)
	
	Если ИмяСобытия = "Запись_ГруппыСотрудников" Тогда
		
		СписокГрупп = Новый Массив;
		ОтмеченныеГруппы(ДеревоГрупп.ПолучитьЭлементы(), СписокГрупп);
		
		ЗаполнитьДеревоГрупп(СписокГрупп, Параметр);

	КонецЕсли; 
	
КонецПроцедуры

#КонецОбласти


#Область ОбработчикиСобытийЭлементовТаблицыФормыДеревоГрупп

&НаКлиенте
Процедура ДеревоГруппВыборЗначения(Элемент, Значение, СтандартнаяОбработка)
	
	СтандартнаяОбработка = Ложь;
	ОповеститьОВыборе(Значение.Ссылка);
	
КонецПроцедуры

&НаКлиенте
Процедура ДеревоГруппВыбор(Элемент, ВыбраннаяСтрока, Поле, СтандартнаяОбработка)
	
	ТекущиеДанные = ДеревоГрупп.НайтиПоИдентификатору(ВыбраннаяСтрока);
	Если ТекущиеДанные <> Неопределено Тогда
		СтандартнаяОбработка = Ложь;
		ОповеститьОВыборе(ТекущиеДанные.Ссылка);
	КонецЕсли; 
	
КонецПроцедуры

&НаКлиенте
Процедура ДеревоГруппПередНачаломДобавления(Элемент, Отказ, Копирование, Родитель, Группа, Параметр)
	
	Отказ = Истина;
	ПараметрыОткрытия = Новый Структура;
	ПараметрыОткрытия.Вставить("СозданиеГруппыСРучнымФормированием", Истина);
	ПараметрыОткрытия.Вставить("РежимВыбора",  Истина);
	
	Если Элементы.ДеревоГрупп.ТекущиеДанные <> Неопределено Тогда
		
		ЗначенияЗаполнения = Новый Структура;
		ЗначенияЗаполнения.Вставить("Родитель", Элементы.ДеревоГрупп.ТекущиеДанные.Ссылка);
		ПараметрыОткрытия.Вставить("ЗначенияЗаполнения", ЗначенияЗаполнения);
		
	КонецЕсли; 
	
	ОткрытьФорму("Справочник.ГруппыСотрудников.ФормаОбъекта", ПараметрыОткрытия, ЭтаФорма, Истина, , , , РежимОткрытияОкнаФормы.БлокироватьОкноВладельца);
	
КонецПроцедуры

&НаКлиенте
Процедура ДеревоГруппПередУдалением(Элемент, Отказ)
	
	Отказ = Истина;
	ТекущиеДанные = ДеревоГрупп.НайтиПоИдентификатору(Элементы.ДеревоГрупп.ТекущаяСтрока);
	Если ТекущиеДанные <> Неопределено Тогда
		
		Оповещение = Новый ОписаниеОповещения("УдалениеГруппыЗавершение", ЭтотОбъект);
		Если ТекущиеДанные.ПометкаУдаления Тогда
			ТекстВопроса = НСтр("ru='Снять с ""%1"" пометку на удаление?';uk='Зняти з ""%1"" позначку на вилучення?'")
		Иначе
			ТекстВопроса = НСтр("ru='Пометить ""%1"" на удаление?';uk='Відмітити ""%1"" для вилучення?'")
		КонецЕсли;
		
		ТекстВопроса = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(
			ТекстВопроса,
			ТекущиеДанные.Представление);
		
		ПоказатьВопрос(Оповещение, ТекстВопроса, РежимДиалогаВопрос.ДаНет);
		
	КонецЕсли; 
	
КонецПроцедуры

#КонецОбласти


#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура Ок(Команда)
	
	Если Элементы.ДеревоГрупп.МножественныйВыбор Тогда
		
		ВыбранныеЗначения = Новый Массив;
		ОтмеченныеГруппы(ДеревоГрупп.ПолучитьЭлементы(), ВыбранныеЗначения);
		
	Иначе
		
		ВыбранныеЗначения = Неопределено;
		Если ДеревоГрупп.ПолучитьЭлементы().Количество() > 0 Тогда
			ОповеститьОВыборе(ДеревоГрупп.ПолучитьЭлементы()[0].Ссылка);
		КонецЕсли;
		
	КонецЕсли;
	
	Если Открыта() Тогда
		Закрыть(ВыбранныеЗначения);
	КонецЕсли; 
	
КонецПроцедуры

&НаКлиенте
Процедура Обновить(Команда)
	
	СписокГрупп = Новый Массив;
	ОтмеченныеГруппы(ДеревоГрупп.ПолучитьЭлементы(), СписокГрупп);
	
	ЗаполнитьДеревоГрупп(СписокГрупп);
	
КонецПроцедуры

#КонецОбласти


#Область СлужебныеПроцедурыИФункции

&НаКлиенте
Процедура УдалениеГруппыЗавершение(Результат, ДополнительныеПараметры) Экспорт
	
	Если Результат = КодВозвратаДиалога.Да Тогда
		УстановитьПометкуНаУдалениеТекущегоЭлемента();
	КонецЕсли; 
	
КонецПроцедуры

&НаСервере
Процедура УстановитьПометкуНаУдалениеТекущегоЭлемента()
	
	ТекущиеДанные = ДеревоГрупп.НайтиПоИдентификатору(Элементы.ДеревоГрупп.ТекущаяСтрока);
	Если ТекущиеДанные <> Неопределено Тогда
		
		ГруппаОбъект = ТекущиеДанные.Ссылка.ПолучитьОбъект();
		ГруппаОбъект.УстановитьПометкуУдаления(Не ГруппаОбъект.ПометкаУдаления);
		
		ТекущиеДанные.ПометкаУдаления = ГруппаОбъект.ПометкаУдаления;
		Если ГруппаОбъект.ПометкаУдаления Тогда
			ТекущиеДанные.Пиктограмма = ТекущиеДанные.Пиктограмма + 1;
		Иначе
			ТекущиеДанные.Пиктограмма = ТекущиеДанные.Пиктограмма - 1;
		КонецЕсли;
		
	КонецЕсли; 
	
КонецПроцедуры

&НаСервере
Процедура ЗаполнитьДеревоГрупп(ОтмеченныеГруппы, ТекущаяСсылка= Неопределено)
	
	Если ТекущаяСсылка= Неопределено Тогда
		
		Если Элементы.ДеревоГрупп.ТекущаяСтрока = Неопределено Тогда
			ТекущаяСсылка = Неопределено;
		Иначе
			ТекущаяСсылка = ДеревоГрупп.НайтиПоИдентификатору(Элементы.ДеревоГрупп.ТекущаяСтрока).Ссылка;
		КонецЕсли;
		
	КонецЕсли; 
	
	ДеревоГрупп.ПолучитьЭлементы().Очистить();
	
	ДобавленныеСсылки = Новый Соответствие;
	ТекущаяСтрока = ДобавитьСтроки(ОбщегоНазначенияКлиентСервер.ЗначениеВМассиве(Справочники.ГруппыСотрудников.ПустаяСсылка()),	ДобавленныеСсылки, ОтмеченныеГруппы, ТекущаяСсылка);
	
	Если ЗначениеЗаполнено(ТекущаяСтрока) Тогда
		Элементы.ДеревоГрупп.ТекущаяСтрока = ТекущаяСтрока;
	КонецЕсли; 
	
КонецПроцедуры
	
&НаСервере	
Функция ДобавитьСтроки(Родители, ДобавленныеСсылки, ОтмеченныеГруппы, ТекущаяГруппа)
	
	ИдентификаторСтроки = Неопределено;
	
	Запрос = Новый Запрос;
	Запрос.УстановитьПараметр("Родители", Родители);
	Запрос.УстановитьПараметр("ОтмеченныеГруппы", ОтмеченныеГруппы);
	
	Запрос.Текст =
		"ВЫБРАТЬ
		|	ГруппыСотрудников.Ссылка,
		|	ГруппыСотрудников.Родитель,
		|	ГруппыСотрудников.Наименование,
		|	ГруппыСотрудников.ПометкаУдаления,
		|	ГруппыСотрудников.ФормироватьАвтоматически КАК ФормироватьАвтоматически,
		|	ВЫБОР
		|		КОГДА НЕ ГруппыСотрудников.ФормироватьАвтоматически
		|				И НЕ ГруппыСотрудников.ПометкаУдаления
		|			ТОГДА 0
		|		КОГДА НЕ ГруппыСотрудников.ФормироватьАвтоматически
		|				И ГруппыСотрудников.ПометкаУдаления
		|			ТОГДА 1
		|		КОГДА ГруппыСотрудников.ФормироватьАвтоматически
		|				И НЕ ГруппыСотрудников.ПометкаУдаления
		|			ТОГДА 2
		|		КОГДА ГруппыСотрудников.ФормироватьАвтоматически
		|				И ГруппыСотрудников.ПометкаУдаления
		|			ТОГДА 3
		|	КОНЕЦ КАК Пиктограмма,
		|	ВЫБОР
		|		КОГДА ГруппыСотрудников.Ссылка В (&ОтмеченныеГруппы)
		|			ТОГДА ИСТИНА
		|		ИНАЧЕ ЛОЖЬ
		|	КОНЕЦ КАК Используется,
		|	КОЛИЧЕСТВО(РАЗЛИЧНЫЕ СоставГруппСотрудников.Сотрудник) КАК КоличествоСотрудников
		|ИЗ
		|	Справочник.ГруппыСотрудников КАК ГруппыСотрудников
		|		ЛЕВОЕ СОЕДИНЕНИЕ РегистрСведений.СоставГруппСотрудников КАК СоставГруппСотрудников
		|		ПО ГруппыСотрудников.Ссылка = СоставГруппСотрудников.ГруппаСотрудников
		|ГДЕ
		|	ГруппыСотрудников.Родитель В(&Родители)
		|	И НЕ ГруппыСотрудников.ФормироватьАвтоматически
		|
		|СГРУППИРОВАТЬ ПО
		|	ГруппыСотрудников.Ссылка,
		|	ГруппыСотрудников.Родитель,
		|	ГруппыСотрудников.ПометкаУдаления,
		|	ГруппыСотрудников.ФормироватьАвтоматически,
		|	ГруппыСотрудников.Наименование
		|
		|УПОРЯДОЧИТЬ ПО
		|	ФормироватьАвтоматически,
		|	ГруппыСотрудников.Наименование";
		
	РодителиТекущегоУровня = Новый Массив;
	
	Выборка = Запрос.Выполнить().Выбрать();
	Пока Выборка.Следующий() Цикл
		
		Если Не ЗначениеЗаполнено(Выборка.Родитель) Тогда
			СтрокиРодителя = ДеревоГрупп.ПолучитьЭлементы();
		Иначе
			СтрокиРодителя = ДобавленныеСсылки.Получить(Выборка.Родитель).ПолучитьЭлементы();
		КонецЕсли;
		
		НоваяСтрока = СтрокиРодителя.Добавить();
		ЗаполнитьЗначенияСвойств(НоваяСтрока, Выборка);
		
		НоваяСтрока.Представление = Выборка.Наименование;
		Если Выборка.КоличествоСотрудников > 0 Тогда
			НоваяСтрока.Представление = НоваяСтрока.Представление + " (" + Выборка.КоличествоСотрудников + ")";
		КонецЕсли; 
		
		Если Не ЗначениеЗаполнено(ИдентификаторСтроки) И Выборка.Ссылка = ТекущаяГруппа Тогда
			ИдентификаторСтроки = НоваяСтрока.ПолучитьИдентификатор();
			НоваяСтрока.Используется = Истина;
		КонецЕсли; 
		
		ДобавленныеСсылки.Вставить(Выборка.Ссылка, НоваяСтрока);
		РодителиТекущегоУровня.Добавить(Выборка.Ссылка);
		
	КонецЦикла; 
	
	Если РодителиТекущегоУровня.Количество() > 0 Тогда
		ИдентификаторРодителей = ДобавитьСтроки(РодителиТекущегоУровня, ДобавленныеСсылки, ОтмеченныеГруппы, ТекущаяГруппа);
		Если ЗначениеЗаполнено(ИдентификаторРодителей) Тогда
			ИдентификаторСтроки = ИдентификаторРодителей;
		КонецЕсли; 
	КонецЕсли; 
	
	Возврат ИдентификаторСтроки;
	
КонецФункции

&НаКлиенте
Процедура ОтмеченныеГруппы(КоллекцияГрупп, СписокГрупп)
	
	Для каждого СтрокаГруппы Из КоллекцияГрупп Цикл
		
		Если СтрокаГруппы.Используется Тогда
			СписокГрупп.Добавить(СтрокаГруппы.Ссылка);
		КонецЕсли;
		
		ОтмеченныеГруппы(СтрокаГруппы.ПолучитьЭлементы(), СписокГрупп);
		
	КонецЦикла;
	
КонецПроцедуры

#КонецОбласти
