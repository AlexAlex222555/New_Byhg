
#Область СлужебныйПрограммныйИнтерфейс

Процедура ПодготовитьНаборыЗаписейКРегистрацииДвиженийПоВидамУчета(ДокументСсылка, СтруктураВидовУчета, ВидыУчетов = Неопределено, Движения = Неопределено, ПроведениеПоВсемУчетам = Ложь, МассивРегистров = Неопределено) Экспорт
			
	ПроведениеПоВсемУчетам = ВидыУчетов = Неопределено;
			
	Если ПроведениеПоВсемУчетам Тогда
		Для Каждого ВидУчета Из СтруктураВидовУчета Цикл
			СтруктураВидовУчета[ВидУчета.Ключ] = Истина;
		КонецЦикла;
	Иначе
		МассивВидовУчета = СтроковыеФункцииКлиентСервер.РазложитьСтрокуВМассивПодстрок(ВидыУчетов, ",");
		Для Каждого ЭлементМассива Из МассивВидовУчета Цикл
			СтруктураВидовУчета[ЭлементМассива] = Истина;
		КонецЦикла;	
	КонецЕсли;
		
	Если Движения = Неопределено Тогда
		
		Движения = Новый Структура;
		
		Если СтруктураВидовУчета.ДанныеДляРасчетаСреднего Тогда
			
			МассивРегистров = УчетСреднегоЗаработка.РегистрыСреднегоЗаработка();
								
		КонецЕсли;
					
		ДвиженияМетаданные = ДокументСсылка.Метаданные().Движения;
		
		Для Каждого Движение Из ДвиженияМетаданные Цикл
			
			МенеджерРегистра = ОбщегоНазначения.МенеджерОбъектаПоПолномуИмени(Движение.ПолноеИмя());
			РегистрНаборЗаписей = МенеджерРегистра.СоздатьНаборЗаписей();
			РегистрНаборЗаписей.Отбор.Регистратор.Установить(ДокументСсылка);
			Если ПроведениеПоВсемУчетам Тогда
				Движения.Вставить(Движение.Имя, РегистрНаборЗаписей);
			Иначе	
				Если МассивРегистров.Найти(Движение) <> Неопределено Тогда 
					Движения.Вставить(Движение.Имя, РегистрНаборЗаписей);
				КонецЕсли;
			КонецЕсли;
			
		КонецЦикла;
						
	КонецЕсли;

КонецПроцедуры

Процедура ЗаписьДвиженийПоУчетам(Движения, ПроведениеПоВсемУчетам, МассивРегистров) Экспорт 
	
	Если ТипЗнч(Движения) = Тип("Структура") Тогда
		
		Для Каждого Движение Из Движения Цикл
			
			Если ПроведениеПоВсемУчетам Тогда
				Движение.Значение.Записать();	
			Иначе
				Если МассивРегистров.Найти(Движение.Значение.Метаданные()) <> Неопределено Тогда 
					Движение.Значение.Записать();			
				КонецЕсли;
			КонецЕсли;
					
		КонецЦикла;   
		
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

Функция СтруктураВидовУчета() Экспорт
	
	СтруктураВидовУчета = Новый Структура;
	СтруктураВидовУчета.Вставить("ДанныеДляРасчетаСреднего", Ложь);
	СтруктураВидовУчета.Вставить("Начисления", Ложь);
	СтруктураВидовУчета.Вставить("УчетНачисленнойЗарплаты", Ложь);
	СтруктураВидовУчета.Вставить("ИсчисленныеСтраховыеВзносы", Ложь);
	СтруктураВидовУчета.Вставить("ОстальныеВидыУчета", Ложь);
	                                     
	Возврат СтруктураВидовУчета;
	
КонецФункции

#КонецОбласти

