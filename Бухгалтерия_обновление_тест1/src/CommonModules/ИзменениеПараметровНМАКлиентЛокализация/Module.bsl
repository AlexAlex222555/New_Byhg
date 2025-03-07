////////////////////////////////////////////////////////////////////////////////
// Процедуры, используемые для локализации документа "Изменение параметров НМА".
// 
////////////////////////////////////////////////////////////////////////////////

#Область СлужебныеПроцедурыИФункции

// Параметры:
// 	ИмяЭлемента - Строка - 
// 	Форма - ФормаКлиентскогоПриложения -
//  ДополнительныеПараметры - Структура - 
Процедура ПриИзмененииРеквизита(ИмяЭлемента, Форма, ДополнительныеПараметры = Неопределено) Экспорт
	
	ТребуетсяВызовСервера = Ложь;
	ПродолжитьИзменениеРеквизита = Истина;
	
	//++ Локализация
	//-- Локализация
	
	Если ПродолжитьИзменениеРеквизита Тогда
		
		ОбщегоНазначенияУТКлиент.ПродолжитьИзменениеРеквизита(
			Форма, 
			ИмяЭлемента, 
			ТребуетсяВызовСервера,
			ДополнительныеПараметры);
			
	КонецЕсли; 
	
КонецПроцедуры

#КонецОбласти