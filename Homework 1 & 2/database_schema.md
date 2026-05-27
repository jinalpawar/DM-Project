# Database Schema

## PRIMARY KEYS

The following  primary keys have been defined for the entities:
- users(user_id)
- groups(group_id)
- languages(language_id)
- interests(interest_id)
- political_orientations(political_orientation_id)
- vaccination_stances(vaccination_stance_id)
- diets(diet_id)
- spiritualities(spirituality_id)

### Bridge tables (many-to-many relationships)
- user_groups(user_id, group_id)
- user_languages(user_id, language_id)
- user_interests(user_id, interest_id)
- user_political_orientations(user_id, political_orientation_id)
- user_vaccination_stances(user_id, vaccination_stance_id)
- user_diets(user_id, diet_id)
- user_spiritualities(user_id, spirituality_id)

---

## FOREIGN KEYS
The following foreign key relationships are defined:
- user_groups.user_id -> users.user_id
- user_groups.group_id -> groups.group_id
- user_languages.user_id -> users.user_id
- user_languages.language_id -> languages.language_id
- user_interests.user_id -> users.user_id
- user_interests.interest_id -> interests.interest_id
- user_political_orientations.user_id -> users.user_id
- user_political_orientations.political_orientation_id -> political_orientations.political_orientation_id
- user_vaccination_stances.user_id -> users.user_id
- user_vaccination_stances.vaccination_stance_id -> vaccination_stances.vaccination_stance_id
- user_diets.user_id -> users.user_id
- user_diets.diet_id -> diets.diet_id
- user_spiritualities.user_id -> users.user_id
- user_spiritualities.spirituality_id -> spiritualities.spirituality_id

---
### RELATIONAL SCHEMA
```sql
USERS (
  user_id PK,
  nickname,
  age,
  gender,
  seeking_gender,
  marital_status,
  children_want,
  children_have,
  city,
  state_region,
  country,
  education_level,
  income_range,
  astrological_sign,
  tested_iq,
  zipcode,
  about_me,
  looking_for,
  passion,
  address,
  latitude,
  longitude,
  tattoos,
  email,
  profile_link
)

GROUPS(
  group_id PK,
  name,
  url UNIQUE,
  avatar_url,
  description,
  group_type,
  members_count,
  join_url
)

USER_GROUPS(
  user_id FK,
  group_id FK,
  PRIMARY KEY (user_id, group_id)
)

LANGUAGES(
  language_id PK,
  name UNIQUE
)

USER_LANGUAGES(
  user_id FK,
  language_id FK,
  PRIMARY KEY (user_id, language_id)
)

INTERESTS(
  interest_id PK,
  name UNIQUE
)

USER_INTERESTS(
  user_id FK,
  interest_id FK,
  PRIMARY KEY(user_id, interest_id)
)

POLITICAL_ORIENTATIONS(
  political_orientation_id PK,
  name UNIQUE
)

USER_POLITICAL_ORIENTATIONS(
  user_id FK,
  political_orientation_id FK,
  PRIMARY KEY(user_id, political_orientation_id)
)

VACCINATION_STANCES(
  vaccination_stance_id PK,
  name UNIQUE
)

USER_VACCINATION_STANCES(
  user_id FK,
  vaccination_stance_id FK,
  PRIMARY KEY(user_id, vaccination_stance_id)
)

DIETS(
  diet_id PK,
  name UNIQUE
)

USER_DIETS(
  user_id FK,
  diet_id FK,
  PRIMARY KEY(user_id, diet_id)
)

SPIRITUALITIES(
  spirituality_id PK,
  name UNIQUE
)

USER_SPIRITUALITIES(
  user_id FK,
  spirituality_id FK,
  PRIMARY KEY(user_id, spirituality_id)
)
