#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ОбработчикиСобытий

Процедура ОбработкаЗаполнения(ДанныеЗаполнения, СтандартнаяОбработка)
	
	Если ТипЗнч(ДанныеЗаполнения) = Тип("Структура")
		И ДанныеЗаполнения.Свойство("Владелец") Тогда
	
		Запрос = Новый Запрос;
		Запрос.Текст = "
		|ВЫБРАТЬ
		|	ДанныеСправочника.Ссылка
		|ИЗ
		|	Справочник.ВариантыГрафиковЛизинга КАК ДанныеСправочника
		|ГДЕ
		|	НЕ ДанныеСправочника.ПометкаУдаления
		|	И ДанныеСправочника.Владелец = &Владелец";
		
		Запрос.УстановитьПараметр("Владелец", ДанныеЗаполнения.Владелец);
		Утвержден = Запрос.Выполнить().Пустой();
		Используется = Утвержден;
	КонецЕсли;
	
КонецПроцедуры

Процедура ПередЗаписью(Отказ)
	
	Если ОбменДанными.Загрузка Тогда
		Возврат;
	КонецЕсли;

	ОбновлениеИнформационнойБазы.ПроверитьОбъектОбработан(ЭтотОбъект);
	
	Если ОбщегоНазначения.ЗначениеРеквизитаОбъекта(Владелец, "Статус") = Перечисления.СтатусыДоговоровКонтрагентов.Закрыт Тогда
		ОбщегоНазначенияКлиентСервер.СообщитьПользователю(
			НСтр("ru='Изменения графика по закрытому договору запрещены!';uk='Зміни графіка по закритому договору заборонені!'"),,,, Отказ);
	КонецЕсли;
	
КонецПроцедуры

Процедура ПриЗаписи(Отказ)
	
	Если ОбменДанными.Загрузка Тогда
		Возврат;
	КонецЕсли;
	
	Если Утвержден Или Используется Тогда
	
		Запрос = Новый Запрос;
		Запрос.Текст = "
		|ВЫБРАТЬ
		|	ДанныеСправочника.Ссылка
		|ИЗ
		|	Справочник.ВариантыГрафиковЛизинга КАК ДанныеСправочника
		|ГДЕ
		|	ДанныеСправочника.Владелец = &Владелец
		|	И ДанныеСправочника.Ссылка <> &Ссылка
		|	И (ДанныеСправочника.Утвержден И &Утвержден
		|		ИЛИ ДанныеСправочника.Используется И &Используется)
		|";
		
		Запрос.УстановитьПараметр("Владелец", Владелец);
		Запрос.УстановитьПараметр("Ссылка", Ссылка);
		Запрос.УстановитьПараметр("Утвержден", Утвержден);
		Запрос.УстановитьПараметр("Используется", Используется);
		
		Выборка = Запрос.Выполнить().Выбрать();
		Пока Выборка.Следующий() Цикл
			
			ВариантГрафикаОбъект = Выборка.Ссылка.ПолучитьОбъект();
			
			Попытка
				ВариантГрафикаОбъект.Заблокировать();
			Исключение
				ТекстСообщения = СтрШаблон(
					НСтр("ru='%1 находится в процессе редактирования пользователем или системой и не может быть изменен.
|Для установки статусов необходимо освободить остальные варианты графиков договора.'
|;uk='%1 знаходиться в процесі редагування користувачем або системою і не може бути змінений. Для установки статусів необхідно звільнити всіх варіантів графіків договору.'"),
					ВариантГрафикаОбъект);
				ОбщегоНазначенияКлиентСервер.СообщитьПользователю(ТекстСообщения,,,, Отказ);
				Прервать;
			КонецПопытки;
			
			Если Утвержден Тогда
				ВариантГрафикаОбъект.Утвержден = Ложь;
			КонецЕсли;
			
			Если Используется Тогда
				ВариантГрафикаОбъект.Используется = Ложь;
			КонецЕсли;
			
			ВариантГрафикаОбъект.Записать();
		КонецЦикла;
	КонецЕсли;
	
	Если Не ДополнительныеСвойства.Свойство("ЗаписьГрафиков") Тогда
		ОбъектыОплаты = Новый Массив;
		ОбъектыОплаты.Добавить(Владелец);
		УстановитьПривилегированныйРежим(Истина);
		РегистрыСведений.ГрафикПлатежей.РассчитатьГрафикПлатежейПоФинансовымИнструментам(ОбъектыОплаты);
		УстановитьПривилегированныйРежим(Ложь);
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#КонецЕсли