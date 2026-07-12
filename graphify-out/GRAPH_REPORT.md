# Graph Report - hr-leave-management-flutter  (2026-07-12)

## Corpus Check
- 104 files · ~30,287 words
- Verdict: corpus is large enough that graph structure adds value.

## Summary
- 1079 nodes · 1434 edges · 79 communities (69 shown, 10 thin omitted)
- Extraction: 99% EXTRACTED · 1% INFERRED · 0% AMBIGUOUS · INFERRED: 14 edges (avg confidence: 0.8)
- Token cost: 0 input · 0 output

## Graph Freshness
- Built from commit: `d88e1483`
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
- README Overview
- api_exception.dart
- Phase 3 — Leave Balances
- user_summary.dart
- admin_field_spec.dart
- Phase 4 — Leave Requests (owner lifecycle)
- List
- Phase 0 — Environment & Scaffolding
- AuthController
- splash_view.dart
- local_cache_service.dart
- dashboard_binding.dart
- List

## God Nodes (most connected - your core abstractions)
1. `tasks/plan.md — Implementation Plan` - 20 edges
2. `Win32Window` - 19 edges
3. `MessageHandler` - 12 edges
4. `HR Leave Management — Flutter Client — Task Checklist` - 11 edges
5. `AuthController` - 11 edges
6. `SPEC.md — HR Leave Management Flutter Client Spec` - 11 edges
7. `Phase 1 — Auth & Session` - 11 edges
8. `FlutterWindow` - 10 edges
9. `Create` - 10 edges
10. `WndProc` - 10 edges

## Surprising Connections (you probably didn't know these)
- `tasks/plan.md — Implementation Plan` --references--> `AppPages`  [EXTRACTED]
  tasks/plan.md → lib/app/routes/app_pages.dart
- `tasks/plan.md — Implementation Plan` --references--> `ApiException`  [EXTRACTED]
  tasks/plan.md → lib/core/errors/api_exception.dart
- `tasks/plan.md — Implementation Plan` --references--> `DioClient`  [EXTRACTED]
  tasks/plan.md → lib/core/network/dio_client.dart
- `Phase 0 — Environment & Scaffolding` --references--> `LocalCacheService`  [EXTRACTED]
  tasks/plan.md → lib/core/storage/local_cache_service.dart
- `Phase 0 — Environment & Scaffolding` --references--> `SecureStorageService`  [EXTRACTED]
  tasks/plan.md → lib/core/storage/secure_storage_service.dart

## Import Cycles
- None detected.

## Hyperedges (group relationships)
- **Design Tokens Kept Consistent Across Flutter and Future Compose App** — lib_app_theme_app_theme_apptheme, spec_specification, concept_poppins_font, rationale_design_token_v2_migration [INFERRED 0.75]
- **Leave Balances/Requests/Plan-Requests/Recommendations Vertical Slice** — tasks_plan_phase_3, tasks_plan_phase_4, tasks_plan_phase_5, tasks_plan_phase_6 [INFERRED 0.75]

## Communities (79 total, 10 thin omitted)

### Community 0 - "App Architecture & Design Rationale"
Cohesion: 0.24
Nodes (11): Material 3 + Single Seed Color Theme, hr-leave-management/frontend (existing React app, architectural reference), AppPages, TeamsRepository, Rationale: Admin CRUD (Phase 8) kept last per user decision even though it only depends on Phase 2.1 — Phases 3-7 seed test data manually via Swagger UI in the meantime, Rationale: Android is the primary/demo target; Windows desktop is for fast dev-loop iteration only; iOS not built (no Mac available), Rationale: no self-signup screen — admins provision all accounts via Phase 8 admin Users screen, matching the existing React app, tasks/plan.md — Implementation Plan (+3 more)

### Community 1 - "Windows Runner: Flutter/Win32 Embedding"
Cohesion: 0.06
Nodes (54): FlutterViewController, PluginRegistry, Point, RECT, Size, unique_ptr, RegisterPlugins(), DartProject (+46 more)

### Community 2 - "GetX Routes, Pages & Middleware Registry"
Cohesion: 0.05
Nodes (37): app_routes.dart, auth_middleware.dart, ../../features/admin/bindings/leave_types_admin_binding.dart, ../../features/admin/bindings/policies_admin_binding.dart, ../../features/admin/bindings/public_holidays_admin_binding.dart, ../../features/admin/views/admin_leave_balances_view.dart, ../../features/admin/views/admin_public_holidays_view.dart, ../../features/admin/views/admin_teams_view.dart (+29 more)

