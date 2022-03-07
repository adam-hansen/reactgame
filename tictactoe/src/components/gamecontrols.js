import React from 'react';

function GameControls(props) {
  return (
    <button className="reset" onClick={props.onClick}>
        Reset Game
    </button>
  );
}

export default GameControls;