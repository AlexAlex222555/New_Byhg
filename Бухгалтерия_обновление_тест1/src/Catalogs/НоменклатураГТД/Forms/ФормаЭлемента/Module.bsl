#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриЧтенииНаСервере(ТекущийОбъект)
	
	// Изменение данных реквизитов приводит к обновлению наименования извне 
	ЗакешироватьСохраненныеРеквизиты(ЭтаФорма);
	
	// Если объект модифицирован пользователем, и пришло оповещение о том что 
	// наименование обновлено извне, то перечитаем объект чтобы не попасть на 
	// оптимистическую блокировку
	ЗакешироватьРедактируемыеРеквизиты(ЭтаФорма);
	
КонецПроцедуры

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)

	// После записи владельца поменять нельзя, т.к. ссылка 
	// на данный справочник может оказаться в документе

	// Подсистема запрета редактирования ключевых реквизитов объектов.
	ЗапретРедактированияРеквизитовОбъектов.ЗаблокироватьРеквизиты(ЭтаФорма);

КонецПроцедуры

&НаСервере
Процедура ПослеЗаписиНаСервере(ТекущийОбъект, ПараметрыЗаписи)
	
	// Подсистема запрета редактирования ключевых реквизитов объектов.
	ЗапретРедактированияРеквизитовОбъектов.ЗаблокироватьРеквизиты(ЭтаФорма);
	
	// Сохраняем ссылки хранимые в БД на случай изменения извне
	ЗакешироватьСохраненныеРеквизиты(ЭтаФорма);

КонецПроцедуры

&НаКлиенте
Процедура ПослеЗаписи(ПараметрыЗаписи)
	
	Оповестить("Запись_НоменклатураГТД", ПараметрыЗаписи, Объект.Ссылка);
	
КонецПроцедуры

&НаКлиенте
Процедура ОбработкаОповещения(ИмяСобытия, Параметр, Источник)
	
	Если Не Объект.Ссылка.Пустая() 
	   И ((ИмяСобытия = "Запись_КодУКТВЭД" И Ссылка_КодУКТВЭД = Источник) ИЛИ
	      (ИмяСобытия = "Запись_НомерГТД" И Ссылка_НомерГТД = Источник)) Тогда
	  
	 	ПеречитатьОбъектСервер();
		
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура Подключаемый_РазрешитьРедактированиеРеквизитовОбъекта(Команда)
	
	Если НЕ Объект.Ссылка.Пустая() Тогда
		
		ОткрытьФорму("Справочник.НоменклатураГТД.Форма.РазблокированиеРеквизитов",,,,,, 
			Новый ОписаниеОповещения("Подключаемый_РазрешитьРедактированиеРеквизитовОбъектаЗавершение", ЭтотОбъект), 
			РежимОткрытияОкнаФормы.БлокироватьВесьИнтерфейс);
		
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура Подключаемый_РазрешитьРедактированиеРеквизитовОбъектаЗавершение(Результат, ДополнительныеПараметры) Экспорт
	
	Если ТипЗнч(Результат) = Тип("Массив") И Результат.Количество() > 0 Тогда
		
		ЗапретРедактированияРеквизитовОбъектовКлиент.УстановитьДоступностьЭлементовФормы(ЭтаФорма, Результат);
		
	КонецЕсли;
	
КонецПроцедуры


#КонецОбласти

#Область ОбработчикиСобытийЭлементовШапкиФормы

&НаКлиенте
Процедура КодУКТВЭДПриИзменении(Элемент)
	
	ЗакешироватьРедактируемыеРеквизиты(ЭтаФорма);
	
КонецПроцедуры

&НаКлиенте
Процедура НомерГТДПриИзменении(Элемент)
	
	ЗакешироватьРедактируемыеРеквизиты(ЭтаФорма);
	
КонецПроцедуры

&НаКлиенте
Процедура КомментарийПриИзменении(Элемент)
	
	ЗакешироватьРедактируемыеРеквизиты(ЭтаФорма);
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаСервере
Процедура ПеречитатьОбъектСервер()
	
	ЗначениеВРеквизитФормы(Объект.Ссылка.ПолучитьОбъект(), "Объект");
	
	Если Модифицированность Тогда
		Объект.КодУКТВЭД   = Объект_КодУКТВЭД;
		Объект.НомерГТД    = Объект_НомерГТД;
		Объект.Комментарий = Объект_Комментарий;
	Иначе
		ЗакешироватьРедактируемыеРеквизиты(ЭтаФорма);
	КонецЕсли;
	
КонецПроцедуры

&НаКлиентеНаСервереБезКонтекста
Процедура ЗакешироватьРедактируемыеРеквизиты(Форма)
	
	// Номенклатуру не кешируем, доступна только для нового элемента 
	Форма.Объект_КодУКТВЭД   = Форма.Объект.КодУКТВЭД;
	Форма.Объект_НомерГТД    = Форма.Объект.НомерГТД;
	Форма.Объект_Комментарий = Форма.Объект.Комментарий;
	
КонецПроцедуры

&НаКлиентеНаСервереБезКонтекста
Процедура ЗакешироватьСохраненныеРеквизиты(Форма)
	
	// Номенклатуру не кешируем, доступна только для нового элемента 
	Форма.Ссылка_КодУКТВЭД = Форма.Объект.КодУКТВЭД;
	Форма.Ссылка_НомерГТД  = Форма.Объект.НомерГТД;
	
КонецПроцедуры

#КонецОбласти