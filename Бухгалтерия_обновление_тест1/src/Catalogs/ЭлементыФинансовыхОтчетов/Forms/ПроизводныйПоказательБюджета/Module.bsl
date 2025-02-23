#Область ОписаниеПеременных

&НаКлиенте
Перем ЗакрытиеФормы;

#КонецОбласти

#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	СпособЗаполненияСтатьи = Неопределено;
	
	Если Параметры.Свойство("АвтоТест") Тогда // Возврат при получении формы для анализа.
		Возврат;
	КонецЕсли;
	
	ДанныеОбъекта = Справочники.ЭлементыФинансовыхОтчетов.ФормаПриСозданииНаСервере(ЭтотОбъект);
	ИдентификаторГлавногоХранилища = Параметры.ИдентификаторГлавногоХранилища;
	ИспользоватьДляВводаПлана = Параметры.ИспользоватьДляВводаПлана;
	ВариантРасположенияГраницыФактическихДанных = Параметры.ВариантРасположенияГраницыФактическихДанных;
	
	Если Параметры.Свойство("НастройкаЯчеек") Тогда
		РежимДерева = Перечисления.РежимыОтображенияДереваНовыхЭлементов.ПроизводныйПоказательСложнойТаблицы;
		АдресЭлементовОтчета = Параметры.АдресЭлементовОтчета;
		АдресТаблицыЭлементов = Параметры.АдресТаблицыЭлементов;
		ИдентификаторСтрокиЭлементаОтчета = Параметры.ИдентификаторСтрокиЭлементаОтчета;
		РедактируемыеЗначения = Параметры.РедактируемыеЗначения;
		Элементы.ОперандыЗафиксироватьПоВертикали.Видимость = Истина;
		Элементы.ОперандыЗафиксироватьПоГоризонтали.Видимость = Истина;
	ИначеЕсли Параметры.Свойство("СпособЗаполнения", СпособЗаполненияСтатьи) Тогда
		Если СпособЗаполненияСтатьи = 1 Тогда
			РежимДерева = Перечисления.РежимыОтображенияДереваНовыхЭлементов.НастройкаАвторасчетаСложнойТаблицы;
			ИдентификаторСтрокиЭлементаОтчета = Параметры.ИдентификаторСтрокиЭлементаОтчета;
			Элементы.ОперандыЗафиксироватьПоВертикали.Видимость = Истина;
			Элементы.ОперандыЗафиксироватьПоГоризонтали.Видимость = Истина;
		ИначеЕсли СпособЗаполненияСтатьи = 2 Тогда
			РежимДерева = Перечисления.РежимыОтображенияДереваНовыхЭлементов.ЗаполнениеСтатьиБюджетов;
		КонецЕсли;
		АдресЭлементовОтчета = Параметры.АдресЭлементовОтчета;
		АдресТаблицыЭлементов = Параметры.АдресТаблицыЭлементов;
		АдресРедактируемогоЭлемента = Параметры.АдресРедактируемогоЭлемента;
	Иначе
		ДеревоЭлементов = ДанныеФормыВЗначение(Параметры.ЭлементыОтчета, Тип("ДеревоЗначений"));
		АдресЭлементовОтчета = ПоместитьВоВременноеХранилище(ДеревоЭлементов, УникальныйИдентификатор);
		РежимДерева = Перечисления.РежимыОтображенияДереваНовыхЭлементов.ПроизводныйПоказательВидаБюджета;
		ИдентификаторСтрокиЭлементаОтчета = Параметры.ИдентификаторСтрокиЭлементаОтчета;
		РедактируемыеЗначения = Параметры.РедактируемыеЗначения;
	КонецЕсли;
	
	ОбновитьДеревоНовыхЭлементов();
	
	ДеревоОператоров = ФинансоваяОтчетностьВызовСервера.ПостроитьДеревоОператоров(Ложь);
	БюджетнаяОтчетностьВызовСервера.ДополнитьДеревоОператоров(ДеревоОператоров);
	ЗначениеВРеквизитФормы(ДеревоОператоров, "Операторы");
	ОбновитьЗаголовокФормы();
	
	Для Каждого СтрокаОперанда Из ДанныеОбъекта.ОперандыФормулы Цикл
		НоваяСтрока = Операнды.Добавить();
		НоваяСтрока.ЭлементОтчета = СтрокаОперанда.Операнд;
		НоваяСтрока.Идентификатор = СтрокаОперанда.Идентификатор;
		НоваяСтрока.АдресСтруктурыЭлемента = СтрокаОперанда.АдресСтруктурыЭлемента;
		Если ЗначениеЗаполнено(НоваяСтрока.АдресСтруктурыЭлемента) Тогда
			ДанныеЭлемента = ПолучитьИзВременногоХранилища(НоваяСтрока.АдресСтруктурыЭлемента);
		Иначе
			ДанныеЭлемента = НоваяСтрока.ЭлементОтчета;
		КонецЕсли;
		БюджетнаяОтчетностьКлиентСервер.ЗаполнитьСтрокуСпискаЭлементовОтчета(ДанныеЭлемента, 
					НоваяСтрока, 
					НоваяСтрока.АдресСтруктурыЭлемента);
		НоваяСтрока.НестандартнаяКартинка = ФинансоваяОтчетностьПовтИсп.НестандартнаяКартинка(НоваяСтрока.ВидЭлемента);
		
		НоваяСтрока.ПривилегированныйРежимКартинка = Не Число(НоваяСтрока.ПривилегированныйРежим);
		
	КонецЦикла;
	
	Параметры.Свойство("РодительВидЭлемента", РодительВидЭлемента);
	
	СобытияФорм.ПриСозданииНаСервере(ЭтотОбъект, Отказ, СтандартнаяОбработка);

КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)
	
	РазделыОператоров = Операторы.ПолучитьЭлементы();
	Если РазделыОператоров.Количество() > 0 Тогда
		Элементы.Операторы.Развернуть(РазделыОператоров[0].ПолучитьИдентификатор());
	КонецЕсли;
	
КонецПроцедуры

&НаСервере
Процедура ПередЗаписьюНаСервере(Отказ, ТекущийОбъект, ПараметрыЗаписи)
		
	Если НЕ Отказ Тогда
		ПривилегированныйРежим = Ложь;
		Справочники.ЭлементыФинансовыхОтчетов.ФормаПередЗаписьюНаСервере(ЭтотОбъект, ТекущийОбъект, Отказ);
		Если ЗначениеЗаполнено(АдресЭлементаВХранилище) Тогда
			СтруктураЭлемента = ПолучитьИзВременногоХранилища(АдресЭлементаВХранилище);
			СтруктураЭлемента.ОперандыФормулы.Очистить();
			Для Каждого СтрокаОперанда Из Операнды Цикл
				Если Не ЗначениеЗаполнено(СтрокаОперанда.АдресСтруктурыЭлемента) Тогда
					СтрокаОперанда.АдресСтруктурыЭлемента = БюджетнаяОтчетностьКлиентСервер.ПоместитьЭлементВХранилище(СтрокаОперанда, ИдентификаторГлавногоХранилища);
				КонецЕсли;
				НоваяСтрокаОперанда = СтруктураЭлемента.ОперандыФормулы.Добавить();
				ЗаполнитьЗначенияСвойств(НоваяСтрокаОперанда, СтрокаОперанда);
				НоваяСтрокаОперанда.Операнд = СтрокаОперанда.ЭлементОтчета;
			КонецЦикла;
			СтруктураЭлемента.Вставить("ЕстьПривилегированныйРежим", ЕстьПривилегированныйРежим);
			ПоместитьВоВременноеХранилище(СтруктураЭлемента, АдресЭлементаВХранилище);
		КонецЕсли;
	КонецЕсли;
	
КонецПроцедуры

&НаСервере
Процедура ПослеЗаписиНаСервере(ТекущийОбъект, ПараметрыЗаписи)
	
	ОбновитьЗаголовокФормы();
	
КонецПроцедуры

&НаКлиенте
Процедура ПередЗакрытием(Отказ, СтандартнаяОбработка)
	
	Если ЗначениеЗаполнено(АдресЭлементаВХранилище) Тогда
		СтандартнаяОбработка = Ложь;
		Если Модифицированность И Не ЗакрытиеФормы = Истина Тогда
			ОписаниеОповещения = Новый ОписаниеОповещения("ПередЗакрытиемОбработкаОповещения", ЭтотОбъект);
			ТекстВопроса = НСтр("ru='Все внесенные изменения будут потеряны. Закрыть форму?';uk='Всі зміни будуть втрачені. Закрити форму?'");
			ПоказатьВопрос(ОписаниеОповещения, ТекстВопроса, РежимДиалогаВопрос.ДаНет);
			Отказ = Истина;
		КонецЕсли;
	КонецЕсли;
	
КонецПроцедуры

&НаСервере
Процедура ОбработкаПроверкиЗаполненияНаСервере(Отказ, ПроверяемыеРеквизиты)
	
	ОграничениеДлиныФормулы = ПланыВидовХарактеристик.РеквизитыЭлементовФинансовыхОтчетов.Формула.ТипЗначения.КвалификаторыСтроки.Длина;
	Если СтрДлина(Формула) > ОграничениеДлиныФормулы Тогда
		ТекстСообщения = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(
			НСтр("ru='Превышена максимальная длина формулы, введено %1 символов, доступно %2 символов.';uk='Перевищена максимальна довжина формули, введено %1 символів, доступно %2 символів.'"),
			СтрДлина(Формула),
			ОграничениеДлиныФормулы);
		ОбщегоНазначенияКлиентСервер.СообщитьПользователю(ТекстСообщения,,"Формула",,Отказ);
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовШапкиФормы

&НаКлиенте
Процедура КомментарийНачалоВыбора(Элемент, ДанныеВыбора, СтандартнаяОбработка)
	
	ОбщегоНазначенияКлиент.ПоказатьФормуРедактированияКомментария(
		Элемент.ТекстРедактирования,
		ЭтотОбъект,
		"Объект.Комментарий");
	
КонецПроцедуры

&НаКлиенте
Процедура БыстрыйПоискНовыхПриИзменении(Элемент)
	
	ОбновитьДеревоНовыхЭлементов();
	
КонецПроцедуры

