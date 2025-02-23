////////////////////////////////////////////////////////////////////////////////
// МОДУЛЬ СОДЕРЖИТ ПРОЦЕДУРЫ И ФУНКЦИИ РЕГИСТРАЦИИ ОБЪЕКТОВ ОБМЕНА С МОБИЛЬНЫМ ПРИЛОЖЕНИЕМ "Заказы"
// - регистрация объектов в узлах обмена
////////////////////////////////////////////////////////////////////////////////

#Область ПрограммныйИнтерфейс

// Обработчик подписки на событие "ПередЗаписью" справочника.
//
// Параметры:
//  Источник - СправочникОбъект - источник события;
//  Отказ - Булево - отказ от выполнения.
//
Процедура ЗарегистрироватьИзмененияСправочникаПередЗаписьюДляОбменаСМобильнымПриложениемЗаказы (Источник, Отказ) Экспорт
	
	Если Источник.ОбменДанными.Загрузка Тогда
		Возврат;
	КонецЕсли;
	
	Если Не ПолучитьФункциональнуюОпцию("ИспользоватьМобильноеПриложение1СЗаказы") Тогда
		Возврат;
	КонецЕсли;
	
	Если Отказ Тогда
		Возврат;
	КонецЕсли;
	
	Если Источник.ЭтоГруппа Тогда
		Возврат;
	КонецЕсли;
	
	ЗарегистрироватьКартинкуНоменклатуры = Ложь;
	Если ЗначениеЗаполнено(Источник.ФайлКартинки) Тогда
		Если Источник.ЭтоНовый() Тогда
			ЗарегистрироватьКартинкуНоменклатуры = Истина;
		Иначе
			СтарыйФайлКартинки = ОбщегоНазначения.ЗначениеРеквизитаОбъекта(Источник.Ссылка, "ФайлКартинки");
			Если НЕ Источник.ФайлКартинки = СтарыйФайлКартинки Тогда
				ЗарегистрироватьКартинкуНоменклатуры = Истина;
			КонецЕсли;
		КонецЕсли;
	КонецЕсли;
	Если ЗарегистрироватьКартинкуНоменклатуры Тогда
		ЗарегистрироватьИзменения(Источник.ФайлКартинки, Ложь);
	КонецЕсли;
КонецПроцедуры

// Обработчик подписки на событие "ПриЗаписи" справочника.
//
// Параметры:
//  Источник - СправочникОбъект - источник события;
//  Отказ - Булево - отказ от выполнения.
//
Процедура ЗарегистрироватьИзмененияПриЗаписиСправочникаДляОбменаСЗаказамиКлиентов(Источник, Отказ) Экспорт
	
	Если Источник.ОбменДанными.Загрузка Тогда
		Возврат;
	КонецЕсли;
	
	Если Не ПолучитьФункциональнуюОпцию("ИспользоватьМобильноеПриложение1СЗаказы") Тогда
		Возврат;
	КонецЕсли;
	
	Если Отказ Тогда
		Возврат;
	КонецЕсли;
	
	ЗарегистрироватьИзменения(Источник);
КонецПроцедуры

// Обработчик подписки на событие "ПриЗаписиЗадания".
//
// Параметры:
//  Источник - ДокументОбъект.ЗаказКлиента, ДокументОбъект.ЗаданиеТорговомуПредставителю - источник события;
//  Отказ - Булево - отказ от выполнения.
//
Процедура ЗарегистрироватьИзмененияПриЗаписиЗаданияДляОбменаСЗаказамиКлиентов(Источник, Отказ) Экспорт
	
	Если Источник.ОбменДанными.Загрузка Тогда
		Возврат;
	КонецЕсли;
	
	Если Не ПолучитьФункциональнуюОпцию("ИспользоватьМобильноеПриложение1СЗаказы") Тогда
		Возврат;
	КонецЕсли;
	
	Если Отказ Тогда
		Возврат;
	КонецЕсли;
	
	НеРегистрироватьИзменения = Ложь;
	Если Источник.ДополнительныеСвойства.Свойство("НеРегистрироватьИзменения", НеРегистрироватьИзменения) Тогда
		Если НеРегистрироватьИзменения Тогда
			Возврат;
		КонецЕсли;
	КонецЕсли;
	
	УзлыДляРегистрации = Новый Массив;
	ЗаданиеТорговомуПредставителю = "";
	
	УстановитьПривилегированныйРежим(Истина);
	
	Если ТипЗнч(Источник) = Тип("ДокументОбъект.ЗаказКлиента") Тогда
		
		Если ТипЗнч(Источник.ДокументОснование) = Тип("ДокументСсылка.ЗаданиеТорговомуПредставителю")
			И ЗначениеЗаполнено(Источник.ДокументОснование) Тогда
			
			Попытка
				ЗаданиеТорговомуПредставителю = Источник.ДокументОснование.ПолучитьОбъект();
			Исключение
				ВызватьИсключение НСтр("ru='Не найдена ссылка на документ основание.';uk='Не знайдене посилання на документ підставу.'",ОбщегоНазначенияКлиентСервер.КодОсновногоЯзыка());
			КонецПопытки;
			
			УзлыДляРегистрации = УзлыДляРегистрацииЗаданий(ЗаданиеТорговомуПредставителю.ТорговыйПредставитель);
		КонецЕсли;
		
	ИначеЕсли ТипЗнч(Источник) = Тип("ДокументСсылка.ЗаданиеТорговомуПредставителю") Тогда
		
		Если Источник.Статус = Перечисления.СтатусыЗаданийТорговымПредставителям.КОтработке Тогда
			
			ЗаданиеТорговомуПредставителю = Источник;
			УзлыДляРегистрации = УзлыДляРегистрацииЗаданий(Источник.ТорговыйПредставитель);
		КонецЕсли;
	КонецЕсли;
	
	Если УзлыДляРегистрации.Количество()>0 Тогда
		ПланыОбмена.ЗарегистрироватьИзменения(УзлыДляРегистрации, ЗаданиеТорговомуПредставителю);
	КонецЕсли;
	
	УстановитьПривилегированныйРежим(Ложь);
