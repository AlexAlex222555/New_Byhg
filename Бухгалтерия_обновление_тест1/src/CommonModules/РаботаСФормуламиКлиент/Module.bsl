
#Область ПрограммныйИнтерфейс

// Осуществляет проверку формулы при интерактивных действиях пользователя
//
// Параметры:
// Формула          - Строка - формула, которую нужно проверить на корректность
// Операнды         - Массив - операнды формулы
// Поле - Строка    - имя поля, к которому необходимо привязать сообщение
// СтроковаяФормула - Булево - признак, что формула строковая.
//
Процедура ПроверитьФормулуИнтерактивно(Формула, Операнды, Знач Поле, СтроковаяФормула = Ложь, ДополнительныеПараметры = Неопределено) Экспорт
	
	Если ЗначениеЗаполнено(Формула) Тогда
		Если ПроверитьФормулу(Формула, Операнды, Поле, , СтроковаяФормула, , ДополнительныеПараметры) Тогда
			
			ПоказатьОповещениеПользователя(
				НСтр("ru='В формуле ошибок не обнаружено';uk='У формулі помилок не виявлено'"),
				,
				,
				БиблиотекаКартинок.Информация32);
			
		КонецЕсли;
	КонецЕсли;
	
КонецПроцедуры

// Осуществляет проверку корректности формулы
//
// Параметры:
//   Формула                 - Строка - текст формулы
//   Операнды                - Массив - операнды формулы
//   Поле                    - Строка - имя поля, к которому необходимо привязать сообщение
//   СообщениеОбОшибке       - Строка - текст сообщения об ошибке
//   СтроковаяФормула        - Булево - признак строковой формулы
//   ПутьКДанным             - Строка - путь к данным, для выдачи сообщения об ошибке
//   ДополнительныеПараметры - Структура - поддерживаемые параметры:
//    * НеВыводитьСообщения - Булево - признак того что не нужно выводить сообщения пользователю, по умолчанию выводятся
//    * ТипРезультата       - ОписаниеТипов - возможные типы, возвращаемые формулой.
//
// Возвращаемое значение:
//  Булево - Ложь, если есть ошибки, иначе Истина.
//
Функция ПроверитьФормулу(Формула, Операнды, Знач Поле = "", Знач СообщениеОбОшибке = "", СтроковаяФормула = Ложь,
		ПутьКДанным = "", ДополнительныеПараметры = Неопределено) Экспорт
		
	Перем ТипРезультата, ФормулаДляВычисленияВЗапросе;
		
	Результат = Истина;
	
	ВыводитьСообщения = Истина;
	Если ДополнительныеПараметры <> Неопределено 
		И ДополнительныеПараметры.Свойство("НеВыводитьСообщения") 
		И ДополнительныеПараметры.НеВыводитьСообщения Тогда
		ВыводитьСообщения = Ложь;
	КонецЕсли;
	
	Если ЗначениеЗаполнено(Формула) Тогда
		
		Если СтроковаяФормула Тогда
			ТекстРасчета = """Строка"" + " + Формула;
			ЗначениеЗамены = """1""";
		Иначе
			ТипРезультата = Неопределено;
			Если ДополнительныеПараметры <> Неопределено Тогда
				ДополнительныеПараметры.Свойство("ТипРезультата", ТипРезультата);
			КонецЕсли;
			Если ТипРезультата = Новый ОписаниеТипов("Дата") Тогда
				ЗначениеЗамены = ОбщегоНазначенияКлиент.ДатаСеанса();
			Иначе
				ЗначениеЗамены = "1 ";
			КонецЕсли;
			ТекстРасчета = Формула;
		КонецЕсли;
		
		Для Каждого Операнд Из Операнды Цикл
			ТекстРасчета = СтрЗаменить(ТекстРасчета, РаботаСФормуламиКлиентСервер.ПолучитьТекстОперандаДляВставки(Операнд), ЗначениеЗамены);
		КонецЦикла;
		
		Попытка
			
			//++ НЕ УТ
			Если ДополнительныеПараметры <> Неопределено 
				И ДополнительныеПараметры.Свойство("ФормулаДляВычисленияВЗапросе", ФормулаДляВычисленияВЗапросе)
				И ФормулаДляВычисленияВЗапросе Тогда
				
				РезультатРасчета = РаботаСФормуламиВызовСервера.ПроверитьФормулуЗапроса(ТекстРасчета, ЗначениеЗамены);
				
			Иначе
			//-- НЕ УТ
				ФункцииИзОбщегоМодуля = Неопределено;
				Если ДополнительныеПараметры <> Неопределено 
					И ДополнительныеПараметры.Свойство("ФункцииИзОбщегоМодуля", ФункцииИзОбщегоМодуля) Тогда
					
					Для каждого ТекущаяСтрока Из ФункцииИзОбщегоМодуля Цикл
						ТекстРасчета = СтрЗаменить(ТекстРасчета, ТекущаяСтрока.Ключ, ТекущаяСтрока.Значение);
					КонецЦикла; 
					
				КонецЕсли;
				
				РезультатРасчета = Вычислить(ТекстРасчета);
			
			//++ НЕ УТ
			КонецЕсли;
			//-- НЕ УТ
			
			Если СтроковаяФормула 
				Или ДополнительныеПараметры <> Неопределено
				И ДополнительныеПараметры.Свойство("ВыбиратьОперандПлана")
				И ДополнительныеПараметры.ВыбиратьОперандПлана Тогда
				ТекстПроверки = СтрЗаменить(Формула, Символы.ПС, "");
				ТекстПроверки = СтрЗаменить(ТекстПроверки, " ", "");
				ОтсутствиеРазделителей = Найти(ТекстПроверки, "][")
					+ Найти(ТекстПроверки, """[")
					+ Найти(ТекстПроверки, "]""");
				Если ОтсутствиеРазделителей > 0 Тогда
					Если ВыводитьСообщения Тогда
						ОбщегоНазначенияКлиентСервер.СообщитьПользователю(
						НСтр("ru='В формуле обнаружены ошибки. Между операндами должен присутствовать оператор или разделитель';uk='У формулі виявлені помилки. Між операндами повинен бути оператор або роздільник'"),
						,
						Поле,
						ПутьКДанным,);
					КонецЕсли;
					Результат = Ложь;
				КонецЕсли;
			КонецЕсли;
			
			Если ДополнительныеПараметры <> Неопределено И ДополнительныеПараметры.Свойство("ТипРезультата") Тогда
				
				ТипРезультатаРасчетаПравильный = Ложь;
				
				Для Каждого ДопустимыйТип Из ДополнительныеПараметры.ТипРезультата.Типы() Цикл
					Если ТипЗнч(РезультатРасчета) = ДопустимыйТип Тогда
						ТипРезультатаРасчетаПравильный = Истина;
						Прервать;
					КонецЕсли;
				КонецЦикла;
				
				Если Не ТипРезультатаРасчетаПравильный Тогда
					Если ВыводитьСообщения Тогда
						ОбщегоНазначенияКлиентСервер.СообщитьПользователю(
						НСтр("ru='В формуле обнаружены ошибки. Результат расчета должен быть типа Булево';uk='У формулі виявлені помилки. Результат розрахунку повинен бути типу Булево'"),
						,
						Поле,
						ПутьКДанным,);
					КонецЕсли;
				КонецЕсли;
				
			КонецЕсли;
		
		Исключение
			
			Результат = Ложь;
			
			Если ВыводитьСообщения Тогда
				ОбщегоНазначенияКлиентСервер.СообщитьПользователю(
				?(ЗначениеЗаполнено(СообщениеОбОшибке) ,СообщениеОбОшибке, НСтр("ru='В формуле обнаружены ошибки. Проверьте формулу. Формулы должны составляться по правилам написания выражений на встроенном языке платформы BAF.';uk='У формулі виявлені помилки. Перевірте формулу. Формули повинні складатися за правилами написання виразів на вбудованій мові платформи BAF.'")),
				,
				Поле,
				ПутьКДанным,);
			КонецЕсли;
			
		КонецПопытки;
		
	КонецЕсли;
	
	Возврат Результат;
	
КонецФункции 


#КонецОбласти
