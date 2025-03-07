#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	Если Параметры.Свойство("АвтоТест") Тогда // Возврат при получении формы для анализа.
		Возврат;
	КонецЕсли;

	ОбновлениеИнформационнойБазы.ПроверитьОбъектОбработан(Объект, ЭтотОбъект);
	
	Если Не ЗначениеЗаполнено(Объект.Ссылка) Тогда
		Если ЗначениеЗаполнено(Параметры.ЗначениеКопирования) Тогда
			КомпоновщикНастроек = ОбщегоНазначения.ЗначениеРеквизитаОбъекта(Параметры.ЗначениеКопирования, "КомпоновщикНастроек");
		КонецЕсли;
		БюджетированиеСервер.ИнициализироватьКомпоновщикНастроекПравила(Объект, ЭтаФорма, КомпоновщикНастроек.Настройки);
		АдресНастроекКомпоновкиДанных = ПоместитьВоВременноеХранилище(КомпоновщикНастроек.ПолучитьНастройки(), УникальныйИдентификатор);
		СхемаКомпоновкиКорректна = КорректностьСхемыКомпоновкиДанных();
	КонецЕсли;
	
	ЗаполнитьВидыАналитик();
	ЗаполнитьНастройкиЗаполненияАналитики();
	
	Если Не БюджетированиеСервер.ИспользуетсяМеждународныйУчет() Тогда
		Разделы = Элементы.РазделИсточникаДанных.СписокВыбора;
		РазделМеждународныйУчет = Разделы.НайтиПоЗначению(Перечисления.РазделыИсточниковДанныхБюджетирования.МеждународныйУчет);
		Если РазделМеждународныйУчет <> Неопределено Тогда
			Разделы.Удалить(РазделМеждународныйУчет);
		КонецЕсли;
	КонецЕсли;
	
	//++ НЕ УТ
	Если Не ПолучитьФункциональнуюОпцию("ИспользоватьРеглУчет") Тогда
		Разделы = Элементы.РазделИсточникаДанных.СписокВыбора;
		РазделРеглУчет = Разделы.НайтиПоЗначению(Перечисления.РазделыИсточниковДанныхБюджетирования.РегламентированныйУчет);
		Если РазделРеглУчет <> Неопределено Тогда
			Разделы.Удалить(РазделРеглУчет);
		КонецЕсли;
	КонецЕсли;
	//-- НЕ УТ
	
	ПредставлениеСтатьиБюджетов = Строка(Объект.СтатьяБюджетов);
	
	// СтандартныеПодсистемы.ПодключаемыеКоманды
	ПодключаемыеКоманды.ПриСозданииНаСервере(ЭтотОбъект);
	// Конец СтандартныеПодсистемы.ПодключаемыеКоманды
	
	УстановитьУсловноеОформление();
	НастроитьЭлементыФормы();
	
КонецПроцедуры

&НаСервере
Процедура ПриЧтенииНаСервере(ТекущийОбъект)
	
	Если ТекущийОбъект.ОборотПоАналитикеРасхода Тогда
		ТипОборотПоАналитике = 1;
	КонецЕсли;
	
	СохраненныйКомпоновщикНастроек = ТекущийОбъект.КомпоновщикНастроек.Получить();
	БюджетированиеСервер.ИнициализироватьКомпоновщикНастроекПравила(Объект, ЭтаФорма, СохраненныйКомпоновщикНастроек);
	АдресНастроекКомпоновкиДанных = ПоместитьВоВременноеХранилище(КомпоновщикНастроек.ПолучитьНастройки(), УникальныйИдентификатор);
	СхемаКомпоновкиКорректна = КорректностьСхемыКомпоновкиДанных();
	
	// СтандартныеПодсистемы.ПодключаемыеКоманды
	ПодключаемыеКомандыКлиентСервер.ОбновитьКоманды(ЭтотОбъект, Объект);
	// Конец СтандартныеПодсистемы.ПодключаемыеКоманды
КонецПроцедуры

&НаСервере
Процедура ПередЗаписьюНаСервере(Отказ, ТекущийОбъект, ПараметрыЗаписи)
	
	Если ВключитьРасширеннуюНастройкуЗаполненияАналитикПриОшибкахВАвто() Тогда
		Отказ = Истина;
		Возврат;
	КонецЕсли;

	ТекущийОбъект.КомпоновщикНастроек = Новый ХранилищеЗначения(КомпоновщикНастроек.ПолучитьНастройки());
	ТекущийОбъект.ПредставлениеОтбора = Строка(КомпоновщикНастроек.Настройки.Отбор);
	Если ТекущийОбъект.РазделИсточникаДанных = Перечисления.РазделыИсточниковДанныхБюджетирования.ПроизвольныеДанные Тогда
		СхемаКомпоновкиДанных = ПолучитьИзВременногоХранилища(АдресСхемыКомпоновкиДанных);
		ТекущийОбъект.СхемаИсточникаДанных = Новый ХранилищеЗначения(СхемаКомпоновкиДанных);
	КонецЕсли;
		
	БюджетированиеСервер.ПоместитьНастройкиЗаполненияАналитикиВПравило(ЭтаФорма, ТекущийОбъект);
	
	
