<template>
  <div class="container mt-3">
    <h3 class="text-center">Players</h3>
    <div class="row">
      <div class="col-md-3">
        <input type="text" v-model="options.name" class="form-control" placeholder="Filter by name">
      </div>
      <div class="col-md-6">
        <button type="submit" @click="getFilteredSortedPlayers" class="btn btn-primary">Filter</button>
        <button type="submit" @click="getAllPlayers" class="btn btn-info" style="margin-left: 10px;">All Players</button>
      </div>
      <div class="col-md-3 text-right">
        <CsvButton />
      </div>
    </div>
    <table class="table table-striped mt-3">
      <thead>
        <tr>
          <th scope="col">#</th>
          <th scope="col">Name</th>
          <th scope="col">Team</th>
          <th scope="col">Pos</th>
          <th scope="col">Att</th>
          <th scope="col">Att/G</th>
          <th scope="col"><a href="#" @click="setSortingAndTriggerRequest('yards_total')">Yds</a></th>
          <th scope="col">Avg</th>
          <th scope="col">Yds/G</th>
          <th scope="col"><a href="#" @click="setSortingAndTriggerRequest('touchdowns')">TD</a></th>
          <th scope="col"><a href="#" @click="setSortingAndTriggerRequest('longest_rush')">Lng</a></th>
          <th scope="col">1st</th>
          <th scope="col">1st%</th>
          <th scope="col">20+</th>
          <th scope="col">40+</th>
          <th scope="col">FUM</th>
        </tr>
      </thead>
      <tbody>
        <tr v-for="player in players" v-bind:key="player.id">
          <th scope="row">{{ player.id }}</th>
          <td>{{ player.name }}</td>
          <td>{{ player.team }}</td>
          <td>{{ player.position }}</td>
          <td>{{ player.attempts }}</td>
          <td>{{ player.attempts_avg }}</td>
          <td>{{ player.yards_total }}</td>
          <td>{{ player.yards_avg }}</td>
          <td>{{ player.yards_per_game }}</td>
          <td>{{ player.touchdowns }}</td>
          <td>{{ player.longest_rush }}</td>
          <td>{{ player.rushing_first }}</td>
          <td>{{ player.rushing_first_percentage }}</td>
          <td>{{ player.twenty_yards }}</td>
          <td>{{ player.forty_yards }}</td>
          <td>{{ player.fumbles }}</td>
        </tr>
      </tbody>
    </table>
  </div>
</template>

<script>

import PlayersService from '@/services/players_service.js';
import CsvButton from './CsvButton.vue';

export default {
  components: {
    CsvButton
  },

  data() {
    return {
      players: [],
      options: {
        name: null,
        sort_by: null,
        sort_dir: "desc"
      }
    };
  },

  methods: {
    async getAllPlayers() {
      PlayersService.getPlayers()
      .then(
        (players => {
          this.$set(this, "players", players);
        }).bind(this)
      );
    },

    async getFilteredSortedPlayers() {
      PlayersService.getPlayers(this.options)
      .then(
        (players => {
          this.$set(this, "players", players);
        }).bind(this)
      );
    },

    setSortingAndTriggerRequest(field) {
      if (this.options.sort_by == field) {
        this.switchSortDir();
      } else {
        this.options.sort_by = field;
      }

      this.getFilteredSortedPlayers();
    },

    switchSortDir() {
      if (this.options.sort_dir == "desc") {
        this.options.sort_dir = "asc";
      } else { this.options.sort_dir = "desc" }
    }
  },

  created() {
    document.title = "'the Rush' Interview Challenge";
    this.getAllPlayers();
  },
};
</script>
