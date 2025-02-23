#Область ПрограммныйИнтерфейс

Процедура ДополнитьСтруктуруДействийПриИзмененииЭлемента(Форма, Элемент, СтруктураДействий) Экспорт
	
	//++ Локализация
	Если Форма.ИмяФормы = "Документ.ОтчетОРозничныхПродажах.Форма.ФормаДокумента" Тогда
		СтруктураДействий.Вставить("ЗаполнитьПризнакПодакцизныйТовар", Новый Структура("Номенклатура", "ПодакцизныйТовар"));
	КонецЕсли;           
	
	//-- Локализация
	Возврат;
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныйПрограммныйИнтерфейс

Процедура ДополнитьСтруктуруКэшируемыеЗначения(КэшированныеЗначения) Экспорт

	//++ Локализация

	КэшированныеЗначения.Вставить("ПризнакиКатегорииЭксплуатации", Новый Соответствие);
	СтруктураПустойКатегории = Новый Структура;
	//++ НЕ УТ
	СтруктураПустойКатегории.Вставить("ВидТМЦ", ПредопределенноеЗначение("Перечисление.ВидыТМЦВЭксплуатации.МалоценныйБыстроизнашивающийсяПредмет"));
	//-- НЕ УТ
	СтруктураПустойКатегории.Вставить("СрокЭксплуатации", 0);
	КэшированныеЗначения.ПризнакиКатегорииЭксплуатации.Вставить(ПредопределенноеЗначение("Справочник.КатегорииЭксплуатации.ПустаяСсылка"), СтруктураПустойКатегории);
	
	//-- Локализация
	
КонецПроцедуры

#Область Локализация

//++ Локализация

Процедура ЗаполнитьНалоговоеНазначениеВозвратнойТарыВСтрокеТЧ(ТекущаяСтрока, СтруктураДействий, КэшированныеЗначения) Экспорт
	
	Перем ЭтоВозвратнаяТара;
	
	Если СтруктураДействий.Свойство("ЗаполнитьНалоговоеНазначениеВозвратнойТары", ЭтоВозвратнаяТара)
		И ЭтоВозвратнаяТара И ТекущаяСтрока.ТипНоменклатуры = ПредопределенноеЗначение("Перечисление.ТипыНоменклатуры.МногооборотнаяТара") Тогда
		ТекущаяСтрока.НалоговоеНазначение = ПредопределенноеЗначение("Справочник.НалоговыеНазначенияАктивовИЗатрат.НДС_НеоблагаемаяХозДеятельность");
	КонецЕсли;
	
КонецПроцедуры

Процедура ПересчитатьСуммуНДСиАкцизногоНалогаВСтрокеТЧ(ТекущаяСтрока, СтруктураДействий, КэшированныеЗначения) Экспорт 
	
	Перем СтруктураПараметровДействия;
	
	Если СтруктураДействий.Свойство("ПересчитатьСуммуНДСиАкцизногоНалога", СтруктураПараметровДействия) Тогда
		
        ТекПроцентНДС = УчетНДСУПКлиентСервер.ЗначениеСтавкиНДС(ТекущаяСтрока.СтавкаНДС);
		Если УчетАкцизногоНалога.ДействуетАкцизныйНалог(СтруктураПараметровДействия.Дата) Тогда
			ТекущаяСтрока.СуммаАкцизногоНалога = УчетАкцизногоНалога.РассчитатьСуммуАкцизногоНалога(
			    ТекущаяСтрока.Сумма, 
				СтруктураПараметровДействия.ЦенаВключаетНДС, 
				ТекущаяСтрока.СтатьяДекларацииПоАкцизномуНалогу, 
				ТекущаяСтрока.ПодакцизныеТоварыДляКоммерческогоИспользования
			);
		Иначе
			ТекущаяСтрока.СуммаАкцизногоНалога = 0;
		КонецЕсли; 
		
		ТекущаяСтрока.СуммаНДС = УчетНДСУПКлиентСервер.РассчитатьСуммуНДС(
            ТекущаяСтрока.Сумма - ТекущаяСтрока.СуммаАкцизногоНалога, 
            ТекПроцентНДС, 
            СтруктураПараметровДействия.ЦенаВключаетНДС
        );
	
	КонецЕсли;
	
