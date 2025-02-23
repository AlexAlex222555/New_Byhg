 
#Область ПрограммныйИнтерфейс

// Обновляет кеш ключевых реквизитов текущей строки товаров.
//
// Параметры:
//  ТаблицаФормы			 - ТаблицаФормы - таблица формы, отображающая ТЧ товаров,
//  КэшированныеЗначения	 - Структура - переменная модуля формы, в которой хранится служебный кэш,
//  ПараметрыУказанияСерий	 - см. НоменклатураКлиентСервер.ПараметрыУказанияСерий
//  Копирование				 - Булево - признак, что кешированная строка скопирована (параметр события ПриНачалеРедактирования).
//
Процедура ОбновитьКешированныеЗначенияДляТЧСУпаковочнымиЛистами(ТаблицаФормы, КэшированныеЗначения,
	ПараметрыУказанияСерий = Неопределено,Копирование = Ложь) Экспорт
	
	Если КэшированныеЗначения = Неопределено Тогда
		КэшированныеЗначения = ОбработкаТабличнойЧастиКлиентСервер.ПолучитьСтруктуруКэшируемыеЗначения();
	КонецЕсли;
	КэшированныеЗначения.Вставить("ДобавлениеСтрок", Ложь);
	КэшированныеЗначения.Вставить("РедактированиеСтрок", Ложь);
	КэшированныеЗначения.Вставить("УпаковочныйЛист", ПредопределенноеЗначение("Документ.УпаковочныйЛист.ПустаяСсылка"));
	КэшированныеЗначения.Вставить("Номенклатура", ПредопределенноеЗначение("Справочник.Номенклатура.ПустаяСсылка"));
	КэшированныеЗначения.Вставить("ЭтоУпаковочныйЛист", Ложь);
	КэшированныеЗначения.Вставить("УдалениеСтрок", Ложь);
	
	ТекущиеДанные = ТаблицаФормы.ТекущиеДанные;
	
	Если ТекущиеДанные <> Неопределено Тогда
		ЗаполнитьЗначенияСвойств(КэшированныеЗначения, ТекущиеДанные);
	КонецЕсли;
	
	Если ПараметрыУказанияСерий <> Неопределено Тогда
		НоменклатураКлиент.ОбновитьКешированныеЗначенияДляУчетаСерий(
			ТаблицаФормы,КэшированныеЗначения,ПараметрыУказанияСерий, Копирование);
	КонецЕсли;
	
КонецПроцедуры

// Действия при начале редактирования табличной части с упаковочными листами.
// Параметры:
//		Форма - ФормаКлиентскогоПриложения - форма для выполнения действий,
//		КэшированныеЗначения - Структура - данные в этой структуре обновляются по текущей строке,
//		НоваяСтрока - Булево - признак добавления новой строки.
//
Процедура ПриНачалеРедактированияТЧСУпаковочнымиЛистами(Форма, КэшированныеЗначения, НоваяСтрока) Экспорт
	
	ИмяТЧТовары = ПараметрыУказанияСерий(Форма).ИмяТЧТовары;
	
	ТекущиеДанные = Форма.Элементы[ИмяТЧТовары].ТекущиеДанные;
	
	Если НоваяСтрока Тогда
		Форма.МаксимальныйНомерСтроки = Форма.МаксимальныйНомерСтроки + 1;
		ТекущиеДанные.НомерСтрокиОтображаемый = Форма.МаксимальныйНомерСтроки;
		Если ЗначениеЗаполнено(Форма.УпаковочныйЛистРодитель) Тогда
			ТекущиеДанные.УпаковочныйЛистРодитель = Форма.УпаковочныйЛистРодитель;
		КонецЕсли;
	КонецЕсли;
	ОбновитьКешированныеЗначенияДляТЧСУпаковочнымиЛистами(Форма.Элементы[ИмяТЧТовары], КэшированныеЗначения);
	КэшированныеЗначения.РедактированиеСтрок = Истина;
	
КонецПроцедуры

