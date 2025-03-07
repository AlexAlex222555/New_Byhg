
#Область СлужебныйПрограммныйИнтерфейс

#Область РедактированиеСвойствСтатьиФинансирования

Процедура ДополнитьФормуСтатьиФинансирования(Форма) Экспорт

	Если ОбщегоНазначения.ПодсистемаСуществует("ЗарплатаКадрыПриложения.УчетБюджетныхУчреждений") Тогда
		Модуль = ОбщегоНазначения.ОбщийМодуль("УчетБюджетныхУчреждений");
		Модуль.ДополнитьФормуСтатьиФинансирования(Форма);
	КонецЕсли;

КонецПроцедуры

Процедура ПрочитатьДополнительныеДанныеСтатьиФинансирования(Форма) Экспорт

	Если ОбщегоНазначения.ПодсистемаСуществует("ЗарплатаКадрыПриложения.УчетБюджетныхУчреждений") Тогда
		Модуль = ОбщегоНазначения.ОбщийМодуль("УчетБюджетныхУчреждений");
		Модуль.ПрочитатьДополнительныеДанныеСтатьиФинансирования(Форма);
	КонецЕсли;

КонецПроцедуры

Процедура ЗаписатьДополнительныеДанныеСтатьиФинансирования(Форма, Ссылка) Экспорт

	Если ОбщегоНазначения.ПодсистемаСуществует("ЗарплатаКадрыПриложения.УчетБюджетныхУчреждений") Тогда
		Модуль = ОбщегоНазначения.ОбщийМодуль("УчетБюджетныхУчреждений");
		Модуль.ЗаписатьДополнительныеДанныеСтатьиФинансирования(Форма, Ссылка);
	КонецЕсли;

КонецПроцедуры

#КонецОбласти

#Область НастройкаРасчетаЗарплаты

Процедура ДополнитьФормуНастройкаРасчетаЗарплаты(Форма) Экспорт

	Если ОбщегоНазначения.ПодсистемаСуществует("ЗарплатаКадрыПриложения.УчетБюджетныхУчреждений") Тогда
		Модуль = ОбщегоНазначения.ОбщийМодуль("УчетБюджетныхУчреждений");
		Модуль.ДополнитьФормуНастройкаРасчетаЗарплаты(Форма);
	КонецЕсли;

КонецПроцедуры

Процедура ЗаписатьНастройкиНастройкаПрограммы(Параметры) Экспорт

	Если ОбщегоНазначения.ПодсистемаСуществует("ЗарплатаКадрыПриложения.УчетБюджетныхУчреждений") Тогда
		Модуль = ОбщегоНазначения.ОбщийМодуль("УчетБюджетныхУчреждений");
		Модуль.ЗаписатьНастройкиНастройкаПрограммы(Параметры);
	КонецЕсли;
	
	Если ОбщегоНазначения.ПодсистемаСуществует("ЗарплатаКадрыПриложения.УчетХозрасчетныхОрганизаций") Тогда
		Модуль = ОбщегоНазначения.ОбщийМодуль("УчетХозрасчетныхОрганизаций");
		Модуль.ЗаписатьНастройкиНастройкаПрограммы(Параметры);
	КонецЕсли;

КонецПроцедуры

Процедура ЗначенияСохраняемыхРеквизитовФормыНастройкаПрограммы(Форма, СохраняемыеРеквизиты) Экспорт

	Если ОбщегоНазначения.ПодсистемаСуществует("ЗарплатаКадрыПриложения.УчетБюджетныхУчреждений") Тогда
		Модуль = ОбщегоНазначения.ОбщийМодуль("УчетБюджетныхУчреждений");
		Модуль.ЗначенияСохраняемыхРеквизитовФормыНастройкаПрограммы(Форма, СохраняемыеРеквизиты);
	КонецЕсли;
	
КонецПроцедуры

Процедура НастройкиПрограммыВРеквизитыФормы(Форма) Экспорт

	Если ОбщегоНазначения.ПодсистемаСуществует("ЗарплатаКадрыПриложения.УчетБюджетныхУчреждений") Тогда
		Модуль = ОбщегоНазначения.ОбщийМодуль("УчетБюджетныхУчреждений");
		Модуль.НастройкиПрограммыВРеквизитыФормы(Форма);
	КонецЕсли;

КонецПроцедуры

#КонецОбласти

#КонецОбласти
