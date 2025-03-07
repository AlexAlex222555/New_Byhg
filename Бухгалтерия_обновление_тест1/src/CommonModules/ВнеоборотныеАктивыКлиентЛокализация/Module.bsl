////////////////////////////////////////////////////////////////////////////////
// Процедуры подсистемы "Внеоборотные активы", предназначенные для локализации.
// 
////////////////////////////////////////////////////////////////////////////////

#Область СлужебныйПрограммныйИнтерфейс

// Описание
// 
// Параметры:
// 	Команда - КомандаФормы - 
// 	Форма - ФормаКлиентскогоПриложения - 
Процедура ПриВыполненииКоманды(Команда, Форма) Экспорт

	ДополнительныеПараметры = Неопределено;
	ТребуетсяВызовСервера = Ложь;
	ПродолжитьВыполнениеКоманды = Истина;
	
	//++ Локализация
	Элементы = Форма.Элементы;
	
	Если Команда.Имя = Элементы.ФормаПроводкиРеглУчета.ИмяКоманды Тогда
		ВыполнитьКомандуОткрытьПроводкиРегламентированногоУчета(Форма, ДополнительныеПараметры);
	КонецЕсли; 

	//-- Локализация
	
	Если ПродолжитьВыполнениеКоманды Тогда
		
		ОбщегоНазначенияУТКлиент.ПродолжитьВыполнениеКоманды(
			Форма, 
			Команда.Имя, 
			ТребуетсяВызовСервера,
			ДополнительныеПараметры);
			
	КонецЕсли; 
	
КонецПроцедуры

Процедура ВыполнитьДействиеПослеРасчета(Форма, ДействиеПослеРасчета) Экспорт

	//++ Локализация
	//-- Локализация

КонецПроцедуры

Функция ПриИзмененииПорядкаУчетаУУ_ОС(Объект, СлужебныеПараметрыФормы) Экспорт

	ИзмененныеРеквизиты = "";
	
	//++ Локализация
	//-- Локализация
	
	Возврат ИзмененныеРеквизиты;
	
КонецФункции

Функция ИмяФормыДокументыПоОсновномуСредству() Экспорт

	ИмяФормы = Неопределено;
	
	//++ Локализация
	Если ВнеоборотныеАктивыВызовСервера.ИспользуетсяУправлениеВНА_2_4() Тогда
		ИмяФормы = "Обработка.ЖурналДокументовОС2_4.Форма";
	Иначе
		ИмяФормы = "Обработка.ЖурналДокументовОС.Форма";
	КонецЕсли;
	//-- Локализация
	
	Возврат ИмяФормы;
	
КонецФункции

Функция ИмяФормыДокументыПоНематериальномуАктиву() Экспорт

	ИмяФормы = Неопределено;
	
	//++ Локализация
	Если ВнеоборотныеАктивыВызовСервера.ИспользуетсяУправлениеВНА_2_4() Тогда
		ИмяФормы = "Обработка.ЖурналДокументовНМА2_4.Форма";
	Иначе
		ИмяФормы = "Обработка.ЖурналДокументовНМА.Форма";
	КонецЕсли;
	//-- Локализация
	
	Возврат ИмяФормы;
	
КонецФункции

Процедура ОбработкаРасшифровки(ФормаОтчета, Элемент, Расшифровка, СтандартнаяОбработка) Экспорт

	//++ Локализация
	//-- Локализация
	
КонецПроцедуры

Процедура ПриИзмененииРеквизитаПринятияКУчетуОС(Элемент, Форма, ДополнительныеПараметры, ТребуетсяВызовСервера) Экспорт

	//++ Локализация
	//-- Локализация
	
КонецПроцедуры

Процедура ПриИзмененииРеквизитаОбъединениеОС(Элемент, Форма, ДополнительныеПараметры, ТребуетсяВызовСервера) Экспорт

	//++ Локализация
	//-- Локализация
	
КонецПроцедуры

#Область ПанельСправочниковВнеоборотныеАктивы