// Действия при окончании редактирования табличной части с упаковочными листами.
// Параметры:
//		Форма - ФормаКлиентскогоПриложения - форма для выполнения действий,
//		НоваяСтрока - Булево - признак добавления новой строки,
//		ОтменаРедактирования - Булево - признак отмены редактирования.
//
Процедура ПриОкончанииРедактированияТЧСУпаковочнымиЛистами(Форма, НоваяСтрока, ОтменаРедактирования) Экспорт
	
	Если НоваяСтрока
		И ОтменаРедактирования Тогда
		Форма.МаксимальныйНомерСтроки = Форма.МаксимальныйНомерСтроки - 1;
	КонецЕсли;
	
КонецПроцедуры

// Действия перед началом добавления строки в табличную часть с упаковочными листами.
//	Параметры:
//		ТаблицаФормы - ДанныеФормыКоллекция - таблица, в которой могут быть строки-упаковочные листы,
//		Отказ - Булево - признак ошибки добавления,
//		Копирование - Булево - признак копирования строки,
//		КэшированныеЗначения - Структура - служебные данные.
//
Процедура ПередНачаломДобавленияВТЧСУпаковочнымиЛистами(ТаблицаФормы, Отказ, Копирование, КэшированныеЗначения) Экспорт
	
	ОбновитьКешированныеЗначенияДляТЧСУпаковочнымиЛистами(ТаблицаФормы, КэшированныеЗначения);
	ТекущиеДанные = ТаблицаФормы.ТекущиеДанные;
	Если Копирование
		И ТекущиеДанные <> Неопределено
		И ТекущиеДанные.ЭтоУпаковочныйЛист Тогда
		Отказ = Истина;
		ПоказатьПредупреждение(,НСтр("ru='Копирование строк с упаковочными листами не предусмотрено';uk='Копіювання рядків з пакувальними листами не передбачено'"));
	КонецЕсли;
	
	КэшированныеЗначения.ДобавлениеСтрок = Истина;
	
КонецПроцедуры

// Преобразует текущую строку-упаковочный лист в строки, содержащиеся внутри упаковочного листа,
//	исходная строка-упаковочный лист удаляется.
//	Параметры:
//		Форма - ФормаКлиентскогоПриложения - форма, в которой есть таблица с упаковочными листами.
//
Процедура РаспаковатьУпаковочныйЛист(Форма) Экспорт
	ИмяТЧТовары = ПараметрыУказанияСерий(Форма).ИмяТЧТовары;
	
	ТекущиеДанные = Форма.Элементы[ИмяТЧТовары].ТекущиеДанные;
	Если ТекущиеДанные = Неопределено Тогда
		ТекстПредупреждения = НСтр("ru='Выберите строку для распаковки.';uk='Виберіть рядок для розпакування.'");
		ПоказатьПредупреждение(,ТекстПредупреждения);
		Возврат;
	ИначеЕсли Не ЗначениеЗаполнено(ТекущиеДанные.УпаковочныйЛистРодитель)
		И Не ЗначениеЗаполнено(ТекущиеДанные.УпаковочныйЛист) Тогда
		ТекстПредупреждения = НСтр("ru='Выбранная строка не включена в упаковочный лист, распаковка невозможна.';uk='Обраний рядок не включений в пакувальний лист, розпакування неможливе.'");
		ПоказатьПредупреждение(,ТекстПредупреждения);
		Возврат;
	КонецЕсли;
	
	ТекстВопроса = НСтр("ru='Распаковать?';uk='Розпакувати?'");
	Оповещение = Новый ОписаниеОповещения("ПослеЗакрытияВопросаОРаспаковке", Форма);
	
	ПоказатьВопрос(Оповещение, ТекстВопроса, РежимДиалогаВопрос.ДаНет);
	
КонецПроцедуры

