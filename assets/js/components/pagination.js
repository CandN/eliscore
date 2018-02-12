import React from 'react';

export default class Paginaton extends React.Component {
  goBackwards() {
    if (this.props.currentPage - 1 > 0) {
      this.props.setPage(this.props.currentPage - 1);
    }
  }
  
  goForward() {
    if (this.props.currentPage + 1 <= this.allPages()) {
      this.props.setPage(this.props.currentPage + 1);
    }
  }
  
  allPages() {
    return Math.ceil(this.props.itemsCount / this.props.itemsPerPage);
  }
  
  render () {
    const {
      itemsCount,
      itemsPerPage,
      currentPage,
    } = this.props
    
    return (
      <div className='pagination'>
        <span className='pagination__items'>
          <span
            className='pagination__left btn btn-default'
            onClick={() => this.goBackwards()}
          >
            &lt;
          </span>
          {
            [...Array(this.allPages())].map((_, i) => {
              const counter = i + 1;
              return (
                <span
                  key={counter}
                  className={'btn btn-default pagination__item ' + (currentPage === counter ? 'pagination__item--active' : '') }
                  onClick={() => this.props.setPage(counter)}
                >
                  {counter}
                </span>
              );
            })
          }
          <span
            className='pagination__right  btn btn-default'
            onClick={() => this.goForward()}
          >
            &gt;
          </span>
        </span>
      </div>
    )
  }
}
