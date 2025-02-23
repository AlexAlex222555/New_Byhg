////////////////////////////////////////////////////////////////////////////////
// ЭлектронноеВзаимодействиеКлиентСервер: общий механизм обмена электронными документами.
//
////////////////////////////////////////////////////////////////////////////////

#Область СлужебныйПрограммныйИнтерфейс


#Область ОбработкаОшибок

// Формирует служебную структуру, которая может быть использована для указания параметров обработки ошибок для
// реквизитов дерева данных электронного документа.
//
// Параметры:
//  КлючДанных			 - ЛюбаяСсылка - ключ данных для обработки через сообщение пользователю (см. СообщениеПользователю).
//  ПутьКДанным			 - Строка - путь к данным для обработки через сообщение пользователю (см. СообщениеПользователю).
//  НавигационнаяСсылка	 - Строка - навигационная ссылка, по которой нужно перейти при клике на ошибку.
//  ИмяФормы			 - Строка - имя формы, которую нужно открыть при клике на ошибку.
//  ПараметрыФормы		 - Структура - параметры, передаваемые в форму, открываемую при клике на ошибку.
//  ТекстОшибки			 - Строка - используется для переопределения стандартного текста ошибки.
// 
// Возвращаемое значение:
//  Структура - содержит следующие ключи:
//    * КлючСообщения - заполняется из параметра "КлючДанных".
//    * ПутьКДаннымСообщения - заполняется из параметра "ПутьКДанным".
//    * НавигационнаяСсылка - заполняется из параметра "НавигационнаяСсылка".
//    * ИмяФормы - заполняется из параметра "ИмяФормы".
//    * ПараметрыФормы - заполняется из параметра "ПараметрыФормы".
//    * ТекстОшибки - заполняется из параметра "ТекстОшибки".
//
Функция НовыеПараметрыОшибки(КлючДанных = Неопределено, ПутьКДанным = "", НавигационнаяСсылка = "", ИмяФормы = "",
	ПараметрыФормы = Неопределено, ТекстОшибки = "") Экспорт

	ДанныеОшибки = Новый Структура;
	ДанныеОшибки.Вставить("КлючСообщения", КлючДанных);
	ДанныеОшибки.Вставить("ПутьКДаннымСообщения", ПутьКДанным);
	ДанныеОшибки.Вставить("НавигационнаяСсылка", НавигационнаяСсылка);
	ДанныеОшибки.Вставить("ИмяФормы", ИмяФормы);
	ДанныеОшибки.Вставить("ПараметрыФормы", ПараметрыФормы);
	ДанныеОшибки.Вставить("ТекстОшибки", ТекстОшибки);
	
	Возврат ДанныеОшибки;

КонецФункции

#КонецОбласти

#КонецОбласти

#Область СлужебныеПроцедурыИФункции


Функция НовыйКонтекстОперации() Экспорт
	
	Контекст = Новый Структура;
	Контекст.Вставить("ЗаголовокОперации", "");
	Диагностика = Новый Структура;
	Диагностика.Вставить("Ошибки", Новый Массив);
	Контекст.Вставить("Диагностика", Диагностика);
	Контекст.Вставить("ТекущаяУчетнаяЗапись", "");
	Контекст.Вставить("ТекущийПользовательИБ", "");
	Контекст.Вставить("ДатаНачалаОперации", Дата(1, 1, 1));
	Контекст.Вставить("ДатаОкончанияОперации", Дата(1, 1, 1));
	Контекст.Вставить("РезультатыОтправкиПолучения", Новый Структура("Успешные, Неудачные", Новый Массив, Новый Массив));
	Контекст.Вставить("ОшибкиОбработаны", Ложь);
	Контекст.Вставить("СообщатьОбОшибке", Истина);
	
	Возврат Контекст;
	
КонецФункции

#КонецОбласти