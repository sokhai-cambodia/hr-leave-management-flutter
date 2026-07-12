# Graph Report - hr-leave-management-flutter  (2026-07-12)

## Corpus Check
- 109 files · ~32,225 words
- Verdict: corpus is large enough that graph structure adds value.

## Summary
- 1151 nodes · 1549 edges · 83 communities (73 shown, 10 thin omitted)
- Extraction: 99% EXTRACTED · 1% INFERRED · 0% AMBIGUOUS · INFERRED: 14 edges (avg confidence: 0.8)
- Token cost: 0 input · 0 output

## Graph Freshness
- Built from commit: `9867173d`
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
- users_repository.dart
- AdminCrudController
- LeavePlanRequestsController
- package:get/get.dart

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
- `Phase 1 — Auth & Session` --references--> `UserModel`  [EXTRACTED]
  tasks/plan.md → lib/data/models/user_model.dart
- `tasks/plan.md — Implementation Plan` --references--> `ApiException`  [EXTRACTED]
  tasks/plan.md → lib/core/errors/api_exception.dart
- `Phase 0 — Environment & Scaffolding` --references--> `ApiException`  [EXTRACTED]
  tasks/plan.md → lib/core/errors/api_exception.dart
- `tasks/plan.md — Implementation Plan` --references--> `DioClient`  [EXTRACTED]
  tasks/plan.md → lib/core/network/dio_client.dart

## Import Cycles
- None detected.

## Hyperedges (group relationships)
- **Design Tokens Kept Consistent Across Flutter and Future Compose App** — lib_app_theme_app_theme_apptheme, spec_specification, concept_poppins_font, rationale_design_token_v2_migration [INFERRED 0.75]
- **Leave Balances/Requests/Plan-Requests/Recommendations Vertical Slice** — tasks_plan_phase_3, tasks_plan_phase_4, tasks_plan_phase_5, tasks_plan_phase_6 [INFERRED 0.75]

## Communities (83 total, 10 thin omitted)

### Community 0 - "App Architecture & Design Rationale"
Cohesion: 0.18
Nodes (16): Material 3 + Single Seed Color Theme, hr-leave-management/frontend (existing React app, architectural reference), AppPages, LeavePlanRequestModel, LeaveRequestModel, TeamsRepository, Rationale: Admin CRUD (Phase 8) kept last per user decision even though it only depends on Phase 2.1 — Phases 3-7 seed test data manually via Swagger UI in the meantime, Rationale: Android is the primary/demo target; Windows desktop is for fast dev-loop iteration only; iOS not built (no Mac available) (+8 more)

### Community 1 - "Windows Runner: Flutter/Win32 Embedding"
Cohesion: 0.06
Nodes (54): FlutterViewController, PluginRegistry, Point, RECT, Size, unique_ptr, RegisterPlugins(), DartProject (+46 more)

### Community 2 - "GetX Routes, Pages & Middleware Registry"
Cohesion: 0.05
Nodes (39): app_routes.dart, auth_middleware.dart, ../../features/admin/bindings/leave_types_admin_binding.dart, ../../features/admin/bindings/policies_admin_binding.dart, ../../features/admin/bindings/public_holidays_admin_binding.dart, ../../features/admin/bindings/teams_admin_binding.dart, ../../features/admin/bindings/users_admin_binding.dart, ../../features/admin/views/admin_leave_balances_view.dart (+31 more)

### Community 3 - "Route Names & Token Storage"
Cohesion: 0.07
Nodes (27): FlutterSecureStorage, adminLeaveBalances, adminLeaveTypes, adminPolicies, adminPublicHolidays, adminTeams, adminUsers, approvals (+19 more)

### Community 4 - "AuthController & DI Bindings"
Cohesion: 0.05
Nodes (41): ../../core/storage/local_cache_service.dart, ../../core/storage/secure_storage_service.dart, ../../data/repositories/auth_repository.dart, ../../data/repositories/leave_plan_requests_repository.dart, ../../data/repositories/leave_requests_repository.dart, ../../data/repositories/recommends_repository.dart, ../../../data/repositories/teams_repository.dart, ../../../data/repositories/users_repository.dart (+33 more)

### Community 5 - "Dio Client Auth Test Suite"
Cohesion: 0.06
Nodes (31): dart:typed_data, DioException, HttpClientAdapter, package:flutter_test/flutter_test.dart, package:hr_leave_management/core/errors/api_exception.dart, package:hr_leave_management/core/network/dio_client.dart, package:hr_leave_management/core/storage/secure_storage_service.dart, package:hr_leave_management/core/storage/token_storage.dart (+23 more)

