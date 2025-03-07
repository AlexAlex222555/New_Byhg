&НаКлиенте
Перем ОткрытыеФормы Экспорт;

//////////////////////////////////////////////////////////////////////////////////
// Обработчики событий формы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	// СтандартныеПодсистемы.ВерсионированиеОбъектов
	ВерсионированиеОбъектов.ПриСозданииНаСервере(ЭтаФорма);
	// Конец СтандартныеПодсистемы.ВерсионированиеОбъектов
	
	// СтандартныеПодсистемы.КонтактнаяИнформация
	УправлениеКонтактнойИнформациейЗарплатаКадры.ПриСозданииНаСервере(ЭтаФорма, ФизическоеЛицо, "ГруппаКонтактнаяИнформация", ПоложениеЗаголовкаЭлементаФормы.Лево);
	// Конец СтандартныеПодсистемы.КонтактнаяИнформация

	// СтандартныеПодсистемы.Свойства
	ДополнительныеПараметры = Новый Структура;
	ДополнительныеПараметры.Вставить("Объект", ФизическоеЛицо);
	ДополнительныеПараметры.Вставить("ИмяЭлементаДляРазмещения", "ГруппаДополнительныеРеквизиты");
	УправлениеСвойствами.ПриСозданииНаСервере(ЭтотОбъект, ДополнительныеПараметры);
	// Конец СтандартныеПодсистемы.Свойства
	
	// СтандартныеПодсистемы.ПодключаемыеКоманды
	ПодключаемыеКоманды.ПриСозданииНаСервере(ЭтотОбъект);
	// Конец СтандартныеПодсистемы.ПодключаемыеКоманды
	
	// СтандартныеПодсистемы.СклонениеПредставленийОбъектов
	СклонениеПредставленийОбъектов.ПриСозданииНаСервере(ЭтотОбъект, ФизическоеЛицо.ФИО, "ФизическоеЛицо");
	// Конец СтандартныеПодсистемы.СклонениеПредставленийОбъектов
	
	// СтандартныеПодсистемы.УправлениеДоступом
	УправлениеДоступом.ПриСозданииФормыЗначенияДоступа(
		ЭтотОбъект, "ФизическоеЛицо.ГруппаДоступа", , Тип("СправочникСсылка.ФизическиеЛица"), Параметры.Ключ.Пустая());
	// Конец СтандартныеПодсистемы.УправлениеДоступом

	
	СотрудникиФормы.ФизическиеЛицаПриСозданииНаСервере(ЭтаФорма, Отказ, СтандартнаяОбработка);
	
	Если Параметры.Ключ.Пустая() Тогда
		УстановитьОтображениеКомандыНалогНаДоходы();
	КонецЕсли; 
	
КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)
	
	ПодключитьОбработчикОжидания("ПослеОткрытияФормы", 0.1, Истина);

	// СтандартныеПодсистемы.ПодключаемыеКоманды
	ПодключаемыеКомандыКлиент.НачатьОбновлениеКоманд(ЭтотОбъект);
	// Конец СтандартныеПодсистемы.ПодключаемыеКоманды
	
	// СтандартныеПодсистемы.Свойства
	УправлениеСвойствамиКлиент.ПослеЗагрузкиДополнительныхРеквизитов(ЭтотОбъект);
	// Конец СтандартныеПодсистемы.Свойства
	
КонецПроцедуры

&НаКлиенте
Процедура ПередЗакрытием(Отказ, ЗавершениеРаботы, ТекстПредупреждения, СтандартнаяОбработка)
	
	Оповещение = Новый ОписаниеОповещения("ЗаписатьИЗакрытьНаКлиенте", ЭтотОбъект);
	Если Модифицированность Тогда
		ОбщегоНазначенияКлиент.ПоказатьПодтверждениеЗакрытияФормы(Оповещение, Отказ, ЗавершениеРаботы);
	Иначе
		СотрудникиКлиент.ПроверитьНеобходимостьЗаписи(ЭтаФорма, Отказ);
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ПриЗакрытии()
	
	Если СозданиеНового И НЕ Параметры.Ключ.Пустая() Тогда
		
		Оповестить("СозданоФизическоеЛицо", ФизическоеЛицоСсылка, ВладелецФормы);
		
	КонецЕсли; 
	
