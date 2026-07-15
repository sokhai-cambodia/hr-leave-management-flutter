# HR Leave Management — Flutter Client — SPEC

## 1. Objective

A Flutter mobile client for the existing HR Leave Management system, built as the "Full Stack Developer" master's final project. It consumes the already-built FastAPI backend from `../hr-leave-management/backend` (API contract documented in `../hr-leave-management/PROJECT_FEATURES.md`) rather than a new Spring Boot backend — the guideline's official stack calls for Spring Boot, but this substitution is a deliberate, documented decision (see §7 Known Gaps vs. Guideline).

**Target users**, single app, role-adaptive UI:
- **Employee** (default role): view profile, leave balances, submit/track leave requests and leave plan requests, get AI-recommended leave dates.
- **Team owner / approver** (`current_user.team.team_owner`): everything an employee can do, plus an approvals queue (approve/reject pending requests from their team).
- **Superuser**: everything above, plus admin management of users, teams, leave types, public holidays, and policies.

The AI leave-plan recommender (`GET /recommends/leave-plan`) is a **headline feature** — get prominent placement (its own dashboard entry point and a dedicated recommendation → selection → submit flow), since it's the most distinctive part of the backend.

## 2. Tech Stack (per course guideline)

- **Flutter** (latest stable), Dart null-safety
- **GetX** — state management, routing, dependency injection
- **Dio** — HTTP client
- **flutter_secure_storage** — JWT access token storage
- **GetStorage** — lightweight local key-value cache (non-sensitive: e.g. last-viewed filters, theme)
- **JWT Bearer auth** against `POST /api/v1/login/access-token` (OAuth2 password flow, form-encoded body)

Backend base URL is configurable per environment (e.g. `http://10.0.2.2:8000` for Android emulator, `http://localhost:8000` for iOS simulator/web); default local backend runs on port 8000 with API prefix `/api/v1`.

## 3. Commands

- `flutter pub get` — install dependencies
- `flutter run` — run on connected device/emulator
- `flutter test` — run unit/widget tests
- `flutter analyze` — static analysis (must be clean before considering a task done)
- `dart format .` — formatting

## 4. Project Structure

Feature-first layout (standard for GetX projects):

```
lib/
  main.dart
  app/
    routes/            # GetX AppPages, AppRoutes route names
    bindings/           # global bindings (if any beyond per-feature)
    theme/               # ThemeData, colors, typography (light + dark)
  core/
    network/             # Dio client + interceptors (auth header, 401 handling)
    storage/              # secure storage + GetStorage wrappers
    errors/                # exception → user-facing message mapping
    constants/
  data/
    models/                # DTOs matching backend *Public / *Create / *Update shapes
    repositories/           # one per backend resource (auth, users, teams, leave_types,
                              # public_holidays, policies, leave_balances, leave_requests,
                              # leave_plan_requests, recommends)
  features/
    auth/                    # login, forgot/reset password
    dashboard/                # role-adaptive home
    leave_requests/            # list/detail/create/submit
    leave_plan_requests/        # list/detail/create/submit
    recommendations/             # AI recommender flow
    approvals/                    # team-owner approve/reject queue
    admin/                          # superuser: users/teams/leave-types/holidays/policies
    profile/
  widgets/                          # shared/reusable widgets
test/
  unit/
  widget/
```

Each `features/<x>/` follows GetX convention: `bindings/`, `controllers/`, `views/`.

## 5. Code Style

- Follow `flutter_lints` recommended rules (enable in `analysis_options.yaml`).
- Models are immutable data classes with `fromJson`/`toJson`; mirror backend field names exactly (see PROJECT_FEATURES.md §2–12) to avoid mapping bugs.
- No business logic in views — controllers/repositories only, per the guideline's "no business logic inside Activities/widgets" spirit.
- Meaningful names; no dead/commented-out code committed.

## 6. Testing Strategy

Per guideline, testing is "recommended" (manual) with unit tests as bonus — **not** the primary investment for this project.

