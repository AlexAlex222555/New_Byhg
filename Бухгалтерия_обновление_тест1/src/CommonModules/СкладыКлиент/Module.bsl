
#Область ПрограммныйИнтерфейс

// Обрабатывает параметры и открывает форму выбора некачественной номенклатуры 
//
// Параметры:
//  ТекущаяСтрока					 - СтрокаТаблицы - текущая строка табличной части
//  СтруктураДействий				 - Структура - структура действий 
//  КэшированныеЗначения			 - Структура - кэшированные значения
//  ОповещениеУспешногоВыполнения	 - ОписаниеОповещения - оповещение, которое будет вызвано после закрытия формы выбора некачественной номенклатуры.
//
Процедура ИзменитьКачество(ТекущаяСтрока,СтруктураДействий, КэшированныеЗначения, ОповещениеУспешногоВыполнения = Неопределено) Экспорт
	
	Если ТекущаяСтрока = Неопределено Тогда
		ПоказатьПредупреждение(, НСтр("ru='Выберите строку, для которой хотите изменить качество';uk='Виберіть рядок, для якого хочете змінити якість'"));
		Возврат;
	КонецЕсли;
	
	Если Не ЗначениеЗаполнено(ТекущаяСтрока.Номенклатура) Тогда
		ОчиститьСообщения();
		ТекстСообщения = НСтр("ru='В выбранной строке не указан товар исходного качества.';uk='У вибраному рядку не вказаний товар вихідної якості.'");
		ОбщегоНазначенияКлиентСервер.СообщитьПользователю(ТекстСообщения);
		Возврат;
	КонецЕсли;
	
	ДополнительныеПараметры = Новый Структура;
	
	ДополнительныеПараметры.Вставить("КэшированныеЗначения", КэшированныеЗначения);
	ДополнительныеПараметры.Вставить("ОповещениеУспешногоВыполнения", ОповещениеУспешногоВыполнения);
	ДополнительныеПараметры.Вставить("СтруктураДействий", СтруктураДействий);
	ДополнительныеПараметры.Вставить("ТекущаяСтрока", ТекущаяСтрока);
	
	Оповещение = Новый ОписаниеОповещения("ИзменитьКачествоЗавершение", ЭтотОбъект, ДополнительныеПараметры);
	ОткрытьФорму("Справочник.Номенклатура.Форма.ФормаВыбораНекачественнойНоменклатуры",
		Новый Структура("Номенклатура", ТекущаяСтрока.Номенклатура),
		,
		,
		,
		,
		Оповещение, 
		РежимОткрытияОкнаФормы.БлокироватьВесьИнтерфейс);
	
КонецПроцедуры

// Берет в работу задания на отбор/размещение, обрабатывает параметры и открывает форму настроек взятия в работу.
//
// Параметры:
//  Форма							 - ФормаКлиентскогоПриложения - форма, на которой находится список заданий на отбор/размещение
//  Список							 - ТаблицаФормы - список заданий на отбор/размещение
//  Операция						 - Строка - "УправлениеОтгрузкой", "УправлениеПоступлением" или "ОтборРазмещение"
//  ОповещениеУспешногоВыполнения	 - ОписаниеОповещения - оповещение, которое будет вызвано после установки настроек.
//
Процедура ВзятьЗаданияВРаботу(Форма, Список, Операция, ОповещениеУспешногоВыполнения) Экспорт
	ОчиститьСообщения();
	
	МассивДокументов = ОбщегоНазначенияУТКлиент.ПроверитьПолучитьВыделенныеВСпискеСсылки(Список);
	
	Если МассивДокументов.Количество() = 0 Тогда
		Возврат;
	КонецЕсли;
	
	Структура = Новый Структура;
	Структура.Вставить("Склад",Форма.Склад);
	Структура.Вставить("Помещение",Форма.Помещение);
	
	ФормаПараметры = Новый Структура("Заголовок ,Операция, ПараметрОбъект", Операция, "ВзятиеЗаданийВРаботу",Структура);  
	
	ДополнительныеПараметры = Новый Структура;
	
	ДополнительныеПараметры.Вставить("МассивДокументов", МассивДокументов);
	ДополнительныеПараметры.Вставить("ОповещениеУспешногоВыполнения", ОповещениеУспешногоВыполнения);
	ДополнительныеПараметры.Вставить("Список", Список);
	ДополнительныеПараметры.Вставить("Форма", Форма);
	
	Оповещение = Новый ОписаниеОповещения("ВзятьЗаданияВРаботуЗавершение", ЭтотОбъект, ДополнительныеПараметры);
	ОткрытьФорму("Документ.ОтборРазмещениеТоваров.Форма.ФормаНастроек", 
		ФормаПараметры, 
		Форма,
		,
		,
		,
		Оповещение, 
		РежимОткрытияОкнаФормы.БлокироватьОкноВладельца);
	
