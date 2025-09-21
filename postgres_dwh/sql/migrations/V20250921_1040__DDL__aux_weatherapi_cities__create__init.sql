create table raw.aux_weatherapi_cities
(
    id           integer generated always as identity primary key
  , name_en      varchar(255)               not null
  , name_ru      varchar(255)               not null
  , country_id   integer                    not null
  , is_active    boolean      default true  not null
  , api_url 	 varchar(500) default null
  , created_at   timestamp    default current_timestamp
  , created_by   varchar(100) default current_user
  , updated_at   timestamp
  , updated_by   varchar(100)
);

COMMENT ON TABLE raw.aux_weatherapi_cities IS 
'configuration table for WeatherAPI integration. 
Contains city names in English and Russian with cities references. 
API URLs and requests are formed based on data from this table.';

COMMENT ON COLUMN raw.aux_weatherapi_cities.id IS 'unique city identifier (auto-increment)';
COMMENT ON COLUMN raw.aux_weatherapi_cities.name_en IS 'city name in English';
COMMENT ON COLUMN raw.aux_weatherapi_cities.name_ru IS 'city name in Russian';
COMMENT ON COLUMN raw.aux_weatherapi_cities.country_id IS 'reference to country in aux_weatherapi_countries table';
COMMENT ON COLUMN raw.aux_weatherapi_cities.is_active IS 'city activity flag (true - active, false - inactive)';
COMMENT ON COLUMN raw.aux_weatherapi_cities.api_url IS '"url" attribute for the API request(optional)';
COMMENT ON COLUMN raw.aux_weatherapi_cities.created_at IS 'record creation date and time';
COMMENT ON COLUMN raw.aux_weatherapi_cities.created_by IS 'user who created the record';
COMMENT ON COLUMN raw.aux_weatherapi_cities.updated_at IS 'date and time of last record update';
COMMENT ON COLUMN raw.aux_weatherapi_cities.updated_by IS 'user who updated the record';