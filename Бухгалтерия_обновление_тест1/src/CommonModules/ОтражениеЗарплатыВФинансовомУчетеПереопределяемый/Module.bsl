////////////////////////////////////////////////////////////////////////////////
// Отражение зарплаты в финансовом учете.
// 
////////////////////////////////////////////////////////////////////////////////

#Область ПрограммныйИнтерфейс
	
// Процедура предназначена для формирования движений по финансовому учету.
//
// Параметры:
//	Движения - коллекция движений документа, 
//	Отказ - булево, признак отказа от проведения документа.
//	ПериодРегистрации - дата, месяц, зарплата которого отражается в учете.
//	ДанныеДляОтражения - структура. Таблицы значений с данными, которые 
//						могут использоваться для формирования движений по финансовому учету.
//						При вызове процедуры ДанныеДляОтражения может содержать 
//						одно или несколько полей с приведенными ниже именами, т.е.
//						Необходимо проверять наличие того или иного элемента структуры.
//	Организация
//                             
Процедура ЗарегистрироватьЗарплатуВФинансовомУчете(Движения, Отказ, ПериодРегистрации, ДанныеДляОтражения, Организация) Экспорт
	
КонецПроцедуры

// Функция определяет возможность выполнения операции отражения зарплаты в финансовом учете, 
// осуществляемой документом «Отражение зарплаты в финансовом учете», 
// одним экземпляром документа по всем организациям.
//
// Возвращаемое значение - булево, 
//	Истина, если операция одним документом по всем организациям доступна, 
//	Ложь - в противном случае
//
Функция ОтражениеЗарплатыВФинансовомУчетеОднимДокументомПоВсемОрганизациямДоступно() Экспорт

	Возврат Ложь;
	
КонецФункции

#КонецОбласти
