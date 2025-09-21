create trigger trg_aux_weatherapi_countries_metadata  
    before update on raw.aux_weatherapi_countries
    for each row execute function raw.update_metadata();