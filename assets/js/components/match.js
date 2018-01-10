import React from 'react'
import PropTypes from 'prop-types'
import Player from './player'
import Separator from './separator'
import Score from './score'

const Match = ({ id, player1, player1_score, player2, player2_score, category_id }) => (
  <div className="score-table__item">
    <div className="match">
      <div className="row match__row">
        <Player id={player1.id} full_name={player1.full_name} />
        <Score score={player1_score} opponentScore={player2_score} />
        <Separator text={"⚔"} category_id={category_id} />
        <Score score={player2_score} opponentScore={player1_score} />
        <Player id={player2.id} full_name={player2.full_name} />
      </div>
    </div>
  </div>
)

Match.propTypes = {
  id: PropTypes.number.isRequired,
  player1_score: PropTypes.number.isRequired,
  player2_score: PropTypes.number.isRequired,
  player1: PropTypes.object.isRequired,
  player2: PropTypes.object.isRequired,
  category_id: PropTypes.number
}

export default Match