### Community 3 - "Route Names & Token Storage"
Cohesion: 0.06
Nodes (33): FlutterSecureStorage, adminLeaveBalances, adminLeaveTypes, adminPolicies, adminPublicHolidays, adminTeams, adminUsers, approvals (+25 more)

### Community 4 - "AuthController & DI Bindings"
Cohesion: 0.07
Nodes (30): ../../core/storage/local_cache_service.dart, ../../core/storage/secure_storage_service.dart, ../../../data/models/user_model.dart, ../../data/repositories/auth_repository.dart, ../../data/repositories/leave_plan_requests_repository.dart, ../../data/repositories/leave_requests_repository.dart, ../../data/repositories/recommends_repository.dart, ../../data/repositories/teams_repository.dart (+22 more)

### Community 5 - "Dio Client Auth Test Suite"
Cohesion: 0.06
Nodes (31): dart:typed_data, DioException, HttpClientAdapter, package:flutter_test/flutter_test.dart, package:hr_leave_management/core/errors/api_exception.dart, package:hr_leave_management/core/network/dio_client.dart, package:hr_leave_management/core/storage/secure_storage_service.dart, package:hr_leave_management/core/storage/token_storage.dart (+23 more)

### Community 6 - "Leave Requests Controller"
Cohesion: 0.08
Nodes (24): createRequest, currentRequest, deleteRequest, detailErrorMessage, errorMessage, fetchLeaveRequests, fetchLeaveTypes, fetchRequestDetail (+16 more)

### Community 7 - "Leave Recommendation Model & App Shell"
Cohesion: 0.06
Nodes (33): ../controllers/approvals_controller.dart, ../../../data/models/leave_plan_request_model.dart, ../../../data/models/leave_request_model.dart, LeavePlanRequestsRepository, LeaveRequestsRepository, ApprovalsBinding, dependencies, ApprovalsController (+25 more)

### Community 8 - "App Theme & Design Tokens"
Cohesion: 0.05
Nodes (41): analysis_options.yaml — Dart Analyzer/Lint Config, cupertino_icons package, Dio HTTP Client, Figma Community HRMS Reference (qaCZJAA9Uca4nGziJ5wx9m), flutter_lints package, flutter_secure_storage package, GetStorage package, GetX (state mgmt / routing / DI) (+33 more)

### Community 9 - "Leave Plan Requests Controller"
Cohesion: 0.07
Nodes (26): createAndSubmitRequest, createRequest, currentRequest, deleteRequest, detailErrorMessage, errorMessage, fetchLeavePlanRequests, fetchLeaveTypes (+18 more)

### Community 10 - "Leave Plan Request Model"
Cohesion: 0.08
Nodes (24): LeaveTypeSummary, amount, approvalAt, approver, approverId, description, details, fromJson (+16 more)

### Community 11 - "Dashboard View"
Cohesion: 0.09
Nodes (26): DashboardController, LeaveBalanceModel, _availableDaysSummary, balance, balances, build, DashboardView, data (+18 more)

### Community 12 - "Leave Request Model"
Cohesion: 0.08
Nodes (23): leave_balance_model.dart, amount, approvalAt, approver, approverId, description, endDate, fromJson (+15 more)

### Community 13 - "Leave Request Form View"
Cohesion: 0.05
Nodes (39): bool get, double?, LeaveRequestModel?, LeaveRequestsController, code, description, fromJson, id (+31 more)

### Community 14 - "Leave Plan Request Form View"
Cohesion: 0.09
Nodes (23): LeavePlanRequestModel?, LeavePlanRequestsController, _addPlannedDate, build, controller, createState, _descriptionController, dispose (+15 more)

### Community 15 - "Balances/Recommends/Teams Repositories"
Cohesion: 0.17
Nodes (12): ../../core/errors/api_exception.dart, Dio, _dio, fetchMyBalances, _dio, fetchRecommendations, _dio, fetchTeams (+4 more)

### Community 16 - "Leave Plan Request Detail View"
Cohesion: 0.15
Nodes (12): leave_plan_request_form_view.dart, build, _buildDetailRow, _buildTimelineRow, _confirmDelete, controller, createState, _formatDate (+4 more)

### Community 17 - "Recommendations Controller & View"
Cohesion: 0.18
Nodes (9): Architecture, Backend contract quirks that shape the code (verified against backend source, not just docs — see `tasks/plan.md` "Verified Backend Ground Truth"), Boundaries, Commands, Design tokens, graphify, Running the backend for manual verification, Testing strategy (+1 more)

