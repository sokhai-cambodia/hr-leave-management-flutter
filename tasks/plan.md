# HR Leave Management — Flutter Client — Implementation Plan

## Context

`hr-leave-management-flutter` is currently empty (branch `feature/flutter-setup`, only `SPEC.md` committed-to-be). This plan breaks the build into vertically-sliced, demoable tasks so each one produces something real running against the existing FastAPI backend (`../hr-leave-management/backend`, contract in `../hr-leave-management/PROJECT_FEATURES.md`), rather than horizontal layers (all models, then all screens, etc.). It's grounded in two research passes: one verifying exact backend schema shapes/field names/status literals against the actual code (not just docs), and one designing the task sequence against that ground truth plus the existing React frontend's proven patterns (auth interceptor, 401 handling, route guarding, role branching).

Decisions already confirmed with the user this session:
- **No self-signup screen** — admins provision all accounts via the Phase 8 admin Users screen, matching the existing React app.
- **Android is the primary/demo target** — Windows desktop is for fast dev-loop iteration only; iOS is not built (no Mac available).
- **Admin CRUD (Phase 8) stays last** — Phases 3–7 seed test data manually via the backend's Swagger UI (`/docs`) in the meantime.

A few smaller implementation choices are decided here (not asked, since they're either technically forced or low-stakes defaults easy to change later) — flagged inline where they occur: team-owner detection heuristic (Phase 2), generic-then-applied CRUD pattern (Phase 8), manual reset-token paste (Phase 1, no deep-linking in scope), infinite-scroll pagination at page size 20, two-tab Approvals layout, Material 3 + single seed color + light/dark theme.

## Verified Backend Ground Truth

- **Auth**: `POST /api/v1/login/access-token` (OAuth2 form-urlencoded: `username`=email, `password`) → `{access_token, token_type: "bearer"}`. `POST /login/test-token` validates a token and returns `UserPublic` — use for session-restore on app start. `POST /password-recovery/{email}`, `POST /reset-password/` (`{token, new_password}`). **No refresh-token endpoint exists** — re-login on 401/expiry is correct, not a shortcut.
- **List endpoints**: all wrap `{data: [...], count: N}`, params `skip`/`limit` (default 0/100, no enforced max). **Exception**: `GET /recommends/leave-plan?year=` returns `{leave_type_id, year, data: [...]}` — no `count`, not paginated, single object.
- **Status literals** (LeaveRequest & LeavePlanRequest, confirmed in code not just docs): exactly `"draft" | "pending" | "approved" | "rejected"`, lowercase.
- **"Team owner" is not a `User` field.** The only real role flag on `User` is `is_superuser`. Approver status is derived per-team via `Team.team_owner_id`/`team_owner`. Flutter must compute "am I a team owner" client-side (see Phase 2).
- **Presentable (nested/trimmed) shapes**: `UserPresentable {id, full_name, email}`, `TeamPresentable {id, name, team_owner: UserPresentable|null}`, `LeaveTypePresentable {id, code, name}` — these appear nested inside other resources, not the full resource.
- **PublicHoliday.date and other date-like backend strings**: stored/transmitted as plain `"YYYY-MM-DD"` strings in some places (public holidays) vs real `date` types in others (leave request start/end, plan detail leave_date) — model each per its actual backend type, don't assume uniformity.
- **Policy.operation/value**: free-form strings (`in`, `>`, `<`, `>=`, `<=`, `==` / `"[0,4]"`, `"50%"`), not enums — no client-side validation beyond "non-empty."
- Full per-resource field lists (User, Team, LeaveType, PublicHoliday, Policy, LeaveBalance, LeaveRequest, LeavePlanRequest+Detail, Recommends) were verified line-by-line against `backend/app/models.py` and `backend/app/leave_models/*.py` — treat `PROJECT_FEATURES.md` as the readable summary and the actual model files as the tiebreaker if anything's ambiguous while building.

## Reference Patterns from the Existing React Frontend (architectural parity, not literal translation)

- `frontend/src/main.tsx`: global API base URL + a token-resolver function injected as bearer auth per request → Dio equivalent is a single `InterceptorsWrapper` reading from `flutter_secure_storage` in `onRequest`.
- Global 401/403 handling: clear stored token + force-navigate to login on any such response → replicate as a Dio response interceptor + `Get.offAllNamed('/login')`, guarded against double-firing from concurrent in-flight requests.
- Route guarding: authenticated routes check "is a token present" before entry (not JWT-decoded expiry) → GetX `GetMiddleware` equivalent.
- One controller owns login/logout + fetches/caches current user after login.
- The *entire* existing "role-based UI" is one boolean branch on `is_superuser` for sidebar items (superuser gets extra admin links). There is **no** team-owner-specific UI anywhere in the existing app — Flutter adds this itself (Phase 2).

## Standard Verification Environment (used by every task below)

- `cd ../hr-leave-management && docker compose up -d` — Postgres, backend (`http://localhost:8000`, prefix `/api/v1`), Adminer, Mailcatcher (SMTP capture at `http://localhost:1080`, needed for Phase 1's forgot/reset-password task).
- Swagger UI at `http://localhost:8000/docs` — used to seed cross-user/cross-team test data before the screens that create it exist yet (Phases 3–7, since admin CRUD is last).
- Superuser bootstrap login: `FIRST_SUPERUSER`/`FIRST_SUPERUSER_PASSWORD` from `../hr-leave-management/.env`.
- Dev iteration: `flutter run -d windows` against `http://localhost:8000/api/v1`. Demo target: Android emulator against `http://10.0.2.2:8000/api/v1`. Base URL injected once via `--dart-define=API_BASE_URL=...`, read from one config file — never hardcoded elsewhere.
- Per-resource example payloads already exist at `../hr-leave-management/frontend/api-docs/*.md` if a request/response shape needs double-checking beyond this plan.

---

## Phase 0 — Environment & Scaffolding

### Task 0.1 — Project scaffold, dependencies, folder skeleton, lint
- **Depends on:** nothing
- Scaffold via `flutter create`; add `get`, `dio`, `flutter_secure_storage`, `get_storage`; build the full `lib/app|core|data|features|widgets` skeleton per SPEC §4 (placeholder files OK); enable `flutter_lints`; add `core/constants/env.dart` reading `String.fromEnvironment('API_BASE_URL', defaultValue: 'http://10.0.2.2:8000/api/v1')`.
- **Acceptance:** `flutter analyze` clean; `flutter pub get` succeeds; folder tree matches SPEC §4; app launches to a placeholder screen.
- **Verify:** `flutter run -d windows` (or Android emulator) launches without error.

### Task 0.2 — Core network/storage infra + connectivity smoke test
- **Depends on:** 0.1
- `core/storage/secure_storage_service.dart` (token get/set/delete), `core/storage/local_cache_service.dart` (GetStorage wrapper); `core/network/dio_client.dart` (single Dio instance, base URL from env, auth-header interceptor, 401/403 stub for Task 1.2); `core/errors/api_exception.dart` mapping FastAPI's two error shapes (`detail: string` and `detail: [{loc,msg,type}]` for 422) into one readable string; a throwaway smoke screen calling `GET /utils/health-check/`.
- **Acceptance:** smoke screen shows true/false correctly; unit test on the error mapper for the 422-list shape.
- **Verify:** backend up → `true`; `docker compose stop backend` → graceful failure message, no crash.

**Checkpoint 0** — confirm the dev workflow/device before building UI on top of it.

---

## Phase 1 — Auth & Session

### Task 1.1 — Login + token storage + current-user fetch + minimal authenticated screen
- **Depends on:** 0.2
- `data/models/user_model.dart`, `data/repositories/auth_repository.dart` (`login()`, `fetchMe()`), `features/auth/controllers/auth_controller.dart`, `features/auth/views/login_view.dart`, minimal post-login welcome screen.
- **Acceptance:** valid creds → token persisted, `/users/me` cached, navigate; invalid creds → backend message shown, no nav; logout clears token; password obscured; login button disabled mid-request.
- **Verify:** log in as `FIRST_SUPERUSER`; confirm welcome screen shows correct email; log out.

### Task 1.2 — Session bootstrap + global 401/403 handling
- **Depends on:** 1.1
- App-start bootstrap: stored token → `POST /login/test-token` validate → route to shell or clear+`/login`. Complete the Dio interceptor: any 401/403 → clear token, `Get.offAllNamed('/login')`, guarded against concurrent double-fire. `AuthMiddleware extends GetMiddleware` redirecting unauthenticated access to `/login`.
- **Acceptance:** no token → opens straight to login, never flashes authenticated UI; kill+relaunch while logged in → restores session; corrupt/deactivate the token's user → next API call anywhere triggers forced logout, not a silent failure.
- **Verify:** restart test; then via `/docs` deactivate the test user, trigger any authenticated call, confirm forced logout.

### Task 1.3 — Forgot password + reset password
- **Depends on:** 1.1
- `AuthRepository.recoverPassword/resetPassword`; two views off the login screen. Reset screen uses a manual "paste your reset token" field (no deep-linking in scope — decided, not open).
- **Acceptance:** known email → success state; unknown → backend's 404 surfaced; valid token+new password → can log in with it; invalid/expired token → backend's message shown.
- **Verify:** with Mailcatcher running, trigger recovery, open `http://localhost:1080`, copy token from the captured email, complete reset, log in with the new password.

**Checkpoint 1** — full auth lifecycle demoable against the real backend.

---

## Phase 2 — App Shell, Role-Adaptive Navigation, Dashboard

### Task 2.1 — App shell + GetX routing + static role-based nav (superuser branch)
- **Depends on:** 1.2
- `app/routes/app_pages.dart`/`app_routes.dart`, per-feature bindings, persistent shell (drawer/bottom-nav) listing: Dashboard, Public Holidays, Leave Plan Requests, Leave Requests, Recommendations, Approvals *(hidden pending 2.2)*, Settings/Profile — plus, only for `is_superuser`: Policies, Leave Types, Teams, Leave Balances(admin), Admin Users. Dashboard: profile card (name/email/team) + placeholder cards for balances/pending/recent (wired live in later phases).
- **Acceptance:** superuser sees full menu; plain employee sees baseline only; every entry navigates somewhere real (no dead taps); "No team assigned" shown when `team == null`.
- **Verify:** compare menus between `FIRST_SUPERUSER` login and a freshly created plain employee (create via `/docs`).

### Task 2.2 — Team-owner detection + Approvals nav entry
- **Depends on:** 2.1
- `data/repositories/teams_repository.dart` (`GET /teams`, open to any authenticated user — no superuser gate). At dashboard bootstrap, fetch teams once per session and compute `isApprover = teams.any(t => t.teamOwner?.id == currentUser.id)`; cache for the session; show/hide Approvals nav accordingly. *(Decided: this is the only viable heuristic given no direct `is_team_owner` flag — an "Approvals list happens to be non-empty" heuristic was considered and rejected, since a team-owner with zero pending items would wrongly lose the nav entry.)*
- **Acceptance:** team-owning user sees "Approvals"; non-owning user doesn't; check runs once per session, not per screen.
- **Verify:** via `/docs`, set a test employee as a team's `team_owner_id`, confirm the entry appears for them and not for another employee.

**Checkpoint 2** — role-adaptive shell demoable with 3 test accounts (superuser, team-owner, plain employee).

---

## Phase 3 — Leave Balances

### Task 3.1 — Leave balances list, wired into dashboard
- **Depends on:** 2.2
- `data/models/leave_balance_model.dart`, `data/repositories/leave_balances_repository.dart`. Employee-facing screen lives under `features/dashboard/` (SPEC's feature folders don't include a dedicated `leave_balances` folder — admin CRUD version of this resource lives under `features/admin/` in Phase 8 instead). List: leave type, `balance`, `taken_balance`, `available_balance` (trusted from server, not recomputed), filtered by year. Wire the dashboard's placeholder balances card to real data.
- **Acceptance:** numbers match `/docs`; unit test on the model parsing the three balance fields (SPEC §6 explicitly calls this out); empty state handled.
- **Verify:** seed balances via `/docs` as superuser if none exist; confirm match; confirm empty state for a user with none.

**Checkpoint 3.**

---

## Phase 4 — Leave Requests (owner lifecycle)

### Task 4.1 — List + detail (read-only)
- **Depends on:** 3.1
- `data/models/leave_request_model.dart` (incl. nested `owner`/`leave_type`/`approver`, `status`), repository, list with status-colored chips, infinite-scroll (page size 20 — decided default), detail view.
- **Acceptance:** list shows only own requests (server-scoped); tapping opens correct detail; status chip colors distinct per state.
- **Verify:** seed 2–3 requests in varying statuses via `/docs`.

### Task 4.2 — Create draft, edit, delete (draft-only)
- **Depends on:** 4.1
- Create form (leave type dropdown, start/end date pickers, description); edit reuses form; delete with confirmation. Hide/disable edit/delete for non-draft as UX nicety, but the backend's 400 on illegal transitions is the real guard and must surface cleanly.
- **Acceptance:** create → draft row appears; edit persists; delete removes; attempting illegal edit/delete on non-draft is handled gracefully, not a crash.
- **Verify:** full create/edit/delete loop; seed a `pending` request via `/docs`, try editing it in-app, confirm graceful rejection.

### Task 4.3 — Submit action + balance-debit visibility
- **Depends on:** 4.2
- "Submit" on a draft's detail → `PUT /{id}/submit`. Handle the "no line approver" failure with a friendly message ("You don't have a line approver assigned yet, contact an admin") — a real, likely-to-be-hit case during testing.
- **Acceptance:** valid submit → `pending` + `approver_id` assigned; no-approver submit → friendly error, not a crash; balances screen reflects the debit after submit (cross-slice check).
- **Verify:** ensure the test employee's team has a `team_owner_id` (from 2.2's seeding); submit; check balances screen for the debit.

**Checkpoint 4** — full owner-side leave-request lifecycle including the cross-cutting balance effect.

---

## Phase 5 — Leave Plan Requests (multi-date lifecycle)

Kept separate from Phase 4 (not folded in) because the create/edit form is materially different (a date *set*, not a range), and because Phase 6 depends on its create/detail screens directly.

### Task 5.1 — List + detail (detail = list of dates)
- **Depends on:** 4.3
- `data/models/leave_plan_request_model.dart` (`details: [{id, leave_date}]`, `amount = details.length`), repository, list + detail (scrollable date chips, sorted).
- **Acceptance:** matches `/docs`; `amount == details.length`.
- **Verify:** seed a 3-date plan request via `/docs`.

### Task 5.2 — Create/edit (multi-date picker, duplicate guard) + delete
- **Depends on:** 5.1
- Create form: leave-type dropdown filtered to `is_allow_plan == true`; date picker that adds to a running chip list (removable); **client-side duplicate-date rejection as a pure, directly-testable function** (not buried in a widget callback — SPEC §6 flags this as worth a unit test). Edit sends the full current date list (backend is full-replace, not partial). Delete with confirmation, draft-only.
- **Acceptance:** duplicate date blocked client-side before any network call; valid multi-date create succeeds; unit test exercises the dedupe function directly.
- **Verify:** try adding a duplicate date in-app, confirm no network call fires and a message appears; create a valid draft, confirm it in 5.1's list.

### Task 5.3 — Submit action
- **Depends on:** 5.2
- Mirrors 4.3's submit + friendly no-approver error. No balance-debit here (plan requests don't touch balances on submit).
- **Acceptance:** submit → `pending` + approver assigned; balances screen explicitly verified *unaffected* (don't assume parity with Phase 4).
- **Verify:** submit, confirm status change, confirm balances unchanged before/after.

**Checkpoint 5.**

---

## Phase 6 — AI Recommendation Flow (headline feature)

### Task 6.1 — Fetch & display recommendations
- **Depends on:** 5.3, 3.1
- `data/models/leave_recommendation_model.dart` (distinct shape: `{leave_type_id, year, data: [...]}`, **not** the `{data, count}` wrapper), `data/repositories/recommends_repository.dart`. View: year selector, list of dates with `predicted_score`, `bridge_holiday`/`team_workload` badges. Both documented 404 cases ("no plannable leave type" vs "no remaining balance") return the same HTTP status — **surface the backend's actual detail message**, don't collapse both into one generic "not found."
- **Acceptance:** chronological order preserved (no client re-sort corrupting server order); both 404 cases show distinguishable messages; year change re-fetches.
- **Verify:** normal case renders plausible scores; zero-balance user shows the specific empty state; no-plannable-type case shows the other specific empty state.

### Task 6.2 — Selection UI → build plan-request draft
- **Depends on:** 6.1
- Multi-select checkboxes + "select all"; "Use selected dates" navigates into 5.2's create form, pre-populated (still editable there — reuses 5.2's logic, not a fork).
- **Acceptance:** selecting N dates lands on the create form with exactly those N, removable; leave type pre-set from the recommendation.
- **Verify:** select 4, proceed, confirm 4 pre-filled, remove 1, confirm 3 remain.

