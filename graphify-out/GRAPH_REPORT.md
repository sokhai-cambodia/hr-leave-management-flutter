# Graph Report - hr-leave-management-flutter  (2026-07-14)

## Corpus Check
- 130 files · ~44,350 words
- Verdict: corpus is large enough that graph structure adds value.

## Summary
- 1437 nodes · 1928 edges · 112 communities (104 shown, 8 thin omitted)
- Extraction: 99% EXTRACTED · 1% INFERRED · 0% AMBIGUOUS · INFERRED: 14 edges (avg confidence: 0.8)
- Token cost: 0 input · 0 output

## Graph Freshness
- Built from commit: `f1175eb7`
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
- leaves_tab_view.dart
- AuthController
- splash_view.dart
- main_shell_binding.dart
- dashboard_binding.dart
- List
- users_repository.dart
- AdminCrudController
- Phase 10 — Post-Launch Enhancements (after Checkpoint 9)
- Phase 8 — Admin/Superuser Master Data CRUD
- Phase 11 — Backend API Enhancements (proposed, tracked here; implemented in `../hr-leave-management`)
- pubspec.yaml — Package Manifest
- Phase 1 — Auth & Session
- leave_types_admin_controller.dart
- Phase 4 — Leave Requests (owner lifecycle)
- Phase 5 — Leave Plan Requests (multi-date lifecycle)
- Phase 6 — AI Recommendation Flow (headline feature)
- hr_leave_management
- Phase 0 — Environment & Scaffolding
- Phase 2 — App Shell, Role-Adaptive Navigation, Dashboard
- Phase 9 — Hardening & Report-Readiness
- local_cache_service.dart
- pending_approvals_count_model.dart
- State
- StatelessWidget
- ../app/theme/app_theme.dart
- env.dart
- LeavePlanRequestsController
- package:table_calendar/table_calendar.dart
- package:flutter/material.dart
- schedule_binding.dart
- ../../features/dashboard/bindings/dashboard_binding.dart
- schedule_view.dart
- RegisterPlugins
- List
- admin_public_holidays_view.dart
- admin_users_view.dart
- user_summary.dart
- List

## God Nodes (most connected - your core abstractions)
1. `HR Leave Management — Flutter Client — Implementation Plan` - 21 edges
2. `Win32Window` - 19 edges
3. `HR Leave Management — Flutter Client — Task Checklist` - 14 edges
4. `AuthController` - 12 edges
5. `MessageHandler` - 12 edges
6. `HR Leave Management — Flutter Client — SPEC` - 11 edges
7. `FlutterWindow` - 10 edges
8. `Create` - 10 edges
9. `WndProc` - 10 edges
10. `AdminCrudController` - 9 edges

## Surprising Connections (you probably didn't know these)
- `_FakeTokenStorage` --implements--> `TokenStorage`  [EXTRACTED]
  test/unit/dio_client_unauthorized_test.dart → lib/core/storage/token_storage.dart
- `wWinMain()` --calls--> `CreateAndAttachConsole()`  [INFERRED]
  windows/runner/main.cpp → windows/runner/utils.cpp
- `Win32Window::Win32Window()` --calls--> `Destroy`  [INFERRED]
  windows/runner/win32_window.cpp → windows/runner/win32_window.h
- `LeaveBalancesAdminController` --inherits--> `AdminCrudController`  [EXTRACTED]
  lib/features/admin/controllers/leave_balances_admin_controller.dart → lib/features/admin/controllers/admin_crud_controller.dart
- `LeaveTypesAdminController` --inherits--> `AdminCrudController`  [EXTRACTED]
  lib/features/admin/controllers/leave_types_admin_controller.dart → lib/features/admin/controllers/admin_crud_controller.dart

## Import Cycles
- None detected.

## Communities (112 total, 8 thin omitted)

### Community 0 - "App Architecture & Design Rationale"
Cohesion: 0.18
Nodes (11): ../controllers/teams_admin_controller.dart, ../../../data/models/team_model.dart, TeamModel, dependencies, TeamsAdminBinding, AdminCrudController, TeamsAdminController, AdminTeamsView (+3 more)

### Community 1 - "Windows Runner: Flutter/Win32 Embedding"
Cohesion: 0.06
Nodes (54): FlutterViewController, PluginRegistry, Point, RECT, Size, unique_ptr, RegisterPlugins(), DartProject (+46 more)

