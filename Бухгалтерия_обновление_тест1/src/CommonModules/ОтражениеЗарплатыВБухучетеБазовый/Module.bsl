////////////////////////////////////////////////////////////////////////////////
// Отражение зарплаты в бухучете базовая реализация.
// 
////////////////////////////////////////////////////////////////////////////////

#Область СлужебныйПрограммныйИнтерфейс

Процедура СформироватьДвиженияПоДокументу(Движения, Отказ, Организация, ПериодРегистрации, ДанныеДляПроведения, СтрокаСписокТаблиц) Экспорт
	
	ОтражениеВРегламентированномУчетеНастройкиОрганизаций = ОтражениеЗарплатыВБухучете.ОтражениеВРегламентированномУчетеНастройкиОрганизаций();
	
	Если Не ОтражениеВРегламентированномУчетеНастройкиОрганизаций.ФормироватьПроводкиВКонцеПериодаПоОрганизациям[Организация] Тогда
		
		// Получим структуру с результатами отражения зарплаты
		// структура РезультатОтраженияЗарплатыДляБухучета
		// ключ - имя таблицы, значение - таблица значений с полученными данными
		// в структуре присутствуют все таблицы, а заполнены только те, которые входят в СтрокаСписокТаблиц.
		ДанныеДляОтражения = ОтражениеЗарплатыВБухучете.ДанныеДляОтраженияЗарплатыВБухучете(ПериодРегистрации, Организация, СтрокаСписокТаблиц, ДанныеДляПроведения);
		
		Если ОбщегоНазначения.ПодсистемаСуществует("ЗарплатаКадрыПриложения.ОценочныеОбязательстваЗарплатаКадры") Тогда
			
			ЕстьДвижениеВыплатаОтпусковЗаСчетРезерва = Ложь;
			Если ТипЗнч(Движения) = Тип("Структура") Тогда
				ЕстьДвижениеВыплатаОтпусковЗаСчетРезерва = Движения.Свойство("ВыплатаОтпусковЗаСчетРезерва");
			Иначе
				ЕстьДвижениеВыплатаОтпусковЗаСчетРезерва = Движения.Найти("ВыплатаОтпусковЗаСчетРезерва") <> Неопределено;
			КонецЕсли;

			Если ЕстьДвижениеВыплатаОтпусковЗаСчетРезерва Тогда
				
				ДокументСсылка = Движения.ВыплатаОтпусковЗаСчетРезерва.Отбор.Регистратор.Значение;  
			 	
				МодульРезервОтпусков = ОбщегоНазначения.ОбщийМодуль("РезервОтпусков");
				НастройкиРезервовОтпусков = МодульРезервОтпусков.НастройкиРезервовОтпусков(Организация, ПериодРегистрации);
				
				Если НастройкиРезервовОтпусков.ФормироватьРезервОтпусковБУ Тогда
					
					КолонкиСуммирования = Неопределено;
					ОтражениеЗарплатыВБухучете.НоваяТаблицаБухучетНачисленнаяЗарплатаИВзносы(КолонкиСуммирования);
					НачисленныеОтпуска = ОтражениеЗарплатыВБухучете.НоваяТаблицаНачисленныеОтпуска();
					МодульРезервОтпусков.СписатьРасходыПоОплатеОтпускаЗаСчетОценочныхОбязательств(Организация, 
						ПериодРегистрации, ДокументСсылка, ДанныеДляОтражения.НачисленнаяЗарплатаИВзносы, НачисленныеОтпуска, КолонкиСуммирования);
					МодульРезервОтпусков.СформироватьДвиженияВыплатаОтпусковЗаСчетРезерва(Движения, Отказ, Организация, ПериодРегистрации, НачисленныеОтпуска);
					ДвиженияВыплатаОтпусковЗаСчетРезерва = Движения.ВыплатаОтпусковЗаСчетРезерва.Выгрузить();
					МодульРезервОтпусков.СформироватьДвиженияСписаниеРезерваОтпусков (Движения, Отказ, Организация, ПериодРегистрации, ДвиженияВыплатаОтпусковЗаСчетРезерва);

				КонецЕсли;
				
			КонецЕсли;
			
		КонецЕсли;
		
		ОтражениеЗарплатыВБухучете.СвернутьДанныеДляОтраженияЗарплатыВБухучете(ДанныеДляОтражения, "Сотрудник,Начисление");
		
		// формирование проводок
		ОтражениеЗарплатыВБухучетеПереопределяемый.СформироватьДвижения(Движения, Отказ, Организация, ПериодРегистрации, ДанныеДляОтражения);
		
	КонецЕсли;

КонецПроцедуры

