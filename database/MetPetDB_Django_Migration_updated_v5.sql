-- Uncomment the following if you want to run this from the beginning
-- 
drop table element_mineral_types_dup;
drop table mineral_relationships_dup;
drop table oxide_mineral_types_dup;
drop table chemical_analysis_elements_dup;
drop table chemical_analysis_oxides_dup;
drop table sample_metamorphic_grades_dup;
drop table sample_metamorphic_regions_dup;
drop table sample_minerals_dup;
drop table sample_reference_dup;
drop table sample_regions_dup;

drop sequence element_mineral_types_dup_seq ;
drop sequence mineral_relationships_dup_seq ;
drop sequence oxide_mineral_types_dup_seq ;
drop sequence chemical_analysis_elements_dup_seq ;
drop sequence chemical_analysis_oxides_dup_seq ; 
drop sequence sample_metamorphic_grades_dup_seq ;
drop sequence sample_metamorphic_regions_dup_seq ;
drop sequence sample_minerals_dup_seq ;
drop sequence sample_reference_dup_seq ;
drop sequence sample_regions_dup_seq ;

-- element_mineral_types
create table element_mineral_types_dup as (select * from element_mineral_types);
create sequence element_mineral_types_dup_seq start 1;
alter table element_mineral_types_dup add column id int;
alter table element_mineral_types_dup add constraint element_mineral_types_unq unique(element_id, mineral_type_id);
update element_mineral_types_dup set id=nextval('element_mineral_types_dup_seq');
ALTER TABLE element_mineral_types_dup add primary key (id);

-- mineral_relationships
create table mineral_relationships_dup as (select * from mineral_relationships);
create sequence mineral_relationships_dup_seq start 1;
alter table mineral_relationships_dup add column id int;
alter table mineral_relationships_dup add constraint mineral_relationships_unq unique(parent_mineral_id, child_mineral_id);
update mineral_relationships_dup set id=nextval('mineral_relationships_dup_seq');
alter table mineral_relationships_dup add primary key (id);

-- oxide_mineral_types
create table oxide_mineral_types_dup as (select * from oxide_mineral_types);
create sequence oxide_mineral_types_dup_seq start 1;
alter table oxide_mineral_types_dup add column id int;
alter table oxide_mineral_types_dup add constraint oxide_mineral_types_unq unique(oxide_id, mineral_type_id);
update oxide_mineral_types_dup set id=nextval('oxide_mineral_types_dup_seq');
alter table oxide_mineral_types_dup add primary key (id);

-- chemical_analysis_elements
create table chemical_analysis_elements_dup as (select * from chemical_analysis_elements);
create sequence chemical_analysis_elements_dup_seq start 1;
alter table chemical_analysis_elements_dup add id int;
update chemical_analysis_elements_dup set id=nextval('chemical_analysis_elements_dup_seq');
alter table chemical_analysis_elements_dup add primary key (id);
alter table chemical_analysis_elements_dup add foreign key (chemical_analysis_id) references chemical_analyses (chemical_analysis_id) match simple on update no action on delete no action;
alter table chemical_analysis_elements_dup add foreign key (element_id) references elements (element_id) match simple on update no action on delete no action;


-- chemical_analysis_oxides
create table chemical_analysis_oxides_dup as (select * from chemical_analysis_oxides);
create sequence chemical_analysis_oxides_dup_seq start 1; 
alter table chemical_analysis_oxides_dup add column id int;
update chemical_analysis_oxides_dup set id=nextval('chemical_analysis_oxides_dup_seq');
alter table chemical_analysis_oxides_dup add primary key (id);
alter table chemical_analysis_oxides_dup add foreign key (chemical_analysis_id) references chemical_analyses (chemical_analysis_id) match simple on update no action on delete no action;
alter table chemical_analysis_oxides_dup add foreign key (oxide_id) references oxides (oxide_id) match simple on update no action on delete no action;

