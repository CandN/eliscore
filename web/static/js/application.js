import React from "react";

let HelloWorld = React.createClass({
    render: function() {
        return (<h1>Hello Mr VP, We'll make America Gr8 Again!</h1>);
    }
});

React.render(
        <HelloWorld />,
    document.getElementById('main_container')
);
