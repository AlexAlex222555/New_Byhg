
#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	Если Параметры.Свойство("АвтоТест") Тогда // Возврат при получении формы для анализа.
		Возврат;
	КонецЕсли;

	ОбновлениеИнформационнойБазы.ПроверитьОбъектОбработан(Объект, ЭтотОбъект);
	
	Элементы.ПоОрганизациям.Видимость = ПолучитьФункциональнуюОпцию("ИспользоватьНесколькоОрганизаций");
	Элементы.ПоПодразделениям.Видимость = ПолучитьФункциональнуюОпцию("ИспользоватьПодразделения");
	
	ЕдиницаИзмеренияОпределяетсяАналитикой = Объект.ЕдиницаИзмеренияОпределяетсяАналитикой;
	ВалютаОпределяетсяАналитикой = Объект.ВалютаОпределяетсяАналитикой;
	ЗагружатьИзДругихПодсистем = Объект.ЗагружатьИзДругихПодсистем;
	УстанавливатьЗначениеНаКаждыйПериод = Объект.УстанавливатьЗначениеНаКаждыйПериод;
	
	ХранилищеНастроекКомпоновкиДанных = ПоместитьВоВременноеХранилище(
										Объект.Ссылка.ХранилищеНастроекКомпоновкиДанных.Получить(), УникальныйИдентификатор);
	ХранилищеСхемыКомпоновкиДанных = ПоместитьВоВременноеХранилище(
										Объект.Ссылка.ХранилищеСхемыКомпоновкиДанных.Получить(), УникальныйИдентификатор);
	
	ЗаполнитьСписокСхемКомпоновкиДанных();
	
	ИнициализироватьКомпоновщикНастроек();
	ЗаполнитьНастройкиЗаполненияАналитики();
	
	// СтандартныеПодсистемы.ЗапретРедактированияРеквизитовОбъектов
	ЗапретРедактированияРеквизитовОбъектов.ЗаблокироватьРеквизиты(ЭтаФорма);
	// Конец СтандартныеПодсистемы.ЗапретРедактированияРеквизитовОбъектов
	
	УправлениеФормой();
	НастроитьПанельНавигацииИДействий();
	
	УстановитьПодпериоды();
	
	УстановитьУсловноеОформление();
	
	// СтандартныеПодсистемы.ПодключаемыеКоманды
	ПодключаемыеКоманды.ПриСозданииНаСервере(ЭтотОбъект);
	// Конец СтандартныеПодсистемы.ПодключаемыеКоманды
	
	СобытияФорм.ПриСозданииНаСервере(ЭтаФорма, Отказ, СтандартнаяОбработка);
	
КонецПроцедуры

&НаСервере
Процедура ПередЗаписьюНаСервере(Отказ, ТекущийОбъект, ПараметрыЗаписи)
	
	ТекущийОбъект.ХранилищеНастроекКомпоновкиДанных = Неопределено;
	ТекущийОбъект.ХранилищеСхемыКомпоновкиДанных    = Неопределено;
	
	Если ЭтоАдресВременногоХранилища(ХранилищеНастроекКомпоновкиДанных) Тогда
		ТекущийОбъект.ХранилищеНастроекКомпоновкиДанных = Новый ХранилищеЗначения(
									ПолучитьИзВременногоХранилища(ХранилищеНастроекКомпоновкиДанных));
	КонецЕсли;
	Если ЭтоАдресВременногоХранилища(ХранилищеСхемыКомпоновкиДанных) Тогда
		ТекущийОбъект.ХранилищеСхемыКомпоновкиДанных    = Новый ХранилищеЗначения(
									ПолучитьИзВременногоХранилища(ХранилищеСхемыКомпоновкиДанных));
	КонецЕсли;
	
	БюджетированиеСервер.ПоместитьНастройкиЗаполненияАналитикиВПравило(ЭтаФорма, ТекущийОбъект);
	
КонецПроцедуры