КонецПроцедуры

&НаКлиенте
Процедура ОбработкаОповещения(ИмяСобытия, Параметр, Источник)
	
	// СтандартныеПодсистемы.Свойства
	Если УправлениеСвойствамиКлиент.ОбрабатыватьОповещения(ЭтотОбъект, ИмяСобытия, Параметр) Тогда
		ОбновитьЭлементыДополнительныхРеквизитов();
	КонецЕсли;
	// Конец СтандартныеПодсистемы.Свойства
	
	СотрудникиКлиент.ФизическиеЛицаОбработкаОповещения(ЭтаФорма, ИмяСобытия, Параметр, Источник);
	
КонецПроцедуры

&НаСервере
Процедура ПриЧтенииНаСервере(ТекущийОбъект)

	// СтандартныеПодсистемы.УправлениеДоступом
	УправлениеДоступом.ПриЧтенииНаСервере(ЭтотОбъект, ТекущийОбъект);
	// Конец СтандартныеПодсистемы.УправлениеДоступом

	// СтандартныеПодсистемы.КонтактнаяИнформация
	УправлениеКонтактнойИнформацией.ПриЧтенииНаСервере(ЭтаФорма, ТекущийОбъект);
	// Конец СтандартныеПодсистемы.КонтактнаяИнформация
	
	// СтандартныеПодсистемы.Свойства
	УправлениеСвойствами.ПриЧтенииНаСервере(ЭтотОбъект, ТекущийОбъект);
	// Конец СтандартныеПодсистемы.Свойства
	
	// СтандартныеПодсистемы.ПодключаемыеКоманды
	ПодключаемыеКомандыКлиентСервер.ОбновитьКоманды(ЭтотОбъект, ФизическоеЛицо);
	// Конец СтандартныеПодсистемы.ПодключаемыеКоманды
	
	СотрудникиФормы.ФизическиеЛицаПриЧтенииНаСервере(ЭтаФорма, ТекущийОбъект);
	УстановитьОтображениеКомандыНалогНаДоходы();
	
КонецПроцедуры

&НаКлиенте
Процедура ПередЗаписью(Отказ, ПараметрыЗаписи)
	
	Если Не ПараметрыЗаписи.Свойство("ПроверкаПередЗаписьюВыполнена") Тогда 
		ЗаписатьНаКлиенте(Ложь, , Отказ);
	КонецЕсли;
	
КонецПроцедуры

&НаСервере
Процедура ПередЗаписьюНаСервере(Отказ, ТекущийОбъект, ПараметрыЗаписи)
	
	// СтандартныеПодсистемы.КонтактнаяИнформация
	УправлениеКонтактнойИнформацией.ПередЗаписьюНаСервере(ЭтаФорма, ТекущийОбъект);
	// Конец СтандартныеПодсистемы.КонтактнаяИнформация
	
	// СтандартныеПодсистемы.Свойства
	УправлениеСвойствами.ПередЗаписьюНаСервере(ЭтотОбъект, ТекущийОбъект);
	// Конец СтандартныеПодсистемы.Свойства
	
	СотрудникиФормы.ФизическиеЛицаПередЗаписьюНаСервере(ЭтаФорма, Отказ, ТекущийОбъект, ПараметрыЗаписи);
	
КонецПроцедуры

&НаСервере
Процедура ПриЗаписиНаСервере(Отказ, ТекущийОбъект, ПараметрыЗаписи)
	
	СотрудникиФормы.ФизическиеЛицаПриЗаписиНаСервере(ЭтаФорма, Отказ, ТекущийОбъект, ПараметрыЗаписи);	
	
КонецПроцедуры

&НаСервере
Процедура ПослеЗаписиНаСервере(ТекущийОбъект, ПараметрыЗаписи)

	// СтандартныеПодсистемы.УправлениеДоступом
	УправлениеДоступом.ПослеЗаписиНаСервере(ЭтотОбъект, ТекущийОбъект, ПараметрыЗаписи);
	// Конец СтандартныеПодсистемы.УправлениеДоступом
	
	// СтандартныеПодсистемы.КонтактнаяИнформация
	УправлениеКонтактнойИнформацией.ПослеЗаписиНаСервере(ЭтаФорма, ТекущийОбъект);
	// Конец СтандартныеПодсистемы.КонтактнаяИнформация
	
	СотрудникиФормы.ФизическиеЛицаПослеЗаписиНаСервере(ЭтаФорма, ТекущийОбъект, ПараметрыЗаписи);
	