КонецПроцедуры

&НаСервере
Процедура ПослеЗаписиНаСервере(ТекущийОбъект, ПараметрыЗаписи)
	
	
	
	Возврат; // Не используется в УТ и КА.
	
КонецПроцедуры

&НаСервере
Процедура ОбработкаПроверкиЗаполненияНаСервере(Отказ, ПроверяемыеРеквизиты)
	
	БюджетированиеСервер.ОбработкаПроверкиНастроекЗаполненияАналитики(НастройкиЗаполненияАналитики, Отказ, Объект.РасширенныйРежимНастройкиЗаполненияАналитики);
	
КонецПроцедуры

&НаКлиенте
Процедура ПослеЗаписи(ПараметрыЗаписи)
	
	Оповестить("ЗаписаноПравилоПолученияФактаПоСтатьеБюджета");
	ОповеститьОЗаписиНового(Объект.Ссылка);
	
КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)
	
	// СтандартныеПодсистемы.ПодключаемыеКоманды
	ПодключаемыеКомандыКлиент.НачатьОбновлениеКоманд(ЭтотОбъект);
	// Конец СтандартныеПодсистемы.ПодключаемыеКоманды
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовФормы

&НаКлиенте
Процедура ИсточникДанныхПриИзменении(Элемент)
	
	ОчиститьСообщения();
	ПриИзмененииИсточникаСервер();
	
КонецПроцедуры

&НаКлиенте
Процедура ХранитьПромежуточныйКэшПриИзменении(Элемент)
	
	ПриИзмененииИсточникаСервер();
	
КонецПроцедуры

&НаКлиенте
Процедура РазделИсточникаДанныхПриИзменении(Элемент)
	
	ОчиститьСообщения();
	ПриИзмененииРазделаИсточникаСервер();
	
КонецПроцедуры

&НаКлиенте
Процедура КорСчетПриИзменении(Элемент)
	
	ПриИзмененииИсточникаСервер();
	
КонецПроцедуры

&НаКлиенте
Процедура ОборотПоАналитикеПриИзменении(Элемент)
	
	Если ТипОборотПоАналитике = 0 Тогда
		Объект.ОборотПоАналитикеРасхода = Ложь;
	Иначе
		Объект.ОборотПоАналитикеРасхода = Истина;
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура СтатьяБюджетовПриИзменении(Элемент)
	
	ПриИзмененииСтатьиБюджетовСервер();
	
КонецПроцедуры

&НаКлиенте
Процедура НастройкиЗаполненияАналитикиВыражениеЗаполненияАналитикиНачалоВыбора(Элемент, ДанныеВыбора, СтандартнаяОбработка)
	
	СтандартнаяОбработка = Ложь;
	
	ПолеНезаполненногоЭлемента = Неопределено;
	Если НЕ РезультатПроверкиВозможностиВыбораАналитики(ПолеНезаполненногоЭлемента) Тогда
		ОчиститьСообщения();
		Если ПолеНезаполненногоЭлемента = Элементы.НастроитьСхемуПолученияДанных.Имя Тогда
			ТекстСообщения = НСтр("ru='Некорректно заполнена схема получения данных';uk='Некоректно заповнена схема отримання даних'");
			ОбщегоНазначенияКлиент.СообщитьПользователю(ТекстСообщения,,,
			                                            "Объект");
		Иначе
			ТекстСообщения = НСтр("ru='Не указаны все реквизиты источника данных, выбор аналитики невозможен';uk='Не вказані всі реквізити джерела даних, вибір аналітики неможливий'");
			ОбщегоНазначенияКлиент.СообщитьПользователю(ТекстСообщения,,
			                                            ПолеНезаполненногоЭлемента,
			                                            "Объект");
		КонецЕсли;
		Возврат;
	КонецЕсли;
	ТекущиеДанные = Элементы.НастройкиЗаполненияАналитики.ТекущиеДанные;
	
	ПараметрыФормы = Новый Структура;
	ПараметрыФормы.Вставить("ВидАналитики",               ТекущиеДанные.ВидАналитики);
	ПараметрыФормы.Вставить("АдресСхемыКомпоновкиДанных", АдресСхемыКомпоновкиДанных);
	ПараметрыФормы.Вставить("РазделИсточникаДанных",      Объект.РазделИсточникаДанных);
	ПараметрыФормы.Вставить("ТекущееВыражение",           ТекущиеДанные.ВыражениеЗаполненияАналитики);
	
	ОткрытьФорму("ОбщаяФорма.ВыборПоляЗаполненияАналитики", ПараметрыФормы, Элемент);
	
КонецПроцедуры

&НаКлиенте
Процедура НастройкиЗаполненияАналитикиВыражениеЗаполненияАналитикиОбработкаВыбора(Элемент, ВыбранноеЗначение, СтандартнаяОбработка)
	
	СтандартнаяОбработка = Ложь;
	ТекущиеДанные = Элементы.НастройкиЗаполненияАналитики.ТекущиеДанные;
	ТекущиеДанные.ВыражениеЗаполненияАналитики = ВыбранноеЗначение;
	
	ВыражениеЗаполненияАналитикиОбработкаВыбораСервер(ТекущиеДанные.ПолучитьИдентификатор());
	Модифицированность = Истина;
	Элементы.НастройкиЗаполненияАналитики.ЗакончитьРедактированиеСтроки(Ложь);
	
