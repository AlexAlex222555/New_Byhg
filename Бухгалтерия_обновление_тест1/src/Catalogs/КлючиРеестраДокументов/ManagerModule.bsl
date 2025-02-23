#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ПрограммныйИнтерфейс

// Соотвествие со списком реквизитов, по которым определяется уникальность ключа
// 
// Возвращаемое значение:
//   Соответствие - ключ - имя реквизита 
//
Функция КлючевыеРеквизиты() Экспорт
	
	Результат = Новый Соответствие;
	Результат.Вставить("Ключ");
	
	Возврат Результат;
	
КонецФункции

// Вычисляет какие ключи реестра нужно создать (обновить) и обновляет их
//
// Параметры:
//  ОбъектыМетаданных			 - Соответствие	 - объекты метаданных:
//  	* Ключ		- ОбъектМетаданныхДокумент	 - объект метаданных документа.
//  	* Значение	- Неопределено					- пустое значение.
//  ЭлементДляОбновленияКлюча	 - ЛюбаяСсылка - ссылка на элемент справочника, по которой нужно создать или обновить ключ
//                                               если параметр передан, то первый параметр игнорируется
//
Процедура СоздатьОбновитьКлючиРеестра(ОбъектыМетаданных = Неопределено, ЭлементДляОбновленияКлюча = Неопределено) Экспорт
	
	Если ЭлементДляОбновленияКлюча <> Неопределено Тогда
		
		ОбъектыМетаданных = Новый Соответствие;
		ОбъектыМетаданных.Вставить(Метаданные.НайтиПоТипу(ТипЗнч(ЭлементДляОбновленияКлюча)));
		
	ИначеЕсли ОбъектыМетаданных = Неопределено Тогда
		
		ОбъектыМетаданных = ОбъектыМетаданныхЗакешированныеВКлючахРеестра();
		
	КонецЕсли;
		
	УстановитьПривилегированныйРежим(Истина);
		
	ЕстьКлючиДляГенерации = Истина;
	
	Пока ЕстьКлючиДляГенерации Цикл
		
		ТаблицаКлючей = КлючиРеестраДляОбновления(ОбъектыМетаданных, Истина, ,ЭлементДляОбновленияКлюча);
		
		ЕстьКлючиДляГенерации = ТаблицаКлючей.Количество() > 0; 
		
		Если Не ЕстьКлючиДляГенерации Тогда
			Возврат;
		КонецЕсли;
	
		НачатьТранзакцию();
		
		Попытка
			
			Если Не МонопольныйРежим() Тогда
				// При работе в немонопольном режиме нужно гарантировать, что по
				// ключам в параллельном сеансе не были изменены ключи.
				
				Блокировка = Новый БлокировкаДанных;
				
				ЭлементБлокировки = Блокировка.Добавить("Справочник.КлючиРеестраДокументов");
				ЭлементБлокировки.ИсточникДанных = ТаблицаКлючей;
				ЭлементБлокировки.ИспользоватьИзИсточникаДанных("Ключ", "Ключ");
				ЭлементБлокировки.Режим = РежимБлокировкиДанных.Исключительный;
				
				Блокировка.Заблокировать();
				
			КонецЕсли;
			
			Запрос = Новый Запрос;
			Запрос.Текст = 
			"ВЫБРАТЬ
			|	ТаблицаКлючей.Ключ КАК Ключ,
			|	ТаблицаКлючей.Организация КАК Организация,
            |	ТаблицаКлючей.КодПоЕДРПОУ КАК КодПоЕДРПОУ,
			|	ТаблицаКлючей.Наименование КАК Наименование
			|ПОМЕСТИТЬ ТаблицаКлючей
			|ИЗ
			|	&ТаблицаКлючей КАК ТаблицаКлючей
			|;
			|
			|////////////////////////////////////////////////////////////////////////////////
			|ВЫБРАТЬ
			|	ТаблицаКлючей.Ключ КАК Ключ,
			|	ТаблицаКлючей.Организация КАК Организация,
            |	ТаблицаКлючей.КодПоЕДРПОУ КАК КодПоЕДРПОУ,
			|	ТаблицаКлючей.Наименование КАК Наименование,
			|	ЕСТЬNULL(КлючиРеестраДокументов.Ссылка, ЗНАЧЕНИЕ(Справочник.КлючиРеестраДокументов.ПустаяСсылка)) КАК Ссылка
			|ИЗ
			|	ТаблицаКлючей КАК ТаблицаКлючей
			|		ЛЕВОЕ СОЕДИНЕНИЕ Справочник.КлючиРеестраДокументов КАК КлючиРеестраДокументов
			|		ПО ТаблицаКлючей.Ключ = КлючиРеестраДокументов.Ключ
			|ГДЕ
			|	(КлючиРеестраДокументов.Ссылка ЕСТЬ NULL
			|			ИЛИ ТаблицаКлючей.Организация <> КлючиРеестраДокументов.Организация
            |			ИЛИ ТаблицаКлючей.КодПоЕДРПОУ <> КлючиРеестраДокументов.КодПоЕДРПОУ
			|			ИЛИ ТаблицаКлючей.Наименование <> КлючиРеестраДокументов.Наименование)";
			
			Запрос.УстановитьПараметр("ТаблицаКлючей", ТаблицаКлючей);
			
			ВыборкаСсылок = Запрос.Выполнить().Выбрать();
			
			Пока ВыборкаСсылок.Следующий() Цикл
				
				Если ЗначениеЗаполнено(ВыборкаСсылок.Ссылка) Тогда
					КлючОбъект = ВыборкаСсылок.Ссылка.ПолучитьОбъект();
				Иначе
					КлючОбъект = Справочники.КлючиРеестраДокументов.СоздатьЭлемент();
				КонецЕсли;
				
				ЗаполнитьЗначенияСвойств(КлючОбъект, ВыборкаСсылок);
				КлючОбъект.Записать();
			КонецЦикла;
			
			ЗафиксироватьТранзакцию();
			
		Исключение
			ОтменитьТранзакцию();
			ТекстСообщения = НСтр("ru='Не удалось обработать ключи реестра документов: %Причина%';uk='Не вдалося обробити ключі реєстру документів: %Причина%'");
			ТекстСообщения = СтрЗаменить(ТекстСообщения, "%Причина%", ПодробноеПредставлениеОшибки(ИнформацияОбОшибке()));
			ЗаписьЖурналаРегистрации(НСтр("ru='Создание ключей аналитики реестра документов';uk='Створення ключів аналітики реєстру документів'",ОбщегоНазначенияКлиентСервер.КодОсновногоЯзыка()),
				УровеньЖурналаРегистрации.Ошибка,
				Метаданные.Справочники.КлючиРеестраДокументов,
				,
				ТекстСообщения);
		
			ВызватьИсключение;
		КонецПопытки;
		
	КонецЦикла;
	
	УстановитьПривилегированныйРежим(Ложь);
	
КонецПроцедуры