КонецПроцедуры

&НаКлиенте
Процедура ПослеЗаписи(ПараметрыЗаписи)
	
	СотрудникиКлиент.ФизическиеЛицаПослеЗаписи(ЭтаФорма, ПараметрыЗаписи);
	
КонецПроцедуры

&НаСервере
Процедура ОбработкаПроверкиЗаполненияНаСервере(Отказ, ПроверяемыеРеквизиты)
	
	// СтандартныеПодсистемы.КонтактнаяИнформация
	УправлениеКонтактнойИнформацией.ОбработкаПроверкиЗаполненияНаСервере(ЭтаФорма, ФизическоеЛицо, Отказ);
	// Конец СтандартныеПодсистемы.КонтактнаяИнформация
	
	// СтандартныеПодсистемы.Свойства
	УправлениеСвойствами.ОбработкаПроверкиЗаполнения(ЭтотОбъект, Отказ, ПроверяемыеРеквизиты, ФизическоеЛицо);
	// Конец СтандартныеПодсистемы.Свойства
	
	СотрудникиФормы.ФизическиеЛицаОбработкаПроверкиЗаполненияНаСервере(ЭтаФорма, Отказ, ПроверяемыеРеквизиты);
	
КонецПроцедуры

&НаКлиенте
Процедура ОбработкаВыбора(ВыбранноеЗначение, ИсточникВыбора)
	
	СотрудникиКлиентРасширенный.ФизическиеЛицаОбработкаВыбора(ЭтотОбъект, ВыбранноеЗначение, ИсточникВыбора); 
	
КонецПроцедуры

//////////////////////////////////////////////////////////////////////////////////
// Сервисные процедуры

&НаСервере
Процедура ПрочитатьНаборЗаписейПериодическихСведений(ИмяРегистра, ВедущийОбъект) Экспорт
	
	РедактированиеПериодическихСведений.ПрочитатьНаборЗаписей(ЭтаФорма, ИмяРегистра, ВедущийОбъект);
	
КонецПроцедуры

///////////////////////////////////////////////////////////////////// 
// ПРОЦЕДУРЫ ПОДСИСТЕМЫ "СВОЙСТВ"

// СтандартныеПодсистемы.Свойства

&НаСервере
Процедура ОбновитьЭлементыДополнительныхРеквизитов()
	
	УправлениеСвойствами.ОбновитьЭлементыДополнительныхРеквизитов(ЭтотОбъект, РеквизитФормыВЗначение("ФизическоеЛицо"));
	
КонецПроцедуры

&НаКлиенте
Процедура ОбновитьЗависимостиДополнительныхРеквизитов()
	
	УправлениеСвойствамиКлиент.ОбновитьЗависимостиДополнительныхРеквизитов(ЭтотОбъект, ФизическоеЛицо);
	
КонецПроцедуры

&НаКлиенте
Процедура Подключаемый_ПриИзмененииДополнительногоРеквизита(Элемент)
	
	УправлениеСвойствамиКлиент.ОбновитьЗависимостиДополнительныхРеквизитов(ЭтотОбъект, ФизическоеЛицо);
	
КонецПроцедуры

// Конец СтандартныеПодсистемы.Свойства

// СтандартныеПодсистемы.ПодключаемыеКоманды
&НаКлиенте
Процедура Подключаемый_ВыполнитьКоманду(Команда)
	ПодключаемыеКомандыКлиент.ВыполнитьКоманду(ЭтотОбъект, Команда, ФизическоеЛицо);
КонецПроцедуры

&НаСервере
Процедура Подключаемый_ВыполнитьКомандуНаСервере(Контекст, Результат) Экспорт
	ПодключаемыеКоманды.ВыполнитьКоманду(ЭтотОбъект, Контекст, ФизическоеЛицо, Результат);
КонецПроцедуры

&НаКлиенте
Процедура Подключаемый_ОбновитьКоманды()
	ПодключаемыеКомандыКлиентСервер.ОбновитьКоманды(ЭтотОбъект, ФизическоеЛицо);