&НаКлиенте
Процедура БыстрыйПоискНовыхОчистка(Элемент, СтандартнаяОбработка)
	
	ОбновитьДеревоНовыхЭлементов();
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийТаблицФормы

&НаКлиенте
Процедура ОператорыНачалоПеретаскивания(Элемент, ПараметрыПеретаскивания, Выполнение)
	
	Если ЗначениеЗаполнено(Элемент.ТекущиеДанные.Оператор) Тогда
		ПараметрыПеретаскивания.Значение = Элемент.ТекущиеДанные.Оператор;
	КонецЕсли;
	
	ДеревоОтправительСтроки = "Операторы";
	
КонецПроцедуры

&НаКлиенте
Процедура ОператорыВыбор(Элемент, ВыбраннаяСтрока, Поле, СтандартнаяОбработка)
	
	СтандартнаяОбработка = Ложь;
	ВставитьОператорВФормулу();
	
КонецПроцедуры

&НаКлиенте
Процедура ДеревоНовыхЭлементовВыбор(Элемент, ВыбраннаяСтрока, Поле, СтандартнаяОбработка)
	
	ВыбранныеОперанды = Новый Массив;
	ВыбранныеОперанды.Добавить(Элемент.ТекущиеДанные);
	БюджетнаяОтчетностьКлиентСервер.ДобавитьОперандыФормулы(ЭтотОбъект, ВыбранныеОперанды, Операнды, Истина);
	
КонецПроцедуры

&НаКлиенте
Процедура ДеревоНовыхЭлементовНачалоПеретаскивания(Элемент, ПараметрыПеретаскивания, Выполнение)
	
	ДеревоОтправительСтроки = "ДеревоНовыхЭлементов";
	ТекущиеДанные = Элемент.ТекущиеДанные;
	
	Если Не БюджетнаяОтчетностьКлиентСервер.ЭлементДоступенКакОперанд(ТекущиеДанные) Тогда
		Выполнение = Ложь;
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ДеревоНовыхЭлементовОкончаниеПеретаскивания(Элемент, ПараметрыПеретаскивания, СтандартнаяОбработка)
	
	Если ПараметрыПеретаскивания.Действие = ДействиеПеретаскивания.Отмена Тогда
		Возврат;
	КонецЕсли;
	
	Если ЭтоПеретаскиваниеЯчейки(ПараметрыПеретаскивания.Значение) Тогда
		
		НовыеОперанды = БюджетнаяОтчетностьКлиентСервер.ДобавитьОперандыФормулы(ЭтотОбъект,
				ПараметрыПеретаскивания.Значение,
				Операнды,
				Ложь);
		ЯчейкаТаблицы = ПредопределенноеЗначение("Перечисление.ВидыЭлементовФинансовогоОтчета.ЯчейкаТаблицы");
		
		Для Каждого НовыйОперанд Из НовыеОперанды Цикл
			
			Если НовыйОперанд.ВидЭлемента <> ЯчейкаТаблицы Тогда
				Продолжить;
			КонецЕсли;
			
			НовыйОперанд.АдресСтруктурыЭлемента = БюджетнаяОтчетностьКлиентСервер.ПоместитьЭлементВХранилище(
				НовыйОперанд, ИдентификаторГлавногоХранилища);
			
			ПараметрыФормы = Новый Структура();
			ПараметрыФормы.Вставить("ВидЭлемента", 						 ЯчейкаТаблицы);
			ПараметрыФормы.Вставить("ИспользоватьДляВводаПлана",		 ИспользоватьДляВводаПлана);
			ПараметрыФормы.Вставить("АдресТаблицыЭлементов", 			 АдресТаблицыЭлементов);
			ПараметрыФормы.Вставить("АдресЭлементовОтчета", 			 АдресЭлементовОтчета);
			ПараметрыФормы.Вставить("АдресЭлементаВХранилище", 			 НовыйОперанд.АдресСтруктурыЭлемента);
			ПараметрыФормы.Вставить("Операнд", 							 Операнды.Индекс(НовыйОперанд));
			Если РежимДерева = ПредопределенноеЗначение("Перечисление.РежимыОтображенияДереваНовыхЭлементов.НастройкаАвторасчетаСложнойТаблицы") Тогда
				ПараметрыФормы.Вставить("АдресРедактируемогоЭлемента", 	 АдресРедактируемогоЭлемента);
			Иначе
				ПараметрыФормы.Вставить("АдресРедактируемогоЭлемента", 	 АдресЭлементаВХранилище);
			КонецЕсли;
			
			Оповещение = Новый ОписаниеОповещения("ОбработкаВыбораЯчейки", ЭтотОбъект, ПараметрыФормы);
			
			ОткрытьФорму("Справочник.ЭлементыФинансовыхОтчетов.ФормаОбъекта",
							ПараметрыФормы, ЭтотОбъект, , , , Оповещение, РежимОткрытияОкнаФормы.БлокироватьОкноВладельца);
			
		КонецЦикла;
		
	Иначе
		
		НовыеОперанды = БюджетнаяОтчетностьКлиентСервер.ДобавитьОперандыФормулы(ЭтотОбъект,
				ПараметрыПеретаскивания.Значение,
				Операнды,
				Ложь);
		ФинансоваяОтчетностьКлиент.ДобавитьТекстФормулы(ЭтотОбъект, НовыеОперанды);
		
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ОператорыОкончаниеПеретаскивания(Элемент, ПараметрыПеретаскивания, СтандартнаяОбработка)
	
	ОткрытьФормуДополнительныхПараметров(ПараметрыПеретаскивания.Значение);
	
