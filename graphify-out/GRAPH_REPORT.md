# Graph Report - hr-leave-management-flutter  (2026-07-13)

## Corpus Check
- 114 files · ~36,433 words
- Verdict: corpus is large enough that graph structure adds value.

## Summary
- 1244 nodes · 1655 edges · 94 communities (84 shown, 10 thin omitted)
- Extraction: 99% EXTRACTED · 1% INFERRED · 0% AMBIGUOUS · INFERRED: 14 edges (avg confidence: 0.8)
- Token cost: 0 input · 0 output

## Graph Freshness
- Built from commit: `42a3c2f4`
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
- env.dart
- AuthController
- splash_view.dart
- placeholder_screen.dart
- dashboard_binding.dart
- List
- users_repository.dart
- AdminCrudController
- Phase 10 — Post-Launch Enhancements (after Checkpoint 9)
- Phase 8 — Admin/Superuser Master Data CRUD
- Phase 11 — Backend API Enhancements (proposed, tracked here; implemented in `../hr-leave-management`)
- pubspec.yaml — Package Manifest
- Phase 1 — Auth & Session
- LeavePlanRequestsController
- Phase 4 — Leave Requests (owner lifecycle)
- Phase 5 — Leave Plan Requests (multi-date lifecycle)
- Phase 6 — AI Recommendation Flow (headline feature)
- hr_leave_management
- Phase 0 — Environment & Scaffolding
- Phase 2 — App Shell, Role-Adaptive Navigation, Dashboard
- Phase 9 — Hardening & Report-Readiness

## God Nodes (most connected - your core abstractions)
1. `HR Leave Management — Flutter Client — Implementation Plan` - 20 edges
2. `Win32Window` - 19 edges
3. `HR Leave Management — Flutter Client — Task Checklist` - 13 edges
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
- `wWinMain()` --calls--> `CreateAndAttachConsole()`  [INFERRED]
  windows/runner/main.cpp → windows/runner/utils.cpp
- `Win32Window::Win32Window()` --calls--> `Destroy`  [INFERRED]
  windows/runner/win32_window.cpp → windows/runner/win32_window.h
- `PoliciesAdminController` --inherits--> `AdminCrudController`  [EXTRACTED]
  lib/features/admin/controllers/policies_admin_controller.dart → lib/features/admin/controllers/admin_crud_controller.dart
- `PublicHolidaysAdminController` --inherits--> `AdminCrudController`  [EXTRACTED]
  lib/features/admin/controllers/public_holidays_admin_controller.dart → lib/features/admin/controllers/admin_crud_controller.dart

## Import Cycles
- None detected.

## Communities (94 total, 10 thin omitted)

### Community 0 - "App Architecture & Design Rationale"
Cohesion: 0.25
Nodes (7): Bindings, ../controllers/dashboard_controller.dart, InitialBinding, LeaveBalancesAdminBinding, DashboardBinding, dependencies, LeavePlanRequestsBinding

### Community 1 - "Windows Runner: Flutter/Win32 Embedding"
Cohesion: 0.06
Nodes (54): FlutterViewController, PluginRegistry, Point, RECT, Size, unique_ptr, RegisterPlugins(), DartProject (+46 more)

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
Nodes (33): dart:typed_data, DioException, HttpClientAdapter, package:flutter_test/flutter_test.dart, package:hr_leave_management/core/network/dio_client.dart, package:hr_leave_management/core/storage/secure_storage_service.dart, package:hr_leave_management/core/storage/token_storage.dart, package:hr_leave_management/data/models/leave_balance_model.dart (+25 more)

### Community 6 - "Leave Requests Controller"
Cohesion: 0.04
Nodes (45): create, createItem, delete, deleteItem, edit, errorMessage, fetchItems, fetchPage (+37 more)

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
Nodes (27): LeaveBalanceModel, ApprovalsView, _availableDaysSummary, balance, balances, build, DashboardView, data (+19 more)