КонецПроцедуры
// Конец СтандартныеПодсистемы.ПодключаемыеКоманды


////////////////////////////////////////////////////////////////////////////////
// ПРОЦЕДУРЫ ПОДСИСТЕМЫ "КОНТАКТНАЯ ИНФОРМАЦИЯ"

&НаКлиенте
Процедура Подключаемый_КонтактнаяИнформацияПриИзменении(Элемент)
	
	УправлениеКонтактнойИнформациейКлиент.ПредставлениеПриИзменении(ЭтаФорма, Элемент);

КонецПроцедуры

&НаКлиенте
Процедура Подключаемый_КонтактнаяИнформацияПриНажатии(Элемент, СтандартнаяОбработка)
	
	УправлениеКонтактнойИнформациейКлиент.НачалоВыбора(ЭтотОбъект, Элемент, , СтандартнаяОбработка);
	
КонецПроцедуры

&НаКлиенте
Процедура Подключаемый_КонтактнаяИнформацияНачалоВыбора(Элемент, ДанныеВыбора, СтандартнаяОбработка)
	
	Результат = УправлениеКонтактнойИнформациейКлиент.ПредставлениеНачалоВыбора(ЭтаФорма, Элемент, СтандартнаяОбработка);

КонецПроцедуры

&НаКлиенте
Процедура Подключаемый_КонтактнаяИнформацияОчистка(Элемент, СтандартнаяОбработка)
	
	Результат = УправлениеКонтактнойИнформациейКлиент.ПредставлениеОчистка(ЭтаФорма, Элемент.Имя);

КонецПроцедуры

&НаКлиенте
Процедура Подключаемый_КонтактнаяИнформацияВыполнитьКоманду(Команда)
	
	Результат = УправлениеКонтактнойИнформациейКлиент.ПодключаемаяКоманда(ЭтаФорма, Команда.Имя);
	УправлениеКонтактнойИнформациейКлиент.ОткрытьФормуВводаАдреса(ЭтаФорма, Результат);

КонецПроцедуры

&НаСервере
Процедура Подключаемый_ОбновитьКонтактнуюИнформацию(Результат) Экспорт
	
	УправлениеКонтактнойИнформациейЗарплатаКадры.ОбновитьКонтактнуюИнформацию(
		ЭтотОбъект, ФизическоеЛицо, Результат, СотрудникиКлиентСервер.ЗависимостиВидовАдресов());
	
КонецПроцедуры

//////////////////////////////////////////////////////////////////////////////////
// Редактирование данных ФизическогоЛица.

&НаКлиенте
Процедура ФизлицоКодПоДРФОПриИзменении(Элемент)	
	СотрудникиКлиент.ФизическиеЛицаКодПоДРФОПриИзменении(ЭтаФорма, Элемент);
КонецПроцедуры


&НаКлиенте
Процедура ФизическоеЛицоМестоРожденияНачалоВыбора(Элемент, ДанныеВыбора, СтандартнаяОбработка)
	
	СотрудникиКлиент.ФизическиеЛицаМестоРожденияНачалоВыбора(ЭтаФорма, Элемент, СтандартнаяОбработка, ФизическоеЛицо.МестоРождения);
	
КонецПроцедуры

&НаКлиенте
Процедура ФизлицоДатаРожденияПриИзменении(Элемент)
	СотрудникиКлиентСервер.УстановитьПодсказкуКДатеРождения(ЭтаФорма);
КонецПроцедуры

&НаКлиенте
Процедура Подключаемый_АдресФотографииНажатие(Элемент, СтандартнаяОбработка)
	
	СотрудникиКлиентРасширенный.ФизическиеЛицаАдресФотографииНажатие(ЭтотОбъект, Элемент, СтандартнаяОбработка);
	
КонецПроцедуры

&НаКлиенте
Процедура УНЗРПриИзменении(Элемент)
	
	Если Не ЗначениеЗаполнено(ФизическоеЛицо.ДатаРождения) Тогда
		Если СтрНайти(ФизическоеЛицо.УНЗР, "-") = 9 Тогда
			СтрокаДР = Лев(ФизическоеЛицо.УНЗР, 8);
			Если СтроковыеФункцииКлиентСервер.ТолькоЦифрыВСтроке(СтрокаДР, Ложь, Ложь) Тогда
				ОписаниеТипа = Новый ОписаниеТипов("Дата");
				ДР = ОписаниеТипа.ПривестиЗначение(СтрокаДР);
				ФизическоеЛицо.ДатаРождения = ДР  
			КонецЕсли
		КонецЕсли;
	КонецЕсли	
	
