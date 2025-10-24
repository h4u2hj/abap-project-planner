@AccessControl.authorizationCheck: #CHECK
@Metadata.allowExtensions: true
@EndUserText.label: 'CDS View for Project'
define root view entity ZR_RAP_PROJECT
  as select from zrap_project as Project
{
  key id               as ID,
      name             as Name,
      description      as Description,
      type             as Type,
      status           as Status,
      @Semantics.amount.currencyCode: 'Currency'
      cost             as Cost,
      currency         as Currency,
      plannedstartdate as PlannedStartDate,
      daystostart      as DaysToStart,
      @Semantics.user.createdBy: true
      createdby        as CreatedBy,
      createdat        as CreatedAt,
      @Semantics.user.lastChangedBy: true
      lastchangedby    as LastChangedBy,
      @Semantics.systemDateTime.lastChangedAt: true
      lastchangedat    as LastChangedAt,
      @Semantics.systemDateTime.localInstanceLastChangedAt: true
      locallastchanged as LocalLastChanged

}
