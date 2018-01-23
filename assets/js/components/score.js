import React from 'react'

class Score extends React.Component {
  render () {
    const { score, opponentScore } = this.props

    let scoreClass
    if (score === opponentScore) {
      scoreClass = 'draw'
    } else if (score < opponentScore) {
      scoreClass = 'lost'
    } else {
      scoreClass = 'win'
    }

    return (
      <div className={'player__score_' + scoreClass + ' col-xs-1 player__score'}>
        {score}
      </div>
    )
  }
}

export default Score
