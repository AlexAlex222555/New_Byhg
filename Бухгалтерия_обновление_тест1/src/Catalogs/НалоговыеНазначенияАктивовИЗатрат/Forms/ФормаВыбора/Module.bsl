#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	Если Параметры.Свойство("АвтоТест") Тогда // Возврат при получении формы для анализа.
		Возврат;
	КонецЕсли;
	
	ПоказыватьВстроеннуюСправкуСохраненноеЗначение	= ХранилищеОбщихНастроек.Загрузить("Справочник_НалоговыеНазначенияАктивовИЗатрат", "ПоказыватьВстроеннуюСправку");
	ПоказыватьВстроеннуюСправку	= ?(ПоказыватьВстроеннуюСправкуСохраненноеЗначение = Неопределено, Истина, ПоказыватьВстроеннуюСправкуСохраненноеЗначение);
		
	УправлениеФормойСервер();
	
	СобытияФорм.ПриСозданииНаСервере(ЭтаФорма, Отказ, СтандартнаяОбработка);		
	
КонецПроцедуры // ПриСозданииНаСервере

&НаКлиенте
Процедура ПриЗакрытии()
	СохранитьНастройкиФормыНаСервере();
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовШапкиФормы

&НаКлиенте
Процедура СписокПриАктивизацииСтроки(Элемент)
	ЗаполнитьТекстВстроеннойСправки(Элементы.Список.ТекущиеДанные);
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура Подключаемый_ВыполнитьПереопределяемуюКоманду(Команда)
	СобытияФормКлиент.ВыполнитьПереопределяемуюКоманду(ЭтаФорма, Команда);
КонецПроцедуры

&НаКлиенте
Процедура ПоказатьСкрытьВстроеннуюСправку(Команда)
	ПоказыватьВстроеннуюСправку = НЕ ПоказыватьВстроеннуюСправку;
	УправлениеФормойСервер();
	ЗаполнитьТекстВстроеннойСправки(Элементы.Список.ТекущиеДанные);
КонецПроцедуры // ПоказатьСкрытьВстроеннуюСправку

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаСервере
Процедура УправлениеФормойСервер()
	Элементы.ВстроеннаяСправка.Видимость = ПоказыватьВстроеннуюСправку;
	Элементы.ФормаПоказатьСкрытьВстроеннуюСправку.Заголовок = ?(ПоказыватьВстроеннуюСправку, "Скрыть справку", "Показать справку");
КонецПроцедуры // УправлениеФормойСервер
	
&НаСервере
Процедура СохранитьНастройкиФормыНаСервере()
	ХранилищеОбщихНастроек.Сохранить("Справочник_НалоговыеНазначенияАктивовИЗатрат", "ПоказыватьВстроеннуюСправку",
	  	ПоказыватьВстроеннуюСправку);
КонецПроцедуры // СохранитьНастройкиФормыНаСервере
	

&НаСервере
Процедура ЗаполнитьТекстВстроеннойСправки(Знач НалоговоеНазначениеСтруктура)
	
	Если НалоговоеНазначениеСтруктура = Неопределено Тогда
		НалоговоеНазначение = Неопределено;
	Иначе
		НалоговоеНазначение = НалоговоеНазначениеСтруктура.Ссылка;	
	КонецЕсли; 
	
	Если НЕ ПоказыватьВстроеннуюСправку Тогда
		Возврат;
	КонецЕсли;
	  
	Если НалоговоеНазначение <> Неопределено Тогда
		ИмяОбласти = Справочники.НалоговыеНазначенияАктивовИЗатрат.ПолучитьИмяПредопределенного(НалоговоеНазначение);
		Если ИмяОбласти = "Управленческое" Тогда
			ИмяОбласти = "";
		КонецЕсли;
	Иначе
		ИмяОбласти = "НДС_Облагаемая";
	КонецЕсли;
	
	Если ЗначениеЗаполнено(ИмяОбласти) Тогда
		МакетПомощника = Справочники.НалоговыеНазначенияАктивовИЗатрат.ПолучитьМакет("Справка");
		
		ОбластьТекстЗаголовок			= ИмяОбласти + "|Заголовок";
		ОбластьТекстаСправки = МакетПомощника.ПолучитьОбласть(ОбластьТекстЗаголовок);
		ТекстЗаголовок = ОбластьТекстаСправки.ТекущаяОбласть.Текст;
		
		ОбластьТекстОбщий			= ИмяОбласти + "|Общий";
		ОбластьТекстаСправки = МакетПомощника.ПолучитьОбласть(ОбластьТекстОбщий);
		ТекстОбщий = ОбластьТекстаСправки.ТекущаяОбласть.Текст;
	Иначе
		ТекстЗаголовок = "";
		ТекстОбщий = "";
	КонецЕсли; 
	
	ТекстОбщий = "<DIV>" + СтрЗаменить(ТекстОбщий, Символы.ПС, "</DIV>" + Символы.ПС + "<DIV>") + "</DIV>";

 	ТекстВстроеннойСправки = Справочники.НалоговыеНазначенияАктивовИЗатрат.ПолучитьМакет("ШаблонВстроеннойСправки").ПолучитьТекст();

	ТекстВстроеннойСправки = СтрЗаменить(ТекстВстроеннойСправки, "%header%", ТекстЗаголовок);
	ТекстВстроеннойСправки = СтрЗаменить(ТекстВстроеннойСправки, "%text%", ТекстОбщий);

	ВстроеннаяСправка = ТекстВстроеннойСправки;
	
КонецПроцедуры // ЗаполнитьТекстВстроеннойСправки


#КонецОбласти