/* Function: raw.update_metadata()
 * Description: Automatically updates metadata (created_at, created_by, updated_at, updated_by) on INSERT/UPDATE operations
 */ 

CREATE OR REPLACE FUNCTION raw.update_metadata()
RETURNS TRIGGER AS $$
BEGIN
    IF TG_OP = 'INSERT' THEN
        NEW.created_at = COALESCE(NEW.created_at, CURRENT_TIMESTAMP);
        NEW.created_by = COALESCE(NEW.created_by, CURRENT_USER);
    ELSIF TG_OP = 'UPDATE' THEN
        NEW.updated_at = CURRENT_TIMESTAMP;
        NEW.updated_by = CURRENT_USER;
    END IF;
    
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

COMMENT ON FUNCTION raw.update_metadata() 
IS 'Automatically updates metadata (created_at, created_by, updated_at, updated_by) on INSERT/UPDATE operations';