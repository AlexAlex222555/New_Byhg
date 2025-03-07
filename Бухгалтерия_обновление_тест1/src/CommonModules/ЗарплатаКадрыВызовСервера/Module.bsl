
#Область СлужебныйПрограммныйИнтерфейс

// Выполняет обработку данных при записи организации.
// Список обработок передается как массив строковых идентификаторов параметром СписокОбработок.
// Параметры:
//	Организация - ссылка на организацию.
//	СписокОбработок - список обработок.
//		Поддерживаются обработки:
Процедура ОбработкаДанныхПриЗаписиОрганизации(Организация, СписокОбработок) Экспорт
	
КонецПроцедуры

Функция ПроверитьАдрес(Знач Адрес, Знач ВидАдреса = Неопределено) Экспорт
	
	Возврат УправлениеКонтактнойИнформациейСлужебный.ПроверитьАдрес(Адрес, ВидАдреса);
	
КонецФункции

// Готовит данные выбора для справочников - классификаторов, упорядочивает по коду.
//
Процедура ПодготовитьДанныеВыбораКлассификаторовСПорядкомКодов(ДанныеВыбора, Параметры, СтандартнаяОбработка, ПолноеИмяОбъектаМетаданных) Экспорт
	
	Запрос = Новый Запрос;
	
	ДанныеВыбора = Новый СписокЗначений;
	
	Запрос.Текст =
		"ВЫБРАТЬ РАЗРЕШЕННЫЕ ПЕРВЫЕ 51
		|	СписокСправочника.Ссылка,
		|	СписокСправочника.Код КАК Код,
		|	СписокСправочника.Наименование,
		|	ИСТИНА КАК НайденПоКоду
		|ИЗ
		|	&СписокСправочника КАК СписокСправочника
		|ГДЕ &ТекстУсловийОтбораПоКодам
		|
		|ОБЪЕДИНИТЬ ВСЕ
		|
		|ВЫБРАТЬ
		|	СписокСправочника.Ссылка,
		|	СписокСправочника.Код,
		|	СписокСправочника.Наименование,
		|	ЛОЖЬ
		|ИЗ
		|	&СписокСправочника КАК СписокСправочника
		|ГДЕ &ТекстУсловийОтбораПоНаименованиям
		|
		|УПОРЯДОЧИТЬ ПО
		|	Код";
		
	Запрос.Текст = СтрЗаменить(Запрос.Текст, "&СписокСправочника", ПолноеИмяОбъектаМетаданных);
	
	УстановитьОтборВЗапросеПоПараметрам(Запрос, Параметры);
		
	Выборка = Запрос.Выполнить().Выбрать();
		
	Пока Выборка.Следующий() Цикл
		
		Если ДанныеВыбора.НайтиПоЗначению(Выборка.Ссылка) = Неопределено Тогда
			
			Если Выборка.НайденПоКоду Тогда
				Представление = СокрЛП(Выборка.Код) + " (" + Выборка.Наименование + ")";
			Иначе
				Представление = Выборка.Наименование + " (" + СокрЛП(Выборка.Код) + ")";
			КонецЕсли;
			
			ДанныеВыбора.Добавить(Выборка.Ссылка, Представление);
			
		КонецЕсли; 
		
	КонецЦикла;
		
	СтандартнаяОбработка = Ложь;
	
КонецПроцедуры

Процедура ПодготовитьДанныеВыбораКлассификаторовСПорядкомРеквизитаДопУпорядочивания(ДанныеВыбора, Параметры, СтандартнаяОбработка, ПолноеИмяОбъектаМетаданных) Экспорт
	
	Запрос = Новый Запрос;
	
	ДанныеВыбора = Новый СписокЗначений;
	
	Запрос.Текст =
		"ВЫБРАТЬ
		|	СписокСправочника.Ссылка
		|ИЗ
		|	&СписокСправочника КАК СписокСправочника
		|ГДЕ &ТекстУсловийОтбораПоНаименованиям
		|
		|УПОРЯДОЧИТЬ ПО
		|	СписокСправочника.РеквизитДопУпорядочивания";
	
	Запрос.Текст = СтрЗаменить(Запрос.Текст, "&СписокСправочника", ПолноеИмяОбъектаМетаданных);
	
	УстановитьОтборВЗапросеПоПараметрам(Запрос, Параметры);
		
	Выборка = Запрос.Выполнить().Выбрать();
	Пока Выборка.Следующий() Цикл
		ДанныеВыбора.Добавить(Выборка.Ссылка);
	КонецЦикла;
	
КонецПроцедуры

// Возвращает данные присоединенного к объекту файла.
//
// Параметры:	
//		СсылкаНаОбъект - ссылка на объект - владелец файла.
//		УникальныйИдентификатор - необязательный. Уникальный идентификатор формы, передается в том случае,
//				   если данные файла нужно поместить во временное хранилище формы.
//  ПолучатьСсылкуНаДвоичныеДанные - Булево - начальное значение Истина,
//                 если передать Ложь, то ссылка на двоичные данные не будет получена,
//                 что существенно ускорит выполнение для больших двоичных данных.
//
//	Возвращаемое значение:
//		см. ПрисоединенныеФайлы.ПолучитьДанныеФайла	
//		
Функция ПолучитьДанныеФайла(СсылкаНаОбъект, УникальныйИдентификатор = Неопределено, ПолучатьСсылкуНаДвоичныеДанные = Истина) Экспорт
	Возврат ЗарплатаКадры.ПолучитьДанныеФайла(СсылкаНаОбъект, УникальныйИдентификатор, ПолучатьСсылкуНаДвоичныеДанные);	
