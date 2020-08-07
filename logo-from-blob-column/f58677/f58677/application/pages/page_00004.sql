prompt --application/pages/page_00004
begin
--   Manifest
--     PAGE: 00004
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
 p_id=>4
,p_user_interface_id=>wwv_flow_api.id(33145567923815077746)
,p_name=>'Hidden - Download Image'
,p_alias=>'HIDDEN-DOWNLOAD-IMAGE'
,p_step_title=>'Hidden - Download Image'
,p_autocomplete_on_off=>'OFF'
,p_page_template_options=>'#DEFAULT#'
,p_page_is_public_y_n=>'Y'
,p_deep_linking=>'Y'
,p_rejoin_existing_sessions=>'P'
,p_last_updated_by=>'KROMOSOETO.S@GMAIL.COM'
,p_last_upd_yyyymmddhh24miss=>'20200807071206'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(19408765491128601039)
,p_plug_name=>'New'
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_plug_template=>wwv_flow_api.id(33145483372276077668)
,p_plug_display_sequence=>10
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(19408765592359601040)
,p_name=>'P4_LOGO_ID'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(19408765491128601039)
,p_prompt=>'Logo Id'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_field_template=>wwv_flow_api.id(33145544366936077722)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(19408765660646601041)
,p_process_sequence=>10
,p_process_point=>'BEFORE_HEADER'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Retrieve image'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'  l_file_name     apex_application_static_files.file_name%type;',
'  l_mime_type     apex_application_static_files.mime_type%type;',
'  l_file_charset  apex_application_static_files.file_charset%type;  ',
'  l_file_content  apex_application_static_files.file_content%type;',
'begin',
'  begin',
'  select nvl(name, ''output'') as file_name, ',
'         nvl(photo_mimetype, ''application/octet-stream'') as mime_type, ',
'         nvl(photo_charset, ''utf-8'') as file_charset, ',
'         photo',
'    into l_file_name, ',
'         l_mime_type, ',
'         l_file_charset, ',
'         l_file_content',
'    from logos',
'   where id      = :P4_LOGO_ID;',
'  exception',
'  when no_data_found then',
'  select nvl(file_name, ''output'') as file_name, ',
'         nvl(mime_type, ''application/octet-stream'') as mime_type, ',
'         nvl(file_charset, ''utf-8'') as file_charset, ',
'         file_content',
'    into l_file_name, ',
'         l_mime_type, ',
'         l_file_charset, ',
'         l_file_content',
'    from apex_application_static_files ',
'   where application_id = :APP_ID ',
'     and file_name      = ''chameleonDefaultLogo.png'';',
'  end;',
'  ',
'  sys.htp.flush;',
'  sys.htp.init;',
'  owa_util.mime_header(l_mime_type, false);',
'  sys.htp.p(''Content-length:''||dbms_lob.getlength(l_file_content));',
'  sys.htp.p(''Content-Disposition:attachment; filename="''||l_file_name||''"; ''||''filename*=''||l_file_charset||''''''''''''||l_file_name);',
'  owa_util.http_header_close;',
'  wpg_docload.download_file(l_file_content);',
'  apex_application.stop_apex_engine;',
'',
'exception',
'  when no_data_found',
'  then',
'    sys.htp.p('''');',
'    apex_application.stop_apex_engine;',
'end;  '))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
wwv_flow_api.component_end;
end;
/