Процедура ПриВыполненииКоманды_ПанельСправочниковВнеоборотныеАктивы(Команда, Форма) Экспорт

	//++ Локализация

	Элементы = Форма.Элементы;

	Если Команда.Имя = Элементы.ОткрытьГодовыеГрафикиАмортизацииОС.Имя Тогда
		ОткрытьФорму("Справочник.ГодовыеГрафикиАмортизацииОС.ФормаСписка", , Форма);
	КонецЕсли; 

	//-- Локализация
	
КонецПроцедуры

#КонецОбласти

//++ Локализация


//  Функция возвращает ОС выбранное в текущей строке таблицы ОС документа для дальнейшей передачи
// в функцию ДозаполнитьТабличнуюЧастьОсновнымиСредствамиПоНаименованию. В случае невозможности
// определения ОС выдает сообщение об ошибке.
//
// Параметры
//  ПараметрыФормы   - Структура с параметрами заполнения, ключи структуры:
//  	Форма             - форма заполняемого документа
//  	Объект            - Значение основного реквизита формы - документа для заполнения
//  	ИмяТабличнойЧасти - Имя табличной части основных средств документа, значение по умолчанию "ОС".
//
// Возвращаемое значение:
//   СправочникСсылка.ОбъектыЭксплуатации, Неопределено - В случае невозможности определения ОС функция
//   	возвращает Неопределено, в противном случае функция возвращает значение ОС.
//
Функция ПолучитьОСДляЗаполнениеПоНаименованию(Параметры) Экспорт
	
	ОчиститьСообщения();
	
	Форма = Параметры.Форма;
	Объект = Параметры.Объект;
	Если Параметры.Свойство("ИмяТабличнойЧасти") Тогда
		ИмяТабличнойЧасти = Параметры.ИмяТабличнойЧасти;
	Иначе
		ИмяТабличнойЧасти = "ОС";
	КонецЕсли;
	
	Если Форма.Элементы[ИмяТабличнойЧасти].ТекущаяСтрока = Неопределено Тогда
		ТекстСообщения = НСтр("ru='Данные для заполнения отсутствуют.';uk='Дані для заповнення відсутні.'");
		ОбщегоНазначенияКлиентСервер.СообщитьПользователю(ТекстСообщения, , "Объект." + ИмяТабличнойЧасти);
		Возврат Неопределено;
	КонецЕсли;
	
	ОсновноеСредство = Форма.Элементы[ИмяТабличнойЧасти].ТекущиеДанные.ОсновноеСредство;
	
	Если НЕ ЗначениеЗаполнено(ОсновноеСредство) Тогда
		ТекстСообщения = НСтр("ru='Не выбрано основное средство';uk='Не вибраний основний засіб'");
		ИндексСтроки = Формат(Объект[ИмяТабличнойЧасти].Индекс(Форма.Элементы[ИмяТабличнойЧасти].ТекущиеДанные), "ЧН=0; ЧГ=");
		ОбщегоНазначенияКлиентСервер.СообщитьПользователю(ТекстСообщения, , "Объект." + ИмяТабличнойЧасти + "[" + ИндексСтроки + "].ОсновноеСредство");
		Возврат Неопределено;
	КонецЕсли;
	
	Возврат ОсновноеСредство;
	
КонецФункции // ПолучитьОСДляЗаполнениеПоНаименованию()

//-- Локализация

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

Функция ОбработкаДействияПодробнееФормыЗакрытияМесяцаЭтапаНачислениеАмортизацииОС(Параметры) Экспорт

	ОбработкаВыполнена = Ложь;
	
	//++ Локализация   
	Если НЕ Параметры.ДополнительныеПараметры.ИспользоватьВнеоборотныеАктивы2_4
		ИЛИ Параметры.Период < Параметры.ДополнительныеПараметры.ДатаНачалаУчета Тогда
		
		ОбработкаВыполнена = Истина;
		ПараметрыФормы = Новый Структура;
		ПараметрыФормы.Вставить("Период", Параметры.Период);
		ПараметрыФормы.Вставить("МассивОрганизаций", Параметры.МассивОрганизаций);
		ОткрытьФорму("Документ.АмортизацияОС.ФормаСписка", ПараметрыФормы);
	КонецЕсли;
	//-- Локализация
	
	Возврат ОбработкаВыполнена;
	