### Community 2 - "GetX Routes, Pages & Middleware Registry"
Cohesion: 0.06
Nodes (36): app_routes.dart, auth_middleware.dart, ../../features/admin/bindings/leave_balances_admin_binding.dart, ../../features/admin/bindings/leave_types_admin_binding.dart, ../../features/admin/bindings/policies_admin_binding.dart, ../../features/admin/bindings/public_holidays_admin_binding.dart, ../../features/admin/bindings/teams_admin_binding.dart, ../../features/admin/bindings/users_admin_binding.dart (+28 more)

### Community 3 - "Route Names & Token Storage"
Cohesion: 0.05
Nodes (37): ../constants/env.dart, FlutterSecureStorage, adminLeaveBalances, adminLeaveTypes, adminPolicies, adminPublicHolidays, adminTeams, adminUsers (+29 more)

### Community 4 - "AuthController & DI Bindings"
Cohesion: 0.09
Nodes (21): _authRepository, bootstrap, currentUser, errorMessage, forceLogout, isApprover, _isHandlingUnauthorized, isLoading (+13 more)

### Community 5 - "Dio Client Auth Test Suite"
Cohesion: 0.05
Nodes (33): dart:typed_data, DioException, HttpClientAdapter, package:flutter_test/flutter_test.dart, package:hr_leave_management/core/errors/api_exception.dart, package:hr_leave_management/core/network/dio_client.dart, package:hr_leave_management/core/storage/token_storage.dart, package:hr_leave_management/data/models/leave_balance_model.dart (+25 more)

### Community 6 - "Leave Requests Controller"
Cohesion: 0.07
Nodes (28): LeaveRequestsRepository, LeaveTypesRepository, _authController, createAndSubmitRequest, createRequest, currentRequest, deleteRequest, detailErrorMessage (+20 more)

### Community 7 - "Leave Recommendation Model & App Shell"
Cohesion: 0.06
Nodes (34): ../controllers/approvals_controller.dart, ../../../data/models/leave_request_model.dart, ApprovalsBinding, dependencies, ApprovalsController, approveLeavePlanRequest, approveLeaveRequest, _authController (+26 more)

### Community 8 - "App Theme & Design Tokens"
Cohesion: 0.06
Nodes (33): AppColors, AppShapes, AppSpacing, AppTheme, _build, buttonRadius, cardRadius, danger (+25 more)

### Community 9 - "Leave Plan Requests Controller"
Cohesion: 0.07
Nodes (27): _authController, createAndSubmitRequest, createRequest, currentRequest, deleteRequest, detailErrorMessage, errorMessage, fetchLeavePlanRequests (+19 more)

### Community 10 - "Leave Plan Request Model"
Cohesion: 0.08
Nodes (23): amount, approvalAt, approver, approverId, description, details, fromJson, id (+15 more)

### Community 11 - "Dashboard View"
Cohesion: 0.08
Nodes (28): DashboardController, ../../leave_requests/views/leave_request_form_view.dart, LeaveBalanceModel, MainShellView, _NavItem, _availableDaysSummary, balance, balances (+20 more)

### Community 12 - "Leave Request Model"
Cohesion: 0.08
Nodes (23): bool get, amount, approvalAt, approver, approverId, description, endDate, fromJson (+15 more)

### Community 13 - "Leave Request Form View"
Cohesion: 0.10
Nodes (21): LeaveRequestModel?, build, controller, createState, _descriptionController, dispose, _endDate, _formatDate (+13 more)

### Community 14 - "Leave Plan Request Form View"
Cohesion: 0.10
Nodes (20): LeavePlanRequestModel?, _addPlannedDate, build, controller, createState, _descriptionController, dispose, _formatDate (+12 more)

### Community 15 - "Balances/Recommends/Teams Repositories"
Cohesion: 0.15
Nodes (14): ../../../core/errors/api_exception.dart, Dio, _dio, fetchPendingCount, _dio, fetchRecommendations, RecommendsRepository, _dio (+6 more)

### Community 16 - "Leave Plan Request Detail View"
Cohesion: 0.14
Nodes (13): leave_plan_request_form_view.dart, LeavePlanRequestsController, build, _buildDetailRow, _buildTimelineRow, _confirmDelete, controller, createState (+5 more)

