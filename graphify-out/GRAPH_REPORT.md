# Graph Report - hr-leave-management-flutter  (2026-07-12)

## Corpus Check
- 89 files · ~26,666 words
- Verdict: corpus is large enough that graph structure adds value.

## Summary
- 898 nodes · 1191 edges · 58 communities (48 shown, 10 thin omitted)
- Extraction: 99% EXTRACTED · 1% INFERRED · 0% AMBIGUOUS · INFERRED: 14 edges (avg confidence: 0.8)
- Token cost: 0 input · 0 output

## Graph Freshness
- Built from commit: `5427a153`
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
- Dio Client
- API Exception Handling
- Profile View
- Team Model
- Splash View
- Android Plugin Registrant
- Gradle Wrapper Script
- Placeholder Screen Widget
- Leave Types Repository
- Android MainActivity
- Admin Teams View
- Windows CMake Build Config
- App Launcher Icon (hdpi)
- App Launcher Icon (mdpi)
- App Launcher Icon (xhdpi)
- App Launcher Icon (xxhdpi)
- App Launcher Icon (xxxhdpi)
- Flutter Framework Concept
- Misc Constant
- README Overview

## God Nodes (most connected - your core abstractions)
1. `tasks/plan.md — Implementation Plan` - 20 edges
2. `Win32Window` - 19 edges
3. `AuthController` - 13 edges
4. `MessageHandler` - 12 edges
5. `HR Leave Management — Flutter Client — Task Checklist` - 11 edges
6. `SPEC.md — HR Leave Management Flutter Client Spec` - 11 edges
7. `Phase 1 — Auth & Session` - 11 edges
8. `FlutterWindow` - 10 edges
9. `Create` - 10 edges
10. `WndProc` - 10 edges

## Surprising Connections (you probably didn't know these)
- `tasks/plan.md — Implementation Plan` --references--> `AppPages`  [EXTRACTED]
  tasks/plan.md → lib/app/routes/app_pages.dart
- `Phase 0 — Environment & Scaffolding` --references--> `LocalCacheService`  [EXTRACTED]
  tasks/plan.md → lib/core/storage/local_cache_service.dart
- `Phase 0 — Environment & Scaffolding` --references--> `SecureStorageService`  [EXTRACTED]
  tasks/plan.md → lib/core/storage/secure_storage_service.dart
- `Phase 6 — AI Recommendation Flow (headline feature)` --references--> `RecommendsRepository`  [EXTRACTED]
  tasks/plan.md → lib/data/repositories/recommends_repository.dart
- `tasks/plan.md — Implementation Plan` --references--> `AuthController`  [EXTRACTED]
  tasks/plan.md → lib/features/auth/controllers/auth_controller.dart

## Import Cycles
- None detected.

## Hyperedges (group relationships)
- **Design Tokens Kept Consistent Across Flutter and Future Compose App** — lib_app_theme_app_theme_apptheme, spec_specification, concept_poppins_font, rationale_design_token_v2_migration [INFERRED 0.75]
- **Leave Balances/Requests/Plan-Requests/Recommendations Vertical Slice** — tasks_plan_phase_3, tasks_plan_phase_4, tasks_plan_phase_5, tasks_plan_phase_6 [INFERRED 0.75]

## Communities (58 total, 10 thin omitted)

### Community 0 - "App Architecture & Design Rationale"
Cohesion: 0.06
Nodes (42): POST /api/v1/login/access-token (8-day session, no refresh), POST /login/test-token (session-restore validation), Material 3 + Single Seed Color Theme, POST /password-recovery/{email}, GET /recommends/leave-plan (AI Leave-Plan Recommender, headline feature), POST /reset-password/, Exception, hr-leave-management/frontend (existing React app, architectural reference) (+34 more)

### Community 1 - "Windows Runner: Flutter/Win32 Embedding"
Cohesion: 0.06
Nodes (54): FlutterViewController, PluginRegistry, Point, RECT, Size, unique_ptr, RegisterPlugins(), DartProject (+46 more)

### Community 2 - "GetX Routes, Pages & Middleware Registry"
Cohesion: 0.06
Nodes (33): app_routes.dart, auth_middleware.dart, ../../features/admin/views/admin_leave_balances_view.dart, ../../features/admin/views/admin_teams_view.dart, ../../features/admin/views/admin_users_view.dart, ../../features/admin/views/leave_types_view.dart, ../../features/admin/views/policies_view.dart, ../../features/approvals/bindings/approvals_binding.dart (+25 more)

### Community 3 - "Route Names & Token Storage"
Cohesion: 0.06
Nodes (32): FlutterSecureStorage, adminLeaveBalances, adminLeaveTypes, adminPolicies, adminTeams, adminUsers, approvals, dashboard (+24 more)

