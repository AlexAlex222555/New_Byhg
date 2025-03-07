#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ОбработчикиСобытий

Процедура ОбработкаПроверкиЗаполнения(Отказ, ПроверяемыеРеквизиты)

	МассивНепроверяемыхРеквизитов = Новый Массив;
	ИспользоватьХарактеристики = ПолучитьФункциональнуюОпцию("ИспользоватьХарактеристикиНоменклатуры");
	// Проверка заполнения характеристик в т.ч. товары.
	НоменклатураСервер.ПроверитьЗаполнениеХарактеристик(ЭтотОбъект, МассивНепроверяемыхРеквизитов, Отказ);
	
	ПараметрыПроверкиКоличества = ОбщегоНазначенияУТ.ПараметрыПроверкиЗаполненияКоличества();
	ПараметрыПроверкиКоличества.ПроверитьВозможностьОкругления = Ложь;
	ОбщегоНазначенияУТ.ПроверитьЗаполнениеКоличества(ЭтотОбъект, ПроверяемыеРеквизиты, Отказ, ПараметрыПроверкиКоличества);

	// Проверка заполнения характеристик в шапке.
	Если Не ИспользоватьХарактеристики Или Не Справочники.Номенклатура.ХарактеристикиИспользуются(Владелец) Тогда

		МассивНепроверяемыхРеквизитов.Добавить("Характеристика");

	КонецЕсли;
	
	ПроверятьХарактеристикуКомпонента = 
		ИспользоватьХарактеристики И Не ЗначениеЗаполнено(ХарактеристикаОсновногоКомпонента)
		И Справочники.Номенклатура.ХарактеристикиИспользуются(НоменклатураОсновногоКомпонента);
	Если ПроверятьХарактеристикуКомпонента Тогда
		ПроверяемыеРеквизиты.Добавить("ХарактеристикаОсновногоКомпонента");
	КонецЕсли;
	
	Если ЗначениеЗаполнено(НоменклатураОсновногоКомпонента) Тогда
		ОтборТоваров =
			Новый Структура("Номенклатура, Характеристика", НоменклатураОсновногоКомпонента, ХарактеристикаОсновногоКомпонента);
		ПредставлениеОсновногоКомпонента =
			НоменклатураКлиентСервер.ПредставлениеНоменклатуры(НоменклатураОсновногоКомпонента, ХарактеристикаОсновногоКомпонента);
		Если Товары.НайтиСтроки(ОтборТоваров).Количество() = 0 Тогда
			ТекстСообщения = НСтр("ru='Основной компонент `%НазваниеТовара%` в товарах не найден.
|Укажите основной компонент из перечня товаров'
|;uk='Основний компонент `%НазваниеТовара%` в товарах не знайдено.
|Вкажіть основний компонент з переліку товарів'");
			ТекстСообщения = СтрЗаменить(ТекстСообщения, "%НазваниеТовара%", ПредставлениеОсновногоКомпонента);
			
			ОбщегоНазначенияКлиентСервер.СообщитьПользователю(ТекстСообщения, , , "Объект", Отказ);
		КонецЕсли;
	КонецЕсли;
	
	ОтборТоваров = Новый Структура("Номенклатура, Характеристика", Владелец, Характеристика);
	ПредставлениеВладельца = НоменклатураКлиентСервер.ПредставлениеНоменклатуры(Владелец, Характеристика);
	Для Каждого СтрокаТЧ Из Товары.НайтиСтроки(ОтборТоваров) Цикл
		ТекстСообщения = НСтр("ru='В строке %НомерСтроки% указан товар ""%НазваниеТовара%"".
|Один и тот же товар не может являться и комплектом, и комплектующей одновременно.'
|;uk='У рядку %НомерСтроки% вказаний товар ""%НазваниеТовара%"".
|Той самий товар не може бути і комплектом, і комплектуючої одночасно.'");
		ТекстСообщения = СтрЗаменить(ТекстСообщения, "%НазваниеТовара%", ПредставлениеВладельца);
		ТекстСообщения = СтрЗаменить(ТекстСообщения, "%НомерСтроки%", СтрокаТЧ.НомерСтроки);
		
		Поле = ОбщегоНазначенияКлиентСервер.ПутьКТабличнойЧасти("Товары", СтрокаТЧ.НомерСтроки, "Номенклатура");
		ОбщегоНазначенияКлиентСервер.СообщитьПользователю(ТекстСообщения, , Поле, "Объект", Отказ);
	КонецЦикла;
	
	ТипНоменклатуры = ОбщегоНазначения.ЗначениеРеквизитаОбъекта(Владелец, "ТипНоменклатуры");
	Если ТипНоменклатуры = Перечисления.ТипыНоменклатуры.Набор Тогда
		МассивНепроверяемыхРеквизитов.Добавить("КоличествоУпаковок");
		МассивНепроверяемыхРеквизитов.Добавить("Количество");
		МассивНепроверяемыхРеквизитов.Добавить("Наименование");
		Если ВариантРасчетаЦеныНабора = Перечисления.ВариантыРасчетаЦенНаборов.ЦенаЗадаетсяЗаНаборРаспределяетсяПоДолям Тогда
			ПроверяемыеРеквизиты.Добавить("Товары.ДоляСтоимости");
		КонецЕсли;
	Иначе
		ПараметрыПроверкиКоличества = ОбщегоНазначенияУТ.ПараметрыПроверкиЗаполненияКоличества();
		ПараметрыПроверкиКоличества.ИмяТЧ = "Объект";
		ПараметрыПроверкиКоличества.ПроверитьВозможностьОкругления = Ложь;
		ОбщегоНазначенияУТ.ПроверитьЗаполнениеКоличества(ЭтотОбъект, ПроверяемыеРеквизиты, Отказ, ПараметрыПроверкиКоличества);
	КонецЕсли;
	
	Если ТипНоменклатуры = Перечисления.ТипыНоменклатуры.Набор
		И ВариантПредставленияНабораВПечатныхФормах <> Перечисления.ВариантыПредставленияНаборовВПечатныхФормах.ТолькоКомплектующие Тогда
		
		Запрос = Новый Запрос(
		"ВЫБРАТЬ РАЗЛИЧНЫЕ ПЕРВЫЕ 2
		|	Номенклатура.СтавкаНДС
		|ИЗ
		|	Справочник.Номенклатура КАК Номенклатура
		|ГДЕ
		|	Номенклатура.Ссылка В(&МассивНоменклатуры)
		|");
		
		Запрос.УстановитьПараметр("МассивНоменклатуры", Товары.ВыгрузитьКолонку("Номенклатура"));
		
		Результат = Запрос.Выполнить();
		Выборка = Результат.Выбрать();
		Если Выборка.Количество() > 1 Тогда
			ОбщегоНазначенияКлиентСервер.СообщитьПользователю(
				НСтр("ru='В составе набора присутствуют позиции номенклатуры с разными ставками НДС.
|Для таких наборов в печатных формах можно выводить только комплектующие.'
|;uk='У складі набору присутні позиції номенклатури з різними ставками ПДВ.
|Для таких наборів в друкованих формах можна виводити тільки комплектуючі.'"),,
				"ВариантПредставленияНабораВПечатныхФормах",
				"Объект", Отказ);
		КонецЕсли;
		
	КонецЕсли;
	
	ОбщегоНазначения.УдалитьНепроверяемыеРеквизитыИзМассива(ПроверяемыеРеквизиты, МассивНепроверяемыхРеквизитов);
	
КонецПроцедуры

Процедура ОбработкаЗаполнения(ДанныеЗаполнения, СтандартнаяОбработка)

	Если ТипЗнч(ДанныеЗаполнения) = Тип("Структура")
		И ДанныеЗаполнения.Свойство("Владелец", Владелец) И ЗначениеЗаполнено(Владелец) Тогда

		ДанныеЗаполнения.Свойство("Характеристика", Характеристика);

		Основной = Не СуществуетОсновнойВариантКомплектации(Владелец, Характеристика);

	КонецЕсли;

КонецПроцедуры

Процедура ПриКопировании(ОбъектКопирования)

	ТипНоменклатуры = ОбщегоНазначения.ЗначениеРеквизитаОбъекта(Владелец, "ТипНоменклатуры");
	Если ТипНоменклатуры = Перечисления.ТипыНоменклатуры.Набор Тогда
		ВызватьИсключение НСтр("ru='Копирование состава набора не требуется';uk='Копіювання складу набору не потрібно'");
	КонецЕсли;
	
	Основной = Не СуществуетОсновнойВариантКомплектации(Владелец, Характеристика);

КонецПроцедуры

Процедура ПередЗаписью(Отказ)

	Если ОбменДанными.Загрузка Тогда
		Возврат;
	КонецЕсли;

	ОбновлениеИнформационнойБазы.ПроверитьОбъектОбработан(ЭтотОбъект);

	ТипНоменклатуры = ОбщегоНазначения.ЗначениеРеквизитаОбъекта(Владелец, "ТипНоменклатуры");
	Если ТипНоменклатуры = Перечисления.ТипыНоменклатуры.Набор Тогда
		
		ТаблицаНоменклатура = Товары.Выгрузить(,"Номенклатура");
		Запрос = Новый Запрос("
		|ВЫБРАТЬ
		|	Т.Номенклатура
		|ПОМЕСТИТЬ Таблица
		|ИЗ
		|	&Таблица КАК Т
		|;
		|
		|ВЫБРАТЬ РАЗЛИЧНЫЕ
		|	Т.Номенклатура.ТипНоменклатуры КАК ТипНоменклатуры
		|ИЗ
		|	Таблица КАК Т
		|");
		Запрос.УстановитьПараметр("Таблица", ТаблицаНоменклатура);
		ТипыНоменклатуры = Запрос.Выполнить().Выгрузить().ВыгрузитьКолонку("ТипНоменклатуры");
		
		СодержитТовары = ТипыНоменклатуры.Найти(Перечисления.ТипыНоменклатуры.Товар) <> Неопределено
		             ИЛИ ТипыНоменклатуры.Найти(Перечисления.ТипыНоменклатуры.МногооборотнаяТара) <> Неопределено;
		
		СодержитУслуги = ТипыНоменклатуры.Найти(Перечисления.ТипыНоменклатуры.Услуга) <> Неопределено
		             ИЛИ ТипыНоменклатуры.Найти(Перечисления.ТипыНоменклатуры.Работа) <> Неопределено;
		
		КоличествоУпаковок = 1;
		Количество         = 1;
		Наименование       = НСтр("ru='Состав набора';uk='Склад набору'") + " (" + Товары.Количество() + ")";
		Основной           = Истина;
		
	Иначе
	
		Если Основной И (Истина <> ОбщегоНазначения.ЗначениеРеквизитаОбъекта(Ссылка, "Основной")) Тогда

			УстановитьПривилегированныйРежим(Истина);

			Запрос = Новый Запрос(
			"ВЫБРАТЬ
			|	Таблица.Ссылка КАК Ссылка
			|ИЗ
			|	Справочник.ВариантыКомплектацииНоменклатуры КАК Таблица
			|ГДЕ
			|	Таблица.Владелец         = &Владелец
			|	И Таблица.Характеристика = &Характеристика
			|	И Таблица.Основной
			|	И Таблица.Ссылка <> &Ссылка
			|");
			Запрос.УстановитьПараметр("Владелец", Владелец);
			Запрос.УстановитьПараметр("Характеристика", Характеристика);
			Запрос.УстановитьПараметр("Ссылка", Ссылка);
			Выборка = Запрос.Выполнить().Выбрать();
			Пока Выборка.Следующий() Цикл

				Объект = Выборка.Ссылка.ПолучитьОбъект();
				Объект.Основной = Ложь;
				Объект.Записать();

			КонецЦикла;

		КонецЕсли;
	
	КонецЕсли;
	
	Если Не Справочники.Номенклатура.ХарактеристикиИспользуются(НоменклатураОсновногоКомпонента) Тогда
		ХарактеристикаОсновногоКомпонента = Неопределено;
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

#Область Прочее

Функция СуществуетОсновнойВариантКомплектации(Номенклатура, ХарактеристикаНоменклатуры = Неопределено)

	ТекстЗапроса = 
	"ВЫБРАТЬ ПЕРВЫЕ 1
	|	1
	|ИЗ
	|	Справочник.ВариантыКомплектацииНоменклатуры КАК Таблица
	|ГДЕ
	|	Таблица.Владелец = &Номенклатура
	|	И Таблица.Основной
	|";
	Если ЗначениеЗаполнено(ХарактеристикаНоменклатуры) Тогда
		ТекстЗапроса = ТекстЗапроса + " И Таблица.Характеристика = &Характеристика ";
	КонецЕсли;

	Запрос = Новый Запрос(ТекстЗапроса);
	Запрос.УстановитьПараметр("Номенклатура", Номенклатура);
	Запрос.УстановитьПараметр("Характеристика", ХарактеристикаНоменклатуры);
	Возврат Не Запрос.Выполнить().Пустой();

КонецФункции

#КонецОбласти

#КонецОбласти

#КонецЕсли
