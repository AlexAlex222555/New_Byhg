
&НаСервере
Функция УстановитьКодНаСервере()
	
	ОперацияВыполненаУспешно = Истина;
	
	Запрос = Новый Запрос;
	Запрос.Текст = 
	"ВЫБРАТЬ
	|	КлассификаторУКТВЭД.Ссылка
	|ИЗ
	|	Справочник.КлассификаторУКТВЭД КАК КлассификаторУКТВЭД
	|ГДЕ
	|	КлассификаторУКТВЭД.Вид = ЗНАЧЕНИЕ(Перечисление.ВидыКодовДляНалоговойНакладной.ПустаяСсылка)
	|	И НЕ КлассификаторУКТВЭД.ПометкаУдаления";
	
	РезультатЗапроса = Запрос.Выполнить();  
	
	Выборка = РезультатЗапроса.Выбрать();
		
	Попытка
		Пока Выборка.Следующий() Цикл
			КодУКТВЭД = Выборка.Ссылка.ПолучитьОбъект();
			КодУКТВЭД.Вид = ВидКода;
			КодУКТВЭД.Записать();
		КонецЦикла;
	Исключение
	    Сообщить(НСтр("ru='Не удалось записать элемент справочника по причине: ';uk='Не вдалося записати елемент довідника з причини: '") +
			ОписаниеОшибки());
		ОперацияВыполненаУспешно = Ложь;
	КонецПопытки;
	
	Возврат ОперацияВыполненаУспешно;
	
КонецФункции

&НаКлиенте
Процедура УстановитьКод(Команда)
	
	Если Не ЗначениеЗаполнено(ВидКода) Тогда
		Сообщить(НСтр("ru='Укажите вид кода!';uk='Вкажіть вид коду!'"));
		Возврат;
	КонецЕсли;
	
	ОперацияУспешна = УстановитьКодНаСервере();
	
	Если ОперацияУспешна Тогда
		ТекстСообщения = НСтр("ru='Операция успешно завершена!';uk='Операція успішно завершена!'");
		ОписаниеОповещения = Новый ОписаниеОповещения("УстановитьКодЗавершение", ЭтотОбъект);
		ПоказатьПредупреждение(ОписаниеОповещения, ТекстСообщения);	
	КонецЕсли; 
	
КонецПроцедуры

&НаКлиенте
Процедура УстановитьКодЗавершение(ДополнительныеПараметры) Экспорт
	
	ЭтотОбъект.Закрыть();
	
КонецПроцедуры
