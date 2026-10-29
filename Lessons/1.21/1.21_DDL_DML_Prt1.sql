--- .read Lessons/1.21/1.21_DDL_DML_Prt1.sql

use data_jobs;

drop database if exists jobs_mart;

create database if not exists jobs_mart;

SHOW DATABASES;

select * from information_schema.schemata;

use jobs_mart;

create schema if not exists staging;

--- drop schema staging;

create table if not exists staging.preferred_roles(
    rolte_id integer primary key,
    role_name varchar
);

select * 
from information_schema.tables
where table_catalog = 'jobs_mart';

insert into staging.preferred_roles (
    rolte_id, 
    role_name
)
values (
    1, 'data_engineer',
),
(
    2, 'Senior Data Engineer'
),
(3, 'software_engineer');

select * from staging.priority_roles;

alter table staging.preferred_roles
add column preferred_role boolean;

update staging.preferred_roles
set preferred_role = True
where rolte_id = 1 or rolte_id = 2;

update staging.preferred_roles
set preferred_role = False
where rolte_id = 3;

alter table staging.priority_role
rename to priority_roles;

alter table staging.priority_roles
rename column preferred_role to priority_lvl;

alter table staging.priority_roles
alter column priority_lvl type integer;

update staging.priority_roles
set priority_lvl = 3
where rolte_id = 3;
