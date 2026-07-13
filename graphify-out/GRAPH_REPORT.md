# Graph Report - hr-leave-management-flutter  (2026-07-13)

## Corpus Check
- 109 files · ~32,353 words
- Verdict: corpus is large enough that graph structure adds value.

## Summary
- 1170 nodes · 1522 edges · 103 communities (68 shown, 35 thin omitted)
- Extraction: 99% EXTRACTED · 1% INFERRED · 0% AMBIGUOUS · INFERRED: 14 edges (avg confidence: 0.8)
- Token cost: 0 input · 0 output

## Graph Freshness
- Built from commit: `0f25969f`
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
- Phase 0 — Environment & Scaffolding
- splash_view.dart
- local_cache_service.dart
- dashboard_binding.dart
- List
- users_repository.dart
- AdminCrudController
- LeavePlanRequestsController
- pubspec.yaml — Package Manifest
- local_cache_service.dart
- hr_leave_management
- Figma Community HRMS Reference (qaCZJAA9Uca4nGziJ5wx9m)
- iconly Icon Package (tried, rejected)
- JWT Bearer Auth (OAuth2 password flow)
- POST /login/test-token (session-restore validation)
- POST /password-recovery/{email}
- Poppins Font (via google_fonts)
- POST /reset-password/
- Spring Boot Course Guideline Requirement (Java 21 + Spring Boot microservices)
- hr-leave-management/frontend (existing React app, architectural reference)
- LeaveRecommendationModel ({leave_type_id, year, data})
- Rationale: Admin CRUD (Phase 8) kept last per user decision even though it only depends on Phase 2.1 — Phases 3-7 seed test data manually via Swagger UI in the meantime
- Rationale: Android is the primary/demo target; Windows desktop is for fast dev-loop iteration only; iOS not built (no Mac available)
- Rationale: design tokens adopted from a Figma Community HRMS reference (minimal/clean, light-first), superseding an earlier dark/indigo/pill-button/filled-input v1 direction after the reference was found to match user intent better
- Rationale: reuse existing FastAPI backend instead of building Spring Boot (existing working backend from a prior team project; focus effort on Flutter client)
- Rationale: iconly icon package tried and reverted — incompatible with current Flutter's IconData being a final class; Material 'outlined' icon variants used instead
- Rationale: no audit-trail model/endpoint exists in backend; Audit Log declared out of scope, noted as future work
- Rationale: no refresh-token endpoint exists on backend; treat 8-day access token as session lifetime, re-prompt login on 401 rather than build a client-side workaround
- Rationale: no self-signup screen — admins provision all accounts via Phase 8 admin Users screen, matching the existing React app
- SPEC.md — HR Leave Management Flutter Client Spec
- tasks/plan.md — Implementation Plan

## God Nodes (most connected - your core abstractions)
1. `Win32Window` - 19 edges
2. `HR Leave Management — Flutter Client — Implementation Plan` - 18 edges
3. `AuthController` - 12 edges
4. `MessageHandler` - 12 edges
5. `HR Leave Management — Flutter Client — SPEC` - 11 edges
6. `HR Leave Management — Flutter Client — Task Checklist` - 11 edges
7. `FlutterWindow` - 10 edges
8. `Create` - 10 edges
9. `WndProc` - 10 edges
10. `AdminCrudController` - 8 edges

## Surprising Connections (you probably didn't know these)
- `_FakeTokenStorage` --implements--> `TokenStorage`  [EXTRACTED]
  test/unit/dio_client_unauthorized_test.dart → lib/core/storage/token_storage.dart
- `wWinMain()` --calls--> `CreateAndAttachConsole()`  [INFERRED]
  windows/runner/main.cpp → windows/runner/utils.cpp
- `Win32Window::Win32Window()` --calls--> `Destroy`  [INFERRED]
  windows/runner/win32_window.cpp → windows/runner/win32_window.h
- `LeaveTypesAdminController` --inherits--> `AdminCrudController`  [EXTRACTED]
  lib/features/admin/controllers/leave_types_admin_controller.dart → lib/features/admin/controllers/admin_crud_controller.dart
- `PoliciesAdminController` --inherits--> `AdminCrudController`  [EXTRACTED]
  lib/features/admin/controllers/policies_admin_controller.dart → lib/features/admin/controllers/admin_crud_controller.dart

## Import Cycles
- None detected.

## Hyperedges (group relationships)
- **Design Tokens Kept Consistent Across Flutter and Future Compose App** — lib_app_theme_app_theme_apptheme, spec_specification, concept_poppins_font, rationale_design_token_v2_migration [INFERRED 0.75]

## Communities (103 total, 35 thin omitted)

### Community 1 - "Windows Runner: Flutter/Win32 Embedding"
Cohesion: 0.06
Nodes (54): FlutterViewController, PluginRegistry, Point, RECT, Size, unique_ptr, RegisterPlugins(), DartProject (+46 more)

