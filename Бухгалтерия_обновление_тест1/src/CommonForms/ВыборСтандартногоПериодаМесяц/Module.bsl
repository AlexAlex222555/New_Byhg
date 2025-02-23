
#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	ЗаполнитьЗначенияСвойств(ЭтотОбъект, Параметры, "НачалоПериода, КонецПериода, ВыборКварталов, ОграничениеСнизу");
	
	Элементы.ГруппаКварталы.Видимость = ВыборКварталов;
	
	Если Не ЗначениеЗаполнено(КонецПериода) Тогда
		КонецПериода  = КонецМесяца(ТекущаяДатаСеанса());
		НачалоПериода = НачалоМесяца(КонецПериода);
	КонецЕсли;
	
	Если ОграничениеСнизу > КонецПериода Тогда
		КонецПериода  = КонецМесяца(ОграничениеСнизу);
		НачалоПериода = НачалоМесяца(ОграничениеСнизу);
	КонецЕсли;
	
	ДатаНачалаГода = НачалоГода(КонецПериода);
	
	НастроитьФормуПоОграничениюПериода(ЭтотОбъект);
	
КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)
	
	УстановитьАктивныйПериод();
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура ПерейтиНаГодНазад(Команда)
	
	ДатаНачалаГода = НачалоГода(ДатаНачалаГода - 1);
	
	НастроитьФормуПоОграничениюПериода(ЭтотОбъект);
	
	УстановитьАктивныйПериод();
	
КонецПроцедуры

&НаКлиенте
Процедура ПерейтиНаГодВперед(Команда)
	
	ДатаНачалаГода = КонецГода(ДатаНачалаГода) + 1;
	
	НастроитьФормуПоОграничениюПериода(ЭтотОбъект);
	
	УстановитьАктивныйПериод();
	
КонецПроцедуры

&НаКлиенте
Процедура ВыбратьМесяц1(Команда)
	
	ВыбратьМесяц(1);
	
КонецПроцедуры

&НаКлиенте
Процедура ВыбратьМесяц2(Команда)
	
	ВыбратьМесяц(2);
	
КонецПроцедуры

&НаКлиенте
Процедура ВыбратьМесяц3(Команда)
	
	ВыбратьМесяц(3);
	
КонецПроцедуры

&НаКлиенте
Процедура ВыбратьМесяц4(Команда)
	
	ВыбратьМесяц(4);
	
КонецПроцедуры

&НаКлиенте
Процедура ВыбратьМесяц5(Команда)
	
	ВыбратьМесяц(5);
	
КонецПроцедуры

&НаКлиенте
Процедура ВыбратьМесяц6(Команда)
	
	ВыбратьМесяц(6);
	
КонецПроцедуры

&НаКлиенте
Процедура ВыбратьМесяц7(Команда)
	
	ВыбратьМесяц(7);
	
КонецПроцедуры

&НаКлиенте
Процедура ВыбратьМесяц8(Команда)
	
	ВыбратьМесяц(8);
	
КонецПроцедуры

&НаКлиенте
Процедура ВыбратьМесяц9(Команда)
	
	ВыбратьМесяц(9);
	
КонецПроцедуры

&НаКлиенте
Процедура ВыбратьМесяц10(Команда)
	
	ВыбратьМесяц(10);
	
КонецПроцедуры

&НаКлиенте
Процедура ВыбратьМесяц11(Команда)
	
	ВыбратьМесяц(11);
	
КонецПроцедуры

&НаКлиенте
Процедура ВыбратьМесяц12(Команда)
	
	ВыбратьМесяц(12);
	
КонецПроцедуры

&НаКлиенте
Процедура ВыбратьКвартал1(Команда)
	
	ВыбратьКвартал(1);
	
КонецПроцедуры

&НаКлиенте
Процедура ВыбратьКвартал2(Команда)
	
	ВыбратьКвартал(2);
	
КонецПроцедуры

&НаКлиенте
Процедура ВыбратьКвартал3(Команда)
	
	ВыбратьКвартал(3);
	