КонецПроцедуры

&НаКлиенте
Процедура ВыборТипаИтогаФормулы(Результат, ДополнительныеПараметры) Экспорт
	
	Если Результат <> Неопределено Тогда
		Элементы.Формула.ВыделенныйТекст = "ИТОГ(<Значение>, """ + Результат + """)";
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ВыборПараметровРазностиДат(Результат, ДополнительныеПараметры) Экспорт
	
	Если Результат <> Неопределено Тогда
		Элементы.Формула.ВыделенныйТекст = "РАЗНОСТЬДАТ("
			+ Результат.НачалоПериода + ", "
			+ Результат.КонецПериода + " , """
			+ ФинансоваяОтчетностьКлиентСерверПовтИсп.ПериодичностьСтрокой(Результат.Периодичность) + """)";
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ОперандыПеретаскивание(Элемент, ПараметрыПеретаскивания, СтандартнаяОбработка, Строка, Поле)
	
	Если ЭтоПеретаскиваниеЯчейки(ПараметрыПеретаскивания.Значение) Тогда
		
		НовыеОперанды = БюджетнаяОтчетностьКлиентСервер.ДобавитьОперандыФормулы(ЭтотОбъект,
				ПараметрыПеретаскивания.Значение,
				Операнды,
				Истина);
		ЯчейкаТаблицы = ПредопределенноеЗначение("Перечисление.ВидыЭлементовФинансовогоОтчета.ЯчейкаТаблицы");
		
		Для Каждого НовыйОперанд Из НовыеОперанды Цикл
			
			Если НовыйОперанд.ВидЭлемента <> ЯчейкаТаблицы Тогда
				Продолжить;
			КонецЕсли;
			
			НовыйОперанд.АдресСтруктурыЭлемента = БюджетнаяОтчетностьКлиентСервер.ПоместитьЭлементВХранилище(НовыйОперанд, ИдентификаторГлавногоХранилища);
			
			ПараметрыФормы = Новый Структура();
			ПараметрыФормы.Вставить("ВидЭлемента", 						 ЯчейкаТаблицы);
			ПараметрыФормы.Вставить("ИспользоватьДляВводаПлана",		 ИспользоватьДляВводаПлана);
			ПараметрыФормы.Вставить("АдресТаблицыЭлементов", 			 АдресТаблицыЭлементов);
			ПараметрыФормы.Вставить("АдресЭлементовОтчета", 			 АдресЭлементовОтчета);
			ПараметрыФормы.Вставить("АдресЭлементаВХранилище", 			 НовыйОперанд.АдресСтруктурыЭлемента);
			ПараметрыФормы.Вставить("Операнд", 							 Операнды.Индекс(НовыйОперанд));
			ПараметрыФормы.Вставить("НеУстанавливатьТекстФормулы", 		 Истина);
			Если РежимДерева = ПредопределенноеЗначение("Перечисление.РежимыОтображенияДереваНовыхЭлементов.НастройкаАвторасчетаСложнойТаблицы") Тогда
				ПараметрыФормы.Вставить("АдресРедактируемогоЭлемента", 		АдресРедактируемогоЭлемента);
			Иначе
				ПараметрыФормы.Вставить("АдресРедактируемогоЭлемента", 		АдресЭлементаВХранилище);
			КонецЕсли;
			
			Оповещение = Новый ОписаниеОповещения("ОбработкаВыбораЯчейки", ЭтотОбъект, ПараметрыФормы);
		
			ОткрытьФорму("Справочник.ЭлементыФинансовыхОтчетов.ФормаОбъекта",
				ПараметрыФормы, ЭтотОбъект,,,, Оповещение, РежимОткрытияОкнаФормы.БлокироватьОкноВладельца);
			
		КонецЦикла;
		
	Иначе
		
		БюджетнаяОтчетностьКлиентСервер.ДобавитьОперандыФормулы(ЭтотОбъект,
				ПараметрыПеретаскивания.Значение,
				Операнды,
				Истина);
		
	КонецЕсли;
	
	// что бы не срабатывало события окончания перетаскивания дерева новых элементов
	ПараметрыПеретаскивания.Значение.Очистить();
	
КонецПроцедуры

&НаКлиенте
Процедура ОперандыОкончаниеПеретаскивания(Элемент, ПараметрыПеретаскивания, СтандартнаяОбработка)
	
	Если ПараметрыПеретаскивания.Действие = ДействиеПеретаскивания.Отмена Тогда
		Возврат;
	КонецЕсли;
	
	ФинансоваяОтчетностьКлиент.ДобавитьТекстФормулы(ЭтотОбъект, ПараметрыПеретаскивания.Значение);
	
КонецПроцедуры

&НаКлиенте
Процедура ОперандыВыбор(Элемент, ВыбраннаяСтрока, Поле, СтандартнаяОбработка)
	
	Если Поле.Имя <> "ПоказателиИдентификатор" Тогда
		РедактироватьПоказатель();
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ОперандыПередОкончаниемРедактирования(Элемент, НоваяСтрока, ОтменаРедактирования, Отказ)
	Если ДублирующийИдентификатор И Не ОтменаРедактирования Тогда
		Отказ = Истина;
	КонецЕсли;
КонецПроцедуры

&НаКлиенте
Процедура ОперандыИдентификаторОкончаниеВводаТекста(Элемент, Текст, ДанныеВыбора, СтандартнаяОбработка)
	
	СтандартнаяОбработка = Ложь;
	
	// Проверим уникальность идентификаторов
	ИсходныйИдентификатор = Элементы.Операнды.ТекущиеДанные.Идентификатор;
	НовыйИдентификатор = Текст;
	
	НайденныеСтроки = Операнды.НайтиСтроки(Новый Структура("Идентификатор", НовыйИдентификатор));
	Если НайденныеСтроки.Количество() > 0 Тогда
		ТекстПредупреждения = НСтр("ru='Дублирующий идентификатор ""%1"".';uk='Дублюючий ідентифікатор ""%1"".'");
		ТекстПредупреждения = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(
			ТекстПредупреждения,
			НовыйИдентификатор);
		ПоказатьПредупреждение(, ТекстПредупреждения);
		
		ДублирующийИдентификатор = Истина;
		
		Возврат;
	Иначе
		ДублирующийИдентификатор = Ложь;
	КонецЕсли;
	
	// Обновим идентификаторы в формуле
	ДанныеВыбора = Новый СписокЗначений;
	ДанныеВыбора.Добавить(НовыйИдентификатор);
	
	Элементы.Операнды.ТекущиеДанные.Идентификатор = НовыйИдентификатор;
	
	Текст = СокрЛП(Текст);
	ИсходноеВыражениеИд = "[" + ИсходныйИдентификатор + "]";
	НовоеВыражениеИд = "[" + НовыйИдентификатор + "]";
	Формула = СтрЗаменить(Формула, ИсходноеВыражениеИд, НовоеВыражениеИд);
	
КонецПроцедуры

&НаКлиенте
Процедура ОперандыПроверкаПеретаскивания(Элемент, ПараметрыПеретаскивания, СтандартнаяОбработка, Строка, Поле)
	
	Если ДеревоОтправительСтроки <> "ДеревоНовыхЭлементов" Тогда
		СтандартнаяОбработка = Ложь;
		ПараметрыПеретаскивания.Действие = ДействиеПеретаскивания.Отмена;
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ОперандыНачалоПеретаскивания(Элемент, ПараметрыПеретаскивания, Выполнение)
	
	ДеревоОтправительСтроки = "Операнды";
	
КонецПроцедуры

&НаКлиенте
Процедура ОперандыПриАктивизацииСтроки(Элемент)
	
	Элементы.ОперандыЗафиксироватьПоВертикали.Доступность = Ложь;
	Элементы.ОперандыЗафиксироватьПоГоризонтали.Доступность = Ложь;
	
	ТекущиеДанные = Элементы.Операнды.ТекущиеДанные;
	Если ТекущиеДанные <> Неопределено И
		ТекущиеДанные.ВидЭлемента = ПредопределенноеЗначение("Перечисление.ВидыЭлементовФинансовогоОтчета.ЯчейкаТаблицы") Тогда
		
		Элементы.ОперандыЗафиксироватьПоВертикали.Доступность = Истина;
		Элементы.ОперандыЗафиксироватьПоГоризонтали.Доступность = Истина;
		
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура ЗавершитьРедактирование(Команда)
	
	ЕстьПривилегированныйРежим = Операнды.НайтиСтроки(Новый Структура("ПривилегированныйРежим",Истина)).Количество() > 0;
	ДополнительныеСведения = Новый Структура();
	ДополнительныеСведения.Вставить("ЕстьПривилегированныйРежим", ЕстьПривилегированныйРежим);
	ФинансоваяОтчетностьКлиент.ЗавершитьРедактированиеЭлементаОтчета(ЭтотОбъект, ДополнительныеСведения);
	
КонецПроцедуры

&НаКлиенте
Процедура НайтиНовыйЭлемент(Команда)
	
	ОбновитьДеревоНовыхЭлементов();
	
КонецПроцедуры

&НаКлиенте
Процедура ПроверитьФормулу(Команда)
	
	ОчиститьСообщения();
	Отказ = Ложь;
	ПроверитьФормулуСервер(Отказ);
	Если НЕ Отказ Тогда
		ТекстПредупреждения = НСтр("ru='Синтаксических ошибок не обнаружено';uk='Синтаксичних помилок не виявлено'");
		ПоказатьПредупреждение(, ТекстПредупреждения);
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура РедактироватьОперанд(Команда)
	
	РедактироватьПоказатель();
	
КонецПроцедуры

&НаКлиенте
Процедура Подключаемый_ВыполнитьПереопределяемуюКоманду(Команда)
	
	СобытияФормКлиент.ВыполнитьПереопределяемуюКоманду(ЭтотОбъект, Команда);
	
КонецПроцедуры

&НаКлиенте
Процедура ЗафиксироватьПоГоризонтали(Команда)
	
	НеСмещатьПриКопированииНаСервере(Истина, Ложь);
	
КонецПроцедуры

&НаКлиенте
Процедура ЗафиксироватьПоВертикали(Команда)
	
	НеСмещатьПриКопированииНаСервере(Ложь, Истина);
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаКлиенте
Процедура ПередЗакрытиемОбработкаОповещения(Результат, ДополнительныеПараметры) Экспорт
	
	Если Результат = КодВозвратаДиалога.Да Тогда
		ЗакрытиеФормы = Истина;
		ЭтотОбъект.Закрыть();
	КонецЕсли;
	
КонецПроцедуры

&НаСервере
Процедура ПроверитьФормулуСервер(Отказ)
	
	БюджетнаяОтчетностьВыводСервер.ПроверитьФормулу(Формула, Операнды.Выгрузить(), Отказ);
	
КонецПроцедуры

&НаСервере
Процедура ОбновитьЗаголовокФормы(Запись = Ложь)
	
	Если НЕ ЗначениеЗаполнено(Объект.НаименованиеДляПечати) Тогда
		Заголовок = НСтр("ru='Производный показатель (создание)';uk='Похідний показник (створення)'");
	Иначе
		Заголовок = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(
			НСтр("ru='%1 %2';uk='%1 %2'"),
			Объект.НаименованиеДляПечати,
			НСтр("ru='(Производный показатель)';uk='(Похідний показник)'"));
	КонецЕсли;
	
КонецПроцедуры

&НаСервере
Процедура ОбновитьДеревоНовыхЭлементов()
	
	ПараметрыДерева = Новый Структура;
	ПараметрыДерева.Вставить("ИмяЭлементаДерева", "ДеревоНовыхЭлементов");
	ПараметрыДерева.Вставить("БыстрыйПоиск", БыстрыйПоискНовых);
	ПараметрыДерева.Вставить("РежимДерева", РежимДерева);
	ПараметрыДерева.Вставить("МодельБюджетирования", Объект.Владелец);
	ПараметрыДерева.Вставить("ИдентификаторСтрокиЭлементаОтчета", ИдентификаторСтрокиЭлементаОтчета);
	ПараметрыДерева.Вставить("ИспользоватьДляВводаПлана", ИспользоватьДляВводаПлана);
	ПараметрыДерева.Вставить("РедактируемыеЗначения", РедактируемыеЗначения);
	
	БюджетнаяОтчетностьВызовСервера.ОбновитьДеревоНовыхЭлементов(ЭтотОбъект, ПараметрыДерева);
	
КонецПроцедуры

&НаКлиенте
Процедура ОткрытьФормуДополнительныхПараметров(ТекстФормулы)
	
	ПараметрыФормы = Новый Структура();
	ПараметрыФормы.Вставить("АдресТаблицыЭлементов", АдресТаблицыЭлементов);
	ПараметрыФормы.Вставить("АдресЭлементовОтчета", АдресЭлементовОтчета);
	Если ЗначениеЗаполнено(АдресРедактируемогоЭлемента) Тогда
		ПараметрыФормы.Вставить("АдресРедактируемогоЭлемента", АдресРедактируемогоЭлемента);
	Иначе
		ПараметрыФормы.Вставить("АдресРедактируемогоЭлемента", АдресЭлементаВХранилище);
	КонецЕсли;
	Если СтрНайти(ТекстФормулы, "ИТОГ(") Тогда
		Оповещение = Новый ОписаниеОповещения("ВыборТипаИтогаФормулы", ЭтотОбъект);
		ОткрытьФорму("Справочник.ЭлементыФинансовыхОтчетов.Форма.ВыборИзмеренийИтога",
			ПараметрыФормы, ЭтотОбъект,,,, Оповещение, РежимОткрытияОкнаФормы.БлокироватьОкноВладельца);
	ИначеЕсли СтрНайти(ТекстФормулы, "РАЗНОСТЬДАТ(") Тогда
		Оповещение = Новый ОписаниеОповещения("ВыборПараметровРазностиДат", ЭтотОбъект);
		ОткрытьФорму("Справочник.ЭлементыФинансовыхОтчетов.Форма.ВыборПараметровРазностьДат",
			ПараметрыФормы, ЭтотОбъект,,,, Оповещение, РежимОткрытияОкнаФормы.БлокироватьОкноВладельца);
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ВставитьОператорВФормулу()
	
	Если ЗначениеЗаполнено(Элементы.Операторы.ТекущиеДанные.Оператор) Тогда
		ТекстДляВставки = Элементы.Операторы.ТекущиеДанные.Оператор;
		Если Элементы.Операторы.ТекущиеДанные.Наименование = "( )" 
			И ЗначениеЗаполнено(Элементы.Формула.ВыделенныйТекст) Тогда
			ТекстДляВставки = "(" + Элементы.Формула.ВыделенныйТекст + ")";
		КонецЕсли;
		ПерваяСтрока = 0; ПерваяКолонка = 0; ПоследняяСтрока = 0; ПоследняяКолонка = 0;
		Элементы.Формула.ПолучитьГраницыВыделения(ПерваяСтрока, ПерваяКолонка, 
													ПоследняяСтрока, ПоследняяКолонка);
		Элементы.Формула.ВыделенныйТекст = ТекстДляВставки;
		Элементы.Формула.УстановитьГраницыВыделения(ПерваяСтрока, ПерваяКолонка, ПерваяСтрока, 
																ПерваяКолонка + СтрДлина(ТекстДляВставки));
		ОткрытьФормуДополнительныхПараметров(ТекстДляВставки);
	КонецЕсли;
	
КонецПроцедуры


// Возвращает строку таблицы Операнды.
// 
// Параметры:
// 	ИндексСтроки - Число - 
// Возвращаемое значение:
// 	ДанныеФормыЭлементКоллекции - :
// 	 *ЭлементОтчета - СправочникСсылка.ЭлементыФинансовыхОтчетов -
// 	 *Идентификатор - Строка -
// 	 *НаименованиеДляПечати - Строка -
// 	 *НестандартнаяКартинка - Число - 
// 	 *ВидЭлемента - ПеречислениеСсылка.ВидыЭлементовФинансовогоОтчета -
// 	 *ЕстьНастройки - Булево -
// 	 *АдресСтруктурыЭлемента - Строка -
// 	 *Комментарий - Строка -
// 	 *ВыводимыеПоказатели - ПеречислениеСсылка.ТипыВыводимыхПоказателейБюджетногоОтчета -
// 	 *ТипЗначенияПоказателя - ПеречислениеСсылка.ТипыЗначенийПоказателейБюджетногоОтчета -
// 	 *ОбратныйЗнак - Булево - 
// 	 *СтатьяПоказательТипИзмерения - СправочникСсылка.СтатьиБюджетов -
// 	 								- ПеречислениеСсылка.Периодичность -
// 	 								- СправочникСсылка.ПоказателиБюджетов -
// 	 								- Строка -
// 	 								- ПланВидовХарактеристикСсылка.АналитикиСтатейБюджетов -
// 	 								- СправочникСсылка.НефинансовыеПоказателиБюджетов -
// 	 								- СправочникСсылка.Сценарии - 
// 	 *ПривилегированныйРежимКартинка - Число -
// 	 *ПривилегированныйРежим - Булево -
// 	
&НаКлиенте
Функция СтрокаОперандаПоИндексуСтроки(ИндексСтроки)
	Возврат Операнды[ИндексСтроки];
КонецФункции

&НаКлиенте
Процедура ОбработкаВыбораЯчейки(Результат, ДополнительныеПараметры) Экспорт
	
	Операнд = ДополнительныеПараметры.Операнд;
	Если Результат = Неопределено Тогда
		Операнды.Удалить(Операнд);
		Элементы.Формула.ВыделенныйТекст = "";
		Возврат;
	КонецЕсли;
	
	Операнд = СтрокаОперандаПоИндексуСтроки(Операнд);
	Операнд.Идентификатор = БюджетнаяОтчетностьКлиентСервер.ИмяОперанда(Результат.ИмяЯчейки, Операнд, Операнды, Ложь);
	Для Каждого СтрокаОперанда Из Операнды Цикл
		Если СтрокаОперанда.Идентификатор = Операнд.Идентификатор 
			И СтрокаОперанда.АдресСтруктурыЭлемента <> Операнд.АдресСтруктурыЭлемента Тогда
			Операнды.Удалить(Операнд);
			Прервать;
		КонецЕсли;
	КонецЦикла;
	
	Если НЕ ДополнительныеПараметры.Свойство("НеУстанавливатьТекстФормулы") Тогда
		Массив = Новый Массив;
		Массив.Добавить(Операнд);
		ФинансоваяОтчетностьКлиент.ДобавитьТекстФормулы(ЭтотОбъект, Массив);
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Функция ЭтоПеретаскиваниеЯчейки(Значение)
	
	Для Каждого СтрокаПеретаскивания Из Значение Цикл
		Если СтрокаПеретаскивания.ВидЭлемента = ПредопределенноеЗначение("Перечисление.ВидыЭлементовФинансовогоОтчета.ЯчейкаТаблицы") Тогда
			Возврат Истина;
		КонецЕсли;
	КонецЦикла;
	
	Возврат Ложь;
	
КонецФункции

&НаКлиенте
Процедура РедактироватьПоказатель()
	
	ВыделенныеСтроки = ОбщегоНазначенияУТКлиент.ПроверитьПолучитьВыделенныеВСпискеСсылки(Элементы.Операнды);
	Если ВыделенныеСтроки.Количество() = 0 Тогда
		Возврат;
	КонецЕсли;
	
	ТекущиеДанные = Элементы.Операнды.ТекущиеДанные;
	
	Если ПустаяСтрока(ТекущиеДанные.АдресСтруктурыЭлемента) Тогда
		ТекущиеДанные.АдресСтруктурыЭлемента = БюджетнаяОтчетностьКлиентСервер.ПоместитьЭлементВХранилище(ТекущиеДанные, ИдентификаторГлавногоХранилища);
	КонецЕсли;
	
	ПараметрыФормы = Новый Структура();
	ПараметрыФормы.Вставить("Ключ", 							ТекущиеДанные.ЭлементОтчета);
	ПараметрыФормы.Вставить("ВидЭлемента", 						ТекущиеДанные.ВидЭлемента);
	ПараметрыФормы.Вставить("АдресЭлементаВХранилище", 			ТекущиеДанные.АдресСтруктурыЭлемента);
	ПараметрыФормы.Вставить("ИдентификаторГлавногоХранилища", 	ИдентификаторГлавногоХранилища);
	ПараметрыФормы.Вставить("ИспользоватьДляВводаПлана", 		ИспользоватьДляВводаПлана);
	ПараметрыФормы.Вставить("ПроизвольныйПоказатель", 			Истина);
	ПараметрыФормы.Вставить("АдресЭлементовОтчета", 			АдресЭлементовОтчета);
	ПараметрыФормы.Вставить("АдресТаблицыЭлементов", 			АдресТаблицыЭлементов);
	Если ЗначениеЗаполнено(АдресРедактируемогоЭлемента) Тогда
		ПараметрыФормы.Вставить("АдресРедактируемогоЭлемента", АдресРедактируемогоЭлемента);
	Иначе
		ПараметрыФормы.Вставить("АдресРедактируемогоЭлемента", АдресЭлементаВХранилище);
	КонецЕсли;
	ПараметрыФормы.Вставить("ВариантРасположенияГраницыФактическихДанных", ВариантРасположенияГраницыФактическихДанных);
	Если НЕ РодительВидЭлемента = ПредопределенноеЗначение("Перечисление.ВидыЭлементовФинансовогоОтчета.СтатьяБюджетов") Тогда
		// Если Производный показатель не принадлежит Статье бюджетов, то показывается флаг "ИсключитьДанныеВводимогоДокументаПриРасчете".
		ПараметрыФормы.Вставить("РодительВидЭлемента",
			ПредопределенноеЗначение("Перечисление.ВидыЭлементовФинансовогоОтчета.ПроизводныйПоказатель"));
	КонецЕсли;
		
	Оповещение = Новый ОписаниеОповещения("ОбновитьСтрокуВидаБюджетаПослеИзменения", ЭтотОбъект, ПараметрыФормы);
	
	ОткрытьФорму("Справочник.ЭлементыФинансовыхОтчетов.ФормаОбъекта",
		ПараметрыФормы, ЭтотОбъект,,,, Оповещение, РежимОткрытияОкнаФормы.БлокироватьОкноВладельца);
	
КонецПроцедуры

&НаКлиенте
Процедура ОбновитьСтрокуВидаБюджетаПослеИзменения(Результат, ДополнительныеПараметры) Экспорт
	
	БюджетнаяОтчетностьКлиентСервер.ЗаполнитьСтрокуСпискаЭлементовОтчета(Результат, 
					Элементы.Операнды.ТекущиеДанные,
					ДополнительныеПараметры.АдресЭлементаВХранилище, 
					Операнды);
		
	ТекущиеДанные = Элементы.Операнды.ТекущиеДанные;
	ТекущиеДанные.ПривилегированныйРежимКартинка = Не Число(ТекущиеДанные.ПривилегированныйРежим);
		
КонецПроцедуры

&НаСервере
Процедура НеСмещатьПриКопированииНаСервере(ПоГоризонтали, ПоВертикали)
	
	РазделительЯчеек = БюджетнаяОтчетностьКлиентСервер.РазделительЯчеекСложнойТаблицы();
	
	СтрокаОперандов = Операнды.НайтиПоИдентификатору(Элементы.Операнды.ТекущаяСтрока);
	Идентификатор = СтрокаОперандов.Идентификатор;
	ПараметрыИдентификатора = Справочники.ЭлементыФинансовыхОтчетов.РазобратьИмяОперандаНаСоставляющие(Идентификатор);
	
	Если ПоГоризонтали Тогда
		ПараметрыИдентификатора.КолонкаФиксированная = НЕ ПараметрыИдентификатора.КолонкаФиксированная;
		Если Не ЗначениеЗаполнено(ПараметрыИдентификатора.Колонка) Тогда
			ПараметрыИдентификатора.СтрокаФиксированная = ПараметрыИдентификатора.КолонкаФиксированная;
		КонецЕсли;
	КонецЕсли;
	
	Если ПоВертикали Тогда
		ПараметрыИдентификатора.СтрокаФиксированная = НЕ ПараметрыИдентификатора.СтрокаФиксированная;
	КонецЕсли;
	
	Текст = ?(ПараметрыИдентификатора.СтрокаФиксированная, "$", "") + ПараметрыИдентификатора.Строка;
	Если ЗначениеЗаполнено(ПараметрыИдентификатора.Колонка) Тогда
		Текст = Текст + РазделительЯчеек + ?(ПараметрыИдентификатора.КолонкаФиксированная, "$", "") + ПараметрыИдентификатора.Колонка;
	КонецЕсли;
	
	СтрокаОперандов.Идентификатор = Текст;
	
	Текст = СокрЛП(Текст);
	НовыйИд = "[" + Текст + "]";
	СтарыйИд = "[" + Идентификатор + "]";
	Формула = СтрЗаменить(Формула, СтарыйИд, НовыйИд);
	
КонецПроцедуры

#КонецОбласти
