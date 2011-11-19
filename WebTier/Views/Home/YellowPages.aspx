<%@ Page Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage" %>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <script type="text/javascript" src="../Scripts/JSONHelp.js"></script>
    <script type="text/javascript">

    $(function () {
    });

    function ShowResponse(JSONdata) {
        // alert($.printableJSON(JSONdata, 0));
        $("#results").html($.printJSONToHTML(JSONdata, 0));
    };


    function SearchListings(loc, radius, searchTerm) {
        var requestData = {
            'key': '<%:ViewData["YPAPIKey"]%>',
            'term': searchTerm,
	    'searchloc': loc,
	    'format': 'json',
	    'radius': radius
        };

        $.getJSON('<%:ViewData["YPListingsUri"]%>/search?callback=?', requestData, ShowResponse);
    };

    function GetDetails(listingId) {
        var requestData = {
            'key': '<%:ViewData["YPAPIKey"]%>',
	    'format': 'json',
	    'listingid': listingId
        };

        $.getJSON('<%:ViewData["YPListingsUri"]%>/details?callback=?', requestData, ShowResponse);
    };


    function EnableListingsAPI() {
        $("#ListingsAPI")[0].style.display = "";
        $("#CouponsAPI")[0].style.display = "none";
    };

    function EnableCouponsAPI() {
        $("#ListingsAPI")[0].style.display = "none";
        $("#CouponsAPI")[0].style.display = "";
    };



    </script>

    <p>
        This sample shows how to access information in the YellowPages API.        
        The developer site is <a href="http://developer.yp.com">here</a>.
        Terms of usage are <a href="http://developer.yp.com/faq">here</a>. The service is at an Alpha stage and so many of the terms and details are evolving.
     </p>
     <p>
        There are almost no constraints. The service is free. The usage limit is 10000 requests per day, but they can increase that if needed.
     </p>
     <p>
     Of particular interest, YellowPages provides an email field for businesses (accessed via the Listing Detail API). There is an elaborate categorization scheme, but the category list is not yet public. They are aware of the need and working on exposing it.
     </p>
     <p>
        <button id="ListingsButton" onclick="EnableListingsAPI();">Listings API</button>
        <button id="CouponsButton" onclick="EnableCouponsAPI();">Offers API</button>
     </p>
     <div id="ListingsAPI" style="display:block">
                <script type="text/javascript">
                    function GetLoc(form) {
                        var i;
                        for (i = 0; i < form.Locations.length; i++) {
                            if (form.Locations[i].checked) {
                                break;
                            }
                        }
                        return form.Locations[i].value;
                    };
                </script>
     <h2> Places API </h2>
     <table>
        <thead>
            <tr>
            <td>Search by search term + location</td>
            <td>Search by search term lat/long</td>
            <td>Get listing details</td>
            </tr>
        </thead>
        <tbody>
        <tr>
            <td>
                <form action="YellowPages.aspx">
                    <input type="radio" name="Locations" value="Redmond, WA"/> Redmond, WA<br />
                    <input type="radio" name="Locations" value="98008" checked/> 98008 <br />
                    <input type="radio" name="Locations" value="1 Microsoft Way, Redmond, WA"/>1 Microsoft Way, Redmond, WA <br />
                    <hr />
                    Radius (in miles) : <input type="text" name="Radius" value="10"/> <br />
                    Search term : <input type="text" name="SearchTerm" value="crossroads"/> <br />
                    
                    <input type="button" value="Search" onclick="SearchListings(GetLoc(this.form), this.form.Radius.value, this.form.SearchTerm.value);" />
                </form>                 
            </td>
            <td>
                <form action="YellowPages.aspx">
                    Lat : <input type="text" name="Latitude" value="47.607551"/> <br />
                    Long : <input type="text" name="Longitude" value="-122.117597"/> <br />
                    Radius (in miles) : <input type="text" name="Radius" value="10"/> <br />
                    Search term (required): <input type="text" name="SearchTerm" value="crossroads"/> <br />
                    
                    <input type="button" value="Search" onclick="SearchListings(this.form.Latitude.value+':'+this.form.Longitude.value, this.form.Radius.value, this.form.SearchTerm.value);" />
                </form>                                 
            </td>
            <td>
                <form action="YellowPages.aspx">
                    Listing Id : <input type="text" name="ListingId" value="21989502"/> <br />
                    <input type="button" value="Get Details" onclick="GetDetails(this.form.ListingId.value);" />
                </form>                                 
          
        </tr>
        </tbody>
     </table>
     </div>
     <div id="CouponsAPI" style="display:none">
     <h2> Coupons API </h2>
     TODO: Similar to the Listings API, this allows searches for coupons near a location/matching a search term. 
     </div>

     <p>
     <h2>Results</h2>
     </p>
     <div id="results"></div>
    
</asp:Content>
