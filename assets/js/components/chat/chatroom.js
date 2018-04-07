import React from 'react'
import PropTypes from 'prop-types'

class Chatroom extends React.Component {
  constructor(props) {
    super(props)

    this.channel = null;

    this.state = {
      opened: true,
      connected: false,
      messages: [],
    }
  }

  componentWillMount() {
    const { id, socket } = this.props
    this.channel = socket.channel(`chatrooms:${id}`)
    let that = this;
    this.channel.on('new_message', response => {
      let messages = this.state.messages
      messages.push(this.parseMessages([response])[0])
      this.setState({ messages: messages })
    })
    this.channel.join()
      .receive('ok', response => {
        let messages = this.parseMessages(response.messages)
        this.setState({ messages: messages })
      })
  }

  parseMessages(messages) {
    return messages.map(message => {
      return {
        id: message.id,
        body: message.body,
        author_id: message.author_id,
        timestamp: message.timestamp
      }
    })
  }

  toggle() {
    this.setState({ opened: !this.state.opened })
  }

  leaveChatroom() {
    const { id, onLeave } = this.props
    onLeave(id, this.channel)
  }

  renderMessage({ id, body, author_id, timestamp }) {
    const { findUser } = this.props
    let authorName = findUser(author_id)
    return (
      <div key={id} className="chatroom__message" ref={el => { this.el = el; }}>
        <div className="chatroom__message-author">{ authorName }: </div>
        <div className="chatroom__message-body">{ body }</div>
      </div>
    )
  }

  componentDidUpdate() {
    if(this.el) {
      this.el.scrollIntoView({ behavior: 'smooth' });
    }
  }

  onMessageSend(event) {
    if(event.key == 'Enter' && event.target.value) {
      this.channel.push('new_message', { body: event.target.value })
      event.target.value = ''
    }
  }

  render() {
    const { name, id } = this.props

    return (
      <div className="chat-room" key={id}>
        <div className="chat-header" onClick={this.toggle.bind(this)}>{ name }</div>
        <div className="chat-leave" onClick={() => this.leaveChatroom()}>x</div>
        { this.state.opened &&
          <div className="chat-messages">
            { this.state.messages.map(message =>
              this.renderMessage(message)
            )}
          </div>
        }
        { this.state.opened &&
          <input type="text" className="chat-input" onKeyPress={(event) => this.onMessageSend(event)} />
        }
      </div>
    )
  }
}

Chatroom.propTypes = {
  id: PropTypes.number.isRequired,
}

export default Chatroom
