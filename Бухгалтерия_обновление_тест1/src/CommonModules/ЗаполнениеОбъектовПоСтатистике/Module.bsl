#Область ПрограммныйИнтерфейс

// Заполняет реквизиты объекта по статистике их использования.
//
// Параметры:
//  Объект - ДокументОбъект - Объект, реквизиты которого необходимо заполнить:
//  	* ДополнительныеСвойства - Структура - Дополнительные свойства объекта:
//  		** ОтключитьЗаполнениеОбъектаПоСтатистике - Булево - Истина, если необходимо отключить заполнение реквизитов по статистике.
//  		                                                     Например, в сценарии загрузки объектов из другой системы.
//  ДанныеЗаполнения - Произвольный - значение, на основании которого выполняется заполнение объекта.
//  ОписаниеЗаполняемыхРеквизитов - Структура - описание реквизитов, для которых необходимо получить значения по статистике
//      (см. функцию ЗаполнениеОбъектовПоСтатистике.ДобавитьОписаниеЗаполняемыхРеквизитов);
//      Если параметр не задан, то описание реквизитов будет получено из функции
//      ЗадатьОписаниеЗаполняемыхРеквизитовПоСтатистике() определенной в модуля менеджера объекта.
//
// Возвращаемое значение:
//  Структура - реквизиты объекта, которые были заполнены по статистике,
//      где Ключ - имя реквизита, а Значение - его новое значение.
//
Функция ЗаполнитьРеквизитыОбъекта(Объект, ДанныеЗаполнения, ОписаниеЗаполняемыхРеквизитов = Неопределено) Экспорт
	
	Если Объект.ДополнительныеСвойства.Свойство("ОтключитьЗаполнениеОбъектаПоСтатистике")
		И Объект.ДополнительныеСвойства.ОтключитьЗаполнениеОбъектаПоСтатистике Тогда
		Возврат Новый Структура;
	КонецЕсли;
	
	Возврат ЗаполнитьРеквизиты(Объект, "", ДанныеЗаполнения, ОписаниеЗаполняемыхРеквизитов);
	
КонецФункции

// Заполняет реквизиты объекта по статистике их использования,
// которые были подчинены указанному ключевому реквизиту в описании заполняемых реквизитов объекта.
//
// Параметры:
//  Объект - ЛюбойОбъект - объект, реквизиты которого необходимо заполнить
//  КлючевойРеквизит - Строка - имя реквизита объекта, подчиненные реквизиты которого надо заполнить по статистике.
//  ОписаниеЗаполняемыхРеквизитов - Структура - описание реквизитов, для которых необходимо получить значения по статистике
//      (см. функцию ЗаполнениеОбъектовПоСтатистике.ДобавитьОписаниеЗаполняемыхРеквизитов);
//      Если параметр не задан, то описание реквизитов будет получено из функции
//      ЗадатьОписаниеЗаполняемыхРеквизитовПоСтатистике() определенной в модуля менеджера объекта.
//
// Возвращаемое значение:
//  Структура - реквизиты объекта, которые были заполнены по статистике,
//      где Ключ - имя реквизита, а Значение - его новое значение.
//
Функция ЗаполнитьПодчиненныеРеквизитыОбъекта(Объект, КлючевойРеквизит, ОписаниеЗаполняемыхРеквизитов = Неопределено) Экспорт
	
	Возврат ЗаполнитьРеквизиты(Объект, КлючевойРеквизит, Неопределено, ОписаниеЗаполняемыхРеквизитов);
	
КонецФункции

