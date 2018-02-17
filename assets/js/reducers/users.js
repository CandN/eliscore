import { RECEIVE_USER } from '../actionTypes';

const initialState = {
  user: {},
};

export default function reducer(state = initialState, action = {}) {
  switch (action.type) {
  case RECEIVE_USER:
    return { ...state, user: action.user };
  default:
    return state;
  }
}
