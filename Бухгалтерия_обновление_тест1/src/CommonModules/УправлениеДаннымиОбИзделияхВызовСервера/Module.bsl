////////////////////////////////////////////////////////////////////////////////
// НСИ производства: Процедуры подсистемы управления данными об изделиях
//
////////////////////////////////////////////////////////////////////////////////

#Область ПрограммныйИнтерфейс

#Область Спецификации

// Возвращает спецификацию изделия
//
// Параметры:
//  ДанныеОбИзделии             - Структура - см. УправлениеДаннымиОбИзделияхКлиентСервер.СтруктураДанныхОбИзделииДляВыбораСпецификации()
//  ПараметрыВыбораСпецификаций - Структура - см. УправлениеДаннымиОбИзделияхКлиентСервер.ПараметрыВыбораСпецификаций()
// 
// Возвращаемое значение:
//  Структура, Неопределено - содержит данные спецификации изделия.
//
Функция СпецификацияИзделия(ДанныеОбИзделии, ПараметрыВыбораСпецификаций) Экспорт
	
	ДанныеСпецификации = Неопределено;
	
	СписокСпецификаций = УправлениеДаннымиОбИзделиях.СпецификацииИзделия(ДанныеОбИзделии, ПараметрыВыбораСпецификаций);
	
	Для Индекс = 0 По СписокСпецификаций.ВГраница() Цикл
		
		Если ДанныеСпецификации = Неопределено И СписокСпецификаций[Индекс].ПодбираетсяАвтоматически = Истина Тогда
			ДанныеСпецификации = СписокСпецификаций[Индекс];
			Если НЕ ЗначениеЗаполнено(ДанныеОбИзделии.ТекущаяСпецификация) Тогда
				Прервать;
			КонецЕсли;
		КонецЕсли;
		
		Если СписокСпецификаций[Индекс].Спецификация = ДанныеОбИзделии.ТекущаяСпецификация Тогда
			ДанныеСпецификации = СписокСпецификаций[Индекс];
			Прервать;
		КонецЕсли;
		
	КонецЦикла;
	
	Возврат ДанныеСпецификации;
	
КонецФункции

// Копирует спецификацию и этапы
//
// Параметры:
//  Источник	- СправочникСсылка.РесурсныеСпецификации - спецификация, которую нужно скопировать.
//
// Возвращаемое значение:
//   СправочникСсылка.РесурсныеСпецификации   - копия спецификации.
//
Функция КопироватьРесурснуюСпецификацию(Источник) Экспорт

	НачатьТранзакцию();
	Попытка
		
		СсылкаНового = Справочники.РесурсныеСпецификации.ПолучитьСсылку();
		
		Объект = Источник.Скопировать();
		Объект.Наименование = Объект.Наименование + " " + НСтр("ru='(копия)';uk='(копія)'");
		
		Если НЕ ЗаполнитьЭтапыПоРесурснойСпецификации(Объект, Источник, СсылкаНового) Тогда
			
			ОтменитьТранзакцию();
			Возврат Неопределено;
			
		КонецЕсли;
		
		
		Объект.УстановитьСсылкуНового(СсылкаНового);
		Объект.Записать();
		
		ЗафиксироватьТранзакцию();
	Исключение
		
		ОтменитьТранзакцию();
		Возврат Неопределено;
		
	КонецПопытки;
	
	Возврат Объект.Ссылка;
	
КонецФункции

#КонецОбласти


#КонецОбласти

#Область СлужебныеПроцедурыИФункции

Процедура РесурсныеСпецификацииОбработкаПолученияДанныхВыбора(ДанныеВыбора, Параметры, СтандартнаяОбработка) Экспорт
	
	Если Параметры.Свойство("ПолучитьСпецификацииПоНоменклатуре") И Параметры.Свойство("Номенклатура") Тогда
		
		СтандартнаяОбработка = Ложь;
		ДанныеВыбора = Новый СписокЗначений;
		
		ДанныеОбИзделии = УправлениеДаннымиОбИзделияхКлиентСервер.СтруктураДанныхОбИзделииДляВыбораСпецификации();
		ЗаполнитьЗначенияСвойств(ДанныеОбИзделии, Параметры);
		
		Список = УправлениеДаннымиОбИзделиях.СписокСпецификацийПоНоменклатуре(ДанныеОбИзделии, Параметры);
		ДанныеВыбора.ЗагрузитьЗначения(Список);
		
	КонецЕсли; 
	
КонецПроцедуры