### Community 12 - "Leave Request Model"
Cohesion: 0.09
Nodes (22): leave_balance_model.dart, amount, approvalAt, approver, approverId, description, endDate, fromJson (+14 more)

### Community 13 - "Leave Request Form View"
Cohesion: 0.10
Nodes (20): bool get, LeaveRequestModel, build, controller, createState, _descriptionController, dispose, _endDate (+12 more)

### Community 14 - "Leave Plan Request Form View"
Cohesion: 0.09
Nodes (22): LeavePlanRequestModel, _addPlannedDate, build, controller, createState, _descriptionController, dispose, _formatDate (+14 more)

### Community 15 - "Balances/Recommends/Teams Repositories"
Cohesion: 0.33
Nodes (5): Dio, _dio, fetchRecommendations, RecommendsRepository, ../models/leave_recommendation_model.dart

### Community 16 - "Leave Plan Request Detail View"
Cohesion: 0.14
Nodes (14): leave_plan_request_form_view.dart, build, _buildDetailRow, _buildTimelineRow, _confirmDelete, controller, createState, _formatDate (+6 more)

### Community 17 - "Recommendations Controller & View"
Cohesion: 0.18
Nodes (9): Architecture, Backend contract quirks that shape the code (verified against backend source, not just docs — see `tasks/plan.md` "Verified Backend Ground Truth"), Boundaries, Commands, Design tokens, graphify, Running the backend for manual verification, Testing strategy (+1 more)

### Community 18 - "Leave Plan Requests List View"
Cohesion: 0.15
Nodes (13): leave_plan_request_detail_view.dart, build, _buildPlanCard, controller, createState, dispose, _formatDate, _getStatusColor (+5 more)

### Community 19 - "Leave Requests List View"
Cohesion: 0.10
Nodes (19): _boolValues, build, _buildField, _buildRelationField, createState, dispose, fields, _findOption (+11 more)

### Community 20 - "Leave Request Detail View"
Cohesion: 0.15
Nodes (12): leave_request_detail_view.dart, build, _buildRequestCard, controller, createState, dispose, _formatDate, _getStatusColor (+4 more)

### Community 21 - "Leave Requests Repository"
Cohesion: 0.17
Nodes (11): approveLeaveRequest, createLeaveRequest, deleteLeaveRequest, _dio, fetchLeaveRequest, fetchLeaveRequests, LeaveRequestsRepository, rejectLeaveRequest (+3 more)

### Community 22 - "Admin & Approvals Placeholder Views"
Cohesion: 0.15
Nodes (12): DateTime, bridgeHoliday, data, fromJson, leaveDate, LeaveRecommendationItem, LeaveRecommendationsModel, leaveTypeId (+4 more)

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
Cohesion: 0.14
Nodes (13): HR Leave Management — Flutter Client — Task Checklist, Phase 0 — Environment & Scaffolding, Phase 10 — Post-Launch Enhancements, Phase 11 — Backend API Enhancements (proposed, not yet implemented — tracked for `../hr-leave-management`), Phase 1 — Auth & Session, Phase 2 — App Shell, Role-Adaptive Navigation, Dashboard, Phase 3 — Leave Balances, Phase 4 — Leave Requests (+5 more)

### Community 27 - "Leave Type Model"
Cohesion: 0.05
Nodes (42): admin_crud_controller.dart, ../../../data/models/paginated_result.dart, ../../../data/repositories/leave_types_repository.dart, ../../data/repositories/policies_repository.dart, LeaveTypesRepository, PublicHolidaysRepository, createItem, deleteItem (+34 more)

### Community 28 - "Auth Views (Login/Forgot/Reset)"
Cohesion: 0.14
Nodes (14): leave_request_form_view.dart, build, _buildDetailRow, _buildTimelineRow, _confirmDelete, controller, createState, _formatDate (+6 more)

