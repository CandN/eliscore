import React from 'react'
import PropTypes from 'prop-types'
import { connect } from 'react-redux'
import { addMatch, postMatch, fetchUsers } from '../actions/index'

export default class NewMatchForm extends React.Component {
  constructor(props) {
    super(props);
  }

  componentWillMount() {
    const { dispatch } = this.props;
    dispatch(fetchUsers());
  }

  render() {
    const { dispatch, users, currentUser } = this.props;

    let player1
    let player1_name
    if (currentUser) {
      player1 = currentUser.id;
      player1_name = currentUser.login;
    }
    let score1
    let player2
    let score2

    return (
      <div className="form-horizontal add-match-form">
        <form onSubmit={e => {
          e.preventDefault()
          dispatch(postMatch(player1, score1.value, player2.value, score2.value))
          player2.value = ''
          score1.value = ''
          score2.value = ''
        }}>
          <div className="row">
            <div className="col-md-6">
              <input type="text" value={player1_name} disabled="true" className="form-control"/>
            </div>
            <div className="col-md-6">
              <select name="player-select" className="form-control col-md-6" ref={node => player2 = node }>
                { users.map(user =>
                  <option key={user.id} value={user.id}>{user.login}</option>
                )}
              </select>
            </div>
          </div>
          <div className="row">
            <div className="col-md-6 text-center">
              <h4>YOUR SCORE</h4>
              <div className="form-group">
                <input placeholder="Enter score" type="number" min="0" step="1" className="form-control" ref={node => { score1 = node }} />
              </div>
            </div>
            <div className="col-md-6 text-center">
              <h4>ENEMY SCORE</h4>
              <div className="form-group">
                <input placeholder="Enter score" type="number" min="0" step="1" className="form-control" ref={node => { score2 = node }} />
              </div>
            </div>
          </div>
          <div className="add-match-form__button">
            <button type="submit" className="btn btn-primary">
              add new game
            </button>
          </div>
        </form>
      </div>
    )
  }
}

NewMatchForm.PropTypes = {
  users: PropTypes.arrayOf(PropTypes.shape({
    id: PropTypes.number.isRequired,
    login: PropTypes.string.isRequired,
    email: PropTypes.string.isRequired
  }).isRequired).isRequired
}