### Community 6 - "Leave Requests Controller"
Cohesion: 0.04
Nodes (45): ../controllers/leave_types_admin_controller.dart, ../../../data/models/leave_type_model.dart, ../../data/repositories/leave_types_repository.dart, LeaveTypeModel, LeaveTypesAdminController, dependencies, LeaveTypesAdminBinding, AdminCrudController (+37 more)

### Community 7 - "Leave Recommendation Model & App Shell"
Cohesion: 0.06
Nodes (35): ../controllers/approvals_controller.dart, ../../../data/models/leave_plan_request_model.dart, ../../../data/models/leave_request_model.dart, GetxController, LeavePlanRequestsRepository, LeaveRequestsRepository, ApprovalsBinding, dependencies (+27 more)

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
Cohesion: 0.10
Nodes (21): bool get, LeaveRequestModel?, LeaveRequestsController, build, controller, createState, _descriptionController, dispose (+13 more)

### Community 14 - "Leave Plan Request Form View"
Cohesion: 0.09
Nodes (21): LeavePlanRequestModel?, LeavePlanRequestsController, _addPlannedDate, build, controller, createState, _descriptionController, dispose (+13 more)

### Community 15 - "Balances/Recommends/Teams Repositories"
Cohesion: 0.22
Nodes (8): ../../../core/errors/api_exception.dart, Dio, _dio, fetchMyBalances, _dio, fetchRecommendations, ../models/leave_balance_model.dart, ../models/leave_recommendation_model.dart

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
Cohesion: 0.05
Nodes (40): admin_crud_controller.dart, ../../../data/models/paginated_result.dart, ../../../data/models/policy_model.dart, ../../data/repositories/policies_repository.dart, ../../data/repositories/public_holidays_repository.dart, create, createItem, delete (+32 more)

### Community 20 - "Leave Request Detail View"
Cohesion: 0.07
Nodes (30): ../controllers/leave_requests_controller.dart, leave_request_detail_view.dart, leave_request_form_view.dart, dependencies, LeaveRequestsBinding, LeaveRequestsController, build, _buildDetailRow (+22 more)

### Community 21 - "Leave Requests Repository"
Cohesion: 0.17
Nodes (11): approveLeaveRequest, createLeaveRequest, deleteLeaveRequest, _dio, fetchLeaveRequest, fetchLeaveRequests, LeaveRequestsRepository, rejectLeaveRequest (+3 more)

### Community 22 - "Admin & Approvals Placeholder Views"
Cohesion: 0.29
Nodes (6): AdminLeaveBalancesView, build, build, PublicHolidaysView, package:flutter/material.dart, ../../../widgets/placeholder_screen.dart

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
Cohesion: 0.17
Nodes (11): double?, code, description, fromJson, id, isActive, name, operation (+3 more)

### Community 29 - "GetX Feature Bindings"
Cohesion: 0.04
Nodes (43): app_drawer.dart, count, data, PaginatedResult, AdminFieldSpec, AdminFieldType, AdminPickerOption, id (+35 more)

### Community 30 - "User Model"
Cohesion: 0.18
Nodes (10): email, fromJson, fullName, id, isActive, isSuperuser, name, team (+2 more)

### Community 31 - "Leave View State Classes"
Cohesion: 0.27
Nodes (10): LeavePlanRequestDetailView, _LeavePlanRequestDetailViewState, LeavePlanRequestFormView, _LeavePlanRequestFormViewState, LeavePlanRequestsView, _LeavePlanRequestsViewState, LeaveRequestsView, _LeaveRequestsViewState (+2 more)

### Community 32 - "Dashboard Controller"
Cohesion: 0.08
Nodes (26): admin_field_spec.dart, admin_form_dialog.dart, ../../features/admin/controllers/admin_crud_controller.dart, GetStorage, _box, LocalCacheService, remove, write (+18 more)

### Community 33 - "App Drawer Widget"
Cohesion: 0.28
Nodes (6): ../app/routes/app_routes.dart, ../controllers/auth_controller.dart, FormState, build, build, build

### Community 34 - "Auth Repository"
Cohesion: 0.25
Nodes (7): _dio, fetchMe, login, recoverPassword, resetPassword, testToken, package:dio/dio.dart

