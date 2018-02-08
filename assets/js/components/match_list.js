import React from 'react'
import PropTypes from 'prop-types'
import Match from './match'
import Pagination from './pagination'

class MatchList extends React.Component {
  constructor(props) {
    super(props);
    
    this.state = {
      currentPage: 1,
      itemsPerPage: 3,
    }
  }
  
  setPage = page => this.setState({ currentPage: page });

  render() {
    const { matches } = this.props;
    const {
      currentPage,
      itemsPerPage,
    } = this.state;
     
    const indexOfLastMatch = currentPage * itemsPerPage;
    const indexOfFirstMatch = indexOfLastMatch - itemsPerPage;
    
    const currentMatches = matches.slice(indexOfFirstMatch, indexOfLastMatch);

    return (
      <div>
        { currentMatches.map(match =>
          <Match key={match.id} {...match} />
          )}
        <Pagination
          itemsCount={matches.length}
          itemsPerPage={itemsPerPage}
          setPage={this.setPage}
          currentPage={currentPage} 
        />
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