КонецПроцедуры

&НаКлиенте
Процедура НастройкиЗаполненияАналитикиВыражениеЗаполненияАналитикиОчистка(Элемент, СтандартнаяОбработка)
	
	СтандартнаяОбработка = Ложь;
	
КонецПроцедуры

&НаКлиенте
Процедура НастройкиЗаполненияАналитикиПриАктивизацииСтроки(Элемент)
	
	ПараметрыВыбораФормы = Новый Массив;
	
	ТекущиеДанные = Элементы.НастройкиЗаполненияАналитики.ТекущиеДанные;
	Если ТекущиеДанные <> Неопределено И ЗначениеЗаполнено(ТекущиеДанные.ДополнительноеСвойство) Тогда
		НовыйПараметрВыбора = Новый ПараметрВыбора("Отбор.Владелец", ТекущиеДанные.ДополнительноеСвойство);
		ПараметрыВыбораФормы.Добавить(НовыйПараметрВыбора);
	КонецЕсли;
	
	Элементы.НастройкиЗаполненияАналитикиЗначениеАналитики.ПараметрыВыбора = Новый ФиксированныйМассив(ПараметрыВыбораФормы);
	
КонецПроцедуры

&НаКлиенте
Процедура ТипПравилаПриИзменении(Элемент)
	
	ТипПравилаПриИзмененииНаСервере();
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура НастроитьСхемуПолученияДанных(Команда)
	
	ЗаголовокФормыНастройкиСхемыКомпоновкиДанных = НСтр("ru='Настройки схемы получения произвольных данных';uk='Настройки схеми отримання довільних даних'");
	
	ПараметрыФормы = Новый Структура;
	ПараметрыФормы.Вставить("АдресСхемыКомпоновкиДанных",            АдресСхемыКомпоновкиДанных);
	ПараметрыФормы.Вставить("АдресНастроекКомпоновкиДанных",         АдресНастроекКомпоновкиДанных);
	ПараметрыФормы.Вставить("Заголовок",                             ЗаголовокФормыНастройкиСхемыКомпоновкиДанных);
	ПараметрыФормы.Вставить("УникальныйИдентификатор",               УникальныйИдентификатор);
	ПараметрыФормы.Вставить("НеНастраиватьУсловноеОформление",       Истина);
	ПараметрыФормы.Вставить("НеНастраиватьПорядок",                  Истина);
	ПараметрыФормы.Вставить("НеНастраиватьОтбор",                    Истина);
	ПараметрыФормы.Вставить("НеНастраиватьВыбор",                    Истина);
	ПараметрыФормы.Вставить("НеПомещатьНастройкиВСхемуКомпоновкиДанных", Ложь);
	ПараметрыФормы.Вставить("ПроцедураПомещенияНастроекВСхемуКомпоновкиДанных", "БюджетированиеСервер.ПоместитьНастройкиВСхемуПолученияФактическихДанных");
	ПараметрыФормы.Вставить("ПроцедураПроверкиСхемыКомпоновкиДанных", "БюджетированиеСервер.ПроверкаКорректностиСхемыПолученияФактическихДанных");
	ПараметрыФормы.Вставить("ПроцедураПриИнициализацииНастроекКомпоновки", "БюджетированиеСервер.ДозаполнениеНастроекПриИзмененииСхемыКомпоновки");
	
	ОписаниеОповещения = Новый ОписаниеОповещения("ИзменитьСхемуКомпоновкиДанных", ЭтотОбъект);
	
	ОткрытьФорму("ОбщаяФорма.УпрощеннаяНастройкаСхемыКомпоновкиДанных", 
		ПараметрыФормы, ЭтаФорма, , , , ОписаниеОповещения, РежимОткрытияОкнаФормы.БлокироватьОкноВладельца);
	
КонецПроцедуры

&НаКлиенте
Процедура ОтключитьРежимРасширеннойНастройкиЗаполненияАналитики(Команда)
	
	ОтключитьРежимРасширеннойНастройкиЗаполненияАналитикиСервер();
	
КонецПроцедуры

&НаКлиенте
Процедура ВключитьРежимРасширеннойНастройкиЗаполненияАналитик(Команда)
	
	ВключитьРежимРасширеннойНастройкиЗаполненияАналитикиСервер();
	
КонецПроцедуры

&НаКлиенте
Процедура ЗаполнитьНастройкиАналитикиПоИсточникуДанных(Команда)
	
	ОчиститьСообщения();
	ЗаполнитьНастройкиАналитикиПоИсточникуДанныхСервер();
	
КонецПроцедуры

// СтандартныеПодсистемы.ПодключаемыеКоманды
&НаКлиенте
Процедура Подключаемый_ВыполнитьКоманду(Команда)
	ПодключаемыеКомандыКлиент.ВыполнитьКоманду(ЭтотОбъект, Команда, Объект);
