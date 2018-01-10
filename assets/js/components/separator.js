import React from 'react';
import PropTypes from 'prop-types';
import { connect } from 'react-redux';

const Separator = ({ text, categories, category_id }) => (
  <div className="col-xs-2">
    <div className="match__separator">
      {text}
    </div>
    <div className="match__category">
      {category_id ? categories[parseInt(category_id)].name : ""}
    </div>
  </div>

);

const mapStateToProps = (state, ownProps) => {
  return {
    categories: state.categories.categories
  }
}

export default connect(mapStateToProps)(Separator)
