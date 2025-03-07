
#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ОбработчикиСобытий

Процедура ПередЗаписью(Отказ)
	
	Если ОбменДанными.Загрузка Тогда
		Возврат;
	КонецЕсли;
	
	ОбновлениеИнформационнойБазы.ПроверитьОбъектОбработан(ЭтотОбъект);
	
	Если ЭтоГруппа Тогда
		Возврат;
	КонецЕсли;
	
	Если Статус.Пустая() Тогда
		Статус = Перечисления.СтатусыНаправленияДеятельности.Используется;
	КонецЕсли;
	
	ШаблонНазначения = Справочники.НаправленияДеятельности.ШаблонНазначения(ЭтотОбъект);
	Справочники.Назначения.ПроверитьЗаполнитьПередЗаписью(Назначение, ШаблонНазначения, ЭтотОбъект, "УчетЗатрат", Отказ, Истина, Не УчетЗатрат);
	
	ДополнительныеСвойства.Вставить("ЭтоНовый", ЭтоНовый());
	Если Не ЭтоНовый() Тогда
		РеквизитыДоЗаписи = ОбщегоНазначения.ЗначенияРеквизитовОбъекта(Ссылка,"ДопускаетсяОбособлениеСверхПотребности,ПометкаУдаления");
		
		ДополнительныеСвойства.Вставить("ОбновитьНазначение", 
			РеквизитыДоЗаписи.ДопускаетсяОбособлениеСверхПотребности <> ДопускаетсяОбособлениеСверхПотребности);
	Иначе
		ДополнительныеСвойства.Вставить("ОбновитьНазначение", ДопускаетсяОбособлениеСверхПотребности);
	КонецЕсли;	
	
	ОбщегоНазначенияУТ.ПодготовитьДанныеДляСинхронизацииКлючей(ЭтотОбъект, ПараметрыСинхронизацииКлючей());	
	
	НаправленияДеятельностиЛокализация.ПередЗаписью(ЭтотОбъект, Отказ);
	
КонецПроцедуры

Процедура ПриЗаписи(Отказ)
	
	Если ОбменДанными.Загрузка Тогда
		Возврат;
	КонецЕсли;
	
	Если ЭтоГруппа Тогда
		Возврат;
	КонецЕсли;
	
	ШаблонНазначения = Справочники.НаправленияДеятельности.ШаблонНазначения(ЭтотОбъект);
    Справочники.Назначения.ПриЗаписиСправочника(
        Назначение, 
    	ШаблонНазначения,
    	ЭтотОбъект,
        НДСОбщегоНазначенияПовтИсп.ОпределитьНалоговоеНазначениеПоНалогообложениюНДС(НалогообложениеНДС),
    	ДополнительныеСвойства.ОбновитьНазначение
    );
	
	ОбновитьПовторноИспользуемыеЗначения();
	
	// Запись подчиненной константы.
	ОбеспечениеСервер.ИспользоватьУправлениеПеремещениемОбособленныхТоваровВычислитьИЗаписать();
	
	ОбщегоНазначенияУТ.СинхронизироватьКлючи(ЭтотОбъект);
	
	НаправленияДеятельностиЛокализация.ПриЗаписи(ЭтотОбъект, Отказ);
	
КонецПроцедуры

Процедура ОбработкаПроверкиЗаполнения(Отказ, ПроверяемыеРеквизиты)
	
	Если ЭтоГруппа Тогда
		Возврат;
	КонецЕсли;
	
	МассивНепроверяемыхРеквизитов = Новый Массив;
	
	
	ОбщегоНазначения.УдалитьНепроверяемыеРеквизитыИзМассива(ПроверяемыеРеквизиты, МассивНепроверяемыхРеквизитов);
	
	НаправленияДеятельностиЛокализация.ОбработкаПроверкиЗаполнения(ЭтотОбъект, Отказ, ПроверяемыеРеквизиты);
	
КонецПроцедуры

Процедура ПриКопировании(ОбъектКопирования)
	
	Если НЕ ЭтоГруппа Тогда
		Назначение = Справочники.Назначения.ПустаяСсылка();
	КонецЕсли;
	
    ПараметрыЗаполнения = Справочники.НаправленияДеятельности.ПараметрыЗаполненияНалогообложениеНДСПродажи();
    УчетНДСУП.ЗаполнитьНалогообложениеНДСПродажи(НалогообложениеНДС, ПараметрыЗаполнения);
	
КонецПроцедуры

Процедура ОбработкаЗаполнения(ДанныеЗаполнения, ТекстЗаполнения, СтандартнаяОбработка)
	
    Если НЕ ЭтотОбъект.ЭтоГруппа Тогда
    	ПараметрыЗаполнения = Справочники.НаправленияДеятельности.ПараметрыЗаполненияНалогообложениеНДСПродажи();
    	УчетНДСУП.ЗаполнитьНалогообложениеНДСПродажи(НалогообложениеНДС, ПараметрыЗаполнения);
    КонецЕсли;
	
	НаправленияДеятельностиЛокализация.ОбработкаЗаполнения(ЭтотОбъект, ДанныеЗаполнения, СтандартнаяОбработка);
	
КонецПроцедуры

#Область СлужебныеПроцедурыИФункции

Функция ПараметрыСинхронизацииКлючей()
	
	Результат = Новый Соответствие;
	
	Результат.Вставить("Справочник.КлючиАналитикиУчетаПоПартнерам", "ПометкаУдаления");
	
	//++ НЕ УТ
	Результат.Вставить("Справочник.ПартииПроизводства", "ПометкаУдаления");
	//-- НЕ УТ
	
	Возврат Результат;
	
КонецФункции

#КонецОбласти
#КонецОбласти

#КонецЕсли