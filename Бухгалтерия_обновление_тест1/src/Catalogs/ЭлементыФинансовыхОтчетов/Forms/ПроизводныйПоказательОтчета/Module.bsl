
#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)

	УстановитьУсловноеОформление();

	Если Параметры.Свойство("АвтоТест") Тогда // Возврат при получении формы для анализа.
		Возврат;
	КонецЕсли;
	
	ДанныеОбъекта = Справочники.ЭлементыФинансовыхОтчетов.ФормаПриСозданииНаСервере(ЭтотОбъект); // См. ФинансоваяОтчетностьКлиентСервер.СтруктураЭлементаОтчета
	ИдентификаторГлавногоХранилища = Параметры.ИдентификаторГлавногоХранилища;
	ВидПоказателей = Параметры.ВидПоказателей;
	
	Если Параметры.Свойство("НастройкаЯчеек") Тогда
		АдресЭлементовОтчета = Параметры.АдресЭлементовОтчета;
		АдресТаблицыЭлементов = Параметры.АдресТаблицыЭлементов;
	КонецЕсли;
	
	ОбновитьДеревоНовыхЭлементов();
	
	ДеревоОператоров = ФинансоваяОтчетностьВызовСервера.ПостроитьДеревоОператоров();
	ЗначениеВРеквизитФормы(ДеревоОператоров, "Операторы");
	
	Элементы.ГруппаДопРеквизиты.Видимость = Параметры.ПоказатьКодСтрокиПримечание;
	ОбновитьЗаголовокФормы();

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
	
	Возврат; // в BASУТ обработчик пустой
	
КонецПроцедуры

&НаСервере
Процедура ПослеЗаписиНаСервере(ТекущийОбъект, ПараметрыЗаписи)
	
	ОбновитьЗаголовокФормы();
	
КонецПроцедуры

&НаКлиенте
Процедура ПередЗакрытием(Отказ, СтандартнаяОбработка)
	
	Если ЗначениеЗаполнено(АдресЭлементаВХранилище) Тогда
		СтандартнаяОбработка = Ложь;
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ОбработкаВыбора(ВыбранноеЗначение, ИсточникВыбора)
	
	Если ЗначениеЗаполнено(ВыбранноеЗначение) Тогда
		ВидОтчета = ВыбранноеЗначение;
		ОбновитьДеревоСохраненныхЭлементов();
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовШапкиФормы

&НаКлиенте
Процедура НаименованиеДляПечатиПриИзменении(Элемент)
	
	Объект.Наименование = Объект.НаименованиеДляПечати;
	
КонецПроцедуры

&НаКлиенте
Процедура КоментарийНачалоВыбора(Элемент, ДанныеВыбора, СтандартнаяОбработка)
	
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
Процедура БыстрыйПоискСохранненыхПриИзменении(Элемент)

	ОбновитьДеревоСохраненныхЭлементов();

КонецПроцедуры

&НаКлиенте
Процедура ВидОтчетаПриИзменении(Элемент)
	
	ОбновитьДеревоСохраненныхЭлементов();
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовТаблицыФормыОператоры

&НаКлиенте
Процедура ОператорыВыбор(Элемент, ВыбраннаяСтрока, Поле, СтандартнаяОбработка)
	
	СтандартнаяОбработка = Ложь;
	ВставитьОператорВФормулу();
	
КонецПроцедуры

&НаКлиенте
Процедура ОператорыНачалоПеретаскивания(Элемент, ПараметрыПеретаскивания, Выполнение)
	
	Если ЗначениеЗаполнено(Элемент.ТекущиеДанные.Оператор) Тогда
		ПараметрыПеретаскивания.Значение = Элемент.ТекущиеДанные.Оператор;
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовТаблицыФормыДеревоновыхэлементов

&НаКлиенте
Процедура ДеревоНовыхЭлементовВыбор(Элемент, ВыбраннаяСтрока, Поле, СтандартнаяОбработка)
	
	ВыбранныеОперанды = Новый Массив;
	ВыбранныеОперанды.Добавить(Элемент.ТекущиеДанные);
	
КонецПроцедуры

&НаКлиенте
Процедура ДеревоНовыхЭлементовНачалоПеретаскивания(Элемент, ПараметрыПеретаскивания, Выполнение)
	
	Индекс = 0;
	Пока Индекс < ПараметрыПеретаскивания.Значение.Количество() Цикл
		
		Ид = ПараметрыПеретаскивания.Значение[Индекс];
		Операнд = ДеревоНовыхЭлементов.НайтиПоИдентификатору(Ид);
		Если Операнд.ЭтоГруппа Тогда
			ПараметрыПеретаскивания.Значение.Удалить(Индекс);
			Продолжить;
		КонецЕсли;
		Индекс = Индекс + 1;
		
	КонецЦикла;
	
	Если ПараметрыПеретаскивания.Значение.Количество() = 0 Тогда
		Выполнение = Ложь;
	КонецЕсли;

	
