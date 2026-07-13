# Graph Report - hr-leave-management-flutter  (2026-07-13)

## Corpus Check
- 114 files · ~35,408 words
- Verdict: corpus is large enough that graph structure adds value.

## Summary
- 1223 nodes · 1628 edges · 90 communities (80 shown, 10 thin omitted)
- Extraction: 99% EXTRACTED · 1% INFERRED · 0% AMBIGUOUS · INFERRED: 14 edges (avg confidence: 0.8)
- Token cost: 0 input · 0 output

## Graph Freshness
- Built from commit: `d1852158`
- Run `git rev-parse HEAD` and compare to check if the graph is stale.
- Run `graphify update .` after code changes (no API cost).

## Community Hubs (Navigation)
- App Architecture & Design Rationale
- Windows Runner: Flutter/Win32 Embedding
- GetX Routes, Pages & Middleware Registry
- Route Names & Token Storage
- AuthController & DI Bindings
- Dio Client Auth Test Suite
- Leave Requests Controller
- Leave Recommendation Model & App Shell
- App Theme & Design Tokens
- Leave Plan Requests Controller
- Leave Plan Request Model
- Dashboard View
- Leave Request Model
- Leave Request Form View
- Leave Plan Request Form View
- Balances/Recommends/Teams Repositories
- Leave Plan Request Detail View
- Recommendations Controller & View
- Leave Plan Requests List View
- Leave Requests List View
- Leave Request Detail View
- Leave Requests Repository
- Admin & Approvals Placeholder Views
- Windows Runner Utils & Main
- Leave Plan Requests Repository
- Recommendations Controller Logic
- Leave Balance Model
- Leave Type Model
- Auth Views (Login/Forgot/Reset)
- GetX Feature Bindings
- User Model
- Leave View State Classes
- Dashboard Controller
- App Drawer Widget
- Auth Repository
- admin_form_dialog.dart
- Dio Client
- leave_types_view.dart
- API Exception Handling
- Profile View
- leave_request_detail_view.dart
- Team Model
- Splash View
- leave_recommendation_model.dart
- Android Plugin Registrant
- Gradle Wrapper Script
- Placeholder Screen Widget
- Leave Types Repository
- leave_types_admin_controller.dart
- leave_balance_model.dart
- Android MainActivity
- Admin Teams View
- ../../app/theme/app_theme.dart
- admin_users_view.dart
- Windows CMake Build Config
- local_cache_service.dart
- App Launcher Icon (hdpi)
- App Launcher Icon (mdpi)
- App Launcher Icon (xhdpi)
- App Launcher Icon (xxhdpi)
- App Launcher Icon (xxxhdpi)
- initial_binding.dart
- Misc Constant
- user_model.dart
- api_exception.dart
- public_holidays_admin_controller.dart
- user_summary.dart
- admin_field_spec.dart
- Phase 4 — Leave Requests (owner lifecycle)
- policies_admin_controller.dart
- Phase 0 — Environment & Scaffolding
- AuthController
- splash_view.dart
- admin_public_holidays_view.dart
- dashboard_binding.dart
- List
- users_repository.dart
- AdminCrudController
- local_cache_service.dart
- public_holiday_model.dart
- app_smoke_test.dart
- pubspec.yaml — Package Manifest
- dashboard_controller.dart
- LeavePlanRequestsController
- public_holidays_admin_controller.dart
- RegisterPlugins
- hr_leave_management

## God Nodes (most connected - your core abstractions)
1. `HR Leave Management — Flutter Client — Implementation Plan` - 19 edges
2. `Win32Window` - 19 edges
3. `HR Leave Management — Flutter Client — Task Checklist` - 12 edges
4. `MessageHandler` - 12 edges
5. `HR Leave Management — Flutter Client — SPEC` - 11 edges
6. `AuthController` - 11 edges
7. `FlutterWindow` - 10 edges
8. `Create` - 10 edges
9. `WndProc` - 10 edges
10. `HR Leave Management — Flutter Client` - 8 edges

