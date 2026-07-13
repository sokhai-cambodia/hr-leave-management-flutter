abstract class Routes {
  Routes._();

  static const splash = '/splash';
  static const login = '/login';
  static const forgotPassword = '/forgot-password';
  static const resetPassword = '/reset-password';

  static const dashboard = '/dashboard';
  static const schedule = '/schedule';
  static const leavePlanRequests = '/leave-plan-requests';
  static const leaveRequests = '/leave-requests';
  static const recommendations = '/recommendations';
  static const approvals = '/approvals';
  static const profile = '/profile';

  static const adminPolicies = '/admin/policies';
  static const adminPublicHolidays = '/admin/public-holidays';
  static const adminLeaveTypes = '/admin/leave-types';
  static const adminTeams = '/admin/teams';
  static const adminLeaveBalances = '/admin/leave-balances';
  static const adminUsers = '/admin/users';
}
