#Область СлужебныеПроцедурыИФункции

// Возвращает таблицу значений с колонками Сотрудник и Группа, содержащую
// сотрудников и группы в которые сотрудники относится
//
// Параметры:
//		Сотрудники					- Массив, ссылок на элементы справочника сотрудники
//									- СправочникСсылка.Сотрудники
//		ОбрабатыватьГруппыПоиска	- Булево, позволяет исключить из обработки
//										группы поиска
//
// Возвращаемое значение;
//		ТаблицаЗначений
//			* Сотрудник			- СправочникСсылка.Сотрудники
//			* ФизическоеЛицо	- СправочникСсылка.ФизическиеЛица
//			* Группа			- СправочникСсылка.ГруппыСотрудников
//
Функция ГруппыСотрудников(Сотрудники, ОбрабатыватьГруппыПоиска = Истина) Экспорт
	
	Если ТипЗнч(Сотрудники) = Тип("СправочникСсылка.Сотрудники") Тогда
		СписокСотрудников = ОбщегоНазначенияКлиентСервер.ЗначениеВМассиве(Сотрудники);
	Иначе
		СписокСотрудников = Сотрудники;
	КонецЕсли;
	
	Возврат ТаблицаГруппСотрудников(СписокСотрудников, Истина, ОбрабатыватьГруппыПоиска);
	
КонецФункции

// Возвращает таблицу значений с колонками Сотрудник, физическоеЛицо
//
// Параметры:
//		ФизическиеЛица				- Массив, ссылок на элементы справочника сотрудники
//									- СправочникСсылка.ФизическиеЛица
//		ОбрабатыватьГруппыПоиска	- Булево, позволяет исключить из обработки
//										группы поиска
//
// Возвращаемое значение;
//		ТаблицаЗначений
//			* Сотрудник			- СправочникСсылка.Сотрудники
//			* ФизическоеЛицо	- СправочникСсылка.ФизическиеЛица
//			* Группа			- СправочникСсылка.ГруппыСотрудников
//
Функция ГруппыСотрудниковФизическихЛиц(ФизическиеЛица, ОбрабатыватьГруппыПоиска = Истина) Экспорт
	
	Если ТипЗнч(ФизическиеЛица) = Тип("СправочникСсылка.ФизическиеЛица") Тогда
		СписокФизическихЛиц = ОбщегоНазначенияКлиентСервер.ЗначениеВМассиве(ФизическиеЛица);
	Иначе
		СписокФизическихЛиц = ФизическиеЛица;
	КонецЕсли;
	
	Возврат ТаблицаГруппСотрудников(СписокФизическихЛиц, Ложь, ОбрабатыватьГруппыПоиска);
	
КонецФункции

// Возвращает сотрудников, соответствующих критериям поиска
//
// Параметры:
//		НастройкиЗаполнения - настройки СКД отчета по сотрудникам
//
//		ТаблицаЗначений
//			* Сотрудник			- СправочникСсылка.Сотрудники
//			* ФизическоеЛицо	- СправочникСсылка.ФизическиеЛица
//
Функция СотрудникиГруппыПоискаПоНастройкам(НастройкиЗаполнения) Экспорт
	
	Если НастройкиЗаполнения = Неопределено Тогда
		
		ТаблицаРезультата = Новый ТаблицаЗначений;
		ТаблицаРезультата.Колонки.Добавить("Сотрудник", Новый ОписаниеТипов("СправочникСсылка.Сотрудники"));
		ТаблицаРезультата.Колонки.Добавить("ФизическоеЛицо", Новый ОписаниеТипов("СправочникСсылка.ФизическиеЛица"));
		
	Иначе
		
		ОтчетОбъект = Отчеты.ОтчетыПоСотрудникам.Создать();
		ОтчетОбъект.ИнициализироватьОтчет();
		
		КомпоновщикМакета = Новый КомпоновщикМакетаКомпоновкиДанных;
		МакетКомпоновки = КомпоновщикМакета.Выполнить(
			ОтчетОбъект.СхемаКомпоновкиДанных, НастройкиЗаполнения, , , Тип("ГенераторМакетаКомпоновкиДанныхДляКоллекцииЗначений"));
		
		ПроцессорКомпоновки = Новый ПроцессорКомпоновкиДанных;
		ПроцессорКомпоновки.Инициализировать(МакетКомпоновки, , , Истина);
		
		ПроцессорВывода = Новый ПроцессорВыводаРезультатаКомпоновкиДанныхВКоллекциюЗначений;
		ТаблицаРезультата = ПроцессорВывода.Вывести(ПроцессорКомпоновки);
		
		ТаблицаРезультата.Колонки.РабочееМестоСотрудник.Имя = "Сотрудник";
		Если ТаблицаРезультата.Колонки.Найти("ЛичныеДанныеФизическоеЛицо") <> Неопределено Тогда
			ТаблицаРезультата.Колонки.ЛичныеДанныеФизическоеЛицо.Имя = "ФизическоеЛицо";
		КонецЕсли; 
		
	КонецЕсли;
	
	Возврат ТаблицаРезультата;
		
