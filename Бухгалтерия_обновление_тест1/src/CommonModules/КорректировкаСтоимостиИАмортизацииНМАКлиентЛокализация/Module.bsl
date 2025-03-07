////////////////////////////////////////////////////////////////////////////////
// Процедуры, используемые для локализации документа "Корректировка стоимости и амортизации НМА".
// 
////////////////////////////////////////////////////////////////////////////////

#Область СлужебныйПрограммныйИнтерфейс

#Область ФормаДокумента

// 
// Параметры:
// 	Элемент - ПолеФормы - 
// 	Форма - ФормаКлиентскогоПриложения - 
Процедура ПриИзмененииРеквизита(Элемент, Форма) Экспорт

	ДополнительныеПараметры = Неопределено;
	ТребуетсяВызовСервера = Ложь;
	ПродолжитьИзменениеРеквизита = Истина;
	
	//++ Локализация
	//-- Локализация
	
	Если ПродолжитьИзменениеРеквизита Тогда
		
		ОбщегоНазначенияУТКлиент.ПродолжитьИзменениеРеквизита(
			Форма, 
			Элемент.Имя, 
			ТребуетсяВызовСервера,
			ДополнительныеПараметры);
	
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#КонецОбласти
