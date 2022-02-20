import React from 'react';

class Square extends React.Component {
    render(i) {
      return (
        <button className="square">
          {this.props.value}
        </button>
      );
    }
}

export default Square;