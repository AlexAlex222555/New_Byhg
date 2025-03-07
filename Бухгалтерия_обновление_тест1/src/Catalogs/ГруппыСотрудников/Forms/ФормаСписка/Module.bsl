
#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
		
	Если Параметры.Свойство("АвтоТест") Тогда // Возврат при получении формы для анализа.
		Возврат;
	КонецЕсли;
	
	Если Параметры.РежимВыбора = Истина Тогда
		
		Элементы.Список.РежимВыбора = Истина;
		
		Элементы.Список.ИзменятьПорядокСтрок = Ложь;
		Элементы.Список.ИзменятьСоставСтрок = Ложь;
		
		Если Параметры.Свойство("ВыборРодителя")
			И Параметры.ВыборРодителя = Истина
			И ЗначениеЗаполнено(Параметры.ТекущаяСтрока) Тогда
			
			ОбщегоНазначенияКлиентСервер.УстановитьЭлементОтбораДинамическогоСписка(
				Список, "Ссылка", Параметры.ТекущаяСтрока, ВидСравненияКомпоновкиДанных.НеРавно);
			
		КонецЕсли;
		
	КонецЕсли; 
	
КонецПроцедуры

&НаКлиенте
Процедура ОбработкаОповещения(ИмяСобытия, Параметр, Источник)
	
	Если ИмяСобытия = "ИзменениеДанныхМестаРаботы" Тогда
		Элементы.Список.Обновить();
	КонецЕсли; 
	
КонецПроцедуры

#КонецОбласти


#Область ОбработчикиСобытийЭлементовТаблицыФормыСписок

&НаКлиенте
Процедура СписокНачалоПеретаскивания(Элемент, ПараметрыПеретаскивания, Выполнение)
	
	ТекущиеДанные = Элементы.Список.ТекущиеДанные;
	Если ТекущиеДанные = Неопределено Или ТекущиеДанные.ФормироватьАвтоматически Тогда
		Выполнение = Ложь;
	КонецЕсли; 
	
КонецПроцедуры

&НаКлиенте
Процедура СписокПроверкаПеретаскивания(Элемент, ПараметрыПеретаскивания, СтандартнаяОбработка, Строка, Поле)
	
	ТекущиеДанные = ПараметрыПеретаскивания.Значение;
	Если ТекущиеДанные = Неопределено
		Или Строка = Неопределено
		Или Не ПодходящийРодитель(Строка) Тогда
			       
		ПараметрыПеретаскивания.Действие = ДействиеПеретаскивания.Отмена;
			
	Иначе
		ПараметрыПеретаскивания.Действие = ДействиеПеретаскивания.Перемещение;
	КонецЕсли; 
	
КонецПроцедуры

#КонецОбласти


#Область СлужебныеПроцедурыИФункции

&НаСервереБезКонтекста
Функция ПодходящийРодитель(Ссылка)
	Возврат Не ОбщегоНазначения.ЗначениеРеквизитаОбъекта(Ссылка, "ФормироватьАвтоматически");
КонецФункции

#КонецОбласти
