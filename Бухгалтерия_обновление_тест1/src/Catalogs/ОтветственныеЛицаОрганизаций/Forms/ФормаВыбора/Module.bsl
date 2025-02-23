
#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	Если Параметры.Свойство("АвтоТест") Тогда // Возврат при получении формы для анализа.
		Возврат;
	КонецЕсли;

	Если Параметры.Свойство("Отбор") И Параметры.Отбор.Свойство("Дата") Тогда
		
		// Наложим отбор списка по периоду действия записи - он должен совпадать с датой документа
		//	- начало периода <= даты документа
		//	- окончание периода >= даты документа или дата окончания периода не указана.
		
		ДатаДляОтбора 	 = Параметры.Отбор.Дата;
		РежимОтображения = РежимОтображенияЭлементаНастройкиКомпоновкиДанных.БыстрыйДоступ;
		
		ГруппаОтбораПоПериоду = ОбщегоНазначенияКлиентСервер.СоздатьГруппуЭлементовОтбора(
			ОбщегоНазначенияУТКлиентСервер.ПолучитьОтборДинамическогоСписка(Список).Элементы,
			НСтр("ru='Период действия';uk='Період дії'"),
			ТипГруппыЭлементовОтбораКомпоновкиДанных.ГруппаИ);
		
		ОбщегоНазначенияКлиентСервер.ДобавитьЭлементКомпоновки(
			ГруппаОтбораПоПериоду,
			"ДатаНачала",
			ВидСравненияКомпоновкиДанных.МеньшеИлиРавно,
			ДатаДляОтбора,,
			Истина,
			РежимОтображения);
		
		ГруппаОтбораПоДатеОкончания = ОбщегоНазначенияКлиентСервер.СоздатьГруппуЭлементовОтбора(
			ГруппаОтбораПоПериоду.Элементы,
			НСтр("ru='Дата окончания';uk='Дата закінчення'"),
			ТипГруппыЭлементовОтбораКомпоновкиДанных.ГруппаИли);
		
		ОбщегоНазначенияКлиентСервер.ДобавитьЭлементКомпоновки(
			ГруппаОтбораПоДатеОкончания,
			"ДатаОкончания",
			ВидСравненияКомпоновкиДанных.БольшеИлиРавно,
			ДатаДляОтбора,,
			Истина,
			РежимОтображения);
		
		ОбщегоНазначенияКлиентСервер.ДобавитьЭлементКомпоновки(
			ГруппаОтбораПоДатеОкончания,
			"ДатаОкончания",
			ВидСравненияКомпоновкиДанных.НеЗаполнено,
			ДатаДляОтбора,,
			Истина,
			РежимОтображения);
		
		ГруппаОтбораПоПериоду.РежимОтображения 		 = РежимОтображения;
		ГруппаОтбораПоДатеОкончания.РежимОтображения = РежимОтображения;
		
		Параметры.Отбор.Удалить("Дата");
		
	КонецЕсли;
	
	Если ПолучитьФункциональнуюОпцию("БазоваяВерсия") Тогда
		Элементы.ФизическоеЛицо.Заголовок = НСтр("ru='Сотрудник';uk='Співробітник'");
	КонецЕсли;
	
	Элементы.Владелец.Видимость = ПолучитьФункциональнуюОпцию("ИспользоватьНесколькоОрганизаций");
	
	СобытияФорм.ПриСозданииНаСервере(ЭтаФорма, Отказ, СтандартнаяОбработка);
	
	ВерсионированиеОбъектов.ПриСозданииНаСервере(ЭтотОбъект);
	
КонецПроцедуры

#КонецОбласти
#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура Подключаемый_ВыполнитьПереопределяемуюКоманду(Команда)
	
	СобытияФормКлиент.ВыполнитьПереопределяемуюКоманду(ЭтаФорма, Команда);
	
КонецПроцедуры

#КонецОбласти

