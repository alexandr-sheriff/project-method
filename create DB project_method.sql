create table file
(
    file_id          bigint auto_increment
        primary key,
    encoded_filename varchar(255) null,
    filename         varchar(255) null
);

create table flyway_schema_history
(
    installed_rank int                                 not null
        primary key,
    version        varchar(50)                         null,
    description    varchar(200)                        not null,
    type           varchar(20)                         not null,
    script         varchar(1000)                       not null,
    checksum       int                                 null,
    installed_by   varchar(100)                        not null,
    installed_on   timestamp default CURRENT_TIMESTAMP not null,
    execution_time int                                 not null,
    success        tinyint(1)                          not null
);

create index flyway_schema_history_s_idx
    on flyway_schema_history (success);

create table spring_session
(
    PRIMARY_ID            char(36)     not null
        primary key,
    SESSION_ID            char(36)     not null,
    CREATION_TIME         bigint       not null,
    LAST_ACCESS_TIME      bigint       not null,
    MAX_INACTIVE_INTERVAL int          not null,
    EXPIRY_TIME           bigint       not null,
    PRINCIPAL_NAME        varchar(100) null,
    constraint SPRING_SESSION_IX1
        unique (SESSION_ID)
);

create index SPRING_SESSION_IX2
    on spring_session (EXPIRY_TIME);

create index SPRING_SESSION_IX3
    on spring_session (PRINCIPAL_NAME);

create table spring_session_attributes
(
    SESSION_PRIMARY_ID char(36)     not null,
    ATTRIBUTE_NAME     varchar(200) not null,
    ATTRIBUTE_BYTES    blob         not null,
    primary key (SESSION_PRIMARY_ID, ATTRIBUTE_NAME),
    constraint SPRING_SESSION_ATTRIBUTES_FK
        foreign key (SESSION_PRIMARY_ID) references spring_session (PRIMARY_ID)
            on delete cascade
);

create table user
(
    user_id                  bigint auto_increment
        primary key,
    activation_code          varchar(255) null,
    active                   bit          not null,
    email                    varchar(32)  null,
    firstname                varchar(16)  null,
    fullname                 varchar(255) null,
    lastname                 varchar(16)  null,
    password                 varchar(255) null,
    user_city                varchar(32)  null,
    user_country             varchar(32)  null,
    user_description         varchar(500) null,
    user_facebook            varchar(255) null,
    user_image               varchar(255) null,
    user_institution         varchar(32)  null,
    user_institution_website varchar(255) null,
    user_linked_in           varchar(255) null,
    user_position            varchar(32)  null,
    user_rating              double       null,
    user_telegram            varchar(255) null,
    user_twitter             varchar(255) null,
    uservk                   varchar(255) null,
    username                 varchar(16)  null
);

create table chat_message
(
    chat_message_id   bigint auto_increment
        primary key,
    chat_message_text varchar(500) null,
    user_id           bigint       null,
    constraint FKf7tbywofv1iojpxc1kw8c3bx7
        foreign key (user_id) references user (user_id)
);

create table chat_message_files
(
    fk_chat_message_id bigint not null,
    fk_file_id         bigint not null,
    constraint UK_rtbyvlhhqh82r8mkjfxnsnjuw
        unique (fk_file_id),
    constraint FKfx1c5ywvvh1eorqi8ris32onf
        foreign key (fk_file_id) references file (file_id),
    constraint FKgnk2qhq2beoybt8jmhdylledn
        foreign key (fk_chat_message_id) references chat_message (chat_message_id)
);

create table project
(
    project_id                    bigint auto_increment
        primary key,
    project_description           varchar(200) null,
    project_end_time              datetime     null,
    project_finished              bit          null,
    project_goals                 varchar(500) null,
    project_image                 varchar(255) null,
    project_name                  varchar(20)  null,
    project_rating                double       null,
    project_start_time            datetime     null,
    project_started               bit          null,
    project_status                varchar(255) null,
    project_tasks                 varchar(500) null,
    project_theoretical_lead_time datetime     null,
    project_lead_user_id          bigint       null,
    project_created_time          datetime     null,
    constraint FKmb09vpg0xxac2ufw09wwki1cs
        foreign key (project_lead_user_id) references user (user_id)
);

create table project_chat_messages
(
    fk_project_id      bigint not null,
    fk_chat_message_id bigint not null,
    constraint UK_pglk7mrv04erutw7c1y08u5wo
        unique (fk_chat_message_id),
    constraint FK64iymb7yrlttnirpyklbvht1o
        foreign key (fk_project_id) references project (project_id),
    constraint FKosddsekue0mpu9tytx9rjo70i
        foreign key (fk_chat_message_id) references chat_message (chat_message_id)
);

