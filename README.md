# Rails Docker Starter
Out of a frustration of trying to get a consistent setup that would let me have multiple Rails and Bundler versions to use easily, I decided to just create a Docker/Docker-Compose solution which would just build the Rails app within a Docker container anyways.

Clone the repo, then run `docker-compose run web rails new . --force --no-deps --database=postgresql` (or whatever database you plan on using).

Then, for Linux, run `sudo chown -R $USER:$USER` since all of the Rails-generated files will initially belong to `root`.

Then, run `docker-compose build` to rebuild the image, since the `Gemfile` was changed by the Rails initialization.

Edit `config/database.yml` to include the correct parameters for the database.

i.e.
```yml
default: &default
  adapter: postgresql
  encoding: unicode
  host: db
  username: postgres
  password:
  pool: 5
.
.
.
```

Boot the app with `docker-compose up` (Note: You might have to run `docker-compose up db` to initialize Postgres first. Better yet, include a `wait-for-it.sh`-like script so that the Rails app waits for Postgres to start).

Finally, create the database through Rails with Rake: `docker-compose run web rake db:create`.

That's it! If you stopped the application, rerun it and then navigate to `localhost:3000` where you should see the Rails startup page.

---
---

*NOTE*: If you edit the `Gemfile` or `docker-compose`, you'll need to rebuild the Docker application image. Some changes (i.e. docker-compose configuration changes such as port change) only require a `docker-compose up --build`. However, changes that would require syncing the `Gemfile.lock` to the changed `Gemfile` will require a `docker-compose run web bundle install` to work properly.

