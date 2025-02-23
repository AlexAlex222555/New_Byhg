
#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	Если Параметры.Свойство("АвтоТест") Тогда // Возврат при получении формы для анализа.
		Возврат;
	КонецЕсли;

	РазрешитьРедактированиеНастройкаАдресногоХранения                             = Истина;
	РазрешитьРедактированиеИспользоватьОрдернуюСхемуПриОтгрузке                   = Истина;
	РазрешитьРедактированиеИспользоватьОрдернуюСхемуПриПоступлении                = Истина;
	РазрешитьРедактированиеИспользоватьСкладскиеПомещения                         = Истина;
	РазрешитьРедактированиеИспользоватьОрдернуюСхемуПриОформленииИзлишковНедостач = Истина;
	РазрешитьРедактированиеТипСклада                                              = Истина;
	РазрешитьРедактированиеРодитель                                               = Истина;
	РазрешитьРедактированиеРозничныйВидЦены                                       = Истина;
	РазрешитьИспользоватьСтатусыПриходныхОрдеров                                  = Истина;
	РазрешитьИспользоватьСтатусыРасходныхОрдеров                                  = Истина;
	РазрешитьРедактированиеДатаНачалаОрдернойСхемыПриОтгрузке                     = Истина;
	РазрешитьРедактированиеДатаНачалаОрдернойСхемыПриПоступлении                  = Истина;
	РазрешитьРедактированиеДатаНачалаОрдернойСхемыПриОтраженииИзлишковНедостач    = Истина;
	РазрешитьРедактированиеДатаНачалаИспользованияСкладскихПомещений              = Истина;
	РазрешитьРедактированиеДатаНачалаАдресногоХраненияОстатков                    = Истина;
	РазрешитьРедактированиеЦеховойКладовой                                        = Истина;
	РазрешитьРедактированиеПодразделения                                          = Истина;
	
	МассивЭлементов = Новый Массив;
	МассивЭлементов.Добавить("РазрешитьРедактированиеТипСклада");
	МассивЭлементов.Добавить("РазрешитьРедактированиеРозничныйВидЦены");
	МассивЭлементов.Добавить("ОписаниеТипСклада");
	МассивЭлементов.Добавить("ОписаниеРозничныйВидЦены");
	
	ОбщегоНазначенияУТКлиентСервер.УстановитьСвойствоЭлементовФормы(Элементы,
		"РазрешитьРедактированиеТипСклада,
		|РазрешитьРедактированиеРозничныйВидЦены,
		|ОписаниеТипСклада,
		|ОписаниеРозничныйВидЦены",
		"Видимость",
		ПолучитьФункциональнуюОпцию("ИспользоватьРозничныеПродажи"));
	
	ИспользоватьОрдерныеСклады = ПолучитьФункциональнуюОпцию("ИспользоватьОрдерныеСклады");
	Для Каждого Элемент Из Элементы.ГруппаЗависимыеОтОрдернойСхемы.ПодчиненныеЭлементы Цикл
		Элемент.Видимость = ИспользоватьОрдерныеСклады;
	КонецЦикла;

	Если НЕ ПолучитьФункциональнуюОпцию("УправлениеПредприятием") Тогда
		Элементы.ОписаниеЦеховаяКладовая.Видимость = Ложь;
	//++ НЕ УТ
	ИначеЕсли НЕ ПолучитьФункциональнуюОпцию("ИспользоватьУправлениеПроизводством2_2") Тогда
		Элементы.ОписаниеЦеховаяКладовая.Видимость = Ложь;
		Элементы.РазрешитьРедактированиеЦеховуюКладовую.Видимость = Ложь;
	//-- НЕ УТ
	КонецЕсли; 
	
	СобытияФорм.ПриСозданииНаСервере(ЭтаФорма, Отказ, СтандартнаяОбработка);

КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

#Область Прочее