КонецФункции

Функция ПолучитьОписаниеДокументаОтчетности(Ссылка, Отказ) Экспорт
	Возврат Неопределено;
КонецФункции 

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

Функция ВосстановитьНачальныеЗначения(ИменаОбъектовМетаданных, ИдентификаторФормы) Экспорт
	
	ПараметрыЗадания = Новый Структура;
	ПараметрыЗадания.Вставить("ИменаОбъектовМетаданных", ИменаОбъектовМетаданных);
	
	Результат = ДлительныеОперации.ЗапуститьВыполнениеВФоне(
		ИдентификаторФормы, "ЗарплатаКадры.УстановитьНачальныеЗначения", ПараметрыЗадания, НСтр("ru='Установка начальных значений';uk='Встановлення початкових значень'"));
		
	Возврат Результат;
	
КонецФункции

Процедура ИсключитьПовторениеЗаписейТекущихДанныхСотрудников(ИмяРегистраТекущихСведений) Экспорт
	
	КадровыйУчет.ИсключитьПовторениеЗаписейТекущихДанныхСотрудников(ИмяРегистраТекущихСведений);
	
КонецПроцедуры

Функция ЗаданиеВыполнено(ИдентификаторЗадания) Экспорт
	Возврат ДлительныеОперации.ЗаданиеВыполнено(ИдентификаторЗадания);
КонецФункции

Процедура УстановитьОтборВЗапросеПоПараметрам(Запрос, Параметры)
	
	ТекстУсловийОтбора = "";
	
	Если Параметры.Отбор.Количество() > 0 Тогда
		
		Для каждого ЭлементОтбора Из Параметры.Отбор Цикл
			
			Если ТипЗнч(ЭлементОтбора.Значение) = Тип("ФиксированныйМассив") Тогда
				
				УсловиеСПравымЗначением = " В (&Отбор" + ЭлементОтбора.Ключ + ")";
				
			Иначе
				
				УсловиеСПравымЗначением = " = (&Отбор" + ЭлементОтбора.Ключ + ")";
				
			КонецЕсли; 
			
			ТекстУсловийОтбора = ?(ПустаяСтрока(ТекстУсловийОтбора), "", ТекстУсловийОтбора + Символы.ПС + " И ")
				+ "СписокСправочника." + ЭлементОтбора.Ключ + УсловиеСПравымЗначением;
				
			Запрос.УстановитьПараметр("Отбор" + ЭлементОтбора.Ключ, ЭлементОтбора.Значение);
			
		КонецЦикла;
		
	КонецЕсли;
	
	Если НЕ ПустаяСтрока(Параметры.СтрокаПоиска) Тогда
		
		ТекстУсловийОтбораПоКоду = "СписокСправочника.Код ПОДОБНО &СтрокаПоиска";
		ТекстУсловийОтбораПоНаименованию = "СписокСправочника.Наименование ПОДОБНО &СтрокаПоиска";
		
		Запрос.УстановитьПараметр("СтрокаПоиска", Параметры.СтрокаПоиска + "%");
		
	Иначе
		
		ТекстУсловийОтбораПоКоду = "";
		ТекстУсловийОтбораПоНаименованию = "";
		
	КонецЕсли;
	
	Если НЕ ПустаяСтрока(ТекстУсловийОтбора) Тогда
		
		ТекстУсловийОтбораПоКоду = ?(ПустаяСтрока(ТекстУсловийОтбораПоКоду), "", ТекстУсловийОтбораПоКоду + Символы.ПС + " И ") + ТекстУсловийОтбора;
		ТекстУсловийОтбораПоНаименованию = ?(ПустаяСтрока(ТекстУсловийОтбораПоНаименованию), "", ТекстУсловийОтбораПоНаименованию + Символы.ПС + " И ") + ТекстУсловийОтбора;
		
	КонецЕсли; 
	
	Если НЕ ПустаяСтрока(ТекстУсловийОтбораПоКоду) Тогда
		
		ТекстУсловийОтбораПоКоду = "ГДЕ
			|	" + ТекстУсловийОтбораПоКоду;
			
		ТекстУсловийОтбораПоНаименованию = "ГДЕ
			|	" + ТекстУсловийОтбораПоНаименованию;
			
	КонецЕсли; 
	
	Запрос.Текст = СтрЗаменить(Запрос.Текст, "ГДЕ &ТекстУсловийОтбораПоКодам", ТекстУсловийОтбораПоКоду);
	Запрос.Текст = СтрЗаменить(Запрос.Текст, "ГДЕ &ТекстУсловийОтбораПоНаименованиям", ТекстУсловийОтбораПоНаименованию);
	
КонецПроцедуры

// Возвращает значения заполнения, передаваемые при создании нового документа из формы списка журнала
// см. описание ЗарплатаКадры.ДинамическийСписокПередНачаломДобавления
//
Процедура ДинамическийСписокПередНачаломДобавления(ПараметрыОткрытия, ФизическоеЛицо, ОрганизацияОтбора, ТипДокумента, ИмяПоляСотрудник = "Сотрудник", ИмяПоляФизическоеЛицо = "ФизическоеЛицо") Экспорт
	ЗарплатаКадры.ДинамическийСписокПередНачаломДобавления(ПараметрыОткрытия, ФизическоеЛицо, ОрганизацияОтбора, ТипДокумента, ИмяПоляСотрудник, ИмяПоляФизическоеЛицо);
КонецПроцедуры

#КонецОбласти
