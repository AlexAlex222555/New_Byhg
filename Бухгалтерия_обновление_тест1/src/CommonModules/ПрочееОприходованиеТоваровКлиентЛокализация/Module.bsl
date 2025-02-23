////////////////////////////////////////////////////////////////////////////////
// Процедуры и функции, используемые в документе ПрочееОприходованиеТоваров.
// 
////////////////////////////////////////////////////////////////////////////////

#Область СлужебныйПрограммныйИнтерфейс

Процедура ПриОткрытии(Форма) Экспорт

	//++ Локализация
	Объект = Форма.Объект;
	Элементы = Форма.Элементы;
	
	//++ НЕ УТ
	МассивЭлементов = Новый Массив;
	ЭтоВозвратИзЭксплуатации = Ложь;
	МассивЭлементов.Добавить("ФормаОбработкаОтражениеДокументовВРеглУчетеПроводкиРеглУчета");
	МассивЭлементов.Добавить("ПроверкаДокументов_КомандаИзмененияСтатусаПроверкиДокумента");
	ОбщегоНазначенияУТКлиентСервер.УстановитьСвойствоЭлементовФормы(Элементы, МассивЭлементов, "Видимость", (Не ЭтоВозвратИзЭксплуатации));
	//-- НЕ УТ
	//-- Локализация
	
КонецПроцедуры

Функция ОбработкаВыбора(Форма, ВыбранноеЗначение, ИсточникВыбора) Экспорт

	ТребуетсяВызовСервера = Ложь;
	
	//++ Локализация
	Если ИсточникВыбора.ИмяФормы = "Справочник.ПартииТМЦВЭксплуатации.Форма.ФормаПодбора" Тогда
		
		Если ВыбранноеЗначение.Количество() > 0 Тогда
			ТребуетсяВызовСервера = Истина;
		КонецЕсли;
		
	КонецЕсли;
	//-- Локализация
	
	Возврат ТребуетсяВызовСервера;
	
КонецФункции

Процедура ТоварыПартияТМЦВЭксплуатацииПриИзменении(Форма) Экспорт
	
	//++ Локализация
	//-- Локализация
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

Процедура ПриВыполненииКоманды(Команда, Форма) Экспорт

	
	//++ Локализация
	
	Элементы = Форма.Элементы;
	
	//++ НЕ УТ
	Если Команда.Имя = Элементы.ТоварыПодобратьТМЦВЭксплуатации.ИмяКоманды Тогда
		
		ПодобратьТМЦВЭксплуатации(Форма);
		
	КонецЕсли; 
	//-- НЕ УТ
	
	//-- Локализация
	
КонецПроцедуры

//++ Локализация

//++ НЕ УТ

Процедура ПодобратьТМЦВЭксплуатации(Форма)
	
	Объект = Форма.Объект;
	
	// &ЗамерПроизводительности
	ОценкаПроизводительностиКлиент.НачатьЗамерВремени(Истина,
		"Документ.ПрочееОприходованиеТоваров.ФормаДокумента.Команда.ПодобратьТМЦВЭксплуатации");
	
	ПараметрыФормы = Новый Структура;
	ПараметрыФормы.Вставить("ЗакрыватьПриВыборе", Ложь);
	ПараметрыФормы.Вставить("Дата", Объект.Дата);
	ПараметрыФормы.Вставить("Организация", Объект.Организация);
	ПараметрыФормы.Вставить("Подразделение", Объект.Подразделение);
	ПараметрыФормы.Вставить("ТекущийРегистратор", Объект.Ссылка);
	
	ОткрытьФорму("Справочник.ПартииТМЦВЭксплуатации.Форма.ФормаПодбора", ПараметрыФормы, Форма);
	
КонецПроцедуры

//-- НЕ УТ

//-- Локализация

#КонецОбласти
