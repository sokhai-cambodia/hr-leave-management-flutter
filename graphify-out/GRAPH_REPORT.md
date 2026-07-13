# Graph Report - hr-leave-management-flutter  (2026-07-13)

## Corpus Check
- 111 files · ~33,987 words
- Verdict: corpus is large enough that graph structure adds value.

## Summary
- 1187 nodes · 1581 edges · 84 communities (75 shown, 9 thin omitted)
- Extraction: 99% EXTRACTED · 1% INFERRED · 0% AMBIGUOUS · INFERRED: 14 edges (avg confidence: 0.8)
- Token cost: 0 input · 0 output

## Graph Freshness
- Built from commit: `5209291e`
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
- Phase 1 — Auth & Session
- Windows CMake Build Config
- local_cache_service.dart
- App Launcher Icon (hdpi)
- App Launcher Icon (mdpi)
- App Launcher Icon (xhdpi)
- App Launcher Icon (xxhdpi)
- App Launcher Icon (xxxhdpi)
- Flutter Framework Concept
- Misc Constant
- api_exception.dart
- user_summary.dart
- admin_field_spec.dart
- Phase 4 — Leave Requests (owner lifecycle)
- policies_admin_controller.dart
- Phase 0 — Environment & Scaffolding
- AuthController
- splash_view.dart
- dashboard_binding.dart
- List
- users_repository.dart
- AdminCrudController
- initial_binding.dart
- pubspec.yaml — Package Manifest
- dashboard_controller.dart
- public_holidays_admin_controller.dart
- package:dio/dio.dart
- hr_leave_management

## God Nodes (most connected - your core abstractions)
1. `Win32Window` - 19 edges
2. `HR Leave Management — Flutter Client — Implementation Plan` - 18 edges
3. `MessageHandler` - 12 edges
4. `HR Leave Management — Flutter Client — SPEC` - 11 edges
5. `HR Leave Management — Flutter Client — Task Checklist` - 11 edges
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
- `PoliciesAdminController` --inherits--> `AdminCrudController`  [EXTRACTED]
  lib/features/admin/controllers/policies_admin_controller.dart → lib/features/admin/controllers/admin_crud_controller.dart

## Import Cycles
- None detected.

## Communities (84 total, 9 thin omitted)

### Community 0 - "App Architecture & Design Rationale"
Cohesion: 0.18
Nodes (14): Point, Size, wchar_t, Scale(), Create, Destroy, UpdateTheme, Win32Window::Win32Window() (+6 more)

### Community 1 - "Windows Runner: Flutter/Win32 Embedding"
Cohesion: 0.12
Nodes (16): FlutterViewController, unique_ptr, DartProject, HWND, LPARAM, LRESULT, UINT, WPARAM (+8 more)

### Community 2 - "GetX Routes, Pages & Middleware Registry"
Cohesion: 0.05
Nodes (41): app_routes.dart, auth_middleware.dart, ../../features/admin/bindings/leave_balances_admin_binding.dart, ../../features/admin/bindings/leave_types_admin_binding.dart, ../../features/admin/bindings/policies_admin_binding.dart, ../../features/admin/bindings/public_holidays_admin_binding.dart, ../../features/admin/bindings/teams_admin_binding.dart, ../../features/admin/bindings/users_admin_binding.dart (+33 more)

### Community 3 - "Route Names & Token Storage"
Cohesion: 0.04
Nodes (44): ../controllers/public_holidays_admin_controller.dart, ../../../data/models/public_holiday_model.dart, FlutterSecureStorage, adminLeaveBalances, adminLeaveTypes, adminPolicies, adminPublicHolidays, adminTeams (+36 more)

### Community 4 - "AuthController & DI Bindings"
Cohesion: 0.09
Nodes (21): _authRepository, bootstrap, currentUser, errorMessage, forceLogout, isApprover, _isHandlingUnauthorized, isLoading (+13 more)

### Community 5 - "Dio Client Auth Test Suite"
Cohesion: 0.04
Nodes (40): ../constants/env.dart, dart:typed_data, DioException, HttpClientAdapter, dio, DioClient, onUnauthorized, _secureStorageService (+32 more)

