import { push }      from 'react-router-redux';
import { httpPost }  from '../utils';

import {
  CURRENT_USER,
  REGISTRATIONS_ERROR,
} from '../actionTypes';

const Actions = {};

Actions.signUp = (data) => {
  return dispatch => {
    httpPost('/api/v1/registrations', {user: data})
      .then((data) => {
        localStorage.setItem('phoenixAuthToken', data.jwt);

        dispatch({
          type: CURRENT_USER,
          currentUser: data.user,
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