## Surprising Connections (you probably didn't know these)
- `_FakeTokenStorage` --implements--> `TokenStorage`  [EXTRACTED]
  test/unit/dio_client_unauthorized_test.dart → lib/core/storage/token_storage.dart
- `OnCreate` --calls--> `RegisterPlugins()`  [INFERRED]
  windows/runner/flutter_window.h → windows/flutter/generated_plugin_registrant.cc
- `wWinMain()` --calls--> `CreateAndAttachConsole()`  [INFERRED]
  windows/runner/main.cpp → windows/runner/utils.cpp
- `Win32Window::Win32Window()` --calls--> `Destroy`  [INFERRED]
  windows/runner/win32_window.cpp → windows/runner/win32_window.h
- `LeaveTypesAdminController` --inherits--> `AdminCrudController`  [EXTRACTED]
  lib/features/admin/controllers/leave_types_admin_controller.dart → lib/features/admin/controllers/admin_crud_controller.dart

## Import Cycles
- None detected.

## Communities (90 total, 10 thin omitted)

### Community 0 - "App Architecture & Design Rationale"
Cohesion: 0.22
Nodes (8): Bindings, ../controllers/dashboard_controller.dart, InitialBinding, DashboardBinding, dependencies, LeavePlanRequestsBinding, LeaveRequestsBinding, PublicHolidaysBinding

### Community 1 - "Windows Runner: Flutter/Win32 Embedding"
Cohesion: 0.12
Nodes (16): FlutterViewController, unique_ptr, DartProject, HWND, LPARAM, LRESULT, UINT, WPARAM (+8 more)

### Community 2 - "GetX Routes, Pages & Middleware Registry"
Cohesion: 0.05
Nodes (42): app_routes.dart, auth_middleware.dart, ../../features/admin/bindings/leave_balances_admin_binding.dart, ../../features/admin/bindings/leave_types_admin_binding.dart, ../../features/admin/bindings/policies_admin_binding.dart, ../../features/admin/bindings/public_holidays_admin_binding.dart, ../../features/admin/bindings/teams_admin_binding.dart, ../../features/admin/bindings/users_admin_binding.dart (+34 more)

### Community 3 - "Route Names & Token Storage"
Cohesion: 0.04
Nodes (41): ../constants/env.dart, FlutterSecureStorage, adminLeaveBalances, adminLeaveTypes, adminPolicies, adminPublicHolidays, adminTeams, adminUsers (+33 more)

### Community 4 - "AuthController & DI Bindings"
Cohesion: 0.09
Nodes (21): _authRepository, bootstrap, currentUser, errorMessage, forceLogout, isApprover, _isHandlingUnauthorized, isLoading (+13 more)

### Community 5 - "Dio Client Auth Test Suite"
Cohesion: 0.05
Nodes (38): dart:typed_data, DioException, HttpClientAdapter, package:flutter_test/flutter_test.dart, package:hr_leave_management/core/errors/api_exception.dart, package:hr_leave_management/core/network/dio_client.dart, package:hr_leave_management/core/storage/secure_storage_service.dart, package:hr_leave_management/core/storage/token_storage.dart (+30 more)

### Community 6 - "Leave Requests Controller"
Cohesion: 0.08
Nodes (24): createRequest, currentRequest, deleteRequest, detailErrorMessage, errorMessage, fetchLeaveRequests, fetchLeaveTypes, fetchRequestDetail (+16 more)

### Community 7 - "Leave Recommendation Model & App Shell"
Cohesion: 0.07
Nodes (30): ../controllers/approvals_controller.dart, ../../../data/models/leave_plan_request_model.dart, ../../../data/models/leave_request_model.dart, ApprovalsBinding, dependencies, ApprovalsController, approveLeavePlanRequest, approveLeaveRequest (+22 more)