КонецПроцедуры

// Помечает задание на отбор/размещение как выполненное без ошибок
//
// Параметры:
//  Форма							 - ФормаКлиентскогоПриложения	- форма, на которой находится список заданий на отбор/размещение 
//  Список							 - ТаблицаФормы - список заданий на отбор/размещение 
//  Операция						 - Строка - "УправлениеОтгрузкой", "УправлениеПоступлением" или "ОтборРазмещение"
//  ОповещениеУспешногоВыполнения	 - ОписаниеОповещения - оповещение, которое будет вызвано после установки настроек.
//
Процедура ОтметитьВыполнениеЗаданийБезОшибок(Форма, Список, Операция, ОповещениеУспешногоВыполнения) Экспорт
	ОчиститьСообщения();
	
	МассивДокументов = ОбщегоНазначенияУТКлиент.ПроверитьПолучитьВыделенныеВСпискеСсылки(Список);
	
	Если МассивДокументов.Количество() = 0 Тогда
		Возврат;
	КонецЕсли;
	
	Структура = Новый Структура;
	Структура.Вставить("Склад", Форма.Склад);
	Структура.Вставить("Помещение", Форма.Помещение);
	
	ФормаПараметры = Новый Структура("Заголовок ,Операция,ПараметрОбъект", Операция, "ВыполнениеЗаданий",Структура);  
	
	ДополнительныеПараметры = Новый Структура;
	
	ДополнительныеПараметры.Вставить("МассивДокументов", МассивДокументов);
	ДополнительныеПараметры.Вставить("ОповещениеУспешногоВыполнения", ОповещениеУспешногоВыполнения);
	ДополнительныеПараметры.Вставить("Список", Список);
	ДополнительныеПараметры.Вставить("Форма", Форма);
	
	Оповещение = Новый ОписаниеОповещения("ОтметитьВыполнениеЗаданийБезОшибокЗавершение", ЭтотОбъект, ДополнительныеПараметры);
	
	ОткрытьФорму("Документ.ОтборРазмещениеТоваров.Форма.ФормаНастроек",
		ФормаПараметры, 
		Форма,
		,
		,
		,
		Оповещение,
		РежимОткрытияОкнаФормы.БлокироватьОкноВладельца);
	
КонецПроцедуры

// Проверяет заполненность реквизитов, необходимых для заполнения реквизита "Склад" в табличной части.
//
// Параметры:
//		Объект- ДокументОбъект - документ, в ТЧ которого нужно проверить заполнение колонки "Склад",
// 		ТабличнаяЧасть - ДанныеФормыКоллекция - табличная часть, в которой необходимо осуществить проверку,
// 		ПредставлениеТабличнойЧасти - Строка - представление табличной части для информирования пользователя,
// 		ВыделенныеСтроки - Массив - Массив выделенных строк табличной части.
//
// Возвращаемое значение:
// 		Булево - Ложь, если необходимые данные не заполнены.
//
Функция ПроверитьВозможностьЗаполненияСкладовВТабличнойЧасти(Объект, ТабличнаяЧасть, ПредставлениеТабличнойЧасти, ВыделенныеСтроки) Экспорт
	
	Если Тип("ДокументСсылка.РеализацияТоваровУслуг") = ТипЗнч(Объект.Ссылка)
		Или Тип("ДокументСсылка.ПередачаТоваровХранителю") = ТипЗнч(Объект.Ссылка) Тогда
		
		Если ЗначениеЗаполнено(Объект.ЗаказКлиента) Тогда
			ТекстПредупреждения = НСтр("ru='Документ введен на основании заказа клиента. Поле ""Склад"" не может быть заполнено';uk='Документ введений на підставі замовлення клієнта. Поле ""Склад"" не може бути заповнене'");
			ПоказатьПредупреждение(,ТекстПредупреждения);
			Возврат Ложь;
		КонецЕсли;
		
	КонецЕсли;
	
	Если ТабличнаяЧасть.Количество() = 0 Тогда
		
		ТекстПредупреждения = НСтр("ru='В документе не заполнена таблица %ПредставлениеТабличнойЧасти%. Поле ""Склад"" не может быть заполнено';uk='У документі не заповнена таблиця %ПредставлениеТабличнойЧасти%. Поле ""Склад"" не може бути заповнене'");
		ТекстПредупреждения = СтрЗаменить(ТекстПредупреждения, "%ПредставлениеТабличнойЧасти%", ПредставлениеТабличнойЧасти);
		ПоказатьПредупреждение(,ТекстПредупреждения);
		Возврат Ложь;
		
	КонецЕсли;
	
	Если ВыделенныеСтроки.Количество() = 0 Тогда
		
		ПоказатьПредупреждение(,НСтр("ru='В таблице отсутствуют выделенные строки. Выделите строки для заполнения реквизита ""Склад""';uk='У таблиці відсутні виділені рядки. Виділіть рядки для заповнення реквізиту ""Склад""'"));
		Возврат Ложь;
		
	КонецЕсли;
	
	Возврат Истина;
	
