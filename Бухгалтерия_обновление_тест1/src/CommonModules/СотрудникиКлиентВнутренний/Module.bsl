////////////////////////////////////////////////////////////////////////////////
// СотрудникиВнутреннийКлиент: методы, обслуживающие работу формы сотрудника.
//  
////////////////////////////////////////////////////////////////////////////////

#Область СлужебныеПроцедурыИФункции

Процедура СотрудникиОбработкаОповещения(Форма, ИмяСобытия, Параметр, Источник) Экспорт
	
	СотрудникиКлиентРасширенный.СотрудникиОбработкаОповещения(Форма, ИмяСобытия, Параметр, Источник);
	
КонецПроцедуры

Процедура СотрудникиПередЗаписью(Форма, Отказ, ПараметрыЗаписи, ОповещениеЗавершения = Неопределено, ЗакрытьПослеЗаписи = Истина) Экспорт
	
	СотрудникиКлиентРасширенный.СотрудникиПередЗаписью(Форма, Отказ, ПараметрыЗаписи, ОповещениеЗавершения, ЗакрытьПослеЗаписи);
	
КонецПроцедуры

Процедура ФизическиеЛицаПередЗаписью(Форма, Отказ, ПараметрыЗаписи, ОповещениеЗавершения = Неопределено, ЗакрытьПослеЗаписи = Истина) Экспорт
	
	СотрудникиКлиентРасширенный.ФизическиеЛицаПередЗаписью(Форма, Отказ, ПараметрыЗаписи, ОповещениеЗавершения, ЗакрытьПослеЗаписи);
	
КонецПроцедуры

Процедура ФизическиеЛицаОбработкаОповещения(Форма, ИмяСобытия, Параметр, Источник) Экспорт
	
	СотрудникиКлиентРасширенный.ФизическиеЛицаОбработкаОповещения(Форма, ИмяСобытия, Параметр, Источник);
	
КонецПроцедуры

Процедура ФизическиеЛицаКодПоДРФОПриИзменении(Форма, Элемент) Экспорт	
	
	СотрудникиКлиентРасширенный.ФизическиеЛицаКодПоДРФОПриИзменении(Форма, Элемент);
	
КонецПроцедуры


Процедура ДокументыФизическихЛицВидДокументаПриИзменении(Форма) Экспорт
	
	СотрудникиКлиентРасширенный.ДокументыФизическихЛицВидДокументаПриИзменении(Форма);
	
КонецПроцедуры

Процедура ДокументыФизическихЛицСерияПриИзменении(Форма, Элемент) Экспорт
	
	СотрудникиКлиентРасширенный.ДокументыФизическихЛицСерияПриИзменении(Форма, Элемент);
	
КонецПроцедуры

Процедура ДокументыФизическихЛицНомерПриИзменении(Форма, Элемент) Экспорт
	
	СотрудникиКлиентРасширенный.ДокументыФизическихЛицНомерПриИзменении(Форма, Элемент);
	
КонецПроцедуры

#КонецОбласти
