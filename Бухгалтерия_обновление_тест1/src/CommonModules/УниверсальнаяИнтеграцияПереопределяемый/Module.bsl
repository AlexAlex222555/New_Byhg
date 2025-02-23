
#Область ПрограммныйИнтерфейс

// Позволяет дополнить, изменить данные перед отправкой в менеджер сервиса.
//
// Параметры:
//  ИдентификаторПравила - Строка - идентификатор правила. 
//  Данные - Структура - данные к отправке. 
//
//@skip-warning Пустой метод
Процедура ОбработатьДанныеПередОтправкой(ИдентификаторПравила, Данные) Экспорт
	
КонецПроцедуры

// Процедура обработки оповещения об изменении объекта. 
// Вызывается после получения данных объекта, перед сохранением объекта в безопасное хранилище.
//
// Параметры:
//  ИдентификаторПравила - Строка - идентификатор правила.
//  КлючОбъекта - Строка - ключ объекта. 
//  Данные - Структура - данные объекта.
//
//@skip-warning Пустой метод
Процедура ОбработатьОповещениеОбИзменении(ИдентификаторПравила, КлючОбъекта, Данные) Экспорт
    
КонецПроцедуры
 
#КонецОбласти 
