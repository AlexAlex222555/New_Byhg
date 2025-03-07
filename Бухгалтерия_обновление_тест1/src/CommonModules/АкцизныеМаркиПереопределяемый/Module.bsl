
#Область ПрограммныйИнтерфейс

#Область ПрограммныйИнтерфейсУТ
// Возвращает адрес таблицы акцизных марки во временном хранилище
//
// Параметры:
//  Форма				 - УправляемаяФорма - Форма
//  ИдентификаторСтроки	 - Строка - Идентификатор строки
// 
// Возвращаемое значение:
//  Строка - Адрес во временном хранилище
//
Функция АдресТаблицыАкцизныхМаркиВоВременномХранилище(Форма, ИдентификаторСтроки) Экспорт
	
	Если ОбщегоНазначенияКлиентСервер.ЕстьРеквизитИлиСвойствоОбъекта(Форма, "Объект") Тогда
		Источник = Форма.Объект;
	Иначе
		Источник = Форма;
	КонецЕсли;
	
	Отбор = Новый Структура("ИдентификаторСтроки", ИдентификаторСтроки);
	
	АкцизныеМарки = Источник.АкцизныеМарки.Выгрузить(Отбор, "ШтрихкодАкцизнойМарки");
	
	Возврат ПоместитьВоВременноеХранилище(АкцизныеМарки, Форма.УникальныйИдентификатор);
	
КонецФункции

// Возвращает информацию по акцизным маркам для строки ТЧ Товары
//
// Параметры:
//  Форма				 - УправляемаяФорма - Форма
//  ИдентификаторСтроки	 - Строка - Идентификатор строки ТЧ
//  ШтрихкодАкцизнойМарки	 - Строка - Штрихкод акцизной марки
// 
// Возвращаемое значение:
//  Структура - Количество, АкцизнаяМаркаНайдена, ШтрихкодАкцизнойМарки
//
Функция ДанныеПоАкцизнымМаркам(Форма, ИдентификаторСтроки, ШтрихкодАкцизнойМарки = "") Экспорт
	
	Если ОбщегоНазначенияКлиентСервер.ЕстьРеквизитИлиСвойствоОбъекта(Форма, "Объект") Тогда
		Источник = Форма.Объект;
	Иначе
		Источник = Форма;
	КонецЕсли;
	
	Отбор = Новый Структура("ИдентификаторСтроки", ИдентификаторСтроки);
	НайденныеСтроки = Источник.АкцизныеМарки.НайтиСтроки(Отбор);
	
	ОтборАкцизнаяМарка = Новый Структура;
	ОтборАкцизнаяМарка.Вставить("ИдентификаторСтроки",        ИдентификаторСтроки);
	ОтборАкцизнаяМарка.Вставить("ШтрихкодАкцизнойМарки", ШтрихкодАкцизнойМарки);
	НайденныеСтрокиАкцизнаяМарка = Источник.АкцизныеМарки.НайтиСтроки(ОтборАкцизнаяМарка);
	
	Результат = Новый Структура;
	Результат.Вставить("Количество",           НайденныеСтроки.Количество());
	Результат.Вставить("АкцизнаяМаркаНайдена", НайденныеСтрокиАкцизнаяМарка.Количество() > 0);
	Результат.Вставить("ШтрихкодАкцизнойМарки",ШтрихкодАкцизнойМарки);
	
	Возврат Результат;
	
КонецФункции

// Удаляет акцизные марки для данных табличной части Товары
//
// Параметры:
//  Форма	 - УправляемаяФорма - Форма
//  Данные	 - Массив (СтрокаТЧ) - Строка (строки) для которых требуется удалить акцизные марки
//
Процедура УдалитьАкцизныеМарки(Форма, Данные) Экспорт
	
	Если ОбщегоНазначенияКлиентСервер.ЕстьРеквизитИлиСвойствоОбъекта(Форма, "Объект") Тогда
		Источник = Форма.Объект;
	Иначе
		Источник = Форма;
	КонецЕсли;
	
	Если ТипЗнч(Данные) = Тип("Массив") Тогда
		ИдентификаторыСтрок = Данные;
	Иначе
		ИдентификаторыСтрок = Новый Массив;
		ИдентификаторыСтрок.Добавить(Данные);
	КонецЕсли;
	
	Для Каждого ИдентификаторСтроки Из ИдентификаторыСтрок Цикл
		
		Отбор = Новый Структура("ИдентификаторСтроки", ИдентификаторСтроки);
		НайденныеСтроки = Источник.АкцизныеМарки.НайтиСтроки(Отбор);
		
		Для Каждого СтрокаТЧ Из НайденныеСтроки Цикл
			Источник.АкцизныеМарки.Удалить(Источник.АкцизныеМарки.Индекс(СтрокаТЧ));
		КонецЦикла;
		
	КонецЦикла;
	
КонецПроцедуры

// Загружает акцизные марки из временного хранилища
//
// Параметры:
//  Форма						 - УправляемаяФорма - Форма
//  ИдентификаторСтроки			 - Строка - Индентификатор строки ТЧ
//  АдресВоВременномХранилище	 - Строка - Адрес во временном хранилище
// 
// Возвращаемое значение:
//   - 
//
Функция ЗагрузитьАкцизныеМаркиИзВременногоХранилища(Форма, ИдентификаторСтроки, АдресВоВременномХранилище) Экспорт
	
	Если ОбщегоНазначенияКлиентСервер.ЕстьРеквизитИлиСвойствоОбъекта(Форма, "Объект") Тогда
		Источник = Форма.Объект;
	Иначе
		Источник = Форма;
	КонецЕсли;
	
	УдалитьАкцизныеМарки(Форма, ИдентификаторСтроки);
	
	АкцизныеМарки = ПолучитьИзВременногоХранилища(АдресВоВременномХранилище);
	Для Каждого СтрокаТЧ Из АкцизныеМарки Цикл
		НоваяСтрока = Источник.АкцизныеМарки.Добавить();
		НоваяСтрока.ШтрихкодАкцизнойМарки = СтрокаТЧ.ШтрихкодАкцизнойМарки;
		НоваяСтрока.ИдентификаторСтроки = ИдентификаторСтроки;
	КонецЦикла;
	
	Возврат ДанныеПоАкцизнымМаркам(Форма, ИдентификаторСтроки, "");
	
