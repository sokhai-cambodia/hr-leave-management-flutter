# HR Leave Management — Flutter Client — Task Checklist

Full detail (acceptance criteria, verify steps) in `tasks/plan.md`.

## Phase 0 — Environment & Scaffolding
- [x] 0.1 Project scaffold, dependencies, folder skeleton, lint
- [x] 0.2 Core network/storage infra + connectivity smoke test
- [x] **Checkpoint 0**

## Phase 1 — Auth & Session
- [x] 1.1 Login + token storage + current-user fetch + minimal authenticated screen
- [x] 1.2 Session bootstrap + global 401/403 handling
- [x] 1.3 Forgot password + reset password
- [x] **Checkpoint 1**

## Phase 2 — App Shell, Role-Adaptive Navigation, Dashboard
- [x] 2.1 App shell + GetX routing + static role-based nav (superuser branch)
- [x] 2.2 Team-owner detection + Approvals nav entry
- [x] **Checkpoint 2**

## Phase 3 — Leave Balances
- [x] 3.1 Leave balances list, wired into dashboard
- [x] **Checkpoint 3**

## Phase 4 — Leave Requests
- [x] 4.1 List + detail (read-only)
- [x] 4.2 Create draft, edit, delete (draft-only)
- [x] 4.3 Submit action + balance-debit visibility
- [x] **Checkpoint 4**

## Phase 5 — Leave Plan Requests
- [x] 5.1 List + detail (detail = list of dates)
- [x] 5.2 Create/edit (multi-date picker, duplicate guard) + delete
- [x] 5.3 Submit action
- [x] **Checkpoint 5**

## Phase 6 — AI Recommendation Flow (headline feature)
- [x] 6.1 Fetch & display recommendations
- [x] 6.2 Selection UI → build plan-request draft
- [x] 6.3 One-tap create & submit, success state
- [x] **Checkpoint 6**

## Phase 7 — Approvals Queue
- [x] 7.1 Approvals list (two tabs) + approve/reject
- [x] **Checkpoint 7**

## Phase 8 — Admin/Superuser Master Data CRUD
- [x] 8.1 Generic CRUD scaffold, proven on Leave Types
- [x] 8.2 Apply pattern: Public Holidays, Policies
- [x] 8.3 Apply pattern: Teams, Users (relational pickers)
- [x] 8.4 Apply pattern: Leave Balances (admin); fix missing Public Holidays admin nav entry — both were gaps found after Checkpoint 8
- [x] **Checkpoint 8**

## Phase 9 — Hardening & Report-Readiness
- [x] 9.1 Targeted unit tests
- [x] 9.2 Analyze-clean pass + empty/error/loading state audit + feature checklist walkthrough

## Phase 10 — Post-Launch Enhancements
- [x] 10.1 Employee Public Holidays month-calendar view (table_calendar) — superseded by Task 11.3's Schedule feature
- [x] 10.2 Remove redundant Profile tile from Dashboard Quick Actions
- [x] 10.3 Remove "Recent Activity" placeholder stat card
- [x] 10.4 Wire "Pending Requests" dashboard stat to real data — later removed outright (Task 11.4)

## Phase 11 — Backend API Enhancements + Flutter Integration (backend in `../hr-leave-management`, deployed on Render)
- [x] 11.1 Query-param filtering (`status`/`owner_id`/`approver_id`) on `GET /leave-requests/` and `GET /leave-plan-requests/` + Flutter integration
- [x] 11.2 New `GET /approvals/pending-count` + Dashboard "Pending Approvals" tappable card
- [x] 11.3 New `GET /schedule/?year&month` (public holidays + team leave) + Schedule feature (replaces Public Holidays screen)
- [x] 11.4 Scope Leave Requests/Leave Plan Requests lists to owner_id; remove "Pending Requests" card and Quick Actions "Approvals" tile (redundant with "Pending Approvals")

## Phase 12 — In-App Notifications (backend written by user, not yet deployed)
- [x] 12.1 Notifications data layer, global unread badge (every screen via `AppShellScaffold`), and list screen with mark-read/mark-all-read
