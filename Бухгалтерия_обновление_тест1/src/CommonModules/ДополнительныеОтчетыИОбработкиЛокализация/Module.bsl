
#Область ПрограммныйИнтерфейс

// Определяет разделы, в которых доступна команда вызова дополнительных обработок.
// В Разделы необходимо добавить метаданные тех разделов,
// в которых размещены команды вызова.
// 
// см. ДополнительныеОтчетыИОбработкиПереопределяемый.ОпределитьРазделыСДополнительнымиОбработками()
//
Процедура ОпределитьРазделыСДополнительнымиОбработками(Разделы) Экспорт
	
	//++ Локализация
	
	Если ПолучитьФункциональнуюОпцию("БазоваяВерсия") Тогда
		
		//++ НЕ БЗК
		ОбщегоНазначенияУТ.ДобавитьПодсистемуВКоллекцию(Разделы, "ОрганизацияБазовая");
		ОбщегоНазначенияУТ.ДобавитьПодсистемуВКоллекцию(Разделы, "ПродажиБазовая");
		ОбщегоНазначенияУТ.ДобавитьПодсистемуВКоллекцию(Разделы, "ЗакупкиБазовая");
		ОбщегоНазначенияУТ.ДобавитьПодсистемуВКоллекцию(Разделы, "СкладБазовая");
		ОбщегоНазначенияУТ.ДобавитьПодсистемуВКоллекцию(Разделы, "БанкИКассаБазовая");
		ОбщегоНазначенияУТ.ДобавитьПодсистемуВКоллекцию(Разделы, "ОтчетыБазовая");
		ОбщегоНазначенияУТ.ДобавитьПодсистемуВКоллекцию(Разделы, "НастройкиБазовая");
		//-- НЕ БЗК
		
	Иначе
		
		//++ НЕ БЗК
		ОбщегоНазначенияУТ.ДобавитьПодсистемуВКоллекцию(Разделы, "РегламентированныйУчет");
		//-- НЕ БЗК
		//++ НЕ УТ
		ОбщегоНазначенияУТ.ДобавитьПодсистемуВКоллекцию(Разделы, "Кадры");
		ОбщегоНазначенияУТ.ДобавитьПодсистемуВКоллекцию(Разделы, "Зарплата");
		//-- НЕ УТ
	КонецЕсли;
	//-- Локализация
	
КонецПроцедуры

#КонецОбласти