&НаСервере
Процедура ПослеЗаписиНаСервере(ТекущийОбъект, ПараметрыЗаписи)

	// СтандартныеПодсистемы.УправлениеДоступом
	УправлениеДоступом.ПослеЗаписиНаСервере(ЭтотОбъект, ТекущийОбъект, ПараметрыЗаписи);
	// Конец СтандартныеПодсистемы.УправлениеДоступом
	
	// СтандартныеПодсистемы.ЗапретРедактированияРеквизитовОбъектов
	ЗапретРедактированияРеквизитовОбъектов.ЗаблокироватьРеквизиты(ЭтаФорма);
	// Конец СтандартныеПодсистемы.ЗапретРедактированияРеквизитовОбъектов
	
	УправлениеФормой();
	НастроитьПанельНавигацииИДействий();
	
КонецПроцедуры

&НаКлиенте
Процедура ПослеЗаписи(ПараметрыЗаписи)
	
	Оповестить("Запись_НефинансовыеПоказателиБюджетов", , Объект.Ссылка);
	
КонецПроцедуры

&НаСервере
Процедура ОбработкаПроверкиЗаполненияНаСервере(Отказ, ПроверяемыеРеквизиты)
	
	БюджетированиеСервер.ОбработкаПроверкиНастроекЗаполненияАналитики(НастройкиЗаполненияАналитики, Отказ, Объект.РасширенныйРежимНастройкиЗаполненияАналитики);
	
КонецПроцедуры

&НаСервере
Процедура ПриЧтенииНаСервере(ТекущийОбъект)

	// СтандартныеПодсистемы.УправлениеДоступом
	Если ОбщегоНазначения.ПодсистемаСуществует("СтандартныеПодсистемы.УправлениеДоступом") Тогда
		МодульУправлениеДоступом = ОбщегоНазначения.ОбщийМодуль("УправлениеДоступом");
		МодульУправлениеДоступом.ПриЧтенииНаСервере(ЭтотОбъект, ТекущийОбъект);
	КонецЕсли;
	// Конец СтандартныеПодсистемы.УправлениеДоступом
	
	// СтандартныеПодсистемы.ПодключаемыеКоманды
	ПодключаемыеКомандыКлиентСервер.ОбновитьКоманды(ЭтотОбъект, Объект);
	// Конец СтандартныеПодсистемы.ПодключаемыеКоманды
	
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
Процедура ОпределятьЕдиницуИзмеренияПриИзменении(Элемент)
	
	Объект.ЕдиницаИзмеренияОпределяетсяАналитикой = ЕдиницаИзмеренияОпределяетсяАналитикой;
	УправлениеФормой();
	
КонецПроцедуры

&НаКлиенте
Процедура ПоСценариямПриИзменении(Элемент)
	
	УправлениеФормой();
	
КонецПроцедуры

&НаКлиенте
Процедура ПоПериодамПриИзменении(Элемент)
	
	УправлениеФормой();
	
КонецПроцедуры

&НаКлиенте
Процедура ВидАналитикиПриИзменении(Элемент)
	
	ВидАналитикиПриИзмененииНаСервере();
	
КонецПроцедуры

&НаКлиенте
Процедура ВидПоказателяПриИзменении(Элемент)
	
	УправлениеФормой();
	
КонецПроцедуры

&НаКлиенте
Процедура СхемаКомпоновкиДанныхПриИзменении(Элемент)
	
	ИнициализироватьКомпоновщикНастроек();
	
КонецПроцедуры

&НаКлиенте
Процедура ЗагружатьИзДругихПодсистемПриИзменении(Элемент)
	
	ЗагружатьИзДругихПодсистемПриИзмененииСервер();
	
КонецПроцедуры

&НаКлиенте
Процедура ВалютаОпределяетсяАналитикойПриИзменении(Элемент)
	
	Объект.ВалютаОпределяетсяАналитикой = ВалютаОпределяетсяАналитикой;
	УправлениеФормой();
	
