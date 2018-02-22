import React from 'react'
import moment from 'moment'

class Timer extends React.Component {
  state = { date: Date.now() }

  componentWillMount () {
    this.interval = window.setInterval(() => {
      this.setState({ date: Date.now() })
    }, 1000)
  }

  componentWillUnmount () {
    window.clearInterval(this.interval)
  }

  showDate (difference, d, h, m, s) {
    if (difference > 0) {
      return `${d}d ${h}h ${m}m ${s}s left untill next TOURNAMENT`
    } else {
      return 'EXPIRED'
    }
  }

  render () {
    const date = new Date(this.state.date)
    const startDate = new Date(this.props.startDate)
    const difference = Math.floor(startDate.getTime() - date.getTime())
    let {days, hours, minutes, seconds} = moment.duration(difference)._data

    return(
      <div>
        {this.showDate(difference, days, hours, minutes, seconds)}
      </div>
    )
  }
}

export default Timer
