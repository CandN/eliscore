import React                from 'react';
import PropTypes            from 'prop-types';
import { connect }          from 'react-redux';
import { Link }             from 'react-router';

import { setDocumentTitle, renderErrorsFor } from '../../utils';
import Actions              from '../../actions/registrations';

class RegistrationsNew extends React.Component {
  componentDidMount() {
    setDocumentTitle('Sign up');
  }

  _handleSubmit(e) {
    e.preventDefault();

    const { dispatch } = this.props;

    const data = {
      login: this.refs.login.value,
      email: this.refs.email.value,
      password: this.refs.password.value,
      password_confirmation: this.refs.passwordConfirmation.value,
    };

    dispatch(Actions.signUp(data));
  }

  render() {
    const { errors } = this.props;

    return (
      <div className="view-container">
        <main>
          <form onSubmit={::this._handleSubmit} className="form-horizontal">
            <div className="form-errors">{errors}</div>
            <div className="form-group">
              <input className="form-control" ref="login" type="text" placeholder="Login" required={true} />
            </div>
            <div className="form-group">
              <input className="form-control" ref="email" type="email" placeholder="Email" required={true} />
            </div>
            <div className="form-group">
              <input className="form-control" ref="password" type="password" placeholder="Password" required={true} />
            </div>
            <div className="form-group">
              <input className="form-control" ref="passwordConfirmation" type="password" placeholder="Confirm password" required={true} />
            </div>
            <button className="btn btn-primary" type="submit">Sign up</button>
          </form>
          <div className="link">
            <Link to="/sign_in">Already have an account? Sign in! </Link>
          </div>
        </main>
      </div>
    );
  }
}

const mapStateToProps = (state) => ({
  errors: state.registration.errors,
});

export default connect(mapStateToProps)(RegistrationsNew);
