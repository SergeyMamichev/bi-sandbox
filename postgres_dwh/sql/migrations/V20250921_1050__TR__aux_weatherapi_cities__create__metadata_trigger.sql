create trigger trg_aux_weatherapi_cities_metadata
    before update on raw.aux_weatherapi_cities
    for each row execute function raw.update_metadata();