&НаКлиенте
Процедура РазрешитьРедактирование(Команда)

	Результат = Новый Массив;
	Если РазрешитьРедактированиеИспользоватьОрдернуюСхемуПриОтгрузке Тогда
		Результат.Добавить("ИспользоватьОрдернуюСхемуПриОтгрузке");
	КонецЕсли;

	Если РазрешитьРедактированиеИспользоватьОрдернуюСхемуПриПоступлении Тогда
		Результат.Добавить("ИспользоватьОрдернуюСхемуПриПоступлении");
	КонецЕсли;
	
	Если РазрешитьРедактированиеИспользоватьСкладскиеПомещения Тогда
		Результат.Добавить("ИспользоватьСкладскиеПомещения");
	КонецЕсли;
	
	Если РазрешитьРедактированиеНастройкаАдресногоХранения Тогда
		Результат.Добавить("НастройкаАдресногоХранения");
	КонецЕсли;

	Если РазрешитьРедактированиеИспользоватьОрдернуюСхемуПриОформленииИзлишковНедостач Тогда
		Результат.Добавить("ИспользоватьОрдернуюСхемуПриОтраженииИзлишковНедостач");
	КонецЕсли;
	
	Если РазрешитьРедактированиеТипСклада Тогда
		Результат.Добавить("ТипСклада");
	КонецЕсли;
	
	Если РазрешитьРедактированиеРодитель Тогда
		Результат.Добавить("Родитель");
	КонецЕсли;
	
	Если РазрешитьИспользоватьСтатусыПриходныхОрдеров Тогда
		Результат.Добавить("ИспользоватьСтатусыПриходныхОрдеров");
	КонецЕсли;
	
	Если РазрешитьИспользоватьСтатусыРасходныхОрдеров Тогда
		Результат.Добавить("ИспользоватьСтатусыРасходныхОрдеров");
	КонецЕсли;
	
	Если РазрешитьРедактированиеРозничныйВидЦены Тогда
		Результат.Добавить("РозничныйВидЦены");
	КонецЕсли;
	
	Если РазрешитьРедактированиеДатаНачалаОрдернойСхемыПриОтгрузке Тогда
		Результат.Добавить("ДатаНачалаОрдернойСхемыПриОтгрузке");
	КонецЕсли;
	
	Если РазрешитьРедактированиеДатаНачалаОрдернойСхемыПриПоступлении Тогда
		Результат.Добавить("ДатаНачалаОрдернойСхемыПриПоступлении");
	КонецЕсли;
	
	Если РазрешитьРедактированиеДатаНачалаОрдернойСхемыПриОтраженииИзлишковНедостач Тогда
		Результат.Добавить("ДатаНачалаОрдернойСхемыПриОтраженииИзлишковНедостач");
	КонецЕсли;
	
	Если РазрешитьРедактированиеДатаНачалаИспользованияСкладскихПомещений Тогда
		Результат.Добавить("ДатаНачалаИспользованияСкладскихПомещений");
	КонецЕсли;
	
	Если РазрешитьРедактированиеДатаНачалаАдресногоХраненияОстатков Тогда
		Результат.Добавить("ДатаНачалаАдресногоХраненияОстатков");
	КонецЕсли;
	
	//++ НЕ УТ
	Если РазрешитьРедактированиеЦеховойКладовой Тогда
		Результат.Добавить("ЦеховаяКладовая");
	КонецЕсли;
	//-- НЕ УТ
	
	Если РазрешитьРедактированиеПодразделения Тогда
		Результат.Добавить("Подразделение");
	КонецЕсли;
	
	Закрыть(Результат);

КонецПроцедуры

#КонецОбласти

&НаКлиенте
Процедура Подключаемый_ВыполнитьПереопределяемуюКоманду(Команда)
	
	СобытияФормКлиент.ВыполнитьПереопределяемуюКоманду(ЭтаФорма, Команда);
	
КонецПроцедуры

#КонецОбласти
