////////////////////////////////////////////////////////////////////////////////
// Подсистема "Обмен с банками по зарплатным проектам".
//
////////////////////////////////////////////////////////////////////////////////

#Область СлужебныеПроцедурыИФункции

Процедура ЗарегистрироватьИзмененияЛицевыхСчетов(ЛицевыеСчетаФизическихЛиц, Организация, ДатаНачала) Экспорт
	
	ОбменСБанкамиПоЗарплатнымПроектамРасширенный.ЗарегистрироватьИзмененияЛицевыхСчетов(ЛицевыеСчетаФизическихЛиц, Организация, ДатаНачала);
	
КонецПроцедуры

Функция ДеньВыплатыЗарплатыВОрганизации(Организация) Экспорт
	Возврат ОбменСБанкамиПоЗарплатнымПроектамРасширенный.ДеньВыплатыЗарплатыВОрганизации(Организация);
КонецФункции

#Область ПервоначальноеЗаполнениеИОбновлениеИнформационнойБазы

Процедура СформироватьДвиженияПоДокументамОплаты(ДокументОплаты) Экспорт
	ОбменСБанкамиПоЗарплатнымПроектамРасширенный.СформироватьДвиженияПоДокументамОплаты(ДокументОплаты);
КонецПроцедуры

#КонецОбласти

#КонецОбласти