КонецФункции

// Заполняет служебные реквизиты в табличной части "Товары" в процедурах ПриСозданииНаСервере
//
// Параметры:
//  Форма				 - УправляемаяФорма - Форма
//  ИмяКолонкиКоличество - Строка - Имя колонки "Количество"
//
Процедура ЗаполнитьСлужебныеРеквизиты(Форма, ИмяКолонкиКоличество = "Количество") Экспорт
	
	Если ОбщегоНазначенияКлиентСервер.ЕстьРеквизитИлиСвойствоОбъекта(Форма, "Объект") Тогда
		Источник = Форма.Объект;
	Иначе
		Источник = Форма;
	КонецЕсли;
	
	Запрос = Новый Запрос(
	"ВЫБРАТЬ
	|	Т.НомерСтроки,
	|	Т.ИдентификаторСтроки,
	|	Т.Номенклатура,
	|	Т.Характеристика,
	|	Т.Упаковка
	|ПОМЕСТИТЬ Товары
	|ИЗ
	|	&Товары КАК Т
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ
	|	Т.ИдентификаторСтроки,
	|	Т.ШтрихкодАкцизнойМарки
	|ПОМЕСТИТЬ АкцизныеМаркиПодготовка
	|ИЗ
	|	&АкцизныеМарки КАК Т
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ
	|	Т.ИдентификаторСтроки КАК ИдентификаторСтроки,
	|	КОЛИЧЕСТВО(РАЗЛИЧНЫЕ Т.ШтрихкодАкцизнойМарки) КАК КоличествоАкцизныхМарок
	|ПОМЕСТИТЬ АкцизныеМарки
	|ИЗ
	|	АкцизныеМаркиПодготовка КАК Т
	|
	|СГРУППИРОВАТЬ ПО
	|	Т.ИдентификаторСтроки
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ
	|	Товары.НомерСтроки КАК НомерСтроки,
	|	ЕСТЬNULL(Товары.Номенклатура.УказыватьШтрихкодАкцизнойМаркиПриПечатиЧека, ЛОЖЬ) КАК УказыватьШтрихкодАкцизнойМаркиПриПечатиЧека,
	|	АкцизныеМарки.КоличествоАкцизныхМарок КАК КоличествоАкцизныхМарок
	|ИЗ
	|	Товары КАК Товары
	|		ЛЕВОЕ СОЕДИНЕНИЕ АкцизныеМарки КАК АкцизныеМарки
	|		ПО (АкцизныеМарки.ИдентификаторСтроки = Товары.ИдентификаторСтроки)");
	
	Товары = Источник.Товары.Выгрузить();
	ДополнениеКИндексу = 0;
	Если Товары.Колонки.Найти("НомерСтроки") = Неопределено Тогда
		ДополнениеКИндексу = 1;
		ОбщегоНазначенияУТ.ПронумероватьТаблицуЗначений(Товары, "НомерСтроки");
	КонецЕсли;
	
	Запрос.Параметры.Вставить("Товары", Товары);
	Запрос.Параметры.Вставить("АкцизныеМарки", Источник.АкцизныеМарки.Выгрузить());
	
	Отбор = Новый Структура;
	Отбор.Вставить("НомерСтроки");
	
	Выборка = Запрос.Выполнить().Выбрать();
	Пока Выборка.Следующий() Цикл
		
		СтрокаТЧ = Источник.Товары[Выборка.НомерСтроки - 1 + ДополнениеКИндексу];
		СтрокаТЧ.УказыватьШтрихкодАкцизнойМаркиПриПечатиЧека = Выборка.УказыватьШтрихкодАкцизнойМаркиПриПечатиЧека;
		СтрокаТЧ.КоличествоАкцизныхМарок         = Выборка.КоличествоАкцизныхМарок;
		
		Если Выборка.УказыватьШтрихкодАкцизнойМаркиПриПечатиЧека Тогда
			Если АкцизныеМаркиКлиентСерверПереопределяемый.КоличествоАкцизныхМарокСоответствуетКоличествуТовара(
				СтрокаТЧ.КоличествоАкцизныхМарок, СтрокаТЧ[ИмяКолонкиКоличество]) Тогда
				СтрокаТЧ.ИндексАкцизнойМарки = 1;
			Иначе
				СтрокаТЧ.ИндексАкцизнойМарки = 2;
			КонецЕсли;
		Иначе
			СтрокаТЧ.ИндексАкцизнойМарки = 0;
		КонецЕсли;
		
	КонецЦикла;
	
КонецПроцедуры

Функция МассивВСтрокуСРазделителями(ИсходныйМассив, Разделитель = ",") Экспорт
	
	СтрокаСРазделителями = "";
	Для каждого ЭлементМассива Из ИсходныйМассив Цикл
		СтрокаСРазделителями = СтрокаСРазделителями + ?(ПустаяСтрока(СтрокаСРазделителями), "", Разделитель) + ЭлементМассива;
	КонецЦикла;
	
	Возврат СокрЛП(СтрокаСРазделителями);
	
КонецФункции
  
#КонецОбласти

#КонецОбласти
