import React        from 'react';
import { connect }  from 'react-redux';
import { routeActions } from 'redux-simple-router';

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
      <b>Here is AuthenticatedContainer</b>
  }
}

const mapStateToProps = (state) => ({
  currentUser: state.session.currentUser,
});

export default connect(mapStateToProps)(AuthenticatedContainer);
