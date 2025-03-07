///////////////////////////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2020
// Все права защищены. Эта программа и сопроводительные материалы предоставляются 
// в соответствии с условиями лицензии Attribution 4.0 International (CC BY 4.0)
// Текст лицензии доступен по ссылке:
// https://creativecommons.org/licenses/by/4.0/legalcode
///////////////////////////////////////////////////////////////////////////////////////////////////////

#Область СлужебныеПроцедурыИФункции

Функция ОпределитьТипФормы(ИмяФормы) Экспорт
	
	Возврат МультиязычностьСервер.ОпределитьТипФормы(ИмяФормы);
	
КонецФункции

Функция КонфигурацияИспользуетТолькоОдинЯзык(ПредставленияВТабличнойЧасти) Экспорт
	
	Если Метаданные.Языки.Количество() = 1 Тогда
		Возврат Истина;
	КонецЕсли;
	
	Если ПредставленияВТабличнойЧасти Тогда
		Возврат Ложь;
	КонецЕсли;
	
	Если МультиязычностьСервер.ИспользуетсяПервыйДополнительныйЯзык()
		Или МультиязычностьСервер.ИспользуетсяПервыйДополнительныйЯзык() Тогда
		Возврат Ложь;
	КонецЕсли;
	
	Возврат Истина;
	
КонецФункции

Функция ОбъектНеСодержитТЧПредставления(Ссылка) Экспорт
	
	Возврат Ссылка.Метаданные().ТабличныеЧасти.Найти("Представления") = Неопределено;
	
КонецФункции

#КонецОбласти

