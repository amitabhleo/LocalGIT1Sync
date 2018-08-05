//GIVEN a user is viewing a record with a gantt chart (Program, Project, Milestone)
beforeEach(function() {
		document.body.innerHTML += '<div id="GanttChartDIV_Test" style="background-color:white; position:relative"/>';

	    g = new JSGantt.GanttChart("g",document.getElementById("GanttChartDIV_Test"), "day", "123");
	    g.setShowRes(0); // Show/Hide Responsible (1/0)
		g.setShowDur(0); // Show/Hide Duration (1/0)
		g.setShowComp(0); // Show/Hide % Complete(1/0)
		g.setCaptionType("None");
		      
		g.AddTaskItem(new JSGantt.TaskItem(1, 'Define Chart API', '', '', 'ff0000', 'http://help.com', 0, 'Brian', 0, 1, 0, 1));
	    g.AddTaskItem(new JSGantt.TaskItem(11, 'Chart Object', '2/20/2008', '2/20/2008', 'ff00ff', 'http://www.yahoo.com', 1, 'Shlomy', 100, 0, 1, 1, '', '', '1'));

		g.Draw();

	});

describe("WHEN the page has loaded", function(){
    
	it("THEN the children should be rendered automatically", function(){
	    expect(JSGantt.findObj('child_11').style.display).toBe("");
	    expect(JSGantt.findObj('childgrid_11').style.display).toBe("");
	
	});

});

describe("WHEN user selects the '-' sign next to a gantt chart item", function(){

	it("THEN the gantt chart should hide the related children records", function(){
		JSGantt.folder('1', g);
	    expect(JSGantt.findObj('child_11').style.display).toBe("none");
	    expect(JSGantt.findObj('childgrid_11').style.display).toBe("none");
	
	});
});