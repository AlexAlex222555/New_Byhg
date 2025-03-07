
#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	Если Параметры.Свойство("АвтоТест") Тогда // Возврат при получении формы для анализа.
		Возврат;
	КонецЕсли;
	
	ДанныеОбъекта = Справочники.ЭлементыФинансовыхОтчетов.ФормаПриСозданииНаСервере(ЭтаФорма);
	ИсточникиЗначений.Загрузить(ДанныеОбъекта.ИсточникиЗначений);
	
	ДеревоЭлементов = ДанныеФормыВЗначение(Параметры.ЭлементыОтчета, Тип("ДеревоЗначений"));
	АдресЭлементовОтчета = ПоместитьВоВременноеХранилище(ДеревоЭлементов, УникальныйИдентификатор);
	
	Заголовок = Параметры.ВидЭлемента;
	
	Если ТипИзмерения = Перечисления.ТипыИзмеренийФинансовогоОтчета.ИзмерениеРегистраБухгалтерии Тогда
		Элементы.ИмяИзмерения.СписокВыбора.Очистить();
		Элементы.ИмяИзмерения.СписокВыбора.Добавить("Организация",   НСтр("ru='Организация';uk='Організація'"));
		Элементы.ИмяИзмерения.СписокВыбора.Добавить("Подразделение", НСтр("ru='Подразделение';uk='Підрозділ'"));
		Если Справочники.НаправленияДеятельности.ИспользуетсяУчетПоНаправлениям() Тогда
			Элементы.ИмяИзмерения.СписокВыбора.Добавить("НаправлениеДеятельности", НСтр("ru='Направление деятельности';uk='Напрям діяльності'"));
		КонецЕсли;
		Элементы.ИмяИзмерения.РедактированиеТекста = Ложь;
	ИначеЕсли ТипИзмерения = Перечисления.ТипыИзмеренийФинансовогоОтчета.Субконто Тогда
		ИмяИзмерения = "<ВидСубконто>";
		Элементы.ИмяИзмерения.Видимость = Ложь;
		Элементы.ВидСубконто.Видимость = Истина;
		Элементы.ВидСубконто.ОграничениеТипа = ФинансоваяОтчетностьСервер.ОписаниеТипаПоЗначению(ВидСубконто);
	Иначе
		МодельБюджетирования = Параметры.МодельБюджетирования;
		Если ПолучитьФункциональнуюОпцию("ФормироватьБюджетыПоПодразделениям",
				Новый Структура("МодельБюджетирования", МодельБюджетирования)) Тогда
			Элементы.ИмяИзмерения.СписокВыбора.Вставить(0, НСтр("ru='Подразделение';uk='Підрозділ'"));
		КонецЕсли;
		Если ПолучитьФункциональнуюОпцию("ФормироватьБюджетыПоОрганизациям",
				Новый Структура("МодельБюджетирования", МодельБюджетирования)) Тогда
			Элементы.ИмяИзмерения.СписокВыбора.Вставить(0, НСтр("ru='Организация';uk='Організація'"));
		КонецЕсли;
		Элементы.ГруппаДополнительныйОтбор.Видимость = Ложь;
	КонецЕсли;
	
	ДополнительныйРежимФормы = Параметры.ДополнительныйРежимФормы;
	
	УправлениеФормой();
	
	СобытияФорм.ПриСозданииНаСервере(ЭтаФорма, Отказ, СтандартнаяОбработка);
	
КонецПроцедуры

&НаСервере
Процедура ПередЗаписьюНаСервере(Отказ, ТекущийОбъект, ПараметрыЗаписи)
	
	Справочники.ЭлементыФинансовыхОтчетов.ФормаПередЗаписьюНаСервере(ЭтаФорма, ТекущийОбъект, Отказ);
	ДанныеОбъекта = ПолучитьИзВременногоХранилища(АдресЭлементаВХранилище);
	ДанныеОбъекта.ИсточникиЗначений = ИсточникиЗначений.Выгрузить();
	ПоместитьВоВременноеХранилище(ДанныеОбъекта, АдресЭлементаВХранилище);
	
КонецПроцедуры

&НаКлиенте
Процедура ПередЗакрытием(Отказ, СтандартнаяОбработка)
	
	Если ЗначениеЗаполнено(АдресЭлементаВХранилище) Тогда
		СтандартнаяОбработка = Ложь;
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
Процедура ИмяИзмеренияПриИзменении(Элемент)
	
	Если НЕ ЗначениеЗаполнено(ИмяИзмерения) Тогда
		Возврат;
	КонецЕсли;
	
	Объект.НаименованиеДляПечати = Элементы.ИмяИзмерения.СписокВыбора.НайтиПоЗначению(ИмяИзмерения).Представление;
	Если ТипИзмерения = ПредопределенноеЗначение("Перечисление.ТипыИзмеренийФинансовогоОтчета.ИзмерениеРегистраБухгалтерии") Тогда
		НастроитьПолеОтбора();
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ВидСубконтоПриИзменении(Элемент)
	
	ВидСубконтоПриИзмененииСервер();
	