КонецПроцедуры

&НаКлиенте
Процедура ДействуетПокаНеУстановленоНовоеПриИзменении(Элемент)
	
	Объект.УстанавливатьЗначениеНаКаждыйПериод = УстанавливатьЗначениеНаКаждыйПериод;
	УправлениеФормой();
	
КонецПроцедуры

&НаКлиенте
Процедура УстанавливатьНаКаждыйПериодПриИзменении(Элемент)
	
	Объект.УстанавливатьЗначениеНаКаждыйПериод = УстанавливатьЗначениеНаКаждыйПериод;
	УправлениеФормой();
	
КонецПроцедуры

&НаКлиенте
Процедура ПериодичностьПериодовПриИзменении(Элемент)
	
	УстановитьПодпериоды();
	
КонецПроцедуры

&НаКлиенте
Процедура НастройкиЗаполненияАналитикиВыражениеЗаполненияАналитикиНачалоВыбора(Элемент, ДанныеВыбора, СтандартнаяОбработка)
	
	СтандартнаяОбработка = Ложь;
	
	ТекущиеДанные = Элементы.НастройкиЗаполненияАналитики.ТекущиеДанные;
	РазделИсточникаДанных = ПредопределенноеЗначение("Перечисление.РазделыИсточниковДанныхБюджетирования.ПроизвольныеДанные");
	
	ПараметрыФормы = Новый Структура;
	ПараметрыФормы.Вставить("ВидАналитики",               ТекущиеДанные.ВидАналитики);
	ПараметрыФормы.Вставить("АдресСхемыКомпоновкиДанных", АдресСхемыКомпоновкиДанных);
	ПараметрыФормы.Вставить("РазделИсточникаДанных",      РазделИсточникаДанных);
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
	
	ПараметрыВыбораЗначенияАналитики = Новый Массив;
	
	ТекущиеДанные = Элементы.НастройкиЗаполненияАналитики.ТекущиеДанные;
	Если ТекущиеДанные <> Неопределено И ЗначениеЗаполнено(ТекущиеДанные.ДополнительноеСвойство) Тогда
		НовыйПараметрВыбора = Новый ПараметрВыбора("Отбор.Владелец", ТекущиеДанные.ДополнительноеСвойство);
		ПараметрыВыбораЗначенияАналитики.Добавить(НовыйПараметрВыбора);
	КонецЕсли;
	
	Элементы.НастройкиЗаполненияАналитикиЗначениеАналитики.ПараметрыВыбора = Новый ФиксированныйМассив(ПараметрыВыбораЗначенияАналитики);
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура НастроитьСхемуПолученияДанных(Команда)
	
	// Открыть редактор настроек схемы компоновки данных
	ЗаголовокФормыНастройкиСхемыКомпоновкиДанных = НСтр("ru='Настройка схемы компоновки данных для нефинансового показателя ""%1""';uk='Настройка схеми компоновки даних для нефінансового показника ""%1""'");
	ЗаголовокФормыНастройкиСхемыКомпоновкиДанных = СтрЗаменить(ЗаголовокФормыНастройкиСхемыКомпоновкиДанных, "%1", Объект.Наименование);
	
	Адреса = БюджетированиеВызовСервера.ПолучитьАдресаСхемыКомпоновкиДанныхВоВременномХранилище(
				Объект.СхемаКомпоновкиДанных, ХранилищеСхемыКомпоновкиДанных, 
				ХранилищеНастроекКомпоновкиДанных, УникальныйИдентификатор);
				
	ОписаниеОповещения = Новый ОписаниеОповещения("ПриОкончанииНастройкиСхемыКомпоновкиДанных", ЭтотОбъект, Адреса);
	
	ПараметрыФормы = Новый Структура;
	ПараметрыФормы.Вставить("НеПомещатьНастройкиВСхемуКомпоновкиДанных", Истина);
	ПараметрыФормы.Вставить("НеРедактироватьСхемуКомпоновкиДанных", Ложь);
	ПараметрыФормы.Вставить("НеЗагружатьСхемуКомпоновкиДанныхИзФайла", Ложь);
	ПараметрыФормы.Вставить("НеНастраиватьУсловноеОформление", Истина);
	ПараметрыФормы.Вставить("НеНастраиватьПараметры", Истина);
	ПараметрыФормы.Вставить("НеНастраиватьВыбор", Истина);
	ПараметрыФормы.Вставить("НеНастраиватьПорядок", Истина);
	ПараметрыФормы.Вставить("УникальныйИдентификатор", УникальныйИдентификатор);
	ПараметрыФормы.Вставить("АдресСхемыКомпоновкиДанных", Адреса.СхемаКомпоновкиДанных);
	ПараметрыФормы.Вставить("АдресНастроекКомпоновкиДанных", Адреса.НастройкиКомпоновкиДанных);
	ПараметрыФормы.Вставить("Заголовок", ЗаголовокФормыНастройкиСхемыКомпоновкиДанных);
	
	ОткрытьФорму("ОбщаяФорма.УпрощеннаяНастройкаСхемыКомпоновкиДанных", 
		ПараметрыФормы, 
		ЭтаФорма, 
		, 
		, 
		, 
		ОписаниеОповещения, 
		РежимОткрытияОкнаФормы.БлокироватьОкноВладельца);
	
