import React                from 'react';
import { connect }          from 'react-redux';
import { setDocumentTitle } from '../../utils';


class IndexView extends React.Component {
  componentDidMount() {
    setDocumentTitle('Home');
  }

  render() {
    return (
      <div>
        hello
      </div>
    )
  }
}

const mapStateToProps = (state) => (
  matches: state.matches;
);

export default connect(mapStateToProps)(IndexView);