КонецПроцедуры

&НаКлиенте
Процедура ИсточникиАналитикПоУмолчаниюПриИзменении(Элемент)
	
	Если ВыбранныеИсточникиЗначений Тогда
		ЗаполнитьИсточникиПоУмолчанию();
	Иначе
		УправлениеФормой();
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура ЗавершитьРедактирование(Команда)
	
	ФинансоваяОтчетностьКлиент.ЗавершитьРедактированиеЭлементаОтчета(ЭтаФорма);
	
КонецПроцедуры

&НаКлиенте
Процедура Подключаемый_ВыполнитьПереопределяемуюКоманду(Команда)
	
	СобытияФормКлиент.ВыполнитьПереопределяемуюКоманду(ЭтаФорма, Команда);
	
КонецПроцедуры

&НаКлиенте
Процедура ВыбратьИсточники(Команда)
	
	ПараметрыВыбораИсточников = Новый Структура("АдресЭлементаВХранилище, АдресЭлементовОтчета, ИсточникиЗначений", 
										АдресЭлементаВХранилище, АдресЭлементовОтчета, ИсточникиЗначений);
	
	Оповещение = Новый ОписаниеОповещения("ВыборИсточниковЗначений", ЭтаФорма);
	ОткрытьФорму("Справочник.ЭлементыФинансовыхОтчетов.Форма.ИсточникиЗначений", ПараметрыВыбораИсточников,,,,,
			Оповещение, РежимОткрытияОкнаФормы.БлокироватьОкноВладельца);
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаСервере
Процедура УправлениеФормой()
	
	ЭтоФинОтчет = ДополнительныйРежимФормы = Перечисления.ДополнительныеРежимыЭлементовОтчетов.ВидОтчета;
	
	Элементы.ГруппаИсточники.Видимость = Не ЭтоФинОтчет;
	
	Элементы.Точность.Видимость = ЭтоФинОтчет И Не Параметры.НеВыводитьТочность;
	
	Элементы.ВыбратьИсточники.Доступность = ВыбранныеИсточникиЗначений;
	Если Элементы.ВыбратьИсточники.Доступность И ИсточникиЗначений.Количество() Тогда
		Элементы.ВыбратьИсточники.Заголовок = НСтр("ru='Изменить источники (%1)';uk='Змінити джерела (%1)'");
		Элементы.ВыбратьИсточники.Заголовок = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(
					Элементы.ВыбратьИсточники.Заголовок, ИсточникиЗначений.Количество());
	Иначе
		Элементы.ВыбратьИсточники.Заголовок = НСтр("ru='Не указаны';uk='Не вказано'");
	КонецЕсли;
	
КонецПроцедуры

&НаСервере
Процедура ВидСубконтоПриИзмененииСервер()
	
	Объект.НаименованиеДляПечати = ОбщегоНазначения.ЗначениеРеквизитаОбъекта(ВидСубконто, "Наименование");
	НастроитьПолеОтбора();
	
КонецПроцедуры

&НаСервере
Процедура НастроитьПолеОтбора()
	
	Справочники.ЭлементыФинансовыхОтчетов.УстановитьНастройкиОтбора(ЭтаФорма, ЭтаФорма.Компоновщик, Объект.ВидЭлемента, Компоновщик.Настройки);
	
КонецПроцедуры

&НаКлиенте
Процедура ВыборИсточниковЗначений(Результат, ДополнительныеПараметры) Экспорт
	
	Если Результат = Неопределено Тогда
		Возврат;
	КонецЕсли;
	
	ИсточникиЗначений.Очистить();
	ОбщегоНазначенияКлиентСервер.ДополнитьТаблицуИзМассива(ИсточникиЗначений, Результат, "Источник");
	
	УправлениеФормой();
	
КонецПроцедуры

&НаСервере
Процедура ЗаполнитьИсточникиПоУмолчанию()
	Кэш = Неопределено;
	
	РассчитанныеИсточникиЗначений = БюджетнаяОтчетностьРасчетКэшаСервер.ИсточникиЗначенийПоУмолчанию(Кэш, АдресЭлементовОтчета, АдресЭлементаВХранилище);
	ИсточникиЗначений.Загрузить(РассчитанныеИсточникиЗначений);
	УправлениеФормой();
	
КонецПроцедуры

#КонецОбласти
