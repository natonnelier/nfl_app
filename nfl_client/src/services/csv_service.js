
export default {

  objectsToCSV(data) {
    const headers = Object.keys(data[0]).join();
    const content = data.map(r => Object.values(r).join());
    return [headers].concat(content).join("\n");
  }

}