### Community 8 - "App Theme & Design Tokens"
Cohesion: 0.09
Nodes (22): AppColors, AppShapes, AppTheme, _build, buttonRadius, cardRadius, danger, dark (+14 more)

### Community 9 - "Leave Plan Requests Controller"
Cohesion: 0.07
Nodes (26): createAndSubmitRequest, createRequest, currentRequest, deleteRequest, detailErrorMessage, errorMessage, fetchLeavePlanRequests, fetchLeaveTypes (+18 more)

### Community 10 - "Leave Plan Request Model"
Cohesion: 0.09
Nodes (22): amount, approvalAt, approver, approverId, description, details, fromJson, id (+14 more)

### Community 11 - "Dashboard View"
Cohesion: 0.08
Nodes (28): AuthController, DashboardController, LeaveBalanceModel, ApprovalsView, _availableDaysSummary, balance, balances, build (+20 more)

### Community 12 - "Leave Request Model"
Cohesion: 0.09
Nodes (22): leave_balance_model.dart, amount, approvalAt, approver, approverId, description, endDate, fromJson (+14 more)

### Community 13 - "Leave Request Form View"
Cohesion: 0.11
Nodes (18): bool get, LeaveRequestModel, build, controller, createState, _descriptionController, dispose, _endDate (+10 more)

### Community 14 - "Leave Plan Request Form View"
Cohesion: 0.10
Nodes (20): LeavePlanRequestModel, _addPlannedDate, build, controller, createState, _descriptionController, dispose, _formatDate (+12 more)

### Community 15 - "Balances/Recommends/Teams Repositories"
Cohesion: 0.33
Nodes (5): Dio, _dio, fetchRecommendations, RecommendsRepository, ../models/leave_recommendation_model.dart

### Community 16 - "Leave Plan Request Detail View"
Cohesion: 0.12
Nodes (17): ../controllers/leave_plan_requests_controller.dart, leave_plan_request_form_view.dart, dependencies, LeavePlanRequestsController, build, _buildDetailRow, _buildTimelineRow, _confirmDelete (+9 more)

### Community 17 - "Recommendations Controller & View"
Cohesion: 0.18
Nodes (9): Architecture, Backend contract quirks that shape the code (verified against backend source, not just docs — see `tasks/plan.md` "Verified Backend Ground Truth"), Boundaries, Commands, Design tokens, graphify, Running the backend for manual verification, Testing strategy (+1 more)

### Community 18 - "Leave Plan Requests List View"
Cohesion: 0.14
Nodes (14): leave_plan_request_detail_view.dart, build, _buildPlanCard, controller, createState, dispose, _formatDate, _getStatusColor (+6 more)

### Community 19 - "Leave Requests List View"
Cohesion: 0.22
Nodes (8): ../../../data/repositories/leave_types_repository.dart, createItem, deleteItem, fetchPage, idOf, matchesSearch, repository, updateItem

### Community 20 - "Leave Request Detail View"
Cohesion: 0.17
Nodes (11): leave_request_detail_view.dart, build, _buildRequestCard, controller, createState, dispose, _formatDate, _getStatusColor (+3 more)

### Community 21 - "Leave Requests Repository"
Cohesion: 0.17
Nodes (11): approveLeaveRequest, createLeaveRequest, deleteLeaveRequest, _dio, fetchLeaveRequest, fetchLeaveRequests, LeaveRequestsRepository, rejectLeaveRequest (+3 more)

### Community 22 - "Admin & Approvals Placeholder Views"
Cohesion: 0.17
Nodes (11): ../controllers/public_holidays_controller.dart, dependencies, PublicHolidaysController, build, _buildHolidayCard, _formatDate, _formatMonthHeading, _monthNames (+3 more)

### Community 23 - "Windows Runner Utils & Main"
Cohesion: 0.24
Nodes (9): _In_, _In_opt_, vector, wWinMain(), string, wchar_t, CreateAndAttachConsole(), GetCommandLineArguments() (+1 more)

