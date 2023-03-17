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

#### Register Users
   
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


**Route:** `/users/user`

**Method:** `GET`

**Response:** 
user data


**Route:** `/users/timeslots`

**Method:** `GET`

**Response:** 
agent data