КонецПроцедуры

&НаСервере
Процедура Подключаемый_ВыполнитьКомандуНаСервере(Контекст, Результат) Экспорт
	ПодключаемыеКоманды.ВыполнитьКоманду(ЭтотОбъект, Контекст, Объект, Результат);
КонецПроцедуры

&НаКлиенте
Процедура Подключаемый_ОбновитьКоманды()
	ПодключаемыеКомандыКлиентСервер.ОбновитьКоманды(ЭтотОбъект, Объект);
КонецПроцедуры
// Конец СтандартныеПодсистемы.ПодключаемыеКоманды

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаКлиенте
Функция РезультатПроверкиВозможностиВыбораАналитики(ПолеНезаполненногоЭлемента)
	
	МожноВыбиратьВыражениеЗаполнения = Истина;
	Если НЕ ЗначениеЗаполнено(Объект.СтатьяБюджетов) Тогда
		МожноВыбиратьВыражениеЗаполнения = Ложь;
		ПолеНезаполненногоЭлемента = Элементы.СтатьяБюджетов.Имя;
	ИначеЕсли НЕ ЗначениеЗаполнено(Объект.РазделИсточникаДанных) Тогда
		МожноВыбиратьВыражениеЗаполнения = Ложь;
		ПолеНезаполненногоЭлемента = Элементы.РазделИсточникаДанных.Имя;
	ИначеЕсли НЕ ЗначениеЗаполнено(Объект.ИсточникДанных) Тогда
		МожноВыбиратьВыражениеЗаполнения = Ложь;
		ПолеНезаполненногоЭлемента = Элементы.ИсточникДанных.Имя;
	ИначеЕсли НЕ ЗначениеЗаполнено(Объект.ИсточникДанных) Тогда
		МожноВыбиратьВыражениеЗаполнения = Ложь;
		ПолеНезаполненногоЭлемента = Элементы.ИсточникДанных.Имя;
	ИначеЕсли Объект.РазделИсточникаДанных =
		ПредопределенноеЗначение("Перечисление.РазделыИсточниковДанныхБюджетирования.ПроизвольныеДанные")
		И НЕ СхемаКомпоновкиКорректна Тогда
		МожноВыбиратьВыражениеЗаполнения = Ложь;
		ПолеНезаполненногоЭлемента = Элементы.НастроитьСхемуПолученияДанных.Имя;
	КонецЕсли;
	
	Возврат МожноВыбиратьВыражениеЗаполнения;
	
КонецФункции

&НаСервере
Функция КорректностьСхемыКомпоновкиДанных()
	СхемаКомпоновкиКорректна = Ложь;
	Если Объект.РазделИсточникаДанных = Перечисления.РазделыИсточниковДанныхБюджетирования.ОперативныйУчет
	 ИЛИ Объект.РазделИсточникаДанных = Перечисления.РазделыИсточниковДанныхБюджетирования.РегламентированныйУчет
	 ИЛИ Объект.РазделИсточникаДанных = Перечисления.РазделыИсточниковДанныхБюджетирования.МеждународныйУчет Тогда
		// Схема компоновки задается макетом из метаданных.
	ИначеЕсли Объект.РазделИсточникаДанных = Перечисления.РазделыИсточниковДанныхБюджетирования.ПроизвольныеДанные Тогда
		СхемаКомпоновки = ПолучитьИзВременногоХранилища(АдресСхемыКомпоновкиДанных);
		Если НЕ СхемаКомпоновки = Неопределено Тогда
			ДоступныеПоляВыбора = КомпоновщикНастроек.Настройки.Выбор.ДоступныеПоляВыбора;
			Для Каждого ДоступноеПолеВыбора Из ДоступныеПоляВыбора.Элементы Цикл
				Если ДоступноеПолеВыбора.Папка Тогда
					Продолжить; // Системные поля
				КонецЕсли;
				СхемаКомпоновкиКорректна = Истина;
			КонецЦикла;
		КонецЕсли;
	КонецЕсли;
	
	Возврат СхемаКомпоновкиКорректна;
КонецФункции

&НаСервере
Процедура УстановитьУсловноеОформление()
	
	УсловноеОформление.Элементы.Очистить();
	БюджетированиеСервер.УстановитьУсловноеНастроекЗаполненияАналитики(УсловноеОформление);
	
КонецПроцедуры

&НаКлиенте
Процедура ИзменитьСхемуКомпоновкиДанных(Результат, Параметры) Экспорт
	
	Если ЗначениеЗаполнено(Результат) Тогда
		КомпоновщикНастроек.ЗагрузитьНастройки(ПолучитьИзВременногоХранилища(Результат));
		ИзмененаСхемаКомпоновкиДанныхСервер();
	КонецЕсли;
	
КонецПроцедуры

&НаСервере
Процедура ЗаполнитьВидыАналитик()
	
	ВидыАналитик = БюджетированиеСервер.ВидыАналитик(Объект);
	
	ЗаполнитьЗначенияСвойств(ЭтаФорма, ВидыАналитик);
	
КонецПроцедуры

