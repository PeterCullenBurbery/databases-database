ALTER TABLE database ADD (
    how_to_set_a_column_to_be_nullable_so_null_is_allowed VARCHAR2(4000),
    note_001                                              VARCHAR2(4000),
    date_created_001                                      TIMESTAMP(9) WITH TIME ZONE,
    date_updated_001                                      TIMESTAMP(9) WITH TIME ZONE,
        date_created_or_updated_001                           TIMESTAMP(9) WITH TIME ZONE GENERATED ALWAYS AS ( coalesce(date_updated_001
        , date_created_001) ) VIRTUAL
);

UPDATE database
SET
    note_001 = note,
    date_created_001 = date_created,
    date_updated_001 = date_updated;

ALTER TABLE database DROP COLUMN date_created_or_updated;

ALTER TABLE database DROP ( note,
                            date_created,
                            date_updated );

ALTER TABLE database RENAME COLUMN note_001 TO note;

ALTER TABLE database RENAME COLUMN date_created_001 TO date_created;

ALTER TABLE database RENAME COLUMN date_updated_001 TO date_updated;

ALTER TABLE database RENAME COLUMN date_created_or_updated_001 TO date_created_or_updated;