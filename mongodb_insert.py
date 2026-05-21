from pymongo import MongoClient
client = MongoClient("mongodb://localhost:27017/")

db = client["dm_project_mongodb"]
print("Connected to MongoDB")
print("Database:",db.name)