### Community 4 - "AuthController & DI Bindings"
Cohesion: 0.06
Nodes (31): ../../core/storage/local_cache_service.dart, ../../../core/storage/secure_storage_service.dart, ../../../data/models/user_model.dart, ../../../data/repositories/auth_repository.dart, ../../../data/repositories/leave_plan_requests_repository.dart, ../../../data/repositories/leave_requests_repository.dart, ../../../data/repositories/leave_types_repository.dart, ../../../data/repositories/recommends_repository.dart (+23 more)

### Community 5 - "Dio Client Auth Test Suite"
Cohesion: 0.06
Nodes (31): dart:typed_data, DioException, HttpClientAdapter, package:flutter_test/flutter_test.dart, package:hr_leave_management/core/errors/api_exception.dart, package:hr_leave_management/core/network/dio_client.dart, package:hr_leave_management/core/storage/secure_storage_service.dart, package:hr_leave_management/core/storage/token_storage.dart (+23 more)

### Community 6 - "Leave Requests Controller"
Cohesion: 0.08
Nodes (25): ../../../data/models/leave_type_model.dart, createRequest, currentRequest, deleteRequest, detailErrorMessage, errorMessage, fetchLeaveRequests, fetchLeaveTypes (+17 more)

### Community 7 - "Leave Recommendation Model & App Shell"
Cohesion: 0.09
Nodes (21): AuthController, LeavePlanRequestsRepository, LeaveRequestsRepository, approveLeavePlanRequest, approveLeaveRequest, _authController, errorMessage, _fetchAllLeavePlanRequests (+13 more)

### Community 8 - "App Theme & Design Tokens"
Cohesion: 0.05
Nodes (41): analysis_options.yaml — Dart Analyzer/Lint Config, cupertino_icons package, Dio HTTP Client, Figma Community HRMS Reference (qaCZJAA9Uca4nGziJ5wx9m), flutter_lints package, flutter_secure_storage package, GetStorage package, GetX (state mgmt / routing / DI) (+33 more)

### Community 9 - "Leave Plan Requests Controller"
Cohesion: 0.07
Nodes (26): createAndSubmitRequest, createRequest, currentRequest, deleteRequest, detailErrorMessage, errorMessage, fetchLeavePlanRequests, fetchLeaveTypes (+18 more)

### Community 10 - "Leave Plan Request Model"
Cohesion: 0.05
Nodes (40): DateTime, LeaveTypeSummary, amount, approvalAt, approver, approverId, description, details (+32 more)

### Community 11 - "Dashboard View"
Cohesion: 0.12
Nodes (16): _availableDaysSummary, balance, balances, build, data, error, _formatDays, icon (+8 more)

### Community 12 - "Leave Request Model"
Cohesion: 0.05
Nodes (39): leave_balance_model.dart, availableBalance, balance, code, fromJson, id, leaveType, LeaveTypeSummary (+31 more)

### Community 13 - "Leave Request Form View"
Cohesion: 0.11
Nodes (19): bool get, build, controller, createState, _descriptionController, dispose, _endDate, _formatDate (+11 more)

### Community 14 - "Leave Plan Request Form View"
Cohesion: 0.10
Nodes (20): _addPlannedDate, build, controller, createState, _descriptionController, dispose, _formatDate, _formKey (+12 more)

### Community 15 - "Balances/Recommends/Teams Repositories"
Cohesion: 0.17
Nodes (12): ../../../core/errors/api_exception.dart, Dio, _dio, fetchMyBalances, _dio, fetchRecommendations, _dio, fetchTeams (+4 more)

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
Cohesion: 0.13
Nodes (14): ../controllers/approvals_controller.dart, ../../../data/models/leave_plan_request_model.dart, ../../../data/models/leave_request_model.dart, ApprovalsBinding, dependencies, ApprovalsController, ApprovalsView, build (+6 more)

### Community 20 - "Leave Request Detail View"
Cohesion: 0.05
Nodes (43): app/bindings/initial_binding.dart, app/routes/app_pages.dart, ../../../app/theme/app_theme.dart, ../controllers/leave_requests_controller.dart, GetStorage, leave_request_detail_view.dart, leave_request_form_view.dart, _box (+35 more)

### Community 21 - "Leave Requests Repository"
Cohesion: 0.17
Nodes (11): approveLeaveRequest, createLeaveRequest, deleteLeaveRequest, _dio, fetchLeaveRequest, fetchLeaveRequests, LeaveRequestsRepository, rejectLeaveRequest (+3 more)

### Community 22 - "Admin & Approvals Placeholder Views"
Cohesion: 0.13
Nodes (14): AdminLeaveBalancesView, build, AdminTeamsView, build, AdminUsersView, build, build, LeaveTypesView (+6 more)

### Community 23 - "Windows Runner Utils & Main"
Cohesion: 0.24
Nodes (9): _In_, _In_opt_, vector, wWinMain(), string, wchar_t, CreateAndAttachConsole(), GetCommandLineArguments() (+1 more)

