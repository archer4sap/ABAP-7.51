@AbapCatalog.sqlViewName: 'YTEST_SRM'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Ytest_srm1'
define view Ytest_srm1 as select from zagency {
    //zagency
    key agency_id,
    begin_date,
    //end_date,
    description,
    overall_status,
    created_by,
    created_at,
    last_changed_by,
    last_changed_at
}
