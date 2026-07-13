import 'package:get/get.dart';

import '../../features/admin/views/admin_leave_balances_view.dart';
import '../../features/admin/views/admin_public_holidays_view.dart';
import '../../features/admin/views/admin_teams_view.dart';
import '../../features/admin/views/admin_users_view.dart';
import '../../features/admin/bindings/leave_balances_admin_binding.dart';
import '../../features/admin/bindings/leave_types_admin_binding.dart';
import '../../features/admin/bindings/policies_admin_binding.dart';
import '../../features/admin/bindings/public_holidays_admin_binding.dart';
import '../../features/admin/bindings/teams_admin_binding.dart';
import '../../features/admin/bindings/users_admin_binding.dart';
import '../../features/admin/views/leave_types_view.dart';
import '../../features/admin/views/policies_view.dart';
import '../../features/approvals/bindings/approvals_binding.dart';
import '../../features/approvals/views/approvals_view.dart';
import '../../features/auth/views/forgot_password_view.dart';
import '../../features/auth/views/login_view.dart';
import '../../features/auth/views/reset_password_view.dart';
import '../../features/auth/views/splash_view.dart';
import '../../features/dashboard/bindings/dashboard_binding.dart';
import '../../features/dashboard/views/dashboard_view.dart';
import '../../features/leave_plan_requests/bindings/leave_plan_requests_binding.dart';
import '../../features/leave_plan_requests/views/leave_plan_requests_view.dart';
import '../../features/leave_requests/bindings/leave_requests_binding.dart';
import '../../features/leave_requests/views/leave_requests_view.dart';
import '../../features/profile/views/profile_view.dart';
import '../../features/recommendations/bindings/recommendations_binding.dart';
import '../../features/recommendations/views/recommendations_view.dart';
import '../../features/schedule/bindings/schedule_binding.dart';
import '../../features/schedule/views/schedule_view.dart';
import 'app_routes.dart';
import 'auth_middleware.dart';
import 'superuser_middleware.dart';

abstract class AppPages {
  AppPages._();

  static final pages = [
    GetPage(name: Routes.splash, page: () => const SplashView()),
    GetPage(name: Routes.login, page: () => const LoginView()),
    GetPage(
      name: Routes.forgotPassword,
      page: () => const ForgotPasswordView(),
    ),
    GetPage(name: Routes.resetPassword, page: () => const ResetPasswordView()),
    GetPage(
      name: Routes.dashboard,
      page: () => const DashboardView(),
      binding: DashboardBinding(),
      middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: Routes.schedule,
      page: () => const ScheduleView(),
      binding: ScheduleBinding(),
      middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: Routes.leavePlanRequests,
      page: () => const LeavePlanRequestsView(),
      binding: LeavePlanRequestsBinding(),
      middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: Routes.leaveRequests,
      page: () => const LeaveRequestsView(),
      binding: LeaveRequestsBinding(),
      middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: Routes.recommendations,
      page: () => const RecommendationsView(),
      binding: RecommendationsBinding(),
      middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: Routes.approvals,
      page: () => const ApprovalsView(),
      binding: ApprovalsBinding(),
      middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: Routes.profile,
      page: () => const ProfileView(),
      middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: Routes.adminPolicies,
      page: () => const PoliciesView(),
      binding: PoliciesAdminBinding(),
      middlewares: [AuthMiddleware(), SuperuserMiddleware()],
    ),
    GetPage(
      name: Routes.adminPublicHolidays,
      page: () => const AdminPublicHolidaysView(),
      binding: PublicHolidaysAdminBinding(),
      middlewares: [AuthMiddleware(), SuperuserMiddleware()],
    ),
    GetPage(
      name: Routes.adminLeaveTypes,
      page: () => const LeaveTypesView(),
      binding: LeaveTypesAdminBinding(),
      middlewares: [AuthMiddleware(), SuperuserMiddleware()],
    ),
    GetPage(
      name: Routes.adminTeams,
      page: () => const AdminTeamsView(),
      binding: TeamsAdminBinding(),
      middlewares: [AuthMiddleware(), SuperuserMiddleware()],
    ),
    GetPage(
      name: Routes.adminLeaveBalances,
      page: () => const AdminLeaveBalancesView(),
      binding: LeaveBalancesAdminBinding(),
      middlewares: [AuthMiddleware(), SuperuserMiddleware()],
    ),
    GetPage(
      name: Routes.adminUsers,
      page: () => const AdminUsersView(),
      binding: UsersAdminBinding(),
      middlewares: [AuthMiddleware(), SuperuserMiddleware()],
    ),
  ];
}