### Community 2 - "GetX Routes, Pages & Middleware Registry"
Cohesion: 0.05
Nodes (40): app_routes.dart, auth_middleware.dart, ../../features/admin/bindings/leave_types_admin_binding.dart, ../../features/admin/bindings/policies_admin_binding.dart, ../../features/admin/bindings/public_holidays_admin_binding.dart, ../../features/admin/bindings/teams_admin_binding.dart, ../../features/admin/bindings/users_admin_binding.dart, ../../features/admin/views/admin_leave_balances_view.dart (+32 more)

### Community 3 - "Route Names & Token Storage"
Cohesion: 0.05
Nodes (40): ../constants/env.dart, FlutterSecureStorage, adminLeaveBalances, adminLeaveTypes, adminPolicies, adminPublicHolidays, adminTeams, adminUsers (+32 more)

### Community 4 - "AuthController & DI Bindings"
Cohesion: 0.09
Nodes (21): _authRepository, bootstrap, currentUser, errorMessage, forceLogout, isApprover, _isHandlingUnauthorized, isLoading (+13 more)

### Community 5 - "Dio Client Auth Test Suite"
Cohesion: 0.06
Nodes (31): dart:typed_data, DioException, HttpClientAdapter, package:flutter_test/flutter_test.dart, package:hr_leave_management/core/errors/api_exception.dart, package:hr_leave_management/core/network/dio_client.dart, package:hr_leave_management/core/storage/secure_storage_service.dart, package:hr_leave_management/core/storage/token_storage.dart (+23 more)

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
Cohesion: 0.08
Nodes (23): amount, approvalAt, approver, approverId, description, details, fromJson, id (+15 more)

### Community 11 - "Dashboard View"
Cohesion: 0.10
Nodes (23): _availableDaysSummary, balance, balances, build, DashboardView, data, error, _formatDays (+15 more)

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
Cohesion: 0.20
Nodes (9): Dio, _dio, fetchMyBalances, _dio, fetchRecommendations, RecommendsRepository, ../models/leave_balance_model.dart, ../models/leave_recommendation_model.dart (+1 more)

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
Cohesion: 0.06
Nodes (35): admin_crud_controller.dart, ../../core/storage/local_cache_service.dart, ../../../core/storage/secure_storage_service.dart, ../../../data/models/paginated_result.dart, ../../../data/repositories/auth_repository.dart, ../../../data/repositories/leave_plan_requests_repository.dart, ../../../data/repositories/leave_requests_repository.dart, ../../../data/repositories/leave_types_repository.dart (+27 more)

### Community 20 - "Leave Request Detail View"
Cohesion: 0.14
Nodes (14): leave_request_detail_view.dart, build, _buildRequestCard, controller, createState, dispose, _formatDate, _getStatusColor (+6 more)

### Community 21 - "Leave Requests Repository"
Cohesion: 0.17
Nodes (11): approveLeaveRequest, createLeaveRequest, deleteLeaveRequest, _dio, fetchLeaveRequest, fetchLeaveRequests, LeaveRequestsRepository, rejectLeaveRequest (+3 more)

### Community 22 - "Admin & Approvals Placeholder Views"
Cohesion: 0.18
Nodes (9): AdminLeaveBalancesView, build, build, createState, initState, build, PublicHolidaysView, package:flutter/material.dart (+1 more)

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
Cohesion: 0.20
Nodes (9): code, description, entitlement, fromJson, id, isActive, isAllowPlan, name (+1 more)

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
Nodes (12): SplashView, _SplashViewState, LeavePlanRequestDetailView, _LeavePlanRequestDetailViewState, LeavePlanRequestsView, _LeavePlanRequestsViewState, AdminCrudView, _AdminCrudViewState (+4 more)

### Community 32 - "Dashboard Controller"
Cohesion: 0.11
Nodes (17): admin_field_spec.dart, admin_form_dialog.dart, ../../features/admin/controllers/admin_crud_controller.dart, build, _confirmDelete, controller, createState, dispose (+9 more)

### Community 33 - "App Drawer Widget"
Cohesion: 0.20
Nodes (12): app/routes/app_routes.dart, ../controllers/auth_controller.dart, FormState, GetView, AuthController, build, ForgotPasswordView, build (+4 more)

### Community 34 - "Auth Repository"
Cohesion: 0.22
Nodes (8): AuthRepository, _dio, fetchMe, login, recoverPassword, resetPassword, testToken, ../models/user_model.dart

### Community 35 - "admin_form_dialog.dart"
Cohesion: 0.16
Nodes (12): ../controllers/public_holidays_admin_controller.dart, ../../../data/models/public_holiday_model.dart, PublicHolidayModel, dependencies, PublicHolidaysAdminBinding, AdminCrudController, PublicHolidaysAdminController, AdminPublicHolidaysView (+4 more)

### Community 36 - "Dio Client"
Cohesion: 0.17
Nodes (11): createItem, deleteItem, fetchPage, idOf, _loadTeamOptions, matchesSearch, onInit, repository (+3 more)

### Community 37 - "leave_types_view.dart"
Cohesion: 0.21
Nodes (10): ../controllers/teams_admin_controller.dart, ../../../data/models/team_model.dart, TeamModel, dependencies, TeamsAdminController, AdminTeamsView, build, _toFormValues (+2 more)

