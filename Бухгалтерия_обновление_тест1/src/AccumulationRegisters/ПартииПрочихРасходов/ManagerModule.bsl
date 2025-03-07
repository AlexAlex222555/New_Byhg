#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ПрограммныйИнтерфейс

// Возвращает текст запроса с типовой структурой временной таблицы "ВтИсходныеПрочиеРасходы".
//
// Возвращаемое значение:
//	Строка - Текст запроса формирования временной таблицы ВтИсходныеПрочиеРасходы.
//
Функция ТекстОписаниеВтИсходныеПартииПрочихРасходов() Экспорт
	
	ТекстЗапроса = "
	|ВЫБРАТЬ ПЕРВЫЕ 0
	|	ДД.Период,
	|	ДД.ВидДвижения,
	|	ДД.Организация,
	|	ДД.Подразделение,
	|	ДД.СтатьяРасходов,
	|	ДД.АналитикаРасходов,
	|	ДД.АналитикаАктивовПассивов,
	|	ДД.ДокументПоступленияРасходов,
	|	ДД.АналитикаУчетаПартий,
	|	ДД.НаправлениеДеятельности,
	|	ДД.АналитикаУчетаНоменклатуры,
    |	ДД.НалоговоеНазначение,
	|	0 КАК Стоимость,
	|	0 КАК СтоимостьБезНДС,
	|	0 КАК НДСУпр,
	|	0 КАК СтоимостьРегл,
	|	0 КАК НДСРегл,
	|	0 КАК ПостояннаяРазница,
	|	0 КАК ВременнаяРазница,
	|	ДД.ХозяйственнаяОперация
	|
	|ПОМЕСТИТЬ ВтИсходныеПартииПрочихРасходов
	|ИЗ
	|	РегистрНакопления.ПартииПрочихРасходов КАК ДД
	|";
	Возврат ТекстЗапроса
	
КонецФункции

// Формирует текст запроса для формирования временной таблицы "ВтПартииПрочихРасходов".
//
// Возвращаемое значение:
//	Строка - Текст запроса формирования временной таблицы ВтПартииПрочихРасходов.
//
Функция ТекстЗапросаТаблицаВтПартииПрочихРасходов() Экспорт
	
	ТекстЗапроса = "
	|ВЫБРАТЬ
	|	Строки.Период КАК Период,
	|	Строки.ВидДвижения КАК ВидДвижения,
	|	Строки.Организация КАК Организация,
	|	Строки.Подразделение КАК Подразделение,
	|	Строки.СтатьяРасходов КАК СтатьяРасходов,
	|	Строки.АналитикаРасходов КАК АналитикаРасходов,
	|	Строки.АналитикаАктивовПассивов КАК АналитикаАктивовПассивов,
	|	Строки.ДокументПоступленияРасходов КАК ДокументПоступленияРасходов,
	|	Строки.АналитикаУчетаПартий КАК АналитикаУчетаПартий,
	|	Строки.НаправлениеДеятельности КАК НаправлениеДеятельности,
	|	Строки.АналитикаУчетаНоменклатуры КАК АналитикаУчетаНоменклатуры,
    |	(ВЫБОР
    |		КОГДА &ПартионныйУчетВерсии22 ТОГДА Строки.НалоговоеНазначение 
    |		ИНАЧЕ НЕОПРЕДЕЛЕНО КОНЕЦ) КАК НалоговоеНазначение,
	|
	|	(ВЫБОР
	|		КОГДА Статья.ВариантРаспределенияРасходовУпр = ЗНАЧЕНИЕ(Перечисление.ВариантыРаспределенияРасходов.НаСебестоимостьТоваров)
	|			ТОГДА Строки.Стоимость
	|		ИНАЧЕ 0 КОНЕЦ) КАК Стоимость,
	|	(ВЫБОР
	|		КОГДА Статья.ВариантРаспределенияРасходовУпр = ЗНАЧЕНИЕ(Перечисление.ВариантыРаспределенияРасходов.НаСебестоимостьТоваров)
	|			ТОГДА Строки.СтоимостьБезНДС
	|		ИНАЧЕ 0 КОНЕЦ) КАК СтоимостьБезНДС,
	|	(ВЫБОР
	|		КОГДА &УправленческийУчетОрганизаций
	|			И (Статья.ВариантРаспределенияРасходовУпр = ЗНАЧЕНИЕ(Перечисление.ВариантыРаспределенияРасходов.НаСебестоимостьТоваров)
    //++ НЕ УТ
	|				ИЛИ Статья.ВариантРаспределенияРасходовУпр = ЗНАЧЕНИЕ(Перечисление.ВариантыРаспределенияРасходов.НаВнеоборотныеАктивы)
    //-- НЕ УТ
	|				ИЛИ (Статья.ВариантРаспределенияРасходовУпр = ЗНАЧЕНИЕ(Перечисление.ВариантыРаспределенияРасходов.НаПроизводственныеЗатраты)
	|			 		И &РаздельныйУчетПостатейныхПроизводственныхЗатратПоНалогообложениюНДС))
	|			ТОГДА Строки.НДСУпр
	|		ИНАЧЕ 0 КОНЕЦ) КАК НДСУпр,
	|
	|	(ВЫБОР 
	|		КОГДА Статья.ВариантРаспределенияРасходовРегл = ЗНАЧЕНИЕ(Перечисление.ВариантыРаспределенияРасходов.НаСебестоимостьТоваров)
    //++ НЕ УТ
	|				ИЛИ Статья.ВариантРаспределенияРасходовРегл = ЗНАЧЕНИЕ(Перечисление.ВариантыРаспределенияРасходов.НаВнеоборотныеАктивы)
    //-- НЕ УТ
	|			ИЛИ (Статья.ВариантРаспределенияРасходовРегл = ЗНАЧЕНИЕ(Перечисление.ВариантыРаспределенияРасходов.НаПроизводственныеЗатраты)
	|				И &РаздельныйУчетПостатейныхПроизводственныхЗатратПоНалогообложениюНДС)
	|			ТОГДА Строки.СтоимостьРегл
	|		ИНАЧЕ 0 КОНЕЦ) КАК СтоимостьРегл,
    |	0 КАК ПостояннаяРазница,
    |	0 КАК ВременнаяРазница,
	|	(ВЫБОР
	|		КОГДА Статья.ВариантРаспределенияРасходовРегл = ЗНАЧЕНИЕ(Перечисление.ВариантыРаспределенияРасходов.НаСебестоимостьТоваров)
    //++ НЕ УТ
	|			ИЛИ Статья.ВариантРаспределенияРасходовРегл = ЗНАЧЕНИЕ(Перечисление.ВариантыРаспределенияРасходов.НаВнеоборотныеАктивы)
    //-- НЕ УТ
	|			ИЛИ (Статья.ВариантРаспределенияРасходовРегл = ЗНАЧЕНИЕ(Перечисление.ВариантыРаспределенияРасходов.НаПроизводственныеЗатраты)
	|				И &РаздельныйУчетПостатейныхПроизводственныхЗатратПоНалогообложениюНДС)
	|			ТОГДА Строки.НДСРегл
	|		ИНАЧЕ 0 КОНЕЦ) КАК НДСРегл,
	|	Строки.ХозяйственнаяОперация,
	|		
	|	ВЫБОР
	|		КОГДА ТИПЗНАЧЕНИЯ(Строки.АналитикаРасходов) = ТИП(Документ.ВводОстатков)
	|			ТОГДА ВЫРАЗИТЬ(Строки.АналитикаРасходов КАК Документ.ВводОстатков).Организация
	|		КОГДА ТИПЗНАЧЕНИЯ(Строки.АналитикаРасходов) = ТИП(Документ.ВводОстатковПрочиеРасходы)
	|			ТОГДА ВЫРАЗИТЬ(Строки.АналитикаРасходов КАК Документ.ВводОстатковПрочиеРасходы).Организация
	|		КОГДА ТИПЗНАЧЕНИЯ(Строки.АналитикаРасходов) = ТИП(Документ.ЗаказНаПеремещение)
	|			ТОГДА ВЫРАЗИТЬ(Строки.АналитикаРасходов КАК Документ.ЗаказНаПеремещение).Организация
	|		КОГДА ТИПЗНАЧЕНИЯ(Строки.АналитикаРасходов) = ТИП(Документ.ЗаказНаСборку)
	|			ТОГДА ВЫРАЗИТЬ(Строки.АналитикаРасходов КАК Документ.ЗаказНаСборку).Организация
	|		КОГДА ТИПЗНАЧЕНИЯ(Строки.АналитикаРасходов) = ТИП(Документ.ЗаказПоставщику)
	|			ТОГДА ВЫРАЗИТЬ(Строки.АналитикаРасходов КАК Документ.ЗаказПоставщику).Организация
	|		КОГДА ТИПЗНАЧЕНИЯ(Строки.АналитикаРасходов) = ТИП(Документ.ПередачаТоваровМеждуОрганизациями)
	|			ТОГДА ВЫРАЗИТЬ(Строки.АналитикаРасходов КАК Документ.ПередачаТоваровМеждуОрганизациями).ОрганизацияПолучатель
	|		КОГДА ТИПЗНАЧЕНИЯ(Строки.АналитикаРасходов) = ТИП(Документ.ПеремещениеТоваров)
	|		 И ВЫРАЗИТЬ(Строки.АналитикаРасходов КАК Документ.ПеремещениеТоваров).ХозяйственнаяОперация
	|				= ЗНАЧЕНИЕ(Перечисление.ХозяйственныеОперации.ПеремещениеТоваровМеждуФилиалами)
	|			ТОГДА ВЫРАЗИТЬ(Строки.АналитикаРасходов КАК Документ.ПеремещениеТоваров).ОрганизацияПолучатель
	|		КОГДА ТИПЗНАЧЕНИЯ(Строки.АналитикаРасходов) = ТИП(Документ.ПеремещениеТоваров)
	|			ТОГДА ВЫРАЗИТЬ(Строки.АналитикаРасходов КАК Документ.ПеремещениеТоваров).Организация
	|		КОГДА ТИПЗНАЧЕНИЯ(Строки.АналитикаРасходов) = ТИП(Документ.ПриобретениеТоваровУслуг)
	|			ТОГДА ВЫРАЗИТЬ(Строки.АналитикаРасходов КАК Документ.ПриобретениеТоваровУслуг).Организация
	|		КОГДА ТИПЗНАЧЕНИЯ(Строки.АналитикаРасходов) = ТИП(Документ.СборкаТоваров)
	|			ТОГДА ВЫРАЗИТЬ(Строки.АналитикаРасходов КАК Документ.СборкаТоваров).Организация
	|		ИНАЧЕ Строки.Организация
	|	КОНЕЦ КАК ОрганизацияПолучатель
	|
	|ПОМЕСТИТЬ ВтПартииПрочихРасходов
	|ИЗ
	|	ВтИсходныеПартииПрочихРасходов КАК Строки
	|	ВНУТРЕННЕЕ СОЕДИНЕНИЕ ПланВидовХарактеристик.СтатьиРасходов КАК Статья
	|		ПО Статья.Ссылка = Строки.СтатьяРасходов
	|ГДЕ
	|	&ИспользоватьУчетПрочихДоходовРасходов
	|	И (Статья.ВариантРаспределенияРасходовУпр = ЗНАЧЕНИЕ(Перечисление.ВариантыРаспределенияРасходов.НаСебестоимостьТоваров)
	|		ИЛИ Статья.ВариантРаспределенияРасходовРегл = ЗНАЧЕНИЕ(Перечисление.ВариантыРаспределенияРасходов.НаСебестоимостьТоваров)
	|		ИЛИ (Статья.ВариантРаспределенияРасходовУпр = ЗНАЧЕНИЕ(Перечисление.ВариантыРаспределенияРасходов.НаПроизводственныеЗатраты)
	|			 И &РаздельныйУчетПостатейныхПроизводственныхЗатратПоНалогообложениюНДС)
	|		ИЛИ (Статья.ВариантРаспределенияРасходовРегл = ЗНАЧЕНИЕ(Перечисление.ВариантыРаспределенияРасходов.НаПроизводственныеЗатраты)
	|			 И &РаздельныйУчетПостатейныхПроизводственныхЗатратПоНалогообложениюНДС)
    //++ НЕ УТ
	|		ИЛИ (
	|		    Статья.ВариантРаспределенияРасходовУпр = ЗНАЧЕНИЕ(Перечисление.ВариантыРаспределенияРасходов.НаВнеоборотныеАктивы)
	|			И &Организация <> ЗНАЧЕНИЕ(Справочник.Организации.УправленческаяОрганизация)
    |       )
	|		ИЛИ (
	|		    Статья.ВариантРаспределенияРасходовРегл = ЗНАЧЕНИЕ(Перечисление.ВариантыРаспределенияРасходов.НаВнеоборотныеАктивы)
	|			И &Организация <> ЗНАЧЕНИЕ(Справочник.Организации.УправленческаяОрганизация)
    |       )
    //-- НЕ УТ
    |
    |  )
	|";
	Возврат ТекстЗапроса;
	
КонецФункции

// Формирует текст запроса для формирования движений по регистру "Партии прочих расходов".
//
// Возвращаемое значение:
//	Строка - Текст запроса формирования таблицы ПартииПрочихРасходов.
//
Функция ТекстЗапросаТаблицаПартииПрочихРасходов() Экспорт
	
	ТекстЗапроса = "
	// Формирование таблицы для записи в регистр "ПартииПрочихРасходов".
	|ВЫБРАТЬ
	|	Строки.Период КАК Период,
	|	Строки.ВидДвижения КАК ВидДвижения,
	|	Строки.Организация КАК Организация,
	|	Строки.Подразделение КАК Подразделение,
	|	Строки.СтатьяРасходов КАК СтатьяРасходов,
	|	Строки.АналитикаРасходов КАК АналитикаРасходов,
	|	Строки.АналитикаАктивовПассивов КАК АналитикаАктивовПассивов,
	|	Строки.ДокументПоступленияРасходов КАК ДокументПоступленияРасходов,
	|	Строки.АналитикаУчетаПартий КАК АналитикаУчетаПартий,
	|	Строки.НаправлениеДеятельности КАК НаправлениеДеятельности,
	|	Строки.АналитикаУчетаНоменклатуры КАК АналитикаУчетаНоменклатуры,
    |	Строки.НалоговоеНазначение КАК НалоговоеНазначение,
	|
	|	Строки.Стоимость КАК Стоимость,
	|	Строки.СтоимостьБезНДС КАК СтоимостьБезНДС,
	|	Строки.НДСУпр КАК НДСУпр,
	|
	|	Строки.СтоимостьРегл КАК СтоимостьРегл,
	|	Строки.ПостояннаяРазница КАК ПостояннаяРазница,
	|	Строки.ВременнаяРазница КАК ВременнаяРазница,
	|	Строки.НДСРегл КАК НДСРегл,
	|
	|	Строки.ХозяйственнаяОперация
	|ИЗ
	|	ВтПартииПрочихРасходов КАК Строки
	|ГДЕ
	|	(Строки.Стоимость <> 0 ИЛИ Строки.СтоимостьБезНДС <> 0 ИЛИ Строки.НДСУпр <> 0
	|		ИЛИ Строки.СтоимостьРегл <> 0 ИЛИ Строки.НДСРегл <> 0
	|		ИЛИ Строки.ПостояннаяРазница <> 0 ИЛИ Строки.ВременнаяРазница <> 0)
	|
	// Сторнирование расходов в упр. учете у организации - источника.
	|ОБЪЕДИНИТЬ ВСЕ
	|ВЫБРАТЬ
	|	Строки.Период КАК Период,
	|	Строки.ВидДвижения КАК ВидДвижения,
	|	Строки.Организация КАК Организация,
	|	Строки.Подразделение КАК Подразделение,
	|	Строки.СтатьяРасходов КАК СтатьяРасходов,
	|	Строки.АналитикаРасходов КАК АналитикаРасходов,
	|	Строки.АналитикаАктивовПассивов КАК АналитикаАктивовПассивов,
	|	Строки.ДокументПоступленияРасходов КАК ДокументПоступленияРасходов,
	|	Строки.АналитикаУчетаПартий КАК АналитикаУчетаПартий,
	|	Строки.НаправлениеДеятельности КАК НаправлениеДеятельности,
	|	Строки.АналитикаУчетаНоменклатуры КАК АналитикаУчетаНоменклатуры,
    |	Строки.НалоговоеНазначение КАК НалоговоеНазначение,
	|
	|	-Строки.Стоимость КАК Стоимость,
	|	-Строки.СтоимостьБезНДС КАК СтоимостьБезНДС,
	|	-Строки.НДСУпр КАК НДСУпр,
	|
	|	0 КАК СтоимостьРегл,
	|	0 КАК ПостояннаяРазница,
	|	0 КАК ВременнаяРазница,
	|	0 КАК НДСРегл,
	|	ЗНАЧЕНИЕ(Перечисление.ХозяйственныеОперации.СторнированиеРасходовУУ) КАК ХозяйственнаяОперация
	|ИЗ
	|	ВтПартииПрочихРасходов КАК Строки
	|ГДЕ
	|	Строки.ОрганизацияПолучатель <> Строки.Организация
	|	И (Строки.Стоимость <> 0 ИЛИ Строки.СтоимостьБезНДС <> 0 ИЛИ Строки.НДСУпр <> 0)
	|
	// Регистрация расходов в упр. учете у организации - получателя.
	|ОБЪЕДИНИТЬ ВСЕ
	|ВЫБРАТЬ
	|	Строки.Период КАК Период,
	|	Строки.ВидДвижения КАК ВидДвижения,
	|	Строки.ОрганизацияПолучатель КАК Организация,
	|	Строки.Подразделение КАК Подразделение,
	|	Строки.СтатьяРасходов КАК СтатьяРасходов,
	|	Строки.АналитикаРасходов КАК АналитикаРасходов,
	|	Строки.АналитикаАктивовПассивов КАК АналитикаАктивовПассивов,
	|	Строки.ДокументПоступленияРасходов КАК ДокументПоступленияРасходов,
	|	Строки.АналитикаУчетаПартий КАК АналитикаУчетаПартий,
	|	Строки.НаправлениеДеятельности КАК НаправлениеДеятельности,
	|	Строки.АналитикаУчетаНоменклатуры КАК АналитикаУчетаНоменклатуры,
    |	Строки.НалоговоеНазначение КАК НалоговоеНазначение,
	|
	|	Строки.Стоимость КАК Стоимость,
	|	Строки.СтоимостьБезНДС КАК СтоимостьБезНДС,
	|	Строки.НДСУпр КАК НДСУпр,
	|
	|	0 КАК СтоимостьРегл,
	|	0 КАК ПостояннаяРазница,
	|	0 КАК ВременнаяРазница,
	|	0 КАК НДСРегл,
	|	ЗНАЧЕНИЕ(Перечисление.ХозяйственныеОперации.РегистрацияРасходовУУ) КАК ХозяйственнаяОперация
	|ИЗ
	|	ВтПартииПрочихРасходов КАК Строки
	|ГДЕ
	|	Строки.ОрганизацияПолучатель <> Строки.Организация
	|	И (Строки.Стоимость <> 0 ИЛИ Строки.СтоимостьБезНДС <> 0 ИЛИ Строки.НДСУпр <> 0)
	|";
	Возврат ТекстЗапроса;
	
