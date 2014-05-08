DROP TRIGGER element_mineral_types_sync_trg ON element_mineral_types;
DROP FUNCTION element_mineral_types_sync();

DROP TRIGGER chemical_analysis_elements_sync_trg ON chemical_analysis_elements;
DROP FUNCTION chemical_analysis_elements_sync();

DROP TRIGGER chemical_analysis_oxides_sync_trg ON chemical_analysis_oxides;
DROP FUNCTION chemical_analysis_oxides_sync();

DROP TRIGGER sample_metamorphic_grades_sync_trg ON sample_metamorphic_grades;
DROP FUNCTION sample_metamorphic_grades_sync();

DROP TRIGGER sample_metamorphic_regions_sync_trg ON sample_metamorphic_regions;
DROP FUNCTION sample_metamorphic_regions_sync();

DROP TRIGGER sample_minerals_sync_trg ON sample_minerals;
DROP FUNCTION sample_minerals_sync();

DROP TRIGGER sample_reference_sync_trg ON sample_reference;
DROP FUNCTION sample_reference_sync();

DROP TRIGGER sample_regions_sync_trg ON sample_regions;
DROP FUNCTION sample_regions_sync();

-- element_mineral_types

CREATE OR REPLACE FUNCTION element_mineral_types_sync() RETURNS trigger AS $$
BEGIN
    INSERT INTO element_mineral_types_dup(id, element_id, mineral_type_id)
    VALUES (nextval('element_mineral_types_dup_seq'), NEW.element_id, NEW.mineral_type_id) ;
    RETURN NULL ;
END ;
$$ LANGUAGE 'plpgsql';

CREATE TRIGGER element_mineral_types_sync_trg
AFTER INSERT OR UPDATE ON element_mineral_types
FOR EACH ROW EXECUTE PROCEDURE element_mineral_types_sync();

-- chemical_analysis_elements

CREATE OR REPLACE FUNCTION chemical_analysis_elements_sync() RETURNS trigger AS $$
BEGIN
    INSERT INTO chemical_analysis_elements_dup(chemical_analysis_id, element_id, amount, precision, precision_type, measurement_unit, min_amount, max_amount, id)
    VALUES (NEW.chemical_analysis_id,NEW.element_id,NEW.amount,NEW.precision,NEW.precision_type, NEW.measurement_unit, NEW.min_amount, NEW.max_amount, nextval('chemical_analysis_elements_dup_seq')) ;
    RETURN NULL ;
END ;
$$ LANGUAGE 'plpgsql';

CREATE TRIGGER chemical_analysis_elements_sync_trg
AFTER INSERT OR UPDATE ON chemical_analysis_elements
FOR EACH ROW EXECUTE PROCEDURE chemical_analysis_elements_sync();

-- chemical_analysis_oxides
CREATE OR REPLACE FUNCTION chemical_analysis_oxides_sync() RETURNS trigger AS $$
BEGIN
    INSERT INTO chemical_analysis_oxides_dup(chemical_analysis_id,oxide_id,amount,precision, precision_type,measurement_unit,min_amount,max_amount,id)
    VALUES (NEW.chemical_analysis_id,NEW.oxide_id,NEW.amount,NEW.precision, NEW.precision_type,NEW.measurement_unit,NEW.min_amount,NEW.max_amount, nextval('chemical_analysis_oxides_dup_seq')) ;
    RETURN NULL ;
END ;
$$ LANGUAGE 'plpgsql';

CREATE TRIGGER chemical_analysis_oxides_sync_trg
AFTER INSERT OR UPDATE ON chemical_analysis_oxides
FOR EACH ROW EXECUTE PROCEDURE chemical_analysis_oxides_sync();

-- sample_metamorphic_grades
CREATE OR REPLACE FUNCTION sample_metamorphic_grades_sync() RETURNS trigger AS $$
BEGIN
    INSERT INTO sample_metamorphic_grades_dup(sample_id,metamorphic_grade_id,id)
    VALUES (NEW.sample_id,NEW.metamorphic_grade_id, nextval('sample_metamorphic_grades_dup_seq')) ;
    RETURN NULL ;
END ;
$$ LANGUAGE 'plpgsql';

