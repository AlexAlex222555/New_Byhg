#Область ПрограммныйИнтерфейс

// Возвращает массив элементов коллекции по массиву идентификаторов таблицы формы.
//
// Параметры:
//  ДанныеФормы - ДанныеФормыКоллекция - коллекция, строки которой необходимо получить
//  Строки - Массив - идентификаторы строк (свойство ВыделенныеСтроки таблицы формы).
//
// Возвращаемое значение:
//  Массив - строки коллекции.
//
Функция ЭлементыКоллекции(ДанныеФормы, Строки) Экспорт
	
	ВыделенныеЭлементы = Новый Массив;
	Для Каждого ИдентификаторСтроки Из Строки Цикл
		ЭлементКоллекции = ДанныеФормы.НайтиПоИдентификатору(ИдентификаторСтроки);
		Если ЭлементКоллекции <> Неопределено Тогда
			ВыделенныеЭлементы.Добавить(ЭлементКоллекции);
		КонецЕсли;
	КонецЦикла;
	Возврат ВыделенныеЭлементы;
	
КонецФункции

#Область КэшированиеСтрок

// Возвращает строку сохраненную в кэше на форме для указанной таблицы.
// Перед использованием необходим разовый вызов РаботаСТабличнымиЧастями.ИнициализироватьКэшСтрок().
//
// Параметры:
//  ТаблицаФормы - ТаблицаФормы - элемент формы, содержащий табличную часть.
//
// Возвращаемое значение 
//  ФиксированнаяСтруктура - закэшированная строка таблицы.
//  Форма - ФормаКлиентскогоПриложения - форма объекта метаданных.
//
Функция КэшСтроки(ТаблицаФормы, Форма) Экспорт
	
	Возврат Форма.КэшированныеСтроки[ТаблицаФормы.Имя];
	
КонецФункции

#КонецОбласти

#КонецОбласти