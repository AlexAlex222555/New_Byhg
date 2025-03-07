#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область СлужебныйПрограммныйИнтерфейс

// Метод устанавливает признак необходимости создания начислений для записи вида отпуска.
//  Параметры: 
//		СоздаватьНачисления - булево, если Истина, то начисления будут созданы.
//
Процедура УстановитьНеобходимостьСоздаватьНачислениеОтпуска(СоздаватьНачисления) Экспорт
	ДополнительныеСвойства.Вставить("СоздаватьНачислениеОтпуска", СоздаватьНачисления);
КонецПроцедуры

// Метод устанавливает признак необходимости создания только начислений компенсации отпуска при записи вида отпуска.
//  Параметры: 
//		СоздаватьНачисления - булево, если Истина, то начисления будут созданы.
//
Процедура УстановитьНеобходимостьСоздаватьНачислениеКомпенсацииОтпуска(СоздаватьНачисления) Экспорт
	ДополнительныеСвойства.Вставить("СоздаватьНачислениеКомпенсацииОтпуска", СоздаватьНачисления);
КонецПроцедуры
	
#КонецОбласти

#Область ОбработчикиСобытий

Процедура ПередЗаписью(Отказ)
	ДополнительныеСвойства.Вставить("ЭтоНовый", ЭтоНовый());
КонецПроцедуры

Процедура ПриЗаписи(Отказ)
	
	Если ЗарплатаКадры.ОтключитьБизнесЛогикуПриЗаписи(ЭтотОбъект) Тогда
		Возврат;
	КонецЕсли;
	
	Если НеобходимоСоздаватьНачисления() Тогда
		
		УстановитьПривилегированныйРежим(Истина);
		
		ПланыВидовРасчета.Начисления.СоздатьНачисленияОтпускаИКомпенсации(Новый Структура("НачальнаяНастройкаПрограммы", Ложь), Ссылка, Наименование, НеобходимоСоздаватьНачислениеОтпуска(), НеобходимоСоздаватьНачислениеКомпенсацииОтпуска());
		УстановитьПривилегированныйРежим(Ложь);
		
	КонецЕсли;
	
КонецПроцедуры

Процедура ОбработкаПроверкиЗаполнения(Отказ, ПроверяемыеРеквизиты)
	
	Если ОтпускБезОплаты Тогда
		ОбщегоНазначенияКлиентСервер.УдалитьЗначениеИзМассива(ПроверяемыеРеквизиты, "СпособРасчетаОтпуска");
	КонецЕсли;
	
	Если НЕ ХарактерЗависимостиДнейОтпуска = ПредопределенноеЗначение("Перечисление.ХарактерЗависимостиКоличестваДнейОтпуска.НеЗависит") Тогда
		ОбщегоНазначенияКлиентСервер.УдалитьЗначениеИзМассива(ПроверяемыеРеквизиты, "КоличествоДнейВГод");
	КонецЕсли;
	
	Если Недействителен И ОбщегоНазначения.ЗначениеРеквизитаОбъекта(Ссылка,"Недействителен") = Ложь Тогда
		ПроверитьАктуальностьОтпуска(Отказ);
	КонецЕсли;
	
	Если НЕ ХарактерЗависимостиДнейОтпуска = ПредопределенноеЗначение("Перечисление.ХарактерЗависимостиКоличестваДнейОтпуска.ЗависитОтСтажа") Тогда
		ОбщегоНазначенияКлиентСервер.УдалитьЗначениеИзМассива(ПроверяемыеРеквизиты, "ВидСтажа");
	КонецЕсли;
	
КонецПроцедуры

Процедура ПриКопировании(ОбъектКопирования)
	
	Если ОбъектКопирования.Предопределенный Тогда
		ОтпускЯвляетсяЕжегодным 			= Неопределено;
		СпособРасчетаОтпуска 				= Неопределено;
		ПредоставлятьОтпускВсемСотрудникам 	= Неопределено;
		КоличествоДнейВГод 					= Неопределено;
		ОтпускБезОплаты 					= Неопределено;
		Недействителен 						= Ложь;
		ОсновнойОтпуск 						= Ложь;
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

Функция НеобходимоСоздаватьНачисления()
		
	Возврат Не Предопределенный 
			И (НеобходимоСоздаватьНачислениеОтпуска() 
				Или НеобходимоСоздаватьНачислениеКомпенсацииОтпуска());
	
КонецФункции 

Функция НеобходимоСоздаватьНачислениеОтпуска()
	
	 СоздаватьНачисление = ЗаписанНовыйОбъект() И Не ЭтотОбъект.ПредоставлятьОтпускВсемГигСпециалистам;
	
	Если ДополнительныеСвойства.Свойство("СоздаватьНачислениеОтпуска") Тогда
		СоздаватьНачисление = ДополнительныеСвойства.СоздаватьНачислениеОтпуска И Не ЭтотОбъект.ПредоставлятьОтпускВсемГигСпециалистам;
	КонецЕсли;
	
	Возврат СоздаватьНачисление;
	
КонецФункции 

Функция НеобходимоСоздаватьНачислениеКомпенсацииОтпуска()
	
	СоздаватьНачисление = ЗаписанНовыйОбъект() И ЭтотОбъект.ОтпускЯвляетсяЕжегодным И Не ОтпускБезОплаты И Не ЭтотОбъект.ПредоставлятьОтпускВсемГигСпециалистам;
	
	Если ДополнительныеСвойства.Свойство("СоздаватьНачислениеКомпенсацииОтпуска") Тогда
		СоздаватьНачисление = ДополнительныеСвойства.СоздаватьНачислениеКомпенсацииОтпуска И Не ЭтотОбъект.ПредоставлятьОтпускВсемГигСпециалистам;
	КонецЕсли;
	
	Возврат СоздаватьНачисление;
	

	
