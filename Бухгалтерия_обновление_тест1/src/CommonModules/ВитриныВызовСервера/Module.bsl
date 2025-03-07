
#Область СлужебныйПрограммныйИнтерфейс

Процедура ПриНачалеРаботыСистемы() Экспорт
	
	Если НЕ РаботаВМоделиСервиса.ИспользованиеРазделителяСеанса() Тогда
		Возврат;
	КонецЕсли;
	
	ЗаписьЖурналаРегистрации(
		ИмяСобытияЖурналаРегистрации(), 
		УровеньЖурналаРегистрации.Информация, , 
		ПолучитьНавигационнуюСсылкуИнформационнойБазы());
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

Функция ИмяСобытияЖурналаРегистрации()
	
	Возврат НСтр("ru='Технология Hmara.BAS.Начало сеанса области данных';uk='Технологія Hmara.BAS.Начало сеансу області даних'",ОбщегоНазначения.КодОсновногоЯзыка());	
	
КонецФункции

#КонецОбласти
