import React from 'react'
import axios from 'axios'

class Leaderboard extends React.Component {
  constructor (props) {
    super(props)
    this.state = {
      leaderboard: []
    }
  }

  componentDidMount () {
    axios.get('/api/v1/leaderboard/fifa')
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
        <a href="/leaderboard/fifa">Fifa</a>
        <a href="/leaderboard/fusball">Fusball</a>
      </div>
    )
  }
}

export default Leaderboard
