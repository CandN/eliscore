import axios from 'axios';
import { normalize, schema } from 'normalizr';
import { buildHeaders, notify } from '../utils';

import {
  ADD_MATCH,
  RECEIVE_CATEGORIES,
  RECEIVE_TOURNAMENT_DATE,
  RECEIVE_MATCHES,
  RECEIVE_USERS,
} from '../actionTypes';

export const addMatch = (id, player1, score1, player2, score2, category_id) => {
  return {
    type: ADD_MATCH,
    id: id,
    player1: player1,
    player1_score: score1,
    player2: player2,
    player2_score: score2,
    category_id: category_id,
  }
}

export const postMatch = (player1_id, score1, player2_id, score2, category_id) => {
  var game_match = {
    player1_id: player1_id,
    player2_id: player2_id,
    player1_score: score1,
    player2_score: score2,
    category_id: category_id,
  }

  return dispatch => {
    return axios.post("/api/v1/matches", game_match, { headers: buildHeaders() })
      .then((response) => {
        var match = response.data.data;
        dispatch(
          addMatch(match.id, match.player1, match.player1_score, match.player2, match.player2_score, match.category_id)
        );
        notify('Added a match', 'Successfully added a match');
      });
  }
}

export const receiveMatches = (matches) => {
  return {
    type: RECEIVE_MATCHES,
    matches
  }
}

export const receiveUsers = (users) => {
  return {
    type: RECEIVE_USERS,
    users
  }
}

export const receiveTournamentDate = (date) => {
  return {
    type: RECEIVE_TOURNAMENT_DATE,
    date
  }
}

export const receiveCategories = (categories) => {
  return {
    type: RECEIVE_CATEGORIES,
    categories
  }
}

export const fetchUsers = () => {
  return dispatch => {
    return axios.get("/api/v1/users",  { headers: buildHeaders() })
      .then((response) => {
        dispatch(receiveUsers(response.data.data))
      })
      .catch((error) => {
        console.log(error);
      })
  }
}

export const fetchCategories = () => {
  return dispatch => {
    return axios.get("/api/v1/categories", { headers: buildHeaders() })
      .then((response) => {
        const category_schema = new schema.Entity('categories');
        const data = normalize(response.data.data, [ category_schema ]);

        dispatch(receiveCategories(data.entities.categories));
      })
      .catch((error) => {
        console.log(error);
      })
  }
}

export const fetchTournamentDate = () => {
  return dispatch => {
    return axios.get("/api/v1/tournaments/date", { headers: buildHeaders() })
      .then((response) => {
        dispatch(receiveTournamentDate(response.data.data));
      })
      .catch((error) => {
        console.log(error);
      })
  }
}

export const fetchMatches = () => {
  return dispatch => {
    return axios.get("/api/v1/matches", { headers: buildHeaders() })
      .then((response) => {
        dispatch(receiveMatches(response.data.data))
      })
      .catch((error) => {
        console.log(error);
      });
  }
}

