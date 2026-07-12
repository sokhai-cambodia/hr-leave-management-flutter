# Graph Report - .  (2026-07-12)

## Corpus Check
- Corpus is ~24,841 words - fits in a single context window. You may not need a graph.

## Summary
- 837 nodes · 1158 edges · 67 communities (54 shown, 13 thin omitted)
- Extraction: 99% EXTRACTED · 1% INFERRED · 0% AMBIGUOUS · INFERRED: 17 edges (avg confidence: 0.82)
- Token cost: 324,419 input · 0 output

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
- App Entrypoint (main.dart)
- Dio Client
- Local Cache Service
- API Exception Handling
- Profile View
- User Summary Model
- Team Model
- Splash View
- API Exception Tests
- Android Plugin Registrant
- Gradle Wrapper Script
- Placeholder Screen Widget
- Leave Types Repository
- Leave Plan Requests Binding
- Leave Requests Binding
- Android MainActivity
- Admin Teams View
- Policies View
- Public Holidays View
- Windows CMake Build Config
- Leave Plan Full-Replace Rationale
- App Launcher Icon (hdpi)
- App Launcher Icon (mdpi)
- App Launcher Icon (xhdpi)
- App Launcher Icon (xxhdpi)
- App Launcher Icon (xxxhdpi)
- Flutter Framework Concept
- Misc Constant
- README Overview

## God Nodes (most connected - your core abstractions)
1. `tasks/plan.md — Implementation Plan` - 27 edges
2. `CLAUDE.md — Architecture & Contributor Guide` - 21 edges
3. `AuthController` - 19 edges
4. `Win32Window` - 19 edges
5. `SPEC.md — HR Leave Management Flutter Client Spec` - 15 edges
6. `MessageHandler` - 12 edges
7. `tasks/todo.md — Task Checklist` - 12 edges
8. `Phase 1 — Auth & Session` - 12 edges
9. `FlutterWindow` - 10 edges
10. `Create` - 10 edges

## Surprising Connections (you probably didn't know these)
- `AppPages` --references--> `SuperuserMiddleware (gates admin routes)`  [EXTRACTED]
  lib/app/routes/app_pages.dart → CLAUDE.md
- `CLAUDE.md — Architecture & Contributor Guide` --references--> `AppTheme`  [EXTRACTED]
  CLAUDE.md → lib/app/theme/app_theme.dart
- `CLAUDE.md — Architecture & Contributor Guide` --references--> `Env`  [EXTRACTED]
  CLAUDE.md → lib/core/constants/env.dart
- `Phase 0 — Environment & Scaffolding` --references--> `LocalCacheService`  [EXTRACTED]
  tasks/plan.md → lib/core/storage/local_cache_service.dart
- `Phase 0 — Environment & Scaffolding` --references--> `SecureStorageService`  [EXTRACTED]
  tasks/plan.md → lib/core/storage/secure_storage_service.dart

## Import Cycles
- None detected.

## Hyperedges (group relationships)
- **Global 401/403 Session-Invalidation Flow** — lib_core_network_dio_client_dioclient, lib_app_bindings_initial_binding_initialbinding, lib_features_auth_controllers_auth_controller_authcontroller, lib_app_routes_app_pages_authmiddleware [EXTRACTED 0.95]
- **Design Tokens Kept Consistent Across Flutter and Future Compose App** — lib_app_theme_app_theme_apptheme, spec_specification, concept_poppins_font, rationale_design_token_v2_migration [INFERRED 0.75]
- **Leave Balances/Requests/Plan-Requests/Recommendations Vertical Slice** — tasks_plan_phase_3, tasks_plan_phase_4, tasks_plan_phase_5, tasks_plan_phase_6 [INFERRED 0.75]

## Communities (67 total, 13 thin omitted)

### Community 0 - "App Architecture & Design Rationale"
Cohesion: 0.05
Nodes (70): analysis_options.yaml — Dart Analyzer/Lint Config, CLAUDE.md — Architecture & Contributor Guide, cupertino_icons package, Dio HTTP Client, FastAPI Backend (Python monolith, ../hr-leave-management/backend), Figma Community HRMS Reference (qaCZJAA9Uca4nGziJ5wx9m), flutter_lints package, flutter_secure_storage package (+62 more)