### Community 38 - "API Exception Handling"
Cohesion: 0.25
Nodes (7): createPolicy, deletePolicy, _dio, fetchPolicies, PoliciesRepository, updatePolicy, ../models/policy_model.dart

### Community 39 - "Profile View"
Cohesion: 0.29
Nodes (6): ../../auth/controllers/auth_controller.dart, build, _InfoRow, label, value, ../../../widgets/app_shell_scaffold.dart

### Community 40 - "leave_request_detail_view.dart"
Cohesion: 0.08
Nodes (24): Bindings, ../controllers/dashboard_controller.dart, ../controllers/leave_requests_controller.dart, ../../../core/network/dio_client.dart, ../../../data/models/leave_balance_model.dart, ../../../data/repositories/leave_balances_repository.dart, GetxController, InitialBinding (+16 more)

### Community 41 - "Team Model"
Cohesion: 0.05
Nodes (41): Context, Critical Files, HR Leave Management — Flutter Client — Implementation Plan, Overall Verification, Phase 0 — Environment & Scaffolding, Phase 1 — Auth & Session, Phase 2 — App Shell, Role-Adaptive Navigation, Dashboard, Phase 3 — Leave Balances (+33 more)

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
Cohesion: 0.17
Nodes (11): availableBalance, balance, code, fromJson, id, LeaveBalanceModel, leaveType, LeaveTypeSummary (+3 more)

### Community 52 - "../../app/theme/app_theme.dart"
Cohesion: 0.22
Nodes (8): app/bindings/initial_binding.dart, app/routes/app_pages.dart, app/theme/app_theme.dart, build, HrLeaveManagementApp, init, load, main

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
Cohesion: 0.10
Nodes (19): _boolValues, build, _buildField, _buildRelationField, createState, dispose, fields, _findOption (+11 more)

### Community 71 - "Phase 4 — Leave Requests (owner lifecycle)"
Cohesion: 0.09
Nodes (22): ../controllers/policies_admin_controller.dart, ../../../data/models/policy_model.dart, double?, code, description, fromJson, id, isActive (+14 more)

### Community 73 - "Phase 0 — Environment & Scaffolding"
Cohesion: 0.15
Nodes (12): ../../../data/repositories/teams_repository.dart, createItem, deleteItem, fetchPage, idOf, _loadUserOptions, matchesSearch, onInit (+4 more)

### Community 75 - "splash_view.dart"
Cohesion: 0.17
Nodes (11): 10. Boundaries, 1. Objective, 2. Tech Stack (per course guideline), 3. Commands, 4. Project Structure, 5. Code Style, 6. Testing Strategy, 7. Known Gaps vs. Guideline (decided, documented — not open questions) (+3 more)

### Community 76 - "local_cache_service.dart"
Cohesion: 0.29
Nodes (6): date, description, fromJson, id, name, toJson

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

### Community 81 - "LeavePlanRequestsController"
Cohesion: 0.50
Nodes (3): ../controllers/leave_plan_requests_controller.dart, dependencies, LeavePlanRequestsController

### Community 86 - "local_cache_service.dart"
Cohesion: 0.29
Nodes (7): GetStorage, _box, LocalCacheService, remove, write, package:get_storage/get_storage.dart, T

## Knowledge Gaps
- **710 isolated node(s):** `What this is`, `Running the backend for manual verification`, `Backend contract quirks that shape the code (verified against backend source, not just docs — see `tasks/plan.md` "Verified Backend Ground Truth")`, `Design tokens`, `Testing strategy` (+705 more)
  These have ≤1 connection - possible missing edges or undocumented components.
- **35 thin communities (<3 nodes) omitted from report** — run `graphify query` to explore isolated nodes.

## Suggested Questions
_Questions this graph is uniquely positioned to answer:_

- **Why does `UserModel` connect `leave_types_admin_controller.dart` to `Dashboard View`, `User Model`?**
  _High betweenness centrality (0.033) - this node is a cross-community bridge._
- **Why does `UserSummary` connect `user_summary.dart` to `Leave Plan Request Model`, `Leave Request Model`?**
  _High betweenness centrality (0.021) - this node is a cross-community bridge._
- **What connects `What this is`, `Running the backend for manual verification`, `Backend contract quirks that shape the code (verified against backend source, not just docs — see `tasks/plan.md` "Verified Backend Ground Truth")` to the rest of the system?**
  _710 weakly-connected nodes found - possible documentation gaps or missing edges._
- **Should `Windows Runner: Flutter/Win32 Embedding` be split into smaller, more focused modules?**
  _Cohesion score 0.05683563748079877 - nodes in this community are weakly interconnected._
- **Should `GetX Routes, Pages & Middleware Registry` be split into smaller, more focused modules?**
  _Cohesion score 0.04983388704318937 - nodes in this community are weakly interconnected._
- **Should `Route Names & Token Storage` be split into smaller, more focused modules?**
  _Cohesion score 0.045454545454545456 - nodes in this community are weakly interconnected._
- **Should `AuthController & DI Bindings` be split into smaller, more focused modules?**
  _Cohesion score 0.09090909090909091 - nodes in this community are weakly interconnected._