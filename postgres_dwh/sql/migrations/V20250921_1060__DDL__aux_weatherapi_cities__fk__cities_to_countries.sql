alter table raw.aux_weatherapi_cities 
    add constraint fk_cities_countries 
    foreign key (country_id) 
    references raw.aux_weatherapi_countries(id);