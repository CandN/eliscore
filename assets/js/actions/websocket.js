import Constants from '../constants';
import { Socket } from 'phoenix';

export function connectSocket(dispatch) {
  const socket = new Socket('/socket', {
    params: { token: localStorage.getItem('phoenixAuthToken') },
    loger: (kind, msg, data) => { console.log(`${kind}: ${msg}`, data); },
  });
  socket.connect();

  dispatch({
    type: Constants.CONNECT_SOCKET,
    socket: socket
  });
}

const Actions = {
  connectSocket: () => {
    return dispatch => {
      connectSocket(dispatch);
    }
  }
}

export {
  Actions
}
