import { addMatch, postMatch,
  fetchUsers,
  fetchMatches } from '../../actions';

import chai, { expect, assert } from 'chai';
import chaiEnzyme from 'chai-enzyme';
import configureStore from 'redux-mock-store';
import thunk from 'redux-thunk';
import sinon from 'sinon';
import axios from 'axios';
import MockAdapter from 'axios-mock-adapter';

const mock = new MockAdapter(axios);

const middlewares = [thunk];
const mockStore = configureStore(middlewares);

chai.use(chaiEnzyme());

describe('add_match', () => {
  it('returns proper action object', () => {
    const payload = [1, 'marton', 1, 'martoff', 2]
    const payload_obj = { id: 1, player1: 'marton', player1_score: 1, player2: 'martoff', player2_score: 2 }

    expect(addMatch(...payload)).to.deep.equal({type: 'ADD_MATCH', ...payload_obj });
  });

  it('returns properly', () => {
    const store = mockStore();
    const payload = [1, 'marton', 1, 'martoff', 2]
    const expectedActions = [
      { type: 'ADD_MATCH', ...payload }
    ]
    const payload_obj = { id: 1, player1: 'marton', player1_score: 1, player2: 'martoff', player2_score: 2 }
    store.dispatch(addMatch(...payload));
    expect(store.getActions()).deep.equal([{ type: "ADD_MATCH", ...payload_obj}])
  });
});


describe('post_match', () => {

  it('dispatches ADD_MATCH action', () => {
    const match = { id: 1, player1: "marton", player1_score: 2, player2: "martoff", player2_score: 20 };
    const expectedActions = [
      { type: 'ADD_MATCH', ...match }
    ]

    mock.onPost('http://localhost:4000/api/v1/matches').reply(200, {
      match: { id: 1, player1: "marton", player1_score: 2, player2: "martoff", player2_score: 20 }
    });

    const payload = ['marton', 1, 'martoff', 2]

    const store = mockStore({matches: {matches: []}});

    return store.dispatch(postMatch(...payload))
      .then(() => {
        expect(store.getActions()).deep.equal(expectedActions);
      })
    mock.reset();
  });

  it('dispatches ADD_ACTION - sinon', sinon.test(() => {

    const payload = ['marton', 1, 'martoff', 2]
    const match = { id: 1, player1: "marton", player1_score: 2, player2: "martoff", player2_score: 20 };
    const tmpGet = axios.get;
    axios.get = sinon.stub().returns(Promise.resolve(...match));

    const dispatch = sinon.spy();
    const action = postMatch(...payload);

    action(dispatch).then(() => {
      expect(dispatch.called).to.be.true;
    });
    axios.get = tmpGet;
  }));

  it('dispatches ADD_ACTION - sinon2', sinon.test(() => {

    const payload = ['marton', 1, 'martoff', 2]
    const match = { id: 1, player1: "marton", player1_score: 2, player2: "martoff", player2_score: 20 };
    const tmpGet = axios.get;
    axios.get = sinon.stub().returns(Promise.resolve(...match));

    const dispatch = sinon.spy();
    const action = postMatch(...payload);

    action(dispatch).then(() => {
      assert(dispatch.calledWith({ type: "ADD_MATCH", ...match }), "didnt call add match");
    });
    axios.get = tmpGet;
  }));
});

describe('fetch_users', () => {
  it('dispatches RECEIVE_USERS action', () => {
    const users = [];
    const expectedActions = [
      { type: 'RECEIVE_USERS', users }
    ]

    mock.onGet('http://localhost:4000/api/v1/users').reply(200, {
      users: []
    });

    const store = mockStore();

    return store.dispatch(fetchUsers())
      .then(() => {
        expect(store.getActions()).deep.equal(expectedActions);
      })
    mock.reset();
  });
});

describe('fetch_matches', () => {
  it('dispatches RECEIVE_MATCHES action', () => {
    const matches = [];
    const expectedActions = [
      { type: 'RECEIVE_MATCHES', matches }
    ]

    mock.onGet('http://localhost:4000/api/v1/matches').reply(200, {
      matches: []
    });

    const store = mockStore();

    return store.dispatch(fetchMatches())
      .then(() => {
        expect(store.getActions()).deep.equal(expectedActions);
      })
    mock.reset();
  });
});
/*
describe('receive_matches', () => {
  it('returns proper action object', () => {
    const payload = [1, 'marton', 1, 'martoff', 2]
    const payload_obj = { id: 1, player1: 'marton', player1_score: 1, player2: 'martoff', player2_score: 2 }

    expect(addMatch(...payload)).to.deep.equal({type: 'ADD_MATCH', ...payload_obj });
  });
});

describe('receive_users', () => {
  it('returns proper action object', () => {
    const payload = [1, 'marton', 1, 'martoff', 2]
    const payload_obj = { id: 1, player1: 'marton', player1_score: 1, player2: 'martoff', player2_score: 2 }

    expect(addMatch(...payload)).to.deep.equal({type: 'ADD_MATCH', ...payload_obj });
  });
});
*/

