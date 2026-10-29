create table if not exists staging.priority_roles(
    role_id integer primary key,
    role_name varchar,
    priority_lvl integer
);

insert into staging.priority_roles (role_id, role_name, priority_lvl)
values
(1, 'Data Engineer', 1),
(2, 'Senior Data Engineer', 1),
(3, 'Software Engineer', 3),


on conflict (role_id) do nothing;

select * from staging.priority_roles;


-- INSERT INTO
--     staging.priority_roles (
--         role_id,
--         role_name,
--         priority_lvl
--     )
-- VALUES
--     (4, 'Data Scientist', 3);

-- UPDATE
--     staging.priority_roles
-- SET
--     priority_lvl = 1
-- WHERE
--     role_id = 1;

-- DELETE FROM
--     staging.priority_roles
-- WHERE
--     role_id = 4
--     AND priority_lvl = 3;