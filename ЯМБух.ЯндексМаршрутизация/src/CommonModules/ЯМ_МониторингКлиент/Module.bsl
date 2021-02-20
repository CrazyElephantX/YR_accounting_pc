
Функция ОбновитьМашиныВМониторинге(МассивДанныхМашины, Настройки) Экспорт 
		
	// обновить машины
	// POST https://courier.yandex.ru/api/v1/companies/{company_id}/couriers-batch
	
	//{
	//"company_id": integer,
	//"id": integer,
	//"name": string,
	//"number": string,
	//"phone": string,
	//"sms_enabled": boolean
	//}
	
	Ответ = ЯМ_МониторингСервер.ЗапросМониторинг("couriers-batch",МассивДанныхМашины,Настройки);
	КодСостояния = Ответ.КодСостояния;
	
	Если НЕ ТипЗнч(Ответ) = Тип("Структура") Тогда 
		
		Сообщить("Ощибка формирования запроса! Код ошибки " + Строка(КодСостояния) + " 
		|Информация о структуре запросов и их примеры в инструкции https://yandex.ru/routing/doc/vrp/");
		
		Возврат Ложь;
		
	Иначе
		
		Если КодСостояния = 200 Тогда 
			Сообщить("Данные по машинам обновлены");
		Иначе
			Сообщить("Ошибка обновления машин в мониторинге");
		КонецЕсли;
		
	КонецЕсли;	
	
	Возврат Истина;
	
КонецФункции

Функция ОбновитьСкладыВМониторинге(МассивДанныхСклады, Настройки) Экспорт 
		
	// POST https://courier.yandex.ru/api/v1/companies/{company_id}/depots-batch
	
	//{
	//"address": string,
	//"allow_route_editing": boolean,
	//"description": string,
	//"id": integer,
	//"lat": number,
	//"lon": number,
	//"mark_route_started_radius": integer,
	//"name": string,
	//"number": string,
	//"order_service_duration_s": integer,
	//"service_duration_s": integer,
	//"time_interval": string,
	//"time_zone": string
	//}
	
	Ответ = ЯМ_МониторингСервер.ЗапросМониторинг("depots-batch",МассивДанныхСклады,Настройки);
	КодСостояния = Ответ.КодСостояния;
	
	Если НЕ ТипЗнч(Ответ) = Тип("Структура") Тогда 
		
		Сообщить("Ощибка формирования запроса! Код ошибки " + Строка(КодСостояния) + " 
		|Информация о структуре запросов и их примеры в инструкции https://yandex.ru/routing/doc/vrp/");
		
		Возврат Ложь;
		
	Иначе	
		
		Если КодСостояния = 200 Тогда 
			Сообщить("Данные по складам обновлены");
		Иначе
			Сообщить("Ошибка обновления складов в мониторинге");
		КонецЕсли;
		
	КонецЕсли;	
	
	Возврат Истина;
	
КонецФункции

Функция ОбновитьМаршрутыВМониторинге(МассивДанныхМаршруты, Настройки) Экспорт 
		
	// POST https://courier.yandex.ru/api/v1/companies/{company_id}/routes-batch
	
	//{
	//"car_id": integer,
	//"courier_id": integer,
	//"courier_number": string,
	//"date": string,
	//"depot_id": integer,
	//"depot_number": string,
	//"id": integer,
	//"imei": integer,
	//"number": string,
	//"route_finish": string,
	//"route_start": string
	//}
	
	Ответ = ЯМ_МониторингСервер.ЗапросМониторинг("routes-batch",МассивДанныхМаршруты,Настройки);
	КодСостояния = Ответ.КодСостояния;
		
	Если НЕ ТипЗнч(Ответ) = Тип("Структура") Тогда 
		
		Сообщить("Ощибка формирования запроса! Код ошибки " + Строка(КодСостояния) + " 
		|Информация о структуре запросов и их примеры в инструкции https://yandex.ru/routing/doc/vrp/");
		
		Возврат Ложь;
		
	Иначе	
		
		Если КодСостояния = 200 Тогда 
			Сообщить("Данные по маршрутам обновлены");
		Иначе
			Сообщить("Ошибка обновления маршрутов в мониторинге");
		КонецЕсли;
		
	КонецЕсли;
	
	Возврат Истина;
	
КонецФункции

Функция ОбновитьТочкиДоставкиВМониторинге(МассивДанныхТочкиДоставки, Настройки) Экспорт 
		
	// POST https://courier.yandex.ru/api/v1/companies/{company_id}/orders-batch
		
	//{
	//"address": string,
	//"amount": number,
	//"comments": string,
	//"customer_id": integer,
	//"customer_name": string,
	//"customer_number": string,
	//"description": string,
	//"lat": number,
	//"lon": number,
	//"mark_delivered_radius": number,
	//"number": string,
	//"partner_id": integer,
	//"payment_type": string,
	//"phone": string,
	//"route_id": integer,
	//"route_number": string,
	//"service_duration_s": integer,
	//"shared_service_duration_s": integer,
	//"shared_with_company_id": integer,
	//	"shared_with_company_ids": [
	//	number
	//	],
	//"status": string,
	//"time_interval": string,
	//"volume": number,
	//"weight": number
	//}	
	
	Ответ = ЯМ_МониторингСервер.ЗапросМониторинг("orders-batch",МассивДанныхТочкиДоставки,Настройки);
	КодСостояния = Ответ.КодСостояния;
	
	Если НЕ ТипЗнч(Ответ) = Тип("Структура") Тогда 
		
		Сообщить("Ощибка формирования запроса! Код ошибки " + Строка(КодСостояния) + " 
		|Информация о структуре запросов и их примеры в инструкции https://yandex.ru/routing/doc/vrp/");
		
		Возврат Ложь;
		
	Иначе
		
		Если КодСостояния = 200 Тогда 
			Сообщить("Данные по точкам доставки обновлены");
		Иначе
			Сообщить("Ошибка обновления точек доставки в мониторинге");
		КонецЕсли;
		
	КонецЕсли;
	
	Возврат Истина;
	
КонецФункции