КонецПроцедуры

&НаКлиенте
Процедура ВыбратьКвартал4(Команда)
	
	ВыбратьКвартал(4);
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаКлиенте
Процедура УстановитьАктивныйПериод()
	
	Если НачалоМесяца(НачалоПериода) = НачалоМесяца(КонецПериода) Тогда
		НомерМесяца = Месяц(НачалоПериода);
		ТекущийЭлемент = Элементы["ВыбратьМесяц" + НомерМесяца];
	ИначеЕсли ВыборКварталов
		И НачалоКвартала(НачалоПериода) = НачалоКвартала(КонецПериода) Тогда
		НомерКвартала = Месяц(КонецКвартала(НачалоПериода))/3;
		ТекущийЭлемент = Элементы["ВыбратьКвартал" + НомерКвартала];
	КонецЕсли;

КонецПроцедуры

&НаКлиенте
Процедура ВыполнитьВыборПериода()

	РезультатВыбора = Новый Структура("НачалоПериода,КонецПериода", НачалоПериода, КонецДня(КонецПериода));
	ОповеститьОВыборе(РезультатВыбора);

КонецПроцедуры 

&НаКлиенте
Процедура ВыбратьМесяц(НомерМесяца)
	
	НачалоПериода = Дата(Год(ДатаНачалаГода), НомерМесяца, 1);
	КонецПериода  = КонецМесяца(НачалоПериода);
	
	ВыполнитьВыборПериода();
	
КонецПроцедуры

&НаКлиенте
Процедура ВыбратьКвартал(НомерКвартала)
	
	НачалоПериодаКвартал = Дата(Год(ДатаНачалаГода), НомерКвартала * 3 - 2, 1);
	НачалоПериода = НачалоПериодаКвартал;
	КонецПериода = КонецКвартала(НачалоПериодаКвартал);
	
	ВыполнитьВыборПериода();
	
КонецПроцедуры

&НаКлиентеНаСервереБезКонтекста
Процедура НастроитьФормуПоОграничениюПериода(Форма)
	
	Если Не ЗначениеЗаполнено(Форма.ОграничениеСнизу) Тогда
		Возврат;
	КонецЕсли;
	
	Если Форма.ОграничениеСнизу < Форма.ДатаНачалаГода
		И Не Форма.ВыбранныйГодОграничен Тогда
		Возврат;
	КонецЕсли;
	
	ПервыйГод = (НачалоГода(Форма.ОграничениеСнизу) = Форма.ДатаНачалаГода);
	
	// Выбор года
	Форма.ВыбранныйГодОграничен = ПервыйГод;
	
	Форма.Элементы.ПерейтиНаГодНазадДоступно.Видимость   = Не ПервыйГод;
	Форма.Элементы.ПерейтиНаГодНазадНедоступно.Видимость = ПервыйГод; // картинка ВыборСтандартногоПериодаНедоступнаяКнопка
	
	// Выбор квартала
	Если Форма.ВыборКварталов Тогда
		
		МинимальныйКвартал = ?(Не ПервыйГод, 1, Месяц(КонецКвартала(Форма.ОграничениеСнизу)) / 3);
		
		Для НомерКвартала = 1 По 4 Цикл
			ЭлементФормы = Форма.Элементы["ВыбратьКвартал" + НомерКвартала]; // ПолеФормы, КнопкаФормы -
			ЭлементФормы.Доступность = (НомерКвартала >= МинимальныйКвартал);
		КонецЦикла;
		
	КонецЕсли;
	
	// Выбор месяца
	МинимальныйМесяц = ?(Не ПервыйГод, 1, Месяц(Форма.ОграничениеСнизу));
	Для НомерМесяца = 1 По 12 Цикл
		ЭлементФормы = Форма.Элементы["ВыбратьМесяц" + НомерМесяца]; // ПолеФормы, КнопкаФормы -
		ЭлементФормы.Доступность = (НомерМесяца >= МинимальныйМесяц);
	КонецЦикла;
	
КонецПроцедуры

#КонецОбласти
