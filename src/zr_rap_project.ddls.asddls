@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: '##GENERATED ZRAP_PROJECT'
define root view entity ZR_RAP_PROJECT
  as select from zrap_project as Project
{
  key id as ID,
  name as Name,
  description as Description,
  type as Type,
  status as Status,
  @Semantics.amount.currencyCode: 'Currency'
  cost as Cost,
  currency as Currency,
  startdate as Startdate,
  plannedstartdate as Plannedstartdate,
  startedintime as Startedintime,
  @Semantics.user.createdBy: true
  createdby as Createdby,
  createdat as Createdat,
  @Semantics.user.lastChangedBy: true
  lastchangedby as Lastchangedby,
  @Semantics.systemDateTime.lastChangedAt: true
  lastchangedat as Lastchangedat,
  @Semantics.systemDateTime.localInstanceLastChangedAt: true
  locallastchanged as Locallastchanged
  
}
