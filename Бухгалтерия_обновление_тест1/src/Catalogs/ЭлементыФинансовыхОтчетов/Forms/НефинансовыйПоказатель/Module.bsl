
#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	Если Параметры.Свойство("АвтоТест") Тогда // Возврат при получении формы для анализа.
		Возврат;
	КонецЕсли;
	
	Справочники.ЭлементыФинансовыхОтчетов.ФормаПриСозданииНаСервере(ЭтотОбъект);
	ИдентификаторГлавногоХранилища = Параметры.ИдентификаторГлавногоХранилища;
	
	Если Параметры.Свойство("ПроизвольныйПоказатель") Тогда
		Заголовок = НСтр("ru='Операнд: %1 %2';uk='Операнд: %1 %2'");
	Иначе
		Заголовок = "%1 %2";
	КонецЕсли;
	
	Заголовок = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(Заголовок,
		Строка(Параметры.ВидЭлемента),
		Строка(НефинансовыйПоказатель));

	Элементы.НастройкаСмещенияПериода.Заголовок = БюджетнаяОтчетностьКлиентСервер.ПредставлениеСмещения(ЭтотОбъект);
	
	РеквизитыОбъекта = ОбщегоНазначения.ЗначенияРеквизитовОбъекта(НефинансовыйПоказатель, "ПоОрганизациям, ПоПодразделениям, ПоСценариям");
	Если Не РеквизитыОбъекта.ПоОрганизациям Тогда
		Элементы.ИспользоватьФильтрПоОрганизация.Видимость = Ложь;
	КонецЕсли;
	Если Не РеквизитыОбъекта.ПоПодразделениям Тогда
		Элементы.ИспользоватьФильтрПоПодразделение.Видимость = Ложь;
	КонецЕсли;
	Если Не РеквизитыОбъекта.ПоСценариям Тогда
		Элементы.ИспользоватьФильтрПоСценарий.Видимость = Ложь;
	КонецЕсли;
	
	ПривилегированныйРежимПереключатель = Число(ПривилегированныйРежим);
	
	СобытияФорм.ПриСозданииНаСервере(ЭтотОбъект, Отказ, СтандартнаяОбработка);
	
КонецПроцедуры

&НаСервере
Процедура ПередЗаписьюНаСервере(Отказ, ТекущийОбъект, ПараметрыЗаписи)
	
	Справочники.ЭлементыФинансовыхОтчетов.ФормаПередЗаписьюНаСервере(ЭтотОбъект, ТекущийОбъект, Отказ);
	
КонецПроцедуры

&НаКлиенте
Процедура ПередЗакрытием(Отказ, СтандартнаяОбработка)
	
	Если ЗначениеЗаполнено(АдресЭлементаВХранилище) Тогда
		СтандартнаяОбработка = Ложь;
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовШапкиФормы

&НаКлиенте
Процедура КомментарийНачалоВыбора(Элемент, ДанныеВыбора, СтандартнаяОбработка)
	
	ОбщегоНазначенияКлиент.ПоказатьФормуРедактированияКомментария(
		Элемент.ТекстРедактирования, 
		ЭтотОбъект, 
		"Объект.Комментарий");
	
КонецПроцедуры

&НаКлиенте
Процедура НастройкаСмещенияПериодаНажатие(Элемент)
	
	ОписаниеОповещения = Новый ОписаниеОповещения("УстановитьПериодСмещения", ЭтотОбъект);
	ПараметрыСмещения = БюджетнаяОтчетностьКлиентСервер.ПараметрыОткрытияФормыНастройкиПериода(ЭтотОбъект);
	ПараметрыСмещения.Вставить("НефинансовыйПоказатель", Истина);
	
	ОткрытьФорму("Справочник.ЭлементыФинансовыхОтчетов.Форма.НастройкаПериодаИсточникаДанных",
		ПараметрыСмещения,,,,,ОписаниеОповещения);
	
КонецПроцедуры

&НаКлиенте
Процедура НеИспользоватьФильтрПриИзменении(Элемент)
	
	УстановитьОтборНаСервере();
	
КонецПроцедуры

&НаКлиенте
Процедура ПривилегированныйРежимПереключательПриИзменении(Элемент)
	
	ПривилегированныйРежим = Булево(ПривилегированныйРежимПереключатель);
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура ЗавершитьРедактирование(Команда)
	
	ФинансоваяОтчетностьКлиент.ЗавершитьРедактированиеЭлементаОтчета(ЭтотОбъект);
	
КонецПроцедуры

&НаКлиенте
Процедура Подключаемый_ВыполнитьПереопределяемуюКоманду(Команда)
	
	СобытияФормКлиент.ВыполнитьПереопределяемуюКоманду(ЭтотОбъект, Команда);
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаКлиенте
Процедура УстановитьПериодСмещения(Результат, ДополнительныеПараметры) Экспорт
	
	БюджетнаяОтчетностьКлиент.УстановитьПериодСмещения(Объект, ЭтотОбъект, Результат);
	
КонецПроцедуры

&НаСервере
Процедура УстановитьОтборНаСервере()
	
	Справочники.ЭлементыФинансовыхОтчетов.УстановитьНастройкиОтбора(ЭтотОбъект,
		Компоновщик,
		Объект.ВидЭлемента,
		Компоновщик.Настройки);
	
КонецПроцедуры

#КонецОбласти

