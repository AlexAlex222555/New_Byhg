////////////////////////////////////////////////////////////////////////////////
// ЗарплатаКадрыОтчеты: Методы, используемые для работы отчетов.
//  
////////////////////////////////////////////////////////////////////////////////

#Область ПрограммныйИнтерфейс

// Содержит настройки размещения вариантов отчетов в панели отчетов.
// Описание см. ВариантыОтчетовПереопределяемый.НастроитьВариантыОтчетов.
//
Процедура НастроитьВариантыОтчетов(Настройки) Экспорт
	
	ЗарплатаКадрыОтчетыВнутренний.НастроитьВариантыОтчетов(Настройки);
	ЗарплатаКадрыОтчетыПереопределяемый.НастроитьВариантыОтчетов(Настройки);
	
КонецПроцедуры

#КонецОбласти


#Область СлужебныйПрограммныйИнтерфейс

// Добавляет элемент отбора, предварительно проверив доступность поля отбора.
//
// Параметры:
//		Отбор - ОтборКомпоновкиДанных
//		ИмяПоля - Строка
//		ВидСравнения - Системное перечисление ВидСравненияКомпоновкиДанных.
//		ПравоеЗначение - любое значение.
//
Процедура ДобавитьЭлементОтбора(Отбор, ИмяПоля, ВидСравнения, ПравоеЗначение) Экспорт
	
	Если Отбор.ДоступныеПоляОтбора.НайтиПоле(Новый ПолеКомпоновкиДанных(ИмяПоля)) <> Неопределено Тогда
		
		ОбщегоНазначенияКлиентСервер.ДобавитьЭлементКомпоновки(
			Отбор, ИмяПоля, ВидСравнения, ПравоеЗначение);
			
	КонецЕсли; 
	
КонецПроцедуры

Функция КлючВарианта(КомпоновщикНастроек) Экспорт
	
	КлючВарианта = Неопределено;
	Если Не ЗначениеЗаполнено(КлючВарианта) Тогда
		
		НастройкиОтчета = КомпоновщикНастроек.ПолучитьНастройки();
		ЗначениеПараметра = НастройкиОтчета.ПараметрыДанных.НайтиЗначениеПараметра(Новый ПараметрКомпоновкиДанных("КлючВарианта"));
		Если ЗначениеПараметра <> Неопределено
			И ЗначениеПараметра.Использование
			И ЗначениеЗаполнено(ЗначениеПараметра.Значение) Тогда
			
				КлючВарианта = ЗначениеПараметра.Значение;
			
		КонецЕсли; 
		
	КонецЕсли; 
	
	Возврат КлючВарианта;
	
КонецФункции

// Находит пользовательскую настройку по имени параметра.
//   Если пользовательская настройка не найдена (например,
//   если параметр не выведен в пользовательские настройки),
//   то получает общую настройку параметра.
//
// Параметры:
//   КомпоновщикНастроекКД - КомпоновщикНастроекКомпоновкиДанных - Компоновщик настроек.
//   ИмяПараметра          - Строка - Имя параметра.
//
// Возвращаемое значение:
//   ЗначениеПараметраНастроекКомпоновкиДанных - Пользовательская настройка параметра.
//   ЗначениеПараметраКомпоновкиДанных - Общая настройка параметра.
//   Неопределено - Если параметр не найден.
//
Функция НайтиПараметр(КомпоновщикНастроекКД, ИмяПараметра) Экспорт
	ПараметрКД = Новый ПараметрКомпоновкиДанных(ИмяПараметра);
	
	Для Каждого ПользовательскаяНастройка Из КомпоновщикНастроекКД.ПользовательскиеНастройки.Элементы Цикл
		Если ТипЗнч(ПользовательскаяНастройка) = Тип("ЗначениеПараметраНастроекКомпоновкиДанных")
			И ПользовательскаяНастройка.Параметр = ПараметрКД Тогда
			Возврат ПользовательскаяНастройка;
		КонецЕсли;
	КонецЦикла;
	
	Возврат КомпоновщикНастроекКД.Настройки.ПараметрыДанных.НайтиЗначениеПараметра(ПараметрКД);