### Community 35 - "admin_form_dialog.dart"
Cohesion: 0.20
Nodes (9): ../../../data/models/public_holiday_model.dart, AdminPublicHolidaysView, build, _emptyValues, _fields, _toFormValues, PublicHolidayModel, PublicHolidaysAdminController (+1 more)

### Community 36 - "Dio Client"
Cohesion: 0.17
Nodes (11): createItem, deleteItem, fetchPage, idOf, _loadTeamOptions, matchesSearch, onInit, repository (+3 more)

### Community 37 - "leave_types_view.dart"
Cohesion: 0.22
Nodes (9): ../controllers/teams_admin_controller.dart, ../../../data/models/team_model.dart, TeamModel, dependencies, TeamsAdminBinding, TeamsAdminController, AdminTeamsView, build (+1 more)

### Community 38 - "API Exception Handling"
Cohesion: 0.22
Nodes (8): createPolicy, deletePolicy, _dio, fetchPolicies, PoliciesRepository, updatePolicy, ../models/paginated_result.dart, ../models/policy_model.dart

### Community 39 - "Profile View"
Cohesion: 0.19
Nodes (12): ../../auth/controllers/auth_controller.dart, GetView, AuthController, ForgotPasswordView, LoginView, ResetPasswordView, build, _InfoRow (+4 more)

### Community 40 - "leave_request_detail_view.dart"
Cohesion: 0.25
Nodes (7): ../../../data/models/leave_balance_model.dart, balances, balancesError, fetchBalances, isLoadingBalances, _leaveBalancesRepository, onInit

### Community 41 - "Team Model"
Cohesion: 0.17
Nodes (11): description, email, fromJson, fullName, id, isActive, name, teamMembers (+3 more)

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
Nodes (9): ../controllers/users_admin_controller.dart, ../../../data/models/user_model.dart, UserModel, dependencies, UsersAdminBinding, UsersAdminController, AdminUsersView, build (+1 more)

### Community 49 - "leave_balance_model.dart"
Cohesion: 0.18
Nodes (10): availableBalance, balance, code, fromJson, id, leaveType, LeaveTypeSummary, name (+2 more)

### Community 52 - "../../app/theme/app_theme.dart"
Cohesion: 0.25
Nodes (7): app/bindings/initial_binding.dart, app/routes/app_pages.dart, ../../app/theme/app_theme.dart, build, HrLeaveManagementApp, init, main

### Community 53 - "Phase 1 — Auth & Session"
Cohesion: 0.29
Nodes (7): POST /api/v1/login/access-token (8-day session, no refresh), POST /login/test-token (session-restore validation), POST /password-recovery/{email}, POST /reset-password/, AuthRepository, Rationale: no refresh-token endpoint exists on backend; treat 8-day access token as session lifetime, re-prompt login on 401 rather than build a client-side workaround, Phase 1 — Auth & Session

### Community 54 - "Windows CMake Build Config"
Cohesion: 1.00
Nodes (3): windows/CMakeLists.txt — Windows Project Config, windows/flutter/CMakeLists.txt — Flutter Build Rules, windows/runner/CMakeLists.txt — Runner Executable Target

### Community 55 - "local_cache_service.dart"
Cohesion: 0.20
Nodes (9): AuthController, IconData, AppDrawer, build, icon, _initials, label, _NavTile (+1 more)

### Community 67 - "api_exception.dart"
Cohesion: 0.20
Nodes (9): Exception, int?, ApiException, _extractMessage, fromDioException, message, _networkErrorMessage, statusCode (+1 more)

### Community 68 - "Phase 3 — Leave Balances"
Cohesion: 0.29
Nodes (7): GET /recommends/leave-plan (AI Leave-Plan Recommender, headline feature), LeaveBalanceModel, LeaveRecommendationModel ({leave_type_id, year, data}), LeaveBalancesRepository, RecommendsRepository, Phase 3 — Leave Balances, Phase 6 — AI Recommendation Flow (headline feature)

### Community 69 - "user_summary.dart"
Cohesion: 0.29
Nodes (6): email, fromJson, fullName, id, toJson, UserSummary

### Community 70 - "admin_field_spec.dart"
Cohesion: 0.22
Nodes (8): Bindings, ../controllers/public_holidays_admin_controller.dart, InitialBinding, PoliciesAdminBinding, dependencies, PublicHolidaysAdminBinding, DashboardBinding, LeavePlanRequestsBinding