### Community 29 - "GetX Feature Bindings"
Cohesion: 0.05
Nodes (33): app_drawer.dart, count, data, PaginatedResult, description, email, fromJson, fullName (+25 more)

### Community 30 - "User Model"
Cohesion: 0.22
Nodes (9): ../controllers/teams_admin_controller.dart, ../../../data/models/team_model.dart, TeamModel, dependencies, TeamsAdminBinding, TeamsAdminController, AdminTeamsView, build (+1 more)

### Community 31 - "Leave View State Classes"
Cohesion: 0.27
Nodes (10): SplashView, _SplashViewState, LeaveRequestsView, _LeaveRequestsViewState, AdminCrudView, _AdminCrudViewState, AdminFormDialog, _AdminFormDialogState (+2 more)

### Community 32 - "Dashboard Controller"
Cohesion: 0.50
Nodes (3): ../controllers/leave_plan_requests_controller.dart, dependencies, LeavePlanRequestsController

### Community 33 - "App Drawer Widget"
Cohesion: 0.20
Nodes (10): ../../../app/routes/app_routes.dart, ../controllers/auth_controller.dart, FormState, build, build, build, build, createState (+2 more)

### Community 34 - "Auth Repository"
Cohesion: 0.25
Nodes (7): AuthRepository, _dio, fetchMe, login, recoverPassword, resetPassword, testToken

### Community 35 - "admin_form_dialog.dart"
Cohesion: 0.11
Nodes (17): admin_field_spec.dart, admin_form_dialog.dart, ../../features/admin/controllers/admin_crud_controller.dart, build, _confirmDelete, controller, createState, dispose (+9 more)

### Community 36 - "Dio Client"
Cohesion: 0.15
Nodes (12): ../../../data/repositories/users_repository.dart, createItem, deleteItem, fetchPage, idOf, _loadTeamOptions, matchesSearch, onInit (+4 more)

### Community 37 - "leave_types_view.dart"
Cohesion: 0.29
Nodes (6): package:dio/dio.dart, package:hr_leave_management/core/errors/api_exception.dart, _dioExceptionWith, main, requestOptions, response

### Community 38 - "API Exception Handling"
Cohesion: 0.22
Nodes (8): ../../../core/errors/api_exception.dart, createPolicy, deletePolicy, _dio, fetchPolicies, PoliciesRepository, updatePolicy, ../models/policy_model.dart

### Community 39 - "Profile View"
Cohesion: 0.29
Nodes (6): ../../auth/controllers/auth_controller.dart, build, _InfoRow, label, value, ../../../widgets/app_shell_scaffold.dart

### Community 40 - "leave_request_detail_view.dart"
Cohesion: 0.18
Nodes (10): email, fromJson, fullName, id, isActive, isSuperuser, name, team (+2 more)

### Community 41 - "Team Model"
Cohesion: 0.15
Nodes (12): Context, Critical Files, HR Leave Management — Flutter Client — Implementation Plan, Overall Verification, Phase 3 — Leave Balances, Phase 7 — Approvals Queue (team-owner role), Reference Patterns from the Existing React Frontend (architectural parity, not literal translation), Sequencing (+4 more)

### Community 42 - "Splash View"
Cohesion: 0.19
Nodes (11): AdminCrudController, ../controllers/leave_balances_admin_controller.dart, ../../../data/models/leave_balance_model.dart, LeaveBalanceModel, dependencies, LeaveBalancesAdminController, AdminLeaveBalancesView, build (+3 more)

### Community 43 - "leave_recommendation_model.dart"
Cohesion: 0.05
Nodes (40): ../controllers/public_holidays_admin_controller.dart, ../controllers/public_holidays_controller.dart, ../../../data/models/public_holiday_model.dart, ../../../data/repositories/public_holidays_repository.dart, date, description, fromJson, id (+32 more)