### Community 24 - "Leave Plan Requests Repository"
Cohesion: 0.17
Nodes (11): approveLeavePlanRequest, createLeavePlanRequest, deleteLeavePlanRequest, _dio, fetchLeavePlanRequest, fetchLeavePlanRequests, LeavePlanRequestsRepository, rejectLeavePlanRequest (+3 more)

### Community 25 - "Recommendations Controller Logic"
Cohesion: 0.07
Nodes (29): ../controllers/recommendations_controller.dart, ../../../data/models/leave_recommendation_model.dart, ../../leave_plan_requests/bindings/leave_plan_requests_binding.dart, ../../leave_plan_requests/controllers/leave_plan_requests_controller.dart, ../../leave_plan_requests/views/leave_plan_request_form_view.dart, dependencies, RecommendationsBinding, changeYear (+21 more)

### Community 26 - "Leave Balance Model"
Cohesion: 0.15
Nodes (12): HR Leave Management — Flutter Client — Task Checklist, Phase 0 — Environment & Scaffolding, Phase 10 — Post-Launch Enhancements, Phase 1 — Auth & Session, Phase 2 — App Shell, Role-Adaptive Navigation, Dashboard, Phase 3 — Leave Balances, Phase 4 — Leave Requests, Phase 5 — Leave Plan Requests (+4 more)

### Community 27 - "Leave Type Model"
Cohesion: 0.12
Nodes (16): LeaveTypesRepository, createItem, deleteItem, fetchPage, idOf, leaveTypeOptions, leaveTypesRepository, _loadLeaveTypeOptions (+8 more)

### Community 28 - "Auth Views (Login/Forgot/Reset)"
Cohesion: 0.11
Nodes (18): ../controllers/leave_requests_controller.dart, GetxController, leave_request_form_view.dart, DashboardController, dependencies, LeaveRequestsController, build, _buildDetailRow (+10 more)

### Community 29 - "GetX Feature Bindings"
Cohesion: 0.05
Nodes (33): app_drawer.dart, count, data, PaginatedResult, description, email, fromJson, fullName (+25 more)

### Community 30 - "User Model"
Cohesion: 0.09
Nodes (21): create, createItem, delete, deleteItem, edit, errorMessage, fetchItems, fetchPage (+13 more)

### Community 31 - "Leave View State Classes"
Cohesion: 0.17
Nodes (16): SplashView, _SplashViewState, LeavePlanRequestFormView, _LeavePlanRequestFormViewState, LeaveRequestDetailView, _LeaveRequestDetailViewState, LeaveRequestFormView, _LeaveRequestFormViewState (+8 more)

### Community 32 - "Dashboard Controller"
Cohesion: 0.20
Nodes (9): code, description, entitlement, fromJson, id, isActive, isAllowPlan, name (+1 more)

### Community 33 - "App Drawer Widget"
Cohesion: 0.16
Nodes (16): ../../../app/routes/app_routes.dart, ../controllers/auth_controller.dart, FormState, GetView, AuthController, build, ForgotPasswordView, build (+8 more)

### Community 34 - "Auth Repository"
Cohesion: 0.22
Nodes (8): AuthRepository, _dio, fetchMe, login, recoverPassword, resetPassword, testToken, ../models/user_model.dart

### Community 35 - "admin_form_dialog.dart"
Cohesion: 0.11
Nodes (17): admin_field_spec.dart, admin_form_dialog.dart, ../../features/admin/controllers/admin_crud_controller.dart, build, _confirmDelete, controller, createState, dispose (+9 more)

### Community 36 - "Dio Client"
Cohesion: 0.17
Nodes (11): createItem, deleteItem, fetchPage, idOf, _loadTeamOptions, matchesSearch, onInit, repository (+3 more)

### Community 37 - "leave_types_view.dart"
Cohesion: 0.17
Nodes (11): double?, code, description, fromJson, id, isActive, name, operation (+3 more)

