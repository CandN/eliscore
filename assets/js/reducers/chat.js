import {
  CHAT_CONNECT_SOCKET_RECEIVE
} from '../actionTypes';

const initialState = {
  socket: null
};

export default function reducer(state = initialState, action = {}) {
  switch (action.type) {
  case CHAT_CONNECT_SOCKET_RECEIVE:
    return { ...state, socket: action.socket };
  default:
    return state;
  }
}
