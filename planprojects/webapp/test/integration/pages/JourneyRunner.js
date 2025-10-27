sap.ui.define([
    "sap/fe/test/JourneyRunner",
	"planprojects/test/integration/pages/ProjectList",
	"planprojects/test/integration/pages/ProjectObjectPage"
], function (JourneyRunner, ProjectList, ProjectObjectPage) {
    'use strict';

    var runner = new JourneyRunner({
        launchUrl: sap.ui.require.toUrl('planprojects') + '/test/flp.html#app-preview',
        pages: {
			onTheProjectList: ProjectList,
			onTheProjectObjectPage: ProjectObjectPage
        },
        async: true
    });

    return runner;
});

