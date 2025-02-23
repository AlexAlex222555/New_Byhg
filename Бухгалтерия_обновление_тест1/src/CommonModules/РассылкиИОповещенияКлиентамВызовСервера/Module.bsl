
////////////////////////////////////////////////////////////////////////////////
// Подсистема "Рассылки и оповещения клиентам".
//
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
//  Содержит программный интерфейс для работы с функционалом рассылок и оповещений клиентам.
//  Содержит процедуры обрабатывающие на сервере обращения клиентского кода.
//

#Область ПрограммныйИнтерфейс

// Получает подписку для подписчика и группы рассылок и оповещений
//
// Параметры:
//  Подписчик     - СправочникСсылка.Партнеры - партнер, для которого получается подписка.
//  ГруппаРассылокИОповещений  - СправочникСсылка.ГруппыРассылокИОповещений - группа для которой получается подписка.
//
// Возвращаемое значение:
//   СправочникСсылка.ПодпискиНаРассылкиИОповещенияКлиентам   - подписка, настроенная для подписчика и группы.
//
Функция ПодпискаДляПодписчика(Подписчик, ГруппаРассылокИОповещений) Экспорт
	
	Запрос = Новый Запрос;
	Запрос.Текст = "ВЫБРАТЬ ПЕРВЫЕ 1
	|	ПодпискиНаРассылкиИОповещенияКлиентам.Ссылка
	|ИЗ
	|	Справочник.ПодпискиНаРассылкиИОповещенияКлиентам КАК ПодпискиНаРассылкиИОповещенияКлиентам
	|ГДЕ
	|	ПодпискиНаРассылкиИОповещенияКлиентам.Владелец = &Подписчик
	|	И ПодпискиНаРассылкиИОповещенияКлиентам.ГруппаРассылокИОповещений = &ГруппаРассылокИОповещений
	|	И НЕ ПодпискиНаРассылкиИОповещенияКлиентам.ПометкаУдаления";
	
	Запрос.УстановитьПараметр("Подписчик", Подписчик);
	Запрос.УстановитьПараметр("ГруппаРассылокИОповещений", ГруппаРассылокИОповещений);
	
	Результат = Запрос.Выполнить();
	Если Результат.Пустой() Тогда
		Возврат Справочники.ПодпискиНаРассылкиИОповещенияКлиентам.ПустаяСсылка();
	КонецЕсли;
	
	Выборка = Результат.Выбрать();
	Выборка.Следующий();
	
	Возврат Выборка.Ссылка;
	
КонецФункции

// Определяет группы рассылок и оповещений, в которых есть виды оповещений по типам событий. 
//
// Параметры:
//  ТипСобытия  - Массив, ПеречисленияСсылка.ТипыСобытийОповещений - типы событий, для которых выполняется поиск.
//
// Возвращаемое значение:
//   Массив   - найденные группы рассылок и оповещений.
//
Функция ДоступныеГруппыОповещенийПоТипуСобытия(ТипСобытия) Экспорт

	УстановитьПривилегированныйРежим(Истина);
	
	Запрос = Новый Запрос;
	Запрос.Текст = "
	|ВЫБРАТЬ РАЗЛИЧНЫЕ
	|	ВидыОповещенийКлиентам.ГруппаРассылокИОповещений КАК ГруппаРассылокИОповещений
	|ИЗ
	|	Справочник.ВидыОповещенийКлиентам КАК ВидыОповещенийКлиентам
	|ГДЕ
	|	ВидыОповещенийКлиентам.ТипСобытия В (&ТипыСобытий)
	|	И НЕ ВидыОповещенийКлиентам.ПометкаУдаления
	|	И НЕ ВидыОповещенийКлиентам.ГруппаРассылокИОповещений.ПометкаУдаления
	|";
	
	Если ТипЗнч(ТипСобытия) = Тип("Массив") Тогда
		ТипыСобытий = ТипСобытия;
	Иначе
		ТипыСобытий = Новый Массив();
		ТипыСобытий.Добавить(ТипСобытия);
	КонецЕсли;
	
	Запрос.УстановитьПараметр("ТипыСобытий", ТипыСобытий);
	Запрос.УстановитьПараметр("ТипСобытия", ТипСобытия);
	
	Возврат Запрос.Выполнить().Выгрузить().ВыгрузитьКолонку("ГруппаРассылокИОповещений");

