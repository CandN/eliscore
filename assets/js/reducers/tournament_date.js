import { RECEIVE_TOURNAMENT_DATE } from '../actionTypes';

const tournamentDate = (state = {}, action) => {
  switch(action.type) {
  case RECEIVE_TOURNAMENT_DATE:
    return action.date.start_date;
  default:
    return state;
  }
};

export default tournamentDate;