Процедура РесурсныеСпецификацииОбработкаПолученияФормы(ВидФормы, Параметры, ВыбраннаяФорма, СтандартнаяОбработка) Экспорт

	Если ВидФормы = "ФормаВыбора" И Параметры.Свойство("ПолучитьСпецификацииПоНоменклатуре") И Параметры.Свойство("Номенклатура") Тогда
		ВыбраннаяФорма = "ФормаВыбораПоНоменклатуре";
		СтандартнаяОбработка = Ложь;
	КонецЕсли;

КонецПроцедуры

Функция УстановитьСтатусСпецификаций(ВыделенныеСсылки, ЗначениеСтатуса) Экспорт

	НовыйСтатус = Перечисления.СтатусыСпецификаций[ЗначениеСтатуса];
	
	Запрос = Новый Запрос;
	Запрос.Текст = 
	"ВЫБРАТЬ РАЗРЕШЕННЫЕ
	|	РесурсныеСпецификации.Ссылка,
	|	РесурсныеСпецификации.Наименование,
	|	РесурсныеСпецификации.ПометкаУдаления
	|ИЗ
	|	Справочник.РесурсныеСпецификации КАК РесурсныеСпецификации
	|ГДЕ
	|	РесурсныеСпецификации.Статус <> &НовыйСтатус
	|	И РесурсныеСпецификации.Ссылка В(&ВыделенныеСсылки)";
	
	Запрос.УстановитьПараметр("ВыделенныеСсылки", ВыделенныеСсылки);
	Запрос.УстановитьПараметр("НовыйСтатус",      НовыйСтатус);
	
	Результат = Запрос.Выполнить();
	Выборка = Результат.Выбрать();
	
	КоличествоОбработанных = 0;
	ОчередьКРасчету = Новый Массив;
	
	Если НовыйСтатус = Перечисления.СтатусыСпецификаций.ВРазработке Тогда
		АдресХранилища = ПоместитьВоВременноеХранилище(Неопределено);
	КонецЕсли;
	
	Пока Выборка.Следующий() Цикл
		
		Если Выборка.ПометкаУдаления Тогда
			ТекстСообщения = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(
									НСтр("ru='Нельзя изменить статус помеченной на удаление спецификации ""%1"".';uk='Не можна змінити статус позначеної на вилучення специфікації ""%1"".'"),
									Выборка.Наименование);
									
			ОбщегоНазначенияКлиентСервер.СообщитьПользователю(ТекстСообщения, Выборка.Ссылка); 
			Продолжить;
		КонецЕсли;
		
		СпрОбъект = Выборка.Ссылка.ПолучитьОбъект();
		
		НачатьТранзакцию();
		
		Попытка
			
			Если НовыйСтатус = Перечисления.СтатусыСпецификаций.ВРазработке Тогда
				ПараметрыПроверки = Новый Структура("Объект", Выборка.Ссылка);
				Справочники.РесурсныеСпецификации.ПроверитьИспользованиеОбъекта(ПараметрыПроверки, АдресХранилища);
				ЕстьСсылки = ПолучитьИзВременногоХранилища(АдресХранилища);
				Если ЕстьСсылки Тогда
					ТекстСообщения = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(
											НСтр("ru='Спецификация ""%1"" используется. Установка статуса ""В разработке"" допускается только в форме спецификации.';uk='Специфікація ""%1"" використовується. Встановлення статусу ""В розробці"" допускається тільки у формі специфікації.'"),
											СпрОбъект.Наименование);
											
					ОбщегоНазначенияКлиентСервер.СообщитьПользователю(ТекстСообщения, Выборка.Ссылка); 
					ОтменитьТранзакцию();
					Продолжить;
				КонецЕсли;
			КонецЕсли; 
			
			СпрОбъект.Статус = НовыйСтатус;
			СпрОбъект.ДополнительныеСвойства.Вставить("ПроверитьЭтапы");
			СпрОбъект.ДополнительныеСвойства.Вставить("ЗапретитьРасчетДлительностиПроизводства");
			Если СпрОбъект.ПроверитьЗаполнение() Тогда
				СпрОбъект.Записать();
				КоличествоОбработанных = КоличествоОбработанных + 1;
				Если НовыйСтатус = Перечисления.СтатусыСпецификаций.Действует Тогда
					ОчередьКРасчету.Добавить(Выборка.Ссылка);
				КонецЕсли;
			КонецЕсли;
			ЗафиксироватьТранзакцию();
		Исключение
			ОтменитьТранзакцию();
		КонецПопытки;
		
	КонецЦикла;
	
	РегистрыСведений.ЗаданияКРасчетуДлительностиПроизводства.ЗапуститьЗадание();
	
	Возврат КоличествоОбработанных;

