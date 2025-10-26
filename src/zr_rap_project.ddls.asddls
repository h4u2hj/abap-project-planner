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
      case status
        when 'S' then 3
        when 'N' then 2
        when 'O' then 2
        when 'X' then 1
        when 'C' then 1
        else 0
      end as StatusCriticality,
      @Semantics.amount.currencyCode: 'Currency'
      cost             as Cost,
      currency         as Currency,
      plannedstartdate as PlannedStartDate,
      daystostart      as DaysToStart,
      @Semantics.user.createdBy: true
      createdby        as CreatedBy,
      @Semantics.systemDateTime.createdAt: true
      createdat        as CreatedAt,
      @Semantics.user.lastChangedBy: true
      lastchangedby    as LastChangedBy,
      @Semantics.systemDateTime.lastChangedAt: true
      lastchangedat    as LastChangedAt,
      @Semantics.systemDateTime.localInstanceLastChangedAt: true
      locallastchanged as LocalLastChanged

}