### Community 38 - "API Exception Handling"
Cohesion: 0.22
Nodes (8): createPolicy, deletePolicy, _dio, fetchPolicies, PoliciesRepository, updatePolicy, ../models/policy_model.dart, package:dio/dio.dart

### Community 39 - "Profile View"
Cohesion: 0.29
Nodes (6): ../../auth/controllers/auth_controller.dart, build, _InfoRow, label, value, ../../../widgets/app_shell_scaffold.dart

### Community 40 - "leave_request_detail_view.dart"
Cohesion: 0.18
Nodes (14): Point, Size, wchar_t, Scale(), Create, Destroy, UpdateTheme, Win32Window::Win32Window() (+6 more)

### Community 41 - "Team Model"
Cohesion: 0.04
Nodes (45): Context, Critical Files, HR Leave Management — Flutter Client — Implementation Plan, Overall Verification, Phase 0 — Environment & Scaffolding, Phase 10 — Post-Launch Enhancements (after Checkpoint 9), Phase 1 — Auth & Session, Phase 2 — App Shell, Role-Adaptive Navigation, Dashboard (+37 more)

### Community 42 - "Splash View"
Cohesion: 0.18
Nodes (11): AdminCrudController, ../controllers/leave_balances_admin_controller.dart, ../../../data/models/leave_balance_model.dart, LeaveBalanceModel, dependencies, LeaveBalancesAdminBinding, LeaveBalancesAdminController, AdminLeaveBalancesView (+3 more)

### Community 43 - "leave_recommendation_model.dart"
Cohesion: 0.15
Nodes (12): DateTime, bridgeHoliday, data, fromJson, leaveDate, LeaveRecommendationItem, LeaveRecommendationsModel, leaveTypeId (+4 more)

### Community 44 - "Android Plugin Registrant"
Cohesion: 0.60
Nodes (3): GeneratedPluginRegistrant, FlutterEngine, Keep

### Community 45 - "Gradle Wrapper Script"
Cohesion: 0.60
Nodes (3): gradlew script, die(), warn()

### Community 46 - "Placeholder Screen Widget"
Cohesion: 0.40
Nodes (4): app_shell_scaffold.dart, build, PlaceholderScreen, title

### Community 47 - "Leave Types Repository"
Cohesion: 0.22
Nodes (8): createLeaveType, deleteLeaveType, _dio, fetchLeaveTypes, fetchLeaveTypesPage, LeaveTypesRepository, updateLeaveType, ../models/leave_type_model.dart

### Community 49 - "leave_balance_model.dart"
Cohesion: 0.12
Nodes (15): availableBalance, balance, code, fromJson, id, leaveType, LeaveTypeSummary, name (+7 more)

### Community 51 - "Admin Teams View"
Cohesion: 0.22
Nodes (8): createBalance, deleteBalance, _dio, fetchBalancesPage, fetchMyBalances, LeaveBalancesRepository, updateBalance, ../models/leave_balance_model.dart

### Community 52 - "../../app/theme/app_theme.dart"
Cohesion: 0.13
Nodes (13): app/bindings/initial_binding.dart, app/routes/app_pages.dart, ../../../app/theme/app_theme.dart, _dartDefineApiBaseUrl, _defaultApiBaseUrl, Env, build, HrLeaveManagementApp (+5 more)

### Community 53 - "admin_users_view.dart"
Cohesion: 0.22
Nodes (9): ../controllers/users_admin_controller.dart, ../../../data/models/user_model.dart, UserModel, dependencies, UsersAdminBinding, UsersAdminController, AdminUsersView, build (+1 more)

### Community 54 - "Windows CMake Build Config"
Cohesion: 1.00
Nodes (3): windows/CMakeLists.txt — Windows Project Config, windows/flutter/CMakeLists.txt — Flutter Build Rules, windows/runner/CMakeLists.txt — Runner Executable Target

### Community 55 - "local_cache_service.dart"
Cohesion: 0.22
Nodes (8): IconData, AppDrawer, build, icon, _initials, label, _NavTile, route