### Task 6.3 — One-tap create & submit, success state
- **Depends on:** 6.2
- Pre-filled create form offers both "Save draft" (5.2 behavior) and "Submit now" (chains create then submit in one gesture); success state links to the new plan request's detail (5.1).
- **Acceptance:** "Submit now" → `pending` plan request matching selection; failure mid-chain (create OK, submit fails for no-approver) leaves the draft intact and reachable, with a clear error — not silently lost.
- **Verify:** full run: select 3 → Submit now → confirm `pending`. Then simulate the failure branch (temporarily unset team_owner) and confirm the draft survives with a clear error.

**Checkpoint 6** — the full recommend→select→submit path works end-to-end. This is the scene to record for the report/demo.

---

## Phase 7 — Approvals Queue (team-owner role)

### Task 7.1 — Approvals list (two tabs) + approve/reject
- **Depends on:** 4.3, 5.3, 2.2
- Reuse Phase 4/5's repositories/models — filter client-side to `status == 'pending' && approver_id == currentUser.id`. Two tabs, "Leave Requests" / "Leave Plans" (decided default — simpler than one merged polymorphic list). Approve/Reject actions; reject requires confirmation (more consequential).
- **Acceptance:** team-owner sees only pending rows where they're the assigned approver (not their own submissions, not other teams'); approve/reject transitions status and removes from queue; **Leave Request** reject credits balance back (cross-check Phase 3); **Leave Plan Request** reject does not touch balances (verify explicitly).
- **Verify (needs cross-user seeding via `/docs`, since admin UI is Phase 8):** team with `team_owner_id` set; a second user on that team submits one of each request type; team-owner approves one, rejects the other; confirm the balance effects match the table above.