КонецПроцедуры

// Обработчик подписки на событие "ПередЗаписьюРегистраСведений".
//
// Параметры:
//  Источник - РегистрСведенийНаборЗаписей.ЦеныНоменклатуры - источник события;
//  Отказ - Булево - отказ от выполнения;
//  Замещение - Булево - признак замещения записей регистра.
//
Процедура ЗарегистрироватьИзмененияРегистраСведенийДляОбменаСМобильнымПриложениемЗаказыКлиентовПередЗаписью(Источник, Отказ, Замещение) Экспорт
	
	Если Источник.ОбменДанными.Загрузка Тогда
		Возврат;
	КонецЕсли;
	
	Если Не ПолучитьФункциональнуюОпцию("ИспользоватьМобильноеПриложение1СЗаказы") Тогда
		Возврат;
	КонецЕсли;
	
	Если Отказ Тогда
		Возврат;
	КонецЕсли;
	
	ЗарегистрироватьИзменения(Источник);
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

Процедура ЗарегистрироватьИзменения(Объект, ЭтоОбъект = Истина)
	
	УстановитьПривилегированныйРежим(Истина);
	
	Исключения = Новый Массив;
	Исключения.Добавить(ПланыОбмена.МобильноеПриложениеЗаказыКлиентов.ЭтотУзел());
	
	Если ЭтоОбъект И Объект.ОбменДанными.Загрузка Тогда
		Исключения.Добавить(Объект.ОбменДанными.Отправитель);
	КонецЕсли;
	
	УзлыДляРегистрации = УзлыДляРегистрации(Исключения);
	
	МобильноеПриложениеЗаказыКлиентовПереопределяемый.ЗарегистрироватьИзмененияДляУзловОбмена(УзлыДляРегистрации, Объект);
КонецПроцедуры

// Возвращает массив узлов плана обмена с учетом исключаемых.
//
// Параметры:
//  Исключения - Массив - массив узлов, для которых регистрацию изменений проводить не надо.
//
// Возвращаемое значение:
//  Массив - массив узлов для регистрации изменений.
//
Функция УзлыДляРегистрации(Исключения)
	
	УстановитьПривилегированныйРежим(Истина);
	
	Запрос = Новый Запрос("ВЫБРАТЬ
	|	МобильноеПриложениеЗаказыКлиентов.Ссылка
	|ИЗ
	|	ПланОбмена.МобильноеПриложениеЗаказыКлиентов КАК МобильноеПриложениеЗаказыКлиентов
	|ГДЕ
	|	НЕ МобильноеПриложениеЗаказыКлиентов.ПометкаУдаления
	|	И НЕ МобильноеПриложениеЗаказыКлиентов.Ссылка В (&МассивИсключений)");
	
	Запрос.УстановитьПараметр("МассивИсключений", Исключения);
	
	Возврат Запрос.Выполнить().Выгрузить().ВыгрузитьКолонку("Ссылка");
КонецФункции

// Возвращает массив узлов плана обмена по торговому представителю.
//
// Параметры:
//  ТорговыйПредставитель - СправочникСсылка.Пользователи - торговый представитель, по которому надо найти узлы.
//
// Возвращаемое значение:
//  Массив - массив узлов для регистрации изменений.
//
Функция УзлыДляРегистрацииЗаданий(ТорговыйПредставитель)
	
	УстановитьПривилегированныйРежим(Истина);
	
	Запрос = Новый Запрос("ВЫБРАТЬ
	|	МобильноеПриложениеЗаказыКлиентов.Ссылка
	|ИЗ
	|	ПланОбмена.МобильноеПриложениеЗаказыКлиентов КАК МобильноеПриложениеЗаказыКлиентов
	|ГДЕ
	|	НЕ МобильноеПриложениеЗаказыКлиентов.ПометкаУдаления
	|	И МобильноеПриложениеЗаказыКлиентов.Пользователь = &ТорговыйПредставитель");
	
	Запрос.УстановитьПараметр("ТорговыйПредставитель", ТорговыйПредставитель);
	
	Возврат Запрос.Выполнить().Выгрузить().ВыгрузитьКолонку("Ссылка");
КонецФункции

#КонецОбласти
