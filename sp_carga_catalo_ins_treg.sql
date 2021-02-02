create or replace procedure SP_CARGA_CATALO_INS_Treg
/*-------------------------------------------------------------------------------------------------------------------------------------------------
--NOMBRE              : SP_CARGA_CATALO_INS_Treg
--NRO_RQ/DC/EX/OT     : Proyecto Ecosistema UGI
--OBJETIVO            : Procedimiento que actualiza estadisticas de esquema universal y guarda numero de registros
                        y columnas por tabla en la tabla SCH_DG_CATALO_INS_Treg
--AUTOR               : Christian Arutaype
--FECHA               : 19/01/2020
--PARAMETROS_ENTRADA :  -
--PARAMETROS_SALIDA :   -
-------------------------------------------------------------------------------------------------------------------------------------------------
MODIFICACIONES
-- FECHA       USUARIO    NRO_RQ   DESCRIPCION_DEL_CAMBIO
------------------------------------------------------------------------------------------------------------------------------------------------*/
as
begin
  DBMS_STATS.GATHER_SCHEMA_STATS('SCH_UNIVERSAL');
  insert into SCH_DG_CATALO_INS_Treg /*+NOLOGGING*/
  select t.owner, t.table_name, t.tablespace_name, count(c.column_name), t.num_rows, t.last_analyzed, sysdate
    from all_tables t
    left join all_tab_columns c on t.table_name=c.table_name
    where t.owner='SCH_UNIVERSAL'
    group by t.owner, t.table_name, t.tablespace_name, t.num_rows, t.last_analyzed, sysdate
  ;
  commit;
end SP_CARGA_CATALO_INS_Treg;