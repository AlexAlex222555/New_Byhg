///////////////////////////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2020
// Все права защищены. Эта программа и сопроводительные материалы предоставляются 
// в соответствии с условиями лицензии Attribution 4.0 International (CC BY 4.0)
// Текст лицензии доступен по ссылке:
// https://creativecommons.org/licenses/by/4.0/legalcode
///////////////////////////////////////////////////////////////////////////////////////////////////////

#Область ПрограммныйИнтерфейс

// Вызывается при нажатии на гиперссылку или двойном щелчке на ячейке 
// табличного документа с описанием изменений системы (общий макет ОписаниеИзмененийСистемы).
//
// Параметры:
//   Область - ОбластьЯчеекТабличногоДокумента - область документа, на 
//             которой произошло нажатие.
//
Процедура ПриНажатииНаГиперссылкуВДокументеОписанияОбновлений(Знач Область) Экспорт
	
	Если СтрНайти(Область.Текст, "http://") > 0 Или СтрНайти(Область.Текст, "https://") > 0 Тогда
		ТекстСсылки = СокрЛП(Область.Текст);
		ПозХТТП = СтрНайти(ТекстСсылки, "http");
		ТекстСсылки = Сред(ТекстСсылки, ПозХТТП);		
		Если СтрЗаканчиваетсяНа(ТекстСсылки, ".") Тогда
			ТекстСсылки = Лев(ТекстСсылки, СтрДлина(ТекстСсылки) - 1);
		КонецЕсли;
		ПерейтиПоНавигационнойСсылке(ТекстСсылки);
	КонецЕсли;

КонецПроцедуры

// Вызывается в обработчике ПередНачаломРаботыСистемы, проверяет возможность
// обновления на текущую версию программы.
//
// Параметры:
//  ВерсияДанных - Строка - версия данных основной конфигурации, с которой выполняется обновление
//                          (из регистра сведений ВерсииПодсистем).
//
Процедура ПриОпределенииВозможностиОбновления(Знач ВерсияДанных) Экспорт
	
	//++ НЕ ГОСИС
	ОбщегоНазначенияУТКлиент.ПриОпределенииВозможностиОбновления();
	//-- НЕ ГОСИС
	
КонецПроцедуры

#КонецОбласти
