insert into raw.aux_weatherapi_cities 
(
    name_en
  , name_ru
  , country_id
) 
select 
    name_en
  , name_ru
  , (select id 
  	   from raw.aux_weatherapi_countries 
  	  where name_en = 'Russia') as country_id
from 
     (values ('Moscow'			, 'Москва')
           , ('Saint Petersburg', 'Санкт-Петербург')
           , ('Novosibirsk'		, 'Новосибирск')
           , ('Yekaterinburg'	, 'Екатеринбург')
           , ('Kazan'			, 'Казань')
           , ('Nizhny Novgorod'	, 'Нижний Новгород')
           , ('Chelyabinsk'		, 'Челябинск')
           , ('Samara'			, 'Самара')
           , ('Omsk'			, 'Омск')
           , ('Rostov-on-Don'	, 'Ростов-на-Дону')
           , ('Ufa'				, 'Уфа')
           , ('Krasnoyarsk'		, 'Красноярск')
           , ('Voronezh'		, 'Воронеж')
           , ('Perm'			, 'Пермь')
           , ('Volgograd'		, 'Волгоград')
	) as cities(name_en, name_ru);