### Community 44 - "Android Plugin Registrant"
Cohesion: 0.60
Nodes (3): GeneratedPluginRegistrant, FlutterEngine, Keep

### Community 45 - "Gradle Wrapper Script"
Cohesion: 0.60
Nodes (3): gradlew script, die(), warn()

### Community 46 - "Placeholder Screen Widget"
Cohesion: 0.53
Nodes (6): GetView, AuthController, ForgotPasswordView, LoginView, ResetPasswordView, ProfileView

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
Cohesion: 0.22
Nodes (8): app/bindings/initial_binding.dart, app/routes/app_pages.dart, ../../../app/theme/app_theme.dart, build, HrLeaveManagementApp, init, load, main

### Community 53 - "admin_users_view.dart"
Cohesion: 0.20
Nodes (10): ../controllers/users_admin_controller.dart, ../../../data/models/user_model.dart, UserModel, dependencies, UsersAdminBinding, UsersAdminController, AdminUsersView, build (+2 more)

### Community 54 - "Windows CMake Build Config"
Cohesion: 1.00
Nodes (3): windows/CMakeLists.txt — Windows Project Config, windows/flutter/CMakeLists.txt — Flutter Build Rules, windows/runner/CMakeLists.txt — Runner Executable Target

### Community 55 - "local_cache_service.dart"
Cohesion: 0.22
Nodes (8): IconData, AppDrawer, build, icon, _initials, label, _NavTile, route

### Community 64 - "initial_binding.dart"
Cohesion: 0.20
Nodes (9): ../../core/network/dio_client.dart, ../../core/storage/local_cache_service.dart, ../../core/storage/secure_storage_service.dart, ../../data/repositories/auth_repository.dart, ../../../data/repositories/leave_balances_repository.dart, ../../../data/repositories/leave_plan_requests_repository.dart, ../../../data/repositories/leave_requests_repository.dart, ../../data/repositories/recommends_repository.dart (+1 more)

### Community 66 - "user_model.dart"
Cohesion: 0.20
Nodes (9): code, description, entitlement, fromJson, id, isActive, isAllowPlan, name (+1 more)

### Community 67 - "api_exception.dart"
Cohesion: 0.20
Nodes (9): Exception, int?, ApiException, _extractMessage, fromDioException, message, _networkErrorMessage, statusCode (+1 more)

### Community 68 - "public_holidays_admin_controller.dart"
Cohesion: 0.29
Nodes (7): GetStorage, _box, LocalCacheService, remove, write, package:get_storage/get_storage.dart, T

### Community 69 - "user_summary.dart"
Cohesion: 0.29
Nodes (6): email, fromJson, fullName, id, toJson, UserSummary

### Community 71 - "Phase 4 — Leave Requests (owner lifecycle)"
Cohesion: 0.09
Nodes (22): ../controllers/policies_admin_controller.dart, ../../../data/models/policy_model.dart, double?, code, description, fromJson, id, isActive (+14 more)

### Community 72 - "policies_admin_controller.dart"
Cohesion: 0.29
Nodes (6): ../controllers/leave_requests_controller.dart, GetxController, DashboardController, dependencies, LeaveRequestsBinding, LeaveRequestsController

### Community 73 - "env.dart"
Cohesion: 0.33
Nodes (5): _dartDefineApiBaseUrl, _defaultApiBaseUrl, Env, package:flutter_dotenv/flutter_dotenv.dart, static const String

### Community 74 - "AuthController"
Cohesion: 0.15
Nodes (12): ../../data/repositories/teams_repository.dart, createItem, deleteItem, fetchPage, idOf, _loadUserOptions, matchesSearch, onInit (+4 more)

### Community 75 - "splash_view.dart"
Cohesion: 0.17
Nodes (11): 10. Boundaries, 1. Objective, 2. Tech Stack (per course guideline), 3. Commands, 4. Project Structure, 5. Code Style, 6. Testing Strategy, 7. Known Gaps vs. Guideline (decided, documented — not open questions) (+3 more)