КонецПроцедуры

Процедура ПересчитатьСуммуНДСПропорциональноВСтрокеТЧ(ТекущаяСтрока, СтруктураДействий, КэшированныеЗначения) Экспорт 
	
	Перем СтруктураПараметровДействия;
	
	Если СтруктураДействий.Свойство("ПересчитатьСуммуНДСПропорционально", СтруктураПараметровДействия) Тогда
		
		Если ТекущаяСтрока.НалоговоеНазначение = ПредопределенноеЗначение("Справочник.НалоговыеНазначенияАктивовИЗатрат.НДС_Пропорционально") Тогда
			
			ТекКоэффициент = СтруктураПараметровДействия.КоэффициентПропорциональногоОтнесенияНДСНаОбязательства;
			ТекущаяСтрока.СуммаНДСПропорционально = ТекущаяСтрока.СуммаНДС * ТекКоэффициент;
		
		Иначе
		
			ТекущаяСтрока.СуммаНДСПропорционально = 0;
		
		КонецЕсли;
	КонецЕсли;

КонецПроцедуры

Процедура ЗаполнитьНоменклатуруГТД(ТекущаяСтрока, СтруктураДействий) Экспорт

	Если Не СтруктураДействий.Свойство("ЗаполнитьНоменклатуруГТД") Тогда
		Возврат;
	КонецЕсли;

	Если Не ЗначениеЗаполнено(ТекущаяСтрока.Номенклатура) Тогда
		ТекущаяСтрока.НомерГТД = Неопределено;
	КонецЕсли;

КонецПроцедуры // ЗаполнитьНоменклатуруГТД

Процедура ЗаполнитьСтатьюДекларацииПоАкцизномуНалогу(ТекущаяСтрока, СтруктураДействий) Экспорт

	Если Не СтруктураДействий.Свойство("ЗаполнитьСтатьюДекларацииПоАкцизномуНалогу") Тогда
		Возврат;
	КонецЕсли;

	Если Не ЗначениеЗаполнено(ТекущаяСтрока.Номенклатура) Тогда
		ТекущаяСтрока.СтатьяДекларацииПоАкцизномуНалогу = Неопределено;
	КонецЕсли;

КонецПроцедуры


 Процедура ЗаполнитьИндексАкцизнойМарки(ТекущаяСтрока, СтруктураДействий) Экспорт
 	
 	ПараметрыДействия = Неопределено;
 	Если СтруктураДействий.Свойство("ЗаполнитьИндексАкцизнойМарки", ПараметрыДействия) Тогда
		Если ТекущаяСтрока.УказыватьШтрихкодАкцизнойМаркиПриПечатиЧека = Истина Тогда
 			
 			Если ПараметрыДействия <> Неопределено И ПараметрыДействия.Свойство("ИмяКолонкиКоличество") Тогда
 				ИмяКолонкиКоличество = ПараметрыДействия.ИмяКолонкиКоличество;
 			Иначе
 				ИмяКолонкиКоличество = "Количество";
 			КонецЕсли;
 			
			Если АкцизныеМаркиКлиентСерверПереопределяемый.КоличествоАкцизныхМарокСоответствуетКоличествуТовара(
				ТекущаяСтрока.КоличествоАкцизныхМарок, ТекущаяСтрока[ИмяКолонкиКоличество]) Тогда
				ТекущаяСтрока.ИндексАкцизнойМарки = 1;
 			Иначе
 				ТекущаяСтрока.ИндексАкцизнойМарки = 2;
 			КонецЕсли;
 		Иначе
 			ТекущаяСтрока.ИндексАкцизнойМарки = 0;
 		КонецЕсли;
 	КонецЕсли;
 	
 КонецПроцедуры

//-- Локализация

#КонецОбласти

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

//++ Локализация
//-- Локализация
#КонецОбласти