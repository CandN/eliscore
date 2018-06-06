import { push }      from 'react-router-redux';
import { httpPost }  from '../utils';

import {
  CURRENT_USER,
  REGISTRATIONS_ERROR,
} from '../actionTypes';

const Actions = {};

Actions.signUp = (data) => {
  return dispatch => {
    httpPost('/api/v1/registrations', data)
      .then((response) => {
        localStorage.setItem('phoenixAuthToken', response.jwt);

        dispatch({
          type: CURRENT_USER,
          currentUser: response.user,
        });

        dispatch(push('/'));
      })
      .catch((error) => {
        error.response.json()
          .then((errorJSON) => {
            dispatch({
              type: REGISTRATIONS_ERROR,
              errors: errorJSON.error,
            });
          });
      });
  };
};

export default Actions;