### Community 71 - "Phase 4 — Leave Requests (owner lifecycle)"
Cohesion: 0.22
Nodes (8): build, _emptyValues, _fields, PoliciesView, _toFormValues, PoliciesAdminController, PolicyModel, ../../../widgets/admin/admin_field_spec.dart

### Community 72 - "List"
Cohesion: 0.40
Nodes (4): ../controllers/dashboard_controller.dart, ../../core/network/dio_client.dart, ../../../data/repositories/leave_balances_repository.dart, dependencies

### Community 73 - "Phase 0 — Environment & Scaffolding"
Cohesion: 0.22
Nodes (8): DioClient, SecureStorageService, deleteToken, getToken, saveToken, TokenStorage, Phase 0 — Environment & Scaffolding, _FakeTokenStorage

### Community 74 - "AuthController"
Cohesion: 0.40
Nodes (5): build, createState, initState, SplashView, _SplashViewState

### Community 75 - "splash_view.dart"
Cohesion: 0.25
Nodes (7): ../constants/env.dart, dio, onUnauthorized, _secureStorageService, package:flutter/foundation.dart, ../storage/token_storage.dart, VoidCallback

### Community 76 - "local_cache_service.dart"
Cohesion: 0.25
Nodes (7): date, description, fromJson, id, name, toJson, String?

### Community 77 - "dashboard_binding.dart"
Cohesion: 0.25
Nodes (7): createPublicHoliday, deletePublicHoliday, _dio, fetchPublicHolidays, PublicHolidaysRepository, updatePublicHoliday, ../models/public_holiday_model.dart

### Community 78 - "List"
Cohesion: 0.25
Nodes (7): createTeam, deleteTeam, _dio, fetchTeams, fetchTeamsPage, updateTeam, ../models/team_model.dart

### Community 79 - "users_repository.dart"
Cohesion: 0.25
Nodes (7): createUser, deleteUser, _dio, fetchUsersPage, updateUser, UsersRepository, ../models/user_model.dart

### Community 80 - "AdminCrudController"
Cohesion: 0.40
Nodes (5): AdminCrudController, PolicyModel, PublicHolidayModel, PoliciesAdminController, PublicHolidaysAdminController

### Community 81 - "LeavePlanRequestsController"
Cohesion: 0.50
Nodes (3): ../controllers/leave_plan_requests_controller.dart, dependencies, LeavePlanRequestsController

### Community 82 - "package:get/get.dart"
Cohesion: 0.50
Nodes (3): ../controllers/policies_admin_controller.dart, dependencies, package:get/get.dart

## Knowledge Gaps
- **665 isolated node(s):** `dependencies`, `pages`, `TeamMemberSummary`, `id`, `fullName` (+660 more)
  These have ≤1 connection - possible missing edges or undocumented components.
- **10 thin communities (<3 nodes) omitted from report** — run `graphify query` to explore isolated nodes.

## Suggested Questions
_Questions this graph is uniquely positioned to answer:_

- **Why does `tasks/plan.md — Implementation Plan` connect `App Architecture & Design Rationale` to `api_exception.dart`, `Phase 3 — Leave Balances`, `Profile View`, `App Theme & Design Tokens`, `Phase 0 — Environment & Scaffolding`, `Phase 1 — Auth & Session`?**
  _High betweenness centrality (0.046) - this node is a cross-community bridge._
- **Why does `LeaveRequestModel` connect `App Architecture & Design Rationale` to `Leave Request Model`, `Leave Requests Controller`?**
  _High betweenness centrality (0.032) - this node is a cross-community bridge._
- **Why does `TeamsRepository` connect `App Architecture & Design Rationale` to `AuthController & DI Bindings`, `List`, `Dio Client`?**
  _High betweenness centrality (0.017) - this node is a cross-community bridge._
- **What connects `dependencies`, `pages`, `TeamMemberSummary` to the rest of the system?**
  _665 weakly-connected nodes found - possible documentation gaps or missing edges._
- **Should `Windows Runner: Flutter/Win32 Embedding` be split into smaller, more focused modules?**
  _Cohesion score 0.05683563748079877 - nodes in this community are weakly interconnected._
- **Should `GetX Routes, Pages & Middleware Registry` be split into smaller, more focused modules?**
  _Cohesion score 0.05110336817653891 - nodes in this community are weakly interconnected._
- **Should `Route Names & Token Storage` be split into smaller, more focused modules?**
  _Cohesion score 0.06896551724137931 - nodes in this community are weakly interconnected._