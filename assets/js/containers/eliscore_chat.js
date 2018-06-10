import React from 'react'
import PropTypes from 'prop-types'
import { Presence } from 'phoenix'
import { connect } from 'react-redux'
import axios from 'axios'
import ChatConnect from '../components/chat/connect_chat'
import Chatroom from '../components/chat/chatroom'
import UserList from '../components/chat/users_list'

import { connectSocket } from '../actions/index';

class EliscoreChat extends React.Component {
  constructor(props) {
    super(props)

    this.channel = null
    this.userChannel = null
    this.state = {
      joined: false,
      opened: false,
      presences: {},
      chatrooms: [],
      messages: {},
    }
  }

  componentDidMount() {
    const { dispatch } = this.props
    let socket_url = "/socket";
    dispatch(connectSocket(socket_url));
  }

  renderOnlineUsers() {
    let array = []
    Presence.list(this.state.presences, (id, {metas: [first, ...rest]}) => {
      array.push({ id: first.id, full_name: first.full_name })
    });
    return array;
  }

  openChat() {
    const { currentUser, socket } = this.props;
    if(this.channel === null) {
      this.channel = socket.channel('chatrooms:lobby')
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
    if(this.userChannel === null) {
      this.userChannel = socket.channel(`users:${currentUser.id}`)
      this.userChannel.on("open_room", payload => {
        //this.joinSingleChatroom(payload.user_id, payload.chatroom_id)
        let rooms = this.state.chatrooms
        rooms.push({ id: payload.chatroom_id, user_id: payload.user_id, name: this.findUser(payload.user_id) })
        this.setState({chatrooms: rooms})
      })
      this.userChannel.join()
        .receive("ok", resp => { console.log("Joined successfully", resp) })
        .receive("error", resp => { console.log("Unable to join", resp) })
    }
    this.setState({opened: !this.state.opened, joined: true})
  }


  leaveChatroom(chatroom_id, channel) {
    channel.leave()
    let chatrooms = this.state.chatrooms;
    let room = chatrooms.find((c) => c.id == chatroom_id)
    let index = chatrooms.indexOf(room)
    delete chatrooms[index]
    this.setState({chatrooms: chatrooms})
  }

  renderRooms() {
    const { socket } = this.props

    return this.state.chatrooms.map(room =>
      <Chatroom
        key={room.user_id}
        socket={socket}
        name={room.name}
        messages={this.state.messages[room.user_id] || []}
        id={room.id}
        findUser={this.findUser.bind(this)}
        onLeave={this.leaveChatroom.bind(this)} />
    )
  }

  newMessage({ timestamp, body, author_id }) {
    const author = this.findUser(author_id);

    return {
      timestamp: timestamp,
      body: body,
      author: author
    }
  }

  openChatroom(user_id) {
    const { currentUser, socket } = this.props

    if(currentUser.id == user_id) {
      return;
    }

    let users = [currentUser.id, user_id]
    let openedChatroomsIds = this.state.chatrooms.map((e) => e.id )
    this.channel.push("chatrooms:open", { body: users })
    .receive("ok", (reply) => {
      if(openedChatroomsIds.includes(reply.id)) {
        return;
      }
      let rooms = this.state.chatrooms
      rooms.push({ id: reply.id, user_id: user_id, name: this.findUser(user_id) })
      this.setState({chatrooms: rooms})
    })
    return;
  }

  findUser(user_id) {
    const { users } = this.props
    let user = users.find(user => {
      return user.id == user_id
    })
    return user.full_name;
  }

  renderUserList() {
    let onlineUsers= this.renderOnlineUsers();
    const { users } = this.props

    return (
      <ul className="chat-userlist">
        <h4>Currently online:</h4>
        { users.map(user =>
          <li
            className="chat-user"
            onClick={() => this.openChatroom(user.id)}
            key={user.id}>
            {user.full_name}
          </li>
        )}
      </ul>
    )
  }

  toggleChat() {
    this.setState({ opened: !this.state.opened })
  }

  renderChat() {
    let classname = this.state.opened ? 'chat-wrapper chat-wrapper--opened' : 'chat-wrapper'
    let onlineUsers = this.renderOnlineUsers();
    const { users } = this.props

    return (
      <div className={classname}>
        { this.state.joined && <div
          className="chat-wrapper__header"
          onClick={this.toggleChat.bind(this)}>EliscoreChat</div> }
        { this.state.opened && <UserList users={users} onClick={this.openChatroom.bind(this)} onlineUsers={onlineUsers} /> }
        { !this.state.joined && <ChatConnect onClick={this.openChat.bind(this)} value="Connect to chat!" /> }
      </div>
    )
  }

  render() {
    return (
      <div className="eliscore-chat chatrooms">
        {this.renderChat()}
        {this.renderRooms()}
      </div>
    )
  }
}

const mapStateToProps = (state, ownProps) => {
  return {
    users: state.matches.users,
    socket: state.chat.socket,
    currentUser: state.session.currentUser
  }
}

export default connect(mapStateToProps)(EliscoreChat);
