import React from 'react';
import axios from 'axios';

class Leaderboard extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      leaderboard: ['Artur', 'Siepet', 'Robcio'],
    }
  }

  render() {
    return (
      <div>
        <h2>Leaderboard</h2>
        <ul className="leaderboard">
          { this.state.leaderboard.map(function(player) {
              return <li className="leaderboard__player">{player}</li>;
            })
          }
        </ul>
      </div>
    );
  }
}

export default Leaderboard;
