<%@ Page Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage" %>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <script type="text/javascript" src="../Scripts/JSONHelp.js"></script>
    <script type="text/javascript" src="http://api.maps.nokia.com/places/beta1/jsPlacesDataAPI.js"></script>
    <script type="text/javascript">


    $(function () {
    });

    function ShowResponse(JSONdata, status) {
        if (status == 'ERROR') {
            $("#results").html("Bad return status:" + status + JSONdata);
        }
        else {
            $("#results").html($.printJSONToHTML(JSONdata, 0));
        }
    };

    function SearchByTerm(lat, long, searchTerm) {
        var searchCenter = { latitude: lat, longitude: long};

        var request = {
            'searchTerm': searchTerm,
	    'searchCenter': searchCenter,
	    'onComplete': ShowResponse
        };
        nokia.places.searchManager.findPlaces(request);
    };

    function SearchByCat(lat, long, category) {
        var searchCenter = { latitude: lat, longitude: long};

        var request = {
            'category': category,
	    'searchCenter': searchCenter,
	    'onComplete': ShowResponse
        };
        nokia.places.searchManager.findPlaces(request);
    };

    function GetCategories() {
        var request = {
	    'onComplete': ShowResponse
        };
        nokia.places.searchManager.getCategories(request);
    };

    function GetDetails(placeId) {
        var request = {
            'placeId': placeId,
	    'onComplete': ShowResponse
        };
        nokia.places.placesManager.getPlaceData(request);
    };

    </script>

    <p>
        This sample shows how to access information in the Nokia Places API.        
        The developer site is <a href="http://api.maps.nokia.com/places/">here</a>.
     </p>
     <p>
     The API seems pretty early stage. They do not require registration or keys (unlike the other APIs). The functionality is similar to other sources ---- places, categories, search by location/category, details of individual places. They don't seem to have email addresses, which makes this data less interesting.
     </p>

     <div id="PlacesAPI" style="display:block">
                <script type="text/javascript">
                    function GetCat(form) {
                        var i;
                        for (i = 0; i < form.Category.length; i++) {
                            if (form.Category[i].checked) {
			        return form.Category[i].value;
                            }
                        }
                        return null;
                    };
		 </script>
     <h2> Places API </h2>
     <table>
        <thead>
            <tr>
            <td>Categories</td>
            <td>Search by lat/long and search term</td>
            <td>Search by lat/long and category</td>
            <td>Details of a specific place</td>
            </tr>
        </thead>
        <tbody>
        <tr>
            <td>
                <form action="Nokia.aspx">
                    <input type="button" value="GetCategories" onclick="GetCategories();" />
                </form>                                 
            </td>
            <td>
                <form action="Nokia.aspx">
                    Lat : <input type="text" name="Latitude" value="47.607551"/> <br />
                    Long : <input type="text" name="Longitude" value="-122.117597"/> <br />
                    
                    Search term : <input type="text" name="SearchTerm" value="Rite"/> <br />
                                        
                    <input type="button" value="Search" onclick="SearchByTerm(this.form.Latitude.value, this.form.Longitude.value, this.form.SearchTerm.value);" />
                </form>                                 
            </td>
            <td>
                <form action="Nokia.aspx">
                    Lat : <input type="text" name="Latitude" value="47.607551"/> <br />
                    Long : <input type="text" name="Longitude" value="-122.117597"/> <br />
                    
                    <input type="radio" name="Category" value="business-services"/> Business & Services <br />
                    <input type="radio" name="Category" value="transport"/> Transport <br />
                    <input type="radio" name="Category" value="eat-drink"/ checked> Eat & Drink <br />
                    <input type="radio" name="Category" value="accomodation"/> Accomodation <br />
                    <input type="radio" name="Category" value="shopping"/> Shopping <br />

                    <input type="button" value="Search" onclick="SearchByCat(this.form.Latitude.value, this.form.Longitude.value, GetCat(this.form));" />
                </form>                                 
            </td>
            <td>
                <form action="Nokia.aspx">
                    Place Id : <input type="text" name="PlaceId" value="840c23nu-d3fe98e375f94940ae7f5117cec6ed5d"/> <br />
                    <input type="button" value="Get Details" onclick="GetDetails(this.form.PlaceId.value);" />
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