### Community 76 - "placeholder_screen.dart"
Cohesion: 0.40
Nodes (4): app_shell_scaffold.dart, build, PlaceholderScreen, title

### Community 77 - "dashboard_binding.dart"
Cohesion: 0.25
Nodes (7): createPublicHoliday, deletePublicHoliday, _dio, fetchPublicHolidays, updatePublicHoliday, ../models/paginated_result.dart, ../models/public_holiday_model.dart

### Community 78 - "List"
Cohesion: 0.22
Nodes (8): createTeam, deleteTeam, _dio, fetchTeams, fetchTeamsPage, TeamsRepository, updateTeam, ../models/team_model.dart

### Community 79 - "users_repository.dart"
Cohesion: 0.25
Nodes (7): createUser, deleteUser, _dio, fetchUsersPage, updateUser, UsersRepository, ../models/user_model.dart

### Community 80 - "AdminCrudController"
Cohesion: 0.16
Nodes (12): ../controllers/leave_types_admin_controller.dart, ../../../data/models/leave_type_model.dart, LeaveTypeModel, dependencies, LeaveTypesAdminBinding, AdminCrudController, LeaveTypesAdminController, build (+4 more)

### Community 81 - "Phase 10 — Post-Launch Enhancements (after Checkpoint 9)"
Cohesion: 0.40
Nodes (5): Phase 10 — Post-Launch Enhancements (after Checkpoint 9), Task 10.1 — Employee Public Holidays month-calendar view, Task 10.2 — Remove redundant Profile tile from Dashboard Quick Actions, Task 10.3 — Remove "Recent Activity" placeholder stat card, Task 10.4 — Wire "Pending Requests" dashboard stat to real data

### Community 82 - "Phase 8 — Admin/Superuser Master Data CRUD"
Cohesion: 0.40
Nodes (5): Phase 8 — Admin/Superuser Master Data CRUD, Task 8.1 — Generic CRUD scaffold, proven on Leave Types, Task 8.2 — Apply pattern: Public Holidays, Policies, Task 8.3 — Apply pattern: Teams, Users (relational pickers), Task 8.4 — Apply pattern: Leave Balances (admin) + fix missing Public Holidays nav entry

### Community 83 - "Phase 11 — Backend API Enhancements (proposed, tracked here; implemented in `../hr-leave-management`)"
Cohesion: 0.50
Nodes (4): Phase 11 — Backend API Enhancements (proposed, tracked here; implemented in `../hr-leave-management`), Task 11.1 — Query-param filtering on `GET /leave-requests/` and `GET /leave-plan-requests/`, Task 11.2 — New `GET /approvals/pending-count`, Task 11.3 — New `GET /schedule/?year=<int>&month=<int 1-12>`

### Community 85 - "Phase 1 — Auth & Session"
Cohesion: 0.50
Nodes (4): Phase 1 — Auth & Session, Task 1.1 — Login + token storage + current-user fetch + minimal authenticated screen, Task 1.2 — Session bootstrap + global 401/403 handling, Task 1.3 — Forgot password + reset password

### Community 86 - "LeavePlanRequestsController"
Cohesion: 0.10
Nodes (20): AuthController, LeaveBalancesRepository, LeavePlanRequestsRepository, LeaveRequestsRepository, _authController, balances, balancesError, _fetchAllLeavePlanRequests (+12 more)

### Community 87 - "Phase 4 — Leave Requests (owner lifecycle)"
Cohesion: 0.50
Nodes (4): Phase 4 — Leave Requests (owner lifecycle), Task 4.1 — List + detail (read-only), Task 4.2 — Create draft, edit, delete (draft-only), Task 4.3 — Submit action + balance-debit visibility

