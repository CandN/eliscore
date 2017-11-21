import React                from 'react';
import PropTypes            from 'prop-types';
import { connect }          from 'react-redux';
import { Link }             from 'react-router';

import { setDocumentTitle, renderErrorsFor } from '../../utils';
import Actions              from '../../actions/sessions';

class SessionsNew extends React.Component {
  componentDidMount() {
    setDocumentTitle('Sign in');
  }

  _handleSubmit(e) {
    e.preventDefault();

    const { dispatch } = this.props;
    const { email, password } = this.refs;

    dispatch(Actions.signIn(email.value, password.value));
  }

  render() {
    const { error } = this.props;

    return (
      <div className="view-container">
        <main>
          <form onSubmit={::this._handleSubmit} className="form-horizontal">
            <div className="form-errors">{error}</div>
            <div className="form-group">
              <input className="form-control" ref="email" type="email" placeholder="Email" required={true} />
            </div>
            <div className="form-group">
              <input className="form-control" ref="password" type="password" placeholder="Password" required={true} />
            </div>
            <div className="signup__button">
              <button className="btn btn-primary btn-signin" type="submit">Sign in</button>
            </div>
          </form>
          <div className="link">
            <Link to="/sign_up">New to Eliscore? Sign up! </Link>
          </div>
        </main>
      </div>
    );
  }
}

const mapStateToProps = (state) => ({
  session: state.session,
  error: state.session.error,
});

export default connect(mapStateToProps)(SessionsNew);
