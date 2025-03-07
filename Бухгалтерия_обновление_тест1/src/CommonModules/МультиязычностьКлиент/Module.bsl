///////////////////////////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2020
// Все права защищены. Эта программа и сопроводительные материалы предоставляются 
// в соответствии с условиями лицензии Attribution 4.0 International (CC BY 4.0)
// Текст лицензии доступен по ссылке:
// https://creativecommons.org/licenses/by/4.0/legalcode
///////////////////////////////////////////////////////////////////////////////////////////////////////

#Область ПрограммныйИнтерфейс

// Обработчик события ПриОткрытии поля ввода формы для открытия формы ввода значения реквизита на разных языках.
//
// Параметры:
//  Форма   - ФормаКлиентскогоПриложения - форма содержащая мультиязычные реквизиты.
//  Объект  - ДанныеФормыСтруктура - объект на форме:
//   * Ссылка - ЛюбаяСсылка - 
//  Элемент - ПолеФормы - Элемент формы, для которого будет открыта форма ввода на разных языках.
//  СтандартнаяОбработка - Булево - Признак выполнения стандартной (системной) обработки события.
//
Процедура ПриОткрытии(Форма, Объект, Элемент, СтандартнаяОбработка) Экспорт
	
	СтандартнаяОбработка = Ложь;
	ПутьКДанным = Форма.ПараметрыМультиязычныхРеквизитов[Элемент.Имя];
	ИмяРеквизита = СтрЗаменить(ПутьКДанным, "Объект.", "");
	
	ПараметрыФормы = Новый Структура;
	ПараметрыФормы.Вставить("Ссылка",          Объект.Ссылка);
	ПараметрыФормы.Вставить("ИмяРеквизита",    ИмяРеквизита);
	ПараметрыФормы.Вставить("ТекущиеЗначение", Элемент.ТекстРедактирования);
	ПараметрыФормы.Вставить("ТолькоПросмотр",  Элемент.ТолькоПросмотр);
	
	Если Объект.Свойство("Представления") Тогда
		ПараметрыФормы.Вставить("Представления", Объект.Представления);
	Иначе
		Представления = Новый Структура();
		
		Представления.Вставить(ИмяРеквизита, Объект[ИмяРеквизита]);
		Представления.Вставить(ИмяРеквизита + "Язык1", Объект[ИмяРеквизита + "Язык1"]);
		Представления.Вставить(ИмяРеквизита + "Язык2", Объект[ИмяРеквизита + "Язык2"]);
		
		ПараметрыФормы.Вставить("ЗначенияРеквизитов", Представления);
		
	КонецЕсли;
	
	ДополнительныеПараметры = Новый Структура;
	ДополнительныеПараметры.Вставить("Объект", Объект);
	ДополнительныеПараметры.Вставить("ИмяРеквизита", ИмяРеквизита);
	
	Оповещение = Новый ОписаниеОповещения("ПослеВводаСтрокНаРазныхЯзыках", МультиязычностьКлиент, ДополнительныеПараметры);
	ОткрытьФорму("ОбщаяФорма.ВводНаРазныхЯзыках", ПараметрыФормы,,,,, Оповещение);
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

Процедура ПослеВводаСтрокНаРазныхЯзыках(Результат, ДополнительныеПараметры) Экспорт
	
	Если ТипЗнч(Результат) <> Тип("Структура") Тогда
		Возврат;
	КонецЕсли;
	
	Объект = ДополнительныеПараметры.Объект;
	Если Результат.ХранениеВТабличнойЧасти Тогда
		
		Для каждого Представление Из Результат.ЗначенияНаРазныхЯзыках Цикл
			Отбор = Новый Структура("КодЯзыка", Представление.КодЯзыка);
			НайденныеСтроки = Объект.Представления.НайтиСтроки(Отбор);
			Если НайденныеСтроки.Количество() > 0 Тогда
				Если ПустаяСтрока(Представление.ЗначениеРеквизита) 
					И СтрСравнить(Результат.ОсновнойЯзык, Представление.КодЯзыка) <> 0 Тогда
						Объект.Представления.Удалить(НайденныеСтроки[0]);
					Продолжить;
				КонецЕсли;
				СтрокаПредставлений = НайденныеСтроки[0];
			Иначе
				СтрокаПредставлений = Объект.Представления.Добавить();
				СтрокаПредставлений.КодЯзыка = Представление.КодЯзыка;
			КонецЕсли;
			СтрокаПредставлений[ДополнительныеПараметры.ИмяРеквизита] = Представление.ЗначениеРеквизита;
			
		КонецЦикла;
		
	Иначе
		
		Для каждого Представление Из Результат.ЗначенияНаРазныхЯзыках Цикл
			Объект[ДополнительныеПараметры.ИмяРеквизита + Представление.Суффикс]= Представление.ЗначениеРеквизита;
		КонецЦикла;
		
	КонецЕсли;
	
	Если Результат.Свойство("СтрокаНаТекущемЯзыке") Тогда
		Объект[ДополнительныеПараметры.ИмяРеквизита] = Результат.СтрокаНаТекущемЯзыке;
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти
