import axios from 'axios';

export const addMatch = (id, player1, score1, player2, score2) => {
  return {
    type: 'ADD_MATCH',
    id: id,
    player1: player1,
    player1_score: score1,
    player2: player2,
    player2_score: score2
  }
}

export const postMatch = (player1, score1, player2, score2) => {
  var game_match = {
    game_match: {
      player1_id: player1,
      player2_id: player2,
      player1_score: score1,
      player2_score: score2
    }
  }

  return dispatch => {
    return axios.post("/api/v1/matches", game_match)
      .then((response) => {
        var match = response.data.match;
        dispatch(addMatch(match.id, match.player1, match.player1_score, match.player2, match.player2_score));
      });
  }
}

export const receiveMatches = (matches) => {
  return {
    type: 'RECEIVE_MATCHES',
    matches
  }
}

export const receiveUsers = (users) => {
  return {
    type: 'RECEIVE_USERS',
    users
  }
}

export const fetchUsers = () => {
  return dispatch => {
    return axios.get("/api/v1/users")
      .then((response) => {
        dispatch(receiveUsers(response.data.data))
      })
      .catch((error) => {
        console.log(error);
      })
  }
}

export const fetchMatches = () => {
  return dispatch => {
    return axios.get("/api/v1/matches")
      .then((response) => {
        dispatch(receiveMatches(response.data.data))
      })
      .catch((error) => {
        console.log(error);
      });
  }
}

