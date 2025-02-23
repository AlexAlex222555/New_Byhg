
#Область СлужебныйПрограммныйИнтерфейс

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

Функция ПравилаУчетаНачисленийСотрудников() Экспорт

	ПравилаУчетаНачислений = Новый Соответствие;
	
	Запрос = Новый Запрос;
	Запрос.Текст = 
	"ВЫБРАТЬ
	|	Начисления.Ссылка,
	|	ВЫБОР
	|		КОГДА Начисления.ЯвляетсяДоходомВНатуральнойФорме
	|			ТОГДА ЗНАЧЕНИЕ(Перечисление.ГруппыНачисленияУдержанияВыплаты.Справочно)
	|		ИНАЧЕ ЗНАЧЕНИЕ(Перечисление.ГруппыНачисленияУдержанияВыплаты.Начислено)
	|	КОНЕЦ КАК ГруппаНачисленияУдержанияВыплаты,
	|	НЕ Начисления.ЯвляетсяДоходомВНатуральнойФорме КАК УчитыватьВоВзаиморасчетах
	|ИЗ
	|	ПланВидовРасчета.Начисления КАК Начисления";
	
	Выборка = Запрос.Выполнить().Выбрать();
	
	Пока Выборка.Следующий() Цикл
		
		ПравилаУчетаНачисления = Новый Структура;
		ПравилаУчетаНачисления.Вставить("ГруппаНачисленияУдержанияВыплаты", Выборка.ГруппаНачисленияУдержанияВыплаты);
		ПравилаУчетаНачисления.Вставить("УчитыватьВоВзаиморасчетах", Выборка.УчитыватьВоВзаиморасчетах);
		
		ПравилаУчетаНачислений.Вставить(Выборка.Ссылка, ПравилаУчетаНачисления);
		
	КонецЦикла;
	
	Возврат ПравилаУчетаНачислений;

КонецФункции 

Функция ПрименениеОбособленныхТерриторий() Экспорт
	Возврат Ложь;
КонецФункции

#Область ПроцедурыИФункцииРаботыСОтчетами

// Возвращает начисления в том порядке, в котором они должны быть выведены в отчете.
//
Функция ПорядокДополнительныхНачислений(Начисления, ДанныеОтчета, СоответствиеПользовательскихПолей, НачальныйНомерКолонки, ВсегоНачислений) Экспорт
	
	НомерКолонки = НачальныйНомерКолонки;
	Для каждого СтрокаНачисления Из Начисления Цикл
		СтрокаНачисления.НомерКолонки = НомерКолонки;
		НомерКолонки = НомерКолонки + 1;
	КонецЦикла;
	
	Возврат Начисления;
	
КонецФункции

// Возвращает удержания в том порядке, в котором они должны быть выведены в отчете.
//
Функция ПорядокДополнительныхУдержаний(Удержания, ДанныеОтчета, СоответствиеПользовательскихПолей, НачальныйНомерКолонки, ВсегоУдержаний) Экспорт
	
	НомерКолонки = НачальныйНомерКолонки;
	Для каждого СтрокаУдержания Из Удержания Цикл
		СтрокаУдержания.НомерКолонки = НомерКолонки;
		НомерКолонки = НомерКолонки + 1;
	КонецЦикла;
	
	Возврат Удержания;
	
КонецФункции
#КонецОбласти

#КонецОбласти