### Community 1 - "Windows Runner: Flutter/Win32 Embedding"
Cohesion: 0.06
Nodes (54): FlutterViewController, PluginRegistry, Point, RECT, Size, unique_ptr, RegisterPlugins(), DartProject (+46 more)

### Community 2 - "GetX Routes, Pages & Middleware Registry"
Cohesion: 0.06
Nodes (32): app_routes.dart, auth_middleware.dart, ../../features/admin/views/admin_leave_balances_view.dart, ../../features/admin/views/admin_teams_view.dart, ../../features/admin/views/admin_users_view.dart, ../../features/admin/views/leave_types_view.dart, ../../features/admin/views/policies_view.dart, ../../features/approvals/views/approvals_view.dart (+24 more)

### Community 3 - "Route Names & Token Storage"
Cohesion: 0.06
Nodes (32): FlutterSecureStorage, adminLeaveBalances, adminLeaveTypes, adminPolicies, adminTeams, adminUsers, approvals, dashboard (+24 more)

### Community 4 - "AuthController & DI Bindings"
Cohesion: 0.06
Nodes (31): ../../core/storage/local_cache_service.dart, ../../../core/storage/secure_storage_service.dart, ../../../data/models/user_model.dart, ../../../data/repositories/auth_repository.dart, ../../../data/repositories/leave_plan_requests_repository.dart, ../../../data/repositories/leave_requests_repository.dart, ../../../data/repositories/leave_types_repository.dart, ../../../data/repositories/recommends_repository.dart (+23 more)

### Community 5 - "Dio Client Auth Test Suite"
Cohesion: 0.07
Nodes (26): dart:typed_data, DioException, HttpClientAdapter, package:flutter_test/flutter_test.dart, package:hr_leave_management/core/network/dio_client.dart, package:hr_leave_management/core/storage/secure_storage_service.dart, package:hr_leave_management/core/storage/token_storage.dart, package:hr_leave_management/data/models/leave_balance_model.dart (+18 more)

### Community 6 - "Leave Requests Controller"
Cohesion: 0.07
Nodes (26): ../../../data/models/leave_type_model.dart, createRequest, currentRequest, deleteRequest, detailErrorMessage, errorMessage, fetchLeaveRequests, fetchLeaveTypes (+18 more)

### Community 7 - "Leave Recommendation Model & App Shell"
Cohesion: 0.08
Nodes (23): app_drawer.dart, DateTime?, bridgeHoliday, data, fromJson, leaveDate, LeaveRecommendationItem, LeaveRecommendationsModel (+15 more)

### Community 8 - "App Theme & Design Tokens"
Cohesion: 0.08
Nodes (25): iconly Icon Package (tried, rejected), AppColors, AppShapes, AppTheme, _build, buttonRadius, cardRadius, danger (+17 more)

### Community 9 - "Leave Plan Requests Controller"
Cohesion: 0.08
Nodes (25): createRequest, currentRequest, deleteRequest, detailErrorMessage, errorMessage, fetchLeavePlanRequests, fetchLeaveTypes, fetchRequestDetail (+17 more)

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
Cohesion: 0.11
Nodes (19): LeaveRequestModel, build, controller, createState, _descriptionController, dispose, _endDate, _formatDate (+11 more)

### Community 14 - "Leave Plan Request Form View"
Cohesion: 0.11
Nodes (17): bool get, _addPlannedDate, build, controller, createState, _descriptionController, dispose, _formatDate (+9 more)

### Community 15 - "Balances/Recommends/Teams Repositories"
Cohesion: 0.16
Nodes (13): ../../../core/errors/api_exception.dart, Dio, _dio, fetchMyBalances, _dio, fetchRecommendations, RecommendsRepository, _dio (+5 more)

### Community 16 - "Leave Plan Request Detail View"
Cohesion: 0.14
Nodes (14): ../../../data/models/leave_plan_request_model.dart, build, _buildDetailRow, _buildTimelineRow, _confirmDelete, controller, createState, _formatDate (+6 more)

### Community 17 - "Recommendations Controller & View"
Cohesion: 0.16
Nodes (12): ../controllers/recommendations_controller.dart, ../../../data/models/leave_recommendation_model.dart, GetxController, DashboardController, dependencies, RecommendationsController, build, _buildBadge (+4 more)

### Community 18 - "Leave Plan Requests List View"
Cohesion: 0.14
Nodes (13): leave_plan_request_detail_view.dart, leave_plan_request_form_view.dart, build, _buildPlanCard, controller, createState, dispose, _formatDate (+5 more)

