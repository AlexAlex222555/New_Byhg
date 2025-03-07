#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	Если Параметры.Свойство("АвтоТест") Тогда // Возврат при получении формы для анализа.
		Возврат;
	КонецЕсли;
	
	Параметры.Свойство("Заголовок",			Заголовок);
	Параметры.Свойство("ОрганизацияСсылка",	ОрганизацияСсылка);
	
	ПрочитатьДанные();
	
	ОбновитьЭлементыФормыПоТекущимНастройкам();
	
	ЭтаФорма.ТолькоПросмотр = ОбособленноеПодразделение;
	

КонецПроцедуры

&НаКлиенте
Процедура ПередЗакрытием(Отказ, ЗавершениеРаботы, ТекстПредупреждения, СтандартнаяОбработка)
	
	Оповещение = Новый ОписаниеОповещения("СохранитьИЗакрыть", ЭтотОбъект);
	ОбщегоНазначенияКлиент.ПоказатьПодтверждениеЗакрытияФормы(Оповещение, Отказ, ЗавершениеРаботы);
	
КонецПроцедуры

&НаКлиенте
Процедура ОбработкаОповещения(ИмяСобытия, Параметр, Источник)
	
	Если ИмяСобытия = "ОтредактированаИстория" И ОрганизацияСсылка = Источник Тогда
		
		Если Параметр.ИмяРегистра = "НастройкиРасчетаРезервовОтпусков" Тогда
			
			Если НастройкиРасчетаРезервовОтпусковНаборЗаписейПрочитан Тогда
				
				РедактированиеПериодическихСведенийКлиент.ОбработкаОповещения(
				ЭтаФорма,
				ОрганизацияСсылка,
				ИмяСобытия,
				Параметр,
				Источник);
				
			КонецЕсли;
			
		КонецЕсли;
		
	КонецЕсли;
	
КонецПроцедуры

&НаСервере
Процедура ОбработкаПроверкиЗаполненияНаСервере(Отказ, ПроверяемыеРеквизиты)
	
	РедактированиеПериодическихСведений.ПроверитьЗаписьВФорме(ЭтаФорма, "НастройкиРасчетаРезервовОтпусков", ОрганизацияСсылка, Отказ);
	
	Если Не Отказ Тогда
		
		ПроверитьЗаполнение = НастройкиРасчетаРезервовОтпусков.ФормироватьРезервОтпусковБУ
			И (НастройкиРасчетаРезервовОтпусков.МетодНачисленияРезерваОтпусков = ПредопределенноеЗначение("Перечисление.МетодыНачисленияРезервовОтпусков.НормативныйМетод"));
			
			Если ПроверитьЗаполнение Тогда
				
				МетаданныеРегистра = Метаданные.РегистрыСведений.НастройкиРасчетаРезервовОтпусков;
				Если НастройкиРасчетаРезервовОтпусков.НормативОтчисленийВРезервОтпусков = 0 Тогда
					ТекстСообщения = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(НСтр("ru='Не заполнено поле ""%1"".';uk='Не заповнено поле ""%1"".'"), МетаданныеРегистра.Ресурсы.НормативОтчисленийВРезервОтпусков.Синоним);
					ПутьКРеквизитуФормы = "НастройкиРасчетаРезервовОтпусков.НормативОтчисленийВРезервОтпусков";
					ОбщегоНазначенияКлиентСервер.СообщитьПользователю(ТекстСообщения, ,	ПутьКРеквизитуФормы, , Отказ);
				КонецЕсли;
				
				Если НастройкиРасчетаРезервовОтпусков.ПредельнаяВеличинаОтчисленийВРезервОтпусков = 0 Тогда
					ТекстСообщения = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(НСтр("ru='Не заполнено поле ""%1"".';uk='Не заповнено поле ""%1"".'"), МетаданныеРегистра.Ресурсы.ПредельнаяВеличинаОтчисленийВРезервОтпусков.Синоним);
					ПутьКРеквизитуФормы = "НастройкиРасчетаРезервовОтпусков.ПредельнаяВеличинаОтчисленийВРезервОтпусков";
					ОбщегоНазначенияКлиентСервер.СообщитьПользователю(ТекстСообщения, ,	ПутьКРеквизитуФормы, , Отказ);
				КонецЕсли;
				
			КонецЕсли;
		
	КонецЕсли;
	