### Community 64 - "initial_binding.dart"
Cohesion: 0.18
Nodes (10): ../../core/network/dio_client.dart, ../../core/storage/local_cache_service.dart, ../../core/storage/secure_storage_service.dart, ../../data/repositories/auth_repository.dart, ../../data/repositories/leave_plan_requests_repository.dart, ../../data/repositories/leave_requests_repository.dart, ../../data/repositories/recommends_repository.dart, ../../data/repositories/teams_repository.dart (+2 more)

### Community 66 - "user_model.dart"
Cohesion: 0.18
Nodes (10): email, fromJson, fullName, id, isActive, isSuperuser, name, team (+2 more)

### Community 67 - "api_exception.dart"
Cohesion: 0.20
Nodes (9): Exception, int?, ApiException, _extractMessage, fromDioException, message, _networkErrorMessage, statusCode (+1 more)

### Community 68 - "public_holidays_admin_controller.dart"
Cohesion: 0.18
Nodes (10): admin_crud_controller.dart, ../../../data/repositories/public_holidays_repository.dart, PublicHolidaysRepository, createItem, deleteItem, fetchPage, idOf, matchesSearch (+2 more)

### Community 69 - "user_summary.dart"
Cohesion: 0.29
Nodes (6): email, fromJson, fullName, id, toJson, UserSummary

### Community 70 - "admin_field_spec.dart"
Cohesion: 0.10
Nodes (19): _boolValues, build, _buildField, _buildRelationField, createState, dispose, fields, _findOption (+11 more)

### Community 71 - "Phase 4 — Leave Requests (owner lifecycle)"
Cohesion: 0.16
Nodes (12): ../controllers/policies_admin_controller.dart, ../../../data/models/policy_model.dart, PolicyModel, dependencies, PoliciesAdminBinding, AdminCrudController, PoliciesAdminController, build (+4 more)

### Community 72 - "policies_admin_controller.dart"
Cohesion: 0.20
Nodes (9): ../../../data/models/paginated_result.dart, ../../data/repositories/policies_repository.dart, createItem, deleteItem, fetchPage, idOf, matchesSearch, repository (+1 more)

### Community 73 - "Phase 0 — Environment & Scaffolding"
Cohesion: 0.20
Nodes (10): ../controllers/teams_admin_controller.dart, ../../../data/models/team_model.dart, TeamModel, dependencies, TeamsAdminBinding, TeamsAdminController, AdminTeamsView, build (+2 more)

### Community 74 - "AuthController"
Cohesion: 0.17
Nodes (11): createItem, deleteItem, fetchPage, idOf, _loadUserOptions, matchesSearch, onInit, repository (+3 more)

### Community 75 - "splash_view.dart"
Cohesion: 0.17
Nodes (11): 10. Boundaries, 1. Objective, 2. Tech Stack (per course guideline), 3. Commands, 4. Project Structure, 5. Code Style, 6. Testing Strategy, 7. Known Gaps vs. Guideline (decided, documented — not open questions) (+3 more)

### Community 76 - "admin_public_holidays_view.dart"
Cohesion: 0.18
Nodes (11): ../controllers/public_holidays_admin_controller.dart, ../../../data/models/public_holiday_model.dart, PublicHolidayModel, dependencies, PublicHolidaysAdminBinding, PublicHolidaysAdminController, AdminPublicHolidaysView, build (+3 more)

### Community 77 - "dashboard_binding.dart"
Cohesion: 0.25
Nodes (7): ../../../core/errors/api_exception.dart, createPublicHoliday, deletePublicHoliday, _dio, fetchPublicHolidays, updatePublicHoliday, ../models/public_holiday_model.dart

### Community 78 - "List"
Cohesion: 0.22
Nodes (8): createTeam, deleteTeam, _dio, fetchTeams, fetchTeamsPage, TeamsRepository, updateTeam, ../models/team_model.dart

