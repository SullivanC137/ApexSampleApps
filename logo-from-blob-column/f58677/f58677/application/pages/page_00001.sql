prompt --application/pages/page_00001
begin
--   Manifest
--     PAGE: 00001
--   Manifest End
wwv_flow_api.component_begin (
 p_version_yyyy_mm_dd=>'2020.03.31'
,p_release=>'20.1.0.00.13'
,p_default_workspace_id=>20364455535222695531
,p_default_application_id=>58677
,p_default_id_offset=>0
,p_default_owner=>'SULLIVANC137'
);
wwv_flow_api.create_page(
 p_id=>1
,p_user_interface_id=>wwv_flow_api.id(33145567923815077746)
,p_name=>'Home'
,p_alias=>'HOME'
,p_step_title=>'Sample - Logo from blob column'
,p_autocomplete_on_off=>'OFF'
,p_page_template_options=>'#DEFAULT#'
,p_last_updated_by=>'KROMOSOETO.S@GMAIL.COM'
,p_last_upd_yyyymmddhh24miss=>'20200807091011'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(19408765353288601038)
,p_plug_name=>'This app'
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_plug_template=>wwv_flow_api.id(33145483372276077668)
,p_plug_display_sequence=>10
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'BODY'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<p> The goal of this app is to show how it is possible to use an image in a blob column as the application logo </p>',
'<p> For this functionality, we create a public page which serves as the download link. </p>',
'<p> Be advised, implementing logo''s this way can make your app slower as APEX will have to fetch a row out of the logos table for every page load. </p>',
'<div>Default Chameleon Icon made from <a href="http://www.onlinewebfonts.com/icon">Icon Fonts</a> is licensed by CC BY 3.0</div>',
'</br>',
'</br>',
'<p> Requested by Jason Choi </p>'))
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(33145579244171077776)
,p_plug_name=>'Sample - Logo from blob column'
,p_icon_css_classes=>'app-icon'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(33145473792786077661)
,p_plug_display_sequence=>10
,p_plug_display_point=>'REGION_POSITION_01'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<p> A sample application to use an image from a blob column as application logo </p>',
'',
'',
''))
,p_plug_query_num_rows=>15
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
,p_attribute_03=>'Y'
);
wwv_flow_api.component_end;
end;
/