КонецФункции

Функция МакетКомпоновкиДанных(Схема, Настройки, ДанныеРасшифровки = Неопределено, МакетОформления = Неопределено,
	ПроверятьДоступностьПолей = Истина, ПараметрыФункциональныхОпций = Неопределено, ТипГенератора = Неопределено) Экспорт
	
	Если ТипГенератора = Неопределено Тогда
		ТипГенератора = Тип("ГенераторМакетаКомпоновкиДанных");
	КонецЕсли;
	
	КомпоновщикМакета = Новый КомпоновщикМакетаКомпоновкиДанных;
	МакетКомпоновкиДанных = КомпоновщикМакета.Выполнить(Схема, Настройки, ДанныеРасшифровки, МакетОформления,
		ТипГенератора, ПроверятьДоступностьПолей, ПараметрыФункциональныхОпций);
	
	УточнитьОтборыЗапросовНаборовДанныхМакетаКомпоновкиДанных(МакетКомпоновкиДанных.НаборыДанных);
	
	Возврат МакетКомпоновкиДанных;
	
КонецФункции

Функция МакетКомпоновкиДанныхДляКоллекцииЗначений(Схема, Настройки, ДанныеРасшифровки = Неопределено, МакетОформления = Неопределено,
	ПроверятьДоступностьПолей = Истина, ПараметрыФункциональныхОпций = Неопределено) Экспорт
	
	Возврат МакетКомпоновкиДанных(Схема, Настройки, ДанныеРасшифровки, МакетОформления,
		ПроверятьДоступностьПолей, ПараметрыФункциональныхОпций, Тип("ГенераторМакетаКомпоновкиДанныхДляКоллекцииЗначений"));
	
КонецФункции

#КонецОбласти


#Область СлужебныеПроцедурыИФункции

Функция СоответствиеПользовательскихПолей(НастройкиОтчета) Экспорт
	
	ЭлементыПользовательскихПолей = НастройкиОтчета.ПользовательскиеПоля.Элементы;
	
	СоответствиеПользовательскихПолей = Новый Соответствие;
	
	Для каждого Элемент Из ЭлементыПользовательскихПолей Цикл
		СоответствиеПользовательскихПолей.Вставить(Элемент.Заголовок, СтрЗаменить(Элемент.ПутьКДанным,".",""));
	КонецЦикла;
	
	Возврат СоответствиеПользовательскихПолей;
	
КонецФункции

Процедура ЗаполнитьПараметрыПользовательскихПолей(Макет, Данные, СоответствиеПользовательскихПолей, ИменаЗаполняемыхПолей = "") Экспорт
	
	ЗаполняемыеПоля = СтроковыеФункцииКлиентСервер.РазложитьСтрокуВМассивПодстрок(ИменаЗаполняемыхПолей);
	
	СтруктураДанных = Новый Структура;
	Для каждого СоответствиеПользовательскогоПоля Из СоответствиеПользовательскихПолей Цикл
		
		Если ЗаполняемыеПоля.Количество() > 0
			И ЗаполняемыеПоля.Найти(СоответствиеПользовательскогоПоля.Ключ) = Неопределено Тогда
			Продолжить;
		КонецЕсли; 
		
		СтруктураДанных.Вставить(СоответствиеПользовательскогоПоля.Значение);
		
	КонецЦикла;
	
	ЗаполнитьЗначенияСвойств(СтруктураДанных, Данные);
	
	СтруктураЗначенийПользовательскихПолей = Новый Структура;
	Для каждого СоответствиеПользовательскогоПоля Из СоответствиеПользовательскихПолей Цикл
		
		Если ЗаполняемыеПоля.Количество() > 0
			И ЗаполняемыеПоля.Найти(СоответствиеПользовательскогоПоля.Ключ) = Неопределено Тогда
			Продолжить;
		КонецЕсли; 
		
		СтруктураЗначенийПользовательскихПолей.Вставить(СоответствиеПользовательскогоПоля.Ключ, СтруктураДанных[СоответствиеПользовательскогоПоля.Значение]);
		
	КонецЦикла;
	
	ЗаполнитьЗначенияСвойств(Макет.Параметры, СтруктураЗначенийПользовательскихПолей);
	
