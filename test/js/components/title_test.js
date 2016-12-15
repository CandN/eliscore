import React from 'react';
import { shallow, mount } from 'enzyme';
import chai, { expect } from 'chai';
import chaiEnzyme from 'chai-enzyme';

import Title from '../../components/title';

chai.use(chaiEnzyme());

describe('<Title />', () => {
  it('throws an error when field prop is not provided', () => {
    expect(() => shallow(<Title />)).to.throw;
  });

  it('renders properly with separator text provided', () => {
    const wrapper = shallow(<Title text="TITLE" />);
    expect(wrapper.find('div')).to.have.length(1);
  });

  it('has proper props defined', () => {
    const wrapper = shallow(<Title text="TITLE" />);
    expect(wrapper.props().text).to.be.defined;
  });

  it('assigs props properly', () => {
    const wrapper = mount(<Title text="TITLE" />);
    expect(wrapper.props().text).to.equal("TITLE");
  });

  it('have proper class names', () => {
    const wrapper = shallow(<Title text="TITLE" />);
    expect(wrapper.find('div')).to.have.className('score-table__title text-center');
  });

  it('render h3 inside', () => {
    const wrapper = shallow(<Title text="TITLE" />);
    expect(wrapper.find('h3')).to.have.length(1);
  });
});
