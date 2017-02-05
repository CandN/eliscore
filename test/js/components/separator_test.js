import React from 'react';
import { shallow, mount } from 'enzyme';
import chai, { expect } from 'chai';
import chaiEnzyme from 'chai-enzyme';

import Separator from '../../../web/static/js/components/separator';

chai.use(chaiEnzyme());

describe('<Separator />', () => {
  it('throws an error when field prop is not provided', () => {
    expect(() => shallow(<Separator />)).to.throw;
  });

  it('renders properly with separator text provided', () => {
    const wrapper = shallow(<Separator text="vs" />);
    expect(wrapper.find('div')).to.have.length(1);
  });

  it('has proper props defined', () => {
    const wrapper = shallow(<Separator text="vs" />);
    expect(wrapper.props().text).to.be.defined;
  });

  it('assigs props properly', () => {
    const wrapper = mount(<Separator text="vs" />);
    expect(wrapper.props().text).to.equal("vs");
  });

  it('assigs props properly', () => {
    const wrapper = shallow(<Separator text="vs" />);
    expect(wrapper.find('div')).to.have.className('col-xs-2 match__separator');
  });
});
