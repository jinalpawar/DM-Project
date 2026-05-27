# MONGODB SCHEMA DESIGN

## Database name

`dm_project_mongodb`

## Collection

`users`

## Design decision

For Homework 3 we transformed the relational PostgreSQL schema into a MongoDB document-based model.
In the relational model, the data was normalized into several tables such as:
-users
-groups
-interests
-languages
-political_orientations
-vaccination_stances
-diets
-spiritualities

Many-to-many relationships were represented using bridge tables such as:
-user_groups
-user_interests
-user_languages
-user_political_orientations
-user_vaccination_stances

In MongoDB we use a denormalized structure centered on the user document.

This is appropriate because most relationships in the dataset are user-centered. Therefore, attributes such as interests, languages, groups, political orientations and vaccination stances are embedded directly inside each user document.

## User document structure

```json
{
    "user_id":11780,
    "nickname": "Mortarion",
    "age":"26",
    "gender":"Man",
    "seeking_gender":"Woman",
    "country":"Germany",
    "city":"Ampfing",
    "education_level":"High School",
    "income_range":"$/ 20-40k",
    "location": {"latitude": 12.409887783985786, "longitude":48.253959449999996},
    "interests":["Pop/Rock/Jazz music", "Dogs","Martial Arts"],
    "languages":["English"],
    "political_orientations": ["Based"],
    "vaccination_stances":["Anti-Vax","Not Covid Vaxxed"],
    "groups":[{"name":"General chat", "url": "https://www.whitedate.net/dating-site-for-white-people-groups/general-chat/",
    "type":"Public Group"}]

}
``` 
## Indexes created

The insertion script creates the following indexes: 

```javascript
db.users.createIndex({ user_id: 1 }, { unique: true })
db.users.createIndex({ country: 1 })
db.users.createIndex({ interests: 1 })
db.users.createIndex({ "groups.name": 1 })