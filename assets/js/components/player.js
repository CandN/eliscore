import React from 'react'
import PropTypes from 'prop-types'

const Player = ({ id, full_name }) => (
  <div className="player player__name col-xs-3 ">
    <a href={`/users/${id}`}>{full_name}</a>
  </div>
)

Player.propTypes = {
  id: PropTypes.number.isRequired,
  full_name: PropTypes.string.isRequired,
}

export default Player
