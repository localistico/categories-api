# Categories API

This app exposes an API to:
 - Get the list of cannonical categories used by localistico
 - Get category suggestions based on a list of selected/ignored
   categories. (currently suggesting descendants of selected
   categories).

Relevant details:
 - Mapping of platform categories to cannonical categories is done
   manually in the [admin backoffice][backoffice].
 - Cannonical categories come from Factual list of categories and has
   less resolution than platforms.
 - API is defined with json-schema. [Docs are autogenerated][docs].
 - Go client is auto-generated in
   [github.com/espresso-team/localistico/categories][gopkg].

TODO:
 - Endpoints to transform platform categories to cannonical categories
   and viceversa.
 - Better suggestion of categories based on data about how common is for
   categories to go together.


# Combine JSON-Schemas, verify output and generate docs

```
rake schema:default
```

# Fetch JSON of factual categories into `db/factual_categories.json`


Fetch and store latest taxonomy of factual categories.

```
rake factual:fetch
```

# Import bing categories into the database

```
rake bing:load
```


[docs]: https://github.com/espresso-team/localistico-categories/blob/master/schema/api.md
[gopkg]: https://github.com/espresso-team/localistico/tree/master/categories
[backoffice]: localistico-categories.herokuapp.com/admin
