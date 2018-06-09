/*
author @amitabh date 9th July, 2018
updating an account before insert description
*/
trigger accountTrigger on Account (before insert) {
	for (account a:Trigger.new){
	//add update description here
	}

}