КонецФункции // ПроверитьВозможностьЗаполненияСкладовВТабличнойЧасти()

// Процедура показывает оповещение о заполнении реквизита "Склад" табличной части
//
// Параметры:
// 		СкладЗаполнения - СправочникСсылка.Склады - Склад, по которому производилось заполнение
// 		ЗаполненоСтрок - Число - Количество заполненных строк
// 		ВыделеноСтрок - Число - Количество строк выделенных для заполнения.
//
Процедура ПоказатьОповещениеОЗаполненииСкладаВТабличнойЧасти(СкладЗаполнения, ЗаполненоСтрок, ВыделеноСтрок) Экспорт
	
	Если ЗаполненоСтрок = 0 Тогда // Если ни одна выделенная строка не была заполнена
		
		ТекстОповещения = НСтр("ru='Выделенные строки не заполнены';uk='Виділені рядки не заповнено'");
		Пояснение = НСтр("ru='Колонка ""Склад"" в выделенных строках не была заполнена';uk='Колонка ""Склад"" у виділених рядках не була заповнена'");
		
	ИначеЕсли ЗаполненоСтрок = ВыделеноСтрок Тогда // Если все выделенные строки были заполнены
		
		ТекстОповещения = НСтр("ru='Выделенные строки заполнены';uk='Виділені рядки заповнені'");
		Пояснение = СтрЗаменить(НСтр("ru='Колонка ""Склад"" в выделенных строках заполнена значением ""%Склад%""';uk='Колонка ""Склад"" у виділених рядках заповнена значенням ""%Склад%""'"), "%Склад%", СкладЗаполнения);
		
	Иначе // Если не все выделенные строки были заполнены
		
		ТекстОповещения = НСтр("ru='Часть выделенных строк заполнена';uk='Частина виділених рядків заповнена'");
		Пояснение = НСтр("ru='Колонка ""Склад"" в %ЗаполненоСтрок% строках из %ВыделеноСтрок% выделенных заполнена значением ""%Склад%""';uk='Колонка ""Склад"" в %ЗаполненоСтрок% рядках з %ВыделеноСтрок% виділених заповнена значенням ""%Склад%""'");
		Пояснение = СтрЗаменить(Пояснение, "%Склад%", СкладЗаполнения);
		Пояснение = СтрЗаменить(Пояснение, "%ЗаполненоСтрок%", ЗаполненоСтрок);
		Пояснение = СтрЗаменить(Пояснение, "%ВыделеноСтрок%", ВыделеноСтрок);
		
	КонецЕсли;
	
	ПоказатьОповещениеПользователя(ТекстОповещения, , Пояснение, БиблиотекаКартинок.Информация32);
	
КонецПроцедуры // ПоказатьОповещениеОЗаполненииСкладаВТабличнойЧасти()

