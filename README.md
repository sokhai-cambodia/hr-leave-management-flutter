# HR Leave Management — Flutter Client

Flutter mobile client for the HR Leave Management system (master's final-project coursework). It consumes the FastAPI backend from the sibling repo [`hr-leave-management`](https://github.com/sokhai-cambodia/hr-leave-management) — see `SPEC.md` for the full design contract and `tasks/plan.md` / `tasks/todo.md` for implementation progress.

## Features

**Authentication & Account**
- Login by email or username, logout, forgot/reset password (email-based, via SMTP)
- Change password, edit profile (phone number, avatar)
- Business Card: shareable QR profile card (save to gallery or share via Telegram/OS share sheet)

**Dashboard**
- Role-adaptive home screen: leave balances at a glance, entry point to AI recommendations
- Team owners additionally see a tappable "Pending Approvals" count

**Leave Requests**
- Create as draft, edit, delete, then submit for approval
- Full lifecycle: draft → pending → approved/rejected
- Balance auto-debits on submit, visible immediately

**Leave Plan Requests**
- Same draft/submit/approve/reject lifecycle as Leave Requests, but for multiple non-contiguous dates in one request (multi-date picker with duplicate-date guard)

**AI Leave Recommendations** (headline feature)
- Fetches suggested leave dates from the backend's recommendation engine
- User picks which suggested dates to keep, then one tap creates and submits the plan request

**Approvals Queue**
- Team owners review pending Leave Requests and Leave Plan Requests in one place, approve or reject each

**Schedule**
- Month-view calendar combining public holidays and the caller's team's approved leave, with month-by-month navigation and color-coded markers

**In-App Notifications**
- Bell icon + unread-count badge on every screen, updates automatically while logged in
- Tapping a notification marks it read and jumps to the relevant request list

**Admin / Superuser Tools**
- Full CRUD (create/read/update/delete, with search + pagination) over Teams, Users, Leave Types, Public Holidays, Policies, and any employee's Leave Balances — no need to touch the backend's Swagger UI directly

See `SPEC.md` §8 for the feature list mapped to exact backend endpoints, and `tasks/todo.md` for the phase-by-phase build history.

## Prerequisites

- **Flutter SDK** (stable channel, Dart SDK `^3.12.2` or newer) — [install guide](https://docs.flutter.dev/get-started/install)
- **Android Studio** with an Android SDK + emulator, or a physical Android phone with USB debugging enabled (and `adb` on your `PATH`)
- Run `flutter doctor` and resolve anything it flags before continuing

## First-time setup

1. **Clone this repo.**
2. **Create your local env file** — required, the build fails without it:
   ```
   cp .env.example .env
   ```
   Then edit `.env` and set `API_BASE_URL` for your setup (see below). `.env` is gitignored — every teammate keeps their own.
3. **Install dependencies:**
   ```
   flutter pub get
   ```
4. **Run the app:**
   ```
   flutter run -d <device>
   ```
   Use `flutter devices` to list available targets (emulator, physical phone, Windows desktop, Chrome).

## Choosing a backend URL (`.env`)

You don't need to run the backend yourself to try the app — a live copy is deployed on Render.

| Setup | `API_BASE_URL` |
|---|---|
| **Quickest — deployed backend (no local backend needed)** | `https://hr-leave-backend.onrender.com/api/v1` |
| Android emulator + backend running locally | `http://10.0.2.2:8000/api/v1` (default; `10.0.2.2` is the emulator's host-loopback address) |
| Physical phone + backend running locally | `http://<your-PC's-LAN-IP>:8000/api/v1` — find your IP with `ipconfig` (Windows) or `ifconfig`/`ip addr` (Mac/Linux); phone and PC must be on the same Wi-Fi |
| Windows/desktop/web + backend running locally | `http://localhost:8000/api/v1` |

Notes:
- The deployed Render backend is on a free tier — it can take 30–60s to wake up on the first request after being idle. If login/data fetch times out immediately, wait a few seconds and retry.
- `--dart-define=API_BASE_URL=<url>` always overrides `.env` (used for CI); `.env` is the normal way to configure local dev.
- After changing `.env`, you must **rebuild** (a fresh `flutter run` or `flutter build`) — it's bundled as an asset, not read live.

## Running the backend locally (optional)

Only needed if you want to run/modify the backend yourself instead of using the deployed one. Requires Docker and a checkout of the sibling `hr-leave-management` repo:

```
cd ../hr-leave-management
docker compose up -d
```

This brings up Postgres, the FastAPI backend (`http://localhost:8000`, API prefix `/api/v1`, Swagger UI at `http://localhost:8000/docs`), Adminer, and Mailcatcher (SMTP capture at `http://localhost:1080` for forgot/reset-password testing). Superuser bootstrap credentials are `FIRST_SUPERUSER` / `FIRST_SUPERUSER_PASSWORD` in `../hr-leave-management/.env`.

## Common commands

| Command | Purpose |
|---|---|
| `flutter pub get` | Install/update dependencies |
| `flutter run -d <device>` | Run on a connected device/emulator |
| `flutter analyze` | Static analysis — must be clean before any task is considered done |
| `flutter test` | Run all unit/widget tests |
| `flutter test test/unit/leave_balance_model_test.dart` | Run a single test file |
| `dart format .` | Format code |

## Project docs

- `docs/ARCHITECTURE.md` — system architecture diagram and full tech stack (client, backend, infrastructure)
- `SPEC.md` — authoritative spec: tech stack, project structure, design tokens, documented gaps vs. the course guideline
- `tasks/plan.md` — phase-by-phase implementation plan with verified backend contract details
- `tasks/todo.md` — current progress (checkbox state is the source of truth for what's built vs. pending)
- `CLAUDE.md` — conventions and architecture notes for AI-assisted development on this repo

## Getting started with Flutter

New to Flutter? These help:

- [Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Flutter learning resources](https://docs.flutter.dev/reference/learning-resources)
- [Flutter documentation](https://docs.flutter.dev/)
