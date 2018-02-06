import React from 'react'
import axios from 'axios'

class LeaderboardFusball extends React.Component {
  constructor (props) {
    super(props)
    this.state = {
      leaderboard: []
    }
  }

  componentDidMount () {
    axios.get('/api/v1/leaderboard/fusball')
      .then(response => {
        let players = response.data.data
        this.setState({ leaderboard: players })
      })
      .catch(error => {
        console.log(error)
      })
  }

  render () {
    return (
      <div className='leaderboard'>
        <div className='row'>
          <table>
            <thead>
              <tr className='leaderboard__players-list'>
                <th></th>
                <th>Name</th>
                <th>Played</th>
                <th>Won</th>
                <th>Lost</th>
                <th>Points</th>
              </tr>
            </thead>
            <tbody>
              { this.state.leaderboard.map((player, i) => {
                return (
                  <tr key={i} className="leaderboard__player">
                    <td className='leaderboard__position'>{i + 1}</td>
                    <td>{player.full_name}</td>
                    <td>{player.all_games}</td>
                    <td>{player.wins}</td>
                    <td>{player.loses}</td>
                    <td>{player.points}</td>
                  </tr>
                )
              })}
            </tbody>
          </table>
        </div>
        <div className='row'>
          <a href="/leaderboard">Go Back</a>
        </div>
      </div>
    )
  }
}

export default LeaderboardFusball