### Community 17 - "Recommendations Controller & View"
Cohesion: 0.18
Nodes (9): Architecture, Backend contract quirks that shape the code (verified against backend source, not just docs — see `tasks/plan.md` "Verified Backend Ground Truth"), Boundaries, Commands, Design tokens, graphify, Running the backend for manual verification, Testing strategy (+1 more)

### Community 18 - "Leave Plan Requests List View"
Cohesion: 0.15
Nodes (12): ../../../data/models/leave_plan_request_model.dart, leave_plan_request_detail_view.dart, build, _buildPlanCard, controller, createState, dispose, _formatDate (+4 more)

### Community 19 - "Leave Requests List View"
Cohesion: 0.10
Nodes (20): FormState, _boolValues, build, _buildField, _buildRelationField, createState, dispose, fields (+12 more)

### Community 20 - "Leave Request Detail View"
Cohesion: 0.05
Nodes (43): ../controllers/notifications_controller.dart, dart:async, ../../../data/models/notification_model.dart, GetxController, ../../leave_plan_requests/views/leave_plan_request_detail_view.dart, ../../leave_requests/views/leave_request_detail_view.dart, changeTab, MainShellController (+35 more)

### Community 21 - "Leave Requests Repository"
Cohesion: 0.17
Nodes (11): approveLeaveRequest, createLeaveRequest, deleteLeaveRequest, _dio, fetchLeaveRequest, fetchLeaveRequests, LeaveRequestsRepository, rejectLeaveRequest (+3 more)

### Community 22 - "Admin & Approvals Placeholder Views"
Cohesion: 0.15
Nodes (12): DateTime?, bridgeHoliday, data, fromJson, leaveDate, LeaveRecommendationItem, LeaveRecommendationsModel, leaveTypeId (+4 more)

### Community 23 - "Windows Runner Utils & Main"
Cohesion: 0.24
Nodes (9): _In_, _In_opt_, vector, wWinMain(), string, wchar_t, CreateAndAttachConsole(), GetCommandLineArguments() (+1 more)

### Community 24 - "Leave Plan Requests Repository"
Cohesion: 0.17
Nodes (11): approveLeavePlanRequest, createLeavePlanRequest, deleteLeavePlanRequest, _dio, fetchLeavePlanRequest, fetchLeavePlanRequests, LeavePlanRequestsRepository, rejectLeavePlanRequest (+3 more)

### Community 25 - "Recommendations Controller Logic"
Cohesion: 0.06
Nodes (30): ../controllers/recommendations_controller.dart, ../../../data/models/leave_recommendation_model.dart, ../../leave_plan_requests/bindings/leave_plan_requests_binding.dart, ../../leave_plan_requests/controllers/leave_plan_requests_controller.dart, ../../leave_plan_requests/views/leave_plan_request_form_view.dart, dependencies, RecommendationsBinding, changeYear (+22 more)

### Community 26 - "Leave Balance Model"
Cohesion: 0.13
Nodes (14): HR Leave Management — Flutter Client — Task Checklist, Phase 0 — Environment & Scaffolding, Phase 10 — Post-Launch Enhancements, Phase 11 — Backend API Enhancements + Flutter Integration (backend in `../hr-leave-management`, deployed on Render), Phase 12 — In-App Notifications (backend written by user, not yet deployed), Phase 1 — Auth & Session, Phase 2 — App Shell, Role-Adaptive Navigation, Dashboard, Phase 3 — Leave Balances (+6 more)

### Community 27 - "Leave Type Model"
Cohesion: 0.13
Nodes (14): createItem, deleteItem, fetchPage, idOf, leaveTypeOptions, leaveTypesRepository, _loadLeaveTypeOptions, _loadUserOptions (+6 more)

### Community 28 - "Auth Views (Login/Forgot/Reset)"
Cohesion: 0.14
Nodes (14): leave_request_detail_view.dart, build, _buildRequestCard, controller, createState, dispose, _formatDate, _getStatusColor (+6 more)

### Community 29 - "GetX Feature Bindings"
Cohesion: 0.11
Nodes (17): ../app/theme/app_theme.dart, build, ErrorStateView, message, onRetry, acceptLabel, build, isLoading (+9 more)

### Community 30 - "User Model"
Cohesion: 0.09
Nodes (21): create, createItem, delete, deleteItem, edit, errorMessage, fetchItems, fetchPage (+13 more)

### Community 31 - "Leave View State Classes"
Cohesion: 0.25
Nodes (7): build, controller, createState, _FieldLabel, _obscure, text, TextEditingController