КонецФункции

// Возвращает сотрудников группы поиска
//
// Параметры:
//		ГруппаПоиска - СправочникСсылка.ГруппыСотрудников
//
// Возвращаемое значение:
//		ТаблицаЗначений
//			* Сотрудник			- СправочникСсылка.Сотрудники
//			* ФизическоеЛицо	- СправочникСсылка.ФизическиеЛица
//		Неопределено, если настройки не заданы
//
Функция СотрудникиГруппыПоиска(ГруппаПоиска) Экспорт
	
	НастройкиЗаполнения = ОбщегоНазначения.ЗначениеРеквизитаОбъекта(ГруппаПоиска, "ХранилищеНастроек");
	Если НастройкиЗаполнения = Неопределено Тогда
		Возврат Неопределено;
	КонецЕсли;
	
	Возврат СотрудникиГруппыПоискаПоНастройкам(НастройкиЗаполнения.Получить());
	
КонецФункции

// Возвращает список сотрудников входящих в состав одной из групп, переданных в параметрах
//
// Параметры:
//		ГруппыСотрудников					- Массив ссылок на группы сотрудников
//											- СправочникСсылка.ГруппыСотрудников
//		ДополнятьСоставомПодчиненныхГрупп	- Булево
//
// Возвращаемое значение:
//		ТаблицаЗначений
//			* Сотрудник			- СправочникСсылка.Сотрудники
//			* ФизическоеЛицо	- СправочникСсылка.ФизическиеЛица
//			* Группа			- СправочникСсылка.ГруппыСотрудников
//
Функция СоставГруппСотрудников(СписокГруппСотрудников, ДополнятьСоставомПодчиненныхГрупп = Истина) Экспорт
	
	Если ТипЗнч(СписокГруппСотрудников) = Тип("СправочникСсылка.ГруппыСотрудников") Тогда
		СписокГрупп = ОбщегоНазначенияКлиентСервер.ЗначениеВМассиве(СписокГруппСотрудников);
	Иначе
		СписокГрупп = СписокГруппСотрудников;
	КонецЕсли;
	
	РеквизитыФормироватьАвтоматически = ОбщегоНазначения.ЗначениеРеквизитаОбъектов(СписокГрупп, "ФормироватьАвтоматически");
	
	СписокГруппФормироватьАвтоматически = Новый Массив;
	СписокГруппСПостояннымСоставом = Новый Массив;
	
	Для каждого ГруппаСРеквизитом Из РеквизитыФормироватьАвтоматически Цикл
		Если ГруппаСРеквизитом.Значение Тогда
			СписокГруппФормироватьАвтоматически.Добавить(ГруппаСРеквизитом.Ключ);
		Иначе
			СписокГруппСПостояннымСоставом.Добавить(ГруппаСРеквизитом.Ключ);
		КонецЕсли;
	КонецЦикла;
	
	ТаблицаГруппСотрудников = Новый ТаблицаЗначений;
	ТаблицаГруппСотрудников.Колонки.Добавить("Сотрудник", Новый ОписаниеТипов("СправочникСсылка.Сотрудники"));
	ТаблицаГруппСотрудников.Колонки.Добавить("ФизическоеЛицо", Новый ОписаниеТипов("СправочникСсылка.ФизическиеЛица"));
	ТаблицаГруппСотрудников.Колонки.Добавить("Группа", Новый ОписаниеТипов("СправочникСсылка.ГруппыСотрудников"));
	
	Если СписокГруппСПостояннымСоставом.Количество() > 0 Тогда
		
		Для каждого Группа Из СписокГруппСПостояннымСоставом Цикл
			
			Запрос = Новый Запрос;
			Запрос.УстановитьПараметр("ГруппаСотрудников", Группа);
			
			Запрос.Текст =
				"ВЫБРАТЬ РАЗРЕШЕННЫЕ
				|	СоставГруппСотрудников.Сотрудник,
				|	СоставГруппСотрудников.Сотрудник.ФизическоеЛицо КАК ФизическоеЛицо,
				|	СоставГруппСотрудников.ГруппаСотрудников КАК Группа
				|ИЗ
				|	РегистрСведений.СоставГруппСотрудников КАК СоставГруппСотрудников
				|ГДЕ
				|	СоставГруппСотрудников.ГруппаСотрудников В ИЕРАРХИИ(&ГруппаСотрудников)";
				
			Если Не ДополнятьСоставомПодчиненныхГрупп Тогда
				Запрос.Текст = СтрЗаменить(Запрос.Текст, "ИЕРАРХИИ", "");
			КонецЕсли; 
				
			Выборка = Запрос.Выполнить().Выбрать();
			Пока Выборка.Следующий() Цикл
				
				НоваяСтрокаТаблицы = ТаблицаГруппСотрудников.Добавить();
				НоваяСтрокаТаблицы.Сотрудник = Выборка.Сотрудник;
				НоваяСтрокаТаблицы.ФизическоеЛицо = Выборка.ФизическоеЛицо;
				НоваяСтрокаТаблицы.Группа = Группа;
				
			КонецЦикла; 
				
		КонецЦикла;
		
	КонецЕсли; 
	
	Если СписокГруппФормироватьАвтоматически.Количество() > 0 Тогда
		
		Для каждого Группа Из СписокГруппФормироватьАвтоматически Цикл
			
			СотрудникиГруппы = СотрудникиГруппыПоиска(Группа);
			ЕстьКолонкаФизическоеЛицо = СотрудникиГруппы.Колонки.Найти("ФизическоеЛицо") <> Неопределено;
			
			Если Не ЕстьКолонкаФизическоеЛицо Тогда
				ФизическиеЛицаСотрудников = ОбщегоНазначения.ЗначениеРеквизитаОбъектов(СотрудникиГруппы.ВыгрузитьКолонку("Сотрудник"), "ФизическоеЛицо");
			КонецЕсли; 
			
			Для каждого СотрудникГруппы Из СотрудникиГруппы Цикл
				
				НоваяСтрокаТаблицы = ТаблицаГруппСотрудников.Добавить();
				НоваяСтрокаТаблицы.Сотрудник = СотрудникГруппы.Сотрудник;
				Если ЕстьКолонкаФизическоеЛицо Тогда
					НоваяСтрокаТаблицы.ФизическоеЛицо = СотрудникГруппы.ФизическоеЛицо;
				Иначе
					НоваяСтрокаТаблицы.ФизическоеЛицо = ФизическиеЛицаСотрудников.Получить(НоваяСтрокаТаблицы.Сотрудник);
				КонецЕсли;
				
				НоваяСтрокаТаблицы.Группа = Группа;
				
			КонецЦикла;
			
		КонецЦикла;
		
	КонецЕсли; 
	
	Возврат ТаблицаГруппСотрудников;
	
