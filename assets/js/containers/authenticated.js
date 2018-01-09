import React            from 'react';
import { connect }      from 'react-redux';
import { routeActions } from 'react-router-redux';
import Actions          from '../actions/sessions';
import MatchList        from '../components/match_list';
import AddButton        from '../components/add_button';
import NewMatchForm     from '../components/new_match_form';
import { fetchMatches } from '../actions/index'
import { fetchCategories } from '../actions/index'

class AuthenticatedContainer extends React.Component {
  constructor(props) {
    super(props)
    this.state = {
      showForm: false
    }
    this.handleClick = this.handleClick.bind(this);
  }

  componentWillMount() {
    const { dispatch } = this.props;
    dispatch(fetchMatches());
    dispatch(fetchCategories());
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
    this.setState({showForm: !this.state.showForm});
    window.scrollTo(0, 0)
  }

  render() {
    const { matches, categories, dispatch, users, currentUser} = this.props;

    return (
      <div>
        <AddButton text="add new match" onclick={this.handleClick}/>
        { this.state.showForm ? <NewMatchForm dispatch={dispatch} users={users} currentUser={currentUser} categories={categories}/> : null }
        <MatchList matches={matches} categories={categories}/>
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
    categories: state.categories.categories,
    users: state.matches.users,
  }
};

export default connect(mapStateToProps)(AuthenticatedContainer);
