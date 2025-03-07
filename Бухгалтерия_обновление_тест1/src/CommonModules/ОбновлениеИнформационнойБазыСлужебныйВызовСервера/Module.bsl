///////////////////////////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2020
// Все права защищены. Эта программа и сопроводительные материалы предоставляются 
// в соответствии с условиями лицензии Attribution 4.0 International (CC BY 4.0)
// Текст лицензии доступен по ссылке:
// https://creativecommons.org/licenses/by/4.0/legalcode
///////////////////////////////////////////////////////////////////////////////////////////////////////

#Область СлужебныеПроцедурыИФункции

// См. описание этой же функции в модуле ОбновлениеИнформационнойБазыСлужебный.
Функция ВыполнитьОбновлениеИнформационнойБазы(ПриЗапускеКлиентскогоПриложения = Ложь, Перезапустить = Ложь, ВыполнятьОтложенныеОбработчики = Ложь) Экспорт
	
	ПараметрыОбновления = ОбновлениеИнформационнойБазыСлужебный.ПараметрыОбновления();
	ПараметрыОбновления.ПриЗапускеКлиентскогоПриложения = ПриЗапускеКлиентскогоПриложения;
	ПараметрыОбновления.Перезапустить = Перезапустить;
	ПараметрыОбновления.ВыполнятьОтложенныеОбработчики = ВыполнятьОтложенныеОбработчики;
	
	Попытка
		Результат = ОбновлениеИнформационнойБазыСлужебный.ВыполнитьОбновлениеИнформационнойБазы(ПараметрыОбновления);
	Исключение
		// Переход в режим открытия формы повторной синхронизации данных перед запуском
		// с двумя вариантами "Синхронизировать и продолжить" и "Продолжить".
		Если ОбщегоНазначения.ПодсистемаСуществует("СтандартныеПодсистемы.ОбменДанными")
		   И ОбщегоНазначения.ЭтоПодчиненныйУзелРИБ() Тогда
			МодульОбменДаннымиСервер = ОбщегоНазначения.ОбщийМодуль("ОбменДаннымиСервер");
			МодульОбменДаннымиСервер.ВключитьПовторениеЗагрузкиСообщенияОбменаДаннымиПередЗапуском();
		КонецЕсли;
		ВызватьИсключение;
	КонецПопытки;
	
	Перезапустить = ПараметрыОбновления.Перезапустить;
	Возврат Результат;
	
КонецФункции

// Снимает блокировку информационной файловой базы.
Процедура СнятьБлокировкуФайловойБазы() Экспорт
	
	Если Не ОбщегоНазначения.ИнформационнаяБазаФайловая() Тогда
		Возврат;
	КонецЕсли;
	
	Если ОбщегоНазначения.ПодсистемаСуществует("СтандартныеПодсистемы.ЗавершениеРаботыПользователей") Тогда
		МодульСоединенияИБ = ОбщегоНазначения.ОбщийМодуль("СоединенияИБ");
		МодульСоединенияИБ.РазрешитьРаботуПользователей();
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти
