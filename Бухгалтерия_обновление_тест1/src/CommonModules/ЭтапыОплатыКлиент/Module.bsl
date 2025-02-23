
////////////////////////////////////////////////////////////////////////////////
// Модуль "ЭтапыОплатыКлиент" содержит процедуры и функции для 
// работы пользователя с таблицей этапов оплаты,
// оповещения пользователя о заполнении этапов оплаты.
//
////////////////////////////////////////////////////////////////////////////////

#Область ПрограммныйИнтерфейс

#Область ПроцедурыИФункцииЗаполненияЭтаповОплаты

// Стандартный обработчик события "ПриИзменении" поля "ЭтапыГрафикаОплатыПроцентПлатежа".
//
// Параметры:
// ТекущиеДанные          - ДанныеФормыЭлементКоллекции - строка с текущими данными таблицы этапов оплаты
// ЭтапыГрафикаОплаты     - ДанныеФормыКоллекция - таблица этапов оплаты
// СуммаОплатыПоДокументу - Число - сумма оплаты документа.
//
Процедура ЭтапыГрафикаОплатыПроцентПлатежаПриИзменении(ТекущиеДанные, ЭтапыГрафикаОплаты, Знач СуммаОплатыПоДокументу) Экспорт
	
	Если ТекущиеДанные.ПроцентПлатежа > 0 И ЭтапыГрафикаОплаты.Итог("ПроцентПлатежа") = 100 Тогда
		
		СуммаПлатежа = 0;
		Для Каждого ТекСтрока Из ЭтапыГрафикаОплаты Цикл
			Если ТекСтрока.НомерСтроки <> ТекущиеДанные.НомерСтроки Тогда
				СуммаПлатежа = СуммаПлатежа + ТекСтрока.СуммаПлатежа;
			КонецЕсли;
		КонецЦикла;
		
		ТекущиеДанные.СуммаПлатежа = СуммаОплатыПоДокументу - СуммаПлатежа;
	Иначе
		
		ТекущиеДанные.СуммаПлатежа = СуммаОплатыПоДокументу * ТекущиеДанные.ПроцентПлатежа / 100;
		
	КонецЕсли;
	
	Если ТекущиеДанные.Свойство("СуммаВзаиморасчетов") Тогда
		ТекущиеДанные.СуммаВзаиморасчетов = 0;
	КонецЕсли;
	
КонецПроцедуры

// Стандартный обработчик события "ПриИзменении" поля "ЭтапыГрафикаОплатыСуммаПлатежа".
//
// Параметры:
// ТекущиеДанные          - ДанныеФормыЭлементКоллекции - строка с текущими данными таблицы этапов оплаты
// ЭтапыГрафикаОплаты     - ДанныеФормыКоллекция - таблица этапов оплаты
// СуммаОплатыПоДокументу - Число - сумма оплаты документа.
//
Процедура ЭтапыГрафикаОплатыСуммаПлатежаПриИзменении(ТекущиеДанные, ЭтапыГрафикаОплаты, Знач СуммаОплатыПоДокументу) Экспорт
	
	Если СуммаОплатыПоДокументу <> 0 Тогда
		
		Если ТекущиеДанные.СуммаПлатежа <> 0 И
			ЭтапыГрафикаОплаты.Итог("СуммаПлатежа") = СуммаОплатыПоДокументу Тогда
			
			ПроцентПлатежа = 0;
			Для Каждого ТекСтрока Из ЭтапыГрафикаОплаты Цикл
				Если ТекСтрока.НомерСтроки <> ТекущиеДанные.НомерСтроки Тогда
					ПроцентПлатежа = ПроцентПлатежа + ТекСтрока.ПроцентПлатежа;
				КонецЕсли;
			КонецЦикла;
			
			ТекущиеДанные.ПроцентПлатежа = 100 - ПроцентПлатежа;
			
		Иначе
			ТекущиеДанные.ПроцентПлатежа = ТекущиеДанные.СуммаПлатежа * 100 / СуммаОплатыПоДокументу;
		КонецЕсли;
	КонецЕсли;
	
	Если ТекущиеДанные.Свойство("СуммаВзаиморасчетов") Тогда
		ТекущиеДанные.СуммаВзаиморасчетов = 0;
	КонецЕсли;
	
КонецПроцедуры

