#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ОбработчикиСобытий

Процедура ОбработкаПроверкиЗаполнения(Отказ, ПроверяемыеРеквизиты)
	
	Если РасчетЗарплатыРасширенныйКлиентСервер.СпособРасчетаИспользуетФормулу(СпособРасчета) Тогда
		ЭтоЛьгота = КатегорияНачисленияИлиНеоплаченногоВремени = Перечисления.КатегорииНачисленийИНеоплаченногоВремени.Льгота;
		УчитываетсяПриРасчете = Не ЭтоЛьгота Или (ЭтоЛьгота И ЛьготаУчитываетсяПриРасчетеЗарплаты);
		Если Не ЗначениеЗаполнено(ФормулаРасчета) И Рассчитывается И УчитываетсяПриРасчете Тогда 
			ТекстСообщения = НСтр("ru='Поле ""Формула расчета"" не заполнено';uk='Поле ""Формула розрахунку"" не заповнено'");
			ОбщегоНазначенияКлиентСервер.СообщитьПользователю(ТекстСообщения, , "ФормулаНеЗаполненаТекст", , Отказ);
		КонецЕсли;	
	КонецЕсли;
	
	Если СпособВыполненияНачисления = Перечисления.СпособыВыполненияНачислений.ВЗаданныхМесяцахПриОкончательномРасчете
		И МесяцыНачисления.Количество() = 0 Тогда
		ТекстОшибки = НСтр("ru='Не выбрано ни одного месяца, в котором выполняется начисление.';uk='Не вибрано жодного місяця, в якому здійснюється нарахування.'");
		ОбщегоНазначенияКлиентСервер.СообщитьПользователю(ТекстОшибки, , , , Отказ);
	КонецЕсли;
	
	// Проверка показателей в формуле расчета.
	Если КатегорияНачисленияИлиНеоплаченногоВремени = Перечисления.КатегорииНачисленийИНеоплаченногоВремени.ДоплатаЗаСовмещение Тогда
		ЕстьРазмерДоплатыЗаСовмещение = Ложь;
		РазмерДоплатыЗаСовмещение = ОбщегоНазначенияКлиентСервер.ПредопределенныйЭлемент("Справочник.ПоказателиРасчетаЗарплаты.РазмерДоплатыЗаСовмещение");
		Если РазмерДоплатыЗаСовмещение <> Неопределено Тогда
			ЕстьРазмерДоплатыЗаСовмещение = Показатели.Найти(РазмерДоплатыЗаСовмещение, "Показатель") <> Неопределено;
		КонецЕсли;
		Если Не ЕстьРазмерДоплатыЗаСовмещение Тогда
			ТекстОшибки = НСтр("ru='Формула вида расчета с назначением «Доплата за совмещение» должна содержать показатель «РазмерДоплатыЗаСовмещение».';uk='Формула виду розрахунку з призначенням ""Доплата за суміщення"" повинна містити показник «РазмерДоплатыЗаСовмещение».'");
			ОбщегоНазначенияКлиентСервер.СообщитьПользователю(ТекстОшибки, , , , Отказ);
		КонецЕсли;
	КонецЕсли;
	
	СвойстваНачислений = ПланыВидовРасчета.Начисления.СвойстваНачисленийПоКатегориям();
	СвойстваНачисления = СвойстваНачислений[КатегорияНачисленияИлиНеоплаченногоВремени];
	
	// Если есть показатель расчета времени, то должен быть заполнен вид времени.
	Если РасчетЗарплатыРасширенныйКлиентСервер.СпособРасчетаИспользуетФормулу(СпособРасчета) Тогда
		Если СвойстваНачисления.НедоступныеСвойства.Найти("ОбозначениеВТабелеУчетаРабочегоВремени") = Неопределено 
			И Не ЗначениеЗаполнено(ОбозначениеВТабелеУчетаРабочегоВремени) Тогда
			ПоказателиРасчетаВремени = Новый Массив;
			ПоказателиРасчетаВремени.Добавить(ОбщегоНазначенияКлиентСервер.ПредопределенныйЭлемент("Справочник.ПоказателиРасчетаЗарплаты.ВремяВДнях"));
			ПоказателиРасчетаВремени.Добавить(ОбщегоНазначенияКлиентСервер.ПредопределенныйЭлемент("Справочник.ПоказателиРасчетаЗарплаты.ВремяВЧасах"));
			ПоказателиРасчетаВремени.Добавить(ОбщегоНазначенияКлиентСервер.ПредопределенныйЭлемент("Справочник.ПоказателиРасчетаЗарплаты.ВремяВДняхЧасах"));
			Для Каждого СтрокаПоказателя Из Показатели Цикл
				Если ПоказателиРасчетаВремени.Найти(СтрокаПоказателя.Показатель) <> Неопределено Тогда
					ТекстОшибки = НСтр("ru='Не заполнен вид по классификатору рабочего времени.';uk='Не заповнений вид за класифікатором робочого часу.'");
					ОбщегоНазначенияКлиентСервер.СообщитьПользователю(ТекстОшибки, , "Объект.ОбозначениеВТабелеУчетаРабочегоВремени", , Отказ);
					Прервать;
				КонецЕсли;
			КонецЦикла;
		КонецЕсли;
	КонецЕсли;
	
	Если СвойстваНачисления.НедоступныеСвойства.Найти("ВидОтпуска") <> Неопределено Тогда
		// Если ВидОтпуска недоступен для редактирования, то не значит, что он не заполняется.
		ОбщегоНазначенияКлиентСервер.УдалитьЗначениеИзМассива(ПроверяемыеРеквизиты, "ВидОтпуска");
	КонецЕсли;
	
	Если КатегорияНачисленияИлиНеоплаченногоВремени = Перечисления.КатегорииНачисленийИНеоплаченногоВремени.РайонныйКоэффициент
		Или КатегорияНачисленияИлиНеоплаченногоВремени = Перечисления.КатегорииНачисленийИНеоплаченногоВремени.СевернаяНадбавка Тогда
		РасчетЗарплаты.ПроверитьУникальностьНачисленияПоКатегории(Ссылка, КатегорияНачисленияИлиНеоплаченногоВремени, Отказ);
	КонецЕсли;
	
	Если КатегорияНачисленияИлиНеоплаченногоВремени = Перечисления.КатегорииНачисленийИНеоплаченногоВремени.ОплатаПредыдущимиДокументами Тогда
		РасчетЗарплаты.ПроверитьУникальностьНачисленияПоКатегории(Ссылка, КатегорияНачисленияИлиНеоплаченногоВремени, Отказ);
	КонецЕсли;
	
	КатегорииПоСвойствам = ПланыВидовРасчета.Начисления.КатегорииПоСвойствамНачислений();
	
	// Коды дохода не заполняются для отдельных категорий.
	Если КатегорииПоСвойствам.КодДоходаНДФЛНеЗаполняется.Найти(КатегорияНачисленияИлиНеоплаченногоВремени) <> Неопределено Тогда
		ОбщегоНазначенияКлиентСервер.УдалитьЗначениеИзМассива(ПроверяемыеРеквизиты, "КодДоходаНДФЛ");
	КонецЕсли;
	
	ПроверитьЗачетНормыВремениВытесняющих(Отказ);
	
	// Базовые начисления этих категорий недоступны для редактирования пользователю, 
	// поэтому не проверяем
	БазовыеНачисленияНеПроверяются = Новый Массив;
	БазовыеНачисленияНеПроверяются.Добавить(Перечисления.КатегорииНачисленийИНеоплаченногоВремени.ДоплатаДоСреднегоЗаработка);
	БазовыеНачисленияНеПроверяются.Добавить(Перечисления.КатегорииНачисленийИНеоплаченногоВремени.ДоплатаДоСреднегоЗаработкаЗаДниБолезни);
	БазовыеНачисленияНеПроверяются.Добавить(Перечисления.КатегорииНачисленийИНеоплаченногоВремени.ДоплатаДоДенежногоСодержанияЗаДниБолезни);
	Если БазовыеНачисленияНеПроверяются.Найти(КатегорияНачисленияИлиНеоплаченногоВремени) = Неопределено Тогда
		РасчетЗарплатыРасширенный.ПроверитьНаличиеБазовыхВидовРасчета(ЭтотОбъект, Отказ);
	КонецЕсли;
	
	Если Не РасчетЗарплатыРасширенный.НачислениеВыполняетсяВЦеломЗаМесяц(ЭтотОбъект)  
		И РасчетЗарплатыРасширенный.ЕстьПоказательВКоллекции(Показатели, "РасчетнаяБазаСтраховыеВзносы") Тогда 
		ТекстСообщения = НСтр("ru='Показатель РасчетнаяБазаСтраховыеВзносы допустимо использовать только в начислениях, выполняемых в целом за месяц.';uk='Показник РасчетнаяБазаСтраховыеВзносы допустимо використовувати тільки в нарахуваннях, що виконуються в цілому за місяць.'");
		ОбщегоНазначенияКлиентСервер.СообщитьПользователю(ТекстСообщения, , "Объект.ФормулаРасчета", , Отказ);
	КонецЕсли;
	
	Если СпособВыполненияНачисления = Перечисления.СпособыВыполненияНачислений.ПоЗначениюПоказателяПриОкончательномРасчете Тогда 
		СтрокаОпределяющийПоказатель = Показатели.Найти(Истина, "ОпределяющийПоказатель");
		Если СтрокаОпределяющийПоказатель = Неопределено Тогда 
			ТекстСообщения = НСтр("ru='Не отмечено ни одного показателя.';uk='Не відмічено жодного показника.'");
	        ОбщегоНазначенияКлиентСервер.СообщитьПользователю(ТекстСообщения, , "СписокОпределяющихПоказателей", , Отказ);
		КонецЕсли;
	КонецЕсли;
	
	Если ВАрхиве И ОбщегоНазначения.ЗначениеРеквизитаОбъекта(Ссылка,"ВАрхиве") = Ложь Тогда
		ПроверитьАктуальностьВидаРасчета(Отказ);
	КонецЕсли;
	
	Если ПериодРасчетаБазовыхНачислений <> Перечисления.ПериодыРасчетаБазовыхНачислений.НесколькоПредыдущихМесяцев Тогда
		ОбщегоНазначенияКлиентСервер.УдалитьЗначениеИзМассива(ПроверяемыеРеквизиты, "СдвигБазовогоПериода");
	КонецЕсли;
	
