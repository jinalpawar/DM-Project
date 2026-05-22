use dm_project_mongodb;

//count users
db.users.countDocuments();

//Show one user
db.users.findOne();

//Users from Germany
db.users.find({ country:"Germany" }).limit(5);

//users with interests Dogs
db.users.find({ interests:"Dogs" }).limit(5);

//users who belong to general chat
db.users.find({ "groups.name": "General chat" }).limit(5);