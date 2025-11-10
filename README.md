# Task Manager

This is a simple task manager application that demonstrates synchronous and asynchronous task processing.

## Ruby version

* ruby 3.2.2

## System dependencies

* Ruby on Rails
* PostgreSQL

## Configuration

1. Clone the repository:
   ```bash
   git clone https://github.com/your-username/your-repository.git
   ```
2. Install the dependencies:
   ```bash
   bundle install
   ```
3. Create the database:
   ```bash
   rails db:create
   ```
4. Run the migrations:
   ```bash
   rails db:migrate
   ```

## How to run the test suite
   ```bash
   rails test
   ```

## Services
* Sidekiq (for background jobs)

## How to run the application
1. Start the Rails server:
   ```bash
   rails server
   ```
2. Start Sidekiq:
   ```bash
   bundle exec sidekiq
   ```
3. Open your browser and go to `http://localhost:3000`

## How to use the application
* Click on "Create Sync Task" to create a task that will be processed synchronously.
* Click on "Create Async Task" to create a task that will be processed asynchronously.

## Deployment instructions

To deploy this application, you can use a service like Heroku or Render.

### Heroku

1.  Create a new Heroku app:
    ```bash
    heroku create
    ```
2.  Push the code to Heroku:
    ```bash
    git push heroku main
    ```
3.  Run the migrations:
    ```bash
    heroku run rails db:migrate
    ```
4.  Scale the web and worker dynos:
    ```bash
    heroku ps:scale web=1 worker=1
    ```

### Render

1.  Create a new Web Service in Render.
2.  Connect your GitHub repository.
3.  Set the start command to `bundle exec rails server`.
4.  Add a background worker with the start command `bundle exec sidekiq`.
5.  Add a PostgreSQL database.

