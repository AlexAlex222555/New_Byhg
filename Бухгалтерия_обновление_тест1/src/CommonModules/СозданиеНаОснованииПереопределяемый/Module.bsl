///////////////////////////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2020
// Все права защищены. Эта программа и сопроводительные материалы предоставляются 
// в соответствии с условиями лицензии Attribution 4.0 International (CC BY 4.0)
// Текст лицензии доступен по ссылке:
// https://creativecommons.org/licenses/by/4.0/legalcode
///////////////////////////////////////////////////////////////////////////////////////////////////////

#Область ПрограммныйИнтерфейс

// Переопределяет настройки команд ввода на основании.
//
// Параметры:
//  Настройки - Структура - настройки подсистемы:
//   * ИспользоватьКомандыВводаНаОсновании - Булево - разрешает использование программных команд ввода на основании
//                                                    вместо штатных. Значение по умолчанию: Истина.
//
Процедура ПриОпределенииНастроек(Настройки) Экспорт
	
КонецПроцедуры

// Определяет список объектов конфигурации, в модулях менеджеров которых предусмотрена процедура 
// ДобавитьКомандыСозданияНаОсновании, формирующая команды создания на основании объектов.
// Синтаксис процедуры ДобавитьКомандыСозданияНаОсновании см. в документации.
//
// Параметры:
//   Объекты - Массив - объекты метаданных (ОбъектМетаданных) с командами создания на основании.
//
// Пример:
//  Объекты.Добавить(Метаданные.Справочники.Организации);
//
Процедура ПриОпределенииОбъектовСКомандамиСозданияНаОсновании(Объекты) Экспорт
	
	//++ НЕ ГОСИС
	
	//++ НЕ БЗК
	//++ НЕ УТ
	ВнеоборотныеАктивы.ПриОпределенииОбъектовСКомандамиСозданияНаОсновании(Объекты);
	//-- НЕ УТ
	
	//++ НЕ УТ
	// СлужебныеПодсистемы.ОбъектыКАУП
	Объекты.Добавить(Метаданные.Документы.АктВыполненныхВнутреннихРабот);
	Объекты.Добавить(Метаданные.Документы.ВводВыводДенежныхСредствПоНаправлению);
	Объекты.Добавить(Метаданные.Документы.ВозвратСырьяОтПереработчика);
	Объекты.Добавить(Метаданные.Документы.ВыработкаСотрудников);
	Объекты.Добавить(Метаданные.Документы.ДвижениеПродукцииИМатериалов);
	Объекты.Добавить(Метаданные.Документы.ЗаказМатериаловВПроизводство);
	Объекты.Добавить(Метаданные.Документы.ЗаказПереработчику);
	Объекты.Добавить(Метаданные.Документы.ИнвентаризацияНМА);
	Объекты.Добавить(Метаданные.Документы.МодернизацияНМА);
	Объекты.Добавить(Метаданные.Документы.ОтчетПереработчика);
	Объекты.Добавить(Метаданные.Документы.ПередачаСырьяПереработчику);
	Объекты.Добавить(Метаданные.Документы.ПеремещениеНМА);
	Объекты.Добавить(Метаданные.Документы.ПланПроизводства);
	Объекты.Добавить(Метаданные.Документы.ПоступлениеОтПереработчика);
	Объекты.Добавить(Метаданные.Документы.ПроизводствоБезЗаказа);
	Объекты.Добавить(Метаданные.Документы.РаспределениеВозвратныхОтходов);
	Объекты.Добавить(Метаданные.Документы.РаспределениеПрочихЗатрат);
	Объекты.Добавить(Метаданные.Документы.УстановкаЗначенийНефинансовыхПоказателей);
	Объекты.Добавить(Метаданные.Справочники.РесурсныеСпецификации);
	Объекты.Добавить(Метаданные.Документы.НаработкаОбъектовЭксплуатации);
	// Конец СлужебныеПодсистемы.ОбъектыКАУП
	//-- НЕ УТ
	
	
	// СлужебныеПодсистемы.ОбъектыУТКАУП
	Объекты.Добавить(Метаданные.Документы.ВыкупПринятыхНаХранениеТоваров);
	Объекты.Добавить(Метаданные.Документы.ВыкупТоваровХранителем);
	Объекты.Добавить(Метаданные.Документы.ОтгрузкаТоваровСХранения);
	Объекты.Добавить(Метаданные.Документы.ПередачаТоваровХранителю);
	Объекты.Добавить(Метаданные.Документы.ПоступлениеТоваровОтХранителя);
	Объекты.Добавить(Метаданные.Документы.ПриемкаТоваровНаХранение);
	Объекты.Добавить(Метаданные.Документы.СписаниеТоваровУХранителя);
	Объекты.Добавить(Метаданные.Документы.СписаниеПринятыхНаХранениеТоваров);
	Объекты.Добавить(Метаданные.Документы.АвансовыйОтчет);
	Объекты.Добавить(Метаданные.Документы.АктВыполненныхРабот);
	Объекты.Добавить(Метаданные.Документы.АктОРасхожденияхПослеОтгрузки);
	Объекты.Добавить(Метаданные.Документы.АктОРасхожденияхПослеПеремещения);
	Объекты.Добавить(Метаданные.Документы.АктОРасхожденияхПослеПриемки);
	Объекты.Добавить(Метаданные.Документы.АннулированиеПодарочныхСертификатов);
	Объекты.Добавить(Метаданные.Документы.ВводОстатков);
	Объекты.Добавить(Метаданные.Документы.ВводОстатковВзаиморасчетов);
	Объекты.Добавить(Метаданные.Документы.ВводОстатковДенежныхСредств);
	Объекты.Добавить(Метаданные.Документы.ВводОстатковОПродажахЗаПрошлыеПериоды);
	Объекты.Добавить(Метаданные.Документы.ВводОстатковПоФинансовымИнструментам);
	Объекты.Добавить(Метаданные.Документы.ВводОстатковПрочиеРасходы);
	Объекты.Добавить(Метаданные.Документы.ВводОстатковПрочихАктивовПассивов);
	Объекты.Добавить(Метаданные.Документы.ВводОстатковРасчетовПоЭквайрингу);
	Объекты.Добавить(Метаданные.Документы.ВводОстатковСПодотчетниками);
	Объекты.Добавить(Метаданные.Документы.ВводОстатковТоваров);
	Объекты.Добавить(Метаданные.Документы.ВзаимозачетЗадолженности);
	Объекты.Добавить(Метаданные.Документы.ВнутреннееПотреблениеТоваров);
	Объекты.Добавить(Метаданные.Документы.ВозвратТоваровМеждуОрганизациями);
	Объекты.Добавить(Метаданные.Документы.ВозвратТоваровОтКлиента);
	Объекты.Добавить(Метаданные.Документы.ВозвратТоваровПоставщику);
	Объекты.Добавить(Метаданные.Документы.ВнесениеДенежныхСредствВКассуККМ);
	Объекты.Добавить(Метаданные.Документы.ВозвратПодарочныхСертификатов);
	Объекты.Добавить(Метаданные.Документы.ВыемкаДенежныхСредствИзКассыККМ);
	Объекты.Добавить(Метаданные.Документы.ВыкупВозвратнойТарыКлиентом);
	Объекты.Добавить(Метаданные.Документы.ВыкупВозвратнойТарыУПоставщика);
	Объекты.Добавить(Метаданные.Документы.ДвижениеПрочихАктивовПассивов);
	Объекты.Добавить(Метаданные.Документы.ДоверенностьВыданная);
	Объекты.Добавить(Метаданные.Документы.ЗаданиеНаПеревозку);
	Объекты.Добавить(Метаданные.Документы.ЗаданиеТорговомуПредставителю);
	Объекты.Добавить(Метаданные.Документы.ЗаказКлиента);
	Объекты.Добавить(Метаданные.Документы.ЗаказНаВнутреннееПотребление);
	Объекты.Добавить(Метаданные.Документы.ЗаказНаПеремещение);
	Объекты.Добавить(Метаданные.Документы.ЗаказНаСборку);
	Объекты.Добавить(Метаданные.Документы.ЗаказПоставщику);
	Объекты.Добавить(Метаданные.Документы.ЗаявкаНаВозвратТоваровОтКлиента);
	Объекты.Добавить(Метаданные.Документы.ЗаявкаНаРасходованиеДенежныхСредств);
	Объекты.Добавить(Метаданные.Документы.ИзменениеАссортимента);
	Объекты.Добавить(Метаданные.Документы.ИнвентаризационнаяОпись);
	Объекты.Добавить(Метаданные.Документы.ИнвентаризацияНаличныхДенежныхСредств);
	Объекты.Добавить(Метаданные.Документы.КоммерческоеПредложениеКлиенту);
	Объекты.Добавить(Метаданные.Документы.КорректировкаИзлишковНедостачПоТоварнымМестам);
	Объекты.Добавить(Метаданные.Документы.КорректировкаНазначенияТоваров);
	Объекты.Добавить(Метаданные.Документы.КорректировкаПоОрдеруНаТовары);
	Объекты.Добавить(Метаданные.Документы.КорректировкаПриобретения);
	Объекты.Добавить(Метаданные.Документы.КорректировкаРеализации);
	Объекты.Добавить(Метаданные.Документы.КорректировкаРегистров);
	Объекты.Добавить(Метаданные.Документы.НачислениеИСписаниеБонусныхБаллов);
	Объекты.Добавить(Метаданные.Документы.НачисленияКредитовИДепозитов);
	Объекты.Добавить(Метаданные.Документы.НормативРаспределенияПлановПродажПоКатегориям);
	Объекты.Добавить(Метаданные.Документы.ОжидаемоеПоступлениеДенежныхСредств);
	Объекты.Добавить(Метаданные.Документы.ОперацияПоПлатежнойКарте);
	Объекты.Добавить(Метаданные.Документы.ОприходованиеИзлишковТоваров);
	Объекты.Добавить(Метаданные.Документы.ОрдерНаОтражениеИзлишковТоваров);
	Объекты.Добавить(Метаданные.Документы.ОрдерНаОтражениеНедостачТоваров);
	Объекты.Добавить(Метаданные.Документы.ОрдерНаОтражениеПересортицыТоваров);
	Объекты.Добавить(Метаданные.Документы.ОрдерНаОтражениеПорчиТоваров);
	Объекты.Добавить(Метаданные.Документы.ОрдерНаПеремещениеТоваров);
	Объекты.Добавить(Метаданные.Документы.ОтборРазмещениеТоваров);
	Объекты.Добавить(Метаданные.Документы.ОтражениеРасхожденийПриИнкассацииДенежныхСредств);
	Объекты.Добавить(Метаданные.Документы.ОтчетБанкаПоОперациямЭквайринга);
	Объекты.Добавить(Метаданные.Документы.ОтчетКомиссионера);
	Объекты.Добавить(Метаданные.Документы.ОтчетКомиссионераОСписании);
	Объекты.Добавить(Метаданные.Документы.ОтчетКомитенту);
	Объекты.Добавить(Метаданные.Документы.ОтчетКомитентуОСписании);
	Объекты.Добавить(Метаданные.Документы.ОтчетОРозничныхПродажах);
	Объекты.Добавить(Метаданные.Документы.ОтчетПоКомиссииМеждуОрганизациями);
	Объекты.Добавить(Метаданные.Документы.ОтчетПоКомиссииМеждуОрганизациямиОСписании);
	Объекты.Добавить(Метаданные.Документы.ПередачаТоваровМеждуОрганизациями);
	Объекты.Добавить(Метаданные.Документы.ПеремещениеТоваров);
	Объекты.Добавить(Метаданные.Документы.РасчетКурсовыхРазниц);
	Объекты.Добавить(Метаданные.Документы.ПересортицаТоваров);
	Объекты.Добавить(Метаданные.Документы.ПересчетТоваров);
	Объекты.Добавить(Метаданные.Документы.ПланЗакупок);
	Объекты.Добавить(Метаданные.Документы.ПланОстатков);
	Объекты.Добавить(Метаданные.Документы.ПланПродаж);
	Объекты.Добавить(Метаданные.Документы.ПланПродажПоКатегориям);
	Объекты.Добавить(Метаданные.Документы.ПланСборкиРазборки);
	Объекты.Добавить(Метаданные.Документы.ПланВнутреннихПотреблений);
	Объекты.Добавить(Метаданные.Документы.ПорчаТоваров);
	Объекты.Добавить(Метаданные.Документы.ПоступлениеБезналичныхДенежныхСредств);
	Объекты.Добавить(Метаданные.Документы.ПоступлениеТоваровНаСклад);
	Объекты.Добавить(Метаданные.Документы.ПриобретениеТоваровУслуг);
	Объекты.Добавить(Метаданные.Документы.ПриобретениеУслугПрочихАктивов);
	Объекты.Добавить(Метаданные.Документы.ПриходныйКассовыйОрдер);
	Объекты.Добавить(Метаданные.Документы.ПриходныйОрдерНаТовары);
	Объекты.Добавить(Метаданные.Документы.ПрочееОприходованиеТоваров);
	Объекты.Добавить(Метаданные.Документы.ПрочиеДоходыРасходы);
	Объекты.Добавить(Метаданные.Документы.РаспоряжениеНаПеремещениеДенежныхСредств);
	Объекты.Добавить(Метаданные.Документы.РаспределениеДоходовПоНаправлениямДеятельности);
	Объекты.Добавить(Метаданные.Документы.РаспределениеРасходовБудущихПериодов);
	Объекты.Добавить(Метаданные.Документы.РассылкаКлиентам);
	Объекты.Добавить(Метаданные.Документы.РасходныйКассовыйОрдер);
	Объекты.Добавить(Метаданные.Документы.РасходныйОрдерНаТовары);
	Объекты.Добавить(Метаданные.Документы.РасчетСебестоимостиТоваров);
	Объекты.Добавить(Метаданные.Документы.РеализацияПодарочныхСертификатов);
	Объекты.Добавить(Метаданные.Документы.РеализацияТоваровУслуг);
	Объекты.Добавить(Метаданные.Документы.РеализацияУслугПрочихАктивов);
	Объекты.Добавить(Метаданные.Документы.РегистрацияЦенНоменклатурыПоставщика);
	Объекты.Добавить(Метаданные.Документы.СборкаТоваров);
	Объекты.Добавить(Метаданные.Документы.СверкаВзаиморасчетов);
	Объекты.Добавить(Метаданные.Документы.РегистраторГрафикаДвиженияТоваров);
	Объекты.Добавить(Метаданные.Документы.СписаниеБезналичныхДенежныхСредств);
	Объекты.Добавить(Метаданные.Документы.СписаниеЗадолженности);
	Объекты.Добавить(Метаданные.Документы.СписаниеНедостачТоваров);
	Объекты.Добавить(Метаданные.Документы.СчетНаОплатуКлиенту);
	Объекты.Добавить(Метаданные.Документы.ТаможеннаяДекларацияИмпорт);
	Объекты.Добавить(Метаданные.Документы.УпаковочныйЛист);
	Объекты.Добавить(Метаданные.Документы.УстановкаБлокировокЯчеек);
	Объекты.Добавить(Метаданные.Документы.УстановкаКвотАссортимента);
	Объекты.Добавить(Метаданные.Документы.УстановкаЦенНоменклатуры);
	Объекты.Добавить(Метаданные.Обработки.РабочееМестоМенеджераПоДоставке);
	Объекты.Добавить(Метаданные.Обработки.УправлениеПоступлением);
	Объекты.Добавить(Метаданные.Справочники.Контрагенты);
	Объекты.Добавить(Метаданные.Справочники.Номенклатура);
	Объекты.Добавить(Метаданные.Справочники.Партнеры);
	Объекты.Добавить(Метаданные.Справочники.СоглашенияСКлиентами);
	Объекты.Добавить(Метаданные.Справочники.СоглашенияСПоставщиками);
	Объекты.Добавить(Метаданные.Справочники.Склады);
	Объекты.Добавить(Метаданные.Документы.ОтчетКомитентуОЗакупках);	
		
	УчетНДСУП.ПриОпределенииОбъектовСКомандамиСозданияНаОсновании(Объекты);
	
	
	// Конец СлужебныеПодсистемы.ОбъектыУТКАУП
	//-- НЕ БЗК
	
	СозданиеНаОснованииЛокализация.ПриОпределенииОбъектовСКомандамиСозданияНаОсновании(Объекты);
    
    //-- НЕ ГОСИС
    
