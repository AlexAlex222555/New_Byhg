////////////////////////////////////////////////////////////////////////////////
// Процедуры, используемые для локализации документа "Списание НМА".
// 
////////////////////////////////////////////////////////////////////////////////

#Область СлужебныйПрограммныйИнтерфейс

Процедура ПослеЗаписи(Объект) Экспорт

	//++ Локализация
	//-- Локализация
	
КонецПроцедуры
 
// 
// Параметры:
// 	ИмяЭлемента - Строка
// 	Форма - ФормаКлиентскогоПриложения - 
// 	ДополнительныеПараметры - Структура - 
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

#Область СлужебныеПроцедурыИФункции

//++ Локализация
//-- Локализация

#КонецОбласти
