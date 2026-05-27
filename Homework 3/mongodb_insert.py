#In PostgreSQL, the data was normalized into multiple tables and bridge tables.
#In MongoDB, we use a denormalized document model where user-related data is embedded inside each user document.
import json 
from pymongo import MongoClient
from datetime import datetime

JSON_FILE_PATH = "../Data/merged_details.json"
MONGO_URI = "mongodb://localhost:27017/"
DB_NAME = "dm_project_mongodb"
COLLECTION_NAME = "users"

def clean_value(value):
    """Convert empty strings and invalid values into None"""
    if value is None:
        return None
    if isinstance(value,str):
        value=value.strip()
        if value == "" or value == "a:0:{}":
            return None
    return value

def split_multi_value(value):
    """
    Split comma-separated values into a clean list. Example:
    'English, German' -> ['English', 'German']"""

    value=clean_value(value)
    if not isinstance(value,str):
        return []
    return [item.strip() for item in value.split(",") if item.strip()]

def get_accordion(user):
    """Get accordionData from profileData safely"""
    profile_data=user.get("profileData", {})
    return profile_data.get("accordionData",{}) or {}

def get_position(user):
    """Extract latitude and longitude safely"""
    position=user.get("position")

    if isinstance(position,dict):
        return {
            "latitude":position.get("latitude"),
            "longitude":position.get("longitude")
        }
    return {
        "latitude":None,
        "longitude":None
    }

def transform_group(group):
    return {
        "name": clean_value(group.get("name")),
        "url": clean_value(group.get("url")),
        "description": clean_value(group.get("description")),
        "type": clean_value(group.get("type"))
    }

def transform_user(user):
    """Transform original JSON user into MongoDB user document"""
    accordion = get_accordion(user)
    position = get_position(user)

    user_id=user.get("id")
    if user_id is None:
        return None
    
    age = clean_value(accordion.get("Age"))

    if isinstance(age, str) and len(age) > 4:
        age = int((datetime.now() - datetime.strptime(age, "%Y-%m-%d %H:%M:%S")).days/365)
    elif isinstance(age, str) and age:
        age = abs(int(age))
    else:
        age = None
    
    document = {
        "user_id": int(user_id),
        "nickname": clean_value(user.get("profileData", {}).get("nickname")),
        "age": age,
        "gender": clean_value(accordion.get("I am a")),
        "seeking_gender": clean_value(accordion.get("Seeking a")),
        "marital_status":clean_value(accordion.get("Marital status")),
        "children_want":clean_value(accordion.get("Children (want)")),
        "children_have":clean_value(accordion.get("Children (have)")),
        "city":clean_value(accordion.get("City")),
        "state_region":clean_value(accordion.get("State/Region")),
        "country":clean_value(accordion.get("Country")),
        "education_level":clean_value(accordion.get("Education Level")),
        "income_range":clean_value(accordion.get("Income")),
        "astrological_sign":clean_value(accordion.get("Astrological Sign")),
        "tested_iq":clean_value(accordion.get("Tested IQ")),
        "zipcode":clean_value(accordion.get("Zipcode")),
        "about_me":clean_value(accordion.get("About me (Minimum 50 Characters, Maximum 500 Characters)")),
        "looking_for":clean_value(accordion.get("Looking for")),
        "passion":clean_value(accordion.get("The one thing I am most passionate about:")),
        "address":clean_value(user.get("address")),
        "location":position,
        "tattoos":clean_value(accordion.get("Tattoos")),
        "email":clean_value(user.get("email")),
        "profile_link":clean_value(user.get("link")),

        "languages":split_multi_value(accordion.get("Language")),
        "interests":split_multi_value(accordion.get("Interests")),
        "political_orientations":split_multi_value(accordion.get("Political Orientation")),
        "vaccination_stances":split_multi_value(accordion.get("Stance on Vaccination")),
        "diets":split_multi_value(accordion.get("Diet")),
        "spiritualities":split_multi_value(accordion.get("Spirituality")),

        "groups":[ transform_group(group) for group in user.get("groupData",[]) if isinstance(group,dict)]

    }
    return document

def main():
    client=MongoClient(MONGO_URI)
    db=client[DB_NAME]
    users_collection=db[COLLECTION_NAME]

    with open(JSON_FILE_PATH,"r", encoding="utf-8") as file:
        data=json.load(file)
    raw_users=data["users"]

    documents=[]
    for user in raw_users:
        document = transform_user(user)
        if document is not None:
            documents.append(document)
    users_collection.delete_many({})

    if documents:
        users_collection.insert_many(documents)
    users_collection.create_index("user_id", unique=True)
    users_collection.create_index("country")
    users_collection.create_index("interests")
    users_collection.create_index("groups.name")

    print("Inserted documents:", users_collection.count_documents({}))
    print("Database:", DB_NAME)
    print("Collection:", COLLECTION_NAME)


if __name__ == "__main__":
    main()
    