// Получает значения реквизитов по статистике их использования в конкретном типе объекта.
//
// Параметры:
//  Ссылка - ЛюбаяСсылка - ссылка на объект определяющий тип, по реквизитам которого необходимо получить значения
//  ОписаниеЗаполняемыхРеквизитов - Структура - описание реквизитов, для которых необходимо получить значения по статистике
//      (см. функцию ЗаполнениеОбъектовПоСтатистике.ДобавитьОписаниеЗаполняемыхРеквизитов)
//  ДанныеКлючевыхРеквизитов - Структура - значения ключевых реквизитов, в пределах которых собирается статистика.
//
// Возвращаемое значение:
//  Структура - реквизиты, для которых были получены значения по статистике,
//      где Ключ - имя реквизита, а Значение - его значение.
//
Функция ПолучитьЗначенияРеквизитов(Ссылка, ОписаниеЗаполняемыхРеквизитов, ДанныеКлючевыхРеквизитов = Неопределено) Экспорт
	
	ИмяОбъектаМетаданных = Ссылка.Метаданные().ПолноеИмя();
	
	// Получим описание структуры реквизитов для заполнения
	ОписаниеРеквизитовОбъекта =
		ОбщегоНазначенияКлиентСервер.СкопироватьСтруктуру(
			ЗаполнениеОбъектовПоСтатистикеПовтИсп.ОписаниеРеквизитовОбъекта(
				ИмяОбъектаМетаданных,
				ОписаниеЗаполняемыхРеквизитов));
	
	Если ЗначениеЗаполнено(ОписаниеРеквизитовОбъекта.ТекстОшибки) Тогда // ошибка в описании заполняемых реквизитов
		ВызватьИсключение ОписаниеРеквизитовОбъекта.ТекстОшибки;
	КонецЕсли;
	
	// Добавим в описание реквизитов объекта информацию о самом заполняемом объекте
	ОписаниеРеквизитовОбъекта.Объект.Вставить("Ссылка",               Ссылка);
	ОписаниеРеквизитовОбъекта.Объект.Вставить("ИмяОбъектаМетаданных", ИмяОбъектаМетаданных);
	// Автора берем не из реквизита документа, а из пользователя ИБ, т.к. статистику надо собирать по этому человеку.
	ОписаниеРеквизитовОбъекта.КэшЗначенияРеквизитов.Вставить("Автор", Пользователи.АвторизованныйПользователь());
	
	ПолученныеЗначения = Новый Структура;
	
	// Обходим дерево реквизитов - от "родителей" верхнего уровня до реквизитов, не имеющих "подчиненных" реквизитов.
	Для Каждого РеквизитыТекущегоУровня Из ОписаниеРеквизитовОбъекта.ПорядокЗаполненияРеквизитов Цикл
		
		// Заполним каждый реквизит текущего уровня дерева реквизитов
		Для Каждого Реквизит Из РеквизитыТекущегоУровня Цикл
			
			// Добавим в кэш значения отсутствующих в нем "реквизитов-родителей" (которые еще не использовались).
			Для Каждого Родитель Из ОписаниеРеквизитовОбъекта.РеквизитыОбъекта[Реквизит.Ключ] Цикл
				Если Не ОписаниеРеквизитовОбъекта.КэшЗначенияРеквизитов.Свойство(Родитель.Ключ) Тогда
					ОписаниеРеквизитовОбъекта.КэшЗначенияРеквизитов.Вставить(Родитель.Ключ);
					ЗаполнитьЗначенияСвойств(ОписаниеРеквизитовОбъекта.КэшЗначенияРеквизитов, ДанныеКлючевыхРеквизитов, Родитель.Ключ);
				КонецЕсли;
			КонецЦикла;
			
			// Сформируем описание заполняемого реквизита
			ЗаполняемыйРеквизит = Новый Структура;
			ЗаполняемыйРеквизит.Вставить("ИмяРеквизита",   Реквизит.Ключ);
			ЗаполняемыйРеквизит.Вставить("СтароеЗначение", Реквизит.Значение);
			ЗаполняемыйРеквизит.Вставить("НовоеЗначение",  Неопределено);
			
			// Получим значение реквизита по статистике
			ЗначениеРеквизитаПоСтатистике(ОписаниеРеквизитовОбъекта, ЗаполняемыйРеквизит);
			
			// Перенесем полученное значение
			ПолученныеЗначения.Вставить(ЗаполняемыйРеквизит.ИмяРеквизита, ЗаполняемыйРеквизит.НовоеЗначение);
			
			// Добавим текущий реквизит в кэш (для заполнения "подчиненных" ему реквизитов)
			ОписаниеРеквизитовОбъекта.КэшЗначенияРеквизитов.Вставить(ЗаполняемыйРеквизит.ИмяРеквизита, ЗаполняемыйРеквизит.НовоеЗначение);
			
		КонецЦикла;
		
	КонецЦикла;
	
	Возврат ПолученныеЗначения;
	
