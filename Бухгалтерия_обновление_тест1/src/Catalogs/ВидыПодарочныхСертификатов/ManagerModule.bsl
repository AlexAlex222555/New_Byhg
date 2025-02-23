#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ПрограммныйИнтерфейс

// Получает реквизиты объекта, которые необходимо блокировать от изменения
//
// Возвращаемое значение:
//  Массив - блокируемые реквизиты объекта.
//
Функция ПолучитьБлокируемыеРеквизитыОбъекта() Экспорт

	Результат = Новый Массив;
	
	Результат.Добавить("Номинал");
	Результат.Добавить("Валюта");
	Результат.Добавить("ТипКарты");
	Результат.Добавить("ПериодДействия");
	Результат.Добавить("КоличествоПериодовДействия");
	Результат.Добавить("СегментНоменклатуры;ИспользоватьСегментНоменклатуры");
	Результат.Добавить("ЧастичнаяОплата;ЧастичнаяОплатаПереключатель");
	Результат.Добавить("ШаблоныКодовПодарочныхСертификатов");
	Результат.Добавить("СчетУчета");
	Результат.Добавить("СтатьяДоходов");
	Результат.Добавить("АналитикаДоходов");
	
	Возврат Результат;

КонецФункции

#Область ДляВызоваИзДругихПодсистем

// Заполняет реквизиты параметров настройки счетов учета подарочных сертификатов, которые влияют на настройку,
// 	соответствующими им именам реквизитов аналитики учета.
//
// Параметры:
// 	СоответствиеИмен - Соответствие - ключом выступает имя реквизита, используемое в настройке счетов учета,
// 		значением является соответствующее имя реквизита аналитики учета.
// 
Процедура ЗаполнитьСоответствиеРеквизитовНастройкиСчетовУчета(СоответствиеИмен) Экспорт
	
	Возврат;
	
КонецПроцедуры

#КонецОбласти

#КонецОбласти

#КонецЕсли