import pandas as pd
import psycopg
from config import config

users_flat = pd.read_csv("users_flat.csv")
groups_unique = pd.read_csv("Groups.csv")
interests = pd.read_csv("Ineterests.csv")
language = pd.read_csv("Language.csv")
political_orientation = pd.read_csv("Political Orientation.csv")
stance_on_vaccination = pd.read_csv("Stance on Vaccination.csv")
diet = pd.read_csv("Diet.csv")
spirituality = pd.read_csv("Spirituality.csv")

# Populate Users Table
sql = """ INSERT INTO users (
    user_id,
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
    profile_link)
    
    VALUES (
    %s, %s, %s, %s, %s, %s,
    %s, %s, %s, %s, %s, %s,
    %s, %s, %s, %s, %s, %s,  
    %s, %s, %s, %s, %s, %s, %s); """

try:
    with psycopg.connect(config) as conn:
        with conn.cursor() as cur:
            cur.executemany(sql,
                    [(   int(user["id"]),
                         user["nickname"],
                         int(user["Age_no"]) if not np.isnan(user["Age_no"]) else None,
                         user["I am a"],
                         user["Seeking a"],
                         user["Marital status"],
                         user["Children (want)"],
                         user["Children (have)"],
                         user["City"],
                         user["State/Region"],
                         user["Country"],
                         user["Education Level"],
                         user["Income"],
                         user["Astrological Sign"],
                         user["Tested IQ"],
                         user["Zipcode"],
                         user["About me (Minimum 50 Characters, Maximum 500 Characters)"],
                         user["Looking for"],
                         user["The one thing I am most passionate about:"],
                         user["Address"],
                         user["Latitude"],
                         user["Longitude"],
                         user["Tattoos"],
                         user["email"],
                         user["link"]  
                         ) 
                         for _, user in users_flat.iterrows()])
except Exception as e:
    print(f"Error: {e}")

# Populate Groups Table
sql = """ INSERT INTO groups (
    name,
    url,
    description,
    group_type
    )
    VALUES (%s, %s, %s, %s); """

try:
    with psycopg.connect(config) as conn:
        with conn.cursor() as cur:
            cur.executemany(sql, 
                            [(
                            group["name"],
                            group["url"],
                            group["description"],
                            group["type"]
                            ) 
                            for _, group in groups_unique.iterrows()])
except Exception as e:
    print(f"Error: {e}")

sql = """ INSERT INTO interests (name) VALUES (%s); """

try:
    with psycopg.connect(config) as conn:
        with conn.cursor() as cur:
            cur.executemany(sql, [[i] for i in interests["Interests"]])

except Exception as e:
    print(f"Error: {e}")


sql = """ INSERT INTO languages (name) VALUES (%s); """

try:
    with psycopg.connect(config) as conn:
        with conn.cursor() as cur:
            cur.executemany(sql, [[i] for i in language["Language"]])

except Exception as e:
    print(f"Error: {e}")

sql = """ INSERT INTO political_orientations (name) VALUES (%s); """

try:
    with psycopg.connect(config) as conn:
        with conn.cursor() as cur:
            cur.executemany(sql, [[i] for i in political_orientation["Political Orientation"]])

except Exception as e:
    print(f"Error: {e}")

    sql = """ INSERT INTO vaccination_stances (name) VALUES (%s); """

try:
    with psycopg.connect(config) as conn:
        with conn.cursor() as cur:
            cur.executemany(sql, [[i] for i in stance_on_vaccination["Stance on Vaccination"]])

except Exception as e:
    print(f"Error: {e}")

    sql = """ INSERT INTO diets (name) VALUES (%s); """

try:
    with psycopg.connect(config) as conn:
        with conn.cursor() as cur:
            cur.executemany(sql, [[i] for i in diet["Diet"]])

except Exception as e:
    print(f"Error: {e}")

    sql = """ INSERT INTO spiritualities (name) VALUES (%s); """

try:
    with psycopg.connect(config) as conn:
        with conn.cursor() as cur:
            cur.executemany(sql, [[i] for i in spirituality["Spirituality"]])