### Community 6 - "Leave Requests Controller"
Cohesion: 0.04
Nodes (45): create, createItem, delete, deleteItem, edit, errorMessage, fetchItems, fetchPage (+37 more)

### Community 7 - "Leave Recommendation Model & App Shell"
Cohesion: 0.06
Nodes (31): ../controllers/approvals_controller.dart, ../../../data/models/leave_plan_request_model.dart, ../../../data/models/leave_request_model.dart, ApprovalsBinding, dependencies, ApprovalsController, approveLeavePlanRequest, approveLeaveRequest (+23 more)

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
Cohesion: 0.09
Nodes (26): AuthController, DashboardController, _availableDaysSummary, balance, balances, build, DashboardView, data (+18 more)

### Community 12 - "Leave Request Model"
Cohesion: 0.09
Nodes (22): leave_balance_model.dart, amount, approvalAt, approver, approverId, description, endDate, fromJson (+14 more)

### Community 13 - "Leave Request Form View"
Cohesion: 0.06
Nodes (31): Bindings, bool get, ../controllers/dashboard_controller.dart, ../controllers/leave_requests_controller.dart, GetxController, InitialBinding, LeaveRequestModel, TeamsAdminBinding (+23 more)

### Community 14 - "Leave Plan Request Form View"
Cohesion: 0.10
Nodes (20): LeavePlanRequestModel, _addPlannedDate, build, controller, createState, _descriptionController, dispose, _formatDate (+12 more)

### Community 15 - "Balances/Recommends/Teams Repositories"
Cohesion: 0.33
Nodes (5): Dio, _dio, fetchRecommendations, RecommendsRepository, ../models/leave_recommendation_model.dart

### Community 16 - "Leave Plan Request Detail View"
Cohesion: 0.12
Nodes (15): ../controllers/leave_plan_requests_controller.dart, leave_plan_request_form_view.dart, dependencies, LeavePlanRequestsController, build, _buildDetailRow, _buildTimelineRow, _confirmDelete (+7 more)

### Community 17 - "Recommendations Controller & View"
Cohesion: 0.18
Nodes (9): Architecture, Backend contract quirks that shape the code (verified against backend source, not just docs — see `tasks/plan.md` "Verified Backend Ground Truth"), Boundaries, Commands, Design tokens, graphify, Running the backend for manual verification, Testing strategy (+1 more)

### Community 18 - "Leave Plan Requests List View"
Cohesion: 0.15
Nodes (13): leave_plan_request_detail_view.dart, build, _buildPlanCard, controller, createState, dispose, _formatDate, _getStatusColor (+5 more)

### Community 19 - "Leave Requests List View"
Cohesion: 0.20
Nodes (9): admin_crud_controller.dart, ../../../data/repositories/leave_types_repository.dart, createItem, deleteItem, fetchPage, idOf, matchesSearch, repository (+1 more)

### Community 20 - "Leave Request Detail View"
Cohesion: 0.14
Nodes (14): leave_request_detail_view.dart, build, _buildRequestCard, controller, createState, dispose, _formatDate, _getStatusColor (+6 more)

### Community 21 - "Leave Requests Repository"
Cohesion: 0.17
Nodes (11): approveLeaveRequest, createLeaveRequest, deleteLeaveRequest, _dio, fetchLeaveRequest, fetchLeaveRequests, LeaveRequestsRepository, rejectLeaveRequest (+3 more)

### Community 22 - "Admin & Approvals Placeholder Views"
Cohesion: 0.50
Nodes (3): build, PublicHolidaysView, ../../../widgets/placeholder_screen.dart

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
Cohesion: 0.17
Nodes (11): HR Leave Management — Flutter Client — Task Checklist, Phase 0 — Environment & Scaffolding, Phase 1 — Auth & Session, Phase 2 — App Shell, Role-Adaptive Navigation, Dashboard, Phase 3 — Leave Balances, Phase 4 — Leave Requests, Phase 5 — Leave Plan Requests, Phase 6 — AI Recommendation Flow (headline feature) (+3 more)