КонецФункции

// Формирует часть текста запроса получения значения поля ОрганизацияПолучатель.
//
// Возвращаемое значение:
//	Строка - Текст запроса формирования значения поля ОрганизацияПолучатель.
//
Функция ТекстЗапросаЗначениеПоляОрганизацияПолучатель(ИмяТаблицы = "") Экспорт
	
	ТекстЗапроса = "
	|	ВЫБОР
	|		КОГДА Строки.АналитикаРасходов ССЫЛКА Справочник.Организации
	|			ТОГДА Строки.АналитикаРасходов
	|		КОГДА Строки.АналитикаРасходов ССЫЛКА Документ.АктВыполненныхРабот
	|			ТОГДА ВЫРАЗИТЬ(Строки.АналитикаРасходов КАК Документ.АктВыполненныхРабот).Организация
	|		КОГДА Строки.АналитикаРасходов ССЫЛКА Документ.ВводОстатков
	|			ТОГДА ВЫРАЗИТЬ(Строки.АналитикаРасходов КАК Документ.ВводОстатков).Организация
	|		КОГДА Строки.АналитикаРасходов ССЫЛКА Документ.ВводОстатковПрочиеРасходы
	|			ТОГДА ВЫРАЗИТЬ(Строки.АналитикаРасходов КАК Документ.ВводОстатковПрочиеРасходы).Организация
	|		КОГДА Строки.АналитикаРасходов ССЫЛКА Документ.ЗаказКлиента
	|			ТОГДА ВЫРАЗИТЬ(Строки.АналитикаРасходов КАК Документ.ЗаказКлиента).Организация
	|		КОГДА Строки.АналитикаРасходов ССЫЛКА Документ.ЗаказНаПеремещение
	|			ТОГДА ВЫРАЗИТЬ(Строки.АналитикаРасходов КАК Документ.ЗаказНаПеремещение).Организация
	|		КОГДА Строки.АналитикаРасходов ССЫЛКА Документ.ЗаказНаСборку
	|			ТОГДА ВЫРАЗИТЬ(Строки.АналитикаРасходов КАК Документ.ЗаказНаСборку).Организация
	|		КОГДА Строки.АналитикаРасходов ССЫЛКА Документ.ЗаказПоставщику
	|			ТОГДА ВЫРАЗИТЬ(Строки.АналитикаРасходов КАК Документ.ЗаказПоставщику).Организация
	|		КОГДА Строки.АналитикаРасходов ССЫЛКА Документ.ЗаявкаНаВозвратТоваровОтКлиента
	|			ТОГДА ВЫРАЗИТЬ(Строки.АналитикаРасходов КАК Документ.ЗаявкаНаВозвратТоваровОтКлиента).Организация
	|		КОГДА Строки.АналитикаРасходов ССЫЛКА Документ.ПередачаТоваровМеждуОрганизациями
	|			ТОГДА ВЫРАЗИТЬ(Строки.АналитикаРасходов КАК Документ.ПередачаТоваровМеждуОрганизациями).ОрганизацияПолучатель
	|		КОГДА Строки.АналитикаРасходов ССЫЛКА Документ.ПеремещениеТоваров
	|			ТОГДА ВЫРАЗИТЬ(Строки.АналитикаРасходов КАК Документ.ПеремещениеТоваров).Организация
	|		КОГДА Строки.АналитикаРасходов ССЫЛКА Документ.ПриобретениеТоваровУслуг
	|			ТОГДА ВЫРАЗИТЬ(Строки.АналитикаРасходов КАК Документ.ПриобретениеТоваровУслуг).Организация
	|		КОГДА Строки.АналитикаРасходов ССЫЛКА Документ.РеализацияТоваровУслуг
	|			ТОГДА ВЫРАЗИТЬ(Строки.АналитикаРасходов КАК Документ.РеализацияТоваровУслуг).Организация
	|		КОГДА Строки.АналитикаРасходов ССЫЛКА Документ.РеализацияУслугПрочихАктивов
	|			ТОГДА ВЫРАЗИТЬ(Строки.АналитикаРасходов КАК Документ.РеализацияУслугПрочихАктивов).Организация
	|		КОГДА Строки.АналитикаРасходов ССЫЛКА Документ.СборкаТоваров
	|			ТОГДА ВЫРАЗИТЬ(Строки.АналитикаРасходов КАК Документ.СборкаТоваров).Организация
	|		ИНАЧЕ НЕОПРЕДЕЛЕНО
	|	КОНЕЦ
	|";
	Если НЕ ПустаяСтрока(ИмяТаблицы) Тогда
		ТекстЗапроса = СтрЗаменить(ТекстЗапроса, "Строки", ИмяТаблицы);
	КонецЕсли;
	Возврат ТекстЗапроса;
	
