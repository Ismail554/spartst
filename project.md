# 📱 Cellis || SPARTST — Mobile App
### Project Documentation · Flutter · MVVM · OpenAPI 3.0.3

---

## Table of Contents

1. [Project Overview](#1-project-overview)
2. [Tech Stack](#2-tech-stack)
3. [Architecture](#3-architecture)
4. [Bottom Navigation Structure](#4-bottom-navigation-structure)
5. [Feature Modules](#5-feature-modules)
6. [API Reference](#6-api-reference)
7. [Data Models](#7-data-models)
8. [State Management](#8-state-management)
9. [Navigation & Routing](#9-navigation--routing)
10. [Real-time Features](#10-real-time-features)
11. [File Uploads & Media](#11-file-uploads--media)
12. [Authentication Flow](#12-authentication-flow)
13. [Folder Structure](#13-folder-structure)
14. [Environment & Configuration](#14-environment--configuration)
15. [Dependencies](#15-dependencies)
16. [Complexity & Scope](#16-complexity--scope)

---

## 1. Project Overview

**Cellis || SPARTST** is a mobile application for music creators — artists, producers, and labels. The platform lets creators collaborate on music projects, apply to industry briefs, host live audio/video sessions, buy and sell beats and samples, and manage their creative career in one place.

| Attribute | Detail |
|---|---|
| App name | Cellis |
| Backend brand | SPARTST (Spart Sessions) |
| Platform | iOS + Android (Flutter) |
| API base URL | `https://api.spartst.com/api/v1` |
| API spec | OpenAPI 3.0.3 · 213 paths · 260 operations · 258 schemas |
| Auth | JWT (access + refresh) · 2FA toggle |
| Payments | Stripe (checkout sessions + saved cards) |
| Real-time | ZegoCloud (sessions call token) + WebSocket (in-session chat) |
| Storage | Per-user quota with breakdown by file type |

### Core User Journeys

```
Creator signs up
  → Builds profile (genres, skills, works portfolio)
  → Discovers other creators on dashboard
  → Posts audio / lyrics / videos to feed
  → Applies to industry briefs
  → Collaborates inside projects (files, lyrics, revenue splits)
  → Hosts or joins live sessions (audio/video call + chat)
  → Sells beats & samples on marketplace
  → Requests payouts for earnings
  → Upgrades subscription for more storage / features
```

---

## 2. Tech Stack

| Layer | Technology |
|---|---|
| UI Framework | Flutter 3.x |
| Language | Dart 3.x |
| State Management | Provider (`ChangeNotifier`) |
| Navigation | GoRouter (ShellRoute for nav bar) |
| HTTP Client | Dio 5.x |
| WebSocket | `web_socket_channel` |
| Video/Audio Calls | ZegoCloud SDK (call token from API) |
| Secure Storage | `flutter_secure_storage` (JWT tokens) |
| Local Storage | `shared_preferences` (theme, onboarding) |
| UI Responsiveness | `flutter_screenutil` |
| Loading States | `shimmer` |
| Animations | `lottie` |
| Image Caching | `cached_network_image` |
| File Picking | `file_picker` + `image_picker` |
| Video Playback | `video_player` |
| Push Notifications | Firebase Cloud Messaging (FCM) |
| Payments | `flutter_stripe` |
| Offline Detection | `connectivity_plus` |
| Code Generation | `json_serializable` + `build_runner` |
| Environment | `flutter_dotenv` |

---

## 3. Architecture

The app follows **MVVM (Model–View–ViewModel)** with a repository layer.

```
┌─────────────────────────────────────────────────────────────┐
│  VIEW  (Screens + Widgets)                                  │
│  • Reads state from ViewModel via context.watch()           │
│  • Calls ViewModel methods on user interaction              │
│  • Never touches Repository or ApiClient directly           │
└───────────────────────┬─────────────────────────────────────┘
                        │ observes / calls
┌───────────────────────▼─────────────────────────────────────┐
│  VIEWMODEL  (ChangeNotifier)                                │
│  • Holds ViewState enum: idle|loading|success|empty|        │
│    error|offline                                            │
│  • Calls Repository methods                                 │
│  • Handles errors via AppException                          │
│  • Calls notifyListeners() on state change                  │
└───────────────────────┬─────────────────────────────────────┘
                        │ calls
┌───────────────────────▼─────────────────────────────────────┐
│  REPOSITORY                                                 │
│  • Makes HTTP calls via ApiClient (Dio)                     │
│  • Maps JSON → Model (fromJson)                             │
│  • Throws typed AppException on errors                      │
└───────────────────────┬─────────────────────────────────────┘
                        │ uses
┌───────────────────────▼─────────────────────────────────────┐
│  CORE SERVICES                                              │
│  ApiClient · AuthTokenService · ConnectivityService         │
│  WebSocketClient · LocalStorageService                      │
└─────────────────────────────────────────────────────────────┘
```

### ViewState Pattern (used in every ViewModel)

```dart
enum ViewState { idle, loading, success, empty, error, offline }
```

Every screen observes this enum and renders accordingly:
- `idle` → blank / uninitialized
- `loading` → shimmer placeholder
- `success` → data list or detail
- `empty` → empty state widget
- `error` → error state widget with retry button
- `offline` → offline banner + cached data if available

---

## 4. Bottom Navigation Structure

```
┌──────────┬──────────┬──────────┬──────────┬──────────┐
│  🏠 Home │ 📰 Feed  │ 🎙 Sesh  │ 🛒 Market│ 👤 Profile│
└──────────┴──────────┴──────────┴──────────┴──────────┘
```

| Tab | Label | Root Screen | Primary API |
|---|---|---|---|
| 1 | **Home** | `DashboardScreen` | `GET /users/dashboard/` |
| 2 | **Feed** | `FeedScreen` | `GET /feed/` |
| 3 | **Sessions** | `SessionsScreen` | `GET /sessions/` |
| 4 | **Market** | `MarketplaceScreen` | `GET /marketplace/assets/` |
| 5 | **Profile** | `MyProfileScreen` | `GET /users/users/me/` |

A `ShellRoute` (GoRouter) wraps all 5 tabs with the `MainNavShell` widget that renders the `BottomNavigationBar` and the shared `OfflineBanner`.

---

## 5. Feature Modules

### 5.1 Auth
Entry point for new and returning users.

**Screens:** Login · Register · Forgot Password · Change Password

**Key fields on registration:**
- `email`, `first_name`, `last_name`, `password`, `password2`
- `display_name`, `best_describe_you` (role), `location`

**Token flow:**
1. `POST /users/auth/login/` → returns `{access, refresh}`
2. Access token stored in `flutter_secure_storage`
3. `AuthInterceptor` attaches `Authorization: Bearer <access>` to every request
4. On 401 → calls `POST /users/auth/token/refresh/` automatically
5. On refresh failure → clears tokens → redirects to Login

---

### 5.2 Dashboard (Home Tab)
The home screen surfaces the most relevant content for the logged-in creator.

**API:** `GET /users/dashboard/`

**Sections rendered:**

| Section | Source field | UI component |
|---|---|---|
| KPI tiles | `stats` | `DashboardStatsRow` — 4 tiles: profile_views · collaborations · active_briefs · works_uploaded |
| Suggested for you | `suggested_for_you` | Horizontal scroll `SuggestedCreatorCard` — shows match_percentage + connection CTA |
| Open industry briefs | `open_industry_briefs` | `OpenBriefCard` — company · category · days_left · is_featured badge |
| Trending this week | `trending_this_week` | `TrendingCreatorCard` |
| In the spotlight | `in_the_spotlight` | `SpotlightWidget` |
| Active projects | `active_projects` | `ActiveProjectTile` — title · progress bar · collaborator |
| Upgrade panel | `upgrade_panel` | `UpgradePanelWidget` — shown when `show_upgrade: true` |

---

### 5.3 Feed (Feed Tab)
A scrollable content feed of audio tracks, videos, photos, and lyrics posts from the creator network.

**Post types:** `audio` · `video` · `photo` · `lyrics`

**Actions per post:**
- `POST /feed/{id}/like/` — toggle like
- `POST /feed/{id}/save/` — toggle save
- `POST /feed/{id}/share/` — share post
- `POST /feed/{id}/report/` — report post
- `GET|POST /feed/{id}/comments/` — threaded comments with replies
- `DELETE /feed/{id}/comments/{comment_pk}/` — delete own comment

**Create post:** composer allows selecting post type, attaching audio/video/photo, adding lyrics text, selecting genres, toggling `allow_downloads` and `allow_comments`.

---

### 5.4 Sessions (Sessions Tab)
Live and scheduled audio/video collaboration sessions powered by **ZegoCloud**.

**Session privacy:** `public` · `private` · `invite_only`

**Session lifecycle:**
```
Created (scheduled) → Started (host calls /start/) → Live → Ended (/end/)
```

**Key flows:**

| Flow | Endpoints |
|---|---|
| Create | `POST /sessions/` |
| Browse upcoming | `GET /sessions/` |
| Join by ID | `POST /sessions/{id}/join/` |
| Join by share link | `POST /sessions/join-by-link/` |
| Get call token | `GET /sessions/{id}/call-token/` → ZegoCloud token |
| In-session chat | `GET /sessions/{id}/messages/` + `POST /sessions/{id}/messages/send/` |
| Invite user | `POST /sessions/{id}/invite/` |
| Accept/decline invite | `POST /sessions/{id}/invites/respond/` → `{action: "accept" | "decline"}` |
| View participants | `GET /sessions/{id}/participants/` |
| End session | `POST /sessions/{id}/end/` (host only) |

**Live session screen layout:**
- Top: participant avatar row with live indicator
- Center: ZegoCloud video/audio call view
- Bottom drawer: in-session chat + send message input

---

### 5.5 Marketplace (Market Tab)
A marketplace for buying and selling music assets.

**Asset types:** `beat_track` · `lyrics` · `sample_pack` · `visual_asset`

**License types:** `non_exclusive` · `exclusive`

**Key flows:**

| Flow | Endpoint |
|---|---|
| Browse assets | `GET /marketplace/assets/` |
| Preview (play) | `POST /marketplace/assets/{id}/play/` — increments play_count |
| Buy (checkout) | `POST /marketplace/checkout/` → Stripe session URL |
| Upload asset | `POST /marketplace/assets/` — title, description, price, BPM, key, cover_image, preview_file, asset_file |
| My listings | `GET /marketplace/assets/my-assets/` |
| Earnings | `GET /marketplace/earnings/` → total_earned · pending_payout · total_paid_out |
| Request payout | `POST /marketplace/payouts/` |
| Purchased licenses | `GET /marketplace/licenses/purchased/` |

**Asset card fields:** cover_image · title · seller_name · asset_type · genre · BPM · key · price · license_type · play_count · sales_count

---

### 5.6 Profile (Profile Tab)
The creator's identity card and portfolio.

**My profile sections:**
- Header: profile_picture · cover_photo · display_name · best_describe_you (role) · location
- Stats row: profile_views · collaborations · works_uploaded
- Genre chips + skill chips
- Works portfolio grid (`GET|POST|PATCH|DELETE /users/works/`)
- Edit button → `EditProfileScreen`

**Public profile** (`GET /users/users/{id}/profile/`):
- Same layout with Connect / Message / Report action buttons
- Connection status: `pending` · `accepted` · `rejected`

**Edit profile** (`PATCH /users/settings/profile/update/`):
- Basic info: first_name · last_name · display_name · bio · location · website
- Role: best_describe_you
- Genres (multi-select from `GET /users/genres/`)
- Skills (multi-select from `GET /users/skills/`)
- Profile picture upload (DELETE to remove)
- Cover photo upload (DELETE to remove)

---

### 5.7 Briefs
Industry job postings (labels, music supervisors, brands) that creators can apply to.

**Brief fields:** title · company · company_type · category · overview · looking_for · genres · budget_min/max · submission_deadline · requirements · deliverables · allow_direct_messages

**Creator flow:**
1. Browse `GET /briefs/` (also surfaced on Dashboard as `open_industry_briefs`)
2. View detail `GET /briefs/{id}/`
3. Apply: `POST /briefs/{id}/apply/` → `{work_sample, cover_letter, portfolio_link}`
4. Track: `GET /briefs/my-submissions/` → status per brief

**Brief owner flow:**
1. Create `POST /briefs/`
2. View submissions `GET /briefs/{id}/submissions/`
3. Update submission status `PATCH /briefs/{id}/submissions/{sub_pk}/status/`

**Submission statuses:** `pending` → `accepted` / `rejected`

---

### 5.8 Projects
Collaborative music projects with shared file storage, lyrics, comments, and revenue splits.

**Project fields:** title · genre · project_type · status · source_brief_id (if created from a brief) · owner · collaborators · progress

**Sub-resources:**

| Resource | Endpoints | Description |
|---|---|---|
| Collaborators | `GET|POST /projects/{id}/collaborators/` | Invite by user_id, assign role + specialty |
| Files | `GET|POST /projects/{id}/files/` | Upload audio/docs with file_type tag |
| File download | `GET /projects/{id}/files/{fid}/download/` | Secure download link |
| Lyrics | `GET|POST|PATCH|DELETE /projects/{id}/lyrics/` | Title + text content or file |
| Comments | `GET|POST|DELETE /projects/{id}/comments/` | Threaded comments |
| Progress | `GET /projects/{id}/progress/` | `{overall, total_files, audio_files, lyrics, comments}` |
| Revenue splits | `GET|PUT /projects/{id}/splits/` | `{splits: [{collaborator_id, revenue_split}]}` · must total 100% |

**Collaborator roles:** set via `PATCH /projects/{id}/collaborators/{cid}/role/`

---

### 5.9 Messaging
1:1 direct messaging between creators.

**Conversations:** `GET|POST /messaging/conversations/` — POST with `{user_id}` to get-or-create a conversation

**Messages:** `GET /messaging/conversations/{id}/messages/` — paginated, oldest-first

**Real-time:** messages arrive via WebSocket subscription (same connection as in-session chat)

---

### 5.10 Notifications
In-app notification centre + push via FCM.

**Notification types:**
`post_like` · `post_comment` · `post_reply` · `post_share` · `connection_request` · `connection_accepted` · `brief_submission` · `brief_submission_status` · `brief_status` · `project_invite` · `project_file_upload` · `project_comment` · `project_status` · `marketplace_sale` · `marketplace_purchase` · `payout_request` · `payout_status` · `subscription`

**Endpoints:** list · unread-count · mark read · mark all read · preferences (`PATCH /users/settings/notifications/update/`)

**Notification preferences:** collaboration_requests · brief_updates · new_briefs · marketing_emails · push_enabled · messages

---

### 5.11 Connections
LinkedIn-style connection graph between creators.

**States:** `pending` → `accepted` / `rejected`

**Endpoints:**

| Action | Endpoint |
|---|---|
| Send request | `POST /users/connections/send/` → `{receiver_id}` |
| Accept | `POST /users/connections/{id}/accept/` |
| Reject | `POST /users/connections/{id}/reject/` |
| My connections | `GET /users/connections/connected/` |
| Received requests | `GET /users/connections/received/` |
| Sent requests | `GET /users/connections/sent/` |
| Block user | `POST /users/blocks/` → `{user_id}` |
| Unblock | `DELETE /users/blocks/{id}/` |

---

### 5.12 Subscriptions & Payments

**Plans** (`GET /subscriptions/plans/`): name · slug · price · billing_cycle · is_most_popular · plan_features · stripe_price_id

**Subscribe flow:**
1. User views plans screen
2. Enters coupon code → `POST /subscriptions/coupon/validate/`
3. Taps subscribe → `POST /subscriptions/checkout/` → Stripe Checkout URL
4. On success webhook → subscription activated
5. User can `POST /subscriptions/change-plan/` or `POST /subscriptions/cancel/`

**Payment methods** (`GET|POST /payments/methods/`): saved Stripe cards with card_type · last_four · cardholder_name · expiry · is_default

**Payout flow:**
1. `GET /payments/payouts/balance/` → available_balance · processing_fee_rate · minimum_payout
2. `POST /payments/payouts/request/` → {amount, withdrawal_reason, payout_method, account_details}
3. Admin approves → `POST /payments/admin/payouts/{id}/approve/`
4. Admin completes → `POST /payments/admin/payouts/{id}/complete/`

**Refund flow:**
1. `POST /payments/refunds/request/` → {transaction_id, refund_amount, reason}
2. Admin processes → approve or reject

---

### 5.13 Settings
Grouped under a Settings root screen with sub-sections.

| Section | Key actions |
|---|---|
| **Account** | View email · change password · delete account |
| **Profile** | Update name · bio · location · website · role · genres · skills · profile picture · cover photo |
| **Security** | Toggle 2FA · update privacy (profile_visibility · show_activity_status · allow_connection_requests) · logout all sessions |
| **Notifications** | Toggle prefs per notification type |
| **Storage** | View breakdown by file type (audio · images · videos · documents) in bytes |
| **Subscription** | View current plan + available plans |
| **Payments** | Manage saved cards + payout summary |

---

### 5.14 Support
User-submitted help tickets.

**Create ticket:** `POST /support/` → {subject, message, priority: high|medium|low, attachment?}

**Track tickets:** `GET /support/my-tickets/` → list with status

**Ticket detail:** `GET /support/my-tickets/{id}/` → full message thread including admin replies

---

### 5.15 Admin Panel
Accessible only to users with `role: admin`. Separate navigation tree — not part of the bottom nav bar.

| Section | Key capabilities |
|---|---|
| Dashboard | Platform-wide KPI overview |
| Users | List · search · view detail · approve · ban · suspend · delete · export CSV |
| Analytics | Summary · user growth · retention rate · revenue by tier · top creators · top genres · export CSV |
| Activity Log | Per-user action audit trail · stats · export CSV |
| Briefs | List all briefs · approve / close · view + approve/reject submissions |
| Subscriptions | List plans · manage features · manage coupons · list subscribers · pause/ban/refund |
| Storage | Platform overview · monthly growth · per-user usage · increase user quota |
| Payments | Payout requests (approve/complete/reject) · refund requests (approve/reject) · stats |
| Marketplace | Transactions (confirm/refund) · payout requests (process) |
| Reports | User reports · ban/suspend/warn/resolve actions · stats |
| Support | All tickets · reply · update status/priority |
| Settings | Admin roles · permission matrix · system announcements · plan pricing |

---

## 6. API Reference

**Base URL:** `https://api.spartst.com/api/v1`

**Authentication:** `Authorization: Bearer <access_token>`

**Pagination:** cursor-based — responses include `count`, `next`, `previous`, `results`

### Complete Endpoint List

#### Auth
```
POST   /users/auth/login/
POST   /users/auth/register/
POST   /users/auth/logout/
POST   /users/auth/reset-password/
POST   /users/auth/change-password/
POST   /users/auth/token/refresh/
```

#### Users & Profile
```
GET    /users/users/
GET    /users/users/me/
PATCH  /users/users/me/
GET    /users/users/{id}/
PUT    /users/users/{id}/
PATCH  /users/users/{id}/
DELETE /users/users/{id}/
GET    /users/users/{id}/profile/
GET    /users/dashboard/
GET    /users/creators/
GET    /users/genres/
GET    /users/skills/
GET    /users/works/
POST   /users/works/
GET    /users/works/{id}/
PUT    /users/works/{id}/
PATCH  /users/works/{id}/
DELETE /users/works/{id}/
```

#### Connections & Blocks
```
POST   /users/connections/send/
GET    /users/connections/connected/
GET    /users/connections/received/
GET    /users/connections/sent/
POST   /users/connections/{id}/accept/
POST   /users/connections/{id}/reject/
GET    /users/blocks/
POST   /users/blocks/
DELETE /users/blocks/{id}/
```

#### Settings
```
GET    /users/settings/account/
POST   /users/settings/account/change-password/
DELETE /users/settings/account/delete/
GET    /users/settings/profile/
PATCH  /users/settings/profile/update/
DELETE /users/settings/profile/profile-picture/
DELETE /users/settings/profile/cover-photo/
GET    /users/settings/security/
POST   /users/settings/security/2fa/toggle/
PATCH  /users/settings/security/privacy/
POST   /users/settings/security/sessions/logout-all/
GET    /users/settings/notifications/
PATCH  /users/settings/notifications/update/
GET    /users/settings/storage/
GET    /users/settings/subscription/
GET    /users/settings/payments/methods/
GET    /users/settings/payments/payouts/
```

#### Feed
```
GET    /feed/
POST   /feed/
GET    /feed/{id}/
PUT    /feed/{id}/
PATCH  /feed/{id}/
DELETE /feed/{id}/
POST   /feed/{id}/like/
POST   /feed/{id}/save/
POST   /feed/{id}/share/
POST   /feed/{id}/report/
GET    /feed/{id}/comments/
POST   /feed/{id}/comments/add/
DELETE /feed/{id}/comments/{comment_pk}/
```

#### Briefs
```
GET    /briefs/
POST   /briefs/
GET    /briefs/my/
GET    /briefs/my-submissions/
GET    /briefs/{id}/
PUT    /briefs/{id}/
PATCH  /briefs/{id}/
DELETE /briefs/{id}/
POST   /briefs/{id}/apply/
GET    /briefs/{id}/submissions/
PATCH  /briefs/{id}/submissions/{sub_pk}/status/
```

#### Projects
```
GET    /projects/
POST   /projects/
GET    /projects/{id}/
PATCH  /projects/{id}/
DELETE /projects/{id}/
GET    /projects/{id}/collaborators/
POST   /projects/{id}/collaborators/
DELETE /projects/{id}/collaborators/leave/
DELETE /projects/{id}/collaborators/{cid}/
PATCH  /projects/{id}/collaborators/{cid}/role/
GET    /projects/{id}/comments/
POST   /projects/{id}/comments/
DELETE /projects/{id}/comments/{cid}/
GET    /projects/{id}/files/
POST   /projects/{id}/files/
DELETE /projects/{id}/files/{fid}/
GET    /projects/{id}/files/{fid}/download/
GET    /projects/{id}/lyrics/
POST   /projects/{id}/lyrics/
GET    /projects/{id}/lyrics/{lid}/
PATCH  /projects/{id}/lyrics/{lid}/
DELETE /projects/{id}/lyrics/{lid}/
GET    /projects/{id}/progress/
GET    /projects/{id}/splits/
PUT    /projects/{id}/splits/
```

#### Sessions
```
GET    /sessions/
POST   /sessions/
POST   /sessions/join-by-link/
GET    /sessions/my-invites/
GET    /sessions/{id}/
PATCH  /sessions/{id}/
DELETE /sessions/{id}/
POST   /sessions/{id}/start/
POST   /sessions/{id}/end/
POST   /sessions/{id}/join/
POST   /sessions/{id}/leave/
POST   /sessions/{id}/invite/
POST   /sessions/{id}/invites/respond/
GET    /sessions/{id}/call-token/
GET    /sessions/{id}/messages/
POST   /sessions/{id}/messages/send/
GET    /sessions/{id}/participants/
```

#### Marketplace
```
GET    /marketplace/assets/
POST   /marketplace/assets/
GET    /marketplace/assets/my-assets/
GET    /marketplace/assets/{id}/
PUT    /marketplace/assets/{id}/
PATCH  /marketplace/assets/{id}/
DELETE /marketplace/assets/{id}/
POST   /marketplace/assets/{id}/play/
POST   /marketplace/checkout/
GET    /marketplace/earnings/
GET    /marketplace/licenses/purchased/
GET    /marketplace/payouts/
POST   /marketplace/payouts/
```

#### Payments
```
GET    /payments/methods/
POST   /payments/methods/
DELETE /payments/methods/{id}/
POST   /payments/methods/{id}/set-default/
GET    /payments/payouts/balance/
GET    /payments/payouts/history/
POST   /payments/payouts/request/
GET    /payments/refunds/history/
POST   /payments/refunds/request/
```

#### Subscriptions
```
GET    /subscriptions/plans/
GET    /subscriptions/plans/{id}/
GET    /subscriptions/me/
POST   /subscriptions/subscribe/
POST   /subscriptions/checkout/
POST   /subscriptions/cancel/
POST   /subscriptions/change-plan/
GET    /subscriptions/billing-history/
POST   /subscriptions/coupon/validate/
```

#### Messaging
```
GET    /messaging/conversations/
POST   /messaging/conversations/
GET    /messaging/conversations/{id}/
DELETE /messaging/conversations/{id}/
GET    /messaging/conversations/{id}/messages/
```

#### Notifications
```
GET    /notifications/
GET    /notifications/unread-count/
PATCH  /notifications/read-all/
GET    /notifications/{id}/
PATCH  /notifications/{id}/read/
```

#### Reports & Support
```
POST   /reports/submit/
GET    /reports/my-reports/
POST   /support/
GET    /support/my-tickets/
GET    /support/my-tickets/{id}/
```

---

## 7. Data Models

### Core Models

#### UserModel
```dart
class UserModel {
  final String id;
  final String email;
  final String firstName;
  final String lastName;
  final String displayName;
  final String bestDescribeYou;   // role: artist | producer | label | etc.
  final String location;
  final String? profilePicture;
  final String? coverPhoto;
  final String? bio;
  final String? website;
  final bool isVerified;
  final List<GenreModel> genres;
  final List<SkillModel> skills;
}
```

#### PostModel
```dart
class PostModel {
  final String id;
  final UserModel user;
  final String postType;          // audio | video | photo | lyrics
  final String? title;
  final String? description;
  final String? lyrics;
  final String? audioFile;
  final String? videoFile;
  final String? photo;
  final List<String> genres;
  final bool allowDownloads;
  final bool allowComments;
  final int likesCount;
  final int commentsCount;
  final int sharesCount;
  final int savesCount;
  final bool isLiked;
  final bool isSaved;
  final bool isShared;
  final DateTime createdAt;
}
```

#### SpartSessionListModel
```dart
class SpartSessionListModel {
  final String id;
  final String title;
  final String description;
  final String privacy;           // public | private | invite_only
  final String status;            // scheduled | live | ended
  final String sessionLink;
  final DateTime? scheduledAt;
  final DateTime? startedAt;
  final DateTime? endedAt;
  final SessionHostModel host;
  final int participantCount;
  final int activeParticipants;
}
```

#### AssetListModel
```dart
class AssetListModel {
  final String id;
  final String sellerName;
  final String title;
  final String assetType;         // beat_track | lyrics | sample_pack | visual_asset
  final String genre;
  final double price;
  final String licenseType;       // non_exclusive | exclusive
  final List<String> tags;
  final int? bpm;
  final String? key;
  final String? coverImage;
  final String? previewFile;
  final int playCount;
  final int salesCount;
  final bool isSold;
}
```

#### DashboardModel
```dart
class DashboardModel {
  final DashboardUserModel user;
  final DashboardStatsModel stats;
  final List<SuggestedCreatorModel> suggestedForYou;
  final List<OpenBriefModel> openIndustryBriefs;
  final List<TrendingCreatorModel> trendingThisWeek;
  final List<dynamic> inTheSpotlight;
  final List<ActiveProjectModel> activeProjects;
  final UpgradePanelModel upgradePanel;
}
```

#### ProjectDetailModel
```dart
class ProjectDetailModel {
  final String id;
  final String title;
  final String genre;
  final String projectType;
  final String status;
  final String? sourceBriefId;
  final UserModel owner;
  final List<CollaboratorModel> collaborators;
  final ProjectProgressModel progress;
}
```

#### BriefDetailModel
```dart
class BriefDetailModel {
  final String id;
  final String title;
  final String company;
  final String companyType;
  final String category;
  final String overview;
  final String lookingFor;
  final List<String> genres;
  final double? budgetMin;
  final double? budgetMax;
  final DateTime submissionDeadline;
  final List<String> requirements;
  final List<String> deliverables;
  final bool allowDirectMessages;
  final int applicationsCount;
  final int daysLeft;
  final bool isFeatured;
  final String status;
  final bool hasApplied;
  final String? userSubmissionStatus;
}
```

#### PlanListModel
```dart
class PlanListModel {
  final String id;
  final String name;
  final String slug;
  final String description;
  final double price;
  final String billingCycle;
  final bool isActive;
  final bool isMostPopular;
  final String stripePriceId;
  final List<PlanFeatureModel> planFeatures;
  final int subscriberCount;
}
```

---

## 8. State Management

Every feature ViewModel extends `ChangeNotifier` and exposes:

```dart
ViewState get state;          // current loading state
T? get data;                  // typed model or list
String get errorMessage;      // populated on error state
Future<void> load();          // primary fetch method
Future<void> refresh();       // pull-to-refresh
```

**Provider registration** in `app.dart` uses `MultiProvider` with `ProxyProvider` chaining:

```
ApiClient
  → DashboardRepository    → DashboardViewModel
  → FeedRepository         → FeedViewModel
  → SessionsRepository     → SessionsListViewModel, LiveSessionViewModel
  → MarketplaceRepository  → MarketplaceViewModel, AssetDetailViewModel
  → ProfileRepository      → MyProfileViewModel, PublicProfileViewModel
  → ...all other repos
```

Scoped ViewModels (e.g. `PostDetailViewModel`, `LiveSessionViewModel`) are registered with `ChangeNotifierProvider` inside the specific screen's subtree, not at the root — to avoid memory leaks.

---

## 9. Navigation & Routing

GoRouter with a `ShellRoute` for the bottom nav bar:

```
/login                          LoginScreen
/register                       RegisterScreen
/forgot-password                ForgotPasswordScreen

[ShellRoute → MainNavShell]
  /dashboard                    DashboardScreen
  /feed                         FeedScreen
    /feed/post/:id              PostDetailScreen
    /feed/create                CreatePostScreen
  /sessions                     SessionsScreen
    /sessions/create            CreateSessionScreen
    /sessions/invites           MyInvitesScreen
    /sessions/:id               SessionDetailScreen
    /sessions/:id/live          LiveSessionScreen
  /marketplace                  MarketplaceScreen
    /marketplace/asset/:id      AssetDetailScreen
    /marketplace/upload         UploadAssetScreen
    /marketplace/my-assets      MyAssetsScreen
    /marketplace/earnings       EarningsScreen
  /profile                      MyProfileScreen
    /profile/edit               EditProfileScreen
    /profile/works              WorksScreen
    /profile/user/:id           PublicProfileScreen

[Outside Shell]
  /briefs                       BriefsListScreen
  /briefs/:id                   BriefDetailScreen
  /briefs/:id/apply             ApplyToBriefScreen
  /projects                     ProjectsListScreen
  /projects/:id                 ProjectDetailScreen
  /messaging                    ConversationsScreen
  /messaging/:id                ChatScreen
  /notifications                NotificationsScreen
  /settings                     SettingsScreen
    /settings/account           AccountSettingsScreen
    /settings/profile           ProfileSettingsScreen
    /settings/security          SecuritySettingsScreen
    /settings/notifications     NotificationSettingsScreen
    /settings/storage           StorageSettingsScreen
  /subscriptions                PlansScreen
  /payments                     PaymentMethodsScreen
  /admin                        AdminDashboardScreen (role guard)
```

---

## 10. Real-time Features

### Sessions (ZegoCloud)
1. User joins session → `GET /sessions/{id}/call-token/`
2. Response contains a ZegoCloud token
3. App initialises ZegoCloud SDK with the token
4. Audio/video call renders in `LiveSessionScreen`

### In-session Chat (WebSocket)
- `WebSocketClient` connects to the session's message stream
- Sends `POST /sessions/{id}/messages/send/` for new messages
- Receives new messages via WebSocket broadcast
- `LiveSessionViewModel` manages the WebSocket lifecycle (connect on join, disconnect on leave/end)

### 1:1 Messaging (WebSocket)
- Same `WebSocketClient` with a different channel per conversation
- `ChatViewModel` subscribes on screen entry, unsubscribes on exit

### Offline Banner
- `ConnectivityService` (connectivity_plus) exposes a `Stream<bool>`
- `OfflineBanner` widget sits inside `MainNavShell` above the child content
- Slides down when `isConnected == false`, slides up when reconnected

---

## 11. File Uploads & Media

### Upload types per feature

| Feature | File types | Field name |
|---|---|---|
| Profile picture | JPG · PNG | `profile_picture` |
| Cover photo | JPG · PNG | `cover_photo` |
| Post (audio) | MP3 · WAV · M4A | `audio_file` |
| Post (video) | MP4 · MOV | `video_file` |
| Post (photo) | JPG · PNG | `photo` |
| Work (portfolio) | any | `file` |
| Project file | any | `file` |
| Project lyrics | PDF · TXT | `file` |
| Asset (preview) | MP3 · WAV | `preview_file` |
| Asset (full) | MP3 · WAV · ZIP | `asset_file` |
| Asset (cover) | JPG · PNG | `cover_image` |
| Support ticket | any | `attachment` |

All uploads use `multipart/form-data` via Dio's `FormData` + `MultipartFile`.

### Storage Quota
- Each user has a storage quota visible in Settings → Storage
- `GET /users/settings/storage/` returns breakdown by file type in bytes
- `StorageBarWidget` renders a coloured segmented progress bar
- Admin can increase a user's quota via `PATCH /admin-hub/storage/users/{id}/increase-limit/`

---

## 12. Authentication Flow

```
App launch
  └─ AuthTokenService.hasToken()
       ├─ true  → load /users/users/me/ → Dashboard
       └─ false → LoginScreen

LoginScreen
  └─ POST /users/auth/login/
       ├─ success → save {access, refresh} → Dashboard
       └─ fail    → show error

Every API request
  └─ AuthInterceptor adds: Authorization: Bearer <access>
       └─ 401 response
            └─ POST /users/auth/token/refresh/
                 ├─ success → retry original request with new access token
                 └─ fail    → clear tokens → redirect to Login

Logout
  └─ POST /users/auth/logout/
  └─ AuthTokenService.clearTokens()
  └─ Navigate to Login

Security Settings
  └─ POST /users/settings/security/2fa/toggle/
  └─ POST /users/settings/security/sessions/logout-all/
```

---

## 13. Folder Structure

```
lib/
├── main.dart
├── app.dart
│
├── core/
│   ├── constants/
│   │   ├── api_endpoints.dart
│   │   ├── app_colors.dart
│   │   ├── app_text_styles.dart
│   │   ├── app_dimensions.dart
│   │   ├── app_spacing.dart
│   │   ├── app_durations.dart
│   │   ├── app_assets.dart
│   │   ├── app_strings.dart
│   │   └── app_routes.dart
│   ├── network/
│   │   ├── api_client.dart
│   │   ├── auth_interceptor.dart
│   │   ├── logging_interceptor.dart
│   │   ├── retry_interceptor.dart
│   │   └── websocket_client.dart
│   ├── services/
│   │   ├── auth_token_service.dart
│   │   ├── connectivity_service.dart
│   │   ├── notification_service.dart
│   │   └── local_storage_service.dart
│   ├── errors/
│   │   ├── app_exception.dart
│   │   ├── no_internet_exception.dart
│   │   ├── unauthorized_exception.dart
│   │   ├── server_exception.dart
│   │   └── error_handler.dart
│   ├── utils/
│   │   ├── validators.dart
│   │   ├── date_formatter.dart
│   │   ├── file_utils.dart
│   │   └── storage_formatter.dart
│   ├── router/
│   │   ├── app_router.dart
│   │   └── route_guards.dart
│   ├── theme/
│   │   ├── app_theme.dart
│   │   └── theme_viewmodel.dart
│   └── widgets/
│       ├── main_nav_shell.dart
│       ├── offline_banner.dart
│       ├── shimmer_box.dart
│       ├── empty_state_widget.dart
│       ├── error_state_widget.dart
│       ├── app_button.dart
│       ├── app_text_field.dart
│       ├── avatar_widget.dart
│       ├── genre_chip.dart
│       ├── skill_chip.dart
│       ├── storage_bar_widget.dart
│       └── paginated_list_widget.dart
│
└── features/
    ├── auth/
    │   ├── models/           login · register · token · user
    │   ├── repositories/     auth_repository.dart
    │   ├── viewmodels/       login · register · forgot_password
    │   └── views/            login · register · forgot_password · change_password screens
    │
    ├── dashboard/
    │   ├── models/           dashboard · user · stats · suggested_creator · trending_creator
    │   │                     open_brief · active_project · upgrade_panel
    │   ├── repositories/     dashboard_repository.dart
    │   ├── viewmodels/       dashboard_viewmodel.dart
    │   └── views/            dashboard_screen + 8 widgets
    │
    ├── feed/
    │   ├── models/           post · comment · report
    │   ├── repositories/     feed_repository.dart
    │   ├── viewmodels/       feed · post_detail · create_post
    │   └── views/            feed · post_detail · create_post screens + 6 widgets
    │
    ├── sessions/
    │   ├── models/           session_list · session_detail · session_write
    │   │                     participant · message · respond_invite
    │   ├── repositories/     sessions_repository.dart
    │   ├── viewmodels/       sessions_list · session_detail · create_session · live_session
    │   └── views/            sessions · session_detail · create_session · live_session
    │                         · my_invites screens + 6 widgets
    │
    ├── marketplace/
    │   ├── models/           asset_list · asset_detail · asset_write
    │   │                     transaction · payout_summary · payout_request
    │   ├── repositories/     marketplace_repository.dart
    │   ├── viewmodels/       marketplace · asset_detail · upload_asset · earnings
    │   └── views/            marketplace · asset_detail · upload_asset · my_assets
    │                         · earnings · purchased_licenses screens + 6 widgets
    │
    ├── profile/
    │   ├── models/           user · creator · work · work_create · genre · skill
    │   ├── repositories/     profile_repository.dart
    │   ├── viewmodels/       my_profile · public_profile · edit_profile · works
    │   └── views/            my_profile · public_profile · edit_profile · works
    │                         · creators screens + 7 widgets
    │
    ├── briefs/
    │   ├── models/           brief_list · brief_detail · brief_write
    │   │                     brief_submission · my_submission · apply
    │   ├── repositories/     briefs_repository.dart
    │   ├── viewmodels/       briefs_list · brief_detail · apply_brief · my_submissions
    │   └── views/            briefs_list · brief_detail · apply · my_briefs
    │                         · my_submissions screens + 3 widgets
    │
    ├── projects/
    │   ├── models/           project_list · project_detail · project_write
    │   │                     collaborator · invite_collaborator · project_file
    │   │                     lyrics · project_progress · revenue_split
    │   ├── repositories/     projects_repository.dart
    │   ├── viewmodels/       projects_list · project_detail · project_files
    │   │                     project_lyrics · collaborators · revenue_split
    │   └── views/            projects_list · project_detail · project_files
    │                         · project_lyrics · collaborators · revenue_split screens + 5 widgets
    │
    ├── messaging/
    │   ├── models/           conversation · message
    │   ├── repositories/     messaging_repository.dart
    │   ├── viewmodels/       conversations · chat
    │   └── views/            conversations · chat screens + 4 widgets
    │
    ├── notifications/
    │   ├── models/           notification · notification_pref
    │   ├── repositories/     notifications_repository.dart
    │   ├── viewmodels/       notifications_viewmodel.dart
    │   └── views/            notifications_screen + 2 widgets
    │
    ├── connections/
    │   ├── models/           connection · send_connection · block_user
    │   ├── repositories/     connections_repository.dart
    │   ├── viewmodels/       connections · blocked_users
    │   └── views/            connections · blocked_users screens + 2 widgets
    │
    ├── settings/
    │   ├── models/           settings_account · settings_profile · privacy_settings
    │   │                     storage_breakdown
    │   ├── repositories/     settings_repository.dart
    │   ├── viewmodels/       account · profile · security · notification · storage settings
    │   └── views/            settings · account · profile · security
    │                         · notifications · storage screens + settings_tile
    │
    ├── subscriptions/
    │   ├── models/           plan_list · plan_feature · subscribe
    │   │                     validate_coupon · change_plan · billing_history
    │   ├── repositories/     subscriptions_repository.dart
    │   ├── viewmodels/       plans · checkout · my_subscription
    │   └── views/            plans · plan_detail · checkout · billing_history
    │                         · my_subscription screens + 4 widgets
    │
    ├── payments/
    │   ├── models/           payment_method · add_payment_method · balance
    │   │                     payout_history · request_payout · refund_request
    │   ├── repositories/     payments_repository.dart
    │   ├── viewmodels/       payment_methods · payout · refunds
    │   └── views/            payment_methods · add_payment_method · payout_balance
    │                         · payout_history · request_payout · refund_history + 3 widgets
    │
    ├── support/
    │   ├── models/           create_ticket · support_ticket · ticket_message
    │   ├── repositories/     support_repository.dart
    │   ├── viewmodels/       support · ticket_detail
    │   └── views/            support · create_ticket · ticket_detail screens + 2 widgets
    │
    └── admin/
        ├── models/           admin_user · activity_log · analytics · brief · storage
        │                     payout · refund · report · announcement · role_permission
        │                     plan_pricing · admin_support_ticket  (19 models)
        ├── repositories/     admin_repository.dart
        ├── viewmodels/       dashboard · users · user_detail · analytics · activity_log
        │                     briefs · storage · payouts · refunds · reports · support
        │                     announcements · roles · plan_pricing  (14 viewmodels)
        └── views/            15 admin screens + 6 widgets
```

---

## 14. Environment & Configuration

`.env` file (never committed):

```env
API_BASE_URL=https://api.spartst.com/api/v1
STRIPE_PUBLISHABLE_KEY=pk_live_...
ZEGOCLOUD_APP_ID=...
ZEGOCLOUD_APP_SIGN=...
FIREBASE_PROJECT_ID=...
SENTRY_DSN=...
```

Loaded via `flutter_dotenv`:
```dart
await dotenv.load(fileName: '.env');
```

**Flavors:** `development` · `staging` · `production` — each with its own `.env` file and Firebase config.

---

## 15. Dependencies

```yaml
dependencies:
  flutter:
    sdk: flutter

  # State
  provider: ^6.1.0

  # Navigation
  go_router: ^13.0.0

  # Networking
  dio: ^5.4.0
  connectivity_plus: ^6.0.0

  # Real-time
  web_socket_channel: ^2.4.0
  zego_uikit_prebuilt_call: ^4.0.0    # ZegoCloud SDK

  # Storage
  flutter_secure_storage: ^9.0.0
  shared_preferences: ^2.2.0

  # UI
  flutter_screenutil: ^5.9.0
  shimmer: ^3.0.0
  lottie: ^3.0.0
  cached_network_image: ^3.3.0

  # Media
  image_picker: ^1.0.0
  video_player: ^2.8.0
  file_picker: ^8.0.0
  just_audio: ^0.9.0                  # Audio preview player

  # Push notifications
  firebase_core: ^2.0.0
  firebase_messaging: ^14.0.0

  # Payments
  flutter_stripe: ^10.0.0

  # Env & config
  flutter_dotenv: ^5.1.0
  permission_handler: ^11.0.0

  # Serialization
  json_annotation: ^4.8.0

dev_dependencies:
  flutter_test:
    sdk: flutter
  mockito: ^5.4.0
  build_runner: ^2.4.0
  json_serializable: ^6.7.0
  flutter_lints: ^3.0.0
```

---

## 16. Complexity & Scope

### API Surface
| Metric | Count |
|---|---|
| Total API paths | 213 |
| Total HTTP operations | 260 |
| Data schemas | 258 |
| Feature modules | 15 |
| Admin-only endpoint groups | 7 |

### App Scope
| Metric | Estimate |
|---|---|
| Screens | ~65 |
| ViewModels | ~55 |
| Repositories | ~15 |
| Models | ~80 |
| Shared widgets | ~45 |
| Dart files total | ~350–380 |

### Complexity Factors
| Factor | Level | Notes |
|---|---|---|
| Real-time (Sessions + Messaging) | 🔴 High | WebSocket + ZegoCloud SDK integration |
| Payments (Stripe + Payouts + Refunds) | 🔴 High | 3 separate payment flows |
| Role-based access (User vs Admin) | 🔴 High | Separate navigation tree + route guards |
| File uploads (audio, video, image, docs) | 🟠 Medium | Multipart forms + storage quota logic |
| Feed (multiple post types + interactions) | 🟠 Medium | Polymorphic card, toggle actions |
| Subscriptions (plans, coupons, billing) | 🟠 Medium | Stripe checkout + webhook integration |
| Social graph (connections, blocks) | 🟡 Low-Medium | Standard CRUD + status FSM |

### Overall Complexity
**🔴 Enterprise / Tier 3**

**Recommended team:** 4–5 Flutter developers
**Recommended MVP timeline:** 20–24 weeks

### Sprint Breakdown (Suggested)
| Sprint | Focus |
|---|---|
| 1–2 | Core setup: project structure · ApiClient · Auth · navigation shell |
| 3–4 | Dashboard + Feed (read-only) |
| 5–6 | Feed interactions · Profile · Edit Profile |
| 7–8 | Sessions (list + detail) · Live session (ZegoCloud) |
| 9–10 | Marketplace (browse + detail + preview player) |
| 11–12 | Marketplace (upload + checkout + earnings) |
| 13–14 | Projects (CRUD + files + lyrics + splits) |
| 15–16 | Briefs (list + apply + my submissions) |
| 17–18 | Messaging · Notifications · Connections |
| 19–20 | Settings · Subscriptions · Payments |
| 21–22 | Admin panel |
| 23–24 | QA · Performance · App store submission |