КонецФункции

// В объекте необходимо показывать подписки, если у клиента нет подписок
// по типу события и клиенту доступна хотя бы одна подписка по типу события.
//
// Параметры:
//  Партнер     - СправочникСсылка.Партнеры - партнер, для которого будет настраиваться подписка.
//  ТипСобытия  - Массив, ПеречисленияСсылка.ТипыСобытийОповещений - типы событий, для которых оформляется подписка.
//
// Возвращаемое значение:
//   Булево   - Истина, если показывать, Ложь в обратном случае.
//
Функция ПоказыватьПодпискиНаОповещенияВОбъекте(Партнер, ТипСобытия) Экспорт
	
	Если Не ПравоДоступа("Изменение", Метаданные.Справочники.ПодпискиНаРассылкиИОповещенияКлиентам) Тогда
		Возврат Ложь;
	КонецЕсли;
	
	УстановитьПривилегированныйРежим(Истина);
	
	Если Не ЗначениеЗаполнено(Партнер) Или Не ЗначениеЗаполнено(ТипСобытия) Тогда
		Возврат Ложь;
	КонецЕсли;
	
	Запрос = Новый Запрос;
	Запрос.Текст = "
	|ВЫБРАТЬ РАЗЛИЧНЫЕ
	|	ВидыОповещенийКлиентам.ГруппаРассылокИОповещений КАК ГруппаРассылокИОповещений
	|ПОМЕСТИТЬ
	|	ВидыОповещенийКлиентам
	|ИЗ
	|	Справочник.ВидыОповещенийКлиентам КАК ВидыОповещенийКлиентам
	|ГДЕ
	|	ВидыОповещенийКлиентам.ТипСобытия В (&ТипыСобытий)
	|	И НЕ ВидыОповещенийКлиентам.ПометкаУдаления
	|	И НЕ ВидыОповещенийКлиентам.ГруппаРассылокИОповещений.ПометкаУдаления
	|;
	|ВЫБРАТЬ
	|	ВидыОповещенийКлиентам.ГруппаРассылокИОповещений КАК ГруппаРассылокИОповещений
	|ИЗ
	|	ВидыОповещенийКлиентам КАК ВидыОповещенийКлиентам
	|;
	|ВЫБРАТЬ РАЗЛИЧНЫЕ
	|	ПодпискиНаРассылкиИОповещенияКлиентам.ГруппаРассылокИОповещений КАК ГруппаРассылокИОповещений
	|ИЗ
	|	Справочник.ПодпискиНаРассылкиИОповещенияКлиентам КАК ПодпискиНаРассылкиИОповещенияКлиентам
	|ГДЕ
	|	ПодпискиНаРассылкиИОповещенияКлиентам.Владелец = &Партнер
	|	И НЕ ПодпискиНаРассылкиИОповещенияКлиентам.ПометкаУдаления
	|	И ПодпискиНаРассылкиИОповещенияКлиентам.ГруппаРассылокИОповещений В (
	|		ВЫБРАТЬ
	|			ВидыОповещенийКлиентам.ГруппаРассылокИОповещений
	|		ИЗ
	|			ВидыОповещенийКлиентам КАК ВидыОповещенийКлиентам 
	|	)
	|;
	|";
	
	Если ТипЗнч(ТипСобытия) = Тип("Массив") Тогда
		ТипыСобытий = ТипСобытия;
	Иначе
		ТипыСобытий = Новый Массив();
		ТипыСобытий.Добавить(ТипСобытия);
	КонецЕсли;
	
	Запрос.УстановитьПараметр("ТипыСобытий", ТипыСобытий);
	Запрос.УстановитьПараметр("Партнер", Партнер);
	Результат = Запрос.ВыполнитьПакет();
	
	РезультатЗапроса1 = Результат[1]; // РезультатЗапроса
	РезультатЗапроса2 = Результат[2]; // РезультатЗапроса

	Выборка1 = РезультатЗапроса1.Выбрать();
	Выборка2 = РезультатЗапроса2.Выбрать();
	
	Возврат Выборка1.Количество() > 0 И Выборка2.Количество() = 0;
	
КонецФункции

#КонецОбласти

