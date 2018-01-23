import { IndexRoute, Route }        from 'react-router';
import React                        from 'react';
import MainLayout                   from '../layouts/main';
import RegistrationsNew             from '../views/registrations/new';
import LiveStream                   from '../components/live_stream';
import SessionsNew                  from '../views/sessions/new';
import UserShow                     from '../views/users/show';
import Leaderboard                  from '../views/users/leaderboard';
import Actions                      from '../actions/sessions';
import AuthenticatedContainer       from '../containers/authenticated';

export default function configRoutes(store) {
  const _ensureAuthenticated = (nextState, replace, callback) => {
    const { dispatch } = store;
    const { session } = store.getState();
    const { current_user } = session;

    if(!current_user && localStorage.getItem('phoenixAuthToken')) {
      dispatch(Actions.currentUser());
    } else if(!localStorage.getItem('phoenixAuthToken')) {
      replace('/sign_in');
    }

    callback();
  };

  return (
    <Route component={MainLayout}>
      <Route path="/sign_up" component={RegistrationsNew} />
      <Route path="/sign_in" component={RegistrationsNew} />
      <Route path="/live" component={LiveStream} />
      <Route path="/" component={AuthenticatedContainer} onEnter={_ensureAuthenticated} />
      <Route path="/users/:username" component={UserShow} />
      <Route path="/leaderboard" component={Leaderboard} />
    </Route>
  );
}
