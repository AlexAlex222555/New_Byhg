#Область ПрограммныйИнтерфейс

// Определить объекты метаданных, в модулях менеджеров которых ограничивается возможность 
// редактирования реквизитов при групповом изменении.
// см. ГрупповоеИзменениеОбъектовПереопределяемый.ПриОпределенииОбъектовСРедактируемымиРеквизитами()
//
Процедура ПриОпределенииОбъектовСРедактируемымиРеквизитами(Объекты) Экспорт
	
	//++ Локализация
	//++ НЕ УТ
	//++ НЕ БЗК
	Объекты.Вставить(Метаданные.Справочники.ИнвентаризацияРасчетовПрисоединенныеФайлы.ПолноеИмя(), "РеквизитыРедактируемыеВГрупповойОбработке");
	Объекты.Вставить(Метаданные.Справочники.ПередачаМатериаловВПроизводствоПрисоединенныеФайлы.ПолноеИмя(), "РеквизитыРедактируемыеВГрупповойОбработке");
	Объекты.Вставить(Метаданные.Справочники.РегистрУчетаПрисоединенныеФайлы.ПолноеИмя(), "РеквизитыРедактируемыеВГрупповойОбработке");
    //-- НЕ БЗК
	Объекты.Вставить(Метаданные.Справочники.ВедомостьНаВыплатуЗарплатыВБанкПрисоединенныеФайлы.ПолноеИмя(), "РеквизитыРедактируемыеВГрупповойОбработке");
	Объекты.Вставить(Метаданные.Справочники.ЗаявкаНаЗакрытиеЛицевыхСчетовСотрудниковПрисоединенныеФайлы.ПолноеИмя(), "РеквизитыРедактируемыеВГрупповойОбработке");
	Объекты.Вставить(Метаданные.Справочники.ЗаявкаНаОткрытиеЛицевыхСчетовСотрудниковПрисоединенныеФайлы.ПолноеИмя(), "РеквизитыРедактируемыеВГрупповойОбработке");
	Объекты.Вставить(Метаданные.Справочники.ПодтверждениеЗачисленияЗарплатыПрисоединенныеФайлы.ПолноеИмя(), "РеквизитыРедактируемыеВГрупповойОбработке");
	Объекты.Вставить(Метаданные.Справочники.ПодтверждениеОткрытияЛицевыхСчетовСотрудниковПрисоединенныеФайлы.ПолноеИмя(), "РеквизитыРедактируемыеВГрупповойОбработке");

	//-- НЕ УТ
	//-- Локализация
	
КонецПроцедуры


#КонецОбласти