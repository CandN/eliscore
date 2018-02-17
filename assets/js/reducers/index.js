import { combineReducers } from 'redux';

import session from './session';
import registration from './registration';
import categories from './categories';
import matches from './matches';
import users from './users';
import { routerReducer } from 'react-router-redux';

export default combineReducers({
  routing: routerReducer,
  session,
  registration,
  matches,
  users,
  categories
});