КонецФункции

// Функция-конструктор параметров заполняемых по статистике использования реквизитов объекта.
// Позволяет задать связь заполняемых реквизитов с "ключевыми" реквизитами объекта и, исходя из их значений,
// использовать их как разрезы и/или условия для сбора статистики использования.
//
// Возвращаемое значение:
//  Структура:
//     * РазрезыСбораСтатистики - Структура - список полей, задающих фильтр для получения объектов, по которым будет собираться статистика
//         * ИспользоватьВсегда - Строка - имена ключевых реквизитов, разделенные запятыми,
//               которые участвуют в отборе объектов для сбора статистики всегда
//         * ИспользоватьТолькоЗаполненные - Строка - имена ключевых реквизитов, разделенные запятыми,
//               которые участвуют в отборе объектов для сбора статистики, только если они заполнены
//     * ЗаполнятьПриУсловии - Структура - список условий, допускающий заполнение реквизитов по статистике
//         * ПоляОбъектаЗаполнены - Строка - имена ключевых реквизитов, разделенные запятыми,
//               которые должны быть заполнены для начала сбора статистики
//         * ПоляОбъектаПусты - Строка - имена ключевых реквизитов, разделенные запятыми,
//               которые должны быть пусты для начала сбора статистики.
//
Функция ПараметрыЗаполняемыхРеквизитов() Экспорт
	
	РазрезыСбораСтатистики = Новый Структура("ИспользоватьВсегда, ИспользоватьТолькоЗаполненные");
	ЗаполнятьПриУсловии    = Новый Структура("ПоляОбъектаЗаполнены, ПоляОбъектаПусты");
	
	Параметры = Новый Структура;
	Параметры.Вставить("РазрезыСбораСтатистики", РазрезыСбораСтатистики);
	Параметры.Вставить("ЗаполнятьПриУсловии", ЗаполнятьПриУсловии);
	
	Возврат Параметры;
	
КонецФункции

// Добавляет в структуру описания информацию о заполняемых реквизитах объекта и их связи с ключевыми реквизитами,
// в пределах которых собирается статистика использования.
//
// Параметры:
//  ОписаниеЗаполняемыхРеквизитов - Структура - переменная, в которой хранится описание заполняемых реквизитов
//  ИменаРеквизитов - Строка - имена реквизитов, разделенные запятыми, по которым добавляется описание
//  Параметры - Структура - параметры заполняемых реквизитов
//      (см. функцию ЗаполнениеОбъектовПоСтатистике.ПараметрыЗаполняемыхРеквизитов).
//
Процедура ДобавитьОписаниеЗаполняемыхРеквизитов(ОписаниеЗаполняемыхРеквизитов, ИменаРеквизитов, Параметры = Неопределено) Экспорт
	
	Для Каждого Реквизит Из СтрРазделить(ИменаРеквизитов, ",", Ложь) Цикл
		
		КлючевыеРеквизиты = Новый Структура;
		
		Если ЗначениеЗаполнено(Параметры) Тогда
			ДобавитьКлючевыеРеквизиты(КлючевыеРеквизиты, Параметры.ЗаполнятьПриУсловии.ПоляОбъектаЗаполнены,
				"ПоляДолжныБытьЗаполнены");
			ДобавитьКлючевыеРеквизиты(КлючевыеРеквизиты, Параметры.ЗаполнятьПриУсловии.ПоляОбъектаПусты,
				"ПоляДолжныБытьПусты");
			ДобавитьКлючевыеРеквизиты(КлючевыеРеквизиты, Параметры.РазрезыСбораСтатистики.ИспользоватьВсегда,
				"ОтбиратьВсегда");
			ДобавитьКлючевыеРеквизиты(КлючевыеРеквизиты, Параметры.РазрезыСбораСтатистики.ИспользоватьТолькоЗаполненные,
				"ОтбиратьТолькоЗаполненные");
		КонецЕсли;
		
		ОписаниеЗаполняемыхРеквизитов.Вставить(СокрЛП(Реквизит), КлючевыеРеквизиты);
		
	КонецЦикла;
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныйПрограммныйИнтерфейс

