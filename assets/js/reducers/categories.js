const initialState = {
  categories: [],
};

const categories= (state = initialState, action) => {
  switch(action.type) {
  case 'RECEIVE_CATEGORIES':
    return Object.assign({}, state, {
      categories: action.categories,
    });
  default:
    return state
  }
}

export default categories
