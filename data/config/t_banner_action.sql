INSERT INTO config.t_banner_action (id, str_title, active, str_type, str_bgcolor, str_route, lg_banner_id) VALUES (1, 'See More', 1, 'BUTTON', 'blue', 'categories', 1);


-- auto-generated definition
create table t_banner_action
(
    id           int auto_increment
        primary key,
    str_title    varchar(30)          null,
    active       tinyint(1) default 1 null,
    str_type     varchar(30)          null,
    str_bgcolor  varchar(30)          null,
    str_route    varchar(30)          null,
    lg_banner_id int                  null,
    constraint t_banner_action_t_banner_id_fk
        foreign key (lg_banner_id) references t_banner (id)
);

