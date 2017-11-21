import chai, { expect } from 'chai';
import reducers from '../../reducers/matches';

describe('matches reducers test', () => {
  const initialState = { matches: [], users: [] }

  it('returns the initial state', () => {
    const matchesReducer = reducers(undefined, {})
    expect(matchesReducer).deep.equal(initialState);
  });

  it('adds match to matches array', () => {
    const match = { id: 1, player1: 'marton', player1_score: 2, player2: 'martoff', player2_score: 3 }
    const matchesReducer = reducers(undefined, { type: 'ADD_MATCH', ...match })
    expect(matchesReducer.matches.length).to.equal(1);
  });

  it('returns fetched matches', () => {
    const match = { id: 2, player1: 'marton', player1_score: 2, player2: 'martoff', player2_score: 3 }
    const matches = [ match ]
    const matchesReducer = reducers(undefined, { type: 'RECEIVE_MATCHES', matches })
    expect(matchesReducer.matches.length).to.equal(1);
    const matchesReducer1 = reducers(undefined, { type: 'RECEIVE_MATCHES', matches: [] })
    expect(matchesReducer1.matches.length).to.equal(0);
  });

  it('returns fetched users', () => {
    const user = { id: 1, username: 'marton' }
    const users = [ user ]
    const matchesReducer = reducers(undefined, { type: 'RECEIVE_USERS', users })
    expect(matchesReducer.users.length).to.equal(1);
    const matchesReducer1 = reducers(undefined, { type: 'RECEIVE_USERS', users: [] })
    expect(matchesReducer1.users.length).to.equal(0);
  });
});
