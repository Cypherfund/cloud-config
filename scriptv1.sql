-- we don't know how to generate root <with-no-name> (class Root) :(
grant audit_abort_exempt, firewall_exempt, select, system_user on *.* to 'mysql.infoschema'@localhost;

grant audit_abort_exempt, authentication_policy_admin, backup_admin, clone_admin, connection_admin, firewall_exempt, persist_ro_variables_admin, session_variables_admin, shutdown, super, system_user, system_variables_admin on *.* to 'mysql.session'@localhost;

grant audit_abort_exempt, firewall_exempt, system_user on *.* to 'mysql.sys'@localhost;

grant alter, alter routine, application_password_admin, audit_abort_exempt, audit_admin, authentication_policy_admin, backup_admin, binlog_admin, binlog_encryption_admin, clone_admin, connection_admin, create, create role, create routine, create tablespace, create temporary tables, create user, create view, delete, drop, drop role, encryption_key_admin, event, execute, file, firewall_exempt, flush_optimizer_costs, flush_status, flush_tables, flush_user_resources, group_replication_admin, group_replication_stream, index, innodb_redo_log_archive, innodb_redo_log_enable, insert, lock tables, passwordless_user_admin, persist_ro_variables_admin, process, references, reload, replication client, replication slave, replication_applier, replication_slave_admin, resource_group_admin, resource_group_user, role_admin, select, sensitive_variables_observer, service_connection_admin, session_variables_admin, set_user_id, show databases, show view, show_routine, shutdown, super, system_user, system_variables_admin, table_encryption_admin, trigger, update, xa_recover_admin, grant option on *.* to root@localhost;

create table campaign.t_account
(
    lg_account_id         varchar(255) not null
        primary key,
    db_cur_amount         double       null,
    int_deposit_count     int          null,
    int_total_deposits    double       null,
    int_total_withdrawals double       null,
    int_withdrawal_count  int          null,
    lg_user_id            varchar(255) null
);

create table campaign.t_bbn_subscriptions
(
    lg_bbn_subscription_id int auto_increment
        primary key,
    db_win_amount          double       null,
    int_num_times_won      int          null,
    lg_account_id          varchar(255) not null,
    constraint FK7ostayanmsvfs93taaifsfixd
        foreign key (lg_account_id) references campaign.t_account (lg_account_id)
);

create table campaign.t_campaign
(
    lg_campaign_id varchar(30)          not null
        primary key,
    b_active       tinyint(1) default 1 null,
    str_desc       varchar(255)         null,
    str_img        varchar(255)         null,
    str_name       varchar(255)         null,
    str_type       varchar(255)         null
);

create table campaign.t_category
(
    lg_category_id   varchar(30)  not null
        primary key,
    bg_color         varchar(255) null,
    db_max_selection int          null,
    db_max_stake     double       null,
    db_min_selection int          null,
    db_min_stake     double       null,
    str_desc         varchar(255) null,
    str_img          varchar(255) null,
    str_name         varchar(100) null,
    campaign         varchar(30)  null,
    constraint t_category_t_campaign_lg_campaign_id_fk
        foreign key (campaign) references campaign.t_campaign (lg_campaign_id)
);

create table campaign.t_bbn_events
(
    id               bigint auto_increment
        primary key,
    category         varchar(30)                        null,
    name             varchar(100)                       null,
    prediction_start datetime                           not null,
    prediction_end   datetime                           not null,
    event_date       datetime                           not null,
    status           varchar(10)                        null,
    created_at       datetime default CURRENT_TIMESTAMP not null,
    created_by       varchar(50)                        not null,
    last_modified_by int                                null,
    last_modified_at datetime                           null,
    constraint ca
        foreign key (category) references campaign.t_category (lg_category_id)
);

create table config.t_channel
(
    id       bigint auto_increment
        primary key,
    str_name varchar(100) null,
    str_code varchar(100) null,
    str_icon varchar(100) null,
    str_url  varchar(100) null
);

create table payment.t_country
(
    str_country_code varchar(255) not null
        primary key,
    dt_date_created  datetime(6)  null,
    dt_date_updated  datetime(6)  null,
    str_country_name varchar(255) null,
    str_dialing_code varchar(255) null
);