КонецПроцедуры

&НаКлиенте
Процедура ЗаполнитьНастройкиАналитикиПоДаннымИсточника(Команда)
	
	ЗаполнитьНастройкиАналитикиПоДаннымИсточникаСервер();
	
КонецПроцедуры

&НаКлиенте
Процедура ВключитьРежимРасширеннойНастройкиЗаполненияАналитик(Команда)
	
	ВключитьРежимРасширеннойНастройкиЗаполненияАналитикиСервер();
	
КонецПроцедуры

&НаКлиенте
Процедура ОтключитьРежимРасширеннойНастройкиЗаполненияАналитики(Команда)
	
	ОтключитьРежимРасширеннойНастройкиЗаполненияАналитикиСервер();
	
КонецПроцедуры

&НаСервере
Процедура УстановитьУсловноеОформление()
	
	УсловноеОформление.Элементы.Очистить();
	БюджетированиеСервер.УстановитьУсловноеНастроекЗаполненияАналитики(УсловноеОформление);
	
КонецПроцедуры

&НаСервере
Процедура ИнициализироватьКомпоновщикНастроек() 
	
	Если ЗначениеЗаполнено(Объект.СхемаКомпоновкиДанных) Тогда
		СхемаКомпоновкиДанных = 
			Справочники.НефинансовыеПоказателиБюджетов.ПредопределеннаяСхемаПолученияДанных(Объект.СхемаКомпоновкиДанных);
	ИначеЕсли ЭтоАдресВременногоХранилища(ХранилищеСхемыКомпоновкиДанных) Тогда
		ХранилищеЗначения = ПолучитьИзВременногоХранилища(ХранилищеСхемыКомпоновкиДанных);
		Если ТипЗнч(ХранилищеЗначения) = Тип("ХранилищеЗначения") Тогда
			СхемаКомпоновкиДанных = ХранилищеЗначения.Получить();
		КонецЕсли;
	КонецЕсли;
	
	Если СхемаКомпоновкиДанных = Неопределено Тогда
		СхемаКомпоновкиДанных = ФинансоваяОтчетностьСервер.НоваяСхема();
		НаборДанных = КомпоновкаДанныхСервер.ДобавитьПустойНаборДанных(СхемаКомпоновкиДанных);
		НаборДанных.Запрос = 
			"ВЫБРАТЬ
			|*";
	КонецЕсли;
	
	Правило = Новый Структура;
	Правило.Вставить("РазделИсточникаДанных", Перечисления.РазделыИсточниковДанныхБюджетирования.ПроизвольныеДанные);
	Правило.Вставить("ПромежуточноеКэшированиеРезультатовРаботыПравил", Ложь);
	БюджетированиеСервер.УстановитьСвойстваПолейДляНастройкиПравила(СхемаКомпоновкиДанных, Правило);
	
	АдресСхемыКомпоновкиДанных = ПоместитьВоВременноеХранилище(СхемаКомпоновкиДанных, УникальныйИдентификатор);
	КомпоновщикНастроек.Инициализировать(Новый ИсточникДоступныхНастроекКомпоновкиДанных(АдресСхемыКомпоновкиДанных));
	
	БюджетированиеСервер.ПроверитьДоступностьПолейЗаполненияАналитики(ЭтаФорма, Объект, Истина);
	
