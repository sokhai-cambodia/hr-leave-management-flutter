# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this is

Flutter mobile client for an HR Leave Management system (master's final-project "Full Stack Developer" course work). It consumes an already-built FastAPI backend at `../hr-leave-management/backend` rather than building a new one — a deliberate, documented substitution for the course's Spring Boot guideline (see `SPEC.md` §7).

**Read `SPEC.md` first** — it is the authoritative spec (tech stack, project structure, design tokens, decided gaps vs. the course guideline). **Read `tasks/plan.md`** for the full phase-by-phase implementation plan with verified backend ground truth (exact field names, status literals, endpoint shapes) and `tasks/todo.md` for current progress (checkbox state is the source of truth for what's built vs. pending).

## Commands

- `cp .env.example .env` — one-time setup; `.env` is gitignored (not a secret, just so each dev/emulator can point at their own backend URL) and is a required asset (`pubspec.yaml`), so **the build fails if it's missing** — a fresh clone must do this before the first `flutter run`/`flutter build` of any kind
- `flutter pub get` — install dependencies
- `flutter run -d windows` — fast dev-loop iteration (against `http://localhost:8000/api/v1`)
- `flutter run -d <android-device>` — Android is the primary/demo target (against `http://10.0.2.2:8000/api/v1`, the emulator's host-loopback address)
- Backend base URL resolution order (see `lib/core/constants/env.dart`): `--dart-define=API_BASE_URL=<url>` (highest precedence, e.g. CI) → `.env`'s `API_BASE_URL` (local dev convenience, edit this instead of retyping dart-define) → hardcoded default. Never hardcode the URL anywhere else.
- `flutter analyze` — static analysis; **must be clean before considering any task done**
- `flutter test` — run all unit/widget tests
- `flutter test test/unit/leave_balance_model_test.dart` — run a single test file
- `dart format .` — formatting

### Running the backend for manual verification

```
cd ../hr-leave-management && docker compose up -d
```
Brings up Postgres, the FastAPI backend (`http://localhost:8000`, API prefix `/api/v1`), Adminer, and Mailcatcher (SMTP capture at `http://localhost:1080`, needed for forgot/reset-password testing). Swagger UI at `http://localhost:8000/docs` is used to seed cross-user/cross-team test data (admin CRUD screens land last, in Phase 8). Superuser bootstrap credentials are `FIRST_SUPERUSER`/`FIRST_SUPERUSER_PASSWORD` in `../hr-leave-management/.env`.

## Architecture

Feature-first layout, standard GetX convention (state management, routing, DI). Each `lib/features/<x>/` has its own `bindings/`, `controllers/`, `views/` where needed (some simpler features skip bindings/controllers and read repositories directly).

- **`lib/core/network/dio_client.dart`** — the single `Dio` instance. Everything else depends on this being correct: base URL from `Env`, a request interceptor injecting the bearer token from secure storage, and a response interceptor that fires `onUnauthorized` on 401/403 *and* on the backend's 400 "Inactive user" shape (a deactivated account with a still-valid token). `onUnauthorized` is wired to `AuthController.forceLogout` in `InitialBinding` — don't add a second place that handles session invalidation.
- **`lib/core/errors/api_exception.dart`** — collapses FastAPI's two error response shapes (`detail: string`, and `detail: [{loc,msg,type}]` for 422 validation errors) into one readable exception. Every repository method wraps its Dio call in `try {...} on DioException catch (e) { throw ApiException.fromDioException(e); }` — follow this pattern for new repository methods.
- **`lib/app/bindings/initial_binding.dart`** — global DI root: storage services → `DioClient` → repositories → `AuthController` (which needs `TeamsRepository` for the team-owner heuristic below). Wired once in `main.dart`, not per-route.
- **`lib/app/routes/app_pages.dart`** + **`app_routes.dart`** — the GetX route table. Authenticated routes carry `middlewares: [AuthMiddleware()]`; superuser-only admin routes additionally carry `SuperuserMiddleware()`. `AuthMiddleware` redirects based on `AuthController.currentUser.value != null` (a reactive session flag), not by decoding the JWT client-side — there is no refresh-token endpoint, so 401 anywhere just forces re-login.
- **`lib/features/auth/controllers/auth_controller.dart`** — owns login/logout, session bootstrap (validates a stored token via `POST /login/test-token` on app start), and caches `currentUser`. Nearly every other feature reads this for role/owner-id checks.
- **`lib/data/repositories/teams_repository.dart`** — powers two different things: the team-owner detection heuristic in `AuthController` (see below) and the admin Teams CRUD screen.
- **`lib/data/models/`** — immutable DTOs with `fromJson`/`toJson` that mirror backend field names exactly (snake_case wire format, e.g. `start_date`, `leave_type_id`). Don't rename fields for Dart convention — mismatches here are a direct source of silent bugs against the FastAPI backend.

### Backend contract quirks that shape the code (verified against backend source, not just docs — see `tasks/plan.md` "Verified Backend Ground Truth")

- **No refresh token.** The access token from `POST /api/v1/login/access-token` is an 8-day session; any 401 means re-login, not silent refresh.
- **List endpoints** return `{data: [...], count: N}` with `skip`/`limit` params — modeled by `lib/data/models/paginated_result.dart`. **Exception:** `GET /recommends/leave-plan` returns `{leave_type_id, year, data: [...]}` with no `count` and isn't paginated — don't reuse `PaginatedResult` there.
- **Status literals** for `LeaveRequest`/`LeavePlanRequest` are exactly `"draft" | "pending" | "approved" | "rejected"`, lowercase — match these literally, don't re-encode as an enum with different casing.
- **"Team owner" is not a `User` field.** The only role flag on `User` is `is_superuser`. Whether the current user is a team owner (and thus sees the Approvals nav entry) is computed client-side in `AuthController` as `teams.any(t => t.teamOwner?.id == currentUser.id)`, fetched once per session — not derived from an "approvals list is non-empty" check (rejected: a team-owner with zero pending items would wrongly lose the nav entry).
- **Date fields are inconsistent on the wire**: some (e.g. `PublicHoliday.date`) are plain `"YYYY-MM-DD"` strings; others (leave request `start_date`/`end_date`, plan detail `leave_date`) are real date-typed fields. Model each per its actual backend type — don't assume uniformity across resources.
- **Leave Plan Request edit is full-replace**, not partial — always send the complete current date list, and reject duplicate dates client-side *before* any network call (see the dedupe function used by the plan-request form, which is unit-tested directly rather than buried in a widget callback).

## Design tokens

Centralized in `lib/app/theme/app_theme.dart` — every screen inherits it; don't style per-screen. Full token table (colors, corner radii, font) is in `SPEC.md` §9. These same values are meant to be mirrored in a separate Android/Jetpack Compose app for product consistency across the two codebases — if asked to change brand colors/shapes, that intent may extend beyond this repo, so check with the user.

## Testing strategy

Per `SPEC.md` §6, testing is manual-first; automated coverage is deliberately narrow — only for logic that's easy to get subtly wrong and hard to eyeball (JWT/session expiry handling, leave-balance display math, duplicate-date validation, 422 error flattening). Don't add broad widget/integration test coverage — it's explicitly out of scope for this project.

## Boundaries

- **Always** run `flutter analyze` clean before marking a task done; keep models in sync with the documented API contract in `../hr-leave-management/PROJECT_FEATURES.md` (readable summary) and the backend's actual model files (tiebreaker if anything's ambiguous).
- **Ask first** before pushing to `origin`; before modifying anything in the `../hr-leave-management` backend/frontend repo — this repo only *consumes* that API, it doesn't change it, unless a real backend gap is found and confirmed with the user.
- **Never** commit the `.env` file itself (gitignored; `.env.example` is the committed template) or other secrets; never hardcode the backend base URL outside `lib/core/constants/env.dart`.

## graphify

This project has a knowledge graph at graphify-out/ with god nodes, community structure, and cross-file relationships.

Rules:
- For codebase questions, first run `graphify query "<question>"` when graphify-out/graph.json exists. Use `graphify path "<A>" "<B>"` for relationships and `graphify explain "<concept>"` for focused concepts. These return a scoped subgraph, usually much smaller than GRAPH_REPORT.md or raw grep output.
- If graphify-out/wiki/index.md exists, use it for broad navigation instead of raw source browsing.
- Read graphify-out/GRAPH_REPORT.md only for broad architecture review or when query/path/explain do not surface enough context.
- After modifying code, run `graphify update .` to keep the graph current (AST-only, no API cost).