### Community 18 - "Leave Plan Requests List View"
Cohesion: 0.17
Nodes (11): leave_plan_request_detail_view.dart, build, _buildPlanCard, controller, createState, dispose, _formatDate, _getStatusColor (+3 more)

### Community 19 - "Leave Requests List View"
Cohesion: 0.09
Nodes (21): create, createItem, delete, deleteItem, edit, errorMessage, fetchItems, fetchPage (+13 more)

### Community 20 - "Leave Request Detail View"
Cohesion: 0.15
Nodes (12): leave_request_detail_view.dart, build, _buildRequestCard, controller, createState, dispose, _formatDate, _getStatusColor (+4 more)

### Community 21 - "Leave Requests Repository"
Cohesion: 0.17
Nodes (11): approveLeaveRequest, createLeaveRequest, deleteLeaveRequest, _dio, fetchLeaveRequest, fetchLeaveRequests, LeaveRequestsRepository, rejectLeaveRequest (+3 more)

### Community 22 - "Admin & Approvals Placeholder Views"
Cohesion: 0.15
Nodes (9): AdminLeaveBalancesView, build, AdminTeamsView, build, AdminUsersView, build, build, PublicHolidaysView (+1 more)

### Community 23 - "Windows Runner Utils & Main"
Cohesion: 0.24
Nodes (9): _In_, _In_opt_, vector, wWinMain(), string, wchar_t, CreateAndAttachConsole(), GetCommandLineArguments() (+1 more)

### Community 24 - "Leave Plan Requests Repository"
Cohesion: 0.17
Nodes (11): approveLeavePlanRequest, createLeavePlanRequest, deleteLeavePlanRequest, _dio, fetchLeavePlanRequest, fetchLeavePlanRequests, LeavePlanRequestsRepository, rejectLeavePlanRequest (+3 more)

### Community 25 - "Recommendations Controller Logic"
Cohesion: 0.06
Nodes (32): ../controllers/recommendations_controller.dart, ../../../data/models/leave_recommendation_model.dart, ../../leave_plan_requests/bindings/leave_plan_requests_binding.dart, ../../leave_plan_requests/controllers/leave_plan_requests_controller.dart, ../../leave_plan_requests/views/leave_plan_request_form_view.dart, LeaveRecommendationsModel, LeaveTypesRepository, dependencies (+24 more)

### Community 26 - "Leave Balance Model"
Cohesion: 0.17
Nodes (11): HR Leave Management — Flutter Client — Task Checklist, Phase 0 — Environment & Scaffolding, Phase 1 — Auth & Session, Phase 2 — App Shell, Role-Adaptive Navigation, Dashboard, Phase 3 — Leave Balances, Phase 4 — Leave Requests, Phase 5 — Leave Plan Requests, Phase 6 — AI Recommendation Flow (headline feature) (+3 more)

### Community 27 - "Leave Type Model"
Cohesion: 0.18
Nodes (10): code, description, entitlement, fromJson, id, isActive, isAllowPlan, LeaveTypeModel (+2 more)

### Community 28 - "Auth Views (Login/Forgot/Reset)"
Cohesion: 0.22
Nodes (8): app_drawer.dart, actions, AppShellScaffold, body, build, floatingActionButton, title, Widget

### Community 29 - "GetX Feature Bindings"
Cohesion: 0.11
Nodes (18): admin_field_spec.dart, AdminFormDialog, _AdminFormDialogState, _boolValues, build, _buildField, createState, dispose (+10 more)

### Community 30 - "User Model"
Cohesion: 0.20
Nodes (9): email, fromJson, fullName, id, isActive, isSuperuser, name, team (+1 more)

### Community 31 - "Leave View State Classes"
Cohesion: 0.27
Nodes (10): LeavePlanRequestDetailView, _LeavePlanRequestDetailViewState, LeavePlanRequestsView, _LeavePlanRequestsViewState, LeaveRequestDetailView, _LeaveRequestDetailViewState, LeaveRequestsView, _LeaveRequestsViewState (+2 more)

### Community 32 - "Dashboard Controller"
Cohesion: 0.11
Nodes (18): admin_form_dialog.dart, ../../features/admin/controllers/admin_crud_controller.dart, AdminCrudView, _AdminCrudViewState, build, _confirmDelete, controller, createState (+10 more)

### Community 33 - "App Drawer Widget"
Cohesion: 0.29
Nodes (7): ../app/routes/app_routes.dart, ../controllers/auth_controller.dart, FormState, build, build, build, package:flutter/material.dart

