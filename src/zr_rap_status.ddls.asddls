@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'CDS View for Status'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZR_RAP_STATUS
  as select from zrap_status as Status
{
      @UI.textArrangement: #TEXT_ONLY
      @ObjectModel.text.element: [ 'StatusText' ]
  key Status.status_id   as StatusId,
      @UI.hidden: true
      Status.status_text as StatusText
}