КонецПроцедуры

&НаСервере
Процедура ЗаполнитьСписокСхемКомпоновкиДанных()
	
	// Заполнение списка схем компоновки данных
	Для каждого Макет Из Метаданные.НайтиПоТипу(ТипЗнч(Объект.Ссылка)).Макеты Цикл
		Если Макет.ТипМакета = Метаданные.СвойстваОбъектов.ТипМакета.СхемаКомпоновкиДанных Тогда
			Элементы.СхемаКомпоновкиДанных.СписокВыбора.Добавить(Макет.Имя, Макет.Синоним);
		КонецЕсли;
	КонецЦикла;
	
	ПредставлениеПроизвольнойСхемы = НСтр("ru='Произвольный';uk='Довільний'");
	Элементы.СхемаКомпоновкиДанных .СписокВыбора.Добавить("", ПредставлениеПроизвольнойСхемы);
	
КонецПроцедуры

&НаСервере
Процедура УправлениеФормой()
	
	СписокВыбора = Элементы.ЗагружатьИзДругихПодсистем.СписокВыбора;
	Если Объект.ПоСценариям Тогда
		СписокВыбора[0].Представление = НСтр("ru='Плановые и фактические данные устанавливаются документом и хранятся в подсистеме ""Бюджетирование и планирование""';uk='Планові і фактичні дані встановлюються документом і зберігаються в підсистемі ""Бюджетування і планування""'");
		СписокВыбора[1].Представление = НСтр("ru='Плановые данные устанавливаются документом, фактические загружаются из других подсистем';uk='Планові дані встановлюються документом, фактичні завантажуються з інших підсистем'");
	Иначе
		СписокВыбора[0].Представление = НСтр("ru='Значения устанавливаются документом';uk='Значення встановлюються документом'");
		СписокВыбора[1].Представление = НСтр("ru='Значения загружаются из других подсистем';uk='Значення завантажуються з інших підсистем'");
	КонецЕсли;
	
	Элементы.ГруппаФактическиеДанные.Видимость = Объект.ЗагружатьИзДругихПодсистем;
	
	Если Объект.ПоСценариям
		И Объект.ЗагружатьИзДругихПодсистем Тогда
		Элементы.ГруппаНастройкиПолучения.Заголовок = НСтр("ru='Фактические данные';uk='Фактичні дані'");
	Иначе 
		Элементы.ГруппаНастройкиПолучения.Заголовок = НСтр("ru='Получение данных из других подсистем';uk='Отримання даних з інших підсистем'");
	КонецЕсли;
	
	Элементы.Периодичность.Видимость = Не Объект.ПоПериодам;
	Если Элементы.ВидАналитики1.Доступность Тогда
		Элементы.Периодичность.Доступность = УстанавливатьЗначениеНаКаждыйПериод;
	КонецЕсли;
	
	Если Объект.ВидПоказателя = Перечисления.ВидыНефинансовыхПоказателей.Денежный Тогда
		Элементы.СтраницыВидаПоказателя.ТекущаяСтраница = Элементы.ГруппаПризнакиВалюты;
	ИначеЕсли Объект.ВидПоказателя = Перечисления.ВидыНефинансовыхПоказателей.Количественный Тогда
		Элементы.СтраницыВидаПоказателя.ТекущаяСтраница = Элементы.ГруппаПризнакиКоличества;
	Иначе
		Элементы.СтраницыВидаПоказателя.ТекущаяСтраница = Элементы.Коэффициент;
	КонецЕсли;
	
	ТолькоПросмотрПризнаковУчета = Элементы.ВидАналитики1.ТолькоПросмотр;
	Элементы.ЕдиницаИзмерения.ТолькоПросмотр 						= ТолькоПросмотрПризнаковУчета;
	Элементы.АналитикаЕдиницыИзмерения.ТолькоПросмотр 				= ТолькоПросмотрПризнаковУчета;
	Элементы.АналитикаВалюты.ТолькоПросмотр 						= ТолькоПросмотрПризнаковУчета;
	Элементы.ПериодичностьПериодов.ТолькоПросмотр 					= ТолькоПросмотрПризнаковУчета;
	Элементы.ПериодичностьПодпериодов.ТолькоПросмотр 				= ТолькоПросмотрПризнаковУчета;
	Элементы.ВалютаОпределяетсяАналитикой.ТолькоПросмотр 			= ТолькоПросмотрПризнаковУчета;
	Элементы.ВалютаУказываетсяВДанных.ТолькоПросмотр 				= ТолькоПросмотрПризнаковУчета;
	Элементы.УказаннаяЕдиницаИзмерения.ТолькоПросмотр 				= ТолькоПросмотрПризнаковУчета;
	Элементы.ЕдиницаИзмеренияОпределяетсяАналитикой.ТолькоПросмотр 	= ТолькоПросмотрПризнаковУчета;
	
	Элементы.ЕдиницаИзмерения.Доступность = Не ЕдиницаИзмеренияОпределяетсяАналитикой;
	Элементы.АналитикаЕдиницыИзмерения.Доступность = ЕдиницаИзмеренияОпределяетсяАналитикой;
	Элементы.АналитикаВалюты.Доступность = ВалютаОпределяетсяАналитикой;
	Элементы.ПериодичностьПериодов.Доступность = Объект.ПоПериодам;
	Элементы.ПериодичностьПодпериодов.Доступность = Объект.ПоПериодам;
	
	Элементы.ДействуетПокаНеУстановленоНовое.ТолькоПросмотр = Элементы.ВидАналитики1.ТолькоПросмотр;
	Элементы.УстанавливатьНаКаждыйПериод.ТолькоПросмотр = Элементы.ВидАналитики1.ТолькоПросмотр;
	Элементы.ЗагружатьИзДругихПодсистем.ТолькоПросмотр = Элементы.ВидАналитики1.ТолькоПросмотр;
	
	Массив = Новый Массив;
	Для Сч = 1 По 6 Цикл
		Массив.Добавить(Объект["ВидАналитики" + Сч]);
	КонецЦикла;
	
	ПараметрыВыбораАналитики = Элементы.АналитикаЕдиницыИзмерения.ПараметрыВыбора;
	МассивВыбора = Новый Массив(ПараметрыВыбораАналитики);
	МассивВыбора[1] = 
		Новый ПараметрВыбора("Отбор.Ссылка", Новый ФиксированныйМассив(Массив));
	Элементы.АналитикаЕдиницыИзмерения.ПараметрыВыбора = Новый ФиксированныйМассив(МассивВыбора);
	
	ПараметрыВыбораАналитики = Элементы.АналитикаВалюты.ПараметрыВыбора;
	МассивВыбора = Новый Массив(ПараметрыВыбораАналитики);
	МассивВыбора[1] = 
		Новый ПараметрВыбора("Отбор.Ссылка", Новый ФиксированныйМассив(Массив));
	Элементы.АналитикаВалюты.ПараметрыВыбора = Новый ФиксированныйМассив(МассивВыбора);
	
	Элементы.ГруппаНастройкаЗаполненияАналитики.Видимость = Объект.ЗагружатьИзДругихПодсистем;
	
	Элементы.ВключитьРежимРасширеннойНастройкиЗаполненияАналитики.Видимость = Не Объект.РасширенныйРежимНастройкиЗаполненияАналитики;
	Элементы.ГруппаНастройкаЗаполненияАналитикиПояснение.Видимость = Не Объект.РасширенныйРежимНастройкиЗаполненияАналитики;
	
	Элементы.ОтключитьРежимРасширеннойНастройкиЗаполненияАналитики.Видимость = Объект.РасширенныйРежимНастройкиЗаполненияАналитики;
	Элементы.НастройкиЗаполненияАналитики.Видимость = Объект.РасширенныйРежимНастройкиЗаполненияАналитики;
	
