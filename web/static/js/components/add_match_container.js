import React, { PropTypes } from 'react'
import { connect } from 'react-redux'
import { addMatch, postMatch, fetchUsers } from '../actions/index'

class AddMatchContainer extends React.Component {
  constructor(props) {
    super(props);
  }

  componentWillMount() {
    const { dispatch } = this.props;
    dispatch(fetchUsers());
  }

  render() {
    const { dispatch, users } = this.props;

    let player1
    let score1
    let player2
    let score2

    return (
      <div className="form" style={{marginTop: '50px', marginBottom: '150px'}}>
        <form onSubmit={e => {
          e.preventDefault()
          dispatch(postMatch(player1.value, score1.value, player2.value, score2.value))
          player1.value = ''
          player2.value = ''
          score1.value = ''
          score2.value = ''
        }}>
          Player1:
            <select className="form-control" ref={node => player1 = node }>
              { users.map(user =>
                <option key={user.id} value={user.id}>{user.login}</option>
              )}
            </select>
          Score:<input className="form-control" ref={node => { score1 = node }} />
          Player2:
            <select className="form-control" ref={node => player2 = node }>
              { users.map(user =>
                <option key={user.id} value={user.id}>{user.login}</option>
              )}
            </select>
          Score:<input className="form-control" ref={node => { score2 = node }} />
          <button type="submit">
            add new game
          </button>
        </form>
      </div>
    )
  }
}

AddMatchContainer.PropTypes = {
  users: PropTypes.arrayOf(PropTypes.shape({
    id: PropTypes.number.isRequired,
    login: PropTypes.string.isRequired,
    email: PropTypes.string.isRequired
  }).isRequired).isRequired
}


const mapStateToProps = (state) => {
  return {
    matches: state.matches,
    users: state.matches.users
  }
}
/*
          Player1: <select className="form-control"
          <input className="form-control" ref={node => { player1 = node }} />

*/
AddMatchContainer = connect(mapStateToProps)(AddMatchContainer)

export default AddMatchContainer
