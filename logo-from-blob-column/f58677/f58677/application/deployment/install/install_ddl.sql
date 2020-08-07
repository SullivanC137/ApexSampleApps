prompt --application/deployment/install/install_ddl
begin
--   Manifest
--     INSTALL: INSTALL-DDL
--   Manifest End
wwv_flow_api.component_begin (
 p_version_yyyy_mm_dd=>'2020.03.31'
,p_release=>'20.1.0.00.13'
,p_default_workspace_id=>20364455535222695531
,p_default_application_id=>58677
,p_default_id_offset=>0
,p_default_owner=>'SULLIVANC137'
);
wwv_flow_api.create_install_script(
 p_id=>wwv_flow_api.id(33233486554643777897)
,p_install_id=>wwv_flow_api.id(33233477121270771540)
,p_name=>'DDL'
,p_sequence=>10
,p_script_type=>'INSTALL'
,p_script_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'-- create tables',
'create table logos (',
'    id                             number not null constraint logos_id_pk primary key,',
'    row_version                    integer not null,',
'    name                           varchar2(255),',
'    photo                          blob,',
'    photo_filename                 varchar2(512),',
'    photo_mimetype                 varchar2(512),',
'    photo_charset                  varchar2(512),',
'    photo_lastupd                  date,',
'    created                        date not null,',
'    created_by                     varchar2(255) not null,',
'    updated                        date not null,',
'    updated_by                     varchar2(255) not null',
')',
';',
'',
'',
'-- triggers',
'create or replace trigger logos_biu',
'    before insert or update ',
'    on logos',
'    for each row',
'begin',
'    if :new.id is null then',
'        :new.id := to_number(sys_guid(), ''XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX'');',
'    end if;',
'    if inserting then',
'        :new.row_version := 1;',
'    elsif updating then',
'        :new.row_version := nvl(:old.row_version,0) + 1;',
'    end if;',
'    if inserting then',
'        :new.created := sysdate;',
'        :new.created_by := nvl(sys_context(''APEX$SESSION'',''APP_USER''),user);',
'    end if;',
'    :new.updated := sysdate;',
'    :new.updated_by := nvl(sys_context(''APEX$SESSION'',''APP_USER''),user);',
'end logos_biu;',
'/',
'',
'-- load data',
''))
);
wwv_flow_api.component_end;
end;
/