**Checkpoint 7** — two-sided workflow (submitter + approver, two logged-in test accounts) fully demoable.

---

## Phase 8 — Admin/Superuser Master Data CRUD

Sliced as pattern-then-apply across 6 resources, not 6 near-duplicate tasks.

### Task 8.1 — Generic CRUD scaffold, proven on Leave Types
- **Depends on:** 2.1
- Generic paginated/searchable list widget (reusing 4.1's infinite-scroll pattern) + generic form-dialog builder driven by a small per-resource field-spec (label/type/validators). Applied first to Leave Types (`code, name, entitlement, description?, is_allow_plan, is_active` — simplest case, no relational fields).
- **Acceptance:** superuser full CRUD loop on Leave Types entirely in-app; non-superuser can't reach the route; adding a second resource in 8.2 requires no changes to the generic widgets, only new field-specs/repositories.
- **Verify:** full CRUD loop as superuser; route unreachable as plain employee.

### Task 8.2 — Apply pattern: Public Holidays, Policies
- **Depends on:** 8.1
- Public Holidays (`date` as a plain `"YYYY-MM-DD"` string on the wire, not a `DateTime`-typed field — only the picker UI treats it as a date). Policies (`operation`/`value` as opaque free-form strings, no client-side enum validation).
- **Acceptance:** both resources full CRUD; holiday dates round-trip exactly (verify via `/docs`, no silent reformatting); policy free-form fields accept arbitrary strings.
- **Verify:** CRUD loop on each; cross-check one record's raw JSON via `/docs`.

### Task 8.3 — Apply pattern: Teams, Users (relational pickers)
- **Depends on:** 8.1
- Teams (`team_owner_id` needs a searchable user-picker, not raw UUID entry). Users (`password` required on create, optional on edit; `team_id` uses the same team-picker). This is where the pattern extends with a relational-picker field type.
- **Acceptance:** team creation lets you pick an existing user as owner via search; user creation requires password, edit doesn't; assigning `team_id`/`team_owner_id` in-app is reflected on next login — **closes the loop**: an employee assigned as a team owner via this screen becomes eligible for the Phase 2.2 Approvals nav entry without touching `/docs`.
- **Verify:** create a team in-app, assign an existing employee as owner; log in as that employee, confirm Approvals now appears (no Swagger UI needed).

### Task 8.4 — Apply pattern: Leave Balances (admin) + fix missing Public Holidays nav entry
- **Depends on:** 8.1
- **Found gap (post-Checkpoint-8 manual test):** 2.1's nav plan always listed `Leave Balances(admin)` for superusers and the dashboard tile existed, but no 8.1-8.3 task actually implemented it — `AdminLeaveBalancesView` shipped as an unwired `PlaceholderScreen`, and `Routes.adminLeaveBalances` had no binding, so opening it would have crashed on `Get.find()`. Separately, `AdminPublicHolidaysView` from 8.2 was fully implemented and routed but had no dashboard nav entry pointing at it — only the (still-placeholder) employee-facing `PublicHolidaysView` tile existed, so a superuser had no in-app way to reach the admin CRUD screen at all.
- Leave Balances CRUD: `owner_id` and `leave_type_id` both use the Task 8.3 relational-picker pattern (employee picker via `UsersRepository`, leave-type picker via `LeaveTypesRepository.fetchLeaveTypes()`); `year` is a plain 4-digit string field (matches the backend's `str`-typed column, not numeric); `balance` is decimal. `taken_balance`/`available_balance` are server-computed and not part of the create/update payload. Backend endpoints: `GET/POST /leave-balances/`, `PUT/DELETE /leave-balances/{id}` (list is not superuser-gated server-side, unusually — every other admin list is — the Flutter route still gates it client-side via `SuperuserMiddleware`, matching the pattern for the other 5 resources). `LeaveBalanceModel` extended with nullable `ownerId`/`owner` (a `UserSummary`) since the existing `/leave-balances/me` self-view path doesn't need them.
- Public Holidays nav: added a superuser-only "Manage Public Holidays" dashboard tile pointing at the existing `Routes.adminPublicHolidays`, distinct from the general "Public Holidays" tile (still a placeholder for all roles — a separate, still-open gap, not part of this fix).
- **Acceptance:** superuser full CRUD loop on Leave Balances entirely in-app (create/edit/delete a balance for any employee); "Manage Public Holidays" reachable from the dashboard and functional; non-superuser can't reach either route.
- **Verify:** `flutter analyze` clean; `flutter test` green (pre-existing `dio_client_unauthorized_test.dart` DotEnv-init failures are unrelated/pre-existing, not caused by this task); manual CRUD loop as superuser on both screens.

**Checkpoint 8** — all 6 admin resources CRUD-able in-app; team-owner assignment loop fully closed in-app.

---

## Phase 9 — Hardening & Report-Readiness

### Task 9.1 — Targeted unit tests (per SPEC §6, not broad coverage)
- **Depends on:** all functional phases (can start incrementally, finalized here)
- Cover exactly: 401-triggers-logout (mock Dio adapter returning 401), available-balance model parsing (3.1), leave-plan duplicate-date validation (5.2), 422 error-message flattening (0.2). No broad widget/integration suite — SPEC explicitly doesn't mandate it.
- **Acceptance:** `flutter test` passes; each test targets a named risk area, not incidental/tautological coverage.
- **Verify:** `flutter test` green; spot-review each test's assertion actually exercises its claimed risk.

### Task 9.2 — Analyze-clean pass + empty/error/loading state audit + feature checklist walkthrough
- **Depends on:** 9.1
- `flutter analyze` to zero issues repo-wide; walk every list/detail/form screen from Phases 3–8 confirming explicit loading/empty/error states (easy to accumulate gaps in across 8 phases of happy-path-first building); final pass against SPEC §8's feature list as a literal checklist.
- **Acceptance:** `flutter analyze` clean; every screen demonstrably handles all three states (verify by stopping the backend mid-session); SPEC §8 checklist fully checked or explicitly annotated as a known gap.
- **Verify:** `docker compose stop backend` mid-session, confirm no screen shows a blank/unhandled-error page; restart backend, confirm recovery without app relaunch.

---

## Phase 10 — Post-Launch Enhancements (after Checkpoint 9)

### Task 10.1 — Employee Public Holidays month-calendar view
- **Depends on:** 2.1 (route existed, unimplemented — `PublicHolidaysView` shipped in Phase 2 as a `PlaceholderScreen` and was never revisited in Phase 3-9's happy-path build-out)
- Replaced the placeholder with a real month-view calendar using the `table_calendar` package (`^3.2.0`, added via `flutter pub add table_calendar`; pulls in `intl`/`simple_gesture_detector` transitively — no direct `intl` usage added elsewhere in the app, month/date headings are still formatted manually to match this codebase's existing convention). New files: `lib/features/public_holidays/controllers/public_holidays_controller.dart`, `lib/features/public_holidays/bindings/public_holidays_binding.dart`, rewritten `lib/features/public_holidays/views/public_holidays_view.dart`.
- No server-side month/year filter exists on `GET /public-holidays/` (only `skip`/`limit`), so the controller fetches once with a generous `limit` (500) on `onInit` — same "small master-data table, fetch once" precedent as `TeamsAdminController._loadUserOptions`. Two pure/static functions do the client-side work, unit-tested directly (no GetX bootstrap needed), same spirit as `LeavePlanRequestsController.isDuplicateDate`: `PublicHolidaysController.groupByDay(List<PublicHolidayModel>) → Map<DateTime, List<PublicHolidayModel>>` (day-normalized, feeds the calendar's `eventLoader` for marker dots) and `PublicHolidaysController.holidaysInMonth(List<PublicHolidayModel>, DateTime) → List<PublicHolidayModel>` (feeds the list section below the calendar). `PublicHolidayModel.date` stays a `String` throughout — `DateTime.parse` is only used transiently for grouping/display, never round-tripped back to the wire.
- UI: `TableCalendar<PublicHolidayModel>` themed with existing tokens (`AppColors.primary` for today, `AppColors.warning` for holiday marker dots, `formatButtonVisible: false`, centered header) inside a `Card`; below it, a heading for the visible month plus a `Column` of `Card`s (mirroring `LeaveRequestsView._buildRequestCard`'s inline shape) listing that month's holidays, or an empty-state message.
- Route: `Routes.publicHolidays` in `lib/app/routes/app_pages.dart` gained a `binding: PublicHolidaysBinding()` (previously had none).
- **For Android/Compose parity:** the two pure grouping/filtering functions above are the reusable "logic," independent of `table_calendar`'s specific widget API — any calendar/month-view component on the Android side needs equivalent day-grouping and month-filtering over the same `GET /public-holidays/` payload shape (`id`, `date` as `"YYYY-MM-DD"`, `name`, `description?`).
- **Acceptance:** calendar renders holiday markers; month navigation (prev/next) works; list below matches the visible month; `flutter analyze` clean; `flutter test` green (new `test/unit/public_holidays_test.dart` covers both pure functions, including a Dec 31/Jan 1 year-boundary case).
- **Verify:** manual — Dashboard → Public Holidays as a logged-in employee on the physical test device; confirm markers, navigation, and list all agree; admin's separate "Manage Public Holidays" CRUD screen (Task 8.4) spot-checked unaffected.

### Task 10.2 — Remove redundant Profile tile from Dashboard Quick Actions
- **Depends on:** 2.1
- `Routes.profile` was reachable two ways: the Dashboard's Quick Actions grid tile and the drawer's "Settings / Profile" entry (`lib/widgets/app_drawer.dart`). Removed the Quick Actions duplicate (`lib/features/dashboard/views/dashboard_view.dart`) — Profile remains reachable via the drawer only.
- **For Android/Compose parity:** if the Android dashboard mirrors this Quick Actions grid, don't include a Profile tile there either — keep account/profile access to a single nav surface (equivalent of the drawer) to avoid the same duplication.
- **Acceptance:** Profile no longer appears in Quick Actions; still reachable from the drawer.
- **Verify:** manual — confirm on the physical test device.

### Task 10.3 — Remove "Recent Activity" placeholder stat card
- **Depends on:** 2.1
- `dashboard_view.dart`'s "Recent Activity" `_PlaceholderStatCard` was hardcoded to always show `'Nothing yet'`, never wired to any data (SPEC §8 listed it as an intended feature, but Phase 3-9 never implemented it). Removed the card rather than leave a permanently-fake stat on screen.
- **Acceptance:** Dashboard no longer shows a "Recent Activity" card.
- **Verify:** manual — confirm on the physical test device.

### Task 10.4 — Wire "Pending Requests" dashboard stat to real data
- **Depends on:** 2.1, 4.x, 5.x
- The "Pending Requests" card was the other hardcoded placeholder (`value: '—'`) next to "Available Days". Wired it to a real count: the current employee's **own** submissions (`ownerId == currentUser.id`) across both `LeaveRequestModel`/`LeavePlanRequestModel` with `status == 'pending'` — distinct from the separate Approvals queue, which is items awaiting *their* approval as a team owner.
- No backend filter/count endpoint exists for this (see Phase 11 below — this is exactly the gap Phase 11 proposes fixing), so `DashboardController.fetchPendingRequestsCount()` walks every page of `GET /leave-requests/` and `GET /leave-plan-requests/` and filters client-side, same pattern/rationale as `ApprovalsController.fetchApprovals()` (`_fetchAllLeaveRequests`/`_fetchAllLeavePlanRequests` page-walking helpers, duplicated here rather than shared since each controller's filter predicate differs — `ownerId` here vs. `approverId` in Approvals). `DashboardController` gained `leaveRequestsRepository`/`leavePlanRequestsRepository` constructor deps (already globally registered in `initial_binding.dart`, just newly injected here) and `_authController = Get.find<AuthController>()` for `currentUser.id`.
- **Once Phase 11's `GET /leave-requests/?owner_id={me}&status=pending&limit=1` (+ leave-plan equivalent) lands:** replace the page-walking with two cheap `count`-only calls, dropping `_fetchAllLeaveRequests`/`_fetchAllLeavePlanRequests` from this controller entirely.
- **Acceptance:** card shows a real number (own pending submissions only, not team/approver items); `flutter analyze` clean.
- **Verify:** manual — confirm the count matches the employee's actual pending submissions on the physical test device.
- **Superseded by Task 11.4:** the "Pending Requests" card was later removed outright in favor of "Pending Approvals" taking its place in the row — kept here for history, not reflecting final state.

---

## Phase 11 — Backend API Enhancements + Flutter Integration

Per this repo's boundary (Flutter only *consumes* the backend API, doesn't change it, `CLAUDE.md`) backend work happens in the sibling `../hr-leave-management` repo — recorded here for tracking and as a reference for the parallel Android/Compose app's equivalent needs. **Backend implemented and deployed (Render); Flutter-side integration complete.**

### Task 11.1 — Query-param filtering on `GET /leave-requests/` and `GET /leave-plan-requests/`
- Backend: added three optional params to each: `status: str | None`, `owner_id: UUID | None`, `approver_id: UUID | None`. Additive/backward-compatible — AND onto the existing non-superuser visibility scope (`owner_id==me OR approver_id==me`), doesn't replace it; non-superusers passing an `owner_id`/`approver_id` other than their own `id` have it ignored (treated as unset), not an error. Implemented in `backend/app/api/routes/leave_requests.py` / `leave_plan_requests.py`.
- Flutter: `LeaveRequestsRepository.fetchLeaveRequests`/`LeavePlanRequestsRepository.fetchLeavePlanRequests` gained optional `status`/`ownerId`/`approverId` params. `DashboardController.fetchPendingRequestsCount` (Task 10.4) now reads `.count` from two `limit: 1` calls (`?owner_id={me}&status=pending`) instead of walking every page — the page-walking helpers were dropped entirely. `ApprovalsController.fetchApprovals` now passes `approverId`/`status: 'pending'` server-side, dropping its client-side `.where()` filter (still walks pages in case the now-much-smaller result set exceeds one page).

### Task 11.2 — New `GET /approvals/pending-count`
- Backend: cheap combined count (no row hydration), `{"leave_requests": int, "leave_plan_requests": int, "total": int}`, counting rows where `approver_id == current_user.id AND status == 'pending'` per table. New `backend/app/api/routes/approvals.py`.
- Flutter: new `PendingApprovalsCountModel`, `ApprovalsRepository.fetchPendingCount()`. `DashboardController.fetchPendingApprovalsCount()` drives a new tappable "Pending Approvals" card on the Dashboard (visible only when `AuthController.isApprover`, same gate as the Approvals nav tile), which navigates to `Routes.approvals` on tap — closing the loop SPEC §8's "approvals count badge for team owners" always intended but never built. `_PlaceholderStatCard` gained an optional `onTap` (renders a trailing chevron when present).

### Task 11.3 — New `GET /schedule/?year=<int>&month=<int 1-12>`
- Backend: combines public holidays + the caller's team's approved leave into one payload. `team_leave` unifies `LeaveRequest` (real date range) and `LeavePlanRequest` (one entry per `LeavePlanDetail`, `start_date == end_date`) into one flat shape: `{id, source: "leave_request"|"leave_plan_request", owner: UserPresentable, leave_type: LeaveTypePresentable, start_date, end_date}` — includes `leave_type` (not a generic "On Leave" marker), filtered to `status == 'approved'` and `team_id == current_user.team_id`; empty list (not an error) if the caller has no team. Entries whose range *overlaps* the queried month are included, not just ones starting inside it. New `backend/app/api/routes/schedule.py`.
- Flutter: Task 10.1's Public Holidays-only calendar feature (`lib/features/public_holidays/`) was renamed/replaced by `lib/features/schedule/` (`ScheduleController`, `ScheduleBinding`, `ScheduleView`) — `Routes.publicHolidays` → `Routes.schedule` (`/public-holidays` → `/schedule`), Dashboard tile and drawer entry relabeled "Schedule". New `ScheduleModel`/`TeamLeaveEntryModel` (`lib/data/models/schedule_model.dart`), `ScheduleRepository`. Unlike Task 10.1's "fetch everything once" approach, `GET /schedule/` is month-scoped server-side, so `ScheduleController.changeMonth()` triggers a fresh network call on calendar page-change rather than a local re-filter. The `TableCalendar<Object>` mixes both `PublicHolidayModel` and `TeamLeaveEntryModel` in one `eventLoader`, with a custom `calendarBuilders.markerBuilder` rendering two distinct marker-dot colors (`AppColors.warning` for holidays, `AppColors.primary` for team leave) plus a legend; the list section below is split into "Holidays in `<Month>`" and "Team Leave in `<Month>`" subsections. Two pure/static functions (`groupHolidaysByDay`, `groupTeamLeaveByDay` — the latter expanding each entry's date range into one key per covered day) are unit-tested directly in `test/unit/schedule_test.dart` (replaces `test/unit/public_holidays_test.dart`). The admin "Manage Public Holidays" CRUD screen (Task 8.4) is unaffected — separate feature, separate route.
### Task 11.4 — Remove "Pending Requests", keep only "Pending Approvals"; scope plain lists to owner_id
- **Depends on:** 11.1, 11.2
- **Found gap (manual test):** the plain "Leave Requests"/"Leave Plan Requests" screens (`LeaveRequestsController`/`LeavePlanRequestsController`) had zero client-side filtering — for a superuser this meant seeing every request in the entire system, and for a team-owner it meant their own submissions mixed in with their team's requests awaiting approval, with no visual distinction. Fixed by passing `ownerId: currentUser.id` on both screens' fetch calls (Task 11.1's param), so these are now genuinely "my requests only" — the Approvals screen remains the sole place to see items awaiting approval.
- Separately, decided the Dashboard's "Pending Requests" card (own pending submissions, Task 10.4) was redundant with "Pending Approvals" (Task 11.2) and less useful (a personal pending-submission count has less actionable value than a tappable approval-queue count) — removed it outright rather than keep both. "Pending Approvals" now sits in "Pending Requests"'s former Row slot next to "Available Days", still conditional on `isApprover`; non-approvers just see "Available Days" alone in that row. `DashboardController` lost its `leaveRequestsRepository`/`leavePlanRequestsRepository` deps and `fetchPendingRequestsCount()` entirely (no longer needed for anything). `dashboard_view.dart`'s `_pendingRequestsSummary` helper renamed to `_pendingCountSummary` (now only formats the approvals count).
- Also removed the Quick Actions grid's "Approvals" tile (`dashboard_view.dart`) — same "reachable elsewhere, drop the duplicate" reasoning as Task 10.2's Profile tile removal: the new "Pending Approvals" card is now the primary entry point, and the drawer's `isApprover`-gated "Approvals" entry (`app_drawer.dart`) remains as the secondary one. Approvals is still reachable two ways (card + drawer), never zero.
- **Acceptance:** Leave Requests/Leave Plan Requests screens show only the current user's own records regardless of role; Dashboard shows "Available Days" + "Pending Approvals" (approvers) or "Available Days" alone (non-approvers) — no "Pending Requests" card anywhere; Quick Actions no longer lists "Approvals" (still in the drawer); `flutter analyze` clean, `flutter test` green (only the pre-existing unrelated `dio_client_unauthorized_test.dart` failures remain).
- **Verify:** manual — as a superuser/team-owner test account, confirm Leave Requests/Leave Plan Requests no longer show other users' records; confirm the Dashboard row and tap-through to Approvals; confirm Approvals is still reachable via the drawer.

---

## Phase 12 — In-App Notifications (backend written, not yet deployed at time of Flutter integration)

Backend (`../hr-leave-management`) already has `Notification` model, `NotificationService` (creates a row on leave/leave-plan submit → notifies approver; approve/reject → notifies owner, no self-notification on submit), and `GET/PUT /notifications/*` routes, fully documented in `PROJECT_FEATURES.md` §14 — written by the user directly in the backend repo, not yet committed/deployed as of this Flutter-side work. Flutter integration was written against that documented contract ahead of deployment; endpoints will 404 until deployed, which the app handles gracefully (silent badge-poll failures, a normal error+retry state on the notifications list).

### Task 12.1 — Notifications data layer, global badge, and list screen
- **Depends on:** 2.1 (AppShellScaffold), Auth (session lifecycle)
- New `NotificationModel`/`NotificationsPage` (`lib/data/models/notification_model.dart`) and `NotificationsRepository` (`fetchNotifications({skip, limit, isRead})`, `fetchUnreadCount()`, `markRead(id)`, `markAllRead()`), registered globally in `initial_binding.dart`.
- New `NotificationsController` (`lib/features/notifications/controllers/notifications_controller.dart`) — registered **globally/permanent** in `InitialBinding` (not per-route via a lazy binding), because the unread badge needs to stay live on every screen, not just while the Notifications screen itself is open. Uses `ever<UserModel?>(authController.currentUser, ...)` to start a 30-second `Timer.periodic` poll of `GET /notifications/unread-count` on login/session-bootstrap and stop it (clearing local state) on logout — reactive to auth state rather than `AuthController` needing to know about notifications. Badge-poll failures are silent (no error toast every 30s); the list screen's own fetch surfaces a normal error+retry state. `markAsRead`/`markAllAsRead` update local state optimistically before the API call resolves.
- New `NotificationsView` (`lib/features/notifications/views/notifications_view.dart`) — standard list-screen pattern (loading/error/empty/infinite-scroll/pull-to-refresh, mirroring `LeaveRequestsView`), unread rows visually distinct (bold text + accent dot + tinted background), "Mark all read" AppBar action, tapping a row marks it read and navigates by `entityType` (`leave_request` → `Routes.leaveRequests`, `leave_plan_request` → `Routes.leavePlanRequests` — the list screen, not a deep link to the specific record; jumping straight to the exact record was deferred as a nice-to-have, not needed for a working first version).
- `AppShellScaffold` (`lib/widgets/app_shell_scaffold.dart`) now bakes in a bell icon + unread-count badge as a trailing AppBar action on every authenticated screen (appended after any caller-supplied `actions`), rather than requiring each screen to opt in individually — tapping it opens `Routes.notifications`.
- New route `Routes.notifications` = `/notifications`, no binding needed (controller is already global).
- **Acceptance:** `flutter analyze` clean; `flutter test` green (only the pre-existing unrelated `dio_client_unauthorized_test.dart` failures remain); app builds/installs/launches without crashing even with the backend not yet deployed (bell badge just stays at 0, notifications list shows a normal error+retry state instead of a 404 crash).
- **Verify (once the backend is deployed):** submit a leave request as one test account, confirm the assigned approver's badge count increments within ~30s (or on next app open); approve/reject it, confirm the submitter's badge increments; tap a notification, confirm it's marked read (badge decrements) and navigates to the right list; "Mark all read" zeroes the badge.

---

## Phase 13 — Account & Identity Enhancements (DONE — backend landed in `../hr-leave-management`, then this Flutter side)

Backend repo for all cross-repo references below: `https://github.com/sokhai-cambodia/hr-leave-management` (local checkout `../hr-leave-management`). Originally planned as "don't touch the backend repo from here," but the user separately asked for the backend work too (implemented and deployed in that repo, not this one — see its own `tasks/plan.md`/`tasks/todo.md` for that side's detail) before this Flutter side was built.

Backend ground truth for this phase (from a dedicated research pass against `backend/app/`, not assumed):
- Change-password endpoint already exists: `PATCH /api/v1/users/me/password` (`app/api/routes/users.py:100-117`), body `UpdatePassword {current_password, new_password}` (`app/models.py:52-54`, both `min_length=8, max_length=128`), requires bearer auth, rejects `new_password == current_password`, 400s on wrong `current_password`. Nothing to add server-side.
- `User`/`UserBase` (`app/models.py:20-27,58-107`) has no `phone_number` and no `username` field today — identity is email-only. Self-editable fields today are limited to `full_name`/`email` via `UserUpdateMe` (`models.py:47-49`, route `users.py:78-97`); everything else (including `team_id`) is admin-only via `UserUpdate`.
- Login (`POST /login/access-token`, `app/api/routes/login.py:24-43`) is a pure email lookup today: `crud.authenticate(session, email=form_data.username, password=...)` → `crud.get_user_by_email()` (`app/crud.py:34-46`). The OAuth2 form field is literally named `username` but its value is treated as an email — there is no username concept anywhere in the schema to reuse.
- Password-reset email (`utils.py:send_email/generate_reset_password_email`, routes in `login.py:54-98`) requires `SMTP_HOST` + `EMAILS_FROM_EMAIL` to be set (`emails_enabled` in `app/core/config.py:88-91`) or `send_email()`'s assertion fails. Local dev points at the Mailcatcher container (`.env`: `SMTP_HOST=mailcatcher`, port 1025, no auth) — a local trap, not real delivery. **`render.yaml`'s `hr-leave-backend` service currently sets zero SMTP env vars** — production forgot-password will 500 until this is fixed.

### Task 13.1 — Change Password screen (Flutter only, backend already supports it)
- **Depends on:** Auth (session lifecycle), Profile screen
- Flutter: new "Change Password" entry in `ProfileView` (near Log out). New form screen — current password, new password, confirm new password (obscured, matching the login screen's show/hide pattern), client-side validation (confirm matches, min length 8) before calling the API. New `AuthRepository.changePassword({currentPassword, newPassword})` → `PATCH /users/me/password`, following the existing `try { ... } on DioException catch (e) { throw ApiException.fromDioException(e); }` pattern used by every other repository method. Wrong current-password (backend 400) surfaces as an inline form error via the existing `ApiException` message, same as the login screen's error handling.
- On success: snackbar + navigate back to Profile. No forced re-login — the backend has no session-invalidation list (JWTs are self-contained, no refresh-token endpoint per the "Verified Backend Ground Truth" section above), so the current token stays valid after a password change; this is a pre-existing backend characteristic, not something this task changes.
- **Acceptance:** user can change their password entirely from the Flutter app; wrong current-password shows a clear inline error; `flutter analyze` clean, `flutter test` green (only the pre-existing `dio_client_unauthorized_test.dart` failures remain).
- **Verify:** manual — change password, log out, confirm login succeeds with the new password and fails with the old one.

### Task 13.2 — QR Business Card (Telegram deep link) — DONE
- **Backend:** `phone_number` added to `UserBase`/`UserUpdateMe` in `../hr-leave-management`, deployed live on Render.
- **Flutter:** `AuthRepository.updateProfile({phoneNumber})` (`PATCH /users/me`, only `phone_number` in the body per the exclude-unset footgun). Rather than a separate "Edit Profile" screen, `ProfileView` got a lightweight edit-icon-next-to-the-Phone-row that opens an `AlertDialog` to update just the phone number (`_showEditPhoneDialog`) — simpler than a full edit-mode screen for a single field. New `BusinessCardView` (`lib/features/profile/views/business_card_view.dart`) shows avatar/name/team + a `qr_flutter`-rendered QR encoding `https://t.me/+<digits-only phone>` (`_normalizePhone` strips everything but digits), or an "add your phone number first" prompt if unset. Reachable from a QR icon in `MainShellView`'s top bar (Home tab only, next to the bell) and from a "My Business Card" tile in `ProfileView`.
- **Acceptance met:** `flutter analyze`/`flutter test` clean (11/11 non-env-dependent tests). Not manually scanned against a real Telegram client from this session — do that pass before considering the feature fully verified.

### Task 13.3 — Username Login (admin-set usernames) — DONE
- **Backend:** `username` (unique, admin-only) added to `UserBase` in `../hr-leave-management`; login now tries username-or-email via `crud.authenticate_by_identifier`; deployed live on Render.
- **Flutter:** `UserModel` gained `username`/`phoneNumber`; `UsersRepository.createUser`/`updateUser` pass both through; `admin_users_view.dart` gained Username + Phone Number `AdminFieldSpec` fields (search now also matches username); `ProfileView` shows username read-only. Login screen's field relabeled "Email or Username" (`login_view.dart`), `keyboardType` changed from `emailAddress` to `text` since a username won't have `@`.
- **Acceptance met:** `flutter analyze` clean.
- **Verify:** manual — as superuser, set a username on a test account via the admin Users screen; log out; log back in using only the username; confirm success; confirm email login still also works for the same account. Not yet done from this session.

### Task 13.4 — Real SMTP for Password Reset Emails — DONE (sandbox mode)
- `render.yaml` has Resend's SMTP env vars; user signed up at resend.com and set `SMTP_PASSWORD` in Render's dashboard. **Decision:** staying on the sandbox address (`onboarding@resend.dev`) rather than verifying a custom domain, since `hr-leave-frontend.onrender.com`/`hr-leave-backend.onrender.com` are Render-owned subdomains the user doesn't control DNS for — Resend can't verify those. Sandbox mode only delivers to the Resend account owner's own email, not teammates'/other real users' addresses. Revisit by buying an actual domain (~$10/yr) if that becomes a real blocker.
- **Acceptance:** a forgot-password request against the deployed (Render) backend delivers a real, working reset-link email.
- **Verify:** manual — trigger forgot-password with a real email address against the deployed backend, confirm the email arrives and the reset link works end-to-end.

---

## Phase 14 — Post-13 UI Polish & App Identity (DONE)

Follow-up refinements requested right after Phase 13 landed and got a first on-device look.

### Task 14.1 — Simplify the shell top bar
- The Phase 13 top bar (avatar + "Hi, {name}" on Home, plain title elsewhere) still looked out of place once seen live — the QR icon action sat oddly next to the bell on every tab. Removed the avatar/greeting from `MainShellView` entirely (all four tabs now just show a plain bold title) and moved the QR icon onto the Dashboard's own profile card instead (top-right corner via `Stack`+`Positioned`), next to the identity info it's actually about.

### Task 14.2 — Restyle Change Password
- Task 13.1's `ChangePasswordView` used a centered/max-width-360 layout (mirroring the login screen). Restyled to match `LeaveRequestFormView`'s pattern instead — top-aligned `ListView`, close (✕) icon in the app bar — since that's the form style used everywhere else that isn't the login/splash screens.

### Task 14.3 — Business Card: clean redesign + Save/Share
- Redesigned `_CardFace` as an actual shareable-card look: gradient (`AppColors.primary` → `AppColors.primaryDark`) header with avatar/name/team, white body with the QR code and a caption, drop shadow, rounded corners — wrapped in a `RepaintBoundary` so it can be captured as an image.
- New dependencies: `gal` (save to gallery) and `share_plus` (OS share sheet). "Save" button captures the card to PNG bytes and calls `Gal.putImageBytes`; "Share" button shares the same PNG alongside a text summary (name/team/Telegram link) via `SharePlus.instance.share(ShareParams(...))`.
- Android manifest gained `WRITE_EXTERNAL_STORAGE` (maxSdkVersion 29) + `android:requestLegacyExternalStorage="true"` per `gal`'s setup docs (both no-ops on modern scoped-storage Android, needed for API ≤29).
- **Windows-build gotcha found:** `share_plus`'s Kotlin compile step failed with "this and base files have different roots" — Kotlin's incremental-compilation cache can't relativize a path between the pub-cache (`C:`) and this project (`D:`) on Windows. Fixed by adding `kotlin.incremental=false` to `android/gradle.properties` (see comment there). Not a code bug, purely a Windows multi-drive dev-environment quirk — flagging in case it resurfaces for another plugin.

### Task 14.4 — App icon and display name
- No source logo existed in the project, so generated one: a 1024×1024 crimson (`AppColors.primary` #E23744) square with a white bold "HR" monogram (`assets/icon/icon.png`), plus a transparent-background version scaled to Android's adaptive-icon safe zone (`assets/icon/icon_foreground.png`). Wired through `flutter_launcher_icons` (new dev dependency + `flutter_launcher_icons:` config block in `pubspec.yaml`, Android-only — this project doesn't build iOS/web) to generate all `mipmap-*` legacy + adaptive-icon resources.
- Android app label changed from the default `hr_leave_management` to "HR Leave" in `AndroidManifest.xml`, matching the wordmark already used on the splash/login screens. Windows desktop's window title/executable metadata was left untouched (out of scope — dev-loop-only target, not the demo target).

### Checkpoint 14
- **Acceptance:** `flutter analyze` clean; `flutter test` green (only the pre-existing unrelated `dio_client_unauthorized_test.dart` failures remain); installed and launched on a real device after each change with no crashes (checked via `adb logcat` for exceptions/FATAL).
- **Verify:** manual — confirm the new icon/name show correctly in the launcher; confirm Save/Share both work on a real device (gallery permission prompt + OS share sheet).

---

## Sequencing

```
Phase 0 (scaffold+infra)
  → Phase 1 (auth/session)
    → Phase 2 (shell/nav/dashboard)
      → Phase 3 (balances)
        → Phase 4 (leave requests)
          → Phase 5 (leave plan requests)
            → Phase 6 (AI recommendations)   ← headline feature, needs 3+5
            → Phase 7 (approvals)             ← needs 2.2+4+5
              → Phase 8 (admin CRUD)          ← needs 2.1 only; kept last per user decision
                → Phase 9 (hardening)
                  → Phase 10 (post-launch enhancements, found/requested after Checkpoint 9)
                    → Phase 11 (backend API enhancements + Flutter integration)
                      → Phase 12 (in-app notifications)
                        → Phase 13 (account & identity enhancements — done, backend work landed in ../hr-leave-management first)
                          → Phase 14 (post-13 UI polish + app icon/name — done)
```

## Critical Files

- `lib/core/network/dio_client.dart` — single Dio instance + auth/401 interceptors; every repository depends on this being correct first.
- `lib/core/errors/api_exception.dart` — FastAPI's dual error shape (`detail: string` vs `detail: [...]` for 422) handled once here.
- `lib/app/routes/app_pages.dart` — route table + auth guard middleware, gates every authenticated screen.
- `lib/features/auth/controllers/auth_controller.dart` — owns login/logout/session state and cached `currentUser`, read by nearly every other feature for role/owner-id checks.
- `lib/data/repositories/teams_repository.dart` — powers both the team-owner detection heuristic (Phase 2) and the Teams admin screen (Phase 8).

## Overall Verification

Each task above has its own verify step against the real running backend (`docker compose up -d` in `../hr-leave-management`). End-to-end acceptance for the whole plan: three test accounts (superuser, team-owner employee, plain employee) can each complete their full respective workflows — plain employee submits a leave request and an AI-recommended leave plan; team-owner approves/rejects both from a second account; superuser manages all master data — entirely through the Flutter app with zero direct Swagger UI use once Phase 8 lands.