### Community 32 - "Dashboard Controller"
Cohesion: 0.14
Nodes (14): leave_request_form_view.dart, build, _buildDetailRow, _buildTimelineRow, _confirmDelete, controller, createState, _formatDate (+6 more)

### Community 33 - "App Drawer Widget"
Cohesion: 0.13
Nodes (14): leave_balance_model.dart, endDate, fromJson, id, leaveType, month, owner, publicHolidays (+6 more)

### Community 34 - "Auth Repository"
Cohesion: 0.22
Nodes (8): AuthRepository, _dio, fetchMe, login, recoverPassword, resetPassword, testToken, ../models/user_model.dart

### Community 35 - "admin_form_dialog.dart"
Cohesion: 0.09
Nodes (22): ../controllers/policies_admin_controller.dart, ../../../data/models/policy_model.dart, double?, code, description, fromJson, id, isActive (+14 more)

### Community 36 - "Dio Client"
Cohesion: 0.15
Nodes (12): ../../../data/repositories/users_repository.dart, createItem, deleteItem, fetchPage, idOf, _loadTeamOptions, matchesSearch, onInit (+4 more)

### Community 37 - "leave_types_view.dart"
Cohesion: 0.22
Nodes (9): ../controllers/leave_balances_admin_controller.dart, ../../../data/models/leave_balance_model.dart, LeaveBalanceModel, dependencies, LeaveBalancesAdminBinding, LeaveBalancesAdminController, AdminLeaveBalancesView, build (+1 more)

### Community 38 - "API Exception Handling"
Cohesion: 0.25
Nodes (7): createPolicy, deletePolicy, _dio, fetchPolicies, PoliciesRepository, updatePolicy, ../models/policy_model.dart

### Community 39 - "Profile View"
Cohesion: 0.20
Nodes (9): ../../auth/controllers/auth_controller.dart, _AdminTile, build, icon, _InfoRow, _initials, label, route (+1 more)

### Community 40 - "leave_request_detail_view.dart"
Cohesion: 0.20
Nodes (9): ../../../data/models/paginated_result.dart, ../../../data/repositories/policies_repository.dart, createItem, deleteItem, fetchPage, idOf, matchesSearch, repository (+1 more)

### Community 41 - "Team Model"
Cohesion: 0.13
Nodes (14): Context, Critical Files, HR Leave Management — Flutter Client — Implementation Plan, Overall Verification, Phase 12 — In-App Notifications (backend written, not yet deployed at time of Flutter integration), Phase 3 — Leave Balances, Phase 7 — Approvals Queue (team-owner role), Reference Patterns from the Existing React Frontend (architectural parity, not literal translation) (+6 more)

### Community 42 - "Splash View"
Cohesion: 0.17
Nodes (11): description, email, fromJson, fullName, id, isActive, name, teamMembers (+3 more)

### Community 43 - "leave_recommendation_model.dart"
Cohesion: 0.29
Nodes (6): date, description, fromJson, id, name, toJson

### Community 44 - "Android Plugin Registrant"
Cohesion: 0.60
Nodes (3): GeneratedPluginRegistrant, FlutterEngine, Keep

### Community 45 - "Gradle Wrapper Script"
Cohesion: 0.60
Nodes (3): gradlew script, die(), warn()

### Community 46 - "Placeholder Screen Widget"
Cohesion: 0.18
Nodes (10): ../../core/network/dio_client.dart, ../../core/storage/local_cache_service.dart, ../../../core/storage/secure_storage_service.dart, ../../../data/repositories/approvals_repository.dart, ../../../data/repositories/auth_repository.dart, ../../../data/repositories/leave_plan_requests_repository.dart, ../../../data/repositories/leave_requests_repository.dart, ../../../data/repositories/notifications_repository.dart (+2 more)

### Community 47 - "Leave Types Repository"
Cohesion: 0.22
Nodes (8): createLeaveType, deleteLeaveType, _dio, fetchLeaveTypes, fetchLeaveTypesPage, LeaveTypesRepository, updateLeaveType, ../models/leave_type_model.dart

### Community 48 - "leave_types_admin_controller.dart"
Cohesion: 0.18
Nodes (10): AdminFieldSpec, AdminFieldType, AdminPickerOption, id, key, label, obscureText, options (+2 more)

### Community 49 - "leave_balance_model.dart"
Cohesion: 0.14
Nodes (13): availableBalance, balance, code, fromJson, id, leaveType, LeaveTypeSummary, name (+5 more)

