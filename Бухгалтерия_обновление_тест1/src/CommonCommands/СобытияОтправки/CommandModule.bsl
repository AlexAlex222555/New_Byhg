///////////////////////////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2020
// Все права защищены. Эта программа и сопроводительные материалы предоставляются 
// в соответствии с условиями лицензии Attribution 4.0 International (CC BY 4.0)
// Текст лицензии доступен по ссылке:
// https://creativecommons.org/licenses/by/4.0/legalcode
///////////////////////////////////////////////////////////////////////////////////////////////////////

#Область ОбработчикиСобытий

&НаКлиенте
Процедура ОбработкаКоманды(УзелИнформационнойБазы, ПараметрыВыполненияКоманды)
	
	ОбменДаннымиКлиент.ПерейтиВЖурналРегистрацииСобытийДанных(УзелИнформационнойБазы, ПараметрыВыполненияКоманды, "ВыгрузкаДанных");
	
КонецПроцедуры

#КонецОбласти
