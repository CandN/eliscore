const match = (state, action) => {
  switch(action.type) {
    case 'ADD_MATCH':
      return {
        id: action.id,
        player1: action.player1,
        player1_score: action.player1_score,
        player2: action.player2,
        player2_score: action.player2_score
      }
    default:
      return state
  }
}

const initialState = {
  matches: [],
  users: [],
};

const matches = (state = initialState, action) => {
  switch(action.type) {
    case 'ADD_MATCH':
      return Object.assign({}, state, {
        matches: [match(undefined, action), ...state.matches]
      });
    case 'RECEIVE_MATCHES':
      return Object.assign({}, state, {
        matches: action.matches,
      });
    case 'RECEIVE_USERS':
      return Object.assign({}, state, {
        users: action.users,
      });
    default:
      return state
  }
}

export default matches
