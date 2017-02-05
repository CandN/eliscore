import React from 'react';
import { shallow, mount } from 'enzyme';
import chai, { expect } from 'chai';
import chaiEnzyme from 'chai-enzyme';

import Player from '../../../web/static/js/components/player'
import Separator from '../../../web/static/js/components/separator'
import Match from '../../../web/static/js/components/match';
import MatchList from '../../../web/static/js/components/match_list';

chai.use(chaiEnzyme());

describe('<Match />', () => {
  it('throws an error when field prop is not provided', () => {
    expect(() => shallow(<MatchList />)).to.throw;
  });

  it('renders properly with separator text provided', () => {
    const player1 = { id: 1, login: "Marton", email: "mart@on.co" }
    const player2 = { id: 2, login: "Martoff", email: "mart@off.co" }
    const wrapper = shallow(<Match id={1} player1={player1} player1_score={10} player2={player2} player2_score={8} />);
    expect(wrapper.find('div')).to.have.length(3);
  });

  it('has proper props defined', () => {
    const player1 = { id: 1, login: "Marton", email: "mart@on.co" }
    const player2 = { id: 2, login: "Martoff", email: "mart@off.co" }
    const wrapper = shallow(<Match id={1} player1={player1} player1_score={10} player2={player2} player2_score={8} />);
    expect(wrapper.props().id).to.be.defined;
    expect(wrapper.props().player1).to.be.defined;
    expect(wrapper.props().player1_score).to.be.defined;
    expect(wrapper.props().player2).to.be.defined;
    expect(wrapper.props().player2_score).to.be.defined;
  });

  it('assigs props properly', () => {
    const player1 = { id: 1, login: "Marton", email: "mart@on.co" }
    const player2 = { id: 2, login: "Martoff", email: "mart@off.co" }
    const wrapper = mount(<Match id={1} player1={player1} player1_score={10} player2={player2} player2_score={8} />);
    expect(wrapper.props().id).to.equal(1);
    expect(wrapper.props().player1.login).to.equal("Marton");
    expect(wrapper.props().player1_score).to.equal(10);
    expect(wrapper.props().player2.login).to.equal("Martoff");
    expect(wrapper.props().player2_score).to.equal(8);
  });

  it('renders childs properly', () => {
    const player1 = { id: 1, login: "Marton", email: "mart@on.co" }
    const player2 = { id: 2, login: "Martoff", email: "mart@off.co" }
    const wrapper = mount(<Match id={1} player1={player1} player1_score={10} player2={player2} player2_score={8} />);
    expect(wrapper.contains(<Player score={10} nickname="Marton" position="left"/>)).to.equal(true);
    expect(wrapper.contains(<Separator text="⚔" />)).to.equal(true);
    expect(wrapper.contains(<Player score={8} nickname="Martoff" position="right"/>)).to.equal(true);
  });
});
