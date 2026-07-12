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

Sliced as pattern-then-apply across 5 resources, not 5 near-duplicate tasks.

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

**Checkpoint 8** — all 5 admin resources CRUD-able in-app; team-owner assignment loop fully closed in-app.

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
```

## Critical Files

- `lib/core/network/dio_client.dart` — single Dio instance + auth/401 interceptors; every repository depends on this being correct first.
- `lib/core/errors/api_exception.dart` — FastAPI's dual error shape (`detail: string` vs `detail: [...]` for 422) handled once here.
- `lib/app/routes/app_pages.dart` — route table + auth guard middleware, gates every authenticated screen.
- `lib/features/auth/controllers/auth_controller.dart` — owns login/logout/session state and cached `currentUser`, read by nearly every other feature for role/owner-id checks.
- `lib/data/repositories/teams_repository.dart` — powers both the team-owner detection heuristic (Phase 2) and the Teams admin screen (Phase 8).

## Overall Verification

Each task above has its own verify step against the real running backend (`docker compose up -d` in `../hr-leave-management`). End-to-end acceptance for the whole plan: three test accounts (superuser, team-owner employee, plain employee) can each complete their full respective workflows — plain employee submits a leave request and an AI-recommended leave plan; team-owner approves/rejects both from a second account; superuser manages all master data — entirely through the Flutter app with zero direct Swagger UI use once Phase 8 lands.
