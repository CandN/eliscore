import { IndexRoute, Route }        from 'react-router';
import React                        from 'react';
import MainLayout                   from '../layouts/main';
import AuthenticatedContainer       from '../containers/authenticated';
import RegistrationsNew             from '../views/registrations/new';

export default (
  <Route component={MainLayout}>
    <Route path="/sign_up" component={RegistrationsNew} />

    <Route path="/" component={AuthenticatedContainer}>
    </Route>
  </Route>
);
