import React from 'react';
import { Link } from 'react-router';
import Header from '../components/header'

export default class MainLayout extends React.Component {
  constructor() {
    super();
  }

  render() {
    return (
      <div>
        <Header />
        {this.props.children}
      </div>
    );
  }
}
