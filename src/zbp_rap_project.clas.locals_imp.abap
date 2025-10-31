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
          lv_diff            TYPE i,
          lv_text            TYPE string,
          lt_update_projects TYPE TABLE FOR UPDATE zr_rap_project.

    READ ENTITIES OF zr_rap_project
      IN LOCAL MODE
      ENTITY Project
      ALL FIELDS WITH CORRESPONDING #( keys )
      RESULT lt_projects.

    DATA(lv_today) = cl_abap_context_info=>get_system_date( ).

    LOOP AT lt_projects INTO DATA(ls_project).

      lv_diff = ls_project-PlannedEndDate - lv_today.

      IF lv_diff > 0.
        " e.g. '1 day' or '5 days'
        lv_text = |{ lv_diff } day{ COND string( WHEN lv_diff = 1 THEN '' ELSE 's' ) }|.
      ELSE.
        IF ls_project-Status = 'C' OR ls_project-Status = 'X'.
            lv_text = 'Project already finished'.
        ELSE.
            lv_text = 'Project not started yet started'.
        ENDIF.
      ENDIF.

      APPEND VALUE #( id = ls_project-id daystostart = lv_text )
             TO lt_update_projects.
    ENDLOOP.

    IF lt_update_projects IS NOT INITIAL.
      MODIFY ENTITIES OF zr_rap_project IN LOCAL MODE
        ENTITY Project
        UPDATE FIELDS ( daystostart )
        WITH lt_update_projects
        FAILED   DATA(ls_failed)
        REPORTED DATA(ls_reported).
    ENDIF.

    result = VALUE #( FOR projects IN lt_projects
                      ( id = projects-id %param = projects ) ).
  ENDMETHOD.

ENDCLASS.