// Поверяет, возможен ли переход в упаковочный из текущей строки.
//	Параметры:
//		ТаблицаФормы - ДанныеФормыКоллекция - таблица, в которой могут быть строки-упаковочные листы,
//		ИмяПоля - Строка - имя текущего поля,
//		ИмяТЧ - Строка - имя табличной части с упаковочными листами
//	Возвращаемое значение:
//		Булево - Истина, если переход в упаковочный лист возможен.
//	
Функция ПроверитьПодготовитьПереходВУпаковочныйЛистПриВыборе(ТаблицаФормы, ИмяПоля, ИмяТЧ = "Товары") Экспорт
	
	ТекущиеДанные = ТаблицаФормы.ТекущиеДанные;
	Если ТекущиеДанные = Неопределено Тогда
		Возврат Ложь;
	КонецЕсли;
	
	Если (ИмяПоля = ИмяТЧ + "Картинка"
		Или ИмяПоля = ИмяТЧ + "НомерСтрокиОтображаемый")
	  И ТекущиеДанные.ЭтоУпаковочныйЛист
	  И ЗначениеЗаполнено(ТекущиеДанные.УпаковочныйЛист) Тогда
		Возврат Истина;
	Иначе
		Возврат Ложь;
	КонецЕсли;
	
КонецФункции

// Действия перед удалением строк в табличной части с упаковочными листами.
//
// Параметры:
//  ТаблицаФормы			 - ДанныеФормыКоллекция - таблица, в которой могут быть строки-упаковочные листы,
//  КэшированныеЗначения	 - Структура - кэш служебных данных,
//  ПараметрыУказанияСерий	 - см. НоменклатураКлиентСервер.ПараметрыУказанияСерий
//
Процедура ПередУдалениемСтрокТЧСУпаковочнымиЛистами(ТаблицаФормы, КэшированныеЗначения, ПараметрыУказанияСерий) Экспорт
	
	ОбновитьКешированныеЗначенияДляТЧСУпаковочнымиЛистами(ТаблицаФормы, КэшированныеЗначения, ПараметрыУказанияСерий);
	КэшированныеЗначения.УдалениеСтрок = Истина;
	
КонецПроцедуры

// Действия при начале выбора значения в поле, где может быть либо номенклатура, либо упаковочный лист.
//	Параметры:
//		Форма - ФормаКлиентскогоПриложения - форма, в которой есть таблица с упаковочными листами,
//		Элемент - ПолеФормы - поле, в котором происходит выбор,
//		СтандартнаяОбработка - Булево - признак выполнения стандартной обработки,
//		РежимПросмотраПоТоварам - Булево - признак текущего режима просмотра
//			таблицы с упаковочными листами (по товарам или товарным местам).
//	
Процедура НачалоВыбораТоварногоМеста(Форма, Элемент, СтандартнаяОбработка, РежимПросмотраПоТоварам = Ложь) Экспорт
	
	Если Не Форма.ИспользоватьУпаковочныеЛисты Тогда
		Возврат;
	КонецЕсли;
	
	Если РежимПросмотраПоТоварам Тогда
		Возврат;
	КонецЕсли;
	
	СтандартнаяОбработка = Ложь;
	
	ИмяТЧТовары = ПараметрыУказанияСерий(Форма).ИмяТЧТовары;
	ТекущиеДанные = Форма.Элементы[ИмяТЧТовары].ТекущиеДанные;
	
	Список = Новый СписокЗначений;
	ПредставлениеНоменклатуры = НСтр("ru='Номенклатура';uk='Номенклатура'");
	ПредставлениеУпаковочногоЛиста = НСтр("ru='Упаковочный лист';uk='Пакувальний лист'");
	Список.Добавить(ПредставлениеНоменклатуры);
	Список.Добавить(ПредставлениеУпаковочногоЛиста);
	ДополнительныеПараметры = Новый Структура("Форма", Форма);
	ОписаниеОповещенияОЗакрытии = Новый ОписаниеОповещения("ПослеВыбораТипаТоварногоМеста", ЭтотОбъект, ДополнительныеПараметры);
	Форма.ПоказатьВыборИзСписка(ОписаниеОповещенияОЗакрытии, Список, Элемент);
	
КонецПроцедуры

