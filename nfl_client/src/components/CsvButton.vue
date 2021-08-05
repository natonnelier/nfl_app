<template>
  <button type="submit" @click="exportToCsv" class="btn btn-success">Export Table to CSV</button>
</template>

<script>

import CsvService from '@/services/csv_service.js';

export default {

  methods: {
    exportToCsv() {
      var csv = CsvService.objectsToCSV(this.$parent.players);
      const anchor = document.createElement('a');
      anchor.href = 'data:text/csv;charset=utf-8,' + encodeURIComponent(csv);
      anchor.target = '_blank';
      anchor.download = 'players.csv';
      anchor.click();
    },
  }

}
</script>
