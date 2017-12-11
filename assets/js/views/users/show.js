import React                from 'react';
import { connect }          from 'react-redux';
import { setDocumentTitle } from '../../utils';
import Actions              from '../../actions/users';

class UserShow extends React.Component {
  componentDidMount() {
    const { dispatch, params: {username} } = this.props;
    setDocumentTitle(`${username} - profile`);
    dispatch(Actions.fetchUser(username));
  }

  render() {
    const { user } = this.props;

    return (
      <div className="user">
        <div className="user__name">{user.login}</div>
        <div className="user__email">{user.email}</div>
        <div className="user__avatar">
          <img src={user.image_url}/>
        </div>
      </div>
    );
  }
}

const mapStateToProps = (state) => ({
  user: state.users.user
});

export default connect(mapStateToProps)(UserShow);