// Стандартный обработчик события "ПриИзменении" поля "ЭтапыГрафикаОплатыПроцентЗалогаЗаТару".
//
// Параметры:
// ТекущиеДанные          - ДанныеФормыЭлементКоллекции - строка с текущими данными таблицы этапов оплаты
// ЭтапыГрафикаОплаты     - ДанныеФормыКоллекция - таблица этапов оплаты
// СуммаЗалогаПоДокументу - Число - сумма залога за тару по документу.
//
Процедура ЭтапыГрафикаОплатыПроцентЗалогаЗаТаруПриИзменении(ТекущиеДанные, ЭтапыГрафикаОплаты, Знач СуммаЗалогаПоДокументу) Экспорт
	
	Если ТекущиеДанные.ПроцентЗалогаЗаТару > 0 И ЭтапыГрафикаОплаты.Итог("ПроцентЗалогаЗаТару") = 100 Тогда
		
		СуммаЗалогаЗаТару = 0;
		Для Каждого ТекСтрока Из ЭтапыГрафикаОплаты Цикл
			Если ТекСтрока.НомерСтроки <> ТекущиеДанные.НомерСтроки Тогда
				СуммаЗалогаЗаТару = СуммаЗалогаЗаТару + ТекСтрока.СуммаЗалогаЗаТару;
			КонецЕсли;
		КонецЦикла;
		
		ТекущиеДанные.СуммаЗалогаЗаТару = СуммаЗалогаПоДокументу - СуммаЗалогаЗаТару;
	Иначе
		
		ТекущиеДанные.СуммаЗалогаЗаТару = СуммаЗалогаПоДокументу * ТекущиеДанные.ПроцентЗалогаЗаТару / 100;
		
	КонецЕсли;
	
	Если ТекущиеДанные.Свойство("СуммаВзаиморасчетов") Тогда
		ТекущиеДанные.СуммаВзаиморасчетов = 0;
	КонецЕсли;
	
КонецПроцедуры

// Стандартный обработчик события "ПриИзменении" поля "ЭтапыГрафикаОплатыСуммаЗалогаЗаТару".
//
// Параметры:
// ТекущиеДанные          - ДанныеФормыЭлементКоллекции - строка с текущими данными таблицы этапов оплаты
// ЭтапыГрафикаОплаты     - ДанныеФормыКоллекция - таблица этапов оплаты
// СуммаЗалогаПоДокументу - Число - сумма залога за тару по документу.
//
Процедура ЭтапыГрафикаОплатыСуммаЗалогаЗаТаруПриИзменении(ТекущиеДанные, ЭтапыГрафикаОплаты, Знач СуммаЗалогаПоДокументу) Экспорт
	
	Если СуммаЗалогаПоДокументу <> 0 Тогда
		
		Если ТекущиеДанные.СуммаЗалогаЗаТару <> 0 И
			ЭтапыГрафикаОплаты.Итог("СуммаЗалогаЗаТару") = СуммаЗалогаПоДокументу Тогда
			
			ПроцентЗалогаЗаТару = 0;
			Для Каждого ТекСтрока Из ЭтапыГрафикаОплаты Цикл
				Если ТекСтрока.НомерСтроки <> ТекущиеДанные.НомерСтроки Тогда
					ПроцентЗалогаЗаТару = ПроцентЗалогаЗаТару + ТекСтрока.ПроцентЗалогаЗаТару;
				КонецЕсли;
			КонецЦикла;
			
			ТекущиеДанные.ПроцентЗалогаЗаТару = 100 - ПроцентЗалогаЗаТару;
			
		Иначе
			ТекущиеДанные.ПроцентЗалогаЗаТару = ТекущиеДанные.СуммаЗалогаЗаТару * 100 / СуммаЗалогаПоДокументу;
		КонецЕсли;
	КонецЕсли;
	
	Если ТекущиеДанные.Свойство("СуммаВзаиморасчетов") Тогда
		ТекущиеДанные.СуммаВзаиморасчетов = 0;
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Область ПроцедурыОповещенияПользователяОВыполненныхДействиях

// Показывает оповещение пользователя об окончании заполнения этапов графика оплаты.
//
Процедура ОповеститьОбОкончанииЗаполненияЭтаповГрафикаОплаты() Экспорт

	ПоказатьОповещениеПользователя(
		НСтр("ru='Этапы оплаты заполнены';uk='Етапи оплати заповнені'"),
		,
		НСтр("ru='Этапы графика оплаты заполнены';uk='Етапи графіка оплати заповнені'"),
		БиблиотекаКартинок.Информация32);

КонецПроцедуры

// Показывает оповещение пользователя о невозможности заполнения этапов графика оплаты.
//
Процедура ОповеститьОНевозможностиЗаполненияЭтаповГрафикаОплаты() Экспорт

	ПоказатьОповещениеПользователя(
		НСтр("ru='Этапы оплаты очищены';uk='Етапи оплати очищені'"),
		,
		НСтр("ru='Сумма неотмененных строк заказа нулевая. Таблица этапов оплаты очищена';uk='Сума нескасованих рядків замовлення нульова. Таблиця етапів оплати очищена'"),
		БиблиотекаКартинок.Информация32);

КонецПроцедуры

#КонецОбласти

#КонецОбласти
