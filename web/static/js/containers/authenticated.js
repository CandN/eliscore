import React            from 'react';
import { connect }      from 'react-redux';
import { routeActions } from 'redux-simple-router';
import Actions          from '../actions/sessions';
import MatchList        from '../components/match_list';

class AuthenticatedContainer extends React.Component {
  componentDidMount() {
    const { dispatch, currentUser } = this.props;

    if (localStorage.getItem('phoenixAuthToken')) {
      dispatch(Actions.currentUser());
    } else {
      dispatch(routeActions.push('/sign_up'));
    }
  }

  render() {
    const { matches, dispatch } = this.props;

    return (
      <MatchList matches={matches} dispatch={dispatch}/>
    )
  }
}

const mapStateToProps = (state) => {
  const matches = state.matches.matches.map(match => {
    return match;
  });

  return {
    currentUser: state.session.currentUser,
    matches: matches,
  }
};

export default connect(mapStateToProps)(AuthenticatedContainer);
