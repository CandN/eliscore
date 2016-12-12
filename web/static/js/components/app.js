import React, { PropTypes } from 'react'
import AddButton from './add_button'
import Title from './title'
import Match from './match'
import MatchList from './match_list'
import AddMatchContainer from '../containers/add_match_container'
import MatchListContainer from '../containers/match_list_container'

const App = () => (
  <div>
    <Title text="YOUR LAST GAMES"/>
    <MatchListContainer />
    <AddButton text="add new game" />
    <AddMatchContainer />
  </div>
)

export default App