КонецПроцедуры


#КонецОбласти

#Область ОбработчикиСобытийЭлементовШапкиФормы

&НаКлиенте
Процедура ГодНастроекПриИзменении(Элемент)
	
	НастройкиРасчетаРезервовОтпусков.Период = Дата(ГодНастроек,1,1);
	
КонецПроцедуры

&НаКлиенте
Процедура ГодНастроекРегулирование(Элемент, Направление, СтандартнаяОбработка)
	
	НастройкиРасчетаРезервовОтпусков.Период = Дата(ГодНастроек,1,1);
	
КонецПроцедуры

&НаКлиенте
Процедура ФормироватьРезервОтпусковБУПриИзменении(Элемент)
	
	Если НастройкиРасчетаРезервовОтпусков.ФормироватьРезервОтпусковБУ Тогда
		
		Если Не ЗначениеЗаполнено(НастройкиРасчетаРезервовОтпусков.МетодНачисленияРезерваОтпусков) Тогда
			НастройкиРасчетаРезервовОтпусков.МетодНачисленияРезерваОтпусков = ПредопределенноеЗначение("Перечисление.МетодыНачисленияРезервовОтпусков.НормативныйМетод");
		КонецЕсли;
		
	Иначе
		
		НастройкиРасчетаРезервовОтпусков.НормативОтчисленийВРезервОтпусков = 0;
		НастройкиРасчетаРезервовОтпусков.ПредельнаяВеличинаОтчисленийВРезервОтпусков = 0;
		НастройкиРасчетаРезервовОтпусков.МетодНачисленияРезерваОтпусков = ПредопределенноеЗначение("Перечисление.МетодыНачисленияРезервовОтпусков.ПустаяСсылка");
		
	КонецЕсли;
	
	ОбновитьДоступностьНастроек(ЭтаФорма);
	
КонецПроцедуры

&НаКлиенте
Процедура МетодНачисленияРезерваОтпусковПриИзменении(Элемент)
	
	ОбработатьИзменениеНастроекМетодаНачисления();
	ОбновитьДоступностьНастроек(ЭтаФорма);
	
КонецПроцедуры


&НаКлиенте
Процедура ОбработатьИзменениеНастроекМетодаНачисления()

	ДоступностьНастроек = НастройкиРасчетаРезервовОтпусков.ФормироватьРезервОтпусковБУ
	И (НастройкиРасчетаРезервовОтпусков.МетодНачисленияРезерваОтпусков = ПредопределенноеЗначение("Перечисление.МетодыНачисленияРезервовОтпусков.НормативныйМетод"));
	Если Не ДоступностьНастроек Тогда
		НастройкиРасчетаРезервовОтпусков.НормативОтчисленийВРезервОтпусков = 0;	
		НастройкиРасчетаРезервовОтпусков.ПредельнаяВеличинаОтчисленийВРезервОтпусков = 0;	
	КонецЕсли;

КонецПроцедуры


#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура НастройкиРасчетаРезервовОтпусковИстория(Команда)
	
	ОткрытьФормуРедактированияИстории("НастройкиРасчетаРезервовОтпусков", ГоловнаяОрганизация, ЭтаФорма, ОбособленноеПодразделение);
	
КонецПроцедуры

&НаКлиенте
Процедура ЗаписатьИЗакрыть(Команда)
	
	СохранитьИЗакрытьНаКлиенте();
	
КонецПроцедуры

&НаКлиенте
Процедура Записать(Команда)
	
	СохранитьИЗакрытьНаКлиенте(Ложь);

КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаКлиенте
Процедура СохранитьИЗакрытьНаКлиенте(ЗакрытьФорму = Истина) Экспорт 

	ДополнительныеПараметры = Новый Структура("ЗакрытьФорму", ЗакрытьФорму);
	
	Оповещение = Новый ОписаниеОповещения("СохранитьИЗакрытьНаКлиентеЗавершение", ЭтотОбъект, ДополнительныеПараметры);
	СохранитьДанные(Ложь, Оповещение);
	
КонецПроцедуры

&НаКлиенте
Процедура СохранитьИЗакрытьНаКлиентеЗавершение(Отказ, ДополнительныеПараметры) Экспорт 

	Если Не Отказ И Открыта() Тогда
		
		Модифицированность = Ложь;
		Если ДополнительныеПараметры.ЗакрытьФорму Тогда
			Закрыть();
		КонецЕсли; 
		
	КонецЕсли; 
	