КонецПроцедуры

Процедура ЗаполнитьПользовательскиеПоляВариантаОтчета(КлючВарианта, НастройкиОтчета) Экспорт
	
	ЗарплатаКадрыОтчетыВнутренний.ЗаполнитьПользовательскиеПоляВариантаОтчета(КлючВарианта, НастройкиОтчета);
	
КонецПроцедуры

Процедура НастроитьВариантОтчетаРасчетныйЛисток(НастройкиОтчета) Экспорт
	
	ЗарплатаКадрыОтчетыВнутренний.НастроитьВариантОтчетаРасчетныйЛисток(НастройкиОтчета);
	
КонецПроцедуры

Процедура ОтчетАнализНачисленийИУдержанийПередЗагрузкойНастроекВКомпоновщик(Контекст, КлючСхемы, КлючВарианта, НовыеНастройкиКД, НовыеПользовательскиеНастройкиКД) Экспорт
	
	ЗарплатаКадрыОтчетыВнутренний.ОтчетАнализНачисленийИУдержанийПередЗагрузкойНастроекВКомпоновщик(Контекст, КлючСхемы, КлючВарианта, НовыеНастройкиКД, НовыеПользовательскиеНастройкиКД);
	
КонецПроцедуры

Процедура УточнитьОтборыЗапросовНаборовДанныхМакетаКомпоновкиДанных(НаборыДанных)
	
	Для Каждого НаборДанных Из НаборыДанных Цикл
		
		Если ТипЗнч(НаборДанных) = Тип("НаборДанныхОбъединениеМакетаКомпоновкиДанных") Тогда
			УточнитьОтборыЗапросовНаборовДанныхМакетаКомпоновкиДанных(НаборДанных.Элементы);
		ИначеЕсли ТипЗнч(НаборДанных) = Тип("НаборДанныхЗапросМакетаКомпоновкиДанных") Тогда
			
			Если СтрНайти(НаборДанных.Запрос, "NULL ")
				Или СтрНайти(НаборДанных.Запрос, "НЕОПРЕДЕЛЕНО ") Тогда
				
				Схема = Новый СхемаЗапроса;
				Схема.УстановитьТекстЗапроса(НаборДанных.Запрос);
				Для Каждого ЗапросПакета Из Схема.ПакетЗапросов Цикл
					
					Если ТипЗнч(ЗапросПакета) = Тип("ЗапросВыбораСхемыЗапроса") Тогда
						
						Для Каждого ОператорПакета Из ЗапросПакета.Операторы Цикл
							
							ИндексыУдаляемыхОтборов = Новый Массив;
							Для Каждого УсловиеОтобора Из ОператорПакета.Отбор Цикл
								
								Если СтрНачинаетсяС(УсловиеОтобора, "NULL ")
									Или СтрНачинаетсяС(УсловиеОтобора, "НЕ NULL ")
									Или СтрНачинаетсяС(УсловиеОтобора, "НЕОПРЕДЕЛЕНО ")
									Или СтрНачинаетсяС(УсловиеОтобора, "НЕ НЕОПРЕДЕЛЕНО ") Тогда
									
									ИндексыУдаляемыхОтборов.Вставить(0, ОператорПакета.Отбор.Индекс(УсловиеОтобора));
									
								КонецЕсли;
								
							КонецЦикла;
							
							Для Каждого ИндексУдаляемогоОтбора Из ИндексыУдаляемыхОтборов Цикл
								ОператорПакета.Отбор.Удалить(ИндексУдаляемогоОтбора);
							КонецЦикла;
							
						КонецЦикла;
						
					КонецЕсли;
					
				КонецЦикла;
				
				НаборДанных.Запрос = Схема.ПолучитьТекстЗапроса();
				
			КонецЕсли;
			
		КонецЕсли;
		
	КонецЦикла;
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