// Заполняет реквизит Автор нового документа, являющегося источником для подписки УстановитьАвтораОбъекта.
//
// Параметры:
//  Источник - ДокументОбъект - документ с реквизитом Автор
//  Отказ - Булево - признак отказа от записи
//  РежимЗаписи - РежимЗаписиДокумента - текущий режим записи документа
//  РежимПроведения - РежимПроведенияДокумента - текущий режим проведения документа.
//
Процедура УстановитьАвтораОбъектаПередЗаписью(Источник, Отказ, РежимЗаписи, РежимПроведения) Экспорт
	
	Если Источник.ОбменДанными.Загрузка Тогда
		Возврат;
	КонецЕсли;
	
	Если Не ЗначениеЗаполнено(Источник.Ссылка) Тогда
		Источник.Автор = Пользователи.АвторизованныйПользователь();
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

#Область МеханизмЗаполнения

// Заполняет реквизиты объекта по статистике.
//
// Параметры:
//  Объект - ДокументОбъектИмяДокумента - Заполняемый объект
//  ОтборПоРеквизитуРодителю - Строка - Имя реквизита объекта, подчиненные реквизиты которого надо заполнить по статистике.
//  ДанныеЗаполнения - Произвольный - одноименный параметр процедуры-обработчика заполнения модуля объекта
//  ОписаниеЗаполняемыхРеквизитов - Структура - описание реквизитов, для которых необходимо получить значения по статистике
//      (см. функцию ЗаполнениеОбъектовПоСтатистике.ДобавитьОписаниеЗаполняемыхРеквизитов).
//
//  Возвращаемое значение:
//  Структура - Структура:
//  		* Ключ - имя измененного реквизита объекта
//  		* Значение - новое значение реквизита объекта.
//
Функция ЗаполнитьРеквизиты(Объект, ОтборПоРеквизитуРодителю, ДанныеЗаполнения, ОписаниеЗаполняемыхРеквизитов)
	
	ИмяОбъектаМетаданных = ИмяОбъектаМетаданных(Объект);
	
	Если ОписаниеЗаполняемыхРеквизитов = Неопределено Тогда
		ОписаниеЗаполняемыхРеквизитов = Новый Структура;
		ОбщегоНазначения.МенеджерОбъектаПоПолномуИмени(ИмяОбъектаМетаданных).ЗадатьОписаниеЗаполняемыхРеквизитовПоСтатистике(
			ОписаниеЗаполняемыхРеквизитов);
	КонецЕсли;
	
	// Получим описание структуры реквизитов для заполнения
	ОписаниеРеквизитовОбъекта =
		ОбщегоНазначенияКлиентСервер.СкопироватьСтруктуру(
			ЗаполнениеОбъектовПоСтатистикеПовтИсп.ОписаниеРеквизитовОбъекта(
				ИмяОбъектаМетаданных,
				ОписаниеЗаполняемыхРеквизитов,
				ОтборПоРеквизитуРодителю));
	
	Если ЗначениеЗаполнено(ОписаниеРеквизитовОбъекта.ТекстОшибки) Тогда // ошибка в описании заполняемых реквизитов
		ВызватьИсключение ОписаниеРеквизитовОбъекта.ТекстОшибки;
	КонецЕсли;
	
	Если ТипЗнч(ДанныеЗаполнения) = Тип("Структура") Тогда
		
		ЗначенияИзДанныхЗаполнения =
			ОбщегоНазначенияКлиентСервер.СкопироватьСтруктуру(
				ЗаполнениеОбъектовПоСтатистикеПовтИсп.РеквизитыЗаполняемыеИзДанныхЗаполнения(ИмяОбъектаМетаданных));
		
		ЗаполнитьЗначенияСвойств(ЗначенияИзДанныхЗаполнения, ДанныеЗаполнения);
		
		Для Каждого КлючИЗначение Из ЗначенияИзДанныхЗаполнения Цикл
			Если ЗначениеЗаполнено(КлючИЗначение.Значение)
				И Не (ЗначениеЗаполнено(Объект[КлючИЗначение.Ключ]) И Объект[КлючИЗначение.Ключ] <> Ложь) Тогда
				// Перенесем значение из данных заполнения в объект.
				// Это необходимо для того, чтобы не заполнять по статистике реквизиты,
				// которые должны заполниться из данных заполнения.
				Объект[КлючИЗначение.Ключ] = КлючИЗначение.Значение;
			КонецЕсли;
		КонецЦикла;
		
	КонецЕсли;
	
	// Добавим в описание реквизитов объекта информацию о самом заполняемом объекте
	ОписаниеРеквизитовОбъекта.Объект.Вставить("Ссылка",               Объект.Ссылка);
	ОписаниеРеквизитовОбъекта.Объект.Вставить("ИмяОбъектаМетаданных", ИмяОбъектаМетаданных);
	// Автора берем не из реквизита документа, а из пользователя ИБ, т.к. статистику надо собирать по этому человеку.
	ОписаниеРеквизитовОбъекта.КэшЗначенияРеквизитов.Вставить("Автор", Пользователи.АвторизованныйПользователь());
	
	ИзмененныеРеквизиты = Новый Структура; // измененные реквизиты объекта
	
	// Обходим дерево реквизитов - от "родителей" верхнего уровня до реквизитов, не имеющих "подчиненных" реквизитов.
	Для Каждого РеквизитыТекущегоУровня Из ОписаниеРеквизитовОбъекта.ПорядокЗаполненияРеквизитов Цикл
		
		// Что надо заполнить на этой итерации
		ЗаполняемыеРеквизиты = ОбщегоНазначенияКлиентСервер.СкопироватьСтруктуру(РеквизитыТекущегоУровня);
		ЗаполнитьЗначенияСвойств(ЗаполняемыеРеквизиты, Объект);
		
		// Заполним каждый реквизит текущего уровня дерева реквизитов
		Для Каждого Реквизит Из ЗаполняемыеРеквизиты Цикл
			
			// Добавим в кэш значения отсутствующих в нем "реквизитов-родителей" (которые еще не использовались).
			Для Каждого Родитель Из ОписаниеРеквизитовОбъекта.РеквизитыОбъекта[Реквизит.Ключ] Цикл
				Если Не ОписаниеРеквизитовОбъекта.КэшЗначенияРеквизитов.Свойство(Родитель.Ключ) Тогда
					ОписаниеРеквизитовОбъекта.КэшЗначенияРеквизитов.Вставить(Родитель.Ключ);
					ЗаполнитьЗначенияСвойств(ОписаниеРеквизитовОбъекта.КэшЗначенияРеквизитов, Объект, Родитель.Ключ);
				КонецЕсли;
			КонецЦикла;
			
			// Сформируем описание заполняемого реквизита
			ЗаполняемыйРеквизит = Новый Структура;
			ЗаполняемыйРеквизит.Вставить("ИмяРеквизита",   Реквизит.Ключ);
			ЗаполняемыйРеквизит.Вставить("СтароеЗначение", Реквизит.Значение);
			ЗаполняемыйРеквизит.Вставить("НовоеЗначение",  Неопределено);
			
			// Получим значение реквизита по статистике
			ЗначениеРеквизитаПоСтатистике(ОписаниеРеквизитовОбъекта, ЗаполняемыйРеквизит);
			
			Если ЗначениеЗаполнено(ЗаполняемыйРеквизит.НовоеЗначение)
				И ЗаполняемыйРеквизит.НовоеЗначение <> ЗаполняемыйРеквизит.СтароеЗначение Тогда
				
				// Значение реквизита объекта отличается от значения, полученного по статистике
				ИзмененныеРеквизиты.Вставить(ЗаполняемыйРеквизит.ИмяРеквизита, ЗаполняемыйРеквизит.НовоеЗначение);
				
				Объект[ЗаполняемыйРеквизит.ИмяРеквизита] = ЗаполняемыйРеквизит.НовоеЗначение;
				
			КонецЕсли;
			
			// Добавим текущий реквизит в кэш (для заполнения "подчиненных" ему реквизитов)
			ОписаниеРеквизитовОбъекта.КэшЗначенияРеквизитов.Вставить(ЗаполняемыйРеквизит.ИмяРеквизита, ЗаполняемыйРеквизит.НовоеЗначение);
			
		КонецЦикла;
		
	КонецЦикла;
	
	Возврат ИзмененныеРеквизиты; // справочно - сами реквизиты объекта уже изменены
	
