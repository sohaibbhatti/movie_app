## Getting Started

1. run the bundle install command 
2. Copy the **database.yml.example** file and modify with your own configurations
3. create databases and you're good to go!


## API design break down

1. Controllers have been scoped with the api version. So to view the relevant controllers, they'll exist in the ``controllers/api/v1/`` folder
2. The controllers are logicless. Instead they invoke the relevant **versioned service** for carrying out the necessary task.
3. Integration tests of the API exist in ```spec/api```

## JSON Response

In the event of an unsuccessful response, along with the HTTP code, the following JSON is returned

```
{
  message: "",// String explaining the type of error, validation error etc
  errors:  {} // Hash consisting field of errors. e.g for validation errors, fields where validations failed
}
```

## API ROUTES

### User
```
   GET    /users/:id
   POST   /users/
   UPDATE /users/:id
   DELETE /users/:id
```
   
   
### Movie
```
   GET    /movies/:id
   POST   /movies/
   UPDATE /movies/:id
   DELETE /movies/:id
```
   
### Like
```
   POST   /movies/:movie_id/users/:user_id/like
   DELETE /likes/:id
   GET    /users/:id/likes # List of movies a user has liked
   GET    /movies/:id/likes # List of users that have liked a particular movie
```

**Note:**
- Concepts like pagination haven't been been added.

