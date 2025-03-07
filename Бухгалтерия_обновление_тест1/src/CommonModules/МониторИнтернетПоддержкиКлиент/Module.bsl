///////////////////////////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2019
// Все права защищены. Эта программа и сопроводительные материалы предоставляются 
// в соответствии с условиями лицензии Attribution 4.0 International (CC BY 4.0)
// Текст лицензии доступен по ссылке:
// https://creativecommons.org/licenses/by/4.0/legalcode
///////////////////////////////////////////////////////////////////////////////////////////////////////

#Область ПрограммныйИнтерфейс

// Обработчик команды БИПМониторПортала1СИТС
// на форме панели администрирования "Интернет-поддержка и сервисы"
// Библиотеки стандартных подсистем.
//
// Параметры:
//	Форма - ФормаКлиентскогоПриложения - форма панели администрирования;
//	Команда - КомандаФормы - команда на панели администрирования.
//
Процедура ИнтернетПоддержкаИСервисы_МониторИнтернетПоддержки(Форма, Команда) Экспорт
	
	МониторПортала1СИТСКлиент.ИнтернетПоддержкаИСервисы_МониторПортала1СИТС(Форма, Команда);
	
КонецПроцедуры

#КонецОбласти
