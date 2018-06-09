/*
author @amitabh date 9th July, 2018
updating an account before insert description
*/
trigger accountTrigger on Account (before insert) {
	for (Account a:Trigger.new){
	//add update description here
	a.accountNumber = 4866;
	}
}