create table users.t_country_codes
(
    KEY_COUNTRY_CODE varchar(3) charset utf8mb3  not null
        primary key,
    str_country_name varchar(50) charset utf8mb3 null
);

create table payment.t_country_payment
(
    lg_country_payment_id bigint auto_increment
        primary key,
    dt_date_created       datetime(6) null,
    dt_date_updated       datetime(6) null,
    lg_country_id         int         null,
    lg_payment_method_id  int         null
);

create table campaign.t_housemate
(
    id            varchar(30)  not null
        primary key,
    str_desc      varchar(255) null,
    str_name      varchar(255) null,
    str_image_url varchar(200) null
);

create table campaign.t_even_option
(
    id        varchar(30)  not null
        primary key,
    db_odd    double(4, 2) null,
    bbn_event bigint       null,
    housemate varchar(30)  null,
    constraint t_even_option_bbn_events_id_fk
        foreign key (bbn_event) references campaign.t_bbn_events (id),
    constraint t_even_option_t_housemate_id_fk
        foreign key (housemate) references campaign.t_housemate (id)
);

create table config.t_menu
(
    id         bigint auto_increment
        primary key,
    str_name   varchar(100) null,
    str_key    varchar(100) null,
    str_icon   varchar(100) null,
    str_route  varchar(100) null,
    str_type   varchar(100) null,
    channel_id bigint       null,
    constraint FK_T_MENU_ON_CHANNEL
        foreign key (channel_id) references config.t_channel (id)
);

create table config.t_banner
(
    id        int auto_increment comment 'id',
    b_active  boolean default 1 null,
    str_title varchar(100)      null,
    str_text  text              null,
    str_image varchar(100)      null,
    str_type  varchar(30)       null,
    constraint t_banner_pk
        primary key (id)
);

create table campaign.t_paramters
(
    str_key         varchar(255) not null
        primary key,
    b_status        bit          null,
    str_description varchar(255) null,
    str_value       varchar(255) null
);

create table config.t_paramters
(
    str_key   varchar(50)             not null
        primary key,
    str_value varchar(255) default '' null,
    b_status  tinyint(1)   default 1  null
)
    charset = utf8mb3;

create table payment.t_paramters
(
    str_key   varchar(255) not null
        primary key,
    str_value varchar(255) null,
    b_status  bit          null
);

create table users.t_paramters
(
    str_key         varchar(255) not null
        primary key,
    str_value       varchar(255) null,
    str_description varchar(255) null,
    b_status        tinyint(1)   null
)
    charset = utf8mb3;

create table payment.t_payment_providers
(
    lg_payment_providers     smallint auto_increment
        primary key,
    b_active                 bit          null,
    b_cashin                 bit          null,
    b_cashout                bit          null,
    db_max_deposit_amount    double       null,
    db_max_withdrawal_amount double       null,
    db_min_deposit_amount    double       null,
    db_min_withdrawal_amount double       null,
    dt_date_created          datetime(6)  null,
    dt_date_updated          datetime(6)  null,
    str_driver_class_name    varchar(255) null,
    str_image_url            double       null,
    str_payment_code         varchar(255) not null,
    str_payment_type         varchar(255) null
);

create table campaign.t_predictions
(
    lg_prediction_id varchar(255)                 not null
        primary key,
    b_active         bit                          null,
    db_odd           double                       null,
    db_pot_win       double                       null,
    db_stake         double                       null,
    str_options      varchar(255)                 null,
    str_status       varchar(255)                 null,
    bbn_event        bigint                       null,
    user_id          varchar(30)                  not null,
    broken           tinyint     default 0        not null,
    formula          varchar(20) default 'NORMAL' null,
    constraint t_predictions_t_bbn_events_id_fk
        foreign key (bbn_event) references campaign.t_bbn_events (id)
);

create table payment.t_received_callback
(
    lg_trace_id     varchar(255) not null
        primary key,
    dt_date_created datetime(6)  null,
    str_status      varchar(255) null
);

create table campaign.t_result
(
    lg_result      bigint auto_increment
        primary key,
    str_win_number varchar(50) not null,
    bbn_event      bigint      null,
    dt_created     datetime    null,
    str_type       varchar(20) null,
    str_status     varchar(20) null,
    points         int         not null,
    constraint bbn
        foreign key (bbn_event) references campaign.t_bbn_events (id)
);

