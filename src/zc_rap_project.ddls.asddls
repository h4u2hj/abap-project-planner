@AccessControl.authorizationCheck: #CHECK
@Metadata.allowExtensions: true
@EndUserText.label: 'Projection View for ZR_RAP_PROJECT'
define root view entity ZC_RAP_PROJECT
  provider contract transactional_query
  as projection on ZR_RAP_PROJECT
{
  key ID,
  Name,
  Description,
  Type,
  Status,
  Cost,
  Currency,
  Startdate,
  Plannedstartdate,
  Startedintime,
  Createdat,
  Locallastchanged
  
}
