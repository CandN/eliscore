import React from 'react'
import PropTypes from 'prop-types'

class UserList extends React.Component {
  constructor(props) {
    super(props)
  }

  isOnline(user_id) {
    const { onlineUsers } = this.props
    let asd = onlineUsers.find(user => {
      return user.id == user_id.id
    })

    return asd !== undefined ? 'user-list__user--active' : null
  }

  render() {
    const { users, onClick, onlineUsers } = this.props

    return (
      <ul className="user-list">
        { users.map(user =>
          <li
            className={`user-list__user ${this.isOnline(user)}`}
            key={user.id}
            onClick={() => onClick(user.id)}>
            { user.full_name }
          </li>
        )}
      </ul>
    )
  }
}

UserList.propTypes = {
  onClick: PropTypes.func.isRequired,
  onlineUsers: PropTypes.array.isRequired,
  users: PropTypes.array.isRequired
}

export default UserList
