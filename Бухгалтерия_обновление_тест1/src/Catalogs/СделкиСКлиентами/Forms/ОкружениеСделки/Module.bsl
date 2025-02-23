
#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	// Пропускаем инициализацию, чтобы гарантировать получение формы при передаче параметра "АвтоТест".
	Если Параметры.Свойство("АвтоТест") Тогда
		Возврат;
	КонецЕсли;
	
	ОбщегоНазначенияКлиентСервер.ДополнитьТаблицу(ПолучитьИзВременногоХранилища(Параметры.АдресУчастники), Участники);
	
	Партнер   = Параметры.Партнер;
	
	ЗаполнитьДеревоСвязей(Партнер, Участники);

	СобытияФорм.ПриСозданииНаСервере(ЭтаФорма, Отказ, СтандартнаяОбработка);

КонецПроцедуры 

#КонецОбласти

#Область ОбработчикиСобытийЭлементовТаблицыФормыДеревоСвязей

&НаКлиенте
Процедура ДеревоСвязейВыбор(Элемент, ВыбраннаяСтрока, Поле, СтандартнаяОбработка)

	СтандартнаяОбработка = Ложь;
	ОткрытьВыполнить();

КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура ОткрытьВыполнить()

	ПоказатьЗначение(Неопределено, Элементы.ДеревоСвязей.ТекущиеДанные.Ссылка);

КонецПроцедуры

&НаКлиенте
Процедура Обновить(Команда)
	
	Если ВладелецФормы.ИзменилисьПараметрыОкруженияСделки Тогда
		
		ВладелецФормы.ИзменилисьПараметрыОкруженияСделки = Ложь;
		Партнер = ВладелецФормы.Объект.Партнер;
		Участники.Очистить();
		ОбщегоНазначенияКлиентСервер.ДополнитьТаблицу(ВладелецФормы.Объект.ПартнерыИКонтактныеЛица, Участники);
		
	КонецЕсли;
	
	ЗаполнитьДеревоСвязей(Партнер,Участники);
	
КонецПроцедуры

&НаКлиенте
Процедура Подключаемый_ВыполнитьПереопределяемуюКоманду(Команда)
	
	СобытияФормКлиент.ВыполнитьПереопределяемуюКоманду(ЭтаФорма, Команда);
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаСервере
Процедура ЗаполнитьДеревоСвязей(Знач Клиент, Знач Участники)

	ДеревоОбъект = РеквизитФормыВЗначение("ДеревоСвязей");

	ДеревоОбъект.Строки.Очистить();
	мУчастники = Новый Массив;
	
	// сформировать ветвь клиента
	СоздатьУзелПартнера(
		ДеревоОбъект,
		Клиент,
		Новый Массив,
		Новый Массив,
		1,
		Справочники.РолиПартнеровВСделкахИПроектах.Клиент.Наименование);
	мУчастники.Добавить(Клиент);

	// сформировать ветви остальных участников
	Для Каждого Участник Из Участники Цикл
		Если мУчастники.Найти(Участник.Партнер) = Неопределено Тогда
			СоздатьУзелПартнера(
				ДеревоОбъект,
				Участник.Партнер,
				Новый Массив,
				Новый Массив,
				1,
				Строка(Участник.РольПартнера));
			мУчастники.Добавить(Участник);
		КонецЕсли;
	КонецЦикла;

	ЗначениеВРеквизитФормы(ДеревоОбъект, "ДеревоСвязей");

КонецПроцедуры

