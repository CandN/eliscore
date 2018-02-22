import React from 'react'
import { Link } from 'react-router'
import { connect } from 'react-redux'
import { fetchTournamentDate } from '../actions/index'
import Timer from './timer.js'

class Header extends React.Component {
  componentWillMount () {
    this.props.fetchTournamentDate()
  }

  render () {
    const { date } = this.props

    return (
      <div className="header">
        <ul className="menu nav nav-pills">
          <li className="logo menu__item menu__item--left active">
            <Link to="/">eliscore</Link>
          </li>
          <li className="menu__item">
            <Link to="/leaderboard" className="menu__item__link">
              Leaderboards
            </Link>
          </li>
          <li className="menu__item">
            <Link to="/#" className="menu__item__link">
              Profile
            </Link>
          </li>
          <li className="menu__item">
            <Link to="/live" className="menu__item__link">
              Live Game
            </Link>
          </li>
          <li className="menu__item menu__item--left timer">
            <Timer startDate={date}/>
          </li>
        </ul>
      </div>
    )
  }
}

const mapStateToProps = (state) => {
  return { date: state.tournamentDate }
}
const mapDispatchToProps = {
  fetchTournamentDate
}

export default connect(mapStateToProps, mapDispatchToProps)(Header)