КонецПроцедуры

&НаКлиенте
Процедура СохранитьДанные(Отказ, ОповещениеЗавершения = Неопределено) Экспорт
	
	Если Не Модифицированность Тогда
		Если ОповещениеЗавершения <> Неопределено Тогда 
			ВыполнитьОбработкуОповещения(ОповещениеЗавершения, Отказ);
		КонецЕсли;
		Возврат;
	КонецЕсли;
	
	ТекстКнопкиДа = НСтр("ru='Изменились сведения о настройках';uk='Змінилися відомості про налаштування'");
	ТекстВопроса = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(
			НСтр("ru='При редактировании изменены сведения о настройках.
                        |Если исправлена прежняя запись (она была ошибочной), нажмите ""Исправлена ошибка"".
                        |Если изменились сведения с %1, нажмите'
                        |;uk='При редагуванні змінені відомості про настройки.
                        |Якщо виправлений колишній запис (він був помилковим), натисніть ""Виправлена помилка"".
                        |Якщо змінились відомості з %1, натисніть'") + " ""%2""",
			Формат(НастройкиРасчетаРезервовОтпусков.Период, "ДФ='д ММММ гггг ""г""'"),
			ТекстКнопкиДа);
			
	Оповещение = Новый ОписаниеОповещения("СохранитьДанныеЗавершение", ЭтотОбъект, ОповещениеЗавершения);
	РедактированиеПериодическихСведенийКлиент.ЗапроситьРежимИзмененияРегистра(ЭтаФорма, "НастройкиРасчетаРезервовОтпусков", ТекстВопроса, ТекстКнопкиДа, Отказ, Оповещение);
			
КонецПроцедуры

&НаКлиенте
Процедура СохранитьДанныеЗавершение(Отказ, ОповещениеЗавершения) Экспорт  
	
	СохранитьДанныеНаСервере(Отказ);
	
	Если НЕ Отказ И ОповещениеЗавершения <> Неопределено Тогда 
		ВыполнитьОбработкуОповещения(ОповещениеЗавершения, Отказ);
	КонецЕсли;
	
КонецПроцедуры

&НаСервере
Процедура ПрочитатьДанные()
	
	ГоловнаяОрганизация = ЗарплатаКадрыПовтИсп.ГоловнаяОрганизация(ОрганизацияСсылка);
	ОбособленноеПодразделение = ОбщегоНазначения.ЗначениеРеквизитаОбъекта(ОрганизацияСсылка,"ОбособленноеПодразделение");
	
	ЮридическоеФизическоеЛицо = ОбщегоНазначения.ЗначениеРеквизитаОбъекта(ГоловнаяОрганизация,"ЮридическоеФизическоеЛицо");
	ЭтоЮрЛицо = ЮридическоеФизическоеЛицо = Перечисления.ЮридическоеФизическоеЛицо.ЮридическоеЛицо;
	
	РедактированиеПериодическихСведений.ПрочитатьЗаписьДляРедактированияВФорме(ЭтаФорма, "НастройкиРасчетаРезервовОтпусков", ГоловнаяОрганизация);
	
	Если Не ЗначениеЗаполнено(НастройкиРасчетаРезервовОтпусков.Период) Тогда
		ГодНастроек = 2014;
		НастройкиРасчетаРезервовОтпусков.Период = Дата(ГодНастроек,1,1);
	Иначе
		ГодНастроек = Год(НастройкиРасчетаРезервовОтпусков.Период);
	КонецЕсли;
		
КонецПроцедуры

&НаСервере
Процедура СохранитьДанныеНаСервере(Отказ)
	
	Если Не ПроверитьЗаполнение() Тогда
		Отказ = Истина;
		Возврат;
	КонецЕсли;
		
	РедактированиеПериодическихСведений.ЗаписатьЗаписьПослеРедактированияВФорме(ЭтаФорма, "НастройкиРасчетаРезервовОтпусков", ГоловнаяОрганизация);
	
	ОбновитьПовторноИспользуемыеЗначения();
	
	Модифицированность = Ложь;
	
КонецПроцедуры

&НаКлиенте
Процедура ОткрытьФормуРедактированияИстории(ИмяРегистра, ВедущийОбъект, Форма, ЗапретРедактирования = Ложь)
	
	ТолькоПросмотрИстории = Форма.ТолькоПросмотр ИЛИ ЗапретРедактирования;
	Если Не ТолькоПросмотрИстории Тогда
		Попытка
			Форма.ЗаблокироватьДанныеФормыДляРедактирования();
			ТолькоПросмотрИстории = Ложь;
		Исключение
			ТолькоПросмотрИстории = Истина;
		КонецПопытки
	КонецЕсли;
	РедактированиеПериодическихСведенийКлиент.ОткрытьИсторию(ИмяРегистра, ВедущийОбъект, Форма, ТолькоПросмотрИстории);
	
КонецПроцедуры

&НаСервере
Процедура ПрочитатьНаборЗаписейПериодическихСведений(ИмяРегистра, ВедущийОбъект) Экспорт
	
	РедактированиеПериодическихСведений.ПрочитатьНаборЗаписей(ЭтаФорма, ИмяРегистра, ВедущийОбъект);
	
КонецПроцедуры

&НаКлиенте
Процедура СохранитьИЗакрыть(Результат, ДополнительныеПараметры) Экспорт 
	
	Отказ = Ложь;
	СохранитьДанныеНаСервере(Отказ);
	
	Если Не Отказ Тогда
		Закрыть();
	КонецЕсли;
	
КонецПроцедуры

&НаСервере
Процедура ОбновитьЭлементыФормыПоТекущимНастройкам()
	
	Элементы.ОрганизацияОписаниеДекорация.Видимость = ОбособленноеПодразделение;
	РаботаВБюджетномУчреждении = ПолучитьФункциональнуюОпцию("РаботаВБюджетномУчреждении");
	Элементы.ГруппаОценочныеОбязательства.ОтображатьЗаголовок = Не РаботаВБюджетномУчреждении;
	Если РаботаВБюджетномУчреждении Тогда
		Элементы.ФормироватьРезервОтпусковБУ.ОтображениеПодсказки = ОтображениеПодсказки.Нет;
		Элементы.ФормироватьРезервОтпусковБУ.Заголовок = НСтр("ru='Формировать оценочные обязательства (резервы)';uk='Формувати оцінні зобов''язання (резерви)'");
	КонецЕсли;
	ОбновитьДоступностьНастроек(ЭтаФорма);
	
КонецПроцедуры

&НаКлиентеНаСервереБезКонтекста
Процедура ОбновитьДоступностьНастроек(Форма)

	ДоступностьНастроек = Форма.НастройкиРасчетаРезервовОтпусков.ФормироватьРезервОтпусковБУ
		И (Форма.НастройкиРасчетаРезервовОтпусков.МетодНачисленияРезерваОтпусков = ПредопределенноеЗначение("Перечисление.МетодыНачисленияРезервовОтпусков.НормативныйМетод"));
	
	Форма.Элементы.МетодНачисленияРезерваОтпусков.Доступность = Форма.НастройкиРасчетаРезервовОтпусков.ФормироватьРезервОтпусковБУ;
	
	Форма.Элементы.НормативОтчисленийВРезервОтпусков.Доступность               = ДоступностьНастроек;
	Форма.Элементы.НормативОтчисленийВРезервОтпусков.АвтоОтметкаНезаполненного = ДоступностьНастроек; 
	Форма.Элементы.НормативОтчисленийВРезервОтпусков.ОтметкаНезаполненного     = ДоступностьНастроек И Форма.НастройкиРасчетаРезервовОтпусков.НормативОтчисленийВРезервОтпусков = 0;
	
	Форма.Элементы.ПредельнаяВеличинаОтчисленийВРезервОтпусков.Доступность               = ДоступностьНастроек;
	Форма.Элементы.ПредельнаяВеличинаОтчисленийВРезервОтпусков.АвтоОтметкаНезаполненного = ДоступностьНастроек; 
	Форма.Элементы.ПредельнаяВеличинаОтчисленийВРезервОтпусков.ОтметкаНезаполненного     = ДоступностьНастроек И Форма.НастройкиРасчетаРезервовОтпусков.ПредельнаяВеличинаОтчисленийВРезервОтпусков = 0;
	
КонецПроцедуры


#КонецОбласти
