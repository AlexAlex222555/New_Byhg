///////////////////////////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2018
// Все права защищены. Эта программа и сопроводительные материалы предоставляются 
// в соответствии с условиями лицензии Attribution 4.0 International (CC BY 4.0)
// Текст лицензии доступен по ссылке:
// https://creativecommons.org/licenses/by/4.0/legalcode
///////////////////////////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
// Подсистема "Получение обновлений программы".
// ОбщийМодуль.ПолучениеОбновленийПрограммыПереопределяемый.
//
////////////////////////////////////////////////////////////////////////////////

#Область ПрограммныйИнтерфейс

// Определяет параметры функциональности получения обновлений программы.
//
// Параметры:
//	ПараметрыПолученияОбновлений - Структура - параметры получения обновлений:
//		* ПолучатьОбновленияКонфигурации - Булево - задействовать функциональность
//			получения обновлений конфигурации в сценарии рабочего
//			обновления программы. В сценариях перехода на новую редакцию конфигурации
//			или новую конфигурацию получение обновления конфигурации используется всегда.
//			Значение параметра по умолчанию - Истина;
//		* ПолучатьИсправления - Булево - задействовать функциональность получения
//			исправлений конфигурации.
//			Значение параметра по умолчанию - Истина;
//		* ВыбиратьКаталогСохраненияДистрибутиваПлатформы - Булево - предлагать в не базовой
//			версии конфигурации сохранять дистрибутив платформы BAF в каталог
//			на диске или локальной сети. В базовой версии настройка не используется, дистрибутив
//			платформы BAF сохраняется в каталог по умолчанию.
//			Значение параметра по умолчанию - Истина;
//
Процедура ПриОпределенииПараметровПолученияОбновлений(ПараметрыПолученияОбновлений) Экспорт
	
	
	
КонецПроцедуры

#КонецОбласти