### Community 88 - "Phase 5 — Leave Plan Requests (multi-date lifecycle)"
Cohesion: 0.50
Nodes (4): Phase 5 — Leave Plan Requests (multi-date lifecycle), Task 5.1 — List + detail (detail = list of dates), Task 5.2 — Create/edit (multi-date picker, duplicate guard) + delete, Task 5.3 — Submit action

### Community 89 - "Phase 6 — AI Recommendation Flow (headline feature)"
Cohesion: 0.50
Nodes (4): Phase 6 — AI Recommendation Flow (headline feature), Task 6.1 — Fetch & display recommendations, Task 6.2 — Selection UI → build plan-request draft, Task 6.3 — One-tap create & submit, success state

### Community 90 - "hr_leave_management"
Cohesion: 0.22
Nodes (8): Choosing a backend URL (`.env`), Common commands, First-time setup, Getting started with Flutter, HR Leave Management — Flutter Client, Prerequisites, Project docs, Running the backend locally (optional)

### Community 91 - "Phase 0 — Environment & Scaffolding"
Cohesion: 0.67
Nodes (3): Phase 0 — Environment & Scaffolding, Task 0.1 — Project scaffold, dependencies, folder skeleton, lint, Task 0.2 — Core network/storage infra + connectivity smoke test

### Community 92 - "Phase 2 — App Shell, Role-Adaptive Navigation, Dashboard"
Cohesion: 0.67
Nodes (3): Phase 2 — App Shell, Role-Adaptive Navigation, Dashboard, Task 2.1 — App shell + GetX routing + static role-based nav (superuser branch), Task 2.2 — Team-owner detection + Approvals nav entry

### Community 93 - "Phase 9 — Hardening & Report-Readiness"
Cohesion: 0.67
Nodes (3): Phase 9 — Hardening & Report-Readiness, Task 9.1 — Targeted unit tests (per SPEC §6, not broad coverage), Task 9.2 — Analyze-clean pass + empty/error/loading state audit + feature checklist walkthrough

## Knowledge Gaps
- **762 isolated node(s):** `Context`, `Verified Backend Ground Truth`, `Reference Patterns from the Existing React Frontend (architectural parity, not literal translation)`, `Standard Verification Environment (used by every task below)`, `Task 0.1 — Project scaffold, dependencies, folder skeleton, lint` (+757 more)
  These have ≤1 connection - possible missing edges or undocumented components.
- **10 thin communities (<3 nodes) omitted from report** — run `graphify query` to explore isolated nodes.

## Suggested Questions
_Questions this graph is uniquely positioned to answer:_

- **Why does `UserSummary` connect `user_summary.dart` to `Leave Plan Request Model`, `Leave Request Model`?**
  _High betweenness centrality (0.021) - this node is a cross-community bridge._
- **Why does `LeavePlanRequestModel` connect `Leave Plan Request Form View` to `Leave Plan Requests Controller`, `Leave Plan Request Model`?**
  _High betweenness centrality (0.020) - this node is a cross-community bridge._
- **Why does `SecureStorageService` connect `Route Names & Token Storage` to `AuthController & DI Bindings`?**
  _High betweenness centrality (0.016) - this node is a cross-community bridge._
- **What connects `Context`, `Verified Backend Ground Truth`, `Reference Patterns from the Existing React Frontend (architectural parity, not literal translation)` to the rest of the system?**
  _762 weakly-connected nodes found - possible documentation gaps or missing edges._
- **Should `Windows Runner: Flutter/Win32 Embedding` be split into smaller, more focused modules?**
  _Cohesion score 0.05683563748079877 - nodes in this community are weakly interconnected._
- **Should `GetX Routes, Pages & Middleware Registry` be split into smaller, more focused modules?**
  _Cohesion score 0.047474747474747475 - nodes in this community are weakly interconnected._
- **Should `Route Names & Token Storage` be split into smaller, more focused modules?**
  _Cohesion score 0.044444444444444446 - nodes in this community are weakly interconnected._