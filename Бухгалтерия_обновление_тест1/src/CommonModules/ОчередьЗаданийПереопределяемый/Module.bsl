///////////////////////////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2020
// Все права защищены. Эта программа и сопроводительные материалы предоставляются 
// в соответствии с условиями лицензии Attribution 4.0 International (CC BY 4.0)
// Текст лицензии доступен по ссылке:
// https://creativecommons.org/licenses/by/4.0/legalcode
///////////////////////////////////////////////////////////////////////////////////////////////////////

#Область ПрограммныйИнтерфейс

// Формирует список шаблонов заданий очереди.
//
// Параметры:
//  ШаблоныЗаданий - Массив - В параметр следует добавить имена предопределенных
//   неразделенных регламентных заданий, которые должны использоваться в качестве
//   шаблонов для заданий очереди.
//
Процедура ПриПолученииСпискаШаблонов(ШаблоныЗаданий) Экспорт
	
	//++ НЕ ГОСИС
	//++ НЕ БЗК
	ШаблоныЗаданий.Добавить(Метаданные.РегламентныеЗадания.ABCКлассификацияНоменклатуры.Имя);
	ШаблоныЗаданий.Добавить(Метаданные.РегламентныеЗадания.ABCКлассификацияПартнеров.Имя);
	ШаблоныЗаданий.Добавить(Метаданные.РегламентныеЗадания.XYZКлассификацияНоменклатуры.Имя);
	ШаблоныЗаданий.Добавить(Метаданные.РегламентныеЗадания.XYZКлассификацияПартнеров.Имя);
	ШаблоныЗаданий.Добавить(Метаданные.РегламентныеЗадания.ОбновлениеДанныхОДоступностиТоваровДляВнешнихПользователей.Имя);
	ШаблоныЗаданий.Добавить(Метаданные.РегламентныеЗадания.ОбновлениеНоменклатурыПродаваемойСовместно.Имя);
	ШаблоныЗаданий.Добавить(Метаданные.РегламентныеЗадания.КорректировкаСтрокЗаказовМерныхТоваров.Имя);
	
	//++ НЕ УТ
	ШаблоныЗаданий.Добавить(Метаданные.РегламентныеЗадания.ОтложенноеПроведениеЭкземпляровБюджета.Имя);
	//-- НЕ УТ
	ШаблоныЗаданий.Добавить(Метаданные.РегламентныеЗадания.ПроведениеПоРасчетамСПартнерами.Имя);
	ШаблоныЗаданий.Добавить(Метаданные.РегламентныеЗадания.РасчетКурсовыхРазниц.Имя);
	ШаблоныЗаданий.Добавить(Метаданные.РегламентныеЗадания.РасчетИсточниковДанныхВариантовАнализа.Имя);
	ШаблоныЗаданий.Добавить(Метаданные.РегламентныеЗадания.РасчетРекомендацийПоддержанияЗапасов.Имя);
	ШаблоныЗаданий.Добавить(Метаданные.РегламентныеЗадания.РасчетСебестоимости.Имя);
	ШаблоныЗаданий.Добавить(Метаданные.РегламентныеЗадания.УдалениеВзаимодействийПоРассылкамИОповещениям.Имя);
	ШаблоныЗаданий.Добавить(Метаданные.РегламентныеЗадания.ОбновлениеКодовТоваровПодключаемогоОборудования.Имя);
	ШаблоныЗаданий.Добавить(Метаданные.РегламентныеЗадания.ОчисткаСегментов.Имя);
	ШаблоныЗаданий.Добавить(Метаданные.РегламентныеЗадания.ФормированиеСообщенийПоОповещениямКлиентов.Имя);
	ШаблоныЗаданий.Добавить(Метаданные.РегламентныеЗадания.ФормированиеСообщенийПоРассылкамКлиентам.Имя);
	ШаблоныЗаданий.Добавить(Метаданные.РегламентныеЗадания.ПроверкаСостоянияСистемы.Имя);
	ШаблоныЗаданий.Добавить(Метаданные.РегламентныеЗадания.РасчетПоказателейПрогнозаРасходаУпаковок.Имя);
	ШаблоныЗаданий.Добавить(Метаданные.РегламентныеЗадания.СозданиеЗаданийНаОтбор.Имя);
	ШаблоныЗаданий.Добавить(Метаданные.РегламентныеЗадания.СозданиеЗаданийНаПеремещение.Имя);
	ШаблоныЗаданий.Добавить(Метаданные.РегламентныеЗадания.СозданиеЗаданийНаПересчетТоваров.Имя);
	ШаблоныЗаданий.Добавить(Метаданные.РегламентныеЗадания.СверткаРезервовТоваровОрганизаций.Имя);
	//-- НЕ БЗК
	ОчередьЗаданийЛокализация.ПриПолученииСпискаШаблонов(ШаблоныЗаданий);
	//-- НЕ ГОСИС
	
