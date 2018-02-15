import React from 'react'
import PropTypes from 'prop-types'
import { Socket, Presence } from 'phoenix'
import { connect } from 'react-redux'
import axios from 'axios'

class EliscoreChat extends React.Component {
  constructor(props) {
    super(props)

    this.channel = null
    this.state = {
      opened: false,
      presences: {},
      chatrooms: {},
      messages: {},
    }
  }

  renderOnlineUsers() {
    let array = []
    Presence.list(this.state.presences, (id, {metas: [first, ...rest]}) => {
      array.push(id)
    });
    return array;
  }

  openChat() {
    const { socket } = this.props;
    if(this.channel === null) {
      this.channel = socket.channel('chat')
      this.channel.on("presence_state", state => {
          let presences = Presence.syncState(this.state.presences, state)
          this.setState({ presences: presences })
          this.renderOnlineUsers(presences)
      })

      this.channel.on("presence_diff", diff => {
          let presences = Presence.syncDiff(this.state.presences, diff)
          this.setState({ presences: presences })
          this.renderOnlineUsers(presences)
      })
      this.channel.join()
        .receive("ok", resp => { console.log("Joined successfully", resp) })
        .receive("error", resp => { console.log("Unable to join", resp) })
    }
    this.setState({opened: !this.state.opened})
  }

  newMessage({ body, author, timestamp }) {
    return (
      <div key={timestamp} className="chat-message">
        <span className="message-author">{author}: </span>
        <span className="message-body">{body}</span>
      </div>
    )
  }

  handleKeyPress(event, user) {
    let channel = this.state.chatrooms[user]
    if(event.key == 'Enter') {
      channel.push("new_message", { body: event.target.value})
      event.target.value = ''
    }
  }

  renderSingleChatroom(user) {
    return (
      <div
        className="chat-room"
        key={user}>
        <div className="divider">Talking with: {user}</div>
        <div
          className="chat-messages"
          id={user}
          >
          { this.state.messages[user].map(message =>
            this.newMessage(message)
          )}
        </div>
        <input type="text" className="chat-input" onKeyPress={(event) => this.handleKeyPress(event, user)}/>
      </div>
    )
  }

  renderRooms() {
    let rooms = Object.keys(this.state.chatrooms).map(room =>
      this.renderSingleChatroom(room)
    )
    return rooms
  }

  openChatroom(user) {
    if(Object.keys(this.state.chatrooms).includes(user)) {
      return;
    }
    console.log(user);

    axios.get("/api/v1/channel")
      .then((response) => {
        const { currentUser, socket } = this.props;
        let rooms = this.state.chatrooms;
        let channel = socket.channel(`rooms:${response.data.data.id}`)
        channel.on("new_message", body => {
          let messages = this.state.messages
          messages[user].push(body)
          this.setState({ messages: messages })
        })
        channel.join()
          .receive("ok", resp => { console.log("Joined successfully", resp) })
          .receive("error", resp => { console.log("Unable to join", resp) })
        rooms[user] = channel
        let messages = this.state.messages
        messages[user] = []
        this.setState({chatrooms: rooms, messages: messages})
      })

    return;
  }

  renderUserList() {
    let users = this.renderOnlineUsers()

    return (
      <ul className="chat-userlist">
        { users.map(user =>
          <li
            className="chat-user"
            onClick={() => this.openChatroom(user)}
            key={user}>
            {user}
          </li>
        )}
      </ul>
    )
  }

  renderChat() {
    let classname = this.state.opened ? 'chat-wrapper chat-wrapper--opened' : 'chat-wrapper'

    return (
      <div className={classname}>
        <div>Click to open chat</div>
        { this.state.opened && this.renderUserList() }
        <input type="submit" onClick={this.openChat.bind(this)} value="Join chat!"/>
      </div>
    )
  }

  render() {
    return (
      <div className="chatrooms">
        {this.renderChat()}
        {this.renderRooms()}
      </div>
    )
  }
}

const mapStateToProps = (state, ownProps) => {
  return {
    socket: state.session.socket,
    currentUser: state.session.currentUser
  }
}

export default connect(mapStateToProps)(EliscoreChat);
