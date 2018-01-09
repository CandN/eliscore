import React from 'react'
import PropTypes from 'prop-types'
import Match from './match'

class MatchList extends React.Component {
  constructor(props) {
    super(props);
  }

  render() {
    const { matches } = this.props;

    return (
      <div>
        { matches.map(match =>
          <Match key={match.id} {...match} />
          )}
      </div>
    )
  }
}

MatchList.propTypes = {
  matches: PropTypes.arrayOf(PropTypes.shape({
    id: PropTypes.number.isRequired,
    player1: PropTypes.object.isRequired,
    player1_score: PropTypes.number.isRequired,
    player2: PropTypes.object.isRequired,
    player2_score: PropTypes.number.isRequired,
    category_id: PropTypes.number,
  }).isRequired).isRequired
}

export default MatchList