// Получим отражение в бухучете начислений и поместим во временную таблицу ВТБухучетНачислений.
// Описание параметров см ОтражениеЗарплатыВБухучете.СоздатьВТБухучетНачислений.
Процедура СоздатьВТБухучетНачислений(Организация, ПериодРегистрации, ПроцентЕНВД, МенеджерВременныхТаблиц, ДополнительныеПараметры) Экспорт
	
	ЕстьЕНВД = ОтражениеЗарплатыВБухучете.ПлательщикЕНВД(Организация, ПериодРегистрации);
	
	// Получим сведения о настройке бухучета для начислений сотрудников.
	ОтражениеЗарплатыВБухучете.СоздатьВТСведенияОБухучетеНачисленийСотрудников(МенеджерВременныхТаблиц, "ВТНачисления", "Сотрудник,ДатаНачала");
	
	ОтражениеЗарплатыВБухучете.СоздатьВТНачислениеВидНачисленияОплатыТрудаДляНУ(МенеджерВременныхТаблиц);
	
	Запрос = Новый Запрос;
	Запрос.МенеджерВременныхТаблиц = МенеджерВременныхТаблиц;
	Запрос.УстановитьПараметр("ПроцентЕНВД", ?(ПроцентЕНВД = Неопределено, 0, ПроцентЕНВД));
	Запрос.УстановитьПараметр("ЕстьЕНВД", ЕстьЕНВД);
	
	РасходыБезСпособаОтражения = Новый Массив;
	РасходыБезСпособаОтражения.Добавить(Перечисления.ВидыОперацийПоЗарплате.РасходыПоСтрахованиюФСС);
	РасходыБезСпособаОтражения.Добавить(Перечисления.ВидыОперацийПоЗарплате.РасходыПоСтрахованиюФССНС);
	РасходыБезСпособаОтражения.Добавить(Перечисления.ВидыОперацийПоЗарплате.КомпенсацияЗаЗадержкуЗарплаты);
	Запрос.УстановитьПараметр("РасходыБезСпособаОтражения", РасходыБезСпособаОтражения);
	
	Запрос.Текст = 
	"ВЫБРАТЬ РАЗЛИЧНЫЕ
	|	Начисления.ПериодРегистрации,
	|	Начисления.ИдентификаторСтроки,
	|	Начисления.Организация,
	|	Начисления.Сотрудник,
	|	Начисления.ФизическоеЛицо,
	|	Начисления.Подразделение,
	|	Начисления.ДатаНачала,
	|	Начисления.ДатаОкончания,
	|	Начисления.ВидОперации,
	|	Начисления.Начисление,
	|	Начисления.ДокументОснование,
	|	Начисления.Сумма,
	|	ВЫБОР
	|		КОГДА Начисления.ДатаНачала = ДАТАВРЕМЯ(1, 1, 1)
	|				ИЛИ Начисления.ДатаНачала < Начисления.ПериодРегистрации
	|			ТОГДА Начисления.ПериодРегистрации
	|		ИНАЧЕ НАЧАЛОПЕРИОДА(Начисления.ДатаНачала, МЕСЯЦ)
	|	КОНЕЦ КАК ПериодПринятияРасходов,
	|	ВЫБОР
	|		КОГДА &ЕстьЕНВД
	|			ТОГДА СведенияОБухучетеНачисленийСотрудников.ОтношениеКЕНВД
	|		ИНАЧЕ ЗНАЧЕНИЕ(Перечисление.ОтношениеКЕНВДЗатратНаЗарплату.НеЕНВД)
	|	КОНЕЦ КАК ОтношениеКЕНВД,
	|	СведенияОБухучетеНачисленийСотрудников.СпособОтраженияЗарплатыВБухучете,
	|	ВидыНачисленияДляНУ.ВидНачисленияОплатыТрудаДляНУ,
	|	ВЫБОР
	|		КОГДА ВидыРасчета.КатегорияНачисленияИлиНеоплаченногоВремени В (ЗНАЧЕНИЕ(Перечисление.КатегорииНачисленийИНеоплаченногоВремени.РайонныйКоэффициент), ЗНАЧЕНИЕ(Перечисление.КатегорииНачисленийИНеоплаченногоВремени.СевернаяНадбавка))
	|				И ВидыРасчета.СпособОтраженияЗарплатыВБухучете = ЗНАЧЕНИЕ(Справочник.СпособыОтраженияЗарплатыВБухУчете.ПустаяСсылка)
	|			ТОГДА ИСТИНА
	|		ИНАЧЕ ЛОЖЬ
	|	КОНЕЦ КАК РаспределятьПоБазе,
	|	ВидыРасчета.ВходитВБазуРКИСН КАК ВходитВБазуРКИСН,
	|	ВЫБОР
	|		КОГДА ВидыРасчета.ВидОперацииПоЗарплате В (&РасходыБезСпособаОтражения)
	|			ТОГДА ИСТИНА
	|		ИНАЧЕ ЛОЖЬ
	|	КОНЕЦ КАК РасходыБезСпособаОтражения
	|ПОМЕСТИТЬ ВТСписокНачислений
	|ИЗ
	|	ВТНачисления КАК Начисления
	|		ЛЕВОЕ СОЕДИНЕНИЕ ВТСведенияОБухучетеНачисленийСотрудников КАК СведенияОБухучетеНачисленийСотрудников
	|		ПО Начисления.Сотрудник = СведенияОБухучетеНачисленийСотрудников.Сотрудник
	|			И Начисления.Подразделение = СведенияОБухучетеНачисленийСотрудников.Подразделение
	|			И Начисления.ДатаНачала = СведенияОБухучетеНачисленийСотрудников.Период
	|			И Начисления.Начисление = СведенияОБухучетеНачисленийСотрудников.Начисление
	|		ЛЕВОЕ СОЕДИНЕНИЕ ВТНачислениеВидНачисленияОплатыТрудаДляНУ КАК ВидыНачисленияДляНУ
	|		ПО Начисления.Начисление = ВидыНачисленияДляНУ.Начисление
	|		ЛЕВОЕ СОЕДИНЕНИЕ ПланВидовРасчета.Начисления КАК ВидыРасчета
	|		ПО Начисления.Начисление = ВидыРасчета.Ссылка
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|УНИЧТОЖИТЬ ВТСведенияОБухучетеНачисленийСотрудников
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ
	|	СписокНачислений.ПериодРегистрации,
	|	СписокНачислений.ИдентификаторСтроки,
	|	СписокНачислений.Организация,
	|	СписокНачислений.Сотрудник,
	|	СписокНачислений.ФизическоеЛицо,
	|	СписокНачислений.Подразделение,
	|	СписокНачислений.ДатаНачала,
	|	СписокНачислений.ДатаОкончания,
	|	СписокНачислений.ВидОперации,
	|	СписокНачислений.Начисление,
	|	СписокНачислений.ДокументОснование,
	|	СписокНачислений.ПериодПринятияРасходов,
	|	ВЫБОР
	|		КОГДА СписокНачислений.РасходыБезСпособаОтражения
	|			ТОГДА ЗНАЧЕНИЕ(Справочник.СпособыОтраженияЗарплатыВБухУчете.ПустаяСсылка)
	|		ИНАЧЕ СписокНачислений.СпособОтраженияЗарплатыВБухучете
	|	КОНЕЦ КАК СпособОтраженияЗарплатыВБухучете,
	|	СписокНачислений.ВидНачисленияОплатыТрудаДляНУ,
	|	СписокНачислений.РаспределятьПоБазе,
	|	СписокНачислений.ВходитВБазуРКИСН,
	|	ВЫБОР
	|		КОГДА СписокНачислений.ОтношениеКЕНВД = ЗНАЧЕНИЕ(Перечисление.ОтношениеКЕНВДЗатратНаЗарплату.ОпределяетсяЕжемесячноПроцентом)
	|			ТОГДА ВЫБОР
	|					КОГДА ОтношениеКЕНВДЗатратНаЗарплату.Ссылка = ЗНАЧЕНИЕ(Перечисление.ОтношениеКЕНВДЗатратНаЗарплату.ЕНВД)
	|						ТОГДА ВЫРАЗИТЬ(СписокНачислений.Сумма * &ПроцентЕНВД / 100 КАК ЧИСЛО(15, 2))
	|					ИНАЧЕ СписокНачислений.Сумма - (ВЫРАЗИТЬ(СписокНачислений.Сумма * &ПроцентЕНВД / 100 КАК ЧИСЛО(15, 2)))
	|				КОНЕЦ
	|		ИНАЧЕ СписокНачислений.Сумма
	|	КОНЕЦ КАК Сумма,
	|	ВЫБОР
	|		КОГДА ВЫБОР
	|				КОГДА СписокНачислений.ОтношениеКЕНВД = ЗНАЧЕНИЕ(Перечисление.ОтношениеКЕНВДЗатратНаЗарплату.ОпределяетсяЕжемесячноПроцентом)
	|					ТОГДА ОтношениеКЕНВДЗатратНаЗарплату.Ссылка
	|				ИНАЧЕ СписокНачислений.ОтношениеКЕНВД
	|			КОНЕЦ = ЗНАЧЕНИЕ(Перечисление.ОтношениеКЕНВДЗатратНаЗарплату.ЕНВД)
	|			ТОГДА ИСТИНА
	|		ИНАЧЕ ЛОЖЬ
	|	КОНЕЦ КАК ОблагаетсяЕНВД
	|ПОМЕСТИТЬ ВТБухучетНачисленийВременная
	|ИЗ
	|	ВТСписокНачислений КАК СписокНачислений
	|		ЛЕВОЕ СОЕДИНЕНИЕ Перечисление.ОтношениеКЕНВДЗатратНаЗарплату КАК ОтношениеКЕНВДЗатратНаЗарплату
	|		ПО (ОтношениеКЕНВДЗатратНаЗарплату.Ссылка В (ЗНАЧЕНИЕ(Перечисление.ОтношениеКЕНВДЗатратНаЗарплату.ЕНВД), ЗНАЧЕНИЕ(Перечисление.ОтношениеКЕНВДЗатратНаЗарплату.НеЕНВД)))
	|			И (СписокНачислений.ОтношениеКЕНВД = ЗНАЧЕНИЕ(Перечисление.ОтношениеКЕНВДЗатратНаЗарплату.ОпределяетсяЕжемесячноПроцентом))
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ
	|	БухучетНачислений.Сотрудник,
	|	БухучетНачислений.Подразделение,
	|	БухучетНачислений.СпособОтраженияЗарплатыВБухучете,
	|	БухучетНачислений.ОблагаетсяЕНВД,
	|	СУММА(БухучетНачислений.Сумма) КАК Сумма
	|ИЗ
	|	ВТБухучетНачисленийВременная КАК БухучетНачислений
	|ГДЕ
	|	БухучетНачислений.ВходитВБазуРКИСН
	|
	|СГРУППИРОВАТЬ ПО
	|	БухучетНачислений.Сотрудник,
	|	БухучетНачислений.Подразделение,
	|	БухучетНачислений.СпособОтраженияЗарплатыВБухучете,
	|	БухучетНачислений.ОблагаетсяЕНВД
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ
	|	СписокНачислений.ИдентификаторСтроки,
	|	СписокНачислений.Сотрудник,
	|	СписокНачислений.Подразделение,
	|	СписокНачислений.Сумма,
	|	СписокНачислений.СпособОтраженияЗарплатыВБухучете,
	|	СписокНачислений.ОблагаетсяЕНВД
	|ИЗ
	|	ВТБухучетНачисленийВременная КАК СписокНачислений
	|ГДЕ
	|	СписокНачислений.РаспределятьПоБазе";
	
	Результат = Запрос.ВыполнитьПакет();
	КоличествоРезультатов = Результат.Количество();
	БазаНачислений = Результат[КоличествоРезультатов-2].Выгрузить();
	НачисленияДляРаспределения = Результат[КоличествоРезультатов-1].Выгрузить();
		
	Начисления = НачисленияДляРаспределения.СкопироватьКолонки();
	
	Отбор = Новый Структура("Сотрудник,Подразделение");
	БазаНачислений.Индексы.Добавить("Сотрудник,Подразделение");
	
	Для каждого СтрокаНачисления Из НачисленияДляРаспределения Цикл
		
		Отбор.Сотрудник = СтрокаНачисления.Сотрудник;
		Отбор.Подразделение = СтрокаНачисления.Подразделение;
		СтрокиБазы = БазаНачислений.НайтиСтроки(Отбор);
		
		Если СтрокиБазы.Количество() > 0 Тогда
			
			Коэффициенты = ОбщегоНазначения.ВыгрузитьКолонку(СтрокиБазы,"Сумма");
			Результаты = ЗарплатаКадры.РаспределитьСуммуПропорциональноБазе(СтрокаНачисления.Сумма, Коэффициенты);
			
			Если Результаты = Неопределено Тогда
				НоваяСтрока = Начисления.Добавить();
				ЗаполнитьЗначенияСвойств(НоваяСтрока, СтрокаНачисления);
				Продолжить;
			КонецЕсли;
			
			Индекс = 0;
			Для Каждого СтрокаБазы Из СтрокиБазы Цикл
				
				НоваяСтрока = Начисления.Добавить();
				ЗаполнитьЗначенияСвойств(НоваяСтрока, СтрокаНачисления);
				НоваяСтрока.Сумма = Результаты[Индекс];
				НоваяСтрока.СпособОтраженияЗарплатыВБухучете = СтрокаБазы.СпособОтраженияЗарплатыВБухучете;
				НоваяСтрока.ОблагаетсяЕНВД = СтрокаБазы.ОблагаетсяЕНВД;
				
				Индекс = Индекс + 1;
				
			КонецЦикла;
			
		Иначе
			
			НоваяСтрока = Начисления.Добавить();
			ЗаполнитьЗначенияСвойств(НоваяСтрока, СтрокаНачисления);
			
		КонецЕсли;
		
	КонецЦикла;
		
	Запрос.УстановитьПараметр("Начисления", Начисления);
	Запрос.Текст = 
	"ВЫБРАТЬ
	|	Начисления.ИдентификаторСтроки,
	|	Начисления.СпособОтраженияЗарплатыВБухучете,
	|	Начисления.ОблагаетсяЕНВД,
	|	Начисления.Сумма
	|ПОМЕСТИТЬ ВТНачисленияПоБазе
	|ИЗ
	|	&Начисления КАК Начисления
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ
	|	Начисления.ПериодРегистрации,
	|	Начисления.Организация,
	|	Начисления.ИдентификаторСтроки,
	|	Начисления.Сотрудник,
	|	Начисления.ФизическоеЛицо,
	|	Начисления.Подразделение,
	|	Начисления.ДатаНачала,
	|	КОНЕЦПЕРИОДА(Начисления.ДатаНачала, МЕСЯЦ) КАК ДатаОкончания,
	|	Начисления.ВидОперации,
	|	Начисления.Начисление,
	|	НачисленияПоБазе.СпособОтраженияЗарплатыВБухучете,
	|	ЗНАЧЕНИЕ(Справочник.СтатьиФинансированияЗарплата.ПустаяСсылка) КАК СтатьяФинансирования,
	|	ЗНАЧЕНИЕ(Справочник.СтатьиРасходовЗарплата.ПустаяСсылка) КАК СтатьяРасходов,
	|	НачисленияПоБазе.ОблагаетсяЕНВД,
	|	НачисленияПоБазе.Сумма,
	|	Начисления.ДокументОснование,
	|	Начисления.ПериодПринятияРасходов,
	|	Начисления.ВидНачисленияОплатыТрудаДляНУ
	|ПОМЕСТИТЬ ВТБухучетНачислений
	|ИЗ
	|	ВТСписокНачислений КАК Начисления
	|		ВНУТРЕННЕЕ СОЕДИНЕНИЕ ВТНачисленияПоБазе КАК НачисленияПоБазе
	|		ПО Начисления.ИдентификаторСтроки = НачисленияПоБазе.ИдентификаторСтроки
	|
	|ОБЪЕДИНИТЬ ВСЕ
	|
	|ВЫБРАТЬ
	|	БухучетНачислений.ПериодРегистрации,
	|	БухучетНачислений.Организация,
	|	БухучетНачислений.ИдентификаторСтроки,
	|	БухучетНачислений.Сотрудник,
	|	БухучетНачислений.ФизическоеЛицо,
	|	БухучетНачислений.Подразделение,
	|	БухучетНачислений.ДатаНачала,
	|	КОНЕЦПЕРИОДА(БухучетНачислений.ДатаНачала, МЕСЯЦ),
	|	БухучетНачислений.ВидОперации,
	|	БухучетНачислений.Начисление,
	|	БухучетНачислений.СпособОтраженияЗарплатыВБухучете,
	|	ЗНАЧЕНИЕ(Справочник.СтатьиФинансированияЗарплата.ПустаяСсылка),
	|	ЗНАЧЕНИЕ(Справочник.СтатьиРасходовЗарплата.ПустаяСсылка),
	|	БухучетНачислений.ОблагаетсяЕНВД,
	|	БухучетНачислений.Сумма,
	|	БухучетНачислений.ДокументОснование,
	|	БухучетНачислений.ПериодПринятияРасходов,
	|	БухучетНачислений.ВидНачисленияОплатыТрудаДляНУ
	|ИЗ
	|	ВТБухучетНачисленийВременная КАК БухучетНачислений
	|ГДЕ
	|	НЕ БухучетНачислений.РаспределятьПоБазе
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|УНИЧТОЖИТЬ ВТБухучетНачисленийВременная
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|УНИЧТОЖИТЬ ВТНачисленияПоБазе
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|УНИЧТОЖИТЬ ВТСписокНачислений";
	
	Запрос.Выполнить();

КонецПроцедуры

// Формирует временную таблицу ВТСведенияОБухучетеЗарплатыСотрудников, список сотрудников и периодов,
// по которым необходимо получить данные, берутся из временной таблицы в менеджере временных
// таблиц, переданном в качестве параметра. Временная таблица обязательно должна содержать
// колонки Сотрудник и Период.
//		Поля "Сотрудник,Период" можно переопределить в ОписательВременныхТаблиц.
//
//	Структура таблицы ВТСведенияОБухучетеЗарплатыСотрудников.
//		Организация
//		Подразделение
//		Сотрудник
//		Период
//		СтатьяФинансирования
//		СтатьяРасходов
//		СпособОтраженияЗарплатыВБухучете
//		ОтношениеКЕНВД.
//
// Параметры:
//		МенеджерВременныхТаблиц - содержит временную таблицу с именем, указанным в параметре ИмяВременнойТаблицы.
//		Организация - если значение Неопределенно, то должно быть поле Организация в таблице ИмяВременнойТаблицы.
//		Подразделение - если значение Неопределенно, то должно быть поле Подразделение в таблице ИмяВременнойТаблицы.
//		ИмяВременнойТаблицы - временная таблица с полями Организация, Подразделение, Сотрудник, Период.
//			Поля Организация и Подразделение могут отсутствовать, если заполнены параметр Организация, Подразделение.
//			Имена полей Сотрудник и Период можно переопределить в параметре ИменаПолейВременнойТаблицы.
//		ИменаПолейВременнойТаблицы - строка, имена полей Сотрудник и Период временной таблицы ИмяВременнойТаблицы.
//
Процедура СоздатьВТСведенияОБухучетеЗарплатыСотрудников(МенеджерВременныхТаблиц, ИмяВременнойТаблицы, ИменаПолейВременнойТаблицы = "Сотрудник,Период", Организация = Неопределено, Подразделение = Неопределено) Экспорт
	
	ИмяВТБухучетОрганизаций   = ЗарплатаКадрыОбщиеНаборыДанных.УникальноеИмяТекстаЗапроса("ВТБухучетОрганизаций");
	ИмяВТБухучетСотрудников   = ЗарплатаКадрыОбщиеНаборыДанных.УникальноеИмяТекстаЗапроса("ВТБухучетСотрудников");
	
	ИмяВТОрганизации = ЗарплатаКадрыОбщиеНаборыДанных.УникальноеИмяТекстаЗапроса("ВТОрганизации");
	ИмяВТСотрудники = ЗарплатаКадрыОбщиеНаборыДанных.УникальноеИмяТекстаЗапроса("ВТСотрудники");
	
	МассивИменПолейОтбора = СтроковыеФункцииКлиентСервер.РазложитьСтрокуВМассивПодстрок(ИменаПолейВременнойТаблицы, ",");
	ИмяПоляСотрудник     = МассивИменПолейОтбора[0];
	ИмяПоляПериод        = МассивИменПолейОтбора[1];
	
	Запрос = Новый Запрос;
	Запрос.МенеджерВременныхТаблиц = МенеджерВременныхТаблиц;
	
	ОрганизацияВТаблице   = Организация = Неопределено;
	ПодразделениеВТаблице = Подразделение = Неопределено;
	
	Если НЕ ОрганизацияВТаблице Тогда
		
		Запрос.УстановитьПараметр("Организация", Организация);
		
		ТекстЗапроса = 
		"ВЫБРАТЬ РАЗЛИЧНЫЕ
		|	&Организация КАК Организация,
		|	Таблица." + ИмяПоляПериод + " КАК Период
		|ПОМЕСТИТЬ " + ИмяВТОрганизации + "
		|ИЗ
		|	" + ИмяВременнойТаблицы + " КАК Таблица
		|;
		|
		|////////////////////////////////////////////////////////////////////////////////
		|";
		
	Иначе
		
		ТекстЗапроса = 
		"ВЫБРАТЬ РАЗЛИЧНЫЕ
		|	Таблица.Организация КАК Организация,
		|	Таблица." + ИмяПоляПериод + " КАК Период
		|ПОМЕСТИТЬ " + ИмяВТОрганизации + "
		|ИЗ
		|	" + ИмяВременнойТаблицы + " КАК Таблица
		|;
		|
		|////////////////////////////////////////////////////////////////////////////////
		|";
		
	КонецЕсли;
	
	ТекстЗапроса = ТекстЗапроса +
	"ВЫБРАТЬ
	|	МаксимальныеПериоды.Организация КАК Организация,
	|	МаксимальныеПериоды.Период КАК Период,
	|	БухучетЗарплаты.СтатьяФинансирования КАК СтатьяФинансирования,
	|	БухучетЗарплаты.СпособОтраженияЗарплатыВБухучете КАК СпособОтраженияЗарплатыВБухучете,
	|	БухучетЗарплаты.ОтношениеКЕНВД КАК ОтношениеКЕНВД
	|ПОМЕСТИТЬ " + ИмяВТБухучетОрганизаций + "
	|ИЗ
	|	(ВЫБРАТЬ
	|		Организации.Организация КАК Организация,
	|		Организации.Период КАК Период,
	|		МАКСИМУМ(БухучетЗарплатыОрганизаций.Период) КАК ПериодРегистра
	|	ИЗ
	|		" + ИмяВТОрганизации + " КАК Организации
	|			ВНУТРЕННЕЕ СОЕДИНЕНИЕ РегистрСведений.БухучетЗарплатыОрганизаций КАК БухучетЗарплатыОрганизаций
	|			ПО Организации.Организация = БухучетЗарплатыОрганизаций.Организация
	|				И Организации.Период >= БухучетЗарплатыОрганизаций.Период
	|	
	|	СГРУППИРОВАТЬ ПО
	|		Организации.Организация,
	|		Организации.Период) КАК МаксимальныеПериоды
	|		ВНУТРЕННЕЕ СОЕДИНЕНИЕ РегистрСведений.БухучетЗарплатыОрганизаций КАК БухучетЗарплаты
	|		ПО МаксимальныеПериоды.Организация = БухучетЗарплаты.Организация
	|			И МаксимальныеПериоды.ПериодРегистра = БухучетЗарплаты.Период
	|
	|ИНДЕКСИРОВАТЬ ПО
	|	Организация,
	|	Период
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|УНИЧТОЖИТЬ " + ИмяВТОрганизации + "";
	
	Запрос.Текст = ТекстЗапроса;
	Запрос.Выполнить();
	
	ТекстЗапроса = 
		"ВЫБРАТЬ РАЗЛИЧНЫЕ
		|	Таблица." + ИмяПоляСотрудник + " КАК Сотрудник,
		|	Таблица." + ИмяПоляПериод + " КАК Период
		|ПОМЕСТИТЬ " + ИмяВТСотрудники + "
		|ИЗ
		|	" + ИмяВременнойТаблицы + " КАК Таблица
		|;
		|
		|////////////////////////////////////////////////////////////////////////////////
		|";
	
	ТекстЗапроса = ТекстЗапроса + 
	"ВЫБРАТЬ
	|	МаксимальныеПериоды.Сотрудник КАК Сотрудник,
	|	МаксимальныеПериоды.Период КАК Период,
	|	БухучетЗарплаты.СтатьяФинансирования КАК СтатьяФинансирования,
	|	БухучетЗарплаты.СпособОтраженияЗарплатыВБухучете КАК СпособОтраженияЗарплатыВБухучете,
	|	БухучетЗарплаты.ОтношениеКЕНВД КАК ОтношениеКЕНВД
	|ПОМЕСТИТЬ " + ИмяВТБухучетСотрудников + "
	|ИЗ
	|	(ВЫБРАТЬ
	|		Подразделения.Сотрудник КАК Сотрудник,
	|		Подразделения.Период КАК Период,
	|		МАКСИМУМ(БухучетЗарплатыПодразделений.Период) КАК ПериодРегистра
	|	ИЗ
	|		" + ИмяВТСотрудники + " КАК Подразделения
	|			ВНУТРЕННЕЕ СОЕДИНЕНИЕ РегистрСведений.БухучетЗарплатыСотрудников КАК БухучетЗарплатыПодразделений
	|			ПО Подразделения.Сотрудник = БухучетЗарплатыПодразделений.Сотрудник
	|				И Подразделения.Период >= БухучетЗарплатыПодразделений.Период
	|	
	|	СГРУППИРОВАТЬ ПО
	|		Подразделения.Сотрудник,
	|		Подразделения.Период) КАК МаксимальныеПериоды
	|		ВНУТРЕННЕЕ СОЕДИНЕНИЕ РегистрСведений.БухучетЗарплатыСотрудников КАК БухучетЗарплаты
	|		ПО МаксимальныеПериоды.Сотрудник = БухучетЗарплаты.Сотрудник
	|			И МаксимальныеПериоды.ПериодРегистра = БухучетЗарплаты.Период
	|
	|ИНДЕКСИРОВАТЬ ПО
	|	Сотрудник,
	|	Период
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|УНИЧТОЖИТЬ " + ИмяВТСотрудники + "";
	
	Запрос.Текст = ТекстЗапроса;
	Запрос.Выполнить();
	
	ТекстЗапроса = 
	"ВЫБРАТЬ РАЗЛИЧНЫЕ
	|	" + ?(ОрганизацияВТаблице,"ВременнаяТаблица.Организация","&Организация") + " КАК Организация,
	|	" + ?(ПодразделениеВТаблице, "ВременнаяТаблица.Подразделение","&Подразделение") + " КАК Подразделение,
	|	ВременнаяТаблица." + ИмяПоляСотрудник + " КАК Сотрудник,
	|	ВременнаяТаблица." + ИмяПоляПериод + " КАК Период,
	|	ВЫБОР
	|		КОГДА БухучетСотрудников.СтатьяФинансирования <> ЗНАЧЕНИЕ(Справочник.СтатьиФинансированияЗарплата.ПустаяСсылка) 
	|			ТОГДА БухучетСотрудников.СтатьяФинансирования
	|		ИНАЧЕ БухучетОрганизаций.СтатьяФинансирования
	|	КОНЕЦ КАК СтатьяФинансирования,
	|	ЗНАЧЕНИЕ(Справочник.СтатьиРасходовЗарплата.ПустаяСсылка) КАК СтатьяРасходов,
	|	ВЫБОР
	|		КОГДА БухучетСотрудников.СпособОтраженияЗарплатыВБухучете <> ЗНАЧЕНИЕ(Справочник.СпособыОтраженияЗарплатыВБухучете.ПустаяСсылка) 
	|			ТОГДА БухучетСотрудников.СпособОтраженияЗарплатыВБухучете
	|		ИНАЧЕ БухучетОрганизаций.СпособОтраженияЗарплатыВБухучете
	|	КОНЕЦ КАК СпособОтраженияЗарплатыВБухучете,
	|	ВЫБОР
	|		КОГДА БухучетСотрудников.ОтношениеКЕНВД <> ЗНАЧЕНИЕ(Перечисление.ОтношениеКЕНВДЗатратНаЗарплату.ПустаяСсылка) 
	|			ТОГДА БухучетСотрудников.ОтношениеКЕНВД
	|		ИНАЧЕ БухучетОрганизаций.ОтношениеКЕНВД
	|	КОНЕЦ КАК ОтношениеКЕНВД
	|ПОМЕСТИТЬ ВТСведенияОБухучетеЗарплатыСотрудников
	|ИЗ
	|	" + ИмяВременнойТаблицы + " КАК ВременнаяТаблица
	|		ЛЕВОЕ СОЕДИНЕНИЕ " + ИмяВТБухучетСотрудников + " КАК БухучетСотрудников
	|		ПО ВременнаяТаблица." + ИмяПоляСотрудник + " = БухучетСотрудников.Сотрудник
	|			И ВременнаяТаблица." + ИмяПоляПериод + " = БухучетСотрудников.Период
	|		ЛЕВОЕ СОЕДИНЕНИЕ " + ИмяВТБухучетОрганизаций + " КАК БухучетОрганизаций
	|		ПО ВременнаяТаблица." + ИмяПоляПериод + " = БухучетОрганизаций.Период
	|			" + ?(ОрганизацияВТаблице,"И ВременнаяТаблица.Организация = БухучетОрганизаций.Организация","") + "
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|УНИЧТОЖИТЬ " + ИмяВТБухучетСотрудников + "
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|УНИЧТОЖИТЬ " + ИмяВТБухучетОрганизаций + "";
	
	Запрос.Текст = ТекстЗапроса;
	Запрос.Выполнить();
	
КонецПроцедуры

// Формирует временную таблицу ВТСведенияОБухучетеНачислений
// получает настройки бухучета из ПВР Начисления, у которых задана стратегия отражения в учете КакЗаданоВидуРасчета.
// 
// Параметры:
//		МенеджерВременныхТаблиц - в менеджер помещается таблица ВТСведенияОБухучетеНачислений.
//
Процедура СоздатьВТСведенияОБухучетеНачислений(МенеджерВременныхТаблиц) Экспорт

	Запрос = Новый Запрос;
	Запрос.МенеджерВременныхТаблиц = МенеджерВременныхТаблиц;
	Запрос.Текст =
	"ВЫБРАТЬ
	|	Начисления.Ссылка КАК Начисление,
	|	ЗНАЧЕНИЕ(Справочник.СтатьиФинансированияЗарплата.ПустаяСсылка) КАК СтатьяФинансирования,
	|	ЗНАЧЕНИЕ(Справочник.СтатьиРасходовЗарплата.ПустаяСсылка) КАК СтатьяРасходов,
	|	Начисления.СпособОтраженияЗарплатыВБухучете КАК СпособОтраженияЗарплатыВБухучете,
	|	Начисления.ОтношениеКЕНВД КАК ОтношениеКЕНВД
	|ПОМЕСТИТЬ ВТСведенияОБухучетеНачислений
	|ИЗ
	|	ПланВидовРасчета.Начисления КАК Начисления
	|
	|ИНДЕКСИРОВАТЬ ПО
	|	Начисление";
	
	Запрос.Выполнить();