// Процедура - Открыть форму проверки упаковки исправления количества.
//
// Параметры:
//	Форма	 - ФормаКлиентскогоПриложения - форма из которой осуществляется открытие формы 
//		обработки "ПроверкаКоличестваТоваровВДокументе";
//	Действие - Строка - "Проверка" или "Исправление".
//
Процедура ОткрытьФормуПроверкиУпаковкиИсправленияКоличества(Форма, Действие = "Проверка") Экспорт
	
	ЭтоРасходныйОрдер = (ТипЗнч(Форма.Объект.Ссылка) = Тип("ДокументСсылка.РасходныйОрдерНаТовары"));
	
	Если Действие = "Проверка" Тогда
		Если ЭтоРасходныйОрдер
			И Форма.ИспользоватьУпаковочныеЛисты Тогда
			ДействиеИмПадеж  = НСтр("ru='Проверка количества и упаковка';uk='Перевірка кількості та упаковка'");
			ДействиеРодПадеж = НСтр("ru='проверки количества и упаковки';uk='перевірки кількості та упаковки'");
		Иначе
			ДействиеИмПадеж  = НСтр("ru='Проверка количества';uk='Перевірка кількості'");
			ДействиеРодПадеж = НСтр("ru='проверки количества';uk='перевірки кількості'");
		КонецЕсли;
	Иначе
		Если ЭтоРасходныйОрдер
			И Форма.ИспользоватьУпаковочныеЛисты Тогда
			ДействиеИмПадеж  = НСтр("ru='Исправление количества и упаковка';uk='Виправлення кількості та упаковки'");
			ДействиеРодПадеж = НСтр("ru='исправления количества и упаковки';uk='виправлення кількості та упаковки'");
		Иначе
			ДействиеИмПадеж  = НСтр("ru='Исправление количества';uk='Виправлення кількості'");
			ДействиеРодПадеж = НСтр("ru='исправления количества';uk='виправлення кількості'");
		КонецЕсли;
	КонецЕсли;
	
	ОчиститьСообщения();
	Отказ = Ложь;
	
	Если Форма.Модифицированность
		ИЛИ Не Форма.Объект.Проведен Тогда
		ТекстВопроса = НСтр("ru='Перед началом %ПроверкиУпаковкиИсправления% товаров документ будет проведен. Продолжить?';uk='Перед початком %ПроверкиУпаковкиИсправления% товарів документ буде проведений. Продовжити?'");
		ТекстВопроса = СтрЗаменить(ТекстВопроса,"%ПроверкиУпаковкиИсправления%", ДействиеРодПадеж);
		Ответ = Неопределено;
		
		ДополнительныеПараметры = Новый Структура;
		
		ДополнительныеПараметры.Вставить("Действие", Действие);
		ДополнительныеПараметры.Вставить("ДействиеИмПадеж", ДействиеИмПадеж);
		ДополнительныеПараметры.Вставить("Форма", Форма);
		ДополнительныеПараметры.Вставить("ЭтоРасходныйОрдер", ЭтоРасходныйОрдер);
		
		ПоказатьВопрос(Новый ОписаниеОповещения("ОткрытьФормуПроверкиУпаковкиИсправленияКоличестваЗавершение",
												ЭтотОбъект,
												ДополнительныеПараметры),
			ТекстВопроса,
			РежимДиалогаВопрос.ОКОтмена,
			,
			КодВозвратаДиалога.Отмена);
		Возврат;
	КонецЕсли;
	
	ОткрытьФормуПроверкиУпаковкиИсправленияКоличестваФрагмент(Действие, ДействиеИмПадеж, Форма, ЭтоРасходныйОрдер);
КонецПроцедуры