КонецФункции

// Создает в менеджере временных таблиц временную таблицу содержащую поля Сотрудник, ФизическоеЛицо, Группа
//
// Параметры:
//		МенеджерВременныхТаблиц		- МенеджерВременныхТаблиц
//		Сотрудники					- Массив сотрудников
//										СправочникСсылка.Сотрудники
//		ОбрабатыватьГруппыПоиска	- Булево
//		ИмяВТГруппыСотрудников		- Строка
//
// Возвращаемое значение:
//		РезультатЗапроса
//
Функция СоздатьВТГруппыСотрудников(МенеджерВременныхТаблиц, Сотрудники, ОбрабатыватьГруппыПоиска = Истина, ИмяВТГруппыСотрудников = "ВТГруппыСотрудников") Экспорт
	
	Запрос = Новый Запрос;
	Запрос.МенеджерВременныхТаблиц = МенеджерВременныхТаблиц;
	
	Запрос.УстановитьПараметр("ГруппыСотрудников", ГруппыСотрудников(Сотрудники, ОбрабатыватьГруппыПоиска));
	
	Запрос.Текст =
		"ВЫБРАТЬ
		|	ГруппыСотрудников.Сотрудник,
		|	ГруппыСотрудников.ФизическоеЛицо,
		|	ГруппыСотрудников.Группа
		|ПОМЕСТИТЬ ВТГруппыСотрудников
		|ИЗ
		|	&ГруппыСотрудников КАК ГруппыСотрудников";
		
	ЗарплатаКадрыОбщиеНаборыДанных.ЗаменитьИмяСоздаваемойВременнойТаблицы(Запрос.Текст, "ВТГруппыСотрудников", ИмяВТГруппыСотрудников);
		
	Возврат Запрос.Выполнить();
	