create table users.t_role
(
    lg_role_id           varchar(20)                        not null
        primary key,
    str_role_description varchar(50)                        null,
    b_active             tinyint  default 0                 null,
    dt_created           datetime default CURRENT_TIMESTAMP not null
);

create table campaign.t_simple_prediction
(
    id          varchar(255) not null
        primary key,
    b_active    bit          null,
    prediction  varchar(30)  null,
    db_odd      double       null,
    db_pot_win  double       null,
    db_stake    double       null,
    int_points  int          null,
    str_options varchar(30)  null,
    constraint t_simple_prediction_t_predictions_lg_prediction_id_fk
        foreign key (prediction) references campaign.t_predictions (lg_prediction_id)
);

create table campaign.t_social_media
(
    lg_social_media_id int          not null
        primary key,
    int_followers      int          null,
    int_followings     int          null,
    str_type           varchar(255) null,
    str_url            varchar(255) null,
    housemate          varchar(30)  not null,
    constraint t_social_media_ibfk_1
        foreign key (housemate) references campaign.t_housemate (id)
);

create index housemate
    on campaign.t_social_media (housemate);

create table users.t_token
(
    lg_token_id varchar(50) charset utf8mb3  not null
        primary key,
    str_refresh varchar(255) charset utf8mb3 null,
    status      varchar(10) charset utf8mb3  null,
    dt_created  timestamp                    null
);

create table payment.t_trace
(
    lg_trace_id                 varchar(255) not null
        primary key,
    b_callback_received         bit          null,
    db_amount                   double       null,
    dt_date_created             datetime(6)  null,
    str_callback_url            varchar(255) null,
    str_originating_transaction varchar(255) null,
    str_phone_number            varchar(255) null,
    lg_payment_providers        smallint     null,
    constraint FKbpb5n2tn0mrlmbdji8ar3ticr
        foreign key (lg_payment_providers) references payment.t_payment_providers (lg_payment_providers)
);

create table payment.t_trace_status
(
    lg_trace_status          varchar(255) not null
        primary key,
    dt_date_created          datetime(6)  null,
    lg_trace_id              varchar(255) null,
    str_ext_code             varchar(255) null,
    str_external_transaction varchar(255) null,
    str_msg                  varchar(255) null,
    str_status               varchar(255) null
);

create table users.t_users
(
    user_id            varchar(50)                  not null
        primary key,
    name               varchar(255) charset utf8mb3 null,
    username           varchar(255) charset utf8mb3 not null,
    phone              varchar(15) charset utf8mb3  null,
    password           varchar(255) charset utf8mb3 not null,
    status             varchar(15) charset utf8mb3  null,
    dt_created         datetime                     null,
    dt_updated         datetime                     null,
    email              varchar(40) charset utf8mb3  null,
    str_login_provider varchar(15) default 'local'  null
);

create table users.t_role_user
(
    lg_role_user_id bigint auto_increment
        primary key,
    lg_role_id      varchar(20)                         null,
    user_id         varchar(50)                         null,
    dt_created      timestamp default CURRENT_TIMESTAMP null,
    constraint t_role_user_ibfk_1
        foreign key (lg_role_id) references users.t_role (lg_role_id),
    constraint t_role_user_t_users_user_id_fk
        foreign key (user_id) references users.t_users (user_id)
);

create index lg_role_id
    on users.t_role_user (lg_role_id);

create index `user status`
    on users.t_users (status);

create table campaign.t_winning_combination
(
    id         bigint         not null
        primary key,
    bbn_event  bigint         null,
    created_at timestamp      null,
    win_amount decimal(15, 3) null,
    constraint t_winning_combination_t_bbn_events_id_fk
        foreign key (bbn_event) references campaign.t_bbn_events (id)
);

create table campaign.t_winning_prediction
(
    lg_prediction_id varchar(255) not null
        primary key,
    b_active         bit          null,
    db_odd           double       null,
    win_amount       double       null,
    db_stake         double       null,
    str_options      varchar(255) null,
    str_status       varchar(255) null,
    bbn_event        bigint       null,
    constraint t_winning_prediction_ibfk_1
        foreign key (bbn_event) references campaign.t_bbn_events (id)
);

create index t_predictions_t_bbn_events_id_fk
    on campaign.t_winning_prediction (bbn_event);
