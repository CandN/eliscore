import React from 'react'

const LiveStream = () => (
  <div className="twitch">
    <iframe src="https://player.twitch.tv/?channel=streamguru_gdansk" 
      frameBorder="0" 
      allowFullScreen="true" 
      scrolling="no" 
      height="378" 
      width="620">
    </iframe>
  </div>
)

export default LiveStream
