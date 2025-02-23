#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда
	
#Область ОбработчикиСобытий
	
Процедура ПередЗаписью(Отказ)

	Если ОбменДанными.Загрузка Тогда
		Возврат;
	КонецЕсли;

	Если Не ПометкаУдаления И Не ДополнительныеСвойства.Свойство("ТолькоОбновлениеНаименования") Тогда
		ПроверитьДублиЭлемента(Отказ);
	КонецЕсли;
	
	// Установим наименование которое будет использоваться для отображения элемента
	Наименование = Справочники.НоменклатураГТД.ПолучитьНаименование(ЭтотОбъект);

КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

Процедура ПроверитьДублиЭлемента(Отказ)
	
	УстановитьПривилегированныйРежим(Истина);
	
	ТекстЗапроса = 
	"ВЫБРАТЬ ПЕРВЫЕ 1
	|	НоменклатураГТД.Ссылка КАК Ссылка
	|ИЗ
	|	Справочник.НоменклатураГТД КАК НоменклатураГТД
	|ГДЕ
	|	НоменклатураГТД.Ссылка <> &Ссылка
	|	И НЕ НоменклатураГТД.ПометкаУдаления
	|	И НоменклатураГТД.Владелец = &Владелец
	|	И НоменклатураГТД.КодУКТВЭД = &КодУКТВЭД
	|	И НоменклатураГТД.НомерГТД = &НомерГТД";
	
	Запрос = Новый Запрос(ТекстЗапроса);
	Запрос.УстановитьПараметр("Ссылка", Ссылка);
	Запрос.УстановитьПараметр("Владелец", Владелец);
	Запрос.УстановитьПараметр("КодУКТВЭД", КодУКТВЭД);
	Запрос.УстановитьПараметр("НомерГТД", НомерГТД);
	
	Результат = Запрос.Выполнить();
	Выборка = Результат.Выбрать();
	Если Выборка.Следующий() Тогда
		
		Текст = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(
			НСтр("ru='Аналогичный код УКТВЭД и номер ГТД уже существует у товара %1';uk='Аналогічний код УКТЗЕД та номер ВМД вже існує у товару %1'"),
			Владелец
		);
		ОбщегоНазначенияКлиентСервер.СообщитьПользователю(
			Текст,
			ЭтотОбъект,
			, // Поле
			,
			Отказ
		);
		
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#КонецЕсли
