import React, {PropTypes}   from 'react';
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
    const { errors } = this.props;

    return (
      <div className="view-container">
        <main>
          <header>
            <div className="logo" />
          </header>
          <form onSubmit={::this._handleSubmit} className="form-horizontal">
            <div className="form-group">
              <input className="form-control" ref="email" type="email" placeholder="Email" required={true} />
              {renderErrorsFor(errors, 'email')}
            </div>
            <div className="form-group">
              <input className="form-control" ref="password" type="password" placeholder="Password" required={true} />
              {renderErrorsFor(errors, 'password')}
            </div>
            <div className="signup__button">
              <button className="btn btn-primary btn-signin" type="submit">Sign in</button>
            </div>
          </form>
        </main>
      </div>
    );
  }
}

const mapStateToProps = (state) => ({
  session: state.session,
});

export default connect(mapStateToProps)(SessionsNew);
