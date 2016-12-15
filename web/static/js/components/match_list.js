import React, { PropTypes } from 'react'
import Match from './match'
import { fetchMatches } from '../actions/index'

class MatchList extends React.Component {
  constructor(props) {
    super(props);
  }

  componentWillMount() {
    const { dispatch } = this.props;
    dispatch(fetchMatches());
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
    player2_score: PropTypes.number.isRequired
 }).isRequired).isRequired
}

export default MatchList