create table project_files
(
    fk_project_id bigint not null,
    fk_file_id    bigint not null,
    constraint UK_jcgx6fafro8wsslb29kp60rt9
        unique (fk_file_id),
    constraint FKbw5dpk7f1q6jtu5gvw5mhaf26
        foreign key (fk_file_id) references file (file_id),
    constraint FKpi7ihmtx6rbxm9c5ygkewjyg7
        foreign key (fk_project_id) references project (project_id)
);

create table stage
(
    stage_id                    bigint auto_increment
        primary key,
    stage_description           varchar(500) null,
    stage_end_time              datetime     null,
    stage_image                 varchar(255) null,
    stage_name                  varchar(20)  null,
    stage_rating                double       null,
    stage_start_time            datetime     null,
    stage_status                varchar(255) null,
    stage_theoretical_lead_time datetime     null,
    stage_project_project_id    bigint       null,
    constraint FK33u3dmjg3dnj12i871nwon4re
        foreign key (stage_project_project_id) references project (project_id)
);

create table stage_files
(
    fk_stage_id bigint not null,
    fk_file_id  bigint not null,
    constraint UK_qtwdiumgrg5hary3b07qlrl3q
        unique (fk_file_id),
    constraint FKp3p4khmsllafu2llen55y9dme
        foreign key (fk_stage_id) references stage (stage_id),
    constraint FKqup64sjgvhbt4kqwu40vu497t
        foreign key (fk_file_id) references file (file_id)
);

create table team
(
    team_id                 bigint auto_increment
        primary key,
    team_name               varchar(20) null,
    team_rating             double      null,
    team_captain_user_id    bigint      null,
    team_project_project_id bigint      null,
    constraint FKehkw85a7hc2dsop0xk9ln6rpe
        foreign key (team_project_project_id) references project (project_id),
    constraint FKffxl90x0r85xgb2a5v41y12wn
        foreign key (team_captain_user_id) references user (user_id)
);

create table answer
(
    answer_id              bigint auto_increment
        primary key,
    answer_assessment      varchar(2000) null,
    answer_assessment_time datetime      null,
    answer_rating          double        null,
    answer_response_time   datetime      null,
    answer_status          varchar(255)  null,
    answer_text            varchar(2000) null,
    answer_stage_stage_id  bigint        null,
    answer_team_team_id    bigint        null,
    answer_user_user_id    bigint        null,
    constraint FK8135o6236xh65u8rnib71y4rm
        foreign key (answer_user_user_id) references user (user_id),
    constraint FK847ckb4t5m5tlqoq92ypc4j6n
        foreign key (answer_team_team_id) references team (team_id),
    constraint FKkfpt7qs0hrk0ecsds1ddod2sy
        foreign key (answer_stage_stage_id) references stage (stage_id)
);

create table answer_files
(
    fk_answer_id bigint not null,
    fk_file_id   bigint not null,
    constraint UK_6trsd3xn2f1r79fo9rgprfiai
        unique (fk_file_id),
    constraint FKbe5eg2ncsk6n2gd62oenpm6c0
        foreign key (fk_file_id) references file (file_id),
    constraint FKt0wi01kp1afuyf9dcpmit4qqy
        foreign key (fk_answer_id) references answer (answer_id)
);

create table team_chat_messages
(
    fk_team_id         bigint not null,
    fk_chat_message_id bigint not null,
    constraint UK_7ibh7wvvnifh8wc07factmhmt
        unique (fk_chat_message_id),
    constraint FKojdmydifey0u1br7q7x73xek8
        foreign key (fk_team_id) references team (team_id),
    constraint FKpkg94tnex1cqf9qwn3dlt8euc
        foreign key (fk_chat_message_id) references chat_message (chat_message_id)
);

create table team_users
(
    fk_team_id bigint not null,
    fk_user_id bigint not null,
    constraint FK323k0pol12c18tdhyun26ihwr
        foreign key (fk_user_id) references user (user_id),
    constraint FK32fbw4d7eonlhhhfr7rfu94oo
        foreign key (fk_team_id) references team (team_id)
);

create table user_roles
(
    user_id bigint       not null,
    roles   varchar(255) null,
    constraint FK55itppkw3i07do3h7qoclqd4k
        foreign key (user_id) references user (user_id)
);

create table user_subscriptions
(
    subscriber_id bigint not null,
    channel_id    bigint not null,
    constraint FKl9bhyxre3khiisorjq37vbr3f
        foreign key (subscriber_id) references user (user_id),
    constraint FKs9oa7i0xgbrqmkvgnv0r19m9v
        foreign key (channel_id) references user (user_id)
);