### Community 27 - "Leave Type Model"
Cohesion: 0.12
Nodes (16): LeaveTypesRepository, createItem, deleteItem, fetchPage, idOf, leaveTypeOptions, leaveTypesRepository, _loadLeaveTypeOptions (+8 more)

### Community 28 - "Auth Views (Login/Forgot/Reset)"
Cohesion: 0.14
Nodes (14): leave_request_form_view.dart, build, _buildDetailRow, _buildTimelineRow, _confirmDelete, controller, createState, _formatDate (+6 more)

### Community 29 - "GetX Feature Bindings"
Cohesion: 0.05
Nodes (33): app_drawer.dart, count, data, PaginatedResult, description, email, fromJson, fullName (+25 more)

### Community 30 - "User Model"
Cohesion: 0.18
Nodes (10): email, fromJson, fullName, id, isActive, isSuperuser, name, team (+2 more)

### Community 31 - "Leave View State Classes"
Cohesion: 0.23
Nodes (12): LeavePlanRequestDetailView, _LeavePlanRequestDetailViewState, LeavePlanRequestFormView, _LeavePlanRequestFormViewState, LeaveRequestFormView, _LeaveRequestFormViewState, AdminCrudView, _AdminCrudViewState (+4 more)

### Community 32 - "Dashboard Controller"
Cohesion: 0.21
Nodes (12): RECT, OnCreate, HWND, Win32Window, child_content_, GetClientArea, OnCreate, quit_on_close_ (+4 more)

### Community 33 - "App Drawer Widget"
Cohesion: 0.29
Nodes (7): ../../../app/routes/app_routes.dart, ../controllers/auth_controller.dart, FormState, build, build, build, package:flutter/material.dart

### Community 34 - "Auth Repository"
Cohesion: 0.22
Nodes (8): AuthRepository, _dio, fetchMe, login, recoverPassword, resetPassword, testToken, ../models/user_model.dart

### Community 35 - "admin_form_dialog.dart"
Cohesion: 0.22
Nodes (9): AdminCrudController, ../controllers/leave_balances_admin_controller.dart, LeaveBalanceModel, dependencies, LeaveBalancesAdminBinding, LeaveBalancesAdminController, AdminLeaveBalancesView, build (+1 more)

### Community 36 - "Dio Client"
Cohesion: 0.17
Nodes (11): createItem, deleteItem, fetchPage, idOf, _loadTeamOptions, matchesSearch, onInit, repository (+3 more)

### Community 37 - "leave_types_view.dart"
Cohesion: 0.21
Nodes (10): ../controllers/teams_admin_controller.dart, ../../../data/models/team_model.dart, TeamModel, dependencies, TeamsAdminController, AdminTeamsView, build, _toFormValues (+2 more)

### Community 38 - "API Exception Handling"
Cohesion: 0.22
Nodes (8): ../../../core/errors/api_exception.dart, createPolicy, deletePolicy, _dio, fetchPolicies, PoliciesRepository, updatePolicy, ../models/policy_model.dart

### Community 39 - "Profile View"
Cohesion: 0.29
Nodes (6): ../../auth/controllers/auth_controller.dart, build, _InfoRow, label, value, ../../../widgets/app_shell_scaffold.dart

### Community 40 - "leave_request_detail_view.dart"
Cohesion: 0.36
Nodes (10): HWND, LPARAM, LRESULT, UINT, WPARAM, EnableFullDpiSupportIfAvailable(), GetHandle, GetThisFromHandle (+2 more)

### Community 41 - "Team Model"
Cohesion: 0.05
Nodes (42): Context, Critical Files, HR Leave Management — Flutter Client — Implementation Plan, Overall Verification, Phase 0 — Environment & Scaffolding, Phase 1 — Auth & Session, Phase 2 — App Shell, Role-Adaptive Navigation, Dashboard, Phase 3 — Leave Balances (+34 more)

### Community 42 - "Splash View"
Cohesion: 0.33
Nodes (5): _dartDefineApiBaseUrl, _defaultApiBaseUrl, Env, package:flutter_dotenv/flutter_dotenv.dart, static const String

