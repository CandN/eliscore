import React            from 'react';
import { connect }      from 'react-redux';
import { routeActions } from 'redux-simple-router';
import Actions          from '../actions/sessions';
import MatchList        from '../components/match_list';
import AddButton        from '../components/add_button';
import NewMatchForm     from '../components/new_match_form';

class AuthenticatedContainer extends React.Component {
  constructor(props) {
    super(props)
    this.state = {
      showForm: false
    }
    this.handleClick = this.handleClick.bind(this);
  }

  componentDidMount() {
    const { dispatch, currentUser } = this.props;

    if (localStorage.getItem('phoenixAuthToken')) {
      dispatch(Actions.currentUser());
    } else {
      dispatch(routeActions.push('/sign_up'));
    }
  }

  handleClick() {
    this.setState({showForm: true});
  }

  render() {
    const { matches, dispatch, users, currentUser} = this.props;

    return (
      <div>
        <MatchList matches={matches} dispatch={dispatch}/>
        <AddButton text="add new match" onclick={this.handleClick}/>
        { this.state.showForm ? <NewMatchForm dispatch={dispatch} users={users} currentUser={currentUser}/> : null }
      </div>
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
    users: state.matches.users,
  }
};

export default connect(mapStateToProps)(AuthenticatedContainer);
