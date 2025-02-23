///////////////////////////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2020
// Все права защищены. Эта программа и сопроводительные материалы предоставляются 
// в соответствии с условиями лицензии Attribution 4.0 International (CC BY 4.0)
// Текст лицензии доступен по ссылке:
// https://creativecommons.org/licenses/by/4.0/legalcode
///////////////////////////////////////////////////////////////////////////////////////////////////////

#Область СлужебныйПрограммныйИнтерфейс

////////////////////////////////////////////////////////////////////////////////
// Обработчики событий подсистем конфигурации.

// См. ОбщегоНазначенияКлиентПереопределяемый.ПослеНачалаРаботыСистемы.
Процедура ПослеНачалаРаботыСистемы() Экспорт
	
	ПараметрыКлиента = СтандартныеПодсистемыКлиент.ПараметрыРаботыКлиентаПриЗапуске();
	Если ПараметрыКлиента.Свойство("Валюты") И ПараметрыКлиента.Валюты.КурсыОбновляютсяОтветственными Тогда
		ПодключитьОбработчикОжидания("РаботаСКурсамиВалютВывестиОповещениеОНеактуальности", 15, Истина);
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

////////////////////////////////////////////////////////////////////////////////
// Обновление курсов валют

// Выводит соответствующее оповещение.
//
Процедура ОповеститьКурсыУстарели() Экспорт
	
	ПоказатьОповещениеПользователя(
		НСтр("ru='Курсы валют устарели';uk='Курси валют застаріли'"),
		НавигационнаяСсылкаОбработки(),
		НСтр("ru='Обновить курсы валют';uk='Оновити курси валют'"),
		БиблиотекаКартинок.Предупреждение32);
	
КонецПроцедуры

// Выводит соответствующее оповещение.
//
Процедура ОповеститьКурсыУспешноОбновлены() Экспорт
	
	ПоказатьОповещениеПользователя(
		НСтр("ru='Курсы валют успешно обновлены';uk='Курси валют успішно оновлені'"),
		,
		НСтр("ru='Курсы валют обновлены';uk='Курси валют оновлені'"),
		БиблиотекаКартинок.Информация32);
	
КонецПроцедуры

// Выводит соответствующее оповещение.
//
Процедура ОповеститьКурсыАктуальны() Экспорт
	
	ПоказатьПредупреждение(,НСтр("ru='Курсы валют актуальны.';uk='Курси валют актуальні.'"));
	
КонецПроцедуры

// Возвращает навигационную ссылку для оповещений.
//
Функция НавигационнаяСсылкаОбработки()
	Возврат "e1cib/app/Обработка.НСИСЗагрузкаКурсовВалют";
КонецФункции

#КонецОбласти