// Обновляет служебный реквизит формы данными о количестве складов используемых в табличной части документа.
//
// Параметры:
//	ТаблицаСкладов - ТаблицаЗначений - Служебный реквизит формы, данные которого необходимо обновить;
//	ТекущиеДанные - ДанныеФормыЭлементКоллекции, Неопределено - строка таблицы реквизиты в которой изменились;
//	КешСтроки - ФиксированнаяСтруктура, Неопределено - строка таблицы реквизиты в которой изменились, содержит 
//		значения до изменений;
//	Обновлять - Булево, Истина - признак необходимости обновления таблицы складов;
//	ЕстьОтменаСтрок - Булево, Истина - ТекущиеДанные и КешСтроки содержат поле "Отменено".
//
Процедура ОбновитьТаблицуСкладов(ТаблицаСкладов, ТекущиеДанные, КешСтроки, Обновлять, ЕстьОтменаСтрок = Истина) Экспорт
	
	Если Не Обновлять Тогда
		Возврат;
	КонецЕсли;
	
	Если ТекущиеДанные <> Неопределено И КешСтроки <> Неопределено Тогда
		
		Если ТекущиеДанные.Склад = КешСтроки.Склад И (Не ЕстьОтменаСтрок Или ТекущиеДанные.Отменено = КешСтроки.Отменено) Тогда
			
			Возврат;
			
		КонецЕсли;
		
	КонецЕсли;
	
	Если КешСтроки <> Неопределено И (Не ЕстьОтменаСтрок Или Не КешСтроки.Отменено) Тогда
		
		Для Каждого СтрокаТаблицы Из ТаблицаСкладов Цикл
		
			Если СтрокаТаблицы.Склад = КешСтроки.Склад Тогда
			
				Если СтрокаТаблицы.КоличествоСтрок > 1 Тогда
					СтрокаТаблицы.КоличествоСтрок = СтрокаТаблицы.КоличествоСтрок - 1;
				Иначе
					ТаблицаСкладов.Удалить(СтрокаТаблицы);
				КонецЕсли;
				
				Прервать;
				
			КонецЕсли;
			
		КонецЦикла;
		
	КонецЕсли;
	
	Если ТекущиеДанные <> Неопределено И ЗначениеЗаполнено(ТекущиеДанные.Склад)
		И (Не ЕстьОтменаСтрок Или Не ТекущиеДанные.Отменено) Тогда
		
		НайденнаяСтрока = Неопределено;
		Для Каждого СтрокаТаблицы Из ТаблицаСкладов Цикл
			
			Если СтрокаТаблицы.Склад = ТекущиеДанные.Склад Тогда
				
				НайденнаяСтрока = СтрокаТаблицы;
				Прервать;
				
			КонецЕсли;
			
		КонецЦикла;
		
		Если НайденнаяСтрока = Неопределено Тогда
			
			НайденнаяСтрока = ТаблицаСкладов.Добавить();
			НайденнаяСтрока.Склад = ТекущиеДанные.Склад;
			НайденнаяСтрока.КоличествоСтрок = 1;
			
		Иначе
			
			НайденнаяСтрока.КоличествоСтрок = НайденнаяСтрока.КоличествоСтрок + 1;
			
		КонецЕсли;
		
	КонецЕсли;
	
КонецПроцедуры

#Область РасхожденияВДокументахОтгрузки

// Процедура обновляет кеш ключевых реквизитов текущей строки товаров.
//
// Параметры:
//  ТаблицаФормы			 - ТаблицаФормы - таблица формы, отображающая ТЧ товаров
//  КэшированныеЗначения	 - Структура - переменная модуля формы, в которой хранятся кешируемые значения
//  ПараметрыУказанияСерий	 - Структура - структура параметров указания серий, возвращаемая соответствующей процедурой модуля менеджера документа
//  Копирование				 - Булево - признак, что кешированная строка скопирована (параметр события ПриНачалеРедактирования).
//
Процедура ОбновитьКешированныеЗначения(ТаблицаФормы,КэшированныеЗначения,ПараметрыУказанияСерий,Копирование = Ложь) Экспорт
	
	Если КэшированныеЗначения = Неопределено Тогда
		КэшированныеЗначения = ОбработкаТабличнойЧастиКлиентСервер.ПолучитьСтруктуруКэшируемыеЗначения();
	КонецЕсли;
	ТекущиеДанные = ТаблицаФормы.ТекущиеДанные;
	Если ТекущиеДанные <> Неопределено Тогда
		// Структура КэшированныеЗначения могла быть созданы при помощи НоменклатураКлиент.ОбновитьКешированныеЗначенияДляУчетаСерий
		//	и может не содержать необходимые свойства.
		КэшированныеЗначения.Вставить("Номенклатура");
		КэшированныеЗначения.Вставить("Характеристика");
		КэшированныеЗначения.Вставить("Серия");
		КэшированныеЗначения.Вставить("Склад");
		КэшированныеЗначения.Вставить("КоличествоУпаковок");
		КэшированныеЗначения.Вставить("Упаковка");
		ЗаполнитьЗначенияСвойств(КэшированныеЗначения, ТекущиеДанные);
	КонецЕсли;
	
	НоменклатураКлиент.ОбновитьКешированныеЗначенияДляУчетаСерий(
				ТаблицаФормы,КэшированныеЗначения,ПараметрыУказанияСерий, Копирование);
	
