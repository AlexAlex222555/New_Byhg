
#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)

	Если Параметры.Свойство("АвтоТест") Тогда // Возврат при получении формы для анализа.
		Возврат;
	КонецЕсли;
	
	Заголовок = НСтр("ru='Ссылка на элемент отчета';uk='Посилання на елемент звіту'");
	
	ДанныеОбъекта = Справочники.ЭлементыФинансовыхОтчетов.ФормаПриСозданииНаСервере(ЭтаФорма);
	СвязанныйВидОтчета = Объект.СвязанныйЭлемент.Владелец;
	НаименованиеСвязанногоЭлемента = Объект.СвязанныйЭлемент.НаименованиеДляПечати;
	Наименование = ДанныеОбъекта.НаименованиеДляПечати;
	Если ПустаяСтрока(НаименованиеСвязанногоЭлемента) И НЕ ПустаяСтрока(Наименование) Тогда
		НаименованиеСвязанногоЭлемента = ДанныеОбъекта.НаименованиеДляПечати;
	КонецЕсли;
	ВидыЭлементов = Перечисления.ВидыЭлементовФинансовогоОтчета;
	ЭтоПоказатель = ДанныеОбъекта.ВидЭлемента = ВидыЭлементов.МонетарныйПоказатель
					ИЛИ ДанныеОбъекта.ВидЭлемента = ВидыЭлементов.НемонетарныйПоказатель
					ИЛИ ДанныеОбъекта.ВидЭлемента = ВидыЭлементов.ПроизводныйПоказатель
					ИЛИ (ДанныеОбъекта.ВидЭлемента = ВидыЭлементов.ИтогПоГруппе И ДанныеОбъекта.ЭтоСвязанный);

	Элементы.ОбратныйЗнак.Видимость = ЭтоПоказатель;
	Элементы.ВыделитьЭлемент.Видимость = ЭтоПоказатель;
	СобытияФорм.ПриСозданииНаСервере(ЭтаФорма, Отказ, СтандартнаяОбработка);

КонецПроцедуры

&НаСервере
Процедура ПередЗаписьюНаСервере(Отказ, ТекущийОбъект, ПараметрыЗаписи)

	ДопРежим = Перечисления.ДополнительныеРежимыЭлементовОтчетов.СвязанныйЭлемент;
	Справочники.ЭлементыФинансовыхОтчетов.ФормаПередЗаписьюНаСервере(ЭтаФорма, ТекущийОбъект, Отказ, ДопРежим);

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
Процедура НаименованиеДляПечатиПриИзменении(Элемент)

	Объект.Наименование = Объект.НаименованиеДляПечати;

КонецПроцедуры

&НаКлиенте
Процедура КомментарийНачалоВыбора(Элемент, ДанныеВыбора, СтандартнаяОбработка)

	ОбщегоНазначенияКлиент.ПоказатьФормуРедактированияКомментария(
		Элемент.ТекстРедактирования, 
		ЭтотОбъект, 
		"Объект.Комментарий");

КонецПроцедуры

&НаКлиенте
Процедура СвязанныйЭлементНажатие(Элемент, СтандартнаяОбработка)

	СтандартнаяОбработка = Ложь;
	Закрыть();

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

#КонецОбласти
