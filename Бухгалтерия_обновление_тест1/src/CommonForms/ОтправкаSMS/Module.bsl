///////////////////////////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2020
// Все права защищены. Эта программа и сопроводительные материалы предоставляются 
// в соответствии с условиями лицензии Attribution 4.0 International (CC BY 4.0)
// Текст лицензии доступен по ссылке:
// https://creativecommons.org/licenses/by/4.0/legalcode
///////////////////////////////////////////////////////////////////////////////////////////////////////

#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	СтатусОтправки = НСтр("ru='Сообщение отправляется...';uk='Повідомлення відправляється...'");
	ТекстСообщения = Параметры.Текст;
	
	НомераТелефонов = Новый Массив;
	Если ТипЗнч(Параметры.НомераПолучателей) = Тип("Массив") Тогда
		Для каждого ИнформацияОТелефоне Из Параметры.НомераПолучателей Цикл
			НомераТелефонов.Добавить(ИнформацияОТелефоне.Телефон);
		КонецЦикла;
	ИначеЕсли ТипЗнч(Параметры.НомераПолучателей) = Тип("СписокЗначений") Тогда
		Для каждого ИнформацияОТелефоне Из Параметры.НомераПолучателей Цикл
			НомераТелефонов.Добавить(ИнформацияОТелефоне.Значение);
		КонецЦикла;
	Иначе
		НомераТелефонов.Добавить(Строка(Параметры.НомераПолучателей));
	КонецЕсли;
	
	Если НомераТелефонов.Количество() = 0 Тогда
		Элементы.ГруппаНомерПолучателя.Видимость = Истина;
	КонецЕсли;
	
	НомераПолучателей = СтрСоединить(НомераТелефонов, ", ");
	
	ШаблонЗаголовка = НСтр("ru='Отправка SMS на телефон %1';uk='Відправлення SMS на телефон %1'");
	Если НомераТелефонов.Количество() > 1 Тогда
		ШаблонЗаголовка = НСтр("ru='Отправка SMS на телефоны: %1';uk='Відправлення SMS на телефони: %1'");
	КонецЕсли;
	
	Заголовок = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(ШаблонЗаголовка, НомераПолучателей);
	
КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)
	ДлинаСообщенияСимволов = СтрДлина(ТекстСообщения);
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовШапкиФормы

