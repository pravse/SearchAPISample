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

    function SearchByType(where, type) {
        // alert("Get Sample items");
        $.getJSON('<%:ViewData["CityGridWhereUri"]%>' + 
                    "?type=" + htmlEncode(type) +
                    "&where=" + htmlEncode(where) +
                    "&publisher=" + '<%:ViewData["CityGridKey"]%>' +
                    "&format=json" +
                    "&callback=?", 
                  ShowResponse);
    };

    function SearchByLatLong(lat, long, type) {
        // alert("Get Sample items");
        $.getJSON('<%:ViewData["CityGridWhereUri"]%>' +
                    "?type=" + htmlEncode(type) +
                    "&lat=" + htmlEncode(lat) +
                    "&lon=" + htmlEncode(long) +
                    "&publisher=" + '<%:ViewData["CityGridKey"]%>' +
                    "&format=json" +
                    "&callback=?",
                  ShowResponse);
    };

    function SearchByWhat(where, what) {
        // alert("Get Sample items");
        $.getJSON('<%:ViewData["CityGridWhereUri"]%>' +
                    "?what=" + htmlEncode(what) +
                    "&where=" + htmlEncode(where) +
                    "&publisher=" + '<%:ViewData["CityGridKey"]%>' +
                    "&format=json" +
                    "&callback=?",
                  ShowResponse);
    };

    function EnablePlacesAPI() {
        $("#PlacesAPI")[0].style.display = "";
        $("#OffersAPI")[0].style.display = "none";
        $("#ReviewsAPI")[0].style.display = "none";
    };

    function EnableOffersAPI() {
        $("#PlacesAPI")[0].style.display = "none";
        $("#OffersAPI")[0].style.display = "";
        $("#ReviewsAPI")[0].style.display = "none";
    };

    function EnableReviewsAPI() {
        $("#PlacesAPI")[0].style.display = "none";
        $("#OffersAPI")[0].style.display = "none";
        $("#ReviewsAPI")[0].style.display = "";
    };


    </script>

    <p>
        This sample shows how to access information in the CityGrid API.        
        The developer site is <a href="http://docs.citygridmedia.com/display/citygridv2/CityGrid+APIs">here</a>.
        Terms of usage are <a href="">here</a>. 
     </p>
     <p>
        The app must show the end-user all results returned by CityGrid (except optionally the ads). The app cannot cache data except for 15 minutes for performance. The usage limit is 10 million queries per month.
     </p>
     <p>
     Of particular interest, CityGrid provides an email field for businesses (accessed via the PlacesDetail API which isn't shown below). 
     </p>
     <p>
        <button id="PlacesButton" onclick="EnablePlacesAPI();">Places API</button>
        <button id="OffersButton" onclick="EnableOffersAPI();">Offers API</button>
        <button id="ReviewsButton" onclick="EnableReviewsAPI();">Reviews API</button>
     </p>
     <div id="PlacesAPI" style="display:block">
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
                    function GetType(form) {
                        var i;
                        for (i = 0; i < form.Types.length; i++) {
                            if (form.Types[i].checked) {
                                break;
                            }
                        }
                        return form.Types[i].value;
                    };
                </script>
     <h2> Places API </h2>
     <table>
        <thead>
            <tr>
            <td>Search by type + location</td>
            <td>Search by search term + location</td>
            <td>Search by lat/long</td>
            </tr>
        </thead>
        <tbody>
        <tr>
            <td>
                <form action="CityGrid.aspx">
                    <input type="radio" name="Locations" value="Redmond, WA"/> Redmond, WA<br />
                    <input type="radio" name="Locations" value="98008" checked/> 98008 <br />
                    <input type="radio" name="Locations" value="1 Microsoft Way, Redmond, WA"/>1 Microsoft Way, Redmond, WA <br />
                    <hr />
                    <input type="radio" name="Types" value="movie"/> Movie <br />
                    <input type="radio" name="Types" value="movietheater"/> MovieTheater <br />
                    <input type="radio" name="Types" value="restaurant" checked/> Restaurant <br />
                    <input type="radio" name="Types" value="hotel"/> Hotel <br />
                    <input type="radio" name="Types" value="travel"/> Travel <br />
                    <input type="radio" name="Types" value="barclub"/> Bar/Club<br />
                    <input type="radio" name="Types" value="spabeauty"/> Spa/Beauty<br />
                    <input type="radio" name="Types" value="shopping"/> Shopping <br />
                    
                    <input type="button" value="Search" onclick="SearchByType(GetLoc(this.form), GetType(this.form));" />
                </form> 
            </td>
            <td>
                <form action="CityGrid.aspx">
                    <input type="radio" name="Locations" value="Redmond, WA"/> Redmond, WA<br />
                    <input type="radio" name="Locations" value="98008" checked/> 98008 <br />
                    <input type="radio" name="Locations" value="1 Microsoft Way, Redmond, WA"/>1 Microsoft Way, Redmond, WA <br />
                    <hr />
                    Search term : <input type="text" name="SearchTerm" value="<enter search term>"/> <br />
                    
                    <input type="button" value="Search" onclick="SearchByWhat(GetLoc(this.form), this.form.SearchTerm.value);" />
                </form>                 
            </td>
            <td>
                <form action="CityGrid.aspx">
                    Lat : <input type="text" name="Latitude" value="47.607551"/> <br />
                    Long : <input type="text" name="Longitude" value="-122.117597"/> <br />
                    
                    <input type="radio" name="Types" value="movie"/> Movie <br />
                    <input type="radio" name="Types" value="movietheater"/> MovieTheater <br />
                    <input type="radio" name="Types" value="restaurant" checked/> Restaurant <br />
                    <input type="radio" name="Types" value="hotel"/> Hotel <br />
                    <input type="radio" name="Types" value="travel"/> Travel <br />
                    <input type="radio" name="Types" value="barclub"/> Bar/Club<br />
                    <input type="radio" name="Types" value="spabeauty"/> Spa/Beauty<br />
                    <input type="radio" name="Types" value="shopping"/> Shopping <br />
                    
                    <input type="button" value="Search" onclick="SearchByLatLong(this.form.Latitude.value, this.form.Longitude.value, GetType(this.form));" />
                </form>                                 
            </td>
          
        </tr>
        </tbody>
     </table>
     </div>
     <div id="OffersAPI" style="display:none">
     <h2> Offers API </h2>
     TODO
     </div>
     <div id="ReviewsAPI" style="display:none">
     <h2> Reviews API </h2>
     TODO
     </div>

     <p>
     <h2>Results</h2>
     </p>
     <div id="results"></div>
    
</asp:Content>
