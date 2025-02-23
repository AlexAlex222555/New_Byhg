#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ПрограммныйИнтерфейс

// Получает складскую группу, если она одна в справочнике.
//
// Возвращаемое значение:
//	СправочникСсылка.СкладскиеГруппыУпаковок - найденная складская группа.
//
Функция СкладскаяГруппаУпаковокПоУмолчанию() Экспорт
	
	Запрос = Новый Запрос;
	Запрос.Текст =
	"ВЫБРАТЬ ПЕРВЫЕ 2
	|	СкладскиеГруппыУпаковок.Ссылка КАК СкладскаяГруппаУпаковок
	|ИЗ
	|	Справочник.СкладскиеГруппыУпаковок КАК СкладскиеГруппыУпаковок
	|ГДЕ
	|	НЕ СкладскиеГруппыУпаковок.ПометкаУдаления";
	
	Выборка = Запрос.Выполнить().Выбрать();
	
	Если Выборка.Количество() = 1 Тогда
		Выборка.Следующий();
		СкладскаяГруппаУпаковок = Выборка.СкладскаяГруппаУпаковок;
	Иначе
		СкладскаяГруппаУпаковок = Справочники.СкладскиеГруппыУпаковок.ПустаяСсылка();
	КонецЕсли;
	
	Возврат СкладскаяГруппаУпаковок;

КонецФункции

#КонецОбласти

#КонецЕсли