CREATE TABLE users (
  user_id BIGINT PRIMARY KEY,
  nickname VARCHAR(100),
  age INT,
  gender VARCHAR(50),
  seeking_gender VARCHAR(50),
  marital_status VARCHAR(50),
  children_want VARCHAR(100),
  children_have VARCHAR(100),
  city VARCHAR(100),
  state_region VARCHAR(100),
  country VARCHAR(100),
  education_level VARCHAR(100),
  income_range VARCHAR(50),
  astrological_sign VARCHAR(50),
  tested_iq VARCHAR(50),
  zipcode VARCHAR(20),
  about_me TEXT,
  looking_for TEXT,
  passion TEXT,
  address TEXT,
  latitude DOUBLE PRECISION,
  longitude DOUBLE PRECISION,
  tattoos VARCHAR(100),
  email VARCHAR(255),
  profile_link TEXT
);

CREATE TABLE groups (
  group_id SERIAL PRIMARY KEY,
  name VARCHAR(255),
  url TEXT UNIQUE,
  avatar_url TEXT,
  description TEXT,
  group_type VARCHAR(100),
  members_count INT,
  join_url TEXT
);

CREATE TABLE user_groups (
  user_id BIGINT NOT NULL,
  group_id INT NOT NULL,
  PRIMARY KEY (user_id, group_id),
  FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE,
  FOREIGN KEY (group_id) REFERENCES groups(group_id) ON DELETE CASCADE
);

CREATE TABLE languages(
  language_id SERIAL PRIMARY KEY,
  name VARCHAR(100) UNIQUE
);

CREATE TABLE user_languages(
  user_id BIGINT NOT NULL,
  language_id INT NOT NULL,
  PRIMARY KEY (user_id, language_id),
  FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE,
  FOREIGN KEY (language_id) REFERENCES languages(language_id) ON DELETE CASCADE
);

CREATE TABLE interests(
  interest_id SERIAL PRIMARY KEY,
  name VARCHAR(150) UNIQUE
);

CREATE TABLE user_interests(
  user_id BIGINT NOT NULL,
  interest_id INT NOT NULL,
  PRIMARY KEY (user_id, interest_id),
  FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE,
  FOREIGN KEY (interest_id) REFERENCES interests(interest_id) ON DELETE CASCADE
);

CREATE TABLE political_orientations(
  political_orientation_id SERIAL PRIMARY KEY,
  name VARCHAR(100) UNIQUE
);

CREATE TABLE user_political_orientations(
  user_id BIGINT NOT NULL,
  political_orientation_id INT NOT NULL,
  PRIMARY KEY (user_id, political_orientation_id),
  FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE,
  FOREIGN KEY  (political_orientation_id) REFERENCES  political_orientations( political_orientation_id) ON DELETE CASCADE
);

CREATE TABLE vaccination_stances(
  vaccination_stance_id SERIAL PRIMARY KEY,
  name VARCHAR(150) UNIQUE
);

CREATE TABLE user_vaccination_stances(
  user_id BIGINT NOT NULL,
  vaccination_stance_id INT NOT NULL,
  PRIMARY KEY (user_id, vaccination_stance_id),
  FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE,
  FOREIGN KEY  (vaccination_stance_id) REFERENCES vaccination_stances(vaccination_stance_id) ON DELETE CASCADE
);

CREATE TABLE diets(
  diet_id SERIAL PRIMARY KEY,
  name VARCHAR(100) UNIQUE
);

CREATE TABLE user_diets(
  user_id BIGINT NOT NULL,
  diet_id INT NOT NULL,
  PRIMARY KEY (user_id, diet_id),
  FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE,
  FOREIGN KEY  (diet_id) REFERENCES diets(diet_id) ON DELETE CASCADE
);

CREATE TABLE spiritualities(
  spirituality_id SERIAL PRIMARY KEY,
  name VARCHAR(100) UNIQUE
);

CREATE TABLE user_spiritualities(
  user_id BIGINT NOT NULL,
  spirituality_id INT NOT NULL,
  PRIMARY KEY (user_id, spirituality_id),
  FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE,
  FOREIGN KEY  (spirituality_id) REFERENCES spiritualities(spirituality_id) ON DELETE CASCADE
);

