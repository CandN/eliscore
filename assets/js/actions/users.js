import axios from 'axios';
import { push }      from 'react-router-redux';

const Actions = {
  fetchUser: (username, users) => {
    return dispatch => {
      return axios.get(`/api/v1/users/${username}`)
        .then((response) => {
          dispatch(Actions.receiveUser(response.data.data));
        })
        .catch((error) => {
          console.log(error);
          dispatch(push('/'));
        })
    }
  },
  receiveUser: (user) => {
    return {
      type: 'RECEIVE_USER',
      user
    }
  }
}

export default Actions
