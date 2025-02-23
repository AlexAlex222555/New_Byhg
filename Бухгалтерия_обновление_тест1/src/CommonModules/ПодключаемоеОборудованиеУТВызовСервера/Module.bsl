
#Область ПрограммныйИнтерфейс

// Получить оборудование подключенное к терминалу.
//
// Параметры:
//  ЭквайринговыйТерминал - СправочникСсылка.ЭквайринговыеТерминалы - Эквайринговый терминал.
// 
// Возвращаемое значение:
//  Структура - Структура по свойствами:
//   * Терминал - Неопределено, СправочникСсылка.ПодключаемоеОборудование - Терминал.
//   * ККТ - Неопределено, СправочникСсылка.ПодключаемоеОборудование - ККТ.
//
Функция ОборудованиеПодключенноеКТерминалу(ЭквайринговыйТерминал) Экспорт
	
	Запрос = Новый Запрос(
	"ВЫБРАТЬ
	|	Т.Ссылка КАК Ссылка
	|ПОМЕСТИТЬ НастройкаРМК
	|ИЗ
	|	Справочник.НастройкиРМК КАК Т
	|ГДЕ
	|	Т.РабочееМесто = &РабочееМесто
	|
	|;
	|ВЫБРАТЬ ПЕРВЫЕ 1
	|	ЭквайринговыеТерминалы.ПодключаемоеОборудование               КАК Терминал,
	|	ЭквайринговыеТерминалы.ИспользоватьБезПодключенияОборудования КАК ИспользоватьБезПодключенияОборудования,
	|	ЭквайринговыеТерминалы.ПодключаемоеОборудованиеККТ            КАК ККТ
	|ИЗ
	|	Справочник.НастройкиРМК.ЭквайринговыеТерминалы КАК ЭквайринговыеТерминалы
	|		ВНУТРЕННЕЕ СОЕДИНЕНИЕ НастройкаРМК КАК НастройкаРМК
	|		ПО НастройкаРМК.Ссылка = ЭквайринговыеТерминалы.Ссылка
	|ГДЕ
	|	ЭквайринговыеТерминалы.ЭквайринговыйТерминал = &ЭквайринговыйТерминал");
	
	Запрос.УстановитьПараметр("РабочееМесто",          МенеджерОборудованияВызовСервера.ПолучитьРабочееМестоКлиента());
	Запрос.УстановитьПараметр("ЭквайринговыйТерминал", ЭквайринговыйТерминал);
	
	ВозвращаемоеЗначение = СтруктураПодключенноеОборудование();
	
	Выборка = Запрос.Выполнить().Выбрать();
	Если Выборка.Следующий() Тогда
		
		ЗаполнитьЗначенияСвойств(ВозвращаемоеЗначение, Выборка);
		Если Выборка.ИспользоватьБезПодключенияОборудования Тогда
			ВозвращаемоеЗначение.Терминал = Неопределено;
		КонецЕсли;
		
	КонецЕсли;
	
	Возврат ВозвращаемоеЗначение;
	
КонецФункции

// Получить оборудование подключенное к кассе.
//
// Параметры:
//  Касса - СправочникСсылка.Кассы - Касса.
// 
// Возвращаемое значение:
//  Структура - Структура по свойствами:
//   * Терминал - Неопределено, СправочникСсылка.ПодключаемоеОборудование - Данные подключенному термиралу
//   * ККТ - Неопределено, СправочникСсылка.ПодключаемоеОборудование - ККТ.
//
Функция ОборудованиеПодключенноеККассе(Касса) Экспорт
	
	Запрос = Новый Запрос(
	"ВЫБРАТЬ
	|	Т.Ссылка КАК Ссылка
	|ПОМЕСТИТЬ НастройкаРМК
	|ИЗ
	|	Справочник.НастройкиРМК КАК Т
	|ГДЕ
	|	Т.РабочееМесто = &РабочееМесто
	|
	|;
	|ВЫБРАТЬ ПЕРВЫЕ 1
	|	Кассы.ПодключаемоеОборудование КАК ККТ
	|ИЗ
	|	Справочник.НастройкиРМК.Кассы КАК Кассы
	|		ВНУТРЕННЕЕ СОЕДИНЕНИЕ НастройкаРМК КАК НастройкаРМК
	|		ПО НастройкаРМК.Ссылка = Кассы.Ссылка
	|ГДЕ
	|	Кассы.Касса = &Касса");
	
	Запрос.УстановитьПараметр("РабочееМесто", МенеджерОборудованияВызовСервера.ПолучитьРабочееМестоКлиента());
	Запрос.УстановитьПараметр("Касса",        Касса);
	
	ВозвращаемоеЗначение = СтруктураПодключенноеОборудование();
	
	Выборка = Запрос.Выполнить().Выбрать();
	Если Выборка.Следующий() Тогда
		ЗаполнитьЗначенияСвойств(ВозвращаемоеЗначение, Выборка);
	КонецЕсли;
	
	Возврат ВозвращаемоеЗначение;
	
КонецФункции

// Получить оборудование подключенное к кассе ККМ.
//
// Параметры:
//  КассаККМ - СправочникСсылка.КассыККМ - Касса ККМ.
// 
// Возвращаемое значение:
//  Структура - Структура по свойствами:
//   * Терминал - Неопределено, СправочникСсылка.ПодключаемоеОборудование - Данные подключенному термиралу
//   * ККТ - Массив Из СправочникСсылка.ПодключаемоеОборудование - ККТ
//
Функция ОборудованиеПодключенноеККассеККМ(КассаККМ) Экспорт
	
	Запрос = Новый Запрос(
	"ВЫБРАТЬ
	|	Т.Ссылка КАК Ссылка
	|ПОМЕСТИТЬ НастройкаРМК
	|ИЗ
	|	Справочник.НастройкиРМК КАК Т
	|ГДЕ
	|	Т.РабочееМесто = &РабочееМесто
	|
	|;
	|ВЫБРАТЬ ПЕРВЫЕ 1
	|	КассыККМ.ПодключаемоеОборудование КАК ККТ
	|ИЗ
	|	Справочник.НастройкиРМК.КассыККМ КАК КассыККМ
	|		ВНУТРЕННЕЕ СОЕДИНЕНИЕ НастройкаРМК КАК НастройкаРМК
	|		ПО НастройкаРМК.Ссылка = КассыККМ.Ссылка
	|ГДЕ
	|	НЕ КассыККМ.ИспользоватьБезПодключенияОборудования
	|	И КассыККМ.КассаККМ = &КассаККМ");
	
	Запрос.УстановитьПараметр("РабочееМесто", МенеджерОборудованияВызовСервера.ПолучитьРабочееМестоКлиента());
	Запрос.УстановитьПараметр("КассаККМ",     КассаККМ);
	
	ВозвращаемоеЗначение = СтруктураПодключенноеОборудование();
	
	Выборка = Запрос.Выполнить().Выбрать();
	Если Выборка.Следующий() Тогда
		ЗаполнитьЗначенияСвойств(ВозвращаемоеЗначение, Выборка);
	КонецЕсли;
	
	Возврат ВозвращаемоеЗначение;
	
КонецФункции

// Получить оборудование подключенное по организации.
//
// Параметры:
//  Организация - ОпределяемыйТип.ОрганизацияБПО - Организация.
// 
// Возвращаемое значение:
//  Структура - Структура по свойствами:
//   * Терминал - Неопределено, СправочникСсылка.ПодключаемоеОборудование - Данные подключенному термиралу
//   * ККТ - Массив Из СправочникСсылка.ПодключаемоеОборудование - ККТ
//
Функция ОборудованиеПодключенноеПоОрганизации(Организация) Экспорт
	
	Запрос = Новый Запрос(
	"ВЫБРАТЬ
	|	ПодключаемоеОборудование.Ссылка КАК ККТ
	|ИЗ
	|	Справочник.ПодключаемоеОборудование КАК ПодключаемоеОборудование
	|ГДЕ
	|	ПодключаемоеОборудование.Организация = &Организация
	|	И НЕ ПодключаемоеОборудование.ПометкаУдаления
	|	И ПодключаемоеОборудование.УстройствоИспользуется
	|	И ПодключаемоеОборудование.РабочееМесто = &РабочееМесто");
	
	Запрос.УстановитьПараметр("РабочееМесто", МенеджерОборудованияВызовСервера.ПолучитьРабочееМестоКлиента());
	Запрос.УстановитьПараметр("Организация",  Организация);
	
	СписокККТ = Новый Массив();
	
	Выборка = Запрос.Выполнить().Выбрать();
	Пока Выборка.Следующий() Цикл
		СписокККТ.Добавить(Выборка.ККТ);
	КонецЦикла;
	
	ВозвращаемоеЗначение = СтруктураПодключенноеОборудование();
	ВозвращаемоеЗначение.ККТ = СписокККТ;
	
	Возврат ВозвращаемоеЗначение;
	
КонецФункции


#КонецОбласти

#Область СлужебныеПроцедурыИФункции

// Служебная структура "подключенное оборудование"
// 
// Возвращаемое значение:
//  Структура - с полями:
//   * ККТ - Массив Из СправочникСсылка.ПодключаемоеОборудование - ККТ
//   * Терминал - Неопределено, СправочникСсылка.ПодключаемоеОборудование - Данные подключенному термиралу
//
Функция СтруктураПодключенноеОборудование()
	
	Результат = Новый Структура;
	Результат.Вставить("Терминал");
	Результат.Вставить("ККТ");
	Возврат Результат;
	
КонецФункции

Процедура ЗаполнитьМассивПодключенногоОборудованияПоОрганизации(ОборудованиеВзаимодействующееОнлайнС1С, ОборудованиеПодключенноеПоОрганизации)
	
	Для Каждого ФискальноеОборудование Из ОборудованиеПодключенноеПоОрганизации.ККТ Цикл
		ДобавитьВМассивФискальноеОборудованиеВзаимодействующееОнлайнС1С(ОборудованиеВзаимодействующееОнлайнС1С, ФискальноеОборудование);
	КонецЦикла;
	
КонецПроцедуры

Процедура ЗаполнитьМассивПодключенногоОборудованияПоТорговомуОбъекту(ОборудованиеВзаимодействующееОнлайнС1С, ОборудованиеПоТорговомуОбъекту)
	
	Если ТипЗнч(ОборудованиеПоТорговомуОбъекту) = Тип("Структура")
		И ОборудованиеПоТорговомуОбъекту.Свойство("ККТ")
		И ОборудованиеПоТорговомуОбъекту.ККТ <> Неопределено Тогда
		
		ДобавитьВМассивФискальноеОборудованиеВзаимодействующееОнлайнС1С(ОборудованиеВзаимодействующееОнлайнС1С, ОборудованиеПоТорговомуОбъекту.ККТ);
	КонецЕсли;
	
КонецПроцедуры

Процедура ДобавитьВМассивФискальноеОборудованиеВзаимодействующееОнлайнС1С(ОборудованиеВзаимодействующееОнлайнС1С, ФискальноеОборудование)
	
	ТипОборудования = ОбщегоНазначения.ЗначениеРеквизитаОбъекта(ФискальноеОборудование, "ТипОборудования");
		
	Если ТипОборудования = Перечисления.ТипыПодключаемогоОборудования.ПринтерЧеков
		ИЛИ ТипОборудования = Перечисления.ТипыПодключаемогоОборудования.ФискальныйРегистратор
		ИЛИ ТипОборудования = Перечисления.ТипыПодключаемогоОборудования.ККТ Тогда
		
		ОборудованиеВзаимодействующееОнлайнС1С.Добавить(ФискальноеОборудование);
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти
