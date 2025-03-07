
#Область СлужебныеПроцедурыИФункции

Функция ОписаниеДокументаОтклонения() Экспорт
	
	ОписаниеДокумента = Новый Структура;
	ОписаниеДокумента.Вставить("СотрудникПутьКДанным");
	ОписаниеДокумента.Вставить("ЗамещаемыйВидВремениПутьКДанным");
	ОписаниеДокумента.Вставить("ПредставлениеВидаВремениПутьКДанным");
	ОписаниеДокумента.Вставить("ПериодРегистрацииПутьКДанным");
	ОписаниеДокумента.Вставить("ДатаНачалаСобытияПутьКДанным");
	ОписаниеДокумента.Вставить("ДатаНачалаПериодаОтклоненияПутьКДанным");
	ОписаниеДокумента.Вставить("ДатаОкончанияПериодаОтклоненияПутьКДанным");
	ОписаниеДокумента.Вставить("ДатаВнутрисменногоОтклоненияПутьКДанным");
	ОписаниеДокумента.Вставить("ВидРасчетаПутьКДанным");
	ОписаниеДокумента.Вставить("ПризнакЧасовоеОтклонениеПутьКДанным");
	ОписаниеДокумента.Вставить("ИмяЭлементаЗамещаемыйВидВремени");
	ОписаниеДокумента.Вставить("ИмяЭлементаВидРасчета");
	ОписаниеДокумента.Вставить("СотрудникВШапкеДокумента");
	ОписаниеДокумента.Вставить("ЗаполнитьПериодДокументаПоУмолчанию", Истина);
	
	Возврат ОписаниеДокумента;
	
КонецФункции

Функция ДокументыОтклоненийДанныеФормыПоОписанию(Форма, ОписаниеДокумента, ЗаполнятьСписокСотрудников = Ложь) Экспорт
	
	ДанныеФормы = Новый Структура;
	
	ДанныеФормы = Новый Структура;
	ДанныеФормы.Вставить("ЗамещаемыйВидВремени", ОбщегоНазначенияКлиентСервер.ПолучитьРеквизитФормыПоПути(Форма, ОписаниеДокумента.ЗамещаемыйВидВремениПутьКДанным));
	ДанныеФормы.Вставить("ПредставлениеВидаВремени", ОбщегоНазначенияКлиентСервер.ПолучитьРеквизитФормыПоПути(Форма, ОписаниеДокумента.ПредставлениеВидаВремениПутьКДанным));
	ДанныеФормы.Вставить("ПериодРегистрации", ОбщегоНазначенияКлиентСервер.ПолучитьРеквизитФормыПоПути(Форма, ОписаниеДокумента.ПериодРегистрацииПутьКДанным));
	ДанныеФормы.Вставить("ДатаНачалаСобытия", ОбщегоНазначенияКлиентСервер.ПолучитьРеквизитФормыПоПути(Форма, ОписаниеДокумента.ДатаНачалаСобытияПутьКДанным));
	ДанныеФормы.Вставить("ДатаНачалаПериодаОтклонения", ОбщегоНазначенияКлиентСервер.ПолучитьРеквизитФормыПоПути(Форма, ОписаниеДокумента.ДатаНачалаПериодаОтклоненияПутьКДанным));
	ДанныеФормы.Вставить("ДатаОкончанияПериодаОтклонения", ОбщегоНазначенияКлиентСервер.ПолучитьРеквизитФормыПоПути(Форма, ОписаниеДокумента.ДатаОкончанияПериодаОтклоненияПутьКДанным));
	ДанныеФормы.Вставить("ДатаВнутрисменногоОтклонения", ОбщегоНазначенияКлиентСервер.ПолучитьРеквизитФормыПоПути(Форма, ОписаниеДокумента.ДатаВнутрисменногоОтклоненияПутьКДанным));
	ДанныеФормы.Вставить("ВидРасчета", ОбщегоНазначенияКлиентСервер.ПолучитьРеквизитФормыПоПути(Форма, ОписаниеДокумента.ВидРасчетаПутьКДанным));
	ДанныеФормы.Вставить("ПризнакЧасовоеОтклонение", ОбщегоНазначенияКлиентСервер.ПолучитьРеквизитФормыПоПути(Форма,ОписаниеДокумента.ПризнакЧасовоеОтклонениеПутьКДанным));
	
	Если ЗаполнятьСписокСотрудников Тогда
		Сотрудники = Новый Массив;
		Если ОписаниеДокумента.СотрудникВШапкеДокумента Тогда
			Сотрудники.Добавить(ОбщегоНазначенияКлиентСервер.ПолучитьРеквизитФормыПоПути(Форма, ОписаниеДокумента.СотрудникПутьКДанным));
		Иначе
			ЭлементыПути = СтроковыеФункцииКлиентСервер.РазложитьСтрокуВМассивПодстрок(ОписаниеДокумента.СотрудникПутьКДанным, ".");
			
			ПутьКТаблице = "";
			Для Сч = 0 По ЭлементыПути.Количество() - 2 Цикл
				ПутьКТаблице = ПутьКТаблице + "." +  ЭлементыПути[Сч];
			КонецЦикла;
			
			ПутьКТаблице = Сред(ПутьКТаблице, 2);
			
			ТаблицаСотрудники = ОбщегоНазначенияКлиентСервер.ПолучитьРеквизитФормыПоПути(Форма, ПутьКТаблице);
			
			Для Каждого СтрокаТаблицы Из ТаблицаСотрудники Цикл
				Сотрудники.Добавить(СтрокаТаблицы[ЭлементыПути[ЭлементыПути.Количество() - 1]]);
			КонецЦикла;
		КонецЕсли;
		
		ДанныеФормы.Вставить("Сотрудники", Сотрудники);
	КонецЕсли;
	
	Возврат ДанныеФормы;
	
КонецФункции

Процедура ТабельЗаполнитьИтогиПоСотруднику(МассивСтрокПоСотруднику, ОписаниеВидовВремени) Экспорт
	
	КоличествоСтрокПоСотруднику = МассивСтрокПоСотруднику.Количество();

	Если КоличествоСтрокПоСотруднику = 0 Тогда
		Возврат;
	КонецЕсли;	
	
	ИтогиПоВидамВремени = Новый Соответствие;
	
	МаксимальноеКоличествоДней = 0;
	Для Каждого СтрокаПоСотруднику Из МассивСтрокПоСотруднику Цикл
		Для НомерДня = 1 По 31 Цикл
			ВидВремени = СтрокаПоСотруднику["ВидВремени" + НомерДня];
			Если ЗначениеЗаполнено(ВидВремени) Тогда
				Часы = СтрокаПоСотруднику["Часов" + НомерДня];
				ИтогиПоВидуВремени = ИтогиПоВидамВремени.Получить(ВидВремени);
				Если ИтогиПоВидуВремени = Неопределено Тогда
					ИтогиПоВидамВремени.Вставить(ВидВремени, Новый Структура("Часы, Дни", Часы, 1));
				Иначе
					ИтогиПоВидуВремени.Часы = ИтогиПоВидуВремени.Часы + Часы;
					ИтогиПоВидуВремени.Дни = ИтогиПоВидуВремени.Дни + 1;
					Если ИтогиПоВидуВремени.Дни > МаксимальноеКоличествоДней Тогда
						МаксимальноеКоличествоДней = ИтогиПоВидуВремени.Дни;
						ПервыйВидВремени = ВидВремени;
					КонецЕсли;
				КонецЕсли;
			КонецЕсли;
		КонецЦикла;
	КонецЦикла;
		
	МассивСтрокПоСотруднику[0].ВремяИтог =  ТабельПредставлениеИтогаПоВидуВремени(ПервыйВидВремени, ИтогиПоВидамВремени, ОписаниеВидовВремени);
	
	ПоследняяСтрокаПоСотруднику = МассивСтрокПоСотруднику[0];
	
	ДополнениеИтогаКПоследнейСтроке = "";
	
	НомерСтроки = 2;
	Для Каждого КлючЗначение Из ИтогиПоВидамВремени Цикл
		Если КлючЗначение.Ключ <> ПервыйВидВремени Тогда  
			
			ПредставлениеИтогаПоВидуВремени = ТабельПредставлениеИтогаПоВидуВремени(КлючЗначение.Ключ, ИтогиПоВидамВремени, ОписаниеВидовВремени);
			
			Если НомерСтроки <= КоличествоСтрокПоСотруднику Тогда 
				ОбрабатываемаяСтрока = МассивСтрокПоСотруднику[НомерСтроки - 1];
				
				ОбрабатываемаяСтрока.ВремяИтог = ПредставлениеИтогаПоВидуВремени;
				
				Если ОбрабатываемаяСтрока.НомерСтроки > ПоследняяСтрокаПоСотруднику.НомерСтроки Тогда
					ПоследняяСтрокаПоСотруднику = ОбрабатываемаяСтрока;
				КонецЕсли;	
		
				НомерСтроки = НомерСтроки + 1;
			Иначе
				ДополнениеИтогаКПоследнейСтроке = ДополнениеИтогаКПоследнейСтроке + "
					|" + ПредставлениеИтогаПоВидуВремени; 
			КонецЕсли;	
		КонецЕсли;
	КонецЦикла;
	
	ПоследняяСтрокаПоСотруднику.ВремяИтог = ПоследняяСтрокаПоСотруднику.ВремяИтог + ДополнениеИтогаКПоследнейСтроке; 
КонецПроцедуры

Функция ТабельПредставлениеВремениПоВиду(ОбозначениеВремени, КоличествоЧасов) Экспорт 
	
	Если Не ПустаяСтрока(ОбозначениеВремени) Или КоличествоЧасов <> 0 Тогда
		Возврат ОбозначениеВремени + " " + Формат(КоличествоЧасов, "ЧГ=");
	Иначе
		Возврат "";
	КонецЕсли;
	
КонецФункции

Функция ТабельСтрокиПоСотруднику(ДанныеОВремени, НомерСтрокиСотрудник) Экспорт
	
	Возврат ДанныеОВремени.НайтиСтроки(Новый Структура("НомерСтрокиСотрудник", НомерСтрокиСотрудник));
	
КонецФункции

Функция ТабельОбозначенияВидовВремени(СоответствиеОбозначенийВидамВремени) Экспорт
	
	ОбозначенияВидовВремени = Новый Соответствие;
	Для Каждого КлючЗначение Из СоответствиеОбозначенийВидамВремени Цикл
		ОбозначенияВидовВремени.Вставить(КлючЗначение.Значение.ВидВремени, КлючЗначение.Ключ);
	КонецЦикла;
	
	Возврат ОбозначенияВидовВремени;
	
КонецФункции

Функция ТабельГоловнаяСтрокаТекущегоСотрудника(ДанныеОВремени, ДанныеТекущейСтроки) Экспорт
	
	НомерСтрокиТекущегоСотрудника = 0;
	Если ДанныеТекущейСтроки.ЭтоПерваяСтрокаПоСотруднику Тогда
		Возврат ДанныеТекущейСтроки;
	Иначе
		НайденныеСтроки = ДанныеОВремени.НайтиСтроки(Новый Структура("ЭтоПерваяСтрокаПоСотруднику, НомерСтрокиСотрудник", Истина, ДанныеТекущейСтроки.НомерСтрокиСотрудник));
		Если НайденныеСтроки.Количество() > 0 Тогда
			Возврат НайденныеСтроки[0];
		Иначе
			Возврат Неопределено
		КонецЕсли;
	КонецЕсли;
	
КонецФункции

Функция ТабельГоловныеСтрокиСотрудников(ДанныеОВремени) Экспорт
	
	Возврат ДанныеОВремени.НайтиСтроки(Новый Структура ("ЭтоПерваяСтрокаПоСотруднику", Истина));
	
КонецФункции

Функция ТабельНоваяСтрокаПоСотруднику(ДанныеОВремени, ГоловнаяСтрокаПоСотруднику) Экспорт 
	
	ИндексГоловнойСтроки = ДанныеОВремени.Индекс(ГоловнаяСтрокаПоСотруднику);
	
	ОбщееКоличествоСтрок = ДанныеОВремени.Количество();
	
	СтруктураПоиска = Новый Структура("НомерСтрокиСотрудник, ЭтоПерваяСтрокаПоСотруднику",
									ГоловнаяСтрокаПоСотруднику.НомерСтрокиСотрудник + 1,
									ГоловнаяСтрокаПоСотруднику.ЭтоПерваяСтрокаПоСотруднику);
	
	СтрокиСледующегоСотрудника = ДанныеОВремени.НайтиСтроки(СтруктураПоиска);
	
	Если СтрокиСледующегоСотрудника.Количество() > 0 Тогда
		ИндексДобавляемойСтроки = ДанныеОВремени.Индекс(СтрокиСледующегоСотрудника[0]); 
		НоваяСтрока = ДанныеОВремени.Вставить(ИндексДобавляемойСтроки);
	Иначе
		НоваяСтрока = ДанныеОВремени.Добавить();
	КонецЕсли;
	
	НоваяСтрока.НомерСтрокиСотрудник = ГоловнаяСтрокаПоСотруднику.НомерСтрокиСотрудник;
	НоваяСтрока.Сотрудник = ГоловнаяСтрокаПоСотруднику.Сотрудник;
	НоваяСтрока.ЧетнаяСтрока = ГоловнаяСтрокаПоСотруднику.ЧетнаяСтрока;
	НоваяСтрока.ПустаяСтрока = Истина;
	
	Возврат НоваяСтрока;
	
КонецФункции

Процедура ТабельУстановитьИнфонадписьВысотаСтрок(Форма) Экспорт
	
	Форма.УстанавливаемаяВысотаСтроки = Форма.ВысотаСтроки;
	Если Форма.Объект.ДанныеОВремени.Количество() = 0 Тогда
		Форма.ИнфонадписьВысотаСтрок = НСтр("ru='Документ не заполнен.';uk='Документ не заповнено.'");
	Иначе
		Обозначение = НСтр("ru='видов';uk='видів'");
		
		Если Форма.ВысотаСтроки >= 5 И Форма.ВысотаСтроки <= 20 Тогда 
			Окончание = НСтр("ru='ти';uk='ти'");
			Обозначение = НСтр("ru='записей';uk='записів'");
		ИначеЕсли (Форма.ВысотаСтроки + 10) % 10 > 1 И (Форма.ВысотаСтроки + 10) % 10 < 5 Тогда
			Окончание = НСтр("ru='х';uk='х'");	
			Обозначение = НСтр("ru='записей';uk='записів'");
		ИначеЕсли (Форма.ВысотаСтроки + 10) % 10 >= 5 Тогда
			Окончание = НСтр("ru='ти';uk='ти'");
			Обозначение = НСтр("ru='записей';uk='записів'");
		ИначеЕсли (Форма.ВысотаСтроки + 10) % 10 = 1 Тогда
			Окончание = НСтр("ru='ой';uk='ой'");	
			Обозначение = НСтр("ru='записи';uk='записи'");
		Иначе
			Окончание = НСтр("ru='ти';uk='ти'");
			Обозначение = НСтр("ru='записей';uk='записів'");
		КонецЕсли;
		Инфонадпись = НСтр("ru='Увеличьте, если хотя бы на один день необходимо ввести более %1-%2 %3 с разными видами времени';uk='Збільшіть, якщо хоча б на один день необхідно ввести більше %1-%2 %3 з різними видами часу'");
		Форма.ИнфонадписьВысотаСтрок = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(Инфонадпись, Формат(Форма.ВысотаСтроки, "ЧГ="), Окончание, Обозначение);
	КонецЕсли;
	
КонецПроцедуры

Функция ТабельРазобратьСтрокуВремени(ОписаниеВидовВремени, ОбозначениеВидаВремениПоУмолчанию, Знач ПредставлениеДанныхОВремени, Отказ = Ложь) Экспорт
	
	ТабельЗаменитьРазделителиПробелами(ПредставлениеДанныхОВремени);
	Если ПустаяСтрока(ПредставлениеДанныхОВремени) Тогда
		Возврат Неопределено;
	КонецЕсли;
	
	МассивПодстрок = СтроковыеФункцииКлиентСервер.РазложитьСтрокуВМассивПодстрок(ПредставлениеДанныхОВремени, " ");
	
	Если МассивПодстрок.Количество() > 2 Тогда
		Отказ = Истина;
		Возврат Неопределено;
	КонецЕсли;
	
	ЕстьПробел = СтрНайти(ПредставлениеДанныхОВремени, " ") > 0;
	
	Часы = 0;
	ЕстьБуквенноеОбозначение = Ложь;
	БуквенноеОбозначение = "";
	Для Каждого Подстрока Из МассивПодстрок Цикл
		СтрокаБезРазделителей = СтрЗаменить(Подстрока, ".", "");
		СтрокаБезРазделителей = СтрЗаменить(СтрокаБезРазделителей, ",", "");
		Если СтроковыеФункцииКлиентСервер.ТолькоЦифрыВСтроке(СтрокаБезРазделителей)
			И СтрДлина(Подстрока) <= СтрДлина(СтрокаБезРазделителей) + 1 Тогда
			Часы = Число(СтрЗаменить(Подстрока, ".", ","));
		Иначе
			Если ЕстьБуквенноеОбозначение Тогда
				Отказ = Истина;
				Возврат Неопределено;
			КонецЕсли;
			
			БуквенноеОбозначение = ВРег(Подстрока); 
			ЕстьБуквенноеОбозначение = Истина;
		КонецЕсли;
		
	КонецЦикла;
	
	Возврат Новый Структура("БуквенноеОбозначение, Часы, ЕстьРазделитель", БуквенноеОбозначение, Часы, ЕстьБуквенноеОбозначение И ЕстьПробел)
	
КонецФункции

Процедура ТабельЗаменитьРазделителиПробелами(ПредставлениеДанныхОВремени)
	
	СтрокаРазделителей = " -/:;" + Символы.ПС;
	
	СтрокаРезультат = "";
	
	ПредставлениеДанныхОВремени = СокрЛП(ПредставлениеДанныхОВремени);
	ДлинаСтроки = СтрДлина(ПредставлениеДанныхОВремени);
	
	ПредыдущийСимволРазделитель = Ложь;
	Для Сч = 1 По ДлинаСтроки Цикл
		Символ = Сред(ПредставлениеДанныхОВремени, Сч, 1);
		Если СтрНайти(СтрокаРазделителей, Символ) = 0 Тогда
			СтрокаРезультат = СтрокаРезультат + Символ;
			ПредыдущийСимволРазделитель = Ложь;
		ИначеЕсли Не ПредыдущийСимволРазделитель Тогда
			СтрокаРезультат = СтрокаРезультат + " ";
			ПредыдущийСимволРазделитель = Истина;
		КонецЕсли;
	КонецЦикла;
	
	ПредставлениеДанныхОВремени = СтрокаРезультат;
	
КонецПроцедуры

Функция ТабельПредставлениеИтогаПоВидуВремени(ВидВремени, ИтогиПоВидамВремени, ОписаниеВидовВремени)
	ПредставлениеИтогаПоВидуВремени = "";
	
	ОписаниеВидаВремени = ОписаниеВидовВремени.Получить(ВидВремени);
	
	БуквенноеОбозначение = ?(ОписаниеВидаВремени = Неопределено, "", ОписаниеВидаВремени);
	
	ИтогиПоВидуВремени = ИтогиПоВидамВремени.Получить(ВидВремени);
	
	Если ОписаниеВидаВремени <> Неопределено Тогда
	
		ПредставлениеИтогаПоВидуВремени = БуквенноеОбозначение + ?(БуквенноеОбозначение = "", "" , " ") 
										+ Строка(ИтогиПоВидуВремени.Дни) + НСтр("ru=' д.';uk=' дн.'") 
										+ ?(ИтогиПоВидуВремени.Часы > 0, " " + Строка(ИтогиПоВидуВремени.Часы) + НСтр("ru=' ч.';uk=' год.'") , "");
	КонецЕсли;										
									
	Возврат ПредставлениеИтогаПоВидуВремени;								
КонецФункции

Функция ТабельНомерДняПоИмениЭлемента(ИмяПоля) Экспорт
	
	ОбрабатываемыйТекст = СтрЗаменить(ИмяПоля, "ДанныеОВремениВремя", "");
	ОбрабатываемыйТекст = СтрЗаменить(ОбрабатываемыйТекст, "Представление", "");
	
	Если СтроковыеФункцииКлиентСервер.ТолькоЦифрыВСтроке(ОбрабатываемыйТекст) Тогда
		Возврат Число(ОбрабатываемыйТекст);
	Иначе
		Возврат Неопределено;
	КонецЕсли;
	
КонецФункции

Процедура ТабельУстановитьДоступностьЭлементовПериодаВводаДанных(Форма) Экспорт
	
	Если Не Форма.Объект.ИсправленныйДокумент.Пустая() Тогда
		Форма.Элементы.ДатаНачалаПериода.Доступность = Ложь;
		Форма.Элементы.ДатаОкончанияПериода.Доступность = Ложь;
		Форма.Элементы.ПериодВводаДанныхОВремени.Доступность = Ложь;
	ИначеЕсли Форма.Объект.ПериодВводаДанныхОВремени = ПредопределенноеЗначение("Перечисление.ПериодыВводаДанныхОВремени.ПерваяПоловинаТекущегоМесяца") Тогда
		Форма.Элементы.ДатаНачалаПериода.Доступность = Ложь;
		Форма.Элементы.ДатаОкончанияПериода.Доступность = Ложь;
	ИначеЕсли Форма.Объект.ПериодВводаДанныхОВремени = ПредопределенноеЗначение("Перечисление.ПериодыВводаДанныхОВремени.ВтораяПоловинаТекущегоМесяца") Тогда
		Форма.Элементы.ДатаНачалаПериода.Доступность = Ложь;
		Форма.Элементы.ДатаОкончанияПериода.Доступность = Ложь;
	ИначеЕсли Форма.Объект.ПериодВводаДанныхОВремени = ПредопределенноеЗначение("Перечисление.ПериодыВводаДанныхОВремени.ТекущийМесяц") Тогда
		Форма.Элементы.ДатаНачалаПериода.Доступность = Ложь;
		Форма.Элементы.ДатаОкончанияПериода.Доступность = Ложь;
	ИначеЕсли Форма.Объект.ПериодВводаДанныхОВремени = ПредопределенноеЗначение("Перечисление.ПериодыВводаДанныхОВремени.ПрошлыйПериод") Тогда
		Форма.Элементы.ДатаНачалаПериода.Доступность = Истина;
		Форма.Элементы.ДатаОкончанияПериода.Доступность = Истина;
	КонецЕсли;
	
КонецПроцедуры

Процедура ТабельУстановитьПериодДокумента(Форма) Экспорт
	
	Если Форма.Объект.ПериодВводаДанныхОВремени = ПредопределенноеЗначение("Перечисление.ПериодыВводаДанныхОВремени.ПерваяПоловинаТекущегоМесяца") Тогда
		Форма.Объект.ДатаНачалаПериода = НачалоМесяца(Форма.Объект.ПериодРегистрации);
		Форма.Объект.ДатаОкончанияПериода = Дата(Год(Форма.Объект.ПериодРегистрации), Месяц(Форма.Объект.ПериодРегистрации), 15);
	ИначеЕсли Форма.Объект.ПериодВводаДанныхОВремени = ПредопределенноеЗначение("Перечисление.ПериодыВводаДанныхОВремени.ВтораяПоловинаТекущегоМесяца") Тогда
		Форма.Объект.ДатаНачалаПериода = Дата(Год(Форма.Объект.ПериодРегистрации), Месяц(Форма.Объект.ПериодРегистрации), 16);
		Форма.Объект.ДатаОкончанияПериода = КонецМесяца(Форма.Объект.ПериодРегистрации);
	ИначеЕсли Форма.Объект.ПериодВводаДанныхОВремени = ПредопределенноеЗначение("Перечисление.ПериодыВводаДанныхОВремени.ТекущийМесяц") Тогда
		Форма.Объект.ДатаНачалаПериода = НачалоМесяца(Форма.Объект.ПериодРегистрации);
		Форма.Объект.ДатаОкончанияПериода = КонецМесяца(Форма.Объект.ПериодРегистрации);
	КонецЕсли;
	
КонецПроцедуры

Процедура ДанныеГрафикаРассчитатьИтогоПоСтроке(ДанныеСтроки) Экспорт
	
	ВсегоДней = 0;
	ВсегоЧасов = 0;
	Для НомерДня = 1 По 31 Цикл
		ВсегоЧасов = ВсегоЧасов + ДанныеСтроки["День" + НомерДня];
		ВсегоДней = ВсегоДней + ?(ДанныеСтроки["День" + НомерДня] > 0, 1, 0)
	КонецЦикла;
	ДанныеСтроки.ИтогДни = ВсегоДней;
	ДанныеСтроки.ИтогЧасы = ВсегоЧасов;
	
КонецПроцедуры

Функция ДанныеГрафикаЧасыПоДнямЦикла(ШаблонЗаполнения, ДанныеОРабочихЧасах) Экспорт
	
	ЧасыПоДнямЦикла = Новый Соответствие;
	
	Для Каждого ДеньЦикла Из ШаблонЗаполнения Цикл
		ЧасыЗаДень = Новый Соответствие;
		
		ДанныеОВремениЗаДень = ДанныеОРабочихЧасах.НайтиСтроки(Новый Структура("НомерДняЦикла", ДеньЦикла.НомерСтроки));
		Для Каждого ДанныеВидуВремени Из ДанныеОВремениЗаДень Цикл
			ЧасыЗаДень.Вставить(ДанныеВидуВремени.ВидВремени, ДанныеВидуВремени.Часов);
		КонецЦикла;
		
		ЧасыПоДнямЦикла.Вставить(ДеньЦикла.НомерСтроки, ЧасыЗаДень);
	КонецЦикла;
	
	Возврат ЧасыПоДнямЦикла;
	
КонецФункции

#КонецОбласти