КонецПроцедуры

// Вызывается для формирования списка команд создания на основании КомандыСозданияНаОсновании, однократно для при первой
// необходимости, а затем результат кэшируется с помощью модуля с повторным использованием возвращаемых значений.
// Здесь можно определить команды создания на основании, общие для большинства объектов конфигурации.
//
// Параметры:
//   КомандыСозданияНаОсновании - ТаблицаЗначений - сформированные команды для вывода в подменю:
//     
//     Общие настройки:
//       * Идентификатор - Строка - Идентификатор команды.
//     
//     Настройки внешнего вида:
//       * Представление - Строка   - Представление команды в форме.
//       * Важность      - Строка   - Группа в подменю, в которой следует вывести эту команду.
//                                    Допустимо использовать: "Важное", "Обычное" и "СмТакже".
//       * Порядок       - Число    - Порядок размещения команды в подменю. Используется для настройки под конкретное
//                                    рабочее место.
//       * Картинка      - Картинка - Картинка команды.
//     
//     Настройки видимости и доступности:
//       * ТипПараметра - ОписаниеТипов - Типы объектов, для которых предназначена эта команда.
//       * ВидимостьВФормах    - Строка - Имена форм через запятую, в которых должна отображаться команда.
//                                        Используется когда состав команд отличается для различных форм.
//       * ФункциональныеОпции - Строка - Имена функциональных опций через запятую, определяющих видимость команды.
//       * УсловияВидимости    - Массив - Определяет видимость команды в зависимости от контекста.
//                                        Для регистрации условий следует использовать процедуру
//                                        ПодключаемыеКоманды.ДобавитьУсловиеВидимостиКоманды().
//                                        Условия объединяются по "И".
//       * ИзменяетВыбранныеОбъекты - Булево - Определяет доступность команды в ситуации,
//                                        когда у пользователя нет прав на изменение объекта.
//                                        Если Истина, то в описанной выше ситуации кнопка будет недоступна.
//                                        Необязательный. Значение по умолчанию: Ложь.
//     
//     Настройки процесса выполнения:
//       * МножественныйВыбор - Булево, Неопределено - Если Истина, то команда поддерживает множественный выбор.
//             В этом случае в параметре выполнения будет передан список ссылок.
//             Необязательный. Значение по умолчанию: Ложь.
//       * РежимЗаписи - Строка - Действия, связанные с записью объекта, которые выполняются перед обработчиком команды.
//             "НеЗаписывать"          - Объект не записывается, а в параметрах обработчика вместо ссылок передается
//                                       вся форма. В этом режиме рекомендуется работать напрямую с формой,
//                                       которая передается в структуре 2 параметра обработчика команды.
//             "ЗаписыватьТолькоНовые" - Записывать новые объекты.
//             "Записывать"            - Записывать новые и модифицированные объекты.
//             "Проводить"             - Проводить документы.
//             Перед записью и проведением у пользователя запрашивается подтверждение.
//             Необязательный. Значение по умолчанию: "Записывать".
//       * ТребуетсяРаботаСФайлами - Булево - Если Истина, то в веб-клиенте предлагается
//             установить расширение работы с файлами.
//             Необязательный. Значение по умолчанию: Ложь.
//     
//     Настройки обработчика:
//       * Менеджер - Строка - Объект, отвечающий за выполнение команды.
//       * ИмяФормы - Строка - Имя формы, которую требуется получить для выполнения команды.
//             Если Обработчик не указан, то у формы вызывается метод "Открыть".
//       * ПараметрыФормы - Неопределено, ФиксированнаяСтруктура - Необязательный. Параметры формы, указанной в ИмяФормы.
//       * Обработчик - Строка - Описание процедуры, обрабатывающей основное действие команды.
//             Формат "<ИмяОбщегоМодуля>.<ИмяПроцедуры>" используется когда процедура размещена в общем модуле.
//             Формат "<ИмяПроцедуры>" используется в следующих случаях:
//               - Если ИмяФормы заполнено то в модуле указанной формы ожидается клиентская процедура.
//               - Если ИмяФормы не заполнено то в модуле менеджера этого объекта ожидается серверная процедура.
//       * ДополнительныеПараметры - ФиксированнаяСтруктура - Необязательный. Параметры обработчика, указанного в Обработчик.
//   
//   Параметры - Структура - Сведения о контексте исполнения.
//       * ИмяФормы - Строка - Полное имя формы.
//
//   СтандартнаяОбработка - Булево - Если установить в Ложь, то событие "ДобавитьКомандыСозданияНаОсновании" менеджера
//                                   объекта не будет вызвано.
//
Процедура ПередДобавлениемКомандСозданияНаОсновании(КомандыСозданияНаОсновании, Параметры, СтандартнаяОбработка) Экспорт
	
	//++ НЕ ГОСИС
	
	СозданиеНаОснованииЛокализация.ПередДобавлениемКомандСозданияНаОсновании(КомандыСозданияНаОсновании, Параметры, СтандартнаяОбработка);
	
	ИмяФормы = Параметры.ИмяФормы;
	МассивПолей = СтроковыеФункцииКлиентСервер.РазложитьСтрокуВМассивПодстрок(ИмяФормы,".");
	Если МассивПолей.Количество() < 4 Тогда
		Возврат;
	КонецЕсли;
	
	Если (ПолучитьФункциональнуюОпцию("ИспользоватьДополнительныеОбработкиСозданияСвязанныхОбъектов", 
				Новый Структура("ДополнительныеОтчетыИОбработкиОбъектНазначения,ДополнительныеОтчетыИОбработкиТипФормы", 
				Справочники.ИдентификаторыОбъектовМетаданных.НайтиПоРеквизиту("ПолноеИмя",МассивПолей[0]+"."+МассивПолей[1]), МассивПолей[3]))
			ИЛИ ПолучитьФункциональнуюОпцию("ИспользоватьДополнительныеОбработкиСозданияСвязанныхОбъектов", 
				Новый Структура("ДополнительныеОтчетыИОбработкиОбъектНазначения,ДополнительныеОтчетыИОбработкиТипФормы", 
				Справочники.ИдентификаторыОбъектовМетаданных.НайтиПоРеквизиту("ПолноеИмя",МассивПолей[0]+"."+МассивПолей[1]), 
				?(СтрНайти(МассивПолей[3], "ФормаСписка") <> 0,ДополнительныеОтчетыИОбработкиКлиентСервер.ТипФормыСписка(),
				ДополнительныеОтчетыИОбработкиКлиентСервер.ТипФормыОбъекта())))) 
			И СтрНайти(ИмяФормы,"ЖурналДокументов") = 0 Тогда
		
		КомандаСозданияНаОсновании = КомандыСозданияНаОсновании.Добавить();
		КомандаСозданияНаОсновании.Обработчик = "СозданиеНаОснованииУТКлиент.СозданиеСвязанныхОбъектов";
		КомандаСозданияНаОсновании.Идентификатор = "СозданиеСвязанныхОбъектов";
		КомандаСозданияНаОсновании.Представление = НСтр("ru='Создание связанных объектов...';uk='Створення пов''язаних об''єктів...'");
		КомандаСозданияНаОсновании.РежимЗаписи = "Проводить";
		КомандаСозданияНаОсновании.МножественныйВыбор = Истина;
		КомандаСозданияНаОсновании.Порядок = 100;
	КонецЕсли;
	
	//++ НЕ БЗК
	// ИнтеграцияС1СДокументооборотом
	Если ПравоДоступа("Просмотр", Метаданные.Обработки.ИнтеграцияС1СДокументооборот) Тогда
		КомандаСозданияНаОсновании = КомандыСозданияНаОсновании.Добавить();
		КомандаСозданияНаОсновании.Обработчик = "СозданиеНаОснованииУТКлиент.ИнтеграцияС1СДокументооборотСоздатьПисьмо";
		КомандаСозданияНаОсновании.Идентификатор = "ИнтеграцияС1СДокументооборотСоздатьПисьмо";
		КомандаСозданияНаОсновании.Представление = НСтр("ru='Документооборот: Письмо';uk='Документообіг: Лист'");
		КомандаСозданияНаОсновании.РежимЗаписи = ?(Параметры.ВидВРег = "ДОКУМЕНТ", "Проводить", "Записывать");
		КомандаСозданияНаОсновании.ФункциональныеОпции = "ИспользоватьЭлектроннуюПочту1СДокументооборота";
		КомандаСозданияНаОсновании.Порядок = 98;
		
		КомандаСозданияНаОсновании = КомандыСозданияНаОсновании.Добавить();
		КомандаСозданияНаОсновании.Обработчик = "СозданиеНаОснованииУТКлиент.ИнтеграцияС1СДокументооборотСоздатьБизнесПроцесс";
		КомандаСозданияНаОсновании.Идентификатор = "ИнтеграцияС1СДокументооборотСоздатьБизнесПроцесс";
		КомандаСозданияНаОсновании.Представление = НСтр("ru='Документооборот: Процесс...';uk='Документообіг: Процес...'");
		КомандаСозданияНаОсновании.РежимЗаписи = ?(Параметры.ВидВРег = "ДОКУМЕНТ", "Проводить", "Записывать");
		КомандаСозданияНаОсновании.ФункциональныеОпции = "ИспользоватьПроцессыИЗадачи1СДокументооборота";
		КомандаСозданияНаОсновании.Порядок = 99;
	КонецЕсли;
	// Конец ИнтеграцияС1СДокументооборотом
	//-- НЕ БЗК
	
	//-- НЕ ГОСИС
	
КонецПроцедуры

// Определяет список команд создания на основании. Вызывается перед вызовом "ДобавитьКомандыСозданияНаОсновании" модуля
// менеджера объекта.
//
// Параметры:
//  Объект - ОбъектМетаданных - объект, для которого добавляются команды.
//  КомандыСозданияНаОсновании - см. СозданиеНаОснованииПереопределяемый.ПередДобавлениемКомандСозданияНаОсновании.КомандыСозданияНаОсновании
//  Параметры - см. СозданиеНаОснованииПереопределяемый.ПередДобавлениемКомандСозданияНаОсновании.Параметры
//  СтандартнаяОбработка - Булево - Если установить в Ложь, то событие "ДобавитьКомандыСозданияНаОсновании" менеджера
//                                  объекта не будет вызвано.
//
Процедура ПриДобавленииКомандСозданияНаОсновании(Объект, КомандыСозданияНаОсновании, Параметры, СтандартнаяОбработка) Экспорт
	
	
	
КонецПроцедуры

#КонецОбласти