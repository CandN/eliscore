import React        from 'react';
import ReactDOM     from 'react-dom';
import fetch        from 'isomorphic-fetch';
import { polyfill } from 'es6-promise';

import NotificationBox from '../components/notification_box';

const defaultHeaders = {
  Accept: 'application/json',
  'Content-Type': 'application/json',
};

export function buildHeaders() {
  const authToken = localStorage.getItem('phoenixAuthToken');

  return { ...defaultHeaders, Authorization: `Bearer: ${authToken}` };
}

export function checkStatus(response) {
  if (response.status >= 200 && response.status < 300) {
    return response;
  } else {
    var error = new Error(response.statusText);
    error.response = response;
    throw error;
  }
}

export function parseJSON(response) {
  return response.json();
}

export function httpGet(url) {

  return fetch(url, {
    headers: buildHeaders(),
  })
  .then(checkStatus)
  .then(parseJSON);
}

export function httpPost(url, data) {
  const body = JSON.stringify(data);

  return fetch(url, {
    method: 'post',
    headers: buildHeaders(),
    body: body,
  })
  .then(checkStatus)
  .then(parseJSON);
}

export function httpDelete(url) {

  return fetch(url, {
    method: 'delete',
    headers: buildHeaders(),
  })
  .then(checkStatus)
  .then(parseJSON);
}

export function setDocumentTitle(title) {
  document.title = `${title} | Eliscore`;
}

export function renderErrorsFor(errors, ref) {
  if (!errors) return false;

  return errors.map((error, i) => {
    if (error[ref]) {
      return (
        <div key={i} className="error">
          {error[ref]}
        </div>
      );
    }
  });
}

export function notify(header, body) {
  let target = document.getElementById('notify-wrapper');
  ReactDOM.render(<NotificationBox header={header} body={body} />, target);
}