КонецФункции

// Создает в менеджере временных таблиц временную таблицу содержащую поля Сотрудник, ФизическоеЛицо, Группа
//
// Параметры:
//		МенеджерВременныхТаблиц				- МенеджерВременныхТаблиц
//		ФизическиеЛица						- Массив сотрудников
//												СправочникСсылка.ФизическиеЛица
//		ОбрабатыватьГруппыПоиска			- Булево
//		ИмяВТГруппыСотрудниковФизическихЛиц	- Строка
//
// Возвращаемое значение:
//		РезультатЗапроса
//
Функция СоздатьВТГруппыСотрудниковФизическихЛиц(МенеджерВременныхТаблиц, ФизическиеЛица, ОбрабатыватьГруппыПоиска = Истина, ИмяВТГруппыСотрудниковФизическихЛиц = "ВТГруппыСотрудниковФизическихЛиц") Экспорт
	
	Запрос = Новый Запрос;
	Запрос.МенеджерВременныхТаблиц = МенеджерВременныхТаблиц;
	
	Запрос.УстановитьПараметр("ГруппыСотрудников", ГруппыСотрудниковФизическихЛиц(ФизическиеЛица, ОбрабатыватьГруппыПоиска));
	
	Запрос.Текст =
		"ВЫБРАТЬ
		|	ГруппыСотрудников.Сотрудник,
		|	ГруппыСотрудников.ФизическоеЛицо,
		|	ГруппыСотрудников.Группа
		|ПОМЕСТИТЬ ВТГруппыСотрудниковФизическихЛиц
		|ИЗ
		|	&ГруппыСотрудников КАК ГруппыСотрудников";
		
	ЗарплатаКадрыОбщиеНаборыДанных.ЗаменитьИмяСоздаваемойВременнойТаблицы(Запрос.Текст, "ВТГруппыСотрудниковФизическихЛиц", ИмяВТГруппыСотрудниковФизическихЛиц);
		
	Возврат Запрос.Выполнить();
	
КонецФункции