КонецФункции

Функция ЗаполнитьЭтапыПоРесурснойСпецификации(Приемник, Источник, СсылкаПриемника)

	Запрос = Новый Запрос(
	// 0
	"ВЫБРАТЬ
	|	РесурсныеСпецификацииВыходныеИзделия.ВидНоменклатуры КАК ВидНоменклатуры,
	|	РесурсныеСпецификацииВыходныеИзделия.Номенклатура КАК Номенклатура,
	|	РесурсныеСпецификацииВыходныеИзделия.Характеристика КАК Характеристика,
	|	РесурсныеСпецификацииВыходныеИзделия.Упаковка КАК Упаковка,
	|	РесурсныеСпецификацииВыходныеИзделия.КоличествоУпаковок КАК КоличествоУпаковок,
	|
	|	РесурсныеСпецификацииВыходныеИзделия.ДоляСтоимости КАК ДоляСтоимости,
	|
	|	РесурсныеСпецификацииВыходныеИзделия.ОбработатьПоСпецификации КАК ОбработатьПоСпецификации,
	|	РесурсныеСпецификацииВыходныеИзделия.Спецификация КАК Спецификация,
	|
	|	РесурсныеСпецификацииВыходныеИзделия.ЭтапРедактирование КАК ЭтапРедактирование,
	|
	|	РесурсныеСпецификацииВыходныеИзделия.ПроцентБрака КАК ПроцентБрака,
	|
	|	РесурсныеСпецификацииВыходныеИзделия.СпособАвтовыбораНоменклатуры КАК СпособАвтовыбораНоменклатуры,
	|	РесурсныеСпецификацииВыходныеИзделия.СпособАвтовыбораХарактеристики КАК СпособАвтовыбораХарактеристики,
	|	РесурсныеСпецификацииВыходныеИзделия.АлгоритмАвтовыбораХарактеристики КАК АлгоритмАвтовыбораХарактеристики,
	|	РесурсныеСпецификацииВыходныеИзделия.СвойствоСодержащееНоменклатуру КАК СвойствоСодержащееНоменклатуру,
	|	РесурсныеСпецификацииВыходныеИзделия.АлгоритмРасчетаКоличества КАК АлгоритмРасчетаКоличества,
	|
	|	РесурсныеСпецификацииВыходныеИзделия.КлючСвязи КАК КлючСвязи
	|
	|ИЗ
	|	Справочник.РесурсныеСпецификации.ВыходныеИзделия КАК РесурсныеСпецификацииВыходныеИзделия
	|ГДЕ
	|	РесурсныеСпецификацииВыходныеИзделия.Ссылка = &Источник
	|
	|УПОРЯДОЧИТЬ ПО
	|	РесурсныеСпецификацииВыходныеИзделия.НомерСтроки
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	// 1
	|ВЫБРАТЬ
	|	РесурсныеСпецификацииВозвратныеОтходы.Номенклатура КАК Номенклатура,
	|	РесурсныеСпецификацииВозвратныеОтходы.Характеристика КАК Характеристика,
	|	РесурсныеСпецификацииВозвратныеОтходы.Упаковка КАК Упаковка,
	|	РесурсныеСпецификацииВозвратныеОтходы.КоличествоУпаковок КАК КоличествоУпаковок,
	|
	|	РесурсныеСпецификацииВозвратныеОтходы.СтатьяКалькуляции КАК СтатьяКалькуляции,
	|
	|	РесурсныеСпецификацииВозвратныеОтходы.ОбработатьПоСпецификации КАК ОбработатьПоСпецификации,
	|	РесурсныеСпецификацииВозвратныеОтходы.Спецификация КАК Спецификация,
	|
	|	РесурсныеСпецификацииВозвратныеОтходы.ЭтапРедактирование КАК ЭтапРедактирование,
	|
	|	РесурсныеСпецификацииВозвратныеОтходы.ОписаниеИзделия КАК ОписаниеИзделия,
	|
	|	РесурсныеСпецификацииВозвратныеОтходы.СпособАвтовыбораНоменклатуры КАК СпособАвтовыбораНоменклатуры,
	|	РесурсныеСпецификацииВозвратныеОтходы.СпособАвтовыбораХарактеристики КАК СпособАвтовыбораХарактеристики,
	|	РесурсныеСпецификацииВозвратныеОтходы.АлгоритмАвтовыбораХарактеристики КАК АлгоритмАвтовыбораХарактеристики,
	|	РесурсныеСпецификацииВозвратныеОтходы.СвойствоСодержащееНоменклатуру КАК СвойствоСодержащееНоменклатуру,
	|	РесурсныеСпецификацииВозвратныеОтходы.АлгоритмРасчетаКоличества КАК АлгоритмРасчетаКоличества,
	|
	|	РесурсныеСпецификацииВозвратныеОтходы.КлючСвязи КАК КлючСвязи
	|ИЗ
	|	Справочник.РесурсныеСпецификации.ВозвратныеОтходы КАК РесурсныеСпецификацииВозвратныеОтходы
	|ГДЕ
	|	РесурсныеСпецификацииВозвратныеОтходы.Ссылка = &Источник
	|
	|УПОРЯДОЧИТЬ ПО
	|	РесурсныеСпецификацииВозвратныеОтходы.НомерСтроки
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	// 2
	|ВЫБРАТЬ
	|	РесурсныеСпецификацииМатериалыИУслуги.Номенклатура КАК Номенклатура,
	|	РесурсныеСпецификацииМатериалыИУслуги.Характеристика КАК Характеристика,
	|	РесурсныеСпецификацииМатериалыИУслуги.Упаковка КАК Упаковка,
	|	РесурсныеСпецификацииМатериалыИУслуги.КоличествоУпаковок КАК КоличествоУпаковок,
	|
	|	РесурсныеСпецификацииМатериалыИУслуги.СтатьяКалькуляции КАК СтатьяКалькуляции,
	|
	|	РесурсныеСпецификацииМатериалыИУслуги.СпособПолученияМатериала КАК СпособПолученияМатериала,
	|	РесурсныеСпецификацииМатериалыИУслуги.ИсточникПолученияПолуфабриката КАК ИсточникПолученияПолуфабриката,
	|	РесурсныеСпецификацииМатериалыИУслуги.ПроизводитсяВПроцессе КАК ПроизводитсяВПроцессе,
	|
	|	РесурсныеСпецификацииМатериалыИУслуги.ПланироватьНеРанее КАК ПланироватьНеРанее,
	|	РесурсныеСпецификацииМатериалыИУслуги.СпецификацияРемонта КАК СпецификацияРемонта,
	|
	|	РесурсныеСпецификацииМатериалыИУслуги.ЭтапРедактирование КАК ЭтапРедактирование,
	|
	|	РесурсныеСпецификацииМатериалыИУслуги.ПрименениеМатериала КАК ПрименениеМатериала,
	|	РесурсныеСпецификацииМатериалыИУслуги.Альтернативный КАК Альтернативный,
	|	РесурсныеСпецификацииМатериалыИУслуги.Вероятность КАК Вероятность,
	|
	|	РесурсныеСпецификацииМатериалыИУслуги.СпособАвтовыбораНоменклатуры КАК СпособАвтовыбораНоменклатуры,
	|	РесурсныеСпецификацииМатериалыИУслуги.СпособАвтовыбораХарактеристики КАК СпособАвтовыбораХарактеристики,
	|	РесурсныеСпецификацииМатериалыИУслуги.АлгоритмАвтовыбораХарактеристики КАК АлгоритмАвтовыбораХарактеристики,
	|	РесурсныеСпецификацииМатериалыИУслуги.СвойствоСодержащееНоменклатуру КАК СвойствоСодержащееНоменклатуру,
	|	РесурсныеСпецификацииМатериалыИУслуги.АлгоритмРасчетаКоличества КАК АлгоритмРасчетаКоличества,
	|
	|	РесурсныеСпецификацииМатериалыИУслуги.КлючСвязи КАК КлючСвязи
	|
	|ИЗ
	|	Справочник.РесурсныеСпецификации.МатериалыИУслуги КАК РесурсныеСпецификацииМатериалыИУслуги
	|ГДЕ
	|	РесурсныеСпецификацииМатериалыИУслуги.Ссылка = &Источник
	|
	|УПОРЯДОЧИТЬ ПО
	|	РесурсныеСпецификацииМатериалыИУслуги.НомерСтроки
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	// 3
	|ВЫБРАТЬ
	|	РесурсныеСпецификацииТрудозатраты.ВидРабот КАК ВидРабот,
	|	РесурсныеСпецификацииТрудозатраты.Количество КАК Количество,
	|
	|	РесурсныеСпецификацииТрудозатраты.СтатьяКалькуляции КАК СтатьяКалькуляции,
	|
	|	РесурсныеСпецификацииТрудозатраты.ЭтапРедактирование КАК ЭтапРедактирование,
	|
	|	РесурсныеСпецификацииТрудозатраты.НазначениеРабот КАК НазначениеРабот,
	|
	|	РесурсныеСпецификацииТрудозатраты.АлгоритмРасчетаКоличества КАК АлгоритмРасчетаКоличества,
	|
	|	РесурсныеСпецификацииТрудозатраты.КлючСвязи КАК КлючСвязи
	|ИЗ
	|	Справочник.РесурсныеСпецификации.Трудозатраты КАК РесурсныеСпецификацииТрудозатраты
	|ГДЕ
	|	РесурсныеСпецификацииТрудозатраты.Ссылка = &Источник
	|
	|УПОРЯДОЧИТЬ ПО
	|	РесурсныеСпецификацииТрудозатраты.НомерСтроки
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	// 4
	|ВЫБРАТЬ
	|	СправочникЭтапыПроизводства.Ссылка КАК Ссылка,
	|	СправочникЭтапыПроизводства.НомерЭтапа КАК НомерЭтапа,
	|	СправочникЭтапыПроизводства.НомерСледующегоЭтапа КАК НомерСледующегоЭтапа
	|ИЗ
	|	Справочник.ЭтапыПроизводства КАК СправочникЭтапыПроизводства
	|ГДЕ
	|	СправочникЭтапыПроизводства.Владелец = &Источник
	|	И НЕ СправочникЭтапыПроизводства.ПометкаУдаления");
	
	Запрос.УстановитьПараметр("Источник", Источник);
	
	Результат = Запрос.ВыполнитьПакет();
	
	Приемник.ВыходныеИзделия.Загрузить(Результат[0].Выгрузить());
	Приемник.ВозвратныеОтходы.Загрузить(Результат[1].Выгрузить());
	Приемник.МатериалыИУслуги.Загрузить(Результат[2].Выгрузить());
	Приемник.Трудозатраты.Загрузить(Результат[3].Выгрузить());
	
	Выборка = Результат[4].Выбрать();
	
	Пока Выборка.Следующий() Цикл
		
		ЭтапОбъект = Выборка.Ссылка.Скопировать();
		ЭтапОбъект.Владелец = СсылкаПриемника;
		ЭтапОбъект.НомерЭтапа = Выборка.НомерЭтапа;
		ЭтапОбъект.НомерСледующегоЭтапа = Выборка.НомерСледующегоЭтапа;
		
		ЭтапОбъект.ОбменДанными.Загрузка = Истина;
		
		Попытка
			
			ЭтапОбъект.Записать();
			
		Исключение
			
			Возврат Ложь;
			
		КонецПопытки;
		
		ВыполнитьЗаменуСсылокВКоллекции(Приемник.ВыходныеИзделия,  "ЭтапРедактирование", Выборка.Ссылка, ЭтапОбъект.Ссылка);
		ВыполнитьЗаменуСсылокВКоллекции(Приемник.ВозвратныеОтходы, "ЭтапРедактирование", Выборка.Ссылка, ЭтапОбъект.Ссылка);
		
		ВыполнитьЗаменуСсылокВКоллекции(Приемник.МатериалыИУслуги, "ЭтапРедактирование",             Выборка.Ссылка, ЭтапОбъект.Ссылка);
		ВыполнитьЗаменуСсылокВКоллекции(Приемник.МатериалыИУслуги, "ИсточникПолученияПолуфабриката", Выборка.Ссылка, ЭтапОбъект.Ссылка);
		ВыполнитьЗаменуСсылокВКоллекции(Приемник.МатериалыИУслуги, "ПланироватьНеРанее",             Выборка.Ссылка, ЭтапОбъект.Ссылка);
		
		ВыполнитьЗаменуСсылокВКоллекции(Приемник.Трудозатраты,     "ЭтапРедактирование", Выборка.Ссылка, ЭтапОбъект.Ссылка);
		
		Если Приемник.ОсновноеИзделиеЭтап = Выборка.Ссылка Тогда
			Приемник.ОсновноеИзделиеЭтап = ЭтапОбъект.Ссылка;
		КонецЕсли;
		
	КонецЦикла;
	
	Возврат Истина;
	
КонецФункции

Процедура ВыполнитьЗаменуСсылокВКоллекции(Коллекция, ИмяПоля, Ссылка, НоваяСсылка)
	
	Отбор = Новый Структура(ИмяПоля, Ссылка);
	
	НайденныеСтроки = Коллекция.НайтиСтроки(Отбор);
	
	Для каждого НайденнаяСтрока Из НайденныеСтроки Цикл
		
		НайденнаяСтрока[ИмяПоля] = НоваяСсылка;
		
	КонецЦикла;
	
КонецПроцедуры


#КонецОбласти