// Возвращает признак, того элемент справочника входит в ключи реестра документов,
// поэтому по нему нужно создавать или обновлять элемент технологического справочника.
//
// Параметры:
//	Объект - Произвольный - объект базы данных, например, СправочникОбъект.Организации.
//
// Возвращаемое значение
//	Булево - Истина, если полученный объект отражается в реестре документов через технологический ключ.
//
Функция ОбъектЯвляетсяКлючомРеестра(Объект) Экспорт
	
	Если Не ЗначениеЗаполнено(Объект) Тогда
		Возврат Ложь;
	ИначеЕсли Не ОбщегоНазначения.ЭтоСправочник(Объект.Метаданные()) Тогда
		Возврат Ложь;
	КонецЕсли;
	
	СправочникСсылка	= Объект.Ссылка;
	ТипСсылки		= ТипЗнч(СправочникСсылка);
	
	МетаданныеКлючей	= Метаданные.НайтиПоПолномуИмени("Справочник.КлючиРеестраДокументов");
	ТипыИсточника		= МетаданныеКлючей.Реквизиты.Ключ.Тип.Типы();
	
	ОбработатьОбъект = ТипыИсточника.Найти(ТипСсылки) <> Неопределено;
	
	Возврат ОбработатьОбъект;
	
КонецФункции

// Функция - Объекты метаданных закешированные в ключах реестра
// 
// Возвращаемое значение:
//  Соответствие - в ключах лежат объекты типа ОбъектМетаданных.
//
Функция ОбъектыМетаданныхЗакешированныеВКлючахРеестра() Экспорт 
	ОбъектыМетаданных = Новый Соответствие;
	
	Для каждого ТипКлюча Из Метаданные.Справочники.КлючиРеестраДокументов.Реквизиты.Ключ.Тип.Типы() Цикл
		
		МетаданныеОбъекта = Метаданные.НайтиПоТипу(ТипКлюча);
		ОбъектыМетаданных.Вставить(МетаданныеОбъекта);
		
	КонецЦикла;
	
	Возврат ОбъектыМетаданных;
	
КонецФункции

