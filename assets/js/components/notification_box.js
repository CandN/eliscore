import React from 'react'
import PropTypes from 'prop-types'

const NotificationBox = ({ header, body }) => (
  <div className="notification-box">
    <h4 className="notification-box__header">{header}</h4>
    <p className="notification-box__body">{body}</p>
  </div>
)

NotificationBox.propTypes = {
  header: PropTypes.string.isRequired,
  header: PropTypes.string.isRequired,
}

export default NotificationBox
