# HireHub — Flutter Job Board App

A 2-screen Flutter application that displays live job listings from the Arbeitnow public API.

---

## Screens

### Screen 1 – Job Dashboard
- Search bar filtering by title or company name
- `CircularProgressIndicator` during API load
- Job cards showing title, company, location
- Heart (bookmark) toggle per job card


 <img width="345" height="768" alt="Screenshot 2026-06-06 121325" src="https://github.com/user-attachments/assets/dd2f9680-432a-4136-80d4-4df482e6429f" />

### Screen 2 – Job Detail
- Full description in a scrollable view
- "Apply Now" button opens the job URL via `url_launcher`
<img width="345" height="768" alt="Screenshot 2026-06-06 121336" src="https://github.com/user-attachments/assets/cef5f9cb-97cd-4acf-a663-413312485b33" />

---

## Architecture

| Concern | Implementation |
|---|---|
| State Management | GetX (`JobController`) |
| Data Model | `JobModel` (typed, `fromJson`) |
| Network | `http` package |
| Error Handling | `hasError` flag → "Try Again" button |
| Navigation | `Get.to()` |

---

## Project Structure

```
lib/
├── main.dart
├── controllers/
│   └── job_controller.dart
├── models/
│   └── job_model.dart
└── screens/
    ├── job_dashboard_screen.dart
    └── job_detail_screen.dart
```

---

## Getting Started

```bash
flutter pub get
flutter run
```

### Dependencies
- `get: ^4.6.6`
- `http: ^1.2.0`
- `url_launcher: ^6.2.5`

---

## API

**Endpoint:** `https://www.arbeitnow.com/api/job-board-api`  
No authentication required.

**Fields used:** `title`, `company_name`, `location`, `description`, `url`

---

## Notes
- Bookmarks are stored in-memory (not persisted across sessions)
- Error state shows a "Try Again" button that re-fetches the API