КонецПроцедуры

&НаКлиенте
Процедура ПриОкончанииНастройкиСхемыКомпоновкиДанных(АдресВоВременномХранилище, Адреса) Экспорт
	
	Если ЗначениеЗаполнено(АдресВоВременномХранилище) Тогда
		ПрименитьРезультатНастройкиСхемыКомпоновкиДанныхСервер(АдресВоВременномХранилище, Адреса);
	КонецЕсли;
	
КонецПроцедуры

&НаСервере
Процедура ПрименитьРезультатНастройкиСхемыКомпоновкиДанныхСервер(АдресВоВременномХранилище, Адреса)
	
	РезультатОтражения = 
			БюджетированиеВызовСервера.ПрименитьИзмененияКСхемеКомпоновкиДанных(
			Объект.СхемаКомпоновкиДанных, 
			Адреса.СхемаКомпоновкиДанных, 
			АдресВоВременномХранилище, 
			Истина);
	
	Объект.СхемаКомпоновкиДанных = РезультатОтражения.СхемаКомпоновкиДанных;
	ХранилищеСхемыКомпоновкиДанных = РезультатОтражения.ХранилищеСхемыКомпоновкиДанных;
	ХранилищеНастроекКомпоновкиДанных = РезультатОтражения.ХранилищеНастроекКомпоновкиДанных;
	ИнициализироватьКомпоновщикНастроек();
	Модифицированность = Истина;
	