-- sample_metamorphic_grades
create table sample_metamorphic_grades_dup as (select * from sample_metamorphic_grades);
create sequence sample_metamorphic_grades_dup_seq start 1;
alter table sample_metamorphic_grades_dup add column id int;
update sample_metamorphic_grades_dup set id=nextval('sample_metamorphic_grades_dup_seq');
alter table sample_metamorphic_grades_dup add primary key (id);
alter table sample_metamorphic_grades_dup add foreign key (metamorphic_grade_id) references metamorphic_grades (metamorphic_grade_id) match simple on update no action on delete no action;
alter table sample_metamorphic_grades_dup add foreign key (sample_id) references samples (sample_id) match simple on update no action on delete no action;


-- sample_metamorphic_regions
create table sample_metamorphic_regions_dup as (select * from sample_metamorphic_regions);
create sequence sample_metamorphic_regions_dup_seq start 1;
alter table sample_metamorphic_regions_dup add column id int;
update sample_metamorphic_regions_dup set id=nextval('sample_metamorphic_regions_dup_seq');
alter table sample_metamorphic_regions_dup add primary key (id);
alter table sample_metamorphic_regions_dup add foreign key (metamorphic_region_id) references metamorphic_regions (metamorphic_region_id) match simple on update no action on delete no action;
alter table sample_metamorphic_regions_dup add foreign key (sample_id) references samples (sample_id) match simple on update no action on delete no action;

-- sample_minerals
create table sample_minerals_dup as (select * from sample_minerals);
create sequence sample_minerals_dup_seq start 1;
alter table sample_minerals_dup add column id int;
update sample_minerals_dup set id=nextval('sample_minerals_dup_seq');
alter table sample_minerals_dup add primary key (id);
alter table sample_minerals_dup add foreign key (mineral_id) references minerals (mineral_id) match simple on update no action on delete no action;
alter table sample_minerals_dup add foreign key (sample_id) references samples (sample_id) match simple on update no action on delete no action;

-- sample_reference
create table sample_reference_dup as (select * from sample_reference);
create sequence sample_reference_dup_seq start 1;
alter table sample_reference_dup add column id int;
update sample_reference_dup set id=nextval('sample_reference_dup_seq');
alter table sample_reference_dup add primary key (id);
alter table sample_reference_dup add foreign key (reference_id) references reference (reference_id) match simple on update no action on delete no action;
alter table sample_reference_dup add foreign key (sample_id) references samples (sample_id) match simple on update no action on delete no action;

-- sample_regions
create table sample_regions_dup as (select * from sample_regions);
create sequence sample_regions_dup_seq start 1;
alter table sample_regions_dup add column id int;
update sample_regions_dup set id=nextval('sample_regions_dup_seq');
alter table sample_regions_dup add primary key (id);
alter table sample_regions_dup add foreign key (region_id) references regions (region_id) match simple on update no action on delete no action;
alter table sample_regions_dup add foreign key (sample_id) references samples (sample_id) match simple on update no action on delete no action;


alter table element_mineral_types_dup owner to metpetdb_dev;
alter table mineral_relationships_dup owner to metpetdb_dev;
alter table oxide_mineral_types_dup owner to metpetdb_dev;
alter table chemical_analysis_elements_dup owner to metpetdb_dev;
alter table chemical_analysis_oxides_dup owner to metpetdb_dev;
alter table sample_metamorphic_grades_dup owner to metpetdb_dev;
alter table sample_metamorphic_regions_dup owner to metpetdb_dev;
alter table sample_minerals_dup owner to metpetdb_dev;
alter table sample_reference_dup owner to metpetdb_dev;
alter table sample_regions_dup owner to metpetdb_dev;

grant all privileges on element_mineral_types_dup_seq to metpetdb_dev;
grant all privileges on mineral_relationships_dup_seq to metpetdb_dev;
grant all privileges on oxide_mineral_types_dup_seq to metpetdb_dev;
grant all privileges on chemical_analysis_elements_dup_seq to metpetdb_dev;
grant all privileges on chemical_analysis_oxides_dup_seq to metpetdb_dev; 
grant all privileges on sample_metamorphic_grades_dup_seq to metpetdb_dev;
grant all privileges on sample_metamorphic_regions_dup_seq to metpetdb_dev;
grant all privileges on sample_minerals_dup_seq to metpetdb_dev;
grant all privileges on sample_reference_dup_seq to metpetdb_dev;
grant all privileges on sample_regions_dup_seq to metpetdb_dev;