&НаСервере
Процедура НастроитьЭлементыФормы()
	
	ПравилоПоРеглУчету = 
		(Объект.РазделИсточникаДанных = Перечисления.РазделыИсточниковДанныхБюджетирования.РегламентированныйУчет);
	ПравилоПоМеждународномуУчету = 
		(Объект.РазделИсточникаДанных = Перечисления.РазделыИсточниковДанныхБюджетирования.МеждународныйУчет);
	ПравилоПоОперативномуУчету = 
		(Объект.РазделИсточникаДанных = Перечисления.РазделыИсточниковДанныхБюджетирования.ОперативныйУчет);
	ПравилоПоПроизвольнымДанным = 
		(Объект.РазделИсточникаДанных = Перечисления.РазделыИсточниковДанныхБюджетирования.ПроизвольныеДанные);
	
	ОписаниеТиповИсточника = Новый ОписаниеТипов(Неопределено);
	ЗаголовокИсточника = НСтр("ru='Источник данных';uk='Джерело даних'");
	ПараметрыВыбораФормы = Новый Массив;
	Если ПравилоПоОперативномуУчету Тогда
		ОписаниеТиповИсточника = Новый ОписаниеТипов("СправочникСсылка.НастройкиХозяйственныхОпераций");
		ЗаголовокИсточника = НСтр("ru='Хозяйственная операция';uk='Господарська операція'");
		ПараметрыВыбораФормы.Добавить(Новый ПараметрВыбора("Отбор.ИспользоватьВБюджетировании", Истина));
	ИначеЕсли ПравилоПоРеглУчету Тогда
		МассивТипов = Новый Массив;
		МассивТипов.Добавить(РеглУчетКлиентСервер.ТипПланСчетов());
		ОписаниеТиповИсточника = Новый ОписаниеТипов(МассивТипов);
		ЗаголовокИсточника = НСтр("ru='Счет учета';uk='Рахунок'");
	ИначеЕсли ПравилоПоПроизвольнымДанным Тогда
		ОписаниеТиповИсточника = Новый ОписаниеТипов("Строка", , , , Новый КвалификаторыСтроки(200));
		Если ТипЗнч(Объект.ИсточникДанных) <> Тип("Строка") 
			Или НЕ ЗначениеЗаполнено(Объект.ИсточникДанных) Тогда
			Объект.ИсточникДанных = Строка(Объект.СтатьяБюджетов);
		КонецЕсли;
	КонецЕсли;
	
	Объект.ИсточникДанных = ОписаниеТиповИсточника.ПривестиЗначение(Объект.ИсточникДанных);
	Объект.КорСчет = ОписаниеТиповИсточника.ПривестиЗначение(Объект.КорСчет);
	
	Элементы.ИсточникДанных.Заголовок = ЗаголовокИсточника;
	Элементы.ИсточникДанных.ПараметрыВыбора = Новый ФиксированныйМассив(ПараметрыВыбораФормы);
	Если ПравилоПоОперативномуУчету Или ПравилоПоРеглУчету Или ПравилоПоМеждународномуУчету Тогда
		Элементы.ИсточникДанных.ОтображениеПодсказки = ОтображениеПодсказки.Нет;
	Иначе
		Элементы.ИсточникДанных.ОтображениеПодсказки = ОтображениеПодсказки.Кнопка;
		Элементы.ИсточникДанных.РасширеннаяПодсказка.Заголовок = ПодсказкаПроизвольногоИсточникаДанных();
	КонецЕсли;
	
	Если НЕ ПравилоПоОперативномуУчету Тогда
		Элементы.ИсточникСуммыОперации.ОтображениеПодсказки = ОтображениеПодсказки.Нет;
		Элементы.ИсточникСуммыОперации.РасширеннаяПодсказка.Заголовок = "";
	Иначе
		ПодсказкаИсточникаСуммыОперации = ИсточникиДанныхПовтИсп.ПодсказкаИсточникаСуммыОперации(
			Объект.ИсточникДанных, 
			Объект.ИсточникСуммыОперации
		);
		Если НЕ ЗначениеЗаполнено(ПодсказкаИсточникаСуммыОперации) Тогда
			Элементы.ИсточникСуммыОперации.ОтображениеПодсказки = ОтображениеПодсказки.Нет;
			Элементы.ИсточникСуммыОперации.РасширеннаяПодсказка.Заголовок = "";
		Иначе
			Элементы.ИсточникСуммыОперации.ОтображениеПодсказки = ОтображениеПодсказки.ОтображатьСнизу;
			Элементы.ИсточникСуммыОперации.РасширеннаяПодсказка.Заголовок = ПодсказкаИсточникаСуммыОперации;
		КонецЕсли;
	КонецЕсли;
	
	Элементы.КорСчет.Видимость = ПравилоПоРеглУчету Или ПравилоПоМеждународномуУчету;
	
	Элементы.ТипИтога.Видимость = ПравилоПоРеглУчету Или ПравилоПоМеждународномуУчету;
	
	Элементы.ИсточникДанных.Видимость = ЗначениеЗаполнено(Объект.РазделИсточникаДанных);
	
	Если ПравилоПоРеглУчету Или ПравилоПоМеждународномуУчету Тогда
		Элементы.ТипИтога.СписокВыбора.Очистить();
		Элементы.ТипИтога.СписокВыбора.Добавить(Перечисления.ТипыИтогов.Оборот);
		Если Объект.КорСчет <> Объект.ИсточникДанных Тогда
			Элементы.ТипИтога.СписокВыбора.Добавить(Перечисления.ТипыИтогов.ОборотДт);
			Элементы.ТипИтога.СписокВыбора.Добавить(Перечисления.ТипыИтогов.ОборотКт);
		Иначе
			Объект.ТипИтога = Перечисления.ТипыИтогов.Оборот;
		КонецЕсли;
	КонецЕсли;
	
	Элементы.ИсточникСуммыОперации.Видимость = ПравилоПоОперативномуУчету;
	Элементы.НастроитьСхемуПолученияДанных.Видимость = ПравилоПоПроизвольнымДанным;
	
	ЗаполнитьСписокВыбораИсточникСуммыОперации(ПравилоПоОперативномуУчету, Объект.ИсточникДанных);
	
	Элементы.ТипОборотПоАналитике.Видимость = 
		ВыбиратьТипОборотаПоАналитике(ПравилоПоОперативномуУчету, Объект.ИсточникДанных);
		
	Элементы.ДекорацияОтступКорСчет.Видимость = 
		ЗначениеЗаполнено(Объект.РазделИсточникаДанных) И 
		Объект.РазделИсточникаДанных <> Перечисления.РазделыИсточниковДанныхБюджетирования.ПроизвольныеДанные;
		
	Элементы.ВключитьРежимРасширеннойНастройкиЗаполненияАналитики.Видимость = Не Объект.РасширенныйРежимНастройкиЗаполненияАналитики;
	Элементы.ГруппаНастройкаЗаполненияАналитикиПояснение.Видимость = Не Объект.РасширенныйРежимНастройкиЗаполненияАналитики;
	
	Элементы.ОтключитьРежимРасширеннойНастройкиЗаполненияАналитики.Видимость = Объект.РасширенныйРежимНастройкиЗаполненияАналитики;
	Элементы.НастройкиЗаполненияАналитики.Видимость = Объект.РасширенныйРежимНастройкиЗаполненияАналитики;
	
	Элементы.ГруппаНевыбранИсточник.Видимость = Не ЗначениеЗаполнено(Объект.РазделИсточникаДанных);
	
	Элементы.ХранитьПромежуточныйКэш.Видимость = ЗначениеЗаполнено(Объект.РазделИсточникаДанных)
		И Объект.ТипПравила = Перечисления.ТипПравилаПолученияФактическихДанныхБюджетирования.ФактическиеДанные;
	
	Элементы.ГруппаХранениеРезультатаВыполненияПравилаПояснение.Видимость = Объект.ПромежуточноеКэшированиеРезультатовРаботыПравил;
	