// Возвращает список полей группировок всех группировок компоновщика настроек.
//
// Параметры: 
//		КомпоновщикНастроек - компоновщик настроек.
//		БезПользовательскихПолей - признак не включения пользовательских настроек СКД.
//
Функция ПолучитьПоляГруппировок(КомпоновщикНастроек, БезПользовательскихПолей = Ложь) Экспорт
	
	СписокПолей = Новый СписокЗначений;
	
	Структура = КомпоновщикНастроек.Настройки.Структура;
	ДобавитьПоляГруппировки(Структура, СписокПолей, БезПользовательскихПолей);
	Возврат СписокПолей;
	
КонецФункции

// Добавляет вложенные поля группировки.
Процедура ДобавитьПоляГруппировки(Структура, СписокПолей, БезПользовательскихПолей)
	
	Для каждого ЭлементСтруктуры Из Структура Цикл
		Если ТипЗнч(ЭлементСтруктуры) = Тип("ТаблицаКомпоновкиДанных") Тогда
			ДобавитьПоляГруппировки(ЭлементСтруктуры.Строки, СписокПолей, БезПользовательскихПолей);
			ДобавитьПоляГруппировки(ЭлементСтруктуры.Колонки, СписокПолей, БезПользовательскихПолей);
		ИначеЕсли ТипЗнч(ЭлементСтруктуры) = Тип("ДиаграммаКомпоновкиДанных") Тогда
			ДобавитьПоляГруппировки(ЭлементСтруктуры.Серии, СписокПолей, БезПользовательскихПолей);
			ДобавитьПоляГруппировки(ЭлементСтруктуры.Точки, СписокПолей, БезПользовательскихПолей);
		Иначе
			Для каждого ТекущееПолеГруппировки Из ЭлементСтруктуры.ПоляГруппировки.Элементы Цикл
				ДоступноеПоле = ЭлементСтруктуры.Выбор.ДоступныеПоляВыбора.НайтиПоле(ТекущееПолеГруппировки.Поле);
				Если ДоступноеПоле <> Неопределено 
				  И (ДоступноеПоле.Родитель = Неопределено ИЛИ Не БезПользовательскихПолей ИЛИ ДоступноеПоле.Родитель.Поле <> Новый ПолеКомпоновкиДанных("UserFields")) Тогда
					СписокПолей.Добавить(Строка(ДоступноеПоле.Поле), ДоступноеПоле.Заголовок);
				КонецЕсли;
			КонецЦикла;
			ДобавитьПоляГруппировки(ЭлементСтруктуры.Структура, СписокПолей, БезПользовательскихПолей);
		КонецЕсли;
	КонецЦикла;
	
КонецПроцедуры

