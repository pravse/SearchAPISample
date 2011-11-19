<%@ Page Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage" %>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <script type="text/javascript" src="../Scripts/JSONHelp.js"></script>
    <script type="text/javascript" src="../Scripts/3Taps.js"></script>
    <script type="text/javascript" src="../Scripts/3TapsSpec.js"></script>
    <script type="text/javascript">

    var ttClient;

    $(function () {
    	ttClient = new threeTapsClient('<%:ViewData["3TapsKey"]%>');
    });

    function ShowResponse(JSONdata) {
        $("#results").html($.printJSONToHTML(JSONdata, 0));
    };

    function GetCategories(withAnnotations) {
    	ttClient.reference.category(ShowResponse,'',withAnnotations);
    };

    function GetSources(withAnnotations) {
    	ttClient.reference.source(ShowResponse);
    };

    function GetLocations(withAnnotations) {
    	ttClient.reference.location(ShowResponse);
    };

    function SearchLocCat(location, category) {
    	var requestData = {
	    'location': location,
	    'category': category,
	    'rpp': 10
	};
    	ttClient.search.search(requestData, ShowResponse);
    };

    function SearchSummaryByCatSrc(category, source) {
    	var requestData = {
	    'category': category,
	    'source': source
	};
    	ttClient.search.summary(requestData, ShowResponse);
    };

    function EnableSearchAPI() {
        $("#MetadataAPI")[0].style.display = "none";
        $("#AggrdataAPI")[0].style.display = "none";
        $("#SearchAPI")[0].style.display = "";
    };

    function EnableAggrdataAPI() {
        $("#MetadataAPI")[0].style.display = "none";
        $("#AggrdataAPI")[0].style.display = "";
        $("#SearchAPI")[0].style.display = "none";
    };

    function EnableMetadataAPI() {
        $("#MetadataAPI")[0].style.display = "";
        $("#AggrdataAPI")[0].style.display = "none";
        $("#SearchAPI")[0].style.display = "none";
    };

    </script>

    <p>
        This sample shows how to access information in the 3Taps API. 3Taps aggregates "exchange" postings from a number of data providers (craigslist, ebay, and others) with a normalized schema and categories.
        The developer site is <a href="https://developer.3taps.com">here</a>.
        Terms of usage are <a href="http://register.3taps.com/apps/tos">here</a>. 
     </p>
     <p>
	There are no obvious restrictions on usage. There are no rate limits.
     </p>
     <p>
     Of particular interest, 3Taps has very great metadata for products. It might provide a common metadata scheme across multiple product providers. But .... sigh .. despite the promise, it currently seems to have only Craigslist data.
     </p>
     <p>
        <button id="SearchButton" onclick="EnableSearchAPI();">Search API</button>
        <button id="AggrdataButton" onclick="EnableAggrdataAPI();">Aggregate data API</button>
        <button id="MetadataButton" onclick="EnableMetadataAPI();">Metadata API</button>
     </p>
     <div id="SearchAPI" style="display:block">
                <script type="text/javascript">
                    // categories can be multi-selected
                    function GetCat(form) {
                        var returnCat = null;
                        var i;
                        for (i = 0; i < form.Category.length; i++) {
                            if (form.Category[i].checked) {
                                if (null == returnCat) {
                                    returnCat = form.Category[i].value;
                                }
                                else {
                                    returnCat = returnCat + '+OR+' + form.Category[i].value;
                                }
                            }
                        }
                        return returnCat;
                    };
                    // locations can be multi-selected
                    function GetLoc(form) {
                        var returnLoc = null;
                        var i;
                        for (i = 0; i < form.Location.length; i++) {
                            if (form.Location[i].checked) {
                                if (null == returnLoc) {
                                    returnLoc = form.Location[i].value;
                                }
                                else {
                                    returnLoc = returnLoc + '+OR+' + form.Location[i].value;
                                }
                            }
                        }
                        return returnLoc;
                    };
                </script>
     <h2> Search API </h2>
     <table>
        <thead>
            <tr>
            <td>Search By Loc/Category</td>
            <td>Search By Source/Heading Content</td>
            <td>Search by Body Content/Date</td>
            <td>Search by Category/PriceRange</td>
            </tr>
        </thead>
        <tbody>
        <tr>
	<td>
                <form action="Google.aspx">
                    <input type="checkbox" name="Category" value="STOY"/> Toys for Sale <br />
                    <input type="checkbox" name="Category" value="STVL"/> Travel for Sale <br />
                    <input type="checkbox" name="Category" value="STIX"/> Tickets for Sale <br />
		    <hr>
                    <input type="checkbox" name="Location" value="NYC"/> New York City <br />
                    <input type="checkbox" name="Location" value="LAX"/> Los Angeles <br />
                    <input type="checkbox" name="Location" value="CHI"/> Chicago <br />

                    <input type="button" value="Search" onclick="SearchLocCat(GetLoc(this.form), GetCat(this.form));" />
                </form>                                 
	</td>
        </tr>
        </tbody>
     </table>
     </div>

     <div id="MetadataAPI" style="display:none">
     <h2> Metadata API </h2>
     <table>
        <thead>
            <tr>
            <td>Categories</td>
            <td>Categories w/ schema annotations</td>
            <td>Sources</td>
            <td>Locations</td>
            </tr>
        </thead>
        <tbody>
            <tr>
            <td>
                <form action="ThreeTaps.aspx">
                    <input type="button" value="Get Categories(Short)" onclick="GetCategories(false);" />
                </form>                                 
	    </td>
            <td>
                <form action="ThreeTaps.aspx">
                    <input type="button" value="Get Categories(Full)" onclick="GetCategories(true);" />
                </form>                                 
	    </td>
            <td>
                <form action="ThreeTaps.aspx">
                    <input type="button" value="Get Sources" onclick="GetSources();" />
                </form>                                 
	    </td>
            <td>
                <form action="ThreeTaps.aspx">
                    <input type="button" value="Get Locations" onclick="GetLocations();" />
                </form>                                 
	    </td>
            </tr>
	</tbody>
     </table>
     </div>

     <div id="AggrdataAPI" style="display:none">
     <h2> Aggregate Data API </h2>
     <table>
        <thead>
            <tr>
            <td>Count By Category</td>
            <td>Count By Location</td>
            <td>Count By Category, Source</td>
            </tr>
        </thead>
        <tbody>
            <tr>
            <td>
                <form action="ThreeTaps.aspx">
                    <input type="checkbox" name="Category" value="STOY"/> Toys for Sale <br />
                    <input type="checkbox" name="Category" value="STVL"/> Travel for Sale <br />
                    <input type="checkbox" name="Category" value="STIX"/> Tickets for Sale <br />
                    <input type="button" value="Count By Category " onclick="SearchSummaryByCatSrc(GetCat(this.form), null);" />
                </form>                                 
	    </td>
	    <td></td>
            <td>
                <form action="ThreeTaps.aspx">
                    <input type="checkbox" name="Category" value="STOY"/> Toys for Sale <br />
                    <input type="checkbox" name="Category" value="STVL"/> Travel for Sale <br />
                    <input type="checkbox" name="Category" value="STIX"/> Tickets for Sale <br />
                    <input type="button" value="Count By Category " onclick="SearchSummaryByCatSrc(GetCat(this.form), null);" />
                </form>                                 
	    </td>
            </tr>
	</tbody>
     </table>
     </div>

     <p>
     <h2>Results</h2>
     </p>
     <div id="results"></div>
    
</asp:Content>