КонецПроцедуры

&НаСервере
Процедура ПриИзмененииСтатьиБюджетовСервер()
	
	РазделПроизвольныеДанные = Перечисления.РазделыИсточниковДанныхБюджетирования.ПроизвольныеДанные;
	СтрокаСтатьяБюджетов = Строка(Объект.СтатьяБюджетов);
	Если Объект.РазделИсточникаДанных = РазделПроизвольныеДанные 
		И (Объект.ИсточникДанных = ПредставлениеСтатьиБюджетов Или Объект.ИсточникДанных = "") Тогда
		Объект.ИсточникДанных = СтрокаСтатьяБюджетов;
	КонецЕсли;
	ПредставлениеСтатьиБюджетов = СтрокаСтатьяБюджетов;
	
	ЗаполнитьВидыАналитик();
	ЗаполнитьНастройкиЗаполненияАналитики();
	
КонецПроцедуры

&НаСервере
Процедура ПриИзмененииИсточникаСервер()
	
	НастроитьЭлементыФормы();
	
	Если ЗначениеЗаполнено(Объект.РазделИсточникаДанных) Тогда
		Если Объект.РазделИсточникаДанных = Перечисления.РазделыИсточниковДанныхБюджетирования.ПроизвольныеДанные
			И Объект.ИсточникДанных = "" Тогда
			Объект.ИсточникДанных = ПредставлениеСтатьиБюджетов;
		КонецЕсли;
		
		Если Элементы.ИсточникСуммыОперации.СписокВыбора.НайтиПоЗначению(Объект.ИсточникСуммыОперации) = Неопределено Тогда
			Объект.ИсточникСуммыОперации = ПредопределенноеЗначение("Перечисление.ПоказателиАналитическихРегистров.ПустаяСсылка");
		КонецЕсли;
		
		ПолучитьСхемуКомпоновкиДанных();
		БюджетированиеСервер.ИнициализироватьКомпоновщикНастроекПравила(Объект, ЭтаФорма, КомпоновщикНастроек.ПолучитьНастройки());
		АдресНастроекКомпоновкиДанных = ПоместитьВоВременноеХранилище(КомпоновщикНастроек.ПолучитьНастройки(), УникальныйИдентификатор);
		Если Не ВключитьРасширеннуюНастройкуЗаполненияАналитикПриОшибкахВАвто() Тогда
			БюджетированиеСервер.ПроверитьДоступностьПолейЗаполненияАналитики(ЭтаФорма, Объект, Истина);
		КонецЕсли;
		СхемаКомпоновкиКорректна = КорректностьСхемыКомпоновкиДанных();
	Иначе
		СхемаКомпоновкиКорректна = Ложь;
	КонецЕсли;
	