КонецФункции

// Определение параметров для сбора статистики.
//
// Параметры:
//  ОписаниеРеквизитовОбъекта - Структура - описание структуры реквизитов для заполнения, содержит ключи
//  	Объект - Структура - содержит ключи
//  		Ссылка - ЛюбаяСсылка - ссылка на объект
//  		ИмяОбъектаМетаданных - Строка - полное имя объекта метаданных
//  	остальные ключи см. ЗаполнениеОбъектовПоСтатистикеПовтИсп.ОписаниеРеквизитовОбъекта()
//  ЗаполняемыйРеквизит - Структура - описание заполняемого реквизита, содержит ключи
//  	ИмяРеквизита - Строка - имя заполняемого реквизита объекта
//
// Возвращаемое значение:
//  Структура - параметры сбора статистики, содержит ключи
//  	РазмерВыборки - Число (х > 0) - количество выбираемых объектов, по умолчанию 5
//  	ЧастотаИспользованияЗначения - Число (0 <= х <= 1) - частота использования значения (вес значения в выборке), по умолчанию 0.5
//  		вес значения в выборке выше этой величины позволяет считать значение "частотным".
//
Функция ПараметрыСбораСтатистики(Знач ОписаниеРеквизитовОбъекта, ЗаполняемыйРеквизит)
	
	ПараметрыСбораСтатистики = Новый Структура;
	ПараметрыСбораСтатистики.Вставить("РазмерВыборки", 5);
	ПараметрыСбораСтатистики.Вставить("ЧастотаИспользованияЗначения", 0.5);
	
	Возврат ПараметрыСбораСтатистики;
	
