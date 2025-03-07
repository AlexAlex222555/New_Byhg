///////////////////////////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2020
// Все права защищены. Эта программа и сопроводительные материалы предоставляются 
// в соответствии с условиями лицензии Attribution 4.0 International (CC BY 4.0)
// Текст лицензии доступен по ссылке:
// https://creativecommons.org/licenses/by/4.0/legalcode
///////////////////////////////////////////////////////////////////////////////////////////////////////

#Область ПрограммныйИнтерфейс

// Определение настроек отображения информации при запуске.
//
// Параметры:
//   Настройки - Структура - Настройки подсистемы.
//       * Показывать - Булево - Показывать ли информацию в текущем сеансе.
//           Истина - Информация будет показана после входа в программу.
//           Ложь - Информация не будет показана.
//
Процедура ОпределитьНастройки(Настройки) Экспорт
	
	//++ НЕ БЗК
	Если НЕ ПолучитьФункциональнуюОпцию("УправлениеТорговлей") Тогда
		Настройки.Показывать = Ложь;
	КонецЕсли; 
	//-- НЕ БЗК
	
КонецПроцедуры

#КонецОбласти
