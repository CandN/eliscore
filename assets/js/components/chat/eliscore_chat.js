import React from 'react'
import PropTypes from 'prop-types'
import Chatroom from 'chatroom'

class EliscoreChat extends React.Component {
  constructor(props) {
    super(props)

    this.state = {
      opened: false,
      connected: false,
      chatrooms: [],
    }
  }

  toggle() {
    this.setState({ opened: !this.state.opened })
  }

  renderChatrooms() {
    this.state.chatrooms.map(chatroom => {
      <Chatroom />
    })
  }

  render() {
    const { name } = this.props
    const classNames = this.state.opened ? 'chatroom chatoom--opened' : 'chatroom'

    return (
      <div className="eliscore-chat">
      </div>
    )
  }
}

EliscoreChat.propTypes = {
  ws: PropTypes.string.isRequired,
  resource: PropTypes.object.isRequired,
}

export default Chatroom