КонецФункции

#Область ДляВызоваИзДругихПодсистем

// СтандартныеПодсистемы.УправлениеДоступом

// См. УправлениеДоступомПереопределяемый.ПриЗаполненииСписковСОграничениемДоступа.
Процедура ПриЗаполненииОграниченияДоступа(Ограничение) Экспорт

	Ограничение.Текст =
	"РазрешитьЧтениеИзменение
	|ГДЕ
	|	ЗначениеРазрешено(Организация)";

КонецПроцедуры

// Конец СтандартныеПодсистемы.УправлениеДоступом

#КонецОбласти

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

#Область ОбновлениеИнформационнойБазы

// Добавляет в список процедуры-обработчики обновления данных ИБ
// для всех поддерживаемых версий библиотеки или конфигурации.
// Вызывается перед началом обновления данных ИБ для построения плана обновления.
//
//  Обработчики - ТаблицаЗначений - описание полей, см. в процедуре
//                ОбновлениеИнформационнойБазы.НоваяТаблицаОбработчиковОбновления.
//
// Пример добавления процедуры-обработчика в список:
//  Обработчик = Обработчики.Добавить();
//  Обработчик.Версия              = "1.1.0.0";
//  Обработчик.Процедура           = "ОбновлениеИБ.ПерейтиНаВерсию_1_1_0_0";
//  Обработчик.МонопольныйРежим    = Ложь;
//
// Параметры:
// 	Обработчики - см. ОбновлениеИнформационнойБазы.НоваяТаблицаОбработчиковОбновления
//
Процедура ОписаниеОбработчиковОбновления(Обработчики) Экспорт

	Обработчик = Обработчики.Добавить();
	Обработчик.Процедура = "РегистрыНакопления.ПартииПрочихРасходов.ОбработатьДанныеДляПереходаНаНовуюВерсию";
    Обработчик.Версия = "3.5.4.400";
	Обработчик.РежимВыполнения = "Отложенно";
	Обработчик.Идентификатор = Новый УникальныйИдентификатор("4df8994b-9305-49ea-b2f0-f742bf1d9d37");
	Обработчик.ПроцедураЗаполненияДанныхОбновления = "РегистрыНакопления.ПартииПрочихРасходов.ЗарегистрироватьДанныеКОбработкеДляПереходаНаНовуюВерсию";
	Обработчик.ПроцедураПроверки = "ОбновлениеИнформационнойБазы.ДанныеОбновленыНаНовуюВерсиюПрограммы";
	Обработчик.Комментарий = НСтр("ru='Заполняет реквизит ""Хозяйственная операция"" в движениях ""Расход"" по регистру ""Партии прочих расходов"". До завершения обработчика в отчетах ""Расходы предприятия"" и ""Расходы организаций"" не будет заполняться показатель ""Распределено на себестоимость товаров"".';uk='Заповнює реквізит ""Господарська операція"" у рухах ""Розход"" за регістром ""Партії інших витрат"". До завершення обробника у звітах ""Витрати підприємства"" та ""Витрати організацій"" не буде заповнюватися показник ""Розподілено на собівартість товарів"".'");
	
	Читаемые = Новый Массив;
	Читаемые.Добавить(Метаданные.РегистрыНакопления.ПартииПрочихРасходов.ПолноеИмя());
	Обработчик.ЧитаемыеОбъекты = СтрСоединить(Читаемые, ",");
	
	Изменяемые = Новый Массив;
	Изменяемые.Добавить(Метаданные.РегистрыНакопления.ПартииПрочихРасходов.ПолноеИмя());
	Обработчик.ИзменяемыеОбъекты = СтрСоединить(Изменяемые, ",");
    
	Обработчик.ПриоритетыВыполнения = ОбновлениеИнформационнойБазы.ПриоритетыВыполненияОбработчика();

	НоваяСтрока = Обработчик.ПриоритетыВыполнения.Добавить();
	НоваяСтрока.Процедура = "РегистрыНакопления.ПрочиеАктивыПассивы.ОбработатьДанныеДляПереходаНаНовуюВерсию";
	НоваяСтрока.Порядок = "До";
    
