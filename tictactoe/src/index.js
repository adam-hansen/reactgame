import React from 'react';
import ReactDOM from 'react-dom';
import './index.css';
import Game from './components/game';
import actionCable from 'actioncable';

const CableApp = {}

CableApp.cable = actionCable.createConsumer('ws:localhost:3001/cable')
  
  // ========================================
  
  ReactDOM.render(
    <Game cableApp={CableApp}/>,
    document.getElementById('root')
  );
  