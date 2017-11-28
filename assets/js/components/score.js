import React from 'react'
import PropTypes from 'prop-types'

const Score = ({ score }) => (
  <div className="player__score col-xs-1">
    {score}
  </div>
)

Score.propTypes = {
  score: PropTypes.number.isRequired,
}

export default Score