КонецФункции

// Определяет значение реквизита, которое согласно статистике является "частотным".
//
// Параметры:
//  ОписаниеРеквизитовОбъекта - Структура - описание структуры реквизитов для заполнения, содержит ключи:
//  	* Объект - Структура - содержит ключи:
//  		* Ссылка - ЛюбаяСсылка - ссылка на объект
//  		* ИмяОбъектаМетаданных - Строка - полное имя объекта метаданных
//  	остальные ключи См. ЗаполнениеОбъектовПоСтатистикеПовтИсп.ОписаниеРеквизитовОбъекта()
//  ЗаполняемыйРеквизит - Структура - описание заполняемого реквизита, содержит ключи
//  	ИмяРеквизита - Строка - имя заполняемого реквизита объекта
//  	СтароеЗначение - Произвольный - текущее значение заполняемого реквизита
//  	НовоеЗначение - Произвольный - новое значение заполняемого реквизита, по умолчанию Неопределено.
//
Процедура ЗначениеРеквизитаПоСтатистике(ОписаниеРеквизитовОбъекта, ЗаполняемыйРеквизит)
	
	// Если реквизит уже заполнен, то его значение не перезаполняем
	Если ЗначениеЗаполнено(ЗаполняемыйРеквизит.СтароеЗначение) И ЗаполняемыйРеквизит.СтароеЗначение <> Ложь Тогда
		ЗаполняемыйРеквизит.НовоеЗначение = ЗаполняемыйРеквизит.СтароеЗначение;
		Возврат;
	КонецЕсли;
	
	// Обработаем реквизиты, по которым нужно отбирать данные для статистики
	ЗначенияРеквизитовРодителей = Новый Структура;
	Для Каждого ОписаниеРодителя Из ОписаниеРеквизитовОбъекта.РеквизитыОбъекта[ЗаполняемыйРеквизит.ИмяРеквизита] Цикл
		ЗначениеРеквизита = ОписаниеРеквизитовОбъекта.КэшЗначенияРеквизитов[ОписаниеРодителя.Ключ];
		ЗначениеРеквизитаЗаполнено = ЗначениеЗаполнено(ЗначениеРеквизита) И ЗначениеРеквизита <> Ложь;
		
		Если ОписаниеРодителя.Значение.Свойство("ПоляДолжныБытьЗаполнены") И Не ЗначениеРеквизитаЗаполнено
			Или ОписаниеРодителя.Значение.Свойство("ПоляДолжныБытьПусты") И ЗначениеРеквизитаЗаполнено Тогда
			Возврат;
		КонецЕсли;
		
		Если ОписаниеРодителя.Значение.Свойство("ОтбиратьТолькоЗаполненные") И ЗначениеРеквизитаЗаполнено
			Или ОписаниеРодителя.Значение.Свойство("ОтбиратьВсегда") Тогда
			ЗначенияРеквизитовРодителей.Вставить(ОписаниеРодителя.Ключ, ЗначениеРеквизита);
		КонецЕсли;
	КонецЦикла;
	
	// Определим параметры сбора статистики
	ПараметрыСбораСтатистики = ПараметрыСбораСтатистики(ОписаниеРеквизитовОбъекта, ЗаполняемыйРеквизит);
	
	// Сформируем текст запроса (содержит шаблоны для замены)
	// Алгоритм расчета значения реквизита:
	// - выберем последние по дате объекты в количестве "РазмерВыборки" (кроме помеченных на удаление объектов и текущего объекта)
	// - посчитаем количество раз, которое использовалось каждое значение заполняемого реквизита в выбранных объектах
	//  	например, Значение1 = 1 раз, Значение2 - 3 раза, Значение3 - 1 раз
	// - выберем одно значение реквизита, вес которого среди всех значений составляет больше 0,5 (50%)
	//  	например, вес Значение1 = 0,2, вес Значение2 = 0,6, вес Значение3 = 0,2, т.е. будет выбрано Значение2
	//  	если значения с подходящим весом (> 0,5) нет, то не будет выбрано ничего,
	//  	т.е. нет такого значения реквизита, которое по статистическим данным является "частотным".
	Запрос = Новый Запрос;
	Запрос.Текст =
	"ВЫБРАТЬ РАЗРЕШЕННЫЕ
	|	Статистика.ЗначениеРеквизита КАК ЗначениеРеквизита,
	|	СУММА(Статистика.ВесЗначения) КАК ВесЗначения
	|ПОМЕСТИТЬ ВТСтатистика
	|ИЗ
	|	(ВЫБРАТЬ ПЕРВЫЕ %1
	|		ТаблицаОбъекта.%2 КАК ЗначениеРеквизита,
	|		1 КАК ВесЗначения
	|	ИЗ
	|		%3 КАК ТаблицаОбъекта
	|	ГДЕ
	|		НЕ ТаблицаОбъекта.ПометкаУдаления
	|		И НЕ ТаблицаОбъекта.Ссылка = &Ссылка
	|		%4
	|	
	|	УПОРЯДОЧИТЬ ПО
	|		ТаблицаОбъекта.Дата УБЫВ) КАК Статистика
	|
	|СГРУППИРОВАТЬ ПО
	|	Статистика.ЗначениеРеквизита
	|;
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ
	|	СУММА(Статистика.ВесЗначения) КАК ОбщийВес
	|ПОМЕСТИТЬ ВТОбщееКоличество
	|ИЗ
	|	ВТСтатистика КАК Статистика
	|;
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ ПЕРВЫЕ 1
	|	ВложенныйЗапрос.ЗначениеРеквизита
	|ИЗ
	|	(ВЫБРАТЬ
	|		Статистика.ЗначениеРеквизита,
	|		Статистика.ВесЗначения / ОбщееКоличество.ОбщийВес КАК УдельныйВес
	|	ИЗ
	|		ВТСтатистика КАК Статистика
	|			ЛЕВОЕ СОЕДИНЕНИЕ ВТОбщееКоличество КАК ОбщееКоличество
	|			ПО ИСТИНА) КАК ВложенныйЗапрос
	|ГДЕ
	|	ВложенныйЗапрос.УдельныйВес > &ЧастотаИспользованияЗначения
	|
	|УПОРЯДОЧИТЬ ПО
	|	ВложенныйЗапрос.УдельныйВес,
	|	ВложенныйЗапрос.ЗначениеРеквизита";
	
	// Отборы запроса:
	// - по объекту, реквизит которого заполняется по статистике.
	Запрос.УстановитьПараметр("Ссылка", ОписаниеРеквизитовОбъекта.Объект.Ссылка);
	// - по минимальному весу значения; вес выше этого позволяет считать значение "частотным".
	Запрос.УстановитьПараметр("ЧастотаИспользованияЗначения", ПараметрыСбораСтатистики.ЧастотаИспользованияЗначения);
	// - по реквизитам-родителям; параметры запроса вида "&Отбор_<Имя реквизита-родителя>".
	УсловияОтбора = Новый Массив;
	Для Каждого Родитель Из ЗначенияРеквизитовРодителей Цикл
		УсловияОтбора.Добавить("И ТаблицаОбъекта." + Родитель.Ключ + " = &Отбор_" + Родитель.Ключ);
		Запрос.УстановитьПараметр("Отбор_" + Родитель.Ключ, Родитель.Значение);
	КонецЦикла;
	
	Запрос.Текст = СтрШаблон(Запрос.Текст,
		Формат(ПараметрыСбораСтатистики.РазмерВыборки, "ЧГ=0"),
		ЗаполняемыйРеквизит.ИмяРеквизита,
		ОписаниеРеквизитовОбъекта.Объект.ИмяОбъектаМетаданных,
		СтрСоединить(УсловияОтбора, Символы.ПС + Символы.Таб + Символы.Таб));
	
	Выборка = Запрос.Выполнить().Выбрать();
	Если Выборка.Следующий() Тогда
		ЗаполняемыйРеквизит.НовоеЗначение = Выборка.ЗначениеРеквизита;
	КонецЕсли;
	
КонецПроцедуры

Функция ИмяОбъектаМетаданных(Объект)
	
	Если ТипЗнч(Объект) = Тип("ДанныеФормыСтруктура") Тогда
		ОбъектМетаданных = Объект.Ссылка.Метаданные();
	Иначе // ДокументОбъект
		ОбъектМетаданных = Объект.Метаданные();
	КонецЕсли;
	
	Возврат ОбъектМетаданных.ПолноеИмя();
	
КонецФункции

Процедура ДобавитьКлючевыеРеквизиты(КлючевыеРеквизиты, ИменаРеквизитов, ИмяСвойства)
	Для Каждого КлючевойРеквизит Из СтрРазделить(ИменаРеквизитов, ",", Ложь) Цикл
		ИмяРеквизита = СокрЛП(КлючевойРеквизит);
		Если Не КлючевыеРеквизиты.Свойство(ИмяРеквизита) Тогда
			КлючевыеРеквизиты.Вставить(ИмяРеквизита, Новый Структура());
		КонецЕсли;
		КлючевыеРеквизиты[ИмяРеквизита].Вставить(ИмяСвойства);
	КонецЦикла;
КонецПроцедуры

#КонецОбласти

#КонецОбласти
