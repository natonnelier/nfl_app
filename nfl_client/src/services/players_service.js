import axios from "axios"
const API_HOST = "http://localhost:4000/api"

function buildParams(options) {
  const queryString = new URLSearchParams({
    name: options['name'] || '',
    sort_by: options['sort_by'] || null,
    sort_dir: options['sort_dir'] || null,
  }).toString();

  return queryString;  
}

export default {

  async getPlayers(options = {}) {
    const params = buildParams(options);
    let res = await axios.get(`${API_HOST}/players?${params}`);
    return res.data.data;
  }
  // async getEventSingle(eventId, accessToken) {
  //   let res = await axios.get("http://localhost:8000/events/" + eventId, {
  //       headers: {
  //           Authorization: `Bearer ${accessToken}`
  //       }
  //   });
  //   return res.data;
  // }
}