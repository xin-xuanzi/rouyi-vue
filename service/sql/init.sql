create table ACT_GE_PROPERTY
(
    NAME_  varchar(64)  not null
        primary key,
    VALUE_ varchar(300) null,
    REV_   int          null
)
    collate = utf8mb3_bin;

create table ACT_GE_SCHEMA_LOG
(
    ID_        varchar(64)  not null
        primary key,
    TIMESTAMP_ datetime(3)  null,
    VERSION_   varchar(255) null
)
    collate = utf8mb3_bin;

create table ACT_HI_ACTINST
(
    ID_                 varchar(64)  not null
        primary key,
    PARENT_ACT_INST_ID_ varchar(64)  null,
    PROC_DEF_KEY_       varchar(255) null,
    PROC_DEF_ID_        varchar(64)  not null,
    ROOT_PROC_INST_ID_  varchar(64)  null,
    PROC_INST_ID_       varchar(64)  not null,
    EXECUTION_ID_       varchar(64)  not null,
    ACT_ID_             varchar(255) not null,
    TASK_ID_            varchar(64)  null,
    CALL_PROC_INST_ID_  varchar(64)  null,
    CALL_CASE_INST_ID_  varchar(64)  null,
    ACT_NAME_           varchar(255) null,
    ACT_TYPE_           varchar(255) not null,
    ASSIGNEE_           varchar(255) null,
    START_TIME_         datetime(3)  not null,
    END_TIME_           datetime(3)  null,
    DURATION_           bigint       null,
    ACT_INST_STATE_     int          null,
    SEQUENCE_COUNTER_   bigint       null,
    TENANT_ID_          varchar(64)  null,
    REMOVAL_TIME_       datetime(3)  null
)
    collate = utf8mb3_bin;

create index ACT_IDX_HI_ACTINST_ROOT_PI
    on ACT_HI_ACTINST (ROOT_PROC_INST_ID_);

create index ACT_IDX_HI_ACT_INST_COMP
    on ACT_HI_ACTINST (EXECUTION_ID_, ACT_ID_, END_TIME_, ID_);

create index ACT_IDX_HI_ACT_INST_END
    on ACT_HI_ACTINST (END_TIME_);

create index ACT_IDX_HI_ACT_INST_PROCINST
    on ACT_HI_ACTINST (PROC_INST_ID_, ACT_ID_);

create index ACT_IDX_HI_ACT_INST_PROC_DEF_KEY
    on ACT_HI_ACTINST (PROC_DEF_KEY_);

create index ACT_IDX_HI_ACT_INST_RM_TIME
    on ACT_HI_ACTINST (REMOVAL_TIME_);

create index ACT_IDX_HI_ACT_INST_START_END
    on ACT_HI_ACTINST (START_TIME_, END_TIME_);

create index ACT_IDX_HI_ACT_INST_STATS
    on ACT_HI_ACTINST (PROC_DEF_ID_, PROC_INST_ID_, ACT_ID_, END_TIME_, ACT_INST_STATE_);

create index ACT_IDX_HI_ACT_INST_TENANT_ID
    on ACT_HI_ACTINST (TENANT_ID_);

create index ACT_IDX_HI_AI_PDEFID_END_TIME
    on ACT_HI_ACTINST (PROC_DEF_ID_, END_TIME_);

create table ACT_HI_ATTACHMENT
(
    ID_                varchar(64)   not null
        primary key,
    REV_               int           null,
    USER_ID_           varchar(255)  null,
    NAME_              varchar(255)  null,
    DESCRIPTION_       varchar(4000) null,
    TYPE_              varchar(255)  null,
    TASK_ID_           varchar(64)   null,
    ROOT_PROC_INST_ID_ varchar(64)   null,
    PROC_INST_ID_      varchar(64)   null,
    URL_               varchar(4000) null,
    CONTENT_ID_        varchar(64)   null,
    TENANT_ID_         varchar(64)   null,
    CREATE_TIME_       datetime(3)   null,
    REMOVAL_TIME_      datetime(3)   null
)
    collate = utf8mb3_bin;

create index ACT_IDX_HI_ATTACHMENT_CONTENT
    on ACT_HI_ATTACHMENT (CONTENT_ID_);

create index ACT_IDX_HI_ATTACHMENT_PROCINST
    on ACT_HI_ATTACHMENT (PROC_INST_ID_);

create index ACT_IDX_HI_ATTACHMENT_RM_TIME
    on ACT_HI_ATTACHMENT (REMOVAL_TIME_);

create index ACT_IDX_HI_ATTACHMENT_ROOT_PI
    on ACT_HI_ATTACHMENT (ROOT_PROC_INST_ID_);

create index ACT_IDX_HI_ATTACHMENT_TASK
    on ACT_HI_ATTACHMENT (TASK_ID_);

create table ACT_HI_BATCH
(
    ID_                  varchar(64)  not null
        primary key,
    TYPE_                varchar(255) null,
    TOTAL_JOBS_          int          null,
    JOBS_PER_SEED_       int          null,
    INVOCATIONS_PER_JOB_ int          null,
    SEED_JOB_DEF_ID_     varchar(64)  null,
    MONITOR_JOB_DEF_ID_  varchar(64)  null,
    BATCH_JOB_DEF_ID_    varchar(64)  null,
    TENANT_ID_           varchar(64)  null,
    CREATE_USER_ID_      varchar(255) null,
    START_TIME_          datetime(3)  not null,
    END_TIME_            datetime(3)  null,
    REMOVAL_TIME_        datetime(3)  null,
    EXEC_START_TIME_     datetime(3)  null
)
    collate = utf8mb3_bin;

create index ACT_HI_BAT_RM_TIME
    on ACT_HI_BATCH (REMOVAL_TIME_);

create table ACT_HI_CASEACTINST
(
    ID_                 varchar(64)  not null
        primary key,
    PARENT_ACT_INST_ID_ varchar(64)  null,
    CASE_DEF_ID_        varchar(64)  not null,
    CASE_INST_ID_       varchar(64)  not null,
    CASE_ACT_ID_        varchar(255) not null,
    TASK_ID_            varchar(64)  null,
    CALL_PROC_INST_ID_  varchar(64)  null,
    CALL_CASE_INST_ID_  varchar(64)  null,
    CASE_ACT_NAME_      varchar(255) null,
    CASE_ACT_TYPE_      varchar(255) null,
    CREATE_TIME_        datetime(3)  not null,
    END_TIME_           datetime(3)  null,
    DURATION_           bigint       null,
    STATE_              int          null,
    REQUIRED_           tinyint(1)   null,
    TENANT_ID_          varchar(64)  null
)
    collate = utf8mb3_bin;

create index ACT_IDX_HI_CAS_A_I_CASEINST
    on ACT_HI_CASEACTINST (CASE_INST_ID_, CASE_ACT_ID_);

create index ACT_IDX_HI_CAS_A_I_COMP
    on ACT_HI_CASEACTINST (CASE_ACT_ID_, END_TIME_, ID_);

create index ACT_IDX_HI_CAS_A_I_CREATE
    on ACT_HI_CASEACTINST (CREATE_TIME_);

create index ACT_IDX_HI_CAS_A_I_END
    on ACT_HI_CASEACTINST (END_TIME_);

create index ACT_IDX_HI_CAS_A_I_TENANT_ID
    on ACT_HI_CASEACTINST (TENANT_ID_);

create table ACT_HI_CASEINST
(
    ID_                        varchar(64)  not null
        primary key,
    CASE_INST_ID_              varchar(64)  not null,
    BUSINESS_KEY_              varchar(255) null,
    CASE_DEF_ID_               varchar(64)  not null,
    CREATE_TIME_               datetime(3)  not null,
    CLOSE_TIME_                datetime(3)  null,
    DURATION_                  bigint       null,
    STATE_                     int          null,
    CREATE_USER_ID_            varchar(255) null,
    SUPER_CASE_INSTANCE_ID_    varchar(64)  null,
    SUPER_PROCESS_INSTANCE_ID_ varchar(64)  null,
    TENANT_ID_                 varchar(64)  null,
    constraint CASE_INST_ID_
        unique (CASE_INST_ID_)
)
    collate = utf8mb3_bin;

create index ACT_IDX_HI_CAS_I_BUSKEY
    on ACT_HI_CASEINST (BUSINESS_KEY_);

create index ACT_IDX_HI_CAS_I_CLOSE
    on ACT_HI_CASEINST (CLOSE_TIME_);

create index ACT_IDX_HI_CAS_I_TENANT_ID
    on ACT_HI_CASEINST (TENANT_ID_);

create table ACT_HI_COMMENT
(
    ID_                varchar(64)   not null
        primary key,
    TYPE_              varchar(255)  null,
    TIME_              datetime(3)   not null,
    USER_ID_           varchar(255)  null,
    TASK_ID_           varchar(64)   null,
    ROOT_PROC_INST_ID_ varchar(64)   null,
    PROC_INST_ID_      varchar(64)   null,
    ACTION_            varchar(255)  null,
    APPROVAL_RESULT    varchar(255)  null,
    MESSAGE_           varchar(4000) null,
    FULL_MSG_          longblob      null,
    TENANT_ID_         varchar(64)   null,
    REMOVAL_TIME_      datetime(3)   null
)
    collate = utf8mb3_bin;

create index ACT_IDX_HI_COMMENT_PROCINST
    on ACT_HI_COMMENT (PROC_INST_ID_);

create index ACT_IDX_HI_COMMENT_RM_TIME
    on ACT_HI_COMMENT (REMOVAL_TIME_);

create index ACT_IDX_HI_COMMENT_ROOT_PI
    on ACT_HI_COMMENT (ROOT_PROC_INST_ID_);

create index ACT_IDX_HI_COMMENT_TASK
    on ACT_HI_COMMENT (TASK_ID_);

create table ACT_HI_DECINST
(
    ID_                varchar(64)  not null
        primary key,
    DEC_DEF_ID_        varchar(64)  not null,
    DEC_DEF_KEY_       varchar(255) not null,
    DEC_DEF_NAME_      varchar(255) null,
    PROC_DEF_KEY_      varchar(255) null,
    PROC_DEF_ID_       varchar(64)  null,
    PROC_INST_ID_      varchar(64)  null,
    CASE_DEF_KEY_      varchar(255) null,
    CASE_DEF_ID_       varchar(64)  null,
    CASE_INST_ID_      varchar(64)  null,
    ACT_INST_ID_       varchar(64)  null,
    ACT_ID_            varchar(255) null,
    EVAL_TIME_         datetime(3)  not null,
    REMOVAL_TIME_      datetime(3)  null,
    COLLECT_VALUE_     double       null,
    USER_ID_           varchar(255) null,
    ROOT_DEC_INST_ID_  varchar(64)  null,
    ROOT_PROC_INST_ID_ varchar(64)  null,
    DEC_REQ_ID_        varchar(64)  null,
    DEC_REQ_KEY_       varchar(255) null,
    TENANT_ID_         varchar(64)  null
)
    collate = utf8mb3_bin;

create index ACT_IDX_HI_DEC_INST_ACT
    on ACT_HI_DECINST (ACT_ID_);

create index ACT_IDX_HI_DEC_INST_ACT_INST
    on ACT_HI_DECINST (ACT_INST_ID_);

create index ACT_IDX_HI_DEC_INST_CI
    on ACT_HI_DECINST (CASE_INST_ID_);

create index ACT_IDX_HI_DEC_INST_ID
    on ACT_HI_DECINST (DEC_DEF_ID_);

create index ACT_IDX_HI_DEC_INST_KEY
    on ACT_HI_DECINST (DEC_DEF_KEY_);

create index ACT_IDX_HI_DEC_INST_PI
    on ACT_HI_DECINST (PROC_INST_ID_);

create index ACT_IDX_HI_DEC_INST_REQ_ID
    on ACT_HI_DECINST (DEC_REQ_ID_);

create index ACT_IDX_HI_DEC_INST_REQ_KEY
    on ACT_HI_DECINST (DEC_REQ_KEY_);

create index ACT_IDX_HI_DEC_INST_RM_TIME
    on ACT_HI_DECINST (REMOVAL_TIME_);

create index ACT_IDX_HI_DEC_INST_ROOT_ID
    on ACT_HI_DECINST (ROOT_DEC_INST_ID_);

create index ACT_IDX_HI_DEC_INST_ROOT_PI
    on ACT_HI_DECINST (ROOT_PROC_INST_ID_);

create index ACT_IDX_HI_DEC_INST_TENANT_ID
    on ACT_HI_DECINST (TENANT_ID_);

create index ACT_IDX_HI_DEC_INST_TIME
    on ACT_HI_DECINST (EVAL_TIME_);

create table ACT_HI_DEC_IN
(
    ID_                varchar(64)   not null
        primary key,
    DEC_INST_ID_       varchar(64)   not null,
    CLAUSE_ID_         varchar(64)   null,
    CLAUSE_NAME_       varchar(255)  null,
    VAR_TYPE_          varchar(100)  null,
    BYTEARRAY_ID_      varchar(64)   null,
    DOUBLE_            double        null,
    LONG_              bigint        null,
    TEXT_              varchar(4000) null,
    TEXT2_             varchar(4000) null,
    TENANT_ID_         varchar(64)   null,
    CREATE_TIME_       datetime(3)   null,
    ROOT_PROC_INST_ID_ varchar(64)   null,
    REMOVAL_TIME_      datetime(3)   null
)
    collate = utf8mb3_bin;

create index ACT_IDX_HI_DEC_IN_CLAUSE
    on ACT_HI_DEC_IN (DEC_INST_ID_, CLAUSE_ID_);

create index ACT_IDX_HI_DEC_IN_INST
    on ACT_HI_DEC_IN (DEC_INST_ID_);

create index ACT_IDX_HI_DEC_IN_RM_TIME
    on ACT_HI_DEC_IN (REMOVAL_TIME_);

create index ACT_IDX_HI_DEC_IN_ROOT_PI
    on ACT_HI_DEC_IN (ROOT_PROC_INST_ID_);

create table ACT_HI_DEC_OUT
(
    ID_                varchar(64)   not null
        primary key,
    DEC_INST_ID_       varchar(64)   not null,
    CLAUSE_ID_         varchar(64)   null,
    CLAUSE_NAME_       varchar(255)  null,
    RULE_ID_           varchar(64)   null,
    RULE_ORDER_        int           null,
    VAR_NAME_          varchar(255)  null,
    VAR_TYPE_          varchar(100)  null,
    BYTEARRAY_ID_      varchar(64)   null,
    DOUBLE_            double        null,
    LONG_              bigint        null,
    TEXT_              varchar(4000) null,
    TEXT2_             varchar(4000) null,
    TENANT_ID_         varchar(64)   null,
    CREATE_TIME_       datetime(3)   null,
    ROOT_PROC_INST_ID_ varchar(64)   null,
    REMOVAL_TIME_      datetime(3)   null
)
    collate = utf8mb3_bin;

create index ACT_IDX_HI_DEC_OUT_INST
    on ACT_HI_DEC_OUT (DEC_INST_ID_);

create index ACT_IDX_HI_DEC_OUT_RM_TIME
    on ACT_HI_DEC_OUT (REMOVAL_TIME_);

create index ACT_IDX_HI_DEC_OUT_ROOT_PI
    on ACT_HI_DEC_OUT (ROOT_PROC_INST_ID_);

create index ACT_IDX_HI_DEC_OUT_RULE
    on ACT_HI_DEC_OUT (RULE_ORDER_, CLAUSE_ID_);

create table ACT_HI_DETAIL
(
    ID_                varchar(64)   not null
        primary key,
    TYPE_              varchar(255)  not null,
    PROC_DEF_KEY_      varchar(255)  null,
    PROC_DEF_ID_       varchar(64)   null,
    ROOT_PROC_INST_ID_ varchar(64)   null,
    PROC_INST_ID_      varchar(64)   null,
    EXECUTION_ID_      varchar(64)   null,
    CASE_DEF_KEY_      varchar(255)  null,
    CASE_DEF_ID_       varchar(64)   null,
    CASE_INST_ID_      varchar(64)   null,
    CASE_EXECUTION_ID_ varchar(64)   null,
    TASK_ID_           varchar(64)   null,
    ACT_INST_ID_       varchar(64)   null,
    VAR_INST_ID_       varchar(64)   null,
    NAME_              varchar(255)  not null,
    VAR_TYPE_          varchar(255)  null,
    REV_               int           null,
    TIME_              datetime(3)   not null,
    BYTEARRAY_ID_      varchar(64)   null,
    DOUBLE_            double        null,
    LONG_              bigint        null,
    TEXT_              varchar(4000) null,
    TEXT2_             varchar(4000) null,
    SEQUENCE_COUNTER_  bigint        null,
    TENANT_ID_         varchar(64)   null,
    OPERATION_ID_      varchar(64)   null,
    REMOVAL_TIME_      datetime(3)   null,
    INITIAL_           tinyint(1)    null
)
    collate = utf8mb3_bin;

create index ACT_IDX_HI_DETAIL_ACT_INST
    on ACT_HI_DETAIL (ACT_INST_ID_);

create index ACT_IDX_HI_DETAIL_BYTEAR
    on ACT_HI_DETAIL (BYTEARRAY_ID_);

create index ACT_IDX_HI_DETAIL_CASE_EXEC
    on ACT_HI_DETAIL (CASE_EXECUTION_ID_);

create index ACT_IDX_HI_DETAIL_CASE_INST
    on ACT_HI_DETAIL (CASE_INST_ID_);

create index ACT_IDX_HI_DETAIL_NAME
    on ACT_HI_DETAIL (NAME_);

create index ACT_IDX_HI_DETAIL_PROC_DEF_KEY
    on ACT_HI_DETAIL (PROC_DEF_KEY_);

create index ACT_IDX_HI_DETAIL_PROC_INST
    on ACT_HI_DETAIL (PROC_INST_ID_);

create index ACT_IDX_HI_DETAIL_RM_TIME
    on ACT_HI_DETAIL (REMOVAL_TIME_);

create index ACT_IDX_HI_DETAIL_ROOT_PI
    on ACT_HI_DETAIL (ROOT_PROC_INST_ID_);

create index ACT_IDX_HI_DETAIL_TASK_BYTEAR
    on ACT_HI_DETAIL (BYTEARRAY_ID_, TASK_ID_);

create index ACT_IDX_HI_DETAIL_TASK_ID
    on ACT_HI_DETAIL (TASK_ID_);

create index ACT_IDX_HI_DETAIL_TENANT_ID
    on ACT_HI_DETAIL (TENANT_ID_);

create index ACT_IDX_HI_DETAIL_TIME
    on ACT_HI_DETAIL (TIME_);

create index ACT_IDX_HI_DETAIL_VAR_INST_ID
    on ACT_HI_DETAIL (VAR_INST_ID_);

create table ACT_HI_EXT_TASK_LOG
(
    ID_                varchar(64)                               not null
        primary key,
    TIMESTAMP_         timestamp(3) default current_timestamp(3) not null on update current_timestamp(3),
    EXT_TASK_ID_       varchar(64)                               not null,
    RETRIES_           int                                       null,
    TOPIC_NAME_        varchar(255)                              null,
    WORKER_ID_         varchar(255)                              null,
    PRIORITY_          bigint       default 0                    not null,
    ERROR_MSG_         varchar(4000)                             null,
    ERROR_DETAILS_ID_  varchar(64)                               null,
    ACT_ID_            varchar(255)                              null,
    ACT_INST_ID_       varchar(64)                               null,
    EXECUTION_ID_      varchar(64)                               null,
    ROOT_PROC_INST_ID_ varchar(64)                               null,
    PROC_INST_ID_      varchar(64)                               null,
    PROC_DEF_ID_       varchar(64)                               null,
    PROC_DEF_KEY_      varchar(255)                              null,
    TENANT_ID_         varchar(64)                               null,
    STATE_             int                                       null,
    REMOVAL_TIME_      datetime(3)                               null
)
    collate = utf8mb3_bin;

create index ACT_HI_EXT_TASK_LOG_PROCDEF
    on ACT_HI_EXT_TASK_LOG (PROC_DEF_ID_);

create index ACT_HI_EXT_TASK_LOG_PROCINST
    on ACT_HI_EXT_TASK_LOG (PROC_INST_ID_);

create index ACT_HI_EXT_TASK_LOG_PROC_DEF_KEY
    on ACT_HI_EXT_TASK_LOG (PROC_DEF_KEY_);

create index ACT_HI_EXT_TASK_LOG_RM_TIME
    on ACT_HI_EXT_TASK_LOG (REMOVAL_TIME_);

create index ACT_HI_EXT_TASK_LOG_ROOT_PI
    on ACT_HI_EXT_TASK_LOG (ROOT_PROC_INST_ID_);

create index ACT_HI_EXT_TASK_LOG_TENANT_ID
    on ACT_HI_EXT_TASK_LOG (TENANT_ID_);

create index ACT_IDX_HI_EXTTASKLOG_ERRORDET
    on ACT_HI_EXT_TASK_LOG (ERROR_DETAILS_ID_);

create table ACT_HI_IDENTITYLINK
(
    ID_                varchar(64)                               not null
        primary key,
    TIMESTAMP_         timestamp(3) default current_timestamp(3) not null on update current_timestamp(3),
    TYPE_              varchar(255)                              null,
    USER_ID_           varchar(255)                              null,
    GROUP_ID_          varchar(255)                              null,
    TASK_ID_           varchar(64)                               null,
    ROOT_PROC_INST_ID_ varchar(64)                               null,
    PROC_DEF_ID_       varchar(64)                               null,
    OPERATION_TYPE_    varchar(64)                               null,
    ASSIGNER_ID_       varchar(64)                               null,
    PROC_DEF_KEY_      varchar(255)                              null,
    TENANT_ID_         varchar(64)                               null,
    REMOVAL_TIME_      datetime(3)                               null
)
    collate = utf8mb3_bin;

create index ACT_IDX_HI_IDENT_LINK_RM_TIME
    on ACT_HI_IDENTITYLINK (REMOVAL_TIME_);

create index ACT_IDX_HI_IDENT_LINK_TASK
    on ACT_HI_IDENTITYLINK (TASK_ID_);

create index ACT_IDX_HI_IDENT_LNK_GROUP
    on ACT_HI_IDENTITYLINK (GROUP_ID_);

create index ACT_IDX_HI_IDENT_LNK_PROC_DEF_KEY
    on ACT_HI_IDENTITYLINK (PROC_DEF_KEY_);

create index ACT_IDX_HI_IDENT_LNK_ROOT_PI
    on ACT_HI_IDENTITYLINK (ROOT_PROC_INST_ID_);

create index ACT_IDX_HI_IDENT_LNK_TENANT_ID
    on ACT_HI_IDENTITYLINK (TENANT_ID_);

create index ACT_IDX_HI_IDENT_LNK_TIMESTAMP
    on ACT_HI_IDENTITYLINK (TIMESTAMP_);

create index ACT_IDX_HI_IDENT_LNK_USER
    on ACT_HI_IDENTITYLINK (USER_ID_);

create table ACT_HI_INCIDENT
(
    ID_                     varchar(64)                               not null
        primary key,
    PROC_DEF_KEY_           varchar(255)                              null,
    PROC_DEF_ID_            varchar(64)                               null,
    ROOT_PROC_INST_ID_      varchar(64)                               null,
    PROC_INST_ID_           varchar(64)                               null,
    EXECUTION_ID_           varchar(64)                               null,
    CREATE_TIME_            timestamp(3) default current_timestamp(3) not null on update current_timestamp(3),
    END_TIME_               timestamp(3)                              null,
    INCIDENT_MSG_           varchar(4000)                             null,
    INCIDENT_TYPE_          varchar(255)                              not null,
    ACTIVITY_ID_            varchar(255)                              null,
    FAILED_ACTIVITY_ID_     varchar(255)                              null,
    CAUSE_INCIDENT_ID_      varchar(64)                               null,
    ROOT_CAUSE_INCIDENT_ID_ varchar(64)                               null,
    CONFIGURATION_          varchar(255)                              null,
    HISTORY_CONFIGURATION_  varchar(255)                              null,
    INCIDENT_STATE_         int                                       null,
    TENANT_ID_              varchar(64)                               null,
    JOB_DEF_ID_             varchar(64)                               null,
    ANNOTATION_             varchar(4000)                             null,
    REMOVAL_TIME_           datetime(3)                               null
)
    collate = utf8mb3_bin;

create index ACT_IDX_HI_INCIDENT_CREATE_TIME
    on ACT_HI_INCIDENT (CREATE_TIME_);

create index ACT_IDX_HI_INCIDENT_END_TIME
    on ACT_HI_INCIDENT (END_TIME_);

create index ACT_IDX_HI_INCIDENT_PROCINST
    on ACT_HI_INCIDENT (PROC_INST_ID_);

create index ACT_IDX_HI_INCIDENT_PROC_DEF_KEY
    on ACT_HI_INCIDENT (PROC_DEF_KEY_);

create index ACT_IDX_HI_INCIDENT_RM_TIME
    on ACT_HI_INCIDENT (REMOVAL_TIME_);

create index ACT_IDX_HI_INCIDENT_ROOT_PI
    on ACT_HI_INCIDENT (ROOT_PROC_INST_ID_);

create index ACT_IDX_HI_INCIDENT_TENANT_ID
    on ACT_HI_INCIDENT (TENANT_ID_);

create table ACT_HI_JOB_LOG
(
    ID_                     varchar(64)      not null
        primary key,
    TIMESTAMP_              datetime(3)      not null,
    JOB_ID_                 varchar(64)      not null,
    JOB_DUEDATE_            datetime(3)      null,
    JOB_RETRIES_            int              null,
    JOB_PRIORITY_           bigint default 0 not null,
    JOB_EXCEPTION_MSG_      varchar(4000)    null,
    JOB_EXCEPTION_STACK_ID_ varchar(64)      null,
    JOB_STATE_              int              null,
    JOB_DEF_ID_             varchar(64)      null,
    JOB_DEF_TYPE_           varchar(255)     null,
    JOB_DEF_CONFIGURATION_  varchar(255)     null,
    ACT_ID_                 varchar(255)     null,
    FAILED_ACT_ID_          varchar(255)     null,
    ROOT_PROC_INST_ID_      varchar(64)      null,
    EXECUTION_ID_           varchar(64)      null,
    PROCESS_INSTANCE_ID_    varchar(64)      null,
    PROCESS_DEF_ID_         varchar(64)      null,
    PROCESS_DEF_KEY_        varchar(255)     null,
    DEPLOYMENT_ID_          varchar(64)      null,
    SEQUENCE_COUNTER_       bigint           null,
    TENANT_ID_              varchar(64)      null,
    HOSTNAME_               varchar(255)     null,
    REMOVAL_TIME_           datetime(3)      null
)
    collate = utf8mb3_bin;

create index ACT_IDX_HI_JOB_LOG_EX_STACK
    on ACT_HI_JOB_LOG (JOB_EXCEPTION_STACK_ID_);

create index ACT_IDX_HI_JOB_LOG_JOB_CONF
    on ACT_HI_JOB_LOG (JOB_DEF_CONFIGURATION_);

create index ACT_IDX_HI_JOB_LOG_JOB_DEF_ID
    on ACT_HI_JOB_LOG (JOB_DEF_ID_);

create index ACT_IDX_HI_JOB_LOG_PROCDEF
    on ACT_HI_JOB_LOG (PROCESS_DEF_ID_);

create index ACT_IDX_HI_JOB_LOG_PROCINST
    on ACT_HI_JOB_LOG (PROCESS_INSTANCE_ID_);

create index ACT_IDX_HI_JOB_LOG_PROC_DEF_KEY
    on ACT_HI_JOB_LOG (PROCESS_DEF_KEY_);

create index ACT_IDX_HI_JOB_LOG_RM_TIME
    on ACT_HI_JOB_LOG (REMOVAL_TIME_);

create index ACT_IDX_HI_JOB_LOG_ROOT_PI
    on ACT_HI_JOB_LOG (ROOT_PROC_INST_ID_);

create index ACT_IDX_HI_JOB_LOG_TENANT_ID
    on ACT_HI_JOB_LOG (TENANT_ID_);

create table ACT_HI_OP_LOG
(
    ID_                varchar(64)                               not null
        primary key,
    DEPLOYMENT_ID_     varchar(64)                               null,
    PROC_DEF_ID_       varchar(64)                               null,
    PROC_DEF_KEY_      varchar(255)                              null,
    ROOT_PROC_INST_ID_ varchar(64)                               null,
    PROC_INST_ID_      varchar(64)                               null,
    EXECUTION_ID_      varchar(64)                               null,
    CASE_DEF_ID_       varchar(64)                               null,
    CASE_INST_ID_      varchar(64)                               null,
    CASE_EXECUTION_ID_ varchar(64)                               null,
    TASK_ID_           varchar(64)                               null,
    JOB_ID_            varchar(64)                               null,
    JOB_DEF_ID_        varchar(64)                               null,
    BATCH_ID_          varchar(64)                               null,
    USER_ID_           varchar(255)                              null,
    TIMESTAMP_         timestamp(3) default current_timestamp(3) not null on update current_timestamp(3),
    OPERATION_TYPE_    varchar(64)                               null,
    OPERATION_ID_      varchar(64)                               null,
    ENTITY_TYPE_       varchar(30)                               null,
    PROPERTY_          varchar(64)                               null,
    ORG_VALUE_         varchar(4000)                             null,
    NEW_VALUE_         varchar(4000)                             null,
    TENANT_ID_         varchar(64)                               null,
    REMOVAL_TIME_      datetime(3)                               null,
    CATEGORY_          varchar(64)                               null,
    EXTERNAL_TASK_ID_  varchar(64)                               null,
    ANNOTATION_        varchar(4000)                             null
)
    collate = utf8mb3_bin;

create index ACT_IDX_HI_OP_LOG_ENTITY_TYPE
    on ACT_HI_OP_LOG (ENTITY_TYPE_);

create index ACT_IDX_HI_OP_LOG_OP_TYPE
    on ACT_HI_OP_LOG (OPERATION_TYPE_);

create index ACT_IDX_HI_OP_LOG_PROCDEF
    on ACT_HI_OP_LOG (PROC_DEF_ID_);

create index ACT_IDX_HI_OP_LOG_PROCINST
    on ACT_HI_OP_LOG (PROC_INST_ID_);

create index ACT_IDX_HI_OP_LOG_RM_TIME
    on ACT_HI_OP_LOG (REMOVAL_TIME_);

create index ACT_IDX_HI_OP_LOG_ROOT_PI
    on ACT_HI_OP_LOG (ROOT_PROC_INST_ID_);

create index ACT_IDX_HI_OP_LOG_TASK
    on ACT_HI_OP_LOG (TASK_ID_);

create index ACT_IDX_HI_OP_LOG_TIMESTAMP
    on ACT_HI_OP_LOG (TIMESTAMP_);

create index ACT_IDX_HI_OP_LOG_USER_ID
    on ACT_HI_OP_LOG (USER_ID_);

create table ACT_HI_PROCINST
(
    ID_                        varchar(64)   not null
        primary key,
    PROC_INST_ID_              varchar(64)   not null,
    BUSINESS_KEY_              varchar(255)  null,
    PROC_DEF_KEY_              varchar(255)  null,
    PROC_DEF_ID_               varchar(64)   not null,
    START_TIME_                datetime(3)   not null,
    END_TIME_                  datetime(3)   null,
    REMOVAL_TIME_              datetime(3)   null,
    DURATION_                  bigint        null,
    START_USER_ID_             varchar(255)  null,
    START_ACT_ID_              varchar(255)  null,
    END_ACT_ID_                varchar(255)  null,
    SUPER_PROCESS_INSTANCE_ID_ varchar(64)   null,
    ROOT_PROC_INST_ID_         varchar(64)   null,
    SUPER_CASE_INSTANCE_ID_    varchar(64)   null,
    CASE_INST_ID_              varchar(64)   null,
    DELETE_REASON_             varchar(4000) null,
    TENANT_ID_                 varchar(64)   null,
    STATE_                     varchar(255)  null,
    constraint PROC_INST_ID_
        unique (PROC_INST_ID_)
)
    collate = utf8mb3_bin;

create index ACT_IDX_HI_PI_PDEFID_END_TIME
    on ACT_HI_PROCINST (PROC_DEF_ID_, END_TIME_);

create index ACT_IDX_HI_PRO_INST_END
    on ACT_HI_PROCINST (END_TIME_);

create index ACT_IDX_HI_PRO_INST_PROC_DEF_KEY
    on ACT_HI_PROCINST (PROC_DEF_KEY_);

create index ACT_IDX_HI_PRO_INST_PROC_TIME
    on ACT_HI_PROCINST (START_TIME_, END_TIME_);

create index ACT_IDX_HI_PRO_INST_RM_TIME
    on ACT_HI_PROCINST (REMOVAL_TIME_);

create index ACT_IDX_HI_PRO_INST_ROOT_PI
    on ACT_HI_PROCINST (ROOT_PROC_INST_ID_);

create index ACT_IDX_HI_PRO_INST_TENANT_ID
    on ACT_HI_PROCINST (TENANT_ID_);

create index ACT_IDX_HI_PRO_I_BUSKEY
    on ACT_HI_PROCINST (BUSINESS_KEY_);

create table ACT_HI_TASKINST
(
    ID_                varchar(64)   not null
        primary key,
    TASK_DEF_KEY_      varchar(255)  null,
    PROC_DEF_KEY_      varchar(255)  null,
    PROC_DEF_ID_       varchar(64)   null,
    ROOT_PROC_INST_ID_ varchar(64)   null,
    PROC_INST_ID_      varchar(64)   null,
    EXECUTION_ID_      varchar(64)   null,
    CASE_DEF_KEY_      varchar(255)  null,
    CASE_DEF_ID_       varchar(64)   null,
    CASE_INST_ID_      varchar(64)   null,
    CASE_EXECUTION_ID_ varchar(64)   null,
    ACT_INST_ID_       varchar(64)   null,
    NAME_              varchar(255)  null,
    PARENT_TASK_ID_    varchar(64)   null,
    DESCRIPTION_       varchar(4000) null,
    OWNER_             varchar(255)  null,
    ASSIGNEE_          varchar(255)  null,
    START_TIME_        datetime(3)   not null,
    END_TIME_          datetime(3)   null,
    DURATION_          bigint        null,
    DELETE_REASON_     varchar(4000) null,
    PRIORITY_          int           null,
    DUE_DATE_          datetime(3)   null,
    FOLLOW_UP_DATE_    datetime(3)   null,
    TENANT_ID_         varchar(64)   null,
    REMOVAL_TIME_      datetime(3)   null,
    APPROVAL_RESULT    varchar(64)   null
)
    collate = utf8mb3_bin;

create index ACT_HI_TASKINST_ASSIGNEE__index
    on ACT_HI_TASKINST (ASSIGNEE_);

create index ACT_IDX_HI_TASKINSTID_PROCINST
    on ACT_HI_TASKINST (ID_, PROC_INST_ID_);

create index ACT_IDX_HI_TASKINST_PROCINST
    on ACT_HI_TASKINST (PROC_INST_ID_);

create index ACT_IDX_HI_TASKINST_ROOT_PI
    on ACT_HI_TASKINST (ROOT_PROC_INST_ID_);

create index ACT_IDX_HI_TASK_INST_END
    on ACT_HI_TASKINST (END_TIME_);

create index ACT_IDX_HI_TASK_INST_PROC_DEF_KEY
    on ACT_HI_TASKINST (PROC_DEF_KEY_);

create index ACT_IDX_HI_TASK_INST_RM_TIME
    on ACT_HI_TASKINST (REMOVAL_TIME_);

create index ACT_IDX_HI_TASK_INST_START
    on ACT_HI_TASKINST (START_TIME_);

create index ACT_IDX_HI_TASK_INST_TENANT_ID
    on ACT_HI_TASKINST (TENANT_ID_);

create table ACT_HI_VARINST
(
    ID_                varchar(64)   not null
        primary key,
    PROC_DEF_KEY_      varchar(255)  null,
    PROC_DEF_ID_       varchar(64)   null,
    ROOT_PROC_INST_ID_ varchar(64)   null,
    PROC_INST_ID_      varchar(64)   null,
    EXECUTION_ID_      varchar(64)   null,
    ACT_INST_ID_       varchar(64)   null,
    CASE_DEF_KEY_      varchar(255)  null,
    CASE_DEF_ID_       varchar(64)   null,
    CASE_INST_ID_      varchar(64)   null,
    CASE_EXECUTION_ID_ varchar(64)   null,
    TASK_ID_           varchar(64)   null,
    NAME_              varchar(255)  not null,
    VAR_TYPE_          varchar(100)  null,
    CREATE_TIME_       datetime(3)   null,
    REV_               int           null,
    BYTEARRAY_ID_      varchar(64)   null,
    DOUBLE_            double        null,
    LONG_              bigint        null,
    TEXT_              varchar(4000) null,
    TEXT2_             varchar(4000) null,
    TENANT_ID_         varchar(64)   null,
    STATE_             varchar(20)   null,
    REMOVAL_TIME_      datetime(3)   null
)
    collate = utf8mb3_bin;

create index ACT_IDX_HI_CASEVAR_CASE_INST
    on ACT_HI_VARINST (CASE_INST_ID_);

create index ACT_IDX_HI_PROCVAR_NAME_TYPE
    on ACT_HI_VARINST (NAME_, VAR_TYPE_);

create index ACT_IDX_HI_PROCVAR_PROC_INST
    on ACT_HI_VARINST (PROC_INST_ID_);

create index ACT_IDX_HI_VARINST_ACT_INST_ID
    on ACT_HI_VARINST (ACT_INST_ID_);

create index ACT_IDX_HI_VARINST_BYTEAR
    on ACT_HI_VARINST (BYTEARRAY_ID_);

create index ACT_IDX_HI_VARINST_NAME
    on ACT_HI_VARINST (NAME_);

create index ACT_IDX_HI_VARINST_RM_TIME
    on ACT_HI_VARINST (REMOVAL_TIME_);

create index ACT_IDX_HI_VARINST_ROOT_PI
    on ACT_HI_VARINST (ROOT_PROC_INST_ID_);

create index ACT_IDX_HI_VAR_INST_PROC_DEF_KEY
    on ACT_HI_VARINST (PROC_DEF_KEY_);

create index ACT_IDX_HI_VAR_INST_TENANT_ID
    on ACT_HI_VARINST (TENANT_ID_);

create index ACT_IDX_HI_VAR_PI_NAME_TYPE
    on ACT_HI_VARINST (PROC_INST_ID_, NAME_, VAR_TYPE_);

create table ACT_ID_GROUP
(
    ID_   varchar(64)  not null
        primary key,
    REV_  int          null,
    NAME_ varchar(255) null,
    TYPE_ varchar(255) null
)
    collate = utf8mb3_bin;

create table ACT_ID_INFO
(
    ID_        varchar(64)  not null
        primary key,
    REV_       int          null,
    USER_ID_   varchar(64)  null,
    TYPE_      varchar(64)  null,
    KEY_       varchar(255) null,
    VALUE_     varchar(255) null,
    PASSWORD_  longblob     null,
    PARENT_ID_ varchar(255) null
)
    collate = utf8mb3_bin;

create table ACT_ID_TENANT
(
    ID_   varchar(64)  not null
        primary key,
    REV_  int          null,
    NAME_ varchar(255) null
)
    collate = utf8mb3_bin;

create table ACT_ID_USER
(
    ID_            varchar(64)  not null
        primary key,
    REV_           int          null,
    FIRST_         varchar(255) null,
    LAST_          varchar(255) null,
    EMAIL_         varchar(255) null,
    PWD_           varchar(255) null,
    SALT_          varchar(255) null,
    LOCK_EXP_TIME_ datetime(3)  null,
    ATTEMPTS_      int          null,
    PICTURE_ID_    varchar(64)  null
)
    collate = utf8mb3_bin;

create table ACT_ID_MEMBERSHIP
(
    USER_ID_  varchar(64) not null,
    GROUP_ID_ varchar(64) not null,
    primary key (USER_ID_, GROUP_ID_),
    constraint ACT_FK_MEMB_GROUP
        foreign key (GROUP_ID_) references ACT_ID_GROUP (ID_),
    constraint ACT_FK_MEMB_USER
        foreign key (USER_ID_) references ACT_ID_USER (ID_)
)
    collate = utf8mb3_bin;

create table ACT_ID_TENANT_MEMBER
(
    ID_        varchar(64) not null
        primary key,
    TENANT_ID_ varchar(64) not null,
    USER_ID_   varchar(64) null,
    GROUP_ID_  varchar(64) null,
    constraint ACT_UNIQ_TENANT_MEMB_GROUP
        unique (TENANT_ID_, GROUP_ID_),
    constraint ACT_UNIQ_TENANT_MEMB_USER
        unique (TENANT_ID_, USER_ID_),
    constraint ACT_FK_TENANT_MEMB
        foreign key (TENANT_ID_) references ACT_ID_TENANT (ID_),
    constraint ACT_FK_TENANT_MEMB_GROUP
        foreign key (GROUP_ID_) references ACT_ID_GROUP (ID_),
    constraint ACT_FK_TENANT_MEMB_USER
        foreign key (USER_ID_) references ACT_ID_USER (ID_)
)
    collate = utf8mb3_bin;

create table ACT_RE_CAMFORMDEF
(
    ID_            varchar(64)   not null
        primary key,
    REV_           int           null,
    KEY_           varchar(255)  not null,
    VERSION_       int           not null,
    DEPLOYMENT_ID_ varchar(64)   null,
    RESOURCE_NAME_ varchar(4000) null,
    TENANT_ID_     varchar(64)   null
)
    collate = utf8mb3_bin;

create table ACT_RE_CASE_DEF
(
    ID_                 varchar(64)   not null
        primary key,
    REV_                int           null,
    CATEGORY_           varchar(255)  null,
    NAME_               varchar(255)  null,
    KEY_                varchar(255)  not null,
    VERSION_            int           not null,
    DEPLOYMENT_ID_      varchar(64)   null,
    RESOURCE_NAME_      varchar(4000) null,
    DGRM_RESOURCE_NAME_ varchar(4000) null,
    TENANT_ID_          varchar(64)   null,
    HISTORY_TTL_        int           null
)
    collate = utf8mb3_bin;

create index ACT_IDX_CASE_DEF_TENANT_ID
    on ACT_RE_CASE_DEF (TENANT_ID_);

create table ACT_RE_DECISION_REQ_DEF
(
    ID_                 varchar(64)   not null
        primary key,
    REV_                int           null,
    CATEGORY_           varchar(255)  null,
    NAME_               varchar(255)  null,
    KEY_                varchar(255)  not null,
    VERSION_            int           not null,
    DEPLOYMENT_ID_      varchar(64)   null,
    RESOURCE_NAME_      varchar(4000) null,
    DGRM_RESOURCE_NAME_ varchar(4000) null,
    TENANT_ID_          varchar(64)   null
)
    collate = utf8mb3_bin;

create table ACT_RE_DECISION_DEF
(
    ID_                 varchar(64)   not null
        primary key,
    REV_                int           null,
    CATEGORY_           varchar(255)  null,
    NAME_               varchar(255)  null,
    KEY_                varchar(255)  not null,
    VERSION_            int           not null,
    DEPLOYMENT_ID_      varchar(64)   null,
    RESOURCE_NAME_      varchar(4000) null,
    DGRM_RESOURCE_NAME_ varchar(4000) null,
    DEC_REQ_ID_         varchar(64)   null,
    DEC_REQ_KEY_        varchar(255)  null,
    TENANT_ID_          varchar(64)   null,
    HISTORY_TTL_        int           null,
    VERSION_TAG_        varchar(64)   null,
    constraint ACT_FK_DEC_REQ
        foreign key (DEC_REQ_ID_) references ACT_RE_DECISION_REQ_DEF (ID_)
)
    collate = utf8mb3_bin;

create index ACT_IDX_DEC_DEF_REQ_ID
    on ACT_RE_DECISION_DEF (DEC_REQ_ID_);

create index ACT_IDX_DEC_DEF_TENANT_ID
    on ACT_RE_DECISION_DEF (TENANT_ID_);

create index ACT_IDX_DEC_REQ_DEF_TENANT_ID
    on ACT_RE_DECISION_REQ_DEF (TENANT_ID_);

create table ACT_RE_DEPLOYMENT
(
    ID_          varchar(64)  not null
        primary key,
    NAME_        varchar(255) null,
    DEPLOY_TIME_ datetime(3)  null,
    SOURCE_      varchar(255) null,
    TENANT_ID_   varchar(64)  null
)
    collate = utf8mb3_bin;

create table ACT_GE_BYTEARRAY
(
    ID_                varchar(64)  not null
        primary key,
    REV_               int          null,
    NAME_              varchar(255) null,
    DEPLOYMENT_ID_     varchar(64)  null,
    BYTES_             longblob     null,
    GENERATED_         tinyint      null,
    TENANT_ID_         varchar(64)  null,
    TYPE_              int          null,
    CREATE_TIME_       datetime(3)  null,
    ROOT_PROC_INST_ID_ varchar(64)  null,
    REMOVAL_TIME_      datetime(3)  null,
    constraint ACT_FK_BYTEARR_DEPL
        foreign key (DEPLOYMENT_ID_) references ACT_RE_DEPLOYMENT (ID_)
)
    collate = utf8mb3_bin;

create index ACT_IDX_BYTEARRAY_NAME
    on ACT_GE_BYTEARRAY (NAME_);

create index ACT_IDX_BYTEARRAY_RM_TIME
    on ACT_GE_BYTEARRAY (REMOVAL_TIME_);

create index ACT_IDX_BYTEARRAY_ROOT_PI
    on ACT_GE_BYTEARRAY (ROOT_PROC_INST_ID_);

create index ACT_IDX_DEPLOYMENT_NAME
    on ACT_RE_DEPLOYMENT (NAME_);

create index ACT_IDX_DEPLOYMENT_TENANT_ID
    on ACT_RE_DEPLOYMENT (TENANT_ID_);

create table ACT_RE_PROCDEF
(
    ID_                 varchar(64)          not null
        primary key,
    REV_                int                  null,
    CATEGORY_           varchar(255)         null,
    NAME_               varchar(255)         null,
    KEY_                varchar(255)         not null,
    VERSION_            int                  not null,
    DEPLOYMENT_ID_      varchar(64)          null,
    RESOURCE_NAME_      varchar(4000)        null,
    DGRM_RESOURCE_NAME_ varchar(4000)        null,
    HAS_START_FORM_KEY_ tinyint              null,
    SUSPENSION_STATE_   int                  null,
    TENANT_ID_          varchar(64)          null,
    VERSION_TAG_        varchar(64)          null,
    HISTORY_TTL_        int                  null,
    STARTABLE_          tinyint(1) default 1 not null
)
    collate = utf8mb3_bin;

create index ACT_IDX_PROCDEF_DEPLOYMENT_ID
    on ACT_RE_PROCDEF (DEPLOYMENT_ID_);

create index ACT_IDX_PROCDEF_TENANT_ID
    on ACT_RE_PROCDEF (TENANT_ID_);

create index ACT_IDX_PROCDEF_VER_TAG
    on ACT_RE_PROCDEF (VERSION_TAG_);

create table ACT_RU_AUTHORIZATION
(
    ID_                varchar(64)  not null
        primary key,
    REV_               int          not null,
    TYPE_              int          not null,
    GROUP_ID_          varchar(255) null,
    USER_ID_           varchar(255) null,
    RESOURCE_TYPE_     int          not null,
    RESOURCE_ID_       varchar(255) null,
    PERMS_             int          null,
    REMOVAL_TIME_      datetime(3)  null,
    ROOT_PROC_INST_ID_ varchar(64)  null,
    constraint ACT_UNIQ_AUTH_GROUP
        unique (GROUP_ID_, TYPE_, RESOURCE_TYPE_, RESOURCE_ID_),
    constraint ACT_UNIQ_AUTH_USER
        unique (USER_ID_, TYPE_, RESOURCE_TYPE_, RESOURCE_ID_)
)
    collate = utf8mb3_bin;

create index ACT_IDX_AUTH_GROUP_ID
    on ACT_RU_AUTHORIZATION (GROUP_ID_);

create index ACT_IDX_AUTH_RESOURCE_ID
    on ACT_RU_AUTHORIZATION (RESOURCE_ID_);

create index ACT_IDX_AUTH_RM_TIME
    on ACT_RU_AUTHORIZATION (REMOVAL_TIME_);

create index ACT_IDX_AUTH_ROOT_PI
    on ACT_RU_AUTHORIZATION (ROOT_PROC_INST_ID_);

create table ACT_RU_CASE_EXECUTION
(
    ID_              varchar(64)  not null
        primary key,
    REV_             int          null,
    CASE_INST_ID_    varchar(64)  null,
    SUPER_CASE_EXEC_ varchar(64)  null,
    SUPER_EXEC_      varchar(64)  null,
    BUSINESS_KEY_    varchar(255) null,
    PARENT_ID_       varchar(64)  null,
    CASE_DEF_ID_     varchar(64)  null,
    ACT_ID_          varchar(255) null,
    PREV_STATE_      int          null,
    CURRENT_STATE_   int          null,
    REQUIRED_        tinyint(1)   null,
    TENANT_ID_       varchar(64)  null,
    constraint ACT_FK_CASE_EXE_CASE_DEF
        foreign key (CASE_DEF_ID_) references ACT_RE_CASE_DEF (ID_),
    constraint ACT_FK_CASE_EXE_CASE_INST
        foreign key (CASE_INST_ID_) references ACT_RU_CASE_EXECUTION (ID_)
            on update cascade on delete cascade,
    constraint ACT_FK_CASE_EXE_PARENT
        foreign key (PARENT_ID_) references ACT_RU_CASE_EXECUTION (ID_)
)
    collate = utf8mb3_bin;

create index ACT_IDX_CASE_EXEC_BUSKEY
    on ACT_RU_CASE_EXECUTION (BUSINESS_KEY_);

create index ACT_IDX_CASE_EXEC_TENANT_ID
    on ACT_RU_CASE_EXECUTION (TENANT_ID_);

create index ACT_IDX_CASE_EXE_CASE_INST
    on ACT_RU_CASE_EXECUTION (CASE_INST_ID_);

create table ACT_RU_CASE_SENTRY_PART
(
    ID_                  varchar(64)  not null
        primary key,
    REV_                 int          null,
    CASE_INST_ID_        varchar(64)  null,
    CASE_EXEC_ID_        varchar(64)  null,
    SENTRY_ID_           varchar(255) null,
    TYPE_                varchar(255) null,
    SOURCE_CASE_EXEC_ID_ varchar(64)  null,
    STANDARD_EVENT_      varchar(255) null,
    SOURCE_              varchar(255) null,
    VARIABLE_EVENT_      varchar(255) null,
    VARIABLE_NAME_       varchar(255) null,
    SATISFIED_           tinyint(1)   null,
    TENANT_ID_           varchar(64)  null,
    constraint ACT_FK_CASE_SENTRY_CASE_EXEC
        foreign key (CASE_EXEC_ID_) references ACT_RU_CASE_EXECUTION (ID_),
    constraint ACT_FK_CASE_SENTRY_CASE_INST
        foreign key (CASE_INST_ID_) references ACT_RU_CASE_EXECUTION (ID_)
)
    collate = utf8mb3_bin;

create table ACT_RU_EXECUTION
(
    ID_                varchar(64)  not null
        primary key,
    REV_               int          null,
    ROOT_PROC_INST_ID_ varchar(64)  null,
    PROC_INST_ID_      varchar(64)  null,
    BUSINESS_KEY_      varchar(255) null,
    PARENT_ID_         varchar(64)  null,
    PROC_DEF_ID_       varchar(64)  null,
    SUPER_EXEC_        varchar(64)  null,
    SUPER_CASE_EXEC_   varchar(64)  null,
    CASE_INST_ID_      varchar(64)  null,
    ACT_ID_            varchar(255) null,
    ACT_INST_ID_       varchar(64)  null,
    IS_ACTIVE_         tinyint      null,
    IS_CONCURRENT_     tinyint      null,
    IS_SCOPE_          tinyint      null,
    IS_EVENT_SCOPE_    tinyint      null,
    SUSPENSION_STATE_  int          null,
    CACHED_ENT_STATE_  int          null,
    SEQUENCE_COUNTER_  bigint       null,
    TENANT_ID_         varchar(64)  null,
    constraint ACT_FK_EXE_PARENT
        foreign key (PARENT_ID_) references ACT_RU_EXECUTION (ID_),
    constraint ACT_FK_EXE_PROCDEF
        foreign key (PROC_DEF_ID_) references ACT_RE_PROCDEF (ID_),
    constraint ACT_FK_EXE_PROCINST
        foreign key (PROC_INST_ID_) references ACT_RU_EXECUTION (ID_)
            on update cascade on delete cascade,
    constraint ACT_FK_EXE_SUPER
        foreign key (SUPER_EXEC_) references ACT_RU_EXECUTION (ID_)
)
    collate = utf8mb3_bin;

create table ACT_RU_EVENT_SUBSCR
(
    ID_            varchar(64)  not null
        primary key,
    REV_           int          null,
    EVENT_TYPE_    varchar(255) not null,
    EVENT_NAME_    varchar(255) null,
    EXECUTION_ID_  varchar(64)  null,
    PROC_INST_ID_  varchar(64)  null,
    ACTIVITY_ID_   varchar(255) null,
    CONFIGURATION_ varchar(255) null,
    CREATED_       datetime(3)  not null,
    TENANT_ID_     varchar(64)  null,
    constraint ACT_FK_EVENT_EXEC
        foreign key (EXECUTION_ID_) references ACT_RU_EXECUTION (ID_)
)
    collate = utf8mb3_bin;

create index ACT_IDX_EVENT_SUBSCR_CONFIG_
    on ACT_RU_EVENT_SUBSCR (CONFIGURATION_);

create index ACT_IDX_EVENT_SUBSCR_EVT_NAME
    on ACT_RU_EVENT_SUBSCR (EVENT_NAME_);

create index ACT_IDX_EVENT_SUBSCR_TENANT_ID
    on ACT_RU_EVENT_SUBSCR (TENANT_ID_);

create index ACT_IDX_EXEC_BUSKEY
    on ACT_RU_EXECUTION (BUSINESS_KEY_);

create index ACT_IDX_EXEC_ROOT_PI
    on ACT_RU_EXECUTION (ROOT_PROC_INST_ID_);

create index ACT_IDX_EXEC_TENANT_ID
    on ACT_RU_EXECUTION (TENANT_ID_);

create table ACT_RU_EXT_TASK
(
    ID_                  varchar(64)      not null
        primary key,
    REV_                 int              not null,
    WORKER_ID_           varchar(255)     null,
    TOPIC_NAME_          varchar(255)     null,
    RETRIES_             int              null,
    ERROR_MSG_           varchar(4000)    null,
    ERROR_DETAILS_ID_    varchar(64)      null,
    LOCK_EXP_TIME_       datetime(3)      null,
    SUSPENSION_STATE_    int              null,
    EXECUTION_ID_        varchar(64)      null,
    PROC_INST_ID_        varchar(64)      null,
    PROC_DEF_ID_         varchar(64)      null,
    PROC_DEF_KEY_        varchar(255)     null,
    ACT_ID_              varchar(255)     null,
    ACT_INST_ID_         varchar(64)      null,
    TENANT_ID_           varchar(64)      null,
    PRIORITY_            bigint default 0 not null,
    LAST_FAILURE_LOG_ID_ varchar(64)      null,
    constraint ACT_FK_EXT_TASK_ERROR_DETAILS
        foreign key (ERROR_DETAILS_ID_) references ACT_GE_BYTEARRAY (ID_),
    constraint ACT_FK_EXT_TASK_EXE
        foreign key (EXECUTION_ID_) references ACT_RU_EXECUTION (ID_)
)
    collate = utf8mb3_bin;

create index ACT_IDX_EXT_TASK_ERR_DETAILS
    on ACT_RU_EXT_TASK (ERROR_DETAILS_ID_);

create index ACT_IDX_EXT_TASK_EXEC
    on ACT_RU_EXT_TASK (EXECUTION_ID_);

create index ACT_IDX_EXT_TASK_PRIORITY
    on ACT_RU_EXT_TASK (PRIORITY_);

create index ACT_IDX_EXT_TASK_TENANT_ID
    on ACT_RU_EXT_TASK (TENANT_ID_);

create index ACT_IDX_EXT_TASK_TOPIC
    on ACT_RU_EXT_TASK (TOPIC_NAME_);

create table ACT_RU_FILTER
(
    ID_            varchar(64)  not null
        primary key,
    REV_           int          not null,
    RESOURCE_TYPE_ varchar(255) not null,
    NAME_          varchar(255) not null,
    OWNER_         varchar(255) null,
    QUERY_         longtext     not null,
    PROPERTIES_    longtext     null
)
    collate = utf8mb3_bin;

create table ACT_RU_JOB
(
    ID_                  varchar(64)      not null
        primary key,
    REV_                 int              null,
    TYPE_                varchar(255)     not null,
    LOCK_EXP_TIME_       datetime(3)      null,
    LOCK_OWNER_          varchar(255)     null,
    EXCLUSIVE_           tinyint(1)       null,
    EXECUTION_ID_        varchar(64)      null,
    PROCESS_INSTANCE_ID_ varchar(64)      null,
    PROCESS_DEF_ID_      varchar(64)      null,
    PROCESS_DEF_KEY_     varchar(255)     null,
    RETRIES_             int              null,
    EXCEPTION_STACK_ID_  varchar(64)      null,
    EXCEPTION_MSG_       varchar(4000)    null,
    FAILED_ACT_ID_       varchar(255)     null,
    DUEDATE_             datetime(3)      null,
    REPEAT_              varchar(255)     null,
    REPEAT_OFFSET_       bigint default 0 null,
    HANDLER_TYPE_        varchar(255)     null,
    HANDLER_CFG_         varchar(4000)    null,
    DEPLOYMENT_ID_       varchar(64)      null,
    SUSPENSION_STATE_    int    default 1 not null,
    JOB_DEF_ID_          varchar(64)      null,
    PRIORITY_            bigint default 0 not null,
    SEQUENCE_COUNTER_    bigint           null,
    TENANT_ID_           varchar(64)      null,
    CREATE_TIME_         datetime(3)      null,
    LAST_FAILURE_LOG_ID_ varchar(64)      null,
    constraint ACT_FK_JOB_EXCEPTION
        foreign key (EXCEPTION_STACK_ID_) references ACT_GE_BYTEARRAY (ID_)
)
    collate = utf8mb3_bin;

create index ACT_IDX_JOB_EXECUTION_ID
    on ACT_RU_JOB (EXECUTION_ID_);

create index ACT_IDX_JOB_HANDLER
    on ACT_RU_JOB (HANDLER_TYPE_(100), HANDLER_CFG_(155));

create index ACT_IDX_JOB_HANDLER_TYPE
    on ACT_RU_JOB (HANDLER_TYPE_);

create index ACT_IDX_JOB_JOB_DEF_ID
    on ACT_RU_JOB (JOB_DEF_ID_);

create index ACT_IDX_JOB_PROCINST
    on ACT_RU_JOB (PROCESS_INSTANCE_ID_);

create index ACT_IDX_JOB_TENANT_ID
    on ACT_RU_JOB (TENANT_ID_);

create table ACT_RU_JOBDEF
(
    ID_                varchar(64)  not null
        primary key,
    REV_               int          null,
    PROC_DEF_ID_       varchar(64)  null,
    PROC_DEF_KEY_      varchar(255) null,
    ACT_ID_            varchar(255) null,
    JOB_TYPE_          varchar(255) not null,
    JOB_CONFIGURATION_ varchar(255) null,
    SUSPENSION_STATE_  int          null,
    JOB_PRIORITY_      bigint       null,
    TENANT_ID_         varchar(64)  null,
    DEPLOYMENT_ID_     varchar(64)  null
)
    collate = utf8mb3_bin;

create table ACT_RU_BATCH
(
    ID_                  varchar(64)  not null
        primary key,
    REV_                 int          not null,
    TYPE_                varchar(255) null,
    TOTAL_JOBS_          int          null,
    JOBS_CREATED_        int          null,
    JOBS_PER_SEED_       int          null,
    INVOCATIONS_PER_JOB_ int          null,
    SEED_JOB_DEF_ID_     varchar(64)  null,
    BATCH_JOB_DEF_ID_    varchar(64)  null,
    MONITOR_JOB_DEF_ID_  varchar(64)  null,
    SUSPENSION_STATE_    int          null,
    CONFIGURATION_       varchar(255) null,
    TENANT_ID_           varchar(64)  null,
    CREATE_USER_ID_      varchar(255) null,
    START_TIME_          datetime(3)  null,
    EXEC_START_TIME_     datetime(3)  null,
    constraint ACT_FK_BATCH_JOB_DEF
        foreign key (BATCH_JOB_DEF_ID_) references ACT_RU_JOBDEF (ID_),
    constraint ACT_FK_BATCH_MONITOR_JOB_DEF
        foreign key (MONITOR_JOB_DEF_ID_) references ACT_RU_JOBDEF (ID_),
    constraint ACT_FK_BATCH_SEED_JOB_DEF
        foreign key (SEED_JOB_DEF_ID_) references ACT_RU_JOBDEF (ID_)
)
    collate = utf8mb3_bin;

create index ACT_IDX_BATCH_JOB_DEF
    on ACT_RU_BATCH (BATCH_JOB_DEF_ID_);

create index ACT_IDX_BATCH_MONITOR_JOB_DEF
    on ACT_RU_BATCH (MONITOR_JOB_DEF_ID_);

create index ACT_IDX_BATCH_SEED_JOB_DEF
    on ACT_RU_BATCH (SEED_JOB_DEF_ID_);

create table ACT_RU_INCIDENT
(
    ID_                     varchar(64)   not null
        primary key,
    REV_                    int           not null,
    INCIDENT_TIMESTAMP_     datetime(3)   not null,
    INCIDENT_MSG_           varchar(4000) null,
    INCIDENT_TYPE_          varchar(255)  not null,
    EXECUTION_ID_           varchar(64)   null,
    ACTIVITY_ID_            varchar(255)  null,
    FAILED_ACTIVITY_ID_     varchar(255)  null,
    PROC_INST_ID_           varchar(64)   null,
    PROC_DEF_ID_            varchar(64)   null,
    CAUSE_INCIDENT_ID_      varchar(64)   null,
    ROOT_CAUSE_INCIDENT_ID_ varchar(64)   null,
    CONFIGURATION_          varchar(255)  null,
    TENANT_ID_              varchar(64)   null,
    JOB_DEF_ID_             varchar(64)   null,
    ANNOTATION_             varchar(4000) null,
    constraint ACT_FK_INC_CAUSE
        foreign key (CAUSE_INCIDENT_ID_) references ACT_RU_INCIDENT (ID_)
            on update cascade on delete cascade,
    constraint ACT_FK_INC_EXE
        foreign key (EXECUTION_ID_) references ACT_RU_EXECUTION (ID_),
    constraint ACT_FK_INC_JOB_DEF
        foreign key (JOB_DEF_ID_) references ACT_RU_JOBDEF (ID_),
    constraint ACT_FK_INC_PROCDEF
        foreign key (PROC_DEF_ID_) references ACT_RE_PROCDEF (ID_),
    constraint ACT_FK_INC_PROCINST
        foreign key (PROC_INST_ID_) references ACT_RU_EXECUTION (ID_),
    constraint ACT_FK_INC_RCAUSE
        foreign key (ROOT_CAUSE_INCIDENT_ID_) references ACT_RU_INCIDENT (ID_)
            on update cascade on delete cascade
)
    collate = utf8mb3_bin;

create index ACT_IDX_INC_CAUSEINCID
    on ACT_RU_INCIDENT (CAUSE_INCIDENT_ID_);

create index ACT_IDX_INC_CONFIGURATION
    on ACT_RU_INCIDENT (CONFIGURATION_);

create index ACT_IDX_INC_EXID
    on ACT_RU_INCIDENT (EXECUTION_ID_);

create index ACT_IDX_INC_JOB_DEF
    on ACT_RU_INCIDENT (JOB_DEF_ID_);

create index ACT_IDX_INC_PROCDEFID
    on ACT_RU_INCIDENT (PROC_DEF_ID_);

create index ACT_IDX_INC_PROCINSTID
    on ACT_RU_INCIDENT (PROC_INST_ID_);

create index ACT_IDX_INC_ROOTCAUSEINCID
    on ACT_RU_INCIDENT (ROOT_CAUSE_INCIDENT_ID_);

create index ACT_IDX_INC_TENANT_ID
    on ACT_RU_INCIDENT (TENANT_ID_);

create index ACT_IDX_JOBDEF_PROC_DEF_ID
    on ACT_RU_JOBDEF (PROC_DEF_ID_);

create index ACT_IDX_JOBDEF_TENANT_ID
    on ACT_RU_JOBDEF (TENANT_ID_);

create table ACT_RU_METER_LOG
(
    ID_           varchar(64)      not null
        primary key,
    NAME_         varchar(64)      not null,
    REPORTER_     varchar(255)     null,
    VALUE_        bigint           null,
    TIMESTAMP_    datetime(3)      null,
    MILLISECONDS_ bigint default 0 null
)
    collate = utf8mb3_bin;

create index ACT_IDX_METER_LOG
    on ACT_RU_METER_LOG (NAME_, TIMESTAMP_);

create index ACT_IDX_METER_LOG_MS
    on ACT_RU_METER_LOG (MILLISECONDS_);

create index ACT_IDX_METER_LOG_NAME_MS
    on ACT_RU_METER_LOG (NAME_, MILLISECONDS_);

create index ACT_IDX_METER_LOG_REPORT
    on ACT_RU_METER_LOG (NAME_, REPORTER_, MILLISECONDS_);

create index ACT_IDX_METER_LOG_TIME
    on ACT_RU_METER_LOG (TIMESTAMP_);

create table ACT_RU_TASK
(
    ID_                varchar(64)   not null
        primary key,
    REV_               int           null,
    EXECUTION_ID_      varchar(64)   null,
    PROC_INST_ID_      varchar(64)   null,
    PROC_DEF_ID_       varchar(64)   null,
    CASE_EXECUTION_ID_ varchar(64)   null,
    CASE_INST_ID_      varchar(64)   null,
    CASE_DEF_ID_       varchar(64)   null,
    NAME_              varchar(255)  null,
    PARENT_TASK_ID_    varchar(64)   null,
    DESCRIPTION_       varchar(4000) null,
    TASK_DEF_KEY_      varchar(255)  null,
    OWNER_             varchar(255)  null,
    ASSIGNEE_          varchar(255)  null,
    DELEGATION_        varchar(64)   null,
    PRIORITY_          int           null,
    CREATE_TIME_       datetime(3)   null,
    LAST_UPDATED_      datetime(3)   null,
    DUE_DATE_          datetime(3)   null,
    FOLLOW_UP_DATE_    datetime(3)   null,
    SUSPENSION_STATE_  int           null,
    TENANT_ID_         varchar(64)   null,
    constraint ACT_FK_TASK_CASE_DEF
        foreign key (CASE_DEF_ID_) references ACT_RE_CASE_DEF (ID_),
    constraint ACT_FK_TASK_CASE_EXE
        foreign key (CASE_EXECUTION_ID_) references ACT_RU_CASE_EXECUTION (ID_),
    constraint ACT_FK_TASK_EXE
        foreign key (EXECUTION_ID_) references ACT_RU_EXECUTION (ID_),
    constraint ACT_FK_TASK_PROCDEF
        foreign key (PROC_DEF_ID_) references ACT_RE_PROCDEF (ID_),
    constraint ACT_FK_TASK_PROCINST
        foreign key (PROC_INST_ID_) references ACT_RU_EXECUTION (ID_)
)
    collate = utf8mb3_bin;

create table ACT_RU_IDENTITYLINK
(
    ID_          varchar(64)  not null
        primary key,
    REV_         int          null,
    GROUP_ID_    varchar(255) null,
    TYPE_        varchar(255) null,
    USER_ID_     varchar(255) null,
    TASK_ID_     varchar(64)  null,
    PROC_DEF_ID_ varchar(64)  null,
    TENANT_ID_   varchar(64)  null,
    constraint ACT_FK_ATHRZ_PROCEDEF
        foreign key (PROC_DEF_ID_) references ACT_RE_PROCDEF (ID_),
    constraint ACT_FK_TSKASS_TASK
        foreign key (TASK_ID_) references ACT_RU_TASK (ID_)
)
    collate = utf8mb3_bin;

create index ACT_IDX_ATHRZ_PROCEDEF
    on ACT_RU_IDENTITYLINK (PROC_DEF_ID_);

create index ACT_IDX_IDENT_LNK_GROUP
    on ACT_RU_IDENTITYLINK (GROUP_ID_);

create index ACT_IDX_IDENT_LNK_USER
    on ACT_RU_IDENTITYLINK (USER_ID_);

create index ACT_IDX_TASK_ASSIGNEE
    on ACT_RU_TASK (ASSIGNEE_);

create index ACT_IDX_TASK_CREATE
    on ACT_RU_TASK (CREATE_TIME_);

create index ACT_IDX_TASK_LAST_UPDATED
    on ACT_RU_TASK (LAST_UPDATED_);

create index ACT_IDX_TASK_OWNER
    on ACT_RU_TASK (OWNER_);

create index ACT_IDX_TASK_TENANT_ID
    on ACT_RU_TASK (TENANT_ID_);

create table ACT_RU_TASK_METER_LOG
(
    ID_            varchar(64) not null
        primary key,
    ASSIGNEE_HASH_ bigint      null,
    TIMESTAMP_     datetime(3) null
)
    collate = utf8mb3_bin;

create index ACT_IDX_TASK_METER_LOG_TIME
    on ACT_RU_TASK_METER_LOG (TIMESTAMP_);

create table ACT_RU_VARIABLE
(
    ID_                  varchar(64)   not null
        primary key,
    REV_                 int           null,
    TYPE_                varchar(255)  not null,
    NAME_                varchar(255)  not null,
    EXECUTION_ID_        varchar(64)   null,
    PROC_INST_ID_        varchar(64)   null,
    PROC_DEF_ID_         varchar(64)   null,
    CASE_EXECUTION_ID_   varchar(64)   null,
    CASE_INST_ID_        varchar(64)   null,
    TASK_ID_             varchar(64)   null,
    BATCH_ID_            varchar(64)   null,
    BYTEARRAY_ID_        varchar(64)   null,
    DOUBLE_              double        null,
    LONG_                bigint        null,
    TEXT_                varchar(4000) null,
    TEXT2_               varchar(4000) null,
    VAR_SCOPE_           varchar(64)   not null,
    SEQUENCE_COUNTER_    bigint        null,
    IS_CONCURRENT_LOCAL_ tinyint       null,
    TENANT_ID_           varchar(64)   null,
    constraint ACT_UNIQ_VARIABLE
        unique (VAR_SCOPE_, NAME_),
    constraint ACT_FK_VAR_BATCH
        foreign key (BATCH_ID_) references ACT_RU_BATCH (ID_),
    constraint ACT_FK_VAR_BYTEARRAY
        foreign key (BYTEARRAY_ID_) references ACT_GE_BYTEARRAY (ID_),
    constraint ACT_FK_VAR_CASE_EXE
        foreign key (CASE_EXECUTION_ID_) references ACT_RU_CASE_EXECUTION (ID_),
    constraint ACT_FK_VAR_CASE_INST
        foreign key (CASE_INST_ID_) references ACT_RU_CASE_EXECUTION (ID_),
    constraint ACT_FK_VAR_EXE
        foreign key (EXECUTION_ID_) references ACT_RU_EXECUTION (ID_),
    constraint ACT_FK_VAR_PROCINST
        foreign key (PROC_INST_ID_) references ACT_RU_EXECUTION (ID_)
)
    collate = utf8mb3_bin;

create index ACT_IDX_BATCH_ID
    on ACT_RU_VARIABLE (BATCH_ID_);

create index ACT_IDX_VARIABLE_TASK_ID
    on ACT_RU_VARIABLE (TASK_ID_);

create index ACT_IDX_VARIABLE_TASK_NAME_TYPE
    on ACT_RU_VARIABLE (TASK_ID_, NAME_, TYPE_);

create index ACT_IDX_VARIABLE_TENANT_ID
    on ACT_RU_VARIABLE (TENANT_ID_);

create table QRTZ_CALENDARS
(
    sched_name    varchar(120) not null comment '调度名称',
    calendar_name varchar(200) not null comment '日历名称',
    calendar      blob         not null comment '存放持久化calendar对象',
    primary key (sched_name, calendar_name)
)
    comment '日历信息表';

create table QRTZ_FIRED_TRIGGERS
(
    sched_name        varchar(120) not null comment '调度名称',
    entry_id          varchar(95)  not null comment '调度器实例id',
    trigger_name      varchar(200) not null comment 'qrtz_triggers表trigger_name的外键',
    trigger_group     varchar(200) not null comment 'qrtz_triggers表trigger_group的外键',
    instance_name     varchar(200) not null comment '调度器实例名',
    fired_time        bigint(13)   not null comment '触发的时间',
    sched_time        bigint(13)   not null comment '定时器制定的时间',
    priority          int          not null comment '优先级',
    state             varchar(16)  not null comment '状态',
    job_name          varchar(200) null comment '任务名称',
    job_group         varchar(200) null comment '任务组名',
    is_nonconcurrent  varchar(1)   null comment '是否并发',
    requests_recovery varchar(1)   null comment '是否接受恢复执行',
    primary key (sched_name, entry_id)
)
    comment '已触发的触发器表';

create table QRTZ_JOB_DETAILS
(
    sched_name        varchar(120) not null comment '调度名称',
    job_name          varchar(200) not null comment '任务名称',
    job_group         varchar(200) not null comment '任务组名',
    description       varchar(250) null comment '相关介绍',
    job_class_name    varchar(250) not null comment '执行任务类名称',
    is_durable        varchar(1)   not null comment '是否持久化',
    is_nonconcurrent  varchar(1)   not null comment '是否并发',
    is_update_data    varchar(1)   not null comment '是否更新数据',
    requests_recovery varchar(1)   not null comment '是否接受恢复执行',
    job_data          blob         null comment '存放持久化job对象',
    primary key (sched_name, job_name, job_group)
)
    comment '任务详细信息表';

create table QRTZ_LOCKS
(
    sched_name varchar(120) not null comment '调度名称',
    lock_name  varchar(40)  not null comment '悲观锁名称',
    primary key (sched_name, lock_name)
)
    comment '存储的悲观锁信息表';

create table QRTZ_PAUSED_TRIGGER_GRPS
(
    sched_name    varchar(120) not null comment '调度名称',
    trigger_group varchar(200) not null comment 'qrtz_triggers表trigger_group的外键',
    primary key (sched_name, trigger_group)
)
    comment '暂停的触发器表';

create table QRTZ_SCHEDULER_STATE
(
    sched_name        varchar(120) not null comment '调度名称',
    instance_name     varchar(200) not null comment '实例名称',
    last_checkin_time bigint(13)   not null comment '上次检查时间',
    checkin_interval  bigint(13)   not null comment '检查间隔时间',
    primary key (sched_name, instance_name)
)
    comment '调度器状态表';

create table QRTZ_TRIGGERS
(
    sched_name     varchar(120) not null comment '调度名称',
    trigger_name   varchar(200) not null comment '触发器的名字',
    trigger_group  varchar(200) not null comment '触发器所属组的名字',
    job_name       varchar(200) not null comment 'qrtz_job_details表job_name的外键',
    job_group      varchar(200) not null comment 'qrtz_job_details表job_group的外键',
    description    varchar(250) null comment '相关介绍',
    next_fire_time bigint(13)   null comment '上一次触发时间（毫秒）',
    prev_fire_time bigint(13)   null comment '下一次触发时间（默认为-1表示不触发）',
    priority       int          null comment '优先级',
    trigger_state  varchar(16)  not null comment '触发器状态',
    trigger_type   varchar(8)   not null comment '触发器的类型',
    start_time     bigint(13)   not null comment '开始时间',
    end_time       bigint(13)   null comment '结束时间',
    calendar_name  varchar(200) null comment '日程表名称',
    misfire_instr  smallint(2)  null comment '补偿执行的策略',
    job_data       blob         null comment '存放持久化job对象',
    primary key (sched_name, trigger_name, trigger_group),
    constraint QRTZ_TRIGGERS_ibfk_1
        foreign key (sched_name, job_name, job_group) references QRTZ_JOB_DETAILS (sched_name, job_name, job_group)
)
    comment '触发器详细信息表';

create table QRTZ_BLOB_TRIGGERS
(
    sched_name    varchar(120) not null comment '调度名称',
    trigger_name  varchar(200) not null comment 'qrtz_triggers表trigger_name的外键',
    trigger_group varchar(200) not null comment 'qrtz_triggers表trigger_group的外键',
    blob_data     blob         null comment '存放持久化Trigger对象',
    primary key (sched_name, trigger_name, trigger_group),
    constraint QRTZ_BLOB_TRIGGERS_ibfk_1
        foreign key (sched_name, trigger_name, trigger_group) references QRTZ_TRIGGERS (sched_name, trigger_name, trigger_group)
)
    comment 'Blob类型的触发器表';

create table QRTZ_CRON_TRIGGERS
(
    sched_name      varchar(120) not null comment '调度名称',
    trigger_name    varchar(200) not null comment 'qrtz_triggers表trigger_name的外键',
    trigger_group   varchar(200) not null comment 'qrtz_triggers表trigger_group的外键',
    cron_expression varchar(200) not null comment 'cron表达式',
    time_zone_id    varchar(80)  null comment '时区',
    primary key (sched_name, trigger_name, trigger_group),
    constraint QRTZ_CRON_TRIGGERS_ibfk_1
        foreign key (sched_name, trigger_name, trigger_group) references QRTZ_TRIGGERS (sched_name, trigger_name, trigger_group)
)
    comment 'Cron类型的触发器表';

create table QRTZ_SIMPLE_TRIGGERS
(
    sched_name      varchar(120) not null comment '调度名称',
    trigger_name    varchar(200) not null comment 'qrtz_triggers表trigger_name的外键',
    trigger_group   varchar(200) not null comment 'qrtz_triggers表trigger_group的外键',
    repeat_count    bigint(7)    not null comment '重复的次数统计',
    repeat_interval bigint(12)   not null comment '重复的间隔时间',
    times_triggered bigint(10)   not null comment '已经触发的次数',
    primary key (sched_name, trigger_name, trigger_group),
    constraint QRTZ_SIMPLE_TRIGGERS_ibfk_1
        foreign key (sched_name, trigger_name, trigger_group) references QRTZ_TRIGGERS (sched_name, trigger_name, trigger_group)
)
    comment '简单触发器的信息表';

create table QRTZ_SIMPROP_TRIGGERS
(
    sched_name    varchar(120)   not null comment '调度名称',
    trigger_name  varchar(200)   not null comment 'qrtz_triggers表trigger_name的外键',
    trigger_group varchar(200)   not null comment 'qrtz_triggers表trigger_group的外键',
    str_prop_1    varchar(512)   null comment 'String类型的trigger的第一个参数',
    str_prop_2    varchar(512)   null comment 'String类型的trigger的第二个参数',
    str_prop_3    varchar(512)   null comment 'String类型的trigger的第三个参数',
    int_prop_1    int            null comment 'int类型的trigger的第一个参数',
    int_prop_2    int            null comment 'int类型的trigger的第二个参数',
    long_prop_1   bigint         null comment 'long类型的trigger的第一个参数',
    long_prop_2   bigint         null comment 'long类型的trigger的第二个参数',
    dec_prop_1    decimal(13, 4) null comment 'decimal类型的trigger的第一个参数',
    dec_prop_2    decimal(13, 4) null comment 'decimal类型的trigger的第二个参数',
    bool_prop_1   varchar(1)     null comment 'Boolean类型的trigger的第一个参数',
    bool_prop_2   varchar(1)     null comment 'Boolean类型的trigger的第二个参数',
    primary key (sched_name, trigger_name, trigger_group),
    constraint QRTZ_SIMPROP_TRIGGERS_ibfk_1
        foreign key (sched_name, trigger_name, trigger_group) references QRTZ_TRIGGERS (sched_name, trigger_name, trigger_group)
)
    comment '同步机制的行锁表';

create index sched_name
    on QRTZ_TRIGGERS (sched_name, job_name, job_group);

create table gen_table
(
    table_id          bigint auto_increment comment '编号'
        primary key,
    table_name        varchar(200) default ''     null comment '表名称',
    table_comment     varchar(500) default ''     null comment '表描述',
    sub_table_name    varchar(64)                 null comment '关联子表的表名',
    sub_table_fk_name varchar(64)                 null comment '子表关联的外键名',
    class_name        varchar(100) default ''     null comment '实体类名称',
    tpl_category      varchar(200) default 'crud' null comment '使用的模板（crud单表操作 tree树表操作）',
    package_name      varchar(100)                null comment '生成包路径',
    module_name       varchar(30)                 null comment '生成模块名',
    business_name     varchar(30)                 null comment '生成业务名',
    function_name     varchar(50)                 null comment '生成功能名',
    function_author   varchar(50)                 null comment '生成功能作者',
    gen_type          char         default '0'    null comment '生成代码方式（0zip压缩包 1自定义路径）',
    gen_path          varchar(200) default '/'    null comment '生成路径（不填默认项目路径）',
    options           varchar(1000)               null comment '其它生成选项',
    create_by         varchar(64)  default ''     null comment '创建者',
    create_time       datetime                    null comment '创建时间',
    update_by         varchar(64)  default ''     null comment '更新者',
    update_time       datetime                    null comment '更新时间',
    remark            varchar(500)                null comment '备注'
)
    comment '代码生成业务表';

create table gen_table_column
(
    column_id      bigint auto_increment comment '编号'
        primary key,
    table_id       varchar(64)               null comment '归属表编号',
    column_name    varchar(200)              null comment '列名称',
    column_comment varchar(500)              null comment '列描述',
    column_type    varchar(100)              null comment '列类型',
    java_type      varchar(500)              null comment 'JAVA类型',
    java_field     varchar(200)              null comment 'JAVA字段名',
    is_pk          char                      null comment '是否主键（1是）',
    is_increment   char                      null comment '是否自增（1是）',
    is_required    char                      null comment '是否必填（1是）',
    is_insert      char                      null comment '是否为插入字段（1是）',
    is_edit        char                      null comment '是否编辑字段（1是）',
    is_list        char                      null comment '是否列表字段（1是）',
    is_query       char                      null comment '是否查询字段（1是）',
    query_type     varchar(200) default 'EQ' null comment '查询方式（等于、不等于、大于、小于、范围）',
    html_type      varchar(200)              null comment '显示类型（文本框、文本域、下拉框、复选框、单选框、日期控件）',
    dict_type      varchar(200) default ''   null comment '字典类型',
    sort           int                       null comment '排序',
    create_by      varchar(64)  default ''   null comment '创建者',
    create_time    datetime                  null comment '创建时间',
    update_by      varchar(64)  default ''   null comment '更新者',
    update_time    datetime                  null comment '更新时间'
)
    comment '代码生成业务表字段';

create table sys_config
(
    config_id    int(5) auto_increment comment '参数主键'
        primary key,
    config_name  varchar(100) default ''  null comment '参数名称',
    config_key   varchar(100) default ''  null comment '参数键名',
    config_value varchar(500) default ''  null comment '参数键值',
    config_type  char         default 'N' null comment '系统内置（Y是 N否）',
    create_by    varchar(64)  default ''  null comment '创建者',
    create_time  datetime                 null comment '创建时间',
    update_by    varchar(64)  default ''  null comment '更新者',
    update_time  datetime                 null comment '更新时间',
    remark       varchar(500)             null comment '备注'
)
    comment '参数配置表';

create table sys_dept
(
    dept_id     bigint auto_increment comment '部门id'
        primary key,
    parent_id   bigint      default 0   null comment '父部门id',
    ancestors   varchar(50) default ''  null comment '祖级列表',
    dept_name   varchar(30) default ''  null comment '部门名称',
    order_num   int(4)      default 0   null comment '显示顺序',
    leader      varchar(20)             null comment '负责人',
    phone       varchar(11)             null comment '联系电话',
    email       varchar(50)             null comment '邮箱',
    status      char        default '0' null comment '部门状态（0正常 1停用）',
    del_flag    char        default '0' null comment '删除标志（0代表存在 2代表删除）',
    create_by   varchar(64) default ''  null comment '创建者',
    create_time datetime                null comment '创建时间',
    update_by   varchar(64) default ''  null comment '更新者',
    update_time datetime                null comment '更新时间'
)
    comment '部门表';

create table sys_dict_data
(
    dict_code   bigint auto_increment comment '字典编码'
        primary key,
    dict_sort   int(4)       default 0   null comment '字典排序',
    dict_label  varchar(100) default ''  null comment '字典标签',
    dict_value  varchar(100) default ''  null comment '字典键值',
    dict_type   varchar(100) default ''  null comment '字典类型',
    css_class   varchar(100)             null comment '样式属性（其他样式扩展）',
    list_class  varchar(100)             null comment '表格回显样式',
    is_default  char         default 'N' null comment '是否默认（Y是 N否）',
    status      char         default '0' null comment '状态（0正常 1停用）',
    create_by   varchar(64)  default ''  null comment '创建者',
    create_time datetime                 null comment '创建时间',
    update_by   varchar(64)  default ''  null comment '更新者',
    update_time datetime                 null comment '更新时间',
    remark      varchar(500)             null comment '备注'
)
    comment '字典数据表';

create table sys_dict_type
(
    dict_id     bigint auto_increment comment '字典主键'
        primary key,
    dict_name   varchar(100) default ''  null comment '字典名称',
    dict_type   varchar(100) default ''  null comment '字典类型',
    status      char         default '0' null comment '状态（0正常 1停用）',
    create_by   varchar(64)  default ''  null comment '创建者',
    create_time datetime                 null comment '创建时间',
    update_by   varchar(64)  default ''  null comment '更新者',
    update_time datetime                 null comment '更新时间',
    remark      varchar(500)             null comment '备注',
    constraint dict_type
        unique (dict_type)
)
    comment '字典类型表';

create table sys_job
(
    job_id          bigint auto_increment comment '任务ID',
    job_name        varchar(64)  default ''        not null comment '任务名称',
    job_group       varchar(64)  default 'DEFAULT' not null comment '任务组名',
    invoke_target   varchar(500)                   not null comment '调用目标字符串',
    cron_expression varchar(255) default ''        null comment 'cron执行表达式',
    misfire_policy  varchar(20)  default '3'       null comment '计划执行错误策略（1立即执行 2执行一次 3放弃执行）',
    concurrent      char         default '1'       null comment '是否并发执行（0允许 1禁止）',
    status          char         default '0'       null comment '状态（0正常 1暂停）',
    create_by       varchar(64)  default ''        null comment '创建者',
    create_time     datetime                       null comment '创建时间',
    update_by       varchar(64)  default ''        null comment '更新者',
    update_time     datetime                       null comment '更新时间',
    remark          varchar(500) default ''        null comment '备注信息',
    primary key (job_id, job_name, job_group)
)
    comment '定时任务调度表';

create table sys_job_log
(
    job_log_id     bigint auto_increment comment '任务日志ID'
        primary key,
    job_name       varchar(64)               not null comment '任务名称',
    job_group      varchar(64)               not null comment '任务组名',
    invoke_target  varchar(500)              not null comment '调用目标字符串',
    job_message    varchar(500)              null comment '日志信息',
    status         char          default '0' null comment '执行状态（0正常 1失败）',
    exception_info varchar(2000) default ''  null comment '异常信息',
    create_time    datetime                  null comment '创建时间'
)
    comment '定时任务调度日志表';

create table sys_logininfor
(
    info_id        bigint auto_increment comment '访问ID'
        primary key,
    user_name      varchar(50)  default ''  null comment '用户账号',
    ipaddr         varchar(128) default ''  null comment '登录IP地址',
    login_location varchar(255) default ''  null comment '登录地点',
    browser        varchar(50)  default ''  null comment '浏览器类型',
    os             varchar(50)  default ''  null comment '操作系统',
    status         char         default '0' null comment '登录状态（0成功 1失败）',
    msg            varchar(255) default ''  null comment '提示消息',
    login_time     datetime                 null comment '访问时间'
)
    comment '系统访问记录';

create table sys_menu
(
    menu_id     bigint auto_increment comment '菜单ID'
        primary key,
    menu_name   varchar(50)              not null comment '菜单名称',
    parent_id   bigint       default 0   null comment '父菜单ID',
    order_num   int(4)       default 0   null comment '显示顺序',
    path        varchar(200) default ''  null comment '路由地址',
    component   varchar(255)             null comment '组件路径',
    query       varchar(255)             null comment '路由参数',
    is_frame    int(1)       default 1   null comment '是否为外链（0是 1否）',
    is_cache    int(1)       default 0   null comment '是否缓存（0缓存 1不缓存）',
    menu_type   char         default ''  null comment '菜单类型（M目录 C菜单 F按钮）',
    visible     char         default '0' null comment '菜单状态（0显示 1隐藏）',
    status      char         default '0' null comment '菜单状态（0正常 1停用）',
    perms       varchar(100)             null comment '权限标识',
    icon        varchar(100) default '#' null comment '菜单图标',
    create_by   varchar(64)  default ''  null comment '创建者',
    create_time datetime                 null comment '创建时间',
    update_by   varchar(64)  default ''  null comment '更新者',
    update_time datetime                 null comment '更新时间',
    remark      varchar(500) default ''  null comment '备注'
)
    comment '菜单权限表';

create table sys_notice
(
    notice_id      int(4) auto_increment comment '公告ID'
        primary key,
    notice_title   varchar(50)             not null comment '公告标题',
    notice_type    char                    not null comment '公告类型（1通知 2公告）',
    notice_content longblob                null comment '公告内容',
    status         char        default '0' null comment '公告状态（0正常 1关闭）',
    create_by      varchar(64) default ''  null comment '创建者',
    create_time    datetime                null comment '创建时间',
    update_by      varchar(64) default ''  null comment '更新者',
    update_time    datetime                null comment '更新时间',
    remark         varchar(255)            null comment '备注'
)
    comment '通知公告表';

create table sys_oper_log
(
    oper_id        bigint auto_increment comment '日志主键'
        primary key,
    title          varchar(50)   default '' null comment '模块标题',
    business_type  int(2)        default 0  null comment '业务类型（0其它 1新增 2修改 3删除）',
    method         varchar(100)  default '' null comment '方法名称',
    request_method varchar(10)   default '' null comment '请求方式',
    operator_type  int(1)        default 0  null comment '操作类别（0其它 1后台用户 2手机端用户）',
    oper_name      varchar(50)   default '' null comment '操作人员',
    dept_name      varchar(50)   default '' null comment '部门名称',
    oper_url       varchar(255)  default '' null comment '请求URL',
    oper_ip        varchar(128)  default '' null comment '主机地址',
    oper_location  varchar(255)  default '' null comment '操作地点',
    oper_param     varchar(2000) default '' null comment '请求参数',
    json_result    varchar(2000) default '' null comment '返回参数',
    status         int(1)        default 0  null comment '操作状态（0正常 1异常）',
    error_msg      varchar(2000) default '' null comment '错误消息',
    oper_time      datetime                 null comment '操作时间'
)
    comment '操作日志记录';

create table sys_post
(
    post_id     bigint auto_increment comment '岗位ID'
        primary key,
    post_code   varchar(64)            not null comment '岗位编码',
    post_name   varchar(50)            not null comment '岗位名称',
    post_sort   int(4)                 not null comment '显示顺序',
    status      char                   not null comment '状态（0正常 1停用）',
    create_by   varchar(64) default '' null comment '创建者',
    create_time datetime               null comment '创建时间',
    update_by   varchar(64) default '' null comment '更新者',
    update_time datetime               null comment '更新时间',
    remark      varchar(500)           null comment '备注'
)
    comment '岗位信息表';

create table sys_role
(
    role_id             bigint auto_increment comment '角色ID'
        primary key,
    role_name           varchar(30)             not null comment '角色名称',
    role_key            varchar(100)            not null comment '角色权限字符串',
    role_sort           int(4)                  not null comment '显示顺序',
    data_scope          char        default '1' null comment '数据范围（1：全部数据权限 2：自定数据权限 3：本部门数据权限 4：本部门及以下数据权限）',
    menu_check_strictly tinyint(1)  default 1   null comment '菜单树选择项是否关联显示',
    dept_check_strictly tinyint(1)  default 1   null comment '部门树选择项是否关联显示',
    status              char                    not null comment '角色状态（0正常 1停用）',
    del_flag            char        default '0' null comment '删除标志（0代表存在 2代表删除）',
    create_by           varchar(64) default ''  null comment '创建者',
    create_time         datetime                null comment '创建时间',
    update_by           varchar(64) default ''  null comment '更新者',
    update_time         datetime                null comment '更新时间',
    remark              varchar(500)            null comment '备注'
)
    comment '角色信息表';

create table sys_role_dept
(
    role_id bigint not null comment '角色ID',
    dept_id bigint not null comment '部门ID',
    primary key (role_id, dept_id)
)
    comment '角色和部门关联表';

create table sys_role_menu
(
    role_id bigint not null comment '角色ID',
    menu_id bigint not null comment '菜单ID',
    primary key (role_id, menu_id)
)
    comment '角色和菜单关联表';

create table sys_user
(
    user_id     bigint auto_increment comment '用户ID'
        primary key,
    dept_id     bigint                    null comment '部门ID',
    user_name   varchar(30)               not null comment '用户账号',
    nick_name   varchar(30)               not null comment '用户昵称',
    user_type   varchar(2)   default '00' null comment '用户类型（00系统用户）',
    email       varchar(50)  default ''   null comment '用户邮箱',
    phonenumber varchar(11)  default ''   null comment '手机号码',
    sex         char         default '0'  null comment '用户性别（0男 1女 2未知）',
    avatar      varchar(100) default ''   null comment '头像地址',
    password    varchar(100) default ''   null comment '密码',
    status      char         default '0'  null comment '帐号状态（0正常 1停用）',
    del_flag    char         default '0'  null comment '删除标志（0代表存在 2代表删除）',
    login_ip    varchar(128) default ''   null comment '最后登录IP',
    login_date  datetime                  null comment '最后登录时间',
    create_by   varchar(64)  default ''   null comment '创建者',
    create_time datetime                  null comment '创建时间',
    update_by   varchar(64)  default ''   null comment '更新者',
    update_time datetime                  null comment '更新时间',
    remark      varchar(500)              null comment '备注'
)
    comment '用户信息表';

create table sys_user_post
(
    user_id bigint not null comment '用户ID',
    post_id bigint not null comment '岗位ID',
    primary key (user_id, post_id)
)
    comment '用户与岗位关联表';

create table sys_user_role
(
    user_id bigint not null comment '用户ID',
    role_id bigint not null comment '角色ID',
    primary key (user_id, role_id)
)
    comment '用户和角色关联表';


create table rouyi.t_act_business_variable
(
    id            bigint auto_increment comment '主键'
        primary key,
    business_code varchar(255) null comment '业务编码',
    variable_id   bigint       null comment '变量ID'
);

create table rouyi.t_act_expand_business
(
    id            int auto_increment comment '主键'
        primary key,
    business_code varchar(255) null comment '业务code',
    business_name varchar(255) null comment '业务名称',
    view_path     varchar(255) null comment '业务组件路径',
    view_path1    varchar(255) null,
    view_path2    varchar(255) null,
    status        char         null comment '状态',
    create_time   datetime     null,
    create_user   bigint       null,
    update_time   datetime     null,
    update_user   bigint       null
)
    comment '流程扩展--业务表';

create table rouyi.t_act_expand_business_relation
(
    id                bigint auto_increment
        primary key,
    expand_process_id bigint(255)  null comment '流程部署ID',
    business_code     varchar(255) null
)
    comment '业务与流程部署关联';

create index t_act_expand_business_relation_index
    on rouyi.t_act_expand_business_relation (business_code);

create table rouyi.t_act_expand_process
(
    id                bigint auto_increment
        primary key,
    act_process_id    varchar(255)                         null,
    act_deployment_id varchar(255)                         null,
    status            int                                  not null,
    version           varchar(255)                         null,
    name              varchar(255)                         null,
    source            longblob                             null comment '0：草稿
1：已发布
99：停用
-1：删除',
    node_props        longblob                             null,
    variable          varchar(1024)                        null,
    deploy_time       datetime                             null,
    tenant_id         varchar(255)                         null,
    notify_type       varchar(255)                         null,
    notify_title      varchar(255)                         null,
    remark            varchar(255)                         null,
    create_time       datetime default current_timestamp() null,
    update_time       datetime                             null,
    create_user       bigint                               null,
    update_user       bigint                               null
);

create table rouyi.t_act_expand_process_variable
(
    id            bigint auto_increment comment '主键'
        primary key,
    code          varchar(255)                         null comment '代码',
    title         varchar(255)                         null comment '名称',
    status        varchar(255)                         null,
    description   varchar(255)                         null comment '描述',
    bean          varchar(255)                         null,
    invoke_target varchar(255)                         null comment '调用实现',
    create_time   datetime default current_timestamp() null comment '创建时间',
    update_time   datetime                             null comment '更新时间'
);

create table rouyi.t_act_hi_expand_process
(
    id                bigint auto_increment
        primary key,
    expand_process_id bigint                               null,
    act_process_id    varchar(255)                         null,
    act_deployment_id varchar(255)                         null,
    status            int                                  not null,
    version           varchar(255)                         null,
    name              varchar(255)                         null,
    source            longblob                             null comment '0：草稿
1：已发布
99：停用
-1：删除',
    node_props        longblob                             null,
    variable          varchar(1024)                        null,
    deploy_time       datetime                             null,
    tenant_id         varchar(255)                         null,
    notify_type       varchar(255)                         null,
    notify_title      varchar(255)                         null,
    remark            varchar(255)                         null,
    create_time       datetime default current_timestamp() null,
    update_time       datetime                             null,
    create_user       bigint                               null,
    update_user       bigint                               null
);

create table rouyi.t_leave
(
    id                  bigint auto_increment
        primary key,
    user_id             bigint                               null,
    leave_type          int                                  null,
    start_date          date                                 null,
    start_time          varchar(255)                         null,
    end_date            date                                 null,
    end_time            varchar(255)                         null,
    duration            double                               null,
    status              varchar(255)                         null,
    process_instance_id varchar(255)                         null,
    remark              varchar(512)                         null,
    create_time         datetime default current_timestamp() null,
    update_time         datetime                             null on update current_timestamp()
);

INSERT INTO rouyi.t_act_business_variable (id, business_code, variable_id) VALUES (7, 'LEAVE', 1);
INSERT INTO rouyi.t_act_business_variable (id, business_code, variable_id) VALUES (8, 'LEAVE', 2);

INSERT INTO rouyi.t_act_expand_business (id, business_code, business_name, view_path, view_path1, view_path2, status, create_time, create_user, update_time, update_user) VALUES (1, 'LEAVE', '请假', 'business/leave/detail', null, null, '0', '2022-11-18 15:13:20', 1, null, null);


INSERT INTO rouyi.t_act_expand_business_relation (id, expand_process_id, business_code) VALUES (1, 1, 'LEAVE');
INSERT INTO rouyi.t_act_expand_business_relation (id, expand_process_id, business_code) VALUES (36, 2, 'LEAVE');
INSERT INTO rouyi.t_act_expand_business_relation (id, expand_process_id, business_code) VALUES (37, 3, 'LEAVE');
INSERT INTO rouyi.t_act_expand_business_relation (id, expand_process_id, business_code) VALUES (41, 4, 'LEAVE');
INSERT INTO rouyi.t_act_expand_business_relation (id, expand_process_id, business_code) VALUES (42, 7, 'LEAVE');
INSERT INTO rouyi.t_act_expand_business_relation (id, expand_process_id, business_code) VALUES (48, 8, 'LEAVE');

INSERT INTO rouyi.t_act_expand_process (id, act_process_id, act_deployment_id, status, version, name, source, node_props, variable, deploy_time, tenant_id, notify_type, notify_title, remark, create_time, update_time, create_user, update_user) VALUES (1, null, null, 0, '1', '请假2022-11', null, null, null, null, null, null, null, null, '2022-11-18 16:03:22', null, null, null);
INSERT INTO rouyi.t_act_expand_process (id, act_process_id, act_deployment_id, status, version, name, source, node_props, variable, deploy_time, tenant_id, notify_type, notify_title, remark, create_time, update_time, create_user, update_user) VALUES (2, 'LEAVE2:5:cc6b208c-9f86-11ed-a8b3-c6bde56990c4', 'cc62950a-9f86-11ed-a8b3-c6bde56990c4', 1, '5', '请假流程_驳回申请人', 0x7B226964223A22726F6F74222C22706172656E744964223A6E756C6C2C2274797065223A22524F4F54222C226E616D65223A22E58F91E8B5B7E4BABA222C2264657363223A22E58F91E8B5B7E4BABA222C2270726F7073223A7B2261737369676E656455736572223A5B5D2C22666F726D5065726D73223A5B5D7D2C226368696C6472656E223A7B226964223A226E6F64655F323237323732333231383234222C22706172656E744964223A22726F6F74222C2270726F7073223A7B7D2C2274797065223A22434F4E444954494F4E53222C226E616D65223A22E69DA1E4BBB6E58886E694AF222C226368696C6472656E223A7B226964223A226E6F64655F323237323732333237303238222C22706172656E744964223A226E6F64655F323237323732333231383234222C2274797065223A22454D505459222C226368696C6472656E223A7B226964223A226E6F64655F303538393935303035303931222C22706172656E744964223A226E6F64655F323237323732333237303238222C2270726F7073223A7B2261737369676E656454797065223A2241535349474E5F55534552222C226D6F6465223A22414E44222C227369676E223A66616C73652C226E6F626F6479223A7B2274797065223A22544F5F50415353222C2261737369676E656455736572223A5B5D7D2C2274696D654C696D6974223A7B2274696D656F7574223A7B22756E6974223A2248222C2276616C7565223A307D2C2268616E646C6572223A7B2274797065223A22524546555345222C226E6F74696679223A7B226F6E6365223A747275652C22686F7572223A317D7D7D2C2261737369676E656455736572223A5B7B22757365724964223A2232222C226E69636B4E616D65223A22E6B58BE8AF95303031222C2273656C6563746564223A66616C73657D5D2C22666F726D5065726D73223A5B5D2C2273656C6653656C656374223A7B226D756C7469706C65223A66616C73657D2C226C6561646572546F70223A7B22656E64436F6E646974696F6E223A22544F50222C22656E644C6576656C223A317D2C226C6561646572223A7B226C6576656C223A317D2C22726F6C65223A5B5D2C22726566757365223A7B2274797065223A22544F5F454E44222C22746172676574223A22227D2C22666F726D55736572223A22227D2C2274797065223A22415050524F56414C222C226E616D65223A22E5AEA1E689B9E4BABA2D41222C226368696C6472656E223A7B226964223A226E6F64655F393738393038393736323439222C22706172656E744964223A226E6F64655F303538393935303035303931222C2270726F7073223A7B2261737369676E656454797065223A2241535349474E5F55534552222C226D6F6465223A22414E44222C227369676E223A66616C73652C226E6F626F6479223A7B2274797065223A22544F5F524546555345222C2261737369676E656455736572223A5B5D7D2C2274696D654C696D6974223A7B2274696D656F7574223A7B22756E6974223A2248222C2276616C7565223A307D2C2268616E646C6572223A7B2274797065223A22524546555345222C226E6F74696679223A7B226F6E6365223A747275652C22686F7572223A317D7D7D2C2261737369676E656455736572223A5B7B22757365724964223A2232222C226E69636B4E616D65223A22E6B58BE8AF95303031222C2273656C6563746564223A66616C73657D5D2C22666F726D5065726D73223A5B5D2C2273656C6653656C656374223A7B226D756C7469706C65223A66616C73657D2C226C6561646572546F70223A7B22656E64436F6E646974696F6E223A22544F50222C22656E644C6576656C223A317D2C226C6561646572223A7B226C6576656C223A317D2C22726F6C65223A5B5D2C22726566757365223A7B2274797065223A22544F5F5355424D4954544552222C22746172676574223A22227D2C22666F726D55736572223A22227D2C2274797065223A22415050524F56414C222C226E616D65223A22E5AEA1E689B9E4BABA42222C226368696C6472656E223A7B226964223A226E6F64655F353930383930393532363232222C22706172656E744964223A226E6F64655F393738393038393736323439222C2270726F7073223A7B2261737369676E656454797065223A2241535349474E5F55534552222C226D6F6465223A22414E44222C227369676E223A66616C73652C226E6F626F6479223A7B2274797065223A22544F5F50415353222C2261737369676E656455736572223A5B5D7D2C2274696D654C696D6974223A7B2274696D656F7574223A7B22756E6974223A2248222C2276616C7565223A307D2C2268616E646C6572223A7B2274797065223A22524546555345222C226E6F74696679223A7B226F6E6365223A747275652C22686F7572223A317D7D7D2C2261737369676E656455736572223A5B7B22757365724964223A2232222C226E69636B4E616D65223A22E6B58BE8AF95303031222C2273656C6563746564223A66616C73657D5D2C22666F726D5065726D73223A5B5D2C2273656C6653656C656374223A7B226D756C7469706C65223A66616C73657D2C226C6561646572546F70223A7B22656E64436F6E646974696F6E223A22544F50222C22656E644C6576656C223A317D2C226C6561646572223A7B226C6576656C223A317D2C22726F6C65223A5B5D2C22726566757365223A7B2274797065223A22544F5F4245464F5245222C22746172676574223A22227D2C22666F726D55736572223A22227D2C2274797065223A22415050524F56414C222C226E616D65223A22E5AEA1E689B9E4BABA2D43222C226368696C6472656E223A7B226964223A226E6F64655F656E645F313233222C2274797065223A22454E44222C226368696C6472656E223A7B7D2C22706172656E744964223A226E6F64655F353930383930393532363232227D7D7D7D7D2C226272616E636873223A5B7B226964223A226E6F64655F323237323732333237303839222C22706172656E744964223A226E6F64655F323237323732333231383234222C2274797065223A22434F4E444954494F4E222C2270726F7073223A7B2267726F75707354797065223A224F52222C2267726F757073223A5B7B227661726961626C654964223A2231222C227661726961626C655469746C65223A22E5BD93E69C88E8AFB7E58187E5A4A9E695B0222C226F70657261746F72223A223E222C2276616C7565223A2233222C2267726F757054797065223A224F52222C227661726961626C65436F6465223A226C656176654461797343757272656E744D6F6E7468227D5D2C2265787072657373696F6E223A22227D2C226E616D65223A22E69DA1E4BBB631222C226368696C6472656E223A7B226964223A226E6F64655F313636323135383636343730222C22706172656E744964223A226E6F64655F323237323732333237303839222C2270726F7073223A7B2273686F756C64416464223A66616C73652C2261737369676E656455736572223A5B7B22757365724964223A2231222C226E69636B4E616D65223A22E7AEA1E79086E59198222C2273656C6563746564223A66616C73657D5D2C22666F726D5065726D73223A5B5D7D2C2274797065223A224343222C226E616D65223A22E68A84E98081E4BABA222C226368696C6472656E223A7B7D7D7D2C7B226964223A226E6F64655F323237323732333239383734222C22706172656E744964223A226E6F64655F323237323732333231383234222C2274797065223A22434F4E444954494F4E222C2270726F7073223A7B2267726F75707354797065223A224F52222C2267726F757073223A5B7B227661726961626C654964223A2231222C227661726961626C655469746C65223A22E5BD93E69C88E8AFB7E58187E5A4A9E695B0222C226F70657261746F72223A223C3D222C2276616C7565223A2233222C2267726F757054797065223A224F52222C227661726961626C65436F6465223A226C656176654461797343757272656E744D6F6E7468227D5D2C2265787072657373696F6E223A22227D2C226E616D65223A22E69DA1E4BBB632222C226368696C6472656E223A7B7D7D5D7D7D, 0x7B22726F6F74223A7B2261737369676E656455736572223A5B5D2C22666F726D5065726D73223A5B5D7D2C226E6F64655F323237323732333231383234223A7B7D2C226E6F64655F323237323732333237303839223A7B2267726F75707354797065223A224F52222C2267726F757073223A5B7B227661726961626C654964223A2231222C227661726961626C655469746C65223A22E5BD93E69C88E8AFB7E58187E5A4A9E695B0222C226F70657261746F72223A223E222C2276616C7565223A2233222C2267726F757054797065223A224F52222C227661726961626C65436F6465223A226C656176654461797343757272656E744D6F6E7468227D5D2C2265787072657373696F6E223A22227D2C226E6F64655F313636323135383636343730223A7B2273686F756C64416464223A66616C73652C2261737369676E656455736572223A5B7B22757365724964223A2231222C226E69636B4E616D65223A22E7AEA1E79086E59198222C2273656C6563746564223A66616C73657D5D2C22666F726D5065726D73223A5B5D7D2C226E6F64655F323237323732333239383734223A7B2267726F75707354797065223A224F52222C2267726F757073223A5B7B227661726961626C654964223A2231222C227661726961626C655469746C65223A22E5BD93E69C88E8AFB7E58187E5A4A9E695B0222C226F70657261746F72223A223C3D222C2276616C7565223A2233222C2267726F757054797065223A224F52222C227661726961626C65436F6465223A226C656176654461797343757272656E744D6F6E7468227D5D2C2265787072657373696F6E223A22227D2C226E6F64655F303538393935303035303931223A7B2261737369676E656454797065223A2241535349474E5F55534552222C226D6F6465223A22414E44222C227369676E223A66616C73652C226E6F626F6479223A7B2274797065223A22544F5F50415353222C2261737369676E656455736572223A5B5D7D2C2274696D654C696D6974223A7B2274696D656F7574223A7B22756E6974223A2248222C2276616C7565223A307D2C2268616E646C6572223A7B2274797065223A22524546555345222C226E6F74696679223A7B226F6E6365223A747275652C22686F7572223A317D7D7D2C2261737369676E656455736572223A5B7B22757365724964223A2232222C226E69636B4E616D65223A22E6B58BE8AF95303031222C2273656C6563746564223A66616C73657D5D2C22666F726D5065726D73223A5B5D2C2273656C6653656C656374223A7B226D756C7469706C65223A66616C73657D2C226C6561646572546F70223A7B22656E64436F6E646974696F6E223A22544F50222C22656E644C6576656C223A317D2C226C6561646572223A7B226C6576656C223A317D2C22726F6C65223A5B5D2C22726566757365223A7B2274797065223A22544F5F454E44222C22746172676574223A22227D2C22666F726D55736572223A22227D2C226E6F64655F393738393038393736323439223A7B2261737369676E656454797065223A2241535349474E5F55534552222C226D6F6465223A22414E44222C227369676E223A66616C73652C226E6F626F6479223A7B2274797065223A22544F5F524546555345222C2261737369676E656455736572223A5B5D7D2C2274696D654C696D6974223A7B2274696D656F7574223A7B22756E6974223A2248222C2276616C7565223A307D2C2268616E646C6572223A7B2274797065223A22524546555345222C226E6F74696679223A7B226F6E6365223A747275652C22686F7572223A317D7D7D2C2261737369676E656455736572223A5B7B22757365724964223A2232222C226E69636B4E616D65223A22E6B58BE8AF95303031222C2273656C6563746564223A66616C73657D5D2C22666F726D5065726D73223A5B5D2C2273656C6653656C656374223A7B226D756C7469706C65223A66616C73657D2C226C6561646572546F70223A7B22656E64436F6E646974696F6E223A22544F50222C22656E644C6576656C223A317D2C226C6561646572223A7B226C6576656C223A317D2C22726F6C65223A5B5D2C22726566757365223A7B2274797065223A22544F5F5355424D4954544552222C22746172676574223A22227D2C22666F726D55736572223A22227D2C226E6F64655F353930383930393532363232223A7B2261737369676E656454797065223A2241535349474E5F55534552222C226D6F6465223A22414E44222C227369676E223A66616C73652C226E6F626F6479223A7B2274797065223A22544F5F50415353222C2261737369676E656455736572223A5B5D7D2C2274696D654C696D6974223A7B2274696D656F7574223A7B22756E6974223A2248222C2276616C7565223A307D2C2268616E646C6572223A7B2274797065223A22524546555345222C226E6F74696679223A7B226F6E6365223A747275652C22686F7572223A317D7D7D2C2261737369676E656455736572223A5B7B22757365724964223A2232222C226E69636B4E616D65223A22E6B58BE8AF95303031222C2273656C6563746564223A66616C73657D5D2C22666F726D5065726D73223A5B5D2C2273656C6653656C656374223A7B226D756C7469706C65223A66616C73657D2C226C6561646572546F70223A7B22656E64436F6E646974696F6E223A22544F50222C22656E644C6576656C223A317D2C226C6561646572223A7B226C6576656C223A317D2C22726F6C65223A5B5D2C22726566757365223A7B2274797065223A22544F5F4245464F5245222C22746172676574223A22227D2C22666F726D55736572223A22227D7D, '[{"variableId":"1","variableTitle":"当月请假天数","operator":">","value":"3","groupType":"OR","variableCode":"leaveDaysCurrentMonth"},{"variableId":"1","variableTitle":"当月请假天数","operator":"<=","value":"3","groupType":"OR","variableCode":"leaveDaysCurrentMonth"}]', '2023-01-29 11:41:22', null, null, null, null, '2022-11-18 16:03:22', null, null, null);
INSERT INTO rouyi.t_act_expand_process (id, act_process_id, act_deployment_id, status, version, name, source, node_props, variable, deploy_time, tenant_id, notify_type, notify_title, remark, create_time, update_time, create_user, update_user) VALUES (3, 'LEAVE3:2:937bb52a-9fad-11ed-8ef9-c6bde56990c4', '93717bf8-9fad-11ed-8ef9-c6bde56990c4', 1, '2', '请假流程002', 0x7B226964223A22726F6F74222C22706172656E744964223A6E756C6C2C2274797065223A22524F4F54222C226E616D65223A22E58F91E8B5B7E4BABA222C2264657363223A22E58F91E8B5B7E4BABA222C2270726F7073223A7B2261737369676E656455736572223A5B5D2C22666F726D5065726D73223A5B5D7D2C226368696C6472656E223A7B226964223A226E6F64655F323237323732333231383234222C22706172656E744964223A22726F6F74222C2270726F7073223A7B7D2C2274797065223A22434F4E444954494F4E53222C226E616D65223A22E69DA1E4BBB6E58886E694AF222C226368696C6472656E223A7B226964223A226E6F64655F323237323732333237303238222C22706172656E744964223A226E6F64655F323237323732333231383234222C2274797065223A22454D505459222C226368696C6472656E223A7B226964223A226E6F64655F393738393038393736323439222C22706172656E744964223A226E6F64655F323237323732333237303238222C2270726F7073223A7B2261737369676E656454797065223A2241535349474E5F55534552222C226D6F6465223A22414E44222C227369676E223A66616C73652C226E6F626F6479223A7B2274797065223A22544F5F50415353222C2261737369676E656455736572223A5B5D7D2C2274696D654C696D6974223A7B2274696D656F7574223A7B22756E6974223A2248222C2276616C7565223A307D2C2268616E646C6572223A7B2274797065223A22524546555345222C226E6F74696679223A7B226F6E6365223A747275652C22686F7572223A317D7D7D2C2261737369676E656455736572223A5B7B22757365724964223A2232222C226E69636B4E616D65223A22E6B58BE8AF95303031222C2273656C6563746564223A66616C73657D5D2C22666F726D5065726D73223A5B5D2C2273656C6653656C656374223A7B226D756C7469706C65223A66616C73657D2C226C6561646572546F70223A7B22656E64436F6E646974696F6E223A22544F50222C22656E644C6576656C223A317D2C226C6561646572223A7B226C6576656C223A317D2C22726F6C65223A5B5D2C22726566757365223A7B2274797065223A22544F5F454E44222C22746172676574223A22227D2C22666F726D55736572223A22227D2C2274797065223A22415050524F56414C222C226E616D65223A22E5AEA1E689B9E4BABA222C226368696C6472656E223A7B226964223A226E6F64655F656E645F313233222C2274797065223A22454E44222C226368696C6472656E223A7B7D2C22706172656E744964223A226E6F64655F393738393038393736323439227D7D7D2C226272616E636873223A5B7B226964223A226E6F64655F323237323732333237303839222C22706172656E744964223A226E6F64655F323237323732333231383234222C2274797065223A22434F4E444954494F4E222C2270726F7073223A7B2267726F75707354797065223A224F52222C2267726F757073223A5B7B227661726961626C654964223A2231222C227661726961626C655469746C65223A22E5BD93E69C88E8AFB7E58187E5A4A9E695B0222C226F70657261746F72223A223E222C2276616C7565223A2233222C2267726F757054797065223A224F52222C227661726961626C65436F6465223A226C656176654461797343757272656E744D6F6E7468227D5D2C2265787072657373696F6E223A22227D2C226E616D65223A22E69DA1E4BBB631222C226368696C6472656E223A7B226964223A226E6F64655F313636323135383636343730222C22706172656E744964223A226E6F64655F323237323732333237303839222C2270726F7073223A7B2273686F756C64416464223A66616C73652C2261737369676E656455736572223A5B7B22757365724964223A2231222C226E69636B4E616D65223A22E7AEA1E79086E59198222C2273656C6563746564223A66616C73657D5D2C22666F726D5065726D73223A5B5D7D2C2274797065223A224343222C226E616D65223A22E68A84E98081E4BABA222C226368696C6472656E223A7B7D7D7D2C7B226964223A226E6F64655F323237323732333239383734222C22706172656E744964223A226E6F64655F323237323732333231383234222C2274797065223A22434F4E444954494F4E222C2270726F7073223A7B2267726F75707354797065223A224F52222C2267726F757073223A5B7B227661726961626C654964223A2231222C227661726961626C655469746C65223A22E5BD93E69C88E8AFB7E58187E5A4A9E695B0222C226F70657261746F72223A223C3D222C2276616C7565223A2233222C2267726F757054797065223A224F52222C227661726961626C65436F6465223A226C656176654461797343757272656E744D6F6E7468227D5D2C2265787072657373696F6E223A22227D2C226E616D65223A22E69DA1E4BBB632222C226368696C6472656E223A7B7D7D5D7D7D, 0x7B22726F6F74223A7B2261737369676E656455736572223A5B5D2C22666F726D5065726D73223A5B5D7D2C226E6F64655F323237323732333231383234223A7B7D2C226E6F64655F323237323732333237303839223A7B2267726F75707354797065223A224F52222C2267726F757073223A5B7B227661726961626C654964223A2231222C227661726961626C655469746C65223A22E5BD93E69C88E8AFB7E58187E5A4A9E695B0222C226F70657261746F72223A223E222C2276616C7565223A2233222C2267726F757054797065223A224F52222C227661726961626C65436F6465223A226C656176654461797343757272656E744D6F6E7468227D5D2C2265787072657373696F6E223A22227D2C226E6F64655F313636323135383636343730223A7B2273686F756C64416464223A66616C73652C2261737369676E656455736572223A5B7B22757365724964223A2231222C226E69636B4E616D65223A22E7AEA1E79086E59198222C2273656C6563746564223A66616C73657D5D2C22666F726D5065726D73223A5B5D7D2C226E6F64655F323237323732333239383734223A7B2267726F75707354797065223A224F52222C2267726F757073223A5B7B227661726961626C654964223A2231222C227661726961626C655469746C65223A22E5BD93E69C88E8AFB7E58187E5A4A9E695B0222C226F70657261746F72223A223C3D222C2276616C7565223A2233222C2267726F757054797065223A224F52222C227661726961626C65436F6465223A226C656176654461797343757272656E744D6F6E7468227D5D2C2265787072657373696F6E223A22227D2C226E6F64655F393738393038393736323439223A7B2261737369676E656454797065223A2241535349474E5F55534552222C226D6F6465223A22414E44222C227369676E223A66616C73652C226E6F626F6479223A7B2274797065223A22544F5F50415353222C2261737369676E656455736572223A5B5D7D2C2274696D654C696D6974223A7B2274696D656F7574223A7B22756E6974223A2248222C2276616C7565223A307D2C2268616E646C6572223A7B2274797065223A22524546555345222C226E6F74696679223A7B226F6E6365223A747275652C22686F7572223A317D7D7D2C2261737369676E656455736572223A5B7B22757365724964223A2232222C226E69636B4E616D65223A22E6B58BE8AF95303031222C2273656C6563746564223A66616C73657D5D2C22666F726D5065726D73223A5B5D2C2273656C6653656C656374223A7B226D756C7469706C65223A66616C73657D2C226C6561646572546F70223A7B22656E64436F6E646974696F6E223A22544F50222C22656E644C6576656C223A317D2C226C6561646572223A7B226C6576656C223A317D2C22726F6C65223A5B5D2C22726566757365223A7B2274797065223A22544F5F454E44222C22746172676574223A22227D2C22666F726D55736572223A22227D7D, '[{"variableId":"1","variableTitle":"当月请假天数","operator":">","value":"3","groupType":"OR","variableCode":"leaveDaysCurrentMonth"},{"variableId":"1","variableTitle":"当月请假天数","operator":"<=","value":"3","groupType":"OR","variableCode":"leaveDaysCurrentMonth"}]', '2023-01-29 16:18:57', null, null, null, null, '2022-11-18 16:03:22', null, null, null);
INSERT INTO rouyi.t_act_expand_process (id, act_process_id, act_deployment_id, status, version, name, source, node_props, variable, deploy_time, tenant_id, notify_type, notify_title, remark, create_time, update_time, create_user, update_user) VALUES (4, 'LEAVE4:1:9f2f805d-a84a-11ed-96b5-c6bde56990c4', '9f20170b-a84a-11ed-96b5-c6bde56990c4', 1, '1', '多审批人--测试', 0x7B226964223A22726F6F74222C22706172656E744964223A6E756C6C2C2274797065223A22524F4F54222C226E616D65223A22E58F91E8B5B7E4BABA222C2264657363223A22E58F91E8B5B7E4BABA222C2270726F7073223A7B2261737369676E656455736572223A5B5D2C22666F726D5065726D73223A5B5D7D2C226368696C6472656E223A7B226964223A226E6F64655F323137313138383838383334222C22706172656E744964223A22726F6F74222C2270726F7073223A7B2261737369676E656454797065223A2241535349474E5F55534552222C226D6F6465223A224E455854222C227369676E223A66616C73652C226E6F626F6479223A7B2274797065223A22544F5F50415353222C2261737369676E656455736572223A5B5D7D2C2274696D654C696D6974223A7B2274696D656F7574223A7B22756E6974223A2248222C2276616C7565223A307D2C2268616E646C6572223A7B2274797065223A22524546555345222C226E6F74696679223A7B226F6E6365223A747275652C22686F7572223A317D7D7D2C2261737369676E656455736572223A5B7B22757365724964223A2232222C226E69636B4E616D65223A22E6B58BE8AF95303031222C2273656C6563746564223A66616C73657D2C7B22757365724964223A22313030222C226E69636B4E616D65223A227A68616E6773616E222C2273656C6563746564223A66616C73657D2C7B22757365724964223A22313031222C226E69636B4E616D65223A226C697369222C2273656C6563746564223A66616C73657D5D2C22666F726D5065726D73223A5B5D2C2273656C6653656C656374223A7B226D756C7469706C65223A66616C73657D2C226C6561646572546F70223A7B22656E64436F6E646974696F6E223A22544F50222C22656E644C6576656C223A317D2C226C6561646572223A7B226C6576656C223A317D2C22726F6C65223A5B5D2C22726566757365223A7B2274797065223A22544F5F454E44222C22746172676574223A22227D2C22666F726D55736572223A22222C226D756C7469436F6D706C65746564436F756E74223A317D2C2274797065223A22415050524F56414C222C226E616D65223A22E5AEA1E689B9E4BABA222C226368696C6472656E223A7B226964223A226E6F64655F656E645F313233222C2274797065223A22454E44222C226368696C6472656E223A7B7D2C22706172656E744964223A226E6F64655F323137313138383838383334227D7D7D, 0x7B22726F6F74223A7B2261737369676E656455736572223A5B5D2C22666F726D5065726D73223A5B5D7D2C226E6F64655F323137313138383838383334223A7B2261737369676E656454797065223A2241535349474E5F55534552222C226D6F6465223A224E455854222C227369676E223A66616C73652C226E6F626F6479223A7B2274797065223A22544F5F50415353222C2261737369676E656455736572223A5B5D7D2C2274696D654C696D6974223A7B2274696D656F7574223A7B22756E6974223A2248222C2276616C7565223A307D2C2268616E646C6572223A7B2274797065223A22524546555345222C226E6F74696679223A7B226F6E6365223A747275652C22686F7572223A317D7D7D2C2261737369676E656455736572223A5B7B22757365724964223A2232222C226E69636B4E616D65223A22E6B58BE8AF95303031222C2273656C6563746564223A66616C73657D2C7B22757365724964223A22313030222C226E69636B4E616D65223A227A68616E6773616E222C2273656C6563746564223A66616C73657D2C7B22757365724964223A22313031222C226E69636B4E616D65223A226C697369222C2273656C6563746564223A66616C73657D5D2C22666F726D5065726D73223A5B5D2C2273656C6653656C656374223A7B226D756C7469706C65223A66616C73657D2C226C6561646572546F70223A7B22656E64436F6E646974696F6E223A22544F50222C22656E644C6576656C223A317D2C226C6561646572223A7B226C6576656C223A317D2C22726F6C65223A5B5D2C22726566757365223A7B2274797065223A22544F5F454E44222C22746172676574223A22227D2C22666F726D55736572223A22222C226D756C7469436F6D706C65746564436F756E74223A317D7D, '[]', '2023-02-09 15:23:17', null, null, null, null, '2023-02-09 06:03:38', null, null, null);
INSERT INTO rouyi.t_act_expand_process (id, act_process_id, act_deployment_id, status, version, name, source, node_props, variable, deploy_time, tenant_id, notify_type, notify_title, remark, create_time, update_time, create_user, update_user) VALUES (7, 'LEAVE7:1:3ea50912-a84b-11ed-96b5-c6bde56990c4', '3ea1fbd0-a84b-11ed-96b5-c6bde56990c4', 1, '1', '多人审批-会签同时审批', 0x7B226964223A22726F6F74222C22706172656E744964223A6E756C6C2C2274797065223A22524F4F54222C226E616D65223A22E58F91E8B5B7E4BABA222C2264657363223A22E58F91E8B5B7E4BABA222C2270726F7073223A7B2261737369676E656455736572223A5B5D2C22666F726D5065726D73223A5B5D7D2C226368696C6472656E223A7B226964223A226E6F64655F323736343935313736383534222C22706172656E744964223A22726F6F74222C2270726F7073223A7B2261737369676E656454797065223A2241535349474E5F55534552222C226D6F6465223A22414E44222C227369676E223A66616C73652C226D756C7469436F6D706C65746564436F756E74223A312C226E6F626F6479223A7B2274797065223A22544F5F50415353222C2261737369676E656455736572223A5B5D7D2C2274696D654C696D6974223A7B2274696D656F7574223A7B22756E6974223A2248222C2276616C7565223A307D2C2268616E646C6572223A7B2274797065223A22524546555345222C226E6F74696679223A7B226F6E6365223A747275652C22686F7572223A317D7D7D2C2261737369676E656455736572223A5B7B22757365724964223A2232222C226E69636B4E616D65223A22E6B58BE8AF95303031222C2273656C6563746564223A66616C73657D2C7B22757365724964223A22313030222C226E69636B4E616D65223A227A68616E6773616E222C2273656C6563746564223A66616C73657D2C7B22757365724964223A22313031222C226E69636B4E616D65223A226C697369222C2273656C6563746564223A66616C73657D5D2C22666F726D5065726D73223A5B5D2C2273656C6653656C656374223A7B226D756C7469706C65223A66616C73657D2C226C6561646572546F70223A7B22656E64436F6E646974696F6E223A22544F50222C22656E644C6576656C223A317D2C226C6561646572223A7B226C6576656C223A317D2C22726F6C65223A5B5D2C22726566757365223A7B2274797065223A22544F5F454E44222C22746172676574223A22227D2C22666F726D55736572223A22227D2C2274797065223A22415050524F56414C222C226E616D65223A22E5AEA1E689B9E4BABA222C226368696C6472656E223A7B226964223A226E6F64655F656E645F313233222C2274797065223A22454E44222C226368696C6472656E223A7B7D2C22706172656E744964223A226E6F64655F323736343935313736383534227D7D7D, 0x7B22726F6F74223A7B2261737369676E656455736572223A5B5D2C22666F726D5065726D73223A5B5D7D2C226E6F64655F323736343935313736383534223A7B2261737369676E656454797065223A2241535349474E5F55534552222C226D6F6465223A22414E44222C227369676E223A66616C73652C226D756C7469436F6D706C65746564436F756E74223A312C226E6F626F6479223A7B2274797065223A22544F5F50415353222C2261737369676E656455736572223A5B5D7D2C2274696D654C696D6974223A7B2274696D656F7574223A7B22756E6974223A2248222C2276616C7565223A307D2C2268616E646C6572223A7B2274797065223A22524546555345222C226E6F74696679223A7B226F6E6365223A747275652C22686F7572223A317D7D7D2C2261737369676E656455736572223A5B7B22757365724964223A2232222C226E69636B4E616D65223A22E6B58BE8AF95303031222C2273656C6563746564223A66616C73657D2C7B22757365724964223A22313030222C226E69636B4E616D65223A227A68616E6773616E222C2273656C6563746564223A66616C73657D2C7B22757365724964223A22313031222C226E69636B4E616D65223A226C697369222C2273656C6563746564223A66616C73657D5D2C22666F726D5065726D73223A5B5D2C2273656C6653656C656374223A7B226D756C7469706C65223A66616C73657D2C226C6561646572546F70223A7B22656E64436F6E646974696F6E223A22544F50222C22656E644C6576656C223A317D2C226C6561646572223A7B226C6576656C223A317D2C22726F6C65223A5B5D2C22726566757365223A7B2274797065223A22544F5F454E44222C22746172676574223A22227D2C22666F726D55736572223A22227D7D, '[]', '2023-02-09 15:27:44', null, null, null, null, '2023-02-09 07:27:44', null, null, null);
INSERT INTO rouyi.t_act_expand_process (id, act_process_id, act_deployment_id, status, version, name, source, node_props, variable, deploy_time, tenant_id, notify_type, notify_title, remark, create_time, update_time, create_user, update_user) VALUES (8, 'LEAVE_8:6:befa3a09-a860-11ed-883b-c6bde56990c4', 'bef4e2d7-a860-11ed-883b-c6bde56990c4', 1, '6', '测试-限时审批', 0x7B226964223A22726F6F74222C22706172656E744964223A6E756C6C2C2274797065223A22524F4F54222C226E616D65223A22E58F91E8B5B7E4BABA222C2264657363223A22E58F91E8B5B7E4BABA222C2270726F7073223A7B2261737369676E656455736572223A5B5D2C22666F726D5065726D73223A5B5D7D2C226368696C6472656E223A7B226964223A226E6F64655F333037313430353237383635222C22706172656E744964223A22726F6F74222C2270726F7073223A7B2261737369676E656454797065223A2241535349474E5F55534552222C226D6F6465223A22414E44222C227369676E223A66616C73652C226D756C7469436F6D706C65746564436F756E74223A312C226E6F626F6479223A7B2274797065223A22544F5F50415353222C2261737369676E656455736572223A5B5D7D2C2274696D654C696D6974223A7B2274696D656F7574223A7B22756E6974223A2248222C2276616C7565223A2231227D2C2268616E646C6572223A7B2274797065223A224E4F54494659222C226E6F74696679223A7B226F6E6365223A66616C73652C22686F7572223A317D7D7D2C2261737369676E656455736572223A5B7B22757365724964223A2232222C226E69636B4E616D65223A22E6B58BE8AF95303031222C2273656C6563746564223A66616C73657D5D2C22666F726D5065726D73223A5B5D2C2273656C6653656C656374223A7B226D756C7469706C65223A66616C73657D2C226C6561646572546F70223A7B22656E64436F6E646974696F6E223A22544F50222C22656E644C6576656C223A317D2C226C6561646572223A7B226C6576656C223A317D2C22726F6C65223A5B5D2C22726566757365223A7B2274797065223A22544F5F454E44222C22746172676574223A22227D2C22666F726D55736572223A22227D2C2274797065223A22415050524F56414C222C226E616D65223A22E5AEA1E689B9E4BABA222C226368696C6472656E223A7B226964223A226E6F64655F656E645F313233222C2274797065223A22454E44222C226368696C6472656E223A7B7D2C22706172656E744964223A226E6F64655F333037313430353237383635227D7D7D, 0x7B22726F6F74223A7B2261737369676E656455736572223A5B5D2C22666F726D5065726D73223A5B5D7D2C226E6F64655F333037313430353237383635223A7B2261737369676E656454797065223A2241535349474E5F55534552222C226D6F6465223A22414E44222C227369676E223A66616C73652C226D756C7469436F6D706C65746564436F756E74223A312C226E6F626F6479223A7B2274797065223A22544F5F50415353222C2261737369676E656455736572223A5B5D7D2C2274696D654C696D6974223A7B2274696D656F7574223A7B22756E6974223A2248222C2276616C7565223A2231227D2C2268616E646C6572223A7B2274797065223A224E4F54494659222C226E6F74696679223A7B226F6E6365223A66616C73652C22686F7572223A317D7D7D2C2261737369676E656455736572223A5B7B22757365724964223A2232222C226E69636B4E616D65223A22E6B58BE8AF95303031222C2273656C6563746564223A66616C73657D5D2C22666F726D5065726D73223A5B5D2C2273656C6653656C656374223A7B226D756C7469706C65223A66616C73657D2C226C6561646572546F70223A7B22656E64436F6E646974696F6E223A22544F50222C22656E644C6576656C223A317D2C226C6561646572223A7B226C6576656C223A317D2C22726F6C65223A5B5D2C22726566757365223A7B2274797065223A22544F5F454E44222C22746172676574223A22227D2C22666F726D55736572223A22227D7D, '[]', '2023-02-09 18:01:39', null, null, null, null, '2023-02-09 08:19:30', null, null, null);


INSERT INTO rouyi.t_act_expand_process_variable (id, code, title, status, description, bean, invoke_target, create_time, update_time) VALUES (1, 'leaveDaysCurrentMonth', '当月请假天数', null, '当月请假天数', 'workflowVariableInvokeService', 'leaveDaysCurrentMonth', '2022-11-30 10:20:14', null);
INSERT INTO rouyi.t_act_expand_process_variable (id, code, title, status, description, bean, invoke_target, create_time, update_time) VALUES (2, 'as', '测试', null, 'sf', 'workflowVariableInvokeService', 'leaveDaysCurrentMonth', '2022-12-01 08:35:19', null);


INSERT INTO rouyi.t_act_hi_expand_process (id, expand_process_id, act_process_id, act_deployment_id, status, version, name, source, node_props, variable, deploy_time, tenant_id, notify_type, notify_title, remark, create_time, update_time, create_user, update_user) VALUES (1, 3, 'LEAVE:17:aaabe0e0-76c1-11ed-b6cb-c6bde56990c4', 'aa99915e-76c1-11ed-b6cb-c6bde56990c4', 1, '17', '请假流程002', 0x7B226964223A22726F6F74222C22706172656E744964223A6E756C6C2C2274797065223A22524F4F54222C226E616D65223A22E58F91E8B5B7E4BABA222C2264657363223A22E58F91E8B5B7E4BABA222C2270726F7073223A7B2261737369676E656455736572223A5B5D2C22666F726D5065726D73223A5B5D7D2C226368696C6472656E223A7B226964223A226E6F64655F323237323732333231383234222C22706172656E744964223A22726F6F74222C2270726F7073223A7B7D2C2274797065223A22434F4E444954494F4E53222C226E616D65223A22E69DA1E4BBB6E58886E694AF222C226368696C6472656E223A7B226964223A226E6F64655F323237323732333237303238222C22706172656E744964223A226E6F64655F323237323732333231383234222C2274797065223A22454D505459222C226368696C6472656E223A7B226964223A226E6F64655F393738393038393736323439222C22706172656E744964223A226E6F64655F323237323732333237303238222C2270726F7073223A7B2261737369676E656454797065223A2241535349474E5F55534552222C226D6F6465223A22414E44222C227369676E223A66616C73652C226E6F626F6479223A7B2274797065223A22544F5F50415353222C2261737369676E656455736572223A5B5D7D2C2274696D654C696D6974223A7B2274696D656F7574223A7B22756E6974223A2248222C2276616C7565223A307D2C2268616E646C6572223A7B2274797065223A22524546555345222C226E6F74696679223A7B226F6E6365223A747275652C22686F7572223A317D7D7D2C2261737369676E656455736572223A5B7B22757365724964223A2232222C226E69636B4E616D65223A22E6B58BE8AF95303031222C2273656C6563746564223A66616C73657D5D2C22666F726D5065726D73223A5B5D2C2273656C6653656C656374223A7B226D756C7469706C65223A66616C73657D2C226C6561646572546F70223A7B22656E64436F6E646974696F6E223A22544F50222C22656E644C6576656C223A317D2C226C6561646572223A7B226C6576656C223A317D2C22726F6C65223A5B5D2C22726566757365223A7B2274797065223A22544F5F454E44222C22746172676574223A22227D2C22666F726D55736572223A22227D2C2274797065223A22415050524F56414C222C226E616D65223A22E5AEA1E689B9E4BABA222C226368696C6472656E223A7B226964223A226E6F64655F656E645F313233222C2274797065223A22454E44222C226368696C6472656E223A7B7D2C22706172656E744964223A226E6F64655F393738393038393736323439227D7D7D2C226272616E636873223A5B7B226964223A226E6F64655F323237323732333237303839222C22706172656E744964223A226E6F64655F323237323732333231383234222C2274797065223A22434F4E444954494F4E222C2270726F7073223A7B2267726F75707354797065223A224F52222C2267726F757073223A5B7B227661726961626C654964223A2231222C227661726961626C655469746C65223A22E5BD93E69C88E8AFB7E58187E5A4A9E695B0222C226F70657261746F72223A223E222C2276616C7565223A2233222C2267726F757054797065223A224F52222C227661726961626C65436F6465223A226C656176654461797343757272656E744D6F6E7468227D5D2C2265787072657373696F6E223A22227D2C226E616D65223A22E69DA1E4BBB631222C226368696C6472656E223A7B226964223A226E6F64655F313636323135383636343730222C22706172656E744964223A226E6F64655F323237323732333237303839222C2270726F7073223A7B2273686F756C64416464223A66616C73652C2261737369676E656455736572223A5B7B22757365724964223A2231222C226E69636B4E616D65223A22E7AEA1E79086E59198222C2273656C6563746564223A66616C73657D5D2C22666F726D5065726D73223A5B5D7D2C2274797065223A224343222C226E616D65223A22E68A84E98081E4BABA222C226368696C6472656E223A7B7D7D7D2C7B226964223A226E6F64655F323237323732333239383734222C22706172656E744964223A226E6F64655F323237323732333231383234222C2274797065223A22434F4E444954494F4E222C2270726F7073223A7B2267726F75707354797065223A224F52222C2267726F757073223A5B7B227661726961626C654964223A2231222C227661726961626C655469746C65223A22E5BD93E69C88E8AFB7E58187E5A4A9E695B0222C226F70657261746F72223A223C3D222C2276616C7565223A2233222C2267726F757054797065223A224F52222C227661726961626C65436F6465223A226C656176654461797343757272656E744D6F6E7468227D5D2C2265787072657373696F6E223A22227D2C226E616D65223A22E69DA1E4BBB632222C226368696C6472656E223A7B7D7D5D7D7D, 0x7B22726F6F74223A7B2261737369676E656455736572223A5B5D2C22666F726D5065726D73223A5B5D7D2C226E6F64655F323237323732333231383234223A7B7D2C226E6F64655F323237323732333237303839223A7B2267726F75707354797065223A224F52222C2267726F757073223A5B7B227661726961626C654964223A2231222C227661726961626C655469746C65223A22E5BD93E69C88E8AFB7E58187E5A4A9E695B0222C226F70657261746F72223A223E222C2276616C7565223A2233222C2267726F757054797065223A224F52222C227661726961626C65436F6465223A226C656176654461797343757272656E744D6F6E7468227D5D2C2265787072657373696F6E223A22227D2C226E6F64655F313636323135383636343730223A7B2273686F756C64416464223A66616C73652C2261737369676E656455736572223A5B7B22757365724964223A2231222C226E69636B4E616D65223A22E7AEA1E79086E59198222C2273656C6563746564223A66616C73657D5D2C22666F726D5065726D73223A5B5D7D2C226E6F64655F323237323732333239383734223A7B2267726F75707354797065223A224F52222C2267726F757073223A5B7B227661726961626C654964223A2231222C227661726961626C655469746C65223A22E5BD93E69C88E8AFB7E58187E5A4A9E695B0222C226F70657261746F72223A223C3D222C2276616C7565223A2233222C2267726F757054797065223A224F52222C227661726961626C65436F6465223A226C656176654461797343757272656E744D6F6E7468227D5D2C2265787072657373696F6E223A22227D2C226E6F64655F393738393038393736323439223A7B2261737369676E656454797065223A2241535349474E5F55534552222C226D6F6465223A22414E44222C227369676E223A66616C73652C226E6F626F6479223A7B2274797065223A22544F5F50415353222C2261737369676E656455736572223A5B5D7D2C2274696D654C696D6974223A7B2274696D656F7574223A7B22756E6974223A2248222C2276616C7565223A307D2C2268616E646C6572223A7B2274797065223A22524546555345222C226E6F74696679223A7B226F6E6365223A747275652C22686F7572223A317D7D7D2C2261737369676E656455736572223A5B7B22757365724964223A2232222C226E69636B4E616D65223A22E6B58BE8AF95303031222C2273656C6563746564223A66616C73657D5D2C22666F726D5065726D73223A5B5D2C2273656C6653656C656374223A7B226D756C7469706C65223A66616C73657D2C226C6561646572546F70223A7B22656E64436F6E646974696F6E223A22544F50222C22656E644C6576656C223A317D2C226C6561646572223A7B226C6576656C223A317D2C22726F6C65223A5B5D2C22726566757365223A7B2274797065223A22544F5F454E44222C22746172676574223A22227D2C22666F726D55736572223A22227D7D, '[{"variableId":"1","variableTitle":"当月请假天数","operator":">","value":"3","groupType":"OR","variableCode":"leaveDaysCurrentMonth"},{"variableId":"1","variableTitle":"当月请假天数","operator":"<=","value":"3","groupType":"OR","variableCode":"leaveDaysCurrentMonth"}]', '2022-12-08 14:29:28', null, null, null, null, '2022-11-18 16:03:22', null, null, null);
INSERT INTO rouyi.t_act_hi_expand_process (id, expand_process_id, act_process_id, act_deployment_id, status, version, name, source, node_props, variable, deploy_time, tenant_id, notify_type, notify_title, remark, create_time, update_time, create_user, update_user) VALUES (2, 2, 'LEAVE:14:fb21a2ff-75fb-11ed-8da0-c6bde56990c4', 'fb1a28ed-75fb-11ed-8da0-c6bde56990c4', -1, '0', '请假流程_驳回申请人', 0x7B226964223A22726F6F74222C22706172656E744964223A6E756C6C2C2274797065223A22524F4F54222C226E616D65223A22E58F91E8B5B7E4BABA222C2264657363223A22E58F91E8B5B7E4BABA222C2270726F7073223A7B2261737369676E656455736572223A5B5D2C22666F726D5065726D73223A5B5D7D2C226368696C6472656E223A7B226964223A226E6F64655F323237323732333231383234222C22706172656E744964223A22726F6F74222C2270726F7073223A7B7D2C2274797065223A22434F4E444954494F4E53222C226E616D65223A22E69DA1E4BBB6E58886E694AF222C226368696C6472656E223A7B226964223A226E6F64655F323237323732333237303238222C22706172656E744964223A226E6F64655F323237323732333231383234222C2274797065223A22454D505459222C226368696C6472656E223A7B226964223A226E6F64655F393738393038393736323439222C22706172656E744964223A226E6F64655F323237323732333237303238222C2270726F7073223A7B2261737369676E656454797065223A2241535349474E5F55534552222C226D6F6465223A22414E44222C227369676E223A66616C73652C226E6F626F6479223A7B2274797065223A22544F5F524546555345222C2261737369676E656455736572223A5B5D7D2C2274696D654C696D6974223A7B2274696D656F7574223A7B22756E6974223A2248222C2276616C7565223A307D2C2268616E646C6572223A7B2274797065223A22524546555345222C226E6F74696679223A7B226F6E6365223A747275652C22686F7572223A317D7D7D2C2261737369676E656455736572223A5B7B22757365724964223A2232222C226E69636B4E616D65223A22E6B58BE8AF95303031222C2273656C6563746564223A66616C73657D5D2C22666F726D5065726D73223A5B5D2C2273656C6653656C656374223A7B226D756C7469706C65223A66616C73657D2C226C6561646572546F70223A7B22656E64436F6E646974696F6E223A22544F50222C22656E644C6576656C223A317D2C226C6561646572223A7B226C6576656C223A317D2C22726F6C65223A5B5D2C22726566757365223A7B2274797065223A22544F5F5355424D4954544552222C22746172676574223A22227D2C22666F726D55736572223A22227D2C2274797065223A22415050524F56414C222C226E616D65223A22E5AEA1E689B9E4BABA222C226368696C6472656E223A7B226964223A226E6F64655F656E645F313233222C2274797065223A22454E44222C226368696C6472656E223A7B7D2C22706172656E744964223A226E6F64655F393738393038393736323439227D7D7D2C226272616E636873223A5B7B226964223A226E6F64655F323237323732333237303839222C22706172656E744964223A226E6F64655F323237323732333231383234222C2274797065223A22434F4E444954494F4E222C2270726F7073223A7B2267726F75707354797065223A224F52222C2267726F757073223A5B7B227661726961626C654964223A2231222C227661726961626C655469746C65223A22E5BD93E69C88E8AFB7E58187E5A4A9E695B0222C226F70657261746F72223A223E222C2276616C7565223A2233222C2267726F757054797065223A224F52222C227661726961626C65436F6465223A226C656176654461797343757272656E744D6F6E7468227D5D2C2265787072657373696F6E223A22227D2C226E616D65223A22E69DA1E4BBB631222C226368696C6472656E223A7B226964223A226E6F64655F313636323135383636343730222C22706172656E744964223A226E6F64655F323237323732333237303839222C2270726F7073223A7B2273686F756C64416464223A66616C73652C2261737369676E656455736572223A5B7B22757365724964223A2231222C226E69636B4E616D65223A22E7AEA1E79086E59198222C2273656C6563746564223A66616C73657D5D2C22666F726D5065726D73223A5B5D7D2C2274797065223A224343222C226E616D65223A22E68A84E98081E4BABA222C226368696C6472656E223A7B7D7D7D2C7B226964223A226E6F64655F323237323732333239383734222C22706172656E744964223A226E6F64655F323237323732333231383234222C2274797065223A22434F4E444954494F4E222C2270726F7073223A7B2267726F75707354797065223A224F52222C2267726F757073223A5B7B227661726961626C654964223A2231222C227661726961626C655469746C65223A22E5BD93E69C88E8AFB7E58187E5A4A9E695B0222C226F70657261746F72223A223C3D222C2276616C7565223A2233222C2267726F757054797065223A224F52222C227661726961626C65436F6465223A226C656176654461797343757272656E744D6F6E7468227D5D2C2265787072657373696F6E223A22227D2C226E616D65223A22E69DA1E4BBB632222C226368696C6472656E223A7B7D7D5D7D7D, 0x7B22726F6F74223A7B2261737369676E656455736572223A5B5D2C22666F726D5065726D73223A5B5D7D2C226E6F64655F323237323732333231383234223A7B7D2C226E6F64655F323237323732333237303839223A7B2267726F75707354797065223A224F52222C2267726F757073223A5B7B227661726961626C654964223A2231222C227661726961626C655469746C65223A22E5BD93E69C88E8AFB7E58187E5A4A9E695B0222C226F70657261746F72223A223E222C2276616C7565223A2233222C2267726F757054797065223A224F52222C227661726961626C65436F6465223A226C656176654461797343757272656E744D6F6E7468227D5D2C2265787072657373696F6E223A22227D2C226E6F64655F313636323135383636343730223A7B2273686F756C64416464223A66616C73652C2261737369676E656455736572223A5B7B22757365724964223A2231222C226E69636B4E616D65223A22E7AEA1E79086E59198222C2273656C6563746564223A66616C73657D5D2C22666F726D5065726D73223A5B5D7D2C226E6F64655F323237323732333239383734223A7B2267726F75707354797065223A224F52222C2267726F757073223A5B7B227661726961626C654964223A2231222C227661726961626C655469746C65223A22E5BD93E69C88E8AFB7E58187E5A4A9E695B0222C226F70657261746F72223A223C3D222C2276616C7565223A2233222C2267726F757054797065223A224F52222C227661726961626C65436F6465223A226C656176654461797343757272656E744D6F6E7468227D5D2C2265787072657373696F6E223A22227D2C226E6F64655F393738393038393736323439223A7B2261737369676E656454797065223A2241535349474E5F55534552222C226D6F6465223A22414E44222C227369676E223A66616C73652C226E6F626F6479223A7B2274797065223A22544F5F524546555345222C2261737369676E656455736572223A5B5D7D2C2274696D654C696D6974223A7B2274696D656F7574223A7B22756E6974223A2248222C2276616C7565223A307D2C2268616E646C6572223A7B2274797065223A22524546555345222C226E6F74696679223A7B226F6E6365223A747275652C22686F7572223A317D7D7D2C2261737369676E656455736572223A5B7B22757365724964223A2232222C226E69636B4E616D65223A22E6B58BE8AF95303031222C2273656C6563746564223A66616C73657D5D2C22666F726D5065726D73223A5B5D2C2273656C6653656C656374223A7B226D756C7469706C65223A66616C73657D2C226C6561646572546F70223A7B22656E64436F6E646974696F6E223A22544F50222C22656E644C6576656C223A317D2C226C6561646572223A7B226C6576656C223A317D2C22726F6C65223A5B5D2C22726566757365223A7B2274797065223A22544F5F5355424D4954544552222C22746172676574223A22227D2C22666F726D55736572223A22227D7D, '[{"variableId":"1","variableTitle":"当月请假天数","operator":">","value":"3","groupType":"OR","variableCode":"leaveDaysCurrentMonth"},{"variableId":"1","variableTitle":"当月请假天数","operator":"<=","value":"3","groupType":"OR","variableCode":"leaveDaysCurrentMonth"}]', null, null, null, null, null, '2022-11-18 16:03:22', null, null, null);
INSERT INTO rouyi.t_act_hi_expand_process (id, expand_process_id, act_process_id, act_deployment_id, status, version, name, source, node_props, variable, deploy_time, tenant_id, notify_type, notify_title, remark, create_time, update_time, create_user, update_user) VALUES (3, 2, 'LEAVE:18:bdccac70-9413-11ed-9449-c6bde56990c4', 'bdbf8d0e-9413-11ed-9449-c6bde56990c4', -1, '18', '请假流程_驳回申请人', 0x7B226964223A22726F6F74222C22706172656E744964223A6E756C6C2C2274797065223A22524F4F54222C226E616D65223A22E58F91E8B5B7E4BABA222C2264657363223A22E58F91E8B5B7E4BABA222C2270726F7073223A7B2261737369676E656455736572223A5B5D2C22666F726D5065726D73223A5B5D7D2C226368696C6472656E223A7B226964223A226E6F64655F323237323732333231383234222C22706172656E744964223A22726F6F74222C2270726F7073223A7B7D2C2274797065223A22434F4E444954494F4E53222C226E616D65223A22E69DA1E4BBB6E58886E694AF222C226368696C6472656E223A7B226964223A226E6F64655F323237323732333237303238222C22706172656E744964223A226E6F64655F323237323732333231383234222C2274797065223A22454D505459222C226368696C6472656E223A7B226964223A226E6F64655F393738393038393736323439222C22706172656E744964223A226E6F64655F323237323732333237303238222C2270726F7073223A7B2261737369676E656454797065223A2241535349474E5F55534552222C226D6F6465223A22414E44222C227369676E223A66616C73652C226E6F626F6479223A7B2274797065223A22544F5F524546555345222C2261737369676E656455736572223A5B5D7D2C2274696D654C696D6974223A7B2274696D656F7574223A7B22756E6974223A2248222C2276616C7565223A307D2C2268616E646C6572223A7B2274797065223A22524546555345222C226E6F74696679223A7B226F6E6365223A747275652C22686F7572223A317D7D7D2C2261737369676E656455736572223A5B7B22757365724964223A2232222C226E69636B4E616D65223A22E6B58BE8AF95303031222C2273656C6563746564223A66616C73657D5D2C22666F726D5065726D73223A5B5D2C2273656C6653656C656374223A7B226D756C7469706C65223A66616C73657D2C226C6561646572546F70223A7B22656E64436F6E646974696F6E223A22544F50222C22656E644C6576656C223A317D2C226C6561646572223A7B226C6576656C223A317D2C22726F6C65223A5B5D2C22726566757365223A7B2274797065223A22544F5F5355424D4954544552222C22746172676574223A22227D2C22666F726D55736572223A22227D2C2274797065223A22415050524F56414C222C226E616D65223A22E5AEA1E689B9E4BABA222C226368696C6472656E223A7B226964223A226E6F64655F656E645F313233222C2274797065223A22454E44222C226368696C6472656E223A7B7D2C22706172656E744964223A226E6F64655F393738393038393736323439227D7D7D2C226272616E636873223A5B7B226964223A226E6F64655F323237323732333237303839222C22706172656E744964223A226E6F64655F323237323732333231383234222C2274797065223A22434F4E444954494F4E222C2270726F7073223A7B2267726F75707354797065223A224F52222C2267726F757073223A5B7B227661726961626C654964223A2231222C227661726961626C655469746C65223A22E5BD93E69C88E8AFB7E58187E5A4A9E695B0222C226F70657261746F72223A223E222C2276616C7565223A2233222C2267726F757054797065223A224F52222C227661726961626C65436F6465223A226C656176654461797343757272656E744D6F6E7468227D5D2C2265787072657373696F6E223A22227D2C226E616D65223A22E69DA1E4BBB631222C226368696C6472656E223A7B226964223A226E6F64655F313636323135383636343730222C22706172656E744964223A226E6F64655F323237323732333237303839222C2270726F7073223A7B2273686F756C64416464223A66616C73652C2261737369676E656455736572223A5B7B22757365724964223A2231222C226E69636B4E616D65223A22E7AEA1E79086E59198222C2273656C6563746564223A66616C73657D5D2C22666F726D5065726D73223A5B5D7D2C2274797065223A224343222C226E616D65223A22E68A84E98081E4BABA222C226368696C6472656E223A7B7D7D7D2C7B226964223A226E6F64655F323237323732333239383734222C22706172656E744964223A226E6F64655F323237323732333231383234222C2274797065223A22434F4E444954494F4E222C2270726F7073223A7B2267726F75707354797065223A224F52222C2267726F757073223A5B7B227661726961626C654964223A2231222C227661726961626C655469746C65223A22E5BD93E69C88E8AFB7E58187E5A4A9E695B0222C226F70657261746F72223A223C3D222C2276616C7565223A2233222C2267726F757054797065223A224F52222C227661726961626C65436F6465223A226C656176654461797343757272656E744D6F6E7468227D5D2C2265787072657373696F6E223A22227D2C226E616D65223A22E69DA1E4BBB632222C226368696C6472656E223A7B7D7D5D7D7D, 0x7B22726F6F74223A7B2261737369676E656455736572223A5B5D2C22666F726D5065726D73223A5B5D7D2C226E6F64655F323237323732333231383234223A7B7D2C226E6F64655F323237323732333237303839223A7B2267726F75707354797065223A224F52222C2267726F757073223A5B7B227661726961626C654964223A2231222C227661726961626C655469746C65223A22E5BD93E69C88E8AFB7E58187E5A4A9E695B0222C226F70657261746F72223A223E222C2276616C7565223A2233222C2267726F757054797065223A224F52222C227661726961626C65436F6465223A226C656176654461797343757272656E744D6F6E7468227D5D2C2265787072657373696F6E223A22227D2C226E6F64655F313636323135383636343730223A7B2273686F756C64416464223A66616C73652C2261737369676E656455736572223A5B7B22757365724964223A2231222C226E69636B4E616D65223A22E7AEA1E79086E59198222C2273656C6563746564223A66616C73657D5D2C22666F726D5065726D73223A5B5D7D2C226E6F64655F323237323732333239383734223A7B2267726F75707354797065223A224F52222C2267726F757073223A5B7B227661726961626C654964223A2231222C227661726961626C655469746C65223A22E5BD93E69C88E8AFB7E58187E5A4A9E695B0222C226F70657261746F72223A223C3D222C2276616C7565223A2233222C2267726F757054797065223A224F52222C227661726961626C65436F6465223A226C656176654461797343757272656E744D6F6E7468227D5D2C2265787072657373696F6E223A22227D2C226E6F64655F393738393038393736323439223A7B2261737369676E656454797065223A2241535349474E5F55534552222C226D6F6465223A22414E44222C227369676E223A66616C73652C226E6F626F6479223A7B2274797065223A22544F5F524546555345222C2261737369676E656455736572223A5B5D7D2C2274696D654C696D6974223A7B2274696D656F7574223A7B22756E6974223A2248222C2276616C7565223A307D2C2268616E646C6572223A7B2274797065223A22524546555345222C226E6F74696679223A7B226F6E6365223A747275652C22686F7572223A317D7D7D2C2261737369676E656455736572223A5B7B22757365724964223A2232222C226E69636B4E616D65223A22E6B58BE8AF95303031222C2273656C6563746564223A66616C73657D5D2C22666F726D5065726D73223A5B5D2C2273656C6653656C656374223A7B226D756C7469706C65223A66616C73657D2C226C6561646572546F70223A7B22656E64436F6E646974696F6E223A22544F50222C22656E644C6576656C223A317D2C226C6561646572223A7B226C6576656C223A317D2C22726F6C65223A5B5D2C22726566757365223A7B2274797065223A22544F5F5355424D4954544552222C22746172676574223A22227D2C22666F726D55736572223A22227D7D, '[{"variableId":"1","variableTitle":"当月请假天数","operator":">","value":"3","groupType":"OR","variableCode":"leaveDaysCurrentMonth"},{"variableId":"1","variableTitle":"当月请假天数","operator":"<=","value":"3","groupType":"OR","variableCode":"leaveDaysCurrentMonth"}]', '2023-01-14 22:00:02', null, null, null, null, '2022-11-18 16:03:22', null, null, null);
INSERT INTO rouyi.t_act_hi_expand_process (id, expand_process_id, act_process_id, act_deployment_id, status, version, name, source, node_props, variable, deploy_time, tenant_id, notify_type, notify_title, remark, create_time, update_time, create_user, update_user) VALUES (4, 2, 'LEAVE2:1:40ec7321-9ef4-11ed-87be-c6bde56990c4', '40d9393f-9ef4-11ed-87be-c6bde56990c4', 1, '1', '请假流程_驳回申请人', 0x7B226964223A22726F6F74222C22706172656E744964223A6E756C6C2C2274797065223A22524F4F54222C226E616D65223A22E58F91E8B5B7E4BABA222C2264657363223A22E58F91E8B5B7E4BABA222C2270726F7073223A7B2261737369676E656455736572223A5B5D2C22666F726D5065726D73223A5B5D7D2C226368696C6472656E223A7B226964223A226E6F64655F323237323732333231383234222C22706172656E744964223A22726F6F74222C2270726F7073223A7B7D2C2274797065223A22434F4E444954494F4E53222C226E616D65223A22E69DA1E4BBB6E58886E694AF222C226368696C6472656E223A7B226964223A226E6F64655F323237323732333237303238222C22706172656E744964223A226E6F64655F323237323732333231383234222C2274797065223A22454D505459222C226368696C6472656E223A7B226964223A226E6F64655F303538393935303035303931222C22706172656E744964223A226E6F64655F323237323732333237303238222C2270726F7073223A7B2261737369676E656454797065223A2241535349474E5F55534552222C226D6F6465223A22414E44222C227369676E223A66616C73652C226E6F626F6479223A7B2274797065223A22544F5F50415353222C2261737369676E656455736572223A5B5D7D2C2274696D654C696D6974223A7B2274696D656F7574223A7B22756E6974223A2248222C2276616C7565223A307D2C2268616E646C6572223A7B2274797065223A22524546555345222C226E6F74696679223A7B226F6E6365223A747275652C22686F7572223A317D7D7D2C2261737369676E656455736572223A5B7B22757365724964223A2232222C226E69636B4E616D65223A22E6B58BE8AF95303031222C2273656C6563746564223A66616C73657D5D2C22666F726D5065726D73223A5B5D2C2273656C6653656C656374223A7B226D756C7469706C65223A66616C73657D2C226C6561646572546F70223A7B22656E64436F6E646974696F6E223A22544F50222C22656E644C6576656C223A317D2C226C6561646572223A7B226C6576656C223A317D2C22726F6C65223A5B5D2C22726566757365223A7B2274797065223A22544F5F4245464F5245222C22746172676574223A22227D2C22666F726D55736572223A22227D2C2274797065223A22415050524F56414C222C226E616D65223A22E5AEA1E689B9E4BABA41222C226368696C6472656E223A7B226964223A226E6F64655F393738393038393736323439222C22706172656E744964223A226E6F64655F303538393935303035303931222C2270726F7073223A7B2261737369676E656454797065223A2241535349474E5F55534552222C226D6F6465223A22414E44222C227369676E223A66616C73652C226E6F626F6479223A7B2274797065223A22544F5F524546555345222C2261737369676E656455736572223A5B5D7D2C2274696D654C696D6974223A7B2274696D656F7574223A7B22756E6974223A2248222C2276616C7565223A307D2C2268616E646C6572223A7B2274797065223A22524546555345222C226E6F74696679223A7B226F6E6365223A747275652C22686F7572223A317D7D7D2C2261737369676E656455736572223A5B7B22757365724964223A2232222C226E69636B4E616D65223A22E6B58BE8AF95303031222C2273656C6563746564223A66616C73657D5D2C22666F726D5065726D73223A5B5D2C2273656C6653656C656374223A7B226D756C7469706C65223A66616C73657D2C226C6561646572546F70223A7B22656E64436F6E646974696F6E223A22544F50222C22656E644C6576656C223A317D2C226C6561646572223A7B226C6576656C223A317D2C22726F6C65223A5B5D2C22726566757365223A7B2274797065223A22544F5F4245464F5245222C22746172676574223A22227D2C22666F726D55736572223A22227D2C2274797065223A22415050524F56414C222C226E616D65223A22E5AEA1E689B9E4BABA42222C226368696C6472656E223A7B226964223A226E6F64655F656E645F313233222C2274797065223A22454E44222C226368696C6472656E223A7B7D2C22706172656E744964223A226E6F64655F393738393038393736323439227D7D7D7D2C226272616E636873223A5B7B226964223A226E6F64655F323237323732333237303839222C22706172656E744964223A226E6F64655F323237323732333231383234222C2274797065223A22434F4E444954494F4E222C2270726F7073223A7B2267726F75707354797065223A224F52222C2267726F757073223A5B7B227661726961626C654964223A2231222C227661726961626C655469746C65223A22E5BD93E69C88E8AFB7E58187E5A4A9E695B0222C226F70657261746F72223A223E222C2276616C7565223A2233222C2267726F757054797065223A224F52222C227661726961626C65436F6465223A226C656176654461797343757272656E744D6F6E7468227D5D2C2265787072657373696F6E223A22227D2C226E616D65223A22E69DA1E4BBB631222C226368696C6472656E223A7B226964223A226E6F64655F313636323135383636343730222C22706172656E744964223A226E6F64655F323237323732333237303839222C2270726F7073223A7B2273686F756C64416464223A66616C73652C2261737369676E656455736572223A5B7B22757365724964223A2231222C226E69636B4E616D65223A22E7AEA1E79086E59198222C2273656C6563746564223A66616C73657D5D2C22666F726D5065726D73223A5B5D7D2C2274797065223A224343222C226E616D65223A22E68A84E98081E4BABA222C226368696C6472656E223A7B7D7D7D2C7B226964223A226E6F64655F323237323732333239383734222C22706172656E744964223A226E6F64655F323237323732333231383234222C2274797065223A22434F4E444954494F4E222C2270726F7073223A7B2267726F75707354797065223A224F52222C2267726F757073223A5B7B227661726961626C654964223A2231222C227661726961626C655469746C65223A22E5BD93E69C88E8AFB7E58187E5A4A9E695B0222C226F70657261746F72223A223C3D222C2276616C7565223A2233222C2267726F757054797065223A224F52222C227661726961626C65436F6465223A226C656176654461797343757272656E744D6F6E7468227D5D2C2265787072657373696F6E223A22227D2C226E616D65223A22E69DA1E4BBB632222C226368696C6472656E223A7B7D7D5D7D7D, 0x7B22726F6F74223A7B2261737369676E656455736572223A5B5D2C22666F726D5065726D73223A5B5D7D2C226E6F64655F323237323732333231383234223A7B7D2C226E6F64655F323237323732333237303839223A7B2267726F75707354797065223A224F52222C2267726F757073223A5B7B227661726961626C654964223A2231222C227661726961626C655469746C65223A22E5BD93E69C88E8AFB7E58187E5A4A9E695B0222C226F70657261746F72223A223E222C2276616C7565223A2233222C2267726F757054797065223A224F52222C227661726961626C65436F6465223A226C656176654461797343757272656E744D6F6E7468227D5D2C2265787072657373696F6E223A22227D2C226E6F64655F313636323135383636343730223A7B2273686F756C64416464223A66616C73652C2261737369676E656455736572223A5B7B22757365724964223A2231222C226E69636B4E616D65223A22E7AEA1E79086E59198222C2273656C6563746564223A66616C73657D5D2C22666F726D5065726D73223A5B5D7D2C226E6F64655F323237323732333239383734223A7B2267726F75707354797065223A224F52222C2267726F757073223A5B7B227661726961626C654964223A2231222C227661726961626C655469746C65223A22E5BD93E69C88E8AFB7E58187E5A4A9E695B0222C226F70657261746F72223A223C3D222C2276616C7565223A2233222C2267726F757054797065223A224F52222C227661726961626C65436F6465223A226C656176654461797343757272656E744D6F6E7468227D5D2C2265787072657373696F6E223A22227D2C226E6F64655F303538393935303035303931223A7B2261737369676E656454797065223A2241535349474E5F55534552222C226D6F6465223A22414E44222C227369676E223A66616C73652C226E6F626F6479223A7B2274797065223A22544F5F50415353222C2261737369676E656455736572223A5B5D7D2C2274696D654C696D6974223A7B2274696D656F7574223A7B22756E6974223A2248222C2276616C7565223A307D2C2268616E646C6572223A7B2274797065223A22524546555345222C226E6F74696679223A7B226F6E6365223A747275652C22686F7572223A317D7D7D2C2261737369676E656455736572223A5B7B22757365724964223A2232222C226E69636B4E616D65223A22E6B58BE8AF95303031222C2273656C6563746564223A66616C73657D5D2C22666F726D5065726D73223A5B5D2C2273656C6653656C656374223A7B226D756C7469706C65223A66616C73657D2C226C6561646572546F70223A7B22656E64436F6E646974696F6E223A22544F50222C22656E644C6576656C223A317D2C226C6561646572223A7B226C6576656C223A317D2C22726F6C65223A5B5D2C22726566757365223A7B2274797065223A22544F5F4245464F5245222C22746172676574223A22227D2C22666F726D55736572223A22227D2C226E6F64655F393738393038393736323439223A7B2261737369676E656454797065223A2241535349474E5F55534552222C226D6F6465223A22414E44222C227369676E223A66616C73652C226E6F626F6479223A7B2274797065223A22544F5F524546555345222C2261737369676E656455736572223A5B5D7D2C2274696D654C696D6974223A7B2274696D656F7574223A7B22756E6974223A2248222C2276616C7565223A307D2C2268616E646C6572223A7B2274797065223A22524546555345222C226E6F74696679223A7B226F6E6365223A747275652C22686F7572223A317D7D7D2C2261737369676E656455736572223A5B7B22757365724964223A2232222C226E69636B4E616D65223A22E6B58BE8AF95303031222C2273656C6563746564223A66616C73657D5D2C22666F726D5065726D73223A5B5D2C2273656C6653656C656374223A7B226D756C7469706C65223A66616C73657D2C226C6561646572546F70223A7B22656E64436F6E646974696F6E223A22544F50222C22656E644C6576656C223A317D2C226C6561646572223A7B226C6576656C223A317D2C22726F6C65223A5B5D2C22726566757365223A7B2274797065223A22544F5F4245464F5245222C22746172676574223A22227D2C22666F726D55736572223A22227D7D, '[{"variableId":"1","variableTitle":"当月请假天数","operator":">","value":"3","groupType":"OR","variableCode":"leaveDaysCurrentMonth"},{"variableId":"1","variableTitle":"当月请假天数","operator":"<=","value":"3","groupType":"OR","variableCode":"leaveDaysCurrentMonth"}]', '2023-01-28 18:12:21', null, null, null, null, '2022-11-18 16:03:22', null, null, null);
INSERT INTO rouyi.t_act_hi_expand_process (id, expand_process_id, act_process_id, act_deployment_id, status, version, name, source, node_props, variable, deploy_time, tenant_id, notify_type, notify_title, remark, create_time, update_time, create_user, update_user) VALUES (5, 3, 'LEAVE3:1:4d153e30-9ef4-11ed-87be-c6bde56990c4', '4d11bbbe-9ef4-11ed-87be-c6bde56990c4', 1, '1', '请假流程002', 0x7B226964223A22726F6F74222C22706172656E744964223A6E756C6C2C2274797065223A22524F4F54222C226E616D65223A22E58F91E8B5B7E4BABA222C2264657363223A22E58F91E8B5B7E4BABA222C2270726F7073223A7B2261737369676E656455736572223A5B5D2C22666F726D5065726D73223A5B5D7D2C226368696C6472656E223A7B226964223A226E6F64655F323237323732333231383234222C22706172656E744964223A22726F6F74222C2270726F7073223A7B7D2C2274797065223A22434F4E444954494F4E53222C226E616D65223A22E69DA1E4BBB6E58886E694AF222C226368696C6472656E223A7B226964223A226E6F64655F323237323732333237303238222C22706172656E744964223A226E6F64655F323237323732333231383234222C2274797065223A22454D505459222C226368696C6472656E223A7B226964223A226E6F64655F393738393038393736323439222C22706172656E744964223A226E6F64655F323237323732333237303238222C2270726F7073223A7B2261737369676E656454797065223A2241535349474E5F55534552222C226D6F6465223A22414E44222C227369676E223A66616C73652C226E6F626F6479223A7B2274797065223A22544F5F50415353222C2261737369676E656455736572223A5B5D7D2C2274696D654C696D6974223A7B2274696D656F7574223A7B22756E6974223A2248222C2276616C7565223A307D2C2268616E646C6572223A7B2274797065223A22524546555345222C226E6F74696679223A7B226F6E6365223A747275652C22686F7572223A317D7D7D2C2261737369676E656455736572223A5B7B22757365724964223A2232222C226E69636B4E616D65223A22E6B58BE8AF95303031222C2273656C6563746564223A66616C73657D5D2C22666F726D5065726D73223A5B5D2C2273656C6653656C656374223A7B226D756C7469706C65223A66616C73657D2C226C6561646572546F70223A7B22656E64436F6E646974696F6E223A22544F50222C22656E644C6576656C223A317D2C226C6561646572223A7B226C6576656C223A317D2C22726F6C65223A5B5D2C22726566757365223A7B2274797065223A22544F5F454E44222C22746172676574223A22227D2C22666F726D55736572223A22227D2C2274797065223A22415050524F56414C222C226E616D65223A22E5AEA1E689B9E4BABA222C226368696C6472656E223A7B226964223A226E6F64655F656E645F313233222C2274797065223A22454E44222C226368696C6472656E223A7B7D2C22706172656E744964223A226E6F64655F393738393038393736323439227D7D7D2C226272616E636873223A5B7B226964223A226E6F64655F323237323732333237303839222C22706172656E744964223A226E6F64655F323237323732333231383234222C2274797065223A22434F4E444954494F4E222C2270726F7073223A7B2267726F75707354797065223A224F52222C2267726F757073223A5B7B227661726961626C654964223A2231222C227661726961626C655469746C65223A22E5BD93E69C88E8AFB7E58187E5A4A9E695B0222C226F70657261746F72223A223E222C2276616C7565223A2233222C2267726F757054797065223A224F52222C227661726961626C65436F6465223A226C656176654461797343757272656E744D6F6E7468227D5D2C2265787072657373696F6E223A22227D2C226E616D65223A22E69DA1E4BBB631222C226368696C6472656E223A7B226964223A226E6F64655F313636323135383636343730222C22706172656E744964223A226E6F64655F323237323732333237303839222C2270726F7073223A7B2273686F756C64416464223A66616C73652C2261737369676E656455736572223A5B7B22757365724964223A2231222C226E69636B4E616D65223A22E7AEA1E79086E59198222C2273656C6563746564223A66616C73657D5D2C22666F726D5065726D73223A5B5D7D2C2274797065223A224343222C226E616D65223A22E68A84E98081E4BABA222C226368696C6472656E223A7B7D7D7D2C7B226964223A226E6F64655F323237323732333239383734222C22706172656E744964223A226E6F64655F323237323732333231383234222C2274797065223A22434F4E444954494F4E222C2270726F7073223A7B2267726F75707354797065223A224F52222C2267726F757073223A5B7B227661726961626C654964223A2231222C227661726961626C655469746C65223A22E5BD93E69C88E8AFB7E58187E5A4A9E695B0222C226F70657261746F72223A223C3D222C2276616C7565223A2233222C2267726F757054797065223A224F52222C227661726961626C65436F6465223A226C656176654461797343757272656E744D6F6E7468227D5D2C2265787072657373696F6E223A22227D2C226E616D65223A22E69DA1E4BBB632222C226368696C6472656E223A7B7D7D5D7D7D, 0x7B22726F6F74223A7B2261737369676E656455736572223A5B5D2C22666F726D5065726D73223A5B5D7D2C226E6F64655F323237323732333231383234223A7B7D2C226E6F64655F323237323732333237303839223A7B2267726F75707354797065223A224F52222C2267726F757073223A5B7B227661726961626C654964223A2231222C227661726961626C655469746C65223A22E5BD93E69C88E8AFB7E58187E5A4A9E695B0222C226F70657261746F72223A223E222C2276616C7565223A2233222C2267726F757054797065223A224F52222C227661726961626C65436F6465223A226C656176654461797343757272656E744D6F6E7468227D5D2C2265787072657373696F6E223A22227D2C226E6F64655F313636323135383636343730223A7B2273686F756C64416464223A66616C73652C2261737369676E656455736572223A5B7B22757365724964223A2231222C226E69636B4E616D65223A22E7AEA1E79086E59198222C2273656C6563746564223A66616C73657D5D2C22666F726D5065726D73223A5B5D7D2C226E6F64655F323237323732333239383734223A7B2267726F75707354797065223A224F52222C2267726F757073223A5B7B227661726961626C654964223A2231222C227661726961626C655469746C65223A22E5BD93E69C88E8AFB7E58187E5A4A9E695B0222C226F70657261746F72223A223C3D222C2276616C7565223A2233222C2267726F757054797065223A224F52222C227661726961626C65436F6465223A226C656176654461797343757272656E744D6F6E7468227D5D2C2265787072657373696F6E223A22227D2C226E6F64655F393738393038393736323439223A7B2261737369676E656454797065223A2241535349474E5F55534552222C226D6F6465223A22414E44222C227369676E223A66616C73652C226E6F626F6479223A7B2274797065223A22544F5F50415353222C2261737369676E656455736572223A5B5D7D2C2274696D654C696D6974223A7B2274696D656F7574223A7B22756E6974223A2248222C2276616C7565223A307D2C2268616E646C6572223A7B2274797065223A22524546555345222C226E6F74696679223A7B226F6E6365223A747275652C22686F7572223A317D7D7D2C2261737369676E656455736572223A5B7B22757365724964223A2232222C226E69636B4E616D65223A22E6B58BE8AF95303031222C2273656C6563746564223A66616C73657D5D2C22666F726D5065726D73223A5B5D2C2273656C6653656C656374223A7B226D756C7469706C65223A66616C73657D2C226C6561646572546F70223A7B22656E64436F6E646974696F6E223A22544F50222C22656E644C6576656C223A317D2C226C6561646572223A7B226C6576656C223A317D2C22726F6C65223A5B5D2C22726566757365223A7B2274797065223A22544F5F454E44222C22746172676574223A22227D2C22666F726D55736572223A22227D7D, '[{"variableId":"1","variableTitle":"当月请假天数","operator":">","value":"3","groupType":"OR","variableCode":"leaveDaysCurrentMonth"},{"variableId":"1","variableTitle":"当月请假天数","operator":"<=","value":"3","groupType":"OR","variableCode":"leaveDaysCurrentMonth"}]', '2023-01-28 18:12:42', null, null, null, null, '2022-11-18 16:03:22', null, null, null);
INSERT INTO rouyi.t_act_hi_expand_process (id, expand_process_id, act_process_id, act_deployment_id, status, version, name, source, node_props, variable, deploy_time, tenant_id, notify_type, notify_title, remark, create_time, update_time, create_user, update_user) VALUES (6, 2, 'LEAVE2:2:623a9a83-9ef4-11ed-87be-c6bde56990c4', '62373f21-9ef4-11ed-87be-c6bde56990c4', 1, '2', '请假流程_驳回申请人', 0x7B226964223A22726F6F74222C22706172656E744964223A6E756C6C2C2274797065223A22524F4F54222C226E616D65223A22E58F91E8B5B7E4BABA222C2264657363223A22E58F91E8B5B7E4BABA222C2270726F7073223A7B2261737369676E656455736572223A5B5D2C22666F726D5065726D73223A5B5D7D2C226368696C6472656E223A7B226964223A226E6F64655F323237323732333231383234222C22706172656E744964223A22726F6F74222C2270726F7073223A7B7D2C2274797065223A22434F4E444954494F4E53222C226E616D65223A22E69DA1E4BBB6E58886E694AF222C226368696C6472656E223A7B226964223A226E6F64655F323237323732333237303238222C22706172656E744964223A226E6F64655F323237323732333231383234222C2274797065223A22454D505459222C226368696C6472656E223A7B226964223A226E6F64655F303538393935303035303931222C22706172656E744964223A226E6F64655F323237323732333237303238222C2270726F7073223A7B2261737369676E656454797065223A2241535349474E5F55534552222C226D6F6465223A22414E44222C227369676E223A66616C73652C226E6F626F6479223A7B2274797065223A22544F5F50415353222C2261737369676E656455736572223A5B5D7D2C2274696D654C696D6974223A7B2274696D656F7574223A7B22756E6974223A2248222C2276616C7565223A307D2C2268616E646C6572223A7B2274797065223A22524546555345222C226E6F74696679223A7B226F6E6365223A747275652C22686F7572223A317D7D7D2C2261737369676E656455736572223A5B7B22757365724964223A2232222C226E69636B4E616D65223A22E6B58BE8AF95303031222C2273656C6563746564223A66616C73657D5D2C22666F726D5065726D73223A5B5D2C2273656C6653656C656374223A7B226D756C7469706C65223A66616C73657D2C226C6561646572546F70223A7B22656E64436F6E646974696F6E223A22544F50222C22656E644C6576656C223A317D2C226C6561646572223A7B226C6576656C223A317D2C22726F6C65223A5B5D2C22726566757365223A7B2274797065223A22544F5F4245464F5245222C22746172676574223A22227D2C22666F726D55736572223A22227D2C2274797065223A22415050524F56414C222C226E616D65223A22E5AEA1E689B9E4BABA2D41222C226368696C6472656E223A7B226964223A226E6F64655F393738393038393736323439222C22706172656E744964223A226E6F64655F303538393935303035303931222C2270726F7073223A7B2261737369676E656454797065223A2241535349474E5F55534552222C226D6F6465223A22414E44222C227369676E223A66616C73652C226E6F626F6479223A7B2274797065223A22544F5F524546555345222C2261737369676E656455736572223A5B5D7D2C2274696D654C696D6974223A7B2274696D656F7574223A7B22756E6974223A2248222C2276616C7565223A307D2C2268616E646C6572223A7B2274797065223A22524546555345222C226E6F74696679223A7B226F6E6365223A747275652C22686F7572223A317D7D7D2C2261737369676E656455736572223A5B7B22757365724964223A2232222C226E69636B4E616D65223A22E6B58BE8AF95303031222C2273656C6563746564223A66616C73657D5D2C22666F726D5065726D73223A5B5D2C2273656C6653656C656374223A7B226D756C7469706C65223A66616C73657D2C226C6561646572546F70223A7B22656E64436F6E646974696F6E223A22544F50222C22656E644C6576656C223A317D2C226C6561646572223A7B226C6576656C223A317D2C22726F6C65223A5B5D2C22726566757365223A7B2274797065223A22544F5F4245464F5245222C22746172676574223A22227D2C22666F726D55736572223A22227D2C2274797065223A22415050524F56414C222C226E616D65223A22E5AEA1E689B9E4BABA42222C226368696C6472656E223A7B226964223A226E6F64655F656E645F313233222C2274797065223A22454E44222C226368696C6472656E223A7B7D2C22706172656E744964223A226E6F64655F393738393038393736323439227D7D7D7D2C226272616E636873223A5B7B226964223A226E6F64655F323237323732333237303839222C22706172656E744964223A226E6F64655F323237323732333231383234222C2274797065223A22434F4E444954494F4E222C2270726F7073223A7B2267726F75707354797065223A224F52222C2267726F757073223A5B7B227661726961626C654964223A2231222C227661726961626C655469746C65223A22E5BD93E69C88E8AFB7E58187E5A4A9E695B0222C226F70657261746F72223A223E222C2276616C7565223A2233222C2267726F757054797065223A224F52222C227661726961626C65436F6465223A226C656176654461797343757272656E744D6F6E7468227D5D2C2265787072657373696F6E223A22227D2C226E616D65223A22E69DA1E4BBB631222C226368696C6472656E223A7B226964223A226E6F64655F313636323135383636343730222C22706172656E744964223A226E6F64655F323237323732333237303839222C2270726F7073223A7B2273686F756C64416464223A66616C73652C2261737369676E656455736572223A5B7B22757365724964223A2231222C226E69636B4E616D65223A22E7AEA1E79086E59198222C2273656C6563746564223A66616C73657D5D2C22666F726D5065726D73223A5B5D7D2C2274797065223A224343222C226E616D65223A22E68A84E98081E4BABA222C226368696C6472656E223A7B7D7D7D2C7B226964223A226E6F64655F323237323732333239383734222C22706172656E744964223A226E6F64655F323237323732333231383234222C2274797065223A22434F4E444954494F4E222C2270726F7073223A7B2267726F75707354797065223A224F52222C2267726F757073223A5B7B227661726961626C654964223A2231222C227661726961626C655469746C65223A22E5BD93E69C88E8AFB7E58187E5A4A9E695B0222C226F70657261746F72223A223C3D222C2276616C7565223A2233222C2267726F757054797065223A224F52222C227661726961626C65436F6465223A226C656176654461797343757272656E744D6F6E7468227D5D2C2265787072657373696F6E223A22227D2C226E616D65223A22E69DA1E4BBB632222C226368696C6472656E223A7B7D7D5D7D7D, 0x7B22726F6F74223A7B2261737369676E656455736572223A5B5D2C22666F726D5065726D73223A5B5D7D2C226E6F64655F323237323732333231383234223A7B7D2C226E6F64655F323237323732333237303839223A7B2267726F75707354797065223A224F52222C2267726F757073223A5B7B227661726961626C654964223A2231222C227661726961626C655469746C65223A22E5BD93E69C88E8AFB7E58187E5A4A9E695B0222C226F70657261746F72223A223E222C2276616C7565223A2233222C2267726F757054797065223A224F52222C227661726961626C65436F6465223A226C656176654461797343757272656E744D6F6E7468227D5D2C2265787072657373696F6E223A22227D2C226E6F64655F313636323135383636343730223A7B2273686F756C64416464223A66616C73652C2261737369676E656455736572223A5B7B22757365724964223A2231222C226E69636B4E616D65223A22E7AEA1E79086E59198222C2273656C6563746564223A66616C73657D5D2C22666F726D5065726D73223A5B5D7D2C226E6F64655F323237323732333239383734223A7B2267726F75707354797065223A224F52222C2267726F757073223A5B7B227661726961626C654964223A2231222C227661726961626C655469746C65223A22E5BD93E69C88E8AFB7E58187E5A4A9E695B0222C226F70657261746F72223A223C3D222C2276616C7565223A2233222C2267726F757054797065223A224F52222C227661726961626C65436F6465223A226C656176654461797343757272656E744D6F6E7468227D5D2C2265787072657373696F6E223A22227D2C226E6F64655F303538393935303035303931223A7B2261737369676E656454797065223A2241535349474E5F55534552222C226D6F6465223A22414E44222C227369676E223A66616C73652C226E6F626F6479223A7B2274797065223A22544F5F50415353222C2261737369676E656455736572223A5B5D7D2C2274696D654C696D6974223A7B2274696D656F7574223A7B22756E6974223A2248222C2276616C7565223A307D2C2268616E646C6572223A7B2274797065223A22524546555345222C226E6F74696679223A7B226F6E6365223A747275652C22686F7572223A317D7D7D2C2261737369676E656455736572223A5B7B22757365724964223A2232222C226E69636B4E616D65223A22E6B58BE8AF95303031222C2273656C6563746564223A66616C73657D5D2C22666F726D5065726D73223A5B5D2C2273656C6653656C656374223A7B226D756C7469706C65223A66616C73657D2C226C6561646572546F70223A7B22656E64436F6E646974696F6E223A22544F50222C22656E644C6576656C223A317D2C226C6561646572223A7B226C6576656C223A317D2C22726F6C65223A5B5D2C22726566757365223A7B2274797065223A22544F5F4245464F5245222C22746172676574223A22227D2C22666F726D55736572223A22227D2C226E6F64655F393738393038393736323439223A7B2261737369676E656454797065223A2241535349474E5F55534552222C226D6F6465223A22414E44222C227369676E223A66616C73652C226E6F626F6479223A7B2274797065223A22544F5F524546555345222C2261737369676E656455736572223A5B5D7D2C2274696D654C696D6974223A7B2274696D656F7574223A7B22756E6974223A2248222C2276616C7565223A307D2C2268616E646C6572223A7B2274797065223A22524546555345222C226E6F74696679223A7B226F6E6365223A747275652C22686F7572223A317D7D7D2C2261737369676E656455736572223A5B7B22757365724964223A2232222C226E69636B4E616D65223A22E6B58BE8AF95303031222C2273656C6563746564223A66616C73657D5D2C22666F726D5065726D73223A5B5D2C2273656C6653656C656374223A7B226D756C7469706C65223A66616C73657D2C226C6561646572546F70223A7B22656E64436F6E646974696F6E223A22544F50222C22656E644C6576656C223A317D2C226C6561646572223A7B226C6576656C223A317D2C22726F6C65223A5B5D2C22726566757365223A7B2274797065223A22544F5F4245464F5245222C22746172676574223A22227D2C22666F726D55736572223A22227D7D, '[{"variableId":"1","variableTitle":"当月请假天数","operator":">","value":"3","groupType":"OR","variableCode":"leaveDaysCurrentMonth"},{"variableId":"1","variableTitle":"当月请假天数","operator":"<=","value":"3","groupType":"OR","variableCode":"leaveDaysCurrentMonth"}]', '2023-01-28 18:13:17', null, null, null, null, '2022-11-18 16:03:22', null, null, null);
INSERT INTO rouyi.t_act_hi_expand_process (id, expand_process_id, act_process_id, act_deployment_id, status, version, name, source, node_props, variable, deploy_time, tenant_id, notify_type, notify_title, remark, create_time, update_time, create_user, update_user) VALUES (7, 2, 'LEAVE2:3:32ca8e97-9f7c-11ed-89d4-c6bde56990c4', '32c3d7d5-9f7c-11ed-89d4-c6bde56990c4', 1, '3', '请假流程_驳回申请人', 0x7B226964223A22726F6F74222C22706172656E744964223A6E756C6C2C2274797065223A22524F4F54222C226E616D65223A22E58F91E8B5B7E4BABA222C2264657363223A22E58F91E8B5B7E4BABA222C2270726F7073223A7B2261737369676E656455736572223A5B5D2C22666F726D5065726D73223A5B5D7D2C226368696C6472656E223A7B226964223A226E6F64655F323237323732333231383234222C22706172656E744964223A22726F6F74222C2270726F7073223A7B7D2C2274797065223A22434F4E444954494F4E53222C226E616D65223A22E69DA1E4BBB6E58886E694AF222C226368696C6472656E223A7B226964223A226E6F64655F323237323732333237303238222C22706172656E744964223A226E6F64655F323237323732333231383234222C2274797065223A22454D505459222C226368696C6472656E223A7B226964223A226E6F64655F303538393935303035303931222C22706172656E744964223A226E6F64655F323237323732333237303238222C2270726F7073223A7B2261737369676E656454797065223A2241535349474E5F55534552222C226D6F6465223A22414E44222C227369676E223A66616C73652C226E6F626F6479223A7B2274797065223A22544F5F50415353222C2261737369676E656455736572223A5B5D7D2C2274696D654C696D6974223A7B2274696D656F7574223A7B22756E6974223A2248222C2276616C7565223A307D2C2268616E646C6572223A7B2274797065223A22524546555345222C226E6F74696679223A7B226F6E6365223A747275652C22686F7572223A317D7D7D2C2261737369676E656455736572223A5B7B22757365724964223A2232222C226E69636B4E616D65223A22E6B58BE8AF95303031222C2273656C6563746564223A66616C73657D5D2C22666F726D5065726D73223A5B5D2C2273656C6653656C656374223A7B226D756C7469706C65223A66616C73657D2C226C6561646572546F70223A7B22656E64436F6E646974696F6E223A22544F50222C22656E644C6576656C223A317D2C226C6561646572223A7B226C6576656C223A317D2C22726F6C65223A5B5D2C22726566757365223A7B2274797065223A22544F5F4245464F5245222C22746172676574223A22227D2C22666F726D55736572223A22227D2C2274797065223A22415050524F56414C222C226E616D65223A22E5AEA1E689B9E4BABA2D41222C226368696C6472656E223A7B226964223A226E6F64655F393738393038393736323439222C22706172656E744964223A226E6F64655F303538393935303035303931222C2270726F7073223A7B2261737369676E656454797065223A2241535349474E5F55534552222C226D6F6465223A22414E44222C227369676E223A66616C73652C226E6F626F6479223A7B2274797065223A22544F5F524546555345222C2261737369676E656455736572223A5B5D7D2C2274696D654C696D6974223A7B2274696D656F7574223A7B22756E6974223A2248222C2276616C7565223A307D2C2268616E646C6572223A7B2274797065223A22524546555345222C226E6F74696679223A7B226F6E6365223A747275652C22686F7572223A317D7D7D2C2261737369676E656455736572223A5B7B22757365724964223A2232222C226E69636B4E616D65223A22E6B58BE8AF95303031222C2273656C6563746564223A66616C73657D5D2C22666F726D5065726D73223A5B5D2C2273656C6653656C656374223A7B226D756C7469706C65223A66616C73657D2C226C6561646572546F70223A7B22656E64436F6E646974696F6E223A22544F50222C22656E644C6576656C223A317D2C226C6561646572223A7B226C6576656C223A317D2C22726F6C65223A5B5D2C22726566757365223A7B2274797065223A22544F5F4245464F5245222C22746172676574223A22227D2C22666F726D55736572223A22227D2C2274797065223A22415050524F56414C222C226E616D65223A22E5AEA1E689B9E4BABA42222C226368696C6472656E223A7B226964223A226E6F64655F353930383930393532363232222C22706172656E744964223A226E6F64655F393738393038393736323439222C2270726F7073223A7B2261737369676E656454797065223A2241535349474E5F55534552222C226D6F6465223A22414E44222C227369676E223A66616C73652C226E6F626F6479223A7B2274797065223A22544F5F50415353222C2261737369676E656455736572223A5B5D7D2C2274696D654C696D6974223A7B2274696D656F7574223A7B22756E6974223A2248222C2276616C7565223A307D2C2268616E646C6572223A7B2274797065223A22524546555345222C226E6F74696679223A7B226F6E6365223A747275652C22686F7572223A317D7D7D2C2261737369676E656455736572223A5B7B22757365724964223A2232222C226E69636B4E616D65223A22E6B58BE8AF95303031222C2273656C6563746564223A66616C73657D5D2C22666F726D5065726D73223A5B5D2C2273656C6653656C656374223A7B226D756C7469706C65223A66616C73657D2C226C6561646572546F70223A7B22656E64436F6E646974696F6E223A22544F50222C22656E644C6576656C223A317D2C226C6561646572223A7B226C6576656C223A317D2C22726F6C65223A5B5D2C22726566757365223A7B2274797065223A22544F5F4245464F5245222C22746172676574223A22227D2C22666F726D55736572223A22227D2C2274797065223A22415050524F56414C222C226E616D65223A22E5AEA1E689B9E4BABA2D43222C226368696C6472656E223A7B226964223A226E6F64655F656E645F313233222C2274797065223A22454E44222C226368696C6472656E223A7B7D2C22706172656E744964223A226E6F64655F353930383930393532363232227D7D7D7D7D2C226272616E636873223A5B7B226964223A226E6F64655F323237323732333237303839222C22706172656E744964223A226E6F64655F323237323732333231383234222C2274797065223A22434F4E444954494F4E222C2270726F7073223A7B2267726F75707354797065223A224F52222C2267726F757073223A5B7B227661726961626C654964223A2231222C227661726961626C655469746C65223A22E5BD93E69C88E8AFB7E58187E5A4A9E695B0222C226F70657261746F72223A223E222C2276616C7565223A2233222C2267726F757054797065223A224F52222C227661726961626C65436F6465223A226C656176654461797343757272656E744D6F6E7468227D5D2C2265787072657373696F6E223A22227D2C226E616D65223A22E69DA1E4BBB631222C226368696C6472656E223A7B226964223A226E6F64655F313636323135383636343730222C22706172656E744964223A226E6F64655F323237323732333237303839222C2270726F7073223A7B2273686F756C64416464223A66616C73652C2261737369676E656455736572223A5B7B22757365724964223A2231222C226E69636B4E616D65223A22E7AEA1E79086E59198222C2273656C6563746564223A66616C73657D5D2C22666F726D5065726D73223A5B5D7D2C2274797065223A224343222C226E616D65223A22E68A84E98081E4BABA222C226368696C6472656E223A7B7D7D7D2C7B226964223A226E6F64655F323237323732333239383734222C22706172656E744964223A226E6F64655F323237323732333231383234222C2274797065223A22434F4E444954494F4E222C2270726F7073223A7B2267726F75707354797065223A224F52222C2267726F757073223A5B7B227661726961626C654964223A2231222C227661726961626C655469746C65223A22E5BD93E69C88E8AFB7E58187E5A4A9E695B0222C226F70657261746F72223A223C3D222C2276616C7565223A2233222C2267726F757054797065223A224F52222C227661726961626C65436F6465223A226C656176654461797343757272656E744D6F6E7468227D5D2C2265787072657373696F6E223A22227D2C226E616D65223A22E69DA1E4BBB632222C226368696C6472656E223A7B7D7D5D7D7D, 0x7B22726F6F74223A7B2261737369676E656455736572223A5B5D2C22666F726D5065726D73223A5B5D7D2C226E6F64655F323237323732333231383234223A7B7D2C226E6F64655F323237323732333237303839223A7B2267726F75707354797065223A224F52222C2267726F757073223A5B7B227661726961626C654964223A2231222C227661726961626C655469746C65223A22E5BD93E69C88E8AFB7E58187E5A4A9E695B0222C226F70657261746F72223A223E222C2276616C7565223A2233222C2267726F757054797065223A224F52222C227661726961626C65436F6465223A226C656176654461797343757272656E744D6F6E7468227D5D2C2265787072657373696F6E223A22227D2C226E6F64655F313636323135383636343730223A7B2273686F756C64416464223A66616C73652C2261737369676E656455736572223A5B7B22757365724964223A2231222C226E69636B4E616D65223A22E7AEA1E79086E59198222C2273656C6563746564223A66616C73657D5D2C22666F726D5065726D73223A5B5D7D2C226E6F64655F323237323732333239383734223A7B2267726F75707354797065223A224F52222C2267726F757073223A5B7B227661726961626C654964223A2231222C227661726961626C655469746C65223A22E5BD93E69C88E8AFB7E58187E5A4A9E695B0222C226F70657261746F72223A223C3D222C2276616C7565223A2233222C2267726F757054797065223A224F52222C227661726961626C65436F6465223A226C656176654461797343757272656E744D6F6E7468227D5D2C2265787072657373696F6E223A22227D2C226E6F64655F303538393935303035303931223A7B2261737369676E656454797065223A2241535349474E5F55534552222C226D6F6465223A22414E44222C227369676E223A66616C73652C226E6F626F6479223A7B2274797065223A22544F5F50415353222C2261737369676E656455736572223A5B5D7D2C2274696D654C696D6974223A7B2274696D656F7574223A7B22756E6974223A2248222C2276616C7565223A307D2C2268616E646C6572223A7B2274797065223A22524546555345222C226E6F74696679223A7B226F6E6365223A747275652C22686F7572223A317D7D7D2C2261737369676E656455736572223A5B7B22757365724964223A2232222C226E69636B4E616D65223A22E6B58BE8AF95303031222C2273656C6563746564223A66616C73657D5D2C22666F726D5065726D73223A5B5D2C2273656C6653656C656374223A7B226D756C7469706C65223A66616C73657D2C226C6561646572546F70223A7B22656E64436F6E646974696F6E223A22544F50222C22656E644C6576656C223A317D2C226C6561646572223A7B226C6576656C223A317D2C22726F6C65223A5B5D2C22726566757365223A7B2274797065223A22544F5F4245464F5245222C22746172676574223A22227D2C22666F726D55736572223A22227D2C226E6F64655F393738393038393736323439223A7B2261737369676E656454797065223A2241535349474E5F55534552222C226D6F6465223A22414E44222C227369676E223A66616C73652C226E6F626F6479223A7B2274797065223A22544F5F524546555345222C2261737369676E656455736572223A5B5D7D2C2274696D654C696D6974223A7B2274696D656F7574223A7B22756E6974223A2248222C2276616C7565223A307D2C2268616E646C6572223A7B2274797065223A22524546555345222C226E6F74696679223A7B226F6E6365223A747275652C22686F7572223A317D7D7D2C2261737369676E656455736572223A5B7B22757365724964223A2232222C226E69636B4E616D65223A22E6B58BE8AF95303031222C2273656C6563746564223A66616C73657D5D2C22666F726D5065726D73223A5B5D2C2273656C6653656C656374223A7B226D756C7469706C65223A66616C73657D2C226C6561646572546F70223A7B22656E64436F6E646974696F6E223A22544F50222C22656E644C6576656C223A317D2C226C6561646572223A7B226C6576656C223A317D2C22726F6C65223A5B5D2C22726566757365223A7B2274797065223A22544F5F4245464F5245222C22746172676574223A22227D2C22666F726D55736572223A22227D2C226E6F64655F353930383930393532363232223A7B2261737369676E656454797065223A2241535349474E5F55534552222C226D6F6465223A22414E44222C227369676E223A66616C73652C226E6F626F6479223A7B2274797065223A22544F5F50415353222C2261737369676E656455736572223A5B5D7D2C2274696D654C696D6974223A7B2274696D656F7574223A7B22756E6974223A2248222C2276616C7565223A307D2C2268616E646C6572223A7B2274797065223A22524546555345222C226E6F74696679223A7B226F6E6365223A747275652C22686F7572223A317D7D7D2C2261737369676E656455736572223A5B7B22757365724964223A2232222C226E69636B4E616D65223A22E6B58BE8AF95303031222C2273656C6563746564223A66616C73657D5D2C22666F726D5065726D73223A5B5D2C2273656C6653656C656374223A7B226D756C7469706C65223A66616C73657D2C226C6561646572546F70223A7B22656E64436F6E646974696F6E223A22544F50222C22656E644C6576656C223A317D2C226C6561646572223A7B226C6576656C223A317D2C22726F6C65223A5B5D2C22726566757365223A7B2274797065223A22544F5F4245464F5245222C22746172676574223A22227D2C22666F726D55736572223A22227D7D, '[{"variableId":"1","variableTitle":"当月请假天数","operator":">","value":"3","groupType":"OR","variableCode":"leaveDaysCurrentMonth"},{"variableId":"1","variableTitle":"当月请假天数","operator":"<=","value":"3","groupType":"OR","variableCode":"leaveDaysCurrentMonth"}]', '2023-01-29 10:25:29', null, null, null, null, '2022-11-18 16:03:22', null, null, null);
INSERT INTO rouyi.t_act_hi_expand_process (id, expand_process_id, act_process_id, act_deployment_id, status, version, name, source, node_props, variable, deploy_time, tenant_id, notify_type, notify_title, remark, create_time, update_time, create_user, update_user) VALUES (8, 2, 'LEAVE2:4:e4ee7c0f-9f83-11ed-a8b3-c6bde56990c4', 'e4df12bd-9f83-11ed-a8b3-c6bde56990c4', 1, '4', '请假流程_驳回申请人', 0x7B226964223A22726F6F74222C22706172656E744964223A6E756C6C2C2274797065223A22524F4F54222C226E616D65223A22E58F91E8B5B7E4BABA222C2264657363223A22E58F91E8B5B7E4BABA222C2270726F7073223A7B2261737369676E656455736572223A5B5D2C22666F726D5065726D73223A5B5D7D2C226368696C6472656E223A7B226964223A226E6F64655F323237323732333231383234222C22706172656E744964223A22726F6F74222C2270726F7073223A7B7D2C2274797065223A22434F4E444954494F4E53222C226E616D65223A22E69DA1E4BBB6E58886E694AF222C226368696C6472656E223A7B226964223A226E6F64655F323237323732333237303238222C22706172656E744964223A226E6F64655F323237323732333231383234222C2274797065223A22454D505459222C226368696C6472656E223A7B226964223A226E6F64655F303538393935303035303931222C22706172656E744964223A226E6F64655F323237323732333237303238222C2270726F7073223A7B2261737369676E656454797065223A2241535349474E5F55534552222C226D6F6465223A22414E44222C227369676E223A66616C73652C226E6F626F6479223A7B2274797065223A22544F5F50415353222C2261737369676E656455736572223A5B5D7D2C2274696D654C696D6974223A7B2274696D656F7574223A7B22756E6974223A2248222C2276616C7565223A307D2C2268616E646C6572223A7B2274797065223A22524546555345222C226E6F74696679223A7B226F6E6365223A747275652C22686F7572223A317D7D7D2C2261737369676E656455736572223A5B7B22757365724964223A2232222C226E69636B4E616D65223A22E6B58BE8AF95303031222C2273656C6563746564223A66616C73657D5D2C22666F726D5065726D73223A5B5D2C2273656C6653656C656374223A7B226D756C7469706C65223A66616C73657D2C226C6561646572546F70223A7B22656E64436F6E646974696F6E223A22544F50222C22656E644C6576656C223A317D2C226C6561646572223A7B226C6576656C223A317D2C22726F6C65223A5B5D2C22726566757365223A7B2274797065223A22544F5F454E44222C22746172676574223A22227D2C22666F726D55736572223A22227D2C2274797065223A22415050524F56414C222C226E616D65223A22E5AEA1E689B9E4BABA2D41222C226368696C6472656E223A7B226964223A226E6F64655F393738393038393736323439222C22706172656E744964223A226E6F64655F303538393935303035303931222C2270726F7073223A7B2261737369676E656454797065223A2241535349474E5F55534552222C226D6F6465223A22414E44222C227369676E223A66616C73652C226E6F626F6479223A7B2274797065223A22544F5F524546555345222C2261737369676E656455736572223A5B5D7D2C2274696D654C696D6974223A7B2274696D656F7574223A7B22756E6974223A2248222C2276616C7565223A307D2C2268616E646C6572223A7B2274797065223A22524546555345222C226E6F74696679223A7B226F6E6365223A747275652C22686F7572223A317D7D7D2C2261737369676E656455736572223A5B7B22757365724964223A2232222C226E69636B4E616D65223A22E6B58BE8AF95303031222C2273656C6563746564223A66616C73657D5D2C22666F726D5065726D73223A5B5D2C2273656C6653656C656374223A7B226D756C7469706C65223A66616C73657D2C226C6561646572546F70223A7B22656E64436F6E646974696F6E223A22544F50222C22656E644C6576656C223A317D2C226C6561646572223A7B226C6576656C223A317D2C22726F6C65223A5B5D2C22726566757365223A7B2274797065223A22544F5F4245464F5245222C22746172676574223A22227D2C22666F726D55736572223A22227D2C2274797065223A22415050524F56414C222C226E616D65223A22E5AEA1E689B9E4BABA42222C226368696C6472656E223A7B226964223A226E6F64655F353930383930393532363232222C22706172656E744964223A226E6F64655F393738393038393736323439222C2270726F7073223A7B2261737369676E656454797065223A2241535349474E5F55534552222C226D6F6465223A22414E44222C227369676E223A66616C73652C226E6F626F6479223A7B2274797065223A22544F5F50415353222C2261737369676E656455736572223A5B5D7D2C2274696D654C696D6974223A7B2274696D656F7574223A7B22756E6974223A2248222C2276616C7565223A307D2C2268616E646C6572223A7B2274797065223A22524546555345222C226E6F74696679223A7B226F6E6365223A747275652C22686F7572223A317D7D7D2C2261737369676E656455736572223A5B7B22757365724964223A2232222C226E69636B4E616D65223A22E6B58BE8AF95303031222C2273656C6563746564223A66616C73657D5D2C22666F726D5065726D73223A5B5D2C2273656C6653656C656374223A7B226D756C7469706C65223A66616C73657D2C226C6561646572546F70223A7B22656E64436F6E646974696F6E223A22544F50222C22656E644C6576656C223A317D2C226C6561646572223A7B226C6576656C223A317D2C22726F6C65223A5B5D2C22726566757365223A7B2274797065223A22544F5F4245464F5245222C22746172676574223A22227D2C22666F726D55736572223A22227D2C2274797065223A22415050524F56414C222C226E616D65223A22E5AEA1E689B9E4BABA2D43222C226368696C6472656E223A7B226964223A226E6F64655F656E645F313233222C2274797065223A22454E44222C226368696C6472656E223A7B7D2C22706172656E744964223A226E6F64655F353930383930393532363232227D7D7D7D7D2C226272616E636873223A5B7B226964223A226E6F64655F323237323732333237303839222C22706172656E744964223A226E6F64655F323237323732333231383234222C2274797065223A22434F4E444954494F4E222C2270726F7073223A7B2267726F75707354797065223A224F52222C2267726F757073223A5B7B227661726961626C654964223A2231222C227661726961626C655469746C65223A22E5BD93E69C88E8AFB7E58187E5A4A9E695B0222C226F70657261746F72223A223E222C2276616C7565223A2233222C2267726F757054797065223A224F52222C227661726961626C65436F6465223A226C656176654461797343757272656E744D6F6E7468227D5D2C2265787072657373696F6E223A22227D2C226E616D65223A22E69DA1E4BBB631222C226368696C6472656E223A7B226964223A226E6F64655F313636323135383636343730222C22706172656E744964223A226E6F64655F323237323732333237303839222C2270726F7073223A7B2273686F756C64416464223A66616C73652C2261737369676E656455736572223A5B7B22757365724964223A2231222C226E69636B4E616D65223A22E7AEA1E79086E59198222C2273656C6563746564223A66616C73657D5D2C22666F726D5065726D73223A5B5D7D2C2274797065223A224343222C226E616D65223A22E68A84E98081E4BABA222C226368696C6472656E223A7B7D7D7D2C7B226964223A226E6F64655F323237323732333239383734222C22706172656E744964223A226E6F64655F323237323732333231383234222C2274797065223A22434F4E444954494F4E222C2270726F7073223A7B2267726F75707354797065223A224F52222C2267726F757073223A5B7B227661726961626C654964223A2231222C227661726961626C655469746C65223A22E5BD93E69C88E8AFB7E58187E5A4A9E695B0222C226F70657261746F72223A223C3D222C2276616C7565223A2233222C2267726F757054797065223A224F52222C227661726961626C65436F6465223A226C656176654461797343757272656E744D6F6E7468227D5D2C2265787072657373696F6E223A22227D2C226E616D65223A22E69DA1E4BBB632222C226368696C6472656E223A7B7D7D5D7D7D, 0x7B22726F6F74223A7B2261737369676E656455736572223A5B5D2C22666F726D5065726D73223A5B5D7D2C226E6F64655F323237323732333231383234223A7B7D2C226E6F64655F323237323732333237303839223A7B2267726F75707354797065223A224F52222C2267726F757073223A5B7B227661726961626C654964223A2231222C227661726961626C655469746C65223A22E5BD93E69C88E8AFB7E58187E5A4A9E695B0222C226F70657261746F72223A223E222C2276616C7565223A2233222C2267726F757054797065223A224F52222C227661726961626C65436F6465223A226C656176654461797343757272656E744D6F6E7468227D5D2C2265787072657373696F6E223A22227D2C226E6F64655F313636323135383636343730223A7B2273686F756C64416464223A66616C73652C2261737369676E656455736572223A5B7B22757365724964223A2231222C226E69636B4E616D65223A22E7AEA1E79086E59198222C2273656C6563746564223A66616C73657D5D2C22666F726D5065726D73223A5B5D7D2C226E6F64655F323237323732333239383734223A7B2267726F75707354797065223A224F52222C2267726F757073223A5B7B227661726961626C654964223A2231222C227661726961626C655469746C65223A22E5BD93E69C88E8AFB7E58187E5A4A9E695B0222C226F70657261746F72223A223C3D222C2276616C7565223A2233222C2267726F757054797065223A224F52222C227661726961626C65436F6465223A226C656176654461797343757272656E744D6F6E7468227D5D2C2265787072657373696F6E223A22227D2C226E6F64655F303538393935303035303931223A7B2261737369676E656454797065223A2241535349474E5F55534552222C226D6F6465223A22414E44222C227369676E223A66616C73652C226E6F626F6479223A7B2274797065223A22544F5F50415353222C2261737369676E656455736572223A5B5D7D2C2274696D654C696D6974223A7B2274696D656F7574223A7B22756E6974223A2248222C2276616C7565223A307D2C2268616E646C6572223A7B2274797065223A22524546555345222C226E6F74696679223A7B226F6E6365223A747275652C22686F7572223A317D7D7D2C2261737369676E656455736572223A5B7B22757365724964223A2232222C226E69636B4E616D65223A22E6B58BE8AF95303031222C2273656C6563746564223A66616C73657D5D2C22666F726D5065726D73223A5B5D2C2273656C6653656C656374223A7B226D756C7469706C65223A66616C73657D2C226C6561646572546F70223A7B22656E64436F6E646974696F6E223A22544F50222C22656E644C6576656C223A317D2C226C6561646572223A7B226C6576656C223A317D2C22726F6C65223A5B5D2C22726566757365223A7B2274797065223A22544F5F454E44222C22746172676574223A22227D2C22666F726D55736572223A22227D2C226E6F64655F393738393038393736323439223A7B2261737369676E656454797065223A2241535349474E5F55534552222C226D6F6465223A22414E44222C227369676E223A66616C73652C226E6F626F6479223A7B2274797065223A22544F5F524546555345222C2261737369676E656455736572223A5B5D7D2C2274696D654C696D6974223A7B2274696D656F7574223A7B22756E6974223A2248222C2276616C7565223A307D2C2268616E646C6572223A7B2274797065223A22524546555345222C226E6F74696679223A7B226F6E6365223A747275652C22686F7572223A317D7D7D2C2261737369676E656455736572223A5B7B22757365724964223A2232222C226E69636B4E616D65223A22E6B58BE8AF95303031222C2273656C6563746564223A66616C73657D5D2C22666F726D5065726D73223A5B5D2C2273656C6653656C656374223A7B226D756C7469706C65223A66616C73657D2C226C6561646572546F70223A7B22656E64436F6E646974696F6E223A22544F50222C22656E644C6576656C223A317D2C226C6561646572223A7B226C6576656C223A317D2C22726F6C65223A5B5D2C22726566757365223A7B2274797065223A22544F5F4245464F5245222C22746172676574223A22227D2C22666F726D55736572223A22227D2C226E6F64655F353930383930393532363232223A7B2261737369676E656454797065223A2241535349474E5F55534552222C226D6F6465223A22414E44222C227369676E223A66616C73652C226E6F626F6479223A7B2274797065223A22544F5F50415353222C2261737369676E656455736572223A5B5D7D2C2274696D654C696D6974223A7B2274696D656F7574223A7B22756E6974223A2248222C2276616C7565223A307D2C2268616E646C6572223A7B2274797065223A22524546555345222C226E6F74696679223A7B226F6E6365223A747275652C22686F7572223A317D7D7D2C2261737369676E656455736572223A5B7B22757365724964223A2232222C226E69636B4E616D65223A22E6B58BE8AF95303031222C2273656C6563746564223A66616C73657D5D2C22666F726D5065726D73223A5B5D2C2273656C6653656C656374223A7B226D756C7469706C65223A66616C73657D2C226C6561646572546F70223A7B22656E64436F6E646974696F6E223A22544F50222C22656E644C6576656C223A317D2C226C6561646572223A7B226C6576656C223A317D2C22726F6C65223A5B5D2C22726566757365223A7B2274797065223A22544F5F4245464F5245222C22746172676574223A22227D2C22666F726D55736572223A22227D7D, '[{"variableId":"1","variableTitle":"当月请假天数","operator":">","value":"3","groupType":"OR","variableCode":"leaveDaysCurrentMonth"},{"variableId":"1","variableTitle":"当月请假天数","operator":"<=","value":"3","groupType":"OR","variableCode":"leaveDaysCurrentMonth"}]', '2023-01-29 11:20:34', null, null, null, null, '2022-11-18 16:03:22', null, null, null);
INSERT INTO rouyi.t_act_hi_expand_process (id, expand_process_id, act_process_id, act_deployment_id, status, version, name, source, node_props, variable, deploy_time, tenant_id, notify_type, notify_title, remark, create_time, update_time, create_user, update_user) VALUES (9, 2, 'LEAVE2:5:cc6b208c-9f86-11ed-a8b3-c6bde56990c4', 'cc62950a-9f86-11ed-a8b3-c6bde56990c4', 1, '5', '请假流程_驳回申请人', 0x7B226964223A22726F6F74222C22706172656E744964223A6E756C6C2C2274797065223A22524F4F54222C226E616D65223A22E58F91E8B5B7E4BABA222C2264657363223A22E58F91E8B5B7E4BABA222C2270726F7073223A7B2261737369676E656455736572223A5B5D2C22666F726D5065726D73223A5B5D7D2C226368696C6472656E223A7B226964223A226E6F64655F323237323732333231383234222C22706172656E744964223A22726F6F74222C2270726F7073223A7B7D2C2274797065223A22434F4E444954494F4E53222C226E616D65223A22E69DA1E4BBB6E58886E694AF222C226368696C6472656E223A7B226964223A226E6F64655F323237323732333237303238222C22706172656E744964223A226E6F64655F323237323732333231383234222C2274797065223A22454D505459222C226368696C6472656E223A7B226964223A226E6F64655F303538393935303035303931222C22706172656E744964223A226E6F64655F323237323732333237303238222C2270726F7073223A7B2261737369676E656454797065223A2241535349474E5F55534552222C226D6F6465223A22414E44222C227369676E223A66616C73652C226E6F626F6479223A7B2274797065223A22544F5F50415353222C2261737369676E656455736572223A5B5D7D2C2274696D654C696D6974223A7B2274696D656F7574223A7B22756E6974223A2248222C2276616C7565223A307D2C2268616E646C6572223A7B2274797065223A22524546555345222C226E6F74696679223A7B226F6E6365223A747275652C22686F7572223A317D7D7D2C2261737369676E656455736572223A5B7B22757365724964223A2232222C226E69636B4E616D65223A22E6B58BE8AF95303031222C2273656C6563746564223A66616C73657D5D2C22666F726D5065726D73223A5B5D2C2273656C6653656C656374223A7B226D756C7469706C65223A66616C73657D2C226C6561646572546F70223A7B22656E64436F6E646974696F6E223A22544F50222C22656E644C6576656C223A317D2C226C6561646572223A7B226C6576656C223A317D2C22726F6C65223A5B5D2C22726566757365223A7B2274797065223A22544F5F454E44222C22746172676574223A22227D2C22666F726D55736572223A22227D2C2274797065223A22415050524F56414C222C226E616D65223A22E5AEA1E689B9E4BABA2D41222C226368696C6472656E223A7B226964223A226E6F64655F393738393038393736323439222C22706172656E744964223A226E6F64655F303538393935303035303931222C2270726F7073223A7B2261737369676E656454797065223A2241535349474E5F55534552222C226D6F6465223A22414E44222C227369676E223A66616C73652C226E6F626F6479223A7B2274797065223A22544F5F524546555345222C2261737369676E656455736572223A5B5D7D2C2274696D654C696D6974223A7B2274696D656F7574223A7B22756E6974223A2248222C2276616C7565223A307D2C2268616E646C6572223A7B2274797065223A22524546555345222C226E6F74696679223A7B226F6E6365223A747275652C22686F7572223A317D7D7D2C2261737369676E656455736572223A5B7B22757365724964223A2232222C226E69636B4E616D65223A22E6B58BE8AF95303031222C2273656C6563746564223A66616C73657D5D2C22666F726D5065726D73223A5B5D2C2273656C6653656C656374223A7B226D756C7469706C65223A66616C73657D2C226C6561646572546F70223A7B22656E64436F6E646974696F6E223A22544F50222C22656E644C6576656C223A317D2C226C6561646572223A7B226C6576656C223A317D2C22726F6C65223A5B5D2C22726566757365223A7B2274797065223A22544F5F5355424D4954544552222C22746172676574223A22227D2C22666F726D55736572223A22227D2C2274797065223A22415050524F56414C222C226E616D65223A22E5AEA1E689B9E4BABA42222C226368696C6472656E223A7B226964223A226E6F64655F353930383930393532363232222C22706172656E744964223A226E6F64655F393738393038393736323439222C2270726F7073223A7B2261737369676E656454797065223A2241535349474E5F55534552222C226D6F6465223A22414E44222C227369676E223A66616C73652C226E6F626F6479223A7B2274797065223A22544F5F50415353222C2261737369676E656455736572223A5B5D7D2C2274696D654C696D6974223A7B2274696D656F7574223A7B22756E6974223A2248222C2276616C7565223A307D2C2268616E646C6572223A7B2274797065223A22524546555345222C226E6F74696679223A7B226F6E6365223A747275652C22686F7572223A317D7D7D2C2261737369676E656455736572223A5B7B22757365724964223A2232222C226E69636B4E616D65223A22E6B58BE8AF95303031222C2273656C6563746564223A66616C73657D5D2C22666F726D5065726D73223A5B5D2C2273656C6653656C656374223A7B226D756C7469706C65223A66616C73657D2C226C6561646572546F70223A7B22656E64436F6E646974696F6E223A22544F50222C22656E644C6576656C223A317D2C226C6561646572223A7B226C6576656C223A317D2C22726F6C65223A5B5D2C22726566757365223A7B2274797065223A22544F5F4245464F5245222C22746172676574223A22227D2C22666F726D55736572223A22227D2C2274797065223A22415050524F56414C222C226E616D65223A22E5AEA1E689B9E4BABA2D43222C226368696C6472656E223A7B226964223A226E6F64655F656E645F313233222C2274797065223A22454E44222C226368696C6472656E223A7B7D2C22706172656E744964223A226E6F64655F353930383930393532363232227D7D7D7D7D2C226272616E636873223A5B7B226964223A226E6F64655F323237323732333237303839222C22706172656E744964223A226E6F64655F323237323732333231383234222C2274797065223A22434F4E444954494F4E222C2270726F7073223A7B2267726F75707354797065223A224F52222C2267726F757073223A5B7B227661726961626C654964223A2231222C227661726961626C655469746C65223A22E5BD93E69C88E8AFB7E58187E5A4A9E695B0222C226F70657261746F72223A223E222C2276616C7565223A2233222C2267726F757054797065223A224F52222C227661726961626C65436F6465223A226C656176654461797343757272656E744D6F6E7468227D5D2C2265787072657373696F6E223A22227D2C226E616D65223A22E69DA1E4BBB631222C226368696C6472656E223A7B226964223A226E6F64655F313636323135383636343730222C22706172656E744964223A226E6F64655F323237323732333237303839222C2270726F7073223A7B2273686F756C64416464223A66616C73652C2261737369676E656455736572223A5B7B22757365724964223A2231222C226E69636B4E616D65223A22E7AEA1E79086E59198222C2273656C6563746564223A66616C73657D5D2C22666F726D5065726D73223A5B5D7D2C2274797065223A224343222C226E616D65223A22E68A84E98081E4BABA222C226368696C6472656E223A7B7D7D7D2C7B226964223A226E6F64655F323237323732333239383734222C22706172656E744964223A226E6F64655F323237323732333231383234222C2274797065223A22434F4E444954494F4E222C2270726F7073223A7B2267726F75707354797065223A224F52222C2267726F757073223A5B7B227661726961626C654964223A2231222C227661726961626C655469746C65223A22E5BD93E69C88E8AFB7E58187E5A4A9E695B0222C226F70657261746F72223A223C3D222C2276616C7565223A2233222C2267726F757054797065223A224F52222C227661726961626C65436F6465223A226C656176654461797343757272656E744D6F6E7468227D5D2C2265787072657373696F6E223A22227D2C226E616D65223A22E69DA1E4BBB632222C226368696C6472656E223A7B7D7D5D7D7D, 0x7B22726F6F74223A7B2261737369676E656455736572223A5B5D2C22666F726D5065726D73223A5B5D7D2C226E6F64655F323237323732333231383234223A7B7D2C226E6F64655F323237323732333237303839223A7B2267726F75707354797065223A224F52222C2267726F757073223A5B7B227661726961626C654964223A2231222C227661726961626C655469746C65223A22E5BD93E69C88E8AFB7E58187E5A4A9E695B0222C226F70657261746F72223A223E222C2276616C7565223A2233222C2267726F757054797065223A224F52222C227661726961626C65436F6465223A226C656176654461797343757272656E744D6F6E7468227D5D2C2265787072657373696F6E223A22227D2C226E6F64655F313636323135383636343730223A7B2273686F756C64416464223A66616C73652C2261737369676E656455736572223A5B7B22757365724964223A2231222C226E69636B4E616D65223A22E7AEA1E79086E59198222C2273656C6563746564223A66616C73657D5D2C22666F726D5065726D73223A5B5D7D2C226E6F64655F323237323732333239383734223A7B2267726F75707354797065223A224F52222C2267726F757073223A5B7B227661726961626C654964223A2231222C227661726961626C655469746C65223A22E5BD93E69C88E8AFB7E58187E5A4A9E695B0222C226F70657261746F72223A223C3D222C2276616C7565223A2233222C2267726F757054797065223A224F52222C227661726961626C65436F6465223A226C656176654461797343757272656E744D6F6E7468227D5D2C2265787072657373696F6E223A22227D2C226E6F64655F303538393935303035303931223A7B2261737369676E656454797065223A2241535349474E5F55534552222C226D6F6465223A22414E44222C227369676E223A66616C73652C226E6F626F6479223A7B2274797065223A22544F5F50415353222C2261737369676E656455736572223A5B5D7D2C2274696D654C696D6974223A7B2274696D656F7574223A7B22756E6974223A2248222C2276616C7565223A307D2C2268616E646C6572223A7B2274797065223A22524546555345222C226E6F74696679223A7B226F6E6365223A747275652C22686F7572223A317D7D7D2C2261737369676E656455736572223A5B7B22757365724964223A2232222C226E69636B4E616D65223A22E6B58BE8AF95303031222C2273656C6563746564223A66616C73657D5D2C22666F726D5065726D73223A5B5D2C2273656C6653656C656374223A7B226D756C7469706C65223A66616C73657D2C226C6561646572546F70223A7B22656E64436F6E646974696F6E223A22544F50222C22656E644C6576656C223A317D2C226C6561646572223A7B226C6576656C223A317D2C22726F6C65223A5B5D2C22726566757365223A7B2274797065223A22544F5F454E44222C22746172676574223A22227D2C22666F726D55736572223A22227D2C226E6F64655F393738393038393736323439223A7B2261737369676E656454797065223A2241535349474E5F55534552222C226D6F6465223A22414E44222C227369676E223A66616C73652C226E6F626F6479223A7B2274797065223A22544F5F524546555345222C2261737369676E656455736572223A5B5D7D2C2274696D654C696D6974223A7B2274696D656F7574223A7B22756E6974223A2248222C2276616C7565223A307D2C2268616E646C6572223A7B2274797065223A22524546555345222C226E6F74696679223A7B226F6E6365223A747275652C22686F7572223A317D7D7D2C2261737369676E656455736572223A5B7B22757365724964223A2232222C226E69636B4E616D65223A22E6B58BE8AF95303031222C2273656C6563746564223A66616C73657D5D2C22666F726D5065726D73223A5B5D2C2273656C6653656C656374223A7B226D756C7469706C65223A66616C73657D2C226C6561646572546F70223A7B22656E64436F6E646974696F6E223A22544F50222C22656E644C6576656C223A317D2C226C6561646572223A7B226C6576656C223A317D2C22726F6C65223A5B5D2C22726566757365223A7B2274797065223A22544F5F5355424D4954544552222C22746172676574223A22227D2C22666F726D55736572223A22227D2C226E6F64655F353930383930393532363232223A7B2261737369676E656454797065223A2241535349474E5F55534552222C226D6F6465223A22414E44222C227369676E223A66616C73652C226E6F626F6479223A7B2274797065223A22544F5F50415353222C2261737369676E656455736572223A5B5D7D2C2274696D654C696D6974223A7B2274696D656F7574223A7B22756E6974223A2248222C2276616C7565223A307D2C2268616E646C6572223A7B2274797065223A22524546555345222C226E6F74696679223A7B226F6E6365223A747275652C22686F7572223A317D7D7D2C2261737369676E656455736572223A5B7B22757365724964223A2232222C226E69636B4E616D65223A22E6B58BE8AF95303031222C2273656C6563746564223A66616C73657D5D2C22666F726D5065726D73223A5B5D2C2273656C6653656C656374223A7B226D756C7469706C65223A66616C73657D2C226C6561646572546F70223A7B22656E64436F6E646974696F6E223A22544F50222C22656E644C6576656C223A317D2C226C6561646572223A7B226C6576656C223A317D2C22726F6C65223A5B5D2C22726566757365223A7B2274797065223A22544F5F4245464F5245222C22746172676574223A22227D2C22666F726D55736572223A22227D7D, '[{"variableId":"1","variableTitle":"当月请假天数","operator":">","value":"3","groupType":"OR","variableCode":"leaveDaysCurrentMonth"},{"variableId":"1","variableTitle":"当月请假天数","operator":"<=","value":"3","groupType":"OR","variableCode":"leaveDaysCurrentMonth"}]', '2023-01-29 11:41:22', null, null, null, null, '2022-11-18 16:03:22', null, null, null);
INSERT INTO rouyi.t_act_hi_expand_process (id, expand_process_id, act_process_id, act_deployment_id, status, version, name, source, node_props, variable, deploy_time, tenant_id, notify_type, notify_title, remark, create_time, update_time, create_user, update_user) VALUES (10, 3, 'LEAVE3:2:937bb52a-9fad-11ed-8ef9-c6bde56990c4', '93717bf8-9fad-11ed-8ef9-c6bde56990c4', 1, '2', '请假流程002', 0x7B226964223A22726F6F74222C22706172656E744964223A6E756C6C2C2274797065223A22524F4F54222C226E616D65223A22E58F91E8B5B7E4BABA222C2264657363223A22E58F91E8B5B7E4BABA222C2270726F7073223A7B2261737369676E656455736572223A5B5D2C22666F726D5065726D73223A5B5D7D2C226368696C6472656E223A7B226964223A226E6F64655F323237323732333231383234222C22706172656E744964223A22726F6F74222C2270726F7073223A7B7D2C2274797065223A22434F4E444954494F4E53222C226E616D65223A22E69DA1E4BBB6E58886E694AF222C226368696C6472656E223A7B226964223A226E6F64655F323237323732333237303238222C22706172656E744964223A226E6F64655F323237323732333231383234222C2274797065223A22454D505459222C226368696C6472656E223A7B226964223A226E6F64655F393738393038393736323439222C22706172656E744964223A226E6F64655F323237323732333237303238222C2270726F7073223A7B2261737369676E656454797065223A2241535349474E5F55534552222C226D6F6465223A22414E44222C227369676E223A66616C73652C226E6F626F6479223A7B2274797065223A22544F5F50415353222C2261737369676E656455736572223A5B5D7D2C2274696D654C696D6974223A7B2274696D656F7574223A7B22756E6974223A2248222C2276616C7565223A307D2C2268616E646C6572223A7B2274797065223A22524546555345222C226E6F74696679223A7B226F6E6365223A747275652C22686F7572223A317D7D7D2C2261737369676E656455736572223A5B7B22757365724964223A2232222C226E69636B4E616D65223A22E6B58BE8AF95303031222C2273656C6563746564223A66616C73657D5D2C22666F726D5065726D73223A5B5D2C2273656C6653656C656374223A7B226D756C7469706C65223A66616C73657D2C226C6561646572546F70223A7B22656E64436F6E646974696F6E223A22544F50222C22656E644C6576656C223A317D2C226C6561646572223A7B226C6576656C223A317D2C22726F6C65223A5B5D2C22726566757365223A7B2274797065223A22544F5F454E44222C22746172676574223A22227D2C22666F726D55736572223A22227D2C2274797065223A22415050524F56414C222C226E616D65223A22E5AEA1E689B9E4BABA222C226368696C6472656E223A7B226964223A226E6F64655F656E645F313233222C2274797065223A22454E44222C226368696C6472656E223A7B7D2C22706172656E744964223A226E6F64655F393738393038393736323439227D7D7D2C226272616E636873223A5B7B226964223A226E6F64655F323237323732333237303839222C22706172656E744964223A226E6F64655F323237323732333231383234222C2274797065223A22434F4E444954494F4E222C2270726F7073223A7B2267726F75707354797065223A224F52222C2267726F757073223A5B7B227661726961626C654964223A2231222C227661726961626C655469746C65223A22E5BD93E69C88E8AFB7E58187E5A4A9E695B0222C226F70657261746F72223A223E222C2276616C7565223A2233222C2267726F757054797065223A224F52222C227661726961626C65436F6465223A226C656176654461797343757272656E744D6F6E7468227D5D2C2265787072657373696F6E223A22227D2C226E616D65223A22E69DA1E4BBB631222C226368696C6472656E223A7B226964223A226E6F64655F313636323135383636343730222C22706172656E744964223A226E6F64655F323237323732333237303839222C2270726F7073223A7B2273686F756C64416464223A66616C73652C2261737369676E656455736572223A5B7B22757365724964223A2231222C226E69636B4E616D65223A22E7AEA1E79086E59198222C2273656C6563746564223A66616C73657D5D2C22666F726D5065726D73223A5B5D7D2C2274797065223A224343222C226E616D65223A22E68A84E98081E4BABA222C226368696C6472656E223A7B7D7D7D2C7B226964223A226E6F64655F323237323732333239383734222C22706172656E744964223A226E6F64655F323237323732333231383234222C2274797065223A22434F4E444954494F4E222C2270726F7073223A7B2267726F75707354797065223A224F52222C2267726F757073223A5B7B227661726961626C654964223A2231222C227661726961626C655469746C65223A22E5BD93E69C88E8AFB7E58187E5A4A9E695B0222C226F70657261746F72223A223C3D222C2276616C7565223A2233222C2267726F757054797065223A224F52222C227661726961626C65436F6465223A226C656176654461797343757272656E744D6F6E7468227D5D2C2265787072657373696F6E223A22227D2C226E616D65223A22E69DA1E4BBB632222C226368696C6472656E223A7B7D7D5D7D7D, 0x7B22726F6F74223A7B2261737369676E656455736572223A5B5D2C22666F726D5065726D73223A5B5D7D2C226E6F64655F323237323732333231383234223A7B7D2C226E6F64655F323237323732333237303839223A7B2267726F75707354797065223A224F52222C2267726F757073223A5B7B227661726961626C654964223A2231222C227661726961626C655469746C65223A22E5BD93E69C88E8AFB7E58187E5A4A9E695B0222C226F70657261746F72223A223E222C2276616C7565223A2233222C2267726F757054797065223A224F52222C227661726961626C65436F6465223A226C656176654461797343757272656E744D6F6E7468227D5D2C2265787072657373696F6E223A22227D2C226E6F64655F313636323135383636343730223A7B2273686F756C64416464223A66616C73652C2261737369676E656455736572223A5B7B22757365724964223A2231222C226E69636B4E616D65223A22E7AEA1E79086E59198222C2273656C6563746564223A66616C73657D5D2C22666F726D5065726D73223A5B5D7D2C226E6F64655F323237323732333239383734223A7B2267726F75707354797065223A224F52222C2267726F757073223A5B7B227661726961626C654964223A2231222C227661726961626C655469746C65223A22E5BD93E69C88E8AFB7E58187E5A4A9E695B0222C226F70657261746F72223A223C3D222C2276616C7565223A2233222C2267726F757054797065223A224F52222C227661726961626C65436F6465223A226C656176654461797343757272656E744D6F6E7468227D5D2C2265787072657373696F6E223A22227D2C226E6F64655F393738393038393736323439223A7B2261737369676E656454797065223A2241535349474E5F55534552222C226D6F6465223A22414E44222C227369676E223A66616C73652C226E6F626F6479223A7B2274797065223A22544F5F50415353222C2261737369676E656455736572223A5B5D7D2C2274696D654C696D6974223A7B2274696D656F7574223A7B22756E6974223A2248222C2276616C7565223A307D2C2268616E646C6572223A7B2274797065223A22524546555345222C226E6F74696679223A7B226F6E6365223A747275652C22686F7572223A317D7D7D2C2261737369676E656455736572223A5B7B22757365724964223A2232222C226E69636B4E616D65223A22E6B58BE8AF95303031222C2273656C6563746564223A66616C73657D5D2C22666F726D5065726D73223A5B5D2C2273656C6653656C656374223A7B226D756C7469706C65223A66616C73657D2C226C6561646572546F70223A7B22656E64436F6E646974696F6E223A22544F50222C22656E644C6576656C223A317D2C226C6561646572223A7B226C6576656C223A317D2C22726F6C65223A5B5D2C22726566757365223A7B2274797065223A22544F5F454E44222C22746172676574223A22227D2C22666F726D55736572223A22227D7D, '[{"variableId":"1","variableTitle":"当月请假天数","operator":">","value":"3","groupType":"OR","variableCode":"leaveDaysCurrentMonth"},{"variableId":"1","variableTitle":"当月请假天数","operator":"<=","value":"3","groupType":"OR","variableCode":"leaveDaysCurrentMonth"}]', '2023-01-29 16:18:57', null, null, null, null, '2022-11-18 16:03:22', null, null, null);
INSERT INTO rouyi.t_act_hi_expand_process (id, expand_process_id, act_process_id, act_deployment_id, status, version, name, source, node_props, variable, deploy_time, tenant_id, notify_type, notify_title, remark, create_time, update_time, create_user, update_user) VALUES (11, 4, 'LEAVE4:1:9f2f805d-a84a-11ed-96b5-c6bde56990c4', '9f20170b-a84a-11ed-96b5-c6bde56990c4', 1, '1', '多审批人--测试', 0x7B226964223A22726F6F74222C22706172656E744964223A6E756C6C2C2274797065223A22524F4F54222C226E616D65223A22E58F91E8B5B7E4BABA222C2264657363223A22E58F91E8B5B7E4BABA222C2270726F7073223A7B2261737369676E656455736572223A5B5D2C22666F726D5065726D73223A5B5D7D2C226368696C6472656E223A7B226964223A226E6F64655F323137313138383838383334222C22706172656E744964223A22726F6F74222C2270726F7073223A7B2261737369676E656454797065223A2241535349474E5F55534552222C226D6F6465223A224E455854222C227369676E223A66616C73652C226E6F626F6479223A7B2274797065223A22544F5F50415353222C2261737369676E656455736572223A5B5D7D2C2274696D654C696D6974223A7B2274696D656F7574223A7B22756E6974223A2248222C2276616C7565223A307D2C2268616E646C6572223A7B2274797065223A22524546555345222C226E6F74696679223A7B226F6E6365223A747275652C22686F7572223A317D7D7D2C2261737369676E656455736572223A5B7B22757365724964223A2232222C226E69636B4E616D65223A22E6B58BE8AF95303031222C2273656C6563746564223A66616C73657D2C7B22757365724964223A22313030222C226E69636B4E616D65223A227A68616E6773616E222C2273656C6563746564223A66616C73657D2C7B22757365724964223A22313031222C226E69636B4E616D65223A226C697369222C2273656C6563746564223A66616C73657D5D2C22666F726D5065726D73223A5B5D2C2273656C6653656C656374223A7B226D756C7469706C65223A66616C73657D2C226C6561646572546F70223A7B22656E64436F6E646974696F6E223A22544F50222C22656E644C6576656C223A317D2C226C6561646572223A7B226C6576656C223A317D2C22726F6C65223A5B5D2C22726566757365223A7B2274797065223A22544F5F454E44222C22746172676574223A22227D2C22666F726D55736572223A22222C226D756C7469436F6D706C65746564436F756E74223A317D2C2274797065223A22415050524F56414C222C226E616D65223A22E5AEA1E689B9E4BABA222C226368696C6472656E223A7B226964223A226E6F64655F656E645F313233222C2274797065223A22454E44222C226368696C6472656E223A7B7D2C22706172656E744964223A226E6F64655F323137313138383838383334227D7D7D, 0x7B22726F6F74223A7B2261737369676E656455736572223A5B5D2C22666F726D5065726D73223A5B5D7D2C226E6F64655F323137313138383838383334223A7B2261737369676E656454797065223A2241535349474E5F55534552222C226D6F6465223A224E455854222C227369676E223A66616C73652C226E6F626F6479223A7B2274797065223A22544F5F50415353222C2261737369676E656455736572223A5B5D7D2C2274696D654C696D6974223A7B2274696D656F7574223A7B22756E6974223A2248222C2276616C7565223A307D2C2268616E646C6572223A7B2274797065223A22524546555345222C226E6F74696679223A7B226F6E6365223A747275652C22686F7572223A317D7D7D2C2261737369676E656455736572223A5B7B22757365724964223A2232222C226E69636B4E616D65223A22E6B58BE8AF95303031222C2273656C6563746564223A66616C73657D2C7B22757365724964223A22313030222C226E69636B4E616D65223A227A68616E6773616E222C2273656C6563746564223A66616C73657D2C7B22757365724964223A22313031222C226E69636B4E616D65223A226C697369222C2273656C6563746564223A66616C73657D5D2C22666F726D5065726D73223A5B5D2C2273656C6653656C656374223A7B226D756C7469706C65223A66616C73657D2C226C6561646572546F70223A7B22656E64436F6E646974696F6E223A22544F50222C22656E644C6576656C223A317D2C226C6561646572223A7B226C6576656C223A317D2C22726F6C65223A5B5D2C22726566757365223A7B2274797065223A22544F5F454E44222C22746172676574223A22227D2C22666F726D55736572223A22222C226D756C7469436F6D706C65746564436F756E74223A317D7D, '[]', '2023-02-09 15:23:17', null, null, null, null, '2023-02-09 06:03:38', null, null, null);
INSERT INTO rouyi.t_act_hi_expand_process (id, expand_process_id, act_process_id, act_deployment_id, status, version, name, source, node_props, variable, deploy_time, tenant_id, notify_type, notify_title, remark, create_time, update_time, create_user, update_user) VALUES (12, 7, 'LEAVE7:1:3ea50912-a84b-11ed-96b5-c6bde56990c4', '3ea1fbd0-a84b-11ed-96b5-c6bde56990c4', 1, '1', '多人审批-会签同时审批', 0x7B226964223A22726F6F74222C22706172656E744964223A6E756C6C2C2274797065223A22524F4F54222C226E616D65223A22E58F91E8B5B7E4BABA222C2264657363223A22E58F91E8B5B7E4BABA222C2270726F7073223A7B2261737369676E656455736572223A5B5D2C22666F726D5065726D73223A5B5D7D2C226368696C6472656E223A7B226964223A226E6F64655F323736343935313736383534222C22706172656E744964223A22726F6F74222C2270726F7073223A7B2261737369676E656454797065223A2241535349474E5F55534552222C226D6F6465223A22414E44222C227369676E223A66616C73652C226D756C7469436F6D706C65746564436F756E74223A312C226E6F626F6479223A7B2274797065223A22544F5F50415353222C2261737369676E656455736572223A5B5D7D2C2274696D654C696D6974223A7B2274696D656F7574223A7B22756E6974223A2248222C2276616C7565223A307D2C2268616E646C6572223A7B2274797065223A22524546555345222C226E6F74696679223A7B226F6E6365223A747275652C22686F7572223A317D7D7D2C2261737369676E656455736572223A5B7B22757365724964223A2232222C226E69636B4E616D65223A22E6B58BE8AF95303031222C2273656C6563746564223A66616C73657D2C7B22757365724964223A22313030222C226E69636B4E616D65223A227A68616E6773616E222C2273656C6563746564223A66616C73657D2C7B22757365724964223A22313031222C226E69636B4E616D65223A226C697369222C2273656C6563746564223A66616C73657D5D2C22666F726D5065726D73223A5B5D2C2273656C6653656C656374223A7B226D756C7469706C65223A66616C73657D2C226C6561646572546F70223A7B22656E64436F6E646974696F6E223A22544F50222C22656E644C6576656C223A317D2C226C6561646572223A7B226C6576656C223A317D2C22726F6C65223A5B5D2C22726566757365223A7B2274797065223A22544F5F454E44222C22746172676574223A22227D2C22666F726D55736572223A22227D2C2274797065223A22415050524F56414C222C226E616D65223A22E5AEA1E689B9E4BABA222C226368696C6472656E223A7B226964223A226E6F64655F656E645F313233222C2274797065223A22454E44222C226368696C6472656E223A7B7D2C22706172656E744964223A226E6F64655F323736343935313736383534227D7D7D, 0x7B22726F6F74223A7B2261737369676E656455736572223A5B5D2C22666F726D5065726D73223A5B5D7D2C226E6F64655F323736343935313736383534223A7B2261737369676E656454797065223A2241535349474E5F55534552222C226D6F6465223A22414E44222C227369676E223A66616C73652C226D756C7469436F6D706C65746564436F756E74223A312C226E6F626F6479223A7B2274797065223A22544F5F50415353222C2261737369676E656455736572223A5B5D7D2C2274696D654C696D6974223A7B2274696D656F7574223A7B22756E6974223A2248222C2276616C7565223A307D2C2268616E646C6572223A7B2274797065223A22524546555345222C226E6F74696679223A7B226F6E6365223A747275652C22686F7572223A317D7D7D2C2261737369676E656455736572223A5B7B22757365724964223A2232222C226E69636B4E616D65223A22E6B58BE8AF95303031222C2273656C6563746564223A66616C73657D2C7B22757365724964223A22313030222C226E69636B4E616D65223A227A68616E6773616E222C2273656C6563746564223A66616C73657D2C7B22757365724964223A22313031222C226E69636B4E616D65223A226C697369222C2273656C6563746564223A66616C73657D5D2C22666F726D5065726D73223A5B5D2C2273656C6653656C656374223A7B226D756C7469706C65223A66616C73657D2C226C6561646572546F70223A7B22656E64436F6E646974696F6E223A22544F50222C22656E644C6576656C223A317D2C226C6561646572223A7B226C6576656C223A317D2C22726F6C65223A5B5D2C22726566757365223A7B2274797065223A22544F5F454E44222C22746172676574223A22227D2C22666F726D55736572223A22227D7D, '[]', '2023-02-09 15:27:44', null, null, null, null, '2023-02-09 07:27:44', null, null, null);
INSERT INTO rouyi.t_act_hi_expand_process (id, expand_process_id, act_process_id, act_deployment_id, status, version, name, source, node_props, variable, deploy_time, tenant_id, notify_type, notify_title, remark, create_time, update_time, create_user, update_user) VALUES (13, 8, 'LEAVE_8:1:7a4f3864-a852-11ed-80f3-c6bde56990c4', '7a3ff622-a852-11ed-80f3-c6bde56990c4', 1, '1', '测试-限时审批', 0x7B226964223A22726F6F74222C22706172656E744964223A6E756C6C2C2274797065223A22524F4F54222C226E616D65223A22E58F91E8B5B7E4BABA222C2264657363223A22E58F91E8B5B7E4BABA222C2270726F7073223A7B2261737369676E656455736572223A5B5D2C22666F726D5065726D73223A5B5D7D2C226368696C6472656E223A7B226964223A226E6F64655F333037313430353237383635222C22706172656E744964223A22726F6F74222C2270726F7073223A7B2261737369676E656454797065223A2241535349474E5F55534552222C226D6F6465223A22414E44222C227369676E223A66616C73652C226D756C7469436F6D706C65746564436F756E74223A312C226E6F626F6479223A7B2274797065223A22544F5F50415353222C2261737369676E656455736572223A5B5D7D2C2274696D654C696D6974223A7B2274696D656F7574223A7B22756E6974223A2248222C2276616C7565223A2231227D2C2268616E646C6572223A7B2274797065223A224E4F54494659222C226E6F74696679223A7B226F6E6365223A66616C73652C22686F7572223A317D7D7D2C2261737369676E656455736572223A5B7B22757365724964223A2232222C226E69636B4E616D65223A22E6B58BE8AF95303031222C2273656C6563746564223A66616C73657D5D2C22666F726D5065726D73223A5B5D2C2273656C6653656C656374223A7B226D756C7469706C65223A66616C73657D2C226C6561646572546F70223A7B22656E64436F6E646974696F6E223A22544F50222C22656E644C6576656C223A317D2C226C6561646572223A7B226C6576656C223A317D2C22726F6C65223A5B5D2C22726566757365223A7B2274797065223A22544F5F454E44222C22746172676574223A22227D2C22666F726D55736572223A22227D2C2274797065223A22415050524F56414C222C226E616D65223A22E5AEA1E689B9E4BABA222C226368696C6472656E223A7B226964223A226E6F64655F656E645F313233222C2274797065223A22454E44222C226368696C6472656E223A7B7D2C22706172656E744964223A226E6F64655F333037313430353237383635227D7D7D, 0x7B22726F6F74223A7B2261737369676E656455736572223A5B5D2C22666F726D5065726D73223A5B5D7D2C226E6F64655F333037313430353237383635223A7B2261737369676E656454797065223A2241535349474E5F55534552222C226D6F6465223A22414E44222C227369676E223A66616C73652C226D756C7469436F6D706C65746564436F756E74223A312C226E6F626F6479223A7B2274797065223A22544F5F50415353222C2261737369676E656455736572223A5B5D7D2C2274696D654C696D6974223A7B2274696D656F7574223A7B22756E6974223A2248222C2276616C7565223A2231227D2C2268616E646C6572223A7B2274797065223A224E4F54494659222C226E6F74696679223A7B226F6E6365223A66616C73652C22686F7572223A317D7D7D2C2261737369676E656455736572223A5B7B22757365724964223A2232222C226E69636B4E616D65223A22E6B58BE8AF95303031222C2273656C6563746564223A66616C73657D5D2C22666F726D5065726D73223A5B5D2C2273656C6653656C656374223A7B226D756C7469706C65223A66616C73657D2C226C6561646572546F70223A7B22656E64436F6E646974696F6E223A22544F50222C22656E644C6576656C223A317D2C226C6561646572223A7B226C6576656C223A317D2C22726F6C65223A5B5D2C22726566757365223A7B2274797065223A22544F5F454E44222C22746172676574223A22227D2C22666F726D55736572223A22227D7D, '[]', '2023-02-09 16:19:31', null, null, null, null, '2023-02-09 08:19:30', null, null, null);
INSERT INTO rouyi.t_act_hi_expand_process (id, expand_process_id, act_process_id, act_deployment_id, status, version, name, source, node_props, variable, deploy_time, tenant_id, notify_type, notify_title, remark, create_time, update_time, create_user, update_user) VALUES (14, 8, 'LEAVE_8:2:afc7ae30-a85c-11ed-92c1-c6bde56990c4', 'afc256fe-a85c-11ed-92c1-c6bde56990c4', 1, '2', '测试-限时审批', 0x7B226964223A22726F6F74222C22706172656E744964223A6E756C6C2C2274797065223A22524F4F54222C226E616D65223A22E58F91E8B5B7E4BABA222C2264657363223A22E58F91E8B5B7E4BABA222C2270726F7073223A7B2261737369676E656455736572223A5B5D2C22666F726D5065726D73223A5B5D7D2C226368696C6472656E223A7B226964223A226E6F64655F333037313430353237383635222C22706172656E744964223A22726F6F74222C2270726F7073223A7B2261737369676E656454797065223A2241535349474E5F55534552222C226D6F6465223A22414E44222C227369676E223A66616C73652C226D756C7469436F6D706C65746564436F756E74223A312C226E6F626F6479223A7B2274797065223A22544F5F50415353222C2261737369676E656455736572223A5B5D7D2C2274696D654C696D6974223A7B2274696D656F7574223A7B22756E6974223A2248222C2276616C7565223A2231227D2C2268616E646C6572223A7B2274797065223A224E4F54494659222C226E6F74696679223A7B226F6E6365223A66616C73652C22686F7572223A317D7D7D2C2261737369676E656455736572223A5B7B22757365724964223A2232222C226E69636B4E616D65223A22E6B58BE8AF95303031222C2273656C6563746564223A66616C73657D5D2C22666F726D5065726D73223A5B5D2C2273656C6653656C656374223A7B226D756C7469706C65223A66616C73657D2C226C6561646572546F70223A7B22656E64436F6E646974696F6E223A22544F50222C22656E644C6576656C223A317D2C226C6561646572223A7B226C6576656C223A317D2C22726F6C65223A5B5D2C22726566757365223A7B2274797065223A22544F5F454E44222C22746172676574223A22227D2C22666F726D55736572223A22227D2C2274797065223A22415050524F56414C222C226E616D65223A22E5AEA1E689B9E4BABA222C226368696C6472656E223A7B226964223A226E6F64655F656E645F313233222C2274797065223A22454E44222C226368696C6472656E223A7B7D2C22706172656E744964223A226E6F64655F333037313430353237383635227D7D7D, 0x7B22726F6F74223A7B2261737369676E656455736572223A5B5D2C22666F726D5065726D73223A5B5D7D2C226E6F64655F333037313430353237383635223A7B2261737369676E656454797065223A2241535349474E5F55534552222C226D6F6465223A22414E44222C227369676E223A66616C73652C226D756C7469436F6D706C65746564436F756E74223A312C226E6F626F6479223A7B2274797065223A22544F5F50415353222C2261737369676E656455736572223A5B5D7D2C2274696D654C696D6974223A7B2274696D656F7574223A7B22756E6974223A2248222C2276616C7565223A2231227D2C2268616E646C6572223A7B2274797065223A224E4F54494659222C226E6F74696679223A7B226F6E6365223A66616C73652C22686F7572223A317D7D7D2C2261737369676E656455736572223A5B7B22757365724964223A2232222C226E69636B4E616D65223A22E6B58BE8AF95303031222C2273656C6563746564223A66616C73657D5D2C22666F726D5065726D73223A5B5D2C2273656C6653656C656374223A7B226D756C7469706C65223A66616C73657D2C226C6561646572546F70223A7B22656E64436F6E646974696F6E223A22544F50222C22656E644C6576656C223A317D2C226C6561646572223A7B226C6576656C223A317D2C22726F6C65223A5B5D2C22726566757365223A7B2274797065223A22544F5F454E44222C22746172676574223A22227D2C22666F726D55736572223A22227D7D, '[]', '2023-02-09 17:32:35', null, null, null, null, '2023-02-09 08:19:30', null, null, null);
INSERT INTO rouyi.t_act_hi_expand_process (id, expand_process_id, act_process_id, act_deployment_id, status, version, name, source, node_props, variable, deploy_time, tenant_id, notify_type, notify_title, remark, create_time, update_time, create_user, update_user) VALUES (15, 8, 'LEAVE_8:3:12c5c88c-a85d-11ed-92c1-c6bde56990c4', '12c1f7fa-a85d-11ed-92c1-c6bde56990c4', 1, '3', '测试-限时审批', 0x7B226964223A22726F6F74222C22706172656E744964223A6E756C6C2C2274797065223A22524F4F54222C226E616D65223A22E58F91E8B5B7E4BABA222C2264657363223A22E58F91E8B5B7E4BABA222C2270726F7073223A7B2261737369676E656455736572223A5B5D2C22666F726D5065726D73223A5B5D7D2C226368696C6472656E223A7B226964223A226E6F64655F333037313430353237383635222C22706172656E744964223A22726F6F74222C2270726F7073223A7B2261737369676E656454797065223A2241535349474E5F55534552222C226D6F6465223A22414E44222C227369676E223A66616C73652C226D756C7469436F6D706C65746564436F756E74223A312C226E6F626F6479223A7B2274797065223A22544F5F50415353222C2261737369676E656455736572223A5B5D7D2C2274696D654C696D6974223A7B2274696D656F7574223A7B22756E6974223A2248222C2276616C7565223A2231227D2C2268616E646C6572223A7B2274797065223A224E4F54494659222C226E6F74696679223A7B226F6E6365223A66616C73652C22686F7572223A317D7D7D2C2261737369676E656455736572223A5B7B22757365724964223A2232222C226E69636B4E616D65223A22E6B58BE8AF95303031222C2273656C6563746564223A66616C73657D5D2C22666F726D5065726D73223A5B5D2C2273656C6653656C656374223A7B226D756C7469706C65223A66616C73657D2C226C6561646572546F70223A7B22656E64436F6E646974696F6E223A22544F50222C22656E644C6576656C223A317D2C226C6561646572223A7B226C6576656C223A317D2C22726F6C65223A5B5D2C22726566757365223A7B2274797065223A22544F5F454E44222C22746172676574223A22227D2C22666F726D55736572223A22227D2C2274797065223A22415050524F56414C222C226E616D65223A22E5AEA1E689B9E4BABA222C226368696C6472656E223A7B226964223A226E6F64655F656E645F313233222C2274797065223A22454E44222C226368696C6472656E223A7B7D2C22706172656E744964223A226E6F64655F333037313430353237383635227D7D7D, 0x7B22726F6F74223A7B2261737369676E656455736572223A5B5D2C22666F726D5065726D73223A5B5D7D2C226E6F64655F333037313430353237383635223A7B2261737369676E656454797065223A2241535349474E5F55534552222C226D6F6465223A22414E44222C227369676E223A66616C73652C226D756C7469436F6D706C65746564436F756E74223A312C226E6F626F6479223A7B2274797065223A22544F5F50415353222C2261737369676E656455736572223A5B5D7D2C2274696D654C696D6974223A7B2274696D656F7574223A7B22756E6974223A2248222C2276616C7565223A2231227D2C2268616E646C6572223A7B2274797065223A224E4F54494659222C226E6F74696679223A7B226F6E6365223A66616C73652C22686F7572223A317D7D7D2C2261737369676E656455736572223A5B7B22757365724964223A2232222C226E69636B4E616D65223A22E6B58BE8AF95303031222C2273656C6563746564223A66616C73657D5D2C22666F726D5065726D73223A5B5D2C2273656C6653656C656374223A7B226D756C7469706C65223A66616C73657D2C226C6561646572546F70223A7B22656E64436F6E646974696F6E223A22544F50222C22656E644C6576656C223A317D2C226C6561646572223A7B226C6576656C223A317D2C22726F6C65223A5B5D2C22726566757365223A7B2274797065223A22544F5F454E44222C22746172676574223A22227D2C22666F726D55736572223A22227D7D, '[]', '2023-02-09 17:35:21', null, null, null, null, '2023-02-09 08:19:30', null, null, null);
INSERT INTO rouyi.t_act_hi_expand_process (id, expand_process_id, act_process_id, act_deployment_id, status, version, name, source, node_props, variable, deploy_time, tenant_id, notify_type, notify_title, remark, create_time, update_time, create_user, update_user) VALUES (16, 8, 'LEAVE_8:4:398ae78c-a85e-11ed-92c1-c6bde56990c4', '39873e0a-a85e-11ed-92c1-c6bde56990c4', 1, '4', '测试-限时审批', 0x7B226964223A22726F6F74222C22706172656E744964223A6E756C6C2C2274797065223A22524F4F54222C226E616D65223A22E58F91E8B5B7E4BABA222C2264657363223A22E58F91E8B5B7E4BABA222C2270726F7073223A7B2261737369676E656455736572223A5B5D2C22666F726D5065726D73223A5B5D7D2C226368696C6472656E223A7B226964223A226E6F64655F333037313430353237383635222C22706172656E744964223A22726F6F74222C2270726F7073223A7B2261737369676E656454797065223A2241535349474E5F55534552222C226D6F6465223A22414E44222C227369676E223A66616C73652C226D756C7469436F6D706C65746564436F756E74223A312C226E6F626F6479223A7B2274797065223A22544F5F50415353222C2261737369676E656455736572223A5B5D7D2C2274696D654C696D6974223A7B2274696D656F7574223A7B22756E6974223A2248222C2276616C7565223A2231227D2C2268616E646C6572223A7B2274797065223A224E4F54494659222C226E6F74696679223A7B226F6E6365223A66616C73652C22686F7572223A317D7D7D2C2261737369676E656455736572223A5B7B22757365724964223A2232222C226E69636B4E616D65223A22E6B58BE8AF95303031222C2273656C6563746564223A66616C73657D5D2C22666F726D5065726D73223A5B5D2C2273656C6653656C656374223A7B226D756C7469706C65223A66616C73657D2C226C6561646572546F70223A7B22656E64436F6E646974696F6E223A22544F50222C22656E644C6576656C223A317D2C226C6561646572223A7B226C6576656C223A317D2C22726F6C65223A5B5D2C22726566757365223A7B2274797065223A22544F5F454E44222C22746172676574223A22227D2C22666F726D55736572223A22227D2C2274797065223A22415050524F56414C222C226E616D65223A22E5AEA1E689B9E4BABA222C226368696C6472656E223A7B226964223A226E6F64655F656E645F313233222C2274797065223A22454E44222C226368696C6472656E223A7B7D2C22706172656E744964223A226E6F64655F333037313430353237383635227D7D7D, 0x7B22726F6F74223A7B2261737369676E656455736572223A5B5D2C22666F726D5065726D73223A5B5D7D2C226E6F64655F333037313430353237383635223A7B2261737369676E656454797065223A2241535349474E5F55534552222C226D6F6465223A22414E44222C227369676E223A66616C73652C226D756C7469436F6D706C65746564436F756E74223A312C226E6F626F6479223A7B2274797065223A22544F5F50415353222C2261737369676E656455736572223A5B5D7D2C2274696D654C696D6974223A7B2274696D656F7574223A7B22756E6974223A2248222C2276616C7565223A2231227D2C2268616E646C6572223A7B2274797065223A224E4F54494659222C226E6F74696679223A7B226F6E6365223A66616C73652C22686F7572223A317D7D7D2C2261737369676E656455736572223A5B7B22757365724964223A2232222C226E69636B4E616D65223A22E6B58BE8AF95303031222C2273656C6563746564223A66616C73657D5D2C22666F726D5065726D73223A5B5D2C2273656C6653656C656374223A7B226D756C7469706C65223A66616C73657D2C226C6561646572546F70223A7B22656E64436F6E646974696F6E223A22544F50222C22656E644C6576656C223A317D2C226C6561646572223A7B226C6576656C223A317D2C22726F6C65223A5B5D2C22726566757365223A7B2274797065223A22544F5F454E44222C22746172676574223A22227D2C22666F726D55736572223A22227D7D, '[]', '2023-02-09 17:43:36', null, null, null, null, '2023-02-09 08:19:30', null, null, null);
INSERT INTO rouyi.t_act_hi_expand_process (id, expand_process_id, act_process_id, act_deployment_id, status, version, name, source, node_props, variable, deploy_time, tenant_id, notify_type, notify_title, remark, create_time, update_time, create_user, update_user) VALUES (17, 8, 'LEAVE_8:5:ee9a605c-a85e-11ed-92c1-c6bde56990c4', 'ee972c0a-a85e-11ed-92c1-c6bde56990c4', 1, '5', '测试-限时审批', 0x7B226964223A22726F6F74222C22706172656E744964223A6E756C6C2C2274797065223A22524F4F54222C226E616D65223A22E58F91E8B5B7E4BABA222C2264657363223A22E58F91E8B5B7E4BABA222C2270726F7073223A7B2261737369676E656455736572223A5B5D2C22666F726D5065726D73223A5B5D7D2C226368696C6472656E223A7B226964223A226E6F64655F333037313430353237383635222C22706172656E744964223A22726F6F74222C2270726F7073223A7B2261737369676E656454797065223A2241535349474E5F55534552222C226D6F6465223A22414E44222C227369676E223A66616C73652C226D756C7469436F6D706C65746564436F756E74223A312C226E6F626F6479223A7B2274797065223A22544F5F50415353222C2261737369676E656455736572223A5B5D7D2C2274696D654C696D6974223A7B2274696D656F7574223A7B22756E6974223A2248222C2276616C7565223A2231227D2C2268616E646C6572223A7B2274797065223A224E4F54494659222C226E6F74696679223A7B226F6E6365223A66616C73652C22686F7572223A317D7D7D2C2261737369676E656455736572223A5B7B22757365724964223A2232222C226E69636B4E616D65223A22E6B58BE8AF95303031222C2273656C6563746564223A66616C73657D5D2C22666F726D5065726D73223A5B5D2C2273656C6653656C656374223A7B226D756C7469706C65223A66616C73657D2C226C6561646572546F70223A7B22656E64436F6E646974696F6E223A22544F50222C22656E644C6576656C223A317D2C226C6561646572223A7B226C6576656C223A317D2C22726F6C65223A5B5D2C22726566757365223A7B2274797065223A22544F5F454E44222C22746172676574223A22227D2C22666F726D55736572223A22227D2C2274797065223A22415050524F56414C222C226E616D65223A22E5AEA1E689B9E4BABA222C226368696C6472656E223A7B226964223A226E6F64655F656E645F313233222C2274797065223A22454E44222C226368696C6472656E223A7B7D2C22706172656E744964223A226E6F64655F333037313430353237383635227D7D7D, 0x7B22726F6F74223A7B2261737369676E656455736572223A5B5D2C22666F726D5065726D73223A5B5D7D2C226E6F64655F333037313430353237383635223A7B2261737369676E656454797065223A2241535349474E5F55534552222C226D6F6465223A22414E44222C227369676E223A66616C73652C226D756C7469436F6D706C65746564436F756E74223A312C226E6F626F6479223A7B2274797065223A22544F5F50415353222C2261737369676E656455736572223A5B5D7D2C2274696D654C696D6974223A7B2274696D656F7574223A7B22756E6974223A2248222C2276616C7565223A2231227D2C2268616E646C6572223A7B2274797065223A224E4F54494659222C226E6F74696679223A7B226F6E6365223A66616C73652C22686F7572223A317D7D7D2C2261737369676E656455736572223A5B7B22757365724964223A2232222C226E69636B4E616D65223A22E6B58BE8AF95303031222C2273656C6563746564223A66616C73657D5D2C22666F726D5065726D73223A5B5D2C2273656C6653656C656374223A7B226D756C7469706C65223A66616C73657D2C226C6561646572546F70223A7B22656E64436F6E646974696F6E223A22544F50222C22656E644C6576656C223A317D2C226C6561646572223A7B226C6576656C223A317D2C22726F6C65223A5B5D2C22726566757365223A7B2274797065223A22544F5F454E44222C22746172676574223A22227D2C22666F726D55736572223A22227D7D, '[]', '2023-02-09 17:48:40', null, null, null, null, '2023-02-09 08:19:30', null, null, null);
INSERT INTO rouyi.t_act_hi_expand_process (id, expand_process_id, act_process_id, act_deployment_id, status, version, name, source, node_props, variable, deploy_time, tenant_id, notify_type, notify_title, remark, create_time, update_time, create_user, update_user) VALUES (18, 8, 'LEAVE_8:6:befa3a09-a860-11ed-883b-c6bde56990c4', 'bef4e2d7-a860-11ed-883b-c6bde56990c4', 1, '6', '测试-限时审批', 0x7B226964223A22726F6F74222C22706172656E744964223A6E756C6C2C2274797065223A22524F4F54222C226E616D65223A22E58F91E8B5B7E4BABA222C2264657363223A22E58F91E8B5B7E4BABA222C2270726F7073223A7B2261737369676E656455736572223A5B5D2C22666F726D5065726D73223A5B5D7D2C226368696C6472656E223A7B226964223A226E6F64655F333037313430353237383635222C22706172656E744964223A22726F6F74222C2270726F7073223A7B2261737369676E656454797065223A2241535349474E5F55534552222C226D6F6465223A22414E44222C227369676E223A66616C73652C226D756C7469436F6D706C65746564436F756E74223A312C226E6F626F6479223A7B2274797065223A22544F5F50415353222C2261737369676E656455736572223A5B5D7D2C2274696D654C696D6974223A7B2274696D656F7574223A7B22756E6974223A2248222C2276616C7565223A2231227D2C2268616E646C6572223A7B2274797065223A224E4F54494659222C226E6F74696679223A7B226F6E6365223A66616C73652C22686F7572223A317D7D7D2C2261737369676E656455736572223A5B7B22757365724964223A2232222C226E69636B4E616D65223A22E6B58BE8AF95303031222C2273656C6563746564223A66616C73657D5D2C22666F726D5065726D73223A5B5D2C2273656C6653656C656374223A7B226D756C7469706C65223A66616C73657D2C226C6561646572546F70223A7B22656E64436F6E646974696F6E223A22544F50222C22656E644C6576656C223A317D2C226C6561646572223A7B226C6576656C223A317D2C22726F6C65223A5B5D2C22726566757365223A7B2274797065223A22544F5F454E44222C22746172676574223A22227D2C22666F726D55736572223A22227D2C2274797065223A22415050524F56414C222C226E616D65223A22E5AEA1E689B9E4BABA222C226368696C6472656E223A7B226964223A226E6F64655F656E645F313233222C2274797065223A22454E44222C226368696C6472656E223A7B7D2C22706172656E744964223A226E6F64655F333037313430353237383635227D7D7D, 0x7B22726F6F74223A7B2261737369676E656455736572223A5B5D2C22666F726D5065726D73223A5B5D7D2C226E6F64655F333037313430353237383635223A7B2261737369676E656454797065223A2241535349474E5F55534552222C226D6F6465223A22414E44222C227369676E223A66616C73652C226D756C7469436F6D706C65746564436F756E74223A312C226E6F626F6479223A7B2274797065223A22544F5F50415353222C2261737369676E656455736572223A5B5D7D2C2274696D654C696D6974223A7B2274696D656F7574223A7B22756E6974223A2248222C2276616C7565223A2231227D2C2268616E646C6572223A7B2274797065223A224E4F54494659222C226E6F74696679223A7B226F6E6365223A66616C73652C22686F7572223A317D7D7D2C2261737369676E656455736572223A5B7B22757365724964223A2232222C226E69636B4E616D65223A22E6B58BE8AF95303031222C2273656C6563746564223A66616C73657D5D2C22666F726D5065726D73223A5B5D2C2273656C6653656C656374223A7B226D756C7469706C65223A66616C73657D2C226C6561646572546F70223A7B22656E64436F6E646974696F6E223A22544F50222C22656E644C6576656C223A317D2C226C6561646572223A7B226C6576656C223A317D2C22726F6C65223A5B5D2C22726566757365223A7B2274797065223A22544F5F454E44222C22746172676574223A22227D2C22666F726D55736572223A22227D7D, '[]', '2023-02-09 18:01:39', null, null, null, null, '2023-02-09 08:19:30', null, null, null);



INSERT INTO sys_config (config_id, config_name, config_key, config_value, config_type, create_by, create_time, update_by, update_time, remark) VALUES (1, '主框架页-默认皮肤样式名称', 'sys.index.skinName', 'skin-blue', 'Y', 'admin', '2022-10-31 05:57:51', '', null, '蓝色 skin-blue、绿色 skin-green、紫色 skin-purple、红色 skin-red、黄色 skin-yellow');
INSERT INTO sys_config (config_id, config_name, config_key, config_value, config_type, create_by, create_time, update_by, update_time, remark) VALUES (2, '用户管理-账号初始密码', 'sys.user.initPassword', '123456', 'Y', 'admin', '2022-10-31 05:57:51', '', null, '初始化密码 123456');
INSERT INTO sys_config (config_id, config_name, config_key, config_value, config_type, create_by, create_time, update_by, update_time, remark) VALUES (3, '主框架页-侧边栏主题', 'sys.index.sideTheme', 'theme-dark', 'Y', 'admin', '2022-10-31 05:57:51', '', null, '深色主题theme-dark，浅色主题theme-light');
INSERT INTO sys_config (config_id, config_name, config_key, config_value, config_type, create_by, create_time, update_by, update_time, remark) VALUES (4, '账号自助-验证码开关', 'sys.account.captchaEnabled', 'true', 'Y', 'admin', '2022-10-31 05:57:51', '', null, '是否开启验证码功能（true开启，false关闭）');
INSERT INTO sys_config (config_id, config_name, config_key, config_value, config_type, create_by, create_time, update_by, update_time, remark) VALUES (5, '账号自助-是否开启用户注册功能', 'sys.account.registerUser', 'false', 'Y', 'admin', '2022-10-31 05:57:51', '', null, '是否开启注册用户功能（true开启，false关闭）');

INSERT INTO sys_dept (dept_id, parent_id, ancestors, dept_name, order_num, leader, phone, email, status, del_flag, create_by, create_time, update_by, update_time) VALUES (100, 0, '0', '若依科技', 0, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2022-10-31 05:57:45', '', null);
INSERT INTO sys_dept (dept_id, parent_id, ancestors, dept_name, order_num, leader, phone, email, status, del_flag, create_by, create_time, update_by, update_time) VALUES (101, 100, '0,100', '深圳总公司', 1, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2022-10-31 05:57:45', '', null);
INSERT INTO sys_dept (dept_id, parent_id, ancestors, dept_name, order_num, leader, phone, email, status, del_flag, create_by, create_time, update_by, update_time) VALUES (102, 100, '0,100', '长沙分公司', 2, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2022-10-31 05:57:45', '', null);
INSERT INTO sys_dept (dept_id, parent_id, ancestors, dept_name, order_num, leader, phone, email, status, del_flag, create_by, create_time, update_by, update_time) VALUES (103, 101, '0,100,101', '研发部门', 1, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2022-10-31 05:57:45', '', null);
INSERT INTO sys_dept (dept_id, parent_id, ancestors, dept_name, order_num, leader, phone, email, status, del_flag, create_by, create_time, update_by, update_time) VALUES (104, 101, '0,100,101', '市场部门', 2, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2022-10-31 05:57:45', '', null);
INSERT INTO sys_dept (dept_id, parent_id, ancestors, dept_name, order_num, leader, phone, email, status, del_flag, create_by, create_time, update_by, update_time) VALUES (105, 101, '0,100,101', '测试部门', 3, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2022-10-31 05:57:45', '', null);
INSERT INTO sys_dept (dept_id, parent_id, ancestors, dept_name, order_num, leader, phone, email, status, del_flag, create_by, create_time, update_by, update_time) VALUES (106, 101, '0,100,101', '财务部门', 4, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2022-10-31 05:57:45', '', null);
INSERT INTO sys_dept (dept_id, parent_id, ancestors, dept_name, order_num, leader, phone, email, status, del_flag, create_by, create_time, update_by, update_time) VALUES (107, 101, '0,100,101', '运维部门', 5, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2022-10-31 05:57:45', '', null);
INSERT INTO sys_dept (dept_id, parent_id, ancestors, dept_name, order_num, leader, phone, email, status, del_flag, create_by, create_time, update_by, update_time) VALUES (108, 102, '0,100,102', '市场部门', 1, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2022-10-31 05:57:45', '', null);
INSERT INTO sys_dept (dept_id, parent_id, ancestors, dept_name, order_num, leader, phone, email, status, del_flag, create_by, create_time, update_by, update_time) VALUES (109, 102, '0,100,102', '财务部门', 2, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2022-10-31 05:57:45', '', null);


INSERT INTO sys_dict_data (dict_code, dict_sort, dict_label, dict_value, dict_type, css_class, list_class, is_default, status, create_by, create_time, update_by, update_time, remark) VALUES (1, 1, '男', '0', 'sys_user_sex', '', '', 'Y', '0', 'admin', '2022-10-31 05:57:50', '', null, '性别男');
INSERT INTO sys_dict_data (dict_code, dict_sort, dict_label, dict_value, dict_type, css_class, list_class, is_default, status, create_by, create_time, update_by, update_time, remark) VALUES (2, 2, '女', '1', 'sys_user_sex', '', '', 'N', '0', 'admin', '2022-10-31 05:57:50', '', null, '性别女');
INSERT INTO sys_dict_data (dict_code, dict_sort, dict_label, dict_value, dict_type, css_class, list_class, is_default, status, create_by, create_time, update_by, update_time, remark) VALUES (3, 3, '未知', '2', 'sys_user_sex', '', '', 'N', '0', 'admin', '2022-10-31 05:57:50', '', null, '性别未知');
INSERT INTO sys_dict_data (dict_code, dict_sort, dict_label, dict_value, dict_type, css_class, list_class, is_default, status, create_by, create_time, update_by, update_time, remark) VALUES (4, 1, '显示', '0', 'sys_show_hide', '', 'primary', 'Y', '0', 'admin', '2022-10-31 05:57:50', '', null, '显示菜单');
INSERT INTO sys_dict_data (dict_code, dict_sort, dict_label, dict_value, dict_type, css_class, list_class, is_default, status, create_by, create_time, update_by, update_time, remark) VALUES (5, 2, '隐藏', '1', 'sys_show_hide', '', 'danger', 'N', '0', 'admin', '2022-10-31 05:57:50', '', null, '隐藏菜单');
INSERT INTO sys_dict_data (dict_code, dict_sort, dict_label, dict_value, dict_type, css_class, list_class, is_default, status, create_by, create_time, update_by, update_time, remark) VALUES (6, 1, '正常', '0', 'sys_normal_disable', '', 'primary', 'Y', '0', 'admin', '2022-10-31 05:57:50', '', null, '正常状态');
INSERT INTO sys_dict_data (dict_code, dict_sort, dict_label, dict_value, dict_type, css_class, list_class, is_default, status, create_by, create_time, update_by, update_time, remark) VALUES (7, 2, '停用', '1', 'sys_normal_disable', '', 'danger', 'N', '0', 'admin', '2022-10-31 05:57:50', '', null, '停用状态');
INSERT INTO sys_dict_data (dict_code, dict_sort, dict_label, dict_value, dict_type, css_class, list_class, is_default, status, create_by, create_time, update_by, update_time, remark) VALUES (8, 1, '正常', '0', 'sys_job_status', '', 'primary', 'Y', '0', 'admin', '2022-10-31 05:57:50', '', null, '正常状态');
INSERT INTO sys_dict_data (dict_code, dict_sort, dict_label, dict_value, dict_type, css_class, list_class, is_default, status, create_by, create_time, update_by, update_time, remark) VALUES (9, 2, '暂停', '1', 'sys_job_status', '', 'danger', 'N', '0', 'admin', '2022-10-31 05:57:50', '', null, '停用状态');
INSERT INTO sys_dict_data (dict_code, dict_sort, dict_label, dict_value, dict_type, css_class, list_class, is_default, status, create_by, create_time, update_by, update_time, remark) VALUES (10, 1, '默认', 'DEFAULT', 'sys_job_group', '', '', 'Y', '0', 'admin', '2022-10-31 05:57:50', '', null, '默认分组');
INSERT INTO sys_dict_data (dict_code, dict_sort, dict_label, dict_value, dict_type, css_class, list_class, is_default, status, create_by, create_time, update_by, update_time, remark) VALUES (11, 2, '系统', 'SYSTEM', 'sys_job_group', '', '', 'N', '0', 'admin', '2022-10-31 05:57:50', '', null, '系统分组');
INSERT INTO sys_dict_data (dict_code, dict_sort, dict_label, dict_value, dict_type, css_class, list_class, is_default, status, create_by, create_time, update_by, update_time, remark) VALUES (12, 1, '是', 'Y', 'sys_yes_no', '', 'primary', 'Y', '0', 'admin', '2022-10-31 05:57:50', '', null, '系统默认是');
INSERT INTO sys_dict_data (dict_code, dict_sort, dict_label, dict_value, dict_type, css_class, list_class, is_default, status, create_by, create_time, update_by, update_time, remark) VALUES (13, 2, '否', 'N', 'sys_yes_no', '', 'danger', 'N', '0', 'admin', '2022-10-31 05:57:50', '', null, '系统默认否');
INSERT INTO sys_dict_data (dict_code, dict_sort, dict_label, dict_value, dict_type, css_class, list_class, is_default, status, create_by, create_time, update_by, update_time, remark) VALUES (14, 1, '通知', '1', 'sys_notice_type', '', 'warning', 'Y', '0', 'admin', '2022-10-31 05:57:50', '', null, '通知');
INSERT INTO sys_dict_data (dict_code, dict_sort, dict_label, dict_value, dict_type, css_class, list_class, is_default, status, create_by, create_time, update_by, update_time, remark) VALUES (15, 2, '公告', '2', 'sys_notice_type', '', 'success', 'N', '0', 'admin', '2022-10-31 05:57:50', '', null, '公告');
INSERT INTO sys_dict_data (dict_code, dict_sort, dict_label, dict_value, dict_type, css_class, list_class, is_default, status, create_by, create_time, update_by, update_time, remark) VALUES (16, 1, '正常', '0', 'sys_notice_status', '', 'primary', 'Y', '0', 'admin', '2022-10-31 05:57:50', '', null, '正常状态');
INSERT INTO sys_dict_data (dict_code, dict_sort, dict_label, dict_value, dict_type, css_class, list_class, is_default, status, create_by, create_time, update_by, update_time, remark) VALUES (17, 2, '关闭', '1', 'sys_notice_status', '', 'danger', 'N', '0', 'admin', '2022-10-31 05:57:50', '', null, '关闭状态');
INSERT INTO sys_dict_data (dict_code, dict_sort, dict_label, dict_value, dict_type, css_class, list_class, is_default, status, create_by, create_time, update_by, update_time, remark) VALUES (18, 99, '其他', '0', 'sys_oper_type', '', 'info', 'N', '0', 'admin', '2022-10-31 05:57:50', '', null, '其他操作');
INSERT INTO sys_dict_data (dict_code, dict_sort, dict_label, dict_value, dict_type, css_class, list_class, is_default, status, create_by, create_time, update_by, update_time, remark) VALUES (19, 1, '新增', '1', 'sys_oper_type', '', 'info', 'N', '0', 'admin', '2022-10-31 05:57:50', '', null, '新增操作');
INSERT INTO sys_dict_data (dict_code, dict_sort, dict_label, dict_value, dict_type, css_class, list_class, is_default, status, create_by, create_time, update_by, update_time, remark) VALUES (20, 2, '修改', '2', 'sys_oper_type', '', 'info', 'N', '0', 'admin', '2022-10-31 05:57:51', '', null, '修改操作');
INSERT INTO sys_dict_data (dict_code, dict_sort, dict_label, dict_value, dict_type, css_class, list_class, is_default, status, create_by, create_time, update_by, update_time, remark) VALUES (21, 3, '删除', '3', 'sys_oper_type', '', 'danger', 'N', '0', 'admin', '2022-10-31 05:57:51', '', null, '删除操作');
INSERT INTO sys_dict_data (dict_code, dict_sort, dict_label, dict_value, dict_type, css_class, list_class, is_default, status, create_by, create_time, update_by, update_time, remark) VALUES (22, 4, '授权', '4', 'sys_oper_type', '', 'primary', 'N', '0', 'admin', '2022-10-31 05:57:51', '', null, '授权操作');
INSERT INTO sys_dict_data (dict_code, dict_sort, dict_label, dict_value, dict_type, css_class, list_class, is_default, status, create_by, create_time, update_by, update_time, remark) VALUES (23, 5, '导出', '5', 'sys_oper_type', '', 'warning', 'N', '0', 'admin', '2022-10-31 05:57:51', '', null, '导出操作');
INSERT INTO sys_dict_data (dict_code, dict_sort, dict_label, dict_value, dict_type, css_class, list_class, is_default, status, create_by, create_time, update_by, update_time, remark) VALUES (24, 6, '导入', '6', 'sys_oper_type', '', 'warning', 'N', '0', 'admin', '2022-10-31 05:57:51', '', null, '导入操作');
INSERT INTO sys_dict_data (dict_code, dict_sort, dict_label, dict_value, dict_type, css_class, list_class, is_default, status, create_by, create_time, update_by, update_time, remark) VALUES (25, 7, '强退', '7', 'sys_oper_type', '', 'danger', 'N', '0', 'admin', '2022-10-31 05:57:51', '', null, '强退操作');
INSERT INTO sys_dict_data (dict_code, dict_sort, dict_label, dict_value, dict_type, css_class, list_class, is_default, status, create_by, create_time, update_by, update_time, remark) VALUES (26, 8, '生成代码', '8', 'sys_oper_type', '', 'warning', 'N', '0', 'admin', '2022-10-31 05:57:51', '', null, '生成操作');
INSERT INTO sys_dict_data (dict_code, dict_sort, dict_label, dict_value, dict_type, css_class, list_class, is_default, status, create_by, create_time, update_by, update_time, remark) VALUES (27, 9, '清空数据', '9', 'sys_oper_type', '', 'danger', 'N', '0', 'admin', '2022-10-31 05:57:51', '', null, '清空操作');
INSERT INTO sys_dict_data (dict_code, dict_sort, dict_label, dict_value, dict_type, css_class, list_class, is_default, status, create_by, create_time, update_by, update_time, remark) VALUES (28, 1, '成功', '0', 'sys_common_status', '', 'primary', 'N', '0', 'admin', '2022-10-31 05:57:51', '', null, '正常状态');
INSERT INTO sys_dict_data (dict_code, dict_sort, dict_label, dict_value, dict_type, css_class, list_class, is_default, status, create_by, create_time, update_by, update_time, remark) VALUES (29, 2, '失败', '1', 'sys_common_status', '', 'danger', 'N', '0', 'admin', '2022-10-31 05:57:51', '', null, '停用状态');



INSERT INTO sys_dict_type (dict_id, dict_name, dict_type, status, create_by, create_time, update_by, update_time, remark) VALUES (1, '用户性别', 'sys_user_sex', '0', 'admin', '2022-10-31 05:57:50', '', null, '用户性别列表');
INSERT INTO sys_dict_type (dict_id, dict_name, dict_type, status, create_by, create_time, update_by, update_time, remark) VALUES (2, '菜单状态', 'sys_show_hide', '0', 'admin', '2022-10-31 05:57:50', '', null, '菜单状态列表');
INSERT INTO sys_dict_type (dict_id, dict_name, dict_type, status, create_by, create_time, update_by, update_time, remark) VALUES (3, '系统开关', 'sys_normal_disable', '0', 'admin', '2022-10-31 05:57:50', '', null, '系统开关列表');
INSERT INTO sys_dict_type (dict_id, dict_name, dict_type, status, create_by, create_time, update_by, update_time, remark) VALUES (4, '任务状态', 'sys_job_status', '0', 'admin', '2022-10-31 05:57:50', '', null, '任务状态列表');
INSERT INTO sys_dict_type (dict_id, dict_name, dict_type, status, create_by, create_time, update_by, update_time, remark) VALUES (5, '任务分组', 'sys_job_group', '0', 'admin', '2022-10-31 05:57:50', '', null, '任务分组列表');
INSERT INTO sys_dict_type (dict_id, dict_name, dict_type, status, create_by, create_time, update_by, update_time, remark) VALUES (6, '系统是否', 'sys_yes_no', '0', 'admin', '2022-10-31 05:57:50', '', null, '系统是否列表');
INSERT INTO sys_dict_type (dict_id, dict_name, dict_type, status, create_by, create_time, update_by, update_time, remark) VALUES (7, '通知类型', 'sys_notice_type', '0', 'admin', '2022-10-31 05:57:50', '', null, '通知类型列表');
INSERT INTO sys_dict_type (dict_id, dict_name, dict_type, status, create_by, create_time, update_by, update_time, remark) VALUES (8, '通知状态', 'sys_notice_status', '0', 'admin', '2022-10-31 05:57:50', '', null, '通知状态列表');
INSERT INTO sys_dict_type (dict_id, dict_name, dict_type, status, create_by, create_time, update_by, update_time, remark) VALUES (9, '操作类型', 'sys_oper_type', '0', 'admin', '2022-10-31 05:57:50', '', null, '操作类型列表');
INSERT INTO sys_dict_type (dict_id, dict_name, dict_type, status, create_by, create_time, update_by, update_time, remark) VALUES (10, '系统状态', 'sys_common_status', '0', 'admin', '2022-10-31 05:57:50', '', null, '登录状态列表');


INSERT INTO sys_job (job_id, job_name, job_group, invoke_target, cron_expression, misfire_policy, concurrent, status, create_by, create_time, update_by, update_time, remark) VALUES (1, '系统默认（无参）', 'DEFAULT', 'ryTask.ryNoParams', '0/10 * * * * ?', '3', '1', '1', 'admin', '2022-10-31 05:57:51', '', null, '');
INSERT INTO sys_job (job_id, job_name, job_group, invoke_target, cron_expression, misfire_policy, concurrent, status, create_by, create_time, update_by, update_time, remark) VALUES (2, '系统默认（有参）', 'DEFAULT', 'ryTask.ryParams(\'ry\')', '0/15 * * * * ?', '3', '1', '1', 'admin', '2022-10-31 05:57:51', '', null, '');
INSERT INTO sys_job (job_id, job_name, job_group, invoke_target, cron_expression, misfire_policy, concurrent, status, create_by, create_time, update_by, update_time, remark) VALUES (3, '系统默认（多参）', 'DEFAULT', 'ryTask.ryMultipleParams(\'ry\', true, 2000L, 316.50D, 100)', '0/20 * * * * ?', '3', '1', '1', 'admin', '2022-10-31 05:57:51', '', null, '');



INSERT INTO sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (1, '系统管理', 0, 1, 'system', null, '', 1, 0, 'M', '0', '0', '', 'system', 'admin', '2022-10-31 05:57:46', '', null, '系统管理目录');
INSERT INTO sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (2, '系统监控', 0, 2, 'monitor', null, '', 1, 0, 'M', '0', '0', '', 'monitor', 'admin', '2022-10-31 05:57:46', '', null, '系统监控目录');
INSERT INTO sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (3, '系统工具', 0, 3, 'tool', null, '', 1, 0, 'M', '0', '0', '', 'tool', 'admin', '2022-10-31 05:57:46', '', null, '系统工具目录');
INSERT INTO sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (4, '若依官网', 0, 5, 'http://ruoyi.vip', null, '', 0, 0, 'M', '0', '0', '', 'guide', 'admin', '2022-10-31 05:57:46', 'admin', '2022-11-04 06:14:08', '若依官网地址');
INSERT INTO sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (100, '用户管理', 1, 1, 'user', 'system/user/index', '', 1, 0, 'C', '0', '0', 'system:user:list', 'user', 'admin', '2022-10-31 05:57:46', '', null, '用户管理菜单');
INSERT INTO sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (101, '角色管理', 1, 2, 'role', 'system/role/index', '', 1, 0, 'C', '0', '0', 'system:role:list', 'peoples', 'admin', '2022-10-31 05:57:46', '', null, '角色管理菜单');
INSERT INTO sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (102, '菜单管理', 1, 3, 'menu', 'system/menu/index', '', 1, 0, 'C', '0', '0', 'system:menu:list', 'tree-table', 'admin', '2022-10-31 05:57:46', '', null, '菜单管理菜单');
INSERT INTO sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (103, '部门管理', 1, 4, 'dept', 'system/dept/index', '', 1, 0, 'C', '0', '0', 'system:dept:list', 'tree', 'admin', '2022-10-31 05:57:46', '', null, '部门管理菜单');
INSERT INTO sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (104, '岗位管理', 1, 5, 'post', 'system/post/index', '', 1, 0, 'C', '0', '0', 'system:post:list', 'post', 'admin', '2022-10-31 05:57:46', '', null, '岗位管理菜单');
INSERT INTO sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (105, '字典管理', 1, 6, 'dict', 'system/dict/index', '', 1, 0, 'C', '0', '0', 'system:dict:list', 'dict', 'admin', '2022-10-31 05:57:46', '', null, '字典管理菜单');
INSERT INTO sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (106, '参数设置', 1, 7, 'config', 'system/config/index', '', 1, 0, 'C', '0', '0', 'system:config:list', 'edit', 'admin', '2022-10-31 05:57:46', '', null, '参数设置菜单');
INSERT INTO sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (107, '通知公告', 1, 8, 'notice', 'system/notice/index', '', 1, 0, 'C', '0', '0', 'system:notice:list', 'message', 'admin', '2022-10-31 05:57:46', '', null, '通知公告菜单');
INSERT INTO sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (108, '日志管理', 1, 9, 'log', '', '', 1, 0, 'M', '0', '0', '', 'log', 'admin', '2022-10-31 05:57:46', '', null, '日志管理菜单');
INSERT INTO sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (109, '在线用户', 2, 1, 'online', 'monitor/online/index', '', 1, 0, 'C', '0', '0', 'monitor:online:list', 'online', 'admin', '2022-10-31 05:57:46', '', null, '在线用户菜单');
INSERT INTO sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (110, '定时任务', 2, 2, 'job', 'monitor/job/index', '', 1, 0, 'C', '0', '0', 'monitor:job:list', 'job', 'admin', '2022-10-31 05:57:46', '', null, '定时任务菜单');
INSERT INTO sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (111, '数据监控', 2, 3, 'druid', 'monitor/druid/index', '', 1, 0, 'C', '0', '0', 'monitor:druid:list', 'druid', 'admin', '2022-10-31 05:57:46', '', null, '数据监控菜单');
INSERT INTO sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (112, '服务监控', 2, 4, 'server', 'monitor/server/index', '', 1, 0, 'C', '0', '0', 'monitor:server:list', 'server', 'admin', '2022-10-31 05:57:46', '', null, '服务监控菜单');
INSERT INTO sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (113, '缓存监控', 2, 5, 'cache', 'monitor/cache/index', '', 1, 0, 'C', '0', '0', 'monitor:cache:list', 'redis', 'admin', '2022-10-31 05:57:46', '', null, '缓存监控菜单');
INSERT INTO sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (114, '缓存列表', 2, 6, 'cacheList', 'monitor/cache/list', '', 1, 0, 'C', '0', '0', 'monitor:cache:list', 'redis-list', 'admin', '2022-10-31 05:57:46', '', null, '缓存列表菜单');
INSERT INTO sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (115, '表单构建', 3, 1, 'build', 'tool/build/index', '', 1, 0, 'C', '0', '0', 'tool:build:list', 'build', 'admin', '2022-10-31 05:57:46', '', null, '表单构建菜单');
INSERT INTO sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (116, '代码生成', 3, 2, 'gen', 'tool/gen/index', '', 1, 0, 'C', '0', '0', 'tool:gen:list', 'code', 'admin', '2022-10-31 05:57:46', '', null, '代码生成菜单');
INSERT INTO sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (117, '系统接口', 3, 3, 'swagger', 'tool/swagger/index', '', 1, 0, 'C', '0', '0', 'tool:swagger:list', 'swagger', 'admin', '2022-10-31 05:57:46', '', null, '系统接口菜单');
INSERT INTO sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (500, '操作日志', 108, 1, 'operlog', 'monitor/operlog/index', '', 1, 0, 'C', '0', '0', 'monitor:operlog:list', 'form', 'admin', '2022-10-31 05:57:46', '', null, '操作日志菜单');
INSERT INTO sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (501, '登录日志', 108, 2, 'logininfor', 'monitor/logininfor/index', '', 1, 0, 'C', '0', '0', 'monitor:logininfor:list', 'logininfor', 'admin', '2022-10-31 05:57:46', '', null, '登录日志菜单');
INSERT INTO sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (1000, '用户查询', 100, 1, '', '', '', 1, 0, 'F', '0', '0', 'system:user:query', '#', 'admin', '2022-10-31 05:57:46', '', null, '');
INSERT INTO sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (1001, '用户新增', 100, 2, '', '', '', 1, 0, 'F', '0', '0', 'system:user:add', '#', 'admin', '2022-10-31 05:57:46', '', null, '');
INSERT INTO sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (1002, '用户修改', 100, 3, '', '', '', 1, 0, 'F', '0', '0', 'system:user:edit', '#', 'admin', '2022-10-31 05:57:46', '', null, '');
INSERT INTO sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (1003, '用户删除', 100, 4, '', '', '', 1, 0, 'F', '0', '0', 'system:user:remove', '#', 'admin', '2022-10-31 05:57:46', '', null, '');
INSERT INTO sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (1004, '用户导出', 100, 5, '', '', '', 1, 0, 'F', '0', '0', 'system:user:export', '#', 'admin', '2022-10-31 05:57:46', '', null, '');
INSERT INTO sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (1005, '用户导入', 100, 6, '', '', '', 1, 0, 'F', '0', '0', 'system:user:import', '#', 'admin', '2022-10-31 05:57:46', '', null, '');
INSERT INTO sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (1006, '重置密码', 100, 7, '', '', '', 1, 0, 'F', '0', '0', 'system:user:resetPwd', '#', 'admin', '2022-10-31 05:57:46', '', null, '');
INSERT INTO sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (1007, '角色查询', 101, 1, '', '', '', 1, 0, 'F', '0', '0', 'system:role:query', '#', 'admin', '2022-10-31 05:57:46', '', null, '');
INSERT INTO sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (1008, '角色新增', 101, 2, '', '', '', 1, 0, 'F', '0', '0', 'system:role:add', '#', 'admin', '2022-10-31 05:57:46', '', null, '');
INSERT INTO sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (1009, '角色修改', 101, 3, '', '', '', 1, 0, 'F', '0', '0', 'system:role:edit', '#', 'admin', '2022-10-31 05:57:46', '', null, '');
INSERT INTO sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (1010, '角色删除', 101, 4, '', '', '', 1, 0, 'F', '0', '0', 'system:role:remove', '#', 'admin', '2022-10-31 05:57:46', '', null, '');
INSERT INTO sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (1011, '角色导出', 101, 5, '', '', '', 1, 0, 'F', '0', '0', 'system:role:export', '#', 'admin', '2022-10-31 05:57:46', '', null, '');
INSERT INTO sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (1012, '菜单查询', 102, 1, '', '', '', 1, 0, 'F', '0', '0', 'system:menu:query', '#', 'admin', '2022-10-31 05:57:46', '', null, '');
INSERT INTO sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (1013, '菜单新增', 102, 2, '', '', '', 1, 0, 'F', '0', '0', 'system:menu:add', '#', 'admin', '2022-10-31 05:57:46', '', null, '');
INSERT INTO sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (1014, '菜单修改', 102, 3, '', '', '', 1, 0, 'F', '0', '0', 'system:menu:edit', '#', 'admin', '2022-10-31 05:57:46', '', null, '');
INSERT INTO sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (1015, '菜单删除', 102, 4, '', '', '', 1, 0, 'F', '0', '0', 'system:menu:remove', '#', 'admin', '2022-10-31 05:57:47', '', null, '');
INSERT INTO sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (1016, '部门查询', 103, 1, '', '', '', 1, 0, 'F', '0', '0', 'system:dept:query', '#', 'admin', '2022-10-31 05:57:47', '', null, '');
INSERT INTO sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (1017, '部门新增', 103, 2, '', '', '', 1, 0, 'F', '0', '0', 'system:dept:add', '#', 'admin', '2022-10-31 05:57:47', '', null, '');
INSERT INTO sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (1018, '部门修改', 103, 3, '', '', '', 1, 0, 'F', '0', '0', 'system:dept:edit', '#', 'admin', '2022-10-31 05:57:47', '', null, '');
INSERT INTO sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (1019, '部门删除', 103, 4, '', '', '', 1, 0, 'F', '0', '0', 'system:dept:remove', '#', 'admin', '2022-10-31 05:57:47', '', null, '');
INSERT INTO sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (1020, '岗位查询', 104, 1, '', '', '', 1, 0, 'F', '0', '0', 'system:post:query', '#', 'admin', '2022-10-31 05:57:47', '', null, '');
INSERT INTO sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (1021, '岗位新增', 104, 2, '', '', '', 1, 0, 'F', '0', '0', 'system:post:add', '#', 'admin', '2022-10-31 05:57:47', '', null, '');
INSERT INTO sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (1022, '岗位修改', 104, 3, '', '', '', 1, 0, 'F', '0', '0', 'system:post:edit', '#', 'admin', '2022-10-31 05:57:47', '', null, '');
INSERT INTO sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (1023, '岗位删除', 104, 4, '', '', '', 1, 0, 'F', '0', '0', 'system:post:remove', '#', 'admin', '2022-10-31 05:57:47', '', null, '');
INSERT INTO sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (1024, '岗位导出', 104, 5, '', '', '', 1, 0, 'F', '0', '0', 'system:post:export', '#', 'admin', '2022-10-31 05:57:47', '', null, '');
INSERT INTO sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (1025, '字典查询', 105, 1, '#', '', '', 1, 0, 'F', '0', '0', 'system:dict:query', '#', 'admin', '2022-10-31 05:57:47', '', null, '');
INSERT INTO sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (1026, '字典新增', 105, 2, '#', '', '', 1, 0, 'F', '0', '0', 'system:dict:add', '#', 'admin', '2022-10-31 05:57:47', '', null, '');
INSERT INTO sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (1027, '字典修改', 105, 3, '#', '', '', 1, 0, 'F', '0', '0', 'system:dict:edit', '#', 'admin', '2022-10-31 05:57:47', '', null, '');
INSERT INTO sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (1028, '字典删除', 105, 4, '#', '', '', 1, 0, 'F', '0', '0', 'system:dict:remove', '#', 'admin', '2022-10-31 05:57:47', '', null, '');
INSERT INTO sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (1029, '字典导出', 105, 5, '#', '', '', 1, 0, 'F', '0', '0', 'system:dict:export', '#', 'admin', '2022-10-31 05:57:47', '', null, '');
INSERT INTO sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (1030, '参数查询', 106, 1, '#', '', '', 1, 0, 'F', '0', '0', 'system:config:query', '#', 'admin', '2022-10-31 05:57:47', '', null, '');
INSERT INTO sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (1031, '参数新增', 106, 2, '#', '', '', 1, 0, 'F', '0', '0', 'system:config:add', '#', 'admin', '2022-10-31 05:57:47', '', null, '');
INSERT INTO sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (1032, '参数修改', 106, 3, '#', '', '', 1, 0, 'F', '0', '0', 'system:config:edit', '#', 'admin', '2022-10-31 05:57:47', '', null, '');
INSERT INTO sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (1033, '参数删除', 106, 4, '#', '', '', 1, 0, 'F', '0', '0', 'system:config:remove', '#', 'admin', '2022-10-31 05:57:47', '', null, '');
INSERT INTO sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (1034, '参数导出', 106, 5, '#', '', '', 1, 0, 'F', '0', '0', 'system:config:export', '#', 'admin', '2022-10-31 05:57:47', '', null, '');
INSERT INTO sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (1035, '公告查询', 107, 1, '#', '', '', 1, 0, 'F', '0', '0', 'system:notice:query', '#', 'admin', '2022-10-31 05:57:47', '', null, '');
INSERT INTO sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (1036, '公告新增', 107, 2, '#', '', '', 1, 0, 'F', '0', '0', 'system:notice:add', '#', 'admin', '2022-10-31 05:57:47', '', null, '');
INSERT INTO sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (1037, '公告修改', 107, 3, '#', '', '', 1, 0, 'F', '0', '0', 'system:notice:edit', '#', 'admin', '2022-10-31 05:57:47', '', null, '');
INSERT INTO sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (1038, '公告删除', 107, 4, '#', '', '', 1, 0, 'F', '0', '0', 'system:notice:remove', '#', 'admin', '2022-10-31 05:57:47', '', null, '');
INSERT INTO sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (1039, '操作查询', 500, 1, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:operlog:query', '#', 'admin', '2022-10-31 05:57:47', '', null, '');
INSERT INTO sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (1040, '操作删除', 500, 2, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:operlog:remove', '#', 'admin', '2022-10-31 05:57:47', '', null, '');
INSERT INTO sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (1041, '日志导出', 500, 3, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:operlog:export', '#', 'admin', '2022-10-31 05:57:47', '', null, '');
INSERT INTO sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (1042, '登录查询', 501, 1, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:logininfor:query', '#', 'admin', '2022-10-31 05:57:47', '', null, '');
INSERT INTO sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (1043, '登录删除', 501, 2, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:logininfor:remove', '#', 'admin', '2022-10-31 05:57:47', '', null, '');
INSERT INTO sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (1044, '日志导出', 501, 3, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:logininfor:export', '#', 'admin', '2022-10-31 05:57:47', '', null, '');
INSERT INTO sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (1045, '账户解锁', 501, 4, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:logininfor:unlock', '#', 'admin', '2022-10-31 05:57:47', '', null, '');
INSERT INTO sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (1046, '在线查询', 109, 1, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:online:query', '#', 'admin', '2022-10-31 05:57:47', '', null, '');
INSERT INTO sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (1047, '批量强退', 109, 2, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:online:batchLogout', '#', 'admin', '2022-10-31 05:57:47', '', null, '');
INSERT INTO sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (1048, '单条强退', 109, 3, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:online:forceLogout', '#', 'admin', '2022-10-31 05:57:47', '', null, '');
INSERT INTO sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (1049, '任务查询', 110, 1, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:job:query', '#', 'admin', '2022-10-31 05:57:47', '', null, '');
INSERT INTO sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (1050, '任务新增', 110, 2, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:job:add', '#', 'admin', '2022-10-31 05:57:47', '', null, '');
INSERT INTO sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (1051, '任务修改', 110, 3, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:job:edit', '#', 'admin', '2022-10-31 05:57:47', '', null, '');
INSERT INTO sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (1052, '任务删除', 110, 4, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:job:remove', '#', 'admin', '2022-10-31 05:57:47', '', null, '');
INSERT INTO sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (1053, '状态修改', 110, 5, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:job:changeStatus', '#', 'admin', '2022-10-31 05:57:47', '', null, '');
INSERT INTO sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (1054, '任务导出', 110, 6, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:job:export', '#', 'admin', '2022-10-31 05:57:47', '', null, '');
INSERT INTO sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (1055, '生成查询', 116, 1, '#', '', '', 1, 0, 'F', '0', '0', 'tool:gen:query', '#', 'admin', '2022-10-31 05:57:47', '', null, '');
INSERT INTO sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (1056, '生成修改', 116, 2, '#', '', '', 1, 0, 'F', '0', '0', 'tool:gen:edit', '#', 'admin', '2022-10-31 05:57:47', '', null, '');
INSERT INTO sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (1057, '生成删除', 116, 3, '#', '', '', 1, 0, 'F', '0', '0', 'tool:gen:remove', '#', 'admin', '2022-10-31 05:57:47', '', null, '');
INSERT INTO sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (1058, '导入代码', 116, 4, '#', '', '', 1, 0, 'F', '0', '0', 'tool:gen:import', '#', 'admin', '2022-10-31 05:57:47', '', null, '');
INSERT INTO sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (1059, '预览代码', 116, 5, '#', '', '', 1, 0, 'F', '0', '0', 'tool:gen:preview', '#', 'admin', '2022-10-31 05:57:47', '', null, '');
INSERT INTO sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (1060, '生成代码', 116, 6, '#', '', '', 1, 0, 'F', '0', '0', 'tool:gen:code', '#', 'admin', '2022-10-31 05:57:47', '', null, '');
INSERT INTO sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (2000, '流程配置', 0, 4, 'workflow', null, null, 1, 0, 'M', '0', '0', '', 'tree-table', 'admin', '2022-11-04 06:14:01', 'admin', '2022-11-11 02:23:08', '');
INSERT INTO sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (2001, '流程部署', 2000, 1, 'deploy', 'workflow/deploy', null, 1, 0, 'C', '0', '0', '', 'documentation', 'admin', '2022-11-04 06:20:49', 'admin', '2022-11-20 02:59:14', '');
INSERT INTO sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (2002, '流程设计', 2000, 2, 'design', 'workflow/design', null, 1, 0, 'C', '1', '0', '', '#', 'admin', '2022-11-04 07:05:54', 'admin', '2022-11-20 02:59:18', '');
INSERT INTO sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (2003, '业务配置', 2000, 3, 'businessIndex', 'workflow/business/index', null, 1, 0, 'C', '0', '0', '', 'tab', 'admin', '2022-11-29 05:34:58', 'admin', '2023-01-05 09:45:50', '');
INSERT INTO sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (2004, '变量配置', 2000, 4, 'variable', 'workflow/variable/index', null, 1, 0, 'C', '0', '0', '', 'edit', 'admin', '2022-12-01 02:04:00', 'admin', '2022-12-01 02:04:17', '');
INSERT INTO sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (2005, '业务功能', 0, 4, 'business', null, null, 1, 0, 'M', '0', '0', '', 'job', 'admin', '2022-12-08 09:07:20', 'admin', '2022-12-12 06:10:14', '');
INSERT INTO sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (2006, '请假申请', 2005, 1, 'leave', 'business/leave/index', null, 1, 0, 'C', '0', '0', '', 'nested', 'admin', '2022-12-08 09:08:32', 'admin', '2022-12-08 09:09:13', '');
INSERT INTO sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (2007, '审批代办', 2005, 2, 'todo', 'business/todo/index', null, 1, 0, 'C', '1', '1', '', 'table', 'admin', '2022-12-12 03:08:07', 'admin', '2022-12-12 08:58:30', '');


INSERT INTO sys_notice (notice_id, notice_title, notice_type, notice_content, status, create_by, create_time, update_by, update_time, remark) VALUES (1, '温馨提醒：2018-07-01 若依新版本发布啦', '2', 0xE696B0E78988E69CACE58685E5AEB9, '0', 'admin', '2022-10-31 05:57:51', '', null, '管理员');
INSERT INTO sys_notice (notice_id, notice_title, notice_type, notice_content, status, create_by, create_time, update_by, update_time, remark) VALUES (2, '维护通知：2018-07-01 若依系统凌晨维护', '1', 0xE7BBB4E68AA4E58685E5AEB9, '0', 'admin', '2022-10-31 05:57:51', '', null, '管理员');



INSERT INTO sys_post (post_id, post_code, post_name, post_sort, status, create_by, create_time, update_by, update_time, remark) VALUES (1, 'ceo', '董事长', 1, '0', 'admin', '2022-10-31 05:57:46', '', null, '');
INSERT INTO sys_post (post_id, post_code, post_name, post_sort, status, create_by, create_time, update_by, update_time, remark) VALUES (2, 'se', '项目经理', 2, '0', 'admin', '2022-10-31 05:57:46', '', null, '');
INSERT INTO sys_post (post_id, post_code, post_name, post_sort, status, create_by, create_time, update_by, update_time, remark) VALUES (3, 'hr', '人力资源', 3, '0', 'admin', '2022-10-31 05:57:46', '', null, '');
INSERT INTO sys_post (post_id, post_code, post_name, post_sort, status, create_by, create_time, update_by, update_time, remark) VALUES (4, 'user', '普通员工', 4, '0', 'admin', '2022-10-31 05:57:46', '', null, '');


INSERT INTO sys_role (role_id, role_name, role_key, role_sort, data_scope, menu_check_strictly, dept_check_strictly, status, del_flag, create_by, create_time, update_by, update_time, remark) VALUES (1, '超级管理员', 'admin', 1, '1', 1, 1, '0', '0', 'admin', '2022-10-31 05:57:46', '', null, '超级管理员');
INSERT INTO sys_role (role_id, role_name, role_key, role_sort, data_scope, menu_check_strictly, dept_check_strictly, status, del_flag, create_by, create_time, update_by, update_time, remark) VALUES (2, '普通角色', 'common', 2, '2', 1, 1, '0', '0', 'admin', '2022-10-31 05:57:46', '', null, '普通角色');



INSERT INTO sys_role_dept (role_id, dept_id) VALUES (2, 100);
INSERT INTO sys_role_dept (role_id, dept_id) VALUES (2, 101);
INSERT INTO sys_role_dept (role_id, dept_id) VALUES (2, 105);



INSERT INTO sys_role_menu (role_id, menu_id) VALUES (2, 1);
INSERT INTO sys_role_menu (role_id, menu_id) VALUES (2, 2);
INSERT INTO sys_role_menu (role_id, menu_id) VALUES (2, 3);
INSERT INTO sys_role_menu (role_id, menu_id) VALUES (2, 4);
INSERT INTO sys_role_menu (role_id, menu_id) VALUES (2, 100);
INSERT INTO sys_role_menu (role_id, menu_id) VALUES (2, 101);
INSERT INTO sys_role_menu (role_id, menu_id) VALUES (2, 102);
INSERT INTO sys_role_menu (role_id, menu_id) VALUES (2, 103);
INSERT INTO sys_role_menu (role_id, menu_id) VALUES (2, 104);
INSERT INTO sys_role_menu (role_id, menu_id) VALUES (2, 105);
INSERT INTO sys_role_menu (role_id, menu_id) VALUES (2, 106);
INSERT INTO sys_role_menu (role_id, menu_id) VALUES (2, 107);
INSERT INTO sys_role_menu (role_id, menu_id) VALUES (2, 108);
INSERT INTO sys_role_menu (role_id, menu_id) VALUES (2, 109);
INSERT INTO sys_role_menu (role_id, menu_id) VALUES (2, 110);
INSERT INTO sys_role_menu (role_id, menu_id) VALUES (2, 111);
INSERT INTO sys_role_menu (role_id, menu_id) VALUES (2, 112);
INSERT INTO sys_role_menu (role_id, menu_id) VALUES (2, 113);
INSERT INTO sys_role_menu (role_id, menu_id) VALUES (2, 114);
INSERT INTO sys_role_menu (role_id, menu_id) VALUES (2, 115);
INSERT INTO sys_role_menu (role_id, menu_id) VALUES (2, 116);
INSERT INTO sys_role_menu (role_id, menu_id) VALUES (2, 117);
INSERT INTO sys_role_menu (role_id, menu_id) VALUES (2, 500);
INSERT INTO sys_role_menu (role_id, menu_id) VALUES (2, 501);
INSERT INTO sys_role_menu (role_id, menu_id) VALUES (2, 1000);
INSERT INTO sys_role_menu (role_id, menu_id) VALUES (2, 1001);
INSERT INTO sys_role_menu (role_id, menu_id) VALUES (2, 1002);
INSERT INTO sys_role_menu (role_id, menu_id) VALUES (2, 1003);
INSERT INTO sys_role_menu (role_id, menu_id) VALUES (2, 1004);
INSERT INTO sys_role_menu (role_id, menu_id) VALUES (2, 1005);
INSERT INTO sys_role_menu (role_id, menu_id) VALUES (2, 1006);
INSERT INTO sys_role_menu (role_id, menu_id) VALUES (2, 1007);
INSERT INTO sys_role_menu (role_id, menu_id) VALUES (2, 1008);
INSERT INTO sys_role_menu (role_id, menu_id) VALUES (2, 1009);
INSERT INTO sys_role_menu (role_id, menu_id) VALUES (2, 1010);
INSERT INTO sys_role_menu (role_id, menu_id) VALUES (2, 1011);
INSERT INTO sys_role_menu (role_id, menu_id) VALUES (2, 1012);
INSERT INTO sys_role_menu (role_id, menu_id) VALUES (2, 1013);
INSERT INTO sys_role_menu (role_id, menu_id) VALUES (2, 1014);
INSERT INTO sys_role_menu (role_id, menu_id) VALUES (2, 1015);
INSERT INTO sys_role_menu (role_id, menu_id) VALUES (2, 1016);
INSERT INTO sys_role_menu (role_id, menu_id) VALUES (2, 1017);
INSERT INTO sys_role_menu (role_id, menu_id) VALUES (2, 1018);
INSERT INTO sys_role_menu (role_id, menu_id) VALUES (2, 1019);
INSERT INTO sys_role_menu (role_id, menu_id) VALUES (2, 1020);
INSERT INTO sys_role_menu (role_id, menu_id) VALUES (2, 1021);
INSERT INTO sys_role_menu (role_id, menu_id) VALUES (2, 1022);
INSERT INTO sys_role_menu (role_id, menu_id) VALUES (2, 1023);
INSERT INTO sys_role_menu (role_id, menu_id) VALUES (2, 1024);
INSERT INTO sys_role_menu (role_id, menu_id) VALUES (2, 1025);
INSERT INTO sys_role_menu (role_id, menu_id) VALUES (2, 1026);
INSERT INTO sys_role_menu (role_id, menu_id) VALUES (2, 1027);
INSERT INTO sys_role_menu (role_id, menu_id) VALUES (2, 1028);
INSERT INTO sys_role_menu (role_id, menu_id) VALUES (2, 1029);
INSERT INTO sys_role_menu (role_id, menu_id) VALUES (2, 1030);
INSERT INTO sys_role_menu (role_id, menu_id) VALUES (2, 1031);
INSERT INTO sys_role_menu (role_id, menu_id) VALUES (2, 1032);
INSERT INTO sys_role_menu (role_id, menu_id) VALUES (2, 1033);
INSERT INTO sys_role_menu (role_id, menu_id) VALUES (2, 1034);
INSERT INTO sys_role_menu (role_id, menu_id) VALUES (2, 1035);
INSERT INTO sys_role_menu (role_id, menu_id) VALUES (2, 1036);
INSERT INTO sys_role_menu (role_id, menu_id) VALUES (2, 1037);
INSERT INTO sys_role_menu (role_id, menu_id) VALUES (2, 1038);
INSERT INTO sys_role_menu (role_id, menu_id) VALUES (2, 1039);
INSERT INTO sys_role_menu (role_id, menu_id) VALUES (2, 1040);
INSERT INTO sys_role_menu (role_id, menu_id) VALUES (2, 1041);
INSERT INTO sys_role_menu (role_id, menu_id) VALUES (2, 1042);
INSERT INTO sys_role_menu (role_id, menu_id) VALUES (2, 1043);
INSERT INTO sys_role_menu (role_id, menu_id) VALUES (2, 1044);
INSERT INTO sys_role_menu (role_id, menu_id) VALUES (2, 1045);
INSERT INTO sys_role_menu (role_id, menu_id) VALUES (2, 1046);
INSERT INTO sys_role_menu (role_id, menu_id) VALUES (2, 1047);
INSERT INTO sys_role_menu (role_id, menu_id) VALUES (2, 1048);
INSERT INTO sys_role_menu (role_id, menu_id) VALUES (2, 1049);
INSERT INTO sys_role_menu (role_id, menu_id) VALUES (2, 1050);
INSERT INTO sys_role_menu (role_id, menu_id) VALUES (2, 1051);
INSERT INTO sys_role_menu (role_id, menu_id) VALUES (2, 1052);
INSERT INTO sys_role_menu (role_id, menu_id) VALUES (2, 1053);
INSERT INTO sys_role_menu (role_id, menu_id) VALUES (2, 1054);
INSERT INTO sys_role_menu (role_id, menu_id) VALUES (2, 1055);
INSERT INTO sys_role_menu (role_id, menu_id) VALUES (2, 1056);
INSERT INTO sys_role_menu (role_id, menu_id) VALUES (2, 1057);
INSERT INTO sys_role_menu (role_id, menu_id) VALUES (2, 1058);
INSERT INTO sys_role_menu (role_id, menu_id) VALUES (2, 1059);
INSERT INTO sys_role_menu (role_id, menu_id) VALUES (2, 1060);

INSERT INTO sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, create_by, create_time, update_by, update_time, remark) VALUES (1, 103, 'admin', '管理员', '00', 'ry@163.com', '15888888888', '1', '', '$2a$10$kvM4VWvSm48laH2xk6qiSOhKfk9a1Kzh0fbWb5HN4iH7Ht6fCcvYO', '0', '0', '127.0.0.1', '2023-02-13 17:32:47', 'admin', '2022-10-31 05:57:45', '', '2023-02-13 09:32:47', '管理员');
INSERT INTO sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, create_by, create_time, update_by, update_time, remark) VALUES (2, 105, 'ry', '测试001', '00', 'ry@qq.com', '15666666666', '1', '', '$2a$10$KF8AwzT2H8ct7Ul/GK6znegpiM2lzxXYrMOTkeZJ4jUle9iuLply.', '0', '0', '127.0.0.1', '2023-02-13 17:35:27', 'admin', '2022-10-31 05:57:45', 'admin', '2023-02-13 09:35:27', '测试员');
INSERT INTO sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, create_by, create_time, update_by, update_time, remark) VALUES (100, 103, '张三', 'zhangsan', '00', '', '18000000000', '1', '', '$2a$10$jrBL9cDT/hDumQTFND8yd.Vj3pn7f.v7Q/eGaWLUp/HWDJoEn6F7m', '0', '0', '127.0.0.1', '2023-02-13 18:05:12', 'admin', '2023-02-09 03:10:47', '', '2023-02-13 10:05:12', null);
INSERT INTO sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, create_by, create_time, update_by, update_time, remark) VALUES (101, 102, '李四', 'lisi', '00', '', '18000000001', '1', '', '$2a$10$g5ROCy7vTo9LvdhwrfiWs.UJ7u9cS3/7Z7Ilj.jqa0lIfiqWQ3oue', '0', '0', '127.0.0.1', '2023-02-13 17:13:47', 'admin', '2023-02-09 03:11:18', '', '2023-02-13 09:13:47', null);


INSERT INTO sys_user_post (user_id, post_id) VALUES (1, 1);
INSERT INTO sys_user_post (user_id, post_id) VALUES (2, 2);
INSERT INTO sys_user_post (user_id, post_id) VALUES (100, 4);
INSERT INTO sys_user_post (user_id, post_id) VALUES (101, 4);



INSERT INTO sys_user_role (user_id, role_id) VALUES (1, 1);
INSERT INTO sys_user_role (user_id, role_id) VALUES (2, 2);
INSERT INTO sys_user_role (user_id, role_id) VALUES (100, 2);
INSERT INTO sys_user_role (user_id, role_id) VALUES (101, 2);