КонецПроцедуры

// Параметры:
// 	Параметры - см. ОбновлениеИнформационнойБазы.ОсновныеПараметрыОтметкиКОбработке
//
Процедура ЗарегистрироватьДанныеКОбработкеДляПереходаНаНовуюВерсию(Параметры) Экспорт
    
    
	ДополнительныеПараметры = ОбновлениеИнформационнойБазы.ДополнительныеПараметрыОтметкиОбработки();
	ДополнительныеПараметры.ЭтоДвижения = Истина;
	ДополнительныеПараметры.ПолноеИмяРегистра = "РегистрНакопления.ПартииПрочихРасходов";
	
	Запрос = Новый Запрос("
	|ВЫБРАТЬ РАЗЛИЧНЫЕ
	|	ДанныеРегистра.Регистратор КАК Ссылка
	|ИЗ
	|	РегистрНакопления.ПартииПрочихРасходов КАК ДанныеРегистра
	|ГДЕ
	|	ДанныеРегистра.ВидДвижения = ЗНАЧЕНИЕ(ВидДвиженияНакопления.Расход)
	|	И ДанныеРегистра.ХозяйственнаяОперация = ЗНАЧЕНИЕ(Перечисление.ХозяйственныеОперации.ПустаяСсылка)
	|	И ДанныеРегистра.Регистратор = ДанныеРегистра.ДокументПоступленияРасходов
	|");
	
	Регистраторы = Запрос.Выполнить().Выгрузить().ВыгрузитьКолонку("Ссылка");
	
	ОбновлениеИнформационнойБазы.ОтметитьКОбработке(Параметры, Регистраторы, ДополнительныеПараметры);
    
КонецПроцедуры

Процедура ОбработатьДанныеДляПереходаНаНовуюВерсию(Параметры) Экспорт
    
	ПолноеИмяРегистра = "РегистрНакопления.ПартииПрочихРасходов";
	МетаданныеРегистра = Метаданные.РегистрыНакопления.ПартииПрочихРасходов;
	
	МенеджерВременныхТаблиц = Новый МенеджерВременныхТаблиц;
	
	ДополнительныеПараметры = ОбновлениеИнформационнойБазы.ДополнительныеПараметрыОтметкиОбработки();
	ДополнительныеПараметры.ЭтоДвижения = Истина;
	ДополнительныеПараметры.ПолноеИмяРегистра = ПолноеИмяРегистра;
	
	Выборка = ОбновлениеИнформационнойБазы.ВыбратьРегистраторыРегистраДляОбработки(Параметры.Очередь, Неопределено, ПолноеИмяРегистра);
    
	ТекстЗапроса = "
	|ВЫБРАТЬ
	|	Движения.Регистратор                 КАК Регистратор,
	|	Движения.Период                      КАК Период,
	|	Движения.ВидДвижения                 КАК ВидДвижения,
	|	Движения.Организация                 КАК Организация,
	|	Движения.Подразделение               КАК Подразделение,
	|	Движения.СтатьяРасходов              КАК СтатьяРасходов,
	|	Движения.АналитикаРасходов           КАК АналитикаРасходов,
	|	Движения.АналитикаАктивовПассивов    КАК АналитикаАктивовПассивов,
	|	Движения.ДокументПоступленияРасходов КАК ДокументПоступленияРасходов,
	|	Движения.АналитикаУчетаПартий        КАК АналитикаУчетаПартий,
	|	Движения.НаправлениеДеятельности     КАК НаправлениеДеятельности,
	|	Движения.АналитикаУчетаНоменклатуры  КАК АналитикаУчетаНоменклатуры,
    |	Движения.НалоговоеНазначение         КАК НалоговоеНазначение,
	|
	|	Движения.Стоимость                   КАК Стоимость,
	|	Движения.СтоимостьБезНДС             КАК СтоимостьБезНДС,
	|	Движения.СтоимостьРегл               КАК СтоимостьРегл,
	|	Движения.НДСРегл                     КАК НДСРегл,
	|	Движения.ПостояннаяРазница           КАК ПостояннаяРазница,
	|	Движения.ВременнаяРазница            КАК ВременнаяРазница,
	|	Движения.НДСУпр                      КАК НДСУпр,
	|
    |	Движения.НалоговоеНазначениеСписания КАК НалоговоеНазначениеСписания,
	|	Движения.ДокументРеализации         КАК ДокументРеализации,
	|	Движения.СтатьяОтраженияРасходов    КАК СтатьяОтраженияРасходов,
	|	Движения.АналитикаОтраженияРасходов КАК АналитикаОтраженияРасходов,
	|	Движения.РасчетПартий               КАК РасчетПартий,
	|	Движения.ПериодБазы                 КАК ПериодБазы,
	|	(ВЫБОР
	|		КОГДА Движения.ХозяйственнаяОперация = ЗНАЧЕНИЕ(Перечисление.ХозяйственныеОперации.ПустаяСсылка)
	|		 И Движения.ВидДвижения = ЗНАЧЕНИЕ(ВидДвиженияНакопления.Расход)
	|		 И Движения.Регистратор = Движения.ДокументПоступленияРасходов
	|			ТОГДА ЗНАЧЕНИЕ(Перечисление.ХозяйственныеОперации.РаспределениеРасходовНаСебестоимость)
	|		ИНАЧЕ Движения.ХозяйственнаяОперация КОНЕЦ) КАК ХозяйственнаяОперация
	|ИЗ
	|	РегистрНакопления.ПартииПрочихРасходов КАК Движения
	|ГДЕ
	|	Движения.Регистратор = &Регистратор
	|
	|УПОРЯДОЧИТЬ ПО
	|	НомерСтроки
	|";
	
	Пока Выборка.Следующий() Цикл
		
		Регистратор = Выборка.Регистратор;
		
		НачатьТранзакцию();
		Попытка
			Блокировка = Новый БлокировкаДанных;
			ЭлементБлокировки = Блокировка.Добавить(ПолноеИмяРегистра + ".НаборЗаписей");
			ЭлементБлокировки.УстановитьЗначение("Регистратор", Регистратор);
			ЭлементБлокировки.Режим = РежимБлокировкиДанных.Исключительный;

			Блокировка.Заблокировать();
			
			Запрос = Новый Запрос(ТекстЗапроса);
			Запрос.УстановитьПараметр("Регистратор", Регистратор);
			
			Набор = РегистрыНакопления.ПартииПрочихРасходов.СоздатьНаборЗаписей();
			Набор.Отбор.Регистратор.Установить(Регистратор);
			
			Результат = Запрос.Выполнить().Выгрузить();
			Если Результат.Количество() = 0 Тогда
				ОбновлениеИнформационнойБазы.ОтметитьВыполнениеОбработки(Регистратор, ДополнительныеПараметры);
				ЗафиксироватьТранзакцию();
				Продолжить;
			КонецЕсли;
			
			Набор.Загрузить(Результат);
			ОбновлениеИнформационнойБазы.ЗаписатьДанные(Набор);
			ЗафиксироватьТранзакцию();
		Исключение
			ОтменитьТранзакцию();
			ТекстСообщения = НСтр("ru='Не удалось обработать документ: %Регистратор% по причине: %Причина%';uk='Не вдалося обробити документ: %Регистратор% по причині: %Причина%'");
			ТекстСообщения = СтрЗаменить(ТекстСообщения, "%Регистратор%", Регистратор);
			ТекстСообщения = СтрЗаменить(ТекстСообщения, "%Причина%", ПодробноеПредставлениеОшибки(ИнформацияОбОшибке()));
			ЗаписьЖурналаРегистрации(ОбновлениеИнформационнойБазы.СобытиеЖурналаРегистрации(), УровеньЖурналаРегистрации.Ошибка,
				Регистратор.Метаданные(), ТекстСообщения);
		КонецПопытки;
	КонецЦикла;
    
    Параметры.ОбработкаЗавершена = Не ОбновлениеИнформационнойБазы.ЕстьДанныеДляОбработки(Параметры.Очередь, ПолноеИмяРегистра);
    
	
КонецПроцедуры

#КонецОбласти

#КонецОбласти

#КонецЕсли
