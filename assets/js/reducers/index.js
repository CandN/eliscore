import { combineReducers }  from 'redux';
import { routerReducer }    from 'react-router-redux';
import session              from './session';
import registration         from './registration';
import categories           from './categories';
import matches              from './matches';
import users                from './users';

export default combineReducers({
  routing: routerReducer,
  session: session,
  registration: registration,
  matches: matches,
  users: users,
  categories: categories,
});
