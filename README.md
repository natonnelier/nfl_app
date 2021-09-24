# NFL stats

![How to use it?](https://p-rdfqrzrn.b4.n0.cdn.getcloudapp.com/items/2NulkNXQ/fd245e46-88b2-453a-84b1-8565f693319b.jpeg?v=67df1832e6a0ba5c7591ab316a7ddaa4)

### Using the App

After following the instructions on [Installing and running](### Installing and running) you should be able to access the app at [http://localhost:8080](http://localhost:8080).

You can sort results by 'Total Rushing Yards', 'Longest Rush' and 'Total Rushing Touchdowns'. To do so click on the column titles Yds, Lng and TD respectively. They are highlated as links.

Filter by Player name using the Filter input. It's case non-sensitive.

And finally you can download the displayed table as a CVS file.

### Requirements

#### Client

* [npm](https://www.npmjs.com/)
* [VueJS](https://vuejs.org/v2/guide/installation.html)

#### Server

* [elixir](https://elixir-lang.org/)
* [phoenix](https://www.phoenixframework.org/)

### Installation and running this solution

First clone the project and `cd` into it:

```shell
$ git clone https://github.com/natonnelier/nfl_app.git
$ cd nfl_app
```

##### Run using the script

There is a shell script to setup and run both server (in the background) and client:

```shell
$ bash nfl-server.sh
```

##### Or run server and client separately

Setup and run server:

```shell
$ cd nfl_rushing

# Install dependencies
$ mix mix deps.get

# Create, migrate and populate DB
$ mix ecto.setup

# Run server
$ mix phx.server
```

And run client:

```shell
$ cd nfl_client
$ npm run serve
```

Both methods should allow you to access the app via web browser at [http://localhost:8080](http://localhost:8080). (Backend uses [http://localhost:4000](http://localhost:4000)).

#### Run tests

```shell
# cd into client if you are not already there
$ cd nfl_rushing

# run
$ mix test
```
