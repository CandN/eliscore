import { push }      from 'react-router-redux';
import Constants     from '../constants';
import { httpPost }  from '../utils';

const Actions = {};

Actions.signUp = (data) => {
  return dispatch => {
    httpPost('/api/v1/registrations', {user: data})
      .then((data) => {
        localStorage.setItem('phoenixAuthToken', data.jwt);

        dispatch({
          type: Constants.CURRENT_USER,
          currentUser: data.user,
        });

        dispatch(push('/'));
      })
      .catch((error) => {
        error.response.json()
          .then((errorJSON) => {
            dispatch({
              type: Constants.REGISTRATIONS_ERROR,
              errors: errorJSON.error,
            });
          });
      });
  };
};

export default Actions;