КонецПроцедуры

Функция ТекстЗапросаДанныеДокументаОбработкаДокументовОтражениеЗарплатыВБухучете() Экспорт

	ТекстЗапроса = "";
	Если ОбщегоНазначения.ПодсистемаСуществует("ЗарплатаКадрыПриложения.БухучетХозрасчетныхОрганизаций") Тогда
		Модуль = ОбщегоНазначения.ОбщийМодуль("БухучетХозрасчетныхОрганизацийБазовый");
		ТекстЗапроса = Модуль.ТекстЗапросаДанныеДокументаОбработкаДокументовОтражениеЗарплатыВБухучете();
	КонецЕсли;
	
	Возврат ТекстЗапроса;
	
КонецФункции

Процедура ОбновитьВидОперацииУдержаниеПоПрочимОперациямСРаботниками() Экспорт

	Если ОбщегоНазначения.ПодсистемаСуществует("ЗарплатаКадрыПриложения.БухучетХозрасчетныхОрганизаций") Тогда
		Модуль = ОбщегоНазначения.ОбщийМодуль("БухучетХозрасчетныхОрганизацийБазовый");
		Модуль.ОбновитьВидОперацииУдержаниеПоПрочимОперациямСРаботниками();
	КонецЕсли;

КонецПроцедуры

Процедура ЗаполнитьВидОперацииПоЗарплатеВНачислениях() Экспорт

	Запрос = Новый Запрос;
	Запрос.Текст = 
	"ВЫБРАТЬ
	|	Начисления.Ссылка,
	|	ВЫБОР
	|		КОГДА Начисления.КатегорияНачисленияИлиНеоплаченногоВремени = ЗНАЧЕНИЕ(Перечисление.КатегорииНачисленийИНеоплаченногоВремени.ОплатаБольничногоЛиста)
	|			ТОГДА ЗНАЧЕНИЕ(Перечисление.ВидыОперацийПоЗарплате.РасходыПоСтрахованиюФСС)
	|		КОГДА Начисления.КатегорияНачисленияИлиНеоплаченногоВремени = ЗНАЧЕНИЕ(Перечисление.КатегорииНачисленийИНеоплаченногоВремени.ОплатаБольничногоЛистаЗаСчетРаботодателя)
	|			ТОГДА ЗНАЧЕНИЕ(Перечисление.ВидыОперацийПоЗарплате.РасходыПоСтрахованиюРаботодатель)
	|		КОГДА Начисления.КатегорияНачисленияИлиНеоплаченногоВремени = ЗНАЧЕНИЕ(Перечисление.КатегорииНачисленийИНеоплаченногоВремени.ОплатаБольничногоНесчастныйСлучайНаПроизводстве)
	|				ИЛИ Начисления.КатегорияНачисленияИлиНеоплаченногоВремени = ЗНАЧЕНИЕ(Перечисление.КатегорииНачисленийИНеоплаченногоВремени.ОплатаБольничногоПрофзаболевание)
	|			ТОГДА ЗНАЧЕНИЕ(Перечисление.ВидыОперацийПоЗарплате.РасходыПоСтрахованиюФССНС)
	|		ИНАЧЕ ЗНАЧЕНИЕ(Перечисление.ВидыОперацийПоЗарплате.НачисленоДоход)
	|	КОНЕЦ КАК ВидОперацииПоЗарплате
	|ИЗ
	|	ПланВидовРасчета.Начисления КАК Начисления
	|ГДЕ
	|	Начисления.ВидОперацииПоЗарплате = ЗНАЧЕНИЕ(Перечисление.ВидыОперацийПоЗарплате.ПустаяСсылка)";
	
	Выборка = Запрос.Выполнить().Выбрать();
	Пока Выборка.Следующий() Цикл
		НачислениеОбъект = Выборка.Ссылка.ПолучитьОбъект();
		НачислениеОбъект.ВидОперацииПоЗарплате = Выборка.ВидОперацииПоЗарплате;
		ОбновлениеИнформационнойБазы.ЗаписатьДанные(НачислениеОбъект);
	КонецЦикла;	

КонецПроцедуры

Процедура ЗаполнитьВидОперацииПоЗарплатеВНачисленияхДляНатуральныхДоходов() Экспорт
	
	Запрос = Новый Запрос;
	Запрос.Текст = 
	"ВЫБРАТЬ
	|	Начисления.Ссылка,
	|	ИСТИНА КАК ЯвляетсяДоходомВНатуральнойФорме,
	|	ЗНАЧЕНИЕ(Перечисление.ВидыОперацийПоЗарплате.НатуральныйДоход) КАК ВидОперацииПоЗарплате
	|ИЗ
	|	ПланВидовРасчета.Начисления КАК Начисления
	|ГДЕ
	|	Начисления.ЯвляетсяДоходомВНатуральнойФорме
	|	И Начисления.ВидОперацииПоЗарплате <> ЗНАЧЕНИЕ(Перечисление.ВидыОперацийПоЗарплате.НатуральныйДоход)
	|	И Начисления.КатегорияНачисленияИлиНеоплаченногоВремени = ЗНАЧЕНИЕ(Перечисление.КатегорииНачисленийИНеоплаченногоВремени.Прочее)
	|
	|ОБЪЕДИНИТЬ ВСЕ
	|
	|ВЫБРАТЬ
	|	Начисления.Ссылка,
	|	ЛОЖЬ,
	|	Начисления.ВидОперацииПоЗарплате
	|ИЗ
	|	ПланВидовРасчета.Начисления КАК Начисления
	|ГДЕ
	|	Начисления.ЯвляетсяДоходомВНатуральнойФорме
	|	И Начисления.КатегорияНачисленияИлиНеоплаченногоВремени <> ЗНАЧЕНИЕ(Перечисление.КатегорииНачисленийИНеоплаченногоВремени.Прочее)";
	
	Выборка = Запрос.Выполнить().Выбрать();
	Пока Выборка.Следующий() Цикл
		НачислениеОбъект = Выборка.Ссылка.ПолучитьОбъект();
		НачислениеОбъект.ВидОперацииПоЗарплате = Выборка.ВидОперацииПоЗарплате;
		НачислениеОбъект.ЯвляетсяДоходомВНатуральнойФорме = Выборка.ЯвляетсяДоходомВНатуральнойФорме;
		ОбновлениеИнформационнойБазы.ЗаписатьДанные(НачислениеОбъект);
	КонецЦикла;
	
КонецПроцедуры

Функция НачисленияСДаннымиЕНВДДляСтраховыхВзносов(Организация, МесяцНачисления, ПараметрыДляРаспределения) Экспорт

	Запрос = Новый Запрос;
	Запрос.МенеджерВременныхТаблиц = ПараметрыДляРаспределения.МенеджерВременныхТаблиц;
	Запрос.Текст = 
	"ВЫБРАТЬ РАЗЛИЧНЫЕ
	|	СписокНачислений.Сотрудник КАК Сотрудник,
	|	СписокНачислений.Подразделение КАК Подразделение,
	|	СписокНачислений.Начисление КАК Начисление,
	|	СписокНачислений.ДатаНачала КАК ДатаНачала,
	|	0 КАК ДоляЕНВД
	|ИЗ
	|	ВТНачисления КАК СписокНачислений";
	
	НачисленияСДаннымиЕНВД = Запрос.Выполнить().Выгрузить();
	
	Возврат НачисленияСДаннымиЕНВД;

КонецФункции

Функция ДополнительныеПараметрыДляОтраженияВБухучете() Экспорт

	Параметры = Новый Структура;
	Параметры.Вставить("ДокументСсылка", Неопределено);
	Параметры.Вставить("БухучетПервичногоДокумента", Неопределено);
	Параметры.Вставить("КоэффициентыРаспределенияСреднегоЗаработка", Неопределено);
	Параметры.Вставить("КоэффициентыРаспределенияСреднегоЗаработкаФСС", Неопределено);
	
	Возврат Параметры;

КонецФункции

