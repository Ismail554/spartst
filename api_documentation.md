# Cellis || SPARTST — API Documentation
## Base URL: `https://api.spartst.com/api/v1`

**Auth:** `Authorization: Bearer <access_token>` required on all endpoints except `/users/auth/*`

**Pagination:** paginated responses include `count`, `next`, `previous`, `results[]`

---

## Table of Contents
1. [Auth](#auth)
2. [Users & Profile](#users--profile)
3. [Connections & Blocks](#connections--blocks)
4. [Settings](#settings)
5. [Feed](#feed)
6. [Briefs](#briefs)
7. [Projects](#projects)
8. [Sessions](#sessions)
9. [Marketplace](#marketplace)
10. [Payments](#payments)
11. [Subscriptions](#subscriptions)
12. [Messaging](#messaging)
13. [Notifications](#notifications)
14. [Reports](#reports)
15. [Support](#support)
16. [Admin Hub](#admin-hub)

---

## Auth

### `POST` /api/v1/users/auth/login/
**Login with email and password**

**Request Body** (application/json)

```json
{
  "email": "user@example.com", // required
  "password": "string" // required
}
```

**Response:** `200` No content

---

### `POST` /api/v1/users/auth/register/
**Register a new user**

**Request Body** (application/json)

```json
{
  "email": "user@example.com", // required
  "first_name": "string", // required
  "last_name": "string", // required
  "password": "string", // required
  "password2": "string", // required
  "display_name": "string",
  "best_describe_you": "string",
  "location": "string",
  "bio": "string",
  "website": "https://example.com/file.mp3",
  "social_links": {},
  "genre_ids": "string",
  "skill_ids": "string",
  "works": [
    {
          "title": "string", // required
          "description": "string",
          "file": "https://example.com/file.mp3" // required
        }
    ]
}
```

**Response:** `201` No content

---

### `POST` /api/v1/users/auth/logout/
**Logout**

**Response:** `205` No content

---

### `POST` /api/v1/users/auth/reset-password/
**Request password reset via email**

**Request Body** (application/json)

```json
{
  "email": "user@example.com" // required
}
```

**Response:** `200` No content

---

### `POST` /api/v1/users/auth/change-password/
**Change password**

**Request Body** (application/json)

```json
{
  "old_password": "string", // required
  "new_password": "string" // required
}
```

**Response:** `200` No content

---

### `POST` /api/v1/users/auth/token/refresh/
**api_v1_users_auth_token_refresh_create**

**Request Body** (application/json)

```json
{
  "access": "string", // required
  "refresh": "string" // required
}
```

**Response `200`**

```json
{
  "access": "string", // required
  "refresh": "string" // required
}
```

---

## Users & Profile

### `GET` /api/v1/users/creators/
**Discover creators**

**Query Parameters**

| Parameter | Type | Required | Description |
|---|---|---|---|
| `best_describe_you` | string | — | Comma-separated role values to filter by |
| `genre_ids` | string | — | Comma-separated genre IDs to filter by |
| `location` | string | — | Filter by location (case-insensitive partial match) |
| `page` | integer | — | A page number within the paginated result set. |
| `search` | string | — | Search by display name, genre, or skill |
| `skill_ids` | string | — | Comma-separated skill IDs to filter by |
| `sort` | string | — | Sort order (default: relevance) |

**Response `200`**

```json
{
  "count": 0, // required
  "next": "https://example.com/file.mp3",
  "previous": "https://example.com/file.mp3",
  "results": [
    {
          "id": 0, // required
          "display_name": "string",
          "profile_picture": "https://example.com/file.mp3", // required
          "cover_photo": "https://example.com/file.mp3", // required
          "best_describe_you": "string", // required
          "location": "string",
          "genres": [
            {
                      "id": "...", // required
                      "name": "..." // required
                    }
            ], // required
          "skills": [
            {
                      "id": "...", // required
                      "name": "..." // required
                    }
            ], // required
          "is_verified": true,
          "connection_count": 0, // required
          "match_score": 0, // required
          "is_connected": true // required
        }
    ] // required
}
```

---

### `GET` /api/v1/users/dashboard/
**Get dashboard overview**

**Response `200`**

```json
{
  "user": {
        "id": 0, // required
        "first_name": "string",
        "last_name": "string",
        "display_name": "string",
        "display": "string", // required
        "profile_picture": "https://example.com/file.mp3" // required
      }, // required
  "stats": {
        "profile_views": 0, // required
        "collaborations": 0, // required
        "active_briefs": 0, // required
        "works_uploaded": 0 // required
      }, // required
  "suggested_for_you": [
    {
          "id": 0, // required
          "name": "string", // required
          "role": "string", // required
          "genres": "string", // required
          "match_percentage": 0, // required
          "profile_picture": "https://example.com/file.mp3", // required
          "connection_status": "string" // required
        }
    ], // required
  "open_industry_briefs": [
    {
          "id": 0, // required
          "title": "string", // required
          "company": "string", // required
          "genres": [
            "string"
            ], // required
          "category": "string", // required
          "days_left": 0, // required
          "is_paid": true, // required
          "is_featured": true // required
        }
    ], // required
  "trending_this_week": [
    {
          "id": 0, // required
          "name": "string", // required
          "role": "string", // required
          "profile_picture": "https://example.com/file.mp3", // required
          "badge": "string" // required
        }
    ], // required
  "in_the_spotlight": {
        "profile_completion": 0, // required
        "is_complete": true // required
      }, // required
  "active_projects": [
    {
          "id": 0, // required
          "title": "string", // required
          "collaborator_name": "string", // required
          "progress": 0, // required
          "updated_at": "string" // required
        }
    ], // required
  "upgrade_panel": {
        "current_plan": "string", // required
        "storage_gb": "string", // required
        "features": [
          "string"
          ], // required
        "show_upgrade": true // required
      } // required
}
```

---

### `GET` /api/v1/users/genres/
**List available genres**

**Query Parameters**

| Parameter | Type | Required | Description |
|---|---|---|---|
| `page` | integer | — | A page number within the paginated result set. |

**Response `200`**

```json
{
  "count": 0, // required
  "next": "https://example.com/file.mp3",
  "previous": "https://example.com/file.mp3",
  "results": [
    {
          "id": 0, // required
          "name": "pop"  // options: pop | hip_hop | rnb | rock | electronic | jazz | country | alternative | soul | indie // required
        }
    ] // required
}
```

---

### `GET` /api/v1/users/skills/
**List available skills**

**Query Parameters**

| Parameter | Type | Required | Description |
|---|---|---|---|
| `page` | integer | — | A page number within the paginated result set. |

**Response `200`**

```json
{
  "count": 0, // required
  "next": "https://example.com/file.mp3",
  "previous": "https://example.com/file.mp3",
  "results": [
    {
          "id": 0, // required
          "name": "mixing"  // options: mixing | mastering | songwriting | composition | vocals | guitar | piano | drums | production | engineering // required
        }
    ] // required
}
```

---

### `GET` /api/v1/users/users/
**List users**

**Query Parameters**

| Parameter | Type | Required | Description |
|---|---|---|---|
| `page` | integer | — | A page number within the paginated result set. |

**Response `200`**

```json
{
  "count": 0, // required
  "next": "https://example.com/file.mp3",
  "previous": "https://example.com/file.mp3",
  "results": [
    {
          "id": 0, // required
          "email": "user@example.com", // required
          "first_name": "string",
          "last_name": "string",
          "display_name": "string",
          "role": {}, // required
          "best_describe_you": "string",
          "location": "string",
          "bio": "string",
          "profile_picture": "https://example.com/file.mp3",
          "cover_photo": "https://example.com/file.mp3",
          "genres": [
            {
                      "id": "...", // required
                      "name": "..." // required
                    }
            ], // required
          "genre_ids": [
            0
            ],
          "skills": [
            {
                      "id": "...", // required
                      "name": "..." // required
                    }
            ], // required
          "skill_ids": [
            0
            ],
          "website": "https://example.com/file.mp3",
          "social_links": {},
          "is_verified": true, // required
          "is_active": true,
          "works": [
            {
                      "id": "...", // required
                      "title": "...", // required
                      "description": "...",
                      "file": "...", // required
                      "created_at": "...", // required
                      "updated_at": "..." // required
                    }
            ], // required
          "profile_complete": "string", // required
          "created_at": "2024-01-01T12:00:00Z", // required
          "updated_at": "2024-01-01T12:00:00Z" // required
        }
    ] // required
}
```

---

### `GET` /api/v1/users/users/me/
**Get or update current user profile**

**Response `200`**

```json
{
  "id": 0, // required
  "email": "user@example.com", // required
  "first_name": "string",
  "last_name": "string",
  "display_name": "string",
  "role": {}, // required
  "best_describe_you": "string",
  "location": "string",
  "bio": "string",
  "profile_picture": "https://example.com/file.mp3",
  "cover_photo": "https://example.com/file.mp3",
  "genres": [
    {
          "id": 0, // required
          "name": "pop"  // options: pop | hip_hop | rnb | rock | electronic | jazz | country | alternative | soul | indie // required
        }
    ], // required
  "genre_ids": [
    0
    ],
  "skills": [
    {
          "id": 0, // required
          "name": "mixing"  // options: mixing | mastering | songwriting | composition | vocals | guitar | piano | drums | production | engineering // required
        }
    ], // required
  "skill_ids": [
    0
    ],
  "website": "https://example.com/file.mp3",
  "social_links": {},
  "is_verified": true, // required
  "is_active": true,
  "works": [
    {
          "id": 0, // required
          "title": "string", // required
          "description": "string",
          "file": "https://example.com/file.mp3", // required
          "created_at": "2024-01-01T12:00:00Z", // required
          "updated_at": "2024-01-01T12:00:00Z" // required
        }
    ], // required
  "profile_complete": "string", // required
  "created_at": "2024-01-01T12:00:00Z", // required
  "updated_at": "2024-01-01T12:00:00Z" // required
}
```

---

### `PATCH` /api/v1/users/users/me/
**Get or update current user profile**

**Request Body** (application/json)

```json
{
  "id": 0,
  "email": "user@example.com",
  "first_name": "string",
  "last_name": "string",
  "display_name": "string",
  "role": {},
  "best_describe_you": "string",
  "location": "string",
  "bio": "string",
  "profile_picture": "https://example.com/file.mp3",
  "cover_photo": "https://example.com/file.mp3",
  "genres": [
    {
          "id": 0, // required
          "name": "pop"  // options: pop | hip_hop | rnb | rock | electronic | jazz | country | alternative | soul | indie // required
        }
    ],
  "genre_ids": [
    0
    ],
  "skills": [
    {
          "id": 0, // required
          "name": "mixing"  // options: mixing | mastering | songwriting | composition | vocals | guitar | piano | drums | production | engineering // required
        }
    ],
  "skill_ids": [
    0
    ],
  "website": "https://example.com/file.mp3",
  "social_links": {},
  "is_verified": true,
  "is_active": true,
  "works": [
    {
          "id": 0, // required
          "title": "string", // required
          "description": "string",
          "file": "https://example.com/file.mp3", // required
          "created_at": "2024-01-01T12:00:00Z", // required
          "updated_at": "2024-01-01T12:00:00Z" // required
        }
    ],
  "profile_complete": "string",
  "created_at": "2024-01-01T12:00:00Z",
  "updated_at": "2024-01-01T12:00:00Z"
}
```

**Response `200`**

```json
{
  "id": 0, // required
  "email": "user@example.com", // required
  "first_name": "string",
  "last_name": "string",
  "display_name": "string",
  "role": {}, // required
  "best_describe_you": "string",
  "location": "string",
  "bio": "string",
  "profile_picture": "https://example.com/file.mp3",
  "cover_photo": "https://example.com/file.mp3",
  "genres": [
    {
          "id": 0, // required
          "name": "pop"  // options: pop | hip_hop | rnb | rock | electronic | jazz | country | alternative | soul | indie // required
        }
    ], // required
  "genre_ids": [
    0
    ],
  "skills": [
    {
          "id": 0, // required
          "name": "mixing"  // options: mixing | mastering | songwriting | composition | vocals | guitar | piano | drums | production | engineering // required
        }
    ], // required
  "skill_ids": [
    0
    ],
  "website": "https://example.com/file.mp3",
  "social_links": {},
  "is_verified": true, // required
  "is_active": true,
  "works": [
    {
          "id": 0, // required
          "title": "string", // required
          "description": "string",
          "file": "https://example.com/file.mp3", // required
          "created_at": "2024-01-01T12:00:00Z", // required
          "updated_at": "2024-01-01T12:00:00Z" // required
        }
    ], // required
  "profile_complete": "string", // required
  "created_at": "2024-01-01T12:00:00Z", // required
  "updated_at": "2024-01-01T12:00:00Z" // required
}
```

---

### `GET` /api/v1/users/users/{id}/
**Retrieve a user**

**Path Parameters**

| Parameter | Type | Description |
|---|---|---|
| `id` | integer |  |

**Response `200`**

```json
{
  "id": 0, // required
  "email": "user@example.com", // required
  "first_name": "string",
  "last_name": "string",
  "display_name": "string",
  "role": {}, // required
  "best_describe_you": "string",
  "location": "string",
  "bio": "string",
  "profile_picture": "https://example.com/file.mp3",
  "cover_photo": "https://example.com/file.mp3",
  "genres": [
    {
          "id": 0, // required
          "name": "pop"  // options: pop | hip_hop | rnb | rock | electronic | jazz | country | alternative | soul | indie // required
        }
    ], // required
  "genre_ids": [
    0
    ],
  "skills": [
    {
          "id": 0, // required
          "name": "mixing"  // options: mixing | mastering | songwriting | composition | vocals | guitar | piano | drums | production | engineering // required
        }
    ], // required
  "skill_ids": [
    0
    ],
  "website": "https://example.com/file.mp3",
  "social_links": {},
  "is_verified": true, // required
  "is_active": true,
  "works": [
    {
          "id": 0, // required
          "title": "string", // required
          "description": "string",
          "file": "https://example.com/file.mp3", // required
          "created_at": "2024-01-01T12:00:00Z", // required
          "updated_at": "2024-01-01T12:00:00Z" // required
        }
    ], // required
  "profile_complete": "string", // required
  "created_at": "2024-01-01T12:00:00Z", // required
  "updated_at": "2024-01-01T12:00:00Z" // required
}
```

---

### `PUT` /api/v1/users/users/{id}/
**Update a user**

**Path Parameters**

| Parameter | Type | Description |
|---|---|---|
| `id` | integer |  |

**Request Body** (application/json)

```json
{
  "id": 0, // required
  "email": "user@example.com", // required
  "first_name": "string",
  "last_name": "string",
  "display_name": "string",
  "role": {}, // required
  "best_describe_you": "string",
  "location": "string",
  "bio": "string",
  "profile_picture": "https://example.com/file.mp3",
  "cover_photo": "https://example.com/file.mp3",
  "genres": [
    {
          "id": 0, // required
          "name": "pop"  // options: pop | hip_hop | rnb | rock | electronic | jazz | country | alternative | soul | indie // required
        }
    ], // required
  "genre_ids": [
    0
    ],
  "skills": [
    {
          "id": 0, // required
          "name": "mixing"  // options: mixing | mastering | songwriting | composition | vocals | guitar | piano | drums | production | engineering // required
        }
    ], // required
  "skill_ids": [
    0
    ],
  "website": "https://example.com/file.mp3",
  "social_links": {},
  "is_verified": true, // required
  "is_active": true,
  "works": [
    {
          "id": 0, // required
          "title": "string", // required
          "description": "string",
          "file": "https://example.com/file.mp3", // required
          "created_at": "2024-01-01T12:00:00Z", // required
          "updated_at": "2024-01-01T12:00:00Z" // required
        }
    ], // required
  "profile_complete": "string", // required
  "created_at": "2024-01-01T12:00:00Z", // required
  "updated_at": "2024-01-01T12:00:00Z" // required
}
```

**Response `200`**

```json
{
  "id": 0, // required
  "email": "user@example.com", // required
  "first_name": "string",
  "last_name": "string",
  "display_name": "string",
  "role": {}, // required
  "best_describe_you": "string",
  "location": "string",
  "bio": "string",
  "profile_picture": "https://example.com/file.mp3",
  "cover_photo": "https://example.com/file.mp3",
  "genres": [
    {
          "id": 0, // required
          "name": "pop"  // options: pop | hip_hop | rnb | rock | electronic | jazz | country | alternative | soul | indie // required
        }
    ], // required
  "genre_ids": [
    0
    ],
  "skills": [
    {
          "id": 0, // required
          "name": "mixing"  // options: mixing | mastering | songwriting | composition | vocals | guitar | piano | drums | production | engineering // required
        }
    ], // required
  "skill_ids": [
    0
    ],
  "website": "https://example.com/file.mp3",
  "social_links": {},
  "is_verified": true, // required
  "is_active": true,
  "works": [
    {
          "id": 0, // required
          "title": "string", // required
          "description": "string",
          "file": "https://example.com/file.mp3", // required
          "created_at": "2024-01-01T12:00:00Z", // required
          "updated_at": "2024-01-01T12:00:00Z" // required
        }
    ], // required
  "profile_complete": "string", // required
  "created_at": "2024-01-01T12:00:00Z", // required
  "updated_at": "2024-01-01T12:00:00Z" // required
}
```

---

### `PATCH` /api/v1/users/users/{id}/
**Partially update a user**

**Path Parameters**

| Parameter | Type | Description |
|---|---|---|
| `id` | integer |  |

**Request Body** (application/json)

```json
{
  "id": 0,
  "email": "user@example.com",
  "first_name": "string",
  "last_name": "string",
  "display_name": "string",
  "role": {},
  "best_describe_you": "string",
  "location": "string",
  "bio": "string",
  "profile_picture": "https://example.com/file.mp3",
  "cover_photo": "https://example.com/file.mp3",
  "genres": [
    {
          "id": 0, // required
          "name": "pop"  // options: pop | hip_hop | rnb | rock | electronic | jazz | country | alternative | soul | indie // required
        }
    ],
  "genre_ids": [
    0
    ],
  "skills": [
    {
          "id": 0, // required
          "name": "mixing"  // options: mixing | mastering | songwriting | composition | vocals | guitar | piano | drums | production | engineering // required
        }
    ],
  "skill_ids": [
    0
    ],
  "website": "https://example.com/file.mp3",
  "social_links": {},
  "is_verified": true,
  "is_active": true,
  "works": [
    {
          "id": 0, // required
          "title": "string", // required
          "description": "string",
          "file": "https://example.com/file.mp3", // required
          "created_at": "2024-01-01T12:00:00Z", // required
          "updated_at": "2024-01-01T12:00:00Z" // required
        }
    ],
  "profile_complete": "string",
  "created_at": "2024-01-01T12:00:00Z",
  "updated_at": "2024-01-01T12:00:00Z"
}
```

**Response `200`**

```json
{
  "id": 0, // required
  "email": "user@example.com", // required
  "first_name": "string",
  "last_name": "string",
  "display_name": "string",
  "role": {}, // required
  "best_describe_you": "string",
  "location": "string",
  "bio": "string",
  "profile_picture": "https://example.com/file.mp3",
  "cover_photo": "https://example.com/file.mp3",
  "genres": [
    {
          "id": 0, // required
          "name": "pop"  // options: pop | hip_hop | rnb | rock | electronic | jazz | country | alternative | soul | indie // required
        }
    ], // required
  "genre_ids": [
    0
    ],
  "skills": [
    {
          "id": 0, // required
          "name": "mixing"  // options: mixing | mastering | songwriting | composition | vocals | guitar | piano | drums | production | engineering // required
        }
    ], // required
  "skill_ids": [
    0
    ],
  "website": "https://example.com/file.mp3",
  "social_links": {},
  "is_verified": true, // required
  "is_active": true,
  "works": [
    {
          "id": 0, // required
          "title": "string", // required
          "description": "string",
          "file": "https://example.com/file.mp3", // required
          "created_at": "2024-01-01T12:00:00Z", // required
          "updated_at": "2024-01-01T12:00:00Z" // required
        }
    ], // required
  "profile_complete": "string", // required
  "created_at": "2024-01-01T12:00:00Z", // required
  "updated_at": "2024-01-01T12:00:00Z" // required
}
```

---

### `DELETE` /api/v1/users/users/{id}/
**Delete a user**

**Path Parameters**

| Parameter | Type | Description |
|---|---|---|
| `id` | integer |  |

**Response:** `204` No content

---

### `GET` /api/v1/users/users/{id}/profile/
**Get user profile**

**Path Parameters**

| Parameter | Type | Description |
|---|---|---|
| `id` | integer |  |

**Query Parameters**

| Parameter | Type | Required | Description |
|---|---|---|---|
| `page` | integer | — | Page number (not used for `about` tab) |
| `page_size` | integer | — | Items per page, max 50 (default 12) |
| `tab` | string | — | Tab to load (default: posts) |

**Response:** `200` No content

---

### `GET` /api/v1/users/works/
**List works**

**Query Parameters**

| Parameter | Type | Required | Description |
|---|---|---|---|
| `page` | integer | — | A page number within the paginated result set. |

**Response `200`**

```json
{
  "count": 0, // required
  "next": "https://example.com/file.mp3",
  "previous": "https://example.com/file.mp3",
  "results": [
    {
          "id": 0, // required
          "title": "string", // required
          "description": "string",
          "file": "https://example.com/file.mp3", // required
          "created_at": "2024-01-01T12:00:00Z", // required
          "updated_at": "2024-01-01T12:00:00Z" // required
        }
    ] // required
}
```

---

### `POST` /api/v1/users/works/
**Upload a new work**

**Request Body** (application/json)

```json
{
  "id": 0, // required
  "title": "string", // required
  "description": "string",
  "file": "https://example.com/file.mp3", // required
  "created_at": "2024-01-01T12:00:00Z", // required
  "updated_at": "2024-01-01T12:00:00Z" // required
}
```

**Response `201`**

```json
{
  "id": 0, // required
  "title": "string", // required
  "description": "string",
  "file": "https://example.com/file.mp3", // required
  "created_at": "2024-01-01T12:00:00Z", // required
  "updated_at": "2024-01-01T12:00:00Z" // required
}
```

---

### `GET` /api/v1/users/works/{id}/
**Retrieve a work**

**Path Parameters**

| Parameter | Type | Description |
|---|---|---|
| `id` | integer |  |

**Response `200`**

```json
{
  "id": 0, // required
  "title": "string", // required
  "description": "string",
  "file": "https://example.com/file.mp3", // required
  "created_at": "2024-01-01T12:00:00Z", // required
  "updated_at": "2024-01-01T12:00:00Z" // required
}
```

---

### `PUT` /api/v1/users/works/{id}/
**Update a work**

**Path Parameters**

| Parameter | Type | Description |
|---|---|---|
| `id` | integer |  |

**Request Body** (application/json)

```json
{
  "id": 0, // required
  "title": "string", // required
  "description": "string",
  "file": "https://example.com/file.mp3", // required
  "created_at": "2024-01-01T12:00:00Z", // required
  "updated_at": "2024-01-01T12:00:00Z" // required
}
```

**Response `200`**

```json
{
  "id": 0, // required
  "title": "string", // required
  "description": "string",
  "file": "https://example.com/file.mp3", // required
  "created_at": "2024-01-01T12:00:00Z", // required
  "updated_at": "2024-01-01T12:00:00Z" // required
}
```

---

### `PATCH` /api/v1/users/works/{id}/
**Partially update a work**

**Path Parameters**

| Parameter | Type | Description |
|---|---|---|
| `id` | integer |  |

**Request Body** (application/json)

```json
{
  "id": 0,
  "title": "string",
  "description": "string",
  "file": "https://example.com/file.mp3",
  "created_at": "2024-01-01T12:00:00Z",
  "updated_at": "2024-01-01T12:00:00Z"
}
```

**Response `200`**

```json
{
  "id": 0, // required
  "title": "string", // required
  "description": "string",
  "file": "https://example.com/file.mp3", // required
  "created_at": "2024-01-01T12:00:00Z", // required
  "updated_at": "2024-01-01T12:00:00Z" // required
}
```

---

### `DELETE` /api/v1/users/works/{id}/
**Delete a work**

**Path Parameters**

| Parameter | Type | Description |
|---|---|---|
| `id` | integer |  |

**Response:** `204` No content

---

## Connections & Blocks

### `GET` /api/v1/users/blocks/
**List blocked users**

**Query Parameters**

| Parameter | Type | Required | Description |
|---|---|---|---|
| `page` | integer | — | A page number within the paginated result set. |

**Response `200`**

```json
{
  "count": 0, // required
  "next": "https://example.com/file.mp3",
  "previous": "https://example.com/file.mp3",
  "results": [
    {
          "id": 0, // required
          "display_name": "string",
          "profile_picture": "https://example.com/file.mp3", // required
          "cover_photo": "https://example.com/file.mp3", // required
          "best_describe_you": "string", // required
          "location": "string",
          "genres": [
            {
                      "id": "...", // required
                      "name": "..." // required
                    }
            ], // required
          "skills": [
            {
                      "id": "...", // required
                      "name": "..." // required
                    }
            ], // required
          "is_verified": true,
          "connection_count": 0, // required
          "match_score": 0, // required
          "is_connected": true // required
        }
    ] // required
}
```

---

### `POST` /api/v1/users/blocks/
**Block a user**

**Request Body** (application/json)

```json
{
  "user_id": 0 // required
}
```

**Response `201`**

```json
{
  "id": 0, // required
  "display_name": "string",
  "profile_picture": "https://example.com/file.mp3", // required
  "cover_photo": "https://example.com/file.mp3", // required
  "best_describe_you": "string", // required
  "location": "string",
  "genres": [
    {
          "id": 0, // required
          "name": "pop"  // options: pop | hip_hop | rnb | rock | electronic | jazz | country | alternative | soul | indie // required
        }
    ], // required
  "skills": [
    {
          "id": 0, // required
          "name": "mixing"  // options: mixing | mastering | songwriting | composition | vocals | guitar | piano | drums | production | engineering // required
        }
    ], // required
  "is_verified": true,
  "connection_count": 0, // required
  "match_score": 0, // required
  "is_connected": true // required
}
```

---

### `DELETE` /api/v1/users/blocks/{id}/
**Unblock a user**

**Path Parameters**

| Parameter | Type | Description |
|---|---|---|
| `id` | integer |  |

**Response:** `204` No content

---

### `GET` /api/v1/users/connections/connected/
**List accepted (connected) users**

**Query Parameters**

| Parameter | Type | Required | Description |
|---|---|---|---|
| `page` | integer | — | A page number within the paginated result set. |
| `search` | string | — | Search connected user by display name |

**Response `200`**

```json
{
  "count": 0, // required
  "next": "https://example.com/file.mp3",
  "previous": "https://example.com/file.mp3",
  "results": [
    {
          "id": 0, // required
          "sender": {
                    "id": 0, // required
                    "display_name": "string",
                    "profile_picture": "https://example.com/file.mp3", // required
                    "cover_photo": "https://example.com/file.mp3", // required
                    "best_describe_you": "string", // required
                    "location": "string",
                    "genres": [
                      "..."
                      ], // required
                    "skills": [
                      "..."
                      ], // required
                    "is_verified": true,
                    "connection_count": 0, // required
                    "match_score": 0, // required
                    "is_connected": true // required
                  }, // required
          "receiver": {
                    "id": 0, // required
                    "display_name": "string",
                    "profile_picture": "https://example.com/file.mp3", // required
                    "cover_photo": "https://example.com/file.mp3", // required
                    "best_describe_you": "string", // required
                    "location": "string",
                    "genres": [
                      "..."
                      ], // required
                    "skills": [
                      "..."
                      ], // required
                    "is_verified": true,
                    "connection_count": 0, // required
                    "match_score": 0, // required
                    "is_connected": true // required
                  }, // required
          "status": {}, // required
          "created_at": "2024-01-01T12:00:00Z", // required
          "updated_at": "2024-01-01T12:00:00Z" // required
        }
    ] // required
}
```

---

### `GET` /api/v1/users/connections/received/
**List received connection requests**

**Query Parameters**

| Parameter | Type | Required | Description |
|---|---|---|---|
| `page` | integer | — | A page number within the paginated result set. |
| `search` | string | — | Search sender by display name |
| `status` | string | — | Filter by status |

**Response `200`**

```json
{
  "count": 0, // required
  "next": "https://example.com/file.mp3",
  "previous": "https://example.com/file.mp3",
  "results": [
    {
          "id": 0, // required
          "sender": {
                    "id": 0, // required
                    "display_name": "string",
                    "profile_picture": "https://example.com/file.mp3", // required
                    "cover_photo": "https://example.com/file.mp3", // required
                    "best_describe_you": "string", // required
                    "location": "string",
                    "genres": [
                      "..."
                      ], // required
                    "skills": [
                      "..."
                      ], // required
                    "is_verified": true,
                    "connection_count": 0, // required
                    "match_score": 0, // required
                    "is_connected": true // required
                  }, // required
          "receiver": {
                    "id": 0, // required
                    "display_name": "string",
                    "profile_picture": "https://example.com/file.mp3", // required
                    "cover_photo": "https://example.com/file.mp3", // required
                    "best_describe_you": "string", // required
                    "location": "string",
                    "genres": [
                      "..."
                      ], // required
                    "skills": [
                      "..."
                      ], // required
                    "is_verified": true,
                    "connection_count": 0, // required
                    "match_score": 0, // required
                    "is_connected": true // required
                  }, // required
          "status": {}, // required
          "created_at": "2024-01-01T12:00:00Z", // required
          "updated_at": "2024-01-01T12:00:00Z" // required
        }
    ] // required
}
```

---

### `POST` /api/v1/users/connections/send/
**Send a connection request**

**Request Body** (application/json)

```json
{
  "receiver_id": 0 // required
}
```

**Response `201`**

```json
{
  "id": 0, // required
  "sender": {
        "id": 0, // required
        "display_name": "string",
        "profile_picture": "https://example.com/file.mp3", // required
        "cover_photo": "https://example.com/file.mp3", // required
        "best_describe_you": "string", // required
        "location": "string",
        "genres": [
          {
                  "id": 0, // required
                  "name": "pop"  // options: pop | hip_hop | rnb | rock | electronic | jazz | country | alternative | soul | indie // required
                }
          ], // required
        "skills": [
          {
                  "id": 0, // required
                  "name": "mixing"  // options: mixing | mastering | songwriting | composition | vocals | guitar | piano | drums | production | engineering // required
                }
          ], // required
        "is_verified": true,
        "connection_count": 0, // required
        "match_score": 0, // required
        "is_connected": true // required
      }, // required
  "receiver": {
        "id": 0, // required
        "display_name": "string",
        "profile_picture": "https://example.com/file.mp3", // required
        "cover_photo": "https://example.com/file.mp3", // required
        "best_describe_you": "string", // required
        "location": "string",
        "genres": [
          {
                  "id": 0, // required
                  "name": "pop"  // options: pop | hip_hop | rnb | rock | electronic | jazz | country | alternative | soul | indie // required
                }
          ], // required
        "skills": [
          {
                  "id": 0, // required
                  "name": "mixing"  // options: mixing | mastering | songwriting | composition | vocals | guitar | piano | drums | production | engineering // required
                }
          ], // required
        "is_verified": true,
        "connection_count": 0, // required
        "match_score": 0, // required
        "is_connected": true // required
      }, // required
  "status": {}, // required
  "created_at": "2024-01-01T12:00:00Z", // required
  "updated_at": "2024-01-01T12:00:00Z" // required
}
```

---

### `GET` /api/v1/users/connections/sent/
**List sent connection requests**

**Query Parameters**

| Parameter | Type | Required | Description |
|---|---|---|---|
| `page` | integer | — | A page number within the paginated result set. |
| `search` | string | — | Search receiver by display name |
| `status` | string | — | Filter by status |

**Response `200`**

```json
{
  "count": 0, // required
  "next": "https://example.com/file.mp3",
  "previous": "https://example.com/file.mp3",
  "results": [
    {
          "id": 0, // required
          "sender": {
                    "id": 0, // required
                    "display_name": "string",
                    "profile_picture": "https://example.com/file.mp3", // required
                    "cover_photo": "https://example.com/file.mp3", // required
                    "best_describe_you": "string", // required
                    "location": "string",
                    "genres": [
                      "..."
                      ], // required
                    "skills": [
                      "..."
                      ], // required
                    "is_verified": true,
                    "connection_count": 0, // required
                    "match_score": 0, // required
                    "is_connected": true // required
                  }, // required
          "receiver": {
                    "id": 0, // required
                    "display_name": "string",
                    "profile_picture": "https://example.com/file.mp3", // required
                    "cover_photo": "https://example.com/file.mp3", // required
                    "best_describe_you": "string", // required
                    "location": "string",
                    "genres": [
                      "..."
                      ], // required
                    "skills": [
                      "..."
                      ], // required
                    "is_verified": true,
                    "connection_count": 0, // required
                    "match_score": 0, // required
                    "is_connected": true // required
                  }, // required
          "status": {}, // required
          "created_at": "2024-01-01T12:00:00Z", // required
          "updated_at": "2024-01-01T12:00:00Z" // required
        }
    ] // required
}
```

---

### `POST` /api/v1/users/connections/{id}/accept/
**Accept a connection request**

**Path Parameters**

| Parameter | Type | Description |
|---|---|---|
| `id` | integer |  |

**Request Body** (application/json)

```json
{
  "id": 0, // required
  "sender": {
        "id": 0, // required
        "display_name": "string",
        "profile_picture": "https://example.com/file.mp3", // required
        "cover_photo": "https://example.com/file.mp3", // required
        "best_describe_you": "string", // required
        "location": "string",
        "genres": [
          {
                  "id": 0, // required
                  "name": "pop"  // options: pop | hip_hop | rnb | rock | electronic | jazz | country | alternative | soul | indie // required
                }
          ], // required
        "skills": [
          {
                  "id": 0, // required
                  "name": "mixing"  // options: mixing | mastering | songwriting | composition | vocals | guitar | piano | drums | production | engineering // required
                }
          ], // required
        "is_verified": true,
        "connection_count": 0, // required
        "match_score": 0, // required
        "is_connected": true // required
      }, // required
  "receiver": {
        "id": 0, // required
        "display_name": "string",
        "profile_picture": "https://example.com/file.mp3", // required
        "cover_photo": "https://example.com/file.mp3", // required
        "best_describe_you": "string", // required
        "location": "string",
        "genres": [
          {
                  "id": 0, // required
                  "name": "pop"  // options: pop | hip_hop | rnb | rock | electronic | jazz | country | alternative | soul | indie // required
                }
          ], // required
        "skills": [
          {
                  "id": 0, // required
                  "name": "mixing"  // options: mixing | mastering | songwriting | composition | vocals | guitar | piano | drums | production | engineering // required
                }
          ], // required
        "is_verified": true,
        "connection_count": 0, // required
        "match_score": 0, // required
        "is_connected": true // required
      }, // required
  "status": {}, // required
  "created_at": "2024-01-01T12:00:00Z", // required
  "updated_at": "2024-01-01T12:00:00Z" // required
}
```

**Response `200`**

```json
{
  "id": 0, // required
  "sender": {
        "id": 0, // required
        "display_name": "string",
        "profile_picture": "https://example.com/file.mp3", // required
        "cover_photo": "https://example.com/file.mp3", // required
        "best_describe_you": "string", // required
        "location": "string",
        "genres": [
          {
                  "id": 0, // required
                  "name": "pop"  // options: pop | hip_hop | rnb | rock | electronic | jazz | country | alternative | soul | indie // required
                }
          ], // required
        "skills": [
          {
                  "id": 0, // required
                  "name": "mixing"  // options: mixing | mastering | songwriting | composition | vocals | guitar | piano | drums | production | engineering // required
                }
          ], // required
        "is_verified": true,
        "connection_count": 0, // required
        "match_score": 0, // required
        "is_connected": true // required
      }, // required
  "receiver": {
        "id": 0, // required
        "display_name": "string",
        "profile_picture": "https://example.com/file.mp3", // required
        "cover_photo": "https://example.com/file.mp3", // required
        "best_describe_you": "string", // required
        "location": "string",
        "genres": [
          {
                  "id": 0, // required
                  "name": "pop"  // options: pop | hip_hop | rnb | rock | electronic | jazz | country | alternative | soul | indie // required
                }
          ], // required
        "skills": [
          {
                  "id": 0, // required
                  "name": "mixing"  // options: mixing | mastering | songwriting | composition | vocals | guitar | piano | drums | production | engineering // required
                }
          ], // required
        "is_verified": true,
        "connection_count": 0, // required
        "match_score": 0, // required
        "is_connected": true // required
      }, // required
  "status": {}, // required
  "created_at": "2024-01-01T12:00:00Z", // required
  "updated_at": "2024-01-01T12:00:00Z" // required
}
```

---

### `POST` /api/v1/users/connections/{id}/reject/
**Reject a connection request**

**Path Parameters**

| Parameter | Type | Description |
|---|---|---|
| `id` | integer |  |

**Request Body** (application/json)

```json
{
  "id": 0, // required
  "sender": {
        "id": 0, // required
        "display_name": "string",
        "profile_picture": "https://example.com/file.mp3", // required
        "cover_photo": "https://example.com/file.mp3", // required
        "best_describe_you": "string", // required
        "location": "string",
        "genres": [
          {
                  "id": 0, // required
                  "name": "pop"  // options: pop | hip_hop | rnb | rock | electronic | jazz | country | alternative | soul | indie // required
                }
          ], // required
        "skills": [
          {
                  "id": 0, // required
                  "name": "mixing"  // options: mixing | mastering | songwriting | composition | vocals | guitar | piano | drums | production | engineering // required
                }
          ], // required
        "is_verified": true,
        "connection_count": 0, // required
        "match_score": 0, // required
        "is_connected": true // required
      }, // required
  "receiver": {
        "id": 0, // required
        "display_name": "string",
        "profile_picture": "https://example.com/file.mp3", // required
        "cover_photo": "https://example.com/file.mp3", // required
        "best_describe_you": "string", // required
        "location": "string",
        "genres": [
          {
                  "id": 0, // required
                  "name": "pop"  // options: pop | hip_hop | rnb | rock | electronic | jazz | country | alternative | soul | indie // required
                }
          ], // required
        "skills": [
          {
                  "id": 0, // required
                  "name": "mixing"  // options: mixing | mastering | songwriting | composition | vocals | guitar | piano | drums | production | engineering // required
                }
          ], // required
        "is_verified": true,
        "connection_count": 0, // required
        "match_score": 0, // required
        "is_connected": true // required
      }, // required
  "status": {}, // required
  "created_at": "2024-01-01T12:00:00Z", // required
  "updated_at": "2024-01-01T12:00:00Z" // required
}
```

**Response `200`**

```json
{
  "id": 0, // required
  "sender": {
        "id": 0, // required
        "display_name": "string",
        "profile_picture": "https://example.com/file.mp3", // required
        "cover_photo": "https://example.com/file.mp3", // required
        "best_describe_you": "string", // required
        "location": "string",
        "genres": [
          {
                  "id": 0, // required
                  "name": "pop"  // options: pop | hip_hop | rnb | rock | electronic | jazz | country | alternative | soul | indie // required
                }
          ], // required
        "skills": [
          {
                  "id": 0, // required
                  "name": "mixing"  // options: mixing | mastering | songwriting | composition | vocals | guitar | piano | drums | production | engineering // required
                }
          ], // required
        "is_verified": true,
        "connection_count": 0, // required
        "match_score": 0, // required
        "is_connected": true // required
      }, // required
  "receiver": {
        "id": 0, // required
        "display_name": "string",
        "profile_picture": "https://example.com/file.mp3", // required
        "cover_photo": "https://example.com/file.mp3", // required
        "best_describe_you": "string", // required
        "location": "string",
        "genres": [
          {
                  "id": 0, // required
                  "name": "pop"  // options: pop | hip_hop | rnb | rock | electronic | jazz | country | alternative | soul | indie // required
                }
          ], // required
        "skills": [
          {
                  "id": 0, // required
                  "name": "mixing"  // options: mixing | mastering | songwriting | composition | vocals | guitar | piano | drums | production | engineering // required
                }
          ], // required
        "is_verified": true,
        "connection_count": 0, // required
        "match_score": 0, // required
        "is_connected": true // required
      }, // required
  "status": {}, // required
  "created_at": "2024-01-01T12:00:00Z", // required
  "updated_at": "2024-01-01T12:00:00Z" // required
}
```

---

## Settings

### `GET` /api/v1/users/settings/account/
**Get account details (email)**

**Response `200`**

```json
{
  "id": 0, // required
  "email": "user@example.com", // required
  "first_name": "string", // required
  "last_name": "string", // required
  "display_name": "string", // required
  "created_at": "2024-01-01T12:00:00Z" // required
}
```

---

### `POST` /api/v1/users/settings/account/change-password/
**Update password**

**Request Body** (application/json)

```json
{
  "current_password": "string", // required
  "new_password": "string", // required
  "confirm_new_password": "string" // required
}
```

**Response:** `200` No content

---

### `DELETE` /api/v1/users/settings/account/delete/
**Delete account (danger zone)**

**Response:** `204` No content

---

### `GET` /api/v1/users/settings/notifications/
**Get notification preferences**

**Response `200`**

```json
{
  "collaboration_requests": true,
  "brief_updates": true,
  "new_briefs": true,
  "marketing_emails": true,
  "push_enabled": true,
  "messages": true
}
```

---

### `PATCH` /api/v1/users/settings/notifications/update/
**Update notification preferences**

**Request Body** (application/json)

```json
{
  "collaboration_requests": true,
  "brief_updates": true,
  "new_briefs": true,
  "marketing_emails": true,
  "push_enabled": true,
  "messages": true
}
```

**Response `200`**

```json
{
  "collaboration_requests": true,
  "brief_updates": true,
  "new_briefs": true,
  "marketing_emails": true,
  "push_enabled": true,
  "messages": true
}
```

---

### `GET` /api/v1/users/settings/payments/methods/
**List saved payment methods (Stripe cards)**

**Query Parameters**

| Parameter | Type | Required | Description |
|---|---|---|---|
| `page` | integer | — | A page number within the paginated result set. |

**Response `200`**

```json
{
  "count": 0, // required
  "next": "https://example.com/file.mp3",
  "previous": "https://example.com/file.mp3",
  "results": [
    {
          "id": 0, // required
          "card_type": "visa"  // options: visa | mastercard | amex | discover | other,
          "card_type_display": "string", // required
          "last_four": "string", // required
          "cardholder_name": "string", // required
          "expiry": "string", // required
          "is_default": true,
          "created_at": "2024-01-01T12:00:00Z" // required
        }
    ] // required
}
```

---

### `GET` /api/v1/users/settings/payments/payouts/
**Get payout summary and payout history**

**Response `200`**

```json
{
  "total_earned": "string", // required
  "pending_payout": "string", // required
  "total_paid_out": "string", // required
  "payout_requests": [
    {}
    ] // required
}
```

---

### `GET` /api/v1/users/settings/profile/
**Get profile settings**

**Response `200`**

```json
{
  "first_name": "string",
  "last_name": "string",
  "display_name": "string",
  "bio": "string",
  "location": "string",
  "website": "https://example.com/file.mp3",
  "best_describe_you": "string",
  "profile_picture": "https://example.com/file.mp3",
  "cover_photo": "https://example.com/file.mp3",
  "genres": [
    {
          "id": 0, // required
          "name": "pop"  // options: pop | hip_hop | rnb | rock | electronic | jazz | country | alternative | soul | indie // required
        }
    ], // required
  "genre_ids": [
    0
    ],
  "skills": [
    {
          "id": 0, // required
          "name": "mixing"  // options: mixing | mastering | songwriting | composition | vocals | guitar | piano | drums | production | engineering // required
        }
    ], // required
  "skill_ids": [
    0
    ],
  "equipment": "string",
  "looking_for_description": "string",
  "social_links": {}
}
```

---

### `DELETE` /api/v1/users/settings/profile/cover-photo/
**Remove cover photo**

**Response:** `204` No content

---

### `DELETE` /api/v1/users/settings/profile/profile-picture/
**Remove profile picture**

**Response:** `204` No content

---

### `PATCH` /api/v1/users/settings/profile/update/
**Update profile settings (cover photo, profile picture, basic info, roles & genres)**

**Request Body** (application/json)

```json
{
  "first_name": "string",
  "last_name": "string",
  "display_name": "string",
  "bio": "string",
  "location": "string",
  "website": "https://example.com/file.mp3",
  "best_describe_you": "string",
  "profile_picture": "https://example.com/file.mp3",
  "cover_photo": "https://example.com/file.mp3",
  "genres": [
    {
          "id": 0, // required
          "name": "pop"  // options: pop | hip_hop | rnb | rock | electronic | jazz | country | alternative | soul | indie // required
        }
    ],
  "genre_ids": [
    0
    ],
  "skills": [
    {
          "id": 0, // required
          "name": "mixing"  // options: mixing | mastering | songwriting | composition | vocals | guitar | piano | drums | production | engineering // required
        }
    ],
  "skill_ids": [
    0
    ],
  "equipment": "string",
  "looking_for_description": "string",
  "social_links": {}
}
```

**Response `200`**

```json
{
  "first_name": "string",
  "last_name": "string",
  "display_name": "string",
  "bio": "string",
  "location": "string",
  "website": "https://example.com/file.mp3",
  "best_describe_you": "string",
  "profile_picture": "https://example.com/file.mp3",
  "cover_photo": "https://example.com/file.mp3",
  "genres": [
    {
          "id": 0, // required
          "name": "pop"  // options: pop | hip_hop | rnb | rock | electronic | jazz | country | alternative | soul | indie // required
        }
    ], // required
  "genre_ids": [
    0
    ],
  "skills": [
    {
          "id": 0, // required
          "name": "mixing"  // options: mixing | mastering | songwriting | composition | vocals | guitar | piano | drums | production | engineering // required
        }
    ], // required
  "skill_ids": [
    0
    ],
  "equipment": "string",
  "looking_for_description": "string",
  "social_links": {}
}
```

---

### `GET` /api/v1/users/settings/security/
**Get security & privacy settings**

**Response:** `200` No content

---

### `POST` /api/v1/users/settings/security/2fa/toggle/
**Toggle Two-Factor Authentication**

**Response:** `200` No content

---

### `PATCH` /api/v1/users/settings/security/privacy/
**Update privacy settings**

**Request Body** (application/json)

```json
{
  "profile_visibility": true,
  "show_activity_status": true,
  "allow_connection_requests": true,
  "two_factor_enabled": true
}
```

**Response `200`**

```json
{
  "profile_visibility": true,
  "show_activity_status": true,
  "allow_connection_requests": true,
  "two_factor_enabled": true
}
```

---

### `POST` /api/v1/users/settings/security/sessions/logout-all/
**Log out all other sessions (invalidates all tokens)**

**Response:** `200` No content

---

### `GET` /api/v1/users/settings/storage/
**Get storage usage breakdown**

**Response `200`**

```json
{
  "audio_files_bytes": 0, // required
  "images_bytes": 0, // required
  "videos_bytes": 0, // required
  "documents_bytes": 0, // required
  "total_bytes": 0, // required
  "audio_files_gb": 0.0, // required
  "images_gb": 0.0, // required
  "videos_gb": 0.0, // required
  "documents_gb": 0.0, // required
  "total_gb": 0.0, // required
  "quota_gb": 0.0 // required
}
```

---

### `GET` /api/v1/users/settings/subscription/
**Get subscription settings (current plan + available plans)**

**Response:** `200` No content

---

## Feed

### `GET` /api/v1/feed/
**Get feed**

**Query Parameters**

| Parameter | Type | Required | Description |
|---|---|---|---|
| `page` | integer | — | A page number within the paginated result set. |
| `page_size` | integer | — | Number of results to return per page. |
| `search` | string | — | Search posts by title or description |
| `tab` | string | — | Filter feed by post type or show saved posts (default: all) |

**Response `200`**

```json
{
  "count": 0, // required
  "next": "https://example.com/file.mp3",
  "previous": "https://example.com/file.mp3",
  "results": [
    {
          "id": 0, // required
          "user": {
                    "id": 0, // required
                    "display_name": "string",
                    "profile_picture": "https://example.com/file.mp3", // required
                    "cover_photo": "https://example.com/file.mp3", // required
                    "best_describe_you": "string", // required
                    "location": "string",
                    "genres": [
                      "..."
                      ], // required
                    "skills": [
                      "..."
                      ], // required
                    "is_verified": true,
                    "connection_count": 0, // required
                    "match_score": 0, // required
                    "is_connected": true // required
                  }, // required
          "post_type": "lyrics"  // options: lyrics | audio | video | photo, // required
          "title": "string",
          "description": "string",
          "lyrics": "string",
          "audio_file": "https://example.com/file.mp3",
          "video_file": "https://example.com/file.mp3",
          "photo": "https://example.com/file.mp3",
          "genres": [
            {
                      "id": "...", // required
                      "name": "..." // required
                    }
            ], // required
          "genre_ids": [
            0
            ],
          "shared_from": {
                    "id": 0, // required
                    "user": {
                                "id": "...", // required
                                "display_name": "...",
                                "profile_picture": "...", // required
                                "cover_photo": "...", // required
                                "best_describe_you": "...", // required
                                "location": "...",
                                "genres": "...", // required
                                "skills": "...", // required
                                "is_verified": "...",
                                "connection_count": "...", // required
                                "match_score": "...", // required
                                "is_connected": "..." // required
                              }, // required
                    "post_type": "lyrics"  // options: lyrics | audio | video | photo, // required
                    "title": "string",
                    "description": "string",
                    "lyrics": "string",
                    "audio_file": "https://example.com/file.mp3",
                    "video_file": "https://example.com/file.mp3",
                    "photo": "https://example.com/file.mp3",
                    "genres": [
                      "..."
                      ], // required
                    "allow_downloads": true,
                    "allow_comments": true,
                    "created_at": "2024-01-01T12:00:00Z" // required
                  }, // required
          "allow_downloads": true,
          "allow_comments": true,
          "likes_count": "string", // required
          "comments_count": "string", // required
          "shares_count": "string", // required
          "saves_count": "string", // required
          "is_liked": "string", // required
          "is_saved": "string", // required
          "is_shared": "string", // required
          "created_at": "2024-01-01T12:00:00Z", // required
          "updated_at": "2024-01-01T12:00:00Z" // required
        }
    ] // required
}
```

---

### `POST` /api/v1/feed/
**Create a post**

**Request Body** (application/json)

```json
{
  "id": 0, // required
  "user": {
        "id": 0, // required
        "display_name": "string",
        "profile_picture": "https://example.com/file.mp3", // required
        "cover_photo": "https://example.com/file.mp3", // required
        "best_describe_you": "string", // required
        "location": "string",
        "genres": [
          {
                  "id": 0, // required
                  "name": "pop"  // options: pop | hip_hop | rnb | rock | electronic | jazz | country | alternative | soul | indie // required
                }
          ], // required
        "skills": [
          {
                  "id": 0, // required
                  "name": "mixing"  // options: mixing | mastering | songwriting | composition | vocals | guitar | piano | drums | production | engineering // required
                }
          ], // required
        "is_verified": true,
        "connection_count": 0, // required
        "match_score": 0, // required
        "is_connected": true // required
      }, // required
  "post_type": "lyrics"  // options: lyrics | audio | video | photo, // required
  "title": "string",
  "description": "string",
  "lyrics": "string",
  "audio_file": "https://example.com/file.mp3",
  "video_file": "https://example.com/file.mp3",
  "photo": "https://example.com/file.mp3",
  "genres": [
    {
          "id": 0, // required
          "name": "pop"  // options: pop | hip_hop | rnb | rock | electronic | jazz | country | alternative | soul | indie // required
        }
    ], // required
  "genre_ids": [
    0
    ],
  "shared_from": {
        "id": 0, // required
        "user": {
                "id": 0, // required
                "display_name": "string",
                "profile_picture": "https://example.com/file.mp3", // required
                "cover_photo": "https://example.com/file.mp3", // required
                "best_describe_you": "string", // required
                "location": "string",
                "genres": [
                  {
                            "id": "...", // required
                            "name": "..." // required
                          }
                  ], // required
                "skills": [
                  {
                            "id": "...", // required
                            "name": "..." // required
                          }
                  ], // required
                "is_verified": true,
                "connection_count": 0, // required
                "match_score": 0, // required
                "is_connected": true // required
              }, // required
        "post_type": "lyrics"  // options: lyrics | audio | video | photo, // required
        "title": "string",
        "description": "string",
        "lyrics": "string",
        "audio_file": "https://example.com/file.mp3",
        "video_file": "https://example.com/file.mp3",
        "photo": "https://example.com/file.mp3",
        "genres": [
          {
                  "id": 0, // required
                  "name": "pop"  // options: pop | hip_hop | rnb | rock | electronic | jazz | country | alternative | soul | indie // required
                }
          ], // required
        "allow_downloads": true,
        "allow_comments": true,
        "created_at": "2024-01-01T12:00:00Z" // required
      }, // required
  "allow_downloads": true,
  "allow_comments": true,
  "likes_count": "string", // required
  "comments_count": "string", // required
  "shares_count": "string", // required
  "saves_count": "string", // required
  "is_liked": "string", // required
  "is_saved": "string", // required
  "is_shared": "string", // required
  "created_at": "2024-01-01T12:00:00Z", // required
  "updated_at": "2024-01-01T12:00:00Z" // required
}
```

**Response `201`**

```json
{
  "id": 0, // required
  "user": {
        "id": 0, // required
        "display_name": "string",
        "profile_picture": "https://example.com/file.mp3", // required
        "cover_photo": "https://example.com/file.mp3", // required
        "best_describe_you": "string", // required
        "location": "string",
        "genres": [
          {
                  "id": 0, // required
                  "name": "pop"  // options: pop | hip_hop | rnb | rock | electronic | jazz | country | alternative | soul | indie // required
                }
          ], // required
        "skills": [
          {
                  "id": 0, // required
                  "name": "mixing"  // options: mixing | mastering | songwriting | composition | vocals | guitar | piano | drums | production | engineering // required
                }
          ], // required
        "is_verified": true,
        "connection_count": 0, // required
        "match_score": 0, // required
        "is_connected": true // required
      }, // required
  "post_type": "lyrics"  // options: lyrics | audio | video | photo, // required
  "title": "string",
  "description": "string",
  "lyrics": "string",
  "audio_file": "https://example.com/file.mp3",
  "video_file": "https://example.com/file.mp3",
  "photo": "https://example.com/file.mp3",
  "genres": [
    {
          "id": 0, // required
          "name": "pop"  // options: pop | hip_hop | rnb | rock | electronic | jazz | country | alternative | soul | indie // required
        }
    ], // required
  "genre_ids": [
    0
    ],
  "shared_from": {
        "id": 0, // required
        "user": {
                "id": 0, // required
                "display_name": "string",
                "profile_picture": "https://example.com/file.mp3", // required
                "cover_photo": "https://example.com/file.mp3", // required
                "best_describe_you": "string", // required
                "location": "string",
                "genres": [
                  {
                            "id": "...", // required
                            "name": "..." // required
                          }
                  ], // required
                "skills": [
                  {
                            "id": "...", // required
                            "name": "..." // required
                          }
                  ], // required
                "is_verified": true,
                "connection_count": 0, // required
                "match_score": 0, // required
                "is_connected": true // required
              }, // required
        "post_type": "lyrics"  // options: lyrics | audio | video | photo, // required
        "title": "string",
        "description": "string",
        "lyrics": "string",
        "audio_file": "https://example.com/file.mp3",
        "video_file": "https://example.com/file.mp3",
        "photo": "https://example.com/file.mp3",
        "genres": [
          {
                  "id": 0, // required
                  "name": "pop"  // options: pop | hip_hop | rnb | rock | electronic | jazz | country | alternative | soul | indie // required
                }
          ], // required
        "allow_downloads": true,
        "allow_comments": true,
        "created_at": "2024-01-01T12:00:00Z" // required
      }, // required
  "allow_downloads": true,
  "allow_comments": true,
  "likes_count": "string", // required
  "comments_count": "string", // required
  "shares_count": "string", // required
  "saves_count": "string", // required
  "is_liked": "string", // required
  "is_saved": "string", // required
  "is_shared": "string", // required
  "created_at": "2024-01-01T12:00:00Z", // required
  "updated_at": "2024-01-01T12:00:00Z" // required
}
```

---

### `GET` /api/v1/feed/{id}/
**Retrieve a post**

**Path Parameters**

| Parameter | Type | Description |
|---|---|---|
| `id` | integer |  |

**Response `200`**

```json
{
  "id": 0, // required
  "user": {
        "id": 0, // required
        "display_name": "string",
        "profile_picture": "https://example.com/file.mp3", // required
        "cover_photo": "https://example.com/file.mp3", // required
        "best_describe_you": "string", // required
        "location": "string",
        "genres": [
          {
                  "id": 0, // required
                  "name": "pop"  // options: pop | hip_hop | rnb | rock | electronic | jazz | country | alternative | soul | indie // required
                }
          ], // required
        "skills": [
          {
                  "id": 0, // required
                  "name": "mixing"  // options: mixing | mastering | songwriting | composition | vocals | guitar | piano | drums | production | engineering // required
                }
          ], // required
        "is_verified": true,
        "connection_count": 0, // required
        "match_score": 0, // required
        "is_connected": true // required
      }, // required
  "post_type": "lyrics"  // options: lyrics | audio | video | photo, // required
  "title": "string",
  "description": "string",
  "lyrics": "string",
  "audio_file": "https://example.com/file.mp3",
  "video_file": "https://example.com/file.mp3",
  "photo": "https://example.com/file.mp3",
  "genres": [
    {
          "id": 0, // required
          "name": "pop"  // options: pop | hip_hop | rnb | rock | electronic | jazz | country | alternative | soul | indie // required
        }
    ], // required
  "genre_ids": [
    0
    ],
  "shared_from": {
        "id": 0, // required
        "user": {
                "id": 0, // required
                "display_name": "string",
                "profile_picture": "https://example.com/file.mp3", // required
                "cover_photo": "https://example.com/file.mp3", // required
                "best_describe_you": "string", // required
                "location": "string",
                "genres": [
                  {
                            "id": "...", // required
                            "name": "..." // required
                          }
                  ], // required
                "skills": [
                  {
                            "id": "...", // required
                            "name": "..." // required
                          }
                  ], // required
                "is_verified": true,
                "connection_count": 0, // required
                "match_score": 0, // required
                "is_connected": true // required
              }, // required
        "post_type": "lyrics"  // options: lyrics | audio | video | photo, // required
        "title": "string",
        "description": "string",
        "lyrics": "string",
        "audio_file": "https://example.com/file.mp3",
        "video_file": "https://example.com/file.mp3",
        "photo": "https://example.com/file.mp3",
        "genres": [
          {
                  "id": 0, // required
                  "name": "pop"  // options: pop | hip_hop | rnb | rock | electronic | jazz | country | alternative | soul | indie // required
                }
          ], // required
        "allow_downloads": true,
        "allow_comments": true,
        "created_at": "2024-01-01T12:00:00Z" // required
      }, // required
  "allow_downloads": true,
  "allow_comments": true,
  "likes_count": "string", // required
  "comments_count": "string", // required
  "shares_count": "string", // required
  "saves_count": "string", // required
  "is_liked": "string", // required
  "is_saved": "string", // required
  "is_shared": "string", // required
  "created_at": "2024-01-01T12:00:00Z", // required
  "updated_at": "2024-01-01T12:00:00Z" // required
}
```

---

### `PUT` /api/v1/feed/{id}/
**Update a post**

**Path Parameters**

| Parameter | Type | Description |
|---|---|---|
| `id` | integer |  |

**Request Body** (application/json)

```json
{
  "id": 0, // required
  "user": {
        "id": 0, // required
        "display_name": "string",
        "profile_picture": "https://example.com/file.mp3", // required
        "cover_photo": "https://example.com/file.mp3", // required
        "best_describe_you": "string", // required
        "location": "string",
        "genres": [
          {
                  "id": 0, // required
                  "name": "pop"  // options: pop | hip_hop | rnb | rock | electronic | jazz | country | alternative | soul | indie // required
                }
          ], // required
        "skills": [
          {
                  "id": 0, // required
                  "name": "mixing"  // options: mixing | mastering | songwriting | composition | vocals | guitar | piano | drums | production | engineering // required
                }
          ], // required
        "is_verified": true,
        "connection_count": 0, // required
        "match_score": 0, // required
        "is_connected": true // required
      }, // required
  "post_type": "lyrics"  // options: lyrics | audio | video | photo, // required
  "title": "string",
  "description": "string",
  "lyrics": "string",
  "audio_file": "https://example.com/file.mp3",
  "video_file": "https://example.com/file.mp3",
  "photo": "https://example.com/file.mp3",
  "genres": [
    {
          "id": 0, // required
          "name": "pop"  // options: pop | hip_hop | rnb | rock | electronic | jazz | country | alternative | soul | indie // required
        }
    ], // required
  "genre_ids": [
    0
    ],
  "shared_from": {
        "id": 0, // required
        "user": {
                "id": 0, // required
                "display_name": "string",
                "profile_picture": "https://example.com/file.mp3", // required
                "cover_photo": "https://example.com/file.mp3", // required
                "best_describe_you": "string", // required
                "location": "string",
                "genres": [
                  {
                            "id": "...", // required
                            "name": "..." // required
                          }
                  ], // required
                "skills": [
                  {
                            "id": "...", // required
                            "name": "..." // required
                          }
                  ], // required
                "is_verified": true,
                "connection_count": 0, // required
                "match_score": 0, // required
                "is_connected": true // required
              }, // required
        "post_type": "lyrics"  // options: lyrics | audio | video | photo, // required
        "title": "string",
        "description": "string",
        "lyrics": "string",
        "audio_file": "https://example.com/file.mp3",
        "video_file": "https://example.com/file.mp3",
        "photo": "https://example.com/file.mp3",
        "genres": [
          {
                  "id": 0, // required
                  "name": "pop"  // options: pop | hip_hop | rnb | rock | electronic | jazz | country | alternative | soul | indie // required
                }
          ], // required
        "allow_downloads": true,
        "allow_comments": true,
        "created_at": "2024-01-01T12:00:00Z" // required
      }, // required
  "allow_downloads": true,
  "allow_comments": true,
  "likes_count": "string", // required
  "comments_count": "string", // required
  "shares_count": "string", // required
  "saves_count": "string", // required
  "is_liked": "string", // required
  "is_saved": "string", // required
  "is_shared": "string", // required
  "created_at": "2024-01-01T12:00:00Z", // required
  "updated_at": "2024-01-01T12:00:00Z" // required
}
```

**Response `200`**

```json
{
  "id": 0, // required
  "user": {
        "id": 0, // required
        "display_name": "string",
        "profile_picture": "https://example.com/file.mp3", // required
        "cover_photo": "https://example.com/file.mp3", // required
        "best_describe_you": "string", // required
        "location": "string",
        "genres": [
          {
                  "id": 0, // required
                  "name": "pop"  // options: pop | hip_hop | rnb | rock | electronic | jazz | country | alternative | soul | indie // required
                }
          ], // required
        "skills": [
          {
                  "id": 0, // required
                  "name": "mixing"  // options: mixing | mastering | songwriting | composition | vocals | guitar | piano | drums | production | engineering // required
                }
          ], // required
        "is_verified": true,
        "connection_count": 0, // required
        "match_score": 0, // required
        "is_connected": true // required
      }, // required
  "post_type": "lyrics"  // options: lyrics | audio | video | photo, // required
  "title": "string",
  "description": "string",
  "lyrics": "string",
  "audio_file": "https://example.com/file.mp3",
  "video_file": "https://example.com/file.mp3",
  "photo": "https://example.com/file.mp3",
  "genres": [
    {
          "id": 0, // required
          "name": "pop"  // options: pop | hip_hop | rnb | rock | electronic | jazz | country | alternative | soul | indie // required
        }
    ], // required
  "genre_ids": [
    0
    ],
  "shared_from": {
        "id": 0, // required
        "user": {
                "id": 0, // required
                "display_name": "string",
                "profile_picture": "https://example.com/file.mp3", // required
                "cover_photo": "https://example.com/file.mp3", // required
                "best_describe_you": "string", // required
                "location": "string",
                "genres": [
                  {
                            "id": "...", // required
                            "name": "..." // required
                          }
                  ], // required
                "skills": [
                  {
                            "id": "...", // required
                            "name": "..." // required
                          }
                  ], // required
                "is_verified": true,
                "connection_count": 0, // required
                "match_score": 0, // required
                "is_connected": true // required
              }, // required
        "post_type": "lyrics"  // options: lyrics | audio | video | photo, // required
        "title": "string",
        "description": "string",
        "lyrics": "string",
        "audio_file": "https://example.com/file.mp3",
        "video_file": "https://example.com/file.mp3",
        "photo": "https://example.com/file.mp3",
        "genres": [
          {
                  "id": 0, // required
                  "name": "pop"  // options: pop | hip_hop | rnb | rock | electronic | jazz | country | alternative | soul | indie // required
                }
          ], // required
        "allow_downloads": true,
        "allow_comments": true,
        "created_at": "2024-01-01T12:00:00Z" // required
      }, // required
  "allow_downloads": true,
  "allow_comments": true,
  "likes_count": "string", // required
  "comments_count": "string", // required
  "shares_count": "string", // required
  "saves_count": "string", // required
  "is_liked": "string", // required
  "is_saved": "string", // required
  "is_shared": "string", // required
  "created_at": "2024-01-01T12:00:00Z", // required
  "updated_at": "2024-01-01T12:00:00Z" // required
}
```

---

### `PATCH` /api/v1/feed/{id}/
**Partially update a post**

**Path Parameters**

| Parameter | Type | Description |
|---|---|---|
| `id` | integer |  |

**Request Body** (application/json)

```json
{
  "id": 0,
  "user": {
        "id": 0, // required
        "display_name": "string",
        "profile_picture": "https://example.com/file.mp3", // required
        "cover_photo": "https://example.com/file.mp3", // required
        "best_describe_you": "string", // required
        "location": "string",
        "genres": [
          {
                  "id": 0, // required
                  "name": "pop"  // options: pop | hip_hop | rnb | rock | electronic | jazz | country | alternative | soul | indie // required
                }
          ], // required
        "skills": [
          {
                  "id": 0, // required
                  "name": "mixing"  // options: mixing | mastering | songwriting | composition | vocals | guitar | piano | drums | production | engineering // required
                }
          ], // required
        "is_verified": true,
        "connection_count": 0, // required
        "match_score": 0, // required
        "is_connected": true // required
      },
  "post_type": "lyrics"  // options: lyrics | audio | video | photo,
  "title": "string",
  "description": "string",
  "lyrics": "string",
  "audio_file": "https://example.com/file.mp3",
  "video_file": "https://example.com/file.mp3",
  "photo": "https://example.com/file.mp3",
  "genres": [
    {
          "id": 0, // required
          "name": "pop"  // options: pop | hip_hop | rnb | rock | electronic | jazz | country | alternative | soul | indie // required
        }
    ],
  "genre_ids": [
    0
    ],
  "shared_from": {
        "id": 0, // required
        "user": {
                "id": 0, // required
                "display_name": "string",
                "profile_picture": "https://example.com/file.mp3", // required
                "cover_photo": "https://example.com/file.mp3", // required
                "best_describe_you": "string", // required
                "location": "string",
                "genres": [
                  {
                            "id": "...", // required
                            "name": "..." // required
                          }
                  ], // required
                "skills": [
                  {
                            "id": "...", // required
                            "name": "..." // required
                          }
                  ], // required
                "is_verified": true,
                "connection_count": 0, // required
                "match_score": 0, // required
                "is_connected": true // required
              }, // required
        "post_type": "lyrics"  // options: lyrics | audio | video | photo, // required
        "title": "string",
        "description": "string",
        "lyrics": "string",
        "audio_file": "https://example.com/file.mp3",
        "video_file": "https://example.com/file.mp3",
        "photo": "https://example.com/file.mp3",
        "genres": [
          {
                  "id": 0, // required
                  "name": "pop"  // options: pop | hip_hop | rnb | rock | electronic | jazz | country | alternative | soul | indie // required
                }
          ], // required
        "allow_downloads": true,
        "allow_comments": true,
        "created_at": "2024-01-01T12:00:00Z" // required
      },
  "allow_downloads": true,
  "allow_comments": true,
  "likes_count": "string",
  "comments_count": "string",
  "shares_count": "string",
  "saves_count": "string",
  "is_liked": "string",
  "is_saved": "string",
  "is_shared": "string",
  "created_at": "2024-01-01T12:00:00Z",
  "updated_at": "2024-01-01T12:00:00Z"
}
```

**Response `200`**

```json
{
  "id": 0, // required
  "user": {
        "id": 0, // required
        "display_name": "string",
        "profile_picture": "https://example.com/file.mp3", // required
        "cover_photo": "https://example.com/file.mp3", // required
        "best_describe_you": "string", // required
        "location": "string",
        "genres": [
          {
                  "id": 0, // required
                  "name": "pop"  // options: pop | hip_hop | rnb | rock | electronic | jazz | country | alternative | soul | indie // required
                }
          ], // required
        "skills": [
          {
                  "id": 0, // required
                  "name": "mixing"  // options: mixing | mastering | songwriting | composition | vocals | guitar | piano | drums | production | engineering // required
                }
          ], // required
        "is_verified": true,
        "connection_count": 0, // required
        "match_score": 0, // required
        "is_connected": true // required
      }, // required
  "post_type": "lyrics"  // options: lyrics | audio | video | photo, // required
  "title": "string",
  "description": "string",
  "lyrics": "string",
  "audio_file": "https://example.com/file.mp3",
  "video_file": "https://example.com/file.mp3",
  "photo": "https://example.com/file.mp3",
  "genres": [
    {
          "id": 0, // required
          "name": "pop"  // options: pop | hip_hop | rnb | rock | electronic | jazz | country | alternative | soul | indie // required
        }
    ], // required
  "genre_ids": [
    0
    ],
  "shared_from": {
        "id": 0, // required
        "user": {
                "id": 0, // required
                "display_name": "string",
                "profile_picture": "https://example.com/file.mp3", // required
                "cover_photo": "https://example.com/file.mp3", // required
                "best_describe_you": "string", // required
                "location": "string",
                "genres": [
                  {
                            "id": "...", // required
                            "name": "..." // required
                          }
                  ], // required
                "skills": [
                  {
                            "id": "...", // required
                            "name": "..." // required
                          }
                  ], // required
                "is_verified": true,
                "connection_count": 0, // required
                "match_score": 0, // required
                "is_connected": true // required
              }, // required
        "post_type": "lyrics"  // options: lyrics | audio | video | photo, // required
        "title": "string",
        "description": "string",
        "lyrics": "string",
        "audio_file": "https://example.com/file.mp3",
        "video_file": "https://example.com/file.mp3",
        "photo": "https://example.com/file.mp3",
        "genres": [
          {
                  "id": 0, // required
                  "name": "pop"  // options: pop | hip_hop | rnb | rock | electronic | jazz | country | alternative | soul | indie // required
                }
          ], // required
        "allow_downloads": true,
        "allow_comments": true,
        "created_at": "2024-01-01T12:00:00Z" // required
      }, // required
  "allow_downloads": true,
  "allow_comments": true,
  "likes_count": "string", // required
  "comments_count": "string", // required
  "shares_count": "string", // required
  "saves_count": "string", // required
  "is_liked": "string", // required
  "is_saved": "string", // required
  "is_shared": "string", // required
  "created_at": "2024-01-01T12:00:00Z", // required
  "updated_at": "2024-01-01T12:00:00Z" // required
}
```

---

### `DELETE` /api/v1/feed/{id}/
**Delete a post**

**Path Parameters**

| Parameter | Type | Description |
|---|---|---|
| `id` | integer |  |

**Response:** `204` No content

---

### `GET` /api/v1/feed/{id}/comments/
**List comments on a post**

**Path Parameters**

| Parameter | Type | Description |
|---|---|---|
| `id` | integer |  |

**Query Parameters**

| Parameter | Type | Required | Description |
|---|---|---|---|
| `page` | integer | — | A page number within the paginated result set. |
| `page_size` | integer | — | Number of results to return per page. |
| `search` | string | — | Search comment body |

**Response `200`**

```json
{
  "count": 0, // required
  "next": "https://example.com/file.mp3",
  "previous": "https://example.com/file.mp3",
  "results": [
    {
          "id": 0, // required
          "user": {
                    "id": 0, // required
                    "display_name": "string",
                    "profile_picture": "https://example.com/file.mp3", // required
                    "cover_photo": "https://example.com/file.mp3", // required
                    "best_describe_you": "string", // required
                    "location": "string",
                    "genres": [
                      "..."
                      ], // required
                    "skills": [
                      "..."
                      ], // required
                    "is_verified": true,
                    "connection_count": 0, // required
                    "match_score": 0, // required
                    "is_connected": true // required
                  }, // required
          "parent": 0,
          "body": "string", // required
          "replies": "string", // required
          "created_at": "2024-01-01T12:00:00Z", // required
          "updated_at": "2024-01-01T12:00:00Z" // required
        }
    ] // required
}
```

---

### `POST` /api/v1/feed/{id}/comments/add/
**Add a comment or reply to a post**

**Path Parameters**

| Parameter | Type | Description |
|---|---|---|
| `id` | integer |  |

**Request Body** (application/json)

```json
{
  "id": 0, // required
  "post": 0, // required
  "parent": 0,
  "body": "string", // required
  "created_at": "2024-01-01T12:00:00Z" // required
}
```

**Response `201`**

```json
{
  "id": 0, // required
  "user": {
        "id": 0, // required
        "display_name": "string",
        "profile_picture": "https://example.com/file.mp3", // required
        "cover_photo": "https://example.com/file.mp3", // required
        "best_describe_you": "string", // required
        "location": "string",
        "genres": [
          {
                  "id": 0, // required
                  "name": "pop"  // options: pop | hip_hop | rnb | rock | electronic | jazz | country | alternative | soul | indie // required
                }
          ], // required
        "skills": [
          {
                  "id": 0, // required
                  "name": "mixing"  // options: mixing | mastering | songwriting | composition | vocals | guitar | piano | drums | production | engineering // required
                }
          ], // required
        "is_verified": true,
        "connection_count": 0, // required
        "match_score": 0, // required
        "is_connected": true // required
      }, // required
  "parent": 0,
  "body": "string", // required
  "replies": "string", // required
  "created_at": "2024-01-01T12:00:00Z", // required
  "updated_at": "2024-01-01T12:00:00Z" // required
}
```

---

### `DELETE` /api/v1/feed/{id}/comments/{comment_pk}/
**Delete own comment**

**Path Parameters**

| Parameter | Type | Description |
|---|---|---|
| `comment_pk` | integer |  |
| `id` | integer |  |

**Response:** `204` No content

---

### `POST` /api/v1/feed/{id}/like/
**Like or unlike a post (toggle)**

**Path Parameters**

| Parameter | Type | Description |
|---|---|---|
| `id` | integer |  |

**Request Body** (application/json)

```json
{
  "id": 0, // required
  "user": {
        "id": 0, // required
        "display_name": "string",
        "profile_picture": "https://example.com/file.mp3", // required
        "cover_photo": "https://example.com/file.mp3", // required
        "best_describe_you": "string", // required
        "location": "string",
        "genres": [
          {
                  "id": 0, // required
                  "name": "pop"  // options: pop | hip_hop | rnb | rock | electronic | jazz | country | alternative | soul | indie // required
                }
          ], // required
        "skills": [
          {
                  "id": 0, // required
                  "name": "mixing"  // options: mixing | mastering | songwriting | composition | vocals | guitar | piano | drums | production | engineering // required
                }
          ], // required
        "is_verified": true,
        "connection_count": 0, // required
        "match_score": 0, // required
        "is_connected": true // required
      }, // required
  "post_type": "lyrics"  // options: lyrics | audio | video | photo, // required
  "title": "string",
  "description": "string",
  "lyrics": "string",
  "audio_file": "https://example.com/file.mp3",
  "video_file": "https://example.com/file.mp3",
  "photo": "https://example.com/file.mp3",
  "genres": [
    {
          "id": 0, // required
          "name": "pop"  // options: pop | hip_hop | rnb | rock | electronic | jazz | country | alternative | soul | indie // required
        }
    ], // required
  "genre_ids": [
    0
    ],
  "shared_from": {
        "id": 0, // required
        "user": {
                "id": 0, // required
                "display_name": "string",
                "profile_picture": "https://example.com/file.mp3", // required
                "cover_photo": "https://example.com/file.mp3", // required
                "best_describe_you": "string", // required
                "location": "string",
                "genres": [
                  {
                            "id": "...", // required
                            "name": "..." // required
                          }
                  ], // required
                "skills": [
                  {
                            "id": "...", // required
                            "name": "..." // required
                          }
                  ], // required
                "is_verified": true,
                "connection_count": 0, // required
                "match_score": 0, // required
                "is_connected": true // required
              }, // required
        "post_type": "lyrics"  // options: lyrics | audio | video | photo, // required
        "title": "string",
        "description": "string",
        "lyrics": "string",
        "audio_file": "https://example.com/file.mp3",
        "video_file": "https://example.com/file.mp3",
        "photo": "https://example.com/file.mp3",
        "genres": [
          {
                  "id": 0, // required
                  "name": "pop"  // options: pop | hip_hop | rnb | rock | electronic | jazz | country | alternative | soul | indie // required
                }
          ], // required
        "allow_downloads": true,
        "allow_comments": true,
        "created_at": "2024-01-01T12:00:00Z" // required
      }, // required
  "allow_downloads": true,
  "allow_comments": true,
  "likes_count": "string", // required
  "comments_count": "string", // required
  "shares_count": "string", // required
  "saves_count": "string", // required
  "is_liked": "string", // required
  "is_saved": "string", // required
  "is_shared": "string", // required
  "created_at": "2024-01-01T12:00:00Z", // required
  "updated_at": "2024-01-01T12:00:00Z" // required
}
```

**Response:** `200` No content

---

### `POST` /api/v1/feed/{id}/report/
**Report a post**

**Path Parameters**

| Parameter | Type | Description |
|---|---|---|
| `id` | integer |  |

**Request Body** (application/json)

```json
{
  "id": 0, // required
  "reason": "inappropriate_content"  // options: inappropriate_content | copyright_violation | spam | hate_speech | misinformation | other, // required
  "notes": "string",
  "created_at": "2024-01-01T12:00:00Z" // required
}
```

**Response:** `201` No content

---

### `POST` /api/v1/feed/{id}/save/
**Save or unsave a post (toggle)**

**Path Parameters**

| Parameter | Type | Description |
|---|---|---|
| `id` | integer |  |

**Request Body** (application/json)

```json
{
  "id": 0, // required
  "user": {
        "id": 0, // required
        "display_name": "string",
        "profile_picture": "https://example.com/file.mp3", // required
        "cover_photo": "https://example.com/file.mp3", // required
        "best_describe_you": "string", // required
        "location": "string",
        "genres": [
          {
                  "id": 0, // required
                  "name": "pop"  // options: pop | hip_hop | rnb | rock | electronic | jazz | country | alternative | soul | indie // required
                }
          ], // required
        "skills": [
          {
                  "id": 0, // required
                  "name": "mixing"  // options: mixing | mastering | songwriting | composition | vocals | guitar | piano | drums | production | engineering // required
                }
          ], // required
        "is_verified": true,
        "connection_count": 0, // required
        "match_score": 0, // required
        "is_connected": true // required
      }, // required
  "post_type": "lyrics"  // options: lyrics | audio | video | photo, // required
  "title": "string",
  "description": "string",
  "lyrics": "string",
  "audio_file": "https://example.com/file.mp3",
  "video_file": "https://example.com/file.mp3",
  "photo": "https://example.com/file.mp3",
  "genres": [
    {
          "id": 0, // required
          "name": "pop"  // options: pop | hip_hop | rnb | rock | electronic | jazz | country | alternative | soul | indie // required
        }
    ], // required
  "genre_ids": [
    0
    ],
  "shared_from": {
        "id": 0, // required
        "user": {
                "id": 0, // required
                "display_name": "string",
                "profile_picture": "https://example.com/file.mp3", // required
                "cover_photo": "https://example.com/file.mp3", // required
                "best_describe_you": "string", // required
                "location": "string",
                "genres": [
                  {
                            "id": "...", // required
                            "name": "..." // required
                          }
                  ], // required
                "skills": [
                  {
                            "id": "...", // required
                            "name": "..." // required
                          }
                  ], // required
                "is_verified": true,
                "connection_count": 0, // required
                "match_score": 0, // required
                "is_connected": true // required
              }, // required
        "post_type": "lyrics"  // options: lyrics | audio | video | photo, // required
        "title": "string",
        "description": "string",
        "lyrics": "string",
        "audio_file": "https://example.com/file.mp3",
        "video_file": "https://example.com/file.mp3",
        "photo": "https://example.com/file.mp3",
        "genres": [
          {
                  "id": 0, // required
                  "name": "pop"  // options: pop | hip_hop | rnb | rock | electronic | jazz | country | alternative | soul | indie // required
                }
          ], // required
        "allow_downloads": true,
        "allow_comments": true,
        "created_at": "2024-01-01T12:00:00Z" // required
      }, // required
  "allow_downloads": true,
  "allow_comments": true,
  "likes_count": "string", // required
  "comments_count": "string", // required
  "shares_count": "string", // required
  "saves_count": "string", // required
  "is_liked": "string", // required
  "is_saved": "string", // required
  "is_shared": "string", // required
  "created_at": "2024-01-01T12:00:00Z", // required
  "updated_at": "2024-01-01T12:00:00Z" // required
}
```

**Response:** `200` No content

---

### `POST` /api/v1/feed/{id}/share/
**Share a post**

**Path Parameters**

| Parameter | Type | Description |
|---|---|---|
| `id` | integer |  |

**Response `200`**

```json
{
  "id": 0, // required
  "user": {
        "id": 0, // required
        "display_name": "string",
        "profile_picture": "https://example.com/file.mp3", // required
        "cover_photo": "https://example.com/file.mp3", // required
        "best_describe_you": "string", // required
        "location": "string",
        "genres": [
          {
                  "id": 0, // required
                  "name": "pop"  // options: pop | hip_hop | rnb | rock | electronic | jazz | country | alternative | soul | indie // required
                }
          ], // required
        "skills": [
          {
                  "id": 0, // required
                  "name": "mixing"  // options: mixing | mastering | songwriting | composition | vocals | guitar | piano | drums | production | engineering // required
                }
          ], // required
        "is_verified": true,
        "connection_count": 0, // required
        "match_score": 0, // required
        "is_connected": true // required
      }, // required
  "post_type": "lyrics"  // options: lyrics | audio | video | photo, // required
  "title": "string",
  "description": "string",
  "lyrics": "string",
  "audio_file": "https://example.com/file.mp3",
  "video_file": "https://example.com/file.mp3",
  "photo": "https://example.com/file.mp3",
  "genres": [
    {
          "id": 0, // required
          "name": "pop"  // options: pop | hip_hop | rnb | rock | electronic | jazz | country | alternative | soul | indie // required
        }
    ], // required
  "genre_ids": [
    0
    ],
  "shared_from": {
        "id": 0, // required
        "user": {
                "id": 0, // required
                "display_name": "string",
                "profile_picture": "https://example.com/file.mp3", // required
                "cover_photo": "https://example.com/file.mp3", // required
                "best_describe_you": "string", // required
                "location": "string",
                "genres": [
                  {
                            "id": "...", // required
                            "name": "..." // required
                          }
                  ], // required
                "skills": [
                  {
                            "id": "...", // required
                            "name": "..." // required
                          }
                  ], // required
                "is_verified": true,
                "connection_count": 0, // required
                "match_score": 0, // required
                "is_connected": true // required
              }, // required
        "post_type": "lyrics"  // options: lyrics | audio | video | photo, // required
        "title": "string",
        "description": "string",
        "lyrics": "string",
        "audio_file": "https://example.com/file.mp3",
        "video_file": "https://example.com/file.mp3",
        "photo": "https://example.com/file.mp3",
        "genres": [
          {
                  "id": 0, // required
                  "name": "pop"  // options: pop | hip_hop | rnb | rock | electronic | jazz | country | alternative | soul | indie // required
                }
          ], // required
        "allow_downloads": true,
        "allow_comments": true,
        "created_at": "2024-01-01T12:00:00Z" // required
      }, // required
  "allow_downloads": true,
  "allow_comments": true,
  "likes_count": "string", // required
  "comments_count": "string", // required
  "shares_count": "string", // required
  "saves_count": "string", // required
  "is_liked": "string", // required
  "is_saved": "string", // required
  "is_shared": "string", // required
  "created_at": "2024-01-01T12:00:00Z", // required
  "updated_at": "2024-01-01T12:00:00Z" // required
}
```

---

## Briefs

### `GET` /api/v1/briefs/
**List active briefs**

**Query Parameters**

| Parameter | Type | Required | Description |
|---|---|---|---|
| `category` | string | — |  |
| `looking_for` | string | — | Filter by role, e.g. vocalist |
| `page` | integer | — | A page number within the paginated result set. |
| `page_size` | integer | — | Number of results to return per page. |
| `paid_only` | string | — |  |
| `search` | string | — | Search by title, company, or overview |
| `sort` | string | — | Sort order (default: recent) |

**Response `200`**

```json
{
  "count": 0, // required
  "next": "https://example.com/file.mp3",
  "previous": "https://example.com/file.mp3",
  "results": [
    {
          "id": 0, // required
          "title": "string", // required
          "company": "string", // required
          "company_type": "major_label"  // options: major_label | independent_label | production_company | talent_agency | artist_management | independent_artist, // required
          "category": "find"  // options: find | revenue_share | collaboration | exposure, // required
          "overview": "string", // required
          "looking_for": "string", // required
          "genres": [
            {
                      "id": "...", // required
                      "name": "..." // required
                    }
            ], // required
          "budget_min": "string",
          "budget_max": "string",
          "submission_deadline": "string", // required
          "requirements_count": "string", // required
          "applications_count": "string", // required
          "days_left": "string", // required
          "is_featured": true,
          "status": "draft"  // options: draft | pending | active | closed,
          "created_at": "2024-01-01T12:00:00Z" // required
        }
    ] // required
}
```

---

### `POST` /api/v1/briefs/
**Create a brief**

**Request Body** (application/json)

```json
{
  "id": 0, // required
  "title": "string", // required
  "company": "string", // required
  "company_type": "major_label"  // options: major_label | independent_label | production_company | talent_agency | artist_management | independent_artist, // required
  "category": "find"  // options: find | revenue_share | collaboration | exposure, // required
  "overview": "string", // required
  "looking_for": "string", // required
  "genres": [
    {
          "id": 0, // required
          "name": "pop"  // options: pop | hip_hop | rnb | rock | electronic | jazz | country | alternative | soul | indie // required
        }
    ], // required
  "genre_ids": [
    0
    ],
  "budget_min": "string",
  "budget_max": "string",
  "submission_deadline": "string", // required
  "requirements": {},
  "deliverables": {},
  "allow_direct_messages": true,
  "email_notifications": true,
  "is_featured": true,
  "status": "draft"  // options: draft | pending | active | closed,
  "created_at": "2024-01-01T12:00:00Z" // required
}
```

**Response `201`**

```json
{
  "id": 0, // required
  "title": "string", // required
  "company": "string", // required
  "company_type": "major_label"  // options: major_label | independent_label | production_company | talent_agency | artist_management | independent_artist, // required
  "category": "find"  // options: find | revenue_share | collaboration | exposure, // required
  "overview": "string", // required
  "looking_for": "string", // required
  "genres": [
    {
          "id": 0, // required
          "name": "pop"  // options: pop | hip_hop | rnb | rock | electronic | jazz | country | alternative | soul | indie // required
        }
    ], // required
  "genre_ids": [
    0
    ],
  "budget_min": "string",
  "budget_max": "string",
  "submission_deadline": "string", // required
  "requirements": {},
  "deliverables": {},
  "allow_direct_messages": true,
  "email_notifications": true,
  "is_featured": true,
  "status": "draft"  // options: draft | pending | active | closed,
  "created_at": "2024-01-01T12:00:00Z" // required
}
```

---

### `GET` /api/v1/briefs/my-submissions/
**My submissions across all briefs**

**Query Parameters**

| Parameter | Type | Required | Description |
|---|---|---|---|
| `tab` | string | — | active = briefs still open; completed = briefs closed (default: active) |

**Response `200`**

```json
{
  "id": 0, // required
  "brief": {
        "id": 0, // required
        "title": "string", // required
        "company": "string", // required
        "submission_deadline": "string", // required
        "days_left": "string" // required
      }, // required
  "status": "under_review"  // options: under_review | shortlisted | selected | not_selected,
  "admin_status": "pending_review"  // options: pending_review | approved | rejected,
  "created_at": "2024-01-01T12:00:00Z", // required
  "updated_at": "2024-01-01T12:00:00Z" // required
}
```

---

### `GET` /api/v1/briefs/my/
**My created briefs**

**Response `200`**

```json
{
  "id": 0, // required
  "title": "string", // required
  "company": "string", // required
  "company_type": "major_label"  // options: major_label | independent_label | production_company | talent_agency | artist_management | independent_artist, // required
  "category": "find"  // options: find | revenue_share | collaboration | exposure, // required
  "overview": "string", // required
  "looking_for": "string", // required
  "genres": [
    {
          "id": 0, // required
          "name": "pop"  // options: pop | hip_hop | rnb | rock | electronic | jazz | country | alternative | soul | indie // required
        }
    ], // required
  "budget_min": "string",
  "budget_max": "string",
  "submission_deadline": "string", // required
  "requirements_count": "string", // required
  "applications_count": "string", // required
  "days_left": "string", // required
  "is_featured": true,
  "status": "draft"  // options: draft | pending | active | closed,
  "created_at": "2024-01-01T12:00:00Z" // required
}
```

---

### `GET` /api/v1/briefs/{id}/
**Get brief detail**

**Path Parameters**

| Parameter | Type | Description |
|---|---|---|
| `id` | integer |  |

**Response `200`**

```json
{
  "id": 0, // required
  "title": "string", // required
  "company": "string", // required
  "company_type": "major_label"  // options: major_label | independent_label | production_company | talent_agency | artist_management | independent_artist, // required
  "category": "find"  // options: find | revenue_share | collaboration | exposure, // required
  "overview": "string", // required
  "looking_for": "string", // required
  "genres": [
    {
          "id": 0, // required
          "name": "pop"  // options: pop | hip_hop | rnb | rock | electronic | jazz | country | alternative | soul | indie // required
        }
    ], // required
  "budget_min": "string",
  "budget_max": "string",
  "submission_deadline": "string", // required
  "requirements": {},
  "deliverables": {},
  "allow_direct_messages": true,
  "applications_count": "string", // required
  "days_left": "string", // required
  "is_featured": true,
  "status": "draft"  // options: draft | pending | active | closed,
  "created_by": {
        "id": 0, // required
        "display_name": "string",
        "profile_picture": "https://example.com/file.mp3",
        "is_verified": true
      }, // required
  "has_applied": "string", // required
  "user_submission_status": "string", // required
  "created_at": "2024-01-01T12:00:00Z", // required
  "updated_at": "2024-01-01T12:00:00Z" // required
}
```

---

### `PUT` /api/v1/briefs/{id}/
**Update a brief (owner only)**

**Path Parameters**

| Parameter | Type | Description |
|---|---|---|
| `id` | integer |  |

**Request Body** (application/json)

```json
{
  "id": 0, // required
  "title": "string", // required
  "company": "string", // required
  "company_type": "major_label"  // options: major_label | independent_label | production_company | talent_agency | artist_management | independent_artist, // required
  "category": "find"  // options: find | revenue_share | collaboration | exposure, // required
  "overview": "string", // required
  "looking_for": "string", // required
  "genres": [
    {
          "id": 0, // required
          "name": "pop"  // options: pop | hip_hop | rnb | rock | electronic | jazz | country | alternative | soul | indie // required
        }
    ], // required
  "genre_ids": [
    0
    ],
  "budget_min": "string",
  "budget_max": "string",
  "submission_deadline": "string", // required
  "requirements": {},
  "deliverables": {},
  "allow_direct_messages": true,
  "email_notifications": true,
  "is_featured": true,
  "status": "draft"  // options: draft | pending | active | closed,
  "created_at": "2024-01-01T12:00:00Z" // required
}
```

**Response `200`**

```json
{
  "id": 0, // required
  "title": "string", // required
  "company": "string", // required
  "company_type": "major_label"  // options: major_label | independent_label | production_company | talent_agency | artist_management | independent_artist, // required
  "category": "find"  // options: find | revenue_share | collaboration | exposure, // required
  "overview": "string", // required
  "looking_for": "string", // required
  "genres": [
    {
          "id": 0, // required
          "name": "pop"  // options: pop | hip_hop | rnb | rock | electronic | jazz | country | alternative | soul | indie // required
        }
    ], // required
  "genre_ids": [
    0
    ],
  "budget_min": "string",
  "budget_max": "string",
  "submission_deadline": "string", // required
  "requirements": {},
  "deliverables": {},
  "allow_direct_messages": true,
  "email_notifications": true,
  "is_featured": true,
  "status": "draft"  // options: draft | pending | active | closed,
  "created_at": "2024-01-01T12:00:00Z" // required
}
```

---

### `PATCH` /api/v1/briefs/{id}/
**Partially update a brief (owner only)**

**Path Parameters**

| Parameter | Type | Description |
|---|---|---|
| `id` | integer |  |

**Request Body** (application/json)

```json
{
  "id": 0,
  "title": "string",
  "company": "string",
  "company_type": "major_label"  // options: major_label | independent_label | production_company | talent_agency | artist_management | independent_artist,
  "category": "find"  // options: find | revenue_share | collaboration | exposure,
  "overview": "string",
  "looking_for": "string",
  "genres": [
    {
          "id": 0, // required
          "name": "pop"  // options: pop | hip_hop | rnb | rock | electronic | jazz | country | alternative | soul | indie // required
        }
    ],
  "genre_ids": [
    0
    ],
  "budget_min": "string",
  "budget_max": "string",
  "submission_deadline": "string",
  "requirements": {},
  "deliverables": {},
  "allow_direct_messages": true,
  "email_notifications": true,
  "is_featured": true,
  "status": "draft"  // options: draft | pending | active | closed,
  "created_at": "2024-01-01T12:00:00Z"
}
```

**Response `200`**

```json
{
  "id": 0, // required
  "title": "string", // required
  "company": "string", // required
  "company_type": "major_label"  // options: major_label | independent_label | production_company | talent_agency | artist_management | independent_artist, // required
  "category": "find"  // options: find | revenue_share | collaboration | exposure, // required
  "overview": "string", // required
  "looking_for": "string", // required
  "genres": [
    {
          "id": 0, // required
          "name": "pop"  // options: pop | hip_hop | rnb | rock | electronic | jazz | country | alternative | soul | indie // required
        }
    ], // required
  "genre_ids": [
    0
    ],
  "budget_min": "string",
  "budget_max": "string",
  "submission_deadline": "string", // required
  "requirements": {},
  "deliverables": {},
  "allow_direct_messages": true,
  "email_notifications": true,
  "is_featured": true,
  "status": "draft"  // options: draft | pending | active | closed,
  "created_at": "2024-01-01T12:00:00Z" // required
}
```

---

### `DELETE` /api/v1/briefs/{id}/
**Delete a brief (owner only)**

**Path Parameters**

| Parameter | Type | Description |
|---|---|---|
| `id` | integer |  |

**Response:** `204` No content

---

### `POST` /api/v1/briefs/{id}/apply/
**Apply to a brief**

**Path Parameters**

| Parameter | Type | Description |
|---|---|---|
| `id` | integer |  |

**Request Body** (application/json)

```json
{
  "id": 0, // required
  "work_sample": "https://example.com/file.mp3",
  "cover_letter": "string",
  "portfolio_link": "https://example.com/file.mp3",
  "status": {}, // required
  "created_at": "2024-01-01T12:00:00Z" // required
}
```

**Response `200`**

```json
{
  "id": 0, // required
  "work_sample": "https://example.com/file.mp3",
  "cover_letter": "string",
  "portfolio_link": "https://example.com/file.mp3",
  "status": {}, // required
  "created_at": "2024-01-01T12:00:00Z" // required
}
```

---

### `GET` /api/v1/briefs/{id}/submissions/
**View submissions to my brief**

**Path Parameters**

| Parameter | Type | Description |
|---|---|---|
| `id` | integer |  |

**Query Parameters**

| Parameter | Type | Required | Description |
|---|---|---|---|
| `status` | string | — | Filter submissions by status |

**Response `200`**

```json
{
  "id": 0, // required
  "applicant": {
        "id": 0, // required
        "display_name": "string",
        "profile_picture": "https://example.com/file.mp3",
        "is_verified": true
      }, // required
  "work_sample": "https://example.com/file.mp3", // required
  "cover_letter": "string", // required
  "portfolio_link": "https://example.com/file.mp3", // required
  "status": "under_review"  // options: under_review | shortlisted | selected | not_selected,
  "created_at": "2024-01-01T12:00:00Z", // required
  "updated_at": "2024-01-01T12:00:00Z" // required
}
```

---

### `PATCH` /api/v1/briefs/{id}/submissions/{sub_pk}/status/
**Update a submission status (brief owner only)**

**Path Parameters**

| Parameter | Type | Description |
|---|---|---|
| `id` | integer |  |
| `sub_pk` | integer |  |

**Request Body** (application/json)

```json
{
  "status": "under_review"  // options: under_review | shortlisted | selected | not_selected
}
```

**Response `200`**

```json
{
  "status": "under_review"  // options: under_review | shortlisted | selected | not_selected
}
```

---

## Projects

### `GET` /api/v1/projects/
**List my projects**

**Query Parameters**

| Parameter | Type | Required | Description |
|---|---|---|---|
| `page` | integer | — | A page number within the paginated result set. |
| `page_size` | integer | — | Number of results to return per page. |

**Response `200`**

```json
{
  "count": 0, // required
  "next": "https://example.com/file.mp3",
  "previous": "https://example.com/file.mp3",
  "results": [
    {
          "id": 0, // required
          "title": "string", // required
          "genre": "string",
          "project_type": "string",
          "status": "in_progress"  // options: in_progress | completed | on_hold,
          "status_display": "string", // required
          "progress": 0, // required
          "total_files": 0, // required
          "collaborators_count": "string", // required
          "owner": {
                    "id": 0, // required
                    "display_name": "string", // required
                    "profile_picture": "https://example.com/file.mp3", // required
                    "email": "user@example.com" // required
                  }, // required
          "created_at": "2024-01-01T12:00:00Z", // required
          "updated_at": "2024-01-01T12:00:00Z" // required
        }
    ] // required
}
```

---

### `POST` /api/v1/projects/
**Create a project manually**

**Request Body** (application/json)

```json
{
  "title": "string", // required
  "genre": "string",
  "project_type": "string",
  "status": "in_progress"  // options: in_progress | completed | on_hold
}
```

**Response `201`**

```json
{
  "title": "string", // required
  "genre": "string",
  "project_type": "string",
  "status": "in_progress"  // options: in_progress | completed | on_hold
}
```

---

### `GET` /api/v1/projects/{id}/
**Get project detail**

**Path Parameters**

| Parameter | Type | Description |
|---|---|---|
| `id` | integer |  |

**Response `200`**

```json
{
  "id": 0, // required
  "title": "string", // required
  "genre": "string",
  "project_type": "string",
  "status": "in_progress"  // options: in_progress | completed | on_hold,
  "status_display": "string", // required
  "source_brief_id": 0, // required
  "owner": {
        "id": 0, // required
        "display_name": "string", // required
        "profile_picture": "https://example.com/file.mp3", // required
        "email": "user@example.com" // required
      }, // required
  "collaborators": [
    {
          "id": 0, // required
          "user": {
                    "id": 0, // required
                    "display_name": "string", // required
                    "profile_picture": "https://example.com/file.mp3", // required
                    "email": "user@example.com" // required
                  }, // required
          "role": "owner"  // options: owner | admin | collaborator | viewer,
          "specialty": "string",
          "revenue_split": "string",
          "joined_at": "2024-01-01T12:00:00Z" // required
        }
    ], // required
  "progress": {
        "overall": 0, // required
        "total_files": 0, // required
        "audio_files": 0, // required
        "lyrics": 0, // required
        "comments": 0 // required
      }, // required
  "created_at": "2024-01-01T12:00:00Z", // required
  "updated_at": "2024-01-01T12:00:00Z" // required
}
```

---

### `PATCH` /api/v1/projects/{id}/
**Update project (owner/admin)**

**Path Parameters**

| Parameter | Type | Description |
|---|---|---|
| `id` | integer |  |

**Request Body** (application/json)

```json
{
  "title": "string",
  "genre": "string",
  "project_type": "string",
  "status": "in_progress"  // options: in_progress | completed | on_hold
}
```

**Response `200`**

```json
{
  "title": "string", // required
  "genre": "string",
  "project_type": "string",
  "status": "in_progress"  // options: in_progress | completed | on_hold
}
```

---

### `DELETE` /api/v1/projects/{id}/
**Delete project (owner only)**

**Path Parameters**

| Parameter | Type | Description |
|---|---|---|
| `id` | integer |  |

**Response:** `204` No content

---

### `GET` /api/v1/projects/{project_pk}/collaborators/
**List collaborators**

**Path Parameters**

| Parameter | Type | Description |
|---|---|---|
| `project_pk` | integer |  |

**Response:** `200` No content

---

### `POST` /api/v1/projects/{project_pk}/collaborators/
**Invite a collaborator**

**Path Parameters**

| Parameter | Type | Description |
|---|---|---|
| `project_pk` | integer |  |

**Request Body** (application/json)

```json
{
  "user_id": 0, // required
  "role": "owner"  // options: owner | admin | collaborator | viewer, // required
  "specialty": "string",
  "personal_message": "string"
}
```

**Response:** `201` No content

---

### `DELETE` /api/v1/projects/{project_pk}/collaborators/leave/
**Leave project (self-remove)**

**Path Parameters**

| Parameter | Type | Description |
|---|---|---|
| `project_pk` | integer |  |

**Response:** `204` No content

---

### `DELETE` /api/v1/projects/{project_pk}/collaborators/{id}/
**Remove a collaborator**

**Path Parameters**

| Parameter | Type | Description |
|---|---|---|
| `id` | integer |  |
| `project_pk` | integer |  |

**Response:** `204` No content

---

### `PATCH` /api/v1/projects/{project_pk}/collaborators/{id}/role/
**Update collaborator role**

**Path Parameters**

| Parameter | Type | Description |
|---|---|---|
| `id` | integer |  |
| `project_pk` | integer |  |

**Request Body** (application/json)

```json
{
  "role": "owner"  // options: owner | admin | collaborator | viewer,
  "specialty": "string"
}
```

**Response:** `200` No content

---

### `GET` /api/v1/projects/{project_pk}/comments/
**List top-level comments (with nested replies)**

**Path Parameters**

| Parameter | Type | Description |
|---|---|---|
| `project_pk` | integer |  |

**Response:** `200` No content

---

### `POST` /api/v1/projects/{project_pk}/comments/
**Post a comment or reply**

**Path Parameters**

| Parameter | Type | Description |
|---|---|---|
| `project_pk` | integer |  |

**Request Body** (application/json)

```json
{
  "content": "string", // required
  "parent": 0
}
```

**Response:** `201` No content

---

### `DELETE` /api/v1/projects/{project_pk}/comments/{id}/
**Delete a comment (author or owner)**

**Path Parameters**

| Parameter | Type | Description |
|---|---|---|
| `id` | integer |  |
| `project_pk` | integer |  |

**Response:** `204` No content

---

### `GET` /api/v1/projects/{project_pk}/files/
**List project files**

**Path Parameters**

| Parameter | Type | Description |
|---|---|---|
| `project_pk` | integer |  |

**Query Parameters**

| Parameter | Type | Required | Description |
|---|---|---|---|
| `file_type` | string | — |  |

**Response:** `200` No content

---

### `POST` /api/v1/projects/{project_pk}/files/
**Upload a file to the project**

**Path Parameters**

| Parameter | Type | Description |
|---|---|---|
| `project_pk` | integer |  |

**Request Body** (application/json)

```json
{
  "name": "string", // required
  "file": "https://example.com/file.mp3", // required
  "file_type": "audio"  // options: audio | other
}
```

**Response:** `201` No content

---

### `DELETE` /api/v1/projects/{project_pk}/files/{id}/
**Delete a file (owner only)**

**Path Parameters**

| Parameter | Type | Description |
|---|---|---|
| `id` | integer |  |
| `project_pk` | integer |  |

**Response:** `204` No content

---

### `GET` /api/v1/projects/{project_pk}/files/{id}/download/
**Download a file**

**Path Parameters**

| Parameter | Type | Description |
|---|---|---|
| `id` | integer |  |
| `project_pk` | integer |  |

**Response:** `200` No content

---

### `GET` /api/v1/projects/{project_pk}/lyrics/
**List project lyrics**

**Path Parameters**

| Parameter | Type | Description |
|---|---|---|
| `project_pk` | integer |  |

**Response:** `200` No content

---

### `POST` /api/v1/projects/{project_pk}/lyrics/
**Upload lyrics to the project**

**Path Parameters**

| Parameter | Type | Description |
|---|---|---|
| `project_pk` | integer |  |

**Request Body** (application/json)

```json
{
  "title": "string", // required
  "content": "string",
  "file": "https://example.com/file.mp3"
}
```

**Response:** `201` No content

---

### `GET` /api/v1/projects/{project_pk}/lyrics/{id}/
**Get lyrics detail**

**Path Parameters**

| Parameter | Type | Description |
|---|---|---|
| `id` | integer |  |
| `project_pk` | integer |  |

**Response:** `200` No content

---

### `PATCH` /api/v1/projects/{project_pk}/lyrics/{id}/
**Update lyrics (uploader or owner)**

**Path Parameters**

| Parameter | Type | Description |
|---|---|---|
| `id` | integer |  |
| `project_pk` | integer |  |

**Response:** `200` No content

---

### `DELETE` /api/v1/projects/{project_pk}/lyrics/{id}/
**Delete lyrics (uploader or owner)**

**Path Parameters**

| Parameter | Type | Description |
|---|---|---|
| `id` | integer |  |
| `project_pk` | integer |  |

**Response:** `204` No content

---

### `GET` /api/v1/projects/{project_pk}/progress/
**Get project progress**

**Path Parameters**

| Parameter | Type | Description |
|---|---|---|
| `project_pk` | integer |  |

**Response:** `200` No content

---

### `GET` /api/v1/projects/{project_pk}/splits/
**View revenue splits**

**Path Parameters**

| Parameter | Type | Description |
|---|---|---|
| `project_pk` | integer |  |

**Response:** `200` No content

---

### `PUT` /api/v1/projects/{project_pk}/splits/
**Update revenue splits (owner only)**

**Path Parameters**

| Parameter | Type | Description |
|---|---|---|
| `project_pk` | integer |  |

**Request Body** (application/json)

```json
{
  "splits": [
    {
          "collaborator_id": 0, // required
          "revenue_split": "string" // required
        }
    ] // required
}
```

**Response:** `200` No content

---

## Sessions

### `GET` /api/v1/sessions/
**List sessions**

**Query Parameters**

| Parameter | Type | Required | Description |
|---|---|---|---|
| `page` | integer | — | A page number within the paginated result set. |
| `page_size` | integer | — | Number of results to return per page. |

**Response `200`**

```json
{
  "count": 0, // required
  "next": "https://example.com/file.mp3",
  "previous": "https://example.com/file.mp3",
  "results": [
    {
          "id": 0, // required
          "title": "string", // required
          "description": "string",
          "privacy": "public"  // options: public | private | invite_only,
          "status": "upcoming"  // options: upcoming | live | ended,
          "session_link": "string",
          "scheduled_at": "2024-01-01T12:00:00Z",
          "started_at": "2024-01-01T12:00:00Z",
          "ended_at": "2024-01-01T12:00:00Z",
          "host": {
                    "id": 0, // required
                    "display_name": "string",
                    "profile_picture": "https://example.com/file.mp3"
                  }, // required
          "participant_count": 0, // required
          "active_participants": "string", // required
          "created_at": "2024-01-01T12:00:00Z" // required
        }
    ] // required
}
```

---

### `POST` /api/v1/sessions/
**Create a new session**

**Request Body** (application/json)

```json
{
  "title": "string", // required
  "description": "string",
  "privacy": "public"  // options: public | private | invite_only,
  "scheduled_at": "2024-01-01T12:00:00Z"
}
```

**Response `201`**

```json
{
  "title": "string", // required
  "description": "string",
  "privacy": "public"  // options: public | private | invite_only,
  "scheduled_at": "2024-01-01T12:00:00Z"
}
```

---

### `POST` /api/v1/sessions/join-by-link/
**Join a session by session link**

**Request Body** (application/json)

```json
{
  "id": 0, // required
  "title": "string", // required
  "description": "string",
  "privacy": "public"  // options: public | private | invite_only,
  "status": "upcoming"  // options: upcoming | live | ended,
  "session_link": "string",
  "scheduled_at": "2024-01-01T12:00:00Z",
  "started_at": "2024-01-01T12:00:00Z",
  "ended_at": "2024-01-01T12:00:00Z",
  "host": {
        "id": 0, // required
        "display_name": "string",
        "profile_picture": "https://example.com/file.mp3"
      }, // required
  "participant_count": 0, // required
  "active_participants": "string", // required
  "created_at": "2024-01-01T12:00:00Z" // required
}
```

**Response `200`**

```json
{
  "id": 0, // required
  "title": "string", // required
  "description": "string",
  "privacy": "public"  // options: public | private | invite_only,
  "status": "upcoming"  // options: upcoming | live | ended,
  "session_link": "string",
  "scheduled_at": "2024-01-01T12:00:00Z",
  "started_at": "2024-01-01T12:00:00Z",
  "ended_at": "2024-01-01T12:00:00Z",
  "host": {
        "id": 0, // required
        "display_name": "string",
        "profile_picture": "https://example.com/file.mp3"
      }, // required
  "participant_count": 0, // required
  "active_participants": "string", // required
  "created_at": "2024-01-01T12:00:00Z" // required
}
```

---

### `GET` /api/v1/sessions/my-invites/
**List my pending invites**

**Response `200`**

```json
{
  "id": 0, // required
  "title": "string", // required
  "description": "string",
  "privacy": "public"  // options: public | private | invite_only,
  "status": "upcoming"  // options: upcoming | live | ended,
  "session_link": "string",
  "scheduled_at": "2024-01-01T12:00:00Z",
  "started_at": "2024-01-01T12:00:00Z",
  "ended_at": "2024-01-01T12:00:00Z",
  "host": {
        "id": 0, // required
        "display_name": "string",
        "profile_picture": "https://example.com/file.mp3"
      }, // required
  "participant_count": 0, // required
  "active_participants": "string", // required
  "created_at": "2024-01-01T12:00:00Z" // required
}
```

---

### `GET` /api/v1/sessions/{id}/
**Get session details**

**Path Parameters**

| Parameter | Type | Description |
|---|---|---|
| `id` | integer |  |

**Response `200`**

```json
{
  "id": 0, // required
  "title": "string", // required
  "description": "string",
  "privacy": "public"  // options: public | private | invite_only,
  "status": "upcoming"  // options: upcoming | live | ended,
  "session_link": "string",
  "scheduled_at": "2024-01-01T12:00:00Z",
  "started_at": "2024-01-01T12:00:00Z",
  "ended_at": "2024-01-01T12:00:00Z",
  "host": {
        "id": 0, // required
        "display_name": "string",
        "profile_picture": "https://example.com/file.mp3"
      }, // required
  "participants": [
    {
          "id": 0, // required
          "user": {
                    "id": 0, // required
                    "display_name": "string",
                    "profile_picture": "https://example.com/file.mp3"
                  }, // required
          "role": "host"  // options: host | participant,
          "joined_at": "2024-01-01T12:00:00Z", // required
          "is_active": true
        }
    ], // required
  "participant_count": 0, // required
  "created_at": "2024-01-01T12:00:00Z", // required
  "updated_at": "2024-01-01T12:00:00Z" // required
}
```

---

### `PATCH` /api/v1/sessions/{id}/
**Update session (host only)**

**Path Parameters**

| Parameter | Type | Description |
|---|---|---|
| `id` | integer |  |

**Request Body** (application/json)

```json
{
  "title": "string",
  "description": "string",
  "privacy": "public"  // options: public | private | invite_only,
  "scheduled_at": "2024-01-01T12:00:00Z"
}
```

**Response `200`**

```json
{
  "title": "string", // required
  "description": "string",
  "privacy": "public"  // options: public | private | invite_only,
  "scheduled_at": "2024-01-01T12:00:00Z"
}
```

---

### `DELETE` /api/v1/sessions/{id}/
**Delete session (host only)**

**Path Parameters**

| Parameter | Type | Description |
|---|---|---|
| `id` | integer |  |

**Response:** `204` No content

---

### `GET` /api/v1/sessions/{id}/call-token/
**Get ZegoCloud token for calls / video calls in this session**

**Path Parameters**

| Parameter | Type | Description |
|---|---|---|
| `id` | integer |  |

**Response `200`**

```json
{
  "token": "string",
  "app_id": 0
}
```

---

### `POST` /api/v1/sessions/{id}/end/
**End session (host only)**

**Path Parameters**

| Parameter | Type | Description |
|---|---|---|
| `id` | integer |  |

**Request Body** (application/json)

```json
{
  "id": 0, // required
  "title": "string", // required
  "description": "string",
  "privacy": "public"  // options: public | private | invite_only,
  "status": "upcoming"  // options: upcoming | live | ended,
  "session_link": "string",
  "scheduled_at": "2024-01-01T12:00:00Z",
  "started_at": "2024-01-01T12:00:00Z",
  "ended_at": "2024-01-01T12:00:00Z",
  "host": {
        "id": 0, // required
        "display_name": "string",
        "profile_picture": "https://example.com/file.mp3"
      }, // required
  "participant_count": 0, // required
  "active_participants": "string", // required
  "created_at": "2024-01-01T12:00:00Z" // required
}
```

**Response `200`**

```json
{
  "id": 0, // required
  "title": "string", // required
  "description": "string",
  "privacy": "public"  // options: public | private | invite_only,
  "status": "upcoming"  // options: upcoming | live | ended,
  "session_link": "string",
  "scheduled_at": "2024-01-01T12:00:00Z",
  "started_at": "2024-01-01T12:00:00Z",
  "ended_at": "2024-01-01T12:00:00Z",
  "host": {
        "id": 0, // required
        "display_name": "string",
        "profile_picture": "https://example.com/file.mp3"
      }, // required
  "participant_count": 0, // required
  "active_participants": "string", // required
  "created_at": "2024-01-01T12:00:00Z" // required
}
```

---

### `POST` /api/v1/sessions/{id}/invite/
**Invite a user to a session (host or participant)**

**Path Parameters**

| Parameter | Type | Description |
|---|---|---|
| `id` | integer |  |

**Request Body** (application/json)

```json
{
  "user_id": 0 // required
}
```

**Response `200`**

```json
{
  "id": 0, // required
  "title": "string", // required
  "description": "string",
  "privacy": "public"  // options: public | private | invite_only,
  "status": "upcoming"  // options: upcoming | live | ended,
  "session_link": "string",
  "scheduled_at": "2024-01-01T12:00:00Z",
  "started_at": "2024-01-01T12:00:00Z",
  "ended_at": "2024-01-01T12:00:00Z",
  "host": {
        "id": 0, // required
        "display_name": "string",
        "profile_picture": "https://example.com/file.mp3"
      }, // required
  "participant_count": 0, // required
  "active_participants": "string", // required
  "created_at": "2024-01-01T12:00:00Z" // required
}
```

---

### `POST` /api/v1/sessions/{id}/invites/respond/
**Respond to a session invite (accept/decline)**

**Path Parameters**

| Parameter | Type | Description |
|---|---|---|
| `id` | integer |  |

**Request Body** (application/json)

```json
{
  "action": "accept"  // options: accept | decline // required
}
```

**Response `200`**

```json
{
  "id": 0, // required
  "title": "string", // required
  "description": "string",
  "privacy": "public"  // options: public | private | invite_only,
  "status": "upcoming"  // options: upcoming | live | ended,
  "session_link": "string",
  "scheduled_at": "2024-01-01T12:00:00Z",
  "started_at": "2024-01-01T12:00:00Z",
  "ended_at": "2024-01-01T12:00:00Z",
  "host": {
        "id": 0, // required
        "display_name": "string",
        "profile_picture": "https://example.com/file.mp3"
      }, // required
  "participant_count": 0, // required
  "active_participants": "string", // required
  "created_at": "2024-01-01T12:00:00Z" // required
}
```

---

### `POST` /api/v1/sessions/{id}/join/
**Join a session by ID**

**Path Parameters**

| Parameter | Type | Description |
|---|---|---|
| `id` | integer |  |

**Request Body** (application/json)

```json
{
  "id": 0, // required
  "title": "string", // required
  "description": "string",
  "privacy": "public"  // options: public | private | invite_only,
  "status": "upcoming"  // options: upcoming | live | ended,
  "session_link": "string",
  "scheduled_at": "2024-01-01T12:00:00Z",
  "started_at": "2024-01-01T12:00:00Z",
  "ended_at": "2024-01-01T12:00:00Z",
  "host": {
        "id": 0, // required
        "display_name": "string",
        "profile_picture": "https://example.com/file.mp3"
      }, // required
  "participant_count": 0, // required
  "active_participants": "string", // required
  "created_at": "2024-01-01T12:00:00Z" // required
}
```

**Response `200`**

```json
{
  "id": 0, // required
  "title": "string", // required
  "description": "string",
  "privacy": "public"  // options: public | private | invite_only,
  "status": "upcoming"  // options: upcoming | live | ended,
  "session_link": "string",
  "scheduled_at": "2024-01-01T12:00:00Z",
  "started_at": "2024-01-01T12:00:00Z",
  "ended_at": "2024-01-01T12:00:00Z",
  "host": {
        "id": 0, // required
        "display_name": "string",
        "profile_picture": "https://example.com/file.mp3"
      }, // required
  "participant_count": 0, // required
  "active_participants": "string", // required
  "created_at": "2024-01-01T12:00:00Z" // required
}
```

---

### `POST` /api/v1/sessions/{id}/leave/
**Leave a session**

**Path Parameters**

| Parameter | Type | Description |
|---|---|---|
| `id` | integer |  |

**Request Body** (application/json)

```json
{
  "id": 0, // required
  "title": "string", // required
  "description": "string",
  "privacy": "public"  // options: public | private | invite_only,
  "status": "upcoming"  // options: upcoming | live | ended,
  "session_link": "string",
  "scheduled_at": "2024-01-01T12:00:00Z",
  "started_at": "2024-01-01T12:00:00Z",
  "ended_at": "2024-01-01T12:00:00Z",
  "host": {
        "id": 0, // required
        "display_name": "string",
        "profile_picture": "https://example.com/file.mp3"
      }, // required
  "participant_count": 0, // required
  "active_participants": "string", // required
  "created_at": "2024-01-01T12:00:00Z" // required
}
```

**Response `200`**

```json
{
  "id": 0, // required
  "title": "string", // required
  "description": "string",
  "privacy": "public"  // options: public | private | invite_only,
  "status": "upcoming"  // options: upcoming | live | ended,
  "session_link": "string",
  "scheduled_at": "2024-01-01T12:00:00Z",
  "started_at": "2024-01-01T12:00:00Z",
  "ended_at": "2024-01-01T12:00:00Z",
  "host": {
        "id": 0, // required
        "display_name": "string",
        "profile_picture": "https://example.com/file.mp3"
      }, // required
  "participant_count": 0, // required
  "active_participants": "string", // required
  "created_at": "2024-01-01T12:00:00Z" // required
}
```

---

### `GET` /api/v1/sessions/{id}/messages/
**List chat messages in a session**

**Path Parameters**

| Parameter | Type | Description |
|---|---|---|
| `id` | integer |  |

**Response `200`**

```json
{
  "id": 0, // required
  "title": "string", // required
  "description": "string",
  "privacy": "public"  // options: public | private | invite_only,
  "status": "upcoming"  // options: upcoming | live | ended,
  "session_link": "string",
  "scheduled_at": "2024-01-01T12:00:00Z",
  "started_at": "2024-01-01T12:00:00Z",
  "ended_at": "2024-01-01T12:00:00Z",
  "host": {
        "id": 0, // required
        "display_name": "string",
        "profile_picture": "https://example.com/file.mp3"
      }, // required
  "participant_count": 0, // required
  "active_participants": "string", // required
  "created_at": "2024-01-01T12:00:00Z" // required
}
```

---

### `POST` /api/v1/sessions/{id}/messages/send/
**Send a chat message to a session**

**Path Parameters**

| Parameter | Type | Description |
|---|---|---|
| `id` | integer |  |

**Request Body** (application/json)

```json
{
  "content": "string" // required
}
```

**Response `200`**

```json
{
  "id": 0, // required
  "title": "string", // required
  "description": "string",
  "privacy": "public"  // options: public | private | invite_only,
  "status": "upcoming"  // options: upcoming | live | ended,
  "session_link": "string",
  "scheduled_at": "2024-01-01T12:00:00Z",
  "started_at": "2024-01-01T12:00:00Z",
  "ended_at": "2024-01-01T12:00:00Z",
  "host": {
        "id": 0, // required
        "display_name": "string",
        "profile_picture": "https://example.com/file.mp3"
      }, // required
  "participant_count": 0, // required
  "active_participants": "string", // required
  "created_at": "2024-01-01T12:00:00Z" // required
}
```

---

### `GET` /api/v1/sessions/{id}/participants/
**List session participants**

**Path Parameters**

| Parameter | Type | Description |
|---|---|---|
| `id` | integer |  |

**Response `200`**

```json
{
  "id": 0, // required
  "title": "string", // required
  "description": "string",
  "privacy": "public"  // options: public | private | invite_only,
  "status": "upcoming"  // options: upcoming | live | ended,
  "session_link": "string",
  "scheduled_at": "2024-01-01T12:00:00Z",
  "started_at": "2024-01-01T12:00:00Z",
  "ended_at": "2024-01-01T12:00:00Z",
  "host": {
        "id": 0, // required
        "display_name": "string",
        "profile_picture": "https://example.com/file.mp3"
      }, // required
  "participant_count": 0, // required
  "active_participants": "string", // required
  "created_at": "2024-01-01T12:00:00Z" // required
}
```

---

### `POST` /api/v1/sessions/{id}/start/
**Start session (host only)**

**Path Parameters**

| Parameter | Type | Description |
|---|---|---|
| `id` | integer |  |

**Request Body** (application/json)

```json
{
  "id": 0, // required
  "title": "string", // required
  "description": "string",
  "privacy": "public"  // options: public | private | invite_only,
  "status": "upcoming"  // options: upcoming | live | ended,
  "session_link": "string",
  "scheduled_at": "2024-01-01T12:00:00Z",
  "started_at": "2024-01-01T12:00:00Z",
  "ended_at": "2024-01-01T12:00:00Z",
  "host": {
        "id": 0, // required
        "display_name": "string",
        "profile_picture": "https://example.com/file.mp3"
      }, // required
  "participant_count": 0, // required
  "active_participants": "string", // required
  "created_at": "2024-01-01T12:00:00Z" // required
}
```

**Response `200`**

```json
{
  "id": 0, // required
  "title": "string", // required
  "description": "string",
  "privacy": "public"  // options: public | private | invite_only,
  "status": "upcoming"  // options: upcoming | live | ended,
  "session_link": "string",
  "scheduled_at": "2024-01-01T12:00:00Z",
  "started_at": "2024-01-01T12:00:00Z",
  "ended_at": "2024-01-01T12:00:00Z",
  "host": {
        "id": 0, // required
        "display_name": "string",
        "profile_picture": "https://example.com/file.mp3"
      }, // required
  "participant_count": 0, // required
  "active_participants": "string", // required
  "created_at": "2024-01-01T12:00:00Z" // required
}
```

---

## Marketplace

### `GET` /api/v1/marketplace/assets/
**Browse marketplace assets**

**Query Parameters**

| Parameter | Type | Required | Description |
|---|---|---|---|
| `asset_type` | string | — |  |
| `genre` | string | — |  |
| `license_type` | string | — |  |
| `page` | integer | — | A page number within the paginated result set. |
| `page_size` | integer | — | Number of results to return per page. |
| `search` | string | — | Search by title or genre |
| `sort` | string | — |  |

**Response `200`**

```json
{
  "count": 0, // required
  "next": "https://example.com/file.mp3",
  "previous": "https://example.com/file.mp3",
  "results": [
    {
          "id": 0, // required
          "seller_name": "string", // required
          "title": "string", // required
          "asset_type": "beat_track"  // options: beat_track | lyrics | sample_pack | visual_asset, // required
          "asset_type_display": "string", // required
          "genre": "string",
          "price": "string", // required
          "license_type": "non_exclusive"  // options: non_exclusive | exclusive,
          "license_type_display": "string", // required
          "tags": {},
          "bpm": 0,
          "key": "string",
          "cover_image": "https://example.com/file.mp3",
          "preview_file": "https://example.com/file.mp3",
          "play_count": 0,
          "sales_count": 0,
          "is_sold": true,
          "created_at": "2024-01-01T12:00:00Z" // required
        }
    ] // required
}
```

---

### `POST` /api/v1/marketplace/assets/
**Upload an asset for sale**

**Request Body** (application/json)

```json
{
  "title": "string", // required
  "description": "string", // required
  "asset_type": "beat_track"  // options: beat_track | lyrics | sample_pack | visual_asset, // required
  "genre": "string",
  "price": "string", // required
  "license_type": "non_exclusive"  // options: non_exclusive | exclusive,
  "tags": {},
  "bpm": 0,
  "key": "string",
  "asset_file": "https://example.com/file.mp3", // required
  "preview_file": "https://example.com/file.mp3",
  "cover_image": "https://example.com/file.mp3"
}
```

**Response `201`**

```json
{
  "title": "string", // required
  "description": "string", // required
  "asset_type": "beat_track"  // options: beat_track | lyrics | sample_pack | visual_asset, // required
  "genre": "string",
  "price": "string", // required
  "license_type": "non_exclusive"  // options: non_exclusive | exclusive,
  "tags": {},
  "bpm": 0,
  "key": "string",
  "asset_file": "https://example.com/file.mp3", // required
  "preview_file": "https://example.com/file.mp3",
  "cover_image": "https://example.com/file.mp3"
}
```

---

### `GET` /api/v1/marketplace/assets/my-assets/
**List my uploaded assets**

**Response `200`**

```json
{
  "id": 0, // required
  "title": "string", // required
  "asset_type": "beat_track"  // options: beat_track | lyrics | sample_pack | visual_asset, // required
  "asset_type_display": "string", // required
  "genre": "string",
  "price": "string", // required
  "license_type": "non_exclusive"  // options: non_exclusive | exclusive,
  "license_type_display": "string", // required
  "tags": {},
  "bpm": 0,
  "key": "string",
  "cover_image": "https://example.com/file.mp3",
  "preview_file": "https://example.com/file.mp3",
  "asset_file": "https://example.com/file.mp3", // required
  "play_count": 0,
  "sales_count": 0,
  "earnings": "string", // required
  "is_sold": true,
  "is_active": true,
  "created_at": "2024-01-01T12:00:00Z", // required
  "updated_at": "2024-01-01T12:00:00Z" // required
}
```

---

### `GET` /api/v1/marketplace/assets/{id}/
**Get asset details**

**Path Parameters**

| Parameter | Type | Description |
|---|---|---|
| `id` | integer | A unique integer value identifying this marketplace asset. |

**Response `200`**

```json
{
  "id": 0, // required
  "seller_id": 0, // required
  "seller_name": "string", // required
  "title": "string", // required
  "description": "string", // required
  "asset_type": "beat_track"  // options: beat_track | lyrics | sample_pack | visual_asset, // required
  "asset_type_display": "string", // required
  "genre": "string",
  "price": "string", // required
  "license_type": "non_exclusive"  // options: non_exclusive | exclusive,
  "license_type_display": "string", // required
  "tags": {},
  "bpm": 0,
  "key": "string",
  "cover_image": "https://example.com/file.mp3",
  "preview_file": "https://example.com/file.mp3",
  "asset_file": "https://example.com/file.mp3", // required
  "play_count": 0,
  "sales_count": 0,
  "is_sold": true,
  "is_active": true,
  "created_at": "2024-01-01T12:00:00Z", // required
  "updated_at": "2024-01-01T12:00:00Z" // required
}
```

---

### `PUT` /api/v1/marketplace/assets/{id}/
**Update asset (owner only)**

**Path Parameters**

| Parameter | Type | Description |
|---|---|---|
| `id` | string |  |

**Request Body** (application/json)

```json
{
  "title": "string", // required
  "description": "string", // required
  "asset_type": "beat_track"  // options: beat_track | lyrics | sample_pack | visual_asset, // required
  "genre": "string",
  "price": "string", // required
  "license_type": "non_exclusive"  // options: non_exclusive | exclusive,
  "tags": {},
  "bpm": 0,
  "key": "string",
  "asset_file": "https://example.com/file.mp3", // required
  "preview_file": "https://example.com/file.mp3",
  "cover_image": "https://example.com/file.mp3"
}
```

**Response `200`**

```json
{
  "title": "string", // required
  "description": "string", // required
  "asset_type": "beat_track"  // options: beat_track | lyrics | sample_pack | visual_asset, // required
  "genre": "string",
  "price": "string", // required
  "license_type": "non_exclusive"  // options: non_exclusive | exclusive,
  "tags": {},
  "bpm": 0,
  "key": "string",
  "asset_file": "https://example.com/file.mp3", // required
  "preview_file": "https://example.com/file.mp3",
  "cover_image": "https://example.com/file.mp3"
}
```

---

### `PATCH` /api/v1/marketplace/assets/{id}/
**Partially update asset (owner only)**

**Path Parameters**

| Parameter | Type | Description |
|---|---|---|
| `id` | string |  |

**Request Body** (application/json)

```json
{
  "title": "string",
  "description": "string",
  "asset_type": "beat_track"  // options: beat_track | lyrics | sample_pack | visual_asset,
  "genre": "string",
  "price": "string",
  "license_type": "non_exclusive"  // options: non_exclusive | exclusive,
  "tags": {},
  "bpm": 0,
  "key": "string",
  "asset_file": "https://example.com/file.mp3",
  "preview_file": "https://example.com/file.mp3",
  "cover_image": "https://example.com/file.mp3"
}
```

**Response `200`**

```json
{
  "title": "string", // required
  "description": "string", // required
  "asset_type": "beat_track"  // options: beat_track | lyrics | sample_pack | visual_asset, // required
  "genre": "string",
  "price": "string", // required
  "license_type": "non_exclusive"  // options: non_exclusive | exclusive,
  "tags": {},
  "bpm": 0,
  "key": "string",
  "asset_file": "https://example.com/file.mp3", // required
  "preview_file": "https://example.com/file.mp3",
  "cover_image": "https://example.com/file.mp3"
}
```

---

### `DELETE` /api/v1/marketplace/assets/{id}/
**Delete asset (owner only)**

**Path Parameters**

| Parameter | Type | Description |
|---|---|---|
| `id` | string |  |

**Response:** `204` No content

---

### `POST` /api/v1/marketplace/assets/{id}/play/
**Increment play count**

**Path Parameters**

| Parameter | Type | Description |
|---|---|---|
| `id` | integer | A unique integer value identifying this marketplace asset. |

**Request Body** (application/json)

```json
{
  "id": 0, // required
  "seller_name": "string", // required
  "title": "string", // required
  "asset_type": "beat_track"  // options: beat_track | lyrics | sample_pack | visual_asset, // required
  "asset_type_display": "string", // required
  "genre": "string",
  "price": "string", // required
  "license_type": "non_exclusive"  // options: non_exclusive | exclusive,
  "license_type_display": "string", // required
  "tags": {},
  "bpm": 0,
  "key": "string",
  "cover_image": "https://example.com/file.mp3",
  "preview_file": "https://example.com/file.mp3",
  "play_count": 0,
  "sales_count": 0,
  "is_sold": true,
  "created_at": "2024-01-01T12:00:00Z" // required
}
```

**Response `200`**

```json
{
  "id": 0, // required
  "seller_name": "string", // required
  "title": "string", // required
  "asset_type": "beat_track"  // options: beat_track | lyrics | sample_pack | visual_asset, // required
  "asset_type_display": "string", // required
  "genre": "string",
  "price": "string", // required
  "license_type": "non_exclusive"  // options: non_exclusive | exclusive,
  "license_type_display": "string", // required
  "tags": {},
  "bpm": 0,
  "key": "string",
  "cover_image": "https://example.com/file.mp3",
  "preview_file": "https://example.com/file.mp3",
  "play_count": 0,
  "sales_count": 0,
  "is_sold": true,
  "created_at": "2024-01-01T12:00:00Z" // required
}
```

---

### `POST` /api/v1/marketplace/checkout/
**Create Stripe checkout session for an asset**

**Request Body** (application/json)

```json
{
  "asset_id": 0, // required
  "success_url": "string", // required
  "cancel_url": "string" // required
}
```

**Response:** `200` No content

---

### `GET` /api/v1/marketplace/earnings/
**Seller earnings summary**

**Response:** `200` No content

---

### `GET` /api/v1/marketplace/licenses/purchased/
**List my purchased licenses**

**Response:** `200` No content

---

### `GET` /api/v1/marketplace/payouts/
**List my payout requests**

**Query Parameters**

| Parameter | Type | Required | Description |
|---|---|---|---|
| `page` | integer | — | A page number within the paginated result set. |
| `page_size` | integer | — | Number of results to return per page. |

**Response `200`**

```json
{
  "count": 0, // required
  "next": "https://example.com/file.mp3",
  "previous": "https://example.com/file.mp3",
  "results": [
    {
          "id": 0, // required
          "amount": "string", // required
          "status": {}, // required
          "status_display": "string", // required
          "seller_note": "string",
          "admin_note": "string", // required
          "processed_at": "2024-01-01T12:00:00Z", // required
          "created_at": "2024-01-01T12:00:00Z" // required
        }
    ] // required
}
```

---

### `POST` /api/v1/marketplace/payouts/
**Request a payout**

**Request Body** (application/json)

```json
{
  "id": 0, // required
  "amount": "string", // required
  "status": {}, // required
  "status_display": "string", // required
  "seller_note": "string",
  "admin_note": "string", // required
  "processed_at": "2024-01-01T12:00:00Z", // required
  "created_at": "2024-01-01T12:00:00Z" // required
}
```

**Response `201`**

```json
{
  "id": 0, // required
  "amount": "string", // required
  "status": {}, // required
  "status_display": "string", // required
  "seller_note": "string",
  "admin_note": "string", // required
  "processed_at": "2024-01-01T12:00:00Z", // required
  "created_at": "2024-01-01T12:00:00Z" // required
}
```

---

## Payments

### `GET` /api/v1/payments/methods/
**List saved payment methods**

**Response `200`**

```json
[
{
    "id": 0, // required
    "card_type": "visa"  // options: visa | mastercard | amex | discover | other,
    "card_type_display": "string", // required
    "last_four": "string", // required
    "cardholder_name": "string", // required
    "expiry": "string", // required
    "is_default": true,
    "created_at": "2024-01-01T12:00:00Z" // required
  }
]
```

---

### `POST` /api/v1/payments/methods/
**Add a new card**

**Request Body** (application/json)

```json
{
  "card_number": "string", // required
  "cardholder_name": "string", // required
  "expiry_date": "string", // required
  "cvv": "string" // required
}
```

**Response `201`**

```json
{
  "id": 0, // required
  "card_type": "visa"  // options: visa | mastercard | amex | discover | other,
  "card_type_display": "string", // required
  "last_four": "string", // required
  "cardholder_name": "string", // required
  "expiry": "string", // required
  "is_default": true,
  "created_at": "2024-01-01T12:00:00Z" // required
}
```

---

### `DELETE` /api/v1/payments/methods/{id}/
**Delete a payment method**

**Path Parameters**

| Parameter | Type | Description |
|---|---|---|
| `id` | integer |  |

**Response:** `204` No content

---

### `POST` /api/v1/payments/methods/{id}/set-default/
**Set card as default payment method**

**Path Parameters**

| Parameter | Type | Description |
|---|---|---|
| `id` | integer |  |

**Response `200`**

```json
{
  "id": 0, // required
  "card_type": "visa"  // options: visa | mastercard | amex | discover | other,
  "card_type_display": "string", // required
  "last_four": "string", // required
  "cardholder_name": "string", // required
  "expiry": "string", // required
  "is_default": true,
  "created_at": "2024-01-01T12:00:00Z" // required
}
```

---

### `GET` /api/v1/payments/payouts/balance/
**Get available payout balance**

**Response `200`**

```json
{
  "available_balance": "string", // required
  "total_earned": "string", // required
  "total_withdrawn": "string", // required
  "minimum_payout": "string", // required
  "processing_fee_rate": "string" // required
}
```

---

### `GET` /api/v1/payments/payouts/history/
**Payout history**

**Query Parameters**

| Parameter | Type | Required | Description |
|---|---|---|---|
| `page` | integer | — | A page number within the paginated result set. |
| `page_size` | integer | — | Number of results to return per page. |

**Response `200`**

```json
{
  "count": 0, // required
  "next": "https://example.com/file.mp3",
  "previous": "https://example.com/file.mp3",
  "results": [
    {
          "id": 0, // required
          "amount": "string", // required
          "status": {}, // required
          "status_display": "string", // required
          "seller_note": "string",
          "admin_note": "string", // required
          "processed_at": "2024-01-01T12:00:00Z", // required
          "created_at": "2024-01-01T12:00:00Z" // required
        }
    ] // required
}
```

---

### `POST` /api/v1/payments/payouts/request/
**Request a payout**

**Request Body** (application/json)

```json
{
  "amount": "string", // required
  "withdrawal_reason": "string",
  "payout_method": {},
  "account_details": "string"
}
```

**Response `201`**

```json
{
  "id": 0, // required
  "amount": "string", // required
  "status": {}, // required
  "status_display": "string", // required
  "seller_note": "string",
  "admin_note": "string", // required
  "processed_at": "2024-01-01T12:00:00Z", // required
  "created_at": "2024-01-01T12:00:00Z" // required
}
```

---

### `GET` /api/v1/payments/refunds/history/
**My refund requests**

**Query Parameters**

| Parameter | Type | Required | Description |
|---|---|---|---|
| `page` | integer | — | A page number within the paginated result set. |
| `page_size` | integer | — | Number of results to return per page. |

**Response `200`**

```json
{
  "count": 0, // required
  "next": "https://example.com/file.mp3",
  "previous": "https://example.com/file.mp3",
  "results": [
    {
          "id": 0, // required
          "refund_id": "string",
          "transaction_id": "string", // required
          "refund_amount": "string", // required
          "original_amount": "string", // required
          "product_description": "string",
          "reason": "service_not_as_described"  // options: service_not_as_described | accidental_purchase | partial_refund_request | duplicate_charge | other, // required
          "reason_display": "string", // required
          "description": "string",
          "status": "pending"  // options: pending | approved | rejected,
          "status_display": "string", // required
          "requested_at": "2024-01-01T12:00:00Z", // required
          "processed_at": "2024-01-01T12:00:00Z"
        }
    ] // required
}
```

---

### `POST` /api/v1/payments/refunds/request/
**Submit a refund request**

**Request Body** (application/json)

```json
{
  "transaction_id": "string",
  "refund_amount": "string", // required
  "product_description": "string",
  "reason": "service_not_as_described"  // options: service_not_as_described | accidental_purchase | partial_refund_request | duplicate_charge | other, // required
  "description": "string"
}
```

**Response `201`**

```json
{
  "id": 0, // required
  "refund_id": "string",
  "transaction_id": "string", // required
  "refund_amount": "string", // required
  "original_amount": "string", // required
  "product_description": "string",
  "reason": "service_not_as_described"  // options: service_not_as_described | accidental_purchase | partial_refund_request | duplicate_charge | other, // required
  "reason_display": "string", // required
  "description": "string",
  "status": "pending"  // options: pending | approved | rejected,
  "status_display": "string", // required
  "requested_at": "2024-01-01T12:00:00Z", // required
  "processed_at": "2024-01-01T12:00:00Z"
}
```

---

## Subscriptions

### `GET` /api/v1/subscriptions/billing-history/
**Get my billing history**

**Response:** `200` No content

---

### `POST` /api/v1/subscriptions/cancel/
**Cancel my subscription**

**Response:** `200` No content

---

### `POST` /api/v1/subscriptions/change-plan/
**Change (upgrade/downgrade) plan**

**Request Body** (application/json)

```json
{
  "plan_id": 0 // required
}
```

**Response:** `200` No content

---

### `POST` /api/v1/subscriptions/checkout/
**Create Stripe Checkout session for a plan**

**Request Body** (application/json)

```json
{
  "plan_id": 0, // required
  "coupon_code": "string",
  "payment_method_id": "string"
}
```

**Response:** `200` No content

---

### `POST` /api/v1/subscriptions/coupon/validate/
**Validate a coupon code against a plan**

**Request Body** (application/json)

```json
{
  "code": "string", // required
  "plan_id": 0 // required
}
```

**Response:** `200` No content

---

### `GET` /api/v1/subscriptions/me/
**Get my active subscription**

**Response:** `200` No content

---

### `GET` /api/v1/subscriptions/plans/
**List active subscription plans**

**Query Parameters**

| Parameter | Type | Required | Description |
|---|---|---|---|
| `page` | integer | — | A page number within the paginated result set. |

**Response `200`**

```json
{
  "count": 0, // required
  "next": "https://example.com/file.mp3",
  "previous": "https://example.com/file.mp3",
  "results": [
    {
          "id": 0, // required
          "name": "string", // required
          "slug": "string", // required
          "description": "string",
          "price": "string",
          "billing_cycle": "monthly"  // options: monthly | yearly,
          "is_active": true,
          "is_most_popular": true,
          "stripe_price_id": "string",
          "plan_features": [
            {
                      "id": "...", // required
                      "feature": "...", // required
                      "value": "...",
                      "display_value": "..." // required
                    }
            ], // required
          "subscriber_count": "string", // required
          "created_at": "2024-01-01T12:00:00Z" // required
        }
    ] // required
}
```

---

### `GET` /api/v1/subscriptions/plans/{id}/
**Get plan detail**

**Path Parameters**

| Parameter | Type | Description |
|---|---|---|
| `id` | integer |  |

**Response `200`**

```json
{
  "id": 0, // required
  "name": "string", // required
  "slug": "string", // required
  "description": "string",
  "price": "string",
  "billing_cycle": "monthly"  // options: monthly | yearly,
  "is_active": true,
  "is_most_popular": true,
  "stripe_price_id": "string",
  "plan_features": [
    {
          "id": 0, // required
          "feature": {
                    "id": 0, // required
                    "key": "string", // required
                    "name": "string", // required
                    "description": "string",
                    "unit": "boolean"  // options: boolean | integer | gb | mb | text,
                    "default_value": "string",
                    "created_at": "2024-01-01T12:00:00Z" // required
                  }, // required
          "value": "string",
          "display_value": "string" // required
        }
    ], // required
  "subscriber_count": "string", // required
  "created_at": "2024-01-01T12:00:00Z" // required
}
```

---

### `POST` /api/v1/subscriptions/subscribe/
**Subscribe to a plan**

**Request Body** (application/json)

```json
{
  "plan_id": 0, // required
  "coupon_code": "string",
  "payment_method_id": "string"
}
```

**Response:** `200` No content

---

## Messaging

### `GET` /api/v1/messaging/conversations/
**List my conversations**

**Query Parameters**

| Parameter | Type | Required | Description |
|---|---|---|---|
| `page` | integer | — | A page number within the paginated result set. |

**Response `200`**

```json
{
  "count": 0, // required
  "next": "https://example.com/file.mp3",
  "previous": "https://example.com/file.mp3",
  "results": [
    {
          "id": 0, // required
          "participants": "string", // required
          "last_message": "string", // required
          "unread_count": "string", // required
          "created_at": "2024-01-01T12:00:00Z", // required
          "updated_at": "2024-01-01T12:00:00Z" // required
        }
    ] // required
}
```

---

### `POST` /api/v1/messaging/conversations/
**Get or create a 1:1 conversation with another user**

**Request Body** (application/json)

```json
{
  "id": 0, // required
  "participants": "string", // required
  "last_message": "string", // required
  "unread_count": "string", // required
  "created_at": "2024-01-01T12:00:00Z", // required
  "updated_at": "2024-01-01T12:00:00Z" // required
}
```

**Response `201`**

```json
{
  "id": 0, // required
  "participants": "string", // required
  "last_message": "string", // required
  "unread_count": "string", // required
  "created_at": "2024-01-01T12:00:00Z", // required
  "updated_at": "2024-01-01T12:00:00Z" // required
}
```

---

### `GET` /api/v1/messaging/conversations/{id}/
**Retrieve a conversation**

**Path Parameters**

| Parameter | Type | Description |
|---|---|---|
| `id` | integer |  |

**Response `200`**

```json
{
  "id": 0, // required
  "participants": "string", // required
  "last_message": "string", // required
  "unread_count": "string", // required
  "created_at": "2024-01-01T12:00:00Z", // required
  "updated_at": "2024-01-01T12:00:00Z" // required
}
```

---

### `DELETE` /api/v1/messaging/conversations/{id}/
**Delete a conversation for me**

**Path Parameters**

| Parameter | Type | Description |
|---|---|---|
| `id` | integer |  |

**Response:** `204` No content

---

### `GET` /api/v1/messaging/conversations/{id}/messages/
**List messages in a conversation (paginated, oldest-first)**

**Path Parameters**

| Parameter | Type | Description |
|---|---|---|
| `id` | integer |  |

**Response `200`**

```json
{
  "id": 0, // required
  "participants": "string", // required
  "last_message": "string", // required
  "unread_count": "string", // required
  "created_at": "2024-01-01T12:00:00Z", // required
  "updated_at": "2024-01-01T12:00:00Z" // required
}
```

---

## Notifications

### `GET` /api/v1/notifications/
**List notifications**

**Query Parameters**

| Parameter | Type | Required | Description |
|---|---|---|---|
| `page` | integer | — | A page number within the paginated result set. |
| `unread_only` | boolean | — | Return only unread notifications (default: false) |

**Response `200`**

```json
{
  "count": 0, // required
  "next": "https://example.com/file.mp3",
  "previous": "https://example.com/file.mp3",
  "results": [
    {
          "id": 0, // required
          "notification_type": {}, // required
          "title": "string", // required
          "message": "string", // required
          "actor_name": "string", // required
          "actor_picture": "string", // required
          "target_id": 0, // required
          "target_type": "string", // required
          "is_read": true, // required
          "created_at": "2024-01-01T12:00:00Z" // required
        }
    ] // required
}
```

---

### `PATCH` /api/v1/notifications/read-all/
**Mark all notifications as read**

**Request Body** (application/json)

```json
{
  "id": 0,
  "notification_type": {},
  "title": "string",
  "message": "string",
  "actor_name": "string",
  "actor_picture": "string",
  "target_id": 0,
  "target_type": "string",
  "is_read": true,
  "created_at": "2024-01-01T12:00:00Z"
}
```

**Response `200`**

```json
{
  "marked": 0
}
```

---

### `GET` /api/v1/notifications/unread-count/
**Get unread notification count**

**Response `200`**

```json
{
  "unread_count": 0
}
```

---

### `GET` /api/v1/notifications/{id}/
**Get notification detail**

**Path Parameters**

| Parameter | Type | Description |
|---|---|---|
| `id` | string |  |

**Response `200`**

```json
{
  "id": 0, // required
  "notification_type": {}, // required
  "title": "string", // required
  "message": "string", // required
  "actor_name": "string", // required
  "actor_picture": "string", // required
  "target_id": 0, // required
  "target_type": "string", // required
  "is_read": true, // required
  "created_at": "2024-01-01T12:00:00Z" // required
}
```

---

### `PATCH` /api/v1/notifications/{id}/read/
**Mark a notification as read**

**Path Parameters**

| Parameter | Type | Description |
|---|---|---|
| `id` | string |  |

**Request Body** (application/json)

```json
{
  "id": 0,
  "notification_type": {},
  "title": "string",
  "message": "string",
  "actor_name": "string",
  "actor_picture": "string",
  "target_id": 0,
  "target_type": "string",
  "is_read": true,
  "created_at": "2024-01-01T12:00:00Z"
}
```

**Response `200`**

```json
{
  "id": 0, // required
  "notification_type": {}, // required
  "title": "string", // required
  "message": "string", // required
  "actor_name": "string", // required
  "actor_picture": "string", // required
  "target_id": 0, // required
  "target_type": "string", // required
  "is_read": true, // required
  "created_at": "2024-01-01T12:00:00Z" // required
}
```

---

## Reports

### `GET` /api/v1/reports/my-reports/
**List my submitted reports**

**Query Parameters**

| Parameter | Type | Required | Description |
|---|---|---|---|
| `page` | integer | — | A page number within the paginated result set. |
| `page_size` | integer | — | Number of results to return per page. |

**Response `200`**

```json
{
  "count": 0, // required
  "next": "https://example.com/file.mp3",
  "previous": "https://example.com/file.mp3",
  "results": [
    {
          "id": 0, // required
          "report_id": "string", // required
          "reported_user_name": "string", // required
          "reported_user_email": "string", // required
          "violation_type": "inappropriate_behavior"  // options: inappropriate_behavior | copyright_infringement | spam_scam | harassment | hate_speech | impersonation | other, // required
          "violation_type_display": "string", // required
          "severity": "low"  // options: low | medium | high | critical,
          "severity_display": "string", // required
          "description": "string",
          "evidence": {},
          "evidence_display": "string", // required
          "status": "pending"  // options: pending | under_review | resolved,
          "status_display": "string", // required
          "action_taken": "none"  // options: none | warning | suspended | banned,
          "action_taken_display": "string", // required
          "reported_at": "2024-01-01T12:00:00Z", // required
          "admin_note": "string"
        }
    ] // required
}
```

---

### `POST` /api/v1/reports/submit/
**Submit a report against a user**

**Request Body** (application/json)

```json
{
  "reported_user_id": 0, // required
  "violation_type": "inappropriate_behavior"  // options: inappropriate_behavior | copyright_infringement | spam_scam | harassment | hate_speech | impersonation | other, // required
  "severity": {},
  "description": "string",
  "evidence": [
    "chat_logs"  // options: chat_logs | screenshots | recordings | documents | other
    ]
}
```

**Response `201`**

```json
{
  "id": 0, // required
  "report_id": "string", // required
  "reported_user_name": "string", // required
  "reported_user_email": "string", // required
  "violation_type": "inappropriate_behavior"  // options: inappropriate_behavior | copyright_infringement | spam_scam | harassment | hate_speech | impersonation | other, // required
  "violation_type_display": "string", // required
  "severity": "low"  // options: low | medium | high | critical,
  "severity_display": "string", // required
  "description": "string",
  "evidence": {},
  "evidence_display": "string", // required
  "status": "pending"  // options: pending | under_review | resolved,
  "status_display": "string", // required
  "action_taken": "none"  // options: none | warning | suspended | banned,
  "action_taken_display": "string", // required
  "reported_at": "2024-01-01T12:00:00Z", // required
  "admin_note": "string"
}
```

---

## Support

### `POST` /api/v1/support/
**Submit a new support ticket**

**Request Body** (application/json)

```json
{
  "subject": "string", // required
  "message": "string", // required
  "priority": {},
  "attachment": "https://example.com/file.mp3"
}
```

**Response `201`**

```json
{
  "id": 0, // required
  "ticket_id": "string",
  "user_name": "string", // required
  "user_email": "string", // required
  "subject": "string", // required
  "status": "open"  // options: open | in_progress | resolved,
  "status_display": "string", // required
  "priority": "high"  // options: high | medium | low,
  "priority_display": "string", // required
  "created_at": "2024-01-01T12:00:00Z", // required
  "updated_at": "2024-01-01T12:00:00Z", // required
  "messages": [
    {
          "id": 0, // required
          "is_admin_reply": true,
          "sender_name": "string", // required
          "sender_email": "string", // required
          "message": "string", // required
          "attachment": "https://example.com/file.mp3",
          "created_at": "2024-01-01T12:00:00Z" // required
        }
    ] // required
}
```

---

### `GET` /api/v1/support/my-tickets/
**List my support tickets**

**Query Parameters**

| Parameter | Type | Required | Description |
|---|---|---|---|
| `page` | integer | — | A page number within the paginated result set. |
| `page_size` | integer | — | Number of results to return per page. |

**Response `200`**

```json
{
  "count": 0, // required
  "next": "https://example.com/file.mp3",
  "previous": "https://example.com/file.mp3",
  "results": [
    {
          "id": 0, // required
          "ticket_id": "string",
          "user_name": "string", // required
          "user_email": "string", // required
          "subject": "string", // required
          "status": "open"  // options: open | in_progress | resolved,
          "status_display": "string", // required
          "priority": "high"  // options: high | medium | low,
          "priority_display": "string", // required
          "created_at": "2024-01-01T12:00:00Z", // required
          "updated_at": "2024-01-01T12:00:00Z" // required
        }
    ] // required
}
```

---

### `GET` /api/v1/support/my-tickets/{id}/
**Get my ticket detail**

**Path Parameters**

| Parameter | Type | Description |
|---|---|---|
| `id` | integer |  |

**Response `200`**

```json
{
  "id": 0, // required
  "ticket_id": "string",
  "user_name": "string", // required
  "user_email": "string", // required
  "subject": "string", // required
  "status": "open"  // options: open | in_progress | resolved,
  "status_display": "string", // required
  "priority": "high"  // options: high | medium | low,
  "priority_display": "string", // required
  "created_at": "2024-01-01T12:00:00Z", // required
  "updated_at": "2024-01-01T12:00:00Z", // required
  "messages": [
    {
          "id": 0, // required
          "is_admin_reply": true,
          "sender_name": "string", // required
          "sender_email": "string", // required
          "message": "string", // required
          "attachment": "https://example.com/file.mp3",
          "created_at": "2024-01-01T12:00:00Z" // required
        }
    ] // required
}
```

---

## Admin Hub

### `GET` /api/v1/admin-hub/activity-log/
**List activity log entries**

**Query Parameters**

| Parameter | Type | Required | Description |
|---|---|---|---|
| `page` | integer | — |  |
| `page_size` | integer | — |  |
| `period` | string | — |  |
| `search` | string | — |  |
| `type` | string | — |  |

**Response `200`**

```json
{
  "count": 0, // required
  "next": "https://example.com/file.mp3",
  "previous": "https://example.com/file.mp3",
  "results": [
    {
          "id": 0, // required
          "activity_id": "string",
          "activity_type": "user_action"  // options: user_action | admin_action | system_update, // required
          "activity_type_display": "string", // required
          "action": "string", // required
          "user_id": "string", // required
          "user_name": "string", // required
          "user_email": "string", // required
          "details": "string",
          "ip_address": "string",
          "timestamp": "2024-01-01T12:00:00Z" // required
        }
    ] // required
}
```

---

### `GET` /api/v1/admin-hub/activity-log/export/
**Export activity log as CSV**

**Response:** `200` No content

---

### `GET` /api/v1/admin-hub/activity-log/stats/
**Activity log stats**

**Response `200`**

```json
{
  "total": 0, // required
  "user_actions": 0, // required
  "admin_actions": 0, // required
  "system_updates": 0, // required
  "period": "string" // required
}
```

---

### `GET` /api/v1/admin-hub/activity-log/{id}/
**Get single activity log entry**

**Path Parameters**

| Parameter | Type | Description |
|---|---|---|
| `id` | integer |  |

**Response `200`**

```json
{
  "id": 0, // required
  "activity_id": "string",
  "activity_type": "user_action"  // options: user_action | admin_action | system_update, // required
  "activity_type_display": "string", // required
  "action": "string", // required
  "user_id": "string", // required
  "user_name": "string", // required
  "user_email": "string", // required
  "details": "string",
  "ip_address": "string",
  "timestamp": "2024-01-01T12:00:00Z" // required
}
```

---

### `GET` /api/v1/admin-hub/analytics/
**Analytics dashboard summary**

**Query Parameters**

| Parameter | Type | Required | Description |
|---|---|---|---|
| `period` | string | — |  |

**Response `200`**

```json
{
  "active_collaborations": 0, // required
  "active_collaborations_change": "string", // required
  "brief_conversion_rate": 0.0, // required
  "brief_conversion_change": "string", // required
  "avg_license_value": 0.0, // required
  "avg_license_note": "string", // required
  "platform_uptime": 0.0, // required
  "platform_uptime_label": "string", // required
  "period": "string" // required
}
```

---

### `GET` /api/v1/admin-hub/analytics/export/
**Export analytics report as CSV**

**Response:** `200` No content

---

### `GET` /api/v1/admin-hub/analytics/retention-rate/
**Retention rate (monthly, proxy)**

**Query Parameters**

| Parameter | Type | Required | Description |
|---|---|---|---|
| `page` | integer | — | A page number within the paginated result set. |

**Response `200`**

```json
{
  "count": 0, // required
  "next": "https://example.com/file.mp3",
  "previous": "https://example.com/file.mp3",
  "results": [
    {
          "month": "string", // required
          "rate": 0.0 // required
        }
    ] // required
}
```

---

### `GET` /api/v1/admin-hub/analytics/revenue-by-tier/
**Revenue by subscription tier**

**Query Parameters**

| Parameter | Type | Required | Description |
|---|---|---|---|
| `page` | integer | — | A page number within the paginated result set. |

**Response `200`**

```json
{
  "count": 0, // required
  "next": "https://example.com/file.mp3",
  "previous": "https://example.com/file.mp3",
  "results": [
    {
          "tier": "string", // required
          "revenue": 0.0 // required
        }
    ] // required
}
```

---

### `GET` /api/v1/admin-hub/analytics/top-creators/
**Top earning creators**

**Query Parameters**

| Parameter | Type | Required | Description |
|---|---|---|---|
| `page` | integer | — | A page number within the paginated result set. |

**Response `200`**

```json
{
  "count": 0, // required
  "next": "https://example.com/file.mp3",
  "previous": "https://example.com/file.mp3",
  "results": [
    {
          "rank": 0, // required
          "creator_id": 0, // required
          "creator_name": "string", // required
          "creator_email": "string", // required
          "total_earnings": 0.0, // required
          "licenses_sold": 0, // required
          "avg_per_license": 0.0 // required
        }
    ] // required
}
```

---

### `GET` /api/v1/admin-hub/analytics/top-genres/
**Top genres by sales**

**Query Parameters**

| Parameter | Type | Required | Description |
|---|---|---|---|
| `page` | integer | — | A page number within the paginated result set. |

**Response `200`**

```json
{
  "count": 0, // required
  "next": "https://example.com/file.mp3",
  "previous": "https://example.com/file.mp3",
  "results": [
    {
          "genre": "string", // required
          "sales": 0, // required
          "revenue": 0.0 // required
        }
    ] // required
}
```

---

### `GET` /api/v1/admin-hub/analytics/user-growth/
**Monthly user growth**

**Query Parameters**

| Parameter | Type | Required | Description |
|---|---|---|---|
| `page` | integer | — | A page number within the paginated result set. |

**Response `200`**

```json
{
  "count": 0, // required
  "next": "https://example.com/file.mp3",
  "previous": "https://example.com/file.mp3",
  "results": [
    {
          "month": "string", // required
          "new_users": 0, // required
          "total_users": 0 // required
        }
    ] // required
}
```

---

### `GET` /api/v1/admin-hub/dashboard/
**Admin dashboard overview**

**Response `200`**

```json
{}
```

---

### `GET` /api/v1/admin-hub/settings/admin-roles/
**List admin roles with user counts and capabilities**

**Query Parameters**

| Parameter | Type | Required | Description |
|---|---|---|---|
| `page` | integer | — | A page number within the paginated result set. |

**Response `200`**

```json
{
  "count": 0, // required
  "next": "https://example.com/file.mp3",
  "previous": "https://example.com/file.mp3",
  "results": [
    {
          "role": "string", // required
          "display_name": "string", // required
          "description": "string", // required
          "capabilities": [
            "string"
            ], // required
          "user_count": 0 // required
        }
    ] // required
}
```

---

### `POST` /api/v1/admin-hub/settings/admin-roles/create-user/
**Create a new admin/moderator/finance user**

**Request Body** (application/json)

```json
{
  "email": "user@example.com", // required
  "password": "string", // required
  "display_name": "string", // required
  "role": "admin"  // options: admin | moderator | finance // required
}
```

**Response `201`**

```json
{
  "id": 0, // required
  "email": "user@example.com", // required
  "display_name": "string", // required
  "role": "string", // required
  "role_display": "string", // required
  "is_active": true, // required
  "created_at": "2024-01-01T12:00:00Z" // required
}
```

---

### `GET` /api/v1/admin-hub/settings/admin-roles/users/
**List admin/moderator/finance users**

**Query Parameters**

| Parameter | Type | Required | Description |
|---|---|---|---|
| `page` | integer | — | A page number within the paginated result set. |
| `role` | string | — | Filter by role |

**Response `200`**

```json
{
  "count": 0, // required
  "next": "https://example.com/file.mp3",
  "previous": "https://example.com/file.mp3",
  "results": [
    {
          "id": 0, // required
          "email": "user@example.com", // required
          "display_name": "string", // required
          "role": "string", // required
          "role_display": "string", // required
          "is_active": true, // required
          "created_at": "2024-01-01T12:00:00Z" // required
        }
    ] // required
}
```

---

### `PATCH` /api/v1/admin-hub/settings/admin-roles/users/{id}/
**Update an admin user's role**

**Path Parameters**

| Parameter | Type | Description |
|---|---|---|
| `id` | integer |  |

**Request Body** (application/json)

```json
{
  "role": "admin"  // options: admin | moderator | finance | user
}
```

**Response `200`**

```json
{
  "id": 0, // required
  "email": "user@example.com", // required
  "display_name": "string", // required
  "role": "string", // required
  "role_display": "string", // required
  "is_active": true, // required
  "created_at": "2024-01-01T12:00:00Z" // required
}
```

---

### `DELETE` /api/v1/admin-hub/settings/admin-roles/users/{id}/remove/
**Remove admin role from user (demote to regular user)**

**Path Parameters**

| Parameter | Type | Description |
|---|---|---|
| `id` | integer |  |

**Response:** `200` No content

---

### `GET` /api/v1/admin-hub/settings/announcements/
**List system announcements**

**Query Parameters**

| Parameter | Type | Required | Description |
|---|---|---|---|
| `page` | integer | — | A page number within the paginated result set. |

**Response `200`**

```json
{
  "count": 0, // required
  "next": "https://example.com/file.mp3",
  "previous": "https://example.com/file.mp3",
  "results": [
    {
          "id": 0, // required
          "title": "string", // required
          "message": "string", // required
          "announcement_type": "info"  // options: info | warning | maintenance | feature,
          "type_display": "string", // required
          "is_published": true,
          "created_by_name": "string", // required
          "created_at": "2024-01-01T12:00:00Z", // required
          "published_at": "2024-01-01T12:00:00Z"
        }
    ] // required
}
```

---

### `POST` /api/v1/admin-hub/settings/announcements/create/
**Create a system announcement**

**Request Body** (application/json)

```json
{
  "title": "string", // required
  "message": "string", // required
  "announcement_type": {}
}
```

**Response `201`**

```json
{
  "id": 0, // required
  "title": "string", // required
  "message": "string", // required
  "announcement_type": "info"  // options: info | warning | maintenance | feature,
  "type_display": "string", // required
  "is_published": true,
  "created_by_name": "string", // required
  "created_at": "2024-01-01T12:00:00Z", // required
  "published_at": "2024-01-01T12:00:00Z"
}
```

---

### `DELETE` /api/v1/admin-hub/settings/announcements/{id}/delete/
**Delete an announcement**

**Path Parameters**

| Parameter | Type | Description |
|---|---|---|
| `id` | integer |  |

**Response:** `204` No content

---

### `POST` /api/v1/admin-hub/settings/announcements/{id}/publish/
**Publish an announcement**

**Path Parameters**

| Parameter | Type | Description |
|---|---|---|
| `id` | integer |  |

**Response `200`**

```json
{
  "id": 0, // required
  "title": "string", // required
  "message": "string", // required
  "announcement_type": "info"  // options: info | warning | maintenance | feature,
  "type_display": "string", // required
  "is_published": true,
  "created_by_name": "string", // required
  "created_at": "2024-01-01T12:00:00Z", // required
  "published_at": "2024-01-01T12:00:00Z"
}
```

---

### `PATCH` /api/v1/admin-hub/settings/announcements/{id}/update/
**Update an announcement**

**Path Parameters**

| Parameter | Type | Description |
|---|---|---|
| `id` | integer |  |

**Request Body** (application/json)

```json
{
  "title": "string",
  "message": "string",
  "announcement_type": {}
}
```

**Response `200`**

```json
{
  "id": 0, // required
  "title": "string", // required
  "message": "string", // required
  "announcement_type": "info"  // options: info | warning | maintenance | feature,
  "type_display": "string", // required
  "is_published": true,
  "created_by_name": "string", // required
  "created_at": "2024-01-01T12:00:00Z", // required
  "published_at": "2024-01-01T12:00:00Z"
}
```

---

### `GET` /api/v1/admin-hub/settings/permissions/
**Get permission matrix for all admin roles**

**Query Parameters**

| Parameter | Type | Required | Description |
|---|---|---|---|
| `page` | integer | — | A page number within the paginated result set. |

**Response `200`**

```json
{
  "count": 0, // required
  "next": "https://example.com/file.mp3",
  "previous": "https://example.com/file.mp3",
  "results": [
    {
          "role": "admin"  // options: admin | moderator | finance, // required
          "role_display": "string", // required
          "user_management": true,
          "content_moderation": true,
          "financial_data": true,
          "brief_management": true,
          "analytics": true,
          "settings": true,
          "updated_at": "2024-01-01T12:00:00Z" // required
        }
    ] // required
}
```

---

### `PUT` /api/v1/admin-hub/settings/permissions/save/
**Save permission matrix (bulk update)**

**Query Parameters**

| Parameter | Type | Required | Description |
|---|---|---|---|
| `page` | integer | — | A page number within the paginated result set. |

**Request Body** (application/json)

```json
{
  "permissions": [
    {
          "role": "admin"  // options: admin | moderator | finance, // required
          "user_management": true,
          "content_moderation": true,
          "financial_data": true,
          "brief_management": true,
          "analytics": true,
          "settings": true
        }
    ] // required
}
```

**Response `200`**

```json
{
  "count": 0, // required
  "next": "https://example.com/file.mp3",
  "previous": "https://example.com/file.mp3",
  "results": [
    {
          "role": "admin"  // options: admin | moderator | finance, // required
          "role_display": "string", // required
          "user_management": true,
          "content_moderation": true,
          "financial_data": true,
          "brief_management": true,
          "analytics": true,
          "settings": true,
          "updated_at": "2024-01-01T12:00:00Z" // required
        }
    ] // required
}
```

---

### `GET` /api/v1/admin-hub/settings/plan-pricing/
**List subscription plans with pricing and features**

**Query Parameters**

| Parameter | Type | Required | Description |
|---|---|---|---|
| `page` | integer | — | A page number within the paginated result set. |

**Response `200`**

```json
{
  "count": 0, // required
  "next": "https://example.com/file.mp3",
  "previous": "https://example.com/file.mp3",
  "results": [
    {
          "id": 0, // required
          "name": "string", // required
          "slug": "string", // required
          "description": "string", // required
          "price": "string", // required
          "billing_cycle": "string", // required
          "is_active": true, // required
          "is_most_popular": true, // required
          "stripe_price_id": "string", // required
          "features": "string" // required
        }
    ] // required
}
```

---

### `PATCH` /api/v1/admin-hub/settings/plan-pricing/{id}/
**Update a subscription plan's pricing / details**

**Path Parameters**

| Parameter | Type | Description |
|---|---|---|
| `id` | integer |  |

**Request Body** (application/json)

```json
{
  "price": "string",
  "description": "string",
  "is_active": true,
  "is_most_popular": true,
  "stripe_price_id": "string"
}
```

**Response `200`**

```json
{
  "id": 0, // required
  "name": "string", // required
  "slug": "string", // required
  "description": "string", // required
  "price": "string", // required
  "billing_cycle": "string", // required
  "is_active": true, // required
  "is_most_popular": true, // required
  "stripe_price_id": "string", // required
  "features": "string" // required
}
```

---

### `GET` /api/v1/admin-hub/storage/
**Platform storage overview (S3)**

**Response `200`**

```json
{
  "storage_type": "string", // required
  "total_used_bytes": 0, // required
  "total_used_tb": 0.0, // required
  "total_quota_bytes": 0, // required
  "total_quota_tb": 0.0, // required
  "users_near_limit": 0, // required
  "users_over_limit": 0, // required
  "total_users_with_storage": 0, // required
  "estimated_monthly_cost_usd": 0.0, // required
  "cost_note": "string" // required
}
```

---

### `GET` /api/v1/admin-hub/storage/growth/
**Monthly storage growth snapshots**

**Query Parameters**

| Parameter | Type | Required | Description |
|---|---|---|---|
| `page` | integer | — | A page number within the paginated result set. |
| `page_size` | integer | — | Number of results to return per page. |

**Response `200`**

```json
{
  "count": 0, // required
  "next": "https://example.com/file.mp3",
  "previous": "https://example.com/file.mp3",
  "results": [
    {
          "month": "string", // required
          "total_bytes": 0, // required
          "total_tb": "string" // required
        }
    ] // required
}
```

---

### `GET` /api/v1/admin-hub/storage/users/
**List user storage usage**

**Query Parameters**

| Parameter | Type | Required | Description |
|---|---|---|---|
| `filter` | string | — | all | near_limit (≥80%) | over_limit |
| `page` | integer | — | A page number within the paginated result set. |
| `page_size` | integer | — | Number of results to return per page. |
| `search` | string | — | Search by email or name |

**Response `200`**

```json
{
  "count": 0, // required
  "next": "https://example.com/file.mp3",
  "previous": "https://example.com/file.mp3",
  "results": [
    {
          "id": 0, // required
          "user_id": 0, // required
          "user_name": "string", // required
          "user_email": "string", // required
          "used_bytes": 0,
          "used_gb": "string", // required
          "limit_bytes": 0,
          "limit_gb": "string", // required
          "usage_percent": "string", // required
          "updated_at": "2024-01-01T12:00:00Z" // required
        }
    ] // required
}
```

---

### `PATCH` /api/v1/admin-hub/storage/users/{id}/increase-limit/
**Increase a user's storage quota**

**Path Parameters**

| Parameter | Type | Description |
|---|---|---|
| `id` | integer |  |

**Request Body** (application/json)

```json
{
  "new_limit_gb": 0.0
}
```

**Response `200`**

```json
{}
```

---

### `GET` /api/v1/admin-hub/support/
**List all support tickets**

**Query Parameters**

| Parameter | Type | Required | Description |
|---|---|---|---|
| `page` | integer | — | A page number within the paginated result set. |
| `page_size` | integer | — | Number of results to return per page. |
| `priority` | string | — |  |
| `search` | string | — |  |
| `status` | string | — |  |

**Response `200`**

```json
{
  "count": 0, // required
  "next": "https://example.com/file.mp3",
  "previous": "https://example.com/file.mp3",
  "results": [
    {
          "id": 0, // required
          "ticket_id": "string",
          "user_name": "string", // required
          "user_email": "string", // required
          "subject": "string", // required
          "status": "open"  // options: open | in_progress | resolved,
          "status_display": "string", // required
          "priority": "high"  // options: high | medium | low,
          "priority_display": "string", // required
          "created_at": "2024-01-01T12:00:00Z", // required
          "updated_at": "2024-01-01T12:00:00Z" // required
        }
    ] // required
}
```

---

### `GET` /api/v1/admin-hub/support/{id}/
**Get ticket detail with messages**

**Path Parameters**

| Parameter | Type | Description |
|---|---|---|
| `id` | integer |  |

**Response `200`**

```json
{
  "id": 0, // required
  "ticket_id": "string",
  "user_name": "string", // required
  "user_email": "string", // required
  "subject": "string", // required
  "status": "open"  // options: open | in_progress | resolved,
  "status_display": "string", // required
  "priority": "high"  // options: high | medium | low,
  "priority_display": "string", // required
  "created_at": "2024-01-01T12:00:00Z", // required
  "updated_at": "2024-01-01T12:00:00Z", // required
  "messages": [
    {
          "id": 0, // required
          "is_admin_reply": true,
          "sender_name": "string", // required
          "sender_email": "string", // required
          "message": "string", // required
          "attachment": "https://example.com/file.mp3",
          "created_at": "2024-01-01T12:00:00Z" // required
        }
    ] // required
}
```

---

### `POST` /api/v1/admin-hub/support/{id}/reply/
**Admin reply to a ticket**

**Path Parameters**

| Parameter | Type | Description |
|---|---|---|
| `id` | integer |  |

**Request Body** (application/json)

```json
{
  "message": "string", // required
  "attachment": "https://example.com/file.mp3"
}
```

**Response `201`**

```json
{
  "id": 0, // required
  "is_admin_reply": true,
  "sender_name": "string", // required
  "sender_email": "string", // required
  "message": "string", // required
  "attachment": "https://example.com/file.mp3",
  "created_at": "2024-01-01T12:00:00Z" // required
}
```

---

### `PATCH` /api/v1/admin-hub/support/{id}/status/
**Update ticket status / priority**

**Path Parameters**

| Parameter | Type | Description |
|---|---|---|
| `id` | integer |  |

**Request Body** (application/json)

```json
{
  "status": "open"  // options: open | in_progress | resolved,
  "priority": "high"  // options: high | medium | low
}
```

**Response `200`**

```json
{
  "id": 0, // required
  "ticket_id": "string",
  "user_name": "string", // required
  "user_email": "string", // required
  "subject": "string", // required
  "status": "open"  // options: open | in_progress | resolved,
  "status_display": "string", // required
  "priority": "high"  // options: high | medium | low,
  "priority_display": "string", // required
  "created_at": "2024-01-01T12:00:00Z", // required
  "updated_at": "2024-01-01T12:00:00Z" // required
}
```

---

### `GET` /api/v1/admin-hub/users/
**List users for admin management**

**Query Parameters**

| Parameter | Type | Required | Description |
|---|---|---|---|
| `page` | integer | — |  |
| `page_size` | integer | — |  |
| `plan` | string | — | Filter by plan name (e.g. Ignite, Launch, Excel, Free) |
| `role` | string | — | Filter by role label (e.g. producer, creator) |
| `search` | string | — | Search by name or email |
| `status` | string | — | Filter by account status |

**Response `200`**

```json
{
  "count": 0, // required
  "next": "https://example.com/file.mp3",
  "previous": "https://example.com/file.mp3",
  "results": [
    {
          "id": 0, // required
          "name": "string", // required
          "email": "user@example.com", // required
          "role": "admin"  // options: admin | user | moderator | finance,
          "role_label": "string", // required
          "plan": "string", // required
          "account_status": "string", // required
          "storage": "string", // required
          "last_active": "string", // required
          "is_verified": true,
          "flags": "string" // required
        }
    ] // required
}
```

---

### `GET` /api/v1/admin-hub/users/export/
**Export user list as CSV**

**Query Parameters**

| Parameter | Type | Required | Description |
|---|---|---|---|
| `plan` | string | — |  |
| `role` | string | — |  |
| `search` | string | — |  |
| `status` | string | — |  |

**Response:** `200` No content

---

### `GET` /api/v1/admin-hub/users/{id}/
**Get full user details (header + all tabs)**

**Path Parameters**

| Parameter | Type | Description |
|---|---|---|
| `id` | integer |  |

**Response `200`**

```json
{
  "header": {
        "id": 0, // required
        "name": "string", // required
        "email": "user@example.com", // required
        "profile_picture": "https://example.com/file.mp3",
        "role": "admin"  // options: admin | user | moderator | finance,
        "role_label": "string", // required
        "plan": "string", // required
        "account_status": "string", // required
        "join_date": "2024-01-01T12:00:00Z", // required
        "last_active": "string", // required
        "storage_used": "string", // required
        "flags": "string", // required
        "is_verified": true
      }, // required
  "overview": {
        "location": "string",
        "genres": "string", // required
        "account_status_detail": "string" // required
      }, // required
  "submissions": {
        "total": 0, // required
        "under_review": 0, // required
        "shortlisted": 0, // required
        "selected": 0, // required
        "not_selected": 0, // required
        "items": [
          {}
          ] // required
      }, // required
  "subscription": {
        "plan_name": "string", // required
        "plan_price": 0.0, // required
        "billing_cycle": "string", // required
        "sub_status": "string", // required
        "current_period_start": "string", // required
        "current_period_end": "string", // required
        "storage_used": "string" // required
      }, // required
  "reports": {
        "total": 0, // required
        "pending": 0, // required
        "resolved": 0, // required
        "items": [
          {}
          ] // required
      }, // required
  "activity": {
        "items": [
          {}
          ] // required
      } // required
}
```

---

### `PUT` /api/v1/admin-hub/users/{id}/
**Update a user account (admin)**

**Path Parameters**

| Parameter | Type | Description |
|---|---|---|
| `id` | integer |  |

**Request Body** (application/json)

```json
{
  "first_name": "string",
  "last_name": "string",
  "display_name": "string",
  "email": "user@example.com", // required
  "role": "admin"  // options: admin | user | moderator | finance,
  "is_active": true,
  "is_verified": true,
  "location": "string",
  "bio": "string"
}
```

**Response `200`**

```json
{
  "first_name": "string",
  "last_name": "string",
  "display_name": "string",
  "email": "user@example.com", // required
  "role": "admin"  // options: admin | user | moderator | finance,
  "is_active": true,
  "is_verified": true,
  "location": "string",
  "bio": "string"
}
```

---

### `PATCH` /api/v1/admin-hub/users/{id}/
**Partially update a user account (admin)**

**Path Parameters**

| Parameter | Type | Description |
|---|---|---|
| `id` | integer |  |

**Request Body** (application/json)

```json
{
  "first_name": "string",
  "last_name": "string",
  "display_name": "string",
  "email": "user@example.com",
  "role": "admin"  // options: admin | user | moderator | finance,
  "is_active": true,
  "is_verified": true,
  "location": "string",
  "bio": "string"
}
```

**Response `200`**

```json
{
  "first_name": "string",
  "last_name": "string",
  "display_name": "string",
  "email": "user@example.com", // required
  "role": "admin"  // options: admin | user | moderator | finance,
  "is_active": true,
  "is_verified": true,
  "location": "string",
  "bio": "string"
}
```

---

### `DELETE` /api/v1/admin-hub/users/{id}/
**Delete a user account (admin)**

**Path Parameters**

| Parameter | Type | Description |
|---|---|---|
| `id` | integer |  |

**Response:** `204` No content

---

### `POST` /api/v1/admin-hub/users/{id}/approve/
**Approve / re-activate a user account**

**Path Parameters**

| Parameter | Type | Description |
|---|---|---|
| `id` | integer |  |

**Request Body** (application/json)

```json
{
  "id": 0, // required
  "name": "string", // required
  "email": "user@example.com", // required
  "role": "admin"  // options: admin | user | moderator | finance,
  "role_label": "string", // required
  "plan": "string", // required
  "account_status": "string", // required
  "storage": "string", // required
  "last_active": "string", // required
  "is_verified": true,
  "flags": "string" // required
}
```

**Response `200`**

```json
{
  "id": 0, // required
  "name": "string", // required
  "email": "user@example.com", // required
  "role": "admin"  // options: admin | user | moderator | finance,
  "role_label": "string", // required
  "plan": "string", // required
  "account_status": "string", // required
  "storage": "string", // required
  "last_active": "string", // required
  "is_verified": true,
  "flags": "string" // required
}
```

---

### `POST` /api/v1/admin-hub/users/{id}/ban/
**Ban a user (deactivates + marks unverified)**

**Path Parameters**

| Parameter | Type | Description |
|---|---|---|
| `id` | integer |  |

**Request Body** (application/json)

```json
{
  "id": 0, // required
  "name": "string", // required
  "email": "user@example.com", // required
  "role": "admin"  // options: admin | user | moderator | finance,
  "role_label": "string", // required
  "plan": "string", // required
  "account_status": "string", // required
  "storage": "string", // required
  "last_active": "string", // required
  "is_verified": true,
  "flags": "string" // required
}
```

**Response `200`**

```json
{
  "id": 0, // required
  "name": "string", // required
  "email": "user@example.com", // required
  "role": "admin"  // options: admin | user | moderator | finance,
  "role_label": "string", // required
  "plan": "string", // required
  "account_status": "string", // required
  "storage": "string", // required
  "last_active": "string", // required
  "is_verified": true,
  "flags": "string" // required
}
```

---

### `POST` /api/v1/admin-hub/users/{id}/suspend/
**Suspend a user account (sets is_active=False)**

**Path Parameters**

| Parameter | Type | Description |
|---|---|---|
| `id` | integer |  |

**Request Body** (application/json)

```json
{
  "id": 0, // required
  "name": "string", // required
  "email": "user@example.com", // required
  "role": "admin"  // options: admin | user | moderator | finance,
  "role_label": "string", // required
  "plan": "string", // required
  "account_status": "string", // required
  "storage": "string", // required
  "last_active": "string", // required
  "is_verified": true,
  "flags": "string" // required
}
```

**Response `200`**

```json
{
  "id": 0, // required
  "name": "string", // required
  "email": "user@example.com", // required
  "role": "admin"  // options: admin | user | moderator | finance,
  "role_label": "string", // required
  "plan": "string", // required
  "account_status": "string", // required
  "storage": "string", // required
  "last_active": "string", // required
  "is_verified": true,
  "flags": "string" // required
}
```

---

### `GET` /api/v1/briefs/admin/
**List all briefs**

**Query Parameters**

| Parameter | Type | Required | Description |
|---|---|---|---|
| `page` | integer | — | A page number within the paginated result set. |
| `page_size` | integer | — | Number of results to return per page. |
| `search` | string | — | Search by title or company |
| `status` | string | — |  |

**Response `200`**

```json
{
  "count": 0, // required
  "next": "https://example.com/file.mp3",
  "previous": "https://example.com/file.mp3",
  "results": [
    {
          "id": 0, // required
          "title": "string", // required
          "company": "string", // required
          "company_type": "major_label"  // options: major_label | independent_label | production_company | talent_agency | artist_management | independent_artist, // required
          "category": "find"  // options: find | revenue_share | collaboration | exposure, // required
          "status": "draft"  // options: draft | pending | active | closed,
          "created_by": {
                    "id": 0, // required
                    "display_name": "string",
                    "profile_picture": "https://example.com/file.mp3",
                    "is_verified": true
                  }, // required
          "submissions_count": "string", // required
          "submission_deadline": "string", // required
          "created_at": "2024-01-01T12:00:00Z" // required
        }
    ] // required
}
```

---

### `GET` /api/v1/briefs/admin/submissions/
**List all submissions (for approved briefs)**

**Query Parameters**

| Parameter | Type | Required | Description |
|---|---|---|---|
| `admin_status` | string | — |  |
| `brief` | string | — | Filter by brief ID |
| `page` | integer | — | A page number within the paginated result set. |
| `page_size` | integer | — | Number of results to return per page. |

**Response `200`**

```json
{
  "count": 0, // required
  "next": "https://example.com/file.mp3",
  "previous": "https://example.com/file.mp3",
  "results": [
    {
          "id": 0, // required
          "submission_id": "string", // required
          "brief_id": 0, // required
          "brief_title": "string", // required
          "applicant": {
                    "id": 0, // required
                    "display_name": "string",
                    "email": "user@example.com", // required
                    "profile_picture": "https://example.com/file.mp3"
                  }, // required
          "work_sample": "https://example.com/file.mp3",
          "cover_letter": "string",
          "admin_status": "pending_review"  // options: pending_review | approved | rejected,
          "status": "under_review"  // options: under_review | shortlisted | selected | not_selected,
          "created_at": "2024-01-01T12:00:00Z" // required
        }
    ] // required
}
```

---

### `GET` /api/v1/briefs/admin/submissions/stats/
**Submission stats**

**Response `200`**

```json
{
  "id": 0, // required
  "submission_id": "string", // required
  "brief_id": 0, // required
  "brief_title": "string", // required
  "applicant": {
        "id": 0, // required
        "display_name": "string",
        "email": "user@example.com", // required
        "profile_picture": "https://example.com/file.mp3"
      }, // required
  "work_sample": "https://example.com/file.mp3",
  "cover_letter": "string",
  "admin_status": "pending_review"  // options: pending_review | approved | rejected,
  "status": "under_review"  // options: under_review | shortlisted | selected | not_selected,
  "created_at": "2024-01-01T12:00:00Z" // required
}
```

---

### `GET` /api/v1/briefs/admin/submissions/{id}/
**Submission detail**

**Path Parameters**

| Parameter | Type | Description |
|---|---|---|
| `id` | integer |  |

**Response `200`**

```json
{
  "id": 0, // required
  "submission_id": "string", // required
  "brief_title": "string", // required
  "applicant": {
        "id": 0, // required
        "display_name": "string",
        "email": "user@example.com", // required
        "profile_picture": "https://example.com/file.mp3"
      }, // required
  "work_sample": "https://example.com/file.mp3",
  "cover_letter": "string",
  "portfolio_link": "https://example.com/file.mp3",
  "file_size": "string", // required
  "admin_status": "pending_review"  // options: pending_review | approved | rejected,
  "status": "under_review"  // options: under_review | shortlisted | selected | not_selected,
  "created_at": "2024-01-01T12:00:00Z" // required
}
```

---

### `PATCH` /api/v1/briefs/admin/submissions/{id}/status/
**Approve or reject a submission**

**Path Parameters**

| Parameter | Type | Description |
|---|---|---|
| `id` | integer |  |

**Request Body** (application/json)

```json
{
  "admin_status": "pending_review"  // options: pending_review | approved | rejected
}
```

**Response `200`**

```json
{
  "admin_status": "pending_review"  // options: pending_review | approved | rejected
}
```

---

### `GET` /api/v1/briefs/admin/{id}/
**Brief detail**

**Path Parameters**

| Parameter | Type | Description |
|---|---|---|
| `id` | integer |  |

**Response `200`**

```json
{
  "id": 0, // required
  "title": "string", // required
  "company": "string", // required
  "company_type": "major_label"  // options: major_label | independent_label | production_company | talent_agency | artist_management | independent_artist, // required
  "category": "find"  // options: find | revenue_share | collaboration | exposure, // required
  "status": "draft"  // options: draft | pending | active | closed,
  "created_by": {
        "id": 0, // required
        "display_name": "string",
        "profile_picture": "https://example.com/file.mp3",
        "is_verified": true
      }, // required
  "submissions_count": "string", // required
  "submission_deadline": "string", // required
  "created_at": "2024-01-01T12:00:00Z" // required
}
```

---

### `PATCH` /api/v1/briefs/admin/{id}/status/
**Approve or close a brief**

**Path Parameters**

| Parameter | Type | Description |
|---|---|---|
| `id` | integer |  |

**Request Body** (application/json)

```json
{
  "status": "draft"  // options: draft | pending | active | closed
}
```

**Response `200`**

```json
{
  "status": "draft"  // options: draft | pending | active | closed
}
```

---

### `GET` /api/v1/feed/admin/reports/
**List all post reports**

**Query Parameters**

| Parameter | Type | Required | Description |
|---|---|---|---|
| `page` | integer | — | A page number within the paginated result set. |
| `page_size` | integer | — | Number of results to return per page. |
| `search` | string | — | Search by post title or reporter name |
| `status` | string | — |  |

**Response `200`**

```json
{
  "count": 0, // required
  "next": "https://example.com/file.mp3",
  "previous": "https://example.com/file.mp3",
  "results": [
    {
          "id": 0, // required
          "post": {
                    "id": 0, // required
                    "title": "string",
                    "post_type": "lyrics"  // options: lyrics | audio | video | photo // required
                  }, // required
          "uploaded_by": "string", // required
          "reporter": {
                    "id": 0, // required
                    "display_name": "string",
                    "email": "user@example.com" // required
                  }, // required
          "reason": "inappropriate_content"  // options: inappropriate_content | copyright_violation | spam | hate_speech | misinformation | other, // required
          "ai_risk_score": 0,
          "status": "pending"  // options: pending | approved | removed,
          "created_at": "2024-01-01T12:00:00Z" // required
        }
    ] // required
}
```

---

### `GET` /api/v1/feed/admin/reports/{id}/
**Report detail**

**Path Parameters**

| Parameter | Type | Description |
|---|---|---|
| `id` | integer |  |

**Response `200`**

```json
{
  "id": 0, // required
  "post": {
        "id": 0, // required
        "title": "string",
        "post_type": "lyrics"  // options: lyrics | audio | video | photo // required
      }, // required
  "uploaded_by": "string", // required
  "reporter": {
        "id": 0, // required
        "display_name": "string",
        "email": "user@example.com" // required
      }, // required
  "reason": "inappropriate_content"  // options: inappropriate_content | copyright_violation | spam | hate_speech | misinformation | other, // required
  "notes": "string",
  "ai_risk_score": 0,
  "status": "pending"  // options: pending | approved | removed,
  "reviewed_by": 0,
  "created_at": "2024-01-01T12:00:00Z", // required
  "updated_at": "2024-01-01T12:00:00Z" // required
}
```

---

### `POST` /api/v1/feed/admin/reports/{id}/action/
**Take action on a report: approve, remove, or warn**

**Path Parameters**

| Parameter | Type | Description |
|---|---|---|
| `id` | integer |  |

**Request Body** (application/json)

```json
{
  "action": "approve"  // options: approve | remove | warn // required
}
```

**Response:** `200` No content

---

### `GET` /api/v1/marketplace/admin/payouts/
**List all payout requests**

**Query Parameters**

| Parameter | Type | Required | Description |
|---|---|---|---|
| `page` | integer | — | A page number within the paginated result set. |
| `page_size` | integer | — | Number of results to return per page. |
| `search` | string | — | Search by seller email or name |
| `status` | string | — |  |

**Response `200`**

```json
{
  "count": 0, // required
  "next": "https://example.com/file.mp3",
  "previous": "https://example.com/file.mp3",
  "results": [
    {
          "id": 0, // required
          "seller_email": "user@example.com", // required
          "seller_name": "string", // required
          "amount": "string", // required
          "status": "pending"  // options: pending | approved | rejected,
          "status_display": "string", // required
          "seller_note": "string", // required
          "admin_note": "string",
          "processed_by_email": "string", // required
          "processed_at": "2024-01-01T12:00:00Z", // required
          "created_at": "2024-01-01T12:00:00Z", // required
          "updated_at": "2024-01-01T12:00:00Z" // required
        }
    ] // required
}
```

---

### `GET` /api/v1/marketplace/admin/payouts/{id}/
**Payout request detail**

**Path Parameters**

| Parameter | Type | Description |
|---|---|---|
| `id` | integer | A unique integer value identifying this payout request. |

**Response `200`**

```json
{
  "id": 0, // required
  "seller_email": "user@example.com", // required
  "seller_name": "string", // required
  "amount": "string", // required
  "status": "pending"  // options: pending | approved | rejected,
  "status_display": "string", // required
  "seller_note": "string", // required
  "admin_note": "string",
  "processed_by_email": "string", // required
  "processed_at": "2024-01-01T12:00:00Z", // required
  "created_at": "2024-01-01T12:00:00Z", // required
  "updated_at": "2024-01-01T12:00:00Z" // required
}
```

---

### `PATCH` /api/v1/marketplace/admin/payouts/{id}/process/
**Approve or reject a payout request**

**Path Parameters**

| Parameter | Type | Description |
|---|---|---|
| `id` | integer | A unique integer value identifying this payout request. |

**Request Body** (application/json)

```json
{
  "id": 0,
  "seller_email": "user@example.com",
  "seller_name": "string",
  "amount": "string",
  "status": "pending"  // options: pending | approved | rejected,
  "status_display": "string",
  "seller_note": "string",
  "admin_note": "string",
  "processed_by_email": "string",
  "processed_at": "2024-01-01T12:00:00Z",
  "created_at": "2024-01-01T12:00:00Z",
  "updated_at": "2024-01-01T12:00:00Z"
}
```

**Response `200`**

```json
{
  "id": 0, // required
  "seller_email": "user@example.com", // required
  "seller_name": "string", // required
  "amount": "string", // required
  "status": "pending"  // options: pending | approved | rejected,
  "status_display": "string", // required
  "seller_note": "string", // required
  "admin_note": "string",
  "processed_by_email": "string", // required
  "processed_at": "2024-01-01T12:00:00Z", // required
  "created_at": "2024-01-01T12:00:00Z", // required
  "updated_at": "2024-01-01T12:00:00Z" // required
}
```

---

### `GET` /api/v1/marketplace/admin/transactions/
**List all transactions**

**Query Parameters**

| Parameter | Type | Required | Description |
|---|---|---|---|
| `page` | integer | — | A page number within the paginated result set. |
| `page_size` | integer | — | Number of results to return per page. |
| `search` | string | — |  |
| `status` | string | — |  |
| `transaction_type` | string | — |  |

**Response `200`**

```json
{
  "count": 0, // required
  "next": "https://example.com/file.mp3",
  "previous": "https://example.com/file.mp3",
  "results": [
    {
          "id": 0, // required
          "transaction_id": "string",
          "transaction_type": "license"  // options: license | subscription | collaboration_split,
          "transaction_type_display": "string", // required
          "asset_id": 0, // required
          "asset_title": "string", // required
          "buyer_name": "string", // required
          "seller_name": "string", // required
          "gross_amount": "string", // required
          "platform_fee": "string", // required
          "net_earnings": "string", // required
          "status": "pending"  // options: pending | payment_received | completed | failed | refunded,
          "status_display": "string", // required
          "stripe_payment_intent_id": "string",
          "payment_method_details": "string",
          "created_at": "2024-01-01T12:00:00Z", // required
          "updated_at": "2024-01-01T12:00:00Z" // required
        }
    ] // required
}
```

---

### `GET` /api/v1/marketplace/admin/transactions/{id}/
**Transaction detail**

**Path Parameters**

| Parameter | Type | Description |
|---|---|---|
| `id` | integer | A unique integer value identifying this transaction. |

**Response `200`**

```json
{
  "id": 0, // required
  "transaction_id": "string",
  "transaction_type": "license"  // options: license | subscription | collaboration_split,
  "transaction_type_display": "string", // required
  "asset_id": 0, // required
  "asset_title": "string", // required
  "buyer_name": "string", // required
  "seller_name": "string", // required
  "gross_amount": "string", // required
  "platform_fee": "string", // required
  "net_earnings": "string", // required
  "status": "pending"  // options: pending | payment_received | completed | failed | refunded,
  "status_display": "string", // required
  "stripe_payment_intent_id": "string",
  "payment_method_details": "string",
  "created_at": "2024-01-01T12:00:00Z", // required
  "updated_at": "2024-01-01T12:00:00Z" // required
}
```

---

### `PATCH` /api/v1/marketplace/admin/transactions/{id}/confirm/
**Confirm or refund a transaction (releases/blocks asset access)**

**Path Parameters**

| Parameter | Type | Description |
|---|---|---|
| `id` | integer | A unique integer value identifying this transaction. |

**Request Body** (application/json)

```json
{
  "status": "pending"  // options: pending | payment_received | completed | failed | refunded
}
```

**Response `200`**

```json
{
  "id": 0, // required
  "transaction_id": "string",
  "transaction_type": "license"  // options: license | subscription | collaboration_split,
  "transaction_type_display": "string", // required
  "asset_id": 0, // required
  "asset_title": "string", // required
  "buyer_name": "string", // required
  "seller_name": "string", // required
  "gross_amount": "string", // required
  "platform_fee": "string", // required
  "net_earnings": "string", // required
  "status": "pending"  // options: pending | payment_received | completed | failed | refunded,
  "status_display": "string", // required
  "stripe_payment_intent_id": "string",
  "payment_method_details": "string",
  "created_at": "2024-01-01T12:00:00Z", // required
  "updated_at": "2024-01-01T12:00:00Z" // required
}
```

---

### `GET` /api/v1/payments/admin/payouts/
**List all payout requests**

**Query Parameters**

| Parameter | Type | Required | Description |
|---|---|---|---|
| `page` | integer | — | A page number within the paginated result set. |
| `page_size` | integer | — | Number of results to return per page. |
| `status` | string | — |  |

**Response `200`**

```json
{
  "count": 0, // required
  "next": "https://example.com/file.mp3",
  "previous": "https://example.com/file.mp3",
  "results": [
    {
          "id": 0, // required
          "request_id": "string",
          "user_name": "string", // required
          "user_email": "user@example.com", // required
          "amount": "string", // required
          "fee": "string", // required
          "net_amount": "string", // required
          "payout_method": {},
          "payout_method_display": "string", // required
          "account_details": "string",
          "withdrawal_reason": "string",
          "status": "pending"  // options: pending | approved | completed | rejected,
          "status_display": "string", // required
          "current_balance": "string", // required
          "requested_at": "2024-01-01T12:00:00Z", // required
          "processed_at": "2024-01-01T12:00:00Z"
        }
    ] // required
}
```

---

### `GET` /api/v1/payments/admin/payouts/stats/
**Payout request statistics**

**Response `200`**

```json
{
  "total_requests": 0, // required
  "pending": 0, // required
  "approved": 0, // required
  "completed": 0, // required
  "rejected": 0, // required
  "total_amount_pending": "string", // required
  "processed_this_month": 0 // required
}
```

---

### `GET` /api/v1/payments/admin/payouts/{id}/
**Get payout request detail**

**Path Parameters**

| Parameter | Type | Description |
|---|---|---|
| `id` | integer |  |

**Response `200`**

```json
{
  "id": 0, // required
  "request_id": "string",
  "user_name": "string", // required
  "user_email": "user@example.com", // required
  "amount": "string", // required
  "fee": "string", // required
  "net_amount": "string", // required
  "payout_method": {},
  "payout_method_display": "string", // required
  "account_details": "string",
  "withdrawal_reason": "string",
  "status": "pending"  // options: pending | approved | completed | rejected,
  "status_display": "string", // required
  "current_balance": "string", // required
  "requested_at": "2024-01-01T12:00:00Z", // required
  "processed_at": "2024-01-01T12:00:00Z",
  "admin_note": "string", // required
  "processed_by_email": "string", // required
  "updated_at": "2024-01-01T12:00:00Z" // required
}
```

---

### `POST` /api/v1/payments/admin/payouts/{id}/approve/
**Approve a payout request**

**Path Parameters**

| Parameter | Type | Description |
|---|---|---|
| `id` | integer |  |

**Request Body** (application/json)

```json
{
  "admin_note": "string"
}
```

**Response `200`**

```json
{
  "id": 0, // required
  "request_id": "string",
  "user_name": "string", // required
  "user_email": "user@example.com", // required
  "amount": "string", // required
  "fee": "string", // required
  "net_amount": "string", // required
  "payout_method": {},
  "payout_method_display": "string", // required
  "account_details": "string",
  "withdrawal_reason": "string",
  "status": "pending"  // options: pending | approved | completed | rejected,
  "status_display": "string", // required
  "current_balance": "string", // required
  "requested_at": "2024-01-01T12:00:00Z", // required
  "processed_at": "2024-01-01T12:00:00Z",
  "admin_note": "string", // required
  "processed_by_email": "string", // required
  "updated_at": "2024-01-01T12:00:00Z" // required
}
```

---

### `POST` /api/v1/payments/admin/payouts/{id}/complete/
**Mark payout as completed (payment processed)**

**Path Parameters**

| Parameter | Type | Description |
|---|---|---|
| `id` | integer |  |

**Request Body** (application/json)

```json
{
  "admin_note": "string"
}
```

**Response `200`**

```json
{
  "id": 0, // required
  "request_id": "string",
  "user_name": "string", // required
  "user_email": "user@example.com", // required
  "amount": "string", // required
  "fee": "string", // required
  "net_amount": "string", // required
  "payout_method": {},
  "payout_method_display": "string", // required
  "account_details": "string",
  "withdrawal_reason": "string",
  "status": "pending"  // options: pending | approved | completed | rejected,
  "status_display": "string", // required
  "current_balance": "string", // required
  "requested_at": "2024-01-01T12:00:00Z", // required
  "processed_at": "2024-01-01T12:00:00Z",
  "admin_note": "string", // required
  "processed_by_email": "string", // required
  "updated_at": "2024-01-01T12:00:00Z" // required
}
```

---

### `POST` /api/v1/payments/admin/payouts/{id}/reject/
**Reject a payout request**

**Path Parameters**

| Parameter | Type | Description |
|---|---|---|
| `id` | integer |  |

**Request Body** (application/json)

```json
{
  "admin_note": "string"
}
```

**Response `200`**

```json
{
  "id": 0, // required
  "request_id": "string",
  "user_name": "string", // required
  "user_email": "user@example.com", // required
  "amount": "string", // required
  "fee": "string", // required
  "net_amount": "string", // required
  "payout_method": {},
  "payout_method_display": "string", // required
  "account_details": "string",
  "withdrawal_reason": "string",
  "status": "pending"  // options: pending | approved | completed | rejected,
  "status_display": "string", // required
  "current_balance": "string", // required
  "requested_at": "2024-01-01T12:00:00Z", // required
  "processed_at": "2024-01-01T12:00:00Z",
  "admin_note": "string", // required
  "processed_by_email": "string", // required
  "updated_at": "2024-01-01T12:00:00Z" // required
}
```

---

### `GET` /api/v1/payments/admin/refunds/
**List all refund requests**

**Query Parameters**

| Parameter | Type | Required | Description |
|---|---|---|---|
| `page` | integer | — | A page number within the paginated result set. |
| `page_size` | integer | — | Number of results to return per page. |
| `status` | string | — |  |

**Response `200`**

```json
{
  "count": 0, // required
  "next": "https://example.com/file.mp3",
  "previous": "https://example.com/file.mp3",
  "results": [
    {
          "id": 0, // required
          "refund_id": "string",
          "transaction_id": "string", // required
          "user_name": "string", // required
          "user_email": "user@example.com", // required
          "original_amount": "string", // required
          "refund_amount": "string", // required
          "product_description": "string",
          "reason": "service_not_as_described"  // options: service_not_as_described | accidental_purchase | partial_refund_request | duplicate_charge | other, // required
          "reason_display": "string", // required
          "description": "string",
          "payment_method": "string", // required
          "status": "pending"  // options: pending | approved | rejected,
          "status_display": "string", // required
          "requested_at": "2024-01-01T12:00:00Z", // required
          "processed_at": "2024-01-01T12:00:00Z"
        }
    ] // required
}
```

---

### `GET` /api/v1/payments/admin/refunds/stats/
**Refund management statistics**

**Response `200`**

```json
{
  "total_requests": 0, // required
  "pending_review": 0, // required
  "approved_this_month": 0, // required
  "rejected": 0, // required
  "total_refund_amount": "string" // required
}
```

---

### `GET` /api/v1/payments/admin/refunds/{id}/
**Get refund request detail**

**Path Parameters**

| Parameter | Type | Description |
|---|---|---|
| `id` | integer |  |

**Response `200`**

```json
{
  "id": 0, // required
  "refund_id": "string",
  "transaction_id": "string", // required
  "user_name": "string", // required
  "user_email": "user@example.com", // required
  "original_amount": "string", // required
  "refund_amount": "string", // required
  "product_description": "string",
  "reason": "service_not_as_described"  // options: service_not_as_described | accidental_purchase | partial_refund_request | duplicate_charge | other, // required
  "reason_display": "string", // required
  "description": "string",
  "payment_method": "string", // required
  "status": "pending"  // options: pending | approved | rejected,
  "status_display": "string", // required
  "requested_at": "2024-01-01T12:00:00Z", // required
  "processed_at": "2024-01-01T12:00:00Z",
  "admin_note": "string", // required
  "processed_by_email": "string", // required
  "updated_at": "2024-01-01T12:00:00Z" // required
}
```

---

### `POST` /api/v1/payments/admin/refunds/{id}/approve/
**Approve a refund request**

**Path Parameters**

| Parameter | Type | Description |
|---|---|---|
| `id` | integer |  |

**Request Body** (application/json)

```json
{
  "admin_note": "string"
}
```

**Response `200`**

```json
{
  "id": 0, // required
  "refund_id": "string",
  "transaction_id": "string", // required
  "user_name": "string", // required
  "user_email": "user@example.com", // required
  "original_amount": "string", // required
  "refund_amount": "string", // required
  "product_description": "string",
  "reason": "service_not_as_described"  // options: service_not_as_described | accidental_purchase | partial_refund_request | duplicate_charge | other, // required
  "reason_display": "string", // required
  "description": "string",
  "payment_method": "string", // required
  "status": "pending"  // options: pending | approved | rejected,
  "status_display": "string", // required
  "requested_at": "2024-01-01T12:00:00Z", // required
  "processed_at": "2024-01-01T12:00:00Z",
  "admin_note": "string", // required
  "processed_by_email": "string", // required
  "updated_at": "2024-01-01T12:00:00Z" // required
}
```

---

### `POST` /api/v1/payments/admin/refunds/{id}/reject/
**Reject a refund request**

**Path Parameters**

| Parameter | Type | Description |
|---|---|---|
| `id` | integer |  |

**Request Body** (application/json)

```json
{
  "admin_note": "string"
}
```

**Response `200`**

```json
{
  "id": 0, // required
  "refund_id": "string",
  "transaction_id": "string", // required
  "user_name": "string", // required
  "user_email": "user@example.com", // required
  "original_amount": "string", // required
  "refund_amount": "string", // required
  "product_description": "string",
  "reason": "service_not_as_described"  // options: service_not_as_described | accidental_purchase | partial_refund_request | duplicate_charge | other, // required
  "reason_display": "string", // required
  "description": "string",
  "payment_method": "string", // required
  "status": "pending"  // options: pending | approved | rejected,
  "status_display": "string", // required
  "requested_at": "2024-01-01T12:00:00Z", // required
  "processed_at": "2024-01-01T12:00:00Z",
  "admin_note": "string", // required
  "processed_by_email": "string", // required
  "updated_at": "2024-01-01T12:00:00Z" // required
}
```

---

### `GET` /api/v1/reports/admin/
**List all user reports**

**Query Parameters**

| Parameter | Type | Required | Description |
|---|---|---|---|
| `page` | integer | — | A page number within the paginated result set. |
| `page_size` | integer | — | Number of results to return per page. |
| `severity` | string | — |  |
| `status` | string | — |  |

**Response `200`**

```json
{
  "count": 0, // required
  "next": "https://example.com/file.mp3",
  "previous": "https://example.com/file.mp3",
  "results": [
    {
          "id": 0, // required
          "post": {
                    "id": 0, // required
                    "title": "string",
                    "post_type": "lyrics"  // options: lyrics | audio | video | photo // required
                  }, // required
          "uploaded_by": "string", // required
          "reporter": {
                    "id": 0, // required
                    "display_name": "string",
                    "email": "user@example.com" // required
                  }, // required
          "reason": "inappropriate_content"  // options: inappropriate_content | copyright_violation | spam | hate_speech | misinformation | other, // required
          "ai_risk_score": 0,
          "status": "pending"  // options: pending | approved | removed,
          "created_at": "2024-01-01T12:00:00Z" // required
        }
    ] // required
}
```

---

### `GET` /api/v1/reports/admin/stats/
**User report statistics**

**Response `200`**

```json
{
  "total_reports": 0, // required
  "pending_review": 0, // required
  "under_review": 0, // required
  "resolved": 0 // required
}
```

---

### `GET` /api/v1/reports/admin/{id}/
**Get report detail**

**Path Parameters**

| Parameter | Type | Description |
|---|---|---|
| `id` | integer |  |

**Response `200`**

```json
{
  "id": 0, // required
  "post": {
        "id": 0, // required
        "title": "string",
        "post_type": "lyrics"  // options: lyrics | audio | video | photo // required
      }, // required
  "uploaded_by": "string", // required
  "reporter": {
        "id": 0, // required
        "display_name": "string",
        "email": "user@example.com" // required
      }, // required
  "reason": "inappropriate_content"  // options: inappropriate_content | copyright_violation | spam | hate_speech | misinformation | other, // required
  "notes": "string",
  "ai_risk_score": 0,
  "status": "pending"  // options: pending | approved | removed,
  "reviewed_by": 0,
  "created_at": "2024-01-01T12:00:00Z", // required
  "updated_at": "2024-01-01T12:00:00Z" // required
}
```

---

### `POST` /api/v1/reports/admin/{id}/ban/
**Ban reported user**

**Path Parameters**

| Parameter | Type | Description |
|---|---|---|
| `id` | integer |  |

**Request Body** (application/json)

```json
{
  "action": "approve"  // options: approve | remove | warn // required
}
```

**Response `200`**

```json
{
  "id": 0, // required
  "post": {
        "id": 0, // required
        "title": "string",
        "post_type": "lyrics"  // options: lyrics | audio | video | photo // required
      }, // required
  "uploaded_by": "string", // required
  "reporter": {
        "id": 0, // required
        "display_name": "string",
        "email": "user@example.com" // required
      }, // required
  "reason": "inappropriate_content"  // options: inappropriate_content | copyright_violation | spam | hate_speech | misinformation | other, // required
  "notes": "string",
  "ai_risk_score": 0,
  "status": "pending"  // options: pending | approved | removed,
  "reviewed_by": 0,
  "created_at": "2024-01-01T12:00:00Z", // required
  "updated_at": "2024-01-01T12:00:00Z" // required
}
```

---

### `POST` /api/v1/reports/admin/{id}/resolve/
**Resolve report without action (close)**

**Path Parameters**

| Parameter | Type | Description |
|---|---|---|
| `id` | integer |  |

**Request Body** (application/json)

```json
{
  "action": "approve"  // options: approve | remove | warn // required
}
```

**Response `200`**

```json
{
  "id": 0, // required
  "post": {
        "id": 0, // required
        "title": "string",
        "post_type": "lyrics"  // options: lyrics | audio | video | photo // required
      }, // required
  "uploaded_by": "string", // required
  "reporter": {
        "id": 0, // required
        "display_name": "string",
        "email": "user@example.com" // required
      }, // required
  "reason": "inappropriate_content"  // options: inappropriate_content | copyright_violation | spam | hate_speech | misinformation | other, // required
  "notes": "string",
  "ai_risk_score": 0,
  "status": "pending"  // options: pending | approved | removed,
  "reviewed_by": 0,
  "created_at": "2024-01-01T12:00:00Z", // required
  "updated_at": "2024-01-01T12:00:00Z" // required
}
```

---

### `POST` /api/v1/reports/admin/{id}/review/
**Mark report as under review**

**Path Parameters**

| Parameter | Type | Description |
|---|---|---|
| `id` | integer |  |

**Request Body** (application/json)

```json
{
  "action": "approve"  // options: approve | remove | warn // required
}
```

**Response `200`**

```json
{
  "id": 0, // required
  "post": {
        "id": 0, // required
        "title": "string",
        "post_type": "lyrics"  // options: lyrics | audio | video | photo // required
      }, // required
  "uploaded_by": "string", // required
  "reporter": {
        "id": 0, // required
        "display_name": "string",
        "email": "user@example.com" // required
      }, // required
  "reason": "inappropriate_content"  // options: inappropriate_content | copyright_violation | spam | hate_speech | misinformation | other, // required
  "notes": "string",
  "ai_risk_score": 0,
  "status": "pending"  // options: pending | approved | removed,
  "reviewed_by": 0,
  "created_at": "2024-01-01T12:00:00Z", // required
  "updated_at": "2024-01-01T12:00:00Z" // required
}
```

---

### `POST` /api/v1/reports/admin/{id}/suspend/
**Suspend reported user's account**

**Path Parameters**

| Parameter | Type | Description |
|---|---|---|
| `id` | integer |  |

**Request Body** (application/json)

```json
{
  "action": "approve"  // options: approve | remove | warn // required
}
```

**Response `200`**

```json
{
  "id": 0, // required
  "post": {
        "id": 0, // required
        "title": "string",
        "post_type": "lyrics"  // options: lyrics | audio | video | photo // required
      }, // required
  "uploaded_by": "string", // required
  "reporter": {
        "id": 0, // required
        "display_name": "string",
        "email": "user@example.com" // required
      }, // required
  "reason": "inappropriate_content"  // options: inappropriate_content | copyright_violation | spam | hate_speech | misinformation | other, // required
  "notes": "string",
  "ai_risk_score": 0,
  "status": "pending"  // options: pending | approved | removed,
  "reviewed_by": 0,
  "created_at": "2024-01-01T12:00:00Z", // required
  "updated_at": "2024-01-01T12:00:00Z" // required
}
```

---

### `POST` /api/v1/reports/admin/{id}/warn/
**Send warning to reported user**

**Path Parameters**

| Parameter | Type | Description |
|---|---|---|
| `id` | integer |  |

**Request Body** (application/json)

```json
{
  "action": "approve"  // options: approve | remove | warn // required
}
```

**Response `200`**

```json
{
  "id": 0, // required
  "post": {
        "id": 0, // required
        "title": "string",
        "post_type": "lyrics"  // options: lyrics | audio | video | photo // required
      }, // required
  "uploaded_by": "string", // required
  "reporter": {
        "id": 0, // required
        "display_name": "string",
        "email": "user@example.com" // required
      }, // required
  "reason": "inappropriate_content"  // options: inappropriate_content | copyright_violation | spam | hate_speech | misinformation | other, // required
  "notes": "string",
  "ai_risk_score": 0,
  "status": "pending"  // options: pending | approved | removed,
  "reviewed_by": 0,
  "created_at": "2024-01-01T12:00:00Z", // required
  "updated_at": "2024-01-01T12:00:00Z" // required
}
```

---

### `GET` /api/v1/subscriptions/admin/coupons/
**List all coupons**

**Response:** `200` No content

---

### `POST` /api/v1/subscriptions/admin/coupons/
**Create a coupon**

**Request Body** (application/json)

```json
{
  "code": "string", // required
  "discount_type": "percentage"  // options: percentage | fixed,
  "discount_value": "string", // required
  "expiry_date": "string",
  "max_uses": 0,
  "is_active": true,
  "applicable_plan_ids": [
    0
    ]
}
```

**Response:** `201` No content

---

### `PATCH` /api/v1/subscriptions/admin/coupons/{id}/
**Update a coupon**

**Path Parameters**

| Parameter | Type | Description |
|---|---|---|
| `id` | integer |  |

**Response:** `200` No content

---

### `DELETE` /api/v1/subscriptions/admin/coupons/{id}/
**Delete a coupon**

**Path Parameters**

| Parameter | Type | Description |
|---|---|---|
| `id` | integer |  |

**Response:** `204` No content

---

### `PATCH` /api/v1/subscriptions/admin/coupons/{id}/toggle/
**Toggle coupon active status**

**Path Parameters**

| Parameter | Type | Description |
|---|---|---|
| `id` | integer |  |

**Response:** `200` No content

---

### `GET` /api/v1/subscriptions/admin/features/
**List all features**

**Response:** `200` No content

---

### `POST` /api/v1/subscriptions/admin/features/
**Create a new feature**

**Request Body** (application/json)

```json
{
  "key": "string", // required
  "name": "string", // required
  "description": "string",
  "unit": "boolean"  // options: boolean | integer | gb | mb | text,
  "default_value": "string"
}
```

**Response:** `201` No content

---

### `PATCH` /api/v1/subscriptions/admin/features/{id}/
**Update a feature**

**Path Parameters**

| Parameter | Type | Description |
|---|---|---|
| `id` | integer |  |

**Response:** `200` No content

---

### `DELETE` /api/v1/subscriptions/admin/features/{id}/
**Delete a feature**

**Path Parameters**

| Parameter | Type | Description |
|---|---|---|
| `id` | integer |  |

**Response:** `204` No content

---

### `GET` /api/v1/subscriptions/admin/overview/
**Subscription management dashboard overview**

**Response:** `200` No content

---

### `GET` /api/v1/subscriptions/admin/plans/
**List all plans (admin)**

**Response:** `200` No content

---

### `POST` /api/v1/subscriptions/admin/plans/
**Create a plan**

**Request Body** (application/json)

```json
{
  "name": "string", // required
  "slug": "string", // required
  "description": "string",
  "price": "string",
  "billing_cycle": "monthly"  // options: monthly | yearly,
  "is_active": true,
  "is_most_popular": true,
  "stripe_price_id": "string",
  "stripe_product_id": "string"
}
```

**Response:** `201` No content

---

### `PATCH` /api/v1/subscriptions/admin/plans/{id}/
**Update a plan (admin)**

**Path Parameters**

| Parameter | Type | Description |
|---|---|---|
| `id` | integer |  |

**Response:** `200` No content

---

### `DELETE` /api/v1/subscriptions/admin/plans/{id}/
**Delete a plan (admin)**

**Path Parameters**

| Parameter | Type | Description |
|---|---|---|
| `id` | integer |  |

**Response:** `204` No content

---

### `PUT` /api/v1/subscriptions/admin/plans/{id}/features/
**Set feature values for a plan**

**Path Parameters**

| Parameter | Type | Description |
|---|---|---|
| `id` | integer |  |

**Request Body** (application/json)

```json
[
{
    "feature_id": 0, // required
    "value": "string" // required
  }
]
```

**Response:** `200` No content

---

### `GET` /api/v1/subscriptions/admin/subscribers/
**List all subscribers**

**Query Parameters**

| Parameter | Type | Required | Description |
|---|---|---|---|
| `plan` | string | — | Filter by plan slug |
| `search` | string | — | Search by user email or name |
| `status` | string | — | Filter by subscription status |

**Response:** `200` No content

---

### `GET` /api/v1/subscriptions/admin/subscribers/{id}/
**Get subscriber detail**

**Path Parameters**

| Parameter | Type | Description |
|---|---|---|
| `id` | integer |  |

**Response:** `200` No content

---

### `POST` /api/v1/subscriptions/admin/subscribers/{id}/ban/
**Ban subscriber (cancel & flag)**

**Path Parameters**

| Parameter | Type | Description |
|---|---|---|
| `id` | integer |  |

**Response:** `200` No content

---

### `POST` /api/v1/subscriptions/admin/subscribers/{id}/pause/
**Pause subscriber subscription**

**Path Parameters**

| Parameter | Type | Description |
|---|---|---|
| `id` | integer |  |

**Response:** `200` No content

---

### `POST` /api/v1/subscriptions/admin/subscribers/{id}/refund/
**Issue refund for subscriber's last payment**

**Path Parameters**

| Parameter | Type | Description |
|---|---|---|
| `id` | integer |  |

**Response:** `200` No content

---