import React from 'react'
import PropTypes from 'prop-types'
import { postMatch, fetchUsers, fetchCategories } from '../actions/index'
import _ from 'lodash'

export default class NewMatchForm extends React.Component {
  constructor (props) {
    super(props)
  }

  render () {
    const { dispatch, users, currentUser, categories } = this.props

    let player1_id
    let player1_name
    if (currentUser) {
      player1_id = currentUser.id;
      player1_name = currentUser.full_name;
    }
    let score1
    let player2_id
    let score2
    let category_id
    let enemyName = _.sample(
      ['foe', 'adversary', 'opponent', 'rival', 'nemesis', 'antagonist', 'combatant', 'challenger', 'competitor', 'gdynianin']
    )

      return (
        <div className="form-horizontal add-match-form animated tada">
          <form onSubmit={e => {
              e.preventDefault()
              dispatch(postMatch(player1_id, score1.value, player2_id.value, score2.value, category_id.value))
              player2_id.value = ''
              category_id.value = ''
              score1.value = ''
              score2.value = ''
          }}>
            <div className="row">
              <div className="col-md-6">
                <input type="text" value={player1_name} disabled="true" className="form-control"/>
              </div>
              <div className="col-md-6">
                <select name="player-select" className="form-control col-md-6" ref={node => player2_id = node }>
                  { users.map(user =>
                    <option key={user.id} value={user.id}>{user.full_name}</option>
                  )}
                </select>
              </div>
            </div>

            <div className="row">
              <div className="col-md-6 text-center">
                <h4>yourscore</h4>
                <div className="form-group">
                  <input placeholder="Enter score" type="number" min="0" step="1" className="form-control" ref={node => { score1 = node }} />
                </div>
              </div>
              <div className="col-md-6 text-center">
                <h4>your {enemyName} score</h4>
                <div className="form-group">
                  <input placeholder="Enter score" type="number" min="0" step="1" className="form-control" ref={node => { score2 = node }} />
                </div>
              </div>
            </div>

            <div className="row">
              <div className="add-match-form__category">
                <select name="category-select" className="form-control col-md-6" ref={node => category_id = node }>
                  {
                    _.values(categories).map(category =>
                      <option key={category.id} value={category.id}>{category.name}</option>
                    )
                  }
                </select>
              </div>
            </div>

            <div className="row">
              <div className="add-match-form__button_div">
                <button type="submit" className="add-match-form__button btn">
                  add new game
                </button>
              </div>
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