### Community 24 - "Leave Plan Requests Repository"
Cohesion: 0.15
Nodes (12): approveLeavePlanRequest, createLeavePlanRequest, deleteLeavePlanRequest, _dio, fetchLeavePlanRequest, fetchLeavePlanRequests, LeavePlanRequestsRepository, rejectLeavePlanRequest (+4 more)

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
Cohesion: 0.50
Nodes (3): ../controllers/leave_plan_requests_controller.dart, dependencies, LeavePlanRequestsController

### Community 30 - "User Model"
Cohesion: 0.20
Nodes (9): email, fromJson, fullName, id, isActive, isSuperuser, name, team (+1 more)

### Community 31 - "Leave View State Classes"
Cohesion: 0.27
Nodes (10): SplashView, _SplashViewState, LeavePlanRequestDetailView, _LeavePlanRequestDetailViewState, LeavePlanRequestFormView, _LeavePlanRequestFormViewState, LeavePlanRequestsView, _LeavePlanRequestsViewState (+2 more)

### Community 32 - "Dashboard Controller"
Cohesion: 0.22
Nodes (8): IconData, AppDrawer, build, icon, _initials, label, _NavTile, route

### Community 33 - "App Drawer Widget"
Cohesion: 0.06
Nodes (36): ../app/routes/app_routes.dart, Bindings, ../controllers/auth_controller.dart, ../controllers/dashboard_controller.dart, ../../../core/network/dio_client.dart, ../../../data/models/leave_balance_model.dart, ../../../data/repositories/leave_balances_repository.dart, FormState (+28 more)

### Community 34 - "Auth Repository"
Cohesion: 0.25
Nodes (7): _dio, fetchMe, login, recoverPassword, resetPassword, testToken, ../models/user_model.dart

### Community 36 - "Dio Client"
Cohesion: 0.25
Nodes (7): ../constants/env.dart, dio, onUnauthorized, _secureStorageService, package:flutter/foundation.dart, ../storage/token_storage.dart, VoidCallback

### Community 38 - "API Exception Handling"
Cohesion: 0.29
Nodes (7): DashboardView, _LeaveBalancesSection, _LeaveBalanceTile, _NavGridTile, _PlaceholderStatCard, _ProfileCard, StatelessWidget

### Community 39 - "Profile View"
Cohesion: 0.29
Nodes (6): ../../auth/controllers/auth_controller.dart, build, _InfoRow, label, value, ../../../widgets/app_shell_scaffold.dart

### Community 41 - "Team Model"
Cohesion: 0.33
Nodes (5): fromJson, id, name, TeamModel, teamOwnerId

### Community 42 - "Splash View"
Cohesion: 0.50
Nodes (3): apiBaseUrl, Env, static const String

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

### Community 54 - "Windows CMake Build Config"
Cohesion: 1.00
Nodes (3): windows/CMakeLists.txt — Windows Project Config, windows/flutter/CMakeLists.txt — Flutter Build Rules, windows/runner/CMakeLists.txt — Runner Executable Target

## Knowledge Gaps
- **497 isolated node(s):** `pages`, `dependencies`, `leaveRequestsRepository`, `leavePlanRequestsRepository`, `_authController` (+492 more)
  These have ≤1 connection - possible missing edges or undocumented components.
- **10 thin communities (<3 nodes) omitted from report** — run `graphify query` to explore isolated nodes.

## Suggested Questions
_Questions this graph is uniquely positioned to answer:_

- **Why does `tasks/plan.md — Implementation Plan` connect `App Architecture & Design Rationale` to `App Theme & Design Tokens`, `App Drawer Widget`?**
  _High betweenness centrality (0.059) - this node is a cross-community bridge._
- **Why does `SecureStorageService` connect `Route Names & Token Storage` to `App Architecture & Design Rationale`, `AuthController & DI Bindings`?**
  _High betweenness centrality (0.058) - this node is a cross-community bridge._
- **Why does `AuthController` connect `App Drawer Widget` to `Dashboard Controller`, `App Architecture & Design Rationale`, `GetX Routes, Pages & Middleware Registry`, `AuthController & DI Bindings`, `Dashboard View`?**
  _High betweenness centrality (0.037) - this node is a cross-community bridge._
- **What connects `pages`, `dependencies`, `leaveRequestsRepository` to the rest of the system?**
  _497 weakly-connected nodes found - possible documentation gaps or missing edges._
- **Should `App Architecture & Design Rationale` be split into smaller, more focused modules?**
  _Cohesion score 0.06312292358803986 - nodes in this community are weakly interconnected._
- **Should `Windows Runner: Flutter/Win32 Embedding` be split into smaller, more focused modules?**
  _Cohesion score 0.05683563748079877 - nodes in this community are weakly interconnected._
- **Should `GetX Routes, Pages & Middleware Registry` be split into smaller, more focused modules?**
  _Cohesion score 0.06031746031746032 - nodes in this community are weakly interconnected._