&НаКлиенте
Процедура ДобавлятьОтправителяПриИзменении(Элемент)
	Элементы.ИмяОтправителя.Доступность = ДобавлятьОтправителя;
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура Отправить(Команда)
	
	Если СтрДлина(ТекстСообщения) = 0 Тогда
		ПоказатьПредупреждение(, НСтр("ru='Необходимо ввести текст сообщения';uk='Необхідно ввести текст повідомлення'"));
		Возврат;
	КонецЕсли;
	
	Если НЕ ОтправкаSMSНастроена() Тогда
		ОткрытьФорму("ОбщаяФорма.НастройкаОтправкиSMS");
		Возврат;
	КонецЕсли;
	
	Элементы.Страницы.ТекущаяСтраница = Элементы.СтраницаСтатус;
	
	Если Элементы.Найти("НастройкаОтправкиSMSОткрыть") <> Неопределено Тогда
		Элементы.НастройкаОтправкиSMSОткрыть.Видимость = Ложь;
	КонецЕсли;
	
	Элементы.Закрыть.Видимость = Истина;
	Элементы.Закрыть.КнопкаПоУмолчанию = Истина;
	Элементы.Отправить.Видимость = Ложь;
	
	// Отправка из серверного контекста.
	ОтправитьSMS();

	// проверка статуса отправки
	Если Не ПустаяСтрока(ИдентификаторСообщения) Тогда
		Элементы.Страницы.ТекущаяСтраница = Элементы.СтраницаСообщениеОтправлено;
		ПодключитьОбработчикОжидания("ПроверитьСтатусДоставки", 2, Истина);
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаСервере
Процедура ОтправитьSMS()
	
	// Сброс отображаемого статуса доставки.
	ИдентификаторСообщения = "";
	
	// Подготовка номеров получателей.
	МассивНомеров = СтроковыеФункцииКлиентСервер.РазложитьСтрокуВМассивПодстрок(НомераПолучателей, ", ", Истина);
	
	// отправка
	РезультатОтправки = ОтправкаSMS.ОтправитьSMS(МассивНомеров, ТекстСообщения, ИмяОтправителя, ОтправлятьВТранслите);
	
	// Вывод информации об ошибках в процессе отправки.
	Если ПустаяСтрока(РезультатОтправки.ОписаниеОшибки) Тогда
		// Проверка доставки для первого получателя.
		Если РезультатОтправки.ОтправленныеСообщения.Количество() > 0 Тогда
			ИдентификаторСообщения = РезультатОтправки.ОтправленныеСообщения[0].ИдентификаторСообщения;
		КонецЕсли;
		Элементы.Страницы.ТекущаяСтраница = Элементы.СтраницаСообщениеОтправлено;
	Иначе
		Элементы.Страницы.ТекущаяСтраница = Элементы.СтраницаСообщениеНеОтправлено;
		
		ШаблонСообщения = НСтр("ru='Отправка не выполнена:
        |%1.'
        |;uk='Відправлення не виконано:
        |%1.'");
		
		Элементы.ТекстСообщениеНеОтправлено.Заголовок = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(
			ШаблонСообщения, РезультатОтправки.ОписаниеОшибки);
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ПроверитьСтатусДоставки()
	
	РезультатДоставки = СтатусДоставки(ИдентификаторСообщения);
	СтатусОтправки = РезультатДоставки.Описание;
	
	РезультатыДоставки = Новый Массив;
	РезультатыДоставки.Добавить("Ошибка");
	РезультатыДоставки.Добавить("НеДоставлено");
	РезультатыДоставки.Добавить("Доставлено");
	РезультатыДоставки.Добавить("НеОтправлено");
	
	ПроверкаСтатусаЗавершена = РезультатыДоставки.Найти(РезультатДоставки.Статус) <> Неопределено;
	Элементы.ГруппаПроверкаСтатусаДоставки.Видимость = ПроверкаСтатусаЗавершена;
	
	ШаблонСостояния = НСтр("ru='Отправка сообщения выполнена. Состояние доставки:
        |%1.'
        |;uk='Відправлення повідомлення виконано. Стан доставки:
        |%1.'");
	Элементы.ТекстСообщениеОтправлено.Заголовок = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(
		ШаблонСостояния, РезультатДоставки.Описание);
	
	
	Если РезультатДоставки.Статус = "Ошибка" Тогда
		Элементы.ДекорацияАнимация.Картинка = БиблиотекаКартинок.Ошибка32;
	Иначе
		Если РезультатыДоставки.Найти(РезультатДоставки.Статус) <> Неопределено Тогда
			Элементы.ДекорацияАнимация.Картинка = БиблиотекаКартинок.Успешно32;
			Элементы.ГруппаПроверкаСтатусаДоставки.Видимость = Ложь;
		Иначе
			ПодключитьОбработчикОжидания("ПроверитьСтатусДоставки", 2, Истина);
			Элементы.ГруппаПроверкаСтатусаДоставки.Видимость = Истина;
		КонецЕсли;
	КонецЕсли;
	
КонецПроцедуры

&НаСервереБезКонтекста
Функция СтатусДоставки(ИдентификаторСообщения)
	
	СтатусыДоставки = Новый Соответствие;
	СтатусыДоставки.Вставить("Ошибка", НСтр("ru='произошла ошибка при подключении к провайдеру SMS';uk='сталася помилка при підключенні до провайдера SMS'"));
	СтатусыДоставки.Вставить("НеОтправлялось", НСтр("ru='сообщение не отправлялось провайдером';uk='повідомлення не відправлялося провайдером'"));
	СтатусыДоставки.Вставить("Отправляется", НСтр("ru='выполняется отправка провайдером';uk='виконується відправка провайдером'"));
	СтатусыДоставки.Вставить("Отправлено", НСтр("ru='отправлено провайдером';uk='відправлено провайдером'"));
	СтатусыДоставки.Вставить("НеОтправлено", НСтр("ru='сообщение не отправлено провайдером';uk='повідомлення не відправлено провайдером'"));
	СтатусыДоставки.Вставить("Доставлено", НСтр("ru='сообщение доставлено';uk='повідомлення доставлене'"));
	СтатусыДоставки.Вставить("НеДоставлено", НСтр("ru='сообщение не доставлено';uk='повідомлення не доставлено'"));
	
	РезультатДоставки = Новый Структура("Статус, Описание");
	РезультатДоставки.Статус = ОтправкаSMS.СтатусДоставки(ИдентификаторСообщения);
	РезультатДоставки.Описание = СтатусыДоставки[РезультатДоставки.Статус];
	Если РезультатДоставки.Описание = Неопределено Тогда
		РезультатДоставки.Описание = "<" + РезультатДоставки.Статус + ">";
	КонецЕсли;
	
	Возврат РезультатДоставки;
	
КонецФункции

&НаКлиенте
Процедура ТекстИзменениеТекстаРедактирования(Элемент, Текст, СтандартнаяОбработка)
	ДлинаСообщенияСимволов = СтрДлина(Текст);
	СтандартнаяОбработка = Ложь;
КонецПроцедуры

&НаСервереБезКонтекста
Функция ОтправкаSMSНастроена()
 	Возврат ОтправкаSMS.НастройкаОтправкиSMSВыполнена();
КонецФункции

#КонецОбласти
