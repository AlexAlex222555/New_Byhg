#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область СлужебныеПроцедурыИФункции

// Процедура выполняет первоначальное заполнение классификатора.
Процедура НачальноеЗаполнение() Экспорт
	
	КлассификаторТаблица = Новый ТаблицаЗначений;
	КлассификаторТаблица.Колонки.Добавить("Код");
	КлассификаторТаблица.Колонки.Добавить("Наименование");
	
	НоваяСтрокаКлассификатора = КлассификаторТаблица.Добавить();
	НоваяСтрокаКлассификатора.Код = "1";
	НоваяСтрокаКлассификатора.Наименование = НСтр("ru='Читает и переводит со словарем';uk='Читає і перекладає зі словником'");
	
	НоваяСтрокаКлассификатора = КлассификаторТаблица.Добавить();
	НоваяСтрокаКлассификатора.Код = "2";
	НоваяСтрокаКлассификатора.Наименование = НСтр("ru='Читает и может объясняться';uk='Читає і може пояснюватися'");
	
	НоваяСтрокаКлассификатора = КлассификаторТаблица.Добавить();
	НоваяСтрокаКлассификатора.Код = "3";
	НоваяСтрокаКлассификатора.Наименование = НСтр("ru='Владеет свободно';uk='Володіє вільно'");
	
	Запрос = Новый Запрос;
	Запрос.Текст = "ВЫБРАТЬ
	               |	СтепениЗнанияЯзыка.Наименование
	               |ИЗ
	               |	Справочник.СтепениЗнанияЯзыка КАК СтепениЗнанияЯзыка";
	
	ТаблицаСуществующих = Запрос.Выполнить().Выгрузить();
	
	Для Каждого СтрокаКлассификатора Из КлассификаторТаблица Цикл
		Если ТаблицаСуществующих.Найти(СтрокаКлассификатора.Наименование,"Наименование")  = Неопределено Тогда
			СправочникОбъект = Справочники.СтепениЗнанияЯзыка.СоздатьЭлемент();
			ЗаполнитьЗначенияСвойств(СправочникОбъект, СтрокаКлассификатора);
			СправочникОбъект.ДополнительныеСвойства.Вставить("ЗаписьОбщихДанных");
			СправочникОбъект.Записать();
		КонецЕсли;
	КонецЦикла;
	
КонецПроцедуры

// Возвращает реквизиты справочника, которые образуют естественный ключ
//  для элементов справочника.
// Используется для сопоставления элементов механизмом «Выгрузка/загрузка областей данных».
//
// Возвращаемое значение: Массив(Строка) - массив имен реквизитов, образующих
//  естественный ключ.
//
Функция ПоляЕстественногоКлюча() Экспорт
	
	Результат = Новый Массив;
	
	Результат.Добавить("Код");
	
	Возврат Результат;
	
КонецФункции

#КонецОбласти

#КонецЕсли