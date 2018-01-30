import React from 'react';
import axios from 'axios';

class Leaderboard extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      leaderboard: [],
    }
  }

  componentDidMount() {
    axios.get('/api/v1/leaderboard')
      .then(response => {
        let players = response.data.data;
        this.setState({ leaderboard: players });
      })
      .catch(error => {
        console.log(error);
      });
  }

  render() {
    return (
      <div className='leaderboard'>
        <ul className='leaderboard__players-list'>
          { this.state.leaderboard.map((player, i) => {
              return (
                <li key={i} className="leaderboard__player">
                  <span className='leaderboard__position'>{i + 1}</span>
                  {player.full_name}, games won: {player.wins}
                </li>
              )
            })
          }
        </ul>
      </div>
    );
  }
}

export default Leaderboard;
