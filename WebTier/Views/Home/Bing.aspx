<%@ Page Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage" %>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <script type="text/javascript" src="../Scripts/JSONHelp.js"></script>
    <script type="text/javascript">

    $(function () {
    });

    function ShowResponse(JSONdata) {
        // alert($.printableJSON(JSONdata, 0));
        // strip out potential script injection tags and print
        $("#results").html($.printJSONToHTML(JSONdata, 0));
    };

    function SearchPhonebook(lat, long, radius, searchTerm) {
        var requestData = {
            'AppId': '<%:ViewData["BingAppId"]%>',
            'Sources': 'Phonebook',
            'Query': searchTerm,
    	    'Latitude': lat,
	        'Longitude': long,
	        'Radius': radius,
            'JsonType': 'callback',
            'JsonCallback': 'ShowResponse'
        };

        $.getJSON('<%:ViewData["BingUri"]%>?callback=?', requestData);
    };

    function GetDetails(locId) {
        var requestData = {
            'AppId': '<%:ViewData["BingAppId"]%>',
            'Sources': 'Phonebook',
            'Query': ' ',
	    'LocId': locId,
	    'Count': 1,
            'JsonType': 'callback',
            'JsonCallback': 'ShowResponse'
        };
        $.getJSON('<%:ViewData["BingUri"]%>?callback=?', requestData);
    };


    </script>

    <p>
        This sample shows how to access information in the Bing Search API.        
        The developer site is <a href="http://www.bing.com/toolbox/bingdeveloper/#">here</a>.
        Terms of usage are <a href="https://ssl.bing.com/webmaster/developers/tou.aspx">here</a>. 
     </p>
     <p>
        The API limitations/constraints are not very explicit. 
     </p>
     <p>
     Bing exposes a different "source type" for each kind of search service (news, web, image, video). Helper services are also exposed as source types (translate, spell, related searches). One interesting source type is "phonebook" which is a business directory --- this is used in the sample below. 
     </p>
     <div id="PhonebookAPI" style="display:block">
     <h2> Places API </h2>
     <table>
        <thead>
            <tr>
            <td>Search by search term + location</td>
            <td>Details of a specific place</td>
            </tr>
        </thead>
        <tbody>
        <tr>
            <td>
                <form action="Bing.aspx">
                    Lat : <input type="text" name="Latitude" value="47.607551"/> <br />
                    Long : <input type="text" name="Longitude" value="-122.117597"/> <br />
                    Radius (miles) : <input type="text" name="Radius" value="5"/> <br />
                    Search term (required): <input type="text" name="SearchTerm" value="crossroads"/> <br />
                                        
                    <input type="button" value="Search" onclick="SearchPhonebook(this.form.Latitude.value, this.form.Longitude.value, this.form.Radius.value, this.form.SearchTerm.value);" />
                </form>                                 
            </td>
            <td>
                A couple of problems with this API. First, it requires the query searchterm (why? if the ID is known). Second, it does not seem to work --- the LocId and Count parameters seem to be ignored.
                <form action="Bing.aspx">
                    Unique Id : <input type="text" name="UniqueId" value="YN925x220706705"/> <br />
                    <input type="button" value="Get Details" onclick="GetDetails(this.form.UniqueId.value);" />
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