// Получает ключи реестра по значениям справочников
//
// Параметры:
//    Значения - Массив, Произвольный - ссылка(и) на справочники базы данных, например, СправочникСсылка.Склад.
// 
// Возвращаемое значение:
//    Массив - ключи реестра
//
Функция КлючиПоЗначениям(Значения) Экспорт
	
	Запрос = Новый Запрос("
	|ВЫБРАТЬ
	|	Ссылка
	|ИЗ
	|	Справочник.КлючиРеестраДокументов
	|ГДЕ
	|	Ключ В (&Ключи)
	|");
	
	Запрос.УстановитьПараметр("Ключи", Значения);
	
	Возврат Запрос.Выполнить().Выгрузить().ВыгрузитьКолонку("Ссылка");
	
КонецФункции

// Находит дубли ключей реестра документов, удаляет их. 
// При этом удаляются записи реестра документов. Если остался ключ, по которому
// в реестре не было записей, а по удаленным ключам были - то записи восстанавливаются
// с "правильными" ключами.
//
Процедура НайтиИУдалитьДубли() Экспорт
	
	РезультатЗапроса = ДублирующиеКлючи(Истина);
	УдалитьДубли(РезультатЗапроса, Ложь);
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

Функция КлючиРеестраДляОбновления(ОбъектыМетаданных, Порциями, ПустыеСсылки = "ВключатьВсе", ЭлементДляОбновленияКлюча = Неопределено)

	ТекстЗапроса =
	ТекстЗапросаВТДанныеПоОбъектам(ОбъектыМетаданных) +
	"ВЫБРАТЬ "+ ?(Порциями, "ПЕРВЫЕ 1000", "") + "
	|	ВложенныйЗапрос.Ключ КАК Ключ,
	|	ВложенныйЗапрос.Организация КАК Организация,
    |	ВложенныйЗапрос.КодПоЕДРПОУ КАК КодПоЕДРПОУ,
	|	ВложенныйЗапрос.Наименование КАК Наименование,
	|	СУММА(ВложенныйЗапрос.Контроль) КАК Контроль
	|ИЗ
	|	(ВЫБРАТЬ
	|		ДанныеПоОбъектам.Ключ КАК Ключ,
	|		ДанныеПоОбъектам.Организация КАК Организация,
    |		ДанныеПоОбъектам.КодПоЕДРПОУ КАК КодПоЕДРПОУ,
	|		ДанныеПоОбъектам.Наименование КАК Наименование,
	|		1 КАК Контроль,
	|		ЕСТЬNULL(КлючиРеестраДокументов.Ссылка, ЗНАЧЕНИЕ(Справочник.КлючиРеестраДокументов.ПустаяСсылка)) КАК СсылкаНаКлюч
	|	ИЗ
	|		ДанныеПоОбъектам КАК ДанныеПоОбъектам
	|			ЛЕВОЕ СОЕДИНЕНИЕ Справочник.КлючиРеестраДокументов КАК КлючиРеестраДокументов
	|			ПО (КлючиРеестраДокументов.Ключ = ДанныеПоОбъектам.Ключ)
	|	ГДЕ
	|	    &БезОтбораПоСсылке
	|	    ИЛИ ДанныеПоОбъектам.Ключ = &ЭлементДляОбновленияКлюча 
	|	
	|	ОБЪЕДИНИТЬ ВСЕ
	|	
	|	ВЫБРАТЬ
	|		КлючиРеестраДокументов.Ключ,
	|		КлючиРеестраДокументов.Организация,
    |		КлючиРеестраДокументов.КодПоЕДРПОУ,
	|		КлючиРеестраДокументов.Наименование,
	|		-1,
	|		КлючиРеестраДокументов.Ссылка
	|	ИЗ
	|		Справочник.КлючиРеестраДокументов КАК КлючиРеестраДокументов
	|	ГДЕ
	|	    &БезОтбораПоСсылке
	|	    ИЛИ КлючиРеестраДокументов.Ключ = &ЭлементДляОбновленияКлюча) КАК ВложенныйЗапрос 
	|
	|СГРУППИРОВАТЬ ПО
	|	ВложенныйЗапрос.Организация,
	|	ВложенныйЗапрос.Ключ,
	|	ВложенныйЗапрос.Наименование,
    |	ВложенныйЗапрос.КодПоЕДРПОУ
	|
	|ИМЕЮЩИЕ
	|	СУММА(ВложенныйЗапрос.Контроль) > 0";
	
	
	Запрос = Новый Запрос;
	
	Если ЭлементДляОбновленияКлюча = Неопределено Тогда
		Запрос.УстановитьПараметр("ВключатьНеПустые", ПустыеСсылки = "ВключатьВсе" Или ПустыеСсылки = "ВключатьНепустые");
		Запрос.УстановитьПараметр("ВключатьПустые", ПустыеСсылки = "ВключатьВсе" Или ПустыеСсылки = "ВключатьПустые");
	Иначе
		Запрос.УстановитьПараметр("ВключатьНеПустые", Истина);
		Запрос.УстановитьПараметр("ВключатьПустые", Ложь);
	КонецЕсли;	
		
	Запрос.УстановитьПараметр("БезОтбораПоСсылке", ЭлементДляОбновленияКлюча = Неопределено);
	Запрос.УстановитьПараметр("ЭлементДляОбновленияКлюча", ЭлементДляОбновленияКлюча);
	Запрос.Текст = ТекстЗапроса;
	
	ТаблицаКлючей = Запрос.Выполнить().Выгрузить();
	
	Возврат ТаблицаКлючей;
		
КонецФункции

Функция ТекстЗапросаВТДанныеПоОбъектам(ОбъектыМетаданных)
	ТекстыЗапроса = Новый Массив;
	
	Если ТипЗнч(ОбъектыМетаданных) = Тип("Соответствие") Тогда
		
		Для Каждого ОписаниеОбъекта Из ОбъектыМетаданных Цикл
			ТекстЗапроса = ТекстЗапросаДанныхПоСправочнику(ОписаниеОбъекта.Ключ);
			ТекстыЗапроса.Добавить(ТекстЗапроса);
		КонецЦикла;
		
		ШаблонЗапросаОбъединения = "
		|
		|ОБЪЕДИНИТЬ ВСЕ
		|
		|";
		
		ТекстЗапросаПоОбъектам = СтрСоединить(ТекстыЗапроса, ШаблонЗапросаОбъединения);
		
	ИначеЕсли ТипЗнч(ОбъектыМетаданных) = Тип("ОбъектМетаданных") Тогда	
		
		ТекстЗапросаПоОбъектам = ТекстЗапросаДанныхПоСправочнику(ОбъектыМетаданных);
		
	Иначе
		
		ТекстИсключения = НСтр("ru='Тип %Тип% не поддерживается функцией';uk='Тип %Тип% не підтримується функцією'");
		ТекстИсключения = СтрЗаменить(ТекстИсключения, "%Тип%", Строка(ТипЗнч(ОбъектыМетаданных)));
		
		ВызватьИсключение ТекстИсключения;
		
	КонецЕсли;
		
	ТекстЗапроса = 
	"ВЫБРАТЬ
	|	ВложенныйЗапрос.Ключ КАК Ключ,
	|	ВложенныйЗапрос.Организация КАК Организация,
    |	ВложенныйЗапрос.КодПоЕДРПОУ КАК КодПоЕДРПОУ,
	|	ВложенныйЗапрос.Наименование КАК Наименование
	|ПОМЕСТИТЬ ДанныеПоОбъектам
	|ИЗ
	|	("
	+ ТекстЗапросаПоОбъектам + ") КАК ВложенныйЗапрос
	|ИНДЕКСИРОВАТЬ ПО Ключ
	|;";
	
	Возврат ТекстЗапроса;
	
КонецФункции

Функция ТекстЗапросаДанныхПоСправочнику(ОбъектМетаданных)
	ШаблонТекстаЗапроса =
	"ВЫБРАТЬ
	|		СправочникИсточник.Ссылка КАК Ключ,
	|		&ТекстПоляОрганизация КАК Организация,
    |		&ТекстПоляКодПоЕДРПОУ КАК КодПоЕДРПОУ,
	|		СправочникИсточник.Наименование КАК Наименование
	|	ИЗ
	|		ПолноеИмяОбъекта КАК СправочникИсточник
	|	ГДЕ
	|		&ВключатьНепустые
	|	
	|	ОБЪЕДИНИТЬ ВСЕ
	|	
	|	ВЫБРАТЬ
	|		ЗНАЧЕНИЕ(ПолноеИмяОбъекта.ПустаяСсылка),
	|		ЗНАЧЕНИЕ(Справочник.Организации.ПустаяСсылка),
	|		"""",
	|		""""
	|	ГДЕ
	|		&ВключатьПустые";
				
	ТекстЗапроса = СтрЗаменить(ШаблонТекстаЗапроса, "ПолноеИмяОбъекта", ОбъектМетаданных.ПолноеИмя());
	
	ЕстьВладелецОрганизация = Ложь;
	
	Для Каждого Реквизит Из ОбъектМетаданных.СтандартныеРеквизиты Цикл
		Если Реквизит.Имя = "Владелец" Тогда
			
			Если Реквизит.Тип.ПривестиЗначение() = Справочники.Организации.ПустаяСсылка() Тогда
				ЕстьВладелецОрганизация = Истина;
			КонецЕсли;
			
			Прервать;
		КонецЕсли;
	КонецЦикла;
	
	Если ЕстьВладелецОрганизация Тогда
		ТекстЗапроса = СтрЗаменить(ТекстЗапроса, "&ТекстПоляОрганизация", "СправочникИсточник.Владелец");
	Иначе
		ТекстЗапроса = СтрЗаменить(ТекстЗапроса, "&ТекстПоляОрганизация", "ЗНАЧЕНИЕ(Справочник.Организации.ПустаяСсылка)");
	КонецЕсли;
	
    Если ОбъектМетаданных.Реквизиты.Найти("КодПоЕДРПОУ") <> Неопределено Тогда
    	ТекстЗапроса = СтрЗаменить(ТекстЗапроса, "&ТекстПоляКодПоЕДРПОУ", "ЕСТЬNULL(СправочникИсточник.КодПоЕДРПОУ,"""")");
    Иначе
    	ТекстЗапроса = СтрЗаменить(ТекстЗапроса, "&ТекстПоляКодПоЕДРПОУ", """""");
    КонецЕсли;
	
	Возврат ТекстЗапроса;
	
КонецФункции

Функция ДублирующиеКлючи(ИтогиПоКлючу)
	Запрос = Новый Запрос;
	
	ТекстЗапроса = 	
	"ВЫБРАТЬ
	|	КлючиРеестраДокументов.Ключ КАК Ключ,
	|	СУММА(1) КАК Контроль
	|ПОМЕСТИТЬ ВТДубли
	|ИЗ
	|	Справочник.КлючиРеестраДокументов КАК КлючиРеестраДокументов
	|
	|СГРУППИРОВАТЬ ПО
	|	КлючиРеестраДокументов.Ключ
	|
	|ИМЕЮЩИЕ
	|	СУММА(1) > 1
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ
	|	КлючиРеестраДокументов.Ссылка КАК Ссылка,
	|	КлючиРеестраДокументов.Ключ КАК Ключ
	|ИЗ
	|	ВТДубли КАК ВТДубли
	|		ВНУТРЕННЕЕ СОЕДИНЕНИЕ Справочник.КлючиРеестраДокументов КАК КлючиРеестраДокументов
	|		ПО ВТДубли.Ключ = КлючиРеестраДокументов.Ключ";
	
	Если ИтогиПоКлючу Тогда
		ТекстЗапроса = 	ТекстЗапроса + "
		|
		|УПОРЯДОЧИТЬ ПО
		|	Ключ,
		|	Ссылка
		|ИТОГИ ПО
		|	Ключ";
	КонецЕсли;
	
	Запрос.Текст = ТекстЗапроса;
	
	Возврат Запрос.Выполнить();
КонецФункции

Процедура УдалитьДубли(РезультатЗапроса, ЭтоОбновлениеИБ)
	
	ВыборкаКлючам = РезультатЗапроса.Выбрать(ОбходРезультатаЗапроса.ПоГруппировкам);
	
	ТекстЗапросаПропадающихЗаписейРеестра =
	"ВЫБРАТЬ
	|	ПроверкаЧтоЗаписиОстаются.Ссылка КАК Ссылка,
	|	МАКСИМУМ(ПроверкаЧтоЗаписиОстаются.ЗаписьОстается) КАК ЗаписьОстается
	|ИЗ
	|	(ВЫБРАТЬ РАЗЛИЧНЫЕ
	|		РеестрДокументов.Ссылка КАК Ссылка,
	|		ИСТИНА КАК ЗаписьОстается
	|	ИЗ
	|		РегистрСведений.РеестрДокументов КАК РеестрДокументов
	|	ГДЕ
	|		(РеестрДокументов.МестоХранения = &ОстающийсяКлюч
	|				ИЛИ РеестрДокументов.Контрагент = &ОстающийсяКлюч)
	|	
	|	ОБЪЕДИНИТЬ
	|	
	|	ВЫБРАТЬ РАЗЛИЧНЫЕ
	|		РеестрДокументов.Ссылка,
	|		ЛОЖЬ
	|	ИЗ
	|		РегистрСведений.РеестрДокументов КАК РеестрДокументов
	|	ГДЕ
	|		(РеестрДокументов.МестоХранения В (&УдаляемыеКлючи)
	|				ИЛИ РеестрДокументов.Контрагент В (&УдаляемыеКлючи))) КАК ПроверкаЧтоЗаписиОстаются
	|
	|СГРУППИРОВАТЬ ПО
	|	ПроверкаЧтоЗаписиОстаются.Ссылка
	|
	|ИМЕЮЩИЕ
	|	МАКСИМУМ(ПроверкаЧтоЗаписиОстаются.ЗаписьОстается) = ЛОЖЬ ИЛИ &ЭтоОбновлениеИБ";
	
	Пока ВыборкаКлючам.Следующий() Цикл
		
		ВыборкаПоСсылкам = ВыборкаКлючам.Выбрать(ОбходРезультатаЗапроса.ПоГруппировкам);
		
		НачатьТранзакцию();
		Попытка
			
			ПерваяСсылка = Истина;
			ОстающийсяКлюч = Неопределено;
			УдаляемыеКлючи = Новый Массив;
			Пока ВыборкаПоСсылкам.Следующий() Цикл
				Если ЭтоОбновлениеИБ Тогда
					ОбновлениеИнформационнойБазы.ОтметитьВыполнениеОбработки(ВыборкаПоСсылкам.Ссылка);
				КонецЕсли;
				
				Если ПерваяСсылка Тогда
					ПерваяСсылка = Ложь;
					ОстающийсяКлюч = ВыборкаПоСсылкам.Ссылка;
					Продолжить;
				КонецЕсли;
				
				УдаляемыеКлючи.Добавить(ВыборкаПоСсылкам.Ссылка);
				
			КонецЦикла;
			
			Запрос = Новый Запрос;
			Запрос.Текст = ТекстЗапросаПропадающихЗаписейРеестра;
			Запрос.УстановитьПараметр("ОстающийсяКлюч", ОстающийсяКлюч);
			Запрос.УстановитьПараметр("УдаляемыеКлючи", УдаляемыеКлючи);
			Запрос.УстановитьПараметр("ЭтоОбновлениеИБ", ЭтоОбновлениеИБ);
			
			ДокументыДляПереотражения = Запрос.Выполнить().Выбрать();
			
			Для Каждого СтрМас Из УдаляемыеКлючи Цикл
				
				КлючОбъект = СтрМас.ПолучитьОбъект();
				УстановитьПривилегированныйРежим(Истина);
				КлючОбъект.Удалить();
				УстановитьПривилегированныйРежим(Ложь);
				
			КонецЦикла;
			
			Пока ДокументыДляПереотражения.Следующий() Цикл
				
				Набор = РегистрыСведений.РеестрДокументов.СоздатьНаборЗаписей();
				Набор.Отбор.Ссылка.Установить(ДокументыДляПереотражения.Ссылка);
				
				Если ДокументыДляПереотражения.ЗаписьОстается Тогда
					Если ЭтоОбновлениеИБ Тогда
						ОбновлениеИнформационнойБазы.ОтметитьВыполнениеОбработки(Набор);
					КонецЕсли;
				Иначе
					УстановитьПривилегированныйРежим(Истина);
					ТаблицыДанных = ПроведениеДокументов.ДанныеДокументаДляПроведения(
						ДокументыДляПереотражения.Ссылка, "РеестрДокументов");
					Набор.ЗагрузитьСОбработкой(ТаблицыДанных.ТаблицаРеестрДокументов);
					Если ЭтоОбновлениеИБ Тогда
						ОбновлениеИнформационнойБазы.ЗаписатьДанные(Набор);
						Очередь = ОбновлениеИнформационнойБазы.ОчередьОтложенногоОбработчикаОбновления(
							"РегистрыСведений.РеестрДокументов.ОбработатьДанныеДляПереходаНаНовуюВерсию");
						Если Очередь <> Неопределено Тогда
							ОбновлениеИнформационнойБазы.ОтметитьВыполнениеОбработки(Набор, , Очередь);
						КонецЕсли;
					Иначе
						Набор.Записать();
					КонецЕсли;
					УстановитьПривилегированныйРежим(Ложь);
					Если ЭтоОбновлениеИБ Тогда		
						ОбновлениеИнформационнойБазы.ОтметитьВыполнениеОбработки(Набор,
							,
							ОбновлениеИнформационнойБазы.ОчередьОтложенногоОбработчикаОбновления(
								"РегистрыСведений.РеестрДокументов.ОбработатьДанныеДляПереходаНаНовуюВерсию"));
					КонецЕсли;
				КонецЕсли;
				
			КонецЦикла;
			
			ЗафиксироватьТранзакцию();
		Исключение
			ОтменитьТранзакцию();
			
			ТекстСообщения = НСтр("ru='Не удалось удалить дубли ключа реестра документов %Ключ% по причине: %Причина%';uk='Не вдалося видалити дублі ключа реєстру документів %Ключ% через: %Причина%'");
			ТекстСообщения = СтрЗаменить(ТекстСообщения, "%Ключ%", ВыборкаКлючам.Ключ);
			ТекстСообщения = СтрЗаменить(ТекстСообщения, "%Причина%", ПодробноеПредставлениеОшибки(ИнформацияОбОшибке()));
			
			Если ЭтоОбновлениеИБ Тогда
				СобытиеЖурнала = ОбновлениеИнформационнойБазы.СобытиеЖурналаРегистрации();
			Иначе
				СобытиеЖурнала = ИмяСобытияЖурналаУдаленияДублей();
			КонецЕсли;

			
			ЗаписьЖурналаРегистрации(СобытиеЖурнала,
				УровеньЖурналаРегистрации.Предупреждение,
				ВыборкаКлючам.Ключ.Метаданные(),
				ВыборкаКлючам.Ключ,
				ТекстСообщения);
		КонецПопытки;
		
	КонецЦикла;
	
КонецПроцедуры

Функция ИмяСобытияЖурналаУдаленияДублей() Экспорт
	
	Возврат НСтр("ru='Удаление ключей реестра документов';uk='Вилучення ключів реєстру документів'",ОбщегоНазначенияКлиентСервер.КодОсновногоЯзыка());	
	
КонецФункции

Функция ЕстьДубли() Экспорт
	
	Запрос = Новый Запрос;
	Запрос.Текст =
	"ВЫБРАТЬ ПЕРВЫЕ 1
	|	КлючиРеестраДокументов.Ключ КАК Ключ,
	|	СУММА(1) КАК Проверка
	|ИЗ
	|	Справочник.КлючиРеестраДокументов КАК КлючиРеестраДокументов
	|
	|СГРУППИРОВАТЬ ПО
	|	КлючиРеестраДокументов.Ключ
	|
	|ИМЕЮЩИЕ
	|	СУММА(1) > 1";
	
	УстановитьПривилегированныйРежим(Истина);
	ЕстьДубли = Не Запрос.Выполнить().Пустой();
	УстановитьПривилегированныйРежим(Ложь);

	Если ЕстьДубли Тогда
		Если СтандартныеПодсистемыПовтИсп.ИспользуетсяРИБ() Тогда
			Если ОбщегоНазначения.ЭтоПодчиненныйУзелРИБ() Тогда
				Возврат "ЕстьДублиВПодчиненномУзлеРИБ";
			Иначе
				Возврат "ЕстьДублиВГлавномУзлеРИБ";
			КонецЕсли;
		Иначе
			Возврат "ЕстьДублиВГлавномУзлеРИБ";
		КонецЕсли;
	Иначе
		Возврат "Нет";
	КонецЕсли;
	
КонецФункции

Функция ЕстьКлючиДляГенерации() Экспорт
	
	ОбъектыМетаданных = ОбъектыМетаданныхЗакешированныеВКлючахРеестра();
	УстановитьПривилегированныйРежим(Истина);
	ЕстьКлючиДляГенерации = КлючиРеестраДляОбновления(ОбъектыМетаданных, Истина).Количество() > 0; 
	УстановитьПривилегированныйРежим(Ложь);
	
	Если ЕстьКлючиДляГенерации Тогда
		Если СтандартныеПодсистемыПовтИсп.ИспользуетсяРИБ() Тогда
			Если ОбщегоНазначения.ЭтоПодчиненныйУзелРИБ() Тогда
				Возврат "ЕстьЭлементыБезКлючейВПодчиненномУзлеРИБ";
			Иначе
				Возврат "ЕстьЭлементыБезКлючейВГлавномУзлеРИБ";
			КонецЕсли;
		Иначе
			Возврат "ЕстьЭлементыБезКлючейВГлавномУзлеРИБ";
		КонецЕсли;
	Иначе
		Возврат "Нет";
	КонецЕсли;

КонецФункции

Функция РезультатФоновыхЗаданий()
	                                       
	Результат = Новый Структура();
	Результат.Вставить("ЕстьДубли");
	Результат.Вставить("ЕстьЭлементыСправочниковБезКлючей");
	Результат.Вставить("ЕстьДокументыКПереотражениюВРеестре");
	
	Возврат Результат;
	
КонецФункции

Процедура НайтиИУдалитьДублиВФормеСписка(Параметры, АдресВременногоХранилища) Экспорт
	
	Если Не ОбновлениеИнформационнойБазы.ОбработкаДанныхЗавершена(Неопределено, "РегистрСведений.РеестрДокументов") Тогда
		ТекстИсключения = НСтр("ru='По реестру документов есть невыполненные обработчики обновления. Перед запуском процедуры необходимо дождаться окончания их выполнения.';uk='За реєстром документів є невиконані обробники оновлення. Перед запуском процедури необхідно дочекатися закінчення їх виконання.'");
	    ВызватьИсключение ТекстИсключения;
	КонецЕсли;

	Результат = РезультатФоновыхЗаданий();
	
	НайтиИУдалитьДубли();
	
	Если ЕстьДубли() <> "Нет" Тогда
		Результат.ЕстьДубли = "Ошибка";
	Иначе
		Результат.ЕстьДубли = "Нет";
	КонецЕсли;	
	
	ПоместитьВоВременноеХранилище(Результат, АдресВременногоХранилища);
	
КонецПроцедуры

Процедура СоздатьКлючиВФормеСписка(Параметры, АдресВременногоХранилища) Экспорт
	
	Если Не ОбновлениеИнформационнойБазы.ОбработкаДанныхЗавершена(Неопределено, "РегистрСведений.РеестрДокументов") Тогда
		ТекстИсключения = НСтр("ru='По реестру документов есть невыполненные обработчики обновления. Перед запуском процедуры необходимо дождаться окончания их выполнения.';uk='За реєстром документів є невиконані обробники оновлення. Перед запуском процедури необхідно дочекатися закінчення їх виконання.'");
	    ВызватьИсключение ТекстИсключения;
	КонецЕсли;
	
	Результат = РезультатФоновыхЗаданий();
	
	СоздатьОбновитьКлючиРеестра();
	
	Запрос = Новый Запрос;
	Запрос.Текст =
	"ВЫБРАТЬ
	|	РеестрДокументов.Ссылка КАК Ссылка
	|ИЗ
	|	РегистрСведений.РеестрДокументов КАК РеестрДокументов
	|ГДЕ
	|	РеестрДокументов.Проведен
	|	И РеестрДокументов.МестоХранения = ЗНАЧЕНИЕ(Справочник.КлючиРеестраДокументов.ПустаяСсылка)";
	
	Выборка = Запрос.Выполнить().Выбрать();
	
	Пока Выборка.Следующий() Цикл
		
		Отказ = Ложь;
		Попытка
			ТаблицыДанных = ПроведениеДокументов.ДанныеДокументаДляПроведения(Выборка.Ссылка, "РеестрДокументов");
			РегистрыСведений.РеестрДокументов.ЗаписатьДанные(ТаблицыДанных, Выборка.Ссылка, Отказ);
		Исключение
			ЗаписьЖурналаРегистрации(НСтр("ru='Переотражение документов в реестре документов';uk='Перевідобаження документів в реєстрі документів'",ОбщегоНазначенияКлиентСервер.КодОсновногоЯзыка()),
				УровеньЖурналаРегистрации.Ошибка,
				Метаданные.РегистрыСведений.РеестрДокументов,
				Выборка.Ссылка,
				ПодробноеПредставлениеОшибки(ИнформацияОбОшибке()));
		КонецПопытки;
		
	КонецЦикла;
	
	Если ЕстьКлючиДляГенерации() <> "Нет" Тогда  
		Результат.ЕстьЭлементыСправочниковБезКлючей = "Ошибка";
	Иначе
		Результат.ЕстьЭлементыСправочниковБезКлючей = "Нет";
	КонецЕсли;
	
	ПоместитьВоВременноеХранилище(Результат, АдресВременногоХранилища);
	
КонецПроцедуры

Процедура ПроверитьНеобходимостьПереотраженияДокументовВРеестре(Параметры, АдресВременногоХранилища) Экспорт
	
	Типы = Метаданные.РегистрыСведений.РеестрДокументов.Измерения.Ссылка.Тип.Типы();
	ЕстьОшибки = Ложь;
	
	Для каждого ТипДокумента Из Типы Цикл   
		
			
			ПолноеИмяДокумента = Метаданные.НайтиПоТипу(ТипДокумента).ПолноеИмя();
			
			НеиспользуемыеПоля = Новый Массив;
			НеиспользуемыеПоля.Добавить("Дополнительно");
			НеиспользуемыеПоля.Добавить("РазделительЗаписи");
			НеиспользуемыеПоля.Добавить("НомерПервичногоДокумента");
			
			УстановитьПривилегированныйРежим(Истина);
			
			ИмяДокумента = СтрРазделить(ПолноеИмяДокумента, ".")[1];
			РезультатАдаптацииЗапроса = Документы[ИмяДокумента].АдаптированныйТекстЗапросаДвиженийПоРегистру("РеестрДокументов");
			Регистраторы = ОбновлениеИнформационнойБазыУТ.ДанныеНезависимогоРегистраДляПерепроведения(
			РезультатАдаптацииЗапроса, 
			"РегистрСведений.РеестрДокументов", 
			ПолноеИмяДокумента, 
			НеиспользуемыеПоля);
			
			УстановитьПривилегированныйРежим(Ложь);
			
			Если Регистраторы.Количество() > 0 Тогда
				ЕстьОшибки = Истина;						
				Прервать;
			КонецЕсли;     
			

	КонецЦикла;
	
	Результат = РезультатФоновыхЗаданий();
	
	Если ЕстьОшибки Тогда
		Результат.ЕстьДокументыКПереотражениюВРеестре = "Нет";
	Иначе
		Результат.ЕстьДокументыКПереотражениюВРеестре =  "Есть";
	КонецЕсли;
	
	ПоместитьВоВременноеХранилище(Результат, АдресВременногоХранилища);
	
КонецПроцедуры

Процедура ИсправитьОшибкиОтраженияДокументовВРеестре(Параметры, АдресВременногоХранилища) Экспорт
	
	Если Не ОбновлениеИнформационнойБазы.ОбработкаДанныхЗавершена(Неопределено, "РегистрСведений.РеестрДокументов") Тогда
		ТекстИсключения = НСтр("ru='По реестру документов есть невыполненные обработчики обновления. Перед запуском процедуры необходимо дождаться окончания их выполнения.';uk='За реєстром документів є невиконані обробники оновлення. Перед запуском процедури необхідно дочекатися закінчення їх виконання.'");
	    ВызватьИсключение ТекстИсключения;
	КонецЕсли;
	
	Типы = Метаданные.РегистрыСведений.РеестрДокументов.Измерения.Ссылка.Тип.Типы();
	ЕстьОшибки = Ложь;
	
	Для каждого ТипДокумента Из Типы Цикл
		
		ПолноеИмяДокумента = Метаданные.НайтиПоТипу(ТипДокумента).ПолноеИмя();
		
		НеиспользуемыеПоля = Новый Массив;
		НеиспользуемыеПоля.Добавить("Дополнительно");
		НеиспользуемыеПоля.Добавить("РазделительЗаписи");
		НеиспользуемыеПоля.Добавить("НомерПервичногоДокумента");
		
		УстановитьПривилегированныйРежим(Истина);
		
		ИмяДокумента = СтрРазделить(ПолноеИмяДокумента, ".")[1];
		РезультатАдаптацииЗапроса = Документы[ИмяДокумента].АдаптированныйТекстЗапросаДвиженийПоРегистру("РеестрДокументов");
		Регистраторы = ОбновлениеИнформационнойБазыУТ.ДанныеНезависимогоРегистраДляПерепроведения(
							РезультатАдаптацииЗапроса, 
							"РегистрСведений.РеестрДокументов", 
							ПолноеИмяДокумента, 
							НеиспользуемыеПоля);
							
		Для Каждого Регистратор из Регистраторы Цикл
			
			Отказ = Ложь;
			
			Попытка
				ТаблицыДанных = ПроведениеДокументов.ДанныеДокументаДляПроведения(Регистратор, "РеестрДокументов");
				РегистрыСведений.РеестрДокументов.ЗаписатьДанные(ТаблицыДанных, Регистратор, Отказ);
				Если Отказ Тогда
					ЕстьОшибки = Истина;
				КонецЕсли;
			Исключение
				ЕстьОшибки = Истина;
				ЗаписьЖурналаРегистрации(НСтр("ru='Переотражение документов в реестре документов';uk='Перевідобаження документів в реєстрі документів'",ОбщегоНазначенияКлиентСервер.КодОсновногоЯзыка()),
					УровеньЖурналаРегистрации.Ошибка,
					Метаданные.РегистрыСведений.РеестрДокументов,
					Регистратор,
					ПодробноеПредставлениеОшибки(ИнформацияОбОшибке()));
			КонецПопытки;;
			
		КонецЦикла;					
		
		УстановитьПривилегированныйРежим(Ложь);
		
	КонецЦикла;
	
	Если ЕстьОшибки Тогда
		Результат = РезультатФоновыхЗаданий();
		Результат.ЕстьДокументыКПереотражениюВРеестре = "Ошибка";
		ПоместитьВоВременноеХранилище(Результат, АдресВременногоХранилища);
	Иначе
		ПроверитьНеобходимостьПереотраженияДокументовВРеестре(Параметры, АдресВременногоХранилища);
	КонецЕсли;
	
КонецПроцедуры

Процедура ОбработкаПолученияПредставления(Данные, Представление, СтандартнаяОбработка)

	Если Данные.Наименование = "" Тогда
		СтандартнаяОбработка = Ложь;
		Представление = "";
	КонецЕсли;

КонецПроцедуры

#Область ОбновлениеИнформационнойБазы


// Добавляет в список процедуры-обработчики обновления данных ИБ
// для всех поддерживаемых версий библиотеки или конфигурации.
// Вызывается перед началом обновления данных ИБ для построения плана обновления.
//
//  Обработчики - ТаблицаЗначений - описание полей, см. в процедуре
//                ОбновлениеИнформационнойБазы.НоваяТаблицаОбработчиковОбновления.
//
// Пример добавления процедуры-обработчика в список:
//  Обработчик = Обработчики.Добавить();
//  Обработчик.Версия              = "1.1.0.0";
//  Обработчик.Процедура           = "ОбновлениеИБ.ПерейтиНаВерсию_1_1_0_0";
//  Обработчик.МонопольныйРежим    = Ложь;
//
// Параметры:
// 	Обработчики - см. ОбновлениеИнформационнойБазы.НоваяТаблицаОбработчиковОбновления
//
Процедура ОписаниеОбработчиковОбновления(Обработчики) Экспорт

	Обработчик = Обработчики.Добавить();
	Обработчик.Версия = "3.5.4.400";
	Обработчик.РежимВыполнения = "Отложенно";
	Обработчик.Процедура = "Справочники.КлючиРеестраДокументов.ОбработатьДанныеДляПереходаНаНовуюВерсию";
	Обработчик.Идентификатор = Новый УникальныйИдентификатор("578adefc-2391-4ae7-b9b4-1816a030d9e8");
	Обработчик.ПроцедураЗаполненияДанныхОбновления = "Справочники.КлючиРеестраДокументов.ЗарегистрироватьДанныеКОбработкеДляПереходаНаНовуюВерсию";
	Обработчик.ПроцедураПроверки = "ОбновлениеИнформационнойБазы.ДанныеОбновленыНаНовуюВерсиюПрограммы";
	Обработчик.ЧитаемыеОбъекты = "Справочник.КассыККМ,"
		+ "Справочник.БанковскиеСчетаОрганизаций,"
		+ "Справочник.Организации,"
		+ "Справочник.Кассы,"
		+ "Справочник.Склады,"
		+ "Справочник.Контрагенты,"
		+ "Справочник.ФизическиеЛица," 
		+ "Справочник.Партнеры," 
		+ "Справочник.СтруктураПредприятия";
	Обработчик.ИзменяемыеОбъекты = "Справочник.КлючиРеестраДокументов";
	Обработчик.БлокируемыеОбъекты = "Справочник.КлючиРеестраДокументов";
	Обработчик.Комментарий = НСтр("ru='Заполняет новый объект метаданных ""Ключи реестра документов"".';uk='Заповнює новий об''єкт метаданих ""Ключі реєстру документів"".'");
	Обработчик.ПриоритетыВыполнения = ОбновлениеИнформационнойБазы.ПриоритетыВыполненияОбработчика();

	НоваяСтрока = Обработчик.ПриоритетыВыполнения.Добавить();
	НоваяСтрока.Процедура = "РегистрыСведений.РеестрДокументов.ОбработатьДанныеДляПереходаНаНовуюВерсию";
	НоваяСтрока.Порядок = "До";

	НоваяСтрока = Обработчик.ПриоритетыВыполнения.Добавить();
	НоваяСтрока.Процедура = "Справочники.СтруктураПредприятия.ОбработатьДанныеДляПереходаНаНовуюВерсию";
	НоваяСтрока.Порядок = "После";

	НоваяСтрока = Обработчик.ПриоритетыВыполнения.Добавить();
	НоваяСтрока.Процедура = "Справочники.Организации.ОбработатьДанныеДляПереходаНаНовуюВерсию";
	НоваяСтрока.Порядок = "Любой";


	
	НоваяСтрока = Обработчик.ПриоритетыВыполнения.Добавить();
	НоваяСтрока.Процедура = "ОбновлениеИнформационнойБазыУТ.ОбновитьПредставленияПредопределенныхЭлементов";
	НоваяСтрока.Порядок = "Любой";   
	
	НоваяСтрока = Обработчик.ПриоритетыВыполнения.Добавить();
	НоваяСтрока.Процедура = "Справочники.Партнеры.ОбработатьДанныеДляПереходаНаНовуюВерсию";
	НоваяСтрока.Порядок = "Любой";
	
КонецПроцедуры

Процедура ЗарегистрироватьДанныеКОбработкеДляПереходаНаНовуюВерсию(Параметры) Экспорт 
	
	ОбъектыМетаданных = ОбъектыМетаданныхЗакешированныеВКлючахРеестра();
	
	КлючиРеестраДляОбновления = КлючиРеестраДляОбновления(ОбъектыМетаданных, Ложь, "ВключатьНепустые");
	
	ОбновлениеИнформационнойБазы.ОтметитьКОбработке(Параметры, КлючиРеестраДляОбновления.ВыгрузитьКолонку("Ключ"));
	
КонецПроцедуры

Процедура ОбработатьДанныеДляПереходаНаНовуюВерсию(Параметры) Экспорт
	
	// Штатно, если все идет нормально, обработчик должен отработать для один запуск, не порциями.
	
	ОбъектыМетаданных = ОбъектыМетаданныхЗакешированныеВКлючахРеестра();
	
	Для Каждого ОбъектМетаданных Из ОбъектыМетаданных Цикл
		
		ЕстьЗаписиВоВременнойТаблице = Истина;
		
		Пока ЕстьЗаписиВоВременнойТаблице Цикл
			
			МенеджерВТ = Новый МенеджерВременныхТаблиц;
			ПолноеИмяСправочника = ОбъектМетаданных.Ключ.ПолноеИмя();
			
			РезультатСозданияВТ = ОбновлениеИнформационнойБазы.СоздатьВременнуюТаблицуСсылокДляОбработки(
										Параметры.Очередь,
										ПолноеИмяСправочника,
										МенеджерВТ);
			
			ЕстьЗаписиВоВременнойТаблице = РезультатСозданияВТ.ЕстьЗаписиВоВременнойТаблице;
			
			Если Не ЕстьЗаписиВоВременнойТаблице Тогда
				Продолжить;
			КонецЕсли;
			
			ТаблицаКлючей = ОбщегоНазначенияУТ.ПоказатьВременнуюТаблицу(МенеджерВТ, РезультатСозданияВТ.ИмяВременнойТаблицы);
			
			НачатьТранзакцию();
			
			Попытка
				
				Блокировка = Новый БлокировкаДанных;
				
				ЭлементБлокировки = Блокировка.Добавить("Справочник.КлючиРеестраДокументов");
				ЭлементБлокировки.ИсточникДанных = ТаблицаКлючей;
				ЭлементБлокировки.ИспользоватьИзИсточникаДанных("Ключ", "Ссылка");
				ЭлементБлокировки.Режим = РежимБлокировкиДанных.Исключительный;
				
				ЭлементБлокировки = Блокировка.Добавить(ПолноеИмяСправочника);
				ЭлементБлокировки.ИсточникДанных = ТаблицаКлючей;
				ЭлементБлокировки.ИспользоватьИзИсточникаДанных("Ссылка", "Ссылка");
				ЭлементБлокировки.Режим = РежимБлокировкиДанных.Разделяемый;
				
				Блокировка.Заблокировать();
				
				ТекстЗапроса = ТекстЗапросаВТДанныеПоОбъектам(ОбъектМетаданных.Ключ) +
				"ВЫБРАТЬ
				|		ДанныеПоОбъектам.Ключ КАК Ключ,
				|		ДанныеПоОбъектам.Организация КАК Организация,
				|		ДанныеПоОбъектам.КодПоЕДРПОУ КАК КодПоЕДРПОУ,
				|		ДанныеПоОбъектам.Наименование КАК Наименование,
				|		ЕСТЬNULL(КлючиРеестраДокументов.Ссылка, ЗНАЧЕНИЕ(Справочник.КлючиРеестраДокументов.ПустаяСсылка)) КАК СсылкаНаКлюч
				|	ИЗ
				|		ДанныеПоОбъектам КАК ДанныеПоОбъектам
				|			ЛЕВОЕ СОЕДИНЕНИЕ Справочник.КлючиРеестраДокументов КАК КлючиРеестраДокументов
				|			ПО (КлючиРеестраДокументов.Ключ = ДанныеПоОбъектам.Ключ)
				|			ВНУТРЕННЕЕ СОЕДИНЕНИЕ " + РезультатСозданияВТ.ИмяВременнойТаблицы + " КАК " + РезультатСозданияВТ.ИмяВременнойТаблицы + "
				|   		ПО ДанныеПоОбъектам.Ключ = " + РезультатСозданияВТ.ИмяВременнойТаблицы + ".Ссылка";
				
				Запрос = Новый Запрос;
				Запрос.Текст = ТекстЗапроса;
				Запрос.МенеджерВременныхТаблиц = МенеджерВТ;
				Запрос.УстановитьПараметр("ВключатьНеПустые", Истина);
				Запрос.УстановитьПараметр("ВключатьПустые", Ложь);
				
				ВыборкаСсылок = Запрос.Выполнить().Выбрать();
				
				Пока ВыборкаСсылок.Следующий() Цикл
					
					Если ЗначениеЗаполнено(ВыборкаСсылок.СсылкаНаКлюч) Тогда
						КлючОбъект = ВыборкаСсылок.СсылкаНаКлюч.ПолучитьОбъект();
					Иначе
						КлючОбъект = Справочники.КлючиРеестраДокументов.СоздатьЭлемент();
					КонецЕсли;
					
					ЗаполнитьЗначенияСвойств(КлючОбъект, ВыборкаСсылок);
					
					ОбновлениеИнформационнойБазы.ЗаписатьДанные(КлючОбъект);
					ОбновлениеИнформационнойБазы.ОтметитьВыполнениеОбработки(КлючОбъект.Ключ);
					
				КонецЦикла;
				
				ЗафиксироватьТранзакцию();
			Исключение
				
				ОтменитьТранзакцию();
				ТекстСообщения = НСтр("ru='Не удалось обработать ключ реестра документов по элементу справочника %Ссылка% по причине: %Причина%';uk='Не вдалося обробити ключ реєстру документів за елементом довідника %Ссылка% по причині: %Причина%'");
				ТекстСообщения = СтрЗаменить(ТекстСообщения, "%Ссылка%", ВыборкаСсылок.Ключ);
				ТекстСообщения = СтрЗаменить(ТекстСообщения, "%Причина%", ПодробноеПредставлениеОшибки(ИнформацияОбОшибке()));
				ЗаписьЖурналаРегистрации(ОбновлениеИнформационнойБазы.СобытиеЖурналаРегистрации(),
					УровеньЖурналаРегистрации.Предупреждение,
					ОбъектМетаданных.Ключ,
					ВыборкаСсылок.Ключ,
					ТекстСообщения);
			КонецПопытки;
			
		КонецЦикла;
		
	КонецЦикла;
	
	ВсеОбработано = Истина;
	
	КлючиРеестраДляОбновления = КлючиРеестраДляОбновления(ОбъектыМетаданных, Ложь, "ВключатьПустые");
	
	Если КлючиРеестраДляОбновления.Количество() > 0 Тогда
		
		ВсеОбработано = Ложь;
		
		Для Каждого СтрТабл Из КлючиРеестраДляОбновления Цикл
			
			НачатьТранзакцию();
			
			Попытка
				
				Блокировка = Новый БлокировкаДанных;
				
				ЭлементБлокировки = Блокировка.Добавить("Справочник.КлючиРеестраДокументов");
				ЭлементБлокировки.УстановитьЗначение("Ключ", СтрТабл.Ключ);
				ЭлементБлокировки.Режим = РежимБлокировкиДанных.Исключительный;				
				
				Блокировка.Заблокировать();
				
				МетаданныеОбъекта = Метаданные.НайтиПоТипу(ТипЗнч(СтрТабл.Ключ));
				
				ТекстЗапроса = ТекстЗапросаВТДанныеПоОбъектам(МетаданныеОбъекта) +
				"ВЫБРАТЬ
				|		ДанныеПоОбъектам.Ключ КАК Ключ,
				|		ДанныеПоОбъектам.Организация КАК Организация,
				|		ДанныеПоОбъектам.КодПоЕДРПОУ КАК КодПоЕДРПОУ,
				|		ДанныеПоОбъектам.Наименование КАК Наименование,
				|		ЕСТЬNULL(КлючиРеестраДокументов.Ссылка, ЗНАЧЕНИЕ(Справочник.КлючиРеестраДокументов.ПустаяСсылка)) КАК СсылкаНаКлюч
				|	ИЗ
				|		ДанныеПоОбъектам КАК ДанныеПоОбъектам
				|			ЛЕВОЕ СОЕДИНЕНИЕ Справочник.КлючиРеестраДокументов КАК КлючиРеестраДокументов
				|			ПО (КлючиРеестраДокументов.Ключ = ДанныеПоОбъектам.Ключ)";
				
				Запрос = Новый Запрос;
				Запрос.Текст = ТекстЗапроса;
				Запрос.УстановитьПараметр("ВключатьНеПустые", Ложь);
				Запрос.УстановитьПараметр("ВключатьПустые", Истина);
				
				ВыборкаСсылок = Запрос.Выполнить().Выбрать();
				
				Пока ВыборкаСсылок.Следующий() Цикл
					
					Если ЗначениеЗаполнено(ВыборкаСсылок.СсылкаНаКлюч) Тогда
						КлючОбъект = ВыборкаСсылок.СсылкаНаКлюч.ПолучитьОбъект();
					Иначе
						КлючОбъект = Справочники.КлючиРеестраДокументов.СоздатьЭлемент();
					КонецЕсли;
					
					ЗаполнитьЗначенияСвойств(КлючОбъект, ВыборкаСсылок);
					
					ОбновлениеИнформационнойБазы.ЗаписатьДанные(КлючОбъект);
					
				КонецЦикла;
				
				ЗафиксироватьТранзакцию();
			Исключение
				
				ОтменитьТранзакцию();
				ТекстСообщения = НСтр("ru='Не удалось обработать ключ реестра документов по элементу справочника %Ссылка% по причине: %Причина%';uk='Не вдалося обробити ключ реєстру документів за елементом довідника %Ссылка% по причині: %Причина%'");
				ТекстСообщения = СтрЗаменить(ТекстСообщения, "%Ссылка%", ВыборкаСсылок.Ключ);
				ТекстСообщения = СтрЗаменить(ТекстСообщения, "%Причина%", ПодробноеПредставлениеОшибки(ИнформацияОбОшибке()));
												ЗаписьЖурналаРегистрации(ОбновлениеИнформационнойБазы.СобытиеЖурналаРегистрации(),
												УровеньЖурналаРегистрации.Предупреждение,
												МетаданныеОбъекта,
												ВыборкаСсылок.Ключ,
												ТекстСообщения);
			КонецПопытки;
		КонецЦикла;
		
		ВсеОбработано = Истина;
		
	КонецЕсли;
	
	Для Каждого ОбъектМетаданных Из ОбъектыМетаданных Цикл
		Если ОбновлениеИнформационнойБазы.ЕстьДанныеДляОбработки(Параметры.Очередь, ОбъектМетаданных.Ключ.ПолноеИмя()) Тогда
			ВсеОбработано = Ложь;
			Прервать;
		КонецЕсли;
	КонецЦикла;
	
	Параметры.ОбработкаЗавершена = ВсеОбработано; 	
	
КонецПроцедуры


#КонецОбласти

#КонецОбласти

#КонецЕсли