КонецФункции 

Функция ЗаписанНовыйОбъект()
	
	ЗаписанНовыйОбъект = Ложь;
	
	Если ДополнительныеСвойства.Свойство("ЭтоНовый") Тогда
		ЗаписанНовыйОбъект = ДополнительныеСвойства.ЭтоНовый;
	КонецЕсли;
	
	Возврат ЗаписанНовыйОбъект;
	
КонецФункции 

// Проверяет наличие актуальных позиций штатного расписания, использующих данный вид отпуска
//	и положенных видов отпусков сотрудников, в случае наличия таковых - устанавливает Отказ = Истина
//	и выводит предепреждения пользователю.
Процедура ПроверитьАктуальностьОтпуска(Отказ)
	
	Запрос = Новый Запрос;
	
	Если ПолучитьФункциональнуюОпцию("ИспользоватьШтатноеРасписание") Тогда
		Запрос.Текст = Запрос.Текст + "
		|ВЫБРАТЬ
		|	ШтатноеРасписание.Наименование КАК ПозицияШтатногоРасписания,
		|	ШтатноеРасписание.Ссылка Как Ссылка
		|ИЗ
		|	Справочник.ШтатноеРасписание.ЕжегодныеОтпуска КАК ШтатноеРасписаниеЕжегодныеОтпуска
		|		ЛЕВОЕ СОЕДИНЕНИЕ Справочник.ШтатноеРасписание КАК ШтатноеРасписание
		|		ПО ШтатноеРасписаниеЕжегодныеОтпуска.Ссылка = ШтатноеРасписание.Ссылка
		|ГДЕ
		|	ШтатноеРасписаниеЕжегодныеОтпуска.ВидЕжегодногоОтпуска = &Ссылка
		|	И НЕ ШтатноеРасписание.ПометкаУдаления
		|	И ШтатноеРасписание.Утверждена
		|	И НЕ ШтатноеРасписание.Закрыта
		|;
		|////////////////////////////////////////////////////////////////////////////////";
	КонецЕсли;
	
	Запрос.Текст = Запрос.Текст + "
		|ВЫБРАТЬ
		|	ПоложенныеВидыЕжегодныхОтпусковСрезПоследних.Сотрудник Как Ссылка,
		|	ПРЕДСТАВЛЕНИЕССЫЛКИ(ПоложенныеВидыЕжегодныхОтпусковСрезПоследних.Сотрудник) КАК СотрудникНаименование
		|ИЗ
		|	РегистрСведений.ПоложенныеВидыЕжегодныхОтпусков.СрезПоследних(&Дата, ВидЕжегодногоОтпуска = &Ссылка) КАК ПоложенныеВидыЕжегодныхОтпусковСрезПоследних";
	
	Запрос.УстановитьПараметр("Дата", ТекущаяДатаСеанса());
	Запрос.УстановитьПараметр("Ссылка", Ссылка);
	
	РезультатыЗапроса = Запрос.ВыполнитьПакет();
	ВыводитьСообщениеОбОшибке = Ложь;
	
	Для каждого РезультатЗапроса Из РезультатыЗапроса Цикл
		Если НЕ РезультатЗапроса.Пустой() Тогда
			Отказ = Истина;
			ВыводитьСообщениеОбОшибке = Истина;
		КонецЕсли;
	КонецЦикла; 
	
	Если ВыводитьСообщениеОбОшибке Тогда
		
		ТекстСообщения = НСтр("ru='Нельзя сделать недействительным вид отпуска,
        | который связан с актуальными правами на отпуск сотрудников или используется в действующей позиции штатного расписания.'
        |;uk='Неможна зробити недійсним вид відпустки,
        |який пов''язаний з актуальними правами на відпустку співробітників або використовується в чинній позиції штатного розкладу.'");
		ОбщегоНазначенияКлиентСервер.СообщитьПользователю(ТекстСообщения, Ссылка, , , Отказ);	
		
		Выборка = РезультатыЗапроса[РезультатыЗапроса.Количество()-1].Выбрать();
		Пока Выборка.Следующий() Цикл
			ТекстСообщения = НСтр("ru='- право на отпуск сотрудника ""%1""';uk='- право на відпустку співробітника ""%1""'");
			ТекстСообщения = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(
				ТекстСообщения,
				Выборка.СотрудникНаименование);
	        ОбщегоНазначенияКлиентСервер.СообщитьПользователю(ТекстСообщения, Ссылка, "Объект.Недействителен" , , Отказ);
		КонецЦикла;	
		
		Если ПолучитьФункциональнуюОпцию("ИспользоватьШтатноеРасписание") Тогда
		
			Выборка = РезультатыЗапроса[РезультатыЗапроса.Количество()-2].Выбрать();
			Пока Выборка.Следующий() Цикл
				ТекстСообщения = НСтр("ru='- позиция штатного расписания ""%1""';uk='- позиція штатного розкладу ""%1""'");
				ТекстСообщения = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(
				ТекстСообщения,
				Выборка.ПозицияШтатногоРасписания);
				ОбщегоНазначенияКлиентСервер.СообщитьПользователю(ТекстСообщения, Ссылка, "Объект.Недействителен" , , Отказ);
			КонецЦикла;
			
		КонецЕсли;
		
	КонецЕсли;
			
КонецПроцедуры

#КонецОбласти

#КонецЕсли