КонецПроцедуры

// Заполняет соответствие имен методов их псевдонимам для вызова из очереди заданий.
//
// Параметры:
//  СоответствиеИменПсевдонимам - Соответствие - 
//    * Ключ - Псевдоним метода, например ОчиститьОбластьДанных.
//    * Значение - Имя метода для вызова, например РаботаВМоделиСервиса.ОчиститьОбластьДанных.
//        В качестве значения можно указать Неопределено, в этом случае считается что имя 
//        совпадает с псевдонимом.
//
Процедура ПриОпределенииПсевдонимовОбработчиков(СоответствиеИменПсевдонимам) Экспорт
	
	//++ НЕ ГОСИС
	
	//++ НЕ БЗК
	СоответствиеИменПсевдонимам.Вставить(Метаданные.РегламентныеЗадания.ФормированиеСегментов.ИмяМетода);
	СоответствиеИменПсевдонимам.Вставить(Метаданные.РегламентныеЗадания.АнализДанныхДляОповещенийКлиентам.ИмяМетода);
	СоответствиеИменПсевдонимам.Вставить(Метаданные.РегламентныеЗадания.АвтоматическоеНачислениеИСписаниеБонусныхБаллов.ИмяМетода);
	СоответствиеИменПсевдонимам.Вставить(Метаданные.РегламентныеЗадания.РасчетПоказателейПрогнозаРасходаУпаковок.ИмяМетода);
	СоответствиеИменПсевдонимам.Вставить(Метаданные.РегламентныеЗадания.СозданиеЗаданийНаПеремещение.ИмяМетода);
	СоответствиеИменПсевдонимам.Вставить(Метаданные.РегламентныеЗадания.СозданиеЗаданийНаОтбор.ИмяМетода);
	СоответствиеИменПсевдонимам.Вставить(Метаданные.РегламентныеЗадания.СозданиеЗаданийНаПересчетТоваров.ИмяМетода);
	СоответствиеИменПсевдонимам.Вставить(Метаданные.РегламентныеЗадания.СверткаРезервовТоваровОрганизаций.ИмяМетода);
	
	
	СоответствиеИменПсевдонимам.Вставить(Метаданные.РегламентныеЗадания.СверткаРезервовТоваровОрганизаций.ИмяМетода);
	//-- НЕ БЗК
	ОчередьЗаданийЛокализация.ПриОпределенииПсевдонимовОбработчиков(СоответствиеИменПсевдонимам);
	//-- НЕ ГОСИС
	
КонецПроцедуры

// Заполняет соответствие методов обработчиков ошибок псевдонимам методов, при возникновении
// ошибок в которых они вызываются.
//
// Параметры:
//  ОбработчикиОшибок - Соответствие -
//    * Ключ - Псевдоним метода, например ОчиститьОбластьДанных.
//    * Значение - Имя метода - обработчика ошибок, для вызова при возникновении ошибки. 
//        Обработчик ошибок вызывается в случае завершения выполнения исходного задания
//        с ошибкой. Обработчик ошибок вызывается в той же области данных, что и исходное задание.
//        Метод обработчика ошибок считается разрешенным к вызову механизмами очереди.
//        Параметры обработчика ошибок:
//          ПараметрыЗадания - Структура - параметры задания очереди.
//          Параметры
//          НомерПопытки
//          КоличествоПовторовПриАварийномЗавершении
//          ДатаНачалаПоследнегоЗапуска.
//
Процедура ПриОпределенииОбработчиковОшибок(ОбработчикиОшибок) Экспорт
	
КонецПроцедуры

// Формирует таблицу регламентных заданий с признаком использования в модели сервиса.
//
// Параметры:
//  ТаблицаИспользования - ТаблицаЗначений - таблица значений с колонками:
//    * РегламентноеЗадание - Строка - имя предопределенного регламентного задания,
//    * Использование - Булево - Истина, если регламентное задание должно
//       выполняться в модели сервиса, Ложь - если не должно.
//
Процедура ПриОпределенииИспользованияРегламентныхЗаданий(ТаблицаИспользования) Экспорт
	
КонецПроцедуры

#КонецОбласти
