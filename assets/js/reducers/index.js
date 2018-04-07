import { combineReducers } from 'redux';

import session from './session';
import registration from './registration';
import categories from './categories';
import tournamentDate from './tournament_date';
import matches from './matches';
import users from './users';
import chat from './chat';
import { routerReducer } from 'react-router-redux';

export default combineReducers({
  routing: routerReducer,
  session,
  registration,
  matches,
  users,
  categories,
  tournamentDate,
  chat
});