### Community 51 - "Admin Teams View"
Cohesion: 0.22
Nodes (8): createBalance, deleteBalance, _dio, fetchBalancesPage, fetchMyBalances, LeaveBalancesRepository, updateBalance, ../models/leave_balance_model.dart

### Community 52 - "../../app/theme/app_theme.dart"
Cohesion: 0.13
Nodes (18): app/bindings/initial_binding.dart, app/routes/app_pages.dart, ../app/routes/app_routes.dart, ../controllers/auth_controller.dart, build, build, build, createState (+10 more)

### Community 53 - "admin_users_view.dart"
Cohesion: 0.12
Nodes (15): actor, copyWith, count, createdAt, data, entityId, entityType, eventType (+7 more)

### Community 54 - "Windows CMake Build Config"
Cohesion: 1.00
Nodes (3): windows/CMakeLists.txt — Windows Project Config, windows/flutter/CMakeLists.txt — Flutter Build Rules, windows/runner/CMakeLists.txt — Runner Executable Target

### Community 55 - "local_cache_service.dart"
Cohesion: 0.11
Nodes (17): AuthController, ../../features/dashboard/views/dashboard_view.dart, ../../features/leave_plan_requests/views/leave_plan_request_form_view.dart, ../../features/leave_requests/views/leave_request_form_view.dart, ../../features/profile/views/profile_view.dart, ../../features/schedule/views/schedule_view.dart, leaves_tab_view.dart, activeIcon (+9 more)

### Community 64 - "initial_binding.dart"
Cohesion: 0.18
Nodes (10): email, fromJson, fullName, id, isActive, isSuperuser, name, team (+2 more)

### Community 66 - "user_model.dart"
Cohesion: 0.22
Nodes (8): IconData, actionLabel, build, EmptyStateView, icon, onAction, subtitle, title

### Community 67 - "api_exception.dart"
Cohesion: 0.20
Nodes (9): Exception, int?, ApiException, _extractMessage, fromDioException, message, _networkErrorMessage, statusCode (+1 more)

### Community 68 - "public_holidays_admin_controller.dart"
Cohesion: 0.29
Nodes (6): package:hr_leave_management/core/storage/secure_storage_service.dart, package:hr_leave_management/data/repositories/auth_repository.dart, package:hr_leave_management/data/repositories/teams_repository.dart, package:hr_leave_management/features/auth/controllers/auth_controller.dart, package:hr_leave_management/features/auth/views/login_view.dart, main

### Community 69 - "user_summary.dart"
Cohesion: 0.29
Nodes (7): GetStorage, _box, LocalCacheService, remove, write, package:get_storage/get_storage.dart, T

### Community 70 - "admin_field_spec.dart"
Cohesion: 0.25
Nodes (7): Color, build, color, label, onTap, StatCard, value

### Community 71 - "Phase 4 — Leave Requests (owner lifecycle)"
Cohesion: 0.25
Nodes (7): Bindings, ../controllers/dashboard_controller.dart, InitialBinding, MainShellBinding, DashboardBinding, dependencies, ScheduleBinding

### Community 72 - "policies_admin_controller.dart"
Cohesion: 0.18
Nodes (10): ../features/notifications/controllers/notifications_controller.dart, actions, AppShellScaffold, body, build, floatingActionButton, NotificationsBellButton, title (+2 more)

### Community 73 - "leaves_tab_view.dart"
Cohesion: 0.20
Nodes (10): ../../features/leave_plan_requests/views/leave_plan_requests_view.dart, ../../features/leave_requests/views/leave_requests_view.dart, build, createState, dispose, LeavesTabView, _LeavesTabViewState, _tabController (+2 more)

### Community 74 - "AuthController"
Cohesion: 0.15
Nodes (12): ../../../data/repositories/teams_repository.dart, createItem, deleteItem, fetchPage, idOf, _loadUserOptions, matchesSearch, onInit (+4 more)

### Community 75 - "splash_view.dart"
Cohesion: 0.17
Nodes (11): 10. Boundaries, 1. Objective, 2. Tech Stack (per course guideline), 3. Commands, 4. Project Structure, 5. Code Style, 6. Testing Strategy, 7. Known Gaps vs. Guideline (decided, documented — not open questions) (+3 more)

