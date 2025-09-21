create table raw.aux_weatherapi_countries
(
    id           integer generated always as identity primary key
  , name_en      varchar(255)               not null
  , name_ru      varchar(255)               not null
  , is_active    boolean      default true  not null
  , created_at   timestamp    default current_timestamp
  , created_by   varchar(100) default current_user
  , updated_at   timestamp
  , updated_by   varchar(100)
);

COMMENT ON TABLE raw.aux_weatherapi_countries IS 
'configuration table for Weather API integration. 
Contains country names in English and Russian. 
API requests are formed based on data from this table.';

COMMENT ON COLUMN raw.aux_weatherapi_countries.id IS 'unique country identifier (auto-increment)';
COMMENT ON COLUMN raw.aux_weatherapi_countries.name_en IS 'country name in English';
COMMENT ON COLUMN raw.aux_weatherapi_countries.name_ru IS 'country name in Russian';
COMMENT ON COLUMN raw.aux_weatherapi_countries.is_active IS 'country activity flag (true - active, false - inactive)';
COMMENT ON COLUMN raw.aux_weatherapi_countries.created_at IS 'record creation date and time';
COMMENT ON COLUMN raw.aux_weatherapi_countries.created_by IS 'user who created the record';
COMMENT ON COLUMN raw.aux_weatherapi_countries.updated_at IS 'date and time of last record update';
COMMENT ON COLUMN raw.aux_weatherapi_countries.updated_by IS 'user who updated the record';