КонецПроцедуры

//////////////////////////////////////////////////////////////////////////////////
// Редактирование ФИО

&НаКлиенте
Процедура ИзменитьФИО(Команда)
	
	СотрудникиКлиент.ФизическоеЛицоИзменилФИОНажатие(ЭтаФорма);
	
КонецПроцедуры

&НаКлиенте
Процедура ФИОФизическихЛицИстория(Команда)
	СотрудникиКлиент.ОткрытьФормуРедактированияИстории("ФИОФизическихЛиц", ФизическоеЛицоСсылка, ЭтаФорма);
КонецПроцедуры

&НаКлиенте
Процедура ФИОПриИзменении(Элемент)
	
	СотрудникиКлиент.ПриИзмененииФИОФизическогоЛица(ЭтаФорма);
	
КонецПроцедуры

&НаКлиенте
Процедура УточнениеНаименованияПриИзменении(Элемент)
	 СотрудникиКлиент.СформироватьНаименованиеФизическогоЛица(ЭтаФорма);
КонецПроцедуры

//////////////////////////////////////////////////////////////////////////////////
// Редактирование гражданства

&НаКлиенте
Процедура ГражданствоФизическихЛицИстория(Команда)
	СотрудникиКлиент.ОткрытьФормуРедактированияИстории("ГражданствоФизическихЛиц", ФизическоеЛицоСсылка, ЭтаФорма);
КонецПроцедуры

&НаКлиенте
Процедура ГражданствоФизическихЛицЛицоБезГражданстваПриИзменении(Элемент)
	
	Если ГражданствоФизическихЛицЛицоБезГражданства = 0 Тогда
		
		Если НЕ ЗначениеЗаполнено(ГражданствоФизическихЛиц.Страна)
			И ЗначениеЗаполнено(ГражданствоФизическихЛицПрежняя.Страна) Тогда
		КонецЕсли;
		
		ГражданствоФизическихЛиц.Страна = ГражданствоФизическихЛицПрежняя.Страна;
		Если НЕ ЗначениеЗаполнено(ГражданствоФизическихЛиц.Страна) Тогда
			ГражданствоФизическихЛиц.Страна = ПредопределенноеЗначение("Справочник.СтраныМира.Украина");
		КонецЕсли; 
		
	Иначе
		
		ГражданствоФизическихЛиц.Страна = ПредопределенноеЗначение("Справочник.СтраныМира.ПустаяСсылка");
		
	КонецЕсли;
	
	СотрудникиКлиентСервер.ОбновитьДоступностьПолейВводаГражданства(ЭтаФорма, ОбщегоНазначенияКлиент.ДатаСеанса());
	
КонецПроцедуры

&НаКлиенте
Процедура ГражданствоФизическихЛицСтранаПриИзменении(Элемент)
	
	СотрудникиКлиентСервер.ОбновитьДоступностьПолейВводаГражданства(ЭтаФорма, ОбщегоНазначенияКлиент.ДатаСеанса());
	
КонецПроцедуры

&НаКлиенте
Процедура ГражданствоФизическихЛицПериодПриИзменении(Элемент)
	
	ГражданствоФизическихЛиц.Период = ГражданствоФизическихЛицПериод;
	
КонецПроцедуры

&НаКлиенте
Процедура ГражданствоФизическихЛицСтранаОбработкаВыбора(Элемент, ВыбранноеЗначение, СтандартнаяОбработка)
	УправлениеКонтактнойИнформациейКлиент.СтранаМираОбработкаВыбора(Элемент, ВыбранноеЗначение, СтандартнаяОбработка);
КонецПроцедуры


//////////////////////////////////////////////////////////////////////////////////
// Редактирование удостоверения личности.

&НаКлиенте
Процедура ДокументыФизическихЛицИстория(Команда)
	СотрудникиКлиент.ОткрытьФормуРедактированияИстории("ДокументыФизическихЛиц", ФизическоеЛицоСсылка, ЭтаФорма);
