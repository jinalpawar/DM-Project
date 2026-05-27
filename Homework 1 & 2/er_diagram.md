# ER Diagram

```mermaid
erDiagram
    USERS {
        int user_id PK
        string nickname
        int age
        string gender
        string seeking_gender
        string marital_status
        string children_want
        string children_have
        string city
        string state_region
        string country
        string education_level
        string income_range
        string astrological_sign
        string tested_iq
        string zipcode
        string about_me
        string looking_for
        string passion
        string address
        float latitude
        float longitude
        string tattoos
        string email
        string profile_link
    }

    GROUPS {
        int group_id PK
        string name
        string url
        string avatar_url
        string description
        string group_type
        int members_count
        string join_url
    }

    LANGUAGES {
        int language_id PK
        string name
    }

    INTERESTS {
        int interest_id PK
        string name
    }

    POLITICAL_ORIENTATIONS {
        int political_orientation_id PK
        string name
    }

    VACCINATION_STANCES {
        int vaccination_stance_id PK
        string name
    }

    DIETS {
        int diet_id PK
        string name
    }

    SPIRITUALITIES {
        int spirituality_id PK
        string name
    }

    USER_GROUPS {
        int user_id FK
        int group_id FK
    }

    USER_LANGUAGES {
        int user_id FK
        int language_id FK
    }

    USER_INTERESTS {
        int user_id FK
        int interest_id FK
    }

    USER_POLITICAL_ORIENTATIONS {
        int user_id FK
        int political_orientation_id FK
    }

    USER_VACCINATION_STANCES {
        int user_id FK
        int vaccination_stance_id FK
    }

    USER_DIETS {
        int user_id FK
        int diet_id FK
    }

    USER_SPIRITUALITIES {
        int user_id FK
        int spirituality_id FK
    }

    USERS ||--o{ USER_GROUPS : belongs_to
    GROUPS ||--o{ USER_GROUPS : includes

    USERS ||--o{ USER_LANGUAGES : speaks
    LANGUAGES ||--o{ USER_LANGUAGES : is_spoken_by

    USERS ||--o{ USER_INTERESTS : has
    INTERESTS ||--o{ USER_INTERESTS : is_selected_by

    USERS ||--o{ USER_POLITICAL_ORIENTATIONS : has
    POLITICAL_ORIENTATIONS ||--o{ USER_POLITICAL_ORIENTATIONS : is_selected_by

    USERS ||--o{ USER_VACCINATION_STANCES : has
    VACCINATION_STANCES ||--o{ USER_VACCINATION_STANCES : is_selected_by

    USERS ||--o{ USER_DIETS : follows
    DIETS ||--o{ USER_DIETS : is_followed_by

    USERS ||--o{ USER_SPIRITUALITIES : has
    SPIRITUALITIES ||--o{ USER_SPIRITUALITIES : is_selected_by
