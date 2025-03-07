
#Область ПрограммныйИнтерфейс

//++ НЕ УТ
#Область ОбменУправлениеПредприятиемДокументооборот

// Процедура-обработчик события "ПередЗаписью" ссылочных типов данных (кроме документов) для механизма регистрации объектов на узлах.
//
// Параметры:
//  Источник       - источник события, кроме типа ДокументОбъект
//  Отказ          - Булево - флаг отказа от выполнения обработчика.
// 
Процедура ОбменДаннымиОбменУправлениеПредприятиемДокументооборотПередЗаписью(Источник, Отказ) Экспорт
	
	ОбменДаннымиСобытия.МеханизмРегистрацииОбъектовПередЗаписью("ОбменУправлениеПредприятиемДокументооборот", Источник, Отказ);
	
КонецПроцедуры

// Процедура-обработчик события "ПередЗаписью" документов для механизма регистрации объектов на узлах.
//
// Параметры:
//  Источник        - ДокументОбъект - источник события.
//  Отказ           - Булево - флаг отказа от выполнения обработчика.
//  РежимЗаписи     - РежимЗаписиДокумента - см. в синтаксис-помощнике РежимЗаписиДокумента.
//  РежимПроведения - РежимПроведенияДокумента - см. в синтаксис-помощнике РежимПроведенияДокумента.
// 
Процедура ОбменДаннымиОбменУправлениеПредприятиемДокументооборотПередЗаписьюДокумента(Источник, Отказ, РежимЗаписи, РежимПроведения) Экспорт
	
	ОбменДаннымиСобытия.МеханизмРегистрацииОбъектовПередЗаписьюДокумента("ОбменУправлениеПредприятиемДокументооборот", Источник, Отказ, РежимЗаписи, РежимПроведения);
	
КонецПроцедуры

// Процедура-обработчик события "ПередУдалением" ссылочных типов данных для механизма регистрации объектов на узлах.
//
// Параметры:
//  Источник       - источник события
//  Отказ          - Булево - флаг отказа от выполнения обработчика.
// 
Процедура ОбменДаннымиОбменУправлениеПредприятиемДокументооборотПередУдалением(Источник, Отказ) Экспорт
	
	ОбменДаннымиСобытия.МеханизмРегистрацииОбъектовПередУдалением("ОбменУправлениеПредприятиемДокументооборот", Источник, Отказ);
	
КонецПроцедуры

// Процедура-обработчик события "ПередЗаписью" регистров для механизма регистрации объектов на узлах.
//
// Параметры:
//  Источник       - НаборЗаписейРегистра - источник события
//  Отказ          - Булево - флаг отказа от выполнения обработчика
//  Замещение      - Булево - признак замещения существующего набора записей.
// 
Процедура ОбменДаннымиОбменУправлениеПредприятиемДокументооборотПередЗаписьюРегистра(Источник, Отказ, Замещение) Экспорт
	
	ОбменДаннымиСобытия.МеханизмРегистрацииОбъектовПередЗаписьюРегистра("ОбменУправлениеПредприятиемДокументооборот", Источник, Отказ, Замещение);
	
КонецПроцедуры

#КонецОбласти 
//-- НЕ УТ

#КонецОбласти