### Community 79 - "users_repository.dart"
Cohesion: 0.25
Nodes (7): createUser, deleteUser, _dio, fetchUsersPage, updateUser, UsersRepository, ../models/paginated_result.dart

### Community 80 - "AdminCrudController"
Cohesion: 0.18
Nodes (11): ../controllers/leave_types_admin_controller.dart, ../../../data/models/leave_type_model.dart, LeaveTypeModel, dependencies, LeaveTypesAdminBinding, LeaveTypesAdminController, build, _emptyValues (+3 more)

### Community 81 - "local_cache_service.dart"
Cohesion: 0.29
Nodes (7): GetStorage, _box, LocalCacheService, remove, write, package:get_storage/get_storage.dart, T

### Community 82 - "public_holiday_model.dart"
Cohesion: 0.29
Nodes (6): date, description, fromJson, id, name, toJson

### Community 83 - "app_smoke_test.dart"
Cohesion: 0.21
Nodes (12): RECT, OnCreate, HWND, Win32Window, child_content_, GetClientArea, OnCreate, quit_on_close_ (+4 more)

### Community 85 - "dashboard_controller.dart"
Cohesion: 0.36
Nodes (10): HWND, LPARAM, LRESULT, UINT, WPARAM, EnableFullDpiSupportIfAvailable(), GetHandle, GetThisFromHandle (+2 more)

### Community 86 - "LeavePlanRequestsController"
Cohesion: 0.25
Nodes (7): ../../../data/repositories/leave_balances_repository.dart, balances, balancesError, fetchBalances, isLoadingBalances, _leaveBalancesRepository, onInit

### Community 87 - "public_holidays_admin_controller.dart"
Cohesion: 0.18
Nodes (10): errorMessage, fetchHolidays, focusedMonth, groupByDay, holidays, holidaysInMonth, isLoading, onInit (+2 more)

### Community 90 - "hr_leave_management"
Cohesion: 0.22
Nodes (8): Choosing a backend URL (`.env`), Common commands, First-time setup, Getting started with Flutter, HR Leave Management — Flutter Client, Prerequisites, Project docs, Running the backend locally (optional)

## Knowledge Gaps
- **745 isolated node(s):** `1. Objective`, `2. Tech Stack (per course guideline)`, `3. Commands`, `4. Project Structure`, `5. Code Style` (+740 more)
  These have ≤1 connection - possible missing edges or undocumented components.
- **10 thin communities (<3 nodes) omitted from report** — run `graphify query` to explore isolated nodes.

## Suggested Questions
_Questions this graph is uniquely positioned to answer:_

- **Why does `LeaveRequestModel` connect `Leave Request Form View` to `Leave Request Model`, `Leave Requests Controller`?**
  _High betweenness centrality (0.025) - this node is a cross-community bridge._
- **Why does `PublicHolidayModel` connect `admin_public_holidays_view.dart` to `public_holiday_model.dart`?**
  _High betweenness centrality (0.021) - this node is a cross-community bridge._
- **Why does `LeaveTypeModel` connect `AdminCrudController` to `Dashboard Controller`?**
  _High betweenness centrality (0.015) - this node is a cross-community bridge._
- **What connects `1. Objective`, `2. Tech Stack (per course guideline)`, `3. Commands` to the rest of the system?**
  _745 weakly-connected nodes found - possible documentation gaps or missing edges._
- **Should `Windows Runner: Flutter/Win32 Embedding` be split into smaller, more focused modules?**
  _Cohesion score 0.11695906432748537 - nodes in this community are weakly interconnected._
- **Should `GetX Routes, Pages & Middleware Registry` be split into smaller, more focused modules?**
  _Cohesion score 0.047474747474747475 - nodes in this community are weakly interconnected._
- **Should `Route Names & Token Storage` be split into smaller, more focused modules?**
  _Cohesion score 0.044444444444444446 - nodes in this community are weakly interconnected._