КонецПроцедуры

Процедура ПередЗаписью(Отказ)
	
	Если ЗарплатаКадры.ОтключитьБизнесЛогикуПриЗаписи(ЭтотОбъект) И Не ДополнительныеСвойства.Свойство("ИзменениеПланаВидовРасчетаПоНастройкам") Тогда
		Возврат;
	КонецЕсли;
	
	ФОТНеРедактируется = РасчетЗарплатыРасширенный.ФОТРассчитываетсяАвтоматически(ЭтотОбъект);
	
	Если СпособВыполненияНачисления <> Перечисления.СпособыВыполненияНачислений.ПоОтдельномуДокументуДоОкончательногоРасчета Тогда
		ВидДокументаНачисления = Перечисления.ВидыДокументовНачисления.ПустаяСсылка();
	КонецЕсли;
	
	// Заполнение вторичных данных объекта выполняется всегда.
	ЗарплатаКадрыРасширенный.ОбновитьПоказателиФормулыРасчета(ЭтотОбъект, Отказ);
	РасчетЗарплатыРасширенный.ЗаполнитьИнформациюОПоказателяхВидаРасчета(ЭтотОбъект);
	РасчетЗарплатыРасширенный.ЗаполнитьИнформациюОбУчетеВремени(ЭтотОбъект);
	РасчетЗарплатыРасширенный.ЗаполнитьИнформациюОбУчетеСреднегоЗаработка(ЭтотОбъект);
	
	ЭтотОбъект.НачисляетсяВЦеломЗаМесяц = РасчетЗарплатыРасширенный.НачислениеВыполняетсяВЦеломЗаМесяц(ЭтотОбъект);

	Если ЗначениеЗаполнено(ОбозначениеВТабелеУчетаРабочегоВремени) 
		И ВидыВремени.Найти(ОбозначениеВТабелеУчетаРабочегоВремени, "ВидВремени") = Неопределено Тогда
		ВидыВремени.Добавить().ВидВремени = ОбозначениеВТабелеУчетаРабочегоВремени;
	КонецЕсли;
	
	
	ОтражениеЗарплатыВБухучетеРасширенный.УточнитьСтратегиюОтраженияВУчетеНачисления(ЭтотОбъект);
	ОтражениеЗарплатыВБухучетеРасширенный.УточнитьВидОперацииПоЗарплатеНачисления(ЭтотОбъект);
	ОтражениеЗарплатыВБухучетеРасширенный.УстановитьОчередностьОтраженияВУчете(ЭтотОбъект);
	
	Если ОбщегоНазначения.ПодсистемаСуществует("ЗарплатаКадрыКорпоративнаяПодсистемы.ЛьготыСотрудников") Тогда 
		Модуль = ОбщегоНазначения.ОбщийМодуль("ЛьготыСотрудников");
		Модуль.ПередЗаписьюНачисления(ЭтотОбъект);
	КонецЕсли;
	
	Если ПланыВидовРасчета.Начисления.КатегорииНачисленийВнутреннихСовместителейИПодработок().Найти(КатегорияНачисленияИлиНеоплаченногоВремени) <> Неопределено Тогда
		ДублироватьДляВнутреннихСовместителейИПодработок = Истина;
	Иначе
		ДублироватьДляВнутреннихСовместителейИПодработок = Ложь;
	КонецЕсли;
	
	Если Не ДублироватьДляВнутреннихСовместителейИПодработок
		И ПланыВидовРасчета.Начисления.КатегорииНачисленийПодработок().Найти(КатегорияНачисленияИлиНеоплаченногоВремени) <> Неопределено Тогда
		ДублироватьДляПодработок = Истина;
	Иначе
		ДублироватьДляПодработок = Ложь;
	КонецЕсли;
	
	Если Не РасчетЗарплатыРасширенный.РазрешенВводНесколькихПлановыхНачислений(КатегорияНачисленияИлиНеоплаченногоВремени, СпособВыполненияНачисления) Тогда 
		ПоддерживаетНесколькоПлановыхНачислений = Ложь;
	КонецЕсли;
	
	Если КатегорияНачисленияИлиНеоплаченногоВремени = Перечисления.КатегорииНачисленийИНеоплаченногоВремени.ДоплатаЗаСовмещение Тогда 
		РазмерДоплатыЗаСовмещение = ОбщегоНазначенияКлиентСервер.ПредопределенныйЭлемент("Справочник.ПоказателиРасчетаЗарплаты.РазмерДоплатыЗаСовмещение");
		НайденныеСтроки = ЭтотОбъект.Показатели.НайтиСтроки(Новый Структура("Показатель", РазмерДоплатыЗаСовмещение));
		Для Каждого СтрокаПоказателя Из НайденныеСтроки Цикл 
			СтрокаПоказателя.ЗапрашиватьПриВводе = Истина;
		КонецЦикла;
	КонецЕсли;
	
	Если КатегорияНачисленияИлиНеоплаченногоВремени = Перечисления.КатегорииНачисленийИНеоплаченногоВремени.ОплатаКомандировки Тогда 
		ПоказательСреднийЗаработокОбщий = ОбщегоНазначенияКлиентСервер.ПредопределенныйЭлемент("Справочник.ПоказателиРасчетаЗарплаты.СреднийЗаработокОбщий");
		НайденныеСтроки = ЭтотОбъект.Показатели.НайтиСтроки(Новый Структура("Показатель", ПоказательСреднийЗаработокОбщий));
		Для Каждого СтрокаПоказателя Из НайденныеСтроки Цикл 
			СтрокаПоказателя.ЗапрашиватьПриВводе = Истина;
		КонецЦикла;
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

