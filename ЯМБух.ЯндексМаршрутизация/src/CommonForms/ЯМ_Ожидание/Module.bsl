
&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	Если Параметры.Свойство("idПланирования") Тогда
		ИДПланирования = Параметры.idПланирования;
	КонецЕсли;
	Если Параметры.Свойство("КоличествоЗаказов") Тогда
		Осталось = Параметры.КоличествоЗаказов;
	КонецЕсли;
КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)
	ПодключитьОбработчикОжидания("ПолучитьРезультатМаршрутизации",10,Ложь);
КонецПроцедуры

//@skip-warning
&НаКлиенте
Процедура ПолучитьРезультатМаршрутизации()
	Осталось = Осталось - 10;
	ДатаЗапомнить = ТекущаяДата();
	РезультатОбработки = ОбработатьОжидание();
	Если РезультатОбработки Тогда
		ОтключитьОбработчикОжидания("ПолучитьРезультатМаршрутизации");
		ЭтаФорма.Закрыть();
	КонецЕсли;
	Осталось = Осталось - (ТекущаяДата() - ДатаЗапомнить);
	ЭтаФорма.ОбновитьОтображениеДанных();
КонецПроцедуры

&НаСервере
Функция ОбработатьОжидание()
	РезультатОбработки = Ложь;
	Запрос = Новый Запрос("ВЫБРАТЬ
	|	ЯМ_ЗапросыНаМаршрутизациюСрезПоследних.id КАК id,
	|	ЯМ_ЗапросыНаМаршрутизациюСрезПоследних.СтатусЗапроса КАК СтатусЗапроса
	|ИЗ
	|	РегистрСведений.ЯМ_ЗапросыНаМаршрутизацию.СрезПоследних КАК ЯМ_ЗапросыНаМаршрутизациюСрезПоследних
	|ГДЕ
	|	ЯМ_ЗапросыНаМаршрутизациюСрезПоследних.СтатусЗапроса = ЗНАЧЕНИЕ(Перечисление.ЯМ_СтатусыЗапросов.Завершен)
	|	И ЯМ_ЗапросыНаМаршрутизациюСрезПоследних.id = &ИДПланирования");
	Запрос.УстановитьПараметр("ИДПланирования",ИДПланирования);
	Результат = Запрос.Выполнить();
	Если Результат.Пустой() Тогда 
		Соединение = Новый HTTPСоединение("courier.yandex.ru",,,
		,Новый ИнтернетПрокси(Истина)
		,
		,Новый ЗащищенноеСоединениеOpenSSL);
		
		РезультатОбработки = ЗагрузитьДанные(Соединение,ИДПланирования,"Запрос");
	Иначе
		РезультатОбработки = Истина;
	КонецЕсли;
	
	Возврат РезультатОбработки;
КонецФункции

&НаСервере
Функция ЗагрузитьДанные(Соединение,ИД,Тип)
	
	Адрес = "/vrs/api/v1/result/mvrp/" + ИД;
	
	Запрос = Новый HTTPЗапрос(Адрес);
	Запрос.Заголовки.Вставить("Content-Type",	"application/json");
	Запрос.Заголовки.Вставить("Accept",			"application/json");
	
	// формирование запроса
	Ответ = Соединение.Получить(Запрос);
	
	Если ТипЗнч(Ответ) = Тип("HTTPОтвет") Тогда 
		Чтение = Новый ЧтениеJSON;
		ОтветСтрокой = Ответ.ПолучитьТелоКакСтроку(); 
		Чтение.УстановитьСтроку(ОтветСтрокой);
		Результат = ПрочитатьJSON(Чтение);
		
		Если Результат.Свойство("error") Тогда
			id = ИД;
			Сообщение = Результат.error.message;
			Статус = "Error";
			Возврат Ложь;
		ИначеЕсли Результат.Свойство("id") Тогда
			id = ИД;
			Сообщение = Результат.Message;
			Статус = Результат.Status;
		КонецЕсли;
		
		Если Результат.Свойство("id") И Результат.Message = "Task successfully completed" Тогда
			ЗаписатьДанныеЗапросаНаСервере(id, Статус, Сообщение,Тип);
			Возврат Истина;
		Иначе
			Возврат Ложь;
		КонецЕсли;
	Иначе	
		// при необходимости реализовать логирование ошибки формирования запроса
		Возврат Ложь;	
	КонецЕсли;
КонецФункции

&НаСервере
Процедура ЗаписатьДанныеЗапросаНаСервере(id, Статус = Неопределено, Сообщение,тип)
	Выполнить("ЯМ_МаршрутизацияСервер.ЗаписатьДанныеЗапроса(id, Статус, Сообщение,тип)");	
КонецПроцедуры