КонецПроцедуры

&НаКлиенте
Процедура ДокументыФизическихЛицВидДокументаПриИзменении(Элемент)
	СотрудникиКлиент.ДокументыФизическихЛицВидДокументаПриИзменении(ЭтаФорма);
КонецПроцедуры

&НаКлиенте
Процедура ДокументыФизическихЛицСерияПриИзменении(Элемент)
	СотрудникиКлиент.ДокументыФизическихЛицСерияПриИзменении(ЭтаФорма, Элемент);
КонецПроцедуры

&НаКлиенте
Процедура ДокументыФизическихЛицНомерПриИзменении(Элемент)
	СотрудникиКлиент.ДокументыФизическихЛицНомерПриИзменении(ЭтаФорма, Элемент);
КонецПроцедуры

&НаКлиенте
Процедура ДокументыФизическихЛицВидДокументаНачалоВыбора(Элемент, ДанныеВыбора, СтандартнаяОбработка)
	
	СотрудникиКлиент.ДокументыФизическихЛицВидДокументаНачалоВыбора(ЭтаФорма, Элемент, СтандартнаяОбработка);

КонецПроцедуры

&НаКлиенте
Процедура ДокументыФизическихЛицДатаВыдачиПриИзменении(Элемент)
	СотрудникиКлиентСервер.ОбновитьПолеУдостоверениеЛичностиПериод(ЭтаФорма);
КонецПроцедуры

&НаКлиенте
Процедура ДокументыФизическихЛицСрокДействияПриИзменении(Элемент)
	СотрудникиКлиентСервер.ОбновитьПолеУдостоверениеЛичностиПериод(ЭтаФорма);
КонецПроцедуры

&НаКлиенте
Процедура ДокументыФизическихЛицКемВыданПриИзменении(Элемент)
	СотрудникиКлиентСервер.ОбновитьПолеУдостоверениеЛичностиПериод(ЭтаФорма);
КонецПроцедуры


&НаКлиенте
Процедура ВсеДокументыЭтогоЧеловека(Команда)
	
	СотрудникиКлиент.ОткрытьСписокВсехДокументовФизическогоЛица(ЭтаФорма, ФизическоеЛицоСсылка);
	
КонецПроцедуры

//////////////////////////////////////////////////////////////////////////////////
// Работа с Сотрудником

&НаКлиенте
Процедура ДополнитьПредставлениеПриИзменении(Элемент)
	СотрудникиКлиент.ДополнитьПредставлениеФизическогоЛицаПриИзменении(ЭтаФорма);
КонецПроцедуры

#Область ОбработчикиКомандФормы


// СтандартныеПодсистемы.Свойства

&НаКлиенте
Процедура Подключаемый_СвойстваВыполнитьКоманду(ЭлементИлиКоманда, НавигационнаяСсылка = Неопределено, СтандартнаяОбработка = Неопределено)
	
	УправлениеСвойствамиКлиент.ВыполнитьКоманду(ЭтотОбъект, ЭлементИлиКоманда, СтандартнаяОбработка);
	
КонецПроцедуры

// Конец СтандартныеПодсистемы.Свойства

&НаКлиенте
Процедура СпециальныеСтатусы(Команда)
	
	СотрудникиКлиент.ОткрытьДополнительнуюФорму(
		СотрудникиКлиентСервер.ОписаниеДополнительнойФормы("Справочник.ФизическиеЛица.Форма.СпециальныеСтатусы"), ЭтаФорма);
	
КонецПроцедуры

&НаКлиенте
Процедура ВоинскийУчет(Команда)
	
	СотрудникиКлиент.ОткрытьДополнительнуюФорму(
		СотрудникиКлиентСервер.ОписаниеДополнительнойФормы("Справочник.ФизическиеЛица.Форма.ВоинскийУчет"), ЭтаФорма);
	
КонецПроцедуры

&НаКлиенте
Процедура ОбразованиеКвалификация(Команда)
	
	СотрудникиКлиент.ОткрытьДополнительнуюФорму(
		СотрудникиКлиентСервер.ОписаниеДополнительнойФормы("Справочник.ФизическиеЛица.Форма.ОбразованиеКвалификация"), ЭтаФорма);
	
