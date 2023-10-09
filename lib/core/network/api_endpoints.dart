// ignore_for_file: constant_identifier_names
class ApiEndPoints {
  ApiEndPoints._();

  static const String GET_LATEST_VERSION = 'Default/GetLatestVersion';

  static const String LOGIN = 'Default/Login';
  static const String UPDATE_USER_SESSION = 'Default/UpdateUserSession';

  //DASHBOARD
  static const String GET_MAIL_COUNT = 'SecureMail/GetMailCount';

  //STATEMENT
  static const String GET_STATEMENT_NEW = 'Statement/GetStatementNew';
  static const String GET_CATEGORY_SUPPORT_PLAN =
      'Statement/GetCategorySupportPlanList';
  static const String GET_FUNDING_SUPPORT_PLAN_STAR_DATE =
      'Statement/getFundingSupportPlanListStartDate';

  //BUDGETING
  static const String GET_BUDGET_NEW = 'Budget/GetBudgetNew';

  //PAYEE
  static const String GET_EMPLOY_BY = 'Employee/GetEmployBy';
}