КонецПроцедуры

&НаСервере
Процедура УстановитьСвязанныеПараметры()
	
	Массив = Новый Массив;
	Для Сч = 1 По 6 Цикл
		Массив.Добавить(Объект["ВидАналитики" + Сч]);
	КонецЦикла;
	
	Если Массив.Найти(Объект.АналитикаВалюты) = Неопределено Тогда
		Объект.АналитикаВалюты = Неопределено;
	КонецЕсли;
	
	Если Массив.Найти(Объект.АналитикаЕдиницыИзмерения) = Неопределено Тогда
		Объект.АналитикаЕдиницыИзмерения = Неопределено;
	КонецЕсли;
	
КонецПроцедуры

&НаСервере
Процедура ВидАналитикиПриИзмененииНаСервере()
	
	УправлениеФормой();
	УстановитьСвязанныеПараметры();
	
КонецПроцедуры

&НаКлиенте
Процедура Подключаемый_РазрешитьРедактированиеРеквизитовОбъекта(Команда)
	
	Оповещение = Новый ОписаниеОповещения("РазрешитьРедактированиеРеквизитовОбъектаЗавершение", ЭтотОбъект);
	ОбщегоНазначенияУТКлиент.РазрешитьРедактированиеРеквизитовОбъекта(ЭтаФорма,,Оповещение);
	
КонецПроцедуры