except Exception as e:
    print(f"Error: {e}")

    sql = """ INSERT INTO user_groups (
    user_id,
    group_id
    ) 
    VALUES (%s, %s); """         
    
with psycopg.connect(config) as conn:
    with conn.cursor() as cur:
        for _, user in users_flat.iterrows():
            for group in user["Groups"]:
                cur.execute(""" SELECT group_id FROM groups 
                                WHERE name = %s """, 
                            (group,)
                            )
                result = cur.fetchone()

                if result:
                    cur.execute(sql, (user["id"], result[0]))

                    sql = """ INSERT INTO user_languages (
    user_id,
    language_id
    ) 
    VALUES (%s, %s); """         
    
with psycopg.connect(config) as conn:
    with conn.cursor() as cur:
        for _, user in users_flat.iterrows():
            if not isinstance(user["Language"], str):
                continue
            for language in user["Language"].split(", "):
                cur.execute(""" SELECT language_id FROM languages 
                                WHERE name = %s """, 
                            (language,)
                            )
                result = cur.fetchone()

                if result:
                    cur.execute(sql, (user["id"], result[0]))


sql = """ INSERT INTO user_interests (
    user_id,
    interest_id
    ) 
    VALUES (%s, %s); """         
    
with psycopg.connect(config) as conn:
    with conn.cursor() as cur:
        for _, user in users_flat.iterrows():
            if isinstance(user["Interests"], str):
                for interest in user["Interests"].split(", "):
                    cur.execute(""" SELECT interest_id FROM interests
                                    WHERE name = %s """, 
                                (interest,)
                                )
                    result = cur.fetchone()

                    if result:
                        cur.execute(sql, (user["id"], result[0]))

sql = """ INSERT INTO user_political_orientations (
    user_id,
    political_orientation_id
    ) 
    VALUES (%s, %s); """         
    
with psycopg.connect(config) as conn:
    with conn.cursor() as cur:
        for _, user in users_flat.iterrows():
            if isinstance(user["Political Orientation"], str):
                for political_orientation in user["Political Orientation"].split(", "):
                    cur.execute(""" SELECT political_orientation_id FROM political_orientations
                                    WHERE name = %s """, 
                                (political_orientation,)
                                )
                    result = cur.fetchone()

                    if result:
                        cur.execute(sql, (user["id"], result[0]))

sql = """ INSERT INTO user_vaccination_stances (
    user_id,
    vaccination_stance_id
    ) 
    VALUES (%s, %s); """         
    
with psycopg.connect(config) as conn:
    with conn.cursor() as cur:
        for _, user in users_flat.iterrows():
            if isinstance(user["Stance on Vaccination"], str):
                for stance in user["Stance on Vaccination"].split(", "):
                    cur.execute(""" SELECT vaccination_stance_id FROM vaccination_stances
                                    WHERE name = %s """, 
                                (stance,)
                                )
                    result = cur.fetchone()

                    if result:
                        cur.execute(sql, (user["id"], result[0]))


sql = """ INSERT INTO user_diets (
    user_id,
    diet_id
    ) 
    VALUES (%s, %s); """         
    
with psycopg.connect(config) as conn:
    with conn.cursor() as cur:
        for _, user in users_flat.iterrows():
            if isinstance(user["Diet"], str):
                for diet in user["Diet"].split(", "):
                    cur.execute(""" SELECT diet_id FROM diets
                                    WHERE name = %s """, 
                                (diet,)
                                )
                    result = cur.fetchone()

                    if result:
                        cur.execute(sql, (user["id"], result[0]))

sql = """ INSERT INTO user_spiritualities (
    user_id,
    spirituality_id
    ) 
    VALUES (%s, %s); """
    
with psycopg.connect(config) as conn:
    with conn.cursor() as cur:
        for _, user in users_flat.iterrows():
            if isinstance(user["Spirituality"], str):
                for spirituality in user["Spirituality"].split(", "):
                    cur.execute(""" SELECT spirituality_id FROM spiritualities
                                    WHERE name = %s """, 
                                (spirituality,)
                                )
                    result = cur.fetchone()

                    if result:
                        cur.execute(sql, (user["id"], result[0]))