Процедура ПроверитьЗачетНормыВремениВытесняющих(Отказ)
	
	// Проверяем, что если у начисления взведен флажок «Зачет нормы времени», 
	// то и у всех вытесняющих должен быть такой флажок.
	Если Не ЗарплатаКадрыРасширенныйКлиентСервер.ЗачетНормыВремениНачисления(ЭтотОбъект) Тогда
		Возврат;
	КонецЕсли;
	
	Вытесняющие = ОбщегоНазначения.ВыгрузитьКолонку(ВытесняющиеВидыРасчета, "ВидРасчета", Истина);
	
	// Выбираем такие вытесняющие, для которых не установлен зачет нормы времени, при этом игнорируем внутрисменные.
	
	Запрос = Новый Запрос(
	"ВЫБРАТЬ
	|	Начисления.Ссылка
	|ИЗ
	|	ПланВидовРасчета.Начисления КАК Начисления
	|ГДЕ
	|	Начисления.Ссылка В(&Вытесняющие)
	|	И НЕ Начисления.ЗачетНормыВремени
	|	И НЕ Начисления.ВидВремени В (ЗНАЧЕНИЕ(Перечисление.ВидыРабочегоВремениСотрудников.ЧасовоеНеотработанное), ЗНАЧЕНИЕ(Перечисление.ВидыРабочегоВремениСотрудников.ЧасовоеОтработанноеВПределахНормы))");
	
	Запрос.УстановитьПараметр("Вытесняющие", Вытесняющие);
	
	Выборка = Запрос.Выполнить().Выбрать();
	
	ПроблемныеВидыРасчета = "";
	Пока Выборка.Следующий() Цикл
		ПроблемныеВидыРасчета = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(
			НСтр("ru='%1«%2», ';uk='%1«%2», '"), ПроблемныеВидыРасчета, Выборка.Ссылка);
	КонецЦикла;
	
	Если ПустаяСтрока(ПроблемныеВидыРасчета) Тогда
		Возврат;
	КонецЕсли;
	
	СтроковыеФункцииКлиентСервер.УдалитьПоследнийСимволВСтроке(ПроблемныеВидыРасчета, 2);
	ТекстСообщения = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(
		НСтр("ru='В списке начислений, приоритет которых выше, обнаружены начисления, не включаемые в зачет нормы времени (см. %1)';uk='У списку нарахувань, пріоритет яких вище, виявлені нарахування, що не включаються в залік норми часу (див. %1)'"), 
		ПроблемныеВидыРасчета);
	ОбщегоНазначенияКлиентСервер.СообщитьПользователю(ТекстСообщения, , "ВытесняющиеВидыРасчета", , Отказ);
	
КонецПроцедуры

// Проверяет наличие актуальных позиций штатного расписания, использующих данное начисление
//	и текущих плановых начислений сотрудников, в случае наличия таковых - устанавливает Отказ = Истина
//	и выводит предупреждения пользователю.
Процедура ПроверитьАктуальностьВидаРасчета(Отказ)
	
	Запрос = Новый Запрос;
	
	Если ПолучитьФункциональнуюОпцию("ИспользоватьШтатноеРасписание") Тогда
		Запрос.Текст = Запрос.Текст + "
		|ВЫБРАТЬ
		|	ШтатноеРасписание.Наименование КАК ПозицияШтатногоРасписания,
		|	ШтатноеРасписание.Ссылка КАК Ссылка
		|ИЗ
		|	Справочник.ШтатноеРасписание.Начисления КАК ШтатноеРасписаниеНачисления
		|		ЛЕВОЕ СОЕДИНЕНИЕ Справочник.ШтатноеРасписание КАК ШтатноеРасписание
		|		ПО ШтатноеРасписаниеНачисления.Ссылка = ШтатноеРасписание.Ссылка
		|ГДЕ
		|	ШтатноеРасписаниеНачисления.Начисление = &Ссылка
		|	И НЕ ШтатноеРасписание.ПометкаУдаления
		|	И ШтатноеРасписание.Утверждена
		|	И НЕ ШтатноеРасписание.Закрыта
		|;
		|////////////////////////////////////////////////////////////////////////////////";
	КонецЕсли;
	
	Запрос.Текст = Запрос.Текст + "
	|ВЫБРАТЬ
	|	ВЫБОР
	|		КОГДА НЕ ПлановыеНачисленияСрезПоследних.Используется
	|			ТОГДА ЛОЖЬ
	|		ИНАЧЕ ВЫБОР
	|				КОГДА ПлановыеНачисленияСрезПоследних.ДействуетДо = ДАТАВРЕМЯ(1, 1, 1)
	|					ТОГДА ИСТИНА
	|				ИНАЧЕ ВЫБОР
	|						КОГДА ПлановыеНачисленияСрезПоследних.ДействуетДо <= &Дата
	|							ТОГДА ПлановыеНачисленияСрезПоследних.ИспользуетсяПоОкончании
	|						ИНАЧЕ ИСТИНА
	|					КОНЕЦ
	|			КОНЕЦ
	|	КОНЕЦ КАК АктуальнаяЗапись,
	|	ПлановыеНачисленияСрезПоследних.Сотрудник КАК Ссылка,
	|	ПРЕДСТАВЛЕНИЕ(ПлановыеНачисленияСрезПоследних.Сотрудник) КАК СотрудникНаименование
	|ИЗ
	|	РегистрСведений.ПлановыеНачисления.СрезПоследних(&Дата, Начисление = &Ссылка) КАК ПлановыеНачисленияСрезПоследних
	|ГДЕ
	|	ВЫБОР
	|			КОГДА НЕ ПлановыеНачисленияСрезПоследних.Используется
	|				ТОГДА ЛОЖЬ
	|			ИНАЧЕ ВЫБОР
	|					КОГДА ПлановыеНачисленияСрезПоследних.ДействуетДо = ДАТАВРЕМЯ(1, 1, 1)
	|						ТОГДА ИСТИНА
	|					ИНАЧЕ ВЫБОР
	|							КОГДА ПлановыеНачисленияСрезПоследних.ДействуетДо <= &Дата
	|								ТОГДА ПлановыеНачисленияСрезПоследних.ИспользуетсяПоОкончании
	|							ИНАЧЕ ИСТИНА
	|						КОНЕЦ
	|				КОНЕЦ
	|		КОНЕЦ";
	
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
		
		ТекстСообщения = НСтр("ru='Нельзя сделать неиспользуемым начисление,
        | которое связано с актуальными плановыми начислениями сотрудников или используется в действующей позиции штатного расписания.'
        |;uk='Неможна зробити невживаним нарахування,
        |яке пов''язане з актуальними плановими нарахуваннями працівників або використовується в чинній позиції штатного розкладу.'");
		ОбщегоНазначенияКлиентСервер.СообщитьПользователю(ТекстСообщения, Ссылка, , , Отказ);	
		
		Выборка = РезультатыЗапроса[РезультатыЗапроса.Количество()-1].Выбрать();
		Пока Выборка.Следующий() Цикл
			ТекстСообщения = НСтр("ru='- плановое начисление сотрудника ""%1""';uk='- планове нарахування співробітника ""%1""'");
			ТекстСообщения = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(
				ТекстСообщения,
				Выборка.СотрудникНаименование);
	        ОбщегоНазначенияКлиентСервер.СообщитьПользователю(ТекстСообщения, Ссылка, "Объект.ВАрхиве" , , Отказ);
		КонецЦикла;	
		
		Если ПолучитьФункциональнуюОпцию("ИспользоватьШтатноеРасписание") Тогда
		
			Выборка = РезультатыЗапроса[РезультатыЗапроса.Количество()-2].Выбрать();
			Пока Выборка.Следующий() Цикл
				ТекстСообщения = НСтр("ru='- позиция штатного расписания ""%1""';uk='- позиція штатного розкладу ""%1""'");
				ТекстСообщения = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(
				ТекстСообщения,
				Выборка.ПозицияШтатногоРасписания);
				ОбщегоНазначенияКлиентСервер.СообщитьПользователю(ТекстСообщения, Ссылка, "Объект.ВАрхиве" , , Отказ);
			КонецЦикла;
			
		КонецЕсли;
		
	КонецЕсли;
			
КонецПроцедуры

#КонецОбласти

#КонецЕсли