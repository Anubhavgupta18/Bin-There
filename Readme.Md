# Documentation of Bin-There API

## Users API

### Users Model
- schema example:
 ```json
{
  "name": "username",
  "email": "user@gmail.com",
  "password":"password",
  "address": {
    "flatNo": "1",
    "city": "Ranchi",
    "state": "Jharkhand",
    "pincode":"834004",
    "lat":"89.2",
    "lon": "39.2",
    "street": "HEC"
  }
}
```

### Routes

**Desc:** Register Users
   
**Route:** `/users/signup`

**Method:** `POST`

**Body:** 
```json
{
    "email":"user@gmail.com",
    "password":"password",
    "name":"username"
}
```

**Response:** 
successfull or not

---

**Desc:** Verify user email

**Route:** `/users/verifyotp`

**Method:** `POST`

**Body:** 
```json
{
    "email":"user@gmail.com",
    "otp":"280270"
}
```

**Response:** 
verified or not if verified then the user is created

---

**Desc:** Login User

**Route:** `/users/signin`

**Method:** `POST`

**Body:** 
```json
{
    "email":"user@gmail.com",
    "password":"password",
}
```

**Response:** 
user data with token

---

**Desc:** updating the fields of a user like address

**Route:** `/users/update`

**Method:** `PATCH`

**Body:** 
any field to update
```json
{
    "address":{
        "city":"Ranchi",
        "state":"Jharkhand",
        "pincode":"834004",
        "flatNo":"21",
        "street":"Road",
        "lat":"83.2",
        "lon":"84.2"
    }
}
```

**Response:** 
updated users data

---

**Desc:** Getting the details of the user

**Route:** `/users/user`

**Method:** `GET`

**Response:** 
user data

---

**Desc:** Getting timeslots for the specific user via pincode mapping

**Route:** `/users/timeslots`

**Method:** `GET`

**Response:** 
agent data


## Agents API

### Agents Model
- schema example:
 ```json
{
  "name": "username",
  "email": "user@gmail.com",
  "mobileNo": "9876543210",
  "pickupPoints": "834004",
  "timeslots": ["6a.m. - 8a.m.", "6p.m. - 8p.m."],
  "password":"password",
  "address": {
    "flatNo": "1",
    "city": "Ranchi",
    "state": "Jharkhand",
    "pincode":"834004",
    "lat":"89.2",
    "lon": "39.2",
    "street": "HEC"
  }
}
```

### Routes

**Desc:** Register Agents
   
**Route:** `/agents/signup`

**Method:** `POST`

**Body:** 
```json
{
    "email":"user@gmail.com",
    "password":"password",
    "name":"username"
}
```

**Response:** 
successfull or not

---

**Desc:** Verify email

**Route:** `/agents/verifyotp`

**Method:** `POST`

**Body:** 
```json
{
    "email":"user@gmail.com",
    "otp":"280270"
}
```

**Response:** 
verified or not if verified then the agent is created

---

**Desc:** Login

**Route:** `/agents/signin`

**Method:** `POST`

**Body:** 
```json
{
    "email":"user@gmail.com",
    "password":"password",
}
```

**Response:** 
agent data with token

---

**Desc:** updating the fields of Agents like address, pickup points, and others

**Route:** `/agents/update`

**Method:** `PATCH`

**Body:** 
any field to update
```json
{
    "timeslots":["1-2","3-4"],
    "address":{
        "city":"Ranchi",
        "state":"Jharkhand",
        "pincode":"834004",
        "flatNo":"21",
        "street":"Road",
        "lat":"83.2",
        "lon":"84.2"
    },
    "pickupPoints":"834004"
}
```

**Response:** 
updated agent data

## Pickups API

### Pickup Model
- schema example:
 ```json
{
     "user": "userRef",
     "timeslot": "6a.m. - 8a.m.",
     "agent": "agentRef",
     "status": "pending || approved || rejected",
 }
```

### Routes

**Desc:** Create Pickup
   
**Route:** `/pickups/`

**Method:** `POST`

**Body:** 
```json
{
    "timeslot":"6a.m. - 8a.m.",
    "agent":"agentId",
}
```

**Response:** 
```json
{
    "pickup": {
        "user": "6414c41d6868a24882d71744",
        "timeslot": "6a.m. - 8a.m.",
        "agent": "6414c9fc500eb9c9a72a5358",
        "status": "pending",
        "_id": "6414db775c5a023e000d2a95",
        "createdAt": "2023-03-17T21:28:23.617Z",
        "updatedAt": "2023-03-17T21:28:23.617Z",
        "__v": 0
    }
}
```

---

**Desc:** Update Pickup

**Route:** `/pickups/update/pickupId`

**Method:** `PATCH`

**Body:** 
```json
{
    "status":"approved",
    "timeslot":"7a.m.-9a.m."
}
```

**Response:** 
```json
{
    "pickup": {
        "_id": "6414db775c5a023e000d2a95",
        "user": "6414c41d6868a24882d71744",
        "timeslot": "7a.m.-9a.m.",
        "agent": "6414c9fc500eb9c9a72a5358",
        "status": "approved",
        "createdAt": "2023-03-17T21:28:23.617Z",
        "updatedAt": "2023-03-17T21:33:49.782Z",
        "__v": 0
    }
}
```

## Reports API

### Reports Model
- schema example:
 ```json
{
    "user": "userRef",
    "description": "test2",
    "image": {
        "url": "https://res.cloudinary.com/drwsrzau7/image/upload/v1679093070/jvmgnomadw7dv36nzpod.png",
        "public_id": "jvmgnomadw7dv36nzpod"
    },
    "lat": "84.1",
    "lon": "73.13",
}
```

### Routes

**Desc:** Create Report
   
**Route:** `/reports/`

**Method:** `POST`

**Body:** 
```json
{
    "description":"test",
    "lat":"83.2",
    "lon":"37.2",
    "image":"image file"
}
```

**Response:** 
```json
{
    "user": "6414c41d6868a24882d71744",
    "description": "test2",
    "image": {
        "url": "https://res.cloudinary.com/drwsrzau7/image/upload/v1679093070/jvmgnomadw7dv36nzpod.png",
        "public_id": "jvmgnomadw7dv36nzpod"
    },
    "lat": "84.1",
    "lon": "73.13"
}
```

---

**Desc:** Get all reports

**Route:** `/reports/`

**Method:** `GET`

**Response:** 
array of all reports

---

**Desc:** Get Report by Report Id

**Route:** `/reports/reportid`

**Method:** `GET`

**Response:** 
get the report data

---

**Desc:** Get all reports of an user

**Route:** `/reports/user/userid`

**Method:** `GET`

**Response:** 
array of all reports of the user

---

**Desc:** Getting the details of the user

**Route:** `/users/user`

**Method:** `GET`

**Response:** 
user data

---

**Desc:** Update a Report except image

**Route:** `/reports/reportid`

**Method:** `PATCH`

**Response:** 
updated report

---

**Desc:** Delete a report

**Route:** `/reports/reportid`

**Method:** `DELETE`

**Response:** 
delete the report