Функция ТаблицаГруппСотрудников(СписокСотрудников, ПоСправочникуСотрудники, ОбрабатыватьГруппыПоиска)
	
	ТаблицаГруппСотрудников = Новый ТаблицаЗначений;
	ТаблицаГруппСотрудников.Колонки.Добавить("Сотрудник", Новый ОписаниеТипов("СправочникСсылка.Сотрудники"));
	ТаблицаГруппСотрудников.Колонки.Добавить("ФизическоеЛицо", Новый ОписаниеТипов("СправочникСсылка.ФизическиеЛица"));
	ТаблицаГруппСотрудников.Колонки.Добавить("Группа", Новый ОписаниеТипов("СправочникСсылка.ГруппыСотрудников"));
	
	Если ОбрабатыватьГруппыПоиска Тогда
		
		Запрос = Новый Запрос;
		Запрос.Текст =
			"ВЫБРАТЬ РАЗРЕШЕННЫЕ
			|	ГруппыСотрудников.Ссылка
			|ИЗ
			|	Справочник.ГруппыСотрудников КАК ГруппыСотрудников
			|ГДЕ
			|	ГруппыСотрудников.ФормироватьАвтоматически
			|
			|УПОРЯДОЧИТЬ ПО
			|	ГруппыСотрудников.ФормироватьАвтоматически,
			|	ГруппыСотрудников.Наименование";
			
		Выборка = Запрос.Выполнить().Выбрать();
		Пока Выборка.Следующий() Цикл
			
			СотрудникиГруппы = СотрудникиГруппыПоиска(Выборка.Ссылка);
			Если СотрудникиГруппы <> Неопределено Тогда
				
				Если СотрудникиГруппы.Колонки.Найти("ФизическоеЛицо") = Неопределено Тогда
					ЕстьКолонкаФизическоеЛицо = Ложь;
					ФизическиеЛицаСотрудников = ОбщегоНазначения.ЗначениеРеквизитаОбъектов(СотрудникиГруппы.ВыгрузитьКолонку("Сотрудник"), "ФизическоеЛицо");
				Иначе
					ЕстьКолонкаФизическоеЛицо = Истина;
				КонецЕсли;
			
				Для каждого СотрудникГруппы Из СотрудникиГруппы Цикл
					
					Если ЕстьКолонкаФизическоеЛицо Тогда
						ФизическоеЛицо = СотрудникГруппы.ФизическоеЛицо;
					Иначе
						ФизическоеЛицо = ФизическиеЛицаСотрудников.Получить(СотрудникГруппы.Сотрудник);
					КонецЕсли;
					
					Если ПоСправочникуСотрудники Тогда
						Если СписокСотрудников.Найти(СотрудникГруппы.Сотрудник) = Неопределено Тогда
							Продолжить;
						КонецЕсли; 
					Иначе
						Если СписокСотрудников.Найти(ФизическоеЛицо) = Неопределено Тогда
							Продолжить;
						КонецЕсли; 
					КонецЕсли;
					
					НоваяСтрокаТаблицы = ТаблицаГруппСотрудников.Добавить();
					НоваяСтрокаТаблицы.Сотрудник = СотрудникГруппы.Сотрудник;
					НоваяСтрокаТаблицы.ФизическоеЛицо = ФизическоеЛицо;
					НоваяСтрокаТаблицы.Группа = Выборка.Ссылка;
					
				КонецЦикла;
				
			КонецЕсли; 
			
		КонецЦикла;
		
	КонецЕсли; 
	
	Запрос = Новый Запрос;
	Запрос.УстановитьПараметр("СписокСотрудников", СписокСотрудников);
	
	Запрос.Текст =
		"ВЫБРАТЬ РАЗРЕШЕННЫЕ
		|	СоставГруппСотрудников.Сотрудник КАК Сотрудник,
		|	ВЫРАЗИТЬ(СоставГруппСотрудников.Сотрудник КАК Справочник.Сотрудники).ФизическоеЛицо КАК ФизическоеЛицо,
		|	СоставГруппСотрудников.ГруппаСотрудников
		|ИЗ
		|	РегистрСведений.СоставГруппСотрудников КАК СоставГруппСотрудников
		|ГДЕ
		|	СоставГруппСотрудников.Сотрудник В(&СписокСотрудников)
		|
		|УПОРЯДОЧИТЬ ПО
		|	Сотрудник,
		|	СоставГруппСотрудников.ГруппаСотрудников.ФормироватьАвтоматически,
		|	СоставГруппСотрудников.ГруппаСотрудников.Наименование";
		
	Если Не ПоСправочникуСотрудники Тогда
		Запрос.Текст = СтрЗаменить(Запрос.Текст, "СоставГруппСотрудников.Сотрудник В(&СписокСотрудников)", "ВЫРАЗИТЬ(СоставГруппСотрудников.Сотрудник КАК Справочник.Сотрудники).ФизическоеЛицо В(&СписокСотрудников)");
	КонецЕсли; 
		
	Выборка = Запрос.Выполнить().Выбрать();
	Пока Выборка.Следующий() Цикл
		
		НоваяСтрокаТаблицы = ТаблицаГруппСотрудников.Добавить();
		НоваяСтрокаТаблицы.Сотрудник = Выборка.Сотрудник;
		НоваяСтрокаТаблицы.ФизическоеЛицо = Выборка.ФизическоеЛицо;
		НоваяСтрокаТаблицы.Группа = Выборка.ГруппаСотрудников;
		
	КонецЦикла; 
	
	Возврат ТаблицаГруппСотрудников;
	
КонецФункции

#КонецОбласти