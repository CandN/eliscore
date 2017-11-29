import React from 'react'
import PropTypes from 'prop-types'

class Player extends React.Component {
  constructor(props) {
    super(props);
  }

  render() {
    const { full_name } = this.props;
      return (
          <div className="player player__name col-xs-3 ">
            <a href={`/users/${full_name}`}>{full_name}</a>
          </div>
      ) 
  }
}

Player.propTypes = {
  full_name: PropTypes.string.isRequired,
}

export default Player