- Primary: manual testing of all major flows during development and before demo.
- Minimal automated coverage: unit tests only for logic that's easy to get subtly wrong and hard to eyeball — e.g. JWT expiry/session handling, leave-balance/available-balance display math, duplicate-date validation before submit. No mandate for widget/integration test coverage.

## 7. Known Gaps vs. Guideline (decided, documented — not open questions)

| Guideline requirement | Backend reality | Decision |
|---|---|---|
| Backend: Java 21 + Spring Boot microservices | FastAPI (Python) monolith, already built | Reuse FastAPI as-is; report explicitly documents this substitution and rationale (existing working backend from a prior team project, focus effort on the Flutter client for this course) |
| Refresh Token flow | Only an 8-day access token from `/login/access-token`; no refresh endpoint | Treat the 8-day token as the session lifetime; re-prompt login on expiry (401). Documented in report as a backend limitation, not implemented client-side workaround |
| Audit Log | No audit-trail model/endpoint in backend | Out of scope for this project; noted as future work in report |

## 8. Feature List (maps to guideline's Functional Requirements)

- **Authentication**: login (OAuth2 password flow), logout (clear token), forgot password (`POST /password-recovery/{email}`), reset password (`POST /reset-password/`). No refresh token (§7).
- **User Management**: self profile view/edit (`GET/PATCH /users/me`), change password; superuser CRUD on all users (`/users`).
- **Dashboard**: role-adaptive summary — leave balances, and (team owners only) a tappable "Pending Approvals" count opening the Approvals queue directly, entry point to AI recommendations. No standalone "pending requests" (own-submissions) stat — removed as redundant with Pending Approvals (`tasks/plan.md` Task 11.4); the Leave Requests/Leave Plan Requests screens are the place to see your own submissions, and are themselves scoped to `owner_id` only (Task 11.4) so they never show other users' records regardless of role. Quick Actions grid intentionally omits Profile and Approvals — both reachable only via the drawer (Profile) or the Pending Approvals card + drawer (Approvals), to avoid duplicate nav surfaces (Tasks 10.2, 11.4). The "Recent Activity" placeholder stat card was removed (Task 10.3) rather than left permanently fake.
- **Master Data** (admin/superuser CRUD, search + pagination): Teams, Leave Types, Public Holidays, Policies, Leave Balances. Leave Balances admin CRUD (`owner_id` + `leave_type_id` relational pickers, `year` as a 4-digit string, `balance` decimal; `taken_balance`/`available_balance` are server-computed, not part of the create/update payload) lets a superuser adjust any employee's balance without touching Swagger UI — see `tasks/plan.md` Task 8.4 for the full field contract (useful reference for the parallel Android/Compose app, §9).
- **Schedule (employee view)**: month-view calendar (`table_calendar` package) showing both public holidays and the caller's team's approved leave, month-by-month navigation, backed by the combined `GET /schedule/?year&month` endpoint (server-side month-scoped, unlike the superseded Public Holidays-only screen it replaced — see `tasks/plan.md` Task 11.3). Two marker colors distinguish holidays from team leave on the calendar, with two separate list sections underneath; team-leave entries show the teammate's name and leave type. Replaces the Task 10.1 Public Holidays screen (`Routes.schedule`, was `Routes.publicHolidays`) — the reusable day-grouping logic shape is documented there for the Android/Compose equivalent, §9.
- **Business Module**: Leave Balances (self view on the dashboard; full CRUD across all employees for superusers, see Master Data above), Leave Requests (draft/submit/approve/reject lifecycle), Leave Plan Requests (multi-date, same lifecycle), AI Recommendation flow (`GET /recommends/leave-plan` → user selects dates → `POST /leave-plan-requests` → `PUT /{id}/submit`).
- **Notifications**: in-app notifications for the leave/leave-plan submit → approve/reject lifecycle (backend `Notification` model + `GET/PUT /notifications/*`, documented in `../hr-leave-management/PROJECT_FEATURES.md` §14). A bell icon + unread-count badge is baked into `AppShellScaffold` itself (every authenticated screen, not just Dashboard) rather than each screen opting in — polls `GET /notifications/unread-count` every 30s while logged in, starts/stops with the session lifecycle. Tapping a notification marks it read and opens the relevant list screen (Leave Requests or Leave Plan Requests, by `entity_type`) — not a deep link to the specific record, see `tasks/plan.md` Task 12.1. Written and integrated ahead of backend deployment; degrades gracefully (silent badge-poll failures, normal error+retry on the list) until the endpoint is live.
- **Audit Log**: out of scope (§7).

