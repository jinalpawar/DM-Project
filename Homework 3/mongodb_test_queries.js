// (3.1) AVG AGE PER POLITICAL ORIENTATION
db.users.aggregate(
    [
        { $unwind: "$political_orientations" },
        {
            $group: {
                _id: "$political_orientations",
                avg_age: { $avg: "$age" }
            }
        },
        { $project: { _id: 0, political_orientations: "$_id", avg_age: { $floor: "$avg_age" } } }
    ]
)

// (3.2) MEMBER COUNT PER GROUP
db.users.aggregate(
    [
        { $unwind: "$groups" },
        {
            $group: {
                _id: "$groups.name",
                member_count: { $count: {} }
            }
        },
        { $sort: { member_count: -1 } }
    ]
)

// (3.3) AVG AGE & USER COUNT PER VACCINATION STANCE PER GENDER
db.users.aggregate(
    [
        { $unwind: "$vaccination_stances" },
        {
            $group: {
                _id: ["$vaccination_stances", "$gender"],
                avg_age: { $avg: "$age" },
                member_count: { $count: {} }
            }
        },
        { $project: { _id: 0, vaccination_stance: { "$arrayElemAt": ["$_id", 0] }, gender: { "$arrayElemAt": ["$_id", 1] }, avg_age: { $floor: "$avg_age" }, member_count: 1 } }

    ]
)
// (3.4) MOST COMMON POLITICAL ORIENTATION PER COUNTRY
db.users.aggregate(
    [
        { $unwind: "$political_orientations" },
        {
            $group: {
                _id: { country: "$country", political_orientation: "$political_orientations" },
                member_count: { $count: {} }
            }
        },
        { $sort: { member_count: -1 } },
        {
            $group: {
                _id: "$_id.country",
                political_orientation: { $first: "$_id.political_orientation" },
                member_count: { $first: "$member_count" }
            }
        },
        { $sort: { member_count: -1 } },
        { $project: { _id: 0, country: "$_id", political_orientation: 1, member_count: 1 } }

    ]
)
// (3.5) MOST COMMON VACCINATION STANCE PER COUNTRY
db.users.aggregate(
    [
        { $unwind: "$vaccination_stances" },
        {
            $group: {
                _id: { country: "$country", vaccination_stance: "$vaccination_stances" },
                member_count: { $count: {} }
            }
        },
        { $sort: { member_count: -1 } },
        {
            $group: {
                _id: "$_id.country",
                vaccination_stance: { $first: "$_id.vaccination_stance" },
                member_count: { $first: "$member_count" }
            }
        },
        { $sort: { member_count: -1 } },
        { $project: { _id: 0, country: "$_id", vaccination_stance: 1, member_count: 1 } }

    ]
)
// (3.6) INTERESTS SHARED BY USERS FROM MINIMUM 5 COUNTRIES
db.users.aggregate(
    [
        { $unwind: "$interests" },
        {
            $group: {
                _id: "$interests",
                country: { $addToSet: "$country" }
            }
        },
        { $project: { _id: 0, interest: "$_id", num_countries: { $size: "$country" } } },
        { $match: { num_countries: { $gte: 5 } } },
        { $sort: { num_countries: -1 } }

    ]
)
// (3.7) MOST COMMON INTERESTS
db.users.aggregate(
    [
        { $unwind: "$interests" },
        {
            $group: {
                _id: "$interests",
                user_count: { $count: {} }
            }
        },
        { $project: { _id: 0, interest: "$_id", user_count: "$user_count" } },
        { $sort: { user_count: -1 } }

    ]
)

// (3.8) TOP 10 GROUPS WITH HIGHEST USER COUNT
db.users.aggregate(
    [
        { $unwind: "$groups" },
        {
            $group: {
                _id: "$groups.name",
                member_count: { $count: {} }
            }
        },
        { $sort: { member_count: -1 } },
        { $limit: 10}
    ]
)

// (3.9) USERS WHO DO NOT BELONG TO ANY GROUP
db.users.find({ groups: [] }, { _id: 1, nickname: 1, country: 1 })

// (3.10) USERS WITH HIGHER GROUP COUNT THAN AVG
var avg = db.users.aggregate(
    [
        { $project: { group_count: { $size: "$groups" } } },
        { $group: { _id: null, average: { $avg: "$group_count" } } }
    ]).toArray()[0].average

db.users.aggregate(
    [
        { $project: { _id: 1, nickname: 1, country: 1, group_count: { $size: "$groups" } } },
        { $match: { group_count: { $gt: avg } } },
        { $sort: { group_count: -1 } }
    ]
)