КонецПроцедуры

&НаКлиенте
Процедура Семья(Команда)
	
	СотрудникиКлиент.ОткрытьДополнительнуюФорму(
		СотрудникиКлиентСервер.ОписаниеДополнительнойФормы("Справочник.ФизическиеЛица.Форма.Семья"), ЭтаФорма);
	
КонецПроцедуры

&НаКлиенте
Процедура ТрудоваяДеятельность(Команда)
	
	СотрудникиКлиент.ОткрытьДополнительнуюФорму(
		СотрудникиКлиентСервер.ОписаниеДополнительнойФормы("Справочник.ФизическиеЛица.Форма.ТрудоваяДеятельность"), ЭтаФорма);
	
КонецПроцедуры
	
&НаКлиенте
Процедура НалогНаДоходы(Команда)
	
	СотрудникиКлиент.ОткрытьДополнительнуюФорму(
		СотрудникиКлиентСервер.ОписаниеДополнительнойФормы("Справочник.Сотрудники.Форма.НалогНаДоходы"), ЭтаФорма);
	
КонецПроцедуры

&НаКлиенте
Процедура КомандаЗаписатьИЗакрыть(Команда)
	
	ЗаписатьНаКлиенте(Истина);
	
КонецПроцедуры

&НаКлиенте
Процедура КомандаЗаписать(Команда)
	
	ЗаписатьНаКлиенте(Ложь);
	
КонецПроцедуры

