import React from 'react'
import PropTypes from 'prop-types'

const ChatConnect = ({ onClick, value }) => (
  <div className="eliscore-chat__join-btn" onClick={onClick}>{ value }</div>
)

ChatConnect.propTypes = {
  onClick: PropTypes.func.isRequired,
  value: PropTypes.string.isRequired,
}

export default ChatConnect
