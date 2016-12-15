import { push }                               from 'react-router-redux';
import Constants                              from '../constants';
import { Socket }                             from 'phoenix';
import { httpGet, httpPost, httpDelete }      from '../utils';


export function setCurrentUser(dispatch, user) {
  const socket = new Socket('/socket', {
    params: { token: localStorage.getItem('phoenixAuthToken') },
    loger: (kind, msg, data) => { console.log(`${kind}: ${msg}`, data); },
  });

  socket.connect();

  const channel = socket.channel(`users:${user.id}`);

  if (channel.state != 'joined') {
    channel.join().receive('ok', () => {
      dispatch({
        type: Constants.CURRENT_USER,
        currentUser: user,
        socket: socket,
        channel: channel,
      });
    });
  }
}

const Actions = {
  signIn: (email, password) => {
    return dispatch => {
      const data = {
        session: {
          email: email,
          password: password,
        },
      };

      httpPost('/api/v1/sessions', data)
      .then((data) => {
        localStorage.setItem('phoenixAuthToken', data.jwt);
        setCurrentUser(dispatch, data.user);
        dispatch(push('/'));
      })
      .catch((error) => {
        dispatch({
          type: Constants.SESSIONS_ERROR,
          error: error,
        });
      });
    };
  },

  currentUser: () => {
    return dispatch => {
      const authToken = localStorage.getItem('phoenixAuthToken');

      httpGet('/api/v1/current_user')
      .then((data) => {
        setCurrentUser(dispatch, data);
      })
      .catch((error) => {
        console.log(error);
        dispatch(push('/sign_in'));
      });
    };
  },

  signOut: () => {
  }
}

export default Actions