@AccessControl.authorizationCheck: #CHECK
@Metadata.allowExtensions: true
@Search: { searchable: true }
@EndUserText.label: 'Projection View for ZR_RAP_PROJECT'
define root view entity ZC_RAP_PROJECT
  provider contract transactional_query
  as projection on ZR_RAP_PROJECT
{
  key ID,
      @Search.defaultSearchElement: true
      Name,
      Description,
      @Search.defaultSearchElement: true
      Type,
      @Semantics.amount.currencyCode: 'Currency'
      Cost,
      @Semantics.amount.currencyCode : 'Currency'
      Budget,
      @Consumption.valueHelpDefinition: [ {
        entity: {
          name: 'I_Currency',
          element: 'Currency'
        }
      } ]
      Currency,
      PlannedStartDate,
      PlannedEndDate,
      DaysToStart,
      StatusCriticality,
      _Status.status_id as StatusId,
      _Status.status_text as StatusText,
      @ObjectModel.text.element: [ 'StatusText' ]
      Status,
      CreatedAt,
      CreatedBy,
      LastChangedAt,
      LastChangedBy,
      LocalLastChanged

}
