import Constants from '../constants';

const initialState = {
  socket: null
};

export default function reducer(state = initialState, action = {}) {
  switch (action.type) {
  case Constants.CONNECT_SOCKET:
    return { ...state, socket: action.socket };
  default:
    return state;
  }
}