### Community 34 - "Auth Repository"
Cohesion: 0.25
Nodes (7): _dio, fetchMe, login, recoverPassword, resetPassword, testToken, ../models/user_model.dart

### Community 35 - "admin_form_dialog.dart"
Cohesion: 0.05
Nodes (43): admin_crud_controller.dart, AdminCrudController, ../controllers/policies_admin_controller.dart, ../controllers/public_holidays_admin_controller.dart, ../../../data/models/paginated_result.dart, ../../../data/models/policy_model.dart, ../../../data/models/public_holiday_model.dart, ../../../data/repositories/policies_repository.dart (+35 more)

### Community 36 - "Dio Client"
Cohesion: 0.15
Nodes (12): leave_request_form_view.dart, build, _buildDetailRow, _buildTimelineRow, _confirmDelete, controller, createState, _formatDate (+4 more)

### Community 37 - "leave_types_view.dart"
Cohesion: 0.16
Nodes (12): ../controllers/leave_types_admin_controller.dart, ../../../data/models/leave_type_model.dart, LeaveTypeModel, dependencies, LeaveTypesAdminBinding, AdminCrudController, LeaveTypesAdminController, build (+4 more)

### Community 38 - "API Exception Handling"
Cohesion: 0.22
Nodes (8): createPolicy, deletePolicy, _dio, fetchPolicies, PoliciesRepository, updatePolicy, ../models/paginated_result.dart, ../models/policy_model.dart

### Community 39 - "Profile View"
Cohesion: 0.29
Nodes (6): ../../auth/controllers/auth_controller.dart, build, _InfoRow, label, value, ../../../widgets/app_shell_scaffold.dart

### Community 40 - "leave_request_detail_view.dart"
Cohesion: 0.17
Nodes (11): ../../../data/models/leave_balance_model.dart, GetxController, balances, balancesError, DashboardController, fetchBalances, isLoadingBalances, _leaveBalancesRepository (+3 more)

### Community 41 - "Team Model"
Cohesion: 0.33
Nodes (5): fromJson, id, name, TeamModel, teamOwnerId

### Community 42 - "Splash View"
Cohesion: 0.50
Nodes (3): apiBaseUrl, Env, static const String

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
Nodes (4): ../app_shell_scaffold.dart, build, PlaceholderScreen, title

### Community 47 - "Leave Types Repository"
Cohesion: 0.22
Nodes (8): createLeaveType, deleteLeaveType, _dio, fetchLeaveTypes, fetchLeaveTypesPage, LeaveTypesRepository, updateLeaveType, ../models/leave_type_model.dart

### Community 48 - "leave_types_admin_controller.dart"
Cohesion: 0.22
Nodes (8): ../../data/repositories/leave_types_repository.dart, createItem, deleteItem, fetchPage, idOf, matchesSearch, repository, updateItem

### Community 49 - "leave_balance_model.dart"
Cohesion: 0.18
Nodes (10): availableBalance, balance, code, fromJson, id, leaveType, LeaveTypeSummary, name (+2 more)

### Community 52 - "../../app/theme/app_theme.dart"
Cohesion: 0.25
Nodes (7): app/bindings/initial_binding.dart, app/routes/app_pages.dart, ../../../app/theme/app_theme.dart, build, HrLeaveManagementApp, init, main

### Community 53 - "Phase 1 — Auth & Session"
Cohesion: 0.25
Nodes (8): POST /api/v1/login/access-token (8-day session, no refresh), POST /login/test-token (session-restore validation), POST /password-recovery/{email}, POST /reset-password/, UserModel, AuthRepository, Rationale: no refresh-token endpoint exists on backend; treat 8-day access token as session lifetime, re-prompt login on 401 rather than build a client-side workaround, Phase 1 — Auth & Session

### Community 54 - "Windows CMake Build Config"
Cohesion: 1.00
Nodes (3): windows/CMakeLists.txt — Windows Project Config, windows/flutter/CMakeLists.txt — Flutter Build Rules, windows/runner/CMakeLists.txt — Runner Executable Target

### Community 55 - "local_cache_service.dart"
Cohesion: 0.20
Nodes (9): AuthController, IconData, AppDrawer, build, icon, _initials, label, _NavTile (+1 more)

### Community 67 - "api_exception.dart"
Cohesion: 0.25
Nodes (7): int?, _extractMessage, fromDioException, message, _networkErrorMessage, statusCode, toString