КонецПроцедуры

#КонецОбласти 

#КонецОбласти 

#Область СлужебныеПроцедурыИФункции

// Параметры:
// 	ДополнительныеПараметры - Структура:
//		* КэшированныеЗначения - Структура
//		* ОповещениеУспешногоВыполнения - ОписаниеОповещения
//		* СтруктураДействий - Структура
//		* ТекущаяСтрока - Произвольный
//
Процедура ИзменитьКачествоЗавершение(Номенклатура, ДополнительныеПараметры) Экспорт
	
	КэшированныеЗначения = ДополнительныеПараметры.КэшированныеЗначения;
	ОповещениеУспешногоВыполнения = ДополнительныеПараметры.ОповещениеУспешногоВыполнения;
	СтруктураДействий = ДополнительныеПараметры.СтруктураДействий;
	ТекущаяСтрока = ДополнительныеПараметры.ТекущаяСтрока;
	
	Если ЗначениеЗаполнено(Номенклатура) Тогда
		
		СтрокаОприходования = Новый Структура("НоменклатураИсходногоКачества,
			|ХарактеристикиИспользуются,
			|Номенклатура,
			|Характеристика,
			|Упаковка,
			|ВидЦены,
			|Цена,
			|Артикул,
			|АртикулОприходование,
			|Количество,
			|КоличествоУпаковок,
			|Сумма,
			|СуммаСНДС");
		Если СтруктураДействий.Свойство("ПроверитьСериюРассчитатьСтатус") Тогда
			СтрокаОприходования.Вставить("Серия");
			СтрокаОприходования.Вставить("СтатусУказанияСерий");
			ПараметрыУказанияСерий = СтруктураДействий.ПроверитьСериюРассчитатьСтатус.ПараметрыУказанияСерий;
			Для Каждого ПолеСвязи Из ПараметрыУказанияСерий.ПоляСвязи Цикл
				СтрокаОприходования.Вставить(ПолеСвязи);
			КонецЦикла;
			Для Каждого Поле Из ПараметрыУказанияСерий.ИменаПолейСтатусУказанияСерий Цикл
				СтрокаОприходования.Вставить(Поле);
			КонецЦикла;
			Для Каждого Поле Из ПараметрыУказанияСерий.ИменаПолейДляОпределенияРаспоряжения Цикл
				СтрокаОприходования.Вставить(Поле);
			КонецЦикла;
			Для Каждого Поле Из ПараметрыУказанияСерий.ИменаПолейДополнительные Цикл
				СтрокаОприходования.Вставить(Поле);
			КонецЦикла;
			Если ТекущаяСтрока.Свойство("Назначение") Тогда
				СтрокаОприходования.Вставить("Назначение");
			КонецЕсли;
		КонецЕсли;
		
		Если ТекущаяСтрока.Свойство("НоменклатураОприходование") Тогда
			ТекущаяСтрока.НоменклатураОприходование = Номенклатура;
			
			ЗаполнитьЗначенияСвойств(СтрокаОприходования, ТекущаяСтрока);
			
			СтрокаОприходования.НоменклатураИсходногоКачества = ТекущаяСтрока.Номенклатура;
			СтрокаОприходования.Номенклатура                  = ТекущаяСтрока.НоменклатураОприходование;
			СтрокаОприходования.ХарактеристикиИспользуются    = ТекущаяСтрока.ХарактеристикиИспользуютсяОприходование;
			СтрокаОприходования.Характеристика                = ТекущаяСтрока.Характеристика;
			
			ОбработкаТабличнойЧастиКлиент.ОбработатьСтрокуТЧ(СтрокаОприходования, СтруктураДействий, КэшированныеЗначения);
			
			ТекущаяСтрока.ХарактеристикиИспользуютсяОприходование = СтрокаОприходования.ХарактеристикиИспользуются;
			ТекущаяСтрока.ХарактеристикаОприходование             = СтрокаОприходования.Характеристика;
			ТекущаяСтрока.АртикулОприходование                    = СтрокаОприходования.Артикул;
			
			Если ТекущаяСтрока.Свойство("Цена") Тогда
				ТекущаяСтрока.Цена = СтрокаОприходования.Цена;
			КонецЕсли;
			
			Если ТекущаяСтрока.Свойство("Сумма") Тогда
				ТекущаяСтрока.Сумма = СтрокаОприходования.Сумма;
			КонецЕсли;
			
			Если ТекущаяСтрока.Свойство("СуммаСНДС") Тогда
				ТекущаяСтрока.СуммаСНДС = СтрокаОприходования.СуммаСНДС;
			КонецЕсли;
			
		Иначе
			СтрокаОприходования.НоменклатураИсходногоКачества = ТекущаяСтрока.Номенклатура;
			ТекущаяСтрока.Номенклатура = Номенклатура;
			ЗаполнитьЗначенияСвойств(СтрокаОприходования, ТекущаяСтрока);
			ОбработкаТабличнойЧастиКлиент.ОбработатьСтрокуТЧ(СтрокаОприходования, СтруктураДействий, КэшированныеЗначения);
			ЗаполнитьЗначенияСвойств(ТекущаяСтрока, СтрокаОприходования);
		КонецЕсли;
		
		Если ОповещениеУспешногоВыполнения <> Неопределено Тогда
			ВыполнитьОбработкуОповещения(ОповещениеУспешногоВыполнения, ТекущаяСтрока);
		КонецЕсли;
		
	КонецЕсли;

КонецПроцедуры

Процедура ВзятьЗаданияВРаботуЗавершение(Результат, ДополнительныеПараметры) Экспорт
	
	МассивДокументов = ДополнительныеПараметры.МассивДокументов;
	ОповещениеУспешногоВыполнения = ДополнительныеПараметры.ОповещениеУспешногоВыполнения;
	Список = ДополнительныеПараметры.Список;
	Форма = ДополнительныеПараметры.Форма;
	
	Если Результат <> КодВозвратаДиалога.ОК Тогда
		Возврат;
	КонецЕсли;
	
	МассивИзмененныхДокументов = СкладыВызовСервера.ВзятьЗаданияВРаботу(МассивДокументов, Форма.НазначитьИсполнителя, Форма.Исполнитель);
	
	ОбщегоНазначенияУТКлиент.ОповеститьПользователяОбУстановкеСтатуса(Список, МассивИзмененныхДокументов.Количество(), МассивДокументов.Количество(),
	ПредопределенноеЗначение("Перечисление.СтатусыОтборовРазмещенийТоваров.ВРаботе"));
	
	Если МассивИзмененныхДокументов.Количество() = 0 Тогда
		Возврат;
	КонецЕсли;
	
	Если Форма.ПечататьЗадания Тогда
		Если Форма.ПечатьНаПринтер Тогда
			УправлениеПечатьюКлиент.ВыполнитьКомандуПечатиНаПринтер("Документ.ОтборРазмещениеТоваров", "СкладскоеЗадание",
			МассивИзмененныхДокументов, Неопределено);
		Иначе
			УправлениеПечатьюКлиент.ВыполнитьКомандуПечати("Документ.ОтборРазмещениеТоваров", "СкладскоеЗадание",
			МассивИзмененныхДокументов, Форма, Неопределено);
		КонецЕсли;
	КонецЕсли;
	
	ВыполнитьОбработкуОповещения(ОповещениеУспешногоВыполнения);

КонецПроцедуры

Процедура ОтметитьВыполнениеЗаданийБезОшибокЗавершение(Результат, ДополнительныеПараметры) Экспорт
	
	МассивДокументов = ДополнительныеПараметры.МассивДокументов;
	ОповещениеУспешногоВыполнения = ДополнительныеПараметры.ОповещениеУспешногоВыполнения;
	Список = ДополнительныеПараметры.Список;
	Форма = ДополнительныеПараметры.Форма;
	
	Если Результат <> КодВозвратаДиалога.ОК Тогда
		Возврат;
	КонецЕсли;
	
	МассивИзмененныхДокументов = СкладыВызовСервера.ОтметитьВыполнениеЗаданийБезОшибок(МассивДокументов,
	Форма.НазначитьИсполнителя, Форма.Исполнитель);
	
	ОбщегоНазначенияУТКлиент.ОповеститьПользователяОбУстановкеСтатуса(
		Список, 
		МассивИзмененныхДокументов.Количество(), 
		МассивДокументов.Количество(),
		ПредопределенноеЗначение("Перечисление.СтатусыОтборовРазмещенийТоваров.ВыполненоБезОшибок"));
	
	Если МассивИзмененныхДокументов.Количество() = 0 Тогда
		Возврат;
	КонецЕсли;
	
	ВыполнитьОбработкуОповещения(ОповещениеУспешногоВыполнения);

КонецПроцедуры

// Параметры:
// 	ДополнительныеПараметры - Структура:
//		* Действие - Строка - "Проверка" или "Исправление"
// 		* Форма - РасширениеУправляемойФормыДляДокумента
// 
Процедура ОткрытьФормуПроверкиУпаковкиИсправленияКоличестваЗавершение(РезультатВопроса, ДополнительныеПараметры) Экспорт
    
    Действие = ДополнительныеПараметры.Действие;
    ДействиеИмПадеж = ДополнительныеПараметры.ДействиеИмПадеж;
    Форма = ДополнительныеПараметры.Форма;
    ЭтоРасходныйОрдер = ДополнительныеПараметры.ЭтоРасходныйОрдер;
    
    
    Ответ = РезультатВопроса;
    Если Ответ = КодВозвратаДиалога.Отмена Тогда
        Отказ = Истина;
    Иначе
        Отказ = Не Форма.Записать(Новый Структура("РежимЗаписи", РежимЗаписиДокумента.Проведение));
    КонецЕсли;
    Если Отказ Тогда
        Возврат;
    КонецЕсли;
    
    ОткрытьФормуПроверкиУпаковкиИсправленияКоличестваФрагмент(Действие, ДействиеИмПадеж, Форма, ЭтоРасходныйОрдер);

КонецПроцедуры

// Параметры:
// 	Действие - Строка
// 	ДействиеИмПадеж - Строка
// 	Форма - ФормаКлиентскогоПриложения:
// 		* Объект - ДанныеФормыСтруктура:
// 			** Ссылка - ДокументСсылка
// 	ЭтоРасходныйОрдер - Булево
//
Процедура ОткрытьФормуПроверкиУпаковкиИсправленияКоличестваФрагмент(Знач Действие, Знач ДействиеИмПадеж, Знач Форма, Знач ЭтоРасходныйОрдер)
    
    Перем ПараметрЗаголовок, ПараметрыФормы;
    
    Если ЗначениеЗаполнено(Форма.Объект.Ссылка) Тогда
        ПараметрЗаголовок = НСтр("ru='%ПроверкаУпаковкаИсправление% товаров в документе %Документ%';uk='%ПроверкаУпаковкаИсправление% товарів у документі %Документ%'");
        ПараметрЗаголовок = СтрЗаменить(ПараметрЗаголовок, "%Документ%", Форма.Объект.Ссылка);
    ИначеЕсли ЭтоРасходныйОрдер Тогда
        ПараметрЗаголовок = НСтр("ru='%ПроверкаУпаковкаИсправление% товаров в расходном ордере на товаров';uk='%ПроверкаУпаковкаИсправление% товарів в видатковому ордері на товарів'");
    Иначе
        ПараметрЗаголовок = НСтр("ru='%ПроверкаУпаковкаИсправление% товаров в ордере на перемещение товаров';uk='%ПроверкаУпаковкаИсправление% товарів в ордері на переміщення товарів'");
    КонецЕсли;
    
    ПараметрЗаголовок = СтрЗаменить(ПараметрЗаголовок, "%ПроверкаУпаковкаИсправление%", ДействиеИмПадеж);
    
    ПараметрыФормы = Новый Структура;
    ПараметрыФормы.Вставить("Заголовок", ПараметрЗаголовок);
    ПараметрыФормы.Вставить("Ложь", Истина);
    ПараметрыФормы.Вставить("Склад", Форма.Объект.Склад);
    ПараметрыФормы.Вставить("Помещение", ?(ЭтоРасходныйОрдер, Форма.Объект.Помещение, Форма.Объект.ПомещениеОтправитель));
    ПараметрыФормы.Вставить("Ордер", Форма.Объект.Ссылка);
    ПараметрыФормы.Вставить("РежимИсправления", ?(Действие = "Проверка", Ложь, Истина));
    Форма.РазблокироватьДанныеФормыДляРедактирования();
    ОткрытьФорму("Обработка.ПроверкаКоличестваТоваровВДокументе.Форма.Форма", ПараметрыФормы, Форма);
    
    Форма.Закрыть();

КонецПроцедуры

#КонецОбласти
