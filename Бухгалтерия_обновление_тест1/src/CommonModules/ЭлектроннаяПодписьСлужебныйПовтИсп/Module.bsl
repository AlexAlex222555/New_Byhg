///////////////////////////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2020
// Все права защищены. Эта программа и сопроводительные материалы предоставляются 
// в соответствии с условиями лицензии Attribution 4.0 International (CC BY 4.0)
// Текст лицензии доступен по ссылке:
// https://creativecommons.org/licenses/by/4.0/legalcode
///////////////////////////////////////////////////////////////////////////////////////////////////////

#Область СлужебныеПроцедурыИФункции

// Только для внутреннего использования.
Функция ОбщиеНастройки() Экспорт
	
	ОбщиеНастройки = Новый Структура;
	
	УстановитьПривилегированныйРежим(Истина);
	
	ОбщиеНастройки.Вставить("ИспользоватьЭлектронныеПодписи",
		Константы.ИспользоватьЭлектронныеПодписи.Получить());
	
	ОбщиеНастройки.Вставить("ИспользоватьШифрование",
		Константы.ИспользоватьШифрование.Получить());
	
	Если ОбщегоНазначения.РазделениеВключено()
	 Или ОбщегоНазначения.ИнформационнаяБазаФайловая()
	   И Не ОбщегоНазначения.КлиентПодключенЧерезВебСервер() Тогда
		
		ОбщиеНастройки.Вставить("ПроверятьЭлектронныеПодписиНаСервере", Ложь);
		ОбщиеНастройки.Вставить("СоздаватьЭлектронныеПодписиНаСервере", Ложь);
	Иначе
		ОбщиеНастройки.Вставить("ПроверятьЭлектронныеПодписиНаСервере",
			Константы.ПроверятьЭлектронныеПодписиНаСервере.Получить());
		
		ОбщиеНастройки.Вставить("СоздаватьЭлектронныеПодписиНаСервере",
			Константы.СоздаватьЭлектронныеПодписиНаСервере.Получить());
	КонецЕсли;
	
	ОбщиеНастройки.Вставить("ЗаявлениеНаВыпускСертификатаДоступно", 
		Метаданные.Обработки.Найти("ЗаявлениеНаВыпускНовогоКвалифицированногоСертификата") <> Неопределено);
	Если ОбщиеНастройки.ЗаявлениеНаВыпускСертификатаДоступно Тогда
		Заявление = ОбщегоНазначения.ОбщийМодуль("Обработки.ЗаявлениеНаВыпускНовогоКвалифицированногоСертификата");
		ОбщиеНастройки.ЗаявлениеНаВыпускСертификатаДоступно = Заявление.ЗаявлениеНаВыпускСертификатаДоступно();
	КонецЕсли;		
	
	Запрос = Новый Запрос;
	Запрос.Текст =
	"ВЫБРАТЬ
	|	Программы.Ссылка КАК Ссылка,
	|	Программы.Наименование КАК Наименование,
	|	Программы.ИмяПрограммы КАК ИмяПрограммы,
	|	Программы.ТипПрограммы КАК ТипПрограммы,
	|	Программы.АлгоритмПодписи КАК АлгоритмПодписи,
	|	Программы.АлгоритмХеширования КАК АлгоритмХеширования,
	|	Программы.АлгоритмШифрования КАК АлгоритмШифрования
	|ИЗ
	|	Справочник.ПрограммыЭлектроннойПодписиИШифрования КАК Программы
	|ГДЕ
	|	НЕ Программы.ПометкаУдаления
	|	И НЕ Программы.ЭтоПрограммаОблачногоСервиса
	|
	|УПОРЯДОЧИТЬ ПО
	|	Наименование";
	
	Выборка = Запрос.Выполнить().Выбрать();
	ОписанияПрограмм = Новый Массив;
	ПоставляемыеНастройки = Справочники.ПрограммыЭлектроннойПодписиИШифрования.ПоставляемыеНастройкиПрограмм();
	
	Пока Выборка.Следующий() Цикл
		Отбор = Новый Структура("ИмяПрограммы, ТипПрограммы", Выборка.ИмяПрограммы, Выборка.ТипПрограммы);
		Строки = ПоставляемыеНастройки.НайтиСтроки(Отбор);
		Идентификатор = ?(Строки.Количество() = 0, "", Строки[0].Идентификатор);
		
		Описание = Новый Структура;
		Описание.Вставить("Ссылка",              Выборка.Ссылка);
		Описание.Вставить("Наименование",        Выборка.Наименование);
		Описание.Вставить("ИмяПрограммы",        Выборка.ИмяПрограммы);
		Описание.Вставить("ТипПрограммы",        Выборка.ТипПрограммы);
		Описание.Вставить("АлгоритмПодписи",     Выборка.АлгоритмПодписи);
		Описание.Вставить("АлгоритмХеширования", Выборка.АлгоритмХеширования);
		Описание.Вставить("АлгоритмШифрования",  Выборка.АлгоритмШифрования);
		Описание.Вставить("Идентификатор",       Идентификатор);
		ОписанияПрограмм.Добавить(Новый ФиксированнаяСтруктура(Описание));
	КонецЦикла;
	
	ОбщиеНастройки.Вставить("ОписанияПрограмм", Новый ФиксированныйМассив(ОписанияПрограмм));
	
	Возврат Новый ФиксированнаяСтруктура(ОбщиеНастройки);
	
КонецФункции

Функция ТипыВладельцев(ТолькоСсылки = Ложь) Экспорт
	
	Результат = Новый Соответствие;
	Типы = Метаданные.ОпределяемыеТипы.ПодписанныйОбъект.Тип.Типы();
	
	ИсключаемыеТипы = Новый Соответствие;
	ИсключаемыеТипы.Вставить(Тип("Неопределено"), Истина);
	ИсключаемыеТипы.Вставить(Тип("Строка"), Истина);
	
	Если ОбщегоНазначения.ПодсистемаСуществует("СтандартныеПодсистемы.РаботаСФайлами") Тогда
		ИсключаемыеТипы.Вставить(Тип("СправочникСсылка." + "ВерсииФайлов"), Истина);
	КонецЕсли;
	
	Для Каждого Тип Из Типы Цикл
		Если ИсключаемыеТипы.Получить(Тип) <> Неопределено Тогда
			Продолжить;
		КонецЕсли;
		Результат.Вставить(Тип, Истина);
		Если Не ТолькоСсылки Тогда
			ИмяТипаОбъекта = СтрЗаменить(Метаданные.НайтиПоТипу(Тип).ПолноеИмя(), ".", "Объект.");
			Результат.Вставить(Тип(ИмяТипаОбъекта), Истина);
		КонецЕсли;
	КонецЦикла;
	
	Возврат Новый ФиксированноеСоответствие(Результат);
	
КонецФункции

Функция КлассификаторОшибокКриптографии() Экспорт
	
	Возврат ЭлектроннаяПодписьСлужебный.КлассификаторОшибокКриптографии();
	
КонецФункции

#КонецОбласти
