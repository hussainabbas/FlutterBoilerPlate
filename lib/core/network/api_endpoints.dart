// ignore_for_file: constant_identifier_names
class ApiEndPoints {
  ApiEndPoints._();

  static const String GET_LATEST_VERSION = 'Default/GetLatestVersion';

  static const String LOGIN = 'Default/Login';
  static const String UPDATE_USER_SESSION = 'Default/UpdateUserSession';

  ///DASHBOARD
  static const String GET_MAIL_COUNT = 'SecureMail/GetMailCount';

  ///STATEMENT
  static const String GET_STATEMENT_NEW = 'Statement/GetStatementNew';
  static const String GET_CATEGORY_SUPPORT_PLAN =
      'Statement/GetCategorySupportPlanList';
  static const String GET_FUNDING_SUPPORT_PLAN_STAR_DATE =
      'Statement/getFundingSupportPlanListStartDate';
  static const String GET_EMPLOYER_CLIENT_LIST =
      'Statement/getEmployersClientList';

  ///BUDGETING
  static const String GET_BUDGET_NEW = 'Budget/GetBudgetNew';
  static const String GET_BUDGET_ALLOCATION = 'Budget/getBugetAllocation';

  ///PAYEE
  static const String GET_EMPLOY_BY = 'Employee/GetEmployBy';
  static const String GET_EMPLOYEE_PAYEE_INITIALS =
      'Employee/EmployeePayeeInitials';
  static const String GET_EMPLOYEE_DOCUMENT_TYPE_BY =
      'Employee/GetDocumentTypeBy';
  static const String ADD_UPDATE_EMPLOYEE = 'Employee/UpdateEmpEr';

  ///NZ POST
  static const String GET_NZ_TOKEN = 'as/token.oauth2';
  static const String GET_NZ_ADDRESSES = 'addresschecker/1.0/suggest';

  ///TIMESHEET
  static const String GET_TIMESHEET = 'Timesheet/GetTimesheet';
  static const String GET_TIMESHEET_EMPLOYEE_DROPDOWN =
      'Timesheet/GetTimesheetEmployeeDropdownsEr';
  static const String GET_TIMESHEET_TRANSACTIONS_PERIODS =
      'Timesheet/GetTimesheetTransactionPeriodsEr';
  static const String GET_TIMESHEET_INITIALS_ER =
      'Timesheet/TimeSheetInitialsEr';
  static const String UPDATE_TIMESHEET = 'Timesheet/UpdateTimesheet';
}
