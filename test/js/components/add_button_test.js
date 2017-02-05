import React from 'react';
import { shallow, mount } from 'enzyme';
import chai, { expect } from 'chai';
import chaiEnzyme from 'chai-enzyme';

import AddButton from '../../../web/static/js/components/add_button';

chai.use(chaiEnzyme());

describe('<AddButton />', () => {
  it('throws an error when field prop is not provided', () => {
    expect(() => shallow(<AddButton />)).to.throw;
  });

  it('renders properly with text provided', () => {
    const wrapper = shallow(<AddButton text="new match" />);
    expect(wrapper.find('div')).to.have.length(2);
  });

  it('has proper props defined', () => {
    const wrapper = shallow(<AddButton text="new match" />);
    expect(wrapper.props().text).to.be.defined;
  });

  it('assigs props properly', () => {
    const wrapper = mount(<AddButton text="new match" />);
    expect(wrapper.props().text).to.equal("new match");
  });

  it('has child rendered', () => {
    const wrapper = shallow(<AddButton text="new match" />);
    expect(wrapper.contains(<div className="score-table__btn-new">new match</div>)).to.equal(true)
  });
});