// Обработчик команды "Разбить строку" для строки, в которой может быть указан упаковочный лист.
//	Параметры:
//		ТЧ - ДанныеФормыКоллекция - табличная часть с обрабатываемой строкой,
//		ДанныеФормы - ТаблицаФормы - элемент формы с обрабатываемой строкой,
//		ОповещениеПослеРазбиения - ОписаниеОповещения - оповещение, вызываемое после попытки разбиения,
//		ПараметрыРазбиенияСтроки - Структура - см. ОбщегоНазначенияУТКлиент.ПараметрыРазбиенияСтроки.
//
Процедура РазбитьСтрокуТЧСУпаковочнымиЛистами(ТЧ, ДанныеФормы, ОповещениеПослеРазбиения, ПараметрыРазбиенияСтроки = Неопределено) Экспорт
	
	Если Не РаботаСТабличнымиЧастямиКлиент.ВыбранаСтрокаДляВыполненияКоманды(ДанныеФормы) Тогда
		ВыполнитьОбработкуОповещения(ОповещениеПослеРазбиения, Неопределено);
	ИначеЕсли ДанныеФормы.ТекущиеДанные.ЭтоУпаковочныйЛист Тогда
		ТекстСообщения = НСтр("ru='Невозможно разбить строку с упаковочным листом.';uk='Неможливо розбити рядок з пакувальним листом.'");
		ПоказатьПредупреждение(,ТекстСообщения);
		ВыполнитьОбработкуОповещения(ОповещениеПослеРазбиения, Неопределено);
	Иначе
		РаботаСТабличнымиЧастямиКлиент.РазбитьСтроку(ТЧ, ДанныеФормы, ОповещениеПослеРазбиения, ПараметрыРазбиенияСтроки);
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

#Область ОбщиеПроцедурыИФункцииПриРаботеСУпаковочнымиЛистами

Функция ПараметрыУказанияСерий(Форма)
	
	Если Форма.ПараметрыУказанияСерий.Свойство("ОтгружаемыеТовары") Тогда
		Возврат Форма.ПараметрыУказанияСерий.ОтгружаемыеТовары;
	Иначе
		Возврат Форма.ПараметрыУказанияСерий;
	КонецЕсли;	
	
КонецФункции

// Параметры:
// 	ДополнительныеПараметры - Структура - где:
// 	* Форма - ФормаКлиентскогоПриложения
// 
Процедура ПослеВыбораТипаТоварногоМеста(Результат, ДополнительныеПараметры) Экспорт
	
	Если Результат = Неопределено Тогда
		Возврат;
	КонецЕсли;
	
	ИмяТЧТовары = ПараметрыУказанияСерий(ДополнительныеПараметры.Форма).ИмяТЧТовары;
	ТекущиеДанные = ДополнительныеПараметры.Форма.Элементы[ИмяТЧТовары].ТекущиеДанные;
	
	ПредставлениеНоменклатуры      = НСтр("ru='Номенклатура';uk='Номенклатура'");
	ПредставлениеУпаковочногоЛиста = НСтр("ru='Упаковочный лист';uk='Пакувальний лист'");
	
	Если Результат.Значение = ПредставлениеНоменклатуры Тогда
		ПараметрыФормы = Новый Структура;
		ОтборПоТипу = Новый Массив;
		ОтборПоТипу.Добавить(ПредопределенноеЗначение("Перечисление.ТипыНоменклатуры.Товар"));
		ОтборПоТипу.Добавить(ПредопределенноеЗначение("Перечисление.ТипыНоменклатуры.МногооборотнаяТара"));
		ПараметрыФормы.Вставить("Отбор", Новый Структура("ТипНоменклатуры", ОтборПоТипу));
		ОткрытьФорму("Справочник.Номенклатура.Форма.ФормаВыбора", ПараметрыФормы, ДополнительныеПараметры.Форма);
	ИначеЕсли Результат.Значение = ПредставлениеУпаковочногоЛиста Тогда
		Отбор = Новый Структура("Проведен", Истина);
		ПараметрыФормы = Новый Структура("Отбор, Штрихкод", Отбор, "");
		ЗаполнитьЗначенияСвойств(ПараметрыФормы, ТекущиеДанные);
		ОткрытьФорму("Документ.УпаковочныйЛист.Форма.ФормаВыбора", ПараметрыФормы, ДополнительныеПараметры.Форма);
	КонецЕсли;
КонецПроцедуры

#КонецОбласти

#КонецОбласти




