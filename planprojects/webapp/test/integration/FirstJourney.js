sap.ui.define([
    "sap/ui/test/opaQunit",
    "./pages/JourneyRunner",
    "sap/ui/test/Opa5"
], function (opaTest, runner, Opa5) {
    "use strict";

    function journey() {
        QUnit.module("First journey");

        opaTest("Start application", function (Given, When, Then) {
            Given.iStartMyApp();

            Then.onTheProjectList.iSeeThisPage();

        });


        opaTest("List shows project table with columns", function (Given, When, Then) {

            When.onTheProjectList.onFilterBar().iExecuteSearch();
            Then.onTheProjectList.onTable().iCheckRows();

            Then.waitFor({
                controlType: "sap.m.Table",
                success: function (aTables) {
                    var oTable = null;
                    for (var i = 0; i < aTables.length; i++) {
                        var oCandidate = aTables[i];
                        if (typeof oCandidate.getId === "function" && oCandidate.getId().indexOf("ProjectList") !== -1) {
                            oTable = oCandidate;
                            break;
                        }
                    }
                    oTable = oTable || aTables[0];

                    Opa5.assert.ok(!!oTable, "Found a table control on the list report");
                    if (!oTable) {
                        return;
                    }

                    var aColumns = oTable.getColumns();
                    Opa5.assert.ok(aColumns.length > 0, "List report table exposes at least one column");

                    var bHeaderWithText = aColumns.some(function (oColumn) {
                        var oHeader = oColumn.getHeader && oColumn.getHeader();
                        if (!oHeader) {
                            return false;
                        }
                        if (typeof oHeader.getText === "function") {
                            return oHeader.getText().trim().length > 0;
                        }
                        if (typeof oHeader.getTitle === "function") {
                            return oHeader.getTitle().trim().length > 0;
                        }
                        return false;
                    });
                    Opa5.assert.ok(bHeaderWithText, "At least one column header contains text");
                },
                errorMessage: "Project list table was not found"
            });
        });


        opaTest("Navigate to ObjectPage", function (Given, When, Then) {
            // Note: this test will fail if the ListReport page doesn't show any data
            
            When.onTheProjectList.onFilterBar().iExecuteSearch();
            
            Then.onTheProjectList.onTable().iCheckRows();

            When.onTheProjectList.onTable().iPressRow(0);
            Then.onTheProjectObjectPage.iSeeThisPage();

        });

        opaTest("Object page displays sections", function (Given, When, Then) {
            Then.onTheProjectObjectPage.iSeeThisPage();

            Then.waitFor({
                controlType: "sap.uxap.ObjectPageLayout",
                success: function (aLayouts) {
                    var oLayout = null;
                    for (var i = 0; i < aLayouts.length; i++) {
                        var oCandidate = aLayouts[i];
                        if (typeof oCandidate.getId === "function" && oCandidate.getId().indexOf("ProjectObjectPage") !== -1) {
                            oLayout = oCandidate;
                            break;
                        }
                    }
                    oLayout = oLayout || aLayouts[0];

                    Opa5.assert.ok(!!oLayout, "Found the object page layout");
                    if (!oLayout) {
                        return;
                    }

                    Opa5.assert.ok(oLayout.getSections().length > 0, "Object page shows at least one section");
                },
                errorMessage: "Object page layout not found"
            });
        });

        opaTest("Object page header shows project title", function (Given, When, Then) {
            Then.onTheProjectObjectPage.iSeeThisPage();

            Then.waitFor({
                controlType: "sap.f.DynamicPageTitle",
                success: function (aTitles) {
                    var oTitle = null;
                    for (var i = 0; i < aTitles.length; i++) {
                        var oCandidate = aTitles[i];
                        if (typeof oCandidate.getId === "function" && oCandidate.getId().indexOf("ProjectObjectPage") !== -1) {
                            oTitle = oCandidate;
                            break;
                        }
                    }
                    oTitle = oTitle || aTitles[0];

                    Opa5.assert.ok(!!oTitle, "Found the object page header title");
                    if (!oTitle) {
                        return;
                    }

                    var oHeading = oTitle.getHeading ? oTitle.getHeading() : null;
                    var sTitleText = "";

                    if (oHeading) {
                        if (typeof oHeading.getText === "function") {
                            sTitleText = oHeading.getText();
                        } else if (typeof oHeading.getTitle === "function") {
                            sTitleText = oHeading.getTitle();
                        }
                        else {
                            errorMessage: "Object page header title not found"
                            return;
                        }
                    }

                    Opa5.assert.ok(sTitleText, "Object page header shows a project title");
                },
                errorMessage: "Object page header title not found"
            });
        });

        opaTest("Teardown", function (Given, When, Then) { 
            // Cleanup
            Given.iTearDownMyApp();
        });
    }

    runner.run([journey]);
});
