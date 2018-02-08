import React from 'react';

export default class Paginaton extends React.Component {
  render () {
    const {
      itemsCount,
      itemsPerPage,
      currentPage,
    } = this.props
    
    const allPages = Math.ceil(itemsCount / itemsPerPage);
    
    return (
      <div className='pagination'>
        <span className='pagination__items'>
          {
            [...Array(allPages)].map((_, i) => {
              const counter = i + 1;
              return (
                <span
                  key={counter}
                  className={'pagination__item ' + (currentPage === counter ? 'pagination__item--active' : '') }
                  onClick={() => this.props.setPage(counter)}
                >
                  {counter}
                </span>
              );
            })
          }
        </span>
      </div>
    )
  }
}