### Community 68 - "Phase 3 — Leave Balances"
Cohesion: 0.29
Nodes (7): GET /recommends/leave-plan (AI Leave-Plan Recommender, headline feature), LeaveBalanceModel, LeaveRecommendationModel ({leave_type_id, year, data}), LeaveBalancesRepository, RecommendsRepository, Phase 3 — Leave Balances, Phase 6 — AI Recommendation Flow (headline feature)

### Community 69 - "user_summary.dart"
Cohesion: 0.29
Nodes (6): email, fromJson, fullName, id, toJson, UserSummary

### Community 70 - "admin_field_spec.dart"
Cohesion: 0.29
Nodes (6): AdminFieldSpec, AdminFieldType, key, label, required, type

### Community 71 - "Phase 4 — Leave Requests (owner lifecycle)"
Cohesion: 0.50
Nodes (5): LeavePlanRequestModel, LeaveRequestModel, Phase 4 — Leave Requests (owner lifecycle), Phase 5 — Leave Plan Requests (multi-date lifecycle), Phase 7 — Approvals Queue (team-owner role)

### Community 72 - "List"
Cohesion: 0.13
Nodes (14): Bindings, ../controllers/dashboard_controller.dart, ../controllers/leave_plan_requests_controller.dart, ../controllers/leave_requests_controller.dart, ../../core/network/dio_client.dart, ../../../data/repositories/leave_balances_repository.dart, InitialBinding, DashboardBinding (+6 more)

### Community 73 - "Phase 0 — Environment & Scaffolding"
Cohesion: 0.50
Nodes (4): Exception, ApiException, DioClient, Phase 0 — Environment & Scaffolding

### Community 74 - "AuthController"
Cohesion: 0.23
Nodes (11): GetView, AuthController, ForgotPasswordView, LoginView, ResetPasswordView, build, createState, initState (+3 more)

### Community 75 - "splash_view.dart"
Cohesion: 0.25
Nodes (7): ../constants/env.dart, dio, onUnauthorized, _secureStorageService, package:flutter/foundation.dart, ../storage/token_storage.dart, VoidCallback

### Community 76 - "local_cache_service.dart"
Cohesion: 0.29
Nodes (7): GetStorage, _box, LocalCacheService, remove, write, package:get_storage/get_storage.dart, T

### Community 77 - "dashboard_binding.dart"
Cohesion: 0.25
Nodes (7): createPublicHoliday, deletePublicHoliday, _dio, fetchPublicHolidays, PublicHolidaysRepository, updatePublicHoliday, ../models/public_holiday_model.dart

### Community 78 - "List"
Cohesion: 0.40
Nodes (4): count, data, PaginatedResult, List

## Knowledge Gaps
- **616 isolated node(s):** `dependencies`, `pages`, `Routes`, `splash`, `login` (+611 more)
  These have ≤1 connection - possible missing edges or undocumented components.
- **10 thin communities (<3 nodes) omitted from report** — run `graphify query` to explore isolated nodes.

## Suggested Questions
_Questions this graph is uniquely positioned to answer:_

- **Why does `tasks/plan.md — Implementation Plan` connect `App Architecture & Design Rationale` to `Phase 3 — Leave Balances`, `Phase 4 — Leave Requests (owner lifecycle)`, `App Theme & Design Tokens`, `Phase 0 — Environment & Scaffolding`, `AuthController`, `Phase 1 — Auth & Session`?**
  _High betweenness centrality (0.037) - this node is a cross-community bridge._
- **Why does `AuthController` connect `AuthController` to `App Architecture & Design Rationale`, `GetX Routes, Pages & Middleware Registry`, `AuthController & DI Bindings`, `leave_request_detail_view.dart`, `Phase 1 — Auth & Session`?**
  _High betweenness centrality (0.022) - this node is a cross-community bridge._
- **Why does `SPEC.md — HR Leave Management Flutter Client Spec` connect `App Theme & Design Tokens` to `App Architecture & Design Rationale`?**
  _High betweenness centrality (0.021) - this node is a cross-community bridge._
- **What connects `dependencies`, `pages`, `Routes` to the rest of the system?**
  _616 weakly-connected nodes found - possible documentation gaps or missing edges._
- **Should `Windows Runner: Flutter/Win32 Embedding` be split into smaller, more focused modules?**
  _Cohesion score 0.05683563748079877 - nodes in this community are weakly interconnected._
- **Should `GetX Routes, Pages & Middleware Registry` be split into smaller, more focused modules?**
  _Cohesion score 0.05384615384615385 - nodes in this community are weakly interconnected._
- **Should `Route Names & Token Storage` be split into smaller, more focused modules?**
  _Cohesion score 0.05555555555555555 - nodes in this community are weakly interconnected._