&НаСервере
Функция ПолучитьСтрокуУчастия(Участник)
	
	Если Участник = Неопределено Или Участник.Пустая() Тогда
		Возврат "";
	КонецЕсли;
	
	// рассчитать количество объектов участия
	Запрос = Новый Запрос(
		"ВЫБРАТЬ РАЗРЕШЕННЫЕ
		|	КОЛИЧЕСТВО(*) КАК ВоВзаимодействиях
		|ИЗ
		|	КритерийОтбора.ВзаимодействияКонтакта(&Контакт) КАК ВзаимодействияКонтакта");
	Запрос.УстановитьПараметр("Контакт", Участник);
	КоличествоВзаимодействий = Запрос.Выполнить().Выбрать();
	КоличествоВзаимодействий.Следующий();

	Если ТипЗнч(Участник) = Тип("СправочникСсылка.ФизическиеЛица") Тогда
		Результат = ?(
			КоличествоВзаимодействий.ВоВзаимодействиях > 0,
			" " - НСтр("ru='(взаимодействий : %КолВзаимодействий%)';uk='(взаємодій : %КолВзаимодействий%)'"),
			"");
		Результат = СтрЗаменить(
			Результат, "%КолВзаимодействий%", КоличествоВзаимодействий.ВоВзаимодействиях);
	Иначе
		Запрос = Новый Запрос(
			"ВЫБРАТЬ РАЗРЕШЕННЫЕ
			|	КОЛИЧЕСТВО(*) КАК ВСделках
			|ИЗ
			|	КритерийОтбора.УчастиеВСделках(&Участник) КАК УчастиеВСделках
			|ГДЕ
			|	(НЕ УчастиеВСделках.Ссылка.ПометкаУдаления)");
		Запрос.УстановитьПараметр("Участник", Участник);
		КоличествоСделок = Запрос.Выполнить().Выбрать();
		КоличествоСделок.Следующий();
		Если КоличествоСделок.ВСделках > 0 Тогда
			Результат = " " + ?(
				КоличествоВзаимодействий.ВоВзаимодействиях > 0,
				НСтр("ru='(сделок : %КолСделок%, взаимодействий - %КолВзаимодействий%)';uk='(угод: %КолСделок%, взаємодій - %КолВзаимодействий%)'"),
				НСтр("ru='(сделок : %КолСделок%)';uk='(угод : %КолСделок%)'"));
			Результат = СтрЗаменить(Результат, "%КолСделок%", КоличествоСделок.ВСделках);
		ИначеЕсли КоличествоВзаимодействий.ВоВзаимодействиях > 0 Тогда
			Результат = " " + НСтр("ru='(взаимодействий : %КолВзаимодействий%)';uk='(взаємодій : %КолВзаимодействий%)'")
		Иначе
			Результат = "";
		КонецЕсли;
		Результат = СтрЗаменить(
			Результат, "%КолВзаимодействий%", КоличествоВзаимодействий.ВоВзаимодействиях);
	КонецЕсли;

	Возврат Результат;

КонецФункции

&НаСервере
Функция СкопироватьМассив(МассивИсточник)

	Результат = Новый Массив;
	Для Каждого Элемент Из МассивИсточник Цикл
		Результат.Добавить(Элемент);
	КонецЦикла;
	Возврат Результат;

КонецФункции

&НаСервере
Процедура ЗаполнитьСвязиПоЗапросу(Узел, ТекстЗапроса, Партнеры, Контакты, УровеньИерархии, ОписаниеРоли = "", ДопПараметр = Неопределено)

	// создать запрос и заполнить его параметры
	Запрос = Новый Запрос(ТекстЗапроса);
	Запрос.УстановитьПараметр("Узел", Узел.Ссылка);
	Если ДопПараметр <> Неопределено Тогда
		Запрос.УстановитьПараметр("ДопПараметр", ДопПараметр);
	КонецЕсли;
	Запрос.УстановитьПараметр("ПустаяДата",Дата(1,1,1));
	Запрос.УстановитьПараметр("ТекущаяДата",ТекущаяДатаСеанса());
	Список = Запрос.Выполнить().Выбрать();

	// создать узлы связей
	Пока Список.Следующий() Цикл
		Если Список.ТипСсылки = Тип("СправочникСсылка.Партнеры") Тогда
			СоздатьУзелПартнера(
				Узел, Список.Ссылка, Партнеры, Контакты, УровеньИерархии + 1,
				?(ОписаниеРоли = "", Список.Роль, ОписаниеРоли));
		ИначеЕсли Список.ТипСсылки = Тип("СправочникСсылка.КонтактныеЛицаПартнеров") Тогда
			СоздатьУзелКонтактногоЛица(
				Узел, Список.Ссылка, Партнеры, Контакты, УровеньИерархии + 1,
				?(ОписаниеРоли = "", Список.Роль, ОписаниеРоли));
		КонецЕсли;
	КонецЦикла;

КонецПроцедуры

&НаСервере
Процедура СоздатьУзелПартнера(Родитель, Партнер, ПартнерыРодителя, мКонтакты, УровеньИерархии, Роль = Неопределено)

	// ограничить рекурсию и глубину анализа
	Если ПартнерыРодителя.Найти(Партнер) <> Неопределено
	 Или (ОграничениеГлубиныАнализа > 0 И УровеньИерархии > ОграничениеГлубиныАнализа) Тогда
		Возврат;
	КонецЕсли;
	
	// создать узел партнера
	Партнеры = СкопироватьМассив(ПартнерыРодителя);
	Партнеры.Добавить(Партнер);
	УзелПартнера = Родитель.Строки.Добавить();
	УзелПартнера.Ссылка = Партнер;
	УзелПартнера.Представление = ?(
		Не ЗначениеЗаполнено(Роль) , ?(Партнер.Пустая(),НСтр("ru='<Не указан>';uk='<Не зазначений>'"),Партнер.Наименование),"(" + Роль + ") " 
		+ ?(Партнер.Пустая(),НСтр("ru='<Не указан>';uk='<Не зазначений>'"),Партнер.Наименование)
	) + ПолучитьСтрокуУчастия(Партнер);

	// сформировать связи с контактными лицами по владельцу
	ЗаполнитьСвязиПоЗапросу(
		УзелПартнера,
		"ВЫБРАТЬ РАЗРЕШЕННЫЕ
		|	КонтактныеЛицаПартнеров.Ссылка КАК Ссылка,
		|	КонтактныеЛицаПартнеров.Представление КАК Представление,
		|	ТИПЗНАЧЕНИЯ(КонтактныеЛицаПартнеров.Ссылка) КАК ТипСсылки,
		|	НЕОПРЕДЕЛЕНО КАК Роль
		|ИЗ
		|	Справочник.КонтактныеЛицаПартнеров КАК КонтактныеЛицаПартнеров
		|ГДЕ
		|	КонтактныеЛицаПартнеров.Владелец = &Узел
		|	И (НЕ КонтактныеЛицаПартнеров.ПометкаУдаления)
		|	И (КонтактныеЛицаПартнеров.ДатаПрекращенияСвязи = &ПустаяДата
		|			ИЛИ КонтактныеЛицаПартнеров.ДатаПрекращенияСвязи > &ТекущаяДата)
		|
		|УПОРЯДОЧИТЬ ПО
		|	Представление",
		Партнеры,
		мКонтакты,
		УровеньИерархии);//сформировать связи с контактными лицами по владельцу

	// сформировать связи с партнерами через группу
	ГруппаПартнера = Партнер.Родитель;
	Если ЗначениеЗаполнено(ГруппаПартнера) Тогда
		СоздатьУзелГруппыПартнеров(УзелПартнера, ГруппаПартнера, Партнеры, мКонтакты, УровеньИерархии + 1);
	КонецЕсли;//сформировать связи с партнерами через группу

	// сформировать связи по первичному интересу
	ЗаполнитьСвязиПоЗапросу(
		УзелПартнера,
		"ВЫБРАТЬ РАЗРЕШЕННЫЕ ПЕРВЫЕ 1
		|	ИсточникиПервичногоИнтереса.ИсточникПервичногоИнтереса КАК Ссылка,
		|	ТИПЗНАЧЕНИЯ(ИсточникиПервичногоИнтереса.ИсточникПервичногоИнтереса) КАК ТипСсылки
		|ИЗ
		|	РегистрСведений.ИсточникиПервичногоИнтереса КАК ИсточникиПервичногоИнтереса
		|ГДЕ
		|	ИсточникиПервичногоИнтереса.Партнер = &Узел
		|
		|УПОРЯДОЧИТЬ ПО
		|	ИсточникиПервичногоИнтереса.Сделка.ДатаНачала",
		Партнеры,
		мКонтакты,
		УровеньИерархии,
		НСтр("ru='первичный интерес';uk='первинний інтерес'"));//сформировать связи по первичному интересу

	// сформировать связи с партнерами, определенные пользователем
	ЗаполнитьСвязиПоЗапросу(
		УзелПартнера,
		"ВЫБРАТЬ РАЗРЕШЕННЫЕ
		|	СвязиМеждуПартнерами12.ВторойПартнер КАК Ссылка,
		|	СвязиМеждуПартнерами12.ВторойПартнер.Наименование КАК Представление,
		|	СвязиМеждуПартнерами12.ВидСвязи.РольПартнера2 КАК Роль,
		|	ТИПЗНАЧЕНИЯ(СвязиМеждуПартнерами12.ВторойПартнер) КАК ТипСсылки
		|ИЗ
		|	РегистрСведений.СвязиМеждуПартнерами КАК СвязиМеждуПартнерами12
		|ГДЕ
		|	СвязиМеждуПартнерами12.ПервыйПартнер = &Узел
		|
		|ОБЪЕДИНИТЬ ВСЕ
		|
		|ВЫБРАТЬ
		|	СвязиМеждуПартнерами21.ПервыйПартнер,
		|	СвязиМеждуПартнерами21.ПервыйПартнер.Наименование,
		|	СвязиМеждуПартнерами21.ВидСвязи.РольПартнера1,
		|	ТИПЗНАЧЕНИЯ(СвязиМеждуПартнерами21.ПервыйПартнер)
		|ИЗ
		|	РегистрСведений.СвязиМеждуПартнерами КАК СвязиМеждуПартнерами21
		|ГДЕ
		|	СвязиМеждуПартнерами21.ВторойПартнер = &Узел",
		Партнеры,
		мКонтакты,
		УровеньИерархии);//сформировать связи с партнерами, определенные пользователем

КонецПроцедуры

&НаСервере
Процедура СоздатьУзелГруппыПартнеров(Родитель, ГруппаПартнера, ПартнерыРодителя, мКонтакты, УровеньИерархии)

	// ограничить рекурсию и глубину анализа
	Если ПартнерыРодителя.Найти(ГруппаПартнера) <> Неопределено
	 Или (ОграничениеГлубиныАнализа > 0 И УровеньИерархии > ОграничениеГлубиныАнализа) Тогда
		Возврат;
	КонецЕсли;

	// создать узел группы партнеров
	Партнеры = СкопироватьМассив(ПартнерыРодителя);
	Партнеры.Добавить(ГруппаПартнера);
	УзелГруппыПартнеров = Родитель.Строки.Добавить();
	УзелГруппыПартнеров.Ссылка = ГруппаПартнера;
	УзелГруппыПартнеров.Представление = "(" + НСтр("ru='в группе';uk='в групі'") + ") " + ГруппаПартнера.Наименование;

	// заполнить узел группы партнеров
	ЗаполнитьСвязиПоЗапросу(
		УзелГруппыПартнеров,
		"ВЫБРАТЬ РАЗРЕШЕННЫЕ
		|	Партнеры.Ссылка КАК Ссылка,
		|	Партнеры.Наименование КАК Представление,
		|	ТИПЗНАЧЕНИЯ(Партнеры.Ссылка) КАК ТипСсылки
		|ИЗ
		|	Справочник.Партнеры КАК Партнеры
		|ГДЕ
		|	Партнеры.Ссылка <> &Узел
		|	И Партнеры.Ссылка В ИЕРАРХИИ(&ДопПараметр)
		|	И (НЕ Партнеры.ПометкаУдаления)",
		Партнеры,
		мКонтакты,
		УровеньИерархии + 1,
		Неопределено,
		ГруппаПартнера);//заполнить узел группы партнеров

КонецПроцедуры

// Создает в дереве родительскую строку для данных контактного лица.
// 
// Параметры:
//  Родитель - СтрокаДереваЗначений - родительская строка.
//  КонтактноеЛицо - СправочникСсылка.КонтактныеЛицаПартнеров - контактное лицо
//  Партнеры - Массив - 
//  КонтактыРодителя - Массив - 
//  УровеньИерархии - Число - 
//  Роль - Неопределено, Строка - 
//
&НаСервере
Процедура СоздатьУзелКонтактногоЛица(Родитель, КонтактноеЛицо, Партнеры, КонтактыРодителя, УровеньИерархии, Роль = Неопределено)

	// ограничить рекурсию и глубину анализа
	Если КонтактыРодителя.Найти(КонтактноеЛицо) <> Неопределено
	 Или (ОграничениеГлубиныАнализа > 0 И УровеньИерархии > ОграничениеГлубиныАнализа) Тогда
		Возврат;
	КонецЕсли;

	// создать узел контактного лица
	мКонтакты = СкопироватьМассив(КонтактыРодителя);
	мКонтакты.Добавить(КонтактноеЛицо);
	УзелКонтактногоЛица = Родитель.Строки.Добавить();
	УзелКонтактногоЛица["Ссылка"] = КонтактноеЛицо;

	// сформировать строку ролей контактного лица
	Если Роль = Неопределено Тогда
			РолиКонтактногоЛица = "";
			Запрос = Новый Запрос(
				"ВЫБРАТЬ РАЗРЕШЕННЫЕ
				|	КонтактныеЛицаПартнеровРолиКонтактногоЛица.РольКонтактногоЛица.Наименование КАК Роль
				|ИЗ
				|	Справочник.КонтактныеЛицаПартнеров.РолиКонтактногоЛица КАК КонтактныеЛицаПартнеровРолиКонтактногоЛица
				|ГДЕ
				|	КонтактныеЛицаПартнеровРолиКонтактногоЛица.Ссылка = &КонтактноеЛицо");
			Запрос.УстановитьПараметр("КонтактноеЛицо", КонтактноеЛицо);
			СписокРолей = Запрос.Выполнить().Выбрать();
			Пока СписокРолей.Следующий() Цикл
				РолиКонтактногоЛица = РолиКонтактногоЛица + ?(
					РолиКонтактногоЛица = "", СписокРолей.Роль, ", " + СписокРолей.Роль);
			КонецЦикла;
		Иначе
			РолиКонтактногоЛица = Роль;
		КонецЕсли; //сформировать строку ролей контактного лица
	УзелКонтактногоЛица.Представление = ?(СокрЛП(РолиКонтактногоЛица) = "","","(" + РолиКонтактногоЛица + ") ") 
										+ КонтактноеЛицо.Наименование + ПолучитьСтрокуУчастия(КонтактноеЛицо);

	// сформировать связи через первичный интерес
	ЗаполнитьСвязиПоЗапросу(
		УзелКонтактногоЛица,
		"ВЫБРАТЬ РАЗРЕШЕННЫЕ РАЗЛИЧНЫЕ
		|	ИсточникиПервичногоИнтереса.Партнер КАК Ссылка,
		|	ИсточникиПервичногоИнтереса.Партнер.Наименование КАК Представление,
		|	ТИПЗНАЧЕНИЯ(ИсточникиПервичногоИнтереса.Партнер) КАК ТипСсылки
		|ИЗ
		|	РегистрСведений.ИсточникиПервичногоИнтереса КАК ИсточникиПервичногоИнтереса
		|ГДЕ
		|	ИсточникиПервичногоИнтереса.ИсточникПервичногоИнтереса.Ссылка = &Узел",
		Партнеры,
		мКонтакты,
		УровеньИерархии,
		НСтр("ru='первичный интерес';uk='первинний інтерес'"));//сформировать связи через первичный интерес

	// получить связь с владельцем
	Запрос = Новый Запрос(
		"ВЫБРАТЬ РАЗРЕШЕННЫЕ
		|	КонтактныеЛицаПартнеров.Владелец КАК Партнер
		|ИЗ
		|	Справочник.КонтактныеЛицаПартнеров КАК КонтактныеЛицаПартнеров
		|ГДЕ
		|	КонтактныеЛицаПартнеров.Ссылка = &КонтактноеЛицо
		|	И (НЕ КонтактныеЛицаПартнеров.ПометкаУдаления)");
	Запрос.УстановитьПараметр("КонтактноеЛицо", КонтактноеЛицо);
	СвязьСВладельцем = Запрос.Выполнить().Выбрать();
	СвязьСВладельцем.Следующий();//получить связь с владельцем

	// добавить строку партнера-владельца
	Если Партнеры.Найти(СвязьСВладельцем.Партнер) = Неопределено Тогда
		СоздатьУзелПартнера(
			УзелКонтактногоЛица,
			СвязьСВладельцем.Партнер,
			Партнеры,
			мКонтакты,
			УровеньИерархии,
			НСтр("ru='партнер';uk='партнер'"))
	КонецЕсли;//добавить строку партнера-владельца

КонецПроцедуры

#КонецОбласти
