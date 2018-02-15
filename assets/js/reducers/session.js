import Constants from '../constants';

const initialState = {
  currentUser: null,
  error: [],
};

export default function reducer(state = initialState, action = {}) {
  switch (action.type) {
  case Constants.CURRENT_USER:
    return { ...state, currentUser: action.currentUser, socket: action.socket };
  case Constants.SESSIONS_ERROR:
    return { ...state, error: action.error };
  default:
    return state;
  }
}
