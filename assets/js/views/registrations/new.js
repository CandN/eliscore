import React                from 'react';
import PropTypes            from 'prop-types';
import { connect }          from 'react-redux';
import { Link }             from 'react-router';
import GoogleLogin          from 'react-google-login';
import googleLogo from '../../../static/images/g-logo.png'

import { setDocumentTitle } from '../../utils';
import Actions              from '../../actions/registrations';

class RegistrationsNew extends React.Component {
  componentDidMount() {
    setDocumentTitle('Login to Eliscore!');
  }

  successResponse({ profileObj }) {
    const { dispatch } = this.props;

    const data = {
      email: profileObj.email,
      uuid: profileObj.googleId,
      full_name: profileObj.name,
      first_name: profileObj.givenName,
      last_name: profileObj.familyName,
      image_url: profileObj.imageUrl
    }
    dispatch(Actions.signUp(data));
  }

  failureResponse() {
  }

  render() {
    const { errors } = this.props;

    return (
      <div className="view-container">
        <main className="google-button-wrapper">
          <GoogleLogin
            clientId="61189001128-f6hlp1hp20aarupukpto32qko966e1n8.apps.googleusercontent.com"
            onSuccess={::this.successResponse}
            onFailure={::this.failureResponse}
            className="google-button"
            buttonText="SIGN IN WITH GOOGLE"
          >
            <img src={googleLogo} className="google-button-logo"/>
            <div class="google-button-text">SIGN IN WITH GOOGLE</div>
          </GoogleLogin>
        </main>
      </div>
    );
  }
}

const mapStateToProps = (state) => ({
  errors: state.registration.errors,
});

export default connect(mapStateToProps)(RegistrationsNew);
