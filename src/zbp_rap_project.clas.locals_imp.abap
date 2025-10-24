CLASS lhc_project DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.
    METHODS:
      get_global_authorizations FOR GLOBAL AUTHORIZATION
        IMPORTING
        REQUEST requested_authorizations FOR Project
        RESULT result,
      checkStartedInTime FOR MODIFY
        IMPORTING keys FOR ACTION Project~checkStartedInTime RESULT result.
ENDCLASS.

CLASS lhc_project IMPLEMENTATION.
  METHOD get_global_authorizations.
  ENDMETHOD.
  METHOD checkStartedInTime.
    DATA: lt_projects        TYPE TABLE FOR READ RESULT zr_rap_project,
          ls_project         TYPE STRUCTURE FOR READ RESULT zr_rap_project,
          lv_planned         TYPE d,
          lv_current_date    TYPE d,
          lv_daystostart     TYPE c,
          lt_update_projects TYPE TABLE FOR UPDATE zr_rap_project.

    READ ENTITIES OF zr_rap_project
      IN LOCAL MODE ENTITY Project
      ALL FIELDS WITH CORRESPONDING #( keys )
      RESULT lt_projects.

    LOOP AT lt_projects INTO ls_project.
      lv_planned = ls_project-PlannedStartDate.
      lv_current_date = cl_abap_context_info=>get_system_date( ).
      IF lv_planned < lv_current_date.

      ELSE.

      ENDIF.

      APPEND VALUE #( id = ls_project-id daystostart = lv_daystostart )
        TO lt_update_projects.
      MODIFY ENTITIES OF zr_rap_project IN LOCAL MODE
        ENTITY Project
        UPDATE FIELDS ( daystostart )
        WITH lt_update_projects.
    ENDLOOP.

    result = VALUE #( FOR projects IN lt_projects
                      ( id = projects-id %param = projects ) ).
  ENDMETHOD.

ENDCLASS.
