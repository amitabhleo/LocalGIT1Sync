trigger testUpload on Contact (before insert) {
	for(Contact c:Trigger.new){
	c.description = 'new contact';
	//added a description now
	}
    
}