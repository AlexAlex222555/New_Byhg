#Область ПрограммныйИнтерфейс

// Проверяет, что это не новый элемент справочника
// 
// Параметры:
// 	Форма - ФормаКлиентскогоПриложения - форма обработчика:
// 		* Объект - СправочникОбъект -
// 	ИмяФормы - Строка - имя подчиненной формы
// 	ОповещениеПослеЗаписи - ОписаниеОповещения - Описание
// 	ТекстВопроса - Строка - текст вопроса
//
Процедура ПроверитьЧтоЭтоНеНовыйЭлемент(Форма, ИмяФормы, ОповещениеПослеЗаписи, ТекстВопроса = Неопределено) Экспорт
	
	// Проверим, что это не новый элемент справочника.
	Если Не ЗначениеЗаполнено(Форма.Объект.Ссылка) Тогда
		
		Если ТекстВопроса = Неопределено Тогда
			ТекстВопроса = НСтр("ru='Данные еще не записаны.
|Переход к ""%ИмяФормы%"" возможен только после записи данных.
|Данные будут записаны.'
|;uk='Дані ще не записані.
|Перехід до ""%ИмяФормы%"" можливий тільки після запису даних.
|Дані будуть записані.'");
			ТекстВопроса = СтрЗаменить(ТекстВопроса, "%ИмяФормы%", ИмяФормы);
		КонецЕсли;
		ПараметрыОповещения = Новый Структура("Оповещение, Форма", ОповещениеПослеЗаписи, Форма);
		ПоказатьВопрос(Новый ОписаниеОповещения("ПроверитьЧтоЭтоНеНовыйЭлементОбработкаОтвета", ЭтотОбъект, ПараметрыОповещения), ТекстВопроса, РежимДиалогаВопрос.ОКОтмена);
		Возврат;
		
	КонецЕсли;
	
	ВыполнитьОбработкуОповещения(ОповещениеПослеЗаписи);
	
КонецПроцедуры

// Возвращает фильтр, используемый для выбора файлов-изображений.
// Возвращаемое значение:
// Строка - строка, содержащая фильтр для файлов-изображений.
//
Функция ФильтрФайловИзображений() Экспорт
	Возврат НСтр("ru='Все картинки (*.bmp;*.gif;*.png;*.jpeg;*.dib;*.rle;*.tif;*.jpg;*.ico;*.wmf;*.emf)|*.bmp;*.gif;*.png;*.jpeg;*.dib;*.rle;*.tif;*.jpg;*.ico;*.wmf;*.emf
                  |Все файлы(*.*)|*.*
                  |Формат bmp(*.bmp*;*.dib;*.rle)|*.bmp;*.dib;*.rle
                  |Формат GIF(*.gif*)|*.gif
                  |Формат JPEG(*.jpeg;*.jpg)|*.jpeg;*.jpg
                  |Формат PNG(*.png*)|*.png
                  |Формат TIFF(*.tif)|*.tif
                  |Формат icon(*.ico)|*.ico
                  |Формат метафайл(*.wmf;*.emf)|*.wmf;*.emf'
                  |;uk='Всі картинки (*.bmp;*.gif;*.png;*.jpeg;*.dib;*.rle;*.tif;*.jpg;*.ico;*.wmf;*.emf)|*.bmp;*.gif;*.png;*.jpeg;*.dib;*.rle;*.tif;*.jpg;*.ico;*.wmf;*.emf
                  |Усі файли(*.*)|*.*
                  |Формат bmp(*.bmp*;*.dib;*.rle)|*.bmp;*.dib;*.rle
                  |Формат GIF(*.gif*)|*.gif
                  |Формат JPEG(*.jpeg;*.jpg)|*.jpeg;*.jpg
                  |Формат PNG(*.png*)|*.png
                  |Формат TIFF(*.tif)|*.tif
                  |Формат icon(*.ico)|*.ico
                  |Формат метафайл(*.wmf;*.emf)|*.wmf;*.emf'");
КонецФункции

#КонецОбласти

#Область СлужебныйПрограммныйИнтерфейс

#Область ОбработчикиСобытийФормыЭлемента

// Обработчик события ПослеЗаписи формы элемента справочника Организации
//
// Параметры:
//  ПараметрыЗаписи - Структура - структура, содержащая параметры записи.
//  Форма           - ФормаКлиентскогоПриложения - форма, для которой выполняется обработчик.
//
Процедура ПослеЗаписи(ПараметрыЗаписи, Форма) Экспорт
	//++ Локализация
	//-- Локализация
КонецПроцедуры

// Обработчик события ПослеЗаписи формы элемента справочника Организации
//
// Параметры:
//  Отказ           - Булево - признак отказа.
//  ПараметрыЗаписи - Структура - структура, содержащая параметры записи.
//  Форма           - ФормаКлиентскогоПриложения - форма, для которой выполняется обработчик.
//
Процедура ПередЗаписью(Отказ, ПараметрыЗаписи, Форма) Экспорт
	//++ Локализация
	//-- Локализация
КонецПроцедуры

// Обработчик события ОбработкаВыбора формы элемента справочника Организации
// 
// Параметры:
// 	ВыбранноеЗначение - Произвольный - Результат выбора в подчиненной форме.
// 	ИсточникВыбора    - Произвольный - Форма-источник события.
//  Форма             - ФормаКлиентскогоПриложения - форма, для которой выполняется обработчик.
//
Процедура ОбработкаВыбора(ВыбранноеЗначение, ИсточникВыбора, Форма) Экспорт
	//++ Локализация
	//-- Локализация
КонецПроцедуры

// Обработчик события ОбработкаОповещения формы элемента справочника Организации
//
// Параметры:
//  см. описание платформенного метода ОбработкаОповещения
//
Процедура ОбработкаОповещения(ИмяСобытия, Параметр, Источник, Форма) Экспорт
	//++ Локализация
	//-- Локализация
КонецПроцедуры

// Обработчик события ПриЗакрытии формы элемента справочника Организации
//
// Параметры:
//  ЗавершениеРаботы - Булево - признак завершения работы.
//  Форма - ФормаКлиентскогоПриложения - форма, для которой выполняется обработчик.
//
Процедура ПриЗакрытии(ЗавершениеРаботы, Форма) Экспорт
	//++ Локализация
	//-- Локализация
КонецПроцедуры

// Обработчик события ПриЗакрытии формы элемента справочника Организации
//
// Параметры:
//  Отказ - Булево - признак отказа.
//  ЗавершениеРаботы - Булево - признак завершения работы.
//  ТекстПредупреждения - Строка - текст предупреждения.
//  СтандартнаяОбработка - Булево - признак стандартной обработки.
//  Форма - ФормаКлиентскогоПриложения - форма, для которой выполняется обработчик.
//
Процедура ПередЗакрытием(Отказ, ЗавершениеРаботы, ТекстПредупреждения, СтандартнаяОбработка, Форма) Экспорт
	//++ Локализация	
	//-- Локализация	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовШапкиФормы

Процедура Нажатие_Организации(Элемент, СтандартнаяОбработка, Форма) Экспорт
	//++ Локализация
	//-- Локализация
КонецПроцедуры

Процедура ОбработкаНавигационнойСсылкиФормы_Организации(Элемент, НавигационнаяСсылкаФорматированнойСтроки, СтандартнаяОбработка, Форма) Экспорт
	//++ Локализация
	СтандартнаяОбработка = Ложь;
	Если НавигационнаяСсылкаФорматированнойСтроки = "ОткрытьНастройкиСистемыНалогообложения" Тогда
		ПроверитьЧтоЭтоНеНовыйЭлемент(Форма,
			НСтр("ru='Настройки системы налогообложения';uk='Настройки системи оподаткування'"),
			Новый ОписаниеОповещения("ОткрытьНастройкиСистемыНалогообложенияОбъектЗаписан", 
				ЭтотОбъект,
				Новый Структура("Форма", Форма)));
	КонецЕсли;
	//++ НЕ УТ
	Если НавигационнаяСсылкаФорматированнойСтроки = "ОткрытьУчетнаяПолитикаБухУчета" Тогда
		ПроверитьЧтоЭтоНеНовыйЭлемент(Форма,
			НСтр("ru='Учетная политика бухгалтерского учета';uk='Облікова політика бухгалтерського обліку'"),
			Новый ОписаниеОповещения("ОткрытьУчетнаяПолитикаБухУчетаОбъектЗаписан", 
				ЭтотОбъект,
				Новый Структура("Форма", Форма)));
	КонецЕсли;
	Если НавигационнаяСсылкаФорматированнойСтроки = "ОткрытьНастройкиУчетаНалогаНаПрибыль" Тогда
		ПроверитьЧтоЭтоНеНовыйЭлемент(Форма,
			НСтр("ru='Настройки учета налога на прибыль';uk='Настройки обліку податку на прибуток'"),
			Новый ОписаниеОповещения("ОткрытьНастройкиУчетаНалогаНаПрибыльОбъектЗаписан", 
				ЭтотОбъект,
				Новый Структура("Форма", Форма)));
	КонецЕсли;
	//-- НЕ УТ
    Если НавигационнаяСсылкаФорматированнойСтроки = "ОткрытьНастройкиУчетаЕН" Тогда
		ПроверитьЧтоЭтоНеНовыйЭлемент(Форма,
			НСтр("ru='Настройки учета ЕН';uk='Настройки обліку ЄП'"),
            Новый ОписаниеОповещения("ОткрытьНастройкиУчетаЕНОбъектЗаписан", 
				ЭтотОбъект,
				Новый Структура("Форма", Форма)));
	КонецЕсли;
	//++ НЕ УТ
	Если НавигационнаяСсылкаФорматированнойСтроки = "ОткрытьРезервыОтпусков" Тогда
		ОрганизацииКлиентЛокализация.ПроверитьЧтоЭтоНеНовыйЭлемент(Форма,
			НСтр("ru='Настройки расчета резервов отпусков';uk='Настройки розрахунку резервів відпусток'"),
			Новый ОписаниеОповещения("ОткрытьНастройкиРасчетаРезервовОтпусков", 
				ЭтотОбъект,
				Новый Структура("Форма", Форма)));
	КонецЕсли;
	//-- НЕ УТ
	Если НавигационнаяСсылкаФорматированнойСтроки = "ЗапуститьОбработкуКопированияНастроек" Тогда
		ПроверитьЧтоЭтоНеНовыйЭлемент(Форма,
			НСтр("ru='Помощник копирования настроек учетной политики';uk='Помічник копіювання настройок облікової політики'"),
			Новый ОписаниеОповещения("ОткрытьПомощникКопированияНастроекОбъектЗаписан",
			ЭтотОбъект,
			Новый Структура("Форма, КопированиеИзДругойОрганизации", Форма, Ложь)));
			
	КонецЕсли;
	
	Если НавигационнаяСсылкаФорматированнойСтроки = "ЗапуститьОбработкуКопированияНастроекИзДругойОрганизации" Тогда
		ПроверитьЧтоЭтоНеНовыйЭлемент(Форма,
			НСтр("ru='Помощник копирования настроек учетной политики';uk='Помічник копіювання настройок облікової політики'"),
			Новый ОписаниеОповещения("ОткрытьПомощникКопированияНастроекОбъектЗаписан",
			ЭтотОбъект,
			Новый Структура("Форма, КопированиеИзДругойОрганизации", Форма, Истина)));
		
	КонецЕсли;
	//-- Локализация
КонецПроцедуры

Процедура СкопироватьНастройкиЗавершение(Результат, ДопПараметры) Экспорт
	Если Результат = Неопределено Или Результат = Ложь Тогда
		Возврат;
	КонецЕсли;
	
	ПараметрыОповещения = Новый Структура();
	ИмяСобытия = "ЗаписьНастроекНалоговУчетныхПолитик";
	Оповестить(ИмяСобытия, ПараметрыОповещения);
	
КонецПроцедуры

Процедура ПриИзмененииРеквизита(Элемент, Форма) Экспорт
	//++ Локализация
	Если Элемент.Имя = "ИндивидуальныйПредприниматель" Тогда
		ИндивидуальныйПредпринимательПриИзменении(Элемент, Форма);
	КонецЕсли;
	//-- Локализация
КонецПроцедуры

Процедура ОкончаниеВводаТекста_Организации(Элемент, Текст, ДанныеВыбора, Параметры, СтандартнаяОбработка, Форма) Экспорт
	//++ Локализация
    //Если Элемент.Имя = "ИНН"
    //	ПриОкончанииВводаИНН(Текст, Форма);
    //КонецЕсли;
	Если Элемент.Имя = "КодПоЕДРПОУ" Тогда
		ПриОкончанииВводаКодПоЕДРПОУ(Текст, Форма);
    КонецЕсли;
	//-- Локализация
КонецПроцедуры

Процедура НачалоВыбора_Организации(Элемент, ДанныеВыбора, СтандартнаяОбработка, Форма) Экспорт
	//++ Локализация
	//-- Локализация
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормыЭлемента

Процедура ВыполнитьКомандуЛокализации(Команда, Форма) Экспорт
	//++ Локализация
    Если Команда.Имя = "ОткрытьПараметрыПФ" Тогда
        ОткрытьПараметрыПФ(Команда, Форма);
	КонецЕсли;
	Если Команда.Имя = "ОткрытьПараметрыФСС" Тогда
		ОткрытьПараметрыФСС(Команда, Форма);
	КонецЕсли;
	Если Команда.Имя = "ОткрытьПараметрыКлассификаторов" Тогда
		ОткрытьПараметрыКлассификаторов(Команда, Форма);
	КонецЕсли;
	Если Команда.Имя = "ОткрытьПараметрыРасчетаЗарплаты" Тогда
		ОткрытьПараметрыРасчетаЗарплаты(Команда, Форма);
	КонецЕсли;
	Если Команда.Имя = "ОткрытьКадровыйУчетИРасчетЗарплаты" Тогда
		ОткрытьКадровыйУчетИРасчетЗарплаты(Команда, Форма);
	КонецЕсли;
	
	Если Команда.Имя = "ОткрытьСпециальныеРежимыЗарплатаКадры" Тогда
		ОткрытьСпециальныеРежимыЗарплатаКадры(Команда, Форма)
	КонецЕсли;	
	
	Если Команда.Имя = "ОткрытьБухучетИВыплатуЗарплаты" Тогда
		ОткрытьБухучетИВыплатуЗарплаты(Команда, Форма);
	КонецЕсли;
	
	Если Команда.Имя = "ОткрытьПараметрыГосРегистрации" Тогда
		ОткрытьПараметрыГосРегистрации(Команда, Форма);
	КонецЕсли;
	//-- Локализация
КонецПроцедуры

#КонецОбласти

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

//++ Локализация
#Область ОбработчикиСобытийЭлементовШапкиФормы_Служебные

//++ НЕ БЗК
#Область НалогиУчетныеПолитики

Процедура ОткрытьНастройкиСистемыНалогообложенияОбъектЗаписан(Результат, ДополнительныеПараметры) Экспорт
	
	Форма = ДополнительныеПараметры.Форма;
	ОткрытьФорму("РегистрСведений.НастройкиСистемыНалогообложения.ФормаЗаписи",
		Новый Структура("Организация", Форма.Объект.Ссылка),
		Форма,,,,
		,
		РежимОткрытияОкнаФормы.БлокироватьОкноВладельца);
		
КонецПроцедуры

//++ НЕ УТ
Процедура ОткрытьУчетнаяПолитикаБухУчетаОбъектЗаписан(Результат, ДополнительныеПараметры) Экспорт
	
	Форма = ДополнительныеПараметры.Форма;
	ОткрытьФорму("РегистрСведений.УчетнаяПолитикаБухУчета.ФормаЗаписи",
		Новый Структура("Организация", Форма.Объект.Ссылка),
		Форма,,,,
		,
		РежимОткрытияОкнаФормы.БлокироватьОкноВладельца);
		
КонецПроцедуры

Процедура ОткрытьНастройкиУчетаНалогаНаПрибыльОбъектЗаписан(Результат, ДополнительныеПараметры) Экспорт
	
	Форма = ДополнительныеПараметры.Форма;
	ОткрытьФорму("РегистрСведений.НастройкиУчетаНалогаНаПрибыль.ФормаЗаписи",
		Новый Структура("Организация", Форма.Объект.Ссылка),
		Форма,,,,
		,
		РежимОткрытияОкнаФормы.БлокироватьОкноВладельца);
		
КонецПроцедуры
//-- НЕ УТ           

Процедура ОткрытьНастройкиУчетаЕНОбъектЗаписан(Результат, ДополнительныеПараметры) Экспорт    
	
	Форма = ДополнительныеПараметры.Форма;
    ОткрытьФорму("РегистрСведений.НастройкиУчетаЕН.ФормаЗаписи",
		Новый Структура("Организация", Форма.Объект.Ссылка),
		Форма,,,,
		,
		РежимОткрытияОкнаФормы.БлокироватьОкноВладельца);
		
КонецПроцедуры


Процедура ОткрытьПомощникКопированияНастроекОбъектЗаписан(Результат, ДополнительныеПараметры) Экспорт
	
	Форма = ДополнительныеПараметры.Форма;
	ЗакрытиеФормыПомощникКопированияНастроек =  Новый ОписаниеОповещения("СкопироватьНастройкиЗавершение",
													ЭтотОбъект,
													Новый Структура("Форма", Форма));
	ОчиститьСообщения();
	ОткрытьФорму("Обработка.ПомощникКопированияНастроекУчетныхПолитик.Форма.Форма",
			Новый Структура("Организация, КопированиеИзДругойОрганизации", Форма.Объект.Ссылка, ДополнительныеПараметры.КопированиеИзДругойОрганизации),
			Форма,,,,
			ЗакрытиеФормыПомощникКопированияНастроек,
			РежимОткрытияОкнаФормы.БлокироватьОкноВладельца);
			
КонецПроцедуры

#КонецОбласти
//-- НЕ БЗК

Процедура ИндивидуальныйПредпринимательПриИзменении(Элемент, Форма)
	ПараметрыОбработки = Новый Структура();

	Если НЕ ЗначениеЗаполнено(Форма.Объект.ИндивидуальныйПредприниматель) Тогда
		Форма.Объект.КодПоЕДРПОУ = "";
		ПараметрыОбработки.Вставить("ИмяПроцедуры", "УправлениеФормойНаСервере")
	Иначе
		Форма.Объект.КодПоЕДРПОУ = ОрганизацииВызовСервераЛокализация.ИзменитьКодПоЕДРПОУ(Форма.Объект.ИндивидуальныйПредприниматель);
	КонецЕсли;
	
	ФИОФизическогоЛица = ОрганизацииВызовСервераЛокализация.ПолучитьФИОФизическогоЛица(Форма.Объект.ИндивидуальныйПредприниматель);
	
	Форма.ФИОИндивидуальногоПредпринимателя	= СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку("%1 %2 %3",
		ФИОФизическогоЛица.Фамилия, ФИОФизическогоЛица.Имя, ФИОФизическогоЛица.Отчество);
		
	Форма.Объект.НаименованиеСокращенное	= СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(НСтр("ru='ФЛП %1 %2 %3';uk='ФОП %1 %2 %3'"),
		ФИОФизическогоЛица.Фамилия,
		?(ПустаяСтрока(ФИОФизическогоЛица.Имя), "", Лев(ФИОФизическогоЛица.Имя, 1) + "."),
		?(ПустаяСтрока(ФИОФизическогоЛица.Отчество), "", Лев(ФИОФизическогоЛица.Отчество, 1) + "."));
		
	Форма.Объект.НаименованиеПолное	= "";
	ОбщегоНазначенияУТКлиент.ПродолжитьИзменениеРеквизита(Форма, "НаименованиеСокращенное", Истина, ПараметрыОбработки);
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы_Контрагенты_Служебные

Процедура ОткрытьПараметрыПФ(Команда, Форма)    
	
	//++ НЕ УТ
	ПроверитьЧтоЭтоНеНовыйЭлемент(Форма,
		НСтр("ru='Пенсионный фонд';uk='Пенсійний фонд'"),
        Новый ОписаниеОповещения("ОткрытьПараметрыПФОбъектЗаписан", ЭтотОбъект, Новый Структура("Форма", Форма)));
	//-- НЕ УТ
	
	Возврат; // в УТ пустой
	
КонецПроцедуры

Процедура ОткрытьПараметрыПФОбъектЗаписан(Результат, ДополнительныеПараметры) Экспорт    
	
	Форма = ДополнительныеПараметры.Форма;
	
	//++ НЕ УТ
	
	СтруктураПараметров = Новый Структура;
	СтруктураПараметров.Вставить("ВидОрганизации", Форма.ВидОрганизации);
	СтруктураПараметров.Вставить("НомерРегистрацииПФ", Форма.Объект.НомерРегистрацииПФ);
	СтруктураПараметров.Вставить("КодОрганаПФУ",       Форма.Объект.КодОрганаПФУ);
	СтруктураПараметров.Вставить("Организация", Форма.Объект.Ссылка);
	
    ОткрытьФорму("Справочник.Организации.Форма.ФормаПараметровПФ",
		СтруктураПараметров,
		Форма,,,,
        Новый ОписаниеОповещения("ОткрытьПараметрыПФЗавершение", ЭтотОбъект, Новый Структура("Форма", Форма)),
		РежимОткрытияОкнаФормы.БлокироватьОкноВладельца);
	//-- НЕ УТ
	
	Возврат; // в УТ пустой
	
КонецПроцедуры

Процедура ОткрытьПараметрыПФЗавершение(Результат, ДополнительныеПараметры) Экспорт    
	
	//++ НЕ УТ
	Форма = ДополнительныеПараметры.Форма;
	Если ТипЗнч(Результат) = Тип("Структура") Тогда
		Форма.Модифицированность = Истина;
        ЗаполнитьЗначенияСвойств(Форма.Объект, Результат);
        Форма.Модифицированность = Истина;
        ОбщегоНазначенияУТКлиент.ПродолжитьВыполнениеКоманды(ДополнительныеПараметры.Форма, "ЗаполнитьОписаниеПФ", Истина);
	КонецЕсли;

	//-- НЕ УТ
	
	Возврат; // в УТ пустой
	
КонецПроцедуры

Процедура ОткрытьПараметрыФСС(Команда, Форма)
		
	//++ НЕ УТ
	ПроверитьЧтоЭтоНеНовыйЭлемент(Форма,
		НСтр("ru='Фонд социального страхования';uk='Фонд соціального страхування'"),
		Новый ОписаниеОповещения("ОткрытьПараметрыФССОбъектЗаписан", ЭтотОбъект, Новый Структура("Форма", Форма)));
		
КонецПроцедуры

Процедура ОткрытьПараметрыФССОбъектЗаписан(Результат, ДополнительныеПараметры) Экспорт
	
	Форма = ДополнительныеПараметры.Форма;
	Объект = Форма.Объект;
	
	СтруктураПараметров = Новый Структура;
	СтруктураПараметров.Вставить("ВидОрганизации", Форма.ВидОрганизации);
	СтруктураПараметров.Вставить("НомерФСС", Объект.НомерФСС);	
	СтруктураПараметров.Вставить("НомерФССУ", Объект.НомерФССУ);	
	СтруктураПараметров.Вставить("НазваниеРабочегоОрганаФонда", Объект.НазваниеРабочегоОрганаФонда);	
	СтруктураПараметров.Вставить("ФИОДиректораФонда", Объект.ФИОДиректораФонда);	
	СтруктураПараметров.Вставить("НомерФССНесчСлучай", Объект.НомерФССНесчСлучай);	
	СтруктураПараметров.Вставить("НомерРегистрацииВСлужбеЗанятости", Объект.НомерРегистрацииВСлужбеЗанятости);	
	СтруктураПараметров.Вставить("ОрганСоциальнойЗащитыНаселения", Объект.ОрганСоциальнойЗащитыНаселения);	
	
	ОткрытьФорму("Справочник.Организации.Форма.ФормаПараметровФСС", 
		СтруктураПараметров, 
		Форма,,,, 
		Новый ОписаниеОповещения("ОткрытьПараметрыФССЗавершение", ЭтотОбъект, Новый Структура("Форма", Форма)),
		РежимОткрытияОкнаФормы.БлокироватьОкноВладельца);

КонецПроцедуры

Процедура ОткрытьПараметрыФССЗавершение(Результат, ДополнительныеПараметры) Экспорт
	Форма = ДополнительныеПараметры.Форма;
	СтруктураПараметров = Результат;

	Если ЗначениеЗаполнено(СтруктураПараметров)
			И СтруктураПараметров <> КодВозвратаДиалога.Отмена Тогда
		ЗаполнитьЗначенияСвойств(Форма.Объект, СтруктураПараметров);
		Форма.Модифицированность = Истина;
		ОбщегоНазначенияУТКлиент.ПродолжитьВыполнениеКоманды(ДополнительныеПараметры.Форма, "ЗаполнитьОписаниеФСС", Истина);
	КонецЕсли;

	//-- НЕ УТ
	Возврат;

КонецПроцедуры


Процедура ОткрытьПараметрыКлассификаторов(Команда, Форма)
	
	//++ НЕ УТ
	ПроверитьЧтоЭтоНеНовыйЭлемент(Форма,
		НСтр("ru='Классификаторы';uk='Класифікатори'"),
		Новый ОписаниеОповещения("ОткрытьПараметрыКлассификаторовОбъектЗаписан", ЭтотОбъект, Новый Структура("Форма", Форма)));
	
КонецПроцедуры

Процедура ОткрытьПараметрыКлассификаторовОбъектЗаписан(Результат, ДополнительныеПараметры) Экспорт
	Форма = ДополнительныеПараметры.Форма;
	Объект = Форма.Объект;
	
	СтруктураПараметров = Новый Структура;
	СтруктураПараметров.Вставить("ВидОрганизации", Форма.ВидОрганизации);
    
	СтруктураПараметров.Вставить("КодОПФГ", Объект.КодОПФГ);
	СтруктураПараметров.Вставить("ОПФГ", Объект.ОПФГ);
	
	СтруктураПараметров.Вставить("КодКОАТУУ", Объект.КодКОАТУУ);
	СтруктураПараметров.Вставить("Территория", Объект.Территория);
	СтруктураПараметров.Вставить("КодКАТОТТГ", Объект.КодКАТОТТГ);

	СтруктураПараметров.Вставить("КодКФВ", Объект.КодКФВ);
	СтруктураПараметров.Вставить("ФормаСобственности", Объект.ФормаСобственности);
	
	СтруктураПараметров.Вставить("КодСПОДУ", Объект.КодСПОДУ);
	СтруктураПараметров.Вставить("ОрганГУ", Объект.ОрганГУ);
	
	СтруктураПараметров.Вставить("КодЗКГНГ", Объект.КодЗКГНГ);
	СтруктураПараметров.Вставить("Отрасль", Объект.Отрасль);
	
	СтруктураПараметров.Вставить("КодКВЕД", Объект.КодКВЕД);
	СтруктураПараметров.Вставить("ВЭД", Объект.ВЭД);
	
	СтруктураПараметров.Вставить("КлассПрофессиональногоРиска", Объект.КлассПрофессиональногоРиска);
	
	ОткрытьФорму("Справочник.Организации.Форма.ФормаПараметрыКлассификаторов", 
		СтруктураПараметров, 
		Форма,,,, 
		Новый ОписаниеОповещения("ОткрытьПараметрыКлассификаторовЗавершение", ЭтотОбъект, Новый Структура("Форма", Форма)),
		РежимОткрытияОкнаФормы.БлокироватьОкноВладельца);
	
КонецПроцедуры

Процедура ОткрытьПараметрыКлассификаторовЗавершение(Результат, ДополнительныеПараметры) Экспорт
	Форма = ДополнительныеПараметры.Форма;
	СтруктураПараметров = Результат;

	Если ЗначениеЗаполнено(СтруктураПараметров)
			И СтруктураПараметров <> КодВозвратаДиалога.Отмена Тогда
		ЗаполнитьЗначенияСвойств(Форма.Объект, СтруктураПараметров);
		Форма.Модифицированность = Истина;
		ОбщегоНазначенияУТКлиент.ПродолжитьВыполнениеКоманды(ДополнительныеПараметры.Форма, "ЗаполнитьОписаниеКлассификаторов", Истина);
	КонецЕсли;

	//-- НЕ УТ
	Возврат;

КонецПроцедуры

Процедура ОткрытьПараметрыГосРегистрации(Команда, Форма)
	
	ПроверитьЧтоЭтоНеНовыйЭлемент(Форма,
		НСтр("ru='Государственная регистрация';uk='Державна реєстрація'"),
		Новый ОписаниеОповещения("ОткрытьПараметрыГосРегистрацииОбъектЗаписан", ЭтотОбъект, Новый Структура("Форма", Форма)));
	
КонецПроцедуры

Процедура ОткрытьПараметрыГосРегистрацииОбъектЗаписан(Результат, ДополнительныеПараметры) Экспорт
	Форма = ДополнительныеПараметры.Форма;
	Объект = Форма.Объект;
	
	СтруктураПараметров = Новый Структура;
	СтруктураПараметров.Вставить("ВидОрганизации", Форма.ВидОрганизации);
    
	СтруктураПараметров.Вставить("ДатаРегистрации", 	Объект.ДатаРегистрации);
	СтруктураПараметров.Вставить("НомерРегистрации",    Объект.НомерРегистрации);
	СтруктураПараметров.Вставить("КемЗарегистрирована", Объект.КемЗарегистрирована);
    
	ОткрытьФорму("Справочник.Организации.Форма.ФормаПараметровГосРегистрации", 
		СтруктураПараметров, 
		Форма,,,, 
		Новый ОписаниеОповещения("ОткрытьПараметрыГосРегистрацииЗавершение", ЭтотОбъект, Новый Структура("Форма", Форма)),
		РежимОткрытияОкнаФормы.БлокироватьОкноВладельца);
	
КонецПроцедуры

Процедура ОткрытьПараметрыГосРегистрацииЗавершение(Результат, ДополнительныеПараметры) Экспорт
	Форма = ДополнительныеПараметры.Форма;
	СтруктураПараметров = Результат;

	Если ЗначениеЗаполнено(СтруктураПараметров)
			И СтруктураПараметров <> КодВозвратаДиалога.Отмена Тогда
		ЗаполнитьЗначенияСвойств(Форма.Объект, СтруктураПараметров);
		Форма.Модифицированность = Истина;
		ОбщегоНазначенияУТКлиент.ПродолжитьВыполнениеКоманды(ДополнительныеПараметры.Форма, "ЗаполнитьОписаниеГосРегистрации", Истина);
	КонецЕсли;

	Возврат;

КонецПроцедуры

Процедура ОткрытьПараметрыРасчетаЗарплаты(Команда, Форма)
	
	//++ НЕ УТ
	ПроверитьЧтоЭтоНеНовыйЭлемент(Форма,
        НСтр("ru='График работы';uk='Графік роботи'"),
		Новый ОписаниеОповещения("ОткрытьПараметрыРасчетаЗарплатыОбъектЗаписан" ,ЭтотОбъект, Новый Структура("Форма", Форма)));
			
КонецПроцедуры

Процедура ОткрытьПараметрыРасчетаЗарплатыОбъектЗаписан(Результат, ДополнительныеПараметры) Экспорт
	Форма = ДополнительныеПараметры.Форма;
	Объект = Форма.Объект;
	
	СтруктураПараметров = Новый Структура;
	СтруктураПараметров.Вставить("ОрганизацияСсылка",            Объект.Ссылка);
	СтруктураПараметров.Вставить("ВидОрганизации",               Форма.ВидОрганизации);
	СтруктураПараметров.Вставить("ГрафикРаботыСотрудников",      Объект.ГрафикРаботыСотрудников);
	
	ОткрытьФорму("Справочник.Организации.Форма.ФормаПараметрыФормированияЗарплаты", 
		СтруктураПараметров,
		Форма,,,,
		Новый ОписаниеОповещения("ОткрытьПараметрыРасчетаЗарплатыЗавершение", ЭтотОбъект, Новый Структура("Форма", Форма)),
		РежимОткрытияОкнаФормы.БлокироватьОкноВладельца);
	
КонецПроцедуры

Процедура ОткрытьПараметрыРасчетаЗарплатыЗавершение(Результат, ДополнительныеПараметры) Экспорт
	Форма = ДополнительныеПараметры.Форма;
	СтруктураПараметров = Результат;

	Если ЗначениеЗаполнено(СтруктураПараметров)
			И СтруктураПараметров <> КодВозвратаДиалога.Отмена Тогда
		ЗаполнитьЗначенияСвойств(Форма.Объект, СтруктураПараметров);
		Форма.Модифицированность = Истина;
		ОбщегоНазначенияУТКлиент.ПродолжитьВыполнениеКоманды(ДополнительныеПараметры.Форма, "ЗаполнитьОписаниеПараметровРасчетаЗарплаты", Истина);
	КонецЕсли;

	//-- НЕ УТ
	Возврат;

КонецПроцедуры


Процедура ОткрытьКадровыйУчетИРасчетЗарплаты(Команда, Форма)
	
	//++ НЕ УТ
	ПроверитьЧтоЭтоНеНовыйЭлемент(Форма,
		НСтр("ru='Параметры кадрового учета и расчета зарплаты';uk='Параметри кадрового обліку і розрахунку зарплати'"),
		Новый ОписаниеОповещения("ОткрытьКадровыйУчетИРасчетЗарплатыОбъектЗаписан", ЭтотОбъект, Новый Структура("Форма", Форма)));
			
КонецПроцедуры

Процедура ОткрытьКадровыйУчетИРасчетЗарплатыОбъектЗаписан(Результат, ДополнительныеПараметры) Экспорт
	Форма = ДополнительныеПараметры.Форма;
	Объект = Форма.Объект;
	ПараметрыОткрытия = Новый Структура;
	ПараметрыОткрытия.Вставить("Заголовок",  НСтр("ru='Параметры кадрового учета и расчет зарплаты';uk='Параметри кадрового обліку і розрахунку зарплати'"));
	ПараметрыОткрытия.Вставить("ОрганизацияСсылка",	Объект.Ссылка);
	
	ОткрытьФорму("ОбщаяФорма.ОрганизацияУчетнаяПолитика",
		ПараметрыОткрытия,
		Форма,,,,
		Новый ОписаниеОповещения("ОткрытьКадровыйУчетИРасчетЗарплатыЗавершение", ЭтотОбъект, Новый Структура("Форма", Форма)),
		РежимОткрытияОкнаФормы.БлокироватьОкноВладельца);
	
КонецПроцедуры

Процедура ОткрытьКадровыйУчетИРасчетЗарплатыЗавершение(Результат, ДополнительныеПараметры) Экспорт
	ОбщегоНазначенияУТКлиент.ПродолжитьВыполнениеКоманды(ДополнительныеПараметры.Форма, "ЗаполнитьОписаниеКадровогоУчетаИРасчетаЗарплаты", Истина);
	//-- НЕ УТ
	Возврат;
КонецПроцедуры

Процедура ОткрытьБухучетИВыплатуЗарплаты(Команда, Форма)
	//++ НЕ УТ
	ПроверитьЧтоЭтоНеНовыйЭлемент(Форма,
		НСтр("ru='Бухучет и выплата зарплаты';uk='Бухгалтерський облік та виплата зарплати'"),
		Новый ОписаниеОповещения("ОткрытьБухучетИВыплатуЗарплатыОбъектЗаписан", ЭтотОбъект, Новый Структура("Форма", Форма)));
	
КонецПроцедуры

Процедура ОткрытьБухучетИВыплатуЗарплатыОбъектЗаписан(Результат, ДополнительныеПараметры) Экспорт
	Форма = ДополнительныеПараметры.Форма;
	Объект = Форма.Объект;
	ПараметрыОткрытия = Новый Структура;
	ПараметрыОткрытия.Вставить("Заголовок",			Форма.Заголовок);
	ПараметрыОткрытия.Вставить("ОрганизацияСсылка",	Объект.Ссылка);
	
	ОткрытьФорму("ОбщаяФорма.ОрганизацияБухучетИВыплатаЗарплаты",
		ПараметрыОткрытия,
		Форма,,,, 
		Новый ОписаниеОповещения("ОткрытьБухучетИВыплатуЗарплатыЗавершение", ЭтотОбъект, Новый Структура("Форма", Форма)),
		РежимОткрытияОкнаФормы.БлокироватьОкноВладельца);
	
КонецПроцедуры

Процедура ОткрытьБухучетИВыплатуЗарплатыЗавершение(Результат, ДополнительныеПараметры) Экспорт
	ОбщегоНазначенияУТКлиент.ПродолжитьВыполнениеКоманды(ДополнительныеПараметры.Форма, "ЗаполнитьОписаниеБухучетаИВыплатыЗарплат", Истина);
	//-- НЕ УТ
	Возврат;
КонецПроцедуры


&НаКлиенте
Процедура ОткрытьСпециальныеРежимыЗарплатаКадры(Команда, Форма)
	//++ НЕ УТ
	ПроверитьЧтоЭтоНеНовыйЭлемент(Форма,
		НСтр("ru='Специальные режимы для Зарплаты и кадров';uk='Спеціальні режими для Зарплати та кадрів'"),	
		Новый ОписаниеОповещения("ОткрытьСпециальныеРежимыЗарплатаКадрыЗаписан", ЭтотОбъект, Новый Структура("Форма", Форма)));

КонецПроцедуры

&НаКлиенте
Процедура ОткрытьСпециальныеРежимыЗарплатаКадрыЗаписан(Результат, ДополнительныеПараметры) Экспорт
	Форма = ДополнительныеПараметры.Форма;
	Объект = Форма.Объект;
	
	ПараметрыОткрытия = Новый Структура;
	ПараметрыОткрытия.Вставить("Заголовок",			Форма.Заголовок);
	ПараметрыОткрытия.Вставить("ОрганизацияСсылка",	Объект.Ссылка);
	
	ОткрытьФорму("ОбщаяФорма.ОрганизацияСпециальныеРежимыЗарплатаКадры",
		ПараметрыОткрытия,
		Форма,,,, 
		Новый ОписаниеОповещения("ОткрытьСпециальныеРежимыЗарплатаКадрыЗавершение", ЭтотОбъект, Новый Структура("Форма", Форма)), 
		РежимОткрытияОкнаФормы.БлокироватьОкноВладельца);
	
КонецПроцедуры

&НаКлиенте
Процедура ОткрытьСпециальныеРежимыЗарплатаКадрыЗавершение(Результат, ДополнительныеПараметры) Экспорт
    
	ОбщегоНазначенияУТКлиент.ПродолжитьВыполнениеКоманды(ДополнительныеПараметры.Форма, "ЗаполнитьОписаниеСпециальныеРежимыЗарплатаКадры", Истина);
    //-- НЕ УТ
    Возврат;

КонецПроцедуры




//++ НЕ УТ
Процедура ОткрытьНастройкиРасчетаРезервовОтпусков(Результат, ДополнительныеПараметры) Экспорт
	Форма = ДополнительныеПараметры.Форма;
		
	ОткрытьФорму("ОбщаяФорма.ОрганизацияНастройкиРасчетаРезервовОтпусков",
		Новый Структура("ОрганизацияСсылка", Форма.Объект.Ссылка),
		Форма,,,,
		Новый ОписаниеОповещения("ОткрытьНастройкиРасчетаРезервовОтпусковЗавершение", ЭтотОбъект, Новый Структура("Форма", Форма)),
		РежимОткрытияОкнаФормы.БлокироватьОкноВладельца);
	
КонецПроцедуры

Процедура ОткрытьНастройкиРасчетаРезервовОтпусковЗавершение(Результат, ДополнительныеПараметры) Экспорт
	ОбщегоНазначенияУТКлиент.ПродолжитьВыполнениеКоманды(ДополнительныеПараметры.Форма, "ЗаполнитьНастройкиРасчетаРезервовОтпусков", Истина);
КонецПроцедуры
//-- НЕ УТ


#КонецОбласти


#Область МетодыДляОбработчиковСобытийФормы


Процедура ПриОкончанииВводаКодПоЕДРПОУ(ТекстРедактирования, Форма)	
	
	Перем ТекстСообщения;
	ОчиститьСообщения();
	
	ЭтоЮрЛицо = Форма.Объект.ЮрФизЛицо = ПредопределенноеЗначение("Перечисление.ЮрФизЛицо.ЮрЛицо")
		ИЛИ Форма.Объект.ЮрФизЛицо = ПредопределенноеЗначение("Перечисление.ЮрФизЛицо.ЮрЛицоНеРезидент");
	
	Если НЕ ПустаяСтрока(ТекстРедактирования) 
		И НЕ РегламентированныеДанныеКлиентСервер.КодПоЕДРПОУСоответствуетТребованиям(ТекстРедактирования, 
			ЭтоЮрЛицо,
			ТекстСообщения) Тогда
		
		ОбщегоНазначенияКлиентСервер.СообщитьПользователю(
			ТекстСообщения,
			,"Объект.КодПоЕДРПОУ",,);
			
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ПриОкончанииВводаИНН(ТекстРедактирования, Форма) 
	
	Перем ТекстСообщения;
	ЭтоЮрЛицо = Форма.Объект.ЮрФизЛицо = ПредопределенноеЗначение("Перечисление.ЮрФизЛицо.ЮрЛицо")
		ИЛИ Форма.Объект.ЮрФизЛицо = ПредопределенноеЗначение("Перечисление.ЮрФизЛицо.ЮрЛицоНеРезидент");
	
	ОчиститьСообщения();
	
	Если НЕ ПустаяСтрока(ТекстРедактирования) 
		И НЕ РегламентированныеДанныеКлиентСервер.ИННПлательщикаНДССоответствуетТребованиям(ТекстРедактирования, 
			ЭтоЮрЛицо, 
			ТекстСообщения) Тогда
		
		ОбщегоНазначенияКлиентСервер.СообщитьПользователю(
			ТекстСообщения,
			,"Объект.ИНН",,);
		
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ПриОкончанииВводаНомерСвидетельства(ТекстРедактирования, Форма) 
	
	Перем ТекстСообщения;
	ЭтоЮрЛицо = Форма.Объект.ЮрФизЛицо = ПредопределенноеЗначение("Перечисление.ЮрФизЛицо.ЮрЛицо")
		ИЛИ Форма.Объект.ЮрФизЛицо = ПредопределенноеЗначение("Перечисление.ЮрФизЛицо.ЮрЛицоНеРезидент");
	
	ОчиститьСообщения();
	
	Если НЕ ПустаяСтрока(ТекстРедактирования) 
		И НЕ РегламентированныеДанныеКлиентСервер.НомерСвидетельстваПлательщикаНДССоответствуетТребованиям(ТекстРедактирования, 
			ЭтоЮрЛицо, 
			ТекстСообщения) Тогда
		
		ОбщегоНазначенияКлиентСервер.СообщитьПользователю(
			ТекстСообщения,
			,"НомерСвидетельства",,);
		
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти
//-- Локализация

#Область ПрочиеСлужебныеМетоды

Процедура ПроверитьЧтоЭтоНеНовыйЭлементОбработкаОтвета(КодОтвета, ДополнительныеПараметры) Экспорт
	
	Если КодОтвета = КодВозвратаДиалога.ОК Тогда 
		Форма = ДополнительныеПараметры.Форма; // РасширениеУправляемойФормыДляДокумента - 
		
		ПараметрыЗаписи = Новый Структура;
		ПараметрыЗаписи.Вставить("НеЗакрыватьФорму", Истина);
		
		ЭлементЗаписан = Форма.Записать(ПараметрыЗаписи);
		
		Если Не ЭлементЗаписан Тогда
			Возврат;
		КонецЕсли;
		
		Оповещение = ДополнительныеПараметры.Оповещение;
		
		ВыполнитьОбработкуОповещения(Оповещение);
		
	КонецЕсли;
	
КонецПроцедуры

Процедура ДоступныеРегистрыНалоговУчетныхПолитик(МассивРегистров) Экспорт
	//++ Локализация
	МассивРегистров.Добавить("НастройкиСистемыНалогообложения");
	//++ НЕ УТ           
	МассивРегистров.Добавить("УчетнаяПолитикаБухУчета");
	МассивРегистров.Добавить("НастройкиУчетаНалогаНаПрибыль");
	//-- НЕ УТ           
    МассивРегистров.Добавить("НастройкиУчетаЕН");
	//-- Локализация
КонецПроцедуры

#КонецОбласти

#КонецОбласти