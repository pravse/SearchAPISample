<%@ Page Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage" %>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <script type="text/javascript" src="../Scripts/JSONHelp.js"></script>
    <script type="text/javascript" src="http://maps.googleapis.com/maps/api/js?libraries=places&sensor=false"></script>
    <script type="text/javascript">

        var map;
        var service;

    $(function () {
        // we have to define a dummy map even though we don't intend to use it 
        map = new google.maps.Map(document.getElementById('results'),
                                   { mapTypeId: google.maps.MapTypeId.ROADMAP,
                                     center: new google.maps.LatLng(47, -122),
                                     zoom: 15
                                   });
        service = new google.maps.places.PlacesService(map);
    });

    function ShowResponse(JSONdata, status) {
        if (status == google.maps.places.PlacesServiceStatus.OK) {
            $("#results").html($.printJSONToHTML(JSONdata, 0));
        }
        else {
            $("#results").html("Bad return status:" + status);
        }
    };

    function SearchPlaces(lat, long, radius, types, searchTerm) {
        var location = new google.maps.LatLng(lat, long);
        var request = {
            location: location,
            radius: radius,
            types: [types],
            keyword: searchTerm
        };
        service.search(request, ShowResponse);
    };

    function GetDetails(ref) {
        var request = {
            reference: ref
        };
        service.getDetails(request, ShowResponse);
    };

    function EnablePlacesAPI() {
        $("#PlacesAPI")[0].style.display = "";
        $("#CheckinsAPI")[0].style.display = "none";
    };

    function EnableCheckinsAPI() {
        $("#PlacesAPI")[0].style.display = "none";
        $("#CheckinsAPI")[0].style.display = "";
    };


    </script>

    <p>
        This sample shows how to access information in the Google Places API.        
        The developer site is <a href="http://code.google.com/apis/maps/documentation/places/">here</a>.
        Terms of usage are <a href="http://code.google.com/apis/maps/documentation/places/#Limits">here</a>. 
     </p>
     <p>
	If a map is used, the map must be from Google.
        Caching is not disallowed --- in fact, the API includes a feature to make it easier to cache results.
        The usage limit is 1000 requests per day, but this can be increased to 100,000 requests per day with user verification. 
     </p>
     <p>
     Of particular interest, Google Places API provides a list of business types or categories <a href="http://code.google.com/apis/maps/documentation/places/supported_types.html">here</a>. However, this list is not hierarchical, and is more oriented towards places rather than businesses/services.
     A minor PITA: according to <a href="http://www.quora.com/Why-doesnt-the-new-Google-Places-API-support-JSONP">this post</a>, the Google Places API wasn't designed to be called from a browser, and therefore isn't JSONP-compliant. As a result, we need to use Google's JS API to invoke it.
     </p>
     <p>
        <button id="PlacesButton" onclick="EnablePlacesAPI();">Places API</button>
        <button id="CheckinsButton" onclick="EnableCheckinsAPI();">Checkins API</button>
     </p>
     <div id="PlacesAPI" style="display:block">
                <script type="text/javascript">
                    // Google Places types/categories can be multi-selected
                    function GetType(form) {
                        var returnTypes = null;
                        var i;
                        for (i = 0; i < form.Types.length; i++) {
                            if (form.Types[i].checked) {
                                if (null == returnTypes) {
                                    returnTypes = form.Types[i].value;
                                }
                                else {
                                    returnTypes = returnTypes + ',' + form.Types[i].value;
                                }
                            }
                        }
                        return returnTypes;
                    };
                </script>
     <h2> Places API </h2>
     <table>
        <thead>
            <tr>
            <td>Search by lat/long</td>
            <td>Details of a specific place</td>
            </tr>
        </thead>
        <tbody>
        <tr>
            <td>
                <form action="Google.aspx">
                    Lat : <input type="text" name="Latitude" value="47.607551"/> <br />
                    Long : <input type="text" name="Longitude" value="-122.117597"/> <br />
                    Radius (meters) : <input type="text" name="Radius" value="10000"/> <br />
                    
                    <input type="checkbox" name="Types" value="electrician"/> Electrician <br />
                    <input type="checkbox" name="Types" value="localservices"/> Plumber <br />
                    <input type="checkbox" name="Types" value="real_estate_agency" checked/> Realtor <br />
                    <input type="checkbox" name="Types" value="roofing_contractor"/> Roofing Contractor <br />
                    <input type="checkbox" name="Types" value="realestate"/> Real Estate <br />
                    <input type="checkbox" name="Types" value="painter"/> Painter <br />
                    <input type="checkbox" name="Types" value="locksmith"/> Locksmith<br />
                    <input type="checkbox" name="Types" value="general_contractor"/> General Contractor <br />

                    Search term : <input type="text" name="SearchTerm" value=""/> <br />
                                        
                    <input type="button" value="Search" onclick="SearchPlaces(this.form.Latitude.value, this.form.Longitude.value, this.form.Radius.value, GetType(this.form), this.form.SearchTerm.value);" />
                </form>                                 
            </td>
            <td>
                <form action="Google.aspx">
                    Place ref : <input type="text" name="Reference" value="CnRtAAAA_7ljOXtLQlU85ry7ULKJLp_83jODvXAmDtxuGZ_b2WXlg4wg1SwKYri7B4YZxO7cuZ-RyfnKtSgwHeZexeum5qWXevRRsrD-D6gjenK9IDP_WikbkPj7rCroflMVRpZm1zxtfB5bsPYc9oK2X9kQixIQu-kz-pRltecG7-vcRqMjbBoU7pYI93oFi3UnWq1ZDUhmLDR3_q0"/> <br />
                    <input type="button" value="Get Details" onclick="GetDetails(this.form.Reference.value);" />
                </form>                                 
            </td>
        </tr>
        </tbody>
     </table>
     </div>
     <div id="CheckinsAPI" style="display:none">
     <h2> Checkins/Reports API </h2>
     TODO: The Checkins API allows you to checkin to a location. The Reports API allows you to create new places.
     </div>
     <p>
     <h2>Results</h2>
     </p>
     <div id="results"></div>
    
</asp:Content>