### Community 43 - "leave_recommendation_model.dart"
Cohesion: 0.15
Nodes (12): DateTime?, bridgeHoliday, data, fromJson, leaveDate, LeaveRecommendationItem, LeaveRecommendationsModel, leaveTypeId (+4 more)

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

### Community 48 - "leave_types_admin_controller.dart"
Cohesion: 0.20
Nodes (10): ../controllers/users_admin_controller.dart, ../../../data/models/user_model.dart, UserModel, dependencies, UsersAdminBinding, UsersAdminController, AdminUsersView, build (+2 more)

### Community 49 - "leave_balance_model.dart"
Cohesion: 0.12
Nodes (15): availableBalance, balance, code, fromJson, id, leaveType, LeaveTypeSummary, name (+7 more)

### Community 51 - "Admin Teams View"
Cohesion: 0.22
Nodes (8): createBalance, deleteBalance, _dio, fetchBalancesPage, fetchMyBalances, LeaveBalancesRepository, updateBalance, ../models/leave_balance_model.dart

### Community 52 - "../../app/theme/app_theme.dart"
Cohesion: 0.22
Nodes (8): app/bindings/initial_binding.dart, app/routes/app_pages.dart, ../../../app/theme/app_theme.dart, build, HrLeaveManagementApp, init, load, main

### Community 53 - "Phase 1 — Auth & Session"
Cohesion: 0.40
Nodes (5): build, createState, initState, SplashView, _SplashViewState

### Community 54 - "Windows CMake Build Config"
Cohesion: 1.00
Nodes (3): windows/CMakeLists.txt — Windows Project Config, windows/flutter/CMakeLists.txt — Flutter Build Rules, windows/runner/CMakeLists.txt — Runner Executable Target

### Community 55 - "local_cache_service.dart"
Cohesion: 0.22
Nodes (8): IconData, AppDrawer, build, icon, _initials, label, _NavTile, route

### Community 67 - "api_exception.dart"
Cohesion: 0.20
Nodes (9): Exception, int?, ApiException, _extractMessage, fromDioException, message, _networkErrorMessage, statusCode (+1 more)

### Community 69 - "user_summary.dart"
Cohesion: 0.29
Nodes (6): email, fromJson, fullName, id, toJson, UserSummary

### Community 70 - "admin_field_spec.dart"
Cohesion: 0.05
Nodes (43): admin_field_spec.dart, admin_form_dialog.dart, ../../features/admin/controllers/admin_crud_controller.dart, GetStorage, _box, LocalCacheService, remove, write (+35 more)

### Community 71 - "Phase 4 — Leave Requests (owner lifecycle)"
Cohesion: 0.09
Nodes (22): ../controllers/policies_admin_controller.dart, ../../../data/models/policy_model.dart, double?, code, description, fromJson, id, isActive (+14 more)

### Community 72 - "policies_admin_controller.dart"
Cohesion: 0.22
Nodes (8): ../../data/repositories/policies_repository.dart, createItem, deleteItem, fetchPage, idOf, matchesSearch, repository, updateItem

### Community 73 - "Phase 0 — Environment & Scaffolding"
Cohesion: 0.15
Nodes (12): ../../../data/repositories/users_repository.dart, createItem, deleteItem, fetchPage, idOf, _loadUserOptions, matchesSearch, onInit (+4 more)

### Community 74 - "AuthController"
Cohesion: 0.53
Nodes (6): GetView, AuthController, ForgotPasswordView, LoginView, ResetPasswordView, ProfileView

### Community 75 - "splash_view.dart"
Cohesion: 0.17
Nodes (11): 10. Boundaries, 1. Objective, 2. Tech Stack (per course guideline), 3. Commands, 4. Project Structure, 5. Code Style, 6. Testing Strategy, 7. Known Gaps vs. Guideline (decided, documented — not open questions) (+3 more)

### Community 77 - "dashboard_binding.dart"
Cohesion: 0.25
Nodes (7): createPublicHoliday, deletePublicHoliday, _dio, fetchPublicHolidays, PublicHolidaysRepository, updatePublicHoliday, ../models/public_holiday_model.dart

