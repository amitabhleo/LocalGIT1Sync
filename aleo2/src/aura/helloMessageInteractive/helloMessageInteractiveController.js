({
	handleClick : function(component, event, helper) {
		var btnClicked = event.getSource();//the button
        var btnMessage = btnClicked.get("v.label");//the button's label
        //after fetching the label details from the button
        //displaying the label
        component.set("v.message",btnMessage);//update message
	}
})
/* Can be done in one statement also
    handleClick2: function(component, event, helper) {
        var newMessage = event.getSource().get("v.label");
        component.set("v.message", newMessage);
    },
    handleClick3: function(component, event, helper) {
        component.set("v.message", event.getSource().get("v.label"));
    }
*/