Процедура СоздатьВТНачисленияБазаОтпуска(МенеджерВременныхТаблиц) Экспорт

	Запрос = Новый Запрос;
	Запрос.МенеджерВременныхТаблиц = МенеджерВременныхТаблиц;
	
	Запрос.Текст = 
	"ВЫБРАТЬ
	|	Начисления.Ссылка КАК Ссылка
	|ПОМЕСТИТЬ ВТНачисленияБазаОтпуска
	|ИЗ
	|	ПланВидовРасчета.Начисления КАК Начисления
	|ГДЕ
	|	НЕ Начисления.КатегорияНачисленияИлиНеоплаченногоВремени В (ЗНАЧЕНИЕ(Перечисление.КатегорииНачисленийИНеоплаченногоВремени.ОплатаОтпуска), ЗНАЧЕНИЕ(Перечисление.КатегорииНачисленийИНеоплаченногоВремени.ОплатаБольничногоЛиста), ЗНАЧЕНИЕ(Перечисление.КатегорииНачисленийИНеоплаченногоВремени.ОплатаБольничногоЛистаЗаСчетРаботодателя), ЗНАЧЕНИЕ(Перечисление.КатегорииНачисленийИНеоплаченногоВремени.ОплатаБольничногоПрофзаболевание), ЗНАЧЕНИЕ(Перечисление.КатегорииНачисленийИНеоплаченногоВремени.ОплатаБольничногоНесчастныйСлучайНаПроизводстве), ЗНАЧЕНИЕ(Перечисление.КатегорииНачисленийИНеоплаченногоВремени.ОтпускПоБеременностиИРодам))
	|
	|ИНДЕКСИРОВАТЬ ПО
	|	Ссылка";
	Запрос.Выполнить();
	
КонецПроцедуры

Процедура ОбновитьВидОперацииЕжегодныеОтпуска() Экспорт

	Запрос = Новый Запрос;
	Запрос.Текст = 
	"ВЫБРАТЬ
	|	Начисления.Ссылка
	|ИЗ
	|	ПланВидовРасчета.Начисления КАК Начисления
	|ГДЕ
	|	Начисления.КатегорияНачисленияИлиНеоплаченногоВремени = ЗНАЧЕНИЕ(Перечисление.КатегорииНачисленийИНеоплаченногоВремени.ОплатаОтпуска)
	|	И Начисления.ВидОперацииПоЗарплате <> ЗНАЧЕНИЕ(Перечисление.ВидыОперацийПоЗарплате.ЕжегодныйОтпуск)";
	Выборка = Запрос.Выполнить().Выбрать();
	Пока Выборка.Следующий() Цикл
		
		НачислениеОбъект = Выборка.Ссылка.ПолучитьОбъект();
		НачислениеОбъект.ВидОперацииПоЗарплате = Перечисления.ВидыОперацийПоЗарплате.ЕжегодныйОтпуск;
		НачислениеОбъект.ОбменДанными.Загрузка = Истина;
		НачислениеОбъект.Записать();
		
	КонецЦикла;	

КонецПроцедуры

Функция СтрокаПолейТаблицыНачисленияСРаспределениемПоЕНВД() Экспорт

	Возврат "Сотрудник,Подразделение,Начисление,ДатаНачала,ОблагаетсяЕНВД,Сумма";

КонецФункции

Процедура СоздатьВТСтраховыеВзносыПоИсточникамФинансирования(Движения, Организация, ПериодРегистрации, Ссылка, МенеджерВременныхТаблиц) Экспорт
	
	Запрос = Новый Запрос;
	Запрос.МенеджерВременныхТаблиц = МенеджерВременныхТаблиц;
	Запрос.Текст = 
	"ВЫБРАТЬ
	|	*,
	|	ЗНАЧЕНИЕ(Справочник.СтатьиФинансированияЗарплата.ПустаяСсылка) КАК СтатьяФинансирования,
	|	ЗНАЧЕНИЕ(Справочник.СтатьиРасходовЗарплата.ПустаяСсылка) КАК СтатьяРасходов,
	|	ЗНАЧЕНИЕ(Справочник.СпособыОтраженияЗарплатыВБухУчете.ПустаяСсылка) КАК СпособОтраженияЗарплатыВБухучете
	|ПОМЕСТИТЬ ВТСтраховыеВзносыПоИсточникамФинансирования
	|ИЗ
	|	ВТРасширенныеСведенияОВзносах КАК СведенияОВзносах";
	Запрос.Выполнить();
	
КонецПроцедуры

Процедура СведенияОБухучетеНачисленийИВзносовПоСтатьямФинансирования(Организация, ПериодРегистрации, МенеджерВременныхТаблиц) Экспорт

	Запрос = Новый Запрос;
	Запрос.МенеджерВременныхТаблиц = МенеджерВременныхТаблиц;
	Запрос.Текст = 
	"ВЫБРАТЬ ПЕРВЫЕ 0
	|	NULL КАК ПериодРегистрации,
	|	NULL КАК Организация,
	|	NULL КАК ИдентификаторСтроки,
	|	NULL КАК Сотрудник,
	|	NULL КАК ФизическоеЛицо,
	|	NULL КАК Подразделение,
	|	NULL КАК ДатаНачала,
	|	NULL КАК ДатаОкончания,
	|	NULL КАК ВидОперации,
	|	NULL КАК Начисление,
	|	NULL КАК СпособОтраженияЗарплатыВБухучете,
	|	NULL КАК  СтатьяФинансирования,
	|	NULL КАК  СтатьяРасходов,
	|	NULL КАК ОблагаетсяЕНВД,
	|	NULL КАК Сумма,
	|	NULL КАК ДокументОснование,
	|	NULL КАК ПериодПринятияРасходов,
	|	NULL КАК ВидНачисленияОплатыТрудаДляНУ
	|ПОМЕСТИТЬ ВТБухучетНачислений
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ ПЕРВЫЕ 0
	|	NULL КАК Сотрудник,
	|	NULL КАК ФизическоеЛицо,
	|	NULL КАК Подразделение,
	|	NULL КАК Начисление,
	|	NULL КАК ВидОперации,
	|	0 КАК СтраховыеВзносы,
	|	NULL КАК ОблагаетсяЕНВД,
	|	NULL КАК СтатьяФинансирования,
	|	NULL КАК СтатьяРасходов,
	|	NULL КАК СпособОтраженияЗарплатыВБухучете,
	|	NULL ПериодПринятияРасходов,
	|	NULL КАК ДатаНачала
	|ПОМЕСТИТЬ ВТБухучетСтраховыхВзносов";
	
	ТекстПолейВзносов = "";
	Для каждого ИмяПоля Из СтроковыеФункцииКлиентСервер.РазложитьСтрокуВМассивПодстрок(УчетСтраховыхВзносов.ОтражаемыеВУчетеВзносы(Истина)) Цикл
		ТекстПолейВзносов = ТекстПолейВзносов + "0 КАК " + ИмяПоля + "," + Символы.ПС;
	КонецЦикла;
	Запрос.Текст = СтрЗаменить(Запрос.Текст, "0 КАК СтраховыеВзносы,", ТекстПолейВзносов);
	
	Запрос.Выполнить();
	

КонецПроцедуры

#КонецОбласти
