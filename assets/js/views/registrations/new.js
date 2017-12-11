import React                from 'react';
import PropTypes            from 'prop-types';
import { connect }          from 'react-redux';
import { Link }             from 'react-router';
import GoogleLogin          from 'react-google-login';

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
        <main>
          <GoogleLogin
              clientId="61189001128-f6hlp1hp20aarupukpto32qko966e1n8.apps.googleusercontent.com"
              buttonText="Login with Google"
              onSuccess={::this.successResponse}
              onFailure={::this.failureResponse}
            />
        </main>
      </div>
    );
  }
}

const mapStateToProps = (state) => ({
  errors: state.registration.errors,
});

export default connect(mapStateToProps)(RegistrationsNew);