КонецПроцедуры

&НаКлиенте
Процедура ДеревоНовыхЭлементовОкончаниеПеретаскивания(Элемент, ПараметрыПеретаскивания, СтандартнаяОбработка)
	
	Возврат; // в BASУТ обработчик пустой
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовТаблицыФормыДеревосохраненныхэлементов

&НаКлиенте
Процедура ДеревоСохраненныхЭлементовВыбор(Элемент, ВыбраннаяСтрока, Поле, СтандартнаяОбработка)
	
	Возврат; // в BASУТ обработчик пустой
	
КонецПроцедуры

&НаКлиенте
Процедура ДеревоСохраненныхЭлементовОкончаниеПеретаскивания(Элемент, ПараметрыПеретаскивания, СтандартнаяОбработка)
	
	Возврат; // в BASУТ обработчик пустой
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовТаблицыФормыОперанды

&НаКлиенте
Процедура ОперандыВыбор(Элемент, ВыбраннаяСтрока, Поле, СтандартнаяОбработка)
	
	Если Поле.Имя <> "ПоказателиИдентификатор" Тогда
		РедактироватьПоказатель();
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ОперандыОкончаниеПеретаскивания(Элемент, ПараметрыПеретаскивания, СтандартнаяОбработка)
	
	ФинансоваяОтчетностьКлиент.ДобавитьТекстФормулы(ЭтотОбъект, ПараметрыПеретаскивания.Значение);
	
КонецПроцедуры

&НаКлиенте
Процедура ОперандыПеретаскивание(Элемент, ПараметрыПеретаскивания, СтандартнаяОбработка, Строка, Поле)
	
	// чтобы не срабатывало события окончания перетаскивания дерева новых элементов
	ПараметрыПеретаскивания.Значение.Очистить();
	
КонецПроцедуры

&НаКлиенте
Процедура ОперандыИдентификаторОкончаниеВводаТекста(Элемент, Текст, ДанныеВыбора, СтандартнаяОбработка)
	
	Текст = СокрЛП(Текст);
	НовыйИд = "[" + Текст + "]";
	СтарыйИд = "[" + Элементы.Операнды.ТекущиеДанные.Идентификатор + "]";
	Формула = СтрЗаменить(Формула, СтарыйИд, НовыйИд);
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура ЗавершитьРедактирование(Команда)
	
	ФинансоваяОтчетностьКлиент.ЗавершитьРедактированиеЭлементаОтчета(ЭтотОбъект);
	
КонецПроцедуры

&НаКлиенте
Процедура НайтиНовыйЭлемент(Команда)
	
	ОбновитьДеревоНовыхЭлементов();
	
КонецПроцедуры

&НаКлиенте
Процедура НайтиСохраненныйЭлемент(Команда)
	
	ОбновитьДеревоСохраненныхЭлементов();
	
КонецПроцедуры