КонецПроцедуры

&НаСервере
Процедура ПриИзмененииРазделаИсточникаСервер()
	
	Раздел = Объект.РазделИсточникаДанных; 
	
	ПравилоПоОперативномуУчету = (Раздел = Перечисления.РазделыИсточниковДанныхБюджетирования.ОперативныйУчет);
	ПравилоПоРеглУчету = (Раздел = Перечисления.РазделыИсточниковДанныхБюджетирования.РегламентированныйУчет);
	ПравилоПоМеждународномуУчету = (Раздел = Перечисления.РазделыИсточниковДанныхБюджетирования.МеждународныйУчет);
	
	Если Не ПравилоПоОперативномуУчету Тогда
		Объект.ИсточникСуммыОперации = Неопределено;
	ИначеЕсли Не ПравилоПоРеглУчету И Не ПравилоПоМеждународномуУчету Тогда 
		Объект.ТипИтога = Неопределено;
	КонецЕсли;
	
	ПриИзмененииИсточникаСервер();
	
КонецПроцедуры

&НаСервере
Процедура ПолучитьСхемуКомпоновкиДанных()
	
	МенеджерЗаписи = РеквизитФормыВЗначение("Объект");
	СхемаКомпоновкиДанных = ИсточникиДанныхСервер.СхемаКомпоновкиДанныхПравила(МенеджерЗаписи,,, Ложь);
	
	БюджетированиеСервер.УстановитьСвойстваПолейДляНастройкиПравила(СхемаКомпоновкиДанных, Объект); 
	АдресСхемыКомпоновкиДанных = ПоместитьВоВременноеХранилище(СхемаКомпоновкиДанных, УникальныйИдентификатор);
	
КонецПроцедуры

&НаСервере
Процедура ЗаполнитьСписокВыбораИсточникСуммыОперации(ПравилоПоОперативномуУчету, ИсточникДанных)
	
	Элементы.ИсточникСуммыОперации.СписокВыбора.Очистить();
	
	Если Не ПравилоПоОперативномуУчету Или Не ЗначениеЗаполнено(ИсточникДанных) Тогда
		Возврат;
	КонецЕсли;
	
	Запрос = Новый Запрос;
	Запрос.Текст = 
	"ВЫБРАТЬ
	|	ПоказателиОперации.Показатель КАК Показатель,
	|	ПРЕДСТАВЛЕНИЕ(ПоказателиОперации.Показатель) КАК Представление
	|ИЗ
	|	Справочник.НастройкиХозяйственныхОпераций.ПоказателиРегистра КАК ПоказателиОперации
	|ГДЕ
	|	ПоказателиОперации.Ссылка = &Операция
	|	И ПоказателиОперации.Использование = ИСТИНА";
	Запрос.УстановитьПараметр("Операция", Объект.ИсточникДанных);
	Выборка = Запрос.Выполнить().Выбрать();
	
	Пока Выборка.Следующий() Цикл
		Элементы.ИсточникСуммыОперации.СписокВыбора.Добавить(Выборка.Показатель, Выборка.Представление);
	КонецЦикла;
	
	Если Элементы.ИсточникСуммыОперации.СписокВыбора.Количество() = 1 Тогда
		Объект.ИсточникСуммыОперации = Элементы.ИсточникСуммыОперации.СписокВыбора[0].Значение;
	КонецЕсли;
	
КонецПроцедуры

&НаСервере
Процедура ИзмененаСхемаКомпоновкиДанныхСервер()
	
	Модифицированность = Истина;
	
	БюджетированиеСервер.ИнициализироватьКомпоновщикНастроекПравила(Объект, ЭтаФорма, КомпоновщикНастроек.ПолучитьНастройки()); 
	АдресНастроекКомпоновкиДанных = ПоместитьВоВременноеХранилище(КомпоновщикНастроек.ПолучитьНастройки(), УникальныйИдентификатор);
	БюджетированиеСервер.ПроверитьДоступностьПолейЗаполненияАналитики(ЭтаФорма, Объект, Истина);
	СхемаКомпоновкиКорректна = КорректностьСхемыКомпоновкиДанных();
	
КонецПроцедуры

&НаСервере
Функция ВыбиратьТипОборотаПоАналитике(ПравилоПоОперативномуУчету, ИсточникДанных)
	
	Результат = Ложь;
	
	Если Не ПравилоПоОперативномуУчету Или Не ЗначениеЗаполнено(ИсточникДанных) Тогда
		Возврат Результат;
	КонецЕсли;
	
	ИмяРегистраИсточника = ОбщегоНазначения.ЗначениеРеквизитаОбъекта(Объект.ИсточникДанных, "ИсточникДанных");
	Результат = (ИмяРегистраИсточника = "ДвиженияНоменклатураНоменклатура");
	
	Возврат Результат;
	