&НаКлиенте
Процедура Работа(Команда)
	
	ДополнительныеПараметры = Новый Структура("ЗаписатьЭлемент", Истина);
	
	Если СозданиеНового И Параметры.Ключ.Пустая() Тогда
		
		ТекстВопроса = НСтр("ru='Данные еще не записаны.
                |Переход к сведениям о рабочих местах возможен только после записи данных.
                |Записать данные?'
                |;uk='Дані ще не записані.
                |Перехід до відомостей про робочі місця можливий тільки після запису даних.
                |Записати дані?'");
				
		Оповещение = Новый ОписаниеОповещения("КомандаРаботаЗавершение", ЭтотОбъект, ДополнительныеПараметры);
		ПоказатьВопрос(Оповещение, ТекстВопроса, РежимДиалогаВопрос.ДаНетОтмена);	
		
	Иначе 
		
		ДополнительныеПараметры.ЗаписатьЭлемент = Ложь;
		КомандаРаботаЗавершение(Неопределено, ДополнительныеПараметры);
		
	КонецЕсли;
	
КонецПроцедуры
	
&НаКлиенте
Процедура КомандаРаботаЗавершение(Знач Ответ, Знач ДополнительныеПараметры) Экспорт
	
	Если ЗначениеЗаполнено(Ответ) И Ответ <> КодВозвратаДиалога.Да Тогда
		Возврат;
	КонецЕсли;
	
	Если ДополнительныеПараметры.ЗаписатьЭлемент И Не Записать() Тогда
		Возврат;
	КонецЕсли;
	
	СотрудникиКлиент.ОткрытьДополнительнуюФорму(
		СотрудникиКлиентСервер.ОписаниеДополнительнойФормы("Справочник.ФизическиеЛица.Форма.Работа"), ЭтаФорма);
	
КонецПроцедуры

&НаКлиенте
Процедура Подключаемый_РедактированиеСведенийОГосударственномСлужащемВыполнитьКоманду(Команда)
	
	СотрудникиКлиент.ОткрытьДополнительнуюФорму(
		СотрудникиКлиентСервер.ОписаниеДополнительнойФормы("ОбщаяФорма.РедактированиеСведенийОГосударственномСлужащем"), ЭтаФорма);

КонецПроцедуры

&НаКлиенте
Процедура Подключаемый_КадровыйРезерв(Команда)
	Если ОбщегоНазначенияКлиент.ПодсистемаСуществует("ЗарплатаКадрыПриложения.КадровыйРезерв") Тогда
		МодульКлиент = ОбщегоНазначенияКлиент.ОбщийМодуль("КадровыйРезервКлиент");
		МодульКлиент.ОткрытьФормуКадровыйРезерв(ЭтаФорма, ФизическоеЛицоСсылка);
	КонецЕсли;
КонецПроцедуры

&НаКлиенте
Процедура Склонения(Команда)
	
	СклонениеПредставленийОбъектовКлиент.ОбработатьКомандуСклонения(ЭтотОбъект, ФизическоеЛицо.ФИО, Истина, 
		?(ЗначениеЗаполнено(ФизическоеЛицо.Пол), ?(ФизическоеЛицо.Пол = ПредопределенноеЗначение("Перечисление.ПолФизическогоЛица.Мужской"), 1, 2), Неопределено));
	    			
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции


&НаКлиенте
Процедура ПослеОткрытияФормы()
	
	СотрудникиКлиент.ФизическиеЛицаПриОткрытии(ЭтаФорма);
	
КонецПроцедуры

////////////////////////////////////////////////////////////////////////////////
// Работа с дополнительными формами.

&НаСервере
Функция АдресДанныхДополнительнойФормыНаСервере(ОписаниеДополнительнойФормы) Экспорт
	Возврат СотрудникиФормы.АдресДанныхДополнительнойФормы(ОписаниеДополнительнойФормы, ЭтаФорма);
КонецФункции

&НаСервере
Процедура ПрочитатьДанныеИзХранилищаВФормуНаСервере(Параметр) Экспорт
	
	СотрудникиФормы.ПрочитатьДанныеИзХранилищаВФорму(
		ЭтаФорма,
		СотрудникиКлиентСервер.ОписаниеДополнительнойФормы(Параметр.ИмяФормы),
		Параметр.АдресВХранилище);
	
КонецПроцедуры

&НаСервере
Процедура СохранитьДанныеДополнительнойФормы(ИмяФормы, Отказ) Экспорт
	
	СотрудникиФормы.СохранитьДанныеДополнительнойФормы(ЭтаФорма, ИмяФормы, Отказ);
	
КонецПроцедуры

&НаСервере
Процедура УстановитьОтображениеКомандыНалогНаДоходы()
	
	ПараметрыФункциональныхОпций = ПолучитьПараметрыФункциональныхОпцийФормы();
	ОбщегоНазначенияКлиентСервер.УстановитьСвойствоЭлементаФормы(
		Элементы,
		"НалогНаДоходы",
		"Видимость",
		ПараметрыФункциональныхОпций.РежимРаботыФормы = Перечисления.РежимыРаботыФормыСотрудника.ФизическоеЛицо);
	
КонецПроцедуры

// СтандартныеПодсистемы.СклонениеПредставленийОбъектов

&НаКлиенте 
Процедура Подключаемый_ПросклонятьПредставлениеПоВсемПадежам() 
	
	СклонениеПредставленийОбъектовКлиент.ПросклонятьПредставлениеПоВсемПадежам(ЭтотОбъект, ФизическоеЛицо.ФИО, Истина, 
		?(ЗначениеЗаполнено(ФизическоеЛицо.Пол), ?(ФизическоеЛицо.Пол = ПредопределенноеЗначение("Перечисление.ПолФизическогоЛица.Мужской"), 1, 2), Неопределено));
		
КонецПроцедуры

// Конец СтандартныеПодсистемы.СклонениеПредставленийОбъектов

#КонецОбласти
	
#Область ЗаписьЭлемента

&НаКлиенте
Процедура ЗаписатьИЗакрытьНаКлиенте(Результат, ДополнительныеПараметры) Экспорт 
	
	ЗаписатьНаКлиенте(Истина);
	
КонецПроцедуры

&НаКлиенте
Процедура ЗаписатьНаКлиенте(ЗакрытьПослеЗаписи, ОповещениеЗавершения = Неопределено, Отказ = Ложь) Экспорт 

	СотрудникиКлиент.СохранитьДанныеФорм(ЭтаФорма, Отказ, ЗакрытьПослеЗаписи);
	Если НЕ ПроверяютсяОднофамильцы Тогда
		
		ОчиститьСообщения();
		
		ПараметрыЗаписи = Новый Структура;
		СотрудникиКлиент.ФизическиеЛицаПередЗаписью(ЭтаФорма, Отказ, ПараметрыЗаписи, ОповещениеЗавершения, ЗакрытьПослеЗаписи);
	
	КонецЕсли; 
	
КонецПроцедуры

#КонецОбласти

	