&НаСервере
Процедура УстановитьПодпериоды()
	
	Периодичности = Перечисления.Периодичность.УпорядоченныеПериодичности();
	Индекс = Периодичности.Найти(Объект.Периодичность);
	Элементы.ПериодичностьПодпериодов.СписокВыбора.Очистить();
	
	Для Сч = 0 По Индекс - 1 Цикл
		Если Не ЗначениеЗаполнено(Периодичности[Сч]) Тогда
			Продолжить;
		КонецЕсли;
		Элементы.ПериодичностьПодпериодов.СписокВыбора.Добавить(Периодичности[Сч]);
	КонецЦикла;
	
	ИндексПодпериодов = Периодичности.Найти(Объект.ПериодичностьПодпериодов);
	Если ИндексПодпериодов >= Индекс И Индекс > 0 Тогда
		Объект.ПериодичностьПодпериодов = Периодичности[Индекс - 1];
	КонецЕсли;
	
КонецПроцедуры

&НаСервере
Процедура ЗагружатьИзДругихПодсистемПриИзмененииСервер()
	
	Объект.ЗагружатьИзДругихПодсистем = ЗагружатьИзДругихПодсистем;
	Если Не ЗагружатьИзДругихПодсистем Тогда
		Объект.РасширенныйРежимНастройкиЗаполненияАналитики = Ложь;
		ЗаполнитьНастройкиЗаполненияАналитики();
	КонецЕсли;
	УправлениеФормой();
	
КонецПроцедуры

&НаСервере
Процедура ЗаполнитьНастройкиЗаполненияАналитики()
	
	ВидыАналитик = Новый Структура;
	Для НомерАналитики = 1 По 6 Цикл
		ВидыАналитик.Вставить("ВидАналитики" + НомерАналитики, Объект["ВидАналитики" + НомерАналитики]);
	КонецЦикла;
	БюджетированиеСервер.ЗаполнитьНастройкиЗаполненияАналитикиПоПравилу(ЭтаФорма, Объект, ВидыАналитик);
	БюджетированиеСервер.ПроверитьДоступностьПолейЗаполненияАналитики(ЭтаФорма, Объект);
	
КонецПроцедуры

&НаСервере
Процедура ВключитьРежимРасширеннойНастройкиЗаполненияАналитикиСервер()
	
	Объект.РасширенныйРежимНастройкиЗаполненияАналитики = Истина;
	ЗаполнитьНастройкиЗаполненияАналитики();
	БюджетированиеСервер.УстановитьНастройкиЗаполненияАналитикиАвтоматически(ЭтаФорма);
	УправлениеФормой();
	
КонецПроцедуры

&НаСервере
Процедура ОтключитьРежимРасширеннойНастройкиЗаполненияАналитикиСервер()
	
	Объект.РасширенныйРежимНастройкиЗаполненияАналитики = Ложь;
	ЗаполнитьНастройкиЗаполненияАналитики();
	УправлениеФормой();
	
КонецПроцедуры

&НаСервере
Процедура ЗаполнитьНастройкиАналитикиПоДаннымИсточникаСервер()
	
	БюджетированиеСервер.УстановитьНастройкиЗаполненияАналитикиАвтоматически(ЭтаФорма);
	
КонецПроцедуры

&НаСервере
Процедура ВыражениеЗаполненияАналитикиОбработкаВыбораСервер(ИдентификаторСтроки) 
	
	БюджетированиеСервер.ПроверитьВыражениеЗаполненияАналитикиПослеВыбора(ЭтаФорма, ИдентификаторСтроки);
	
КонецПроцедуры

&НаКлиенте
Процедура РазрешитьРедактированиеРеквизитовОбъектаЗавершение(Результат, ДополнительныеПараметры) Экспорт
	
	УправлениеФормой();
	
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

&НаСервере
Процедура НастроитьПанельНавигацииИДействий()

	СтруктураНастроек = Новый Структура;
	СтруктураНастроек.Вставить("ИспользоватьУстанавливаемыйНефинансовыйПоказательБюджетов", Не Объект.ЗагружатьИзДругихПодсистем);
	
	ОбщегоНазначенияУТ.НастроитьФормуПоПараметрам(ЭтаФорма, СтруктураНастроек);

КонецПроцедуры

#КонецОбласти