### Community 19 - "Leave Requests List View"
Cohesion: 0.15
Nodes (12): ../../../data/models/leave_request_model.dart, leave_request_detail_view.dart, build, _buildRequestCard, controller, createState, dispose, _formatDate (+4 more)

### Community 20 - "Leave Request Detail View"
Cohesion: 0.15
Nodes (12): leave_request_form_view.dart, build, _buildDetailRow, _buildTimelineRow, _confirmDelete, controller, createState, _formatDate (+4 more)

### Community 21 - "Leave Requests Repository"
Cohesion: 0.15
Nodes (12): approveLeaveRequest, createLeaveRequest, deleteLeaveRequest, _dio, fetchLeaveRequest, fetchLeaveRequests, LeaveRequestsRepository, rejectLeaveRequest (+4 more)

### Community 22 - "Admin & Approvals Placeholder Views"
Cohesion: 0.15
Nodes (9): AdminLeaveBalancesView, build, AdminUsersView, build, build, LeaveTypesView, ApprovalsView, build (+1 more)

### Community 23 - "Windows Runner Utils & Main"
Cohesion: 0.24
Nodes (9): _In_, _In_opt_, vector, wWinMain(), string, wchar_t, CreateAndAttachConsole(), GetCommandLineArguments() (+1 more)

### Community 24 - "Leave Plan Requests Repository"
Cohesion: 0.17
Nodes (11): approveLeavePlanRequest, createLeavePlanRequest, deleteLeavePlanRequest, _dio, fetchLeavePlanRequest, fetchLeavePlanRequests, LeavePlanRequestsRepository, rejectLeavePlanRequest (+3 more)

### Community 25 - "Recommendations Controller Logic"
Cohesion: 0.17
Nodes (11): changeYear, errorMessage, fetchRecommendations, isLoading, leaveTypeName, leaveTypesRepository, onInit, recommendations (+3 more)

### Community 26 - "Leave Balance Model"
Cohesion: 0.18
Nodes (10): availableBalance, balance, code, fromJson, id, leaveType, LeaveTypeSummary, name (+2 more)

### Community 27 - "Leave Type Model"
Cohesion: 0.18
Nodes (10): code, description, entitlement, fromJson, id, isActive, isAllowPlan, LeaveTypeModel (+2 more)

### Community 28 - "Auth Views (Login/Forgot/Reset)"
Cohesion: 0.29
Nodes (7): ../app/routes/app_routes.dart, ../controllers/auth_controller.dart, FormState, build, build, build, package:flutter/material.dart

### Community 29 - "GetX Feature Bindings"
Cohesion: 0.20
Nodes (9): Bindings, ../controllers/dashboard_controller.dart, ../../../core/network/dio_client.dart, ../../../data/repositories/leave_balances_repository.dart, DashboardBinding, dependencies, LeavePlanRequestsBinding, LeaveRequestsBinding (+1 more)

### Community 30 - "User Model"
Cohesion: 0.20
Nodes (9): email, fromJson, fullName, id, isActive, isSuperuser, name, team (+1 more)

### Community 31 - "Leave View State Classes"
Cohesion: 0.27
Nodes (10): LeavePlanRequestFormView, _LeavePlanRequestFormViewState, LeavePlanRequestsView, _LeavePlanRequestsViewState, LeaveRequestDetailView, _LeaveRequestDetailViewState, LeaveRequestsView, _LeaveRequestsViewState (+2 more)

### Community 32 - "Dashboard Controller"
Cohesion: 0.22
Nodes (8): ../../../data/models/leave_balance_model.dart, LeaveBalancesRepository, balances, balancesError, fetchBalances, isLoadingBalances, _leaveBalancesRepository, onInit

### Community 33 - "App Drawer Widget"
Cohesion: 0.22
Nodes (8): IconData, AppDrawer, build, icon, _initials, label, _NavTile, route

### Community 34 - "Auth Repository"
Cohesion: 0.22
Nodes (8): AuthRepository, _dio, fetchMe, login, recoverPassword, resetPassword, testToken, ../models/user_model.dart

### Community 35 - "App Entrypoint (main.dart)"
Cohesion: 0.25
Nodes (7): app/bindings/initial_binding.dart, app/routes/app_pages.dart, app/theme/app_theme.dart, build, HrLeaveManagementApp, init, main

