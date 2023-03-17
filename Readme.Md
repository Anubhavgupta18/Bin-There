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
