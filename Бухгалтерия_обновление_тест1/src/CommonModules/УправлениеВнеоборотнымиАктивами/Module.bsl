
#Область ПрограммныйИнтерфейс

#Область ОбщиеПроцедурыИФункции

// Функция определяет фактический срок использования актива (в месяцах)
// исходя из даты принятия актива к учету и даты выбытия.
//
// Параметры:
//   ДатаПринятияКУчету - Дата - Дата принятия актива к учету.
//   ДатаВыбытия - Дата - Дата выбытия актива.
//
// Возвращаемое значение:
//   Число - Число месяцев.
//
Функция ОпределитьФактическийСрокИспользования(ДатаПринятияКУчету, ДатаВыбытия) Экспорт
	
	КоличествоЛет     = Год(ДатаВыбытия) - Год(ДатаПринятияКУчету);
	КоличествоМесяцев = Месяц(ДатаВыбытия) - Месяц(ДатаПринятияКУчету);
	
	Возврат КоличествоЛет * 12 + КоличествоМесяцев;
	
КонецФункции // ОпределитьФактическийСрокИспользования()

#КонецОбласти

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

#КонецОбласти
