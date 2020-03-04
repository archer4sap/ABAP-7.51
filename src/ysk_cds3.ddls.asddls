@AbapCatalog.sqlViewName: 'YSK_CSDV3'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'YSK_CDS3_sumittest'
define view YSK_CDS3 as select from zagency {
    //zagency
    key agency_id,
    begin_date,
    end_date,
    description,
    overall_status,
    created_by,
    created_at,
    last_changed_by,
    last_changed_at
}