### Community 78 - "List"
Cohesion: 0.22
Nodes (8): createTeam, deleteTeam, _dio, fetchTeams, fetchTeamsPage, TeamsRepository, updateTeam, ../models/team_model.dart

### Community 79 - "users_repository.dart"
Cohesion: 0.25
Nodes (7): createUser, deleteUser, _dio, fetchUsersPage, updateUser, UsersRepository, ../models/paginated_result.dart

### Community 80 - "AdminCrudController"
Cohesion: 0.09
Nodes (21): ../controllers/leave_types_admin_controller.dart, ../../../data/models/leave_type_model.dart, code, description, entitlement, fromJson, id, isActive (+13 more)

### Community 83 - "initial_binding.dart"
Cohesion: 0.20
Nodes (9): ../../core/network/dio_client.dart, ../../core/storage/local_cache_service.dart, ../../core/storage/secure_storage_service.dart, ../../data/repositories/auth_repository.dart, ../../data/repositories/leave_plan_requests_repository.dart, ../../data/repositories/leave_requests_repository.dart, ../../data/repositories/recommends_repository.dart, ../../data/repositories/teams_repository.dart (+1 more)

### Community 85 - "dashboard_controller.dart"
Cohesion: 0.22
Nodes (8): ../../../data/models/leave_balance_model.dart, ../../../data/repositories/leave_balances_repository.dart, balances, balancesError, fetchBalances, isLoadingBalances, _leaveBalancesRepository, onInit

### Community 87 - "public_holidays_admin_controller.dart"
Cohesion: 0.20
Nodes (9): ../../../data/models/paginated_result.dart, ../../data/repositories/public_holidays_repository.dart, createItem, deleteItem, fetchPage, idOf, matchesSearch, repository (+1 more)

### Community 88 - "package:dio/dio.dart"
Cohesion: 0.29
Nodes (6): package:dio/dio.dart, package:hr_leave_management/core/errors/api_exception.dart, _dioExceptionWith, main, requestOptions, response

### Community 90 - "hr_leave_management"
Cohesion: 0.22
Nodes (8): Choosing a backend URL (`.env`), Common commands, First-time setup, Getting started with Flutter, HR Leave Management — Flutter Client, Prerequisites, Project docs, Running the backend locally (optional)

## Knowledge Gaps
- **723 isolated node(s):** `1. Objective`, `2. Tech Stack (per course guideline)`, `3. Commands`, `4. Project Structure`, `5. Code Style` (+718 more)
  These have ≤1 connection - possible missing edges or undocumented components.
- **9 thin communities (<3 nodes) omitted from report** — run `graphify query` to explore isolated nodes.

## Suggested Questions
_Questions this graph is uniquely positioned to answer:_

- **Why does `LeaveRequestModel` connect `Leave Request Form View` to `Leave Request Model`, `Leave Requests Controller`?**
  _High betweenness centrality (0.012) - this node is a cross-community bridge._
- **What connects `1. Objective`, `2. Tech Stack (per course guideline)`, `3. Commands` to the rest of the system?**
  _723 weakly-connected nodes found - possible documentation gaps or missing edges._
- **Should `Windows Runner: Flutter/Win32 Embedding` be split into smaller, more focused modules?**
  _Cohesion score 0.11695906432748537 - nodes in this community are weakly interconnected._
- **Should `GetX Routes, Pages & Middleware Registry` be split into smaller, more focused modules?**
  _Cohesion score 0.048625792811839326 - nodes in this community are weakly interconnected._
- **Should `Route Names & Token Storage` be split into smaller, more focused modules?**
  _Cohesion score 0.04251700680272109 - nodes in this community are weakly interconnected._
- **Should `AuthController & DI Bindings` be split into smaller, more focused modules?**
  _Cohesion score 0.09090909090909091 - nodes in this community are weakly interconnected._
- **Should `Dio Client Auth Test Suite` be split into smaller, more focused modules?**
  _Cohesion score 0.043478260869565216 - nodes in this community are weakly interconnected._