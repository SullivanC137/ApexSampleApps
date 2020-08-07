prompt --application/create_application
begin
--   Manifest
--     FLOW: 58677
--   Manifest End
wwv_flow_api.component_begin (
 p_version_yyyy_mm_dd=>'2020.03.31'
,p_release=>'20.1.0.00.13'
,p_default_workspace_id=>20364455535222695531
,p_default_application_id=>58677
,p_default_id_offset=>0
,p_default_owner=>'SULLIVANC137'
);
wwv_flow_api.create_flow(
 p_id=>wwv_flow.g_flow_id
,p_owner=>nvl(wwv_flow_application_install.get_schema,'SULLIVANC137')
,p_name=>nvl(wwv_flow_application_install.get_application_name,'Sample - Logo from blob column')
,p_alias=>nvl(wwv_flow_application_install.get_application_alias,'SAMPLE-LOGO-FROM-BLOB-COLUMN')
,p_page_view_logging=>'YES'
,p_page_protection_enabled_y_n=>'Y'
,p_checksum_salt=>'294EA42AD879ADE4C8D22B7E48CAD70CE8EE6A33FF1D54AC37020208A3CF6598'
,p_bookmark_checksum_function=>'SH512'
,p_compatibility_mode=>'19.2'
,p_flow_language=>'en'
,p_flow_language_derived_from=>'FLOW_PRIMARY_LANGUAGE'
,p_allow_feedback_yn=>'Y'
,p_date_format=>'DS'
,p_timestamp_format=>'DS'
,p_timestamp_tz_format=>'DS'
,p_direction_right_to_left=>'N'
,p_flow_image_prefix => nvl(wwv_flow_application_install.get_image_prefix,'')
,p_documentation_banner=>'Application created from create application wizard 2020.08.06.'
,p_authentication=>'PLUGIN'
,p_authentication_id=>wwv_flow_api.id(33145429051667077618)
,p_application_tab_set=>1
,p_logo_type=>'I'
,p_logo=>'https://apex.oracle.com/pls/apex/f?p=58677:4:0::::P4_LOGO_ID:&P4_LOGO_ID.'
,p_app_builder_icon_name=>'app-icon.svg'
,p_proxy_server=>nvl(wwv_flow_application_install.get_proxy,'')
,p_no_proxy_domains=>nvl(wwv_flow_application_install.get_no_proxy_domains,'')
,p_flow_version=>'Release 1.0'
,p_flow_status=>'AVAILABLE_W_EDIT_LINK'
,p_exact_substitutions_only=>'Y'
,p_browser_cache=>'N'
,p_browser_frame=>'D'
,p_rejoin_existing_sessions=>'N'
,p_csv_encoding=>'Y'
,p_auto_time_zone=>'N'
,p_substitution_string_01=>'APP_NAME'
,p_substitution_value_01=>'Sample - Logo from blob column'
,p_last_updated_by=>'KROMOSOETO.S@GMAIL.COM'
,p_last_upd_yyyymmddhh24miss=>'20200807091011'
,p_file_prefix => nvl(wwv_flow_application_install.get_static_app_file_prefix,'')
,p_files_version=>4
,p_ui_type_name => null
);
wwv_flow_api.component_end;
end;
/