CREATE TRIGGER sample_metamorphic_grades_sync_trg
AFTER INSERT OR UPDATE ON sample_metamorphic_grades
FOR EACH ROW EXECUTE PROCEDURE sample_metamorphic_grades_sync();

-- sample_metamorphic_regions
CREATE OR REPLACE FUNCTION sample_metamorphic_regions_sync() RETURNS trigger AS $$
BEGIN
    INSERT INTO sample_metamorphic_regions_dup(sample_id,metamorphic_region_id,id)
    VALUES (NEW.sample_id,NEW.metamorphic_region_id, nextval('sample_metamorphic_regions_dup_seq')) ;
    RETURN NULL ;
END ;
$$ LANGUAGE 'plpgsql';

CREATE TRIGGER sample_metamorphic_regions_sync_trg
AFTER INSERT OR UPDATE ON sample_metamorphic_regions
FOR EACH ROW EXECUTE PROCEDURE sample_metamorphic_regions_sync();

-- sample_minerals
CREATE OR REPLACE FUNCTION sample_minerals_sync() RETURNS trigger AS $$
BEGIN
    INSERT INTO sample_minerals_dup(mineral_id, sample_id, amount,id)
    VALUES (NEW.mineral_id, NEW.sample_id, NEW.amount, nextval('sample_minerals_dup_seq')) ;
    RETURN NULL ;
END ;
$$ LANGUAGE 'plpgsql';

CREATE TRIGGER sample_minerals_sync_trg
AFTER INSERT OR UPDATE ON sample_minerals
FOR EACH ROW EXECUTE PROCEDURE sample_minerals_sync();

-- sample_reference
CREATE OR REPLACE FUNCTION sample_reference_sync() RETURNS trigger AS $$
BEGIN
    INSERT INTO sample_reference_dup(sample_id,reference_id,id)
    VALUES (NEW.sample_id,NEW.reference_id, nextval('sample_reference_dup_seq')) ;
    RETURN NULL ;
END ;
$$ LANGUAGE 'plpgsql';

CREATE TRIGGER sample_reference_sync_trg
AFTER INSERT OR UPDATE ON sample_reference
FOR EACH ROW EXECUTE PROCEDURE sample_reference_sync();

-- sample_regions
CREATE OR REPLACE FUNCTION sample_regions_sync() RETURNS trigger AS $$
BEGIN
    INSERT INTO sample_regions_dup(sample_id,region_id,id)
    VALUES (NEW.sample_id,NEW.region_id, nextval('sample_regions_dup_seq')) ;
    RETURN NULL ;
END ;
$$ LANGUAGE 'plpgsql';

CREATE TRIGGER sample_regions_sync_trg
AFTER INSERT OR UPDATE ON sample_regions
FOR EACH ROW EXECUTE PROCEDURE sample_regions_sync();


GRANT TRIGGER ON TABLE element_mineral_types to metpetdb_dev;
GRANT TRIGGER ON TABLE chemical_analysis_elements to metpetdb_dev;
GRANT TRIGGER ON TABLE chemical_analysis_oxides to metpetdb_dev;
GRANT TRIGGER ON TABLE sample_metamorphic_grades to metpetdb_dev;
GRANT TRIGGER ON TABLE sample_metamorphic_regions to metpetdb_dev;
GRANT TRIGGER ON TABLE sample_minerals to metpetdb_dev;
GRANT TRIGGER ON TABLE sample_reference to metpetdb_dev;
GRANT TRIGGER ON TABLE sample_regions to metpetdb_dev;


ALTER FUNCTION element_mineral_types_sync() OWNER TO metpetdb_dev;
ALTER FUNCTION chemical_analysis_elements_sync() OWNER TO metpetdb_dev;
ALTER FUNCTION chemical_analysis_oxides_sync() OWNER TO metpetdb_dev;
ALTER FUNCTION sample_metamorphic_grades_sync() OWNER TO metpetdb_dev;
ALTER FUNCTION sample_metamorphic_regions_sync() OWNER TO metpetdb_dev;
ALTER FUNCTION sample_minerals_sync() OWNER TO metpetdb_dev;
ALTER FUNCTION sample_reference_sync() OWNER TO metpetdb_dev;
ALTER FUNCTION sample_regions_sync() OWNER TO metpetdb_dev;
