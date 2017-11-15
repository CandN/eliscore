import React, { PropTypes } from 'react'

class Player extends React.Component {
  constructor(props) {
    super(props);
  }

  render() {
    const { score, nickname, position } = this.props;

    return (
      <div className="col-xs-5">
        <div className={`player player--${position}`}>
          <div className={`player__score player__score--${position}`}>{score}</div>
          <div className={`player__name player__name--${position}`}>
              <a href={`/users/${nickname}`}>{nickname}</a>
            </div>
        </div>
      </div>
    )
  }
}

Player.propTypes = {
  score: PropTypes.number.isRequired,
  nickname: PropTypes.string.isRequired,
  position: PropTypes.string.isRequired
}

export default Player
