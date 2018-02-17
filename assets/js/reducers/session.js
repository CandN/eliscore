import {
  CURRENT_USER,
  SESSIONS_ERROR,
} from '../actionTypes';

const initialState = {
  currentUser: null,
  error: [],
};

export default function reducer(state = initialState, action = {}) {
  switch (action.type) {
  case CURRENT_USER:
    return { ...state, currentUser: action.currentUser, socket: action.socket };
  case SESSIONS_ERROR:
    return { ...state, error: action.error };
  default:
    return state;
  }
}