### Community 76 - "main_shell_binding.dart"
Cohesion: 0.29
Nodes (6): ../../features/dashboard/controllers/dashboard_controller.dart, ../../features/leave_plan_requests/controllers/leave_plan_requests_controller.dart, ../../features/leave_requests/controllers/leave_requests_controller.dart, ../../features/schedule/controllers/schedule_controller.dart, dependencies, main_shell_controller.dart

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
Nodes (20): ../controllers/leave_types_admin_controller.dart, ../../../data/models/leave_type_model.dart, code, description, entitlement, fromJson, id, isActive (+12 more)

### Community 81 - "Phase 10 — Post-Launch Enhancements (after Checkpoint 9)"
Cohesion: 0.40
Nodes (5): Phase 10 — Post-Launch Enhancements (after Checkpoint 9), Task 10.1 — Employee Public Holidays month-calendar view, Task 10.2 — Remove redundant Profile tile from Dashboard Quick Actions, Task 10.3 — Remove "Recent Activity" placeholder stat card, Task 10.4 — Wire "Pending Requests" dashboard stat to real data

### Community 82 - "Phase 8 — Admin/Superuser Master Data CRUD"
Cohesion: 0.40
Nodes (5): Phase 8 — Admin/Superuser Master Data CRUD, Task 8.1 — Generic CRUD scaffold, proven on Leave Types, Task 8.2 — Apply pattern: Public Holidays, Policies, Task 8.3 — Apply pattern: Teams, Users (relational pickers), Task 8.4 — Apply pattern: Leave Balances (admin) + fix missing Public Holidays nav entry

### Community 83 - "Phase 11 — Backend API Enhancements (proposed, tracked here; implemented in `../hr-leave-management`)"
Cohesion: 0.40
Nodes (5): Phase 11 — Backend API Enhancements + Flutter Integration, Task 11.1 — Query-param filtering on `GET /leave-requests/` and `GET /leave-plan-requests/`, Task 11.2 — New `GET /approvals/pending-count`, Task 11.3 — New `GET /schedule/?year=<int>&month=<int 1-12>`, Task 11.4 — Remove "Pending Requests", keep only "Pending Approvals"; scope plain lists to owner_id

### Community 85 - "Phase 1 — Auth & Session"
Cohesion: 0.50
Nodes (4): Phase 1 — Auth & Session, Task 1.1 — Login + token storage + current-user fetch + minimal authenticated screen, Task 1.2 — Session bootstrap + global 401/403 handling, Task 1.3 — Forgot password + reset password

### Community 86 - "leave_types_admin_controller.dart"
Cohesion: 0.20
Nodes (9): admin_crud_controller.dart, ../../../data/repositories/leave_types_repository.dart, createItem, deleteItem, fetchPage, idOf, matchesSearch, repository (+1 more)

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

### Community 94 - "local_cache_service.dart"
Cohesion: 0.53
Nodes (6): GetView, AuthController, ForgotPasswordView, LoginView, ResetPasswordView, ProfileView

### Community 95 - "pending_approvals_count_model.dart"
Cohesion: 0.33
Nodes (5): fromJson, leavePlanRequests, leaveRequests, PendingApprovalsCountModel, total

### Community 96 - "State"
Cohesion: 0.20
Nodes (14): _PasswordField, _PasswordFieldState, LeavePlanRequestDetailView, _LeavePlanRequestDetailViewState, LeavePlanRequestFormView, _LeavePlanRequestFormViewState, LeavePlanRequestsView, _LeavePlanRequestsViewState (+6 more)

### Community 97 - "StatelessWidget"
Cohesion: 0.11
Nodes (17): admin_field_spec.dart, admin_form_dialog.dart, ../../features/admin/controllers/admin_crud_controller.dart, build, _confirmDelete, controller, createState, dispose (+9 more)

### Community 98 - "../app/theme/app_theme.dart"
Cohesion: 0.14
Nodes (13): ../../../data/repositories/leave_balances_repository.dart, ApprovalsRepository, approvalsRepository, balances, balancesError, fetchBalances, fetchPendingApprovalsCount, isLoadingBalances (+5 more)

### Community 99 - "env.dart"
Cohesion: 0.33
Nodes (5): _dartDefineApiBaseUrl, _defaultApiBaseUrl, Env, package:flutter_dotenv/flutter_dotenv.dart, static const String

