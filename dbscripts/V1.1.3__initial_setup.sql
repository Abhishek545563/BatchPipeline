CREATE OR REPLACE PROCEDURE initial_setup() 
RETURNS VARCHAR
LANGUAGE SQL
AS
$$
BEGIN

create database if not exists leaplogic_cicd;
create schema if not exists leaplogic_cicd.config;
create schema if not exists leaplogic_cicd.landing_zone;
create schema if not exists leaplogic_cicd.curated_zone;
create schema if not exists leaplogic_cicd.consumption_zone;

CREATE TABLE IF NOT EXISTS leaplogic_cicd.CONFIG.PIPELINE_PROPERTIES (
  id INT AUTOINCREMENT,
  prop_name VARCHAR,
  prop_value VARCHAR,
  prop_status VARCHAR,
  time_stamp TIMESTAMP
);


INSERT INTO leaplogic_cicd.CONFIG.PIPELINE_PROPERTIES (prop_name, prop_value, prop_status, time_stamp)
VALUES
('AWS_ACCESS_KEY', 'AKIAZFRR4USBH6ODJBXT', 'ACTIVE', current_timestamp()),
('AWS_SECRET_KEY', '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', 'ACTIVE', current_timestamp()),
('S3_BUCKET', 'impetusll', 'ACTIVE', current_timestamp()),
('S3_REGION', 'Asia Pacific (Mumbai) ap-south-1', 'ACTIVE', current_timestamp()),
('ORDERS_FILE_PATH', 's3://impetusll/sample/order/', 'ACTIVE', current_timestamp()),
('CUSTOMER_FILE_PATH', 's3://impetusll/sample/customer/', 'ACTIVE', current_timestamp()),
('ITEM_FILE_PATH', 's3://impetusll/sample/item/', 'ACTIVE', current_timestamp()),
('S3_TARGET_BUCKET', 's3://impetusll/unload/', 'ACTIVE', current_timestamp()),
('FILE_FORMAT', 'json_format', 'ACTIVE', current_timestamp()),
('TARGET_FILE_FORMAT', 'parquet_format', 'ACTIVE', current_timestamp()),
('ORDERS_FILE_LOAD_PATTERN', '.*order.*[.]json', 'ACTIVE', current_timestamp()),
('CUSTOMER_FILE_LOAD_PATTERN', '.*customer.*[.]parquet', 'ACTIVE', current_timestamp()),
('ITEM_FILE_LOAD_PATTERN', '.*item.*[.]parquet', 'ACTIVE', current_timestamp());

/*INSERT INTO leaplogic_cicd.CONFIG.PIPELINE_PROPERTIES (prop_name, prop_value, prop_status, time_stamp)
VALUES
('AWS_ACCESS_KEY', 'AKIAZFRR4USBH6ODJBXT', 'ACTIVE', current_timestamp()),
('AWS_SECRET_KEY', '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', 'ACTIVE', current_timestamp()),
('S3_BUCKET', 'ma-test-onkar001', 'ACTIVE', current_timestamp()),
('S3_REGION', 'Asia Pacific (Mumbai) ap-south-1', 'ACTIVE', current_timestamp()),
('ORDERS_FILE_PATH', 's3://ma-test-onkar001/leaplogic_cicdsnowflakepoc/order/', 'ACTIVE', current_timestamp()),
('CUSTOMER_FILE_PATH', 's3://ma-test-onkar001/leaplogic_cicdsnowflakepoc/customer/', 'ACTIVE', current_timestamp()),
('ITEM_FILE_PATH', 's3://ma-test-onkar001/leaplogic_cicdsnowflakepoc/item/', 'ACTIVE', current_timestamp()),
('S3_TARGET_BUCKET', 's3://ma-test-onkar001/unload/', 'ACTIVE', current_timestamp()),
('FILE_FORMAT', 'csv_format', 'ACTIVE', current_timestamp()),
('TARGET_FILE_FORMAT', '(TYPE = PARQUET)', 'ACTIVE', current_timestamp());*/

END
$$;