&НаКлиенте
Процедура ПроверитьФормулу(Команда)
	
	ОчиститьСообщения();
	Отказ = Ложь;
	ПроверитьФормулуСервер(Отказ);
	Если НЕ Отказ Тогда
		ТекстПредупреждения = НСтр("ru='Синтаксических ошибок не обнаружено';uk='Синтаксичних помилок не виявлено'");
		ПоказатьПредупреждение(Неопределено, ТекстПредупреждения);
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

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаСервере
Процедура УстановитьУсловноеОформление()

	УсловноеОформление.Элементы.Очистить();

	//

	Элемент = УсловноеОформление.Элементы.Добавить();

	ПолеЭлемента = Элемент.Поля.Элементы.Добавить();
	ПолеЭлемента.Поле = Новый ПолеКомпоновкиДанных(Элементы.ОперандыТипИтога.Имя);

	ОтборЭлемента = Элемент.Отбор.Элементы.Добавить(Тип("ЭлементОтбораКомпоновкиДанных"));
	ОтборЭлемента.ЛевоеЗначение = Новый ПолеКомпоновкиДанных("Операнды.НачальноеСальдо");
	ОтборЭлемента.ВидСравнения = ВидСравненияКомпоновкиДанных.Равно;
	ОтборЭлемента.ПравоеЗначение = Истина;

	ОтборЭлемента = Элемент.Отбор.Элементы.Добавить(Тип("ЭлементОтбораКомпоновкиДанных"));
	ОтборЭлемента.ЛевоеЗначение = Новый ПолеКомпоновкиДанных("Операнды.ТипИтога");
	ОтборЭлемента.ВидСравнения = ВидСравненияКомпоновкиДанных.Равно;
	ОтборЭлемента.ПравоеЗначение = Перечисления.ТипыИтогов.Сальдо;

	ОтборЭлемента = Элемент.Отбор.Элементы.Добавить(Тип("ЭлементОтбораКомпоновкиДанных"));
	ОтборЭлемента.ЛевоеЗначение = Новый ПолеКомпоновкиДанных("Операнды.ВидЭлемента");
	ОтборЭлемента.ВидСравнения = ВидСравненияКомпоновкиДанных.Равно;
	ОтборЭлемента.ПравоеЗначение = Перечисления.ВидыЭлементовФинансовогоОтчета.МонетарныйПоказатель;

	Элемент.Оформление.УстановитьЗначениеПараметра("Текст", НСтр("ru='Начальное сальдо';uk='Початкове сальдо'"));

	//

	Элемент = УсловноеОформление.Элементы.Добавить();

	ПолеЭлемента = Элемент.Поля.Элементы.Добавить();
	ПолеЭлемента.Поле = Новый ПолеКомпоновкиДанных(Элементы.ОперандыТипИтога.Имя);

	ОтборЭлемента = Элемент.Отбор.Элементы.Добавить(Тип("ЭлементОтбораКомпоновкиДанных"));
	ОтборЭлемента.ЛевоеЗначение = Новый ПолеКомпоновкиДанных("Операнды.НачальноеСальдо");
	ОтборЭлемента.ВидСравнения = ВидСравненияКомпоновкиДанных.Равно;
	ОтборЭлемента.ПравоеЗначение = Истина;

	ОтборЭлемента = Элемент.Отбор.Элементы.Добавить(Тип("ЭлементОтбораКомпоновкиДанных"));
	ОтборЭлемента.ЛевоеЗначение = Новый ПолеКомпоновкиДанных("Операнды.ТипИтога");
	ОтборЭлемента.ВидСравнения = ВидСравненияКомпоновкиДанных.Равно;
	ОтборЭлемента.ПравоеЗначение = Перечисления.ТипыИтогов.СальдоДт;

	ОтборЭлемента = Элемент.Отбор.Элементы.Добавить(Тип("ЭлементОтбораКомпоновкиДанных"));
	ОтборЭлемента.ЛевоеЗначение = Новый ПолеКомпоновкиДанных("Операнды.ВидЭлемента");
	ОтборЭлемента.ВидСравнения = ВидСравненияКомпоновкиДанных.Равно;
	ОтборЭлемента.ПравоеЗначение = Перечисления.ВидыЭлементовФинансовогоОтчета.МонетарныйПоказатель;

	Элемент.Оформление.УстановитьЗначениеПараметра("Текст", НСтр("ru='Начальное сальдо Дт';uk='Початкове сальдо Дт'"));

	//

	Элемент = УсловноеОформление.Элементы.Добавить();

	ПолеЭлемента = Элемент.Поля.Элементы.Добавить();
	ПолеЭлемента.Поле = Новый ПолеКомпоновкиДанных(Элементы.ОперандыТипИтога.Имя);

	ОтборЭлемента = Элемент.Отбор.Элементы.Добавить(Тип("ЭлементОтбораКомпоновкиДанных"));
	ОтборЭлемента.ЛевоеЗначение = Новый ПолеКомпоновкиДанных("Операнды.НачальноеСальдо");
	ОтборЭлемента.ВидСравнения = ВидСравненияКомпоновкиДанных.Равно;
	ОтборЭлемента.ПравоеЗначение = Истина;

	ОтборЭлемента = Элемент.Отбор.Элементы.Добавить(Тип("ЭлементОтбораКомпоновкиДанных"));
	ОтборЭлемента.ЛевоеЗначение = Новый ПолеКомпоновкиДанных("Операнды.ТипИтога");
	ОтборЭлемента.ВидСравнения = ВидСравненияКомпоновкиДанных.Равно;
	ОтборЭлемента.ПравоеЗначение = Перечисления.ТипыИтогов.СальдоКт;

	ОтборЭлемента = Элемент.Отбор.Элементы.Добавить(Тип("ЭлементОтбораКомпоновкиДанных"));
	ОтборЭлемента.ЛевоеЗначение = Новый ПолеКомпоновкиДанных("Операнды.ВидЭлемента");
	ОтборЭлемента.ВидСравнения = ВидСравненияКомпоновкиДанных.Равно;
	ОтборЭлемента.ПравоеЗначение = Перечисления.ВидыЭлементовФинансовогоОтчета.МонетарныйПоказатель;

	Элемент.Оформление.УстановитьЗначениеПараметра("Текст", НСтр("ru='Начальное сальдо Кт';uk='Початкове сальдо Кт'"));

	//

	Элемент = УсловноеОформление.Элементы.Добавить();

	ПолеЭлемента = Элемент.Поля.Элементы.Добавить();
	ПолеЭлемента.Поле = Новый ПолеКомпоновкиДанных(Элементы.ОперандыТипИтога.Имя);

	ОтборЭлемента = Элемент.Отбор.Элементы.Добавить(Тип("ЭлементОтбораКомпоновкиДанных"));
	ОтборЭлемента.ЛевоеЗначение = Новый ПолеКомпоновкиДанных("Операнды.НачальноеСальдо");
	ОтборЭлемента.ВидСравнения = ВидСравненияКомпоновкиДанных.Равно;
	ОтборЭлемента.ПравоеЗначение = Ложь;

	ОтборЭлемента = Элемент.Отбор.Элементы.Добавить(Тип("ЭлементОтбораКомпоновкиДанных"));
	ОтборЭлемента.ЛевоеЗначение = Новый ПолеКомпоновкиДанных("Операнды.ТипИтога");
	ОтборЭлемента.ВидСравнения = ВидСравненияКомпоновкиДанных.Равно;
	ОтборЭлемента.ПравоеЗначение = Перечисления.ТипыИтогов.Сальдо;

	ОтборЭлемента = Элемент.Отбор.Элементы.Добавить(Тип("ЭлементОтбораКомпоновкиДанных"));
	ОтборЭлемента.ЛевоеЗначение = Новый ПолеКомпоновкиДанных("Операнды.ВидЭлемента");
	ОтборЭлемента.ВидСравнения = ВидСравненияКомпоновкиДанных.Равно;
	ОтборЭлемента.ПравоеЗначение = Перечисления.ВидыЭлементовФинансовогоОтчета.МонетарныйПоказатель;

	Элемент.Оформление.УстановитьЗначениеПараметра("Текст", НСтр("ru='Конечное сальдо';uk='Кінцеве сальдо'"));

	//

	Элемент = УсловноеОформление.Элементы.Добавить();

	ПолеЭлемента = Элемент.Поля.Элементы.Добавить();
	ПолеЭлемента.Поле = Новый ПолеКомпоновкиДанных(Элементы.ОперандыТипИтога.Имя);

	ОтборЭлемента = Элемент.Отбор.Элементы.Добавить(Тип("ЭлементОтбораКомпоновкиДанных"));
	ОтборЭлемента.ЛевоеЗначение = Новый ПолеКомпоновкиДанных("Операнды.НачальноеСальдо");
	ОтборЭлемента.ВидСравнения = ВидСравненияКомпоновкиДанных.Равно;
	ОтборЭлемента.ПравоеЗначение = Ложь;

	ОтборЭлемента = Элемент.Отбор.Элементы.Добавить(Тип("ЭлементОтбораКомпоновкиДанных"));
	ОтборЭлемента.ЛевоеЗначение = Новый ПолеКомпоновкиДанных("Операнды.ТипИтога");
	ОтборЭлемента.ВидСравнения = ВидСравненияКомпоновкиДанных.Равно;
	ОтборЭлемента.ПравоеЗначение = Перечисления.ТипыИтогов.СальдоДт;

	ОтборЭлемента = Элемент.Отбор.Элементы.Добавить(Тип("ЭлементОтбораКомпоновкиДанных"));
	ОтборЭлемента.ЛевоеЗначение = Новый ПолеКомпоновкиДанных("Операнды.ВидЭлемента");
	ОтборЭлемента.ВидСравнения = ВидСравненияКомпоновкиДанных.Равно;
	ОтборЭлемента.ПравоеЗначение = Перечисления.ВидыЭлементовФинансовогоОтчета.МонетарныйПоказатель;

	Элемент.Оформление.УстановитьЗначениеПараметра("Текст", НСтр("ru='Конечное сальдо Дт';uk='Кінцеве сальдо Дт'"));

	//

	Элемент = УсловноеОформление.Элементы.Добавить();

	ПолеЭлемента = Элемент.Поля.Элементы.Добавить();
	ПолеЭлемента.Поле = Новый ПолеКомпоновкиДанных(Элементы.ОперандыТипИтога.Имя);

	ОтборЭлемента = Элемент.Отбор.Элементы.Добавить(Тип("ЭлементОтбораКомпоновкиДанных"));
	ОтборЭлемента.ЛевоеЗначение = Новый ПолеКомпоновкиДанных("Операнды.НачальноеСальдо");
	ОтборЭлемента.ВидСравнения = ВидСравненияКомпоновкиДанных.Равно;
	ОтборЭлемента.ПравоеЗначение = Ложь;

	ОтборЭлемента = Элемент.Отбор.Элементы.Добавить(Тип("ЭлементОтбораКомпоновкиДанных"));
	ОтборЭлемента.ЛевоеЗначение = Новый ПолеКомпоновкиДанных("Операнды.ТипИтога");
	ОтборЭлемента.ВидСравнения = ВидСравненияКомпоновкиДанных.Равно;
	ОтборЭлемента.ПравоеЗначение = Перечисления.ТипыИтогов.СальдоКт;

	ОтборЭлемента = Элемент.Отбор.Элементы.Добавить(Тип("ЭлементОтбораКомпоновкиДанных"));
	ОтборЭлемента.ЛевоеЗначение = Новый ПолеКомпоновкиДанных("Операнды.ВидЭлемента");
	ОтборЭлемента.ВидСравнения = ВидСравненияКомпоновкиДанных.Равно;
	ОтборЭлемента.ПравоеЗначение = Перечисления.ВидыЭлементовФинансовогоОтчета.МонетарныйПоказатель;

	Элемент.Оформление.УстановитьЗначениеПараметра("Текст", НСтр("ru='Конечное сальдо Кт';uk='Кінцеве сальдо Кт'"));

	//

	Элемент = УсловноеОформление.Элементы.Добавить();

	ПолеЭлемента = Элемент.Поля.Элементы.Добавить();
	ПолеЭлемента.Поле = Новый ПолеКомпоновкиДанных(Элементы.ОперандыТипИтога.Имя);

	ОтборЭлемента = Элемент.Отбор.Элементы.Добавить(Тип("ЭлементОтбораКомпоновкиДанных"));
	ОтборЭлемента.ЛевоеЗначение = Новый ПолеКомпоновкиДанных("Операнды.ВидЭлемента");
	ОтборЭлемента.ВидСравнения = ВидСравненияКомпоновкиДанных.НеРавно;
	ОтборЭлемента.ПравоеЗначение = Перечисления.ВидыЭлементовФинансовогоОтчета.МонетарныйПоказатель;

	Элемент.Оформление.УстановитьЗначениеПараметра("Текст", ""); 

