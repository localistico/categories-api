## Categories
Get information from localistico and services' categories

### Categories All
Get all categories

```
GET /categories
```


#### Curl Example
```bash
$ curl -n -X GET http://localistico-categories.herokuapp.com/categories

```


#### Response Example
```
HTTP/1.1 200 OK
```
```json
[
  {
    "id": 10,
    "abstract": false,
    "parent_id": 1,
    "en": "Indian Restaurant",
    "es": "Restaurante Indio",
    "created_at": "2012-01-01T12:00:00Z",
    "updated_at": "2012-01-01T12:00:00Z"
  }
]
```

### Categories Select
List existing profiles from a business.

```
GET /categories
```

#### Required Parameters
| Name | Type | Description | Example |
| ------- | ------- | ------- | ------- |
| **ids** | *array* | List of IDs of the categories to select | `[10,24,144]` |



#### Curl Example
```bash
$ curl -n -X GET http://localistico-categories.herokuapp.com/categories
 -G \
  -d ids[]=10 \
  -d ids[]=24 \
  -d ids[]=144

```


#### Response Example
```
HTTP/1.1 200 OK
```
```json
[
  {
    "id": 10,
    "abstract": false,
    "parent_id": 1,
    "en": "Indian Restaurant",
    "es": "Restaurante Indio",
    "created_at": "2012-01-01T12:00:00Z",
    "updated_at": "2012-01-01T12:00:00Z"
  }
]
```

### Categories Suggestions
Suggest categories based on the ones passed as an argument

```
GET /suggestions
```

#### Optional Parameters
| Name | Type | Description | Example |
| ------- | ------- | ------- | ------- |
| **selected** | *array* | List of IDs of the categories to base the suggestions on. | `[10,24,144]` |
| **ignored** | *array* | List of IDs of categories to ignore. | `[35,54,532,764]` |
| **limit** | *integer* | Maximum amount of categories to return | `15` |


#### Curl Example
```bash
$ curl -n -X GET http://localistico-categories.herokuapp.com/suggestions
 -G \
  -d selected[]=10 \
  -d selected[]=24 \
  -d selected[]=144 \
  -d ignored[]=35 \
  -d ignored[]=54 \
  -d ignored[]=532 \
  -d ignored[]=764 \
  -d limit=15

```


#### Response Example
```
HTTP/1.1 200 OK
```
```json
[
  {
    "id": 10,
    "abstract": false,
    "parent_id": 1,
    "en": "Indian Restaurant",
    "es": "Restaurante Indio",
    "created_at": "2012-01-01T12:00:00Z",
    "updated_at": "2012-01-01T12:00:00Z"
  }
]
```

### Categories Normalized
List existing profiles from a business.

```
GET /categories/normalized
```

#### Required Parameters
| Name | Type | Description | Example |
| ------- | ------- | ------- | ------- |
| **service_categories** | *object* |  |  |



#### Curl Example
```bash
$ curl -n -X GET http://localistico-categories.herokuapp.com/categories/normalized
 -G \
  -d 

```


#### Response Example
```
HTTP/1.1 200 OK
```
```json
[
  {
    "id": 10,
    "abstract": false,
    "parent_id": 1,
    "en": "Indian Restaurant",
    "es": "Restaurante Indio",
    "created_at": "2012-01-01T12:00:00Z",
    "updated_at": "2012-01-01T12:00:00Z"
  }
]
```

### Categories ServiceAll
Get all categories

```
GET /categories/{category_service}
```


#### Curl Example
```bash
$ curl -n -X GET http://localistico-categories.herokuapp.com/categories/$CATEGORY_SERVICE

```


#### Response Example
```
HTTP/1.1 200 OK
```
```json
[
  {
    "id": 10,
    "category_id": 1,
    "service": "yelp",
    "category": "Indian Restaurant",
    "created_at": "2012-01-01T12:00:00Z",
    "updated_at": "2012-01-01T12:00:00Z"
  }
]
```


