-- 1. Create the virtualization_software table
CREATE TABLE database (
    database_id RAW(16) DEFAULT sys_guid() PRIMARY KEY,
    database    VARCHAR2(1000) NOT NULL,
    CONSTRAINT uq_software_company UNIQUE ( database ),

    -- Additional columns for note and dates
    note                       VARCHAR2(4000),  -- General-purpose note field
    date_created               TIMESTAMP(9) WITH TIME ZONE DEFAULT systimestamp(9) NOT NULL,
    date_updated               TIMESTAMP(9) WITH TIME ZONE,
        date_created_or_updated TIMESTAMP(9) WITH TIME ZONE GENERATED ALWAYS AS ( COALESCE ( DATE_UPDATED , DATE_CREATED ) ) VIRTUAL
);


-- Trigger to update date_updated for virtualization_software
CREATE OR REPLACE TRIGGER trg_set_date_updated_database 
BEFORE UPDATE ON database
FOR EACH ROW
BEGIN
    :NEW.date_updated := systimestamp;
END;
/