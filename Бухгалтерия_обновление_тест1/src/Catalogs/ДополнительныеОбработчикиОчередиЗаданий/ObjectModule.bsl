#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда
	
#Область ОбработчикиСобытий

Процедура ПриКопировании(ОбъектКопирования)
	
	Авто = Ложь;
	
КонецПроцедуры

Процедура ОбработкаПроверкиЗаполнения(Отказ, ПроверяемыеРеквизиты)
	
	ПроверитьВозможностьИзменения();
	
	Проверка = Методы.Выгрузить(, "Метод");
	Проверка.Свернуть("Метод");
	Если Проверка.Количество() <> Методы.Количество() Тогда
		ОбщегоНазначения.СообщитьПользователю(НСтр("ru='Обнаружены дубли методов';uk='Виявлені дублі методів'"), , "Методы", , Отказ);
	КонецЕсли;
	
КонецПроцедуры

Процедура ПередЗаписью(Отказ)
	
	Если ОбменДанными.Загрузка Тогда
		Возврат;
	КонецЕсли;
	
	ПроверитьВозможностьИзменения();
	
КонецПроцедуры

Процедура ПриЗаписи(Отказ)
	
	ПараметрыЗадания = Новый Массив;
	ПараметрыЗадания.Добавить(Ссылка);
	
	РегламентноеЗадание = Справочники.ДополнительныеОбработчикиОчередиЗаданий.РегламентноеЗадание(Ссылка);
	Если РегламентноеЗадание = Неопределено Тогда
		РегламентноеЗадание = РегламентныеЗадания.СоздатьРегламентноеЗадание(Метаданные.РегламентныеЗадания.ОбработкаОчередиЗаданийБТС);
		РегламентноеЗадание.Использование = Ложь;
		РегламентноеЗадание.Ключ = Строка(Ссылка.УникальныйИдентификатор());
	КонецЕсли;
	РегламентноеЗадание.КоличествоПовторовПриАварийномЗавершении = 0;
	РегламентноеЗадание.Наименование = СтрШаблон("%1 (%2)", Метаданные.РегламентныеЗадания.ОбработкаОчередиЗаданийБТС.Синоним, Наименование);
	РегламентноеЗадание.Параметры = ПараметрыЗадания;
	
	Если ПометкаУдаления Тогда
		РегламентноеЗадание.Использование = Ложь;
	Иначе
		ДополнительныеСвойства.Свойство("Использование", РегламентноеЗадание.Использование);
	КонецЕсли;
	
	Расписание = Неопределено;
	Если ДополнительныеСвойства.Свойство("Расписание", Расписание) Тогда
		РегламентноеЗадание.Расписание = Расписание;
	КонецЕсли;
	
	РегламентноеЗадание.Записать();
	
	Если ОбменДанными.Загрузка Тогда
		Возврат;
	КонецЕсли;
	
КонецПроцедуры

Процедура ПередУдалением(Отказ)
	
	РегламентноеЗадание = Справочники.ДополнительныеОбработчикиОчередиЗаданий.РегламентноеЗадание(Ссылка);
	Если РегламентноеЗадание <> Неопределено Тогда
		РегламентноеЗадание.Удалить();
	КонецЕсли;
	
	Если ОбменДанными.Загрузка Тогда
		Возврат;
	КонецЕсли;
	
	ПроверитьВозможностьИзменения();
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

Процедура ПроверитьВозможностьИзменения()
	
	Если Авто Тогда
		ВызватьИсключение НСтр("ru='Редактирование этой настройки выполняется только в Менеджере сервиса';uk='Редагування цієї настройки виконується тільки в Менеджері сервісу'");
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#КонецЕсли

