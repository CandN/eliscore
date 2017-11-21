import React from 'react';
import { shallow, mount } from 'enzyme';
import chai, { expect } from 'chai';
import chaiEnzyme from 'chai-enzyme';

import Player from '../../components/player';

chai.use(chaiEnzyme());

describe('<Player />', () => {
  it('throws an error when field prop is not provided', () => {
    expect(() => shallow(<Player />)).to.throw;
  });

  it('renders properly with props provided', () => {
    const wrapper = shallow(<Player score={10} nickname="Marton" position="left"/>);
    expect(wrapper.find('div')).to.have.length(4);
  });

  it('has proper props defined', () => {
    const wrapper = shallow(<Player score={10} nickname="Marton" position="left"/>);
    expect(wrapper.props().score).to.be.defined;
    expect(wrapper.props().nickname).to.be.defined;
    expect(wrapper.props().position).to.be.defined;
  });

  it('assigs props properly', () => {
    const wrapper = mount(<Player score={10} nickname="Marton" position="left"/>);
    expect(wrapper.props().score).to.equal(10);
    expect(wrapper.props().nickname).to.equal("Marton");
    expect(wrapper.props().position).to.equal("left");
  });

  it('renders proper children', () => {
    const wrapper = shallow(<Player score={10} nickname="Marton" position="left"/>);
    expect(wrapper.find('.player__score')).to.have.length(1);
    expect(wrapper.find('.player__score').text()).to.equal("10");
    expect(wrapper.find('.player__name')).to.have.length(1);
    expect(wrapper.find('.player__name').text()).to.equal("Marton");
  });
});
