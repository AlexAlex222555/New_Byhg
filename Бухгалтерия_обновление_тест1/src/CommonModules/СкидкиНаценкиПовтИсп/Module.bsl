
#Область ПрограммныйИнтерфейс

// Возвращает объект внешнего отчета или обработки.
//
// Параметры:
//   Ссылка - СправочникСсылка.ДополнительныеОтчетыИОбработки - Подключаемый отчет или обработка.
//
// Возвращаемое значение: 
//   * ВнешняяОбработкаОбъект - Объект подключенной обработки.
//   * ВнешнийОтчетОбъект     - Объект подключенного отчета.
//   * Неопределено           - Если передана некорректная ссылка.
//
// Важно:
//   Проверка функциональной опции "ИспользоватьДополнительныеОтчетыИОбработки"
//     должна выполняться вызывающим кодом.
//
Функция ОбъектВнешнейОбработки(ВнешняяОбработка) Экспорт
	
	Возврат ДополнительныеОтчетыИОбработки.ОбъектВнешнейОбработки(ВнешняяОбработка);
	
КонецФункции

// Подключает внешнюю обработку (отчет).
//   Подробнее - см. ДополнительныеОтчетыИОбработки.ПодключитьВнешнююОбработку().
//
// Параметры:
//   Ссылка - СправочникСсылка.ДополнительныеОтчетыИОбработки - Подключаемый отчет или обработка.
//
// Возвращаемое значение:
//   * Строка       - Имя подключенного отчета или обработки.
//   * Неопределено - Если передана некорректная ссылка.
//
Функция ПодключитьВнешнююОбработку(ВнешняяОбработка) Экспорт
	
	Возврат ДополнительныеОтчетыИОбработкиВызовСервера.ПодключитьВнешнююОбработку(ВнешняяОбработка);
	
КонецФункции

#КонецОбласти