## 9. Design Tokens (shared brand, mirrored in the Android/Compose app)

Chosen for a minimal/clean, light-first look, adopted from reviewing a Figma Community HRMS reference (`figma.com/design/qaCZJAA9Uca4nGziJ5wx9m` — a Community file, published for reuse/inspiration; only the design direction was taken, not any copied assets). Implemented centrally in `lib/app/theme/app_theme.dart` so every screen inherits it automatically rather than being styled per-screen. Superseded an earlier dark/indigo/pill-button/filled-input direction (v1) after this reference was found to match what the user wanted better. Current values below are "redesign batch 3" (`feature/ui-redesign`) — a white-canvas + single red/coral accent direction inspired by a separate reference mockup; **Flutter-app-only as of this writing, not yet mirrored in the Android/Compose app** (see `STYLE_GUIDE.md` at repo root — a copy-pasteable version of this table for handing to the Android build).

| Token | Value |
|---|---|
| Accent/primary | `#E23744` (confident red/coral) |
| Primary dark (pressed/gradient end) | `#C01F2B` |
| Dark background / surface | `#121212` / `#1E1E1E` |
| Light background / surface | `#FFFFFF` / `#FFFFFF` |
| Light field fill | `#F7F7F9` |
| Light border | `#EAEAEE` |
| Danger / warning / success / info | `#EF4444` / `#F5A623` / `#22A659` / `#4C8DFF` |
| Status pastel formula | badge/stat-card background = status color blended at 14% alpha over white; foreground = full status color (one formula, not per-status hand-picked pairs) |
| Font | Poppins (via `google_fonts`; Compose side should use the Poppins downloadable/bundled font for parity) |
| Button shape | 14px corner radius, 54px min height, no elevation |
| Card shape | 18px corner radius, elevation 1, shadow at black 8% alpha |
| Text field shape | 12px corner radius, **outlined/bordered** (not filled-borderless), border color from `lightBorder`, 1.5px primary-colored focus border |
| Pill/tab indicator | full pill radius (999px) |
| Default theme mode | Light-first (dark mode available as a toggle) |
| Icons | Material "outlined" icon variants (no third-party icon pack — `iconly` was tried and is incompatible with current Flutter's `IconData` being a `final class`; reverted) |
| Dashboard navigation pattern | 2-column card grid of icon+label tiles (from the reference's Dashboard screen) rather than a plain list |
| Choice inputs | Segmented chip toggles for binary/small-set choices (e.g. Full day/AM/PM, Yes/No) — pattern from the reference's Leave Request form |

These same values (color hex, font, corner radii) should be re-used when building the Android/Jetpack Compose app's `MaterialTheme`, so the two apps present one consistent product despite being separate codebases.

## 10. Boundaries

- **Always**: run `flutter analyze` clean before marking a task done; keep models in sync with the documented API contract in `PROJECT_FEATURES.md`.
- **Ask first**: before pushing to the `origin` remote of this repo; before modifying anything in the `hr-leave-management` (backend/frontend) repo — this Flutter repo should only *consume* that API, not change it, unless a real gap is found and confirmed with the user.
- **Never**: commit secrets or `.env` files; hardcode the backend base URL only in one place (use env/config), not scattered through the codebase.