### Community 100 - "LeavePlanRequestsController"
Cohesion: 0.40
Nodes (4): ../controllers/leave_plan_requests_controller.dart, dependencies, LeavePlanRequestsBinding, LeavePlanRequestsController

### Community 101 - "package:table_calendar/table_calendar.dart"
Cohesion: 0.14
Nodes (13): ../../../data/models/schedule_model.dart, ../../../data/repositories/schedule_repository.dart, ScheduleModel, changeMonth, errorMessage, fetchSchedule, focusedMonth, groupHolidaysByDay (+5 more)

### Community 102 - "package:flutter/material.dart"
Cohesion: 0.20
Nodes (9): class, ../../../data/repositories/public_holidays_repository.dart, createItem, deleteItem, fetchPage, idOf, matchesSearch, repository (+1 more)

### Community 103 - "schedule_binding.dart"
Cohesion: 0.50
Nodes (3): ../controllers/schedule_controller.dart, dependencies, ScheduleController

### Community 105 - "../../features/dashboard/bindings/dashboard_binding.dart"
Cohesion: 0.40
Nodes (4): app_shell_scaffold.dart, build, PlaceholderScreen, title

### Community 107 - "schedule_view.dart"
Cohesion: 0.14
Nodes (13): build, _buildHolidayCard, _buildTeamLeaveCard, color, _formatDate, _formatDateRange, _formatMonthHeading, label (+5 more)

### Community 108 - "RegisterPlugins"
Cohesion: 0.25
Nodes (7): _dio, fetchNotifications, fetchUnreadCount, markAllRead, markRead, NotificationsRepository, ../models/notification_model.dart

### Community 109 - "List"
Cohesion: 0.40
Nodes (4): ../controllers/leave_requests_controller.dart, dependencies, LeaveRequestsBinding, LeaveRequestsController

### Community 110 - "admin_public_holidays_view.dart"
Cohesion: 0.18
Nodes (11): ../controllers/public_holidays_admin_controller.dart, ../../../data/models/public_holiday_model.dart, PublicHolidayModel, dependencies, PublicHolidaysAdminBinding, PublicHolidaysAdminController, AdminPublicHolidaysView, build (+3 more)

### Community 111 - "admin_users_view.dart"
Cohesion: 0.20
Nodes (10): ../controllers/users_admin_controller.dart, ../../../data/models/user_model.dart, UserModel, dependencies, UsersAdminBinding, UsersAdminController, AdminUsersView, build (+2 more)

### Community 115 - "user_summary.dart"
Cohesion: 0.29
Nodes (6): email, fromJson, fullName, id, toJson, UserSummary

### Community 118 - "List"
Cohesion: 0.40
Nodes (4): count, data, PaginatedResult, List

## Knowledge Gaps
- **888 isolated node(s):** `_titles`, `icon`, `activeIcon`, `label`, `selected` (+883 more)
  These have ≤1 connection - possible missing edges or undocumented components.
- **8 thin communities (<3 nodes) omitted from report** — run `graphify query` to explore isolated nodes.

## Suggested Questions
_Questions this graph is uniquely positioned to answer:_

- **Why does `PublicHolidayModel` connect `admin_public_holidays_view.dart` to `leave_recommendation_model.dart`?**
  _High betweenness centrality (0.021) - this node is a cross-community bridge._
- **Why does `UserSummary` connect `user_summary.dart` to `App Drawer Widget`, `Leave Plan Request Model`, `Leave Request Model`, `leave_balance_model.dart`, `admin_users_view.dart`?**
  _High betweenness centrality (0.015) - this node is a cross-community bridge._
- **Why does `LeavePlanRequestModel` connect `Leave Plan Request Model` to `Leave Plan Requests Controller`?**
  _High betweenness centrality (0.013) - this node is a cross-community bridge._
- **What connects `_titles`, `icon`, `activeIcon` to the rest of the system?**
  _888 weakly-connected nodes found - possible documentation gaps or missing edges._
- **Should `Windows Runner: Flutter/Win32 Embedding` be split into smaller, more focused modules?**
  _Cohesion score 0.05683563748079877 - nodes in this community are weakly interconnected._
- **Should `GetX Routes, Pages & Middleware Registry` be split into smaller, more focused modules?**
  _Cohesion score 0.0553306342780027 - nodes in this community are weakly interconnected._
- **Should `Route Names & Token Storage` be split into smaller, more focused modules?**
  _Cohesion score 0.04878048780487805 - nodes in this community are weakly interconnected._