КонецФункции

&НаСервере
Процедура ВключитьРежимРасширеннойНастройкиЗаполненияАналитикиСервер(Знач ВыраженияЗаполненияАналитики = Неопределено)
	
	Объект.РасширенныйРежимНастройкиЗаполненияАналитики = Истина;
	ЗаполнитьНастройкиЗаполненияАналитики();
	БюджетированиеСервер.УстановитьНастройкиЗаполненияАналитикиАвтоматически(ЭтаФорма, ВыраженияЗаполненияАналитики);
	НастроитьЭлементыФормы();
	
КонецПроцедуры

&НаСервере
Процедура ОтключитьРежимРасширеннойНастройкиЗаполненияАналитикиСервер()
	
	Объект.РасширенныйРежимНастройкиЗаполненияАналитики = Ложь;
	ЗаполнитьНастройкиЗаполненияАналитики();
	НастроитьЭлементыФормы();
	
КонецПроцедуры

&НаСервере
Процедура ЗаполнитьНастройкиЗаполненияАналитики()
	
	ВидыАналитик = Новый Структура;
	Для НомерАналитики = 1 По 6 Цикл
		ВидыАналитик.Вставить("ВидАналитики" + НомерАналитики, ЭтаФорма["ВидАналитики" + НомерАналитики]);
	КонецЦикла;
	БюджетированиеСервер.ЗаполнитьНастройкиЗаполненияАналитикиПоПравилу(ЭтаФорма, Объект, ВидыАналитик);
	БюджетированиеСервер.ПроверитьДоступностьПолейЗаполненияАналитики(ЭтаФорма, Объект);
	
КонецПроцедуры

&НаСервере
Процедура ЗаполнитьНастройкиАналитикиПоИсточникуДанныхСервер()
	
	БюджетированиеСервер.УстановитьНастройкиЗаполненияАналитикиАвтоматически(ЭтаФорма);
	
КонецПроцедуры

&НаСервере
Процедура ВыражениеЗаполненияАналитикиОбработкаВыбораСервер(ИдентификаторСтроки) 
	
	БюджетированиеСервер.ПроверитьВыражениеЗаполненияАналитикиПослеВыбора(ЭтаФорма, ИдентификаторСтроки);
	
КонецПроцедуры

&НаСервере
Процедура ТипПравилаПриИзмененииНаСервере()
	
	Если Объект.ТипПравила = Перечисления.ТипПравилаПолученияФактическихДанныхБюджетирования.ИсполнениеБюджета Тогда
		Объект.ПромежуточноеКэшированиеРезультатовРаботыПравил = Ложь;
	КонецЕсли;
	
	НастроитьЭлементыФормы();
	
КонецПроцедуры

&НаСервере
Функция ВключитьРасширеннуюНастройкуЗаполненияАналитикПриОшибкахВАвто()
	
	Результат = Ложь;
	Если Не Объект.РасширенныйРежимНастройкиЗаполненияАналитики Тогда
		СхемаКомпоновкиДанных = ПолучитьИзВременногоХранилища(АдресСхемыКомпоновкиДанных);
		ВидыАналитик = НастройкиЗаполненияАналитики.Выгрузить(, "НомерАналитики, ВидАналитики");
		ВыраженияЗаполненияАналитики = БюджетированиеСервер.ВыраженияЗаполненияАналитикиПоСхемеКомпоновкиДанных(СхемаКомпоновкиДанных, ВидыАналитик);
		ПараметрыПоиска = Новый Структура("Неоднозначно", Истина);
		НайденныеСтроки = ВыраженияЗаполненияАналитики.НайтиСтроки(ПараметрыПоиска);
		Если НайденныеСтроки.Количество() Тогда
			ВключитьРежимРасширеннойНастройкиЗаполненияАналитикиСервер(ВыраженияЗаполненияАналитики);
			Результат = Истина;
		КонецЕсли;
	КонецЕсли;
	
	Возврат Результат;

КонецФункции

&НаСервере 
Функция ПодсказкаПроизвольногоИсточникаДанных()
	ПодсказкаИсточника = НСтр("ru='В запросе схемы компоновки данных следует добавить поле выборки и условие вида:
|""%1"" КАК ИсточникДанных.'
|;uk='У запиті схеми компонування даних слід додати поле вибірки і умову виду: 
|""%1"" КАК ИсточникДанных.'");
	ПодсказкаИсточника = СтрШаблон(ПодсказкаИсточника, 
		?(ЗначениеЗаполнено(Объект.ИсточникДанных), Объект.ИсточникДанных, ПредставлениеСтатьиБюджетов));
	
	Возврат ПодсказкаИсточника; 
КонецФункции

&НаСервере
Процедура ИсточникСуммыОперацииПриИзмененииНаСервере()
	НастроитьЭлементыФормы();
КонецПроцедуры

&НаКлиенте
Процедура ИсточникСуммыОперацииПриИзменении(Элемент)
	ИсточникСуммыОперацииПриИзмененииНаСервере();
КонецПроцедуры

#КонецОбласти