### Community 36 - "Dio Client"
Cohesion: 0.25
Nodes (7): ../constants/env.dart, dio, onUnauthorized, _secureStorageService, package:flutter/foundation.dart, ../storage/token_storage.dart, VoidCallback

### Community 37 - "Local Cache Service"
Cohesion: 0.29
Nodes (7): GetStorage, _box, LocalCacheService, remove, write, package:get_storage/get_storage.dart, T

### Community 38 - "API Exception Handling"
Cohesion: 0.25
Nodes (7): int?, _extractMessage, fromDioException, message, _networkErrorMessage, statusCode, toString

### Community 39 - "Profile View"
Cohesion: 0.29
Nodes (6): ../../auth/controllers/auth_controller.dart, build, _InfoRow, label, value, ../../../widgets/app_shell_scaffold.dart

### Community 40 - "User Summary Model"
Cohesion: 0.29
Nodes (6): email, fromJson, fullName, id, toJson, UserSummary

### Community 41 - "Team Model"
Cohesion: 0.33
Nodes (5): fromJson, id, name, TeamModel, teamOwnerId

### Community 42 - "Splash View"
Cohesion: 0.40
Nodes (5): build, createState, initState, SplashView, _SplashViewState

### Community 43 - "API Exception Tests"
Cohesion: 0.33
Nodes (5): package:hr_leave_management/core/errors/api_exception.dart, _dioExceptionWith, main, requestOptions, response

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
Cohesion: 0.40
Nodes (4): _dio, fetchLeaveTypes, LeaveTypesRepository, ../models/leave_type_model.dart

### Community 48 - "Leave Plan Requests Binding"
Cohesion: 0.50
Nodes (3): ../controllers/leave_plan_requests_controller.dart, dependencies, LeavePlanRequestsController

### Community 49 - "Leave Requests Binding"
Cohesion: 0.50
Nodes (3): ../controllers/leave_requests_controller.dart, dependencies, LeaveRequestsController

### Community 54 - "Windows CMake Build Config"
Cohesion: 1.00
Nodes (3): windows/CMakeLists.txt — Windows Project Config, windows/flutter/CMakeLists.txt — Flutter Build Rules, windows/runner/CMakeLists.txt — Runner Executable Target

## Knowledge Gaps
- **444 isolated node(s):** `dependencies`, `pages`, `Routes`, `splash`, `login` (+439 more)
  These have ≤1 connection - possible missing edges or undocumented components.
- **13 thin communities (<3 nodes) omitted from report** — run `graphify query` to explore isolated nodes.

## Suggested Questions
_Questions this graph is uniquely positioned to answer:_

- **Why does `SecureStorageService` connect `Route Names & Token Storage` to `App Architecture & Design Rationale`, `AuthController & DI Bindings`?**
  _High betweenness centrality (0.062) - this node is a cross-community bridge._
- **Why does `AuthController` connect `App Architecture & Design Rationale` to `App Drawer Widget`, `GetX Routes, Pages & Middleware Registry`, `AuthController & DI Bindings`, `Splash View`, `Dashboard View`, `Recommendations Controller & View`?**
  _High betweenness centrality (0.055) - this node is a cross-community bridge._
- **Are the 2 inferred relationships involving `CLAUDE.md — Architecture & Contributor Guide` (e.g. with `SPEC.md — HR Leave Management Flutter Client Spec` and `tasks/plan.md — Implementation Plan`) actually correct?**
  _`CLAUDE.md — Architecture & Contributor Guide` has 2 INFERRED edges - model-reasoned connections that need verification._
- **What connects `dependencies`, `pages`, `Routes` to the rest of the system?**
  _444 weakly-connected nodes found - possible documentation gaps or missing edges._
- **Should `App Architecture & Design Rationale` be split into smaller, more focused modules?**
  _Cohesion score 0.05191146881287726 - nodes in this community are weakly interconnected._
- **Should `Windows Runner: Flutter/Win32 Embedding` be split into smaller, more focused modules?**
  _Cohesion score 0.05683563748079877 - nodes in this community are weakly interconnected._
- **Should `GetX Routes, Pages & Middleware Registry` be split into smaller, more focused modules?**
  _Cohesion score 0.06218487394957983 - nodes in this community are weakly interconnected._