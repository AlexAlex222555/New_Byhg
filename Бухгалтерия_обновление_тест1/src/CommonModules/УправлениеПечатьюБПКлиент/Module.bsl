
#Область СлужебныйПрограммныйИнтерфейс

Функция ВыполнитьКомандуПечати(ОписаниеКоманды) Экспорт
	ПараметрыПечати = ПолучитьЗаголовокПечатнойФормы(ОписаниеКоманды.ОбъектыПечати);
	
	Если ОписаниеКоманды.Свойство("ДополнительныеПараметры") Тогда
		ПараметрыПечати.Вставить("ДополнительныеПараметры", ОписаниеКоманды.ДополнительныеПараметры);
	КонецЕсли; 
	
	УправлениеПечатьюКлиент.ВыполнитьКомандуПечати(ОписаниеКоманды.МенеджерПечати, ОписаниеКоманды.Идентификатор, ОписаниеКоманды.ОбъектыПечати,
		ОписаниеКоманды.Форма, ПараметрыПечати);
	
КонецФункции

Функция ВыполнитьКомандуПечатиКарточкиОС(ОписаниеКоманды) Экспорт
	
	ПараметрыПечати = ПолучитьЗаголовокПечатнойФормы(ОписаниеКоманды.ОбъектыПечати);
	Если ОписаниеКоманды.Свойство("ДатаСведений") Тогда
		ПараметрыПечати.Вставить("ДатаСведений", ОписаниеКоманды.ДатаСведений);
	КонецЕсли;
	
	УправлениеПечатьюКлиент.ВыполнитьКомандуПечати(
        ОписаниеКоманды.МенеджерПечати, 
        ОписаниеКоманды.Идентификатор, 
        ОписаниеКоманды.ОбъектыПечати,
		ОписаниеКоманды.Форма, 
        ПараметрыПечати
    );
	
КонецФункции

////////////////////////////////////////////////////////////////////////////////
// Процедуры для команд печати
Функция ПолучитьЗаголовокПечатнойФормы(ПараметрКоманды) Экспорт 
	
	Если Тип(ПараметрКоманды) = Тип("Массив") И ПараметрКоманды.Количество() = 1 Тогда 
		Возврат Новый Структура("ЗаголовокФормы", ПараметрКоманды[0]);
	Иначе
		Возврат Новый Структура;
	КонецЕсли;
	
КонецФункции

#КонецОбласти