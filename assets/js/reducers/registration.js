import { REGISTRATIONS_ERROR } from '../actionTypes';

const initialState = {
  errors: null,
};

export default function reducer(state = initialState, action = {}) {
  switch (action.type) {
  case REGISTRATIONS_ERROR:
    return {...state, errors: action.errors};

  default:
    return state;
  }
}
