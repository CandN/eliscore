import React from 'react'
import PropTypes from 'prop-types';
import Player from './player'
import Separator from './separator'

const Match = ({ id, player1, player1_score, player2, player2_score }) => (
  <div className="score-table__item">
    <div className="match">
      <div className="row match__row">
        <Player score={player1_score} nickname={player1.full_name} position="left" />
        <Separator text="⚔" />
        <Player score={player2_score} nickname={player2.full_name} position="right" />
      </div>
    </div>
  </div>
)

Match.propTypes = {
  id: PropTypes.number.isRequired,
  player1_score: PropTypes.number.isRequired,
  player2_score: PropTypes.number.isRequired,
  player1: PropTypes.object.isRequired,
  player2: PropTypes.object.isRequired
}

export default Match