// Возвращает последний элемент структуры - группировку.
//
// Параметры:
//		ЭлементСтруктурыНастроек - элемент структуры компоновки данных.
//		Строки - признак для получения последний группировки строк (Серий) или колонок (точек).
//
Функция ПолучитьПоследнийЭлементСтруктуры(ЭлементСтруктурыНастроек, Строки = Истина) Экспорт
	
	Если ТипЗнч(ЭлементСтруктурыНастроек) = Тип("КомпоновщикНастроекКомпоновкиДанных") Тогда
		Настройки = ЭлементСтруктурыНастроек.Настройки;
	ИначеЕсли ТипЗнч(ЭлементСтруктурыНастроек) = Тип("НастройкиКомпоновкиДанных") Тогда
		Настройки = ЭлементСтруктурыНастроек;
	Иначе
		Возврат Неопределено;
	КонецЕсли;
	
	Структура = Настройки.Структура;
	Если Структура.Количество() = 0 Тогда
		Возврат Настройки;
	КонецЕсли;
	
	Если Строки Тогда
		ИмяСтруктурыТаблицы = "Строки";
		ИмяСтруктурыДиаграммы = "Серии";
	Иначе
		ИмяСтруктурыТаблицы = "Колонки";
		ИмяСтруктурыДиаграммы = "Точки";
	КонецЕсли;
	
	Пока Истина Цикл
		ЭлементСтруктуры = Структура[0];
		Если ТипЗнч(ЭлементСтруктуры) = Тип("ТаблицаКомпоновкиДанных") И ЭлементСтруктуры[ИмяСтруктурыТаблицы].Количество() > 0 Тогда
			Если ЭлементСтруктуры[ИмяСтруктурыТаблицы][0].Структура.Количество() = 0 Тогда
				Структура = ЭлементСтруктуры[ИмяСтруктурыТаблицы];
				Прервать;
			КонецЕсли;
			Структура = ЭлементСтруктуры[ИмяСтруктурыТаблицы][0].Структура;
		ИначеЕсли ТипЗнч(ЭлементСтруктуры) = Тип("ДиаграммаКомпоновкиДанных") И ЭлементСтруктуры[ИмяСтруктурыДиаграммы].Количество() > 0 Тогда
			Если ЭлементСтруктуры[ИмяСтруктурыДиаграммы][0].Структура.Количество() = 0 Тогда
				Структура = ЭлементСтруктуры[ИмяСтруктурыДиаграммы];
				Прервать;
			КонецЕсли;
			Структура = ЭлементСтруктуры[ИмяСтруктурыДиаграммы][0].Структура;
		ИначеЕсли ТипЗнч(ЭлементСтруктуры) = Тип("ГруппировкаКомпоновкиДанных")
			  ИЛИ ТипЗнч(ЭлементСтруктуры) = Тип("ГруппировкаТаблицыКомпоновкиДанных")
			  ИЛИ ТипЗнч(ЭлементСтруктуры) = Тип("ГруппировкаДиаграммыКомпоновкиДанных") Тогда
			Если ЭлементСтруктуры.Структура.Количество() = 0 Тогда
				Прервать;
			КонецЕсли;
			Структура = ЭлементСтруктуры.Структура;
		ИначеЕсли ТипЗнч(ЭлементСтруктуры) = Тип("ТаблицаКомпоновкиДанных") Тогда
			Возврат ЭлементСтруктуры[ИмяСтруктурыТаблицы];
		ИначеЕсли ТипЗнч(ЭлементСтруктуры) = Тип("ДиаграммаКомпоновкиДанных")	Тогда
			Возврат ЭлементСтруктуры[ИмяСтруктурыДиаграммы];
		Иначе
			Возврат ЭлементСтруктуры;
		КонецЕсли;
	КонецЦикла;
	
	Возврат Структура[0];
	
КонецФункции

// Устарела. Следует использовать НайтиДоступнуюНастройку().
Функция ПолучитьДоступноеПоле(ДоступныеПоля, Поле) Экспорт
	
	Если ТипЗнч(Поле) = Тип("Строка") Тогда
		ПолеДоступа = Новый ПолеКомпоновкиДанных(Поле);
	ИначеЕсли ТипЗнч(Поле) = Тип("ПолеКомпоновкиДанных") Тогда
		ПолеДоступа = Поле;
	Иначе
		Возврат Неопределено;
	КонецЕсли;
	
	Возврат ДоступныеПоля.НайтиПоле(ПолеДоступа);
	
КонецФункции

Процедура КонтрольНастроекОтчетовПриЗаписиРассылкиОтчетов(Источник, Отказ) Экспорт
	// Вставить содержимое обработчика.
КонецПроцедуры

#КонецОбласти
