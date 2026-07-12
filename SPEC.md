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
- **Dashboard**: role-adaptive summary — leave balances, pending requests, recent activity, entry point to AI recommendations; approvals count badge for team owners.
- **Master Data** (admin/superuser CRUD, search + pagination): Teams, Leave Types, Public Holidays, Policies.
- **Business Module**: Leave Balances (view), Leave Requests (draft/submit/approve/reject lifecycle), Leave Plan Requests (multi-date, same lifecycle), AI Recommendation flow (`GET /recommends/leave-plan` → user selects dates → `POST /leave-plan-requests` → `PUT /{id}/submit`).
- **Audit Log**: out of scope (§7).

## 9. Boundaries

- **Always**: run `flutter analyze` clean before marking a task done; keep models in sync with the documented API contract in `PROJECT_FEATURES.md`.
- **Ask first**: before pushing to the `origin` remote of this repo; before modifying anything in the `hr-leave-management` (backend/frontend) repo — this Flutter repo should only *consume* that API, not change it, unless a real gap is found and confirmed with the user.
- **Never**: commit secrets or `.env` files; hardcode the backend base URL only in one place (use env/config), not scattered through the codebase.