КонецПроцедуры

&НаСервере 
Процедура ОбновитьДеревоНовыхЭлементов()
	
	Возврат; // в BASУТ обработчик пустой
	
КонецПроцедуры

&НаСервере 
Процедура ОбновитьДеревоСохраненныхЭлементов()
	
	Если НЕ ЗначениеЗаполнено(БыстрыйПоискСохраненных)
		И НЕ ЗначениеЗаполнено(ФильтрПоВидуОтчета) Тогда
		СохраненныеЭлементы = ДеревоСохраненныхЭлементов.ПолучитьЭлементы();
		СохраненныеЭлементы.Очистить();
		Возврат;
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура РедактироватьПоказатель()
	
	ВыделенныеСтроки = ОбщегоНазначенияУТКлиент.ПроверитьПолучитьВыделенныеВСпискеСсылки(Элементы.Операнды);
	Если ВыделенныеСтроки.Количество() = 0 Тогда
		Возврат;
	КонецЕсли;
	
	ТекущиеДанные = Элементы.Операнды.ТекущиеДанные;

КонецПроцедуры

&НаКлиенте
Процедура ОбновитьСтрокуОперандаПослеИзменения(Результат, ДополнительныеПараметры) Экспорт
	
	Возврат; // в BASУТ обработчик пустой
	
КонецПроцедуры

&НаКлиенте
Процедура ВставитьОператорВФормулу()
	
	Если ЗначениеЗаполнено(Элементы.Операторы.ТекущиеДанные.Оператор) Тогда
		ТекстДляВставки = Элементы.Операторы.ТекущиеДанные.Оператор;
		Если Элементы.Операторы.ТекущиеДанные.Наименование = "( )" 
			И ЗначениеЗаполнено(Элементы.Формула.ВыделенныйТекст) Тогда
			ТекстДляВставки = "(" + Элементы.Формула.ВыделенныйТекст + ")";
		КонецЕсли;
		Элементы.Формула.ВыделенныйТекст = ТекстДляВставки;
	КонецЕсли;
	
КонецПроцедуры

&НаСервере
Процедура ПроверитьФормулуСервер(Отказ)
	
	Возврат; // в BASУТ обработчик пустой
	
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

#КонецОбласти
