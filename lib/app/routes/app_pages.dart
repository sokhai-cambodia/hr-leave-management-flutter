import 'package:get/get.dart';

import '../../features/admin/views/admin_leave_balances_view.dart';
import '../../features/admin/views/admin_teams_view.dart';
import '../../features/admin/views/admin_users_view.dart';
import '../../features/admin/bindings/leave_types_admin_binding.dart';
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
import '../../features/public_holidays/views/public_holidays_view.dart';
import '../../features/recommendations/bindings/recommendations_binding.dart';
import '../../features/recommendations/views/recommendations_view.dart';
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
      name: Routes.publicHolidays,
      page: () => const PublicHolidaysView(),
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
      middlewares: [AuthMiddleware(), SuperuserMiddleware()],
    ),
    GetPage(
      name: Routes.adminLeaveBalances,
      page: () => const AdminLeaveBalancesView(),
      middlewares: [AuthMiddleware(), SuperuserMiddleware()],
    ),
    GetPage(
      name: Routes.adminUsers,
      page: () => const AdminUsersView(),
      middlewares: [AuthMiddleware(), SuperuserMiddleware()],
    ),
  ];
}