КонецФункции

Функция ОбработкаДействияПодробнееФормыЗакрытияМесяцаЭтапаНачислениеАмортизацииНМА(Параметры) Экспорт

	ОбработкаВыполнена = Ложь;
	
	//++ Локализация
	Если НЕ Параметры.ДополнительныеПараметры.ИспользоватьВнеоборотныеАктивы2_4
		ИЛИ Параметры.Период < Параметры.ДополнительныеПараметры.ДатаНачалаУчета Тогда
		
		ОбработкаВыполнена = Истина;
		ПараметрыФормы = Новый Структура;
		ПараметрыФормы.Вставить("Период", Параметры.Период);
		ПараметрыФормы.Вставить("МассивОрганизаций", Параметры.МассивОрганизаций);
		ОткрытьФорму("Документ.АмортизацияНМА.ФормаСписка", ПараметрыФормы);
	КонецЕсли;
	//-- Локализация
	
	Возврат ОбработкаВыполнена;
	
КонецФункции

//++ Локализация
	Процедура ВыполнитьКомандуОткрытьПроводкиРегламентированногоУчета(Форма, ДополнительныеПараметры)
		
		Если Форма.Модифицированность ИЛИ НЕ ЗначениеЗаполнено(Форма.Объект.Ссылка) Тогда
			
			ДополнительныеПараметры = Новый Структура;
			
			ПараметрыДействия = Новый Структура;
			ПараметрыДействия.Вставить("ЗаголовокДействия", НСтр("ru='Проводки регламентированного учета';uk='Проводки регламентованого обліку'"));
			ПараметрыДействия.Вставить("ДействиеПослеРасчета", "ОткрытьПроводкиРегламентированногоУчета");
			ДополнительныеПараметры.Вставить("Выполнить_ЗаписатьИВыполнитьДействие", ПараметрыДействия);
			
		Иначе
			ОткрытьПроводкиРегламентированногоУчета(Форма.Объект.Ссылка);
		КонецЕсли; 
		
	КонецПроцедуры

	Процедура ОткрытьПроводкиРегламентированногоУчета(Ссылка)

		Отбор = Новый Структура("Регистратор", Ссылка);
		ПараметрыФормы = Новый Структура("Отбор", Отбор);
		ОткрытьФорму("Обработка.ОтражениеДокументовВРеглУчете.Форма.ПроводкиРегламентированногоУчета", ПараметрыФормы);

	КонецПроцедуры

	Процедура ПорядокУчетаБУПриИзменении(Форма, ДополнительныеПараметры)
		
		
	КонецПроцедуры

	Процедура СрокИспользованияБУПриИзменении(ДополнительныеПараметры)
		
		ДополнительныеПараметры = Новый Структура;
		
		ПараметрыДействия = Новый Структура("ИмяРеквизита,ОбновитьЕслиСовпадают", "СрокИспользованияБУ", Истина);
		ДополнительныеПараметры.Вставить("Выполнить_ПриИзмененииСрокаИспользования", ПараметрыДействия);
		
	КонецПроцедуры

	Процедура СрокИспользованияНУПриИзменении(ДополнительныеПараметры)
		
		ДополнительныеПараметры = Новый Структура;
		
		ПараметрыДействия = Новый Структура("ИмяРеквизита,ОбновитьЕслиСовпадают", "СрокИспользованияНУ", Ложь);
		ДополнительныеПараметры.Вставить("Выполнить_ПриИзмененииСрокаИспользования", ПараметрыДействия);
		
	КонецПроцедуры

//-- Локализация

#КонецОбласти
